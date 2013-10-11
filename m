Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Make LE scan interval and window a controller option
Date: Fri, 11 Oct 2013 08:23:19 -0700
Message-Id: <1381505000-50787-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The scan interval and window for LE passive scanning and connection
establishment should be configurable on a per controller basis. So
introduce a setting that later on will allow modifying it.

This setting does not affect LE active scanning during device
discovery phase. As long as that phase uses interleaved discovery,
it will continuously scan.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_conn.c         | 4 ++--
 net/bluetooth/hci_core.c         | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0e01dc2..6900454 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -164,6 +164,8 @@ struct hci_dev {
 	__u16		page_scan_interval;
 	__u16		page_scan_window;
 	__u8		page_scan_type;
+	__u16		le_scan_interval;
+	__u16		le_scan_window;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1395871..c52bfb7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -562,8 +562,8 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	hci_req_init(&req, hdev);
 
 	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = __constant_cpu_to_le16(0x0060);
-	cp.scan_window = __constant_cpu_to_le16(0x0030);
+	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
+	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
 	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a097a62..1910dc2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2273,6 +2273,9 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
+	hdev->le_scan_interval = 0x0060;
+	hdev->le_scan_window = 0x0030;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
-- 
1.8.3.1

