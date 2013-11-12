Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 4/5] android: Add support for getting UUIDs property
Date: Tue, 12 Nov 2013 13:06:24 +0100
Message-ID: <1384257985-26319-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384257985-26319-1-git-send-email-szymon.janc@tieto.com>
References: <1384257985-26319-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This method will call adapter_properties_cb with uuids of
adapter. Method is called also when uuid is added or removed.
---
 android/adapter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index d5b1806..fd40bad 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -998,6 +998,45 @@ static void uuid16_to_uint128(uint16_t uuid, uint128_t *u128)
 	ntoh128(&uuid128.value.uuid128, u128);
 }
 
+static bool get_uuids(void)
+{
+	struct hal_ev_adapter_props_changed *ev;
+	GSList *list = adapter->uuids;
+	unsigned int uuid_count = g_slist_length(list);
+	int len = uuid_count * sizeof(uint128_t);
+	uint8_t buf[BASELEN_PROP_CHANGED + len];
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
+		uint16_t uuid = GPOINTER_TO_UINT(list->data);
+		uint128_t uint128;
+
+		uuid16_to_uint128(uuid, &uint128);
+
+		/* Android expects swapped bytes in uuid */
+		for (i = 0; i < 16; i++)
+			p[15 - i] = uint128.data[i];
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
@@ -1008,6 +1047,10 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 	}
 
 	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+
+	/* send notification only if bluetooth service is registered */
+	if (notification_sk >= 0)
+		get_uuids();
 }
 
 static void remove_uuid(uint128_t *uuid)
@@ -1031,6 +1074,10 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 	}
 
 	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+
+	/* send notification only if bluetooth service is registered */
+	if (notification_sk >= 0)
+		get_uuids();
 }
 
 static void add_uuid(uint8_t svc_hint, uint128_t *uuid)
@@ -1331,14 +1378,6 @@ static bool get_name(void)
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

