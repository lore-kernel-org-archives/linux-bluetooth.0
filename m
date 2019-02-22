Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A2EC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627420818
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfBVGcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:32:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:7861 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfBVGcL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 01:32:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 22:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="301674821"
Received: from ingas-nuc1.sea.intel.com ([10.251.136.115])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2019 22:32:05 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/3 v2] mesh: Implement Leave() method
Date:   Thu, 21 Feb 2019 22:31:45 -0800
Message-Id: <20190222063148.4995-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches includes implementation of Leave() method on
Network interface and a number of fixes that allow to cleanly
remove a node info form the running daemon and the persistent
storage

Inga Stotland (3):
  mesh: Re-arrange node cleanup functions
  mesh: Cleanup storage save and remove procedures
  mesh: Implement Leave() method on Network interface

 mesh/mesh.c    | 33 ++++++++++++++++++++++++---------
 mesh/node.c    | 50 ++++++++++++++++++++++++++++++++++++--------------
 mesh/node.h    |  5 +++--
 mesh/storage.c | 46 ++++++++++++++++++++++++++++++----------------
 mesh/storage.h |  2 +-
 5 files changed, 94 insertions(+), 42 deletions(-)

-- 
2.17.2

