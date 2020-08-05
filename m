Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A9F2173E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHETUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:20:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:42213 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgHERsm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 13:48:42 -0400
IronPort-SDR: M4ofSXJ3SM3mNWO9lfkMD6WQqkUlsypVWtK2eNPbIuyxP2v5Tk+GFD0SuMz0i7v+evZlQoc7vr
 lAYjmMvqdB+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="237470599"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="237470599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 10:44:57 -0700
IronPort-SDR: +yHScxxKYp1319fLV3oiV2j8kplv4RaoZ7+LNK5nJe7NgB3RpWacCe87zoGaTwcl7jQBMv6vqA
 PKec3VjAAaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="437245692"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.189])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2020 10:44:56 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 00/10] Mesh Config Server clean up
Date:   Wed,  5 Aug 2020 10:44:46 -0700
Message-Id: <20200805174456.49342-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v4 - Further fixes in handling Key Refresh Phase Set message

*******************
 v3 - address Brian's comments
 
*******************
This patch set groups functionality by config messages.
Also, fixes the cases where malformed messages should be  silently
ignored and the situations when incorrect error status
is sent in response.

Inga Stotland (10):
  mesh: Clean up handling of config subscription messages
  mesh: Clean up handling of config model binding messages
  mesh: Clean up handling of config node identity message
  mesh: Clean up handling of config publication messages
  mesh: Clean up handling of config net and app key messages
  mesh: Clean up handling of config relay messages
  mesh: Clean up handling of config poll timeout message
  mesh: Clean up handling of config net transmit messages
  mesh: Clean up handling of config KR phase messages
  mesh: Refactor heartbeat pub/sub

 mesh/cfgmod-server.c    | 1196 +++++++++++++++++----------------------
 mesh/cfgmod.h           |    2 +-
 mesh/mesh-config-json.c |   12 +-
 mesh/mesh-config.h      |    6 +-
 mesh/mesh-defs.h        |    3 +
 mesh/model.c            |  234 ++++----
 mesh/model.h            |   21 +-
 mesh/net.c              |  326 +++++++----
 mesh/net.h              |   54 +-
 mesh/node.h             |    4 -
 10 files changed, 912 insertions(+), 946 deletions(-)

-- 
2.26.2

