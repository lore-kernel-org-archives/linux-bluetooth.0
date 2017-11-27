Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 2/2] autopair: Add pin codes to try for gaming input devices
Date: Mon, 27 Nov 2017 16:26:51 +0100
Message-Id: <20171127152651.18997-2-hadess@hadess.net>
In-Reply-To: <20171127152651.18997-1-hadess@hadess.net>
References: <20171127152651.18997-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As well as remote controls.
---
 plugins/autopair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 70e19930e..043bd9b9d 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -111,6 +111,18 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 
 	case 0x05:		/* Peripheral */
 		switch ((class & 0xc0) >> 6) {
+		case 0x00:
+			switch ((class & 0x1e) >> 2) {
+			case 0x01:	/* Joystick */
+			case 0x02:	/* Gamepad */
+			case 0x03:	/* Remote Control */
+				if (attempt > 1)
+					return 0;
+				memcpy(pinbuf, "0000", 4);
+				return 4;
+			}
+
+			break;
 		case 0x01:		/* Keyboard */
 		case 0x03:		/* Combo keyboard/pointing device */
 			/* For keyboards rejecting the first random code
-- 
2.14.3

