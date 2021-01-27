Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9737C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEA660C3D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhA0XRc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:17:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:48450 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235163AbhA0XLX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 18:11:23 -0500
IronPort-SDR: FK70KibnDSZ1MhHR25MPwRgDxEy+BZn+MLl16j1o+/VB4tFxry4/tj/vAVuqbPHNpFjDt/BiNw
 DTB9je+XAN2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="179365792"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="179365792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:10:37 -0800
IronPort-SDR: yfyiPEsA1r+a1OfrU2k8nZ7mQc5GoXwpiaGGSrSF0O9w9zF1Qd8EnTPjENo+8P3sZlGyoapEcg
 3wxHFdFU57sw==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="403263747"
Received: from bjmaylan-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.126.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:10:36 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, denkenz@gmail.com
Subject: [PATCH BlueZ v3 2/2] tools/mgmt-tester: Fix formatter for size_t value
Date:   Wed, 27 Jan 2021 15:10:05 -0800
Message-Id: <20210127231005.1579325-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210127231005.1579325-1-brian.gix@intel.com>
References: <20210127231005.1579325-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 32 bit systems, sizeof macro doesn't always return (unsigned long),
and the %zu formatter specifically handles size_t.

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
index fe73a6d89..bb9fb0b9c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9121,7 +9121,7 @@ static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
 	}
 
 	if (sizeof(rp->cap_len) + rp->cap_len != length) {
-		tester_warn("Controller capabilities malformed, size %lu != %u",
+		tester_warn("Controller capabilities malformed, size %zu != %u",
 				sizeof(rp->cap_len) + rp->cap_len, length);
 		tester_test_failed();
 	}
-- 
2.25.4

