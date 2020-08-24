Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB73C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1741C20774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHXDyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Aug 2020 23:54:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:64620 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgHXDyS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Aug 2020 23:54:18 -0400
IronPort-SDR: hIPanseINlgVPxm8fwq3LbPy7vyD+3Tmog33PEJXHEvLt4txy0dSzO12sQz+w8gET9Se+Yp6/j
 4r9HJuhAKioA==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220106398"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="220106398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 20:54:16 -0700
IronPort-SDR: Sww/gu6kXdHsYlo903CDDiFJTzU/Q7q5XjcOyTHCTiHlhsWAwGR2VgXckpZrz8VfpDwSymH76k
 widMGTf4cMzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="322017085"
Received: from jlpajela-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.252.134.16])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2020 20:54:16 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] Mesh send/publish API change
Date:   Sun, 23 Aug 2020 20:54:11 -0700
Message-Id: <20200824035415.13420-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set modifies Send, DevKeySend, Publish & VendorPublish
methods on bleuz.mesh.Node interface to include additional argument
"options".
This new argument is a dictionary that currently has only one
new key word defined:
    "ForceSegmented" - to force small payloads to be sent as
    		      one-segment messages

Other key words may be defined in future to accommodate evolving
requirements of Mesh Profile specification.


Inga Stotland (4):
  doc/mesh-api: Add "options" dictionary to Send/Publish
  mesh: Handle "options" dictionary in Send/Publish methods
  tools/mesh-cfglient: Add "options" to Send/DevKeySend
  test/test-mesh: Add "options" to Send/Publish

 doc/mesh-api.txt       | 47 ++++++++++++++++++--
 mesh/cfgmod-server.c   |  2 +-
 mesh/model.c           |  6 +--
 mesh/model.h           |  9 ++--
 mesh/node.c            | 99 +++++++++++++++++++++++++++++-------------
 test/test-mesh         | 10 ++++-
 tools/mesh-cfgclient.c |  8 ++++
 7 files changed, 136 insertions(+), 45 deletions(-)

-- 
2.26.2

