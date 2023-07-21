Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3689EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 12:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGUMFf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjGUMFU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 08:05:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA48E3A9D
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:05:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so27189351fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1689941098; x=1690545898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+l+E6WOqPvLovqraD39twbq8sUliN3bDM6u2bR47Zg=;
        b=md+50u6T1mYLLk7/fSuFlsN83lkTCuU9FQMQk5gdKPuIoN8uDkuq7XZKZMQmbxgqmz
         NNRoafMLZcRwoTWm6qHnFfKL3iG9TNl/cmblGnUn8JyIVxuggiTGKEDVm6kVQV+BlMG6
         9cWaFBekAonEj+ij3w5ye4sE9oxPPI3tfUkNyYtChrfiN9aeq28EMc/Axw8AUxZAKhMN
         uzDqobOCorMfHAutZ0pyhrf1GlBJNrwLFDL0y/aRPy7okPIGQElHCeMmgnzbJ4ZUxfN3
         e1IXF4dF5VMCFi6IQ+sXSoY+mMbus609bYSOYuGU6Y6CcGmoLTmsPCSU/FMLmgFddnqI
         XaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941098; x=1690545898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+l+E6WOqPvLovqraD39twbq8sUliN3bDM6u2bR47Zg=;
        b=BEKq1SE+lz/NQ0fR9+XQkv38FjC7sBLBExg+0+wTrtzJuJ7dC6GzISoQXKZIs9M20F
         aRFdEu/S8BsnDGpHf7pOJSqo1A2ki6UK87bmx90QSVrsCAQBpgtQi5cRelxJ38WpwGj1
         ZP+Bm8RjgrBtQ+evK5yuo1l8VeRGZN8cu9kBwKq1zCCLfXkRbKt+9s4dTb+avLf6PV3e
         w2juKAcBkTOnAYVs6mmdk4Wz9LQQku0nn4SaMWft8wrJO3XoyriYV/FXshiM7H29deZA
         LflPft2JLf8nP3yisR53ko700S2djEm41pA2Pm3xusjYBtd8V3wNL9geSq5eD7qixCPs
         9/LQ==
X-Gm-Message-State: ABy/qLYvpRodhvUwNq3EbjTOKdYV+GQ8+r7QE/WqRsbrQdONeMPJK+Hw
        V9d9YNu8L1f675KgSgCKU5VzhUBgdSlya0ejp8Q=
X-Google-Smtp-Source: APBJJlEqap73uioOLFEd45qF5ZStRoLOWpz11y0W4jQqyAJNQYJnYAhMvLKRPGeyF9sUXnPIRrjOlQ==
X-Received: by 2002:a2e:8e95:0:b0:2b6:efcf:1463 with SMTP id z21-20020a2e8e95000000b002b6efcf1463mr1305247ljk.6.1689941098226;
        Fri, 21 Jul 2023 05:04:58 -0700 (PDT)
Received: from rymek.localdomain (217.96.247.89.ipv4.supernova.orange.pl. [217.96.247.89])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e885a000000b002b6de6deb5asm907977ljj.2.2023.07.21.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:04:57 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 4/4] btmon: Make BIG identifier consistent
Date:   Fri, 21 Jul 2023 14:03:20 +0200
Message-Id: <20230721120320.147496-5-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
References: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetooth spec uses BIG Handle as a BIG identifier.
Btmon sometimes use this and sometimes BIG ID.
This patch makes code consistent
---
 monitor/bt.h     | 4 ++--
 monitor/packet.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index ea24a076e..b60263fa0 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2789,7 +2789,7 @@ struct bt_hci_bis_test {
 } __attribute__ ((packed));
 
 struct bt_hci_cmd_le_create_big_test {
-	uint8_t  big_id;
+	uint8_t  big_handle;
 	uint8_t  adv_handle;
 	uint8_t  num_bis;
 	struct bt_hci_bis_test bis[0];
@@ -3676,7 +3676,7 @@ struct bt_hci_evt_le_big_sync_estabilished {
 
 #define BT_HCI_EVT_LE_BIG_SYNC_LOST		0x1e
 struct bt_hci_evt_le_big_sync_lost {
-	uint8_t  big_id;
+	uint8_t  big_handle;
 	uint8_t  reason;
 } __attribute__ ((packed));
 
diff --git a/monitor/packet.c b/monitor/packet.c
index fd1e9e034..f581a8e72 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8811,7 +8811,7 @@ static void le_create_big_cmd_test_cmd(uint16_t index, const void *data,
 {
 	const struct bt_hci_cmd_le_create_big_test *cmd = data;
 
-	print_field("BIG ID: 0x%2.2x", cmd->big_id);
+	print_field("BIG Handle: 0x%2.2x", cmd->big_handle);
 	print_field("Advertising Handle: 0x%2.2x", cmd->adv_handle);
 	print_field("Number of BIS: %u", cmd->num_bis);
 
@@ -11633,7 +11633,7 @@ static void le_big_sync_lost_evt(struct timeval *tv, uint16_t index,
 {
 	const struct bt_hci_evt_le_big_sync_lost *evt = data;
 
-	print_field("BIG ID: 0x%2.2x", evt->big_id);
+	print_field("BIG Handle: 0x%2.2x", evt->big_handle);
 	print_reason(evt->reason);
 }
 
-- 
2.34.1

