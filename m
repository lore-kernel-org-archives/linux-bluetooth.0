Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 03:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFE320758
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 03:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9eAArlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgESDKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 23:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgESDKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 23:10:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88FAC061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 20:10:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n15so728706pjt.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWOTdZi7BjfNU6IStooGncHExVaXLvE7BgmB90JE6Fw=;
        b=m9eAArlHPj8p3MqomYAn9ALtfJWw2F8q0cP+xXpAhWKOIIcxzcz/vXuHfiQerxvu97
         uRakjkxgCOOKe4yCW1zpgpnXfEiQJOjRhG9RATPDmTLu+6Dwa4hAm3FvaEYNo4NKcV+M
         oeT5Y79Ih4yDQES69XsnTFBn4Mbke0ouPXVb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWOTdZi7BjfNU6IStooGncHExVaXLvE7BgmB90JE6Fw=;
        b=r7EXmRS4bjSppXfYQY7FGGz9QJ3TYguBWSdTB7wbd4GGyyEvddRdpnpegdnKoUmNA3
         PnbsZU3ybt1Qm3Ss9ACH2zQkfPDTKUwSRvYj2TLcHZZbPFPKE8t2gb+Qb9X4jpDQ/mEu
         FYvWzLM/qfdwEvOsEFpZyIzGWmc6euqy1dCgD4yxcvvj+I4fv/sybw4iNI5k4e+5hHzv
         JzaoTdMuh3YwCHrQ6pBKCmh7owhVIcGBfBO41hLradezgEG1Y7U3Y4GdpP1no2n2uRzq
         3HR9dijWbdXXiIxybdfjIn6DvwjbJXKMHUCOMhOKur8BGxzSoR8gmOZ2SuY8J9KStnDP
         Hwzw==
X-Gm-Message-State: AOAM530lknYdzBAoUtx354u0GN1k/TGlO2ijWIeiuEvWrdl6SsQynH/N
        auq9r8JbfpvNIsqvuXkGvKGnEuw+y14=
X-Google-Smtp-Source: ABdhPJzayZoq46TH6RlnNrv59F1zj/oT9MrcYwfUxn4RqGWvhoW36nIlELwIwbdXA2N53WKsGpyQJg==
X-Received: by 2002:a17:90a:8c09:: with SMTP id a9mr2753017pjo.172.1589857811060;
        Mon, 18 May 2020 20:10:11 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id ce21sm726479pjb.51.2020.05.18.20.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:10:10 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2] lib: Add definitions for advertisement monitor features
Date:   Mon, 18 May 2020 20:10:00 -0700
Message-Id: <20200518200949.BlueZ.v2.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following command opcodes, event codes and the corresponding
structures.
- MGMT_OP_READ_ADV_MONITOR_FEATURES
- MGMT_OP_ADD_ADV_PATTERNS_MONITOR
- MGMT_OP_REMOVE_ADV_MONITOR
- MGMT_EV_ADV_MONITOR_ADDED
- MGMT_EV_ADV_MONITOR_REMOVED
---

Changes in v2:
- Fix build failures.

 lib/mgmt.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index b4fc72069..6d7441ccc 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -628,6 +628,42 @@ struct mgmt_rp_set_exp_feature {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS	(1 << 0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x004B
+struct mgmt_rp_read_adv_monitor_features {
+	uint32_t supported_features;
+	uint32_t enabled_features;
+	uint16_t max_num_handles;
+	uint8_t max_num_patterns;
+	uint16_t num_handles;
+	uint16_t handles[0];
+}  __packed;
+
+struct mgmt_adv_pattern {
+	uint8_t ad_type;
+	uint8_t offset;
+	uint8_t length;
+	uint8_t value[31];
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x004C
+struct mgmt_cp_add_adv_patterns_monitor {
+	uint8_t pattern_count;
+	struct mgmt_adv_pattern patterns[0];
+} __packed;
+struct mgmt_rp_add_adv_patterns_monitor {
+	uint16_t monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x004D
+struct mgmt_cp_remove_adv_monitor {
+	uint16_t monitor_handle;
+} __packed;
+struct mgmt_rp_remove_adv_monitor {
+	uint16_t monitor_handle;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -857,6 +893,16 @@ struct mgmt_ev_exp_feature_changed {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_ADDED	0x0028
+struct mgmt_ev_adv_monitor_added {
+	uint16_t monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x0029
+struct mgmt_ev_adv_monitor_removed {
+	uint16_t monitor_handle;
+}  __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -933,6 +979,9 @@ static const char *mgmt_op[] = {
 	"Read Security Information",			/* 0x0048 */
 	"Read Experimental Features Information",
 	"Set Experimental Feature",
+	"Read Advertisement Monitor Features",
+	"Add Advertisement Patterns Monitor",
+	"Remove Advertisement Monitor",
 };
 
 static const char *mgmt_ev[] = {
@@ -976,6 +1025,8 @@ static const char *mgmt_ev[] = {
 	"Extended Controller Information Changed",
 	"PHY Configuration Changed",
 	"Experimental Feature Changed",
+	"Advertisement Monitor Added",			/* 0x0028 */
+	"Advertisement Monitor Removed",
 };
 
 static const char *mgmt_status[] = {
-- 
2.26.2

