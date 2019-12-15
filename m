Return-Path: <SRS0=+je2=2F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F0C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 17:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FC4206A5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 17:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FYI9ZuZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLOR7h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:59:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:22796 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfLOR7g (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Dec 2019 12:59:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 09:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,318,1571727600"; 
   d="scan'208";a="216960116"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2019 09:59:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Dec 2019 09:59:34 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Dec 2019 09:59:34 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 15 Dec 2019 09:59:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 15 Dec 2019 09:59:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGNw2isrUm79r+J42yDnN3tbLw2ojYVG8ehCdmnB7uUa8G+KsMQSUysAk/vPeebf1VXpTRU+ZANqbOs6T+wcQW+KSEAPnVYWQW055LyVJIevUDED/I/A5Er+ftGiylhXZuLLcU0jX+CH9zYWXAfaAGjRFnrKMxOrI5Kr8BX+SrImlw+n1kU9DcRj/GcnD/cNmD87kGao8NIJRdY5BJAJ1A1fF554UkCyu9sUl62dMniiFrwvFiljwtsg2BcW8rPyvE6YVPCbG41HRi+xJNCzgIG5+ch/7zzabupg+ApUktB0VcG7/ipWcf3agw8d/WyfNYyrxcFwJ+BcirHvIcT8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dymB9mD64KQVafJPd+N7DbhjuDksIo7Dp4biZ+jHmto=;
 b=U/Hp1b3GxUYhyueh6AWOXcctn15nbOYOw3Y07mXz819aiXcD3Fkxk7VRXNh5oEb3nvJFpo/ka4elzzFsXbcCUZzpMdMNe4AwMl/SQAm4eNvo5KBgqusS9LwZfYqgrQTwN4kx/qvh2E1VUFgUtA+ABttYyrW8Zw1Bb4T32Dr1hT40EAzrZS6KH6TlRuXPrCnQNpi6n1w4FBMdR0W84BIzXPtZ4bEmwDP0A9P6KEa9stRQZKzbmmuK/yFEI6/6H5hXHd4vxESd2cZjT+r2eKyhNzSEJqN9XADxlNLpnek4INSGVbztEJm4MeUt0xZBIxl6TbRa0gZuUOqN0ResNzfa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dymB9mD64KQVafJPd+N7DbhjuDksIo7Dp4biZ+jHmto=;
 b=FYI9ZuZauHqY8m7rObMAofVR3qdvcmL7caYNrO7wXST7EkyCdUxxdBmQaBmyNNnPxGUq0K+o9L/Dc0GB1AItbx8j5T0gHSFlGZ+KoRDdejblSpLAUR1PyMEqnl21lX6sfCgDu/ir413V69+tD4rrdAOdmtoHTDqR1bfuk1HbpMM=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1702.namprd11.prod.outlook.com (10.173.16.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Sun, 15 Dec 2019 17:59:32 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2516.021; Sun, 15 Dec 2019
 17:59:32 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Thread-Topic: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Thread-Index: AQHVr655Ej+mnsOuJ06B2Di94+XS9ae7g3CA
Date:   Sun, 15 Dec 2019 17:59:32 +0000
Message-ID: <8fc6635a780fe17d1ffead02aceb2a42387b0902.camel@intel.com>
References: <20191210230600.23035-1-inga.stotland@intel.com>
In-Reply-To: <20191210230600.23035-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e22094f-e13a-4e04-ba29-08d7818889f4
x-ms-traffictypediagnostic: CY4PR11MB1702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1702E7D14199144F53542264E1560@CY4PR11MB1702.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(186003)(86362001)(81156014)(81166006)(6636002)(2616005)(6512007)(26005)(4001150100001)(8936002)(66556008)(66476007)(6486002)(66446008)(64756008)(76116006)(66946007)(316002)(2906002)(36756003)(71200400001)(110136005)(6506007)(5660300002)(8676002)(478600001)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1702;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTGzOzo/iiNsUkLFWIXjHD3neCCQ5EGtOgSZA+SzfyGCZu/5DbxrdiJ6W89X25zpcdZp3oJRUuMc2eAjg0ghgMyvMkWmU5zBOgkwpzghaRr8iiHLaYmi5p3DzYZp1sD8rPd/fVO6DtOaHAulYBsulqeSdl1x+smdDhRM7keGLQ+BnsfVkHHAd8RjSNkNOk5hHDuAKBqLBB01Akt7WQqaiQK+Maa9VyyS+JN1G88e+c40LJGeAo63HYERNU8AINNmpaJpa+h5BBByQELb4xEgM2UbwKhldlNG4y/pCbjsUkCRfbbj3dPHvAxAlQyW26LnE6gm9ldS3g39Y9FochyqPTrUgNH/Q4Ec80mVzlugCkDgc69hD4rr4DteOTnT7tey/D3KVCQMXp+EYJHkWSzqrDo9ZkWlXJa5nYx1cVxq3WAMjF8Lw1pdavSKAxw8D7a6
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF3E782F0E3CE439992A9239E8C6A88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e22094f-e13a-4e04-ba29-08d7818889f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 17:59:32.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhYim4GNEDCjrhyH1D+xOeuS0OBROlHFBxJh6HJJUnJ1EXgOTx0C9Z8trVm8d2N/pPBWSQtk4BqBengDsm3BIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1702
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTItMTAgYXQgMTU6MDYgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgcmVtb3ZlcyB1bm5lY2Vzc2FyeSBob3VzZWtlZXBpbmcgZm9yIGhj
aSBjb250cm9sbGVycw0KPiAtLS0NCj4gIG1lc2gvbWVzaC1tZ210LmMgfCAyMiArKy0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyMCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2gtbWdtdC5jIGIvbWVzaC9tZXNo
LW1nbXQuYw0KPiBpbmRleCAyNzI3MmQ0ZDIuLjJjZjJlYmFjMiAxMDA2NDQNCj4gLS0tIGEvbWVz
aC9tZXNoLW1nbXQuYw0KPiArKysgYi9tZXNoL21lc2gtbWdtdC5jDQo+IEBAIC00MiwxNCArNDIs
OCBAQCBzdHJ1Y3QgcmVhZF9pbmZvX3JlcSB7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgc3RydWN0
IG1nbXQgKm1nbXRfbWVzaDsNCj4gLXN0YXRpYyBzdHJ1Y3QgbF9xdWV1ZSAqY29udHJvbGxlcnM7
DQo+ICBzdGF0aWMgc3RydWN0IGxfcXVldWUgKnJlYWRfaW5mb19yZWdzOw0KPiAgDQo+IC1zdGF0
aWMgYm9vbCBzaW1wbGVfbWF0Y2goY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikNCj4gLXsN
Cj4gLQlyZXR1cm4gYSA9PSBiOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgdm9pZCBwcm9jZXNzX3Jl
YWRfaW5mb19yZXEodm9pZCAqZGF0YSwgdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0KPiAgCXN0cnVj
dCByZWFkX2luZm9fcmVnICpyZWcgPSBkYXRhOw0KPiBAQCAtMTAxLDIzICs5NSwxNCBAQCBzdGF0
aWMgdm9pZCByZWFkX2luZm9fY2IodWludDhfdCBzdGF0dXMsIHVpbnQxNl90IGxlbmd0aCwNCj4g
IHN0YXRpYyB2b2lkIGluZGV4X2FkZGVkKHVpbnQxNl90IGluZGV4LCB1aW50MTZfdCBsZW5ndGgs
IGNvbnN0IHZvaWQgKnBhcmFtLA0KPiAgCQkJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCj4gIHsNCj4g
LQlpZiAobF9xdWV1ZV9maW5kKGNvbnRyb2xsZXJzLCBzaW1wbGVfbWF0Y2gsIExfVUlOVF9UT19Q
VFIoaW5kZXgpKSkNCj4gLQkJcmV0dXJuOw0KPiAtDQo+IC0JbF9xdWV1ZV9wdXNoX3RhaWwoY29u
dHJvbGxlcnMsIExfVUlOVF9UT19QVFIoaW5kZXgpKTsNCj4gLQ0KPiAtCWlmIChtZ210X3NlbmQo
bWdtdF9tZXNoLCBNR01UX09QX1JFQURfSU5GTywgaW5kZXgsIDAsIE5VTEwsDQo+IC0JCQlyZWFk
X2luZm9fY2IsIExfVUlOVF9UT19QVFIoaW5kZXgpLCBOVUxMKSAhPSAwKQ0KPiAtCQlyZXR1cm47
DQo+IC0NCj4gLQlsX3F1ZXVlX3JlbW92ZShjb250cm9sbGVycywgTF9VSU5UX1RPX1BUUihpbmRl
eCkpOw0KPiArCW1nbXRfc2VuZChtZ210X21lc2gsIE1HTVRfT1BfUkVBRF9JTkZPLCBpbmRleCwg
MCwgTlVMTCwNCj4gKwkJCQlyZWFkX2luZm9fY2IsIExfVUlOVF9UT19QVFIoaW5kZXgpLCBOVUxM
KTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgaW5kZXhfcmVtb3ZlZCh1aW50MTZfdCBpbmRl
eCwgdWludDE2X3QgbGVuZ3RoLCBjb25zdCB2b2lkICpwYXJhbSwNCj4gIAkJCQkJCQl2b2lkICp1
c2VyX2RhdGEpDQo+ICB7DQo+ICAJbF93YXJuKCJIY2kgZGV2ICU0LjR4IHJlbW92ZWQiLCBpbmRl
eCk7DQo+IC0JbF9xdWV1ZV9yZW1vdmUoY29udHJvbGxlcnMsIExfVUlOVF9UT19QVFIoaW5kZXgp
KTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgcmVhZF9pbmRleF9saXN0X2NiKHVpbnQ4X3Qg
c3RhdHVzLCB1aW50MTZfdCBsZW5ndGgsDQo+IEBAIC0xNTcsOSArMTQyLDYgQEAgc3RhdGljIHZv
aWQgcmVhZF9pbmRleF9saXN0X2NiKHVpbnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBsZW5ndGgsDQo+
ICANCj4gIHN0YXRpYyBib29sIG1lc2hfbWdtdF9pbml0KHZvaWQpDQo+ICB7DQo+IC0JaWYgKCFj
b250cm9sbGVycykNCj4gLQkJY29udHJvbGxlcnMgPSBsX3F1ZXVlX25ldygpOw0KPiAtDQo+ICAJ
aWYgKCFyZWFkX2luZm9fcmVncykNCj4gIAkJcmVhZF9pbmZvX3JlZ3MgPSBsX3F1ZXVlX25ldygp
Ow0KPiAgDQo=
