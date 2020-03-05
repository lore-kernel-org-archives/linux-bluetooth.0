Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E31C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809D421556
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgCEJS6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:18:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:48950 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCEJS6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 04:18:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 01:18:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="259126130"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2020 01:18:56 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] obexd: Handle MAP Event Report v1.1 and v1.2
Date:   Thu,  5 Mar 2020 14:25:23 +0530
Message-Id: <1583398524-18749-5-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
References: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to add handler function for the corresponding
events mentioned in extended event reports 1.1 and 1.2.
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
index 8a059ab..3bcb4a3 100644
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

