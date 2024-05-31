Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282B80029
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139068; cv=none; b=pgz72L7GocYNu8aZuFn1s4r1oj5FmS8Ys2VNVkFFy1nt4YRSAiymf57X+W9hxVMAxC9OxeU3SW6xZr0c1RPZC5nNzipgKVAgaiZVmpSenMNNOY00Vkve7KHhzFc6DcwM/O3RUxtbxbHEHwcGgbXSyliFhS422ZnifCHTPBSd+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139068; c=relaxed/simple;
	bh=/dZPROiwyfBri1XohbJgsYQ/ZxSPJ0HpY+cRVHjK6Fs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dkBE5pHRJpuq2u/oPWoHRBIt5L8CmdsMvII0mOO2HAfKs2HX0CepAESh9uGCM1sSnMACuW8R8rORB1dnQeM75dF/x4e2Rdeq9bSZSk6JlTGznhK5My1Uqdft97Es5rbs6Fn/j0V3gOYvc5EvP3oLTDj+Jg+qJOVzXkZOuAA14nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jLEE9nEv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jLEE9nEv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V3cX9w015776
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 07:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/dZPROiwyfBri1XohbJgsY
	Q/ZxSPJ0HpY+cRVHjK6Fs=; b=jLEE9nEv80V9lPdn8EPzw3D7KQ8rjZDJz8xH+v
	XM4DqMrtdEgwLy6Wz3VECMbQIUBtWiCQ5MPADFcnv0OWS7ZDNcGgGYxeBck7sDrH
	8diY4lJm8momkn4i05Row9sf+CxxNRJuIAlV/n0JzUv47ObwZoXc8UoduJqxfZk7
	06Q92bGCPrFMFPXd4+2tZ6oTMnQGOrAUQy0frsORPgApGwBjpRbIT2fiAqvcxXI2
	Lu6aRSF+2T0iQa8Q+KqKl9XnJKrOFXbC0T7AXN/QcaU9a3iQFi3wHA2oWe6gHouW
	zV6TH06z/VeM/XjMQeeZbXBoyNGVnz5PupVP5VmRnuF6KAxw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws5rvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 07:04:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V74PWo003817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 07:04:25 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 31 May 2024 00:04:25 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::4223:f723:395d:74fa]) by
 nasanex01c.na.qualcomm.com ([fe80::4223:f723:395d:74fa%13]) with mapi id
 15.02.1544.009; Fri, 31 May 2024 00:04:25 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: MAP server crash during connection
Thread-Topic: MAP server crash during connection
Thread-Index: AdqzKJeyPcFb24X1Rwqc4W+GcA5qlw==
Date: Fri, 31 May 2024 07:04:25 +0000
Message-ID: <ec4a4adbfee94a699ebd635abc51f01c@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yKIjsRcGIkb4Mh6yU7wQ7H55D0PEuiEg
X-Proofpoint-GUID: yKIjsRcGIkb4Mh6yU7wQ7H55D0PEuiEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=774
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310053

Hi bluez team,
I have been trying to verify MAP Server obex profile on bluez 5.65.
While trying=A0connection, I have noticed the crash on the server side (con=
nection initiated from client side) and hence connection is failing.
Please find the backtrace of the crash -

=A0 assertion failed "i =3D=3D len" file "../../dbus-1.14.8/dbus/dbus-objec=
t-tree.c" line 1321 function _dbus_decompose_path
=A0 /usr/lib/libdbus-1.so.3(_dbus_print_backtrace+0x28) [0xfffff7f4cc9c]
=A0 /usr/lib/libdbus-1.so.3(_dbus_abort+0x14) [0xfffff7f4fe3c]
=A0 /usr/lib/libdbus-1.so.3(+0x4a9cc) [0xfffff7f3a9cc]
=A0 /usr/lib/libdbus-1.so.3(+0x36c5c) [0xfffff7f26c5c]
=A0 /usr/lib/libdbus-1.so.3(dbus_connection_get_object_path_data+0xc4) [0xf=
ffff7f0f818]
=A0 /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed_full+0x30) [0=
x450dc4]
=A0 /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed+0x14) [0x450e=
c0]
=A0 /usr/libexec/bluetooth/obexd(manager_emit_transfer_property+0x34) [0x42=
9408]
=A0 /usr/libexec/bluetooth/obexd(obex_put_stream_start+0xc8) [0x42b314]
=A0 /usr/libexec/bluetooth/obexd() [0x425f58]
=A0 /usr/libexec/bluetooth/obexd() [0x42adcc]
=A0 /usr/libexec/bluetooth/obexd() [0x4171dc]
=A0 /usr/libexec/bluetooth/obexd() [0x418078]
=A0 /usr/lib/libglib-2.0.so.0(+0xb20cc) [0xfffff7e420cc]
=A0 /usr/lib/libglib-2.0.so.0(+0x54a30) [0xfffff7de4a30]
=A0 /usr/lib/libglib-2.0.so.0(g_main_context_dispatch+0x44) [0xfffff7de850c=
]
=A0 /usr/lib/libglib-2.0.so.0(+0x5868c) [0xfffff7de868c]
=A0 /usr/lib/libglib-2.0.so.0(g_main_loop_run+0x1ac) [0xfffff7de8b08]
=A0 /usr/libexec/bluetooth/obexd(main+0x128) [0x427d6c]
=A0 /lib/libc.so.6(+0x2affc) [0xfffff7c0affc]
=A0 /lib/libc.so.6(__libc_start_main+0x90) [0xfffff7c0b0c4]
=A0 /usr/libexec/bluetooth/obexd(_start+0x30) [0x4101b0]

=A0 Program received signal SIGABRT, Aborted.

=A0__pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno=
@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:4

Please help support the issue.

Thanks,
Amisha
