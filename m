Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF43D349F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833868; cv=none; b=TfDFrdZl9nE5FsRLgPrvEzI2z6X2yUhDfde0rLrOJPQI1Pn2VAzbQ7guYSA3XyApmqfpnQWQ3P5BTfTDIv1GSibyqp9qEFvueDSgiW1rDMCiVLzC1CudcHrv9zsZC3r7hWhHqB0X1hiySOiFeR/S+q1CgxxRy4kahuZ4fJp6NYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833868; c=relaxed/simple;
	bh=oXmC8idmhUjLhYKkawhxd1KTUk9sFV2me7GAOHR77NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxkPlVWi5azGrXlA2TmJHcOwbxIONn1wXH8yRuOPO2AixpvBXAH4WJSTYsKnJpP2ELQ+jQaeafJcTYPzmEWG9UPUqxKqIpaYCPd/AOqH5k6PtKlUuILt6vNbYdHiOS03KrWdq7rZ3Jjo8HUqe+CUc9N3mV8t6H9PTRDMXWF6CIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gz+cvaaj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C0fq9Wxr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gz+cvaaj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C0fq9Wxr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImG4X575372
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HqnGNJe4aVFQAwHYVz4IVkUb
	pJzRctg4kbwJ6qvqXEQ=; b=Gz+cvaajX4mhzLOU0wjRcbjDFK9QXIimHOYONwve
	nZNVLLIuarf0H2pmPp9OAzsHqOamkZOGuj/9xpx0yuHvvOTkvar0ewS3vqF5Yi2d
	LSVDxMzMJpcrr6KN5F6lr8WmrKHgRFvUPGF2Qg0RTyMs+Ans7alzqwpmRMwzvW7X
	VcNueb3pd1eZrKjnUg8dyIz6sIhlqXQs9sxEH3eeUgrBkEc7p2XXawAYEzFsfLGW
	tDSTIVs4ZJR8I8DY1a0oSzbmbgWFZsqD7hm/HwoE4lO12EVIP2DoTIssXigm4MLZ
	XawU6v8ELgh+GyrEd3718zwN65hfbToxF4Zg2hozZZ1bBg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0ku6jx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:11:01 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9772de2c463so1124313241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784833861; x=1785438661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqnGNJe4aVFQAwHYVz4IVkUbpJzRctg4kbwJ6qvqXEQ=;
        b=C0fq9WxrIX5jXtj/wyI7QdTsx4MRaNPvQYr1ZcVCwVpTtc5osgKhZ3Wdid19IImjQ+
         eRB8Ssnqk1aJp01Bdrjc+7lDswK0lTrOIPNn6TMd1lpv1DeG/UeDmSIGec5scPMOa0eS
         yohEQEN3F92IyAkfEfbxUBKv7R90ttcdrpRS3cJh7xLiNaqaYSS1BxMYfltfucWN9Ig2
         bCApSh6cNaaNBDr+Me0PZeumT8hb1PH4rYVyPjds9nKIWqTJMS2a/u9+JVTb4NNrKTUc
         BpiQoJ3gxqxGwf+p89p9Rg0EHKJGLryV8QAtzdad+dXAStyW6SUG4c1nVw3uEicfD5Vd
         DPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784833861; x=1785438661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqnGNJe4aVFQAwHYVz4IVkUbpJzRctg4kbwJ6qvqXEQ=;
        b=mio5eMm0AaJc8yXZ++LbS9zS6J/15Vg9NY9q/KaoLDsKpAdiDH+FVtyfoCdaUDKgdl
         QD5hIq6k6dMM42tym10f0N77yVAVERE+wdXdr6TqXlmyo29R1wqVfR03nEDn1ooErye7
         bxs31d237bhTyRJFO6EcMtv4FYyCsk1BESys3jkyGaia1jpBfUdpInQ2q+uibVlK4lLC
         lwUQSJHimoPjIJANvgPvlImt2lG2keJRBmK8KmyHxv1MoqBzBeFBdaPQMMzPuCU4YzUk
         eEVWcQAI07MUrlNgAO2VnsPhVxunJ4d6I8k9l/8CYr0onY4jha5uZm9GSYNnjdlV1AvY
         VecQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEpvwVxzDPw9mHXBW/Qy1yEm7u717IN8CXvdMbBvcw2wprfAqHtJim5huIZOFEzPz23mHgWaCQa6Ztdqg3RZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRigfi+s9UuTROl5C6JuXyOvTspV9Sv7Ev41STkVqh6ZbKJFtt
	isEtO7xg+4Saf2LxCkSqB2RVyssQqW6Tvxmi+VH4s5ib2JrO2I1ak4aaHGDNj2onWfYeefdUm7h
	rMzvo9SbSS2+0RQPAgijOv4xZtWDj9R7AWvRJnjK9dQaVOsO6BQKhtn9lxVvgGkBBDkp0xU4=
X-Gm-Gg: AR+sD10bvsuQ0G4otx3wly6jVJ/jHQfbAvhT5OnBhPwRX7uQDxckYbbU1OAE5k5ksXf
	qPaCYsba2uU4s+3cw6jSjquao4GrVBQwJ3iK5GOcMm11Knvnu4oSQ+IJ6XgZBmg4pw20MLJNLXT
	rEVebgyPa/zhGAoig63q8WJKSVZ2hKWBmr/pAVwtAa1p7//EXUaA0TN9Tw6JaqAIX0lq3QPTl9g
	BC6nxkCvPUTSllCW419Kc5p7RRzgcpUQ57385VcVDAMUG2i2k4Y5TtYukPfG92VQ/h3m+4LtUra
	xZNJTPsAZcHJE0XqwXmenGtMzuy8ttZre7ZbEWJwuGDjm+3BgtAS9CwyhDP0zqIvDhHXvf/hcWw
	vR38v24CsQwlbeiqfnEp/AiGvbquUs3LYp/EmzOdOue8TxBx6HkxX4fP4BPTvHOrKIU0tDHme0r
	ngccZ1XKZ9X0kWKQ==
X-Received: by 2002:a05:6102:f8a:b0:729:3df2:1aa0 with SMTP id ada2fe7eead31-74d5fdd6122mr2499713137.17.1784833860785;
        Thu, 23 Jul 2026 12:11:00 -0700 (PDT)
X-Received: by 2002:a05:6102:f8a:b0:729:3df2:1aa0 with SMTP id ada2fe7eead31-74d5fdd6122mr2499687137.17.1784833860300;
        Thu, 23 Jul 2026 12:11:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6d558casm10653751fa.35.2026.07.23.12.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:10:57 -0700 (PDT)
Date: Thu, 23 Jul 2026 22:10:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com
Subject: Re: [PATCH 3/3] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
Message-ID: <x7cbergf7m3jyhvgjatscbznferq24tfb4gvzinqvnn7morvkg@3jnmaarqwh2t>
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
 <20260723-rb3-industrial-bt-uart-v1-3-3c8e580c09d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-3-3c8e580c09d1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JnkUF_gUc5rzPipf6hWuUpeFiK3Elh5_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfXwd3M7+b60azn
 kwrMH+U4VHhNtmvOud/nqqJl5qufBCFWhc2YM6/fivU9P855GAA3HGm4Nyj2NJsUD+QYOsk8OHP
 z0ehn/V+uOnAExB2an83CSoQVqIBHHs=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a626745 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=19QfC_L9TYtDCd6GSmkA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: JnkUF_gUc5rzPipf6hWuUpeFiK3Elh5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfX9CI0mLGHliWa
 Y2aGpsmMyCsngnqhm0w2Tt1qtHDHRyvk702TDt7jn2ey+5JUJvq5QKQFX4j/G1uc0rfpGGiYZIi
 uI3gz5qMUSzK2VDspM8oXwh96Lrboddy7QQJUBgIq1PUeUOeU3gYtf4sDlIu36h5SnU9SPlORSC
 MjUUVpW6mMnyTIjknRCYAnXGs91KczGhbBNWHcLhmYGF4BsZggjOohD4wVchQb1CwQE8nbMBySF
 DP/Z7EhRgc7BwyH2qy9KWUAxi7dNHVVeJiGcJzTAIEAUSOids2SybixQtTZ3hy/QQbC5NXPOOyK
 r86dCIITIYA47NIoSsGTrIXd9TPzYBcjDi8uvtYSXS1UuCLQDo+3HiPYrarfOSKwyA0/HxDxarr
 lDq6l97A8gWMUOcS0/5qB+vIF//ukJG+kycIFqFGIQQU369ruIxmVL1vAgXDuG1ZsV7fGv0YhOK
 AxBMr/RMYtIxyTM9vrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230186

On Thu, Jul 23, 2026 at 06:01:09PM +0530, Rahul Samana wrote:
> Add an overlay for the RB3 Gen 2 Industrial mezzanine variant that routes
> QCC2072 Bluetooth over UART4 and models the M.2 E-key connector graph
> endpoints for PCIe and UART.
> 
> The default Industrial mezzanine overlay describes the common mezzanine
> hardware. Build this variant by applying the common Industrial mezzanine
> overlay first, followed by the BT UART overlay, because the reworked board
> keeps the common mezzanine description and only changes the Bluetooth
> transport routing.
> 
> The overlay also disables the on-board WCN6750 PMU and UART7 path so the
> M.2 QCC2072 Bluetooth controller can be used instead.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   2 +
>  ...s6490-rb3gen2-industrial-mezzanine-bt-uart.dtso | 133 +++++++++++++++++++++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6f33c4e2f09c..45786d3db14a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -179,8 +179,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>  
>  qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
>  qcs6490-rb3gen2-industrial-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo
> +qcs6490-rb3gen2-industrial-mezzanine-bt-uart-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtbo
>  
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-industrial-mezzanine.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-thundercomm-minipc-g1iot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-thundercomm-rubikpi3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso
> new file mode 100644
> index 000000000000..06560df0a719
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-uart.dtso
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +&{/} {
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_WCN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		regulator-boot-on;
> +	};
> +
> +	m2_e_connector: m2-e-connector {

Kill unused labels. Everywhere.

> +		compatible = "pcie-m2-e-connector";
> +		vpcie3v3-supply = <&vreg_wcn_3p3>;
> +
> +		m2_e_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				m2_e_pcie_ep: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&pcie0_m2_e_ep>;
> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				m2_e_uart_ep: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&uart4_m2_e_ep>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&qup_uart4_cts {
> +	bias-bus-hold;
> +};
> +
> +&qup_uart4_rts {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&qup_uart4_rx {
> +	bias-pull-up;
> +};
> +
> +&qup_uart4_tx {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&tlmm {
> +	qup_uart4_sleep_cts: qup-uart4-sleep-cts-state {
> +		pins = "gpio16";
> +		function = "gpio";
> +		bias-bus-hold;
> +	};
> +
> +	qup_uart4_sleep_rts: qup-uart4-sleep-rts-state {
> +		pins = "gpio17";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +
> +	qup_uart4_sleep_tx: qup-uart4-sleep-tx-state {
> +		pins = "gpio18";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	qup_uart4_sleep_rx: qup-uart4-sleep-rx-state {
> +		pins = "gpio19";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +};
> +
> +&pcie0_port {
> +	pcie@0,0 {
> +		pcie@2,0 {
> +			port {

The house that Jack built. Don't use multiple nested nodes to patch it.
The node might go away and nobody will notice it. Add a label to the
exact location and patch only it.

> +				pcie0_m2_e_ep: endpoint {
> +					remote-endpoint = <&m2_e_pcie_ep>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&uart4 {
> +	status = "okay";
> +	/delete-property/ interrupts;
> +	interrupts-extended = <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart4_sleep_cts>, <&qup_uart4_sleep_rts>,
> +		    <&qup_uart4_sleep_tx>, <&qup_uart4_sleep_rx>;
> +
> +	port {
> +		uart4_m2_e_ep: endpoint {
> +			remote-endpoint = <&m2_e_uart_ep>;
> +		};
> +	};
> +};
> +
> +&uart7 {
> +	status = "disabled";
> +};
> +
> +&{/wcn6750-pmu} {

label

> +	status = "disabled";
> +};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
