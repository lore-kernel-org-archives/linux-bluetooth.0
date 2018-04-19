Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	thierry.escande@linaro.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 1/2] Bluetooth: Add device tree bindings for Atheros chips
Date: Thu, 19 Apr 2018 19:04:57 +0530
Message-Id: <1524144898-4645-2-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1524144898-4645-1-git-send-email-bgodavar@codeaurora.org>
References: <1524144898-4645-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

 - Add binding document for serial bluetooth chips using Qualcomm protocol.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a5..d7fb29b 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,10 +10,21 @@ device the slave device is attached to.
 Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
+   * "qca,wcn3990-bt"
 
 Optional properties:
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
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
 
 Example:
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
