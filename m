Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03857C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A270A64E7C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhBILp1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhBILnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 06:43:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3923C061793
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 03:41:04 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b9so30632467ejy.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 03:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cdv5f6UoHhgwKec8Q4SJz4p8zdgsIs89uRQs3/y4BH4=;
        b=O8II6ADwamTAmlGXGlGuyPlFYNossPTeUz+BysyJc5TnJOQy/pqgrSU3vy+f7TFDyR
         oRw+EsU3bT4hSREx4BklnfntxC9T8S+A/9QpCyg+chHetb/uMbW7MW6WyDGeiqAP6mF0
         A5vdwnGOy01NhUbOehwWdyE7ZVz9KkyheAimSI3PsSNHtRHlZqzilaLT5D2rtwlKbUNf
         z/4hdiUSI94oyBEQoe2fbAzk/1tiNyIRVHLLtXtHAMOc5hCshOOB9P+e5hGGtL0suCbV
         Hl1Clob3s1oWLtQvvcKiY+KsvqMihwoTdM2ka5PNsybf3aFs8uhA2XK81IPlB2woXdXX
         9mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cdv5f6UoHhgwKec8Q4SJz4p8zdgsIs89uRQs3/y4BH4=;
        b=tZFPOBIr0aDZp3AvO9Dkpeqw5K/lKUUE7CgUk3gVNxwTIv/w7gNOXTWBrcwFMIynPR
         OOzKc7SItzaE4NI2hXPBw1rJ1AxCDiU26GubjXZXgKQGeH/W0m0Beey25aju1reE877z
         4hRbFoLE2AS2Pcuj68s/Fj2btHrJQDDIeQNcmIsWTleYLdFQ63zkpsdpcEyik7aUGcN7
         3qxSQGkEtz27XvdqnB9NrzKIZATV1X3Q8ZgALeT7BFzW7NTtAQTotMgw7epFWKshO3t9
         bEedUhEB1acxFq5EumrNOhVC6P211dWxssMRc6RHS1n6pxnFZn9exZTYFECmrcS8pD+z
         aKKw==
X-Gm-Message-State: AOAM530YmR925yBDcQ1oIpSOU13miVfJ2s5n5/O8Rze7Xx2kCmbByryu
        /nv7+R5gXXjtjdOw7wDZVcQ2fKZ+2vmMFQ==
X-Google-Smtp-Source: ABdhPJwTc3I+8Kfi73nys1Ue6uNErVs2+g8ZLVS0g3mgY/77+o6uDyHlFvHU/ScFmLQXOIgpoaU5dQ==
X-Received: by 2002:a17:906:854f:: with SMTP id h15mr21336130ejy.2.1612870863457;
        Tue, 09 Feb 2021 03:41:03 -0800 (PST)
Received: from localhost.localdomain (ipb218f30b.dynamic.kabel-deutschland.de. [178.24.243.11])
        by smtp.gmail.com with ESMTPSA id e16sm5700248eja.85.2021.02.09.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:41:01 -0800 (PST)
From:   Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org
Subject: [PATCH] Bluetooth: btusb: Fallback to 16 bit ROM version lookup
Date:   Tue,  9 Feb 2021 12:40:24 +0100
Message-Id: <20210209114024.2910-2-falbrechtskirchinger@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209114024.2910-1-falbrechtskirchinger@gmail.com>
References: <20210209114024.2910-1-falbrechtskirchinger@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
support") changes ROM version lookup from 16 bit to 32 bit. Previously, the
upper 16 bit of the version number were ignored. This breaks setups, where the
upper 16 bits are non-zero, but are now assumed to be zero.

An example of such a device would be
0cf3:3008 Qualcomm Atheros Communications Bluetooth (AR3011)
with ROM version 0x1020200 and this corresponding entry in the device table:
{ 0x00000200, 28, 4, 16 }, /* Rome 2.0 */

This patch adds a potential second round of lookups that mimics the old
behavior, should no version have been matched by comparing the full 32 bits.
During this second round only the lower 16 bits are compared, but only where
the upper 16 bits are defined zero in the lookup table.

Fixes: b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
support")

Signed-off-by: Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
---
 drivers/bluetooth/btusb.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa91277..d8c4c6474f14 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4054,6 +4054,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	const struct qca_device_info *info = NULL;
 	struct qca_version ver;
 	u32 ver_rom;
+	u16 ver_rom_low;
 	u8 status;
 	int i, err;
 
@@ -4065,8 +4066,22 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	ver_rom = le32_to_cpu(ver.rom_version);
 
 	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
-		if (ver_rom == qca_devices_table[i].rom_version)
+		if (ver_rom == qca_devices_table[i].rom_version) {
 			info = &qca_devices_table[i];
+			break;
+		}
+	}
+	if (!info) {
+		// If we don't find an exact version match, try with
+		// the lower half, but only where the upper half is 0
+		ver_rom_low = ver_rom & 0xffff;
+		for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
+			if (!(qca_devices_table[i].rom_version & 0xffff0000) &&
+			    ver_rom_low == qca_devices_table[i].rom_version) {
+				info = &qca_devices_table[i];
+				break;
+			}
+		}
 	}
 	if (!info) {
 		bt_dev_err(hdev, "don't support firmware rome 0x%x", ver_rom);
-- 
2.30.0

