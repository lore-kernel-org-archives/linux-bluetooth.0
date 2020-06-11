Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E2FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 23:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A94A2074B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 23:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WnbsNjai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFKXNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFKXNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 19:13:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E3C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 16:13:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so3351787pfp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKWuyf5UIveSTADwQcVUfNBnJQ+ctgbcMprFx3fi5Q8=;
        b=WnbsNjaiJrPi6qZhrTVCCQAwLcLmfI0nbBDkXji0U+iCgaGf7UteUQlP7lEnvM3xGU
         K4LX1TGnmVNv5rzFFqdU2cTiP7AL0iI0CLDTFqJboipij/UXybirdxFz5GVu4muav/LG
         jONBYb/YyOTIpwTRIzRBsKaljdrWmK4cALCQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKWuyf5UIveSTADwQcVUfNBnJQ+ctgbcMprFx3fi5Q8=;
        b=rKd8/gMZzTiYOoQm0zBi3BocOVKN+fbGQfH1qgshZFe54nY4FtolA6aDDzg4ZGm2eP
         elFNDrgOsHoVlPzTJBy74dJtNXE+7pf9+rKzLq9ft3OJ5mioh8Rl1niDBqj0ETCL/k5M
         /oPo43K3+ba9G+mpgABdlr2c0juDYD0npMjTMorLpQvldt+6lyL2XzCrnmYggTU5oT16
         mwBT2NMHsFPpehwLH28YIkr+nCiMu9b9iII6DC4Aoh8PYJf6I1FYqTu0yKNxtPaxThUS
         vPoucrYOsbun2xphPEbJngfg6sYYBZLp5c/VvK7dUjni4ahGh8uWeakv4OUQrwW6dfKQ
         Xh5Q==
X-Gm-Message-State: AOAM531oqysgyoZlEzXTsdTperq2JKjE+GX84rdzvSrCMTLi00YIbD12
        pgi4i1o98org0QJcrey4ccexUtgXiUg=
X-Google-Smtp-Source: ABdhPJxdA40tboOixC9HqP7Dfp76L5pCkNcG7t1kJvGo1AmEaLhkvmDBE7W99S/SDA6qQNFifPoYOg==
X-Received: by 2002:a63:8c5a:: with SMTP id q26mr4462413pgn.312.1591917214161;
        Thu, 11 Jun 2020 16:13:34 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id t22sm3487520pjy.32.2020.06.11.16.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 16:13:33 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3] mgmt: Add definitions for advertisement monitor features
Date:   Thu, 11 Jun 2020 16:13:25 -0700
Message-Id: <20200611161241.BlueZ.v3.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
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

Changes in v3:
- Update mgmt command/event opcodes to match with mgmt-api.txt.
- Insert dummy lines for the skipped command/event opcodes.

Changes in v2:
- Fix build failures.

 lib/mgmt.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 2f78d75bf..59856711b 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -646,6 +646,42 @@ struct mgmt_cp_set_default_system_parameters {
 	uint8_t  parameters[0]; /* mgmt_system_parameter_tlv */
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS	(1 << 0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x0051
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
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
+struct mgmt_cp_add_adv_patterns_monitor {
+	uint8_t pattern_count;
+	struct mgmt_adv_pattern patterns[0];
+} __packed;
+struct mgmt_rp_add_adv_patterns_monitor {
+	uint16_t monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x0053
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
@@ -875,6 +911,16 @@ struct mgmt_ev_exp_feature_changed {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_ADDED	0x002b
+struct mgmt_ev_adv_monitor_added {
+	uint16_t monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x002c
+struct mgmt_ev_adv_monitor_removed {
+	uint16_t monitor_handle;
+}  __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -953,6 +999,13 @@ static const char *mgmt_op[] = {
 	"Set Experimental Feature",
 	"Read Default System Configuration",
 	"Set Default System Configuration",
+	"<0x004d>",
+	"<0x004e>",
+	"<0x004f>",
+	"<0x0050>",					/* 0x0050 */
+	"Read Advertisement Monitor Features",
+	"Add Advertisement Patterns Monitor",
+	"Remove Advertisement Monitor",
 };
 
 static const char *mgmt_ev[] = {
@@ -996,6 +1049,11 @@ static const char *mgmt_ev[] = {
 	"Extended Controller Information Changed",
 	"PHY Configuration Changed",
 	"Experimental Feature Changed",
+	"<0x0028>",					/* 0x0028 */
+	"<0x0029>",
+	"<0x002a>",
+	"Advertisement Monitor Added",
+	"Advertisement Monitor Removed",
 };
 
 static const char *mgmt_status[] = {
-- 
2.26.2

