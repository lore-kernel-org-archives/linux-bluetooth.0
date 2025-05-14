Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB919C558
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208394; cv=none; b=lO588933zXzhnba7gzT7V9f3chXCJiXAen2Cz/EWMTcwGMIIN3CHWyF2zckU5THKq86zSQ4D2kax4wVPCm4h8GmSnjrA7DvN4EZzLi5uUHYH4cNzd+fq6SqQuhoOjdQZJDk0mhHp5xDVXYr8H3fN9YdK5Q7j+2ekYMzF7Az/feY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208394; c=relaxed/simple;
	bh=oKwLJIHK4K4cPDG14FRc4VaiVaL5KeDP3GLgna4vliY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BvZh4TJWp7Xig5YAqQhN1DC3h/RODRt9obhRguKsmTo985mGVwypV56eDDg+UKQPlda0xy+0Ir9xV/idSLnoX9IZvX+naT/afOIpte7kS90wd4gkBLYBoS8TvEE9tse8v5y3itPs24WZ638yO/xwglLpZ+Z79X1zN8yc6lw9sTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WVvLFgCA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WVvLFgCA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E1dTkR000754;
	Wed, 14 May 2025 07:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MtYe50Ea09TsaZZHeQ5MgUs3wLJI9Iljd+MU8yay9lU=; b=WVvLFgCAxsSZvZlA
	6qsN7q1joV4F//lYBRZEmKU8FAAzaXdIjVN5148gpxVaDiBmkPMAMQjOu3623FIt
	CCl7J1lekeLVUpUsgggWqxDHxAy6VaPnEUu79trwprWF1hZ6stmpb+ZwIDb11SqK
	sR46LhxszsTXlvs/Nc+ieJgvuw/LqHuZfFeLzvRCOvERzhlovY8lZAXHJ+xifC3t
	dG4W+uiqONgBeD5FPrB+Ckljrv3fr4pH20b59eQKcpWwSN7Pwee/PIr3H6yNKM5o
	Kem4R1vqwQE7Z0u8R187WdrCQhHkjHXJ9m9CJf4r3N0LDlp6BeSrMcihr3h5IOkD
	+pGyQg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr9taa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 07:39:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54E7do0N007151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 07:39:50 GMT
Received: from [10.253.76.179] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 May
 2025 00:39:49 -0700
Message-ID: <be6c5a69-dd8a-44a2-baa2-971a753a98a4@quicinc.com>
Date: Wed, 14 May 2025 15:39:46 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not clearing
 cmd_sync_work_list on power off
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <20250409135402.212535-1-luiz.dentz@gmail.com>
 <CABBYNZKOUYLWxMx-dokfH0J7fAsi0Rp2LiKM7qB8E5OCuzY3Ug@mail.gmail.com>
 <fb82d491-518b-412f-9f18-3cc5d3858b7d@quicinc.com>
Content-Language: en-US
In-Reply-To: <fb82d491-518b-412f-9f18-3cc5d3858b7d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UHN0iO4fS_-1hEIrixWvgDPW3zC_HFDi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2NSBTYWx0ZWRfX0JVEiWpimJAe
 JL8FVk78xNS9qUaJQBjud7EKr2JpjgM85rOry1f4A699RMtgp1OJmkOAAH57dsy45ykPfxY/9lb
 8ZoetUQZbgsLQIQzyz8cI1A0oQk/z0n9HLA+wEnHz4F0MOKbdHOp4vtHgKUFGSHjpqCmS2F9HaJ
 NK70vjkoY5Tw2snF2b4qZWge8q/UwExlUeQWrHARW0c7MbWBvDXIumHxVHsJQ83SQfynhNaXY6x
 1QGPpIc3YnYQ+4sifYo/IXJ7Ihrn2qOzav8ZnUFIRcCfIi2fxFqZIYieUpOdLZ5DWNzMjVaV7do
 /1hCTSaFzImeV+dTC7GlSc3ZCYOTR2/TFkWPa4QseVfuUC8uvkaSz9g+Y1NGupHKuXKRGdtmZ5m
 7vyxQYzghx23IagFznpLdG/BpmWUFONpNf4GOUS07Lx4FgwLndMkEENLBjulDp0Y0yXft/Gl
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=682448c7 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=6OpGlENfWYVAC2iqtWgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UHN0iO4fS_-1hEIrixWvgDPW3zC_HFDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140065

Dear Luiz

On 2025/4/21 13:43, Shuai Zhang wrote:
> Dear Luiz
> 
> On 2025/4/9 21:55, Luiz Augusto von Dentz wrote:
>> On Wed, Apr 9, 2025 at 9:54 AM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>>
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> When powering off the cmd_sync_work_list may contain items which shall
>>> be cleared during power off as they shouldn't be run during power off
>>> sequence.
>>>
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>>  net/bluetooth/hci_sync.c | 20 +++++++++++++++-----
>>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>> index 609b035e5c90..7a822ef71a74 100644
>>> --- a/net/bluetooth/hci_sync.c
>>> +++ b/net/bluetooth/hci_sync.c
>>> @@ -648,16 +648,22 @@ static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
>>>         kfree(entry);
>>>  }
>>>
>>> -void hci_cmd_sync_clear(struct hci_dev *hdev)
>>> +/* Clear remaining entries in cmd_sync_work_list */
>>> +static void hci_cmd_sync_list_clear(struct hci_dev *hdev)
>>>  {
>>>         struct hci_cmd_sync_work_entry *entry, *tmp;
>>>
>>> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
>>> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>>> +}
>>> +
>>> +void hci_cmd_sync_clear(struct hci_dev *hdev)
>>> +{
>>>         cancel_work_sync(&hdev->cmd_sync_work);
>>>         cancel_work_sync(&hdev->reenable_adv_work);
>>>
>>>         mutex_lock(&hdev->cmd_sync_work_lock);
>>> -       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
>>> -               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>>> +       hci_cmd_sync_list_clear(hdev);
>>>         mutex_unlock(&hdev->cmd_sync_work_lock);
>>>  }
>>>
>>> @@ -678,6 +684,7 @@ EXPORT_SYMBOL(hci_cmd_sync_cancel);
>>>   *
>>>   * - Set result and mark status to HCI_REQ_CANCELED
>>>   * - Wakeup command sync thread
>>> + * - Clear cmd_sync_work_list if the interface is down
>>>   */
>>>  void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>>>  {
>>> @@ -692,6 +699,9 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>>>
>>>                 wake_up_interruptible(&hdev->req_wait_q);
>>>         }
>>> +
>>> +       if (err == EHOSTDOWN || err == -EHOSTDOWN)
>>> +               hci_cmd_sync_list_clear(hdev);
>>>  }
>>>  EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
>>>
>>> @@ -5159,14 +5169,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>>                 disable_delayed_work(&hdev->power_off);
>>>                 disable_delayed_work(&hdev->ncmd_timer);
>>>                 disable_delayed_work(&hdev->le_scan_disable);
>>> +               hci_cmd_sync_cancel_sync(hdev, ENODEV);
>>>         } else {
>>>                 cancel_delayed_work(&hdev->power_off);
>>>                 cancel_delayed_work(&hdev->ncmd_timer);
>>>                 cancel_delayed_work(&hdev->le_scan_disable);
>>> +               hci_cmd_sync_cancel_sync(hdev, EHOSTDOWN);
>>>         }
>>>
>>> -       hci_cmd_sync_cancel_sync(hdev, ENODEV);
>>> -
>>>         cancel_interleave_scan(hdev);
>>>
>>>         if (hdev->adv_instance_timeout) {
>>> --
>>> 2.49.0
>>
>> Have a try with the above changes.
>>
> I've applied the above changes and it's passed for this case. nice! 
> May I ask if it was you who submitted this change or was it me? 
> 
May I inquire what your thoughts are? If you have any questions, 
please let me know.


thanks,
Shuai

