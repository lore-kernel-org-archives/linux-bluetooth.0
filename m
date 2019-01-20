Return-Path: <SRS0=FRXr=P4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C96C6369F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Jan 2019 12:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F96A2084F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Jan 2019 12:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfATMlT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Jan 2019 07:41:19 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44645 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbfATMlS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Jan 2019 07:41:18 -0500
Received: from localhost.localdomain ([84.93.100.233])
        by smtp with ESMTP
        id lCPPgmo0o0eJxlCPdgxu5i; Sun, 20 Jan 2019 12:41:18 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=LrG8NEVc c=1 sm=1 tr=0
 a=28fyDxKB7osSiHeljbD2ug==:117 a=28fyDxKB7osSiHeljbD2ug==:17
 a=X63dCvaKAAAA:20 a=SuiTQ7b_h-UYz9pQzvQA:9 a=1hm7HB1BtpB_aWXK:21
 a=jPV5CKKMQbvjlxdG:21
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: dt-bindings: Realtek serial bluetooth
Date:   Sun, 20 Jan 2019 12:40:46 +0000
Message-Id: <20190120124046.6715-2-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120124046.6715-1-beagleboard@davidjohnsummers.uk>
References: <20190120124046.6715-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGcoFOwsplqn+/uzZpM17VEsB5vHkmvTi5nvbQzETsEzpzsB7MIZV19kTwGj+RT+pASHWsh28f2alj+Bdi52lDtGsq7JWhWVdGcb8dwoMU2dd11B9/CE
 pvVVIZt/TCEiTjCmEtqTPtU+Uwan2d4SZZYQv2EVScJPKCdzAxK0yuq9RkBhp8rAz9YCpm6UlNi7KkCHlwppSt4CUbgyUKi6WI8=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since v2, the compatible binding names have been changed to end in
-bt, as requested by robh. Also the example has been expanded.

As before, for these Realtek devices, are typicaly joint wifi and
bluetooth devices; with seperate interfaces which will be
independently wired to the cpu. For these devices wifi is sdio, whilst
bluetooth is a uart. This patchset just sets the device tree links for
the bluetooth interface.

The example device tree source code, alas hasn't been tested. It is a
copy of that used on the ASUS Tinker Board:

https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678

If these patches are accepted, my next job will be to mainline the
rest of the Tinker Board patches - so if this element of the device
tree has to change, I will also update the example here.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 .../bindings/net/realtek-bluetooth-serial.txt | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
new file mode 100644
index 000000000000..119f9db4f87f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
@@ -0,0 +1,32 @@
+Realtek bluetooth devices connected via a UART.
+These devices typically also have a wi-fi connected via sdio - the
+compatible described here is used just for referencing the bluetooth.
+
+- compatible: should be "realtek,<name>-bt"
+  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
+       "realtek,rtl8723as-bt"
+       "realtek,rtl8723bs-bt"
+       "realtek,rtl8723ds-bt"
+       "realtek,rtl8761atv"
+       "realtek,rtl8821as-bt"
+       "realtek,rtl8821cs-bt"
+       "realtek,rtl8822bs-bt"
+
+Example:
+
+&uart0 {
+	status = "okay";
+	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bluetooth";
+		uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default","rts_gpio";
+		pinctrl-0 = <&uart0_rts>;
+		pinctrl-1 = <&uart0_gpios>;
+		BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+this ensures that the bluetooth device is tied to the correct uart
-- 
beagleboard@davidjohnsummers.uk

