Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D527B347
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770431; cv=none; b=VtbSc8TlHQ8uTW04eylx9bN4hBS+Iqs9LEgrABVBRKcro3UGndranJV1sGV68Dp2fYL/5XVsJTxIPtDkIcYCBbLFY4bRKSrI/rhDsj6cqU1NwyAm+doCEuJ+BCI+S1i7vc7OBfwRxaw2t3FkrzjwTAQ+ALoPA6eqxWyR2kPJnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770431; c=relaxed/simple;
	bh=hn3kVdb4aa9sWrqJzNBczdYj2m7KfDYePW/W0GkFT+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=vFLaCG7Ka1Ef9VfwVaHP3QzMm9hIWcgIIu+rgIREOPgelxgHdPnoZ/QPQtC8/mnSVaBFmbkaVmo6D2PQl7bBA+scoazo/1VllxnLNZBRLr2EBAX0xjfg2qcf5w4p+jci3gedD0MrRt/TMYLhocEKQS8uVQ1KVwHItv9BPEqNncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cV6ye+US; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S7u78Vc5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cV6ye+US";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S7u78Vc5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6070qXWi1979567
	for <linux-bluetooth@vger.kernel.org>; Wed, 7 Jan 2026 07:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I5rtVm8kNFSFhoT2yKf6mXo3wnmnNY7xaHa+NsjBgro=; b=cV6ye+USs5P5wt1n
	k6ys4SVj7O8Aajl7GmFu2o5gdDl0dgVeNOisVrkiWZnO66i2ac5YG0w7mWm21X/Y
	E5/7EkUEUPPjqoUIs10tfcHVgM5kuuJFoygriBJZ9DMn1k9zFFJKUS34sna5IX7c
	Rwf7TsuxovPqI8sSgsYZSOS1bWq2T8dfl7WPyU56z9T1bU7D/qsS0p0Yp71RH5k1
	gL8qEe1rIAfqZMEUA9Cb3entCGBsS7I8+wyPx2nO5kXfq1tkBKJUYD3YnGjl6r5E
	nFMD1GmCMsGcGNupdC3bk14edWQ0Alhjz09YcL6Y9xuO6O2QQBccVZOsR/SF5aRl
	ii8bWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhdavh1vp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 07:20:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso4235023a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 23:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767770426; x=1768375226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5rtVm8kNFSFhoT2yKf6mXo3wnmnNY7xaHa+NsjBgro=;
        b=S7u78Vc5HNKt6kc0T/k+DE2fKWj/1WnGiSl8P06T/RWxIGfrMaDaeHFvmIGHGARUfr
         D7VbV/xNYg2pT4rxrIlo6ifNJgKvVJ+uqOmvr56n340+RarbQu9OmZfazX8H0NggjQCR
         kvu3jT/m9bwoNXod+yATeC+yee0VuucFC83bAXJQOo51iZv2ADOaeWjN75cZQ4uRVPhn
         PtNFmfmxkYN9X66E+Co2xnszX1t3w8Msl8AtC4h1hZ59urkWO8PnjfelFki/smazmkTi
         JamrNfrwiEyrvv4T4jO0CeCsvB5qmlOO41iIJkMl9dTx8VDx3zhheogv5JOuG8MTiybT
         2GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770426; x=1768375226;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5rtVm8kNFSFhoT2yKf6mXo3wnmnNY7xaHa+NsjBgro=;
        b=v+5lwvu0qDU1arKqPMmEZjcJ6ZaQLB2LxfgjVKqZhPbzfZK95kcK8gysCZudvrWAnP
         ulukVxOW3NsnKV0xc14ccRKgmN49KbSM1XNTXgWK98R+kKlSfhm4sAsST95rbpgf3Uu7
         E+ZuAMTtEgJNy3FwaG5cDySEqLghJyW0YlAwnqWH1oDTFhuE4KghUAA/TZ3zIcuV1ASq
         iKEKT9+4aoj8Q+7pCL5H8mwuomDtpI26CAQ+YvzNkOctA3UzZYo3fR8lsiDqHjkAnQkn
         jsk5GiySy8huuMJD8wu830S5CVQdsXE1ZtbSFf4OIRA+LSvloCLGDwBJf1IETQaNaOEH
         LrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2o49lQF3wJnu3/povnBnyJA+2DPM6EiBJB4ZQdr+4plUhJVxbGsEAyL0dIV8Z3Isb8SZxeNh9i/SCGdXagXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgcbk1qGQvF9LCSbNxPysJG6oi5rtq1HpAo2/RVKYS7d6qBiWf
	WZshXp6IWmEwfhsdnaHcnS1TrOktGMSQ1TguU8NE5o4aKWOxd+jJE6E3EQdV1Qwy4+wRHJ2BPVW
	ik9HEYKvc0eg5rsvudMYUaASckiqRbLLa7DzWrtUpvFy4syXZia50gNVSnF137D1Yn/IOhFY=
X-Gm-Gg: AY/fxX7HOt6ndyqJg0FvvIZXgcg7gw9JSymyzTHTewFELE1vENhGIruv9kIIGv9Tyvg
	idTjl5msRJycRVNlGWPSDtYyeTDXXOXWZkZPrNWmHkw9tk+4CgPT5Yn3ag5v74OHD2mycPJVU8m
	kU3nn16o+h3ZAm7TAIkgbyqREu+0uqQOR/7bXfVo+/uho9sdvOILlSwI/wepHJ4KqGpUEqIUnVT
	x+B8GEyz8EMr0MgFzwWjlR9ZARL65S77eN6ONM3q7vEe9/cihKZjM1Mgz7ru5sU4J5WReoruUGK
	foBrQPqUMIAReHeEboa4UPyhhrG9ado7tK3e1FCkEB3Go81VcfRVlax181AgEH9bM2sHD2NvKEh
	cdu61dQrx7F1Gt0jRKEa+Ldjcwcqqbcyk0Lvl
X-Received: by 2002:a17:90b:2692:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-34f68c30794mr1329895a91.2.1767770425993;
        Tue, 06 Jan 2026 23:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG16DMkcL/CSNKiRMdoKO6+UgbIG597U/d9qnrM/4cda0X/Fn3XSdRKRhGTTuG7Yiy/hqTtA==
X-Received: by 2002:a17:90b:2692:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-34f68c30794mr1329869a91.2.1767770425544;
        Tue, 06 Jan 2026 23:20:25 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4118sm4089665a91.7.2026.01.06.23.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 23:20:25 -0800 (PST)
Message-ID: <baa1a047-0866-4e5f-b550-97d43d825c8c@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 12:50:19 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [PATCH 2/2] Bluetooth: hci_qca: QCC2072 enablement
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
 <20251217112850.520572-2-vivesahu@qti.qualcomm.com>
 <xv7zlaoymcuq5kirrgu3thp3trmbdry5maraz34v4tkekinyaf@wgrfk7ukiilk>
 <BY5PR02MB69467A78CA2F2929B6618343F186A@BY5PR02MB6946.namprd02.prod.outlook.com>
Content-Language: en-US
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Rocky Liao (QUIC)" <quic_rjliao@quicinc.com>,
        "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_janathot@quicinc.com
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <BY5PR02MB69467A78CA2F2929B6618343F186A@BY5PR02MB6946.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA1OCBTYWx0ZWRfX7EDsEs2T27S7
 Eo06shVmsALtbZ92HQzfgjk7mzD7EZmPTq88X6xW+N6f4PqDC7mOu7lLSDFi8BAfOpegN/sJWqd
 RYooLaWWthMyDodRbkXGmyCJgypl8B0RwvFvTLFg0r67b3yvUw/0YCbYOzMo+OM2ItG4K4uwvWl
 gfomMN5TY9e59LyedT8UTvXmuT/pOInt0CZaVw81YCw3MUqqj0mOVPRHQc6AunBu6ouxICDN5bW
 QZ0du+NvQCrYlQDpz5AGGcWIAltbJgLbCTqM4OVo78SLEl3qPL8Sse6q+7ditpgY0wf7nECLBuy
 hn5eWD/VD7f75bpuz4boKEF2EiViApv2/PUUYeVl6icsvabW2GXAw28emNl5zxyP5ejp+20080v
 2bTQH7HNk5NVr6u6XvoQmboQ+iUQO2S3hQ+JlUNtuGesePYUNElZyg4NmULP3TMaj27fjGrNzx2
 fleYRWTSXVaAtbu+zDQ==
X-Proofpoint-ORIG-GUID: 21dGoD-03fRCIjnIlHGRxvb5mJk0bgzK
X-Authority-Analysis: v=2.4 cv=comWUl4i c=1 sm=1 tr=0 ts=695e093b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=-uHN8is5J-lzmrAJaG4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 21dGoD-03fRCIjnIlHGRxvb5mJk0bgzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070058

> From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Sent: 17 December 2025 19:59
> To: Vivek Sahu <vivesahu@qti.qualcomm.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz <luiz.dentz@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Bartosz Golaszewski <brgl@bgdev.pl>; Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Rocky Liao (QUIC) <quic_rjliao@quicinc.com>; Mohammed Sameer Mulla (QUIC) <quic_mohamull@quicinc.com>; Harish Bandi (QUIC) <quic_hbandi@quicinc.com>; linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-msm@vger.kernel.org <linux-arm-msm@vger.kernel.org>
> Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: QCC2072 enablement
>
> On Wed, Dec 17, 2025 at 04:58:50PM +0530, Vivek Kumar Sahu wrote:
>> Adding support for BT SoC QCC2072.
>> Set appropriate configurations for BT UART
>> transport.
> Read Documentation/process/submitting-patches.rst


I'll make the commit message more clear in the next patch set of this 
commit.


>
>> Signed-off-by: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c   |  8 ++++++++
>>   drivers/bluetooth/btqca.h   |  1 +
>>   drivers/bluetooth/hci_qca.c | 17 +++++++++++++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 7c958d6065be..7eb095db4a1d 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -854,6 +854,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>                         snprintf(config.fwname, sizeof(config.fwname),
>>                                  "qca/hmtbtfw%02x.tlv", rom_ver);
>>                         break;
>> +             case QCA_QCC2072:
> Please keep the file sorted. Find a correct place to insert your changes
> rather than randomly sticking them to the end. This applies to _all_ the
> changes you've made here.


I'll address this in the next patch set of this commit.

>
>> +                     snprintf(config.fwname, sizeof(config.fwname),
>> +                              "qca/ornbtfw%02x.tlv", rom_ver);
> I hope to see the firmware being submitted to linux-firmware.


"YES", firmware is being submitted.


>
>> +                     break;
>>                 default:
>>                         snprintf(config.fwname, sizeof(config.fwname),
>>                                  "qca/rampatch_%08x.bin", soc_ver);
>> @@ -929,6 +933,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>                         qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>                                  "hmtnv", soc_type, ver, rom_ver, boardid);
>>                         break;
>> +             case QCA_QCC2072:
>> +                     snprintf(config.fwname, sizeof(config.fwname),
>> +                              "qca/ornnv%02x.bin", rom_ver);
> No board-specific NVMEM dumps?


"NO", for this BT SoC there is no board specific NVM.


>
>> +                     break;
>>                 default:
>>                         snprintf(config.fwname, sizeof(config.fwname),
>>                                  "qca/nvm_%08x.bin", soc_ver);
> --
> With best wishes
> Dmitry
