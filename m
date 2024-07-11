Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D11534E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697874; cv=none; b=kCrALf80ztEqxnADL4YvTqUtXuKKfovtm9njrMP/IKH5IplYZOIX59gdv7y3WNvLcJqncvf8yrnr+AqSFSJmgDebjMew+zrBZTWtNQMffulr8CM3f1jWZZ1gcayTcGO5T6IScXZ0KJaKgbfPpGbgVsn7cW/CfBivZGDcOH9t6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697874; c=relaxed/simple;
	bh=H+Y2eYw58mHSFhrkEZs+DeWuyqCuu2BZuMrv1fkb/UA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PP4+kFgxLViwv/VS3hgCmvjAuvDE5hYgL4WPGSlRhD01fF8ATv4jAVj3PbM/veQzaua3KiCxRb6XjLOEtg8nnoLvJN3rdRgQH8J0msDcAOX5zAGAxBJzQ6QBp0Je9W7wHHDVOQg4nKBHLUhDLd1T3jW788+bS8WOOslLrM7NnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pv/Y+9Gd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pv/Y+9Gd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mleI011616;
	Thu, 11 Jul 2024 11:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MnzpEwc5pbCMpUQ08hT/P/w4bS3DCgnRzos0mDhoBVw=; b=Pv/Y+9GdSFyVEDxr
	2+KFw1nj/IkzDkbf8JbPk3LSTJtsRQ7/6C6UTSDufxwVydKImfvJLfzqC/gtUN99
	RAO/SIAslsex5fPS6sbwE3xE4A+PxYcXCMXOtxqOS7vI32lCbbJPQyKhFVFZPaJg
	2OfDR81OIm1Ze7QCLgzPTLLJ5PdajjztqoszF8/T4JyZZySnYFvkadsI0urNkCZc
	4aANXX3FD76M+VbREpvt9f6Y5qTh5GZ+WmJKvL19nmNqFBLVHWrFO/iBZ7zyTVZa
	xdEoypYhd7NI2RCLEE9wPOZgkQpO2j3MF/OpLFm82bHTZT8B1euGTKmguUkIeec+
	2CkMog==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwv7w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:37:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BBbemw031379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:37:40 GMT
Received: from [10.216.15.91] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 04:37:38 -0700
Message-ID: <23be30f4-3fda-4825-981e-1fe5d41df0f9@quicinc.com>
Date: Thu, 11 Jul 2024 17:07:35 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v5] obex: Move size emit signal to plugins instead
 of obex.c
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <pmenzel@molgen.mpg.de>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
References: <20240703093133.9423-1-quic_amisjain@quicinc.com>
 <655fe5fa-30f1-4b30-83ab-3c55cb1db3ea@quicinc.com>
Content-Language: en-US
In-Reply-To: <655fe5fa-30f1-4b30-83ab-3c55cb1db3ea@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t06DHvecttBVAIiN1VN73EzeTuOOYvCd
X-Proofpoint-ORIG-GUID: t06DHvecttBVAIiN1VN73EzeTuOOYvCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110083


Hi,
Please review the below change.
Do comment for any concerns.

On 7/8/2024 12:00 PM, Amisha Jain wrote:
> Hi Team,
> Please review the below the change.
> Do comment for any concerns.
> 
> Thanks,
> Amisha
> 
> On 7/3/2024 3:01 PM, Amisha Jain wrote:
>> Instead of emitting the property "Size" from obex_put_stream_start(),
>> Call the function manager_emit_transfer_property() from plugins/*.c
>> wherever plugin has transfer object present.
>> Remove the code from obex.c which is generic for all profiles.
>>
>> This change resolves the type mismatch issue when calling the
>> manager_emit_transfer_property from obex.c. We are passing
>> 'os->service_data' of plugin session type but the
>> manager_emit_transfer_property() expects the 'obex_transfer'
>> type, therefore size is not set properly and might cause
>> crash/disconnection.
>>
>> ---
>>   obexd/plugins/ftp.c | 5 +++++
>>   obexd/plugins/opp.c | 5 +++++
>>   obexd/src/obex.c    | 3 ---
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
>> index 874fe2b8b..127bb9aaf 100644
>> --- a/obexd/plugins/ftp.c
>> +++ b/obexd/plugins/ftp.c
>> @@ -175,6 +175,11 @@ int ftp_chkput(struct obex_session *os, void 
>> *user_data)
>>       ret = obex_put_stream_start(os, path);
>> +    if (obex_get_size(os) != OBJECT_SIZE_DELETE &&
>> +                obex_get_size(os) != OBJECT_SIZE_UNKNOWN) {
>> +        manager_emit_transfer_property(ftp->transfer, "Size");
>> +    }
>> +
>>       if (ret == 0)
>>           manager_emit_transfer_started(ftp->transfer);
>> diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
>> index 777f5f8ed..74b2f805b 100644
>> --- a/obexd/plugins/opp.c
>> +++ b/obexd/plugins/opp.c
>> @@ -87,6 +87,11 @@ skip_auth:
>>       err = obex_put_stream_start(os, path);
>> +    if (obex_get_size(os) != OBJECT_SIZE_DELETE &&
>> +                obex_get_size(os) != OBJECT_SIZE_UNKNOWN) {
>> +        manager_emit_transfer_property(user_data, "Size");
>> +    }
>> +
>>       g_free(path);
>>       if (err < 0)
>> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
>> index 98d6245a4..370bfac9e 100644
>> --- a/obexd/src/obex.c
>> +++ b/obexd/src/obex.c
>> @@ -716,9 +716,6 @@ int obex_put_stream_start(struct obex_session *os, 
>> const char *filename)
>>           return err;
>>       }
>> -    if (os->size != OBJECT_SIZE_DELETE && os->size != 
>> OBJECT_SIZE_UNKNOWN)
>> -        manager_emit_transfer_property(os->service_data, "Size");
>> -
>>       os->path = g_strdup(filename);
>>       return 0;
