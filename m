Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <linux-bluetooth@vger.kernel.org>, YueHaibing
	<yuehaibing@huawei.com>
Subject: [PATCH] Bluetooth: remove redundant variables 'adv_set' and 'cp'
Date: Mon, 6 Aug 2018 19:08:51 +0800
Message-ID: <20180806110851.8568-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Variables 'adv_set' and 'cp'  are being assigned but are never used hence
they are redundant and can be removed.

Cleans up clang warnings:
net/bluetooth/hci_event.c:1135:29: warning: variable 'adv_set' set but not used [-Wunused-but-set-variable]
net/bluetooth/mgmt.c:3359:39: warning: variable 'cp' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bluetooth/hci_event.c | 3 ---
 net/bluetooth/mgmt.c      | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 754714c..8078587 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1132,7 +1132,6 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
-	struct hci_cp_ext_adv_set *adv_set;
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -1144,8 +1143,6 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	adv_set = (void *) cp->data;
-
 	hci_dev_lock(hdev);
 
 	if (cp->enable) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 231602f7..3bdc8f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3356,7 +3356,6 @@ int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
 static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode, struct sk_buff *skb)
 {
-	struct mgmt_cp_set_phy_confguration *cp;
 	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
@@ -3367,8 +3366,6 @@ static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 	if (!cmd)
 		goto unlock;
 
-	cp = cmd->param;
-
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id,
 				MGMT_OP_SET_PHY_CONFIGURATION,
-- 
2.7.0
