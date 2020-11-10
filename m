Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9CFC4741F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F8206B6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="eDMwGLGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgKJS0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:26:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:58379 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJS0F (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 13:26:05 -0500
IronPort-SDR: 2UzAtjypqjDHHmKpA+HhkzrDe7X7pTiNV2yXZrLsvFuaIg/AgrybaIR3flk+RhnkUOowzXq8Ow
 zjri9l6C3Yjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="234192671"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="234192671"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 10:26:03 -0800
IronPort-SDR: ixWSPMACqPTWgeSgf9bNzejXfCEJDfKYG1GfDeIz9IdOLS/2O+27N05DNKmuVlFTMpGhNdqllS
 Vq+0h8mjFVJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="327777037"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 10:26:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 10:26:00 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSWcxwDoZ+A/i5JGl/8udTSNqI6VvCGqbIthVE4QT7lz8RsMx6tn4UoE8mDugDJSDPbcNOIyJ288pWT3zJpYnsLsAwIJqXnhYtDelWt0lkwqDUIwO+fdjznzQEuRGmgkU3U4MltXt3SuYqWLissW5g+KzlzMpZfj9KZbmytuRDBhE73G8ak9UWsz+1cXWmAqFsJd4TfVcDvEEIpUhUpiexJrKs59ZbWUMS1E8Vc+9IqvukQnRd15HTBUHbg2xaGL7w+XK+pvAXZzd+Fe0Kz7b06+Z+jbmTwteP3pfJOMdfRk2X03ZjBPUsTYMpXzsPOVd4vlRqDRdzGqC+SNJ5RmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHVbcE4+c7BNQ7AWm9YswbZHT51YPPYVcDPo0FkJe3E=;
 b=kcPrCNkxi16OoggWixtdQKr4wWjiN4SNajw/eOcudEb751IWWr2syLSNb6+j/i1bfZ89wjG1u9WOCC1xbtd5NyCvagnb1jKAD2wRv6umYG/loR3/irb37L70qN/GeIIGljYlvHUn/YdrU7CbP/Kmrcmpqz1AsXJGFN0JiucG5SPwIiOcTgE5abMadWWfDiFw6NZY21uFyr9+RAUgdkTbEN5YHXz0hDPNDbsxiJxeIh/ryMVtdVZ+bWoMXspmSlgPAlbO4KRsE73W2LB/wfm0h+FzZDPb6cHkNu2BPbcY1Ycqd6+nKp1j8cOQLv7NnEbe/vNi4hc9rL9HmGi1uWhXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHVbcE4+c7BNQ7AWm9YswbZHT51YPPYVcDPo0FkJe3E=;
 b=eDMwGLGAZKX0StH+0KbntUGYLGuaUJOS/bX1rmzv1pA2lv2ib8c1kmeIAxuL5GrUq7BVb/3A0wlhYTQKeNGG41ZvY2ogovk+Exe1jD4Hrc1Hw55Ml4O9BIdYQLK0Z6NZPjvs2KXAtceztyaLSoqmG5OKMvbPJdhCNuJlXs7ce04=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2029.namprd11.prod.outlook.com (2603:10b6:300:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 18:25:54 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 18:25:54 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix memory leak when failing to load a node
Thread-Topic: [PATCH BlueZ] mesh: Fix memory leak when failing to load a node
Thread-Index: AQHWtxl6zeVWAINOwku0vIqHwvaHbqnBr6WA
Date:   Tue, 10 Nov 2020 18:25:54 +0000
Message-ID: <18cfb30ac42a011185e7ddd27a0e32292efc4fb4.camel@intel.com>
References: <20201110042451.71288-1-inga.stotland@intel.com>
In-Reply-To: <20201110042451.71288-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dae422a-8a6c-49f9-f202-08d885a60f7b
x-ms-traffictypediagnostic: MWHPR11MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2029CE98670826735DD2DB6CE1E90@MWHPR11MB2029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vrPwpq0K9oooSynivWGYKaxhsBtEkzEhg5DkQmMLN4QzZMReuQ80R1kVyhn9R7Q13DuIxFBQZ9oxs2eTxGQqCm02gMNmGgqUUrgHp4f+kwkfC6P+ohrVXhepHzPDHBNY5Qi73hvuvy4YnDtjuRN2DcO7GTthitc6dWIEj6WeWAst0+i1UVKR1+KF4QybXHtN6eVdThzvUf9kpLrVPBtx67Zv7FcYGnEh+b8DHRIPGScOIf9Z4svtWSvE1DckUemYzn2Alphn9YZwN2BpGxL1zb21QLZNlm5wkgrM8as+0E2spZgW7yD6FfuZcRzTFWrjWnVueux44dpXL4oACGstvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8936002)(83380400001)(6636002)(86362001)(2906002)(110136005)(36756003)(8676002)(26005)(316002)(186003)(6486002)(4744005)(5660300002)(2616005)(91956017)(66556008)(6506007)(64756008)(66946007)(66476007)(76116006)(66446008)(478600001)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rLOdiqQVc3NqEKDzwj7NbDqEyrxKYw85TOq18jtfNyuOCpWw6AmmwKgi5CuMIcCbIW92c2C1Au/DhscsLQNqy8L4hFP+ciS8OWVz5xeH/qetW8sDL/S9pD6FyEWGvySVaL7wjZp5hqfEF9KMq2nLekVkfyVyd2ahPDtJKQs3wJx8UvdbImgmKQ3cYmv5/+0Y//WbEnHFJJoFQx+Q20Y7sGDQohpet7AmbNEZOiEZVSwOI5fk4OtBW2UnosxZ8IV4mRqkcGSSbpxxuIXBkdUre0aewBQAeesBZpor0PPsBnXQKtr9h0Okqi2m7/GI66Sobf1owkjZeDazbBnVvBf9WOjRCmLW/DAyCtfjk97+7BRxGRLPnYklhaDD4EYYOrw8Bs5wB95ow4hUxyQ5DaefcUiIltPNBhvaZzZ00+FdnXKrUF3Vz8PV8sUP841zLyrVcchVi9SdooSC3ndU9bLpaaSgwUBkT3VJ7T9Laoya+mqJtP6kS4AbqAOpSKkQj98mXXSf0ZEt1yhB3TejU4C2Y8kd3LWuqjEEEK3G7xBehNg+tHLOXVbEvT9IVEO6Li2/Tt38YarbdwYew09EuzjzZEtwJ4rm30JgsXWIL0rI6jGp6eRCfCBoqqKfXIZ/tMpjZaD65VQ3rHOgC+kyObwgMp3I5xijmtKvMRFoYLq5XuKvzcJ5eP7HsKok3kagcQJkyysKkyB2R8kyyHs32TquFF5IlkYTTC0L0NdvZItlJO6ZkmP3EPExQ7ZUsiYRfb+BHIXoyV8hakqHmUjW9KQjO033o/HW+SM822q+ILEzWH7UsOK2jy0vj5Ngd67sSVGdlq9LbjDTeuehARTLXvQpxBt+MVN6R8KnWigkq5RksfhHG6XhER6I14tSFeQP0M2EWp+lvArU3kcX8JTlGyCC8Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E476170FCF0264FA0F8892ED86A6518@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dae422a-8a6c-49f9-f202-08d885a60f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 18:25:54.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rpx/x9s5ad4nC36QOJuYVkTWlFeIVmg0KQV7Hdz4H9jq6etPzP1OmZO4ot3agiBNYh2k1hRy13JuxRwm1ZyVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMjAtMTEtMDkgYXQgMjA6MjQgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgYSBtZW1vcnkgbGVhayB0aGF0IG1heSBvY2N1ciBvbiB1
bnN1Y2Nlc3NmdWwgZWxlbWVudA0KPiBpbml0aWFsaXphdGlvbiBmcm9tIHN0b3JhZ2UuDQo+IC0t
LQ0KPiAgbWVzaC9ub2RlLmMgfCA3ICsrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9ub2RlLmMg
Yi9tZXNoL25vZGUuYw0KPiBpbmRleCAxMWIwYzk0NDIuLjM1MjkzZTBmMCAxMDA2NDQNCj4gLS0t
IGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4gQEAgLTMyNiwxNiArMzI2LDEz
IEBAIHN0YXRpYyBib29sIGFkZF9lbGVtZW50X2Zyb21fc3RvcmFnZShzdHJ1Y3QgbWVzaF9ub2Rl
ICpub2RlLA0KPiAgDQo+ICAJZWxlLT5pZHggPSBkYl9lbGUtPmluZGV4Ow0KPiAgCWVsZS0+bG9j
YXRpb24gPSBkYl9lbGUtPmxvY2F0aW9uOw0KPiAtDQo+IC0NCj4gLQlpZiAoIWVsZS0+bW9kZWxz
KQ0KPiAtCQllbGUtPm1vZGVscyA9IGxfcXVldWVfbmV3KCk7DQo+ICsJZWxlLT5tb2RlbHMgPSBs
X3F1ZXVlX25ldygpOw0KPiArCWxfcXVldWVfcHVzaF90YWlsKG5vZGUtPmVsZW1lbnRzLCBlbGUp
Ow0KPiAgDQo+ICAJaWYgKCFtZXNoX21vZGVsX2FkZF9mcm9tX3N0b3JhZ2Uobm9kZSwgZWxlLT5p
ZHgsIGVsZS0+bW9kZWxzLA0KPiAgCQkJCQkJCWRiX2VsZS0+bW9kZWxzKSkNCj4gIAkJcmV0dXJu
IGZhbHNlOw0KPiAgDQo+IC0JbF9xdWV1ZV9wdXNoX3RhaWwobm9kZS0+ZWxlbWVudHMsIGVsZSk7
DQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICANCg==
