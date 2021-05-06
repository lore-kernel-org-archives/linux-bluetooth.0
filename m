Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF3DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA70613BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEFCTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 22:19:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:27097 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhEFCTY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 22:19:24 -0400
IronPort-SDR: Aya+OPFIhblls6oe2Hy/qdHiGdpD+r/1nTUsj36ZzZcQj7TL28zohdTWGiFYIYAavdihirBBVb
 /slM9DOZYJ+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="259631458"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="259631458"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:27 -0700
IronPort-SDR: M1TwQLgUJJhejHqCz8tn0DLeIiFduYfhLc/vu4wH4o4Mmf1zhC699zjM/OVhXD5ZTfa+MEcgc1
 cRtwQaJY7HZA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="469230368"
Received: from zloh1-mobl.gar.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.6.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:26 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 00/11] RFC: convert tester tools to use ELL
Date:   Wed,  5 May 2021 19:18:06 -0700
Message-Id: <20210506021817.289939-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
 src/shared/bttester.c   | 280 +++++++++++++++
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
 14 files changed, 2373 insertions(+), 1428 deletions(-)
 create mode 100644 emulator/hciemu-ell.c
 create mode 100644 src/shared/bttester.c
 create mode 100644 src/shared/bttester.h

-- 
2.26.3

