Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE75255E2F
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214204; cv=none; b=k7ulENtz7bhFT8abKAuHxFWb9uqlthDf/54uCxwiGvxq0gXte3qFJHVDSPcsnsTfZv+QUgt4sk48Qo0hUUW6jqPEbBKeWjEYXL6l5ce6rUEDreEK87jKKAvQYGb4jdHXQiZZfVtN3MmXZ1G4SvKaEVRG7NUGz9NRfkVPw33TQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214204; c=relaxed/simple;
	bh=cSCdtKFlVQ9jFnXMlsjyWoU/NjOG+TuBKvqGSLO3MCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tLe0af2qPfFvr7ZMo2qqNZHxC7cXI9XZeGIBYINWFBtb0FVaayL0vtK5gRzIu9Kxt7qKdUe4gyfOADhuYfg6rckGVs2vK7me48OLMOmQ6GuJ0ltDdJ3Ouk6MGkvvIMqplaQ6IG+qG2owC13es31Dx46C5Hah15QpaQEpCphVzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JkxxpYz2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JkxxpYz2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMWr4O007614;
	Mon, 21 Apr 2025 05:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4o+/ga4/DyKy0UZUjNXefRvcBd70eKJFQHv08NoIFw=; b=JkxxpYz2C5wC9Kw6
	X29kMS9cwCfCsZF3nBql10TdoVvkEhESvljQCQ+pUfi+AZpdyEko5+/CvBOJVtXe
	bS10CMYJy4wUDysSK+JHtH4Mefo5mtNj05BIEPtuGomnhP9CXRPxFcwmzN99OuJ0
	z/sBTu/CiTgWRWRBbIvir/lI/t2Sk/42RE9S3tLk3B+NCqlc2iMlwSUMTYGmN9Hu
	lRsOzoanJ0Gf5TIsIcf4vjiohcftoz8UAu+pSvwYRmin0tSdeqZKXkyvj/sQAQvc
	Frc47jjqcocEY7zo7dmHMDHanpApdzWEbwgLzHtIdIUeTQWC1bU/GJRiiRngJ701
	RQlCqg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464478u49r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 05:43:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53L5hJ7Q026547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 05:43:19 GMT
Received: from [10.253.72.235] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 20 Apr
 2025 22:43:18 -0700
Message-ID: <fb82d491-518b-412f-9f18-3cc5d3858b7d@quicinc.com>
Date: Mon, 21 Apr 2025 13:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not clearing
 cmd_sync_work_list on power off
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <20250409135402.212535-1-luiz.dentz@gmail.com>
 <CABBYNZKOUYLWxMx-dokfH0J7fAsi0Rp2LiKM7qB8E5OCuzY3Ug@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <CABBYNZKOUYLWxMx-dokfH0J7fAsi0Rp2LiKM7qB8E5OCuzY3Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BWw4-GANvmasiR7OkFURUqZXc-brXZuM
X-Authority-Analysis: v=2.4 cv=CYgI5Krl c=1 sm=1 tr=0 ts=6805daf8 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=047R5PHfBdm35bCd7vQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BWw4-GANvmasiR7OkFURUqZXc-brXZuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504210042

Dear Luiz

On 2025/4/9 21:55, Luiz Augusto von Dentz wrote:
> On Wed, Apr 9, 2025 at 9:54 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> When powering off the cmd_sync_work_list may contain items which shall
>> be cleared during power off as they shouldn't be run during power off
>> sequence.
>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>>  net/bluetooth/hci_sync.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index 609b035e5c90..7a822ef71a74 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -648,16 +648,22 @@ static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
>>         kfree(entry);
>>  }
>>
>> -void hci_cmd_sync_clear(struct hci_dev *hdev)
>> +/* Clear remaining entries in cmd_sync_work_list */
>> +static void hci_cmd_sync_list_clear(struct hci_dev *hdev)
>>  {
>>         struct hci_cmd_sync_work_entry *entry, *tmp;
>>
>> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
>> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>> +}
>> +
>> +void hci_cmd_sync_clear(struct hci_dev *hdev)
>> +{
>>         cancel_work_sync(&hdev->cmd_sync_work);
>>         cancel_work_sync(&hdev->reenable_adv_work);
>>
>>         mutex_lock(&hdev->cmd_sync_work_lock);
>> -       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
>> -               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>> +       hci_cmd_sync_list_clear(hdev);
>>         mutex_unlock(&hdev->cmd_sync_work_lock);
>>  }
>>
>> @@ -678,6 +684,7 @@ EXPORT_SYMBOL(hci_cmd_sync_cancel);
>>   *
>>   * - Set result and mark status to HCI_REQ_CANCELED
>>   * - Wakeup command sync thread
>> + * - Clear cmd_sync_work_list if the interface is down
>>   */
>>  void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>>  {
>> @@ -692,6 +699,9 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>>
>>                 wake_up_interruptible(&hdev->req_wait_q);
>>         }
>> +
>> +       if (err == EHOSTDOWN || err == -EHOSTDOWN)
>> +               hci_cmd_sync_list_clear(hdev);
>>  }
>>  EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
>>
>> @@ -5159,14 +5169,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>                 disable_delayed_work(&hdev->power_off);
>>                 disable_delayed_work(&hdev->ncmd_timer);
>>                 disable_delayed_work(&hdev->le_scan_disable);
>> +               hci_cmd_sync_cancel_sync(hdev, ENODEV);
>>         } else {
>>                 cancel_delayed_work(&hdev->power_off);
>>                 cancel_delayed_work(&hdev->ncmd_timer);
>>                 cancel_delayed_work(&hdev->le_scan_disable);
>> +               hci_cmd_sync_cancel_sync(hdev, EHOSTDOWN);
>>         }
>>
>> -       hci_cmd_sync_cancel_sync(hdev, ENODEV);
>> -
>>         cancel_interleave_scan(hdev);
>>
>>         if (hdev->adv_instance_timeout) {
>> --
>> 2.49.0
> 
> Have a try with the above changes.
> 
I've applied the above changes and it's passed for this case. nice! 
May I ask if it was you who submitted this change or was it me? 

