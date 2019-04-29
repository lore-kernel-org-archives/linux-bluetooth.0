Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415CDC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12226215EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfD2TpL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:45:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:27048 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2TpL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 15:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 12:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="144648055"
Received: from ingas-nuc1.sea.intel.com ([10.252.200.123])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2019 12:45:10 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] Cleanup of org.bluez.mesh.Network1 interface
Date:   Mon, 29 Apr 2019 12:45:05 -0700
Message-Id: <20190429194509.3378-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches tightens the existing implementation of Join() and
Attach() methods. Some redundacies are removed, common code is combined and
validation of node composition is added for Attach method.

Inga Stotland (4):
  mesh: Remove Node interface if node owner disconnects
  mesh: Clean up processing of Attach() method
  mesh: Consolidate processing of mesh element properties
  mesh: Unify processing of GetManagedObjects result

 mesh/mesh-defs.h |   2 +
 mesh/mesh.c      |  69 +++---
 mesh/node.c      | 558 ++++++++++++++++++++++++++---------------------
 mesh/node.h      |   9 +-
 4 files changed, 344 insertions(+), 294 deletions(-)

-- 
2.17.2

