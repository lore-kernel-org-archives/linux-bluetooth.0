Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3736C4741F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AB7206D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sHYJlTMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKJS0a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:26:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:58404 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731432AbgKJS02 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 13:26:28 -0500
IronPort-SDR: 0AYW+ptQQJAPFV9AU0aLZQIhZkDjI3cqXalO/TTb922QZDUUe5MKKiF8I8aP2JkuXRsEixbHPl
 i3fEFk+gQ27A==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="234192737"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="234192737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 10:26:27 -0800
IronPort-SDR: 4KtP5pxyZBYs6xlCoOGHVuDpl7CbFt44NMgF2nfIpOPU20m1gl8hVB8VUgdeCDi/OyoxIWV2u4
 TUCmrJTljglg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="327777316"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 10:26:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 10:26:25 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTwyr4Kg35DK0472uuKX5q5rcm4TgOKFqiKlIR1UpKFanxEvrK0AKYcXnWRj2ocTuaBOMylLGSzftKVXxRqQGkCkdNVh0tWZufwfs93XhHm+i/m1Fdft/7IkqcwIv2fXHnqfLLSQQ+v97hrCxmDG5avY1FfiLiitgmogy5wAHt6JXoO+xyH106NyLZLb8BuatLY8mFU1DbEv+iESattfyEGfy2uqXYNsAWSPEeKk9NTTlT+77QKMpBeiblDJywDcMlJUQVx+OPPAarLSIa1HlquL2enapzNXga5qRQ64WdDacvrOqIOjlDHpgyxcFg++4dZWUF8s9sBP9bp8dhllzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Tf7o/bVeMf6eCKOFrStYDRzcEoW/CWsCKpOn02xvs=;
 b=DJLNRDdXB9Q88/Y4tIkGI/WJacyr/Jm4YeZmKpF6tV88gMwvFqsEq/g2QKV8VKSY2XcsVucYzsG6leHK+zw36DIsQ2KpoPXH++wDfJgyFY53TSEIzQHFJn2vbzabi6GIoEsM73X6qBF2w6t3JKcyv9PegfuDTTLTvXy8sMiceXMA2Y98N6UlwLStIGMXqbNgiYhavigKRe5QYAg7Fqby0tphAWNYP/9yXwigiS+ltqpiNl3gEDgBKBC7MMxHiuGiLgvXVlnb9I3oqw1maK0OYykLr1MCHDpoOWtcYz+qtVDuuS/KNCVi8qU47OffC35htBkfdUsCv2EhK/lUpD0sSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Tf7o/bVeMf6eCKOFrStYDRzcEoW/CWsCKpOn02xvs=;
 b=sHYJlTMDxGOOClTRfs/OFpFZ0hHsAzIlzbjKSKJyGKIrEwvJAOAWSM+/e1MDyOPcKyzdb5Osigcy8C+9ytRDen/wEV/M7txDWnsu98KeEqqH2azyfAg96SxY1093nXWCmZKYXYao8up5RvHBZpGauARInhtTRr3Ci+Fl6RJ54Ew=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2029.namprd11.prod.outlook.com (2603:10b6:300:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 18:26:24 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 18:26:24 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Only deregister io for the last network
 detached
Thread-Topic: [PATCH BlueZ] mesh: Only deregister io for the last network
 detached
Thread-Index: AQHWtI8TKfky1IjJjkqONxlSxSZwNanBtN6A
Date:   Tue, 10 Nov 2020 18:26:24 +0000
Message-ID: <3f781f7f1056d768dfa99d89201f610c809a18e6.camel@intel.com>
References: <20201106224811.1987610-1-mike@mnmoran.org>
In-Reply-To: <20201106224811.1987610-1-mike@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: mnmoran.org; dkim=none (message not signed)
 header.d=none;mnmoran.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f497285-8942-431c-702d-08d885a62185
x-ms-traffictypediagnostic: MWHPR11MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2029992EA6AD997D18675A5FE1E90@MWHPR11MB2029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDqTiYVm3LZxuyBNDc2CEzc+/FGsShnxnPEEeZZP4df1IAhs7olFYa6R4LBLrXTHqgBijSGn/QzE8L9J/1UFu9q9BDza2rlHmT4G9fFc4Cj+7Q7PwFEDE/CTuJFCgs6i7GaNNnaACpsrLMohM4kxx6s+3IldX3fLx67wSsY30me8NSnnBILrU/3yfdp6rOhS+hZ6VIAH2mlDMgGaADf7EX08fAu/nlNagmChD3Gsuuuhe5zXFIPifyPa6uVguatgvGVyPm3o/UwM0AI8/hnGs3QhBvbOLX1C66LXDHCVmMbd3/Sa+42/2wHc3wd/zIH5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8936002)(83380400001)(86362001)(2906002)(110136005)(36756003)(107886003)(8676002)(26005)(316002)(186003)(6486002)(4744005)(5660300002)(2616005)(91956017)(66556008)(6506007)(64756008)(66946007)(66476007)(76116006)(66446008)(478600001)(71200400001)(6512007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VBcRQGckJD8aFHC4rVQH1WFih38qTK6G3WGg7uGTmIeKtixvZt9WJczpLxdy5/xo6AwKoRIZCmES9PNiBek265DwmJXdohlqe94BYXEzK9UnParuk5O0LiD1fwbLzb2P1dvZ7ticJK6luaMd8Y8HlYIZ47jwkUBiSqSRCvAGpGjr8Cmr73n0gaYGqcYKMBSmFB4tgqySdiQqJrSTs7ZFHvquiHBcSgqBJBdjdAZ7OZozmZ5W0LZB7Bb1xxv5x0Ft/RFkUomi8Ixq8Z71UPmrLhBj94lG1ZHCeijSKDrubMgsab+hvXw7U6HwIkeUsnV34bk9bO0G7GTgi+vg8IRBnYXzjqy3Bbsjs2ipfKXI68l8jZM41t0jEBcfFErV/YZMVqnzHsYMm5O6MlYbV3ZruXLaOEBe7sNfGXpxy+1R23Fv4tT72tf86Iwmc7D9ac402boZ/ByXfGgUGIVdnLdruLn+ctngpERmopk/1j9WtZd+tsbl29i81bVTdSBM9DPgngvV9aTvrFbRlcET5ARqRHve5ZoBJwFzXj+CpzU0E4Y9r2C1EIrLlI2fPcxE8UJCCU338+UTjm15Rib5KV7ZkKTB4gnLpSzhi+3BVznCQL7ID0jWkZGsYffKBc6/6VjxboTIVvaIs5R7K8Z0VF9pcsK5yPQg5D/pTwTuiilV0qDkZLwVkAOs3xWghuV0KgJv0j8STGhZZ3bOqjLPEHJVwyotQacDCe55LzpwlaoYaVS280l8J1DjDVwSIYOnXeTMjrHSXEAkvs/visexicDpfIivbRz1bBsvjlfoLTCZInzmRMUt7Z1gQ6Q37hKGUqmNI26m3aJtgdCWOG+2szaWkqra93R5qnatUdq0uGO6K3poKEEhN2Z8Yb4nccG+xzapxyMuztA9v51fDHOoqWZi3A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B34D6722D3D754C84882D1867C98606@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f497285-8942-431c-702d-08d885a62185
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 18:26:24.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0UB2dG+I4MmclSNBbCDLpPiwol09f6j9+/mghM1w4HSlUQ1EpyZWzTT4q0iuQvBi4VkvD1xEjUgLvik8ElkWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMjAtMTEtMDYgYXQgMTc6NDggLTA1MDAsIE1pY2hhZWwgTi4g
TW9yYW4gd3JvdGU6DQo+IFdoZW4gbXVsdGlwbGUgbWVzaCBuZXR3b3JrcyBhcmUgYWN0aXZlIGFu
ZCBvbmUgaXMgZGV0YWNoZWQNCj4gdXNpbmcgTGVhdmUoKSwgdGhlIEkvTyB0byBhbGwgbmV0d29y
a3MgaXMgaGFsdGVkLg0KPiANCj4gVGhpcyBwYXRjaCBwcmV2ZW50cyB0aGF0IGJ5IG9ubHkgZGVy
ZWdpc3RlcmluZyB0aGUgSS9PDQo+IGlmIGFsbCBuZXR3b3JrcyBoYXZlIGJlZW4gZGV0YWNoZWQu
DQo+IA0KPiAtLS0NCj4gIG1lc2gvbmV0LmMgfCA4ICsrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IDAxYTQ3NWQ3NC4uOWUwZWE4NjBmIDEwMDY0
NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTI4OTksOCAr
Mjg5OSwxMiBAQCBzdHJ1Y3QgbWVzaF9pbyAqbWVzaF9uZXRfZGV0YWNoKHN0cnVjdCBtZXNoX25l
dCAqbmV0KQ0KPiAgCWlvID0gbmV0LT5pbzsNCj4gIA0KPiAgCW1lc2hfaW9fc2VuZF9jYW5jZWwo
bmV0LT5pbywgJnR5cGUsIDEpOw0KPiAtCW1lc2hfaW9fZGVyZWdpc3Rlcl9yZWN2X2NiKGlvLCBz
bmIsIHNpemVvZihzbmIpKTsNCj4gLQltZXNoX2lvX2RlcmVnaXN0ZXJfcmVjdl9jYihpbywgcGt0
LCBzaXplb2YocGt0KSk7DQo+ICsNCj4gKwkvKiBPbmx5IGRlcmVnaXN0ZXIgaW8gaWYgdGhpcyBp
cyB0aGUgbGFzdCBuZXR3b3JrIGRldGFjaGVkLiovDQo+ICsJaWYgKGxfcXVldWVfbGVuZ3RoKG5l
dHMpIDwgMikgew0KPiArCQltZXNoX2lvX2RlcmVnaXN0ZXJfcmVjdl9jYihpbywgc25iLCBzaXpl
b2Yoc25iKSk7DQo+ICsJCW1lc2hfaW9fZGVyZWdpc3Rlcl9yZWN2X2NiKGlvLCBwa3QsIHNpemVv
Zihwa3QpKTsNCj4gKwl9DQo+ICANCj4gIAluZXQtPmlvID0gTlVMTDsNCj4gIAlsX3F1ZXVlX3Jl
bW92ZShuZXRzLCBuZXQpOw0K
