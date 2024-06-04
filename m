Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C30136E2B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481589; cv=none; b=UcYZJJDjp/uIggd41HAgDh4ubUxnOBiWzYBvVEiYDZrKB93imlu3ahpup/nKMIaPcUbu3SexuAbEHxDAL+9I+1RSdhEN+A3baYt4D3amrVscgE9/z97xQyJP4oV9rSj/hrl2AGGhTVLzIphxZ1N/GWBExreeljVR5j8Z3lSBtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481589; c=relaxed/simple;
	bh=nk8FaQIPDz65hZ8Gav0TfzKsigTPUX2Er9pfsnMhYLo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJlkaWXTpWRx8VPGNnlaPBJvOsJGE+gAgg0N96r+bDvptD6xVHT4g81CQO4PL6t1nx+TRotftsYdU6Dxk1MYnNwhv7IEWr3yXc2lWEiidHs6oFiSR10CVzQiKRD3HtQqIzy0PKDN9EQf7RFp8/6oYzg805IVlt7PjvWsCwaD1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYpotitX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYpotitX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45431xrO018795
	for <linux-bluetooth@vger.kernel.org>; Tue, 4 Jun 2024 06:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nk8FaQIPDz65hZ8Gav0TfzKsigTPUX2Er9pfsnMhYLo=; b=OYpotitXkJ5E48Xv
	nk9fjM6y9Hh4xSSVqaWDcPwn+07TULXEKh6ihkQbM+9nTd/0weyOG/VS6wbIjRkV
	LF/3PVtrRe0FXH7OjlHOVu0v1OINyWzZrv3CgGAf3/fQnYt7M+HA2cx/8g7w5444
	1I4Jeq0HSLjI/8pHFglj5wfyss7HkPmNtTBlMPzhl+BJ+RYHmYK3pmU1MaqWhd9k
	+wnQrgN41cn1YlGy8PSw3lc0wrJo9YXLwLzc4e/fqTYcp5zn8y6JU+uDiY57Ufcr
	WLdObsMUbc9xmILHXAIPK5d23C3bJl/y0dnwMbVOIo2CZ+ub/fnjMaDHI1Bf+keU
	8fUJsg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bdv9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jun 2024 06:13:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4546D5Lp025348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 4 Jun 2024 06:13:05 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 23:13:05 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::4223:f723:395d:74fa]) by
 nasanex01c.na.qualcomm.com ([fe80::4223:f723:395d:74fa%13]) with mapi id
 15.02.1544.009; Mon, 3 Jun 2024 23:13:05 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: MAP server crash during connection
Thread-Topic: MAP server crash during connection
Thread-Index: AdqzKJeyPcFb24X1Rwqc4W+GcA5qlwDHZ+PQ
Date: Tue, 4 Jun 2024 06:13:04 +0000
Message-ID: <3ffea594e86647208806e321275df2c6@quicinc.com>
References: <ec4a4adbfee94a699ebd635abc51f01c@quicinc.com>
In-Reply-To: <ec4a4adbfee94a699ebd635abc51f01c@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KtOwWIs6rBNJNAofeT_BPFp2_OIjJS7L
X-Proofpoint-GUID: KtOwWIs6rBNJNAofeT_BPFp2_OIjJS7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=942 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040049

Hi,
Please help with the below issue.

> -----Original Message-----
> From: Amisha Jain (QUIC)
> Sent: Friday, May 31, 2024 12:34 PM
> To: 'linux-bluetooth@vger.kernel.org' <linux-bluetooth@vger.kernel.org>
> Subject: MAP server crash during connection
>=20
> Hi bluez team,
> I have been trying to verify MAP Server obex profile on bluez 5.65.
> While trying=A0connection, I have noticed the crash on the server side
> (connection initiated from client side) and hence connection is failing.
> Please find the backtrace of the crash -
>=20
> =A0 assertion failed "i =3D=3D len" file "../../dbus-1.14.8/dbus/dbus-obj=
ect-tree.c"
> line 1321 function _dbus_decompose_path
> =A0 /usr/lib/libdbus-1.so.3(_dbus_print_backtrace+0x28) [0xfffff7f4cc9c]
> =A0 /usr/lib/libdbus-1.so.3(_dbus_abort+0x14) [0xfffff7f4fe3c]
> =A0 /usr/lib/libdbus-1.so.3(+0x4a9cc) [0xfffff7f3a9cc]
> =A0 /usr/lib/libdbus-1.so.3(+0x36c5c) [0xfffff7f26c5c]
> =A0 /usr/lib/libdbus-1.so.3(dbus_connection_get_object_path_data+0xc4)
> [0xfffff7f0f818]
> =A0 /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed_full+0x30)
> [0x450dc4]
> =A0 /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed+0x14)
> [0x450ec0]
> =A0 /usr/libexec/bluetooth/obexd(manager_emit_transfer_property+0x34)
> [0x429408]
> =A0 /usr/libexec/bluetooth/obexd(obex_put_stream_start+0xc8) [0x42b314]
> =A0 /usr/libexec/bluetooth/obexd() [0x425f58]
> =A0 /usr/libexec/bluetooth/obexd() [0x42adcc]
> =A0 /usr/libexec/bluetooth/obexd() [0x4171dc]
> =A0 /usr/libexec/bluetooth/obexd() [0x418078]
> =A0 /usr/lib/libglib-2.0.so.0(+0xb20cc) [0xfffff7e420cc]
> =A0 /usr/lib/libglib-2.0.so.0(+0x54a30) [0xfffff7de4a30]
> =A0 /usr/lib/libglib-2.0.so.0(g_main_context_dispatch+0x44) [0xfffff7de85=
0c]
> =A0 /usr/lib/libglib-2.0.so.0(+0x5868c) [0xfffff7de868c]
> =A0 /usr/lib/libglib-2.0.so.0(g_main_loop_run+0x1ac) [0xfffff7de8b08]
> =A0 /usr/libexec/bluetooth/obexd(main+0x128) [0x427d6c]
> =A0 /lib/libc.so.6(+0x2affc) [0xfffff7c0affc]
> =A0 /lib/libc.so.6(__libc_start_main+0x90) [0xfffff7c0b0c4]
> =A0 /usr/libexec/bluetooth/obexd(_start+0x30) [0x4101b0]
>=20
> =A0 Program received signal SIGABRT, Aborted.
>=20
> =A0__pthread_kill_implementation (threadid=3D<optimized out>,
> signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:4
>=20
> Please help support the issue.
>=20
> Thanks,
> Amisha
