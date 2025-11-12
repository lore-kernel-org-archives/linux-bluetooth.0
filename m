Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412F2206A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954251; cv=none; b=hI8F8+osxOI+WWTkgEt5WUgyMO40uuMplRyOGEhmj0l+IWkGJ267Yqi19tNFUeq0tZPmkjyPqVVwxb78tsWBwJyTORWCjHzJImKT3NFkp/zc3c8/MFbQ+RZAOk011X5pckyakfS8tcICyzSYX0dq8iBpgAqxBYME9FD5Af5/Jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954251; c=relaxed/simple;
	bh=IIaToPY544Y8Q7YQpEj1QuODNq6/ZHEM7RPkMgIfZ4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLJGseH3k21i9ZiDSVvmchn2pCVqBX+K9UlCXm871yhR4n7EaqFwec7qii5tIAn+b913dNSkPJVg0ofU70SHsXWIvzNW0RUEFXv96ZwQyanZgojemWbIpOLDMvuwseWcb3CQmF+CPDoNIXalPRPiG638h6KAGfwxsg4LQCTij/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lz5OZLmM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=clAf3Eg/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lz5OZLmM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clAf3Eg/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9hneC908441
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 13:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/44QdJJTWaS4EuRU1XRPP8XiijRIj+e+dHbhb/7shXs=; b=lz5OZLmMV1RFUQD1
	tn5+ePuIcsL9+rSPx+6F9/izlW5kAJh1o5PZ32boZxDLGElC5bRIWpfq8YGdMY26
	qW27VyRlXZoBM05p3F1XRryJ3hfpuQVWqO0Zhx+w2a5qZe/8oQ/Op8ePau9gI4RW
	qOZU3FABmz0Ol9AbThLfhi1U6iWNj2I1Orwyo/lkMwRtYsBh0aB1XHIghZrF1np5
	ABYfIbXg3sSJCmyhZ1ljN3r31gNeMfPCGGfOCZe1Hha5pRb44LK6fBJOuh7ZmYGh
	JXC1k+/JOX2PeaYJa6rnJ+G/+kR51aMuJHgON7WnYs0FywwvhSmKnCFnShXj6Jvz
	Fj/eHA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqur8ky3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 13:30:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edb714b16aso1863241cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762954247; x=1763559047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/44QdJJTWaS4EuRU1XRPP8XiijRIj+e+dHbhb/7shXs=;
        b=clAf3Eg/UyaYFTx4QJy3S8AqmEg+2x77txVdTLg+K1uM8tJW9YSKJyraVQxhCO7GUJ
         H3rVSYb9PjhQfbGHavP5u5DCVFZ4WVrooc7upDO5HJ/PhbP02+2PPBj7mjMkX0ogk4ZN
         qgxGN96eWW3TesdPav85z7rjBjMLkDK7rRqxA2UuT6m957iCTbZZmA5uLHG8BNAGr4WZ
         GuVFhGZm+io3hJr6JJO9kDJ8dFiwgG2JbppFM48jkdXs0Z1EMxG0HubjmV7UNpoZseUC
         wA/+61Jgn1nidcaqVgb6bPXp0WnflzVclEpG3HaYZBWkAG9o86cIn1wIO4Dldj2s0pBU
         ZBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762954247; x=1763559047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/44QdJJTWaS4EuRU1XRPP8XiijRIj+e+dHbhb/7shXs=;
        b=tnKGPKUXbLir1cFMP7Kv4EggLXRt7c7WKeFb303HDWtTDXjv9T7WLL/D+yozGZlpJr
         6dXoTZfB/uhh8uZofLwoDjzgyUYFgyAnKQtbj9vFTHsRNSuFzBy7yA5jF66TeJ1OHzKz
         csBupXuoLZgxRN4nHj3ZNfJcSdeqxEiP7RpEgu0sLWm6RKLBwXwDTw1OqOyXpzv0IsJY
         yFFg+FQM+HxMW1rJUqs5OoXjtQW3HPZOttbbNQzt4hCtVXaYxuBnat1tQPEr3JQvp1eL
         6K6l5oV9wI7VQD5eFoSHv7T7BvpRQk76Asd12lsH0M6idt8KeLgZO6NnUuocoTnaCQQX
         Fw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR3oVsRE8kSIPPsVPR5Yi8j9NsEIZ6YOGSww374PzcNCEKkyCIG1+/c6PCRaiZ2edvXzcX1Yhpw/Ykvy38h7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgsJhjhmA2L07jeOGpL+aL46IveOkSWSDP8d+xAdTvS8qEOdK
	yMo9WR4IfkttfbQ5lTgl8KnLEC3CfWcUyW86w1FFd/p4ruV4sYIghKxNg6ZhobIHKCbmmnSvlC0
	q227Eg45ub6OUiM+Ji6WiQp6P9tSCTeMBnhaDw8hlAHKUYlUf9O5iyHDAf6hFUTxWxsD/mTE=
X-Gm-Gg: ASbGnct5DQVPVI6P4IzMIF+6gliuoKYFaLMvxoBV0Sr4/UWppM1YjzxvZAmAFxucxkp
	56MRWRX5YzP+3V+spItaJmMNa0m2ksC8xgiKrHg3dvCxNFsPxuF5ICw6au9fgS1dT772l1d9lYF
	oun4YGIcXlh7AHXQ+Eplr7queAuP8HzezOCqzJtVDQ6/gOu+Au2ygalPsIUpAYiAVxSS3sDE2IR
	Hf4b94eTaMSiC66cYnooBQXUn2zjrr2+yPbSDqr5vDHihQT/qEzqh/bfcNM9zGb3J5o+uS/xJho
	0o5SsyxD9IPjfbTFZhEsVxovqrX0102og+G70fc7yHYPZdad12nd+lgSpR11+rxWfZaRj8/iuIc
	NkoTG2AqHnZ75ZUINTdxY59J/KyjJoqO7m+euyJWtNQLH16RyiCqzVWY8
X-Received: by 2002:ac8:5994:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4eddbd46144mr23816361cf.7.1762954247351;
        Wed, 12 Nov 2025 05:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaCidicKlTBr1TM5P7offIP77B3anNOfsqqxDoaGf9E+pOaF90XYSEHFgNiRXwNrPGyMdkEQ==
X-Received: by 2002:ac8:5994:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4eddbd46144mr23815711cf.7.1762954246478;
        Wed, 12 Nov 2025 05:30:46 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm15752222a12.14.2025.11.12.05.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:30:45 -0800 (PST)
Message-ID: <622d407b-d04f-463d-bcbb-3543933d5fa1@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 14:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Shuai Zhang <quic_shuaz@quicinc.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com
References: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
 <0df692e3-7e39-4a7e-916a-c385015a2821@oss.qualcomm.com>
 <093749fb-5eee-4a1c-a29e-8232e0c9dd6d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <093749fb-5eee-4a1c-a29e-8232e0c9dd6d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwOSBTYWx0ZWRfXwvo2ouwlTPlR
 FySstqCNAPMn3OPlJzemyyDaty20eXK37FQ+DFxXCcy9hZ5ZQFyL8Ji4u3ph6zUWoaUp587vA2g
 DOzMn/QYTl/0tj28ZXjB/E2bSyGoS/INfWSMW+DRp2Z61Hx/YWDyV4GYx+cfh9gFv03pUWenJFo
 jha4xsDRxtI2Pyw8i2eCKVk1SnnuPqkYczlkuPQgUmRHBaBz5/ud5bdxBWtPQ5nYydUroXH7RK7
 qs9dqfzjs9FTRgQmTwa3Tiap+aU7emmAEM/P80GJIyjmdhDgLxhMoGVpgKjLi8tjstxvxjrO0q9
 abX5e5WvofAly5CE/pkPyL2buUFZgUN2crqXkBGXS1XYrPsKXtO21ecs0TTBhn32C+d77LtTxLP
 PVqj1rs7VDivfwryChrzwOatnzRJFg==
X-Proofpoint-GUID: T57OeVCOsm_AJAgT6WogP0IBGA1NbNe8
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69148c08 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=BUb7FIXMvheu7h8L-Y4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: T57OeVCOsm_AJAgT6WogP0IBGA1NbNe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120109

On 11/12/25 12:29 PM, Shuai Zhang wrote:
> Hi Konrad
> 
> Thank you for your review.
> On 11/12/2025 5:53 PM, Konrad Dybcio wrote:
>> On 11/12/25 8:46 AM, Shuai Zhang wrote:
>>> For WCN6855: download wcnhpbtfwxx.tlv and wcnhpnvxx.xxx;
>>> if they do not exist, download hpbtfwxx.tlv and hpnvxx.xxx instead.
>>>
>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>> ---
>>
>> Would these files be fundamentally any different, or is it a workaround
>> for someone else being creative with filenames?
>>
> 
> The prefix “wcn” corresponds to the WCN685x chip, while entries without
> the “wcn” prefix correspond to the QCA2066 chip. There are some feature
> differences between the two. 
> 
> However, due to historical reasons, the WCN685x chip has been using firmware
> without the “wcn” prefix. We are now correcting the mapping between the chip
> and its corresponding firmware.
> 
> If it is necessary to add a comment to explain this, I will submit a new patch.

Yes, most definitely. Please add this both in the commit message and
a comment in the code

Konrad
