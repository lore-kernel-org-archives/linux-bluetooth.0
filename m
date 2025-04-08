Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E125F965
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106428; cv=none; b=FyLHxGYK7OUOQ5FjKgi/MDn9R4cNqNV4AFTo4WB3x7XBEmFKpnSAYCCTCZom4RIViV8h8rpNaP6arvZprLKeeZnuK68phQDxkhWy/th98HQSYGnHxpzZIxgmCh8QsYI+aFF9sckxQ6q+IMX+Eq6lEfLGj26mVAbroGrmuhqwYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106428; c=relaxed/simple;
	bh=+fEJ1b+07CcATXKYWyt5TaeA3VvNDhjfE8NkFwCco5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IhDJF6Q26GtKJypmBHvdS1sN0fA+uOuZDeLZKXi1kfziKgEo8mOOTJ6h2M3iJoPrPbrxW7OE5vNKvdBXOTHpzAqOoJ5E2BDQ2CMVWH+U6FiTFG3JVL7rL/IYV+knVAt1zH4/BTbmJxgPGpd6+ZizWH4hbSofvnLHNMn8+7rOZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BmGtNG6Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BmGtNG6Z"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GMJG029517;
	Tue, 8 Apr 2025 10:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+KttiYHClY3maGJGxYW/wlW/ajbXGKQv9RGSBVhvRdY=; b=BmGtNG6ZNRdBwdB7
	ZXRSaazVI6TP8gGsfWo65ns0MPCbmPHwO2W8Bz0J1HCw21iZ1F4u/d65yXOFWkvQ
	xFW/ojx6NllspcLWAQ1jvsGXJ7dhCE389UOGL3QJ5jII3h6FFlP+9OWVVwpANupI
	CIWkyjhwUf8sdE+CNzgXs6JoTyaMmOYQf7AVHOXW4Y7j3/K56icAVuWYcRXTsljr
	o5tKtmKmm5lC9S3XXj8KsRsqXg5SGC9k1cl7KkAI1B9xWNGb589BOScojkRdgrci
	N5yE53Kok4SFs37eSysplm/17fiR1kJgPNtVARUTgR/aivRo/Je/EwZ5BPTqCMO6
	7mLxjg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrfbr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:00:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 538A0F5f012120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 10:00:15 GMT
Received: from [10.239.96.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 03:00:13 -0700
Message-ID: <d7038bc6-0313-455f-9fa1-e27ee4466240@quicinc.com>
Date: Tue, 8 Apr 2025 18:00:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Establishing ACL links is
 prohibited when power off
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <quic_chejiang@quicinc.com>, <quic_jiaymao@quicinc.com>,
        <quic_chezhou@quicinc.com>, <quic_zijuhu@quicinc.com>,
        <quic_mohamull@quicinc.com>, <linux-bluetooth@vger.kernel.org>
References: <20250408024646.1784057-1-quic_shuaz@quicinc.com>
 <4db1b876-afa7-4ccb-be2f-36974669f269@molgen.mpg.de>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <4db1b876-afa7-4ccb-be2f-36974669f269@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dY0EVf-fbJbWERkwJKkhJaaVJFlc44SD
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f4f3b0 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=aGVx9mtOzzJrNiPZ1wwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dY0EVf-fbJbWERkwJKkhJaaVJFlc44SD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080071

Dear Paul

On 4/8/2025 5:37 PM, Paul Menzel wrote:
> Dear Shuai,
> 
> 
> Thank you for your patch. Some minor comments.
> 
> It’d be great if you made the summary/title a statement about the action of the patch and not about the issue. Maybe:
> 
> Prohibit establishing of ACL links during poweroff
> 
> 
> Am 08.04.25 um 04:46 schrieb Shuai Zhang:
>> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
>> to be left in cmd_sync_work_list. Then the driver will try to send
>> the HCI command of creating connection but failed.
> 
> s/failed/fails/

 Could you please explain what this means?

> 
>> When establishing ACL link, add judgment for BT power off.
> 
> Maybe:
> 
> Check if the device is *not* starting up, that means powering off, when establishing the ACL link, and cancel early in this case.
> 
> 
> It’d be great if you documented how to reproduce the bug and test the patch.
> 

 I will revise the aforementioned issues and publish the updates in version 2. 
 Thank you very much for your suggestions.

>> Change-Id: I9844a1ce1f207453e4fadeded3da1738eb4660c9
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> ---
>>   net/bluetooth/hci_sync.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index aeeadb45e..fdd57132e 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -6761,7 +6761,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
>>       struct hci_cp_create_conn cp;
>>       int err;
>>
>> -    if (!hci_conn_valid(hdev, conn))
>> +    if (!hci_conn_valid(hdev, conn) || !test_bit(HCI_UP, &hdev->flags))
>>           return -ECANCELED;
>>
>>       /* Many controllers disallow HCI Create Connection while it is doing
>> -- 
>> 2.34.1
> 
> The diff looks reasonable.
> 
> 
> Kind regards,
> 
> Paul

