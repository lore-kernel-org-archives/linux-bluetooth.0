Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BF2054FE;
	Mon, 16 Dec 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356167; cv=none; b=DGMuI7DJ9RtvxXaS9YwmX44FMBDSkgLVwD0Vm4JagTX2ChrCb9BlryyvCqNcK2H9DSXYFYTrzk73C/Yiz0EfGYX78F8o/pEz4czyb3eTRgnoRncQr/HJbUKNNBnPG36l0bMVJe9h1nwl0x214LgAJA9u8UaNo87307uep+OrFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356167; c=relaxed/simple;
	bh=WyP7BzgYY7YGA+a0ILLeArWmBBHz47BFHlAp06/Vr8E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=q18GjiOU3xQHPLG5QTH0UWJ97h7hgFBv8wZQOHwCxEAk49FQM3ePh/sXhZiZbVvSR6DqVEKv0Oq7tIWs7uaGV99tdoUSFyeFfvE/R++Udwj/SUgSI0P4Syku1HH/AVgK3Q+tCi/KqWKV9L5RqAHoOYPmXVXKR30EdFM2stidDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gGB6biMD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gGB6biMD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBLi4L026769;
	Mon, 16 Dec 2024 13:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ytcw+NCskfRTmLBds1Ot3cdlcldMD7z44DgB0WOj1Ak=; b=gGB6biMDbJY9xyK7
	2BlNK6b/OruZd+h+PzCCUxTmtNQGgnmPRQ3sCV3FqSq5O7lryul3ZDQ3YQw2SKBV
	qYzKWA0Ieubq6BfjrlxHA6J2YMQIY9L2pIy0wK/6If0TDEpdir+dIT6c5UD/pumw
	dxIGXpNkafK0lrYayJWHESoTHTDDkNFLlyu37ptqiWQPUm/9Pvkro+HNjWapCl2I
	locG8ETl3uqE+olURsoInA5+epwbpfqIzR7ERBCPE+XHBHIuapv4yseCPPcVDThb
	jxUEgFKSQMdfFy6+p0k53gUQ5VNwg/vUzSdJoq1QIv0VNh87aLVzeYB8hJ/neq01
	wLC6lA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jk8grca2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 13:36:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BGDa1Gv009387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 13:36:01 GMT
Received: from [10.253.36.176] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 05:35:59 -0800
Message-ID: <9be4f9c2-bf10-4bd2-ad56-40684f4fb5c3@quicinc.com>
Date: Mon, 16 Dec 2024 21:35:56 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: clear cmd_sync_work_list when
 power off
From: Jiayang Mao <quic_jiaymao@quicinc.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_chejiang@quicinc.com>, <quic_shuaz@quicinc.com>
References: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
 <CABBYNZLY_PAA0jPiHwGKUmdd3SKqwViLSHAkNHH0=trdqrDRnQ@mail.gmail.com>
 <8107a53f-5967-461b-8c89-773096a316d1@quicinc.com>
 <CABBYNZJarA24Sy5qXKy77Jtnn+RBYhSg7Hxj9wUxENNvwkiyTg@mail.gmail.com>
 <f96edd22-c7d1-4d83-96d6-8138fbb1ff71@quicinc.com>
Content-Language: en-US
In-Reply-To: <f96edd22-c7d1-4d83-96d6-8138fbb1ff71@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PFGyh9t2_qUzWqJvmCciqnL6dQ7-pkmf
X-Proofpoint-ORIG-GUID: PFGyh9t2_qUzWqJvmCciqnL6dQ7-pkmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160114

Hi Luiz,

On 2024/12/4 21:47, Jiayang Mao wrote:
> Hi Luiz,
> 
> On 2024/12/4 1:28, Luiz Augusto von Dentz wrote:
>> Hi Jiayang,
>>
>> On Tue, Dec 3, 2024 at 12:19 PM Jiayang Mao <quic_jiaymao@quicinc.com> 
>> wrote:
>>>
>>> Hi Luiz,
>>>
>>> On 2024/12/3 4:41, Luiz Augusto von Dentz wrote:
>>>> Hi Jiayang,
>>>>
>>>> On Mon, Nov 25, 2024 at 12:51 PM Jiayang Mao 
>>>> <quic_jiaymao@quicinc.com> wrote:
>>>>>
>>>>> Clear the remaining command in cmd_sync_work_list when BT is
>>>>> performing power off. In some cases, this list is not empty after
>>>>> power off. BT host will try to send more HCI commands.
>>>>> This can cause unexpected results.
>>>>
>>>> What commands are in the queue?
>>>
>>> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
>>> to be left in the queue. Then the driver will try to send the HCI
>>> command of creating connection but failed.
>>
>> There shouldn't be happening though:
>>
>>      /* Terminated due to Power Off */
>>      err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
>>      if (err)
>>          goto out;
>>
>>      err = hci_dev_close_sync(hdev);
>>
>> Perhaps there is something attempting to connect after
>> hci_disconnect_all_sync has completed, in that case there is a bug
>> around this sequence or we need to check HCI_POWERING_DOWN to not
>> attempt to process the connection attempts.
>>
> After pairing, an L2CAP channel is to be created by l2cap_sock_create
> function. It eventually calls hci_connect_acl_sync, which adds
> hci_acl_create_conn_sync to the cmd_sync_work_list.
> 
> The issue arises if BT is turned off after this addition but before
> hci_acl_create_conn_sync is execute.
> 
> Your suggestion to check HCI_POWERING_DOWN seems more appropriate
> for addressing this issue. We can try incorporating this check into
> hci_acl_create_conn_sync.

Thank you for your attention to this matter. Could you please help to
check my reply? Please let me know if there are any other concerns, or
if I should submit another change to check HCI_POWERING_DOWN in
hci_acl_create_conn_sync.
> 
>>>>
>>>>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
>>>>> ---
>>>>>    net/bluetooth/hci_sync.c | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>>>> index c86f4e42e..bc622d074 100644
>>>>> --- a/net/bluetooth/hci_sync.c
>>>>> +++ b/net/bluetooth/hci_sync.c
>>>>> @@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>>>>    {
>>>>>           bool auto_off;
>>>>>           int err = 0;
>>>>> +       struct hci_cmd_sync_work_entry *entry, *tmp;
>>>>>
>>>>>           bt_dev_dbg(hdev, "");
>>>>>
>>>>> @@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>>>>           clear_bit(HCI_RUNNING, &hdev->flags);
>>>>>           hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
>>>>>
>>>>> +       mutex_lock(&hdev->cmd_sync_work_lock);
>>>>> +       list_for_each_entry_safe(entry, tmp, &hdev- 
>>>>> >cmd_sync_work_list, list)
>>>>> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>>>>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>>>>
>>>> Seems equivalent to hci_cmd_sync_clear, that said we should have been
>>>> running with that lock already, also if there is a sequence like
>>>> close/open the close may cancel the subsequent open, so I don't think
>>>> we should be canceling every subsequent callback like this.
>>>
>>> In hci_cmd_sync_clear, the work cmd_sync_work and reenable_adv_work are
>>> canceled. hci_cmd_sync_clear is not directly called because these two
>>> works should not be canceled during power off.
>>> Do you mean the added code should be moved to other functions to avoid
>>> the risk of lock?
>>>
>>> Yes. This change lacks considering sequence of close/open. I will update
>>> the implementation to ensure it does not remove the opening and the
>>> operations after re-opening.
>>>>
>>>>>           /* After this point our queues are empty and no tasks are 
>>>>> scheduled. */
>>>>>           hdev->close(hdev);
>>>>>
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>
>>>>
>>>
>>
>>
> 
Thanks,
Jiayang Mao
