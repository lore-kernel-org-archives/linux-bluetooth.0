Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421CC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD9020409
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="XNEgBuY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLCStx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:49:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:4363 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfLCStx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 13:49:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 10:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="213530989"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2019 10:49:47 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 10:49:47 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 10:49:46 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 3 Dec 2019 10:49:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj4GlaNjGG3jcnY/EFjmlDrh6VqqbFnpysIhjfQad1uzbM6Jaei11pIoHT/Iq9sKsYO5hSimHjvjHu5z9mwBz3q8jSBD40onP3TeY0SPf02Ziv/H+0n0H5DErFpkSUnAD1Jy/Tf673Cu7FjeivXegQBl+x1DFIdsaHKejWhk1uJ2F8V3GZJOyWKOUTdJN3BE+AknrZAsxk9NREyUivUdz0122z2AEbveATJfWSITSYrpCNrFxlaMpFEF9sNl/Pso4lIqm2XeFyG9Ti1mZvlPMv862NaSYp6ifnD9I22B72V+j5uf4OtAsIjgOLbY3n1GgEK8xEFECoLB9GDUsO5iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy1KrlAGKJ0Q+9XXtwzGKTiQptM2mzHdxJ+1LT4+tYo=;
 b=NlO15r66Q/YFz+Tq2d1bA195FdZgtBbe7vzr9dv0kEdfoXPL0zPxHhTrvAhfCP1Ye2NJLWpYrj0m6JWqXljGKxtfEybV42YyOAtHW+iWu4mGKKEkCDRT1Ap8bN9/t1xxTjFFj184wFS4s0NG2q2kDQ8zH82tBwaCDtqnP8rhIww8+Duxk1LiJYIL2r/PIOkXdQIw2AemGuibG1JTkdAebq78DH+S3JZZOc2V49cTWYGMwQmLG/tSWirqs1kW21kHe9FW5SmjSdXnvBX8fJ0tpz5tUyltEIqhb8Rr9KLXFEOf5QpKMlAcd5FUM9rYRWkTvtbsP9pM/5NiBXCVOo0Rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy1KrlAGKJ0Q+9XXtwzGKTiQptM2mzHdxJ+1LT4+tYo=;
 b=XNEgBuY6XzTORWC0klaH5kSIEEeyE0A5Wxx6FkgNFLqMxdR0p7H4bCHTcgk5qcnDhvj7oMGfKvt8YtozoWW5GdwTblsA0MnHWwmk0qhAz2TpnE0zRYwY0jkCw2+PEvVh8fZhDHllNdd4888yIlWKln4Utc3fFKmCAhuWRxyM/7M=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB2022.namprd11.prod.outlook.com (10.173.16.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 18:49:45 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 18:49:45 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "nagaraj.dr@samsung.com" <nagaraj.dr@samsung.com>
Subject: Re: [PATCH 1/1] mesh: Fix invalid netkey index in appkey add/delete
Thread-Topic: [PATCH 1/1] mesh: Fix invalid netkey index in appkey add/delete
Thread-Index: AQHVqb+nItHlUpYjzEWdIJ2rscmudqeowVsA
Date:   Tue, 3 Dec 2019 18:49:45 +0000
Message-ID: <ade7a0ba4d965b384d7d3132c4a291e963cb6153.camel@intel.com>
References: <CGME20191203095335epcas5p2f42315a8d7d9a081afa929f96bb66356@epcas5p2.samsung.com>
         <1575366807-7878-1-git-send-email-nagaraj.dr@samsung.com>
In-Reply-To: <1575366807-7878-1-git-send-email-nagaraj.dr@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fdf1b28-8f15-420b-5544-08d7782190e4
x-ms-traffictypediagnostic: CY4PR11MB2022:
x-microsoft-antispam-prvs: <CY4PR11MB2022E9EA08D118CB2A5B4593E1420@CY4PR11MB2022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(3846002)(6116002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(305945005)(91956017)(7736002)(81156014)(99286004)(14444005)(256004)(86362001)(5660300002)(316002)(2501003)(118296001)(4744005)(110136005)(2906002)(6246003)(478600001)(36756003)(25786009)(6436002)(81166006)(6512007)(8676002)(2616005)(6506007)(229853002)(6486002)(8936002)(446003)(26005)(11346002)(186003)(102836004)(71190400001)(14454004)(71200400001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB2022;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82jgdKy4Vk/onaM8R/QB5Y5I/1pHL7oRJR0GThY3l6E/RjejlCeNmNjbInQaIybJdr/SkNaYj3/wl2nHkxZ2AFIZ2O8+2YyFF2bue9YLUOgJDgN8Vqz1JeB2f6bAs7dw1ebz2wz02AQdtEfjkTgAET6WaucqFoecyvJXfuFcyiF02dCRBo4SLWxeP9KpvDfHOGWX8sjOa0hjgiznsooxxcNiF7kDW2l2pd+13y9PLY9m0/MZmSywJeBhF4+CsWHAWZHj67psubKF0eQcRrAqm1/DBWrzEYxNn4Jy3mDt+DFQieSHA7NvIp1IHFmtA1rgd98RHCtiS9lo7luptCzoy5+hJU0LP5ekH5ko4ZJ5ivdhDs93Nqwe+rE7LusmxiU8jCxvcLVjlFVPn1aImEJbgnzDpI1MvpqFEtPC8doYiH/cnwWu+TP6EW8J59oSO4vi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DEB089A41C5724FB293758011A05BEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdf1b28-8f15-420b-5544-08d7782190e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 18:49:45.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/pWWf93uNH+OsF+YUltBJzLQyd/3oOK/nzO+VqA8Og2KgZXm3zayp3N6g3mSMdeN2UDGTK17pikN+4+Tuv7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2022
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTItMDMgYXQgMTU6MjMgKzA1MzAsIE5hZ2FyYWogRCBS
IHdyb3RlOg0KPiA4IExTYnMgb2YgbmV0a2V5IGluZGV4IHNob3VsZCBiZSBwYWNrZWQgaW50byB0
aGUgZmlyc3Qgb2N0ZXQNCj4gLS0tDQo+ICB0b29scy9tZXNoLWdhdHQvY29uZmlnLWNsaWVudC5j
IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC1nYXR0L2NvbmZpZy1jbGllbnQuYyBiL3Rv
b2xzL21lc2gtZ2F0dC9jb25maWctY2xpZW50LmMNCj4gaW5kZXggNWU2Mzc0Zi4uZWQzMWM2NyAx
MDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC1nYXR0L2NvbmZpZy1jbGllbnQuYw0KPiArKysgYi90
b29scy9tZXNoLWdhdHQvY29uZmlnLWNsaWVudC5jDQo+IEBAIC01OTEsNyArNTkxLDcgQEAgc3Rh
dGljIHZvaWQgY21kX2FwcF9rZXkoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSwgdWludDMyX3Qgb3Bj
b2RlKQ0KPiAgCQlyZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElUX0ZBSUxV
UkUpOw0KPiAgCX0NCj4gIA0KPiAtCW1zZ1tuKytdID0gbmV0X2lkeCAmIDB4ZjsNCj4gKwltc2db
bisrXSA9IG5ldF9pZHggJiAweGZmOw0KPiAgCW1zZ1tuKytdID0gKChuZXRfaWR4ID4+IDgpICYg
MHhmKSB8DQo+ICAJCSgoYXBwX2lkeCA8PCA0KSAmIDB4ZjApOw0KPiAgCW1zZ1tuKytdID0gYXBw
X2lkeCA+PiA0Ow0K
