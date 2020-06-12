Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F28C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 23:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269EE2078A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 23:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WK4D0qcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFLXqQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFLXqQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 19:46:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E130DC03E96F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 16:46:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so4519393pjv.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 16:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGRzpb5lB92OX59ZTLb3ILoKGjAfwI8TyMX6hJG2aFU=;
        b=WK4D0qcBlxRaJ4ICJ4AKgC72AKQhP9eKgCDlnSWkh1Vu7x2SGnx8b+w0dw8bkrhrZc
         E5+A79X5XGoMa3N1nh7BOviCHx+N9YeQ3koFvfjtroCiUOmlVcILexZX2qf3uOfrkRPS
         ANdpvT0x1t/mWNB4s0PaADQpGi/RZqq8zimSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGRzpb5lB92OX59ZTLb3ILoKGjAfwI8TyMX6hJG2aFU=;
        b=LsjUycaq/hha6S4kT2VeZLVo/i8ApfstZSJiffHdaEy2hRqak3jqSCBagnJmL2AoPh
         WKkqHRL0JdCPEE4wvKl5YaZ/JsC/OGvt6XzMxQpIjz5y5Oa8O5Bda39dBf8OR+mz/Wvp
         +Ls5nli8SXX0Y9pCoTj5ROZSfbq+hCeCeUy2O4VxA3sRT0mk85KcCzg1HDnWDietn0+F
         t+2xdwiKpxxyHcmy7qaNlZfrfGy3euVY+czFMTdbug1dXJIGiYNPq8DxosECFlO5dZ/E
         ++dSFOP6Mu2WeCHqrsQcKvcqB0JTMamBX5qSqC6Jm0RGQ85xKdguhT/9L7CosmFU25as
         RmYQ==
X-Gm-Message-State: AOAM533Z0RSzxg+ab++mojI0G1LyXIupoP+apJqRZUDfFL4t5D8yRizG
        XwDvmlnFOHjdaTHxRuq3A+1wry0O1M4=
X-Google-Smtp-Source: ABdhPJwA7krUN2We5VsuUZM60FdTbjQhCBCJa8wPWTZs8e/1st6xqlaRG9iTgKTewBXG1ggCmlk0Bw==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr13463040plb.233.1592005575019;
        Fri, 12 Jun 2020 16:46:15 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id b19sm6198639pjo.57.2020.06.12.16.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 16:46:13 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 1/7] Bluetooth: Add definitions for advertisement monitor features
Date:   Fri, 12 Jun 2020 16:45:50 -0700
Message-Id: <20200612164243.v4.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for Advertisement Monitor API. Here are the commands
and events added.
- Read Advertisement Monitor Feature command
- Add Advertisement Pattern Monitor command
- Remove Advertisement Monitor command
- Advertisement Monitor Added event
- Advertisement Monitor Removed event

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4: None
Changes in v3:
- Update command/event opcodes.
- Correct data types.

Changes in v2: None

 include/net/bluetooth/mgmt.h | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fae..fcc5d0349f549 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,45 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS    BIT(0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x0051
+#define MGMT_READ_ADV_MONITOR_FEATURES_SIZE	0
+struct mgmt_rp_read_adv_monitor_features {
+	__le32 supported_features;
+	__le32 enabled_features;
+	__le16 max_num_handles;
+	__u8 max_num_patterns;
+	__le16 num_handles;
+	__le16 handles[];
+}  __packed;
+
+struct mgmt_adv_pattern {
+	__u8 ad_type;
+	__u8 offset;
+	__u8 length;
+	__u8 value[31];
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
+struct mgmt_cp_add_adv_patterns_monitor {
+	__u8 pattern_count;
+	struct mgmt_adv_pattern patterns[];
+} __packed;
+#define MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE	1
+struct mgmt_rp_add_adv_patterns_monitor {
+	__le16 monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x0053
+struct mgmt_cp_remove_adv_monitor {
+	__le16 monitor_handle;
+} __packed;
+#define MGMT_REMOVE_ADV_MONITOR_SIZE		2
+struct mgmt_rp_remove_adv_monitor {
+	__le16 monitor_handle;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -933,3 +972,13 @@ struct mgmt_ev_exp_feature_changed {
 	__u8	uuid[16];
 	__le32	flags;
 } __packed;
+
+#define MGMT_EV_ADV_MONITOR_ADDED	0x002b
+struct mgmt_ev_adv_monitor_added {
+	__le16 monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x002c
+struct mgmt_ev_adv_monitor_removed {
+	__le16 monitor_handle;
+}  __packed;
-- 
2.26.2

