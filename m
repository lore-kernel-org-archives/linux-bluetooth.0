Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1068C4361A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBFC22C7D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgLDSNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:13:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:54498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgLDSNj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Dec 2020 13:13:39 -0500
IronPort-SDR: qspLGO77KChXH4Becyz8GYSodMMUBdfiXn/1QUKiTgr6wTjeNKGNePNUnNkbos8iT+vjxg8Bq3
 6p1mtkIlxlmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="173572036"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="173572036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:12:36 -0800
IronPort-SDR: JjYNdbMh+9oiWi9+Zbj3vPLixipIANHmr7JWccecsGc+fAn8ZO18V7m/fYVWzseliorYZWNL32
 Syqiy0tkPNxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="482480489"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2020 10:12:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Dec 2020 10:12:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 4 Dec 2020 10:12:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 4 Dec 2020 10:11:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFLaIqOMzfNgfPb76XXhJ00c6ZTlUQgBQCkwgouTqbYK6K5sXipnIbtfoKZrXoSol2RlKT5Mpi2dQH0wSGdt8EUbk1eManJRrOeCvMqVYCzZIPNZ4IC/0AtutUrLUPDrfgV5EEZtwLyeMkYzAjJNJ2IK7H6qq+E71Bm+CtdKTyCBhwTKEN4NMoP9zbThunu5pVioYfVPemA3MIBiWqugtpDLzxJDyOaGG8rhuAhIuV30Df1MOGW4V7tnoS/z35fDnZlNPOQPdwOGPEtEgdTqZRjczmVDqXcAzmICcg4M3+8/fZpoJQH4BYL0hdj7kCPOzXorUqRyr142MVCo8u4usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J/f+O25OLijLuA+Knn0LkPiGwZGJoWE7DDvYaoSlQw=;
 b=agJbQRjs6YBDF57C8oeU0KKbWUsqV/sIpsHWSJPNnCgfPLKdFP+oJPL6HgkMbkydUam56BQvaQcNhl63em3qKZ3E0LPVVPJXcr284YD5OJhdcJ/F9CtGOGLpmginLpxHQ7gCx92d6tA4cPOvE6tjfy3eHXJtSYBfuIUkXarP5jLMmiPaMNMaHBTmtIVvfXgA5odSlBH189/28kAuNtxRkK6HfhSPfX+yzTZYRMi/mlnOXVp1t2vxxGqHZXEBksuDSblJh6jouol2Uq5mM/qqoqImd9M8avvZXWdC1H4PxKexo7G1KhGFfoe+tGgGjrY6L0Eq+sI7DD4yeYGNJ6rTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J/f+O25OLijLuA+Knn0LkPiGwZGJoWE7DDvYaoSlQw=;
 b=EqsNq5BEtGc3Jg1GTCfAoGsRhJUjnxQaQnRRjAmNmA7cC5LL5mwnRCoH6e3iiC5KppwskuacvZY1FCp8+IvtPeLgD4s15SO0K6/ZVdKNFihKSd1CcGVOcYD5SlhOPsF4ffI+7bepWJlzj7BbIckUYKjL6Qc2QZKYKhuZL45BE3A=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 18:11:47 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 18:11:47 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Zero out config node struct before
 initializing
Thread-Topic: [PATCH BlueZ] mesh: Zero out config node struct before
 initializing
Thread-Index: AQHWyO/IHe3Cvbpqr0GiVJQHsShJmKnnP/oA
Date:   Fri, 4 Dec 2020 18:11:47 +0000
Message-ID: <6c3dd7e32c77ff7e9c09de90cb39d70fd0cf867d.camel@intel.com>
References: <20201202211151.148651-1-inga.stotland@intel.com>
In-Reply-To: <20201202211151.148651-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a33e116-25cc-44ad-e754-08d89880106d
x-ms-traffictypediagnostic: MW3PR11MB4620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46204A6C77C5C2C9D49367BAE1F10@MW3PR11MB4620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsp9bHxc5BXd+tLQlU+DP6j3UsYrR/gFmjGfN4HSQwbMclWWjKRyuRc0OyNMO6Yr02Ti3l8QAbXYhUTMzfpAmOP/0AZ6Vpag88L84fVy23WIpeHfo+KLFjwdwCVgwuwFhRpUiTSOrx7vMwV4bwh/U+D1Ijelh2x5mkj3uEX5rIan/Ax+bH4prkvQgel2JtDsgfoiX1mXV8zqmNcNpO6q0yRyK8gEaWXRuZnSLnPxaG9oe/gQ/6mFCVajffElczhKjimu17K+FBKfMc0dQv1BlSWXY4pT5LCevcLXujYFxjfRvekk38f+ZtGOI5nqFsRGcfguSuMcD0G7u8NblqAJIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(4744005)(8936002)(6506007)(6636002)(478600001)(86362001)(71200400001)(8676002)(316002)(6512007)(110136005)(2906002)(6486002)(26005)(36756003)(186003)(66556008)(91956017)(66476007)(66946007)(64756008)(66446008)(76116006)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WCwBK2/EEjgJcHmpF60c9zJjyTHE6BqJGnrAK82fTkUGUnm2Hde50EB4To90HLhUomwaqwhB16jymVUrnzTUM/I+1IiuUsi4yp8wKtCJ2M8p6pflZW2dS3g+m2S0Ww84y9N+TQAmjN/qQU7bsS4ZjjLBFk7i9asCltmqog4mvP51eMQOGdm38/xU6h+gxSa8WEdkplptroF6LrbenNnzlw32uFKXJFW8qX6WLQioZjrnirBQ+51CEVmBYUpiraykvq4xDOdL/mIUYbNvSmdqkXNlwqMDFuM+XMZYnvIvzP86qB8R/Zi7rkWXJpOjnH+8cs+Dn/UfnnPigW5+sjAYZr4DEmeyrFrHx+jw3N2oZBULCl8cUw/K8PutjqEgJ9F5Q6L3cY2BWNi+NFCYCfMaVsEbr8+3bE3gkRplNiNAoB00v1qpinAuvpvcK33ChP/5deRWw3opFXRt/Ri6cIQgzlLGXfgXmr2EJoMHMXE7K/aqUuhzFVPuwHFaVndrjeXYV5aDwgzAU9mRc+Uc3lJ9oOsMVhSy6PKeO+7hXU6zlOFyugiMjlOH5EUPLblNOq5GrLGczJHNGxqhSgq3NWMVdypZLi/Kxn/NZF5XnREfLlaWsNGJ+elt2m84mOxVlD6ORc1GhNLSP9Y99n0Vf1RvbWI+5tJ+EJ4VcEOycEHAJkXPIGig4GLw4LkXxYHvGs5MJrvs/zXRu++2eLRbegUAyrwTzTSZuM99hi9qjuTkHvjLixEPfbm0iTkkgEh1I4Au
Content-Type: text/plain; charset="utf-8"
Content-ID: <713C3D0460CD134982D510B640442EFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a33e116-25cc-44ad-e754-08d89880106d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 18:11:47.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvlQE8WpAGW9VkOzXgwYGNpRZn3oBm0jl5nPUpJh2C+/F0lLDo+P/JJSluL4jOLFCSxRUFDO+HRqE6WEi/OASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTEyLTAyIGF0IDEzOjExIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIG1lbXNldHMgYWxsIHRoZSBmaWVsZHMgb2YgbWVzaF9kYl9ub2RlIHRv
IHplcm8gcHJpb3IgdG8gaW50aWFsaXppbmcNCj4gc29tZSBmaWVsZHMgaW4gbWVzaF9jb25maWdf
bm9kZSBzdHJ1Y3QgYW5kIGNyZWF0aW5nIGEgYnJhbmQgbmV3IG5vZGUNCj4gY29uZmlndXJhdGlv
bi4gSnVzdCBhIHByZWNhdXRpb24gYWdhaW5zdCBoYXZpbmcgdW5pbml0aWFsaXplZCBpdGVtcy4N
Cj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+
IGluZGV4IDM1MjkzZTBmMC4uNGJjMTEzMDliIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0K
PiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtODU2LDYgKzg1Niw4IEBAIHN0YXRpYyB2b2lkIGNv
bnZlcnRfbm9kZV90b19zdG9yYWdlKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsDQo+ICB7DQo+ICAJ
Y29uc3Qgc3RydWN0IGxfcXVldWVfZW50cnkgKmVudHJ5Ow0KPiAgDQo+ICsJbWVtc2V0KGRiX25v
ZGUsIDAsIHNpemVvZihzdHJ1Y3QgbWVzaF9jb25maWdfbm9kZSkpOw0KPiArDQo+ICAJZGJfbm9k
ZS0+Y2lkID0gbm9kZS0+Y29tcC5jaWQ7DQo+ICAJZGJfbm9kZS0+cGlkID0gbm9kZS0+Y29tcC5w
aWQ7DQo+ICAJZGJfbm9kZS0+dmlkID0gbm9kZS0+Y29tcC52aWQ7DQo=
