Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE73C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 16:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDDE21835
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 16:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fFhLf0BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLQQzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:55:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:11267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQQzn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 11:55:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 08:55:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="416902992"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2019 08:55:42 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 08:55:42 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 08:55:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 08:55:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6tyuvVlc1hpVIFmM4g3Pn3DIFa+A6i+7TVdhBRcvA9j7/ewFl8e1h/PBocNHRQ9tlFhY7l1KjqPYaEUi/FhyXotdXrX52ZWW5R97fm2UG2JcB3tGqSTLpuo72jyjVpz35aDsjayQYygqDkKZ2rFfw7PhW6+r6F1WppLUXmLcJuk8Mmvu/Qt9Vufw6N1t4ZsVlRoaEZa/bxqD01D021xfM/xqE/PQFEhVjfzFMZjaDJQkLO/3lfe92Ebd/XTgJqNyP/caWuOWzafDkQduZND/UckpcubdhGHVm8CB5wY3oCJHITzxJffbHIAQTUg9nXs4QFNAj31Nv7OfHa9NPrQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fco0Ai/hTtZDMYviEuFt846lPwTbnR1P+4yjyX8QajU=;
 b=G8uuLFN3vpd/B6ojoQaWtiXiv68jvb0SVQi1vsp/I7+cpxgDGOM7d5FyOIz0MGJoqyNMMuYzgrKlodMjk1kE0Gw4nLhEw6UrcnsVAwfcPqp/YkrGZOkYee8/srWukTi4DH3QCXYfM7aNs85cmCH+7sfpmc/X7SGB0GAlcRqfzW9ze6JXi1lw/iEX5ApAK6E/s3pMPJmDAtvC+wCzTp96YUIRRjZ0eA0+BooXTfeD/0vr445S8/9WXe/WY4yV+5XLKGH2QLU4HwE6zNmxEhzKh1DRO3irA8HOO2A/K6GAH3K5Q2Dv4BDl5djouMUaRtdtm3IMHE/gRjBsdHgKUXUXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fco0Ai/hTtZDMYviEuFt846lPwTbnR1P+4yjyX8QajU=;
 b=fFhLf0BEhyr8dFc7vXttnv2zyN+vYwY+dB1f2h10c7r2bGirnlcij9y4+awrrVSHYc3xn7DTOfOtx83CQYXSTcx2wImczpwqM8KPbaqf96Zv9jkMpphPunbnljXoXOKOLmgj7wqxmAwjPgqRIAM2jOOs5VGjECLmkmBIai+kwVs=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Tue, 17 Dec 2019 16:55:27 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 16:55:27 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "yury@ygsoftware.com.au" <yury@ygsoftware.com.au>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh-cfgclient fails with 'Segmentation fault'
Thread-Topic: mesh-cfgclient fails with 'Segmentation fault'
Thread-Index: AdW07CI9akHkPeGZRIeoVtfEhG5axgAA0Y4AAAGSLoAAAUWXAA==
Date:   Tue, 17 Dec 2019 16:55:27 +0000
Message-ID: <5cd5562573fe4e277088807c5fe479919996be3e.camel@intel.com>
References: <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com>
          <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com>
          <0101016f14697e81-b2b4716b-65b2-47c1-949b-36193e42ecf7-000000@us-west-2.amazonses.com>
          <20191217153402.teo4tv44fxgbvmkd@mlowasrzechonek2133>
          <mail.818c9bc4-2f51-4df1-a8f3-a37c0d84cc99@storage.wm.amazon.com>
          <mail.818c9bc4-2f51-4df1-a8f3-a37c0d84cc99@storage.wm.amazon.com>
         <0101016f14a7d6f7-c2c20ba5-322b-4803-b010-472848fc33b4-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016f14a7d6f7-c2c20ba5-322b-4803-b010-472848fc33b4-000000@us-west-2.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 092a0d39-17d9-4c1f-79a2-08d78311eb00
x-ms-traffictypediagnostic: CY4PR11MB1256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1256DDB091ADCF8290B2D858E1500@CY4PR11MB1256.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(51914003)(66946007)(76116006)(107886003)(110136005)(2906002)(36756003)(64756008)(66476007)(66556008)(966005)(6486002)(66446008)(5660300002)(8676002)(71200400001)(2616005)(6512007)(316002)(478600001)(186003)(81156014)(81166006)(86362001)(4326008)(6506007)(4001150100001)(26005)(8936002)(54906003)(91956017)(66574012);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1256;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61w4BDcANYljXjJwWonLYOLsuJWDvZxAr44POy81mCslqKBNrolFBoB8KE7LNfgWc+BUEECdfz63gvSQTUvM64vDn6QxTpbPEP/35TaTKJoKhqNsMQFdCTqjXRo/soN8xOot2jYWREqpMcCDkXhdq2jpbarRKm94psZNBdGsIpPMj35a/hxZsJ/SU++eqPi3jBwO3bficBLKCh6yRd6SSCL9IQIcsFaAxEjWt43ctuKqiHW4G7e5I+rwhfAMp6qj2YI+P4lOkTnaEjBVGrxTsaRb5ikY5SoP02kMVUUgxVI4c7L6VDhn8tCRvbVMBIh03dLNHbwZ5LCyY3H8b58XtP8qizsBGvyUGGvV2VQqy5TgrxpDhAssbik+va174OZ8+EOIzgsEa3KixxPHEqThcGWXvBHCSZQ0lPskwZZM+3FGA18usvWGzVav5p6b+XPIcj6uqGVdgghTn1Dwm0uNgeLqh9+zfZjpV+8zd5YbDSh8NTeMfsrbuqatavuV7uoyv4H7/OTyW66xsJveWYNH9I21Y8G9PhRN3AadCTwtJ60=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D121912A3ADBF45A9FA0D32CF3BAEE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 092a0d39-17d9-4c1f-79a2-08d78311eb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 16:55:27.4585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYtzIMnO0D++w9e6C/mNqpR5glx6AQzrKlzVh7vaf+0zgibMakRyjhanH00tsJ2OXd3dhMHPa7Rpx9vWucT48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgWXVyeSwNCg0KT24gVHVlLCAyMDE5LTEyLTE3IGF0IDE2OjE5ICswMDAwLCBZdXJ5IEdhbHVz
dG92IHdyb3RlOg0KPiBIaSBNaWNoYcWCLA0KPiBUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25z
ZS4NCj4gDQo+ID4gT24gMTIvMTcsIFl1cnkgR2FsdXN0b3Ygd3JvdGU6DQo+ID4gPiBwaUByYXNw
YmVycnlwaTp+L2JsdWV6LW1hc3RlciAkIC4vdG9vbHMvbWVzaC1jZmdjbGllbnQNCj4gPiA+IFdh
cm5pbmc6IGNvbmZpZyBmaWxlICIvaG9tZS9waS8uY29uZmlnL21lc2hjZmcvY29uZmlnX2RiLmpz
b24iIG5vdCBmb3VuZA0KPiA+ID4gDQo+ID4gPiBbbWVzaC1jZmdjbGllbnRdIyBjcmVhdGUNCj4g
PiA+IFNlZ21lbnRhdGlvbiBmYXVsdA0KPiA+ID4gDQo+ID4gPiBIYXBweSB0byBkZWJ1ZyB0aGUg
Y29kZSBpZiBzb21lYm9keSB3b3VsZCBleHBsYWluIGhvdyApDQo+ID4gDQo+ID4gWW91IG1pZ2h0
IHRyeSBydW5uaW5nIGl0IHVuZGVyIGEgZGVidWdnZXI6DQo+ID4gICQgZ2RiIC4vdG9vbHMvbWVz
aC1jZmdjbGllbnQgLWV4IHJ1bg0KPiA+IGFuZCBjYXB0dXJlIHRoZSBiYWNrdHJhY2UgdmlhICJi
dCIgY29tbWFuZC4NCj4gPiANCj4gPiBBbHRob3VnaCBob25lc3RseSwgSSdkIHJlY29tbWVuZCBw
bGF5aW5nIHdpdGggRC1CdXMgQVBJIGRpcmVjdGx5LCBlLmcuDQo+ID4gaW4gUHl0aG9uLg0KPiA+
IA0KPiA+IFRoZSBjb21tYW5kIGxpbmUgaXMgYSBiaXQgYWxwaGEuDQo+ID4gDQo+ID4gLS0gDQo+
ID4gTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgPG1pY2hhbC5sb3dhcy1yemVjaG9uZWtAc2lsdmFp
ci5jb20+DQo+ID4gU2lsdmFpciBodHRwOi8vc2lsdmFpci5jb20NCj4gPiBKYXNub2fDs3Jza2Eg
NDQsIDMxLTM1OCBLcmFrb3csIFBPTEFORA0KPiANCj4gV2FybmluZzogY29uZmlnIGZpbGUgIi9o
b21lL3BpLy5jb25maWcvbWVzaGNmZy9jb25maWdfZGIuanNvbiIgbm90IGZvdW5kDQo+IFttZXNo
LWNmZ2NsaWVudF0jIGNyZWF0ZQ0KPiANCj4gUHJvZ3JhbSByZWNlaXZlZCBzaWduYWwgU0lHU0VH
ViwgU2VnbWVudGF0aW9uIGZhdWx0Lg0KPiBsX2RidXNfcHJveHlfbWV0aG9kX2NhbGwgKHByb3h5
PTB4MCwgbWV0aG9kPW1ldGhvZEBlbnRyeT0weDM0MmMwICJDcmVhdGVOZXR3b3JrIiwgc2V0dXA9
c2V0dXBAZW50cnk9MHgxNGZhMA0KPiA8Y3JlYXRlX25ldF9zZXR1cD4sDQoNClRoaXMgZmFpbHVy
ZSBvY2N1cnMgKHdpdGggcHJveHk9TlVMTCkgd2hlbiB0aGUgYmx1ZXRvb3RoLW1lc2hkIGRhZW1v
biBpcyBydW5uaW5nLCBidXQgaXQgd2FzIHVuYWJsZSB0byBmaW5kIGFuDQpMRSBjYXBhYmxlIEJU
IGNvbnRyb2xsZXIuICBUaGlzIGlzIGEgbG5vd24gaXNzdWUsIHRoYXQgd2Ugc2hvdWxkIHByb2Jh
Ymx5IHB1dCBpbiB0aGUgYmx1ZXovdG9vbHMvbWVzaC9SRUFETUUNCmZpbGUuLi4gICBCdXQgZm9y
IG5vdyB0aGVyZSBhcmUgYSBmZXcgd2F5cyB0byBhZGRyZXNzIGl0Og0KDQoxLiBNYWtlIHN1cmUg
dGhhdCB0aGUgYmx1ZXRvb3RoZCBkYWVtb24gaXMgbm90IGNsYWltaW5nIGFsbCB0aGUgQlQgY29u
dHJvbGxlcnMuICBJZiB5b3UgaGF2ZSBtdWx0aXBsZSBCVA0KY29udHJvbGxlcnMgaW4geW91ciBz
eXN0ZW0sIGNoYW5nZSB0aGUgZm9sbG93aW5nIHZhbHVlIGluIHlvdXIgL2V0Yy9ibHVldG9vdGgv
bWFpbi5jb25mIGZpbGU6DQoNCltQb2xpY3ldDQpBdXRvRW5hYmxlPWZhbHNlDQoNCldpdGggQXV0
b0VuYWJsZSB0cnVlLCBibHVldG9vdGhkIGNsYWltcyBhbGwgY29udHJvbGxlcnMuIChibHVldG9v
dGhkIG11c3QgYmUgcmVzdGFydGVkIGZvciBjaGFuZ2UgdG8gdGFrZQ0KZWZmZWN0KS4NCg0KMi4g
SWYgeW91IGhhdmUgb25seSBvbmUgQlQgY29udHJvbGxlciBpbiB5b3VyIHN5c3RlbSwgeW91ICpt
dXN0KiBkaXNhYmxlIGJsdWV0b290aCBkYWVtb24gdG8gdXNlIG1lc2gtDQpibHVldG9vdGguLi4g
IFRvIGRpc2FibGUgYmx1ZXRvb3RoZCBlbnRpcmVseSAobGVhdmluZyB0aGUgY29udHJvbGxlcihz
KSB0byBibHVldG9vdGgtbWVzaGQpIGRpc2FibGUgYW5kIHN0b3ANCnRoZSBtYWluIGJsdWV0b290
aCBkYWVtb246DQoNCiMgc3lzdGVtY3RsIGRpc2FibGUgYmx1ZXRvb3RoDQojIHN5c3RlbWN0bCBz
dG9wIGJsdWV0b290aA0KDQoNCldlIGhvcGUgdG8gZ2V0IHRoZSB0d28gZGFlbW9ucyB0byBjby1l
eGlzdCBhdCBzb21lIHBvaW50LCBidXQgdGhhdCB3aWxsIHJlcXVpcmUga2VybmVsIGNoYW5nZXMs
IHNvIGZvciBub3cNCnRoZXNlIGFyZSB5b3VyIHR3byBjaG9pY2VzLg0KDQoNCj4gICAgIHJlcGx5
PXJlcGx5QGVudHJ5PTB4MTRlMDQgPGNyZWF0ZV9uZXRfcmVwbHk+LCB1c2VyX2RhdGE9MHgwLCBk
ZXN0cm95PTB4MCkgYXQgZWxsL2RidXMtY2xpZW50LmM6MzA0DQo+IDMwNCAgICAgICAgICAgICBy
ZXEgPSBsX25ldyhzdHJ1Y3QgbWV0aG9kX2NhbGxfcmVxdWVzdCwgMSk7DQo+IChnZGIpIGJ0DQo+
ICMwICBsX2RidXNfcHJveHlfbWV0aG9kX2NhbGwgKHByb3h5PTB4MCwgbWV0aG9kPW1ldGhvZEBl
bnRyeT0weDM0MmMwICJDcmVhdGVOZXR3b3JrIiwgc2V0dXA9c2V0dXBAZW50cnk9MHgxNGYNCj4g
YTAgPGNyZWF0ZV9uZXRfc2V0dXA+LA0KPiAgICAgcmVwbHk9cmVwbHlAZW50cnk9MHgxNGUwNCA8
Y3JlYXRlX25ldF9yZXBseT4sIHVzZXJfZGF0YT0weDAsIGRlc3Ryb3k9MHgwKSBhdCBlbGwvZGJ1
cy1jbGllbnQuYzozMDQNCj4gIzEgIDB4MDAwMTViMDAgaW4gY21kX2NyZWF0ZV9uZXR3b3JrIChh
cmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj08b3B0aW1pemVkIG91dD4pIGF0IHRvb2xzL21lc2gt
DQo+IGNmZ2NsaWVudC5jOjcxMQ0KPiAjMiAgMHgwMDAxZTM5OCBpbiBjbWRfZXhlYyAoYXJndj0w
eDY5MzA4LCBhcmdjPTEsIGVudHJ5PTB4MzMyMTAgPG1haW5fbWVudSs4PikgYXQgc3JjL3NoYXJl
ZC9zaGVsbC5jOjQ0MQ0KPiAjMyAgbWVudV9leGVjIChlbnRyeT0weDMzMjEwIDxtYWluX21lbnUr
OD4sIGFyZ2M9YXJnY0BlbnRyeT0xLCBhcmd2PWFyZ3ZAZW50cnk9MHg2OTMwOCkgYXQNCj4gc3Jj
L3NoYXJlZC9zaGVsbC5jOjQ2OA0KPiAjNCAgMHgwMDAxZTczMCBpbiBzaGVsbF9leGVjIChhcmdj
PTEsIGFyZ3Y9MHg2OTMwOCkgYXQgc3JjL3NoYXJlZC9zaGVsbC5jOjUxMQ0KPiAjNSAgMHgwMDAx
ZjY4NCBpbiBybF9oYW5kbGVyIChpbnB1dD0weDY5MDY4ICJjcmVhdGUiKSBhdCBzcmMvc2hhcmVk
L3NoZWxsLmM6NzEzDQo+ICM2ICAweGI2ZjdjZGMwIGluIHJsX2NhbGxiYWNrX3JlYWRfY2hhciAo
KSBmcm9tIC9saWIvYXJtLWxpbnV4LWdudWVhYmloZi9saWJyZWFkbGluZS5zby43DQo+ICM3ICAw
eDAwMDFlNjA4IGluIGlucHV0X3JlYWQgKGlvPTxvcHRpbWl6ZWQgb3V0PiwgdXNlcl9kYXRhPTxv
cHRpbWl6ZWQgb3V0PikgYXQgc3JjL3NoYXJlZC9zaGVsbC5jOjEyNTYNCj4gIzggIDB4MDAwMjJm
OWMgaW4gaW9fY2FsbGJhY2sgKGZkPTxvcHRpbWl6ZWQgb3V0PiwgZXZlbnRzPTEsIHVzZXJfZGF0
YT0weDY5MjgwKSBhdCBlbGwvaW8uYzoxMjYNCj4gIzkgIDB4MDAwMjNlMjggaW4gbF9tYWluX2l0
ZXJhdGUgKHRpbWVvdXQ9PG9wdGltaXplZCBvdXQ+KSBhdCBlbGwvbWFpbi5jOjQ3MA0KPiAjMTAg
MHgwMDAyM2VmMCBpbiBsX21haW5fcnVuICgpIGF0IGVsbC9tYWluLmM6NTIwDQo+ICMxMSBsX21h
aW5fcnVuICgpIGF0IGVsbC9tYWluLmM6NTAyDQo+ICMxMiAweDAwMDI0MTUwIGluIGxfbWFpbl9y
dW5fd2l0aF9zaWduYWwgKGNhbGxiYWNrPTxvcHRpbWl6ZWQgb3V0PiwgdXNlcl9kYXRhPXVzZXJf
ZGF0YUBlbnRyeT0weDApIGF0DQo+IGVsbC9tYWluLmM6NjQyDQo+ICMxMyAweDAwMDIwMmQwIGlu
IG1haW5sb29wX3J1bl93aXRoX3NpZ25hbCAoZnVuYz08b3B0aW1pemVkIG91dD4sIHVzZXJfZGF0
YT11c2VyX2RhdGFAZW50cnk9MHgwKSBhdA0KPiBzcmMvc2hhcmVkL21haW5sb29wLWVsbC5jOjg3
DQo+ICMxNCAweDAwMDFmOTBjIGluIGJ0X3NoZWxsX3J1biAoKSBhdCBzcmMvc2hhcmVkL3NoZWxs
LmM6MTE3NA0KPiAjMTUgMHgwMDAxMjk4MCBpbiBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0Piwg
YXJndj08b3B0aW1pemVkIG91dD4pIGF0IHRvb2xzL21lc2gtY2ZnY2xpZW50LmM6MTk4Mg0KPiAN
Cj4gDQo=
