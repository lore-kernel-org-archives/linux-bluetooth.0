Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFEA31;
	Wed, 21 Aug 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223502; cv=none; b=gK/2XCNZ1FGj6c2qJRp10XkjlLx0siWZ90Hy7U/mxaBcmpghRMGnj1xSEqB5Dq9cF5cI0VvhVZI5iL7fMfwxexv85ZiK9/zXYpIKNa6f9IsxbQpj9lJ6Q7NFsRnlKjjFBQzRm004YaB2Fb8GWZgWIkafrhxZcifDRbB52r+NNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223502; c=relaxed/simple;
	bh=Cop5p7boT2EE+AxgDMbqrgdM0XlEYff5/dt9xq2skhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DkbIMLw0LXYmoKl4WnQWWZiXEN6D3H+u7OvSDr6//EnW7OUF6JyHiBgJthH5dAFEZI4jd81bz1mB+sNm4iwuxr8jEt2Do/zWqpuPkUpYy4xtHObMCprn/68F9l168mxfabE4/eJwf8IDYaFB2lheNBoCw9X1XZxl9GtEMuDuJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WelqQAg+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WelqQAg+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5I4oK029023;
	Wed, 21 Aug 2024 06:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NBhRVgyCiBQiJkjdRk9oouBxqES1gSxUghHSCnA/ZlI=; b=WelqQAg+Pdw8YyyI
	PJKjPcNBOALUY3AmGrY2E5LMyYz+xjsOj06c/7/FloPiN3aDW4eHnAzaTvrumJHG
	R9HJuYohY5BEib10z8C05K9c+ksRsEGmXZX2Erun4GXhzqzcjAQothsbRRs49c/Y
	fLXrShGHgqP7QOGB/PRmOrAn49uMfNZBMwVaAzdtod35GbevnYhtKIF+ZhlqKNQS
	STnQhAapgRLa/Rl1FRrtTLKRqrCuMK9oUd/o2trKbiq3nxNSrnYTYlw2gfu6m2Ul
	KbsMSKpA2ibAgLP1FoPMfvIv0vWK3ZtH8U2e47SMC/XE/6MvQKFhzz3bsJ6GhCNA
	jjNhdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4159yj8ark-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 06:58:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L6w5jF015667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 06:58:05 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 23:58:03 -0700
Message-ID: <c3ed299e-709e-4fae-9ef6-c5ad2f6a1c55@quicinc.com>
Date: Wed, 21 Aug 2024 14:58:01 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Drop unused event during BT on
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
 <15472cea-904c-4d79-9195-3063ce7f1e2e@quicinc.com>
 <2be3922d-8899-4e58-aa23-57a0b5cfc111@molgen.mpg.de>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <2be3922d-8899-4e58-aa23-57a0b5cfc111@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zwTOqGtz_aqLg2ux2UVl0IweSP5wpuJX
X-Proofpoint-GUID: zwTOqGtz_aqLg2ux2UVl0IweSP5wpuJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210049

Hi Paul, 

Thank you for the comment. 

On 8/21/2024 12:49 PM, Paul Menzel wrote:
> Dear Cheng,
> 
> 
> Thank you for your patch.
> 
> Am 21.08.24 um 06:16 schrieb Cheng Jiang:
> 
>> Is there any comment for the changes? Thanks!
>>
>> On 7/26/2024 5:58 PM, Cheng Jiang wrote:
>>> For the WCN6750/WCN6855/WCN7850, the vendor command for a baudrate
>>> change is not sent as synchronous HCI command, controller sends the
>>> corresponding vendor event with the new baudrate. It needs to be
>>> dropped, otherwise it may be misinterpreted as response to a later
>>> command.
> 
> Is that documented in some datasheet?
It's defined in 80-WL520-14_REV_F_Bluetooth_HCI_Vendor_Specific_Commands_Application_Note.pdf. 
> 
> How can this behavior be tested, and your change be verified? How did you test it?
From the dmegs log, we can find the "Bluetooth: hci0: unexpected event for opcode 0xfc48" in dmesg. The change
is verified on QCOM's platform. Check the log is disappeared in dmesg when boot up the system.  
> 
>>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
>>> ---
>>>   drivers/bluetooth/hci_qca.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index ca6466676902..f497d601e035 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1206,7 +1206,15 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>>>            * vendor command).
>>>            */
>>>   -        if (hdr->evt == HCI_EV_VENDOR)
>>> +        /* For the WCN6750/WCN6855/WCN7850, like the WCN3990, the
> 
> Does “like the” mean “and” in this situation? WCN3990 is not mentioned in the commit message.
WCN3990 is already handled in the exist code. WCN3990 uses HCI_EV_VENDOR (0xff) as event code while
WCN6750/WCN6855/WCN7850 use HCI_EV_CMD_COMPLETE(0x0e). The logic of handling this event is almost the
same.
> 
>>> +         * vendor command for a baudrate change command isn't sent as
>>> +         * synchronous HCI command, the controller sends the corresponding
>>> +         * command complete event with the new baudrate. The event is
>>> +         * received and properly decoded after changing the baudrate of
>>> +         * the host port. It needs to be dropped.
>>> +         */
>>> +
> 
> It’d remove the blank line.
Will remove in next patch. 
> 
>>> +        if (hdr->evt == HCI_EV_VENDOR || hdr->evt == HCI_EV_CMD_COMPLETE)
>>>               complete(&qca->drop_ev_comp);
> 
> Excuse my ignorance. Is `HCI_EV_CMD_COMPLETE` only sent in case of a baudrate change?
HCI_EV_CMD_COMPLETE is also sent for other HCI command. This section is called only if QCA_DROP_VENDOR_EVENT is
set. QCA_DROP_VENDOR_EVENT is set before sending the baudrate change HCI command, and cleared after received 
the event or timeout happens. So only the event for baudrate change HCI command is dropped here. 
> 
>>>           kfree_skb(skb);
>>> @@ -1497,6 +1505,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>>             switch (soc_type) {
>>>           case QCA_WCN3990:
>>> +        case QCA_WCN6750:
>>> +        case QCA_WCN6855:
>>> +        case QCA_WCN7850:
> 
> So setting the speed wasn’t working before?
It works before, but the event of baudrate change HCI command is not handled properly. Here is used to set
the QCA_DROP_VENDOR_EVENT flags and reinit completion. They will be used when handling event from controller.
> 
>>>               reinit_completion(&qca->drop_ev_comp);
>>>               set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
>>>               break;
>>> @@ -1531,6 +1542,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>>             switch (soc_type) {
>>>           case QCA_WCN3990:
>>> +        case QCA_WCN6750:
>>> +        case QCA_WCN6855:
>>> +        case QCA_WCN7850:
>>>               /* Wait for the controller to send the vendor event
>>>                * for the baudrate change command.
>>>                */
> 
> 
> Kind regards,
> 
> Paul

