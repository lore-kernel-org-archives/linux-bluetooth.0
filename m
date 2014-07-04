Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/12] Bluetooth: Don't bother doing anything if auto_connect doesn't change
Date: Fri,  4 Jul 2014 12:37:20 +0300
Message-Id: <1404466647-16352-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When hci_conn_params_set() is called if the new auto_connect value is
the same as the old one we don't need to take any action. Simply return
success from the function in this case.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dd8aa5f86810..0601fcbd21eb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3525,6 +3525,9 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	if (!params)
 		return -EIO;
 
+	if (params->auto_connect == auto_connect)
+		return 0;
+
 	if (params->auto_connect == HCI_AUTO_CONN_REPORT &&
 	    auto_connect != HCI_AUTO_CONN_REPORT)
 		list_del_init(&params->action);
-- 
1.9.3

