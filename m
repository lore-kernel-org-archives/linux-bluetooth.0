Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/4] Remove ancient NAME_SENT name resolution status
Date: Mon, 27 Dec 2010 09:21:05 -0400
Message-Id: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The NAME_SENT status was introduced on commit
d6a16516a9f6deae8342f00e8186b02d0019a1e1, when there was a
"RemoteNameUpdate" D-Bus signal. Nowadays, there is no such signal, and
the device name (if any) is always sent on "DeviceFound" signal.
---
 src/adapter.h |    1 -
 src/event.c   |   19 -------------------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index ab83011..857eec8 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -61,7 +61,6 @@ typedef enum {
 	NAME_NOT_REQUIRED, /* used by get remote name without name resolving */
 	NAME_REQUIRED,      /* remote name needs be resolved       */
 	NAME_REQUESTED,    /* HCI remote name request was sent    */
-	NAME_SENT          /* D-Bus signal RemoteNameUpdated sent */
 } name_status_t;
 
 struct btd_adapter;
diff --git a/src/event.c b/src/event.c
index cfc47bf..6598e37 100644
--- a/src/event.c
+++ b/src/event.c
@@ -487,7 +487,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 	char local_addr[18], peer_addr[18], *alias, *name;
-	struct remote_dev_info *dev, match;
 	name_status_t name_status;
 	struct eir_data eir_data;
 	int state, err;
@@ -525,20 +524,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (err < 0)
 		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
 
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	bacpy(&match.bdaddr, peer);
-	match.name_status = NAME_SENT;
-	/* if found: don't send the name again */
-	dev = adapter_search_found_devices(adapter, &match);
-	if (dev) {
-		g_free(eir_data.name);
-		adapter_update_found_devices(adapter, peer, rssi, class,
-						NULL, NULL, dev->legacy,
-						eir_data.services,
-						NAME_NOT_REQUIRED);
-		return;
-	}
-
 	/* the inquiry result can be triggered by NON D-Bus client */
 	if (adapter_get_discover_type(adapter) & DISC_RESOLVNAME &&
 				adapter_has_discov_sessions(adapter))
@@ -581,10 +566,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		}
 	}
 
-	if (name && eir_data.name_complete)
-		name_status = NAME_SENT;
-
-	/* add in the list to track name sent/pending */
 	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
 					legacy, eir_data.services, name_status);
 
-- 
1.7.0.4

