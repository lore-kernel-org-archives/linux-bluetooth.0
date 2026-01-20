Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F33D7D6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903741; cv=none; b=ixChCtUwS+a0te6JzFQEG3AYiucXLmtjXW8D7x+QgsqtO3fozthaJ79OoXEhd5I6Td+Pg3IzpZ2jpu0e745XLjPELbGrjZGSltsrdcOcW/yDmBfrhhFr6MgAhbGaEJIoMvEnKs0rJul7641h6LoO13XTAB3h4hiqzeOn2BRwLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903741; c=relaxed/simple;
	bh=yz0X4B56o0xJQ7v4pyOQFGL4zSaD/UvOL4okAVWFLk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=kVPRZQ/sykM3XFkuBd6RGrC4ydRnPXrBmqtBw/r2MpPr5GgspSVyWoh3YZ6WpxMW9wP7I4Ci25ZDmguGH9E2bQPyt2CTvaR//R3nuifOND8QKD6uEcb5b64JTVwZYd5c90sYdonYB9PupwA9Mo8vAyX0kGOo79GjASkLvzvpGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XL4hTnJN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JlB9tvr1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XL4hTnJN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JlB9tvr1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K33Hbj3805133
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 10:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9CJZetFiZ5EMxXr8wlgpLR/AVlp9ScPsDs/V+VrVgz4=; b=XL4hTnJNnM664FUt
	lDX4HnSiI3o0uTMh4cH0CV4Jwv8T2yPi5yMVQMZDxs+nyQsJDAOciRjLDz2MSQYf
	amXtFL/+p826XCaNj/NllIbO7Bdn8jwEF8YQXbg9E66f+6yFpcCAXorfJVccZMI0
	IJVmEcMbRayKzk0W+/Gf4CE7ZEPUdEhPBjpZJawNJN9CgFuw8or69PL1Z3RnWhIK
	dszasiLoHDUQmlVL/CRHELkxn2/OA6v3U3dH4styP1fbwakoIhGej0tOUDy4qbf/
	5yLJ7ecnG4GSnnlVOZhDHo9qFCNLYqHLb/dHbxHsCLNqEUQJgy8NySP8cuimSbNF
	A3zU/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt1f896ba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 10:08:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c21341f56so9716978a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 02:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768903738; x=1769508538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CJZetFiZ5EMxXr8wlgpLR/AVlp9ScPsDs/V+VrVgz4=;
        b=JlB9tvr1/H3A5//i7xCgpkEQPTLKu6fruALdtDX7yLiM9gfi6wi+JFMoU8oKAT+tSJ
         7OyKqyDdjHuDPw7eut3msxC4ewOXDKZID20TNv+8LQjDqdlAW0ai2EnVj8rzIng18cMl
         vj3vQ60zPDcwFKIwK1KlcmQcTdUNS04ZKEtd+tFA+GfscAo5wAncOWoltRtj8tsYp0Jm
         eM/7cd7SO7mS5JNQjTFfgpP4V6xIWQGkJzVgbZi/hqLgAquveDSFMs4uVu4B6k5LZK7X
         1nU56P0jDhAk+ECBIsSA8NG+/LGFFQef5olgVcIhG10GNa2lTynDYwroJzy3Ba1vLefN
         ms2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903738; x=1769508538;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CJZetFiZ5EMxXr8wlgpLR/AVlp9ScPsDs/V+VrVgz4=;
        b=B0F1t9fnkZXPaRkmoAFtBvjTGX0WDVOzqBNAM+Y1K0xmgcgRGpMCyqFxfD85kqORDn
         Xv7Xd9RKX3lAImFdKVFIzVJEzSYE95CmuISNh71WOhfKqcaTgDg8cBNuBc1HE4LkYtxz
         VUi1VuHoDvH+nFuhD49Ihg0olQW1JrPjgh9p5dj+k8435HXIM9wUOOx0Gst/dakZBxY5
         LcUiWkmCL5h6mu8C/NlYlbOGTQSc88hKtEAG730cchhfRcx1tBpFlhyWhkR0d5qoE7Xp
         Hu4ASLpb+dQYXEdwa7PCxcA7PdWTgK1PjxFhko0TbdPB416R+zqzWICeV2fUTWANNSJO
         WEVg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCirLk4a3ddmVM4YH5yGz1NCs/eyqVg8T7YxCDjk9WyBgYp/cmkfMegsAdhoFAEAo8YgmWkIlgAzmtYKtUPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo15/NoMgw77JfyHmsv3FaWz6Y10LEfrAcB9FKG2lDpirRYqi7
	WFpOQ/Fqt5fG9yoBq6F1zL4wiF/fSC5V/1+MbOTuOJtbeB0yM80o/k4hR8H4h34R+4DJdkRaBCg
	QZ9qlC5ErHcpZ7OHEnzkBMrobrhpI8FWFWTXIpud4CeEI7KUdS03tz7+205tDSAlokjChk90=
X-Gm-Gg: AZuq6aKhlpi9fdaeOiu65sAynoR30V6JbvjtPorUrLLgwaP1ZYUg77lqvYqscAER6uR
	UOYzLKADZJSg+w/n1aPdwz0Ws6Jpqin5NJTqOikwDI/ReGMtmnGt3PN90WEfCbXQcUdMDoJjdCt
	8MwnPq38IOb4GYwHkmYkvBDkSM4CrpPX+QehSXm5w7DxWHH2/Aybm97qPrRioH5Nsl9NrN/95EJ
	zdE5iTnzZtkJ72mzWNS53+M9mjb0aTPVB0PMLHaPXurK7YrA70VLtogo6r6XlsCHMKip5m3p6Sh
	gB4GIypGXfGnqwsd45kwPZl6C5l0RA20tO+RfFjzJNnvKhErAfvMtHzQrfUKgHjV+DuC5lNWNii
	iv11HTlE5QM9ECpstjGGGRhpBnwUPPwBIbqHk
X-Received: by 2002:a17:90b:544b:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-352c407a7e3mr1236587a91.20.1768903737743;
        Tue, 20 Jan 2026 02:08:57 -0800 (PST)
X-Received: by 2002:a17:90b:544b:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-352c407a7e3mr1236574a91.20.1768903737276;
        Tue, 20 Jan 2026 02:08:57 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352c150faa1sm1663686a91.7.2026.01.20.02.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:08:57 -0800 (PST)
Message-ID: <279d96ed-865c-4f15-a67c-ee1a94ea2c3e@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 15:38:51 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [PATCH 1/2] DT: add bindings for QCC2072 Add DT compatible
 string "qcom,qcc2072-bt" to yaml file.
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
 <d180711b-7957-4252-b34b-81312705555b@molgen.mpg.de>
 <BY5PR02MB6946637904902544E6767829F189A@BY5PR02MB6946.namprd02.prod.outlook.com>
Content-Language: en-US
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Rocky Liao (QUIC)" <quic_rjliao@quicinc.com>,
        "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <BY5PR02MB6946637904902544E6767829F189A@BY5PR02MB6946.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4NCBTYWx0ZWRfX/vxMigxYqJiq
 rdi5Q1vj3t4Fv+kIzK+lsVbC9Y7L4TEgRSQom9xhBrbAeS9z9Pxcy6oGk99Oo1vcqLL5yQ5cl45
 4tVDIeUVd9Q25bENvuz2NuHarXd+DSj6BRyRoB6BAD0VAMJUR5M0jDmYoviY5jkKdEYc9knFFGD
 3wNo4uTnJR2+4YWOJCrz9SbIExuBtPDFs0oQuIkTw6NskjP5DXfjwEp1Td3lzFsqtqdOGngRv/b
 k5wswbBTet5E5boG4VAHeTgGVQy0BEfAGuw52WdUeFaqHTA/KVSyClomvIbNmdiqzCXKLAHG0IN
 jw1UeYbnNqu05FDF7SXDcbMD18ueV6CvO8I2Ti6x9RhbRwmdom8ZY0IJt+up8bPyIPZMK1fQh6V
 IghE6LimVfxWq5pHJ0pSp5NP0FWdmIUW9XbGnIuGY2Ly4xvAdy8ktTig1bap1oGO0xZ6drIi5tG
 JFoxzYdKb/a5rwD7deA==
X-Proofpoint-GUID: OOyTfWuIngm1JUV1AqjyqnCNe1BQTyDQ
X-Proofpoint-ORIG-GUID: OOyTfWuIngm1JUV1AqjyqnCNe1BQTyDQ
X-Authority-Analysis: v=2.4 cv=LdQxKzfi c=1 sm=1 tr=0 ts=696f543a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=mJvZe0GqcyW80rR8KUMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=M-Yerj1wOn-OpK7r_3ei:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200084

> ________________________________
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: 17 December 2025 19:44
> To: Vivek Sahu <vivesahu@qti.qualcomm.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz <luiz.dentz@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Bartosz Golaszewski <brgl@bgdev.pl>; Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Rocky Liao (QUIC) <quic_rjliao@quicinc.com>; Mohammed Sameer Mulla (QUIC) <quic_mohamull@quicinc.com>; Harish Bandi (QUIC) <quic_hbandi@quicinc.com>; linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-msm@vger.kernel.org <linux-arm-msm@vger.kernel.org>
> Subject: Re: [PATCH 1/2] DT: add bindings for QCC2072 Add DT compatible string "qcom,qcc2072-bt" to yaml file.
>
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
>
> Dear Vivek,
>
>
> Thank you for your patch. The formatting is off, and the summary/title
> (subject) has two statements – look yourself in the archive [1]. Also
> the prefix seems wrong.
>
> Am 17.12.25 um 12:28 schrieb Vivek Kumar Sahu:
>> Signed-off-by: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
> Please elaborate by giving more context, why it is compatible, and I’d
> like to see how you tested this.

The compatible string "qcom,qcc2072-bt" is defined in target dtsi file 
and it was tested on the hardware. The corresponding target specific 
dtsi file is currently merged in downstream.

>
>> ---
>>    .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml    | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> index 6353a336f382..197248d6f7b8 100644
>> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> @@ -28,6 +28,7 @@ properties:
>>          - qcom,wcn6750-bt
>>          - qcom,wcn6855-bt
>>          - qcom,wcn7850-bt
>> +      - qcom,qcc2072-bt
> Lacking more lines, I am not certain, but I maybe this should be sorted.
I'll address it in next patch of this commit.
>
>>      enable-gpios:
>>        maxItems: 1
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://lore.kernel.org/all/20251217112850.520572-1-vivesahu@qti.qualcomm.com/
