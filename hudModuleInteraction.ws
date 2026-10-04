if ( _interactionEntity )
			{
				key  = _interactionEntityComponent.GetInteractionKey();
				actionName = _interactionEntityComponent.GetInputActionName();
				actionText = _interactionEntityComponent.GetInteractionFriendlyName();

				theInput.GetPCKeysForAction( actionName, keys );
				if ( keys.Size() )
				{
					key2 = (int)keys[ 0 ];
				}
				
				
				//---=== modFriendlyHUD ===---
				showInteractionIcon = GetFHUDConfig().ShowInteractionIcon(_interactionEntityComponent.GetActionName());
				showInteractionText = GetFHUDConfig().ShowInteractionText(_interactionEntityComponent.GetActionName());
				if ( actionName == 'Finish' && theInput.LastUsedPCInput() )
				{
					showInteractionIcon = false;
				}

				// CHILL OUT MOD INTEGRATION
				if (((CO_Interactor) _interactionEntity)) 
				{
					m_fxSetInteractionKeyIconAndTextSFF.InvokeSelfFourArgs( FlashArgInt( key ), FlashArgInt( key2 ), FlashArgString( actionName ), FlashArgString( ((CO_Interactor) _interactionEntity).GetInteractionText() ) ); 
					m_fxSetVisibilityExSFF.InvokeSelfFiveArgs( FlashArgBool( true ), FlashArgBool( false ), FlashArgBool( true ), FlashArgBool( true ), FlashArgBool( true ) );
				}
				else 
				{
					// Standard-Verhalten mit Friendly HUD Steuerung
					m_fxSetInteractionKeyIconAndTextSFF.InvokeSelfFourArgs( FlashArgInt( key ), FlashArgInt( key2 ), FlashArgString( actionName ), FlashArgString( GetLocStringByKeyExt( actionText ) ) );
					m_fxSetVisibilityExSFF.InvokeSelfFiveArgs( FlashArgBool( showInteractionIcon ), FlashArgBool( false ), FlashArgBool( showInteractionText ), FlashArgBool( showInteractionIcon ), FlashArgBool( showInteractionText ) );
				}		
				isIconVisible = showInteractionIcon;
				//---=== modFriendlyHUD ===---
				
			}
