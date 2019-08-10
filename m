Return-Path: <SRS0=fX1h=WG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA83C32751
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Aug 2019 07:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36239208C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Aug 2019 07:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfHJH0V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:26:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:50837 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfHJH0V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Aug 2019 03:26:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2019 00:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,368,1559545200"; 
   d="scan'208";a="169526254"
Received: from ingas-nuc1.sea.intel.com ([10.251.24.184])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2019 00:26:20 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/1 v2] ELL based mainloop
Date:   Sat, 10 Aug 2019 00:26:18 -0700
Message-Id: <20190810072619.7714-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch addresses a need to enable using common mainloop for the
ell-based apps that desire to use common bluetooth fuctionality
(e.g., bt_shell).

Note: A bit awkward callback handling there is due to the discrepancy
in the arg type for signo (signal number).

src/shared/mainloop.h:
typedef void (*mainloop_signal_func) (int signum, void *user_data)

and ell/main.h:

typedef void (*l_main_signal_cb_t) (uint32_t signo, void *user_data)

My guess is that ell derives the unsigned int type from <sys/signalfd.h>,
where ssi_signo is defined as uint32_t. BlueZ is probably following the
standard Linux signal handling, where signal is represented as an int. 

Inga Stotland (1):
  shared/mainloop: Add ell-based mainloop implementation

 Makefile.am               |  11 +++-
 src/shared/mainloop-ell.c | 129 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 3 deletions(-)
 create mode 100644 src/shared/mainloop-ell.c

-- 
2.21.0

