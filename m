Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8D3C108F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077342; cv=none; b=mZ9E2gCx6+BSFsu868GYtuBcpmBtl3H4AUF2WPCwrbkTKaKsMBIw7aFbobQqWLBrTun7w2e/iQbrCvnU/DbFtzUXBL/Awu80V+8ALEINbMEuA/W8LcI/suJOUYRVYSyz1zmISGcz6IKK7Rd+29Sq26ODTKKxs+ifjxllvTIwak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077342; c=relaxed/simple;
	bh=6+8anx7ZeT5eEobYXLCvVKBGOsuq8YLhumkfxh1cprQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqEvA54CBo67FfD9MfyN3Th9o6Wk85McUnXbTR8qo92PbTxUYdxEjULksbvrkYg2kShJ6YTAoYrUg5kxEuYNFQ0s4oPZhEHjdnoTEm5fvRnxxwPSXbO2429yGTPBXM88+I+T6YGWYckyCqWwA23Z9sDBVapKIzWGUe2FCr5nSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WWxNFwEb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/Hn1KLg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WWxNFwEb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/Hn1KLg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6637ZmWr3410166
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 11:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v3QJyHRa1NqPOMjsxEzu8DRdanlcPy1iog4etxanpVk=; b=WWxNFwEb9O/XHM4C
	yhDVARpN+BdzepOdiJ9CQU2qC9NLij6IyweYrQzebJzcrFU0hAuvzXCBe5UchY+C
	Eh5zutonWqUpIZjFbzDDMexQ0cCXPpgO7GgLuB45tXmHEwLhgn6Rst8h91WwJF8E
	vKpwwLohy9F8xTgO1s3U0TO/evtj40g7Zz1DGryd1E6aSdNtaFjlaP6sR7PZXp9G
	uYiFg6fYiP5GLb1ZGtEGA3PxmbRbvtr8AiOHpeNYEQ87T1o2j//mPONIyoAoFm4w
	IthyuRJR1Ym+i6bjaRd/pgrJtE0a71sU/Q1MT57l9h/drxfeYD7anOD2QnzcXGzE
	/yo4xg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u30t4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 11:15:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e6b97afe7so14014585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783077340; x=1783682140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3QJyHRa1NqPOMjsxEzu8DRdanlcPy1iog4etxanpVk=;
        b=a/Hn1KLgBKM497kMUyCkC2XTRBQB088I6D9t9L8cULkz6MxH3HDXDg1VnUWYeXYdfB
         EmwIxsCy9ZXwuhJ5HbpNWmicrc8MEXaw+1pEVUoBx2hesabAOFAG/JVLTbYDsOIdHUAI
         oi54AdXRAT/23YDFte8xO4RNwdRt/Gh0V3lYebadQL1U8iLjB4XDbu937pDlyOD99B/i
         51KZ/3q1/rt2Fot7Y/rPLddDsxyeJW3sSJu8+3K4J83SWKwol+YeG2f6DzvmR7lrgy0i
         VwAh3Vahl5l4u+utE7qzq0/rKr7g08g3Sinc7l6uRHD9qq5Smc8hqpfIAfNJ/1AQqiTz
         P5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077340; x=1783682140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v3QJyHRa1NqPOMjsxEzu8DRdanlcPy1iog4etxanpVk=;
        b=Cyfrecnms9F1iMu99/Nnh/5EX8Mi7gCDuvmi/DVHFGJmYcSte8VI1svu8ApcZzrjXl
         ajR77kUlUAQ0Hb+s1bSqN/kabpLTD+Ngceit7pVap6+oDqVLfXYiV0XzcfGjBaZC+lyW
         xHd9s+8UJPwTx6+95Y9RcVtbpjfMNcMHYe8WLtKLss7E9KKfb4l+4Hdqy2Ok3asGd4/n
         GoSTpwtDTsego4OO9VTMKLgWKN7d7ASG+lFWaG2okrNsc89aUOxApHHb6ENgXnCTJrNT
         q+g7Hr+lTTiQ5z/tjf15a/ITUEZNrhEUUd/CcATEvXyy1wSvF+FAPndKikeXfhbROJzi
         mQvg==
X-Forwarded-Encrypted: i=1; AFNElJ8mnqf5ehpahJlYsaSJpN2BWDsFpEqT7BiibSBV/ZHMgUh/n5dN972PuQK/Ad4xE7ZuLZu6lFDqjR0uGb9nnaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96VyrN1r2uk3BYU4UUOlqdc/NK65SN4GXiL4pR3OmrK2paexY
	K34Hy1nTyF4GBCZHo+EGqhit52d+6WfKAwOnVVtGm9YcgKVejR+rI8Ze1xvTj48rPjvqujuDKvc
	v4zjSW5eviynLuUPa1wes2RNqAr3+JOnbHFW5TkRvRwmQSiEbwI1lZcUvSBQTjPh7XPiU7Gs=
X-Gm-Gg: AfdE7cnrDbqmzOoLp8Lo1i2XSy2LCxoEh4D57mh3iNMKV68nfJr823L/RdHmnFHXVvs
	/PIYGI746i8X5n5VLMYGnm/zcT0cLprxScPFne1L4QykwzfQeOfi1QnhKfrECo++rkcICKmcd7l
	szVIM3acMjdfDOG/StKcnKjAIh6mMIrzxT/ZYjkmaGXoo35vsthV2Fldd9zG2YKwHirSmHazlXo
	gJN1t/T7MwG67v5qX8WX88Ch1UJhWCx2unUfDo0KAor+xBsxzJoqUyEJ7YIZKWn7fxz3Gzbha3v
	34TlgJNTr7gKP9U1ufDACpxtRDL+hDJEsatlBH17RrpHbxfcHqjQ/9d+AVpoICnHdTBp6Xuepx3
	SBzu+55sBKfVif5aXjIWdK795nrDg0sKkyXc=
X-Received: by 2002:a05:620a:8391:b0:918:588c:d095 with SMTP id af79cd13be357-92e784f8db2mr829848385a.8.1783077339740;
        Fri, 03 Jul 2026 04:15:39 -0700 (PDT)
X-Received: by 2002:a05:620a:8391:b0:918:588c:d095 with SMTP id af79cd13be357-92e784f8db2mr829845285a.8.1783077339236;
        Fri, 03 Jul 2026 04:15:39 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f6e3dsm265198466b.62.2026.07.03.04.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 04:15:38 -0700 (PDT)
Message-ID: <342ad16a-8210-4dea-99c3-50700f830de4@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 13:15:36 +0200
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com>
 <20260703-ipq5018-bluetooth-v3-3-62da72818ab3@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260703-ipq5018-bluetooth-v3-3-62da72818ab3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W_HSHD68JFu3e_DUfmYSqLaxerUJZNEL
X-Proofpoint-ORIG-GUID: W_HSHD68JFu3e_DUfmYSqLaxerUJZNEL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwOSBTYWx0ZWRfX+y9BR7vYXMII
 Mn8lPrILpOix0Jfu9PRZasqiXweQMYwlrDvdc2AET1h7YaLCi1jPEGQZuAneMv2SKoSMPPCOf4g
 JIpv/No+oImQtZhLXOwgJp+BMPCLww8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwOSBTYWx0ZWRfX9bhrnZVlb6T2
 57CLhFek69dFixyy5p1ayn1682/uLQdwQIDqLlcO2pJxxdXxMFJtYnAppLEn2q0ZjRq4Q7DUE9t
 fVlE/GHRG75hptvcmePEEGnA7fAHpZm8nNzFb4IqTy/MmgNFRjP913kHeuExudKYVIM7YI6DmIP
 64YBb5Bu1tkTcuc1vEoSZcfzOi8tvaJnxmaO51S6nd9VfyWFEkY9NhA9UkriGxG3ZHCZChpZlQ/
 02dAVeJOF/6oDXOfU+XZ77PrsxbH6vGa8vXibFsuNWIBPYEdt1ggRirLbUpaThR12fw2+VmZPQV
 gwpT/h0CnmvoyFRDVVzxHGBviVGErRsCmA2G2b6BFgPvKV0iR4bb9s+lIqrGNXl9nX3P6ts9sVv
 SZeFWIFr57VseJsNYOnIWxdbHt4yV9LQ0RL3EfFkUBrGm5OPdKDc5BL+nIyFmodjkLfPVPaJPVH
 skNuxV769sElPOkgTRg==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a4799dc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=EFz_iqN25vaghz0NCYEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030109

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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
