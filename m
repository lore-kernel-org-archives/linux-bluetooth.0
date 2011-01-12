Return-Path: <cyrus@holtmann.org>
From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        padovan@profusion.mobi
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH] Bluetooth: Check authorization when sec_level goes high.
Date: Wed, 12 Jan 2011 14:08:31 +0200
Message-Id: <1294834111-29658-1-git-send-email-matti.j.aaltonen@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Initiate authorization check also in cases where the
security level of an existing connection changes to
BT_SECURITY_HIGH.

This patch fixes a bug which makes commands bluez-test-device and
bluez-simple-agent fail, if the latter is given before the connection
created by bluez-test-device has expired.

Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
---
 net/bluetooth/hci_conn.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b1e460..5df232b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -380,8 +380,19 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		acl->auth_type = auth_type;
 		hci_acl_connect(acl);
 	} else {
-		if (acl->sec_level < sec_level)
+		if (acl->sec_level < sec_level) {
 			acl->sec_level = sec_level;
+			if (acl->sec_level == BT_SECURITY_HIGH) {
+				struct hci_cp_auth_requested ar;
+
+				acl->state = BT_CONFIG;
+				memset(&ar, 0, sizeof(ar));
+				ar.handle = cpu_to_le16(acl->handle);
+				hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED,
+					     sizeof(ar), &ar);
+			}
+		}
+
 		if (acl->auth_type < auth_type)
 			acl->auth_type = auth_type;
 	}
-- 
1.6.1.3
