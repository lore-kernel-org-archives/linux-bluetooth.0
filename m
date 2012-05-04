Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] input: increase security level of the connection
Date: Thu,  3 May 2012 23:01:19 -0300
Message-Id: <1336096879-17327-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/input/device.c b/input/device.c
index 59388d8..092560d 100644
--- a/input/device.c
+++ b/input/device.c
@@ -74,7 +74,9 @@ struct input_conn {
 	GIOChannel		*intr_io;
 	guint			ctrl_watch;
 	guint			intr_watch;
+	guint			sec_watch;
 	int			timeout;
+	struct hidp_connadd_req *req;
 	struct input_device	*idev;
 };
 
@@ -128,6 +130,9 @@ static void input_conn_free(struct input_conn *iconn)
 	if (iconn->intr_watch)
 		g_source_remove(iconn->intr_watch);
 
+	if (iconn->sec_watch)
+		g_source_remove(iconn->sec_watch);
+
 	if (iconn->intr_io)
 		g_io_channel_unref(iconn->intr_io);
 
@@ -566,14 +571,31 @@ cleanup:
 	g_free(req);
 }
 
+static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
+								gpointer data)
+{
+	struct input_conn *iconn = data;
+	struct hidp_connadd_req *req = iconn->req;
+
+	DBG(" ");
+
+	encrypt_completed(0, req);
+
+	iconn->sec_watch = 0;
+	iconn->req = NULL;
+
+	return FALSE;
+}
+
 static int hidp_add_connection(const struct input_device *idev,
-				const struct input_conn *iconn)
+					struct input_conn *iconn)
 {
 	struct hidp_connadd_req *req;
 	struct fake_hid *fake_hid;
 	struct fake_input *fake;
 	sdp_record_t *rec;
 	char src_addr[18], dst_addr[18];
+	GError *gerr = NULL;
 	int err;
 
 	req = g_new0(struct hidp_connadd_req, 1);
@@ -627,7 +649,12 @@ static int hidp_add_connection(const struct input_device *idev,
 		if (err == 0) {
 			/* Waiting async encryption */
 			return 0;
-		} else if (err != -EALREADY) {
+		}
+
+		if (err == -ENOSYS)
+			goto nosys;
+
+		if (err != -EALREADY) {
 			error("encrypt_link: %s (%d)", strerror(-err), -err);
 			goto cleanup;
 		}
@@ -640,6 +667,20 @@ cleanup:
 	g_free(req);
 
 	return err;
+
+nosys:
+	if (!bt_io_set(iconn->intr_io, BT_IO_L2CAP, &gerr,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID)) {
+		error("btio: %s", gerr->message);
+		g_error_free(gerr);
+		goto cleanup;
+	}
+
+	iconn->req = req;
+	iconn->sec_watch = g_io_add_watch(iconn->intr_io, G_IO_OUT,
+							encrypt_notify, iconn);
+	return 0;
 }
 
 static int is_connected(struct input_conn *iconn)
-- 
1.7.10

