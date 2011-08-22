Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 9/9] Implement media_transport for HFP_HS_UUID
Date: Mon, 22 Aug 2011 17:30:47 +0200
Message-Id: <1314027047-5476-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The transport is used by pulseaudio to suspend and resume streams.
---
 audio/transport.c |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index f915262..2739199 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -42,6 +42,7 @@
 #include "transport.h"
 #include "a2dp.h"
 #include "headset.h"
+#include "gateway.h"
 
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
@@ -436,6 +437,115 @@ static void cancel_headset(struct media_transport *transport, guint id)
 	headset_cancel_stream(transport->device, id);
 }
 
+static void gateway_resume_complete(struct audio_device *dev, GError *err,
+							void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_request *req = owner->pending;
+	struct media_transport *transport = owner->transport;
+	int fd;
+	uint16_t imtu, omtu;
+	gboolean ret;
+
+	req->id = 0;
+
+	if (dev == NULL)
+		goto fail;
+
+	if (err) {
+		error("Failed to resume gateway: error %s", err->message);
+		goto fail;
+	}
+
+	fd = gateway_get_sco_fd(dev);
+	if (fd < 0)
+		goto fail;
+
+	imtu = 48;
+	omtu = 48;
+
+	media_transport_set_fd(transport, fd, imtu, omtu);
+
+	if (g_strstr_len(owner->accesstype, -1, "r") == NULL)
+		imtu = 0;
+
+	if (g_strstr_len(owner->accesstype, -1, "w") == NULL)
+		omtu = 0;
+
+	ret = g_dbus_send_reply(transport->conn, req->msg,
+						DBUS_TYPE_UNIX_FD, &fd,
+						DBUS_TYPE_UINT16, &imtu,
+						DBUS_TYPE_UINT16, &omtu,
+						DBUS_TYPE_INVALID);
+	if (ret == FALSE)
+		goto fail;
+
+	media_owner_remove(owner);
+
+	return;
+
+fail:
+	media_transport_remove(transport, owner);
+}
+
+static guint resume_gateway(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct audio_device *device = transport->device;
+
+	if (transport->in_use == TRUE)
+		goto done;
+
+	transport->in_use = gateway_lock(device, GATEWAY_LOCK_READ |
+						GATEWAY_LOCK_WRITE);
+	if (transport->in_use == FALSE)
+		return 0;
+
+done:
+	return gateway_request_stream(device, gateway_resume_complete,
+					owner);
+}
+
+static gboolean gateway_suspend_complete(gpointer user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+
+	/* Release always succeeds */
+	if (owner->pending) {
+		owner->pending->id = 0;
+		media_request_reply(owner->pending, transport->conn, 0);
+		media_owner_remove(owner);
+	}
+
+	transport->in_use = FALSE;
+	media_transport_remove(transport, owner);
+	return FALSE;
+}
+
+static guint suspend_gateway(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct audio_device *device = transport->device;
+	static int id = 1;
+
+	if (!owner) {
+		gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
+		transport->in_use = FALSE;
+		return 0;
+	}
+
+	gateway_suspend_stream(device);
+	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
+	g_idle_add(gateway_suspend_complete, owner);
+	return id++;
+}
+
+static void cancel_gateway(struct media_transport *transport, guint id)
+{
+	gateway_cancel_stream(transport->device, id);
+}
+
 static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_owner *owner = user_data;
@@ -672,6 +782,13 @@ static int set_property_headset(struct media_transport *transport,
 	return -EINVAL;
 }
 
+static int set_property_gateway(struct media_transport *transport,
+						const char *property,
+						DBusMessageIter *value)
+{
+	return -EINVAL;
+}
+
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -740,6 +857,12 @@ static void get_properties_headset(struct media_transport *transport,
 	dict_append_entry(dict, "Routing", DBUS_TYPE_STRING, &routing);
 }
 
+static void get_properties_gateway(struct media_transport *transport,
+						DBusMessageIter *dict)
+{
+	/* None */
+}
+
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter)
 {
@@ -881,6 +1004,13 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		transport->nrec_id = headset_add_nrec_cb(device,
 							headset_nrec_changed,
 							transport);
+	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
+			strcasecmp(uuid, HSP_HS_UUID) == 0) {
+		transport->resume = resume_gateway;
+		transport->suspend = suspend_gateway;
+		transport->cancel = cancel_gateway;
+		transport->get_properties = get_properties_gateway;
+		transport->set_property = set_property_gateway;
 	} else
 		goto fail;
 
-- 
1.7.1

