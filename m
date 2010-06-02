Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 32/32] Add support for mcl reconnections
Date: Wed,  2 Jun 2010 15:19:28 +0200
Message-Id: <1275484768-25838-33-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-32-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-28-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-29-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-30-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-31-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-32-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 9678baa..7a726e0 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -56,6 +56,7 @@ struct hdp_connection_cb {
 	struct hdp_instance	*hdpi;
 	uint32_t		rem_id;
 	DBusMessage		*msg;
+	struct hdp_link		*hdpl;
 };
 
 static struct hdp_adapter *find_adapter(GSList *list,
@@ -554,11 +555,15 @@ static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
 	if (err)
 		goto fail;
 
-	hdpl = create_health_link(hdpi, mcl, &gerr);
-	if (gerr)
-		goto fail;
+	if (cb_data->hdpl)
+		hdpl = cb_data->hdpl;
+	else {
+		hdpl = create_health_link(hdpi, mcl, &gerr);
+		if (gerr)
+			goto fail;
+		hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
+	}
 
-	hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
 	reply = g_dbus_create_reply(msg, DBUS_TYPE_OBJECT_PATH, &hdpl->path,
 							DBUS_TYPE_INVALID);
 	g_dbus_send_message(device->conn, reply);
@@ -664,10 +669,7 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 	hdpi = l->data;
 	hdpl = get_health_link(hdpi, device);
 	if (hdpl) {
-		if (hdpl->closed) {
-			debug("Need a reconection");
-			/* TODO: Reconnect */;
-		} else
+		if (!hdpl->closed)
 			return g_dbus_create_reply(msg, DBUS_TYPE_OBJECT_PATH,
 						&hdpl->path, DBUS_TYPE_INVALID);
 	}
@@ -677,6 +679,8 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 	cb_data->hdpi = hdpi;
 	cb_data->rem_id = rid;
 	cb_data->msg = dbus_message_ref(msg);
+	/* Used for reconnections */
+	cb_data->hdpl = hdpl;
 
 	adapter = device->hdp_adapter->btd_adapter;
 	adapter_get_address(adapter, &src);
-- 
1.6.3.3

