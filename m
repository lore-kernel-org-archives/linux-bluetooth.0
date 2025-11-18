Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEE225A3B
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763472255; cv=none; b=pATxUQSgyWYQEzAUU8wjCatdUEcaBRnC7QmuD7c5W8Oa75Hptkm4LdZU/UpoYtzEvT8VBKZdIb+ci07aj0eHwZQg72UvY72NSc1Ri+S5xvSuQvHuGCSaPLejMxMXCgryYJ8LNI1ngmFtUIQoEF4ecvVUwQQpEJAiuEgoNorrvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763472255; c=relaxed/simple;
	bh=YRPcOuCWyS3IkB/8T5kzemqn4zA4eRE3UPKIfdMgAGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA4bTLZab0A4dwp9Hsctg9NJhQKDDXltUPeIHop7EO5Lq5V2GM5QAJ0xrS5QDp40M/7EnNed3/+joU2g1GV7AWr2CnjEvCLw0smwLasZ+tiBSVjlDD0os7ffz3dUjKZA70cECkB6iHd8QSPabIFB4yjSThAi7qIpHTQEKaV2+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VzmbQNtA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X+oGahCE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VzmbQNtA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+oGahCE"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AICB3KV2803486
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mT3BS7HYX0OjxoOUzW62R+wISMMOs6OD7mkkhojAy3U=; b=VzmbQNtA4hDbL9no
	AJzSYpKX10KwzUrif06jiE/nsLfhDNC2rUzeyJsTjdGhvpt3duUHBzNcm0eZiFx7
	KKLCxIbrdDlnynq4ahc+n8+2e6FjqbUaTTwaduw0STkDTNcFlCJZ77CLbZlP1dVr
	I/nPTCXSJjQuxpHkEFDcgCXAYfyzJCJm7OCeIjovfdMf/+yPV1ZoO/fp4BQ4x9q8
	1EjHVfNhVgAjI35jYwutdCdlQbbMXsvTOKK1inOoqn2lXMCxh8y1qQiK+WX9vd85
	WS2OF6Qjw8PQ96lL9ZWWuPw8s4G8W5Z7ftUOdnw+C0/2UcgP2P0YMwq1091l9kTS
	2VgPKg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agrk205ws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:24:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-882414eeb90so16518516d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763472252; x=1764077052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mT3BS7HYX0OjxoOUzW62R+wISMMOs6OD7mkkhojAy3U=;
        b=X+oGahCEXfpgYhcckhr71ZLiVUonRG82h6Afw8Cg5NHv1jXA3bM+77TgrpKSDhAbNM
         Rn26VcWqXAkMdkP0ZLSGjRDQoR8EPNzmXnih7+X2QeDgHNrgqxmE4NObSeGuEYn0HSMQ
         i5CQGXJhhb5nZFSdqDzNbvG818PvMNvP/Z23XQ+C0nFKuYT5XH9b8R2sYk1noO1TZMAK
         NhbrHaA9UBvrdEz+WVydGVtRGB3bs5PMzI4ONk2wlbOLX1HptrsyyDBFjY2zfAAvBx88
         JTqF4XSzRBWO4gYU0RKEdCPCkRXKEQXcu++X9WvRC4L0N2Q5haxH8ravWVkAVvmW0zLo
         W20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763472252; x=1764077052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mT3BS7HYX0OjxoOUzW62R+wISMMOs6OD7mkkhojAy3U=;
        b=B4tCImRrfdM3mBoqGWQhU0Vb41b9HaU1YdqvEvSDiMVklIEg3Wicf20416y3WmYHAS
         M5DCnbCSdLEJpKN4h09JGCW5pf7sE/SKW1cxIJMtLp+sazv2IHUiR4WL9tZy2EmpGNTv
         lDh0fyOubsvmNLkPiOXFlsZuH/2mYb7aSUAyX5mZHSOccuCvnSG8ME3HlVNRPskTLrr0
         a2Fd+y3Jq9N3lKlh0t6bO7rqm/on5wB05lghK8ZWYh2gGlAfEOC3v/aBlShqgf0J0SlK
         rzpUeZAAwvCrhKiogumwuK8nmsdJdm6gegwBCCxXDLtx0P5tIjPntwB8hvwADujkHhwy
         lxgA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Fx/dFFNWrTwMbsVbr+V0VseP+idWtXmkvrPfzJilZCCxXVzeG7AVGU2mBFAkUssOL5dMGqn9op0OI8M0cVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/roqKz3B1WTfi/u4z5p8uJlSySQ7n9bnTXqKM8JnhIuE/cQEa
	h+qwWL2WhG6h1R1fQHfv4jPGRgBLJZzQVWli00+xgZqjDWC1Z6RriyOJEHZ+0ixaN1RAem7z06L
	gfZk5S0KqJwoQkQJgfLLA6FhyF7wdwnaZmL6SWZkHRpPrXodSavn5lAUJk2b1oDTeC8Tk128=
X-Gm-Gg: ASbGnctVM8RFMI2o6lOb1i7KG/eyNM4d/Bc4JE82RuKZpn6FQwlcW4y71qzyIypvwXD
	nfmG/OvyGMPGS0C0YYT7IiY5gH306CFGrgAlc94vhq6OHgNHF+WZ5hKLdTCP5JqtTP4naLGRN9A
	lTNgKaV3zunXDTGeDivPLywhXO/mv9nkjrKcpBLphwgNCTgEhUyNngBib/e4ePxZewr2sBkvqJi
	b5EV3kWAdm8yw6UVgHBehFXqfKDMH1xqioBZm6drZQllH826w/JxB83FoVxTS5N8ILOg3YU1XCp
	6/aEw1oZTwuybm/AMJ+b49lnDcHnggXaB0OUxzx1g1CIgtE5FJ0f/gWZ332G00RU5D/lnbegZgn
	Mtl4oN4ltUffBmQt8+nYzkzR/LqP4ikp3uzOocYiiXHzCnHd8Wigt8yzGg9WKz5njF0ayCg==
X-Received: by 2002:a0c:bf42:0:b0:883:7783:9a with SMTP id 6a1803df08f44-88377832e51mr89995726d6.0.1763472251590;
        Tue, 18 Nov 2025 05:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRqlXLxm47/RUttNlD6ATYs2pNgJfsISYFm460SZi5po+LnzWhSuIw5Ny6ZU54jqrLTKE3LQ==
X-Received: by 2002:a0c:bf42:0:b0:883:7783:9a with SMTP id 6a1803df08f44-88377832e51mr89995376d6.0.1763472251012;
        Tue, 18 Nov 2025 05:24:11 -0800 (PST)
Received: from [10.111.165.185] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865bdc76sm113493986d6.55.2025.11.18.05.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 05:24:10 -0800 (PST)
Message-ID: <cef25c09-0ecb-42ea-b781-a4e0d3c61542@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 21:24:05 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: monaco-evk: Enable Bluetooth support
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        quic_jiaymao@quicinc.com, Konrad Dybcio <konradybcio@kernel.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>, quic_shuaz@quicinc.com,
        quic_chezhou@quicinc.com
References: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
 <176313578860.3262114.17056319042303889483.robh@kernel.org>
 <CAL_JsqJX3doLFv-Nc6o+L1W_o8VjtvGp9dqdpsotuyG17zU7Lw@mail.gmail.com>
 <ca6b02d8-07cc-4bc9-ac99-e75d8e3548fe@oss.qualcomm.com>
 <0428a5a5-fd4e-4309-9b28-f94664177692@kernel.org>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <0428a5a5-fd4e-4309-9b28-f94664177692@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a6Q9NESF c=1 sm=1 tr=0 ts=691c737c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tldeaCnzwUXVKdrmyTgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: t5Yoowe3PQkHgT7YZMgacx0TvoM5DGOV
X-Proofpoint-ORIG-GUID: t5Yoowe3PQkHgT7YZMgacx0TvoM5DGOV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEwNiBTYWx0ZWRfXwPxKYAcg4l1a
 AccAljxvcWZYg4T00BOrNpLYZx2UbtOAWaUyxMntQcxaSjwVLG5bhSIurfbj+c+R9KOmMRFExdC
 J+jRDwln2FSCz32kqRL9Hd8+o5TLkQleeVG91l6Hf3mpE/Yj430pKZDJS/qMEdlkhyW7L2T7OjE
 bExhCS6ZGIOoffTwKsnQ4xgIIwI0PFhV5OXfipxt1I47HiCE4YzmqfIEp9u+aAcoGaX29e8miIK
 kgF5FmlRA0xIKL5bylW4W1UN6PPzvyZWx7cIDTc1cr3l2mKeS5Vwr0K3QYK0hmT0rhjvwn0XMMn
 KGQhyuAFXELEyLf7Bp+CEVeM4bGG3jsU6v5l94qV+uYhEvKjGwjbUAJvcBH3SmegEisGywyPFDZ
 e5tm5ElLapSe6d9+EIvPWpc9pTFbmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180106

Hi Krzysztof,

Thanks for your comments.

On 11/18/2025 3:19 PM, Krzysztof Kozlowski wrote:
> On 18/11/2025 08:07, Wei Deng wrote:
>> Hi Rob,
>>
>> Thanks for your comments.
>>
>> On 11/15/2025 12:18 AM, Rob Herring wrote:
>>> On Fri, Nov 14, 2025 at 10:06 AM Rob Herring (Arm) <robh@kernel.org> wrote:
>>>>
>>>>
>>>> On Thu, 13 Nov 2025 18:35:19 +0530, Wei Deng wrote:
>>>>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>>>>> Bluetooth work, we need to define the necessary device tree nodes,
>>>>> including UART configuration and power supplies.
>>>>>
>>>>> Since there is no standard M.2 binding in the device tree at present,
>>>>> the PMU is described using dedicated PMU nodes to represent the
>>>>> internal regulators required by the module.
>>>>>
>>>>> The module provides a 3.3V supply, which originates from the
>>>>> main board’s 12V rail. To represent this power hierarchy in the device
>>>>> tree, add a fixed 12V regulator node as the DC-IN source and link it
>>>>> to the 3.3V regulator node.
>>>>>
>>>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 99 +++++++++++++++++++++++++
>>>>>  1 file changed, 99 insertions(+)
>>>>>
>>>>
>>>>
>>>> My bot found new DTB warnings on the .dts files added or changed in this
>>>> series.
>>>>
>>>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>>>> are fixed by another series. Ultimately, it is up to the platform
>>>> maintainer whether these warnings are acceptable or not. No need to reply
>>>> unless the platform maintainer has comments.
>>>>
>>>> If you already ran DT checks and didn't see these error(s), then
>>>> make sure dt-schema is up to date:
>>>>
>>>>   pip3 install dtschema --upgrade
>>>>
>>>>
>>>> This patch series was applied (using b4) to base:
>>>>  Base: attempting to guess base-commit...
>>>>  Base: tags/next-20251112 (exact match)
>>>>  Base: tags/next-20251112 (use --merge-base to override)
>>>>
>>>> If this is not the correct base, please add 'base-commit' tag
>>>> (or use b4 which does this automatically)
>>>>
>>>> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251113130519.2647081-1-wei.deng@oss.qualcomm.com:
>>>>
>>>> arch/arm64/boot/dts/qcom/monaco-evk.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpcielp3-supply', 'vddpcielp9-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
>>>>         from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
>>>> arch/arm64/boot/dts/qcom/monaco-evk.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpcie1p3-supply' is a required property
>>>>         from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
>>>> arch/arm64/boot/dts/qcom/monaco-evk.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpcie1p9-supply' is a required property
>>>>         from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
>>>
>>> This is the 3rd report of your typos. Is there some reason you are
>>> ignoring the reports?
>>>
>>
>> Sorry for the delayed response. These warnings are worth addressing 
>> and will be resolved in the next patch.
>>
> 
> 
> Three of your patchsets have bugs easily pointed out by tools, so please
> answer - are you ignoring the reports? Are you doing any tests before
> sending?
> 

Testing was completed on the local hardware platform with successful 
compilation and normal functionality, so the tests in this section 
were omitted. Prior to the next submission, a dt-binding constraint 
check will be performed.

> Best regards,
> Krzysztof

-- 
Best Regards,
Wei Deng

