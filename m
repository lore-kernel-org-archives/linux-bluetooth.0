Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: jonas.holmberg@axis.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Change initial min and max interval
Date: Thu, 23 Feb 2017 15:17:02 +0100
Message-Id: <20170223141702.32390-1-jonashg@axis.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jonas Holmberg <jonashg@axis.com>

Use the initial connection interval recommended in Bluetooth
Specification v4.2 (30ms - 50ms).

Signed-off-by: Jonas Holmberg <jonashg@axis.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3ac89e9..0568677 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2950,8 +2950,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_adv_max_interval = 0x0800;
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
-	hdev->le_conn_min_interval = 0x0028;
-	hdev->le_conn_max_interval = 0x0038;
+	hdev->le_conn_min_interval = 0x0018;
+	hdev->le_conn_max_interval = 0x0028;
 	hdev->le_conn_latency = 0x0000;
 	hdev->le_supv_timeout = 0x002a;
 	hdev->le_def_tx_len = 0x001b;
-- 
2.10.2

