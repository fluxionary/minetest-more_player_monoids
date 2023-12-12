# more_player_monoids

more monoids to prevent other mobs from clobbering each other when modifying player attributes.

## API

| monoid name       | description                                                        | identity | composition    |
|-------------------|--------------------------------------------------------------------|----------|----------------|
| sneak             | a player can sneak                                                 | true     | nothing false  |
| sneak_glitch      | a player can use the sneak glitch                                  | false    | anything true  |
| new_move          | new movement is enabled                                            | true     | nothing false  |
| hud_hotbar        | the hotbar is visible                                              | true     | nothing false  |
| hud_healthbar     | the healthbar is visible                                           | true     | nothing false  |
| hud_crosshair     | the reticule is visible                                            | true     | nothing false  |
| hud_wielditem     | the player's hand/item is visible                                  | true     | nothing false  |
| hud_breathbar     | the player's breath is visible when not full                       | true     | nothing false  |
| hud_minimap       | the minimap can be used                                            | false    | anything true  |
| hud_minimap_radar | the player can use the radar minimap                               | false    | anything true  |
| hud_basic_debug   | the player can see basic debug info                                | false    | anything true  |
| hud_chat          | the player can see chat in the HUD                                 | true     | nothing false  |
| saturation        | lighting saturation multiplier                                     | 1        | multiplicative |
| day_night_ratio   | controls how lighting appears                                      | nil      | additive       |
| player_attached   | if true, animations will not be updated and knockback is prevented | false    | anything true  |
