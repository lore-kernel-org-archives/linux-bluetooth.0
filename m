Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86D1B4F3A;
	Wed,  4 Dec 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320064; cv=none; b=B/+beWrI9RDtYjc/DoH2WlFeHj9mohdIK8eMALRZS2WOO/pZAlvQN383+6ZPRX4Y1tVRWdLpkAhgYb5T+zqM1TGVAvJbMTd97uhm/zi0EE9lFB8okThpWdIuH/tHjsS3XmnVJS+2R8O7V0AoZNUjymVNfctwdEuk5eJhDcT0u04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320064; c=relaxed/simple;
	bh=c1bDgF6WhluWx6RoiHsYgUM2O5Pcds5u8V0qLFUFD4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eQY4Hk0w0RFnsWjHU3XJGKTTVsi0J+Q9zv0aaj8Om60IVtFaDV1vJxC9sKbCuCoaD3xWEm5e2FbL8TXKMMfnOv8zkIejJPsIh3hlLEUm0jJNE2ZUQiU0RU41MK+6ddSAxfEI8u3TeYWGHoQGWjhKnkNefnQytHiZKsB0tiNGnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2UAzbZR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2UAzbZR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B45A6rF010083;
	Wed, 4 Dec 2024 13:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yRacWDUhcGA+ZllPoX4yt0lZeffwWNX/rP8w2UjBzNk=; b=o2UAzbZRiZO/x0++
	Pl7zBfb4DfxUT331Huz08FSvNgu8kt0zkcF0jHqDSTqxCjzWLJ/jbLJqICJG89QG
	tQH+d+jFNPrJD269AulVdALWGnPEf45tVFVXL0wlnMx6soGraL0d2SMCXMe624qY
	rqoNubbPRniB9ZQsXW+RyxnPmXC5s9Rw/wngepckE7D34/fp1uE9FJvqAIZTuJDw
	TcmA/LFY3Ama23lJuW9mFoEu9Uss/HZo0rh5eO96BXQ+/0NOWfMiLB5+22qlPhwE
	MhOzTsu5Dxs/s4ipjitsLzaut9bfbRRasDXAYNfzLkgYpi7F5wfdkfufjCf0+lVu
	8WvZfQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a4by34s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 13:47:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4DlcFb030713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 13:47:38 GMT
Received: from [10.253.11.68] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Dec 2024
 05:47:36 -0800
Message-ID: <f96edd22-c7d1-4d83-96d6-8138fbb1ff71@quicinc.com>
Date: Wed, 4 Dec 2024 21:47:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: clear cmd_sync_work_list when
 power off
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
Content-Language: en-US
From: Jiayang Mao <quic_jiaymao@quicinc.com>
In-Reply-To: <CABBYNZJarA24Sy5qXKy77Jtnn+RBYhSg7Hxj9wUxENNvwkiyTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4mdBu1M420KY_EuwE0-w1Wtw6FyhYbo6
X-Proofpoint-ORIG-GUID: 4mdBu1M420KY_EuwE0-w1Wtw6FyhYbo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040105

Hi Luiz,

On 2024/12/4 1:28, Luiz Augusto von Dentz wrote:
> Hi Jiayang,
> 
> On Tue, Dec 3, 2024 at 12:19 PM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>
>> Hi Luiz,
>>
>> On 2024/12/3 4:41, Luiz Augusto von Dentz wrote:
>>> Hi Jiayang,
>>>
>>> On Mon, Nov 25, 2024 at 12:51 PM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>>>
>>>> Clear the remaining command in cmd_sync_work_list when BT is
>>>> performing power off. In some cases, this list is not empty after
>>>> power off. BT host will try to send more HCI commands.
>>>> This can cause unexpected results.
>>>
>>> What commands are in the queue?
>>
>> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
>> to be left in the queue. Then the driver will try to send the HCI
>> command of creating connection but failed.
> 
> There shouldn't be happening though:
> 
>      /* Terminated due to Power Off */
>      err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
>      if (err)
>          goto out;
> 
>      err = hci_dev_close_sync(hdev);
> 
> Perhaps there is something attempting to connect after
> hci_disconnect_all_sync has completed, in that case there is a bug
> around this sequence or we need to check HCI_POWERING_DOWN to not
> attempt to process the connection attempts.
> 
After pairing, an L2CAP channel is to be created by l2cap_sock_create
function. It eventually calls hci_connect_acl_sync, which adds
hci_acl_create_conn_sync to the cmd_sync_work_list.

The issue arises if BT is turned off after this addition but before
hci_acl_create_conn_sync is execute.

Your suggestion to check HCI_POWERING_DOWN seems more appropriate
for addressing this issue. We can try incorporating this check into
hci_acl_create_conn_sync.

>>>
>>>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
>>>> ---
>>>>    net/bluetooth/hci_sync.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>>> index c86f4e42e..bc622d074 100644
>>>> --- a/net/bluetooth/hci_sync.c
>>>> +++ b/net/bluetooth/hci_sync.c
>>>> @@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>>>    {
>>>>           bool auto_off;
>>>>           int err = 0;
>>>> +       struct hci_cmd_sync_work_entry *entry, *tmp;
>>>>
>>>>           bt_dev_dbg(hdev, "");
>>>>
>>>> @@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>>>           clear_bit(HCI_RUNNING, &hdev->flags);
>>>>           hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
>>>>
>>>> +       mutex_lock(&hdev->cmd_sync_work_lock);
>>>> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
>>>> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>>>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>>>
>>> Seems equivalent to hci_cmd_sync_clear, that said we should have been
>>> running with that lock already, also if there is a sequence like
>>> close/open the close may cancel the subsequent open, so I don't think
>>> we should be canceling every subsequent callback like this.
>>
>> In hci_cmd_sync_clear, the work cmd_sync_work and reenable_adv_work are
>> canceled. hci_cmd_sync_clear is not directly called because these two
>> works should not be canceled during power off.
>> Do you mean the added code should be moved to other functions to avoid
>> the risk of lock?
>>
>> Yes. This change lacks considering sequence of close/open. I will update
>> the implementation to ensure it does not remove the opening and the
>> operations after re-opening.
>>>
>>>>           /* After this point our queues are empty and no tasks are scheduled. */
>>>>           hdev->close(hdev);
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>
>>>
>>
> 
> 

