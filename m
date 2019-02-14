Return-Path: <SRS0=ZFDx=QV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E418C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D7A21B1A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393767AbfBNDp3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:45:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:19361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387562AbfBNDp3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Feb 2019 22:45:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 19:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="274927351"
Received: from ingas-nuc1.sea.intel.com ([10.254.99.167])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 19:45:28 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/3] mesh: Save/restore application keys
Date:   Wed, 13 Feb 2019 19:45:24 -0800
Message-Id: <20190214034527.6310-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches fixes the application key add/update processing.
An application key needs to be saved to a local node configuration file
when:
	- a new application key is added by a configuration client
    - an existing application key is updated by a configuration client
	  during key refresh procedure.

Also, fix error codes for AppKey List operation

Inga Stotland (3):
  mesh: Separate functions for app key add and update
  mesh: Save newly added or updated app key to config file
  mesh: Return correct error code for Appkey List command

 mesh/appkey.c        |  92 ++++++++++++++++++++++---------------
 mesh/appkey.h        |   4 +-
 mesh/cfgmod-server.c |   8 +++-
 mesh/mesh-db.c       | 107 ++++++++++++++++++++-----------------------
 mesh/mesh-db.h       |   4 +-
 mesh/storage.c       |   5 +-
 6 files changed, 120 insertions(+), 100 deletions(-)

-- 
2.17.2

