Return-Path: <thierry.escande@linaro.org>
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add qualcomm-bluetooth
Date: Wed, 14 Mar 2018 16:55:13 +0100
Message-Id: <20180314155514.3374-3-thierry.escande@linaro.org>
In-Reply-To: <20180314155514.3374-1-thierry.escande@linaro.org>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Add binding document for serial bluetooth chips using Qualcomm protocol.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---

v4:
- Move bt-disable-n-gpios to required properties section
- Add clocks and pinctrl-0 as required properties

v3: no change
v2: no change

 .../devicetree/bindings/net/qualcomm-bluetooth.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
new file mode 100644
index 000000000000..cdb14b96c229
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -0,0 +1,34 @@
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
+ - bt-disable-n-gpios: gpio specifier, used to enable chip during probe
+ - pinctrl-0: pin phandle for bt_en gpio
+ - clocks: clock phandle for SUSCLK_32KHZ
+
+Example:
+
+serial@7570000 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp1_uart1_default>;
+	pinctrl-1 = <&blsp1_uart1_sleep>;
+
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
+
+		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_pin_a>;
+
+		clocks = <&divclk4>;
+	};
+};
-- 
2.14.1
