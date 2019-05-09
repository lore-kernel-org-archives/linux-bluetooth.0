Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3579DC04AB1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDE8217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEIVdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 17:33:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:4694 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfEIVdc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 17:33:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 14:33:31 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.251.10.18])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2019 14:33:31 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v6 0/2] mesh: node dir Restructure, and keyring
Date:   Thu,  9 May 2019 14:33:19 -0700
Message-Id: <20190509213321.19822-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version 6 allows the legal file descriptor == 0, and uses lseek()
to streamline checking network bindings when updating application keys.


Brian Gix (2):
  mesh: Reconfigure node storage tree
  mesh: Add key storage

 Makefile.mesh  |   1 +
 mesh/README    |  34 ++++++-
 mesh/keyring.c | 298 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/keyring.h |  49 ++++++++++
 mesh/node.c    |  16 ++--
 mesh/node.h    |   4 +-
 mesh/storage.c | 144 +++++++++++++++++-----------
 7 files changed, 479 insertions(+), 67 deletions(-)
 create mode 100644 mesh/keyring.c
 create mode 100644 mesh/keyring.h

-- 
2.14.5

