Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B70C7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACF321901
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfGZQTN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:19:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:7067 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfGZQTM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 12:19:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="178446155"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2019 09:19:12 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 09:19:11 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.86]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 09:19:11 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v6 0/5] Use composition data to validate app
 against the
Thread-Topic: [PATCH BlueZ v6 0/5] Use composition data to validate app
 against the
Thread-Index: AQHVQ3xv74Pd99eOSEqLJUlSbe20V6bdihSA
Date:   Fri, 26 Jul 2019 16:19:11 +0000
Message-ID: <1564157949.16999.0.camel@intel.com>
References: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.105.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5323B9025B39244B6E006931A62B151@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gRnJpLCAyMDE5LTA3LTI2IGF0IDA4OjM2ICswMjAwLCBN
aWNoYcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gVGhhbmtzIGZvciB5b3VyIHBhdGllbmNl
IDopDQo+IA0KPiArIEZpeCBicmFjZSBzdHlsZQ0KPiArIEZpeCBjb21tZW50IHN0eWxlDQo+ICsg
Rml4IHR5cG8gd2hlbiBhc3NpZ25pbmcgZWxlbWVudCBwYXRocyBpbiBhdHRhY2hfcmVxX25vZGUN
Cj4gKyBGaXggc2V0dGluZyBhcHBfcGF0aCBhbmQgb3duZXIgZHVyaW5nIEF0dGFjaCgpDQo+ICsg
Rml4IHR5cG8gQ29tcGFueUlEIHByb3BlcnR5IHZhbGlkYXRpb24NCj4gKyBBZGRlZCBjb21tZW50
cyBhYm91dCB0ZW1wb3Jhcnkgbm9kZSB1c2FnZSBkdXJpbmcgQXR0YWNoKCkNCj4gKyBLZWVwIGVs
ZW1lbnQncyBMb2NhdGlvbiBwcm9wZXJ0eSBvcHRpb25hbCBhY2NvcmRpbmcgdG8gQVBJDQo+ICAg
ZG9jdW1lbnRhdGlvbg0KPiANCj4gLS0tDQo+IA0KPiBUaGlzIHBhdGNoc2V0IHN0cmVhbWxpbmVz
IGFwcCB2YWxpZGF0aW9uIGJ5IGNyZWF0aW5nIGEgdGVtcG9yYXJ5IG5vZGUNCj4gZHVyaW5nIEF0
dGFjaCwgSm9pbiBhbmQgQ3JlYXRlTmV0d29yayBjYWxscywgdGhlbiB2YWxpZGF0aW5nIGl0cw0K
PiBjb21wb3NpdGlvbiBkYXRhIHRvOg0KPiAgLSBmaXQgaW4gQ29uZmlnIE1vZGVsIENvbXBvc2l0
aW9uIERhdGEgR2V0IG1lc3NhZ2UNCj4gIC0gZGVjbGFyZSBtYW5kYXRvcnkgbW9kZWxzIG9uIHBy
aW1hcnkgZWxlbWVudA0KPiAgLSBkZWNsYXJlIGNvbnNlY3V0aXZlIGVsZW1lbnQgaW5kZXhlcw0K
PiANCj4gRHVyaW5nIEF0dGFjaCBjYWxsLCB0ZW1wb3JhcnkgY29tcG9zaXRpb24gZGF0YSBpcyBh
bHNvIGNvbXBhcmVkIHdpdGgNCj4gZGF0YSBnZW5lcmF0ZWQgZm9yIGV4aXN0aW5nIG5vZGUsIGd1
YXJhbnRlZWluZyBpbW11dGFibGl0eSByZXF1aXJlZCBieQ0KPiB0aGUgc3BlY2lmaWNhdGlvbi4N
Cj4gDQo+IE1pY2hhxYIgTG93YXMtUnplY2hvbmVrICg1KToNCj4gICBtZXNoOiBDb252ZXJ0IHZv
aWQgcG9pbnRlcnMgdG8gYW5vbnltb3VzIHVuaW9ucyBpbiBtYW5hZ2VkX29ial9yZXF1ZXN0DQo+
ICAgbWVzaDogVmFsaWRhdGUgYXBwbGljYXRpb24gYnkgY29tcGFyaW5nIGNvbXBvc2l0aW9uIGRh
dGENCj4gICBtZXNoOiBLZWVwIGVsZW1lbnQgYW5kIG1vZGVsIGxpc3RzIHNvcnRlZCBhbmQgdW5p
cXVlDQo+ICAgbWVzaDogQ2hlY2sgdGhhdCBlbGVtZW50IGluZGV4ZXMgYXJlIGNvbnNlY3V0aXZl
DQo+ICAgbWVzaDogQ2hlY2sgdGhhdCBjb25maWcgc2VydmVyIGlzIHByZXNlbnQgaW4gcHJpbWFy
eSBlbGVtZW50DQo+IA0KPiAgbWVzaC9tZXNoLWRlZnMuaCB8ICAgMiArDQo+ICBtZXNoL25vZGUu
YyAgICAgIHwgNTU2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDI5MCBpbnNlcnRpb25zKCspLCAyNjggZGVsZXRpb25z
KC0pDQo+IA==
