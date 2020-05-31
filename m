Return-Path: <SRS0=oW7/=7N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE99C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 May 2020 04:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7426206F1
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 May 2020 04:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgEaElb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 May 2020 00:41:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:59354 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEaElb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 May 2020 00:41:31 -0400
IronPort-SDR: 4MwPFLzPg8quLoApR0v6Nz/xsrrZ9cIeYUZ9+5wLXhFJnxEy/+IFLAcVBrIZlRk+MOG2iy7/A1
 AATwJhZYiqcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 21:41:30 -0700
IronPort-SDR: 43E04IrU0Wm3sXu8EQhudTRyb3PaaaSCh9d4G6SeRQVKJXBmnc12MKS3trm8zKpa55BvXTjKNp
 quiW0etM4ZQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,455,1583222400"; 
   d="scan'208";a="377087033"
Received: from rfcheney-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.68.158])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2020 21:41:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 0/5] Mesh clean up
Date:   Sat, 30 May 2020 21:41:23 -0700
Message-Id: <20200531044128.16734-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2: Restored some debug output related to model configuration state

**********
No functional changes: cleaned up debug output so that
hex print is not executed if debug is not enabled.

Style cleanup in net.c. Removed unused functions from net.h/net.c

Inga Stotland (5):
  mesh: Helper packet print should depend on debug setting
  mesh: Debug output clean up
  mesh: Remove debug-only related callback for packet send
  mesh: Clean up style in net.c
  mesh: Remove unused functions from net.c

 mesh/main.c            |   3 +-
 mesh/manager.c         |   6 +-
 mesh/mesh-io-generic.c |   3 +-
 mesh/model.c           |  52 +---
 mesh/net.c             | 572 +++++++++++------------------------------
 mesh/net.h             |  30 +--
 mesh/pb-adv.c          |   7 +-
 mesh/prov-initiator.c  |   2 +-
 mesh/util.c            |  11 +
 mesh/util.h            |   1 +
 10 files changed, 182 insertions(+), 505 deletions(-)

-- 
2.26.2

