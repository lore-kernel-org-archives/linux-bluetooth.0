Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F777C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FD62085B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hA0rwnoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfKGRYq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:24:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:23793 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKGRYq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 12:24:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 09:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="404171432"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2019 09:24:45 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 09:24:44 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 7 Nov 2019 09:24:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWfHk8Mkw0LF7d5qt/mLbuKfyzVvh1L373jJaiMl4otX5dFayuWOwpuobmlVUtl8Y4jZjLEh/wDwax3ur19qpkb2S90Epcc1Z8CL8NkpD/mBbHAFchLE1KRhMYWznJOt4wS4gkHr6t75JOYG2pqsXUcCj/mwOrDyiwiqFnDM9/ujLP6zKaCcH4V7GryqQ5D6iBuPUSZBfJFjTEmWYCwsRKb05SyMpuLk0fL9L7fSMWs4EBKyzExElvEgAN3X5B/BhiWj3XKpN6aH7N3yklvVxWdmylfbt18mct7sEEs10QLP5pfdLjlHgkrbWlzyiR9dQf5N6kGcdbpeVpwlGMbnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUM9x0S9hXB3rft7lpyoRO2p9+VlBulkIjvMGfxG8bE=;
 b=a4gpASc6wijZ+4T/okIqjqb67qlQoroTF6XK3YbJ9Y/l+Kx+TeNLlzWFIdENeMuQG0WClmpmmMHYMlOQZ7O3rCIxiJpH0VGcJ2Nsz68D8BOxEHSVHoIIyuPlHYEXh0R/CtNuLMafRMwfyIgHa0N2eM7aQEbZyKVL+mtCNklU63Kp/WxdZVBw9qlTT0vSLbnWO7WfZpvyeQJQibkzaVcvYxVaAo7uKgwT/k3gkf8Zl7dZ9x0vM09WQLS7Gzp8OAOKn1DfecAy2MX7p7Rcr9I56RY2BJ5NdfeGu9gA9eZg5zcrdB4x6MQSVqC70s+4RhdeQXg3fU7bDPejvzw6OAzG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUM9x0S9hXB3rft7lpyoRO2p9+VlBulkIjvMGfxG8bE=;
 b=hA0rwnoNDQAGRDeIu74mYdArU8uarQ0vnBD8ORPmWNfPYftBd3BvNfsLR/fkCZo4oqpyzzj0eyums+QLlu+B/f4B0z70vc6U6OVCRXvDH/SnWyVnE7ufBoBQ3467rBKEu4n/yzKfUkucgoMXQM1qmKDlnD11+Wk5tdaHeDOiklU=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2071.namprd11.prod.outlook.com (10.172.77.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 17:24:19 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 17:24:19 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: fix binaries and config name
 in README
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: fix binaries and config name
 in README
Thread-Index: AQHVlWq1N0qwD/JEWECkGX7FpR68+6d/9YkA
Date:   Thu, 7 Nov 2019 17:24:19 +0000
Message-ID: <8e48111c43f28b7ca72f6ad647ea655606335fc1.camel@intel.com>
References: <20191107121640.26600-1-aurelien@aurel32.net>
In-Reply-To: <20191107121640.26600-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beeadd62-994b-439a-149a-08d763a752d7
x-ms-traffictypediagnostic: CY4PR1101MB2071:
x-microsoft-antispam-prvs: <CY4PR1101MB207110662C77F4C0BB13A419E1780@CY4PR1101MB2071.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(81156014)(7736002)(305945005)(14444005)(256004)(36756003)(102836004)(6506007)(5660300002)(76176011)(8936002)(91956017)(186003)(81166006)(118296001)(86362001)(8676002)(66476007)(26005)(76116006)(66946007)(66446008)(64756008)(66556008)(14454004)(66066001)(6512007)(25786009)(71200400001)(2906002)(229853002)(71190400001)(6486002)(99286004)(478600001)(316002)(2501003)(6436002)(110136005)(11346002)(2616005)(6116002)(3846002)(476003)(446003)(486006)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2071;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6Nj0h51pepqLQpPCqoNMKg3WYSA121RpltobMXZkzlUqrNgaM6w+n3mfQbr4Ga91XksoF963sOtzH3lp5fc65CHaDMEvLQqE1xURsw6DCfQnpreMv0BeuXMB25zWZwnDZoH/INwIHn2kylb/RQLrfcIR6vFqFv3YbZ77yEuObkVdkclrjNeNHVIL4Bbrru3OQow2AVg03q/ywCxqvS6IY8IxtxvEmR+UGYHCCnmJy536xGw5a9dggDG6JBVofdO84q05BLTY2GW3PviZqu0yi+xsukfQEKgXBik5c7jbCO85Lpqj6P7JYyt9gi8guKn+ZU7Ad86fysEKuunwa7LGEcenAQNq637IazV4LRZSpovxaXHPDHD17Thjc8jI1hSlypiAnbVSAHD/atdpjxsFSOrYbGt1JaiuvH5qS6c5cir8tNu7SOnymifmCxj5By/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <393D001338C00B40872CA049277C7D38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: beeadd62-994b-439a-149a-08d763a752d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:24:19.5980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtnCx3Hvg+mQUnfZc6j68tgIgAkeONM8AaI+OPf9X74woNHgK8lV4X5jXS0dnUXihBqalxjXXzU1ru5Nw7OFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2071
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMTEtMDcgYXQgMTM6MTYgKzAxMDAsIEF1cmVsaWVuIEph
cm5vIHdyb3RlOg0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBtZXNoLWNmZ2NsaWVudCBSRUFETUUg
ZmlsZToNCj4gLSBUaGUgY29uZmlndXJhdGlvbiBkaXJlY3RvcnkgaXMgbWVzaGNmZyBub3QgbWVz
aC1jZmdjbGkNCj4gLSBUaGUgaG9tZSBkaXJlY3RvcnkgaXMgbG9va2VkIHVwIHVzaW5nICRIT01F
IG5vdCB1c2luZyAvaG9tZS8kVVNFUg0KPiAtIFRoZSBiaW5hcnkgaXMgY2FsbGVkIG1lc2gtY2Zn
Y2xpZW50LCBub3QgbWVzaC1jb25maWcNCj4gLSBUaGUgLWMgb3B0aW9uIHRha2VzIGEgY29uZmln
IGZpbGUgcGF0aCwgbm90IHRoZSBkaXJlY3Rvcnkgd2hlcmUgdGhlDQo+ICAgY29uZmlnIGZpbGUg
aXMgc3RvcmVkLg0KPiANCj4gLS0tDQo+ICB0b29scy9tZXNoL1JFQURNRSB8IDYgKysrLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvUkVBRE1FIGIvdG9vbHMvbWVzaC9SRUFETUUNCj4gaW5k
ZXggOTM2MmQ4ZmY2Li4zODMwZDFiMTcgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvUkVBRE1F
DQo+ICsrKyBiL3Rvb2xzL21lc2gvUkVBRE1FDQo+IEBAIC0yNSwxMSArMjUsMTEgQEAgdGhhdCBj
b250YWlucyBpbmZvcm1hdGlvbiBhYm91dCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgY29uZmln
dXJlZCBtZXNoDQo+ICBuZXR3b3JrLg0KPiAgDQo+ICBUaGUgZGVmYXVsdCBkaXJlY3RvcnkgZm9y
IG1lc2gtY2ZnY2xpZW50IGNvbmZpZ3VyYXRpb24gZmlsZSBpcw0KPiAtL2hvbWUvPHVzZXJuYW1l
Pi8uY29uZmlnL21lc2gtY2ZnY2xpDQo+ICskSE9NRS8uY29uZmlnL21lc2hjZmcNCj4gIA0KPiAt
VG8gc3BlY2lmeSBhIGN1c3RvbSBzdG9yYWdlIGRpcmVjdG9yeSwgcnVuIG1lc2gtY29uZmlnIHRv
b2wgYXM6DQo+ICtUbyBzcGVjaWZ5IGEgY3VzdG9tIGZpbGUsIHJ1biBtZXNoLWNmZ2NsaWVudCB0
b29sIGFzOg0KPiAgDQo+IC0JbWVzaGN0bCAtYyA8Y29uZmlnX2Rpcl9uYW1lPg0KPiArCW1lc2gt
Y2ZnY2xpZW50IC1jIDxjb25maWdfZmlsZV9uYW1lPg0KPiAgDQo+ICBJZiBhIGNvbmZpZ3VyYXRp
b24gZmlsZSBpcyBub3QgZm91bmQsIGl0IGlzIGFzc3VtZWQgdGhhdCBhIG1lc2ggbmV0d29yaw0K
PiAgZG9lcyBub3QgZXhpc3QuIEluIHRoaXMgY2FzZSwgdGhlIHRvb2wgbWF5IGJlIHVzZWQgdG8g
Z2VuZXJhdGUgYSBuZXcgIG1lc2gNCg==
