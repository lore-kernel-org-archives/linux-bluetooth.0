Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DE30AD0A
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685301; cv=none; b=J+jDzGwbDIK7Cs1tpsfa7VRLYJaNnbmChv+mJHMR6NO6x9ReIaXUF61N79zoKbDhtSmmzlJQv6qZUXrPd0DDKUFXnwNbhZ6XkOUCChZpClD+jznepmFSzgbef6YB71WYynsaoe4GqqbCkN2XA2LEyRPaEzZlfWh4k989NvxrgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685301; c=relaxed/simple;
	bh=/x8jJlEp84PvJvZUCYE5U7swZZ7/tisiu4amOxNYegI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKqm9hOxYxwijPFftmV89mWjckKIKY9LTf1iy/6Jge6SODXeUZ9IWmKKuVnMBk1EbGSyRoBMeCUmilHPicDz7boK9Wfq2xwBsBNBZdXFrtWOUXMOnXKHZjSfBXrPq0Kqxlon2dpTU9Bzf0tXUi3AzcwpMrv16ZekXqgUe0h5yo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Je7xsfxM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z3YB5FXA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Je7xsfxM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z3YB5FXA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60649LLS2254441
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 07:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GO8a2P1GNs0xnvslVLQ6oJgZID2w0ORPE5dsU6eLmiQ=; b=Je7xsfxMat9yvqRc
	b9dlDgwKKiGSd53V8wEYXtRLajHrBjX1xMq2l7M/O9QqYDavHL2Ft/eaBbIMx0Mp
	j9R3ez7QUI3bEnYPiyDiDfVc17yTmgoK6z4K6UNsl4TRW2B9D3kWevJkLzHps8/T
	+btCMHVkWwt+CxXW+lOhhcb7rNSRGAmB8nKG1flxvwnWC0PXJOCr8PVm4hnim9wY
	lDa90PKxCKwV3ExUAt1iuLKigQ5gbkDsXyMw6EmleGZ5T362jk0Jss4Gv6Kxb2PC
	Bg7qgytLn++21HE1OlrHCMsXTxrayCRYrD2amuAlHfJHa+p7j07AUA2kaiZIC2gd
	K11s6Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu420j8k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 07:41:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f13989cd3so22430215ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 23:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767685296; x=1768290096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO8a2P1GNs0xnvslVLQ6oJgZID2w0ORPE5dsU6eLmiQ=;
        b=Z3YB5FXAL1clI3riiQnBJfIEBsGrGLJ4F2QdB8n4NiU7WsSmU+2kcglq12A1MnCxUp
         a8JRmaR4nysyTBqRqUjIMk5cGlmEMiK7tfHdxb/keE/w9qfcGz9A2JrKEhvpBXiQc5TA
         X/MqUTrW9BPaCWTtt+1rc8dQMVz817odth4YjVSQF3ogqWIRvP33Q9rCYZP5suEF6kP8
         35fjzCOn0WchJnBP6NN3xxLJfLEwXON2xrBYdcwomkFkA8wBntRpKWNW4t9XYTDdGMLL
         m6Xtok+xmfqKOhrSlQNY44c3FMUpXvKf4A3y5/AWIKFxYLYDscfjPWuBpSxUwwBpN6Mz
         qe/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767685296; x=1768290096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GO8a2P1GNs0xnvslVLQ6oJgZID2w0ORPE5dsU6eLmiQ=;
        b=Utxnq1dkG5vdfuxTpTmqP0VFXBtVmIBW/bGpz+qinw6egPERFIvJkslvQH/WJvvE6j
         brmthOkGHeDZdV7CmWMZtFkkHQO8Z5E9AYodA8vz1isvUd8lMv4l22YBcXWueRZwKdWp
         QR2CEFlx8c1+hKVxOfoidgCKTU0msIZaNV+Yxz3ddvQ4ssaRBDIhzDNcOduITDxT7z8Z
         SeX3DwiG1JTO1nKNYrkKx/tFvpK9Bsuku9p0PRBJmYMuniquyHgRGCD8Yx0U0Z89Oolk
         Lxr6T6w2VBbjgSC1NHwApgr5Mt1TqG3qvYhTy8w/ovFvGSdYEZJmMo6/rHKO3Un0muw+
         EZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfyb+0KMXKAc4keIPJVj/UHFdKoTuzNsT6VscpHNGY3fHWnOEieG7qTKRIdyaS6JM57QT38/3TtYQu/a0AYYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuHs+dFNdQjvXNHO3nf3ZJhHJE6siW2tlNpfQ6fN/g6Huogai
	Tx857Wl3Ce2Fdhb5LVLbxxe42kb8bTBEbOQbsMjf9GKcsFq2eIwLLtRlxwrBsAD7BrovSsCxECz
	e/H7cR94EftZumQu+aI5lCyusMRH702W/EIUvQ5DpLY0UZyFnbVbdZdHxVXfl+Gk6Rum/NnQ=
X-Gm-Gg: AY/fxX781pw4B0DOjUHQsXqNGoA2tuBAhAAYEWoo3vy48mdOCr6slImWjS/9Bo4NaWK
	ERIUhY1qDcoYNGfIPijSlENwD9/e61q00m98mHW2tQWWpFH9wyLnr9tgxHr2C+2dVFEk4A4PVbD
	lHa/kwqZ4qHblE1Uav3mETMfDFb/khdsozfwVOv1umkup5MW9GVvstmcg2uiqrdJk2ga7yBt6V/
	rCuxwE0+lvikVqyy/wG1Wh4s90slPIVfqDTK5MyU3jMPaw7Z27V1x4ZZ/LHGI9XYovTnRneCpLN
	p1+gaRfhYNf612l0uXMfwtoPl7OTIt9QBfknAKX4k48pZ32USfWd/IcuTTDVIDIvfC9LjWMmQjB
	L2+kgNh9MglYBegO/88LMnCYLPAsLP+g=
X-Received: by 2002:a05:7022:b9c:b0:11b:869f:742a with SMTP id a92af1059eb24-121f18a34a3mr2093313c88.1.1767685296435;
        Mon, 05 Jan 2026 23:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOCTRrhaewqHkomFtiYL4h3XHML7uxcz6q2akIRWzgWCr0s/iQHtThSr2VGzGSnsmsYmS9BA==
X-Received: by 2002:a05:7022:b9c:b0:11b:869f:742a with SMTP id a92af1059eb24-121f18a34a3mr2093285c88.1.1767685295970;
        Mon, 05 Jan 2026 23:41:35 -0800 (PST)
Received: from [10.92.136.148] ([114.94.8.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm2565089c88.17.2026.01.05.23.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 23:41:35 -0800 (PST)
Message-ID: <83fc2a70-b6c0-4168-8827-466e3584c493@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 15:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Bluetooth: hci_qca: Cleanup on all setup failures
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260105141427.196411-1-jinwang.li@oss.qualcomm.com>
 <20260105141427.196411-2-jinwang.li@oss.qualcomm.com>
 <qymmgw7oteikzceh3kyr664idl3asfqz67c6ibgpjruet4leje@e6xq3ov4gsag>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <qymmgw7oteikzceh3kyr664idl3asfqz67c6ibgpjruet4leje@e6xq3ov4gsag>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695cbcb1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=+dQloWKbpC4JZN4npCJT8A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=CNz0r7oPcfcQ9U3cNVwA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: HrEI_HD6Q_DpreFiqxVxzYfAiFLPG2ly
X-Proofpoint-ORIG-GUID: HrEI_HD6Q_DpreFiqxVxzYfAiFLPG2ly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA2NCBTYWx0ZWRfX7Rnm5iNadFgY
 MavTIbsIHLVyjReuuad/r5g1Wvb6zwXm7bDTfhJv2z9iQJFjelXcLJ98GXy4APN4FvtyxF9OGsE
 9H4gElaSbDQC+boTbxEqNczS/sty7AvvQZd5NPr16Osnc9UIteYKr7K52A9IgqfNoM4+VRuKEnL
 F4b7Cxjjh3oL+nObjXSIa/wJ3Mk0sUQzuKH0tUWkRgjt3UcWvf37bAKlYzdcPWF0aSvZoFVuLID
 BvXxoH6Uo4pwrOMYKPM6vRxBE0a9bLV01hCrE3Z/292RyZsnrhAzpEzTvoLwrDZjAWqu+hQmHcI
 ShDv5f5A4TUIsII9pUJ6tsucB3FbsMpRkRlZpBbCW7EuDtmZ02vMeFpOkAQMnAiZ3vk/mpvIM4X
 1C/CG0bcP+e6tFfJjrWE3rJhM/kwQoYWbTIYsknr11F110hYcKD4NB4NVbuKe7GIQ+uNOqkHj1Q
 CIAoSiS/XZAaZi6lW4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060064


On 1/6/2026 6:22 AM, Dmitry Baryshkov wrote:
> On Mon, Jan 05, 2026 at 10:14:27PM +0800, Jinwang Li wrote:
>> The setup process previously combined error handling and retry gating
>> under one condition. As a result, the final failed attempt exited
>> without performing cleanup.
>>
>> Update the failure path to always perform power and port cleanup on
>> setup failure, and reopen the port only when retrying.
>>
>> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> Fixes?
I will add this tag and update.
>
>> ---
>>   drivers/bluetooth/hci_qca.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
