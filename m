Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C8C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE032083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="h7Q1aCW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgAQO4z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:56:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:31034 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgAQO4z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 09:56:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 06:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="306255339"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2020 06:56:39 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 06:56:38 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 06:56:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 06:56:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiF7Q/aR/0GdiF955/e0UlI4T/DqxKL595uB+bm+a8q9gZVw0DV+4iQzm65muXOSC/7tTgIkghSv+o43UF57E7c/LgE0XfMt+DHXZrOwgwiXPBRhbD5jLc1EISxBsYOT9OgF2XWRe/BLLxOmBT6K5YfvGWFZjU8wY48YplpbIjyM56Jr6zas+tQ1SFxdzS7tLh4n33hXNNVMP6ZR9BcPLkTUu59QnmE6yB12hKajAmfazUrYQeV3XvvmpNZ6CpL/FFH5DRUZvaHVWImdK0KWEhEoxQz+QORNOzWzjlbKLP4N4TrYiNh6ywNJF6ZO5jLQbTz5RZ0zJcgjhEjOgt50cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBu/0lyCuXcJh2Zz63ksEXFqc086710U+YtGGdPGbuU=;
 b=W70nGWtAjZZDDdPw4+198usIjs5VrOGO6yAd7TVmN6YO5LcaEfpCSeoL7FaIy9RQqTOuHyff9pbezduHJf9RmKRTz353n3GH/bZ0cTIghubG3Sffau9dFajgY3GvOVInSrfKi3K4EG7WOoew8b8QGvZGG/uxZA6ERi8a8ZeSnlTACcu4sLz8vQUlUmHdIi0jWQVEYnNkyKJPDBcq4uym5gEyuwCkAR9B9365xgIstMDHyozjl2/TSAekJGy3jv54C3knaGE/le//BNJvvdeb0fVmU8nT4lWc8iJ4Kt5rViVaoa+mF2oEJqqlXibkdPrOQ353aS8J+iMwz6VG8uWBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBu/0lyCuXcJh2Zz63ksEXFqc086710U+YtGGdPGbuU=;
 b=h7Q1aCW0R8J0WYB1t2kDPtnKtuBi+37NrBWYz16p0Op8PWfGj2dEHcShs3xPJ2WSKF3/Di7lqp+06WpyvKynJNFme+WDRSR5/vOdT3BxyY2FNjX/VlPvCpi4xIZoR5ag+Ib78wcmepKPeaapBTk/6yn0XwCFMUb2WhdU/50DtAA=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1792.namprd11.prod.outlook.com (10.175.51.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Fri, 17 Jan 2020 14:56:36 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 14:56:36 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     =?utf-8?B?TWljaGHFgiBMb3dhcy1SemVjaG9uZWs=?= 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Thread-Topic: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Thread-Index: AQHVzQYdUfE8nht/UUeExx2EIxj7Fqfu24MAgAALk+iAAAXtAIAABZKr
Date:   Fri, 17 Jan 2020 14:56:36 +0000
Message-ID: <7B361DEC-FBE8-4A45-AA51-95D4E5F6E6A7@intel.com>
References: <20200117071604.20675-1-brian.gix@intel.com>
 <20200117133402.jvnrhoect6olamtk@mlowasrzechonek2133>
 <E1B6E49B-2246-4C1E-9C3C-D15CA1B6DF9C@intel.com>,<20200117143640.7erexoeo6bsevnky@mlowasrzechonek2133>
In-Reply-To: <20200117143640.7erexoeo6bsevnky@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [2607:fb90:563f:4e18:20d9:7afa:886e:e223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee32a609-74d5-4279-33b0-08d79b5d7364
x-ms-traffictypediagnostic: MWHPR11MB1792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17922426BF6E7B4426BA8234E1310@MWHPR11MB1792.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(71200400001)(2906002)(54906003)(6506007)(53546011)(33656002)(66476007)(66946007)(5660300002)(64756008)(66446008)(8676002)(81156014)(91956017)(316002)(76116006)(8936002)(66556008)(81166006)(107886003)(2616005)(6512007)(4326008)(6486002)(86362001)(478600001)(186003)(6916009)(36756003)(31214005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1792;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QROiG0phJsB0Z7iMnAuurDj1PxMROncOQ63JSm9NZbf8CMf15OP80f5wDix+Hw0gn9Dq338P1x5m+ibuw1u7er/q7PamzKS9g1+Xc6C3LqdvY+yRkt8S4EpJG0+eUAStUkTQtkPjyl53GfVh4mOvI4rosTVNKiugJXEiTtUHKVmZ8V4TndEmlHzKbzGCwTfOys8MKVwdNIC+UbMyYKXzdyhMK5YgACMLdds13X0lREVg2JXRMcZE016nZK41l/IrEqr6qKMooC78/fVURZVTGDPa5gx4m1R3j5Ih15JfFiGhWpOZphTlMa3uolsrloPXF2DK5/fUD9idrNeAowe1IBoJeBr0MM/ZgRJQlU9NSHJ14ibl3eWX5OpVH0tEmhQUsfbpL71Hea4+938ie0xvBN1pfUiq+RRQp0biN8cnB0/+bxVP7vQ0U7+mX5bvcrtKl5b9UAF0OnzAdGc0HsojiFTebLjJGVZqFla4F3BFYkXYjsrUcA9+HquS60d3HItZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee32a609-74d5-4279-33b0-08d79b5d7364
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 14:56:36.5255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBPYEFWxmKnRnXmO9o6/Hhs4mybM2YMqlh7oG4SFxSAl8geXrbmAsHANVihKtLavnGLU0Xiwmg3piFjRuu7u9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1792
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KPiBPbiBKYW4gMTcsIDIwMjAsIGF0IDY6MzcgQU0sIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIDxtaWNoYWwubG93YXMtcnplY2hvbmVrQHNpbHZhaXIuY29tPiB3cm90ZToN
Cj4gDQo+IO+7v0hpIEJyaWFuLA0KPiANCj4gT24gMDEvMTcsIEdpeCwgQnJpYW4gd3JvdGU6DQo+
Pj4gSG0uIEkgY2FuJ3Qgc2VlbSB0byB3cmFwIG15IGhlYWQgYXJvdW5kIHRoaXMgYmFja3RyYWNl
LiBEbyB5b3UgbWF5YmUNCj4+PiBoYXZlIGEgcmVwcm9kdWN0aW9uIHBhdGg/DQo+PiANCj4+IFRo
ZSBiYWNrdHJhY2UgZG9lc27igJl0IHJlYWxseSBzaG93IHdoYXQgaGFzIGdvbmUgd3JvbmcgdmVy
eSB3ZWxsLA0KPj4gYmVjYXVzZSB3aGF0IGhhcyBoYXBwZW5lZCBpcyBhIGhlYXAgY29ycnVwdGlv
bi4gVGhlIHNlZyBmYXVsdCBvY2N1cnMNCj4+IGR1cmluZyBhIG1lbW9yeSBhbGxvYyBzb21ldGlt
ZSBsYXRlci4NCj4+IA0KPj4gVGhlIHBoeXNpY3Mgb2YgdGhlIHByb2JsZW0sIGlzIGJlc3Qgc2hv
d24gYnkgbG9jYWwgY29uZmlnIGNsaWVudA0KPj4gcmVxdWVzdGluZyBzZWdtZW50ZWQgY29tcG9z
aXRpb24gZGF0YSBmcm9tIGEgbG9jYWwgY29uZmlnIHNlcnZlci4gIFRoZQ0KPj4gb25lIHJlcXVl
c3QsIGFsbCByZXNwb25zZSBzZWdtZW50cywgdGhlIHJldHVybiBzZWcgQUNLcyBhbGwgaGFwcGVu
IG9uDQo+PiB0aGUgc2FtZSBDIGNhbGxpbmcgc3RhY2sgd2hpY2ggZ2V0cyAqdmVyeSogZGVlcCwg
YW5kIHN0ZXBzIG9mZiB0aGUNCj4+IGVuZCwgc2luY2Ugbm90aGluZyBnb2VzIE9UQS4gSXQgZG9l
cyAqbm90KiBoYXBwZW4gZHVyaW5nIE9UQQ0KPj4gb3BlcmF0aW9ucyBiZWNhdXNlIGVhY2ggZGlz
Y3JldGUgcGFja2V0IHN0YXJ0cyBmcm9tIGEgZnJlc2ggQyBjYWxsaW5nDQo+PiBzdGFjayBmcm9t
IG1haW4oKS4NCj4gDQo+IFllYWgsIEkgZ290IHRoYXQgcGFydCAtIGxfaWRsZSB1bndpbmRzIHRo
ZSBzdGFjayBzbyB0aGF0IGV2ZXJ5dGhpbmcNCj4gc3RhcnRzIGZyb20gdGhlIGJlZ2lubmluZywg
aXQnYSBwcmV0dHkgc3RhbmRhcmQgdGVjaG5pcXVlIGZvciBtYWluDQo+IGxvb3BzLg0KPiANCj4g
V2hhdCBJIGNvdWxkbid0IGZpbmQgaXMgdGhlIGV4YWN0IHBsYWNlIHdoZXJlIHNlbmRfbXNnX3Br
dCByZWN1cnNlcywgYnV0DQo+IEkgdGhpbmsgSSd2ZSBmb3VuZCBpdCBub3csIGUuZy4gaW4gdGhp
cyBjYWxsIGNoYWluOg0KPiANCj4gICAgc2VuZF9tc2dfcGt0DQo+ICAgIG5ldF9yeA0KPiAgICBw
YWNrZXRfcmVjZWl2ZWQNCj4gICAgc2VnX3J4ZWQNCj4gICAgc2VuZF9uZXRfYWNrDQo+ICAgIG1l
c2hfbmV0X3RyYW5zcG9ydF9zZW5kDQo+ICAgIHNlbmRfbXNnX3BrdCA8LSBoZXJlDQo+IA0KPiBJ
biB0aGUgZW5kOiB0aGUgcGF0Y2ggaXMgZmluZSwgYnV0IG1heWJlIGNoYW5nZSB0aGUgY29tbWl0
IGxvZyBhbmQvb3IgYQ0KPiBjb21tZW50LCBzaW5jZSwgYXMgeW91IHJlbWFya2VkLCB0aGUgYmFj
a3RyYWNlIGRvZXNuJ3QgZXhwbGFpbiBtdWNoPw0KDQpUaGUgY29tbWl0IG1lc3NhZ2UgaXMgb3Vy
IHN0YW5kYXJkIGV4cGxhbmF0aW9uIHdoZW4gYSBidWcgaGFzIGNhdXNlZCBhIGNyYXNoL3NlZyBm
YXVsdCwgc28gdGhhdCBvdGhlcnMgc3VmZmVyaW5nIHRoZSBzYW1lIGZhdGUgY2FuIG1hdGNoIHRo
ZSBwcm9ibGVtIHdpdGggdGhlIGZpeC4gSXQgaXNu4oCZdCByZWFsbHkgaW50ZW5kZWQgdG8gYmUg
YWxsIGluZm8gcmVxdWlyZWQgdG8gZGVidWcgdGhlIHByb2JsZW0geW91cnNlbGYu
