Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75710788
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713649364; cv=none; b=q1beoCenvy0eYaXKWUwpcRxypzFz6oCexMch7EYKp4VxU11v2jCB9wznR6f3glAgJeol39ieoca9jz0inAfPApqvM5JecGGNqN4NWaTSLNZPcFFnl0WcyA/htk8yrfY367YgK4XZxkprzIV8Yq3BNXYO80f6CnOkmXVgodEHYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713649364; c=relaxed/simple;
	bh=K7eijfu1sxCNMje7iClmCNBPC2JV47O6K5YNLuSei8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mL+4ccdVaiLbpX5inQI2Cve4A5HNxhg4NW8J3yLhIVlE6Hmgwg6DCzWd5pLGyR+5pLf4y+rUzD3+2SE41cnVAq2gUKWNyEz03Z8AzY9bUb+kmS9a1qznkyldxEx1xZZv+gU5frp4Ron76QOpje19AqC79tsWF0iZ86sQ8fRPDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SZq44Fgy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SZq44Fgy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KLQbNo014164;
	Sat, 20 Apr 2024 21:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LP3l2pHa+laTsfbvAFj0/33y0xXVJSHCm6qUbLPGCP4=; b=SZ
	q44FgyLvYmVFWvjiO3JZ+0jL/eQhmaD02skOoDBrA3KOfYCT1YoxEVgk9M9x/vY2
	fcPdd8/9cBD9nu0YMstaI5yGCtyeMeoasJ+JErRtSUw9QufR0yCo3vOiGD4HpOrw
	pqK4eer1IKLK9TlwpLU0c9SwwKBPcR+mJrk2Jkiu9utgKIazXStq/F6Pau8zYgeN
	PllCJkd/8qawY//G98GIWi1I51xGpMA5/03/K1kK/W2evM4lXBljIX1QffUSpiWW
	pFD+TZW5lNXtlQS+V8fQGoV0s7Gf+XJgriZDfF3TQ7I08F1t2FmQOvZ3jhXp5iE/
	10CfzlgnZbYYOWFhdukQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm70ch8c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 21:42:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KLgYEE020158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 21:42:34 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 14:42:33 -0700
Message-ID: <1cbe19a8-37e2-4933-b1c1-9e6c30d359cc@quicinc.com>
Date: Sun, 21 Apr 2024 05:42:30 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390 after disable then warm reboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-3-git-send-email-quic_zijuhu@quicinc.com>
 <63772c3f-eab7-4be0-8b1c-0cebea361eae@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <63772c3f-eab7-4be0-8b1c-0cebea361eae@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qwKFB3aAcf5nfbDcdWalRPUifP7V7rVN
X-Proofpoint-ORIG-GUID: qwKFB3aAcf5nfbDcdWalRPUifP7V7rVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_19,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=977 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200160

On 4/20/2024 7:07 PM, Krzysztof Kozlowski wrote:
> On 20/04/2024 00:03, Zijun Hu wrote:
>> From: Zijun Hu <zijuhu@qti.qualcomm.com>
>>
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>> serdev") will cause below regression issue:
>>
>> BT can't be enabled after below steps:
>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>> if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.
> 
> Please mention if QCA6390 requires reset pin, according to datasheet or
> some hardware guideline.
> 
will update commit message.
>>
>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>> once BT was ever enabled.
>>
>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 0934e74112a6..3f5173f1180b 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2438,13 +2438,12 @@ static void qca_serdev_shutdown(struct device *dev)
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
>> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
>> +		    hci_dev_test_flag(hdev, HCI_SETUP))
>>  			return;
> 
> I am sorry, but why do we need to perform shutdown procedure now if
> device is off?
> 
this is shutdown of serdev and not hdev's shutdown.
> I raised questions about this and I still don't understand. Not much got
> better comparing to previous version. Actually, I have no clue what
> changed. Where is the changelog?
> 
my reply at below link will help you
https://lore.kernel.org/all/fe1a0e3b-3408-4a33-90e9-d4ffcfc7a99b@quicinc.com/
> 
> Best regards,
> Krzysztof
> 

