Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DDC47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083DF214E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="p/yr7qCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfJKTF7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:05:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:61704 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfJKTF7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 15:05:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 12:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,285,1566889200"; 
   d="scan'208";a="207489220"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2019 12:05:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 12:05:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Oct 2019 12:05:57 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Oct 2019 12:05:57 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 11 Oct 2019 12:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGjEng1L7jPY7K0nG/asnh68axAJMJJOgVq0R1kgXToKdA645MTUybp0AcZ8zpl+bO7LErEOs3KFJ36dW4rybpn/JHQjak1kwHJfNRcFmxdHga4huXs5dbu7jAH3o4/qvI+1eJ8A3UySV8Any0ScCztEzveM0WzMRNlsW2ZcQNa3ve1bTo6E2QipQTmN56Cne/AYO0Ow4M0vJ3zhy6bgSsc9OBs66KZuhzKSt8ZLJn4Y3KjpCIeZ16+UWQFisJn+M+3xtEqHXR0bFyMLRpNjDqiyIabtX0gtZV00pbhUBl1vDie2kgFvf2BHaOrK20iAJwsg3/b5LDrUiGzrU0XSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IhRVz0aEhegOClUZvXQzQf1qdxOx6pEt2PD/MvMpfc=;
 b=IVUdzJvDD6UrO4tTBDTDeIQ++qk/+f6h+C1Y7GQBX31bJdRNZZJJilJf3PeitCQr+K55HFOPRlQESs0+Uhj6f4/ANBVS/Ie0MI/ngmufUSD1yt/NRvlgW0L4udFcnMYPg76Xt57kSczFvPiBYWHPP7CUvotht/ojSItGoxvMkIE1YuelfrqhGHwNnwtbP4L5krkiMociUAiXiSrajMIjSf+Ag2W1GUFjl99vvQb8etYELmzZGUXM/9Z9MTt4lK9iDQKGx80W0IbwIUfTY5uuzSLG/sGDbpAMBEixuxNbX+eaRugtiD2lgF7sfbWoVhCLlyvDO+33ki0u/wkD/0j8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IhRVz0aEhegOClUZvXQzQf1qdxOx6pEt2PD/MvMpfc=;
 b=p/yr7qClWshlQrYAajIRitWUhH+IYdINUZ9VRZA1SwFGvN6Mzv5nPE5xogaWadsX5RGaTCyzkJLURUJXVaFWl2H1iZj0qoXfwyQ0va4jBoY/fhMIcwx0NUHUIIA+nlUBmim3QYicMtrDfMyo+RZmBAAFEVITiMRQ6kd//K4LIrI=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3164.namprd11.prod.outlook.com (20.176.119.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 19:05:56 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 19:05:56 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "pali.rohar@gmail.com" <pali.rohar@gmail.com>
CC:     "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Thread-Topic: Determinate EDR speed
Thread-Index: AQHVgA3afztLEGC5V0S2QInFi2N9RKdVv7OAgAAFYACAAAcEAIAAAZ2A
Date:   Fri, 11 Oct 2019 19:05:56 +0000
Message-ID: <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
         <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
         <20191011183502.ao45xlyfabpbadxo@pali>
         <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
In-Reply-To: <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b494f2-10e3-4366-99cb-08d74e7e0bbb
x-ms-traffictypediagnostic: DM6PR11MB3164:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR11MB31647F99DDF71D31645748C8E1970@DM6PR11MB3164.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(476003)(4001150100001)(486006)(478600001)(118296001)(81156014)(36756003)(81166006)(8676002)(1361003)(2616005)(11346002)(446003)(86362001)(99286004)(966005)(6916009)(8936002)(102836004)(3480700005)(26005)(186003)(7116003)(6512007)(6306002)(66066001)(76176011)(6506007)(2351001)(54906003)(256004)(64756008)(66556008)(6486002)(316002)(66446008)(229853002)(66946007)(305945005)(76116006)(91956017)(14454004)(7736002)(66476007)(6246003)(66574012)(5660300002)(2501003)(25786009)(6116002)(3846002)(14444005)(5640700003)(2906002)(4326008)(6436002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3164;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7NEyfohAegJdcgAuPP2kG4jpVCxQADE/y297Mo16+DD7oQs3IdTlNH68bXvtqo/s621j8fi3TLJgZwbLIltW0Dt+b4y46PpHn1LBcebTfncz9/xT0y0oB4p1SklgHL4zM5jb9GLckceQIOtVVterqpGzIjy0rumONZyt5ajlDZYbUoIV/l1ld119eb5DM7qEKWcahQOegieo1CXmmSKxFNnx9w34tPUt72YNamXhheobKd1YRSvadb24GrnXU/WXDtmEH+IzJnSh9NAPkb5kvpQ5J/9SQ6xIXJAb5GwByOelA52vFweaeKj0E6KQAnEkEdyNPtt7BndQfRXiB3MInI8T0T/3UsY/WtZVGWoOUosPPKyx0zoHKW0g08qI859EsL8XaqnCJW1/MffxkHM3dl1UTk4FcsWsTjq8lh9Mh7PdMAXDjobwkS2fJpOiJ3XP/sM513bEwP6mW7zcNvf4g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F5731F04E32A04289913977589D1D41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b494f2-10e3-4366-99cb-08d74e7e0bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 19:05:56.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yLAR8X46WzVl+9k6DEl549pVPZFQaybSUtaf9Gl5ao+qfW2qCvSnlKqyOflWhpcjvQmBS4pWmu6YL9e37o4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3164
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDE5LTEwLTExIGF0IDE5OjAwICswMDAwLCBHaXgsIEJyaWFuIHdyb3RlOg0KPiBI
aSBQYWxpLA0KPiANCj4gT24gRnJpLCAyMDE5LTEwLTExIGF0IDIwOjM1ICswMjAwLCBQYWxpIFJv
aMOhciB3cm90ZToNCj4gPiBDdXJyZW50bHkgYmx1ZXogQVBJLCBtZXRob2QgQWNxdWlyZSgpIGFs
cmVhZHkgaW5mb3JtIGNhbGxlZCBhcHBsaWNhdGlvbg0KPiA+IHdoYXQgaXMgc29ja2V0IE1UVSBm
b3IgaW5wdXQgYW5kIG91dHB1dC4gU28gZnJvbSB0aGlzIGluZm9ybWF0aW9uIGl0IGlzDQo+ID4g
cG9zc2libGUgdG8gZGV0ZWN0IGlmIGRldmljZSBzdXBwb3J0cyBFRFIgMyBvciBub3QuDQo+ID4g
DQo+ID4gQnV0IGl0IGlzIHRvbyBsYXRlIHRvIGhhdmUgdGhpcyBpbmZvcm1hdGlvbi4gSSBuZWVk
IHRvIHNlbmQgU0JDDQo+ID4gcGFyYW1ldGVycyB0byBibHVleiBmaXJzdCB3aGVuIGRvaW5nIEEy
RFAgbmVnb3RpYXRpb24sIHRoaXMgaXMgZWFybHkNCj4gPiBzdGVwcyBiZWZvcmUgQWNxdWlyZSgp
IGlzIGNhbGxlZC4NCj4gDQo+IFRoaXMgc2VlbXMgdG8gYmUgdGhlIGtpbmQgb2YgaW5mb3JtYXRp
b24gd2hpY2ggaXMgZml4ZWQsIGZvciB0aGUgbGlmZSBvZiB0aGUgcGFpcmluZy4NCj4gDQo+IFdo
YXQgaWYgeW91IGFzc3VtZWQgdGhlIGxvd2VyIHNwZWVkIHRoZSBmaXJzdCB0aW1lIHlvdSBjb25u
ZWN0ZWQsIGRldGVybWluZWQgdGhlDQo+IHNwZWVkIGR1cmluZyB0aGUgZmlyc3Qgc3RyZWFtaW5n
LCBhbmQgdGhlbiBlaXRoZXIgaW1tZWRpYXRlbHkgcmVuZWdvdGlhdGUgKGNhY2hpbmcgdGhlIGlk
ZW50aWZ5aW5nDQo+IGluZm9ybWF0aW9uDQo+IG9mIHRoZSBTTkspLCBvciBqdXN0IGNhY2hlIHRo
ZSBpbmZvcm1hdGlvbiBmb3IgZnV0dXJlIGNvbm5lY3Rpb25zLg0KPiANCj4gT3IgdGhlIHJldmVy
c2UsIGFuZCBhc3N1bWUgZmFzdCwgYnV0IGltbWVkaWF0ZWx5IGFkanVzdCBkb3duIGlmIHlvdSBh
cmVuJ3QgZ2V0dGluZyB3aGF0IHlvdSBob3BlZCBmb3IuDQo+IA0KPiBJbiBhbnkgY2FzZSwgdGhp
cyB3b3VsZCBiZSBhICJEZXZpY2UgU2V0dXAiIGdsaXRjaCB3aGljaCB5b3UgY291bGQgbm90ZSBh
cyBhIHJvdXRpbmUgcGFydCBvZiBwYWlyaW5nIGluIHRoZQ0KPiBkb2N1bWVudGF0aW9uLg0KDQpP
ciwgU3RyZWFtICJTaWxlbmNlIiB0aGUgZmlyc3QgdGltZSB5b3UgY29ubmVjdCwgaW4gb3JkZXIg
dG8gZGV0ZXJtaW5lIHRocm91Z2hwdXQuICBJdCB3b3VsZCBhZGQgMS0yIHNlY29uZHMgdG8NCnlv
dXIgY29ubmVjdGlvbiB0aW1lIHBlcmhhcHMsIGJ1dCB3b3VsZCBiZSBsZXNzIG5vdGljYWJsZSB0
byB0aGUgdXNlci4NCg0KPiANCj4gPiBUaGVyZWZvcmUgSSdtIGFza2luZyBmb3Igc29tZSB3YXkg
aG93IHRvIGdldCBpbmZvcm1hdGlvbiBpZiBkZXZpY2UNCj4gPiBzdXBwb3J0cyBFRFIgMiBvciBF
RFIgMy4gVGhpcyBpcyBiYXNpY2FsbHkgcmVxdWlyZW1lbnQgZm9yIHByb3Blcg0KPiA+IGltcGxl
bWVudGF0aW9uIG9mIFNCQyBpbiBoaWdoIHF1YWxpdHkgbW9kZS4gU28gaWYgdGhlcmUgYXJlIG5v
dCBzdWNoIEFQSQ0KPiA+IHlldCwgY291bGQgaXQgYmUgZXhwb3J0ZWQgZnJvbSBrZXJuZWwgdG8g
dXNlcnNwYWNlIGFuZCBibHVldG9vdGhkDQo+ID4gZGFlbW9uPw0KPiA+IA0KPiA+IFNlZSB0aGVz
ZSB0d28gYXJ0aWNsZXMgZm9yIG1vcmUgZGV0YWlscyBhYm91dCBTQkMgYW5kIGl0cyBoaWdoIHF1
YWxpdHk6DQo+ID4gDQo+ID4gaHR0cHM6Ly9oYWJyLmNvbS9lbi9wb3N0LzQ1NjE4Mi8NCj4gPiBo
dHRwOi8vc291bmRleHBlcnQub3JnL2FydGljbGVzLy0vYmxvZ3MvYXVkaW8tcXVhbGl0eS1vZi1z
YmMteHEtYmx1ZXRvb3RoLWF1ZGlvLWNvZGVjDQo+ID4gDQo+ID4gPiA+IElzIHRoZXJlIGFueSBi
bHVleiBBUEkgZm9yIGl0Pw0KPiA+ID4gPiANCg==
