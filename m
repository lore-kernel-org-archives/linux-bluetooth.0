Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45BEC388F7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F7A206F9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKGHDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:45622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKGHDW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:22 -0500
IronPort-SDR: kc8a0wsPuZkneA1XfDY0sKs90T6EVUzrZEVZL+bXOyi6Qf6/GdUFROStuv8ZZi6zawTWEdjO3X
 ffofI+hvcUog==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485507"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485507"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:22 -0800
IronPort-SDR: bK7su7rgtME0A51+TS0ZJWXPOwA0AsS1Veem0zBRrCWMsQ26KRpd8LK98KLSMPVTrDqY2/fO5r
 oO7uup1sxd3Q==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359031994"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:22 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 00/10] Convert tools to use ELL library
Date:   Fri,  6 Nov 2020 23:03:02 -0800
Message-Id: <20201107070312.8561-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set is a part of ongoing effort to remove GLib dependencies
from BlueZ in favor of using ELL library.

bluez/tools subdirectory is chosen as a first candidate since
it provides standalone functionality making it easier to adress the
issues discovered during the conversion process.

The patch set is a snapshot of *some* tools converted to use ELL as well
as ELL based versions of emulator/hciemu-ell.c and shared/tester-ell.c.

Inga Stotland (10):
  shared/tester-ell: Create ell-based version of tester code
  emulator/hciemu: Create ELL based version of hciemu
  tools/gap-tester: Convert to use ELL library
  tools/sco-tester: Convert to use ELL library
  tools/userchan-tester: Convert to use ELL library
  tools/smp-tester: Convert to use ELL library
  tools/bnep-tester: Convert to use ELL library
  tools/l2cap-tester: Convert to use ELL library
  tools/mgmt-tester: Convert to use ELL library
  tools/rfcomm-tester: Convert to use ELL library

 Makefile.am             |   8 +-
 Makefile.tools          |  34 +-
 emulator/hciemu-ell.c   | 564 ++++++++++++++++++++++++++
 src/shared/tester-ell.c | 875 ++++++++++++++++++++++++++++++++++++++++
 tools/bnep-tester.c     |   9 +-
 tools/gap-tester.c      |  87 ++--
 tools/l2cap-tester.c    | 256 ++++++------
 tools/mgmt-tester.c     |   5 +-
 tools/rfcomm-tester.c   |  92 +++--
 tools/sco-tester.c      |  33 +-
 tools/smp-tester.c      |  24 +-
 tools/userchan-tester.c |   2 -
 12 files changed, 1715 insertions(+), 274 deletions(-)
 create mode 100644 emulator/hciemu-ell.c
 create mode 100644 src/shared/tester-ell.c

-- 
2.26.2

