Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625EAC4167B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 22:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLVWnm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 17:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiLVWni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 17:43:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59B5F7A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b12so2229825pgj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dhV8egEZU8cWS7ajuLRcKLQDgDZ98wBiHZ4g2Ri8EI=;
        b=Jy8gN1TEgkEd+0gaIZsXCnXzG/okrp3PJ0G8JWSNNECuz8CEe4BOMZpZudYH99bBL5
         H6QIkJppW0n0Xt7lY+f1FSPDaJlLGfKhs3bykUf/wB1SZzUEyynsBDiZBLkL0ME5Ha9U
         FOTvV14nlXups5eOgsjy1E0hTqcRzyOdyNbappFF02lpeONp+//SQoP+WzgQ/Nt8GFIh
         txskIHYRkXtInQ624PdBOVn/yMobXk/Zv5R+he0tncw826CNXjLJpMxTnBa1G5ifx7SO
         bI4faFCGPOEgmJjLrayLWUpmw8d4DnOBFwfkySxCVADt4eifWqrBxtlzasRLA2lckyg8
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dhV8egEZU8cWS7ajuLRcKLQDgDZ98wBiHZ4g2Ri8EI=;
        b=HqHeivKDbGXo9vIMwt7sU+mfVx0ZEApkB4NcXwqDlzFne4a8epPeRjaJ7I6+H4pLNb
         ZaNEgvuRwZiH5FVW6J2U4vzNmF2hGqYREW0HwiWxl2htE9FkwaKvs3q75RiqpL9fGVEM
         nBURc26SAQYDf/QitlPemY0Tj8zjp46zfHDDs0AsgTefgE0uBflR19m7qEEdKPmmy5sp
         /33pV7PnrT49eA98J44CoK2tegeRjt3K/DnPuqJ8a0PpcYHLK2fUgmi4yRj3htoa1Y5d
         qOTtu+r5kADBU3QLFUxG4b9N/mQhGVMcLrPihNKyP7riuez9C8BjkYFLqyG5EKhxrfoj
         SuGA==
X-Gm-Message-State: AFqh2koUJU1jMvpErb/CTNkQeLMLCMECfmkUGsyEmhnDknmdDsx2df0w
        uRIAsrmOZQcKj/4utPafx7oTZMtyfm4PWg==
X-Google-Smtp-Source: AMrXdXtU5vrINMPbN3Xo7cYEsLNjNTmX/epxYhyLBvg1Z6jj82FLRD+2U8G68HMQ4zDhgcXQgVZQww==
X-Received: by 2002:aa7:85d4:0:b0:578:8864:7b24 with SMTP id z20-20020aa785d4000000b0057888647b24mr7828601pfn.12.1671749016695;
        Thu, 22 Dec 2022 14:43:36 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79d86000000b0056bbeaa82b9sm1187546pfq.113.2022.12.22.14.43.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:43:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] monitor: Add support for decoding RSI
Date:   Thu, 22 Dec 2022 14:43:29 -0800
Message-Id: <20221222224329.685837-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221222224329.685837-1-luiz.dentz@gmail.com>
References: <20221222224329.685837-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding Resolvable Set Identifier[1] advertising
type (0x2e) according to CIS[2] spec:

        Resolvable Set Identifier: 46-BB-DB-26-D8-55
          Hash: 0x26d855
          Random: 0x46bbdb

[1] https://www.bluetooth.com/specifications/assigned-numbers/
[2] https://www.bluetooth.com/specifications/csis-1-0-1/
---
 monitor/packet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 134cf398a66f..44f1941bd30c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3123,6 +3123,7 @@ static void print_fec(uint8_t fec)
 #define BT_EIR_MESH_PROV		0x29
 #define BT_EIR_MESH_DATA		0x2a
 #define BT_EIR_MESH_BEACON		0x2b
+#define BT_EIR_CSIP_RSI			0x2e
 #define BT_EIR_3D_INFO_DATA		0x3d
 #define BT_EIR_MANUFACTURER_DATA	0xff
 
@@ -4017,6 +4018,14 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_mesh_beacon(data, data_len);
 			break;
 
+		case BT_EIR_CSIP_RSI:
+			if (data_len < 6)
+				break;
+			print_addr("Resolvable Set Identifier", data, 0xff);
+			print_field("  Hash: 0x%6x", get_le24(data));
+			print_field("  Random: 0x%6x", get_le24(data + 3));
+			break;
+
 		case BT_EIR_MANUFACTURER_DATA:
 			if (data_len < 2)
 				break;
-- 
2.37.3

