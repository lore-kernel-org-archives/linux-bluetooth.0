Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A496CC432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D542E206DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Pre9EJ6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKMRQe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:16:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:61778 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKMRQd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 12:16:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 09:16:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="287941076"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2019 09:16:32 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 Nov 2019 09:16:31 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 Nov 2019 09:16:31 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 13 Nov 2019 09:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCEhD66D6JzJeHZvhp0bipDThX5VYAg9dkE+uzinJ/oTpLPlPskY0hgH0+01B7yedEfNPNoHdH5pErCD5SyZzkFafbRTJoa6pYj0XKDscZ0uAJ0xEvo556lWEoxbKbC20j0uu0mdd7bpPQ9UfPEgH00FyPVwVl0/duPlp8rzDmXo59+Jp5Ygl2igWcA/8g75UV2X0dt/iy3pvkhY8NWxOCEvTF+oJIo2Y4TW/M0l8HMLRTSfrkss/xlcdngrM0Wd9fjGEOQV43RkSMlVKWsjN4toDesCrD4xba/qVEdes2UJVF1oDFuq9833fH8Jo9xFgOm1GcbtoDaqoIkbca0XIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL5wHlS64+vliuFbZgo/8sPgV7mCSqseEwwHP3FpMAw=;
 b=lo1koK5yEPIoQTJknLeCcB3eKCZ6CTg4OIOMIssMuxLKOqRQZQf+eKqwQTk5yZCdZlnIAwgt59NhFW/58rFSJxxKV6zK40gfLQw0kjZcDJWVttyVE6z+ttF1bKO2IX6fIN7J4upLJsXVpRjugn0apP42TfVq1axdABzjELJsXHnRrYZ02HIJfgsAIVSb2H5KnvaAKtzAUFl8rOjHmRtISa8TSywx63DaimCRRaqRVRHIuFQcFATx/lrMcsx3QhjP5L6smYc7MlELIZ9XlF0OgIZW4eABOsvN5ZBInZcUgg3RyGFN9DiAE5UHeluXdCRSWtIsIrmdYva/2oEvqfvkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL5wHlS64+vliuFbZgo/8sPgV7mCSqseEwwHP3FpMAw=;
 b=Pre9EJ6wZZtA5vFg+p1JfCc6ndQwCa87SukRSyiktcc0TpcGxbXu3DXWr/0JuGZf/Sx4qJnI2UV+7AnhAOGS1y234s0VcaS9Ap9nGMI2Xbg1sA/yDXthhtxBzmyfBMr4fZSA0dM/FD1qUPafDbADI44syfjsAiFCxIRvkYeHNHs=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2087.namprd11.prod.outlook.com (10.174.54.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 17:16:30 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 17:16:30 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Add missing property interface to node
 objects
Thread-Topic: [PATCH BlueZ] mesh: Add missing property interface to node
 objects
Thread-Index: AQHVmUYeLfADO8tHK0+AUgusz7BzsaeJWaCA
Date:   Wed, 13 Nov 2019 17:16:29 +0000
Message-ID: <7390c6e30fcd8c01205fb29bb3e725b56b5dce4a.camel@intel.com>
References: <20191112104327.13109-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20191112104327.13109-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abf2fc43-6517-4846-ff8c-08d7685d3964
x-ms-traffictypediagnostic: CY4PR1101MB2087:
x-microsoft-antispam-prvs: <CY4PR1101MB2087E1F783711C3C22EA818AE1760@CY4PR1101MB2087.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(7736002)(316002)(76116006)(91956017)(229853002)(110136005)(99286004)(71190400001)(4744005)(71200400001)(8676002)(118296001)(305945005)(6486002)(478600001)(66066001)(81166006)(81156014)(6436002)(6506007)(486006)(4001150100001)(3846002)(76176011)(2501003)(5660300002)(36756003)(8936002)(446003)(11346002)(102836004)(476003)(256004)(2906002)(25786009)(66946007)(6512007)(66446008)(66556008)(86362001)(14454004)(6246003)(26005)(6116002)(66476007)(186003)(2616005)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2087;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fO3QSMrDDiJc9LNeJQ3rGo3UD0Vrpp2Sq2f7S6PVAarCgTFDDuMnmx9Db1nGO8KAQKrJ4N7hg1iE9NxlDZ1KGgGK8sYRzCewmcfeBI/gWyYNZnuRiOlYnMbZW7jHuqrrvgwj0+Ps3pxQdVM8gzuhoJu2+U+B0/7UfZSBlRTXkvLaAULOpJvsSQZsX8iJpzkFlrXd68NZPQnOaJ3E09ZvAqEMEsJCRInpJi2TLsRywg//s/ze9Dm1g4KtBTQJaG61lr3PvnEl3cXEkCzGhHpZY2t2dXGu2xET8UI2Fn55toO7c57O9Mh76GbcNQlGx9IPEJBk21NGwhXkxxWO3Q/RaDIk+YRlyDhfV5kcwfCukiNJ8ATPN9VcfGLB168GyIrUtn8LMtbpsffPr3BjA7RuTWeZkuioTKfNy0Y826w0e6OphafBbc2UViIlaCV9O074
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E59562FA932D14FADBFC86B68B73EB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: abf2fc43-6517-4846-ff8c-08d7685d3964
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:16:29.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yB4ZDNpU+A4qhMeG5clbM46vR/o1cCc0u+X9EquthCTQyaN+1wsd2Rr9iSFHw+mEM28AD7jG3hZoMHmnbpuGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2087
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIHN0eWxlLWd1aWRlIGNvcnJlY3Rpb25zOg0KUmVkdWNlIG1heCBsaW5lIGxl
bmd0aCB0byA8ODAgY2hhcmFjdG9ycw0KDQpPbiBUdWUsIDIwMTktMTEtMTIgYXQgMTE6NDMgKzAx
MDAsIE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiAtLS0NCj4gIG1lc2gvbm9kZS5j
IHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21lc2gvbm9kZS5jIGIvbWVzaC9ub2RlLmMNCj4gaW5kZXggZTIzZjMyZGQx
Li5kMmRmZjNhNTEgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbm9kZS5jDQo+ICsrKyBiL21lc2gvbm9k
ZS5jDQo+IEBAIC0yOTQsNiArMjk0LDEwIEBAIHN0YXRpYyB2b2lkIGZyZWVfbm9kZV9kYnVzX3Jl
c291cmNlcyhzdHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiAgDQo+ICAJCWxfZGJ1c19vYmplY3Rf
cmVtb3ZlX2ludGVyZmFjZShkYnVzX2dldF9idXMoKSwgbm9kZS0+b2JqX3BhdGgsDQo+ICAJCQkJ
CQlNRVNIX01BTkFHRU1FTlRfSU5URVJGQUNFKTsNCj4gKw0KPiArCQlsX2RidXNfb2JqZWN0X3Jl
bW92ZV9pbnRlcmZhY2UoZGJ1c19nZXRfYnVzKCksIG5vZGUtPm9ial9wYXRoLA0KPiArCQkJCQkJ
CUxfREJVU19JTlRFUkZBQ0VfUFJPUEVSVElFUyk7DQo+ICsNCj4gIAkJbF9mcmVlKG5vZGUtPm9i
al9wYXRoKTsNCj4gIAkJbm9kZS0+b2JqX3BhdGggPSBOVUxMOw0KPiAgCX0NCj4gQEAgLTExNTYs
NiArMTE2MCwxMCBAQCBzdGF0aWMgYm9vbCByZWdpc3Rlcl9ub2RlX29iamVjdChzdHJ1Y3QgbWVz
aF9ub2RlICpub2RlKQ0KPiAgCQkJCQlNRVNIX01BTkFHRU1FTlRfSU5URVJGQUNFLCBub2RlKSkN
Cj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+ICsJaWYgKCFsX2RidXNfb2JqZWN0X2FkZF9pbnRl
cmZhY2UoZGJ1c19nZXRfYnVzKCksIG5vZGUtPm9ial9wYXRoLA0KPiArCQkJCQlMX0RCVVNfSU5U
RVJGQUNFX1BST1BFUlRJRVMsIE5VTEwpKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gIAly
ZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0K
