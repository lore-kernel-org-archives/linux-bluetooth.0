Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/2] android/hid: Reject connections from unknown devices
Date: Fri, 22 Aug 2014 11:02:59 +0200
Message-Id: <1408698180-23301-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408698180-23301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408698180-23301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't accept input from not bonded devices.
---
 android/hidhost.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index da5f818..07985d8 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1410,6 +1410,20 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	ba2str(&dst, address);
 	DBG("Incoming connection from %s on PSM %d", address, psm);
 
+	if (!bt_device_is_bonded(&dst)) {
+		uint8_t hdr = (HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG);
+		int sk = g_io_channel_unix_get_fd(chan);
+
+		warn("hidhost: Rejected connection from unknown device %s",
+								address);
+
+		if (write(sk, &hdr, sizeof(hdr)) < 0)
+			error("hidhost: Unable to send virtual cable unplug");
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

