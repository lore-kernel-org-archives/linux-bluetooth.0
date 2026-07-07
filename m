Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D852DC782
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410706; cv=none; b=m9RrbV4TMnEViu4auDUAKotQrCxvseKiR1kZbJHuwtBRFNdgWVUSA+7eeLqUb3Tmh1bFjTZqpiGhRWoKlPith94vJEz5iW9t1NR9EyQHwTms4nCkh243RzW8YHLM/3TxtXOeZMg7EgEtPU4suCshhHCRSpdRRMTFNJc8zQV37pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410706; c=relaxed/simple;
	bh=GTQCbbONJYb5DhiScbASo8gdRnlKVRI049kQ1W70M00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrFtrXLj1VMcYbY7Mk1nv+er9X06bqAk5clvg7dx6xaB5T5DNzYPPjmbYjwJBqdtYYaQQYT5ddNNKyT3comu9We1ZhYjGE3+rmar5XDYifmUfMzwqA1Txna2OVwpZ+r1aEPaohhqNQTcuQ3SGehgL6hgxLGflx7x2E/Xu95TLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXYE35xw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T7kzjK8O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXYE35xw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T7kzjK8O"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6676KbK92922726
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jul 2026 07:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGsKHl4+WtIZmZys5q4B4bjUDscQEyhEgFF3Vd/4R6Q=; b=jXYE35xwTgHmf+Wc
	/NuQ+dJN/CTmFW4o7MJT2nXFyp8G8pVk6BAh6BjYOtzlgGDt5d6gjQ0nIcGkd4Rr
	1yxra+rSe8pfYuGP/WXLg52thzqEb2hz2jkeFXJHNXcrDecpW0vwCu6mrdLFti8Y
	29C3jLip4ULi34m+MTGSVtomRJaQwKfl/eiLDgMwRo9MF7lBfY7g5bjto3RcMAhn
	wAYoFEl/aJ5onuzRvQK6xM2qVxwU3J07xm7ufjRjP4y0yV34rAIpAG8O+B/jCeRN
	1BhwEV+CGKYbRT0/1EqYn83kb4gHdggrbBcQnN2mJ/2pbm/9Da2MeSQDZz4te7QG
	obAPzg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t8br4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:51:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c27616421so14381901cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783410703; x=1784015503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGsKHl4+WtIZmZys5q4B4bjUDscQEyhEgFF3Vd/4R6Q=;
        b=T7kzjK8OILfkOvZFV1wp4AFbZq06QPTA08uGetPaJuAgfOOzyL4iR5o5zkFIKS4Gqn
         DUiccuDcRr8HyX5JMgZD3nRfzaL87/c4X+3z8fFuU40+qHXdzVGmmgfb7JgsRZ2LUJax
         MY33tBptnt3uv47M1Ibo7q2V2OoXWTp0pU04Zu80guehdyo8j8EwzOm+kA1A7wnHYedk
         gmJNCv+SuKO4uvB2I7UDeoxv8YVdS0hx7EjaqgeSiM0wOxFiQ+yzceRpkxJjQi6D+Zgl
         0dD6MTepS9AGeLEULj2CHImVWp8pcDosNF/StNyq2BsB4IYH3rfT8GO/BPMgTYWvxYhn
         /2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410703; x=1784015503;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGsKHl4+WtIZmZys5q4B4bjUDscQEyhEgFF3Vd/4R6Q=;
        b=FqTtW+0FNbO4oY+WbOjb4J5b7XL0bvLtaTAZjs4i7VnsZzEV9P8V13Vw/BCugfEw6S
         LxArbBKM7aSjccSMPzz9W8ks+oir4ax+nkb9OaWdJqSTQHNdr1MM6DR1dPTa7pEnIj56
         KgBCInQrP2xGHzdmc69nDAMGN5XU9VgOAV0ZQxX9aAf3Td44+yWtw41EehgDBgKNus8q
         v13jLkKUb7CuSFJUbq1HyDqnBYXby110ERYyXjZUiRQcWUsODcQgfBYWWztphAQyPBzS
         6/setcJ+XmtrHzlQpI6VjiE7uMw9l/xKAFD4Ol1UOa+0W/e9ujV5iyFakl7VM95iRp5S
         2HaA==
X-Forwarded-Encrypted: i=1; AHgh+RqRy7GTe4C7i+zKnZv273hshG+QOYv5LxP3mG62nDo5XvlR7vR86GQAyoYPejlhdowf8eF4ZXkfXyyEoz4Qbzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8VapSr+zv3FVJULxANa6w6XQk3M9t0bVdQWeqDYeL+nos4/2
	Lv0nDFX6Vzo5hZsM1WfbhlroPRhyIa4XVJiLO/5HY/zSVVkFIt2tUbXf7r5IHT00LxBWkCuklr8
	mc1rkfn5zi8Lh+bOvyu/fe6bPyS/A5/B71k8AkFGZ8nhUGaTxqo0S0DcU5F3arinF8DZ4Ubo=
X-Gm-Gg: AfdE7cmPWJgE/wV4K94Go1FT2mgkxUS4eYftBzqec+b0KCe7ACj5SeNyUDH9kYRohgY
	AokELeU0ZqYU1mWrjkX1rsqwydC7gbn8wpyykbEbeI3mPvSi0LGr1YPKPZdwJojx9vfonX7dgLO
	Gp7qc1BueszSwAqd05MgWz/orxMgfGEMRv9awj/lOXBkwlix00yViCBdpShkUHZTvS81v1Qqu3q
	2vE1p14EtcgTbsQulmGy7RPkIasS0E79SAkZmANM6SWcRir+/mFu+7xSh3OZ3bd1HOSAestW0G/
	RkGVtQi4cbJSwFy0iOR4NsIxGXP42O3man0hWYUnv5RqwJMK3N/VyLDaBIt3An9I0GHDMb/5L0q
	YrZdDYRlVI9pSb9/cL1vBHrBCJU5+OOuC21U=
X-Received: by 2002:ac8:5710:0:b0:51c:db4:3cb8 with SMTP id d75a77b69052e-51c4bed6cd2mr121678311cf.8.1783410703133;
        Tue, 07 Jul 2026 00:51:43 -0700 (PDT)
X-Received: by 2002:ac8:5710:0:b0:51c:db4:3cb8 with SMTP id d75a77b69052e-51c4bed6cd2mr121678191cf.8.1783410702706;
        Tue, 07 Jul 2026 00:51:42 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d79906sm5534277a12.14.2026.07.07.00.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 00:51:41 -0700 (PDT)
Message-ID: <6a312986-49b7-483b-8253-5bb3b842ac34@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
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
References: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
 <20260706-ipq5018-bluetooth-v4-5-350262a30959@outlook.com>
 <6d8c0326-1b3e-4eae-b528-22ca77dbaf6d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6d8c0326-1b3e-4eae-b528-22ca77dbaf6d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LWiXTgjY-BiGer_VlTs4sBFPGpaEpl8f
X-Proofpoint-ORIG-GUID: LWiXTgjY-BiGer_VlTs4sBFPGpaEpl8f
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4cb00f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=iO9hu9iUymBLBQONcncA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NCBTYWx0ZWRfXxsDrbq2/jCsE
 67wIwatq9gXhkPJo1Jek6t57YRQWu66Kh90K6rwzpo2Kmtr1NCoDXyOCSgQZ/5BNpfOnKaY8Ga1
 bWfk8Dm2lw5URThNCVb7gtmWI7FECxXXcupEJCi0l4Lbwij/fMfsDSqoo2HZDUVf2jPfXWfTpdj
 fEAK4jD0Za6qjKN+pJ1ehFVxn+9bsCTIiAQL1RNP/2J78R6ArvdW9TXUhO6dFPoE5ZB7l5o9uVI
 LcrC2M/MDS3GLZcv+18N8rl2fB6k82V7gHdmhXNriJgqjq2xxe841OB5rz5ZAP9fr6bKucInVWd
 BS8tY30niicqqkWA5+QmzsiO5j7Zqosuc3TNqSVPmofXbauFBqonQ9VmeMLmOvRleaBan1mff+j
 zsaJt+szWkaYWTpf9p+zlW9pxCrdZgJwcZ1HMEDCMsJweHFhELUFskwuRqoc0gcEkRk7wnyDzhL
 IS8T+U0RLzSlj4Do/ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NCBTYWx0ZWRfX6oA7GV49kSln
 VM3g0l3xsx5w0ndvIJ0tt5MP0UcUO1p57U4N4Og6BKjElAmtOgS6h9RkQ0VFsHcF64SslmRtosY
 AS2L6u9JRdfsIwJdZKGGMoyEAA8Fxm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070074

On 7/7/26 9:51 AM, Konrad Dybcio wrote:
> On 7/6/26 7:26 PM, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> Add nodes for the reserved memory carveout and Bluetooth.
>>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> [...]
> 
>> @@ -136,6 +153,11 @@ reserved-memory {
>>  		#size-cells = <2>;
>>  		ranges;
>>  
>> +		btss_region: bluetooth@7000000 {
>> +			reg = <0x0 0x07000000 0x0 0x58000>;
> 
> FWIW RAM starts at 0x4000_0000 - I'm thinking whether this should
> just be the 'reg' value of the bluetooth node. This makes even more
> sense as you write to this region using I/O accessors

FWIW2: The region is called "BT_RAM"

Konrad
