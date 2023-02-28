Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19E4C7EE39
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 15:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjB1PWP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjB1PWN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 10:22:13 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B530B3A;
        Tue, 28 Feb 2023 07:22:12 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-172b0ba97b0so11256401fac.4;
        Tue, 28 Feb 2023 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=d5w7w27+GAkN37xqVH6ee8uy88MpzzRY30PwJvnMeeg9ZZhCYOoMqeE4FelbkHeUlj
         h+FbOl6jjK+E8rQNKx7XTgFa5bKU8heRCqSbhEdFLtaylBgv7ia0NKWXa3dHaC5dxEqo
         88qzI1HDPT55GcYUT2Kl6kgCB9CTiJgjCyLZ9H6Pe30aZlZQht8+olLhf9uilAKNNQUj
         n5q/gJ9BoSHe8MLg96sh9JRmlZclZ65I45ksKxdByQZp+OiSXZ3EKLOnmzBf+v2r09ez
         xKSH4tNKb9zIHGRIbntSyKAtuk2iNzXQlz8ReyDnTa2K2LnqqOsFo7/8BS8sMJfzgqB/
         HZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=R2DWzkeM4UpiF4Eu9sevftJFNP3426iufCcQR6Jq/vU9UqOVS+AZwM5t9bU1JeURsS
         XM/QHDdvD+HDcUGwyugerXZE2nGgUFDKA0VAZiCpHcWBdqtWbweK9FrdISstdnKEE4Ew
         WNITPGBVn+GqbyZaPSadZQe3qWRv3cL/lPMLqr1hg+1rSy72uNR9yVLUszaHh5Vhb2iG
         g1ytp2MqZr3MZEouEWZCrchvkFXMYvljGR5RnMRWgUqIc1I40NbtKXa149j1a6g4m3BC
         h+nAeGlZGDUBUWKxlHe4flF8NUA3r2cTuT1bZAjU/M9EU3Fxwb8P+75SYGQXJFxhVaGo
         zQ3Q==
X-Gm-Message-State: AO0yUKXpJA5mbBE/C4X+mkrrlwHlhBrE8S7t0pW6ClKWPTs6FvJnta84
        8Rp0ci2Myq23/iOUj5nxTpNOpkMw45s=
X-Google-Smtp-Source: AK7set9rrJt43Ctw7elZnb2Hvde0dLtTQmNKHpPqPDo9gbz3WaMi2Pg/CGJ8oTZUgFDvxB777eL0aA==
X-Received: by 2002:a05:6870:ec8a:b0:16a:2db3:fce3 with SMTP id eo10-20020a056870ec8a00b0016a2db3fce3mr1688775oab.40.1677597731944;
        Tue, 28 Feb 2023 07:22:11 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id yy23-20020a056871259700b0017264f96879sm3318321oab.17.2023.02.28.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:22:11 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/3 V4] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
Date:   Tue, 28 Feb 2023 09:22:04 -0600
Message-Id: <20230228152205.133582-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228152205.133582-1-macroalpha82@gmail.com>
References: <20230228152205.133582-1-macroalpha82@gmail.com>
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

