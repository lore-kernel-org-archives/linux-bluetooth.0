Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Advertise telephony service class for handsfree AG role, for Nokia 616 support.
Date: Tue, 23 Sep 2008 11:19:44 -0700
Message-Id: <1222193984-27820-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Nokia 616 incorrectly requires the telehony bit to be set to make a
handsfree connection.
---
 src/sdpd-service.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 30aad32..f138d22 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -121,6 +121,13 @@ static void update_svclass_list(void)
 		case HANDSFREE_SVCLASS_ID:
 			val |= 0x20;	/* Audio */
 			break;
+		/* For Nokia 616 carkit compatability - it incorrectly requires
+		 * the telephony bit set for handsfree usage, despite this not
+		 * being a requirement of the handsfree spec.
+		 */
+		case HANDSFREE_SVCLASS_ID:
+			val |= 0x40;    /* Telephony */
+			break;
 		case CORDLESS_TELEPHONY_SVCLASS_ID:
 		case INTERCOM_SVCLASS_ID:
 		case FAX_SVCLASS_ID:
-- 
1.5.5

