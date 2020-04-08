Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768EC2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 17:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B1620769
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 17:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="eWRDHAss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDHRTO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:19:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:33973 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgDHRTO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 13:19:14 -0400
IronPort-SDR: StNjz6ZzEJ2XYP9p056XmRzLG8BZ+PLOPvbo33qAIh9Gnoakh+PC+7Q2sNh0CmqE7vWi1wFn9I
 xCr9N9II59BA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 10:15:20 -0700
IronPort-SDR: wz40/FU24zP/f/PbYHbmB2A+EWg6Ozsv9I1oyXK8c8gCTIBuWRyP+s71ValN1Ta/bbA/ov0Hgy
 rT3Pf/yWoN8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="361901477"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2020 10:15:19 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 10:15:19 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Apr 2020 10:15:18 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 8 Apr 2020 10:15:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 10:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjRbXKdxcs7g1hbjGJ5LKLwQ+EYQQnojcjd9p1yIYQxB/brkVyuZ8QjB5tsNz1MvSYrhAEE7xiWfuaOoMgyAY3+oijJt8v4vttj2CrGDTblEFY7fJq/1MrdsZnmAl138fzUu8Ccc/tkoLn/DsU2o5aXT10L5CyFjHsA88hH0MggrWWyJoddBKEhuolUD5zRbZ4NJ+uqlyHQCnvgaNtcWMRnAn63HXdT3eo2cLqExMEIEIj3RbkBQmgaSECdv8bxwpqPG13F9x1KGJqFvvxdNJqFHtn//RZXXiJpuogk4fIO859MNUsnllUSqLb5kbtdyFGrZWdR5N+U/Y90SuS8pBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKur+93KLjjSWcuPrDgiTt2jVQg/pa7v4fr/Hh+gnuI=;
 b=K5GqeIJB1fSKD1IBM+EFFvVfg3B/nV5N0efAewf/p0FLpXbiw/unM9Rzb61q0W691hg4cB6Qs0THuuIvDAX36CuOLho4Y2vDOQArVoLo9L7pasLnnEAUIGMprPfyGPXx0PLOsIzcgw3hCfT+3oA1IxbWmEcJY4dibohfxgRgJq5JrEhr8zff3ov93pcCqf14gBHF2W7YTXJEpUu/vmuF5i8ERuC3qiXuJqTs7iyKBKs8+lE08MwS7FKQc1Twa4txEmZCeN6ttrAx1eekM0wlMB8i0521sH1qlL484TlBfnQaxoCnCpGI9qmvDC7ppF1vfdEwPjEiBIrYhfTD4WIobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKur+93KLjjSWcuPrDgiTt2jVQg/pa7v4fr/Hh+gnuI=;
 b=eWRDHAssUH61upoemcsgsETPJjDrdQ53Abh0uzlmTvWM/ZVvK1BqXVQ63yBWPau7WrstMVzV5C3Zlyxg9O+Xiyb5iLS42jOjCV+ODJJ1eixuBergfHGmSMP3LedGcvOKsaNoeB/0hkOPglEqOY53SmG0YwIBkdQIQn5g/Y8KOFE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Wed, 8 Apr
 2020 17:15:08 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2900.015; Wed, 8 Apr 2020
 17:15:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Ignore beacons with IVU if IV already updated
Thread-Topic: [PATCH BlueZ] mesh: Ignore beacons with IVU if IV already
 updated
Thread-Index: AQHWDL+4sArhH/oJok+NsLn0pANYA6hveP8A
Date:   Wed, 8 Apr 2020 17:15:07 +0000
Message-ID: <904bb5075012101ab2c7d0f77a7d3a30679a33c9.camel@intel.com>
References: <20200407093251.594-1-rafal.gajda@silvair.com>
In-Reply-To: <20200407093251.594-1-rafal.gajda@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 798a251d-e845-40ab-e51e-08d7dbe0635b
x-ms-traffictypediagnostic: MW3PR11MB4635:
x-microsoft-antispam-prvs: <MW3PR11MB46355A7A012054116543690EE1C00@MW3PR11MB4635.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(5660300002)(2616005)(36756003)(71200400001)(186003)(26005)(81166007)(2906002)(66476007)(91956017)(66446008)(64756008)(66556008)(6512007)(8936002)(478600001)(110136005)(6506007)(66946007)(76116006)(15650500001)(8676002)(81156014)(86362001)(6486002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXwlZfdfF0pSNian3YUgmpErhUJAvL7rhqtxCW2JXixX5o8euCCVzSrk4vWlzYPDRg+rzuvVWdHshfq8/4YQV1FpccMA0d5TnBWE5e9XjaoZAm1xw6Jas+cSXR/FjqqGF30rZvG5/NbrAtDLIC2VnVIO4nLLG/HMbOR26lKZhF4qYXQrC6Y+slvOK+uCfCpor5Po6MEMtu7eCMXmishspht+3UqbhQw6ijTWbRjd6GBdooX+7+UUjpp/p+cOZq3n/hsf2oN9BmelV1+16q/gzEXQkQh6PmtSiXV6AWZoPlQiLPJvIyuNs5UBx1cEpPX8A1rlVwOYMzYRy0O501EFc1wtOPakGroItrPVU/syB0etJhv09Hi5aPe77m/1IaVYOsM1EW09jNH8Ewpf7VdVX8PAjbriKiwPzyDy3Wlg3SewkO7Jx7HlJ5nWSjrdPaI0
x-ms-exchange-antispam-messagedata: /mpKaRhmnPNEomTGmBBoGC7uEAi00otG3sjTRluW85M3Hu0g0Wdo1qh4VCUVSIi043hHlJP3quXvg6OgWLdEMK9H1ZJfei3Ky2MjqhrfBDUpnHnGz2MF14+ZbfFqV2vpsoJuEnwYGPwe8xauMIDYwA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA038266A63BB4B9AA0E4F57B6EB47B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a251d-e845-40ab-e51e-08d7dbe0635b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 17:15:08.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGZ+Oh1Dud1UTQd9OZePOVNs1L15s/JTOz4ZHvqnaa8beAzMrX20L1yqVcIuiNBE9sRgfW0mKl+oMfWfZtdLSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUmFmYcWCLA0KDQpPbiBUdWUsIDIwMjAtMDQtMDcgYXQgMTE6MzIgKzAyMDAsIFJhZmHFgiBH
YWpkYSB3cm90ZToNCj4gV2hlbiBkYWVtb24gcmVjZWl2ZXMgYmVhY29uIHdpdGggSVY9bisxLCBJ
VlU9RmFsc2UgaXQgd2lsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KPiBzdGFydCBzZW5kaW5nIG1lc3NhZ2VzIHdpdGggbmV3IElWIGFuZCBzZXQgc2VxdWVuY2Ug
dG8gMC4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IEhvd2V2
ZXIgaWYgZGFlbW9uIHJlY2VpdmVzIGFub3RoZXIgYmVhY29uIHdpdGggSVY9bisxLCBJVlU9VHJ1
ZSBpdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gd2lsbCBnbyBiYWNrIHRv
IHNlbmRpbmcgbWVzc2FnZXMgd2l0aCBvbGQgSVY9biAoSVZVIHdpbGwgYmUgc2V0IHRvICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiBUcnVlKS4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQo+IEJlY2F1c2Ugc2VxdWVuY2UgbnVtYmVyIGhhcyBiZWVuIHJl
c2V0IHRob3NlIG1lc3NhZ2VzIHdpbGwgYmUgZHJvcHBlZCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCj4gYnkgcmVwbGF5IHByb3RlY3Rpb24gYW5kIG5vZGUgd2lsbCBsb3NlIGNvbW11
bmljYXRpb24uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IE9uY2UgSVYg
aXMgdXBkYXRlZCBkYWVtb24gc2hvdWxkIG5vdCBnbyBiYWNrIHRvIHVzaW5nIHRoZSBvbGQgdmFs
dWUuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiBUaGlzIHBhdGNoIGFkZHMgYmVhY29uIHJlamVj
dGlvbiBpZiBJViBoYXMgYWxyZWFkeSBiZWVuIHVwZGF0ZWQuICAgDQo+IA0KPiAtLS0NCj4gIG1l
c2gvbmV0LmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IDlhNTZk
MmVlOC4uMmY1MWE1YWRlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gv
bmV0LmMNCj4gQEAgLTI3MTcsNiArMjcxNywxMiBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfaXZfaXZ1
X3N0YXRlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MzJfdCBpdl9pbmRleCwNCj4gIAkJCXJl
dHVybjsNCj4gIAkJfQ0KPiAgDQo+ICsJCS8qIElnbm9yZSBiZWFjb25zIHdpdGggSVZVIGlmIElW
IGFscmVhZHkgdXBkYXRlZCAqLw0KPiArCQlpZiAoaXZfaW5kZXggPT0gbmV0LT5pdl9pbmRleCkg
ew0KPiArCQkJbF9pbmZvKCJpdiBhbHJlYWR5IHVwZGF0ZWQiKTsNCj4gKwkJCXJldHVybjsNCj4g
KwkJfQ0KPiArDQoNCkkgc2VlIHRoZSBidWcgeW91IGFyZSBmaXhpbmcsIGFuZCBhZ3JlZSB3aXRo
IHRoZSBmaXguDQoNCkkgaGF2ZSBzcHVuIGEgdjIgb2YgdGhpcyBwYXRjaCBJIHdvdWxkIGxpa2Ug
dG8gdG8gT0s6DQoNCjEuIEkgaGF2ZSBlbGltaW5hdGVkIHRoZSBsX2luZm8gb3V0cHV0LCBiZWNh
dXNlIHdpdGggYSBsb3Qgb2Ygbm9kZXMsIHRoaXMgc2VuZHMgb3V0IGEgYnVyc3Qgb2YgIml2IGFs
cmVhZHkNCnVwZGF0ZWQiIHN0cmluZ3MgZWFjaCB0aW1lIHRoaXMgb2NjdXJzICh3aGljaCBzZWVt
cyB0byBiZSBhIGxvdCkuDQoNCjIuIEkgYWRkZWQgdGhlIGVxdWl2aWxlbnQgY2hlY2sgdG8gdGhl
IElWX1VQRF9JTklUIHN0YXRlLCBzaW5jZSB0aGlzIGNvdWxkIGp1c3QgYXMgZWFzaWx5IGhhcHBl
biBvbiByZXN0YXJ0LA0Kd2hlcmUgdGhlIGZpcnN0IGJlYWNvbiBhIGRhZW1vbiBoZWFycyBoYXMg
dGhlIG9sZCBJVlUgc3RhdGUgYXMgd2VsbC4uLg0KDQpJIHdpbGwgYXdhaXQgeW91ciBPSyBiZWZv
cmUgYXBwbHlpbmcuDQoNCj4gIAkJaWYgKCFuZXQtPml2X3VwZGF0ZSkgew0KPiAgCQkJbF9pbmZv
KCJpdl91cGRfc3RhdGUgPSBJVl9VUERfVVBEQVRJTkciKTsNCj4gIAkJCW5ldC0+aXZfdXBkX3N0
YXRlID0gSVZfVVBEX1VQREFUSU5HOw0K
