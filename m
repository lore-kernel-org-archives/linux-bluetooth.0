Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CE54776
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483395; cv=none; b=G0HYxAaMI4jzSLxRGmTXw0kYVjRLd36j3k7NNpQ0u+CTen4C2a5GcS+p5Z+X8PnU/RD1qZmD3cCNGEF17pUkA5egVgPu55tqOWLZB9HR9i98RUeLz6u9ccapbh6cBnsGc4g7KB0tdenL3kQr89QkT5p2VfXTKg244mqPDMtbyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483395; c=relaxed/simple;
	bh=8Xp6P/ykqaVCgIJvJoBVAl1zXrqrKIfHtE5RT86rC0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XtPfhvcHkoEU1H4M5/x3gXGEwM1q/Lhhc2ykdwKFUeJlPhQrj6zzfNoHvs9vRbLlVAKDzOvM31sLDVydXoe6KM/sTeU/qofRaSajgRRB4zKNQMU8CRGoMfTAih2YwyBQEAoh/82Nc6QjooTzG3DPdwhEHx++A2kBW8VNjB8BkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ARv3ClVO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ARv3ClVO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IMZ0QA012307;
	Thu, 18 Apr 2024 23:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oJncXBHtsxdbY7ArO4R1XA8kviAbl9g1+wt3UbZS+Tw=; b=AR
	v3ClVOvTDEy8G+AlTuHFG5YZC3CsRBfX8bX55YbXnYbARdCEIw8xUCEmpx0638c8
	hdFnNkZmQAT30TY5m+oq6w9jEdarBlFTzJGkW4e0lH+MTYsiCd+BcoYvcaVR0Fti
	5uMKAZcejfLvIsYCG7mDongv9rxdq+0bBVVG2KY+5h0RyG+w4TkOvplQDaUZ5gwV
	gXohrOBHxlbdsnEbE+xD1upK0RQZ2pxEAznikVT/NoFC11P+MAuLynbXkVVRMekO
	dePy9qi54cGqVEvFo6quzb1li5CK9veTlihGJh7PbzstcHxejPj6q13pi4Py3ryn
	ughEn7NnxJZ+458YiVVA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk155hrm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:36:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43INaOcH004147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:36:24 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 16:36:23 -0700
Message-ID: <d6aa48e7-ab87-4014-894e-5b6da4d42687@quicinc.com>
Date: Fri, 19 Apr 2024 07:36:20 +0800
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
 <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
 <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IifZA7Z0BFyPGQSWYCmTj8KqHAzcUXvh
X-Proofpoint-GUID: IifZA7Z0BFyPGQSWYCmTj8KqHAzcUXvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180170

On 4/19/2024 6:42 AM, Bartosz Golaszewski wrote:
> On Thu, 18 Apr 2024 at 23:43, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 4/19/2024 1:00 AM, Bartosz Golaszewski wrote:
>>> On Thu, 18 Apr 2024 at 16:06, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
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
>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
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
>>>>                 }
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> I told you under your yesterday's submission that you should instead
>>> consider bailing out from probe() if gpiod_get_optional() returns an
>>> error as right now if it returns EPROBE_DEFER (enable-gpios is there
>>> but the controller is not up yet), you will act like the GPIO was not
>>> even specified.
>>>
>>> gpiod_get_optional() returns NULL if the GPIO property is not there or
>>> an error if anything else goes wrong. In the latter case, you should
>>> abort probe.
>>>
>>
>> 1) do you meet the case that EPROBE_DEFER is returned ?
>>
> 
> It doesn't matter. It's about correct usage of a programming interface.
> 
>> 2) does the reverted change solve above issue you mentioned?
>>
> 
> What?
> 
the revert change means below change.
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")

>> 3) does the reverted change solve any functionality issue you actually meet ?
>>
> 
> What?
> 
see above.
>> 4) BT still is able to work fine by clearing the quirk even if getting preferred H/W reset way failure, why do we need to bail-out and return dev_err_probe() ?
>>
> 
> The only acceptable "failure" for gpiod_get_optional() is when it
> returns NULL. I should have fixed it when I sent the patch you're
> reverting but I didn't spot it right away. Proceeding on any other
> error makes no sense and will result in inconsistent behavior.
> 
as i ever explained. we need to treat NULL returning and error returning equivalently.

>> we will fix it by right way if EPROBE_DEFER is reported.
>>
> 
> What?
> 
will fix the issue if anyone meet and report they meet the error that EPROBE_DEFER is reported.
>> this change is to solve the issue mentioned by commit message regardless other issues.
>> it is not possible for every commit to fix any other potential issues as long as the fix
>> doesn't introduce new issue.
>>
> 
> What I mean is: don't revert a logically sound commit. Instead:
> improve the situation on top of it. In this case: bail out on error.
> And like Krzysztof said: right now the GPIO is required according to
> bindings so using gpiod_get_optional() doesn't even make sense as far
> as bindings go.
> 
my point is that it is not logically sound commit.
> Bart

