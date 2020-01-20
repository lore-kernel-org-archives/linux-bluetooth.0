Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB39C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 17:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C15C217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 17:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Mt2HFfDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgATRRr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:17:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:27768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgATRRr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 12:17:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 09:17:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="220719724"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2020 09:17:46 -0800
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jan 2020 09:17:46 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jan 2020 09:17:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jan 2020 09:17:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUHudLgvqzu4J+4ch6GJhq9xqR4KvemS0HVZmRvl93nb6uqTJmXsEayd8zAl1gpDjelwSLj1Y4IGBP/KcOOJHQNSWNB5sQYxMTCRWfSqMXKZYBqju+Gd/iGj+FCiP7TkJjcFDeunqDxTVqwaZIPqve72u2dP+lF5czhJ7u+Mt/PDb7REZrT14aqq5UpVHsMNtxO2UD1MNwCWGxSYqiKPvzrUZKXJ1uHQJW3F/jPBva0yQJfUrOPmt87mfuVRToAtPlUDLIRxhGRR1EYMfkyRobcDfTTPF0q0s1j5o0MPL26WfoCEqptCCYlFkJqVAfu8dflRwThmAtW5gSOExIt6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMjK5IgY3JZtzz9atCAuGWXSZEATg95rfxZmEDvSgkM=;
 b=DVk78JyjmqXRCAbk5+2/DFHEtADw4Z2j3/e39KYxz/HlD+mxHU7qWbIG5E9JDv3av2IW3i2E4J0gAcGvx9WOoPt5eO+G5nVPdnTMQxgNJJnTcC6EeNilpYoUV6VQfOLRvUJjc7u9gCHgpP9KtvpX2RgEjOpa4qmOtWYXQKIFaIG0qVVZjsis5dOwbvgxFS9vkwK7Wy5vsti0U/evsMtcHr1mzjvwYBxGm6J04HtgRQo3J9Eh8d9FXzhMV3AYBRnha6hhRtE9ZuFi0LG4z9UxDGaG1KrEQ9IFgk3eUsBEg4uATZ8wW3H2Ue86Lzg3EgHSaYjScUSbTj8xoofaU35r/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMjK5IgY3JZtzz9atCAuGWXSZEATg95rfxZmEDvSgkM=;
 b=Mt2HFfDw6pM6ZpzIk/WNuxKf3q7e1iXDoQeA4aGV3fL+yQRB+18fHVxCrPu+E99VU5qYc0FLD+iQFDDl1effvtKhtisBHoHovZqYxl/Tf5dxm2BYE6x8aNKOb2ttCv+Cjfcavhnz9wDoSxF5w0+gC5MpOryAZ/PhjDrQ8vWjG+Y=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB0047.namprd11.prod.outlook.com (10.164.204.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Mon, 20 Jan 2020 17:17:45 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 17:17:45 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Thread-Topic: [PATCH 0/3] Allow to reattach with new composition data
Thread-Index: AQHVz6xZE3L9S8RQfkKy+Ikw7hve1Kfzy7UA
Date:   Mon, 20 Jan 2020 17:17:45 +0000
Message-ID: <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
In-Reply-To: <20200120161114.6757-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da47a09f-dfe7-4d5d-f5e0-08d79dccaa44
x-ms-traffictypediagnostic: MWHPR11MB0047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB004730D9FF4D284EC4B71E95E1320@MWHPR11MB0047.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(81156014)(6506007)(316002)(5660300002)(36756003)(478600001)(71200400001)(110136005)(86362001)(8676002)(81166006)(66446008)(64756008)(66556008)(76116006)(6512007)(66476007)(107886003)(91956017)(66946007)(4326008)(2906002)(2616005)(6486002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB0047;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5grNKj8TYUWo6yMTcTzZPP0CcwLVOJsLAGfTV9ZZ/eeK2pETuKgbzj5CpW0YRDwp4n4+XkwtPELloqOvIihUQNGkRQajBjboPZaUnggLyVePTLGp8Yt9Z++laiztVOnqmrd82FxUJ+SxY2A5omEtKGDx24znLs7DJ3I9xw5DPxFvN2mdc2kUXLOaFN8DvOHi4EvwZMWDO1jc7m7WpfnG7qSRrROvJuTTaaMPBhdtdeON4NRFKLe61C1M3fGJVbfJzluqaBFQlP5t+LOB4Z42s2LhkZdolCwTvgV5xCwizFLi7hGsJcZZ2lRpYNYL8USTkOsZpnuLVyzoAW7ZJ9ck+GbmNfX0DooP5MlPEzKEcz2vCZ+D4IOGN3bM+cWIUruAhtJ26MfGrMuoqJ091m42qtI8rprBcexyob8sVU71R00UKawyLLLrr14pQoHcD+aJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14D0EA733A36646B0355AAEB9E9A4B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da47a09f-dfe7-4d5d-f5e0-08d79dccaa44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 17:17:45.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6YyUeTJz7g/8sjmjKT3kCPwg6BtBtKvNQscq6iep6nuuuZfFGR/+ZcdywRXHg7D5QtgcxDoZAlW8qH5R/hBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0047
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIsDQoNCmEgZmV3IHRoaW5ncy4uDQoNCkZpcnN0LCB0aGUgc3ViamVjdCBsaW5lIGZv
ciB1c2VyIHNwYWNlIHBhdGNoZXMgc2hvdWxkIGFsd2F5cyBiZSBbQmx1ZVogUEFUQ0guLi5dIHRv
IGRpZmZlcmVudGlhdGUgYmx1ZXouZ2l0DQpwYXRjaGVzIGZyb20ga2VybmVsIHBhdGNoZXMuDQoN
CkFsc286ICBUaGUgdGl0bGUgb2YgdGhlIHBhdGNoIHNob3VsZCBhbHdheXMgc3RhcnQgd2l0aCB0
aGUgY29tcG9uZW50IGJlaW5nIG1vZGlmaWVkLi4uIGluIHRoaXMgY2FzZSANCiJtZXNoOiBBbGxv
dyByZWF0dGFjaC4uLiIgb3IgInRvb2xzL21lc2g6IFhYWFgiIGZvciBleGFtcGxlDQoNCk9uIE1v
biwgMjAyMC0wMS0yMCBhdCAxNzoxMSArMDEwMCwgSmFrdWIgV2l0b3dza2kgd3JvdGU6DQo+IFRo
aXMgcGF0Y2ggYWxsb3dzIHRoZSBhcHBsaWNhdGlvbiB0byBtb2RpZnkgdGhlIENJRCwgUElELCBW
SUQgYW5kIENSUEwgaW4gdGhlIGNvbXBvc2l0aW9uIGRhdGEuDQoNClRoaXMgd2lsbCByZXF1aXJl
IHNvbWUgZGlzY3Vzc2lvbi4gICBDdXJyZW50bHkgd2UgYXJlIHBsYW5uaW5nIGF0ICpsZWFzdCog
dG8gbWFrZSBDUlBMIGVudGlyZWx5IHVuZGVyIHRoZQ0KY29udHJvbCBvZiBibHVldG9vdGgtbWVz
aC5jb25mLCBiZWNhdXNlIHRoaXMgaGFzIGEgc2lnbmlmaWNhbnQgZGFlbW9uIGltcGFjdC4NCg0K
VGhlIG90aGVyIHNldHRpbmdzIEkgYW0gbm90IGFzIGNvbmNlcm5lZCBhYm91dC4uLiAgSWYgdGhl
IHNwZWMgcmVhbGx5IGRvZXMgYWxsb3cgdGhlaXIgYWx0ZXJhdGlvbiB0aG91Z2gsIEkgYW0NCndp
bGxpbmcgdG8gY29uc2lkZXIgdGhlbS4NCg0KPiBBY2NvcmRpbmcgdGhlIE1lc2ggUHJvZmlsZSAo
Mi4zLjQgRWxlbWVudHMpIHRoZSBtb2RpZmljYXRpb24gb2YgZmllbGRzIG90aGVyIHRoYW4gIkVs
ZW1lbnRzIiBpcyBub3QNCj4gcHJvaGliaXRlZC4NCj4gDQo+IEFsc28gaW4gbXkgb3BpbmlvbiAo
YXMgeW91IGNhbiBzZWUgaW4gdGhlIDFzdCBwYXRjaCksIHRoZXJlIGlzIG5vIG5lZWQgdG8gdXNl
IHBvaW50ZXIgdG8gdGhlIG5vZGVfY29tcG9zaXRpb24NCj4gc3RydWN0Lg0KPiBUaGUgc3RhdGlj
IGlzIG1vcmUgY2xlYXIgYW5kIGxlc3MgcHJvYmxlbWF0aWMuDQo+IA0KPiBKYWt1YiBXaXRvd3Nr
aSAoMyk6DQo+ICAgbWVzaDogdXNlIHN0YXRpYyBub2RlX2NvbXAgaW5zdGVhZCBvZiB0aGUgcG9p
bnRlcg0KPiAgIG1lc2g6IGFkZCBjb21wb3NpdGlvbiBkYXRhIHNldHRlcg0KPiAgIG1lc2g6IGFs
bG93IHRvIHJlYXR0YWNoIHdpdGggbmV3IGNvbXBvc2l0aW9uIGRhdGENCj4gDQo+ICBtZXNoL21l
c2gtY29uZmlnLWpzb24uYyB8IDQ2ICsrKysrKysrKysrKysrKy0tLS0tDQo+ICBtZXNoL21lc2gt
Y29uZmlnLmggICAgICB8ICAyICsNCj4gIG1lc2gvbm9kZS5jICAgICAgICAgICAgIHwgOTYgKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgOTYgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pDQo+IA0K
