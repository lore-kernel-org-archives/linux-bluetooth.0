Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1AFC7EE32
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 23:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBXXYI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBXXYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 18:24:04 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF642ED52;
        Fri, 24 Feb 2023 15:23:47 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1722c48a773so1320972fac.2;
        Fri, 24 Feb 2023 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=jgvBF2hfMIZ0N5yUXWOdlorcPiNIzuUWRsOiPxYXlQy8aG+xFTqs+9zivEXSBx2d5p
         YS+0QT7FG+tWlpR3O59uhR9cz5VDAknOm6/x3Rxp1DClido4JghwtoyKIxXfHiKw3BAH
         OWg9Y+l3y5z6KTQfTPj1jd+NyPxamUzBeiPgl549xUXm/FU9H27cDEOC5v8mAh+IK+qT
         zg9RQPqup6HJFgCluvHEpn7Lf1m8x6fJw2rguE1e86dvFF3vHQiBFgSrri3ddjetl7dU
         ubLHNsf3XEeZcwqV4MHiatNZLcVc/Z4S13AFhdBAZUAKrhd1JrnYRM+u0716tINddHEa
         EDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi5SJcEKPHpeQOw0+UlGmmDXXROx+75oT2f8FTNnNag=;
        b=WikQimZW6K4sZGQmz5sClqLgw5cMWWu+bx9By9AWjZTt9FK0f1bJdv97RVkKup5hrE
         oAIwmYFppfPCT5KhhMZJN05QCtrv+dfpnnaCeSNPWyHvb0PZQ6aOm30G2qNv3Zq1zno7
         5lN9/lGzWIh1cLrX19Qn7kIVBf9sSWb6cbdbQz9iwBQAERuDCti8EyKM/9PniGv9mfGd
         IpAcChy/kWYIYL8k9wXTzqXIToCqDbsEpHl0Z9BPmuxuQA9HHOzcDJUvy/ELR9IAiSX3
         HmfJCspHAs9BYl8QPdRJ5C2F0ocO7pA4x7tclwph//msIZrTiBLTvUFFXenRUiTs+odW
         FqaQ==
X-Gm-Message-State: AO0yUKV5n4AIssBHBKT9oCIo8aARU7uTX9X3iU6qbAxhrf4YQ0MCSo5x
        qQwYxBqQVV7ZYrPrtybG0zhrtP+isGk=
X-Google-Smtp-Source: AK7set+zka4pq8KQXGjVN1FASvAvHq0OCmxDjCs6BbiXJ/sRS9u4YynA9aCd4kkTI1sVbq15KIMgJQ==
X-Received: by 2002:a05:6870:d1ca:b0:172:80f4:9887 with SMTP id b10-20020a056870d1ca00b0017280f49887mr5493008oac.31.1677281026960;
        Fri, 24 Feb 2023 15:23:46 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870d39600b0016b0369f08fsm119706oag.15.2023.02.24.15.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:23:46 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/3 V2] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
Date:   Fri, 24 Feb 2023 17:23:38 -0600
Message-Id: <20230224232339.124969-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224232339.124969-1-macroalpha82@gmail.com>
References: <20230224232339.124969-1-macroalpha82@gmail.com>
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

