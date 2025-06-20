Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B186289E05
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419571; cv=none; b=HUvyi8u4fGEqOy08UVMlhua7OJYU3BlCtHxDX0vDYb3Eg1GbPuHhkRAyQsgBLsyyU6sYLD2NTngt9iksFbYt9HgLt6xn7MfIBkmH7YE0chrOpBpR+5dnH+OwAC4hEp4n+zU9ivT9VeMaq3hGaO0CzAJH6/WMcMP+BLczcKXHWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419571; c=relaxed/simple;
	bh=iAqA8YjbhlO1UZz3Ql5Nd/cAzinmaYMGsONAovFA6iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgpBo8ItldXwFPPXXlE1LuNKXyCoOsJcf4dYPo/S4/X2fTljdxVkU1uofRZ7q6LXJRcZbftcHQT/KCSQnpCsRiuCCHLCJqSIo6JvczJps4yh6k4NV86/ObvskotBXNDvLQVcFPSzKMAAQvngrEHcYLvr+zepnJBwLMmYK0e0y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 4.4.d.4.e.7.9.1.e.7.4.6.0.d.5.7.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:75d0:647e:197e:4d44] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uSa5Z-004gdY-1e;
	Fri, 20 Jun 2025 12:39:21 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ RFC] Refactor uid_state handling
Date: Fri, 20 Jun 2025 12:31:52 +0100
Message-ID: <20250620113854.2389729-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We talked recently about refactoring logind.{c,h} to fit more neatly
into the program's wider architecture.  This patch sketches out a
possible approach.  It compiles, but has not been tested beyond that.
If I'm on the right track, I'll come back with a proper solution.

The old API provided callbacks on high-level "init" and "exit" events.
That made sense for the limited case it was used for, but seems
unlikely to scale if this starts picking up more use cases.  So the
RFC API just provides a single event that passes a `logind_cb_context`
struct to callbacks, and provides `LOGIND_USER_IS_ACTIVE(ctxt)` to
replicate the old behaviour.

The old API invited individual transports/drivers to use it directly,
which again made sense for version 1, but bypassed `transport.h` and
`driver.h`.  The RFC API registers callbacks with `driver.h` and
`transport.h` in a more normal way, and they pass `logind_cb_context`
straight through to the callbacks.  That means we won't need to do
much refactoring if the struct changes some day, but also means
individual transports/drivers need to know about `logind.h`.
The alternative would look something like this:

--- obexd/client/driver.h
+++ obexd/client/driver.h
struct obc_driver {
	const char *service;
	const char *uuid;
	void *target;
	gsize target_len;
	void *(*supported_features) (struct obc_session *session);
	int (*probe) (struct obc_session *session);
	void (*remove) (struct obc_session *session);
+	int (*uid_state) (const char *state, const int seats);
};
--- obexd/client/driver.c
+++ obexd/client/driver.c
+static void call_cb(gpointer data, gpointer ctxt_)
+{
+	struct obc_driver *driver = (struct obc_driver *)data;
+	struct logind_cb_context *ctxt = (struct logind_cb_context *)ctxt_;
+	if (driver->uid_state) {
+		ctxt->res |= driver->uid_state(ctxt->state, ctxt->seats);
+	}
+}

That would have a better best case (fewer `#include logind.h`s strewn
throughout the code) but a worse worst case (bigger refactoring job if
we need to pass an extra argument some day).  I think the RFC patch is
a better balance of risks, but am happy either way.

The RFC patches for `pbap.c` and `bluetooth.c` are designed to show
the difference between the old and new API.  A proper patch will
probably get rid of the `_cb()`, `_init()` and `_exit()` functions.

Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/client/driver.c     |  18 +++++
 obexd/client/driver.h     |   5 ++
 obexd/client/pbap.c       |  62 ++++++++++------
 obexd/plugins/bluetooth.c |  30 ++++++--
 obexd/src/logind.c        | 152 ++++++++++++++++++--------------------
 obexd/src/logind.h        |  59 ++++++++++++---
 obexd/src/main.c          |  12 +++
 obexd/src/transport.c     |  17 +++++
 obexd/src/transport.h     |   5 ++
 9 files changed, 237 insertions(+), 123 deletions(-)

diff --git a/obexd/client/driver.c b/obexd/client/driver.c
index 195cdd2f1..d5d0fe2ab 100644
--- a/obexd/client/driver.c
+++ b/obexd/client/driver.c
@@ -74,3 +74,21 @@ void obc_driver_unregister(struct obc_driver *driver)
 
 	drivers = g_slist_remove(drivers, driver);
 }
+
+static void call_cb(gpointer data, gpointer ctxt)
+{
+	struct obc_driver *driver = (struct obc_driver *)data;
+
+	if (driver->uid_state)
+		driver->uid_state(((struct logind_cb_context *)ctxt));
+}
+
+static void call_uid_state_cb(gpointer ctxt)
+{
+	g_slist_foreach(drivers, call_cb, ctxt);
+}
+
+gboolean obc_driver_init(void)
+{
+	return logind_register(call_uid_state_cb) >= 0;
+}
diff --git a/obexd/client/driver.h b/obexd/client/driver.h
index cc4cace7b..928c0c558 100644
--- a/obexd/client/driver.h
+++ b/obexd/client/driver.h
@@ -8,6 +8,9 @@
  *
  */
 
+#include "obexd/src/logind.h"
+struct obc_session;
+
 struct obc_driver {
 	const char *service;
 	const char *uuid;
@@ -16,8 +19,10 @@ struct obc_driver {
 	void *(*supported_features) (struct obc_session *session);
 	int (*probe) (struct obc_session *session);
 	void (*remove) (struct obc_session *session);
+	void (*uid_state) (struct logind_cb_context *ctxt);
 };
 
 int obc_driver_register(struct obc_driver *driver);
 void obc_driver_unregister(struct obc_driver *driver);
 struct obc_driver *obc_driver_find(const char *pattern);
+gboolean obc_driver_init(void);
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 78c46bf86..dc2a519e5 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -146,6 +146,9 @@ static DBusConnection *system_conn;
 static unsigned int listener_id;
 static char *client_path;
 
+static int pbap_init_cb(void);
+static void pbap_exit_cb(void);
+
 static struct pending_request *pending_request_new(struct pbap_data *pbap,
 							DBusMessage *message)
 {
@@ -1300,6 +1303,20 @@ static void pbap_remove(struct obc_session *session)
 	g_dbus_unregister_interface(conn, path, PBAP_INTERFACE);
 }
 
+static gboolean user_was_active = FALSE;
+static void pbap_uid_state(struct logind_cb_context *ctxt)
+{
+	gboolean user_is_active = LOGIND_USER_IS_ACTIVE(ctxt);
+
+	if (user_was_active == user_is_active)
+		return;
+	user_was_active = user_is_active;
+	if (user_is_active)
+		pbap_init_cb();
+	else
+		pbap_exit_cb();
+}
+
 static DBusMessage *pbap_release(DBusConnection *conn,
 	DBusMessage *msg, void *data)
 {
@@ -1452,13 +1469,13 @@ static struct obc_driver pbap = {
 	.target_len = OBEX_PBAP_UUID_LEN,
 	.supported_features = pbap_supported_features,
 	.probe = pbap_probe,
-	.remove = pbap_remove
+	.remove = pbap_remove,
+	.uid_state = pbap_uid_state
 };
 
-static int pbap_init_cb(gboolean at_register)
+static int pbap_init_cb(void)
 {
 	int err;
-	(void)at_register;
 
 	DBG("");
 
@@ -1483,7 +1500,7 @@ static int pbap_init_cb(gboolean at_register)
 	return 0;
 }
 
-static void pbap_exit_cb(gboolean at_unregister)
+static void pbap_exit_cb(void)
 {
 	DBusMessage *msg;
 	DBusMessageIter iter;
@@ -1491,22 +1508,28 @@ static void pbap_exit_cb(gboolean at_unregister)
 
 	DBG("");
 
-	if (!at_unregister) {
-		client_path = g_strconcat("/org/bluez/obex/", uuid, NULL);
-		g_strdelimit(client_path, "-", '_');
+	client_path = g_strconcat("/org/bluez/obex/", uuid, NULL);
+	g_strdelimit(client_path, "-", '_');
 
-		msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
-							"org.bluez.ProfileManager1",
-							"UnregisterProfile");
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+						"org.bluez.ProfileManager1",
+						"UnregisterProfile");
 
-		dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_init_append(msg, &iter);
 
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
-								&client_path);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&client_path);
 
-		g_dbus_send_message(system_conn, msg);
-	}
+	g_dbus_send_message(system_conn, msg);
 
+	pbap_exit();
+}
+
+int pbap_init(void)
+{
+}
+void pbap_exit(void)
+{
 	g_dbus_remove_watch(system_conn, listener_id);
 
 	unregister_profile();
@@ -1524,12 +1547,3 @@ static void pbap_exit_cb(gboolean at_unregister)
 
 	obc_driver_unregister(&pbap);
 }
-
-int pbap_init(void)
-{
-	return logind_register(pbap_init_cb, pbap_exit_cb);
-}
-void pbap_exit(void)
-{
-	return logind_unregister(pbap_init_cb, pbap_exit_cb);
-}
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 355921479..ebff88db3 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -57,6 +57,9 @@ static DBusMessage *profile_release(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static int bluetooth_init_cb(void);
+static void bluetooth_exit_cb(void);
+
 static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
 	int sk = g_io_channel_unix_get_fd(io);
@@ -381,6 +384,20 @@ static void bluetooth_stop(void *data)
 	profiles = NULL;
 }
 
+static gboolean user_was_active = FALSE;
+static void bluetooth_uid_state(struct logind_cb_context *ctxt)
+{
+	gboolean user_is_active = LOGIND_USER_IS_ACTIVE(ctxt);
+
+	if (user_was_active == user_is_active)
+		return;
+	user_was_active = user_is_active;
+	if (user_is_active)
+		bluetooth_init_cb();
+	else
+		bluetooth_exit_cb();
+}
+
 static int bluetooth_getpeername(GIOChannel *io, char **name)
 {
 	GError *gerr = NULL;
@@ -422,14 +439,14 @@ static const struct obex_transport_driver driver = {
 	.start = bluetooth_start,
 	.getpeername = bluetooth_getpeername,
 	.getsockname = bluetooth_getsockname,
-	.stop = bluetooth_stop
+	.stop = bluetooth_stop,
+	.uid_state = bluetooth_uid_state
 };
 
 static unsigned int listener_id = 0;
 
-static int bluetooth_init_cb(gboolean at_register)
+static int bluetooth_init_cb(void)
 {
-	(void)at_register;
 	connection = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (connection == NULL)
 		return -EPERM;
@@ -440,10 +457,9 @@ static int bluetooth_init_cb(gboolean at_register)
 	return obex_transport_driver_register(&driver);
 }
 
-static void bluetooth_exit_cb(gboolean at_unregister)
+static void bluetooth_exit_cb(void)
 {
 	GSList *l;
-	(void)at_unregister;
 
 	g_dbus_remove_watch(connection, listener_id);
 
@@ -467,11 +483,11 @@ static void bluetooth_exit_cb(gboolean at_unregister)
 
 static int bluetooth_init(void)
 {
-	return logind_register(bluetooth_init_cb, bluetooth_exit_cb);
 }
 static void bluetooth_exit(void)
 {
-	return logind_unregister(bluetooth_init_cb, bluetooth_exit_cb);
+	if (user_was_active)
+		bluetooth_exit_cb();
 }
 
 OBEX_PLUGIN_DEFINE(bluetooth, bluetooth_init, bluetooth_exit)
diff --git a/obexd/src/logind.c b/obexd/src/logind.c
index b4279b209..a8ea25543 100644
--- a/obexd/src/logind.c
+++ b/obexd/src/logind.c
@@ -27,66 +27,48 @@
 
 static sd_login_monitor * monitor;
 static int uid;
-static gboolean active = FALSE;
 static gboolean monitoring_enabled = TRUE;
 static guint event_source;
 static guint timeout_source;
 
-struct callback_pair {
-	logind_init_cb init_cb;
-	logind_exit_cb exit_cb;
-};
-
 GSList *callbacks;
 
-static void call_init_cb(gpointer data, gpointer user_data)
-{
-	int res;
-
-	res = ((struct callback_pair *)data)->init_cb(FALSE);
-	if (res)
-		*(int *)user_data = res;
-}
-static void call_exit_cb(gpointer data, gpointer user_data)
+static void call_cb(gpointer data, gpointer user_data)
 {
-	((struct callback_pair *)data)->exit_cb(FALSE);
+	(*((logind_cb *)data))(user_data);
 }
 
-static int update(void)
+static void logind_cb_context_init(struct logind_cb_context *ctxt)
 {
-	char *state = NULL;
-	gboolean state_is_active;
-	int res;
-
-	res = sd_login_monitor_flush(monitor);
-	if (res < 0)
-		return res;
-	res = sd_uid_get_state(uid, &state);
-	state_is_active = g_strcmp0(state, "active");
-	free(state);
-	if (res < 0)
-		return res;
-
-	if (state_is_active) {
-		if (!active)
-			return 0;
-	} else {
-		res = sd_uid_get_seats(uid, 1, NULL);
-		if (res < 0)
-			return res;
-		if (active == !!res)
-			return 0;
+	ctxt->res = sd_login_monitor_flush(monitor);
+	if (ctxt->res < 0)
+		return;
+
+	ctxt->res = ctxt->seats = sd_uid_get_seats(uid, 1, NULL);
+	if (ctxt->res < 0)
+		return;
+
+	/*
+	 * the documentation for sd_uid_get_state() isn't clear about
+	 * what to do with the state on error.  The following should
+	 * be safe even if the behaviour changes in future
+	 */
+	ctxt->state = 0;
+	ctxt->res = sd_uid_get_state(uid, (char **)&ctxt->state);
+	if (ctxt->res <= 0) {
+		free((char *)ctxt->state);
+		return;
 	}
-	active ^= TRUE;
-	res = 0;
-	g_slist_foreach(callbacks, active ? call_init_cb : call_exit_cb, &res);
-	return res;
+
+	ctxt->res = 0;
+	return;
 }
 
 static gboolean timeout_handler(gpointer user_data);
 
 static int check_event(void)
 {
+	struct logind_cb_context ctxt;
 	uint64_t timeout_usec;
 	int res;
 
@@ -95,9 +77,14 @@ static int check_event(void)
 		return res;
 	if (!monitoring_enabled)
 		return 0;
-	res = update();
-	if (res < 0)
-		return res;
+
+	logind_cb_context_init(&ctxt);
+	if (ctxt.res)
+		return ctxt.res;
+	g_slist_foreach(callbacks, call_cb, &ctxt);
+	free((char *)ctxt.state);
+	if (ctxt.res)
+		return ctxt.res;
 
 	res = sd_login_monitor_get_timeout(monitor, &timeout_usec);
 	if (res < 0)
@@ -154,6 +141,7 @@ static gboolean timeout_handler(gpointer user_data)
 
 static int logind_init(void)
 {
+	struct logind_cb_context ctxt;
 	GIOChannel *channel;
 	int events;
 	int fd;
@@ -174,11 +162,6 @@ static int logind_init(void)
 		goto FAIL;
 	}
 
-	// Check this after creating the monitor, in case of race conditions:
-	res = update();
-	if (res < 0)
-		goto FAIL;
-
 	events = res = sd_login_monitor_get_events(monitor);
 	if (res < 0)
 		goto FAIL;
@@ -202,7 +185,10 @@ static int logind_init(void)
 FAIL:
 	sd_login_monitor_unref(monitor);
 	monitoring_enabled = FALSE;
-	active = TRUE;
+	ctxt.state = "active";
+	ctxt.seats = 1;
+	ctxt.res = 0;
+	g_slist_foreach(callbacks, call_cb, &ctxt);
 	return res;
 }
 
@@ -219,17 +205,18 @@ static void logind_exit(void)
 	sd_login_monitor_unref(monitor);
 }
 
-static gint find_cb(gconstpointer a, gconstpointer b)
+int logind_register(logind_cb cb)
 {
-	return ((struct callback_pair *)a)->init_cb - (logind_init_cb)b;
-}
+	struct logind_cb_context ctxt;
 
-int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
-{
-	struct callback_pair *cbs;
+	logind_cb_context_init(&ctxt);
+	if (ctxt.res) {
+		free((char *)ctxt.state);
+		return ctxt.res;
+	}
 
 	if (!monitoring_enabled)
-		return init_cb(TRUE);
+		goto CALL_CB;
 	if (callbacks == NULL) {
 		int res;
 
@@ -237,24 +224,23 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
 		if (res) {
 			error("logind_init(): %s - login detection disabled",
 				strerror(-res));
-			return init_cb(TRUE);
+			goto CALL_CB;
 		}
 	}
-	cbs = g_new(struct callback_pair, 1);
-	cbs->init_cb = init_cb;
-	cbs->exit_cb = exit_cb;
-	callbacks = g_slist_prepend(callbacks, cbs);
-	return active ? init_cb(TRUE) : 0;
+	callbacks = g_slist_prepend(callbacks, cb);
+
+CALL_CB:
+	cb(&ctxt);
+	free((char *)ctxt.state);
+	return ctxt.res;
 }
-void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
+void logind_unregister(logind_cb cb)
 {
 	GSList *cb_node;
 
 	if (!monitoring_enabled)
-		return exit_cb(TRUE);
-	if (active)
-		exit_cb(TRUE);
-	cb_node = g_slist_find_custom(callbacks, init_cb, find_cb);
+		return;
+	cb_node = g_slist_find(callbacks, cb);
 	if (cb_node != NULL)
 		callbacks = g_slist_delete_link(callbacks, cb_node);
 	if (callbacks == NULL)
@@ -263,20 +249,26 @@ void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
 
 int logind_set(gboolean enabled)
 {
-	int res = 0;
-
-	if (monitoring_enabled == enabled)
-		return 0;
-
 	monitoring_enabled = enabled;
 	if (enabled) {
-		active = FALSE;
-		return update();
+		struct logind_cb_context ctxt;
+
+		logind_cb_context_init(&ctxt);
+		if (ctxt.res)
+			return ctxt.res;
+		g_slist_foreach(callbacks, call_cb, &ctxt);
+		free((char *)ctxt.state);
+		return ctxt.res;
 	}
 
-	active = TRUE;
-	g_slist_foreach(callbacks, call_exit_cb, &res);
-	return res;
+	struct logind_cb_context ctxt = {
+		.state = "active",
+		.seats = 1,
+		.res = 0
+	};
+
+	g_slist_foreach(callbacks, call_cb, &ctxt);
+	return ctxt.res;
 }
 
 #endif
diff --git a/obexd/src/logind.h b/obexd/src/logind.h
index 3cdb03338..243aa17bd 100644
--- a/obexd/src/logind.h
+++ b/obexd/src/logind.h
@@ -8,30 +8,65 @@
  *
  */
 
-typedef int (*logind_init_cb)(gboolean at_register);
-typedef void (*logind_exit_cb)(gboolean at_unregister);
+#ifndef OBEXD_SRC_LOGIND_H
+#define OBEXD_SRC_LOGIND_H
+
+struct logind_cb_context {
+	const char *state;
+	int seats;
+	int res;
+};
+
+typedef void (*logind_cb)(gpointer ctxt);
 
 #ifdef SYSTEMD
 
-int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb);
-void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb);
+/*
+ * Register callback and call it with the current state
+ */
+int logind_register(logind_cb init_cb);
+/*
+ * Unregister callback but DO NOT call it -
+ * unregistration usually happens when the user is logging out,
+ * and other programs are going away.
+ *
+ * If possible, close resources at exit instead of at unregister.
+ * Otherwise, you will need to explicitly call your callback.
+ */
+void logind_unregister(logind_cb cb);
+/*
+ * Override the detected login state
+ */
 int logind_set(gboolean enabled);
 
-#else
+/* Recommended way to detect (in)activity */
+#define LOGIND_USER_IS_ACTIVE(ctxt) \
+	(!g_strcmp0(ctxt->state, "active") && !!(ctxt->seats))
 
-static inline int logind_register(logind_init_cb init_cb,
-					logind_exit_cb exit_cb)
+#else /* SYSTEMD */
+
+static inline int logind_register(logind_cb cb)
 {
-	return init_cb(TRUE);
+	(void)cb;
+	struct logind_cb_context ctxt = {
+		.state = "active",
+		.seats = 1,
+		.res = 0
+	};
+	cb(&ctxt);
+	return ctxt.res;
 }
-static inline void logind_unregister(logind_init_cb init_cb,
-					logind_exit_cb exit_cb)
+static inline void logind_unregister(logind_cb cb)
 {
-	return exit_cb(TRUE);
+	(void)cb;
 }
 static inline int logind_set(gboolean enabled)
 {
 	return 0;
 }
 
-#endif
+#define LOGIND_USER_IS_ACTIVE(...) 1
+
+#endif /* SYSTEMD */
+
+#endif /* OBEXD_SRC_LOGIND_H */
diff --git a/obexd/src/main.c b/obexd/src/main.c
index 6837f0d73..116888a78 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -34,6 +34,9 @@
 
 #include "../client/manager.h"
 
+#include "../client/driver.h"
+#include "transport.h"
+
 #include "log.h"
 #include "logind.h"
 #include "obexd.h"
@@ -279,6 +282,15 @@ int main(int argc, char *argv[])
 	if (option_system_bus)
 		logind_set(FALSE);
 
+	if (obc_driver_init() == FALSE) {
+		error("manager_init failed");
+		exit(EXIT_FAILURE);
+	}
+	if (obex_transport_driver_init() == FALSE) {
+		error("manager_init failed");
+		exit(EXIT_FAILURE);
+	}
+
 	DBG("Entering main loop");
 
 	main_loop = g_main_loop_new(NULL, FALSE);
diff --git a/obexd/src/transport.c b/obexd/src/transport.c
index 527d9ffce..fdd49b7a2 100644
--- a/obexd/src/transport.c
+++ b/obexd/src/transport.c
@@ -79,3 +79,20 @@ obex_transport_driver_unregister(const struct obex_transport_driver *driver)
 
 	drivers = g_slist_remove(drivers, driver);
 }
+
+static void call_cb(gpointer data, gpointer ctxt)
+{
+	struct obex_transport_driver *driver =
+		(struct obex_transport_driver *)data;
+	if (driver->uid_state)
+		driver->uid_state(((struct logind_cb_context *)ctxt));
+}
+
+static int call_uid_state_cb(gpointer ctxt)
+{
+	g_slist_foreach(drivers, call_cb, ctxt);
+}
+
+gboolean obex_transport_driver_init(void)
+{
+}
diff --git a/obexd/src/transport.h b/obexd/src/transport.h
index 322d8f526..087d8c211 100644
--- a/obexd/src/transport.h
+++ b/obexd/src/transport.h
@@ -8,6 +8,9 @@
  *
  */
 
+#include "obexd/src/logind.h"
+struct obex_server;
+
 struct obex_transport_driver {
 	const char *name;
 	uint16_t service;
@@ -15,9 +18,11 @@ struct obex_transport_driver {
 	int (*getpeername) (GIOChannel *io, char **name);
 	int (*getsockname) (GIOChannel *io, char **name);
 	void (*stop) (void *data);
+	void (*uid_state) (struct logind_cb_context *ctxt);
 };
 
 int obex_transport_driver_register(const struct obex_transport_driver *driver);
 void
 obex_transport_driver_unregister(const struct obex_transport_driver *driver);
 const GSList *obex_transport_driver_list(void);
+gboolean obex_transport_driver_init(void);
-- 
2.49.0

