Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA90FC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E30B217F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 20:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zbhrsypa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfLBULT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:11:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:59211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfLBULS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 15:11:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 12:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="222558710"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2019 12:11:17 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Dec 2019 12:11:17 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Dec 2019 12:11:17 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.50) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 2 Dec 2019 12:11:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj47KkxN/j6aEPVJkDnq3ZVj32BnZ/6V80qCXRCpslNX7YWnQLXABX82yOKqWeBMOBI9OB4tB47MyjFz1ABYENgBCo4slQgUEH9hXr9F4TeVHkmCbXajRG25HCVjIRTf0TWbV/JbHZaGAgVOvDl5ca6thxhLb1wu21wi1CYhw4kNhZheQ1aYwq7dYXD+SkVV57luOFuWsIlbXsUNJxVziHCBM4nTCUy5FMxyXjCfB5MNGn5eeTBqK1YZZABMtf6Qw4n6FkErHxQYKQNioWCcEh6XE9vDQl6cW/thyjtP45RkVoGVBoQU51KG7l4/xead5bi1SUMkGCzqKRkuCVlmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stJERlHEi27TxtR27MsV/adG3T4db0Z6x+Q2RObmi2g=;
 b=UL2xRhqNicGpsyoK+5Fhhpa3mBvlVW6/hjsQJDVsWj7IqYNb/uzEuZZ5yudiRNbt8sgK1+Wd0NNdRyj6SZPiRFAo5q1SLzuijvk7ycai2gSMdJCPXSjv5XLD+gE4Z8dlFidghtQ2eWKCTRD7cGI7kQs5gXCn5V7ImpuP/D7i4tPRQWyw5MEi/6TpIwy2gyQs/trKLMvlUAF7slGmmu2NfyNzUg7eU35kWTs5HEOjryGe4A7ggnjmj79FN7jbIlYqCfbS6TM6debiLHnIDdvfr82kiSF9Gvt7QldnHRL8mtkvSm/t3Kd9i2XHrZTzNCy0r074MCrhn+qrYkdqagdpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stJERlHEi27TxtR27MsV/adG3T4db0Z6x+Q2RObmi2g=;
 b=zbhrsypaic/imuFw8bAuJH/jwrNKlMK38ajhkqjFYeUxtyGwRto9CCERydSdHwfTJ72RehSIhycvryF3DslVXYhuFLVUhLyZISto2JRfQTe0RsEjQ1+bUqUUOXt1PqXf1G+rg65JGoIjYI6QbKyJMXbw8s2zBdE+XTyJtyYQ1co=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1671.namprd11.prod.outlook.com (10.172.68.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Mon, 2 Dec 2019 20:10:57 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:10:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: fix (re)transmit count & interval steps
Thread-Topic: [PATCH BlueZ] mesh: fix (re)transmit count & interval steps
Thread-Index: AQHVmMnbRyDJPl5+Z02p6iAJ4vinOKenZ6IA
Date:   Mon, 2 Dec 2019 20:10:57 +0000
Message-ID: <d7133754c5fc39059df6136804aecc1ba2bb0966.camel@intel.com>
References: <20191111195406.3291-1-aurelien@aurel32.net>
In-Reply-To: <20191111195406.3291-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a88bbf0a-1636-4f3c-979e-08d77763be71
x-ms-traffictypediagnostic: CY4PR11MB1671:
x-microsoft-antispam-prvs: <CY4PR11MB167111A17FBF17FFB049E7E5E1430@CY4PR11MB1671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:192;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(6512007)(6486002)(25786009)(478600001)(8936002)(81166006)(186003)(71200400001)(2501003)(14454004)(256004)(66946007)(81156014)(3846002)(76176011)(2906002)(66066001)(14444005)(6116002)(102836004)(5660300002)(6506007)(36756003)(91956017)(2616005)(8676002)(26005)(118296001)(71190400001)(99286004)(229853002)(110136005)(316002)(11346002)(66446008)(6246003)(64756008)(66556008)(446003)(305945005)(86362001)(66476007)(4001150100001)(6436002)(76116006)(7736002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1671;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkXNZ3I1aghevhy7Sls+9zSri0KQUrb6181fUVMeiFiL5yhUtw+Du3xnUiPFvhFZn3XGBflBGKhiIa019B8luNVT/AWyjVtM5N4tpp1aKC9lD7JehBdcgb9BKo0r5MlDRgCHLf2fr66ZMQHvnh3Z1f6+/AhTfDFeATnhYnkIMt+VMSWzkpuWxTaqnVgzD6yBGTeUZWB5SF6cNG+joLBWD9Tzv1flHRgS379+A/cogM6JQN89jpWxKNqLBdcpqggCpcz9fr8ijzNusnsmppnv205TFH413aSo7Rs9FdQMI8LD8R7ltv6fzMIgE+5OE+fXuy7iYOjcTFK26sbEv6txu5wxUWGxfFZkZJ3gzIsVNkKnUyeyJOFtJhhgmA8dzj2XXzA12wUdEbtjvwl8IHSN1zKM7KpLImFWZ7DPBi0fyJ1r3AGaXQ5FlHSIMC+y4kce
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5870DEAF56AC7C438F174D1B723168A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a88bbf0a-1636-4f3c-979e-08d77763be71
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 20:10:57.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qC4vxjdHRdP/+5XXErbXy68w+6Fr4lsZvMVe7MFCSNFnPBQbCRYS0AVB4usqX0Fl+861x+ZEYknbmcbymSrmlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1671
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZC4uLiBUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQpPbiBNb24sIDIwMTktMTEtMTEgYXQg
MjA6NTQgKzAxMDAsIEF1cmVsaWVuIEphcm5vIHdyb3RlOg0KPiBUaGUgRm91bmRhdGlvbiBNb2Rl
bCBMYXllciB1c2VzIGxpdHRsZSBlbmRpYW4gb3JkZXJpbmcuIEFzIGENCj4gY29uc2VxdWVuY2Ug
dGhlIChyZSl0cmFuc21pdCBjb3VudCBhbmQgaW50ZXJ2YWwgc3RlcHMgaW4gdGhlIENvbmZpZw0K
PiBSZWxheSwgQ29uZmlnIE1vZGVsIFB1YmxpY2F0aW9uIGFuZCBDb25maWcgTmV0d29yayBUcmFu
c21pdCBtZXNzYWdlcw0KPiB1c2UgdGhlIGxvd2VyIDMgYml0cyBmb3IgdGhlIChyZSl0cmFuc21p
c3Npb24gY291bnQgYW5kIHRoZSBoaWdoZXIgNQ0KPiBiaXRzIGZvciB0aGUgaW50ZXJ2YWwgc3Rl
cHMuDQo+IA0KPiBUaGUgZmlndXJlIDQuNSBpbiBzZWN0aW9uIDQuMy4yLjE2IG9mIHRoZSBNZXNo
IFByb2ZpbGUgQmx1ZXRvb3RoDQo+IFNwZWNpZmljYXRpb24gcHJvdmlkZXMgYSBnb29kIGNsYXJp
ZmljYXRpb24uDQo+IA0KPiBUaGlzIHBhdGNoIHRoZXJlZm9yZSBmaXhlcyB0aG9zZSBtZXNzYWdl
cyBmb3IgYm90aCB0aGUgZGFlbW9uIGFuZA0KPiBjb25maWd1cmF0aW9uIGNsaWVudCBwYXJ0cy4N
Cj4gLS0tDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4g
IG1lc2gvbW9kZWwuYyAgICAgICAgIHwgIDQgKystLQ0KPiAgdG9vbHMvbWVzaC9jZmdjbGkuYyAg
fCAgOCArKysrLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL2NmZ21vZC1zZXJ2ZXIuYyBiL21l
c2gvY2ZnbW9kLXNlcnZlci5jDQo+IGluZGV4IDU1Y2M4ZTllYi4uOGFjZGU5NWI5IDEwMDY0NA0K
PiAtLS0gYS9tZXNoL2NmZ21vZC1zZXJ2ZXIuYw0KPiArKysgYi9tZXNoL2NmZ21vZC1zZXJ2ZXIu
Yw0KPiBAQCAtMjExLDggKzIxMSw4IEBAIHN0YXRpYyBib29sIGNvbmZpZ19wdWJfc2V0KHN0cnVj
dCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICAJCQkudHRsID0gdHRsLA0K
PiAgCQkJLmNyZWRlbnRpYWwgPSBjcmVkX2ZsYWcsDQo+ICAJCQkucGVyaW9kID0gcGVyaW9kLA0K
PiAtCQkJLmNvdW50ID0gcmV0cmFuc21pdCA+PiA1LA0KPiAtCQkJLmludGVydmFsID0gKCgweDFm
ICYgcmV0cmFuc21pdCkgKyAxKSAqIDUwDQo+ICsJCQkuY291bnQgPSByZXRyYW5zbWl0ICYgMHg3
LA0KPiArCQkJLmludGVydmFsID0gKChyZXRyYW5zbWl0ID4+IDMpICsgMSkgKiA1MA0KPiAgCQl9
Ow0KPiAgDQo+ICAJCWlmIChiX3ZpcnQpDQo+IEBAIC04NzAsOCArODcwLDggQEAgc3RhdGljIGJv
b2wgY2ZnX3Nydl9wa3QodWludDE2X3Qgc3JjLCB1aW50MzJfdCBkc3QsIHVpbnQxNl90IHVuaWNh
c3QsDQo+ICAJCWlmIChzaXplICE9IDIgfHwgcGt0WzBdID4gMHgwMSkNCj4gIAkJCXJldHVybiB0
cnVlOw0KPiAgDQo+IC0JCWNvdW50ID0gKHBrdFsxXSA+PiA1KSArIDE7DQo+IC0JCWludGVydmFs
ID0gKChwa3RbMV0gJiAweDFmKSArIDEpICogMTA7DQo+ICsJCWNvdW50ID0gKHBrdFsxXSAmIDB4
NykgKyAxOw0KPiArCQlpbnRlcnZhbCA9ICgocGt0WzFdID4+IDMpICsgMSkgKiAxMDsNCj4gIAkJ
bm9kZV9yZWxheV9tb2RlX3NldChub2RlLCAhIXBrdFswXSwgY291bnQsIGludGVydmFsKTsNCj4g
IAkJLyogRmFsbCBUaHJvdWdoICovDQo+ICANCj4gQEAgLTg3OSw3ICs4NzksNyBAQCBzdGF0aWMg
Ym9vbCBjZmdfc3J2X3BrdCh1aW50MTZfdCBzcmMsIHVpbnQzMl90IGRzdCwgdWludDE2X3QgdW5p
Y2FzdCwNCj4gIAkJbiA9IG1lc2hfbW9kZWxfb3Bjb2RlX3NldChPUF9DT05GSUdfUkVMQVlfU1RB
VFVTLCBtc2cpOw0KPiAgDQo+ICAJCW1zZ1tuKytdID0gbm9kZV9yZWxheV9tb2RlX2dldChub2Rl
LCAmY291bnQsICZpbnRlcnZhbCk7DQo+IC0JCW1zZ1tuKytdID0gKChjb3VudCAtIDEpIDw8IDUp
ICsgKChpbnRlcnZhbC8xMCAtIDEpICYgMHgxZik7DQo+ICsJCW1zZ1tuKytdID0gKGNvdW50IC0g
MSkgKyAoKGludGVydmFsLzEwIC0gMSkgPDwgMyk7DQo+ICANCj4gIAkJbF9kZWJ1ZygiR2V0L1Nl
dCBSZWxheSBDb25maWcgKCVkKSIsIG1zZ1tuLTFdKTsNCj4gIAkJYnJlYWs7DQo+IEBAIC04ODgs
OCArODg4LDggQEAgc3RhdGljIGJvb2wgY2ZnX3Nydl9wa3QodWludDE2X3Qgc3JjLCB1aW50MzJf
dCBkc3QsIHVpbnQxNl90IHVuaWNhc3QsDQo+ICAJCWlmIChzaXplICE9IDEpDQo+ICAJCQlyZXR1
cm4gdHJ1ZTsNCj4gIA0KPiAtCQljb3VudCA9IChwa3RbMF0gPj4gNSkgKyAxOw0KPiAtCQlpbnRl
cnZhbCA9ICgocGt0WzBdICYgMHgxZikgKyAxKSAqIDEwOw0KPiArCQljb3VudCA9IChwa3RbMF0g
JiAweDcpICsgMTsNCj4gKwkJaW50ZXJ2YWwgPSAoKHBrdFswXSA+PiAzKSArIDEpICogMTA7DQo+
ICANCj4gIAkJaWYgKG1lc2hfY29uZmlnX3dyaXRlX25ldF90cmFuc21pdChub2RlX2NvbmZpZ19n
ZXQobm9kZSksIGNvdW50LA0KPiAgCQkJCQkJCQlpbnRlcnZhbCkpDQo+IEBAIC05MDAsNyArOTAw
LDcgQEAgc3RhdGljIGJvb2wgY2ZnX3Nydl9wa3QodWludDE2X3Qgc3JjLCB1aW50MzJfdCBkc3Qs
IHVpbnQxNl90IHVuaWNhc3QsDQo+ICAJCW4gPSBtZXNoX21vZGVsX29wY29kZV9zZXQoT1BfQ09O
RklHX05FVFdPUktfVFJBTlNNSVRfU1RBVFVTLA0KPiAgCQkJCQkJCQkJbXNnKTsNCj4gIAkJbWVz
aF9uZXRfdHJhbnNtaXRfcGFyYW1zX2dldChuZXQsICZjb3VudCwgJmludGVydmFsKTsNCj4gLQkJ
bXNnW24rK10gPSAoKGNvdW50IC0gMSkgPDwgNSkgKyAoKGludGVydmFsLzEwIC0gMSkgJiAweDFm
KTsNCj4gKwkJbXNnW24rK10gPSAoY291bnQgLSAxKSArICgoaW50ZXJ2YWwvMTAgLSAxKSA8PCAz
KTsNCj4gIA0KPiAgCQlsX2RlYnVnKCJHZXQvU2V0IE5ldHdvcmsgVHJhbnNtaXQgQ29uZmlnIik7
DQo+ICAJCWJyZWFrOw0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5jIGIvbWVzaC9tb2RlbC5j
DQo+IGluZGV4IDg0ZjFkYzc0Yy4uNDVjZGI5M2JiIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVs
LmMNCj4gKysrIGIvbWVzaC9tb2RlbC5jDQo+IEBAIC0xNTM3LDggKzE1MzcsOCBAQCBzdHJ1Y3Qg
bWVzaF9tb2RlbCAqbWVzaF9tb2RlbF9zZXR1cChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
OF90IGVsZV9pZHgsDQo+ICAJaWYgKHB1YiAmJiAocHViLT52aXJ0IHx8ICEoSVNfVU5BU1NJR05F
RChwdWItPmFkZHIpKSkpIHsNCj4gIAkJdWludDhfdCBtb2RfYWRkclsyXTsNCj4gIAkJdWludDhf
dCAqcHViX2FkZHI7DQo+IC0JCXVpbnQ4X3QgcmV0cmFuc21pdCA9IChwdWItPmNvdW50IDw8IDUp
ICsNCj4gLQkJCQkJCShwdWItPmludGVydmFsIC8gNTAgLSAxKTsNCj4gKwkJdWludDhfdCByZXRy
YW5zbWl0ID0gcHViLT5jb3VudCArDQo+ICsJCQkJCSgocHViLT5pbnRlcnZhbCAvIDUwIC0gMSkg
PDwgMyk7DQo+ICANCj4gIAkJLyogQWRkIHB1YmxpY2F0aW9uICovDQo+ICAJCWxfcHV0X2xlMTYo
cHViLT5hZGRyLCAmbW9kX2FkZHIpOw0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC9jZmdjbGku
YyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggMDRlZGM3MDZjLi5kNDY4ZmIyOGMgMTAw
NjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gKysrIGIvdG9vbHMvbWVzaC9jZmdj
bGkuYw0KPiBAQCAtNDcxLDcgKzQ3MSw3IEBAIHN0YXRpYyBib29sIG1zZ19yZWN2ZCh1aW50MTZf
dCBzcmMsIHVpbnQxNl90IGlkeCwgdWludDhfdCAqZGF0YSwNCj4gIAkJCXJldHVybiB0cnVlOw0K
PiAgDQo+ICAJCWJ0X3NoZWxsX3ByaW50ZigiTm9kZSAlNC40eDogUmVsYXkgMHglMDJ4LCBjbnQg
JWQsIHN0ZXBzICVkXG4iLA0KPiAtCQkJCXNyYywgZGF0YVswXSwgZGF0YVsxXT4+NSwgZGF0YVsx
XSAmIDB4MWYpOw0KPiArCQkJCXNyYywgZGF0YVswXSwgZGF0YVsxXSAmIDB4NywgZGF0YVsxXSA+
PiAzKTsNCj4gIAkJYnJlYWs7DQo+ICANCj4gIAljYXNlIE9QX0NPTkZJR19QUk9YWV9TVEFUVVM6
DQo+IEBAIC01MjcsOCArNTI3LDggQEAgc3RhdGljIGJvb2wgbXNnX3JlY3ZkKHVpbnQxNl90IHNy
YywgdWludDE2X3QgaWR4LCB1aW50OF90ICpkYXRhLA0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4g
IA0KPiAtCQlidF9zaGVsbF9wcmludGYoIlJleG1pdCBjb3VudFx0JWRcbiIsIGRhdGFbOV0gPj4g
NSk7DQo+IC0JCWJ0X3NoZWxsX3ByaW50ZigiUmV4bWl0IHN0ZXBzXHQlZFxuIiwgZGF0YVs5XSAm
IDB4MWYpOw0KPiArCQlidF9zaGVsbF9wcmludGYoIlJleG1pdCBjb3VudFx0JWRcbiIsIGRhdGFb
OV0gJiAweDcpOw0KPiArCQlidF9zaGVsbF9wcmludGYoIlJleG1pdCBzdGVwc1x0JWRcbiIsIGRh
dGFbOV0gPj4gMyk7DQo+ICANCj4gIAkJYnJlYWs7DQo+ICANCj4gQEAgLTEwNTYsNyArMTA1Niw3
IEBAIHN0YXRpYyB2b2lkIGNtZF9yZWxheV9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4g
IAl9DQo+ICANCj4gIAltc2dbbisrXSA9IHBhcm1zWzBdOw0KPiAtCW1zZ1tuKytdID0gKHBhcm1z
WzFdIDw8IDUpIHwgcGFybXNbMl07DQo+ICsJbXNnW24rK10gPSBwYXJtc1sxXSB8IChwYXJtc1sy
XSA8PCAzKTsNCj4gIA0KPiAgCWlmICghY29uZmlnX3NlbmQobXNnLCBuLCBPUF9DT05GSUdfUkVM
QVlfU0VUKSkNCj4gIAkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9G
QUlMVVJFKTsNCg==
