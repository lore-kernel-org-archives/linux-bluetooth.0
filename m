Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9792C15A0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314075; cv=none; b=qkCR/h49U9IxekFuhk1nj9ughTbtqlTRDW3VjiYkvSR2vResPYoKD/Csra2dkSpRHBUblIOu4tTEQvrI1zKV/QOtigxax9dlf9N7f+Em3hicEtOgcCilOG8L3BbmYgAm7wMzxDMgM/xIFIr7h/GuHVP1i/3T501VgWAAHRoaxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314075; c=relaxed/simple;
	bh=/gC+8O0Ta/JGs14mGk4zJ9tMSLuy2XCPq22nfMdC8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTPnzYAPdvcZWqzBwJIgnrditvhbp27z/bWrv3KboWKrGwEDHkEX1NDIYNYQuViF+UdK0NN5sM/Zs1UWGROEHmBdNP+HMxoqGD+hwip1DKuwYPTzBg1fSNMhm0snUzHQaNLJjzMh7xAi+967Ws52CC6yDWHuYYV9XnP/7kilLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYU22juG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NECLUs0K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYU22juG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NECLUs0K"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GL7gCK1613313
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RKhJoOuZx2FucQUbomIoWiNWGak8XORahFbx6/jtBDI=; b=TYU22juG1gy4IgnM
	VXI7Eb31xt2QnwD5Xs+IsYs3Y1c7VNGk4Dgnh4e3mDRvmcps9hRLYKyErQUn9xHx
	5oqQ52+oyQyTykv4svGBgjiLDp7Qzh6wHSbz5noe5mTqWfqtXRNic2/GfazpLY8Z
	Tj6Rg/j4iSia8Q4vsh+IXwPEvOYx9w9CNiCS+MUaoK12wIT45qf4DiCFs1eCPSmZ
	MfOuHOunV/NK0oni6F0fzA6VN2ajdWwWwzK7XR1l5tXugxV1Fua6q9N17JJsdjTl
	K492TQkIONLhX76/nnnY06YJFdmXnw/rlcuzyMzumBH40cJjYw02vZC/DQ/fksbJ
	nSsDaw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662sjd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:41:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aae3810558so45411055ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771314073; x=1771918873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKhJoOuZx2FucQUbomIoWiNWGak8XORahFbx6/jtBDI=;
        b=NECLUs0KELDLSsx0HlXt9hJl/AG+crHBfk8WJ36Zavz/5yKcWj2Nq34jwTBZZizM0e
         IaVIAMalMqFL/A7ohhqXcX5yQ0U/Bm6TdEm5t1xKSfbc9E7321SISUug9GVgPBCC4aKH
         t42TWSUef6XOxNL5ZeGwLbcCi9LyEkEuiZ8YrRTeulhiFji8VwGATnUpUuHpfH8698LI
         ahGwaQL4doBvjgYTeGe073nFaIFyDq+PTT2Ddbykjwr49znNpA0k6qsTZ7S7FWeySuxJ
         u9w/ILLzEEqh0n/geAoKhXJjYB3IhSBTWqeWkpZUjWyDxA6IebzoJQbaW3oQ27wMtbQk
         bfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771314073; x=1771918873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKhJoOuZx2FucQUbomIoWiNWGak8XORahFbx6/jtBDI=;
        b=WeAeJKNj8ZGLQRVzeGnGSHNUulHh8OYnGDF/0DVIyUB4hGVG1scQ6BFKJsCrZHN8dB
         6mtPBPuvUvquT6dGcJc46aIseX1UKzThEsSP5v9dJG7XuY96p2s31LTgbK5txW+0hTEU
         y3lZErS5oPd154lZrpZeFgMt4I5FOzIIsiAcClCyfxx9+vOso6ISlQIq2MkHMSbstoZR
         L73wsE5ZrF+tFbVBsRg4eTBuQDv2fBN92VWfTqyHP5HMGf9g8PQUwfx2HsYDm8XU4iG4
         pi1nO0uKeSqxuAJulmZinUjaUYAflnQlT3IPr3uRVVS5RMgheMYtTepTt+3RNFzVgVUM
         yssA==
X-Forwarded-Encrypted: i=1; AJvYcCWgu1Gfg35u9FxFRM4pvq/+mKNRbYNFbZnN7XM9njbat/4lX60OSFA4ASDpLnPwO2ZGp9vhLitODEH5GcohKi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0axxi2D0TXyY+Vmg+fx8KLQIUsaeo6wl7BLfcrJgUxgNfsBea
	DTwu4OtqNQ4/EkHi/z+Of+2S0AB848Nn1jLpz+4O2rB3m30INAtCzE7tByen95vb1/Z3L+QciaZ
	oNuFH6e7n8EvGpIllyz7xWtDw6nNE6sftvcq/iw4QJnwkz8AGH7OMVkBU0ctat28ZCQhPnx8=
X-Gm-Gg: AZuq6aJbdyK8qAXbISwxt6v1q883p7zq5fzJ3u2SY6IbroB/QTaQKjKoEYsMLsJd0H3
	nRvrEo1cmyWBKJOvM19zxK3OIMaAs5iUQQZsEYZbvo23wR7UgErvvRBKvpD2/o6zrjkjnLXnbDK
	xsoX8MYb3zu5lJcW/SdVWAE1tEhy6ROnjMh3Q/c5JaJ/O7Erag/lrYiOuwyiYiUhNLiWxAYGK2G
	ljBaNohkDo0QYrl0K0W29Sr0+c2p5A8HErsCeJhAwKpY2abkCaNiYcpvhV+SoOXKLK9AuBtbVDY
	8HkqIMtGCsq0khzp949tM5x1LIpU2u/Kb9rUNSb/mdYDZVAQH54G5OtkaGQetba6mP/U6PLSI1f
	SqDb3psS79KuOab8XK1u+BPaMTGHjQqr2/nUlUgHEDmMa3LUZ
X-Received: by 2002:a17:90b:35c3:b0:356:2540:bdb3 with SMTP id 98e67ed59e1d1-356aab9a337mr9700495a91.10.1771314072729;
        Mon, 16 Feb 2026 23:41:12 -0800 (PST)
X-Received: by 2002:a17:90b:35c3:b0:356:2540:bdb3 with SMTP id 98e67ed59e1d1-356aab9a337mr9700483a91.10.1771314072291;
        Mon, 16 Feb 2026 23:41:12 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e7d95d8sm20072354a91.2.2026.02.16.23.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 23:41:11 -0800 (PST)
Message-ID: <3f59dbaf-1270-42bc-a21c-210c92b398ac@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:11:05 +0530
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
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <xai73ei5ixb3qpp53cjvk2h4adlfo2zl7qglshup4pbeyh4fpi@ihdos4z6vsoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA2MyBTYWx0ZWRfX8pqdMeReBBsA
 B+nCdSPWdBiHQAdE2yT2bja2ZmYD1CqgYUb6yMm8MEIAefyQ1E/L6DhnniNLGGXNG97BEZ/tOGj
 ebSIrYtNixv/D9yO0VmjNaenALMhpIYcN4eBofXDLOFeOiGadXp+GaSB+ke7qNOwtnWXTy8VRMY
 UblofM8th2I4PIKsfis4d3CHjx4g4udrHMkiWCpUKg5EkegAV5gXymAghuuSfMfTZYcwLkmdIpT
 fJW+Xa2uKVRhCOfnWy12lwGK+A6phCtQRp8B3KCLM9o255OBZYINl+zaArvGyEgiEgYQJ4k+7kf
 VSw9Oq3TBUP0kpq7tOw9CJyasPiNc4FiidzEJ52zyx/r5KaOV/MoDDZHwXv8YXOfua8B1IzIJir
 +xSQy4Ehhow/SN86MDo5N/4dIEIlhLptL+oBftnPvUrD2tzCTUH5Ov6R9cSqLfDHL86KlXTLRK9
 vuQTbJIP5T0lgJps0iA==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=69941b99 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=X7cMRLG0ekiW5Bl67NYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 66ODR2UDmzjN-jaIAThlGd-g7GU9gWM2
X-Proofpoint-ORIG-GUID: 66ODR2UDmzjN-jaIAThlGd-g7GU9gWM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170063



On 2/17/2026 12:04 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 11:17:30AM +0530, Vivek Sahu wrote:
>> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
>> possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
>> bindings, so device schema will be easier to read/maintain and list only
>> relevant properties.
> 
> How is it relevant to the commit? You are not splitting anything. You
> are adding bindings for the new hardware.
This commit is added on top of split schema where for each chip set 
there is separate binding yaml file instead of following up traditional
method of updating qualcomm-bluetooth.yaml
> 
>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> ---
>>   .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>>
> 

