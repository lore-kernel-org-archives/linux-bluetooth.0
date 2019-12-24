Return-Path: <SRS0=L7UJ=2O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9348CC3F68F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 05:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725BC2071A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 05:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfLXF0y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Dec 2019 00:26:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:5863 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfLXF0x (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Dec 2019 00:26:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 21:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="249713667"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2019 21:26:52 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] doc/obex-api: Update documentation
Date:   Tue, 24 Dec 2019 10:33:02 +0530
Message-Id: <1577163782-28759-2-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577163782-28759-1-git-send-email-ajay.kishore@intel.com>
References: <1577163782-28759-1-git-send-email-ajay.kishore@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds documentation with the conversation listing feature

Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
---
 doc/obex-api.txt | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index f39355a..8f27b40 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -892,3 +892,97 @@ Properties	string Folder [readonly]
 		boolean Protected [readonly]
 
 			Message protected flag
+
+Conversation Access hierarchy
+==============================
+
+Service		org.bluez.obex
+Interface	org.bluez.obex.Conversation1
+Object path	[Session object path]
+
+Methods		array{object, dict} ListConversations(string folder, dict filter)
+			Returns an array containing the conversations found in the
+			given subfolder of the current folder, or in the current
+			folder if folder is empty.
+
+			Possible Filters: MaxListCount, LastActivityBegin, LastActivityEnd,
+			ReadStatus, Recipient
+
+		Properties:
+			string id:
+
+				Conversation unique identification
+
+			string name:
+
+				Conversation name
+
+			string last_activity:
+
+				Conversation timestamp for the last activity
+
+			boolean read_status:
+
+				Conversation read flag
+
+			string version_counter:
+
+				128 bits version counter.
+				The 'Conversation-Listing Version Counter',
+				'Conversation Version Counter', and 'Folder
+				Version Counter' are used to detect if something
+				has changed
+
+			string summary:
+
+				Conversation summary
+
+			string display:
+
+				Conversation participants name
+
+			string chat_state:
+
+				Conversation current chat state of the participants
+
+			string presence_availability:
+
+				Conversation  participants availability
+
+			string presence_text:
+
+				User defined status of the conversation
+
+			uint16 priority:
+
+				Conversation participant priority
+
+		Possible errors: org.bluez.obex.Error.InvalidArguments
+				 org.bluez.obex.Error.Failed
+
+
+Filter:		uint16 MaxListCount:
+
+			Maximum number of items in the conversations.
+
+		string LastActivityBegin:
+
+			Filter conversations by starting period.
+
+			Possible values: Date in "YYYYMMDDTHHMMSS" format.
+
+		string LastActivityEnd:
+
+			Filter conversations by ending period.
+
+			Possible values: Date in "YYYYMMDDTHHMMSS" format.
+
+		boolean ReadStatus:
+
+			Filter converstions by read flag.
+
+			Possible values: True for read or False for unread
+
+		string Recipient:
+
+			Filter conversations by conversation-recipient.
-- 
2.7.4

