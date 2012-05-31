Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Filter duplicated reports in LE scan
Date: Thu, 31 May 2012 20:01:41 -0300
Message-Id: <1338505301-25384-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables filtering duplicated advertising reports during
LE scan.

Some LE devices advertise using very small intervals generating lots
of equal advertising report events to the host. Each event generates
a mgmt_device_found event which is copied to userspace.

Enabling this feature, duplicated advertising reports are filtered
at controller's link layer. This way, the controller doesn't wake up
the host to report duplicated advertising reports and, consequently,
less data is copied to userspace.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 979556a..cf39e95 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1526,6 +1526,7 @@ static void le_scan_enable_req(struct hci_dev *hdev, unsigned long opt)
 
 	memset(&cp, 0, sizeof(cp));
 	cp.enable = 1;
+	cp.filter_dup = 1;
 
 	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
-- 
1.7.10.2

