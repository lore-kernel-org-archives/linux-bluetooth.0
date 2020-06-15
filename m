Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6093CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B48520679
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 16:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="K+pkFZcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgFOQD1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:03:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:46243 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgFOQD0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 12:03:26 -0400
IronPort-SDR: vn7xeXD7zt4VZQszdVbvpS7ajkzcT6H6q5CkL6P0kelFCTc3pcjoOM42O4AXH4VOgi1ts86Un2
 dRbFsYZRkpKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 09:03:25 -0700
IronPort-SDR: 1M/6IeTubM3KDEsgmgkzEc243xQRvflJxAXbLjwKNw3LHBYu/DT1Q3ThTKGZtVOrRfKd1eZVcx
 T0R4NtGclnjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="420418028"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2020 09:03:25 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 09:03:25 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 09:03:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 09:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXkXyrknEblVDbh8rZiiJ+H2EeDuuouB6tvCYYj4qMXz9MQjiaMyAKLxHD17VgVHUKthOsU+D+qAKZ1EFU9NyftHXlN7lLmI9jJkR6dJ2Hzynr+J8You8/hozEl2xOiRrv7bsSxAy/ph7NJ3YR4iJ4t2RDO7bf+zs+LEBcm9WlUpUknX7kN3czZEnVc0dJEFqaW8ur3voHtLHywSAr6vYNFVz47ZJYL7kMsTrZUaYPOe8vlCNfStFBYDUnOyzanMqRmquENGRdvIlJs2yExurx+W0JVxn6Y6/sxKlKRRNu5UmtAK2THVy4nEbQJxtd4CY556M/aiM2GsLZX+btC4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDpfgEo5+3hAbFxcSMrlF8dY/ilwZmB27ThJw2HFEXQ=;
 b=P99O3Bp1Js6FMCDldmH7zMFlCTBRkmBkLJmwdb/CUEBkUSSM4qiGQ2a+VC+ad3MIjKV0VwpCYQahx2RqnKsvcAWGbVpWwnUF1i5hBkhqzjzV7wtKq+0XpgMk5J2iomCpB7QkLojbZBCWcsQvdzWgT49SailHaSUsHBgbm14I9I7rE9VrDSeYH1j/pJy9ljhwbPxbDm2MkhS6xB+JkS32JtdB7ZMdYT4Pa9abSbKKTXcWOGQcpMNq1Xk0VWNVdEk5kP+N+YpqkXmCIYzopdTwofcfmX2Gj0DusuSDkJpP9NBKHdBzArcgmCCACwFUdSmM2L0cScbMOqrySIUjX5r7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDpfgEo5+3hAbFxcSMrlF8dY/ilwZmB27ThJw2HFEXQ=;
 b=K+pkFZcqr4I5CElJXkTzMrksihpqGVmbxRKtXZ5e4rudcENFYyliVAJjOrytfgLjBybQd78SwRqn/hg9G+ayrvOYcuLU3VW+jbTDjyr5mU+uwxSe0lNOc5TPNojV9ogIPsYv3gCIgDu/qeYxGH8p8L/+RM2h/KJAmikn6RBuv4Y=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 16:03:22 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 16:03:22 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave() &
 Attach()
Thread-Topic: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave()
 & Attach()
Thread-Index: AQHWP0o0Jeh0ITVbG0G5y9ap/TqDrqjZXcaAgACAoIA=
Date:   Mon, 15 Jun 2020 16:03:22 +0000
Message-ID: <72efc0bd23669143a0c1b9749a6c523f1ea49f5f.camel@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
         <20200610171121.46910-6-inga.stotland@intel.com>
         <20200615082259.bpstucduyunyqvmt@mlowasrzechonek2133>
In-Reply-To: <20200615082259.bpstucduyunyqvmt@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dede6a1-b2ca-4b67-38b3-08d81145a127
x-ms-traffictypediagnostic: MW3PR11MB4602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4602DF0A32703733FD84F65DE19C0@MW3PR11MB4602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T97itSHRgUprHaekcUno6RHkouqohj3RRMdicf8FvJZTTGEGnVDAYrJnry7BuBfFwlPEHvhiJcJyjnTl+FKRlO+Yzmmxv3AM0VcflZe2ptP/rM2E+eJM01+pnIIqMbVfXnaVul4Dx/rql0vYXyvVnbNvE//+apSljURDiGKIdLlS6TpFUyUZNuYIBgdWyQpgC6KrMdQkIbKCCXVERyYyEUkKjNcBNFKAbj5Db6AVByrKrtlFpDrNRJD5YzigQ6yzyeITqwKf8uefZXZwKk8tiAsIdIU8UnnCUetj/E8b9HmP/p405O3mWVTJaj9QQHj7EizbDFK8Or9aacC85weSBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(83380400001)(110136005)(71200400001)(36756003)(8936002)(5660300002)(186003)(2616005)(8676002)(26005)(316002)(478600001)(66476007)(66556008)(64756008)(66446008)(6486002)(6636002)(6506007)(76116006)(66946007)(86362001)(2906002)(6512007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EbPX4Zcs5k5oLg+7IrAWLLcK8vLxsot7qmuUkpBPQs+BOlxLI1amxekkKZhhwJOjMSy7nUsCOQUDTd+18+ArrP3U5cRmfqKpu58zGPK6H1YrmuSQhD7BCYRkLh1CCgJCBBeR9K9K5OH3pS5jgWIwlQ04V4ndQv9a/uVIvmp20wH40F1Tj3SI8BzVy0bvZkumZfH4/PCC/36Sxojr5bVs7fH0rILr8197QPYwNgQ2Lxtt9aAXiFkOdyzLw5PMUaQSJ9yYpFVEszAbKhMsUE5p4EfoEQQX8B5JWcba/j/BOcizAPjDLkniWsP6tq8rMdsEiiRWMAXi+cbWJU+JM/C07kUIxzBdIlYYbbEZTxGcqU72j+I8hhfa21o6WC4GkdNC3CgkBGk9VeQo7g4OoZESufn4ZvWlmIODD6MPwP8w73fmdxGF7xKAQciSRef/DnudD9ZZGON3O2I7NRs1DkomZsC19xpqxAB/5Nn3Zpm+8cna9TueGjiygjSNHXkxU8Me
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1F5F9361930B4683B138C6D20894E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dede6a1-b2ca-4b67-38b3-08d81145a127
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 16:03:22.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSsq4KywmIRLT2RbyRp4Hne7DaDhFcTgY5wup72gpLXZ6C8e6fbShrBgxPV86IB7yORHi7oyxM+vtajSbPWp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gTW9uLCAyMDIwLTA2LTE1IGF0IDEwOjIyICswMjAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gSGkgSW5nYSwNCj4gDQo+IE9uIDA2LzEwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiA+IEF0dGFjaCgpIG1ldGhvZDoNCj4gPiBJZiBBdHRhY2ggbWV0
aG9kIGlzIGNhbGxlZCBmb3IgYSBub2RlIHRoYXQgaXMgYmVpbmcgcHJvY2Vzc2VkIGFzIGEgcmVz
dWx0DQo+ID4gb2YgYSBDcmVhdGUsIEltcG9ydCBvciBKb2luIG1ldGhvZCBjYWxscyBpbiBwcm9n
cmVzcywgbm9kZSBhdHRhY2htZW50DQo+ID4gaXMgbm90IGFsbG93ZWQgYW5kIG9yZy5ibHVlei5t
ZXNoLkVycm9yLkJ1c3kgZXJyb3IgaXMgcmV0dXJuZWQuDQo+IA0KPiBJIGRvbid0IHRoaW5rIEkg
dW5kZXJzdGFuZCBob3cgdGhpcyBpcyBzdXBwb3NlZCB0byBiZSB1c2VkIGJ5IHRoZQ0KPiBhcHBs
aWNhdGlvbi4NCj4gDQo+IFNvIGZhciwgd2UndmUgaW1wbGVtZW50ZWQgdGhlIEFQSSBieSBjYWxs
aW5nIEltcG9ydCgpIGFuZCB0aGVuLCBhcyBzb29uIGFzDQo+IEpvaW5Db21wbGV0ZSgpIGNhbGwg
YXJyaXZlcywgY2FsbGluZyBBdHRhY2goKS4NCj4gDQo+ID4gQEAgLTE2NTQsNiArMTY2NSwxMiBA
QCB2b2lkIG5vZGVfYXR0YWNoKGNvbnN0IGNoYXIgKmFwcF9yb290LCBjb25zdCBjaGFyICpzZW5k
ZXIsIHVpbnQ2NF90IHRva2VuLA0KPiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPiAgDQo+ID4g
KwkvKiBDaGVjayBpZiB0aGVyZSBpcyBhIHBlbmRpbmcgcmVxdWVzdCBhc3NvY2lhdGVkIHdpdGgg
dGhpcyBub2RlICovDQo+ID4gKwlpZiAobm9kZS0+YnVzeSkgew0KPiA+ICsJCWNiKHVzZXJfZGF0
YSwgTUVTSF9FUlJPUl9CVVNZLCBOVUxMKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAJLyogQ2hlY2sgaWYgdGhlIG5vZGUgaXMgYWxyZWFkeSBpbiB1c2UgKi8NCj4gPiAg
CWlmIChub2RlLT5vd25lcikgew0KPiA+ICAJCWxfd2FybigiVGhlIG5vZGUgaXMgYWxyZWFkeSBp
biB1c2UiKTsNCj4gDQo+IFdpdGggdGhpcyBwYXRjaCwgdGhpcyBjYWxsIHNlcXVlbmNlIGZhaWxz
LCBiZWNhdXNlIG5vdyB3ZSdyZSBzdXBwb3NlZCB0bw0KPiBzZW5kIGEgKnJlcGx5KiB0byBKb2lu
Q29tcGxldGUgZmlyc3QsIGFuZCBvbmx5IHRoZW4gY2FsbCBBdHRhY2goKT8NCg0KQSBjb3VwbGUg
bW9udGhzIGFnbywgd2UgbWFkZSB0aGUgZGVjaXNpb24gKHdpdGggeW91ciBpbnB1dCwgSSBiZWxp
ZXZlKSB0aGF0IHdlIG5lZWRlZCB0byB1c2UgSm9pbkNvbXBsZXRlIG9uDQpldmVyeSBub2RlIGNy
ZWF0aW9uIChKb2luLCBJbXBvcnQsIENyZWF0ZSksIHRvIGVuc3VyZSB0aGF0IHRoZSBBcHAgaGFz
IHRoZSB0b2tlbiwgYW5kIGFsbCByZXF1aXJlZA0KaW5mb3JtYXRpb25udGhlIGRhZW1vbiByZXF1
aXJlcyB0aGUgQXBwIHRvIGhhdmUuICBJZiB0aGUgZGFlbW9uIGRvZXMgKm5vdCogZ2V0IHRoZSBz
dWNjZXNzZnVsIHJldHVybiBmcm9tDQpKb2luQ29tcGxldGUsIGl0IGRlc3Ryb3lzIHRoZSBlbnRp
cmUgbm9kZS4uLiAgU28gdGhlcmVmb3JlIHRoZSBub2RlIGlzbid0IGVudGlyZWx5IGNvbXBsZXRl
IHVudGlsIHRoZSBkYWVtb24NCnJlY2VpdmVzIHRoZSByZXR1cm4uDQoNCg0KVGhpcyBjcmVhdGVz
IGFuIGF3a3dhcmQgc3RhdGUgZm9yIHRoZSBub2RlLi4uICBQYXJ0IG9mIEF0dGFjaCgpIHJlcXVp
cmVzIHRoZSBkYWVtb24gdG8gbWFrZSBhbiBPYmplY3RNYW5hZ2VyDQpyZXF1ZXN0IG9mIHRoZSBh
cHAgdG8gZ2V0IHRoZSBsYXRlc3QgY29tcG9zaXRpb24gc2V0dGluZ3MsIGFuZCB2YWxpZGF0ZSB0
aGUgQXBwIHdoaWNoIGlzIGF0dGFjaGluZyB3aXRoIHRoYXQNCnRva2VuLiAgSXQgYWxzbyBjcmVh
dGVzIHRoZSB1bmZvcnR1bmF0ZSBzaXR1YXRpb24gcmV2ZWFsZWQgaW4gb25lIG9mIHlvdXIgdGVz
dC1zdWl0ZSBjYXNlcyB3aGVyZSBpZiBMZWF2ZSgpIHdhcw0KY2FsbGVkIGJlZm9yZSByZXR1cm5p
bmcgdGhlIEpvaW5Db21wbGV0ZSgpIGNhbGwsIHdlIFNlZy1GYXVsdGVkLg0KDQpCb3RoIExlYXZl
KCksIGFuZCB0aGUgc2l0dWF0aW9uIG9mIHRoZSAqZmlyc3QqIEF0dGFjaCgpIGZvbGxvd2luZyBK
b2luQ29tcGxldGUgYXJlICJPbmNlIGluIGEgTm9kZSdzIExpZmV0aW1lIg0Kc2l0dWF0aW9ucy4g
IFdlIGRlY2lkZWQgdGhhdCB0aGUgc2FmZXN0IGNvdXJzZSBvZiBhY3Rpb24gaGVyZSB3YXMgdG8g
cmVxdWlyZSB0aGUgSm9pbkNvbXBsZXRlIHJldHVybiBwcmlvcg0KZWl0aGVyIEF0dGFjaCBvciBM
ZWF2ZS4uLiAgQmVjYXVzZSB0aGUgbm9kZSBuZWVkcyBmaW5hbGl6aW5nLg0KDQo+IA0KPiBJJ20g
dXNpbmcgYSBoaWdoLWxldmVsIEFQSSBmb3IgRC1CdXMsIHNvIEkgZG9uJ3QgcmVhbGx5IGNvbnRy
b2wgd2hlbiB0aGUNCj4gcmVwbHkgaXMgc2VudCwgc28gYXQgdGhlIG1vbWVudCB0aGUgb25seSB3
YXkgdG8gaW1wbGVtZW50IHRoaXMgd291bGQgYmUNCj4gYnkgZGVsYXlpbmcgQXR0YWNoKCkgYnkg
YSBmaXhlZCB0aW1lb3V0IC0gYW5kIEknbSBub3QgY29tZm9ydGFibGUgd2l0aA0KPiB0aGF0Lg0K
DQoNClllYWgsIEkgY2FuIHNlZSBob3cgdGhpcyBpcyBub3cgcmVxdWlyZWQuLi4gIA0KDQpJbiB0
aGUgbWVzaC1jZmdjbGllbnQgdG9vbCAod2hpY2ggaXMgYWxzbyBidWlsdCBvbiBFTEwpIHdlIGFj
Y29tcGxpc2ggdGhpcyBieSBzY2hlZHVsaW5nIGFuIGlkbGVfb25lc2hvdCBmb3INCnRoZSBBdHRh
Y2guICANCg0KSXQgY291bGQgYWxzbyBiZSBkb25lIGJ5IGlzc3VpbmcgdGhlIGxfZGJ1c19zZW5k
IG9mIHRoZSBKb2luQ29tcGxldGUgcmVzcG9uc2Ugd2l0aGluIGpvaW5fY29tcGxldGUsIGJlZm9y
ZQ0KY2FsbGluZyB0aGUgQXR0YWNoIHNlbmQuLi4gIFRoZW4gcmV0dXJuaW5nIE5VTEwgYXMgdGhl
IHJldHVybiByZXN1bHQgb2Ygam9pbl9jb21wbGV0ZSAod2hlcmUgdGhlIHJlc3BvbnNlIHdvdWxk
DQpub3JtYWxseSBiZSBzZW50KS4NCg0KPiANCj4gcmVnYXJkcw0K
