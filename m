Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A479309F0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474683; cv=none; b=EgHV+7haTQ4yCHc1JDbfoQVU498f3Zf+u0U1sLyHKLuUoGd5CYcdAOVLDDiupyBeyZk8fvnrnau50mGzXM7Gw2Ke+J0kfVbg47KNXj2ke1ICjCTlGuSRXdUV9x1k3u6efQ+dVk6IdBysfwR8HEsLwHfG7oybEnr42Ss2EDiY5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474683; c=relaxed/simple;
	bh=Q7+haChMoxZVgNnjOOIgYZJvNkqMyhGzjP3c4d93zG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/BnS3prDwLdseJnnvQ0Kcq7P9fc3tmQLFCwfKJ1GrmtBAK4N2X4FNRY9Fz6+5eLVHG99qpK/6g6QRSOpegnlgagxYiZNzNgZvZ1qOwqbPnefjwP1bibQKn60bNmu6DPLQfWqw8bSl402/wtXoNjTZhILILnNSEfPreIGrgOaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fokxcU5Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QlyIXdtq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fokxcU5Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QlyIXdtq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIDj5pU623738
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TuxJPUbB3G7x2UER5YSdBk+4SqSkYmbQVqXfwbZf/Qw=; b=fokxcU5QLMTlgo81
	UWlJNhS0Cl1Cx34+Bm6An7nZuW5od0dbI59sdgyutOzAQZRtHaVCPGcQhJOytzcy
	J4vAyq5nFg0oG/MMPpz9bkaw7mKruvV9EoWsceEw+igLOlNIzgTJGColyU2FFz2b
	V8B6AKT2Ldpkhg6Cfl8qiZma+xpxrjCGkFHGs0xJCHlG957eNBeafnakoLtEiRH8
	slQEd0FuiCDPhb0T8ZYE1UHbDQYQoi+d9Y17mtr31aTE+vr4aIDjbxE5sRht4sor
	159OiLwc2tyASNv8WHAi9bVWujJk9nTiVjYfeYpacKgJBrSORgafTEU7UKwSA7sS
	8SbnYg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agahfanhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:41 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dfa4d7ed54so644257137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763474680; x=1764079480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuxJPUbB3G7x2UER5YSdBk+4SqSkYmbQVqXfwbZf/Qw=;
        b=QlyIXdtqBaapA7VTyDyiuiUwrF5TbslwRusB4MCYLUJzVV3rAwO5rQfK5/3aIGmalr
         oUqlip5DrtqllzyADgoXuo829AdX9QwkI4qCRw8CsSqwVJRTu71HTjNzRcpc7MSnloc6
         Tf9wPzCBiiJvg6pp84YLBTpnJXpk16lpk3Bk9E5jk6n0E9iIx7AW2pHx/swLy9v/ZxRa
         vu4ZrQjXbtZRrTeH2RyJhFgizWna5pFPwbB0nocux2PcL/Wq7kLITckHVO1qhSwYNRxo
         fIPBiYtl9C7sAdw7BgknzYH7NgS5UX6WmXp6K4oHNltxHChKy79HoApNJmW/iIr1ZnNv
         SDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474680; x=1764079480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuxJPUbB3G7x2UER5YSdBk+4SqSkYmbQVqXfwbZf/Qw=;
        b=KOaO8dgGWTgeanjOkPXKluPWdrJ7g9pKooTJZVGE7vRWOJaHV9ryMhjdDsRojmBhei
         wsUbY7yt3+PQHcgACRL9n8GXuWp5aVasVGqnITyO/qcJfTbLMFBpDUsZN1uKutTI8Hi0
         ytXcy4t6QfItxNi2J5a+1iLzasWIjsAFjJkFicWzKCz/kUuHK54K+AZMP6edtWAllQt6
         J/nO8OdA+Xh9frIA/BhiNksuq/hrKvvXJnSI8fR+gtWpcl9wji5jtJiN6MUD2r1JXcqs
         lhWTdMhWdOmng5a2TC1IEtBo2UUMzKSG6T2HQdWmUFMmu6HL/QcN4Q73WokD2J0Lya+U
         c0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqeM/RIpSzHgYSA54JcLFJcQzxYZHqYT0zp7+/zWN+s5ZTeF8BwuC1vvBGRB32yMkMnFZngyIJMzL0yRcciqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfLUPDnSpTd19wSxAjz9t7aNeMTUGsZPSz0MkVBX4deg8LSP0
	Q4JVzehTwR8MblOikcjKYCWmgkRrEWupwLGFAuIUpKnUS55pnLPsgGhneUrYtzE8h2EY12HjUo+
	qBSc0I90YdEa4uDK7mrZ5YPOIbPDkPDhrsbK5wGwJaBZTCtrGqjaag2SLBkyEzD1pnjYWHrs=
X-Gm-Gg: ASbGncvqCOW68vl+pORUsgFKs7w4o8zZSEncO3E3kO4zPLy4QllvI/uYsKJlBK7ZW/I
	rv58wi7QmlUyaaSm2nt0jDTHarBvImnDxo5CzP+57QuzeObwX72aUZepmioa+bwNvnN8DyoUx66
	bC66V/aHTGjelNd87hD4v0rdgLYtyUnt2Yd4a4lclvYvtZ8E85zPWeJq917WVUcgCiyJVSRPPDp
	1Qs3WmYiUWLjHpkvhD+aPqbix3IfHynfKnyxj9ivJO9QzA96Y0ogjUOQg+A52BHwIgFtDLsiQiH
	Mf4K0TWPnQODT77JYR6T5jR/HXqyd2U+HCNIlhUeYXqU+PDGlsME3qcmI6r0MhS0D2nwc8VkA3F
	WO84opcV4rxNlTDjpUWJ/vb1+r42ujKGNM6X4QidGs+hTCx7Roy70EsxxIFjyz2pyYDs=
X-Received: by 2002:a05:6102:951:b0:5df:aa69:be98 with SMTP id ada2fe7eead31-5e193d0ab7fmr372192137.6.1763474680193;
        Tue, 18 Nov 2025 06:04:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQGzvXSwZpZPNLSEPbENMSSFvZW+jmFJY3wy2WWlOPnirPhPFmyrsfmOoFg1sPz5BYihtVzA==
X-Received: by 2002:a05:6102:951:b0:5df:aa69:be98 with SMTP id ada2fe7eead31-5e193d0ab7fmr372161137.6.1763474679521;
        Tue, 18 Nov 2025 06:04:39 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd809ddsm1378104066b.48.2025.11.18.06.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:04:38 -0800 (PST)
Message-ID: <7bf64ac2-b793-4343-b6e4-41a88cd1295c@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 15:04:36 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
References: <20251117021645.712753-1-shuai.zhang@oss.qualcomm.com>
 <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
 <76edfe9c-1302-4e63-8bcd-ee7dd55a128d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <76edfe9c-1302-4e63-8bcd-ee7dd55a128d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDExMyBTYWx0ZWRfX6Dx3uG5Xibpt
 3NqIGA2Btts+QM0+zsj4T4Dr/QkqqTS+4jV4vmp+It7hvoNK+BGVYhJ7BXPxOYnKdKpNhlUFJsQ
 0o1aGl8lnJvzOFCEZvDx9SNEDTtc7gHtU1YYqaZR7lmc2sDgJxrR4HfO9jnU6dl+gUdceEHLL5b
 4zdeyqp4g0xAUlDpXPxo65fv0Asc0ObhdmPA77L8odoJYoHIrMLBPCuFoxFOK2dfsceTPnehh+H
 eCiypPzYc7aOsNZuWtv37RxpenbmT6hA/zqvo2PraVdueuhx75qoTVgsP5S/Q/SkInA8EdRNuCt
 NrFRc95QUXp65lNg2iW7PVreS4rOsP0JjtvZq+O4xE4gADw1XJsnLTWV3mXd/2bHJVn7oQtwJw1
 uD/VofhQ39WaGtbiy5nx4e3FltT7hA==
X-Authority-Analysis: v=2.4 cv=RpTI7SmK c=1 sm=1 tr=0 ts=691c7cf9 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=55LQ_9fuPLE9N9XlFToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mR9NimCdDvMA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: SxzL4JXnBFcJs_-6J1MeCTJZ24r3Vyka
X-Proofpoint-GUID: SxzL4JXnBFcJs_-6J1MeCTJZ24r3Vyka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180113

On 11/18/25 2:44 PM, Shuai Zhang wrote:
> Dear
> 
> On 11/17/2025 10:16 AM, Shuai Zhang wrote:
>> Historically, WCN685x and QCA2066 shared the same firmware files.
>> Now, changes are planned for the firmware that will make it incompatible
>> with QCA2066, so a new firmware name is required for WCN685x.
>>
>> Test Steps:
>>   - Boot device
>>   - Check the BTFW loading status via dmesg
>>
>> Sanity pass and Test Log:
>> QCA Downloading qca/wcnhpbftfw21.tlv
>> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
>> QCA Downloading qca/hpbftfw21.tlv
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---

[...]

> Could you confirm if it has already been accepted?

Please familiarize yourself with the kernel development cycle. You sent this
patch yesterday, at a very late point in the kernel dev cycle (rc6, normally
rc7 or rc8 is last) when maintainers generally don't accept patches.

https://docs.kernel.org/process/2.Process.html

The branch your changes will land before being queued for torvalds merge
the following cycle is likely:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/log/

which you can watch yourself, although normally maintainers respond with
an "applied, thanks" message

Please also trim your replies, you included a whole patch as context and
only added meaningful text at the very end. Please also don't top-post.
I see you're doing so as a mannerism, but it should generally be avoided.

Konrad
