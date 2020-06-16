Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DAEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C8206F1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lg8lX80j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgFPRks (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:40:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:52716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgFPRkr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:40:47 -0400
IronPort-SDR: Hwwzq3o2aChsV3kaak5iFx1MOGFrJ529dm5qm/MtzGBU+wM9YpNVkLMUseQgMoOim+g/+SKdWO
 LbZ7AJu5LrCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 10:40:46 -0700
IronPort-SDR: 7s1jZRpwG/Eo0QpoWjCwS2a5qy8aVxQ7pD8DkKsaxhMkEazlI2mKExG62gRlqxLctx7CEwT30a
 pO1KjJO9Uf4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="261489362"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 10:40:45 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:40:45 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:40:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+UyfxXQOO2UBtL8hV/EPApUEpLPNc7wUWy7z0AC3CagbHiIZkcDAF+bBxzqVoYnS6j/CD7NxD5O9sqzAsDC1T6HuELds0GMzkvH1L0uWqFxqmzmS2RoT51aOKltMakJHeszIAZVD2m85v+3t3bkMHJqeRfWpG9x4fZ/F9bfBmUDAXSE5Q/PYbFqYxcx/BfKP+tNkuutIUC7D2lT+BEE90LHL1iojlbIvLKkLqH1Fu6x81SMj7/xkjzls8fD0CrJGuZgx7rD2MQDlupi/XsB9a41u4JphlOqq7b/BNZAVAKqxLgHAHktg/AdZzykcZDdt7ZJz/Xb/kWEn8p1zTzY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rGul2/7MPdtjRclKmYy7ebIlcihW1tlgRhNPgyTekY=;
 b=oIG/tBlJZXnW2y5cyTWPjWnZ+crA8lelj8wpDrt5wXiLDrFugc+pcYhSMO8psBwZ7Flvg9cTpwwqJTvPnYc+2lIGOlDRelCMSYgotbzANOSrzJfDgbWBQHRmq2JVq1bvy2FC8bt6lNx61RSaDoRWomYUO7QUp5zvWgNs5+KsYPAsXZvMAISL40zteC3eIA9ABJSEBJxduq+JaU/+wT8f0eSio6UaT4CHdhrg20QokGxSieRGitj1bNiVJ9IoNgpqN7oSPphrqzFaBaykWOeY0CO7bJnOuuGsQguv7c6N9EflCzL4PZkso4qYu8McCR+PIPS1aPOARX17SguEVSU70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rGul2/7MPdtjRclKmYy7ebIlcihW1tlgRhNPgyTekY=;
 b=lg8lX80jAaX6zIrPCJ+IGujnov5QGCls3zG9XnvzTW8q2R7AulZTZiFMVyrVQli6zpgaUdQnhcifECP2uQS6w01vbS8uwXrMnSQ3GJVr4y+UFM22bKWgl6WYOJHMLGrytQgRL+xXhR+LDVrgrF+JSGJwKTBb+xN7KhkqdfrKW90=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1261.namprd11.prod.outlook.com (2603:10b6:300:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 16 Jun
 2020 17:40:43 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 17:40:43 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Rename IVUpdate import flag to IvUpdate
Thread-Topic: [PATCH BlueZ] mesh: Rename IVUpdate import flag to IvUpdate
Thread-Index: AQHWQxI4C+YH/Cxrq0CKVjuVQ1D2xajbhF4A
Date:   Tue, 16 Jun 2020 17:40:43 +0000
Message-ID: <f3f2366227f55265bde6dcd105a093db13dc2920.camel@intel.com>
References: <20200615124108.11517-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200615124108.11517-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 822a2aba-a268-42f3-6c14-08d8121c64f6
x-ms-traffictypediagnostic: MWHPR11MB1261:
x-microsoft-antispam-prvs: <MWHPR11MB12610401C706F7D4DF87CF4FE19D0@MWHPR11MB1261.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qchJYPsOI44auHtQa9ybnrPYcyHyrVTkHus/wvr6ypZaIiy6i2Pw7xutMpAIqh5DrYr5UXUQ6SzsAcADyJARPKL/GaT59oXxlhGTh2loJr4YNyCBFko4hgwy8KMuFY+dB4HgAi1bQohZzQSjEdwFBdLnLZPIN11Pnzm+GUTfo2w0fLQhhpJlg7DNW2M8GEwRMoiUcq3uTJkcJBl/W5eI/5+9lJTO+ZDuoYYCwdEq4w4zrE5hcGf84EFzgO4AKvFKFJcagRCnbIxW/JvAjhjlE8do1pVQe2ApgwTUpWyYOkebc7DZwpqTWPQjajEemF2mBhWXNuhJ9LeFSpJQ4RFfww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(2616005)(86362001)(8676002)(110136005)(316002)(8936002)(66476007)(64756008)(66446008)(83380400001)(71200400001)(66556008)(186003)(76116006)(66946007)(91956017)(36756003)(26005)(6512007)(2906002)(478600001)(5660300002)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZX9N3NYiVr7JQuhE5JaPFDzqvCR/b6JET0H4c2UbZHWK9bfXuj9YlYGbd/t/aKuxqSJT/JS2Fi1pf4DciSDHPaLrHr567axbRs2rc6f1FmXlGxGgHUp7nwkd2/x9tkcdeVybiFpjq/M3FwmiKO12lNGRzc+b4bhCUcDWnQjqAFrj0NZIH2Xla+qJsMPeOUY+hgIswJFF1d1rpTXXjV0jrwFfi9tLuQmgNSRnqphDbNVRF84ZnxEMB4uyQFwrBPCJwK8ne8GhCMzy+FR926ERlVocCnI7XTtnfk6Z704Hes4UHJAt498usujbhv1mmen+6dI3ovBtKRbIVR7OrweJ8ZKdtxp7/bqeD9CmmUurvm7XR0X4GCyRWwcZh0YOOxJxAG+FIDGrxJBHCjGanDmviwRtsqZOCirDXzWfB63StBxg3+f/lWmxLseGe/bkmk/pPsS3KctQHU0PMqqqC+9RQgLEBA2whmNW5to8wD32qEg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD8545932C75F4ABD954191850CF77C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 822a2aba-a268-42f3-6c14-08d8121c64f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 17:40:43.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59lwcacVhhwyGMRLly+drxBNHw9Zz9Ts3ngvYYQp3CxEZfPEbKnrnlB2XoAdKYxGoZsqyBdlgqSnpD1ON4JN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1261
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMjAtMDYtMTUgYXQgMTQ6NDEgKzAyMDAsIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBOYW1lIGNoYW5nZSBmb3IgY29uc2lzdGVuY3kgd2l0aCAi
SXZJbmRleCIgcHJvcGVydHkuDQo+IC0tLQ0KPiAgZG9jL21lc2gtYXBpLnR4dCB8IDIgKy0NCj4g
IG1lc2gvbWVzaC5jICAgICAgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2MvbWVzaC1hcGkudHh0
IGIvZG9jL21lc2gtYXBpLnR4dA0KPiBpbmRleCA2ZDkwNWNmNDguLjdmYmFiMzJiNiAxMDA2NDQN
Cj4gLS0tIGEvZG9jL21lc2gtYXBpLnR4dA0KPiArKysgYi9kb2MvbWVzaC1hcGkudHh0DQo+IEBA
IC0xOTAsNyArMTkwLDcgQEAgTWV0aG9kczoNCj4gIAkJVGhlIGZsYWdzIHBhcmFtZXRlciBpcyBh
IGRpY3Rpb25hcnkgY29udGFpbmluZyBwcm92aXNpb25pbmcNCj4gIAkJZmxhZ3MuIFN1cHBvcnRl
ZCB2YWx1ZXMgYXJlOg0KPiAgDQo+IC0JCQlib29sZWFuIElWVXBkYXRlDQo+ICsJCQlib29sZWFu
IEl2VXBkYXRlDQo+ICANCj4gIAkJCQlXaGVuIHRydWUsIGluZGljYXRlcyB0aGF0IHRoZSBuZXR3
b3JrIGlzIGluIHRoZQ0KPiAgCQkJCW1pZGRsZSBvZiBJViBJbmRleCBVcGRhdGUgcHJvY2VkdXJl
Lg0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLmMgYi9tZXNoL21lc2guYw0KPiBpbmRleCA0YWJh
ZTRkOTIuLmE2MmNiNTM5MCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNoLmMNCj4gKysrIGIvbWVz
aC9tZXNoLmMNCj4gQEAgLTgwOCw3ICs4MDgsNyBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNz
YWdlICppbXBvcnRfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCQkJCQkJCSJCYWQgbmV0
IGluZGV4Iik7DQo+ICANCj4gIAl3aGlsZSAobF9kYnVzX21lc3NhZ2VfaXRlcl9uZXh0X2VudHJ5
KCZpdGVyX2ZsYWdzLCAma2V5LCAmdmFyKSkgew0KPiAtCQlpZiAoIXN0cmNtcChrZXksICJJVlVw
ZGF0ZSIpICYmDQo+ICsJCWlmICghc3RyY21wKGtleSwgIkl2VXBkYXRlIikgJiYNCj4gIAkJCWxf
ZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X3ZhcmlhbnQoJnZhciwgImIiLCAmaXZ1KSkNCj4gIAkJCWNv
bnRpbnVlOw0KPiAgDQo=
