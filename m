Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C8C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A373208CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 09:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEJUL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:20:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:47728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCEJUL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 04:20:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 01:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="441318521"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2020 01:20:11 -0800
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 01:20:10 -0800
Received: from BGSMSX107.gar.corp.intel.com (10.223.4.191) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 01:20:10 -0800
Received: from bgsmsx110.gar.corp.intel.com ([169.254.11.98]) by
 BGSMSX107.gar.corp.intel.com ([169.254.9.81]) with mapi id 14.03.0439.000;
 Thu, 5 Mar 2020 14:50:07 +0530
From:   "Kishore, Ajay" <ajay.kishore@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] obexd: Add initial support for MAP conversations
Thread-Topic: [PATCH v2 1/6] obexd: Add initial support for MAP conversations
Thread-Index: AQHV4RFkpGoDIqz/UkmKsCZd91BCsKg53CMA
Date:   Thu, 5 Mar 2020 09:20:06 +0000
Message-ID: <A4827819204CC641A5E2541E6709F15337DD7D34@BGSMSX110.gar.corp.intel.com>
References: <1581402970-1781-1-git-send-email-ajay.kishore@intel.com>
 <CABBYNZ+Fr629sA17x5wG-C=bGxVGyh=5OMgxp9gjCfkQKPEDqg@mail.gmail.com>
In-Reply-To: <CABBYNZ+Fr629sA17x5wG-C=bGxVGyh=5OMgxp9gjCfkQKPEDqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1i
bHVldG9vdGgtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1ibHVldG9vdGgtDQo+IG93bmVy
QHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEx1aXogQXVndXN0byB2b24gRGVudHoNCj4g
U2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxMiwgMjAyMCAxMjo1OCBBTQ0KPiBUbzogS2lzaG9y
ZSwgQWpheSA8YWpheS5raXNob3JlQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIG9iZXhkOiBBZGQg
aW5pdGlhbCBzdXBwb3J0IGZvciBNQVAgY29udmVyc2F0aW9ucw0KPiANCj4gSGkgQWpheSwNCj4g
DQo+IE9uIE1vbiwgRmViIDEwLCAyMDIwIGF0IDExOjMyIFBNIEFqYXkgS2lzaG9yZSA8YWpheS5r
aXNob3JlQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBDaGFuZ2VzIG1hZGUgdG8gYWRk
IGEgbmV3IG1ldGhvZCBmb3IgTUFQIGNvbnZlcnNhdGlvbiBsaXN0aW5nIGkuZQ0KPiA+ICJMaXN0
Q29udmVyc2F0aW9ucyIgdG8gaGFuZGxlIGNvbnZlcnNhdGlvbiBsaXN0aW5nIG9iamVjdA0KPiA+
ICJ4LWJ0L01BUC1jb252by1saXN0aW5nIi4NCj4gPiAtLS0NCj4gPiAgb2JleGQvY2xpZW50L21h
cC5jIHwgNjcNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9vYmV4ZC9jbGllbnQvbWFwLmMgYi9vYmV4ZC9jbGllbnQvbWFwLmMg
aW5kZXgNCj4gPiA1NTBjNWFmLi5hZGY2MmQ5IDEwMDY0NA0KPiA+IC0tLSBhL29iZXhkL2NsaWVu
dC9tYXAuYw0KPiA+ICsrKyBiL29iZXhkL2NsaWVudC9tYXAuYw0KPiA+IEBAIC0xNTYwLDYgKzE1
NjAsNjkgQEAgc3RhdGljIERCdXNNZXNzYWdlDQo+ICptYXBfbGlzdF9tZXNzYWdlcyhEQnVzQ29u
bmVjdGlvbiAqY29ubmVjdGlvbiwNCj4gPiAgICAgICAgIHJldHVybiBnZXRfbWVzc2FnZV9saXN0
aW5nKG1hcCwgbWVzc2FnZSwgZm9sZGVyLCBhcHBhcmFtKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMg
R09iZXhBcHBhcmFtICpwYXJzZV9jb252ZXJzYXRpb25fZmlsdGVycyhHT2JleEFwcGFyYW0NCj4g
KmFwcGFyYW0sDQo+ID4gKw0KPiA+ICtEQnVzTWVzc2FnZUl0ZXIgKml0ZXIpIHsNCj4gPiArICAg
ICAgIERCdXNNZXNzYWdlSXRlciBhcnJheTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoZGJ1c19t
ZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKGl0ZXIpICE9IERCVVNfVFlQRV9BUlJBWSkgew0KPiA+
ICsgICAgICAgICAgICAgICBEQkcoIk5vdCBvZiB0eXBlIGFycmF5Iik7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBOVUxMOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGRi
dXNfbWVzc2FnZV9pdGVyX3JlY3Vyc2UoaXRlciwgJmFycmF5KTsNCj4gPiArDQo+ID4gKyAgICAg
ICB3aGlsZSAoZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZhcnJheSkgPT0NCj4gREJV
U19UWVBFX0RJQ1RfRU5UUlkpIHsNCj4gPiArICAgICAgICAgICAgICAgY29uc3QgY2hhciAqa2V5
Ow0KPiA+ICsgICAgICAgICAgICAgICBEQnVzTWVzc2FnZUl0ZXIgdmFsdWUsIGVudHJ5Ow0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgZGJ1c19tZXNzYWdlX2l0ZXJfcmVjdXJzZSgmYXJyYXks
ICZlbnRyeSk7DQo+ID4gKyAgICAgICAgICAgICAgIGRidXNfbWVzc2FnZV9pdGVyX2dldF9iYXNp
YygmZW50cnksICZrZXkpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgZGJ1c19tZXNzYWdl
X2l0ZXJfbmV4dCgmZW50cnkpOw0KPiA+ICsgICAgICAgICAgICAgICBkYnVzX21lc3NhZ2VfaXRl
cl9yZWN1cnNlKCZlbnRyeSwgJnZhbHVlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIC8q
IFRPRE86IFBhcnNlIGNvbnZlcnNhdGlvbiBmaWx0ZXJzICovDQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICBkYnVzX21lc3NhZ2VfaXRlcl9uZXh0KCZhcnJheSk7DQo+ID4gKyAgICAgICB9DQo+
ID4gKyAgICAgICByZXR1cm4gYXBwYXJhbTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIERC
dXNNZXNzYWdlICptYXBfbGlzdF9jb252ZXJzYXRpb25zKERCdXNDb25uZWN0aW9uICpjb25uZWN0
aW9uLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IERCdXNNZXNzYWdlICptZXNzYWdlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZvaWQgKnVzZXJfZGF0YSkgew0KPiA+ICsgICAgICAgc3RydWN0
IG1hcF9kYXRhICptYXAgPSB1c2VyX2RhdGE7DQo+ID4gKyAgICAgICBjb25zdCBjaGFyICpmb2xk
ZXI7DQo+ID4gKyAgICAgICBHT2JleEFwcGFyYW0gKmFwcGFyYW07DQo+ID4gKyAgICAgICBEQnVz
TWVzc2FnZUl0ZXIgYXJnczsNCj4gPiArDQo+ID4gKyAgICAgICBkYnVzX21lc3NhZ2VfaXRlcl9p
bml0KG1lc3NhZ2UsICZhcmdzKTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoZGJ1c19tZXNzYWdl
X2l0ZXJfZ2V0X2FyZ190eXBlKCZhcmdzKSAhPSBEQlVTX1RZUEVfU1RSSU5HKQ0KPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gZ19kYnVzX2NyZWF0ZV9lcnJvcihtZXNzYWdlLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIEVSUk9SX0lOVEVSRkFDRSAiLkludmFsaWRBcmd1bWVudHMiLCBO
VUxMKTsNCj4gPiArDQo+ID4gKyAgICAgICBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYmFzaWMoJmFy
Z3MsICZmb2xkZXIpOw0KPiA+ICsNCj4gPiArICAgICAgIGFwcGFyYW0gPSBnX29iZXhfYXBwYXJh
bV9zZXRfdWludDE2KE5VTEwsDQo+IE1BUF9BUF9NQVhMSVNUQ09VTlQsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBERUZBVUxUX0NP
VU5UKTsNCj4gPiArICAgICAgIGFwcGFyYW0gPSBnX29iZXhfYXBwYXJhbV9zZXRfdWludDE2KGFw
cGFyYW0sDQo+IE1BUF9BUF9TVEFSVE9GRlNFVCwNCj4gPiArDQo+ID4gKyBERUZBVUxUX09GRlNF
VCk7DQo+ID4gKw0KPiA+ICsgICAgICAgZGJ1c19tZXNzYWdlX2l0ZXJfbmV4dCgmYXJncyk7DQo+
ID4gKw0KPiA+ICsgICAgICAgaWYgKHBhcnNlX2NvbnZlcnNhdGlvbl9maWx0ZXJzKGFwcGFyYW0s
ICZhcmdzKSA9PSBOVUxMKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGdfb2JleF9hcHBhcmFtX2Zy
ZWUoYXBwYXJhbSk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBnX2RidXNfY3JlYXRlX2Vy
cm9yKG1lc3NhZ2UsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgRVJST1JfSU5URVJGQUNF
ICIuSW52YWxpZEFyZ3VtZW50cyIsIE5VTEwpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgICAgIC8qVE9ETzogUmV0dXJuIGNvbnZlcnNhdGlvbiBsaXN0aW5nICovDQo+ID4gKyAgICAg
ICByZXR1cm4gTlVMTDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNoYXIgKipnZXRfZmls
dGVyX3N0cnModWludDY0X3QgZmlsdGVyLCBpbnQgKnNpemUpICB7DQo+ID4gICAgICAgICBjaGFy
ICoqbGlzdCwgKippdGVtOw0KPiA+IEBAIC0xODE3LDYgKzE4ODAsMTAgQEAgc3RhdGljIGNvbnN0
IEdEQnVzTWV0aG9kVGFibGUgbWFwX21ldGhvZHNbXSA9DQo+IHsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBHREJVU19BUkdTKHsgImZvbGRlciIsICJzIiB9LCB7ICJmaWx0ZXIiLCAiYXtz
dn0iIH0pLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEdEQlVTX0FSR1MoeyAibWVzc2Fn
ZXMiLCAiYXtvYXtzdn19IiB9KSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfbGlz
dF9tZXNzYWdlcykgfSwNCj4gPiArICAgICAgIHsgR0RCVVNfQVNZTkNfTUVUSE9EKCJMaXN0Q29u
dmVyc2F0aW9ucyIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgR0RCVVNfQVJHUyh7ICJm
b2xkZXIiLCAicyIgfSwgeyAiZmlsdGVyIiwgImF7c3Z9IiB9KSwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBHREJVU19BUkdTKHsgImNvbnZlcnNhdGlvbnMiLCAiYXtvYXtzdn19IiB9KSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtYXBfbGlzdF9jb252ZXJzYXRpb25zKSB9LA0K
PiA+ICAgICAgICAgeyBHREJVU19NRVRIT0QoIkxpc3RGaWx0ZXJGaWVsZHMiLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIE5VTEwsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgR0RC
VVNfQVJHUyh7ICJmaWVsZHMiLCAiYXMiIH0pLA0KPiA+IC0tDQo+ID4gMi43LjQNCj4gDQo+IEkg
c2VlIHNvbWUgbWl4IG9mIHYyIGFuZCB2MyBwYXRjaGVzLCBJIHJlY29tbWVuZCB1cGRhdGluZyB0
aGUgd2hvbGUgc2V0IHRvIHYzDQo+IHRvIG1ha2UgZWFzaWVyIHRvIHJldmlldy4NCkRvbmUuDQo+
IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQpUaGFua3MuDQpBamF5DQo=
