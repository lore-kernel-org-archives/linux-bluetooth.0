Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/15] Bluetooth: Add initial code for distributing local IRK
Date: Sat, 22 Feb 2014 19:06:32 +0200
Message-Id: <1393088805-28658-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This code adds a HCI_PRIVACY flag to track whether Privacy support is
enabled (meaning we have a local IRK) and makes sure the IRK is
distributed during SMP key distribution in case this flag is set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      | 1 +
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/smp.c              | 6 ++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe4b06bfc150..5ff885ff29df 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -126,6 +126,7 @@ enum {
 	HCI_SSP_ENABLED,
 	HCI_SC_ENABLED,
 	HCI_SC_ONLY,
+	HCI_PRIVACY,
 	HCI_RPA_RESOLVING,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0fcc041fbb5..68bbcabdd9fd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -303,6 +303,8 @@ struct hci_dev {
 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
+	__u8			irk[16];
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6355a460e9d0..8ef50c790b96 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -265,6 +265,9 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	if (test_bit(HCI_RPA_RESOLVING, &hdev->dev_flags))
 		remote_dist |= SMP_DIST_ID_KEY;
 
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+		local_dist |= SMP_DIST_ID_KEY;
+
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = SMP_OOB_NOT_PRESENT;
@@ -1189,8 +1192,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		struct smp_cmd_ident_addr_info addrinfo;
 		struct smp_cmd_ident_info idinfo;
 
-		/* Send a dummy key */
-		get_random_bytes(idinfo.irk, sizeof(idinfo.irk));
+		memcpy(idinfo.irk, hdev->irk, sizeof(idinfo.irk));
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
 
-- 
1.8.5.3

