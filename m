Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282AECE58D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C331E20869
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 20:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HAXDrObh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbfJQUTl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:19:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:58664 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfJQUTl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Oct 2019 16:19:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 13:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="195271211"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2019 13:19:40 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 13:19:40 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 13:19:39 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 17 Oct 2019 13:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEeEox3j1DLIJM0xWfDVOcPKywnHXa/NUptrKboCVX7tyduGljes+JfDWSHF5sHm+rHxjJ8TMFEYi7NWNeroHjlCelUY6tMreurATh+lWK/SfgoX+3z6o137oDWF7dFpNX5VxBwgLupMnlAkbOM7HILUS49Sd8azkV68QgTPh+dDwrbbL09PUV3XomXupeLLu6nyYvgIQC2WVW3jl60Fqnp0fG2m98A2qKKrA6xY8/xckFRekYKD/L5s27AAZTS8I9FbAetslhg5h5ASuFhd0mgGDDjjMbxR9QzzHB/6SVqd2l420KCaX7OrantswhAXIpg+vEXll0eezyuHsCdI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jljGtDAaGpsVPE25pEqU/nLX8RYSCnzlBHEJHnpgvQ=;
 b=Fgi5+F35qIi7N2RMHORkRJWdGA4UiXCRhmESC8ieSexjhr56xcfvfcq29sY4qnNZrbhHbNaPRVqmnoXKzlRM+7sctkW7uXhSYNa/r4cjVpU98nRxM3RRf6ZkkEIIlaSWsEtxmXikNuOEQzZI1VIDDgHwlxasFXzlTiU259l682CZ8H0vSASAd+aJs2BxkkB4ciz3ZZgEU0vdJHmK+i1s3+pdGVG5IqrawKY1/jC0GLdyfUU+YEipWRi02LCEJXdliJcUuSVGHlYgBaQltB9sCgdE7fl25J7GWdbONqXA4/1Ff+8BzXEnojiYg1Q+lOGBKR+PjeQ/GYJwkxug4hU5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jljGtDAaGpsVPE25pEqU/nLX8RYSCnzlBHEJHnpgvQ=;
 b=HAXDrObhZzA54POeSxK2w4X7LKChSm9bI7pm3fGt3G4LQ0Xj/si9soXN8Ffoc2lJmJMEFXcMgqE3keqShaf0VFUeLegGBIbsCoyqzBVLPX+z3RnPl27cUNw+b/KHNsYVNQ9qPv2RfhLCSw7XWkUglOSomg75E9B9MTAAGnHvDJY=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2357.namprd11.prod.outlook.com (10.173.194.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 20:19:38 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501%10]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 20:19:38 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Implement AddAppKey and AddNetKey methods
Thread-Topic: [PATCH BlueZ] mesh: Implement AddAppKey and AddNetKey methods
Thread-Index: AQHVhSRn4xAyzqylcU+3ahRtFE+MnKdfRhsA
Date:   Thu, 17 Oct 2019 20:19:37 +0000
Message-ID: <62c6cfb678e5556883ed5ed89c97adaf5938292d.camel@intel.com>
References: <20191017195205.7539-1-inga.stotland@intel.com>
In-Reply-To: <20191017195205.7539-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0013a7a7-2b7a-4c77-9fec-08d7533f559d
x-ms-traffictypediagnostic: CY4PR1101MB2357:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2357AC19D9ADAD4E4F441178E16D0@CY4PR1101MB2357.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(3846002)(110136005)(66066001)(14444005)(316002)(71200400001)(76176011)(25786009)(14454004)(36756003)(71190400001)(6486002)(6512007)(86362001)(6116002)(229853002)(256004)(2501003)(5660300002)(99286004)(6436002)(2906002)(6506007)(2616005)(478600001)(11346002)(6636002)(186003)(102836004)(446003)(81166006)(91956017)(7736002)(305945005)(8676002)(81156014)(6246003)(4001150100001)(66476007)(26005)(66946007)(118296001)(76116006)(66556008)(66446008)(64756008)(8936002)(476003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2357;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFaa0SJRVEcCRmn2TzKpcwXC+WfF1yRE9J7ZtDGn+gq5PAskB+ZSGBjVC3lS7gsUcWY5gTuILW6TPYYU/nr4rLnSdT9ISoX2wIjKFD2okXkRyT840VZWX4EM8YK4k170en5F+UDAbLM8LcpF9DdtyJLUT9mWusiaqH3/l1m+6Zhnibmb1c7xSIeaD099M+zQuuhryT4J8PHPWHG1fqVAfgTIyaEsUGzywms/U/myoFY8LXKw/OTLht3PhZhn/uj8BHuzVW4EGmMZJCKlQSuBaYR0anuuUhJo+OlqreZflVJPR49reVZM8RVV8MFSkaHHH4uwiyFmX3FKjjhqnsjo9I4NDpfOziDwdFxeJpKtkRLujjFYv1kS8STaztppz+hLO1isirqG1lg+CI+X+5Jcm5qaUqHlL8RD1Xr/3O3CMXU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F3CB28CD2F304E9A72A45769A2D927@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0013a7a7-2b7a-4c77-9fec-08d7533f559d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 20:19:37.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCoTj8RbuSmjG+IkgWgz2lj6Z4AIdDxWwozUFJSbINT/hJ+A/E8LjqXFy6z1hy8RFKNGwfARoWZ/IejkCeCxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2357
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwNCg0KT24gVGh1LCAyMDE5LTEwLTE3IGF0IDEyOjUyIC0wNzAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBUaGlzIGFkZHMgaW1wbGVtZW50YXRpb24gZm9yIHRoZSBmb2xsb3dpbmcg
bWV0aG9kcyBvbg0KPiBvcmcuYmx1ZXoubWVzaC5Ob2RlMSBpbnRlcmZhY2U6DQo+IHZvaWQgQWRk
TmV0S2V5KG9iamVjdCBlbGVtZW50X3BhdGgsIHVpbnQxNiBkZXN0aW5hdGlvbiwNCj4gCQl1aW50
MTYgc3VibmV0X2luZGV4LCB1aW50MTYgbmV0X2luZGV4LCBib29sZWFuIHVwZGF0ZSkNCj4gdm9p
ZCBBZGRBcHBLZXkob2JqZWN0IGVsZW1lbnRfcGF0aCwgdWludDE2IGRlc3RpbmF0aW9uLA0KPiAJ
CXVpbnQxNiBhcHBfaW5kZXgsIHVpbnQxNiBuZXRfaW5kZXgsIGJvb2xlYW4gdXBkYXRlKQ0KPiAt
LS0NCj4gIG1lc2gvbm9kZS5jIHwgMTI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMjUgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gv
bm9kZS5jDQo+IGluZGV4IDc0Njk0ZDUyMC4uYzQ3ZTE5NjFkIDEwMDY0NA0KPiAtLS0gYS9tZXNo
L25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtNDQzLDcgKzQ0Myw3IEBAIHN0YXRp
YyB2b2lkIHNldF9uZXRfa2V5KHZvaWQgKmEsIHZvaWQgKmIpDQo+ICAJCQkJCQkJCW5ldGtleS0+
cGhhc2UpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBzZXRfYXBwX2tleSh2b2lkICphLCB2
b2lkICpiKQ0KPiArc3RhdGljIHZvaWQgc2V0X2FwcGtleSh2b2lkICphLCB2b2lkICpiKQ0KPiAg
ew0KPiAgCXN0cnVjdCBtZXNoX2NvbmZpZ19hcHBrZXkgKmFwcGtleSA9IGE7DQo+ICAJc3RydWN0
IG1lc2hfbm9kZSAqbm9kZSA9IGI7DQo+IEBAIC01MTIsNyArNTEyLDcgQEAgc3RhdGljIGJvb2wg
aW5pdF9mcm9tX3N0b3JhZ2Uoc3RydWN0IG1lc2hfY29uZmlnX25vZGUgKmRiX25vZGUsDQo+ICAJ
bF9xdWV1ZV9mb3JlYWNoKGRiX25vZGUtPm5ldGtleXMsIHNldF9uZXRfa2V5LCBub2RlKTsNCj4g
IA0KPiAgCWlmIChkYl9ub2RlLT5hcHBrZXlzKQ0KPiAtCQlsX3F1ZXVlX2ZvcmVhY2goZGJfbm9k
ZS0+YXBwa2V5cywgc2V0X2FwcF9rZXksIG5vZGUpOw0KPiArCQlsX3F1ZXVlX2ZvcmVhY2goZGJf
bm9kZS0+YXBwa2V5cywgc2V0X2FwcGtleSwgbm9kZSk7DQo+ICANCj4gIAltZXNoX25ldF9zZXRf
c2VxX251bShub2RlLT5uZXQsIG5vZGUtPnNlcV9udW1iZXIpOw0KPiAgCW1lc2hfbmV0X3NldF9k
ZWZhdWx0X3R0bChub2RlLT5uZXQsIG5vZGUtPnR0bCk7DQo+IEBAIC0yMDAxLDYgKzIwMDEsMTIz
IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKmRldl9rZXlfc2VuZF9jYWxsKHN0cnVj
dCBsX2RidXMgKmRidXMsDQo+ICAJcmV0dXJuIGxfZGJ1c19tZXNzYWdlX25ld19tZXRob2RfcmV0
dXJuKG1zZyk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKmFk
ZF9uZXRrZXlfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiArCQkJCQkJc3RydWN0IGxfZGJ1
c19tZXNzYWdlICptc2csDQo+ICsJCQkJCQl2b2lkICp1c2VyX2RhdGEpDQo+ICt7DQo+ICsJc3Ry
dWN0IG1lc2hfbm9kZSAqbm9kZSA9IHVzZXJfZGF0YTsNCj4gKwljb25zdCBjaGFyICpzZW5kZXIs
ICplbGVfcGF0aDsNCj4gKwlzdHJ1Y3Qgbm9kZV9lbGVtZW50ICplbGU7DQo+ICsJdWludDE2X3Qg
ZHN0LCBzdWJfaWR4LCBuZXRfaWR4LCBzcmM7DQo+ICsJYm9vbCB1cGRhdGU7DQo+ICsJc3RydWN0
IGtleXJpbmdfbmV0X2tleSBrZXk7DQo+ICsJdWludDhfdCBkYXRhWzIwXTsNCj4gKw0KPiArCWxf
ZGVidWcoIkFkZE5ldEtleSIpOw0KPiArDQo+ICsJc2VuZGVyID0gbF9kYnVzX21lc3NhZ2VfZ2V0
X3NlbmRlcihtc2cpOw0KPiArDQo+ICsJaWYgKHN0cmNtcChzZW5kZXIsIG5vZGUtPm93bmVyKSkN
Cj4gKwkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX05PVF9BVVRIT1JJWkVELCBO
VUxMKTsNCj4gKw0KPiArCWlmICghbF9kYnVzX21lc3NhZ2VfZ2V0X2FyZ3VtZW50cyhtc2csICJv
cXFxYiIsICZlbGVfcGF0aCwgJmRzdCwNCj4gKwkJCQkJCSZzdWJfaWR4LCAmbmV0X2lkeCwgJnVw
ZGF0ZSkpDQo+ICsJCXJldHVybiBkYnVzX2Vycm9yKG1zZywgTUVTSF9FUlJPUl9JTlZBTElEX0FS
R1MsIE5VTEwpOw0KPiArDQo+ICsJZWxlID0gbF9xdWV1ZV9maW5kKG5vZGUtPmVsZW1lbnRzLCBt
YXRjaF9lbGVtZW50X3BhdGgsIGVsZV9wYXRoKTsNCj4gKwlpZiAoIWVsZSkNCj4gKwkJcmV0dXJu
IGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX05PVF9GT1VORCwNCj4gKwkJCQkJCQkiRWxlbWVu
dCBub3QgZm91bmQiKTsNCj4gKw0KPiArCXNyYyA9IG5vZGVfZ2V0X3ByaW1hcnkobm9kZSkgKyBl
bGUtPmlkeDsNCj4gKw0KPiArCWlmICgha2V5cmluZ19nZXRfbmV0X2tleShub2RlLCBuZXRfaWR4
LCAma2V5KSkNCj4gKwkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX05PVF9GT1VO
RCwNCj4gKwkJCQkJCQkiTmV0S2V5IG5vdCBmb3VuZCIpOw0KDQpUaGlzIGlzIHRoZSB3cm9uZyBu
ZXQga2V5IHRvIGxvb2sgdXAgaW4gdGhlIGtleXJpbmcuICBGcm9tIHRoZSBtZXNoLWFwaS50eHQ6
DQoNCgkJVGhlIHN1Ym5ldF9pbmRleCBwYXJhbWV0ZXIgcmVmZXJzIHRvIHRoZSBzdWJuZXQgaW5k
ZXggb2YgdGhlDQoJCW5ldHdvcmsgdGhhdCBpcyBiZWluZyBhZGRlZCBvciB1cGRhdGVkLiBUaGlz
IGtleSBtdXN0IGV4aXN0IGluDQoJCXRoZSBsb2NhbCBrZXkgZGF0YWJhc2UuDQoNCgkJVGhlIG5l
dF9pbmRleCBwYXJhbWV0ZXIgaXMgdGhlIHN1Ym5ldCBpbmRleCBvZiB0aGUgbmV0d29yayBvbg0K
CQl3aGljaCB0aGUgbWVzc2FnZSBpcyB0byBiZSBzZW50Lg0KDQo+ICsNCj4gKwlpZiAoIXVwZGF0
ZSkgew0KPiArCQlsX3B1dF9iZTE2KE9QX05FVEtFWV9BREQsIGRhdGEpOw0KPiArCQltZW1jcHko
ZGF0YSArIDQsIGtleS5vbGRfa2V5LCAxNik7DQoNCklmIHdlIGFyZSBpbiBQaGFzZSAyLCB0aGVu
IHRoZSBrZXkgc2VudCBvbiBORVRLRVlfQUREIHNob3VsZCBiZSB0aGUgbmV3IGtleS4NCg0KPiAr
CX0gZWxzZSB7DQo+ICsJCWlmIChrZXkucGhhc2UgIT0gS0VZX1JFRlJFU0hfUEhBU0VfT05FKQ0K
PiArCQkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX0ZBSUxFRCwNCj4gKwkJCQkJ
CQkiQ2Fubm90IHVwZGF0ZSIpOw0KPiArCQlsX3B1dF9iZTE2KE9QX05FVEtFWV9VUERBVEUsIGRh
dGEpOw0KPiArCQltZW1jcHkoZGF0YSArIDQsIGtleS5uZXdfa2V5LCAxNik7DQo+ICsJfQ0KPiAr
DQo+ICsJbF9wdXRfbGUxNihzdWJfaWR4LCAmZGF0YVsyXSk7DQoNClRoaXMgaXMgY29ycmVjdC4g
IEJ1dCBzZWUgYWJvdmUuDQoNCj4gKw0KPiArCWlmICghbWVzaF9tb2RlbF9zZW5kKG5vZGUsIHNy
YywgZHN0LCBBUFBfSURYX0RFVl9SRU1PVEUsIG5ldF9pZHgsDQo+ICsJCQkJCQkJREVGQVVMVF9U
VEwsIGRhdGEsIDIwKSkNCj4gKwkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX05P
VF9GT1VORCwgTlVMTCk7DQo+ICsNCj4gKwlyZXR1cm4gbF9kYnVzX21lc3NhZ2VfbmV3X21ldGhv
ZF9yZXR1cm4obXNnKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2Fn
ZSAqYWRkX2FwcGtleV9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICsJCQkJCQlzdHJ1Y3Qg
bF9kYnVzX21lc3NhZ2UgKm1zZywNCj4gKwkJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCj4gK3sNCj4g
KwlzdHJ1Y3QgbWVzaF9ub2RlICpub2RlID0gdXNlcl9kYXRhOw0KPiArCWNvbnN0IGNoYXIgKnNl
bmRlciwgKmVsZV9wYXRoOw0KPiArCXN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZTsNCj4gKwl1aW50
MTZfdCBkc3QsIGFwcF9pZHgsIG5ldF9pZHgsIHNyYzsNCj4gKwlib29sIHVwZGF0ZTsNCj4gKwlz
dHJ1Y3Qga2V5cmluZ19uZXRfa2V5IG5ldF9rZXk7DQo+ICsJc3RydWN0IGtleXJpbmdfYXBwX2tl
eSBhcHBfa2V5Ow0KPiArCXVpbnQ4X3QgZGF0YVsyMF07DQo+ICsNCj4gKwlsX2RlYnVnKCJBZGRO
ZXRLZXkiKTsNCg0KQWRkQXBwS2V5DQoNCj4gKw0KPiArCXNlbmRlciA9IGxfZGJ1c19tZXNzYWdl
X2dldF9zZW5kZXIobXNnKTsNCj4gKw0KPiArCWlmIChzdHJjbXAoc2VuZGVyLCBub2RlLT5vd25l
cikpDQo+ICsJCXJldHVybiBkYnVzX2Vycm9yKG1zZywgTUVTSF9FUlJPUl9OT1RfQVVUSE9SSVpF
RCwgTlVMTCk7DQo+ICsNCj4gKwlpZiAoIWxfZGJ1c19tZXNzYWdlX2dldF9hcmd1bWVudHMobXNn
LCAib3FxcWIiLCAmZWxlX3BhdGgsICZkc3QsDQo+ICsJCQkJCQkmYXBwX2lkeCwgJm5ldF9pZHgs
ICZ1cGRhdGUpKQ0KPiArCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJ
RF9BUkdTLCBOVUxMKTsNCj4gKw0KPiArCWVsZSA9IGxfcXVldWVfZmluZChub2RlLT5lbGVtZW50
cywgbWF0Y2hfZWxlbWVudF9wYXRoLCBlbGVfcGF0aCk7DQo+ICsJaWYgKCFlbGUpDQo+ICsJCXJl
dHVybiBkYnVzX2Vycm9yKG1zZywgTUVTSF9FUlJPUl9OT1RfRk9VTkQsDQo+ICsJCQkJCQkJIkVs
ZW1lbnQgbm90IGZvdW5kIik7DQo+ICsNCj4gKwlzcmMgPSBub2RlX2dldF9wcmltYXJ5KG5vZGUp
ICsgZWxlLT5pZHg7DQo+ICsNCj4gKwlpZiAoIWtleXJpbmdfZ2V0X2FwcF9rZXkobm9kZSwgYXBw
X2lkeCwgJmFwcF9rZXkpKQ0KPiArCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1Jf
Tk9UX0ZPVU5ELA0KPiArCQkJCQkJCSJBcHBLZXkgbm90IGZvdW5kIik7DQo+ICsNCj4gKwlpZiAo
IWtleXJpbmdfZ2V0X25ldF9rZXkobm9kZSwgYXBwX2tleS5uZXRfaWR4LCAmbmV0X2tleSkpIHsN
Cj4gKwkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX05PVF9GT1VORCwNCj4gKwkJ
CQkJCSJCb3VuZCBOZXRLZXkgbm90IGZvdW5kIik7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKCF1cGRh
dGUpIHsNCj4gKwkJZGF0YVswXSA9IE9QX0FQUEtFWV9BREQ7DQo+ICsJCW1lbWNweShkYXRhICsg
NCwgYXBwX2tleS5vbGRfa2V5LCAxNik7DQoNClBoYXNlIDIgbWVhbnMgbmV3X2tleQ0KDQo+ICsJ
fSBlbHNlIHsNCj4gKwkJaWYgKG5ldF9rZXkucGhhc2UgIT0gS0VZX1JFRlJFU0hfUEhBU0VfT05F
KQ0KPiArCQkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX0ZBSUxFRCwNCj4gKwkJ
CQkJCQkiQ2Fubm90IHVwZGF0ZSIpOw0KPiArCQlkYXRhWzBdID0gT1BfQVBQS0VZX1VQREFURTsN
Cj4gKwkJbWVtY3B5KGRhdGEgKyA0LCBhcHBfa2V5Lm5ld19rZXksIDE2KTsNCj4gKwl9DQo+ICsN
Cj4gKwkvKiBQYWNrIGJvdW5kIE5ldEtleSBhbmQgQXBwS2V5IGludG8gMyBvY3RldHMgKi8NCj4g
KwlkYXRhWzFdID0gYXBwX2tleS5uZXRfaWR4Ow0KPiArCWRhdGFbMl0gPSAoKGFwcF9rZXkubmV0
X2lkeCA+PiA4KSAmIDB4ZikgfCAoKGFwcF9pZHggPDwgNCkgJiAweGYwKTsNCj4gKwlkYXRhWzNd
ID0gYXBwX2lkeCA+PiA0Ow0KPiArDQo+ICsJaWYgKCFtZXNoX21vZGVsX3NlbmQobm9kZSwgc3Jj
LCBkc3QsIEFQUF9JRFhfREVWX1JFTU9URSwgbmV0X2lkeCwNCj4gKwkJCQkJCQlERUZBVUxUX1RU
TCwgZGF0YSwgMjApKQ0KPiArCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfTk9U
X0ZPVU5ELCBOVUxMKTsNCj4gKw0KPiArCXJldHVybiBsX2RidXNfbWVzc2FnZV9uZXdfbWV0aG9k
X3JldHVybihtc2cpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdl
ICpwdWJsaXNoX2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAkJCQkJCXN0cnVjdCBsX2Ri
dXNfbWVzc2FnZSAqbXNnLA0KPiAgCQkJCQkJdm9pZCAqdXNlcl9kYXRhKQ0KPiBAQCAtMjIxOSw2
ICsyMzM2LDEyIEBAIHN0YXRpYyB2b2lkIHNldHVwX25vZGVfaW50ZXJmYWNlKHN0cnVjdCBsX2Ri
dXNfaW50ZXJmYWNlICppZmFjZSkNCj4gIAkJCQkJCSIiLCAib3FicWF5IiwgImVsZW1lbnRfcGF0
aCIsDQo+ICAJCQkJCQkiZGVzdGluYXRpb24iLCAicmVtb3RlIiwNCj4gIAkJCQkJCSJuZXRfaW5k
ZXgiLCAiZGF0YSIpOw0KPiArCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiQWRkTmV0
S2V5IiwgMCwgYWRkX25ldGtleV9jYWxsLCAiIiwNCj4gKwkJCQkJIm9xcXFiIiwgImVsZW1lbnRf
cGF0aCIsICJkZXN0aW5hdGlvbiIsDQo+ICsJCQkJCSJzdWJuZXRfaW5kZXgiLCAibmV0X2luZGV4
IiwgInVwZGF0ZSIpOw0KPiArCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiQWRkQXBw
S2V5IiwgMCwgYWRkX2FwcGtleV9jYWxsLCAiIiwNCj4gKwkJCQkJIm9xcXFiIiwgImVsZW1lbnRf
cGF0aCIsICJkZXN0aW5hdGlvbiIsDQo+ICsJCQkJCSJhcHBfaW5kZXgiLCAibmV0X2luZGV4Iiwg
InVwZGF0ZSIpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiUHVibGlzaCIs
IDAsIHB1Ymxpc2hfY2FsbCwgIiIsICJvcWF5IiwNCj4gIAkJCQkJImVsZW1lbnRfcGF0aCIsICJt
b2RlbF9pZCIsICJkYXRhIik7DQo+ICAJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJW
ZW5kb3JQdWJsaXNoIiwgMCwgdmVuZG9yX3B1Ymxpc2hfY2FsbCwNCg==
