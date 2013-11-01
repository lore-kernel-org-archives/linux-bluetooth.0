Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/6] android/hal: Add debug prints for every HAL callback
Date: Fri,  1 Nov 2013 13:30:17 +0200
Message-Id: <1383305418-13619-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This allows us to trace callbacks to Java.
---
 android/hal-bluetooth.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 91c5f97..7334d24 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -153,6 +153,8 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 	struct hal_ev_adapter_props_changed *ev = buf;
 	bt_property_t props[ev->num_props];
 
+	DBG("");
+
 	if (!bt_hal_cbacks->adapter_properties_cb)
 		return;
 
@@ -168,6 +170,8 @@ static void handle_bond_state_change(void *buf)
 	struct hal_ev_bond_state_changed *ev = buf;
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
 
+	DBG("state %u", ev->state);
+
 	if (bt_hal_cbacks->bond_state_changed_cb)
 		bt_hal_cbacks->bond_state_changed_cb(ev->status, addr,
 								ev->state);
@@ -180,6 +184,8 @@ static void handle_pin_request(void *buf)
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
 	bt_bdname_t *name = (bt_bdname_t *) ev->name;
 
+	DBG("");
+
 	if (bt_hal_cbacks->pin_request_cb)
 		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev);
 }
@@ -191,6 +197,8 @@ static void handle_ssp_request(void *buf)
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
 	bt_bdname_t *name = (bt_bdname_t *) ev->name;
 
+	DBG("");
+
 	if (bt_hal_cbacks->ssp_request_cb)
 		bt_hal_cbacks->ssp_request_cb(addr, name, ev->class_of_dev,
 							ev->pairing_variant,
@@ -218,6 +226,8 @@ static void handle_discovery_state_changed(void *buf)
 {
 	struct hal_ev_discovery_state_changed *ev = buf;
 
+	DBG("");
+
 	if (bt_hal_cbacks->discovery_state_changed_cb)
 		bt_hal_cbacks->discovery_state_changed_cb(ev->state);
 }
@@ -227,6 +237,8 @@ static void handle_device_found(void *buf, uint16_t len)
 	struct hal_ev_device_found *ev = buf;
 	bt_property_t props[ev->num_props];
 
+	DBG("");
+
 	if (!bt_hal_cbacks->device_found_cb)
 		return;
 
@@ -242,6 +254,8 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 	struct hal_ev_remote_device_props *ev = buf;
 	bt_property_t props[ev->num_props];
 
+	DBG("");
+
 	if (!bt_hal_cbacks->remote_device_properties_cb)
 		return;
 
-- 
1.7.10.4

