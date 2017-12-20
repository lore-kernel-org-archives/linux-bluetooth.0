Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] shared/util: Introduce bt_appear_to_str
Date: Wed, 20 Dec 2017 10:17:50 -0200
Message-Id: <20171220121751.8238-3-luiz.dentz@gmail.com>
In-Reply-To: <20171220121751.8238-1-luiz.dentz@gmail.com>
References: <20171220121751.8238-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_appear_to_str which can decode the appearance code to a
human readable string.
---
 lib/bluetooth.c   |  1 +
 src/shared/util.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  1 +
 3 files changed, 89 insertions(+)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 3276b68a5..effc7f49d 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -32,6 +32,7 @@
 #include <ctype.h>
 #include <stdarg.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/socket.h>
 
diff --git a/src/shared/util.c b/src/shared/util.c
index 2559963db..f6f265e56 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -893,3 +894,89 @@ const char *bt_uuidstr_to_str(const char *uuid)
 
 	return bt_uuid32_to_str(val);
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
+const char *bt_appear_to_str(uint16_t appearance)
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
diff --git a/src/shared/util.h b/src/shared/util.h
index 1edf26705..3f5f6dfb5 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -111,6 +111,7 @@ void util_clear_uid(unsigned int *bitmap, uint8_t id);
 const char *bt_uuid16_to_str(uint16_t uuid);
 const char *bt_uuid32_to_str(uint32_t uuid);
 const char *bt_uuidstr_to_str(const char *uuid);
+const char *bt_appear_to_str(uint16_t appearance);
 
 static inline int8_t get_s8(const void *ptr)
 {
-- 
2.13.6

