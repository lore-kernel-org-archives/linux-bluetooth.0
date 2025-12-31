Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AD313526
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182854; cv=none; b=ZcRm+Z4DCaSUKTwjROfAD8FcBclB0HWnnLHf2n+NkBE5irejTQ0hZXBmsPywkYV5RF3Db3wN5tK+46rLwy+VMPXPcvZDt5GywBHJATTR5GlhCUBcdsENrDJzwxqd9eNDfRk27TbZrZvIm9P1e0Mvi+B9vn5s0kkUomPgf3Ma55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182854; c=relaxed/simple;
	bh=Ebrj7FgOfGB4Y+kPltqSMdTk435gtaE4KgDy3ASxAFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAdjG5sOipWPr9NhkhzxwTB+gZovBUj4eGr0/e3aT8IDFXS2bQIRumGFoMHxnjSTtV051NPnalwWkeLhgw3jCkbLHQtzcrk5st0LaV7TcPovfFbmpnkjlj82JrAF9vbrJGj1/hiJbFwpA9IcstXDPRjcHwnbfmbOdaB1dLilX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dETWGwMe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzC84GKC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dETWGwMe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzC84GKC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV5KKXa3539627
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xwd9J0/7DDL1t+C6kRTwUe2pr4UfwNnjK2TEMmjygUs=; b=dETWGwMe+maDJg6A
	KDCiCIlf8zfgCwNkm9P7ZPfLfB8pjwsjQZCu5L8egpOH9A7Ibj4MC6n+AlTz8coH
	NmxWKy8OCzm0S255KkAUgQVB4BYolcMKmPzDKCZf1qXyU3V6izUp8N4R1BEgnJp1
	5rlyyVJJBycsVzhiae1bMuDl70A4bcQP7/2F/vwTnHfB7cI6Dy7Pixv8mHXOJNrW
	nlfCfcIRMoDSrYYrpEWWvKEXRLFrK660ApFarqXIXIDbzTpfatbXur/sheoWT+jf
	wr+n/9uaKBVHUSsfLiS9OxHHZbwKYjeqkTYiBoYeVMtNY0/7Zzho8vZAQesQsD9U
	1Dq69g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc88ykgaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:07:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f34c24e2cbso35465561cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182851; x=1767787651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xwd9J0/7DDL1t+C6kRTwUe2pr4UfwNnjK2TEMmjygUs=;
        b=DzC84GKCoUZBtMLrR8TABwP3YSCdkgvv+fKWgm+ObOMMHsxtBbk3cn6Eo/qvGbQYDs
         6L6LIFNoAtLANQVgwwChZrz64sSVBBIL1FD2FGLE0A42dffHOj3CkR26ZJ2mVJpPpSuJ
         wsBNC/X1Pp1yvL32YYnsD/AZyWs+OMoFF5aPYVELLZNxrKYxPzl0ljIeXkZWn4e7HiK1
         rTtK8ijOQPBp9zouHSrThns2mHNEhajRKHbfGORYUlP/m+l1N9kSC4XL+Jom81+h4ia9
         hpt+mabGgAaNumEAjc1DMy7DAgmZE54oWL0vOmtLhfOO/umW8/5JYV4t3IHZN6fyTPvz
         38cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182851; x=1767787651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xwd9J0/7DDL1t+C6kRTwUe2pr4UfwNnjK2TEMmjygUs=;
        b=P01m5Y4K3e/cd0ojfaKHGNXDvgHuxI4In1acGdkePo/rEjT9INOUjSMmsZ0x5yXecc
         BKU17gl901RW6wAdmKuEWvHlshKu3yqciru4NJRrEkvvBlQUnnVXbnKAZqLac6Ka+hi2
         uxgD9a+fJtd/r3Y7DU+u1Y7PMx+kDQhpY1ODdafA8TiZ0xvHrUlubkNfVOQeyftKhKnB
         w3ljPTObJ2N+TF7vC+5xOC0Z+eGe2GPdIoi82ir4PIwJhF3cZqStwBK1+IfCMzRJWsrq
         z5RQfC1ujWgLbEIGEhkDLOGwVOeiQskP0ihfbpUTf7O98ZV97l/rSp/83/j5kWqIK0Z5
         GiCw==
X-Forwarded-Encrypted: i=1; AJvYcCWjjf0yj3cIJvKcaWSIuA+rgOQlFWOdqMTTeKa+iTupc85z7e0oUFxjm+v0nybq9YaIf9F7wre4+YHnkmuXbOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRE6rHQgrHSnnfBVOO4TT5rt0w1RyekkFlsjaKe+jnZFaJd5F
	Pn5zVt1itUZidyWb/xxnSsKaPIxZnwIdUcpR8DeW3JID+0u5BXqftiUfYAnKb2LJJrpTpXFlPgq
	1LLsoWS3lnG4eHwOejVZfuiTQc4N6fH7EagoXKTUjKX3ifhMC/WokvEpD19V9SnnxYGAqe6s=
X-Gm-Gg: AY/fxX6Ago+rlVOMQ5Cu7CwB2STyB0rAG5uK69PAE4jYFpXCWDybwSJ0P543dIKBVvT
	8vq6Z1kphEAsYDrzV3in13dE0ZQT8fi11avshIa84XuWwvOxmKn5b5GJZVQoM1R7A6lM6xw1Uhc
	Qc0qLxMjJqDZnTHTdCdgxE8RW/EpifPlaCHenR4nOX5vDlx+La7HHx1KdQJ75wHDci5Lu4TL0Il
	teqILcAZCgOCgEFd87kQeb4YHXRF7PldBI59u8nk6tigEwfNUhXe6bYNKdj7z/Pb5j0ME6k+3ef
	D1e5RopQFUKy8q95HHW87DWjBuIaV0Bh1ILXWXemBWncIsn3pdO4C99bLa66aenI8Okf16gvzrJ
	W6f7fA+VqXq03k9TZ3ohnRoyyskE28pu2QlhbEw3HSjn+RT8k1Ac4vbDd25Rb9vzmiQ==
X-Received: by 2002:a05:622a:189c:b0:4ee:4482:e838 with SMTP id d75a77b69052e-4f4abccb8aamr395358641cf.1.1767182850783;
        Wed, 31 Dec 2025 04:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEECDEGzAJoOCl0rfUP6GBsO3KwpS8blNulJ+u+SXkREin+4W+m764nMSG1CDEYpWIXFGzjzQ==
X-Received: by 2002:a05:622a:189c:b0:4ee:4482:e838 with SMTP id d75a77b69052e-4f4abccb8aamr395358211cf.1.1767182850209;
        Wed, 31 Dec 2025 04:07:30 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f51a74sm4055637366b.63.2025.12.31.04.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:07:29 -0800 (PST)
Message-ID: <17211f57-0c25-4108-bdc9-50d0f96d3185@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ
 storm
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
 <20251231-wcn3990-pwrctl-v1-6-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-6-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POcCOPqC c=1 sm=1 tr=0 ts=69551203 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_BXXzmC4fWfZa3wPJs8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: i0WCI5oBHGnEBXTjW0VNS_fHy7ou_yPD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNiBTYWx0ZWRfXxg19gK6Q882j
 sTHhkkpZQtkxNTM0aPPXqBP6O+it3dGu4N2lPIvS9CJWtL+TkFITGpnvRblUFLVcS+996rNFE+J
 eAZ6q92Z4sDFoQsZtb06lsmS1xbSYxFsF8wIB9zLSqfFKWs1va1vBWpew9H3OJ4IxNKuz+ZDeXS
 Ol91P0jMoyTHRoq1uXmyOCsI7hLg2x6ePU3wh8g4nbOOeJWQeoLmwl5uCjRTePyb/BS01S5TPqC
 4u9T3WS9gClHl0T4Opp3EVveHGubHsWeVOieY7FFsWJGchmOY+cYu5rkJipoXB8I0x+G8G49L27
 8rwj1UvFFGenBOTpz34jBzFPsfcm2OePqvcR1ML1ONLmkOt6WPpnfjk0KXxH0Ty2Msmu1TPOX1l
 LOfb1fatb8nQxwyr77Tyx/t7vrukExv7gqsdg+z3OHvB3igjkm3vwd1DVzYpTIaZmi1b+g1o0HN
 N7l2qeWbhvcAmftTEJw==
X-Proofpoint-GUID: i0WCI5oBHGnEBXTjW0VNS_fHy7ou_yPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310106

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> Follow commit 9c92d36b0b1e ("arm64: dts: qcom: qrb2210-rb1: Fix UART3
> wakeup IRQ storm") and apply the similar fix to the RB2 platform.
> 
> Having RX / TX pins as pull up and wakup interrupt as high-level
> triggered generates an interrupt storm when trying to suspend the
> device. Avoid the storm by using the falling edge trigger (as all other
> platforms do).
> 
> Fixes: cab60b166575 ("arm64: dts: qcom: qrb4210-rb2: Enable bluetooth")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
