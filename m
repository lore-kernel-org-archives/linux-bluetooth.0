Return-Path: <SRS0=Xed5=37=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E9C3B186
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 06:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFAD206D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 06:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBKG7J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:59:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:10653 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgBKG7J (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Feb 2020 01:59:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 22:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; 
   d="scan'208";a="405849911"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 22:59:08 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] doc/obex-api: Update documentation
Date:   Tue, 11 Feb 2020 12:06:10 +0530
Message-Id: <1581402970-1781-6-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581402970-1781-1-git-send-email-ajay.kishore@intel.com>
References: <1581402970-1781-1-git-send-email-ajay.kishore@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds documentation with the conversation listing feature
---
 doc/obex-api.txt | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index f39355a..ef81460 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -712,6 +712,44 @@ Methods		void SetFolder(string name)
 			Possible errors: org.bluez.obex.Error.InvalidArguments
 					 org.bluez.obex.Error.Failed
 
+		array{object, dict} ListConversations(string folder, dict filter)
+
+			Returns an array containing the conversations found in the
+			given subfolder of the current folder, or in the current
+			folder if folder is empty.
+
+			Possible Filters: MaxListCount, LastActivityBegin, LastActivityEnd,
+			ReadStatus, Recipient
+
+			Each message is represented by an object path followed
+			by a dictionary of the properties.
+
+			Properties:
+
+				string id:
+
+					Conversation unique identification
+
+				string last_activity:
+
+					Conversation timestamp for the last activity
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
+			Possible errors: org.bluez.obex.Error.InvalidArguments
+					 org.bluez.obex.Error.Failed
+
+
 		void UpdateInbox(void)
 
 			Request remote to update its inbox.
@@ -799,6 +837,18 @@ Filter:		uint16 Offset:
 			Possible values: True for high priority or False for
 			non-high priority
 
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
 Message hierarchy
 =================
 
-- 
2.7.4

