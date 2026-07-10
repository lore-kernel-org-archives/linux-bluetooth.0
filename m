Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209853FC5A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677480; cv=none; b=grqIHroiNt+iAMpq7t3dja1pVylfCmcPr9HP/fCaUy5PY4HfMeKH+zJvxZdPlwjv5z/itsIc/W9vPY8Sh0pv4B3rApz7Ke1V/tNk04Uhnt6DYR8Brm+aNn6vXJOB5dMbwQBwUlHfFjQWszdZvYoyTlLnY633xGPYoo7d6juSOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677480; c=relaxed/simple;
	bh=6pXYbq0cnSv0KPQPpczNz5p2DBipwsIgwwH6Bmrx3y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrgEZooyzTTH2k+dRWLOe2W2k/rUrxrIpvxxkpVe4+n+Dq+ZaxnYkfE+k22CnQHaAb5SnfVPicuxQx0POJ1a+aXpTW9nd2yMQZmUW6/0taIRskZ4kdZNGa86wemYqcVZz+OHTxV2wkIuo+YI+hX3Aq3kxXVOM0e3m/nPOMXs5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ozl487vZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WA0rlals; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozl487vZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WA0rlals"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dYKH056500
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Vyq56zyV3kK/hWlhQpFe9/5myCJg+mLyuzZJXrDJPQ=; b=ozl487vZanGltMn+
	QpHgalX8RBnW6jugZr+4QR1ocqaSsPjHS55sxqaiRDh/3Z5mdW+Kr1N003XRGNwY
	tZnj7UUur6r3c0NZxInCQiJAJMc4dTnbz9Wgc0/wLSidN1kwA53A5hkAiXQ6N66y
	6EtyJ6C72Ww9kQPEv3C71mwt8C+YZDoH+693GWikPE0Dlw0BaZmrnc9THC794Jiu
	uNEYTtip+GZphKsdktaSSa/T2pxeBy0zxZjVrUrqh6hsjuPz6IxHRj8dNSCE2bqM
	Z8DljmkommMI518uUh6ryj06cMuopd0ZVvdSf/T1ZC2mTS55ifRtaIbQyNtot61Q
	U4hEzw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwtafr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0d6a2f4cso7089411cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677472; x=1784282272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vyq56zyV3kK/hWlhQpFe9/5myCJg+mLyuzZJXrDJPQ=;
        b=WA0rlalsrE78wUgu9Y70T8dGyKZblV4tF8kxsU8TgTNA7dhymQRmkFHqgJ/R4iOp8B
         lbpvB2/V9KhjQeKj9B8G+rxUTZwysMoUfUdu21YJBJqBpTINCuOKLJ+nvpBJt5soJsGN
         iRYl9dvRXQ8xLXNQNePqtiG8gXSBW7FbECk8Xeoh+n+O1VkPFuTPqkR6cC9bL9DWJtgm
         F5RCZr0M8Bc/8iirsrk+Xq8ZGrCEt37VAXNy8ACHCpmPxDb2yaQ575rcS1mAoX4R2sY8
         wBceAijLIub1QJiNvCQtNyuxULQC1oQNFtbV3I2yV9XMymXR7DwTHPdiMcJ7wC/tjXu6
         BIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677472; x=1784282272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Vyq56zyV3kK/hWlhQpFe9/5myCJg+mLyuzZJXrDJPQ=;
        b=MwNXigRvdhx/E1cdgdaGYTxVVCNl7MDVGfuGSGcCi8YCL6uV8hUiw82xcfSh5Pyiwd
         iOq0JmNBH56y1ef5Gea5ZZwZsEY23olDwDgjS/25RLeUCHQ2VWlK6FUZpjkHbqWab7ru
         hYpu4U9UvwcvmI6fPmvKcXEU+j0l1wciRdzBwm/dE9aWSwPQarCx1dZnfzRcAZcRC5+b
         an/6aXfoPeC4FubbF8NgEQKXnRdlHvVvBx1uRfC+7d1XlDrYe8YQThY/6yQWIvWD6Zsu
         I3jn6CAFxg9ouUm8Qpn3myzpneUsl7YkOMLgjBgc+nSUeHqMmrR0MDfMsSGTEEBL4pYS
         fqqg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8eUpMxbu4k4N/FwwKSlHsG4NziGQZOv5bnsvccWjh9OmRDjl2hiNKvQZQJoF+fLyYEMydgJy8Ji+1KIBkhAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrXdqpuDWBVtweeofecUvAhK7AcR1Uwlf/jT25lqyTJjAbELk
	2PosT/b8OeGqLY5sUM9WYLxOs2qTeUjmLkNjRanYpxr1+9OWbaVRfS2yUUAW7u/hZWpTUxjpDaE
	F7OSVvZzFYOJceCQImW9R8RJzxpiSot6EG5Rom/wOELr5bvRH001FZe1tE+iUczLdvscJ5Ig=
X-Gm-Gg: AfdE7ckEl+WQoNRP8EXjoTb99CPoMnp2cq36UDz/j/TMmBeeld+C8i0umTI1MQBO6Ef
	PDVdF9ZGKPNtN+RUqyfY8AvFqZSokWUdrz7uzh00oLa2G/e5ya4fdRzYsS3C+42gN4CoSN/oCeF
	PngkR6CgD2uKrvmKaLv7FFCdMbutbggnrEU//kuoSIRfcmUBmRxDpabsoY8JibMPXJX6L8sfY1w
	wJwfXh65fwFHSMKHgbqg6PzUzkGOcfjAWgkXKaAQaTtTgVXBFNHr9XGI9doeAjjxFk7t990z1AN
	Unrc3sksgcr8c4ofEdwfVK0Ix1rgqDY+aQLr8KsG+XUX2m8qRRFKvYDndQ4H6747xwfvE+eTAOx
	qp00Xndk/bNVw7VVrrwSI8N/MNPe56J5zVOrd4yEQ010KZAhzVx08HBK8fwZug6rGXN2Vj8JVEY
	r6mWdwchjG35Pt4zlFRCMng7DzIvrDNIAPaPfe5+doUnEo0f4n8YpK5u/xdFLafJReWpuuep9hr
	U+wvvUO/pHq/wAeBvra
X-Received: by 2002:a05:622a:1195:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-51c8b3ffca3mr110162141cf.9.1783677471882;
        Fri, 10 Jul 2026 02:57:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1195:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-51c8b3ffca3mr110161911cf.9.1783677471489;
        Fri, 10 Jul 2026 02:57:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:37 +0200
Subject: [PATCH v3 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-11-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a50c220 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: gnH1HOKlZhPQOuE4r5Vf8L_WLODLaDSP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OCBTYWx0ZWRfX/Ns2p3lpKWOc
 E6m2d0jT9A5uTaaDctA3gxIv4/o7JDMOwmmbqKpT2uEKMO0ns46K9XdI0cV7dIJvmmLR7tKvhkS
 La8eEhxAp7hgF/KxV2YPW3GE5noQYtI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OCBTYWx0ZWRfX+5puslt4/DhN
 N7O6j36DwyjhwxUnYAj4iCYcXC1CA0l0xaKYYe8/z9WhSqoM9A3dFuEetVOIdXVNZINXnNnV+3/
 AuzPunOgo53PQ4K+n5REHf7YnzYTF7dV8CxmXdXV965epAhRG2oVxFR4YC4eWn9dIUD/1A60qfu
 xLvgqsCLmsKIiagw12nDXsgycyeJcRYFLixD0Xd8ULIMo0jVbcQMPiIgP/5x5FizY5YuVJ0rPpB
 /b+/TORRVHAwt0sbMkSkqXIYGcAesY8Hd2r1UTdtpjswlUABxeF4PsOqRMqINJ2F6DWbSmTsU0i
 LHkin4GoYrmXjdRkOQQ3AgsFv0Z2OlTRLHfkyb9cgkMYm7h0MxVndzMGPrSt3qRP6YbNUYju+bb
 lGYCnVX3AgCGmGdGgib6dhXBYvv4xKLTfCuPR0xietUe7GXJa33u0xLNL8D4TyGuTLo/gXQrGn1
 IW+2UCMdFhNjCtcNfRg==
X-Proofpoint-ORIG-GUID: gnH1HOKlZhPQOuE4r5Vf8L_WLODLaDSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100098

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
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index f67a554adf956696aeac2348e478dbd0b74f0e62..e3d3d68932efff494f3c7ab96d75869be24c4a94 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -155,6 +155,40 @@ vreg_nvme: regulator-3p3-m2 {
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
+					remote-endpoint = <&pcie_bridge_ep>;
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
@@ -409,6 +443,22 @@ pci@0,0 {
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
+				pcie_bridge_ep: endpoint {
+					remote-endpoint = <&lga_pcie_ep>;
+				};
+			};
+		};
+
 		pci@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -501,6 +551,12 @@ max98091_default: max98091-default-state {
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
@@ -544,10 +600,10 @@ &uart7 {
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

