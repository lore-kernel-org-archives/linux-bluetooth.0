Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] tools/btpclient: Add solicit uuid16 service list support for ad
Date: Wed, 28 Feb 2018 13:41:27 +0100
Message-Id: <20180228124129.25851-7-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to get/set solicit uuid16 service list in
advertising data.
---
 tools/btpclient.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 006d8acbe..3b53b8fc8 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -45,6 +45,7 @@
 #define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST	0x02
 #define AD_TYPE_SHORT_NAME			0x08
 #define AD_TYPE_TX_POWER			0x0a
+#define AD_TYPE_SOLICIT_UUID16_SERVICE_LIST	0x14
 #define AD_TYPE_SERVICE_DATA_UUID16		0x16
 #define AD_TYPE_APPEARANCE			0x19
 #define AD_TYPE_MANUFACTURER_DATA		0xff
@@ -98,6 +99,7 @@ static struct ad {
 	struct l_queue *uuids;
 	struct l_queue *services;
 	struct l_queue *manufacturers;
+	struct l_queue *solicits;
 	bool tx_power;
 	bool name;
 	bool appearance;
@@ -443,6 +445,7 @@ static void ad_cleanup(void)
 	l_queue_destroy(ad.uuids, l_free);
 	l_queue_destroy(ad.services, ad_cleanup_service);
 	l_queue_destroy(ad.manufacturers, l_free);
+	l_queue_destroy(ad.solicits, l_free);
 
 	memset(&ad, 0, sizeof(ad));
 }
@@ -756,6 +759,7 @@ static void ad_init(void)
 	ad.uuids = l_queue_new();
 	ad.services = l_queue_new();
 	ad.manufacturers = l_queue_new();
+	ad.solicits = l_queue_new();
 
 	ad.local_appearance = UINT16_MAX;
 }
@@ -876,6 +880,27 @@ static bool ad_manufacturerdata_getter(struct l_dbus *dbus,
 	return true;
 }
 
+static bool ad_solicituuids_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct l_queue_entry *entry;
+
+	if (l_queue_isempty(ad.solicits))
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (entry = l_queue_get_entries(ad.solicits); entry;
+							entry = entry->next)
+		l_dbus_message_builder_append_basic(builder, 's', entry->data);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
 static bool ad_includes_getter(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -975,6 +1000,8 @@ static void setup_ad_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "ManufacturerData", 0,
 					"a{qv}", ad_manufacturerdata_getter,
 					NULL);
+	l_dbus_interface_property(interface, "SolicitUUIDs", 0, "as",
+						ad_solicituuids_getter, NULL);
 	l_dbus_interface_property(interface, "Includes", 0, "as",
 						ad_includes_getter, NULL);
 	l_dbus_interface_property(interface, "LocalName", 0, "s",
@@ -1089,6 +1116,14 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 
 			break;
 		}
+		case AD_TYPE_SOLICIT_UUID16_SERVICE_LIST:
+		{
+			char *uuid = dupuuid2str(ad_data, 16);
+
+			l_queue_push_tail(ad.solicits, uuid);
+
+			break;
+		}
 		default:
 			l_info("Unsupported advertising data type");
 
-- 
2.13.6

