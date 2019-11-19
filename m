Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7572C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 19:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9106C223B0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It1oHMG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSTqu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:46:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSTqu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 14:46:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so12546664wrw.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2019 11:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUeJQy60Ws4vwGxiaFjACtSjG8oIrIuzPKifgrc5ops=;
        b=It1oHMG2OfngIKRNudtt4wJf/25BpMMuIFm6qnbChTAO5c6Pen+P28bJ4TXubD1k0D
         LPoPEzNtom2aPymloDHKhmqqjp/KU/fgsnTe5lR6eDgOg9iBAwQWAFX9/b7MqnuFhcir
         G/ggdKNRGtth5vHu8TIFYhsyxtWW2Qocx/OpKwBxjKNMtEpWyBgoTdRhviLPy81omzHp
         HEkdPgjf1aEBN6dxAfC6GCtRrigVhgCkIAEfJevNtsOy4FvJNTtalFfa/YbF6vwfjp87
         +8vIQN9mqShe4WcJdFgcfmJzcsWsuYumUlyUceVFsAQQmzae1i1w/uL9qv0DIjtMMPIw
         QkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUeJQy60Ws4vwGxiaFjACtSjG8oIrIuzPKifgrc5ops=;
        b=G2cF4wckQX83RvE1Pz+F3TpCy4Du0nH/QphOx4f+tBgusQJnt8EXIT0RlwxESk+QYe
         q4Vn1q4bDYHPq05uGfSrH3uYbbpWTnK05BbNH+qae3apHvQZE6qLKVtyYlpoqF1v4t7R
         9D4DPGldO4ufWNceMghTZcZjxHbCd0xXzFViMka6p50Z/Qx3xZPs4Imci9dsI70Wj1AN
         68WfORrwGiWQub6sPnkXLNnL8GKgawFJHQkj7ZHasUiwH0/A9wo9z+C5AnTnUzxlXIlG
         87qjmJaAX3duaPHgGeGX9ko+DVAoxr1jELCoxI0Dlrpl6KchGTe1RbipxMDzkkGw98Tm
         M16w==
X-Gm-Message-State: APjAAAURP4vmn4CcrH6cn6hAZ1XFGGf9XgfGkU65IeMXwZTQdTBgv9m2
        oOKfpKrSnZ7A9XuouOIn921Wtd393mo=
X-Google-Smtp-Source: APXvYqxIVa+09OgDtJa0H/xpjaiDrE2LVpvr0j6sc5lkNQvhk8QJK2SVV/72PXtY26/i8porzm4m2g==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr38638560wrc.315.1574192807454;
        Tue, 19 Nov 2019 11:46:47 -0800 (PST)
Received: from localhost ([37.238.189.2])
        by smtp.gmail.com with ESMTPSA id y16sm28278954wro.25.2019.11.19.11.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 11:46:46 -0800 (PST)
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH 2/2] Bluetooth: btbcm: Add entry for BCM4335A0 UART bluetooth
Date:   Tue, 19 Nov 2019 22:46:38 +0300
Message-Id: <20191119194638.4967-3-mohammad.rasim96@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119194638.4967-1-mohammad.rasim96@gmail.com>
References: <20191119194638.4967-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the device ID for the BCM4335A0 module
(part of the AMPAK AP6335 WIFI/Bluetooth combo)

hciconfig output:
```
hci1:   Type: Primary  Bus: UART
        BD Address: 43:35:B0:07:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING
        RX bytes:5079 acl:0 sco:0 events:567 errors:0
        TX bytes:69065 acl:0 sco:0 commands:567 errors:0
        Features: 0xbf 0xfe 0xcf 0xff 0xdf 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: SLAVE ACCEPT
        Name: 'alarm'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Version: 4.0 (0x6)  Revision: 0x161
        LMP Version: 4.0 (0x6)  Subversion: 0x4106
        Manufacturer: Broadcom Corporation (15)
```

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
---
 drivers/bluetooth/btbcm.c   | 1 +
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..22464bf8cda3 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -339,6 +339,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
 	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
+	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7646636f2d18..7eba10b0ae6c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1422,6 +1422,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
+	{ .compatible = "brcm,bcm4335a0" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.24.0

