Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4774FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F7160C41
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhA0XRe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:17:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:41328 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235178AbhA0XLS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 18:11:18 -0500
IronPort-SDR: LfTFhbCJlYUsJrUR3K8bM6n5Qgo9IqnYAlcJCfTO86ykNpFTLFMD9vH1KY/ozQSrZeYDMHe80L
 WAaVhic86q2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167824119"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="167824119"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:10:30 -0800
IronPort-SDR: 8BCIYtJROM6RxZRP2VUvTXLzFJGfenm0MYgtP+pVpHyGokjYU6tt8jX47sG0YJ7rxi4JZDsjSt
 rFfEvuOt7jLA==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="403263591"
Received: from bjmaylan-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.126.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:10:29 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, denkenz@gmail.com
Subject: [PATCH BlueZ v3 1/2] advertising: Fix formater for size_t data type
Date:   Wed, 27 Jan 2021 15:10:04 -0800
Message-Id: <20210127231005.1579325-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210127231005.1579325-1-brian.gix@intel.com>
References: <20210127231005.1579325-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some 32 bit systems sizeof does not return (unsigned long). The
size_t formater %zu handles this across architectures.

Fixes the error:

In file included from src/advertising.c:30:
src/advertising.c: In function ‘read_controller_cap_complete’:
src/log.h:60:20: error: format ‘%lu’ expects argument of type ‘long
unsigned int’, but argument 5 has type ‘unsigned int’ [-Werror=format=]
   60 |  btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
      |                    ^~~~~~~~~~

src/advertising.c:1757:3: note: in expansion of macro ‘error’
 1757 |   error("Controller capabilities malformed, size %lu != %u",
      |   ^~~~~
src/advertising.c:1757:52: note: format string is defined here
 1757 |   error("Controller capabilities malformed, size %lu != %u",
      |                                                  ~~^
      |                                                    |
      |                                             long unsigned int
      |                                                  %u
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 4f5123fa1..15a343e52 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1754,7 +1754,7 @@ static void read_controller_cap_complete(uint8_t status, uint16_t length,
 	}
 
 	if (sizeof(rp->cap_len) + rp->cap_len != length) {
-		error("Controller capabilities malformed, size %lu != %u",
+		error("Controller capabilities malformed, size %zu != %u",
 				sizeof(rp->cap_len) + rp->cap_len, length);
 		return;
 	}
-- 
2.25.4

