Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11365C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ECE2076F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="W22bnSE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYTMX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:12:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:1392 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgCYTMX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 15:12:23 -0400
IronPort-SDR: NLMZJIqZuTWil23YTIcbvFAldiM4vWtebdgED3SZLefGKFLijsNrtKdxmEeTOBB7pRhJwBUxGE
 m8qpbMaaBZgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 12:12:21 -0700
IronPort-SDR: IOeWi0w7QRm1FY48HdLM/wSLVkD1qaQJjfT/ek2L7f2LNGLQlNuNjCLJtprkH0Uh88kY/PLpRR
 XuuNJXmPWbSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="448374210"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga006.fm.intel.com with ESMTP; 25 Mar 2020 12:12:20 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 12:12:20 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX155.amr.corp.intel.com (10.22.240.21) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 12:12:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 25 Mar 2020 12:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixaqN6JiEPB+YooikxKnUm0LIk1EsJLFMn555w1M4XBAWkEkVqGu8s4q9fgu+hLsIBL5wuIP37KdpP1Ru01KLFug6J1VHbohKkxlJY9XFqxxbRRk0NYdCGOKJgGomV5401snuI3HLcyRcg2TjX9Ln0Q72XDnYc3QocHx6ZJAaa18QbhQrTiz18IyzbuNod0myQNtq38RXCfasI5OFnnhCA3f4J3imo71uJZgdC3GMQrt8sOPxna5aU4a6s1pnWw4JOnJ9CueCJEggolnJw/Whjs45lcyr2RdABOmjf7XE3Aaa0iZF8iCy/gf1n2HMWHT501LI3fAuZMs5EkbL9UG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9Atc1rW64Uj371BdMRu/stcBc9EKKqDpRxaGi55nag=;
 b=gFYzy65+UM6XWPNFTtvjzqd0m+BeekEuy5iZzlWsYeFKtG2eeYmDLusy9K1Qf8Yjt22hnBaN4u2XyvBVAy/EUP/mkslRK3I8cBnlSGLvhWnYp117VoX0HFARNLIOcjV6T5dhGRQOUa/rQdgL5n2kVfQxucbhoRZaohof9N9Dkl+DMMDY3sbuIisvt9lf8ca9hOkthj9NMslNH2w3xQMZQzkjXYGKm7+or2IHp9WHuCVMFMNr6wNtfjZpGJv5QKGIwLhfxAVW6BIx/Kt8RvAbRXEW3VCXWskuJ+Lm2SQL0eC9xWEgliCahzKcD3qtpJOsCftdLJZtwdUMvyOQoRnzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9Atc1rW64Uj371BdMRu/stcBc9EKKqDpRxaGi55nag=;
 b=W22bnSE5QwmyTZgnHUEtpurV0eLLvln7ep2EPtoyA75BKU4FgjRE9o/a11p2DLA+8q4tAfi+Td/IGKhMOZiCZ4zBjs0TCUwM7jmn1Rmg/rfzHyTW4YLReohRxtvue7BFyKnI55tDQbyVLcRlq8yZpaF098yh7XTh+Ek6bc7hTzI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 25 Mar
 2020 19:12:18 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 19:12:18 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "s.syam@samsung.com" <s.syam@samsung.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/1] mesh: Check limits for count and interval of relay
Thread-Topic: [PATCH 1/1] mesh: Check limits for count and interval of relay
Thread-Index: AQHWAhJ8S8ll8vk7BUe5j5v1JH7GVKhZrnUA
Date:   Wed, 25 Mar 2020 19:12:18 +0000
Message-ID: <a0d832523512cf3f4f9c7eed27a258687732e47d.camel@intel.com>
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
         <CGME20200324192820epcas5p10a4ae9a6d7e7dab22f4a5ab4ee752099@epcas5p1.samsung.com>
         <1585078044-14974-2-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1585078044-14974-2-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c82a5088-a902-4038-0b0b-08d7d0f07029
x-ms-traffictypediagnostic: MW3PR11MB4681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4681F5FD886B05E55C8C77D6E1CE0@MW3PR11MB4681.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:163;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(107886003)(6506007)(6512007)(2616005)(26005)(71200400001)(36756003)(186003)(86362001)(110136005)(54906003)(478600001)(6486002)(316002)(76116006)(2906002)(4326008)(8936002)(8676002)(81156014)(81166006)(66446008)(66556008)(64756008)(66946007)(66476007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4681;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PW3sFFPReZG3KbT/N3GTeX912Ed6ObCkR6Rs+dh5louNzCK76vSplJYcFExpHeLt3+F6IkM6w8fMPNNxX/wYHtagtRs0gzWBPEqvIgmMFSrPKZZk8R9IolAW1Kjc8TysqP+kCvMlMTY1ju/Ev1FjAyHkmOXDNc48hZbXDqpO+wFKFts5UikYNl5bY+edDx+oSGpyGdFjkhaAbIDEfshPztwmdIJ8eeEw6q1ryoi7TI6yXN3ZejfcqkitBxAF8lHROQ6x3UIAlNDn9DjQASHJrPoJRxJ5UoCr9NO+WRaD14xWLYjS8UGPWrqQ55/a4ntDfoCYxgSxLCsa5m+stah8nuTY4EmzBGi48mNfudfSxZXaLDoLzrbqaqDz65IDbgwiKJN2q3chtcf2DdenhW/54ycawydoDOeO4XmcsGDgyaZCzXAGeSF8CfuGQ3fEnSUy
x-ms-exchange-antispam-messagedata: /NPItUVgmtNg3p/lMh50fHxV6I2ikeW1QQZDzeRsIuHrupKgzAGu5XVC/Ify1CJexhpPIIDYPx6Jk+Y7sjP7GaRXvOjgVpWASDeUWP2Zc1ofWu2/bxtV2XM6EtB+F3u3vFBaWTN6qIbKPmCOlqHDlQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2162C953949D3A47A10D956C988B62A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c82a5088-a902-4038-0b0b-08d7d0f07029
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 19:12:18.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjM8dwJMYZp6z8H1ipKZqSGIUoUk77/iJsV19/kkoBrAzn09i5EKwJ0Ilmt5RYanWY6UPfZe1LlgCbCo81pI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUHJhdGh5dXNoYSwNCg0KSW5nYSBhbmQgSSBoYXZlIGJlZW4gdGFsa2luZywgYW5kIGNvbXBh
cmluZyBiZWhhdmlvciB0byBzcGVjLCBhbmQgd2UgYmVsaWV2ZSB0aGF0IHRoZSAqb25seSogd2F5
IHRoYXQgaW52YWxpZA0KZGF0YSBjYW4gbWFrZSBpdHMgd2F5IGludG8gdGhlIHN5c3RlbSBpcyB0
byBoYW5kLWVkaXQgdGhlIG5vZGUuanNvbiBmaWxlLCB3aGljaCBpcyBub3Qgc29tZXRoaW5nIHdl
IHdhbnQgdG8NCmVuY291cmFnZS4gIFdlIHN1Z2dlc3QgbW92aW5nIHZhbGlkYXRpb24gdG8gd2hl
cmUgdGhlIG5vZGUuanNvbiBpcyByZWFkLi4uLg0KbWVzaC9jb25maWctanNvbi5jIGluIHBhcnNl
X2ZlYXR1cmVzKCkNCg0KQmFzaWNhbGx5LCB3ZSBvbmx5IGNhcmUgaWYgDQogICAgIm1vZGUiOiJl
bmFibGVkIiwNCg0KaW4gd2hpY2ggY2FzZSwgd2UgcmFuZ2UgY2hlY2sgaW50ZXJ2YWwgKDEwLTMy
MCkgYW5kIGNvdW50ICgxLTgpLg0KDQpBbnkgdmFsdWVzIG91dHNpZGUgdGhhdCByYW5nZSwgd2Ug
IkZhaWwgdG8gUGFyc2UiIHRoZSBub2RlLCBhbmQgdGhhdCBub2RlIHdpbGwgbm90IGJlIGxvYWRl
ZC4uLi4gIFNvIGVkaXQgdGhlDQpub2RlLmpzb24gYnkgaGFuZCAqb25seSogd2l0aCBsZWdhbCBh
cmd1bWVudHMuDQoNCkJleW9uZCB0aGF0LCBpZiByZWxheSBpcyAiZGlzYWJsZWQiIG9yICJ1bnN1
cHBvcnRlZCIsIHRoZSBpbnRlcnZhbCBhbmQgY291bnQgYXJlIGRvbid0IGNhcmVzLCBhbmQgdGhl
cmUgaXMgbm8NCm9ibGlnYXRpb24gZm9yIHRoZSAybmQgcGFyYW1ldGVyIG9jdGV0IG9mIFJFTEFZ
X1NUQVRVUyB0byBiZSB6ZXJvJ2QuICBBcyBmb3IgdGhlIGluY29taW5nIFJFTEFZX1NFVCwgdGhl
cmUgYXJlDQpubyBvdXQgb2YgcmFuZ2Ugb3IgZGlzYWxsb3dlZCB2YWx1ZXMgZm9yIGNvdW50IG9y
IGludGVydmFsLiAgDQoNCg0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDAwOjU3ICswNTMwLCBQcmF0
aHl1c2hhIE5lbGx1cmkgd3JvdGU6DQo+IEZyb206IFByYXRoeXVzaGEgTiA8cHJhdGh5dXNoYS5u
QHNhbXN1bmcuY29tPg0KPiANCj4gQWRkZWQgbGltaXQgY2hlY2tpbmcgY29uZGl0aW9uIGZvciBj
b3VudCBhbmQgaW50ZXJ2YWwNCj4gYmVmb3JlIHByb2Nlc3NpbmcgZm9yIGNvdW50IGFuZCBpbnRl
cnZhbCBzdGVwcy4NCj4gLS0tDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDYgKysrKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21vZC1zZXJ2ZXIuYw0K
PiBpbmRleCA3MTExNDExYzcuLjE1MWNhYjE1NCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9jZmdtb2Qt
c2VydmVyLmMNCj4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gQEAgLTg4MSw3ICs4ODEs
MTEgQEAgc3RhdGljIGJvb2wgY2ZnX3Nydl9wa3QodWludDE2X3Qgc3JjLCB1aW50MzJfdCBkc3Qs
IHVpbnQxNl90IHVuaWNhc3QsDQo+ICAJCW4gPSBtZXNoX21vZGVsX29wY29kZV9zZXQoT1BfQ09O
RklHX1JFTEFZX1NUQVRVUywgbXNnKTsNCj4gIA0KPiAgCQltc2dbbisrXSA9IG5vZGVfcmVsYXlf
bW9kZV9nZXQobm9kZSwgJmNvdW50LCAmaW50ZXJ2YWwpOw0KPiAtCQltc2dbbisrXSA9IChjb3Vu
dCAtIDEpICsgKChpbnRlcnZhbC8xMCAtIDEpIDw8IDMpOw0KPiArDQo+ICsJCWlmIChjb3VudCA+
IDAgJiYgaW50ZXJ2YWwgPj0gMTApDQo+ICsJCQltc2dbbisrXSA9IChjb3VudCAtIDEpICsgKChp
bnRlcnZhbC8xMCAtIDEpIDw8IDMpOw0KPiArCQllbHNlDQo+ICsJCQltc2dbbisrXSA9IDA7DQo+
ICANCj4gIAkJbF9kZWJ1ZygiR2V0L1NldCBSZWxheSBDb25maWcgKCVkKSIsIG1zZ1tuLTFdKTsN
Cj4gIAkJYnJlYWs7DQo=
