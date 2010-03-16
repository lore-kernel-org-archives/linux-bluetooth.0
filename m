Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Mar 2010 14:33:13 +0200
Message-ID: <2c3916b71003160533s714e9ef3h6c803f88a79f27d2@mail.gmail.com>
Subject: [PATCH] Fix display of last device classes in hciconfig
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is my first ever patch, so it's very simple...
Based on current content in:
http://www.bluetooth.org/assigned-numbers/baseband.htm

Signed-off-by: Daniel Abraham <daniel.shrugged@gmail.com>
---
 tools/hciconfig.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 3f687e0..c97ce44 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -645,8 +645,26 @@ static char *get_minor_device_name(int major, int minor)
 			return "Game";
 		}
 		break;
-	case 63:	/* uncategorised */
-		return "";
+	case 9: /* health */
+		switch(minor) {
+		case 0:
+			return "Undefined";
+		case 1:
+			return "Blood Pressure Monitor";
+		case 2:
+			return "Thermometer";
+		case 3:
+			return "Weighing Scale";
+		case 4:
+			return "Glucose Meter";
+		case 5:
+			return "Pulse Oximeter";
+		case 6:
+			return "Heart/Pulse Rate Monitor";
+		case 7:
+			return "Health Data Display";
+		}
+		break;
 	}
 	return "Unknown (reserved) minor device class";
 }
@@ -668,7 +686,9 @@ static void cmd_class(int ctl, int hdev, char *opt)
 					"Audio/Video",
 					"Peripheral",
 					"Imaging",
-					"Uncategorized" };
+					"Wearable",
+					"Toy",
+					"Health" };
 	int s = hci_open_dev(hdev);

 	if (s < 0) {
@@ -706,7 +726,9 @@ static void cmd_class(int ctl, int hdev, char *opt)
 		} else
 			printf("Unspecified");
 		printf("\n\tDevice Class: ");
-		if ((cls[1] & 0x1f) >= sizeof(major_devices) / sizeof(*major_devices))
+		if (0x1f == cls[1])
+			printf("Uncategorized\n");
+		else if ((cls[1] & 0x1f) >= sizeof(major_devices) / sizeof(*major_devices))
 			printf("Invalid Device Class!\n");
 		else
 			printf("%s, %s\n", major_devices[cls[1] & 0x1f],
-- 
1.6.6.1
