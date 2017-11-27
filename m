Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 1/2] autopair: Add more common PIN codes for audio devices
Date: Mon, 27 Nov 2017 16:26:50 +0100
Message-Id: <20171127152651.18997-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PIN codes "1111", and "1234" are fairly common PIN codes used for audio
devices such as speakers and headsets. This replaces similar quirks
already present in gnome-bluetooth's PIN database.
---
 plugins/autopair.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 6980b0a64..70e19930e 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -92,10 +92,20 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 		case 0x06:		/* Headphones */
 		case 0x07:		/* Portable Audio */
 		case 0x0a:		/* HiFi Audio Device */
-			if (attempt > 1)
-				return 0;
-			memcpy(pinbuf, "0000", 4);
-			return 4;
+			{
+				const char *pincodes[] = {
+					"0000",
+					"1234",
+					"1111"
+				};
+				const char *pincode;
+
+				if (attempt > G_N_ELEMENTS(pincodes))
+					return 0;
+				pincode = pincodes[attempt - 1];
+				memcpy(pinbuf, pincode, strlen(pincode));
+				return strlen(pincode);
+			}
 		}
 		break;
 
-- 
2.14.3

