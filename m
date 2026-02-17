Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F37355058
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332691; cv=none; b=arCtGbP3enhmVqD6Ochg/lCIp/nPoyLWjHRV1c9EkyjhbV3GM3xf1pgtV1SwpRPS3JlRd/noeDwtlUQdzrWbCK6yttTP4q90xNl9W4K4gtLo87MXttr0VvLyVL82JrmzmXoMy/z/3xcbNIY3upybxs4IcoqeNcGBU3yt8OrdJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332691; c=relaxed/simple;
	bh=Ca3zSXt8QGtVOUGGIoxDeLx7u9+fOCOqDTWoTo2FmJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMPQcVbu6y9oR9N/ID2qh106oC2T2sLBhKE/C4UbiQSjAtG8BKuDe6mXmj297pIdr3uIcBB26i9EBMmstViwDjTXvmcQModOp7CLUY3ihmsX8lCOP8c+iYFwe//dXiyNbCE+VfHEg3OMCCyGorwAgpmj13jkxdmcjyBTMCU5I8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Feb49PJs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kH85NwAH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Feb49PJs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kH85NwAH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBDg9B125852
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 12:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	asaSuZLFZGJBkgVGIsOK4VggmZQuyypXqKdUggUVJh4=; b=Feb49PJsHWiHVOed
	tqFLfjMEJqVsssCzoNDvHM49DwOnTQrFcnXTwDvCrTMpcHr2awSOlfdT7s5YJRyo
	aEg5/f6TaX0mpHFY3i5NIJBC0LnWjv2sc2eJ5ASzdY0IhocssV1Ha+JJQozZRhLL
	DPmss3aPZt+oWJ/wOs1GNBOIHKt4hVY5GI3FiZ6l5SS/VCoJ6PdTAgEippwQeSvS
	efzaY6j78PyH7cuRvY069ZZA0RDMLu3w1SpdyAc/UY8CSfLzYilDuNZTKl2LXwoE
	YaeqwG+wCE++kDohWncstcmwu1Q4ROsFt2TWI0LlWy160CEpfRIGlVVz63k90rW9
	tfSY+w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxukgdq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 12:51:28 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1270be4d176so14889018c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 04:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771332688; x=1771937488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asaSuZLFZGJBkgVGIsOK4VggmZQuyypXqKdUggUVJh4=;
        b=kH85NwAHZvk5rSI59fZsSBM5JBJfPEMpc2dcQM+QuL1aKiZUvhTCS0PZk1wUe9ll6q
         +KopGukydeZtbBat8ef2ufEdijZX8ksQ3REtNIQXwthgMZUbgSN2+YR9dWHE1IYUeDLa
         syrYDTu/EtuqHfB9lERGgWwrDyj1YZ16sepZuqAMIN9LkksRFRsFza8X+Wd8u0L4uy+l
         FTp4JpDe0QPfu0kajKa2bivSiN5zB7Jb2B0bmmDyf5eGrFVsKJjmT9Erf7/ZyV+yY+Zd
         37brRn64p4Vj1bLNyXY1SJvarUkJMloJSsiI2btIxL7HNYI1SnoazOWYLTDFCHGbdZpq
         SNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771332688; x=1771937488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asaSuZLFZGJBkgVGIsOK4VggmZQuyypXqKdUggUVJh4=;
        b=hGnffkcHqK8FOGdvJO971dT2MYahfjrR5fz6BM2YXtjc0CV1dKCxHkx5kp0hyxMfAf
         ceS+DDkj8Fd4YhThigunag4RYFX1zDwuXmnBYBL2pbEWpDVEauOEhkwkZ1coIBMjff5M
         XQ/opI89gmsCbiX6VJbTmSBuBLuGgio9IVGh3ysguaWhv8SebmWqEdXbcwGCcoD2PtEJ
         Q1dovS11R2zMkAOgq9pKzvO7UIevk17dpBpzBLHzZ9VnuCAaGdJuThd5AsJwBE1wLODE
         JxEVlIJMxhzYaAB6t8FF/9KmHCpTBefGRO3eYNt/1JfeKPsI6rCuZPleE6vEeWXOtekl
         XJeg==
X-Forwarded-Encrypted: i=1; AJvYcCUhp+HfW0SQYO5Iu4Ws5z2iSG6K0d9RL08pLs1BIfsp961uqvJp5FQ6ByniURnCMICXvGHGutE6vTl9+UvasUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPjV7zzbvmG+4ZDdGr8C3EEK2JZWT10FA81JTfIYX58wBQYSk
	f36JuH0Kp00bAoNGAWtoP3tzD1SiCiR0rwr0TiLueylqiZmRsD5ZfWhMBpvidk7S+a0pw3Dp2y8
	RrYKKlANCiGLyGOejn53NY/tEyE/zo8PML/wC/yI10jPC6a2xhjqln/mjbhbPvSqsnSkOlvI=
X-Gm-Gg: AZuq6aK/+YSlV4oFnMe3zZO9B1ulb0krs7IQyKhD/AVS/p0OSjEnRzn9ezHgaUJLr1f
	diOjyI5zOJWvocnZvtWSZNbI3owKO2vNUJmjLC96MH1kszfdbWFShizf1E2+VPBLeajuhjEIcCL
	NLdcGOCoy8eFO2mZAJalliGt4couUPb4cqv6icUdzJFUBJ5qPpxIfVftHO2L9PZk9g/uvuEvnxE
	wNDLjp3QDtdSrgGZz5Qf3On36GarjfUwsM9JxOfJujbOs6kY0b7VXrJbVGmzLu8xfHVYCm0KWKW
	AHqUd8c97K/ckaGqIA0Cf/egU3iC7RfoGLdEEsHLUOKfIy1RblcUhKDAR2LEKfmmZ9XTqTYO1HM
	ClQKnSBl2sDmnEnaaujjY+5gVWBBK+qTz316sNCrWA6okYnwE
X-Received: by 2002:a05:7022:439b:b0:11b:9386:a3c5 with SMTP id a92af1059eb24-12741bebf03mr5406392c88.48.1771332687828;
        Tue, 17 Feb 2026 04:51:27 -0800 (PST)
X-Received: by 2002:a05:7022:439b:b0:11b:9386:a3c5 with SMTP id a92af1059eb24-12741bebf03mr5406377c88.48.1771332687205;
        Tue, 17 Feb 2026 04:51:27 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm17876010c88.5.2026.02.17.04.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:51:26 -0800 (PST)
Message-ID: <cdbef8d2-df96-4a41-98eb-3acc747a0aaf@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 18:21:19 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-3-vivek.sahu@oss.qualcomm.com>
 <mt4vrzmq7caqddwtz7nc3tn33zxh7uupoxfmk5pfqobhuex43f@se64qz7qvuh6>
 <19d3cced-f630-4a6b-853e-3798487fd769@oss.qualcomm.com>
 <20260217-mighty-organic-oxpecker-2ed848@quoll>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <20260217-mighty-organic-oxpecker-2ed848@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FsFhByojO7NddZAhAaVPZE5tfX2UsSpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX/GV5VCJqkOVg
 CZqMUdasqjeEqhbCZG8M6RBf1CywRVWJnptXCGP7Q87nnXVHR5IlJfdzuLMPDce+t4VUcVQr6St
 SSK1q1WVo33Tj0PLHEkgwmpB/u4BN2n3wH2oUyjmzduBehU/N/FTVKO8xOCMjSm4W8sE8HZ6tVt
 d5ZgUtnxhE14u9wq4Aw6r1IqaUDW5ope+DNQuVSeogJm7r2ezITDRlpgjdUb3pngnX1I3cD1VZm
 B/FZ0l4y1sLkHSGtqdhz4UNf8tSRQnEV7UUFZaju3F1h/tgvOFUgXK9fd7dAGrWAvRtDaMHE54R
 dx8UpRLvCdL0LVeTr6sGVc0ZBXsDwbYUGoPVDEoFrrrTF8nJYcLtEdOi+kVAh46i0fCpGqXtbZp
 t52o9ca3IXEhl0134pRF4SzTwds5Xck+96/MFR/VA6s9qdO5GfbuEToYVo3azJsylT8i8e81282
 qS0v8NpMmIv96/LKenA==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=69946450 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=IBWEejItevxuk87JBWgA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: FsFhByojO7NddZAhAaVPZE5tfX2UsSpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170106



On 2/17/2026 1:23 PM, Krzysztof Kozlowski wrote:
> On Tue, Feb 17, 2026 at 01:17:29PM +0530, Vivek Sahu wrote:
>>>> +		case QCA_QCC2072:
>>>> +			snprintf(config.fwname, sizeof(config.fwname),
>>>> +				 "qca/ornnv%02x.bin", rom_ver);
>>>> +			break;
>>>>    		case QCA_WCN3950:
>>>>    			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
>>>>    				variant = "t";
>>>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>>>> index 8f3c1b1c77b3..a175ac31e7b2 100644
>>>> --- a/drivers/bluetooth/btqca.h
>>>> +++ b/drivers/bluetooth/btqca.h
>>>> @@ -158,6 +158,7 @@ enum qca_btsoc_type {
>>>>    	QCA_WCN6750,
>>>>    	QCA_WCN6855,
>>>>    	QCA_WCN7850,
>>>> +	QCA_QCC2072,
>>>
>>> Why not keep it sorted?
>>>
>> As mentioned in the cover letter "qca_btsoc_type" enum in
>> drivers/bluetooth/btqca.h contains all the soc type which need to be enabled
>> for BT enablement on the target device. There are few places where logic of
>> framing packets transferring between SoC  and Host depends on the which
>> generation of the chip it is, refer api "qca_read_soc_version". So It is not
>> sorted in btqca.h file.
> 
> Neither in previous patch comments nor here you respond to actual
> comment. You just write something completely irrelevant.
> 
> I don't think any of this should be considered if you are not
> responding to actual comments.
> 
> 
> Best regards,
> Krzysztof
> 
There is high impact on the existing design if i make this enum sorted. 
We are considering your comments regarding sorting for next commit not 
for this commit. Can we have approval for this commit if all other 
changes looks fine.
