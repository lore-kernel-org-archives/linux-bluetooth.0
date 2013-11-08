Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 3/4] android: Add support for getting UUIDs property
Date: Fri, 8 Nov 2013 13:21:23 +0100
Message-ID: <1383913284-4032-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
References: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This method will call adapter_properties_cb with uuids of
adapter. Method is called also when uuid is added or removed.
---
 android/adapter.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 8ea104b..8c4fe76 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -988,6 +988,44 @@ static void load_link_keys(GSList *keys)
 	}
 }
 
+static bool get_uuids(void)
+{
+	struct hal_ev_adapter_props_changed *ev;
+	GSList *list = adapter->uuids;
+	unsigned int uuid_count = g_slist_length(list);
+	int len = uuid_count * sizeof(uint128_t);
+	uint8_t buf[BASELEN_PROP_CHANGED + len];
+	bt_uuid_t *uuid;
+	uint8_t *p;
+	int i;
+
+	memset(buf, 0, sizeof(buf));
+	ev = (void *) buf;
+
+	ev->num_props = 1;
+	ev->status = HAL_STATUS_SUCCESS;
+
+	ev->props[0].type = HAL_PROP_ADAPTER_UUIDS;
+	ev->props[0].len = len;
+	p = ev->props->val;
+
+	for (; list; list = g_slist_next(list)) {
+		uuid = list->data;
+
+		/* uuids on list are in mgmt interface format and need to
+		 * be swapped before sending to HAL */
+		for (i = 0; i < 16; i++)
+			p[15 - i] = uuid->value.u128.data[i];
+
+		p += sizeof(uint128_t);
+	}
+
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+
+	return true;
+}
+
 static void remove_uuid_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -998,6 +1036,10 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 	}
 
 	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+
+	/* send notification only if bluetooth service is registered */
+	if (notification_sk >= 0)
+		get_uuids();
 }
 
 static void remove_uuid(const uint8_t *uuid)
@@ -1006,7 +1048,6 @@ static void remove_uuid(const uint8_t *uuid)
 
 	memcpy(cp.uuid, uuid, sizeof(uint128_t));
 
-
 	mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_UUID,
 				adapter->index, sizeof(cp), &cp,
 				remove_uuid_complete, NULL, NULL);
@@ -1022,6 +1063,10 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 	}
 
 	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+
+	/* send notification only if bluetooth service is registered */
+	if (notification_sk >= 0)
+		get_uuids();
 }
 
 static void add_uuid(uint8_t svc_hint, const uint8_t *uuid)
@@ -1335,14 +1380,6 @@ static bool get_name(void)
 	return true;
 }
 
-static bool get_uuids(void)
-{
-	DBG("Not implemented");
-
-	/* TODO: Add implementation */
-
-	return false;
-}
 
 static bool get_class(void)
 {
-- 
1.8.4.2

