Return-Path: <thierry.escande@linaro.org>
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] dt-bindings: net: bluetooth: Add qualcomm-bluetooth
Date: Thu, 29 Mar 2018 21:15:23 +0200
Message-Id: <20180329191524.30225-4-thierry.escande@linaro.org>
In-Reply-To: <20180329191524.30225-1-thierry.escande@linaro.org>
References: <20180329191524.30225-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Add binding document for serial bluetooth chips using Qualcomm protocol.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v7: no change

v6:
- Remove chip specific pinctrl conf
- Move gpio and clocks into optional props section

v5:
- Rename 'bt-disable-n' gpio as 'enable'

v4:
- Move bt-disable-n-gpios to required properties section
- Add clocks and pinctrl-0 as required properties

v3: no change
v2: no change

 .../devicetree/bindings/net/qualcomm-bluetooth.txt | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
new file mode 100644
index 000000000000..0ea18a53cc29
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -0,0 +1,30 @@
+Qualcomm Bluetooth Chips
+---------------------
+
+This documents the binding structure and common properties for serial
+attached Qualcomm devices.
+
+Serial attached Qualcomm devices shall be a child node of the host UART
+device the slave device is attached to.
+
+Required properties:
+ - compatible: should contain one of the following:
+   * "qcom,qca6174-bt"
+
+Optional properties:
+ - enable-gpios: gpio specifier used to enable chip
+ - clocks: clock provided to the controller (SUSCLK_32KHZ)
+
+Example:
+
+serial@7570000 {
+	label = "BT-UART";
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
+
+		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+		clocks = <&divclk4>;
+	};
+};
-- 
2.14.1
