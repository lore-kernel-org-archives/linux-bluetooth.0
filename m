Return-Path: <SRS0=yUSv=W4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00058C3A5A4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AB521897
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfIAPq4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:46:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:46378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfIAPq4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Sep 2019 11:46:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2019 08:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,455,1559545200"; 
   d="scan'208";a="333358189"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2019 08:46:55 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0439.000;
 Sun, 1 Sep 2019 08:46:54 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: test AEAD at startup to check kernel
 support
Thread-Topic: [PATCH BlueZ v2] mesh: test AEAD at startup to check kernel
 support
Thread-Index: AQHVX2dPD80gpH0rfEOtheH/X9EA2acXb32A
Date:   Sun, 1 Sep 2019 15:46:54 +0000
Message-ID: <86098e6b6bef7eac124d805c4cf882ebd4c2f809.camel@intel.com>
References: <20190830191527.15962-1-brian.gix@intel.com>
In-Reply-To: <20190830191527.15962-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.229.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FD63B011197AC4F89798E0BC5BD852E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZC4NCg0KT24gRnJpLCAyMDE5LTA4LTMwIGF0IDEyOjE1IC0wNzAwLCBCcmlhbiBHaXgg
d3JvdGU6DQo+IE9uZSB0aW1lIHRlc3QgYXQgc3RhcnR1cCB0byBlbnN1cmUgZWl0aGVyIGtlcm5l
bCB2ZXJzaW9uIHY0Ljkgb3IgbGF0ZXIsDQo+ICpvciogdGhhdCByZXF1aXJlZCBBRVMtQ0NNIHN1
cHBvcnQgaGFzIGJlZW4gYmFjay1wb3J0ZWQuIElmIHN1cHBvcnQgbm90DQo+IHRoZXJlLCBkYWVt
b24gd2lsbCBydW4gd2l0aG91dCBwcm92aWRpbmcgRC1CdXMgc2VydmljZSBvciBhdHRhY2hpbmcg
dG8NCj4gY29udHJvbGxlcnMgKHByZXZlbnRzIHN5c3RlbWQgdGhyYXNoaW5nKS4NCj4gLS0tDQo+
ICBtZXNoL2NyeXB0by5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICBtZXNoL2NyeXB0by5oIHwgIDEgKw0KPiAgbWVzaC9tYWluLmMg
ICB8ICA3ICsrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc2gvY3J5cHRvLmMgYi9tZXNoL2NyeXB0by5jDQo+IGluZGV4IGE2
ZGM3ZmZlMi4uY2ViZGZmZTQ1IDEwMDY0NA0KPiAtLS0gYS9tZXNoL2NyeXB0by5jDQo+ICsrKyBi
L21lc2gvY3J5cHRvLmMNCj4gQEAgLTExMzAsMyArMTEzMCw1NyBAQCBib29sIG1lc2hfY3J5cHRv
X2NoZWNrX2Zjcyhjb25zdCB1aW50OF90ICpwYWNrZXQsIHVpbnQ4X3QgcGFja2V0X2xlbiwNCj4g
IA0KPiAgCXJldHVybiBmY3MgPT0gMHhjZjsNCj4gIH0NCj4gKw0KPiArLyogVGhpcyBmdW5jdGlv
biBwZXJmb3JtcyBhIHF1aWNrLWNoZWNrIG9mIEVMTCBhbmQgS2VybmVsIEFFQUQgZW5jcnlwdGlv
bi4NCj4gKyAqIFNvbWUga2VybmVsIHZlcnNpb25zIGJlZm9yZSB2NC45IGhhdmUgYSBrbm93biBB
RUFEIGJ1Zy4gSWYgdGhlIHN5c3RlbQ0KPiArICogcnVubmluZyB0aGlzIHRlc3QgaXMgdXNpbmcg
YSB2NC44IG9yIGVhcmxpZXIga2VybmVsLCBhIGZhaWx1cmUgaGVyZSBpcw0KPiArICogbGlrZWx5
IHVubGVzcyBBRUFEIGVuY3J5cHRpb24gaGFzIGJlZW4gYmFja3BvcnRlZC4NCj4gKyAqLw0KPiAr
c3RhdGljIGNvbnN0IHVpbnQ4X3QgY3J5cHRvX3Rlc3RfcmVzdWx0W10gPSB7DQo+ICsJMHg3NSwg
MHgwMywgMHg3ZSwgMHhlMiwgMHg4OSwgMHg4MSwgMHhiZSwgMHg1OSwNCj4gKwkweGJjLCAweGU2
LCAweGRkLCAweDIzLCAweDYzLCAweDViLCAweDE2LCAweDYxLA0KPiArCTB4YjcsIDB4MjMsIDB4
OTIsIDB4ZDQsIDB4ODYsIDB4ZWUsIDB4ODQsIDB4MjksDQo+ICsJMHg5YSwgMHgyYSwgMHhiZiwg
MHg5Ng0KPiArfTsNCj4gKw0KPiArYm9vbCBtZXNoX2NyeXB0b19jaGVja19hdmFpbCgpDQo+ICt7
DQo+ICsJdm9pZCAqY2lwaGVyOw0KPiArCWJvb2wgcmVzdWx0Ow0KPiArCXVpbnQ4X3QgaTsNCj4g
Kwl1bmlvbiB7DQo+ICsJCXN0cnVjdCB7DQo+ICsJCQl1aW50OF90IGtleVsxNl07DQo+ICsJCQl1
aW50OF90IGFhZFsxNl07DQo+ICsJCQl1aW50OF90IG5vbmNlWzEzXTsNCj4gKwkJCXVpbnQ4X3Qg
ZGF0YVsyMF07DQo+ICsJCQl1aW50OF90IG1pY1s4XTsNCj4gKwkJfSBjcnlwdG87DQo+ICsJCXVp
bnQ4X3QgYnl0ZXNbMF07DQo+ICsJfSB1Ow0KPiArCXVpbnQ4X3Qgb3V0X21zZ1tzaXplb2YodS5j
cnlwdG8uZGF0YSkgKyBzaXplb2YodS5jcnlwdG8ubWljKV07DQo+ICsNCj4gKwlsX2RlYnVnKCJU
ZXN0aW5nIENyeXB0byIpOw0KPiArCWZvciAoaSA9IDA7IGkgPCBzaXplb2YodSk7IGkrKykgew0K
PiArCQl1LmJ5dGVzW2ldID0gMHg2MCArIGk7DQo+ICsJfQ0KPiArDQo+ICsJY2lwaGVyID0gbF9h
ZWFkX2NpcGhlcl9uZXcoTF9BRUFEX0NJUEhFUl9BRVNfQ0NNLCB1LmNyeXB0by5rZXksDQo+ICsJ
CQkJc2l6ZW9mKHUuY3J5cHRvLmtleSksIHNpemVvZih1LmNyeXB0by5taWMpKTsNCj4gKw0KPiAr
CWlmICghY2lwaGVyKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlyZXN1bHQgPSBsX2Fl
YWRfY2lwaGVyX2VuY3J5cHQoY2lwaGVyLA0KPiArCQkJCXUuY3J5cHRvLmRhdGEsIHNpemVvZih1
LmNyeXB0by5kYXRhKSwNCj4gKwkJCQl1LmNyeXB0by5hYWQsIHNpemVvZih1LmNyeXB0by5hYWQp
LA0KPiArCQkJCXUuY3J5cHRvLm5vbmNlLCBzaXplb2YodS5jcnlwdG8ubm9uY2UpLA0KPiArCQkJ
CW91dF9tc2csIHNpemVvZihvdXRfbXNnKSk7DQo+ICsNCj4gKwlpZiAocmVzdWx0KQ0KPiArCQly
ZXN1bHQgPSAhbWVtY21wKG91dF9tc2csIGNyeXB0b190ZXN0X3Jlc3VsdCwgc2l6ZW9mKG91dF9t
c2cpKTsNCj4gKw0KPiArCWxfYWVhZF9jaXBoZXJfZnJlZShjaXBoZXIpOw0KPiArDQo+ICsJcmV0
dXJuIHJlc3VsdDsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL21lc2gvY3J5cHRvLmggYi9tZXNoL2Ny
eXB0by5oDQo+IGluZGV4IDFhNzNiY2FhMy4uZTVjZTg0MGI0IDEwMDY0NA0KPiAtLS0gYS9tZXNo
L2NyeXB0by5oDQo+ICsrKyBiL21lc2gvY3J5cHRvLmgNCj4gQEAgLTE2MSwzICsxNjEsNCBAQCBi
b29sIG1lc2hfY3J5cHRvX2NoZWNrX2Zjcyhjb25zdCB1aW50OF90ICpwYWNrZXQsIHVpbnQ4X3Qg
cGFja2V0X2xlbiwNCj4gIAkJCQkJCQl1aW50OF90IHJlY2VpdmVkX2Zjcyk7DQo+ICBib29sIG1l
c2hfY3J5cHRvX2Flc19jbWFjKGNvbnN0IHVpbnQ4X3Qga2V5WzE2XSwgY29uc3QgdWludDhfdCAq
bXNnLA0KPiAgCQkJCQlzaXplX3QgbXNnX2xlbiwgdWludDhfdCByZXNbMTZdKTsNCj4gK2Jvb2wg
bWVzaF9jcnlwdG9fY2hlY2tfYXZhaWwodm9pZCk7DQo+IGRpZmYgLS1naXQgYS9tZXNoL21haW4u
YyBiL21lc2gvbWFpbi5jDQo+IGluZGV4IDI2MmUzZGE0OC4uMjczNjUxZjk3IDEwMDY0NA0KPiAt
LS0gYS9tZXNoL21haW4uYw0KPiArKysgYi9tZXNoL21haW4uYw0KPiBAQCAtMzQsNiArMzQsNyBA
QA0KPiAgI2luY2x1ZGUgImxpYi9tZ210LmgiDQo+ICANCj4gICNpbmNsdWRlICJtZXNoL21lc2gu
aCINCj4gKyNpbmNsdWRlICJtZXNoL2NyeXB0by5oIg0KPiAgI2luY2x1ZGUgIm1lc2gvZGJ1cy5o
Ig0KPiAgI2luY2x1ZGUgIm1lc2gvbWVzaC1pby5oIg0KPiAgDQo+IEBAIC0xMjEsNiArMTIyLDEy
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICANCj4gIAlsX2xvZ19zZXRf
c3RkZXJyKCk7DQo+ICANCj4gKwlpZiAoIW1lc2hfY3J5cHRvX2NoZWNrX2F2YWlsKCkpIHsNCj4g
KwkJbF9lcnJvcigiTWVzaCBDcnlwdG8gZnVuY3Rpb25zIHVuYXZhaWxhYmxlIik7DQo+ICsJCXN0
YXR1cyA9IGxfbWFpbl9ydW5fd2l0aF9zaWduYWwoc2lnbmFsX2hhbmRsZXIsIE5VTEwpOw0KPiAr
CQlnb3RvIGRvbmU7DQo+ICsJfQ0KPiArDQo+ICAJZm9yICg7Oykgew0KPiAgCQlpbnQgb3B0Ow0K
PiAgCQljb25zdCBjaGFyICpzdHI7DQo=
