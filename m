Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACE48C8D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810213; cv=none; b=GaxRPbunAMEKIt2nJ3E8vcBrtg9PY25+9uPsLJNBrhCPJmw6oN8DoKiQgvNxRheGSihwACo63pAly6WPZxS0Wmx9PLh3llgBHLZumQ7awsWZf/nT5qAPPjX7M9t+XFEJgrdL2PwjTjWHrjB/Aj8pKBRxd8e8i57YV01l3tzFyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810213; c=relaxed/simple;
	bh=MIFQXUvAtwmgOUcunrJdpxB7lkEYC76HSseE80aRcPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvCvxaCi4l7orifpZFWC/ss83ZmIXsrfclz86x0y7XrGBZl/uWtTwMSAtVN3u0m6jJR22YJJQv2aCZyG/q0HEUYjBd0NbyOqHr9rQJyduVfojmZOIMD3aCpvDaa+T6JEPKnHHNp9NnpRG4EDeyF/ch4sfTj1bAyGElw37aqsYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mpf8Q9UO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJ6vWQTk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mpf8Q9UO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJ6vWQTk"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qaDt3045036
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CMEk/wsPN+7sowI+XK59uaUQPgLYiebmeLhtXo4zWew=; b=Mpf8Q9UOu02/TvTA
	AWRLlkqFSudBBk2Nl6O1C4l3GhL7Cd+ehLodGqyFZfO02uqkzAx2yS8JOMzuA3DV
	R3Jzo9iGG4D5+7oFeNxmosfhIFoaMaYwKxx9G3o0IMMzstu1bD8uEnqf4zsBAdwn
	KJ1mldvN1EHmy0hLd0u0OlzkvCoe8X9Zg9jBh3JiEBxtRu7GGMduQopIzEl2NfZv
	x7YFLlyE/yeZ6vPYq6Gssvlfy04VchAuSjENQHJTAuzNZBaFBLTMzxvah5CANBYR
	SnvBMDMA5AxpgRTZu7JSb7FGQ0UXjctWG/ffAsKW+HqeKhXWJFc5p7rEOW0AizHs
	Sky+Dw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkeuq94gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:36:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cccfa32670so8899635ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784810211; x=1785415011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMEk/wsPN+7sowI+XK59uaUQPgLYiebmeLhtXo4zWew=;
        b=MJ6vWQTkhaZWHaB7hWY079Ke3+dh9IXsUXU+ch2hy9+NPBha3/b+uFqBOkj3grNcCf
         aq96z4Uwa0kXg3KTig1mK+zQLK5VdLj6vHBON+SYbqLbbVqqozlbMYhdLlzX1yoC2WJ+
         fCKAVS1EEQ+T1PKHVln3yRelx3nt3KQOM6lPHfbkK9eevY9/yaDSReGTEYScxCha5XRw
         2V+aS/X/mtKAXh8pcJ4S901AIC9l8YRvtVySVElF0Y+r/2jUTzRG+3MxB4PkQJQj6LXs
         biA5vIsoFtU8YJ3CGArvNYxIXcEppv+2LKtclQkdGhdKwURdJf7PvMCV+YUc3f9ZcoRa
         Wj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784810211; x=1785415011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMEk/wsPN+7sowI+XK59uaUQPgLYiebmeLhtXo4zWew=;
        b=ks3FJx/ImyUKcKEGv44JC7OOKCkFPBwQb0GtLjTaJB4IVyDPBYlgXCpRxvba5mVhPN
         VblYLlINQXO4NPenzELUtaYmD2EJgWzbWFqLCrD8gdD8M+hd6trQZbokZJQ5jtQAGskN
         Dng77wYx9T/Vcq86tcEhxVDJswvplZQTiGNKXm1cJCp8WJ5teekmwwn9DOTc7zI2gpIt
         6b47hrGzykECniRoEALVayxk+kP8Dlea/r9nI9VXkEhsQcYI/J3zuLR6n6AJLkjI84fe
         KVPhcvxCd6sPsJ8n+dUE93TCN17mxkAvQ63u5tkcqYOkCHmLZA3x1uRqiQcJ4xpJTLR4
         zTIA==
X-Forwarded-Encrypted: i=1; AHgh+RqxGjfyYL2akvznSGYffeU2zhJo8ZoAUrTCfzdbP5DV4/YuakucgiBncOyz09iIl+5nkIcOqY60pXzE0gY6xQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq8rIU4gmrFANjnpYp1b40v/sZgQa+88Lk/hxS4wSn4OvPHlA
	YKrpN0KNPE+wcNs2r3c+5mp+s1QbqZ1NR4Jk4ksOUEtIcFWYxDLaRyBwzcjgLbiP/vArgPF5Fer
	FlSVNrP9jh0vAXI+aYIo2WWt4N8pgSpfd0VhYpUHyLzDPhWqgSH8/t5+LMhMZCk3LF+c+rc8=
X-Gm-Gg: AR+sD10rpQOHtnZicQlgePQSnp7svo95Ca2McWwTB4RukFr9oxsqg8NQNy5a/CkXbhd
	uOhVXouYn90DNLjpXUIUZIc0CBQRDMK19n+b58ZILq3+7JQPHUMIaFXTnHBhNmKhL2Pi8XK+CWz
	LvHYmDTn8u2Ir2+TfHmcATP7DjXAIo1N72p3mqCKuyl4tb8jtD605fQ/HVrER/fKuKIWFNplZbu
	XwoCkWU/boIutSmolJZ6n6H4PuusdV7ENfVqmNLSG2bwH09aPJ/+nRQdm4ePqWBuWU9AgZRnHGk
	3Ta+YTpxAFcZ/mNadnwGK39hR43+sKPVMWDItoLdekYVatwja6Cu4RiPBAHiSNqysQVkDROjos1
	JILwfo6Cg7b55OtMBrISx6NmmyjTFxA==
X-Received: by 2002:a17:903:ac6:b0:2cf:9f62:1dcd with SMTP id d9443c01a7336-2cfa6d83500mr39741955ad.32.1784810210882;
        Thu, 23 Jul 2026 05:36:50 -0700 (PDT)
X-Received: by 2002:a17:903:ac6:b0:2cf:9f62:1dcd with SMTP id d9443c01a7336-2cfa6d83500mr39741455ad.32.1784810210398;
        Thu, 23 Jul 2026 05:36:50 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd76c4sm33851225ad.23.2026.07.23.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:36:50 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 18:01:09 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rb3-industrial-bt-uart-v1-3-3c8e580c09d1@oss.qualcomm.com>
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNCBTYWx0ZWRfX8XeHTZNexCyW
 NL1KQJP5Ph17gDijLXZh6ZC37U+qQvJ1DGvqzqvymwKjWoSXvKiIYmu0q5/p9TIgjLZrZ12s072
 NLl9cDmWjAgwBuhVqVMAzf7YfkbfVwo=
X-Proofpoint-ORIG-GUID: HEIXztADsFpKPRK8XhwvHymVu6VpgLp3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNCBTYWx0ZWRfX9UIBjlsYhzgj
 GFpBmQVm9jAWK5C9iurg/b390TzPNTu0WgDg2UPMmDbjOuVhFeS26U/fYOiZ4D+3CDBtbTP/Zha
 haGw2QZ7FNaZZytwpwjLK/g6fRtpsjb41fRrIprZrayTuUXe3EIOfVBvcDJqooNFgi/D+Krn6ei
 RQpV/0Aom8k8vy6Xs9ZhuEVgsCL221MOVqimbIK2WAzlNKR7cf5EzDPSQr5bSX+JcV79lgkfl1b
 MWVdG2KzXnqiIL/bUBCnN4Zh4d8XrcfxNbasdem6+sAcDcBJb8BsGubxCwGx18EeHhuMSzpIu+a
 zSi1mIQqYAF6UtoERq+I/Vd211I93iBQ4zlI8kLorde0k+86ShgM1RL2/2EPBHQIMYrGewkXlGn
 3m+RAWMmGAVS/EReDPokN5mku/jHUwLRBysc3fbPJoBCKBK1G1kDd6qcdBLYGVGRnOaskj3jYqn
 UFFfM+NQb3FoHCtrHqA==
X-Authority-Analysis: v=2.4 cv=cPDQdFeN c=1 sm=1 tr=0 ts=6a620ae3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=WIP-PoRWG5U8A2xzRqUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: HEIXztADsFpKPRK8XhwvHymVu6VpgLp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230124

Add an overlay for the RB3 Gen 2 Industrial mezzanine variant that routes
QCC2072 Bluetooth over UART4 and models the M.2 E-key connector graph
endpoints for PCIe and UART.

The default Industrial mezzanine overlay describes the common mezzanine
hardware. Build this variant by applying the common Industrial mezzanine
overlay first, followed by the BT UART overlay, because the reworked board
keeps the common mezzanine description and only changes the Bluetooth
transport routing.

The overlay also disables the on-board WCN6750 PMU and UART7 path so the
M.2 QCC2072 Bluetooth controller can be used instead.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   2 +
 ...s6490-rb3gen2-industrial-mezzanine-bt-uart.dtso | 133 +++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6f33c4e2f09c..45786d3db14a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -179,8 +179,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
 
 qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
 qcs6490-rb3gen2-industrial-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo
+qcs6490-rb3gen2-industrial-mezzanine-bt-uart-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-industrial-mezzanine.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-thundercomm-minipc-g1iot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-thundercomm-rubikpi3.dtb
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso
new file mode 100644
index 000000000000..06560df0a719
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+&{/} {
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_WCN_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		regulator-boot-on;
+	};
+
+	m2_e_connector: m2-e-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vreg_wcn_3p3>;
+
+		m2_e_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie0_m2_e_ep>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&uart4_m2_e_ep>;
+				};
+			};
+		};
+	};
+};
+
+&qup_uart4_cts {
+	bias-bus-hold;
+};
+
+&qup_uart4_rts {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart4_rx {
+	bias-pull-up;
+};
+
+&qup_uart4_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&tlmm {
+	qup_uart4_sleep_cts: qup-uart4-sleep-cts-state {
+		pins = "gpio16";
+		function = "gpio";
+		bias-bus-hold;
+	};
+
+	qup_uart4_sleep_rts: qup-uart4-sleep-rts-state {
+		pins = "gpio17";
+		function = "gpio";
+		bias-pull-down;
+	};
+
+	qup_uart4_sleep_tx: qup-uart4-sleep-tx-state {
+		pins = "gpio18";
+		function = "gpio";
+		bias-pull-up;
+	};
+
+	qup_uart4_sleep_rx: qup-uart4-sleep-rx-state {
+		pins = "gpio19";
+		function = "gpio";
+		bias-pull-up;
+	};
+};
+
+&pcie0_port {
+	pcie@0,0 {
+		pcie@2,0 {
+			port {
+				pcie0_m2_e_ep: endpoint {
+					remote-endpoint = <&m2_e_pcie_ep>;
+				};
+			};
+		};
+	};
+};
+
+&uart4 {
+	status = "okay";
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart4_sleep_cts>, <&qup_uart4_sleep_rts>,
+		    <&qup_uart4_sleep_tx>, <&qup_uart4_sleep_rx>;
+
+	port {
+		uart4_m2_e_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
+	};
+};
+
+&uart7 {
+	status = "disabled";
+};
+
+&{/wcn6750-pmu} {
+	status = "disabled";
+};

-- 
2.34.1

