Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FE62076B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 16:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HkTmkkKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHLQ2g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:28:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:15293 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgHLQ2f (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 12:28:35 -0400
IronPort-SDR: EcSrklZPwF+mXeKK1v/LDdI5ZClwGykj2N9MMYouWCHpm3yIBiZ6cMa63/5ZDCuA1tXlYzh2vB
 D3eGZ2EGwsGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="153215110"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="153215110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:28:34 -0700
IronPort-SDR: ZXUeH1UUaO8ubX3JAQS9Y4UBC2gBnAn6PRCM4UlQrRzQ6CC3fEpceM59MLFARX4qGRKlP29eiw
 ChiYsSIBbj1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="332846477"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2020 09:28:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Aug 2020 09:28:33 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 12 Aug 2020 09:28:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 12 Aug 2020 09:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsEY+3nhL5uaG9X6QzYi20ueOBIl1Vgy8RqtdGhRvJPma1mud1JFV+xRc2YouAcmmROA+cbjiIT3yQkEg0iG96v/UMNIe/2RYr9p2MMhS7UfkjYcFKySmGJRQ4Rcwdcd/to1L6r8zHsddhu5PzZXyQVD9vHjKNCqWm+TL6Kajp9I8LR/g4hlRQ8OzAtNPISvu9OqYhiNUidFtF9bX/VfkV2qYm4Me22zp6cD1wJjNH7PSUT4bbUJw3sOKXv5EKFNoK560zYK5ywlbBuh+K0K5A28UaQkWeTSTKU2rMIyzXzA1X45Q6qJBqECDlIzgC2ioCfqnmsijXRNGEvzJBsjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwh0Uw746Nh3EJlVCPni6QimEDZlBkMZdEC9RVhMRqA=;
 b=nQwBVz7zo+1XkwvVXtaHPg6t0riJLwqZKwTuieevs7DlcmvJ/iyW7KGnFxGjPK9DLVU5pRG1oQgFnzt/h9RUgySTW5zbR0DgWQfJXgr10prtjCRQDa6GS2RA92LbDT0f6H8GVJzvY9H/oSa1Q/eWKECtIPLka9VpifKMfnjYpIthjRdo+/vzkXhc9miABTlHqRkfrq1v8A4HJA4iU+HV6jA/fhoebCfxP0nkSE5FS2F2XkWHhDLzopaQPmQip5SiMZ3hXMroK4cA5z/IhuCtE/CuKrbobWDF4nLuvYtgDGYh1DjvbF7ho2KoZ/4ncsH1YMFCZ/4pqe2gCzcZuhsGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwh0Uw746Nh3EJlVCPni6QimEDZlBkMZdEC9RVhMRqA=;
 b=HkTmkkKYGMBrChlNjmHy9Z6LValdEaAZZzJacw7gngyHXNvICEse7Zy4TSTH19EErC9c0wkY+myMIpexVEWUm+yIl1exunG72Odztoo6m0y5sgSjEhpucjIWOf0HjTntuDYgXTJS4pVpyiiBoI+eI/GAtacZQp0hN8Jyi+gC+/E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1853.namprd11.prod.outlook.com (2603:10b6:300:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 12 Aug
 2020 16:28:28 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 16:28:28 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix encoding of Config Key Refresh Phase
 Status
Thread-Topic: [PATCH BlueZ] mesh: Fix encoding of Config Key Refresh Phase
 Status
Thread-Index: AQHWcBayG3TGPnpP10+G1M3FsfNV7qk0qwmA
Date:   Wed, 12 Aug 2020 16:28:28 +0000
Message-ID: <26cc25a933fc4d6df173a347e479d18e9f43a0f4.camel@intel.com>
References: <20200811193709.27341-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200811193709.27341-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 625263bb-a7cf-4906-65cf-08d83edcbea9
x-ms-traffictypediagnostic: MWHPR11MB1853:
x-microsoft-antispam-prvs: <MWHPR11MB185300AF43E6589B200242B7E1420@MWHPR11MB1853.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztimS/s0vMyp/CvIMZ51a4yK64KoM+SKUpO5UkAVSNub6AGkrEccMA/72S+Y84Kt4BVXEmzUfHNr/RBb5Mc6nHMG4uYTWSlEUvbFomSC1ZXcvvpjnirNErqwqYjJATy77cV3QG17Y0ClXed/5UypcCpkrBFlfZx/eJR3r7AZSvc3y1GkSE7K5lI9tcdyU5gSEKe6Lt3tETyUiWdW6JkSMQ8d5EP4ato/KKnKQjLc8/wgTwlnR1mKZXJVYX/npIUsoYe8FEs1MDaGo6wD/qFCyDTxyMzCnoFdcFwP4Tz1kvY0a3RJnH7WaRqDuuOMFX6KURJvRNbP5PAPSsVrBxTwRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(6486002)(186003)(6506007)(71200400001)(2616005)(86362001)(4744005)(36756003)(5660300002)(110136005)(26005)(6512007)(66556008)(8936002)(8676002)(2906002)(76116006)(64756008)(66446008)(478600001)(91956017)(66476007)(66946007)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2PbE9AUWQvmZ5XUQse3cHzJxw/C2Z4Opw7w060LcLsUkRJQeJ71BjPcmp4dUqfH3zOnkXFaOcf3Yeb1tpWcx02dkIkeotYDYB1/+ZLyiKaris9NFBlMgioGqe9lFhDDVJKlyWdh2f9RuHVE6CDamBL1RtMJUdsmTCGNWsAeWlEjsSnILxukPCkJ04rbgcWzaEIardQYNR15yg6CSAotvgRpPHVWSCJsfiiVyVM8ef4yUWNr+fjN+5//SJVYzUIHYgEg/JrgsZg+6w8InV9TqnqsplipBv4lN5bKL4MBrkc7g2zGTH7sT3CMgnqWkVv9bCM7vvXp5NE7PZkKt7gYHzGJ28abUAlSw1j7/Bw3Kw686TSH4islC7C/iI1y6J1Xj0n18Pkro4OrlH3Hwt8EIsZFmvARfnP9fz6yVkitFBVOJcqVv8i1SRYUZsQW0FwitGE0V9ZqZtrxLv5rmWJl8jeIJzODHsGSYc9KNftaRwzqmjaY+AHYCBqQPn7Olx6Mw8X6B/kktrxKhAtnmJ2xwYuR+t0XfigpAK2cHdBdAMG+c7/wRsEuew9gMZlyoAz2tBxmuooNKHp7xVona4SvfKcy7+iPHc5EcTiJtkvlj7T8PaUIN9yxZMmyS7EHSEyWG4IQVgARzADolKHiuWn/Siw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E789FD9728CBC4594A4CBD69C62F4A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625263bb-a7cf-4906-65cf-08d83edcbea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 16:28:28.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rf2hq4u5Ec9Evt4Gxd2kPCfDV4Uf8KXVgu4JEvpfpHOol9RXctlrB6Cir46k7NowXHxhHGOlXY8jJU2DtE0VOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1853
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMjAtMDgtMTEgYXQgMjE6MzcgKzAyMDAsIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBDb25maWcgS2V5IFJlZnJlc2ggUGhhc2UgU3RhdHVzIGlz
IDQgb2N0ZXRzIGxvbmcgKHNlZSBNZXNoIFByb2ZpbGUNCj4gdjEuMC4xLCBzZWN0aW9uIDQuMy4y
LjYwKTogMSBvY3RldCBmb3Igc3RhdHVzLCAyIG9jdGV0cyBmb3IgbmV0IGtleQ0KPiBpbmRleCwg
MSBvY3RldCBmb3IgdGhlIHBoYXNlLg0KPiAtLS0NCj4gIG1lc2gvY2ZnbW9kLXNlcnZlci5jIHwg
NiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21v
ZC1zZXJ2ZXIuYw0KPiBpbmRleCA5ZGE5ODE3MDAuLjkwZWJkZjA0NiAxMDA2NDQNCj4gLS0tIGEv
bWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gQEAg
LTQ0NywxMSArNDQ3LDExIEBAIHN0YXRpYyB1aW50MTZfdCBjZmdfa2V5X3JlZnJlc2hfcGhhc2Uo
c3RydWN0IG1lc2hfbm9kZSAqbm9kZSwNCj4gIA0KPiAgZG9uZToNCj4gIAltc2dbbl0gPSBzdGF0
dXM7DQo+IC0JbF9wdXRfbGUxNihpZHgsIG1zZyArIG4pOw0KPiAtCW1zZ1tuICsgMl0gPSAoc3Rh
dHVzICE9IE1FU0hfU1RBVFVTX1NVQ0NFU1MpID8NCj4gKwlsX3B1dF9sZTE2KGlkeCwgJm1zZ1tu
ICsgMV0pOw0KPiArCW1zZ1tuICsgM10gPSAoc3RhdHVzICE9IE1FU0hfU1RBVFVTX1NVQ0NFU1Mp
ID8NCj4gIAkJCQkJCUtFWV9SRUZSRVNIX1BIQVNFX05PTkUgOiBwaGFzZTsNCj4gIA0KPiAtCXJl
dHVybiBuICsgMzsNCj4gKwlyZXR1cm4gbiArIDQ7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB1aW50
OF90IHVpbnQzMl90b19sb2codWludDMyX3QgdmFsdWUpDQo=
