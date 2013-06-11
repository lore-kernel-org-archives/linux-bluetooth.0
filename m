Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 8/9] adapter: forbid properties to be set during Pairing Session
Date: Tue, 11 Jun 2013 11:56:26 +0100
Message-Id: <1370948187-3702-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If one or more pairing session is ongoing the following properties can't
be set: Pairable, PairableTimeout, Discoverable and DiscoverableTimeout.
---
 src/adapter.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 9e11f02..8bb9788 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2108,6 +2108,13 @@ static void property_set_discoverable(const GDBusPropertyTable *property,
 {
 	struct btd_adapter *adapter = user_data;
 
+	if (adapter->pairing) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".PermissionDenied",
+					"Pairing session ongoing");
+		return;
+	}
+
 	property_set_mode(adapter, MGMT_SETTING_DISCOVERABLE, iter, id);
 }
 
@@ -2131,6 +2138,13 @@ static void property_set_discoverable_timeout(
 	struct btd_adapter *adapter = user_data;
 	dbus_uint32_t value;
 
+	if (adapter->pairing) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".PermissionDenied",
+					"Pairing session ongoing");
+		return;
+	}
+
 	dbus_message_iter_get_basic(iter, &value);
 
 	adapter->discoverable_timeout = value;
@@ -2160,6 +2174,13 @@ static void property_set_pairable(const GDBusPropertyTable *property,
 {
 	struct btd_adapter *adapter = user_data;
 
+	if (adapter->pairing) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".PermissionDenied",
+					"Pairing session ongoing");
+		return;
+	}
+
 	property_set_mode(adapter, MGMT_SETTING_PAIRABLE, iter, id);
 }
 
@@ -2182,6 +2203,13 @@ static void property_set_pairable_timeout(const GDBusPropertyTable *property,
 	struct btd_adapter *adapter = user_data;
 	dbus_uint32_t value;
 
+	if (adapter->pairing) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".PermissionDenied",
+					"Pairing session ongoing");
+		return;
+	}
+
 	dbus_message_iter_get_basic(iter, &value);
 
 	adapter->pairable_timeout = value;
-- 
1.8.1.4

