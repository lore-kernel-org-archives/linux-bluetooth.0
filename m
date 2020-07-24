Return-Path: <SRS0=QcUl=BD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD94C433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDC920737
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 12:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGXMUy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:20:54 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:47410 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMUy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jul 2020 08:20:54 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id F2AC9C0907
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2020 20:20:44 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P20417T140494254360320S1595593245635670_;
        Fri, 24 Jul 2020 20:20:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4363d5b6be41cca5a42b152a2cef72e2>
X-RL-SENDER: chengbo@uniontech.com
X-SENDER: chengbo@uniontech.com
X-LOGIN-NAME: chengbo@uniontech.com
X-FST-TO: linux-bluetooth@vger.kernel.org
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   chengbo <515672508@qq.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] src: Event callback registration optimization
Date:   Fri, 24 Jul 2020 20:20:45 +0800
Message-Id: <20200724122045.17245-1-515672508@qq.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After read info complete,too many event registration functions are
not conducive to subsequent expansion.
---
 ...ent-callback-registration-optimizati.patch | 187 ++++++++++++++++++
 src/adapter.c                                 | 143 ++++----------
 2 files changed, 229 insertions(+), 101 deletions(-)
 create mode 100644 0001-src-adapter.c-Event-callback-registration-optimizati.patch

diff --git a/0001-src-adapter.c-Event-callback-registration-optimizati.patch b/0001-src-adapter.c-Event-callback-registration-optimizati.patch
new file mode 100644
index 000000000..d0f4804c6
--- /dev/null
+++ b/0001-src-adapter.c-Event-callback-registration-optimizati.patch
@@ -0,0 +1,187 @@
+From c2bf3d643c8f2eb7b97c0ede4396f879ba6febf8 Mon Sep 17 00:00:00 2001
+From: mac fanqiang <macfqiang@gmail.com>
+Date: Fri, 24 Jul 2020 17:42:37 +0800
+Subject: [PATCH] src/adapter.c : Event callback registration optimization    
+ After read info complete,too many event registration functions are not
+ conducive to subsequent expansion.     If we want to add a new event,
+ according to the previous logic, we must add an event registration function,
+ the code is too redundant.     Therefore, I added a global time callback
+ registration in this submission.     If you want to add event registration
+ later, you only need to add the new event and event callback function to the
+ global table.
+
+---
+ src/adapter.c | 143 +++++++++++++++-----------------------------------
+ 1 file changed, 42 insertions(+), 101 deletions(-)
+
+diff --git a/src/adapter.c b/src/adapter.c
+index 5e896a9f0..7afb4509d 100644
+--- a/src/adapter.c
++++ b/src/adapter.c
+@@ -298,6 +298,11 @@ struct btd_adapter {
+ 	bool le_simult_roles_supported;
+ };
+ 
++struct mgmt_callback{
++		uint16_t event;
++		mgmt_notify_func_t callback;
++};
++
+ typedef enum {
+ 	ADAPTER_AUTHORIZE_DISCONNECTED = 0,
+ 	ADAPTER_AUTHORIZE_CHECK_CONNECTED
+@@ -9163,6 +9168,41 @@ static void read_exp_features(struct btd_adapter *adapter)
+ 	btd_error(adapter->dev_id, "Failed to read exp features info");
+ }
+ 
++static struct mgmt_callback g_mgmt_callback_table[] = {
++	{MGMT_EV_NEW_SETTINGS, new_settings_callback},
++	{MGMT_EV_CLASS_OF_DEV_CHANGED, dev_class_changed_callback},
++	{MGMT_EV_LOCAL_NAME_CHANGED, local_name_changed_callback},
++	{MGMT_EV_DISCOVERING, discovering_callback},
++	{MGMT_EV_DEVICE_FOUND, device_found_callback},
++	{MGMT_EV_DEVICE_DISCONNECTED, disconnected_callback},
++	{MGMT_EV_DEVICE_CONNECTED, connected_callback},
++	{MGMT_EV_CONNECT_FAILED, connect_failed_callback},
++	{MGMT_EV_DEVICE_UNPAIRED, unpaired_callback},
++	{MGMT_EV_AUTH_FAILED, auth_failed_callback},
++	{MGMT_EV_NEW_LINK_KEY, new_link_key_callback},
++	{MGMT_EV_NEW_LONG_TERM_KEY, new_long_term_key_callback},
++	{MGMT_EV_NEW_CSRK, new_csrk_callback},
++	{MGMT_EV_NEW_IRK, new_irk_callback},
++	{MGMT_EV_NEW_CONN_PARAM, new_conn_param},
++	{MGMT_EV_DEVICE_BLOCKED, device_blocked_callback},
++	{MGMT_EV_DEVICE_UNBLOCKED, device_unblocked_callback},
++	{MGMT_EV_PIN_CODE_REQUEST, pin_code_request_callback},
++	{MGMT_EV_USER_CONFIRM_REQUEST, user_confirm_request_callback},
++	{MGMT_EV_USER_PASSKEY_REQUEST, user_passkey_request_callback},
++	{MGMT_EV_PASSKEY_NOTIFY, user_passkey_notify_callback}
++};
++
++static void mgmt_event_register(struct btd_adapter *adapter)
++{
++	int len = sizeof(g_mgmt_callback_table)/sizeof(g_mgmt_callback_table[0]);
++
++	for (int i = 0; i < len; i++) {
++		mgmt_register(adapter->mgmt, g_mgmt_callback_table[i].event, 
++					adapter->dev_id, g_mgmt_callback_table[i].callback,
++					adapter, NULL);
++	}
++}
++
+ static void read_info_complete(uint8_t status, uint16_t length,
+ 					const void *param, void *user_data)
+ {
+@@ -9288,107 +9328,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
+ 	 * controller info. From now on they can track updates and
+ 	 * notifications.
+ 	 */
+-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->dev_id,
+-					new_settings_callback, adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
+-						adapter->dev_id,
+-						dev_class_changed_callback,
+-						adapter, NULL);
+-	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
+-						adapter->dev_id,
+-						local_name_changed_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_DISCOVERING,
+-						adapter->dev_id,
+-						discovering_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_FOUND,
+-						adapter->dev_id,
+-						device_found_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_DISCONNECTED,
+-						adapter->dev_id,
+-						disconnected_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED,
+-						adapter->dev_id,
+-						connected_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_CONNECT_FAILED,
+-						adapter->dev_id,
+-						connect_failed_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_UNPAIRED,
+-						adapter->dev_id,
+-						unpaired_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_AUTH_FAILED,
+-						adapter->dev_id,
+-						auth_failed_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LINK_KEY,
+-						adapter->dev_id,
+-						new_link_key_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LONG_TERM_KEY,
+-						adapter->dev_id,
+-						new_long_term_key_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_CSRK,
+-						adapter->dev_id,
+-						new_csrk_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_IRK,
+-						adapter->dev_id,
+-						new_irk_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_CONN_PARAM,
+-						adapter->dev_id,
+-						new_conn_param,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_BLOCKED,
+-						adapter->dev_id,
+-						device_blocked_callback,
+-						adapter, NULL);
+-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_UNBLOCKED,
+-						adapter->dev_id,
+-						device_unblocked_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_PIN_CODE_REQUEST,
+-						adapter->dev_id,
+-						pin_code_request_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_USER_CONFIRM_REQUEST,
+-						adapter->dev_id,
+-						user_confirm_request_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_USER_PASSKEY_REQUEST,
+-						adapter->dev_id,
+-						user_passkey_request_callback,
+-						adapter, NULL);
+-
+-	mgmt_register(adapter->mgmt, MGMT_EV_PASSKEY_NOTIFY,
+-						adapter->dev_id,
+-						user_passkey_notify_callback,
+-						adapter, NULL);
+-
++	mgmt_event_register(adapter);
++	
+ 	set_dev_class(adapter);
+ 
+ 	set_name(adapter, btd_adapter_get_name(adapter));
+-- 
+2.20.1
+
diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..7afb4509d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -298,6 +298,11 @@ struct btd_adapter {
 	bool le_simult_roles_supported;
 };
 
+struct mgmt_callback{
+		uint16_t event;
+		mgmt_notify_func_t callback;
+};
+
 typedef enum {
 	ADAPTER_AUTHORIZE_DISCONNECTED = 0,
 	ADAPTER_AUTHORIZE_CHECK_CONNECTED
@@ -9163,6 +9168,41 @@ static void read_exp_features(struct btd_adapter *adapter)
 	btd_error(adapter->dev_id, "Failed to read exp features info");
 }
 
+static struct mgmt_callback g_mgmt_callback_table[] = {
+	{MGMT_EV_NEW_SETTINGS, new_settings_callback},
+	{MGMT_EV_CLASS_OF_DEV_CHANGED, dev_class_changed_callback},
+	{MGMT_EV_LOCAL_NAME_CHANGED, local_name_changed_callback},
+	{MGMT_EV_DISCOVERING, discovering_callback},
+	{MGMT_EV_DEVICE_FOUND, device_found_callback},
+	{MGMT_EV_DEVICE_DISCONNECTED, disconnected_callback},
+	{MGMT_EV_DEVICE_CONNECTED, connected_callback},
+	{MGMT_EV_CONNECT_FAILED, connect_failed_callback},
+	{MGMT_EV_DEVICE_UNPAIRED, unpaired_callback},
+	{MGMT_EV_AUTH_FAILED, auth_failed_callback},
+	{MGMT_EV_NEW_LINK_KEY, new_link_key_callback},
+	{MGMT_EV_NEW_LONG_TERM_KEY, new_long_term_key_callback},
+	{MGMT_EV_NEW_CSRK, new_csrk_callback},
+	{MGMT_EV_NEW_IRK, new_irk_callback},
+	{MGMT_EV_NEW_CONN_PARAM, new_conn_param},
+	{MGMT_EV_DEVICE_BLOCKED, device_blocked_callback},
+	{MGMT_EV_DEVICE_UNBLOCKED, device_unblocked_callback},
+	{MGMT_EV_PIN_CODE_REQUEST, pin_code_request_callback},
+	{MGMT_EV_USER_CONFIRM_REQUEST, user_confirm_request_callback},
+	{MGMT_EV_USER_PASSKEY_REQUEST, user_passkey_request_callback},
+	{MGMT_EV_PASSKEY_NOTIFY, user_passkey_notify_callback}
+};
+
+static void mgmt_event_register(struct btd_adapter *adapter)
+{
+	int len = sizeof(g_mgmt_callback_table)/sizeof(g_mgmt_callback_table[0]);
+
+	for (int i = 0; i < len; i++) {
+		mgmt_register(adapter->mgmt, g_mgmt_callback_table[i].event, 
+					adapter->dev_id, g_mgmt_callback_table[i].callback,
+					adapter, NULL);
+	}
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9288,107 +9328,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	 * controller info. From now on they can track updates and
 	 * notifications.
 	 */
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->dev_id,
-					new_settings_callback, adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
-						adapter->dev_id,
-						dev_class_changed_callback,
-						adapter, NULL);
-	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
-						adapter->dev_id,
-						local_name_changed_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_DISCOVERING,
-						adapter->dev_id,
-						discovering_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_FOUND,
-						adapter->dev_id,
-						device_found_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_DISCONNECTED,
-						adapter->dev_id,
-						disconnected_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED,
-						adapter->dev_id,
-						connected_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_CONNECT_FAILED,
-						adapter->dev_id,
-						connect_failed_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_UNPAIRED,
-						adapter->dev_id,
-						unpaired_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_AUTH_FAILED,
-						adapter->dev_id,
-						auth_failed_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LINK_KEY,
-						adapter->dev_id,
-						new_link_key_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LONG_TERM_KEY,
-						adapter->dev_id,
-						new_long_term_key_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_CSRK,
-						adapter->dev_id,
-						new_csrk_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_IRK,
-						adapter->dev_id,
-						new_irk_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_CONN_PARAM,
-						adapter->dev_id,
-						new_conn_param,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_BLOCKED,
-						adapter->dev_id,
-						device_blocked_callback,
-						adapter, NULL);
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_UNBLOCKED,
-						adapter->dev_id,
-						device_unblocked_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_PIN_CODE_REQUEST,
-						adapter->dev_id,
-						pin_code_request_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_USER_CONFIRM_REQUEST,
-						adapter->dev_id,
-						user_confirm_request_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_USER_PASSKEY_REQUEST,
-						adapter->dev_id,
-						user_passkey_request_callback,
-						adapter, NULL);
-
-	mgmt_register(adapter->mgmt, MGMT_EV_PASSKEY_NOTIFY,
-						adapter->dev_id,
-						user_passkey_notify_callback,
-						adapter, NULL);
-
+	mgmt_event_register(adapter);
+	
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
-- 
2.20.1



