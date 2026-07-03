Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD53C140F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077328; cv=none; b=Ce47cqdQXQUDlsj00IvqlA1ACvUcyzNshGeRx/5d9H9APzI43kT8fdbuAdM/YixOQM5B5574OFjkfLyf6ecQ5ESZ1k/Jw4Go7whPlGl55PrXj8Zy3MTuXLDoNg/UI9XyaPZF6GDM6F6bAzvpo7kWh6REctPfhEOrejsEhgnWd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077328; c=relaxed/simple;
	bh=fh36BDF5Wbj/PXKC4YWBxl1j1DTIaaaH5aqUWXZOVrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8S+rle1R6gErOVjTuTPLHhlqkiR9UPRltl8GIg4XF5vyjA4kjL/EzO6jMzWxZCKG3VH8QmafkulTvR2TGop2TPqwQMnSkcA1pSRcqJCpXtqdGGX5Rr+nCIFVBzyWoxJX1lbgMe7Z8gHSymBGtJithftcpTXN+F4EGgVIpu3AS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RmwOdMMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z1OalHRF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RmwOdMMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z1OalHRF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663683q33053231
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 11:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gsBCA1giK0XVWDpPfKpAgEuh7s3EHL6OztVzj2y8Zj8=; b=RmwOdMMtKyw9kFMm
	O9wPwrVqt29KlawWaGggpSyZgOHw+QkpxFF35U2uC5UuXLe+iSYtEcp3tb5xxmEC
	uKkImPFEk+lP9XBHT1io399Umq6LKNsPYaSwYtenfqrcFsyHgytTmF4qFGmiui0n
	DRl1KvaU4G+w1LIcz9oxkt6j5Xy/5zY7UFg9ehYlpMx5ACqYNJBZyYxWBlahk0yR
	wWTzgy8lvegErjNZeabVDcKHlbtw4rbiXmRb9FCfazrlLL5ovSMgehWJ9RkA9wOF
	PTyCh+3E3y6zJeGEOBn+bYKxMAe3sY8Y+NpvsFU47chwb8zN3XFKdpR3UVIrcWT4
	gFUhuw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j0143g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 11:15:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4ecd1ae4so8856685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783077325; x=1783682125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsBCA1giK0XVWDpPfKpAgEuh7s3EHL6OztVzj2y8Zj8=;
        b=Z1OalHRFyjhFEyLi8rIbnWfm0DAuVl1bY6yLDv7NAUoMeRja7kH0pgL4S27AumiZTJ
         koEG2sSp1M8yt3GWKu31MiVJpUK/96OPK+r2dKRmkva2UX9RmFTZMy01mD1AHrjCAMIc
         i4YvH/dLyxDTK4H45uV8+HV6ec42YcdTM+aEvuIyA6GyRDLIPxklo3sreuD35rueOKag
         g2UL92HvRdlcjS3RzWSPmTMrugVsqXW5Ozx0enAHC3tuLQFyGB2kwcPT+5R5WnqS6adi
         p39BKzy+5g0seJPTyK7Cu2QNzlun0DaMIaVTaAbQUsZEXoFI6ugQR1u/XHDZ/XYk+yBG
         CUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077325; x=1783682125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsBCA1giK0XVWDpPfKpAgEuh7s3EHL6OztVzj2y8Zj8=;
        b=YygqFNGpMET0UzW7F3kvofwMVWJ/CddlVkFhvKgm+3TB5bXjQut3rhO0mzEIYFvliU
         NBxZkj+tYyJ3Y0I/xyxQ0VOa+lOF8PMEEeu0RIOPq29Tm+JtpK0oOXJkO2pOxGY1/fBA
         cIkjwv3zgLBgKV039cDTQBgAKx0GEOqzZS6U5FrtA23mKxPhY9n+5OYX7Ug2dYvM+Z9P
         xP2sr2MhdvNKiC4eomfZ6LF/sDLG5yWFC7xOrAdoDITx5okrmgddUB3C6NdYXIa0K+Y5
         DqAvcEvpRlxNbNio60UalgbOznQRRszd/cg/nnWkg9jLmRl+SdIJY7dAL6KbZhNSlLmr
         uCxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IbnwwCtzshF57vWXTFM1L7DvCeuSiMO2H/kV/fjdPRyX8MqHI/+GBSWwxt+DUy0yb9BUEs7drnIlYSMzpbC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4BcqOrXfpYEN5MrTq1ByGPUxrQ8QjYjlnUYUYmoVbxbbBGlb
	BIP8R1+3YZSFBaszGCod7LKmsoAnt7pxpS/2jsMaD8AcAgwdlmArmDvPNElp47k3xfsF15mHTUX
	HXdbQaaAk9RlFPTym29OKNiaaKd8iVvyEI6CUPH+0Ultt3SccmgzH4QBFP/XPhW/EEFXDCco=
X-Gm-Gg: AfdE7cl1+3VpNdwWhXLOlhX+Cvj/nLf17vKH36pmB1p8EwpzNm4i7VtNUenyUz5YSBz
	fwNJYpS4QwlxqZ/lzlJo0MH1xWEGyfs5JeP4HBcv3c0RZcLENkRw/Fn8ioG14fh5gFXDaYWwitn
	DVrfM2+pSRsfjpRYso/Q5rtVfLySWLhQBKhciJHpW7I8LPCe9Qzxw2/HSyKS7sf31EH9xMG5yWa
	bK72NNoMDta4d+uty4Ms7a/wGq3+2GfeJ9KMWlRbi2nPKy1tpI8bMbHgDNzZEPBJijSCxPJb/33
	Gqx8+5Jb66lPq1e4dYxH+NIcKaYzCELG4AckDQNyOSYCVyUwHdOuSkdiitvBDtTi1iWy4OY35EG
	hgYKr/SVP+M+S1UrxlUpo
X-Received: by 2002:a05:620a:6482:b0:92b:2a80:3ced with SMTP id af79cd13be357-92e782d254fmr822410485a.4.1783077324910;
        Fri, 03 Jul 2026 04:15:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6482:b0:92b:2a80:3ced with SMTP id af79cd13be357-92e782d254fmr822398385a.4.1783077323810;
        Fri, 03 Jul 2026 04:15:23 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6095b7dsm268392666b.19.2026.07.03.04.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 04:15:23 -0700 (PDT)
Message-ID: <76d4b184-e089-4dad-90d5-96da762c1fd9@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 13:15:20 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: george.moussalem@outlook.com, Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com>
 <20260703-ipq5018-bluetooth-v3-3-62da72818ab3@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260703-ipq5018-bluetooth-v3-3-62da72818ab3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xxguprpu0uss3-x9mwfXZKjH4L9RpHkE
X-Proofpoint-ORIG-GUID: xxguprpu0uss3-x9mwfXZKjH4L9RpHkE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwOSBTYWx0ZWRfX5IgxLi73Y5LL
 96RrLZP6MEmMbGqvHPCs7y5eZPB4HTvUtCmfxtzMl5WxOZKPaVFmUQGWZlB3qBsQ5gHF1znQued
 MQLoRiFrw7tI3Yb4vZrYx7XKrILi8SU=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a4799ce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=EFz_iqN25vaghz0NCYEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwOSBTYWx0ZWRfXxMbPrDvJKFPi
 xnrigMJVD+c8JpFcBcPfmJ8dkzq1kKBcLSEk4zL5EDaa6FLeGUR/HV775FGLMwD8jhpso1ydxCP
 foFOGrN/Au9/NXRwWPMYPxxv9l+NvlZwyWy7VirUT5SKW0NTh/pHactFJm2LfqQZ1UsD/G7mz4o
 ufZfthkPBEp/LgybyjDtSm2BvXnlSVrGhJeKN82wbYymAYOvyPvJEdREeCZhmh9S0fPzlljE95F
 FcxLegwenT/Mn/H6j4npF7rk4hmrUul99f44UIQrA56LixjBivB/KiO+ecVhqFvjdBHMvfv5ykq
 veI1J/6m7Y2yXuo1dEqYvVJTFLxF2lmjePSo8R1oom7oM3ki9Ro9LCjLjjZoImAlOgnJNVLdvEs
 9Bf4ohcKI88WpAEhad7JRhosFLMg2sALpHlu4CWgDEPJ0AiWjhXkbJjxGU5cHe84BHtT/vf/GUq
 cxW56LEq9TQCOWsIY2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030109

On 7/3/26 7:01 AM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> @@ -105,6 +105,7 @@ int qcom_scm_shm_bridge_enable(struct device *scm_dev);
>  #define QCOM_SCM_PIL_PAS_SHUTDOWN	0x06
>  #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
>  #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
> +#define QCOM_SCM_PIL_PAS_BT_PWR_MODE	0x21
>  #define QCOM_SCM_PIL_PAS_GET_RSCTABLE	0x21

0_0

collisions here are *bad*.. +cc a couple folks for awareness..

Konrad
