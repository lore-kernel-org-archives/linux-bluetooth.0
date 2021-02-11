Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1EEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6819564E38
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhBKWXs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:23:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:1736 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhBKWXG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 17:23:06 -0500
IronPort-SDR: X+GJK6s1Nq3rUM0vvq98mPT9FR5zFtdf5vj2ipIkWMI8KFicGRfA/+JUK5WInelaZORdF0VIDP
 mQeKicK8gZIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246392975"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="246392975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 14:21:59 -0800
IronPort-SDR: iygIkBvAmk5k9DSpl8EOt74fnDXgtPMQiKRRme1fDr1QaK7lh7zEVoVYpRMdGlOohLKUW3QxNi
 O2TWr1eZBFKA==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="381070056"
Received: from binman-mobl4.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.251.152.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 14:21:59 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4] test/test-mesh: Generate correct value for Device UUID
Date:   Thu, 11 Feb 2021 14:21:42 -0800
Message-Id: <20210211222143.39986-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211222143.39986-1-inga.stotland@intel.com>
References: <20210211222143.39986-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This ensures that the value of Device UUID when invoking
Join method is compliant with RFC 4122.
---
 test/test-mesh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/test/test-mesh b/test/test-mesh
index 9e4783734..a478843a3 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -889,6 +889,11 @@ class MainMenu(Menu):
 
 		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
 		random.shuffle(uuid)
+		uuid[6] &= 0x0f;
+		uuid[6] |= 4 << 4;
+		uuid[8] &= 0x3f;
+		uuid[8] |= 0x80;
+
 		uuid_str = array_to_string(uuid)
 
 		print(set_yellow('Joining with UUID ') + set_green(uuid_str))
-- 
2.26.2

