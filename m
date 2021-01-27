Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B479D64DA5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 18:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbhA0SZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 13:25:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:21028 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343828AbhA0SZK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 13:25:10 -0500
IronPort-SDR: 4noFpp+ANDEQPIqwQDgeDaZuG2WesRpkxmtegtFcPg5n4BhCS2/hxd7Jd3Pc16DS64LJ47+ni1
 lGv8qFoN8Jjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="244190116"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="244190116"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 10:24:16 -0800
IronPort-SDR: MrVNzXg9+xzFi+zGnDbf93AJkci45BrncU3jIb+OJb0TdmyFf0pvHNqDjdjin4Tj85T+ZqlFj6
 /m9idgaYZfmg==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="430192018"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.3.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 10:24:15 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 2/2] tools/mgmt-tester: Make data size explicit for log
Date:   Wed, 27 Jan 2021 10:23:28 -0800
Message-Id: <20210127182328.1542194-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210127182328.1542194-1-brian.gix@intel.com>
References: <20210127182328.1542194-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 32 bit systems, sizeof macro doesn't always return (unsigned long)

Fix following error:

tools/mgmt-tester.c: In function ‘read_50_controller_cap_complete’:
tools/mgmt-tester.c:9124:58: error: format ‘%lu’ expects argument of type
‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Werror=format=]

 9124 |   tester_warn("Controller capabilities malformed, size %lu != %u",
      |                                                        ~~^
      |                                                          |
      |                                                  long unsigned int
      |                                                        %u
 9125 |     sizeof(rp->cap_len) + rp->cap_len, length);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                         |
      |                     unsigned int
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

