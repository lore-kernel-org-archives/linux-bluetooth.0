Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48473C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2FE20883
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfpt1dQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfARRDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:03:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39235 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfARRCv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so6603705pld.6;
        Fri, 18 Jan 2019 09:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LgNmpUZNbudKQwbqSkrJvpGuDLaSJyahqxMxDXFKylA=;
        b=Pfpt1dQmBQJXMUNgR53emDaiSe047LELt436/GfMUtpuisKukbtTQH0u1w9sEXiywv
         Eep+vI+gVslOyzUUTP6WvwKlfgxcq0zxrTCy5CTP4d27qwoOeoVkZm+Nwpl6ufadeC5I
         VhZohwAFYa1CmsXT4ExcPCwq2ABdLO9Rv5k4uVTtOAxgz3AKy5hRWQ7Ztje51urxC0PW
         dCeTRbjOv3u/nkWlleEwyRK3yaVoV6q1NN8L1aSSpeLd3I2XkpWBhpK1WOk5GNMtTTeu
         KoBlk9mQ5+rhRzDmugWmy9f+u2fVCj4GppqeS3o3nO3/CNiSTp1LvivS98FffuU8O1dN
         m2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgNmpUZNbudKQwbqSkrJvpGuDLaSJyahqxMxDXFKylA=;
        b=t7sTG4FM9uwfSLsql/xh/Mx3R/TERSl+QIz1UGdkQBza6o1k8cBMR3/hgEKu/7t5Jj
         8ye8bFxg+nmTzrsEHOLGSlHNhtZ7RjNK1t4iLikJl4eK/7mzNBJWVodKHvc90jH0sJ28
         nqyj9fj+Gu5jTIqGJ2I5BayhfsYk1lEUOAVHDLwu72Spl368DPvFEQuYW+3I1HTiYZ4w
         UcFmhtmoK4zEWUqVg8vw7UTIPv5tr3S3gl0Qi6ghS6Z3n/P0gGGD5yIbNenatLHtRK/U
         gQcS7+EaJ65bFA+/y4R4Speh76+iWluwRrd2pLLCYEcOt6vXfcCMkO2ekCO4syTy8BuV
         vLqg==
X-Gm-Message-State: AJcUukeAtkVtAcMEOtbv233aAAlDhIFR4Uhh6CofFBcYk9HQl68ni25z
        +IA1Jba3AwFo9Jw2UptI/MY=
X-Google-Smtp-Source: ALg8bN6kUKgnGRWhF24o8hn5zCzZpIYRKHBoqNOOBq2Gs5dDMB3b/y5oa634RNCtCF32/+SpyIfI3A==
X-Received: by 2002:a17:902:e012:: with SMTP id ca18mr19815227plb.218.1547830970874;
        Fri, 18 Jan 2019 09:02:50 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:50 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] arm64: allwinner: a64: enable Bluetooth On Pinebook
Date:   Fri, 18 Jan 2019 09:02:30 -0800
Message-Id: <20190118170232.16142-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pinebook has an RTL8723CS WiFi + BT chip, BT is connected to UART1
and uses PL4 as BT reset, PL5 as device wake GPIO, PL6 as host wake GPIO
the I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index d22736a62481..8fc55dfa7034 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -340,6 +340,20 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723cs-bt";
+		reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-postfix = "pinebook";
+	};
+};
+
 &usb_otg {
 	dr_mode = "host";
 };
-- 
2.20.1

