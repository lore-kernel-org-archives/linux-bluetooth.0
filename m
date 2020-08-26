Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7345C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936252078B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tqr/M3Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHZQ6L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:58:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:24211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHZQ6J (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 12:58:09 -0400
IronPort-SDR: U7j5Qqn5MgUGBizO80DCVUHoVykRf6V7Ffq8N+Z85ZDID6FhRl27DPreskGhUHsN5iA79y+2e5
 YW/01AfvDyoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144006086"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="144006086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:58:08 -0700
IronPort-SDR: K+j4SrnBQ1su5J78NU3zSnzOT/IsREflmoCq7538243vvJJXE92mplWyGI3oVu1j1l6i7/URLX
 le1UKOA/+wZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="329292551"
Received: from fmsmsx605-2.cps.intel.com (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 09:58:08 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 09:58:08 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Aug 2020 09:58:08 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Aug 2020 09:58:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 26 Aug 2020 09:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDxShjlPYojZ70NOfZZnLOmHraUA/SaEn/eD29ey64ijqHYXKozzwd4cTgS1dlHQhbBK/duvHDpxrBppP4zYcAJzpZfFcpfC+9LfTTNaXnwAInNm4Y27+r/MQuCDaCRqNCx6u5XvmMGNn8wWwkkSHNnTQHmLIKGam7H5H4eEsRwfF/8Xaufu2KPQEmcLKMJtRQ5ESW8TY/kYmltw9N2ApZzmMsSdI8CzdlbYaNLNPd7Dk7GDbp6O6i5qCBeTiuoSTBJolK6OkRq66lnlQOeslKeK2SaP6bQjfO9Dtbzc9RHQgf+6NZ9OmpZB4iZ4kUvtI+04h6OcVv/7SyYdIlERJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbR7T0WBY2V4VcScOPVuQ8iXElABMQis552iZ9IXk4E=;
 b=kUYMBaay3BWFM2FDoJI2a6WdZzRv8CidmzHMsx27B+vgsM71uXCGEaSvsAPoDVJXOh96ZjkoTHzAlCXLuZ8xLFH2rtzzZ/Qz8LdJgu6Xpo0Yp1u3lBRHp3GsVb062By6ej91rS5di6pwzQnX5F8hR4ONBn/zB7BYnXnruTCnH0gLCj+58eiqQOv8yQQqdIjWLyC/Ug8Gwcx+hfWqvT9KWqmzOtprQNla0F41ZgH9+/JQvwxKzozI32Bkp7UOud0vGvAb9UQMPHLVSeEPW4TfR2uyRNzX5JEZdEOEafc/wLIv3uiwZl1rlFfNBVXr+O7Gct+ZRHQ1CH7Yvpzxtx2/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbR7T0WBY2V4VcScOPVuQ8iXElABMQis552iZ9IXk4E=;
 b=tqr/M3Cf4SxuQnnaev6dzfT3glhQAusGnKGpkjf7DTD5q27NGWD79P6tqY/tyX3gd+2cM7I1Sc6kK2fwFeOo/b9IPygAC1E6e1JjsT0sQtXEaZ29xznqKUcbmdnfekN5f+U1q1VxAiUG5wVJRCtKkb7xYS/sjfxIStNQS++t2JE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR1101MB2192.namprd11.prod.outlook.com (2603:10b6:301:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 16:58:06 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 16:58:06 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/4] Mesh send/publish API change
Thread-Topic: [PATCH BlueZ v3 0/4] Mesh send/publish API change
Thread-Index: AQHWe8mUWQRcoFWSdEi2UPln3ahZpalKnI6A
Date:   Wed, 26 Aug 2020 16:58:06 +0000
Message-ID: <4b29d4d233edd02266e905b13651859ec0dce918.camel@intel.com>
References: <20200826165420.563822-1-brian.gix@intel.com>
In-Reply-To: <20200826165420.563822-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2b28ebb-4d8b-43f2-d9ed-08d849e13458
x-ms-traffictypediagnostic: MWHPR1101MB2192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2192DA28A722396497C3AB68E1540@MWHPR1101MB2192.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: onaXrtICe/GOV5q7qmltscYM1pqCRNmWgQkjPdbtRMuedP1Zj2WnJ1VXLudWZosvYsEMqxHKQFjFMb/rhIL8JX3gTfTksgmxbM6jK8yIuxZMNLF8WW8nk20Veq0rUd7AsFc7GxgoeXLgDzwUdzghO62Nt/fuH6dD6O2nEpb3YD3qrDtoT7MV9MApS6dKqCW5mOoDAsSqNKkUbRZuETmlGZonG4z/bJn17ws/bhmA3hAv8LLEHJIDsTSUJBNXrj3quXLUiw5srCAaitDsChvw3+QVN6UMlSQG7pCIRKIWR3OhJftk1FNdaLqsC3SgP4oK+IfdgUDczlfLHn9lkFdkTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66946007)(186003)(36756003)(91956017)(2906002)(5660300002)(76116006)(6506007)(8676002)(4326008)(6486002)(83380400001)(8936002)(64756008)(6512007)(66446008)(66556008)(66476007)(71200400001)(316002)(26005)(86362001)(54906003)(2616005)(107886003)(478600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MLon2IDrfunR4sLwbwM2VVnHL286mE5lyDaac+QQx9SHUfrkXF6fENdVvyBWw7u+fpx9HeDGhG7qoa5ZF797AE7XajjuDbWfBfLNuJHfXDWfk0GZBkMefx+TNqWT0GICqJd1cMOFJJgviUPI6gcTVj9OPoGPOfZVcqJZHfhz/vZ7vg+ygb7OaJdDNJLXDfiRhU9DubvrGwI3txOKx/mLX9nBqKlEdAruOqD4OODYMB+sf44YJrwRAjRQRueDVcmFq6w/nklT+l0L2q5/MvLKyGj/EahPyuXxAt1DAHS0sPBjCfGDgxGrME5+Nh+SKS/jD/E7nDmaVEhqSaKyK67600h8qIYCbyYOVJIlnfU1h/FPnRqbWJVOKwknmZFxcSV3XvCiBWhmmuWM66rrnsrMoIr4HqO/2M+Gks8uPOmMW5heq7j5DZXKoOa7LMpiRSwtSAACHv5FzyP04SPBldZy/g8Hf76l1pcUT1MXe804De+7SfzhO8niYkuW7ZeDV19hkBsNEPDSVonhve4XM4pCtMUY7VPD7ei89I42Ccb7C3IclXcwHKtGXP5sDgnaWGtlgwmgvq+pMbbbaACBqpuwqGzuUoFGk/O+EXVM0SYinO1Ri9ropZyFxGuiXFwc8RHLeEQ/s2W2Xgie715S+zCmMA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A68D441B98B0224EAD6871CB55EC472E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b28ebb-4d8b-43f2-d9ed-08d849e13458
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 16:58:06.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ydtt9tR7aa6fX5g+tN/ZxRISFyDCNa/bLMojoQOjtNE5siVaa7wCQWCH6HgvPZsqzzTw397HS4UEEWHNuymNnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gV2VkLCAyMDIwLTA4LTI2IGF0IDA5OjU0IC0wNzAwLCBCcmlh
biBHaXggd3JvdGU6DQo+IFRoaXMgcGF0Y2ggc2V0IG1vZGlmaWVzIFNlbmQsIERldktleVNlbmQg
YW5kIFB1Ymxpc2ggbWV0aG9kcw0KPiBvbiBibHVlei5tZXNoLk5vZGUgaW50ZXJmYWNlIHRvIGlu
Y2x1ZGUgYWRkaXRpb25hbCBhcmd1bWVudCAib3B0aW9ucyIuDQo+IA0KPiBUaGlzIG5ldyBhcmd1
bWVudCBpcyBhIGRpY3Rpb25hcnkgdGhhdCBjdXJyZW50bHkgaGFzIG9ubHkgb25lDQo+IG5ldyBr
ZXkgd29yZCBkZWZpbmVkIGZvciBTZW5kKCkgYW5kIERldktleVNlbmQoKToNCj4gICAgICJGb3Jj
ZVNlZ21lbnRlZCIgLSB0byBmb3JjZSBzbWFsbCBwYXlsb2FkcyB0byBiZSBzZW50IGFzDQo+ICAg
ICAgICAgICAgICAgICAgICAgICBvbmUtc2VnbWVudCBtZXNzYWdlcw0KPiANCj4gT3RoZXIga2V5
IHdvcmRzIG1heSBiZSBkZWZpbmVkIGluIGZ1dHVyZSB0byBhY2NvbW1vZGF0ZSBldm9sdmluZw0K
PiByZXF1aXJlbWVudHMgb2YgTWVzaCBQcm9maWxlIHNwZWNpZmljYXRpb24uDQo+IA0KPiAqKioq
KioqKiogdjIgKioqKioqKioqKioqDQo+IEluIGNhc2Ugb2YgUHVibGlzaCgpLCBhbmQgYWRkaXRp
b25hbCBrZXl3b3JkIGlzIGRlZmluZWQNCj4gICAgICJWZW5kb3IiIC0gIDE2LWJpdCBDb21wYW55
IElEIGFzIGRlZmluZWQgYnkgdGhlIEJsdWV0b290aCBTSUcNCj4gDQo+IFRoaXMgYWxsb3dzIHVz
IHRvIGVsaW1pbmF0ZSBWZW5kb3JQdWJsaXNoKCkgbWV0aG9kLg0KPiANCj4gKioqKioqKioqIHYz
ICoqKioqKioqKioqKg0KPiBBZGRlZCBWZW5kb3Igc3BlY2lmaWMgY2xhcml0eSB0byB0aGUgUHVi
bGlzaCgpIG1ldGhvZCBkZXNjcmlwdGlvbiBpbg0KPiBtZXNoLWFwaS50eHQsIHNpbmNlIFZlbmRv
clB1Ymxpc2goKSBpcyByZW1vdmVkLg0KPiANCj4gDQo+IEluZ2EgU3RvdGxhbmQgKDQpOg0KPiAg
IGRvYy9tZXNoLWFwaTogQWRkICJvcHRpb25zIiBkaWN0aW9uYXJ5IHRvIFNlbmQvUHVibGlzaA0K
PiAgIG1lc2g6IEhhbmRsZSAib3B0aW9ucyIgZGljdGlvbmFyeSBpbiBTZW5kL1B1Ymxpc2ggbWV0
aG9kcw0KPiAgIHRvb2xzL21lc2gtY2ZnbGllbnQ6IEFkZCAib3B0aW9ucyIgdG8gU2VuZC9EZXZL
ZXlTZW5kDQo+ICAgdGVzdC90ZXN0LW1lc2g6IEFkZCAib3B0aW9ucyIgdG8gU2VuZC9QdWJsaXNo
DQo+IA0KPiAgZG9jL21lc2gtYXBpLnR4dCAgICAgICB8ICA2MCArKysrKysrKysrLS0tLS0tLS0N
Cj4gIG1lc2gvY2ZnbW9kLXNlcnZlci5jICAgfCAgIDIgKy0NCj4gIG1lc2gvbW9kZWwuYyAgICAg
ICAgICAgfCAgIDYgKy0NCj4gIG1lc2gvbW9kZWwuaCAgICAgICAgICAgfCAgIDkgKy0tDQo+ICBt
ZXNoL25vZGUuYyAgICAgICAgICAgIHwgMTQwICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICB0ZXN0L3Rlc3QtbWVzaCAgICAgICAgIHwgIDExICsrKy0NCj4gIHRv
b2xzL21lc2gtY2ZnY2xpZW50LmMgfCAgIDggKysrDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDEyNyBp
bnNlcnRpb25zKCspLCAxMDkgZGVsZXRpb25zKC0pDQo+IA0K
