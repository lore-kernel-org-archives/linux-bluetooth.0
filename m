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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A7CC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9441661132
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 01:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhDOBsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 21:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDOBsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 21:48:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F03C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 18:48:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j7so6363497pgi.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v4o/Fxoqp/bomBeH0damFKo2auptHUeHTyCtUt+Huzc=;
        b=PmhMUNLwaUMvaVTdBYGoqjSJEb2VLeE0O45m7P8cbpXOapvXj309AiJXIo+jYOXZbn
         daARg5WvNUBfDjUIhrj6ZYIf9fELtZivhzUs7DXmErKhWjGMXqxqox15DCFq53OOJUNX
         77nfdXoSYNu5YSWsXEPDosrNmKAcwI/qaY3vb+IMSoMc8MDTVgC685seSGh454nHXYcc
         FtkC53AmemoASlCaBBJmsHWbX6KBGRBCgTJJ1537l+9ZQLBbrt8rErQl3wDVBlbgHyJ/
         bgkUIhZ1gL8zsklNaKMqcCfmRFrh6YhCaZPsIaTPaef47UGbIdDjj7OtLr0FXMgv6KQV
         Jzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4o/Fxoqp/bomBeH0damFKo2auptHUeHTyCtUt+Huzc=;
        b=r1KWCPu17l7QrdXZpelvAtwoSoyIVRWueCFOJevFkOJvagQvSErKL2chf4+KaQ8Dff
         ScP/xMEaJB93mgRwAiSae+iYxuizgDMp+5uvyZfkpEtzwYt3Jko0csmt6ZNRC36pDlit
         ja3RxN/q5B6XsOZ+GNLcyZInZQ+td+NSwXu7pHeghuVXB2yGbVpVWgxsTtSo7WTecT02
         ox3UAzcC0IVHXi98qIz6zHyioTdZnVea4jD5n47i8IutqtIvatT1qfkI65qj5OOs+qWD
         aiz8kyjSgFU/MteId2U+0QJw8aCFU4eQzX4cC3SbCN2MdFjdlV1RHo4jGH6HQIah4UmZ
         fntw==
X-Gm-Message-State: AOAM531BIqMudipQsCkLQ9faIgc2yi/+mFISm1YhN04b5LPa9L89SoTx
        x5cNo9BtLC+w/bdayeFyeCRg3Vo2JhQ=
X-Google-Smtp-Source: ABdhPJxzbHdfYKV6yPB30LKGWkmEwMaxHs6VIk3VMZN4+sRu0ei+qqGCx1K0YAcKHPM9PaCmb9NiKA==
X-Received: by 2002:a05:6a00:1c6d:b029:249:4886:4edb with SMTP id s45-20020a056a001c6db029024948864edbmr825723pfw.66.1618451310328;
        Wed, 14 Apr 2021 18:48:30 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:dc5e:59ef:71c8:3cee])
        by smtp.gmail.com with ESMTPSA id 18sm638374pgn.82.2021.04.14.18.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 18:48:29 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [RFC BlueZ v2] monitor: Fix the incorrect vendor name
Date:   Wed, 14 Apr 2021 18:48:28 -0700
Message-Id: <20210415014828.422303-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Tedd Ho-Jeong An <tedd.an@intel.com>
References: <Tedd Ho-Jeong An <tedd.an@intel.com>
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
 monitor/packet.c | 56 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d729a01cc..30ed9944c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -266,6 +266,7 @@ struct index_data {
 	uint8_t  bdaddr[6];
 	uint16_t manufacturer;
 	uint16_t msft_opcode;
+	uint8_t  msft_evt_code;
 	size_t   frame;
 };
 
@@ -3940,6 +3941,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 			memcpy(index_list[index].bdaddr, ni->bdaddr, 6);
 			index_list[index].manufacturer = fallback_manufacturer;
 			index_list[index].msft_opcode = BT_HCI_CMD_NOP;
+			index_list[index].msft_evt_code = 0x00;
 		}
 
 		addr2str(ni->bdaddr, str);
@@ -4006,9 +4008,11 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				/*
 				 * Intel controllers that support the
 				 * Microsoft vendor extension are using
-				 * 0xFC1E for VsMsftOpCode.
+				 * 0xFC1E for VsMsftOpCode and 0x50 for event
+				 * code.
 				 */
 				index_list[index].msft_opcode = 0xFC1E;
+				index_list[index].msft_evt_code = 0x50;
 				break;
 			case 93:
 				/*
@@ -9323,7 +9327,7 @@ static const char *get_supported_command(int bit)
 	return NULL;
 }
 
-static const char *current_vendor_str(void)
+static const char *current_vendor_str(uint16_t ocf)
 {
 	uint16_t manufacturer, msft_opcode;
 
@@ -9335,7 +9339,35 @@ static const char *current_vendor_str(void)
 		msft_opcode = BT_HCI_CMD_NOP;
 	}
 
-	if (msft_opcode != BT_HCI_CMD_NOP)
+	if (msft_opcode != BT_HCI_CMD_NOP &&
+				cmd_opcode_ocf(msft_opcode) == ocf)
+		return "Microsoft";
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
+static const char *current_vendor_evt_str(uint8_t evt)
+{
+	uint16_t manufacturer, msft_evt_code;
+
+	if (index_current < MAX_INDEX) {
+		manufacturer = index_list[index_current].manufacturer;
+		msft_evt_code = index_list[index_current].msft_evt_code;
+	} else {
+		manufacturer = fallback_manufacturer;
+		msft_evt_code = 0x00;
+	}
+
+	if (msft_evt_code == evt)
 		return "Microsoft";
 
 	switch (manufacturer) {
@@ -9378,18 +9410,18 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 
 static const struct vendor_evt *current_vendor_evt(uint8_t evt)
 {
-	uint16_t manufacturer, msft_opcode;
+	uint16_t manufacturer, msft_evt_code;
 
 	if (index_current < MAX_INDEX) {
 		manufacturer = index_list[index_current].manufacturer;
-		msft_opcode = index_list[index_current].msft_opcode;
+		msft_evt_code = index_list[index_current].msft_evt_code;
 	} else {
 		manufacturer = fallback_manufacturer;
-		msft_opcode = BT_HCI_CMD_NOP;
+		msft_evt_code = 0x00;
 	}
 
-	if (msft_opcode != BT_HCI_CMD_NOP)
-		return NULL;
+	if (msft_evt_code == evt)
+		return msft_vendor_evt();
 
 	switch (manufacturer) {
 	case 2:
@@ -9573,7 +9605,7 @@ static void cmd_complete_evt(const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -9665,7 +9697,7 @@ static void cmd_status_evt(const void *data, uint8_t size)
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
@@ -11018,7 +11050,7 @@ static void vendor_evt(const void *data, uint8_t size)
 	const struct vendor_evt *vnd = current_vendor_evt(subevent);
 
 	if (vnd) {
-		const char *str = current_vendor_str();
+		const char *str = current_vendor_evt_str(subevent);
 
 		if (str) {
 			snprintf(vendor_str, sizeof(vendor_str),
@@ -11419,7 +11451,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 			const struct vendor_ocf *vnd = current_vendor_ocf(ocf);
 
 			if (vnd) {
-				const char *str = current_vendor_str();
+				const char *str = current_vendor_str(ocf);
 
 				if (str) {
 					snprintf(vendor_str, sizeof(vendor_str),
-- 
2.25.1

