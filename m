Return-Path: <SRS0=6lUD=BM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C300CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 07:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9390A2083B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 07:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="T2Gn4sKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHBHFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Aug 2020 03:05:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:15371 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgHBHFN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Aug 2020 03:05:13 -0400
IronPort-SDR: iO1FfOgDL9f/jrMer17cgYjzWC0EJiFtqyi8wh+F+Syjq/ZsZI56wPc4jMa+CRW0htJqCpnQjO
 FAqTjkA+njJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="216411277"
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="216411277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 00:04:42 -0700
IronPort-SDR: QMeeBUrFb/tG5B5P9zojMg7lKxpix4SncDpnpD2O8QIp27YDZ9Zmyet6FLzy2QqtlBPUqqej2C
 ud3Rv8nwfugg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="305487284"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2020 00:04:42 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 2 Aug 2020 00:04:41 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 2 Aug 2020 00:04:41 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 2 Aug 2020 00:04:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 2 Aug 2020 00:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V91+VeLM/Pp3rqFbG//fmid5lF8S6cb+wkD0XqL39oqUAwVyDGcQYY4gPE+AQJY9u4BRNbR45NxXjPOXYu59u/nN5WFaOUxcHNTFJhy7mti4KVxb4u14IGUp3utqRXfEMZIzO0D2MDJ47hyxNRqxBug73vVBKKPhQl1IGs9Z/26KGJR8Hz/adkl46MWcD8zGvNItBf2/2t1IhMnuK/3abGWGSPmPoDz5/jBl0yB6LQITbO7zCFOM8t/NprgrRUEdm+SdKXNlblDas0eCxjQZq3g8kHFmbQkpz5vd9ZBCWselg6PXlqb3ASDjFg0H6aXHLps9brR2qrKxlfZyC9o8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww8iXmQdvJzN7Js9ch3KQMdFCOdkeGPxQofkwJqY0dE=;
 b=idEj6CDEcZ0Ard8z3qmIKzEki9f9XTNq520hLsmJXXVbmHfGU3FywBPfJ9NeLelu35DCyn+XAlT5bOFXHPosbypGMxZBu7WES+hQ8uBrAJ7OkGiipUIHWVxDRVcey08NaUSNNSxPz130XeVefTHNP/chM1n+03a68O3z8ZAQY+Quf8W5DkbYFkRY5c+Agw9VEGMQ5UIeDTbQYJy9vPxxfkLGpaNH7WtwajHNHvEkbyHkXPTTelE4uqKgQ8/VwN1O94mIIDyER0M4naQgBniUg4b7KJD2quYb2NzvI0VqtdDOtMy3q3HeaMBa4Nh1jqHWSOpdlImIkFF6Rw4fXgiX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww8iXmQdvJzN7Js9ch3KQMdFCOdkeGPxQofkwJqY0dE=;
 b=T2Gn4sKhUeY+5TyJb67IcUtuAwMII2fu6Jylt04uc9ju3D9Ic1QUGSi4zI01qAbDDIib4CkF8rPpc/X+J3rud8L4Pf2688GM1CpQRFSEcHTN38y0PsbQ3hJQFFWbK2POfG9YY4ydXMH6OGdscNb/sen3q2YaqCKxtSJsf3oYj6w=
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MWHPR11MB1950.namprd11.prod.outlook.com (2603:10b6:300:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Sun, 2 Aug
 2020 07:04:39 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::3591:c4a5:ffe2:4b82]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::3591:c4a5:ffe2:4b82%7]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 07:04:39 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/1] mesh: Add strings for SIG Model IDs.
Thread-Topic: [PATCH BlueZ 1/1] mesh: Add strings for SIG Model IDs.
Thread-Index: AQHWZ7w4yOcgtCQ2w0eDcOM+ardaGakkZuYA
Date:   Sun, 2 Aug 2020 07:04:39 +0000
Message-ID: <b20b3a4a31a6393a1f1c035823fa20b7a778c1b2.camel@intel.com>
References: <d3547f5d-5dae-38fb-41c6-33454e8b1356@mnmoran.org>
In-Reply-To: <d3547f5d-5dae-38fb-41c6-33454e8b1356@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4 (3.36.4-1.fc32) 
authentication-results: mnmoran.org; dkim=none (message not signed)
 header.d=none;mnmoran.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8b47a6-dd01-4b97-5cf2-08d836b252d7
x-ms-traffictypediagnostic: MWHPR11MB1950:
x-microsoft-antispam-prvs: <MWHPR11MB19501194A528A6ED69A1CB6CFB4C0@MWHPR11MB1950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:98;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDawSQzwQl33dQvw3ZXE1lXcE0kJ/lRZl5z0lMB88S4MPHl+FjjFq1IIEICQuulDdzn9fCczezuEEF7iwlGJDR+rHsx9w4EB4fMRsRh6Na3lULgk6B033ppJ+ORO7HldEVlRTZ6NeAQSiLigABBHDqHcpmJlpblmYdw6uo+MUyqjiLcj1KO11idYDozRwIlCYUIjbaW+Qsfougl+xj8wCQxXFHPVukr2Jqjh7U6xon/0jqFup9p5zF5o2SgdOEDBHwRWnICf9VlKi1wkfHbQsloew+N4DLvpYT2av0UJGizKxRT2TVtDpg63Ffqz9jfwsZFQD+E0N76Ei0tT848lzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(83380400001)(8936002)(71200400001)(316002)(6486002)(86362001)(8676002)(36756003)(110136005)(478600001)(2616005)(2906002)(91956017)(6512007)(5660300002)(6506007)(66476007)(66556008)(66446008)(186003)(64756008)(66946007)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zr+D3/pJ/IXUzXfiYBuFDXlVxdXp2CP9AXRqujPlcSAl34wBpVds2VbcDCtA4o/VRGPfS3UaVM0bB+G3uwOlZ2VdsyuWTQMCHzcH7oa1ULznxCMKIHgALmcBiSyfofEemEQKis5i+CZkUYOw2SCzP0DH700RuZshJFc56N/oe7Zt6migQfpQbedxzX1xBg0cjywpObC+idM9MAh1wLrPJQ7bX4p51q0AoL7SJmpLxB2qoethSZogks+MwdPYuStHCFj+kjbK4PFXHgKuJz/Bh/Z3IRr5ytVdef76ESMeUhwMujwlJ39OeMuHefC5WEzd6iT/xlyY9npXqccc5tOacvY+U33Uu1GELSCKwPK9RF0Cb/y8MjmdeJcLYDhPXo3q7iiFGctN9PNAZKpNmw0bMbcTXdo+BjtIGu7OAd3+7HzYZ9A8Q3+IOrnFAFI9Oh5LiTrYVTAvpKzQTZTQU6G+mrSacibDiu8pjTO2HFtfJPo6hCvIlXXG5J6wSKzwtKkHAuHBbbX/LFuUVsIvZf0LKKqhVEIcSwt07zjNe76eIn1QzUsyp6wqQN0mqCv0wL5CjfJS3DO3imeVr/YfeD8w5pXfXoDH3I97nsmU/r8XkR/saJehRe6N20o9rAwl0B+3T9DYCFATxgH6VWeDYXKuUA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA7C6EA2AD1197409198A1C5047DA50F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8b47a6-dd01-4b97-5cf2-08d836b252d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2020 07:04:39.4441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMGD8o420FuI/slLDrHKmREKcr3wiH2Md3pLvvb8/AHB33PLEfPIWNOc4q1DGv/ryN9uWshDcPPPGVIM8FcMjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1950
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFlbCwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guIEZldyBzdHlsZSB0d2Vha3MuDQoN
CkZpcnN0LCBubyBwZXJpb2QgYXQgdGhlIGVuZCBvZiBjb21taXQgdGl0bGUuDQoNCk9uIFNhdCwg
MjAyMC0wOC0wMSBhdCAwMDoyOCAtMDQwMCwgTWljaGFlbCBOLiBNb3JhbiB3cm90ZToNCj4gVGhp
cyBwYXRjaCBhZGRzIGEgdXRpbGl0eSBmdW5jdGlvbiByZXR1cm5pbmcgYSBzdHJpbmcNCj4gZGVz
Y3JpYmluZyBhIFNJRyBNb2RlbCBJRCBhbmQgdXNlcyB0aGlzIGZ1bmN0aW9uDQo+IGZvciBpbiB0
aGUgbWVzaC1jZmdjbGllbnQgaW4gdGhlIGxpc3Qtbm9kZXMgY29tbWFuZA0KPiBvdXRwdXQgYW5k
IGluIHRoZSBkaXNwbGF5IG9mIHJlY2VpdmVkIGNvbXBvc2l0aW9uIGRhdGEuDQo+IA0KPiAtLS0N
Cj4gICB0b29scy9tZXNoL2NmZ2NsaS5jIHwgIDMgKystDQo+ICAgdG9vbHMvbWVzaC9yZW1vdGUu
YyB8ICA1ICsrLS0NCj4gICB0b29scy9tZXNoL3V0aWwuYyAgIHwgNjQgDQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHRvb2xzL21lc2gvdXRpbC5o
ICAgfCAgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMgYi90b29scy9t
ZXNoL2NmZ2NsaS5jDQo+IGluZGV4IGUzNmM4ZGNhNS4uZjZmNDY1YzZjIDEwMDY0NA0KPiAtLS0g
YS90b29scy9tZXNoL2NmZ2NsaS5jDQo+ICsrKyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gQEAg
LTI2Myw3ICsyNjMsOCBAQCBzdGF0aWMgdWludDMyX3QgcHJpbnRfbW9kX2lkKHVpbnQ4X3QgDQo+
ICpkYXRhLCBib29sIHZlbmRvciwgY29uc3QgY2hhciAqb2Zmc2V0KQ0KPiAgICAJaWYgKCF2ZW5k
b3IpIHsNCj4gICAJCW1vZF9pZCA9IGdldF9sZTE2KGRhdGEpOw0KPiAtCQlidF9zaGVsbF9wcmlu
dGYoIiVzTW9kZWwgSURcdCU0LjR4XG4iLCBvZmZzZXQsIG1vZF9pZCk7DQo+ICsJCWJ0X3NoZWxs
X3ByaW50ZigiJXNNb2RlbCBJRFx0JTQuNHggXCIlc1wiXG4iLA0KPiArCQkJb2Zmc2V0LCBtb2Rf
aWQsc2lnX21vZGVsX3N0cmluZyhtb2RfaWQpKTsNCg0KU3BhY2UgYmVmb3JlIHNpZ19tb2RlbF9z
dHJpbmcuDQpBbHNvLCBtYWtlIHN1cmUgdGhhdCB0aGUgIHdyYXBwZWQgbGluZQ0KIm9mZnNldCxt
b2RfaWQsc2lnX21vZGVsX3N0cmluZyhtb2RfaWQpKSIgaXMNCnJpZ2h0IGFkanVzdGVkLCBpLmUu
LCBhY2NvcmRpbmcgdG8gQmx1ZVogY29kaW5nIHN0eWxlIChhcyBvdXRsaW5lZCBpbg0KZG9jL2Nv
ZGluZy1zdHlsZS50eHQpOg0KIlRoZSByZWZlcnJlZCBzdHlsZSBmb3IgbGluZSB3cmFwcGluZyBp
cyB0byBpbmRlbnQgYXMgZmFyIGFzIHBvc3NpYmxlDQp0byB0aGUgcmlnaHQgd2l0aG91dCBoaXR0
aW5nIHRoZSA4MCBjb2x1bW5zIGxpbWl0LiINCg0KPiAgIAkJbW9kX2lkID0gVkVORE9SX0lEX01B
U0sgfCBtb2RfaWQ7DQo+ICAgCX0gZWxzZSB7DQo+ICAgCQltb2RfaWQgPSBnZXRfbGUxNihkYXRh
ICsgMik7DQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL3JlbW90ZS5jIGIvdG9vbHMvbWVzaC9y
ZW1vdGUuYw0KPiBpbmRleCBjNzRmMGJlYzEuLmJhM2U1MGQzZiAxMDA2NDQNCj4gLS0tIGEvdG9v
bHMvbWVzaC9yZW1vdGUuYw0KPiArKysgYi90b29scy9tZXNoL3JlbW90ZS5jDQo+IEBAIC0zMCw2
ICszMCw3IEBADQo+ICAgI2luY2x1ZGUgInRvb2xzL21lc2gva2V5cy5oIg0KPiAgICNpbmNsdWRl
ICJ0b29scy9tZXNoL21lc2gtZGIuaCINCj4gICAjaW5jbHVkZSAidG9vbHMvbWVzaC9yZW1vdGUu
aCINCj4gKyNpbmNsdWRlICJ0b29scy9tZXNoL3V0aWwuaCINCg0KTGluZSBicmVhayBiZXR3ZWVu
IGluY2x1ZGVzICYgZGVmaW5lcw0KDQo+ICAgICNkZWZpbmUgYWJzX2RpZmYoYSwgYikgKChhKSA+
IChiKSA/IChhKSAtIChiKSA6IChiKSAtIChhKSkNCj4gICBAQCAtMjkzLDggKzI5NCw4IEBAIHN0
YXRpYyB2b2lkIHByaW50X21vZGVsKHZvaWQgKm1vZGVsLCANCj4gdm9pZCAqdXNlcl9kYXRhKQ0K
PiAgICAJaWYgKG1vZF9pZCA+PSBWRU5ET1JfSURfTUFTSykgew0KPiAgIAkJbW9kX2lkICY9IH5W
RU5ET1JfSURfTUFTSzsNCj4gLQkJYnRfc2hlbGxfcHJpbnRmKCJcdFx0XHQiIENPTE9SX0dSRUVO
ICJTSUcgbW9kZWw6ICU0LjR4XG4iDQo+IC0JCQkJCQkJQ09MT1JfT0ZGLCBtb2RfaWQpOw0KPiAr
CQlidF9zaGVsbF9wcmludGYoIlx0XHRcdCIgQ09MT1JfR1JFRU4gIlNJRyBtb2RlbDogJTQuNHgg
DQo+IFwiJXNcIlxuIg0KPiArCQkJCQkJCUNPTE9SX09GRiwgbW9kX2lkLHNpZ19tb2RlbF9zdHJp
bmcobW9kX2lkKSk7DQoNClNwYWNlIGJlZm9yZSBzaWdfbW9kZWxfc3RyaW5nLg0KQWxzbywgbWFr
ZSBzdXJlIHRoYXQgdGhlICB3cmFwcGVkIGxpbmUNCiJvZmZzZXQsbW9kX2lkLHNpZ19tb2RlbF9z
dHJpbmcobW9kX2lkKSkiIGlzDQpyaWdodCBhZGp1c3RlZCwgaS5lLiwgYWNjb3JkaW5nIHRvIEJs
dWVaIGNvZGluZyBzdHlsZSAoYXMgb3V0bGluZWQgaW4NCmRvYy9jb2Rpbmctc3R5bGUudHh0KToN
CiJUaGUgcmVmZXJyZWQgc3R5bGUgZm9yIGxpbmUgd3JhcHBpbmcgaXMgdG8gaW5kZW50IGFzIGZh
ciBhcyBwb3NzaWJsZQ0KdG8gdGhlIHJpZ2h0IHdpdGhvdXQgaGl0dGluZyB0aGUgODAgY29sdW1u
cyBsaW1pdC4iDQoNCj4gICAJCXJldHVybjsNCj4gICAJfQ0KPiAgIGRpZmYgLS1naXQgYS90b29s
cy9tZXNoL3V0aWwuYyBiL3Rvb2xzL21lc2gvdXRpbC5jDQo+IGluZGV4IDcxNzZjYzU2Mi4uNDYw
M2E2MjYxIDEwMDY0NA0KPiAtLS0gYS90b29scy9tZXNoL3V0aWwuYw0KPiArKysgYi90b29scy9t
ZXNoL3V0aWwuYw0KPiBAQCAtMTM4LDMgKzEzOCw2NyBAQCB2b2lkIHN3YXBfdTI1Nl9ieXRlcyh1
aW50OF90ICp1MjU2KQ0KPiAgIAkJdTI1NltpXSBePSB1MjU2WzMxIC0gaV07DQo+ICAgCX0NCj4g
ICB9DQo+ICsNCj4gK2NvbnN0IGNoYXIqCXNpZ19tb2RlbF9zdHJpbmcodWludDE2X3Qgc2lnX21v
ZGVsX2lkKQ0KDQoiY2hhcioJc2lnIiAtPiAiY2hhciAqc2lnIg0KDQo+ICt7DQo+ICsJc3dpdGNo
IChzaWdfbW9kZWxfaWQpIHsNCj4gKwljYXNlIDB4MDAwMDogcmV0dXJuICJDb25maWd1cmF0aW9u
IFNlcnZlciI7DQo+ICsJY2FzZSAweDAwMDE6IHJldHVybiAiQ29uZmlndXJhdGlvbiBDbGllbnQi
Ow0KPiArCWNhc2UgMHgwMDAyOiByZXR1cm4gIkhlYWx0aCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgw
MDAzOiByZXR1cm4gIkhlYWx0aCBDbGllbnQiOw0KPiArCWNhc2UgMHgxMDAwOiByZXR1cm4gIkdl
bmVyaWMgT25PZmYgU2VydmVyIjsNCj4gKwljYXNlIDB4MTAwMTogcmV0dXJuICJHZW5lcmljIE9u
T2ZmIENsaWVudCI7DQo+ICsJY2FzZSAweDEwMDI6IHJldHVybiAiR2VuZXJpYyBMZXZlbCBTZXJ2
ZXIiOw0KPiArCWNhc2UgMHgxMDAzOiByZXR1cm4gIkdlbmVyaWMgTGV2ZWwgQ2xpZW50IjsNCj4g
KwljYXNlIDB4MTAwNDogcmV0dXJuICJHZW5lcmljIERlZmF1bHQgVHJhbnNpdGlvbiBUaW1lIFNl
cnZlciI7DQo+ICsJY2FzZSAweDEwMDU6IHJldHVybiAiR2VuZXJpYyBEZWZhdWx0IFRyYW5zaXRp
b24gVGltZSBDbGllbnQiOw0KPiArCWNhc2UgMHgxMDA2OiByZXR1cm4gIkdlbmVyaWMgUG93ZXIg
T25PZmYgU2VydmVyIjsNCj4gKwljYXNlIDB4MTAwNzogcmV0dXJuICJHZW5lcmljIFBvd2VyIE9u
T2ZmIFNldHVwIFNlcnZlciI7DQo+ICsJY2FzZSAweDEwMDg6IHJldHVybiAiR2VuZXJpYyBQb3dl
ciBPbk9mZiBDbGllbnQiOw0KPiArCWNhc2UgMHgxMDA5OiByZXR1cm4gIkdlbmVyaWMgUG93ZXIg
TGV2ZWwgU2VydmVyIjsNCj4gKwljYXNlIDB4MTAwQTogcmV0dXJuICJHZW5lcmljIFBvd2VyIExl
dmVsIFNldHVwIFNlcnZlciI7DQo+ICsJY2FzZSAweDEwMEI6IHJldHVybiAiR2VuZXJpYyBQb3dl
ciBMZXZlbCBDbGllbnQiOw0KPiArCWNhc2UgMHgxMDBDOiByZXR1cm4gIkdlbmVyaWMgQmF0dGVy
eSBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMDBEOiByZXR1cm4gIkdlbmVyaWMgQmF0dGVyeSBDbGll
bnQiOw0KPiArCWNhc2UgMHgxMDBFOiByZXR1cm4gIkdlbmVyaWMgTG9jYXRpb24gU2VydmVyIjsN
Cj4gKwljYXNlIDB4MTAwRjogcmV0dXJuICJHZW5lcmljIExvY2F0aW9uIFNldHVwIFNlcnZlciI7
DQo+ICsJY2FzZSAweDEwMTA6IHJldHVybiAiR2VuZXJpYyBMb2NhdGlvbiBDbGllbnQiOw0KPiAr
CWNhc2UgMHgxMDExOiByZXR1cm4gIkdlbmVyaWMgQWRtaW4gUHJvcGVydHkgU2VydmVyIjsNCj4g
KwljYXNlIDB4MTAxMjogcmV0dXJuICJHZW5lcmljIE1hbnVmYWN0dXJlciBQcm9wZXJ0eSBTZXJ2
ZXIiOw0KPiArCWNhc2UgMHgxMDEzOiByZXR1cm4gIkdlbmVyaWMgVXNlciBQcm9wZXJ0eSBTZXJ2
ZXIiOw0KPiArCWNhc2UgMHgxMDE0OiByZXR1cm4gIkdlbmVyaWMgQ2xpZW50IFByb3BlcnR5IFNl
cnZlciI7DQo+ICsJY2FzZSAweDEwMTU6IHJldHVybiAiR2VuZXJpYyBQcm9wZXJ0eSBDbGllbnQi
Ow0KPiArCWNhc2UgMHgxMTAwOiByZXR1cm4gIlNlbnNvciBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgx
MTAxOiByZXR1cm4gIlNlbnNvciBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMTAyOiByZXR1
cm4gIlNlbnNvciBDbGllbnQiOw0KPiArCWNhc2UgMHgxMjAwOiByZXR1cm4gIlRpbWUgU2VydmVy
IjsNCj4gKwljYXNlIDB4MTIwMTogcmV0dXJuICJUaW1lIFNldHVwIFNlcnZlciI7DQo+ICsJY2Fz
ZSAweDEyMDI6IHJldHVybiAiVGltZSBDbGllbnQiOw0KPiArCWNhc2UgMHgxMjAzOiByZXR1cm4g
IlNjZW5lIFNlcnZlciI7DQo+ICsJY2FzZSAweDEyMDQ6IHJldHVybiAiU2NlbmUgU2V0dXAgU2Vy
dmVyIjsNCj4gKwljYXNlIDB4MTIwNTogcmV0dXJuICJTY2VuZSBDbGllbnQiOw0KPiArCWNhc2Ug
MHgxMjA2OiByZXR1cm4gIlNjaGVkdWxlciBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMjA3OiByZXR1
cm4gIlNjaGVkdWxlciBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMjA4OiByZXR1cm4gIlNj
aGVkdWxlciBDbGllbnQiOw0KPiArCWNhc2UgMHgxMzAwOiByZXR1cm4gIkxpZ2h0IExpZ2h0bmVz
cyBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzAxOiByZXR1cm4gIkxpZ2h0IExpZ2h0bmVzcyBTZXR1
cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzAyOiByZXR1cm4gIkxpZ2h0IExpZ2h0bmVzcyBDbGll
bnQiOw0KPiArCWNhc2UgMHgxMzAzOiByZXR1cm4gIkxpZ2h0IENUTCBTZXJ2ZXIiOw0KPiArCWNh
c2UgMHgxMzA0OiByZXR1cm4gIkxpZ2h0IENUTCBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgx
MzA1OiByZXR1cm4gIkxpZ2h0IENUTCBDbGllbnQiOw0KPiArCWNhc2UgMHgxMzA2OiByZXR1cm4g
IkxpZ2h0IENUTCBUZW1wZXJhdHVyZSBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzA3OiByZXR1cm4g
IkxpZ2h0IEhTTCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzA4OiByZXR1cm4gIkxpZ2h0IEhTTCBT
ZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzA5OiByZXR1cm4gIkxpZ2h0IEhTTCBDbGllbnQi
Ow0KPiArCWNhc2UgMHgxMzBBOiByZXR1cm4gIkxpZ2h0IEhTTCBIdWUgU2VydmVyIjsNCj4gKwlj
YXNlIDB4MTMwQjogcmV0dXJuICJMaWdodCBIU0wgU2F0dXJhdGlvbiBTZXJ2ZXIiOw0KPiArCWNh
c2UgMHgxMzBDOiByZXR1cm4gIkxpZ2h0IHh5TCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzBEOiBy
ZXR1cm4gIkxpZ2h0IHh5TCBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzBFOiByZXR1cm4g
IkxpZ2h0IHh5TCBDbGllbnQiOw0KPiArCWNhc2UgMHgxMzBGOiByZXR1cm4gIkxpZ2h0IExDIFNl
cnZlciI7DQo+ICsJY2FzZSAweDEzMTA6IHJldHVybiAiTGlnaHQgTEMgU2V0dXAgU2VydmVyIjsN
Cj4gKwljYXNlIDB4MTMxMTogcmV0dXJuICJMaWdodCBMQyBDbGllbnQiOw0KPiArDQo+ICsJZGVm
YXVsdDogcmV0dXJuICJVbmtub3duIjsNCj4gKwl9DQo+ICt9DQo+IGRpZmYgLS1naXQgYS90b29s
cy9tZXNoL3V0aWwuaCBiL3Rvb2xzL21lc2gvdXRpbC5oDQo+IGluZGV4IGNjYTA3Y2Y5Ni4uN2U5
NjZiYzY5IDEwMDY0NA0KPiAtLS0gYS90b29scy9tZXNoL3V0aWwuaA0KPiArKysgYi90b29scy9t
ZXNoL3V0aWwuaA0KPiBAQCAtMjcsMyArMjcsNCBAQCB1aW50MTZfdCBtZXNoX29wY29kZV9zZXQo
dWludDMyX3Qgb3Bjb2RlLCANCj4gdWludDhfdCAqYnVmKTsNCj4gICBib29sIG1lc2hfb3Bjb2Rl
X2dldChjb25zdCB1aW50OF90ICpidWYsIHVpbnQxNl90IHN6LCANCj4gdWludDMyX3QgKm9wY29k
ZSwgaW50ICpuKTsNCj4gICBjb25zdCBjaGFyICptZXNoX3N0YXR1c19zdHIodWludDhfdCBzdGF0
dXMpOw0KPiAgIHZvaWQgc3dhcF91MjU2X2J5dGVzKHVpbnQ4X3QgKnUyNTYpOw0KPiArY29uc3Qg
Y2hhcioJc2lnX21vZGVsX3N0cmluZyh1aW50MTZfdCBzaWdfbW9kZWxfaWQpOw0KDQoiY2hhcioJ
c2lnIiAtPiAiY2hhciAqc2lnIg0KDQoNClJlZ2FyZHMsDQpJbmdhDQo=
