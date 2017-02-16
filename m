Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 4/7] profiles/gap: Added support for PPCP characteristic
Date: Thu, 16 Feb 2017 18:03:12 +0000
Message-Id: <20170216180315.30531-5-eu@felipetonello.com>
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Peripheral Preferred Connection Parameters (PPCP) characteristic
contains the preferred connection parameters of a peripheral device.

These parameters are stored in the info file and loaded to Kernel using
MGMT's respective command.

IMPORTANT: The connection will only be updated upon next reconnection to
the peripheral device. This is a limitation of the current BlueZ API
that doesn't allow change specific parameters of current connection.
---
 profiles/gap/gas.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 0d34503ad446..a9f09f0b3299 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -162,6 +162,75 @@ static void handle_appearance(struct gas *gas, uint16_t value_handle)
 		DBG("Failed to send request to read appearance");
 }
 
+static void read_ppcp_cb(bool success, uint8_t att_ecode,
+			const uint8_t *value, uint16_t length,
+			void *user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t min_interval, max_interval, latency, timeout, max_latency;
+
+	if (!success) {
+		DBG("Reading PPCP failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 8) {
+		DBG("Malformed PPCP value");
+		return;
+	}
+
+	min_interval = get_le16(&value[0]);
+	max_interval = get_le16(&value[2]);
+	latency = get_le16(&value[4]);
+	timeout = get_le16(&value[6]);
+
+	DBG("GAP Peripheral Preferred Connection Parameters:");
+	DBG("\tMinimum connection interval: %u", min_interval);
+	DBG("\tMaximum connection interval: %u", max_interval);
+	DBG("\tSlave latency: %u", latency);
+	DBG("\tConnection Supervision timeout multiplier: %u", timeout);
+
+	/* 0xffff indicates no specific min/max */
+	if (min_interval == 0xffff)
+		min_interval = 6;
+
+	if (max_interval == 0xffff)
+		max_interval = 3200;
+
+	/* avoid persisting connection parameters that are not valid */
+	if (min_interval > max_interval ||
+	    min_interval < 6 || max_interval > 3200) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	if (timeout < 10 || timeout > 3200) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	if (max_interval >= timeout * 8) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	max_latency = (timeout * 4 / max_interval) - 1;
+	if (latency > 499 || latency > max_latency) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	btd_device_set_conn_param(gas->device, min_interval, max_interval,
+					latency, timeout);
+}
+
+static void handle_ppcp(struct gas *gas, uint16_t value_handle)
+{
+	if (!bt_gatt_client_read_value(gas->client, value_handle,
+						read_ppcp_cb, gas, NULL))
+		DBG("Failed to send request to read PPCP");
+}
+
 static inline bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
 {
 	bt_uuid_t lhs;
@@ -188,6 +257,8 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 		handle_device_name(gas, value_handle);
 	else if (uuid_cmp(GATT_CHARAC_APPEARANCE, &uuid))
 		handle_appearance(gas, value_handle);
+	else if (uuid_cmp(GATT_CHARAC_PERIPHERAL_PREF_CONN, &uuid))
+		handle_ppcp(gas, value_handle);
 	else {
 		char uuid_str[MAX_LEN_UUID_STR];
 
-- 
2.11.1

