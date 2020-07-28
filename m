Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656AEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DF520825
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgG1SKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:10:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:19385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgG1SKx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 14:10:53 -0400
IronPort-SDR: WmWiqBpKZ97LzAmNOCWdSkirne2J1FrSpqZTUfK/UITGqhUt9qjI9ZhL6d188/JIfCL2lepYgP
 0smzNtvjHG0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="215796103"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="215796103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 11:10:52 -0700
IronPort-SDR: A6qK79H71M9Uxr+9EIltU83hE1/D66iPcYDMVG2RCIe0ZZBh2586bD4zeWucOOzVEevKqoabhf
 aOfFMTaLTVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="364586885"
Received: from rmangham-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.114.251])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2020 11:10:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix calculation of model publication period
Date:   Tue, 28 Jul 2020 11:10:51 -0700
Message-Id: <20200728181051.22075-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the extraction of bit fields from model publication
period octet received as part of Congif Publication Set message.

The step resolution field is extracted as upper 2 bits (shift by 6)
and the number of steps field is extracted by masking lower 6 bits.
---
 mesh/model.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 31197b363..ef7668147 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -170,20 +170,21 @@ static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
 
 static uint32_t pub_period_to_ms(uint8_t pub_period)
 {
-	int n;
+	int step_res, num_steps;
 
-	n = pub_period >> 2;
+	step_res = pub_period >> 6;
+	num_steps = pub_period & 0x3f;
 
-	switch (pub_period & 0x3) {
+	switch (step_res) {
 	default:
-		return n * 100;
+		return num_steps * 100;
 	case 2:
-		n *= 10;
+		num_steps *= 10;
 		/* Fall Through */
 	case 1:
-		return n * 1000;
+		return num_steps * 1000;
 	case 3:
-		return n * 10 * 60 * 1000;
+		return num_steps * 10 * 60 * 1000;
 	}
 }
 
-- 
2.26.2

