Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E629C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F4920721
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE2Ghx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 02:37:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:53719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2Ghw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 02:37:52 -0400
IronPort-SDR: W3uHbsPRr3YjX5Ac2c4UHxw2gGehvJMYFyVYbz7vx0Oraxz/dl8jAMFlOIm24B669lPyeTEb3y
 qVXqpArkwXSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:37:52 -0700
IronPort-SDR: opS+C7n5Nb+YMPCJRXNGdhDr5R8bKSPC/zjphbLzr97YQhjIyePDmOjxb0AF4HxBjusJbLT0za
 zOjYjiT53gSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="257260583"
Received: from dmikkels-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.187])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2020 23:37:51 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/5] Mesh clean up
Date:   Thu, 28 May 2020 23:37:45 -0700
Message-Id: <20200529063750.186278-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

No functional changes: cleaned up debug output so that
hex print is not executed if debug is not enabled.

Style cleanup in net.c. Removed unused functions from net.h/net.c

Inga Stotland (5):
  mesh: Make helper packet print depends on debug setting
  mesh: Debug output clean up
  mesh: Remove debug-only related callback for packet send
  mesh: Clean up style in net.c
  mesh: Remove unused functions from net.c

 mesh/main.c            |   3 +-
 mesh/manager.c         |   6 +-
 mesh/mesh-io-generic.c |   3 +-
 mesh/model.c           |  53 +---
 mesh/net.c             | 572 +++++++++++------------------------------
 mesh/net.h             |  30 +--
 mesh/pb-adv.c          |   7 +-
 mesh/prov-initiator.c  |   2 +-
 mesh/util.c            |  11 +
 mesh/util.h            |   1 +
 10 files changed, 180 insertions(+), 508 deletions(-)

-- 
2.26.2

