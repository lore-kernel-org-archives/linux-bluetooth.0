Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2FFC1975A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024F1206EB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="q/Awr8Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCLSWT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:22:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:30018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLSWT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 14:22:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="442151301"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2020 11:22:05 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:22:05 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX122.amr.corp.intel.com (10.22.225.227) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:22:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0KrnS998PF3oQ3S6LdAfklfY2JHKD1Zi7NaqL03jSWhsM2REtoo0LPwY9voy1CvJM8xyiWivUZtd6IUH0mXi7SC8Qyh9jotJMQEL5Q6kK6horfO5rxwzPFOK8ap/zcNmQnOtZzkw6hH7hCm9rTpWM6HmM+dMFYEBnG5n1SmW1Wgk7j74N6DNtR2nr2YY2Qwsl2+ikq8bUzikTsJre0hhWDkdRniv6Af/8afL6SJclhSLO5NknGOGxJ0FeEmEQJC1Gvewchq09sObsR4FrRGY03Z71DKHUBG7ZJRTznv3GZ9WHhRm83cCuh784eDocy405yP0nFHdywIgR4Zwvw0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUliEi6ahEi+mMUaAKPXkJQKcmk3/kEyBVKNJpKmsSE=;
 b=AGG0llChH+ozSX07tqZA1LZ/vx5IETueSg8iSFctNTpvZVHl9srGewY+7YntdJH8MVseB3Xq3uyQ7w/yHTDlSxq60O4iXW+elvUW70VuEms57ZBuGjheENFjQnHlQenCMKlhqGhy+zkDe04nTZYCEfApkbtYcyJwhBUfdjVga2vhDWjVwe3QUvjScWUXLnSobXRNvj40HbGJu/1XRz1zBmzGveQwzrk7+3zaFgxHh224uD7B2GQK1c8bs1ZZaUyzNgf3uJxzFKvPMqj2OT6kI7LB7wd7TLnUWi2X3TA2hmpxE/uakeo8cE95kOulqmTirfKTZBPZRzcZDJYWvjaWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUliEi6ahEi+mMUaAKPXkJQKcmk3/kEyBVKNJpKmsSE=;
 b=q/Awr8KsfyYfrH6sbyQZ0cHg1k/pm0Vsavoh7sWfg96n6mLo8judQdC1ydtHYVUCRwDT1PufYb1mHkhxMs3ueG8rFz0e6RCGqKrgdG9kN1vMZAdA08lALosXx22kI65PFS55jh0sZNMcF4jauqqSaajc6iU0oMOG8hVNvNqqNX0=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 18:22:04 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 18:22:04 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "pachoramos1@gmail.com" <pachoramos1@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] README: Add Mesh required Kernel Configuration
 section
Thread-Topic: [PATCH BlueZ] README: Add Mesh required Kernel Configuration
 section
Thread-Index: AQHV9/KgDI7hu2ZOM0WxPl4a4SUJkqhFRlsA
Date:   Thu, 12 Mar 2020 18:22:04 +0000
Message-ID: <0fab56c52f87cfc948d251c146c577fe71a15abe.camel@intel.com>
References: <20200311221518.25060-1-brian.gix@intel.com>
In-Reply-To: <20200311221518.25060-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d49203e1-c7f4-4177-7827-08d7c6b243f4
x-ms-traffictypediagnostic: MW3PR11MB4745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4745E14C00C1EDDEA89EA03CE1FD0@MW3PR11MB4745.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(5660300002)(478600001)(81166006)(8936002)(2616005)(186003)(26005)(6506007)(81156014)(6916009)(107886003)(86362001)(76116006)(6486002)(316002)(91956017)(4326008)(66556008)(36756003)(8676002)(54906003)(66446008)(6512007)(64756008)(66946007)(2906002)(66476007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4745;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVsOXItk74r1M4rn8pkyCskmwY9w1h/V+QggdANhguGQvjt0q77sEs+ozAkxAKYRmEF/2a9ESSMV8QHsOSRiLl4m0f6VlVozb9ylNfs8L/YG3DDpZi6cMjRf5N7Rg9L/DTzW9utYc+XZlCO3t1orgtqf+tQZbMGTCOBTRLru7VU83c13qpvbt7MmhEpz1YcJ1Dyhl3YRnRqUuR3s+LhS09xamJmwcXHjD/EkIbu9pNVKQXb1De4sCd5vtj9WyZy8Q8J1F+Jjny5ztV1jYtv7dKN9AD5H4oVe6un2BAwPyH1YExZZhNDoODSTz/BA/Ipfhn63zMJ21SeuIHfrFeRvhtCec+NofuZjh6CoRUkBQw6+4is08zyuiQCKD7UjYlwlmt1MpqMCX96BL01DXZDmMqTtQYjqy5TvRCty1Vu6rKJ7NK6n7hqaOyDnBNORTgLR
x-ms-exchange-antispam-messagedata: i1+qRxZNLLTxP5Pmc13O8PnPaZgTV7ZedYq4hZOt61sdGA4q1wf9htqIxA2vjViD2eU38XxSnpvaHegnHRHKVyDeoA/RdakbGlpAFDPEMgdKZ1HOyzcwFZG2stPfFvyozBsknlpzEZGlhpoLjidCPQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <424FCEDCBC4357458433C54BD93E6E75@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d49203e1-c7f4-4177-7827-08d7c6b243f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 18:22:04.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nkujr7KEn13gz0VO1mEkb4HLxF0iwejftA0uQYsHvkXj1KOSiPI2/8wZd0JnL0HwZqZwW81l6nhuy56RRVWUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTExIGF0IDE1OjE1IC0wNzAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IE5vdCBhbGwgZGlzdHJpYnV0aW9ucyBpbmNsdWRlIGFsbCByZXF1aXJlZCBtZXNoIGNy
eXB0byBzdXBwb3J0LiAgVGhpcw0KPiBhZGRzIGEgc2VjdGlvbiB3aXRoIGtub3duIGtlcm5lbCBy
ZXF1aXJlZCBvcHRpb25zLg0KPiAtLS0NCj4gIFJFQURNRSB8IDI1ICsrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvUkVBRE1FIGIvUkVBRE1FDQo+IGluZGV4IGM3MDMyZDAyYi4uYWQwYTMwN2Y0IDEw
MDY0NA0KPiAtLS0gYS9SRUFETUUNCj4gKysrIGIvUkVBRE1FDQo+IEBAIC02MSw2ICs2MSwzMSBA
QCBXaGVuIG5laXRoZXIgLS1lbmFibGUtbWVzaCBub3IgLS1lbmFibGUtYnRwY2xpZW50IGlzIHNw
ZWNpZmllZCwgdGhlbiB0aGlzDQo+ICBwYXJ0IGlzIGlycmVsZXZhbnQgYW5kIEVtYmVkZGVkIExp
bnV4IGxpYnJhcnkgaXMgbm90IHJlcXVpcmVkLg0KPiAgDQo+ICANCj4gK0tlcm5lbCBCdWlsZCBP
cHRpb25zIChmb3IgTWVzaCkNCj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4g
Kw0KPiArVGhlIE1lc2ggZGFlbW9uIHVzZXMga2VybmVsIHByb3ZpZGVkIGNyeXB0byB1dGlsaXRp
ZXMgdG8gcGVyZm9ybSByZXF1aXJlZA0KPiArc2VjdXJpdHkgc2VjdXJpdGllcyBvZiBCbHVldG9v
dGggTWVzaC4gTWFueSBzdGFuZGFyZCBkaXN0cmlidXRpb25zIGN1cnJlbnRseQ0KPiArZW5hYmxl
IGFsbCByZXF1aXJlZCBjcnlwdG8gZmVhdHVyZXMsIGJ1dCBhIGZldyBub3RhYmxlIGRpc3RyaWJ1
dGlvbnMgZG8NCj4gK25vdC4NCj4gKw0KPiArSWYgTWVzaCBDcnlwdG9ncmFwaHkgaXMgbm90IHdv
cmtpbmcsIHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbiBvcHRpb25zDQo+ICttYXkgbmVlZCB0
byBiZSBlbmFibGVkLCBhbmQgdGhlIGtlcm5lbCByZWJ1aWx0Lg0KPiArDQo+ICsxLiBBIG1pbmlt
dW0gb2Yga2VybmVsIHZlcnNpb24gNC45IG9yIGxhdGVyIGlzIHJlcXVpcmVkDQo+ICsNCj4gKzIu
IFRoZSBrZXJuZWwgbXVzdCBhdCBhIG1pbmltdW0gaGF2ZSB0aGUgZm9sbG93aW5nIC5jb25maWcg
b3B0aW9ucyB0dXJuZWQgb246DQo+ICsJQ09ORklHX0NSWVBUT19VU0VSDQo+ICsJQ09ORklHX0NS
WVBUT19VU0VSX0FQSQ0KPiArCUNPTkZJR19DUllQVE9fVVNFUl9BUElfQUVBRA0KPiArCUNPTkZJ
R19DUllQVE9fVVNFUl9BUElfSEFTSA0KPiArDQo+ICsJQ09ORklHX0NSWVBUT19BRVMNCj4gKwlD
T05GSUdfQ1JZUFRPX0NDTQ0KPiArCUNPTkZJR19DUllQVE9fQUVBRA0KPiArCUNPTkZJR19DUllQ
VE9fQ01BQw0KPiArDQo+ICsNCj4gIENvbmZpZ3VyYXRpb24gYW5kIG9wdGlvbnMNCj4gID09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gIA0K
