Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v5 1/3] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date: Fri, 11 May 2018 17:51:01 +0530
Message-Id: <1526041263-18795-2-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1526041263-18795-1-git-send-email-bgodavar@codeaurora.org>
References: <1526041263-18795-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 .../devicetree/bindings/net/qualcomm-bluetooth.txt | 31 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a5..63cae49 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,24 @@ device the slave device is attached to.
 Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
+   * "qcom,wcn3990-bt"
 
 Optional properties:
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
-
-Example:
+ - vddpa-supply: Bluetooth VDD PA regulator handle
+ - vddio-supply: Bluetooth VDD IO regulator handle
+ - vddldo-supply: Bluetooth VDD LDO regulator handle. Kept under optional
+		  parameters as some of the chipsets doesn't require ldo or
+		  it may use from same vddio.
+ - vddxtal-supply: Bluetooth VDD XTAL regulator handle
+ - vddcore-supply: Bluetooth VDD CORE regulator handle
+ - vddpwd-supply: Chip power down gpio is required when bluetooth module
+		  and other modules like wifi co-exist in a singe chip and
+		  shares a common gpio to bring chip out of reset.
+ - oper-speed: operating speed of the chip.
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +40,18 @@ serial@7570000 {
 		clocks = <&divclk4>;
 	};
 };
+
+serial@898000 {
+	label = "BT-UART";
+	status = "okay";
+
+	bluetooth: bt_wcn3990 {
+		compatible = "qcom,wcn3990-bt";
+		vddio-supply = <&pm8998_s3>;
+		vddxtal-supply = <&pm8998_s5>;
+		vddcore-supply = <&pm8998_l7>;
+		vddpa-supply = <&pm8998_l17>;
+		vddldo-supply = <&pm8998_l25>;
+		oper-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
