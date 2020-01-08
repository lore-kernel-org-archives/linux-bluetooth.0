Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4C5C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415512067D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FYkASbog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgAHRNG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:13:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:47756 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHRNG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 12:13:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="222986629"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2020 09:13:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 09:13:04 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Jan 2020 09:13:03 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 09:13:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 09:13:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgQWm+hxMZJBRw4RsW74XQWnHfeqL90EyCERie2bZzUzogtRgXGIfCbudA240Ey7WQiHMo34nXClJ7co4BinhrNBpZXD8YLVOdXuXOqt8RkPVqWFZl0dqWYP0qv4gRZNCPkkAfFr4R3/+FOPq59bw6UNNUGveiOiN2kPigk5UWCz/0+gr6ZasezuLNyryawoXipg/JTWjmz6vynxKT1iN7cX9AIGTVvduvFRN9cfR1BlczFxxlHHhG+O7WGMoAbC01RQvSoyYXDU/K/IucaD3gx5xYXAP1y+oIvc9pOMKCRnnlaaH9QW/q+l1tGqmh/Zi6wzoM7uSyt6eV+3cYu2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flrx9kOwnT1iH5+RMAqt+oXFFSyOn3g70TX/Ph1coQI=;
 b=mD0PuimAe5TKYNGXmumks/hA8s3uGiTDKA0Uij+KzmDtYAy81LUtvSph8FnEp/SFkZla7o1zwLWwWoWg7IZbgaVOecVj584ZGOBKiAQXsIbtzMnJ1kzT3QNR2ELfGjOMc5eM61pskJxIebem3YyfugmtN53MDJI5BKU5UktF5o/eS+aqkCM7SSfwewnWFA6vUrJjvtK7FxylBelATxcssSACdq4j6O08g3zx0JYchxUhBr6FltzqLuoG0wdNp+GaNG+xV+Fa63bGXKndEXvrwO/1qWnToPPh83VIFmONkiu+Q0YLiI5nkVKmuy2mxf9ucXAoIzzQJMjrLFhYRkgltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flrx9kOwnT1iH5+RMAqt+oXFFSyOn3g70TX/Ph1coQI=;
 b=FYkASbogg6eoG/wwA2azdifP3vX/noi9bhnmtI19WrtR23t3mcgPlTzQDgjYEcwuVUkYrPE0Y6h62NUYfvr3D1bdTrBmmOPkGAmO5mPPWGF8KAqLGqK0k1pMZ8anhVp8u4klj/x2+SW1auGXF+DL3478XYijZTBhjmH53Ick2KE=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1671.namprd11.prod.outlook.com (10.172.68.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 17:13:02 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 17:13:02 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Remove misleading DEFAULT_CRPL from node.c
Thread-Topic: [PATCH BlueZ] mesh: Remove misleading DEFAULT_CRPL from node.c
Thread-Index: AQHVxjcrOCHpqYjwOkODwkxFxoQQyKfhAVUA
Date:   Wed, 8 Jan 2020 17:13:02 +0000
Message-ID: <d75077baa1c113066b0396ac4cab1a6a90164fd4.camel@intel.com>
References: <20200108151941.14609-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200108151941.14609-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68548e12-1c1d-4f5d-7e2f-08d7945e04fe
x-ms-traffictypediagnostic: CY4PR11MB1671:
x-microsoft-antispam-prvs: <CY4PR11MB167103DBF7F6EB4BD381DB69E13E0@CY4PR11MB1671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(76116006)(91956017)(4744005)(66446008)(64756008)(66556008)(66476007)(81156014)(81166006)(8676002)(8936002)(2616005)(36756003)(26005)(478600001)(66946007)(5660300002)(71200400001)(2906002)(186003)(6506007)(110136005)(86362001)(6512007)(316002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1671;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbR7aiwfZFTupiIbV2hGJAyZ+PTqHPnpLyMn2Qduaw5ImQMP0DbpMAV1k/UQoPNtCQYBwUsVxpFEcH7k1rWmKUpY74jAKPHrRInPMabvLUbsFxRDZtxphzOUBlN/4NkvKgatQ4an3D3XPUQYV/vaCG1CwTnZ5UFK8Lv5hLzETnQZkTrCbbEdQbW/GC+nxoAnX0rmgM7iuP46gcPRfG7IEks75+g2LrtulEsLqoo9fCf6eTK4Vu6qlJE+u7L2931/jxD/pG3A/OoV0UbSv/5wfNiuav/hQ4ZJPxk/Lv7X2wm2gLE7iyCTLRBnQFjiD92SrHgamp2WMBvNfI4/zJNOaSXeGi1xfn6tJghMas2ml3wCgffFHvnmeiPW4oqudyBorrQYPyOXI2tq1kNVfmMa1cqD0XkHIy7jHwSNrqhQQ8GDlCAw5J9+Q+JJJMl4xLWK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9725EC02C915DF4D87751FACFE5B45F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68548e12-1c1d-4f5d-7e2f-08d7945e04fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 17:13:02.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpi2El4qCGk8uyPGmgh9diTZuVOwWf1T2MDziLNH293Rct+RrhMQG+gZGm/crbK+GqKsUBXKxKh/G1d5Xsvm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1671
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAxLTA4IGF0IDE2OjE5ICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8IDIgLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbm9kZS5j
IGIvbWVzaC9ub2RlLmMNCj4gaW5kZXggMzFhOTg2ZDA2Li4wYWQ5MzUxMDUgMTAwNjQ0DQo+IC0t
LSBhL21lc2gvbm9kZS5jDQo+ICsrKyBiL21lc2gvbm9kZS5jDQo+IEBAIC01Niw4ICs1Niw2IEBA
DQo+ICAvKiBEZWZhdWx0IGVsZW1lbnQgbG9jYXRpb246IHVua25vd24gKi8NCj4gICNkZWZpbmUg
REVGQVVMVF9MT0NBVElPTiAweDAwMDANCj4gIA0KPiAtI2RlZmluZSBERUZBVUxUX0NSUEwgMTAN
Cj4gLQ0KPiAgZW51bSByZXF1ZXN0X3R5cGUgew0KPiAgCVJFUVVFU1RfVFlQRV9KT0lOLA0KPiAg
CVJFUVVFU1RfVFlQRV9BVFRBQ0gsDQo=
