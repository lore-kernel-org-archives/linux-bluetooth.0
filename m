Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A7DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 23:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9824E2072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 23:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATKOt2HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgERXyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgERXx7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 19:53:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D77C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 16:53:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so5566289pgn.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/10x0uNla2zl5e736aQzqou192BBkCx3UHffdpSHiww=;
        b=ATKOt2HSzHYIbOciIb2InbkV/WBUOEisocxRbBsrOdiW4MAmebWu3Jv59qUbq4+AEx
         n6QjlPpN25O13sMrIlfxYJ1QFPpXpKdZnnIrnKNA1S3ZiDmODzO6nULgpIA5bbKIfCHx
         rpS9gyWqhGnsbkmfQifws0X5v4ijwwqz4HRcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/10x0uNla2zl5e736aQzqou192BBkCx3UHffdpSHiww=;
        b=svwln8sXVrSWqwYVFyd9YUX1d407fNeZ7BUK+EW3A8Y++b46mognYTxjGgBCCydPaf
         BPmSC38xc7SdXVZVsRAvRGToHHlgstI5IY0hCKQIAP2xpcHZrf8QV0/o7MpZJS+d5VA7
         gNpDOXHLgFgH5BZNHTRUDBuvC4M5M2xolcQ5uPqxRMooxLAGb/MCoFn/mLbxw92X+rUn
         PAZVkmj8vrLZI+2mSqlqinVWLXCnKYgp5ID9u5qpbtn6vX05PEE07OcRlzVrK+xlXY2w
         IFPfIerne2VIZmK7+JndLHVWATQeLeYlEGqjax9Igcin/p4oVrRY5GnjRfEKD2EnG0FG
         WaQA==
X-Gm-Message-State: AOAM532oDj/w7DzZhxBrYVhZ2I1SOrm52wCySXJJixeV4GiQUxhGWc6s
        3opPTFrxmhghBe/ssPonI2dgd5kWyH0=
X-Google-Smtp-Source: ABdhPJx64zGNGmmyjIkjI3t3MyyQOumUatusJW9uzIxTf7rWs2iwYHVqFY8BoJcKrBUXr3Vzf4QmwQ==
X-Received: by 2002:aa7:95a5:: with SMTP id a5mr10901140pfk.151.1589846038997;
        Mon, 18 May 2020 16:53:58 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id a30sm8562417pgm.44.2020.05.18.16.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 16:53:58 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] lib: Add definitions for advertisement monitor features
Date:   Mon, 18 May 2020 16:53:54 -0700
Message-Id: <20200518165301.BlueZ.v1.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
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

 lib/mgmt.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index b4fc72069..9fc9c1717 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -628,6 +628,42 @@ struct mgmt_rp_set_exp_feature {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS	(1 << 0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x004B
+struct mgmt_rp_read_adv_monitor_features {
+	__u32 supported_features;
+	__u32 enabled_features;
+	__u16 max_num_handles;
+	__u8 max_num_patterns;
+	__16 num_handles;
+	__16 handles[0];
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
+	struct mgmt_adv_pattern patterns[0];
+} __packed;
+struct mgmt_rp_add_adv_patterns_monitor {
+	__u16 monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x004D
+struct mgmt_cp_remove_adv_monitor {
+	__u16 monitor_handle;
+} __packed;
+struct mgmt_rp_remove_adv_monitor {
+	__u16 monitor_handle;
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
+	__u16 monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x0029
+struct mgmt_ev_adv_monitor_removed {
+	__u16 monitor_handle;
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

