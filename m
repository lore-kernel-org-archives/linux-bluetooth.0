Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0760C433E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07DB2078B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHZQyb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:54:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:2013 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZQy3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 12:54:29 -0400
IronPort-SDR: P1UUjfiM24j7JajYvaEIlsTcvzcrAZ2EN1pXChSDxgI9C99HKfN/YyS2hgO8w9WtMs3iw2f0LB
 60WSkeqgvd4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135883622"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135883622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:54:27 -0700
IronPort-SDR: C5C65wsWoyGZrGzPEP4yTggIAUM1Mfe8WK6Tvq49A3Ozks4SLBXXb8ltQyqpWohctuop58quPN
 Kro1tFRzrgYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="331851974"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.63.130])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 09:54:26 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 3/4] tools/mesh-cfglient: Add "options" to Send/DevKeySend
Date:   Wed, 26 Aug 2020 09:54:19 -0700
Message-Id: <20200826165420.563822-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200826165420.563822-1-brian.gix@intel.com>
References: <20200826165420.563822-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

This adds a new dictionary paramenter (empty by default) when
invoking Send() and DevKeySend() methods.
---
 tools/mesh-cfgclient.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 59f079213..3987e3179 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -274,6 +274,14 @@ static void send_msg_setup(struct l_dbus_message *msg, void *user_data)
 		l_dbus_message_builder_append_basic(builder, 'b', &req->rmt);
 
 	l_dbus_message_builder_append_basic(builder, 'q', &req->idx);
+
+	/* Options */
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+
+	/* Data */
 	append_byte_array(builder, req->data, req->len);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
-- 
2.25.4

