Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F56311C05
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119469; cv=none; b=FfDoX3ZNMoSHVN6lIwf/BOLZc3BT0SdYUAp3YZ87UzxfxPm8YSHTNkSx8CykONGnlmYyGmMlDe8CKfBebIt987TgIDo6WVZ6qf9W028wlPaN3D8h8bNKirodjQWHWyv7SZpX//eoZJOjpIdEhxBKYhX8qxsijWFrtWLPuBrJAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119469; c=relaxed/simple;
	bh=4jaLqD3KZ7VuNrlZ6Q6LZMSVU3w1+1xihGdTjga8JjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4QeFJjQBBytLqinDL7Bsj9CEfv1eM7RGiiOf+JXARKLAhfQM9dCbQHnHxpRgN/G/ILLTDkYJRKRMeeNBnC9FYOoS6FXqfCKTzQGIl+zG7PiFTC3iHb0leLXBt11hRYBfmgXEXMWNCY9o5dpyrpEslwzoR8r7Gi4vPHNlXKXNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+llvOnO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dU6ah67w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+llvOnO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dU6ah67w"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8JCJY1590811
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 11:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	50JEvdflBeKatW9OY+cR1OJ8SgpTllW/vP2IZkIBCk8=; b=n+llvOnOw1qaao6q
	QcTfxCQ1uNvCabsnHPbv2Nv0EmN3d1ynBcBP/gMSqsLUxEsT93uKO7wePXuRWFsY
	bGRzsw3fAwnTFuir45oQ8DgJToVm/yuPCYUQjUvNTbfOymjtVu4PkwiUsNfffA1I
	YCQ42UvXklpURm5MMfvkm00Uj44NZyemAOcq3S2W5H7laReRiPSNK+9L7d5BxKhO
	W3DK6qKWT5Am1hCU2zBKv0417c62IevssNUa7g7ZIfPzoMj3KU87ZZufYSsJAAyK
	uoxPKzYQ9+ZoufKktOnXLFACPbaTUKk2DZaquISO89WSJiOvT9VB8FXXveyL4pJy
	PpgH8Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9ft04s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 11:24:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b95d06db747so2380994a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 03:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763119464; x=1763724264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50JEvdflBeKatW9OY+cR1OJ8SgpTllW/vP2IZkIBCk8=;
        b=dU6ah67wsyqijI0TXiSi6fB2R8aEXRuVVWBXKq/2j4ZB0Db1QZPeK4GPSzgQh3od5f
         0tr/w3/bgAfszZLELSE0wVvR/s+EzG/Gh+mfdP18uhTjCjaJ98UwrhHV9XBpggyIKcgd
         ILIcg5bUUs2UGEAlHkn5wsYyj4VBqQqtP1Yp3vlIOBvvvGO6JFtRLk1wcyJUWqasOJG8
         kRVnEnJHFRPQAhTo86u7BQwM/KxpjWGBB+W4ohMjvbCdZESh0szvJkYF95+kMZAkZxps
         ugcgmySPL3LCw3a75gA0qhLf28uM7qr1ABNoezc5gk+09w57WjzssmsrgDMSYpYiSfPx
         cNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763119464; x=1763724264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50JEvdflBeKatW9OY+cR1OJ8SgpTllW/vP2IZkIBCk8=;
        b=igstDopRHGL0c/49eBL6HhU1ra6T4eceX12zd2dpVnb4Hn1LtUrP8IH6XcDdQYiaY4
         S0LyUV71LQGxMlKUnslq5oMiew6Y4XDM+uabVBVsSBX3rws731meAxZG80kmx6Lu1r9B
         aWIpo4TTG1wYneIC5iLN4BdpcpFziOQr8a8i+q3BoA6+EFgLQKNDoWGdHgO4YZraLER/
         kdJ2WTfxH/NJTIoUlGWlkQ/D4gZ49ngNthDQP/nPFYrpo9gLp6iT0a3jG7/bLpngxrNv
         JqII3fr4I6dWYSBTIhsMPFJB3R0nfrVLkf9fg+1XQ+JbsMxUHOfBZEST8gprh6Phc6w5
         irNw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GK5qlSI2GV3LCAnsNAi4UzC/JFDy/pekb3b/4+jgd6u9pMUp+TeqdWvfuwpDrEGpLD9Ne4cv6eGkeSx0ygI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQ2pJSWe57KDnYeqrIKU0G1LnNz5oFx+z98QBTN/Y1QU1HIMH
	TNxNrQejhuRVROjiFkjq32eIAvN31dG9Q15T1GNMzKVza54flKiJGloKtP8c2g69EPW7P8qziQb
	NymrG/a0MC4ZFUYys41C0Sl8Nmt3xPaSJJdiqcocEC5oMqjiZ74FHjXwMBXDGEYmAnyBArV8=
X-Gm-Gg: ASbGnct8Yx46X6mVI/ZzEpOHxrnFjoVngvBlau//+HSzkktBIBZCK5Ye0CiXV3zpf3S
	AyPu4KN6Azz1lhZWhesRoUiT5Zgpcj8ewrcjreANTloCQeXHOopVGk0mSb9QbCQqOktX8BnAoFn
	ds7y25LR4DK6CnVseREhEdBEQJujFyUoxIfDCdVIqmuIKa5z/eTmsTtrjbA8ZhiaOnP5RYvb2Nq
	c/DyuF6+XxFoIc9fGvfFK4iqt3k+QKwEAYncLYKADImpvErmHGoro+D/ukUo3pXbvMA2u7KkASM
	tT0jerBKcfsq3yzWrsuM/2MbZeWCzFipTrYkcZS1CVv9J+QGxzvVCPkRPwAVsXyoVeUBgaKrT62
	q6/l8/1/xkdRwwc+k8vRWaNfbkBj8//TgwS3VIOebRo21Xy6D3FxcIIQ=
X-Received: by 2002:a05:7022:f68a:b0:119:e569:f84f with SMTP id a92af1059eb24-11b033ae894mr1093202c88.6.1763119464415;
        Fri, 14 Nov 2025 03:24:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER/KNwHh+JkP9cIAvCS8U1orv/bAdp2HgRSNhoWYtU/+3J4fEc3CRBuZMRvHx0R9loqh4jRg==
X-Received: by 2002:a05:7022:f68a:b0:119:e569:f84f with SMTP id a92af1059eb24-11b033ae894mr1093186c88.6.1763119463426;
        Fri, 14 Nov 2025 03:24:23 -0800 (PST)
Received: from [10.110.115.10] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885c0sm9652707c88.3.2025.11.14.03.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 03:24:22 -0800 (PST)
Message-ID: <eb280667-f2bc-443a-baac-4f48d5acfc1d@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 19:24:18 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20251114081751.3940541-1-shuai.zhang@oss.qualcomm.com>
 <20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com>
 <967d99e5-7cc1-4f8c-8a1b-21b1bd096cb9@molgen.mpg.de>
 <32c952e1-39c0-421b-ad77-26603907d444@oss.qualcomm.com>
 <8ffee44c-0e44-4137-bf9e-11e7d8b168ab@molgen.mpg.de>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <8ffee44c-0e44-4137-bf9e-11e7d8b168ab@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SdD6t/Ru c=1 sm=1 tr=0 ts=69171169 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=BUV9c_y4XzYhrbKXCpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: B1EO2OSsPt_Xq_WjK8q_sVBN-_XgN2gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5MCBTYWx0ZWRfX20sulH89em2i
 LBk3Ky6HvBeNBziR6CpwB/JO4x78Y78QztgBDo+yF6shyQ3OgZkWvC0LAPlAd6MHHx0gJEdetnR
 QNWEpbTpa3w2Wd3K88muYTg0vL4hvVFjpx4czB3vTglbBN2g4A6EplxvqPfghj4F+8Pl+rRlr0d
 3AMJbNRXgxgIB8fvTGCJ0+eKa5hctFSG3sht/k0Evuu2BRvw1V8DiedMCKPZv6rZxaWiqAYoFfr
 ecSQbrqXmXh4Oy2GmvkAfzZWS94fNWSRmyfEx/rOnjdsmegKueh9u2kumZ1pu7Fi9Z8XRFuUBi8
 lxFq6alxpf2G1bFIZ8F8bx5JahF8wjqj3MrYMN+twJdFdN5AxOK7+tlMnN7sXp9WMfXuDn8/5Iv
 QB1SBPR/reB3kthBmIBCRNWkO1v54A==
X-Proofpoint-ORIG-GUID: B1EO2OSsPt_Xq_WjK8q_sVBN-_XgN2gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140090

Dear Paul

On 11/14/2025 6:45 PM, Paul Menzel wrote:
> Dear Shuai,
>
>
> Am 14.11.25 um 11:41 schrieb Shuai Zhang:
>
>> On 11/14/2025 6:04 PM, Paul Menzel wrote:
>
>>> Am 14.11.25 um 09:17 schrieb Shuai Zhang:
>>>> The prefix "wcn" corresponds to the WCN685x chip, while entries 
>>>> without
>>>> the "wcn" prefix correspond to the QCA2066 chip. There are some 
>>>> feature
>>>> differences between the two.
>>>>
>>>> However, due to historical reasons, WCN685x chip has been using 
>>>> firmware
>>>> without the "wcn" prefix. The mapping between the chip and its
>>>> corresponding firmware has now been corrected.
>>>
>>> Present tense: … is now corrected.
>>>
>>> Maybe give one example of the firmware file.
>>>
>>> How did you test this? Maybe paste some log lines before and after?
>>>
>> Should I put the test log results directly in the commit?
>
> Without knowing how they look, I cannot say for sure, but yes, I would 
> add as much as possible to the commit message.
>
Sure, I’ll update.

>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 30209aeff75f ("Bluetooth: qca: Expand firmware-name to load 
>>>> specific rampatch")
>>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>>> ---
>>>>   drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>>> index 7c958d606..8e0004ef7 100644
>>>> --- a/drivers/bluetooth/btqca.c
>>>> +++ b/drivers/bluetooth/btqca.c
>>>> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, 
>>>> uint8_t baudrate,
>>>>                    "qca/msbtfw%02x.mbn", rom_ver);
>>>>               break;
>>>>           case QCA_WCN6855:
>>>> +            /* Due to historical reasons, WCN685x chip has been 
>>>> using firmware
>>>> +             * without the "wcn" prefix. The mapping between the 
>>>> chip and its
>>>> +             * corresponding firmware has now been corrected.
>>>> +             */
>>>>               snprintf(config.fwname, sizeof(config.fwname),
>>>> -                 "qca/hpbtfw%02x.tlv", rom_ver);
>>>> +                 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>>>>               break;
>>>>           case QCA_WCN7850:
>>>>               snprintf(config.fwname, sizeof(config.fwname),
>>>> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, 
>>>> uint8_t baudrate,
>>>>       }
>>>>         err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>>> +
>>>> +    if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
>>>> +        snprintf(config.fwname, sizeof(config.fwname),
>>>> +             "qca/hpbtfw%02x.tlv", rom_ver);
>>>> +        err = qca_download_firmware(hdev, &config, soc_type, 
>>>> rom_ver);
>>>> +    }
>>>> +
>>>>       if (err < 0) {
>>>>           bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>>>>           return err;
>>>> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, 
>>>> uint8_t baudrate,
>>>>           case QCA_WCN6855:
>>>>               qca_read_fw_board_id(hdev, &boardid);
>>>>               qca_get_nvm_name_by_board(config.fwname, 
>>>> sizeof(config.fwname),
>>>> -                          "hpnv", soc_type, ver, rom_ver, boardid);
>>>> +                          "wcnhpnv", soc_type, ver, rom_ver, 
>>>> boardid);
>>>>               break;
>>>>           case QCA_WCN7850:
>>>>               qca_get_nvm_name_by_board(config.fwname, 
>>>> sizeof(config.fwname),
>>>> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, 
>>>> uint8_t baudrate,
>>>>       }
>>>>         err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>>> +
>>>> +    if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
>>>> +        qca_get_nvm_name_by_board(config.fwname, 
>>>> sizeof(config.fwname),
>>>> +                      "hpnv", soc_type, ver, rom_ver, boardid);
>>>> +        err = qca_download_firmware(hdev, &config, soc_type, 
>>>> rom_ver);
>>>> +    }
>>>> +
>>>>       if (err < 0) {
>>>>           bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>>>>           return err;
>>>
>>> The diff logs good.
>>>
>>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

Kind regards,

Shuai


