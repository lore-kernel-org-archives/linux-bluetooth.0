Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7849C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71D20409
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="a8lcgZQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLCSuf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:50:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:5930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfLCSuf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 13:50:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 10:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="222923630"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 10:50:33 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 10:50:18 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 10:50:18 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 3 Dec 2019 10:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/5TSUiRtPbaosHMfHak1ndTm7H7ki0Do/6OFzowCtEVpLAV77KG4uXbXyzKRWqb8FxcKUTB2sUUiQjCvK85gRPTL63wBMEivRhZAYYCh7SUZst8k3VZJuUCSrPxEbzIaFF5tZgh21L4i/7H4EvQoFGQ68EoYlmcnTziP0luLVXDKV0+jhT1wimf6X+I2qA3crR0O/UdObcgXahvFCfKOjoHPzQGKsGM73gMzxHveWjJhTqmYoCGm/FyrvZPiD5zX2erQ0IDSotdy5QpR/ZJ7o+xL+EQRAus8eY+YHpvwGp9w/ROI09Hh7PK+TWwRPUpne+hIBbMJferklegHTIFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eceARnUUeORK5lGrGTW5nJ+b1cWItMzN8dYZOhMGTk=;
 b=dgIuxaUAkwpYvSxwTCuMCVzUcrG4cgXenGiw9SplCWxWlIw87A258q0o80SR4+W6Hd04feYy3cytOHVbPao8Vpkqy8WVz/8q0CCBXQL3eYK0YGsu4ALnrzJoUcQSwbKZT6fAH4snHoGnBstgZ/mCrDOkbrDhU7ItYPcS9U7AV9Qzqectr45/RUPFx4ULDYyGsFAZNvmLeGrcVhb/ytOfhl3QsnUnLXhxhXx7FwJXQVHTo++p3fsgJ0VjTtQofu0bDndc8lK3qrUC4z5ATaoSEcYzA0UzG4zfFEH5DXwjcQYoj8QaYyTC8B1Bcpr5MXDMftw05jvU3DqaLhymCh4X3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eceARnUUeORK5lGrGTW5nJ+b1cWItMzN8dYZOhMGTk=;
 b=a8lcgZQORbuP3pEzuf8Nm5h7q15PJ6MENGtJuzgOrLOvSEIZkYyLXpoi7CsuFsheJDZzygtVYR5IzDJzbKEJ2UO6QLPxldj6Op6bd6kP1f98xgkqI3gwN5OiSX+yGG1F8wX427maGV/zQJciTmYSC1oKa+3Bs+92pbPoO58v1EA=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB2022.namprd11.prod.outlook.com (10.173.16.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 18:50:16 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 18:50:16 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] mesh: Fix invalid transaction number in PROV_INVITE
Thread-Topic: [PATCH 1/1] mesh: Fix invalid transaction number in PROV_INVITE
Thread-Index: AQHVqcDIhfk0Jl1POUe4IyYX1ccvIaeowX6A
Date:   Tue, 3 Dec 2019 18:50:15 +0000
Message-ID: <d806af62b13b384ed003a38ed92c3ae95398a9e4.camel@intel.com>
References: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
         <CGME20191203100133epcas5p190c7b3e7e06d84b1db57ec85054876ef@epcas5p1.samsung.com>
         <1575367285-8098-2-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1575367285-8098-2-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f40f7f-e5f5-42f0-23a0-08d77821a31f
x-ms-traffictypediagnostic: CY4PR11MB2022:
x-microsoft-antispam-prvs: <CY4PR11MB20221970FA2F230C2403F1E7E1420@CY4PR11MB2022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(3846002)(6116002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(305945005)(91956017)(7736002)(81156014)(99286004)(256004)(86362001)(5660300002)(316002)(2501003)(118296001)(4744005)(110136005)(2906002)(6246003)(478600001)(36756003)(25786009)(6436002)(81166006)(6512007)(8676002)(2616005)(6506007)(229853002)(6486002)(8936002)(446003)(26005)(11346002)(186003)(102836004)(71190400001)(14454004)(71200400001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB2022;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9jQpscZz1iNYsde5obWpV+1SukNzqNFlc56xDfr8LuYcCCw1YrA5Xa7NpdT0WDzsH5S3+N3W0moGFrWvfAiPsQcxbyzCU0Z//XLR7XDsQWt14iaXbwQ5Zhx2CKDKbXV0fM1wVBSEvpTvoEx3beV5YwpzFAGDb47A12lWdFe2HQ+oHFITMyzR/JoZhOEz8YP6XCb30Wjhd99mLPNKVGr9rMyFnTqvXwKRWpwzVM9X6bw7CQ45SMtX7a6JM5TjLZhXSjqPayjtLBxbVPkH8Jh+Gon+FZG5vd7vsc1Khz4x5Gieoy+c0DSsejUESd/Ltuz19WB2W+Z1PAcQG/qKvaXxVIx7KuFfh+p2dVYkB4cwNBN2y5JtE9eD9+ym1+w5vkmOJlqJCgyN7C3tGk9OkHaAVpkWb54kP7p+35u6X37YGeH0P14f8qaL4SV5Z+qhCWI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9564232117B1DA408153F3901C08E4C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f40f7f-e5f5-42f0-23a0-08d77821a31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 18:50:16.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOSJfa/1AuQZ4wXmcRAMNBrOldrH1bZDd8NJHWbwqF6k8/5f3AES7m2KIuV5KNKzBKOtumLss3ajmbXmgp1AYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2022
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTItMDMgYXQgMTU6MzEgKzA1MzAsIFByYXRoeXVzaGEg
TmVsbHVyaSB3cm90ZToNCj4gRnJvbTogUHJhdGh5dXNoYSBOIDxwcmF0aHl1c2hhLm5Ac2Ftc3Vu
Zy5jb20+DQo+IA0KPiBGb3IgaW5pdGlhdG9yLCB0cmFuc2FjdGlvbiBudW1iZXIgc3RhcnRzIGZy
b20gMHgwMCB3aGVyZSBhcyBmb3IgYWNjZXB0b3INCj4gdHJhbnNhY3Rpb24gbnVtYmVyIHN0YXJ0
cyBmcm9tIDB4ODAuIFNpbmNlIHRyYW5zYWN0aW9uIG51bWJlciBpcw0KPiBwcmUtaW5jcmVtZW50
ZWQgYW5kIHNlbnQgaW4gZXZlcnkgcGFja2V0LCBpbml0aWFsaXplIGl0IHdpdGggMHhGRiBmb3IN
Cj4gaW5pdGlhdG9yIGFuZCAweDdGIGZvciBhY2NlcHRvci4NCj4gLS0tDQo+ICBtZXNoL3BiLWFk
di5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9tZXNoL3BiLWFkdi5jIGIvbWVzaC9wYi1hZHYuYw0KPiBpbmRleCA2YjRhNzAwLi4x
OWQxNDUzIDEwMDY0NA0KPiAtLS0gYS9tZXNoL3BiLWFkdi5jDQo+ICsrKyBiL21lc2gvcGItYWR2
LmMNCj4gQEAgLTI5Miw2ICsyOTIsNyBAQCBzdGF0aWMgdm9pZCBwYl9hZHZfcGFja2V0KHZvaWQg
KnVzZXJfZGF0YSwgY29uc3QgdWludDhfdCAqcGt0LCB1aW50MTZfdCBsZW4pDQo+ICAJCS8qIE9u
bHkgY2FsbCBPcGVuIGNhbGxiYWNrIG9uY2UgKi8NCj4gIAkJaWYgKGZpcnN0KSB7DQo+ICAJCQls
X2RlYnVnKCJQQi1BRFYgb3BlbiBjb25maXJtZWQiKTsNCj4gKwkJCXNlc3Npb24tPmxvY2FsX3Ry
YW5zX251bSA9IDB4RkY7DQo+ICAJCQlzZXNzaW9uLT5vcGVuX2NiKHNlc3Npb24tPnVzZXJfZGF0
YSwgcGJfYWR2X3R4LA0KPiAgCQkJCQkJCXNlc3Npb24sIFBCX0FEVik7DQo+ICAJCX0NCg==
