Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E184E1E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831786; cv=none; b=apveNbtBqQVOvX/4Kkhdteo7g46r5e1PyPqCmJFG4JzNLtfOCLeWfURSIxDaGB2FkyR0DnKn44tZl0U3jXjc5NqL5wCmwNR5y/RZf7/hSfAZ90J6ia6CEg6NUhxroSsPP+dQUhFp6SU9hvJmVoorE+xRf7SnykJGUfYVN+SyiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831786; c=relaxed/simple;
	bh=P/aNCPBpJuMGtJrbbjYA7ZXS3WhRBH9OIuSXd0Aj4EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TKeL79qvDqCfZwtCmv6zcepsR07opgiNB47JGjEKadRt024kDIDmUsThk3x9t3RMQ03qHAEZrHFM7KWpRf6kRpiclBca6piQ7Tdg1eOJd4ZsFz4rXkV26SW1o50+JTaXL22GuCz8Ts24ev0uFrBQGESOU7HM0Z866KuB+n1hFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PalMxLT2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PalMxLT2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4612IIJ6011060;
	Mon, 1 Jul 2024 11:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SWC6IOg5YlmSl8dPpPpQaG/Exke+7Q+rdtQflJCV0gU=; b=PalMxLT2sYFZeXDu
	4y6UU1vsao/joBLlIg516OmbjSUrFsDjw97g1WW0ucbPxFsIjFqOJx7Ht9Videja
	47GRsOsIDrFrznMku6FOr6je09OGp/l3m1sCSjrR6zXfDJ6CikZ2B4mR6oMhD2yl
	bev02G0jfHJEaO68TFB3A+Y+cw5MxmXYgcXc03A/jmae8te3VTzF8ktI0ALsqM02
	yIiFq7LOR1duTcyZmAgISGk3wWw3LQhPkOODK6ZC7/0g4yGm/lUmmljMZIRIgYpY
	CHdljgj4fpcQasC+s9TEVAqqVwZ11XN6e9gktcy9JHqInuF0d1zGyAuOzAzrn5SU
	Kol8Cw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 403kj8s0r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 11:03:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461B32J5010426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 11:03:02 GMT
Received: from [10.219.0.139] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 04:03:00 -0700
Message-ID: <5e3186e5-0ec3-41e2-985e-f2609a4a9fd5@quicinc.com>
Date: Mon, 1 Jul 2024 16:32:57 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Added BREDR not supported bit in AD Flag when
 discoverable is off
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <20240628072342.2256-1-quic_prathm@quicinc.com>
 <CABBYNZJ7RfPu61tt7R-nrUfZX1DnSY73KS84p9QiyTW7WDpfXQ@mail.gmail.com>
From: Prathibha Madugonde <quic_prathm@quicinc.com>
In-Reply-To: <CABBYNZJ7RfPu61tt7R-nrUfZX1DnSY73KS84p9QiyTW7WDpfXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qpv2sNFpraF-6Hp7cFtSjD2OYwOOI8K6
X-Proofpoint-ORIG-GUID: qpv2sNFpraF-6Hp7cFtSjD2OYwOOI8K6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_09,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010085



On 6/28/2024 7:08 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, Jun 28, 2024 at 3:24 AM <quic_prathm@quicinc.com> wrote:
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
>>   src/advertising.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/src/advertising.c b/src/advertising.c
>> index 5d373e088..9857ceceb 100644
>> --- a/src/advertising.c
>> +++ b/src/advertising.c
>> @@ -1444,6 +1444,7 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>>   {
>>          struct adv_parser *parser;
>>          int err;
>> +       uint8_t flags;
>>
>>          for (parser = parsers; parser && parser->name; parser++) {
>>                  DBusMessageIter iter;
>> @@ -1499,6 +1500,21 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>>                  goto fail;
>>          }
>>
>> +       if (!btd_adapter_get_discoverable(client->manager->adapter)) {
>> +               /* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
>> +                * page 158:
>> +                * IUT does not contain
>> +                * ‘LE General Discoverable Mode’ flag or the
>> +                * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type
>> +                * But AD Flag Type should be there for the test case to
>> +                * PASS. Thus BR/EDR Not Supported BIT shall be included
>> +                * in the AD Type flag.
>> +                */
>> +               flags = bt_ad_get_flags(client->data);
>> +               flags |= BT_AD_FLAG_NO_BREDR;
>> +               bt_ad_add_flags(client->data, &flags, 1);
>> +       }
> 
> I think we would be much better off using broadcaster role for such a
> test case or does it require to be connectable? Anyway I don't think
> there is a requirement to disable BR/EDR when not discoverable, so if
> we really need to pass specific flags then perhaps it would be better
> to create a Flags property so clients can set themselves.
> 
Hi,
This particular test case require IUT to be in connectable. There is
already code snippet to disable BR/EDR when adapter is not discoverable
in the set_flags() like below.
	/* Set BR/EDR Not Supported if adapter is not discoverable but
	 * the instance is.
	 */
	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
			!btd_adapter_get_discoverable(client->manager->adapter))
		flags |= BT_AD_FLAG_NO_BREDR;

Hence using the same logic. Currently AD flags(BT_AD_FLAG_LIMITED,
BT_AD_FLAG_GENERAL & BT_AD_FLAG_NO_BREDR) is managed based on properties
discoverable, discoverable timeout and adapter discoverable.

--
Prathibha Madugonde


>>          err = refresh_advertisement(client, add_adv_callback);
>>
>>          if (!err)
>> --
>> 2.17.1
>>
> 
> 
