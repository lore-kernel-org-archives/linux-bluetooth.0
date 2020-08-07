Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B44C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2035206B5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHGBRV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:17:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:31449 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgHGBRU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 21:17:20 -0400
IronPort-SDR: FQD3XSe1QiarS2NroEoqlHumxtjWzcWZfxr70b8ZpJX6srOBCfdCRF79vlarXB1E5HRCmZ7mko
 JiZzsSNAipdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152936391"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="152936391"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 18:17:17 -0700
IronPort-SDR: TSyuzHD6ml2jaXtM9ekBHxOHx1FfjghLQG2i46/AyCEIkmVVCNZBkWXd/2uk9VLB/mR1bBMbIp
 IexxbN19++ig==
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="493876851"
Received: from apazhamp-mobl.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.254.82.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 18:17:17 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 3/3] btpclient: Fix gap reset not sending response
Date:   Thu,  6 Aug 2020 18:17:03 -0700
Message-Id: <20200807011703.22087-3-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200807011703.22087-1-tedd.an@linux.intel.com>
References: <20200807011703.22087-1-tedd.an@linux.intel.com>
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

