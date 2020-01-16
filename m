Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF9C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9601A2073A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPQjT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:39:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:60306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPQjS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 11:39:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 08:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="373375248"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.90.67])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2020 08:39:18 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com, jakub.witowski@silvair.com
Subject: [PATCH BlueZ v3 0/1] mesh: Sequence number related fixes
Date:   Thu, 16 Jan 2020 08:39:07 -0800
Message-Id: <20200116163908.18041-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Version 3 -
Adjusted comments for clarity, and adjusted the cache-write code
to not rewrite the NVM storage if nothing has changed, to prevent
NVM thrashing if we do reach the out-of-range boundary.

I would like both Michal and Jakub's comments on these adjustments.

Jakub Witowski (1):
  mesh: Sequence number related fixes

 mesh/crypto.c           |  3 +++
 mesh/mesh-config-json.c | 16 ++++++++++++++--
 mesh/net.c              |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.21.1

