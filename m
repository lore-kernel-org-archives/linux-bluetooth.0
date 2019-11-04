Return-Path: <SRS0=jKvG=Y4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A0ACA9ED3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F652222C5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 22:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Ma4+RN9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfKDWLS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:11:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:21876 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390622AbfKDWLP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Nov 2019 17:11:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 14:11:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="212397954"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2019 14:11:14 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 4 Nov 2019 14:11:14 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 4 Nov 2019 14:11:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZtkTMRp8Zthb6NjlJjT/ONU6rtDcFG2jhc6inaU531DPdjEUT1WuuSnZD4IXSP8d6jQb9BgI/kjNJo0TktN7LmGHIsTz/iv1AEK/Z+NRojNW6v8WNr/yJPI8blB0ofX+8zCkpauShobFZuADlAiEGl0NY7qQbpLU+sp3cXbkbHr+SGSaA4dDv/1YiOqyNyk11r/X6VTHaUBLQ0mijBgXxJN+eZzI1s3EQc6tgzLFyXQP2GtXiFRiPHBnhTCKAXfPZOwLpgDk3mLkhiE0Av9DsvW2B52z9vTO4f14JeKJgskk2GL3QToSaFKgSE48LxGfSQmSUGV+QahwElwLcB86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4ebO7dvf5+L5olRM9w5QOj/oiAfkMJalzECMxJ6YLI=;
 b=Iwmi2jtpi52BuBXrjfdDmKRlUG54/GqPnBfSpuO2yPC0mORTDiSPok83ingLLjp9km9qGMlNX6EWmE/LRkBjNNKbOUi8fLhetRhuCYbjFjnCfNTXgmwICiWz9y3CUUQndkw1ot5o4vSavDRZ64GSyvFmdqSC6ECOp937gglYCF4gY3bXnRdGPI2Gal2v4n8Vu+/6FhtgAtXEyyRk5XMXnfdPkQdHd0hWLaxKga107XZ4iuSN/BDKVvq0eF+CCcwgw4LoATNqqZN1rHmFymwEp3fVgf0zXArNtPl7zFP0tJKKFcKqbHLYWgT16mvvhfIN7dSCFBegx1lWfsID1ZOy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4ebO7dvf5+L5olRM9w5QOj/oiAfkMJalzECMxJ6YLI=;
 b=Ma4+RN9vWUjnkPzLyZbAwJa4aWC1975XfLQllqRkivw1/MUK0WxsD/iMw4VzLNyW0RHLIlyGqs4s4+7Kb4Ew1bP6YXWHu5ryF/2ZR/7JAJWt4xHRE3QyTCLvm90OhCHG+OXxp2a6AEfXB4Q/HHiHJST42yRSeCqlNydwDvrbx/Y=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2200.namprd11.prod.outlook.com (10.172.76.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 22:11:12 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 22:11:12 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "stefan.seyfried@googlemail.com" <stefan.seyfried@googlemail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: test-mesh-crypto segfaults
Thread-Topic: test-mesh-crypto segfaults
Thread-Index: AQHVk1VO68tQgsqZz0+1Ib+798NR36d7ktsA
Date:   Mon, 4 Nov 2019 22:11:11 +0000
Message-ID: <70299d5df034aa0174a9263ea8736b56fd9bbd02.camel@intel.com>
References: <5f75011d-a157-cab2-72df-0209f7a30f21@message-id.googlemail.com>
In-Reply-To: <5f75011d-a157-cab2-72df-0209f7a30f21@message-id.googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0c7a3e6-4974-45f9-c4cc-08d76173e720
x-ms-traffictypediagnostic: CY4PR1101MB2200:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2200403665AB0481FA2AA1B4E17F0@CY4PR1101MB2200.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(2501003)(6506007)(6116002)(446003)(8936002)(11346002)(110136005)(76116006)(81156014)(6512007)(102836004)(476003)(118296001)(7736002)(478600001)(36756003)(316002)(3846002)(305945005)(86362001)(81166006)(5660300002)(4326008)(486006)(91956017)(3480700005)(26005)(76176011)(66066001)(99286004)(256004)(186003)(2616005)(14454004)(6246003)(25786009)(64756008)(14444005)(66556008)(66946007)(71190400001)(71200400001)(6486002)(66476007)(6436002)(8676002)(107886003)(66446008)(229853002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2200;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nACBFpnK8Kfum2cpizXabpzPSGE6h9WbDGW+iGQ/673/S7hE1QVzv5UTJBdFEv9vaT4AaQNRGhR5Euf9w21jeGK8NKNpWhAnuLppVhfqf34q6zaCgzrx/1ymMsRR4ZbfmI5B96bV2o7QZWK953fZynpl4QpwCHehAQuXhUlaM9OsgWIXAYB6F0PNZeWaL36sP4IYZIKPW5uS3D49mqhrtpN1ldNeCsuM3JWz0j1mCeLS/QQH4b3CrSLpml6AtbTgQsuTj0vOJbxh04FzAvHZTK9Ba9VhHTTHPeixx6dxDRvzyI/+b2FmjZtA8RDTflI0w6sDROfFBWg6itedXOmqvqi410BKXoNzlieg7elY0TNOGq8+/iy/5uRwfVBc6wvCC2uTe+SufXojZRftqHDmEx95VOzHc+gO6zzB98nTimQuGmTr/W8AVEAnZmRzyUrr
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F0E276129DDDD4DA99D1809A8ABF1F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c7a3e6-4974-45f9-c4cc-08d76173e720
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 22:11:12.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozMiD3MJ1eXeDI73v1AbvlohwdSrSm7KgZiikRYEnrxz1MmaVmyA6evIb+8XZg09zOA9b41+MFc26KwTq0zAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2200
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgU3RlZmFuLA0KDQpPbiBNb24sIDIwMTktMTEtMDQgYXQgMjI6MTYgKzAxMDAsIFN0ZWZhbiBT
ZXlmcmllZCB3cm90ZToNCj4gSGksDQo+IA0KPiB0ZXN0LW1lc2gtY3J5cHRvIHNlZ2ZhdWx0cyBm
b3IgbWUuDQo+IA0KPiBhYnVpbGRAc3Ryb2xjaGk6fi9ycG1idWlsZC9CVUlMRC9ibHVlei01LjUy
PiBnZGIgdW5pdC90ZXN0LW1lc2gtY3J5cHRvDQo+IA0KPiBbLi4uLl0NCj4gDQo+IFs4LjYuMiBT
ZXJ2aWNlIERhdGEgdXNpbmcgTm9kZSBJZGVudGl0eV0NCj4gSUQgUmVzb2x2aW5nIEtleSAgICAg
PSA4NDM5NmM0MzVhYzQ4NTYwYjU5NjUzODUyNTNlMjEwYw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgIDg0Mzk2YzQzNWFjNDg1NjBiNTk2NTM4NTI1M2UyMTBjID0+IFBBU1MNCj4gSGFzaCBJbnB1
dCAgICAgICAgICAgPSAwMDAwMDAwMDAwMDAzNGFlNjA4ZmJiYzFmMmM2MTIwMQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIDAwMDAwMDAwMDAwMDM0YWU2MDhmYmJjMWYyYzYxMjAxID0+IFBBU1MN
Cj4gSGFzaCAgICAgICAgICAgICAgICAgPSAwMDg2MTc2NWFlZmNjNTdiDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgMDA4NjE3NjVhZWZjYzU3YiA9PiBQQVNTDQo+IE1lc2ggSUQgQmVhY29uICAg
ICAgID0gMDEwMDg2MTc2NWFlZmNjNTdiMzRhZTYwOGZiYmMxZjJjNg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgIDAxMDA4NjE3NjVhZWZjYzU3YjM0YWU2MDhmYmJjMWYyYzYgPT4gUEFTUw0KPiAN
Cg0KVGhpcyBpcyB2ZXJ5IHN0cmFuZ2UuICBUaGUgdW5pdCB0ZXN0IGxvb2tzIGxpa2UgaXQgaGFz
IGNvbXBsZXRlZCBzdWNjZXNzZnVsbHkgKGF0IGxlYXN0IGZyb20gd2hhdCB5b3UgY29weS0NCnBh
c3RlZCkuICBUaGF0IHRlc3QgOC42LjIgaXMgdGhlIGZpbmFsIHRlc3QsIGFuZCBpdCBsb29rcyBo
YXBweS4gIENhbiB5b3UgdmVyaWZ5IGZvciBtZSB0aGF0IGFsbCB0aGUgb3RoZXINCnRlc3RzIGNv
bXBsZXRlZCBzdWNjZXNzZnVsbHk/DQoNClRoZXJlIGlzIGEgKnNtYWxsKiBjaGFuY2UgdGhhdCB5
b3UgY291bGQgYmUgcnVubmluZyBvbiBhbiBvbGQga2VybmVsOiAgS2VybmVscyB2ZXJzaW9uIDQu
OCBhbmQgYmVmb3JlIGhhZCBhIA0KYnVnIGluIHRoZSBBRUFEIGNyeXB0byBjb2RlIHRoYXQgbWFk
ZSBtZXNoIGNvZGUgKGluY2x1ZGluZyB0aGlzIHVuaXQgdGVzdCkgaW5vcGVyYWJsZS4uLiAgQnV0
IHRoaXMgc2hvdWxkIHNob3cNCnVwICpmaXJzdCogaW4gb25lIG9mIHRoZSBlYXJsaWVyIHRlc3Rz
IHdpdGhpbiB0aGlzIHVuaXQgdGVzdC4uLiBzbyBsb29rIGZvciBhbnkgRkFJTCBkZXNpZ25hdGlv
bnMuDQoNClRoZSBvdGhlciB0aGluZyBhYm91dCB0aGlzIHBhcnRpY3VsYXIgdGVzdCBpcyB0aGF0
IGl0IGlzIHRoZSAqb25seSogYmx1ZXogdW5pdCB0ZXN0IHdoaWNoIGlzIGJhc2VkIG9uIEVMTA0K
KEVtYmVkZGVkIExpbnV4IExpYnJhcnkpIGluc3RlYWQgb2YgR0xJQi4NCg0KQXJlIHlvdSBydW5u
aW5nIGZyb20gYW4gaW5zdGFsbGVkIEVMTCB3aGVuIGNvbXBpbGluZyBibHVleiwgb3IgZG8geW91
IGhhdmUgRUxMIGluIGEgInBlZXIgZGlyZWN0b3J5Ii4uLiBGb3INCmluc3RhbmNlOg0KDQouLi4v
d29yay9lbGwNCi4uLi93b3JrL2JsdWV6IA0KDQpJZiB5b3UgaGF2ZSB0aGUgRUxMIHNvdXJjZSBj
b2RlIGF2YWlsYWJsZSwgcGxlYXNlIHRyeSBydW5uaW5nOg0KZWxsICUgbWFrZSBjaGVjaw0KDQpw
YXlpbmcgcGFydGljdWxhciBhdHRlbnRpb24gdG8gdGhlIG91dHB1dCBvZjoNCnVuaXQvdGVzdC1j
aXBoZXINCg0KSWYgdW5pdC90ZXN0LWNpcGhlciBpbiBFTEwgcGFzc2VzLCB0aGVuIHVuaXQvdGVz
dC1tZXNoLWNyeXB0byBpbiBCTFVFWiBzaG91bGQgcGFzcy4NCg0KDQo+IA0KPiBQcm9ncmFtIHJl
Y2VpdmVkIHNpZ25hbCBTSUdTRUdWLCBTZWdtZW50YXRpb24gZmF1bHQuDQo+IDB4MDAwMDdmZmZm
N2U4NzRhZSBpbiBtZW0yY2h1bmtfY2hlY2sgKCkgZnJvbSAvbGliNjQvbGliYy5zby42DQo+IChn
ZGIpIGJ0DQo+ICMwICAweDAwMDA3ZmZmZjdlODc0YWUgaW4gbWVtMmNodW5rX2NoZWNrICgpIGZy
b20gL2xpYjY0L2xpYmMuc28uNg0KPiAjMSAgMHgwMDAwN2ZmZmY3ZThiNmFmIGluIGZyZWVfY2hl
Y2sgKCkgZnJvbSAvbGliNjQvbGliYy5zby42DQo+ICMyICAweDAwMDA1NTU1NTU1NTdjOTggaW4g
bF9mcmVlIChwdHI9PG9wdGltaXplZCBvdXQ+KSBhdCBlbGwvdXRpbC5jOjEzNg0KPiAjMyAgbF9x
dWV1ZV9jbGVhciAocXVldWU9MHg1NTU1NTU1NmQwMTAsIGRlc3Ryb3k9MHg1NTU1NTU1NTdjNjAN
Cj4gPGxfZnJlZT4pIGF0IGVsbC9xdWV1ZS5jOjEwNw0KPiAjNCAgMHgwMDAwNTU1NTU1NTU3MjEw
IGluIF9zdWJfRF82NTUzNV8xLjcwMjEgKCkgYXQgZWxsL2NpcGhlci5jOjMxOQ0KPiAjNSAgMHgw
MDAwN2ZmZmY3ZmUyYzEzIGluIF9kbF9maW5pICgpIGZyb20gL2xpYjY0L2xkLWxpbnV4LXg4Ni02
NC5zby4yDQo+ICM2ICAweDAwMDA3ZmZmZjdlM2Y4NzcgaW4gX19ydW5fZXhpdF9oYW5kbGVycyAo
KSBmcm9tIC9saWI2NC9saWJjLnNvLjYNCj4gIzcgIDB4MDAwMDdmZmZmN2UzZmEyYyBpbiBleGl0
ICgpIGZyb20gL2xpYjY0L2xpYmMuc28uNg0KPiAjOCAgMHgwMDAwN2ZmZmY3ZTI3ZTEyIGluIF9f
bGliY19zdGFydF9tYWluICgpIGZyb20gL2xpYjY0L2xpYmMuc28uNg0KPiAjOSAgMHgwMDAwNTU1
NTU1NTU3YjhhIGluIF9zdGFydCAoKSBhdCAuLi9zeXNkZXBzL3g4Nl82NC9zdGFydC5TOjEyMA0K
PiANCj4gdGhpcyBpcyByZXByb2R1Y2libGUgaGVyZSwgSSdtIGRpc2FibGluZyB0aGlzIHRlc3Qg
Zm9yIG5vdyBpbiB0aGUNCj4gb3BlblNVU0UgcGFja2FnZSBidWlsZC4NCj4gDQo+IEJlc3QgcmVn
YXJkcw0K
