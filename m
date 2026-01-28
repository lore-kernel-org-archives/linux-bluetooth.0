Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4F2ED16D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572527; cv=none; b=FcBHrYtkb/d5u3kwBWY5kZtxeQa5bLXhzHUIftvw0f1nxVqpVJng0/3Vl5dijx4WgpQPgVlGwix17MVXtp6HUjyCkw9+mlodN6HF74fPtZ1PJjHIUIx6FVh61eovCWmITs+LxnsYeQ5HSv6Oy2hHdFKwewGaG0Jej/QWUlAWmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572527; c=relaxed/simple;
	bh=WHykkKVTvoX1tioyPgjt24UHORCDKOhRIyZm8zIUXIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLIOtRyBEwmUNZB66GnWn6olO4ZLVX/Z0vfaf3MNJoIxnxc1ARf9ViRQ74eBMj37eqMBN8I6ikTFAiOD24/MmUYJnfVAvmQP2yqW10VzVRCEN1LPfx7ur43lMci7lg4XcHhHxbDGgK+19J8IqucRkAKaS3cBUcciOd6AT0QNrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOJtRydT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQYDLtUy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOJtRydT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UQYDLtUy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RN4K1n3712915
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RqbDSn9eNmryfrGgqBkMCYUYqgtxmUHyERoRcVxeqx0=; b=QOJtRydT0o1p9uts
	jmZrRPdQqebq7QonWVQJn0iBP21NsOKYqTQmNeyNzE5W5YawE5hPVTOmvvWBEKlx
	hzJuljGJVNKu2ensIeSSIDMCATlVm+KXbzMh6u19FRgIwGcCtS41VxBIZgUVunm2
	xXnZBCKppErZnZ7GkxWwAzIDQRz/ieYQ9Ik76kpWVWD0Dx0xP3s/gtxLzfcr/O+u
	0heAha2q7dBidv6po/GpSbxDTqN2s3GCWyFNRSX8Ux1d/cs6ftYei2QnFBIMGheW
	U7XYxAgNZQ2UzcMO4+h4n5Giy+33DLwALsmcLFcjWp7LMB75QhTt9IHbDQjNPH53
	Acu7fQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by6qbgu1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:55:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a7b7f04a11so38727425ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 19:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769572523; x=1770177323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqbDSn9eNmryfrGgqBkMCYUYqgtxmUHyERoRcVxeqx0=;
        b=UQYDLtUyF6p8A+Nx02LTLzVoY6fBX2yQICXzQfLJGu5+bhG1w/cyCNiKeIYwKL4xjk
         wLd+ulNnSLrT0u3RvR/46WeULQQRQr7ivfEznum2wXCVZn2l0qH+2vJE4ThhyBedvogl
         P1NW5tkVL0qnb97YFy6Yotb2VFVfFGXBIJDK4NrjDtZoor/KwLUNRfK7NPC96L9FioYt
         efkSK625CkRm1p0+a51lZIlOuYLT6aQYOHDVpaxDGvTdC1Vahs7///26EMPqGapDqxtI
         X3dCJZzilLRBrJtRz4eKUViheChbOwalWncOhadwozsV3+z1ZkZMvuWy9y2mjzDEdy1q
         oTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769572523; x=1770177323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqbDSn9eNmryfrGgqBkMCYUYqgtxmUHyERoRcVxeqx0=;
        b=tLBvCTL4OTMytXcJ47REmstwDescDuEmzl+H6nmrFra6wgf25z4IW6sMlcNT8Jd23e
         fufFqm7svsIi76emybP5vPG6zbP8SIhXNaSiQSI+pAgZMbGntFXBMjsnJhRw/m48m2Pp
         4Gy54XeP1omVs2A4mC5AdDd0vTxg1GDEJtwtBLTlit3SxU0SIR/hHrB1PT14BzgH53zO
         3asrTDD3LeDF2QFpbT7wLDbJniI7vnuLiP/WRkpD4ow/tWKA9KD0y2LCYsF1IPcDpZBs
         wvxs7bV6aKpC4F9zxQ4nXhdUn6RcNPD6jFw/sXS661L53jOPMbqz+Vf5xd2OTwE/ZvHK
         RQYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDHzeBYU1A5PzGOJxvO1RFJ2SrwjaBY04GRaIIRLQSrHSpRTUqVm1/aeZ8PxzZWWPYdHc4nD+kAd+O8YHWGcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yF9PpOxHcdh6/QgTpq69zPwlOH8szjkMhDCjdossY7kFDFtB
	uzn01yRU9Zz8QrmZWVAqZwr98fmrUCx5/kXNL7vYd/DJkaiS2jpF4Ug0ufKnPLWs4riPwEVRrry
	PeN5jUuhOA8taxwp1RkvfBG0JTSsyIwQJIWwzYtAnxSXM2XNW1eYYWpXR8NRBpnWYq027+aM=
X-Gm-Gg: AZuq6aLQOgM3geiL3kUBf7d+uDBq25awMMEeG9lYoEu93yLFnlSRiGocrvqz5fZYHJt
	0F/M0SCBS+j8AfW/XIYzmjO5VP4JQAksF3qMd3PttXXs2Oqwp2LJ09izCqaWhDKrWU6PWqe1q0H
	JtPanMUNRIsMzfsAzLLygKBP81hTbbvmxU7rPBT9LfNSDzqT13yUf8AXxdi8vVe/YlWwmqiARRA
	vDfKTsP85B1bRG53iAeUBm8V0XX0ACJ5YXbcMZLemfFG7cmaHqWhklkMUZ+uUBu14oOBqPIIb6/
	aNsqgZFv1N7XDv2B7mZIIuggIa8j7jC8H66ulfUENCpTVU6YV27ict9x1qQk8ww+VPFLMUzuK7h
	kioI3Ef+3zhJp1ha79gfc40c=
X-Received: by 2002:a17:903:ac7:b0:294:d953:6ff9 with SMTP id d9443c01a7336-2a870e555b8mr44234515ad.47.1769572522744;
        Tue, 27 Jan 2026 19:55:22 -0800 (PST)
X-Received: by 2002:a17:903:ac7:b0:294:d953:6ff9 with SMTP id d9443c01a7336-2a870e555b8mr44234145ad.47.1769572522332;
        Tue, 27 Jan 2026 19:55:22 -0800 (PST)
Received: from [10.253.33.183] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4110sm7374895ad.84.2026.01.27.19.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 19:55:21 -0800 (PST)
Message-ID: <35ab1910-76b8-4923-b4ec-f8c104de31c7@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 11:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuai.zhang@oss.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        chezhou@qti.qualcomm.com, wei.deng@oss.qualcomm.com,
        yiboz@qti.qualcomm.com
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
 <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
 <CABBYNZL-J3-kcrN-B_1yXci+nw8zjgiiD_YFH0i4xeRNvY_Jrw@mail.gmail.com>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <CABBYNZL-J3-kcrN-B_1yXci+nw8zjgiiD_YFH0i4xeRNvY_Jrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rR7_EMnrzZ_gkmagzy3xGq8N7IUSS3_D
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=697988ab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uKruyNfH5c2KcShk9z8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: rR7_EMnrzZ_gkmagzy3xGq8N7IUSS3_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyOCBTYWx0ZWRfX+ok6wTvw4OG6
 y4JDfh/e/fd3O+xNe5uyuwZjK0GNuyKNU9gDvDKhx8YYmIDlNQlFLUko2upYzJ1a3cRD8Jlt6LD
 cPVdmHu/JV79tR7LkMHNMQUO6merVWfnAupEOIZQBkEW1qmGFfwlLmn7ZoFxR5PVN0+oO2QqeQf
 Cyb7oqv03NZzHV5gVCV3A4rOEC5Gp/5T5v4owNWlMliF7UNtqUiHydBpWDokN3LMowKBzssbFZm
 IDWAtpGcPV5PlZBvI3YJaz/cxxdNh3aSTNXt4eE3HPFR2EZ7BQU0S534s3vumfVHVFR5YWyOdpT
 Q9pBqMDTASpVSVs0B+sor+JwSAouT+RzSD4wjM5f2mce0aS7yByVl8L/Yg6vzwz/ii8Hs5PuQwf
 F0X68qsf8ZFQmxcPmrgWFMofjflJuOJCJL+bMpJSY3iHwfl3qj5KKDLbTH1br03g95QtGOkDeGt
 O3/CTPGTjNvKM1MDhSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280028

Hi,

On 1/27/2026 11:47 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Jan 27, 2026 at 10:06 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
>>>
>>>
>>> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
>>>> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
>>>>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
>>>>> data structures to enable Hands-Free Profile (HFP) hardware
>>>>> offload support on these Qualcomm Bluetooth chipsets.
>>>>>
>>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/bluetooth/hci_qca.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>> Any other chips which would benefit from this flag? If you are setting
>>>> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
>>>> set for WCN6750?
>>>>
>>>
>>> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
>>> considered at this time.
>>
>> What does it mean? It either supports HFP ofload, or not. Does it?
> 
> Or does that mean offload is considered the default over HCI, and in
> that case does it actually work with the likes of Linux
> distros/Pipewire or it is Android only? The fact that it is mentioning
> HFP rather than SCO is already concerning to me, the kernel driver
> shouldn't be involved with profile layers other than core.
> 

Offloading over HCI is the default way for most use cases, but I don't mean
it. Offloading over non-HCI ways (such as I2S, slimbus) need some other
supports from software aspect, these supports for other chips are not ready
yet.

I use HFP because I notice it was used before, like qca_configure_hfp_offload().
Should I correct it if it is not proper here?

> 
>>
>> --
>> With best wishes
>> Dmitry
> 
> 
> 

