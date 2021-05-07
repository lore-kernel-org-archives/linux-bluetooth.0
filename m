Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69564C43460
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2038E613D8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhEGF5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 01:57:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:17170 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhEGF5h (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 01:57:37 -0400
IronPort-SDR: hsgU3izY7EIQH4XcIgul4kDt7y6Xv8v7Zdq9WZBURYfJdApSGwjrpAg2uErCOOagvwxUl4ZH9r
 BaYvo5xV8rAg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="178220272"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="178220272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:36 -0700
IronPort-SDR: y29Zt/qjTSE8LuCjyH9fNeYPxulaUzrFGWOiS4V8vFCuppLSghnAIfF4NLoP/ymFj0quFU9zez
 48SGDir01rFg==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="407314519"
Received: from jinhuach-mobl1.ccr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.7.101])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:35 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC BlueZ v2 00/11] Convert tester tools to use ELL
Date:   Thu,  6 May 2021 22:56:18 -0700
Message-Id: <20210507055629.338409-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2: Fix build error with external ELL

************
This patch set contains a proposed approach to convert noninteractive
tester tools to use ELL primitives removing GLib dependencies.

Two new files emulator/hciemu-ell.c and src/shared/bttester.c are
created as an intermediate step before removing their GLib-based counterparts
subject to the vetting/approval of this patch set.

Inga Stotland (11):
  shared/bttester: tester framework wrapper to use ELL
  emulator/hciemu: Create ELL based version of hciemu
  tools/gap-tester: Convert to use ELL library
  tools/sco-tester: Convert to use ELL library
  tools/userchan-tester: Convert to use ELL library
  tools/smp-tester: Convert to use ELL library
  tools/bnep-tester: Convert to use ELL library
  tools/l2cap-tester: Convert to use ELL library
  tools/mgmt-tester: Convert to use ELL library
  tools/rfcomm-tester: Convert to use ELL library
  tools/hci-tester: Convert to use ELL library

 Makefile.am             |   4 +-
 Makefile.tools          |  36 +-
 emulator/hciemu-ell.c   | 645 +++++++++++++++++++++++++++++++++++
 src/shared/bttester.c   | 279 +++++++++++++++
 src/shared/bttester.h   |  28 ++
 tools/bnep-tester.c     | 115 +++----
 tools/gap-tester.c      | 107 +++---
 tools/hci-tester.c      | 289 ++++++++--------
 tools/l2cap-tester.c    | 680 ++++++++++++++++++-------------------
 tools/mgmt-tester.c     | 735 ++++++++++++++++++++--------------------
 tools/rfcomm-tester.c   | 290 ++++++++--------
 tools/sco-tester.c      | 231 +++++++------
 tools/smp-tester.c      | 210 ++++++------
 tools/userchan-tester.c | 151 ++++-----
 14 files changed, 2372 insertions(+), 1428 deletions(-)
 create mode 100644 emulator/hciemu-ell.c
 create mode 100644 src/shared/bttester.c
 create mode 100644 src/shared/bttester.h

-- 
2.26.3

