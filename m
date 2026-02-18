Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA130F52A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415527; cv=none; b=s+IDsF58AYmeAr/NVtUWNUxJXN7OIeJbSPfQZlNUIueze9eCZv/bETBAG883jrlgYIAuTEM4VJYr889jSNCz6b7VtAe6ac1zYNgFwdWykfxQmSZhpe3rbVFB6ZpxkT3AYsb4bnnqOeCsIAI3grGk/U3HLlynYOqIj9oC81Vqkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415527; c=relaxed/simple;
	bh=XauVvUuBZhYsr9MKZ6ELvOnNqNIgI/9JLE17Lm3MYgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inmbVfUWMM2MwJ0L71DCM0SAdidr2ZoL8AsgbOOXojAbDgFxOwIg4VZw+FhdEbvU3lCHYzJ4389LcH98wQME04PpkWiSKHmQrkwrdq+uC1Vu81p0Kf8vyLNTk85udZPvh6NOinv57S0xChC87afTADcgcbr/D9RA7HeNBdaGBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWpYVfrs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LEAtmLaM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWpYVfrs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEAtmLaM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IBUoTG4060324
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDRjBFND8147IxSirZUuWVkN3Wo71mzLZsgaNY+6T1o=; b=iWpYVfrsyo3G7Ypd
	xkHq/kLBROF78D7P5qFbKPyAue7KcMA333j516EUnLg0Z8ewuScJHKSRNCxN7z5/
	OBJ0U1zqhQ5kOuCVTbt8psEtbCHa2glR7OEbyv5lSJmpXIqyS9DSKyszYLeIr3/7
	JRDuNNzXIKD5ZNftuyNpgeq/FFwYRkdZdTV2HmCCEug6l/Lr3Vld5owObzcWM3iP
	Ty6eRxCslkgZr3IOSDi4u1PusGWhPXj3bS+qkoGvYfldOg/PD1KDGbo/2qClfKeW
	YRvN//FIRL6zhfvZY22xPPOqAPrF9Zuh8dmVCkIR6TqmrcpXB1FvI6gwkDEZf5Jw
	AmU9hQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd1qx1mjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:52:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aaeafeadbcso60853385ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 03:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771415522; x=1772020322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDRjBFND8147IxSirZUuWVkN3Wo71mzLZsgaNY+6T1o=;
        b=LEAtmLaM60cAqdIoYv7/ckAhPICZi8P8h+aAtn/NWKOb5CQ71Mho2LBcgCbOkW+LIO
         75NvCQTZQY9wqxGnRk2nvY4X8lsqJygl1l6SUf2yszPTwnigbPT14GqmxUUuxj+LIbRW
         xE9w0+v5PnxQbt/NeAqPh8q9FJFd/WwbiNe3W0FP8F+BZDbEYdqeQpl5RCLBSca8v2P6
         Zd6jSTTDbdno22P98fQ0CHtFK6C3kZiarscTp1YO5McHg0C1PKIwCm3aSOf5Ru1gHghM
         iWsvfUg9AD9+AsTD9xtPmdF4jMTk0ThGqCIW9D1jpkJSwTsaHjQ9XPj5oLggqVmNbk7Q
         tyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415522; x=1772020322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDRjBFND8147IxSirZUuWVkN3Wo71mzLZsgaNY+6T1o=;
        b=BW1I82s1Dk3XfVGafk3Y96pj8+LucqN9HWUKWC/Ks4fvXyuwZipcQn05HQTGPDy0ll
         sT+UW6P0HTkVpzsLz67GKI6RTFLVaZMefVUmYhs8KdizwtdIpw17RE9hYoe+VnxTIheQ
         aNTP9cKrdGQXsod5PboL1iKsl1cvFdT+easWZEcPEhTP8RHk66pXDYYmpoob+YTIvPa7
         6BBRl8GoH3sEw4OmjkN+LKZQuBiWB0TyFPxD+dI+dVbgyR/VomoRAHHmwneBAHxxSSCZ
         2JV0B00nRM5vOTe6uyeANJmnCCr4NuwOHvGtuAyl2ARZF4T0B64iadpFARmZlfzRM2j2
         Y3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVw8YDy4A4rU/b20FM4ASm0Vi3mr9E8MMAcf8wVnBM7Tef/SwhODTFTNS8/zBlP3dDQLUuIo23jnOxa6ozwiqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6fZMj66s+6cezesqntOERena/PTypXkOFb2DF/imntVZ7eWl
	08spoOjU6GSX3npLRm+45ncW+XcJvPc3Wp8EYQ+JXtIM3DYTUEm/ZGagwXuMAO4GPKOor1h+6Bg
	A0dIffzT0CU3HkyM2/DTQ0Mh/I2EZZjqcnxcTzIkMEf/atTPryQwKCvtX9cwNMg/P+poWmy4=
X-Gm-Gg: AZuq6aLb/QFE7/uI6gG4K0JLYmfW6BXekEku98UTaBwdZU/vdaCXtCLcQ5N73f4jbzq
	k1EeGMTlZBEQI+W87wXrYwlYW06mdBKFCpPlBNlQYw9nAgmuaxL2yOexJVZxI57Q3rseLURnYHC
	v0D1y6ezO3A28XDqpK9yU3aFm51P8a7xT0iJufZJ4vKN8lZr83egIF6FEkEzSfrpfgTusptARHD
	FVfZfJqPX0FwkFc7n6im+ZuUI6dMaL4sJFd/c1pH6yyZuQKFzcOtcIclI37X+y1WC3e67Dx14Ja
	Ljq/CXGJUmZH5dogqqr36sj3fKPvdaGbdDg9eJw1bpUWzsB90nqtters0VKApYl+9+6nxh4jI1+
	zGP5wXMa38WOqQtm7aFVzD+uf8trqX9a01ieK3rSlV3sttVYn
X-Received: by 2002:a17:903:2d1:b0:2ab:2733:bc25 with SMTP id d9443c01a7336-2ab505529cfmr155247405ad.14.1771415521926;
        Wed, 18 Feb 2026 03:52:01 -0800 (PST)
X-Received: by 2002:a17:903:2d1:b0:2ab:2733:bc25 with SMTP id d9443c01a7336-2ab505529cfmr155247075ad.14.1771415521441;
        Wed, 18 Feb 2026 03:52:01 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa5cbsm168300505ad.9.2026.02.18.03.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 03:52:01 -0800 (PST)
Message-ID: <289a2530-89c3-487f-abbb-f20d419c7622@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 17:21:55 +0530
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
X-Proofpoint-GUID: Fu6qlqzGZd69DbBtgvFf_DeYEbOMmA2g
X-Authority-Analysis: v=2.4 cv=R7oO2NRX c=1 sm=1 tr=0 ts=6995a7e3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=IBWEejItevxuk87JBWgA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEwNCBTYWx0ZWRfX1/BLBvmTBhQJ
 NbB/OKA2RHl7fbvD2pMoFbWCJo/6TiTNsuQsLMyP9TgOTQSr9WRE2J3XAV1iW3YbQCiS0K2qZGT
 f+i99Tu76zDcVjFaYON570eELg4o5CtuG4SVg1zT+AK1XbECgOb2wrYQVCY/95ZgkcSuX/iyTdi
 CPAR2mdWYMlKtQmxTSixEL+a1jXU2E74GaUxTdzy/P+XUZE4a3qwNjbSEsxFJ8VbHwBcT+8+Quz
 irhQLjNhLiXsKfxXN0SLqqNsrJQ45+kOPZH8+6UumV6GJFL91+bwJKihkPN1sWwzPYhjQS6uJzz
 00DO3RK6wsZUEZuajVn2omevojJjEN72kjyfMRn7pVVoIq/puIplKNjpPvXMMZok1XUvt80T/lA
 XIIX8w3Lt5yIsmcTJz7HOpQ95TgHniKH1UeBt6eTUhOVpkKAO5SU90ANcwj6U5ZtYcnETOi1nca
 QGATyy7R52k2F8g3e5g==
X-Proofpoint-ORIG-GUID: Fu6qlqzGZd69DbBtgvFf_DeYEbOMmA2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180104



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
I've addressed it in patch set 5 of this commit
