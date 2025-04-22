Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED018202C44
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314328; cv=none; b=WDJLP1ZasKJ9+d5VOmq7wyYZGgm5uyR2wg1O2odV0WMlGZ58tF9LLli3NN3SGDZyHNJ2AfB7b6qJwvIjRAO8mVo+Rx6Eu/OVkGLF54zPWIjuyGmNwCgw6IqJbDYz2aRFZ/NUZK1qjsN2XdchnqRaauOjJS89v6dgi3rNysBYpE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314328; c=relaxed/simple;
	bh=IR1J3GpueIDMVHtwvjvZjEWIVTAGqTc7+de2aZCzoLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YmwBgZGDYb65rgSUQDgHKQdArnldU4LEUVyz0z028r64TOdSvVg2MVkxKsiaP4MZOoan5oXg97p1CsJ0oopr/t3+NjZRq7+mCyxVcAtVQ5Sos/IYjXD1quPgCVj5UBVgXy7A0Eg7UxZxXTpZnQ1xXbIQ4u4UXImp2wCGXrKfXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SwUASVeo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SwUASVeo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4Ois0003167;
	Tue, 22 Apr 2025 09:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IR1J3GpueIDMVHtwvjvZjEWIVTAGqTc7+de2aZCzoLM=; b=SwUASVeojx13f/4/
	jHOHuo/VpHxh32UqnnLHsVM87O+92styNfQUmMc8j7vw+1fjC+UAYUsPTEn7K938
	v2ZSgv2ilRDr7WoFGi82KFXspoBWicFXejnXKObzBf658elVZOhwlhDGq36ASP0p
	Sg4isQ7sT55RRNS1UFtLWpxnHe4egInbIlijlk6Fj70hJaR8yFZT97qmOuGF+sEu
	sqozqSQEFjsHTeItI1crpG2/kYx2e0/pzqAdumeacppT11ZtIjnpyQSoZo911A7E
	VukV7vwDjcA9xZUbgMQEcutRlKHgn7wa00NOn84PLITOggxIVXLr2gSAx19WeoIK
	xc05Lw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642u9f0y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:31:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M9VwkO030033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:31:58 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 02:31:57 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::4675:16d:9fb4:f046]) by
 nasanex01c.na.qualcomm.com ([fe80::4675:16d:9fb4:f046%13]) with mapi id
 15.02.1544.009; Tue, 22 Apr 2025 02:31:57 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi
 (QUIC)" <quic_hbandi@quicinc.com>,
        "Anubhav Gupta (QUIC)"
	<quic_anubhavg@quicinc.com>
Subject: RE: [RESEND PATCH v2] obex: Send response to client for Abort request
Thread-Topic: [RESEND PATCH v2] obex: Send response to client for Abort
 request
Thread-Index: AQHbsoJznq+ByPXZfUevtARQAluTXLOuozkAgACfwyA=
Date: Tue, 22 Apr 2025 09:31:57 +0000
Message-ID: <b317f7463bc546d6a118ffcc7ec7493e@quicinc.com>
References: <20250421055814.96955-1-quic_amisjain@quicinc.com>
 <CABBYNZ+umV4SZqVdtFq_ThD9PDpYA41+rZ=EF=xVxgOUXXQwsw@mail.gmail.com>
In-Reply-To: <CABBYNZ+umV4SZqVdtFq_ThD9PDpYA41+rZ=EF=xVxgOUXXQwsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TYaWtQQh c=1 sm=1 tr=0 ts=6807620f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=xqWC_Br6kY4A:10 a=xK3qW6YPlCsA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=ouU___kX6HvrnhbTjasA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: p8OlmgervuV1DZ8BBl9Q0Ftj4rZHi1xL
X-Proofpoint-GUID: p8OlmgervuV1DZ8BBl9Q0Ftj4rZHi1xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220071

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBB
cHJpbCAyMSwgMjAyNSA3OjU3IFBNDQo+IFRvOiBBbWlzaGEgSmFpbiAoUVVJQykgPHF1aWNfYW1p
c2phaW5AcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
OyBNb2hhbW1lZCBTYW1lZXIgTXVsbGEgKFFVSUMpDQo+IDxxdWljX21vaGFtdWxsQHF1aWNpbmMu
Y29tPjsgSGFyaXNoIEJhbmRpIChRVUlDKQ0KPiA8cXVpY19oYmFuZGlAcXVpY2luYy5jb20+OyBB
bnViaGF2IEd1cHRhIChRVUlDKQ0KPiA8cXVpY19hbnViaGF2Z0BxdWljaW5jLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtSRVNFTkQgUEFUQ0ggdjJdIG9iZXg6IFNlbmQgcmVzcG9uc2UgdG8gY2xpZW50
IGZvciBBYm9ydA0KPiByZXF1ZXN0DQo+IA0KPiBIaSBBbWlzaGEsDQo+IA0KPiBPbiBNb24sIEFw
ciAyMSwgMjAyNSBhdCAxOjU44oCvQU0gQW1pc2hhIEphaW4gPHF1aWNfYW1pc2phaW5AcXVpY2lu
Yy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSW5jYXNlIG9mIG9uZ29pbmcgdHJhbnNmZXIsIElm
IHRoZSBjbGllbnQgc2VuZHMgQWJvcnQgcmVxdWVzdCwgU2VydmVyDQo+ID4gaXMgbm90IHNlbmRp
bmcgYW55IHJlc3BvbnNlIGJhY2suDQo+ID4NCj4gPiBJZGVhbGx5IGl0IHNob3VsZCBzZW5kIE9L
IG9yIFN1Y2Nlc3MgcmVwb25zZSBjb2RlIGZvciB0aGUgYWJvcnQgY29tbWFuZC4NCj4gPg0KPiA+
IFRoaXMgaXMgcmVxdWlyZWQgaW4gUFRTIHRlc3RpbmcgZm9yIHBhc3NpbmcgYmVsb3cgdGVzdGNh
c2VzIC0NCj4gPiAxKSBPUFAvU1IvT1BIL0JWLTI3LUkNCj4gPiBUbyB2ZXJpZnkgdGhhdCBhIHNl
cnZlciBjYW4gcmVzcG9uZCB0byBhbiBBQk9SVCBmcm9tIHRoZSBjbGllbnQgZHVyaW5nIGFuDQo+
IE9CRVggb3BlcmF0aW9uLg0KPiA+IDIpRlRQL1NSL09UUi9CVi0wMi1DDQo+ID4gVG8gdmVyaWZ5
IHRoYXQgdGhlIHB1c2hlZCBmaWxlIGlzIGFib3J0ZWQgbm9ybWFsbHkuDQo+ID4gMylQQkFQL1BT
RS9QREYvQlYtMDYtSQ0KPiA+IFZlcmlmeSB0aGF0IHRoZSBQQ0UgY2FuIGFib3J0IGEgUGhvbmUg
Qm9vayBvYmplY3QgZG93bmxvYWQgZnJvbSB0aGUgUFNFLg0KPiA+IDQpUEJBUC9QU0UvUEJGL0JW
LTAzLUkNCj4gPiBWZXJpZnkgdGhhdCB0aGUgUENFIGNhbiBhYm9ydCBhIHZDYXJkLWxpc3Rpbmcg
b2JqZWN0IGRvd25sb2FkIGZyb20gdGhlIFBTRS4NCj4gPg0KPiA+IC0tLQ0KPiA+ICBvYmV4ZC9z
cmMvb2JleC5jIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvb2JleGQvc3JjL29iZXguYyBiL29iZXhkL3NyYy9vYmV4LmMg
aW5kZXgNCj4gPiAzNzBiZmFjOWUuLjAzMzBkNWE3YyAxMDA2NDQNCj4gPiAtLS0gYS9vYmV4ZC9z
cmMvb2JleC5jDQo+ID4gKysrIGIvb2JleGQvc3JjL29iZXguYw0KPiA+IEBAIC0zODksNiArMzg5
LDggQEAgc3RhdGljIHZvaWQgdHJhbnNmZXJfY29tcGxldGUoR09iZXggKm9iZXgsIEdFcnJvcg0K
PiA+ICplcnIsIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4gPg0KPiA+ICAgICAgICAgaWYgKGVyciAh
PSBOVUxMKSB7DQo+ID4gICAgICAgICAgICAgICAgIGVycm9yKCJ0cmFuc2ZlciBmYWlsZWQ6ICVz
XG4iLCBlcnItPm1lc3NhZ2UpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoc3RyY21wKGVyci0+
bWVzc2FnZSwgIlJlcXVlc3Qgd2FzIGFib3J0ZWQiKSA9PSAwKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIG9zX3NldF9yZXNwb25zZShvcywgMCk7DQo+IA0KPiBXZSBzaG91bGRuJ3QgYmUg
Y2hlY2tpbmcgdGhlIGVycm9yIG1lc3NhZ2UgYnV0IHJhdGhlciBjaGVjayB0aGUgZXJyb3IgY29k
ZQ0KPiBHX09CRVhfRVJST1JfQ0FOQ0VMTEVELCB0aGF0IHNhaWQgSSB3b25kZXIgd2h5IHRoaXMg
aXMgbm90IGJlaW5nDQo+IGhhbmRsZWQgZGlyZWN0bHkgaW4gdGhlIGxpa2VzIG9mIGdvYmV4L2dv
YmV4LXRyYW5zZmVyLmM6dHJhbnNmZXJfYWJvcnRfcmVxLCBidXQNCj4gaXQgbG9va3MgbGlrZSBp
dCByZXNwb25kaW5nIGFscmVhZHk6DQo+IA0KDQpZZXMsIGNvZGUgaXMgcHJlc2VudCB0byBzZW5k
IE9LIHJlc3BvbnNlIGluIGdvYmV4L2dvYmV4LXRyYW5zZmVyLmM6dHJhbnNmZXJfYWJvcnRfcmVx
LCBidXQgcmVzcG9uc2UgaXMgbm90IGJlaW5nIHNlbnQgYXQgYWxsIGFmdGVyIEFib3J0IGFuZCBo
ZW5jZSB0ZXN0Y2FzZXMgYXJlIGZhaWxpbmcuDQoNCj4gICAgIHJzcCA9IGdfb2JleF9wYWNrZXRf
bmV3KEdfT0JFWF9SU1BfU1VDQ0VTUywgVFJVRSwNCj4gR19PQkVYX0hEUl9JTlZBTElEKTsNCj4g
ICAgIGdfb2JleF9zZW5kKG9iZXgsIHJzcCwgTlVMTCk7DQo+IA0KPiA+ICAgICAgICAgICAgICAg
ICBnb3RvIHJlc2V0Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4g
Pg0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
