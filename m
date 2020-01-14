Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C87C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 22:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE14F2187F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 22:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="MHGx6zCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANWZh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:25:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:58266 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgANWZh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 17:25:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 14:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="225356535"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 14:25:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 14:25:36 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 14:25:35 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 14:25:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 14:25:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ6Luz5uDqKRyquUZ/YuGuoSL2qv+e1ybL8Yq4t2V5sr1YShaWZHK15/ylBClx7uzHWqemL8nk1DeN+1E4ZlIM9lHQYhrdmu32SXWeGuCHjjttEUrD+Kk5X0VQPrjn0VnxGPrZ2B6h42RP6Cp/0B/sARxx8rMd/lMuvuuLHppb4jEpjWEISji8mS4UwKaga7RDeVLJHj36vhx88Q25DTaPbE8rpQg6I/Ozq3QUhBUU0eMghEvJw90ZvR6+xzwKIWQLEqbrpdfbKFJz1GdazfGd19UwmhPx27jXSd3N/tw4r6VJNS0TgBUqfSM74/R775boBSsEifxDakOU8nllUZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usIUf2fOjh/5wqbQEejap2meZXlpl9l4emurt0C84Hs=;
 b=OPlQnn78asbywpDL3iVXfVih6xp36kysWPMtdHGtK75+0u+HqEXxPdXo+TdZGtVOAMwX0ZcBa18QuY9RxlTSV9Q6YGedq6A87epweuwuXEww1AsPtoofmei5Vks8grEXpOBlxlmTnAPese/BWA1RJUp47TFV/Di2hhLHOFcWAT9FFviYP8AoC0ZBOSOG+jB4tr5kMe/gF6u/0dIWwLHC/+Qs1EQh/EjxtIFLCoRs5zAxDKdkkVUFeQejv+GWvD1Wu628KGiaqTUwUUpcNz7Z+SlNRq86VyQ+Mjl+Kd5odl87KdOO0CI5Nc7SJqJgZqEoghzDzDUCqcSrxtd68dmH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usIUf2fOjh/5wqbQEejap2meZXlpl9l4emurt0C84Hs=;
 b=MHGx6zCms/F2L64QwGybH+ibHuJFQKMdgrPMztb6/BhC/Z6DQtcoLjsIiMqfH/J772HkQb8Og5WG/T1vjRWpWkWgpm4PQHbL7JKQopGityVdFF7Qjhu+2k0tRoWCng8sxPJzPEl15PYQhLMsagnH0It+MdEJh6iKPW21RP6qwBs=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB3296.namprd11.prod.outlook.com (52.135.109.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 22:25:28 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 22:25:28 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH RESEND BlueZ 1/1] mesh: Add --io option
Thread-Topic: [PATCH RESEND BlueZ 1/1] mesh: Add --io option
Thread-Index: AQHVygznq9eTqKX+ZE+azCGu4sREHKfqkGMAgAAIpwCAACXngA==
Date:   Tue, 14 Jan 2020 22:25:27 +0000
Message-ID: <d84d8e72b13cc720b6605a9d26d1d7d5c0a6c257.camel@intel.com>
References: <20200113122726.768-1-michal.lowas-rzechonek@silvair.com>
         <20200113122726.768-2-michal.lowas-rzechonek@silvair.com>
         <e2a55b9eca724eafb6c019a0e306d33cfb45a617.camel@intel.com>
         <20200114200948.xgy2idbjcmhqybdm@kynes>
In-Reply-To: <20200114200948.xgy2idbjcmhqybdm@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c14527bf-64f2-481f-fab5-08d79940a888
x-ms-traffictypediagnostic: SN6PR11MB3296:
x-microsoft-antispam-prvs: <SN6PR11MB32969FDB329BABB99A9E17A2FB340@SN6PR11MB3296.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(81156014)(81166006)(8936002)(2616005)(71200400001)(6486002)(5660300002)(8676002)(316002)(2906002)(6916009)(6512007)(66476007)(478600001)(76116006)(86362001)(6506007)(91956017)(66556008)(66946007)(186003)(26005)(36756003)(4326008)(64756008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3296;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6A31sp2uzlOjAVC8hWE2pI1w0XoUD5JvGBPYGqzkpg8gEiwwVccP0EMLjpa2IJYWMKLCNVSCrDgYGdqcuZiP8ld0ZGwn425syCtgfZAqh1VdMqmcgZ0QiGIsqwCZIZX2oxFHGaH3Y/HA4LHhS6fgB5MXsP04lXxM13dF9vVJsR3DQxtRxd1FX/IXFKyADcxbdecS5iyP/ssaM1j5BtC44EuU3V6kzTEM4km+GO8HYfNsLmUkw5yR1zhc9KqY86MuWydSUHcpgqfcgikoXYo1Pm0walpvAmVmiBL/baS+P+jhspbt37R1tmN4xkQIu5VsukHv+mf+4/IpcpZmfH87UWCoPxJWMYNHzzeNGVsPvL/cuRJ61Yi1bX8Wi4E2MCAKq56FembOKeR2UoxIt1/aB9EgVnF9PNKko4PFo3xgv8zIOYPurijAffk4LWt1dH8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BA7359D27976A4EAA4FCFEA14CFCB38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c14527bf-64f2-481f-fab5-08d79940a888
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 22:25:27.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VJ4z4NXvQrx6qwixzh7+H7nMwxvHZwJDk7ELxV2JRxG7LpDuYZulO+/3L5Ar5GRtyTBnJE8ot/Ctxrz8RM+mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3296
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBUdWUsIDIwMjAtMDEtMTQgYXQgMjE6MDkgKzAxMDAsIG1pY2hhbC5s
b3dhcy1yemVjaG9uZWtAc2lsdmFpci5jb20NCndyb3RlOg0KPiBIaSBJbmdhLA0KPiANCj4gT24g
MDEvMTQsIFN0b3RsYW5kLCBJbmdhIHdyb3RlOg0KPiA+IEkgd29uZGVyIGlmIGl0IHdvdWxkIGJl
IGJldHRlciB0byByZS11c2UgIi1pIiBvcHRpb24gYnkgY2hhbmdpbmcgaXQncw0KPiA+IG1lYW5p
bmcgZm9ybSAiaW5kZXgiIHRvICJpL28iLg0KPiA+IA0KPiA+IFNvIHRoYXQgIiAtaSBoY2k8Iz4i
IHdpbGwgbWFwIHRvIGdlbmVyaWMgaS9vIG9uIGEgc3BlY2lmaWVkIGNvbnRyb2xsZXINCj4gPiBh
bmQgbm8gIi1pIiBvcHRpb24gbWVhbnMgYW55IGNvbnRyb2xsZXIuDQo+ID4gIA0KPiA+IFllcywg
d2Ugd2lsbCBsb29zZSBzb21lIHVuaWZvcm1pdHkgYWNyb3NzIGFsbCBvZiB0aGUgYmx1ZXogaW4g
YSBzZW5zZQ0KPiA+IHRoYXQgIi1pIDwjPiIgd29uJ3Qgd29yaywgYnV0IGltbyBpdCdzIHByZWZl
cmFibGUgdG8gaGF2aW5nIHR3byBvcHRpb25zDQo+ID4gd2l0aCBpbnRlci1kZXBlbmRlY2llcy4N
Cj4gDQo+IEhtLCBtaWdodCBiZS4uLiBUaGUgcmVhc29uIEkgYWRkZWQgdGhlICItLWlvPTx0eXBl
Pjo8b3B0aW9ucz4iIHdhcyB0aGUNCj4gIjxvcHRpb25zPiIgcGFydC4NCj4gDQo+IEZvciBleGFt
cGxlLCB3ZSBoYXZlIGEgbm9uLUhDSSByYWRpbyBhZGFwdGVyIHRoYXQgdXNlcw0KPiAiLS1pbz11
YXJ0Oi9kZXYvdHR5PG4+IiBzeW50YXgsIG9yIHJlbW90ZSByYWRpbyB1c2luZw0KPiAiLS1pbz10
Y3A6PGhvc3Q+Ojxwb3J0PiIgc3ludGF4Lg0KPiANCj4gU28gbWF5YmUgSSBjb3VsZCBwYXJzZSAg
Ii1pIDxuPiIgYW5kICAiLWkgaGNpPG4+IiAod2hlcmUgPG4+IGlzIGENCj4gbnVtYmVyKSBhcyBh
IHNob3J0Y3V0IGZvciAiLWkgZ2VuZXJpYzpoY2k8bj4iPw0KPiANCj4gVGhhdCB3b3VsZCBhbGxv
dyB1cyB0byBtZXJnZSBib3RoIG9wdGlvbnMgYW5kIHJlbmFtZSAiLS1pbmRleCIgdG8NCj4gIi0t
aW8iLg0KPiANCg0KWWVzLCBJJ2QgYmUgZmluZSB3aXRoIHRoaXMga2luZCBvZiBjaGFuZ2UuIERl
cGVuZGluZyBvbiB0aGUgdHlwZSwNCndlIHdvdWxkIGtub3cgaG93IHRvIHBhcnNlIHRoZSBvcHRp
b25zLiBXaXRoIHRoZSBmYWxsYmFjayB0byBsZWdhY3kNCmNhc2VzOg0KCSogbm8gb3B0aW9uIGdp
dmVuOiBnZW5lcmljLCBhbnkgY29udHJvbGxlcg0KCSogIi1pIDxoY2kjPiIgb3IgLWkgPCM+IDog
Z2VuZXJpYyB3aXRoIHRoZSBzcGVjaWZpZWQgY29udHJvbGxlcg0KDQpUaGFuayB5b3UsDQoNCklu
Z2ENCg==
