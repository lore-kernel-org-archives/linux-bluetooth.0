Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788423164B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731601; cv=none; b=XFWFgTlsbKtdd1Bn3gXRQJ7YYqw8Q/9ivHTleCzuw0qZ/L60v4zYVDucGVm/4l98tZRNpoZuY9zNkdhlDlCsdaLE7R2GnLNAadqwFtikqakfdx4Av+fMFzInI4iSqDEKonDHtJJKlRzThqsKNyyeBukohYR3F9GdfQ5BW8yUt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731601; c=relaxed/simple;
	bh=erLQoruVgdG1tPtGnSYjEdMaQh7l+bORlfqid1duOSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXM3vFXzg1bz8m4yzNrG4hDBrGAPbnSEHq10a+Pg7s9Zbo+n6clrSEs9uP0Fj/FKX3rmNxtMuzC8k6u8VfIGHcfVWFZpYYsbD8HWZ3jA9v+P5FlC+asGdpy+UlQrcXXUdGrSInGnQ5K2GoDj/WtLCWY4Z2BMAU10xNu9cwnA6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dA+JJVfx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TB2eUi9E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dA+JJVfx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TB2eUi9E"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7Z4pT2169285
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 13:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DmF4Gfu8XO9Rvxh6aUMFei3U16jyA5Bxui9UplFPhvs=; b=dA+JJVfxOU/pc2T/
	FCMosy2Uzx+iIQq26U2S9qKh9Sbi4B/2N4TuE3FzSRRE74FCTUNwXDsUnopEOZJJ
	Bk4B+AjdTZGDva8hklcZbFPfB8n9Dq0PTE+LhbnpsBDFmWm28HSQgfkFB+nN7wcm
	e9ElENDbS3m7e1PSg04sk/ott+l5frxFIJtwdujb3DVmpuBmJ0VIcnxUPoHiSDlX
	+v7QZ4sTIh850AIsNQeusPJCtjGaKT8y20QGP/GDKypBDOoS6a5Gx8Y3e5BTeHjv
	7TEKNppKN7BhHJrYVb4F7eahcZM9HsF/92jsq1sofDPOtBncWDyRq0x/p+7Ga7Wg
	bdNNiQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c80drs5m7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 13:53:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso4517688eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 05:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770731599; x=1771336399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmF4Gfu8XO9Rvxh6aUMFei3U16jyA5Bxui9UplFPhvs=;
        b=TB2eUi9ECv4sgbedB1+8VcAR6ds7UFDy3pgTZ93R+fMqgzA9wlUABLlCD1K/9jUP+/
         Z0Anc7F0QRK+wN1SBKADKUyOTgIvoVtTN96VmgGOTakUVIGlqmQJBQSsOhz/224i982m
         hoMP6qSQGyyV7UhVRlFUsnaHu0P+5dvdxO0l8YD5DG1HH4m1tBIwWuGBityZkOn2s7BD
         dmU7zVoIOlelDpj5QgHUfe08wVmcigJiuhATVR2XxNah/HUy/6ROwiVpc08VhvOWQ6+N
         HZ+l2dS7vWyrbVQUIJOlucv6T/9vIj3AFipEAGbkaNnonccqKbJnFX2dMu/1Y/Wi7857
         Sv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770731599; x=1771336399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmF4Gfu8XO9Rvxh6aUMFei3U16jyA5Bxui9UplFPhvs=;
        b=HyZ2HKEvqjpUJOxSeiKGnBw1uyvALSp4bs0UNO3LbYwN2EfqKPRUA4Pz7zuftmwr3j
         4GbVK30CV2pPHRBTIhi8qpdOYon5ceWQ4J4UGA8qbEp1bkZRGohRWa0Frvost7B+AtBi
         igvIc9EA4vvcMhr94vB7u6PaVmPzpy7sBCuSg94r8YZK6ev5e+lCiK5ETlgHPyVTPqxH
         K6RrFpYDP5S2bibftfwrB9hcjRfIKvfz7iVA1opr+83HSWxCwhsfd/3aUTjk6qW8oY0k
         RStxM9EXol5x+hmaJ7vBUBnqd70B94LR0XXvPbgf/9Byg7LWoKU3+v/xFMBzB1cuJqlc
         +Otw==
X-Forwarded-Encrypted: i=1; AJvYcCVK6/L0gGJsd3t3DuRwvQWB8EDnR4SQc06YpLIPIXQuXqQYg5lZO50+7Nynvx3tN7alGTIZGqkKTNGwp9W2fbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QHptlLUsHHoQqynGWyNA1BQiGhlcRiqzp1oCdnLShzx/Ew5D
	oM1e//4CLNGWDG+BCbAJMqWZgCgKAQdIMZkmjLOOv4ajAs2mmYLRWh6qIXJdj2qOOLWOAF/aIyp
	fOBlP2Go+nkXebu7fp+0wXIz18VpLMOKIlFKJfqC6dNcpycyuSrB+VzxeGJK9gYz9c8aFRHk=
X-Gm-Gg: AZuq6aIQEjY+RND3C6ufqCT8ok4E072rJZ1r/m4+QKbfJQZARsRVTlJLbg/Nx00gtcZ
	zYmtUa7zyhnmcXKpFFECrmortNJO+45kb+xY/h05KOXxbuCBePNEz3Jv6GQhKpEMZI+6apzxaX1
	taMWehjTZTm3r7JORKrayVCS9gxa6Hj/jZtFMNACgxZ6cGIvgNNk3MTfQpc+ad/ydxasBQjORwC
	oPQp7+R67JeMajY/XHI1+4FRl6v/RIpooM3P9h2M3LKuI/OVLN1aQ5rTgwkQF7wvHbeA3lYRmjB
	p2/weBuvj13IL45y1jCeUdoG3Ev/tiMxyThgMnNp19v8YMYEAcQDtx4owM6rwmHK3Dx+z8C/1p+
	EDSOcpDYLwOFwEgeqQTUmupoJy5VyKQtzU3uZA5+2Jmj2aaPP
X-Received: by 2002:a05:7300:572c:b0:2ae:55f0:f2be with SMTP id 5a478bee46e88-2b85683e423mr6864656eec.31.1770731598928;
        Tue, 10 Feb 2026 05:53:18 -0800 (PST)
X-Received: by 2002:a05:7300:572c:b0:2ae:55f0:f2be with SMTP id 5a478bee46e88-2b85683e423mr6864647eec.31.1770731598389;
        Tue, 10 Feb 2026 05:53:18 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c88cb4sm9295064eec.30.2026.02.10.05.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 05:53:18 -0800 (PST)
Message-ID: <dada4a44-f464-4325-9082-50029d6a4555@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 19:23:11 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: qca: add QCC2072 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-3-vivek.sahu@oss.qualcomm.com>
 <CAMRc=MfT7ourMH+ShJpnBAjv_uOb_ds0rxJOYaz_HsoT45dJYA@mail.gmail.com>
 <cbc0b42d-fb5f-45b8-9074-d0bcc64a9de1@oss.qualcomm.com>
 <erc5u6hzofidlf54dsz7htta55o4xwgihgh4tu6mqkg2ijz3fo@6hd6q6iljrfq>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <erc5u6hzofidlf54dsz7htta55o4xwgihgh4tu6mqkg2ijz3fo@6hd6q6iljrfq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNyBTYWx0ZWRfX/QW9vVZ4KOg+
 26G/4nYXzgkB/2fnnvgcNC3LuiDjRrdNO9WqCYe6+PUrcMu8Aqb1izsKDY809jbClDyYHeplgnn
 JOLHkChBKP/ZmaEbjRVPM4NN11wM0s1CZ7YPuNzsmPao3Zz081a785Oc2zzJNTK6P4jKrLm43AC
 EKCJVLsU4wtqT2EZY6TCTIawPZoGOyHFPUuoeyV8l/rtDOi6rTSn2VZL1NvGe27c1vXeCTj72Xt
 WeqQlRub0nOIo7PgCgFfS2cpfj9leFk61nxWKPL087jAE1JGZongeNPokUXnRvNCEY5q7nYkUlt
 8Wxs4XGa02MKCcHAiOyF3nvU1aZFi1UMq0lb5BRfj2rf74Hss03Biaov7zerqaCV6GQ8YLUhl2s
 x5pzeTmS32kSLWJBXcJt+Np9I5/yCFv43Eg3OiEf5zgXNjFIqVz/qjugkUsITWU+yXIR4HUR+rY
 PSx+KmvDeCV2sOIcwnA==
X-Authority-Analysis: v=2.4 cv=fd+gCkQF c=1 sm=1 tr=0 ts=698b384f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=UT5QHHMPRZfFomOLfS4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: esQJ0Mf48nVX52OUg4dOUW5uqfneeTnz
X-Proofpoint-GUID: esQJ0Mf48nVX52OUg4dOUW5uqfneeTnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100117



On 2/10/2026 5:46 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 10, 2026 at 05:41:13PM +0530, Vivek Sahu wrote:
>>
>> On 2/9/2026 5:04 PM, Bartosz Golaszewski wrote:
>>> On Mon, 9 Feb 2026 09:06:13 +0100, Vivek Sahu
>>> <vivek.sahu@oss.qualcomm.com> said:
>>>> QCC2072 is a family of WiFi/BT connectivity chip.
>>>> It requires different firmware files and has different
>>>> configurations , so add it as a separate SoC type.
>>>>
>>>> Correct the sorting of other chipsets for better readability.
>>>>
>>>> The firmware for these chips has been recently added to the
>>>>       linux-firmware repository and will be a part of the upcoming
>>>>       release.
>>> Something is wrong with formatting here.
>>>
>>> I would personally split the sorting and support for the new model into two
>>> patches - without and with functional changes respectively - for easier review.
>>>
>>> Bartosz
>>
>> Yes, I'm now splitting this patch into 2 parts, one for sorting another one
>> for new model
>>
>> support. Please ignore this patch.
> 
> Please stop adding extra empty lines between (or fix your email client).
> 
>>
>> Sorting change has been raised with tittle "[PATCH v1] Bluetooth: qca:
>> Refactor code on
>>
>> the basis of chipset names". Please approve it at quickest so that we can
>> raise new model
>>
>> addition code changes on top of that.
> 
> 
> Why couldn't you send it as 2 patches in a single series?
> 
this change includes driver change and yaml change. In recent
bluetooth-next branch there is a new style of documentation of bindings
comes as "Split to separate schema". I need to re-modify my patch again
and compile. Splitting patch seems more convenient for code submission 
and addressing review comments.
