Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F183FC2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD687206E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgDQS5c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:57:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:11656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgDQS5c (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 14:57:32 -0400
IronPort-SDR: E0PsaQkhiRkPTzun886mkv0OXlN4oIQAp+W+uqiFKXJGU8L2/by418nMi6gCbXJlUwEaAbFijs
 y90o1GcOCGXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 11:57:31 -0700
IronPort-SDR: F8EsVOaNx6ydIdob9VY4e2hExuXyPbdLACmN6O/TCkVOKjxkIJvc8SosOfYMv5CR/vE5scLDg4
 e29E9tNwATTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="257667454"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.69.33])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2020 11:57:31 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix GCC 10.0 warnings
Date:   Fri, 17 Apr 2020 11:57:21 -0700
Message-Id: <20200417185721.18312-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/crypto.c           | 2 +-
 mesh/mesh-config-json.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index df597bb3f..99536594b 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -1038,7 +1038,7 @@ bool mesh_crypto_check_avail()
 			uint8_t data[20];
 			uint8_t mic[8];
 		} crypto;
-		uint8_t bytes[0];
+		uint8_t bytes[73];
 	} u;
 	uint8_t out_msg[sizeof(u.crypto.data) + sizeof(u.crypto.mic)];
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 97267b6c3..7362112f2 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1980,7 +1980,7 @@ bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 								bool cache)
 {
-	int value;
+	int value = 0;
 	uint32_t cached = 0;
 
 	if (!cfg)
-- 
2.21.1

