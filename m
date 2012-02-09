Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Add address type to Out Of Band mgmt messages
Date: Thu,  9 Feb 2012 17:23:46 +0200
Message-Id: <1328801030-24274-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the implementation for these mgmt to be up to date
with the latest API specification. Right now the address type isn't
actually used for anything but that might change in the future.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    4 ++--
 net/bluetooth/mgmt.c         |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 378d498..f284499 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -270,14 +270,14 @@ struct mgmt_rp_read_local_oob_data {
 
 #define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0021
 struct mgmt_cp_add_remote_oob_data {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 hash[16];
 	__u8 randomizer[16];
 } __packed;
 
 #define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x0022
 struct mgmt_cp_remove_remote_oob_data {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_START_DISCOVERY		0x0023
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 16fc828..763a447 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1875,7 +1875,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, void *data,
 
 	hci_dev_lock(hdev);
 
-	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
+	err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr, cp->hash,
 								cp->randomizer);
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
@@ -1910,7 +1910,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 
 	hci_dev_lock(hdev);
 
-	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
+	err = hci_remove_remote_oob_data(hdev, &cp->addr.bdaddr);
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 						MGMT_STATUS_INVALID_PARAMS);
-- 
1.7.9

