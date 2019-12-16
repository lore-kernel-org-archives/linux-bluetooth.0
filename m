Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD6C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B17320725
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLPJxR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:53:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:2698 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfLPJxR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 04:53:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 01:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="364976355"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 01:53:15 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] obexd: Handle MAP Event Report v1.1 and v1.2
Date:   Mon, 16 Dec 2019 14:58:29 +0530
Message-Id: <1576488509-26331-2-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576488509-26331-1-git-send-email-ajay.kishore@intel.com>
References: <1576488509-26331-1-git-send-email-ajay.kishore@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to add handler function for the corresponding
events mentioned in extended event reports 1.1 and 1.2.

Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
---
 obexd/client/map-event.h |  8 +++++++-
 obexd/client/map.c       | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
index 5414b26..c41bb67 100644
--- a/obexd/client/map-event.h
+++ b/obexd/client/map-event.h
@@ -32,7 +32,13 @@ enum map_event_type {
 	MAP_ET_MEMORY_FULL,
 	MAP_ET_MEMORY_AVAILABLE,
 	MAP_ET_MESSAGE_DELETED,
-	MAP_ET_MESSAGE_SHIFT
+	MAP_ET_MESSAGE_SHIFT,
+	MAP_ET_READ_STATUS_CHANGED,
+	MAP_ET_MESSAGE_REMOVED,
+	MAP_ET_MESSAGE_EXTENDED_DATA_CHANGED,
+	MAP_ET_PARTICIPANT_PRESENCE_CHANGED,
+	MAP_ET_PARTICIPANT_CHAT_STATE_CHANGED,
+	MAP_ET_CONVERSATION_CHANGED
 };
 
 struct map_event {
diff --git a/obexd/client/map.c b/obexd/client/map.c
index b65131a..846794f 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -2550,6 +2550,12 @@ static void map_handle_folder_changed(struct map_data *map,
 								"Folder");
 }
 
+static void map_handle_remove_message(struct map_data *map,
+						struct map_event *event)
+{
+	g_hash_table_remove(map->messages, &event->handle);
+}
+
 static void map_handle_notification(struct map_event *event, void *user_data)
 {
 	struct map_data *map = user_data;
@@ -2582,6 +2588,19 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_MESSAGE_SHIFT:
 		map_handle_folder_changed(map, event, event->folder);
 		break;
+	case MAP_ET_READ_STATUS_CHANGED:
+		map_handle_status_changed(map, event, "read");
+		break;
+	case MAP_ET_MESSAGE_REMOVED:
+		map_handle_remove_message(map, event);
+		break;
+	case MAP_ET_MESSAGE_EXTENDED_DATA_CHANGED:
+		map_handle_status_changed(map, event,
+					"message-extended-data-changed");
+		break;
+	case MAP_ET_PARTICIPANT_PRESENCE_CHANGED:
+	case MAP_ET_PARTICIPANT_CHAT_STATE_CHANGED:
+	case MAP_ET_CONVERSATION_CHANGED:
 	case MAP_ET_MEMORY_FULL:
 	case MAP_ET_MEMORY_AVAILABLE:
 	default:
-- 
2.7.4

