Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39DBC433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E2464DAB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhA0RmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:42:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:56862 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344049AbhA0RmF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 12:42:05 -0500
IronPort-SDR: dbCJiphUdhydiZDNB5JTxpLqZNEtHBLyR2Qw5Zxztj2D+wIghP2RN2KPJlZeOjwF+/R4t5C8cr
 9ZJsgAa0o0jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159278760"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="159278760"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:41:24 -0800
IronPort-SDR: C3L6m4CCTSS3P21lFB4KBfaMfRScCp0aXDJRXgamFY/rj11aFG3/yEl5GcNpl20SnzzLL3VIN5
 pGKi1kt7LXww==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="410604387"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.3.187])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:41:24 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 1/2] advertising: Make data size explicit for formats
Date:   Wed, 27 Jan 2021 09:40:49 -0800
Message-Id: <20210127174050.1536152-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210127174050.1536152-1-brian.gix@intel.com>
References: <20210127174050.1536152-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some 32 bit systems sizeof does not return (unsigned long)

Fixes the error:

In file included from src/advertising.c:30:
src/advertising.c: In function ‘read_controller_cap_complete’:
src/log.h:60:20: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘unsigned int’ [-Werror=format=]
   60 |  btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
      |                    ^~~~~~~~~~
src/advertising.c:1757:3: note: in expansion of macro ‘error’
 1757 |   error("Controller capabilities malformed, size %lu != %u",
      |   ^~~~~
src/advertising.c:1757:52: note: format string is defined here
 1757 |   error("Controller capabilities malformed, size %lu != %u",
      |                                                  ~~^
      |                                                    |
      |                                                    long unsigned int
      |                                                  %u
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 4f5123fa1..36e737987 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1755,7 +1755,7 @@ static void read_controller_cap_complete(uint8_t status, uint16_t length,
 
 	if (sizeof(rp->cap_len) + rp->cap_len != length) {
 		error("Controller capabilities malformed, size %lu != %u",
-				sizeof(rp->cap_len) + rp->cap_len, length);
+			(long) sizeof(rp->cap_len) + rp->cap_len, length);
 		return;
 	}
 
-- 
2.25.4

