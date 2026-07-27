Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80E41D64A
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167275; cv=none; b=cSn7SJCUcduc59KrTpdnrtD7H0FeDQb6G+7B+LbscyWgEArwl0hPuJH6eTXSrjcovJPHxt04RvQ8cD51Rdcjd3oHtGSbfe0J7+wpDVptH8LZFeDK7boPpVM0RnUvNWx0CyU+bZE/GPgNz7LCsLJp+VJyOKaE0Xdcdzjo9zUXVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167275; c=relaxed/simple;
	bh=EmNMDATglf3AftKoGe4gO7aU8HvSPpfpT+PUJBZEg6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ge/MaZAY+zrReFVkeeV1YXedCiuW1ex8YkgT99T92+7BvP8/cmc4J36ssbbJR1JLYE2k0lbtUdT2Ez6sB94vYe7jVKTm3Tl2vUy6vljKjBo3lp6DUnmwQYwGhNwArLkAhCaKE0omUyaXR6CcjHTuBADXXDz5ja8BSUlXaQzhpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JW0JT5v+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J06EC+cx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JW0JT5v+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J06EC+cx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlaSd3663514
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9aAS9+E/tGC0hbzJfaKVQm0giC3eEl6eeIWKssyuhtU=; b=JW0JT5v+Wq0G/FR8
	5At9htZPTdBAhfRDJAlyB/U5hQLg30P87Yn6KGKI/TSQT9KWCQvEpcN0n0MvIRMN
	hu8f241huFMjkP5We5y3u6YBgp1e0bJR3HZyV0vznDqEw4+S1P6GqsDxJawdmWnS
	Jnptqpw7WD53QgN6dW0Cy+tA5d+sE1fioZd/UMYDBOjx4xxUv/e7WZ2wEKB8w1TG
	N96TnIe3ND/XDHv/Yn0WOO4oizMGmOi6R0TWZVRBzWOvQ0lRQXL9kPXQxCnuONkQ
	ZfbonCWyeiqCWyIWCILE0Rih/QzoTrMXx0CYunaTVyCGW/lhwj1fyqTBOPQ5LpLh
	cindOQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2asjac0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:51 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e8a76a273so73898407b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167270; x=1785772070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aAS9+E/tGC0hbzJfaKVQm0giC3eEl6eeIWKssyuhtU=;
        b=J06EC+cxm0RaM7wFLn3w6qTWoNAckGhvBpCkUyJhMuTt8+BGpi4D8x1dtZPfKPKrBp
         TgxLBXsylxvXSYyBTSAdhwJNQ22oUDAPwLLbLCIAELDkRg6MVsDEt+ISU2ef7H+Do4GM
         Ba+q+uyC9SWAF8wQcRThdfAzyfipjyajCxM5mYRVLiQE9BShOO0bjyRaVjkHE81+naZk
         V6uW7faEHOpOJbqbS17bZ0EBNOP1OlX7GhyDU89/RMahLkjytv+9yYXHrYl5FjMEBodD
         zfriCTZx6aACBGwBbkMn+maEDbbj0ZLvqrNIdejqzIE+yiiVNDjd5ZP3turVIj4fJMSl
         2gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167270; x=1785772070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aAS9+E/tGC0hbzJfaKVQm0giC3eEl6eeIWKssyuhtU=;
        b=Yoz7hn15Twp9+TGCKfCrjnyh6cY551EWV8XPam7cg5AXcUj2NIf5CBiAAhGOb/pRqA
         v5m3mz3HKi1Ydn9Yk0jnC1wKpzpcnutHOymMyOILhhNQpUBQ/h9wqXV/H0z740PiKp7A
         d5vTk3Da5V23lVJxzI3uKOsUhztGvrtDP7QzgcN15B+9eNISBdyqKKwbSZoez3P58fl5
         xKRmwjZ20x87VzLoJETWY/8ktv9E+a5nU9MOw0GFlex1t3MDewRKDHifcBl/hFYSr+UE
         StDfKeeS/YzSC9pTU85ZQvVz9LWiT3Yt81Ls2uWvAimshcwOuEGnGSJJXUOvoHz+pNSL
         Wdfg==
X-Forwarded-Encrypted: i=1; AHgh+RqH3BUbISqOND06j1wOcFPg04J2tWW5+4276EhEVMlUiVRje1/JC9W7VtAte3AkXdnFotTNjD1Zs8nWFAfzkog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KAw8QIA0yJfBbTbOVbzWg3X57MxtrNlGhH8vU5/dv7FUW0pB
	Q0kz4SomOYmpjQL7FLUx4IAsdcWbMGhZYfJjdqSaU+qcKN3auVylrQ64KFuqN/qCLw1C/LWnPEq
	R4Vwdhw+vRAsvzIZl4ZKUPqGb3UxM3OItR6eOxtpCkVjJY0aKeDGrnyeMFtxSPURFD3+PJf4=
X-Gm-Gg: AR+sD10cs2mM1yaA4+vB+ZBhgTk8u67lN3+mXXDIiObFyfQ/bWRh9jJJkgh96XytEy7
	m34YUbiHv1tKikddHaY0cJAgTCktOyZEDrUd/RSJfYvw4GR9dm564n5GBRdg5uWUrBTCz+wh+gH
	LAK+PqeNV4Y+E3pqllLUnUALOiDFGSwHwoKiOQawYu0XNjgHFtWHRP59UQE1z9HVH2cIJ8ZHwu7
	5M2L32t75PIFuQS12VcMtPeImsyXxatU7bFgvW8TojpwpvgSSS4B6kMg+KhwP9dFjdof+jRR3od
	GYD1AjDTBOh0mSEjE8sq1jgRPorzy3ojzpLcIPS0t+xO2aOd3KYm2xmmGqPRdPt9xqR3+d95+kT
	T5yI8YsMeTGWzCPYxLZxywazwSX6O3g==
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr495477b3.1.1785167270534;
        Mon, 27 Jul 2026 08:47:50 -0700 (PDT)
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr495357b3.1.1785167270201;
        Mon, 27 Jul 2026 08:47:50 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:50 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:06 +0530
Subject: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX+ZAP4hOnu8+5
 Lp3AmH+5ZsMssxWyLUhWVJDg58A2RFlC3jXO8g8xBUDNohm3lLUJ5izaTM1zE9XtEH1wgAQ3ckZ
 C2fx5B9edP6Fi/O59UQxK+Ec/+pqKMWqHbTIm9RZxHHbC08PhjK0xpSFCZaJuqnHTmL4h3pmjfC
 KZwi6QZu6csMcOkWg9VVWUGFs0CSlCJiFJCGsjW/ootP6YZhX6o7C6LTMoaMZOI93Gj65qS6Qcl
 Feyk1d5L5VVntwiHIzBebmkYkoSAdVNRf42DW/bjnsi1NZlq5YOEyogG2ZJ6gorh88peBn9eU8X
 VSYXsQIv9Yld+/bfUPq79YLLCsyDPFP7p0GSmTOuBkOi6mejwEULGZOPof3dqIygwyNkDeDpdWm
 asAP7h0S1g73VQM8Nq/WWd41YQWdiPtkR9reLnj/ALzuJnXbj+Eb8ysxNaSkRQfJPpEjxEWYyMO
 XAu5Flgt1mO5DYi8Log==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a677da7 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=i_xuHGjCaTy6jZfIMc0A:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX1IFJO1upOObb
 gynFykajzn8DE/agjEdvii61jFsrKxM2BYaJakgZnZ4OSSB3jcepbEx4m0/oznQtBni9kKV+dkp
 WGt5osnt4TWTTwWSZagX+1ZXR4a9jvE=
X-Proofpoint-ORIG-GUID: 5Y1-TbpbbKpgS1EXKB7DNCbojGzrJMwW
X-Proofpoint-GUID: 5Y1-TbpbbKpgS1EXKB7DNCbojGzrJMwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148

The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
mezzanine hardware description but routes QCC2072 Bluetooth over UART4
instead of the default Bluetooth-over-USB path.

Build this variant by applying the common Industrial mezzanine overlay
first, followed by the BT UART overlay. The overlay models the M.2 E-key
connector graph endpoints for PCIe and UART, and disables the on-board
WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
used instead.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   2 +
 ...s6490-rb3gen2-industrial-mezzanine-bt-uart.dtso | 129 +++++++++++++++++++++
 2 files changed, 131 insertions(+)

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
index 000000000000..67577d6f279f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso
@@ -0,0 +1,129 @@
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
+	m2-e-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vreg_wcn_3p3>;
+
+		ports {
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
+&pcie0_m2_e {
+	port {
+		pcie0_m2_e_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
+};
+
+&uart4 {
+	interrupts-extended = <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart4_sleep_cts>, <&qup_uart4_sleep_rts>,
+		    <&qup_uart4_sleep_tx>, <&qup_uart4_sleep_rx>;
+
+	status = "okay";
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
+&wcn6750_pmu {
+	status = "disabled";
+};

-- 
2.34.1

