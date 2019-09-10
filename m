Return-Path: <SRS0=SYhR=XF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF456C49ED9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Sep 2019 16:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D612089F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Sep 2019 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436814AbfIJQlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:41:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:53374 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436804AbfIJQlp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Sep 2019 12:41:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 09:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="200321183"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2019 09:41:43 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Sep 2019 09:41:43 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.153]) with mapi id 14.03.0439.000;
 Tue, 10 Sep 2019 09:41:43 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v4 0/2] mesh: Streamline Key Refresh finalization
Thread-Topic: [PATCH BlueZ v4 0/2] mesh: Streamline Key Refresh finalization
Thread-Index: AQHVZM+bsErCEIN2iEiIv/l6SRYEY6clmPkA
Date:   Tue, 10 Sep 2019 16:41:43 +0000
Message-ID: <ed48a0384e0e0d49a2dcd48442d50c0d5ea5f418.camel@intel.com>
References: <20190906162434.7434-1-brian.gix@intel.com>
In-Reply-To: <20190906162434.7434-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.91.200]
Content-Type: text/plain; charset="utf-8"
Content-ID: <08DA444000D7EA46980595C99A561DA0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBGcmksIDIwMTktMDktMDYgYXQgMDk6MjQgLTA3MDAsIEJy
aWFuIEdpeCB3cm90ZToNCj4gQWxsIEFwcCBrZXkgcmVmcmVzaCBmaW5hbGl6YXRpb24gd2lsbCBo
YXBwZW4gd2hlbiB0aGUgYm91bmQgTmV0IEtleSBpcw0KPiBmaW5hbGl6ZWQuDQo+IA0KPiBWZXJz
aW9uIDQ6IEFsbG93IGEgcmVkdW5kZW50IGNhbGwgdG8gc2V0IHBoYXNlIDMgKGFmdGVyIHRyYW5z
aXRpb24gdG8NCj4gcGhhc2UgMCBjb21wbGV0ZSkgYnkgcmV0dXJuaW5nIHN1Y2Nlc3NmdWxseSwg
YnV0IGRvaW5nIG5vdGhpbmcuDQo+IA0KPiANCj4gQnJpYW4gR2l4ICgyKToNCj4gICBkb2M6IFJl
bW92ZSB1bmVlZGVkIGRidXMgQVBJIGZvciBBcHAgS2V5IFJlZnJlc2gNCj4gICBtZXNoOiBBdXRv
bWF0ZSBBcHBLZXkgdXBkYXRlIG9uIEtSIHBoYXNlIDItLT4zLS0+MA0KPiANCj4gIGRvYy9tZXNo
LWFwaS50eHQgfCAxOSAtLS0tLS0tLS0tLS0tLS0tDQo+ICBtZXNoL2tleXJpbmcuYyAgIHwgNTgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBtZXNo
L2tleXJpbmcuaCAgIHwgIDEgKw0KPiAgbWVzaC9tYW5hZ2VyLmMgICB8IDUzICsrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgNzkg
aW5zZXJ0aW9ucygrKSwgNTIgZGVsZXRpb25zKC0pDQo+IA0K
