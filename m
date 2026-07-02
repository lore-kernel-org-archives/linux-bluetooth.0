Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A473CF20C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989201; cv=none; b=gP7x2ERgBQNasj6qJqE66E2CG+AoW2f6qNQ56p/j+fVV2Ebr4BxiBlGsCjgLtmEgYDJ4OdooZv+uJg8TnouMRUsXdqwkOBORIHGNXhTAJVgV+um0IpUsHThs9gG/j6vOc/1aO380Md98TyzDU5r8z7KRk1SKVlYmO2v8vBu2/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989201; c=relaxed/simple;
	bh=3DSVzwIlnQfv+D7lfNEK0mAhgs9cSZ6PohGta8ETunw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vyv9bQ0KmvQujQoTguBGawtexgcD7zEs9NWcyIWM9T2WkwNpRBjsZ9HfZsuSc3DOSuMsYlKrFAg9lcgZU6zOfEtu1H6ZX9yQes1jJwWF3DaTSKlQ96UDdVcW4VJiEN9AS2cw1VJkeOpl/Ey2v/ExHLA2yK9EHTnqhPQHl7u02fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4ItMzV4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcHrN8bf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4ItMzV4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcHrN8bf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628sNhs4172571
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 10:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wa7zNeg/NowcWs39grlG3DDJYgS0nuGoGJSwyYi+7Oo=; b=T4ItMzV4QpaTtcBx
	XsVrhIVkfIpAIf5yUx+JRAUEB2piepvOZfe4XDKmVQxNjAPWFesCq4qSmt9KLGw5
	vqQhsBW1Kc7XW3WE/IP2o9jc8N+svf3miupUWM7ZoOhxdM/YoDFpRrAJ7xRJznhl
	4rpkL/EgCj5BDT41MBHUADyfLGSZoWJvHiqd7Sao9BIELkkQPpK5CYeSrj9RUTrc
	MQb8fJXzlvz270zHmi2onpJqZlTKIDB5il+7Ls1cu80idVKSt9SzNnE92QOzfhRY
	BQ2m9iq7wN5JPksKS4U/DjyqCoX7TjP2vYsv8d3tVHqFaXYi5KQJhKuvbFn5F+Fn
	y1jTgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwre40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 10:46:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e623b0e95so163765085a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989197; x=1783593997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wa7zNeg/NowcWs39grlG3DDJYgS0nuGoGJSwyYi+7Oo=;
        b=UcHrN8bfSR6RgK9NtvaXhvHVROBc/o13hdfG5xmWpUATvmV5xu8/VcqU779U2Aafgw
         yd8y+fIxiSE200ohu0SaFY1bC93gwnxLonGvue2NH7yiAjdVKtNxwBi9BCEFkoLHatcC
         Gic6np0+8IP1RBZLPbEceYlRZL1dT/EpaG+fih2mOYNW9hPuwAVF/NRoNTjE9GIDFhFY
         W7sv5+c9G1KQUduFfv+Z2iZ4JOTXsFtQOtE3z9Yh/p2f6P6ODNudhRbChsGASYJ2aEhk
         CstwZuIo5HfSJxUFNKZfpWA3UazwmDabpgDZ80u2H9sQ+l1+uXZEN1mJqhIhPfRAvAYm
         nhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989197; x=1783593997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wa7zNeg/NowcWs39grlG3DDJYgS0nuGoGJSwyYi+7Oo=;
        b=W/NqITKDE1AU8csU82wkBm2ralnpjI3pBmLi6/3em+6EQTBy5AlMvWYlRgnb93c3dj
         cwzZrl4qWB7hCnLNJ+ZR4/Ehb/Q09cQD3p14mr3NVaYl7TPB5FNFVRlg40aCWoCsQdFt
         hCU1fzJxDMn7YnWWkq9NNz44TamO7jKEhwnITohaaf7HRvlo4Gf6SVEpZeGZ9DcmCRnF
         GhCsHA1GvRFbwSK7BrURp8UUJxqOg8XosBycb2F0U+33JxeU7nvv9+EfH+ImVx/SWN1W
         QDZzfDjFTHd3ykxO9isLBz2RRzX0sSkByKvJZAbEeS+e9UhztIELVV4MdRVymg/Jldjo
         KiVw==
X-Forwarded-Encrypted: i=1; AFNElJ9JJTBxIEMAOnUgw36/F3zzXM6NiUUwr2rmXOEDgtAMJZv95VOico0Exx1gbjuY6AA0YvQ1g8VpwGyigDVN2Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpcHb6b5RnXmzB0l8xQ6SktX3rJPQ9k01JjEaKbfHqEGCJ0V7
	bkkKuZUO/jLhEuNTY2gY+9xR6/ek1Mvr/jPyRfZVLxv/zkrQ7KqHaYBFW/AlqUG6mGUHiS/Z1Sp
	SgpqfMGMTAqSxSYf+LxyoLruPo0mp9uWzUuOPr682P0kzt++OTvkXgYX8eGbiDbamaHjSbHM=
X-Gm-Gg: AfdE7cnM0CUMfzOnjdLUx3mojCMDLML1qVKxSMn4MJ99j/3To0j6YlZSFHaM80bv2Js
	tensmxj9efdO/D5pDJ4lHXTY+6Q6LLTPm3b2sj6fvjdqik4Ra19poc6o8nXgFZwevm35RZFPJsH
	N/QktZCExlTLYbVD+ajpNi5/nF0blt4J7Gmkb9/L+9COam+2txPSNPwKIGU7sUkPKJQ5Foe3c0n
	w04qyQjMoUUlY4+V9RaC9CTxT9aiVZz85CxydeyU2RA0yypJfDVv6tBxA1QqMpga7YdViIyQVtu
	4aEvJsod+2C4ikcjCeipsei6Sk9Sxg9nyQWHfE6xDI6AajkFrYTWfFT6B/AOYiM8sXSk8MpD37u
	mXvckKi+73hQc6blov7ey/3O5n+xvUnYnNfHx8iAG4XxfikRfDoYM/y8/Xesw858L6yXPuCXj/o
	AlbZJE2LtICA5UxCqSKHtszSZwmSfs0RavPQgiZO2gRv1OY7Rko3QtWfkJ3YowsQU=
X-Received: by 2002:a05:620a:444f:b0:92e:5610:e479 with SMTP id af79cd13be357-92e784db52fmr656334885a.52.1782989196825;
        Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
X-Received: by 2002:a05:620a:444f:b0:92e:5610:e479 with SMTP id af79cd13be357-92e784db52fmr656332885a.52.1782989196333;
        Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 12:46:16 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-monza-wireless-v2-4-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
In-Reply-To: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: qeUF4g2d-VgDuXuaTV-nwM0e3nFGgQGJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX4805gQUxbuRp
 8+gEcLur/yNzdeyKVsCPuSjAXJUZI56wSWacV7HhEvdsKSWgLJftTouJhfF05P/xq44wWgRiWFz
 GcH1LZoE4415hpI7zqW4I6/Y4M7Ft83t+p4z9GDjy7jJrNyw1d5qVCjuGM2tFC+p+0NC7aPi/pI
 Q9OjeIjYmlH56oyvgOy1o4SpFRk2Ncs7FxYFn0uzdIzdYcYlxZps/F47bw141vOtkHiifFFtbeM
 bOMaPf+IldzvIPrQB3acSXu3h3m6Q+JsIVm4xuXza5fU2d1zq5INx0rMVtwLjVIw6tWqxUYNZ20
 /OSyEVQf55QS4w+oaKhWPQzR4HXxZ+lDSOG/fa3Esu5lX9JzaQOGoaHHCUbPt6DdrkicnjeVPTj
 Fnb/G0HLwH89oAXH99ulNBGn+e05exK+NjLS++Ojlz0uS+oiOgDmG2cpXEggmubwMRlcM6L5AFs
 0PJsikyVm3h6xuWV92Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX+txwJaOsw+hV
 sjlNGdt6yndiVnxySzY5HwCyo3fEZ9RxYCi5awHH89GJEZXEDfSDMP061OduphHBmgVDR7LDG2/
 9eQrA/7paZvW3w2wLgj36O1qTfbUE9k=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a46418d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: qeUF4g2d-VgDuXuaTV-nwM0e3nFGgQGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

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

