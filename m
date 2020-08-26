Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FDC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9DF2078B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHZQyb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:54:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:2014 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgHZQy3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 12:54:29 -0400
IronPort-SDR: pAg5h1zIqlAJVn5V2l8ClCMpKAIp8rgrpC2pRdo0fJdvNqMYK+BtFQi6rYFdltBLdEepvhv9av
 3fRSsVPmXXdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135883623"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135883623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:54:27 -0700
IronPort-SDR: AU+5rklClgwUa1JUQIrb9iOmVgZTWNzS5Og575e5vcHtbZb2DGjveA5CZeyXoc8eXoOXRek8OT
 Iu2bq7Z92tEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="331851977"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.63.130])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 09:54:27 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 4/4] test/test-mesh: Add "options" to Send/Publish
Date:   Wed, 26 Aug 2020 09:54:20 -0700
Message-Id: <20200826165420.563822-5-brian.gix@intel.com>
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
2.25.4

