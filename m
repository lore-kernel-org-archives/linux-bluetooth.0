Return-Path: <SRS0=cKDh=UZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8151C48BD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98612214DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 17:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZRos (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:44:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:49367 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZRor (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jun 2019 13:44:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="183217688"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2019 10:44:46 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Jun 2019 10:44:46 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.90]) with mapi id 14.03.0439.000;
 Wed, 26 Jun 2019 10:44:46 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Modify check of the node directory name
 upon removal
Thread-Topic: [PATCH BlueZ 1/1] mesh: Modify check of the node directory
 name upon removal
Thread-Index: AQHVKrQZHNvrFjUvIkGB+yvjT7tpJqaurZ+A
Date:   Wed, 26 Jun 2019 17:44:46 +0000
Message-ID: <1561571085.22940.18.camel@intel.com>
References: <20190624174142.15920-1-inga.stotland@intel.com>
In-Reply-To: <20190624174142.15920-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.45.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <709EB7E45E45E143ABBAC26A33E33157@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzLg0KDQpPbiBNb24sIDIwMTktMDYtMjQgYXQgMTA6NDEgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgcmVtb3ZlcyBjaGVjayBmb3IgIm1lc2giIGFzIHRo
ZSBwYXJlbnQgZGlyZWN0b3J5IG5hbWUgYW5kLCBpbnN0ZWFkLA0KPiB2ZXJpZmllcyB0aGF0IHRo
ZSBub2RlIGNvbmZpZ3VyYXRpb24gZGlyZWN0b3J5IG5hbWUgaXMgdGhlIGhleGFkZWNpbWFsDQo+
IHN0cmluZyByZXByZXNlbnRhdGluZyB0aGUgbm9kZSdzIFVVSUQuDQo+IC0tLQ0KPiAgbWVzaC9z
dG9yYWdlLmMgfCAzOSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9tZXNoL3N0b3JhZ2UuYyBiL21lc2gvc3RvcmFnZS5jDQo+IGluZGV4IDFh
OTk0NWFhOC4uNTRjOTg1NTU5IDEwMDY0NA0KPiAtLS0gYS9tZXNoL3N0b3JhZ2UuYw0KPiArKysg
Yi9tZXNoL3N0b3JhZ2UuYw0KPiBAQCAtNTMsMjAgKzUzLDYgQEAgc3RhdGljIGNvbnN0IGNoYXIg
KmJha19leHQgPSAiLmJhayI7DQo+ICBzdGF0aWMgY29uc3QgY2hhciAqdG1wX2V4dCA9ICIudG1w
IjsNCj4gIHN0YXRpYyBjb25zdCBjaGFyICpzdG9yYWdlX2RpcjsNCj4gIA0KPiAtLyogVGhpcyBp
cyBhIHRocmVhZC1zYWZlIGFsd2F5cyBtYWxsb2NlZCB2ZXJzaW9uIG9mIGRpcm5hbWUgd2hpY2gg
d2lsbCB3b3JrDQo+IC0gKiByZWdhcmRsZXNzIG9mIHdoaWNoIHVuZGVybHlpbmcgZGlybmFtZSgp
IGltcGxlbWVudGF0aW9uIGlzIHVzZWQuDQo+IC0gKi8NCj4gLXN0YXRpYyBjaGFyICphbGxvY19k
aXJuYW1lKGNvbnN0IGNoYXIgKnBhdGgpDQo+IC17DQo+IC0JY2hhciAqdG1wID0gbF9zdHJkdXAo
cGF0aCk7DQo+IC0JY2hhciAqZGlyOw0KPiAtDQo+IC0JZGlyID0gZGlybmFtZSh0bXApOw0KPiAt
CXN0cm5jcHkodG1wLCBkaXIsIHN0cmxlbihwYXRoKSArIDEpOw0KPiAtDQo+IC0JcmV0dXJuIHRt
cDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGJvb2wgcmVhZF9ub2RlX2NiKHN0cnVjdCBtZXNoX2Ri
X25vZGUgKmRiX25vZGUsIHZvaWQgKnVzZXJfZGF0YSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbWVzaF9u
b2RlICpub2RlID0gdXNlcl9kYXRhOw0KPiBAQCAtNDg2LDIwICs0NzIsMjAgQEAgdm9pZCBzdG9y
YWdlX3NhdmVfY29uZmlnKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIGJvb2wgbm9fd2FpdCwNCj4g
IAkJbF9pZGxlX29uZXNob3QoaWRsZV9zYXZlX2NvbmZpZywgaW5mbywgTlVMTCk7DQo+ICB9DQo+
ICANCj4gLXN0YXRpYyBpbnQgY3JlYXRlX2Rpcihjb25zdCBjaGFyICpkaXJuYW1lKQ0KPiArc3Rh
dGljIGludCBjcmVhdGVfZGlyKGNvbnN0IGNoYXIgKmRpcl9uYW1lKQ0KPiAgew0KPiAgCXN0cnVj
dCBzdGF0IHN0Ow0KPiAgCWNoYXIgZGlyW1BBVEhfTUFYICsgMV0sICpwcmV2LCAqbmV4dDsNCj4g
IAlpbnQgZXJyOw0KPiAgDQo+IC0JZXJyID0gc3RhdChkaXJuYW1lLCAmc3QpOw0KPiArCWVyciA9
IHN0YXQoZGlyX25hbWUsICZzdCk7DQo+ICAJaWYgKCFlcnIgJiYgU19JU1JFRyhzdC5zdF9tb2Rl
KSkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gIAltZW1zZXQoZGlyLCAwLCBQQVRIX01BWCArIDEp
Ow0KPiAgCXN0cmNhdChkaXIsICIvIik7DQo+ICANCj4gLQlwcmV2ID0gc3RyY2hyKGRpcm5hbWUs
ICcvJyk7DQo+ICsJcHJldiA9IHN0cmNocihkaXJfbmFtZSwgJy8nKTsNCj4gIA0KPiAgCXdoaWxl
IChwcmV2KSB7DQo+ICAJCW5leHQgPSBzdHJjaHIocHJldiArIDEsICcvJyk7DQo+IEBAIC01MTcs
NyArNTAzLDcgQEAgc3RhdGljIGludCBjcmVhdGVfZGlyKGNvbnN0IGNoYXIgKmRpcm5hbWUpDQo+
ICAJCXByZXYgPSBuZXh0Ow0KPiAgCX0NCj4gIA0KPiAtCW1rZGlyKGRpcm5hbWUsIDA3NTUpOw0K
PiArCW1rZGlyKGRpcl9uYW1lLCAwNzU1KTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiBA
QCAtNjQwLDcgKzYyNiw4IEBAIHN0YXRpYyBpbnQgZGVsX2ZvYmplY3QoY29uc3QgY2hhciAqZnBh
dGgsIGNvbnN0IHN0cnVjdCBzdGF0ICpzYiwgaW50IHR5cGVmbGFnLA0KPiAgLyogUGVybWFuZW50
bHkgcmVtb3ZlIG5vZGUgY29uZmlndXJhdGlvbiAqLw0KPiAgdm9pZCBzdG9yYWdlX3JlbW92ZV9u
b2RlX2NvbmZpZyhzdHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiAgew0KPiAtCWNoYXIgKm5vZGVf
cGF0aCwgKm1lc2hfcGF0aCwgKm1lc2hfbmFtZTsNCj4gKwljaGFyICpub2RlX3BhdGgsICpub2Rl
X25hbWU7DQo+ICsJY2hhciB1dWlkWzMzXTsNCj4gIAlzdHJ1Y3QganNvbl9vYmplY3QgKmpub2Rl
Ow0KPiAgDQo+ICAJaWYgKCFub2RlKQ0KPiBAQCAtNjU2LDEzICs2NDMsMTMgQEAgdm9pZCBzdG9y
YWdlX3JlbW92ZV9ub2RlX2NvbmZpZyhzdHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiAgCWxfZGVi
dWcoIkRlbGV0ZSBub2RlIGNvbmZpZyAlcyIsIG5vZGVfcGF0aCk7DQo+ICANCj4gIAkvKiBNYWtl
IHN1cmUgcGF0aCBuYW1lIG9mIG5vZGUgZm9sbG93cyBleHBlY3RlZCBndWlkZWxpbmVzICovDQo+
IC0JbWVzaF9wYXRoID0gYWxsb2NfZGlybmFtZShub2RlX3BhdGgpOw0KPiAtCW1lc2hfbmFtZSA9
IGJhc2VuYW1lKG1lc2hfcGF0aCk7DQo+IC0JaWYgKHN0cmNtcChtZXNoX25hbWUsICJtZXNoIikp
DQo+IC0JCWdvdG8gZG9uZTsNCj4gKwlpZiAoIWhleDJzdHIobm9kZV91dWlkX2dldChub2RlKSwg
MTYsIHV1aWQsIHNpemVvZih1dWlkKSkpDQo+ICsJCXJldHVybjsNCj4gIA0KPiAtCW5mdHcobm9k
ZV9wYXRoLCBkZWxfZm9iamVjdCwgNSwgRlRXX0RFUFRIIHwgRlRXX1BIWVMpOw0KPiArCW5vZGVf
bmFtZSA9IGJhc2VuYW1lKG5vZGVfcGF0aCk7DQo+ICANCj4gLWRvbmU6DQo+IC0JbF9mcmVlKG1l
c2hfcGF0aCk7DQo+ICsJaWYgKHN0cmNtcChub2RlX25hbWUsIHV1aWQpKQ0KPiArCQlyZXR1cm47
DQo+ICsNCj4gKwluZnR3KG5vZGVfcGF0aCwgZGVsX2ZvYmplY3QsIDUsIEZUV19ERVBUSCB8IEZU
V19QSFlTKTsNCj4gIH0=
