Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 1/9] media: Fix accesstype comparison
Date: Fri, 14 Sep 2012 14:03:08 +0200
Message-Id: <1347624196-11281-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Replace the string representation of the accesstype with a conventional
binary representation. This makes the code simpler and more efficient.

This also fixes a minor bug in the Release() D-Bus method, where the
string comparison was used to see whether the owner should be removed. A
client acquiring with "rw" and releasing with "wr" would lead to the
inconsistent state of having a released transport with an owner with no
accesstype. Partial releases can also get affected by this bug since the
released character (partial accesstype) got replaced by a whitespace.

Additionally, this approach is more robust in case new flags are added
in the future.
---
 audio/transport.c |  119 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 68 insertions(+), 51 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index d40c92d..d418878 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -49,6 +49,11 @@
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
 
+typedef enum {
+	TRANSPORT_LOCK_READ = 1,
+	TRANSPORT_LOCK_WRITE = 1 << 1,
+} transport_lock_t;
+
 struct media_request {
 	DBusMessage		*msg;
 	guint			id;
@@ -58,7 +63,7 @@ struct media_owner {
 	struct media_transport	*transport;
 	struct media_request	*pending;
 	char			*name;
-	char			*accesstype;
+	transport_lock_t	lock;
 	guint			watch;
 };
 
@@ -84,8 +89,7 @@ struct media_transport {
 	int			fd;		/* Transport file descriptor */
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
-	gboolean		read_lock;
-	gboolean		write_lock;
+	transport_lock_t	lock;
 	gboolean		in_use;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
@@ -104,6 +108,31 @@ struct media_transport {
 	void			*data;
 };
 
+static const char *lock2str(transport_lock_t lock)
+{
+	if (lock == 0)
+		return "";
+	else if (lock == TRANSPORT_LOCK_READ)
+		return "r";
+	else if (lock == TRANSPORT_LOCK_WRITE)
+		return "w";
+	else
+		return "rw";
+}
+
+static transport_lock_t str2lock(const char *str)
+{
+	transport_lock_t lock = 0;
+
+	if (g_strstr_len(str, -1, "r") != NULL)
+		lock |= TRANSPORT_LOCK_READ;
+
+	if (g_strstr_len(str, -1, "w") != NULL)
+		lock |= TRANSPORT_LOCK_WRITE;
+
+	return lock;
+}
+
 void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
@@ -148,17 +177,15 @@ static void media_request_reply(struct media_request *req,
 }
 
 static gboolean media_transport_release(struct media_transport *transport,
-					const char *accesstype)
+							transport_lock_t lock)
 {
-	if (g_strstr_len(accesstype, -1, "r") != NULL) {
-		transport->read_lock = FALSE;
+	transport->lock &= ~lock;
+
+	if (lock & TRANSPORT_LOCK_READ)
 		DBG("Transport %s: read lock released", transport->path);
-	}
 
-	if (g_strstr_len(accesstype, -1, "w") != NULL) {
-		transport->write_lock = FALSE;
+	if (lock & TRANSPORT_LOCK_WRITE)
 		DBG("Transport %s: write lock released", transport->path);
-	}
 
 	return TRUE;
 }
@@ -191,7 +218,6 @@ static void media_owner_free(struct media_owner *owner)
 	media_owner_remove(owner);
 
 	g_free(owner->name);
-	g_free(owner->accesstype);
 	g_free(owner);
 }
 
@@ -200,7 +226,7 @@ static void media_transport_remove(struct media_transport *transport,
 {
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 
-	media_transport_release(transport, owner->accesstype);
+	media_transport_release(transport, owner->lock);
 
 	/* Reply if owner has a pending request */
 	if (owner->pending)
@@ -260,10 +286,10 @@ static void a2dp_resume_complete(struct avdtp *session,
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
 
-	if (g_strstr_len(owner->accesstype, -1, "r") == NULL)
+	if ((owner->lock & TRANSPORT_LOCK_READ) == 0)
 		imtu = 0;
 
-	if (g_strstr_len(owner->accesstype, -1, "w") == NULL)
+	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
 		omtu = 0;
 
 	ret = g_dbus_send_reply(transport->conn, req->msg,
@@ -371,10 +397,10 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
 
-	if (g_strstr_len(owner->accesstype, -1, "r") == NULL)
+	if ((owner->lock & TRANSPORT_LOCK_READ) == 0)
 		imtu = 0;
 
-	if (g_strstr_len(owner->accesstype, -1, "w") == NULL)
+	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
 		omtu = 0;
 
 	ret = g_dbus_send_reply(transport->conn, req->msg,
@@ -476,10 +502,10 @@ static void gateway_resume_complete(struct audio_device *dev, GError *err,
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
 
-	if (g_strstr_len(owner->accesstype, -1, "r") == NULL)
+	if ((owner->lock & TRANSPORT_LOCK_READ) == 0)
 		imtu = 0;
 
-	if (g_strstr_len(owner->accesstype, -1, "w") == NULL)
+	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
 		omtu = 0;
 
 	ret = g_dbus_send_reply(transport->conn, req->msg,
@@ -569,35 +595,18 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 }
 
 static gboolean media_transport_acquire(struct media_transport *transport,
-							const char *accesstype)
+							transport_lock_t lock)
 {
-	gboolean read_lock = FALSE, write_lock = FALSE;
-
-	if (g_strstr_len(accesstype, -1, "r") != NULL) {
-		if (transport->read_lock == TRUE)
-			return FALSE;
-		read_lock = TRUE;
-	}
-
-	if (g_strstr_len(accesstype, -1, "w") != NULL) {
-		if (transport->write_lock == TRUE)
-			return FALSE;
-		write_lock = TRUE;
-	}
-
-	/* Check invalid accesstype */
-	if (read_lock == FALSE && write_lock == FALSE)
+	if (transport->lock & lock)
 		return FALSE;
 
-	if (read_lock) {
-		transport->read_lock = read_lock;
+	transport->lock |= lock;
+
+	if (lock & TRANSPORT_LOCK_READ)
 		DBG("Transport %s: read lock acquired", transport->path);
-	}
 
-	if (write_lock) {
-		transport->write_lock = write_lock;
+	if (lock & TRANSPORT_LOCK_WRITE)
 		DBG("Transport %s: write lock acquired", transport->path);
-	}
 
 
 	return TRUE;
@@ -616,16 +625,16 @@ static void media_transport_add(struct media_transport *transport,
 
 static struct media_owner *media_owner_create(DBusConnection *conn,
 						DBusMessage *msg,
-						const char *accesstype)
+						transport_lock_t lock)
 {
 	struct media_owner *owner;
 
 	owner = g_new0(struct media_owner, 1);
 	owner->name = g_strdup(dbus_message_get_sender(msg));
-	owner->accesstype = g_strdup(accesstype);
+	owner->lock = lock;
 
 	DBG("Owner created: sender=%s accesstype=%s", owner->name,
-			accesstype);
+							lock2str(lock));
 
 	return owner;
 }
@@ -662,6 +671,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	struct media_owner *owner;
 	struct media_request *req;
 	const char *accesstype, *sender;
+	transport_lock_t lock;
 	guint id;
 
 	if (!dbus_message_get_args(msg, NULL,
@@ -675,13 +685,17 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (owner != NULL)
 		return btd_error_not_authorized(msg);
 
-	if (media_transport_acquire(transport, accesstype) == FALSE)
+	lock = str2lock(accesstype);
+	if (lock == 0)
+		return btd_error_invalid_args(msg);
+
+	if (media_transport_acquire(transport, lock) == FALSE)
 		return btd_error_not_authorized(msg);
 
-	owner = media_owner_create(conn, msg, accesstype);
+	owner = media_owner_create(conn, msg, lock);
 	id = transport->resume(transport, owner);
 	if (id == 0) {
-		media_transport_release(transport, accesstype);
+		media_transport_release(transport, lock);
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
@@ -699,6 +713,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	struct media_transport *transport = data;
 	struct media_owner *owner;
 	const char *accesstype, *sender;
+	transport_lock_t lock;
 	struct media_request *req;
 
 	if (!dbus_message_get_args(msg, NULL,
@@ -712,7 +727,9 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (owner == NULL)
 		return btd_error_not_authorized(msg);
 
-	if (g_strcmp0(owner->accesstype, accesstype) == 0) {
+	lock = str2lock(accesstype);
+
+	if (owner->lock == lock) {
 		guint id;
 
 		/* Not the last owner, no need to suspend */
@@ -742,9 +759,9 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 		media_owner_add(owner, req);
 
 		return NULL;
-	} else if (g_strstr_len(owner->accesstype, -1, accesstype) != NULL) {
-		media_transport_release(transport, accesstype);
-		g_strdelimit(owner->accesstype, accesstype, ' ');
+	} else if ((owner->lock & lock) == lock) {
+		media_transport_release(transport, lock);
+		owner->lock &= ~lock;
 	} else
 		return btd_error_not_authorized(msg);
 
-- 
1.7.7.6

