Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32815C5DF60
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BAB2085B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 17:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="OIkWHnIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfKGRXS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:23:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:19897 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGRXS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 12:23:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 09:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="230715341"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2019 09:23:17 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 09:23:17 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 09:23:17 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.55) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 7 Nov 2019 09:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq4psuB2mDv52zcd2+ExdZlgjfrqd2GCH4Yp6D+b0fza8BFivBMaHM41h1e++NOInJbTHjE9XalEfscGG1EqMVpEceTnPWjWTznpnW6iOn/TDVenxAY7UQWK3PNzyHlTUg7AjAJvNh5SXeUoPaWMUTQ8y/YAVvpr0cBmFA6gbQ7VCrLoMLvT+1K8Pp6+1SOMYLmRbt3g21ekGDO5HWtez75C41tmF5B0W0FDdYKGbQHeoZjoUBgxjKekfs7LSSuuHv7+T+cgEwr46O6ro/ehMgm51N2YxpJRonUhnzdHENkyXhjDn/MAM1bRf3ydqd0rwa3WYKDM7V2G+1jPpLkt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwOLwVGUlRNeH8RXxpAjk36sP2GSPl3GBGPQyOWHrc8=;
 b=DcTP/z6sSXvXGDLJxqgP4M4LNvw7GJfUSbMw7auU0Blq4TR//XtN2jqGwoniTYlmy+n4xDav92jpKzhSGh0M5xi6cP7D31LnymgIGSOe7ilY4cdj71VISQi9HKar7POE9IAqylsdNW1VWHEeWV/fEEZj4IuwPQzWcOOfwnvFQk9Js97j26uO1BkgnSRwA2uUgPVBdhtn1Kus45NqRU1fxtwKraJu4i/MyntfD5MyB+YRoyirKCs17HSqTjLdhQAvbzJEWsp+IpUnCWG5G+435nYJqZVmrmvsQFS4LPfGvAFsCjnOSmhViu7dQNwNB14OHDA1J0GCow0yM3Sv9CqHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwOLwVGUlRNeH8RXxpAjk36sP2GSPl3GBGPQyOWHrc8=;
 b=OIkWHnIjubA7dhim2UUp9hohPee1hNAm7NRi/pd6E5H9wp+doAaS9WiOwYU5sXkRsEMFt7gLXQz7dU27kvbbjsAiya6ljEbBncoCnQV/PfO17dkYaOnOMF+UCfUN6xpGRLbb5Zyt34toD5vMFaz3w+Nt/8GEzHUgOlwKoiD1rrw=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2071.namprd11.prod.outlook.com (10.172.77.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 17:23:14 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 17:23:14 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] unit: Fixed Mesh Crypto unit test build for LTO
Thread-Topic: [PATCH BlueZ] unit: Fixed Mesh Crypto unit test build for LTO
Thread-Index: AQHVlCyjV+9PlbdcTkWmHYNsagPBYqd/97kA
Date:   Thu, 7 Nov 2019 17:23:14 +0000
Message-ID: <10ecfd2a28f1e7a9573c5361e29d3e4aca0b552d.camel@intel.com>
References: <20191105225827.20207-1-brian.gix@intel.com>
In-Reply-To: <20191105225827.20207-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cec88c79-979f-44fd-a2f1-08d763a72c22
x-ms-traffictypediagnostic: CY4PR1101MB2071:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB207118486CB20F900A73EE22E1780@CY4PR1101MB2071.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(81156014)(7736002)(305945005)(256004)(36756003)(102836004)(6506007)(5660300002)(76176011)(8936002)(91956017)(186003)(81166006)(2351001)(6916009)(118296001)(86362001)(8676002)(66476007)(26005)(76116006)(66946007)(66446008)(64756008)(66556008)(14454004)(5640700003)(66066001)(107886003)(6512007)(25786009)(4326008)(71200400001)(2906002)(229853002)(71190400001)(6486002)(99286004)(478600001)(316002)(2501003)(6436002)(11346002)(2616005)(6116002)(3846002)(476003)(446003)(486006)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2071;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUKQwQERKhAcRffa0PxyHbUtE5alEFNmV9evc5+F9FsZkKVSx3FkhKR2BIMLz+qWn+us73UY5VOPyrkLO1AlKQ1Pct4FXoxMZFnA1VZmM+K43FPYRZhLKyT4Bnz+54bTxQqDUFYdbTeL4MyZIvTKbqq3LMQKzKhFU3wFCMcBd6a//pctoc8szMCl5qXlk1zOUpUWJiuc91GjnCR2WJXePa5UaLnSAX8EHIKDM/+FMgh9jRb7evXc0HTlXyo28qmpxdYCXRr+jD6uw3jn/NVWwJwcCo9D6sR+60rkssXwXoOeQrMsN60iITno79c692G36pwL74VHkNaAwRwsC816KA8H8qzAY3A3EcPTW7JbIlyWKQy1dlIzfaGtxRBb8suYqIfrVSoJ4GCZMverLcWNKWa8bTvbZtpm7Bu1668cqxV4Pv+eRyaQN4qFQZKoRPwJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <C718ABE2A9FEE64DA33A49AB24ED9878@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cec88c79-979f-44fd-a2f1-08d763a72c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:23:14.6580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kib/NcgTdao7eP5/i0WTS+spfFHtUCakkvCkFfCSihjH7B9ajwv43+8qOSojqF3cxHtOYxe46mV6HCCTZEdwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2071
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTEtMDUgYXQgMTQ6NTggLTA4MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gV2FzIGVycm9uZW91c2x5IGNvbXBpbGluZyBhbmQgbGlua2luZyBleHBsaWNpdCB1
bml0IHRlc3QgdmVyc2lvbnMgb2YgdGhlDQo+IEVMTCBzb3VyY2UgZGVwZW5kYW5jaWVzIHdoaWxl
IGFsc28gbGlua2luZyB3aXRoIHRoZSBsaWJyYXJ5IG1hZGUgZnJvbQ0KPiBzYW1lIHNvdXJjZXMu
IFRoaXMgY3JlYXRlZCBMaW5rIFRpbWUgT3B0aW1pemF0aW9uIChMVE8pIHByb2JsZW1zIHdoZW4N
Cj4gY2FsbGluZyBleGl0KCksIGFzIHRoZXJlIHdlcmUgdHdvIGNvcGllcyBvZiB0aGUgY29uc3Ry
dWN0b3JzIGFuZA0KPiBkZXN0cnVjdG9ycyBmcm9tIGVsbC9sb2cuYy4NCj4gLS0tDQo+ICBNYWtl
ZmlsZS5hbSB8IDYgKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUu
YW0NCj4gaW5kZXggODRjOTcxMmM5Li44ZDQxOWZiMzAgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxl
LmFtDQo+ICsrKyBiL01ha2VmaWxlLmFtDQo+IEBAIC01MjQsMTAgKzUyNCw4IEBAIGlmIE1FU0gN
Cj4gIHVuaXRfdGVzdHMgKz0gdW5pdC90ZXN0LW1lc2gtY3J5cHRvDQo+ICB1bml0X3Rlc3RfbWVz
aF9jcnlwdG9fQ1BQRkxBR1MgPSAkKGVsbF9jZmxhZ3MpDQo+ICB1bml0X3Rlc3RfbWVzaF9jcnlw
dG9fU09VUkNFUyA9IHVuaXQvdGVzdC1tZXNoLWNyeXB0by5jIFwNCj4gLQkJCQltZXNoL2NyeXB0
by5oIGVsbC9pbnRlcm5hbCBlbGwvZWxsLmggXA0KPiAtCQkJCSQoZWxsX3NvdXJjZXMpDQo+IC11
bml0X3Rlc3RfbWVzaF9jcnlwdG9fTERBREQgPSBzcmMvbGlic2hhcmVkLWVsbC5sYSBcDQo+IC0J
CQkkKGVsbF9sZGFkZCkNCj4gKwkJCQltZXNoL2NyeXB0by5oIGVsbC9pbnRlcm5hbCBlbGwvZWxs
LmgNCj4gK3VuaXRfdGVzdF9tZXNoX2NyeXB0b19MREFERCA9ICQoZWxsX2xkYWRkKQ0KPiAgZW5k
aWYNCj4gIA0KPiAgaWYgTUFJTlRBSU5FUl9NT0RFDQo=
