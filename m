Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D93DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Oct 2022 18:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiJNS5Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJNS5X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Oct 2022 14:57:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229291D3748
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 11:57:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g28so5718104pfk.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RX30rg6WmboD9/oaN/9GsKnM75vpU7IW8psSf4cD6g0=;
        b=iRcQg/dKXDqtd8PoaQuczupOa+QvlOh/sxZREVYHfc+/ZbXEHZD3msz9bwUezOxQrt
         jrUJdrKRdPcc/gB5yp/rEFjglkZAy/T0eGg24hlVBf6B62caUNUQDuGLSYI1B9XLV9XG
         flaFzpo9laV/p4VC5yuFbnKmtZe/qvdrbR3jbbZm5BZ0OaV9Y7GkWC45S1YkDg1Qa8KG
         0+dIdvl3p801YheyX6arrdSTn/9luxdcFZzSwtqgTBhWjIhneu5Nx1rbhzeddgXTYmZD
         JGPG3jZzkgfm3/m+B4r+0CvGpxqi8nffLOjasGtS1eXbemP2LH5Q1JCV7EA4ugXL8k2L
         lrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RX30rg6WmboD9/oaN/9GsKnM75vpU7IW8psSf4cD6g0=;
        b=iAgBuOBVkCaz0e5hZ3G1T22UyM6BORyiaMs8hqD0wy9HPaIFmg+ilsbTxtIxmtYgFh
         NKwaf9JQhSZAnAYDHb5OXU9KeeGNEn4/Vvmup0zB4SnygZj9pZZ+a2RDSBw0c8dTBOzZ
         8L+U48gJBdOAl38CJyI5Wag3dhC/OMNQM/WJ1KYhI4474bvt/uYAb2nh62kaIUX9xmzG
         A2W45rVc3J08Kho/m8DeDtlh7odmJYkpJHMYeNKlpT96yCJr0ULZ8yzUGP2PzZHMGBxJ
         4f2WVplvLIu86WjElGe8xuOjGprXTatxJ9dyTn7sFMZspmbm69cNodtZ+SwTCXV37Jxu
         FkmA==
X-Gm-Message-State: ACrzQf3prosbf/GcteSpYY2hJr8Vr67C/B8mvZM/9Z3WrUn3RRww/I6G
        pzn3Rbqov4+LDiqbdANvln1C23O20tY=
X-Google-Smtp-Source: AMsMyM7WAGi5b3iTme407FSSgiGVNuhsXcmsDUqbNu6etJCHB2BGpHNe9JxNOmQoHyQiD2nUiem+CQ==
X-Received: by 2002:a65:6bca:0:b0:420:712f:ab98 with SMTP id e10-20020a656bca000000b00420712fab98mr5679580pgw.350.1665773842394;
        Fri, 14 Oct 2022 11:57:22 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:ab40:7d71:fa07:4ac4])
        by smtp.gmail.com with ESMTPSA id p4-20020a637f44000000b0043954df3162sm1740730pgn.10.2022.10.14.11.57.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:57:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] monitor: Fix incorrect vendor name for vendor cmd and evt
Date:   Fri, 14 Oct 2022 11:57:20 -0700
Message-Id: <20221014185720.1132417-1-hj.tedd.an@gmail.com>
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
 monitor/packet.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 692012029..c4e5182f0 100644
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
@@ -9877,22 +9878,16 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 static const struct vendor_evt *current_vendor_evt(const void *data,
 							int *consumed_size)
 {
-	uint16_t manufacturer, msft_opcode;
+	uint16_t manufacturer;
 	uint8_t evt = *((const uint8_t *) data);
 
 	/* A regular vendor event consumes 1 byte. */
 	*consumed_size = 1;
 
-	if (index_current < MAX_INDEX) {
+	if (index_current < MAX_INDEX)
 		manufacturer = index_list[index_current].manufacturer;
-		msft_opcode = index_list[index_current].msft_opcode;
-	} else {
+	else
 		manufacturer = fallback_manufacturer;
-		msft_opcode = BT_HCI_CMD_NOP;
-	}
-
-	if (msft_opcode != BT_HCI_CMD_NOP)
-		return NULL;
 
 	switch (manufacturer) {
 	case 2:
@@ -9904,6 +9899,27 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
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
@@ -10084,7 +10100,7 @@ static void cmd_complete_evt(uint16_t index, const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -10176,7 +10192,7 @@ static void cmd_status_evt(uint16_t index, const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -11618,7 +11634,7 @@ static void vendor_evt(uint16_t index, const void *data, uint8_t size)
 	const struct vendor_evt *vnd = current_vendor_evt(data, &consumed_size);
 
 	if (vnd) {
-		const char *str = current_vendor_str();
+		const char *str = current_vendor_evt_str();
 
 		if (str) {
 			snprintf(vendor_str, sizeof(vendor_str),
@@ -12020,7 +12036,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
-- 
2.34.1

