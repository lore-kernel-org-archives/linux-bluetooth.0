Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 02/12] Add a function to remove ATT connection callback
Date: Wed,  6 Jul 2011 18:23:00 -0300
Message-Id: <1309987380-9893-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attio.h  |    2 ++
 src/device.c |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/attio.h b/src/attio.h
index fad8516..7935dcd 100644
--- a/src/attio.h
+++ b/src/attio.h
@@ -27,3 +27,5 @@ typedef void (*attio_connect_cb) (GAttrib *attrib, gpointer user_data);
 guint btd_device_add_attio_callback(struct btd_device *device,
 						attio_connect_cb func,
 						gpointer user_data);
+
+gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id);
diff --git a/src/device.c b/src/device.c
index b0d9c30..f22a7fa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2469,3 +2469,30 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	return attio->id;
 }
+
+static int attio_id_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct attio_data *attio = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return attio->id - id;
+}
+
+gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
+{
+	struct attio_data *attio;
+	GSList *l;
+
+	l = g_slist_find_custom(device->attios, GUINT_TO_POINTER(id),
+								attio_id_cmp);
+	if (!l)
+		return FALSE;
+
+	attio = l->data;
+
+	device->attios = g_slist_remove(device->attios, attio);
+
+	g_free(attio);
+
+	return TRUE;
+}
-- 
1.7.6

