Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD953C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD064DD5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhBLVnu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:43:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:54929 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLVnt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 16:43:49 -0500
IronPort-SDR: PCXGTsw/ENZSp1R4VCPw9CCN6QDraRicWwdW5iz+gwTCLzGSKPlrolfMuowNEsJSc2lDwiDdzl
 GhxmnV3X5Kwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="243967603"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="243967603"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:55 -0800
IronPort-SDR: /FUt9pILhbRTxGoR+dIBvUZ+s+SBo/ZKYY+v0ye6p++XdKEAdJNDRA10lU7qWYJGJJ3F/I6kMi
 zvOxUswJHo1A==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="416116350"
Received: from dmoore1-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.2.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:55 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 3/4] test/test-mesh: Generate correct value for Device UUID
Date:   Fri, 12 Feb 2021 13:42:43 -0800
Message-Id: <20210212214244.74995-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210212214244.74995-1-inga.stotland@intel.com>
References: <20210212214244.74995-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This ensures that the value of Device UUID when invoking
Join method is compliant with RFC 4122.
---
 test/test-mesh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 9e4783734..fbf2476bf 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -887,12 +887,11 @@ class MainMenu(Menu):
 			print(set_error('Provisioning agent not found'))
 			return
 
-		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
-		random.shuffle(uuid)
-		uuid_str = array_to_string(uuid)
+		uuid_bytes = uuid.uuid4().bytes
+		uuid_str = array_to_string(uuid_bytes)
 
 		print(set_yellow('Joining with UUID ') + set_green(uuid_str))
-		mesh_net.Join(app.get_path(), uuid,
+		mesh_net.Join(app.get_path(), uuid_bytes,
 			reply_handler=join_cb,
 			error_handler=join_error_cb)
 
-- 
2.26.2

