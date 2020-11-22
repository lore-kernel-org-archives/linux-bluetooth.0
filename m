Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2128AC6379F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50322075A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 08:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="D8ul2EMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKVIfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 03:35:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:49430 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgKVIfR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 03:35:17 -0500
IronPort-SDR: 1H2tqL/IearBsgrDI+hCanFUx9qXpEM6F21R93GrUTnjxvFnePIWq48gjxSY9QbccSPBs4DX2a
 02WlDmtDcdIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="159404384"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="159404384"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 00:35:16 -0800
IronPort-SDR: b4QDkZf9QnRTqT5EpN3LiJMu0qRkQnvBJ6XebDGXCTa1UvYkwk3NVd3/c5xWfS7kUDx5csXmjD
 DrNKMupkUDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="326866949"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2020 00:35:16 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 00:35:16 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 00:35:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 22 Nov 2020 00:35:15 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 22 Nov 2020 00:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HozlzkEdiuVN5PP8Q8CGzimh7M9RnTW8HRWfCEF6a2X7mlwts3APQrBzqz/PfZHaUCT5ZE6gL+Pbzvfs0Um79KMIT0yfibTut9fZQ9lZA7WeoQZPTIQMAXgeYLXp0eq774AlxG0/kLPhV9ppifcp5KEHs27rUCA7zP8jJd+6Vr5/gogPAYZRMnk7ssX3i21ulPdVC2ZrUInjeLHt+lCvVMuSvmY4T+sgWS3jCaIujcJHfj8loOP7OWp2l/tk5trGovuya930D1G2aq+cee9n/um56I37FxnbtpCwhAyYYwWYcwT8p3VlSuphgNAkpevmkJwDTKxjZl01jxGXTJOHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huT33NFxniWAXSSDRlHRxrkryZmprFAV1frW5O4jCSE=;
 b=ZFhJAsYEwweWWVSMLiG7Hlm7qS2nvVHburIWbPobMOQ6t47Ahb97JXoOkuEXfYd/sUyDDxdOaLd++nWiRc+RBol/uqmc2vBVt1w8AoffVcTChBq3Z+tTQYuIUtHEfpg4n3xgkK+i2BJESOXSd3RkOuSuZQ8qaTHN2KbepNid2LM4e426J3ruSVbm9/ofxcmz0HrBE8OzA8TJhJrepW214KBPd5+cYAzf6GydBpp2x3s1uEXQMOYtvtys5/Szw9pE6N3/3MRMF+4aGjG4JUJtizQEuRKiyovrf+ApEt+kYyAlEkFLPTcBpbDvlTBdjWe9TpZ2hPixWtbnGS0qSM2blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huT33NFxniWAXSSDRlHRxrkryZmprFAV1frW5O4jCSE=;
 b=D8ul2EMMoX48GgZnuulVjy52nSFZxoPkZimXfBSNcA6sCJZ4SkTouFjU94+kstm1VWCD34qesFRVA+cZlQ1z6tKe4rq6k03k65mnqqJ7ZEuVPTbaYgutwkNRHGwvTL+tcHA8J6tRfyFP5nzeGRGereXkFTBOekCdHg4mPo7umU4=
Received: from DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) by
 DM6PR11MB4393.namprd11.prod.outlook.com (2603:10b6:5:206::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Sun, 22 Nov 2020 08:35:07 +0000
Received: from DM6PR11MB3146.namprd11.prod.outlook.com
 ([fe80::c804:48b7:2d61:83da]) by DM6PR11MB3146.namprd11.prod.outlook.com
 ([fe80::c804:48b7:2d61:83da%5]) with mapi id 15.20.3589.024; Sun, 22 Nov 2020
 08:35:07 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>, Kiran K <kiraank@gmail.com>
CC:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Firmware version read error on Intel AX210
Thread-Topic: Firmware version read error on Intel AX210
Thread-Index: AQHWwFN1qv0byiSyF0KMPF70QEKl2qnTM3eAgACe2JA=
Date:   Sun, 22 Nov 2020 08:35:07 +0000
Message-ID: <DM6PR11MB314662E82730EF100538531DF5FD0@DM6PR11MB3146.namprd11.prod.outlook.com>
References: <89a134d0-c6f6-c685-2aeb-7dc5eee1966f@gmail.com>
 <44820333-3e09-5405-a1aa-19f64087f164@gmail.com>
In-Reply-To: <44820333-3e09-5405-a1aa-19f64087f164@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.182.237.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09eee735-5e92-439c-7800-08d88ec1845a
x-ms-traffictypediagnostic: DM6PR11MB4393:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB439378E871B6062381FE402FF5FD0@DM6PR11MB4393.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71Ie+VlmXTXHmn2dfbNVfG5u5Hbjwu21+gunbWFzA7/TQQriVKq4ACMCbt3tIc570JOkmZuzwuTcSGNxX/peeRRL7ZYzVKGXS4Umo5HHigVD9uSGEQWaUco61BT+wbofDEX3wPOf2H7tjdg5/lYOb6gdbJlLEoindUIpf4z40zmzMwe+8A/eDGs+jjunmCplge5CW4OA740tbKVeEF06sKye2JgH6Isfgufw7Peo77FLd0rixHka+zZd5BM7BNhp3Cc48zrvPKioEoFc3OtcEl8gzqH4xKJxEE1fRb2MlR6/fWCsc2RxqHGMBEQBEmdt0N7fFC8G+sbj8hnMF6qUu+LLn5cgwHT9b2OMk+fAUmao2c2J18xwKb20FINuC1Aq59iPN4jkqHAtfdvwRxsd/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3146.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(9686003)(8676002)(7696005)(4326008)(5660300002)(6506007)(26005)(53546011)(2906002)(55016002)(8936002)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(110136005)(316002)(54906003)(966005)(76116006)(478600001)(33656002)(83380400001)(52536014)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5BbdfSyENb8D5oSLBKnVPFigGg6ffwIHHkSkD/dSUmbg4AEo9dJjc0jYwu6Q/RZJQrwu3HI1Cu4PwNdMMAPfeySCKbQTr9MvJ4fX8wcToysiCqPMSyEoAksH2U6U9Nt3o3Rme+rcnTm49t1xANdgroL3aWDeeeSmcUB6Nf3tlQGbW7ujc7EQ2FP8BR3uVNS7BAWkpF/Pk0BETVQSVUCVRXdbOOWjpbIc3DwFXlKz8VX5Wfoz6Fk7BHdvX1VZYNKQE93QRxMLk56aLO07/9lyzTyU6ovjTznVHCpCi2RDZo8Ex3J13EkPptXebVt0tLVWz1dVga8zHbGelbW85Z7++2MhV1vY9EQzqA4g/lP2jdAuEwBiCwKfX3SjX6FEPAqSU9OREwh0TEqE0gr7ioBiHGkSURzBdtTDkUy/i/ms8F+Wob3kRSBYvjR88AhDZqF0PEwNTF7+a4bmNxa9vLxAZ4N2fm4HVb1YnH1TTuCoBW6lSB5udODpEv1K12N345XvK6evbbJ/zinmEudHt+ZAzGe96Rz7NmamQBD91cRfUUcLF0LEp4mmpP0WiWcYXR+tYm6spZh+uPIy69kyVEscYeMfTEMz+BC00T0tvOQ0wEmV6SYSMzNSJWN2rwbBktwbkN98CU3a4w2LipYn4UgsHg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3146.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09eee735-5e92-439c-7800-08d88ec1845a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2020 08:35:07.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+y5mnjG1XDXywe7tw0CXSc1eLVqJGAkX3vxveKAejHpe8cKjyiPwsRou6jymXA+aGdonjlOiYYUFQ/rNXxFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4393
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSGVpbmVyIEthbGx3ZWl0LA0KDQpUaGUgcGF0Y2hlcyB0byBzdXBwb3J0ICBJbnRlbCBBWDIx
MCAgYXJlIG5vdCBmdWxseSB1cHN0cmVhbWVkIGludG8gYmx1ZXRvb3RoLW5leHQuICBGaW5hbCBw
YXRjaCBzZXQgcmV2aWV3IGlzIGluIHByb2dyZXNzIC0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Mzg3NDc1DQoNClJlZ2FyZHMsDQpL
aXJhbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhlaW5lciBLYWxs
d2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgMjIs
IDIwMjAgNDozMCBBTQ0KPiBUbzogS2lyYW4gSyA8a2lyYWFua0BnbWFpbC5jb20+OyBLLCBLaXJh
biA8a2lyYW4ua0BpbnRlbC5jb20+DQo+IENjOiBCbHVlWiBkZXZlbG9wbWVudCA8bGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IEZpcm13YXJlIHZlcnNpb24g
cmVhZCBlcnJvciBvbiBJbnRlbCBBWDIxMA0KPiANCj4gQW0gMjEuMTEuMjAyMCB1bSAyMzoxMiBz
Y2hyaWViIEhlaW5lciBLYWxsd2VpdDoNCj4gPiBJIGhhdmUgYSBuZXcgQVgyMTAgV2lGaS9CbHVl
dG9vdGggY2FyZCBhbmQgYnRpbnRlbF9yZWFkX3ZlcnNpb24oKQ0KPiA+IGZhaWxzIHdpdGggZXJy
b3IgLTIyIChFSU5WQUwpLiBVbmRlcmx5aW5nIGVycm9yIGlzIHRoYXQgdGhlIGZpcm13YXJlDQo+
ID4gdmVyc2lvbiByZWFkIGNvbW1hbmQgcmV0dXJucyB3aXRoIGhkZXYtPnJlcV9yZXN1bHQgPSAx
OCAoMHgxMikuDQo+ID4gKHJlcV9zdGF0dXMgPSAwKQ0KPiA+PkZyb20gd2hhdCBJJ3ZlIHJlYWQg
dGhpcyBtZWFucyBpbnZhbGlkIGNvbW1hbmQgcGFyYW1ldGVycy4NCj4gPiBEaWQgc29tZXRoaW5n
IGNoYW5nZSB3aXRoIEFYMjEwIGFuZCBjb21tYW5kIDB4ZmMwNSByZXF1aXJlcyBzcGVjaWZpYw0K
PiA+IHBhcmFtZXRlcnMgbm93PyBPciB3aGF0IGVsc2UgbWF5IGNhdXNlIHRoaXMgaXNzdWU/DQo+
ID4NCj4gU2VlbXMgQVgyMTAgdXNlcyB0aGUgbmV3IFRMViBpbmZyYXN0cnVjdHVyZS4gYnRpbnRl
bF9yZWFkX3ZlcnNpb25fdGx2KCkNCj4gcmV0dXJucyB2YWxpZCBkYXRhLiBXaWxsIFRMVi9BWDIx
MCBzdXBwb3J0IGJlIGFkZGVkIGZvciA1LjExPw0K
