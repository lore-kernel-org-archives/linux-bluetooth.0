Return-Path: <SRS0=/Akc=U5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D91CC4646D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jun 2019 06:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312E62146E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jun 2019 06:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfF3GoA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Jun 2019 02:44:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:7277 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfF3GoA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Jun 2019 02:44:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 23:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,434,1557212400"; 
   d="scan'208";a="314543842"
Received: from ingas-nuc1.sea.intel.com ([10.254.64.161])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2019 23:44:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4 v4] test: test-mesh - Correctly stop periodic publication
Date:   Sat, 29 Jun 2019 23:43:56 -0700
Message-Id: <20190630064356.12660-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630064356.12660-1-inga.stotland@intel.com>
References: <20190630064356.12660-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the order of checks for an updated publication period:
check for zero period first, and if this is the case, stop sending
the periodic model publications.
---
 test/test-mesh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index c075a642b..4d515e186 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -606,15 +606,15 @@ class OnOffServer(Model):
 
 	def set_publication(self, period):
 
-		# We do not handle ms in this example
-		if period < 1000:
-			return
-
 		self.pub_period = period
 		if period == 0:
 			self.timer.cancel()
 			return
 
+		# We do not handle ms in this example
+		if period < 1000:
+			return
+
 		self.timer.start(period/1000, self.publish)
 
 	def publish(self):
-- 
2.21.0

