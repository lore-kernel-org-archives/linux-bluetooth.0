Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6830C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB98206C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 19:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="h/zpRv6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfLKTTu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:19:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:3074 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLKTTt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 14:19:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 11:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="414965097"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 11 Dec 2019 11:19:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Dec 2019 11:19:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 11:19:48 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 11:19:48 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 11 Dec 2019 11:19:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWWQ9wLxVYO/Yp35Sjc08ljyYrE71O7C/yQtLuNbFUFq+jONn4QvguoLPumrltBcKqWBT18kPWFoula5xweWCbHXBdNMbK2yW7bXpLi+7ZkO8FdnZ9AuxNhMCPurclnaD+PDZqOIWdKUKVWwEJHytB/t2+hMfCb/9lbt2Rn8VJoDwKbGU2kNL5wOovnwZR5C+A1bhnzz6OJ8qBkA4MVcAP4MSatPzR2mR9mjxpG+lG4TUPWZyXCKRbLVf2MrC9LQhkxoul6UJ7XWLv8zdnJqlhWmkRhC/ht7cnAG0nRStl1yDk2Mga2RiEHvmrjd/P100ciFK3IKnZtgO/JYu/ArpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heBXxink4kFKc/xsUCqVVnhGLq4DJrVJiZtIUhKHUJo=;
 b=e56pVJnb2Of6t1UWOIrgVbbXUos/Ac9Fs67MSjQCFtnWvtUXMoOUoJEW/rSH5pjSodYb0s4pFU9RqSTj+qUPUCWpXbe8yJhov3qfhWc4EW1c6M7PlWHAFvcd9LktgtyJDCBbxJlm9PXZ8arn74byqR8f36EarRRtuc5ioM6FOaAaXDmsOVtNdjQ2oCG6incePaXhzB7dXGgQqKl6LXyMsJOjE8Tm7NbeRZlp7M1SLxwsaG0FdxvkVKKBT9mDYot9ybySKN7viqwJ7MBuLRRR6JsqMqxt8mOkXKGAEQwOQAu2azUPb3ZR4hYV+praM/fxCtuPzaDBh4LnvJTeuDR6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heBXxink4kFKc/xsUCqVVnhGLq4DJrVJiZtIUhKHUJo=;
 b=h/zpRv6hEhPbP+1ebTFplTebfOGinuUmstPdsF5QV/utaWq9aLxMcAEIh7kj6uZJXXB1y4FiuRT/l23p53EW55zXByaRjsw3Z1AKuOu3ntiuVNWuns3sl/juNyNGwifmeZOE+dAq/D86y+3RG4q4oF6Sh9vuWpMDPJWRr61An3Q=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1686.namprd11.prod.outlook.com (10.173.17.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 19:19:42 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 19:19:42 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Thread-Topic: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Thread-Index: AQHVr655Ej+mnsOuJ06B2Di94+XS9ae1UIKA
Date:   Wed, 11 Dec 2019 19:19:42 +0000
Message-ID: <85224a83d7e93ec11da47e1a2852f35a3a170115.camel@intel.com>
References: <20191210230600.23035-1-inga.stotland@intel.com>
In-Reply-To: <20191210230600.23035-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce531ed2-0ec3-47b1-822b-08d77e6f1311
x-ms-traffictypediagnostic: CY4PR11MB1686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB168695546FD198EE307F899DE15A0@CY4PR11MB1686.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(81156014)(2616005)(6486002)(498600001)(2906002)(86362001)(66476007)(8936002)(6636002)(26005)(6506007)(6512007)(4001150100001)(71200400001)(8676002)(81166006)(186003)(64756008)(91956017)(110136005)(66946007)(66556008)(36756003)(76116006)(5660300002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1686;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlmUfzipVNN/Ub2khHSHhIcdt4aT28Hy0gHrOSqKaG4jbGHdySmiRo23GeyhWufDEcKmFonMcCM+QcJGvkAwIhdp2JFTvjiZmTs65xFUWA8bJc2prLfB+7njJI0XgvZctDvhp89CAFssW0dLhGFi6QjS63BBdTjT6bejCDgi1WNoOL7tXga5E1+kH+ilqYw/GbhpOMrdjTcYZVuI4rJxUNS7vMU0E4dHJOoPwjX5XB7emA6HB+cuZQl539kmCqCREdvTeY9VLO8RhJyMdgr1iRLhJgZd2+9+Q6j8i2iit75pULkDisI8UkNMQa9U/6SWXJUtUlRMiXAvrzzCqa3BMc3PNx5r+m+9B3whoDyoZmwkWNDnmw1F06fqI+MqUSifVk5Gm7kNhiPbXg/tqE67Ekgf9XaV+p8qA5vqmTmujvXNxOoJ5axvz/ZmeQeEMl8o
Content-Type: text/plain; charset="utf-8"
Content-ID: <32782AA60234324E86EA7D6F6D698A4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce531ed2-0ec3-47b1-822b-08d77e6f1311
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 19:19:42.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vm3QGKuZbFmhNFqoAsz4SFn44EN18k7kiSRD7FgDCQ9zNDE8tzjsYDDUqG/UcFwCbFowlI/R2SnvQMEpVytvdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1686
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwNCg0KT24gVHVlLCAyMDE5LTEyLTEwIGF0IDE1OjA2IC0wODAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBUaGlzIHJlbW92ZXMgdW5uZWNlc3NhcnkgaG91c2VrZWVwaW5nIGZvciBo
Y2kgY29udHJvbGxlcnMNCj4gLS0tDQo+ICBtZXNoL21lc2gtbWdtdC5jIHwgMjIgKystLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMjAgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLW1nbXQuYyBiL21lc2gvbWVz
aC1tZ210LmMNCj4gaW5kZXggMjcyNzJkNGQyLi4yY2YyZWJhYzIgMTAwNjQ0DQo+IC0tLSBhL21l
c2gvbWVzaC1tZ210LmMNCj4gKysrIGIvbWVzaC9tZXNoLW1nbXQuYw0KPiBAQCAtNDIsMTQgKzQy
LDggQEAgc3RydWN0IHJlYWRfaW5mb19yZXEgew0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIHN0cnVj
dCBtZ210ICptZ210X21lc2g7DQo+IC1zdGF0aWMgc3RydWN0IGxfcXVldWUgKmNvbnRyb2xsZXJz
Ow0KPiAgc3RhdGljIHN0cnVjdCBsX3F1ZXVlICpyZWFkX2luZm9fcmVnczsNCj4gIA0KPiAtc3Rh
dGljIGJvb2wgc2ltcGxlX21hdGNoKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpDQo+IC17
DQo+IC0JcmV0dXJuIGEgPT0gYjsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIHZvaWQgcHJvY2Vzc19y
ZWFkX2luZm9fcmVxKHZvaWQgKmRhdGEsIHZvaWQgKnVzZXJfZGF0YSkNCj4gIHsNCj4gIAlzdHJ1
Y3QgcmVhZF9pbmZvX3JlZyAqcmVnID0gZGF0YTsNCj4gQEAgLTEwMSwyMyArOTUsMTQgQEAgc3Rh
dGljIHZvaWQgcmVhZF9pbmZvX2NiKHVpbnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBsZW5ndGgsDQo+
ICBzdGF0aWMgdm9pZCBpbmRleF9hZGRlZCh1aW50MTZfdCBpbmRleCwgdWludDE2X3QgbGVuZ3Ro
LCBjb25zdCB2b2lkICpwYXJhbSwNCj4gIAkJCQkJCQl2b2lkICp1c2VyX2RhdGEpDQo+ICB7DQo+
IC0JaWYgKGxfcXVldWVfZmluZChjb250cm9sbGVycywgc2ltcGxlX21hdGNoLCBMX1VJTlRfVE9f
UFRSKGluZGV4KSkpDQo+IC0JCXJldHVybjsNCj4gLQ0KPiAtCWxfcXVldWVfcHVzaF90YWlsKGNv
bnRyb2xsZXJzLCBMX1VJTlRfVE9fUFRSKGluZGV4KSk7DQoNCkkgdGhpbmsgYmVmb3JlIGFwcGx5
aW5nIHRoaXMsIHdlIHNob3VsZCByZS13b3JrIHRoZSBjb250cm9sbGVyIGluZGV4IHRvIGJlIGNv
bnNpc3RlbnRseSB1aW50MTZfdCwgcmF0aGVyIHRoYW4NCnRoZSBhd2t3YXJkIG1peCBvZiBpbnQg
YW5kIHVpbnQxNl90Lg0KDQo+IC0NCj4gLQlpZiAobWdtdF9zZW5kKG1nbXRfbWVzaCwgTUdNVF9P
UF9SRUFEX0lORk8sIGluZGV4LCAwLCBOVUxMLA0KPiAtCQkJcmVhZF9pbmZvX2NiLCBMX1VJTlRf
VE9fUFRSKGluZGV4KSwgTlVMTCkgIT0gMCkNCj4gLQkJcmV0dXJuOw0KPiAtDQo+IC0JbF9xdWV1
ZV9yZW1vdmUoY29udHJvbGxlcnMsIExfVUlOVF9UT19QVFIoaW5kZXgpKTsNCj4gKwltZ210X3Nl
bmQobWdtdF9tZXNoLCBNR01UX09QX1JFQURfSU5GTywgaW5kZXgsIDAsIE5VTEwsDQo+ICsJCQkJ
cmVhZF9pbmZvX2NiLCBMX1VJTlRfVE9fUFRSKGluZGV4KSwgTlVMTCk7DQo+ICB9DQo+ICANCj4g
IHN0YXRpYyB2b2lkIGluZGV4X3JlbW92ZWQodWludDE2X3QgaW5kZXgsIHVpbnQxNl90IGxlbmd0
aCwgY29uc3Qgdm9pZCAqcGFyYW0sDQo+ICAJCQkJCQkJdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0K
PiAgCWxfd2FybigiSGNpIGRldiAlNC40eCByZW1vdmVkIiwgaW5kZXgpOw0KPiAtCWxfcXVldWVf
cmVtb3ZlKGNvbnRyb2xsZXJzLCBMX1VJTlRfVE9fUFRSKGluZGV4KSk7DQo+ICB9DQo+ICANCj4g
IHN0YXRpYyB2b2lkIHJlYWRfaW5kZXhfbGlzdF9jYih1aW50OF90IHN0YXR1cywgdWludDE2X3Qg
bGVuZ3RoLA0KPiBAQCAtMTU3LDkgKzE0Miw2IEBAIHN0YXRpYyB2b2lkIHJlYWRfaW5kZXhfbGlz
dF9jYih1aW50OF90IHN0YXR1cywgdWludDE2X3QgbGVuZ3RoLA0KPiAgDQo+ICBzdGF0aWMgYm9v
bCBtZXNoX21nbXRfaW5pdCh2b2lkKQ0KPiAgew0KPiAtCWlmICghY29udHJvbGxlcnMpDQo+IC0J
CWNvbnRyb2xsZXJzID0gbF9xdWV1ZV9uZXcoKTsNCj4gLQ0KPiAgCWlmICghcmVhZF9pbmZvX3Jl
Z3MpDQo+ICAJCXJlYWRfaW5mb19yZWdzID0gbF9xdWV1ZV9uZXcoKTsNCj4gIA0K
