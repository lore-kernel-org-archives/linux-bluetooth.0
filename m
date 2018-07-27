Return-Path: <bgodavar@qualcomm.com>
From: Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
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
Subject: [PATCH v11 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date: Fri, 27 Jul 2018 19:43:14 +0530
Message-Id: <20180727141320.25218-2-bgodavar@bgodavar-linux.qualcomm.com>
In-Reply-To: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v11:
    * removed entries of regulator currents.

Changes in v10:
    * added entry for regulator currents

Changes in v9:
    * updated with latest reg handle and names.
    * updated max-speed definition. 

Changes in v8:
    * Separated the optional entries between two chips

Changes in v7:
    * no change.

Changes in v6:

    * Changed the oper-speed to max-speed.

Changes in v5:

    * Added entry for oper-speed and init-speed.

---
 .../bindings/net/qualcomm-bluetooth.txt       | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..2175174415ee 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,22 @@ device the slave device is attached to.
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
+Optional properties for compatible string qcom,wcn3990-bt:
+
+ - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
+ - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
+ - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
+ - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +38,15 @@ serial@7570000 {
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
2.17.1
