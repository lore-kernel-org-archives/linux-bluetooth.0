Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659B1DF736
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772418902; cv=none; b=Pb+qnMXMtYNJSROP3MNe5pErvumttGbjMdoNDE99aNbW6vW2L9Ap263ZOk9mmroqzr+CL6F9HuTY2KKLJ4J2QTIjeYmCw8cgjuu3vIowto77TbZUQbuoKFLHxGT18KSokMUjnROx827lvGikGOT8+w096brMBPGOsCLf1YcxH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772418902; c=relaxed/simple;
	bh=Xs8kJot3WRbpDNItkcNVq8Y7Uyd9/cwu8VHxLBqVH40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYMGh7z39upBgHXxrqIl6jV1nOhHbT053Xfx0w2i0PbzEYUCwFvx4sD6BKvSwoRW0W/7suudAbFOvY5eI0r1qmHlNAc/XiA+iYDtLHAiRxqDys2Y1g+Ntmk4/NT8Xd9QuXrmnkhfayjVb/GtqRo4CpL2tA1z1HTiwd9lWbBu4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2d043Eu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJsXAXuF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2d043Eu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJsXAXuF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621GIv7l1614827
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Mar 2026 02:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4DqqZkXLphrWO5J1IJC0ojtVAG7Macz0jvAFX5TiYAw=; b=k2d043Eu0CqLN2DW
	Kn6jO8ZlRztn92pkrbRSNJb4P/qh06cLPxF06HvFvNRnXw1rE3HRc2oRyTgLwJaP
	0VPsNkMLIq8ZUc4YUuEL2lqGo/zUPcjWJKbPds0sa9paxErImXrkGIDSOwxvXpm0
	g+7im50yTUsyyUZ3QwqYhY+0gTNJIOuplr9Ezglok3qO0mr3R1M7UWe/XMBlMjri
	p6rZ3i2+viL6qZvBv/CH36+s4dtOFYLjBsbW/EzDKTo1R9DTWM1qHmi0VaUc9UOL
	VGvgwtAPyTgtio6m53xlDBD5qlKEq9BLlYGkwnzezkdgFvXJ/kbxiYJiNddBb5JZ
	FgsASg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgrur24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 02:35:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3586513febcso2618134a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 18:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772418900; x=1773023700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DqqZkXLphrWO5J1IJC0ojtVAG7Macz0jvAFX5TiYAw=;
        b=VJsXAXuFTM4o2ZVTypkm5k+0LdgcRrxBh0k8UYPxHV6V2Mzn20FzktHDXDRLQtCqn0
         f2Dl+VAGFqVf2hehZNaWfO0v4EZ5H9NztFMB+LcmSu3CMTODp/SDBF/6wGsYgcXzLdZN
         GaJuNQvDFGlcHMf8WWDSsbKf8VC7qq9LItjzW7AR9nnXIMrZNqyt5mvFWuegTLuorNKv
         DPRX0s0KMsn9ckaHx49EDcFq77beyI+57aklEA7FqAEmMQBcHAZq1+EA1TeWmL8XzMlh
         JuoymuWUNSnGP6YcwM3eruQO2iJUF9pnoE2pcnnUyjRUVQX4zcyv1ZTmA2fNpyMMvftf
         P5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772418900; x=1773023700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DqqZkXLphrWO5J1IJC0ojtVAG7Macz0jvAFX5TiYAw=;
        b=NSvzmnypSKo9Sdcr/kiVTYDDD4C35bQ+LrJEUy/eBB+IbjwGB0tyz7Fovj/B1caeSU
         7jrUmZkupZm8NViFN/gf9aekA4RS2ug6JrHiiFjfzQVunblfjMDUusCpiAFIWSJgElmQ
         qDpW5F5/CcKeIfiKoviRgrFkE07ecVnshUGdUgqLc8NdbGcLXeXxxjgeBz+whnboHMgC
         x8jaWKS5P97IfxtnxOqyYHkxnPJbqscL4MFDUCXfi4w8AKFhiXWkEhHg7rkSmCh8DczQ
         GPXR+bwG6mFq2cWTJVD2fd7djlJg3jKtaPLAv90Okseg7okvkGUppLUOoX8H9ZmergUT
         rHSA==
X-Forwarded-Encrypted: i=1; AJvYcCWiibb2uI7irCoPYt9XkHkfcgaLIa8sHaB2anOKKM/T8PdZ45jwXeUFcenFr/wzciRaI0jEOX8XBYzWla4g63Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86+txtLhcfJxxx5PzIIa77RA2YD4Sqr+xuKNnMfFzN8v/ATna
	/205Pa4Y3WjQ2t+mCd0iJ9mebwJv5GoaRw1ko9j5/p8jRTZ907U5bu565/GjYZGBhmW6tdGThAZ
	Ozm0+k402DD0k+PDyblosSItZdnJrwimhA3FtjpQOvDDI6dw5oTjk50FcR+ZUs0ArP1XhmqA=
X-Gm-Gg: ATEYQzwDHAU9qgJ/VARiPZMTyGeIuu3GmlWanoOpLaRerDHA+Mb0ue2VRMq0WDzR5Jm
	fjlTt2V4dGCYXaXOeFE6MG1xfx52WcXNhdAt/6kva/2SFMB3kgVl0viD++1BzemL38hrxhcuBp8
	WhKqqpGbFIalj+WwecPOmNZColoGMQnSG/Nw7PMTl2pxCbims3zA7DxCJXDgSlkiKrXEpzluYcH
	BDnT2JpTKgTF2pE0UeZx1immLAfKTwGrlWeccNRubFFMFNM1XlHdMD/YnB3ogBD0jOJOeV1aWaf
	zdbybD4j+GvPu5xvk1VGCAJkHt/OF2yU2UbywQtp+0Rs/yh7MFMRubzfrF6J8ow0CGAzlF1ygkP
	SZAwZQfL1+yFQThxhdq6yQFpwHmNGcVSS4rZMnW1liTg=
X-Received: by 2002:a17:90b:5688:b0:356:1dad:1b04 with SMTP id 98e67ed59e1d1-35965ccbadfmr6626672a91.3.1772418899742;
        Sun, 01 Mar 2026 18:34:59 -0800 (PST)
X-Received: by 2002:a17:90b:5688:b0:356:1dad:1b04 with SMTP id 98e67ed59e1d1-35965ccbadfmr6626641a91.3.1772418899135;
        Sun, 01 Mar 2026 18:34:59 -0800 (PST)
Received: from [10.253.34.61] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3598e71565asm1011530a91.15.2026.03.01.18.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 18:34:58 -0800 (PST)
Message-ID: <5559144f-cd46-4fa1-89a2-8d54a627ed04@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 10:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
 <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
 <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
 <e544645a-e113-4ff0-bb1a-3a6577d6a83b@oss.qualcomm.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <e544645a-e113-4ff0-bb1a-3a6577d6a83b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyMiBTYWx0ZWRfX/AWGBtnm6wRT
 mWaLv9NoDjFQwfCCmbnO7osQufZ5qO6TYod3FYeizvMXBsIvrHnOMVDjcSygRexKtOY1bGALFib
 UYmlYyehhw/dQgvL5CadIaufVnTHV8ygDWpu8N6zur8etpR1m5QxWuI69/i5bkYwt2wXR/sD9ZW
 a4nyeepMJ4RifTP0okxHMNhCSRdvr9q8aqNzJy05tVMKIG6VQY16jZvtlYgsiFcVlorxKymM3Us
 1FR4lJB6eD8keLc9F+TXGB27whrvP2UsU7OqZ+G6Wx6F2xi68EisX5a6pliBaWM1e+9cnBHdHla
 VOikWwhePwgPDYiWPXMHbfbWgsB9s6WMkEKyv3q30I8c9OHO8reSqIYyISDYTxgK1rxIdGTcUZH
 ml66wrVoH6Kpm8J/GcFMb3MElru9xJlpP6rk62TQJh5G2to3btSDQDBXuTBCzmzwFFHz2y9zqNW
 RR3SrN9sf5LqXZ66pqw==
X-Proofpoint-GUID: 4HcVYtYX7pKrrs6yRBtlgdVJKg6TWBUB
X-Proofpoint-ORIG-GUID: 4HcVYtYX7pKrrs6yRBtlgdVJKg6TWBUB
X-Authority-Analysis: v=2.4 cv=Zqzg6t7G c=1 sm=1 tr=0 ts=69a4f754 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VQt4_GuLh9oJCfVlm4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020022

Hi Konrad,

On 2/26/2026 8:15 PM, Konrad Dybcio wrote:
> On 2/26/26 10:14 AM, Wei Deng wrote:
>> Hi Konrad,
>>
>>
>> On 2/25/2026 8:27 PM, Konrad Dybcio wrote:
>>> On 2/25/26 10:17 AM, Wei Deng wrote:
>>>> Enable BT on qcs8300-ride by adding a BT device tree node.
>>>>
>>>> Since the platform uses the QCA6698 Bluetooth chip. While
>>>> the QCA6698 shares the same IP core as the WCN6855, it has
>>>> different RF components and RAM sizes, requiring new firmware
>>>> files. Use the firmware-name property to specify the NVM and
>>>> rampatch firmware to load.
>>>>
>>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>> ---
>>>> This patch depends on:
>>>> - WLAN
>>>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
>>>>
>>>> Changes in v3:
>>>> - Rebase patches
>>>> - Remove unintended 'output-low' from bt-en-state pinctrl
>>>> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
>>>
>>> Only now did I realize you're the author of both patches!
>>>
>>> Next time around, please keep them in the same series, for easier
>>> tracking (since they're very much related)
>>
>> Just to clarify — are you referring to the below WLAN-related patch and this one? 
>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/ 
>> If so, they are authored by different people. This BT-related patch depend on it.
> 
> Right, I seem to only have read the first part of the name.. sorry about that!

No problem at all, thanks for the clarification!
Appreciate you pointing this out — we’re aligned now.
Thanks!

> 
> Konrad

-- 
Best Regards,
Wei Deng

