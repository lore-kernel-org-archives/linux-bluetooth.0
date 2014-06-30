Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Provide defaults for LE connection latency and timeout
Date: Mon, 30 Jun 2014 12:16:08 +0200
Message-Id: <1404123370-56018-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store the connection latency and supervision timeout default values
with all the other controller defaults. And when needed use them
for new connections.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_conn.c         | 4 ++--
 net/bluetooth/hci_core.c         | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 182044824495..ed842c7e5cf1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -203,6 +203,8 @@ struct hci_dev {
 	__u16		le_scan_window;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
+	__u16		le_conn_latency;
+	__u16		le_supv_timeout;
 	__u16		discov_interleaved_timeout;
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e7ee7267f846..d00aaf976efc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -773,8 +773,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	} else {
 		conn->le_conn_min_interval = hdev->le_conn_min_interval;
 		conn->le_conn_max_interval = hdev->le_conn_max_interval;
-		conn->le_conn_latency = 0x0000;
-		conn->le_supv_timeout = 0x002a;
+		conn->le_conn_latency = hdev->le_conn_latency;
+		conn->le_supv_timeout = hdev->le_supv_timeout;
 	}
 
 	/* If controller is scanning, we stop it since some controllers are
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d972023196b..94551c33c4c6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3439,8 +3439,8 @@ int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 update:
 	params->conn_min_interval = conn_min_interval;
 	params->conn_max_interval = conn_max_interval;
-	params->conn_latency = 0x0000;
-	params->supervision_timeout = 0x002a;
+	params->conn_latency = hdev->le_conn_latency;
+	params->supervision_timeout = hdev->le_supv_timeout;
 	params->auto_connect = auto_connect;
 
 	switch (auto_connect) {
@@ -3706,6 +3706,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_scan_window = 0x0030;
 	hdev->le_conn_min_interval = 0x0028;
 	hdev->le_conn_max_interval = 0x0038;
+	hdev->le_conn_latency = 0x0000;
+	hdev->le_supv_timeout = 0x002a;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
-- 
1.9.3

