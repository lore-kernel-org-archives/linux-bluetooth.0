Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66517C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379566197D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 20:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSUix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:38:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:18065 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCSUie (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Mar 2021 16:38:34 -0400
IronPort-SDR: 2XfK+d6EEqxVo7Dp2L/ixJKlR/8vBItG5die71pBATpY3wcM4xyEa+bLUD2i543WT+bq2lmINL
 LsgSbiyYc4qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="253964217"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="253964217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 13:38:34 -0700
IronPort-SDR: v+gV8QmHqBPIAq/hygfFtmEPb4TkRMrUy1W8HF5EdTO5QwvsCOsNEucfzu4i27TMqaswyQMYjA
 MQBEhcE6bk9g==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406934868"
Received: from rkuhnis-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.65.199])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 13:38:32 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     brian.gix@intel.com, linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 0/2] Framework for non-interactive mesh test
Date:   Fri, 19 Mar 2021 13:38:23 -0700
Message-Id: <20210319203825.459070-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v4: Use tester frameworks from ELL library

**********
v3: Fixed copyright style in mesh-io-unit.h

**********
v2: Fixed errors reported by bluez-bot.
    Regarding the warnings for the "__attribute__((packed))":
    keeping this style to be consistent with the rest of BLueZ codebase 
    
**********
This patch set introduces a framework for non-interactive testing of
mesh daemon functionality and consists of the three components:

1. A version of src/shared/tester that uses ELL primitives:
   everything mesh-related uses ELL.

2. New type of mesh IO used only for testing.

3. The mesh-cfgtest tool that excercises a number of mesh D-Bus
   API calls. Currently, the tool covers limited number of initial
   test cases. The extended coverage will be provided after this
   patch set is accepted.

Brian Gix (1):
  mesh: Add unit test IO

Inga Stotland (1):
  tools/mesh-cfgtest: Non-iteractive test for mesh

 Makefile.am          |   14 +-
 Makefile.mesh        |    2 +
 Makefile.tools       |    6 +
 mesh/main.c          |   51 +-
 mesh/mesh-io-unit.c  |  533 +++++++++++++++
 mesh/mesh-io-unit.h  |   11 +
 mesh/mesh-io.c       |    9 +-
 mesh/mesh-io.h       |    3 +-
 tools/mesh-cfgtest.c | 1458 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 2065 insertions(+), 22 deletions(-)
 create mode 100644 mesh/mesh-io-unit.c
 create mode 100644 mesh/mesh-io-unit.h
 create mode 100644 tools/mesh-cfgtest.c

-- 
2.26.2

