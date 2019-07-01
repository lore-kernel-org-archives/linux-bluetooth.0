Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEDC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF6B208C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 15:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGAP5E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:57:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:54202 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfGAP5E (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 11:57:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 08:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="163723732"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2019 08:57:03 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 08:57:03 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.232]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 08:57:02 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: RE: Was: mesh: Added ImportLocalNode call with its API --> Multiple
 Methods?
Thread-Topic: Was: mesh: Added ImportLocalNode call with its API -->
 Multiple Methods?
Thread-Index: AQHVLRZ9fRBaO09IV0ao9IDcG1DkoqawXpWAgAE4cACABGC1AP//+Lpw
Date:   Mon, 1 Jul 2019 15:57:02 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBB4F18@ORSMSX103.amr.corp.intel.com>
References: <20190625143855.29889-1-jakub.witowski@silvair.com>
 <1561568468.22940.16.camel@intel.com>
 <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
 <CAMCw4t3pXTbtt05RD694jzF_MNT_J9dcFMtA7iuD4ujZT9FDbg@mail.gmail.com>
 <1561660267.7802.29.camel@intel.com> <20190627195127.payxcdeexiamsi24@kynes>
 <1561732182.7802.47.camel@intel.com>
 <20190701092052.24dxntjvvdcylp6r@mlowasrzechonek2133>
In-Reply-To: <20190701092052.24dxntjvvdcylp6r@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGRiZjY4MTYtNzVhMi00NGE5LWE3MGEtN2Y3MzdiYTBmNDM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieWx4S0JKS0hzdWtsdVlLQjhkVFdlOERTY0ptamFCaXd2QzVUZGpJdkNSWXhcL2dWUWhkM1wvb0U5YVwvQTFwWlRKTSJ9
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLg0KDQo+ID4gV2UgY2FuIHBlcmhhcHMgIk92ZXJsb2FkIiB0aGlzIGZ1bmN0aW9u
YWxpdHkgYnkgYWxsb3dpbmcgYSBtaW5pbWFsDQo+ID4gSlNPTiB3aXRoIG9ubHkgUHJvdiBEYXRh
IHBhcnRzLCBpZiB3ZSBhcmUgbG9va2luZyBmb3IgYSBQcm92aXNpb25pbmcNCj4gPiBzaG9ydGN1
dCwgYW5kIGFsd2F5cyByZXF1aXJpbmcgdGhlIE9iamVjdE1hbmFnZXIgY2FsbHMgZmV0Y2ggdGhl
DQo+ID4gQ29tcG9zaXRpb24gKGlmIHRoZSBKU09OIHdhcyBtaW5pbWFsKSBhbmQgdG8gU2FuaXR5
IGNoZWNrIHRoZQ0KPiA+IENvbXBvc2l0aW9uIChpZiB0aGUgSlNPTiBjb250YWlucyBhIGZ1bGx5
IGRldmVsb3BlZC9jb25maWd1cmVkDQo+ID4gTWlncmF0ZWQgbm9kZSkuDQo+IA0KPiBPaywgdGhh
dCBzb3VuZHMgYmV0dGVyLiBXZSBjb3VsZCBzdGFydCBieSBpbXBsZW1lbnRpbmcgdGhlICJQcm92
aXNvaW5pbmcNCj4gc2hvcnRjdXQiIHZhcmlhbnQsIGFuZCBhZGQgZnVsbC1ibG93biBtaWdyYXRp
b24gd2hlbiBpdCdzIG5lZWRlZC4NCj4gDQo+IFdvdWxkIHRoYXQgYmUgT0sgZnJvbSB5b3VyIFBP
Vj8NCg0KVGhpcyB3b3VsZCBiZSBPSyBmb3IgbWUuICBIb3cgYWJvdXQgSW5nYT8NCg0KQlIsIA0K
QnJpYW4NCg==
