Return-Path: <SRS0=evc1=YX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2B6CA9ECE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5321929
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 22:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="jsJXY1/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfJ3Wo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:44:26 -0400
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39618 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfJ3WoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Oct 2019 18:44:25 -0400
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 28C66BFCB4;
        Wed, 30 Oct 2019 22:44:24 +0000 (UTC)
Received: from bonstra.fr.eu.org (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id 799DF60919;
        Wed, 30 Oct 2019 23:44:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572475462; x=1573685062;
        bh=WcI1lb2HPbE6I47E0pUdS9lIXhqiufvTf994SqCaSoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jsJXY1/j/UCI2FROIU9mDLmA6WYMaWfy73EICqeoanir22oEHD8AkQzuiKuCYFpwQ
         LsWrD6za3n/k+snlTZz+2wYpEvAskfY9Y9g4jQss/WeXZkO7/GbgpHf9klZusfGAAB
         Y5coHDGF0LOrrWGCd6cTGqOt+gbH9dzvVObatkPUgbX4vPfFM6Ot+V1A0I1aHNaD0B
         3hQRgDsoy9GQuH4uQ+r+GMRTLLT4OEWy4GvYi5RWuPpz8OLnzuf0MuEgwaSj6uFEI2
         miX0EvjU+a1tOIHUcptLiY8Hm/mh3RHRoL8g1uqg5wlHX0JZTEHL26uHtw+uKPEXRO
         sKcEgmpPZU60g==
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
Subject: [PATCH v2 1/3] dt-bindings: net: bluetooth: add DT binding for Realtek controllers
Date:   Wed, 30 Oct 2019 23:43:31 +0100
Message-Id: <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
References: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The rtl_bt driver already supports some Realtek controllers on ACPI
platforms.
This commit adds bindings for DT-only platforms.

Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
---
 .../bindings/net/realtek-bluetooth.txt        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
new file mode 100644
index 000000000000..01d4ed146705
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
@@ -0,0 +1,25 @@
+Realtek Bluetooth controllers
+=============================
+
+This documents the binding structure and properties for the serial
+attached Bluetooth controllers from Realtek.
+
+Required properties:
+- compatible: currently, only "realtek,rt8723bs-bt" is supported
+
+Optional properties:
+- enable-gpio: gpio line controlling the power down (BT_DIS#) signal
+- device-wake: gpio line controlling the device wakeup (BT_WAKE) signal
+- config-name: postfix added to the name of the firmware file
+  containing the chip configuration
+
+Example:
+
+&uart1 {
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		enable-gpio = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		device-wake-gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		config-name = "teres_a64_i";
+	};
+};
-- 
2.23.0

