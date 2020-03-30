Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F3C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 06:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5385320786
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 06:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oLWQ+l0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgC3GFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:05:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:26087 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbgC3GFB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 02:05:01 -0400
IronPort-SDR: EXjg2lwQSlrWTpH2xZO/RKj9jL1oMbNwTQac3DOebLnoI6+C0nHsxmGnxiEe7xsJc3qQ+b1W0L
 vh+Im6p5gzIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 23:05:01 -0700
IronPort-SDR: lJENh7BO+ciqZkrHZecUeug9RWdCO/ToREdu4nDhevXLvixMSAzSubZ3MTKv5Qk68X066np1pF
 c4+Jbz2yWy6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; 
   d="scan'208";a="272268258"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2020 23:05:01 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 29 Mar 2020 23:05:01 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 29 Mar 2020 23:05:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 29 Mar 2020 23:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlh8EcjYcvGNP7zIoEzP8CxVKnPcqI0XkELrEq3xhHdUrrPtXtm+c3jNq/PPpJH8NBKKuEpSqTLiRxZyd9hZSKjQqu8ydueeJjd4NiuLYqkEPMj44SQ3ZfgRAj0CtDzr8kN0TyXmrXfT6ZHXaJbnTJj+pZUPr+S4zdpR19JRqGT19AIBP+IlA7OcT2uuXCjF6NzSfZg2JAmF53LDYSiRV0LXuMcFvEfyJ5v5p74dakPliFrGVaNJZyXGe5kPNGfc2MbacOU+zJZxq/2JsAo43kUqA4GkosXujb/iHCRHEYPCWVKBzfLdPsIb6JoebvqdfkWBFUv8lq6lkboHsr51FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+rp08Y9CYW2SaLPjsd9ZdeBnN9AQObY3nCCd6jMdPY=;
 b=J+Z6vbIEHjs5oCaaLXX0Scc1Rlx8GHEzGPVjYtTJdJJZEl+yGQhUZzA1M2sFn+ye8ynmqoXg5wGg5oc5Eo9uCQZoZa7Wba2/q8xexiXylRndN5OIJis/efxEq2MbvkFunKwcWtAYWHbX4tbsbhGpZfdtGi1d7dn+sb2lf2ufs3K4vE/bjSk5U5zDyHUpXeZjbnL0XFcUnlIzcydq84G67aAzbDaSPXS15/mdiCN3dqVkmfUwJ69Q3hk/3a4OabTaMqQVx/0KlaumUngMPJUj6/+1b3IFN3dM1sbPfaHyTLuSHA0Zw/lRsEx+cTnwtl6M13mcBWYQ6f8h1/txu0Aimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+rp08Y9CYW2SaLPjsd9ZdeBnN9AQObY3nCCd6jMdPY=;
 b=oLWQ+l0DbBpVagXTtpVa/jLng1aKgbxZIKxBuxPwXFh9PhooAhzCiKCXBkDZGC/k9svFuzYe1eYKxTA9X5X06tPBXJtMUO2i3/sv/TyBNHJqDR7FdgkHa1LtlV/DtE/SaUefD89hw2R8RE9898x9ScvwBpZhqWB/ouA5F+pJMN8=
Received: from MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14)
 by MWHPR11MB1855.namprd11.prod.outlook.com (2603:10b6:300:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 06:04:59 +0000
Received: from MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1]) by MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1%5]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 06:04:59 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>
CC:     "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "nitin.j@samsung.com" <nitin.j@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>
Subject: Re: RE: Re: Mesh Key Refreshment procedure from Config client
Thread-Topic: RE: Re: Mesh Key Refreshment procedure from Config client
Thread-Index: AQHWA4Dpq//CCphC7k67mv4pvD1fg6hb5R2AgAAG3YCAAImWAIAENbWA
Date:   Mon, 30 Mar 2020 06:04:58 +0000
Message-ID: <f10ab3eeb9691d20544d0a65b08027fe2de3c26a.camel@intel.com>
References: <20200327053515epcms5p1cd532ff3b1ac4b97d375a6336e3ded50@epcms5p1>
         <81d243b6c593e1edb6b36be87898fc57e1e5f0f2.camel@intel.com>
         <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
         <20200304153920epcms5p47e26659f715177b0244f18c71e4b5fed@epcms5p4>
         <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
         <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p4>
         <20200327134742epcms5p46a971a1f5653956a287898e01a296dee@epcms5p4>
In-Reply-To: <20200327134742epcms5p46a971a1f5653956a287898e01a296dee@epcms5p4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57436c2d-f974-4fcc-59c4-08d7d4704726
x-ms-traffictypediagnostic: MWHPR11MB1855:
x-microsoft-antispam-prvs: <MWHPR11MB185546F53A8304722BB2FAD6FBCB0@MWHPR11MB1855.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(136003)(376002)(39860400002)(366004)(346002)(316002)(186003)(54906003)(2616005)(81156014)(26005)(81166006)(478600001)(71200400001)(6486002)(6916009)(36756003)(6506007)(86362001)(5660300002)(2906002)(4326008)(6512007)(8676002)(8936002)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZdgd6VqWEtfV+1EgzjGrJ+EKVct/Ubc/GfW00W7cDhtVFPRDqSF1k1M/cy0LqP/uc+TLQFX49zL5kw7R8AVqxNWplPfPjIr/nyXfFzaHMSBr79Q2OF56lydvbeuJDHnYJrMp2nC/NclagW77Ms6ejoMzujy5yp2PxVdzPV16Ad7FCaeLCip5+dF1TONtbKFNznvhS5PeJTBr+sJRCSfc6G3Vk4Kk4gROGz4O/0bQQhGnYJxdXrYv1T8yT6byxU9qFpH2l5vZ7O8RKuzEtXynbTUGf7DMk01/T9eCxJnUmESu6lln5uJgLwI2EgqaMNPCOiiQ5vKtuVniDTYzYzfZKM4k+YsjBDT5X0Xker0A97A9H7NSXv3JjjpHwxFKf9pGYYObBLS2LrUBTNlSd27Y8QO2NBYlpaZhgbLqXgh/4qPiq0TEi1q6H6k/JGBM7Ov
x-ms-exchange-antispam-messagedata: Yqhx3WqRDP1YajZiq9JHVVRz/Y+nbGbqvvt7XhMVvOyXgMitUQQ5+J2QSkr9w/f164aDXULh4A0BHzCxgNxpxUhFk1982Dx/OtHFfnwkM6ESHCwiBwZgjFNFoaYJ+3Ht/IMfX1o4j8V+5uuJJUU0kA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A50CF62D9B2D840BB6C5181E792C7BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57436c2d-f974-4fcc-59c4-08d7d4704726
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 06:04:58.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wYQyGd91dyHMQVSPX4lep4k1uzATJ9mDeZ2JziyAayGI1t/15pQX4pHa/MzHMz4aRdIQg89n7O3ojNi+as1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1855
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQW51cGFtLA0KDQpPbiBGcmksIDIwMjAtMDMtMjcgYXQgMTk6MTcgKzA1MzAsIEFudXBhbSBS
b3kgd3JvdGU6DQo+ICANCj4gSGkgSW5nYSwNCj4gDQo+ID4gLS0tLS0tLS0tIE9yaWdpbmFsIE1l
c3NhZ2UgLS0tLS0tLS0tDQo+ID4gU2VuZGVyIDogQW51cGFtIFJveSA8DQo+ID4gYW51cGFtLnJA
c2Ftc3VuZy5jb20NCj4gPiA+IFN0YWZmIEVuZ2luZWVyL0FwcGxpY2F0aW9uIFMvVyBHcm91cCAv
U1JJLURlbGhpL1NhbXN1bmcNCj4gPiBFbGVjdHJvbmljcw0KPiA+IERhdGUgOiAyMDIwLTAzLTI3
IDExOjA3IChHTVQrNTozMCkNCj4gPiBUaXRsZSA6IFJFOiBSZTogTWVzaCBLZXkgUmVmcmVzaG1l
bnQgcHJvY2VkdXJlIGZyb20gQ29uZmlnIGNsaWVudA0KPiA+IA0KPiA+IEhpIEluZ2EsDQo+ID4g
DQo+ID4gPiBIaSBBbnVwYW0sDQo+ID4gPiANCj4gPiA+IE9uIFRodSwgMjAyMC0wMy0yNiBhdCAy
MDoyMiArMDUzMCwgQW51cGFtIFJveSB3cm90ZToNCj4gPiA+ID4gSGkgLA0KPiA+ID4gPiAgUHJl
c2VudGx5LCBJIGFtIHRyeWluZyB0byBjaGVjayAqS2V5IFJlZnJlc2htZW50IFByb2NlZHVyZSoN
Cj4gPiA+ID4gZnJvbSBNZXNoIENvbmZpZyBjbGllbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3Ig
Y2hlY2tpbmcgdGhlIG9wZXJhdGlvbiwgSSBkaWQgZm9sbG93aW5nIHN0ZXBzDQo+ID4gPiA+ICAt
IENyZWF0ZSBTdWJuZXQgaW4gQ29uZmlnIGNsaWVudCBhdCBOZXQgaW5kZXggMQ0KPiA+ID4gPiAg
LSBBZGQgU3ViTmV0S2V5IHRvIExvY2FsIE5vZGUgYXQgTmV0IEluZGV4IDENCj4gPiA+ID4gIC0g
QWRkIFN1Yk5ldEtleSB0byBSZW1vdGUgTm9kZSBhdCBOZXQgSW5kZXggMQ0KPiA+ID4gPiANCj4g
PiA+IA0KPiA+ID4gUGxlYXNlIHRyeSB0byBhZGQgdHdvIHN0ZXBzIG1vcmUgaGVyZToNCj4gPiA+
ICAgLSBVcGRhdGUgU3VibmV0IDEgKHN1Ym5ldC11cGRhdGUgY29tbWFuZCBpbiBtYWluIG1lbnUp
DQo+ID4gDQo+ID4gSSBtaXNzZWQgbWVudGlvbmluZyBhYm92ZSBzdGVwIGluIG15IGVtYWlsLiBB
Y3R1YWxseSwgYmVmb3JlDQo+ID4gdXBkYXRpbmcgbmV0a2V5IHRvIHJlbW90ZSwgSSBkaWQgdXBk
YXRlIGxvY2FsIHN1Ym5ldC4NCj4gPiBCdXQgeWVzLCBJIG1pc3NlZCBvdXQgYmVsb3cgc3RlcCAo
VXBkYXRpbmcgbmV0a2V5IHRvIGxvY2FsIG5vZGUpLg0KPiA+IFdpbGwgZ2l2ZSBpdCBhIHRyeSBu
b3cuIE11Y2ggdGhhbmtzIQ0KPiA+IA0KPiANCj4gQWZ0ZXIgdXBkYXRpbmcgdGhlIE5ldGtleSB0
byB0aGUgbG9jYWwgbm9kZShjb25maWcgY2xpZW50KSBhbmQgdGhlbg0KPiB0byB0aGUgcmVtb3Rl
IG5vZGUsIEkgbW9uaXRvcmVkIHRoZSBiZWFjb25pbmcga2V5IHVzZWQgYnkgbG9jYWwNCj4gY29u
ZmlnIGNsaWVudC4NCj4gUGxlYXNlIG5vdGUgdGhhdCBzaW5jZSwgb25seSB0d28gbmV0a2V5cyBh
cmUgYXQgcHJlc2VudGx5IGNvbmZpZ3VyZWQNCj4gaW4gYm90aCB0aGUgbm9kZXMsIHRoZXJlZm9y
ZSwgdGhlIGtleSBJRCdzIGFyZSAxIChmb3IgcHJpbWFyeSBuZXRrZXkNCj4gYXQgaW5kZXggMCks
IDIoRm9yIE5ldGtleSBhdCBpbmRleCAxKSAmIDMoRm9yIG5ldyBOZXRLZXkgYXQgaW5kZXggMSku
DQo+IA0KPiBBZnRlciBOZXRLZXkgdXBkYXRlLCBUaGUgS1IgcGhhc2UgaW4gYm90aCBzaWRlcyBh
cmUgc2V0IHRvIDEsIGJ1dCBpdA0KPiBzZWVtcywgdGhlIG5ldyBrZXkgaWQgKHdoaWNoIGlzIDMg
aW4gdGhpcyBjYXNlKSBpcyBzdGlsbCAqTk9UIHVzZWQNCj4gZm9yIGJlYWNvbmluZywgYnkgdGhl
ICdDb25maWcgQ2xpZW50IG5vZGUnDQo+IENvbmZpZyBDbGllbnQgc3RpbGwga2VlcHMgb24gYmVh
Y29uaW5nIHdpdGgga2V5IElEIDEgJiAyLiBTaGFyaW5nIGENCj4gYml0IG9mIGxvZ3MgZm9yIHlv
dXIgcmVmZXJlbmNlLg0KPiANCj4gRHVyaW5nIE5ldEtleSBVcGRhdGUtDQo+IG1lc2gvY2ZnbW9k
LXNlcnZlci5jOmNmZ19zcnZfcGt0KCkgQ09ORklHLVNSVi1vcGNvZGUgMHg4MDQ1IHNpemUgMTgN
Cj4gaWR4IDAwMA0KPiBrZXkgcmVmcmVzaCBwaGFzZSAxOiBLZXkgSUQgMw0KPiANCj4gQmVhY29u
IEtleXMgYWZ0ZXIgTmV0S2V5IHVwZGF0ZSBvbiByZW1vdGUgTm9kZSAtDQo+IG1lc2gvbmV0LWtl
eXMuYzpzbmJfdGltZW91dCgpIGJlYWNvbiAyIGZvciAxIG5vZGVzLCBwZXJpb2QgMzAsIG9icyAy
LA0KPiBleHAgMw0KPiBtZXNoL25ldC1rZXlzLmM6c25iX3RpbWVvdXQoKSBiZWFjb24gMSBmb3Ig
MSBub2RlcywgcGVyaW9kIDIwLCBvYnMgMiwNCj4gZXhwIDINCj4gDQo+IFBsZWFzZSBzaGFyZSB5
b3VyIG9waW5pb24gdG8gY2hlY2sgdGhlIGlzc3VlIGZ1cnRoZXIuIFRoYW5rIFlvdQ0KDQpJbmRl
ZWQsIHRoZXJlJ3MgYSBtaXNzaW5nIGZ1bmN0aW9uYWxpdHkgaW4gbWVzaC1jZmdjbGllbnQgdG9v
bDoga2V5DQpyZWZyZXNoIHBoYXNlIGNvbW1hbmRzLg0KVGhlIHBhdGNoIHNldCAgdGhhdCBJIHBv
c3RlZCB0b2RheSBzaG91bGQgYWRkcmVzcyB0aGUgaXNzdWU6DQpbUEFUQ0ggQmx1ZVogMS8yXSB0
b29scy9tZXNoLWNmZ2NsaWVudDogU2F2ZSBzdWJuZXQga2V5IHJlZnJlc2ggcGhhc2UNCltQQVRD
SCBCbHVlWiAyLzJdIHRvb2xzL21lc2gtY2ZnY2xpZW50OiBBZGQgY29tbWFuZHMgZm9yIEtleSBS
ZWZyZXNoDQpQaGFzZQ0KDQpUaGUgYmVhY29uaW5nIHdpbGwgc3RhcnQgIHVwZGF0ZWQgbmV0d29y
ayBrZXkgb25jZSB0aGUgS2V5IFJlZnJlc2gNCnByb2NlZHVyZSBhZHZhbmNlcyB0byBwaGFzZSAy
Og0KMS4gInN1Ym5ldC1zZXRfcGhhc2UgPG5ldF9pbmRleD4gMiIgZnJvbSB0aGUgbWFpbiBtZW51
DQoyLiAia3JfcGhhc2Vfc2V0IDxuZXRfaW5kZXg+IDIiIGZyb20gIHRoZSBjb25maWcgbWVudSAo
c2VudCB0byBlaXRoZXINCmxvY2FsIG9yIHJlbW90ZSBub2RlIG9yIGJvdGgpLg0KICAgICBUaGUg
dHJhbnNpdGlvbiB0byBwaGFzZSAyIGNhbiBoYXBwZW4gZWl0aGVyIGFzIGEgcmVzdWx0IG9mIGEN
CmRpcmVjdGx5IHNldHRpbmcgYSBwaGFzZSBvbiBhIG5vZGUgb3IgYnkNCiAgICAgZGV0ZWN0aW5n
IGEgYmVhY29uIHdpdGggS1IgYml0IHNldCAod2hpY2gsIG9mIGNvdXJzZSBhc3N1bWVzIHRoYXQN
CmF0IGxlYXN0IG9uZSBub2RlIGdvdCBpdCdzIHBoYXNlIHNldA0KICAgIGRpcmVjdGx5IGFuZCB0
aGF0IHRoYXQgbm9kZSBoYXMgYmVhY29uaW5nIGVuYWJsZWQpIC4NCg0KU2ltaWxhciBzdGVwcyB0
byBmaW5pc2ggS2V5IFJlZnJlc2ggcHJvY2VkdXJlOiBzZXQgcGhhc2UgMyBmb3Igc3VibmV0DQph
bmQgc2VuZCBwaGFzZSBjb21tYW5kIHRvIG5vZGUocykNCg0KDQo+ICANCj4gPiA+ICAgLSBVcGRh
dGUgTmV0S2V5IDEgZm9yIGEgbG9jYWwgbm9kZSAoc3dpdGNoIHRvIGNvbmZpZyBtZW51KQ0KPiA+
ID4gDQo+ID4gPiA+ICAtIFVwZGF0ZSBOZXRrZXkgdG8gcmVtb3RlIE5vZGUgaW4gTmV0IGluZGV4
IDENCj4gPiA+ID4gDQo+ID4gPiA+IEFmdGVyIHVwZGF0aW5nIHRoZSBOZXRrZXksIEkgYmVsaWV2
ZSwgY29uZmlnIGNsaWVudCBoYXMgdG8NCj4gPiA+ID4gZWl0aGVyIHNlbmQgb3V0IFNOQiB3aXRo
IEtleVJlZnJlc2htZW50KEtSKSBGbGFnPTEgJiBzZWN1cmVkDQo+ID4gPiA+IHdpdGggdXBkYXRl
ZCBOZXRLZXkgKGkuZSBieSBzdWJuZXQtPm5ldF9rZXlfdXBkIGlkKQ0KPiA+ID4gPiBvciBzZW5k
IG91dCAiQ29uZmlnIEtleSBSZWZyZXNoIFBoYXNlIFNldCIgd2l0aCB0cmFuc2l0aW9uDQo+ID4g
PiA+IHBhcmFtZXRlciwgc2V0IHRvIDIuIEkgY291bGQgbm90IGZpbmQgdGhlIGxhdGVyIHByb3Zp
c2lvbiBpbg0KPiA+ID4gPiBjZmdjbGllbnQgbWVudS4NCj4gPiA+ID4gSG93ZXZlciwgQ29uZmln
IENsaWVudCBzZWVtcyB0byBiZSBub3Qgc2VuZGluZyBvdXQgU2VjdXJlDQo+ID4gPiA+IE5ldHdv
cmsgQmVhY29uIGFzIHdlbGwuIFNvIEtSIHByb2NlZHVyZSBzZWVtcyB0byBiZSBub3QNCj4gPiA+
ID4gcHJvZ3Jlc3NpbmcgYXQgbXkgc2V0dXAgYXQgcHJlc2VudC4NCj4gPiA+ID4gDQo+ID4gPiA+
IEFueSBoaW50IG9mIHdoYXQgY291bGQgYmUgbWlzc2luZyB3aWxsIGJlIHJlYWxseSBoZWxwZnVs
ISBUaGFuaw0KPiA+ID4gPiBZb3UuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBCZXN0IFJlZ2Fy
ZHMsDQo+ID4gPiBJbmdhDQo+IA0KPiBCUiwNCj4gLUFudXBhbSBSb3kNCg==
