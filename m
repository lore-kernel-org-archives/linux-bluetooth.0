Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F338D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382257; cv=none; b=o3vFEeNnaHJBWHZLK/ASTB/fltnUMgLkj+nUekhc7FbAfNxrvok0Gk7hjo3xCgQiXYOh7a68LGfxUjI25HD1id5JV5yVOSQRgnpbihJ2/0jdVozjzWYYMhq4MkIBsF8H9qb/bGr95b8AOAFb/v/zcVs8cwO2w/Nyat2Q18wXmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382257; c=relaxed/simple;
	bh=PMPUs+9Kfuj23F1Ez1A7GWH4uRhOKcMmdcOgmCFXxHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E8ZrPhjLjII5OhItxPwOOicEKpjF7unLmYB+dLeB0bv90MVgpr7yR6HuFf169gNL9iDY8M2BpEKa4MRCjGTrOI6FMdAzc1zYBdH6kO38RYcnkUd0o0JRp9zI5ZXSOoxkkwyEICv28wkFSBkwN5HdaLPUr9kjHE2wf2AR9NmAyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WuXV1xZA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WuXV1xZA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PKKcU3020437;
	Wed, 26 Jun 2024 06:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0HqQQx0aKpVjFetL7sPGfvwuzOCVX4nANx/gCVKcPuM=; b=WuXV1xZAfxy24BL0
	kWGoP2q6AH7MC8Qiyj40RtV2Vylh26EpgH/D0WxQTL02bw99XekYPnELsPnlBQdI
	PFw0BZj9ekze8xrO+6z2XM3AijtrdKq0ifi6WqQlaEggzF5TJWoWP7U/dkS7BkaO
	SDoph/Bbrav97zinaVXbm8vwmeWgQrAs0qbDTz4ltSpkThOusEaAlGA79N0g1pXw
	lzI3RfOWS+8vRkKm2ngMRqK0fBsiI7M9X8gN3kmjsQBHL24R8wMO/i5x99kQ9vH9
	qBHxX4jsZpaekNGE2LTzm1b+RlHYiNx+KCfIOmv3wvbzPw7Z9+gmfMiC5RhkbYRw
	uypF1w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqcegpau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 06:10:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q6Aou7005912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 06:10:50 GMT
Received: from [10.216.34.141] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 23:10:48 -0700
Message-ID: <8ae5c6f5-e005-42d9-ad5b-ea53a978a85a@quicinc.com>
Date: Wed, 26 Jun 2024 11:40:12 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth : Update the mas session structure
To: Pauli Virtanen <pav@iki.fi>, <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
References: <20240625063533.30536-1-quic_amisjain@quicinc.com>
 <dac1d55c940b3a9afb971263c8195e765e77c598.camel@iki.fi>
Content-Language: en-US
From: Amisha Jain <quic_amisjain@quicinc.com>
In-Reply-To: <dac1d55c940b3a9afb971263c8195e765e77c598.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DTzC83GHvU7tRblXWbI6TGmEMBbEpeAV
X-Proofpoint-ORIG-GUID: DTzC83GHvU7tRblXWbI6TGmEMBbEpeAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260047

Hi,

Correct! The problem here is manager_emit_transfer_property() is 
expecting the structure of type 'obex_transfer' and we are passing the 
structure of session type which will be type mismatch and inappropriate 
values will be populated in further calls in code. Hence property "Size" 
will never emit on console(obexctl) as it is not set properly and might 
cause crash/disconnection.

 > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
 > index a4bae857f..ed219d3e7 100644
 > --- a/obexd/src/obex.c
 > +++ b/obexd/src/obex.c
 > @@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session 
*os, const char *filename)
 >                  return err;
 >          }
 >
 > +       if (os->size != OBJECT_SIZE_DELETE && os->size != 
OBJECT_SIZE_UNKNOWN)
 > +               manager_emit_transfer_property(os->service_data, "Size");
 > +
 >          os->path = g_strdup(filename);
 >


One way to resolve this issue is to add the additional field in 
'mas_session' so it can cast to struct 'obex_transfer'. We are adding 
new field 'char *path' as only transfer->path will be invoked and passed 
further.

void manager_emit_transfer_property(struct obex_transfer *transfer,
								char *name)
{
	if (!transfer->path)
		return;

	g_dbus_emit_property_changed(connection, transfer->path,
					TRANSFER_INTERFACE, name);
}

 >> Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
 >> ---
 >>   obexd/plugins/mas.c | 4 +++-
 >>   1 file changed, 3 insertions(+), 1 deletion(-)
 >>
 >> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
 >> index 10b972d65..71bf12ad3 100644
 >> --- a/obexd/plugins/mas.c
 >> +++ b/obexd/plugins/mas.c
 >> @@ -51,6 +51,8 @@
 >>   #define ML_BODY_END "</MAP-msg-listing>"
 >>
 >>   struct mas_session {
 >> +	uint8_t notification_status;
 >> +	char *path;
 >>   	struct mas_request *request;
 >>   	void *backend_data;
 >>   	gboolean finished;
 >> @@ -59,7 +61,6 @@ struct mas_session {
 >>   	GObexApparam *inparams;
 >>   	GObexApparam *outparams;
 >>   	gboolean ap_sent;
 >> -	uint8_t notification_status;
 >>   };
 >>
 >>   static const uint8_t MAS_TARGET[TARGET_SIZE] = {
 >> @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session 
*os, int *err)
 >>   		goto failed;
 >>
 >>   	manager_register_session(os);
 >> +	mas->path = NULL;
 >

There is no transfer already registered for mas during connection, so 
setting the path to NULL.

On 6/25/2024 9:09 PM, Pauli Virtanen wrote:
> Hi,
> 
> ti, 2024-06-25 kello 12:05 +0530, Amisha Jain kirjoitti:
>> Update the 'mas_session' structure such that
>> manager_emit_transfer_property(os->service_data, "Size")
>> will get the proper structure in arguments as
>> expected like structure 'obex_transfer' and transfer->path
>> won't be populated with inappropriate value.
>>
>> As there is no new transfer registered during mas connect,
>> hence setting the path to NULL to avoid invoking the
>> g_dbus_emit_property_changed() property.
>>
>> Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
>> ---
>>   obexd/plugins/mas.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
>> index 10b972d65..71bf12ad3 100644
>> --- a/obexd/plugins/mas.c
>> +++ b/obexd/plugins/mas.c
>> @@ -51,6 +51,8 @@
>>   #define ML_BODY_END "</MAP-msg-listing>"
>>   
>>   struct mas_session {
>> +	uint8_t notification_status;
>> +	char *path;
>>   	struct mas_request *request;
>>   	void *backend_data;
>>   	gboolean finished;
>> @@ -59,7 +61,6 @@ struct mas_session {
>>   	GObexApparam *inparams;
>>   	GObexApparam *outparams;
>>   	gboolean ap_sent;
>> -	uint8_t notification_status;
>>   };
>>   
>>   static const uint8_t MAS_TARGET[TARGET_SIZE] = {
>> @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *os, int *err)
>>   		goto failed;
>>   
>>   	manager_register_session(os);
>> +	mas->path = NULL;
> 
> Maybe the problem here is that the change in commit bb160515185e
> ("obexd: Emit Size property of transfer after open()") is not right?
> 
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index a4bae857f..ed219d3e7 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
>                  return err;
>          }
>   
> +       if (os->size != OBJECT_SIZE_DELETE && os->size != OBJECT_SIZE_UNKNOWN)
> +               manager_emit_transfer_property(os->service_data, "Size");
> +
>          os->path = g_strdup(filename);
> 
> This casts os->service_data to obex_transfer which IIUC does not work
> for most the plugins, as it's the session struct.
> 
> Maybe plugins can emit the transfer property change in their open()
> callback, for the plugins where it makes sense?
> 
>>   
>>   	return mas;
>>   
> 
