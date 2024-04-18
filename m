Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C66199E98
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476625; cv=none; b=kRT4RTzQUOszZ/unA2OykcYPVlYxEopnLgN4Foccii7LRPRDMGhpND7GaBPtzbc30R68ECTYh9d5kJ/xBRzEOwx+QV2ZN7sdIRv2oLND80zVlSCwrXPA6Xio1pXnpQ2aHtpCtM5+jsaBmgI1auaXPzhMQT2a7jBMQyAEajuIOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476625; c=relaxed/simple;
	bh=oNWEH2KnMPXtRWECODQivviaS1rxECZkI/FN3JGzvNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePe1aoWrX9hOy0fJ+7PySQZs2IpDmANQYnMJLGh9wdLbKQzHAJgV+KJn/yKWy63Jtawb7KI9suTFsUwPrqC+SblEH5zKC8ljPw3TWQa87dLPmDVoVNqIUMWwHb2bXv16Rh3Oub2cowW8qkxwMCsBGBzGnMV0O/4abpoYAh+4QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SmouDq9P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SmouDq9P"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IL2AIh031436;
	Thu, 18 Apr 2024 21:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s+sd+GM8A1gkqW6SrlYO9H46f9pMSUoT1xNn0rWf4Cc=; b=Sm
	ouDq9PCv/cptZBprJLGUzvok/tzKpvtm+DIXeEjSuqusr+NLJwmTmpLLng0yKAuS
	xzrsdR4XEzMj/8n0qwVkKzozbsfi/xETVsj3+ZitkEBXfa0fOnTudiz2eqowwefX
	og1Vg+07920hm657/uwwih0YfLhYL41IOL/oJWcoi5bOZ9g0kp6qYp033g50iBh9
	JhLtjxuAch5oyFsiqG3MzNMgK7HwzpY0RP2OHWSbK7RXEB+uWxIQe43+RMY9ZXvl
	ntPGx39fpCHewWxhSSgbdy0tYVOXgKpW6tl06GN6ByIQpKi96jUTr/STWM86K64X
	ScWjjv0BMkcqlmYgOPdg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54j1at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 21:43:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ILha1c010320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 21:43:36 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 14:43:33 -0700
Message-ID: <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
Date: Fri, 19 Apr 2024 05:43:31 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CC: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <krzysztof.kozlowski@linaro.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NDUD0ga-CeXlXt6tgyay41zNhOhpepDU
X-Proofpoint-ORIG-GUID: NDUD0ga-CeXlXt6tgyay41zNhOhpepDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180156

On 4/19/2024 1:00 AM, Bartosz Golaszewski wrote:
> On Thu, 18 Apr 2024 at 16:06, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()") will cause serious regression issue for
>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>> QCA_QCA6390 and QCA_QCA2066, the regression issue is that BT can't be
>> enabled any more once BT is disabled if BT reset pin is not configured
>> by DT or ACPI.
>>
>> if BT reset pin is not configured, devm_gpiod_get_optional() will return
>> NULL, and we should NOT set quirk HCI_QUIRK_NON_PERSISTENT_SETUP, but the
>> reverted commit SET the quirk since NULL is not a error case, and cause
>> qca_setup() call failure triggered by the 2nd and later BT enable
>> operations since there are no available BT reset pin to clear BT firmware
>> downloaded by the 1st enable operation, fixed by reverting the commit.
>>
>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 92fa20f5ac7d..160175a23a49 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2323,7 +2323,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>
>>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>                                                GPIOD_OUT_LOW);
>> -               if (IS_ERR(qcadev->bt_en) &&
>> +               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
>>                     (data->soc_type == QCA_WCN6750 ||
>>                      data->soc_type == QCA_WCN6855)) {
>>                         dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>> @@ -2332,7 +2332,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>
>>                 qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>                                                GPIOD_IN);
>> -               if (IS_ERR(qcadev->sw_ctrl) &&
>> +               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
>>                     (data->soc_type == QCA_WCN6750 ||
>>                      data->soc_type == QCA_WCN6855 ||
>>                      data->soc_type == QCA_WCN7850))
>> @@ -2354,7 +2354,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>         default:
>>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>                                                GPIOD_OUT_LOW);
>> -               if (IS_ERR(qcadev->bt_en)) {
>> +               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>                         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>                         power_ctrl_enabled = false;
>>                 }
>> --
>> 2.7.4
>>
> 
> I told you under your yesterday's submission that you should instead
> consider bailing out from probe() if gpiod_get_optional() returns an
> error as right now if it returns EPROBE_DEFER (enable-gpios is there
> but the controller is not up yet), you will act like the GPIO was not
> even specified.
> 
> gpiod_get_optional() returns NULL if the GPIO property is not there or
> an error if anything else goes wrong. In the latter case, you should
> abort probe.
> 

1) do you meet the case that EPROBE_DEFER is returned ?

2) does the reverted change solve above issue you mentioned?

3) does the reverted change solve any functionality issue you actually meet ?

4) BT still is able to work fine by clearing the quirk even if getting preferred H/W reset way failure, why do we need to bail-out and return dev_err_probe() ?

we will fix it by right way if EPROBE_DEFER is reported.

this change is to solve the issue mentioned by commit message regardless other issues.
it is not possible for every commit to fix any other potential issues as long as the fix
doesn't introduce new issue.

right ?
> Bart

