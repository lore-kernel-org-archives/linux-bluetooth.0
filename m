Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585837107C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072867; cv=none; b=adYQ3YQLesun9DOHm0DvdfuhXuxLJ9trEZgcts4rXXNjb5TbS4P3vUNuAni+IKYyOsh6KhiYhtGJj5oTx5zbRuStEexBZQR4m7y191TVxlKf1GnBiQ6MNpCyzj6X+grKnx5O6nXksHRQ9ra/T4s5fODLMm7eNewHMjdZV5A0Tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072867; c=relaxed/simple;
	bh=0afPbzTRb3UPGydEkttEYkJyawIuXJ1ku2cfpqMLNy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD8nMCUfknWrC6bwTuXauiZsXACcyLFeadHZwMWd6OmXlpu+YpunaueGhJubyV3WptWO8waRLytX8eZkeUPDS1sWEGOMvgjYxjjII6JpuYwGbwjAWMuaB+IZNCHkg5c7FBXiz8t/X880SsWzWnAOiPmolvzIpHrjbVcf+XDfm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MY352vsT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZWUpUo+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MY352vsT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZWUpUo+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PGkiDV3633021
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 02:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yRgG+FSy5Tv9HXEJSby1T5Gf
	NUrd7SZUPbnRQ5PAy5U=; b=MY352vsTQhdJvcTEh6Eh/mzsrHY39PG/NyHIAolm
	K4I6y/8tRwhHatN9zH1LB+NFfKmi11z8ggdpkMQdZGQBDgfKRm/01FB+HxwmRBsr
	HBamh4dGt+dK5qT34cmpseMbvA9Ake7DdqHamUx4We640yAR3NZNqjCqZllEbOS6
	NI2uBzdGBpHD5Gu5l1A/YTa9CJwAdKa4m/zSav8QIUGNrMxzlsW3m7cxbrtcCqTG
	Y5LCOfN9KLSB5rQbVL507UQzi9ls6fwKpBvDwE7JoGb+WHX1/Ul8GV6y9EvBUCtc
	bkSOTqzYmqP/u9+u3Y2PWqxlNgr/rOLYWLuySs6lOX3chw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj4w4shmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 02:27:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ef98116so256986885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 18:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772072864; x=1772677664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRgG+FSy5Tv9HXEJSby1T5GfNUrd7SZUPbnRQ5PAy5U=;
        b=aZWUpUo+pNQVq/6lHLzI457l3cNosA6Sc4/9UUZo/Grf8THKAJ5786m9Adj0MzeQLH
         Xuu0dQeKzg3f2VLx220GKnDDnHRTk2kkiTePUDBxrWc6f07wpqlxhicOKj8Z3kh/msqw
         I8sYkUG/AVPU/qnvAkQe44NQtZDtzqYfQOkAj1qQjxmzg1n8UoJVip5rvI/0nGvF72xl
         QerftDx3HVzeBEVP0mC0gdh37SxVLdrelhTQjF+Ty52IsKDsH+JMkxQBKDiEowt1+gF0
         SKyvrKIYGM8Balk2sNVobJIUUMAb0xokfsNRgZjcye99+F+qK7qCntBdgrHQKuzbsVc2
         IECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772072864; x=1772677664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRgG+FSy5Tv9HXEJSby1T5GfNUrd7SZUPbnRQ5PAy5U=;
        b=wYuXAsarQAirpUpHmteu703sHkVCuUXM4b7nWJKjTYplQjOYbBlXF7Sz0Qm4LStuVu
         ydrw+3MCOlIOoXRLQ8LEnJxXek1fKhyPeV23JBszSxS2PVZcs8lTrpZV0aKEzEAJM7xx
         5+Hy0mwRa2Dof/ENxSfSsogNTbk4m5mDffxunErFPOpv2QtI9mEH54jxmrd73j1+rXHp
         BI/E1eqJF/3SGp0m/Tyqyd0zEZWoI7NVTWXibau0fAnFtiOW8t/71dak6R8wo+cSVzcv
         aT1xGxWhw+YJjZrjd6zrxcdPjjqTdhz5GDdPTRfnkbA8biiHgCcBnMpiCfz/VD7IF41v
         82yg==
X-Forwarded-Encrypted: i=1; AJvYcCWfLTbviRB31Gjr3AnwBApR73mO63IOMhgqoAdlQyXlW3p1wmksvIC9o1yGigFRTHIDNQ0FQCp9/LPlTSgOxAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/2dSgIFf326obIWTVqFupIKKlR+LUQJIDovt2/ojIFNCRwBp
	6rBzVqcyddt+EUS3cZgjuaHDonM4ZBnd2Z8LXClvkgE0hWZD4HPE2xyQogpUA1Oxn0Rin56K8j2
	rG6OTULYnQIbRKNmTlUyWqrVFfROmTcmOMN+5aPIN/SrRPfj3jjbk6gPBkqJXz/LGr9mFPi0=
X-Gm-Gg: ATEYQzwizZlE+tOSYLXi6ijm1PVDTqFbrOUYqYm0hOicFEsIMddlvHALheGmG2kOo6V
	i1Y6N+dM3NgJJj19t0X8NLNz8wR7e40WMHHlyl+mdbu0MLvNcYltyb3zV7H10BEdZaezJBFRjo9
	d8EpItFRhBELHUfiW9KIkR627EMuExZbhty7jbK3jBCiXqxkSzNwJkemrv7jmmYZcINcVI2whwE
	22T+VNH1etpgvAOT+2Ly5555fiDJ7qrYcsGwb3Xzd+HBe62QoPtHGIVDMwVzuN6/i4j13ER5Ul4
	teYAiogywAIf3nWDjSjkAvG09XhwvI9KIiGlWfJt1Bico0Iqmxvz4DJ7C5UTqhl+r3d17HWCxff
	Ca3nrf8oV24BPhXLsEL8iKn7UgnK5N/Q+MJG+RdEUsd3NOjQCPwvCMcEM4Run0s8TJ8nion3IlF
	DDD7XOXCt2MPcg+CqHtpaxRK1eZ0Ub4Xlz3QQ=
X-Received: by 2002:a05:620a:1904:b0:8ca:110b:38cc with SMTP id af79cd13be357-8cb8ca0df13mr2240587185a.27.1772072864463;
        Wed, 25 Feb 2026 18:27:44 -0800 (PST)
X-Received: by 2002:a05:620a:1904:b0:8ca:110b:38cc with SMTP id af79cd13be357-8cb8ca0df13mr2240584685a.27.1772072863966;
        Wed, 25 Feb 2026 18:27:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f640f8sm1429571fa.18.2026.02.25.18.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 18:27:42 -0800 (PST)
Date: Thu, 26 Feb 2026 04:27:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
Message-ID: <xuhr6wicgyvc6f3ejq2qnhpb4wk25larvr5frivkwojkq5o3ny@pruh4twsloiu>
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rbPFbXUP2aTmB4toeBIY6ixMUfR8BdSg
X-Authority-Analysis: v=2.4 cv=IqMTsb/g c=1 sm=1 tr=0 ts=699fafa1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xdtaErPNZdlPjHlDlRYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAxOSBTYWx0ZWRfX9sIjADp0h+Ua
 thfGT87esHJkUuICIfnrt5rcCL0tVh2Icb3wBKPUJIcKOAIexN0tG6oEBnV+3z2Y3CHCAiIgD21
 Q+C9HXuT5QplBH4RM6wLvEEHp+7UO4dF28PcigMTIlZXwAan303194J7AdomxjgV62FDCJZWuqf
 YN+yEWjqQIu3EY0oL84aLw9GzIsu4pM46GWFUdFWg5Bwf66Vqhv8x8a23Stx9JPsD5UJ+VuqxH2
 KwQIfgPBcl9EEjBZobWngByDf3o8Odv+ElnKfFjWYmaasbJMCdRnWLAO2KgsIIS6ouMoYUQtIvA
 mYdRLj+voB9vz2gfdi0/cAf7tG/iJtjeIUjy5RWyGtz4Bf2JIK13c09jm4ZQip/HT+3IK3kOirO
 mO1S5jCnPWUBwIGpzSM8cjbTmfA5mdr61Wj8CbqEK48ZP6lLgpKBEKj46vMteCEpOWeqqDhpwpB
 C1L9gtIvyUEhKtftsVw==
X-Proofpoint-GUID: rbPFbXUP2aTmB4toeBIY6ixMUfR8BdSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260019

On Wed, Feb 25, 2026 at 02:47:00PM +0530, Wei Deng wrote:
> Enable BT on qcs8300-ride by adding a BT device tree node.
> 
> Since the platform uses the QCA6698 Bluetooth chip. While
> the QCA6698 shares the same IP core as the WCN6855, it has
> different RF components and RAM sizes, requiring new firmware
> files. Use the firmware-name property to specify the NVM and
> rampatch firmware to load.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> This patch depends on:
> - WLAN
> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
> 
> Changes in v3:
> - Rebase patches
> - Remove unintended 'output-low' from bt-en-state pinctrl
> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
> - Link to v2: https://lore.kernel.org/all/20251118140406.1551669-2-wei.deng@oss.qualcomm.com/
> 
> Changes for v2
> - Update commit message, add firmware name detail
> - Reorganize patchset
> - Link to v1: https://lore.kernel.org/all/20251113130942.2661069-1-wei.deng@oss.qualcomm.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 2ede6efd1afd..03c01ae630b4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -18,6 +18,7 @@ / {
>  	aliases {
>  		serial0 = &uart7;
>  		mmc0 = &sdhc_1;
> +		serial1 = &uart2;
>  	};
>  
>  	chosen {
> @@ -107,6 +108,7 @@ wcn6855-pmu {
>  		vddpcie1p3-supply = <&vreg_conn_1p35>;
>  		vddpcie1p9-supply = <&vreg_conn_1p95>;
>  
> +		bt-enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
>  		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
>  
>  		regulators {
> @@ -559,6 +561,12 @@ &sdhc_1 {
>  };
>  
>  &tlmm {
> +	bt_en_state: bt-en-state {
> +		pins = "gpio55";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +
>  	pcie0_default_state: pcie0-default-state {
>  		wake-pins {
>  			pins = "gpio0";
> @@ -633,6 +641,24 @@ wlan_en_state: wlan-en-state {
>  	};
>  };
>  
> +&uart2 {
> +	status = "okay";
> +	bluetooth: bluetooth {

Please add an empty line before the subnode.

> +		compatible = "qcom,wcn6855-bt";
> +		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
> +		max-speed = <3200000>;
> +
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
> +	};
> +};
> +
>  &uart7 {
>  	status = "okay";
>  };
> 
> base-commit: 7dff99b354601dd01829e1511711846e04340a69
> prerequisite-message-id: 20260122053624.4068718-1-wei.zhang@oss.qualcomm.com
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry
