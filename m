Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1] Bluetooth: fix MGMT_EV_NEW_LONG_TERM_KEY event
Date: Wed,  5 Aug 2015 23:16:29 +0200
Message-Id: <1438809389-4230-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes how MGMT_EV_NEW_LONG_TERM_KEY event is build. Right now
val vield is filled with only 1 byte, instead of whole value. This bug
was introduced in
commit 1fc62c526a57 ("Bluetooth: Fix exposing full value of shortened LTKs")

Before that patch, if you paired with device using bluetoothd using simple
pairing, and then restarted bluetoothd, you would be able to re-connect,
but device would fail to establish encryption and would terminate
connection. After this patch connecting after bluetoothd restart works
fine.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7ab1915..e435438 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7843,7 +7843,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	/* Make sure we copy only the significant bytes based on the
 	 * encryption key size, and set the rest of the value to zeroes.
 	 */
-	memcpy(ev.key.val, key->val, sizeof(key->enc_size));
+	memcpy(ev.key.val, key->val, key->enc_size);
 	memset(ev.key.val + key->enc_size, 0,
 	       sizeof(ev.key.val) - key->enc_size);
 
-- 
2.1.4

