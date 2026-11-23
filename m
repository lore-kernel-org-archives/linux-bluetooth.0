Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429551;
	b=wJI1AsEOyb4HKThixaakv2dETVHBJ/zDMlPvxKvSbTCcecva7N2K39uaOPcfRcDwgDr4
	 pyaQqdIIf4S6gpjxUWJGpqIZQ0UEOGMlUP/e6tnaXqpi6nPkfPZZMp4dZdjXnlfuS/cDQ
	 QIJxvyOE8XklSSBfLZHjky2Q9wPhA7WjLVD4qb2daVtgwrEYZnVAmFSmVgE+hBhZHPz8E
	 8wT4tPmPmvH49fmcTwlxxUf4arZiJYhL6dmO++0J4JMNlfjT4pJF6muv/3/7g89dGtKlq
	 BBIvP9nHZCdE5GPlIMvxNk0Fxr09khQvY0HLFIQ0yFotoqD7YwH4n9/irLllYqdS2Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429551;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=;
	b=smn0dOmrwW/MEJdYGMxTsdnk54moMNjGi9cTOxUPxNMuo1NU/Z76Z28x5Z4R/O3rKDev
	 qAZE/fKVrmlDLkLodiEWIMXjNfQpJTrNOPKCS+LVqNSD4HHvmy57KkBdAwzPjpamLndmX
	 AF10NZm6evj26VljCso7ctWmsfn/YVl961Hc3Z3Lw5eKf6ETj2aJdOH9c8ASYjCjwG0jC
	 nsRpPxPGnbVJapbOFIEF/VF3W3H0AnTvfAcR827erfjjFloq7PQmpQRQvXuqeZmiEkZha
	 JWdMh8bthGwO44vIGadMh/LQZjbHh08m45qZWChTButDHydOZX7oJ5ISaP5bwLL9e/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FCwEvqXU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8zGynrN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B319606A6B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B319606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FCwEvqXU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8zGynrN
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G29Q2528286
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=; b=FCwEvqXUkkteeyjh
	1S1Ho07mY7+MKpmHGjEpw/u01sly2+/FTvEP3DbYOaNMFdyedfCc8KpP9x4lRn+9
	A9GvoI3DZmwdpWJy7r5424xDBZvy9bHCD2b4MJVnhGdPCaMGywtJC9FT0qyGlyV+
	bjZVkDxJfYFsLjwgM4l7A3g07KPRdR6XcdRDPUFjrpV4ADTfOqjI4cy2TRrxtL0L
	k0tF4GRKq+GJzOwgd3Yob6c3gzAJmcmbno9BC2LCe6dX4WZiMeOPxPjLe9DpAkKQ
	6wyyiVcFN7ERh2eHiLdm9ZmEZiukHkjJ1FJw+go9wSXTvq1YjNAf0r1CP0fvc5sn
	6oo4BQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7rhw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so625545485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429549; x=1796034349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=;
        b=e8zGynrNkJF/Ka7jkUNs3W2xbr22U/K+qfrV82Uj3K2D5z1zhv3c1ZjhGXe66em4Er
         I3+fN7Pf1rj/xTgz1nYhQ6T2e/7LIQrMLycClEsS3ajg+jO1QmGWtiREX7s2epLFJSmY
         KCxqRpiEqT9eEc6Flm/TtoydTyEIqVe1x3iirasxDyKazg6nIpCH4ta+FudOJqofGFvn
         A4lUe9nVetnxq/c7qju3fB2b7vVy2dr+9CXpJSJhczi+qUgGW7pJ6SHb7y7C+wlMiRej
         UKzNcKOj/X5lUMq1JoYAu8dMhsyxXo2t5qeNCAWCWGxEOQF8sBTfB8O88g0f0HV5m6no
         BDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429549; x=1796034349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=;
        b=J0zkc1Pnxf/wY30n2YU0ooWkTjzRte1vgRqKTp03w6Sk+pakXGyZWKMZH+ZhpHDexx
         54/q3B2JjE2NU93HKvvhqVkC9lymCFqJnJGAerS1foDqmiKuSBMNjMGP7UxgrFnIqk4g
         CxGlJ0/Dc6kkZJKE31JzWAXQ8a8sbun2Vxtv+/kQHCHy/G7bVA0ABbbxLZgHrLfCHlKs
         tgMfF09+mhnkYlzel7Gd111lJLM2PHfmoww26SScy4NjZpY/l4bwmb+nkbSgUohZrTMz
         dFwz28PR+VkW5Hwdg2HJ9GUPWi03lt3GuD2DWoVg1ro6x55stzT8afNIT9WW2DFn2+/L
         wPbA==
X-Forwarded-Encrypted: i=1; AL+hErH27oPDEgrDRFNQICs/G4wt0GE0yOH1EtWtuVQsiAcgM97xyU7T46X3BgmDWZY/+AYl3o7/p7MxtsGITyqJ1IE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yij3qpv7Fedsb0uGoSO1sdUqQqEws50+RCDl2IFqTe5E8GOEg
	0VXZ16NIsZXMJev2Zd2gTr2jZpFtXwN00gRC6LSN/uNOxDuR6XJRlAjkNHMvb/4wCgtPTZOAGwn
	+N820fXsbyKhkN6iGVIa02UpuuVj9+rJX3jC7cknmjxMsOZL1Q4yg9sqa9kR80+F6W8Ov6Lw=
X-Gm-Gg: AZFdTZfxF0pMFGbLioWJvE6Y/zoLVih/XymqVEHb2Eprdsy+GMlrEMoLt3K2v/fkZXE
	ffwCKYDKGCIa855fLhFC0JeP5Wi1hGv59Pk60qnUPok3VysH7xNHqfS72T5wzbwAN5AtM39DUv7
	Wrr3LGVmd2ZV5wE5otB+CjHWm5j5+cf2186Rp8b1/VO58yAsLyrHH+iOuIN8gMUT1PWQjqWCdlD
	iYf/8Jy6kpJTVvkhabuH2GdJtRP0tDWFlFxp5HtaAuVQ9/mjq8V9Xl6YjbZ4wYa0PHvmELhVq3Y
	ImzXQU9Q0VKdShFXhqzdevOOvGQkHray9VciHcQTUbhFTNpPBM70djymOKyUPLPUrsvrN0UAYD4
	XdR/x0JSaoXYrUoEQqOHzNBxjgBMK4jFBsrq0dKrsVWrjbR4KK6UUB5T8ffp/O2xDl1ymzoDmtb
	LCj4UJz4TdY8c2jkULMI7BU8ZxsILx1wmDweNSDpfg5NuPB4vn0uUE7ZSOeJx6M9KxG1B4CfRJ2
	BS2ugccu2bNo1WVYtHzANyVN+i8
X-Received: by 2002:a05:620a:890c:b0:949:6e5f:7395 with SMTP id af79cd13be357-949bab350f0mr1756204285a.79.1795429549295;
        Mon, 23 Nov 2026 02:25:49 -0800 (PST)
X-Received: by 2002:a05:620a:890c:b0:949:6e5f:7395 with SMTP id af79cd13be357-949bab350f0mr1756200385a.79.1795429548752;
        Mon, 23 Nov 2026 02:25:48 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:48 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:39 +0100
Subject: [PATCH v8 8/8] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-monza-wireless-v8-8-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b0414ad cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfXwflVZcrNzb4L
 Wu8KUy7COBkIx6rGfnR6GuoUFHrV1y652VvV/wT9Ud+MEEK92RQ6ztylUXEbRXrwWwQbcAjMIwu
 5xvkIF43MdQhYrAIOOR+N2B1uXGqJHWt9JOETVQyhy+oxhbYwN0buluhVJrJnMy/il9eviTNCZV
 RadbtkZFCvYr77Z0vBXX0jZWHS+hybwUfwS02le9bpwXvmi48r79FFHUt9GWTdJrX0QqpkINv39
 syPEap/nBGXPU4a99cm9GOpSCaKiGvvCxr5IfjCx9g4G6OrD/GblOYS5KEjmDpc8FH2AGwMAmMy
 kDHU5Ug9rqX6KB2nFq+KEqtNUhzq9aAPWWniWFz39ecfLioUNgNZ3fhgkoVGY6lav2o3iSu1X/w
 PyyLYaCPAD2dW4NpbPWGg/CRJgcYgdQPR6dMmNmMwe6D8ffRo9E5G4R81gMDNVE+5ml+GhXoFOD
 Zrb1BKXkjMtms5rJ3Jw==
X-Proofpoint-GUID: ZWMQ-veR1BI0Bh604c9z5f8klibCfmex
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX2w9X2VM2v3EE
 JZUX1Miftn+yaJMfHn5RsJoiGK7ax0TFat7PmR8wvSUXBW0iVDOKiN4osUF2vIKo144U0x6qJil
 GT+W50OUOC71W4W38HEX50G9uPg8RrA=
X-Proofpoint-ORIG-GUID: ZWMQ-veR1BI0Bh604c9z5f8klibCfmex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230041

Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
Arduino VENTUNO Q board. The module is interfaced via LGA and is
compatible with the M.2 Key E.

Add wireless-lga-connector node using pcie-m2-e-connector binding,
connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
the Bluetooth interface.

Add pcie@1,0 downstream port node with pciclass,0604 compatible so
the pci-pwrctrl driver can acquire the power sequencer and enable
the M.2 slot before PCIe enumeration.

Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
(gpio56/gpio55) used by the power sequencer.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index 9ac2a04b302d90728d2302e81ed4b27b9467c23d..132f28df555b3ca3bbb411fd38155cc57f22698c 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -180,6 +180,40 @@ vreg_nvme: regulator-3p3-m2 {
 		enable-active-high;
 		startup-delay-us = <20000>;
 	};
+
+	wireless-lga-connector {
+		compatible = "qcom,pcie-m2-1418-lga-connector",
+			     "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vdc_3v3>;
+		vpcie1v8-supply = <&vdc_1v8>;
+		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&nfa725b_default_state>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* WiFi/PCIe */
+			port@0 {
+				reg = <0>;
+
+				lga_pcie_ep: endpoint {
+					remote-endpoint = <&pcie_ep>;
+				};
+			};
+
+			/* Bluetooth/UART */
+			port@3 {
+				reg = <3>;
+
+				lga_uart_ep: endpoint {
+					remote-endpoint = <&uart10_ep>;
+				};
+			};
+		};
+	};
 };
 
 &cci1 {
@@ -548,6 +582,22 @@ pcie@0,0 {
 		ranges;
 		reg = <0x010000 0x00 0x00 0x00 0x00>;
 
+		pcie@1,0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			compatible = "pciclass,0604";
+			bus-range = <0x00 0xff>;
+			ranges;
+			reg = <0x020800 0x00 0x00 0x00 0x00>;
+
+			port {
+				pcie_ep: endpoint {
+					remote-endpoint = <&lga_pcie_ep>;
+				};
+			};
+		};
+
 		pcie@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -706,6 +756,12 @@ max98091_default: max98091-default-state {
 		bias-pull-up;
 	};
 
+	nfa725b_default_state: nfa725b-default-state {
+		pins = "gpio55", "gpio56";
+		function = "gpio";
+		bias-disable;
+	};
+
 	pcie1_default_state: pcie1-default-state {
 		wake-pins {
 			pins = "gpio21";
@@ -757,10 +813,10 @@ &uart7 {
 &uart10 {
 	status = "okay";
 
-	bluetooth: bluetooth {
-		compatible = "qcom,qca2066-bt";
-		enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
-		clocks = <&sleep_clk>;
+	port {
+		uart10_ep: endpoint {
+			remote-endpoint = <&lga_uart_ep>;
+		};
 	};
 };
 

-- 
2.34.1

