Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B152F9D82
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449643; cv=none; b=XM8R1r5rJoKqApP7KVxkr2qtNm/lwaOnmXbS27LVe/Jq14VA4EZm21TTJcHENjlEJjx3JyTIL5LtAjwlbWNN8kkgizOOhWFvTe9cVb1gkpWOiXIjcp8fS5hWwMYdGGCI6wnf7HUWQcRlPGwWSw1mFyFGvt9Xc8NzHl6GnScuWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449643; c=relaxed/simple;
	bh=sOeaUXxsrFJtN9a9NiKmF84gRMiymY8YXaaOeKHVjHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYPE4FnYq0XYJcfypYgWMODqrplImzeE0RGQ20I96gKLEV4gP7UHP0EmwVemce344wvL79TXJmCegJEGX0SXYxDgmPci7pKp9LWj3i2qNESxjQLnrT34CQDipiqiyR5kDfsxkOGLHo4PT/vrMpOy87u6arxPD5nv9VJGTMy9ra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hS6TJsmE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gf17vfT7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hS6TJsmE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gf17vfT7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6Uqtc623738
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 07:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B/tZKMyVLNtLQWWg+Bp8Zes15L6VB/BxyRP9zm1Ku9s=; b=hS6TJsmEzcfsHRAp
	qNFbzYKbDiZAlCo36TcXLt+yLqAQysBHG7kMNzcAYkCJYOyal92BR7X3EAbXZJ0j
	/NMwJXpBXhiwiNaE2kWaZq211j976wElOs1T/jjzzvzpICSa0UrGQKS7DchZaLQb
	6nfCF/gzBNuj8DYzb1+wtupYxdVJpD6k9kav6Skii6bCjbTIZ8CVkZS0RVMCrNT1
	rvEoNWeplL0lfqgFQ9KHRq4u/7zFXM9/9i8ndhK62FhyMbofgMvjBYsyhLcOm5+6
	G/zcWcnnaltFSTkvQtds0Rs7hkp5aT3ZYlmx1xd0INm7BTe0xa3/bzDEdDXgXjW6
	Rj0D0Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agahf9fyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 07:07:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2ea2b51cfso57000885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763449640; x=1764054440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/tZKMyVLNtLQWWg+Bp8Zes15L6VB/BxyRP9zm1Ku9s=;
        b=gf17vfT7J5AQCwBxbS0+DkTSpjZyXOr8licUFtIUXVs6MiIg3B81ftVWnZ0ZfRb4L+
         HpketBwrLfpesyr78Sx2JJYODSxYD7ntgAEz1HpH468S2gBr8+BZrLa5uvFPI9E3O15L
         8H1TTNuf2h/+P9OqfMaYTc/NeCoXKgxnPu3nGB3wNwfvJ7vC1hpKsO1xiFGM9p7cnVEP
         +sLFdQ0NU0I6Qh/zaqoF7p2g6EsuW2wrrZJ+379pFcNDao5SEtnMhtQx0pfpADhUm1dB
         52yqpjbdyj6lt1RYyIsqrC4BWgCnG9r6/sjnUptW8yrIyYT7CxYirxKc3LK0raa8x3+C
         Ufnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449640; x=1764054440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/tZKMyVLNtLQWWg+Bp8Zes15L6VB/BxyRP9zm1Ku9s=;
        b=cG8BLomq9NaXrbbrXH61rAX0AGITpcbOv0TZh0OVynSOTxlKvdylkdteF9mi7Tz4hC
         1Fgf57cYZhgyYi0KLA5K3UFG7mupm/tAh0ud/Ye89GomSIIYjfnQxo0jCyYyAIfuTq+p
         Dg+OOd3lK/7SnXS5Yg6Buj8GUzLCY6fUfzZb7ai8AUREnm22W00UTh8VLfqj5SF0eCL0
         hRkcDvk+ncHQcNAV9465hq4s9zOkM+YLtP4qjwGTcLUuxiW0FDQ1crCoiyClGhULYRcE
         u5oNYR+v2hjvA1JK6NEr5hiW8+naaMWClnMr300w661RqST8kDukdf8oU+dszC/si4Zr
         iKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMQcGBL78uIqfbIpMd5FspYKV8PvFBT0MmHSUdNoNMu4daM6ylINWrdq+72xHqZ3OAA+l6KyrIFfi36oAWG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHLNJVTXlLhG3wY4LERHeQ93jJyC+pqWT9LdpHy7Ib/882LSA
	BN3xRrs04GHwZL/o66UaYpKnQJFnJJ7xqWi1fg1thyua0fgCtapZpQJnh309PQxoMl00jfwMQLk
	oO+89RqyN32xR1pzKrapcL1VbMTVm2CDXlK5r0zlIkaRap2Fwm99DbIqHn958hnlWCLT4ssg=
X-Gm-Gg: ASbGnct8SbSJ1nswOEkAHFX2wJbiXiUkZhGdmFsywosv729Jyk91dVQOOP3NS9PJcOu
	yseCPpzIfk63rB3vZkoW7v1l0H/8NDCJ58KVF2RAOA4DQ7zrqi+//W1w2KTfrW4cZHnKAWXQcvW
	sL3SAJcdybgV1TCk59lEkDODtoY/QJU9AlzFjNzPgo3EL45eLA7E3w6ZAcaSQ8M5WZfuWnZTj4/
	6FDIeoxwOs9GXlv7HNuGZxAE4Kc6YIYKn7RQqz0gh0HIlmXGcVxJIKHeFtlbRH6ZrvI7lsQ+yh+
	4SRraKXg3HKpUYqM7iYxja3ck68ZZa1bBLN1hbWzn0Mdm+YUtNOHKKDCHS0TLTmyY3IbfHe0PvH
	eV2wFr8apg3QLhJMgmNyGNHNtjI2v0H18PdzPRUvHvRiuYZz8x/xUJia+9/wA7cqeJRA9rg==
X-Received: by 2002:a05:620a:45a0:b0:8b2:5af3:7fce with SMTP id af79cd13be357-8b305fc0905mr124388685a.7.1763449640218;
        Mon, 17 Nov 2025 23:07:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEu9v9TyfDRsZKBlpOt5+qQcXV8hKGBopNDzp4XI6skrUBSqx0E5xT27h6J34ZbY1SNdkrBQQ==
X-Received: by 2002:a05:620a:45a0:b0:8b2:5af3:7fce with SMTP id af79cd13be357-8b305fc0905mr124386885a.7.1763449639804;
        Mon, 17 Nov 2025 23:07:19 -0800 (PST)
Received: from [10.111.165.185] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeaf78bsm1142044685a.15.2025.11.17.23.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 23:07:19 -0800 (PST)
Message-ID: <ca6b02d8-07cc-4bc9-ac99-e75d8e3548fe@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 15:07:13 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: monaco-evk: Enable Bluetooth support
To: Rob Herring <robh@kernel.org>
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
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <CAL_JsqJX3doLFv-Nc6o+L1W_o8VjtvGp9dqdpsotuyG17zU7Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA1NSBTYWx0ZWRfX7giG0TV1EKXo
 i7z+nyVptNRgigXvoV7Twmr/t41ox8J9vmNPtodA725NJztw9uYbfwROVm2/YYgW4YImwHxRY6z
 PoPmgjorlQOjenvDxx92ob1Bk40lHWWnt5UR7UJLvP+0hp40TvVz9xM9GbGqABF+M1AMhP/obHl
 oxN6f8pk9arrs0oeFeBRQLUa+aMCCUppGTKCF7KT2hSEUF2jM1McZGLBgSEMIf0R8OD103L015s
 dR8bDvGq/Pi8rZ0n9Tz67I+JCu+tBjqIaKvheeW0UenS6eJiwd7ebzFvmBmV1pSxeqELQdevQ6p
 199HuuebPxAm7gfde05LzNrnhrSS/WmXA1Do+j/WGhxWE1XQIfchN7bALD4B2dWQ6dekpXtEa8X
 vQAyyWM3nWNpsl2USmjMePD6yWuJ9Q==
X-Authority-Analysis: v=2.4 cv=RpTI7SmK c=1 sm=1 tr=0 ts=691c1b29 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=iVCT6-G-MG_SWDpW4E0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: w5TLch4MS17ov1KDO2JOVtcvU-mIAz8J
X-Proofpoint-GUID: w5TLch4MS17ov1KDO2JOVtcvU-mIAz8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180055

Hi Rob,

Thanks for your comments.

On 11/15/2025 12:18 AM, Rob Herring wrote:
> On Fri, Nov 14, 2025 at 10:06 AM Rob Herring (Arm) <robh@kernel.org> wrote:
>>
>>
>> On Thu, 13 Nov 2025 18:35:19 +0530, Wei Deng wrote:
>>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>>> Bluetooth work, we need to define the necessary device tree nodes,
>>> including UART configuration and power supplies.
>>>
>>> Since there is no standard M.2 binding in the device tree at present,
>>> the PMU is described using dedicated PMU nodes to represent the
>>> internal regulators required by the module.
>>>
>>> The module provides a 3.3V supply, which originates from the
>>> main board’s 12V rail. To represent this power hierarchy in the device
>>> tree, add a fixed 12V regulator node as the DC-IN source and link it
>>> to the 3.3V regulator node.
>>>
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 99 +++++++++++++++++++++++++
>>>  1 file changed, 99 insertions(+)
>>>
>>
>>
>> My bot found new DTB warnings on the .dts files added or changed in this
>> series.
>>
>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>> are fixed by another series. Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not. No need to reply
>> unless the platform maintainer has comments.
>>
>> If you already ran DT checks and didn't see these error(s), then
>> make sure dt-schema is up to date:
>>
>>   pip3 install dtschema --upgrade
>>
>>
>> This patch series was applied (using b4) to base:
>>  Base: attempting to guess base-commit...
>>  Base: tags/next-20251112 (exact match)
>>  Base: tags/next-20251112 (use --merge-base to override)
>>
>> If this is not the correct base, please add 'base-commit' tag
>> (or use b4 which does this automatically)
>>
>> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251113130519.2647081-1-wei.deng@oss.qualcomm.com:
>>
>> arch/arm64/boot/dts/qcom/monaco-evk.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpcielp3-supply', 'vddpcielp9-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
>>         from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
>> arch/arm64/boot/dts/qcom/monaco-evk.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpcie1p3-supply' is a required property
>>         from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
>> arch/arm64/boot/dts/qcom/monaco-evk.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpcie1p9-supply' is a required property
>>         from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
> 
> This is the 3rd report of your typos. Is there some reason you are
> ignoring the reports?
> 

Sorry for the delayed response. These warnings are worth addressing 
and will be resolved in the next patch.

> Rob

-- 
Best Regards,
Wei Deng

