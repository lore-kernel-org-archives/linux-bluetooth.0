Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FDDC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4082146E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEJSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:18:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:48950 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCEJSz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 04:18:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 01:18:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="259126122"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2020 01:18:54 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] obexd: Get conversation listings
Date:   Thu,  5 Mar 2020 14:25:21 +0530
Message-Id: <1583398524-18749-3-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
References: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to build get conversation listing command and its
respective callback function to handle response for conversation
listing.
---
 obexd/client/map.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 6e84a73..4f3d6c5 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1221,6 +1221,64 @@ clean:
 	pending_request_free(request);
 }
 
+static void conversation_listing_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	struct pending_request *request = user_data;
+	struct map_parser *parser;
+	GMarkupParseContext *ctxt;
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	char *contents;
+	size_t size;
+	int perr;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(request->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", err->message);
+		goto done;
+	}
+
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(request->msg,
+						ERROR_INTERFACE ".Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(request->msg);
+	if (reply == NULL) {
+		g_free(contents);
+		goto clean;
+	}
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+
+	dbus_message_iter_close_container(&iter, &array);
+	g_free(contents);
+
+done:
+	if (convo_element_end)
+		if (g_dbus_send_message(conn, reply))
+			convo_element_end = FALSE;
+clean:
+	pending_request_free(request);
+}
+
 static char *get_absolute_folder(struct map_data *map, const char *subfolder)
 {
 	const char *root = obc_session_get_folder(map->session);
@@ -1269,6 +1327,43 @@ fail:
 	return reply;
 }
 
+static DBusMessage *get_conversations_listing(struct map_data *map,
+							DBusMessage *message,
+							const char *folder,
+							GObexApparam *apparam)
+{
+	struct pending_request *request;
+	struct obc_transfer *transfer;
+	GError *err = NULL;
+	DBusMessage *reply;
+
+	transfer = obc_transfer_get("x-bt/MAP-convo-listing", folder, NULL,
+									&err);
+
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
+		goto fail;
+	}
+	obc_transfer_set_apparam(transfer, apparam);
+
+	request = pending_request_new(map, message);
+	request->folder = get_absolute_folder(map, folder);
+
+	if (!obc_session_queue(map->session, transfer,
+				conversation_listing_cb, request, &err)) {
+		pending_request_free(request);
+		goto fail;
+	}
+
+	return NULL;
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+}
+
 static GObexApparam *parse_subject_length(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
@@ -1681,8 +1776,7 @@ static DBusMessage *map_list_conversations(DBusConnection *connection,
 			ERROR_INTERFACE ".InvalidArguments", NULL);
 	}
 
-	/*TODO: Return conversation listing */
-	return NULL;
+	return get_conversations_listing(map, message, folder, apparam);
 }
 
 static char **get_filter_strs(uint64_t filter, int *size)
-- 
2.7.4

