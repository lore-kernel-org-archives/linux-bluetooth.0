Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 4/6] media: Add MediaTransport.TryAcquire()
Date: Wed,  5 Dec 2012 17:15:32 +0100
Message-Id: <1354724134-7354-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Split the Acquire() method in two parts so that the optional acquires,
formerly represented as a "?" flag in the accesstype parameter of
Acquire(), are now implemented in TryAcquire().
---
 doc/media-api.txt          |  7 +++++++
 profiles/audio/transport.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b15ad61..5e052b4 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -266,6 +266,13 @@ Methods		fd, uint16, uint16 Acquire()
 			Acquire transport file descriptor and the MTU for read
 			and write respectively.
 
+		fd, uint16, uint16 TryAcquire()
+
+			Acquire transport file descriptor only if the transport
+			is in "pending" state at the time the message is
+			received by BlueZ. Otherwise no request will be sent
+			to the remote device and the function will just fail.
+
 		void Release()
 
 			Releases file descriptor.
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 1064098..0fd2469 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -463,6 +463,37 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_transport *transport = data;
+	struct media_owner *owner;
+	struct media_request *req;
+	guint id;
+
+	if (transport->owner != NULL)
+		return btd_error_not_authorized(msg);
+
+	if (transport->state >= TRANSPORT_STATE_REQUESTING)
+		return btd_error_not_authorized(msg);
+
+	if (transport->state != TRANSPORT_STATE_PENDING)
+		return btd_error_failed(msg, "Transport not playing");
+
+	owner = media_owner_create(msg);
+	id = transport->resume(transport, owner);
+	if (id == 0) {
+		media_owner_free(owner);
+		return btd_error_not_authorized(msg);
+	}
+
+	req = media_request_create(msg, id);
+	media_owner_add(owner, req);
+	media_transport_set_owner(transport, owner);
+
+	return NULL;
+}
+
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -634,6 +665,11 @@ static const GDBusMethodTable transport_methods[] = {
 			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
 							{ "mtu_w", "q" } ),
 			acquire) },
+	{ GDBUS_ASYNC_METHOD("TryAcquire",
+			NULL,
+			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
+							{ "mtu_w", "q" }),
+			try_acquire) },
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
 	{ },
 };
-- 
1.7.11.7

