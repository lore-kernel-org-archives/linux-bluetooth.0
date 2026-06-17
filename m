Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190613F7873
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693192; cv=none; b=H46iFyd1WdynzO6HTsLuXGEspAE0QXffQzVTjnGBAn5yQItR1wPwpDQw5OFWafWwDekwzFFeSimDnW2fRnWnh3BtKV+GHICXJqEHfV5ojYkxsiPbcs0+srKJWTSMvXuVAoruEM8UEBkFK8aTFOoqa/2JwMoeeUNJpz31yccdhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693192; c=relaxed/simple;
	bh=tkAEUA5OxX3j3Lit/V6dTiJdu6f/BbYFwiY/RkMX5zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muQw5SwVZ1qfaVQgIjSEOhVSYJy9sM5Phr7MS5F6mVtLtkKboDunnS3X01q3O2YHM1FE7WuX/sILevLXbwJZrN8wBQz0p+4I11kUKyKjUhNtRNMkSz7h+ImaAdVKzfHANRXcfc5Sx9KIay55ijMTZofQ4I+iCPPyV+xJmLb84Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTFUW6Sy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j5THNKr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTFUW6Sy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j5THNKr/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HAjn6O2579261
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=; b=NTFUW6SyPyQlqpM0
	eRxetGpx0Bey2F8789sepoc5vGnzV3R7Dx7+FLDnTuOdjBPHhnNsgZB+7JD1TEu8
	GJlwJZN60NLoam4a7RpEGEE3ZgNyvQdrVnDvtkQ/rLidMlK4BctBb205w1lES0w/
	d4dtfR49OdnB4Qrljw66h+jbl8dPlP2vF7+gAiaJ5uNrucDP5YAVbouxWcOcmEKc
	GUKQmtHrZe0TC3bbL1QxAA/+ZlZ5V7ydPoqgzL4AyHu3WcWbEXSM9u+S0HYm7S/8
	EolR3DNKQU13xdeYJaupj0N9vZ+PzsyZQixtsJZQgqfuMJaqEZGtfpg295t97tXr
	ZvG+Ew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2as6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5178ac43d27so14451091cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781693189; x=1782297989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=;
        b=j5THNKr/wpOMaBJpNdFHoIbp8FoL8NXXaLN9mNfkOSUbw9ZWWoEwoVb0E8yS6+K0CC
         kLbny9kdieYkp434bKmssmr4sqY8YTkrjrCF6hDXO1CEiUtQuicgu43dNpmC1MO4Qvq4
         PSaTpkylN6ooXTEJ+Co6EmhQsxsDLD3/KphpNm4GiOSJENxT2N4sxyyz7cwVV7IwWTmz
         xwXBSUfylcOKW6HyPFHESKUy4b6ummFMaPqskoXrv+FmWOOo+5C+grEEAz+ab+IIrF6v
         WUZbaiKjk1oif2Znq+SdwSto4JwUDxn8Jin7x+PoAV5rPBAJFxbM1OejBeATdnfDh49E
         3DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693189; x=1782297989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=;
        b=KSk/divmgjK233sWMZUYJhDSydvLXQ+4CiwN4k2KG6wn3x4MrTgCqy+OjmVRX+WsQU
         0Il0P6v6LNo/mxtMrA4MJxnJMfgP1wSayeGgqo6HZCdxp7yZ8Ipc+m7EcKdgn/7AOV1q
         dr8ySIajBOrXhQeYqfRVU0OP7G4fyG4Lz6vxIdcMTG6B5GZ/siGlnF7XgkAH6AHh4umi
         9rOIS9MPmwDZRpehg4MBmDwZqYJgkIQRjtgBN+vpz9wB/BT6SApz3htyyYBZVgdHJin8
         bG8ZYfcc65SJ3FcgtspviMKVYd+hfW3aYqK1Q+8UkTeTQEur8o/ChvYLBjXR/Q7P4R+G
         mHgA==
X-Forwarded-Encrypted: i=1; AFNElJ9i1NfH0ozremIaHYQKH4xcIXlqqhRvRgK2GacdC6KpLVTD3Xs+0q58AZf6mJMYqdc5wX7BwobRm2PtJ0OXLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGW0Fh0pILw/z5r98/gJ12/PPxqN6YEPVzuMkA4zOpiFZOh4C
	w3JZp7RmHoXjw3gBUvAJOxPEhdQ5cg8DYFDY33FzkFUfFsx6RLY1LLKu7c6UVv+WyV8wIkvZDq6
	XOgIaIc2jMMU7QMTqdY+YdU6Pss49+6Gx3XKFElhj1g4fqWCL6HzPphiVcU0EFksvC2H1awg=
X-Gm-Gg: Acq92OEydNP7XhRuaZ6zeT1vaEiSexlfIv8+x4BoUgz+UwSJBqHbWIaW2bfhHXXwaq5
	PT22z77489cEJBEB1f2clTbGnscO16BzISbNbjj5d97CLXBxrdi+H+TFbbCFRm8eCRoRwj/ZNY1
	CEa9XjdsvIje3NqEVPhK7IVGxgt/KqEwvsb1njY6Utiz2Tjo+VYjQmetWbMntOEjWyCWLKqQaJu
	PPon2BWtMNNUex/udAtQbGFyrARf5SMSSN2zBAYd3IMQQ1MS0tZzGwzujYdvrQgEb5vBqs+T+r1
	lrg3PNEjF/MR8Pzo23Bf7brILT47/BkiISS8i6yYKGY+9U8pvMFU2LAah2HsUKzK1rsgsApxbnh
	MQb01ZtppVDQVhfmixYPqA4/e56kCU55/E4s=
X-Received: by 2002:a05:620a:c4d:b0:916:10f6:765e with SMTP id af79cd13be357-91dbc5298c0mr258843285a.6.1781693189456;
        Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:916:10f6:765e with SMTP id af79cd13be357-91dbc5298c0mr258839885a.6.1781693189023;
        Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937948ddfcsm6244840a12.21.2026.06.17.03.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:46:28 -0700 (PDT)
Message-ID: <7b5c713c-e00c-410c-968e-56b9f487211b@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
 <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
 <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a327b06 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KWhx9lE1SZ_w_DgzBjgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX6p7tJux/XvTX
 hkZqPGNVPs+Fe4OW5b5QJZdXkGt7rK1fSlNhLWD+BP067aLL2chcWcH1TKWl2y1FeGP6AyQvEbe
 XBvPTIb/dvfiRSuNSyCOzXl8yanZSHs=
X-Proofpoint-GUID: mlwxAZ0rflSEu5OwAwAaGC3Ghh0_Dh3E
X-Proofpoint-ORIG-GUID: mlwxAZ0rflSEu5OwAwAaGC3Ghh0_Dh3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX9QzdZXlo9BWn
 X8H5VmueJig1MAWLJBc/G8h9twp8O5TXtRs4TIp/TRQaTvHHWiM0cgd4+hOisitiGGnFz5g6q+I
 ZuFQRhRzhKQzJ39plbbs8d8a5hG7H+U9uxq5p2uiu2GSOXzIF9DMlPTVALE1Je13qMpnKwHId9l
 1TKz4fRDpNUtpJZxX/msnKXVvcEXd7KN0HemBX9GZ3ea8aVG6ecZMWli16Z7xCyzdCLXRbpgxNE
 sMtvFklpuvTJHDao90sAstm0mlgLo0IYyZIzFbj/idKe5SzUzlCYEuduuKwiPU33Mkj7mNXfGAy
 Jcg0a2th2lUp3O6/yArHuZCSkhHN2faLJNY8BqtvnSzGBVaoOCZMGaxwGCEHEfy+p2mjInaLZlA
 L8RpAyVBKo308F3gNPWI8RwxG+pEgCdnIi0keXIMnEKuAk2ouKLyX1kwj7QPsNfZZED1mTffEfZ
 M4KuEkCMaZeOsmlpNzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170101

On 6/11/26 9:44 PM, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 02:09:27PM +0200, Konrad Dybcio wrote:
>> On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
>>> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
>>> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
>>> parts of the device.
>>
>> [...]
>>
>>> +	wcn6855-pmu {
>>> +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
>>> +
>>> +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
>>> +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
>>> +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		vddio-supply = <&vreg_s10b_1p8>;
>>> +		vddaon-supply = <&vreg_s11b_0p95>;
>>> +		vddpmu-supply = <&vreg_s11b_0p95>;
>>> +		vddpmumx-supply = <&vreg_s2e_0p85>;
>>> +		vddpmucx-supply = <&vreg_s11b_0p95>;
>>> +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
>>> +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
>>> +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
>>> +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
>>> +		vddpcie1p9-supply = <&vreg_s1c_1p86>;
>>
>> [...]
>>
>>> @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
>>>  			regulator-name = "vreg_l7e_2p8";
>>>  			regulator-min-microvolt = <2800000>;
>>>  			regulator-max-microvolt = <2800000>;
>>> +
>>> +			/*
>>> +			 * This is used by the RF front-end for which there is
>>> +			 * no way to represent it in DT (yet?).
>>> +			 */
>>> +			regulator-boot-on;
>>> +			regulator-always-on;
>>
>> msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
>> perhaps?) - what is its actual use?
> 
> WiFI/BT RF front-end, a separate chip containing amplifiers, couplers,
> etc.
> 
> It is a separate chip (or a module), it is not powered on by the PMU,
> etc.

Ah, that thing.. yeah I don't really know. Although it'd be a shame to
keep it powered forever, so maybe one day someone will revisit this

Konrad
