Return-Path: <SRS0=jEMa=CA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A73C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Aug 2020 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D9B2072D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Aug 2020 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="NwLEQCwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHVOVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:21:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:61901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgHVOVH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Aug 2020 10:21:07 -0400
IronPort-SDR: ZTcje9Uh/zv6M/uhkptd++BjlOc60N2uSnO87OfBmYf63sC5VtKOk5g30Xn6+lpX+hAMqE1Wvl
 8CiWnhJ90Jhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="154977984"
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="scan'208";a="154977984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 07:21:06 -0700
IronPort-SDR: a77ZLTayAin71VYwXsXwIUiUHlT1uj7TFhG3zGywWYT6mB4sOAWlDw0rskyHZ5gha8yHbFbj2v
 gUl7x8cDKyhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="scan'208";a="372182659"
Received: from orsmsx602-2.jf.intel.com (HELO ORSMSX602.amr.corp.intel.com) ([10.22.229.82])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2020 07:21:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Aug 2020 07:21:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Aug 2020 07:21:05 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 22 Aug 2020 07:21:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 22 Aug 2020 07:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAw5qTHmbYgz2bX9643PuvN1+qDY2cx3Pvep8F01omQqtl4mL6pKStGb8vvLCQFyqHlDuvksjY6OkOMMf6+LBN9448Ps73TROxSzo3sxvtK2B8XBTB9lh4/dZUOV3A58ml+TjgGkemflc069Ch0IWaNOBGR4npVEdqKbnhJ0dHIw8gYDhzUlEeXCKyAXJ3aD7Qzk+AK62Sht708OgYFyzALgiZr+ar6L+zn7G5KKtPmclrQk6A1CNRXcyEJ6o/9ohXx0N0MY918+s7AZ34Pct2ESjPfY5iYWJsAetciRARpm0row7JjSYlxvIgEqlJQzWINwwfNT++ij0GwgZHirpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b+DIDrKr39zHBM8gk+sRn8leTyCuh1pVIVhyqQU+WU=;
 b=IG3f3XpL2FAEfUvSTZ8UiH5krfNJIjUy8BhAuRZ+k9RkMm5Qg0LYItpmg6I8LqSMlo7k7Kw1dEL+cDBxhTr0MRC6Dl/sVeCoKtghd9lISPOAAfbPm9/XIb/82hD7nC/OZ27wbakcMbUcY98dnOPHzLIHAMQlfR8A3j1VBMjTX3nSXRB2BKnZuzMK4JoL5DNg2+AQGg2s5gFd9Nvcpv/7KQMjoIMQl3ec1DpBnHRJ5XuY/BY+jfsN+6uucC9053td8lU09NuNRFakLOLyUB5D9h85Mbobm4VHlu5qwiodcvCAzqutMcu4D2qe6giq87NycAOyJE/BcfrNAL33Dao2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b+DIDrKr39zHBM8gk+sRn8leTyCuh1pVIVhyqQU+WU=;
 b=NwLEQCwWX5/EkpW/L2s18mGFvfhNifQ4C6OEzRRYo/dapzpCFuDanCEkDBMDExMuGv+YcHGIU93N/O7szyZg/4YhVOqXTC0SEyLm4YZkL47WvgQ3urOXte8o8CjlqJ2/SQqVe81UhnNeMtNK3LY/UTS/iYsHPxR7jMliJUrd71E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Sat, 22 Aug
 2020 14:21:04 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3305.026; Sat, 22 Aug 2020
 14:21:04 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Use valid net key index when handling Send
 call
Thread-Topic: [PATCH BlueZ] mesh: Use valid net key index when handling Send
 call
Thread-Index: AQHWd37J2YpmPaFZ7keIPhkCoQiFVqlEL+6A
Date:   Sat, 22 Aug 2020 14:21:03 +0000
Message-ID: <f1a03abbda88c79e75779762a88fee04503e258b.camel@intel.com>
References: <20200821054856.41857-1-inga.stotland@intel.com>
In-Reply-To: <20200821054856.41857-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b43ddf1-9e85-4524-41d7-08d846a69a4f
x-ms-traffictypediagnostic: MW3PR11MB4682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB468244A04AEDD6F138840ECDE1580@MW3PR11MB4682.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Wx4repY++WCB2gLIy7DDnmSHLNQOjMuYR5U/AG+lvGlwlQpfj8vk6cuIC9vpzAUaqZAoya4wpYsSDw4A7xz3OyfalTUHNs5RKwVnievbf1lo0/YrCxJZs9LS37HWkz4uldciKNCbuquJpnVdAwtpv8oW1gQFUEZ2gxvZvtF5bHRfdYaJ7aCatjV2ylb4yizVP3KWoGEZeHheVeb5AO63T/RufGE1/jTxG1SxflM322KdxA1zINLx/g0ylhBLalN8ybu5jeyHMqxM9ZSu6ghM37Hk//xnjNMEIFsaxL+dVF6lGrr/6mYthj5xj7t9mLDtge9VJ+HTExmMRGNIsY0yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(66476007)(76116006)(64756008)(71200400001)(8936002)(66446008)(66556008)(6506007)(26005)(83380400001)(5660300002)(316002)(186003)(8676002)(36756003)(6486002)(478600001)(66946007)(86362001)(6512007)(2906002)(6636002)(2616005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IwoO1wzEJEz6r5kRYNp+nPNjTOtm4NIsRoB76e7KZfHkFVPQR1gDDbZW8lGlP+KhmJJn/n5mlStgDf5q8/V8vKbb6s+pGnoGW/O8ocCxIXhlj3/Qfte5DYxEGxvfk6GFefcM8FeqYukDHfAxBl2lzxk2DbKlLUJD5YSs7GnDlSY+Q/UmG1NkeeBjJG6xgH5jYSJKtrk0Ejv63fO6TysBBc0Lblc1RIN7887yI7Hoj0d/AwIpIKtALcDtbU8pZTj5eJDhFqZVAAI9I5T5zC70wQElGwrNepRZoRezzRjJSl7ENyTaP9j8wKmgWkrKAU3ZYyTlFJGN32E5Shc0rGwi4xv+FiJNBiUfKl3mDoaFQg4L/rqH/L0Y+N71Sk1i1i5XLl1sIacyYoVSMeP4lMA48NOeVrneWTFd2+/7BdwKMgPIUxi+Bjbmr4zl3T4VD8daihTiutAmcWr3kEDoCtA1JElHUkTPfxWTNNWAHA/HyKHRii5Tj36J9KBsNH6MoAAS5+sEahk6NyXarHlAjFx1I86WCDMay2UzgoX9n8x1RxFCFyG7yyilzg3FN7yB0MEm6vJrqgMIoCvnl1dDEFCulp5uetKDJD4V6HSdAchOwxRvuVfQKprhSJ4g41PiNrcOCRfxFDwF1ZDKC9/k1ldISg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE59306BA73EC4E9C6449835AC4BB6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b43ddf1-9e85-4524-41d7-08d846a69a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2020 14:21:03.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxaYo2lm4EBAJDVg2iAAgbMylV2t/puQCDMmm/p/0tpQ603Qcl8Xu34af8WpX1+o+qmI8R2nOPRJ/F4hHOUCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTA4LTIwIGF0IDIyOjQ4IC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBSZXRyaWV2ZSB2YWx1ZSBvZiBib3VuZCBOZXQgS2V5IGluZGV4IGJhc2VkIG9u
IHRoZSB2YWx1ZSBvZg0KPiBwYXNzZWQgQXBwS2V5IGluZGV4LiBDaGVjayBpZiB0aGUga2V5IGlz
IHByZXNlbnQgYW5kIGZhaWwgZWFybHkNCj4gaW4gY2FzZSBvZiBlcnJvci4gQWxzbywgcGFzcyB0
aGUgY29ycmVjdCBOZXRLZXkgaW5kZXggdG8gbW9kZWwNCj4gbGF5ZXIgaW4gbWVzaF9tb2RlbF9z
ZW5kKCksIGluc3RlYWQgb2YgaGFyZCBjb2RlZCAwLg0KPiAtLS0NCj4gIG1lc2gvbW9kZWwuYyB8
ICAyIC0tDQo+ICBtZXNoL25vZGUuYyAgfCAxMyArKysrKysrKystLS0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9tZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gaW5kZXggZWI1MTQyNTAzLi43ZTFjNGFi
OTIgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21vZGVsLmMNCj4g
QEAgLTU0Nyw4ICs1NDcsNiBAQCBzdGF0aWMgYm9vbCBtc2dfc2VuZChzdHJ1Y3QgbWVzaF9ub2Rl
ICpub2RlLCBib29sIGNyZWQsIHVpbnQxNl90IHNyYywNCj4gIAkJCWxfZGVidWcoIm5vIGFwcCBr
ZXkgZm9yICgleCkiLCBhcHBfaWR4KTsNCj4gIAkJCXJldHVybiBmYWxzZTsNCj4gIAkJfQ0KPiAt
DQo+IC0JCW5ldF9pZHggPSBhcHBrZXlfbmV0X2lkeChub2RlX2dldF9uZXQobm9kZSksIGFwcF9p
ZHgpOw0KPiAgCX0NCj4gIA0KPiAgCW91dCA9IGxfbWFsbG9jKG91dF9sZW4pOw0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9ub2RlLmMgYi9tZXNoL25vZGUuYw0KPiBpbmRleCAxZWVmZmViOGIuLmVkM2Q5
NTljNSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4g
QEAgLTE3NjEsNyArMTc2MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnNlbmRf
Y2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCWNvbnN0IGNoYXIgKnNlbmRlciwgKmVsZV9w
YXRoOw0KPiAgCXN0cnVjdCBsX2RidXNfbWVzc2FnZV9pdGVyIGl0ZXJfZGF0YTsNCj4gIAlzdHJ1
Y3Qgbm9kZV9lbGVtZW50ICplbGU7DQo+IC0JdWludDE2X3QgZHN0LCBhcHBfaWR4LCBzcmM7DQo+
ICsJdWludDE2X3QgZHN0LCBhcHBfaWR4LCBuZXRfaWR4LCBzcmM7DQo+ICAJdWludDhfdCAqZGF0
YTsNCj4gIAl1aW50MzJfdCBsZW47DQo+ICANCj4gQEAgLTE3OTAsMTAgKzE3OTAsMTUgQEAgc3Rh
dGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqc2VuZF9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMs
DQo+ICANCj4gIAlpZiAoYXBwX2lkeCAmIH5BUFBfSURYX01BU0spDQo+ICAJCXJldHVybiBkYnVz
X2Vycm9yKG1zZywgTUVTSF9FUlJPUl9JTlZBTElEX0FSR1MsDQo+IC0JCQkJCQkiSW52YWxpZCBr
ZXlfaW5kZXgiKTsNCj4gKwkJCQkJCSJJbnZhbGlkIGtleSBpbmRleCIpOw0KPiArDQo+ICsJbmV0
X2lkeCA9IGFwcGtleV9uZXRfaWR4KG5vZGVfZ2V0X25ldChub2RlKSwgYXBwX2lkeCk7DQo+ICsJ
aWYgKG5ldF9pZHggPT0gTkVUX0lEWF9JTlZBTElEKQ0KPiArCQlyZXR1cm4gZGJ1c19lcnJvciht
c2csIE1FU0hfRVJST1JfSU5WQUxJRF9BUkdTLA0KPiArCQkJCQkJCSJLZXkgbm90IGZvdW5kIik7
DQo+ICANCj4gLQlpZiAoIW1lc2hfbW9kZWxfc2VuZChub2RlLCBzcmMsIGRzdCwgYXBwX2lkeCwg
MCwgREVGQVVMVF9UVEwsIGZhbHNlLA0KPiAtCQkJCQkJCQlkYXRhLCBsZW4pKQ0KPiArCWlmICgh
bWVzaF9tb2RlbF9zZW5kKG5vZGUsIHNyYywgZHN0LCBhcHBfaWR4LCBuZXRfaWR4LCBERUZBVUxU
X1RUTCwNCj4gKwkJCQkJCQlmYWxzZSwgZGF0YSwgbGVuKSkNCj4gIAkJcmV0dXJuIGRidXNfZXJy
b3IobXNnLCBNRVNIX0VSUk9SX0ZBSUxFRCwgTlVMTCk7DQo+ICANCj4gIAlyZXR1cm4gbF9kYnVz
X21lc3NhZ2VfbmV3X21ldGhvZF9yZXR1cm4obXNnKTsNCg==
