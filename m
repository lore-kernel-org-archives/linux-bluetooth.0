Return-Path: <SRS0=Tmar=O6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09DC43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Dec 2018 01:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD0021907
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Dec 2018 01:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545355086;
	bh=DDHMCH+ea5TZgKtmOPy2JuZ2jQU/ODVXu7U6wawHuNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QpWRp1qdxM/7gxpyyE62DBmfXHuW7s2huAXh1C5NJVdXrRg3xlG2dLg2EIfbRGidW
	 fSfu9zltm5wytQiGwPBOlEWZ7zatIe7sHSD4uTbUAKz26tBf1sy+zdGCI7Hq/iGmvn
	 123R/MtZ5tUKfTnyPJ0cQKT1XgdTXaX1GyAxNi60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbeLUBSF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbeLUBSF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 20:18:05 -0500
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44AE1218E0;
        Fri, 21 Dec 2018 01:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545355084;
        bh=DDHMCH+ea5TZgKtmOPy2JuZ2jQU/ODVXu7U6wawHuNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfabcGP9UJbuPcDBb/w6nJ1bdesdTc+Mv37rknPuDs/RQpb+Cax3PtWOZ25A/OWJo
         usYV8w3c7lpEU1DR1zoO0BAipoZr9dAq8qoVYvaiYYAJdaA2nEI9hPGK7n6pXoF78X
         NgjvEz6EbRHtCxDskniEHtKpSeYx0Y1WOSmOXHBY=
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org,
        linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 01/14] ARM: dts: LogicPD Torpedo: Add WiLink UART node
Date:   Fri, 21 Dec 2018 02:17:39 +0100
Message-Id: <20181221011752.25627-2-sre@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
References: <20181221011752.25627-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Add a node for the UART part of WiLink chip.

Cc: Adam Ford <aford173@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
This is compile tested only!
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 9d5d53fbe9c0..2699da12dc2d 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -54,6 +54,14 @@
 	};
 };
 
+&uart2 {
+	bluetooth {
+		compatible = "ti,wl1283-st";
+		enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>; /* gpio 162 */
+		max-speed = <3000000>;
+	};
+};
+
 &omap3_pmx_core {
 	mmc3_pins: pinmux_mm3_pins {
 		pinctrl-single,pins = <
-- 
2.19.2

