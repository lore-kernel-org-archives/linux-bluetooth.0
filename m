Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 5/9] Fix using "magic" values for key types
Date: Wed,  6 Jul 2011 17:10:37 -0300
Message-Id: <1309983041-23744-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
References: <y>
 <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have macros for the different type of keys we should
use them to make the code clearer.
---
 plugins/hciops.c |   10 ++++++----
 src/event.c      |   19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 3daccac..207e187 100644
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
+					&& old_key_type != 0xff) ||
 			(conn->loc_auth > 0x01 && conn->rem_auth > 0x01) ||
 			(conn->loc_auth == 0x02 || conn->loc_auth == 0x03) ||
 			(conn->rem_auth == 0x02 || conn->rem_auth == 0x03)) {
diff --git a/src/event.c b/src/event.c
index 9cdb5e1..2d7958b 100644
--- a/src/event.c
+++ b/src/event.c
@@ -444,11 +444,24 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 
 	DBG("storing link key of type 0x%02x", key_type);
 
-	if (key_type & 0x10)
+	switch (key_type) {
+	case HCI_LK_COMBINATION:
+	case HCI_LK_LOCAL_UNIT:
+	case HCI_LK_REMOTE_UNIT:
+	case HCI_LK_DEBUG_COMBINATION:
+	case HCI_LK_UNAUTH_COMBINATION:
+	case HCI_LK_AUTH_COMBINATION:
+	case HCI_LK_CHANGED_COMBINATION:
+		ret = write_link_key(local, peer, key, key_type, pin_length);
+		break;
+	case HCI_LK_SMP_LTK:
 		ret = store_longtermkey(local, peer, key, key_type, pin_length,
 								dlen, data);
-	else
-		ret = write_link_key(local, peer, key, key_type, pin_length);
+		break;
+	default:
+		ret = -ENOTSUP;
+		break;
+	}
 
 	if (ret == 0 && device_is_temporary(device))
 		device_set_temporary(device, FALSE);
-- 
1.7.6

