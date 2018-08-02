Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	thierry.escande@linaro.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v13 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date: Fri,  3 Aug 2018 00:37:26 +0530
Message-Id: <20180802190732.4811-2-bgodavar@codeaurora.org>
In-Reply-To: <20180802190732.4811-1-bgodavar@codeaurora.org>
References: <20180802190732.4811-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v13:
 * Segregated optional and required properties for wcn3990.
---
 .../bindings/net/qualcomm-bluetooth.txt       | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..824c0e23c544 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,25 @@ device the slave device is attached to.
 Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
+   * "qcom,wcn3990-bt"
+
+Optional properties for compatible string qcom,qca6174-bt:
 
-Optional properties:
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
 
-Example:
+Required properties for compatible string qcom,wcn3990-bt:
+
+ - vddio-supply: VDD_IO supply regulator handle.
+ - vddxo-supply: VDD_XO supply regulator handle.
+ - vddrf-supply: VDD_RF supply regulator handle.
+ - vddch0-supply: VDD_CH0 supply regulator handle.
+
+Optional properties for compatible string qcom,wcn3990-bt:
+
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +41,15 @@ serial@7570000 {
 		clocks = <&divclk4>;
 	};
 };
+
+serial@898000 {
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
