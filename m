Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55306C4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318C0208E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 23:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfF1XBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:01:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:53752 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfF1XBo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 19:01:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 16:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="314271642"
Received: from ingas-nuc1.sea.intel.com ([10.252.196.161])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2019 16:01:43 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4 v3] Model publication fixes
Date:   Fri, 28 Jun 2019 16:01:38 -0700
Message-Id: <20190628230142.16367-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ A workaround for (bogus) compiler warning, plus commit text fixes
+ Michal's comment: variable naming

This set of patches cleans up miscellaneous code redundancies in model.c
and contains fixes in the following areas:
- virtual address housekeeping
- checks for model publication removal, i.e., when config pub message has
  "unassigned" value for publication address 
- return values discrepancies (few cases where an integer error code is
  to be returned, but boolean false was returned instead)

Inga Stotland (4):
  mesh: Clean up model.c and cfg-server.c
  mesh: Fix virtual address processing
  mesh: Fix and clean up model publication code
  test: test-mesh - Correctly stop periodic publication

 mesh/cfgmod-server.c |  47 +++---
 mesh/model.c         | 366 ++++++++++++++++++-------------------------
 mesh/model.h         |  38 ++---
 test/test-mesh       |   8 +-
 4 files changed, 190 insertions(+), 269 deletions(-)

-- 
2.21.0

