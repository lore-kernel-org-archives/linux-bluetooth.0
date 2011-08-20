Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 04/12] Fix using "magic" values for the key types
Date: Fri, 19 Aug 2011 21:12:00 -0300
Message-Id: <1313799128-8842-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecc0e86..43f4f02 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -955,12 +955,12 @@ static void link_key_notify(int index, void *ptr)
 	DBG("local auth 0x%02x and remote auth 0x%02x",
 					conn->loc_auth, conn->rem_auth);
 
-	if (key_type == 0x06) {
+	if (key_type == HCI_LK_CHANGED_COMBINATION) {
 		/* Some buggy controller combinations generate a changed
 		 * combination key for legacy pairing even when there's no
 		 * previous key */
 		if (conn->rem_auth == 0xff && old_key_type == 0xff)
-			key_type = 0x00;
+			key_type = HCI_LK_COMBINATION;
 		else if (old_key_type != 0xff)
 			key_type = old_key_type;
 		else
@@ -972,7 +972,7 @@ static void link_key_notify(int index, void *ptr)
 	key_info->type = key_type;
 
 	/* Skip the storage check if this is a debug key */
-	if (key_type == 0x03)
+	if (key_type == HCI_LK_DEBUG_COMBINATION)
 		goto done;
 
 	/* Store the link key persistently if one of the following is true:
@@ -986,7 +986,9 @@ static void link_key_notify(int index, void *ptr)
 	 * If none of the above match only keep the link key around for
 	 * this connection and set the temporary flag for the device.
 	 */
-	if (key_type < 0x03 || (key_type == 0x06 && old_key_type != 0xff) ||
+	if (key_type < HCI_LK_DEBUG_COMBINATION ||
+			(key_type == HCI_LK_CHANGED_COMBINATION
+					&& old_key_type != HCI_LK_INVALID) ||
 			(conn->loc_auth > 0x01 && conn->rem_auth > 0x01) ||
 			(conn->loc_auth == 0x02 || conn->loc_auth == 0x03) ||
 			(conn->rem_auth == 0x02 || conn->rem_auth == 0x03)) {
-- 
1.7.6

