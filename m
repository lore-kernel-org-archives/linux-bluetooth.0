Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37FC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3374B2087F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCKWVO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:21:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:33953 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKWVO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 18:21:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 15:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="281758382"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2019 15:21:14 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Mar 2019 15:21:14 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.233]) with mapi id 14.03.0415.000;
 Mon, 11 Mar 2019 15:21:13 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix bug with adding more than one app key
Thread-Topic: [PATCH BlueZ v2] mesh: Fix bug with adding more than one app
 key
Thread-Index: AQHU2C1sA3xnEBJOgEafJwEQmHVLeqYHdnSA
Date:   Mon, 11 Mar 2019 22:21:13 +0000
Message-ID: <1552342871.29289.4.camel@intel.com>
References: <20190311171059.12298-1-brian.gix@intel.com>
In-Reply-To: <20190311171059.12298-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.149.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C376BA77335146B1E72D0EF344191E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMTktMDMtMTEgYXQgMTA6MTAgLTA3MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gRml4ZWQgcHJvYmxlbSB3aGVyZSBpZiB0aGUgYXBwS2V5cyBhcnJheSBhbHJlYWR5
IGV4aXN0cywgdGhhdCBuZXcgYWRkDQo+IGtleSByZXF1ZXN0cyB3ZXJlIHJlamVjdGVkLg0KPiAt
LS0NCj4gIG1lc2gvbWVzaC1kYi5jIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLWRiLmMgYi9tZXNoL21lc2gtZGIu
Yw0KPiBpbmRleCAyZGMxM2NkNjUuLmQ1ZDE5ZDUyZiAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNo
LWRiLmMNCj4gKysrIGIvbWVzaC9tZXNoLWRiLmMNCj4gQEAgLTUzMyw4ICs1MzMsNiBAQCBib29s
IG1lc2hfZGJfYXBwX2tleV9hZGQoanNvbl9vYmplY3QgKmpvYmosIHVpbnQxNl90IG5ldF9pZHgs
IHVpbnQxNl90IGFwcF9pZHgsDQo+ICAJY2hhciBidWZbNV07DQo+ICANCj4gIAlqc29uX29iamVj
dF9vYmplY3RfZ2V0X2V4KGpvYmosICJhcHBLZXlzIiwgJmphcnJheSk7DQo+IC0JaWYgKGphcnJh
eSkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+ICAJaWYgKGphcnJheSkNCj4gIAkJamVudHJ5
ID0gZ2V0X2tleV9vYmplY3QoamFycmF5LCBhcHBfaWR4KTs=
