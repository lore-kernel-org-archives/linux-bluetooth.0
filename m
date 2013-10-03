Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Restrict loading of long term keys to LE capable controllers
Date: Wed,  2 Oct 2013 21:16:08 -0700
Message-Id: <1380773768-12958-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Loading long term keys into a BR/EDR only controller make no sense.
The kernel would never use any of these keys. So instead of allowing
userspace to waste memory, reject such operation with a not supported
error message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 273ea8f..03fca4c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3551,6 +3551,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	u16 key_count, expected_len;
 	int i, err;
 
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
 	key_count = __le16_to_cpu(cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count *
-- 
1.8.3.1

