Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F8FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 04:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E5761076
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 04:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhHZEcf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 00:32:35 -0400
Received: from mx01.fronius.com ([85.31.3.78]:59376 "EHLO mx01.fronius.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237999AbhHZEce (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 00:32:34 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 00:32:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=fronius.com; s=s1;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TAPpeROFhLb9YvR0K6JZhc/qMFLPBUmJjigf2/qX8cU=;
  b=DSYIczZhyMIIPNC9q0jgmzkyLjWrrTS9FWA3UJX4zK1+19yJjTWtLgmN
   YTAyiK8U625urCn/G4IkElC2LMc/4btaq7B9kKt7eEu5E1NxAnq8SnPIZ
   +cAosHZLPGmnT3FZjsmZCOIT+lSD6JPmlqUwk4ZxcwyswAnhik/40y08q
   E=;
Authentication-Results: mx01.fronius.com; dkim=none (message not signed) header.i=none
IronPort-SDR: fctE3+pfT+H6tmwyrm5xy3Cq2UmYFkaKxXbt2OEw4j2JbIFET/m4tynKiQne+AIM0nV9Ve1blw
 vhVf6RbvqkTw==
IronPort-HdrOrdr: A9a23:5K3IKqkw8OqVc9qIDwHRTxysVNDpDfII3DAbv31ZSRFFG/Fwz/
 re+8jy1XfP5wr5K0tQ/+xoX5PwPE80lKQFm7X5Uo3SPzUO1FHEEGgm1/qH/9SCIVyDygc+79
 YDT0EWMrSZZjJHZITBkWyF+r0bruVvhZrJuQ6o9RZQpG9RB52IpD0JczpzWncGPDWuK6BJb6
 ah2g==
X-IronPort-AV: E=Sophos;i="5.84,352,1620684000"; 
   d="scan'208";a="45051871"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from unknown (HELO AT-ESXVM-613.fronius.com) ([10.2.6.13])
  by mx01.fronius.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2021 06:24:32 +0200
Received: from AT-ESXVM-612.fronius.com (10.2.6.12) by
 AT-ESXVM-613.fronius.com (10.2.6.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 26 Aug 2021 06:24:32 +0200
Received: from AT-ESXVM-612.fronius.com ([fe80::b877:544f:b560:3fa4]) by
 AT-ESXVM-612.fronius.com ([fe80::b877:544f:b560:3fa4%5]) with mapi id
 15.01.2176.014; Thu, 26 Aug 2021 06:24:32 +0200
From:   Eisenkolb Thomas <Eisenkolb.Thomas@fronius.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        David Lechner <david@lechnology.com>
Subject: AW: [PATCH BlueZ v2 1/2] device: clear eir_uuids list on disconnect
Thread-Topic: [PATCH BlueZ v2 1/2] device: clear eir_uuids list on disconnect
Thread-Index: AQHXmdGKvP68LPNXxUOjoqbQLOuJ+auEp3eAgACFxEA=
Date:   Thu, 26 Aug 2021 04:24:32 +0000
Message-ID: <c74ad033ff8240f8a77b00c6f8f678a0@fronius.com>
References: <20210825165125.2675544-1-david@lechnology.com>
 <20210825165125.2675544-2-david@lechnology.com>
 <CABBYNZJzTmpvcaw5eDa9awvVZYQdJuKW7EQSYfpMOCzhorP8cg@mail.gmail.com>
In-Reply-To: <CABBYNZJzTmpvcaw5eDa9awvVZYQdJuKW7EQSYfpMOCzhorP8cg@mail.gmail.com>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.25.111]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGVsbG8sDQoNCkkgaGF2ZSBqdXN0IGZvdW5kIHRoZSBzYW1lIHByb2JsZW0gZXZlbiBpZiBbR0FU
VF0gQ2FjaGUgPSBubyBpcyBzZXQgaW4gbWFpbi5jb25mLg0KSXQgaXMgc2ltcGx5IHRoZSBzYW1l
IGJlY2F1c2UgdGhlIGRldmljZSBpcyBoZWxkIGFzIHRlbXBvcmFyeSBkZXZpY2UuDQoNCkFkZGl0
aW9uYWxseSB0aGUgbWV0aG9kICJkZXZfcHJvcGVydHlfZ2V0X3V1aWRzIiBpbiBkZXZpY2UuYyBv
bmx5IHJldHVybnMgVVVJRHMgb2YgDQp0aGUgY2FjaGVkICh0ZW1wb3JhcnkgaG9sZCkgZGV2aWNl
IGJlY2F1c2UgZGV2LT5sZV9zdGF0ZS5zdmNfcmVzb2x2ZWQgaXMgbm90IHR1cm5lZCANCnRvIGZh
bHNlIG9uIGRpc2Nvbm5lY3QuIFNvIGlmIGEgZGlzY29ubmVjdGVkIGRldmljZSBhZHZlcnRpc2Vk
IGFuIG5ldyBVVUlELCB5b3UgbmV2ZXINCmdldCBub3RpZmllZCBhYm91dCBpdCB0aHJvdWdoIGRi
dXMuDQoNClRocm91Z2ggREJ1cyBkZXZpY2Ugbm9kZSBJIHdvdWxkIGV4cGVjdCB0byBnZXQgYm90
aCBVVUlEIGxpc3RzLiBUaGUgY2FjaGVkIG9uZXMgYW5kIA0KYWxzbyB0aGUgYWR2ZXJ0aXNlZCBv
bmVzLg0KQWN0dWFsbHkgSSBqdXN0IG1lcmdlIHRoZSB0d28gbGlzdHMgYW5kIHByb3ZpZGUgdGhl
IHJlc3VsdCB0byBEQnVzIGRldmljZS0+VVVJRHMgcmVxdWVzdC4NCg0KSG9wZSB5b3UgY2FuIGNo
YW5nZSB0aGlzLg0KDQpUaGFua3MuDQoNClRob21hcw0KDQotLS0tLVVyc3Byw7xuZ2xpY2hlIE5h
Y2hyaWNodC0tLS0tDQpWb246IEx1aXogQXVndXN0byB2b24gRGVudHogW21haWx0bzpsdWl6LmRl
bnR6QGdtYWlsLmNvbV0gDQpHZXNlbmRldDogRG9ubmVyc3RhZywgMjYuIEF1Z3VzdCAyMDIxIDAw
OjEzDQpBbjogRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5jb20+DQpDYzogbGludXgt
Ymx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KQmV0cmVmZjogUmU6IFtQQVRDSCBCbHVlWiB2MiAx
LzJdIGRldmljZTogY2xlYXIgZWlyX3V1aWRzIGxpc3Qgb24gZGlzY29ubmVjdA0KDQpIaSBEYXZp
ZCwNCg0KT24gV2VkLCBBdWcgMjUsIDIwMjEgYXQgOTo1NCBBTSBEYXZpZCBMZWNobmVyIDxkYXZp
ZEBsZWNobm9sb2d5LmNvbT4gd3JvdGU6DQo+DQo+IFRoZSBlaXJfdXVpZHMgbGlzdCBjb250YWlu
cyBHQVRUIHNlcnZpY2UgVVVJRHMgZnJvbSBhZHZlcnRpc2luZyBkYXRhLg0KPiBUaGUgZGV2aWNl
IG1heSBhZHZlcnRpc2UgZGlmZmVyZW50IFVVSURzIGVhY2ggdGltZSBpdCBpcyBzY2FubmVkIGFu
ZCANCj4gY29ubmVjdGVkLCBzbyB0aGUgbGlzdCBuZWVkcyB0byBiZSBjbGVhcmVkIHdoZW4gdGhl
IGRldmljZSBkaXNjb25uZWN0cy4NCj4NCj4gVGhpcyBwYXJ0aWFsbHkgZml4ZXMgYW4gaXNzdWUg
d2hlcmUgdGhlIFVVSURzIEQtQnVzIHByb3BlcnR5IGlzIGVtcHR5IA0KPiBhZnRlciBzY2Fubmlu
ZywgY29ubmVjdGluZywgZGlzY29ubmVjdGluZyBhbmQgc2Nhbm5pbmcgYWdhaW4gd2hlbiANCj4g
W0dBVFRdIENhY2hlID0geWVzIGlzIHNldCBpbiBtYWluLmNvbmYuDQo+DQo+IElzc3VlOiBodHRw
czovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovaXNzdWVzLzE5Mg0KPiBTaWduZWQtb2ZmLWJ5OiBE
YXZpZCBMZWNobmVyIDxkYXZpZEBsZWNobm9sb2d5LmNvbT4NCj4gLS0tDQo+ICBzcmMvZGV2aWNl
LmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvc3JjL2RldmljZS5jIGIvc3JjL2RldmljZS5jIGluZGV4IDgwNzEwNjgxMi4uNTNl
ZjNlOWExIA0KPiAxMDA2NDQNCj4gLS0tIGEvc3JjL2RldmljZS5jDQo+ICsrKyBiL3NyYy9kZXZp
Y2UuYw0KPiBAQCAtMzEyOSw2ICszMTI5LDkgQEAgdm9pZCBkZXZpY2VfcmVtb3ZlX2Nvbm5lY3Rp
b24oc3RydWN0IGJ0ZF9kZXZpY2UgDQo+ICpkZXZpY2UsIHVpbnQ4X3QgYmRhZGRyX3R5cGUpDQo+
DQo+ICAgICAgICAgZGV2aWNlX3VwZGF0ZV9sYXN0X3NlZW4oZGV2aWNlLCBiZGFkZHJfdHlwZSk7
DQo+DQo+ICsgICAgICAgZ19zbGlzdF9mcmVlX2Z1bGwoZGV2aWNlLT5laXJfdXVpZHMsIGdfZnJl
ZSk7DQo+ICsgICAgICAgZGV2aWNlLT5laXJfdXVpZHMgPSBOVUxMOw0KPiArDQo+ICAgICAgICAg
Z19kYnVzX2VtaXRfcHJvcGVydHlfY2hhbmdlZChkYnVzX2Nvbm4sIGRldmljZS0+cGF0aCwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgREVWSUNFX0lO
VEVSRkFDRSwgDQo+ICJDb25uZWN0ZWQiKTsNCj4NCj4gLS0NCj4gMi4yNS4xDQoNCkFwcGxpZWQs
IHRoYW5rcy4NCg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
