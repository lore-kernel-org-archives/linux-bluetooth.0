Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix flags of mgmt_device_found event
Date: Mon, 11 Jun 2012 09:18:51 -0400
Message-Id: <1339420731-27485-1-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1338577525-9182-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1338577525-9182-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change flags field to matches userspace structure.
This field needs to be converted to little endian before forward it.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/mgmt.h |    2 +-
 net/bluetooth/mgmt.c         |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 23fd054..4348ee8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -444,7 +444,7 @@ struct mgmt_ev_auth_failed {
 struct mgmt_ev_device_found {
 	struct mgmt_addr_info addr;
 	__s8	rssi;
-	__u8	flags[4];
+	__le32	flags;
 	__le16	eir_len;
 	__u8	eir[0];
 } __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..34cf841 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3528,9 +3528,9 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
 	if (cfm_name)
-		ev->flags[0] |= MGMT_DEV_FOUND_CONFIRM_NAME;
+		ev->flags |= MGMT_DEV_FOUND_CONFIRM_NAME;
 	if (!ssp)
-		ev->flags[0] |= MGMT_DEV_FOUND_LEGACY_PAIRING;
+		ev->flags |= MGMT_DEV_FOUND_LEGACY_PAIRING;
 
 	if (eir_len > 0)
 		memcpy(ev->eir, eir, eir_len);
@@ -3540,6 +3540,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					  dev_class, 3);
 
 	ev->eir_len = cpu_to_le16(eir_len);
+	ev->flags = cpu_to_le32(ev->flags);
 
 	ev_size = sizeof(*ev) + eir_len;
 
-- 
1.7.10.3

