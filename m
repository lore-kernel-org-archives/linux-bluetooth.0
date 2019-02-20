Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C623C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 05:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DC120C01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 05:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfBTFxX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:53:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:18898 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfBTFxX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 00:53:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 21:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="144929325"
Received: from ingas-nuc1.sea.intel.com ([10.251.128.60])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2019 21:53:22 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/3] mesh: Implement Leave() method
Date:   Tue, 19 Feb 2019 21:53:17 -0800
Message-Id: <20190220055320.2333-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches includes implementation of Leave() method on
Network interface and a number of fixes that allow to cleanly
remove a node info form the running daemon and the persistent
storage.

Inga Stotland (3):
  mesh: Re-arrange node cleanup functions
  mesh: Cleanup storage save and remove procedures
  mesh: Implement Leave() method on Network interface

 mesh/mesh.c    | 33 ++++++++++++++++++++++++---------
 mesh/node.c    | 42 ++++++++++++++++++++++++++++--------------
 mesh/node.h    |  4 ++--
 mesh/storage.c | 38 +++++++++++++++++++++++---------------
 mesh/storage.h |  2 +-
 5 files changed, 78 insertions(+), 41 deletions(-)

-- 
2.17.2

