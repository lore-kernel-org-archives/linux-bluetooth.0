Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF485C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 16:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAZQzl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjAZQzi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 11:55:38 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A988CA28;
        Thu, 26 Jan 2023 08:55:37 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b18-20020a056830311200b0068aed2e014fso205226ots.13;
        Thu, 26 Jan 2023 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYum9q+uVIbOHOyhER0PhfzXPuRj2vYitiXxSbjrvH8=;
        b=CBNU86PAL6R6hfHSOKwzcIew5pLx591BkPo4VEKAd1Uli/gTZOgU1YjmLusHvBdSBp
         ALo41EqZ+htUwEHghn1tLgG94tWUm0zGppE4L7J4N4KfPFevDj8yFUN4D+HHqeDPgNrO
         2fT825SXxPRgezQQKHLh6PVVo2ozBFGb8oTKzhWlQ3WLJ/GVo85SRFcKs3VcDU50IHKh
         9vu1sNuTogqu3XTuAMqXzFprK3eMI9BQotd2oZ3aWvitKqlyqECnrtlxVodIe07gGa7b
         dX0c4PSuZEmUjT3YHKPLn+75+u7AyiZVjUGxccwwor9+kftVxw377NHTEqJntxtmVDFN
         3IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYum9q+uVIbOHOyhER0PhfzXPuRj2vYitiXxSbjrvH8=;
        b=MaNyvqtSHUopUyI4uozktrNwXvf/om/0pVmmgR5p0DD0UjzZNo/lvIEM4q7rt59i7L
         bcUYNTBIKwQRywalRsZqkxtgTgPsWcbwJwQqn0K5YglKpCq0hsEgmGgOBGYIMEmJ9NG/
         WMNNXS6IPMJZqCOdeqRf/vuePFHtlbyLwQa1tuneuJ8rcJKpNVF2bEMxRTA+S+puCM1I
         HMu9Kh6QLsTziIEmvUOvOx5QrMwcLU6x1dg3DTV4MlSmDoE+x13T1JqymMbp1AxngKgf
         lXjOpyKOQIrTUxWoxnQ9d/qRwmPHmRzX6a4e1m2Y7klB5rAr3JD7QGgG8zLDTSbYSBqz
         kF0Q==
X-Gm-Message-State: AFqh2kpHsWqDfCQJN2zhcdDxMyRHJRno0wbUtYKm3FjIcC4pXtkQ6Iwj
        vhJgPrfFQxmFU6dQ3Ws2sd/PbDRrtAw=
X-Google-Smtp-Source: AMrXdXsZJyNo9ZouJXYPIL0OaHLQDWw9cjty3t/5rOCRrRnJAwgaM/nB0FbIqJ6mgAyC+okQ6Z6VKw==
X-Received: by 2002:a9d:6f05:0:b0:684:a657:3a44 with SMTP id n5-20020a9d6f05000000b00684a6573a44mr18763665otq.16.1674752136381;
        Thu, 26 Jan 2023 08:55:36 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id r10-20020a056830120a00b0066eab2ec808sm694798otp.1.2023.01.26.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:55:36 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devicetree@vger.kernel.org, alistair@alistair23.me,
        anarsoul@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, max.chou@realtek.com, hildawu@realtek.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH RFC 2/2] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
Date:   Thu, 26 Jan 2023 10:55:29 -0600
Message-Id: <20230126165529.1452252-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126165529.1452252-1-macroalpha82@gmail.com>
References: <20230126165529.1452252-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

RTL8821CS is a WiFi + Bluetooth combo chip from Realtek that provides
WiFi A/B/G/N/AC over an SDIO interface and Bluetooth 4.2 over a UART
interface.

Note that the firmware this was tested with was firmware version
0xaa9a4e68 as reported by the driver. Attempts at using other
firmware were unsucessful.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/bluetooth/btrtl.c  | 8 ++++++++
 drivers/bluetooth/hci_h5.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 69c3fe649ca7..c95e55d8d696 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -128,6 +128,14 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
+	/* 8821CS */
+	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8821cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8821cs_config" },
+
 	/* 8761A */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6455bc4fb5bb..9531f092a71a 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1096,6 +1096,8 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 
 static const struct of_device_id rtl_bluetooth_of_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
+	{ .compatible = "realtek,rtl8821cs-bt",
+	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8822cs-bt",
 	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8723bs-bt",
-- 
2.34.1

