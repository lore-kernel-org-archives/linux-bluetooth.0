Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF86C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275F62071E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgHXDyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Aug 2020 23:54:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:64622 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgHXDyT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Aug 2020 23:54:19 -0400
IronPort-SDR: Y9fTsTkdclU8y1P9pKIap9+Dqx7vi1dup1ZI21ncB1GdOvFeo6CfaLmzLb1ZATs0nyql8M1yho
 FG8caJFcCfRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220106403"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="220106403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 20:54:19 -0700
IronPort-SDR: uBAWpxkAW+8fNMdxbjOnomFUqqhUiKzvTQt8pd1QP2mbTEzgf0bzckcOHudCpcRYpwhluGVjsy
 oU2X3zySH07Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="322017102"
Received: from jlpajela-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.252.134.16])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2020 20:54:19 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] test/test-mesh: Add "options" to Send/Publish
Date:   Sun, 23 Aug 2020 20:54:15 -0700
Message-Id: <20200824035415.13420-5-inga.stotland@intel.com>
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
invoking Send() or Publish() methods.
---
 test/test-mesh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 5da0278d6..918ec8799 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -183,6 +183,8 @@ current_menu = None
 
 user_input = 0
 input_error = False
+#send_opts = {'ForcedSegmented' : dbus.Boolean(False)}
+send_opts = dbus.Dictionary(signature='sv')
 
 def raise_error(str_value):
 	global input_error
@@ -538,14 +540,18 @@ class Model():
 		self.pub_period = period
 
 	def send_publication(self, data):
+		global send_opts
+
 		print('Send publication ', end='')
 		print(data)
-		node.Publish(self.path, self.model_id, data,
+		node.Publish(self.path, self.model_id, send_opts, data,
 						reply_handler=generic_reply_cb,
 						error_handler=generic_error_cb)
 
 	def send_message(self, dest, key, data):
-		node.Send(self.path, dest, key, data,
+		global send_opts
+
+		node.Send(self.path, dest, key, send_opts, data,
 						reply_handler=generic_reply_cb,
 						error_handler=generic_error_cb)
 
-- 
2.26.2

