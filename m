Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/7] Bluetooth: Add support for pairing via mgmt over LE
Date: Fri, 19 Aug 2011 21:06:54 -0300
Message-Id: <1313798816-8647-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using the advertising cache we are able to infer the type
of the remote device, and so trigger pairing over the correct
link type.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 53e109e..1ce8d80 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1347,6 +1347,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	struct hci_dev *hdev;
 	struct mgmt_cp_pair_device *cp;
 	struct pending_cmd *cmd;
+	struct adv_entry *entry;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
 	int err;
@@ -1372,7 +1373,14 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 	}
 
-	conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level, auth_type);
+	entry = hci_find_adv_entry(hdev, &cp->bdaddr);
+	if (entry)
+		conn = hci_connect(hdev, LE_LINK, &cp->bdaddr, sec_level,
+								auth_type);
+	else
+		conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level,
+								auth_type);
+
 	if (IS_ERR(conn)) {
 		err = PTR_ERR(conn);
 		goto unlock;
@@ -1391,7 +1399,10 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto unlock;
 	}
 
-	conn->connect_cfm_cb = pairing_complete_cb;
+	/* For LE, just connecting isn't a proof that the pairing finished */
+	if (!entry)
+		conn->connect_cfm_cb = pairing_complete_cb;
+
 	conn->security_cfm_cb = pairing_complete_cb;
 	conn->disconn_cfm_cb = pairing_complete_cb;
 	conn->io_capability = cp->io_cap;
-- 
1.7.6

