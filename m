Return-Path: <SRS0=aWoj=CD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCECC433E5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 00:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCCA2087D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 00:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHYAyp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:54:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:44195 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgHYAyn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 20:54:43 -0400
IronPort-SDR: tHl5xcxHckPbEoJKAqGT991MYJC2doLiu0CCHLoZJHXCgNCR8yrvkvFEepF8Fk3fa1Opf8lOFI
 7vTBMtoudLsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143797447"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143797447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:54:42 -0700
IronPort-SDR: H1tmZAIrESaOoqzHutOja3NmImT0oOy4u5tNmKGf8URnv2tUa5loqM4A0YtoViTgwvEggQUIsG
 16iS5SuQYCIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474141849"
Received: from apaharia-mobl.gar.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.231.108])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2020 17:54:42 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 4/4] test/test-mesh: Add "options" to Send/Publish
Date:   Mon, 24 Aug 2020 17:54:35 -0700
Message-Id: <20200825005435.26566-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825005435.26566-1-inga.stotland@intel.com>
References: <20200825005435.26566-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new dictionary paramenter (empty by default) when
invoking Send() or Publish() methods.
---
 test/test-mesh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 5da0278d6..1e1b8724d 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -184,6 +184,9 @@ current_menu = None
 user_input = 0
 input_error = False
 
+send_opts = dbus.Dictionary(signature='sv')
+send_opts = {'ForceSegmented' : dbus.Boolean(True)}
+
 def raise_error(str_value):
 	global input_error
 
@@ -538,14 +541,18 @@ class Model():
 		self.pub_period = period
 
 	def send_publication(self, data):
+		pub_opts = dbus.Dictionary(signature='sv')
+
 		print('Send publication ', end='')
 		print(data)
-		node.Publish(self.path, self.model_id, data,
+		node.Publish(self.path, self.model_id, pub_opts, data,
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

