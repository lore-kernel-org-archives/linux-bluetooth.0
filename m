Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: Add optional nvmem BD address bindings to ti,wlink-st
Date: Thu,  7 Dec 2017 20:57:39 -0600
Message-Id: <1512701860-8321-3-git-send-email-david@lechnology.com>
In-Reply-To: <1512701860-8321-1-git-send-email-david@lechnology.com>
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds optional nvmem consumer properties to the ti,wlink-st device tree
bindings to allow specifying the BD address.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
* Renamed "mac-address" to "bd-address"
* Fixed typos in example
* Specify byte order of "bd-address"

 Documentation/devicetree/bindings/net/ti,wilink-st.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
index 1649c1f..a45a508 100644
--- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
+++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
@@ -32,6 +32,9 @@ Optional properties:
    See ../clocks/clock-bindings.txt for details.
  - clock-names : Must include the following entry:
    "ext_clock" (External clock provided to the TI combo chip).
+ - nvmem-cells: phandle to nvmem data cell that contains a 6 byte BD address
+   with the most significant byte first (big-endian).
+ - nvmem-cell-names: "bd-address" (required when nvmem-cells is specified)
 
 Example:
 
@@ -43,5 +46,7 @@ Example:
 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		clocks = <&clk32k_wl18xx>;
 		clock-names = "ext_clock";
+		nvmem-cells = <&bd_address>;
+		nvmem-cell-names = "bd-address";
 	};
 };
-- 
2.7.4
