Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37512C2D0BF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEDF20637
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nYHo/an9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJP1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:27:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:28688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfLJP1a (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 10:27:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 07:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="264575067"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Dec 2019 07:27:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Dec 2019 07:27:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 07:27:24 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Dec 2019 07:27:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 10 Dec 2019 07:27:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVvDnTKdcMDAZhiP5s9QORUG5LAI0l4x+y7SI+76+pGS7xkjeAh4f8jZalrucN/XPo11Fu6wdhyAq47gHuGjx/dop8xhDbUhbnBv2iEShv9GzTJtFM03yYmzNtHcLL1jpN3e/XfMSd5kYdBqmC70Mi2DStcPsz+IPKNnjySx4joWSz5w/+7FZYqRVpmPvf859+PQoDJ/Ln4sjldNAGlMPdLF6SQvXjI2S1bZnaEAeFvPPPKrBBry/SqRZB2vWZhrl9vtNY3nManOr1mhS2/rY4LKEnPtoez+3h8hpYL9pYlSiH/G60GzYs2Z+pgcEBvDqC7huTvLFlnVzv6QMXPDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGur08Ym4cr1/Gef1UAvdttZ9oCWgN2rz44AVtwdnic=;
 b=F/do7Bjfn2cuM9Osbre3kl2RTGTNCUNmmNBDd8E4nHaIPHAPpcX6ChYcXsulPHbynDdaO0oPOBLu0Z8oo+QYyTqVI44uXELAmSXNc/Ek8pdc64aHwy+8TknxWvNLBa1mXJlTfboz2lytZKNS0d7403ZLj2jWN0+KSsS/Vy4BHK82SAO9OJ5lcCHkAYv6eZ1Av6mSLSa2YayYRPjGV0odY5ICwh/Wh2bfN7M6Rf/suUoy9azZfdz8iNuoAtaTKv8BGl/jGy1ANHwlQeywJknovhTu+w3BP2AAlcgZp93NA5wxQ3Z0/as4AOyLqsGtMcVGQ2jppvrkL/Qzb8l6ovkNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGur08Ym4cr1/Gef1UAvdttZ9oCWgN2rz44AVtwdnic=;
 b=nYHo/an9P8EaHw0c2md512h+eLpkvgfetEdf0yhcwJuIfUFoRCpWHtUaTkqM6xFj60Mno658HzROaiyN2P9YDc3rSpbnYTZrVkUZh9gGnRytZqz4SjAbq8hLgSeeTYbNmBT9rKglYHRp1YUg0Pg6Ofy9zvprM6KsL8kk+WEJ9g4=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB3135.namprd11.prod.outlook.com (52.135.127.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 15:27:21 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 15:27:21 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "aabhay169@gmail.com" <aabhay169@gmail.com>
CC:     "ay.agarwal@samsung.com" <ay.agarwal@samsung.com>,
        "anupam.r@samsung.com" <anupam.r@samsung.com>
Subject: Re: Bluez mesh-cfgclient: Not able to configure the device
Thread-Topic: Bluez mesh-cfgclient: Not able to configure the device
Thread-Index: AQHVrB9+sIWnL/xlskWK5VyfWhGvE6euM7wAgAUkuoCAACvpgA==
Date:   Tue, 10 Dec 2019 15:27:20 +0000
Message-ID: <c68d91215e510b319ac569633f0fcd388d505f73.camel@intel.com>
References: <CALbZ3NJniYdZXgaNDR9778cfbr7kkNhGEeSm3pDqwOHXRp8Thg@mail.gmail.com>
         <083b4e2c7f18c4043ad939289a09c057b4c5e8c5.camel@intel.com>
         <CALbZ3NJ6JDjoB3Vr2aROP6mkJZwL1QtPrrBPyc8X6=PO_C9wsw@mail.gmail.com>
In-Reply-To: <CALbZ3NJ6JDjoB3Vr2aROP6mkJZwL1QtPrrBPyc8X6=PO_C9wsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aa223cc-1151-411b-4907-08d77d85736d
x-ms-traffictypediagnostic: SN6PR11MB3135:
x-microsoft-antispam-prvs: <SN6PR11MB3135DF2483DA93DAAA649614FB5B0@SN6PR11MB3135.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(51914003)(189003)(199004)(498600001)(66476007)(6486002)(76116006)(66446008)(5660300002)(91956017)(81166006)(8676002)(66556008)(64756008)(2906002)(81156014)(66946007)(2616005)(6506007)(36756003)(186003)(110136005)(71200400001)(8936002)(4001150100001)(4326008)(86362001)(6512007)(54906003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3135;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcwednuOWr0+Dc0pr6oZukGt8smPGHyOHxefaCLpehKyOsS577TpsYOKFpUSnaPtjE3GakH8uowJygTCyBBR9autyZ8Xu4vHYR1NEpD3/sO1C/D0D4AQ2gLUoDbfXx+rummFXrGqElGtLSrNgZwPY3BO2uVCqAvQ6NTEnRvdUys4xSAoPOHS4X3AQ3F82PdRMoKFw0MbqyEfbs1IiePegdK28vo4abcVw+e9Ksttgo6FUPO9q/ndiMVQLz8QcwMKf13YulW7oE8Z8hw7b35tC9fcKO7s0UPBakeW1b6hvdyKgJEJSmYruN1KYuiwEE0AGic/CwFuHDjWm/aXr7sZwu2kYXq0zm0m5keu9hG9rAD9ePAZcOguBGNe2CM2iUTxmFLraVNeTEO2pcW7eF9Nd68+P0RgJnYep8nVmedPpKdEuQrk4EKm7gPZTWczqQSEw4k3YqyDBA9QdCpuEYkQkNqSCPq4Y57g6JBggW1dnkD8kdTQB3NbhCS87CHetMR2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D8A55826EDF7C489820138AD0980797@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa223cc-1151-411b-4907-08d77d85736d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 15:27:20.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGWg07L1vjILpdt5+WRx1CObiR20kkSjNoU1TP1w0Njc72tworNDrOalodwxh4IxybvR/cfP1M0yLr0c20R0Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3135
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQWJoYXksDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxODoyMCArMDUzMCwgQWJoYXkgQWdh
cndhbCB3cm90ZToNCj4gSGkgSW5nYQ0KPiANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcGx5DQo+
IA0KPiBVbmZvcnR1bmF0ZWx5IHdlIGFyZSBzdGlsbCBub3QgYWJsZSB0byByZXNvbHZlIHRoZSBp
c3N1ZQ0KPiANCj4gV2UgaGF2ZSB1c2VkIGZvbGxvd2luZyBtZXNoLWNmZ2NsaWVudCBjb21tYW5k
cw0KPiANCj4gDQo+IFttZXNoLWNmZ2NsaWVudF0jIGNyZWF0ZQ0KPiANCj4gW21lc2gtY2ZnY2xp
ZW50XSMgYXBwa2V5LWNyZWF0ZSAwMDAwIDAwMDENCj4gDQo+IFttZXNoLWNmZ2NsaWVudF0jIGRp
c2NvdmVyLXVucHJvdmlzaW9uZWQgb24NCj4gDQo+IFVucHJvdmlzaW9uZWQgc2NhbiBzdGFydGVk
DQo+IA0KPiBTY2FuIHJlc3VsdDoNCj4gDQo+ICAgICByc3NpID0gLTYyDQo+IA0KPiAgICAgVVVJ
RCA9IEYyNEIzRjMyOURGMjAwMDAwMDAwMDAwMDAwMDAwMDAwDQo+IA0KPiANCj4gW21lc2gtY2Zn
Y2xpZW50XSMgcHJvdmlzaW9uIEYyNEIzRjMyOURGMjAwMDAwMDAwMDAwMDAwMDAwMDAwDQo+IA0K
PiBQcm92aXNpb25pbmcgc3RhcnRlZA0KPiANCj4gQXNzaWduIGFkZHJlc3NlcyBmb3IgNCBlbGVt
ZW50cw0KPiANCj4gUHJvdmlzaW9uaW5nIGRvbmU6DQo+IA0KPiBNZXNoIE5vZGU6DQo+IA0KPiAg
ICAgVVVJRCA9IEYyNEIzRjMyOURGMjAwMDAwMDAwMDAwMDAwMDAwMDAwDQo+IA0KPiAgICAgUHJp
bWFyeSA9IDAwYWENCj4gDQo+ICAgICBlbGVtZW50cyA9IDQNCj4gDQo+IA0KPiBbbWVzaC1jZmdj
bGllbnRdIyBtZW51IGNvbmZpZw0KPiANCj4gW21lc2gtY2ZnY2xpZW50XSMgdGFyZ2V0IDAwYWEN
Cj4gDQo+IFtjb25maWc6IFRhcmdldCA9IDAwYWFdIGFwcGtleS1hZGQgMDAwMQ0KPiANCj4gTm8g
cmVzcG9uc2UgZm9yICJBcHBLZXlBZGQiIGZyb20gMDBhYQ0KPiANCj4gDQo+IFdlIGhhdmUgYWxz
byBjb25maXJtZWQgdGhhdCB0aGUgbG9jYWwgTmV0S2V5IHdpdGggaW5kZXggMDAwMCBhbmQNCj4g
YXBwa2V5IHdpdGggaW5kZXggMDAwMSBhcmUgYm90aCBwcmVzZW50LCBhcyB1c2VkIGluIGFib3Zl
IGNvbW1hbmRzLg0KPiBBcyBjYW4gYmUgc2VlbiBpbiBjb25maWdfZGIuanNvbg0KPiAibmV0S2V5
cyI6Ww0KPiAgICAgew0KPiAgICAgICAgICAiaW5kZXgiOiIwMDAwIg0KPiAgICAgIH0NCj4gICBd
LA0KPiAiYXBwS2V5cyI6Ww0KPiAgICAgew0KPiAgICAgICAgICAiYm91bmROZXRLZXkiOiIwMDAw
IiwNCj4gICAgICAgICAgImluZGV4IjoiMDAwMSINCj4gICAgICB9DQo+ICAgXSwNCj4gDQo+IA0K
PiBQbGVhc2UgYWR2aXNlIHdoYXQgY2FuIGJlIGRvbmUgdG8gcmVzb2x2ZSB0aGlzIGlzc3VlLg0K
PiANCj4gDQo+IFRoYW5rcyBhbmQgcmVnYXJkcw0KPiBBYmhheSBBZ2Fyd2FsDQo+IE9uIFNhdHVy
ZGF5LCBEZWNlbWJlciA3LCAyMDE5LCBTdG90bGFuZCwgSW5nYSA8DQo+IGluZ2Euc3RvdGxhbmRA
aW50ZWwuY29tPiB3cm90ZToNCj4gPiBIaSBBYmhheSwNCj4gPiANCj4gPiBPbiBGcmksIDIwMTkt
MTItMDYgYXQgMTU6NTUgKzA1MzAsIEFiaGF5IEFnYXJ3YWwgd3JvdGU6DQo+ID4gPiBIaQ0KPiA+
ID4gDQo+ID4gPiBJIGFtIHRyeWluZyB0aGUgbWVzaC1jZmdjbGllbnQgdG9vbCB0byBjb250cm9s
IGEgc3lsdmFuaWEgc21hcnQrDQo+ID4gPiBidWxiIHdpdGggaXQuDQo+ID4gPiBJIGFtIGFibGUg
dG8gcHJvdmlzaW9uIHRoZSBkZXZpY2Ugb24gUEItQURWLg0KPiA+ID4gDQo+ID4gPiBVbmZvcnR1
bmF0ZWx5IEkgYW0gbm90IGFibGUgdG8gY29uZmlndXJlIHRoZSBkZXZpY2UuIEl0IHNob3dzIHRo
ZQ0KPiA+ID4gZXJyb3IgbWVzc2FnZSBhcw0KPiA+ID4gW2NvbmZpZzogVGFyZ2V0ID0gMDBhYV0j
IGFwcGtleS1hZGQgMA0KPiA+ID4gTm8gcmVzcG9uc2UgZm9yICJBcHBLZXlBZGQiIGZyb20gMDBh
YQ0KPiA+ID4gDQo+ID4gPiBOb3RlIHRoYXQgSSBoYXZlIGJlZW4gYWJsZSB0byBjb25maWd1cmUg
YW5kIGNvbnRyb2wgdGhlIGRldmljZQ0KPiA+ID4gKG9uL29mZikgdXNpbmcgbWVzaGN0bC4NCj4g
PiA+IA0KPiA+ID4gUGxlYXNlIGFkdmlzZSB3aGF0IGNhbiBiZSB0aGUgaXNzdWUgYW5kIGhvdyB0
byBkZWJ1ZyB0aGlzLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgYW5kIFJlZ2FyZHMsDQo+ID4gPiBB
YmhheSBBZ2Fyd2FsDQo+ID4gDQo+ID4gSSBzdXNwZWN0IHRoYXQgdGhlIHJlYXNvbiBpcyBmb3Ig
dGhpcyBiZWhhdmlvciBpcyB0aGUgZmFjdCB0aGF0IGENCj4gPiBsb2NhbCBBcHBLZXkgd2l0aCBp
bmRleCAiMCIgZG9lcyBub3QgZXhpc3QuDQo+ID4gDQo+ID4gUHJpb3IgdG8gc2VuZGluZyBBcHBL
ZXlzIG9yIE5ldEtleXMgdG8gYSByZW1vdGUgbm9kZSx0aGUga2V5cyBuZWVkDQo+ID4gdG8gYmUg
Z2VuZXJhdGVkIGxvY2FsbHkgYnkgZXhlY3V0aW5nDQo+ID4gY29tbWFuZHMgZnJvbSB0aGUgbWFp
biBtZXNoLWNmZ2NsaWVudCBtZW51Og0KPiA+ICJjcmVhdGUtc3VibmV0IiBmb3IgYSBOZXRLZXkN
Cj4gPiBhbmQNCj4gPiAiY3JlYXRlLWFwcGtleSIgZm9yIGFuIEFwcEtleQ0KPiA+IA0KPiA+IEJl
c3QgcmVnYXJkcywNCj4gPiBJbmdhDQo+ID4gDQo+IA0KPiANCg0KQXJlIHlvdSBhYmxlIHRvIHJ1
biB0aGUgYmx1ZXRvb290aC1tZXNoZCBkYWVtb24gaW4gZGVidWcgbW9kZSwgaS5lLiwNCnN0YXJ0
IGl0IGZyb20gdGhlIGNvbW1hbmQgIGxpbmUgd2l0aCAiLW5kIiBvcHRpb24/IEl0IHdvdWxkIGJl
IGhlbHBmdWwNCnRvIHNlZSBpZiB0aGUgYXBwa2V5IG1lc3NhZ2UgaXMgYmVpbmcgc2VudCB0byB0
aGUgcmVtb3RlIG5vZGUuDQoNCkJlc3QgcmVnYXJkZHMsDQpJbmdhDQoNCg0KDQoNCg==
