Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCCAC33CA1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BAA2067D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 17:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bMZKpT/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgAHRNV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:13:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:14639 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHRNV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 12:13:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="216013973"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga008.jf.intel.com with ESMTP; 08 Jan 2020 09:13:20 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 09:13:20 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 09:13:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 09:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J19rej3oqc7vG3EXkQ0PtFpL3WjuOOvNvkcFolf4y8/t6VJWyNfGOcE3DMLrMDwAOgZK/z4pl3K0DKXojvxL2PoTEbt1ImZlJVpvXYJLpoF3vgvvd+HpzzHWIv0AeuFxfbq9t2qrkVPTXIHAJ//sI1BwyPQkJhuZryX25e+3P1O6v6pqmD44FU4rsY1nXiygqBpcoRHG9DxOffhFwv3pLOEombnqsosQFTz4V912wemQ5rb+xMrynOtDj0twrTCXdl0Lu/fsLlqFGLkErIV86DK6UiFU1Omz4ii+GJ6DUtbZSkj93nAStYSLUFddrjw3UKyOmHqmYIagh6eSyW4TyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEkzwb+Oy7IjYJk1ph2c/dP8NMFQh2c71G9N3h9cpMw=;
 b=Btl+33p7M1Dv7wRhMeF75PWSwrxY6hqQKm8covucfoEG3l27vo3GDwKhFp7uBAbS7n/4QmFIdG7K2MJZYqwlwnsEeKh+evwz6OrRTChIz0FZLkCO4fjqU37xVjt7bt6iKwxsLjn0R3sBqRapkvV9gnsQ4JJpde//+BuNYYxJwp6Pqhl+p1WHCZbIwPBY1PfwgqDtdroQoyuuCX4YXla10KVXmzRaYlXhcWV0op1HQl4uR6NHzjf+l8WrjQeH+Qyi2HOjX2xvOCrj5p7goyRCbIjxexcrnFZrxfgGu91rHsW8ubvq6OZTz1TP4Pe6BG6jrmkgREx63j4q7+y1cXvlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEkzwb+Oy7IjYJk1ph2c/dP8NMFQh2c71G9N3h9cpMw=;
 b=bMZKpT/NkEyAKh0jnFxsbyLV07lsHWHFQMz0f9TCFLp9CYS+RJc0uBm831Z4AoMEGUBZNaAztoI6lYi4vQkGIiHxyztqw/R2qq8P+J5KuiP2JAZ/w7quYdYqGb3qs5sHoVd9/2h38fA3/rZenxNy95culuX14CKSR4+hzNuGTYU=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1671.namprd11.prod.outlook.com (10.172.68.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 17:13:19 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 17:13:19 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix node reset
Thread-Topic: [PATCH BlueZ] mesh: Fix node reset
Thread-Index: AQHVxa8I9zqgu7EbfUS6yn1gW6duBKfhAnkA
Date:   Wed, 8 Jan 2020 17:13:19 +0000
Message-ID: <6cef0737e023e443582762858625715cc4e62e25.camel@intel.com>
References: <20200107230505.8087-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200107230505.8087-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4b11ea4-b2d5-4ad6-790b-08d7945e0efe
x-ms-traffictypediagnostic: CY4PR11MB1671:
x-microsoft-antispam-prvs: <CY4PR11MB1671DE14E53DCFCEB42C3CDDE13E0@CY4PR11MB1671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(76116006)(91956017)(66446008)(64756008)(66556008)(66476007)(81156014)(81166006)(8676002)(8936002)(2616005)(36756003)(26005)(478600001)(66946007)(5660300002)(71200400001)(2906002)(186003)(6506007)(110136005)(86362001)(6512007)(316002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1671;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQIGTqUCoj3CXVZcVh192z/QwlifwVqWN2QNDNwVgb/mvYkxhhe8ptqTuTvsv7ZJ8SKbcV0SYCZVDBTedGeGmA5cWXz8hs6vKiYYzA034UCwWaPr9WSOVL+22He3V8kwRXyWKwh9xMOvKNNJkrNd2CWz1q6H30cJQeyPtpitIgzj1SwfpHFF1xx0RraS4MPi98pIhFv31wSf2bg84oFLDgLlUbl/24nTRFYbfMTkSlzezAzEhi6aoU5Vc5kxmjMPQVPuTJlo5lNUPvDuHvwBDl0NdePswv9qpGRnUnb4eVVF2NMmogSLoa7uSlIdt5PLCJq/d7v7prQKPPnCdEJ3N+kPq1mqTAqBrm8WUmeFReJdOp3c2iNUfGBHUusv5SBblO7FIHcTijJr/Goz8uUzrmkhRI/7x4E1vREAP45ceeNcxGPQ5flwHoXBS1I3i3uK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC374454541A3F4AAD05AAF2778E49B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b11ea4-b2d5-4ad6-790b-08d7945e0efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 17:13:19.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkZjVmbwttYvFDZg4C/Lp47ERv2Q6A7BSEsfIdh/r6I3NZib5NA3v1eL+7/vhnMjWlZRASQFHAEfgGsZ9bEoAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1671
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAxLTA4IGF0IDAwOjA1ICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gSW5zdGVhZCBvZiBzdG9wcGluZyB0aGUgZGFlbW9uLCBqdXN0
IHJlbW92ZSB0aGUgbm9kZS4NCj4gDQo+IC0tLQ0KPiAgbWVzaC9jZmdtb2Qtc2VydmVyLmMgfCAx
MiArKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNo
L2NmZ21vZC1zZXJ2ZXIuYw0KPiBpbmRleCA4YWNkZTk1YjkuLmJiNDNmMDFhMCAxMDA2NDQNCj4g
LS0tIGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMN
Cj4gQEAgLTc0MCw5ICs3NDAsMTEgQEAgc3RhdGljIGludCBoYl9zdWJzY3JpcHRpb25fc2V0KHN0
cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBzcmMsDQo+ICANCj4gIHN0YXRpYyB2b2lkIG5v
ZGVfcmVzZXQoc3RydWN0IGxfdGltZW91dCAqdGltZW91dCwgdm9pZCAqdXNlcl9kYXRhKQ0KPiAg
ew0KPiArCXN0cnVjdCBtZXNoX25vZGUgKm5vZGUgPSB1c2VyX2RhdGE7DQo+ICsNCj4gIAlsX2Rl
YnVnKCJOb2RlIFJlc2V0Iik7DQo+ICAJbF90aW1lb3V0X3JlbW92ZSh0aW1lb3V0KTsNCj4gLQls
X21haW5fcXVpdCgpOw0KPiArCW5vZGVfcmVtb3ZlKG5vZGUpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0
aWMgYm9vbCBjZmdfc3J2X3BrdCh1aW50MTZfdCBzcmMsIHVpbnQzMl90IGRzdCwgdWludDE2X3Qg
dW5pY2FzdCwNCj4gQEAgLTEyNjUsNyArMTI2NywxMSBAQCBzdGF0aWMgYm9vbCBjZmdfc3J2X3Br
dCh1aW50MTZfdCBzcmMsIHVpbnQzMl90IGRzdCwgdWludDE2X3QgdW5pY2FzdCwNCj4gIA0KPiAg
CWNhc2UgT1BfTk9ERV9SRVNFVDoNCj4gIAkJbiA9IG1lc2hfbW9kZWxfb3Bjb2RlX3NldChPUF9O
T0RFX1JFU0VUX1NUQVRVUywgbXNnKTsNCj4gLQkJbF90aW1lb3V0X2NyZWF0ZSgxLCBub2RlX3Jl
c2V0LCBuZXQsIE5VTEwpOw0KPiArCQkvKg0KPiArCQkgKiBkZWxheSBub2RlIHJlbW92YWwgdG8g
Z2l2ZSBpdCBhIGNoYW5jZSB0byBzZW5kIGJhY2sgdGhlDQo+ICsJCSAqIHN0YXR1cw0KPiArCQkg
Ki8NCj4gKwkJbF90aW1lb3V0X2NyZWF0ZSgxLCBub2RlX3Jlc2V0LCBub2RlLCBOVUxMKTsNCj4g
IAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo=
