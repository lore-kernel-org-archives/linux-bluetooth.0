Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 1/6] android/bluetooth: Add flag for kernel connection control
Date: Mon,  4 Aug 2014 12:34:14 +0200
Message-Id: <1407148459-20125-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set option kernel connection control to TRUE if mgmt interface
is 1.7 or higier. Kernel connect control means that things like
background scan, auto connect or white list are supported by kernel and
can be used by daemon.
---
 android/bluetooth.c | 13 +++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index cd1772a..aaba585 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -221,6 +221,8 @@ static GSList *browse_reqs;
 
 static struct ipc *hal_ipc = NULL;
 
+static bool kernel_conn_control = false;
+
 static void get_device_android_addr(struct device *dev, uint8_t *addr)
 {
 	/*
@@ -1489,6 +1491,11 @@ bool bt_device_set_uuids(const bdaddr_t *addr, GSList *uuids)
 	return true;
 }
 
+bool bt_kernel_conn_control(void)
+{
+	return kernel_conn_control;
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
@@ -3268,6 +3275,12 @@ static void read_version_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
+	/* Starting from mgmt 1.7, kernel can handle connection control */
+	if (MGMT_VERSION(mgmt_version, mgmt_revision) >= MGMT_VERSION(1, 7)) {
+		info("Kernel connection control will be used");
+		kernel_conn_control = true;
+	}
+
 	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
 					mgmt_index_added_event, cb, NULL);
 	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
diff --git a/android/bluetooth.h b/android/bluetooth.h
index e00634c..adad6c4 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -79,3 +79,5 @@ void bt_store_gatt_ccc(const bdaddr_t *addr, uint16_t value);
 uint16_t bt_get_gatt_ccc(const bdaddr_t *addr);
 
 const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type);
+
+bool bt_kernel_conn_control(void);
-- 
1.8.4

