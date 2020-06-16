Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3445C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44E32080D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 18:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="MkNR8kgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFPSNr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:13:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:49246 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPSNp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 14:13:45 -0400
IronPort-SDR: QpJsx5avKazK0wbw4/xeK7N6JgUtCdoN1eMGtAkQm8f2HYELBPwVgFPITGxDWQ05V6a8ZaW9gB
 SaTe04+lsT+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 11:13:43 -0700
IronPort-SDR: tkKQnmjUbcqQDIC/bEbssdMNk8xxjsin0xskR9PG62nnGro6W8Pk+/4UGUCA4V3Gr/OnOivy5U
 suIFwo3fepwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="277009045"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 11:13:43 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 11:13:42 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 16 Jun 2020 11:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFxopJtEPyMi/ZPl590CU/ZcH4nRkyRSQ+hZt7PSOekefbHERkEyYly6OJyTxUKzzrOrOANW1lPYPQ1U09XoI8KTA2SyrzQEEs3lddpP8n3bPhkgu90Pw+DFXcOt7OSwg7CvJRpQ0yosirvWw2neWJInbeRpe16yEIgFa/0XOPfBvo44nYSjrlLq+oTIkL7ZO/Dx1DtRA3uZY7I0iWsnkIOZztBGrrF5qwMR+Rq2BE2NN14vbIGEh4sExrV2c1y8R9W1+2jY0u87c6VLVXyzCZmLSYlGNWhZg+fvr3JvrAvpovwmPpkIsiHL79UR7ydRgW4p5O2msoyZ0qNXwvjLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPo8OMBzP0vnUYIuWFsxbKCU+2JjCHmDjv8ODu5zR5w=;
 b=TmeZtssBeDpktXpiLGS9bsY3meK3apHsr1eN+w3QaV2Ju6FRopsxY6yzVMgi9/2InDiMDoyC1m/v/2ABRD02mD4eLjUrHk6R0fvYNxmmCdGipS+ffhabHbXv0r0TiCjPnguDw0Q5RSgdtlATpx9OUy2CpkNi66cOhy+3ea7dp4jy/bORkyRXsiKKE1r72ZmJjyDNfXLiSGD1N8EqgA3cujDoF/vdfeYHC28I/ZZ8RnklNN1p8NG6GbIuR48JpKDjNgIIK4a9R50FqYpshZRzrUz+UjMg4XYlsmPH5lj5iJ+63CHOEcjbDMM+G7nwiWTTy9wnbcdeuD6GFdIOIku7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPo8OMBzP0vnUYIuWFsxbKCU+2JjCHmDjv8ODu5zR5w=;
 b=MkNR8kgsByAcAXQEAaK9YhN0DFImmRzwhHjxPvOHNaBySDZMwXMODoihp4uXH7/C4VY0wXXuewFgfwJsKYcM4XiJFml+iWciVdhk3AfVKvv8QGl6spCRKrpL/gg9oWcrZynLrWATLwZr/9yns3H4gRCYHJisak7JDP9tIix6BnU=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR1101MB2320.namprd11.prod.outlook.com (2603:10b6:301:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 18:13:41 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 18:13:41 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
Subject: Re: [RFC BlueZ 0/2] mesh: Deliver mesh packets over datagram socket
Thread-Topic: [RFC BlueZ 0/2] mesh: Deliver mesh packets over datagram socket
Thread-Index: AQHWQ9mF9KMowX42FUeKOs07w1XR56jbjAeA
Date:   Tue, 16 Jun 2020 18:13:41 +0000
Message-ID: <cf1b99049f6b843affbdc7355038a97331993d14.camel@intel.com>
References: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc65e26b-a1ae-40ac-bd50-08d81221001b
x-ms-traffictypediagnostic: MWHPR1101MB2320:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2320F682256A93AB2EAA8D73E19D0@MWHPR1101MB2320.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZprT4SPBAam223HUsbpzIgMQSqYOtr6VAfp72+D9MWcdQnhYz18gnd+psad8UKpbRyi61Cldapn0IEQjLnZ/75Rb5rM/0NqmqNJqXnEXB2223ggHpV1+T9GB2Imf8zRHDZLPZ24CRR4muXIoEmUM7b59Fc6i/ZbsCv6WF1cfPjzXDm195/z3ZHJ8ZIPfsQyRWuVpxS6gXhai6YKg4a5b8877dR8PhaDTEzQMD4a4w/+rfAC2v3IRm39UZmfc1M8Yxk9VtJJfpNAXqxJWN/Tbnx/Y7oa1wVJDU3kY9Ct47pj5D2230kVYUYgqFDAfWfp/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(186003)(26005)(36756003)(6506007)(5660300002)(2616005)(83380400001)(4326008)(54906003)(91956017)(64756008)(66446008)(66476007)(76116006)(8676002)(66556008)(6486002)(110136005)(8936002)(66574015)(316002)(6512007)(66946007)(86362001)(478600001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ENF6uYGHiix29WdgLEKonkOCaqE0i/MwAieJBhIgRhjcuDIcBZn+aXqsC3ghq1yqO1t3NLTGHRceE3bxPmZjTWQN9eVZ2tZaz41UYBW7sD5MN3A8TGuTBEO4knX0OVzTRryT92Fz0G3XXGMYhxEEp3UiiunGYNXthgyIwgWVdMoXrbfV08Yv+aCSADtxx/3ht6XLTitZrgIGZ2mNIIc+47PYIb1A64qvjM9wuPi7dBR34UsD1IFpjIDCce0m/m6/h2yvl8rnpts93piWDSYwho+gLEIufFkDYxCdF9a37p2MaY0k+YFMUD0WsXncA/sC1AsVXy+a34nxJpwzkeKCCCMdd20nDppIoUsuMY7/Q1RpgDN3wtsMnp4kntxyX0O5d77altOmI8fRpMDy3rgDagsHeBtwp8juel84x/bi5YkbR11TnFQqylFSSFeKUdeXurCs5pUAPKTnPG56XclRS4i8oysQbuIdyx41laKTNQM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81BFCDC7F0E4D84392A2215C744F14A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc65e26b-a1ae-40ac-bd50-08d81221001b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 18:13:41.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DD7h+9fONjHxYOnWfI3SZgFcnfYlPUKROs5n+NgWFxHP0oAhnvPhgzCSmtq4i7KixrmgmwgaB1RiIgzJwRtAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2320
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVHVlLCAyMDIwLTA2LTE2IGF0IDE0OjI3ICswMjAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBwYXRjaHNldCBhZGRzIGFub3RoZXIgRC1C
dXMgQVBJIGZvciBhdHRhY2hpbmcgYXBwbGljYXRpb25zLCBjYWxsZWQNCj4gQXR0YWNoRkQuDQoN
CldlIGhhdmUgdGFsa2VkIGEgbGl0dGxlIGFib3V0IHRoaXMsIGJ1dCBJIGFtIHBlcnNvbmFsbHkg
b3Bwb3NlZCB0bw0Kc3dpdGNoaW5nIHRoZSBkYWVtb24tLT4gQXBwIG1lc3NhZ2UgZGVsaXZlcnkg
c3lzdGVtIHRvIHNvY2tldCBiYXNlZC4NClRoaXMgaGFzIHRoZSBmZWVsaW5nIG9mIHNvbWV0aGlu
ZyB0aGF0IGhhcyBiZWVuIGRldmVsb3BlZCBhcyB0aGUNCnJlc3VsdCBvZiBhIHN0cmVzcyB0ZXN0
IHRvIHNlZSBob3cgbXVjaCBkYXRhIGNhbiBiZSBwdXNoZWQgdGhyb3VnaA0KdGhlIHN5c3RlbSBh
cyBmYXN0IGFzIHBvc3NpYmxlLCB3aGljaCBzaG91bGQgbm90IGJlIGEgY29tbW9uIG1lc2ggdXNl
DQpjYXNlLg0KDQpJIGFsc28gd29ycnkgYWJvdXQgdGhlIGluY3JlYXNlIGluIHN5c3RlbSBzb2Nr
ZXQgcmVzb3JjZXMuLi4NCkN1cnJlbnRseSB0aGUgZGFlbW9uIGNvbnN1bWVzIDEgc29ja2V0IGZv
ciBBcHAgPC0tPiBkYWVtb24NCmNvbW11bmljYXRpb24gKHRoZSBvbmUgdG8gdGhlIGRidXMgZGFl
bW9uKSwgYW5kIGVhY2ggQXBwIGN1cnJlbnRseQ0KYmVpbmcgc3VwcG9ydGVkIHVzZXMgb25lIG1v
cmUgKGFnYWluLCB0byBkYnVzIGRhZW1vbikgQW5kIGFsbA0KTVVYaW5nLCBtYXJzaGFsaW5nIGFu
ZCB1bm1hcnNoYWxpbmcgb2YgbWVzc2FnZXMgaXMgaGFuZGxlZCBieQ0KREJVUy4uLiAgIHRoZSB2
ZXJ5IHJlYXNvbiBmb3IgaXQncyBleGlzdGFuY2UuIFdoaWxlIGNyZWF0aW5nIGENCm5ldyBzb2Nr
ZXQgYmV0d2VlbiBBcHAgYW5kIGRhZW1vbiB3b3VsZCBtYWtlIHRoZSBtZXNzYWdlcyBmbG93DQpm
YXN0ZXIsIGl0IGNvbWVzIGF0IHRoZSBjb3N0IG9mIHJlLWludmVudGluZyBNVVhpbmcsIG1hcnNo
YWxpbmcsDQp1bm1hcnNoYWxpbmcgcGx1cyBhbGwgdGhlIGFkZGl0aW9uYWwgc29ja2V0cy4gQSBs
YXJnZXIgY29kZQ0KZm9vdHByaW50LCBhbmQgYSAqbXVjaCogbGFyZ2VyIHJlc291cmNlIGZvb3Rw
cmludC4NCg0KVGhpcyBqdXN0IGZlZWxzIHRvIG1lIGxpa2UgdGhlIGtpbmQgb2YgY3VzdG9taXph
dGlvbiB0aGF0IGlzIGZpbmUNCmZvciBhIHZlbmRvciB0byBkbyBmb3IgYSBzcGVjaWFsaXplZCBo
aWdoLWZsb3cgbWVzaCwgYnV0IG5vdA0Kc29tZXRoaW5nIHRoYXQgd2Ugd2FudCB0byBpbXBvc2Ug
b24gZXZlcnlvbmUgd2hvIHVzZXMgTWVzaCBpbiB0aGUNCm9wZW4gc291cmNlIGNvbW11bml0eS4N
Cg0KPiBXaGVuIGFwcGxpY2F0aW9uIHVzZXMgdGhhdCBBUEksIGl0IHJlY2VpdmVzIG9uZSBlbmQg
b2YgYSBkYXRhZ3JhbSBzb2NrZXQNCj4gcGFpciwgd2hpY2ggaXQncyBzdXBwb3NlZCB0byByZWN2
KCkgZnJvbSBpbiBvcmRlciB0byByZWNlaXZlIG1lc2gNCj4gcGFja2V0cywgaW5zdGVhZCBvZiB3
YXRpbmcgZm9yICpNZXNzYWdlUmVjZWl2ZWQoKSBjYWxscyBvdmVyIEQtQnVzLg0KPiANCj4gVGhp
cyBzaWduaWZpY2FudGx5IHJlZHVjZXMgc3lzdGVtIGxvYWQgZm9yIGhpZ2ggdHJhZmZpYyBlbnZp
cm9ubWVudA0KPiAoZS5nLiBhbiBhcHBsaWNhdGlvbiB0aGF0IHN1YnNjcmliZXMgdG8gYSBsYXJn
ZSBudW1iZXIgb2YgcHVibGljYXRpb25zDQo+IGluIGEgYmlnIG5ldHdvcmspLg0KPiANCj4gTWVz
c2FnZSBkZWxpdmVyeSBpcyBvbmUgd2F5IG9ubHk6IGFwcGxpY2F0aW9uIGlzIHN0aWxsIHN1cHBv
c2VkIHRvIGNhbGwNCj4gKlNlbmQgbWV0aG9kcyB2aWEgRC1CdXMsIGFsdGhvdWdoIHRoZSBzb2Nr
ZXQgcGFpciBpcyBiaWRpcmVjdGlvbmFsLCBzbw0KPiBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBh
ZGQgc2VuZGluZyBhcyB3ZWxsLg0KPiANCj4gTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgKDEpOg0K
PiAgIG1lc2g6IEltcGxlbWVudCBBdHRhY2hGRCBtZXRob2QNCj4gDQo+IFByemVteXPFgmF3IEZp
ZXJlayAoMSk6DQo+ICAgbWVzaDogQWRkIGRvY3VtZW50YXRpb24gZm9yIEF0dGFjaEZEDQo+IA0K
PiAgZG9jL21lc2gtYXBpLnR4dCB8ICA0MCArKysrKysrKysrKysrKysNCj4gIG1lc2gvbWVzaC5j
ICAgICAgfCAgMTIgKysrKy0NCj4gIG1lc2gvbW9kZWwuYyAgICAgfCAxMjYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIG1lc2gvbm9kZS5jICAgICAg
fCAgODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgbWVzaC9ub2RlLmggICAg
ICB8ICAgNCArLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAyNTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo=
