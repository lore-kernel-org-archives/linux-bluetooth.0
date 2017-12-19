Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] lib: Introduce bt_appeartostr
Date: Tue, 19 Dec 2017 10:40:58 -0200
Message-Id: <20171219124059.4466-3-luiz.dentz@gmail.com>
In-Reply-To: <20171219124059.4466-1-luiz.dentz@gmail.com>
References: <20171219124059.4466-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_appeartostr which can decode the appearance code to a
human readable string.
---
 lib/bluetooth.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bluetooth.h |  1 +
 2 files changed, 88 insertions(+)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 3276b68a5..75d94dbfa 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -32,6 +32,7 @@
 #include <ctype.h>
 #include <stdarg.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/socket.h>
 
@@ -2343,3 +2344,89 @@ const char *bt_compidtostr(int compid)
 		return "not assigned";
 	}
 }
+
+static const struct {
+	uint16_t val;
+	bool generic;
+	const char *str;
+} appearance_table[] = {
+	{    0, true,  "Unknown"		},
+	{   64, true,  "Phone"			},
+	{  128, true,  "Computer"		},
+	{  192, true,  "Watch"			},
+	{  193, false, "Sports Watch"		},
+	{  256, true,  "Clock"			},
+	{  320, true,  "Display"		},
+	{  384, true,  "Remote Control"		},
+	{  448, true,  "Eye-glasses"		},
+	{  512, true,  "Tag"			},
+	{  576, true,  "Keyring"		},
+	{  640, true,  "Media Player"		},
+	{  704, true,  "Barcode Scanner"	},
+	{  768, true,  "Thermometer"		},
+	{  769, false, "Thermometer: Ear"	},
+	{  832, true,  "Heart Rate Sensor"	},
+	{  833, false, "Heart Rate Belt"	},
+	{  896, true,  "Blood Pressure"		},
+	{  897, false, "Blood Pressure: Arm"	},
+	{  898, false, "Blood Pressure: Wrist"	},
+	{  960, true,  "Human Interface Device"	},
+	{  961, false, "Keyboard"		},
+	{  962, false, "Mouse"			},
+	{  963, false, "Joystick"		},
+	{  964, false, "Gamepad"		},
+	{  965, false, "Digitizer Tablet"	},
+	{  966, false, "Card Reader"		},
+	{  967, false, "Digital Pen"		},
+	{  968, false, "Barcode Scanner"	},
+	{ 1024, true,  "Glucose Meter"		},
+	{ 1088, true,  "Running Walking Sensor"			},
+	{ 1089, false, "Running Walking Sensor: In-Shoe"	},
+	{ 1090, false, "Running Walking Sensor: On-Shoe"	},
+	{ 1091, false, "Running Walking Sensor: On-Hip"		},
+	{ 1152, true,  "Cycling"				},
+	{ 1153, false, "Cycling: Cycling Computer"		},
+	{ 1154, false, "Cycling: Speed Sensor"			},
+	{ 1155, false, "Cycling: Cadence Sensor"		},
+	{ 1156, false, "Cycling: Power Sensor"			},
+	{ 1157, false, "Cycling: Speed and Cadence Sensor"	},
+	{ 1216, true,  "Undefined"				},
+
+	{ 3136, true,  "Pulse Oximeter"				},
+	{ 3137, false, "Pulse Oximeter: Fingertip"		},
+	{ 3138, false, "Pulse Oximeter: Wrist Worn"		},
+	{ 3200, true,  "Weight Scale"				},
+	{ 3264, true,  "Undefined"				},
+
+	{ 5184, true,  "Outdoor Sports Activity"		},
+	{ 5185, false, "Location Display Device"		},
+	{ 5186, false, "Location and Navigation Display Device"	},
+	{ 5187, false, "Location Pod"				},
+	{ 5188, false, "Location and Navigation Pod"		},
+	{ 5248, true,  "Undefined"				},
+	{ }
+};
+
+const char *bt_appeartostr(uint16_t appearance)
+{
+	const char *str = NULL;
+	int i, type = 0;
+
+	for (i = 0; appearance_table[i].str; i++) {
+		if (appearance_table[i].generic) {
+			if (appearance < appearance_table[i].val)
+				break;
+			type = i;
+		}
+
+		if (appearance_table[i].val == appearance) {
+			str = appearance_table[i].str;
+			break;
+		}
+	}
+
+	if (!str)
+		str = appearance_table[type].str;
+
+	return str;
+}
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index eb279260e..23d048cf6 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -339,6 +339,7 @@ void bt_free(void *ptr);
 
 int bt_error(uint16_t code);
 const char *bt_compidtostr(int id);
+const char *bt_appeartostr(uint16_t appearance);
 
 typedef struct {
 	uint8_t data[16];
-- 
2.13.6

