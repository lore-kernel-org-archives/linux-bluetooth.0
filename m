Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75495C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BD020797
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ivkL/eyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgKJS0Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:26:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:42071 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbgKJS0Q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 13:26:16 -0500
IronPort-SDR: muCS7L+HCdjlzMarUA5XgygK1wPuqobTBBryS1jYvgqnaaLOgrB1ZGYZVmyxM8mUmOxSkkt2ib
 +y2AJ2aLr1Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="231653566"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="231653566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 10:26:13 -0800
IronPort-SDR: ENSSR+TiCYHPyL+/Jn2o5sgWIG/MI7DKF6SDzizQ5+1vIdx02hab7Y0PTSbsMBgIqAxvIWJb27
 Gq+D+YzEizzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="356260232"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2020 10:26:12 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 10:26:11 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNeJi5tW8UXUWDgdZpl92V6+IFTa6WREHgHZsGc7T4EMpJ1MmK/VVyL3UF812wCv+WG/j+uCz25eyROxWv7JGrxYSxRXBrGpiwSyQbpxXMKApUKnCuuh33m9y0z29pndw/EDvk/Ic8Cwkk/aZLU6rOlQuNlQaAEL7tQjdaD35gG/6mWtF5zzOfeKNra8J/6oeSf9bkQMw4OU81/pGW9DH2cn3vd2vAJi5ulduvXV7s2tmzHjMLSg1jKpP2nw3CTpzjYR12Mn7endrthiQ5uqVKA9vz/V8QCnvNr6dl5GJ5iQpcMEL39WwJew4uleSlupeB6zgH+ICW/CrATX//WIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7nRydQxN4IfAt3ZKPYczOumv+Fci9WBVmUPmlpYRwY=;
 b=PB3h6oWHyVKWh4oWYbIKfQqdsZ5smuXgu9uf9eu0IMkX5PC4K+XWgY9FBvBrK0wo0Qwbs7kI2IBbnVQrlAXeC/i14vCb+Gy8bbO3xGyxVIFRHaVc8fRTcfqRkjWrECu6a+855zD/EaQKvGqPH0eRu/1KRqZ/YYG5dv5gUpz5qrA9Tp5OMhHoOYSFOjCDhgqoXsj0NPdFAHlyHYrq/NWHXaJV4kIyekuM56rE+nCn3TiJgaSBhz/goREefwbMG7/5z5Gm/3eGvuikooKWcBCATlL1EJQX1ThxUDkEUVf+r6SJGUjfcHO/vYAAau8DL1CI4wlI6mY6WXFdAEG89J/InA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7nRydQxN4IfAt3ZKPYczOumv+Fci9WBVmUPmlpYRwY=;
 b=ivkL/eykPLKoThXimxTTUenn3eDVLwJ82BbyUo0HnlaJY6OiMAXqZQfm+KCu6jq536YydypMU1IodCk+FHlgu5wMfDGc+KSH+ENK4wJPrx1gPToMvpviA+wJUaVtMJaYj6kgUsHiMQLyv5hYd0gBL6NxG7zzAoEMPL/y3dxbpWE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2029.namprd11.prod.outlook.com (2603:10b6:300:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 18:26:07 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 18:26:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix memory leak and NULL pointer dereference
Thread-Topic: [PATCH BlueZ] mesh: Fix memory leak and NULL pointer dereference
Thread-Index: AQHWtxkBeQchSBtZa0e+bkdM/s/ZEKnBr7UA
Date:   Tue, 10 Nov 2020 18:26:07 +0000
Message-ID: <528e5135dc4a98f6375d3a75594c183c3fa3c923.camel@intel.com>
References: <20201110042127.71045-1-inga.stotland@intel.com>
In-Reply-To: <20201110042127.71045-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6629252e-a2ce-4722-47ba-08d885a61753
x-ms-traffictypediagnostic: MWHPR11MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2029968832A71EC0BA31739CE1E90@MWHPR11MB2029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xi6OwXF76xhHA8fuUzgHLQxzB0cVJdD6jXl0LW0qPZ8kTM5K/7hGXZW/60OOPYSooRG3KBCwVz6YkhEbaJjR61h2SqmLzhSkseKPQ8wYuWPo/FWbYjk63a4m6SMHi3G0HEorGki+T4Lxa13TKDKm6zHWjKCrmHO1UdMPQD76tZFDXIRRf7uGh0IgYpQZkfekHPCOxWnK7qml6P2I8hND7OgW8kt6zQC+LISCmU1k4CMLpkvp+XPkmUKuml7C9ZUowd6lVjhVtgZfEU+95LeTEL6ZzyrB50qOJcRcWIstuKrrr6wKlCe8XT0jq7SgDrZuLLUjY0foIkq3K0OODLoBPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8936002)(83380400001)(6636002)(86362001)(2906002)(110136005)(36756003)(8676002)(26005)(316002)(186003)(6486002)(5660300002)(2616005)(91956017)(66556008)(6506007)(64756008)(66946007)(66476007)(76116006)(66446008)(478600001)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oiV0lT6dTHKhCDKc7Xf7cnl74b6PSCMoiUbkN7kYFYfiCXSDdLMXg1tfroPBtHMnmqXeHdNowHMM8Af3spm0j4NaCvUoHqPUCPD5IaResMGDkaJ6rNCTl3XnLrc5FFrJhxXnUsVLEcOpKiKJZDrKw5tjCUOPR1U/0P/bGgbm3VrhCXe67hahMDlJ6BhTIP87XJuFydvEYIhThhgE+UAwg/RYG7R6nRy/twnliFs6dzGH+VcYceddyho3dRL6IvoOLwIkJoAfXRGpnFoWPdB8YfBVT6qZ3nLYmABwXzWbtcHn5ZsZDbUIwIBBo9091ZzEZve+uimOOuuylOSFIR9EI+rLzwpfP6u8m2Ou851ZL9q9Rk45cTa72OIpN1caNPelfHiwg3sIqeVvavFS9otAVWvFYaMah+qHdxL2szKHABLigevGgVFuKW5KFPUi5yi7EOpZdYDb5UehW/AUZ1mcaUzCNeh+9qVHloI91W95KzrxGrP2YqaOJnS7ZsjnCn7ssJmKqtTTVT4u+9yHPNDrDBJuecZQ2wySd5RXOF22Cq/vezVtLqmL9jutUKpD++Be++i9NRGpMFq8lhjmE/rVtVRoD5qdv3jS+7LDyuxRlR1jtrSHutd49rFa4qwogZ0iJOmAEi45I+2+l+2pBX7YtohYwB25FoWAtuVCwaG0Bq8Xpk1qfg2ECh6drzg3RKI9e8ai9CwVP9IIMuZV/zhBUwF5yEg7ZIl+t6i15QtpjDp9qfhbLDoHAKN3QMALhONc/yJkMQ8RJq1UbzYSlWPFw5Nsco5MSUO2l5ZcEk0/wPFWgxRtZ+ncPafQyi7w2goot0eVi4SECKIh+ZCTOQYyhVgYl3JTsgeIaRxFcF2lL9qe//rdyjV0UoDSIDSgqBbUL637PN8tYLpLStY0E18IUA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD38CBA1C885A84EA69FEBC73E963EB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6629252e-a2ce-4722-47ba-08d885a61753
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 18:26:07.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j78pDw3rwTjCrl4B88Ra09YGoQrqu19sc/igk8K2tfleUgsqdbcYTzuQpmHkMze1+D6caGb1OXYX0Y+tGf6CXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMjAtMTEtMDkgYXQgMjA6MjEgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgYSBwb3RlbnRpYWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNpbmcgaW4gbWVzaF9tb2RlbF9wdWJfc2V0KCkNCj4gd2hlbiB2aXJ0dWFsIGFkZHJlc3MgcHVi
bGljYXRpb24gY2Fubm90IGJlIHN1Y2Nlc3NmdWxseSBzdG9yZWQuDQo+IEFsc28sIGZpeCBhIG1p
bm9yIG1lbW9yeSBsZWFrIHRoYXQgbWF5IG9jY3VyIG9uIHVuc3VjY2Vzc2Z1bCBtb2RlbA0KPiBp
bml0aWFsaXphdGlvbiBmcm9tIHN0b3JhZ2UuDQo+IC0tLQ0KPiAgbWVzaC9tb2RlbC5jIHwgOCAr
KysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gaW5k
ZXggYzhlYjhjNjA3Li44MjA3OGVkODUgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbW9kZWwuYw0KPiAr
KysgYi9tZXNoL21vZGVsLmMNCj4gQEAgLTEwOTEsMTEgKzEwOTEsMTEgQEAgaW50IG1lc2hfbW9k
ZWxfcHViX3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBhZGRyLCB1aW50MzJf
dCBpZCwNCj4gIAkJc3RhdHVzID0gc2V0X3ZpcnRfcHViKG1vZCwgcHViX2FkZHIsIGlkeCwgY3Jl
ZF9mbGFnLCB0dGwsDQo+ICAJCQkJCQkJcGVyaW9kLCBjbnQsIGludGVydmFsKTsNCj4gIA0KPiAt
CSpwdWJfZHN0ID0gbW9kLT5wdWItPmFkZHI7DQo+IC0NCj4gIAlpZiAoc3RhdHVzICE9IE1FU0hf
U1RBVFVTX1NVQ0NFU1MpDQo+ICAJCXJldHVybiBzdGF0dXM7DQo+ICANCj4gKwkqcHViX2RzdCA9
IG1vZC0+cHViLT5hZGRyOw0KPiArDQo+ICAJaWYgKCFtb2QtPmNicykNCj4gIAkJLyogRXh0ZXJu
YWwgbW9kZWwgKi8NCj4gIAkJY29uZmlnX3VwZGF0ZV9tb2RlbF9wdWJfcGVyaW9kKG5vZGUsIGVs
ZV9pZHgsIGlkLA0KPiBAQCAtMTYzOSw4ICsxNjM5LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgbWVzaF9t
b2RlbCAqbW9kZWxfc2V0dXAoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQ4X3QgZWxlX2lkeCwN
Cj4gIAkvKiBJbXBsaWNpdGx5IGJpbmQgY29uZmlnIHNlcnZlciBtb2RlbCB0byBkZXZpY2Uga2V5
ICovDQo+ICAJaWYgKGRiX21vZC0+aWQgPT0gQ09ORklHX1NSVl9NT0RFTCkgew0KPiAgDQo+IC0J
CWlmIChlbGVfaWR4ICE9IFBSSU1BUllfRUxFX0lEWCkNCj4gKwkJaWYgKGVsZV9pZHggIT0gUFJJ
TUFSWV9FTEVfSURYKSB7DQo+ICsJCQlsX2ZyZWUobW9kKTsNCj4gIAkJCXJldHVybiBOVUxMOw0K
PiArCQl9DQo+ICANCj4gIAkJbF9xdWV1ZV9wdXNoX2hlYWQobW9kLT5iaW5kaW5ncywNCj4gIAkJ
CQkJTF9VSU5UX1RPX1BUUihBUFBfSURYX0RFVl9MT0NBTCkpOw0K
