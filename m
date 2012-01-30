Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/8] Bluetooth: Add support for removing LTK's when pairing is removed
Date: Mon, 30 Jan 2012 19:29:16 -0300
Message-Id: <1327962558-25720-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of having a separated command for removing SMP keys, we use the
Remove Keys command to remove *all* keys.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9e415dc..b61de08 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -665,6 +665,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 addr_type);
+int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_smp_ltks_clear(struct hci_dev *hdev);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 57aa716..57bee59 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1113,6 +1113,12 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 	bacpy(&rp.bdaddr, &cp->bdaddr);
 	rp.status = MGMT_STATUS_FAILED;
 
+	err = hci_remove_ltk(hdev, &cp->bdaddr);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, -err);
+		goto unlock;
+	}
+
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
 		rp.status = MGMT_STATUS_NOT_PAIRED;
-- 
1.7.8.1

