Return-Path: <SRS0=4P0p=XD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74354C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Sep 2019 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0D42082C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Sep 2019 14:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfIHOS7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Sep 2019 10:18:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:21199 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfIHOS7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Sep 2019 10:18:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 07:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,481,1559545200"; 
   d="scan'208";a="383729793"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2019 07:18:57 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 8 Sep 2019 07:18:58 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.240]) with mapi id 14.03.0439.000;
 Sun, 8 Sep 2019 07:18:58 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3] mesh: Handle messages sent to a fixed group
 address
Thread-Topic: [PATCH BlueZ v3] mesh: Handle messages sent to a fixed group
 address
Thread-Index: AQHVZUKdBxdGfkaFyk2Ua2G5MUM9jKciS4WA
Date:   Sun, 8 Sep 2019 14:18:57 +0000
Message-ID: <0a5008f93d4b2d7e82a7e8d68a6444d2284d98f7.camel@intel.com>
References: <20190907060759.5298-1-inga.stotland@intel.com>
In-Reply-To: <20190907060759.5298-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.11.138]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C8E7CD3FF0D654A819F900D72C0446B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMTktMDktMDYgYXQgMjM6MDcgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgaGFuZGxlcyB0aGUgY2FzZSB3aGVuIGFuIGluYm91bmQgbWVzc2Fn
ZSBpcyBhZGRyZXNzZWQgdG8NCj4gYSBmaXhlZCBncm91cCwgaS5lLiwgYWxsLXByb3hpZXMsIGFs
bC1mcmllbmRzLCBhbGwtcmVsYXlzIGFuZA0KPiBhbGwtbm9kZXMuIFRoZSBtZXNzYWdlIGlzIGRl
bGl2ZXJlZCB0byBhIHByaW1hcnkgZWxlbWVudCBvbmx5LA0KPiBhbmQsIHdpdGggdGhlIGV4Y2Vw
dGlvbiBvZiBhbGwtbm9kZXMgY2FzZSwgaWYgdGhlIGNvcnJlc3BvbmRpbmcNCj4gZmVhdHVyZSBp
cyBlbmFibGVkIG9uIHRoZSBub2RlLg0KPiAtLS0NCj4gIG1lc2gvbWVzaC1kZWZzLmggfCAgMiAr
Kw0KPiAgbWVzaC9tb2RlbC5jICAgICB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2gtZGVmcy5oIGIvbWVzaC9tZXNoLWRlZnMuaA0K
PiBpbmRleCAxMjE5ZTQ5MzkuLjhmMjhmYzg5YiAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNoLWRl
ZnMuaA0KPiArKysgYi9tZXNoL21lc2gtZGVmcy5oDQo+IEBAIC0xMTgsNCArMTE4LDYgQEANCj4g
ICNkZWZpbmUgSVNfR1JPVVAoeCkJCSgoKCh4KSA+PSBHUk9VUF9BRERSRVNTX0xPVykgJiYgXA0K
PiAgCQkJCQkoKHgpIDwgRklYRURfR1JPVVBfSElHSCkpIHx8IFwNCj4gIAkJCQkJKCh4KSA9PSBB
TExfTk9ERVNfQUREUkVTUykpDQo+ICsNCj4gKyNkZWZpbmUgSVNfRklYRURfR1JPVVBfQUREUkVT
Uyh4KQkoKHgpID49IFBST1hJRVNfQUREUkVTUykNCj4gICNkZWZpbmUgSVNfQUxMX05PREVTKHgp
CSgoeCkgPT0gQUxMX05PREVTX0FERFJFU1MpDQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVsLmMg
Yi9tZXNoL21vZGVsLmMNCj4gaW5kZXggOGYzZDY3ZWNmLi5hMDZiNjg0YTUgMTAwNjQ0DQo+IC0t
LSBhL21lc2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21vZGVsLmMNCj4gQEAgLTMxMSw3ICszMTEs
NyBAQCBzdGF0aWMgdm9pZCBmb3J3YXJkX21vZGVsKHZvaWQgKmEsIHZvaWQgKmIpDQo+ICAJCXJl
dHVybjsNCj4gIA0KPiAgCWRzdCA9IGZ3ZC0+ZHN0Ow0KPiAtCWlmIChkc3QgPT0gZndkLT51bmlj
YXN0IHx8IElTX0FMTF9OT0RFUyhkc3QpKQ0KPiArCWlmIChkc3QgPT0gZndkLT51bmljYXN0IHx8
IElTX0ZJWEVEX0dST1VQX0FERFJFU1MoZHN0KSkNCj4gIAkJZndkLT5oYXNfZHN0ID0gdHJ1ZTsN
Cj4gIAllbHNlIGlmIChmd2QtPnZpcnQpIHsNCj4gIAkJdmlydCA9IGxfcXVldWVfZmluZChtb2Qt
PnZpcnR1YWxzLCBzaW1wbGVfbWF0Y2gsIGZ3ZC0+dmlydCk7DQo+IEBAIC04ODYsOCArODg2LDMw
IEBAIGJvb2wgbWVzaF9tb2RlbF9yeChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBib29sIHN6bWlj
dCwgdWludDMyX3Qgc2VxMCwNCj4gIAlpZiAoIW51bV9lbGUgfHwgSVNfVU5BU1NJR05FRChhZGRy
KSkNCj4gIAkJZ290byBkb25lOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBJbiBjYXNlIG9mIGZpeGVk
IGdyb3VwICBhZGRyZXNzZXMgY2hlY2sgaWYgdGhlDQo+ICsJICogY29ycmVzcG9uZGluZyBtb2Rl
IGlzIGVuYWJsZWQuDQo+ICsJICovDQo+ICsJaWYgKGRzdCA9PSBQUk9YSUVTX0FERFJFU1MgJiYN
Cj4gKwkJCShub2RlX3Byb3h5X21vZGVfZ2V0KG5vZGUpICE9IE1FU0hfTU9ERV9FTkFCTEVEKSkN
Cj4gKwkJZ290byBkb25lOw0KPiArDQo+ICsJaWYgKGRzdCA9PSBGUklFTkRTX0FERFJFU1MgJiYN
Cj4gKwkJCShub2RlX2ZyaWVuZF9tb2RlX2dldChub2RlKSAhPSBNRVNIX01PREVfRU5BQkxFRCkp
DQo+ICsJCWdvdG8gZG9uZTsNCj4gKw0KPiArCWlmIChkc3QgPT0gUkVMQVlTX0FERFJFU1MpIHsN
Cj4gKwkJdWludDhfdCBjbnQ7DQo+ICsJCXVpbnQxNl90IGludGVydmFsOw0KPiArDQo+ICsJCWlm
IChub2RlX3JlbGF5X21vZGVfZ2V0KG5vZGUsICZjbnQsICZpbnRlcnZhbCkgIT0NCj4gKwkJCQkJ
CQlNRVNIX01PREVfRU5BQkxFRCkNCj4gKwkJCWdvdG8gZG9uZTsNCj4gKwl9DQo+ICsNCj4gIAlp
c19zdWJzY3JpcHRpb24gPSAhKElTX1VOSUNBU1QoZHN0KSk7DQo+ICANCj4gKw0KPiAgCWZvciAo
aSA9IDA7IGkgPCBudW1fZWxlOyBpKyspIHsNCj4gIAkJc3RydWN0IGxfcXVldWUgKm1vZGVsczsN
Cj4gIA0KPiBAQCAtOTI3LDYgKzk0OSwxNCBAQCBib29sIG1lc2hfbW9kZWxfcngoc3RydWN0IG1l
c2hfbm9kZSAqbm9kZSwgYm9vbCBzem1pY3QsIHVpbnQzMl90IHNlcTAsDQo+ICAJCS8qIElmIHRo
ZSBtZXNzYWdlIHdhcyB0byB1bmljYXN0IGFkZHJlc3MsIHdlIGFyZSBkb25lICovDQo+ICAJCWlm
ICghaXNfc3Vic2NyaXB0aW9uICYmIGVsZV9pZHggPT0gaSkNCj4gIAkJCWJyZWFrOw0KPiArDQo+
ICsJCS8qDQo+ICsJCSAqIEZvciB0aGUgZml4ZWQgZ3JvdXAgYWRkcmVzc2VzLCBpLmUuLCBhbGwt
cHJveGllcywNCj4gKwkJICogYWxsLWZyaWVuZHMsIGFsbC1yZWxheXMsIGFsbC1ub2RlcywgdGhl
IG1lc3NhZ2UgaXMgZGVsaXZlcmVkDQo+ICsJCSAqIHRvIGEgcHJpbWFyeSBlbGVtZW50IG9ubHku
DQo+ICsJCSAqLw0KPiArCQlpZiAoSVNfRklYRURfR1JPVVBfQUREUkVTUyhkc3QpKQ0KPiArCQkJ
YnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICBkb25lOg0K
