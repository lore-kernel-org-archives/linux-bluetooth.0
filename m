Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE41F8EE3;
	Tue,  3 Dec 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246386; cv=none; b=ifDDxHGrVwXil4RgOmG//Tmxdan67xsbWWDh66xVkt6bGtSwaUgPaXqyUPH8NcQkK+nE3bd6JX7XZQ5nNIcNFHuds8iYgt+b5gprv5lftKiAKMCRqiapeH5WwxiCX33fGpZqZsZ5WgUV+xT30COdDY1SrjDCM4umxBST7/MF0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246386; c=relaxed/simple;
	bh=vI2Y41B4eSxt4ShVp6IB70gQDts0zC7SctHdFa3iT9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WZxE6p9yoenSKUOvCvINcI4iJ9X4hX5CIXAWwXH/dTVQpuSWZMJmv2X59CABicCcnAu6XfQ/wSDCenV6dod9x7fsw1gG4PpAm6iEl+0YPrBAW8wHTz+TgGXf8nmRYx8GdFRVAIveIZwBMlbWizsINRlLmbHP9gbvSf61x0iCr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SsM3N+IC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SsM3N+IC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B39qiVd026044;
	Tue, 3 Dec 2024 17:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XX0dL3F2Ta8HItYyJqeOeTw3Nm6TpiJq8N8Zg6ju370=; b=SsM3N+IC3fzdp2MC
	3VPv7r8AWh6We/DwZIxDwXz99XJuFOgvm3Syv+YA0X02uiwuh3qC+agAViFwnGoI
	PNynbi7UkHowCORYajrPhp3kH65/vXhSS3uzqdgy1daap5UFMrCHjFyfPX/91i/v
	SnSAuDVt07eS/BO4XBSS8Irrfa07ym8+KWRPtPt8WtdTyKlUYkdLGEjOOa4T6fDU
	KtkRzkLKCl/QmhdQbjQE+XbbGT864qc04eqv6zF3BgtfkOeUv4L2Nn1djTnM16wc
	idchoN1WS3wDOSjsa1xA9R+te/HuprHUBRzYGFqooVmx4eJUvULvvdqyXipyQP+0
	QQjsmw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9h3xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 17:19:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3HJbu4001092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 17:19:37 GMT
Received: from [10.253.11.68] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 09:19:34 -0800
Message-ID: <8107a53f-5967-461b-8c89-773096a316d1@quicinc.com>
Date: Wed, 4 Dec 2024 01:19:31 +0800
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
        <quic_chejiang@quicinc.com>
References: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
 <CABBYNZLY_PAA0jPiHwGKUmdd3SKqwViLSHAkNHH0=trdqrDRnQ@mail.gmail.com>
Content-Language: en-US
From: Jiayang Mao <quic_jiaymao@quicinc.com>
In-Reply-To: <CABBYNZLY_PAA0jPiHwGKUmdd3SKqwViLSHAkNHH0=trdqrDRnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y8hNViYTvLfTvg8naBHcDqiRRXqurFbe
X-Proofpoint-GUID: Y8hNViYTvLfTvg8naBHcDqiRRXqurFbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030145

Hi Luiz,

On 2024/12/3 4:41, Luiz Augusto von Dentz wrote:
> Hi Jiayang,
> 
> On Mon, Nov 25, 2024 at 12:51 PM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>
>> Clear the remaining command in cmd_sync_work_list when BT is
>> performing power off. In some cases, this list is not empty after
>> power off. BT host will try to send more HCI commands.
>> This can cause unexpected results.
> 
> What commands are in the queue?

If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
to be left in the queue. Then the driver will try to send the HCI
command of creating connection but failed.
> 
>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
>> ---
>>   net/bluetooth/hci_sync.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index c86f4e42e..bc622d074 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>   {
>>          bool auto_off;
>>          int err = 0;
>> +       struct hci_cmd_sync_work_entry *entry, *tmp;
>>
>>          bt_dev_dbg(hdev, "");
>>
>> @@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>          clear_bit(HCI_RUNNING, &hdev->flags);
>>          hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
>>
>> +       mutex_lock(&hdev->cmd_sync_work_lock);
>> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
>> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
> 
> Seems equivalent to hci_cmd_sync_clear, that said we should have been
> running with that lock already, also if there is a sequence like
> close/open the close may cancel the subsequent open, so I don't think
> we should be canceling every subsequent callback like this.

In hci_cmd_sync_clear, the work cmd_sync_work and reenable_adv_work are
canceled. hci_cmd_sync_clear is not directly called because these two
works should not be canceled during power off.
Do you mean the added code should be moved to other functions to avoid
the risk of lock?

Yes. This change lacks considering sequence of close/open. I will update
the implementation to ensure it does not remove the opening and the
operations after re-opening.
> 
>>          /* After this point our queues are empty and no tasks are scheduled. */
>>          hdev->close(hdev);
>>
>> --
>> 2.25.1
>>
> 
> 

