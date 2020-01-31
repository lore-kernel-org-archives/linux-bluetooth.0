Return-Path: <SRS0=covd=3U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE7FC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 18:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855AD206F0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 18:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zrHx+mG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgAaSaM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:30:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:59368 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgAaSaM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jan 2020 13:30:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 10:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; 
   d="scan'208";a="310079951"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2020 10:30:10 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 10:30:10 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 10:30:09 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 31 Jan 2020 10:30:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YImKZrmxLCEAiZi6S7HehqbzbPflJTNWb2IA1YsE85ALsZOCSU1uFxujUPsVqugdsf5UdOGbrrXR3V6nJccabczAlGWUagY1vQzpJWCBxmyp3gsJD9oiXr0L3Jtr8yKYr5blxZbfTYr+te43aQVFmmrZuyQPPPFJBfo42WsoIShG8bSVWcFKQb5c45gHVFS8hVYdvam1itYd5X8Q2qT3ZVvRROFE+HiViF2hDPrOai16dwEoe6RP9vwYrl8/y4EBaHGMumgQbrsYqjm4AM16CpcTGVdfrdblzm7Qr405g0ZVfRaZ6D1XQzAV+2+7In7P3+JLrqzgF/EgdXf1WiGnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN4LIM6ag54n5Fo4CRfZn+NRB8GG2rdzsYmg0yfHd5Y=;
 b=WGM0UTfHEt+anhroNVBflHYHH4fzKVHP724p8q7OVR+0TDr/jbVlGdQphg4mXzQ0zjZX5sx62ZQF8weYgR/6nnwJsiRjah/KIf/veGb1E/KGfOhtRNUGEzWSFMK1qUj0S899ZQ8Cni3917k0/4ROLbhsCfr5md4XbCWQ+pM7PuDVKE+eoikvApgLM4SkUAedso1jfVj3U14zDPB0sVFbd+hHWQnRltf34r4VmjJqwJCBB2k66EA162mUn5b9Yspg53yElp3xmSQ9rObZfKhPKZgoeWsE9k3mbw4tSr3XUob6liARfsoMrSjwKXOAikFE5AM3U0PX0V4hpBnVSqmE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN4LIM6ag54n5Fo4CRfZn+NRB8GG2rdzsYmg0yfHd5Y=;
 b=zrHx+mG6IHmEkKKy2Us6iaomqkQwgRVdvOmaxPKPK4BoV7bj1L1pVQh4qfPKIdjNcL9JmWLZ6e0KHWF8d4Ytv+IjxS5AjtzXAkxhNYgjxhLQCYY77dMVT+VSqeQv65yWET3zGpZlUCmDyJRcjZUtUMDgDe0vxlB+bB1L8A/x1mM=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2562.namprd11.prod.outlook.com (52.135.246.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 18:30:08 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 18:30:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 0/4] Allow to reattach with new composition data
Thread-Topic: [PATCH BlueZ v2 0/4] Allow to reattach with new composition data
Thread-Index: AQHV13p/3aX30F61cECrODycmqB5sKgFGfeA
Date:   Fri, 31 Jan 2020 18:30:08 +0000
Message-ID: <4f6f01337afbbef4a24c897a2f072f405f124e1c.camel@intel.com>
References: <20200130143425.5844-1-jakub.witowski@silvair.com>
In-Reply-To: <20200130143425.5844-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd659254-082f-47af-455e-08d7a67b9982
x-ms-traffictypediagnostic: BN7PR11MB2562:
x-microsoft-antispam-prvs: <BN7PR11MB25620599C6973F69F6AEF773E1070@BN7PR11MB2562.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(136003)(396003)(189003)(199004)(66476007)(64756008)(66556008)(66446008)(66946007)(6486002)(2906002)(91956017)(76116006)(36756003)(2616005)(81156014)(186003)(8676002)(86362001)(8936002)(316002)(81166006)(5660300002)(6506007)(478600001)(26005)(71200400001)(110136005)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2562;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xuzig+qYFfBomwYG/xIPDjzmsJxA9wPSfgXgSXBmniUFcjUN/ShUFQYMlOAJCKTdID2AyBfhLONIMDMlglO2ITrLZMdIwbjGswBQ+LPrhnpgKGuq3kGkXKPnM5TEWHZFswVCPPf/whdhr8BqKh2u+pFnoOafP9Qh8zRQHlRY+AR1w3di0Z7GLnve5OlQ2dQ4RqNfnrFB7W6a7/YIAk3x/gFkESB2cQSqSngUswEEqGM/9j+Km3n/zeUSRlyQA9rKK22GqVMc8aHdr07QL1ELslC1a1SOYEVcg/OyvCJEy67yR31oouTBxac/izf3eM1KHe9RlC9bAZwJZMBURXp9nvJBTjfPC1IsAl9tJ/8U/XhhHFJ2unpoj5m0yhrO921jDP8aLGswm1+MDXOklJMI7xJB04ls+YEv61iVSSQF5O9U0hDZl6x1KQZVgmUVT4D
x-ms-exchange-antispam-messagedata: 2+0lHHYYEughpI/qo41JH2v9AjxTvbGn1HQ3k4lmJD8tyAevFFfKjQSyfB33oCWF197pbrEdjCBtEIdsKxsZqEHzpAcb+yaxWQUUyJWA0SB36l7M3bt8v+IoJuIwHAIUF3OJLAYJpg1jHiLjud9arg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <23DA2B5D1831A64C823B040CD9C4BDFC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd659254-082f-47af-455e-08d7a67b9982
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 18:30:08.0335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GMZ57kEUw/q4BRoS5d4a0KFDLQA7MskYHYKC9soV6mTIl1gaxRQ2OgTCk2kW/oV6JZ4j/Boh1RS3tLBu/d9nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2562
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIsDQpPbiBUaHUsIDIwMjAtMDEtMzAgYXQgMTU6MzQgKzAxMDAsIEpha3ViIFdpdG93
c2tpIHdyb3RlOg0KPiBUaGlzIHBhdGNoIGFsbG93cyB0aGUgYXBwbGljYXRpb24gdG8gbW9kaWZ5
IHRoZSBDSUQsIFBJRCBhbmQgVklEIGluIHRoZSBjb21wb3NpdGlvbiBkYXRhLg0KPiANCj4gVmVy
c2lvbiAyOiBEbyBub3QgYWxsb3cgdG8gY2hhbmdlIENSUEwgaW4gdGhlIGNvbXBvc2l0aW9uIGRh
dGEuDQo+IEFkZGl0aW9uYWx5IHZlcmlmeSB0aGUgZGV2aWNlIGtleSB3aGVuIHVwZGF0aW5nIGNv
bXAgZGF0YSBhbmQgcmVtb3ZlDQo+IHVudXNlZCBmdW5jdGlvbiBpbiB0aGUgM3JkIHBhdGNoLg0K
PiANCj4gVmVyc2lvbiAxOiBBY2NvcmRpbmcgdGhlIE1lc2ggUHJvZmlsZSAoMi4zLjQgRWxlbWVu
dHMpIHRoZSBtb2RpZmljYXRpb24gb2YgZmllbGRzDQo+IG90aGVyIHRoYW4gIkVsZW1lbnRzIiBp
cyBub3QgcHJvaGliaXRlZC4NCj4gDQo+IEFsc28gaW4gbXkgb3BpbmlvbiAoYXMgeW91IGNhbiBz
ZWUgaW4gdGhlIDFzdCBwYXRjaCksIHRoZXJlIGlzIG5vIG5lZWQgdG8gdXNlIHBvaW50ZXIgdG8N
Cj4gdGhlIG5vZGVfY29tcG9zaXRpb24gc3RydWN0LiBUaGUgc3RhdGljIGlzIG1vcmUgY2xlYXIg
YW5kIGxlc3MgcHJvYmxlbWF0aWMuDQo+IA0KPiBKYWt1YiBXaXRvd3NraSAoNCk6DQo+ICAgbWVz
aDogdXNlIHN0YXRpYyBub2RlX2NvbXAgaW5zdGVhZCBvZiB0aGUgcG9pbnRlcg0KPiAgIG1lc2g6
IGFkZCBjaWQvcGlkL3ZpZCBzZXR0ZXINCj4gICBtZXNoOiByZW1vdmUgdW51c2VkIG5vZGVfc2V0
X2RldmljZV9rZXkoKQ0KPiAgIG1lc2g6IGFsbG93IHRvIHJlYXR0YWNoIHdpdGggbmV3IGNvbXBv
c2l0aW9uIGRhdGENCg0KUGF0Y2hlcyAxIGFuZCAzIG9mIHRoaXMgcGF0Y2hzZXQgaGF2ZSBiZWVu
IGFwcGxpZWQsIGFzIHRoZXkgYXJlIG5vbi1jb250cm92ZXJzaWFsLg0KDQpJIHdvdWxkIGxpa2Ug
dG8gd2FpdCBhIGxpdHRsZSB3aGlsZSwgYXMgdGhlIFdvcmtpbmcgZ3JvdXAgd2VpZ2hzIGluLCBv
biBtb2RpZnlpbmcgY29tcG9zaXRpb24gZGF0YS4NCg0KSSBhbSBhY3R1YWxseSByZWFkeSB0b2Rh
eSB0byBhbGxvdyBhbiBBcHAgdG8gQXR0YWNoIHRvIGFuIGV4aXN0aW5nIG5vZGUsIHdpdGggbW9k
aWZpY2F0aW9ucyB0byBpdCdzIENJRC9QSUQvVklEDQooZHJvcCBkYWVtb24gdmFsaWRhdGlvbikg
d2l0aCB0aGUgdW5kZXJzdGFuZGluZyB0aGF0IHRoZSBjb21wb3NpdGlvbiBzdG9yZWQgaW4gbm9k
ZS5qc29uIGlzIG5vdCBjaGFuZ2VkLiAgQnV0DQphbnl0aGluZyB0aGF0IGNoYW5nZXMgT1RBIGJl
aGF2aW9yLCBJIHdvdWxkIGxpa2UgYmxlc3NlZCBieSB0aGUgV0cgYW5kIHRoZSBTSUcuDQoNCg0K
PiANCj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwgIDQwICsrKysrKysrKysrKy0tLS0NCj4g
IG1lc2gvbWVzaC1jb25maWcuaCAgICAgIHwgICAyICsNCj4gIG1lc2gvbm9kZS5jICAgICAgICAg
ICAgIHwgMTAwICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIG1l
c2gvbm9kZS5oICAgICAgICAgICAgIHwgICAxIC0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgOTYgaW5z
ZXJ0aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pDQo+IA0K
