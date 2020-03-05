Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFFFC3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0642146E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCEJSy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:18:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:48950 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCEJSy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 04:18:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 01:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="259126118"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2020 01:18:52 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] obexd: Add parsers for conversation filters
Date:   Thu,  5 Mar 2020 14:25:20 +0530
Message-Id: <1583398524-18749-2-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
References: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to add a new method to parse the map conversation filters.
Filters LastActivityBegin and LastActivityEnd is used to filter the
conversations that are returned in the Conversation-Listing object by
LastActivity.
---
 obexd/client/map.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 obexd/src/map_ap.h |  3 +++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index adf62d9..6e84a73 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1369,6 +1369,21 @@ static GObexApparam *parse_filter_type(GObexApparam *apparam,
 									types);
 }
 
+static GObexApparam *parse_la_begin(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	return g_obex_apparam_set_string(apparam,
+					MAP_AP_FILTERLASTACTIVITYBEGIN,
+					string);
+}
+
 static GObexApparam *parse_period_begin(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
@@ -1397,6 +1412,20 @@ static GObexApparam *parse_period_end(GObexApparam *apparam,
 								string);
 }
 
+static GObexApparam *parse_la_end(GObexApparam *apparam,
+						DBusMessageIter *iter)
+{
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	return g_obex_apparam_set_string(apparam, MAP_AP_FILTERLASTACTIVITYEND,
+								string);
+}
+
 static GObexApparam *parse_filter_read(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
@@ -1560,6 +1589,19 @@ static DBusMessage *map_list_messages(DBusConnection *connection,
 	return get_message_listing(map, message, folder, apparam);
 }
 
+static GObexApparam *parse_filter_conv_id(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint8 id;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &id);
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_CONVERSATIONID, id);
+}
+
 static GObexApparam *parse_conversation_filters(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
@@ -1582,8 +1624,28 @@ static GObexApparam *parse_conversation_filters(GObexApparam *apparam,
 		dbus_message_iter_next(&entry);
 		dbus_message_iter_recurse(&entry, &value);
 
-		/* TODO: Parse conversation filters */
-
+		if (strcasecmp(key, "Offset") == 0) {
+			if (parse_offset(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "MaxCount") == 0) {
+			if (parse_max_count(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "LastActivityBegin") == 0) {
+			if (parse_la_begin(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "FilterLastActivityEnd") == 0) {
+			if (parse_la_end(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Read") == 0) {
+			if (parse_filter_read(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Recipient") == 0) {
+			if (parse_filter_recipient(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "ConversationId") == 0) {
+			if (parse_filter_conv_id(apparam, &value) == NULL)
+				return NULL;
+		}
 		dbus_message_iter_next(&array);
 	}
 	return apparam;
diff --git a/obexd/src/map_ap.h b/obexd/src/map_ap.h
index da108fe..3773859 100644
--- a/obexd/src/map_ap.h
+++ b/obexd/src/map_ap.h
@@ -31,6 +31,8 @@ enum map_ap_tag {
 	MAP_AP_FILTERREADSTATUS		= 0x06,		/* uint8_t	*/
 	MAP_AP_FILTERRECIPIENT		= 0x07,		/* char *	*/
 	MAP_AP_FILTERORIGINATOR		= 0x08,		/* char *	*/
+	MAP_AP_FILTERLASTACTIVITYBEGIN	= 0x08,		/* char *       */
+	MAP_AP_FILTERLASTACTIVITYEND	= 0x09,		/* char *       */
 	MAP_AP_FILTERPRIORITY		= 0x09,		/* uint8_t	*/
 	MAP_AP_ATTACHMENT		= 0x0A,		/* uint8_t	*/
 	MAP_AP_TRANSPARENT		= 0x0B,		/* uint8_t	*/
@@ -48,4 +50,5 @@ enum map_ap_tag {
 	MAP_AP_STATUSINDICATOR		= 0x17,		/* uint8_t	*/
 	MAP_AP_STATUSVALUE		= 0x18,		/* uint8_t	*/
 	MAP_AP_MSETIME			= 0x19,		/* char *	*/
+	MAP_AP_CONVERSATIONID		= 0x1C,		/* uint32_t     */
 };
-- 
2.7.4

