Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67079C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9AF60EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhJOFLk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhJOFLj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9FC061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c4so506620pgv.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEeyzxGtuP1ge7cWJUyHCs+RWH7heJp2l3FNn5r5mnM=;
        b=hOsDgUUTkDhuu9Gg2kCLyVw1MOPoqVHQ/SLjJRcjbjOYTag1RrbrAHcMn95jeaWh9D
         cjItANxDRdzPPJhek/16GhNYuK+6HcI34Id8UTXUdFgRySYD7hamd8Tw7qBJ6iFmzYn4
         UV9taJytEF02XucG6EExg1Cf3blWK2GMEA8hF09S15YZzh/KqUhxpm9Xan9eePd93HMM
         uMOEEHsxFf5/i2abZiZuUDe/Q95971qK5dWvObFZJXc1nELyp1p2uPE4kXYMW7rshcDJ
         wRwEiVTnxNZcDbO0zKHniXioGtcp++3aRoGlFp3SeZAG7ibRxNi0KBCsXfRh/9SQTM90
         MYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEeyzxGtuP1ge7cWJUyHCs+RWH7heJp2l3FNn5r5mnM=;
        b=Y5LLhGQA4AFkJw0Eoe8SBELJyNJ22f0ELPDSCs06cW18ZpKqvi/WraWHd12uVWSVZu
         02oanFpnzH1saMedy7SoGmUGaacrTb2D61B+ee5zOkXg6bI0p7EmQYQfqBt+xdZaSzq9
         iNKasmmuwxy4PtbzKDDTmHdjGF8ocWw1Z1jWm/SVorekggzIQMHNIFv+tG/QLmU75aq4
         6ea/fmUyeQPhm3gBm8vCU3UoBdmWvYvGlarVJJpTZrheKMQBMfZIVYg4LesfiJRbn5mi
         B55gVCRca0oB9CbzsfBpxjfMmMmIw4cXwbnoz/6JIs5s8uvqEwmKvxnBOUZyF6O+o3/S
         oO8w==
X-Gm-Message-State: AOAM531G7zLchaGWIaGC4eMIlpF+8vs05Yxrn9H2kb2JqJz6KpTsawis
        G4k04YCCIpLrhczF24LFUBpq4fQq548=
X-Google-Smtp-Source: ABdhPJykhjuB8XdbKBQWtdeFxNwY7McBnrCsHziQQlWs4OT6FZqjtFjWPFX4ywetXDnrBMjRXGWoAQ==
X-Received: by 2002:a63:7e45:: with SMTP id o5mr7484231pgn.445.1634274572858;
        Thu, 14 Oct 2021 22:09:32 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p17sm10347510pju.34.2021.10.14.22.09.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:09:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] monitor: Add packet definitions for MSFT extension
Date:   Thu, 14 Oct 2021 22:09:23 -0700
Message-Id: <20211015050929.3130100-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper packet definitions for command and response of MSFT
extension.
---
 monitor/msft.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/monitor/msft.h b/monitor/msft.h
index a268f4bc7..90a64117a 100644
--- a/monitor/msft.h
+++ b/monitor/msft.h
@@ -24,6 +24,154 @@
 
 #include <stdint.h>
 
+#define MSFT_SUBCMD_READ_SUPPORTED_FEATURES	0x00
+
+struct msft_cmd_read_supported_features {
+	uint8_t subcmd;
+} __attribute__((packed));
+
+struct msft_rsp_read_supported_features {
+	uint8_t  status;
+	uint8_t  subcmd;
+	uint8_t  features[8];
+	uint8_t  evt_prefix_len;
+	uint8_t  evt_prefix[];
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_MONITOR_RSSI		0x01
+
+struct msft_cmd_monitor_rssi {
+	uint8_t  subcmd;
+	uint16_t handle;
+	int8_t   rssi_high;
+	int8_t   rssi_low;
+	uint8_t  rssi_low_interval;
+	uint8_t  rssi_period;
+} __attribute__((packed));
+
+struct msft_rsp_monitor_rssi {
+	uint8_t  status;
+	uint8_t  subcmd;
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_CANCEL_MONITOR_RSSI		0x02
+
+struct msft_cmd_cancel_monitor_rssi {
+	uint8_t  subcmd;
+	uint16_t handle;
+} __attribute__((packed));
+
+struct msft_rsp_cancel_monitor_rssi {
+	uint8_t  status;
+	uint8_t  subcmd;
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_LE_MONITOR_ADV		0x03
+
+struct msft_le_monitor_pattern {
+	uint8_t  len;
+	uint8_t  type;
+	uint8_t  start;
+	uint8_t  data[];
+} __attribute__((packed));
+
+struct msft_le_monitor_adv_pattern_type {
+	uint8_t num_patterns;
+	struct msft_le_monitor_pattern data[];
+} __attribute__((packed));
+
+struct msft_le_monitor_adv_uuid_type {
+	uint8_t  type;
+	union {
+		uint16_t u16;
+		uint32_t u32;
+		uint8_t  u128[8];
+	} value;
+} __attribute__((packed));
+
+struct msft_le_monitor_adv_irk_type {
+	uint8_t  irk[8];
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_LE_MONITOR_ADV_ADDR		0x04
+struct msft_le_monitor_adv_addr {
+	uint8_t  type;
+	uint8_t  addr[6];
+} __attribute__((packed));
+
+struct msft_cmd_le_monitor_adv {
+	uint8_t  subcmd;
+	int8_t   rssi_low;
+	int8_t   rssi_high;
+	uint8_t  rssi_low_interval;
+	uint8_t  rssi_period;
+	uint8_t  type;
+	uint8_t  data[];
+} __attribute__((packed));
+
+struct msft_rsp_le_monitor_adv {
+	uint8_t  status;
+	uint8_t  subcmd;
+	uint8_t  handle;
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_LE_CANCEL_MONITOR_ADV	0x04
+
+struct msft_cmd_le_cancel_monitor_adv {
+	uint8_t  subcmd;
+	uint8_t  handle;
+} __attribute__((packed));
+
+struct msft_rsp_le_cancel_monitor_adv {
+	uint8_t  status;
+	uint8_t  subcmd;
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_LE_MONITOR_ADV_ENABLE	0x05
+
+struct msft_cmd_le_monitor_adv_enable {
+	uint8_t  subcmd;
+	uint8_t  enable;
+} __attribute__((packed));
+
+struct msft_rsp_le_monitor_adv_enable {
+	uint8_t  status;
+	uint8_t  subcmd;
+} __attribute__((packed));
+
+#define MSFT_SUBCMD_READ_ABS_RSSI		0x06
+
+struct msft_cmd_read_abs_rssi {
+	uint8_t  subcmd;
+	uint16_t handle;
+} __attribute__((packed));
+
+struct msft_rsp_read_abs_rssi {
+	uint8_t  status;
+	uint8_t  subcmd;
+	uint16_t handle;
+	uint8_t  rssi;
+} __attribute__((packed));
+
+#define MSFT_SUBEVT_RSSI			0x01
+
+struct msft_evt_rssi {
+	uint8_t  subevt;
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  rssi;
+} __attribute__((packed));
+
+#define MSFT_SUBEVT_MONITOR_DEVICE		0x02
+
+struct msft_evt_monitor_device {
+	uint8_t  subevt;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  handle;
+	uint8_t  state;
+} __attribute__((packed));
+
 struct vendor_ocf;
 struct vendor_evt;
 
-- 
2.31.1

