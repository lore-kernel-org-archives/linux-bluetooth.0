Return-Path: <SRS0=Lh13=V5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A11DC19759
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Aug 2019 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C110206A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Aug 2019 20:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfHAU27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:28:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:31067 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfHAU25 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Aug 2019 16:28:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 13:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="174729925"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2019 13:28:53 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 1 Aug 2019 13:28:53 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 13:28:52 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v7 0/3] Implement org.bluez.mesh.Network1.Import()
 D-Bus API
Thread-Topic: [PATCH BlueZ v7 0/3] Implement
 org.bluez.mesh.Network1.Import() D-Bus API
Thread-Index: AQHVR2/6vCYE8XhowEKsnmyAkK5jDabnNe6A
Date:   Thu, 1 Aug 2019 20:28:52 +0000
Message-ID: <1564691331.19611.0.camel@intel.com>
References: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.29.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <21A90EE9194FB843AC7FB822E5D53BB1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIFdlZCwgMjAxOS0wNy0zMSBhdCAwOToxNiArMDIwMCwgTWlj
aGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+ICsgS2VlcCBkZWZhdWx0VFRMIGFuZCBzZXFO
dW1iZXIgb3B0aW9uYWwsIGJ1dCBjaGVjayB0aGUgZm9ybWF0IGFuZCByYW5nZQ0KPiArIFN0eWxl
IGZpeGVzIGluIG1lc2gtY29uZmlnLWpzb24NCj4gKyBSZXdvcmtlZCB0aGUgQVBJIHRvIG5ldyBz
aWduYXR1cmUNCj4gKyBSZW1vdmVkIGRlcGVuZGVuY2llcyBvbiBtZXNoLWNvbmZpZw0KPiANCj4g
DQo+ICoqKiBCTFVSQiBIRVJFICoqKg0KPiANCj4gSmFrdWIgV2l0b3dza2kgKDEpOg0KPiAgIG1l
c2g6IEV4dHJhY3QgcmVhZF8qIGZ1bmN0aW9ucyBpbiBtZXNoLWNvbmZpZy1qc29uDQo+IA0KPiBN
aWNoYcWCIExvd2FzLVJ6ZWNob25layAoMik6DQo+ICAgbWVzaDogQWRkIGRvY3VtZW50YXRpb24g
Zm9yIEltcG9ydCgpIEQtQnVzIEFQSQ0KPiAgIG1lc2g6IEltcGxlbWVudCBJbXBvcnQoKSBELUJ1
cyBBUEkgb2Ygb3JnLmJsdWV6Lm1lc2guTmV0d29yazENCj4gICAgIGludGVyZmFjZQ0KPiANCj4g
IGRvYy9tZXNoLWFwaS50eHQgICAgICAgIHwgIDU3ICsrKysrKysrKysrKysrLS0tLS0tDQo+ICBt
ZXNoL21lc2gtY29uZmlnLWpzb24uYyB8ICA4MyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LQ0KPiAgbWVzaC9tZXNoLmMgICAgICAgICAgICAgfCAxMTUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiAgbWVzaC9ub2RlLmMgICAgICAgICAgICAgfCAgODcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICBtZXNoL25vZGUuaCAgICAgICAgICAgICB8
ICAgNSArKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAzMTQgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRp
b25zKC0pDQo+IA==
