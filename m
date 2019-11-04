Return-Path: <SRS0=jKvG=Y4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A20CA9ED3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 22:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A44204FD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 22:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bJKa8BEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbfKDW0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:26:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:37964 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbfKDW0v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Nov 2019 17:26:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 14:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="195610322"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2019 14:26:50 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 4 Nov 2019 14:26:50 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 4 Nov 2019 14:26:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVjz1wi2wCCTQAxs7ElaNEWFpswismkjG6uvHMmVGOTi/VzJ/rD5GsxyrOz7+h2iDjjkkRewL6sW6IFcvfTOm0A/rGM5zZtWibOlL/sMM2oqQ9FjUXdKaEW/vrsCYTWMk1icAKCcOjYN+N1l2o9xmqbvdLYsEUE3c+jSPZAJ7eobwITlLL/dY4U4LzwcBMa9kE4LJk3uw38/Mi1VnVLgdlBsaEDif1feu4vbPk0n5Gwo2BLzqAzOST0GuphtGKsP6RItGP664UhZ8dzgV0fTACmWF732fa1X8LGGx18oNcXt2F+DQJ4WFiiZ8baWJuLwNWjWWQTIvXk71nZnhUgsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9lXK70tPAnICxzwRC2JpksuY5ny5L45LQilC8V+MC0=;
 b=f24pC2dzzSWfDiU2DIClbwroO5eJsQDrvWJZIrpwJ5bnlyeprz/88YfGNfUJDUhtlEx3N5fm5dH5AQvmjljKpZ/eAkFHHWf58CphAmTQE9IlN3cPdFvHSmhpPBJl35AD2Rnb93IGH0rHLcSuIsqg8CvzD/QxnQq6rE1Xbd+YVWXo/6GqSCGd0+8476NCWouJmixM7L6h3JLdJTOJZ38jyvGzKIdUcC9+hLP1MVBqbjNjPcIqwfKLr93iLc+xPKE0ff2W23dU7bweUXExV0vB8XiN0sZW6vMlmAbEk/LZ2b816G+8XSG3YfaML+oOioIPo+wBEVzGbutPtVHjzUGfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9lXK70tPAnICxzwRC2JpksuY5ny5L45LQilC8V+MC0=;
 b=bJKa8BEjbAZufqkoLbf6XjR0TlXA5U989Sisq6EnzMU3SVM3T6W4eI9HJZU1pX/K6/qnVzxWErUDErmwgxR9xlpxkyPKYZXnFQ14b+G/Nq0MiOE32ADNtzIFlDhDuSlTf39LxMI1xPWysAhH0m3vJRtW9xPxy6gcPlfFL669D7Q=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2088.namprd11.prod.outlook.com (10.172.75.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 22:26:48 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 22:26:48 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "stefan.seyfried@googlemail.com" <stefan.seyfried@googlemail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: test-mesh-crypto segfaults
Thread-Topic: test-mesh-crypto segfaults
Thread-Index: AQHVk1VO68tQgsqZz0+1Ib+798NR36d7ktsAgAAEXYA=
Date:   Mon, 4 Nov 2019 22:26:48 +0000
Message-ID: <295dfc627e4f1ccf61fe644062098b44b1e28b0d.camel@intel.com>
References: <5f75011d-a157-cab2-72df-0209f7a30f21@message-id.googlemail.com>
         <70299d5df034aa0174a9263ea8736b56fd9bbd02.camel@intel.com>
In-Reply-To: <70299d5df034aa0174a9263ea8736b56fd9bbd02.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcdd7679-8844-4247-447a-08d761761542
x-ms-traffictypediagnostic: CY4PR1101MB2088:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2088006AD25666EF672752AEE17F0@CY4PR1101MB2088.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(71200400001)(71190400001)(6246003)(76176011)(86362001)(6436002)(6506007)(102836004)(229853002)(5660300002)(6486002)(107886003)(6116002)(3846002)(446003)(11346002)(6512007)(2616005)(476003)(14444005)(256004)(4326008)(186003)(486006)(66066001)(2906002)(8936002)(305945005)(8676002)(66946007)(478600001)(14454004)(81156014)(81166006)(36756003)(3480700005)(316002)(110136005)(118296001)(2501003)(26005)(7736002)(66476007)(91956017)(76116006)(64756008)(66446008)(66556008)(99286004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2088;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FK8/7UwdYuCIMRxBKyT46zAViHqhsKbdoGsqb8sI2pSf3GZaBez2mGEcw+76TSnPKq9jBIfpKLamNEulkfm62twsnu/bk4cV070TxMlCJ7Iw/2JNy8YCMIGSW+6Szi0VRoOlGBG6O/0g6YtlR62ylCvQ6zd4BGQSUzqrbbuGjW/SFq/1W80IXZCGhRtBnpXDRAp6fJ2Y0EtSrkEdGhFnGDo4nQp9np2G0MIbpNWHKoXIbT+XPnz4i8lEB3zInYwG570/kIOPtKgkhg46178KgkZThpQX8s4CGfLX2My/EV7FnLtWYkMsZoGZ/hPsgnIPfeHjevIocGFTC1I81lHbBvuV51CJXV0lz6nleLA3ld0vnEg8PKcZwkRVgrB8yeKyzaOJG1SLBHUONTpH+u6VybXrYbLOMgemIvNt0s62zcYLk7tzxj56ZsyxXnACE2kl
Content-Type: text/plain; charset="utf-8"
Content-ID: <181C93D59A39C943865832B5A95463CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdd7679-8844-4247-447a-08d761761542
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 22:26:48.5854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OskCIJ/bMFZ/qpND+WLU7rNDPSJWgAHvr/3ESJSZ7k9vrYcQaQbp6bCzLy+PVleJ/0qaTFCPAgymOWm8VY7fww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2088
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QWxzbywgbWFrZSBzdXJlIHlvdXIgRUxMIHZlcnNpb24gaXMgYXQgbGVhc3QgUmVsZWFzZSAwLjI2
LCBmcm9tIDMwLU9jdC0yMDE5Lg0KDQpPbiBNb24sIDIwMTktMTEtMDQgYXQgMjI6MTEgKzAwMDAs
IEdpeCwgQnJpYW4gd3JvdGU6DQo+IEhpIFN0ZWZhbiwNCj4gDQo+IE9uIE1vbiwgMjAxOS0xMS0w
NCBhdCAyMjoxNiArMDEwMCwgU3RlZmFuIFNleWZyaWVkIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0K
PiA+IHRlc3QtbWVzaC1jcnlwdG8gc2VnZmF1bHRzIGZvciBtZS4NCj4gPiANCj4gPiBhYnVpbGRA
c3Ryb2xjaGk6fi9ycG1idWlsZC9CVUlMRC9ibHVlei01LjUyPiBnZGIgdW5pdC90ZXN0LW1lc2gt
Y3J5cHRvDQo+ID4gDQo+ID4gWy4uLi5dDQo+ID4gDQo+ID4gWzguNi4yIFNlcnZpY2UgRGF0YSB1
c2luZyBOb2RlIElkZW50aXR5XQ0KPiA+IElEIFJlc29sdmluZyBLZXkgICAgID0gODQzOTZjNDM1
YWM0ODU2MGI1OTY1Mzg1MjUzZTIxMGMNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIDg0Mzk2
YzQzNWFjNDg1NjBiNTk2NTM4NTI1M2UyMTBjID0+IFBBU1MNCj4gPiBIYXNoIElucHV0ICAgICAg
ICAgICA9IDAwMDAwMDAwMDAwMDM0YWU2MDhmYmJjMWYyYzYxMjAxDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAwMDAwMDAwMDAwMDAzNGFlNjA4ZmJiYzFmMmM2MTIwMSA9PiBQQVNTDQo+ID4g
SGFzaCAgICAgICAgICAgICAgICAgPSAwMDg2MTc2NWFlZmNjNTdiDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAwMDg2MTc2NWFlZmNjNTdiID0+IFBBU1MNCj4gPiBNZXNoIElEIEJlYWNvbiAg
ICAgICA9IDAxMDA4NjE3NjVhZWZjYzU3YjM0YWU2MDhmYmJjMWYyYzYNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgIDAxMDA4NjE3NjVhZWZjYzU3YjM0YWU2MDhmYmJjMWYyYzYgPT4gUEFTUw0K
PiA+IA0KPiANCj4gVGhpcyBpcyB2ZXJ5IHN0cmFuZ2UuICBUaGUgdW5pdCB0ZXN0IGxvb2tzIGxp
a2UgaXQgaGFzIGNvbXBsZXRlZCBzdWNjZXNzZnVsbHkgKGF0IGxlYXN0IGZyb20gd2hhdCB5b3Ug
Y29weS0NCj4gcGFzdGVkKS4gIFRoYXQgdGVzdCA4LjYuMiBpcyB0aGUgZmluYWwgdGVzdCwgYW5k
IGl0IGxvb2tzIGhhcHB5LiAgQ2FuIHlvdSB2ZXJpZnkgZm9yIG1lIHRoYXQgYWxsIHRoZSBvdGhl
cg0KPiB0ZXN0cyBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5Pw0KPiANCj4gVGhlcmUgaXMgYSAqc21h
bGwqIGNoYW5jZSB0aGF0IHlvdSBjb3VsZCBiZSBydW5uaW5nIG9uIGFuIG9sZCBrZXJuZWw6ICBL
ZXJuZWxzIHZlcnNpb24gNC44IGFuZCBiZWZvcmUgaGFkIGEgDQo+IGJ1ZyBpbiB0aGUgQUVBRCBj
cnlwdG8gY29kZSB0aGF0IG1hZGUgbWVzaCBjb2RlIChpbmNsdWRpbmcgdGhpcyB1bml0IHRlc3Qp
IGlub3BlcmFibGUuLi4gIEJ1dCB0aGlzIHNob3VsZA0KPiBzaG93DQo+IHVwICpmaXJzdCogaW4g
b25lIG9mIHRoZSBlYXJsaWVyIHRlc3RzIHdpdGhpbiB0aGlzIHVuaXQgdGVzdC4uLiBzbyBsb29r
IGZvciBhbnkgRkFJTCBkZXNpZ25hdGlvbnMuDQo+IA0KPiBUaGUgb3RoZXIgdGhpbmcgYWJvdXQg
dGhpcyBwYXJ0aWN1bGFyIHRlc3QgaXMgdGhhdCBpdCBpcyB0aGUgKm9ubHkqIGJsdWV6IHVuaXQg
dGVzdCB3aGljaCBpcyBiYXNlZCBvbiBFTEwNCj4gKEVtYmVkZGVkIExpbnV4IExpYnJhcnkpIGlu
c3RlYWQgb2YgR0xJQi4NCj4gDQo+IEFyZSB5b3UgcnVubmluZyBmcm9tIGFuIGluc3RhbGxlZCBF
TEwgd2hlbiBjb21waWxpbmcgYmx1ZXosIG9yIGRvIHlvdSBoYXZlIEVMTCBpbiBhICJwZWVyIGRp
cmVjdG9yeSIuLi4gRm9yDQo+IGluc3RhbmNlOg0KPiANCj4gLi4uL3dvcmsvZWxsDQo+IC4uLi93
b3JrL2JsdWV6IA0KPiANCj4gSWYgeW91IGhhdmUgdGhlIEVMTCBzb3VyY2UgY29kZSBhdmFpbGFi
bGUsIHBsZWFzZSB0cnkgcnVubmluZzoNCj4gZWxsICUgbWFrZSBjaGVjaw0KPiANCj4gcGF5aW5n
IHBhcnRpY3VsYXIgYXR0ZW50aW9uIHRvIHRoZSBvdXRwdXQgb2Y6DQo+IHVuaXQvdGVzdC1jaXBo
ZXINCj4gDQo+IElmIHVuaXQvdGVzdC1jaXBoZXIgaW4gRUxMIHBhc3NlcywgdGhlbiB1bml0L3Rl
c3QtbWVzaC1jcnlwdG8gaW4gQkxVRVogc2hvdWxkIHBhc3MuDQo+IA0KPiANCj4gPiBQcm9ncmFt
IHJlY2VpdmVkIHNpZ25hbCBTSUdTRUdWLCBTZWdtZW50YXRpb24gZmF1bHQuDQo+ID4gMHgwMDAw
N2ZmZmY3ZTg3NGFlIGluIG1lbTJjaHVua19jaGVjayAoKSBmcm9tIC9saWI2NC9saWJjLnNvLjYN
Cj4gPiAoZ2RiKSBidA0KPiA+ICMwICAweDAwMDA3ZmZmZjdlODc0YWUgaW4gbWVtMmNodW5rX2No
ZWNrICgpIGZyb20gL2xpYjY0L2xpYmMuc28uNg0KPiA+ICMxICAweDAwMDA3ZmZmZjdlOGI2YWYg
aW4gZnJlZV9jaGVjayAoKSBmcm9tIC9saWI2NC9saWJjLnNvLjYNCj4gPiAjMiAgMHgwMDAwNTU1
NTU1NTU3Yzk4IGluIGxfZnJlZSAocHRyPTxvcHRpbWl6ZWQgb3V0PikgYXQgZWxsL3V0aWwuYzox
MzYNCj4gPiAjMyAgbF9xdWV1ZV9jbGVhciAocXVldWU9MHg1NTU1NTU1NmQwMTAsIGRlc3Ryb3k9
MHg1NTU1NTU1NTdjNjANCj4gPiA8bF9mcmVlPikgYXQgZWxsL3F1ZXVlLmM6MTA3DQo+ID4gIzQg
IDB4MDAwMDU1NTU1NTU1NzIxMCBpbiBfc3ViX0RfNjU1MzVfMS43MDIxICgpIGF0IGVsbC9jaXBo
ZXIuYzozMTkNCj4gPiAjNSAgMHgwMDAwN2ZmZmY3ZmUyYzEzIGluIF9kbF9maW5pICgpIGZyb20g
L2xpYjY0L2xkLWxpbnV4LXg4Ni02NC5zby4yDQo+ID4gIzYgIDB4MDAwMDdmZmZmN2UzZjg3NyBp
biBfX3J1bl9leGl0X2hhbmRsZXJzICgpIGZyb20gL2xpYjY0L2xpYmMuc28uNg0KPiA+ICM3ICAw
eDAwMDA3ZmZmZjdlM2ZhMmMgaW4gZXhpdCAoKSBmcm9tIC9saWI2NC9saWJjLnNvLjYNCj4gPiAj
OCAgMHgwMDAwN2ZmZmY3ZTI3ZTEyIGluIF9fbGliY19zdGFydF9tYWluICgpIGZyb20gL2xpYjY0
L2xpYmMuc28uNg0KPiA+ICM5ICAweDAwMDA1NTU1NTU1NTdiOGEgaW4gX3N0YXJ0ICgpIGF0IC4u
L3N5c2RlcHMveDg2XzY0L3N0YXJ0LlM6MTIwDQo+ID4gDQo+ID4gdGhpcyBpcyByZXByb2R1Y2li
bGUgaGVyZSwgSSdtIGRpc2FibGluZyB0aGlzIHRlc3QgZm9yIG5vdyBpbiB0aGUNCj4gPiBvcGVu
U1VTRSBwYWNrYWdlIGJ1aWxkLg0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcw0K
