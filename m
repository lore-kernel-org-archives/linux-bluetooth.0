Return-Path: <SRS0=Kz1L=YT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E27CA9EBC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739AB222CD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="EINBN9ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfJZUsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:48:39 -0400
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39552 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfJZUsj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Oct 2019 16:48:39 -0400
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id ECC5ABFCD6;
        Sat, 26 Oct 2019 20:41:47 +0000 (UTC)
Received: from bonstra.fr.eu.org (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id 5BE6A60871;
        Sat, 26 Oct 2019 22:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572122506; x=1573332106;
        bh=okg4/RrUrpM90N+gfPD7IrHzDsoXwkD6ueG/FO07g5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EINBN9ZXwqVpF8rJ4xUkRTL+V6CcIsjhqtGGqA0BVj0WCHC01c1g1TVMK6yqER+Zl
         8df8LXfT7Cwhad1qdS7a8AHFEBn6URJShul2OfmCNtDLGCijNrx5PMTLCcTJzyWgTC
         rD1oyfPbA0NzVzWQXil644pDfH7qovDqFZ2xUXsSVamCUUctqXsRsC+cTjyOHBc/l9
         7aOWW4BGZN5/6QMiilHChXRHH8uAtQn62ESTsljHaZbhoG2za6jqTjNt9bcDl5uq4n
         5b8N/5zH99h+gRLpbrD3vGdBSnGjrD4e6EvV/aYi3+ASN+nKN7TEPmdrWHFEWTlw3W
         8sR6pdgHqPong==
From:   Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: net: bluetooth: add DT binding for rtl8723bs
Date:   Sat, 26 Oct 2019 22:41:14 +0200
Message-Id: <20191026204116.95119-2-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
References: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The rtl_bt driver already supports rtl8723bs devices on ACPI platforms.
This commit adds bindings for DT-only platforms.

Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
---
 .../bindings/net/realtek,rtl8723bs-bt.txt     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt b/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt
new file mode 100644
index 000000000000..16b5cf799103
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt
@@ -0,0 +1,25 @@
+Realtek rtl8723bs Bluetooth controller
+======================================
+
+This documents the binding structure and properties for the serial
+attached rtl8723bs Bluetooth controller.
+
+Required properties:
+- compatible: must be "realtek,rt8723bs-bt"
+
+Optional properties:
+- enable-gpio: gpio line controlling the power down (BT_DIS#) signal
+- device-wake: gpio line controlling the device wakeup (BT_WAKE) signal
+- realtek,config-name: postfix added to the name of the firmware file
+  containing the chip configuration
+
+Example:
+
+&uart1 {
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		enable-gpio = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		device-wake-gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		realtek,config-name = "olimex_a64_teres_i";
+	};
+};
-- 
2.23.0

