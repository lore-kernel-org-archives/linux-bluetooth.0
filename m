Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BDC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 19:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427002146E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 19:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="T5z7idhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLQTSs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:18:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:8796 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQTSs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 14:18:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="415571740"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga005.fm.intel.com with ESMTP; 17 Dec 2019 11:18:48 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 11:18:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 11:18:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSVCwu/Anta1F11yzCbiQL96Nc/0Oqjy+qjjn/FPc75z0jKAXGU1GMMjhMVgomSGTf+/7ssdJARRVHDXHvuqBJFen1Sjp5N+FKFt7srHh2aGlxRV8il42EHXA/hzPWqo2++g3gI23msPYD6PKODQycWkhZ+W+i7ub4p8FrisPEX6Tc6Nz6BtHp3DuOXYTPIgVhmswtiTbhl4ZxY8NyI5aftvLjVm9cw+46irCkItHTQE8JHmpdZcaVIhhfvB6PEa0j0tHmmUOFGu/7bUd5d0FxARxDziZDafzEFvsOdn00TjC/R0zZEKcNXvgzc4pB3dm8GSqQfrdN0bYS20QwivVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAS1EwV16p5ocUCmbhh57mlu5jmmyoVyiNw1c8AaSBk=;
 b=LJGaJPAQD63Gl5Mbhr09kv1C6JAcXWDtUGCk/r0aFUXojn+KfJW0ad7mfClOEajhSxZBs1/SM+9wEGiWn3aSnjMW6awWCdkFceNqof6CAjJxcaulmVOCIltixw96ATCThklOu8Qew7e1bg4RvJskUojxjJOgvJ3qYg0xxkUUXwPT4DuqoFbjfiFRMzroYcJdml+V9G1GyW9mFB3FuYwaA+OfgU/YXAEscdsvmVVVNdlZeHt7pEaQVhkywD4jq8MHVaQVFKGbrvfS+yadBXjSYPTrD1mdHfMDpfRn0K60E8fCc5bwPYvubZ81LM2NM7XVm61aXOF7XUoeAtI345Et9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAS1EwV16p5ocUCmbhh57mlu5jmmyoVyiNw1c8AaSBk=;
 b=T5z7idhWf1S7uuBCGd5z3PfrJbX5aC3R46Btfs9JFr4nQr85PoiDmzj1D6xth+zn++fMpxD9RREqg7tQ2xVkXWqgTPWgzY6NEry/6qrC6XMyrOLOTkaJayprbGeQb5fm4xIZ2MCJXiopoW/srgvj4XMYBVdiLhJ6C3nduk6rCYA=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1480.namprd11.prod.outlook.com (10.172.70.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Tue, 17 Dec 2019 19:18:46 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 19:18:46 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Thread-Topic: mesh: Handling application failures on Create/Join/Import
Thread-Index: AQHVtQn6uV8/TznPHkeEUzvQD9wTFae+qsgAgAAClACAAAFCAIAAAuoAgAAB/YA=
Date:   Tue, 17 Dec 2019 19:18:46 +0000
Message-ID: <450359d19e8b296f53b5dc03b649d7ce78d9d99a.camel@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
         <20191217184728.qoapokv7acfyaz33@kynes>
         <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
         <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
         <20191217191138.ib7socqz4h4i4e5j@kynes>
In-Reply-To: <20191217191138.ib7socqz4h4i4e5j@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9227792e-a137-4a9f-b902-08d78325f06d
x-ms-traffictypediagnostic: CY4PR11MB1480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1480517BACF937DE66DA66E7E1500@CY4PR11MB1480.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(36756003)(71200400001)(6916009)(8676002)(81166006)(4326008)(54906003)(478600001)(2616005)(8936002)(4001150100001)(6486002)(66446008)(64756008)(66946007)(316002)(86362001)(66556008)(2906002)(81156014)(5660300002)(26005)(6506007)(107886003)(66476007)(91956017)(6512007)(76116006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1480;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: woMfxq2b+fszFWcD0xRu83cO345c90vrXkhf7+K0LsKOU8+W8ftNEVacX006HLZJHYHqcb1nxv4Ds1lvnUuMYglQJotKdnPbhjiYec0t5JQ01BF9J/7n71Vh+fNxszeqIcc0USUBFDikjCjXlcO9kNjZkUXAOG/oQUP3OwXlEUVCvKeouX47LnazHZ+BaaLEWghCXB3+hthGUXs4+mBkMsHHCj0ArCcJSsUoz4GSEp3jUlIe3oteHCXj/6iB6Tal4BBi3gK2i9NRK2zn29FX83ICbpzL2bR+fj2W66OyJXpRXNJaZchQjcvLGBU/zN240bWu4wB7fTf2QanXpVorEsnuyq/zF1LwA2TtoC9cOeaboC6BnIFYzPblKjrScM2Qc6DDjw8Pib8u/Mquwedz1ell4JxU0wpKm+9NUscvNZLx3MlmW7tyrzCF9YHt9rbc
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EC8263C98F6D04DA966CCAF624E58B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9227792e-a137-4a9f-b902-08d78325f06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 19:18:46.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5ctfdMN3HWXNCF3Ipled31C0SgixzoPnTv4NeWcvpd3IgKc78YXH48k4ITmO88iZVc3/QfXKzfw1QDdhvZGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1480
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDIwOjExICswMTAwLCBtaWNoYWwubG93YXMtcnplY2hvbmVr
QHNpbHZhaXIuY29tIHdyb3RlOg0KPiBPbiAxMi8xNywgR2l4LCBCcmlhbiB3cm90ZToNCj4gPiBJ
IHRoaW5rIG9uZSBwaWVjZSBvZiBmdW5jdGlvbmFsaXR5IHRoYXQgd2UgaGF2ZSAqbm90KiB5ZXQg
dGVzdGVkIGlzDQo+ID4gTm9kZSBSZXNldC4gIElmIGEgQ29uZmlnIENsaWVudCBzZW5kcyBhIE5v
ZGUgUmVzZXQgdG8gYW4gIk9ycGhhbmVkDQo+ID4gTm9kZSIsIHVzaW5nIHRoYXQgbm9kZXMgRGV2
aWNlIEtleSwgdGhlIGRhZW1vbiBzaG91bGQgYmUgY2xlYW5pbmcgdXANCj4gPiBhbGwgb2YgaXQn
cyBzdG9yYWdlLg0KPiANCj4gSSBtZWFudCAnZ2V0IHJpZCBvZiBpdCBmcm9tIHRoZSBhcHBsaWNh
dGlvbiBzaWRlJy4gQWZ0ZXIgQ3JlYXRlKCksIG5vb25lDQo+IGVsc2Uga25vd3MgaG93IHRvIHRh
bGsgdG8gdGhlIG5ld2x5IGNyZWF0ZWQgY29uZmlnIHNlcnZlci4uLg0KPiANCj4gPiA+IEkgdGhp
bmsgdGhlIEFwcGxpY2F0aW9uIGRvZXMgbmVlZCB0byB0YWtlIHJlc3BvbnNpYmlsaXR5IGZvciB0
aGUNCj4gPiA+IHRva2VuLCBvbmNlIGl0IHJlY2VpdmVzIGl0Li4uICBJZiB0aGUgY2FsbCAob3Ig
cmVzcG9uc2UpIHRoYXQNCj4gPiA+IGRlbGl2ZXJzIHRoZSB0b2tlbiB0byB0aGUgQXBwIGZhaWxz
LCB0aGUgbm9kZSBzaG91bGQgYmUgZGVsZXRlZA0KPiANCj4gSW5kZWVkLiBXb3VsZCB5b3UgYmUg
d2lsbGluZyB0byBhY2NlcHQgYSBwYXRjaCB0aGF0IGNoYW5nZXMgdG9rZW4NCj4gZGVsaXZlcnkg
dG8gdXNlIEpvaW5Db21wbGV0ZSBjYWxsIGluIGFsbCBjYXNlcywgYW5kIGNoZWNrcyB0aGF0IHRo
ZSBjYWxsDQo+IHJldHVybnMgc3VjY2Vzc2Z1bGx5Pw0KDQoNCk1heWJlLi4uICBJIG5lZWQgdG8g
ZGlzY3VzcyBpdCB3aXRoIEluZ2EuICBIb3cgZG9lcyB0aGlzIHJlbGF0ZSB0byBDcmVhdGUoKSB0
aG91Z2g/ICBUaGVyZSBpcyBubyBKb2luQ29tcGxldGUoKQ0KY2FsbCBjdXJyZW50bHkgYXhzIGEg
cmVzdWx0IG9mIENyZWF0ZSgpLi4uICBqdXN0IHRoZSByZXR1cm4gdmFsdWUgZnJvbSB0aGUgQ3Jl
YXRlKCkgbWV0aG9kLiBJcyB5b3VyIHByb2JsZW0NCnRoYXQgdGhlIGRhZW1vbiBjYW5ub3QgYmUg
c3VyZSB0aGF0IHRoZSByZXR1cm4gdmFsdWUgKHRva2VuKSBmcm9tIENyZWF0ZSgpIHdhcyByZWNl
aXZlZD8NCg==
