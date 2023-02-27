Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD848C7EE30
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjB0Qah (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjB0Qaf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 11:30:35 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914119009;
        Mon, 27 Feb 2023 08:30:34 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bi17so5647495oib.3;
        Mon, 27 Feb 2023 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=AB8LeUkTcrQRY85Hb0/W61RuKo2xweA6HreDGbedIZ4lpMLzlWTSUF/xrbrAt7n79W
         sqCwrYZXQtMCCDb02px/hr93KRyMc8K6ZUqcrguPZP3gMR72LJQY5aAe3DenFAUkS3S6
         fnWI5wTCTi3h0HpuW5p1qlS3cCaO4GfWPIMgPo2s7nZ7OrE8otKGPCizqNyGCUcSAVrL
         zzt5BqTuGkbW1ZcGkJpM2lIH+0WYGzSPRyJNoxq6DJ5NDBh8JmqqPKxGBXd+XIQMWRhd
         NKN+JM0R82VVfdKjYF+UPulpevgsxwsydQlJ40rME2LUxmugStUN6xoREo//mf/rtTOK
         Nxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=1m61XXNTdpWQGw6p9drVfpnCdajEN5be3huciyAc1cLAudpzuapRx8MB5nDwmN+WdO
         a8pXCkuUPHZdCb15qxf/RWwK/m6kFngEMbU9gXv/FQ72EX5yaN0uetpp6kOzsIv+U/vd
         CedRtTDUZuSW36edaJybMg6PoPhMFwQ5gilkXnN824TCJA5utMBlCxS5Hk6ht5T3KQFq
         OgulAXMaL0nx5myUcnR7AgYA3UB6wP5TCaljyAoX3yH0tCD5g7/MCSKXva4wS2S5s69l
         51ebyYTRj5RqF+OR8yJ3trpyTPNHzYg9yiyXeNY1vga/4UB9K2L8c4cD37w2P9+jJ9vJ
         lnkg==
X-Gm-Message-State: AO0yUKWWjrxRS8ZV9k/rmH0wSLCZ1UAuA+qA3L9KAU1t0tACJopsT/9S
        rMdi/Wz20Nwxy88gw4c3FuhJtTnT1+c=
X-Google-Smtp-Source: AK7set/bPQ3QZ2GzK9RQge0qhmbwGja53OKibb/98SsVY4DXh7x+yc6pKG4M6zYmVub6rgvZ98FZsg==
X-Received: by 2002:a54:4005:0:b0:384:3eef:77f5 with SMTP id x5-20020a544005000000b003843eef77f5mr682758oie.49.1677515433836;
        Mon, 27 Feb 2023 08:30:33 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm3267713oib.13.2023.02.27.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:30:33 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/3 V3] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
Date:   Mon, 27 Feb 2023 10:30:26 -0600
Message-Id: <20230227163027.130292-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227163027.130292-1-macroalpha82@gmail.com>
References: <20230227163027.130292-1-macroalpha82@gmail.com>
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

