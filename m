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
Subject: [PATCH v10 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date: Fri, 20 Jul 2018 19:02:37 +0530
Message-Id: <20180720133243.6851-2-bgodavar@codeaurora.org>
In-Reply-To: <20180720133243.6851-1-bgodavar@codeaurora.org>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
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
 .../bindings/net/qualcomm-bluetooth.txt       | 42 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..ca04c4981048 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,34 @@ device the slave device is attached to.
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
+
+ - If WCN3990 is connected to platform where RPMH PMIC processor is used
+   then the load values will be 1uA. if it is connected to platform where RPM
+   PMIC processor is used then load value will be 10000 uA.
+   if it is connected to different platform, where current values are fixed
+   as in data sheet then below property are not required.
+
+   - vddio-current: Bluetooth wcn3990 VDD_IO current level in uA.
+   - vddxo-current: Bluetooth wcn3990 VDD_XO current level in uA.
+   - vddrf-current: Bluetooth wcn3990 VDD_RF current level in uA.
+   - vddch0-current: Bluetooth wcn3990 VDD_CH0 current level in uA.
+
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +50,19 @@ serial@7570000 {
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
+		vddio-current = <1>;
+		vddxo-current = <1>;
+		vddrf-current = <1>;
+		vddch0-current = <1>;
+		max-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
