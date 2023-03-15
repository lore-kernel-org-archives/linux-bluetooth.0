Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B48C7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjCORhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCORhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:37:07 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856ED233F3;
        Wed, 15 Mar 2023 10:37:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so828318oti.13;
        Wed, 15 Mar 2023 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678901825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=qPC4gZYCxPAdomO7x2ePq6XD9csKWTlB7N6G/jLz48l0dY4EJY8cSHrew/nHQHFt40
         WxIAs1WMQ3LsOsd+WLyQ4m1haS+rq0layySkB2ZmI+mAfzdTFLPdkmN7+VJ4TcESvbMt
         VPWTRSzaz8A3/IXPSfMeEq/9RgOjgaW05hiO9P7Us2Lc0r7arNW50xQrHt2uhhCcY0fN
         XvTMsl7KPWZQemToXDQ/5d1mRlUcwsKXkIHbv9Yfq9NUdbSAGe9MStCwuqc1XYXDPVcN
         SdYzo931LEEBV1Z6Ru04Im76Bd6t1dovo/7mhJDZnUEIAMj7PMpZRbomrecoAup09/cF
         RFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=YhjvtguBqH/vob4ILfZ51smzR5O57DfnjK/vNeVS8182325TaXFvPQ8tKRPA1tLoio
         P8rBEIgmiQiwggOoYmyCv2FPg1E2eFKA48+sHomC6AH98ghVNzfC3Y8xhCn2E/WTWDkc
         mD8ImLmN608MK23/qTheoeWms1gr2af2Uc532qG2lAUO07+Xpq+5ovgGyBbPX/Eka3BW
         +fTY6CsgcuXjtqqz/kZaELOiGhYRVp/fB8Q69ZjTycy6yQE2Yb6kfR2fS8XUXmPbStPO
         8OnjkyU/JQoGGCcbRS+CA8mfgnQrbhEXFAEa3W7Dc1Lf4jOryyiHsVj7Hyea1gbPSfFK
         QABA==
X-Gm-Message-State: AO0yUKXde+C0IQhJ58VIcaXMJEIk05uRhTEpcQHkI0ORDgSIWeAibkv5
        4gwn8glHLsY+FWOzDYKZGnxOzdMNq3Q=
X-Google-Smtp-Source: AK7set+sx5nxxFxUnhUxX2uYiMEekshtg15WzBs5KwTRHPbKUletwNKGwb4nm2kN6q4jEk2xLohDmA==
X-Received: by 2002:a9d:19c2:0:b0:694:7e44:d4b1 with SMTP id k60-20020a9d19c2000000b006947e44d4b1mr17560353otk.9.1678901824877;
        Wed, 15 Mar 2023 10:37:04 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d3e17000000b0068abc8e786fsm2562044otd.10.2023.03.15.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:37:04 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/3 V5] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
Date:   Wed, 15 Mar 2023 12:36:56 -0500
Message-Id: <20230315173657.28692-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315173657.28692-1-macroalpha82@gmail.com>
References: <20230315173657.28692-1-macroalpha82@gmail.com>
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
0x75b8f098.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/bluetooth/btrtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 69c3fe649ca7..72947d319fa6 100644
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
-- 
2.34.1

