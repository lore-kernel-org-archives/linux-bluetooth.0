Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3FC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFDC206C0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 20:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iuolNzxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgICU2B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:28:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:12143 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbgICU17 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 16:27:59 -0400
IronPort-SDR: AfxCKH/H3/7q8k2G2DyUoSvMl0O3B6VcPg/5KQYz8r2C9EWE7+vKU75GG3ZEywr5SJXvPdff+E
 xs0SMj0R5/Kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="155050294"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="155050294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 13:27:55 -0700
IronPort-SDR: 145vYdKLpOvw2zaQO/bIUVphcNAQ8ssSPObMfjftbhkxOQP63sImlNwqGgl2qdhZwcLn+WL1X2
 O5gKYqI37H3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="405588196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2020 13:27:55 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 13:27:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 13:27:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 3 Sep 2020 13:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwFrHowKP4IZvveuPaCLpjUi4hEzYDTqFr+spVsF6xLd8NySVKzCMt6JA4T46DKZ4yaTADxxDy6qIjs4gXTUlUTZubCNmsgh56jdn1Ig4sNBqq/xPZKtGOMlzhp9C0QcfO7P9n+qfK50f8QQrLVJ95jD0rICwf+GzOUIbDXlK2pWXOYaFmNBUhZkQVwjgKQQYl+oaEut+A7L58MK1SgRpg5e5CLsPX86PhznOFqLVf4tSEWSjy4lT0T2FS4o6+2j8yiVKAB+Qob2qQ+CiITQJ4ifvCXaimWsxDqRyBdMO8mQPgNS0nf5FUJxaYqwl6MtGlUEe+DHZ6dzu9u5VsHaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/GTOrxwaKTZs6hz6cwGdflMgSj5GuzVae1cFmFGVIg=;
 b=Rzf9zw4/Hq+0OgQBL36TXvPLmSIJ0Z/m1wSD5Nzj4gFmcIJmOYZCBbqN6xvlB1QiYO3o4luNwUFH3YMKiNOLn0qcO4y3DSqMUg5kqgEWfyRwEtoaTFsQaR9bebe3tNTupiNI/xSKmY7lSd9EpZeARfakMoICbGIfm8CNqN8bYBP19MMtstE/rrUEctJBe1oqiNaSJgT1BJjGVo4WMLl8Chx/2/PLnxrZvu4ArygbL+1L7fPl5Km+B7axjx2PYS5SfRbKY0XlaEqr5e+I5qzGh7XM8Nf23ke29i77tpnzQI/y/5kjiXhrSPinSLh2z/DioBSBtgsigMRVnkZuEBPwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/GTOrxwaKTZs6hz6cwGdflMgSj5GuzVae1cFmFGVIg=;
 b=iuolNzxtVWiuK8hbHuSHD5wrpFCid0Vxlf2q4/y63Kzw7a52CcIXtzLc+oR5az/ikxixlzLMtHpBoRZEO4fReN/aq5PnjjzmVp2YaipZKvUhI3MItWFZwRec3nrnCBWhoLID93hPfY/75lXaNEsqKWNvE8wz4s6fVzMJo1TdB2E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:27:44 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 20:27:44 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Remove unused timing variable tx_start
Thread-Topic: [PATCH BlueZ] mesh: Remove unused timing variable tx_start
Thread-Index: AQHWgiTBdlm/C5bEUkajkMHcU9KB5KlXXRCA
Date:   Thu, 3 Sep 2020 20:27:44 +0000
Message-ID: <a4e57397b7e50bd1a64d3f213f9e70d8d8818d44.camel@intel.com>
References: <20200903190205.9439-1-inga.stotland@intel.com>
In-Reply-To: <20200903190205.9439-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e2623dc-e861-449e-7501-08d85047d090
x-ms-traffictypediagnostic: MW3PR11MB4698:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4698828BB60F0F1922A5BC3CE12C0@MW3PR11MB4698.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6rdvtvXyb7eoUDNijCtMA0vLZn8iULcQy+Z3/EM4gWVzfMRvU7D5ZiOQ86uOOlz60906m9x91t1pJVAsVXKg4hcp9VudNJlhLXpZyF7AZ78h0lodgp3NmzIdgLYfXcDHMRaWDxx1269JMqibwa32Of26MI2QayJ66XMUl+k+gqEF+LOs2VEzDrqExPyHHOKyK3BnbfrKPK/f5fWov+nH2E95WRugFsrDcJ/nn08hTpjsCVRO9UExLOJQ73kua2MGXUlUHZjYHJTVORrvJQQv7HjIs6rzMSzwVAu+GcCkuM4/R0YQGp+z36gz/7fwQheHtvQmD7qgyPoBfEvRi8SDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(110136005)(6636002)(71200400001)(5660300002)(6486002)(36756003)(6506007)(66446008)(316002)(66556008)(66476007)(64756008)(66946007)(186003)(76116006)(91956017)(26005)(86362001)(478600001)(8936002)(8676002)(83380400001)(2906002)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ICHB1eyGktLqzLzofb9NNDZltbzfMkIYQsfUzcS5fDtuNqZJ0qIYCRPT3hNRQJvZyBZ7/jZTSc3XvV0zS11oBwqoaBhZvXzTtu7BDZbZzW/Ob6jyhKZC2nSAYn0eYB5OvvvXDY7Et4eXH1ZXdpOISjt5o3WKr645CrRlOorBHHLe6PpSQuokuDDtgvAIq5Ld3XXH1Rzgtkf7oSHkVwNpmnE6N7DM8/z+8gw5AoA5DzI/QBLxhW4nVuC+YUpGMFPmh7DSGwphgln75IYtl/7zv8OaqcI6nP2J6gFK2wBMKbx3d7GYt0doKT5OqhlGOR84TBGa6YZ9gxiAJHZ0gyvdFbNX/QoCAC/H9gsd3AwQfoAYSyCWyFqehDlWQgoNzv7tEEp7brRbBRJFJJhinETHddpJgOu2IkSgwb5jMi80yAdjggqdlSOSIBVil9h+LYMbGshZekKgOAbRIHJO5MPiHeVTZI71nRC+vKeDw81nMkuqsn1kxXIhCe7jWGoBcLxXnUJr51vLNbaSKoCZ4kKTzDfkSYOe9BcXKP7vNSN+jCbz3L5aJ/WC9qbwg4aSwJ6juuMkdK9/B/4rS15w1XVnCYkoHvYKDJpe5V15cCDpuW99UMMhgA1mBZcJzZSl+e0lbHPn8coQbdIpGBuaAmfXHQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5F6A341248DD24AA861D74B30D59331@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2623dc-e861-449e-7501-08d85047d090
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 20:27:44.3439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeElU7HYYeXD7C/Cy2PP1fdQl0p9pPLU3gaoNBlsTq5kf16U6YJdF8ARIXZ6ItHXCoVX8caxVBQEF2Ovui1tPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTA5LTAzIGF0IDEyOjAyIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBJbiBtb2RlbC5jLCB0eF9TdGFydCBpcyBhIHN0YXRpYyB2YXJpYWJsZSwgZHlu
YW1pY2FsbHkgc2V0LCBidXQNCj4gbmV2ZXIgdXNlZC4gSXMgcmVtb3ZlZCBub3cuDQo+IC0tLQ0K
PiAgbWVzaC9tb2RlbC5jIHwgNiAtLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbW9kZWwuYyBiL21lc2gvbW9kZWwuYw0KPiBp
bmRleCBlZDJhNzUyMTUuLjU3MTZmNWUyMiAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tb2RlbC5jDQo+
ICsrKyBiL21lc2gvbW9kZWwuYw0KPiBAQCAtODAsOCArODAsNiBAQCBzdHJ1Y3QgbW9kX2Zvcndh
cmQgew0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IGxfcXVldWUgKm1lc2hfdmlydHVhbHM7DQo+ICAN
Cj4gLXN0YXRpYyBzdHJ1Y3QgdGltZXZhbCB0eF9zdGFydDsNCj4gLQ0KPiAgc3RhdGljIGJvb2wg
aXNfaW50ZXJuYWwodWludDMyX3QgaWQpDQo+ICB7DQo+ICAJaWYgKGlkID09IENPTkZJR19TUlZf
TU9ERUwgfHwgaWQgPT0gQ09ORklHX0NMSV9NT0RFTCkNCj4gQEAgLTEwMTgsOCArMTAxNiw2IEBA
IGludCBtZXNoX21vZGVsX3B1Ymxpc2goc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDMyX3Qg
aWQsIHVpbnQxNl90IHNyYywNCj4gIAkJcmV0dXJuIE1FU0hfRVJST1JfRE9FU19OT1RfRVhJU1Q7
DQo+ICAJfQ0KPiAgDQo+IC0JZ2V0dGltZW9mZGF5KCZ0eF9zdGFydCwgTlVMTCk7DQo+IC0NCj4g
IAlpZiAoSVNfVU5BU1NJR05FRChtb2QtPnB1Yi0+YWRkcikpDQo+ICAJCXJldHVybiBNRVNIX0VS
Uk9SX0RPRVNfTk9UX0VYSVNUOw0KPiAgDQo+IEBAIC0xMDQ5LDggKzEwNDUsNiBAQCBib29sIG1l
c2hfbW9kZWxfc2VuZChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBzcmMsIHVpbnQx
Nl90IGRzdCwNCj4gIAlpZiAoc3JjID09IDApDQo+ICAJCXNyYyA9IG5vZGVfZ2V0X3ByaW1hcnko
bm9kZSk7DQo+ICANCj4gLQlnZXR0aW1lb2ZkYXkoJnR4X3N0YXJ0LCBOVUxMKTsNCj4gLQ0KPiAg
CWlmIChJU19VTkFTU0lHTkVEKGRzdCkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gIA0K
