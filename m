Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A0C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CA52084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 17:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="y6TaNC/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKLR4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:56:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:1684 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLR4U (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 12:56:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 09:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="287624348"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2019 09:56:20 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:56:19 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:56:19 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 12 Nov 2019 09:56:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm4vYCX2lMExZI043XyedeZ+FpmeP0GV5YwwboF5eMpgv0+3A2f6coJwrClUI1XuCVL857jAXdJmsMu0Ndr85Bw2QY3pxMwMyKR+lTykjrZOZW79uEGEIirOOs9H3FhaTZOhXJ4Q67J+CdBuuPITHhdqVQK/by+y/blIDND0CrEJ4yOuac7g8ubsJl8nUfpQS4kaUOtvfgR3Efkbi/cYEU6ig2ww6Wi9DX/MnxOlNl7acjVfs+TvoPr0RYJeC6NKZO6ZPHto50g6za+VMx8lo/pd0ZjM2/D3Iiob5N3uYq9vDSIgJazi9bFhQjKNomtVovRC/Kl11VI1QRbqcbHO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrPWYFrOBbuPCKnwFek5UBkgP0wB5XjGUyQ9xTfLMq0=;
 b=i8XUhjWxlFwH7nNZme6/0Y3ZLx58X9J14V2ke3FVD3Qf/1hz0rlRUIBVu+w1znE0QJryhQN+njVKv8yZmTiHliFI7Ah/KjrDxBo5AavEF42hTW+kSqI4RJeoG3x8dM3emLzokjLhslPeEtVq5jXyivnAVVC0EcIsE3Losstz1LTXm2XGjmXr20fvh45r4Bsj7JxDwSkcTNT2AGl54BNxGg4G8KMviVwQUX/lAe1UfgcquArK2X0GvVz76fj6ZU5nPP8BRfWWm2/Wx+NhC60psNI2FtnwdUNECcl3Q/S1qbZR+ldxQi1xKXLahcVBo6NFWC0WgtLegHgu2kxrt2FIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrPWYFrOBbuPCKnwFek5UBkgP0wB5XjGUyQ9xTfLMq0=;
 b=y6TaNC/plAPf7x6s7UPp8nuvahRLHMu4tOvqpLOOoySBle78gkbOR8SY6SEevcXGmsUCw2J0Vgr+hj5T5HXoSYxirT4E2IPG8dQIbo1BViEg/6rMVh2Fuzos6KKAFWAFiv1R1xfSTzHrLCX59pUVh7GGr/ZEcZpKfjFPgxX2/cU=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2215.namprd11.prod.outlook.com (10.174.52.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 17:56:15 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 17:56:15 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix clean up after AddNode method
Thread-Topic: [PATCH BlueZ] mesh: Fix clean up after AddNode method
Thread-Index: AQHVlpGvzjRWVhTdwEe3kk0F4Kf7PqeH19CA
Date:   Tue, 12 Nov 2019 17:56:15 +0000
Message-ID: <8158a78610ff3ecae0a5a0b86e3c0bca58018f0d.camel@intel.com>
References: <20191109000700.5428-1-inga.stotland@intel.com>
In-Reply-To: <20191109000700.5428-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfb37332-d32f-4212-f884-08d767999d12
x-ms-traffictypediagnostic: CY4PR1101MB2215:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2215377794B588F8D614476FE1770@CY4PR1101MB2215.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(6636002)(186003)(99286004)(6436002)(71190400001)(118296001)(25786009)(305945005)(486006)(6506007)(102836004)(76176011)(446003)(11346002)(26005)(7736002)(66066001)(476003)(2616005)(6512007)(6486002)(229853002)(256004)(71200400001)(6246003)(66556008)(66476007)(64756008)(81166006)(81156014)(66946007)(66446008)(8676002)(76116006)(14444005)(2906002)(6116002)(478600001)(3846002)(91956017)(2501003)(316002)(36756003)(14454004)(8936002)(5660300002)(110136005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2215;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bk7HnFyE2gLYx7E5cYyGcjddp7jnpwMrJsuTaxnNDPyNzypMqmTOIvyT5HTAu1O1TltWimw8Xiafg4KMLTedGa1dknkBRsNmJpKGlXEsfe0DksUiKCZh+qgMrqKzx9R1QZlmaEpXZOC19icoREepFHl8625dnN6CUuTWNUcyIbmisnI4J70wheIYzizeHcUu9SO1pf2suWGOq1r/YuzpP+rDBjmwMz+VHGSLrlf3Et0Ue2Xvlie05hk6cYYFVUlBDk3B8ro0zxg3h+VMO9ZV97CWO8FcvZpRSn3CkC4qPGhHnIj5AD31MNXETU5v1W0Ru86gZTMpxRClC2GmJQ2uwcSDNtXHZzEasu26DcB3dwsjAfZfYZ+3xF1OUwjo9jWwBzLPWp1YbIbfRLcK53kTUFiWEBfVQKvhz+7JogBfyfq6o22+Ba3M9i6DAou0Y5Cw
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC48E67C0E27294DAF32CEC091FFA40D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb37332-d32f-4212-f884-08d767999d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 17:56:15.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xID3pmwA3r/Ou+zZwaX9JCThPKFxhOoCfyyyh3nCRT6Q2zquTD2Goj4/Kai0ifEpSU1tyuxRqKXkGazx31vjCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2215
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIEZyaSwgMjAxOS0xMS0wOCBhdCAxNjowNyAtMDgwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gVGhpcyBmaXhlcyB0aGUgY2xlYW51cCByb3V0aW5lIHRoYXQg
aXMgY2FsbGVkIGFmdGVyIEFkZE5vZGUgbWV0aG9kDQo+IG9uIG9yZy5ibHVlei5tZXNoLk1hbmFn
ZXIxIGludGVyZmFjZSBpcyBjb21wbGV0ZTogZG8gbm90IHJlbW92ZQ0KPiB0aGUgYWdlbnQgYXNz
b2NpYXRlZCB3aXRoIHRoZSBQcm92aXNpb25lciAob3duZXIgb2YgTWFuYWdlciBpbnRlcmZhY2Up
Lg0KPiAtLS0NCj4gIG1lc2gvbWFuYWdlci5jIHwgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9t
YW5hZ2VyLmMgYi9tZXNoL21hbmFnZXIuYw0KPiBpbmRleCBiMzllYTZlZDcuLjBiMTFiNDU0MSAx
MDA2NDQNCj4gLS0tIGEvbWVzaC9tYW5hZ2VyLmMNCj4gKysrIGIvbWVzaC9tYW5hZ2VyLmMNCj4g
QEAgLTgwLDggKzgwLDYgQEAgc3RhdGljIHZvaWQgZnJlZV9wZW5kaW5nX2FkZF9jYWxsKCkNCj4g
IAkJbF9kYnVzX3JlbW92ZV93YXRjaChkYnVzX2dldF9idXMoKSwNCj4gIAkJCQkJCWFkZF9wZW5k
aW5nLT5kaXNjX3dhdGNoKTsNCj4gIA0KPiAtCW1lc2hfYWdlbnRfcmVtb3ZlKGFkZF9wZW5kaW5n
LT5hZ2VudCk7DQo+IC0NCj4gIAlsX2ZyZWUoYWRkX3BlbmRpbmcpOw0KPiAgCWFkZF9wZW5kaW5n
ID0gTlVMTDsNCj4gIH0NCj4gQEAgLTI0Niw3ICsyNDQsNyBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1
c19tZXNzYWdlICphZGRfbm9kZV9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICAJYWRkX3Bl
bmRpbmcgPSBsX25ldyhzdHJ1Y3QgYWRkX2RhdGEsIDEpOw0KPiAgCW1lbWNweShhZGRfcGVuZGlu
Zy0+dXVpZCwgdXVpZCwgMTYpOw0KPiAgCWFkZF9wZW5kaW5nLT5ub2RlID0gbm9kZTsNCj4gLQlh
ZGRfcGVuZGluZy0+YWdlbnQgPSBub2RlX2dldF9hZ2VudChub2RlKTs7DQo+ICsJYWRkX3BlbmRp
bmctPmFnZW50ID0gbm9kZV9nZXRfYWdlbnQobm9kZSk7DQo+ICANCj4gIAlpZiAoIW5vZGVfaXNf
cHJvdmlzaW9uZXIobm9kZSkgfHwgKGFkZF9wZW5kaW5nLT5hZ2VudCA9PSBOVUxMKSkgew0KPiAg
CQlsX2luZm8oIlByb3Zpc2lvbmVyOiAlZCIsIG5vZGVfaXNfcHJvdmlzaW9uZXIobm9kZSkpOw0K
