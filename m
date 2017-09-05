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
Subject: [PATCH v4 1/3] dt-bindings: soc: qcom: Add local-bd-address property to WCNSS-BT
Date: Tue,  5 Sep 2017 12:26:02 +0200
Message-Id: <1504607164-12645-1-git-send-email-loic.poulain@linaro.org>
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

 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
index 4ea39e9186a7..1edfcdc6e267 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
@@ -37,6 +37,12 @@ The following properties are defined to the bluetooth node:
 	Definition: must be:
 		    "qcom,wcnss-bt"
 
+- local-bd-address:
+	Usage: optional
+	Value type: <u8 array>
+	Definition: should specify the unique 6-byte BD address assigned to the
+		    BT controller. Usually added at runtime by the boot loader.
+
 == WiFi
 The following properties are defined to the WiFi node:
 
-- 
2.13.0
