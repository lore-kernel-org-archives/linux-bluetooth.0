Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	robh+dt@kernel.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	bjorn.andersson@linaro.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: net: document Bluetooth bindings in one place
Date: Fri,  8 Sep 2017 15:57:53 +0200
Message-Id: <1504879075-587-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

In the same way as Ethernet, gather the Bluetooth related bindings in
one file. Introduce the bluetooth-bd-address property which can be used
to store the assigned BD address.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Set device as unconfigured if default address detected
     Add warning if BD addr retrieved from DT
 v3: if no addr retrieved from DT, unconditionally set
     the invalid BD addr flag.
     swap and set bdaddr in the platform probe
 v4: Add dt-bindings documentation
     split patch in two parts (setup, dt prop)
     use local-bd-address name instead of local-mac-address
 v5: remove 2/3 merged in bluetooth-next tree
     Add bluetooth.txt for common BT bindings
     expect local-bd-address in little-endian format
 v6: use of_property_read_u8_array instead of of_get_property
 v7: use dev_info instead of BT_INFO to have dev context

 Documentation/devicetree/bindings/net/bluetooth.txt | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/bluetooth.txt b/Documentation/devicetree/bindings/net/bluetooth.txt
new file mode 100644
index 0000000..94797df
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth.txt
@@ -0,0 +1,5 @@
+The following properties are common to the Bluetooth controllers:
+
+- local-bd-address: array of 6 bytes, specifies the BD address that was
+  uniquely assigned to the Bluetooth device, formatted with least significant
+  byte first (little-endian).
-- 
1.9.1
