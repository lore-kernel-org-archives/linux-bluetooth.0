Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 6/6] android: Add support for getting adapter uuids
Date: Tue, 5 Nov 2013 14:21:40 +0100
Message-ID: <1383657700-22313-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement get adapter uuids command. It will pack supported
uuids to structure and send it via notification socket

---
 android/adapter.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 89db078..6ce2211 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1291,13 +1291,47 @@ static bool get_name(void)
 	return true;
 }
 
+static void swap_uuid(const uint8_t *src, uint8_t *dst)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		dst[15 - i] = src[i];
+}
+
 static bool get_uuids(void)
 {
-	DBG("Not implemented");
+	struct hal_ev_adapter_props_changed *ev;
+	unsigned int i;
+	int len;
+	uint8_t *p;
 
-	/* TODO: Add implementation */
+	len = sizeof(*ev) + sizeof(struct hal_property) +
+			NELEM(supported_services) * sizeof(uint128_t);
 
-	return false;
+	ev = g_malloc(len);
+
+	ev->num_props = 1;
+	ev->status = HAL_STATUS_SUCCESS;
+
+	ev->props[0].type = HAL_PROP_ADAPTER_UUIDS;
+	ev->props[0].len = sizeof(uint128_t) * NELEM(supported_services);
+	p = ev->props->val;
+
+	for (i = 0; i < NELEM(supported_services); i++) {
+		/* we have to swap supported uuids
+		 * because hal expects them in reversed order
+		 * than mgmt intrface */
+		swap_uuid(supported_services[i].uuid, p);
+		p += sizeof(uint128_t);
+	}
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+
+	g_free(ev);
+
+	return true;
 }
 
 static bool get_class(void)
-- 
1.8.4.1

