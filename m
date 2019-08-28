Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF4C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A59217F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfH1Wsz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:48:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:13786 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfH1Wsz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 18:48:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 15:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="210328931"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.35.27])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 15:48:54 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 0/2] mesh: Streamline Key Refresh finalization
Date:   Wed, 28 Aug 2019 15:48:49 -0700
Message-Id: <20190828224851.2201-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

All App key refresh finalization will happen when the bound Net Key is
finalized.

Brian Gix (2):
  doc: Remove uneeded dbus API for App Key Refresh
  mesh: Automate AppKey update on KR phase 2-->3-->0

 doc/mesh-api.txt | 19 ---------------
 mesh/keyring.c   | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/keyring.h   |  1 +
 mesh/manager.c   | 39 ++++++------------------------
 4 files changed, 72 insertions(+), 50 deletions(-)

-- 
2.21.0

