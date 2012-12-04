Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 2/3] media: Remove internal transport locks
Date: Tue,  4 Dec 2012 18:13:49 +0100
Message-Id: <1354641230-3667-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354641230-3667-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354641230-3667-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The internal transport_lock_t is not needed any more since transports
are now always acquired with read and write permissions.
---
 profiles/audio/transport.c | 134 ++++++++++-----------------------------------
 1 file changed, 30 insertions(+), 104 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5924f73..ad9270e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -51,11 +51,6 @@
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
 
 typedef enum {
-	TRANSPORT_LOCK_READ = 1,
-	TRANSPORT_LOCK_WRITE = 1 << 1,
-} transport_lock_t;
-
-typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
@@ -80,7 +75,6 @@ struct media_owner {
 	struct media_transport	*transport;
 	struct media_request	*pending;
 	char			*name;
-	transport_lock_t	lock;
 	guint			watch;
 };
 
@@ -100,7 +94,6 @@ struct media_transport {
 	int			fd;		/* Transport file descriptor */
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
-	transport_lock_t	lock;
 	transport_state_t	state;
 	guint			hs_watch;
 	guint			source_watch;
@@ -115,18 +108,6 @@ struct media_transport {
 	void			*data;
 };
 
-static const char *lock2str(transport_lock_t lock)
-{
-	if (lock == 0)
-		return "";
-	else if (lock == TRANSPORT_LOCK_READ)
-		return "r";
-	else if (lock == TRANSPORT_LOCK_WRITE)
-		return "w";
-	else
-		return "rw";
-}
-
 static const char *state2str(transport_state_t state)
 {
 	switch (state) {
@@ -229,20 +210,6 @@ static void media_request_reply(struct media_request *req, int err)
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
-static gboolean media_transport_release(struct media_transport *transport,
-							transport_lock_t lock)
-{
-	transport->lock &= ~lock;
-
-	if (lock & TRANSPORT_LOCK_READ)
-		DBG("Transport %s: read lock released", transport->path);
-
-	if (lock & TRANSPORT_LOCK_WRITE)
-		DBG("Transport %s: write lock released", transport->path);
-
-	return TRUE;
-}
-
 static void media_owner_remove(struct media_owner *owner)
 {
 	struct media_transport *transport = owner->transport;
@@ -279,8 +246,6 @@ static void media_transport_remove(struct media_transport *transport,
 {
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 
-	media_transport_release(transport, owner->lock);
-
 	/* Reply if owner has a pending request */
 	if (owner->pending)
 		media_request_reply(owner->pending, EIO);
@@ -339,12 +304,6 @@ static void a2dp_resume_complete(struct avdtp *session,
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
 
-	if ((owner->lock & TRANSPORT_LOCK_READ) == 0)
-		imtu = 0;
-
-	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
-		omtu = 0;
-
 	ret = g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
 						DBUS_TYPE_UNIX_FD, &fd,
 						DBUS_TYPE_UINT16, &imtu,
@@ -443,24 +402,6 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 	media_transport_remove(owner->transport, owner);
 }
 
-static gboolean media_transport_acquire(struct media_transport *transport,
-							transport_lock_t lock)
-{
-	if (transport->lock & lock)
-		return FALSE;
-
-	transport->lock |= lock;
-
-	if (lock & TRANSPORT_LOCK_READ)
-		DBG("Transport %s: read lock acquired", transport->path);
-
-	if (lock & TRANSPORT_LOCK_WRITE)
-		DBG("Transport %s: write lock acquired", transport->path);
-
-
-	return TRUE;
-}
-
 static void media_transport_add(struct media_transport *transport,
 					struct media_owner *owner)
 {
@@ -473,17 +414,14 @@ static void media_transport_add(struct media_transport *transport,
 							owner, NULL);
 }
 
-static struct media_owner *media_owner_create(DBusMessage *msg,
-						transport_lock_t lock)
+static struct media_owner *media_owner_create(DBusMessage *msg)
 {
 	struct media_owner *owner;
 
 	owner = g_new0(struct media_owner, 1);
 	owner->name = g_strdup(dbus_message_get_sender(msg));
-	owner->lock = lock;
 
-	DBG("Owner created: sender=%s accesstype=%s", owner->name,
-							lock2str(lock));
+	DBG("Owner created: sender=%s", owner->name);
 
 	return owner;
 }
@@ -522,7 +460,6 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	const char *sender;
 	dbus_bool_t optional;
 	guint id;
-	transport_lock_t lock = TRANSPORT_LOCK_READ | TRANSPORT_LOCK_WRITE;
 
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_BOOLEAN, &optional,
@@ -535,16 +472,15 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (owner != NULL)
 		return btd_error_not_authorized(msg);
 
+	if (transport->state >= TRANSPORT_STATE_REQUESTING)
+		return btd_error_not_authorized(msg);
+
 	if (transport->state != TRANSPORT_STATE_PENDING && optional)
 		return btd_error_failed(msg, "Transport not playing");
 
-	if (media_transport_acquire(transport, lock) == FALSE)
-		return btd_error_not_authorized(msg);
-
-	owner = media_owner_create(msg, lock);
+	owner = media_owner_create(msg);
 	id = transport->resume(transport, owner);
 	if (id == 0) {
-		media_transport_release(transport, lock);
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
@@ -563,7 +499,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	struct media_owner *owner;
 	const char *sender;
 	struct media_request *req;
-	transport_lock_t lock = TRANSPORT_LOCK_READ | TRANSPORT_LOCK_WRITE;
+	guint id;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -571,45 +507,35 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (owner == NULL)
 		return btd_error_not_authorized(msg);
 
-	if (owner->lock == lock) {
-		guint id;
-
-		/* Not the last owner, no need to suspend */
-		if (g_slist_length(transport->owners) != 1) {
-			media_transport_remove(transport, owner);
-			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-		}
-
-		if (owner->pending) {
-			const char *member;
+	/* Not the last owner, no need to suspend */
+	if (g_slist_length(transport->owners) != 1) {
+		media_transport_remove(transport, owner);
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
 
-			member = dbus_message_get_member(owner->pending->msg);
-			/* Cancel Acquire request if that exist */
-			if (g_str_equal(member, "Acquire"))
-				media_owner_remove(owner);
-			else
-				return btd_error_in_progress(msg);
-		}
+	if (owner->pending) {
+		const char *member;
 
-		transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
+		member = dbus_message_get_member(owner->pending->msg);
+		/* Cancel Acquire request if that exist */
+		if (g_str_equal(member, "Acquire"))
+			media_owner_remove(owner);
+		else
+			return btd_error_in_progress(msg);
+	}
 
-		id = transport->suspend(transport, owner);
-		if (id == 0) {
-			media_transport_remove(transport, owner);
-			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-		}
+	transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
 
-		req = media_request_create(msg, id);
-		media_owner_add(owner, req);
+	id = transport->suspend(transport, owner);
+	if (id == 0) {
+		media_transport_remove(transport, owner);
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
 
-		return NULL;
-	} else if ((owner->lock & lock) == lock) {
-		media_transport_release(transport, lock);
-		owner->lock &= ~lock;
-	} else
-		return btd_error_not_authorized(msg);
+	req = media_request_create(msg, id);
+	media_owner_add(owner, req);
 
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	return NULL;
 }
 
 static gboolean get_device(const GDBusPropertyTable *property,
-- 
1.7.11.7

