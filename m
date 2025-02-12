Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFB21129C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386124; cv=none; b=bU2dLRfo+hDoKaR0a0vPjrGjjOcWgV4sKPRXKBGRkJPoDc86Gqrx4RcJ3o+galn6qIb0C8m0zO70h7NgJNJGoAsiBuZEz5J6sY9nBDk8LLKTFDQq0gGc0eOulKD2QKeDM4kRcPc2zbWpj/SAoclFJfOOnmBrAwtkptM7QN28jsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386124; c=relaxed/simple;
	bh=XrrP51fOWaKhJUnH4li7WxW0BFAhCxdtt6IanaZLiq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CO9AaTsO5uxYWRVtfmd6lGeilzgIj7ZwTDkRm2Az96VYwiG9KW0wC8/3z9xJZGiMtS1LZOmLpCuBUAEV6Dk/NWmzUHIxiNmcA0H4b1yAxIpizDyTUJ7ot3GnaMzkvKjmHbRCj4lmFRuX/z1WppkR+eU/zQLMabzR3tIQhyNa3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y696nkVR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y696nkVR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C95Qi4026076
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 18:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzNvM5065LfNbEdMn33HWzrmtbdRhRb1EstAfKt+ttg=; b=Y696nkVRWyzsUziQ
	bTxMxDyIEnOPN2OT5pi2cp92hPS7L7IcICFZD+e8xLwwZadZKykhg7C9Ip/ur4qG
	g9w81vUFZHUKmIeM7gclU/TH8DUn26Ja3Jq2h9KT9sx9kgb343H5zs/pBbMUEQo8
	r5rYIAjCX0SZuBJIv+lrejePFWpz/ZOgWAGQvmJP7/UZ2myDVJUvA9naLkgZXZt1
	z0foB+6nVq3D3FuqdIKyeT5vAA4ybbNdNbaBOkPFxX1snaoBmfWfqpuj1jLdR3oO
	meYUYJNx+e4UFaVXwEztJRLq+9tKxH2sKqiRyzJRwBjZE4llQhvi3zrqZoddU71Q
	1UTC2A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j5cpa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 18:48:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51CImdSP011705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 18:48:39 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 10:48:38 -0800
Received: from nasanex01c.na.qualcomm.com ([fe80::5e20:e07b:8a35:51ee]) by
 nasanex01c.na.qualcomm.com ([fe80::5e20:e07b:8a35:51ee%13]) with mapi id
 15.02.1544.009; Wed, 12 Feb 2025 10:48:38 -0800
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi
 (QUIC)" <quic_hbandi@quicinc.com>,
        "Anubhav Gupta (QUIC)"
	<quic_anubhavg@quicinc.com>
Subject: RE: [PATCH v2] obex: Add messages_get_message() implementation for
 MAP plugin
Thread-Topic: [PATCH v2] obex: Add messages_get_message() implementation for
 MAP plugin
Thread-Index: AQHbeLcTbCya/shjJU2oF4clObG2C7NECzFw
Date: Wed, 12 Feb 2025 18:48:38 +0000
Message-ID: <b54a7f6cc3ea48ec98a7c81ccfc40f7a@quicinc.com>
References: <20250206164852.3649751-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250206164852.3649751-1-quic_amisjain@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: linux-bluetooth@vger.kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fQgXpyCst2fY3Wl3eT44MvMTyWtyobZm
X-Proofpoint-GUID: fQgXpyCst2fY3Wl3eT44MvMTyWtyobZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120135

Hi @linux-bluetooth@vger.kernel.org,
Please review the below patch.
Gentle reminder.

> -----Original Message-----
> From: Amisha Jain <quic_amisjain@quicinc.com>
> Sent: Thursday, February 6, 2025 10:19 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Mohammed Sameer Mulla (QUIC) <quic_mohamull@quicinc.com>;
> Harish Bandi (QUIC) <quic_hbandi@quicinc.com>; Anubhav Gupta (QUIC)
> <quic_anubhavg@quicinc.com>
> Subject: [PATCH v2] obex: Add messages_get_message() implementation for
> MAP plugin
>=20
> GET Message() operation should be supported for passing below PTS
> testcases - 1.MAP/MSE/MMB/BV-12-C Verify that the MSE can return an email
> message to the MCE.
> 2.MAP/MSE/MMB/BV-13-C
> Verify that the MSE can return a SMS message in native format to the MCE.
> 3.MAP/MSE/MMB/BV-14-C
> Verify that the MSE can return a SMS message with text trans-coded to UTF=
-8
> to the MCE.
>=20
> ---
>  obexd/plugins/mas.c            |  4 ++--
>  obexd/plugins/messages-dummy.c | 32
> +++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c index
> 10b972d65..f63fcf6c6 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -612,11 +612,11 @@ static void *message_open(const char *name, int
> oflag, mode_t mode,
>  		return NULL;
>  	}
>=20
> +	mas->buffer =3D g_string_new("");
> +
>  	*err =3D messages_get_message(mas->backend_data, name, 0,
>  			get_message_cb, mas);
>=20
> -	mas->buffer =3D g_string_new("");
> -
>  	if (*err < 0)
>  		return NULL;
>  	else
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-
> dummy.c index e313c6163..93648831a 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -516,7 +516,37 @@ int messages_get_message(void *session, const char
> *handle,
>  					messages_get_message_cb callback,
>  					void *user_data)
>  {
> -	return -ENOSYS;
> +	struct session *s =3D  session;
> +	FILE *fp;
> +	char *path;
> +	char buffer[1024];
> +
> +	DBG(" ");
> +	path =3D g_build_filename(s->cwd_absolute, handle, NULL);
> +	fp =3D fopen(path, "r");
> +	if (fp =3D=3D NULL)
> +	{
> +		DBG("fopen() failed");
> +		return -EBADR;
> +	}
> +
> +	/* 1024 is the maximum size of the line which is calculated to be more
> +	 * sufficient*/
> +	while (fgets(buffer, 1024, fp)) {
> +		if (callback)
> +		{
> +			callback(session, 0, 0, (const char*)buffer, user_data);
> +		}
> +	}
> +
> +	if (callback)
> +	{
> +		callback(session, 0, 0, NULL, user_data);
> +	}
> +
> +	g_free(path);
> +	fclose(fp);
> +	return 0;
>  }
>=20
>  int messages_update_inbox(void *session, messages_status_cb callback,
> --
> 2.34.1
>=20

