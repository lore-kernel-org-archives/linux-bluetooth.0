Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB80C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988CB24687
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 07:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="E4Oj4n0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgARHP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jan 2020 02:15:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:17995 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgARHP0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jan 2020 02:15:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 23:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,333,1574150400"; 
   d="scan'208";a="220947428"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2020 23:15:24 -0800
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 23:15:24 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 23:15:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jan 2020 23:15:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac9mcLgBAm1/p2yjCGzQnQL9CZTqnKKGCAYWAr8kHzvRKX0czX6/oGj45ktUOpAl5YV3NptvHXMUCGV/Y34FjWUVBrMEFCjtnrb29sUr5rGePhzK3kuwu2eH/7Q2D4wG4wYASxtKKkHKHRo5QX52/8Y3+3eI5/sFkDyHPKjOaWIVa44aJ11wfxXdrthKqvyT2Y2ihb2DSVA9MmWDwOoJ4EdngAnAiQGkIPbF0tS8pmZXX+PJB68tHoaN7TnNw1PtyF9KYnVaqrIBKTObOfoDImCGXEB678DWyn/mdrw0xNOY02BfdNLPBafpxjoY5+xpD4lBBzSP0mns8auCpsummw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UTWuVA/PKII03b9Ud+TBmW9Flw5UFL/LyPiWeM9twU=;
 b=OxWsCB9xWcLMU16a5zTGaga028BemfhfRddIEGHAQFeT7mVGud+e84BA+rY06WltQ/pvdgXv1oB4+esyZTOVOeJQv9OCO2vqMasDqM8QfIzbrUPeW7ySyoAr8TK9cJJsTDp0G/B/M3qddvb/FZjmCN1Fc1dY0hiGCu+HwWR+z6sf3AvVYqnD32Pzy1R3sNDGCpprR8DaGvfKtmn8TeeWQa8DMBU/1t2jV0Hh5xiBH3ek5EuaVrsTJMs1cLYXCzI4ianrNa3143IJzV383CSjRyh20uYGT3wPq+yaL3agLhD7a/p0BttKWXj28cmsqgCZ6bEtH/I5P2gcwOMYKxnrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UTWuVA/PKII03b9Ud+TBmW9Flw5UFL/LyPiWeM9twU=;
 b=E4Oj4n0bb1RzjPP4MFBFKKfBcGDhHDXrY8DfZbvxbRMLbL9bSjq2E9raqhPWw8Rpym4fz5AKdewYoJ5pC7pHoPvyu9HrjzXXNFRZG+zLgcmJqaEVhpRBsu7rkdeTcXUu+RKyTDSN/wKYquNnAlBIReEPlOB7Kxsh2ZEBCLDdHO4=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1630.namprd11.prod.outlook.com (10.172.55.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Sat, 18 Jan 2020 07:15:17 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.015; Sat, 18 Jan 2020
 07:15:16 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix opcode for OP_VEND_MODEL_APP_GET
Thread-Topic: [PATCH BlueZ] mesh: Fix opcode for OP_VEND_MODEL_APP_GET
Thread-Index: AQHVzYrNP/1D3jsRFk2EkhEJhdLpOqfwAvsA
Date:   Sat, 18 Jan 2020 07:15:16 +0000
Message-ID: <e0a3bac4f548f8a2a9426ca8859e4fefacc0bcfc.camel@intel.com>
References: <20200117230613.2495-1-inga.stotland@intel.com>
In-Reply-To: <20200117230613.2495-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d17342b-b25e-4b1a-07c1-08d79be62b71
x-ms-traffictypediagnostic: MWHPR11MB1630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1630B41F2CE6F35F4FE559A9E1300@MWHPR11MB1630.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0286D7B531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(76116006)(26005)(36756003)(186003)(2616005)(71200400001)(5660300002)(86362001)(6506007)(66556008)(66446008)(6636002)(64756008)(66946007)(66476007)(2906002)(110136005)(6486002)(4744005)(8936002)(8676002)(81156014)(81166006)(6512007)(478600001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1630;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhHv3tdX/wntOYvAab4hm4v2GdK6/PefsPuJlCOSfAQkQtlQ0wgC0JpkKfYm+Q5cEDVXHc3kMgY2sSqg6Usew7U+mH/qJp2mbIe3mJsVGlmHAUotvEZTloVTfuFXIfWmp5i2bYQqKzmAftbUfutlxOHrFviCKArOh7E1ip6au1Yj94SLPvoQootp8+TZY2wztSZ8+2SEfZhwGnfq2qD7YmqVEaCb3MBdowfA49HY73HAop6ogxfOMsbpegY3QTdDuY0MrN012qjf0Jy28SwjGq/Ohza1qY6j/DaQUw7Ykf2h0TX3UjdIZTzA9d6TPhm78hZLeDwnUA821gahjp6Ow+Bz0w0pC/KshuLbgyPTMgVjsLSOW5G5S1NjLlQmXwFYokFt9I5FHrls4BNO4tSsTVfLOQKJo085LYyLn0i/XWx4GgrdzMExZE0QfQt3g2Ac
Content-Type: text/plain; charset="utf-8"
Content-ID: <205309E3883DC04FA07DE28A6A4C183A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17342b-b25e-4b1a-07c1-08d79be62b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2020 07:15:16.8536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6CSq1DdwYxFn6fbyznaX2v+gDi5Fs75qpVu5b3l5AeDvXf2DfiNvrpMISLtCBkzZptGbvaF36Ni5VU/Bd4MCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1630
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gRnJpLCAyMDIwLTAxLTE3IGF0IDE1OjA2IC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGNoYW5nZXMgdGhlIHZhbHVlIG9mIE9QX1ZFTkRfTU9ERUxfQVBQX0dF
VCB0byAweDgwNEQgKGl0IHdhcw0KPiBpbmNvcnJlY3RseSBzZXQgdG8gMHg4MDRDKQ0KPiAtLS0N
Cj4gIG1lc2gvY2ZnbW9kLmggfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL2NmZ21vZC5oIGIvbWVz
aC9jZmdtb2QuaA0KPiBpbmRleCBkYThiNWIzMmIuLjM4M2ZkYmY2YiAxMDA2NDQNCj4gLS0tIGEv
bWVzaC9jZmdtb2QuaA0KPiArKysgYi9tZXNoL2NmZ21vZC5oDQo+IEBAIC05MSw3ICs5MSw3IEBA
DQo+ICAjZGVmaW5lIE9QX05PREVfUkVTRVRfU1RBVFVTCQkJMHg4MDRBDQo+ICAjZGVmaW5lIE9Q
X01PREVMX0FQUF9HRVQJCQkweDgwNEINCj4gICNkZWZpbmUgT1BfTU9ERUxfQVBQX0xJU1QJCQkw
eDgwNEMNCj4gLSNkZWZpbmUgT1BfVkVORF9NT0RFTF9BUFBfR0VUCQkJMHg4MDRDDQo+ICsjZGVm
aW5lIE9QX1ZFTkRfTU9ERUxfQVBQX0dFVAkJCTB4ODA0RA0KPiAgI2RlZmluZSBPUF9WRU5EX01P
REVMX0FQUF9MSVNUCQkJMHg4MDRFDQo+ICANCj4gIHZvaWQgY2ZnbW9kX3NlcnZlcl9pbml0KHN0
cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQ4X3QgZWxlX2lkeCk7DQo=
