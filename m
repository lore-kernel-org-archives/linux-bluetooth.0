Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE818C02E
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314459; cv=none; b=nMEpKvDmkpcNP/KT4BU0JDM+XcyF/TaHjoq4Fq2q3OH7qDwmLD64m0bkNx2CkTBwHhhQvSlp1Xl3slMSLUswtkIpTAe8n5yo60MxGDnmbQPs4Z7dgFPtrUfh5ebDxeWh+dRnBO9u9XONdv4T+lBbY3N0hkazAVeZBLhN5bTdTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314459; c=relaxed/simple;
	bh=2jGxGEuBlJscNQnXWDluFEDy5ghSOzIcnct0+mW6ZRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0nWOU5Y2ixlkXtlpsNcEjcqNZ/lw49M4/Tko8oK/vzU6x9gSyyIqrT89jaKNTqDEjjBzrcMWKgBdQgCrABebWcDG6NHYgJF49fOGzsBPOY11NKFO715tI/034bryxKmeqZZ8C5R0iNcL7x5AXVUdYOw4PAAE28MGWx6jNwSeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMsJ3Tx2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1F/4uRu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMsJ3Tx2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1F/4uRu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GH4RA8985178
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9IwUNyGoySH/Ufr4T9HjdVC2VQgvcnJRhQYb4OPxhIk=; b=BMsJ3Tx2u3EKMJxL
	wBV9vvy0qnc1SpJFVMJ8aJ19SAB4zJU88VqkW80A9l3ZTKdeFTBIMCIeozmEkvYt
	YXzYsWaHJ3FA9Mudkejh1MMyAPkLWzJ9LrvuJHje+KYFIqIOdEJE7B8aunTfy6WK
	MtOangzJSUUdqiH5fnkIenhsQy7+/8C3MhLFM+O9PRnQv1Ckt9Ptnf16szXpT8p3
	im9eSLMrqfQp8NFhe+mZ+QgUmoAzMIGx4XtvQ0tEK0if+bQV3KpkPf2cfkwSwE1+
	WC+qkXjA3eTCULc/x2NJKP5lN7idozZxAvVGW8zw1MnAOmdGMtebwAuOnYaSEDkf
	rVuhEQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap1e58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:47:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c61dee98720so2929665a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 23:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771314456; x=1771919256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IwUNyGoySH/Ufr4T9HjdVC2VQgvcnJRhQYb4OPxhIk=;
        b=A1F/4uRu2/kdfQvi9t2zO7AIj4YkKfSLVXrE247RKDbgTNqeDxo5x0AABvM1ZDUtoA
         qRB1Pg1KZG15U3Sp/IMfAF19ZUhdYJ9F20C0n9sAmRPHi59hF50pXBp4bqI8kNgKQHvf
         dNgek6VJd4tPc7I5dVYUYaYdTIQ401K5EAJ64FAsRvQ0R84Vr8H26uX61tS7iq89zHS8
         wHJq8pv6SahkeYjW7InMg165gIYV956Apu59RYN/v+UOHJFjhg9E6n8AI6bq8ApFCVQP
         exh7tcebFw+ApBj8Fg+Y05gRPS3nrk7oRb4ehMX8tU5IJSLQJtgd9ewtQfwbSlkzcA76
         //yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771314456; x=1771919256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IwUNyGoySH/Ufr4T9HjdVC2VQgvcnJRhQYb4OPxhIk=;
        b=G+2C/ql0mCkmgF8fRluwU1+U68gjHhN62GvdNjNiO1LfMRBZoZWrAaRrf+HB0ocGoX
         /2Jfr44D94NAnxJ9tWxky8kY6TqAJK6k4FfN4saVDnBfIkYgx0OE1gY/d/DPtY7hxDf6
         3aBPAWmi56LMmN0LsGgF13d0kcd9Hvn6nPwPZBIDx5UETxGG0PMfCikf785uFtqi70Rs
         /I7jMBYL5ajNJlDCwuTgFyvz8qCm/hyk4lM/Y7Ekv5TA9L94tQXNgwoDWBPxM/yTTFMg
         BIpaiSUphKyy82DkaIbeO1o++FuYycqR+QHtVcczNgOVRnI9RXzknoJyULbkfWOfS9SM
         +jnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEK+NtCfGitiKlZvQ5t3gnbCaJAgXD7bRBSkBYhDMVsSmKwj0vsEPPqwqBNbZ3T8cZpShCr1EKckXAMvsmTps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXLQ7JRhQtuMiXt6qC4wthJ8weFtOB7oT46fT1bPJlqLtMV9q
	Gqsgm/0zgx9aBEPbfszKz9htDLak4wDzBBviODjmNwpyXX4Dm1sepP56/56HbasC8V9CnPct9tx
	fw5QhkdM4doB2DZCnfQ4BgvjndXkqSxd+2fpqjSg6j+vNyGdeLZTmU+Z7c2j+5DxOuDMxktc=
X-Gm-Gg: AZuq6aLiCW9GjscCZVOecseryj0Ppw914vkRgPnGyTA9hij9V+XEPCH7E+lKa1maQ8g
	Q0X72yOWm4Af6bOJZKWvdLnRnqHTOR0gjrzlO+5z/KlJ4FzPzdGfmscwUtPJ1OGwzSrE5ahuMj8
	TcyykKQsohrOuV1IPTwukAlm9f0G7AhabNUHwt4AjSFz1m7Ku8Xx3ZrOTqgthv7ko4DvyVziO3G
	L6e8Os7kFOySwOoFeLMinKOHquGbOC4fghnzbh8GK0usXetlwl1KUeti8rDwspyX6hF1gQxraFt
	BEFmgGnpmsGlbNMtT9EGkRrU4sBBPrQphWkXCGiKcHHbS+0k94kdhFvuH59e/XIPKDNZOpTSs8R
	3ooFi80n7ruWvK1H2CMgnfxQ1G3knJlwA0vYnQ0jj4vPocWXo
X-Received: by 2002:a05:6a20:72a0:b0:394:593a:eea4 with SMTP id adf61e73a8af0-39483a47260mr9250292637.57.1771314455569;
        Mon, 16 Feb 2026 23:47:35 -0800 (PST)
X-Received: by 2002:a05:6a20:72a0:b0:394:593a:eea4 with SMTP id adf61e73a8af0-39483a47260mr9250267637.57.1771314455026;
        Mon, 16 Feb 2026 23:47:35 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e531e6cbbsm9049846a12.18.2026.02.16.23.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 23:47:34 -0800 (PST)
Message-ID: <19d3cced-f630-4a6b-853e-3798487fd769@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:17:29 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
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
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <mt4vrzmq7caqddwtz7nc3tn33zxh7uupoxfmk5pfqobhuex43f@se64qz7qvuh6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA2MyBTYWx0ZWRfX1jKIceki86L3
 0+5rfb1H/3UYqcN43n5sXrL1AA21nCvgSKzZ3rZGIMJ1eEqGgxODbxzsgQfD3ioErUWWU6sHovp
 1jI2JvH/2Gx5QQ5yZZt+QpkaB5HdRxrbWTIb/UPYp1b4fB5KNKkZwWeUrJpq47Ah9hn4knmLCeX
 bs5Cagfy8PJOnKhh/DxZjmJiyEhlt580jYo+8p9Mfy8wIoL0Ytz4Reyue//muSDXqIJnq95mLFy
 ohYF7e1XvoqK7cEwrPvSrvXebLKCUwzWo/q4LbNPXaZPMA9G6M30ZnljCUuYiJep+DIO7AITfrW
 fCGoLVpU01R/gBcn6ZptXIQKZh/H+BOBpsb+mmHV1rwFajEoIIbbA3KOa/eA24lkAweLDsb7n8L
 RfxpG295kOEQYQdqrMh1v8iGp5grG6bMOMk2wYOaeFOc2Dx48Tont6sUJRw369KbVZcLBHsBGqb
 MQtmIs/+DSt532KCvgg==
X-Proofpoint-ORIG-GUID: AXrAq6q9zQhQBJA4Kmaf8DX5g6lmiRpB
X-Proofpoint-GUID: AXrAq6q9zQhQBJA4Kmaf8DX5g6lmiRpB
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=69941d18 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=ddT8l1QBLkt25e737uwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170063



On 2/17/2026 12:06 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 11:17:31AM +0530, Vivek Sahu wrote:
>> QCC2072 is a family of WiFi/BT connectivity chip.
>> It requires different firmware files and has different
>> configurations , so add it as a separate SoC type.
>>
>> The firmware for these chips has been recently added to the
>> linux-firmware repository and will be a part of the upcoming
>> release.
>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c   |  8 ++++++++
>>   drivers/bluetooth/btqca.h   |  1 +
>>   drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 9f7e13fcb20e..65c8d2978956 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -807,6 +807,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   			snprintf(config.fwname, sizeof(config.fwname),
>>   				 "qca/htbtfw%02x.tlv", rom_ver);
>>   			break;
>> +		case QCA_QCC2072:
>> +			snprintf(config.fwname, sizeof(config.fwname),
>> +				 "qca/ornbtfw%02x.tlv", rom_ver);
>> +			break;
>>   		case QCA_WCN3950:
>>   			snprintf(config.fwname, sizeof(config.fwname),
>>   				 "qca/cmbtfw%02x.tlv", rom_ver);
>> @@ -900,6 +904,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   			snprintf(config.fwname, sizeof(config.fwname),
>>   				 "qca/htnv%02x.bin", rom_ver);
>>   			break;
>> +		case QCA_QCC2072:
>> +			snprintf(config.fwname, sizeof(config.fwname),
>> +				 "qca/ornnv%02x.bin", rom_ver);
>> +			break;
>>   		case QCA_WCN3950:
>>   			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
>>   				variant = "t";
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index 8f3c1b1c77b3..a175ac31e7b2 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -158,6 +158,7 @@ enum qca_btsoc_type {
>>   	QCA_WCN6750,
>>   	QCA_WCN6855,
>>   	QCA_WCN7850,
>> +	QCA_QCC2072,
> 
> Why not keep it sorted?
> 
As mentioned in the cover letter "qca_btsoc_type" enum in 
drivers/bluetooth/btqca.h contains all the soc type which need to be 
enabled for BT enablement on the target device. There are few places 
where logic of framing packets transferring between SoC  and Host 
depends on the which generation of the chip it is, refer api 
"qca_read_soc_version". So It is not sorted in btqca.h file.

>>   };
>>   
>>   #if IS_ENABLED(CONFIG_BT_QCA)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 8e035b7c6f3e..7786ced0bbbb 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -625,6 +625,7 @@ static int qca_open(struct hci_uart *hu)
>>   		qcadev = serdev_device_get_drvdata(hu->serdev);
>>   
>>   		switch (qcadev->btsoc_type) {
>> +		case QCA_QCC2072:
>>   		case QCA_WCN3950:
>>   		case QCA_WCN3988:
>>   		case QCA_WCN3990:
>> @@ -1500,6 +1501,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   		 * changing the baudrate of chip and host.
>>   		 */
>>   		switch (soc_type) {
>> +		case QCA_QCC2072:
>>   		case QCA_WCN3950:
>>   		case QCA_WCN3988:
>>   		case QCA_WCN3990:
>> @@ -1516,6 +1518,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   		}
>>   
>>   		switch (soc_type) {
>> +		case QCA_QCC2072:
>>   		case QCA_WCN3990:
>>   			reinit_completion(&qca->drop_ev_comp);
>>   			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
>> @@ -1535,6 +1538,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   
>>   error:
>>   		switch (soc_type) {
>> +		case QCA_QCC2072:
>>   		case QCA_WCN3950:
>>   		case QCA_WCN3988:
>>   		case QCA_WCN3990:
>> @@ -1551,6 +1555,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   		}
>>   
>>   		switch (soc_type) {
>> +		case QCA_QCC2072:
>>   		case QCA_WCN3990:
>>   			/* Wait for the controller to send the vendor event
>>   			 * for the baudrate change command.
>> @@ -1935,6 +1940,10 @@ static int qca_setup(struct hci_uart *hu)
>>   		soc_name = "qca2066";
>>   		break;
>>   
>> +	case QCA_QCC2072:
>> +		soc_name = "qcc2072";
>> +		break;
>> +
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>> @@ -1970,6 +1979,7 @@ static int qca_setup(struct hci_uart *hu)
>>   	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>   
>>   	switch (soc_type) {
>> +	case QCA_QCC2072:
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>> @@ -2003,6 +2013,7 @@ static int qca_setup(struct hci_uart *hu)
>>   	}
>>   
>>   	switch (soc_type) {
>> +	case QCA_QCC2072:
>>   	case QCA_WCN3950:
>>   	case QCA_WCN3988:
>>   	case QCA_WCN3990:
>> @@ -2108,6 +2119,12 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>>   	.num_vregs = 0,
>>   };
>>   
>> +static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
>> +	.soc_type = QCA_QCC2072,
>> +	.num_vregs = 0,
>> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
> 
> No regulators? How is it powered on?
> 
Host to controller communication is over M.2 UART, so no regulators are 
required to power on chip.

>> +};
>> +
>>   static const struct qca_device_data qca_soc_data_wcn3950 __maybe_unused = {
>>   	.soc_type = QCA_WCN3950,
>>   	.vregs = (struct qca_vreg []) {
>> @@ -2758,6 +2775,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>>   	{ .compatible = "qcom,qca6174-bt" },
>>   	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
>>   	{ .compatible = "qcom,qca9377-bt" },
>> +	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},
>>   	{ .compatible = "qcom,wcn3950-bt", .data = &qca_soc_data_wcn3950},
>>   	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
>>   	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>> -- 
>> 2.34.1
>>
> 

