event OnSpawned( spawnData : SEntitySpawnData )
	{
		var i 				: int;
		var items 			: array<SItemUniqueId>;
		var items2 			: array<SItemUniqueId>;
		var horseTemplate 	: CEntityTemplate;
		var horseManager 	: W3HorseManager;
		
		// --- MOD-GEAR START ---
		var armorIds  : array<SItemUniqueId>;
		// --- MOD-GEAR END ---
		
	  AddAnimEventCallback('ActionBlend','OnAnimEvent_ActionBlend');
		AddAnimEventCallback('cast_begin','OnAnimEvent_Sign');
		AddAnimEventCallback('cast_throw','OnAnimEvent_Sign');
		AddAnimEventCallback('cast_end','OnAnimEvent_Sign');
		AddAnimEventCallback('cast_friendly_begin','OnAnimEvent_Sign');
		AddAnimEventCallback('cast_friendly_throw','OnAnimEvent_Sign');
		AddAnimEventCallback('axii_ready','OnAnimEvent_Sign');
		AddAnimEventCallback('axii_alternate_ready','OnAnimEvent_Sign');
		AddAnimEventCallback('yrden_draw_ready','OnAnimEvent_Sign');
		AddAnimEventCallback( 'ProjectileThrow','OnAnimEvent_Throwable');
		AddAnimEventCallback( 'OnWeaponReload','OnAnimEvent_Throwable');
		AddAnimEventCallback( 'ProjectileAttach','OnAnimEvent_Throwable');
		AddAnimEventCallback( 'Mutation11AnimEnd','OnAnimEvent_Mutation11AnimEnd');
		AddAnimEventCallback( 'Mutation11ShockWave','OnAnimEvent_Mutation11ShockWave');

		if(!spawnData.restored)
		{
			levelManager = new W3LevelManager in this;			
			levelManager.Initialize();
			
			// --- MOD-GEAR START---		
			// Läuft bei JEDEM Laden (auch alte Spielstände), aber dank des Facts NUR EINMAL pro Savegame!
			// 1. Löscht die Kaer-Morhen-Hose sofort aus der Generierung
			items2 = inv.GetItemsByName('Starting Armor');
			for(i=0; i<items2.Size(); i+=1)
			{
				inv.RemoveItem(items2[i]);
			}	
			// 2. Erzeugt die Cavil Pants und den Rest der Rüstung im Inventar
			armorIds  = inv.AddAnItem('Geralt Kontusz R', 1);
		
			inv.AddAnItem('blavikenarmor', 1);
			inv.AddAnItem('Oathbreaker armor', 1);
			
			// 3. Rüstet die Cavil Pants im nun leeren Slot direkt aus
			if ( armorIds.Size() > 0 )
			{
				EquipItem( pantsIds[0] );
			}
			// --- MOD-GEAR END ---
			
			inv.GetAllItems(items);
			for(i=0; i<items.Size(); i+=1)
			{
				if(inv.IsItemMounted(items[i]) && ( !inv.IsItemBody(items[i]) || inv.GetItemCategory(items[i]) == 'hair' ) )
					EquipItem(items[i]);
			}
			
			AddAlchemyRecipe('Recipe for Swallow 1',true,true);
			AddAlchemyRecipe('Recipe for Cat 1',true,true);
			AddAlchemyRecipe('Recipe for White Honey 1',true,true);
			
			AddAlchemyRecipe('Recipe for Samum 1',true,true);
			AddAlchemyRecipe('Recipe for Grapeshot 1',true,true);
			
			AddAlchemyRecipe('Recipe for Specter Oil 1',true,true);
			AddAlchemyRecipe('Recipe for Necrophage Oil 1',true,true);
			AddAlchemyRecipe('Recipe for Alcohest 1',true,true);
		}
