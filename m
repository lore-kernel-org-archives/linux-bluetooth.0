Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Make LE scan interval and window a controller option
Date: Fri,  4 Oct 2013 03:19:14 -0700
Message-Id: <1380881955-59853-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The scan interval and window for LE passive scanning and connection
establishment should be configurable on a per controller basis. So
introduce a setting that later on will allow modifying it.

This setting does not affect LE active scanning during device
discovery phase. As long as that phase uses interleaved discovery,
it will will continuously scan.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_conn.c         | 4 ++--
 net/bluetooth/hci_core.c         | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e09c305..7442ece 100644
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
index 08e601c..c5b115e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -55,8 +55,8 @@ static void hci_le_create_connection(struct hci_conn *conn)
 	struct hci_cp_le_create_conn cp;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = __constant_cpu_to_le16(0x0060);
-	cp.scan_window = __constant_cpu_to_le16(0x0030);
+	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
+	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
 	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 82dbdc6..6c2eff0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2223,6 +2223,9 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
+	hdev->le_scan_interval = 0x0060;
+	hdev->le_scan_window = 0x0030;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
-- 
1.8.3.1

