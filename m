Return-Path: <SRS0=cSIk=BX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6216C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A29206B2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 22:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sMPcR3rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMWFo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:05:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:39661 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHMWFn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Aug 2020 18:05:43 -0400
IronPort-SDR: pZJciN7vc5UsXXdQ+8lZ0co191q34apyv+PAHiXirzLmM2tKfxRSg1Rlai2nrCJk3VpkrtX9lA
 0RmpJzgqw0CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="155441746"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="155441746"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 15:05:41 -0700
IronPort-SDR: 2UBCv+9rmNvVdDKgmdBUCJUGpwHJjB84evv5yohB9WQ0wNR/WkONbyPQew6FzsHe5+wxJcHw71
 cS6zi6j4UVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="276968489"
Received: from unknown (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2020 15:05:41 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 15:05:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Aug 2020 15:05:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 13 Aug 2020 15:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHvh7EOkjRfi2z6M+ZBGBuRRHesqt1kky5E61JCk7LpSkJzPszWq2Z9y+lcXokjnQ6sk5kYtlw0WDXQfAmH/DB7HBlBbb+NSkauBxCF5pcBL8m5hPvM9NQ8TyO4a/btu5G9lAErsv14zuKpUaPcDsrkU1hFKUmhz5fvLX5xmtojUN4QwnS/7OS2/bKR+KLzgVKC6M88+BH6gBg11j3QcIcaZmHk2RcDxzJHI3XvfgMr/3JaO6MHDtyS+dw3X0gooVXgVDLYFdQL8ar6+lp6mYbfl/zlXi+aiydOoURAmmSLQNyiLl3zuL42twZJ/Vpv/RXphE9oBdqIMtvMrlrIgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMca/oLyGjYBIftnTJw0oz5dtN8XJ5z3yfjjFVsz7As=;
 b=nu0BQnRsCpi0e+X1NNvzqeD9fu+NY4W4WSY8vR/ojprfzW5EyWRHU1yvNrfdhV7nwCwglMQ0SBkBQxa2XoPRsHfjPKcsWj1EePVX1Haeg7tQlBYYKpgKvVa0k8By8W9scZVcH9yiw7kgjn+AXHK1K6StT+JqJhzbao2Bc4vHTnnyPPxDnCLNPtp49uUsQtvxlArhQlp3D6SC/ZaLVb4cWjWISJhkgnb19WrLbbeCZORt/z2ffHVM1HX2ULyurUrBx5RrbbGBKBxi0rPTbSEgElfnQSxBdIGRVjMD2TVtwfTkHMbfRBk5qUsjME2rryR7z4xan0EDh6BEOXGViu1+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMca/oLyGjYBIftnTJw0oz5dtN8XJ5z3yfjjFVsz7As=;
 b=sMPcR3rPp/tNdQrCv+GByo2FrEhlVgkiheUT1wbpXoELalhLg+qkt3EfR9M46G8huLO8Y6zHOyJmdtVt9Q13U8BJ6k0MdOht/LxXGUMH3n47mqUxEhCBPTsc7Du60946ZjUNAGLA0df6Kg3bqpLhqN4KvN2xYu44zDuS26wHfL8=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1791.namprd11.prod.outlook.com (2603:10b6:300:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Thu, 13 Aug
 2020 22:05:39 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 22:05:39 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ 1/2] mesh: Fix model ID prior to calling mesh config
 functions
Thread-Topic: [PATCH BlueZ 1/2] mesh: Fix model ID prior to calling mesh
 config functions
Thread-Index: AQHWcNtEnuhduX/s2UOK1SdgwF0M66k2mgoA
Date:   Thu, 13 Aug 2020 22:05:39 +0000
Message-ID: <3e4a1b55178ae1099523669695792fd8de328ab7.camel@intel.com>
References: <20200812190317.102140-1-inga.stotland@intel.com>
In-Reply-To: <20200812190317.102140-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a089729-9b21-4976-f4b9-08d83fd50383
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1791D5DAB9795C51E44293F7E1430@MWHPR11MB1791.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UwEvdRWMgo+XTvs0oXTl10Y4ixc/tSS2OcVep0jeOgbVqnXMiqJV0DAT5kIhQPEVhPpD4BXaZAHEhlZfBcDs9qUEzyBiWeYYqjtr+m/NdIHyjiFmJ9nThvtvzyGhW95m4bEsesBek8lEOyhPf5AFZ7TvLPpzI3ZjG0RA+cQln7IT1Br57KklXDMicSW+N9XRL0TsKsRZe73MGOiwIcV/JVBV+6RKRDq86ZTjOWOKI08o4OcYE3lGhUbX1QxuLeSzFHSfPIxIDpmpX+Zb34jI1PMMIeMadK6QGC+ylhbDrDwtsTOYJ8rCYTdAIVCoxJy/TvhN9eekQqBxHtwdayAiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(5660300002)(66946007)(64756008)(66446008)(91956017)(186003)(26005)(71200400001)(8936002)(8676002)(6506007)(2906002)(76116006)(66476007)(66556008)(4326008)(316002)(6512007)(83380400001)(110136005)(6486002)(2616005)(6636002)(478600001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XtBFgH5R8G79fR4BPqtaHoQUvTTNDVUsus4Ifoi2hyW2mCX6cdHJlFXud6A9ZTGhCVULyzn1DjEVT2wu/WLAEZS6bHznh6TnaiItwNOAcLrgomMTH997C/nzToL8WZOgLs9Ocz1koJHj8fHhmA2wW4sGThM1xxwjPJZomjcVMKquN7GSlBlRXHu17UCosz+lO5ucFVHTyPp3o0G3MLnS3b7mUwQfOHpCWGVqHueFWFYNKIv27jTkd6/iTeeyik/gvvFflqVfND/2jCBU64z2SNNbzLJOumugMCkz7Eddjnzl5PmeOONM/Ibl5PV8N+aE/uOB9M/VJ6PxVwmQQO9fYKKOnmYd2w8wcx36b3SUXraDxWMBlrZ0jKInDzSCqCBRq5bPTYqy3UaxM8c3RFzZREuyAd30hFD78xdcm7jBBwjCj2YZhVw3HT6ooLtO06gaOvjXKuyLdv3eHm2T+ZSfoVI1b52UqhKeM7qnLeFzjFQo8EXaBZP/H5PaENxy4Ito+NDbSdy08667YCBZkVOfHsyXY4OzDW0tiolEtQZxbodZP7l9eF1OmLSlGTPU7wwSEqhxA1RubBpRznIAfbaZIJ8G5BQuaVIBM6xyAUwTtZ57CKJn+DEuvzv3mWoi5tl4vqYB8AOjXJkPF4NdZrlC8A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F576B6E33E55824081C54E2FA513B57F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a089729-9b21-4976-f4b9-08d83fd50383
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 22:05:39.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xitRmvJa9fdFa/fkZ30yaen+Gg+a93EYJL59fq4+wggLY+rK5LVlbn+74FoMuSW906o5mNhIKy46U6ZLZjhAOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBQYXRjaHNldA0KDQpPbiBXZWQsIDIwMjAtMDgtMTIgYXQgMTI6MDMgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IE1vZGVsIElEcyBmb3IgU0lHIGRlZmluZWQgbW9kZWxzIG5l
ZWQgdG8gYmUgc3RyaXBwZWQgb2ZmIFNJR19WRU5ET1INCj4gdmFsdWUgdXNlZCBmb3IgaW50ZXJu
YWwgaG91c2VrZWVwaW5nIHByaW9yIHRvIGNhbGxpbmcgZnVuY3Rpb25zDQo+IHRoYXQgc2F2ZSBu
ZXcgbW9kZWwgc3RhdGUgaW4gbm9kZSBjb25maWd1cmF0aW9uLg0KPiANCj4gQWxzbywgcmVtb3Zl
IGR1cGxpY2F0ZSBzdGF0ZW1lbnRzIGZvciBtb2RlbCBsb29rdXAgaW4gbm9kZSBjb25maWcuDQo+
IC0tLQ0KPiAgbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMgfCAgNyArLS0tLS0tDQo+ICBtZXNoL21v
ZGVsLmMgICAgICAgICAgICB8IDEyICsrKysrKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gv
bWVzaC1jb25maWctanNvbi5jIGIvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMNCj4gaW5kZXggYTQw
ZjkyYzAxLi4wODZkNjE4YjEgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWVzaC1jb25maWctanNvbi5j
DQo+ICsrKyBiL21lc2gvbWVzaC1jb25maWctanNvbi5jDQo+IEBAIC0xNjksMTEgKzE2OSw2IEBA
IHN0YXRpYyBqc29uX29iamVjdCAqZ2V0X2VsZW1lbnRfbW9kZWwoanNvbl9vYmplY3QgKmpub2Rl
LCBpbnQgZWxlX2lkeCwNCj4gIAlzaXplX3QgbGVuOw0KPiAgCWNoYXIgYnVmWzldOw0KPiAgDQo+
IC0JaWYgKCF2ZW5kb3IpDQo+IC0JCXNucHJpbnRmKGJ1ZiwgNSwgIiU0LjR4IiwgKHVpbnQxNl90
KW1vZF9pZCk7DQo+IC0JZWxzZQ0KPiAtCQlzbnByaW50ZihidWYsIDksICIlOC44eCIsIG1vZF9p
ZCk7DQo+IC0NCj4gIAlpZiAoIWpzb25fb2JqZWN0X29iamVjdF9nZXRfZXgoam5vZGUsICJlbGVt
ZW50cyIsICZqZWxlbWVudHMpKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiBAQCAtMTg5LDcg
KzE4NCw3IEBAIHN0YXRpYyBqc29uX29iamVjdCAqZ2V0X2VsZW1lbnRfbW9kZWwoanNvbl9vYmpl
Y3QgKmpub2RlLCBpbnQgZWxlX2lkeCwNCj4gIAkJcmV0dXJuIE5VTEw7DQo+ICANCj4gIAlpZiAo
IXZlbmRvcikgew0KPiAtCQlzbnByaW50ZihidWYsIDUsICIlNC40eCIsIG1vZF9pZCk7DQo+ICsJ
CXNucHJpbnRmKGJ1ZiwgNSwgIiU0LjR4IiwgKHVpbnQxNl90KW1vZF9pZCk7DQo+ICAJCWxlbiA9
IDQ7DQo+ICAJfSBlbHNlIHsNCj4gIAkJc25wcmludGYoYnVmLCA5LCAiJTguOHgiLCBtb2RfaWQp
Ow0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5jIGIvbWVzaC9tb2RlbC5jDQo+IGluZGV4IDIz
YWZiOTNhOC4uMTM2ZWRiMTk0IDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVsLmMNCj4gKysrIGIv
bWVzaC9tb2RlbC5jDQo+IEBAIC02MjgsNiArNjI4LDcgQEAgc3RhdGljIGludCB1cGRhdGVfYmlu
ZGluZyhzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBhZGRyLCB1aW50MzJfdCBpZCwN
Cj4gIAkJCQkJCXVpbnQxNl90IGFwcF9pZHgsIGJvb2wgdW5iaW5kKQ0KPiAgew0KPiAgCXN0cnVj
dCBtZXNoX21vZGVsICptb2Q7DQo+ICsJYm9vbCB2ZW5kb3I7DQo+ICAJaW50IGVsZV9pZHggPSBu
b2RlX2dldF9lbGVtZW50X2lkeChub2RlLCBhZGRyKTsNCj4gIA0KPiAgCWlmIChlbGVfaWR4IDwg
MCkNCj4gQEAgLTY1MSwxMSArNjUyLDE1IEBAIHN0YXRpYyBpbnQgdXBkYXRlX2JpbmRpbmcoc3Ry
dWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgYWRkciwgdWludDMyX3QgaWQsDQo+ICAJaWYg
KHVuYmluZCBeIGhhc19iaW5kaW5nKG1vZC0+YmluZGluZ3MsIGFwcF9pZHgpKQ0KPiAgCQlyZXR1
cm4gTUVTSF9TVEFUVVNfU1VDQ0VTUzsNCj4gIA0KPiArCXZlbmRvciA9IElTX1ZFTkRPUihpZCk7
DQo+ICsJaWQgPSB2ZW5kb3IgPyBpZCA6IE1PREVMX0lEKGlkKTsNCj4gKw0KPiAgCWlmICh1bmJp
bmQpIHsNCj4gIAkJbW9kZWxfdW5iaW5kX2lkeChub2RlLCBlbGVfaWR4LCBtb2QsIGFwcF9pZHgp
Ow0KPiArDQo+ICAJCWlmICghbWVzaF9jb25maWdfbW9kZWxfYmluZGluZ19kZWwobm9kZV9jb25m
aWdfZ2V0KG5vZGUpLA0KPiAtCQkJCQkJCWFkZHIsIElTX1ZFTkRPUihpZCksDQo+IC0JCQkJCQkJ
aWQsIGFwcF9pZHgpKQ0KPiArCQkJCQkJCWFkZHIsIHZlbmRvciwgaWQsDQo+ICsJCQkJCQkJCWFw
cF9pZHgpKQ0KPiAgCQkJcmV0dXJuIE1FU0hfU1RBVFVTX1NUT1JBR0VfRkFJTDsNCj4gIA0KPiAg
CQlsX2RlYnVnKCJVbmJpbmQga2V5ICU0LjR4IHRvIG1vZGVsICU4Ljh4IiwgYXBwX2lkeCwgbW9k
LT5pZCk7DQo+IEBAIC02NjYsMTMgKzY3MSwxMiBAQCBzdGF0aWMgaW50IHVwZGF0ZV9iaW5kaW5n
KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IGFkZHIsIHVpbnQzMl90IGlkLA0KPiAg
CQlyZXR1cm4gTUVTSF9TVEFUVVNfSU5TVUZGX1JFU09VUkNFUzsNCj4gIA0KPiAgCWlmICghbWVz
aF9jb25maWdfbW9kZWxfYmluZGluZ19hZGQobm9kZV9jb25maWdfZ2V0KG5vZGUpLCBhZGRyLA0K
PiAtCQkJCQkJSVNfVkVORE9SKGlkKSwgaWQsIGFwcF9pZHgpKQ0KPiArCQkJCQkJdmVuZG9yLCBp
ZCwgYXBwX2lkeCkpDQo+ICAJCXJldHVybiBNRVNIX1NUQVRVU19TVE9SQUdFX0ZBSUw7DQo+ICAN
Cj4gIAltb2RlbF9iaW5kX2lkeChub2RlLCBlbGVfaWR4LCBtb2QsIGFwcF9pZHgpOw0KPiAgDQo+
ICAJcmV0dXJuIE1FU0hfU1RBVFVTX1NVQ0NFU1M7DQo+IC0NCj4gIH0NCj4gIA0KPiAgc3RhdGlj
IHN0cnVjdCBtZXNoX3ZpcnR1YWwgKmFkZF92aXJ0dWFsKGNvbnN0IHVpbnQ4X3QgKnYpDQo=
