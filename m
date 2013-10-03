Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Restrict loading of link keys to BR/EDR capable controllers
Date: Wed,  2 Oct 2013 21:16:07 -0700
Message-Id: <1380773768-12958-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Loading link keys into a LE only controller make no sense. The kernel
would never use any of these keys. So instead of allowing userspace
to waste memory, reject such operation with a not supported error
message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3b3ed05..273ea8f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1821,6 +1821,12 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	u16 key_count, expected_len;
 	int i;
 
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
 	key_count = __le16_to_cpu(cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count *
-- 
1.8.3.1

