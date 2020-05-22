Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C86B2073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iAUhLO14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgEVUy2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 16:54:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:63655 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbgEVUy1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 16:54:27 -0400
IronPort-SDR: EOPRK4jw9jbkknVrwetlfmg4P9HnVEcMuqKz7od8Ao9TY4UfifLDUtY3sGKgwifi9qGUlXB9dT
 +RY586I2m+Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 13:54:26 -0700
IronPort-SDR: JA1+q8CPbXEa69DOp4OzHe+siX777TS9Z+GxXrx9QUqhHH9HOrpEtEv/3h5O9Z6173/B84c9fP
 716K5nFYEIow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="283514184"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2020 13:54:26 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 May 2020 13:54:26 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX160.amr.corp.intel.com (10.22.226.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 May 2020 13:54:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 May 2020 13:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxqI3qcZFk/cdQsWCPcmHmtBDv6YzV5Bx/BsNsMoYfaSi/0quqVW6p5CtOcjKQ6p0XFOkcLyyqU/oE6LAQLh7yAt/OR9834uBn5STi8glCFr8DarPPFExarfOZLAohGbvX8GrMtcF1QhXSZqmw2ufIw1U1K0e766ycWI3sr9ehCKzxxqqj35MzthhXBg3k6PJALYKSnbPSMvlhHguv9omop2Rp8KBf7qwhPAghOVMUEDbrNzH+tobLuh+AKGcqZBIr1CsLm3wq9xVbr98aJEQZnNkteuhEE3yTdgQfA/xBA6MNs34CaMcPxSaOJd2jS28dhS5fyWv/NwVSRNtYBrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0Asw6JZCVsvbw7CN8ycI93niEpPQJPg/SgXZ407SV0=;
 b=MVVbxlfVruev2Hgpe5nUrufIqaXL0S0dckmSxjcJVvag6DBMpK7hm7VLGR9kQhpOwoFsWzErXT7bN1YDcCoJlnmDQy+scndu+7nBTsPEszifX4Vgx//ejEeoaRDIRFKKgw1Gf7J4yCwuUqL69AaJ5cLUZ27esPWZ4QBi53VaPHKHpwZ1D5TjUmWljpm/GtqFWZfJ/aXOzbhY7oVcum1ZYMu77oEI0R9H0k5c2p7fgto2vsIDQotYoWZwAsoySZQT0qPImuW2e+yY/rhFf8AbDaMcn8Ah/t8IrkVhXARL1okp1lsoc3cdntOuuNXZ2sfgMJswsYKKlsLfk8uTOzzdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0Asw6JZCVsvbw7CN8ycI93niEpPQJPg/SgXZ407SV0=;
 b=iAUhLO14Kjb1gbXSVf7F+LP6V7s4fTgESGHMLSQRm0FIGEf1TogKCz0ru9pKgyiqYnMaHXXrU5r7vgvd39hbpq1NMdvrLvEvGzTriYzgeaK+Q1wlZqSBpRlue3ctvaVIvRcqcLdRKCFIkQ8CzL7ZvMG9wqRF3sx0RPT7jznMKFE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 20:54:24 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 20:54:24 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 00/10] Mesh code clean up
Thread-Topic: [PATCH BlueZ 00/10] Mesh code clean up
Thread-Index: AQHWL9DjEBGCcy+jQEKR4Rr07Jgfgai0lraA
Date:   Fri, 22 May 2020 20:54:24 +0000
Message-ID: <bb9f034b83fc4beb08350d20979e191ec3f7c84b.camel@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d92b96aa-5c83-4b04-763a-08d7fe924f3e
x-ms-traffictypediagnostic: MW3PR11MB4587:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45876C88EF837B2575CC399DE1B40@MW3PR11MB4587.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eobdWKAZ3pJzOsnZ3SN2r88tso8l2pE0t4psEK8/BoqCuveTXexQozI6iGOyGIYIczRAMAliQINsYrs8AkJjSIaQYaCJvqCIb+4OK59RucEgq7hJtxsGaxm/kjkef1dZVk3r9Z+ntNk4pZ0J5rMqgfUJ6xwVlNOhOJj0KFfmLhfOqBp3J0Ky0ITdqOfGynD1tqLi9D+WCqzgjJMcX23ZljQJWzb1kjQ3SYwGbz6SCT0mDGDLfp0O1muwo5J1etafLrsyZr7fNqkBFAaKG++WBiZDV6F30OWNAHU4VjeQeQl7qwSoD7aPVYF21ewLydg7jOgV3XYfJbYLYlnHLqs/fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(346002)(366004)(376002)(136003)(2616005)(110136005)(6512007)(86362001)(316002)(6486002)(4744005)(36756003)(8676002)(478600001)(8936002)(5660300002)(71200400001)(76116006)(66446008)(91956017)(66476007)(66946007)(66556008)(64756008)(6506007)(2906002)(26005)(6636002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xY9HTnVHY2S9KMurkAdO8QikYNfCQdRBxraWrU8TsRTaMxYMWW7e4Xy5QOJj61SZOxK5fRKg4/qYzb+ZWpZI7geOZxG81bbjIi3+d3VcBWI4kvRkgX2rliFAyUeicsTPI4K8i8ctXzRIsh09soF5MueTsKYJ8Ig4IzS0wZIjho2fgXPXh0GAMubJY1ir6Pge01yoXmd3quM1Aep67L2P+Hoacl7AgzpZBkgp+mHG+e6ZfRLMKvk+vnfW+yUoXWEZagY22AMCmu3pucz6prPdkDTfGIqAlxZHEH1Kzz88H3o9O+AsCXaCCFEzGT3eUAeoqONWXlMa8JBx3wacATEpPr/tLY8Qv1pxe4S46ghax5yB+rOQ2T7GXwsE5o6uWXPfc0OMH9nLc/nRTBQv4UbQdfQjAFbAtEVixi6CrCamY4/NAjABMpmajeCvIBGeMA5qFjgz2NHGiu0MNtWniZemM7w9lSYLfntTO0R4ifV3aIY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E52EE2CA5CE6CB4FBE87881CCEBE5E1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d92b96aa-5c83-4b04-763a-08d7fe924f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 20:54:24.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tRR8k6Vq3lkDX5SVRJAvODIE5BnfkVCFzH1ZhZpK53wzCVuUJvInk/y7CI+F13bm3IRkNVa7yE7b4d+NjufRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBQYXRjaHNldA0KDQpPbiBUaHUsIDIwMjAtMDUtMjEgYXQgMTc6MzQgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgcGF0Y2hzZXQgaXMgY29udGFpbnMgYSBudW1iZXIg
b2YgbWVtb3J5IGxlYWsgZml4ZXMgYW5kDQo+IHNvbWUgc3R5bGlzdGljIGNoYW5nZXMgdGhhdCBo
b3BlZnVsbHkgcmVzdWx0IGluIG1vcmUgY29tcGFjdA0KPiBhbmQgcmVhZGFibGUgY29kZS4NCj4g
DQo+IEluZ2EgU3RvdGxhbmQgKDEwKToNCj4gICBtZXNoOiBSZW1vdmUgdW51c2VkIHN0cnVjdHVy
ZSBtZW1iZXINCj4gICBtZXNoOiBGcmVlIGFsbG9jYXRlZCBhZ2VudCBpbiBtZXNoX3JlbW92ZV9h
Z2VudCgpDQo+ICAgbWVzaDogUmVtb3ZlIGFnZW50IHdoZW4gZnJlZWluZyBub2RlJ3MgZHluYW1p
YyByZXNvdXJjZXMNCj4gICBtZXNoOiBBZGQgZmluYWxpemF0aW9uIG9mIGEgbmV3bHkgY3JlYXRl
ZCBub2RlDQo+ICAgbWVzaDogUmVtb3ZlIHVudXNlZCBmdW5jdGlvbiBwcm90b3R5cGVzIGZyb20g
bm9kZS5oDQo+ICAgbWVzaDogQ3JlYXRlIGEgcXVldWUgb2YgcGVuZGluZyByZXF1ZXN0cyBpbiBt
ZXNoX2luaXQoKQ0KPiAgIG1lc2g6IENsZWFuIHVwIEltcG9ydCgpIG1ldGhvZCBjYWxsDQo+ICAg
bWVzaDogQ2xlYW4gdXAgQXR0YWNoKCkgbWV0aG9kIGNhbGwNCj4gICBtZXNoOiBGaXggbWVtb3J5
IGxlYWsgaW4gQ3JlYXRlLCBJbXBvcnQgJiBBdHRhY2ggbWV0aG9kcw0KPiAgIG1lc2g6IENsZWFu
IHVwIEpvaW4oKSBtZXRob2QNCj4gDQo+ICBtZXNoL2FnZW50LmMgfCAgMTAgKystLQ0KPiAgbWVz
aC9tZXNoLmMgIHwgMTM2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgbWVzaC9ub2RlLmMgIHwgIDU3ICsrKysrKysrKysrKy0tLS0tLS0tLQ0K
PiAgbWVzaC9ub2RlLmggIHwgICA3ICsrLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRp
b25zKCspLCAxMjIgZGVsZXRpb25zKC0pDQo+IA0K
