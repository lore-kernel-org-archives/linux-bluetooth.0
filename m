Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DEEC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 19:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4421D61450
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 19:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbhDUTgL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhDUTgL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Apr 2021 15:36:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD08C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 12:35:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e2so17926512plh.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oW2GkaOj0HcDnC01fUYCZBZ3nWShC/mHEShqSkGQpxU=;
        b=XgfkVcq1xZLnVguZfXniT3g9cKJZHkiFYqG77DOXVzAE0CHOQsu8/zNDeWondPbPGn
         6RwvtA3IYI7HDc+OG/1uR6FlwdczoJd9AJio3gl9kAYHg+LV0sOljLbF/5X9TOPPuQ0A
         lWc0sCOksVSSRj6f+SXT8dZ1phhYVnk09QNpEGN7O6QAXqXd/3jpJskmyPInqrfmINX6
         3dSFoeNUFE0tL7BuCqp8JVXQVfYuuQPgac+qfT/a5LHfF+8CBTaBLutbZJ7pVJh7UQmZ
         Ruhzp+ps5dqCqSrDFr9zd0lL6BufwQp1/SGLZBm4hzn5RBnQ+YF9hTSRa0XkVniRwtN0
         GGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oW2GkaOj0HcDnC01fUYCZBZ3nWShC/mHEShqSkGQpxU=;
        b=omoXxX7v46Ecs51wbpwst5FJZXzYgHq7Zz8jSmeEJj1HOVNNL9SgPAa7Uj+jnmj6k2
         LRFIKOjV0ox+2rouVWciUlmYppzJuGQMsVmaJ2/CAJOK9xBUle0z3EucGINApfkzEaKG
         LpCNRQjSrccPKT8RNkUU5YhU+VYdABr5V/pZOmZqltDfF1B/DB5W9bnbb6Att54WPfDq
         O221PMYW7eO9V4w6QGYzU7RfmiO53laXgCUAQadPyN97nILUiOM9fqLtoGlPUTvgqfzF
         p4Rs7DD38IGM6OCgOBtL43j5PuVPDATtVfNE/eLHa1pbw/Jhf6WtgW3/0QqT0kFII3C8
         z3+w==
X-Gm-Message-State: AOAM530p14OUgXd3CQh2aMuSGh1rMOvpCdDKNSmlBSW2XR55S/XBDJu/
        SKcnGbRTKJyDIh/A0yzxrtycqPvuvrk=
X-Google-Smtp-Source: ABdhPJyf1EHzRV+Bv9HrLk688R02zoAnLB6t5p/pIzUgLpVtOBLTedhEg8z48vVodRN1lgKVKzmA6g==
X-Received: by 2002:a17:902:d911:b029:ea:cc53:5501 with SMTP id c17-20020a170902d911b02900eacc535501mr35001398plz.21.1619033736862;
        Wed, 21 Apr 2021 12:35:36 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:d74a:a8bf:6ad:5ef0])
        by smtp.gmail.com with ESMTPSA id b21sm105234pfl.82.2021.04.21.12.35.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:35:36 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ v5] monitor: Fix the incorrect vendor name
Date:   Wed, 21 Apr 2021 12:35:35 -0700
Message-Id: <20210421193535.4616-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the vendor name is alwasy shown as "Microsoft".

< HCI Command: Microsoft Secure Send (0x3f|0x0009) plen 249
        Type: Data fragment (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      Microsoft Secure Send (0x3f|0x0009) ncmd 31
        Status: Success (0x00)
---
 monitor/packet.c | 121 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 18 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d729a01cc..42e1fef70 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -266,6 +266,8 @@ struct index_data {
 	uint8_t  bdaddr[6];
 	uint16_t manufacturer;
 	uint16_t msft_opcode;
+	uint8_t  msft_evt_prefix_len;
+	uint8_t  msft_evt_prefix[32];
 	size_t   frame;
 };
 
@@ -3940,6 +3942,8 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 			memcpy(index_list[index].bdaddr, ni->bdaddr, 6);
 			index_list[index].manufacturer = fallback_manufacturer;
 			index_list[index].msft_opcode = BT_HCI_CMD_NOP;
+			index_list[index].msft_evt_prefix_len = 0;
+			memset(index_list[index].msft_evt_prefix, 0, 32);
 		}
 
 		addr2str(ni->bdaddr, str);
@@ -4006,9 +4010,12 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				/*
 				 * Intel controllers that support the
 				 * Microsoft vendor extension are using
-				 * 0xFC1E for VsMsftOpCode.
+				 * 0xFC1E for VsMsftOpCode and 0x50 for event
+				 * code.
 				 */
 				index_list[index].msft_opcode = 0xFC1E;
+				index_list[index].msft_evt_prefix_len = 1;
+				index_list[index].msft_evt_prefix[0] = 0x50;
 				break;
 			case 93:
 				/*
@@ -4017,6 +4024,15 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 * 0xFCF0 for VsMsftOpCode.
 				 */
 				index_list[index].msft_opcode = 0xFCF0;
+				index_list[index].msft_evt_prefix_len = 8;
+				index_list[index].msft_evt_prefix[0] = 0x23;
+				index_list[index].msft_evt_prefix[1] = 0x79;
+				index_list[index].msft_evt_prefix[2] = 0x54;
+				index_list[index].msft_evt_prefix[3] = 0x33;
+				index_list[index].msft_evt_prefix[4] = 0x77;
+				index_list[index].msft_evt_prefix[5] = 0x88;
+				index_list[index].msft_evt_prefix[6] = 0x97;
+				index_list[index].msft_evt_prefix[7] = 0x68;
 				break;
 			}
 		}
@@ -9323,7 +9339,7 @@ static const char *get_supported_command(int bit)
 	return NULL;
 }
 
-static const char *current_vendor_str(void)
+static const char *current_vendor_str(uint16_t ocf)
 {
 	uint16_t manufacturer, msft_opcode;
 
@@ -9335,7 +9351,8 @@ static const char *current_vendor_str(void)
 		msft_opcode = BT_HCI_CMD_NOP;
 	}
 
-	if (msft_opcode != BT_HCI_CMD_NOP)
+	if (msft_opcode != BT_HCI_CMD_NOP &&
+				cmd_opcode_ocf(msft_opcode) == ocf)
 		return "Microsoft";
 
 	switch (manufacturer) {
@@ -9350,6 +9367,27 @@ static const char *current_vendor_str(void)
 	return NULL;
 }
 
+static const char *current_vendor_evt_str(uint8_t evt)
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
 static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 {
 	uint16_t manufacturer, msft_opcode;
@@ -9378,18 +9416,12 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 
 static const struct vendor_evt *current_vendor_evt(uint8_t evt)
 {
-	uint16_t manufacturer, msft_opcode;
+	uint16_t manufacturer;
 
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
@@ -9401,6 +9433,26 @@ static const struct vendor_evt *current_vendor_evt(uint8_t evt)
 	return NULL;
 }
 
+static const struct vendor_evt *current_vendor_msft_evt(const void *data,
+							uint8_t size)
+{
+	uint8_t *prefix, prefix_len;
+
+	if (index_current < MAX_INDEX) {
+		prefix_len = index_list[index_current].msft_evt_prefix_len;
+		prefix = index_list[index_current].msft_evt_prefix;
+	} else
+		return NULL;
+
+	/* MSFT extension events start with the MSFT event prefix which is
+	 * defined by the vendor and followed by the MSFT event code.
+	 */
+	if (size > prefix_len && !memcmp(data, prefix, prefix_len))
+		return msft_vendor_evt();
+
+	return NULL;
+}
+
 static void inquiry_complete_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_complete *evt = data;
@@ -9573,7 +9625,7 @@ static void cmd_complete_evt(const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -9665,7 +9717,7 @@ static void cmd_status_evt(const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -11012,13 +11064,46 @@ static void le_meta_event_evt(const void *data, uint8_t size)
 
 static void vendor_evt(const void *data, uint8_t size)
 {
-	uint8_t subevent = *((const uint8_t *) data);
+	uint8_t subevent;
 	struct subevent_data vendor_data;
 	char vendor_str[150];
-	const struct vendor_evt *vnd = current_vendor_evt(subevent);
+	const struct vendor_evt *vnd;
+
+	/* For MSFT Extension event only */
+	vnd = current_vendor_msft_evt(data, size);
+	if (vnd) {
+		snprintf(vendor_str, sizeof(vendor_str),
+					"Microsoft %s", vnd->str);
+		print_indent(6, COLOR_HCI_EVENT, "", vendor_str, COLOR_OFF,
+					" length: %u", size);
+
+		if (!vnd->evt_func) {
+			packet_hexdump(data, size);
+			return;
+		}
+
+		if (vnd->evt_fixed) {
+			if (size != vnd->evt_size) {
+				print_text(COLOR_ERROR, "invalid packet size");
+				packet_hexdump(data, size);
+				return;
+			}
+		} else {
+			if (size < vnd->evt_size) {
+				print_text(COLOR_ERROR, "too short packet");
+				packet_hexdump(data, size);
+				return;
+			}
+		}
+
+		vnd->evt_func(data, size);
+		return;
+	}
 
+	subevent = *((const uint8_t *) data);
+	vnd = current_vendor_evt(subevent);
 	if (vnd) {
-		const char *str = current_vendor_str();
+		const char *str = current_vendor_evt_str(subevent);
 
 		if (str) {
 			snprintf(vendor_str, sizeof(vendor_str),
@@ -11419,7 +11504,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
-- 
2.25.1

