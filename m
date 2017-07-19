Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] monitor: Filter duplicated advertisements
Date: Wed, 19 Jul 2017 16:09:05 +0300
Message-Id: <20170719130909.24702-3-luiz.dentz@gmail.com>
In-Reply-To: <20170719130909.24702-1-luiz.dentz@gmail.com>
References: <20170719130909.24702-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reduces the verbosity and give a precise picture of how unique
each report is.
---
 monitor/packet.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index cc24165..4ed0faa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -42,7 +42,9 @@
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
 
+#include "src/shared/mainloop.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/btsnoop.h"
 #include "display.h"
 #include "bt.h"
@@ -100,6 +102,9 @@
 
 #define COLOR_PHY_PACKET		COLOR_BLUE
 
+#define ADV_TIMEOUT			3000
+#define ADV_MAX_CACHE			100
+
 static time_t time_offset = ((time_t) -1);
 static int priority_level = BTSNOOP_PRIORITY_INFO;
 static unsigned long filter_mask = 0;
@@ -267,11 +272,20 @@ void packet_select_index(uint16_t index)
 
 #define MAX_INDEX 16
 
+struct adv_data {
+	struct bt_hci_evt_le_adv_report evt;
+	void *data;
+	size_t frame;
+	int timeout;
+	struct queue *cache;
+};
+
 struct index_data {
 	uint8_t  type;
 	uint8_t  bdaddr[6];
 	uint16_t manufacturer;
 	size_t	frame;
+	struct queue *adv_cache;
 };
 
 static struct index_data index_list[MAX_INDEX];
@@ -8587,12 +8601,86 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
 }
 
+static void adv_free(void *data)
+{
+	struct adv_data *adv = data;
+
+	free(adv->data);
+	free(adv);
+}
+
+static bool match_adv(const void *data, const void *user_data)
+{
+	const struct adv_data *adv = data;
+	const struct bt_hci_evt_le_adv_report *evt = user_data;
+
+	if (memcmp(&adv->evt, evt, sizeof(*evt)))
+		return false;
+
+	return memcmp(adv->data, evt->data, evt->data_len) == 0;
+}
+
+static void adv_timeout(int id, void *data)
+{
+	struct adv_data *adv = data;
+
+	/* Remove from check (adv is freed after returning) */
+	queue_remove(adv->cache, adv);
+
+	mainloop_remove_timeout(adv->timeout);
+}
+
 static void le_adv_report_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_report *evt = data;
+	struct index_data *idata = &index_list[index_current];
+	struct adv_data *match;
+	struct adv_data *adv;
 	uint8_t evt_len;
 	int8_t *rssi;
 
+	if (!idata->adv_cache)
+		idata->adv_cache = queue_new();
+
+	adv = queue_remove_if(idata->adv_cache, match_adv, (void *) evt);
+	if (adv) {
+		/* Update cache and modify expire timeout */
+		if (mainloop_modify_timeout(adv->timeout, ADV_TIMEOUT) < 0) {
+			mainloop_remove_timeout(adv->timeout);
+			adv->timeout = mainloop_add_timeout(ADV_TIMEOUT,
+							adv_timeout, adv,
+							adv_free);
+		}
+		queue_push_head(idata->adv_cache, adv);
+		print_field("Duplicate of #%zu", adv->frame);
+		size = 0;
+		goto rssi;
+	}
+
+	match = new0(struct adv_data, 1);
+	match->evt = *evt;
+
+	match->data = malloc(evt->data_len);
+	memcpy(match->data, evt->data, evt->data_len);
+
+	match->cache = idata->adv_cache;
+	match->frame = idata->frame;
+	match->timeout = mainloop_add_timeout(ADV_TIMEOUT, adv_timeout, match,
+						adv_free);
+	if (match->timeout <= 0) {
+		print_field("Cannot cache: %s (%d)", strerror(-match->timeout),
+							match->timeout);
+		adv_free(match);
+		goto print;
+	}
+
+	queue_push_head(idata->adv_cache, match);
+
+	if (queue_length(idata->adv_cache) > ADV_MAX_CACHE)
+		queue_remove(idata->adv_cache,
+					queue_peek_tail(idata->adv_cache));
+
+print:
 	print_num_reports(evt->num_reports);
 
 report:
@@ -8602,6 +8690,7 @@ report:
 	print_field("Data length: %d", evt->data_len);
 	print_eir(evt->data, evt->data_len, true);
 
+rssi:
 	rssi = (int8_t *) (evt->data + evt->data_len);
 	print_rssi(*rssi);
 
-- 
2.9.4

