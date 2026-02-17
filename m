Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339A2DB7BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316404; cv=none; b=KimGvZ0YPXmFJhwrRGfN1ZG9INVyTqjDzpjHGP0XBYc22qTfSAHE6FMEkbz4G9LdvAhIcawiukKfc4NYNswEGq0WDzBESigbkMZMZtqzwnrQY5j1zhjktopcLoq9dd8LTNP1IDx4Q2SH9Vict8r8s8Op+x32nJ+0f8F/QxrP7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316404; c=relaxed/simple;
	bh=5NHCoY3t5gF4SkQd1kPK6aR1jzzVmLT3HKJTcPpHFa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFWh0syi2M0P0Kv8oi7gUkSraJKPD6VBAQxeR0J5fidHz2E2w9yNdaftKMXJpTDGrCQEWQztI2hGnE854kga3bCAhRO6vvvGRo4EDdHBpLtM9+vDTuR2GZTGcHIopwNaw2fg1gDSTqKjDKRVLSNNLWQOs0QKIWHcwMdhQm7N03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S96N/B1P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ryxq3SUI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S96N/B1P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ryxq3SUI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H82AnZ982436
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+TxhKo+tFn4A50MPPxOkkZg79rFGGqBbGidUFVQXhvY=; b=S96N/B1PBteijTTO
	dqwzELyyvsAXBM/kRqd8rYz7VrEwX+xnlxu1zV4SRuzpMA2UzDH3TLCFmYxn59xE
	qH6gNx8Bewl49Emc98BsIwRyAjWHBz3bWN+0NwF4q6GlObj7g/z87LG/VDzmnqEx
	Kv3ahMVu4UCp/VoGRBpD2xVIwOYFQD0XiPP9R92N+iw006dmDv351ZP+c67Qcy9z
	crAy3zZO9Q2cABAb/Ygn1Vono+uPn/5kA1oGfOqNAOm2Hv/GgK7WgeMrs/AAavJt
	+t54L3tr/J8LWH3FXMxL0rdqk4meM+V4LCJvjD6ECse5o2+efXRvVR1B3mTIorVH
	Uza+ig==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662snm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:20:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824ad5d2098so1943477b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771316401; x=1771921201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TxhKo+tFn4A50MPPxOkkZg79rFGGqBbGidUFVQXhvY=;
        b=Ryxq3SUI5As4+5+crOmmP1OAIlevnnlTnhSfvur0goop7P9Dt4nWUvruJgqguzXX9V
         ktpfIlfPAnsvn37Pu+F2P0Mixjwp9y3fJ+0abfxsChZiMehEV9/0oNOMkYR9ju57AbOG
         ZcXvipa0vEIk+9km3g47WJnCRvwepGZZ7QfDaK1EBTQzkANVHZlwbXXatUr2rpPpWn38
         pPSF+DmPH92i+la3aG2qW8VfW63oEFfuYA2TifvAvW0NLVw8drEowdW8NhxGeQaLtWBd
         w2VKgVj6JzWsYnYGOe45MlCqr31zdue9VehIfuVbYAawkmaNsjnCqjUTwec3ACjCtwxa
         U8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771316401; x=1771921201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TxhKo+tFn4A50MPPxOkkZg79rFGGqBbGidUFVQXhvY=;
        b=aoQZXgBbg4m3CWNXOmbczbCVjr5rhC2HQWEFiMWSZbDhpQSUuF93Ua9BAw8rYId0nl
         Le6iyJdH+IY3FHuyKob/qYCn9Xv6JJdt7+HgdQuoApUwCpujBfGk0/wmx50VFNo0hjXn
         CWdB7LCXXrqDFYrL+MblRirEz47mWVTAf/gGG5+Kh+CB2DcBgbxrcrToHMI98iMnUQuU
         mUy32Ykld+g3C1Xdir3u2DuEVWEaq/yCasidUbKJS4Gn/PCNaCg6UyKsFFChFC1kiaQc
         dnc9e5iGmniar+KRha9556vMcizJbJYbn+ABjc9gBsM39dilKNhu8kCMI4jMpY2ifHMy
         Hu7g==
X-Forwarded-Encrypted: i=1; AJvYcCX3LPjjRdNWksRnPPIDZIuMIUA+kiECgHAt27RqyVRSLhthKZyQ9TG1SAeO/T50Wdishxkp2Pb3x5HVAUjyV1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jFuLG8lheegr632ma/rWvS+7dBOpTLsPkuHV03MttezPh/qJ
	vdyxxYQaK/kRokomXCgnQxX5NVWplUnGmdRWQpRc5XeFwbvYEqWhnZPudNrtevsWm7kqJuJLyBF
	TLyCqV7lmukpTWump5325mtmWjHq0WZTO7vRRUeJhcsxRIWeRuViINqJisE2MUA6+vOFh0O0=
X-Gm-Gg: AZuq6aIRhGVJtxYcqAC6b7P5Mjx5VsjudYNDKOcUlkOwHhSOP8ai+05W0tdaHL7Ge1w
	QVZlLsgHMqiDC2ySOT2ZNzJPGc1b2CtKD/ftkBdI0Eb+D3bxBH2X5uJP27/4W2lPGzeUPRjHiaL
	j3pSdReu6C6iP0CxVun9CiOwLPFcFBi3aPBeTAUUkJf/yy2m5Y1Q6gnwvKds2te1yFJGhsGZs4h
	5x6xvPFwlV3rFAneg7TdphYNS6I2MRYZKFiWXvmtkqlOVFGVl9oPpXhe5i7nyYlIFrhDwM+lrOM
	+IiJD+Y2V6qsTPP/fFh3UYy4q39JnvT8EkKPOL8+0V3C75E0dBEJmnqxa644o/4FjTgU15oaWz2
	YdJwzGBwegude3gyzpOOe118kcQqjAY/ThBrSFCsX9E+8v5Rv
X-Received: by 2002:a05:6a00:2383:b0:81f:3f03:6832 with SMTP id d2e1a72fcca58-824d95f3794mr10542853b3a.44.1771316400532;
        Tue, 17 Feb 2026 00:20:00 -0800 (PST)
X-Received: by 2002:a05:6a00:2383:b0:81f:3f03:6832 with SMTP id d2e1a72fcca58-824d95f3794mr10542827b3a.44.1771316400048;
        Tue, 17 Feb 2026 00:20:00 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9084asm16005229b3a.43.2026.02.17.00.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 00:19:59 -0800 (PST)
Message-ID: <ae347961-4ad4-4772-bae4-7b698a05ac8b@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:49:54 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: Split to
 separate schema
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
 <xai73ei5ixb3qpp53cjvk2h4adlfo2zl7qglshup4pbeyh4fpi@ihdos4z6vsoo>
 <3f59dbaf-1270-42bc-a21c-210c92b398ac@oss.qualcomm.com>
 <vdxktsvqwgmwi5wuaiktjstzkosvrjkkzkisnv2k2ffyehmh2w@yleoccukebbu>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <vdxktsvqwgmwi5wuaiktjstzkosvrjkkzkisnv2k2ffyehmh2w@yleoccukebbu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA2OCBTYWx0ZWRfX0g6T1fAksLLZ
 PgHGjBxrTQMKrf4hDcNS+FbZab5SHxDi/l1I7sdRx/em6gDNcCW/a9AxxUQDLW0FBWa2IiDKx8b
 48nqc3PTbCqMB0idnwmiRUsx880/fATYjqREMR7hf19hniBNFdd+p4tqHb3GgECF1ZfMnIviGj1
 xnm61IdOg9ZTERZ4cGqknK7bkzb6d0fqvMF4B1r9n66JiDO0QpYt/778dMdXzPLwl2nGvR5s4UY
 /yRsM98fmI5zcOUWbkJ/K8Gipwxd8aKcxdPD6MA2Z5vO7ygU78WYRA2McDWbJNxaiJ8Wd6AARE3
 v9dqzLMEYF7HKxLYkqonKJXBCA+Np0CRD5tjtRg0qxbsvOgUjoS+W9mGNHplvVfADwGee5H7Jb+
 BG/B7XfGhd0zvehV+0CYRydPIBiC9B/YXnlQ2WNM0rXFywQegEVOvgDYdTk2r9dVtRPuJCqq36z
 6pDGTKjaGBiiCb0BgOw==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=699424b1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Sxt5uGroJ81OMFZ79MMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: DxJCiTnmUx7Q-9Lfnh6iihE3E0gfV3MI
X-Proofpoint-ORIG-GUID: DxJCiTnmUx7Q-9Lfnh6iihE3E0gfV3MI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170068



On 2/17/2026 1:43 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 01:11:05PM +0530, Vivek Sahu wrote:
>>
>>
>> On 2/17/2026 12:04 PM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 17, 2026 at 11:17:30AM +0530, Vivek Sahu wrote:
>>>> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
>>>> possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
>>>> bindings, so device schema will be easier to read/maintain and list only
>>>> relevant properties.
>>>
>>> How is it relevant to the commit? You are not splitting anything. You
>>> are adding bindings for the new hardware.
>> This commit is added on top of split schema where for each chip set there is
>> separate binding yaml file instead of following up traditional
>> method of updating qualcomm-bluetooth.yaml
> 
> What does your commit message describe? What are you splitting?
> 
The commit is about adding a binding for new chipset QCC2072 which is a 
WiFi/BT connectivity chip. It requires different firmware, so document 
it as a new compatible string.
Seems like slit to separate schema is confusing sentence for this 
commit. I'll correct it in new patch set.

>>>
>>>>
>>>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>>>> ---
>>>>    .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
>>>>    1 file changed, 48 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>>>>
>>>
>>
> 

