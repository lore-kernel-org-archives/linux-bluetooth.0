Return-Path: <SRS0=c51M=WD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542CCC433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 06:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DCB21BF6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 06:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfHGGrv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:47:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:3495 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfHGGrv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Aug 2019 02:47:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 23:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="182194355"
Received: from ingas-nuc1.sea.intel.com ([10.254.176.241])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2019 23:47:50 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2] ELL-based bt_shell implementation
Date:   Tue,  6 Aug 2019 23:47:45 -0700
Message-Id: <20190807064747.6725-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set addresses the need of using bt-shell functionality
when running with ell mainloop.
Specifically, need this for implementation of mesh profisioning tool:
mesh daemon is implemented using ell library and is driven by
ell main loop.

Inga Stotland (2):
  shared/shell: Add ell based shell implementation
  shared/shell: Add "clear-history" API

 Makefile.am            |   13 +-
 src/shared/shell-ell.c | 1325 ++++++++++++++++++++++++++++++++++++++++
 src/shared/shell.c     |    7 +-
 src/shared/shell.h     |    1 +
 4 files changed, 1342 insertions(+), 4 deletions(-)
 create mode 100644 src/shared/shell-ell.c

-- 
2.21.0

