Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D92C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B0E2084D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgG3Uiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:38:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:35025 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgG3Uix (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 16:38:53 -0400
IronPort-SDR: ZLJFCJmEXNSdqti77Gkp/CBi4rNpRj6l0jzY1a3NwEi8i1pdPcvtG/z4VwqmN4+FpESPpQaxOR
 ESEziYAA+/dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169803084"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="169803084"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 13:38:52 -0700
IronPort-SDR: Peh0QPxfNF13JYDqdHy/1Tj2qXIlWpFDkta8EL9FQNkvPoSanhIKYHCMGQJPGdpr5McemLaXQ/
 FsJ11N8FrUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="330864943"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 13:38:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 00/10] Clean up Config Server
Date:   Thu, 30 Jul 2020 13:38:41 -0700
Message-Id: <20200730203851.32043-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set cleans up implementation of config server.
Specifically, all the response status messages are sent from
a single point.

Along the way, some behavioral inconsistencies are fixed like
ignoring more malformed messages, returning correct error
status codes.

Inga Stotland (10):
  mesh: Clean up handling of config subscription messages
  mesh: Clean up handling of config model binding messages
  mesh: Clean up handling of config node identity message
  mesh: Clean up handling of config publication messages
  mesh: Clean up handling of config net and app key messages
  mesh: Clean up handling of config relay messages
  mesh: Clean up handling of config poll timeout message
  mesh: Clean up handling of config net transmit messages
  mesh: Clean up handling of config KR phase messages
  mesh: Refactor heartbeat pub/sub

 mesh/cfgmod-server.c    | 1149 ++++++++++++++++-----------------------
 mesh/cfgmod.h           |    2 +-
 mesh/mesh-config-json.c |   12 +-
 mesh/mesh-config.h      |    6 +-
 mesh/model.c            |  227 ++++----
 mesh/model.h            |   21 +-
 mesh/net.c              |  273 +++++++---
 mesh/net.h              |   48 +-
 8 files changed, 851 insertions(+), 887 deletions(-)

-- 
2.26.2

