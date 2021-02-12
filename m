Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADC9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A8B64E26
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBLVne (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:43:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:54929 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLVne (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 16:43:34 -0500
IronPort-SDR: aZ7H6hwem02XFzVgKctKqNLLFpeYF+O5c+ZsJef9V0lS2JDQTKWlB+AkRNNx71GmtGE+AE7UYN
 o8Oisaw9uyUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="243967596"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="243967596"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:52 -0800
IronPort-SDR: ryAPiiQfNPUtxoPwoMsp+hr7NhpQZdUHyxAa8OiXWp46uI6Wap9qWXa4J1r6p3aIgLFUDDYGr8
 2i2eQKbrYjMw==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="416116325"
Received: from dmoore1-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.2.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:52 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 0/4] Use compliant UUID for mesh
Date:   Fri, 12 Feb 2021 13:42:40 -0800
Message-Id: <20210212214244.74995-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2: Incorporate Michał's suggestion to use Python's uuid module
functions.

************
Mesh profile spec states that the values use for Device UUIDs
folow format and generation procedures outlined in RFC 4122.
This patch set addresses this requirement.


Inga Stotland (4):
  doc/mesh-api: Add notion of Device UUID compliance
  mesh: Add validation of Device UUID value
  test/test-mesh: Generate correct value for Device UUID
  tools/mesh-cfg-client:

 Makefile.am            |  6 ++++--
 doc/mesh-api.txt       |  9 ++++++---
 mesh/mesh.c            | 18 +++++++++---------
 test/test-mesh         |  7 +++----
 tools/mesh-cfgclient.c |  6 +++---
 tools/mesh/mesh-db.c   |  2 +-
 6 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.26.2

