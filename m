Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Oct 2022 02:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJNCCv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 22:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNCCu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 22:02:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5704A185419
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 19:02:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so3510371pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSU5NpiwuaXsgptONk3Fc85PS5GRj+bQGDybLa8MA8k=;
        b=HP5IOOSDxMTVWRRucZlxCh8Xko2hfYdnrNBKWzAS2Njy7U5gFQfBqeA++A3ceOx9u6
         QYKLvpNSGFJwJW/uetUS07INr6Rt9+YnOjPq0f8wCEhyqGmpJQ6otTmCtOdZhc1oYgr0
         J52AOnyZX2yRjBND/8RhBcV0NPcM+cw+GzDn8WRbS8jteDRA7BebcezhHol3ahoZPagY
         Y6htI1pLAcbrgShn4HbbN0AIVni7S+moD00/0bpxaeHpMkokxEPvSw2hpZjyhXp7EIe7
         90SO0dNXBi2PNnJToF1HZn9WYgvYC+p0FU+pOVpZnb4nZytnZkXr5x8yK8Hcv0kPAgfK
         ZoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSU5NpiwuaXsgptONk3Fc85PS5GRj+bQGDybLa8MA8k=;
        b=tW1nCzJuJ29t2KU9YMx1CEh6PDcK1nJL4Iqvdl7NmSaG+QZxZH5QGjrpnTYGVd5WwC
         7/1SZduWHPw5sz5GEo3siQ/w/Zzg3e7NNTOMaJckZRPt2Ej7xTh3uTRIDloAvSlCX64x
         5IfKin2e+jF62Oub9Jw47mXJkjCqDDCvnOdoHzFmS3Y7lDTMCy+4fcWFmsJWbewKJgWm
         LSWoCHHWBI5cQRwPqkXAbhedQhom31U8qfZtDlDZiLpyRWKTc/IJzjeo+H3Q59FT1xYc
         Dk80yXlhcAt1AFh1BHwGqN/mkqljPq3qCD3QbIF8MkdEJ3ThfxBGPU2DLlZSp1yV/Cbp
         5/9Q==
X-Gm-Message-State: ACrzQf1I+0G2IY5NxD4cYqdHrq0mODQoWJWuHrCWjNoWimGrQAHXw8Pd
        h85Nq4ukRcNSs6jho3j+rEj71oYSY70=
X-Google-Smtp-Source: AMsMyM4fmFf4hhw/KhOxjEbndlkAkr4djIlVIL4gDzUQBEDJ3uIhdgNN4Qz1gF4becwc6w1R4JJabg==
X-Received: by 2002:a17:903:244a:b0:184:586e:8864 with SMTP id l10-20020a170903244a00b00184586e8864mr2884797pls.113.1665712968527;
        Thu, 13 Oct 2022 19:02:48 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:ab40:7d71:fa07:4ac4])
        by smtp.gmail.com with ESMTPSA id o7-20020a625a07000000b00562496395besm363162pfb.170.2022.10.13.19.02.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 19:02:48 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] monitor: Fix incorrect vendor name for vendor cmd and evt
Date:   Thu, 13 Oct 2022 19:02:46 -0700
Message-Id: <20221014020246.1035012-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the issue that the vendor name for all vendor HCI
command and event are display as Microsoft.
---
 monitor/packet.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 692012029..d11d8808d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9821,7 +9821,7 @@ static const char *get_supported_command(int bit)
 	return NULL;
 }
 
-static const char *current_vendor_str(void)
+static const char *current_vendor_str(uint16_t ocf)
 {
 	uint16_t manufacturer, msft_opcode;
 
@@ -9833,7 +9833,8 @@ static const char *current_vendor_str(void)
 		msft_opcode = BT_HCI_CMD_NOP;
 	}
 
-	if (msft_opcode != BT_HCI_CMD_NOP)
+	if (msft_opcode != BT_HCI_CMD_NOP &&
+				cmd_opcode_ocf(msft_opcode) == ocf)
 		return "Microsoft";
 
 	switch (manufacturer) {
@@ -9891,9 +9892,6 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
 		msft_opcode = BT_HCI_CMD_NOP;
 	}
 
-	if (msft_opcode != BT_HCI_CMD_NOP)
-		return NULL;
-
 	switch (manufacturer) {
 	case 2:
 		return intel_vendor_evt(data, consumed_size);
@@ -9904,6 +9902,27 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
 	return NULL;
 }
 
+static const char *current_vendor_evt_str(void)
+{
+	uint16_t manufacturer;
+
+	if (index_current < MAX_INDEX)
+		manufacturer = index_list[index_current].manufacturer;
+	else
+		manufacturer = fallback_manufacturer;
+
+	switch (manufacturer) {
+	case 2:
+		return "Intel";
+	case 15:
+		return "Broadcom";
+	case 93:
+		return "Realtek";
+	}
+
+	return NULL;
+}
+
 static void inquiry_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_complete *evt = data;
@@ -10084,7 +10103,7 @@ static void cmd_complete_evt(uint16_t index, const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -10176,7 +10195,7 @@ static void cmd_status_evt(uint16_t index, const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -11618,7 +11637,7 @@ static void vendor_evt(uint16_t index, const void *data, uint8_t size)
 	const struct vendor_evt *vnd = current_vendor_evt(data, &consumed_size);
 
 	if (vnd) {
-		const char *str = current_vendor_str();
+		const char *str = current_vendor_evt_str();
 
 		if (str) {
 			snprintf(vendor_str, sizeof(vendor_str),
@@ -12020,7 +12039,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
-- 
2.34.1

