Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84354C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 23:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDDA2078C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 23:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZumT5u8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437736AbgE1XzL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437671AbgE1XzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 19:55:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8918C08C5CA
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 16:55:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so406058pgg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 16:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7SGnHQEJZH8F0krQCl34Ydvm5S42dlpxkmjv3VJYu0=;
        b=eZumT5u8Wa2rtx0tfJi7hNCNpvi5FowWlYQPg0HGhtWAz2exsdLuiOm9vm80khaBOZ
         sEerEOEVmI0X1JZBo5ez4n+g2U3SHxddLQSXjkFGGWId8po8DcqSbdABFlsPp2KqMeTt
         fy7p33+jZTYUOaIG0lXROVj5SfR/tCZnOlUGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7SGnHQEJZH8F0krQCl34Ydvm5S42dlpxkmjv3VJYu0=;
        b=uQdjsYB8s7e1YIeRFOuAqth8y15W+lObeK3hIqOOxjflhNCYz9MEkniYRyj/Bnoa6/
         FxSreF7aWtz+KMQD1FQ/g4n2EDZzzc1XlBPm51F3HgzHC0XSqamJ9RSh4h4uvbQAi5/r
         5REoVj6qlAYSukU0o28FengTt7SDwazuiAevFfaxPbIRdMJgeodXLrr95TG5LZxCYAWC
         FdDwEqswWlp+PzLaWC0CEZAjEwnOe95d3v4D9ev4surde70l36ilS3uazYNFhdpXv5hg
         nlrK/nZYlWFwp1N+PbFkgnWhG4NWPirlNcJvXpYEky/XD2ivtmtoiSnN9EpMRKGsLMcX
         h9/g==
X-Gm-Message-State: AOAM532Gq1sF0tXJsW0f61xKtqhe6ZEACYgqQAjiwZdQVyHbUUzebVRq
        YOsUBECTgbXOQjUkheFha6ChVDJyhTg=
X-Google-Smtp-Source: ABdhPJwwodXakmojQKptX1+Fol9ux6f2AaOWGzBj7pIY7pNb4HrA3CwJVMigps57BlYgCLq/Gmt2LA==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr5544651pfc.65.1590710106747;
        Thu, 28 May 2020 16:55:06 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id f18sm5022591pga.75.2020.05.28.16.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 16:55:05 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 1/7] Bluetooth: Add definitions for advertisement monitor features
Date:   Thu, 28 May 2020 16:54:49 -0700
Message-Id: <20200528165324.v1.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
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

 include/net/bluetooth/mgmt.h | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fae..df36c50d15f53 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,45 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS    BIT(0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x004B
+#define MGMT_READ_ADV_MONITOR_FEATURES_SIZE	0
+struct mgmt_rp_read_adv_monitor_features {
+	__u32 supported_features;
+	__u32 enabled_features;
+	__u16 max_num_handles;
+	__u8 max_num_patterns;
+	__u16 num_handles;
+	__u16 handles[];
+}  __packed;
+
+struct mgmt_adv_pattern {
+	__u8 ad_type;
+	__u8 offset;
+	__u8 length;
+	__u8 value[31];
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x004C
+struct mgmt_cp_add_adv_patterns_monitor {
+	__u8 pattern_count;
+	struct mgmt_adv_pattern patterns[];
+} __packed;
+#define MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE	1
+struct mgmt_rp_add_adv_patterns_monitor {
+	__u16 monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x004D
+struct mgmt_cp_remove_adv_monitor {
+	__u16 monitor_handle;
+} __packed;
+#define MGMT_REMOVE_ADV_MONITOR_SIZE		2
+struct mgmt_rp_remove_adv_monitor {
+	__u16 monitor_handle;
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
+#define MGMT_EV_ADV_MONITOR_ADDED	0x0028
+struct mgmt_ev_adv_monitor_added {
+	__u16 monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x0029
+struct mgmt_ev_adv_monitor_removed {
+	__u16 monitor_handle;
+}  __packed;
-- 
2.26.2

