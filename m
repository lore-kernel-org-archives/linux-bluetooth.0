Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: add TI CC2560 Bluetooth chip
Date: Tue, 12 Dec 2017 18:29:30 -0600
Message-Id: <1513124971-23717-2-git-send-email-david@lechnology.com>
In-Reply-To: <1513124971-23717-1-git-send-email-david@lechnology.com>
References: <1513124971-23717-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a compatible string for the Texas Instruments CC2560 Bluetooth
chip to the existing TI WiLink shared transport bindings. These chips are
similar enough that the same bindings work for both. The file is renamed
to ti-bluetooth.txt to make it more generic.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt}     | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt} (78%)

diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Documentation/devicetree/bindings/net/ti-bluetooth.txt
similarity index 78%
rename from Documentation/devicetree/bindings/net/ti,wilink-st.txt
rename to Documentation/devicetree/bindings/net/ti-bluetooth.txt
index a45a508..6d03ff8 100644
--- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
+++ b/Documentation/devicetree/bindings/net/ti-bluetooth.txt
@@ -1,10 +1,18 @@
-TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
+Texas Instruments Bluetooth Chips
+---------------------------------
+
+This documents the binding structure and common properties for serial
+attached TI Bluetooth devices. The following chips are included in this
+binding:
+
+* TI CC256x Bluetooth devices
+* TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
 
 TI WiLink devices have a UART interface for providing Bluetooth, FM radio,
 and GPS over what's called "shared transport". The shared transport is
 standard BT HCI protocol with additional channels for the other functions.
 
-These devices also have a separate WiFi interface as described in
+TI WiLink devices also have a separate WiFi interface as described in
 wireless/ti,wlcore.txt.
 
 This bindings follows the UART slave device binding in
@@ -12,6 +20,7 @@ This bindings follows the UART slave device binding in
 
 Required properties:
  - compatible: should be one of the following:
+    "ti,cc2560"
     "ti,wl1271-st"
     "ti,wl1273-st"
     "ti,wl1281-st"
-- 
2.7.4
