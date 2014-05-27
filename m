Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 8/9] core: Store list of monitored devices in adapter
Date: Tue, 27 May 2014 09:52:50 +0200
Message-ID: <1401177171-19994-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds list of devices which should be polled for connection
information to adapter.
---
 src/adapter.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index a3204d0..045ce30 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -53,6 +53,7 @@
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "hcid.h"
 #include "sdpd.h"
@@ -178,6 +179,7 @@ struct btd_adapter {
 	bool discovery_suspended;	/* discovery has been suspended */
 	GSList *discovery_list;		/* list of discovery clients */
 	GSList *discovery_found;	/* list of found devices */
+	struct queue *monitored_devices;
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
 	guint temp_devices_timeout;	/* timeout for temporary devices */
@@ -4166,6 +4168,8 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 
 	adapter->auths = g_queue_new();
 
+	adapter->monitored_devices = queue_new();
+
 	return btd_adapter_ref(adapter);
 }
 
@@ -4190,6 +4194,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->connect_list);
 	adapter->connect_list = NULL;
 
+	queue_destroy(adapter->monitored_devices, free);
+	adapter->monitored_devices = NULL;
+
 	for (l = adapter->devices; l; l = l->next)
 		device_remove(l->data, FALSE);
 
@@ -5460,15 +5467,41 @@ static void disconnect_complete(uint8_t status, uint16_t length,
 	dev_disconnected(adapter, &rp->addr, MGMT_DEV_DISCONN_LOCAL_HOST);
 }
 
+struct monitored_device {
+	struct mgmt_addr_info addr;
+};
+
+static bool compare_monitored_device(const void *a, const void *b)
+{
+	const struct monitored_device *a1 = a;
+	const struct monitored_device *b1 = b;
+
+	return !memcmp(&a1->addr.bdaddr, &b1->addr.bdaddr, sizeof(bdaddr_t)) &&
+			a1->addr.type == b1->addr.type;
+}
+
 int btd_adapter_add_monitored_device(struct btd_adapter *adapter,
 							const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type)
 {
+	struct monitored_device *mdev;
 	char addrstr[18];
 
 	ba2str(bdaddr, addrstr);
 	DBG("addr %s type %d", addrstr, bdaddr_type);
 
+	mdev = new0(struct monitored_device, 1);
+	bacpy(&mdev->addr.bdaddr, bdaddr);
+	mdev->addr.type = bdaddr_type;
+
+	if (queue_find(adapter->monitored_devices, compare_monitored_device,
+									mdev)) {
+		free(mdev);
+		return 0;
+	}
+
+	queue_push_tail(adapter->monitored_devices, mdev);
+
 	return 0;
 }
 
@@ -5476,11 +5509,26 @@ int btd_adapter_remove_monitored_device(struct btd_adapter *adapter,
 							const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type)
 {
+	struct monitored_device match;
+	struct monitored_device *mdev;
 	char addrstr[18];
 
 	ba2str(bdaddr, addrstr);
 	DBG("addr %s type %d", addrstr, bdaddr_type);
 
+	memset(&match, 0, sizeof(match));
+	bacpy(&match.addr.bdaddr, bdaddr);
+	match.addr.type = bdaddr_type;
+
+	mdev = queue_find(adapter->monitored_devices, compare_monitored_device,
+									&match);
+	if (!mdev)
+		return 0;
+
+	queue_remove(adapter->monitored_devices, mdev);
+
+	free(mdev);
+
 	return 0;
 }
 
-- 
1.9.3
