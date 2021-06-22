Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0342C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57D36134F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFVBDv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhFVBDu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 21:03:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533D0C061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a127so4540851pfa.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fijeLYxAajiOMQuAFN30hNSlRkp9xloU3BMCsZB7sQs=;
        b=e4dTfHsl+nmjGfAFuXN3OVEF7HtXde/nRK73JQBVUU6PvovzrvN07dXYnjh8YRrhR7
         c/6EdB0WvSPnUjtrckipWUOODZm1cpjYe7oTJ18/zPCdnOUgPav6Nbo2e2bJFEVIeY5P
         I6bunC4ml/EnR7zwI06suBGrKejVXcEfzpRBnmM1Eec0qLs5wCeDysHzvV12iwidB/Ej
         xZNoTZf4q5Bj4D3AYoP442N5mtCY2kBI1zchhdJ3DECwyXROLzbv45VWrPS1BAycSCql
         xdAt2Ado2H1G/QfOA5P9xOSTWWSs4RJ3zWuHKovg646m34jFpRndviGrqhNSYPTEWTIn
         XjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fijeLYxAajiOMQuAFN30hNSlRkp9xloU3BMCsZB7sQs=;
        b=AoFWComZRgNxISHc3sbF3j2iGIGnwYXzapLfCmXXpRJqGDnS3p+GAbHeINXXQ9Xxw6
         4F6CAN8C3w8xIPf25NRDm7qWoDwJDmxyWlcwtbZHLV7F+MwvGD82o9d52aXcXg3TCGXu
         FVxdnyz6aocTD4AlClaN/i0b1zIFzf2Ga3N84OWxjgRsyeBZIMNh+NwvO+MbomMupIrG
         WSD6J2tEJl0Ag9G/1HF+QZbDqqvHMd/ku0QYu6fZuws+mx7NDdoxphHPA4TGAHKj3lJm
         QKp1xyQ80N2yXZkFTfD8MlDX60CvJZQ3rusHSTW1P700Dfc80y1LVN9atarCrLN6/ycA
         CyUQ==
X-Gm-Message-State: AOAM533juPT/M6QeFiUPdENg3SCsRTfaOQISsyx571wygUgo+WM8zQVV
        R8F3n6/WRR0FXIFv7cJL8tq3GLVkZek=
X-Google-Smtp-Source: ABdhPJxj3egqzWm7tbrbuvj3yiK6bxiYWff6cHMJNcBrzTEyOhoahem5DA/SMIuZlTCQ1nsMo9OKeg==
X-Received: by 2002:a63:ff1f:: with SMTP id k31mr1143651pgi.315.1624323694697;
        Mon, 21 Jun 2021 18:01:34 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id f28sm17970120pgb.12.2021.06.21.18.01.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 18:01:34 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/5] emulator/bthost: Create ext adv params before setting adv data
Date:   Mon, 21 Jun 2021 18:01:30 -0700
Message-Id: <20210622010131.427059-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210622010131.427059-1-hj.tedd.an@gmail.com>
References: <20210622010131.427059-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Based on the SPEC 5.2 Vol 4, Part E, Section 7.8.54, the
LE_Set_Extended_Advertising_Data_Command may be issued after an
advertising set identifed by the Advertising_Handle has been created
using the HCI_LE_Set_Extended_Advertising_Parameters command.
---
 emulator/bthost.c | 26 ++++++++++++++++++++------
 emulator/bthost.h |  1 +
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 16934d35a..62f5a1bae 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2549,6 +2549,7 @@ void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 	memset(adv_cp, 0, sizeof(*adv_cp));
 	memset(adv_cp->data, 0, 31);
 
+	adv_cp->handle = 1;
 	adv_cp->operation = 0x03;
 	adv_cp->fragment_preference = 0x01;
 
@@ -2572,20 +2573,33 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
 }
 
-void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
+void bthost_set_ext_adv_params(struct bthost *bthost)
 {
 	struct bt_hci_cmd_le_set_ext_adv_params cp;
-	struct bt_hci_cmd_le_set_ext_adv_enable cp_enable;
 
 	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
 	cp.evt_properties = cpu_to_le16(0x0013);
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 							&cp, sizeof(cp));
+}
+
+void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_ext_adv_enable *cp_enable;
+	struct bt_hci_cmd_ext_adv_set *cp_set;
+	uint8_t cp[6];
+
+	memset(cp, 0, 6);
+
+	cp_enable = (struct bt_hci_cmd_le_set_ext_adv_enable *)cp;
+	cp_set = (struct bt_hci_cmd_ext_adv_set *)(cp + sizeof(*cp_enable));
+
+	cp_enable->enable = enable;
+	cp_enable->num_of_sets = 1;
+	cp_set->handle = 1;
 
-	memset(&cp_enable, 0, sizeof(cp_enable));
-	cp_enable.enable = enable;
-	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &cp_enable,
-					sizeof(cp_enable));
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, cp, 6);
 }
 
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 7e5286df3..5a85b7232 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -80,6 +80,7 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
+void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
-- 
2.26.3

