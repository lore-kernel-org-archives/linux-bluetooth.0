Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE20AC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73E20656
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfANWK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:10:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:64804 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfANWK2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 17:10:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:10:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="134563957"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2019 14:10:27 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 14 Jan 2019 14:10:26 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.248]) with mapi id 14.03.0415.000;
 Mon, 14 Jan 2019 14:10:26 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/2] mesh: Clean up when finishing the Join call
Thread-Topic: [PATCH BlueZ 2/2] mesh: Clean up when finishing the Join call
Thread-Index: AQHUqiBJle42MdWcgkGoSJi95SdKRKWv3cAA
Date:   Mon, 14 Jan 2019 22:10:26 +0000
Message-ID: <1547503824.32139.1.camel@intel.com>
References: <20190112024055.9967-1-inga.stotland@intel.com>
         <20190112024055.9967-2-inga.stotland@intel.com>
In-Reply-To: <20190112024055.9967-2-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.233]
Content-Type: text/plain; charset="utf-8"
Content-ID: <15CF3306AF083647B9FA61760F3C28B4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpQYXRjaCBBcHBsaWVkDQoNCk9uIEZyaSwgMjAxOS0wMS0xMSBhdCAxODo0MCAtMDgwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gQ29uc29saWRhdGUgbXVsdGlwbGUgaW5zdGFuY2VzIHdoZXJl
IHRoZSBwZW5kaW5nIEpvaW4gZGF0YSBpcyBmcmVlZA0KPiBpbnRvIGNhbGxpbmcgb25lIGZ1bmN0
aW9uIGZyZWVfcGVuZGluZ19qb2luX2NhbGwoKS4NCj4gDQo+IEFsc28sIGFkZCBjaGVja3MgZm9y
IE5VTEwgZGF0YSBpbiBjbGVhbnVwIGZ1bmN0aW9ucyBmb3Igc3RvcmFnZSwgYWdlbnQNCj4gYW5k
IHByb3Zpc2lvbmluZyBhY2NlcHRvci4NCj4gLS0tDQo+ICBtZXNoL2FnZW50LmMgICAgICAgICB8
ICAyICstDQo+ICBtZXNoL21lc2guYyAgICAgICAgICB8IDU5ICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBtZXNoL3Byb3YtYWNjZXB0b3IuYyB8ICA1ICsr
LS0NCj4gIG1lc2gvc3RvcmFnZS5jICAgICAgIHwgIDMgKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvYWdlbnQuYyBiL21lc2gvYWdlbnQuYw0KPiBpbmRleCBjNmZmMTE4MDIuLjg4YWQ4NGQ3OSAx
MDA2NDQNCj4gLS0tIGEvbWVzaC9hZ2VudC5jDQo+ICsrKyBiL21lc2gvYWdlbnQuYw0KPiBAQCAt
MjEwLDcgKzIxMCw3IEBAIHN0YXRpYyB2b2lkIGFnZW50X2ZyZWUodm9pZCAqYWdlbnRfZGF0YSkN
Cj4gIA0KPiAgdm9pZCBtZXNoX2FnZW50X3JlbW92ZShzdHJ1Y3QgbWVzaF9hZ2VudCAqYWdlbnQp
DQo+ICB7DQo+IC0JaWYgKCFsX3F1ZXVlX2ZpbmQoYWdlbnRzLCBzaW1wbGVfbWF0Y2gsIGFnZW50
KSkNCj4gKwlpZiAoIWFnZW50IHx8ICFsX3F1ZXVlX2ZpbmQoYWdlbnRzLCBzaW1wbGVfbWF0Y2gs
IGFnZW50KSkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+ICAJYWdlbnRfZnJlZShhZ2VudCk7DQo+IGRp
ZmYgLS1naXQgYS9tZXNoL21lc2guYyBiL21lc2gvbWVzaC5jDQo+IGluZGV4IDg5NzFmN2NjNC4u
YTFjMjZlNzdjIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2guYw0KPiArKysgYi9tZXNoL21lc2gu
Yw0KPiBAQCAtMzQ1LDYgKzM0NSwyOCBAQCBzdGF0aWMgdm9pZCBhdHRhY2hfZXhpdCh2b2lkICpk
YXRhKQ0KPiAgCWxfZnJlZShwZW5kaW5nKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZnJl
ZV9wZW5kaW5nX2pvaW5fY2FsbChib29sIGZhaWxlZCkNCj4gK3sNCj4gKwlpZiAoIWpvaW5fcGVu
ZGluZykNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKGpvaW5fcGVuZGluZy0+ZGlzY193YXRj
aCkNCj4gKwkJbF9kYnVzX3JlbW92ZV93YXRjaChkYnVzX2dldF9idXMoKSwNCj4gKwkJCQkJCWpv
aW5fcGVuZGluZy0+ZGlzY193YXRjaCk7DQo+ICsNCj4gKwlhY2NlcHRvcl9jYW5jZWwoJm1lc2gp
Ow0KPiArDQo+ICsJbWVzaF9hZ2VudF9yZW1vdmUoam9pbl9wZW5kaW5nLT5hZ2VudCk7DQo+ICsN
Cj4gKwlpZiAoZmFpbGVkKSB7DQo+ICsJCXN0b3JhZ2VfcmVtb3ZlX25vZGVfY29uZmlnKGpvaW5f
cGVuZGluZy0+bm9kZSk7DQo+ICsJCW5vZGVfZnJlZShqb2luX3BlbmRpbmctPm5vZGUpOw0KPiAr
CX0NCj4gKw0KPiArCWxfZnJlZShqb2luX3BlbmRpbmcpOw0KPiArCWpvaW5fcGVuZGluZyA9IE5V
TEw7DQo+ICt9DQo+ICsNCj4gIHZvaWQgbWVzaF9jbGVhbnVwKHZvaWQpDQo+ICB7DQo+ICAJc3Ry
dWN0IGxfZGJ1c19tZXNzYWdlICpyZXBseTsNCj4gQEAgLTM1MywxOSArMzc1LDEyIEBAIHZvaWQg
bWVzaF9jbGVhbnVwKHZvaWQpDQo+ICAJbWdtdF91bnJlZihtZ210X21lc2gpOw0KPiAgDQo+ICAJ
aWYgKGpvaW5fcGVuZGluZykgew0KPiArCQkvKiBUaGUgSm9pbigpIGNhbGwgZmFpbGVkIHNpbmNl
IGl0IGhhcyBub3QgYmVlbiBjb21wbGV0ZWQgKi8NCj4gIAkJcmVwbHkgPSBkYnVzX2Vycm9yKGpv
aW5fcGVuZGluZy0+bXNnLCBNRVNIX0VSUk9SX0ZBSUxFRCwNCj4gIAkJCQkJCQkiRmFpbGVkLiBF
eGl0aW5nIik7DQo+ICAJCWxfZGJ1c19zZW5kKGRidXNfZ2V0X2J1cygpLCByZXBseSk7DQo+ICAN
Cj4gLQkJaWYgKGpvaW5fcGVuZGluZy0+ZGlzY193YXRjaCkNCj4gLQkJCWxfZGJ1c19yZW1vdmVf
d2F0Y2goZGJ1c19nZXRfYnVzKCksDQo+IC0JCQkJCQlqb2luX3BlbmRpbmctPmRpc2Nfd2F0Y2gp
Ow0KPiAtDQo+IC0JCWlmIChqb2luX3BlbmRpbmctPm5vZGUpDQo+IC0JCQlub2RlX2ZyZWUoam9p
bl9wZW5kaW5nLT5ub2RlKTsNCj4gLQ0KPiAtCQlsX2ZyZWUoam9pbl9wZW5kaW5nKTsNCj4gLQkJ
am9pbl9wZW5kaW5nID0gTlVMTDsNCj4gKwkJZnJlZV9wZW5kaW5nX2pvaW5fY2FsbCh0cnVlKTsN
Cj4gIAl9DQo+ICANCj4gIAlsX3F1ZXVlX2Rlc3Ryb3koYXR0YWNoX3F1ZXVlLCBhdHRhY2hfZXhp
dCk7DQo+IEBAIC00MDQsMjYgKzQxOSw2IEBAIGNvbnN0IGNoYXIgKm1lc2hfc3RhdHVzX3N0cih1
aW50OF90IGVycikNCj4gIAl9DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGZyZWVfcGVuZGlu
Z19qb2luX2NhbGwoYm9vbCBmYWlsZWQpDQo+IC17DQo+IC0JaWYgKCFqb2luX3BlbmRpbmcpDQo+
IC0JCXJldHVybjsNCj4gLQ0KPiAtCWlmIChqb2luX3BlbmRpbmctPmRpc2Nfd2F0Y2gpDQo+IC0J
CWxfZGJ1c19yZW1vdmVfd2F0Y2goZGJ1c19nZXRfYnVzKCksDQo+IC0JCQkJCQlqb2luX3BlbmRp
bmctPmRpc2Nfd2F0Y2gpOw0KPiAtDQo+IC0JbWVzaF9hZ2VudF9yZW1vdmUoam9pbl9wZW5kaW5n
LT5hZ2VudCk7DQo+IC0NCj4gLQlpZiAoZmFpbGVkKSB7DQo+IC0JCXN0b3JhZ2VfcmVtb3ZlX25v
ZGVfY29uZmlnKGpvaW5fcGVuZGluZy0+bm9kZSk7DQo+IC0JCW1lc2hfYWdlbnRfcmVtb3ZlKGpv
aW5fcGVuZGluZy0+YWdlbnQpOw0KPiAtCX0NCj4gLQ0KPiAtCWxfZnJlZShqb2luX3BlbmRpbmcp
Ow0KPiAtCWpvaW5fcGVuZGluZyA9IE5VTEw7DQo+IC19DQo+IC0NCj4gIC8qIFRoaXMgaXMgYmVp
bmcgY2FsbGVkIGlmIHRoZSBhcHAgZXhpdHMgdW5leHBlY3RlZGx5ICovDQo+ICBzdGF0aWMgdm9p
ZCBwcm92X2Rpc2NfY2Ioc3RydWN0IGxfZGJ1cyAqYnVzLCB2b2lkICp1c2VyX2RhdGEpDQo+ICB7
DQo+IEBAIC00MzMsOCArNDI4LDYgQEAgc3RhdGljIHZvaWQgcHJvdl9kaXNjX2NiKHN0cnVjdCBs
X2RidXMgKmJ1cywgdm9pZCAqdXNlcl9kYXRhKQ0KPiAgCWlmIChqb2luX3BlbmRpbmctPm1zZykN
Cj4gIAkJbF9kYnVzX21lc3NhZ2VfdW5yZWYoam9pbl9wZW5kaW5nLT5tc2cpOw0KPiAgDQo+IC0J
YWNjZXB0b3JfY2FuY2VsKCZtZXNoKTsNCj4gLQ0KPiAgCWpvaW5fcGVuZGluZy0+ZGlzY193YXRj
aCA9IDA7DQo+ICANCj4gIAlmcmVlX3BlbmRpbmdfam9pbl9jYWxsKHRydWUpOw0KPiBAQCAtNTUz
LDkgKzU0Niw3IEBAIHN0YXRpYyB2b2lkIG5vZGVfaW5pdF9jYihzdHJ1Y3QgbWVzaF9ub2RlICpu
b2RlLCBzdHJ1Y3QgbWVzaF9hZ2VudCAqYWdlbnQpDQo+ICANCj4gIGZhaWw6DQo+ICAJbF9kYnVz
X3NlbmQoZGJ1c19nZXRfYnVzKCksIHJlcGx5KTsNCj4gLQltZXNoX2FnZW50X3JlbW92ZShqb2lu
X3BlbmRpbmctPmFnZW50KTsNCj4gLQlsX2ZyZWUoam9pbl9wZW5kaW5nKTsNCj4gLQlqb2luX3Bl
bmRpbmcgPSBOVUxMOw0KPiArCWZyZWVfcGVuZGluZ19qb2luX2NhbGwodHJ1ZSk7DQo+ICB9DQo+
ICANCj4gIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKmpvaW5fbmV0d29ya19jYWxsKHN0
cnVjdCBsX2RidXMgKmRidXMsDQo+IGRpZmYgLS1naXQgYS9tZXNoL3Byb3YtYWNjZXB0b3IuYyBi
L21lc2gvcHJvdi1hY2NlcHRvci5jDQo+IGluZGV4IGJhYTNjNGQzMC4uZDk4Mzk5MWQ0IDEwMDY0
NA0KPiAtLS0gYS9tZXNoL3Byb3YtYWNjZXB0b3IuYw0KPiArKysgYi9tZXNoL3Byb3YtYWNjZXB0
b3IuYw0KPiBAQCAtMTE4LDkgKzExOCwxMCBAQCBzdGF0aWMgc3RydWN0IG1lc2hfcHJvdl9hY2Nl
cHRvciAqcHJvdiA9IE5VTEw7DQo+ICANCj4gIHN0YXRpYyB2b2lkIGFjY2VwdG9yX2ZyZWUodm9p
ZCkNCj4gIHsNCj4gKwlpZiAoIXByb3YpDQo+ICsJCXJldHVybjsNCj4gIA0KPiAtCWlmIChwcm92
KQ0KPiAtCQlsX3RpbWVvdXRfcmVtb3ZlKHByb3YtPnRpbWVvdXQpOw0KPiArCWxfdGltZW91dF9y
ZW1vdmUocHJvdi0+dGltZW91dCk7DQo+ICANCj4gIAltZXNoX3NlbmRfY2FuY2VsKGJlY19maWx0
ZXIsIHNpemVvZihiZWNfZmlsdGVyKSk7DQo+ICAJbWVzaF9zZW5kX2NhbmNlbCgmcGt0X2ZpbHRl
ciwgc2l6ZW9mKHBrdF9maWx0ZXIpKTsNCj4gZGlmZiAtLWdpdCBhL21lc2gvc3RvcmFnZS5jIGIv
bWVzaC9zdG9yYWdlLmMNCj4gaW5kZXggNTdhZTg4YjM0Li4zYTY2MTRlYjIgMTAwNjQ0DQo+IC0t
LSBhL21lc2gvc3RvcmFnZS5jDQo+ICsrKyBiL21lc2gvc3RvcmFnZS5jDQo+IEBAIC01NzMsNiAr
NTczLDkgQEAgdm9pZCBzdG9yYWdlX3JlbW92ZV9ub2RlX2NvbmZpZyhzdHJ1Y3QgbWVzaF9ub2Rl
ICpub2RlKQ0KPiAgCXN0cnVjdCBqc29uX29iamVjdCAqam5vZGU7DQo+ICAJY29uc3QgY2hhciAq
ZGlyX25hbWU7DQo+ICANCj4gKwlpZiAoIW5vZGUpDQo+ICsJCXJldHVybjsNCj4gKw0KPiAgCWpu
b2RlID0gbm9kZV9qY29uZmlnX2dldChub2RlKTsNCj4gIAlpZiAoam5vZGUpDQo+ICAJCWpzb25f
b2JqZWN0X3B1dChqbm9kZSk7
