Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Fix adding missing breaks
Date: Thu, 12 Jun 2014 17:22:18 +0300
Message-Id: <1402582938-8476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 1de313b..32f6ff6 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -571,18 +571,22 @@ static bool check_value(uint8_t attr, uint8_t number, const uint8_t *values)
 			if (values[i] < AVRCP_EQUALIZER_OFF ||
 						values[i] > AVRCP_EQUALIZER_ON)
 				return false;
+			break;
 		case AVRCP_ATTRIBUTE_REPEAT_MODE:
 			if (values[i] < AVRCP_REPEAT_MODE_OFF ||
 					values[i] > AVRCP_REPEAT_MODE_GROUP)
 				return false;
+			break;
 		case AVRCP_ATTRIBUTE_SHUFFLE:
 			if (values[i] < AVRCP_SHUFFLE_OFF ||
 					values[i] > AVRCP_SHUFFLE_GROUP)
 				return false;
+			break;
 		case AVRCP_ATTRIBUTE_SCAN:
 			if (values[i] < AVRCP_SCAN_OFF ||
 					values[i] > AVRCP_SCAN_GROUP)
 				return false;
+			break;
 		}
 	}
 
-- 
1.8.3.2

