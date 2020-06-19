Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D19B21924
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 21:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFSV06 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:26:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:21821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgFSV05 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 17:26:57 -0400
IronPort-SDR: H8eb1vNU4Puaceb6pBlwSI9UPKB9SJnHmZLytmPpKLepAQPmNi3xt2tG97mCcVJdFWAcXqtou/
 00n00A0PLukw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="143045072"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="143045072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 14:26:56 -0700
IronPort-SDR: er9eYI5XSEQe+YCS7AEDcUbogNNNLCbXTz+o2PRXN3MznN65WZSvr5LLHYxK8/7M980uQq6+16
 0YW3VjJOpq/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="292246221"
Received: from pafleisc-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.109.121])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2020 14:26:56 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/3] Blacklist addresses of deleted nodes
Date:   Fri, 19 Jun 2020 14:26:52 -0700
Message-Id: <20200619212655.107839-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set adds a notion of blacklisted addresses for nodes that
have been removed from mesh network.
The addresses of nodes that have been removed should not be added
back into available unicast addresses pool (for assigning to newly
provisioned nodes) until mesh-wide IV Index is changed at least twice 

Inga Stotland (3):
  mesh: Emit PropertiesChanged when IV Index changes
  tools/mesh-cfgclient: get/set IV index
  tools/mesh-cfgclient: add list of blacklisted addresses

 mesh/net.c             |   2 +
 mesh/node.c            |   9 +++
 mesh/node.h            |   1 +
 tools/mesh-cfgclient.c |  41 +++++++++-
 tools/mesh/mesh-db.c   | 170 +++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h   |   5 +-
 tools/mesh/remote.c    | 110 +++++++++++++++++++++++---
 tools/mesh/remote.h    |   3 +
 8 files changed, 329 insertions(+), 12 deletions(-)

-- 
2.26.2

