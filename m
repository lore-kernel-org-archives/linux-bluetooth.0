Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE58C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6A21855
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni/H1V2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfAWRpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:45:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWRpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 12:45:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so3510264wrw.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=WA0vSoKFnfldAEmjpIP0AQNYI2AVT8BXOwoRVWj+3PM=;
        b=Ni/H1V2tWuliGNfWl2WWAJ0saeyBLY/tECo6mvrW87tBtgSt4lFm3pK/9Qy3JyQISG
         f8dwHB1tY5NvYwe1CwD7C+Bv7i2cLxq8Ac52Heqly4bed1vPPwuoXAEemGEK/zG/aVZR
         8BsFjF+I2qE32Gn5of7nRKoSQeV6nSSv/c8b45W4E+GwxlcZNCny3ffGtLIG9R+sxvr+
         kMQpnEweqmA6p5usDqxIaOiheZQOFPdxXChfpXiFnwTX6qCgJ+fWmJmjiva3T6wZMPDa
         xblW5G03IEMQeW5QabH9OcAxkJRT9YECDluVib3qCeaenafgjGs2RJWQtUdeBKfyD2dA
         t4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=WA0vSoKFnfldAEmjpIP0AQNYI2AVT8BXOwoRVWj+3PM=;
        b=ND+9IIIDVgcxeaZaQVh2B2A3JaubVpwnTck1CgTVRVAou63+wlq6jyN5BJng6JYEw3
         icjZFyix9qMGaFcBrRxN01GK9QGXKNfRSMH3e/aN5M6tbKBODHXOPKLdXmFz1JlO/8tC
         6STKVyuCllXP2mwIHgrSex3S/lxDxm+Mx+2ce4Gk8C7ruN7RmtnPI/GKw0DqmmAgjxvw
         qefRC5f3xpHugu3X5OO2dsiO4/6R2yBRzvl67eYvda1l5tHnXwfpD1BQI7WWGiDMuYJT
         F0yxgFKbVy9GCC6nrdXfPuLu2taE2q5am0VXpi5cyzLnia2c0jbmT/dllq+pKAmZSLAV
         F/Ag==
X-Gm-Message-State: AJcUukejbyEtWHRhkc5CPir5EELVwPOZuehaUzcICN8kAEcxdkCW921n
        ONty3rPaqntyjOPJX5eto2r9sBIZ
X-Google-Smtp-Source: ALg8bN4py4VwQ+K/mdUs880A5HeAMzx0/wO4DBiT2T3QdpeR9c2By9Rr3QJoyFRrs4iBkggj2Y+AYQ==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr3557201wrq.108.1548265513994;
        Wed, 23 Jan 2019 09:45:13 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id 3sm72192721wmw.46.2019.01.23.09.45.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:45:12 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX HD and LDAC
Date:   Wed, 23 Jan 2019 18:45:04 +0100
Message-Id: <20190123174504.12350-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index 18569c895..a21410f5a 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
 {
 	if (vendor == 0x0000004f && vndcodec == 0x0001)
 		return "aptX";
+	else if (vendor == 0x0000000a && vndcodec == 0x0001)
+		return "FastStream";
+	else if (vendor == 0x0000000a && vndcodec == 0x0002)
+		return "aptX Low Latency";
+	else if (vendor == 0x000000d7 && vndcodec == 0x0024)
+		return "aptX HD";
 	else if (vendor == 0x0000012d && vndcodec == 0x00aa)
 		return "LDAC";
 	return "Unknown";
@@ -403,8 +409,10 @@ static void capabilities(int level, struct frame *frm)
 				printf("%s\n", tmp & 0x80 ? "VBR" : "");
 				break;
 			case 255:
-				if (vendor == 0x0000004f &&
-							vndcodec == 0x0001) {
+				if ((vendor == 0x0000004f && vndcodec == 0x0001) ||
+				    (vendor == 0x0000000a && vndcodec == 0x0002) ||
+				    (vendor == 0x000000d7 && vndcodec == 0x0024)) {
+					/* aptX, aptX Low Latency, aptX HD */
 					tmp = p_get_u8(frm);
 					p_indent(level + 1, frm);
 					if (tmp & 0x80)
@@ -422,7 +430,51 @@ static void capabilities(int level, struct frame *frm)
 					if (tmp & 0x01)
 						printf("Mono ");
 					printf("\n");
-					break;
+				} else if (vendor == 0x0000000a && vndcodec == 0x0001) {
+					/* FastStream */
+					tmp = p_get_u8(frm);
+					freq = p_get_u8(frm);
+					if (tmp & 0x1) {
+						p_indent(level + 1, frm);
+						printf("Sink ");
+						if (freq & 0x2)
+							printf("44.1kHz ");
+						if (freq & 0x1)
+							printf("48kHz ");
+						printf("\n");
+					}
+					if (tmp & 0x2) {
+						p_indent(level + 1, frm);
+						printf("Source ");
+						if (freq & 0x20)
+							printf("16kHz ");
+						printf("\n");
+					}
+				} else if (vendor == 0x0000012d && vndcodec == 0x00aa) {
+					/* LDAC */
+					tmp = p_get_u8(frm);
+					p_indent(level + 1, frm);
+					if (tmp & 0x20)
+						printf("44.1kHz ");
+					if (tmp & 0x10)
+						printf("48kHz ");
+					if (tmp & 0x08)
+						printf("88.2kHz ");
+					if (tmp & 0x04)
+						printf("96kHz ");
+					if (tmp & 0x02)
+						printf("176.4kHz ");
+					if (tmp & 0x01)
+						printf("192kHz ");
+					printf("\n");
+					p_indent(level + 1, frm);
+					if (tmp & 0x01)
+						printf("Stereo ");
+					if (tmp & 0x02)
+						printf("Dual ");
+					if (tmp & 0x04)
+						printf("Mono ");
+					printf("\n");
 				} else {
 					hex_dump(level + 1, frm, len - 8);
 					frm->ptr += (len - 8);
-- 
2.11.0

