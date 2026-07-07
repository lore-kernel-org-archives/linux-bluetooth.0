Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586631327F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412860; cv=none; b=nkKyDtes6dso193kn09d0OkdVqmZtNfG+pWI9b89xB3G7019PD6r3Zjp+/CW6FDjAX8cT3vSKUUhqlrW2UfIOUmU7jPo6CGFuHmlSj0w/J++qMHJvt84/TEMb++rCBpLaQiUwaMUjVy8VW62/q9JGGqLazdIlHuUo3KWLPDFu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412860; c=relaxed/simple;
	bh=rVjNLV8fcin1IfLO3gAv3V8tbKv67Km9LTOAjwI0Df4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIh4qckqwN0f5dkyT4MAohXQRkCnKIJI5aamfG1tw5piPmWaLcVHKOIyW8eqi48j9ViFFEbCsfLHmG3ART844izp6FgJuFHNy/Tksk/AzR6CHBhKS3L8uK0thN69gEkYbYTKg0uhJgbZIYXESVl7K6IqDdk1dUR/o9TccpPyFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hd6olM5O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GhE3vjZ+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hd6olM5O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GhE3vjZ+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678Dw5s3070370
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jul 2026 08:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V/ZgBEwLyfyIVk+OdidjeJ6wnAs8OCnD38pl/d4BiaE=; b=Hd6olM5OvIkTE1Cc
	3IHxUJsLzoapbKi5IvVWbpt9Di0LLrbGe1Q0+zR8pSMt8/JsGBPtVlxI54IxVk3h
	yLAmZdmnehhBSvVGyxpFnWL06iIUb5+9PdjBqQL70ngtwcTbfqNomy9/ay5UcBNr
	wxFkCc8J3pSwwd5Vhgsk2gk/PPuGh0MeJjTSQ9eG3SE/2Uf6LLs5bzSyTfTzV55y
	9zjTDo+doOmTRuezCNLmpJPRHxDpiAqyIj0ceSq3NVJw/2GuMK1sylikDMtJ/K9a
	FehGr8ut4LaZk+xXixOKeyLrThP1YFLkY9fSAXz24PiL7V9no6x8XRULiO/ANSU/
	Ao9xdA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8h1c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 08:27:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c15c77619so9116651cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783412857; x=1784017657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/ZgBEwLyfyIVk+OdidjeJ6wnAs8OCnD38pl/d4BiaE=;
        b=GhE3vjZ+KpoXM/pAMjWGUIiUUvgvQhFIV8OyCW1K4pYCQI+qMW7SeQQMcfXfIgOsp4
         mIfO5tkSo11uELzsyNOUyjqlWQObXJ9SnZHBWOnF7GTOUcPs6dl0MyLUn1bRn88Uyc+G
         h3JGZeWLtTKxwzzIQ9+ALoqvvSIcNFtuEwU2a39vhfrr4Jn3kbPT+n9OtNHh/wTfeW5N
         G4EzBXb1yMd6L/nn+5p2cbhk28bvspegTwQ8tJdgcvdYnKEgRkL/C3Wa6pEtw9yBX0OP
         AxdfstdWf6ftm7X3u78o0zyPbUZJSuNGqYKpThxc/a04kc04ZzK8TKvfu8ELFPJ7Awni
         VKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783412857; x=1784017657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/ZgBEwLyfyIVk+OdidjeJ6wnAs8OCnD38pl/d4BiaE=;
        b=FkkhLUAc2NwR1HPEXvJnPHmJxniSGZZDrsxyH8J3+sJpoAWKnTtDMAPdPZBQmeOZ+6
         HmfLxCQh4ytU2SYQjYNlfq8gfaJ1csxsCpUW01iIgcQvNYBzMTTqg0qwW+gsjuhZ/LXT
         5jn52l8cIk76kvONzgue0UXtEig/6tEQfWyFKx7p/yZvbvWfsUN3JVkGWyXEqDzIKdAM
         reA+kEa+q4UU2RwIPrS+Cxctffn8E5b/bwJdth1LclDUsX1fPxOO0AeHqCl7Z0w0gRpA
         8E9hBGLcubJ1gnc0i204BG978ZNGYuSS5O3a/K8zIlZYct4rSX1DjvnE+QWu9kKOdSVJ
         Ckaw==
X-Forwarded-Encrypted: i=1; AHgh+RpRIVjbmbcoTYo9FxyS+0y9RR/jI07GNkmpqMg88FX28s4y6P4TE2yO0C/aHNQYaswg4BH+7vbp5ihAkM2sRmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmvl0KJBTo+EdM64xgCzxjml+Qluunhjy50dqMHlYO7H2IDvU0
	cGpbf6jUWic6Zqk0LOqv2vYU5k5J4ilsHd4zmWwNVuyz3mjvmIRNA6ZFC460BmdvtIf6O9wmaz2
	buB+Z+1hdjeyn+418UZPxSLzix4JMEg/pih5DKthP6Db5WLsy6uj0X2Fz6ylehXvfBRRbUrU=
X-Gm-Gg: AfdE7ckVpaa5yILXaRRmC++xSNXZYSv4hyD6aVTlJ65eUX4y6QHhPzhr7z58p5H46pY
	Ve6CWsHEHaRaf3axieNU4TmbChUofXUVx8/zfd4jyCxxxI8aBMPdz7JhnUYFFk5GxiS7ti/IJY5
	hi06kcMvpl6kmn7yogyF0sh0B1JpQVcI1u9GfWxyXhzIs9LndmlgAI2DbWdBFqkx+wdg07m30km
	7v6qxgqI9kuGdNoUOHxaxngiya8WWz/wgD7KWA8VWZMwVevtmOPGuUtF6K/JlEJLvuzRIadeuez
	aF/UkRi6xTao4kzzU/LDmYrexYpK/CWbfAY7veCsVFdd0a9BLxjqU6MW88WJDjbYT0hTP12cqoT
	Al+I1Ikvw3us0p9Si8rU48DPCUFnWUFTwtp8=
X-Received: by 2002:a05:622a:3:b0:51b:8543:cbbd with SMTP id d75a77b69052e-51c4bd94c36mr122379411cf.1.1783412857083;
        Tue, 07 Jul 2026 01:27:37 -0700 (PDT)
X-Received: by 2002:a05:622a:3:b0:51b:8543:cbbd with SMTP id d75a77b69052e-51c4bd94c36mr122379271cf.1.1783412856618;
        Tue, 07 Jul 2026 01:27:36 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82311fsm81296866b.8.2026.07.07.01.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:27:35 -0700 (PDT)
Message-ID: <edb2a1ad-4213-420e-b494-af71da00a213@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: George Moussalem <george.moussalem@outlook.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
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
 <6a312986-49b7-483b-8253-5bb3b842ac34@oss.qualcomm.com>
 <SN7PR19MB6736F66FB96D6A43C128AD719DF02@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB6736F66FB96D6A43C128AD719DF02@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MCBTYWx0ZWRfXyKX3r0xhWi4k
 ZZjU6GveV+1QbwqWoI/6xrcaIbtPvFQVX/fGngC+YuqPT7ProRY85H/+qFBBKPDZ/iRX/2W9l7d
 aiBxof1k2lwtL3ip/D3Mq+Ab+0mnYHQgPZtDybfee/6vumRiojaIjKxd+3dN2Y5nxqUI9mORQKQ
 hbRNxkjZN2YX8qUOgGlj+Xz/d+PD4lGWezwFcd12Y8QVLgpLLwkvIcntkBDkmazLRpowVxHRfAn
 KQGSL7ou3dYVn+eVNkEoiy9eelwLpd6W33cMVb6Am7t049DkVdwly73WzowGU4Kpcrrw6B/L0ZC
 kqaiVaSPGH3R/TNcds58gdL/VjGy/C72eNIivEC1YtCxlNj8xIsXYFd8KlLkIHPb2Zdi+3NY47m
 oniLBFN9kcerI+RmXg3uKueJp/pOqIeggrY7Tl9hqUXL5JFcZr0sNWRGdJEcfOlsO6j5IOvCxl/
 fO3QwtfAyM0psBsMzBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MCBTYWx0ZWRfXwXPnoE0Eba6Q
 ykN8npgPRJ0Mby9Elxg6lJH4RrTLNXt/x8nuyII06fBjO1J1BFyUQhff2zfKVn+nxs+q00EHhlb
 iynyxeS9qEsdzfM/s9Iq0IugJHE38B8=
X-Proofpoint-GUID: QI5dgePxEwd1PeKztrd9SIuXObqigD2I
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cb87a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=5lF2iwBCjgZWocWpIzkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: QI5dgePxEwd1PeKztrd9SIuXObqigD2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070080

On 7/7/26 10:12 AM, George Moussalem wrote:
> On 7/7/26 11:51, Konrad Dybcio wrote:
>> On 7/7/26 9:51 AM, Konrad Dybcio wrote:
>>> On 7/6/26 7:26 PM, George Moussalem via B4 Relay wrote:
>>>> From: George Moussalem <george.moussalem@outlook.com>
>>>>
>>>> Add nodes for the reserved memory carveout and Bluetooth.
>>>>
>>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> @@ -136,6 +153,11 @@ reserved-memory {
>>>>  		#size-cells = <2>;
>>>>  		ranges;
>>>>  
>>>> +		btss_region: bluetooth@7000000 {
>>>> +			reg = <0x0 0x07000000 0x0 0x58000>;
>>>
>>> FWIW RAM starts at 0x4000_0000 - I'm thinking whether this should
>>> just be the 'reg' value of the bluetooth node. This makes even more
>>> sense as you write to this region using I/O accessors
> 
> I wasn't sure whether setting the unit address to the memory region it
> uses and write to. Perhaps Bjorn/Krzysztof can provide guidance?
> So essentially, the proposal would be for the bluetooth node without a
> reg property to look like:
> 
> bluetooth@7000000 {
> ...
> 	memory-region = <&btss_region>	--> which starts at 0x07000000

I was proposing that we remove the reserved-memory region and define
this register range only through the 'reg' property.

> };
>  > FWIW2: The region is called "BT_RAM"
>>
>> Konrad
> 
> Thanks, I'll update the node name of the memory region to bt_ram@7000000

Node names (between ':' and '@') must not contain underscores, use a
hyphen there.

Konrad
