Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7F397E8B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897728; cv=none; b=eMH0MBnbIr/hznSlscWTwjXaHoQ12xPSEEp+W9+2Ut1SofZSg2+dRx3vNhR5zdNck5MzDjIqsXkLqNV3nVfPgeiXoIQPbuNPOVbjPIjsNG9qpKBYTtaBQ6JByPh8RH1L4WMOkBXu8lTg7ZZK8XgUfWdoMNiVzBLc9Jd0Oi8yOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897728; c=relaxed/simple;
	bh=a5iiqO1Am2OWCq075yZfw2R1p/EIkUJTHJLlohpIPmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+4wrynl1Aj8pdRdUiqM9CtaJi/Xo6YP4bImKfEC5+24tIAJy7nmCqTAA03Oz+mBRhWaE57fgVj5mxTTDlS/R0ohVKKRLy2op0csZRYqgOQM75EEj+Eb0sdW+XLY8U7kPQzhRLTpR8pZ+gHHPkiLd9g6MokYXVdFeVfl7aSsKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LjEtOZxg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=awfWVzbF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LjEtOZxg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="awfWVzbF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J0JSH31928643
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4I8/5ez3q2OJRFcbgSMBcsslv1AdLgBA/kvA1ffDk1Q=; b=LjEtOZxg7h7xv8gN
	FixCK5mcVT/TUuTAKxHkXBxQTM/HxbFQWAi+Ur+GHjEhPVeaaPVYKAFI4vNGIC93
	zbnSLmRS4S9yAMqlzZZYENJlVDNMfGyVzz/kfPxSRgQoUxHJwsiZecw25Uokd0Zn
	tODeVnrEeHcx35O+JWurKO2cK/p8jVa+8Svem4JQYkN3oqS7IbTNPtoSEg01WQRy
	yGBy1GYJlANI68WotDUk8vc8qSWNbG/LcJpoLkWPM0wBG6Gpl5/REYjY/JT4Lkrz
	NxX/EfimjjwN0q4gy/zbukRF8nBuXYIouc0vgA1V8PWbyUYSFHIsnBh9l1M3y5Hd
	Hf2Jlg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyut1b4ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:22:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c0cb775215so14318706eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 22:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773897724; x=1774502524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I8/5ez3q2OJRFcbgSMBcsslv1AdLgBA/kvA1ffDk1Q=;
        b=awfWVzbFnZ0pqmVdh68DtJzQJRV1FvDA/7OtTCmCtwBpmEduCgfSLVDgpxhSZp7XP+
         zIXT52OTcFH22O3E0W33fxMK+K+ilGXsnsdrqSR2NDMm6oTwXI3kjOaOZcu1CIcdU0YT
         bDXAcnpJ713QALYahVcRykFEJWluQtWYxuFOOk4rWu5PH0rmniVo/OUtRWeOwGjLhyEw
         nN1BvdHXxxrddnvN2D6GWqaTJF2HYsPJHd51RweteXXoO7iURkmoZLFGyEPDowC8/ma5
         UtIaTdclJ01sSy4vOa1VUHLpJy67xXToTcab6fC9jFKCsuuQALnH073fVhzasALbtLcN
         anhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773897724; x=1774502524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I8/5ez3q2OJRFcbgSMBcsslv1AdLgBA/kvA1ffDk1Q=;
        b=M7Xm2Q//AxzP8BgiHNhU6Vr+nhn7sQVP7nbb4V6rCAZ8J82ix2TzO+c8Jrq15HljvK
         gZ77t+y93zlezFaIftU4DLmUoy5zTWGeD8DjRBj4mV8IaOBGCueC7HOmcoCHo3yqOPwu
         F8adxmHvp1SB7gzWpYGjaWhBH5as18WgN2bdTMlb14ThAIhkplEHoRzUzr6H+uTZOy7K
         i4T0Z0sVHT9SXLrWNgbMXeBUYkundEV6WIEWSrJWMaQ4WgKuRVl+aqHJsnkNMF5pqwD7
         JJFtGkkCIg6BdIk5pjTXdAauNc0LWRS90mYOGWjxW1bn/tqfGJ8bDdzTwCritdcA3CKy
         SueA==
X-Forwarded-Encrypted: i=1; AJvYcCUg1QqVPqlaL8KtgifC2xpZRW8vznL/z+9xmE88Pd1moK6HQDLTq4gjIa2vcnMA3j4OEQxWu/5NgfOKcnHG9sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfs1YgTsh8biF4VP05YTBoJscRbgAwWGqH4gtTVEFKYHtHC1XP
	D9aT86UuIlUkl8l7jYwnpTcDTChdV/79HvTwWRSqvhZ1AppveSYQAC2wwAVUix1IffcywrMICfi
	97GfwAEMs9oXR3yAxqjsDouZ4IGvjrX+6xnfghMl7LIkqGp2KQ636lz2NNU8kiMFByDdDo9k=
X-Gm-Gg: ATEYQzy95U5ccDImVO0y++C6wb8sWUxOFtaqCRTOiGF1M4vRToGGxPInx2jqOikJDB2
	s3d9XPhTwIiQZdy1M7omztA3S7U2pIROXayCfnNr7WjvOFQb7IaB1G3G9r+ydXgVBExMLppszIX
	3D7I/lGu+WIZnGY51kPcZDVFWi4dLEacwt9LRniYUznl/B+c6G8LJTYzAsinOxuuM9YAIpLSHqz
	/nU2ZVT2D7pZ65oqWMaER5Ik2k62r9Lx15i/4KpAindFQEw30m8NaZgeq6mF9X8odU3BSSPSn3a
	bWVxKgLrprjmcykxBEJHBthYYtZ7DfM36Qk6P+Z6TtB7rgiJgYAj0mI5DWEAm+7wUTm0kmrI/gp
	UyDOSiXbFA6sjVczRS0C/a/9gbnkVs1gWJBAwLsqVz2LRDQvYHr3TU9dWm71qK+0tXiULq31b7M
	c=
X-Received: by 2002:a05:7300:cb0b:b0:2c0:c27c:339e with SMTP id 5a478bee46e88-2c0e50423a6mr2959127eec.25.1773897724485;
        Wed, 18 Mar 2026 22:22:04 -0700 (PDT)
X-Received: by 2002:a05:7300:cb0b:b0:2c0:c27c:339e with SMTP id 5a478bee46e88-2c0e50423a6mr2959121eec.25.1773897723954;
        Wed, 18 Mar 2026 22:22:03 -0700 (PDT)
Received: from [10.110.94.9] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e559ff3fsm6714643eec.21.2026.03.18.22.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:22:03 -0700 (PDT)
Message-ID: <1603a5b0-8edd-4c31-b2d1-344ee7df10ac@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 13:21:58 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
 <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mvjay0u3J3XiNyM1Oz_RMZ7D5M-PrPXq
X-Authority-Analysis: v=2.4 cv=ModfKmae c=1 sm=1 tr=0 ts=69bb87fd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=AYBSpBTACJuzp8GJotcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Mvjay0u3J3XiNyM1Oz_RMZ7D5M-PrPXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAzOCBTYWx0ZWRfX33bo9JN5XjG8
 0t60r6aoFz5mbIMe2D8kBjSvOUMBG2+/8ermuoC8ozv7cGx7nzayU6Thht53N4eZSbcb9B9sSA+
 SOcy+m5mlSH3pegYjdF4/8f4B52d75tcepSO4Qoie1h2BFNEEiRCjhsMgFJkHQwmK7Drosn/AwG
 SaRhf1iw1+wTcDsofFd1/fvoIhztCr4LjzYOCh2vfEYSGbar5eO8Nmt7XR/hSC2o7Z2B5RcBdOO
 vrT77xH3Ni6VWZzY7Yt/CBpPN1MZ1YwcKdgqAPsox4fxzbCjUfudnD0cs9QHkdjeDoiMV48pdv5
 rYm7GA4iKp3CjHaU9CKB5E32hjbiSctboA9H5/lvVWyLC8FURGVs0F1AaLW/I+uIAhb6HpDAGrZ
 W7EeH9yS9xBRibVG2Tm2Ne4yNipsbjsn4z6DNOTqXUlIWrp+EeH2Gq8CA/LSRSSmy8wccHjyNJe
 m3EB8YQWg13s91alSAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190038

Hi  Dmitry

On 3/19/2026 11:51 AM, Dmitry Baryshkov wrote:
> On Thu, Mar 19, 2026 at 11:10:40AM +0800, Shuai Zhang wrote:
>> For platforms where the bt_en GPIO is not defined, software-based power
>> control should be disabled when power is managed by hardware.
> What does it mean for this chip, managing the power in hardware?

bt_en is pulled high by hardware, or described in the device tree as a 
regular always-on GPIO.


>> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
>> cleared when bt_en is absent, aligning its behavior with WCN6750 and
>> WCN6855.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index c17a462aef55..4512ff7cd0c0 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   
>>   		if (!qcadev->bt_en &&
>>   		    (data->soc_type == QCA_WCN6750 ||
>> -		     data->soc_type == QCA_WCN6855))
>> +		     data->soc_type == QCA_WCN6855 ||
>> +		     data->soc_type == QCA_WCN7850))
>>   			power_ctrl_enabled = false;
>>   
>>   		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>> -- 
>> 2.34.1
>>
