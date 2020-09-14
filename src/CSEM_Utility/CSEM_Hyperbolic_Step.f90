!
! Hyperbolic step functions for differentiable replacement of IF statements
!
!
! CREATION HISTORY:
!       Written by:     Paul van Delst, 09-Nov-2010
!                       paul.vandelst@noaa.gov
!

MODULE CSEM_Hyperbolic_Step

  ! -----------------
  ! Environment setup
  ! -----------------
  ! Module use
  USE CSEM_Type_Kinds, ONLY: fp => CSEM_fp
  ! Disable implicit typing
  IMPLICIT NONE


  ! ------------
  ! Visibilities
  ! ------------
  PRIVATE
  PUBLIC :: Hyperboic_Step
  PUBLIC :: Hyperboic_Step_TL
  PUBLIC :: Hyperboic_Step_AD


  ! -----------------
  ! Module parameters
  ! -----------------
  CHARACTER(*), PARAMETER :: MODULE_VERSION_ID = &
  '$Id: Hyperbolic_Step.f90 21141 2012-09-14 17:40:43Z paul.vandelst@noaa.gov $'
  ! Literals
  REAL(fp), PARAMETER :: ZERO   = 0.0_fp
  REAL(fp), PARAMETER :: POINT5 = 0.5_fp
  REAL(fp), PARAMETER :: ONE    = 1.0_fp
  ! X-input maximum value
  REAL(fp), PARAMETER :: XCUTOFF = 70.0_fp

CONTAINS


!--------------------------------------------------------------------------------
!:sdoc+:
!
! NAME:
!       Hyperboic_Step
!
! PURPOSE:
!       Subroutine to compute a hyperbolic, differentiable, step function:
!
!         g(x) = 0.5(1 + TANH(x))
!
!       NOTE: No input checking of the validity of the x-argument for use
!             with TANH() is done.
!
! CALLING SEQUENCE:
!       CALL Hyperboic_Step( x, g )
!                             
!
! INPUTS:
!       x:      The function abscissa.
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(IN)
!
! OUTPUTS:
!       g:      The hyperbolic step function value.
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(OUT)
!
!:sdoc-:
!--------------------------------------------------------------------------------

  SUBROUTINE Hyperboic_Step( x, g )
    REAL(fp), INTENT(IN)  :: x
    REAL(fp), INTENT(OUT) :: g
    g = POINT5 * ( ONE + TANH(x) )
  END SUBROUTINE Hyperboic_Step


!--------------------------------------------------------------------------------
!:sdoc+:
!
! NAME:
!       Hyperboic_Step_TL
!
! PURPOSE:
!       Subroutine to compute the tangent-linear form of a hyperbolic,
!       differentiable, step function:
!
!         g(x) = 0.5(1 + TANH(x))
!
!       NOTE: Computations are only performed for input |x| < 70 to avoid
!             infinite result for COSH().
!
! CALLING SEQUENCE:
!       CALL Hyperboic_Step_TL( x, x_TL, g_TL )
!                             
!
! INPUTS:
!       x:      The function abscissa.
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(IN)
!
!       x_TL:   The tangent-linear abscissa.
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(IN)
!
! OUTPUTS:
!       g_TL:   The tangent-linear hyperbolic step function value.
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(OUT)
!
!:sdoc-:
!--------------------------------------------------------------------------------

  SUBROUTINE Hyperboic_Step_TL( x, x_TL, g_TL )
    REAL(fp), INTENT(IN)  :: x, x_TL
    REAL(fp), INTENT(OUT) :: g_TL
    IF ( ABS(x) < XCUTOFF ) THEN
      g_TL = POINT5 * x_TL / COSH(x)**2
    ELSE
      g_TL = ZERO
    END IF
  END SUBROUTINE Hyperboic_Step_TL


!--------------------------------------------------------------------------------
!:sdoc+:
!
! NAME:
!       Hyperboic_Step_AD
!
! PURPOSE:
!       Subroutine to compute the adjoint of a hyperbolic, differentiable,
!       step function:
!
!         g(x) = 0.5(1 + TANH(x))
!
!       NOTE: Computations are only performed for input |x| < 70 to avoid
!             infinite result for COSH().
!
! CALLING SEQUENCE:
!       CALL Hyperboic_Step_AD( x, g_AD, x_AD )
!                             
!
! INPUTS:
!       x:      The function abscissa.
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(IN)
!
!       g_AD:   The adjoint hyperbolic step function value.
!               NOTE: *** SET TO ZERO UPON EXIT ***
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(IN OUT)
!
! OUTPUTS:
!       x_AD:   The adjoint abscissa.
!               NOTE: *** MUST CONTAIN VALUE UPON ENTRY ***
!               UNITS:      N/A
!               TYPE:       REAL(fp)
!               DIMENSION:  Scalar
!               ATTRIBUTES: INTENT(IN OUT)
!
!:sdoc-:
!--------------------------------------------------------------------------------

  SUBROUTINE Hyperboic_Step_AD( x, g_AD, x_AD )
    REAL(fp), INTENT(IN)     :: x
    REAL(fp), INTENT(IN OUT) :: g_AD  ! AD Input
    REAL(fp), INTENT(IN OUT) :: x_AD  ! AD Output
    IF ( ABS(x) < XCUTOFF ) THEN
      x_AD = x_AD + POINT5 * g_AD / COSH(x)**2
    END IF
    g_AD = ZERO
  END SUBROUTINE Hyperboic_Step_AD

END MODULE CSEM_Hyperbolic_Step