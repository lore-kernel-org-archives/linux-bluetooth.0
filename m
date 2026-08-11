Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298C442FB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459421; cv=none; b=XBXIWW3qMdUlZHnXRx/pKb2SCZYUYNCDzNbV4kIV4DEcDtWkrhXY6w+lIaLV7CYiRm0Z7z7Ki6ph58eU9bSLi95Uy0jZPhBCTFRxZUkkeDLs278br1rqDHSkHHHi0aJk7zOq4owEFzLla0Zvt7QiZnIQx1BSpbvaac+nuV4Z2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459421; c=relaxed/simple;
	bh=+RgJXc2u92oUD7Rw9xwnt1R96zyV00TaMbgYq7bjaXM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bQEVIdC/7aHuaCkthsJN9BmwEm4YPgThfiQrsNN52r2Dt8AcaMuBK43afISPvmMo8RSy+8Yuo3yrOwq2KgtmRT41qLwnzH/i0A1D/QB7jKoxqyL5e6cqwnZR1f81cV1tfi/iz7dRjDhqqCFR0aJv4X3wUYCTTqF2Ci9l2mIMOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iB0uxe0V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HlgllN9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iB0uxe0V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HlgllN9j"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWjFb3718152
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o2jxnNo5iYYeoQlUrnLxfvN7FrefT2UcRsNzeLU2PJU=; b=iB0uxe0V1mB0z4UO
	1VFh4g+7Iwuu6fP4rgOg7qY3P4+i81iLg8H6W4IsS0Dinj6ouyr9AKr9z/hWavmX
	EfzWlXMBkfiVmyVai6t5ntiQ22CtCuwyhmh6mGIHYEjsHJe6lYy+jFXknT6UI6LW
	Ths2gLRltsrYIDY/mT30P+Xizpjfe59TY1MEAq+o7QwyrPUVA43KHqebvhIathHu
	hRPJcMx3Ai3Bvchzs0G21i//zjKxK17aOlR8pmW0/KuSlrvhg2CTWl1koMtBDGmW
	v6mRvso2hNR6udaKOPwb3oACJqnMvJf+6jqaInkl+8wUke6WU0uJhYOuE4rb/hKX
	4bm2rw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwess3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:43:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52b4f6ac06aso53664231cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786459418; x=1787064218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2jxnNo5iYYeoQlUrnLxfvN7FrefT2UcRsNzeLU2PJU=;
        b=HlgllN9jJpZ0NLXSxNg291I8k7KQbfwrfEr9UK5ox8MS5iM5ZD/1FSYvcOLnBgFBEE
         gYzRUcqd8uNgZFbcH+NbHWjh9MxbPW6ETZyk/QW6WMDkqOPFXBHmJWniYYsrPKdMHtcW
         yNHe4f2Qo+ch4b98EkFIM3QidtpKpzZcYOAlQifFzBZm3rLNrLfKGNdCTU0PQm/mRPgS
         Yv0qBcoKX/h+ZkvKVUMjHCnGJoFm1nOYV0PY0Tr8IUQ3tOdsPsSMn4Md6X4ed457G4Gw
         Xo7SyNO4zAjNm2W2Q7RAItmm+hV+T3fckEHLKWkkVrxH2PMGS0R23w+TJ0oDYLfRZb9D
         W2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459418; x=1787064218;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2jxnNo5iYYeoQlUrnLxfvN7FrefT2UcRsNzeLU2PJU=;
        b=JUrvrWZ3ofFty/oDPvV1Ng7cSfwLEkpDZZS3RosPiVSGAaIOtRCS73tUG15sHI9dr8
         so1zzJilQxzjP77Wfr3flMQSoDHXGXExEDuEvNRevc8lPK5oZq23Tg7fE8ZDh+w6ieND
         FPxpVCqkKGmPqW3napdGO4SCkWOp1YLydxOhdoJ0QYA+548JSEbbPo0YwhdzlMo+6ATN
         cgTLghTIC+EWCG2TkCtAAQg1EEeGBGaAzieelmN3cr8ZZYMGVQI8xwlNb34ITbZrpu2E
         YI2OxpEbj/4JnWcP1ZfcgaKmb8JFo1hvqaaF0V0nj7bVeuJoZlA1BANy8B70vM7+hjun
         I1gQ==
X-Gm-Message-State: AOJu0YyRDUYbMwYjd6Dey6Ndv6oti1scxMrCOwgq9R5FaG7y91z4sTk0
	hxmkXIkoF64OhZ2sj8bLKR7B1cApf5fpubzPh5farV3VYijmk1IQceayUshnHNwfG2BOwcxwz/Q
	JTTeW/hdi6OICDFHwEmNUhDy2krUs0vQwF21Uhenzcs/ztwbM6S9EAfuvnNZEhfXxZDBAFWc=
X-Gm-Gg: AR+sD13bpRIrIrZ1Bz1+8giPZDzHdiVcmBpN9XpsWSRVXYxcRwhTlEQa1s4esqYoD52
	Wt1byhuz3z4P4hUfy1b9ipcWyBGAq+2twUEUa9XxGSkmDKFAQVPGBto7HfW6Gp1Pddv49hZtDyv
	ugG8hhNK63fG4vZCgN5yEjXrOtLdq7kfY1NYiPqC2SAJ0mNVPtGzZAZ58ArYdKu7HKwSiM0SNnX
	ViwIl33Ig1DTBo5lR7dGdzjVQvn+cA9qWpEz3zoyrTn+z0kNNuk12ytbqFL3lcV7V6kPYKZjlLJ
	cdZhkTTsAbw6EFqKCFkItYUcWifnScbB3+d0XnuwE6M9jTP2EqGuA9mqSL4rZcpZmqBJdZJZqNe
	JR+UXcGFxmC6fJBDORJlkUw9NrdmsPUkzIlvHEaXqJCl5bY8QQ57CUjIP0S1L7y7+ikRGQSRXuZ
	F7P13y/QefX6KdG8SiBmqBbrGHM4AmksCw07OaCEX2wTb2Fa6GCRj7x8jESpDxpJcy27k=
X-Received: by 2002:a05:622a:2447:b0:51c:51e:661c with SMTP id d75a77b69052e-52d585be373mr36375081cf.25.1786459418316;
        Tue, 11 Aug 2026 07:43:38 -0700 (PDT)
X-Received: by 2002:a05:622a:2447:b0:51c:51e:661c with SMTP id d75a77b69052e-52d585be373mr36374641cf.25.1786459417867;
        Tue, 11 Aug 2026 07:43:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e43207c8sm62004566b.35.2026.08.11.07.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:43:36 -0700 (PDT)
Message-ID: <13692d14-6093-457c-bf39-42afd2d5f8a7@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping
 the last request
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
 <6a7ae9ed.9e118ab0.227f96.1808@mx.google.com>
 <f1e1dcdd-cca7-4670-abf0-febf16c72e15@oss.qualcomm.com>
 <CABBYNZKPA8UjfY0uo8cPE4BbxTRON-OgEpMuuHdwJ=br91H3Tw@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CABBYNZKPA8UjfY0uo8cPE4BbxTRON-OgEpMuuHdwJ=br91H3Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jKZGiGM32CgNzg8v1Q_82h_NrwuolD_e
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b351b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=u2QlH3m47oE_y6XC3icA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: jKZGiGM32CgNzg8v1Q_82h_NrwuolD_e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfXwtD+wa5mzYYF
 aqyu1hSznl0A3n4mUEMJIHA04v5qR8u4aL9V5+Y62qX1Xj43lKrQZIN6my+7J1QO+/rb2/G1Gje
 lziI4jqvYxDE4+8I7bjGKiy/JPDiYT8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfX/HIx7eXiVjXs
 LECPpcmTlLtMZ5ewgc4HqBpmJvHNIPYQIokxRE38ZcnIfpbh7KdGgWiuqbfv0ZQxBHtLADyzPU5
 9hiCXJDwFw18/NMJGQiAXT6S1zKB6BMtyHffn59ybJfd6Yrk8BhlUj3U+6u2Tdy6MsTHyde2Mw3
 bCw3s9u4NgG82vJ5tLidIde2JpOAlxKIx/F9cN608tckfCeiZ+Scdl5LhvnJasn45AVyxB8TvS/
 QdibTMjcJXZ8PaD3gKhBQN9kMY108ZEnIk7bNde7zru4yu0B3xL4+vIlNU/8JaFHJl5WgkB5YsK
 s8l+Yma0M53Qyu2pzD/8X8+tDShZgV6az1dhjqFuzw6YxwloLe/ldnUW2wZPBVhcfuBGCzmnIsZ
 CWcIjN2Jl32KZd7svZ1fR8vZGSFzIM8lR0494ZWC6d7c6EI42FV8XQXXL6UrVoQrtb8wm47TXd7
 4rZrMAaUtHj74HbZu3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110123

Hi Luiz,

On 11-Aug-26 15:59, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Aug 11, 2026 at 7:05 AM <johannes.goede@oss.qualcomm.com> wrote:

<snip>

>> I'm seeing the exact same failures in other CI runs from recent
>> patches, e.g. :
>>
>> https://lore.kernel.org/linux-bluetooth/20260808062541.3705446-1-zhangchen200426@163.com/T/#t
>>
>> So I'm assuming that these are pre-existing CI issues and
>> not caused by this patch.
> 
> Yeah, don't worry about those, there is an issue found by sashiko that
> perhaps we need to address:
> 
> https://sashiko.dev/#/patchset/20260811083730.71393-1-johannes.goede%40oss.qualcomm.com

Thank you for pointing that out.

The Sashiko suggestion to make the clearing of the flag unconditionally
(after freeing the skb if it is there) seems to make sense.

Shall I prepare a v2 with that change ?

Regards,

Hans



