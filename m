Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555E47D954
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987072; cv=none; b=cn4LPM/VppycUirZKs+FiRu/YhJ6sRwoWlqE3Bqmk+yFyAgaVfm6r5hhD+RltYsZac8a+mIY1WxrGDvyQZBcz52f1GBRHV+Ygq+fIfXi6Eyaafwx3eSwdhYik/0qYBvzrVfZZSd06YUtrU820mqy7dM6pHxdZizXLAHVni4kwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987072; c=relaxed/simple;
	bh=qhf4FJ3odKS56QxVuWRfD31f5/JvheIY33dz3gwcHeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+9XaaAm8r+7Edyk06N8puckNTM2ZC6oG14AsOQki7PaFXyDBai5bbCd4RXgMXBG10SwPv/ChVf+HyiBIF7cAcmtijr4oBXn0T0qHyDHqOF6pjgemfaxyLu+zUxGC8KfP/qw6y41h6mtobBnGKS24uj/40Req2eObAn083iap4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jE/O8SMf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eW0wMM8T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jE/O8SMf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eW0wMM8T"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627Ttig3964266
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 10:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ke6SoKxqJ09nAQTKH6WMSBqtr3TiErZcgSc9Of5cKMo=; b=jE/O8SMf51onCh5h
	sC4+NROafsbjjJi3N/E4sl8Atcr8XIV4YEserGMNTIN23zUr9SAhKKsYvS+6PYXq
	NEL2plkyWXYGQL0nNNiTQLGzHi31bKV0cJWb+B4si9wMJHUrdeB1uLgqyPQjaLre
	8qOP9xteKareNTzDD8oOauciCWG7yNhAs6UeieUj559eR99csCzvMQW1jEz6S6Jo
	xWvCXSA3gv/66S6vp9oxY8fmpnq2ycWOTJpW9qu3Ed3UIcrUO6d4gCxRyorcSWYz
	+WLs0weh/7R2jFQc23p68AjeHCRQWU7K+xz73L/QlA3H5QBCORjbPTUBi/3w3Y9F
	7G7uGA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc0mg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 10:11:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso1840465a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782987069; x=1783591869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ke6SoKxqJ09nAQTKH6WMSBqtr3TiErZcgSc9Of5cKMo=;
        b=eW0wMM8TazZmumJckVxYp9tzBgn1vcNkBw/bdhwk4ajLo9poTTB+BwKPpIviWgPXUN
         a2KMC0wEbv29nsXWOtZj7fd7PArpoJu9gfE4QKj87tu+FoCSo94Q4jtmtCn5iL1Dz9nr
         InLNUmEzYIZpLoq/qkEfaDYNOyEpHO+P9A9dVELxWIdhhoHZH3PsVqt/LJ7hLTXu7Jtj
         SdG0LYMmHPfin1hVVZ4Es1Ow1XC7CPaQk6sKs5QvguL6MIS7fTVl2E2jLQF4tvRz1Liy
         0u6B4RSOM9uIIZ8GKaNWAzZBonQYlrqT1i87g37o0O+P7edK/OGPRsrZtKt5xBsUFms3
         dLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782987069; x=1783591869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke6SoKxqJ09nAQTKH6WMSBqtr3TiErZcgSc9Of5cKMo=;
        b=ABLonfLBOZzftqIa5Ok21lwVi5kgZInehUUwmrPB3F8k6yjJ4zogHFff/cx5x9t9bX
         a3j6QeDli88cAir4sTBEXiFtsyy1x1d2Kd3ALYL+Qi8I/9kMNXJwitqotRgdWeno4PGk
         DAC+1lzba4qnciJ/SrlkAwppfl/HE9fyemhqjbzKzHU2fvS/+KPTq7MX7IpjcBakvFRo
         hy9l9nT9oML7mnm3gsFXt5GekO7RmZjv9wChpvG5ewvq8Zc0fwe2/BZutrYfHHk5rJKV
         /Q6tPmgNdWSvZhG3WJkBGN6/PmMxyx99zC010oTuBFKcz8iBTW7znqjketkk9ozUD+8Y
         fKmA==
X-Forwarded-Encrypted: i=1; AFNElJ9TClu/Kr0EvrOWSYlzp8OnZof8j+uZqXGEj7gjI3YBMNFKAwsYefgCfYAxRObTpoYJYe7GELQxDfvzPYjTDe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YnA41zPREa7U0g5syWeGQeUptJXpWdpaQfFjjDTKD+LIT9R5
	6eezIs4sdDTuW/DTkvwQlrbiBx/mTJ6wzabqEd7Hgci+hOk825CCWgEMvuxIzW7BMBkO7TavEWB
	QXDbBxqXAHnGzwElWEDqVP+CGeytMFZCGa6FLPTp40A2p/ZQuc93QwwP8p/T5ohYxum8mM4a1a1
	PFrd8=
X-Gm-Gg: AfdE7cn8+5AYCFTQmyPBUvtykdHaNf2AKeH+uenIKsuY/hGYaG/NYk8QA51L0nQjKQS
	0ANuw8JZlLmUtRFYOQGQ8ohCUWHGQhTnhhneRS/Ql7cv7sF0H5ao3ajy2J89dJydNGzAZdc291g
	Uxz/OSnP05U47IDJ0uqAAR3QabxxtGKLgclMjWChk+Aad/8fWxY5Pz+b5mEKTvn+aF+nuXcPST+
	CfE3thTg4ixDQT27ZtEG9ErvpGU8/2KTtqTKBVHHquaAYPWvjYyN1rfHLk72ftZu4ZBvGdL4RNJ
	G6+sgDkiCA8l4JGSpTWMp3I+/qL/07NAwIeB9VnqyJ3I1k9DZnS9WuvOPjTC4oAHq+MzlTqChe8
	gav4n58QQ//bJCcM3pBjSOlQcZ5DrGb3CdiaPfz32
X-Received: by 2002:a05:6a20:258f:b0:3bf:8b8d:3151 with SMTP id adf61e73a8af0-3bfed3efa54mr6561687637.44.1782987069027;
        Thu, 02 Jul 2026 03:11:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:258f:b0:3bf:8b8d:3151 with SMTP id adf61e73a8af0-3bfed3efa54mr6561630637.44.1782987068440;
        Thu, 02 Jul 2026 03:11:08 -0700 (PDT)
Received: from [10.218.39.201] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e926a7066sm1075080a12.28.2026.07.02.03.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:11:08 -0700 (PDT)
Message-ID: <ca635179-eb3c-4a5f-882c-065deaca155c@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:41:01 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Bluetooth: qca: add QCC2072 support
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, dishank.garg@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com>
 <CAMRc=MeUhtNiMQLeMwvF_v+WOaiVgF+jsTM1HPZd_XdkGk3txA@mail.gmail.com>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <CAMRc=MeUhtNiMQLeMwvF_v+WOaiVgF+jsTM1HPZd_XdkGk3txA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -HxkVpFxeiilW7TVh5XS86NNy8IOYW-L
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46393e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bST5VZXYjKSMy1wPTP0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwNSBTYWx0ZWRfXzeaRqG3LmURI
 IGiuENHdqaYYtXlfHHpdCOJo20FgrwGbBKFAi7Z4F5vlOai76jwZh+FVvr675uvDzdHOBvrGHq1
 4O+mcYhpLuPa3qHEyeCenLtCcXtdCCm3dFUJFIgtNejBOVdkQo/KrbDshamQSm5EnfQqrdzLAQ/
 cM7gZT/Bbfgf6i2bOruzR4vPIsE7mOAdI/Vg0Hzi80F3IhRQH3sykO63/7kmmD/D4N8mbTE75xd
 xpjd/m7qCdHAO6AxJs5zeI88gqUHHiLpUaVYC1UnwFv6P74lPhUtaIE7ejhs7iZAnkilxZ9lonA
 DxGsmosvGRTMWrxC1asl1W+nzMOf60ckbiqw8yAOPMdxM2SHBcDox3GzQdq7DkZ5ljvXLo34jYD
 3QXTU9pz4g4JTTGIuiYrcaInKipT/H3eWfMh/kT+isS3pgzKGUQCv06gA0EndmigmBp3OeGGJ2i
 nJYQepFFeeHe4VWZdlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwNSBTYWx0ZWRfX6bK4DcAU7wjI
 rgP8IpzyM3wEWmOfYygrlfm29O1AWS9MVbSnkWlsNVEbh89WpVxV2h9R6GAycrCxoQyz0MQQuDk
 QOqKKBNoOFVjE/euD73Skt0UmQ4S0oc=
X-Proofpoint-GUID: -HxkVpFxeiilW7TVh5XS86NNy8IOYW-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020105



On 6/1/2026 1:57 PM, Bartosz Golaszewski wrote:
> On Fri, 29 May 2026 19:58:22 +0200, Yepuri Siddu
> <yepuri.siddu@oss.qualcomm.com> said:
>> QCC2072 is a BT/WiFi combo SoC that uses different firmware
>> filenames and requires no external voltage regulators, so add
>> it as a new SoC type.
>>
>> The chip supports the wideband speech and valid LE states
>> capabilities. Its firmware is named using the "orn" prefix and
>> follows the standard rom-version-based scheme:
>>      - qca/ornbtfw<ver>.tlv
>>      - qca/ornnv<ver>.bin
>>
>> These firmware files are already present in the linux-firmware
>> repository.
>>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c   |  9 +++++++++
>>   drivers/bluetooth/btqca.h   |  1 +
>>   drivers/bluetooth/hci_qca.c | 24 ++++++++++++++++++++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index dda76365726f..0ef7546e7c7a 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -843,6 +843,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   			snprintf(config.fwname, sizeof(config.fwname),
>>   				 "qca/hmtbtfw%02x.tlv", rom_ver);
>>   			break;
>> +		case QCA_QCC2072:
>> +			snprintf(config.fwname, sizeof(config.fwname),
>> +				 "qca/ornbtfw%02x.tlv", rom_ver);
>> +			break;
>>   		default:
>>   			snprintf(config.fwname, sizeof(config.fwname),
>>   				 "qca/rampatch_%08x.bin", soc_ver);
>> @@ -937,6 +941,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>   				 "hmtnv", soc_type, ver, rom_ver, boardid);
>>   			break;
>> +		case QCA_QCC2072:
>> +			snprintf(config.fwname, sizeof(config.fwname),
>> +				 "qca/ornnv%02x.bin", rom_ver);
>> +			break;
>>   		default:
>>   			snprintf(config.fwname, sizeof(config.fwname),
>>   				 "qca/nvm_%08x.bin", soc_ver);
>> @@ -999,6 +1007,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   	case QCA_WCN6750:
>>   	case QCA_WCN6855:
>>   	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>   		/* get fw build info */
>>   		err = qca_read_fw_build_info(hdev);
>>   		if (err < 0)
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index 8f3c1b1c77b3..a175ac31e7b2 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -158,6 +158,7 @@ enum qca_btsoc_type {
>>   	QCA_WCN6750,
>>   	QCA_WCN6855,
>>   	QCA_WCN7850,
>> +	QCA_QCC2072,
>>   };
>>
>>   #if IS_ENABLED(CONFIG_BT_QCA)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index ed280399bf47..fc67ba0e4984 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1372,6 +1372,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>>
>>   	/* Give the controller time to process the request */
>>   	switch (qca_soc_type(hu)) {
>> +	case QCA_QCC2072:
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>> @@ -1459,6 +1460,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
>>   static int qca_check_speeds(struct hci_uart *hu)
>>   {
>>   	switch (qca_soc_type(hu)) {
>> +	case QCA_QCC2072:
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>> @@ -1510,6 +1512,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   		case QCA_WCN6750:
>>   		case QCA_WCN6855:
>>   		case QCA_WCN7850:
>> +		case QCA_QCC2072:
>>   			hci_uart_set_flow_control(hu, true);
>>   			break;
>>
>> @@ -1545,6 +1548,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   		case QCA_WCN6750:
>>   		case QCA_WCN6855:
>>   		case QCA_WCN7850:
>> +		case QCA_QCC2072:
>>   			hci_uart_set_flow_control(hu, false);
>>   			break;
>>
>> @@ -1861,6 +1865,7 @@ static int qca_power_on(struct hci_dev *hdev)
>>   	case QCA_WCN6750:
>>   	case QCA_WCN6855:
>>   	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>   		ret = qca_regulator_init(hu);
>>   		break;
>>
>> @@ -1957,6 +1962,10 @@ static int qca_setup(struct hci_uart *hu)
>>   		soc_name = "wcn7850";
>>   		break;
>>
>> +	case QCA_QCC2072:
>> +		soc_name = "qcc2072";
>> +		break;
>> +
>>   	default:
>>   		soc_name = "ROME/QCA6390";
>>   	}
>> @@ -1980,6 +1989,7 @@ static int qca_setup(struct hci_uart *hu)
>>   	case QCA_WCN6750:
>>   	case QCA_WCN6855:
>>   	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>   		if (qcadev->bdaddr_property_broken)
>>   			hci_set_quirk(hdev, HCI_QUIRK_BDADDR_PROPERTY_BROKEN);
>>
>> @@ -2013,6 +2023,7 @@ static int qca_setup(struct hci_uart *hu)
>>   	case QCA_WCN6750:
>>   	case QCA_WCN6855:
>>   	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>   		break;
>>
>>   	default:
>> @@ -2166,6 +2177,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
>>   	.num_vregs = 4,
>>   };
>>
>> +static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
>> +	.soc_type = QCA_QCC2072,
>> +	.num_vregs = 0,
>> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
>> +};
>> +
>>   static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>>   	.soc_type = QCA_WCN6750,
>>   	.vregs = (struct qca_vreg []) {
>> @@ -2268,6 +2285,7 @@ static void qca_power_off(struct hci_uart *hu)
>>
>>   	case QCA_WCN6750:
>>   	case QCA_WCN6855:
>> +	case QCA_QCC2072:
>>   		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>>   		msleep(100);
>>   		qca_regulator_disable(qcadev);
>> @@ -2414,6 +2432,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   		qcadev->btsoc_type = QCA_ROME;
>>
>>   	switch (qcadev->btsoc_type) {
>> +	case QCA_QCC2072:
>>   	case QCA_QCA6390:
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>> @@ -2434,6 +2453,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   	}
>>
>>   	switch (qcadev->btsoc_type) {
>> +	case QCA_QCC2072:
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>> @@ -2484,6 +2504,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   		if (!qcadev->bt_en &&
>>   		    (data->soc_type == QCA_WCN6750 ||
>>   		     data->soc_type == QCA_WCN6855 ||
>> +		     data->soc_type == QCA_QCC2072 ||
> 
> Looking at the bindings: this chip cannot have an enable GPIO, so it probably
> should have its own if branch that unconditionally sets power_ctrl_enabled to
> false?

QCC2072 is an M.2 E-key chip. As M.2 Power Sequencing changes are being 
upstreamed, we will reupdate our existing patches to align with M.2 
power sequencing approach.
This includes aligning the bindings, DT and also BT driver changes.

Thanks,
Siddu

> 
>>   		     data->soc_type == QCA_WCN7850))
>>   			power_ctrl_enabled = false;
>>
>> @@ -2492,6 +2513,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   		if (IS_ERR(qcadev->sw_ctrl) &&
>>   		    (data->soc_type == QCA_WCN6750 ||
>>   		     data->soc_type == QCA_WCN6855 ||
>> +		     data->soc_type == QCA_QCC2072 ||
> 
> Same here.
> 
> Bart
> 
>>   		     data->soc_type == QCA_WCN7850)) {
>>   			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>>   			return PTR_ERR(qcadev->sw_ctrl);
>> @@ -2570,6 +2592,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>>   	struct qca_power *power = qcadev->bt_power;
>>
>>   	switch (qcadev->btsoc_type) {
>> +	case QCA_QCC2072:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>>   	case QCA_WCN3991:
>> @@ -2779,6 +2802,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>>   	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>>   	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
>>   	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
>> +	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>> --
>> 2.34.1
>>
>>

