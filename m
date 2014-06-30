Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/12] android/hidhost: Use bt_hog_send in bt_hid_send_data
Date: Mon, 30 Jun 2014 16:47:49 +0300
Message-Id: <1404136079-24846-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bt_hid_send_data is called for a HoG device send data using
bt_hog_send.
---
 android/hidhost.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 0c0d69d..07b2b02 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1270,6 +1270,21 @@ failed:
 									status);
 }
 
+static int hog_send_data(struct hid_device *dev, void *data, size_t size)
+{
+	int err;
+
+	DBG("");
+
+	err = bt_hog_send(dev->hog, data, size);
+	if (err == 0)
+		return 0;
+
+	error("hidhost: error writing data to HoG device: %s (%d)",
+							strerror(-err), -err);
+	return err;
+}
+
 static void bt_hid_send_data(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_hidhost_send_data *cmd = buf;
@@ -1322,6 +1337,14 @@ static void bt_hid_send_data(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	if (dev->hog) {
+		if (hog_send_data(dev, req, req_size) == 0)
+			goto done;
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	fd = g_io_channel_unix_get_fd(dev->intr_io);
 
 	if (write(fd, req, req_size) < 0) {
@@ -1331,6 +1354,7 @@ static void bt_hid_send_data(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+done:
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.9.3

