Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 1/3] media: Remove transport access type from D-Bus API
Date: Tue,  4 Dec 2012 18:13:48 +0100
Message-Id: <1354641230-3667-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354641230-3667-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354641230-3667-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

There is no known use-case making use of these access types and
therefore the Media API can be simplified.

>From now on, the transport will always be acquired with read and write
access rights.
---
 doc/media-api.txt          | 30 ++++++++----------------------
 profiles/audio/transport.c | 44 +++++++++-----------------------------------
 2 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index cf69efa..cb5d9a3 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -261,31 +261,17 @@ Service		org.bluez
 Interface	org.bluez.MediaTransport
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/fdX
 
-Methods		fd, uint16, uint16 Acquire(string accesstype)
+Methods		fd, uint16, uint16 Acquire(boolean optional)
 
-			Acquire transport file descriptor and the MTU for read
-			and write respectively.
+			Acquire transport (with read and write rights) and
+			return the file descriptor and the MTU.
 
-			possible accesstype:
+			The optional flag specifies that the transport will be
+			acquired only if it's in "pending" state, and will
+			otherwise fail. This means no request will be sent to
+			the remote side.
 
-				"r" : Read only access
-
-				"w" : Write only access
-
-				"rw": Read and write access
-
-			The accesstype string can also be combined with a "?"
-			suffix, which will make the request optional. This
-			typically means the transport will only be acquired if
-			it is already available (remote-initiated), but
-			otherwise no request will be sent to the remote side.
-			In this last case the function will fail. Note that,
-			due to compatibility issues with older versions of
-			BlueZ, clients are encouraged to use exactly the same
-			accesstype for Release(), matching the string provided
-			to Acquire().
-
-		void Release(string accesstype)
+		void Release()
 
 			Releases file descriptor.
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 610aca3..5924f73 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -127,19 +127,6 @@ static const char *lock2str(transport_lock_t lock)
 		return "rw";
 }
 
-static transport_lock_t str2lock(const char *str)
-{
-	transport_lock_t lock = 0;
-
-	if (g_strstr_len(str, -1, "r") != NULL)
-		lock |= TRANSPORT_LOCK_READ;
-
-	if (g_strstr_len(str, -1, "w") != NULL)
-		lock |= TRANSPORT_LOCK_WRITE;
-
-	return lock;
-}
-
 static const char *state2str(transport_state_t state)
 {
 	switch (state) {
@@ -532,12 +519,13 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	struct media_transport *transport = data;
 	struct media_owner *owner;
 	struct media_request *req;
-	const char *accesstype, *sender;
-	transport_lock_t lock;
+	const char *sender;
+	dbus_bool_t optional;
 	guint id;
+	transport_lock_t lock = TRANSPORT_LOCK_READ | TRANSPORT_LOCK_WRITE;
 
 	if (!dbus_message_get_args(msg, NULL,
-				DBUS_TYPE_STRING, &accesstype,
+				DBUS_TYPE_BOOLEAN, &optional,
 				DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
@@ -547,12 +535,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (owner != NULL)
 		return btd_error_not_authorized(msg);
 
-	lock = str2lock(accesstype);
-	if (lock == 0)
-		return btd_error_invalid_args(msg);
-
-	if (transport->state != TRANSPORT_STATE_PENDING &&
-				g_strstr_len(accesstype, -1, "?") != NULL)
+	if (transport->state != TRANSPORT_STATE_PENDING && optional)
 		return btd_error_failed(msg, "Transport not playing");
 
 	if (media_transport_acquire(transport, lock) == FALSE)
@@ -578,14 +561,9 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner;
-	const char *accesstype, *sender;
-	transport_lock_t lock;
+	const char *sender;
 	struct media_request *req;
-
-	if (!dbus_message_get_args(msg, NULL,
-				DBUS_TYPE_STRING, &accesstype,
-				DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
+	transport_lock_t lock = TRANSPORT_LOCK_READ | TRANSPORT_LOCK_WRITE;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -593,8 +571,6 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (owner == NULL)
 		return btd_error_not_authorized(msg);
 
-	lock = str2lock(accesstype);
-
 	if (owner->lock == lock) {
 		guint id;
 
@@ -764,13 +740,11 @@ static void set_volume(const GDBusPropertyTable *property,
 
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
-			GDBUS_ARGS({ "access_type", "s" }),
+			GDBUS_ARGS({ "optional", "b" }),
 			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
 							{ "mtu_w", "q" } ),
 			acquire) },
-	{ GDBUS_ASYNC_METHOD("Release",
-			GDBUS_ARGS({ "access_type", "s" }), NULL,
-			release ) },
+	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
 	{ },
 };
 
-- 
1.7.11.7

