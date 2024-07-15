Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4703F8E4
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721024600; cv=none; b=i/4ZXWCgYca+4w0qsFiI+wKcsJi9FPbnwjL6tPJh5YsXgmH3CotzsuzvE/M3C9JDVbd4qWdEF2OFZpJVtFEFM8+ZtAetA3FBQ5B3pal0JzHhvdCC8ssYyesQRqxGket8iQy7NnHqdFUO2+/twLYYDvveJg0q081RhBrVj17zQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721024600; c=relaxed/simple;
	bh=AP9XGFWIVttKyfcXNWm1ENccK/2uqbKUI0EqeHo7ds4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=o3RTYTmJ1sUyCl2OZp0jr6RyBh7rUU9O4INGYAKlrssJfIId8GjDKevmWBSUbcloX5H8Ics3rKcbY2NDCvxGJE5PfhyHR2VBblYgnWWWK0YUPhYRAc/X2IwW8aBon39XWnOFluMb+dghD2ktDx2nNw/145dRgtkld+THilRT/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kVRZQvoY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kVRZQvoY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F2ddim006890
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G0OKNRSVTEHw0qe6JriVw52/c9InHF9Pi6UCjSGFGO0=; b=kVRZQvoYNYWOalfs
	wFzwOc51fUW+y3RMQmn1QVZZUIbIM3A9qkOUPbbqCCOBithTwpDvwkj+GMcygfdc
	NTKICSC2SpOpDS2JgUrD9XLoSrKHjzkkudpSTacMob+h9/J0P2tMkY1D9Dt/kxTv
	924nHn+S9N/qrAyFHnLVlR3P5YFDUuZFlHjId8YxMfonkmypYSO/h5DFecIA6lUS
	4B5DxyoYeXg6xvyMRyvtRupu/HZIWmH8eoc3FoezOFR2pfX/tD1Nc9SBbp08/sAW
	iz6DBgnQJ9sQ1xjANDN5febPm6AS/o2mcFoYhTe8ZPGtcn/HuPjbB9DkYVT4njG5
	TjiT0Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjbh2vrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:23:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46F6NHku005961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:23:17 GMT
Received: from [10.218.28.94] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Jul
 2024 23:23:15 -0700
Message-ID: <29785a1d-7858-48f6-ba71-2c543d1c4747@quicinc.com>
Date: Mon, 15 Jul 2024 11:53:21 +0530
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
X-Proofpoint-ORIG-GUID: unp1kM1JnFGoGy1s1EKC96rVBxUcNsh0
X-Proofpoint-GUID: unp1kM1JnFGoGy1s1EKC96rVBxUcNsh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_02,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150049

Hi ,
Please review and comment for any concern.

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
