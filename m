Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C76DDD9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743633; cv=none; b=cKIJ6oO6OYi0Tauh7HX5N2f+rVLjAABC1ZPgISmRthMK8HGvriU9QrphR4vyzgE1bM1wPsmWdMfV+j3YW+uIY1bCCwT/qLsmK2wRS+hCCfE/iFv8qZd9g6pO5FfRRmwS+7EkTbPsfMcdj2E1HG5wn+yp3E8tztqwj6fQLM+irBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743633; c=relaxed/simple;
	bh=vqurLvfMJwYqyHYjXDaVgERo/W/vNxiB+I0htU1KDgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLjShMatI75oHrYudw0O+/zXSd+wWo4rnibZgw6hsd5bdvrLITn1ITewYBWPPd4RTi2jiu9BnGt3Q8ze+CfYBTm0N9fbHCLSaSzFwkAah82GYyIDPJPf0gjEmQ0archG3gEivyOEbNn16o9Z/DurH/sXBh8cvEpw2eTNB3cjn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XdLI60FN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XdLI60FN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4572aeMB020320
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Jun 2024 07:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8HCJDCruMoMEMRwZQ/FzHdXtH3QWm8pHmweWoyjuI78=; b=XdLI60FNM2Y5gGZA
	6ZQgHdshPoXItFZK/xKJcIowdL9S9Nn/x+4oaOf1B+zM3OTkp7ne+4HKuQnKbleh
	C5vkdj+Cmp6G0EuV1dmO/6Hi3oKedZ9syINrwNEulzcHadG48VoshwfHyzlKa8xe
	xZhEAuvydACekzhC0K93yEN8bv/Xntw8+k4WOUnAJP4H4cE4hPuVddfW34tQRkvX
	TzanYg9B128nhA1acjTSzoV97AMHS6cEl7z0L/kRDQd+9dlZO0Y8aQ1vuFXWoE8/
	u70fnSWd5ZvnoovqhEZg/vOp9nBVXyuR6vhVzmURvMp4FYkAwpqMlBfd4tAoaEVL
	7HiDqg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk3h2u7tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2024 07:00:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 45770TxS003958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Jun 2024 07:00:29 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 00:00:28 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::4223:f723:395d:74fa]) by
 nasanex01c.na.qualcomm.com ([fe80::4223:f723:395d:74fa%13]) with mapi id
 15.02.1544.009; Fri, 7 Jun 2024 00:00:28 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>
Subject: RE: MAP server crash during connection
Thread-Topic: MAP server crash during connection
Thread-Index: AdqzKJeyPcFb24X1Rwqc4W+GcA5qlwDHZ+PQAJhNwjA=
Date: Fri, 7 Jun 2024 07:00:28 +0000
Message-ID: <6a7a26622a3f47aaa7b531773ce35f48@quicinc.com>
References: <ec4a4adbfee94a699ebd635abc51f01c@quicinc.com>
 <3ffea594e86647208806e321275df2c6@quicinc.com>
In-Reply-To: <3ffea594e86647208806e321275df2c6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c2tG60G4K_MDUrCYaCx9D78d5I8wQrSn
X-Proofpoint-ORIG-GUID: c2tG60G4K_MDUrCYaCx9D78d5I8wQrSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070048

Hi,
To resolve the MAP crash issue, We have added the below fix -


diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 3a68fd6..7c95075 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -716,7 +716,7 @@ int obex_put_stream_start(struct obex_session *os, cons=
t char *filename)
 		return err;
 	}
=20
-	if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE_UNKNOWN=
)
+	if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE_UNKNOWN=
 && strcmp(os->service->name, "Message Access server") !=3D 0)
 		manager_emit_transfer_property(os->service_data, "Size");
=20
 	os->path =3D g_strdup(filename);
--

Please review the above fix and let us know if we can go ahead with this ch=
ange.

Thanks,
Amisha

> -----Original Message-----
> From: Amisha Jain (QUIC)
> Sent: Tuesday, June 4, 2024 11:43 AM
> To: 'linux-bluetooth@vger.kernel.org' <linux-bluetooth@vger.kernel.org>
> Subject: RE: MAP server crash during connection
>=20
> Hi,
> Please help with the below issue.
>=20
> > -----Original Message-----
> > From: Amisha Jain (QUIC)
> > Sent: Friday, May 31, 2024 12:34 PM
> > To: 'linux-bluetooth@vger.kernel.org'
> > <linux-bluetooth@vger.kernel.org>
> > Subject: MAP server crash during connection
> >
> > Hi bluez team,
> > I have been trying to verify MAP Server obex profile on bluez 5.65.
> > While trying=A0connection, I have noticed the crash on the server side
> > (connection initiated from client side) and hence connection is failing=
.
> > Please find the backtrace of the crash -
> >
> > =A0 assertion failed "i =3D=3D len" file "../../dbus-1.14.8/dbus/dbus-o=
bject-tree.c"
> > line 1321 function _dbus_decompose_path
> > =A0 /usr/lib/libdbus-1.so.3(_dbus_print_backtrace+0x28) [0xfffff7f4cc9c=
]
> > =A0 /usr/lib/libdbus-1.so.3(_dbus_abort+0x14) [0xfffff7f4fe3c]
> > =A0 /usr/lib/libdbus-1.so.3(+0x4a9cc) [0xfffff7f3a9cc]
> > =A0 /usr/lib/libdbus-1.so.3(+0x36c5c) [0xfffff7f26c5c]
> > =A0 /usr/lib/libdbus-1.so.3(dbus_connection_get_object_path_data+0xc4)
> > [0xfffff7f0f818]
> > =A0 /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed_full+0x30=
)
> > [0x450dc4]
> > =A0 /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed+0x14)
> > [0x450ec0]
> > =A0 /usr/libexec/bluetooth/obexd(manager_emit_transfer_property+0x34)
> > [0x429408]
> > =A0 /usr/libexec/bluetooth/obexd(obex_put_stream_start+0xc8) [0x42b314]
> > =A0 /usr/libexec/bluetooth/obexd() [0x425f58]
> > =A0 /usr/libexec/bluetooth/obexd() [0x42adcc]
> > =A0 /usr/libexec/bluetooth/obexd() [0x4171dc]
> > =A0 /usr/libexec/bluetooth/obexd() [0x418078]
> > =A0 /usr/lib/libglib-2.0.so.0(+0xb20cc) [0xfffff7e420cc]
> > =A0 /usr/lib/libglib-2.0.so.0(+0x54a30) [0xfffff7de4a30]
> > =A0 /usr/lib/libglib-2.0.so.0(g_main_context_dispatch+0x44)
> > [0xfffff7de850c]
> > =A0 /usr/lib/libglib-2.0.so.0(+0x5868c) [0xfffff7de868c]
> > =A0 /usr/lib/libglib-2.0.so.0(g_main_loop_run+0x1ac) [0xfffff7de8b08]
> > =A0 /usr/libexec/bluetooth/obexd(main+0x128) [0x427d6c]
> > =A0 /lib/libc.so.6(+0x2affc) [0xfffff7c0affc]
> > =A0 /lib/libc.so.6(__libc_start_main+0x90) [0xfffff7c0b0c4]
> > =A0 /usr/libexec/bluetooth/obexd(_start+0x30) [0x4101b0]
> >
> > =A0 Program received signal SIGABRT, Aborted.
> >
> > =A0__pthread_kill_implementation (threadid=3D<optimized out>,
> > signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:4
> >
> > Please help support the issue.
> >
> > Thanks,
> > Amisha
