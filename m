Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE193C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883F824680
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="B+XkTT7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgANOkz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:40:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:7636 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANOky (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:40:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:40:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="248063854"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2020 06:40:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:40:53 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 06:40:53 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 06:40:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:40:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0te3evbIfoYR37v2yYPfwVd/+7OIzBEsrntFjfz2kwYxTU13y+5whET8SKtWaKNCKe9P2D+Ylgummscg1grW7dalhKd43+H5kipJW4YcHodGNykFY2EF86TeT6UhaWA7+4GESsFRsc3JiLZD6X7CB3B22OMByojKUlB7OV3XBAZw9g1izhZaBkmpoHizrsI82v/Xj3k2G+kvFuygbP4nGcAa32tYz3uxss+a74h7cLGTmWBT3H/lymWEuEAD7lI7dqWUaf7ZEUwdDbduofV66sBTQtyosHxiL0eShIc2U8+UQ+tkq8WT993xq0YNQPeQ9i9Em3VZYMO+HJFHhry8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0/WFXjK5vN5mvAncWsYwJ0UnDT+UNrpbQxojatGV0w=;
 b=NoN6uN2elicApVbsiOv+2n8EXksldP3+OiAayub2YAQOTjk5de2XZG2r1ROFpUMBnIxL4s6pR5PwW59XLHeLWwid0t9iBzE8TGXchUMuqWOSD6cYLiS45sxOeWAZksBxvfTYv/S0hA2FM3tzDSADerj0+4o35Oa8B7LbADWygZrOcnttUHiDT7kC4WUZ93DyXJ7Ju5IeILwZQFckc6XiXw/bntTtjaEncNK9KF9e+Sl1PxQHuZJjypu5CBc1JrQlOBOiQnT8so5M5RNdj/tNzpxhgcCzYTQTLc2jdrOzeyb6K06R1lX3FDVidYtsXX/mIpsiJTlzxR5uVuhwfMNIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0/WFXjK5vN5mvAncWsYwJ0UnDT+UNrpbQxojatGV0w=;
 b=B+XkTT7/j66MrKobQHSlunm1uvj8iW7t0amzJSJ6gFmru9PMiIbgCCRW4wIkcrranWN/VJTLYxNgaSaAxQN7+s4Moykj2Lt7gotpDYs3KbMlfaUAd1ubyR43i1ZjSKlzo7DYLaSRPiJcCsljtUhTiX4i54jWrM2qOo+hR83l7Cs=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:40:42 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:40:42 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix exiting IV_UPD_STATE when receiving first
 SNB
Thread-Topic: [PATCH BlueZ] mesh: Fix exiting IV_UPD_STATE when receiving
 first SNB
Thread-Index: AQHVxuym1xoubmghpE2UgYFJS/5lyKfqQ1aA
Date:   Tue, 14 Jan 2020 14:40:42 +0000
Message-ID: <4d564a2af113af28b39b947900c50e8a8dd11d9b.camel@intel.com>
References: <20200109125859.5389-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200109125859.5389-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ff1841a-f91f-4ce8-f895-08d798ffbb56
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-microsoft-antispam-prvs: <MWHPR11MB1805100123AAAE0CA858485BE1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(6506007)(478600001)(6486002)(36756003)(91956017)(66476007)(8936002)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(316002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HimlWDu2R294ReMX1KKXYtENxlQbKpq4ZpJDvzPSfPK77KbLD5e0IyKWwpvv6xEWBJ4sHUgNnJ6PHirFJaGak22T3yPdfiX72wE1eZ2ANNujqAO8X9635iQ51SnJ8hlynTkNa7ilbLLAZmFXFdHxTPm2u7TWwRDkr9VGZA5d6cHQnil+DX3s2lfvMnxWIUn2LW6gOXSCmCeQGwtUNsGXdqEQ8xu5d4qPpMFxYvkQDbyiKZxn2QT0N9TbCc51WO9hmU221WpYrqoJV6//oGHpvECZs42PMgFDveyYKg3MZW/F8SCwhyiGjRtqDtgj8x0/BTAk4fkjinVFkKBjBmWVaWXr1FShZTexa9SuRh88fny4nNKkSMNngQ7PSluzUWp6C8Ed1Kktz3Zxd3+bDdG61VBGufF6vpl9M67+kVmgF5V3VBls/wvkAlppGuQpxKnF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC32B697061CF44985AF661221EAEF40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff1841a-f91f-4ce8-f895-08d798ffbb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:40:42.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3UZMKJMt6PCmUpY1aqhapPpblHJkm/yy9+xd+iQIpdxzRQoZ2SHpTa1QmmXtmiuX3/6L4eB588OrSGcgnHJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDEzOjU4ICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gRmlyc3QgdmFsaWQgU05CIHJlY2VpdmVkIGZyb20gdGhlIG5l
dHdvcmsgc2hvdWxkIGNhdXNlIHRoZSBub2RlIHRvDQo+IHN3aXRjaCBpbnRvIElWX1VQRF9OT1JN
QUwgc3RhdGUuDQo+IA0KPiBPdGhlcndpc2UsIGl0IHdpbGwgbmV2ZXIgdHJ5IHRvIGVudGVyIElW
IFVwZGF0ZSBwcm9jZWR1cmUgd2hlbiBzZXF1ZW5jZQ0KPiBudW1iZXIgYXBwcm9hY2hlcyB0aGUg
SVZfVVBEQVRFX1NFUV9UUklHR0VSLCBiZWNhdXNlIHRoYXQncyBvbmx5IGFsbG93ZWQNCj4gaW4g
SVZfVVBEX05PUk1BTC4NCj4gLS0tDQo+ICBtZXNoL25ldC5jIHwgMTQgKysrKysrKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IDIwZTlhMWU4
MS4uYmQ4ODI2YjU4IDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0
LmMNCj4gQEAgLTI2ODgsMTEgKzI2ODgsMTcgQEAgc3RhdGljIHZvaWQgcHJvY2Vzc19iZWFjb24o
dm9pZCAqbmV0X3B0ciwgdm9pZCAqdXNlcl9kYXRhKQ0KPiAgCS8qIFdlIGhhdmUgb2ZmaWNpYWxs
eSAqc2VlbiogdGhpcyBiZWFjb24gbm93ICovDQo+ICAJYmVhY29uX2RhdGEtPnByb2Nlc3NlZCA9
IHRydWU7DQo+ICANCj4gLQlpZiAoaXZpID09IG5ldC0+aXZfaW5kZXggJiYgaXZ1ID09IG5ldC0+
aXZfdXBkYXRlICYmIGtyID09IGxvY2FsX2tyKQ0KPiAtCQlyZXR1cm47DQo+ICsJLyoNCj4gKwkg
KiBJZ25vcmUgdGhlIGJlYWNvbiBpZiBpdCBkb2Vzbid0IGNoYW5nZSBhbnl0aGluZywgdW5sZXNz
IHdlJ3JlDQo+ICsJICogZG9pbmcgSVYgUmVjb3ZlcnkNCj4gKwkgKi8NCj4gKwlpZiAobmV0LT5p
dl91cGRfc3RhdGUgPT0gSVZfVVBEX0lOSVQgfHwNCj4gKwkJCQlpdmkgIT0gbmV0LT5pdl9pbmRl
eCB8fCBpdnUgIT0gbmV0LT5pdl91cGRhdGUpDQo+ICsJCXVwZGF0ZV9pdl9pdnVfc3RhdGUobmV0
LCBpdmksIGl2dSk7DQo+ICsNCj4gKwlpZiAoa3IgIT0gbG9jYWxfa3IpDQo+ICsJCXVwZGF0ZV9r
cl9zdGF0ZShzdWJuZXQsIGtyLCBiZWFjb25fZGF0YS0+a2V5X2lkKTsNCj4gIA0KPiAtCXVwZGF0
ZV9pdl9pdnVfc3RhdGUobmV0LCBpdmksIGl2dSk7DQo+IC0JdXBkYXRlX2tyX3N0YXRlKHN1Ym5l
dCwga3IsIGJlYWNvbl9kYXRhLT5rZXlfaWQpOw0KPiAgCW5ldF9rZXlfYmVhY29uX3JlZnJlc2go
YmVhY29uX2RhdGEtPmtleV9pZCwgbmV0LT5pdl9pbmRleCwNCj4gIAkJISEoc3VibmV0LT5rcl9w
aGFzZSA9PSBLRVlfUkVGUkVTSF9QSEFTRV9UV08pLCBuZXQtPml2X3VwZGF0ZSk7DQo+ICB9DQo=
