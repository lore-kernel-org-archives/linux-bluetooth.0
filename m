Return-Path: <SRS0=jcZI=CH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC54C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 00:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DB8207DA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 00:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH2AIN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:08:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:10238 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgH2AIN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 20:08:13 -0400
IronPort-SDR: +3AiurOMES0StYhdXY92G4lc45OSGPiyFlOK7ZOPVjDIbTdSlyP4IccTrjoAdhC/57STOHu9GO
 y3VfdCLkLZzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="136305340"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="136305340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 17:08:10 -0700
IronPort-SDR: u3ZMtn9vWPBh2CQBL+QGtO5w2pQBE3pydhi65ie1KoeleRTLAatETACP2uI1N6ZJv4EBvCwMr6
 6tZ79QYECgvg==
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="324213880"
Received: from asmit14x-mobl1.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.254.83.187])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 17:08:10 -0700
From:   tedd.an@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [V3 3/3] btpclient: Fix gap reset not sending response
Date:   Fri, 28 Aug 2020 17:08:03 -0700
Message-Id: <20200829000803.20286-3-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200829000803.20286-1-tedd.an@intel.com>
References: <20200829000803.20286-1-tedd.an@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the GAP reset command to response the default settings
after resetting the stack.
---
 tools/btpclient.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index f9c693056..38e326670 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -521,6 +521,19 @@ static void reset_unreg_agent_reply(struct l_dbus_proxy *proxy,
 	ag.registered = false;
 }
 
+static void update_current_settings(struct btp_adapter *adapter,
+							uint32_t new_settings)
+{
+	struct btp_new_settings_ev ev;
+
+	adapter->current_settings = new_settings;
+
+	ev.current_settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_NEW_SETTINGS, adapter->index,
+							sizeof(ev), &ev);
+}
+
 static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 								void *user_data)
 {
@@ -528,6 +541,7 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 	const struct l_queue_entry *entry;
 	uint8_t status;
 	bool prop;
+	uint32_t default_settings;
 
 	if (!adapter) {
 		status = BTP_ERROR_INVALID_INDEX;
@@ -570,10 +584,13 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 			goto failed;
 		}
 
-	adapter->current_settings = adapter->default_settings;
+	default_settings = adapter->default_settings;
+
+	update_current_settings(adapter, default_settings);
 
 	/* TODO for we assume all went well */
-	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index,
+				sizeof(default_settings), &default_settings);
 	return;
 
 failed:
@@ -644,19 +661,6 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
-static void update_current_settings(struct btp_adapter *adapter,
-							uint32_t new_settings)
-{
-	struct btp_new_settings_ev ev;
-
-	adapter->current_settings = new_settings;
-
-	ev.current_settings = L_CPU_TO_LE32(adapter->current_settings);
-
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_NEW_SETTINGS, adapter->index,
-							sizeof(ev), &ev);
-}
-
 static void btp_gap_set_connectable(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
-- 
2.25.4

