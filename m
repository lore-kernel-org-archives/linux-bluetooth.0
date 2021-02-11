Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97CC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A2864E3B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBKWXN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:23:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:1738 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhBKWWj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 17:22:39 -0500
IronPort-SDR: FVXTJAZTXc8/kEdLbLwYQw3cRMER5IT2aWWQFD5zLTys6qHik8l217c3K9BGuoIM2ISXdxiPrN
 xDspJbX42Sjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246392968"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="246392968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 14:21:56 -0800
IronPort-SDR: 4MFSBrUMTXIlw2vdkllRPxegfMZDJzgmuhSaQUh9XpMpBhQm8JZnkQVpaBQ9BD6bxgaPRCWTBa
 gLNQa0E4OFuw==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="381070043"
Received: from binman-mobl4.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.251.152.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 14:21:55 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/4] doc/mesh-api: Add notion of Device UUID compliance
Date:   Thu, 11 Feb 2021 14:21:40 -0800
Message-Id: <20210211222143.39986-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211222143.39986-1-inga.stotland@intel.com>
References: <20210211222143.39986-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add requirement that the value of Device UUID supplied in
CreateNetwork/Join/Import methods should be compliant with
RFC 4122.
---
 doc/mesh-api.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 254ccbd7f..f2c6b9e5c 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -27,7 +27,8 @@ Methods:
 		The uuid parameter is a 16-byte array that contains Device UUID.
 		This UUID must be unique (at least from the daemon perspective),
 		therefore attempting to call this function using already
-		registered UUID results in an error.
+		registered UUID results in an error. The composition of the UUID
+		octets must be in compliance with RFC 4122.
 
 		When provisioning finishes, the daemon will call either
 		JoinComplete or JoinFailed method on object implementing
@@ -149,7 +150,8 @@ Methods:
 		The uuid parameter is a 16-byte array that contains Device UUID.
 		This UUID must be unique (at least from the daemon perspective),
 		therefore attempting to call this function using already
-		registered UUID results in an error.
+		registered UUID results in an error. The composition of the UUID
+		octets must be in compliance with RFC 4122.
 
 		The other information the bluetooth-meshd daemon will preserve
 		about the initial node, is to give it the initial primary
@@ -179,7 +181,8 @@ Methods:
 		The uuid parameter is a 16-byte array that contains Device UUID.
 		This UUID must be unique (at least from the daemon perspective),
 		therefore attempting to call this function using already
-		registered UUID results in an error.
+		registered UUID results in an error. The composition of the UUID
+		octets must be in compliance with RFC 4122.
 
 		The dev_key parameter is the 16-byte value of the dev key of
 		the imported mesh node.
-- 
2.26.2

