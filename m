Return-Path: <SRS0=Xed5=37=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E8C352A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 06:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2DA2082F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 06:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBKG7E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:59:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:10653 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgBKG7E (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Feb 2020 01:59:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 22:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; 
   d="scan'208";a="405849840"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 22:59:00 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] obexd: Add initial support for MAP conversations
Date:   Tue, 11 Feb 2020 12:06:05 +0530
Message-Id: <1581402970-1781-1-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to add a new method for MAP conversation listing i.e
"ListConversations" to handle conversation listing object
"x-bt/MAP-convo-listing".
---
 obexd/client/map.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 550c5af..adf62d9 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1560,6 +1560,69 @@ static DBusMessage *map_list_messages(DBusConnection *connection,
 	return get_message_listing(map, message, folder, apparam);
 }
 
+static GObexApparam *parse_conversation_filters(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		DBG("Not of type array");
+		return NULL;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		/* TODO: Parse conversation filters */
+
+		dbus_message_iter_next(&array);
+	}
+	return apparam;
+}
+
+static DBusMessage *map_list_conversations(DBusConnection *connection,
+						DBusMessage *message,
+						void *user_data)
+{
+	struct map_data *map = user_data;
+	const char *folder;
+	GObexApparam *apparam;
+	DBusMessageIter args;
+
+	dbus_message_iter_init(message, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+			ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &folder);
+
+	apparam = g_obex_apparam_set_uint16(NULL, MAP_AP_MAXLISTCOUNT,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, MAP_AP_STARTOFFSET,
+							DEFAULT_OFFSET);
+
+	dbus_message_iter_next(&args);
+
+	if (parse_conversation_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+			ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	/*TODO: Return conversation listing */
+	return NULL;
+}
+
 static char **get_filter_strs(uint64_t filter, int *size)
 {
 	char **list, **item;
@@ -1817,6 +1880,10 @@ static const GDBusMethodTable map_methods[] = {
 			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{sv}" }),
 			GDBUS_ARGS({ "messages", "a{oa{sv}}" }),
 			map_list_messages) },
+	{ GDBUS_ASYNC_METHOD("ListConversations",
+			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{sv}" }),
+			GDBUS_ARGS({ "conversations", "a{oa{sv}}" }),
+			map_list_conversations) },
 	{ GDBUS_METHOD("ListFilterFields",
 			NULL,
 			GDBUS_ARGS({ "fields", "as" }),
-- 
2.7.4

