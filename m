Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05809C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C079A2086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE2s9Fi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfARRCz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38008 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfARRCy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so6606731plb.5;
        Fri, 18 Jan 2019 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZcE0++5u/bnDO9bvoYpUsbiaOU0sb4V9OQ0+PXHgS5E=;
        b=mE2s9Fi4sTMYiU1QXLckdLLFVjTB+qtcWoGKiDN2/mjUnPrMyJ4k64vtBj2rKcUU6O
         In4qg1yIauYZ3u/2jaER+vstVOdaR64r2TQz63tV4b9xq4+0kR1mbsuAHrYt1PpZpXzq
         oga9PX/ZfZSxZJA+a5kXvZmzoIS8wZ3RJv9taxrP8MD0s2iWRIUEHq51q2Lz//kxELtb
         1A6IRRJSJ+rXxq/G1ZsW2VuYUudyvnOJNrs63P6uxAX7xGWcpfk8hBvVoqsSJ4e2LlDX
         1WOem+WVtD1FxWVs4KMe3xsMv6DNVP/T7H/lZ+xu73yMTOvd1rT1S2/qkYcVSK506eFE
         JABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcE0++5u/bnDO9bvoYpUsbiaOU0sb4V9OQ0+PXHgS5E=;
        b=T7XIA8b4PaXFAKTglFL13+jqGMQ/X6abCyHd7nyVcXI03CXNM+3h4v9PNQUZPFOuCe
         SS687Pdj0HvqBCkPPAz1dXhZZ/np2DcQg5bglmdCEfxR6wh0icj55ceX+I9lasQP01j+
         txE82I7JAA2j0bhSIAIVjBTh+dNbXBL3bObp9uqHIlq3SXwlMiSsyVJM3dBIs9tn+kze
         zuQZ7NvLfm+p+jBSEKQbVoTCLFvYEY+GgfjW/V3QaXMhNece9bB3HGdoz9E/CCdVTi9G
         7OjbiNfF6JIyTiAAAP1AwsIyxsjJPMAwOk89ybXD+C54rT2rJFg12Qodtb/5QtykklQV
         7JHg==
X-Gm-Message-State: AJcUukf6qHRcjzy4wj5UT14l4Iya+w+PrQKw5AuwzQTUrTRKTo9khzr2
        4wVrd8UpUgA0mmiyrxwYZSg=
X-Google-Smtp-Source: ALg8bN67v456utGVLWiqi+aDYttYUprlBywzYI0OUggA5xoUZQRpdBWeIlXY8gcLLbH3xV9LWXo1SA==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr20153695plb.182.1547830973155;
        Fri, 18 Jan 2019 09:02:53 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:52 -0800 (PST)
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
Subject: [PATCH 8/8] DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On SoPine baseboard
Date:   Fri, 18 Jan 2019 09:02:32 -0800
Message-Id: <20190118170232.16142-9-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SoPine has optional RTL8723BS WiFi + BT module, BT is connected to UART1
and uses PL4 as BT reset, PL5 as device wake GPIO, PL6 as host wake GPIO
the I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index e6fb9683f213..691ffad390c6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -204,6 +204,20 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-postfix = "pine64";
+	};
+};
+
 &usb_otg {
 	dr_mode = "host";
 	status = "okay";
-- 
2.20.1

