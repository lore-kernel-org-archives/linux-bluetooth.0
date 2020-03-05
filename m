Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D597C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5E72072D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="eEbsv2ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgCEQD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:03:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:12865 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCEQD6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 11:03:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="232979780"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 05 Mar 2020 08:03:56 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 08:03:55 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Mar 2020 08:03:55 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Mar 2020 08:03:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 5 Mar 2020 08:03:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euU164EGM+505WLD1/ew5ewj/hAS24ea93X97ZjYoee0Q/Ou09LH9lqKJhNQdCQLRJL6xzhmP5Kmmq5dp6FeSxnaBj9KD4GySJlVSYtV7KunmKi4eW2gvcdTyBuqppJL6S2wgrwoEXD0k35VPdhi6D4iBESaFB/NTpqaQLSj1u+whryH/0tFDxsFE4fh9+MIm6jOFKXRHK9L5FbqJVRn8hrZfB64+o43VFAHoffev/RbXr4cg9tT8cTzl4zaTInfZAKvv3AvorJp6VWYdgJtfGUrBMkxSGEed7L9AcFkmhMp1Fcrja758fHM0cUvYjmeV4uC2V5NN1iAKA/mFOqzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYKFxWS49r0Qw9OQxgeg4UL3mYZGvdY4Jmb+BVLsYQ4=;
 b=kEyO0nxl8SIUcAYbNP+7ro6F8VohfxfNC1jJ2M8akh02cuhqyN418iHWQOzIHKXf7X0wJquM79abxWCzw03cHCGEdUU06w0QLig5PVO8UTniI0LbZ/gcy7lL1dbAT1sjjCkrlho4mkowLuKFip2Cc0Q/Y6oWq8TyKV1uhyfS6o8XBr5wad8FGJu0oDEVeKRZQiQrgXBdYgRJRTpYf/+UbU4pZx21UeyWmMKZ3gV7i3PtQXxkIIDDG3MXyDgEbti9CbkjBP3wrO0YEqOMN72y0uYQThS1x+3G+QAw573N1jdeGFaHHAoFM58foxd4beNI5r3U/K/pYGPVFaP6TBKHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYKFxWS49r0Qw9OQxgeg4UL3mYZGvdY4Jmb+BVLsYQ4=;
 b=eEbsv2ZRWahzwxzm11rkAUEqLVNadIE1I04A17ZDTBk5LHfZEu23XdXYW5b5EjnkjTOFMV2lE8JJQhfA3HYgWCr6NcpOx5J4iBqQ9FLKb/VPZmo9x+nVlj7E7yr7OtIiMY5XbXNKXvL5ob1pXdOhhtHvOp4fJ1fPq1WecOd+cxs=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Thu, 5 Mar
 2020 16:03:53 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 16:03:53 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Record remote node's default
 TTL
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Record remote node's default
 TTL
Thread-Index: AQHV8fgXyfDLC0vKwUGSgCHDrE5rjqg6K2MA
Date:   Thu, 5 Mar 2020 16:03:53 +0000
Message-ID: <52fa0d5c8e73c3878eb91bc434600a9ffaddd4f3.camel@intel.com>
References: <20200304073915.24964-1-inga.stotland@intel.com>
In-Reply-To: <20200304073915.24964-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 586e8cd0-020a-4f41-ec84-08d7c11ecd96
x-ms-traffictypediagnostic: MW3PR11MB4553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4553BB4F6E4C4BC79E8F00D3E1E20@MW3PR11MB4553.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(110136005)(71200400001)(6506007)(2906002)(86362001)(81156014)(8936002)(81166006)(6636002)(8676002)(316002)(91956017)(186003)(66476007)(5660300002)(66556008)(66446008)(66946007)(36756003)(2616005)(64756008)(76116006)(26005)(6486002)(478600001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4553;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTFW9lrn9DqG6TfBaXEAOR59C6I2a0qNCyCH65W+Z8eNfm9s3rSSlkcnM75gxFMeh1b2YgzD+/dCuWvL4f7lA4dV7i+OvBYLnu8RVwsmzClwTbcXB9bVpeWnIXkTFY87Ypb2nxF2mTpBDIZZqINczdro7LGH3uBoDt/HkCwDATAqQj5EOd7QH+4C8e3CK4bYl5x97GisiilxMpQ88iKeJJQdAdJXd8dsHeURJCbwaHgmDxEeEVHb+jllkMAdVEu+a84lcgwiBF/GTvV57vdp+edUr3rPfuV6pal7vJ3zMxIv1/KrSFYcKJMWEC6Ehc9yb9goTP5y/n7ggfW1DK9Py8OljWmC7h+tw2kX252VOGH1mBMkYF5/C77FD9qHIeHj7FHHclpA1rvVTsPm/tycqUaqZR9hFu6Tc20c1L4bHhzcj4+4DFbj84CUgbkO21aQ
x-ms-exchange-antispam-messagedata: Ts7atvrRgJjwioqkGg9S+iSoHbBPLl0Fs4Vtm041oo31HViNJZUC1oxm6HEd8cRzTcvxAO/QUa9fKFmIVEgLTXUP9GWksjcXTWCk1hw9AgGxP6EtCSZJ2V8aP1TWfnVosZnQ33V8PUQcdGxb/9n+Dw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D88EB754213FBD49B53160D54AE1F5FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 586e8cd0-020a-4f41-ec84-08d7c11ecd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 16:03:53.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOTOXsPzShIP6sTLVm9NXBBNXYpU6LvyE006VEyF8qr/kGbxbh7kYWUgcX9Ch9p/r/O3OmeorvZq8vFDjdBE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDIzOjM5IC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGFkZHMgY29kZSB0byBzYXZlIHRoZSB2YWx1ZSBvZiBhIHJlbW90ZSBu
b2RlJ3MgZGVmYXVsdCBUVEwNCj4gdXBvbiByZWNlaXZpbmcgQ29uZmlnIERlZmF1bHQgVFRMIFN0
YXR1cyBtZXNzYWdlLg0KPiANCj4gQWxzbywgY2xlYW51cCBsZWZ0b3ZlciAiI2lmIDAiIGNsYXVz
ZQ0KPiAtLS0NCj4gIHRvb2xzL21lc2gvY2ZnY2xpLmMgIHwgIDEgKw0KPiAgdG9vbHMvbWVzaC9t
ZXNoLWRiLmMgfCAyNSArKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvbWVzaC9jZmdjbGkuYyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggMGFlYTdl
NTUzLi4zM2U3N2Q4NzggMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gKysr
IGIvdG9vbHMvbWVzaC9jZmdjbGkuYw0KPiBAQCAtNTU3LDYgKzU1Nyw3IEBAIHN0YXRpYyBib29s
IG1zZ19yZWN2ZCh1aW50MTZfdCBzcmMsIHVpbnQxNl90IGlkeCwgdWludDhfdCAqZGF0YSwNCj4g
IAkJCXJldHVybiB0cnVlOw0KPiAgDQo+ICAJCWJ0X3NoZWxsX3ByaW50ZigiTm9kZSAlNC40eCBE
ZWZhdWx0IFRUTCAlZFxuIiwgc3JjLCBkYXRhWzBdKTsNCj4gKwkJbWVzaF9kYl9ub2RlX3R0bF9z
ZXQoc3JjLCBkYXRhWzBdKTsNCj4gIA0KPiAgCQlicmVhazsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvbWVzaC9tZXNoLWRiLmMgYi90b29scy9tZXNoL21lc2gtZGIuYw0KPiBpbmRleCA0MTEx
NGY0MGYuLjRhMjZhNjY3ZSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC9tZXNoLWRiLmMNCj4g
KysrIGIvdG9vbHMvbWVzaC9tZXNoLWRiLmMNCj4gQEAgLTQzNCw2ICs0MzQsMjQgQEAgYm9vbCBt
ZXNoX2RiX25vZGVfbmV0X2tleV9hZGQodWludDE2X3QgdW5pY2FzdCwgdWludDE2X3QgaWR4KQ0K
PiAgCXJldHVybiBhZGRfbm9kZV9rZXkoam5vZGUsICJuZXRLZXlzIiwgaWR4KTsNCj4gIH0NCj4g
IA0KPiArYm9vbCBtZXNoX2RiX25vZGVfdHRsX3NldCh1aW50MTZfdCB1bmljYXN0LCB1aW50OF90
IHR0bCkNCj4gK3sNCj4gKwlqc29uX29iamVjdCAqam5vZGU7DQo+ICsNCj4gKwlpZiAoIWNmZyB8
fCAhY2ZnLT5qY2ZnKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlqbm9kZSA9IGdldF9u
b2RlX2J5X3VuaWNhc3QodW5pY2FzdCk7DQo+ICsJaWYgKCFqbm9kZSkNCj4gKwkJcmV0dXJuIGZh
bHNlOw0KPiArDQo+ICsJaWYgKCF3cml0ZV9pbnQoam5vZGUsICJkZWZhdWx0VFRMIiwgdHRsKSkN
Cj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJcmV0dXJuIG1lc2hfY29uZmlnX3NhdmUoKHN0
cnVjdCBtZXNoX2NvbmZpZyAqKSBjZmcsIHRydWUsDQo+ICsJCQkJCQkJCU5VTEwsIE5VTEwpOw0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBqYXJyYXlfa2V5X2RlbChqc29uX29iamVjdCAqamFy
cmF5LCBpbnQxNl90IGlkeCkNCj4gIHsNCj4gIAlpbnQgaSwgc3ogPSBqc29uX29iamVjdF9hcnJh
eV9sZW5ndGgoamFycmF5KTsNCj4gQEAgLTkyMywxMyArOTQxLDYgQEAgYm9vbCBtZXNoX2RiX2Ny
ZWF0ZShjb25zdCBjaGFyICpmbmFtZSwgY29uc3QgdWludDhfdCB0b2tlbls4XSwNCj4gIAkJZ290
byBmYWlsOw0KPiAgDQo+ICAJanNvbl9vYmplY3Rfb2JqZWN0X2FkZChqY2ZnLCAiYXBwS2V5cyIs
IGphcnJheSk7DQo+IC0jaWYgMA0KPiAtCWphcnJheSA9IGpzb25fb2JqZWN0X25ld19hcnJheSgp
Ow0KPiAtCWlmICghamFycmF5KQ0KPiAtCQlnb3RvIGZhaWw7DQo+IC0NCj4gLQlqc29uX29iamVj
dF9vYmplY3RfYWRkKGpjZmcsICJncm91cHMiLCBqYXJyYXkpOw0KPiAtI2VuZGlmDQo+ICANCj4g
IAlpZiAoIW1lc2hfY29uZmlnX3NhdmUoKHN0cnVjdCBtZXNoX2NvbmZpZyAqKSBjZmcsIHRydWUs
IE5VTEwsIE5VTEwpKQ0KPiAgCQlnb3RvIGZhaWw7DQo=
