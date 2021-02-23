Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFEC433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E464E20
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhBWTEb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:19082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233977AbhBWTEb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:31 -0500
IronPort-SDR: TdD3oVKoc1g0uIwbJyNWuy62/o8xkiLvIhdkKwWjFv1N+kjTSHmLUyeHV8lAbOFqMkKeZq9fAx
 tkoNALXfwMnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="246335974"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="246335974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:50 -0800
IronPort-SDR: DFR50DBe2MElo4SgXYGzXDQSItEOa9D3rFFLUdLLWWMGts7jQ+a3gCz/kqAkGm4fwOPungxQFR
 K/rIZLRpZrTQ==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432831096"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:50 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 4/6] profiles: Cleanup deprecated symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:50 -0800
Message-Id: <20210223190252.483784-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210223190252.483784-1-brian.gix@intel.com>
References: <20210223190252.483784-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/input/suspend-dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index c6527ee88..ea1835e0f 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -121,7 +121,7 @@ int suspend_init(suspend_event suspend, resume_event resume)
 		}
 	}
 
-	if (mkfifo(HOG_SUSPEND_FIFO, S_IRUSR | S_IWUSR) < 0) {
+	if (mkfifo(HOG_SUSPEND_FIFO, 0600) < 0) {
 		int err = -errno;
 
 		error("Can't create FIFO (%s): %s (%d)", HOG_SUSPEND_FIFO,
-- 
2.25.4

