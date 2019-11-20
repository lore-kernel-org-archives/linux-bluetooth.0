Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BCAC432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 11:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4B42230F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 11:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXv9w2q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKTLCs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:02:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36098 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfKTLCs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 06:02:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so7324934wmd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2019 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raniJMYfoIyetXFqCcX/xH2yHuG8ZQyELBDZ9TlUojc=;
        b=SXv9w2q/i+oLawAIkAeayda3JPGMI/vif0JCn9PkCUB4MbWvO5vXlnqtsKmLNk35YC
         NUB+xy5gPDz2w2yplxuXr4rBuTeDWACbrVlKQYooiV9imb6JWBA6u6hLN9IF5vmyfj4y
         x8T/B3NiISZevNUqASjlXcx0r1n0iPCkYdHw154w7d5qDjCB4icJYodNYMeSAckcnwpK
         3GWUJwhMbj/futK2E1bLhywWJT8FpZAPZQexj2TOEJp8l3r/IJ1imwqDIgEeIO0IDp1g
         kWjxBkll/0yFMBDljw/cxeRCWXFLR2w4Cp9nm1v+ADj1DaxdOTLl7J4wWis0plaMT4SD
         wbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raniJMYfoIyetXFqCcX/xH2yHuG8ZQyELBDZ9TlUojc=;
        b=fdc8Z/Nivl0wvaVY6eiwYpM+UrpdLV7MB0AR90/Bbp/2gpODJ4kSciLxQZVwcdSUiL
         zOPIYjHRUpUOQQ7Hdl8u3Zn7CJvtvuLghZUlGmgGUALGjvp3NQJQ6dLQOTP9IvEcZc5s
         jZGLOQokJogKjWB6kLsSMb/eugS7gJB/QSdpe+NSddL98kxPmgxw3kiVRnXy5fuK9neo
         Y7NGzDGaWglBOnzhB28nxvRprzpw7jDOnkphg7yt1s0Ymik4iyu+qp/Z8SFEUw6hiqoM
         UC+J9g4ysXsj6FOpAE0eLr/K3eDpvCLUMEbJC0BKImWPoAg3QOMH2oPKS5sr53CdmLfV
         q2yQ==
X-Gm-Message-State: APjAAAXM32W9reCcNzBi/NA3omySh/8Brpp5+5T2O5SuKn6htxOSSRSt
        bLAp2lxKpmRKH8l1bEl254HMSVND0gI=
X-Google-Smtp-Source: APXvYqyN5cSRbLFF30uL6zhsIJ3ygU//UCVB+3SOIN9g/KbyD/xEE1fHMTzEXkHR//4GpnQx5AZtmA==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr2545599wml.174.1574247765330;
        Wed, 20 Nov 2019 03:02:45 -0800 (PST)
Received: from localhost ([37.238.189.2])
        by smtp.gmail.com with ESMTPSA id r15sm34592413wrc.5.2019.11.20.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:02:44 -0800 (PST)
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-amlogic@lists.infradead.org
Cc:     Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v2 2/2] Bluetooth: btbcm: Add entry for BCM4335A0 UART bluetooth
Date:   Wed, 20 Nov 2019 14:02:35 +0300
Message-Id: <20191120110235.13987-3-mohammad.rasim96@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120110235.13987-1-mohammad.rasim96@gmail.com>
References: <20191120110235.13987-1-mohammad.rasim96@gmail.com>
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
index 0bb9023ec214..689c7f36fea2 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -342,6 +342,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
 	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
+	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0f851c0dde7f..d2a6a4afdbbb 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1425,6 +1425,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
 	{ .compatible = "brcm,bcm43540-bt" },
+	{ .compatible = "brcm,bcm4335a0" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.17.1

