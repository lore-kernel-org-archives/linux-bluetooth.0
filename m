Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 4/8] android/hal: Add extra logs
Date: Wed, 30 Oct 2013 14:16:42 +0200
Message-Id: <1383135406-23658-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add extra log prints for printing properties and bluetooth addresses.
---
 android/hal-bluetooth.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 89535ed..93490f3 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -346,7 +346,7 @@ static int set_adapter_property(const bt_property_t *property)
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -357,7 +357,8 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 						bt_property_type_t type)
 {
-	DBG("");
+	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
+						bt_property_type_t2str(type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -368,7 +369,8 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
-	DBG("");
+	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
+						btproperty2str(property));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -378,7 +380,7 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -388,7 +390,7 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -424,7 +426,7 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_create_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -439,7 +441,7 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_cancel_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -454,7 +456,7 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_remove_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -470,7 +472,7 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 {
 	struct hal_cmd_pin_reply cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -489,7 +491,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 {
 	struct hal_cmd_ssp_reply cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
-- 
1.7.10.4

