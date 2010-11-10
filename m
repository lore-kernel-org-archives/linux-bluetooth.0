Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] [RFC] Fix HDP-related segfault upon device recreation
Date: Wed, 10 Nov 2010 01:15:15 -0200
Message-Id: <1289358915-6612-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When device is removed and paired again, hdp_device is destroyed
but a cached mcap_mcl may retain a pointer in mcl->cb->user_data.
This patch ensures that such MCL is destroyed.

There is probably a better solution to this e.g. changing cache
strategy for accepted connections. A loop can be removed if 1:1
relationship between hdp_device and MCL is guaranteed.
---
 health/hdp.c      |    1 +
 health/mcap.c     |   23 ++++++++++++++++++++++-
 health/mcap_lib.h |    2 ++
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index b141fe7..44ebe75 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -277,6 +277,7 @@ static void free_health_device(struct hdp_device *device)
 	}
 
 	device_unref_mcl(device);
+	mcap_invalidate_by_user_data(device->hdp_adapter->mi, device);
 
 	g_free(device);
 }
diff --git a/health/mcap.c b/health/mcap.c
index cb7b74c..34ccdaa 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -938,6 +938,27 @@ gboolean mcap_mcl_set_cb(struct mcap_mcl *mcl, gpointer user_data,
 	return TRUE;
 }
 
+static gint cmp_mcl_user_data(gconstpointer a, gconstpointer b)
+{
+	const struct mcap_mcl *mcl = a;
+	gconstpointer user_data = b;
+
+	if (mcl->cb)
+		if (mcl->cb->user_data == user_data)
+			return 0;
+
+	return 1;
+}
+
+void mcap_invalidate_by_user_data(struct mcap_instance *mi, gpointer user_data)
+{
+	GSList *l;
+
+	while ((l = g_slist_find_custom(mi->cached, user_data,
+						cmp_mcl_user_data)))
+		mcap_close_mcl(l->data, FALSE);
+}
+
 void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
 {
 	bacpy(addr, &mcl->addr);
@@ -2143,4 +2164,4 @@ gboolean mcap_set_data_chan_mode(struct mcap_instance *mi, uint8_t mode,
 
 	return bt_io_set(mi->dcio, BT_IO_L2CAP, err, BT_IO_OPT_MODE, mode,
 							BT_IO_OPT_INVALID);
-}
\ No newline at end of file
+}
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index 7740623..cc10c17 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -172,6 +172,8 @@ void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr);
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl);
 void mcap_mcl_unref(struct mcap_mcl *mcl);
 
+void mcap_invalidate_by_user_data(struct mcap_instance *mi, gpointer user_data);
+
 /* CSP operations */
 
 void mcap_enable_csp(struct mcap_instance *ms);
-- 
1.7.0.4

