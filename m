Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6674FC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3606120896
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5QwWQtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfARRCt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40377 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfARRCs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so6330843pgp.7;
        Fri, 18 Jan 2019 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d2rQCukECTJQilTnrmqyIouQcxujlVs0VqTurP7Vfgw=;
        b=A5QwWQtkeb+gp7/yUDs3PgOjwdsSvVocZkMnIO6pMCwJ5rIogQA2WynHjNSJybVTpv
         fGaNbgySGaTW9HkRagV5mvKiUc/us/gswoj0v3zFk4ck/dfgA+gPKH9HR8oPewgohIVw
         sXhMOVgKNLmNLYBd5aoC1exj1/60VA0sVzRrgBeKi3I9mJZyar7u1PxiRrNF38BB5aXz
         s9H250UhEBbnO7vq5O/91k5wbMwYdp836OntanmubH3y8xaQ9z1+qRdIPG6TwK2SD3m8
         bxoVb8Ssqt8IlA8NBxcI2C6bP2kC167TgSk6tbvYj65dFeH1pK0nLPXtp/DFFVDI4h+7
         ppRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2rQCukECTJQilTnrmqyIouQcxujlVs0VqTurP7Vfgw=;
        b=ES5N9M8TQc6vIJDGHtNeW/tGtriq42lDWgOB7LzkSzGrdyatDhUu84FEw0SpnF8mUc
         gTvefKSV6eHtYIx6+Of+0/barQa5FREOVzjQ6U+yqU79/86H2MpK8mdbBKvVWHd31yRO
         JHgA+vG2BFQmh0pN9tp14Gmht4GpPgkSeKANzUCfBT7arGrjeWvyy1Ijh60vntS+Knvd
         FuWsfMdLmcHlMgeJBwPL0mqIBxu2jPs8vE90QyD+3nFpx3OP2jqgydjxolCFpt1mdAwp
         Nj3iz0WuL4Mft2d7ksL9wfunA0G6p4/iOpwB3NcoIlz5e0m2H0y12oe5P1Gu3xjInm/u
         cv5A==
X-Gm-Message-State: AJcUukdzgYHFADSDktgXftnz28rPDpvqZxgf1exSFYJl5ee8D9d/Osfa
        q1e/BZoCBv0sE8ERBaQTmrQ=
X-Google-Smtp-Source: ALg8bN6nIPP2MNX0kxfvTje18iThnYwjws4PFr2ea4/zP2x8dsfJDv2hBo/BuhJSO8QS/crgw7j5kg==
X-Received: by 2002:a62:1212:: with SMTP id a18mr20702116pfj.217.1547830967166;
        Fri, 18 Jan 2019 09:02:47 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:46 -0800 (PST)
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
Subject: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
Date:   Fri, 18 Jan 2019 09:02:27 -0800
Message-Id: <20190118170232.16142-4-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add binding document for bluetooth part of RTL8723BS/RTL8723CS

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
new file mode 100644
index 000000000000..8357f242ae4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
@@ -0,0 +1,35 @@
+RTL8723BS/RTL8723CS Bluetooth
+---------------------
+
+RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
+BT is connected over serial. It speaks H5 protocol with few extra commands
+to upload firmware and change module speed.
+
+Required properties:
+
+ - compatible: should be one of the following:
+   * "realtek,rtl8723bs-bt"
+   * "realtek,rtl8723cs-bt"
+Optional properties:
+
+ - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
+ - enable-gpios: GPIO specifier, used to enable the BT module (active high)
+ - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
+ - firmware-postfix: firmware postfix to be used for firmware config
+ - reset-gpios: GPIO specifier, used to reset the BT module (active high)
+
+Example:
+
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+       status = "okay";
+
+       bluetooth {
+               compatible = "realtek,rtl8723bs-bt";
+               reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+               device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+               host-wakeup-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+               firmware-postfix="pine64";
+       };
+};
-- 
2.20.1

