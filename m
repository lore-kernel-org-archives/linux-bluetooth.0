Return-Path: <SRS0=okSL=QO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD27C282C2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 03:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF132175B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 03:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBGDzj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:55:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:49795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfBGDzj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 22:55:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 19:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="141359299"
Received: from ingas-nuc1.sea.intel.com ([10.251.16.219])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2019 19:55:38 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/5 v2] mesh: Save/restore network keys
Date:   Wed,  6 Feb 2019 19:55:32 -0800
Message-Id: <20190207035537.20375-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rev.2: addressed Brina's comments.

This set of patches fixes the network key add/update processing.
Network keys need to be saved to a local node configuration file
when:
	- a new node is provisioned
	- new network key are added by a configuration client
    - existing network key is updated by a configuration client
	  during key refresh procedure.

Also, each saved network key is accompanied by a proper key
refresh phase setting.

Inga Stotland (5):
  mesh: Separate functions for net key add and update
  mesh: Add function to restore net key state from storage
  mesh: Declare internal functions as static
  mesh: Save key refresh phase state to node config file
  mesh: Save newly added or updated net key to config file

 mesh/cfgmod-server.c |   8 +-
 mesh/mesh-db.c       | 178 +++++++++++++++++-----------
 mesh/mesh-db.h       |   6 +-
 mesh/net.c           | 268 +++++++++++++++++++++++++++----------------
 mesh/net.h           |  12 +-
 mesh/node.c          |  19 ++-
 mesh/storage.c       |  22 ++--
 mesh/storage.h       |   7 +-
 8 files changed, 326 insertions(+), 194 deletions(-)

-- 
2.17.2

