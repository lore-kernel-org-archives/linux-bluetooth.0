Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/3] android/hidhost: Add remove bond handling
Date: Thu, 28 Aug 2014 10:37:21 +0200
Message-Id: <1409215042-11313-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch HID/HOG is aware when remote device has been unpaired.
---
 android/hidhost.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 5b31c95..c404088 100644
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
-- 
1.8.4

