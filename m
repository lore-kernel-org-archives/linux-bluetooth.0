Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FDC3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0556321726
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 18:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfH2SjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:39:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:4322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbfH2SjD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 14:39:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 11:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="182429616"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 11:39:00 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.129]) with mapi id 14.03.0439.000;
 Thu, 29 Aug 2019 11:39:00 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Log D-Bus method call errors
Thread-Topic: [PATCH BlueZ] mesh: Log D-Bus method call errors
Thread-Index: AQHVVy2bkXDzmW+5gESx2fBstT1SHacRQJeAgAEnZYCAAJELAA==
Date:   Thu, 29 Aug 2019 18:38:59 +0000
Message-ID: <145b9b726c45fd37592b5a7a3504c911cd848409.camel@intel.com>
References: <20190820075654.2195-1-michal.lowas-rzechonek@silvair.com>
         <685bc703108f5329b861f5c5f87301b44bddd8e0.camel@intel.com>
         <20190829095951.nzzqqhgvblhogf4e@mlowasrzechonek2133>
In-Reply-To: <20190829095951.nzzqqhgvblhogf4e@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.35.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C2AD96B7B7B8245A2770E0460516AB7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVGh1LCAyMDE5LTA4LTI5IGF0IDExOjU5ICswMjAwLCBtaWNoYWwu
bG93YXMtcnplY2hvbmVrQHNpbHZhaXIuY29tIHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+IE9u
IDA4LzI4LCBHaXgsIEJyaWFuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOS0wOC0yMCBhdCAwOTo1
NiArMDIwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+ID4gPiBJZiBhIHN5c3Rl
bSBpcyBtaXNjb25maWd1cmVkLCBtZXNoIGRhZW1vbiBtaWdodCBub3QgaGF2ZSBwZXJtaXNzaW9u
cyB0bw0KPiA+ID4gY2FsbCBhcHBsaWNhdGlvbiBtZXRob2RzLg0KPiA+ID4gDQo+ID4gPiBUaGlz
IHBhdGNoIGNhdXNlcyBtZXNoIGRhZW1vbiB0byBsb2cgc3VjaCBlcnJvcnMsIGluc3RlYWQgb2Yg
ZmFpbGluZw0KPiA+ID4gc2lsZW50bHkuDQo+ID4gDQo+ID4gU29tZSBvZiB0aGVzZSBSZXBsaWVz
IGZvciBlcnJvciBjaGVja2luZyBhcmUgd2FycmFudGVkLCBJIHRoaW5rLi4uDQo+ID4gUGFydGlj
dWxhcmlseSB3aGVuIHRoZXJlIGlzIHJlcXVpcmVkIGluZm9ybWF0aW9uIHRoYXQgbmVlZHMgdG8g
YmUgc2VudA0KPiA+IHRvIHRoZSBBcHBsaWNhdGlvbiBkdXJpbmcgUHJvdmlzaW9uaW5nLCBmb3Ig
aW5zdGFuY2UuDQo+ID4gDQo+ID4gQnV0IHNvbWV0aW1lcyB3ZSBleHBlY3QgdGhlIGFwcGxpY2F0
aW9uIHRvIGJlICJhd2F5IiBmb3Igbm9ybWFsDQo+ID4gcmVhc29ucyAoaXQgaXMgaW50ZW5kZWQg
YXMgYSBmb3JlZ3JvdW5kIGFwcCwgZm9yIGluc3RhbmNlKSB3aGVyZSBJIGFtDQo+ID4gbm90IHN1
cmUgd2Ugd2FudCB0byByZXF1aXJlIHRoZSByZXNwb25zZS4uLiBGb3IgaW5zdGFuY2UgdGhlIG1l
dGhvZA0KPiA+IGNhbGxzIGluIG1vZGVsLmMgdGhhdCBvY2N1ciB3aGVuIGEgcmVtb3RlIG5vZGUg
aGFzIHNlbnQgYSBtZXNzYWdlLg0KPiANCj4gWWVzLCB0aGVzZSBjYWxscyB3ZXJlIG15IHByaW1h
cnkgY29uY2VybiBoZXJlLg0KPiANCj4gTm90ZSB0aGF0IEQtQnVzIGNhbGxzIGRvICpub3QqIGhh
cHBlbiBpZiB0aGUgYXBwbGljYXRpb24gaXMgbm90IGF0dGFjaGVkDQo+IChub2RlLT5vd25lciBp
cyBOVUxMKS4NCg0KVGhhdCBpcyB0cnVlLCBhbmQgd2UgKmV4cGVjdCogYXBwbGljYXRpb25zIHRo
YXQgYXJlIGF0dGFjaGVkIHRvIGhhbmRsZSB0aGUgc29ja2V0LXNpZ25hbHMgKHRoYXQgZHJpdmUg
ZC1idXMpIGluDQphIHRpbWVseSBtYW5uZXIuLi4gIEJ1dCBJIGFtIG5vdCBzdXJlIHdlIGhhdmUg
YSB3YXkgdG8gZW5mb3JjZSBpdC4gDQoNCkNlcnRhaW5seSwgd2UgY2FuIHNpbXVsYXRlIGEgZGlz
Y29ubmVjdGlvbiBpZiBhbiBBcHAgaWdub3JlcyBpdCdzIERCdXMgc29ja2V0IHNpZ25hbCwgYnV0
IGFnYWluLCB3ZSB3b24ndCBrbm93DQphYm91dCB0aGF0IGZvciAzMCBzZWNvbmRzIHdoaWNoIHNl
ZW1zIGxpa2UgZm9yZXZlci4uLiAgQW5kIGFuIEFwcCBjb3VsZCBwb3RlbnRpYWxseSBoYXZlIGEg
bGFyZ2UgZW5vdWdoIGJhY2tsb2cNCm9mIG1lc3NhZ2VzIG5lZ2F0aXZlbHkgYWZmZWN0aW5nIHRo
ZSBkYWVtb24gYmVmb3JlIGl0IGFuZCBjb3JyZWN0cyBpdC4NCg0KPiANCj4gPiBUaGUgTm9uLVJl
cGx5IHZlcnNpb24gb2Ygc2VuZCAodG93YXJkcyB0aGUgYXBwcykgd2FzIGFjdHVhbGx5IGEgZGVz
aWduDQo+ID4gZGVjaXNpb24sIHNpbmNlIHdlIGRvbid0IHdhbnQgdGhlICpkYWVtb24qIHRvIGV4
aGFzdCBkLWJ1cyByZXNvdXJjZXMsDQo+ID4gZGVwZW5kaW5nIG9uIHJlcGxpZXMgZnJvbSBBcHBz
IHRoYXQgYXJlIGlnbm9yaW5nIHRoZSBtZXNzYWdlcyB3ZSBhcmUNCj4gPiBzZW5kaW5nLg0KPiA+
IA0KPiA+IFRoaXMgY291bGQgbmVnYXRpdmVseSBpbXBhY3QgdGhlIGRhZW1vbidzIGFiaWxpdHkg
dG8NCj4gPiBpbnRlcmFjdCB3aXRoIHBlcmhhcHMgYmV0dGVyIGJlaGF2ZWQgYXBwbGljYXRpb25z
LiAgSSB0aGluayBldmVyeQ0KPiA+IHJlcGx5IHJlcXVpcmVkIG1lc3NhZ2UgcGVyc2lzdHMgZm9y
IHVwIHRvIDMwIHNlY29uZHMuDQo+IA0KPiBUcnVlLg0KPiANCj4gU2luY2UgbW9zdCBvZiB0aGUg
YXBwbGljYXRpb24tc2lkZSBtZXRob2RzIGRvIG5vdCByZXR1cm4gYW55dGhpbmcgKGFuZA0KPiBy
aWdodGx5IHNvLCBiZWNhdXNlICJBbnkgZGlzY3JldGUgT1RBIG1lc3NhZ2UgbWlnaHQgYmUgbG9z
dCIpLCB0aGUNCj4gYXBwbGljYXRpb24gaXMgZnJlZSB0byBkbyB3aGF0ZXZlciBpcyBwbGVhc2Vz
IHdpdGggdGhlIHBheWxvYWQsDQo+IGluY2x1ZGluZyBkcm9wcGluZyBpdC4NCj4gDQo+IFN0aWxs
LCBJIHRoaW5rIHRoYXQgdGhlIG5vbmUgb2YgdGhlIGNhbGwgaGFuZGxlcnMgb24gdGhlIGFwcGxp
Y2F0aW9uDQo+IHNpZGUgc2hvdWxkICpldmVyKiByZXR1cm4gZXJyb3JzL3RpbWVvdXRzIG92ZXIg
RC1CdXMuDQo+IA0KPiBJJ20gYXJndWluZyB0aGF0IHN1Y2ggYW4gYXBwbGljYXRpb24gaXMgbWlz
YmVoYXZpbmcsIHNvIGl0IHByb2JhYmx5DQo+IHNob3VsZCBiZSBwcm9tcHRseSBkZXRhY2hlZC4g
VGhhdCB3b3VsZCBwcm90ZWN0IHRoZSBkYWVtb24uDQo+IA0KPiA+IEkgdGhpbmsgb3VyIHJ1bGUg
b2YgdGh1bWIgc2hvdWxkIGJlIHJlcXVpcmluZyBhIHJlc3BvbnNlIHdoZW4gdGhlDQo+ID4gZGFl
bW9uIG5lZWRzIHRvIGtub3cgdGhhdCB0aGUgQXBwIGhhcyBzdWNjZXNzZnVsbHkgaGFuZGxlZCBj
cml0aWNhbA0KPiA+IGluZm9ybWF0aW9uIHNvIGZvciBpbnN0YW5jZSBZRVMgZm9yOg0KPiA+IA0K
PiA+IEFkZE5vZGVDb21wbGV0ZSgpDQo+ID4gSm9pbkNvbXBsZXRlKCkNCj4gPiBSZXF1ZXN0UHJv
dkRhdGEoKQ0KPiANCj4gQWdyZWVkLg0KPiANCj4gcmVnYXJkcw0K
