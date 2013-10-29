Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/9] android/hal: Add extra logs
Date: Tue, 29 Oct 2013 12:21:54 +0200
Message-Id: <1383042118-21205-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add extra log prints for printing properties and bluetooth addresses.
---
 android/hal-bluetooth.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index da96202..81e23cb 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -251,7 +251,7 @@ static int set_adapter_property(const bt_property_t *property)
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -262,7 +262,8 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 						bt_property_type_t type)
 {
-	DBG("");
+	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
+						bt_property_type_t2str(type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -273,7 +274,8 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
-	DBG("");
+	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
+						btproperty2str(property));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -283,7 +285,7 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -293,7 +295,7 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -325,7 +327,7 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_create_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -340,7 +342,7 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_cancel_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -355,7 +357,7 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_remove_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -371,7 +373,7 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 {
 	struct hal_cmd_pin_reply cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -390,7 +392,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 {
 	struct hal_cmd_ssp_reply cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
-- 
1.7.10.4

