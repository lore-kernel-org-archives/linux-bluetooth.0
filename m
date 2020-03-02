Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9340BC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D832465E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="A/NMkEGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCBQ4t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:56:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:62421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgCBQ4t (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 11:56:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 08:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="258011151"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2020 08:56:48 -0800
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 08:56:48 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 08:56:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 2 Mar 2020 08:56:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhMN8RB1JdR0uqBqLXz01XX8+5u+fe7zrjGuVzOTlFDWsbck+1B68cyRo6O7IrxLGMmsHoQSaU8Dogcozvznr7uUylA1XmVZWXd6KhU4r4qwAkW2Yazvv4//TJLuO5Yw37DCtI/b1pSmbCWUaWlRMtrNB9Mykou9LPx/QVHeb0yquDc2duVzMuHw2a6irBpfMQPVb6U+OTJUwllH3o2sSzVK0iMobkoFpbH/KSxn+sgY+vujrpYpkhKE8uhteCDMjeP7LQAaunwZTMNawzI1YEyaY9oMNEzMFKjfHY3Ak9sP1/LWeIuky3Gb72sAYjw60H2evTwZnFw4x+ryiVIdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfavpvu4xFUNLD1SC8g6l7YO0pYkHRyv5RWdXpfuf7E=;
 b=Sgz/hwmAj0XHdpHagxDMHg6aKd0UiQjAfQcv21Cp2jlIrH4PsMS6qcUKtFA8HzK9lj1Jo6vifmsGJpKhHTzLO0CiDIkqPmdzDG1DSL3WHlxE+KN/j67VfuEuCk6dan43VaPX4Or20NTDY2rWE0LKtREH1tGNpBySQA2k6VxVPX98J9rDkK8OryOKcqiJLsgUliB/ADYeFl30DzQ6ZPkrdnfiFBi5JBG3KW8cHr84vJpak2WtP3yQO0ywxuLPvbqMYeaCf+m7TsjZFRnNVKDrArPD06v5326CN7bd2ZLT4RxnUvQmOWIwLfOI+WtTt0FfZrkfWO7bKY50eyFoJT9CVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfavpvu4xFUNLD1SC8g6l7YO0pYkHRyv5RWdXpfuf7E=;
 b=A/NMkEGHI+CWuDgSZaTwadBc3EhN/QILzYh87t9VxirgPG8HKFnhJjKPIkvt+Q7qmaX6bj+jJGkIAdzYy24fSYnfZR5nioJ1URcWHzh11opRAaY6JBDDte/nPu9DsFkaTxL9vDm8vrdTkIfdWIOeKNfUP8UVX0O4A4MhZ3UWzsM=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 16:56:32 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:56:32 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "anupam.r@samsung.com" <anupam.r@samsung.com>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Topic: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Index: AQHV8JHINvUFOeOxHkqiBtq6PDPN6ag1WuqAgAAJHwCAACHegA==
Date:   Mon, 2 Mar 2020 16:56:32 +0000
Message-ID: <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
References: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
         <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
         <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p7>
         <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
In-Reply-To: <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d15a1fa8-e716-43f5-a516-08d7becaa911
x-ms-traffictypediagnostic: MW3PR11MB4602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB460246B180352484C9897F85E1E70@MW3PR11MB4602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(6512007)(26005)(8936002)(186003)(86362001)(107886003)(8676002)(54906003)(478600001)(110136005)(2616005)(81156014)(966005)(81166006)(4326008)(6486002)(91956017)(36756003)(76116006)(5660300002)(6506007)(71200400001)(2906002)(66946007)(66476007)(64756008)(66446008)(316002)(66574012)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4602;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfSOx6TZKwXSMFegT0KSFsDBD4k0cE5RbeoBEZDedoDza0QrLapwOfBzcvOHQCa4wMk6tQ3H7BZjjHKxJez2DLUFs+vt0yP0mVIw4u6PYdyh5M11QDgFPKACnFDPvGA1dDllo+e7bu8gU+Cabefor8v7yMedJusrdPX6ujaUFFUXAFtb56Q66UjxMNRGBovbQwVdXQAXABtUj9EZPaKQ5GE11XJK4cD7K7iof9F1JuxELS3GkATy6YjBaxDHUKvMouPDF1sUHurHuEfwAPvZbsFkenMSkdZ+AtQlNg1jcxnf05nRp08UWUv8lsgI+my2tCXhmzromKKvARLToK4DD7Jv5xiZDNWHr0b7n7XkTKJBwVtOk3J0LitxJ3WvSGhZknihR9U/MGC/eh0s0gFtggcQB9GedN8uuxRNE2jkRP5qmSGpxAc2QEJha6tRHzeN7o3TNm1U2g/XlrXB+VqEmJrndlnTbrj24wNzM+zkZvLWXbNNKKIx0/AWeGFHKTqaZdVfMfkA6ZHVmM4DEprEBA==
x-ms-exchange-antispam-messagedata: 04eZL9hDqz8iWN5+SIaC5Q7yl2+WcavamYje1p7BcdxNMXKV2fth7tMJSad+VwvrGCWDSWfWnQxfoKURxnc8UmZQVKLvYG+uyy6k+GrbZfLCs4StSWxGcte0lIr+LMbEHWLrldcBvCj3vF1P/CxudA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <862CE0B77BE1BD49AE64DCBCBC1262F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d15a1fa8-e716-43f5-a516-08d7becaa911
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:56:32.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPdTPcZ+ekqXeXXZw9zgWa3OoKjqOMxvqZDlKWqB47aC+FZ/VjkxCEXQNtaahZME7FlcC2JSr1WjLsNC6RGe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDIwOjI1ICswNTMwLCBBbnVwYW0gUm95IHdyb3RlOg0KPiBI
aSBNaWNoYWwsDQo+ICANCj4gPiAtLS0tLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLS0tLS0N
Cj4gPiBTZW5kZXIgOiBNaWNoYcWCIExvd2FzLVJ6ZWNob25layA8bWljaGFsLmxvd2FzLXJ6ZWNo
b25la0BzaWx2YWlyLmNvbT4NCj4gPiBEYXRlIDogMjAyMC0wMy0wMiAxOTo1MiAoR01UKzU6MzAp
DQo+ID4gVGl0bGUgOiBSZTogUmVnYXJkaW5nIE9PQiBhdXRoZW50aWNhdGlvbiBtZXRob2QgJiBh
Y3Rpb24gZm9yIE1lc2ggcHJvdmlzaW9uZXINCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBPbiAw
My8wMiwgQW51cGFtIFJveSB3cm90ZToNCj4gPiA+IEFsc28sIEkgd291bGQgbGlrZSB0byBrbm93
LCB3aGV0aGVyIHRoZXJlIGlzIGFueSBwbGFuIHRvIFJlcXVlc3QNCj4gPiA+IGV4dGVybmFsIHBy
b3Zpc2lvbmluZyBBZ2VudCB0byBjaG9vc2UgUHJvdmlzaW9uaW5nIG1ldGhvZCAmIHNwZWNpZmlj
DQo+ID4gPiBhY3Rpb24/ICBUaGUgcmVhc29uIGJlaW5nLCBzb21lICphcHBsaWNhdGlvbiogbWF5
IGJlIGludGVyZXN0ZWQgaW4gYQ0KPiA+ID4gcGFydGljdWxhciBTZWN1cml0eSBsZXZlbCAmIEF1
dGhlbnRpY2F0aW9uIGFjdGlvbiwgZGVwZW5kaW5nIG9uIGl0cw0KPiA+ID4gb3duIEkvTyBjYXBh
YmlsaXRpZXMuDQo+ID4gDQo+ID4gRm9yIHRoZSByZWNvcmQsIHdlIGFsc28gbmVlZCB0aGlzIGlz
IGZ1bmN0aW9uYWxpdHkuIE9uZSBvZiB0aGUgcG9zc2libGUNCj4gPiBzY2VuYXJpb3MgaXMgaGF2
aW5nIGEgcHJvdmlzaW9uZXIgd2hvIGRvZXNuJ3QgaGF2ZSBhIHJlbGlhYmxlIEludGVybmV0DQo+
ID4gY29ubmVjdGlvbiBhbmQgbWlnaHQgd2FudCB0byBmYWxsIGJhY2sgdG8gKGxlc3Mgc2VjdXJl
KSBPT0IgYWN0aW9ucyBpZg0KPiA+IGl0IGNhbm5vdCBvYnRhaW4gT09CIHB1YmxpYyBrZXkuDQo+
ID4gDQo+ID4gV2UndmUgYmVlbiBwbGFubmluZyB0byBzZW5kIGEgcGF0Y2ggaW1wbGVtZW50aW5n
IGEgRC1CdXMgQVBJIGZvciB0aGF0LA0KPiA+IGJ1dCBpdCdzIG5vdCByZWFkeSB5ZXQgOigNCj4g
DQo+IE9rYXksIHRoYXQgd291bGQgYmUgbmljZSAmIGFuZCB3aWxsIGl0IGFsbG93IGFwcGxpY2F0
aW9uIHRvIGNob29zZSBib3RoIGEpICJPT0IgUHViIEtleShXaXRoL1dpdGhvdXQpIiBhcw0KPiB3
ZWxsIGFzICBiKSJPT0IgQXV0aCBNZXRob2RzKElOL09VVC9TdGF0aWMvTm8gT09CKSAmIEFjdGlv
bnMoQmxpbmsvQmVlcC9WaWJyYXRlL051bS9hbHBoYSBldGMuKSI/DQoNClRoZSBvcmlnaW5hbCBw
bGFuIGZvciB0aGlzIHdhcyB0aGF0IGFuIEFnZW50IGRlZmluZXMgaXQncyBDYXBhYmlsaXRpZXMg
ZC1idXMgcHJvcGVydGllcyB0byBpbmRpY2F0ZSB0aGUgT09CDQptZXRob2RvbG9naWVzIGl0IGlz
IHdpbGxpbmcgdG8gc3VwcG9ydCAqZm9yIHRoYXQgc2Vzc2lvbiouIElmIHlvdSAqc29tZXRpbWVz
KiB3YW50IHRvIHN1cHBvcnQgInN0YXRpYy1vb2IiIG9yDQoicHVibGljLW9vYiIgKGZvciBpbnN0
YW5jZSwgdG8gZG8gYSBDZXJ0aWZpY2F0ZSBsb29rdXAgdmlhIGEgV0FOKSB0aGVuIGZvciB0aGF0
IHNlc3Npb24sIHRob3NlIGNhcGFiaWxpdGllcw0Kc2hvdWxkIGJlIGluY2x1ZGVkIGluIHRoZSBB
Z2VudCdzIENhcGFiaWxpdGllcyBhcnJheS4uLiAgIGFuZCBpZiB0aGUgV0FOIGlzIG9mZmxpbmUs
IGFuZCBDZXJ0aWZpY2F0ZXMgY2FuJ3QgYmUNCnJldHJpZXZlZCwgdGhlbiBsZWF2ZSB0aGF0IGNh
cGFiaWxpdHkgb3V0Lg0KDQpPdGhlcndpc2UsIHllcy4uLiAgVGhlICppbml0aWF0b3IqIGRhZW1v
biB0aGVuIGxvb2tzIGF0IHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIHJlbW90ZSB1bnByb3Zpc2lv
bmVkIGRldmljZSwNCmFuZCB0aGUgY2FwYWJpbGl0aWVzIG9mIHRoZSBsb2NhbCBhZ2VudCwgYW5k
IGNob29zZXMgdGhlIGhpZ2hlc3Qgc2VjdXJpdHkgbWV0aG9kIHRoYXQgY2FuIGJlIHN1cHBvcnRl
ZCBiZXR3ZWVuDQp0aGUgdHdvIGRldmljZXMuICBCdXQgdGhlIGxpc3Qgb2YgYXZhaWxhYmxlIG1l
dGhvZHMgaXMgc3RpbGwgdW5kZXIgdGhlIGNvbnRyb2wgb2YgdGhlIEFwcC4NCg0KPiANCj4gPiBy
ZWdhcmRzDQo+ID4gLS0gDQo+ID4gTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgPG1pY2hhbC5sb3dh
cy1yemVjaG9uZWtAc2lsdmFpci5jb20+DQo+ID4gU2lsdmFpciANCj4gPiBodHRwczovL3Byb3Rl
Y3QyLmZpcmVleWUuY29tL3VybD9rPWJjZDQ5NmJmLWUxNDIyZmM4LWJjZDUxZGYwLTBjYzQ3YTMx
MmFiMC1mNWQ5ODZjY2EyMGU4MDRmJnU9aHR0cDovL3NpbHZhaXIuY29tLw0KPiA+IEphc25vZ8Oz
cnNrYSA0NCwgMzEtMzU4IEtyYWtvdywgUE9MQU5EDQo=
