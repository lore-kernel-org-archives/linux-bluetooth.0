Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26122192D73
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954417; cv=none; b=s4GyDTy72NVxQARawFI+58LuGJPcu06LcG37XR1j1T3ev+k24ilhcS25PnYoNv/aYgIqhMC4x7oCr7VJCAjUPDX5h98FGR1EMDYX9V0BbN3+3zRzr1hvUxUFImMbGuC5Qf8pCjkuBB1Sn3XEzt3kijaBWVYx5ZJ95xTE1/iIp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954417; c=relaxed/simple;
	bh=WoNSE/sE5fC33uSU/9fyxT1jw2V0Oynfwszs7Z6IVwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sx0TGGbNesKJuAG/Uw6WmdvoqzF2WyuQg0m/Ejfods1By7IVR0dTIEaKOXv2IH3FwfPDM0ab3eU96Hgj3eBNIxkHJUOi2ISS6xAjIq9aPwN44pMcegHkxjRj+q2jtdfYtqEZ+bwNv1CPQkmzcwa+egibDBYy/Ui1dvHK1PCUZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FpHhz/uv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FpHhz/uv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9mao5030750
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x3B4oWFzJNbqUipgeIarx9O0ibUhzHvQuYbYMdgwP1o=; b=FpHhz/uvwWgLvlHd
	E+D+I6Je46lMUesJcQdY9+eN9g/8+m995xQQG9SWhvL5CDXHtFeluwF3lL+hBzKx
	PZmGJ+UhGkhQbbjrhKTY8N0bYWgt9hxBkA7efJNmulgvV9xfNE3a5MI+bkLB2EBC
	M6rIBU4YM0ui7uVMS1LJmsaeqIXQpCnxnEshm9oEj66vQDr8PoMGQRPnJj4cnxvh
	Z+pa1RrixzILK6PqI+2Sme+/w/dLsFgD3a6b33S89gXsi+mNYCpWip8QMkg29BFY
	FdZLnj2+37l1D1WlU7UKEXQgJ/uNTmEV26++1DTASH2nRCNeYdYoV1ybfBjY5KCT
	0M+YTA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q5jb87ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:46:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f28dc247so46379985a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 03:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734954414; x=1735559214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3B4oWFzJNbqUipgeIarx9O0ibUhzHvQuYbYMdgwP1o=;
        b=ISL/Tx+k630MTJgmwsm9pe+Ij5if1GAN/P4AyhBR/TIwAxlzZHUN8V6RVBLc9/lHj0
         1C3hGprFotnKV/DG/mTowCEE2D/lVf6HV+cBi8j6/zd3F7wcucgiGTXwCWc3iV0GlPJh
         j/AN+GeVj9L2Gt0o+vx19iRejiPMWNYHWjXB+3glyt2BTCwsUrGF/e6teCslwPu9bucu
         79juW2qaBjD0VBBwsU4aIuJshP88ZbGFgy4wDTYpK44CFlVxjK95pEaV0Aqw3TebVepF
         EQWbRSenzPrSTSTCrvERckmN2/qMxGw9f1irxm4d8ASXJSp5QLPSLX2rZL85TvtzaGXZ
         dmxQ==
X-Gm-Message-State: AOJu0YxEAPEBZ6JA21yR6mP3/RefOL3BGoj6/3zgE3w92uQ6veafhyEr
	YnzvROA4DayQMwC/ZfcXRT7Rn9hxmOb+OHu95M6RsCRId0CdMHoYynpxsw0x/Ki5UmKiVi9SjcQ
	6WjGxtwvxu9Hzq40USkT8t4jAVn49y1+Y0AJr5aJ5z8odksvoIkAeAv1VS92J6BaI05I=
X-Gm-Gg: ASbGncvla6mkolGloprY+OOQdy0SnUFOb2yC/i2QSrEkEemNiqymck2DXfNdlp1gcfL
	CzMzoMMdk+f093nbImgTxKeawtVmdF8/RcVF/SO3H9ZtyijWLoyVe1uG4jC1iGKbNrF4IjYfnBD
	v3uywxixMAc7KaErz4cV+4Vgxlh6nnI1IgW4ixYN8oju1XBnRU4kihwLYgqF0/7weVQylMmU4pg
	N8thtJYtl/gCCuFVerBu7wOWa3LaKbKnAcSRYywuA3clU/eSaVA1iOIAkhjcxjdwWyzdh7voK3K
	Rt4jt2f+fKEXpWNpTT72OqVDXNEfxnKxmxI=
X-Received: by 2002:a05:620a:2a13:b0:7b6:da92:fcd5 with SMTP id af79cd13be357-7b9ba75c089mr709413185a.9.1734954413919;
        Mon, 23 Dec 2024 03:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNZDOc8mF9qHhiFj67lTcN+JTELVHiDCWwHoBDaAnJpVE8Z7J/DHYM1IQnlLkKvZX7HuEaXA==
X-Received: by 2002:a05:620a:2a13:b0:7b6:da92:fcd5 with SMTP id af79cd13be357-7b9ba75c089mr709410985a.9.1734954413501;
        Mon, 23 Dec 2024 03:46:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f192sm4984127a12.35.2024.12.23.03.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 03:46:52 -0800 (PST)
Message-ID: <89d308d4-8565-4e60-bab7-94474dae3b55@oss.qualcomm.com>
Date: Mon, 23 Dec 2024 12:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] Bluetooth: qca: Update firmware-name to support
 board specific nvm
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
References: <20241212150232.3823088-1-quic_chejiang@quicinc.com>
 <20241212150232.3823088-3-quic_chejiang@quicinc.com>
 <94eae703-ed9e-4f57-9786-99db7aaa07d1@oss.qualcomm.com>
 <db516034-81de-4e41-932d-c1bb26e1c55b@quicinc.com>
 <d5fe224b-7ef5-47ae-840c-7b6df21da816@oss.qualcomm.com>
 <3a8fe16f-aca7-482e-b1cb-e6fa37717843@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3a8fe16f-aca7-482e-b1cb-e6fa37717843@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bGRdff_OIEQxqA1mX1mh0dY3eRe2KPav
X-Proofpoint-ORIG-GUID: bGRdff_OIEQxqA1mX1mh0dY3eRe2KPav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412230106

On 23.12.2024 3:47 AM, Cheng Jiang (IOE) wrote:
> Hi Konrad,
> 
> On 12/20/2024 9:46 PM, Konrad Dybcio wrote:
>> On 13.12.2024 8:05 AM, Cheng Jiang (IOE) wrote:
>>
>> [...]
>>
>>>> /*
>>>>  * If the board-specific file is missing, try loading the default
>>>>  * one, unless that was attempted already
>>>>  */
>>>>
>>>> But, even more importantly:
>>>>
>>>> a) do we want to load the "incorrect" file?
>>> Normally, there is a default NVM file ending with .bin, which is suitable 
>>> for most boards. However, some boards have different configurations that 
>>> require a specific NVM. If a board-specific NVM is not found, a default 
>>> NVM is preferred over not loading any NVM.
>>
>> So, if one is specified, but not found, this should either be a loud error,
>> or a very loud warning & fallback. Otherwise, the device may provide subpar
>> user experience without the user getting a chance to know the reason.
>>
>> I think failing is better here, as that sends a clearer message, and would
>> only happen if the DT has a specific path (meaning the user put some
>> intentions behind that choice)
>>
> In the existing BT driver implementation, even if the rampatch/nvm are not found,
> BT still works with ROM code only. No fails, just a warning in the dmesg. For this
> new approach, we use the similar logic. 
> 
> The fallback to load a default nvm file is due to each board has a unique board
> id, it's not necessary to upstream all the board-specific nvm since most of them 
> may be the same, the default nvm file is suitable for them. But we can't set the 
> default nvm file name in the DT, since the platform can attach different 
> connectivity boards. This is a reasonable way to approach this. 

Okay, let's do it this way then.

>>>> b) why would we want to specify the .bin file if it's the default anyway?
>>> The default NVM directory is the root of qca. The 'firmware-name' property 
>>> can specify an NVM file in another directory. This can be either a default 
>>> NVM like 'QCA6698/hpnv21.bin' or a board-specific NVM like 'QCA6698/hpnv21.b205'.
>>
>> Do we expect QCA6698/hpnv21.bin and QCAabcd/hpnv21.bin to be compatible?
>>
> No. It may be different. 

That's a bit disappointing considering the filename implies it's suitable
for a family of chips.. But I guess there's nothing we can change here.

Konrad
