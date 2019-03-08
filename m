Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70885C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4968B206DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCHW6X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:58:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:23709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfCHW6X (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 17:58:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 14:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="120994271"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.43])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 14:58:22 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/3] Save and restore mesh models pub/sub settings
Date:   Fri,  8 Mar 2019 14:58:17 -0800
Message-Id: <20190308225820.20561-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set implements the following:
- Write updates of node model subscriptions to node config file
- Write updates of node model publication settings to node config file
- Correctly restore subscriptions and publications on daemon startup

Inga Stotland (3):
  mesh: Add json config functions to save pub/sub updates
  mesh: Save model subscription updates to config file
  mesh: Store model publication settings in config file

 mesh/cfgmod-server.c | 104 +++++++++++++++-
 mesh/mesh-db.c       | 282 ++++++++++++++++++++++++++++++++++++++++++-
 mesh/mesh-db.h       |  15 ++-
 mesh/model.c         |  22 ++--
 4 files changed, 404 insertions(+), 19 deletions(-)

-- 
2.17.2

