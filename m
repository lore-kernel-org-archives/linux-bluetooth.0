Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358DC282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ACC20821
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBDUK6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:10:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:12260 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfBDUK6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 15:10:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="316277200"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2019 12:10:57 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Feb 2019 12:10:57 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.62]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 12:10:56 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add README file
Thread-Topic: [PATCH BlueZ] mesh: Add README file
Thread-Index: AQHUucRDfyvyNUt8jEqgjVmmC5yCFaXQngoA
Date:   Mon, 4 Feb 2019 20:10:56 +0000
Message-ID: <1549311054.22761.2.camel@intel.com>
References: <20190201002241.19170-1-inga.stotland@intel.com>
In-Reply-To: <20190201002241.19170-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.13.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7094F662327A24CA32817A0E07F1B2A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpBcHBsaWVkDQoNCk9uIFRodSwgMjAxOS0wMS0zMSBhdCAxNjoyMiAtMDgwMCwgSW5nYSBTdG90
bGFuZCB3cm90ZToNCj4gICAgIFRoaXMgZmlsZSBjb250YWlucyBpbnN0cnVjdGlvbnMgZm9yIEJs
dWV0b290aCBtZXNoIGRhZW1vbg0KPiAgICAgY29uZmlndXJhdGlvbiBhbmQgZGVzY3JpcHRpb24g
b2YgdGhlIHBlcnNpc3RlbnQgc3RvcmFnZS4NCj4gLS0tDQo+ICBtZXNoL1JFQURNRSB8IDUwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IG1lc2gv
UkVBRE1FDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9SRUFETUUgYi9tZXNoL1JFQURNRQ0KPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAuLjE1MWExZTZhMQ0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL21lc2gvUkVBRE1FDQo+IEBAIC0wLDAgKzEsNTAgQEANCj4gK0Js
dWV0b290aCBNZXNoIERhZW1vbg0KPiArKioqKioqKioqKioqKioqKioqKioqDQo+ICsNCj4gK0Nv
cHlyaWdodCAoQykgMjAxOSAgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQu
DQo+ICsNCj4gK0NvbXBpbGF0aW9uIGFuZCBpbnN0YWxsYXRpb24NCj4gKz09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gKw0KPiArSW4gYWRkaXRpb24gdG8gbWFpbiBCbHVlWiByZXF1aXJl
bWVudHMsIE1lc2hDdGwgbmVlZHMgdGhlIGZvbGxvd2luZzoNCj4gKwktIGpzb24tYyBsaWJyYXJ5
DQo+ICsNCj4gK0NvbmZpZ3VyYXRpb24gYW5kIG9wdGlvbnMNCj4gKz09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gKw0KPiArCS0tZW5hYmxlLW1lc2gNCj4gKw0KPiArCQlCdWlsZCBtZXNoIGRh
ZW1vbiBhbmQgb3RoZXIgQmx1ZXRvb3RoIE1lc2ggYmFzZWQgdG9vbHMNCj4gKw0KPiArQ3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgbWVzaCBkYWVtb24gcmVxdWlyZXMgZXhjbHVzaXZlIGFj
Y2VzcyB0bw0KPiArYSBCbHVldG9vdGggY29udHJvbGxlci4NCj4gK1RoZSBBdXRvRW5hYmxlIG9w
dGlvbiBpbiB0aGUgaW5zdGFsbGVkIG1haW4uY29uZiBzaG91bGQgYmUgc2V0IHRvICJmYWxzZSIu
DQo+ICsNCj4gK1N0b3JhZ2UNCj4gKz09PT09PT0NCj4gKw0KPiArRGVmYXVsdCBzdG9yYWdlIGRp
cmVjdG9yeSBpcyAvdmFyL2xpYi9ibHVldG9vdGgvbWVzaC4NCj4gKw0KPiArVGhlIGRpcmVjdG9y
eSBjb250YWlucyB0aGUgcHJvdmlzaW9uZWQgbm9kZXMgY29uZmlndXJhdGlvbnMuDQo+ICtFYWNo
IG5vZGUgaGFzIGl0cyBvd24gc3ViZGlyZWN0b3J5LCBuYW1lZCB3aXRoIGEgNC1kaWdpdCAoaGV4
YWRlY2ltYWwpDQo+ICtpZGVudGlmaWNhdG9yIHRoYXQgaXMgaW50ZXJuYWxseSBnZW5lcmF0ZWQg
YnkgdGhlIG1lc2ggZGFlbW9uIGF0IHRoZSB0aW1lDQo+ICtvZiB0aGUgbm9kZSBwcm92aXNpb25p
bmcuDQo+ICsNCj4gK0VhY2ggc3ViZGlyZWN0b3J5IGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgZmls
ZXM6DQo+ICsJLSBub2RlLmpzb246DQo+ICsJCW5vZGUgY29uZmlndXJhdGlvbiBhbmQgaXMgcG9w
dWxhdGVkIGJ5IHRoZQ0KPiArCQlkYWVtb24gYmFzZWQgb24gdGhlIGNvbmZpZ3VyYXRpb24gY29t
bWFuZHMgZnJvbSBhDQo+ICsJCXByb3Zpc2lvbmVyL2NvbmZpZ3VyYXRpb24gY2xpZW50DQo+ICsJ
LSBub2RlLmpzb24uYmFrOg0KPiArCQlhIGJhY2t1cCB0aGF0IHRoZSBsYXN0IGtub3duIGdvb2Qg
bm9kZSBjb25maWd1cmF0aW9uLg0KPiArDQo+ICtUaGUgZmlsZXMgYXJlIGluIEpTT04gZm9ybWF0
Lg0KPiArDQo+ICtJbmZvcm1hdGlvbg0KPiArPT09PT09PT09PT0NCj4gKw0KPiArTWFpbGluZyBs
aXN0czoNCj4gKwlsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+ICsNCj4gK0ZvciBh
ZGRpdGlvbmFsIGluZm9ybWF0aW9uIGFib3V0IHRoZSBwcm9qZWN0IHZpc2l0IEJsdWVaIHdlYiBz
aXRlOg0KPiArCWh0dHA6Ly93d3cuYmx1ZXoub3JnDQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2Yg
ZmlsZQ==
