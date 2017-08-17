Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: robh+dt@kernel.org,
	f.fainelli@gmail.com,
	rjui@broadcom.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	stefan.wahren@i2se.com
Cc: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH v4 2/4] ARM: dts: bcm283x: Use stdout-path instead of console bootarg
Date: Thu, 17 Aug 2017 19:59:49 +0200
Message-Id: <1502992791-10265-2-git-send-email-loic.poulain@gmail.com>
In-Reply-To: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
References: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add the serial port config to "chosen/stdout-path".
Create serial0/1 aliases referring to uart0 ant uart1 paths.
Remove unneeded earlyprintk.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
 v2: dt-bindings as separate patch
     rebase on upcoming pi3 dts changes
 v3: changes in bcm serdev drivers:
     name refactoring and additional comments
     Add generic host_set_baudrate method
     Use agnostic device_property_read
 v4: changes in doc and dts:
     Add additional params to broadcom bt dt-bindings
     Set the max baudrate to 2000000 instead of 921600
     use chosen/stdout-path instead of console=
     remove useless earlyprintk
     same changes in bcm283x.dtsi

 arch/arm/boot/dts/bcm283x.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 431dcfc..013431e 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -20,8 +20,13 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	chosen {
-		bootargs = "earlyprintk console=ttyAMA0";
+		stdout-path = "serial0:115200n8";
 	};
 
 	thermal-zones {
-- 
1.9.1
