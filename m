Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2B382
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399750; cv=none; b=ipLTDMkQ3LuCzZ8jtvr1QnDhIWpzA43xVgobze3q93MHkTXYsXMthNilcDG/xABAqx8niMIIN/ddulNTWAeJ0+yBm8qFSg142deS36cgqhDbSkghGJZw6RW0K3Vu9ZYNsudZmf+BhRqDiLY+X2UWLLwgo8hiJJDymIYPOjfg0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399750; c=relaxed/simple;
	bh=aVRhMfrMs6zqE7BBplpzqSlaTRPKrn+MOQKeph925pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qh+6P9Ajn6BmbnEL5/Je21wSjGThX6BKwCakPtgE6WW2+0CZCGepSnl9w9va3IsuOFteIr/Lw2CyGoRuN3O7X49o7hOcvTNNwYtT2xjy0x38s7jmqsrQwg52d39zKS5tiFXJPWi5zWugMnlw3T/fjC/ls0+UJtir3FEGmTLE3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dcVbaxWP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dcVbaxWP"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNGFlo024501;
	Thu, 18 Apr 2024 00:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J8IsceMSh6IU3FpZ6Ng0Z7Vy5oRCMA3KVbtsaw6misI=; b=dc
	VbaxWPXCsHmLp6M983os7saQy9lfIVwuXacJhRYjB0LUC4yIKYGd6xCr1yNdCNDq
	ywnNw3IfRAZEdsRYS+RvfgRNmb36D3Pzkn+JWzul0KSXsOHg15gZPWQktYTntbtH
	GV32jdOzxUlkOm1EwsMaHx+2GjieWn/KkE3VeDV78VdxCu7QPdv41o3ZAgRr3R0Z
	MyCw3unrPjTmqNq/Rr9200P9cHzk85YIlno4qziEF/TBkalxtHypuTaXJiW3eYQT
	ejkgKZhJwLyIoSs9dNxHpxnbQnsAQ2PbuMpdQttzZRD/gwbx1WR9Lysua9DteST7
	bswNNce9LUC75HxOTqHQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9w5ahcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:22:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I0MKHC004314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:22:20 GMT
Received: from [10.253.9.153] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 17:22:19 -0700
Message-ID: <c84b2259-9817-46b9-acde-2de1b7184657@quicinc.com>
Date: Thu, 18 Apr 2024 08:22:16 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
 with gpiod_get_optional()"
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CC: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>
References: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSeuQMz-JCK7tqiQCmt7z37L1UncNK0un28JHAa8qRhnp-g@mail.gmail.com>
 <59a1921a-343a-46cb-9a9c-6a18f63a02b3@quicinc.com>
 <CACMJSet_SKVPV74AKz52LRH1PaxzF4gaFbdayCYNVW7Xt-5mnA@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSet_SKVPV74AKz52LRH1PaxzF4gaFbdayCYNVW7Xt-5mnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AjRsCjjJqilJ_QV8eSXXwTtG5IgMYBnw
X-Proofpoint-GUID: AjRsCjjJqilJ_QV8eSXXwTtG5IgMYBnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_19,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180001

On 4/18/2024 8:01 AM, Bartosz Golaszewski wrote:
> On Thu, 18 Apr 2024 at 01:44, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 4/18/2024 2:59 AM, Bartosz Golaszewski wrote:
>>> On Wed, 17 Apr 2024 at 13:53, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>>>
>>>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>>>
>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>> with gpiod_get_optional()") will cause serious regression issue for
>>>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>>>> QCA_QCA6390 and QCA_QCA2066, the regression issue is that BT can't be
>>>> enabled any more once BT is disabled if BT reset pin is not configured
>>>> by DT or ACPI.
>>>>
>>>> if BT reset pin is not configured, devm_gpiod_get_optional() will return
>>>> NULL, and we should NOT set quirk HCI_QUIRK_NON_PERSISTENT_SETUP, but the
>>>> reverted commit SET the quirk since NULL is not a error case, and cause
>>>> qca_setup() call failure triggered by the 2nd and later BT enable
>>>> operations since there are no available BT reset pin to clear BT firmware
>>>> downloaded by the 1st enable operation, fixed by reverting the commit.
>>>>
>>>
>>> Then you just go back to bad usage of the GPIO API. Please see my
>>> suggestion below.
>>>
>> we need to treat below tow cases equivalently.
>> 1) BT reset pin is NOT configured, devm_gpiod_get_optional() return NULL.
>> 2) BT reset pin is configured, but failed to be got, devm_gpiod_get_optional() return ERROR.
>>
>> FOR above two cases, hci_qca driver doesn't get available BT reset pin for H/W reset.
>> so we use IS_ERR_OR_NULL() instead of IS_ERR().
>>
>> is it not right ?
>>
>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/bluetooth/hci_qca.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index 92fa20f5ac7d..160175a23a49 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -2323,7 +2323,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>
>>>>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>                                                GPIOD_OUT_LOW);
>>>> -               if (IS_ERR(qcadev->bt_en) &&
>>>> +               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
>>>>                     (data->soc_type == QCA_WCN6750 ||
>>>>                      data->soc_type == QCA_WCN6855)) {
>>>>                         dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>>>> @@ -2332,7 +2332,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>
>>>>                 qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>>>                                                GPIOD_IN);
>>>> -               if (IS_ERR(qcadev->sw_ctrl) &&
>>>> +               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
>>>>                     (data->soc_type == QCA_WCN6750 ||
>>>>                      data->soc_type == QCA_WCN6855 ||
>>>>                      data->soc_type == QCA_WCN7850))
>>>> @@ -2354,7 +2354,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>         default:
>>>>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>                                                GPIOD_OUT_LOW);
>>>> -               if (IS_ERR(qcadev->bt_en)) {
>>>> +               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>                         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>                         power_ctrl_enabled = false;
>>>
>>> Can you just move this out of this block? Or just simply check the
>>> presence of the GPIO descriptor in the if block setting the quirk bit?
>>> Warning on a missing *optional* GPIO is wrong. It's not an unexpected
>>> situation, it's normal.
>>>
>> your concern is that the prompt message is printed by wrong way or the prompt message is not precise.
>> is it right ?
>>
> 
> Actually now that you're saying this: if gpiod_get_optional() returns
> IS_ERR() then we should bail-out and return dev_err_probe(), not
> proceed. What if GPIOLIB returns EPROBE_DEFER? Only NULL is an
> acceptable return value from gpiod_get_optional().
> 
1)  "you're saying this" or "i am saying this" ? is it a typo error?
2)  BT still is able to work by clearing the quirk even if getting preferred H/W reset way failure, why need to bail-out and return dev_err_probe() ?
3)  are you sumbit the change because you meet any functionality issues?
4)  do you meet the case that EPROBE_DEFER is returned ?, are your change is to fix the EPROBE_DEFER case ? if so, your fix is not right.
> Bart
> 
>>> Bartosz
>>>
>>>>                 }
>>>> --
>>>> 2.7.4
>>>>
>>

