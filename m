Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 04:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1129A64DFF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 04:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBFEq5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Feb 2021 23:46:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:19902 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhBFEot (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Feb 2021 23:44:49 -0500
IronPort-SDR: dio9AGVKXlIPcM4Xp2OSFARpmm3IDF+5bDD43a9+NG6j+t95CilzB0TdTDAeB68/lx201FgheY
 misk+ZS4WELw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="180745500"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="180745500"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 20:43:57 -0800
IronPort-SDR: 8FUpaBmF/cz9PyE071n1ehwB4t7n+pJfOS6YSm6c8e7C54/LdfstjczPsfnqk123z6B2gnTFYy
 IvLQIheZm7KA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="484717248"
Received: from yxiong5-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.99.79])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 20:43:57 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 0/3] Framework for non-interactive mesh test
Date:   Fri,  5 Feb 2021 20:43:37 -0800
Message-Id: <20210206044340.396467-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

Inga Stotland (2):
  shared/tester: Create ell-based version of tester code
  tools/mesh-cfgtest: Non-iteractive test for mesh daemon

 Makefile.am             |    8 +-
 Makefile.mesh           |    2 +
 Makefile.tools          |    6 +
 mesh/main.c             |   51 +-
 mesh/mesh-io-unit.c     |  533 ++++++++++++++++
 mesh/mesh-io-unit.h     |   20 +
 mesh/mesh-io.c          |    9 +-
 mesh/mesh-io.h          |    3 +-
 src/shared/tester-ell.c |  887 ++++++++++++++++++++++++++
 tools/mesh-cfgtest.c    | 1319 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 2817 insertions(+), 21 deletions(-)
 create mode 100644 mesh/mesh-io-unit.c
 create mode 100644 mesh/mesh-io-unit.h
 create mode 100644 src/shared/tester-ell.c
 create mode 100644 tools/mesh-cfgtest.c

-- 
2.26.2

