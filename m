Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5389CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2284C204EC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="I2OmvE0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFJRnD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:43:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:18027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJRnD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:43:03 -0400
IronPort-SDR: minfNmk5sIi+EEjQjOmUt72oINKbvQvqxwr/UsAIgJvKfwDuoI8myDnwjbqkx/NXs2L4MPD6Xz
 ew90V7wPW0ZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:43:02 -0700
IronPort-SDR: NglVX5iCe5200V+Sfn6LN94QnjesjYNZ3M7C0ckSvb7HFFEbKxy6uPxVUMuo8WzH1qJnfjmDlu
 qSForCV/LQgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="473504974"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2020 10:43:02 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jun 2020 10:43:01 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jun 2020 10:43:01 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Jun 2020 10:43:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 10 Jun 2020 10:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BecK6dTZ2Hta4nVLPy65c53uAfFVahfY137TBj87D0e8oyoM7AsvODTGzzobcN4F+/FoIkAvjUSS12fnwZAPVr/k44NC8sYrYx4Ib0aMGzgMYniTip73bACdBauwQYcgJAjDGYOUbtJcmtUE6QGOtIRvWZmHzS/OgbeWqU3GTZqjMH25UkRaS0n9lhClJ4dxdAMZ1ZxYdyizzrRh0ogL2J0rLQZ/mkoX9WG3y4uHlR4V97WuqFBYg3pdNCzCUyQep1sf/ztuqlEcLMLqAeYBZkBkg9O5fpbuZ4iE0mlmo3gEMkhFd3I9nfE6x3yt8rArv7N+JI3uDOWaIAiXKHSX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDdkX63Zw2Sx2p46yu/FrIGv6zCG//iLWFwZmM5Jhhw=;
 b=DGGT5cw0PkHvged6g9DEGFQZhXS8IY5GxTJiRMc+ue2tSY5HiJupalkpPvsTbIl8a3KJZPq1rn9+L7zjNU8QFYxwE86+O6qjw9N8QyH3LNdmTZYHRv8VT2+aZjS1Z32jmAxyl5nIN6/DI0ww+drvkN339u8MufGc9AOsjFQ4HWgyfrHjTQWXMiwRKcTFzAmjFOtcmpJyNjwRlwJdaXDonIVTuT5oLJTjyA3wpMi+csBbFGmzQ37z9WNRUEaRV+MywQwxR8lH9xq2ExsObKl/arN9OEEA5ryL8Cu78kY9Fpz8xgjb+um3NJOgZe+SVN9TlqvES8qRuBJ8O4Z9Shzf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDdkX63Zw2Sx2p46yu/FrIGv6zCG//iLWFwZmM5Jhhw=;
 b=I2OmvE0ID+pHXYb0jPfVm9YfZ5IBRuCKxNLZG0AKbGl09ajbEOH0ZgcQZoZIbb0Zx4uOO6Ymc/o/NMf5Z63R7hQvOwiUOcmamWwSE2k+NwoPOYUqaUJ6k/vhBVgiPQcsktb5OS7Yf9ua1erivhei6pk1X/kKb/85gCljuKKYEFo=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 17:42:59 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 17:42:59 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/5] Put safeguards around Leave & Attach calls
Thread-Topic: [PATCH BlueZ v3 0/5] Put safeguards around Leave & Attach calls
Thread-Index: AQHWP0owVbiE10WL+UyI20X93ICTTqjSHpMA
Date:   Wed, 10 Jun 2020 17:42:59 +0000
Message-ID: <6a035fb91fce25b25401bcaf1bb454fa729ef130.camel@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
In-Reply-To: <20200610171121.46910-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e82bdee1-07f1-4733-b172-08d80d65b796
x-ms-traffictypediagnostic: MW3PR11MB4570:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4570E3FBFCCCA134E6A78D96E1830@MW3PR11MB4570.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLvlQIK4QwXhZLMwgUKUCODakJ8YgfnhP+enqbr0iKuOr6BGjwtlfgLAXGstFmA5n/mVGDbTH2TY0Fr6QusT8iTPunb9/iOMMSyegg/QLKz7nMOwKYVR9WH9VUOgFh4Q/ufPGHxT1NJ1EiR76iUqECjcZ1GCnSYXQQi1EFcf/V4o/Gf+aitYcp3hV+oJ5xV3R77Tto6x5SwtkFpLGaKPYKsHjK/9o+0LBnpNfK6lqQ5sqI0S30lGYDvE0ywZU9WJwC4Y1ig5wTvYkaNKB6faVtA2VecRbhWoDVNcFV/PJF0/CuE/iXjFMx6v/7zW4QsY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(6506007)(26005)(86362001)(186003)(2616005)(2906002)(8936002)(36756003)(6512007)(83380400001)(316002)(8676002)(5660300002)(6636002)(71200400001)(91956017)(66946007)(66446008)(64756008)(66556008)(76116006)(110136005)(66476007)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 90siNaex298iZcXqhN10vpJnuHy3l3aEXnD/3cf5dl0YSe66uFQ6cjuTmIQS7HdpLYPxR6dxrThwlbr9qh4rC3UaaECFLbZ2Bbww6Z4QC4vCvgRgEMK27meq0zMgzl6n276Ol2/Dl2r1gts9d4ufVg/NtDM5acf7IblTRvyJG9NDh4b/610wytqF6AwRFOa8ZiHuc0u4ugSO7tCivre0BuT5Z3gVXTw1dG9zLATD4vIkiWM6efqBG7DXc9ihVWc5lu/XGRcYzKjrk2h6+R11ll03++CYv7Ry/VgmF9R8UQcldeEaiTkimbGXsklrN2HT0Oy4wqsU0x7APOMEryOm2tbJcRjTEFxL51w1zjvSXRCsN/9OpY/JiKNBeS67VoUpc0Q+XMzEls4SZ0ZOJCXbMNl/QD8idGXSf/X0AVMldLkxsUk61GjHnDM532tCSnPI6WsrJP/4nbyL06gWVLiSRpQg/1wikvc3B+X2pCdh+sk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D3E0DB4D10D78429B658AB0DE9DE6FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e82bdee1-07f1-4733-b172-08d80d65b796
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 17:42:59.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPUWw8mWZ72OYHlTzKuCDVVLRJSFrmjR4N62Aqc4FO6wptELtAAngiDhV8y+lftnP+BwFKH9OpO36Q5OVhJpBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBXZWQsIDIwMjAtMDYtMTAgYXQgMTA6MTEgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgc2V0IG9mIHBhdGNoZXMgYWRkcmVzc2VzIHRoZSBz
aXR1YXRpb24gd2hlbiBhbiBhcHBsaWNhdGlvbg0KPiBjYWxscyBMZWF2ZSgpIG9yIEF0dGFjaCgp
IG1ldGhvZHMgb24gYSBub2RlIHRoYXQgaGFzIGFub3RoZXIgaW5jb21wbGV0ZQ0KPiBtZXRob2Qg
Y2FsbCBvbiBOZXR3b3JrIGludGVyZmFjZSBhc3NvY2lhdGVkIHdpdGggaXQuDQo+IA0KPiBUaGUg
c2ltcGxlIHNvbHV0aW9uIGlzIHRvIHJldHVybiBlcnJvciBpbiByZXNwb25zZSB0byBMZWF2ZSgp
IG1ldGhvZA0KPiBpZiBhbiBhcHBsaWNhdGlvbiBzdGlsbCBvd2VzIHRoZSBkYWVtb24gZWl0aGVy
IGEgcmVwbHkgdG8gR2V0TWFuYWdlZE9iamVjdHMNCj4gcmVxdWVzdCBpbiBjYXNlIG9mIEF0dGFj
aCgpIG9yIGEgcmVwbHkgdG8gSm9pbkNvbXBsZXRlKCkgaW4gY2FzZSBvZg0KPiBKb2luKCksIENy
ZWF0ZSgpIG9yIEltcG9ydCgpDQo+IA0KPiBTaW1pbGFybHksIGEgIkJ1c3kiIGVycm9yIGlzIHJl
dHVybmVkIGluIHJlc3BvbnNlIHRvIEF0dGFjaCgpIG1ldGhvZA0KPiBpZiBhbiBhcHBsaWNhdGlv
biBzdGlsbCBvd2VzIHRoZSBkYWVtb24gYSByZXBseSB0byBKb2luQ29tcGxldGUoKQ0KPiBpbiBj
YXNlIG9mIHBlbmRpbmcgSm9pbigpLCBDcmVhdGUoKSBvciBJbXBvcnQoKQ0KPiANCj4gSW5nYSBT
dG90bGFuZCAoNSk6DQo+ICAgbWVzaDogRGVsZXRlIHVudXNlZCBmdW5jdGlvbg0KPiAgIG1lc2g6
IE1ha2UgIkJ1c3kiIGFuZCAiSW5Qcm9ncmVzcyIgdG8gYmUgZGlzdGluY3QgZXJyb3JzDQo+ICAg
bWVzaDogQWRkIGRlc3Ryb3kgY2FsbGJhY2sgdG8gZGJ1c19zZW5kX3dpdGhfdGltZW91dCgpDQo+
ICAgbWVzaDogQWRkIHRpbWVvdXQgdG8gR2V0TWFuYWdlZE9iamVjdHMgY2FsbA0KPiAgIG1lc2g6
IEFkZCAibm9kZSBpcyBidXN5IiBjaGVjayBmb3IgTGVhdmUoKSAmIEF0dGFjaCgpDQo+IA0KPiAg
ZG9jL21lc2gtYXBpLnR4dCB8ICA1ICsrKy0NCj4gIG1lc2gvZGJ1cy5jICAgICAgfCAxMCArKysr
KysrLQ0KPiAgbWVzaC9kYnVzLmggICAgICB8ICAxICsNCj4gIG1lc2gvZXJyb3IuaCAgICAgfCAg
MSArDQo+ICBtZXNoL21hbmFnZXIuYyAgIHwgMTEgKysrKy0tLS0tDQo+ICBtZXNoL21lc2guYyAg
ICAgIHwgMjIgKysrKysrKysrKystLS0tLS0NCj4gIG1lc2gvbm9kZS5jICAgICAgfCA2MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIG1lc2gvbm9k
ZS5oICAgICAgfCAgMiArLQ0KPiAgdGVzdC90ZXN0LW1lc2ggICB8ICAyIC0tDQo+ICA5IGZpbGVz
IGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiANCg==
