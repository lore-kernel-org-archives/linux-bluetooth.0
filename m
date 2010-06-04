Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 32/32] Add support for mcl reconnections
Date: Fri,  4 Jun 2010 10:30:25 +0200
Message-Id: <1275640225-4186-33-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-32-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-29-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-30-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-31-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-32-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 6a73e05..8a6a0d4 100644
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
-			DBG("Need a reconection");
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

