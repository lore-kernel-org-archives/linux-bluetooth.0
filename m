Return-Path: <SRS0=f8/T=TK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1076C04AB2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 May 2019 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBE32070D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 May 2019 16:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEJQQS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 May 2019 12:16:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:13843 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfEJQQS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 May 2019 12:16:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 09:15:15 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2019 09:15:14 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 10 May 2019 09:15:14 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.91]) with mapi id 14.03.0415.000;
 Fri, 10 May 2019 09:15:14 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>
Subject: Re: Build Warnings, BlueZ TIP, Fedora-30
Thread-Topic: Build Warnings, BlueZ TIP, Fedora-30
Thread-Index: AQHVBdM7qJSYRVHedk2EmjO9QNxIP6Zkh7QAgAB5FQA=
Date:   Fri, 10 May 2019 16:15:14 +0000
Message-ID: <1557504912.4778.3.camel@intel.com>
References: <1557343285.14401.4.camel@intel.com>
         <603f5710ed4711308901ff4322925b6a33cf0f71.camel@hadess.net>
In-Reply-To: <603f5710ed4711308901ff4322925b6a33cf0f71.camel@hadess.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.146.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <186EA209C31172429F6B07A5C4F67800@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQmFzdGllbiwNCg0KT24gRnJpLCAyMDE5LTA1LTEwIGF0IDExOjAxICswMjAwLCBCYXN0aWVu
IE5vY2VyYSB3cm90ZToNCj4gT24gV2VkLCAyMDE5LTA1LTA4IGF0IDE5OjIxICswMDAwLCBHaXgs
IEJyaWFuIHdyb3RlOg0KPiA+IFRoZXNlIDMgbmV3IGJ1aWxkIHdhcm5pbmdzIHNob3dlZCB1cCB3
aGVuIEkgdXBncmFkZWQgb25lIG9mIG15DQo+ID4gZGV2aWNlcyB0byBGZWRvcmEgMzAuDQo+ID4g
DQo+ID4gVGhleSBhcmUgYWxsIGluIHRoZSBBbmRyb2lkIHN1YnRyZWUuDQo+IA0KPiBJIHNlbnQg
cGF0Y2hlcyBmb3IgdGhvc2UgdG8gdGhlIGxpc3QgeWVzdGVyZGF5LCB3b3VsZCBiZSBuaWNlIGlm
IHlvdQ0KPiBjb3VsZCB0ZXN0IHRoZW0uIFRoZXkgd2VyZSBvbmx5IGNvbXBpbGUtdGVzdGVkLg0K
DQpJIGhhdmUgcmV2aWV3ZWQgeW91ciB0aHJlZSBhbmRyb2lkIHBhdGNoZXMsIGFuZCB0aGluayB0
aGV5IHdpbGwgd29yayBjb3JyZWN0bHkuDQoNCkkgZG8gbm90IGhhdmUgdGhlIGFiaWxpdHkgYXQg
dGhlIG1vbWVudCB0byBidWlsZC10ZXN0IHRoZW0gdW50aWwgbGF0ZXIgdG9kYXkgKFBhY2lmaWMg
Q29hc3QgVVMgdGltZSAoUERUKSkgYW5kDQpkbyBub3QgaGF2ZSB0aGUgYWJpbGl0eSB0byBydW4g
dGVzdCB0aGVtIGF0IGFsbC4NCg0KQnV0IGluIG15IG9waW5pb24sIHNob3VsZCB0aGV5IGJ1aWxk
IGNvcnJlY3RseSBvbiBGZWRvcmEtMzAsIHRoZXkgZGVzZXJ2ZSB0byBiZSBhcHBsaWVkLg0KDQpu
b3RlOiAgVGhvc2Ugd2VyZSBqdXN0IDMgb2YgOCBwYXRjaGVzIGluIHlvdXIgc2V0LCBhbmQgSSBo
YXZlIG5vdCByZXZpZXdlZCB0aGUgb3RoZXJzLg==
