Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FC19067C
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864676; cv=none; b=uEVl8nR0eMFiqjRXBYvZI36O1+tAqK4j5KY8v9qZX+omUFktNf3MWWvLKxsr0/2T1NDmQMicqmaMGyIveTru5my4biDh7a4iKgNP2FhNhVQUqbQ3kGiUGXN00zL92UpVQbxSibiv0H5+0CjTrMlwQ4EXqf9k5YmXNlI06SirRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864676; c=relaxed/simple;
	bh=F87/smNyR6Os8dg4MgBs0/IhscooYag0KN2o9H6aHs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5oFRxnj9YobXfBjZHAioXyb09P7ppRlhlbSjeH+g/8yco1KSQ0DcymfE7uQ/J/mr5WiRDn7fzVp4EObwbB5FnSvtiRNYPk9JrocnC3oU2YT1GV9ZF54qh7MFUZ4rvhmP4SRcZ4oE2pwX/QQ0aR5n+cbu74fZuEAwevxtAME4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d3Su+iTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZVXO7OZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d3Su+iTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kZVXO7OZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGuuf2130978
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 12:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ia4arzq0yyKzPIBuGzO+k/lXgqxrQlfO0SI55RDLmg8=; b=d3Su+iTkvYK2ew1w
	jWBUOujSVltPgR5efWc25takI4/oTNjJ1DbVL1TQsmHoanNvuBC9T30rXEmmUSdo
	D/PkMjbh+9K3OP88QI2vIx1vhuzbxPhI25+sTVhcDJreewlJ9r+nQIHaFv4eIhoZ
	auDE3wCzFFbk7/ZEgVxstnXLxx74DuNwcoEh1H/zwnI5eimK6A/Kbe9qzpm6WF+E
	mDh1KK8Ktv8gp2TpnPktcz8+zrzEyYVY4CvZ072qd73Oco/3ROJV35nYlbpoaAOv
	XIWz/YxzFhZ9Dwg+MPMjbSp3hTNV1jdCwi6wfxUiy9rBkoQoft7aPr00jsIy3JQQ
	GzIItw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhthm7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 12:37:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29558b13bb9so6478075ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864673; x=1763469473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ia4arzq0yyKzPIBuGzO+k/lXgqxrQlfO0SI55RDLmg8=;
        b=kZVXO7OZP8qtR9PF8y/Sj9FHv5rUEGwr7QLfyZhHk+/PE7LEA+GFZPYhcPQbAk7B86
         yG2kmYOtCklIO3VFm9VMFYuzGRTMReGiSdpw2eVV7HWPKLpwkZXPb/IrWS8Mqse0ISwx
         +SqhsToHZicXDWhGRzjDnIfhEJSupmMwJCShNCMZJSfVkwD4AWadcAxDuPat+qltgBjA
         fHTqlv/scLvs2gBvsee8zuspOelUQMj9PI1K8zMs5tvDhy4oWwAB+zc6JBm4MWpu5mZp
         lMqsBy3G1rqHyqM8N4DXXcqUr1AlBjQN7URppv6+5Hx/E8/sDrONDK5QZYEfDM7/feSL
         PRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864673; x=1763469473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ia4arzq0yyKzPIBuGzO+k/lXgqxrQlfO0SI55RDLmg8=;
        b=KSeM7f3LwkMrUII0vq0dKw3wrUQcvlI7oiV1BpSiyuHV7+WYs83752rmgfrUVKI+xp
         +Kjq8j8uyQCeUvBN+a2qGVfm26RZEGtvQ1sgcRslGDbAa6Z+zAxe3wAp8tKWv61j0wkI
         d0xXQ0fZXQ5PPuga/EAo2M8yBV1b3b7SN4Wyvejyg9cLGBrvQuXD/to3kp1KavL/HJ2z
         gw/4fww9ahTs8eEcCOv98OFu//u11rsaMTp+Msk2JjZZ5TEH/uH/PH/s6JG6YsmIjwyu
         Yw7/PZhOrH4fc0I3AU2NMgoRlSflYPOPY9vLQ7O2giE/+TcYPuDQmYjtZg7/DOdSjTZC
         BOag==
X-Forwarded-Encrypted: i=1; AJvYcCWEPuUbesVbUYt+OVt9GcHm12atiWtVU9Fa1B7DVoPxSwfKWA3i0F0Qc5a4f3kBoi2bDdqTdpnbSs1f3Sirgeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+U2nRlgn7Funk9XMGyIdg7z1ccoquetM7aDs36qivAPWBduB7
	XFV1fk3XFN0+SZDrSFfkrCAv8B30V7PIAry1WoPrWcI3sJtUCYNj4iP6/bzjYvSfOeEQUJvgu7Z
	9N1WAOZv8nd7pmo3ScgqlnwK1TGiqQnfQtScDcYaU9ptjmhU2ZonMMG23nSUZHe9H/yO2jko=
X-Gm-Gg: ASbGncvP/a0D7q5yuciaXyDpYdBYCRpj+i3YqAFiibJMQ2ZQ+D6Uqu2QHPMqtPAjujg
	ckr/3nWklOorozdvpZ2A7PQx5gKY5jqMXyzEujg3JjBALa0wKfi4MOTQjvyrbkNX1X7/h6CRaze
	4uK6LVTab0E3Gsanao1HejdsP5guy3hf8x/OiEUdjXYRItlrz5OXmmojA7l5UPkxNINfjCIXEVe
	powP7nlDjqGr3q6X21g/orSjfcl01rVkFHhHjy+xjbC9jdgk8YOaC1ubsAIsfbX2vnEik3bJJ0F
	aCqc3ExEwmjmLNvMCT1IkVj6CpASnk9NH2iB8oMxwKSH8wLrFjjNvKbgThaB6QfefWvRpnfjqUH
	0CKZW0kW3VEyEmrX0lFx4
X-Received: by 2002:a17:902:d490:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29840fee954mr19743435ad.4.1762864672970;
        Tue, 11 Nov 2025 04:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0q+p3aApFgfFXqkFESOn3QG4Gvbs1jnstOAi+s6mYdXc9o8PALRvTBIKDC6BrvFmGzWhTuw==
X-Received: by 2002:a17:902:d490:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29840fee954mr19743165ad.4.1762864672475;
        Tue, 11 Nov 2025 04:37:52 -0800 (PST)
Received: from [10.233.17.95] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm180165815ad.102.2025.11.11.04.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 04:37:52 -0800 (PST)
Message-ID: <a3d1c1f1-ef52-4c68-b3a9-8b394da32208@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 20:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
 <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mKLEcqK0tx4r510_1TA0cVfvPwzGRky6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMCBTYWx0ZWRfX8WZ3dFNAFUpo
 qqR1PO0vWoOzlSqOVzj2HQfpzb6rayp1OcO8r5cWeMt0pZXYCidnKpGuGtK9FtICwA7jlTPxu8b
 +ynYhJoHJcIVGW9AFEBH+sNpvkDU1wa8AySTrDIvjRYssfVHJ5ozar6JSGMuIuFZqz3oqjYuJHZ
 WNpjfq9Z7VR5Wc8cK4NS70Pfb8pMC4x6rQ++gRG1MX8pxoL1506YcF+wmB1Y1E90KCvEgaNT1qR
 o4H4zNnD+PHeKNmO2tcL2iYzvPV0D5Z5kFzrYZ6Xqzx8QImSlgBRoFltnLP3cd7dIoY68aPo2aX
 l10Fh8oJsvvvnB3eUPG1AHQd3fT3mvPppBDyuoJ9Hy++TSVwtEaeYRu5Hya9l6kDpvFxAPgU1J1
 AtLdTSdNlJwQftE32CEUHM82SsnDOg==
X-Proofpoint-ORIG-GUID: mKLEcqK0tx4r510_1TA0cVfvPwzGRky6
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=69132e21 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=F864Gg6nNBeLBzAGB4AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110100

Hi Dmitry,
Thanks for your comments.

On 11/10/2025 8:39 PM, Dmitry Baryshkov wrote:
> On Mon, Nov 10, 2025 at 11:27:09AM +0530, Wei Deng wrote:
>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>> Bluetooth work, we need to define the necessary device tree nodes,
>> including UART configuration and power supplies.
>>
>> Since there is no standard M.2 binding in the device tree at present,
>> the PMU is described using dedicated PMU nodes to represent the
>> internal regulators required by the module.
>>
>> The 3.3V supply for the module is assumed to come directly from the
> 
> Why do you need to assume anything?

The M.2 interface provides a 3.3V supply, which originates from the main board’s 12V rail. To represent this power hierarchy in the device tree, add a fixed 12V regulator node as the DC-IN source and link it to the 3.3V regulator node.
Will update commit message in the next patch.

> 
>> main board supply, which is 12V. To model this in the device tree, we
>> add a fixed 12V regulator node as the DC-IN source and connect it to
>> the 3.3V regulator node.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
>>  1 file changed, 115 insertions(+)
> 
> Why do you cc stable for this patch?

I will remove the Cc: stable in the next patch.

> 

-- 
Best Regards,
Wei Deng

