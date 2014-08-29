Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 2/3] android/hidhost: Add remove bond handling
Date: Fri, 29 Aug 2014 11:53:59 +0200
Message-Id: <1409306040-3162-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409306040-3162-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409306040-3162-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch HID/HOG is aware when remote device has been unpaired.
---
 android/hidhost.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 5b31c95..476742e 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1483,12 +1483,35 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
+static void hid_unpaired_cb(const bdaddr_t *addr, uint8_t type)
+{
+	GSList *l;
+	struct hid_device *dev;
+	char address[18];
+
+	l = g_slist_find_custom(devices, addr, device_cmp);
+	if (!l)
+		return;
+
+	dev = l->data;
+
+	ba2str(addr, address);
+	DBG("Unpaired device %s", address);
+
+	hid_device_remove(dev);
+}
+
 bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 
 	DBG("");
 
+	if (!bt_unpaired_register(hid_unpaired_cb)) {
+		error("hidhost: Could not register unpaired callback");
+		return false;
+	}
+
 	bacpy(&adapter_addr, addr);
 
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -1552,4 +1575,6 @@ void bt_hid_unregister(void)
 
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HIDHOST);
 	hal_ipc = NULL;
+
+	bt_unpaired_unregister(hid_unpaired_cb);
 }
-- 
1.8.4

