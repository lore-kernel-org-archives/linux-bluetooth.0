Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 6/9] dt/bindings: Add a serial/UART attached device binding
Date: Fri,  6 Jan 2017 10:26:32 -0600
Message-Id: <20170106162635.19677-7-robh@kernel.org>
In-Reply-To: <20170106162635.19677-1-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add a common binding for describing serial/UART attached devices. Common
examples are Bluetooth, WiFi, NFC and GPS devices.

Serial attached devices are represented as child nodes of a UART node.
This may need to be extended for more complex devices with multiple
interfaces, but for the simple cases a child node is sufficient.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/slave-device.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt

diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt b/Documentation/devicetree/bindings/serial/slave-device.txt
new file mode 100644
index 000000000000..9b7c2d651345
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/slave-device.txt
@@ -0,0 +1,34 @@
+Serial Slave Device DT binding
+
+This documents the binding structure and common properties for serial
+attached devices. Common examples include Bluetooth, WiFi, NFC and GPS
+devices.
+
+qSerial attached devices shall be a child node of the host UART device the
+slave device is attached to. It is expected that the attached device is
+the only child node of the UART device. The slave device node name shall
+reflect the generic type of device for the node.
+
+Required Properties:
+
+- compatible 	: A string reflecting the vendor and specific device the node
+		  represents.
+
+Optional Properties:
+
+- reg		: A single cell representing the port/line number of the
+		  host UART. Only used if the host UART is a single node
+		  with multiple ports.
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+	interrupts = <1>;
+
+	bluetooth {
+		compatible = "brcm,bcm43341-bt";
+		interrupt-parent = <&gpio>;
+		interrupts = <10>;
+	};
+};
--
2.10.1
