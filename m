Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v2 8/8] autopair: Try a fixed pincode for keyboards rejecting random codes
Date: Fri, 12 Apr 2013 16:28:38 -0700
Message-Id: <1365809318-17775-9-git-send-email-deymo@chromium.org>
In-Reply-To: <1365809318-17775-1-git-send-email-deymo@chromium.org>
References: <1365809318-17775-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes the autopair plugin try a fixed "0000" pincode for
keyboards that reject the pincode too fast (less than 500ms). This
too short delay rejecting the pincode means that the user didn't
have time to type the random pincode in the bluetooth keyboard and
was the keyboard who actually rejected it.
---
 plugins/autopair.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 0f0d123..fcf117a 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -87,8 +87,23 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 		switch ((class & 0xc0) >> 6) {
 		case 0x01:		/* Keyboard */
 		case 0x03:		/* Combo keyboard/pointing device */
-			if (attempt > 1)
+			/* For keyboards rejecting the first random code in less
+			 * than 500ms, try a fixed code. */
+			if (attempt > 1 &&
+				device_bonding_last_duration(device) < 500) {
+				/* Don't try more than one dumb code */
+				if (attempt > 2)
+					return 0;
+				/* Try "0000" as the code for the second
+				 * attempt. */
+				memcpy(pinbuf, "0000", 4);
+				return 4;
+			}
+
+			/* Never try more than 3 random pincodes. */
+			if (attempt >= 4)
 				return 0;
+
 			snprintf(pinstr, sizeof pinstr, "%06d",
 						rand() % 1000000);
 			*display = TRUE;
-- 
1.8.1.3
