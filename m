Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B707464
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203145; cv=none; b=LsA8Qy4+K9WvuQ0ZmAcpt9o6yPMV+a5SB/wgCzLoyeGrWpwVz5Mz3J2i4oP3ytwLXl1098fTaGwRedBws8U0Vs5hGzzL/A8tDL85SqvFH3boyPGz1osXA4H32tuaxBG0ITN4DB6c35GdRmfHZQxnOJpH5WgGbFVnvHTH1JFIKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203145; c=relaxed/simple;
	bh=bDyb5Rwxq3Cy+8JGVN2dneh9+lJGIoWCSXwFaaulY2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AobZMfxmDbk5NjbGsnuEE8VUCgzr+78bnNTDpTgNl2dAiirGVao3me6sJS5GVhoF2NZmoHOBvSbg6IEUhpRKg5E2MwI7DFhw103ptOPbBzqcra2FEAdb8DCqXwv6pGxG4NvGftsUTWC6BKeKM0ENkotQTp8R3Fb19w7hsau7I4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FkT0aSrH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FkT0aSrH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TATZkG017467;
	Tue, 29 Oct 2024 11:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bDyb5Rwxq3Cy+8JGVN2dneh9+lJGIoWCSXwFaaulY2M=; b=FkT0aSrH4a9Jb3eq
	fjfLBVSY5xLREOcga4IlptDLV6JkEvuqm8e19KtGX+gP/79AJkNOLrDpxI7A7P8k
	RKt52D7dOUI71yEf6kbDRjmurArlKCJ3fxG7r+o5UJ47b0WlitcluYD1/MIseXDw
	fke+7+xUkj93kzxS5oxEJ1GZxusL+vezDM7mrygZdkCwW351p2ekUkYTcvGYkA9M
	uOXU1jrlT1TK0vexF/yqIVtVFyJMDZIP7ApOFi3MToxgzt8MSdSexMqhzYaNNzKs
	u/fTWOyoyudP93lO71WdMeDNZhzfB5Qa6e7raSYVgNN5FstF5apSX648/1KRLWdj
	UsszOw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrgr7p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 11:59:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TBx0Xx018952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 11:59:00 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 04:59:00 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::cfa9:539b:fb6d:d257]) by
 nasanex01c.na.qualcomm.com ([fe80::cfa9:539b:fb6d:d257%13]) with mapi id
 15.02.1544.009; Tue, 29 Oct 2024 04:58:59 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi
 (QUIC)" <quic_hbandi@quicinc.com>,
        "Anubhav Gupta (QUIC)"
	<quic_anubhavg@quicinc.com>
Subject: RE: [PATCH v1] obex : Fix for PBAP GET request in PTS testing
Thread-Topic: [PATCH v1] obex : Fix for PBAP GET request in PTS testing
Thread-Index: AQHbKSoIN1jpndj60EOJZSA+JzT4a7KcreMAgAFo/gA=
Date: Tue, 29 Oct 2024 11:58:59 +0000
Message-ID: <bb86f6f947174e85813b225d8a51f101@quicinc.com>
References: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
 <CABBYNZKj+pr5yLmrOEcDH9LCDBpvaq0XeBuN8nDzB1SnkNbY-Q@mail.gmail.com>
In-Reply-To: <CABBYNZKj+pr5yLmrOEcDH9LCDBpvaq0XeBuN8nDzB1SnkNbY-Q@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: j5-CERsAFWlrRHjDu4fjTXIahM-SAtS8
X-Proofpoint-GUID: j5-CERsAFWlrRHjDu4fjTXIahM-SAtS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290093

SGkgTHVpeiwNClRoZSBkZWZhdWx0IHBhcmFtIGFkZGVkIGhlcmUgaXMgY29ycmVzcG9uZGluZyB0
byAnTWF4bGlzdENvdW50JyBhdHRyaWJ1dGUgKHRhZyBpZCAtIDB4MDQpIHdoaWNoIHNob3VsZCBi
ZSA2NTUzNSBpZiBpdCBpcyBub3Qgc3BlY2lmaWVkIGJ5IGNsaWVudCBhcyBwZXIgdGhlIFBCQVAg
c3BlYy4gVGhlIHZhbHVlIDY1NTM1IG1lYW5zIHRoYXQgdGhlIG51bWJlciBvZiBlbnRyaWVzIGlz
IG5vdCByZXN0cmljdGVkLg0KSGVyZSBpcyB0aGUgZXhwbGFuYXRpb24gb2YgYXBwbGljYXRpb24g
cGFyYW1ldGVyIGhlYWRlciAtIA0KZGVmYXVsdF9hcHBhcmFtc1tdID0geyAweDA0LCAweDAyLCAw
eGZmLCAweGZmIH0NCg0KICAgICAgMHgwNCAtIFRhZyBpZCAoZm9yIE1heGxpc3RDb3VudCkNCiAg
ICAgIDB4MDIgLSBsZW5ndGgNCiAgICAgIG5leHQgMiBieXRlcyBhcmUgdmFsdWUgLSAweGZmZmYN
Cg0KVGhhbmtzLA0KQW1pc2hhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgT2N0b2JlciAyOCwgMjAyNCA3OjU3IFBNDQo+IFRvOiBBbWlzaGEgSmFpbiAoUVVJ
QykgPHF1aWNfYW1pc2phaW5AcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdl
ci5rZXJuZWwub3JnOyBNb2hhbW1lZCBTYW1lZXIgTXVsbGEgKFFVSUMpDQo+IDxxdWljX21vaGFt
dWxsQHF1aWNpbmMuY29tPjsgSGFyaXNoIEJhbmRpIChRVUlDKQ0KPiA8cXVpY19oYmFuZGlAcXVp
Y2luYy5jb20+OyBBbnViaGF2IEd1cHRhIChRVUlDKQ0KPiA8cXVpY19hbnViaGF2Z0BxdWljaW5j
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gb2JleCA6IEZpeCBmb3IgUEJBUCBHRVQg
cmVxdWVzdCBpbiBQVFMgdGVzdGluZw0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkNCj4gb2YgYW55IGxp
bmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBIaSBB
bWlzaGEsDQo+IA0KPiBPbiBNb24sIE9jdCAyOCwgMjAyNCBhdCA3OjEw4oCvQU0gQW1pc2hhIEph
aW4gPHF1aWNfYW1pc2phaW5AcXVpY2luYy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBj
aGFuZ2UgaXMgcmVxdWlyZWQgZm9yIHBhc3NpbmcgYmVsb3cgUFRTIHRlc3RjYXNlcyAtIDEuDQo+
ID4gUEJBUC9QU0UvUEJEL0JWLTAyLUMgMi4gUEJBUC9QU0UvUEJEL0JWLTAzLUMgMy4gUEJBUC9Q
U0UvUEJEL0JJLTAxLUMNCj4gPiA0LiBQQkFQL1BTRS9QQkQvQlYtMTMtQyA1LiBQQkFQL1BTRS9Q
QkQvQlYtMTQtQyA2Lg0KPiA+IFBCQVAvUFNFL1BCRC9CVi0xNy1DDQo+ID4NCj4gPiBGb3IgYWxs
IHRoZSBHRVQgcGhvbmVib29rIHJlcXVlc3Qgc2VudCBieSBQVFMgaGFzIG5vIGV4dHJhIHBhcmFt
cw0KPiA+IGFkZGVkIGluIGl0LCB0aGVyZWZvcmUgUEJBUCBzZXJ2ZXIgaXMgcmVqZWN0aW5nIHRo
ZSByZXF1ZXN0IGJ5IHNlbmRpbmcNCj4gPiAnQmFkIFJlcXVlc3QnIGFzIHJlc3BvbnNlLg0KPiA+
IFNvIGFwcGVuZGluZyBmZXcgZGVmYXVsdCBwYXJhbXMgaW4gR0VUIHJlcXVlc3QgdG8gYXZvaWQg
dGVzdGNhc2UNCj4gPiBmYWlsdXJlLg0KPiA+DQo+ID4gLS0tDQo+ID4gIG9iZXhkL3BsdWdpbnMv
cGJhcC5jIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvb2JleGQvcGx1Z2lucy9wYmFwLmMgYi9vYmV4ZC9wbHVnaW5z
L3BiYXAuYyBpbmRleA0KPiA+IDQxNzVmOWRlOC4uM2MyMzgxNWJhIDEwMDY0NA0KPiA+IC0tLSBh
L29iZXhkL3BsdWdpbnMvcGJhcC5jDQo+ID4gKysrIGIvb2JleGQvcGx1Z2lucy9wYmFwLmMNCj4g
PiBAQCAtNTI0LDYgKzUyNCwxMSBAQCBzdGF0aWMgaW50IHBiYXBfZ2V0KHN0cnVjdCBvYmV4X3Nl
c3Npb24gKm9zLCB2b2lkDQo+ICp1c2VyX2RhdGEpDQo+ID4gICAgICAgICAgICAgICAgIH07DQo+
ID4gICAgICAgICAgICAgICAgIGJ1ZmZlciA9IGRlZmF1bHRfYXBwYXJhbXM7DQo+ID4gICAgICAg
ICAgICAgICAgIHJzaXplID0gc2l6ZW9mKGRlZmF1bHRfYXBwYXJhbXMpOw0KPiA+ICsgICAgICAg
fSBlbHNlIGlmICghcnNpemUgJiYgZ19hc2NpaV9zdHJjYXNlY21wKHR5cGUsIFBIT05FQk9PS19U
WVBFKQ0KPiA+ICsgPT0gMCkgew0KPiANCj4gSG1tLCB3aGVyZSBkbyB0aGVzZSB2YWx1ZXMgY29t
ZSBmcm9tIHRob3VnaD8gQXJlIHRoZXkgZGVmaW5lZCBpbiB0aGUNCj4gUEJBUCBzcGVjLCBpZiB0
aGV5IGFyZSB0aGVuIHdlIGNhbiBwcm9iYWJseSBxdW90ZSB0aGUgc3BlYy4NCj4gDQo+ID4gKyAg
ICAgICAgICAgICAgIHN0YXRpYyBjb25zdCB1aW50OF90IGRlZmF1bHRfYXBwYXJhbXNbXSA9IHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAweDA0LCAweDAyLCAweGZmLCAweGZmIH07DQo+
ID4gKyAgICAgICAgICAgICAgIGJ1ZmZlciA9IGRlZmF1bHRfYXBwYXJhbXM7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJzaXplID0gc2l6ZW9mKGRlZmF1bHRfYXBwYXJhbXMpOw0KPiA+ICAgICAgICAg
fQ0KPiA+DQo+ID4gICAgICAgICBwYXJhbXMgPSBwYXJzZV9hcGFyYW0oYnVmZmVyLCByc2l6ZSk7
DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1
c3RvIHZvbiBEZW50eg0K
