Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v7 7/8] core: adapter: filter discovery results when filered discovery is used
Date: Tue, 31 Mar 2015 00:33:29 -0700
Message-Id: <1427787210-4436-8-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427787210-4436-1-git-send-email-jpawlowski@google.com>
References: <1427787210-4436-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds filtering to device found event, and enforces lack
of RSSI delta for filtered scan.

When filtering, we compare against each client filter. That
additionally removes some of reports.
---
 src/adapter.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0345183..d5f24b1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5314,6 +5314,60 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
 	}
 }
 
+static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
+								int8_t rssi)
+{
+	GSList *l, *m;
+	bool got_match = false;
+
+	for (l = discovery_filter; l != NULL && got_match != true;
+							l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *item = client->discovery_filter;
+
+		/*
+		 * If one of currently running scans is regular scan, then
+		 * return all devices as matches
+		 */
+		if (!item) {
+			got_match = true;
+			continue;
+		}
+
+		/* if someone started discovery with empty uuids, he wants all
+		 * devices in given proximity.
+		 */
+		if (!item->uuids)
+			got_match = true;
+		else {
+			for (m = item->uuids; m != NULL && got_match != true;
+							m = g_slist_next(m)) {
+				/* m->data contains string representation of
+				 * uuid.
+				 */
+				if (g_slist_find_custom(eir_data->services,
+							m->data,
+							g_strcmp) != NULL)
+					got_match = true;
+			}
+		}
+
+		if (got_match) {
+			/* we have service match, check proximity */
+			if (item->rssi == DISTANCE_VAL_INVALID ||
+			    item->rssi <= rssi ||
+			    item->pathloss == DISTANCE_VAL_INVALID ||
+			    (eir_data->tx_power != 127 &&
+			     eir_data->tx_power - rssi <= item->pathloss))
+				return true;
+
+			got_match = false;
+		}
+	}
+
+	return got_match;
+}
+
 static void update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
@@ -5380,8 +5434,18 @@ static void update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
+	if (adapter->filtered_discovery &&
+	    !is_filter_match(adapter->discovery_list, &eir_data, rssi)) {
+		eir_data_free(&eir_data);
+		return;
+	}
+
 	device_set_legacy(dev, legacy);
-	device_set_rssi(dev, rssi);
+
+	if (adapter->filtered_discovery)
+		device_set_rssi_with_delta(dev, rssi, 0);
+	else
+		device_set_rssi(dev, rssi);
 
 	if (eir_data.appearance != 0)
 		device_set_appearance(dev, eir_data.appearance);
-- 
2.2.0.rc0.207.ga3a616c

