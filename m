Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EB3932EE
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405345; cv=none; b=Jv7Jsh1zoHqfg5e7RPTTzPrw4Xkjc+xePsd47rOcdM2enKf0knKzYLsww/O2KmLcGc2Zj/6Py+a7JK1BesdYW+YdnYoyNnh7R4LMQygz1MTl3Ek9p/ho4OkNGWkSr5t/pOXko6yaExkuXUVTwhJi/Fj5TuqOnzGCmErIA9egKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405345; c=relaxed/simple;
	bh=U8Ak6oKhFgfiwx6TcDOlzDTgaMSNLc43Trkp3IHVdWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rh8zLnjYxCx6EEs13nzVEuwMWlOz76aw32Z/JPQtyBDjzj8nmf4nesFRbJEekNmeHamwOvmHkA/Hstc31wO+PWH8RaWCFqHVVXokeisj/d1CXDscKEK6CbE1b6GpNhbFJtaQT44wZCmBqfQvv7w37hEmPk/x2QOvZXClvzcsWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhYHRgLp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWzfQc8R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhYHRgLp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWzfQc8R"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC9YsL3229787
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZFQlLi5fIwcgW1eNDQpKZ6gmEkmv4Gi6LwX5bnaQCU0=; b=hhYHRgLp6kMIAoGE
	IDFCHkMefPoAlbpqy1BOYiDxctLJWhivYxZcdDL3BAfLWthoGWN4P3GSYtczABIE
	RgyvIthQBMgNL9e2hkmXo+RL9NJdanng68P4tMXFBi+xHjz9199J25diXAmQ8t4E
	LjQoh8/7m2gbZE6i84XBZtOpvD3Ikh9OZsQuR08Yjs9QGvZ4DlQkrh2ZN42PqTAe
	F2ZxsiSZnv8MsZWzzwqBuN2XO5rtUV0yloYU3GrC08KZzeacfdg9JEhERBvImhYL
	iTkiv068ZH/3ijqF/6xvvNwUj4Y0mflF53T4TIriN9+2aOI7GKKv7zCs9Ov2aoCM
	umIRIw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7j4rb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:35:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50946034c60so18765321cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773405342; x=1774010142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFQlLi5fIwcgW1eNDQpKZ6gmEkmv4Gi6LwX5bnaQCU0=;
        b=dWzfQc8Rp3A0HgK/ehUnBdPam6pZQH11Z5+VvJMj8nDe3+5droR6fJJmg3WDnHe3p/
         PfRV161GH/xHqERcXuhrnurCSsY9hprWE7RchmrFmQ0oni0uDg+1oRWbj4WxYDUmHkXZ
         pJV+wuP2fIrcdiMU6T453aIY06yUp2QKWaGR+A2td2ljgPqzUmakXozTQp04DNXi1wEf
         CcPOvwAlSdoBkVjYizOd7MuzimhFSfNdU9I59X2co7qPRllrolhFoitQh5Aq1ZRpKbQ+
         X6kS6DNoNoNvqPzH0uqDIHlNaLsW/qIHa7esR9cOrSvlomG4whgDEvpEZ3q6cz7a8lgQ
         qF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405342; x=1774010142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFQlLi5fIwcgW1eNDQpKZ6gmEkmv4Gi6LwX5bnaQCU0=;
        b=RmknR+Py6vHmT0okkB1hzEYKev5HeAZQqiBcaK/vtlHCn9ggpm5tumKSm520u02F1Y
         tDHoUoxD/iDq+UOjv0gWkKfbpKogS1Fu0M3b0JB5cQrwG1VBUt/+FWhwQVHhT5bQxiFJ
         13afVy8OtOmIOvsRW0ndx0X/HNERHy4Ih6Cu8iCboYgv+aN0wVY9LPb+oDn++voCfVfi
         WoG+kv0q6wt9uTHcU9C9tCj5lu+h8pxkpzKqWYNAHg7ZItW4xSyH94jhpf008Re6QXCC
         aJhSRMSvRUcvk+ybXBWCEzxvrp8vO7vBGJbsWz5BYFWI7BBWrTPW3NHAlErFe5ELFlia
         MSvw==
X-Forwarded-Encrypted: i=1; AJvYcCXVAs/CFHUSb85sEYTblf7VmAL8vjacHcDNlCVYVtP0eDQmEcwQFn+f7HP4i2Rmjn5hcog8bvQaCmxF9brmI68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkrEeB/s7Yf15K6MdYYz+QJuQMEs9kyNYQ7j10Nl1Y4e+jyJh
	wvBT63N+kdsCGR6Ems/aXAu3GB8xZwa9fUaMkvfNcqi30Xc6O5XVrzIc43XI5YpwHqsGMQycu0E
	2TaJ0F5DqgG1IKXg+UOSKuwBxG8p6S687oHLzgMTm3qZWfmDXjyFgigyxHjLfuytwgg8CeX8=
X-Gm-Gg: ATEYQzzwizWJ97HyMZyUUxnSOPErGp3kELE54OnvB+oQ+IR0gxqGNmyZkY4jxiaOrCJ
	SJi06eSNLBIn94BUnvX9aeuFE/hsWxBxfOzd76NXnavw8e8C9UtRBWJyDMcxJUPVhqBwG9se5iI
	B71iv3V93TiSYw1+3oihBJ29PFULwFB3MEr2TI0bCjKW6BBHRI27Jthvxuz3r5bE+m1BCKcH14G
	p+tmzACPqzh+RncpDJkYV6uzJkDfP4K/0W4o2GhgnZuKnjoNYwS6KGdUcrzJnrMEjBpyJN/zBjJ
	zmyeNsfTiSj5kTWayWrUBKu8yjDaNgsWxeKChi7kWwyAtxXwAm1wQKZ4ARV0mO+Ju3f6vszh8mv
	6zUNmXo1iR9uszu4kt7/bnrEGrXUaZWFvRZfmcw77QsODJnhBtjRI6N+poFk318Wbvn/8b/qtWt
	J9s74=
X-Received: by 2002:a05:622a:1442:b0:509:1057:4a67 with SMTP id d75a77b69052e-50957caaae7mr31210661cf.2.1773405342228;
        Fri, 13 Mar 2026 05:35:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1442:b0:509:1057:4a67 with SMTP id d75a77b69052e-50957caaae7mr31210331cf.2.1773405341756;
        Fri, 13 Mar 2026 05:35:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33b95sm1519437e87.15.2026.03.13.05.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:35:40 -0700 (PDT)
Message-ID: <7b16ec93-0fb6-49ba-b329-eb92525a3ef3@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 13:35:37 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth
 over both USB and UART
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
 <cffdb8ab-a293-4535-860c-378a4b8a3d33@oss.qualcomm.com>
 <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uu7u0zaH-we1URyfzRwJb34MeXzlLTcC
X-Proofpoint-GUID: uu7u0zaH-we1URyfzRwJb34MeXzlLTcC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5OSBTYWx0ZWRfXwMV9IE2Kgq0W
 wik1OnkWMF4dDVKj9xUIjo7aDlRFEAlV7hQoPiuSMZi8F/hCQJsooKibntsWcuEaLZ7M9T5J38+
 x/mGN1TgZdPPKqCA3WAep/NLheQNCBbvLEJiP3hCWw8QyTiYkdoiRHiXkeJzyw0f6ZwUe8KfYRl
 4i0XsdnX/o+PQwioncxK0am4lkyQdlvuASAXXm+j4DEum8Bf3HmYlL4sy7WMOCHnGrYp36/QUvm
 jn+XiFshmnaPBxBOiLatP+MnHnbZQrM2mM7OghNi2GhvIjiXzuiXFnfFt6ezMweSpaFp4HXpgp+
 b6z7X72OOMWl+hn8jhv3pooMQbeDhoSORSchSDi4A5L7F3T3AwPM0dXAM4UohRuKqEl5WYo1c25
 Bg3xvVQDPuWERdv2gTw0Mtaqv9Z2q2j//aetASmIj7v3WN55c530pV/tcWHC094HSu4bg3bDE24
 5LI+ASU2v80sJDQSw1w==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b4049f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=o0osI4lbHl_TFWF7onwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130099

On 3/13/26 7:37 AM, Shuai Zhang wrote:
> Hi Konrad
> 
> On 3/11/2026 9:07 PM, Konrad Dybcio wrote:
>> On 3/11/26 10:09 AM, Shuai Zhang wrote:
>>> When Bluetooth supports both USB and UART, the BT UART driver is
>>> always loaded, while USB is hot-pluggable. As a result, when Bluetooth
>>> is used over USB, the UART driver still be probed and drive BT_EN low,
>>> which causes the Bluetooth device on USB to be disconnected.
>> Is bluetooth connected over UART *and* USB simultaneously?
> BT uses either UART or USB, never both at the same time.

[...]

>>>   -    wcn_bt_en: wcn-bt-en-state {
>>> -        pins = "gpio116";
>>> -        function = "gpio";
>>> -        drive-strength = <2>;
>>> -        bias-disable;
>>> +    wcn_bt_en_hog: wcn-bt-en-state-hog {
>> This name is illegal (make CHECK_DTBS=1 qcom/hamoa-iot-evk.dtb)
> 
> 
> |I will use tlmm to control|
> 
> 
>>
>>> +        gpio-hog;
>>> +        gpios = <116 GPIO_ACTIVE_HIGH>;
>>> +        output-high;
>>> +        input-disable;
>> This property is not allowed for TLMM pins
>>
>>> +        link-name = "BT_EN";
>> This property doesn't exist
> 
> 
> I  will remove it;

Please run

make [...] CHECK_DTBS=1 qcom/hamoa-iot-evk.dtb

for your next submission to ensure the schema checks succeed

Konrad
