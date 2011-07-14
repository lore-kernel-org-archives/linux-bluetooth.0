Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix powering off/on after RequestSession/SetProperty
Date: Thu, 14 Jul 2011 14:31:30 +0300
Message-Id: <1310643090-10690-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter's global_mode is overwritten to be off if request comes from
plug-in callback and initiator of mode change is not the adapter.
Otherwise, in some scenarios, adapter may return to state on after
being switched off.

More specifically, use of RequestSession and SetProperty "powered"
sets global_mode to state on. Switching adapter off via plug-in
interface releases all sessions that in turn restores adapter's
state to global_mode, which is on.

This fixes such inconsistency.
---
 src/adapter.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0909a22..9013ba3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -122,6 +122,7 @@ struct btd_adapter {
 	uint8_t mode;			/* off, connectable, discoverable,
 					 * limited */
 	uint8_t global_mode;		/* last valid global mode */
+	gboolean pc_initiator;		/* initiator of power cycling */
 	struct session_req *pending_mode;
 	int state;			/* standard inq, periodic inq, name
 					 * resolving, suspended discovery */
@@ -2194,6 +2195,9 @@ static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
 {
 	GSList *l;
 
+	if (adapter->powered_callbacks)
+		adapter->pc_initiator = TRUE;
+
 	for (l = adapter->powered_callbacks; l; l = l->next) {
 		btd_adapter_powered_cb cb = l->data;
 
@@ -2336,6 +2340,8 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	DBG("");
 
+	adapter->pc_initiator = FALSE;
+
 	/*
 	 * g_slist_free is not called after g_slist_foreach because the list is
 	 * updated using g_slist_remove in session_remove which is called by
@@ -3423,6 +3429,9 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	if (adapter->off_timer)
 		return 0;
 
+	if (!adapter->pc_initiator)
+		adapter->global_mode = MODE_OFF;
+
 	if (adapter->connections == NULL)
 		return adapter_ops->set_powered(adapter->dev_id, FALSE);
 
-- 
1.7.4.1

