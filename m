Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 08/16] Refactoring adapter_set_state()
Date: Fri, 29 Apr 2011 21:27:24 -0300
Message-Id: <1304123252-14464-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a new state machine for struct btd_adapter.

The adapter_set_state() function was completely rewritten since its
logic does not apply anymore. The whole logic of interleaved discovery
procedure before implemented in adapter_set_state() should be
implemented at hciops and mgmtops layers.

At the adapter layer, it is not important to track what is the current
state (inquiring or scanning) during the discovery session. All the
adapter layer cares about is if it is performing the discovery or not.
Therefore, the adapter states STATE_STDINQ, STATE_PINQ and
STATE_LE_SCAN were replaced by a new state called STATE_DISCOV.

Additionally, because there is no point in implementing states
as a bitmask, all adapter states were implemented using integers
instead of a bitmask.
---
 plugins/mgmtops.c |   11 ++---
 src/adapter.c     |  147 +++++++++++++++++++++++------------------------------
 src/adapter.h     |   10 ++--
 src/event.c       |    5 +--
 4 files changed, 73 insertions(+), 100 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 9fa195d..e4eac81 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1374,13 +1374,10 @@ static void mgmt_discovering(int sk, uint16_t index, void *buf, size_t len)
 	if (!adapter)
 		return;
 
-	state = adapter_get_state(adapter);
-
-	if (ev->val) {
-		if (!(state & (STATE_STDINQ | STATE_LE_SCAN | STATE_PINQ)))
-			state |= STATE_PINQ;
-	} else
-		state &= ~(STATE_STDINQ | STATE_PINQ);
+	if (ev->val)
+		state = STATE_DISCOV;
+	else
+		state = STATE_IDLE;
 
 	adapter_set_state(adapter, state);
 }
diff --git a/src/adapter.c b/src/adapter.c
index 6c29992..6a2a8c1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -59,9 +59,6 @@
 #include "attrib-server.h"
 #include "att.h"
 
-/* Interleaved discovery window: 5.12 sec */
-#define GAP_INTER_DISCOV_WIN		5120
-
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
 #define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
@@ -266,11 +263,13 @@ static int pending_remote_name_cancel(struct btd_adapter *adapter)
 	if (!dev) /* no pending request */
 		return -ENODATA;
 
-	adapter->state &= ~STATE_RESOLVNAME;
 	err = adapter_ops->cancel_resolve_name(adapter->dev_id, &dev->bdaddr);
 	if (err < 0)
 		error("Remote name cancel failed: %s(%d)",
 						strerror(errno), errno);
+
+	adapter_set_state(adapter, STATE_IDLE);
+
 	return err;
 }
 
@@ -280,7 +279,7 @@ int adapter_resolve_names(struct btd_adapter *adapter)
 	int err;
 
 	/* Do not attempt to resolve more names if on suspended state */
-	if (adapter->state & STATE_SUSPENDED)
+	if (adapter->state == STATE_SUSPENDED)
 		return 0;
 
 	memset(&match, 0, sizeof(struct remote_dev_info));
@@ -715,8 +714,8 @@ static void stop_discovery(struct btd_adapter *adapter, gboolean suspend)
 
 	/* Reset if suspended, otherwise remove timer (software scheduler)
 	   or request inquiry to stop */
-	if (adapter->state & STATE_SUSPENDED) {
-		adapter->state &= ~STATE_SUSPENDED;
+	if (adapter->state == STATE_SUSPENDED) {
+		adapter_set_state(adapter, STATE_IDLE);
 		return;
 	}
 
@@ -1204,23 +1203,14 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 						DEVICE_TYPE_BREDR);
 }
 
-static gboolean stop_scanning(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	adapter_ops->stop_scanning(adapter->dev_id);
-
-	return FALSE;
-}
-
 static int start_discovery(struct btd_adapter *adapter)
 {
 	/* Do not start if suspended */
-	if (adapter->state & STATE_SUSPENDED)
+	if (adapter->state == STATE_SUSPENDED)
 		return 0;
 
 	/* Postpone discovery if still resolving names */
-	if (adapter->state & STATE_RESOLVNAME)
+	if (adapter->state == STATE_RESOLVNAME)
 		return -EINPROGRESS;
 
 	pending_remote_name_cancel(adapter);
@@ -1368,7 +1358,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 				DBUS_TYPE_UINT32, &adapter->pairable_timeout);
 
 
-	if (adapter->state & (STATE_PINQ | STATE_STDINQ | STATE_LE_SCAN))
+	if (adapter->state == STATE_DISCOV)
 		value = TRUE;
 	else
 		value = FALSE;
@@ -2761,80 +2751,76 @@ void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 	bacpy(bdaddr, &adapter->bdaddr);
 }
 
+static inline void suspend_discovery(struct btd_adapter *adapter)
+{
+	if (adapter->state != STATE_SUSPENDED)
+		return;
+
+	if (adapter->oor_devices) {
+		g_slist_free(adapter->oor_devices);
+		adapter->oor_devices = NULL;
+	}
+
+	if (adapter->scheduler_id) {
+		g_source_remove(adapter->scheduler_id);
+		adapter->scheduler_id = 0;
+	}
+
+	adapter_ops->stop_discovery(adapter->dev_id);
+}
+
+static inline void resolve_names(struct btd_adapter *adapter)
+{
+	int err;
+
+	if (adapter->state != STATE_RESOLVNAME)
+		return;
+
+	err = adapter_resolve_names(adapter);
+	if (err < 0)
+		adapter_set_state(adapter, STATE_IDLE);
+}
+
 void adapter_set_state(struct btd_adapter *adapter, int state)
 {
 	const char *path = adapter->path;
 	gboolean discov_active;
-	int previous, type;
 
 	if (adapter->state == state)
 		return;
 
-	previous = adapter->state;
 	adapter->state = state;
 
-	type = adapter_get_discover_type(adapter);
+	DBG("hci%d: new state %d", adapter->dev_id, adapter->state);
 
-	switch (state) {
-	case STATE_STDINQ:
-	case STATE_PINQ:
-		discov_active = TRUE;
+	switch (adapter->state) {
+	case STATE_IDLE:
+		update_oor_devices(adapter);
 
-		/* Started a new session while resolving names ? */
-		if (previous & STATE_RESOLVNAME)
-			return;
+		discov_active = FALSE;
+		emit_property_changed(connection, path,
+					ADAPTER_INTERFACE, "Discovering",
+					DBUS_TYPE_BOOLEAN, &discov_active);
+
+		if (adapter_has_discov_sessions(adapter)) {
+			adapter->scheduler_id = g_timeout_add_seconds(
+						main_opts.discov_interval,
+						discovery_cb, adapter);
+		}
 		break;
-	case STATE_LE_SCAN:
+	case STATE_DISCOV:
 		discov_active = TRUE;
-
-		if (!adapter->disc_sessions)
-			break;
-
-		/* Stop scanning after TGAP(100)/2 */
-		adapter->stop_discov_id = g_timeout_add(GAP_INTER_DISCOV_WIN,
-							stop_scanning,
-							adapter);
-
-		/* For dual mode: don't send "Discovering = TRUE" (twice) */
-		if (bredr_capable(adapter) == TRUE)
-			return;
-
+		emit_property_changed(connection, path,
+					ADAPTER_INTERFACE, "Discovering",
+					DBUS_TYPE_BOOLEAN, &discov_active);
 		break;
-	case STATE_IDLE:
-		/*
-		 * Interleave: from inquiry to scanning. Interleave is not
-		 * applicable to requests triggered by external applications.
-		 */
-		if (adapter->disc_sessions && (type & DISC_INTERLEAVE) &&
-						(previous & STATE_STDINQ)) {
-			adapter_ops->start_scanning(adapter->dev_id, 0);
-			return;
-		}
-		/* BR/EDR only: inquiry finished */
-		discov_active = FALSE;
+	case STATE_RESOLVNAME:
+		resolve_names(adapter);
 		break;
-	default:
-		discov_active = FALSE;
+	case STATE_SUSPENDED:
+		suspend_discovery(adapter);
 		break;
 	}
-
-	if (discov_active == FALSE) {
-		if (type & DISC_RESOLVNAME) {
-			if (adapter_resolve_names(adapter) == 0) {
-				adapter->state |= STATE_RESOLVNAME;
-				return;
-			}
-		}
-
-		update_oor_devices(adapter);
-	} else if (adapter->disc_sessions && main_opts.discov_interval)
-			adapter->scheduler_id = g_timeout_add_seconds(
-						main_opts.discov_interval,
-						discovery_cb, adapter);
-
-	emit_property_changed(connection, path,
-				ADAPTER_INTERFACE, "Discovering",
-				DBUS_TYPE_BOOLEAN, &discov_active);
 }
 
 int adapter_get_state(struct btd_adapter *adapter)
@@ -3274,24 +3260,19 @@ gboolean adapter_has_discov_sessions(struct btd_adapter *adapter)
 void adapter_suspend_discovery(struct btd_adapter *adapter)
 {
 	if (adapter->disc_sessions == NULL ||
-			adapter->state & STATE_SUSPENDED)
+			adapter->state == STATE_SUSPENDED)
 		return;
 
 	DBG("Suspending discovery");
 
-	stop_discovery(adapter, TRUE);
-	adapter->state |= STATE_SUSPENDED;
+	adapter_set_state(adapter, STATE_SUSPENDED);
 }
 
 void adapter_resume_discovery(struct btd_adapter *adapter)
 {
-	if (adapter->disc_sessions == NULL)
-		return;
-
 	DBG("Resuming discovery");
 
-	adapter->state &= ~STATE_SUSPENDED;
-	start_discovery(adapter);
+	adapter_set_state(adapter, STATE_IDLE);
 }
 
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
diff --git a/src/adapter.h b/src/adapter.h
index bb1abe8..a408a92 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -37,12 +37,10 @@
 #define MODE_UNKNOWN		0xff
 
 /* Discover states */
-#define STATE_IDLE		0x00
-#define STATE_LE_SCAN		0x01
-#define STATE_STDINQ		0x02
-#define STATE_PINQ		0x04
-#define STATE_RESOLVNAME	0x08
-#define STATE_SUSPENDED		0x10
+#define STATE_IDLE		0
+#define STATE_DISCOV		1
+#define STATE_RESOLVNAME	2
+#define STATE_SUSPENDED		3
 
 /* Supported host/controller discover type */
 #define DISC_LE			0x01
diff --git a/src/event.c b/src/event.c
index b04220a..bf6f4e3 100644
--- a/src/event.c
+++ b/src/event.c
@@ -559,7 +559,6 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 {
 	struct btd_adapter *adapter;
 	char srcaddr[18], dstaddr[18];
-	int state;
 	struct btd_device *device;
 	struct remote_dev_info match, *dev_info;
 
@@ -604,9 +603,7 @@ proceed:
 	if (adapter_resolve_names(adapter) == 0)
 		return;
 
-	state = adapter_get_state(adapter);
-	state &= ~STATE_RESOLVNAME;
-	adapter_set_state(adapter, state);
+	adapter_set_state(adapter, STATE_IDLE);
 }
 
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.1

