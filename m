Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C62AC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 May 2023 07:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjENHsN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 May 2023 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjENHsL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 May 2023 03:48:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F562112
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 00:48:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aafa41116fso78700555ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 00:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684050484; x=1686642484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NnQY8noj1MmR/ModEB4va/hdB07OBevUq7UGZR96Es=;
        b=aod5o48Q1jn62cAjOkvTdvoY//WwVUxfug/sweWLvAK6jZioFwohpqM4nw4MfakmPr
         mIrNiQ6murJlHEkO5vbNtMJcJHt3G9u7pPvqIVV6fCw8TSn0VaE7RkUL9cyu1oJqNRFf
         KzHmYF8j48Oy1wxczJ4k3quxgKvmoRhesw0Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684050484; x=1686642484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NnQY8noj1MmR/ModEB4va/hdB07OBevUq7UGZR96Es=;
        b=DzSSydgTs+KA6NQRbF9DvsmuDViTO2Nv9oi2if2YP0AcAA9uerY3DfvwHVTej8xYwb
         PMANr5a1VPdAarXK4U3yNGYLbwyEiVZpIFhiBUAsN3jKs42ATiKl+xE1PP7vgeI9WLwu
         wCbz9jcm4DfiXfcP2jbQssgnaa380bjRyZo04486bmdUqqNafm6ie8K6Zp9HkJN5j9pz
         saww0X6ZOIrcReb/xKmLN/g5maL3HcDuSey4yzvoSZj0IBAAS5ocj2AfXBcKgvqLik32
         77EB3vOUrft7GLTz/S007ceuX1o8aBQxc1s4pWA3M+1ojvrlo7lSWRvngERoPZXIaXC4
         R2RQ==
X-Gm-Message-State: AC+VfDxtbZzJd6ck/B78oiLpZbA13KwOScrGGCsOTQ+LSaK/65Z6CFUY
        7Up5YuytOeODDe+FKYDgT2d5TA==
X-Google-Smtp-Source: ACHHUZ6Hy/3ldJ/A7WBa+micL+eupJ48zrwm9GfokwyqfxTZ3YFGS6iY6weBheTF0G9Sv5PtCwFFGw==
X-Received: by 2002:a17:902:6ac3:b0:1ac:93ba:a5ec with SMTP id i3-20020a1709026ac300b001ac93baa5ecmr17497603plt.52.1684050483745;
        Sun, 14 May 2023 00:48:03 -0700 (PDT)
Received: from 8add390ca20e.heitbaum.com ([122.199.31.3])
        by smtp.googlemail.com with ESMTPSA id j4-20020a17090276c400b00194caf3e975sm10903363plt.208.2023.05.14.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 00:48:03 -0700 (PDT)
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH 2/3] Bluetooth: btrtl: Add support for RTL8822BS UART
Date:   Sun, 14 May 2023 07:47:30 +0000
Message-Id: <20230514074731.70614-3-rudi@heitbaum.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230514074731.70614-1-rudi@heitbaum.com>
References: <20230514074731.70614-1-rudi@heitbaum.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a RTL8822BS UART with hci_ver = 0x07. This is similar to RTL8822CS
observed on the Tanix TX6 Android set-top box. But the previous
generation of chip. The RTL8822BS requires the
BROKEN_LOCAL_EXT_FEATURES_PAGE_2 quirk.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/bluetooth/btrtl.c  | 12 +++++++++++-
 drivers/bluetooth/hci_h5.c |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 2915c82d719d..b53a4ef88550 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -234,7 +234,15 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cu_config" },
 
-	/* 8822B */
+	/* 8822BS with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb, 0x7, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8822bs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822bs_config" },
+
+	/* 8822BU with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb, 0x7, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
@@ -1182,6 +1190,8 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 
 		hci_set_aosp_capable(hdev);
 		break;
+	case CHIP_ID_8822B:
+		set_bit(HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2, &hdev->quirks);
 	default:
 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
 		rtl_dev_dbg(hdev, "WBS supported not enabled.");
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fefc37b98b4a..726b6c7e28b8 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1072,6 +1072,10 @@ static struct h5_vnd rtl_vnd = {
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
 
+static const struct h5_device_data h5_data_rtl8822bs = {
+	.vnd = &rtl_vnd,
+};
+
 static const struct h5_device_data h5_data_rtl8822cs = {
 	.vnd = &rtl_vnd,
 };
@@ -1100,6 +1104,8 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 
 static const struct of_device_id rtl_bluetooth_of_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
+	{ .compatible = "realtek,rtl8822bs-bt",
+	  .data = (const void *)&h5_data_rtl8822bs },
 	{ .compatible = "realtek,rtl8822cs-bt",
 	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8723bs-bt",
-- 
2.25.1

