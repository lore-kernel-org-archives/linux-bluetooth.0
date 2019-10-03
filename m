Return-Path: <SRS0=QFCk=X4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E6C10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 20:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6204A2133F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 20:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TTMLLbv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfJCUGi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:06:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:40376 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbfJCUGi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Oct 2019 16:06:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 13:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="275823055"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2019 13:06:36 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 3 Oct 2019 13:06:35 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 3 Oct 2019 13:06:35 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.50) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 3 Oct 2019 13:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE+5ceWcQcOQdYgMe5HHJL7a4jvUXu2lQE2XKkvVY49NdI/fRlk/XmRUGJuRnvNF21D0meA8zdUb6I43ZLZLst5C2ESYZleqgZFMc2Wp5jZcIY/1MIG/AOcbYG6ypELgfJkrEQ/6ckeElzuAcbOYeK26fBLPH2qbRuPXpF+wBaALSucnXcZOtXLGxFrT/BJ2gQCgjN5LZ3HwxkksajICbpTe4SU55gB2h3ab4w7olNRFiblfnChyocKCkfOy1TnoZwknuNEpkFIQv9bLncvctUsOyaW8FCvi3YbW6o2ysEddfLi21rMq/HPi8nsZX3U/MERtt8tNKdgEYkfGI2GcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXP8NivY8FSLswadXscxotIsi4yxH44d5fid8Ygs9E4=;
 b=Cb6eYOV2VkTWbAAUV1GVJj/6wzq8n4dId5XrVIYyaYtKtTzvna+MgY3FjpCk0EGOLSq9/bE+6D3hQUc+y/jm5aZDPQNxMfd90KkgVrXuW+FLGKNpnU70/QHMS3YMz0dsgAJIlIDTEqbHJTxDFE8gzRBhOr137WFj9J4uOsJJeoFypo/3gPlNg/g0Cbo2mQFU3jWlDnLlFzr6Nrp83X+DzWO6kjgqiZB7aJrO0LtIhG99kba+n8LX5Q0VzQ1s58qlMyK8XI0NrJb+dTA1R1g3hAww3WQZRjten7iWvRYJLvgZkmWY34gi9C4Gf03VZNcE53XEzxXa/SRcQMmzSYkFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXP8NivY8FSLswadXscxotIsi4yxH44d5fid8Ygs9E4=;
 b=TTMLLbv3D+6tdNmfvb5SDiLQXDYEpGmfePvPYfVWrLSjDUqdoUGxtULsf1ixSXOujVpKU71jc2OddYw4RY3txNY15qMDMHCRYLrK9xg6QnqsjSww9TXSJInido16Irg1/sdSyRmpAd9r5MMOpuC9bLki32RXd505MkcY0qlyhmQ=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3418.namprd11.prod.outlook.com (20.177.219.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 20:06:34 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 20:06:34 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/4] mesh: Streamline crypto functions
Thread-Topic: [PATCH BlueZ 0/4] mesh: Streamline crypto functions
Thread-Index: AQHVVnGlhWxefkXZnk6PzKMy9g+i7adJnzeA
Date:   Thu, 3 Oct 2019 20:06:34 +0000
Message-ID: <318d1a2fdef7f14b6130a99dea3443e82bcbc453.camel@intel.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ee1886-7726-4b05-b487-08d7483d30bd
x-ms-traffictypediagnostic: DM6PR11MB3418:
x-microsoft-antispam-prvs: <DM6PR11MB3418EF7013C5BB414C1137D7E19F0@DM6PR11MB3418.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39830400003)(366004)(346002)(396003)(199004)(189003)(11346002)(5660300002)(3846002)(36756003)(6486002)(2501003)(446003)(71190400001)(6116002)(99286004)(478600001)(71200400001)(81156014)(486006)(25786009)(118296001)(6512007)(6246003)(14454004)(76176011)(6436002)(81166006)(8676002)(256004)(14444005)(66556008)(66446008)(64756008)(476003)(66066001)(305945005)(2616005)(186003)(76116006)(91956017)(8936002)(102836004)(66476007)(7736002)(110136005)(66946007)(229853002)(316002)(6506007)(2906002)(86362001)(26005)(31214005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3418;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZOcFGbmFFYmPfQdsKtjzh82OQPA3GkPYQtLcMPpNbPGGhvWXYqA7EruQGbccOj5rObfLurcDjtOEl7sguL5umvDce4TwTkiy2RaSiEt046gZvd76ro7Jv60FOqr8/XN6BAyvLkCpdhOoKGOhKI0rBh3sm9Jv1Fhwrt00frKNUZcnfbM64KhcBq+Lx9EkX4emYeFmQ5CetOe/OZuWrcSPZhkPayC/JXDm45fESGAyVQwrHnAsYLz+Gd40C8QNUjV+M7BKQ/dSukXnexuj+A2Mnx1GhJMqudAq0NkvsDsAeJyfW0J1nbmekVqe6ivvO7uLcJ9jMx6XJmb5E4eIkN2W6TEYsx0yh28WOQbnD3uxNap0pxIPXOqqPYvGO9iOvtS7xYoi5TL0HNE1zrSGi7WkBwZqgufYP+zST9XRFPkD4k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C429055AC4CE174798DE165116E1ADB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ee1886-7726-4b05-b487-08d7483d30bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 20:06:34.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWE4OZOq0rBQougVUrV0hvgF/3D161bpm+MEzmwVUps6SGKLLT/9wDLBg0kKI2PPn7iOeYegC2MRJam2uYfERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3418
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KSSBhbSBhcHBseWluZyBwYXRjaGVzIDEtMyBvZiB0aGlzIHBhdGNoIHNl
dC4gVGhlIDR0aCAocmVtb3ZhbCBvZg0KcmVkdW5kZW50IGNyeXB0byByb3V0aW5lcykgaXMgcHJv
YmxlbWF0aWMgZm9yIFVuaXQgVGVzdGluZywgd2hlcmUNCndlIHdhbnQgdG8gYmUgYWJsZSB0byBz
aG93IHRoZSBkaXNjcmV0ZSBzdGVwcyBvZiBwYWNrZXQgYXNzZW1ibHkNCmFuZCBkaXNlY3Rpb24u
DQoNCllvdSBhcmUgd2VsY29tZSB0byBzdWJtaXQgYSBmb2xsb3ctdXAgdG8gcGF0Y2ggNCBpZiB5
b3UgbGlrZSwNCnRoYXQgd2lsbCB3b3JrIHdpdGggdGhlIFVuaXQgVGVzdCBjb2RlLg0KDQpPbiBN
b24sIDIwMTktMDgtMTkgYXQgMTE6MzMgKzAyMDAsIE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIHdy
b3RlOg0KPiBUaGlzIHBhdGNoLXNldCBpcyBhIGNsZWFudXAgb2YgcmVkdW5kYW50IGFuZC9vciB1
bnVzZWQgcGFydHMgb2YNCj4gbWVzaC9jcnlwdG8sIG1ha2luZyBib3RoIHRoZSB1c2FnZSBhbmQg
dGhlIGltcGxlbWVudGF0aW9uIGEgYml0DQo+IG1vcmUgY29uc2lzdGVudC4NCj4gDQo+IE1pY2hh
xYIgTG93YXMtUnplY2hvbmVrICg0KToNCj4gICBtZXNoOiBSZW1vdmUgdW51c2VkIGRlZmluZXMN
Cj4gICBtZXNoOiBOb3JtYWxpemUgQWNjZXNzIEtleSBBSUQgYW5kIEluZGV4IG5hbWluZyBpbiBt
b2RlbHMNCj4gICBtZXNoOiBBbGlnbiBhcHBrZXlfcGFja2V0X2RlY3J5cHQgd2l0aCBkZXYgYW5k
IHZpcnQgdmFyaWFudHMuDQo+ICAgbWVzaDogUmVtb3ZlIHJlZHVuZGFudCBjb2RlIGZyb20gbWVz
aC9jcnlwdG8NCj4gDQo+ICBtZXNoL2FwcGtleS5jIHwgMTExICsrKy0tLS0tLS0tLS0NCj4gIG1l
c2gvYXBwa2V5LmggfCAgMTAgKy0NCj4gIG1lc2gvY3J5cHRvLmMgfCA0MzQgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIG1lc2gvY3J5cHRvLmgg
fCAgNDggKy0tLS0tDQo+ICBtZXNoL21vZGVsLmMgIHwgIDg0ICsrKysrKysrLS0NCj4gIDUgZmls
ZXMgY2hhbmdlZCwgMjM0IGluc2VydGlvbnMoKyksIDQ1MyBkZWxldGlvbnMoLSkNCj4gDQo=
