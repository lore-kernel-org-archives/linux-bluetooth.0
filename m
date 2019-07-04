Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7571C5B578
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9494C218A0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 00:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfGDAQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:16:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:63746 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfGDAQl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 20:16:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 17:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="247792369"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2019 17:16:40 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jul 2019 17:16:40 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.237]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 17:16:40 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix clean up of node's DBUS assosiated
 resources
Thread-Topic: [PATCH BlueZ] mesh: Fix clean up of node's DBUS assosiated
 resources
Thread-Index: AQHVMfOMn7/f5crSdUyoyl/ZdJKo76a6DO8A
Date:   Thu, 4 Jul 2019 00:16:39 +0000
Message-ID: <1562199398.23933.40.camel@intel.com>
References: <20190703230244.20229-1-inga.stotland@intel.com>
In-Reply-To: <20190703230244.20229-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.20.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E61CB77A81B4774CA97CB902CA80C226@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBbcGxpZWQNCg0KT24gV2VkLCAyMDE5LTA3LTAzIGF0IDE2OjAyIC0wNzAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBUaGlzIGNvbnNvbGlkYXRlcyBtdWx0aXBsZSBwbGFjZXMgd2hlcmUgbm9k
ZSdzIG9iamVjdCBwYXRocywNCj4gaW50ZXJmYWNlcywgZXRjLiBhcmUgZGUtYWxsb2NhdGVkLCBp
bnRvIG9uZSByb3V0aW5lOg0KPiBmcmVlX25vZGVfZGJ1c19yZXNvdXJjZXMoKS4NCj4gVGhpcyBh
bHNvIGFkZHJlc3NlcyBtZW1vcnkgbGVha3MgYXNzb3NpYXRlZCB3aXRoIGluY29uc2lzdGVudCBm
cmVlaW5nDQo+IG9mIG9iamVjdCBwYXRoIHN0cmluZ3MuDQo+IC0tLQ0KPiAgbWVzaC9ub2RlLmMg
fCA2NiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbm9kZS5jIGIvbWVzaC9ub2RlLmMNCj4gaW5kZXggYWRj
MmFhOTNlLi42N2UwZGQwMTQgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbm9kZS5jDQo+ICsrKyBiL21l
c2gvbm9kZS5jDQo+IEBAIC0yMjYsMzQgKzIyNiw0NiBAQCBzdGF0aWMgdm9pZCBlbGVtZW50X2Zy
ZWUodm9pZCAqZGF0YSkNCj4gIAlsX2ZyZWUoZWxlbWVudCk7DQo+ICB9DQo+ICANCj4gLXN0YXRp
YyB2b2lkIGZyZWVfbm9kZV9yZXNvdXJjZXModm9pZCAqZGF0YSkNCj4gK3N0YXRpYyB2b2lkIGZy
ZWVfbm9kZV9kYnVzX3Jlc291cmNlcyhzdHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiAgew0KPiAt
CXN0cnVjdCBtZXNoX25vZGUgKm5vZGUgPSBkYXRhOw0KPiArCWlmICghbm9kZSkNCj4gKwkJcmV0
dXJuOw0KPiAgDQo+IC0JLyogVW5yZWdpc3RlciBpbyBjYWxsYmFja3MgKi8NCj4gLQlpZiAobm9k
ZS0+bmV0KQ0KPiAtCQltZXNoX25ldF9kZXRhY2gobm9kZS0+bmV0KTsNCj4gLQltZXNoX25ldF9m
cmVlKG5vZGUtPm5ldCk7DQo+ICsJaWYgKG5vZGUtPmRpc2Nfd2F0Y2gpIHsNCj4gKwkJbF9kYnVz
X3JlbW92ZV93YXRjaChkYnVzX2dldF9idXMoKSwgbm9kZS0+ZGlzY193YXRjaCk7DQo+ICsJCW5v
ZGUtPmRpc2Nfd2F0Y2ggPSAwOw0KPiArCX0NCj4gIA0KPiAtCWxfcXVldWVfZGVzdHJveShub2Rl
LT5lbGVtZW50cywgZWxlbWVudF9mcmVlKTsNCj4gLQlsX2ZyZWUobm9kZS0+Y29tcCk7DQo+IC0J
bF9mcmVlKG5vZGUtPmFwcF9wYXRoKTsNCj4gKwlsX3F1ZXVlX2ZvcmVhY2gobm9kZS0+ZWxlbWVu
dHMsIGZyZWVfZWxlbWVudF9wYXRoLCBOVUxMKTsNCj4gIAlsX2ZyZWUobm9kZS0+b3duZXIpOw0K
PiAtCWxfZnJlZShub2RlLT5ub2RlX3BhdGgpOw0KPiAtDQo+IC0JaWYgKG5vZGUtPmRpc2Nfd2F0
Y2gpDQo+IC0JCWxfZGJ1c19yZW1vdmVfd2F0Y2goZGJ1c19nZXRfYnVzKCksIG5vZGUtPmRpc2Nf
d2F0Y2gpOw0KPiArCW5vZGUtPm93bmVyID0gTlVMTDsNCj4gKwlsX2ZyZWUobm9kZS0+YXBwX3Bh
dGgpOw0KPiArCW5vZGUtPmFwcF9wYXRoID0gTlVMTDsNCj4gIA0KPiAgCWlmIChub2RlLT5wYXRo
KSB7DQo+ICAJCWxfZGJ1c19vYmplY3RfcmVtb3ZlX2ludGVyZmFjZShkYnVzX2dldF9idXMoKSwg
bm9kZS0+cGF0aCwNCj4gIAkJCQkJCQlNRVNIX05PREVfSU5URVJGQUNFKTsNCj4gIA0KPiAgCQls
X2RidXNfb2JqZWN0X3JlbW92ZV9pbnRlcmZhY2UoZGJ1c19nZXRfYnVzKCksIG5vZGUtPnBhdGgs
DQo+IC0JCQkJCSAgICAgICBNRVNIX01BTkFHRU1FTlRfSU5URVJGQUNFKTsNCj4gKwkJCQkJCU1F
U0hfTUFOQUdFTUVOVF9JTlRFUkZBQ0UpOw0KPiArCQlsX2ZyZWUobm9kZS0+cGF0aCk7DQo+ICsJ
CW5vZGUtPnBhdGggPSBOVUxMOw0KPiAgCX0NCj4gK30NCj4gIA0KPiAtCWxfZnJlZShub2RlLT5w
YXRoKTsNCj4gK3N0YXRpYyB2b2lkIGZyZWVfbm9kZV9yZXNvdXJjZXModm9pZCAqZGF0YSkNCj4g
K3sNCj4gKwlzdHJ1Y3QgbWVzaF9ub2RlICpub2RlID0gZGF0YTsNCj4gIA0KPiArCS8qIFVucmVn
aXN0ZXIgaW8gY2FsbGJhY2tzICovDQo+ICsJaWYgKG5vZGUtPm5ldCkNCj4gKwkJbWVzaF9uZXRf
ZGV0YWNoKG5vZGUtPm5ldCk7DQo+ICsJbWVzaF9uZXRfZnJlZShub2RlLT5uZXQpOw0KPiArDQo+
ICsJbF9xdWV1ZV9kZXN0cm95KG5vZGUtPmVsZW1lbnRzLCBlbGVtZW50X2ZyZWUpOw0KPiArCWxf
ZnJlZShub2RlLT5jb21wKTsNCj4gKw0KPiArCWZyZWVfbm9kZV9kYnVzX3Jlc291cmNlcyhub2Rl
KTsNCj4gIAlsX2ZyZWUobm9kZSk7DQo+ICB9DQo+ICANCj4gQEAgLTEwMzMsMjQgKzEwNDUsOSBA
QCBzdGF0aWMgdm9pZCBhcHBfZGlzY19jYihzdHJ1Y3QgbF9kYnVzICpidXMsIHZvaWQgKnVzZXJf
ZGF0YSkNCj4gIAlsX2luZm8oIkFwcCAlcyBkaXNjb25uZWN0ZWQgKCV1KSIsIG5vZGUtPm93bmVy
LCBub2RlLT5kaXNjX3dhdGNoKTsNCj4gIA0KPiAgCW5vZGUtPmRpc2Nfd2F0Y2ggPSAwOw0KPiAt
DQo+IC0JbF9xdWV1ZV9mb3JlYWNoKG5vZGUtPmVsZW1lbnRzLCBmcmVlX2VsZW1lbnRfcGF0aCwg
TlVMTCk7DQo+IC0NCj4gLQlsX2ZyZWUobm9kZS0+b3duZXIpOw0KPiAtCW5vZGUtPm93bmVyID0g
TlVMTDsNCj4gLQ0KPiAtCWlmIChub2RlLT5wYXRoKSB7DQo+IC0JCWxfZGJ1c19vYmplY3RfcmVt
b3ZlX2ludGVyZmFjZShkYnVzX2dldF9idXMoKSwgbm9kZS0+cGF0aCwNCj4gLQkJCQkJCQlNRVNI
X05PREVfSU5URVJGQUNFKTsNCj4gLQ0KPiAtCQlsX2RidXNfb2JqZWN0X3JlbW92ZV9pbnRlcmZh
Y2UoZGJ1c19nZXRfYnVzKCksIG5vZGUtPnBhdGgsDQo+IC0JCQkJCQlNRVNIX01BTkFHRU1FTlRf
SU5URVJGQUNFKTsNCj4gLQkJbF9mcmVlKG5vZGUtPmFwcF9wYXRoKTsNCj4gLQkJbm9kZS0+YXBw
X3BhdGggPSBOVUxMOw0KPiAtCX0NCj4gKwlmcmVlX25vZGVfZGJ1c19yZXNvdXJjZXMobm9kZSk7
DQo+ICB9DQo+ICANCj4gLQ0KPiAgc3RhdGljIGJvb2wgdmFsaWRhdGVfbW9kZWxfcHJvcGVydHko
c3RydWN0IG5vZGVfZWxlbWVudCAqZWxlLA0KPiAgCQkJCQlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2Vf
aXRlciAqcHJvcGVydHksDQo+ICAJCQkJCXVpbnQ4X3QgKm51bV9tb2RlbHMsIGJvb2wgdmVuZG9y
KQ0KPiBAQCAtMTYxMSwxNCArMTYwOCw5IEBAIGZhaWw6DQo+ICAJCS8qIEhhbmRsZSBmYWlsZWQg
QXR0YWNoIHJlcXVlc3QgKi8NCj4gIAkJbm9kZV9yZWFkeV9mdW5jX3QgY2IgPSByZXEtPmNiOw0K
PiAgDQo+IC0JCWxfcXVldWVfZm9yZWFjaChub2RlLT5lbGVtZW50cywgZnJlZV9lbGVtZW50X3Bh
dGgsIE5VTEwpOw0KPiAtCQlsX2ZyZWUobm9kZS0+YXBwX3BhdGgpOw0KPiAtCQlub2RlLT5hcHBf
cGF0aCA9IE5VTEw7DQo+ICsJCWZyZWVfbm9kZV9kYnVzX3Jlc291cmNlcyhub2RlKTsNCj4gIA0K
PiAtCQlsX2ZyZWUobm9kZS0+b3duZXIpOw0KPiAtCQlub2RlLT5vd25lciA9IE5VTEw7DQo+ICAJ
CWNiKHJlcS0+dXNlcl9kYXRhLCBNRVNIX0VSUk9SX0ZBSUxFRCwgbm9kZSk7DQo+IC0NCj4gIAl9
IGVsc2Ugew0KPiAgCQkvKiBIYW5kbGUgZmFpbGVkIEpvaW4gYW5kIENyZWF0ZSByZXF1ZXN0cyAq
Lw0KPiAgCQlpZiAobm9kZSk=
