Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581D13B59E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117675; cv=none; b=NY10UiVoQyZnl/NlxMAH4QOMP18roGE/gbK84YGqAQBEkntd/jZzZ6zvsAIsF1fGY5BJ6X2xyBmynyIvQUhszf9YaKC8s4sXNIfAiO+q62l0xoMWTHKm3/aKnMV+3jXGxacktQkjgIFgD7+UxJv9JQo641knTUMZswPJauPoPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117675; c=relaxed/simple;
	bh=ztGYnkOV8SHEFCuR2sypGpse8hUz1zpTpp0zWo8ytW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RQAMBIfYJ+yEdYplBzKr57gY3lRtLWMNp7DmSKPswZzroekMVLwCa16JKteCVHCh/NsUBzmDHuZU99k4p/TYga6MZHUJB1C6Kph/6YrJIwc8SgybxNHtliJv/CHOuZkPqYshW+89sX1A4fdULRXF8yddmW9QAUF2zIH29dHKdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eTvk9oYA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eTvk9oYA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKAjssa004590;
	Wed, 20 Nov 2024 15:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vrgcx09lChOxJGLeB3K/7nR1CAJ906kI63Nh8q9oosY=; b=eTvk9oYAq70WEmGY
	9NYHa8fFIczvdeTF95VKMigCEI3r67eHtPPcCHjBtSWvBEFHwj20QxHyHpOsWD2L
	t8+rD0J49eIbvVULncbr002gwsyPgWp/+X5AeLrn29L5VKQqetkhkLMwYRXSqUSo
	/fKhvH/iJtlMGoF+VozFyrE2q7+FMVdzloFiS0uZGfrgSKfZKtXBwXxV+A49n26j
	a65Vyd1Ybm7yRYhhR9RKT7Bj/zoTaEVKzJ4Gunp2siatG2CsPx7I/MOvXPIdTORH
	OZrumLCy5bC1LRc2X4qRy2LQQyIu/pL+7SoZ28I4EIRrt+I7fy5f6/vhsX7990oL
	t7JMvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ea70rjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:47:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKFlpsW023758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:47:51 GMT
Received: from [10.216.48.116] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 07:47:49 -0800
Message-ID: <7b8d7575-5b50-4794-bc2d-2bf2f6e9c022@quicinc.com>
Date: Wed, 20 Nov 2024 21:17:46 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] Fix for broadcast mode, not to add any AD flags in
 advertise Data
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <20241120144918.11991-1-quic_prathm@quicinc.com>
 <CABBYNZL=HwZ1rsgghwF90VyfFVmLJwcT2LJEKK0-T__3N1jBaA@mail.gmail.com>
From: Prathibha Madugonde <quic_prathm@quicinc.com>
In-Reply-To: <CABBYNZL=HwZ1rsgghwF90VyfFVmLJwcT2LJEKK0-T__3N1jBaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GhCxoPYk_OK05u32Ye8-3bc_O7IufEI7
X-Proofpoint-ORIG-GUID: GhCxoPYk_OK05u32Ye8-3bc_O7IufEI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200107



On 11/20/2024 8:43 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, Nov 20, 2024 at 10:00 AM <quic_prathm@quicinc.com> wrote:
>>
>> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>>
>> src/advertising.c
>> Include check for broadcast mode:
>> Need not set flags in AD flags of Advertise Data
> 
> Please reword the last sentence to something like: "AD flags shall
> never be set for broadcast", also add traces showing what is
> happening.
> 
Thanks Luiz for the input, re-framing the sentence and sending in 
upcoming patch.

Below is the snippet of btmon logs for advertise broadcast failure.

*****************************
@ MGMT Command: Add Extended Advertising Data (0x0055) plen 22 
 
                          {0x0001} [hci0] 160.010453
         Instance: 1
         Advertising data length: 3
         Flags: 0x04
           BR/EDR Not Supported
         Scan response length: 8
         Name (complete): prathm
@ MGMT Event: Advertising Added (0x0023) plen 1 
 
                          {0x0002} [hci0] 160.010474
         Instance: 1
 > HCI Event: Command Complete (0x0e) plen 4 
 
                                #46 [hci0] 160.010849
       LE Set Extended Advertising Data (0x08|0x0037) ncmd 2
         Status: Invalid HCI Command Parameters (0x12)
*******************************

>> Test steps:
>>  From DUT, bluetoothctl go to menu advertise
>> secondary 1M/2M
>> name on
>> back
>> advertise broadcast
> 
> In case you don't know it, it is possible to call command from
> submenus directly:
> 
> advertise.secondary 1M/2M
> advertise.name on
> advertise broadcast
> 

Got it. Thank you for info.

Thanks
Prathibha

>> ---
>>   src/advertising.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/advertising.c b/src/advertising.c
>> index bd121e525..2fc6f917d 100644
>> --- a/src/advertising.c
>> +++ b/src/advertising.c
>> @@ -759,10 +759,15 @@ static bool parse_discoverable(DBusMessageIter *iter,
>>
>>          dbus_message_iter_get_basic(iter, &discoverable);
>>
>> +       /* For broadcast mode, need not add any flags
>> +        * just return true without adding flags.
>> +        */
>>          if (discoverable)
>>                  flags = BT_AD_FLAG_GENERAL;
>> -       else
>> +       else if (client->type != AD_TYPE_BROADCAST)
>>                  flags = 0x00;
>> +       else
>> +               return true;
>>
>>          if (!set_flags(client , flags))
>>                  goto fail;
>> --
>> 2.17.1
>>
>>
> 
> 
