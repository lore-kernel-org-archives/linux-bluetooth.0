Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E591C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 00:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF40610E8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 00:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhJNA7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNA7T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 20:59:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BABC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 17:57:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y1so2972373plk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEeyzxGtuP1ge7cWJUyHCs+RWH7heJp2l3FNn5r5mnM=;
        b=p3pI1lBST/wj0wVwQ978WN2HzDlsCZlzqf/LYzTt0TByP+UkW1BgkeK0jgyN4RV2iq
         A1lX6luFOnOmSOojvADBIMSHFMW0ojiN3unnmzePgxqgZ9MGoEdASUwgD+4tjEQcAAFs
         GYKcOb7ci7/cVbQfftPQs8Uq3ziCKfu1hAKXdssZZC5wwdKQh+wZhBPHKKbrBEZaCVJ0
         IRQhra3MbGy2sVxo7txK86ENZNOiDJrN8rum7en411QfYsqaaLyBYN9Jr+A0Fo4Sg1J0
         2U6Lpdz5PwPuopHtJkMCg1NHXRzK+psjEkr4jarzyIgLYVKBZK3yc064wp2lzNAnv1mx
         8SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEeyzxGtuP1ge7cWJUyHCs+RWH7heJp2l3FNn5r5mnM=;
        b=tCwYVzAAqrOMJ7hnGT3YtngLlRE3irgRvqfjMyb7pCKFG3UiQNvpflOXlX+/Lj4ENl
         q+AwTB42qQGB9hMh+vMQGQ0tXFSRN1VeitQjWaEee0OOawvqofW50wJuNxQ3kNHdSMxO
         oxpuJ5QVub62dHjmWTBEqiAZYD8a+OA7oVYMyw9w4jvfx3Iaj6tAjl2NyI7cL1ocMGkk
         wy4uL5c81Uzyfr2vzVNtPbFautDahIEUmmv/1rVhfa2KAgdKPSmSOqPTo7BTRz0u3LzN
         6omg0x736rfhvqpWSkYrdtUG+kdW12Hv4caSu2dTD3+Wwa/jTKYRB5gtlkQ7JyBe8WLs
         EZkw==
X-Gm-Message-State: AOAM533I+rxBt1cvielWFfjWDuF+GnqkY7DaQ0oi3mZ43oP9Y2t8IyoT
        VNsj1u+IRZqfbuZXVOVomnX7eRRo4i4=
X-Google-Smtp-Source: ABdhPJwBkJHiQt9OrZjNwZlJk8houwHwk+Qxo94twU5PI7FDBvwq0BfJXVWxi8S0RLLh7N8CCiw42g==
X-Received: by 2002:a17:902:ed8c:b0:13f:136f:efb1 with SMTP id e12-20020a170902ed8c00b0013f136fefb1mr2295554plj.56.1634173034798;
        Wed, 13 Oct 2021 17:57:14 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s17sm640836pge.50.2021.10.13.17.57.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:57:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] monitor: Add packet definitions for MSFT extension
Date:   Wed, 13 Oct 2021 17:57:12 -0700
Message-Id: <20211014005713.2857000-1-luiz.dentz@gmail.com>
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

