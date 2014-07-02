Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] Bluetooth: Add new auto_conn value matching mgmt action 0x00
Date: Wed,  2 Jul 2014 17:37:27 +0300
Message-Id: <1404311854-12233-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The 0x00 action value of mgmt means "scan and report" but do not
connect. This is different from HCI_AUTO_CONN_DISABLED so we need a new
value for it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 1 +
 net/bluetooth/mgmt.c             | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2091e0013b8c..f4a2f50f30b5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -449,6 +449,7 @@ struct hci_conn_params {
 
 	enum {
 		HCI_AUTO_CONN_DISABLED,
+		HCI_AUTO_CONN_REPORT,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
 	} auto_connect;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7e46a7c6092f..a3cd0bbd3518 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3547,6 +3547,7 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
+	case HCI_AUTO_CONN_REPORT:
 	case HCI_AUTO_CONN_LINK_LOSS:
 		hci_pend_le_conn_del(hdev, addr, addr_type);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 29850e76ea3c..f7217f9eda03 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5034,7 +5034,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	if (cp->action)
 		auto_conn = HCI_AUTO_CONN_ALWAYS;
 	else
-		auto_conn = HCI_AUTO_CONN_DISABLED;
+		auto_conn = HCI_AUTO_CONN_REPORT;
 
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
-- 
1.9.3

