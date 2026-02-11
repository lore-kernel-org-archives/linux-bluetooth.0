Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFA318140
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770792053; cv=none; b=MVmW+4kMo7rdDoYdnXtUYlRskt7IRhUq1WU64TmRJs3ZdRg6BPCm3PwDSsqppGVA/nnEAtT3HzClW7CpydomNgX2nmm11ljSAg7APvW/JNpbi051yc99vqTdMJ1uNTpaF9chrBNB9CirnjXVZo5c3H1Zv/wuzegqgcXCRXw34qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770792053; c=relaxed/simple;
	bh=YH3FuVlgLgd/E3WmPqJzg+c7wtZLF8F2U4xBPchRE6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vchbw9tnMXy8jidAqlLNvdmDMZ67Yq7e5z8aNEe1ifCIzWiL51RJktEicOF/y9ONyrf7g9vaNq/mCr6xMlQYZQfMGzDSKEduRKXAUUiyjwWZgG7tdSTNJ9Rcp6ricyh2o6QDALbFyD6Ne5TlnQ+Fu75mjKEs1Jeqtm3ThQV7PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+Q876rV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ficDGRyd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+Q876rV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ficDGRyd"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B6C7MT2640777
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 06:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bohvUBFi4Gh+pEokfjbsD5VJpip/y7EK4T8dlIQ7NvE=; b=H+Q876rVrojGIspY
	0gklgrrHdm1gHkkVbrpSWh546jcMGz2tgTP7N1StRgq2dHo46XVAUh4lOB2QARzM
	DHQHE20E1l+5O9kfh8CXAzzaTzYK5Yzr5I+Cr39oqx8HpFC54UMyUe1WdIRwkPAK
	/3tj41PMt1VtKlOzS68tMpb/qWgyAyWfoh3txTNlF3bpDyClhf9uAocTgya+OMVw
	cRYja4vHk8yn+ko4f4RKDjYsAh6kJ3GevwaM+EOJIFGF03lS7LOQFxJI1hfeuSMl
	GpdM60bAPCDsnZyIBre01K3wtn78kXgyhhY7npkIiYPzaI/3dId5DeNcxcaF4sMs
	ma3bmA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8bgnhpjs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 06:40:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b7ef896edcso24541759eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 22:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770792051; x=1771396851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bohvUBFi4Gh+pEokfjbsD5VJpip/y7EK4T8dlIQ7NvE=;
        b=ficDGRydozrGXmPTtvxh4VsZqczpDzKk35f/G3CUrX3t+7xGk57FrABnb3D8r4Pw5b
         FLMPV+3rt+ncCVFKtfCsl1sxChjqDNPzqCpYBo+SZUk3YLt8ObErnU0CAqLQ2/+JLQSy
         INWvF6Uo5j7Io4BVhqqSXJRiXQ+lf01JWBx/fulEBAY5Vl978c1qX9eFl3Q+xuT049pW
         lmcDyXKCzLJnUyvN6RbseRoWSEVPywxQnWTcFjzz2xMmgIToFyO58KObbn10VCSEfe2F
         djnEpyh4UdbQIK/fHB2lPEtUGkDg6QdCNnmdID+8o6Q//m3ZnH/xSfJDH/2evIvQjPc/
         wJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770792051; x=1771396851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bohvUBFi4Gh+pEokfjbsD5VJpip/y7EK4T8dlIQ7NvE=;
        b=Pm12B9zFDoUBx8bhg4qJZqYV+KfiMEx8HPMSM5bS7nHTxVgbinS1fhD6LHYPt+mJ3Y
         p3oCv//RInIochmdB+IBTINIzKz0VtfHee5riXQK1fq83eXSdvgw9cXXdBSPXDaLl6Vx
         XhvVp2R3xOfuAz9GJ1GsAWNQhIMv3Wydu70QnQfjd3/OoVVBXnMppOTzfQm1TWxQE0yi
         UkpJ7jc1IKqA08MDh1pa/z+6mguvh8Dp55oSiinBVX3J83ax0cFLppkq5DtO+bWtFu47
         6EFBo0L5ayNpaQxPsThtT0XpEeUR/5Z523LaR9Y4oVglk2pyueSxkKMVY5Ph5C6yvA1J
         CEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNF8fatOPVA+IohsBYsYXYv+3VHZ6PFYzHa9kCCD1/kRNoOQ4ut1Q3y+BGNJJ+P074qIFuwu6BSTiCH1mjO/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3pqxiGKCQDG79KjNh7EN2l95WXjUDTHw41Aw92+RKsSAp7X0
	6TCJap07x0KKn8VLa2rs5HLsIziIcVEEo6/IlrDFC0C0g7gx3R/gdLukgL319MHmNjwuhgyGonD
	Bpc+mopZ8UzeFEtCteXHYWk9f1LnL3ptoGCtM/BWjPiJ0K6BnIU/KkEFUYFok5GagL3twrlw=
X-Gm-Gg: AZuq6aIPqMDUWgr2A7AWg0nkxJ/S8RAslpH92h2LA7TuCsbSLmkU8YYa72a1N2Bc440
	gqTtRwSeZkb7lf1+N99Of7Ic6l4WdnGRfLk5Ytr7YX3KcBE1xydePryh2FNaQLH4DxjtnKsBJCA
	zaWmlo3rzstvsi+zoIaLNbrKY0Q7nF4n+5PpUYQQj/EGFdnpmAr7W5ypguiH3wzit+yfjQmRPu0
	OA/f/Cy4UTmixCwH4rzcgGfV6YFWEGaPdEQtTFL8FtWf5pUL8JUgtkhfCQMVO4KAkMRtW1JhfJ7
	OFhsN0BQ0J0z/+AeC1f17kVx96Mj47RFWBIAxyCkAEF8jFuVB1ILx7aqByJFVDn2CYHwqci4BL+
	+Y7tdyPTUr4TwUY6kQhF0ENrBQP6Y0mCexHWCsPHhIVNXyN4o
X-Received: by 2002:a05:7300:ad2d:b0:2b8:2910:dcae with SMTP id 5a478bee46e88-2ba9e05aa79mr393344eec.13.1770792050557;
        Tue, 10 Feb 2026 22:40:50 -0800 (PST)
X-Received: by 2002:a05:7300:ad2d:b0:2b8:2910:dcae with SMTP id 5a478bee46e88-2ba9e05aa79mr393331eec.13.1770792049996;
        Tue, 10 Feb 2026 22:40:49 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2aadsm686093eec.1.2026.02.10.22.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 22:40:49 -0800 (PST)
Message-ID: <a1597998-f996-41e7-b100-3fd20d1130c3@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 12:10:41 +0530
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
 <dada4a44-f464-4325-9082-50029d6a4555@oss.qualcomm.com>
 <CAO9ioeWhNO1vYVvN46wNfr2NFAjD-oERLhMKTXyRkRDLtJTMqA@mail.gmail.com>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <CAO9ioeWhNO1vYVvN46wNfr2NFAjD-oERLhMKTXyRkRDLtJTMqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1MyBTYWx0ZWRfX9QyP8SCNqIdu
 6aoWHh9nfituIHQ1oikTZZFz2UrgK8iwEf+Rr5EG2/zoG6gsHy7oJBDpxylZRbOubBloHBZEpVl
 1bLrDNOHfqTH7j/ZMxkXjMNW4MLuQQkQvIHutOICiXRPP03xI8x+QsrIGZO1hc0WCcIMWYp23Ay
 HGUf6re4c/gpf8ZGqs/vweg8Be4X5itZTkvzMKtkA79j6uUTmzP5XLhojioOCxOQ7LXlE3iqKLd
 ojY+VZKgEECw3JH9U7WieajzR6KtKzr8DHnrmX4y3csyIAtT3a80VKJexoKNhpsYXSUGQeyTJty
 hYsWPBQDMHkXUMWSRXvXY0bYRbkNLhgYHPUwMJ8XWnw+M9GgQs4aLfkXspE6SWF3JZVLP/Iyl2K
 Qnmf7KfXZZ4fWgCX1aAVFWxzb3IUPb4rswnzFe8Tn0LSo2z8g3J6V4x00BiLyG9XIuF3HL9Qalu
 U7XA+4tzqZL76lEUinA==
X-Authority-Analysis: v=2.4 cv=TKVIilla c=1 sm=1 tr=0 ts=698c2473 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=xrSJ1D06K7msiDK0uVkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: NJyHRRtch74-tExrmIPnegMzf00WBWL9
X-Proofpoint-GUID: NJyHRRtch74-tExrmIPnegMzf00WBWL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110053



On 2/11/2026 7:18 AM, Dmitry Baryshkov wrote:
> On Tue, 10 Feb 2026 at 15:53, Vivek Sahu <vivek.sahu@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 2/10/2026 5:46 PM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 10, 2026 at 05:41:13PM +0530, Vivek Sahu wrote:
>>>>
>>>> On 2/9/2026 5:04 PM, Bartosz Golaszewski wrote:
>>>>> On Mon, 9 Feb 2026 09:06:13 +0100, Vivek Sahu
>>>>> <vivek.sahu@oss.qualcomm.com> said:
>>>>>> QCC2072 is a family of WiFi/BT connectivity chip.
>>>>>> It requires different firmware files and has different
>>>>>> configurations , so add it as a separate SoC type.
>>>>>>
>>>>>> Correct the sorting of other chipsets for better readability.
>>>>>>
>>>>>> The firmware for these chips has been recently added to the
>>>>>>        linux-firmware repository and will be a part of the upcoming
>>>>>>        release.
>>>>> Something is wrong with formatting here.
>>>>>
>>>>> I would personally split the sorting and support for the new model into two
>>>>> patches - without and with functional changes respectively - for easier review.
>>>>>
>>>>> Bartosz
>>>>
>>>> Yes, I'm now splitting this patch into 2 parts, one for sorting another one
>>>> for new model
>>>>
>>>> support. Please ignore this patch.
>>>
>>> Please stop adding extra empty lines between (or fix your email client).
>>>
>>>>
>>>> Sorting change has been raised with tittle "[PATCH v1] Bluetooth: qca:
>>>> Refactor code on
>>>>
>>>> the basis of chipset names". Please approve it at quickest so that we can
>>>> raise new model
>>>>
>>>> addition code changes on top of that.
>>>
>>>
>>> Why couldn't you send it as 2 patches in a single series?
>>>
>> this change includes driver change and yaml change. In recent
>> bluetooth-next branch there is a new style of documentation of bindings
>> comes as "Split to separate schema". I need to re-modify my patch again
>> and compile. Splitting patch seems more convenient for code submission
>> and addressing review comments.
> 
> It makes maintainer's life more complicated as they have to cope with
> dependencies between patch series.
> 
I understand, let me see if i could send the patches in single series.
