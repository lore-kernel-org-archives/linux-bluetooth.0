Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF212C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A223D24656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Tn8MXkun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgAVQtC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:49:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:29008 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgAVQtC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 11:49:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="425912816"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2020 08:49:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 08:49:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Jan 2020 08:49:00 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 22 Jan 2020 08:49:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 08:48:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0815rW1qOI5KBOSVepYz4Xd55AaESJHKxZb8MQljAfvN98gJ8kWIQ0BbJU7HrBS2B/lhtdg8DZ4xEfAk7IvwjhFl1yzokxLqAeQszgpmAMPGGP5Gyjh6FMR/g6A1e9vA8O/ygHB4hQOtMtDYe9wOWGWOnfK6c2a3bMcykAZomxcYuBncqTnzI7zhWlhC9UQja6rSHNo/st+5J3H58ttms+3tsif6GqTeJHDbuAXPtUwotqrybDwOKUn7QkBQag+daZKvReqgkopgLNJzwDoxnP1QYRtmOSEk6JGzbzstystXde0QChzOGcnwGs6gn+Dlqp3WmZbm+zDZ1SjalaHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S15yP2QBRV1K9qdAMsJmSAJE/XhB2IqvcQus1dfBpQ=;
 b=RU9VcLGEcNhYAVpzWda+wk5JoWl7ZvgJhByNdI33BZfefv76TbAx9J1JNDOHtfgaiq5AorwSezlwkSTarT27GwZeVDzsiBG3feRcJtLuw2pmC69hCi6QoLr9hizkYm4/VfSjG/AAqYanawJeywnWo4yWxTIUo2wEHwniHBZEJhJ+W5BOKDYS5RUNYjFuE1L8ZeCRu82/ThJtZxHuYrS4WB2fDiLbGVrKdhYQyLDFvVoFBMtYgaR3nGS5gfN72ZACWFjm0s2GcaRKhJTLBPb5G0ZyxS0DFc2wyIJJhRwesRjz8x9yne/vX72KAjzHPYjZIN2UNuBGlO/IMUSVDBcI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S15yP2QBRV1K9qdAMsJmSAJE/XhB2IqvcQus1dfBpQ=;
 b=Tn8MXkunqhuMs6knhc1zRGOw0zfrE8xaZjrLSYzAWAYfkg4FQkpGXvR96fhKM/F17O2AfFtbEAWCRW1s0OAAVDKd4klqR2k5FdFZ5CUNx4DcHHsEbgKtKYhLHhkCPOJlrFqGDEnwMT4rpj7MulY5fmTt3PXXRaVp8TZsrA02quk=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1614.namprd11.prod.outlook.com (10.172.56.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 16:48:55 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 16:48:55 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/4] Add functionality to mesh-cfgclient tool
Thread-Topic: [PATCH BlueZ 0/4] Add functionality to mesh-cfgclient tool
Thread-Index: AQHVzbb4Pon5IeusjUW/aqGCFdTldaf27DsA
Date:   Wed, 22 Jan 2020 16:48:54 +0000
Message-ID: <a26564cd4be1bc6a7d05c220a4be4267f3033126.camel@intel.com>
References: <20200118042233.15338-1-inga.stotland@intel.com>
In-Reply-To: <20200118042233.15338-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed3101a5-6d03-4da1-df13-08d79f5af7d6
x-ms-traffictypediagnostic: MWHPR11MB1614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB16147B389D8616103D432CB1E10C0@MWHPR11MB1614.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(64756008)(66556008)(66476007)(66446008)(110136005)(36756003)(66946007)(2906002)(26005)(71200400001)(76116006)(316002)(6636002)(186003)(91956017)(6512007)(8676002)(6486002)(86362001)(4744005)(81156014)(2616005)(478600001)(6506007)(81166006)(5660300002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1614;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ra3PnjrNxHKIXkAEXlUkkpZ+40ozz1Xh2uz34x6Y7Jf5eBQic4g/d/eFvhszr4PPtjLB1wqmIR9EkBlT8ITsUWTqZi4C093XxCJK+/1AiQFJ7PxGPwMyFPUXU2hRklp78bMyztNrWsfda5i4GsO5f2XKjLR5aDgBPSzlBda7MuXjfzGyBUUKteiJHpK4GiNuoXBMGA7gVe/YGNjIw4asuBsgUsM25wznDbQt8OouV7Kxv867KK1CK6ZzEDuA76YLlOcNQrM7NUuuzzh3KB2HG7sbMw3pnDSgKbHlRoPzKYb7L20Gi0KKGTvw1XxMP+JaoHkM9N786NQop+x57rlZe/98L08e4fepkeLtoALlHD/VryspsxVFn+reRMYNIGrtyx1rWmOlKeoM8EDNpgq3gRxOV5TVddzTr07zAJD4UkQ814HIFH9FSeobPRsj4ER7
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BDDD9D12C871841948E1F114347CE92@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3101a5-6d03-4da1-df13-08d79f5af7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 16:48:54.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uydu+2YE/4GMkitYRXguWjm0q3i0K3AQPncpJmCDboV1/fbcEwmRwR+L6MAO357W6cq0fUjZMABKqk6L+9BZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1614
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gRnJpLCAyMDIwLTAxLTE3IGF0IDIwOjIyIC0wODAwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHNldCBvZiBwYXRjaGVzIGFkZHMgbW9yZSBmdW5jdGlv
bmFsaXR5IHRvIG1lc2ggY29uZmlndXJhdGlvb24gdG9vbA0KPiBhcyB3ZWxsIGFzIGEgYml0IG9m
IGNvZGUgdGlnaHRlbmluZy4NCj4gDQo+IA0KPiBJbmdhIFN0b3RsYW5kICg0KToNCj4gICB0b29s
cy9tZXNoOiBSZWZhY3RvciBjb2RlIGZvciBnZW5lcmF0aW5nIG1vZGVsIElEDQo+ICAgdG9vbHMv
bWVzaDogQWRkIGxlbmd0aCBjaGVja3MgZm9yIHJ4ZWQgbWVzc2FnZXMNCj4gICB0b29scy9tZXNo
OiBBZGQgc3VwcG9ydCBmb3IgVmVuZG9yIE1vZGVsIEFwcCBHZXQvTGlzdA0KPiAgIHRvb2xzL21l
c2g6IEltcGxlbWVudCBtb2RlbCBncm91cCBzdWJzY3JpcHRpb24gY29tbWFuZHMNCj4gDQo+ICB0
b29scy9tZXNoL2NmZ2NsaS5jIHwgMjMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTU5IGluc2VydGlvbnMoKyksIDc0IGRl
bGV0aW9ucygtKQ0KPiANCg==
