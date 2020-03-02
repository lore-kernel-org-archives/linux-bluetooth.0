Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0952FC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C575D22B48
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="aaP9EvuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCBRb3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:31:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:10026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgCBRb2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 12:31:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 09:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="239708274"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2020 09:31:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 09:31:26 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:31:25 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:31:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 2 Mar 2020 09:31:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6npPgd5l/2wykCRBlJHdHzcarR1ZtQUS7aUE24A0nBsi+nfj+cFvyxo9fDz582FFv3hriU72ipwEUKVXTLwbmgqQETPs5OBP6O2pZ5j4T8L4hfgnGX1SBCvWAnZWrHA4mHvWJZt3y3Qah94pTGeCZiEwpXyJeioTbRQOFtKFyJDaYANad7jAynm6uW8QP0Gi4zxqlbAph8k22efzmG1OR+gliaqKzvZLyf7fqX4Y9SwldMCWYPxlzQJRyzeAwhyqlGw3b32W09DAdHETBYsOByIXR8BbGXfqxtXtPVBxW+jTPT/hc0FUDNT41nX3gYbsxso+4oGeo4tQp5nAcAwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L9dkjFJLu9q+tlKniJctKzvl6tFOmSK4o9NIAbDB5U=;
 b=MAtUgfdDix7aziknQjsmdGqbxaifewBc+YCaukHyQRq3Lgai1wzRiO7TRgMcAHEmPL1nbB7hZyE8hQnHwIqVKP62xgirvFhqBzh9WOMvvb8LOg1tPJ5GmgUS9ruGaEVvx3Q0QjFvdxM7rotonsriKA7xFmdyl0Z0aasvqvrDQ7SyRhPqFQ2s2cqXsj8mMrJ+rlxWcyBqNGO0HeIs3JP3YpcR6fLuE7uxg9AP70LTppNfWUk13zRsvm2e7AjbSTeOiqY6AijaAn/vJPmaJ97rs5vBQL7ZZx7q2vuVqo7zA9QHFrqK5A10nqeELM68ejqOGB/xwF2szjphf05s+IOEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L9dkjFJLu9q+tlKniJctKzvl6tFOmSK4o9NIAbDB5U=;
 b=aaP9EvuYtMH/RPstIN8CP4Ir92F/oWtBxaQJ9JUMUGcQ2TL3pQ9x6ZyESmGE24HjwFw/ilnrGErFRQaoubJ4S+nLmbGjdfzzz8MDoqxI/T2009o+ySQ//NWo8o3UOdmRF4h3P6TtvTuL21ubsZQN2nJMj721JL0gJrAoN1q5+aI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 17:31:24 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 17:31:24 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Topic: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Index: AQHV8JHINvUFOeOxHkqiBtq6PDPN6ag1WuqAgAAJHwCAACHegIAABVoAgAAEZIA=
Date:   Mon, 2 Mar 2020 17:31:24 +0000
Message-ID: <17a69d79616ada7b4e64da8c7b3829ec594c755a.camel@intel.com>
References: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
         <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
         <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p7>
         <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
         <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
         <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
In-Reply-To: <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b83119d6-0eca-4215-5d74-08d7becf87ec
x-ms-traffictypediagnostic: MW3PR11MB4731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4731DA86CFB630D78FE98520E1E70@MW3PR11MB4731.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(6512007)(6486002)(71200400001)(86362001)(8676002)(81166006)(81156014)(66574012)(4326008)(66446008)(66556008)(64756008)(66946007)(5660300002)(76116006)(91956017)(6506007)(66476007)(6636002)(316002)(8936002)(26005)(186003)(2616005)(478600001)(36756003)(110136005)(2906002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4731;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HyKW8Zr2SCypu4R3TeqbHbfYNOxJgajsS55CVyIVzXRSuQdtb/iv+LexmDIlRHlaJdGMitZ2gxfnYW0PKqwh9RUz6jmvnHZGb2gYlgUtboTFGT+T/2KHzgAkPWUuWLESSWvg98+Bs8JpJ5GXA1DB7S9LwZ9Lf77ElFxIKd0Nh7EE1YISqc+QYaHC3oVfqCrnLDBNmQgOVF7j64ZkSGxad70rQ1o16vZM1HDuDEzvT+ThS+lKOsn9w/wRaRUd7ehC7n2aP7dEdtpff1YbSRJAD6d1xKLQJQ/KkRA7PsVJvjWJWgyGuAomPGe8rKejxmDzUyy03rCdRNtdMVxMaJ93ZpvF9PBKKktMWNrNBaHMQ7jLnOgegLBEu4zMfnlTgiVRr/cXAYGt7mIdGMwYR5scoAYxwbzib03EnTWweQQG/j89bdbK3c4fQBS2DAuiX2/5
x-ms-exchange-antispam-messagedata: LNnN9UrKbQxVpdBD/F2F9G5hDzMBBtzDweQUy9M6AhPMaZvCDeQ/FNcKVmXVjqbyhQstLFZF34FYxKii5tzYrY0rtJQihECkHkxZHtxKo3d9wsvZvzQjKJoP9HEsCbSlmjuRLFPKjR0vwc9qDbajmw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5C6398DF777DC49A4234B51A8EC2BA1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b83119d6-0eca-4215-5d74-08d7becf87ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 17:31:24.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DoyxgC+t8pdFmj7jhbayV5FQTODLA2bi9FXyF7BbkwH7o764noeIBvs47l2+wNYNSszbn7OqY7OTANU61mN9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwgYW5kIGFsbCwNCk9uIE1vbiwgMjAyMC0wMy0wMiBhdCAxNzoxNSArMDAwMCwgU3Rv
dGxhbmQsIEluZ2Egd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gTW9uLCAyMDIwLTAzLTAyIGF0IDE2
OjU2ICswMDAwLCBHaXgsIEJyaWFuIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMy0wMiBhdCAy
MDoyNSArMDUzMCwgQW51cGFtIFJveSB3cm90ZToNCj4gPiA+IEhpIE1pY2hhbCwNCj4gPiA+ICAN
Cj4gPiA+ID4gLS0tLS0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0tLS0tDQo+ID4gPiA+IFNl
bmRlciA6IE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIDwNCj4gPiA+ID4gbWljaGFsLmxvd2FzLXJ6
ZWNob25la0BzaWx2YWlyLmNvbQ0KPiA+ID4gPiBEYXRlIDogMjAyMC0wMy0wMiAxOTo1MiAoR01U
KzU6MzApDQo+ID4gPiA+IFRpdGxlIDogUmU6IFJlZ2FyZGluZyBPT0IgYXV0aGVudGljYXRpb24g
bWV0aG9kICYgYWN0aW9uIGZvciBNZXNoDQo+ID4gPiA+IHByb3Zpc2lvbmVyDQo+ID4gPiA+IA0K
PiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDAzLzAyLCBBbnVwYW0gUm95IHdyb3Rl
Og0KPiA+ID4gPiA+IEFsc28sIEkgd291bGQgbGlrZSB0byBrbm93LCB3aGV0aGVyIHRoZXJlIGlz
IGFueSBwbGFuIHRvDQo+ID4gPiA+ID4gUmVxdWVzdA0KPiA+ID4gPiA+IGV4dGVybmFsIHByb3Zp
c2lvbmluZyBBZ2VudCB0byBjaG9vc2UgUHJvdmlzaW9uaW5nIG1ldGhvZCAmDQo+ID4gPiA+ID4g
c3BlY2lmaWMNCj4gPiA+ID4gPiBhY3Rpb24/ICBUaGUgcmVhc29uIGJlaW5nLCBzb21lICphcHBs
aWNhdGlvbiogbWF5IGJlIGludGVyZXN0ZWQNCj4gPiA+ID4gPiBpbiBhDQo+ID4gPiA+ID4gcGFy
dGljdWxhciBTZWN1cml0eSBsZXZlbCAmIEF1dGhlbnRpY2F0aW9uIGFjdGlvbiwgZGVwZW5kaW5n
IG9uDQo+ID4gPiA+ID4gaXRzDQo+ID4gPiA+ID4gb3duIEkvTyBjYXBhYmlsaXRpZXMuDQo+ID4g
PiA+IA0KPiA+ID4gPiBGb3IgdGhlIHJlY29yZCwgd2UgYWxzbyBuZWVkIHRoaXMgaXMgZnVuY3Rp
b25hbGl0eS4gT25lIG9mIHRoZQ0KPiA+ID4gPiBwb3NzaWJsZQ0KPiA+ID4gPiBzY2VuYXJpb3Mg
aXMgaGF2aW5nIGEgcHJvdmlzaW9uZXIgd2hvIGRvZXNuJ3QgaGF2ZSBhIHJlbGlhYmxlDQo+ID4g
PiA+IEludGVybmV0DQo+ID4gPiA+IGNvbm5lY3Rpb24gYW5kIG1pZ2h0IHdhbnQgdG8gZmFsbCBi
YWNrIHRvIChsZXNzIHNlY3VyZSkgT09CDQo+ID4gPiA+IGFjdGlvbnMgaWYNCj4gPiA+ID4gaXQg
Y2Fubm90IG9idGFpbiBPT0IgcHVibGljIGtleS4NCj4gPiA+ID4gDQo+ID4gPiA+IFdlJ3ZlIGJl
ZW4gcGxhbm5pbmcgdG8gc2VuZCBhIHBhdGNoIGltcGxlbWVudGluZyBhIEQtQnVzIEFQSSBmb3IN
Cj4gPiA+ID4gdGhhdCwNCj4gPiA+ID4gYnV0IGl0J3Mgbm90IHJlYWR5IHlldCA6KA0KPiA+ID4g
DQo+ID4gPiBPa2F5LCB0aGF0IHdvdWxkIGJlIG5pY2UgJiBhbmQgd2lsbCBpdCBhbGxvdyBhcHBs
aWNhdGlvbiB0byBjaG9vc2UNCj4gPiA+IGJvdGggYSkgIk9PQiBQdWIgS2V5KFdpdGgvV2l0aG91
dCkiIGFzDQo+ID4gPiB3ZWxsIGFzICBiKSJPT0IgQXV0aCBNZXRob2RzKElOL09VVC9TdGF0aWMv
Tm8gT09CKSAmDQo+ID4gPiBBY3Rpb25zKEJsaW5rL0JlZXAvVmlicmF0ZS9OdW0vYWxwaGEgZXRj
LikiPw0KPiA+IA0KPiA+IFRoZSBvcmlnaW5hbCBwbGFuIGZvciB0aGlzIHdhcyB0aGF0IGFuIEFn
ZW50IGRlZmluZXMgaXQncw0KPiA+IENhcGFiaWxpdGllcyBkLWJ1cyBwcm9wZXJ0aWVzIHRvIGlu
ZGljYXRlIHRoZSBPT0INCj4gPiBtZXRob2RvbG9naWVzIGl0IGlzIHdpbGxpbmcgdG8gc3VwcG9y
dCAqZm9yIHRoYXQgc2Vzc2lvbiouIElmIHlvdQ0KPiA+ICpzb21ldGltZXMqIHdhbnQgdG8gc3Vw
cG9ydCAic3RhdGljLW9vYiIgb3INCj4gPiAicHVibGljLW9vYiIgKGZvciBpbnN0YW5jZSwgdG8g
ZG8gYSBDZXJ0aWZpY2F0ZSBsb29rdXAgdmlhIGEgV0FOKQ0KPiA+IHRoZW4gZm9yIHRoYXQgc2Vz
c2lvbiwgdGhvc2UgY2FwYWJpbGl0aWVzDQo+ID4gc2hvdWxkIGJlIGluY2x1ZGVkIGluIHRoZSBB
Z2VudCdzIENhcGFiaWxpdGllcyBhcnJheS4uLiAgIGFuZCBpZiB0aGUNCj4gPiBXQU4gaXMgb2Zm
bGluZSwgYW5kIENlcnRpZmljYXRlcyBjYW4ndCBiZQ0KPiA+IHJldHJpZXZlZCwgdGhlbiBsZWF2
ZSB0aGF0IGNhcGFiaWxpdHkgb3V0Lg0KPiA+IA0KPiA+IE90aGVyd2lzZSwgeWVzLi4uICBUaGUg
KmluaXRpYXRvciogZGFlbW9uIHRoZW4gbG9va3MgYXQgdGhlDQo+ID4gY2FwYWJpbGl0aWVzIG9m
IHRoZSByZW1vdGUgdW5wcm92aXNpb25lZCBkZXZpY2UsDQo+ID4gYW5kIHRoZSBjYXBhYmlsaXRp
ZXMgb2YgdGhlIGxvY2FsIGFnZW50LCBhbmQgY2hvb3NlcyB0aGUgaGlnaGVzdA0KPiA+IHNlY3Vy
aXR5IG1ldGhvZCB0aGF0IGNhbiBiZSBzdXBwb3J0ZWQgYmV0d2Vlbg0KPiA+IHRoZSB0d28gZGV2
aWNlcy4gIEJ1dCB0aGUgbGlzdCBvZiBhdmFpbGFibGUgbWV0aG9kcyBpcyBzdGlsbCB1bmRlcg0K
PiA+IHRoZSBjb250cm9sIG9mIHRoZSBBcHAuDQo+ID4gDQo+IA0KPiBUaGUgZGFlbW9uIGluZGVl
ZCBpcyBtaXNzaW5nIHRoZSBkeW5hbWljIGFjcXVpc2l0aW9uIG9mIHRoZQ0KPiBwcm92aXNpb25l
cidzIGFnZW50IGNhcGFiaWxpdGllcy4gSSB0aGluayB0aGVyZSBpcyBubyBuZWVkIGZvciBhIG5l
dyBELQ0KPiBCdXMgbWV0aG9kLCB0aGUgY3VycmVudCBBUEkgaXMgc3VmZmljaWVudC4gV2hhdCBp
cyBuZWVkZWQsIGlzIHRvIGFkZA0KPiBjYWxsIGZvciBHZXRQcm9wZXJ0eSgpIHJlcXVlc3Qgb2Yg
IkNhcGFiaWxpdGllcyIgb24gdGhlIEFnZW50IGludGVyZmFjZQ0KPiAoaW4gYWdlbnQuYykgcHJp
b3IgdG8gc2VuZGluZyBwcm92aXNpb25pbmcgaW52aXRlIChpbiBwcm92LWluaXRpYXRvci5jLCAN
Cj4gYmVmb3JlIG9yIGluIHByb3ZfaW5pdF9vcGVuKCkpDQoNClllcywgYWZ0ZXIgdGFsa2luZyB3
aXRoIEluZ2EsIHRoaXMgaXMgYWJzb2x1dGVseSBjb3JyZWN0OiAgSSB0aGluayB3ZSBoYXZlIGV2
ZXJ5dGhpbmcgaW4gb3VyIGV4aXN0aW5nIEFQSSB0bw0Kc3VwcG9ydCBmdWxsIGNvbnRyb2wgYnkg
dGhlIFByb3Zpc2lvbmVyIEFwcCBhcyB0byB3aGF0IE9PQiBtZXRob2RvbG9neSBnZXRzIHVzZWQu
Li4gIEJ1dCB0aGUgZnVuY3Rpb25hbGl0eSBpbg0KdGhlIHByb3YtaW5pdGF0b3IuYyB0byB1c2Ug
aXQgaXMgY3VycmVudGx5IG1pc3NpbmcuIA0KDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBJbmdh
DQo+IA0KPiANCg==
