Return-Path: <SRS0=ynic=46=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DEC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Mar 2020 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC173206EB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Mar 2020 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCMSIj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:08:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:26967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMSIi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Mar 2020 14:08:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="266811405"
Received: from ingas-nuc1.sea.intel.com ([10.251.23.252])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 11:08:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2] Remote node reset implementation
Date:   Fri, 13 Mar 2020 11:08:34 -0700
Message-Id: <20200313180836.23227-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches provides complete implementation of sending
and processing of Config Node Reset and Config Node Reset Status
messages

Inga Stotland (2):
  tools/mesh-cfgclient: Implement node-reset command
  mesh: Fix processing of Config Node Reset message

 mesh/cfgmod-server.c   | 14 ++++----
 tools/mesh-cfgclient.c | 77 ++++++++++++++++--------------------------
 tools/mesh/cfgcli.c    | 60 ++++++++++++++++++++++++++++----
 tools/mesh/cfgcli.h    |  4 ++-
 tools/mesh/mesh-db.c   | 39 +++++++++++++++++++++
 tools/mesh/remote.c    | 20 +++++++++++
 tools/mesh/remote.h    |  1 +
 7 files changed, 154 insertions(+), 61 deletions(-)

-- 
2.21.1

