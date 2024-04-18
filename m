Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD332F30
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477967; cv=none; b=IAhD04rvLTXRSelCn48VpSPDpyABETuYuhy/6AqG42AyJxHjApy8sELr+Zw4eL+fzMeNPf+ebJxA7asOpQ7TCFcMq/VucGqnnk3g22R9yb8NN/k7XVvHkEsAZDmkqQf1o7eF71Pl+mO34h+A0xhvDyQU7MR/1m769PvetdQXT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477967; c=relaxed/simple;
	bh=YqlO+/TZuhC2FkjS/jEiQZJlCL60Zyd0+bTAwVjMRCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A9ecWYalIKStV7PYHSIB3hHByo8fKqVaObW+DMNEBhoAnrRDhlGbDFL1XDKUBv4ZKJRTBuGnYBq+s/d/kEIV5AS821Umxr4egSzm7vBg1cz2hU1u+XXN3MNIQbzIuEvooQZBMy8KaSomVyAX1FwloMeBGYOugAsi9+MkZZ+Yoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lep8aWk2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lep8aWk2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ILo1HJ018476;
	Thu, 18 Apr 2024 22:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=R4+6kaLE38+JfOX+xHhQZbyLmvGHNt70vddRLkcj0yY=; b=Le
	p8aWk2zeTIrCsQGeFKJ/FJKGxVQvYXL9pbAts3uTty+C25Fh4M54a+65xq5zEVf6
	cOCAGPTiAUu944xETMIMtZha6ShkXE3ZhG/7NuQEBYN7x69WxAK3/XFVnxMb9R9/
	FqNyTg1DHYTAZY8nz/e/ujyDReI/r8nZWmci7JB4zKBtXR052hAWTsccea4vkB3/
	j7yY5bc5ACqxY8/uEO0D1sE9h75Ee/WhSeWZOX9AFPuaTUvncR+rjzwqMTnW5bLJ
	DaU7b+kkcQQIQedeZblAQt1NuwVb44KsxVCDNWdUmMM95TDihChhCFig1p9TouLq
	FY/6vW+OoesGXIdeH4mg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk9s788xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 22:05:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IM5vAM001404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 22:05:57 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 15:05:55 -0700
Message-ID: <f4b93d58-56a2-4fa1-88aa-7d5dfb8dcb0e@quicinc.com>
Date: Fri, 19 Apr 2024 06:05:53 +0800
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
 <8751981b-3063-4228-bbec-f36bd544e0fb@quicinc.com>
 <93af3308-d70f-4423-a911-0f437f882462@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <93af3308-d70f-4423-a911-0f437f882462@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5k6XpWV3pRsra-WOLjk7n04gCvhvjm12
X-Proofpoint-ORIG-GUID: 5k6XpWV3pRsra-WOLjk7n04gCvhvjm12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180160

On 4/19/2024 4:58 AM, Krzysztof Kozlowski wrote:
> On 18/04/2024 22:34, quic_zijuhu wrote:
>> On 4/19/2024 12:48 AM, Krzysztof Kozlowski wrote:
>>> On 18/04/2024 16:06, Zijun Hu wrote:
>>>> From: Zijun Hu <zijuhu@qti.qualcomm.com>
>>>>
>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>> serdev") will cause regression issue for QCA_QCA6390 if BT reset pin is
>>>> not configured by DT or ACPI, the regression issue is that BT can't be
>>>> enabled after disable then warm reboot, fixed by correcting conditions
>>>> for sending the VSC reset controller within qca_serdev_shutdown().
>>>
>>> I have trouble understanding what is the bug. Can you rephrase it?
>>>
>> Think about below sequences:
>> cold reboot(power off then power on) -> Enable BT -> Disable BT -> Warm reboot -> Enable BT again ...
>> BT is failed to be enabled after warm reboot.
> 
> Still not. Please get someone to help you rephrase it. One long sentence
> is not good approach. Describe the problem, how it can be reproduced and
> then come with brief explanation how you fixed it (because it is not
> obvious to me).
> 
thanks for your suggestions. will optimize commit message based on your suggestions.
>>>>
>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>> Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>> ---
>>>>  drivers/bluetooth/hci_qca.c | 12 +++++++++---
>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index 160175a23a49..2a47a60ecc25 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -2437,15 +2437,21 @@ static void qca_serdev_shutdown(struct device *dev)
>>>>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>>>  	struct hci_uart *hu = &qcadev->serdev_hu;
>>>>  	struct hci_dev *hdev = hu->hdev;
>>>> -	struct qca_data *qca = hu->priv;
>>>>  	const u8 ibs_wake_cmd[] = { 0xFD };
>>>>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>>>  
>>>>  	if (qcadev->btsoc_type == QCA_QCA6390) {
>>>> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>>> -		    !test_bit(HCI_RUNNING, &hdev->flags))
>>>> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>> +			BT_INFO("QCA do not need to send EDL_RESET_REQ");
>>>>  			return;
>>>> +		}
>>>> +
>>>> +		if (hci_dev_test_flag(hdev, HCI_SETUP)) {
>>>
>>> Commit msg does not help me at all to understand why you are changing
>>> the test bits.
>> it is test bits not changing bits.
> 
> Previously we tested bits for BT off and HCI running. Now not, so you
> changed the logic. Maybe it is correct, maybe not, I don't understand why.
> 
if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means we can and need to do initialization
by calling hdev->setup() for every BT enable,  so we don't need to send VSC to reset controller
here.

if HCI_QUIRK_NON_PERSISTENT_SETUP is cleared. it means we only can or need to do initialization
for the first BT enable operation. if HCI_SETUP is set, that means we don't do any BT enable yet
and the initialization operations are never performed. so we also don't need to send VSC any more.

otherwise, we need to send VSC to reset controller since initialization have been Done regardless of
BT state. for this case the serdev have still be opened. so it also don't meet the crash the 272970be3dab
fixed.

>>>
>>>> +			BT_INFO("QCA do not send EDL_RESET_REQ");
>>>> +			return;
>>>> +		}
>>>>  
>>>> +		BT_INFO("QCA start to send EDL_RESET_REQ");
>>>
>>> Why debugging info is part of the fix?
>>>
>> they are reserved intentionally to print critical info.
> 
> No, it's downstream coding style. Please don't bring it upstream. Or
> explain why this deserves informing user. Drivers should be quiet mostly.
> 
> 
okay, will remove BT_INFO("QCA start to send EDL_RESET_REQ");
> 
> Best regards,
> Krzysztof
> 

