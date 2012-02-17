Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: mgmt: Add address type to confirm name command
Date: Fri, 17 Feb 2012 14:32:27 +0200
Message-Id: <1329481947-19108-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
References: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The latest mgmt API includes an address type for all messages containing
an address. This patch updates the confirm name command to match this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    4 ++--
 net/bluetooth/mgmt.c         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index eb584cc..14c1816 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -296,11 +296,11 @@ struct mgmt_cp_start_discovery {
 
 #define MGMT_OP_CONFIRM_NAME		0x0025
 struct mgmt_cp_confirm_name {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 name_known;
 } __packed;
 struct mgmt_rp_confirm_name {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6862340..01c8d62 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2299,7 +2299,7 @@ static int confirm_name(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->bdaddr);
+	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->addr.bdaddr);
 	if (!e) {
 		err = cmd_status (sk, index, MGMT_OP_CONFIRM_NAME,
 				MGMT_STATUS_INVALID_PARAMS);
-- 
1.7.9

