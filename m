Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652819DF62
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553904; cv=none; b=GJW2yi80qme34oB4DknpQlHioub0XLAHj5qbR2L7aD4VErdFa4PResZuX3Q62rFErk0f8V9ecZaSsxNXojmzNMwIfVWmJjDfJ5I67XcqJtNA4h5vwjUbjukUA+7jGFxHbfnK5S/x0gkP3dk8Ba2FjYAq7XnOmjLuM2HFkRFxiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553904; c=relaxed/simple;
	bh=YnHDWkp366tU72mr3vfJJ10ZNvw9SQcGSIwvgOoYZVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tj8bXnXwYE9tThds4sjyjkmQStKDLIz0E1bzWuiNYrtccS1eg6Y6FLrpkWYSfsyxKGypYExZKV57cl5tftCLxhDifIBdKuO8EkugL0pzw6ZHW+lcdfmkCnUntJVyw0FWWExMGKjZMtvttWmcwFxmY6F9JJXRigWekr1SOKv5lkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pHFbvLMD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pHFbvLMD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWqqR011767;
	Wed, 26 Feb 2025 07:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YnHDWkp366tU72mr3vfJJ10ZNvw9SQcGSIwvgOoYZVU=; b=pHFbvLMDswFkfMgm
	ib4tWxT1MJVfcs5Gec4sLISIWbY8p/XkRxiFi+d7a5CNwCBkR6Lpq1ZLDS6qNHbU
	O2iwmkMtyTp6Kk1WWXo4A6WVvrdBTr2sec3+FiUUgPeOkGybjxySgQ9JCr7BbP9m
	pEi9LDkXlVKXjcCkI3EdIO7CawNfaxw6VMh6eLbXEB796re5H39Dtmp/5GNmIbKU
	eQHJEcCKoISx69w3+rf4MJEv5XWcJ2K+dsUaatShYbFOxuTBQpjzyiwrt40gpV0r
	L9RkoXq+y2OS+KRnnv/1kvD2yG2tOJUiaxbEt5NeQeWQR1wlw/SNi7DQX0OMXoCl
	kEzDIw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmh2qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 07:11:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q7BVSS013214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 07:11:31 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 23:11:31 -0800
Received: from nasanex01c.na.qualcomm.com ([fe80::ba75:b71c:16c5:acbd]) by
 nasanex01c.na.qualcomm.com ([fe80::ba75:b71c:16c5:acbd%13]) with mapi id
 15.02.1544.009; Tue, 25 Feb 2025 23:11:31 -0800
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi
 (QUIC)" <quic_hbandi@quicinc.com>,
        "Anubhav Gupta (QUIC)"
	<quic_anubhavg@quicinc.com>
Subject: RE: [RESEND PATCH v2] obex: Add messages_get_message() implementation
 for MAP plugin
Thread-Topic: [RESEND PATCH v2] obex: Add messages_get_message()
 implementation for MAP plugin
Thread-Index: AQHbhqz8Fby1kSofWUKSdWO0MVNjsLNXApWAgAIlZTA=
Date: Wed, 26 Feb 2025 07:11:31 +0000
Message-ID: <1937d5048f91464a8bb32fe2466a94b8@quicinc.com>
References: <20250224111056.3255513-1-quic_amisjain@quicinc.com>
 <98149822-8ac9-4099-bb44-16f79419ddc3@molgen.mpg.de>
In-Reply-To: <98149822-8ac9-4099-bb44-16f79419ddc3@molgen.mpg.de>
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
X-Proofpoint-ORIG-GUID: DuioLJ_8KETxqu4IoOIuEtnN5_-riOsK
X-Proofpoint-GUID: DuioLJ_8KETxqu4IoOIuEtnN5_-riOsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260056

SGkgUGF1bCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1l
bnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI0
LCAyMDI1IDc6MzQgUE0NCj4gVG86IEFtaXNoYSBKYWluIChRVUlDKSA8cXVpY19hbWlzamFpbkBx
dWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IE1vaGFt
bWVkIFNhbWVlciBNdWxsYSAoUVVJQykNCj4gPHF1aWNfbW9oYW11bGxAcXVpY2luYy5jb20+OyBI
YXJpc2ggQmFuZGkgKFFVSUMpDQo+IDxxdWljX2hiYW5kaUBxdWljaW5jLmNvbT47IEFudWJoYXYg
R3VwdGEgKFFVSUMpDQo+IDxxdWljX2FudWJoYXZnQHF1aWNpbmMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1JFU0VORCBQQVRDSCB2Ml0gb2JleDogQWRkIG1lc3NhZ2VzX2dldF9tZXNzYWdlKCkNCj4g
aW1wbGVtZW50YXRpb24gZm9yIE1BUCBwbHVnaW4NCj4gDQo+IERlYXIgQW1pc2hhLA0KPiANCj4g
DQo+IEFtIDI0LjAyLjI1IHVtIDEyOjEwIHNjaHJpZWIgQW1pc2hhIEphaW46DQo+ID4gR0VUIE1l
c3NhZ2UoKSBvcGVyYXRpb24gc2hvdWxkIGJlIHN1cHBvcnRlZCBmb3IgcGFzc2luZyBiZWxvdyBQ
VFMNCj4gPiB0ZXN0Y2FzZXMgLQ0KPiA+DQo+ID4gMS5NQVAvTVNFL01NQi9CVi0xMi1DDQo+ID4g
VmVyaWZ5IHRoYXQgdGhlIE1TRSBjYW4gcmV0dXJuIGFuIGVtYWlsIG1lc3NhZ2UgdG8gdGhlIE1D
RS4NCj4gPiAyLk1BUC9NU0UvTU1CL0JWLTEzLUMNCj4gPiBWZXJpZnkgdGhhdCB0aGUgTVNFIGNh
biByZXR1cm4gYSBTTVMgbWVzc2FnZSBpbiBuYXRpdmUgZm9ybWF0IHRvIHRoZSBNQ0UuDQo+IA0K
PiBhKm4qIFNNUw0KPiANCj4gPiAzLk1BUC9NU0UvTU1CL0JWLTE0LUMNCj4gPiBWZXJpZnkgdGhh
dCB0aGUgTVNFIGNhbiByZXR1cm4gYSBTTVMgbWVzc2FnZSB3aXRoIHRleHQgdHJhbnMtY29kZWQg
dG8NCj4gPiBVVEYtOA0KPiANCj4gYSpuKg0KPiANCj4gPiB0byB0aGUgTUNFLg0KPiANCj4gSeKA
mWQgYWRkIGEgc3BhY2UgYWZ0ZXIgdGhlIGJ1bGxldCBwb2ludHMgKHRoZSBkb3QpLg0KPiANCj4g
PiBDdXJyZW50bHkgZ2V0IG1lc3NhZ2Ugb3BlcmF0aW9uIGlzIG5vdCBpbXBsZW1lbnRlZCwgaGVu
Y2UgYWJvdmUNCj4gPiB0ZXN0Y2FzZXMgYXJlIGZhaWxpbmcuDQo+ID4gQWRkZWQgY29kZSB0byBz
ZW5kIHRoZSBjb21wbGV0ZSBibWVzc2FnZSBpbiByZXNwb25zZQ0KPiANCj4gU2hvdWxkIHRoaXMg
YmUgKm1lc3NhZ2UqIG9yIGlzICpibWVzc2FnZSogc29tZSB0ZXJtaW5vbG9neT8NCj4gDQoNClRo
aXMgaXMgJ2JtZXNzYWdlJywgbWVzc2FnZSBmb3JtYXQgdXNlZCBieSBNQVAgdG8gc3RvcmUgbWVz
c2FnZXMuDQpBcyBwZXIgU3BlYywgYk1lc3NhZ2VzIGFyZSBhcHBsaWNhdGlvbiBvYmplY3RzIHVz
ZWQgYnkgTUFQIGZvciBtZXNzYWdlIHRyYW5zcG9ydC4gDQpFeGNoYW5nZWQgbWVzc2FnZXMgc2hh
bGwgdXNlIHRoZSBiTWVzc2FnZSBmb3JtYXQuDQoNCj4gPiB0byB0aGUgZ2V0IHJlcXVlc3QgZm9y
IHRoZSByZXF1ZXN0ZWQgbWVzc2FnZSBoYW5kbGUuDQo+ID4NCj4gPiAtLS0NCj4gPiAgIG9iZXhk
L3BsdWdpbnMvbWFzLmMgICAgICAgICAgICB8ICA0ICsrLS0NCj4gPiAgIG9iZXhkL3BsdWdpbnMv
bWVzc2FnZXMtZHVtbXkuYyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL29iZXhkL3BsdWdpbnMvbWFzLmMgYi9vYmV4ZC9wbHVnaW5zL21hcy5j
IGluZGV4DQo+ID4gMTBiOTcyZDY1Li5mNjNmY2Y2YzYgMTAwNjQ0DQo+ID4gLS0tIGEvb2JleGQv
cGx1Z2lucy9tYXMuYw0KPiA+ICsrKyBiL29iZXhkL3BsdWdpbnMvbWFzLmMNCj4gPiBAQCAtNjEy
LDExICs2MTIsMTEgQEAgc3RhdGljIHZvaWQgKm1lc3NhZ2Vfb3Blbihjb25zdCBjaGFyICpuYW1l
LCBpbnQNCj4gb2ZsYWcsIG1vZGVfdCBtb2RlLA0KPiA+ICAgCQlyZXR1cm4gTlVMTDsNCj4gPiAg
IAl9DQo+ID4NCj4gPiArCW1hcy0+YnVmZmVyID0gZ19zdHJpbmdfbmV3KCIiKTsNCj4gPiArDQo+
ID4gICAJKmVyciA9IG1lc3NhZ2VzX2dldF9tZXNzYWdlKG1hcy0+YmFja2VuZF9kYXRhLCBuYW1l
LCAwLA0KPiA+ICAgCQkJZ2V0X21lc3NhZ2VfY2IsIG1hcyk7DQo+ID4NCj4gPiAtCW1hcy0+YnVm
ZmVyID0gZ19zdHJpbmdfbmV3KCIiKTsNCj4gPiAtDQo+ID4gICAJaWYgKCplcnIgPCAwKQ0KPiA+
ICAgCQlyZXR1cm4gTlVMTDsNCj4gPiAgIAllbHNlDQo+ID4gZGlmZiAtLWdpdCBhL29iZXhkL3Bs
dWdpbnMvbWVzc2FnZXMtZHVtbXkuYw0KPiA+IGIvb2JleGQvcGx1Z2lucy9tZXNzYWdlcy1kdW1t
eS5jIGluZGV4IGUzMTNjNjE2My4uNjY1ZmFjZTNmIDEwMDY0NA0KPiA+IC0tLSBhL29iZXhkL3Bs
dWdpbnMvbWVzc2FnZXMtZHVtbXkuYw0KPiA+ICsrKyBiL29iZXhkL3BsdWdpbnMvbWVzc2FnZXMt
ZHVtbXkuYw0KPiA+IEBAIC01MTYsNyArNTE2LDMyIEBAIGludCBtZXNzYWdlc19nZXRfbWVzc2Fn
ZSh2b2lkICpzZXNzaW9uLCBjb25zdA0KPiBjaGFyICpoYW5kbGUsDQo+ID4gICAJCQkJCW1lc3Nh
Z2VzX2dldF9tZXNzYWdlX2NiIGNhbGxiYWNrLA0KPiA+ICAgCQkJCQl2b2lkICp1c2VyX2RhdGEp
DQo+ID4gICB7DQo+ID4gLQlyZXR1cm4gLUVOT1NZUzsNCj4gPiArCXN0cnVjdCBzZXNzaW9uICpz
ID0gIHNlc3Npb247DQo+ID4gKwlGSUxFICpmcDsNCj4gPiArCWNoYXIgKnBhdGg7DQo+ID4gKwlj
aGFyIGJ1ZmZlclsxMDI0XTsNCj4gPiArDQo+ID4gKwlEQkcoIiAiKTsNCj4gPiArCXBhdGggPSBn
X2J1aWxkX2ZpbGVuYW1lKHMtPmN3ZF9hYnNvbHV0ZSwgaGFuZGxlLCBOVUxMKTsNCj4gPiArCWZw
ID0gZm9wZW4ocGF0aCwgInIiKTsNCj4gPiArCWlmIChmcCA9PSBOVUxMKSB7DQo+ID4gKwkJREJH
KCJmb3BlbigpIGZhaWxlZCIpOw0KPiA+ICsJCXJldHVybiAtRUJBRFI7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJLyogMTAyNCBpcyB0aGUgbWF4aW11bSBzaXplIG9mIHRoZSBsaW5lIHdoaWNoIGlz
IGNhbGN1bGF0ZWQgdG8gYmUgbW9yZQ0KPiA+ICsJICogc3VmZmljaWVudCovDQo+IA0KPiBJIGRv
IG5vdCBmdWxseSBncm9rIHRoaXMgc2VudGVuY2UuIENvdWxkIHlvdSBwbGVhc2UgcmVwaHJhc2U/
DQo+IA0KDQpTdXJlLCB0aGlzIGNvcnJlc3BvbmRzIHRvIG1heCBzaXplIG9mIGEgbGluZSBpbiBh
IGZpbGUsIGFzIHdlIGFyZSByZWFkaW5nIHRoZSBmaWxlIGxpbmUgYnkgbGluZS4NClNhbWUgd2F5
IGl0IGlzIHByZXNlbnQgaW4gZXhpc3RpbmcgZnVuY3Rpb24gLSBnZXRfbWVzc2FnZXNfbGlzdGlu
ZygpLg0KDQpzdGF0aWMgZ2Jvb2xlYW4gZ2V0X21lc3NhZ2VzX2xpc3Rpbmcodm9pZCAqZCkNCnsN
Cg0KICAgICAgICBzdHJ1Y3QgbWVzc2FnZV9saXN0aW5nX2RhdGEgKm1sZCA9IGQ7DQogICAgICAg
IC8qIDEwMjQgaXMgdGhlIG1heGltdW0gc2l6ZSBvZiB0aGUgbGluZSB3aGljaCBpcyBjYWxjdWxh
dGVkIHRvIGJlIG1vcmUNCiAgICAgICAgICogc3VmZmljaWVudCovDQogICAgICAgIGNoYXIgYnVm
ZmVyWzEwMjRdOw0KICAgICAgICBHTWFya3VwUGFyc2VDb250ZXh0ICpjdHh0Ow0KDQo+ID4gKwl3
aGlsZSAoZmdldHMoYnVmZmVyLCAxMDI0LCBmcCkpIHsNCj4gPiArCQlpZiAoY2FsbGJhY2spDQo+
ID4gKwkJCWNhbGxiYWNrKHNlc3Npb24sIDAsIDAsIChjb25zdCBjaGFyKilidWZmZXIsIHVzZXJf
ZGF0YSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGNhbGxiYWNrKQ0KPiA+ICsJCWNhbGxi
YWNrKHNlc3Npb24sIDAsIDAsIE5VTEwsIHVzZXJfZGF0YSk7DQo+ID4gKw0KPiA+ICsJZ19mcmVl
KHBhdGgpOw0KPiA+ICsJZmNsb3NlKGZwKTsNCj4gPiArCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+
DQo+ID4gICBpbnQgbWVzc2FnZXNfdXBkYXRlX2luYm94KHZvaWQgKnNlc3Npb24sIG1lc3NhZ2Vz
X3N0YXR1c19jYg0KPiA+IGNhbGxiYWNrLA0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+
IFBhdWwNCg0KVGhhbmtzLA0KQW1pc2hhDQo=
