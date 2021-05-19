Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A43C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A920611BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhESSXa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:23:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:32191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhESSX3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:23:29 -0400
IronPort-SDR: PsRJGOu4OwUPD/fpi8duRTCSQhbmwGRurFjWaOE6Dz8yWNNrBZSUhcZJSyX+ihqWlRsiXA2gvh
 ESqn1LDwzLsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188175118"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188175118"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:09 -0700
IronPort-SDR: ATRA+w8Kdkj4KACmA5fpvmMWQIma0G/xk+AYIXQ83w7Wlwv/3mRqKNY5qaYN5JauevQ4AyJdQv
 GlTenjXglPlw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439838641"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:08 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 0/5] OOB Authentication improvements
Date:   Wed, 19 May 2021 11:21:45 -0700
Message-Id: <20210519182150.1680987-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set fixes some minor bugs, and adds explicit support for all
currently supported Provisioning authentication methods.

v2: Added prov-acceptor queuing, and fixed whitespace issues

Brian Gix (5):
  mesh: Fix delivery of PB-ACK to acceptors
  nesh: Normalize endian of public/private ECC keys
  tools/mesh: Add all supported OOB methods to cfgclient
  test/mesh: Add support for testing more OOB auth
  mesh: Add single threading to prov-acp ob messaging

 mesh/pb-adv.c          |  1 -
 mesh/prov-acceptor.c   | 96 +++++++++++++++++++++++++++---------------
 mesh/prov-initiator.c  |  3 ++
 mesh/provision.h       |  1 +
 test/agent.py          | 23 ++++++++++
 tools/mesh-cfgclient.c | 32 +++++++++++---
 6 files changed, 116 insertions(+), 40 deletions(-)

-- 
2.25.4

