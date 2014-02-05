Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/AVRCP: Add bt_avrcp_disconnect
Date: Wed,  5 Feb 2014 12:26:58 +0200
Message-Id: <1391596020-27679-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
References: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_avrcp_disconnect function which can be used to disconnect
AVRCP sessions.
---
 android/avrcp.c | 26 ++++++++++++++++++++++++++
 android/avrcp.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index 8600d98..f61ed34 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -135,6 +135,11 @@ static void avrcp_device_free(void *data)
 	if (dev->session)
 		avctp_shutdown(dev->session);
 
+	if (dev->io) {
+		g_io_channel_shutdown(dev->io, FALSE, NULL);
+		g_io_channel_unref(dev->io);
+	}
+
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 }
@@ -338,3 +343,24 @@ void bt_avrcp_connect(const bdaddr_t *dst)
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
 }
+
+void bt_avrcp_disconnect(const bdaddr_t *dst)
+{
+	struct avrcp_device *dev;
+	GSList *l;
+
+	DBG("");
+
+	l = g_slist_find_custom(devices, dst, device_cmp);
+	if (!l)
+		return;
+
+	dev = l->data;
+
+	if (dev->session) {
+		avctp_shutdown(dev->session);
+		return;
+	}
+
+	avrcp_device_free(dev);
+}
diff --git a/android/avrcp.h b/android/avrcp.h
index 7b0a5ed..4ad49e6 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -25,3 +25,4 @@ bool bt_avrcp_register(const bdaddr_t *addr);
 void bt_avrcp_unregister(void);
 
 void bt_avrcp_connect(const bdaddr_t *dst);
+void bt_avrcp_disconnect(const bdaddr_t *dst);
-- 
1.8.5.3

