Return-Path: <cyrus@holtmann.org>
From: Georg Lukas <georg@op-co.de>
To: linux-bluetooth@vger.kernel.org
Cc: Georg Lukas <georg@op-co.de>
Subject: [PATCH 1/2] Bluetooth: Provide defaults for LE advertising interval
Date: Sat, 26 Jul 2014 13:59:57 +0200
Message-Id: <1406375998-15288-2-git-send-email-georg@op-co.de>
In-Reply-To: <1406375998-15288-1-git-send-email-georg@op-co.de>
References: <1406375998-15288-1-git-send-email-georg@op-co.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store the default values for minimum and maximum advertising interval
with all the other controller defaults. These vaules are sent to the
adapter whenever advertising is (re)enabled.

Signed-off-by: Georg Lukas <georg@op-co.de>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_core.c         | 2 ++
 net/bluetooth/mgmt.c             | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 747a0c3..b5d5af3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -203,6 +203,8 @@ struct hci_dev {
 	__u16		page_scan_window;
 	__u8		page_scan_type;
 	__u8		le_adv_channel_map;
+	__u16		le_adv_min_interval;
+	__u16		le_adv_max_interval;
 	__u8		le_scan_type;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d8f91d5..8292bba 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3923,6 +3923,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_min_interval = 80;
 
 	hdev->le_adv_channel_map = 0x07;
+	hdev->le_adv_min_interval = 0x0800;
+	hdev->le_adv_max_interval = 0x0800;
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
 	hdev->le_conn_min_interval = 0x0028;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccc4653..ff87458 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1086,8 +1086,8 @@ static void enable_advertising(struct hci_request *req)
 		return;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.min_interval = cpu_to_le16(0x0800);
-	cp.max_interval = cpu_to_le16(0x0800);
+	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
 	cp.type = connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
-- 
2.0.1

