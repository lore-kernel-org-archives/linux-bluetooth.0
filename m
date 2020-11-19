Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FE0C63697
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 16:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB09022264
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 16:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fI3/hOJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgKSQlU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:41:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:12535 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgKSQlT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 11:41:19 -0500
IronPort-SDR: wrBmIDmumgj5AUxr1Zfb9UNHbTakwWAIot4XjATHPQn8F7qy/MnrychqgHzcuruMTCRDfhoQay
 ifUjbaDlVaIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235468318"
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="235468318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 08:41:18 -0800
IronPort-SDR: HSND7V8L77sXNPYlCUvWt4sWd+RWQNcTsC+fVBg6rwThvGMrxjwR6WkSWW1na2P9hpMp6PUZ38
 k5CIuZtRbFMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="401565046"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2020 08:41:12 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 08:41:11 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 08:41:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 08:41:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 08:41:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b51lEcStcARzPXBhWl4l+3ZC1COqrHHwxAXXkwaQhnuFH+MQusOOQzKSTbWpcznF84Txw868QDnWzdiPKBZT/UOBCw6v5YMAYpxAYoK4MwOcvDTSQ854ddBJFhy0P9U5hwOfRpasYs7QPDQczKZc2VSDs91eNyBR5zAb/A0+TiO3U3i0OeuXHR9Wh8TMh0PfvycOlR72E5DuaLeNs/YiRsdDsV2wSKzGJCoKc13OCS8UZxpTaU2HIFT+m0uufP01DgbOzG7ZFhTp8fTxNuS6DuVzr+/eD73PCgKbPwqBFO1cqGuV5dCYH5ahU+EU6K7RN+EhS1pvKMw4fVtuIXcuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obU92RxiVlPbMUq1zo1pa5RrYMl/adeCegmJpSOykhA=;
 b=Ps4M1/ZCixX9PZV1rpiWMKUsmPbjHe6+6C0MpFehLCaPi/qF2jhmc1FU/sluE4137K6wp0nnJ1m0yrt3Jnz0k1wfnyw8Tz06tStYdVyRhAPB5ShnDEvHmDYy49US1guJaN4eRQ38f1HsmT2uddAH05SMDVn/cKKSZM/ZvRqNDYzwZtANv/oI0+fnwVmvhZElSeaE9I5Dg+JgfgwPlItNMI1JUKMZ3XcujYNtWdeoJ+1ffp9oylgsrc0yHVNAWnmzmR7uMtFvTNJ3fEwO3IRKIdChAy//UV4skTER0XBKeHUjt093WuvAjbjLnv7HFDf9w0U2NNWwrBKPBG9cH8HbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obU92RxiVlPbMUq1zo1pa5RrYMl/adeCegmJpSOykhA=;
 b=fI3/hOJ3+fWCLuZcs/+mIxvnF6uvwGlKVEtJjGvvxz+tIcbBAXF2fS18BaW5rwkMrNhzsj5cTRaJDG9Y8ldWscVfB5j83VjU1rbvvifyHxML6RdrkoL8rblL/LFbuyiblcyLWK/0quxuk6BzeZ5arT50cGwkLSIVrdrbFDF0fKA=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1951.namprd11.prod.outlook.com (2603:10b6:300:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 16:41:10 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3564.032; Thu, 19 Nov 2020
 16:41:10 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "sbrown@ewol.com" <sbrown@ewol.com>
Subject: Re: [PATCH BlueZ] mesh: Fix regression error in HB subscription set
Thread-Topic: [PATCH BlueZ] mesh: Fix regression error in HB subscription set
Thread-Index: AQHWveTml8Cg39UI5EaSztBg9A3FQKnPqcaA
Date:   Thu, 19 Nov 2020 16:41:10 +0000
Message-ID: <a399d71d1dcfafda18827a7fdabfe39b3c792b46.camel@intel.com>
References: <20201118195600.30267-1-inga.stotland@intel.com>
In-Reply-To: <20201118195600.30267-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52124a8f-47d1-4587-1e31-08d88ca9ebb1
x-ms-traffictypediagnostic: MWHPR11MB1951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1951049DF0802A6EF6D17BE8E1E00@MWHPR11MB1951.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnDhFydCv+QsBeeBUQ/Peq9KkWaAVO9WuJCr5pOnFBSRE8dgC5y3vWqPiHEUvXrK3c62ym/WEoFuiDGhtgd340zBzz/s2hmG+2ukWjr3HhgHpjGIseerTNGAq2F2Oy9SVR0VAi7sk5yF85joFyvVUVTxoQ1vRqCwSVA30E2B/lIGlw80l3AyE48B2L1FSNVh9lXk+lHX1xVFRmywBlufaK7/j3rvXHlPqPCHRssFZPmoaVKBQMc/W30eNAH0aIHoKckBDHsffvYEZRK64HEHxd/NPTa/Ed14VdFCClnZbPFOM2ij3yZ9+3AhZ+Jvhutjh3qmct27KEjWDyp5xiCHHZLsF2uYIrHC8hTqF38UIaeEebLr+u58QgiN/0DbjWnV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(6636002)(83380400001)(6512007)(4001150100001)(186003)(26005)(86362001)(4326008)(2616005)(6506007)(316002)(8936002)(8676002)(64756008)(110136005)(71200400001)(478600001)(6486002)(5660300002)(2906002)(76116006)(91956017)(66946007)(66476007)(66446008)(36756003)(66556008)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dKWykgD0rnforJeWaQBQi4XvizYX2uOVeq7fgCqufg/+PDQz09oinEZrLDOwMfeqPewvw1Fe6VLOXOWOSDC0qQlKFVd7YaTcvHZ4K216jSijZMwP0LEPlUndKbB86asqDYHdg3RXdt6SgFKDVE92nqHnrLe8XVhXqDdwv7WFeceNZ1VFvmPE34QdmyrONlL437aS7G2/pgUaFnjH+gFpzGfZlwg0zITQW6GxzSeWYL5hw3Tu2fYQ53EEau6X7cEPSWc2rL9gXcFqewx9Y/SV2J9vf7RCKNlZTMPCA0A9v11jvpxrn1ed7CXx8ewlVHH14schO+nL7T+2ags+xfvhdqPfEZCdJtVrYdHRkLeOG2/veOnGVnYCVVtZONr42f/bHEpzQsYFBl27FCxP7J+36GQ2i+vGH/19sU9pSMPQFr++zZe+LkMcibpWh1TnTZcSJRKZUKiRdDGftOJIAgEr7yRU1BnWIBYrZaxRtsxhVhFnAAfmDkdETEb/rzBosP/b1Ep0pxTg2xAoEkRTyLUOVi19LR0z0012doY6x50Ckgm/Xb2BAii6R6doOuNDSkBabXcGl2WYhP9nsZlzlPyWqQh0IvZR4OgsYoQh+kEOt+ufv8KVLA6m9wSCwsSoSE2quOrAbmBP7ilSCS5+G8VwVHUpLf4OtdIwhzecyUO0aQC+Pi2GE0vsiL2e6ocs9r6UOQvN39Dm5iX0sQJnXWi7bLOKAtxae0Pl4yfd25A8/06UEzO/VSATJTcWuKrem96yv+xd7w39b5FV+ySo7oGNQCOBnXe9TJ9Y5t8NKKjqSDmaL2NG9XMLeGn9BpWQ6RzGl1HwkUBdpJ01JkQtEeYP32wDATYBXxEtIPXwNoy1ObYfesB5FiDBGKo6mOOCTEBIeyzCgNHU3hqFkaV97V3pUQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <82CCA8F74A7314469981B248AB5889CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52124a8f-47d1-4587-1e31-08d88ca9ebb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 16:41:10.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiYCbKwhwh1Z63LRzVZIfIVn6ErpuGdL3XCf9znapxG8gVqMqoJHS7/q7ilvWnbbnSXXDh3VZi5lUQWtc2hEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1951
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZC4NCg0KT24gV2VkLCAyMDIwLTExLTE4IGF0IDExOjU2IC0wODAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBUaGlzIGZpeGVzIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGluIGNvbW1p
dCBjNzdiYjg0OGE5ZmINCj4gKCJtZXNoOiBSZWZhY3RvciBoZWFydGJlYXQgcHViL3N1YiIpOg0K
PiBIZWFydGJlYXQgc3Vic2NyaXB0aW9uIHNob3VsZCBiZSBlbmFibGVkIHVubGVzcyBlaXRoZXIg
c291cmNlIG9yDQo+IGRlc3RpbmF0aW9uIGFyZSB1bmFzc2lnbmVkIGFkZHJlc3NlcyBvciBwZXJp
b2QgbG9nIGlzIHplcm8uDQo+IA0KPiBBbHNvLCBkZWNyZW1lbnQgcmVmIGNvdW50IG9uIGdyb3Vw
IGRlc3RpbmF0aW9uIGFkZHJlc3MgaWYgcGVyaW9kIGxvZw0KPiBpcyB6ZXIgc2luY2UgdGhlIHN1
YnNjcmlwdGlvbiBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgcHJvY2Vzc2VkLg0KPiAtLS0NCj4gIG1l
c2gvbmV0LmMgfCAxNSArKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMg
Yi9tZXNoL25ldC5jDQo+IGluZGV4IDllMGVhODYwZi4uYjI0Y2RiYTc3IDEwMDY0NA0KPiAtLS0g
YS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTM1ODIsMTYgKzM1ODIsMjEg
QEAgaW50IG1lc2hfbmV0X3NldF9oZWFydGJlYXRfc3ViKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1
aW50MTZfdCBzcmMsIHVpbnQxNl90IGRzdCwNCj4gIAkJc3ViLT5tYXhfaG9wcyA9IDA7DQo+ICAN
Cj4gIAl9IGVsc2UgaWYgKCFwZXJpb2RfbG9nICYmIHNyYyA9PSBzdWItPnNyYyAmJiBkc3QgPT0g
c3ViLT5kc3QpIHsNCj4gKwkJaWYgKElTX0dST1VQKHN1Yi0+ZHN0KSkNCj4gKwkJCW1lc2hfbmV0
X2RzdF91bnJlZyhuZXQsIHN1Yi0+ZHN0KTsNCj4gKw0KPiAgCQkvKiBQcmVzZXJ2ZSBjb2xsZWN0
ZWQgZGF0YSwgYnV0IGRpc2FibGUgKi8NCj4gIAkJc3ViLT5lbmFibGVkID0gZmFsc2U7DQo+ICAJ
CXN1Yi0+cGVyaW9kID0gMDsNCj4gIA0KPiAtCX0gZWxzZSBpZiAoc3ViLT5kc3QgIT0gZHN0KSB7
DQo+IC0JCWlmIChJU19HUk9VUChzdWItPmRzdCkpDQo+IC0JCQltZXNoX25ldF9kc3RfdW5yZWco
bmV0LCBzdWItPmRzdCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJaWYgKHN1Yi0+ZHN0ICE9IGRzdCkg
ew0KPiArCQkJaWYgKElTX0dST1VQKHN1Yi0+ZHN0KSkNCj4gKwkJCQltZXNoX25ldF9kc3RfdW5y
ZWcobmV0LCBzdWItPmRzdCk7DQo+ICANCj4gLQkJaWYgKElTX0dST1VQKGRzdCkpDQo+IC0JCQlt
ZXNoX25ldF9kc3RfcmVnKG5ldCwgZHN0KTsNCj4gKwkJCWlmIChJU19HUk9VUChkc3QpKQ0KPiAr
CQkJCW1lc2hfbmV0X2RzdF9yZWcobmV0LCBkc3QpOw0KPiArCQl9DQo+ICANCj4gIAkJc3ViLT5l
bmFibGVkID0gISFwZXJpb2RfbG9nOw0KPiAgCQlzdWItPnNyYyA9IHNyYzsNCg==
