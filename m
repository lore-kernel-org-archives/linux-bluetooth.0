Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08768C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E592184D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEIAA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 20:00:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:65492 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgEIAA0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 20:00:26 -0400
IronPort-SDR: fqbLl/BiaTF28dY3Hz9Jszf96F5fOAGIRHXaTx9hbmYsOsNOSpg/jqFPoSlxUuzIHESC9A2cwq
 Tv2+Bgti37lQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 17:00:26 -0700
IronPort-SDR: uwk+2B6mIzjV00A19ftJCJHBFfTTf9SvNFGddyKn10LPrj+ekRAK4kiuQPEG+/Njf3GrP0h+Wc
 j1FiaixygX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="408275086"
Received: from ingas-nuc1.sea.intel.com ([10.254.110.242])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2020 17:00:25 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] Allow some composition fields update
Date:   Fri,  8 May 2020 17:00:20 -0700
Message-Id: <20200509000024.5704-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset modifies how we verify the integrity of an existing
node when processing Attach() call.

The changes:
- Vericifaction includes only element/models relationship: this should
  stay constant during node's lifetime.
- Allow updating of CID, PID, VID and CRPL.
- Some general cleanup related to saving node configuration.

Inga Stotland (4):
  mesh: On node attach, verify element/model composition only
  mesh: Avoid saving duplicate fields in node config
  mesh: Allow updating CID, PID, VID & CRPL on node attach
  mesh: Remove redundant call to save node configuration

 mesh/mesh-config-json.c | 56 +++++++++++++++++++++++++++++++++--------
 mesh/mesh-config.h      |  4 +++
 mesh/node.c             | 29 +++++++++++++++------
 3 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.21.3

