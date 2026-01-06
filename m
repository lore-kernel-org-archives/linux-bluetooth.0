Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AB242D95
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666098; cv=none; b=sfIuUBVD98B4MqDv+59jQsRo062AytQQ3nZN4hxV2uWx9t4WkU9/3olPZ53ysiarCulK1gYcIqVcoxrbmS5zLnPkg15upiXb8ADmu0YogDDj6JSQ1KQCPNaOYrHs/7aE6u66SABFpaxCL7lB7qVeUnSSu4Kr8yPDoOzk/BGucWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666098; c=relaxed/simple;
	bh=/QBwN7mvoQ0BdiuAGuzlfyo9MQ6gEZfYYF1zUajQ7jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHBUnctMpM0Fsf2yBFMAWcGnFwjH1c2fjXIa9vMht52JaWwrTpqUl+rtGkvH2hxJQN1ZxVS9mpPI0fKi2xOe5bAnifSBW4nWwjtS3RRh3vSrNMYtC1wY3sDd4d03E0/pKrHm6fl+cPFI2eISH3f1GdaWHgrGleAQGOM4lhArT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PylSFXzZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cNc+Z52j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PylSFXzZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cNc+Z52j"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nYsh2291772
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 02:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBO20PBppYKjzHh0LvN9MJwZEsZj2XhbXZEtEqOAk9o=; b=PylSFXzZk7Z5gBSj
	M6L+c7+IWMpJSGY/ypzT56r4CJxMsLADg+JZTz0gO0GmawMFR+iCDXHDGGCkz44g
	DGOjaxMWGHA7KXwu5KsO3KcWv+9yyz+dg2hMl2scLOSy0jsW+Bc2ljKFWYmUeE3J
	B686rCfTPV0r7HSBStbVCu9Tw6YFz4VExvj/NAtL7GYguBSq9u8FJjKKwIrSEkKs
	AzeGsIQuGt7tyQdE7c9cW4JUg1Vn0dXNt6yUMw/XxKYx6dufyJj63eHTcUgwY7Uy
	5X3t0TYN7Db0RMTpCyFhCZ6/P4vGgJxAbVWCzZuyQgs73CLAghkY52wSYvMwiyTT
	50CjTw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg79nk7pp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 02:21:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso734200a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 18:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767666095; x=1768270895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBO20PBppYKjzHh0LvN9MJwZEsZj2XhbXZEtEqOAk9o=;
        b=cNc+Z52j40MWcPzfU2xjlbkQaRZ11OZRj105N4w0HTwn2J3DWNUTHqthxOrkyz5Drz
         aesrCIo21prn75Fh99ugq54z94EXSwcUV/+SBza0zLrtZcRjZu9IQ0DJ+J9UMZqz+nKM
         gjd+cNlqq2UXwwB4X+WySDPUoLWGchdzxM9TYWckPmd52MgHtUzArJkn0ZFCQiyz1Cax
         1ZWo1RQnN8wRh0CtbRmhAp1m/JCGdn64EM/+5QT2IPlqOywUjL5RWSHMa28sMEovLMv4
         YKKad28bkDMC7ijBFv8vLJLFb5hEZU97yyZCEM4jN6NJ9rPTL9mNO1jWjUfi2Wly/U8l
         e9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767666095; x=1768270895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBO20PBppYKjzHh0LvN9MJwZEsZj2XhbXZEtEqOAk9o=;
        b=p20vz1vfVtB34WtS/+fb+/j1YS5hgpvKM2nKhePo6zWhH/KiURllIZLmUfXMkbz97J
         sLrS05MZ8+AgJSs/vC1+Q7QbMR0j1lXPBpcIeq4Sh921gIfszQpsJGipjMxA6s6OfQyD
         Wfss+T2DWJogKVaY18qejlKCxfXuYuwr/BMgU0r3Hf1V2DGng0yLdjkSE59IOpJ9XJH8
         xLMbUb6dwJYghPT1IanEsWuK4ILcaQpAUq2J+QEHAJcTh4TGZbktdClVq2/lk8/ATZUz
         beU1QmYumh3kXaEd3niUf5fwXnU6dGV7BOV4VApstbx4WVzVIGzhOrEiZmYmSl1PPShj
         /wQA==
X-Forwarded-Encrypted: i=1; AJvYcCUxTcdTgU0PX6nnNl5KCcpmznymjp0WjyQdWgrA3qTmWIULdr7NsTgQ52uLFZjXhWd1gHNNfYeAMOguem1/dJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYGXzMuKMHxzea5G9CmEnIjn4USVyqf3oYCHnoPOYl5lD4KZs
	JQbaXx6B2vwEubdglTM8bkMFL0S1OCCYMC4fNDiB4k+QYj8wmgrlG69RWUg49U1BKiTAhsmZpUO
	VjQLmeMICUFayAqxeGlgyIO0MXmQp4uAIR9xu9sn9aRFc1rktLnUUAX0dEL69pHC/3WMdAK5FPn
	I6aIEJoA==
X-Gm-Gg: AY/fxX7UdVKdsyQMbjpLLl/14f3d0O28gk4CGb3+7mlo0zFAzY7APlbTItrvlHAw2+5
	hlEgH6WmSRckKFW7ugB2h9xyfiOL6EoFsSx9L44GxSUq/Br7EJxDnfoyciXm0GI8KopB3AyPcgV
	Js4Vf5DCnWlZxhdZyLyFrOqT9wrqFwr7gLuz5yzXg0DEoEcH1qhuYGSoWWWVEgwQ1j6FxNJfrwt
	XbQKq/iQGyCIhKpbcTJ5IT6XntQGvqFOIvhv0HwMDWXMsciRLLqOx2sYR7FmzqcFkdza1fE1wHO
	eOcMg7HlxdJFsnXzBgars7Kab2rR9zLFxiO3PLLUcZtKOkzDQlyesySaoVd3H0yQLZwMTWZZZZD
	MTrGHeVmDkw76By5xX9ZnsAuHHd/GyIZBKKWdqQZr1GhnNTe2j8TmZxX/WvpVKpFZ
X-Received: by 2002:a05:7022:e0c:b0:11b:b2f5:a1f4 with SMTP id a92af1059eb24-121f18fa854mr1180076c88.39.1767666095189;
        Mon, 05 Jan 2026 18:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZWYKKjDQkCHJhiLuRB9dT/rtOLEEoLRbWLBv8D4McSmZhwR/cEPBv63uz8SoRG58/0PuMkg==
X-Received: by 2002:a05:7022:e0c:b0:11b:b2f5:a1f4 with SMTP id a92af1059eb24-121f18fa854mr1180056c88.39.1767666094609;
        Mon, 05 Jan 2026 18:21:34 -0800 (PST)
Received: from [10.110.93.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f23b798asm1364920c88.0.2026.01.05.18.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 18:21:34 -0800 (PST)
Message-ID: <6d29459c-2cd8-44ed-b64f-6947cf620960@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 10:21:29 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] Bluetooth: btqca: move WCN7850 WA
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260106020738.466321-1-shuai.zhang@oss.qualcomm.com>
 <tfdeucc7opjtjuo723hskens3te3eg5ohm7db6tbhompbtgkkq@vsqgz5qtmbr2>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <tfdeucc7opjtjuo723hskens3te3eg5ohm7db6tbhompbtgkkq@vsqgz5qtmbr2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RdZ3PrzR2mNrRSfjDE-zuI-9KAkmqkS1
X-Proofpoint-ORIG-GUID: RdZ3PrzR2mNrRSfjDE-zuI-9KAkmqkS1
X-Authority-Analysis: v=2.4 cv=Y8P1cxeN c=1 sm=1 tr=0 ts=695c71b0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=zPWPNcdd_rTy89SwO4wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOSBTYWx0ZWRfX1homf920YBnR
 yWCSIK+BcRW965arUOCIv0SrBFldf1yQzeqjQdFzYZzNJ/ApH/GNbh7+rpbhVaUQZ65hrUDKHnM
 qyPDNBsRU6tmEbOTIqEllEoergsUZwRniuOj82rWZqnCLmEpB/P77g840poJMf+hL5WI02wF+18
 HhQDH+6ls/7TG24WNv6RKEjTCNi4eoJ7R0pLrhDH3oDmsMQL7mUJSDkesft7rNEHXfmyZfCy+dY
 WIZgSjWK7Od2uoYgoA4r+ChDsdcQbSHMguYyOJOgGuCtPHc6d50GU6K5A9RUqyrjCSNYP0G9oPr
 EU3INY4jIauYxm+s3LAeR0PMTe+OIOOVTe9gJfa94YXmvDzJZSOzgWXG93cyNLyLnnYradONoAR
 agK74tOq2Efhad5Kh0Jbi8FWUtwT6Ed1LRWjNfXvjP4817NbXlXnb2jHfMHkBXuB5n0ig79p8xK
 cEjbVQ0BI1IntWW1Pxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060019

Hi Dmitry

On 1/6/2026 10:16 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 06, 2026 at 10:07:37AM +0800, Shuai Zhang wrote:
>> Move WCN7850 workaround to the caller
> Why have you lost the second patch?


I thought the second one had already been reviewed, so I didn’t need to 
submit it.

Do I need to submit a new version that includes both patches?


>> Changes v7
>> - Update the if logic for firmware retrieval failure.
>> - Link to v6:
>>    https://lore.kernel.org/all/20260105055646.3816296-1-shuai.zhang@oss.qualcomm.com/
>> Changes v6
>> - Add WCN7850 workaround details in the commit.
>> - Reduce the logic nesting level.
>> - Link to v5:
>>    https://lore.kernel.org/all/20251231075817.2611848-1-shuai.zhang@oss.qualcomm.com/
>>
>> Changes v5
>> - Separate move WCN7850 and add WCN6855 fw name commit.
>> - remove WCN7850 unuseless condition.
>> - Link to v4:
>>    https://lore.kernel.org/all/20251226075621.3223336-1-shuai.zhang@oss.qualcomm.com/
>>
>> Changed v4:
>> - move WCN7850 WA to the caller.
>>    handle cases where the firmware cannot be found.
>> - Link to v3
>>    https://lore.kernel.org/all/20251117021645.712753-1-shuai.zhang@oss.qualcomm.com/
>>
>> changed v3:
>> - Remove CC satble
>> - Update commit
>> - add test steps and log
>> - Link to v2
>>    https://lore.kernel.org/all/20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com/
>>
>> Changes v2:
>> - Add Fixes tag.
>> - Add comments in the commit and code to explain the reason for the changes.
>> - Link to v1
>>    https://lore.kernel.org/all/20251112074638.1592864-1-quic_shuaz@quicinc.com/
>>
>> Shuai Zhang (2):
>>    Bluetooth: btqca: move WCN7850 workaround to the caller
>>    Bluetooth: btqca: Add WCN6855 firmware priority selection feature
>>
>>   drivers/bluetooth/btqca.c | 66 ++++++++++++++++++++++++---------------
>>   1 file changed, 41 insertions(+), 25 deletions(-)
>>
>> -- 
>> 2.34.1
>>
