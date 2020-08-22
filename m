Return-Path: <SRS0=jEMa=CA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E8DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Aug 2020 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAF52072D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Aug 2020 14:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="muXZajqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHVO1h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:27:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:45620 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgHVO1f (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Aug 2020 10:27:35 -0400
IronPort-SDR: lQGlaTlU4awUo6tdxGzW3v0lejl2YXacvT4zwqa96IeqUgq3yHyXPjqLfuKQG10fURMsAUGjli
 MffhHohOBbEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="156772478"
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="scan'208";a="156772478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 07:27:34 -0700
IronPort-SDR: 5RuZCZ3Ra/pEAdPX9RvsjPag82ornAzRv0BsiBv2rJFFTgXMUPwkphTvPKM8MTIGtQP8FLOMWR
 o6OoGYLiT1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="scan'208";a="442648192"
Received: from fmsmsx602-2.cps.intel.com (HELO fmsmsx602.amr.corp.intel.com) ([10.18.84.212])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2020 07:27:34 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Aug 2020 07:27:33 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 22 Aug 2020 07:27:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 22 Aug 2020 07:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXsM5xrlB8U5fFbrxtzXBWhIy913769bjaQl+7x9T2MoBBlSAVGuBa9USBPUh0MLwxym36XQ4CoIywXWbbaE8v01z2cLa4NAX0kgpP6/E8iZM+hI3y8CBqyRuuJPh30xuuAAw4bcHYM1aXGs3by82+zZVxW3yaGEKiELewmAdZ4AAAxdAXY7XtSX6HCEWXmbvpYEl8DDFjEQMc5SOfu/DGEeXHEy6i5j6HvBdFrd9FhsiMc22fNdx21VAuczl7bapS3yQkI6hldyfVMm6knnlbcNQ6ARXB9pc9oYby3eRo8wIDa++At3PgbKdp36BMRAHGBSvJ1f7T6v7TxqNKFg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PRzdK51I/ZzG/2yTsjcdoKwIt7bWPCfsToa5DfpvSE=;
 b=LxI4uHeGtU8lbeI9Fe3LZ4d6qhPa/Gb2ndJGqo7UVcSfidlOaoqaVUNz4G2WrZ7UEmiYUxxFnYZLc6gHwFgL9EZvy7RwEzaTL4T8yPpGtt0FjfXR/hC0ETjumcTeXCtCzhyUexUGFUlX7x72c6j2I5MCytqBA3QB73ty9dYiaBZeoPQF55v99j/a8qrDZgTGugtENEsRbgRD80Jm4mwWw6Y8M0jKGti0sNfgpO31wexkMQUM1poGjUg/TI7ed9SjA/iBBuPpynIH3f6xE7XWoZ8nzprU72NSQfhGi1XLYC7xYqlHTtUqsIsLCxZgcsM8hkZH6GkAYjsn13KVO6uzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PRzdK51I/ZzG/2yTsjcdoKwIt7bWPCfsToa5DfpvSE=;
 b=muXZajqiK4+jJ80l/CB3Cj4R8gQT42ZL4olYN+Ax71I/pAYeH8KPifL/5eFX5SfGI24bMSSViflmErcSvZYX+X73CQlMYwzttupn2CGVNyUda/XyPphPtDX5CNCgHRh86f5xi7yI0qShV0InsK+gI8GtPQRJPRp9xiNF/Goq8kM=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Sat, 22 Aug
 2020 14:27:32 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3305.026; Sat, 22 Aug 2020
 14:27:32 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "daan@dptechnics.com" <daan@dptechnics.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/1] Added random address in mesh HCI initialization
 to prevent error 0x12 when enabling/disabling LE scans
Thread-Topic: [PATCH BlueZ 1/1] Added random address in mesh HCI
 initialization to prevent error 0x12 when enabling/disabling LE scans
Thread-Index: AQHWdgLUZ2KEwp3CbU2pCdVSfGggMalENLeA
Date:   Sat, 22 Aug 2020 14:27:32 +0000
Message-ID: <d9b02252be21635e6e572ae9d43e8c3539524f9c.camel@intel.com>
References: <20200819082822.64903-1-daan@dptechnics.com>
         <20200819082822.64903-2-daan@dptechnics.com>
In-Reply-To: <20200819082822.64903-2-daan@dptechnics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: dptechnics.com; dkim=none (message not signed)
 header.d=none;dptechnics.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60aecef-40f5-4ee7-6317-08d846a781c8
x-ms-traffictypediagnostic: MW3PR11MB4682:
x-microsoft-antispam-prvs: <MW3PR11MB46829EF647690BBA04BEBBE4E1580@MW3PR11MB4682.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p80KLYlmfyeiXNfXwgE0JlNiQKnQXqRHjbbdbPcq0Xh5fpyk18fcRu52C1g3CkSw3a7EVeFLiMMSUE3BPXsQUFlHUUebu7W3iqJm6tjcqwNuZOeT4lUqZ5CLuuu4PWZEkmK+S9LzkDItjrFB6tpxmQ6xKsn/bK/UcHB7hzMlgQvCBlSfFu1OuklSUgJg2FWioDJv+3/TaGfcNOiBJNEIC8IlAIpGm2cubr8OH1J2aYmhmxql7rADgl96d59enLvmwIHhea+UQvixFFp3J3Ygoaob3yA7lHQvWESeok2e9rkBMgUXz0MjSLFyXWK26aPVhhYu+mtWduNYE4mcQ4KGYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(66476007)(76116006)(64756008)(71200400001)(8936002)(66446008)(66556008)(6506007)(26005)(5660300002)(316002)(186003)(8676002)(36756003)(6486002)(478600001)(66946007)(86362001)(6512007)(2906002)(2616005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 45G5OXAYUPfvcjlFKiWMUVRgYG5Y3GYWym5TgBErwz/em3PE80uwncocrmCwMKsi8hazGqXMVkWS4oGwIJ71Z2z55UrFFN7ImmfeU+LAGkpxpyBeNHhm+9gmYBymLxFfF2gtdt3iDlIaTXYFHy3Bt4La9IMJH5dlCsTqIbkPDx5F1Ur+uDHv1LHbzImjTWL12noQM1Iti6BlFQ3ouHczZEWdaDIqT4+7PVL96j4idrFhIE3dhiMIYXMn/kV7xKOHXJStGqCYPn4/+PmWifMIt7EHKu7GSv5G+lzpnvvxJW3W9iOKfeVIjBZiIUOXV6rd6ignb9wP7KwiuZ31Z/wVVVx/lT7An19hRF1dPplxCFTungoQ+tDV7noOPmSkA/mkeXp3/HE6LdGKXx1oFbp74eXkYr0uuOjUlgB/vwzZSSCJVGCXdIIJJbpvCUrKWNn7VTp5WVTbwGP/PYl6zo5yUWKyOaOgp6RHCGM5d6l3LyHP91ARvxeFdX/xa+zQrqjP2nVElc0D+OZGVsg/OzrW/2IPQgpY/zfcmTZRH6Iwnu0fru5WTtqrnWr48zu1fgLglJdKbWr/TIWZZfdwHXjdGUvjRK/9sQ5qinBvOmajA67MZ1KjRspHcd8cZ6JA/cP1VtnUIXZABAEPPHig21bndQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD31C39C8ACFE841B917D87B49235E4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60aecef-40f5-4ee7-6317-08d846a781c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2020 14:27:32.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCSgW0u+pFwQpQc4923HmCQauWHZLF5XIzlCvKTH7WXgVSNl/iYhyybo/zIlAXHqF7vkp2qM74kVOV6Gyjpgcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIGNvcnJlY3Rpb25zIHRvIEdJVCBwb2xpY3kgZXJyb3JzDQpPbiBXZWQsIDIw
MjAtMDgtMTkgYXQgMTA6MjggKzAyMDAsIERhYW4gUGFwZSB3cm90ZToNCj4gLS0tDQo+ICBtZXNo
L21lc2gtaW8tZ2VuZXJpYy5jIHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2gtaW8tZ2VuZXJpYy5jIGIv
bWVzaC9tZXNoLWlvLWdlbmVyaWMuYw0KPiBpbmRleCA2N2IxM2ExYjkuLjY3MzA0ZDIwMSAxMDA2
NDQNCj4gLS0tIGEvbWVzaC9tZXNoLWlvLWdlbmVyaWMuYw0KPiArKysgYi9tZXNoL21lc2gtaW8t
Z2VuZXJpYy5jDQo+IEBAIC0yMDksNiArMjA5LDcgQEAgc3RhdGljIHZvaWQgY29uZmlndXJlX2hj
aShzdHJ1Y3QgbWVzaF9pb19wcml2YXRlICppbykNCj4gIAlzdHJ1Y3QgYnRfaGNpX2NtZF9sZV9z
ZXRfc2Nhbl9wYXJhbWV0ZXJzIGNtZDsNCj4gIAlzdHJ1Y3QgYnRfaGNpX2NtZF9zZXRfZXZlbnRf
bWFzayBjbWRfc2VtOw0KPiAgCXN0cnVjdCBidF9oY2lfY21kX2xlX3NldF9ldmVudF9tYXNrIGNt
ZF9zbGVtOw0KPiArCXN0cnVjdCBidF9oY2lfY21kX2xlX3NldF9yYW5kb21fYWRkcmVzcyBjbWRf
cmFkZHI7DQo+ICANCj4gIAkvKiBTZXQgc2NhbiBwYXJhbWV0ZXJzICovDQo+ICAJY21kLnR5cGUg
PSAweDAwOyAvKiBQYXNzaXZlIFNjYW5uaW5nLiBObyBzY2FubmluZyBQRFVzIHNoYWxsIGJlIHNl
bnQgKi8NCj4gQEAgLTI2MSw2ICsyNjIsMTAgQEAgc3RhdGljIHZvaWQgY29uZmlndXJlX2hjaShz
dHJ1Y3QgbWVzaF9pb19wcml2YXRlICppbykNCj4gIAljbWRfc2xlbS5tYXNrWzZdID0gMHgwMDsN
Cj4gIAljbWRfc2xlbS5tYXNrWzddID0gMHgwMDsNCj4gIA0KPiArCS8qIFNldCBMRSByYW5kb20g
YWRkcmVzcyAqLw0KPiArCWxfZ2V0cmFuZG9tKGNtZF9yYWRkci5hZGRyLCA2KTsNCj4gKwljbWRf
cmFkZHIuYWRkcls1XSB8PSAweGMwOw0KPiArDQo+ICAJLyogVE9ETzogTW92ZSB0byBzdWl0YWJs
ZSBwbGFjZS4gU2V0IHN1aXRhYmxlIG1hc2tzICovDQo+ICAJLyogUmVzZXQgQ29tbWFuZCAqLw0K
PiAgCWJ0X2hjaV9zZW5kKGlvLT5oY2ksIEJUX0hDSV9DTURfUkVTRVQsIE5VTEwsIDAsIGhjaV9n
ZW5lcmljX2NhbGxiYWNrLA0KPiBAQCAtMjgyLDYgKzI4NywxMCBAQCBzdGF0aWMgdm9pZCBjb25m
aWd1cmVfaGNpKHN0cnVjdCBtZXNoX2lvX3ByaXZhdGUgKmlvKQ0KPiAgCWJ0X2hjaV9zZW5kKGlv
LT5oY2ksIEJUX0hDSV9DTURfTEVfU0VUX0VWRU5UX01BU0ssICZjbWRfc2xlbSwNCj4gIAkJCXNp
emVvZihjbWRfc2xlbSksIGhjaV9nZW5lcmljX2NhbGxiYWNrLCBOVUxMLCBOVUxMKTsNCj4gIA0K
PiArCS8qIFNldCBMRSByYW5kb20gYWRkcmVzcyAqLw0KPiArCWJ0X2hjaV9zZW5kKGlvLT5oY2ks
IEJUX0hDSV9DTURfTEVfU0VUX1JBTkRPTV9BRERSRVNTLCAmY21kX3JhZGRyLA0KPiArCQkJc2l6
ZW9mKGNtZF9yYWRkciksIGhjaV9nZW5lcmljX2NhbGxiYWNrLCBOVUxMLCBOVUxMKTsNCj4gKw0K
PiAgCS8qIFNjYW4gUGFyYW1zICovDQo+ICAJYnRfaGNpX3NlbmQoaW8tPmhjaSwgQlRfSENJX0NN
RF9MRV9TRVRfU0NBTl9QQVJBTUVURVJTLCAmY21kLA0KPiAgCQkJCXNpemVvZihjbWQpLCBoY2lf
Z2VuZXJpY19jYWxsYmFjaywgTlVMTCwgTlVMTCk7DQo=
