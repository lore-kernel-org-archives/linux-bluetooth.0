Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] monitor: Use bt_appeartostr
Date: Tue, 19 Dec 2017 10:40:59 -0200
Message-Id: <20171219124059.4466-4-luiz.dentz@gmail.com>
In-Reply-To: <20171219124059.4466-1-luiz.dentz@gmail.com>
References: <20171219124059.4466-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Remove appearance table used to decode appearance.
---
 monitor/packet.c | 84 ++------------------------------------------------------
 1 file changed, 2 insertions(+), 82 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index a9f2ab5f2..0e1e41f49 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1081,90 +1081,10 @@ static void print_dev_class(const uint8_t *dev_class)
 				"  Unknown service class (0x%2.2x)", mask);
 }
 
-static const struct {
-	uint16_t val;
-	bool generic;
-	const char *str;
-} appearance_table[] = {
-	{    0, true,  "Unknown"		},
-	{   64, true,  "Phone"			},
-	{  128, true,  "Computer"		},
-	{  192, true,  "Watch"			},
-	{  193, false, "Sports Watch"		},
-	{  256, true,  "Clock"			},
-	{  320, true,  "Display"		},
-	{  384, true,  "Remote Control"		},
-	{  448, true,  "Eye-glasses"		},
-	{  512, true,  "Tag"			},
-	{  576, true,  "Keyring"		},
-	{  640, true,  "Media Player"		},
-	{  704, true,  "Barcode Scanner"	},
-	{  768, true,  "Thermometer"		},
-	{  769, false, "Thermometer: Ear"	},
-	{  832, true,  "Heart Rate Sensor"	},
-	{  833, false, "Heart Rate Belt"	},
-	{  896, true,  "Blood Pressure"		},
-	{  897, false, "Blood Pressure: Arm"	},
-	{  898, false, "Blood Pressure: Wrist"	},
-	{  960, true,  "Human Interface Device"	},
-	{  961, false, "Keyboard"		},
-	{  962, false, "Mouse"			},
-	{  963, false, "Joystick"		},
-	{  964, false, "Gamepad"		},
-	{  965, false, "Digitizer Tablet"	},
-	{  966, false, "Card Reader"		},
-	{  967, false, "Digital Pen"		},
-	{  968, false, "Barcode Scanner"	},
-	{ 1024, true,  "Glucose Meter"		},
-	{ 1088, true,  "Running Walking Sensor"			},
-	{ 1089, false, "Running Walking Sensor: In-Shoe"	},
-	{ 1090, false, "Running Walking Sensor: On-Shoe"	},
-	{ 1091, false, "Running Walking Sensor: On-Hip"		},
-	{ 1152, true,  "Cycling"				},
-	{ 1153, false, "Cycling: Cycling Computer"		},
-	{ 1154, false, "Cycling: Speed Sensor"			},
-	{ 1155, false, "Cycling: Cadence Sensor"		},
-	{ 1156, false, "Cycling: Power Sensor"			},
-	{ 1157, false, "Cycling: Speed and Cadence Sensor"	},
-	{ 1216, true,  "Undefined"				},
-
-	{ 3136, true,  "Pulse Oximeter"				},
-	{ 3137, false, "Pulse Oximeter: Fingertip"		},
-	{ 3138, false, "Pulse Oximeter: Wrist Worn"		},
-	{ 3200, true,  "Weight Scale"				},
-	{ 3264, true,  "Undefined"				},
-
-	{ 5184, true,  "Outdoor Sports Activity"		},
-	{ 5185, false, "Location Display Device"		},
-	{ 5186, false, "Location and Navigation Display Device"	},
-	{ 5187, false, "Location Pod"				},
-	{ 5188, false, "Location and Navigation Pod"		},
-	{ 5248, true,  "Undefined"				},
-	{ }
-};
-
 static void print_appearance(uint16_t appearance)
 {
-	const char *str = NULL;
-	int i, type = 0;
-
-	for (i = 0; appearance_table[i].str; i++) {
-		if (appearance_table[i].generic) {
-			if (appearance < appearance_table[i].val)
-				break;
-			type = i;
-		}
-
-		if (appearance_table[i].val == appearance) {
-			str = appearance_table[i].str;
-			break;
-		}
-	}
-
-	if (!str)
-		str = appearance_table[type].str;
-
-	print_field("Appearance: %s (0x%4.4x)", str, appearance);
+	print_field("Appearance: %s (0x%4.4x)", bt_appeartostr(appearance),
+								appearance);
 }
 
 static void print_num_broadcast_retrans(uint8_t num_retrans)
-- 
2.13.6

