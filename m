Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE35DC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815F764DB0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhA0RmS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:42:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:56864 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236093AbhA0RmJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 12:42:09 -0500
IronPort-SDR: lkv0oo7ykysg+b8hmC65Zp/7lowO8c3BhLOD3+w2HoOzD/kXZeqoxjyLMxob1znTYKkHITeeZR
 D8IR4ZgRz4Fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159278767"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="159278767"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:41:29 -0800
IronPort-SDR: 0O9tS+l9n+Yo3xPvwOp5oJVe3B6GCI6acxEtRO5rBP7fggUYTmCGpvCPpucTwj/3yG7DzOzxbw
 Et2zXWmz+kAw==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="410604407"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.3.187])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:41:29 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 2/2] tools/mgmt-tester: Make data size explicit for formats
Date:   Wed, 27 Jan 2021 09:40:50 -0800
Message-Id: <20210127174050.1536152-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210127174050.1536152-1-brian.gix@intel.com>
References: <20210127174050.1536152-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 32 bit systems, sizeof macro doesn't always return (unsigned long)

Fix following error:

tools/mgmt-tester.c: In function ‘read_50_controller_cap_complete’:
tools/mgmt-tester.c:9124:58: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Werror=format=]
 9124 |   tester_warn("Controller capabilities malformed, size %lu != %u",
      |                                                        ~~^
      |                                                          |
      |                                                          long unsigned int
      |                                                        %u
 9125 |     sizeof(rp->cap_len) + rp->cap_len, length);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                         |
      |                         unsigned int
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fe73a6d89..6bc40181e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9122,7 +9122,7 @@ static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
 
 	if (sizeof(rp->cap_len) + rp->cap_len != length) {
 		tester_warn("Controller capabilities malformed, size %lu != %u",
-				sizeof(rp->cap_len) + rp->cap_len, length);
+			(long) sizeof(rp->cap_len) + rp->cap_len, length);
 		tester_test_failed();
 	}
 
-- 
2.25.4

