Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5372C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8322020714
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gXzEbZuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCZRDG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:03:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:21002 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgCZRDF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 13:03:05 -0400
IronPort-SDR: 9LVpPo3Wy/8PkPamjvHWoN9BAWkHzHsVcJE0sBGKc++t9EAQVOh7z9aolYXlrscd3gp2KcxALJ
 Gd0HjDku68sA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:03:05 -0700
IronPort-SDR: pyuJQGBF8eB8MYnoIGLvnljH0+UkcKvFZKMqPWGZUCeUeX46Ur1f/ujayfCoaywG9tRpj9A7Rd
 KD819yQbmUCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="293693551"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Mar 2020 10:03:04 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 10:03:03 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Mar 2020 10:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOdvn5bxlSdslnSPcnlUnL+VCU3NaczdQiAjlK0PV48RB8QWxBxypJFb7rd2ixvzuL9kQ03tzwDNStAHqQwuz0/bJkoQXTY7lpdx5fqSrB65PHshnTN6p9RavCSoQl372Me1s4Us5znZkauw/wgpQOQUxvADkWdmEAvwskKY8GTp3iJipxcCVmkUUrkKaTq9IaWZK3RUzC5VlrDg7uQzI8MS35AkmUAeFzbEjJbaZajJo4YXn3+DIRH1Z/KbLhzP3LopTUD8h5VtfIG0HVsHWekRflUEe5ERm8JLKBG+yK19GRlUumsIxrLtZhQHbI4JLAfv6xrKkZYefQFXa8n34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFh48x4ctQDRlQKrUt1UW6igDi7dhnJKhcGqgTuQiBQ=;
 b=AxMoVTv68kuhdbSaDpaxL1uI1DLF6Pz4/9y/E/yMmYv/yIe2fUvSqjshxPR/DwQ6ET5tbNQDKxLDxgaEKpk5khn1CBfn97JGn4uQNVs2YEqsjm/mFBXuhb+42EH0/NF8mw9y4CJWRDrdJ04mzbiJgEu9fw8fiWIechKoDIzSjYrGqFhk8QRi9Bxc1vZq2OV7IHWLhYgfUXRFgQAYwByOktWz/KMkVuUsm4S9O/jPG1eauR9PtdDbAlfcZhI0hoiaKvaJsZM4/0ucvUSfz5T14DPSe+1Dy5NPZ/XSE0Zw+pWIbNPWOHMGXWOGKU1K2b1cTd9JQ51q0Tm0JbO1a58SEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFh48x4ctQDRlQKrUt1UW6igDi7dhnJKhcGqgTuQiBQ=;
 b=gXzEbZuzUqsK3apEQA7OJL36ayuq5XNGbk1SG2k6cZe0YxeO1SN4opXqkoMsg3iEjIPqET2lrQH7ureU1nQ1cILNfsWBZnmTipi+3ga2rpB5GWRpqWEGsVtJU0A5f2X2vRc+adxstLxz7a9xZpYjxSXAbeqdrd8t7K0dRvqV8GI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 17:02:58 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 17:02:58 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "s.syam@samsung.com" <s.syam@samsung.com>
Subject: Re: [PATCH 1/1] mesh: Send input complete for input OOB
 Authentication
Thread-Topic: [PATCH 1/1] mesh: Send input complete for input OOB
 Authentication
Thread-Index: AQHWAhKFyGLJdJHQ9ECvAXkPzjorE6hbHKaA
Date:   Thu, 26 Mar 2020 17:02:58 +0000
Message-ID: <9d7af034ca959e66660078ea3df47fe2e1b4fc33.camel@intel.com>
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
         <CGME20200324192826epcas5p2eb80e44ac061329faf5421ba3b76e5f8@epcas5p2.samsung.com>
         <1585078044-14974-9-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1585078044-14974-9-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f5935de-8dcb-4dc1-2333-08d7d1a788fe
x-ms-traffictypediagnostic: MW3PR11MB4537:
x-microsoft-antispam-prvs: <MW3PR11MB4537478C61AA216DD8A9C161E1CF0@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(136003)(346002)(4744005)(478600001)(316002)(8936002)(110136005)(86362001)(5660300002)(6486002)(6512007)(64756008)(36756003)(26005)(81166006)(186003)(8676002)(81156014)(76116006)(91956017)(66446008)(66556008)(66476007)(66946007)(2616005)(4326008)(2906002)(71200400001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4537;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpLzOwT8MmQzZGnCn6rq6JyXYphQ403o1Qqx0HK3urA3J+11S7LM6G5UICNnM0JGIyyrdp0WfQqVq2ma0R5KNk80AZvbvGASPz8AgcIviYOU1GSm/59ZBmRHyiMMhNglMlWMhSeX2IIDXghoUjU5aO9GT/06V5aWCt9L6zR8i4+7Hgv9oHZheuYFMfeLNsPQYvM9T/zFY/fdA/dmo2eLEhpS4cTHwkLEHJwTKoWrXaf71jHkwqHCHbrrUpBOETtx1Fsd2P4nT9KU+lbsJP8ely/trbszZqtNfZKQh20bypMQHwFq6ibT1hiBBCWyt+74AgfbmLT9UOa/Ht03C3ZMs9HIgSYwA4EuaoqjxxrYrFg+H0A16DjeE5c08MvMmogEv+Jt1aGTgXXlxeCx/wsjG0J6c+eQRK8SlTGf9RiWBxkh3+gLaPVRw7VMBiS0XRSV
x-ms-exchange-antispam-messagedata: MtedX4P49sG4PK5fwvSSaKoftlfIDUl7lweGyevfXBEf+N1L4RR+PHML3rUAL//V5pHNX6v5jQx9eHuOoSXH1B2wILroX56aRmufBT5K1s59NqPHSbl8+FuMdZ68HERtMYURW5rkorDpCR+/IBrzYg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <898D8CB71B97574889010113516CB5C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5935de-8dcb-4dc1-2333-08d7d1a788fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 17:02:58.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJgxyZk33Be4spU0JGc5XfPvQRhsky6kADYfr4GsNOa3v7qZ6KvQ/5QHofzRLxPYVHqpweWcTkBbPVefstY6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDAwOjU3ICswNTMwLCBQcmF0aHl1c2hhIE5l
bGx1cmkgd3JvdGU6DQo+IEZyb206IFByYXRoeXVzaGEgTiA8cHJhdGh5dXNoYS5uQHNhbXN1bmcu
Y29tPg0KPiANCj4gU2VuZCBpbnB1dCBjb21wbGV0ZSB3aGVuIHVzZXIgY29tcGxldGVzIGlucHV0
IG9wZXJhdGlvbi4NCj4gLS0tDQo+ICBtZXNoL3Byb3YtYWNjZXB0b3IuYyB8IDYgKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVz
aC9wcm92LWFjY2VwdG9yLmMgYi9tZXNoL3Byb3YtYWNjZXB0b3IuYw0KPiBpbmRleCAwMzk3MmMy
MjcuLjIwYTJjZTRiZSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9wcm92LWFjY2VwdG9yLmMNCj4gKysr
IGIvbWVzaC9wcm92LWFjY2VwdG9yLmMNCj4gQEAgLTI3Miw2ICsyNzIsMTIgQEAgc3RhdGljIHZv
aWQgc3RhdGljX2NiKHZvaWQgKnVzZXJfZGF0YSwgaW50IGVyciwgdWludDhfdCAqa2V5LCB1aW50
MzJfdCBsZW4pDQo+ICAJbWVtY3B5KHByb3YtPnJhbmRfYXV0aF93b3Jrc3BhY2UgKyAxNiwga2V5
LCAxNik7DQo+ICAJbWVtY3B5KHByb3YtPnJhbmRfYXV0aF93b3Jrc3BhY2UgKyAzMiwga2V5LCAx
Nik7DQo+ICAJcHJvdi0+bWF0ZXJpYWwgfD0gTUFUX1JBTkRfQVVUSDsNCj4gKw0KPiArCWlmIChw
cm92LT5jb25mX2lucHV0cy5zdGFydC5hdXRoX2FjdGlvbiA9PQ0KPiArCQkJCQkJCVBST1ZfQUNU
SU9OX0lOX0FMUEhBKSB7DQo+ICsJCW1zZy5vcGNvZGUgPSBQUk9WX0lOUF9DTVBMVDsNCj4gKwkJ
cHJvdi0+dHJhbnNfdHgocHJvdi0+dHJhbnNfZGF0YSwgJm1zZy5vcGNvZGUsIDEpOw0KPiArCX0N
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgcHJpdl9rZXlfY2Iodm9pZCAqdXNlcl9kYXRhLCBp
bnQgZXJyLCB1aW50OF90ICprZXksIHVpbnQzMl90IGxlbikNCg==
