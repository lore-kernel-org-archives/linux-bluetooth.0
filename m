Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AD222560
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183398; cv=none; b=o6K2y00AOfoBwyEHZD4b0FnMmG9vBqONeoPmMIYzrKVQCr//haOxsTsclw1R2BOZ7FLQm53ELjoyH1km/1r6LXMxpprrTDXiXFE6ET3JgBv+P7jPsm7oynDb0sI9lurJpPzY1SGEUXMMM3wAUBfbZX0rce+N++9R6Wjx76ET5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183398; c=relaxed/simple;
	bh=MR3AmbLZ5anPbDIh6appxGPnZYKMJT7zJ1pCI1xBgTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrmBUTkYbzSbfIv87vvlXKZLfrFe4stv6eBOcIO46XpF74ATbRMgAvq8qozKUY+8d/faAO2L9Gw4Qe7pDs/qnvnKAg/YuagJvKCd1oQ5sNwiyd6O6QAUya2/kHcNf5moTc+Osf1nitkCeFFMEc5FZdFBhkhC4UqQ1YnoJgQMlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RMabYfAV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W7dXQZHv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RMabYfAV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W7dXQZHv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV674MB3540739
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=; b=RMabYfAVrgVgQTB5
	9jkiNcMhmfzvt1CSh7z1Axyb6mW+0bqqcmtggZmOWYa/utb+nWBPPsiZ7xcHC327
	XbHmlAJ/MnA2N+K2RSc1OLJbAcdzUnqnNtlhsKJmRdQZohVdBVlQLeYG7JsOQetd
	gFmqFGsn0Haa09YG2izW2il4W5EWV16fZ0OQVE05W2INkTTk8zhl5nKDVWEn2TCv
	pDOdCFr9gHNXeoY7OiC0kN/qXK4n99UXuQed2k/0MHBkag76J9zPouNUtPpjgMnH
	N/ckmQpVkhrT+Ny1VlqviW1zz93M7GiMRg9ZadfFmFxABY+Ylh1G5fuETJJg4LlX
	SvZk/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc88ykgue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ede0bd2154so34276531cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183395; x=1767788195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=;
        b=W7dXQZHvmYzBFuZF4NQ5uhFsFkvCPaIbPzbRF7J0CDUoMKmRvfbQp0oYnFI5OxXZpw
         i7rePM67lZfoLB00AVtQaBnkqFkDsXhIG5x9OlYxrpS4SF01HixeWTID2PBipPOdf7EJ
         MMivgsoCKKXaX0eHaEDGre+Z/QqeEHf+6ptQsZXqszdKbX8DXS85MMZIqL1JAUUpdR7Y
         u39Ac53l/3Dp2SETqT2dREFNwkaUgLRZ6gMcjRE6OtgXwsuQbmt21QjG4mev2qreuDT/
         lVQMIwpgv3SM+EC68TcJKPMj+LqJZ607miNgeIUGQ1gyb9f5J3yuDipfleWyfYbY39/o
         L2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183395; x=1767788195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=;
        b=KebnDK1Ga9kq4llC7H2qPAgQ44BVn5SIf3KRHHrwG/wqLNrIHUVaV2YtqfBoeLbkWy
         c/9LSlolIZMEwAieRB5hScyVMLl1+Y0Rbzcynn+TBXkbNMifb9uNuxSX0V6TKh2nKidf
         s8tFrt17E1JXkqZUMGN4p/Y7G+HpXwbgae8pkXVWBO0MhaeI2CN1/fly/CCc+TYyJqru
         ZRekKlSW0sy/dlNkHrKcyLxPfxB14S23EDtJB9I52uXWjOFX8G+YmKXHjsNvjnTsnIId
         9as4DbMOhin/4q+VuZCC+C4DjV9ayLoa7kDCEkA56+hrQV9SXLRSYRtWPeecfw9rFTRE
         GoIA==
X-Forwarded-Encrypted: i=1; AJvYcCXizFrgmRJ+UaJbAEr51FEVbjWMepMLb2ymNPar9QdSl8TX5xEFRT31nrZjKUC6Ph3nyqBfxXb0IOs11IPPPCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQP/88ED5baj9SC6VyuxqalDL20yuBQ67S7DMaBDKSGU0Mp3pM
	/XB8yiAb3Ksx4h54iM+mUNXGdtXLirhqsaq182K0E4t0OmYowdpCKhO/ee4PVSkVQIDIMQ5Ok3P
	SoJmEd5ZyMHubIlWqCenI/O48uvASm92V1ZZ0W5KQpkjzsmoiVOQmIyyK5wFaeh20vHAp5G8=
X-Gm-Gg: AY/fxX5a1Qv2HYTf01tV+TRXxGech6JLV10orE+mRH2zdw11ga083aLcHuU2RGoKe+U
	Xidf7uw8ufnuT14zkwMdiyoPAaQebDODOm7xG7h8ejFB6fOcO6u4Z5wN3wcN3P70lZHpmcJamvS
	/3MB7fzBfSdt0NP66bg3EfR1XA6bRFJ4kdJIf6Crn5O7Z05eA5TG3ZM8+g6G2r653acVJgKnV/p
	cQB5DH7E2DAYAmU51m9RMwjjrFQCj7ZGw2TNV9GoAvDO7x93POfD54l20wShTkQIFEmmHVl4kXf
	3vpIXzm2KE4Lxu7ROg++7TbVGj9qIFNSWpuaxVgNpZcAbUoOTecuKS02essK2cIAj//juSRcqKe
	zCPgbpn1ThcEQDmUPMUBZ4VpSc1kjfdeH7jeIadGgSQuuLRie+WBGNbRPGZ4va2aH0g==
X-Received: by 2002:ac8:5a46:0:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4f4abce1a3cmr428476691cf.1.1767183395141;
        Wed, 31 Dec 2025 04:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Pfwh+egtxUj/QdUbBygykdOyCe3AD9kpBY9v2ldni3kiCg/sIQlD059WEMSwkll6E6T/RQ==
X-Received: by 2002:ac8:5a46:0:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4f4abce1a3cmr428476301cf.1.1767183394596;
        Wed, 31 Dec 2025 04:16:34 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdf3sm3954791866b.12.2025.12.31.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:16:34 -0800 (PST)
Message-ID: <59f3db15-77f1-42eb-97e1-31129fdf363d@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POcCOPqC c=1 sm=1 tr=0 ts=69551424 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=83yv27ILqWWRH8MFNrwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: eY_W6kJL2gJx9j92J5lRrFCcds5aiaZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX0rLr3bOX/VNt
 6/npogX3rflrCkTIC7ui5MxcNHso7Txj4bRTzXAoto3+lGHBUDdPHw3vUQ3A8a/SJbRqCbK6yPw
 xm3+5Zhf4LSetI4N7AbAuiqgTeEFQKxHCwR4RRxesv4mTU00923U8fjlGuaBI0keAtnwi4U05xP
 C4zRAAe/eYY0v8vKIzKSYzDHj1XnAjuyVau2Un8l7PrDBSpz7+7oNNbfWQvP5+3SkupMbzABG6a
 l15pPmGCctglHo9LYtu7wqQAnqRv7wzgQZaJCCQ3fdQ6M8cYBHSsDYGRqfcN6UiIFdMGw2oo+bV
 t/A7nS/K0SdFjSk0kHwn4Istc1fzINqWFlB6jqjJTDppw7BqyVNahILfo6VaaHoFsaI3Idz7vCF
 qgtPHPuDokuLbJ39/YnFSGyfKqFMlwHD7r9Jp0ZA/iHpeFL+bYtJW/5mWLfvJfeXWTuJ2BKVLoY
 aBTRsIhjwbPFGJXw3cA==
X-Proofpoint-GUID: eY_W6kJL2gJx9j92J5lRrFCcds5aiaZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> Properly describe the PMU present as a part of the onboard WCN3998
> WiFi/BT chip. Enable Bluetooth part of the chip too.

[...]

> +	wcn3998-pmu {
> +		compatible = "qcom,wcn3998-pmu";
> +
> +		pinctrl-0 = <&sw_ctrl_default>;
> +		pinctrl-names = "default";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrfa1p3-supply = <&vreg_l2c_1p3>;
> +		vddch0-supply = <&vreg_l11c_3p3>;
> +		vddch1-supply = <&vreg_l10c_3p3>;

Again, please double-check - I see UFS VCC is on this line too and I
would guesstimate that antenna supplies may be separate

Konrad
