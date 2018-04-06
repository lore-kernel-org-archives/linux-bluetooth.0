Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add device tree bindings for Atheros chips
Date: Fri,  6 Apr 2018 17:22:24 +0530
Message-Id: <1523015546-994-2-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1523015546-994-1-git-send-email-bgodavar@codeaurora.org>
References: <1523015546-994-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rupesh Tatiya <rtatiya@codeaurora.org>

Change-Id: Ie62e3b90b6226019142206c8d44712a6c8550ef2
Signed-off-by: Rupesh Tatiya <rtatiya@codeaurora.org>
---
 .../devicetree/bindings/bluetooth/btqca_power.txt  | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bluetooth/btqca_power.txt

diff --git a/Documentation/devicetree/bindings/bluetooth/btqca_power.txt b/Documentation/devicetree/bindings/bluetooth/btqca_power.txt
new file mode 100644
index 0000000..f0f593c
--- /dev/null
+++ b/Documentation/devicetree/bindings/bluetooth/btqca_power.txt
@@ -0,0 +1,30 @@
+* Bluetooth Controller
+Bluetooth controller communicates with the Bluetooth Host using HCI Transport layer.
+HCI Transport layer can be based on UART or USB serial communication protocol.
+
+Required properties:
+  - compatible: Should be set to one of the following:
+	qca,ar3002
+	qca,qca6174
+	qca,wcn3990
+
+Optional properties:
+  - vddpa-supply: Bluetooth VDD PA regulator handle
+  - vddio-supply: Bluetooth VDD IO regulator handle
+  - vddldo-supply: Bluetooth VDD LDO regulator handle. Kept under optional parameters
+		as some of the chipsets doesn't require ldo or it may use from same vddio.
+  - vddxtal-supply: Bluetooth VDD XTAL regulator handle
+  - vddcore-supply: Bluetooth VDD CORE regulator handle
+  - vddpwd-supply: Chip power down gpio is required when bluetooth module
+		and other modules like wifi co-exist in a singe chip and shares a
+		common gpio to bring chip out of reset.
+
+Example:
+  bt-ar3002 {
+    compatible = "qca,ar3002";
+    vddio-supply = <&pm8941_s3>;
+    vddpa-supply = <&pm8941_l19>;
+    vddxtal-supply = <&pm8994_l30>;
+    vddcore-supply = <&pm8994_s3>;
+    vddpwd-supply = <&ath_chip_pwd_l>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
