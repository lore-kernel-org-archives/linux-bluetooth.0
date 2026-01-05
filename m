Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F443AD24
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582120; cv=none; b=rfCW8fBgsCJCVGAshlko0vtHcwfbI3yefpo+WvMTOMexOdTrof9MkUToyd09WC1pqyIB7vpI8z9u4AHNruvWlp96ldtmxpg1cAj14fLXRn18NPipt8dvtuZ8DWW/MpZ0fqwtIC2o/uBzoCXWZQT6UmIqHvAb7rwcZA3Z6nuq4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582120; c=relaxed/simple;
	bh=TcVcFAzdK1L7oaPmQITMHsIB2Sl5kqTwn25Do+5cAJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYzi7k/Rq18l5IUcE7N8RmVv2A7jjClXVYaGrFNQq+tNW0Aq5B9m0KFx+m3ssjYMLdTRTKFm2fOOgmJBfJlSnX+jhyhvxfNDBvI1PFCHdKi2+vpstjL32usMJJlzPzEJewc9tPPnaN9FQe542D2JbvNHxlQS4l20GZESEEhKn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFijDMNR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vm2GRN0Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFijDMNR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vm2GRN0Y"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604LfkY13505181
	for <linux-bluetooth@vger.kernel.org>; Mon, 5 Jan 2026 03:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWwuOViYV8FT9T9UVEeIWCWEZ06Ee7nADDhLsdvaexc=; b=JFijDMNRD9d+nmNv
	PimnLMZLmbClJ89NbrbRdrXD+a2FX4flrfKJ8lYhCDJIoVB1D+Tijucp6GRQByXX
	Ip2fIYYZdoVc74pv09fXlwSk+tu8DO11QQRzCTOuG3Q0A64swDD5fE7I/EuJJu88
	7KVLt6pYVM2sM2k9R3iwkYNPEbw+XBct31N0oiHlqzJOzZJpDw3gGBAMAZgObZgE
	L3lfxYQy1XaNA6uXfktjeG3p5QiG/g++8lmAlF3vl57KgQBT2RdY4HDLD3Qh3yWd
	p8dMlSpw5ZPfUuJ+3+OzG45LE+S0cUjeO73lua9PTwXEnUazdoHlKnwBLeTYjOOY
	HRAZIQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet2qu2ym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 03:01:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c0c7e0a8ac1so20293654a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Jan 2026 19:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767582117; x=1768186917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWwuOViYV8FT9T9UVEeIWCWEZ06Ee7nADDhLsdvaexc=;
        b=Vm2GRN0Y2j8jW4nblEtx+2FOoOEuphDVq3mZHjCMHFxi/1RlzTLmkudYb0IHHHTNVP
         AqbMojbmK3LXoV4DPN2fVLaMkopxnnjmiheRs7Kog1gNMu3FGQB0KDv9ATLv8drMn9px
         G/gkqXm55pEFInUgBgu+naWvnLIWPOZ0vEMV1cVLH/0Kjj8kF1a1QLXGlUcJZzQYnEJW
         8Aw/KthSLAj2LJGa8ZroUF89e1SeSTaxv/8VTR/qXQF7jMhHVbaFrEtorA3aPcT7EYKJ
         UFThidk1tQlWCw63Hl+c9SMQ9uxcLgkkT8xeugPLCzNznQXf3ZD4iSbrbFUi4bhYLLhN
         ryTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767582117; x=1768186917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWwuOViYV8FT9T9UVEeIWCWEZ06Ee7nADDhLsdvaexc=;
        b=pgpTf41rjObwt3uzSQiS3BVvYWkBXaDn0+MFmRdobtKohx4kWq2zBNclYR5wLhGIiH
         pfASthlhgGkFn0WhcegxSz5v0NOTZFs36oKtCzU79jrumfjRTzgxIKe/72hbU4FW4zmp
         71LPiE5VJyFDmBriFuQNbCbfzNLk8HA83n4Ju8Cg+8Lzj0AkoYU2d2dxCYEzYkGpaF8t
         BprNnekp3egQ01Qht7D3KCOKokYtSHPfbGO00G1HwAVcqLUMTFQpfm7xmXrPaTwvLqCT
         9jEVxE5L0CcpmA47yGM+tP01ZaKi9jBpViJCym76JLQHssZOel+YgxpVf5WT2/8trElt
         uQgA==
X-Forwarded-Encrypted: i=1; AJvYcCXNhRyyQqBGy6++QXWrDP/eObkbTz6eIZu6lXecMomEEl++yzFRUs72LIM1nK3wl1PQo2jO0YRrCkRgHc4MNQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7nmnt6V+Kkqv7bWxstF++ZNanGSAyn4KcGDbmHkVnOSPjaHE
	YyS6B+DOUUaiK/+X8Apx12fqxIQQbPqfBShWVEpEaX/JUXXVn7wcnq49ufox2pU+Z94RSFhBhjy
	Z/Cb4Yx9osVjj88QdUrFFmfslJ4MiwfzZ3aqesUkmiqGLf0r4/ZCwHUT9HYUARVYatx2+0b0=
X-Gm-Gg: AY/fxX7pyCx1KyRpEMK4k4bGr9AtdOcd4cxgU3LeLj0NWPPMHNZv8CqlTwjdtdwNnKI
	IqK7A4RS5LwGYty6/Ga72N7t42OeGdJUvDdeC7T1hd2CglfXu6UaxEt4SBSzzFJcsAGJcXr2FZX
	nbrC/7x3wKEJFjzLzC/KJl3XC5mzAw5RwHSpyc450VbcFbVtZ2yEnhAhM3z08ea5WakX3i5oiTS
	L1ddIOOyMwViU5J0AgdLC/heaep4KVbuMQB/E+Zt1wA7W6avHIjbWvCX+FWBVpjJBnDUvqnJA3+
	g4po48NqvsxBothd58o4UH47KlpoBSjHgYFZ5ndcAoXu4Y1qLnQkaEy73RVxf4fF37HbTvkE53I
	1o6BIUprgWUp1cjQkKU+Xdj78JODIJ75xwGVaqHG4pBgH08e+lMaSXnxIClnOXDSD
X-Received: by 2002:a05:7022:689:b0:119:e569:f620 with SMTP id a92af1059eb24-121722e13ddmr60048747c88.25.1767582117260;
        Sun, 04 Jan 2026 19:01:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9nh6pp98Os8eGY2VprvQnIN6lP8gpiM/Yw3L+8/zskxFXQ3KdzjQxpZraJglP3LQdtaZeYg==
X-Received: by 2002:a05:7022:689:b0:119:e569:f620 with SMTP id a92af1059eb24-121722e13ddmr60048710c88.25.1767582116587;
        Sun, 04 Jan 2026 19:01:56 -0800 (PST)
Received: from [10.110.40.60] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm174401548c88.0.2026.01.04.19.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 19:01:56 -0800 (PST)
Message-ID: <3a3cd2a6-5372-4a02-a3e4-9d52c7391fb3@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 11:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] Bluetooth: btqca: move WCN7850 workaround to the
 caller
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20251231075817.2611848-1-shuai.zhang@oss.qualcomm.com>
 <20251231075817.2611848-2-shuai.zhang@oss.qualcomm.com>
 <fee7fcb8-06dc-4b94-943c-b261d2c71976@molgen.mpg.de>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <fee7fcb8-06dc-4b94-943c-b261d2c71976@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zSsd7vb0W1rercFuYhw23V-mfyyMwYY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDAyNiBTYWx0ZWRfX5RJnMgIC67/R
 TT8T4eyrk0IxctrQOYrqf45O6A98EVT2EGPwIwOrk1vrTePcFWA51kgm+MCVqIAf2l6DNqrUiw0
 Z9d69dKnJanr8kORsCYqcKLRlBe9epxVwlNy/PasXyFrvRz0bm1ybxt3ogHKjzQFa/rdyRIGLcz
 P1rd/g/rmKOsEobu3Sf010961IU5x/yrjXHK3lxNn+QdPXjCtHpTUr0tdRYKBsc515Fh5f9GZZU
 voPdxYb0Z1y7L1YPrkVko2RpwD06Mtt6VEuJl3mirp6rFNzePZXntOicXQv6wEd1SqV8Ae6SCl4
 SQAMvli0231yj/GOIjHFrY3KZ36zfY4hWoYxDVkKz39PRJvVA9QKglQsAJwZhZYtvlFTEAa34pH
 eDTqyyRPNm8/LiFMGhXMuZeTPR7jaxBfeBNXrgVXz6HAYNlJe6bWxxsgroU6VnBB6Ach/ULPs5x
 yZmpXI4Sw0Zxmez7jsA==
X-Authority-Analysis: v=2.4 cv=RKK+3oi+ c=1 sm=1 tr=0 ts=695b29a6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pRLi8byjjBT-p1ZUwX8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: zSsd7vb0W1rercFuYhw23V-mfyyMwYY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050026

Hi Paul

On 12/31/2025 4:38 PM, Paul Menzel wrote:
> Dear Shuai,
>
>
> Thank you for the patch.
>
> Am 31.12.25 um 13:58 schrieb Shuai Zhang:
>> To code uniformity, move WCN7850 workaround to the caller.
>
> Please elaborate, and detail what WCN7850 workaround.
>

I will update.


>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 41 +++++++++++++++++++--------------------
>>   1 file changed, 20 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 7c958d606..b4c0a018d 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -581,28 +581,11 @@ static int qca_download_firmware(struct hci_dev 
>> *hdev,
>>         ret = request_firmware(&fw, config->fwname, &hdev->dev);
>>       if (ret) {
>> -        /* For WCN6750, if mbn file is not present then check for
>> -         * tlv file.
>> -         */
>> -        if (soc_type == QCA_WCN6750 && config->type == 
>> ELF_TYPE_PATCH) {
>
> The `config->type == ELF_TYPE_PATCH` wasn’t moved, and it’s not 
> visible from the diff, why. Please explain in the commit message.


If it is WCN7850, config.type is already set to ELF_TYPE_PATCH when 
downloading the rampatch file.

Therefore, if (config.type == ELF_TYPE_PATCH) will always evaluate to true.


>
>> -            bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
>> -                   config->fwname, ret);
>> -            config->type = TLV_TYPE_PATCH;
>> -            snprintf(config->fwname, sizeof(config->fwname),
>> -                 "qca/msbtfw%02x.tlv", rom_ver);
>> -            bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
>> -            ret = request_firmware(&fw, config->fwname, &hdev->dev);
>> -            if (ret) {
>> -                bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> -                       config->fwname, ret);
>> -                return ret;
>> -            }
>> -        }
>>           /* If the board-specific file is missing, try loading the 
>> default
>>            * one, unless that was attempted already.
>>            */
>> -        else if (config->type == TLV_TYPE_NVM &&
>> -             qca_get_alt_nvm_file(config->fwname, 
>> sizeof(config->fwname))) {
>> +        if (config->type == TLV_TYPE_NVM &&
>> +            qca_get_alt_nvm_file(config->fwname, 
>> sizeof(config->fwname))) {
>>               bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
>>               ret = request_firmware(&fw, config->fwname, &hdev->dev);
>>               if (ret) {
>> @@ -862,8 +845,24 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>         err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>       if (err < 0) {
>> -        bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>> -        return err;
>> +        /* For WCN6750, if mbn file is not present then check for
>> +         * tlv file.
>> +         */
>> +        if (soc_type == QCA_WCN6750) {
>> +            bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
>> +                   config.fwname, err);
>> +            config.type = TLV_TYPE_PATCH;
>> +            snprintf(config.fwname, sizeof(config.fwname),
>> +                 "qca/msbtfw%02x.tlv", rom_ver);
>> +            bt_dev_info(hdev, "QCA Downloading %s", config.fwname);
>> +            err = qca_download_firmware(hdev, &config, soc_type, 
>> rom_ver);
>> +        }
>> +
>> +        if (err) {
>> +            bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> +                   config.fwname, err);
>> +            return err;
>> +        }
>>       }
>>         /* Give the controller some time to get ready to receive the 
>> NVM */
>
>
> Kind regards,
>
> Paul

Kind regards,

Shuai

>
