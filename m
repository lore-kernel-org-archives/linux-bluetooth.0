Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] android/hidhost: Add remove bond handling
Date: Wed, 27 Aug 2014 22:47:43 +0200
Message-Id: <1409172464-30369-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch HID/HOG is aware when remote device has been unpaired.
---
 android/hidhost.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 5b31c95..eeefb63 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1483,6 +1483,24 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
+static void hid_unpaired_cb(const bdaddr_t *addr)
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
@@ -1525,6 +1543,8 @@ bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HIDHOST, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	bt_unpaired_register(hid_unpaired_cb);
+
 	return true;
 }
 
-- 
1.8.4

