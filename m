Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068CCC433E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE0A20774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgHXDyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Aug 2020 23:54:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:64622 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgHXDyT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Aug 2020 23:54:19 -0400
IronPort-SDR: UuRAfZvCdXJpz/6l/IAbAQoLDRDiZKBc/IIFT2pWmU6K2eC2cTH4oBhcR0IGtpon5bwN6XSknf
 ZvXt6Yws6UEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220106401"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="220106401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 20:54:18 -0700
IronPort-SDR: 8NgeNABJoNFHhGcMG+Aa6pMKKL1WbzOeCZc4cM4h+2AbGusKIEifsyh0XLK0L8OqAHbxDOsjhJ
 CE4roO0Llw6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="322017099"
Received: from jlpajela-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.252.134.16])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2020 20:54:18 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4] tools/mesh-cfglient: Add "options" to Send/DevKeySend
Date:   Sun, 23 Aug 2020 20:54:14 -0700
Message-Id: <20200824035415.13420-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824035415.13420-1-inga.stotland@intel.com>
References: <20200824035415.13420-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
2.26.2

