Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FA1E522
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265886; cv=none; b=DXFiMuFpePfKvaMk214UPE3Ede1CIpSgYBtFFnT50ksou19VZ6GN888OYkn7rYy5HCvXTiEDI146faiDgCRT0TCh2FdZo+bkuEHsnu3PMqX6mIIFcomJrgnIdRdJQgYjU8TGrepvAUbFNb/KX4khk9cRNcK6Ql3v5luNYmIuWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265886; c=relaxed/simple;
	bh=KSn6Y52h9DtVgNVDPAu5gNFvi1oFhrpHOR+M85iJNVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtbTFMXN0IWbTiwrGZ6Y9X70w80gFYBzEX8VH8YUkAacOSwFb+g5nkvYmtYKEhHBCjxlpFjP/ScJdAEac3P8oaQ0ivO+EYGH/OzFUunYrcS0wp25O4FRTQnTZggTS2On+00mo9xl2tqecupAPEqnB+jPHggLotRURMKlE/rE3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G127XXQD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G127XXQD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1v7C004566;
	Thu, 30 Jan 2025 19:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KSn6Y52h9DtVgNVDPAu5gNFvi1oFhrpHOR+M85iJNVY=; b=G127XXQDtjmjaB2P
	dFj4lwRq+6CqGx4huynAciIiHXF0+iNtvw4lql14SNi7jjQAJ0QngjnoWvIOVenM
	BqdIU/3aymw8hTycEVEgXYIbhZ3xZxqFkPz9epzxyghJ0GLQ92a0hxL/b3A9RJCv
	xka9phmhWUx3NLepvYefneWncxaCi+Sym7yZfp65uTfMyHdwUItSN+RPAz1ibiCG
	geYZ34DUTcKkqffwRmGYiibg2fyo0tuv1fRjy96mQ9GWYC8WyBtm9kod0//DERVd
	WbiV+H+HZzpP7N6rgfF8Xtj/3H3q3ckk1q00j3cI4OXGifnUNclB8RNlGr6w2Doy
	YaiMuA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7j8318-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 19:38:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50UJc2sk007721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 19:38:02 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 30 Jan 2025 11:38:02 -0800
Received: from nasanex01c.na.qualcomm.com ([fe80::5e20:e07b:8a35:51ee]) by
 nasanex01c.na.qualcomm.com ([fe80::5e20:e07b:8a35:51ee%13]) with mapi id
 15.02.1544.009; Thu, 30 Jan 2025 11:38:02 -0800
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi
 (QUIC)" <quic_hbandi@quicinc.com>,
        "Anubhav Gupta (QUIC)"
	<quic_anubhavg@quicinc.com>
Subject: RE: [PATCH v1] obex: Add supported features tag in MAP Client Connect
 Request
Thread-Topic: [PATCH v1] obex: Add supported features tag in MAP Client
 Connect Request
Thread-Index: AQHbcaw0TGv7naO0lkmbt1NgcMpucbMs/OAAgAK4gyA=
Date: Thu, 30 Jan 2025 19:38:01 +0000
Message-ID: <9c3b4bf424904d30888ec68677696cc3@quicinc.com>
References: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
 <CABBYNZL-26H=BuJvPbrqF8oswWiGWxiX8atNdt5ULYt5Xs3VgA@mail.gmail.com>
In-Reply-To: <CABBYNZL-26H=BuJvPbrqF8oswWiGWxiX8atNdt5ULYt5Xs3VgA@mail.gmail.com>
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
X-Proofpoint-GUID: MXnF-bWYg5oYqQe0PI6QGGFEJrzAALTt
X-Proofpoint-ORIG-GUID: MXnF-bWYg5oYqQe0PI6QGGFEJrzAALTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501300150

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
SmFudWFyeSAyOCwgMjAyNSAxMToyMCBQTQ0KPiBUbzogQW1pc2hhIEphaW4gKFFVSUMpIDxxdWlj
X2FtaXNqYWluQHF1aWNpbmMuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVs
Lm9yZzsgTW9oYW1tZWQgU2FtZWVyIE11bGxhIChRVUlDKQ0KPiA8cXVpY19tb2hhbXVsbEBxdWlj
aW5jLmNvbT47IEhhcmlzaCBCYW5kaSAoUVVJQykNCj4gPHF1aWNfaGJhbmRpQHF1aWNpbmMuY29t
PjsgQW51YmhhdiBHdXB0YSAoUVVJQykNCj4gPHF1aWNfYW51YmhhdmdAcXVpY2luYy5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG9iZXg6IEFkZCBzdXBwb3J0ZWQgZmVhdHVyZXMgdGFn
IGluIE1BUCBDbGllbnQNCj4gQ29ubmVjdCBSZXF1ZXN0DQo+IA0KPiBIaSBBbWlzaGEsDQo+IA0K
PiBPbiBUdWUsIEphbiAyOCwgMjAyNSBhdCAxMjo0M+KAr1BNIEFtaXNoYSBKYWluIDxxdWljX2Ft
aXNqYWluQHF1aWNpbmMuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgY2hhbmdlIGlzIHJl
cXVpcmVkIGZvciBiZWxvdyBQVFMgdGVzdGNhc2UgLQ0KPiA+DQo+ID4gMS4gTUFQL01DRS9NRkIv
QlYtMDYtQw0KPiA+IFZlcmlmeSB0aGF0IHRoZSBNQ0Ugc2VuZHMgaXRzIE1hcFN1cHBvcnRlZEZl
YXR1cmVzIGluIHRoZSBPQkVYIENvbm5lY3QNCj4gPiByZXF1ZXN0IGlmIHRoZSBNU0UgZGVjbGFy
ZXMgc3VwcG9ydCBmb3IgdGhlIGZlYXR1cmUNCj4gPiBNYXBTdXBwb3J0ZWRGZWF0dXJlcyBpbiBD
b25uZWN0IFJlcXVlc3QgaW4gaXRzIFNEUCByZWNvcmQuDQo+ID4NCj4gPiBJZiBTZXJ2ZXIncyBT
RFAgcmVjb3JkIGNvbnRhaW5zIHRoZSBmaWVsZCAnTWFwU3VwcG9ydGVkRmVhdHVyZXMgaW4NCj4g
PiBDb25uZWN0IFJlcXVlc3QnIGFzIHN1cHBvcnRlZCB0aGVuIGluY2x1ZGUgdGhlIHN1cHBvcnRl
ZCBmZWF0dXJlcyB0YWcNCj4gPiBpbiBvYmV4IGNvbm5lY3QgcmVxdWVzdC4NCj4gDQo+IENhbiB5
b3UgaW5jbHVkZSB0aGUgYnRtb24gb3V0cHV0IHdpdGggYW5kIHdpdGhvdXQ/DQo+IA0KYnRtb24g
b3V0cHV0IGRvZXMgbm90IGNhcHR1cmVzIG9iZXggcGFja2V0IHNvIGFkZGluZyBzbm9vcCBwYWNr
ZXQgLQ0KDQpPYmV4IENvbm5lY3QgcmVxdWVzdCB3aXRoIHRoaXMgY2hhbmdlIC0NCk9CRVgNCglS
b2xlOiBDZW50cmFsDQoJQWRkcmVzczogMA0KCVBhY2tldCBTdGF0dXM6IEZpbmFsIFBhY2tldA0K
CU9wY29kZTogQ29ubmVjdA0KCUxlbmd0aDogMzUNCglPQkVYIFZlcnNpb24gTnVtYmVyOiAweDEw
DQoJZmxhZ3MNCglNYXhpbXVtIFBhY2tldCBMZW5ndGg6IDE4MDANCglUYXJnZXQNCgkJSGVhZGVy
IEVuY29kaW5nOiBCeXRlIFNlcXVlbmNlDQoJCUhlYWRlciBJRDogVGFyZ2V0DQoJCUxlbmd0aDog
MTkNCgkJVGFyZ2V0OiBNQVMNCglBcHBsaWNhdGlvbiBQYXJhbWV0ZXJzDQoJCUhlYWRlciBFbmNv
ZGluZzogQnl0ZSBTZXF1ZW5jZQ0KCQlIZWFkZXIgSUQ6IEFwcGxpY2F0aW9uIFBhcmFtZXRlcnMN
CgkJTGVuZ3RoOiA5DQoJCVBhcmFtZXRlcg0KCQkJVGFnOiBNYXAgU3VwcG9ydGVkIEZlYXR1cmVz
DQoJCQlMZW5ndGg6IDQNCgkJCVZhbHVlDQoJCQkJOiBNZXNzYWdlcy1MaXN0aW5nIEZvcm1hdCBW
ZXJzaW9uIDEuMQ0KCQkJCTogRXh0ZW5kZWQgRXZlbnQgUmVwb3J0IDEuMQ0KCQkJCTogSW5zdGFu
Y2UgSW5mb3JtYXRpb24gRmVhdHVyZQ0KCQkJCTogRGVsZXRlIEZlYXR1cmUNCgkJCQk6IFVwbG9h
ZGluZyBGZWF0dXJlDQoJCQkJOiBCcm93c2luZyBGZWF0dXJlDQoJCQkJOiBOb3RpZmljYXRpb24g
RmVhdHVyZQ0KCQkJCTogTm90aWZpY2F0aW9uIFJlZ2lzdHJhdGlvbiBGZWF0dXJlDQoNCk9iZXgg
Q29ubmVjdCByZXF1ZXN0IHdpdGhvdXQgdGhpcyBjaGFuZ2UgLSANCk9CRVgNCglSb2xlOiBDZW50
cmFsDQoJQWRkcmVzczogMA0KCVBhY2tldCBTdGF0dXM6IEZpbmFsIFBhY2tldA0KCU9wY29kZTog
Q29ubmVjdA0KCUxlbmd0aDogMjYNCglPQkVYIFZlcnNpb24gTnVtYmVyOiAweDEwDQoJZmxhZ3MN
CglNYXhpbXVtIFBhY2tldCBMZW5ndGg6IDE4MDANCglUYXJnZXQNCgkJSGVhZGVyIEVuY29kaW5n
OiBCeXRlIFNlcXVlbmNlDQoJCUhlYWRlciBJRDogVGFyZ2V0DQoJCUxlbmd0aDogMTkNCgkJVGFy
Z2V0OiBNQVMNCg0KPiA+IC0tLQ0KPiA+ICBvYmV4ZC9jbGllbnQvbWFwLmMgfCAxOSArKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvb2JleGQvY2xpZW50L21hcC5jIGIvb2JleGQvY2xpZW50L21hcC5j
IGluZGV4DQo+ID4gYjg4MjAzMzViLi4yZmQwZjc0ZWMgMTAwNjQ0DQo+ID4gLS0tIGEvb2JleGQv
Y2xpZW50L21hcC5jDQo+ID4gKysrIGIvb2JleGQvY2xpZW50L21hcC5jDQo+ID4gQEAgLTM5LDYg
KzM5LDcgQEANCj4gPiAgI2RlZmluZSBPQkVYX01BU19VVUlEIFwNCj4gPg0KPiAiXHhCQlx4NThc
eDJCXHg0MFx4NDJceDBDXHgxMVx4REJceEIwXHhERVx4MDhceDAwXHgyMFx4MENceDlBXHg2NiIN
Cj4gPiAgI2RlZmluZSBPQkVYX01BU19VVUlEX0xFTiAxNg0KPiA+ICsjZGVmaW5lIFNVUFBPUlRF
RF9GRUFUVVJFU19UQUcgIDB4MjkNCj4gPg0KPiA+ICAjZGVmaW5lIE1BUF9JTlRFUkZBQ0UgIm9y
Zy5ibHVlei5vYmV4Lk1lc3NhZ2VBY2Nlc3MxIg0KPiA+ICAjZGVmaW5lIE1BUF9NU0dfSU5URVJG
QUNFICJvcmcuYmx1ZXoub2JleC5NZXNzYWdlMSINCj4gPiBAQCAtMjE3OSw2ICsyMTgwLDIzIEBA
IHN0YXRpYyB2b2lkIHBhcnNlX3NlcnZpY2VfcmVjb3JkKHN0cnVjdA0KPiBtYXBfZGF0YSAqbWFw
KQ0KPiA+ICAgICAgICAgICAgICAgICBtYXAtPnN1cHBvcnRlZF9mZWF0dXJlcyA9IDB4MDAwMDAw
MWY7ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgKm1hcF9zdXBwb3J0ZWRfZmVhdHVyZXMoc3Ry
dWN0IG9iY19zZXNzaW9uICpzZXNzaW9uKSB7DQo+ID4gKyAgICAgICBjb25zdCB2b2lkICpkYXRh
Ow0KPiA+ICsNCj4gPiArICAgICAgIC8qIFN1cHBvcnRlZCBGZWF0dXJlIEJpdHMgKi8NCj4gPiAr
ICAgICAgIGRhdGEgPSBvYmNfc2Vzc2lvbl9nZXRfYXR0cmlidXRlKHNlc3Npb24sDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNEUF9BVFRSX01BUF9TVVBQT1JU
RURfRkVBVFVSRVMpOw0KPiA+ICsgICAgICAgaWYgKCFkYXRhKQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gTlVMTDsNCj4gPiArDQo+ID4gKyAgICAgICBpZigqKHVpbnQzMl90ICopZGF0YSAm
IDB4MDAwODAwMDApDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBnX29iZXhfYXBwYXJhbV9z
ZXRfdWludDMyKE5VTEwsDQo+IFNVUFBPUlRFRF9GRUFUVVJFU19UQUcsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMjdmKTsNCj4gDQo+IERvbid0IHRoaW5rIGl0
IGlzIHNhZmUgdG8gY2hlY2sgdGhlIGRhdGEgbGlrZSBhYm92ZSwgd2UgZG9uJ3Qga25vdyBpZiBm
aWVsZA0KPiByZXR1cm5lZCBpcyByZWFsbHkgMzIgYml0cywgcGVyaGFwcyBpdCB3b3VsZCBiZSBh
IGdvb2QgaWRlYSB0byBpbnRyb2R1Y2UNCj4gc29tZXRoaW5nIGxpa2Ugb2JjX3Nlc3Npb25fZ2V0
X2F0dHJpYnV0ZV9sZTMyIHRoYXQgd291bGQgZW5zdXJlIHRoZSB2YWx1ZSBpcw0KPiByZWFsbHkg
MzIgYml0cyBhbmQgYWxzbyBjaGVjayBpdHMgbGl0dGxlL2JpZyBlbmRpYW4gaW4gdGhlIHByb2Nl
c3MuDQo+IA0KDQpBcyBwZXIgdGhlIEJUIFNwZWMsIDMyIGJpdHMgZmllbGQgaXMgcmVzZXJ2ZWQg
Zm9yICdNYXBTdXBwb3J0ZWRGZWF0dXJlcycgYXR0cmlidXRlIGluIFNEUCByZWNvcmQuIFNvLCBp
dCB3aWxsIGJlIGFsd2F5cyAzMiBiaXRzLiBFYWNoIGJpdCBjb3JyZXNwb25kcyB0byBlYWNoIGZl
YXR1cmUuIElmIGFueSBmZWF0dXJlIGlzIG5vdCBzdXBwb3J0ZWQgdGhlbiB0aGF0IGJpdCB3aWxs
IGJlIHplcm8uDQoNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gTlVMTDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiAgc3RhdGljIGludCBtYXBfcHJvYmUoc3RydWN0IG9iY19zZXNzaW9uICpzZXNzaW9u
KSAgew0KPiA+ICAgICAgICAgc3RydWN0IG1hcF9kYXRhICptYXA7DQo+ID4gQEAgLTIyMjQsNiAr
MjI0Miw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb2JjX2RyaXZlciBtYXAgPSB7DQo+ID4gICAgICAgICAu
dXVpZCA9IE1BU19VVUlELA0KPiA+ICAgICAgICAgLnRhcmdldCA9IE9CRVhfTUFTX1VVSUQsDQo+
ID4gICAgICAgICAudGFyZ2V0X2xlbiA9IE9CRVhfTUFTX1VVSURfTEVOLA0KPiA+ICsgICAgICAg
LnN1cHBvcnRlZF9mZWF0dXJlcyA9IG1hcF9zdXBwb3J0ZWRfZmVhdHVyZXMsDQo+ID4gICAgICAg
ICAucHJvYmUgPSBtYXBfcHJvYmUsDQo+ID4gICAgICAgICAucmVtb3ZlID0gbWFwX3JlbW92ZQ0K
PiA+ICB9Ow0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IEx1
aXogQXVndXN0byB2b24gRGVudHoNCg0KVGhhbmtzLA0KQW1pc2hhDQo=
