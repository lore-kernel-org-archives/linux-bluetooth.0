Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 1/2] android/hid: Reject connections from unknown devices
Date: Mon, 25 Aug 2014 14:54:18 +0200
Message-Id: <1408971259-21929-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408971259-21929-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408971259-21929-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't accept input from not bonded devices.
---
 android/hidhost.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index da5f818..bb725c1 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -950,6 +950,19 @@ failed:
 									status);
 }
 
+static bool bt_hid_write_virtual_unplug(GIOChannel *chan)
+{
+	uint8_t hdr = HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG;
+	int fd = g_io_channel_unix_get_fd(chan);
+
+	if (write(fd, &hdr, sizeof(hdr)) == sizeof(hdr))
+		return true;
+
+	error("hidhost: Error writing virtual unplug command: %s (%d)",
+							strerror(errno), errno);
+	return false;
+}
+
 static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_hidhost_virtual_unplug *cmd = buf;
@@ -957,8 +970,6 @@ static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 	GSList *l;
 	uint8_t status;
 	bdaddr_t dst;
-	uint8_t hdr;
-	int fd;
 
 	DBG("");
 
@@ -977,13 +988,7 @@ static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	hdr = HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG;
-
-	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
-
-	if (write(fd, &hdr, sizeof(hdr)) < 0) {
-		error("hidhost: Error writing virtual unplug command: %s (%d)",
-						strerror(errno), errno);
+	if (!bt_hid_write_virtual_unplug(dev->ctrl_io)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -1410,6 +1415,16 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	ba2str(&dst, address);
 	DBG("Incoming connection from %s on PSM %d", address, psm);
 
+	if (!bt_device_is_bonded(&dst)) {
+		warn("hidhost: Rejecting connection from unknown device %s",
+								address);
+		if (psm == L2CAP_PSM_HIDP_CTRL)
+			bt_hid_write_virtual_unplug(chan);
+
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
 	switch (psm) {
 	case L2CAP_PSM_HIDP_CTRL:
 		l = g_slist_find_custom(devices, &dst, device_cmp);
-- 
1.9.1

