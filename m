Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E589C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DBC205ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLPJxE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:53:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:4377 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfLPJxE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 04:53:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 01:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="364976289"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 01:53:03 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] doc/obex-api: Update documentation
Date:   Mon, 16 Dec 2019 14:58:28 +0530
Message-Id: <1576488509-26331-1-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds documentation with the conversation listing feature

Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
---
 doc/obex-api.txt | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index f39355a..9a76159 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -712,6 +712,71 @@ Methods		void SetFolder(string name)
 			Possible errors: org.bluez.obex.Error.InvalidArguments
 					 org.bluez.obex.Error.Failed
 
+
+
+		array{object, dict} listconversations(string folder, dict filter)
+			Returns an array containing the conversations found in the
+			given subfolder of the current folder, or in the current
+			folder if folder is empty.
+
+			Possible Filters: LastActivityBegin, LastActivityEnd,
+			ReadStatus, Recipient
+
+
+			Properties:
+
+				string id:
+
+					Conversation unique identification
+
+				string name:
+
+					Conversation name
+
+				string last_activity:
+
+					Conversation timestamp for the last activity
+
+				boolean read_status:
+
+					Conversation read flag
+
+				string version_counter:
+
+					128 bits version counter.
+					The ‘Conversation-Listing Version Counter’,
+					‘Conversation Version Counter’, and ‘Folder
+					Version Counter’ are used to detect if something
+					has changed
+
+				string summary:
+
+					Conversation summary
+
+				string display:
+
+					Conversation participants name
+
+				string chat_state:
+
+					Conversation current chat state of the participants
+
+				string presence_availability:
+
+					Conversation  participants availability
+
+				string presence_text:
+
+					User defined status of the conversation
+
+				uint16 priority:
+
+					Conversation participant priority
+
+			Possible errors: org.bluez.obex.Error.InvalidArguments
+					 org.bluez.obex.Error.Failed
+
+
 		void UpdateInbox(void)
 
 			Request remote to update its inbox.
-- 
2.7.4

