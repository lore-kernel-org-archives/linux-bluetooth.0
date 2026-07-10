Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340B19CCF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643855; cv=none; b=NV8gXhWhM8zXDzQpj0EmQPCSJMwqbN2LtSHbcgNS/5XHEGlYdysNkm0GO1uroJQtZDhuzKYZWqJPLI1DjhqdNzMkoc7zo4EG9Ry8K37pgEdTS5OJFp3rNr8OdoSDKh6AJqR1Z8hwBCzwwd+Y1jl8roFYsPSLelUT9uNRKjLwxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643855; c=relaxed/simple;
	bh=YmRxb9U03rNlErOBGajCtQxncAxiRT0XO/81RnSyvYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB/jGlPqHA8r1Ur3PIcZclo5+m+HNpDRuYKHkLZYBakPVyb7oev+YG1mA+PISMp+c4H1hVcA9P9GWvUDiNQnw6d9g2SE2mXzjhWeL0rWQH9CO9o1IxL6k2BUDFQOB5KNyfwAtCL4OFJdJ+Dv4mahriNJZtsOL5lRyhl60Gw9lLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m1ToP/uV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ILpzqJVi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m1ToP/uV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ILpzqJVi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HWqG32563407
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GvhcGYTMJPejCfPdL/NP4toBFut6IfWuvYTk3dYNJaE=; b=m1ToP/uVxtJU8f1k
	Zx00FGR0ICX0ZsCVVHMc98lRb8Yzq1KKbbTAT62LjKASjdPEKHXE8w/mJGUTLotj
	58v2OrLWqlJ82GL2w7sPyTal5Jd/4mRnSGwpw4lHEZcFnHuhOzihndB1PwrmhwZX
	IYAJmGf7UpaPsslX3KBeNX6LOgFyyL0UaGgVR99M6p5Uc2TwMBhVOTcGlXqoOsF+
	eIDyZ1QQmuUoAbt+gLOJrWqVfOKNhOc9FLx4Hk6V/mUN90RhIFFp+PibrXNusBOF
	dPgyXTw/Kn+3f2h+wi/y5YkbYLycWEjj0qpxyzPHovkDXzzJAlKBiYKnwbpZdj4U
	o1cELQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3j25m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:37:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc7ea29141so1828885ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783643848; x=1784248648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvhcGYTMJPejCfPdL/NP4toBFut6IfWuvYTk3dYNJaE=;
        b=ILpzqJViYuyxCjkHxNaY0bE4KtDbAgR26B7gCIWPGwvO7kFJ5lq0QaRI3y0dLqCGej
         eGv2+h/wGQUCcdl5hAQsXOyhnTUC0ZX+iS2SagFXrjZRuIPQmsaI9LpojV8D0nTD+qmj
         gdZ16rWQegrxnSa1uq2L0GCOrnkKmh2bY9dxxWWj1khHxPDBbMCQQfQKxQQlZT+4GXs9
         nepg3J40bpcp/1at7pPl6pF7Gkzjx/oo6lsZyUdzRPUXWKXvPj1UVWuShW1HSxhuDc6D
         sEWd75dac0ZMiKEfyTG835BLm3YuW5Qg6Sqk2sswH5eRjFK/uSvPOonGoCLT7l4Ivd3e
         APAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643848; x=1784248648;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GvhcGYTMJPejCfPdL/NP4toBFut6IfWuvYTk3dYNJaE=;
        b=AZc6Rax059sI+a9x+rXkUxadKqdQOBc1Lii1vkvlYoG+Gnq4CxAXdfQi1+lhoUuTJw
         lsO7ALPSauPDN/zcdPzse8IJCRiL70qUhZlAibajIdwhgztLKkaDJc6k8A32YxBNZ45U
         fw/hXCMX51xGsWVdkeB9A0V3iVRYHdHxiMNvlDz8PbTDUbOjy7CkRUJeA6a4wWr3pZzC
         yJJM1iRjOWyftT7ktbLq6AEWB2KG+kVnk4TS18d5jQ9/Me+JA/g7/hFoSXBz1vj/G01m
         6gZ0WOn3HR4f6Memay12oIVTnI/nggZF5T96GP007Ty0F8fJAq1+hRgCYflhCY4Fqfkz
         WyFg==
X-Forwarded-Encrypted: i=1; AHgh+RowUeS2G1toy7X5X0HkC7leJEKHQ0d4UHwKjh2fOAGYBEy2oLJLi6ZWQay5kudygBwTJCqYDmYb+h1jEpmni60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqg8XQvMJhORcxCTrZPVfRZwrx75J1vaP2MOlzU3luxjqWM020
	N728ZtS8Ok/Okr23cGdgxRAizOKFvBuvTVePWkqwF2X4Za1QpBMQKRf8pF6awiuTTYwRiNQur65
	bMuHeZgA3aZIiFOy34CH13BLVkfSJrWSs2opKg/532LYXy47cI3VhXNwi95TX83xnNYaTjw0=
X-Gm-Gg: AfdE7cn+IUrS2JsQldwEPNfxKm+scQju1KawOBdOTNnas9kQ7l/pu80fvi6HrBromLt
	NalDsjpPpmP4bjp4mkbX1xnTXnr/XY+g2logd5O2Y6NElGy+KxXWFib44wqFUxKnJYaHyl2t0DK
	uP+Io8EcjVsy0WgRjriwjBQCoowLGq/Wmh6MOhTrHj0GmJ4xZURxWc+wFJouOtYPwIdS58ed0jI
	pqAVfarYERyEpfBi/42KeJ61E9XA75USG/03qBRAFpyIe6AsUnUVXxZP0Aw9RZC4WzL1fyhwZKZ
	Z/WCal1iR8Ix4aqco8axQMqaZ7+fFp91pK3zW4pmJ1qYNmyvSmp9gj7QZgEqWabLeCTzw6cY4Ns
	ydbZEyHYgll4SHBieNEOW5Ok2yrOKIWBv2uYekokopawlVRc4mFamx2nQ/UVWDXqLPWE4MQ0gS6
	2EeQ==
X-Received: by 2002:a17:902:d585:b0:2c0:db23:4a6 with SMTP id d9443c01a7336-2ccea33a741mr74572755ad.1.1783643848224;
        Thu, 09 Jul 2026 17:37:28 -0700 (PDT)
X-Received: by 2002:a17:902:d585:b0:2c0:db23:4a6 with SMTP id d9443c01a7336-2ccea33a741mr74572525ad.1.1783643847768;
        Thu, 09 Jul 2026 17:37:27 -0700 (PDT)
Received: from [10.133.33.243] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d474sm52320175ad.70.2026.07.09.17.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 17:37:27 -0700 (PDT)
Message-ID: <c56cb927-9ba4-4fff-9b2f-9dde69d9ab0b@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 08:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_qca: Clear memdump state on invalid dump
 size
To: Paul Menzel <pmenzel@molgen.mpg.de>, Ruoyu Wang <ruoyuw560@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709062250.4166128-1-ruoyuw560@gmail.com>
 <435c7cb7-945e-47c2-b70a-dff137f03699@molgen.mpg.de>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <435c7cb7-945e-47c2-b70a-dff137f03699@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAwMyBTYWx0ZWRfX7WlG2k8wO2c1
 11vq2Meo/+5yrY5uXOhqoKD7QZGRVDJWYDkzRunPn2r/0eNnbByryry2S2Rx5u99l02OX8blAuW
 WM5RoevtpI5KMOCI1C+28V8o3nmQQY4Xj4S4l4Mds0nqR1XXYCj/nu6qMel5MtKEePHW1j47j7J
 nTsuFXm4zOTZvPfQjV7YX4Il22Ct0LtDB/KL2tjNJrzqYDhLB+o2vd57MDQYwE1YEMW6KdpHmFV
 m6e/B4wyqLwrc5fkgUZkEDLEyFCjTjGjvlJRwinbqrEe6OOm+0UbCishmgt7jcTvIJrA9plxqUS
 hSyXU1R2oZkw9MTL5is2sKtSiGwhYwaWKQxVkYd7poWQtZ607BZ1y7wxMt+kDbCDjCCbvtZz45Q
 vjOjHSJRyc9l7rEIwy7FTyrZ2QXE+B/+Bu/S1CLt3/+aleUNGykcQvGBITnbjuZQsfcceMbTZwk
 FS5HU3YEqOBG5R2Ud/w==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a503ecd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4sb9oNcESZPBAQWmjUMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAwMyBTYWx0ZWRfX0d0ra1ERuTSC
 AdHv7aEgAZnLv9ZuN8ynXRs5MOOOiaOCPy03c14CuXnRC224RyuAmlBRqJIQ9ol5ZMAhmTekOTw
 AOVybM3TQ4+xrl3KodqXteEu8P7/ODE=
X-Proofpoint-GUID: ciiR22hROFNmbw2ttrhtWIDwO02B5DFx
X-Proofpoint-ORIG-GUID: ciiR22hROFNmbw2ttrhtWIDwO02B5DFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100003

On 7/9/2026 3:26 PM, Paul Menzel wrote:
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b2d1ee3a3d115..1222f97800f4a 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1087,6 +1087,10 @@ static void qca_controller_memdump(struct work_struct *work)
>               if (!(qca_memdump->ram_dump_size)) {
>                   bt_dev_err(hu->hdev, "Rx invalid memdump size");
>                   kfree(qca_memdump);
> +                qca->qca_memdump = NULL;
> +                qca->memdump_state = QCA_MEMDUMP_COLLECTED;
> +                clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +                clear_bit(QCA_IBS_DISABLED, &qca->flags);
>                   kfree_skb(skb);
>                   mutex_unlock(&qca->hci_memdump_lock);
>                   return;

Reviewed-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
