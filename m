Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	robh+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	bjorn.andersson@linaro.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: soc: qcom: Add local-bd-address property to WCNSS-BT
Date: Tue,  5 Sep 2017 20:58:42 +0200
Message-Id: <1504637923-21652-2-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1504637923-21652-1-git-send-email-loic.poulain@linaro.org>
References: <1504637923-21652-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add optional local-bd-address property which is a 6-byte array
storing the assigned BD address. Since having a unique BD address
is critical, a per-device property value should be allocated.
This property is usually added by the boot loader which has access
to the provisioned data.

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

 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
index 4ea39e9..042a2e4 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
@@ -37,6 +37,11 @@ The following properties are defined to the bluetooth node:
 	Definition: must be:
 		    "qcom,wcnss-bt"
 
+- local-bd-address:
+	Usage: optional
+	Value type: <u8 array>
+	Definition: see Documentation/devicetree/bindings/net/bluetooth.txt
+
 == WiFi
 The following properties are defined to the WiFi node:
 
@@ -91,6 +96,9 @@ smd {
 
 			bt {
 				compatible = "qcom,wcnss-bt";
+
+				/* BD address 00:11:22:33:44:55 */
+				local-bd-address = [ 55 44 33 22 11 00 ];
 			};
 
 			wlan {
-- 
1.9.1
