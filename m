Return-Path: <SRS0=/Nrl=6I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D7C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 23:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BFC20736
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDXXKt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:10:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:53475 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXXKs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 19:10:48 -0400
IronPort-SDR: y+TBCLh8YpoWyply/a0pdZ9xkv/J709ViH8abDxSp/hgI+4lzq3t0u/F4R4zuhArDdMBgd5UaS
 5B/9sMWZqAEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 16:10:48 -0700
IronPort-SDR: 5iDSxUQBU9rpIrvXQjKpDZj6w2XSHw827/D2M1v9kf6GHyR0Qwgqnlh2Bi6tpGJqsdhf2yeNZd
 VFWdPFAuZt6Q==
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="274776829"
Received: from han1-mobl3.jf.intel.com ([10.54.74.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 16:10:48 -0700
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Subject: [PATCH] Test patch: build fail
Date:   Fri, 24 Apr 2020 16:10:42 -0700
Message-Id: <20200424231042.127237-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DO NOT MERGE
---
 tools/btpclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index f9c693056..04c83f6ae 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -3215,7 +3215,7 @@ int main(int argc, char *argv[])
 
 	l_free(socket_path);
 
-	l_main_exit();
+	l_main_exit()
 
 	return EXIT_SUCCESS;
 }
-- 
2.25.3

