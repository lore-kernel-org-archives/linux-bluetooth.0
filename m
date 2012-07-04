Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] core: Fix not waiting for discovery to stop before attempting to pair
Date: Wed,  4 Jul 2012 15:09:28 +0300
Message-Id: <1341403768-16709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In some cases, LE controllers, this can cause errors due to scan/inquiry
being active.

To fix this instead of immediately attempting to pair wait until
discovery is properly stopped and only then proceed with bonding.
---
Still RFC because I could only test against controllers that used to
work without this patch.

 src/adapter.c |   48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f922876..043ca02 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -106,6 +106,12 @@ struct service_auth {
 	struct btd_adapter *adapter;
 };
 
+struct pending_bonding {
+	bdaddr_t bdaddr;
+	uint8_t addr_type;
+	uint8_t io_cap;
+};
+
 struct btd_adapter {
 	uint16_t dev_id;
 	gboolean up;
@@ -137,6 +143,7 @@ struct btd_adapter {
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
 	gboolean discov_suspended;	/* Discovery suspended */
+	struct pending_bonding *bonding;/* Pending device bonding */
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
 
@@ -498,6 +505,10 @@ static void stop_discovery(struct btd_adapter *adapter)
 	/* Reset if suspended, otherwise remove timer (software scheduler)
 	 * or request inquiry to stop */
 	if (adapter->discov_suspended) {
+		if (adapter->bonding != NULL) {
+			g_free(adapter->bonding);
+			adapter->bonding = NULL;
+		}
 		adapter->discov_suspended = FALSE;
 		return;
 	}
@@ -2551,7 +2562,20 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 	g_slist_free_full(adapter->oor_devices, dev_info_free);
 	adapter->oor_devices = g_slist_copy(adapter->found_devices);
 
-	if (!adapter_has_discov_sessions(adapter) || adapter->discov_suspended)
+	if (adapter->discov_suspended) {
+		if (adapter->bonding != NULL) {
+			adapter_ops->create_bonding(adapter->dev_id,
+						&adapter->bonding->bdaddr,
+						adapter->bonding->addr_type,
+						adapter->bonding->io_cap);
+			g_free(adapter->bonding);
+			adapter->bonding = NULL;
+			return;
+		} else
+			adapter->discov_suspended = FALSE;
+	}
+
+	if (!adapter_has_discov_sessions(adapter))
 		return;
 
 	DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
@@ -2560,10 +2584,10 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 	adapter->discov_id = g_idle_add(discovery_cb, adapter);
 }
 
-static void suspend_discovery(struct btd_adapter *adapter)
+static int suspend_discovery(struct btd_adapter *adapter)
 {
 	if (adapter->disc_sessions == NULL || adapter->discov_suspended)
-		return;
+		return -EALREADY;
 
 	DBG("Suspending discovery");
 
@@ -2579,6 +2603,8 @@ static void suspend_discovery(struct btd_adapter *adapter)
 		adapter->discov_id = 0;
 	} else
 		adapter_ops->stop_discovery(adapter->dev_id);
+
+	return 0;
 }
 
 static int found_device_cmp(gconstpointer a, gconstpointer b)
@@ -3530,9 +3556,19 @@ int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap)
 {
-	suspend_discovery(adapter);
-	return adapter_ops->create_bonding(adapter->dev_id, bdaddr,
-						addr_type, io_cap);
+	if (suspend_discovery(adapter) == -EALREADY)
+		return adapter_ops->create_bonding(adapter->dev_id, bdaddr,
+							addr_type, io_cap);
+
+	if (adapter->bonding != NULL)
+		return -EBUSY;
+
+	adapter->bonding = g_new0(struct pending_bonding, 1);
+	bacpy(&adapter->bonding->bdaddr, bdaddr);
+	adapter->bonding->addr_type = addr_type;
+	adapter->bonding->io_cap = io_cap;
+
+	return 0;
 }
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
-- 
1.7.10.4

