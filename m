Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E127302CDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576736; cv=none; b=WujIx5q3l+OquqGrQGK7B8LsTl42dvjftHRyp5Nq3pMlGiH5pwytBOD3BiDVagveahGrRZyhcmTtP4Tn5dm5bhk4vTW3D+e40TFYkSagoz1beX5wDa+rauV25csTuAzNACuoXaE1wcissD13E4J0WvvS5kiCMaYlPknhcWN3t6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576736; c=relaxed/simple;
	bh=q/2i4QMctXHF+dDhlqSpXa8ULXx0wN8PBam97iLzyx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcRmVZVwcJIh0xrlTcKB7lkToRNroTgEGNimudtSRqBMaoMRchkqS3JL3bqEIhU6qMBDt1dxCpwQcC5MTUudvAyfPXfN7o8q1MJZwNCnArXX4MxGGk57b3EWKjdo5wN+3b9AmDeoHVa4t6fGrVQPymHMaMXCNTlfvV8qtuZDbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cVJjBioS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gRwka4On; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVJjBioS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gRwka4On"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G8F3WH3192399
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 15:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XRcRwBypFQShmuN0jEyzBJtIwf6t2aDrIBCTyHNhTLs=; b=cVJjBioSxB1YM+YY
	RD/27+OD87cRm4c4XZ/ogHSNFlOO8viEL7BYEuV7xyqP8RUVuydBEEiazoWosaUe
	9Abv8bYRdOhVrWCtF2SAgUfncEMV50B+RqA/TYTk7TPa2nncozkQjPgWi8bsgHWK
	GA/kB4+nGUz9VhuXS5IMarQHEA9f122rrrTy15vq4f/B1+/bF4zzDmwil/je60Gq
	Y2+HNvObXdlUfEpGAE3gA/TMANX1D/GWoQZ3pc5xOXrBgtUID1NGIp5GmV8CjGrE
	XvjYFnBZikD5fE4uSa11axV1i05KIGI6xwQCtNXpddTFis2V4APEtLy+qNe0opXt
	1+j1oA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq968jmxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 15:18:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b21d136010so3492370eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768576733; x=1769181533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRcRwBypFQShmuN0jEyzBJtIwf6t2aDrIBCTyHNhTLs=;
        b=gRwka4OnfqkmCqwHfOo322XVwx4GjXUdUVOU5HggIn4ohOLEDj7kRQNwZDEOEnCBcu
         OcXOsnBMCHyAhbiODgMJhrl4wFdJmBaJwStfV/74t7k+nfSkeXUZIhXteDFloqR9P6wR
         +WMQCpLxdvarlKqWW0Ol7Nerg9cYdkrQSMgDpmel77XpJsFRY5iulYHg+UrHS3TojyyR
         clPwkqzb+Hf5euA/H9dNGv3CfhytMbi+pFTKEHdL1M6IwyD+ybL0hWpB08t3e3gUy4I9
         9JkydzcTBirXZiEDRJKfeCyMH6H9GulHlgTEreTiJYRwDUxBSfAzxiqagONyBeTSl74S
         otQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768576733; x=1769181533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRcRwBypFQShmuN0jEyzBJtIwf6t2aDrIBCTyHNhTLs=;
        b=GybKJvnudlNSEYHc5roobJW83CgVLIDdg+yaEWNBjrEo6kiDHyTq7LNPkiqzEMPg0A
         kp9JxWvkLuQUAlUexPswe9hYS1iWVbulVaIc5LXzzMxmQK2J+2Npxcb95FJMAsL+SGwF
         k6Kg9BcEYOnCWBBtOzT38IxAnwO/n45j9HDU8WMjDDgidIy/Y4gVuUKzsHAcBB+MktDa
         y0FnhVRF1gnom2V89HniDokhKIVuqRNMHi09yNcznXEeNPcYph2BEnpoOYfxvt3OhZg9
         c0oeVRu8mFl9S9+IgHfrr5EpyS0QZqp3bMxZw6FLpZWJoF0qtm6Wi4zcWjox475F2JxJ
         QJKA==
X-Forwarded-Encrypted: i=1; AJvYcCWA5PaBHQuONBRSLgB6RtIDxJCLwPiezhcqPCQlw6iJon1x6eYlT/DeLkCa91J1/+7EAGrijUM1unIN77gDbOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkf3NFLeUGBfgxy5SIBbu2AgMhD3qgvvNEE0glqB7oaVlCOocc
	QFyZr2AmpYhDl/S8kDRRyDTjIruah2WDAi/n05v9Kfv6AdDlsis3fz6GQM1DDTg9Uep55KmyQFN
	sxs5isVS1io9a+5abSi/wsiMRjpA5QAEr9wD1j0YdruQWPSsaC0dWm4bBC7mBG55BDMAc9t8=
X-Gm-Gg: AY/fxX7ViXrPWaiu7w8yeEhaOPINz0zLJlPTE88fVNwUAKoe81C3wVg9WGh3ijS9rGN
	p2lMH7FPWiDCLHzXHCJwmG2rUV/aJFYCfMDUCoJP4r7s5fLJtWSBd9HpJnqoxluRHHfAZHdOGiA
	zZc/jDZJwu9JJi/TKBPTvCFvbM5Dc7prU19sBxOtFrRqUqSRolo0lbfU22+cAfUlelXIM5MR7fa
	kTm31XjSclIkeDF9FeydnEIUFX/uB3Fs9Ldy5H382XdVRXfJjFu4j7BKYpdeYB9Y8d3JUjBNUYq
	xZ/NECdu8K2nMnW8kez/sM6QxkRimwZ02S4uMvJ5gDriamwzs+5EMiHhY4qqZvFE+RzxCgu/66K
	JHrYOq7X+6y6dJNCTsnWZBbUcldD1bt8rcEPWPLf8OY+ggB/GB62dDAtVdtdMVZoyzNaXErcMWY
	NT
X-Received: by 2002:a05:7022:4185:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1244a6e070amr2977278c88.11.1768576732813;
        Fri, 16 Jan 2026 07:18:52 -0800 (PST)
X-Received: by 2002:a05:7022:4185:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1244a6e070amr2977248c88.11.1768576732230;
        Fri, 16 Jan 2026 07:18:52 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac5842csm2773177c88.1.2026.01.16.07.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 07:18:51 -0800 (PST)
Message-ID: <132c34db-07c6-491b-bfda-f3c51462a184@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 07:18:50 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
 <52b2b799-09e6-40a4-bea8-c7e8bf21cf51@oss.qualcomm.com>
 <15470b51-d398-449d-9017-304df5ad7cef@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <15470b51-d398-449d-9017-304df5ad7cef@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JNg2csKb c=1 sm=1 tr=0 ts=696a56dd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fl7gpmSGIpyIZsR_3woA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: zrPCkzdF9bEqL-byXivAr13w-LozOWuS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEwOSBTYWx0ZWRfX2f1sF4w4CNLA
 KBKWQuo8MNgy3tOdPIW2JzqXsRUCnnjaSG4AjwyaGzRKMQXqXjyaD39f+Dv7b4f8doTvK8c1Ktj
 2EQ5g4fwoMNGyqp1rvbxFi+6iq+JgjItwz2t3r46oqUrfqi10qjT/HVctwa+o+mnW1eVMDOxFZG
 kUJnwiTH1Grd/5YjeHfxr62LaWAQuVHlC2IUjgYmkFqRjobmElxcdHhPpX0wi3CJxRNEi8ZMIt9
 Uew5JsujpOImBhF3F6k9U+VqB2d6noQYLlF9vHdfKtXIDr9WclAcpNEg0V95WvLQO8E8t4Yil2k
 U4FVhcqdlYUAv9xQEB/GJno311Zbs+O3nEGxghN0mNd/3zFo/oc6kqlkZAFr5rSfaLDcVpWz3Aq
 R5waDL3Mn4AHjrhBFUsDaiL71qrvB61+J0yPu1mE9W28yt2uO+sbnAQH/NR6VzSMnflIJGdlYEI
 Cbf07gtjkLajffh538w==
X-Proofpoint-GUID: zrPCkzdF9bEqL-byXivAr13w-LozOWuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160109

On 1/15/2026 11:48 PM, Krzysztof Kozlowski wrote:
> On 15/01/2026 23:30, Jeff Johnson wrote:
>> On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
>>> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
>>> voltages over internal rails. Implement support for using powersequencer
>>> for this family of ATH10k devices in addition to using regulators.
>>>
>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>  drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
>>>  drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
>>
>> My automation flagged:
>> * drivers/net/wireless/ath/ath10k/snoc.c has no QTI copyright
>> * drivers/net/wireless/ath/ath10k/snoc.h has no QTI copyright
>> * 2 copyright issues
>>
>> I'll add these manually in my 'pending' branch
>>
> 
> And why is this a problem? You are not here to impose Qualcomm rules, bu
> care about Linux kernel. You cannot add copyrights based on what exactly?

I am a maintainer that is paid by Qualcomm to perform that role, and hence I
have a duty to enforce the legal guidance from Qualcomm when it comes to
contributions from other Qualcomm employees.

/jeff
