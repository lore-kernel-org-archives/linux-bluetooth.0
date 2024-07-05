Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B027452
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157927; cv=none; b=ot8qtqmm3vIDgxgKdEbfWZEezThZxpLMxK7m+0e4zPPXcry0XYKNRb9Audu1PURrVRbWeda/8MIEGo0xNXa2hnvYFDLtLraq9aQ3C55gnEhhm4SAF6yd1Sd1ai0p+KCD84+6lC/h8Idy4e6wZv8UU69+Mbqg9+p3+DbOybO5c/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157927; c=relaxed/simple;
	bh=Legypp/8dY1VyT+XP0QQmDefZxOuqajuyzmk0HKPdO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSVW8KWawzAcmlFaw14OavpQRW/H8DeTLJAgT/2ctHDkBtydtrqVaiTtu6vm69+IV2Ywppc1swNdEyslV0ZBiKi476v/Zk8eWPQC0GInQZC5/tEIsjIGi7grDxNIDBmjUf+WR1+VcJbbuiHQtRsyfzAziFIHt/K6wxvA2+zXqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EPhJ+6xx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EPhJ+6xx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Mo9lh005321;
	Fri, 5 Jul 2024 05:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q2wyFa5g/kqDsUIjiQZwe/HHRJRRF6kW/QFbvSiJ/Z0=; b=EPhJ+6xx4mWgOdHs
	qZBW8tFn8sREo2qIIBCOqP7WZTM0EmvtSRNG+mkerBxiVI3OTj2POHq40BusjoQX
	W8mwjwQLhF07erz4aBGS+WtrtYhb4DQw9xRGBNFE92Sf8FllKmRHO7NU+iEp1uJA
	3lalHxTb2YU25qQNelgJ2R9e6WIpb68DumttY7rHjXm2m6G8BBkbSVYIvOxzTq/B
	zK58ErpG/8LybmPSOwIqEunYpuywonJ+UfFkF0fUWwUQcKRcQuRomm64Dogi05sx
	iXkwYXameFkbenTNcdMTJm1OjIXTPwdkQUCeXrycOxw4C2Y14wb2JeEE1iX9j5mS
	B1R4RQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 405cg2bb08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 05:38:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4655cgQb008331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 05:38:42 GMT
Received: from [10.216.4.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 4 Jul 2024
 22:38:40 -0700
Message-ID: <8aff29a0-fc0b-4c65-aeaf-b3c88b5283e3@quicinc.com>
Date: Fri, 5 Jul 2024 11:08:37 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Added BREDR not supported bit in AD Flag when
 discoverable is off
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <20240703070220.15246-1-quic_prathm@quicinc.com>
 <CABBYNZKaqNa_yR4PO3S4R9pvne7XYvy8nX5GCBK+7T9DsuDRpA@mail.gmail.com>
From: Prathibha Madugonde <quic_prathm@quicinc.com>
In-Reply-To: <CABBYNZKaqNa_yR4PO3S4R9pvne7XYvy8nX5GCBK+7T9DsuDRpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q7H3QlSSAWd3cwUnMyVUqDTiw5ULxyVI
X-Proofpoint-ORIG-GUID: Q7H3QlSSAWd3cwUnMyVUqDTiw5ULxyVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_02,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050039



On 7/3/2024 7:27 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, Jul 3, 2024 at 3:02 AM <quic_prathm@quicinc.com> wrote:
>>
>> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>>
>> Fix for GAP/DISC/NONM/BV-02-C
>> As per GAP.TS.p44 test spec
>> IUT does not contain General Discoverable mode and Limited Discoverable
>> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
>> case, thus added BR/EDR not supported bit in the AD Type Flag when
>> discoverable is off.
>>
>> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
>> ---
>>   src/advertising.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/advertising.c b/src/advertising.c
>> index 5d373e088..cfb239585 100644
>> --- a/src/advertising.c
>> +++ b/src/advertising.c
>> @@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
>>          /* Set BR/EDR Not Supported if adapter is not discoverable but the
>>           * instance is.
>>           */
>> -       if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
>> -                       !btd_adapter_get_discoverable(client->manager->adapter))
>> +       if (!btd_adapter_get_discoverable(client->manager->adapter))
>>                  flags |= BT_AD_FLAG_NO_BREDR;
>>
>>          if (!bt_ad_add_flags(client->data, &flags, 1))
>> @@ -1499,6 +1498,17 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>>                  goto fail;
>>          }
>>
>> +       /* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
>> +        * page 158:
>> +        * IUT does not contain
>> +        * ‘LE General Discoverable Mode’ flag or the
>> +        * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type
>> +        * But AD Flag Type should be there for the test case to
>> +        * PASS. Thus BR/EDR Not Supported BIT shall be included
>> +        * in the AD Type flag.
>> +        */
>> +       set_flags(client, bt_ad_get_flags(client->data));
> 
> Was there a bug or something that you are having to add this code here?

Hi Luiz,

Yes there is an issue when discoverable is off the parse_discoverable()
is not triggering when we do advertise on. Fixed this issue and sending
in next patch- [PATCH BlueZ] Set BREDR not supported bit in AD Flag when
discoverable is off. Please review.

Thanks
Prathibha Madugonde
> 
>>          err = refresh_advertisement(client, add_adv_callback);
>>
>>          if (!err)
>> --
>> 2.17.1
>>
> 
> 
