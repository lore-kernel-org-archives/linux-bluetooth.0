Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D35376F5
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420240; cv=none; b=OzhCYJPaXKkga1BrKpLaloraLXGCH/efLqEJc5fC0n4QuZE1a4DoFUaSbKYQYvcyPxNMdeW+dHxoPVxjk6AeN+FHTndRL1aR33UpYkL5Ff5J04b5L6/ONQ2k47RiHpH4/uGckPvy4EJoQVHuw1IU6FzSLy8u+V9MoOPThxUgP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420240; c=relaxed/simple;
	bh=3vpFrdEigbBA+1O/BO0Qm1es5FRfrLbofwTWeF6iifo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=HhLoHMDXPdyJu3VA8AvYcwD9vX1qleujESElmKsCCWGRWwaU+p/ISXYnCBWAoFRugdbRXbWNm1fgzG9UNq5II5AFf9fgWT8wG+HxQoZaWDHaQonbt6SiWNdFATkpvBUfZXDXXBdpmvZ78ookJQ8P8uwKEOtIIUJUSCDWOcfUGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVGYPV/U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVGYPV/U"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4682G7nR016208
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jul 2024 06:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5bLDS1EvjOBUkpS89Z54qxQbG20Sh04eKEUD8ykR2Nk=; b=ZVGYPV/UqM28wDh7
	VkjzIkZsHTZlb+Vd4D/f3htF2bPcZLNPS/4JyahcatJSMg1bewl29UQsvyZ6w21+
	0RbBVlG/WUVL3tFoOfaxEyV+FIjD4b6BFN7vTu3GYox+euZGE2Z2NpcxbUaUmYed
	Ik0lfBLgumKHPAHgNv3n2oDURHIWSyIO0ZkrExZOFxP1uoaUxAS9b/6N0rCRPo4p
	7DraWkQgELJ4sb3DHdugFsKXo2n9Ep0zguvoEiVOJN5RBcffgLLPlKZTzEyFqnZW
	QjWqVppOW3WaOe0jBFNjHczZUvzcWNAmlvXtXNz6z8Ce6s1tCf0yuE1lVn6cymqW
	lDSqmQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x512s0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 06:30:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4686UVhj016181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jul 2024 06:30:31 GMT
Received: from [10.218.28.94] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 7 Jul 2024
 23:30:29 -0700
Message-ID: <655fe5fa-30f1-4b30-83ab-3c55cb1db3ea@quicinc.com>
Date: Mon, 8 Jul 2024 12:00:26 +0530
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
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
References: <20240703093133.9423-1-quic_amisjain@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240703093133.9423-1-quic_amisjain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ffj2YSfg2iVaguPWL5Jr68lQtP9kwQz0
X-Proofpoint-ORIG-GUID: ffj2YSfg2iVaguPWL5Jr68lQtP9kwQz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080049

Hi Team,
Please review the below the change.
Do comment for any concerns.

Thanks,
Amisha

On 7/3/2024 3:01 PM, Amisha Jain wrote:
> Instead of emitting the property "Size" from obex_put_stream_start(),
> Call the function manager_emit_transfer_property() from plugins/*.c
> wherever plugin has transfer object present.
> Remove the code from obex.c which is generic for all profiles.
> 
> This change resolves the type mismatch issue when calling the
> manager_emit_transfer_property from obex.c. We are passing
> 'os->service_data' of plugin session type but the
> manager_emit_transfer_property() expects the 'obex_transfer'
> type, therefore size is not set properly and might cause
> crash/disconnection.
> 
> ---
>   obexd/plugins/ftp.c | 5 +++++
>   obexd/plugins/opp.c | 5 +++++
>   obexd/src/obex.c    | 3 ---
>   3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 874fe2b8b..127bb9aaf 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -175,6 +175,11 @@ int ftp_chkput(struct obex_session *os, void *user_data)
>   
>   	ret = obex_put_stream_start(os, path);
>   
> +	if (obex_get_size(os) != OBJECT_SIZE_DELETE &&
> +				obex_get_size(os) != OBJECT_SIZE_UNKNOWN) {
> +		manager_emit_transfer_property(ftp->transfer, "Size");
> +	}
> +
>   	if (ret == 0)
>   		manager_emit_transfer_started(ftp->transfer);
>   
> diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
> index 777f5f8ed..74b2f805b 100644
> --- a/obexd/plugins/opp.c
> +++ b/obexd/plugins/opp.c
> @@ -87,6 +87,11 @@ skip_auth:
>   
>   	err = obex_put_stream_start(os, path);
>   
> +	if (obex_get_size(os) != OBJECT_SIZE_DELETE &&
> +				obex_get_size(os) != OBJECT_SIZE_UNKNOWN) {
> +		manager_emit_transfer_property(user_data, "Size");
> +	}
> +
>   	g_free(path);
>   
>   	if (err < 0)
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 98d6245a4..370bfac9e 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -716,9 +716,6 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
>   		return err;
>   	}
>   
> -	if (os->size != OBJECT_SIZE_DELETE && os->size != OBJECT_SIZE_UNKNOWN)
> -		manager_emit_transfer_property(os->service_data, "Size");
> -
>   	os->path = g_strdup(filename);
>   
>   	return 0;
