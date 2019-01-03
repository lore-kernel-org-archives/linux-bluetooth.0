Return-Path: <SRS0=oHG9=PL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AEFC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FD62070D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfACQnl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:43:41 -0500
Received: from avasout03.plus.net ([84.93.230.244]:41584 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbfACQnk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jan 2019 11:43:40 -0500
Received: from localhost.localdomain ([87.112.196.180])
        by smtp with ESMTPA
        id f5yHgSh7KimnMf5yRgALVK; Thu, 03 Jan 2019 16:36:09 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CoqRjEwD c=1 sm=1 tr=0
 a=Y1wGFK3FhPvFCcGACwKsaA==:117 a=Y1wGFK3FhPvFCcGACwKsaA==:17 a=ag1SF4gXAAAA:8
 a=OE3fWgKIv0mTuvs3W8IA:9 a=QAsrkg2CaESh2Yvt:21 a=3fakuoe7C_Kcefeu:21
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-AUTH: davidjohnsummers@:2500
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCHv2] Description of the realtek bluetooth device tree hooks
Date:   Thu,  3 Jan 2019 16:35:37 +0000
Message-Id: <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAkm9zAlECxWQLhXo7Q589QNcGDC2gfu6hoaG3VtoQya9njWI7TwaPZ7gMS45vJ8LWahhiJtSS9C/4N1Z57zqWiuMnbD0z+XByQzMHq0g+jLCDrXC4Wz
 cN5Tdz43ktAXMpaNhSZsJq9Kbsx+QRWhNBCt4yDR9Fk6GxuDEN7LCP8MlODrMGsTUQB/p3ISWtBQ6isUhwotBb5TZuAuJ98cZUQ=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the desrciption file that describes the hooks for the
realtek bluetooth serial devices, as needed to refer to the interface
in the device tree.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
new file mode 100644
index 000000000000..0aabca1fc002
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
@@ -0,0 +1,28 @@
+Realtek bluetooth devices connected via a UART
+
+- compatible: should be "realtek,<name>-bluetooth"
+  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
+       "realtek,rtl8723as-bluetooth"
+       "realtek,rtl8723bs-bluetooth"
+       "realtek,rtl8723ds-bluetooth"
+       "realtek,rtl8761atv"
+       "realtek,rtl8821as-bluetooth"
+       "realtek,rtl8821cs-bluetooth"
+       "realtek,rtl8822bs-bluetooth"
+- These device are bluetooth devices, that connect via a uart
+- all devices (except for rtl8761atv) are also wifi devices, this is connected
+  seperatly via sdio - and is not covered by this compatible node
+- ideally these will be referenced in a device tree serial node via serdev
+ http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
+
+Example:
+
+&uart0 {
+	status = "okay";
+       	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
+       	bluetooth {
+               	  compatible = "realtek,rtl8723bs-bluetooth";
+       	};
+};
+
+this ensures that the bluetooth device is tied to the correct uart
-- 
beagleboard@davidjohnsummers.uk

