Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0D16C69F
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472492; cv=none; b=O5UPiotg4XeSCOUyMMX2VgkoUHYUnErxmAXH7t6IQ3ayLaA98OXZm5+RoDjxQchNLkHHdz5CemQAIWt5BO/tPH+/9NXV+PT7sPrGftA8lB7NjJxy5c35xE+eymz7cj5xdUZCfihYUXSrPyx9fn01fI3oMOlJc/AJQeZjiXf35/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472492; c=relaxed/simple;
	bh=zoE4923V0PsclUGsE4gf9VUBFNqe0bWDhW7lN2YUWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mxrqCRCnVD20J6gsFGs05wuFezPaSOCzhAiWIx0+hd/ITjC9QF/xaub9dLv8BfHAnTcYxB+CgnNcLy8JKaiAebGSZilicTmqIH4DrUfG1d16Sjo6S8o3//DEG7ARVAdqtEWhkZ3n7Yahg5+dUB1/Pie182X/rXo/Ix5PuW1v/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lyyari9A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lyyari9A"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IK8tOu020366;
	Thu, 18 Apr 2024 20:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bSOOhzXeLO0DS/P6KPCknfdyn2ALQY8xM75gr/qNgok=; b=Ly
	yari9AzXVZMReyUb/nuzvCixmYfKjJBPK3WBDvL0FObuOo7Pt3MUTSIrhMuMfgEc
	bx48R1bmtJszPv+90DQcWO0QNFmOUPYqqiXYuIBAA2DHl3movpw6xIZi/Pg4H73H
	nQYnjiInG77fw2ml30o8JQ02PZQ46iAz0jreDJxLvXRzmn886VgzpEGLuXMD+g0m
	lX7ecEgQ3jpZhfq5yX6ppB0wNFGsrf7MeFzmmla72SKZM1HTIqmF+I9Qp7ACKu34
	6F7KSdNiixw9TcYXa1GDlA0W+qA0IsW+VehRtLcBWa/+08ah/1yOgwAwGmU1zJ2v
	VLrWCJVJ05pcKlDTy2sQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xka6rr200-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 20:34:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IKYg2c008719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 20:34:42 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 13:34:39 -0700
Message-ID: <8751981b-3063-4228-bbec-f36bd544e0fb@quicinc.com>
Date: Fri, 19 Apr 2024 04:34:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390 after disable then warm reboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <bartosz.golaszewski@linaro.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-3-git-send-email-quic_zijuhu@quicinc.com>
 <7cd6f395-1f1b-4a73-840f-d70fff5da220@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <7cd6f395-1f1b-4a73-840f-d70fff5da220@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SibjTcPWesfSKvnyNriCwAyasLaq1NOO
X-Proofpoint-GUID: SibjTcPWesfSKvnyNriCwAyasLaq1NOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180149

On 4/19/2024 12:48 AM, Krzysztof Kozlowski wrote:
> On 18/04/2024 16:06, Zijun Hu wrote:
>> From: Zijun Hu <zijuhu@qti.qualcomm.com>
>>
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>> serdev") will cause regression issue for QCA_QCA6390 if BT reset pin is
>> not configured by DT or ACPI, the regression issue is that BT can't be
>> enabled after disable then warm reboot, fixed by correcting conditions
>> for sending the VSC reset controller within qca_serdev_shutdown().
> 
> I have trouble understanding what is the bug. Can you rephrase it?
> 
Think about below sequences:
cold reboot(power off then power on) -> Enable BT -> Disable BT -> Warm reboot -> Enable BT again ...
BT is failed to be enabled after warm reboot.
>>
>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 160175a23a49..2a47a60ecc25 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2437,15 +2437,21 @@ static void qca_serdev_shutdown(struct device *dev)
>>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>  	struct hci_uart *hu = &qcadev->serdev_hu;
>>  	struct hci_dev *hdev = hu->hdev;
>> -	struct qca_data *qca = hu->priv;
>>  	const u8 ibs_wake_cmd[] = { 0xFD };
>>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>  
>>  	if (qcadev->btsoc_type == QCA_QCA6390) {
>> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
>> -		    !test_bit(HCI_RUNNING, &hdev->flags))
>> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>> +			BT_INFO("QCA do not need to send EDL_RESET_REQ");
>>  			return;
>> +		}
>> +
>> +		if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> 
> Commit msg does not help me at all to understand why you are changing
> the test bits.
it is test bits not changing bits.
> 
>> +			BT_INFO("QCA do not send EDL_RESET_REQ");
>> +			return;
>> +		}
>>  
>> +		BT_INFO("QCA start to send EDL_RESET_REQ");
> 
> Why debugging info is part of the fix?
> 
they are reserved intentionally to print critical info.
> Best regards,
> Krzysztof
> 

