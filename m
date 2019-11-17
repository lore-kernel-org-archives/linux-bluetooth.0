Return-Path: <SRS0=tHDW=ZJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA2C432C3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Nov 2019 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95B2084C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Nov 2019 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpFVHO2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfKQR43 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:56:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45008 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfKQR42 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Nov 2019 12:56:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so16769257wrs.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Nov 2019 09:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xrlHyn/zKHye+GAnh7De8qb9y10xddfAIfezFOlqYo=;
        b=PpFVHO2OzcW+yW+E90oxLBuFpIw+nu3TOOdkf1Xe2dnqWz3iZbrHdLXwphAwrb2ekm
         5fpyjk81zVFkW/VG5LtZ1e4Io1WjnSN3ibXw15+TVZAIj3c2CrsNf4FFLu0vFzpzC0hs
         mPagAINrysa7uVt4IbFKUy5/WJ+DSGvfrE4B1h6suSayHS3ekEQFaSS7TaXyDRCDd0+q
         18RprW5WFCaMoKIl3ovvlgc8TPcFGG6hX0jF9Sr0dGkvqEgx86Y4W1u4jIsZ7Jqp8cxv
         HwBSYHFckP+fFOuMlBfzVyrwdHk55yDKahXcfEC96x9Cp91j+yPrN+ohYEIOSblrCGPB
         jE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xrlHyn/zKHye+GAnh7De8qb9y10xddfAIfezFOlqYo=;
        b=HY55fGHk9P4s3SDMr8bejDBwLxXRl628KUeWPrgfZSyhOxafWRDqhkBm+UoVwIjW7d
         VoNlhzYOIc4/DCdfUmdhNY8MsXggy063DAHdlWRlOjzR/4zIYY4t73n97CIGXm/j7/4G
         R3H6z+gLl4NMpRR5vuNpCKi1t0CbkCIZxzRAGmrl8fAwLkR21Ss/9vkuIhmfuO36xX/g
         WkP6kfBKIE7AnoVY/5KEy+jduOXQI07gwSkH1wIyNFWNQAw4HgfeAoZWBCdlpKLun6Ek
         9WosUaqi6P07ICbdH5iShBOItO/+IY+QxunD+YK4KWoOYaBE4EjmfzaH09B+RvzCDhh6
         YDBg==
X-Gm-Message-State: APjAAAVj3Y7u1v5oeQlNi0Rqmld3gB65kq1PYbETmY6lLFIcNE9OzO1L
        5FbLsLgkdSjI9xdrF+e3uJU=
X-Google-Smtp-Source: APXvYqx8QHWUHIGY40LTa8n0gtDc2T+YB+/sFkE0wXCESE6N5Descd+yIcErtU/ukNX9O3OGVsOtiA==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr24866517wrq.352.1574013386499;
        Sun, 17 Nov 2019 09:56:26 -0800 (PST)
Received: from localhost ([37.238.189.25])
        by smtp.gmail.com with ESMTPSA id t185sm19395198wmf.45.2019.11.17.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 09:56:26 -0800 (PST)
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
To:     linux-amlogic@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Mohammad Rasim <mohammad.rasim96@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH 4/4] Bluetooth: btbcm: Add entry for BCM4335A0 UART bluetooth
Date:   Sun, 17 Nov 2019 20:56:06 +0300
Message-Id: <20191117175606.5050-5-mohammad.rasim96@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191117175606.5050-1-mohammad.rasim96@gmail.com>
References: <20191117175606.5050-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the device ID for the BCM4335A0 module (part of the AMPAK AP6335 WIFI/Bluetooth combo)

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
2.23.0

