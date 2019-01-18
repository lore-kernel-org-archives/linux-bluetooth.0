Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D1C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA5B20883
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftqIRO/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfARRC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfARRCx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so6863205pfe.13;
        Fri, 18 Jan 2019 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UMvz14KsDb0PYMBq3+E2kRoJCqEy6k0e06L9ePq+UfA=;
        b=ftqIRO/X/6mzz1he8iRS6VADySG/xrTgENEVo+bxqpOeBDi+0tTPC1II0ZpFXstAu0
         oKvalFBRf6QPyf8UvcB3wIbjDVvQ7Fsrlkbsiv+LBiGdHkbANXaxxVccLVk6NAkPHtvw
         GwEPPSy4Xu++rppn4Q3+B5J4OJ2wAgGwnw8FN0z0IgRYUHWZMCm/5T2HvVUk5cn5RIl4
         kSnwQQ45Pyl8bpFFnvweymF47YaIM/L76reqUY5Y+xDlRrFOGqqkpbYmsI9oSSFjobZy
         J1J88G7Da8e262SKonZpMQq0UsVKXxFe6ZpMlwa5+PwjYa/yN5TW9mF7IQ+74vJ9FK61
         cFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMvz14KsDb0PYMBq3+E2kRoJCqEy6k0e06L9ePq+UfA=;
        b=R1SoHR9G21ykwJeU288V6c8Ktcqg5pWsTT0aQj2TMM2Zn7B4JCaD4rlfgNmYPQ5GGY
         4EFT16OBvGmaGA03J95HziO+HKQInn51KEQu6mHSvUxMmxj+DEepE+AtRdq50dRDhoBI
         4oVIFJlAZWGfh3AFhOjAZhLEn7NFSN/98t0q+4OErefABkWdTr8tH4jziHm37iMtH8Nv
         Wfj1KA+Azf47chmfSTO0rz19Z1mxC0ozOE81FsK0Ra83yoyjmX7mLpKirUBzeb+DF5w1
         KbHYdjtudVlTypOzsL2hswgB6JKO535ygylU1RnsNvwM3Ry2LlQO8aEwtNc34H6xjL4W
         9zCg==
X-Gm-Message-State: AJcUukd7/02qLrxJsKohlK6nPcmy58UFV4ikdL90IB0knmi7OZQwu362
        xULvigl9FcPCy76jsMn/XxQ=
X-Google-Smtp-Source: ALg8bN5hUwzZesH5VdBnEDelmV183k6F7bwp74T/wOB1HhQXIVzVGCHABPyZhMDnuYMTeOOaB2enfQ==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr18696033pgb.26.1547830972161;
        Fri, 18 Jan 2019 09:02:52 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:51 -0800 (PST)
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
Subject: [PATCH 7/8] DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On Pine64
Date:   Fri, 18 Jan 2019 09:02:31 -0800
Message-Id: <20190118170232.16142-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pine64 has optional RTL8723BS WiFi + BT module, BT is connected to UART1
and uses PL4 as BT reset, PL5 as device wake GPIO, PL6 as host wake GPIO
the I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 216f2f5db5ef..4d48aa31d420 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -302,7 +302,15 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
-	status = "disabled";
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-postfix = "pine64";
+	};
 };
 
 /* On Pi-2 connector */
-- 
2.20.1

