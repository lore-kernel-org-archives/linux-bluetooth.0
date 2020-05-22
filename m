Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F33C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 21:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D952073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgEVVNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 17:13:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:48186 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731053AbgEVVNR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 17:13:17 -0400
IronPort-SDR: 8Xg32E05V9rQtoKWJtZGF87xsKnUZUzV6WpDjyQ7CcAfov2HPzLQL86eD7m3nppY8p/a1BeNHj
 YGKWqaNj/WuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 14:13:15 -0700
IronPort-SDR: uFNmDn+kPhtD3o7cJV2IWZpSyHr3dxTQ3QRlIKJ5R1Novz5i8UeKZ3hU8VdF404erDF5qFVjJQ
 2mGBKyit5FTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="254372391"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.68.94])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2020 14:13:15 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 4/4] mesh: Destroy PB-ADV queue when provisioning done
Date:   Fri, 22 May 2020 14:13:09 -0700
Message-Id: <20200522211309.233824-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522211309.233824-1-brian.gix@intel.com>
References: <20200522211309.233824-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/pb-adv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 291d92651..c1316ed1b 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -560,4 +560,9 @@ void pb_adv_unreg(void *user_data)
 	send_close_ind(session, 0);
 	l_queue_remove(pb_sessions, session);
 	l_free(session);
+
+	if (!l_queue_length(pb_sessions)) {
+		l_queue_destroy(pb_sessions, l_free);
+		pb_sessions = NULL;
+	}
 }
-- 
2.25.4

