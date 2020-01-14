Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB6C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5B724680
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VRfWDG+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgANOml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:42:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:31649 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgANOmk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:42:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:42:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="248064168"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2020 06:42:37 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:42:37 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 06:42:37 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 06:42:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:42:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq9dGu2t1+/9jm9sQxNsua6b40e8Cybl24A767BGp3mItAqoZy7hs+6U2/CsrxGq8ASpho8DGSK3qJ1iv+2DTQIbmYqu2kKL4cecNwmn/cKRNjwHMBagjX9Kuykc+PEZGk39FKlxGpkwq5pwTji/yCKEJzgDmffcYRGAfDJggzg4cBXySrZrysWZ2mP3D9wm2rHeDcf7rhEXFgT38UOp2zyNDwf5ylkJxZXN3kC9Xe6DlXnHGXe6L3HW0Y4jthbF1JMmgQqHEWQ53MbpEKvSQuMF98CCiCqT4DEEAskvLoJg3MN3HjcGacj76aJsBWgUG9RtFxxL1uAhl+e5Ad4wKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6afhACUzfwu4chxz50Job6KhiC1i5Ug8TTY0SIDl4I=;
 b=B5w75IadvtSX8RY9Mj0XqpF7P7B9Yu5DXp3iIKPJAZx8hs8xi9kx1yMAelW15IMdSj9g+hzQyGpmONwC1apfGTKNTlCxoh8YVADDf+1BiOSnHvhnSiIkpSYlSiqMXPWWIrjc2I0y90BVsLl6esVQapeq7sS3/vETQZPXg5IIQZYrXf5s+KW4DUhSxIOPI4OKn+MwLwR0ef6iuJqLeBsw1hsEDUM31rzqTh0xUs4+oLy+eRQzSCulXD8Jx7+i0j4T6yvc2t3nggrNEkm6ZmooBx8AI7uciGZ8L7xDIUbK3qJAD31ufwLrm162/AVZhgzQH0u6/TzlKWv3nPE/cWT9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6afhACUzfwu4chxz50Job6KhiC1i5Ug8TTY0SIDl4I=;
 b=VRfWDG+aIkZRw7PzpV6kocXyr56yb2HVh0cTWKTPLWEZH7TdMPJRPR2lf/3NdMiAEdf0ayFkuQ7h8BmTOQxOFO1Q/GxXe1pHOVerbshVv/z+LbhQ76kxRVWmEN3J8MIBAsS5Ivuipo2BSXzoLKA5zUo01ZeAAL5pjU9Ct94Wg2U=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:42:34 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:42:34 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh: Remove node's appkeys when deleting a
 netkey
Thread-Topic: [PATCH BlueZ] tools/mesh: Remove node's appkeys when deleting a
 netkey
Thread-Index: AQHVx1jLPthC+HP8R0Os75B+tKrj46fqQwSA
Date:   Tue, 14 Jan 2020 14:42:34 +0000
Message-ID: <ad27f200e67016406e3f658286960cfb82293ae1.camel@intel.com>
References: <20200110015320.2160-1-inga.stotland@intel.com>
In-Reply-To: <20200110015320.2160-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40c87183-6633-4462-fee0-08d798fffe19
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1805015B825EA86B7C2977D4E1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(6506007)(478600001)(6486002)(36756003)(91956017)(66476007)(6636002)(8936002)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(316002)(26005)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 350RwEbtIL0F5zItYSCeNblGZY2ZOSjbtXAC2TaoJfEFn1Ym4uOw0m7HeM3O7TPscJ9NQuwyaNRMs6idZgwGp6lJ5nj19ylMg3r6ImIbdZOCaykw7TOehWh5rzfSQkJJ4SOs31jN1FQG8YKDo0AqyeTjeNVGvkZZJnjSxRCLNmlIRE45GV79b3jR9GJ01CJLQN1cEvq5HxsQtpnuwwvlwejkIB3qwSIFs88FzDfuBkJ+/khjhlsBbaBT66WYxA7Ke/iZYeiQqOKhId7iSjS5vq1gRGPYqnT0xBHnr1akCQfgJm+y8w1bKJLG/pMnySCuG8juHJDl0fxs/dohgH4T2KrpJ/jgG+3JCZm7U86Jppwtv8SqCM5fKitBcwMwcBi7OuzlPkemGTQudW6+E4aU/nF28ZHyTnFScNrPyO8qRDIuBujVzNyeAh9X4Q3+JCELnaaXQHQgqptJtAWllaND3k8Hb8N8bTQoRnA9fVoPuMg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74663AA3BF49AD4A8A87FD0FB2ED4FD0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c87183-6633-4462-fee0-08d798fffe19
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:42:34.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5+X6aCXzYBofDjjNS7EaC1xPP9IvhOjC/TJ7egJENFq2skxVgAtF0kFAm4BEaIoBSdOsCkgBkPDIranX8KNfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDE3OjUzIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBXaGVuIGEgbmV0a2V5IGlzIGRlbGV0ZWQgZnJvbSBhIHJlbW90ZSBub2RlLCBh
bGwgdGhlIGFwcGtleXMgYm91bmQNCj4gdG8gdGhpcyBuZXRrZXkgYXJlIGV4cGVjdGVkIHRvIGJl
IGRlbGV0ZWQgYXMgd2VsbC4NCj4gVGhpcyBmaXhlcyBhcHBfa2V5IHF1ZXVlIG1hbmlwdWxhdGlv
biB0byBhdm9pZCBpc3N1ZXMgY2F1c2VkIGJ5IG1vZGlmeWluZw0KPiB0aGUgcXVldWUgd2hpbGUg
aXRlcmF0aW5nIG92ZXIgaXQ6IGluc3RlYWQgb2YgaXRlcmF0aW9uIG92ZXIgYWxsIHRoZQ0KPiBl
bnRyaWVzLCBmaW5kIGEgZmlyc3QgYm91bmQga2V5LCBkZWxldGUgaXQsIGZpbmQgbmV4dC4uLiBh
bmQgc28gb24sDQo+IHVudGlsIHRoZXJlIGFyZSBubyBib3VuZCBrZXlzIGxlZnQgaW4gdGhlIGFw
cF9rZXlzIHF1ZXVlLg0KPiAtLS0NCj4gIHRvb2xzL21lc2gvcmVtb3RlLmMgfCAyNSArKysrKysr
KysrKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL3JlbW90ZS5jIGIv
dG9vbHMvbWVzaC9yZW1vdGUuYw0KPiBpbmRleCAyNWU4ZDIzZjguLjUzM2Q1OWIyOCAxMDA2NDQN
Cj4gLS0tIGEvdG9vbHMvbWVzaC9yZW1vdGUuYw0KPiArKysgYi90b29scy9tZXNoL3JlbW90ZS5j
DQo+IEBAIC0yLDcgKzIsNyBAQA0KPiAgICoNCj4gICAqICBCbHVlWiAtIEJsdWV0b290aCBwcm90
b2NvbCBzdGFjayBmb3IgTGludXgNCj4gICAqDQo+IC0gKiAgQ29weXJpZ2h0IChDKSAyMDE5ICBJ
bnRlbCBDb3Jwb3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4gKyAqICBDb3B5cmlnaHQg
KEMpIDIwMTktMjAyMCAgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+
ICAgKg0KPiAgICoNCj4gICAqICBUaGlzIGxpYnJhcnkgaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQo+IEBAIC04MSw2ICs4MSwxNCBAQCBzdGF0aWMgYm9v
bCBtYXRjaF9ub2RlX2FkZHIoY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikNCj4gIAlyZXR1
cm4gZmFsc2U7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBib29sIG1hdGNoX2JvdW5kX2tleShjb25z
dCB2b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiArew0KPiArCXVpbnQxNl90IGFwcF9pZHggPSBM
X1BUUl9UT19VSU5UKGEpOw0KPiArCXVpbnQxNl90IG5ldF9pZHggPSBMX1BUUl9UT19VSU5UKGIp
Ow0KPiArDQo+ICsJcmV0dXJuIChuZXRfaWR4ID09IGtleXNfZ2V0X2JvdW5kX2tleShhcHBfaWR4
KSk7DQo+ICt9DQo+ICsNCj4gIGJvb2wgcmVtb3RlX2FkZF9ub2RlKGNvbnN0IHVpbnQ4X3QgdXVp
ZFsxNl0sIHVpbnQxNl90IHVuaWNhc3QsDQo+ICAJCQkJCXVpbnQ4X3QgZWxlX2NudCwgdWludDE2
X3QgbmV0X2lkeCkNCj4gIHsNCj4gQEAgLTEyMyw3ICsxMzEsNyBAQCBib29sIHJlbW90ZV9hZGRf
bmV0X2tleSh1aW50MTZfdCBhZGRyLCB1aW50MTZfdCBuZXRfaWR4KQ0KPiAgYm9vbCByZW1vdGVf
ZGVsX25ldF9rZXkodWludDE2X3QgYWRkciwgdWludDE2X3QgbmV0X2lkeCkNCj4gIHsNCj4gIAlz
dHJ1Y3QgcmVtb3RlX25vZGUgKnJtdDsNCj4gLQljb25zdCBzdHJ1Y3QgbF9xdWV1ZV9lbnRyeSAq
bDsNCj4gKwl2b2lkICpkYXRhOw0KPiAgDQo+ICAJcm10ID0gbF9xdWV1ZV9maW5kKG5vZGVzLCBt
YXRjaF9ub2RlX2FkZHIsIExfVUlOVF9UT19QVFIoYWRkcikpOw0KPiAgCWlmICghcm10KQ0KPiBA
QCAtMTMyLDEzICsxNDAsMTQgQEAgYm9vbCByZW1vdGVfZGVsX25ldF9rZXkodWludDE2X3QgYWRk
ciwgdWludDE2X3QgbmV0X2lkeCkNCj4gIAlpZiAoIWxfcXVldWVfcmVtb3ZlKHJtdC0+bmV0X2tl
eXMsIExfVUlOVF9UT19QVFIobmV0X2lkeCkpKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4g
LQlmb3IgKGwgPSBsX3F1ZXVlX2dldF9lbnRyaWVzKHJtdC0+YXBwX2tleXMpOyBsOyBsID0gbC0+
bmV4dCkgew0KPiAtCQl1aW50MTZfdCBhcHBfaWR4ID0gKHVpbnQxNl90KSBMX1BUUl9UT19VSU5U
KGwtPmRhdGEpOw0KPiArCWRhdGEgPSBsX3F1ZXVlX3JlbW92ZV9pZihybXQtPmFwcF9rZXlzLCBt
YXRjaF9ib3VuZF9rZXksDQo+ICsJCQkJCQlMX1VJTlRfVE9fUFRSKG5ldF9pZHgpKTsNCj4gKwl3
aGlsZSAoZGF0YSkgew0KPiArCQl1aW50MTZfdCBhcHBfaWR4ID0gKHVpbnQxNl90KSBMX1BUUl9U
T19VSU5UKGRhdGEpOw0KPiAgDQo+IC0JCWlmIChuZXRfaWR4ID09IGtleXNfZ2V0X2JvdW5kX2tl
eShhcHBfaWR4KSkgew0KPiAtCQkJbF9xdWV1ZV9yZW1vdmUocm10LT5hcHBfa2V5cywgTF9VSU5U
X1RPX1BUUihhcHBfaWR4KSk7DQo+IC0JCQltZXNoX2RiX25vZGVfYXBwX2tleV9kZWwocm10LT51
bmljYXN0LCBhcHBfaWR4KTsNCj4gLQkJfQ0KPiArCQltZXNoX2RiX25vZGVfYXBwX2tleV9kZWwo
cm10LT51bmljYXN0LCBhcHBfaWR4KTsNCj4gKwkJZGF0YSA9IGxfcXVldWVfcmVtb3ZlX2lmKHJt
dC0+YXBwX2tleXMsIG1hdGNoX2JvdW5kX2tleSwNCj4gKwkJCQkJCUxfVUlOVF9UT19QVFIobmV0
X2lkeCkpOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiB0cnVlOw0K
