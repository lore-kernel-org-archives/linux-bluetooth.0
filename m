Return-Path: <SRS0=gGyw=WC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB82BC433FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C500A20578
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 16:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfHFQ4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:56:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:64537 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbfHFQ4k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Aug 2019 12:56:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 09:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="374115625"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 09:56:39 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.11]) with mapi id 14.03.0439.000;
 Tue, 6 Aug 2019 09:56:39 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix storing network retransmission in config
Thread-Topic: [PATCH BlueZ] mesh: Fix storing network retransmission in
 config
Thread-Index: AQHVS2MhtNTrcltnQkGjiRjLICEKRqbuzmUA
Date:   Tue, 6 Aug 2019 16:56:39 +0000
Message-ID: <b2830469a7bb2724ed0b48fb6808a5c34d158da1.camel@intel.com>
References: <20190805075458.15694-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190805075458.15694-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.0.138]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5909DA183348B343B42BF9200FA5BE17@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIE1vbiwgMjAxOS0wOC0wNSBhdCAwOTo1NCArMDIwMCwgTWlj
aGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IC0tLQ0KPiAgbWVzaC9tZXNoLWNvbmZpZy1q
c29uLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYyBiL21lc2gv
bWVzaC1jb25maWctanNvbi5jDQo+IGluZGV4IDE3N2FhYWM3Yi4uZDQ5ZjUyMjZhIDEwMDY0NA0K
PiAtLS0gYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYw0KPiArKysgYi9tZXNoL21lc2gtY29uZmln
LWpzb24uYw0KPiBAQCAtMTU1Myw3ICsxNTUzLDcgQEAgYm9vbCBtZXNoX2NvbmZpZ193cml0ZV9u
ZXRfdHJhbnNtaXQoc3RydWN0IG1lc2hfY29uZmlnICpjZmcsIHVpbnQ4X3QgY250LA0KPiAgCWpu
b2RlID0gY2ZnLT5qbm9kZTsNCj4gIA0KPiAgCWpyZXRyYW5zbWl0ID0ganNvbl9vYmplY3RfbmV3
X29iamVjdCgpOw0KPiAtCWlmIChqcmV0cmFuc21pdCkNCj4gKwlpZiAoIWpyZXRyYW5zbWl0KQ0K
PiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gIAlpZiAoIXdyaXRlX2ludChqcmV0cmFuc21pdCwg
ImNvdW50IiwgY250KSkNCg==
