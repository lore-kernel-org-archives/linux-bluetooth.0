Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE230DD1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414764; cv=none; b=VcxelcCpoN6p9KSZlls7FASfGHUGoLNfXqe249fhe7Zh4AnOxMZeLAameMXdd6cd7K/ytohnKvR2sQhvSiFQHC2LhMmquQpAnlktvEJxl2DWk/yGHpGE/IK2OT/v6XhPyOiNk5Wr/3CIOMGS06mr8VQFGQWi2NHZLT0PxH4pU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414764; c=relaxed/simple;
	bh=FMdxVUC0R0jadThg3kkIYRMnfauWR9cEQM0ddy7MYIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx6mduVcaHJMEMjwTLowBJQfesxoXNnoJ1h3gYfrhhwILjsQCuPs9XrzQOuZysEP5CR0gUcldAJ0C6QU06HE77W70ez8xZoVh4syjSiPnXtMZ/TSqQu3g0YUSbcaKuE3P8yIOutiJOCmLCaJGNTQluSe2CXqnQPUrvF0axvIq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIpcpKtR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOMHMakg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIpcpKtR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOMHMakg"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HN86fP4060748
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ppdqtJT3CiJXkezhUY3eB7UumNbDs0BXpqi0rJyn9YM=; b=gIpcpKtRlocQGhfB
	8cNWhZ3i6Vdemt5LbFRVGiyKuvWz5ZuNlouqqozJK1nK8iIBB/Zm1Wu5FVi4vRSy
	Kw9cjBtGzni8YLJ09qBNFqnpVgxkbSf7uSeE5XTexSNoNYgfuQ7t2r0tjl1XzeIM
	/rA85ITlK6JZgTmQOzVy1KX1P+/kKrcHFxlqnGbxQbiSM4TE4E4szS/rDrEdqWiH
	w6c7ODeXrx+kkqlIkmPDDQwbdcUsV0BiUyZ+A6VSkR9SYRF+vOvc9CveBFHpkCwk
	oJABwdcYkZ2OepJh043liyOT6sv0x8Q5GXGOIme4+9bVFKVJdXyiPcopE08ngVkW
	Q6qo8A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd1qx1kpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:39:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e18ade2c2so3734669a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771414761; x=1772019561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppdqtJT3CiJXkezhUY3eB7UumNbDs0BXpqi0rJyn9YM=;
        b=TOMHMakg7i+rPwaVOltwJr+Sarhv1JGRudROURfoXR8sJqlXni/BqaoMrVEx0zP/Me
         82xE/znzzqpvwQQL3SLiT4inPkE+uq+hvy0wV5E/6oVn0jGeRKY1iOMpXJoI8mCrfOT0
         pDcDfMIXlxYiY0NUp5X0FyTpMYRMtdhQF5IpDcZo92HIVE5O7fr5vC/VKGczAVOrBKxl
         aRqbSziNsMxI6gSBOZnUg+MQMiuX8ZO76FVkrrckzvqcdrg2PbTj0wyNzh5MU3BhUqwk
         Wo9txClsluxiog1I76OfjCDzIWnB/4havpWy0azBO9UFOBkzB1FGsup8e8oHXndQDQzy
         0K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771414761; x=1772019561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppdqtJT3CiJXkezhUY3eB7UumNbDs0BXpqi0rJyn9YM=;
        b=PAYPosaq+BsXxUEEygDFyXP4tZXJJ0XHsCGJcqWhGEN6/s8+k/F5tQ1Jx7xxUjMA+q
         VE6IjmvwzHY74/6Nn6G9kNwjJSj4bKhKYgs/y+E+3DHxCONyj+H0Qekrysyslvywdv8M
         9h3KR7kAeaOfJXJN/i8opNlaFM4oAg+42cmoTTOBUdDbS5SfVUzzBxta6wt5FnFEfU01
         mK5GnlR3LmxmHUrahrYYr4+AZAbSt2YyJIx8b9JL8KDfoSh6TFyh9bJyWnyn7l5QwZYk
         1vkiDGKbs2Rbhdeq4vp5TyhLFrd9UTs5kymZjVJy8BEb4jB5PYGJLSWzPGo/y4dlfkFs
         CQIw==
X-Forwarded-Encrypted: i=1; AJvYcCWrlG8WSi+LxKgEkqeLsVtW+TpJ4OcJ07vcODJhe5zFcDSlpJH7ClCFMp787PJQsmx0oNO5TUdpELsktHxbcPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWyhTkiSX0KHw0FXx+RzgdPU0pqZdAMAOzdasFXBUUVQCBdlR
	lg5uey/flUzJv5G04fydK7dwygwBBmjB2cqpEY5VLhoJeImSA+QuGnNmCANqktuUfMRNQRUigFG
	M3qM1vtlK3Gw6YpFZ8CefHBiPuqxc7pBmzrZiXfystJ3+TrAHUfaPT211jvIF1Lq/ukwZvNo=
X-Gm-Gg: AZuq6aI8BzCFrY7+D5MO4N2ts4f5hqVVZhhPuzUsAOGLuIVUeuwcLyO0w8kUCuwI5+r
	TMfa26qCJ7uZ/0SP9LxkoblVKwS5Cl5J9nwbihYLXBqSNDpjwsCprzOng4WQro2U6nudE+3bzkZ
	rnz/AcR7mebfxmbrCiM2m8/iYyDNOgYJaInkSJ1mQTQo/pIFkdzRlmncrPB5b3V3ii62ATAlROB
	Rnqe5b1eIzw88ffdHo9wRbhYNaUzprRTN+5JVU3kIFb884QQkObt++XmZ0B2P7f9bh2x74OjIoB
	wXsbPc6D4J4kCmrG3WrUp+7S+mD9gu3ieFR0thcoxvA+PCVrUn+0e2wKJsgt4zxxqeHUjWzMday
	ysoRmTA0Y5qswpfEg43hFZMMzCWKISesmG0Ze1Xv6yEzjiCsi
X-Received: by 2002:a05:6a00:368f:b0:823:7c4:d81d with SMTP id d2e1a72fcca58-825274749bfmr1844222b3a.6.1771414761102;
        Wed, 18 Feb 2026 03:39:21 -0800 (PST)
X-Received: by 2002:a05:6a00:368f:b0:823:7c4:d81d with SMTP id d2e1a72fcca58-825274749bfmr1844197b3a.6.1771414760601;
        Wed, 18 Feb 2026 03:39:20 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb25e9sm16895776b3a.56.2026.02.18.03.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 03:39:20 -0800 (PST)
Message-ID: <0637e27c-cadd-45e7-9c43-cc510c431f2d@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 17:09:14 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
 <cdbef8d2-df96-4a41-98eb-3acc747a0aaf@oss.qualcomm.com>
 <3v3iz5cxsbaoevcfkk7itutdepfuagxoemixgfhewdevmju2ut@rcg3zuyg4gzn>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <3v3iz5cxsbaoevcfkk7itutdepfuagxoemixgfhewdevmju2ut@rcg3zuyg4gzn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ekdyxg_SFawheUa_940MmRzmv9OrffZ4
X-Authority-Analysis: v=2.4 cv=R7oO2NRX c=1 sm=1 tr=0 ts=6995a4ea cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=ZkFF6JlifP4NxvfhLXQA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEwMyBTYWx0ZWRfXwC3RFDN0ejzX
 gGMjsULaa9YziU3ybSpdGhuLpiA7rXGDjGXHH3DispCDNl6eWlm5/7GbE2ynjJhdckeEG91OWBP
 m85/2FNZULlJVhBvHQTUxG8cJnm7DXFRHPV8rmOqB3DTvklvdFwiBC8jZohuuRS9IZHtSbXLleO
 xaWn+UWM+zBHhs4dBh1TPRtiEDlGxmnJQTBnwe4m1JZ5ZkKOHhdaqwtuKraNgizX5dqHO3e2tXO
 ghTNAY44Q+eubKtrjVwcPl4E7E4kUnSIAjF3jHeUDHSTQfgKWehy55zGWSUPbyCGDRB1hzYJV3R
 i5ELFOFLLMHxIWKJdK2jQKe4vaUzSlgzGkcEa0WvLtEKjvzNY5xXEeZUIdcLDmWlqOxhbuEOdxT
 FPbXq/B8KS6gVzmhuL5lcdX5DtsMflhPSDTt8IpzjdTOlmTOwJB26TKm4c2VTgq8XHFOse3gESP
 AReTTEIAFfW9GiIAKYA==
X-Proofpoint-ORIG-GUID: Ekdyxg_SFawheUa_940MmRzmv9OrffZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180103



On 2/17/2026 6:31 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 06:21:19PM +0530, Vivek Sahu wrote:
>>
>>
>> On 2/17/2026 1:23 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Feb 17, 2026 at 01:17:29PM +0530, Vivek Sahu wrote:
>>>>>> +		case QCA_QCC2072:
>>>>>> +			snprintf(config.fwname, sizeof(config.fwname),
>>>>>> +				 "qca/ornnv%02x.bin", rom_ver);
>>>>>> +			break;
>>>>>>     		case QCA_WCN3950:
>>>>>>     			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
>>>>>>     				variant = "t";
>>>>>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>>>>>> index 8f3c1b1c77b3..a175ac31e7b2 100644
>>>>>> --- a/drivers/bluetooth/btqca.h
>>>>>> +++ b/drivers/bluetooth/btqca.h
>>>>>> @@ -158,6 +158,7 @@ enum qca_btsoc_type {
>>>>>>     	QCA_WCN6750,
>>>>>>     	QCA_WCN6855,
>>>>>>     	QCA_WCN7850,
>>>>>> +	QCA_QCC2072,
>>>>>
>>>>> Why not keep it sorted?
>>>>>
>>>> As mentioned in the cover letter "qca_btsoc_type" enum in
>>>> drivers/bluetooth/btqca.h contains all the soc type which need to be enabled
>>>> for BT enablement on the target device. There are few places where logic of
>>>> framing packets transferring between SoC  and Host depends on the which
>>>> generation of the chip it is, refer api "qca_read_soc_version". So It is not
>>>> sorted in btqca.h file.
>>>
>>> Neither in previous patch comments nor here you respond to actual
>>> comment. You just write something completely irrelevant.
>>>
>>> I don't think any of this should be considered if you are not
>>> responding to actual comments.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> There is high impact on the existing design if i make this enum sorted. We
> 
> What kind of "high impact"?
> 
We identified a better way of handling it. I'll move it to the correct 
place.
>> are considering your comments regarding sorting for next commit not for this
>> commit. Can we have approval for this commit if all other changes looks
>> fine.
> 
> 
> No.
> 

