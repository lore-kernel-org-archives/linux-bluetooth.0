Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540EAC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2520714
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HykVc+dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCZRD0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:03:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:34384 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgCZRD0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 13:03:26 -0400
IronPort-SDR: e5OvR886CQdEaCSG8SSblTLgXsycayOoF0+pgsxlDVEosj6XhEd/zQN7u+1e5ULIov0n54Hery
 ymNLtKZH/J2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:03:25 -0700
IronPort-SDR: ZDf/soRTTSvUJaNVW/mBdr9Gol/WPqhlEE82Rxbb/BaCGrUtLeWSRg7l35HZepafkHGRGzY0Hv
 OJrAcNRgeBTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="358209232"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2020 10:03:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 10:03:25 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 10:03:24 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 10:03:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Mar 2020 10:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzHJ1aJez0LJeh++YiiEO4Ur8o7YRX1v533zNJX9KkFf2eaXnDM93MuVJAP4UrchjlyD0ATNmuSJ5fIkfG6wL6XkdJugMyJnA+r0VPET/QOD/gYxORjJ6oBszmdXXs7OhS+KIDP2vUr7l3w5086IfXcXL/ghf0/XAy897aqPlQDtIZSrtyuvakJztRU9Jf2pDOinYKram0iLlc4GF/xqQ7vEjWXdsw6Ue4T91ZXAWYwrc7yoUNOByUmQncnll6gRC4+hmSc7aOOYRW+HNrR2AT0mtakgGwqxhUGmy1mK0aWxCbOnDDy3HCIomdK38E21eYVyC6JVlEb9ZrbcK6y3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5mrjsn8S0XmbkDvp1kn/GDlurXsLPdQkPUH2H3zFbc=;
 b=AXJHCDbM0VlEF1t0WHsdzWbYfSv1Ds521Aps+7ZfpOMqO9rxB7OLYasIK0Sk5SCr0eXXuKxaoCH6LBDOh+QRRGmld4vwDsqWsD9ANaYd1w/c6DIkP5mNAzm2f8HwmIs+ODuYJvNKUmbsVcMQSYbTN8YeYo7dhvzJID8a+/SWehFh7j8JTfxxA2BvlOSiIltCmZaZIPMsfy6vBsacLW6cA8Ynnhz32o05/VjYwfeZvf/goHFKhZj+uMyp2WCrRfLHV67zfsXeeF7hEfOXUkrFUKM5v+DcwZywqnFTLFi3nZdySdvMih/9bFrs8rXNa5WNriaHoJPrs1P3D4FvGP/glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5mrjsn8S0XmbkDvp1kn/GDlurXsLPdQkPUH2H3zFbc=;
 b=HykVc+dEcwAOZob+c5AaijcXUpajLs9Zs466NcmixyWyc4wS2/lkQXR4K+Ze2rsA/STcRlSUGSLAGwxxvztngaqANl5Hw6rObUwGpuFQZDKroEyW9PSMlJjhL7xUpCep+kxSmY70kU5qscoCIpF1DckknX8U1JpCKZ0VBLRq3KY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 26 Mar
 2020 17:03:20 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 17:03:20 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "s.syam@samsung.com" <s.syam@samsung.com>
Subject: Re: [PATCH 1/1] mesh: Handle invalid public keys
Thread-Topic: [PATCH 1/1] mesh: Handle invalid public keys
Thread-Index: AQHWAhJ//DbRrlI6oE2J1DUxWSodGahbHMCA
Date:   Thu, 26 Mar 2020 17:03:20 +0000
Message-ID: <8cb10bcfb4294e625d2af4a653cf92badba3225a.camel@intel.com>
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
         <CGME20200324192822epcas5p2986c35616c596051bb7826457439c893@epcas5p2.samsung.com>
         <1585078044-14974-4-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1585078044-14974-4-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b2addff-424e-46e7-9e96-08d7d1a7960a
x-ms-traffictypediagnostic: MW3PR11MB4682:
x-microsoft-antispam-prvs: <MW3PR11MB4682E5F3AE549F24A933A289E1CF0@MW3PR11MB4682.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(110136005)(66476007)(66556008)(316002)(6506007)(64756008)(66446008)(2616005)(36756003)(91956017)(76116006)(8936002)(66946007)(4326008)(478600001)(81166006)(6512007)(8676002)(186003)(6486002)(5660300002)(2906002)(26005)(71200400001)(81156014)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4682;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzlKzlhMh0k4Wg8pXtaeF9jlxudT8mgF3t1zP0J8F6Mtw5UlT2jvm5f0RhmAAUb7qSOsKRUd4An+QicBKHfcfQ/x0oVbQew2QuVnKwaWWcTXsrZ73ty4trdpYq9So96LImHDePUQc7oMnSsMv5N/9qrkYbRc3UCoHm0Jx5fJoWdhdpYERhftHsWPF38GBjLYAp0xmaSg5ozX3DVJ83cCbFeBGMWbL8DACN6WuhyScsG/+eFKXvwU+6S+V2cq2vRVKRqKo8k5/Fef10VNBHQh82POjw99IgLvclG6vKF6DlrdhNksJuMGfQZMD2X0TAmm28s/+HyDiQFMFusf6qgg0TE8CHLRgc4IULcc+6qtTY9Mze3xeiZu9cXGRW0FUu1RnJm/qPXWtTQVtVGehmhAdVpAOHm22e9Ccqg2VSIaoeOm3409l1WZw68boif6g6pp
x-ms-exchange-antispam-messagedata: 59+5t+/YbK4pZLOHNu7N9Qwryla/vRGOpbj5IBh8ds9UybRTHCT0uu+Nkzdspf8rLtYMd6TbgXYUCTs4GeOcoTRU90XkVTZJkUCC8vmYet7k9n6ZumbARwiAhSgg9BUjgipt/6gD8kaq+IhcRdkXRg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <87DA36A2ACAE204C9D6CD2CB97E30427@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2addff-424e-46e7-9e96-08d7d1a7960a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 17:03:20.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBdYVC5C8CFc7I5OEuYcgRnXcaKxJ3sFkV7Xub4SXXGwbvoX/LDvVuIbW4Gb9IQBz/QgJYmVt6x9KZqDZJ3iAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDAwOjU3ICswNTMwLCBQcmF0aHl1c2hhIE5l
bGx1cmkgd3JvdGU6DQo+IEZyb206IFByYXRoeXVzaGEgTiA8cHJhdGh5dXNoYS5uQHNhbXN1bmcu
Y29tPg0KPiANCj4gQ2hlY2sgZm9yIGludmFsaWQgcHVibGljIGtleXMgcmVjZWl2ZWQgYW5kIHNl
bmQgcHJvdmlzaW9uIGZhaWxlZC4NCj4gLS0tDQo+ICBtZXNoL3Byb3YtYWNjZXB0b3IuYyB8IDM4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bWVzaC9wcm92LWFjY2VwdG9yLmMgYi9tZXNoL3Byb3YtYWNjZXB0b3IuYw0KPiBpbmRleCAwMzk3
MmMyMjcuLmQzOTViYzVmMiAxMDA2NDQNCj4gLS0tIGEvbWVzaC9wcm92LWFjY2VwdG9yLmMNCj4g
KysrIGIvbWVzaC9wcm92LWFjY2VwdG9yLmMNCj4gQEAgLTE4MCw3ICsxODAsNyBAQCBzdGF0aWMg
dm9pZCBzd2FwX3UyNTZfYnl0ZXModWludDhfdCAqdTI1NikNCj4gIAl9DQo+ICB9DQo+ICANCj4g
LXN0YXRpYyB2b2lkIHByb3ZfY2FsY19zZWNyZXQoY29uc3QgdWludDhfdCAqcHViLCBjb25zdCB1
aW50OF90ICpwcml2LA0KPiArc3RhdGljIGJvb2wgcHJvdl9jYWxjX3NlY3JldChjb25zdCB1aW50
OF90ICpwdWIsIGNvbnN0IHVpbnQ4X3QgKnByaXYsDQo+ICAJCQkJCQkJdWludDhfdCAqc2VjcmV0
KQ0KPiAgew0KPiAgCXVpbnQ4X3QgdG1wWzY0XTsNCj4gQEAgLTE5MCwyMiArMTkwLDI3IEBAIHN0
YXRpYyB2b2lkIHByb3ZfY2FsY19zZWNyZXQoY29uc3QgdWludDhfdCAqcHViLCBjb25zdCB1aW50
OF90ICpwcml2LA0KPiAgCXN3YXBfdTI1Nl9ieXRlcyh0bXApOw0KPiAgCXN3YXBfdTI1Nl9ieXRl
cyh0bXAgKyAzMik7DQo+ICANCj4gLQllY2RoX3NoYXJlZF9zZWNyZXQodG1wLCBwcml2LCBzZWNy
ZXQpOw0KPiArCWlmICghZWNkaF9zaGFyZWRfc2VjcmV0KHRtcCwgcHJpdiwgc2VjcmV0KSkNCj4g
KwkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+ICAJLyogQ29udmVydCB0byBNZXNoIGJ5dGUgb3JkZXIg
Ki8NCj4gIAlzd2FwX3UyNTZfYnl0ZXMoc2VjcmV0KTsNCj4gKwlyZXR1cm4gdHJ1ZTsNCj4gIH0N
Cj4gIA0KPiAtc3RhdGljIHZvaWQgYWNwX2NyZWRlbnRpYWxzKHN0cnVjdCBtZXNoX3Byb3ZfYWNj
ZXB0b3IgKnByb3YpDQo+ICtzdGF0aWMgYm9vbCBhY3BfY3JlZGVudGlhbHMoc3RydWN0IG1lc2hf
cHJvdl9hY2NlcHRvciAqcHJvdikNCj4gIHsNCj4gLQlwcm92X2NhbGNfc2VjcmV0KHByb3YtPmNv
bmZfaW5wdXRzLnBydl9wdWJfa2V5LA0KPiAtCQkJcHJvdi0+cHJpdmF0ZV9rZXksIHByb3YtPnNl
Y3JldCk7DQo+ICsJaWYgKCFwcm92X2NhbGNfc2VjcmV0KHByb3YtPmNvbmZfaW5wdXRzLnBydl9w
dWJfa2V5LA0KPiArCQkJcHJvdi0+cHJpdmF0ZV9rZXksIHByb3YtPnNlY3JldCkpDQo+ICsJCXJl
dHVybiBmYWxzZTsNCj4gIA0KPiAtCW1lc2hfY3J5cHRvX3MxKCZwcm92LT5jb25mX2lucHV0cywN
Cj4gLQkJCXNpemVvZihwcm92LT5jb25mX2lucHV0cyksIHByb3YtPnNhbHQpOw0KPiArCWlmICgh
bWVzaF9jcnlwdG9fczEoJnByb3YtPmNvbmZfaW5wdXRzLA0KPiArCQkJc2l6ZW9mKHByb3YtPmNv
bmZfaW5wdXRzKSwgcHJvdi0+c2FsdCkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAtCW1l
c2hfY3J5cHRvX3Byb3ZfY29uZl9rZXkocHJvdi0+c2VjcmV0LCBwcm92LT5zYWx0LA0KPiAtCQkJ
cHJvdi0+Y2FsY19rZXkpOw0KPiArCWlmICghbWVzaF9jcnlwdG9fcHJvdl9jb25mX2tleShwcm92
LT5zZWNyZXQsIHByb3YtPnNhbHQsDQo+ICsJCQlwcm92LT5jYWxjX2tleSkpDQo+ICsJCXJldHVy
biBmYWxzZTsNCj4gIA0KPiAgCWxfZ2V0cmFuZG9tKHByb3YtPnJhbmRfYXV0aF93b3Jrc3BhY2Us
IDE2KTsNCj4gIA0KPiBAQCAtMjE4LDYgKzIyMyw3IEBAIHN0YXRpYyB2b2lkIGFjcF9jcmVkZW50
aWFscyhzdHJ1Y3QgbWVzaF9wcm92X2FjY2VwdG9yICpwcm92KQ0KPiAgCXByaW50X3BhY2tldCgi
TG9jYWxSYW5kb20iLCBwcm92LT5yYW5kX2F1dGhfd29ya3NwYWNlLCAxNik7DQo+ICAJcHJpbnRf
cGFja2V0KCJDb25maXJtYXRpb25TYWx0IiwgcHJvdi0+c2FsdCwgMTYpOw0KPiAgCXByaW50X3Bh
Y2tldCgiQ29uZmlybWF0aW9uS2V5IiwgcHJvdi0+Y2FsY19rZXksIDE2KTsNCj4gKwlyZXR1cm4g
dHJ1ZTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHVpbnQzMl90IGRpZ2l0X21vZCh1aW50OF90IHBv
d2VyKQ0KPiBAQCAtMjk4LDggKzMwNCwxMyBAQCBzdGF0aWMgdm9pZCBwcml2X2tleV9jYih2b2lk
ICp1c2VyX2RhdGEsIGludCBlcnIsIHVpbnQ4X3QgKmtleSwgdWludDMyX3QgbGVuKQ0KPiAgCXN3
YXBfdTI1Nl9ieXRlcyhwcm92LT5jb25mX2lucHV0cy5kZXZfcHViX2tleSArIDMyKTsNCj4gIA0K
PiAgCXByb3YtPm1hdGVyaWFsIHw9IE1BVF9MT0NBTF9QUklWQVRFOw0KPiAtCWlmICgocHJvdi0+
bWF0ZXJpYWwgJiBNQVRfU0VDUkVUKSA9PSBNQVRfU0VDUkVUKQ0KPiAtCQlhY3BfY3JlZGVudGlh
bHMocHJvdik7DQo+ICsJaWYgKChwcm92LT5tYXRlcmlhbCAmIE1BVF9TRUNSRVQpID09IE1BVF9T
RUNSRVQpIHsNCj4gKwkJaWYgKCFhY3BfY3JlZGVudGlhbHMocHJvdikpIHsNCj4gKwkJCW1zZy5v
cGNvZGUgPSBQUk9WX0ZBSUxFRDsNCj4gKwkJCW1zZy5yZWFzb24gPSBQUk9WX0VSUl9VTkVYUEVD
VEVEX0VSUjsNCj4gKwkJCXByb3YtPnRyYW5zX3R4KHByb3YtPnRyYW5zX2RhdGEsICZtc2csIHNp
emVvZihtc2cpKTsNCj4gKwkJfQ0KPiArCX0NCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgc2Vu
ZF9jYXBzKHN0cnVjdCBtZXNoX3Byb3ZfYWNjZXB0b3IgKnByb3YpDQo+IEBAIC00MjMsNyArNDM0
LDEwIEBAIHN0YXRpYyB2b2lkIGFjcF9wcm92X3J4KHZvaWQgKnVzZXJfZGF0YSwgY29uc3QgdWlu
dDhfdCAqZGF0YSwgdWludDE2X3QgbGVuKQ0KPiAgCQlpZiAoKHByb3YtPm1hdGVyaWFsICYgTUFU
X1NFQ1JFVCkgIT0gTUFUX1NFQ1JFVCkNCj4gIAkJCXJldHVybjsNCj4gIA0KPiAtCQlhY3BfY3Jl
ZGVudGlhbHMocHJvdik7DQo+ICsJCWlmICghYWNwX2NyZWRlbnRpYWxzKHByb3YpKSB7DQo+ICsJ
CQlmYWlsLnJlYXNvbiA9IFBST1ZfRVJSX1VORVhQRUNURURfRVJSOw0KPiArCQkJZ290byBmYWls
dXJlOw0KPiArCQl9DQo+ICANCj4gIAkJaWYgKCFwcm92LT5jb25mX2lucHV0cy5zdGFydC5wdWJf
a2V5KQ0KPiAgCQkJc2VuZF9wdWJfa2V5KHByb3YpOw0K
