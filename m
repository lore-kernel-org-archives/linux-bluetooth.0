Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08023E44E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179775; cv=none; b=GR+0yWOLJ7pypw4im7R9iOyBTgJirorbImnKiKqxRvF1WPZBhqN39eWSHI6w1MNO/kLEAmeCUBHNr8hBZa42dngAqF9A2RwpPPOfu1lqWyFoxW61297o9WkhUMw00qHuvs6pb3f3KRLR2L89FJfWOqB6RiO7fE9yUyyzgmHm1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179775; c=relaxed/simple;
	bh=PvuQ0Mdk6NxDmi0CVM4MzXjDM2sWs1KzMrzzbVZ/HAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW8feVrqYb76jcS6wK7NZB/1HBF9q85OXQhiM+vsHIVxhi2GdnKdUGLrbHCekF54rYVQIHkt9/N1u01uW8Y2MKe6TkEybkaUOPda7aCJ2onebh3d8Jte0Y3JNXzDHaE3ZGVPQrwPB0h9/1QsEn4GJUaEnIzjZglebxdIfLHAu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fX+52gJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1QFzKHO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fX+52gJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1QFzKHO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA1160299664
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=; b=fX+52gJamw398GVK
	gyubigFeKdi3+9/GX+7kBBj6HY42+3HdRKhPsu9mXy5dbUXS90EJqjsSHDC3G8CC
	ujFt7Rt0wqppB+I402QBxcq3vY6l3hU4eZmp4tlXDqXI3o46pazyIElutRHRxWLJ
	aEgj3/0kX0o5BsLwO/PzMC5X2dBUcJhBZI3XcbFvhnMqDvi5OELS82WE6F5sH6hI
	hYNgSUlZlUqqSTneeKkl00PR+tpsBSZNrbtsjmaeyjjYMC7MqNVdmDXHOXFSbqgD
	///S7kA36MeheAERQvf+Mhsvk4jn96lMD7qFNpb2p9Ce9BLpMN2HwqV1Y3COO66A
	0wy0GQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe7038yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:09:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51768e1d798so20119671cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179772; x=1781784572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=;
        b=G1QFzKHO+FbmtnEAl3cgJ0RO5AAC8b4riE04qiEmvuCy5IpV7zXK0ZRH1B6XG7pW9p
         9nguGU+sAwb6S6Y++D77HeQ1TX9QZQ9l325y4Q8dw+gg76TVEnKku4csMaVGGbGLWG3z
         f9RVhD7CHTy3UmgVnhfR9uwru76L8d7IGXM/6uvKB8CvsUZOn1h1KWX4v42fKyXD/hja
         XWXpj48cVsJfpQBx4sSbQ4HGcyWAV6cJoYb3QRHYBJ3dAR7fIlih4CNZiZkF69hBgqZH
         m7r3SyqbdKwN28l7gQDNfP6vWl71VvQccVcMGjOuxrOfMRJE/HSI9pWkvHGxDYt50sBP
         s4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179772; x=1781784572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=;
        b=br24McOjqyo915N79LdLtHjj4cMbwy/4rEKmYMu90QwJo4DREPMedacWfu/JQweInF
         PP9b+iECj0QyJwpoyaSQ/6H6J5p0/4UevRX5r98VcLT9aAguuDciBubpXM5I8T2wGIfO
         /obo8ye0/60etsg6rdskzJx/niRnEf9Q5jqROmc4VOLVHHExRCbStC1P6ryW5wN17mjK
         eC7bQXSYMMeTu+7Wg768ptcfov5kfO/CPdSU15FYoKWed5qRbIw+YA4rMTTaxH0IqRrJ
         EOZeOmPufigHd4wJ0cD5ulv0taVcaXXwBYD6dtsPF4UOFC8m05Wx1NvG9s7p0ojo8ZH5
         aViA==
X-Forwarded-Encrypted: i=1; AFNElJ+CnCcyxaA2A5q8Lx7j+G2tBt0tJCIMSix7lZz9AsR82k9pUZ8Gvx+8LGVZsJnxiER/oEHxLI8SUDnADB8M8eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbXwwhoA7PJeaUzUhDco5SMAzUdE7ukulyXFdlMj+EO5J8p4t
	zB7oLqcV0xnW0xjs8fZErzldSBtTFdEKoZbMVparLRM9I/eT4rov1hz3bTkIR16cIyiX+PRLDzj
	xovw2F6oqNRNe4mldWeDjmb0Tb/t79PvhqoDDzf90asLsWc1dZRXyEn7ZpBmeo+uguXJB+1Y=
X-Gm-Gg: Acq92OFzBsHR7INMq6L7ipbTpzBjGeoJkYqlPoLtGlkCj81u1OA8gcrhIJ+FU3FDy0Q
	rp36TPYNWzHdbByJnstCWsU3bVscib6u2zzIZ76oRCwgisuvHaFzXuZPK7XGdbaTY2E3bLpK3Ez
	D7hevufxD1X9roFYdyOmRRB0K2aiaibJei/JjLn1Um32id+IYBsguBqq6xA6EcQLrBtp6w26g3W
	dJ2JURrTW28sJ53N52JRvD6M+VFF7JKBoH6z2uGt6YDsCMNDgK0DqSVfLfSrcDOMjzRiHUy76ED
	CwPJ6GtF+CqJXVqbYQTanrziQ9o+fc2kkFMtJte/mMbZDX0jkRQVmwR2PDtgcuCV+kSS/VjUVmY
	X1Kn9HqklB40CmmGjHyaUcr5/1V/RBbbNGF5/nyNd7XNWcitLeS603wv8
X-Received: by 2002:a05:622a:1449:b0:517:8999:6c4b with SMTP id d75a77b69052e-517ee262f43mr23989041cf.7.1781179771923;
        Thu, 11 Jun 2026 05:09:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1449:b0:517:8999:6c4b with SMTP id d75a77b69052e-517ee262f43mr23988691cf.7.1781179771522;
        Thu, 11 Jun 2026 05:09:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb60ae379sm56540366b.50.2026.06.11.05.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:09:30 -0700 (PDT)
Message-ID: <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mTPT1SxEIOBF-hdQ9jSEF2raNiDUyLPx
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2aa57c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VQxyErZXnhhA2ehoMNgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMiBTYWx0ZWRfX7/q/zOFNOYPV
 zijJJurXV8GvqJWWHeeaS2fXHGVrLc42Ij/q9X2/B44+4MbdRY74a5jkp6Joqs7unPalZkkTgyp
 2CNv3+DJX8ogvd1mMVK3x2C6/KG084eaYn/xTGXW5fCQ2SzaUM2W9s6PAWZaNllf2v56pMdPdep
 a6JYqzCrKnsxn6aB4cM8poczc8c1iQhuffkZGy0b07BHR1N8vQOAIl5H0SRu/ppn18TVUXRgknE
 CMdgzpYnanGH3+/LZS3oRkoVHnWhtFxi7hIPenvtj5D5O/Uc1oLb4kRtcFcOjalF/heXL75ETlL
 nXMTLzcz7QcPQBDECHvv3RoAzdTPz1Jw7nz03aMMvlIM+S4SmrT2Un3G5DMiZp+o1geruYO2mnz
 KW1xzUA6dEsSUoiSmfyQ5MTdgjnCfKfP5QLa0/wvDxcXWZWsgjg24tbTAvJI0hDyO8PcLxuZvKk
 VFNYg062NaTcTzdLB9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMiBTYWx0ZWRfXyr0+UW5Fcbt5
 fj9BLF9iHmoLM7YeMm0kpRx0Rj1gXWtycaf5JkSUI4TSRR8e2nnCWbgdQa3QX7tM2ysD7pwBwt+
 a0E29YBboCDxljlOeGxCr4+MeprwsXs=
X-Proofpoint-ORIG-GUID: mTPT1SxEIOBF-hdQ9jSEF2raNiDUyLPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110122

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> parts of the device.

[...]

> +	wcn6855-pmu {
> +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
> +
> +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
> +		pinctrl-names = "default";
> +
> +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
> +
> +		vddio-supply = <&vreg_s10b_1p8>;
> +		vddaon-supply = <&vreg_s11b_0p95>;
> +		vddpmu-supply = <&vreg_s11b_0p95>;
> +		vddpmumx-supply = <&vreg_s2e_0p85>;
> +		vddpmucx-supply = <&vreg_s11b_0p95>;
> +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
> +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
> +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
> +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
> +		vddpcie1p9-supply = <&vreg_s1c_1p86>;

[...]

> @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
>  			regulator-name = "vreg_l7e_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <2800000>;
> +
> +			/*
> +			 * This is used by the RF front-end for which there is
> +			 * no way to represent it in DT (yet?).
> +			 */
> +			regulator-boot-on;
> +			regulator-always-on;

msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
perhaps?) - what is its actual use?

Konrad
