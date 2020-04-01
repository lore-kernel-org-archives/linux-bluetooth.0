Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E444AC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF08620BED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ji/cClug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbgDAP1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:27:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:53662 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbgDAP1q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 11:27:46 -0400
IronPort-SDR: qQIxKxwZt21YNPQ1mQGU6FxEAqGljUmbESq9pTtZi4DONptfefld4Vue8xAwglTRxgHI9GmgUo
 Z6LeDHIvT9fg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 08:27:45 -0700
IronPort-SDR: bzoe7Q9xT6v3hkK346hNdy6eijV7utNLbOif+fGq8gZc6SgXVbnk+kxFLysIKZXbcKgztDGOQC
 XuTe9RPsMTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="359893332"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2020 08:27:45 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 08:27:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 08:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYyBdZWQK74LItuV74ATSuGn5oE6pzW4Yb4EuIZFZbO5PHhcZ9u7yDMeBMbjhzHWUZmvB23r2ETIiP6odXrGTFyWYSquoOu9ezmM6b3XprClzrvrc/ymaMmDasuyD1HiJresMJb9CXdnC+jdSAJ1Tnk0AJsnRKYIE6kpE0ka1o2DPK3+OSW5aVZV20wXF8nABlzH3GqPkSJ+RqwsHbOtJGRoh6hbXOtxIcaQY7W9t9DCOgoOTl0JaIm/siGCphXyImkbXd1HZiGnoqpIhwTTQC80mQfvAVP+0vojoN8WfxOlw+5zF3t34POXStkryyGnCBNEUANR1ju9Vtf8VxvcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcIp8NfzUqQwQstMN8VUsoFjNXv86XItLayCJ6ZiML4=;
 b=dx+JydiSTCO4ByCZKgeeoUS3DzBwUKQsbsGMcg1sbU7DZSLi790ICNsyISD95O8nqQspAdc3XWgRg4ZDHA7cjh6F71swsmblruoUMQXENDMiy+Z4SUApowGSHamhFL9COxSdanh5usg7T5E1p83ACpjaslAKyx/9fR6JgPrN/b2CSmR+5wNp6rzP4RQOooOOlTCDA6qaC2U0TRPHQA1aItpbpED8fO8xBN/q01YTQ0dG33zAISs6phhO5ywS/EzDUK5QsctRmiF1BBYbvfdtRzpD+KpF/rZTnt0ERkpoV57KiqJraQAkjsWl/x6i8kDqh/Ru99o7CtBIDmL8436z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcIp8NfzUqQwQstMN8VUsoFjNXv86XItLayCJ6ZiML4=;
 b=ji/cClugiYV3SDXYA/2Ltxt640CEJCqLsWX+UETUf0lf8caHW4cyWr8ze086jC1Isdz6rruukt+V7vqzAQE0emPJQQcc0inFdCG71bczJ3+ZFzR9i/h+StWpsXkzWCqESFHxaXx2LDC4We6AOp+A6ijv4p8x75x8fXPAVocnUsA=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4700.namprd11.prod.outlook.com (2603:10b6:303:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 15:27:43 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 15:27:43 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "nitin.j@samsung.com" <nitin.j@samsung.com>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>
Subject: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Thread-Topic: [PATCH BlueZ] mesh: Add check for valid netkey index
Thread-Index: AQHWCBzUCLdKS+ksE06MAFe9MVMWf6hkY/EA
Date:   Wed, 1 Apr 2020 15:27:43 +0000
Message-ID: <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
References: <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcas5p1.samsung.com>
         <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
In-Reply-To: <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08646e9b-ef04-468d-c815-08d7d6513909
x-ms-traffictypediagnostic: MW3PR11MB4700:
x-microsoft-antispam-prvs: <MW3PR11MB47004587341DCE772852D962E1C90@MW3PR11MB4700.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(2616005)(66476007)(478600001)(6512007)(81166006)(316002)(64756008)(71200400001)(81156014)(8936002)(86362001)(66946007)(66556008)(66446008)(36756003)(6486002)(5660300002)(2906002)(8676002)(6506007)(76116006)(186003)(110136005)(4326008)(54906003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u86Vy2bhEKfrGP5wCojSYBFtwjyWOgTl5xEnpQTXYn95rNvEQH3Ql9HNIPINtTg2WlEkhcDx2GX5DgKpySk8LPTKJdXwr5mW5JOdpFquhbt/1AKI3uKohUrAbgX39XAk/Lk45LWNcJPQKTPXuBvpNXp9ebQQQW9EcgbgUXpxJMQdXn4Cgf3He+tQnlf2utYPfVgoeb9YgS2Mo/q4dOnKom0yZPcO+2aBdhtte/TuNcIQtfjKGi3gyPjw3cDl7XD6j/lQg5XGzKnIUj5vtYClbIYM9AXBHQ6zuSoJqBwa1chOXpYprxwBkoFKqKsQfuXGOqzfAcOIlIALwfbCvSdwyqu9CIRwwpYB4M36wfvRCbqszsAaZI5H9lKe4cMxXKKdKgM26XQseMLjbkwbuwksbTzCogHz/n/382IsSXaU927sd5fpWseNwu4Cgfk1lJDu
x-ms-exchange-antispam-messagedata: oDvIxUsH28Wg6OHfozr+GotLxfl3fOP+cXmvaZJ0+7t3qSt0BlMpuonjKFjNU8rHpj4VSpZ0pp+DLhsS2tZtHDUkdUKKsYWNKo7nzh3nZi8puZNJWLAQ23SG/HAjAdq+9BI6Ize1Mnus39dgzeJ4QA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <689F495065AAD34AAADD7B001029FC0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 08646e9b-ef04-468d-c815-08d7d6513909
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 15:27:43.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oq9Lx2uY9XdP0lJRn1s+l32T+Mqlw06uZaJQ8WEE0DkCbU4Tb7Pnfpcd1TPjKx1mtjBNtcUAp4QSWRoFT1dI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4700
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQW51cGFtLA0KT24gV2VkLCAyMDIwLTA0LTAxIGF0IDE2OjUwICswNTMwLCBBbnVwYW0gUm95
IHdyb3RlOg0KPiBUaGlzIHBhdGNoIGFkZHMgdmFsaWRhdGlvbiBvZiBuZXQga2V5IGluZGV4LCB3
aGljaCB3aWxsIGJlDQo+IHVzZWQgdG8gc2VuZCBtZXNzYWdlIHRvIG5vZGVzLiBSZXR1cm4gZXJy
b3IgaW4gY2FzZSBuZXQga2V5IGluZGV4DQo+IGlzIG5vdCB2YWxpZC4gVGhpcyBhdm9pZHMgbWVz
c2FnZSBlbmNyeXB0aW9uIHVzaW5nIGRldmljZSBrZXkNCj4gYW5kIGZ1cnRoZXIgcHJvY2Vzc2lu
ZyBvZiB0aGUgbWVzc2FnZS4NCj4gLS0tDQo+ICBtZXNoL21vZGVsLmMgfCA5ICsrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvbW9kZWwuYyBiL21lc2gvbW9kZWwuYw0KPiBpbmRleCA5NDU1ODMzLi42Y2MxZGM1IDEwMDY0
NA0KPiAtLS0gYS9tZXNoL21vZGVsLmMNCj4gKysrIGIvbWVzaC9tb2RlbC5jDQo+IEBAIC01NDYs
NiArNTQ2LDcgQEAgc3RhdGljIGJvb2wgbXNnX3NlbmQoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwg
Ym9vbCBjcmVkZW50aWFsLCB1aW50MTZfdCBzcmMsDQo+ICAJdWludDhfdCBkZXZfa2V5WzE2XTsN
Cj4gIAl1aW50MzJfdCBpdl9pbmRleCwgc2VxX251bTsNCj4gIAljb25zdCB1aW50OF90ICprZXk7
DQo+ICsJc3RydWN0IGtleXJpbmdfbmV0X2tleSBuZXRfa2V5Ow0KPiAgCXVpbnQ4X3QgKm91dDsN
Cj4gIAl1aW50OF90IGtleV9haWQgPSBBUFBfQUlEX0RFVjsNCj4gIAlib29sIHN6bWljID0gZmFs
c2U7DQo+IEBAIC01NzgsOCArNTc5LDE2IEBAIHN0YXRpYyBib29sIG1zZ19zZW5kKHN0cnVjdCBt
ZXNoX25vZGUgKm5vZGUsIGJvb2wgY3JlZGVudGlhbCwgdWludDE2X3Qgc3JjLA0KPiAgCQl9DQo+
ICANCj4gIAkJbmV0X2lkeCA9IGFwcGtleV9uZXRfaWR4KG5vZGVfZ2V0X25ldChub2RlKSwgYXBw
X2lkeCk7DQo+ICsJCWlmIChuZXRfaWR4ID09IE5FVF9JRFhfSU5WQUxJRCkgew0KPiArCQkJbF9k
ZWJ1Zygibm8gbmV0IGtleSBmb3IgKCV4KSIsIG5ldF9pZHgpOw0KPiArCQkJcmV0dXJuIGZhbHNl
Ow0KPiArCQl9DQoNClRoaXMgKm1pZ2h0KiBiZSBhIHZhbGlkICJzYW5pdHkiIHRlc3QuLi4gIEFs
dGhvdWdoIGFuIEFwcCBLZXkgc2hvdWxkIG5ldmVyIGJlIGFsbG93ZWQgdG8gYmUgYWRkZWQsIG9y
IGV4aXN0DQp1bmxlc3MgdGhlIGJvdW5kIG5ldGtleSBhbHJlYWR5IGV4aXN0cy4gIEkgdGhpbmsg
dGhlIG9ubHkgd2F5IGFuIEFwcCBLZXkgbWlnaHQgZXhpc3Qgd2l0aG91dCBpdCdzIGJvdW5kIG5l
dGtleQ0KaXMgaWYgdGhlIGRhZW1vbiBwcml2YXRlIG5vZGUuanNvbiBmaWxlIHdhcyBoYW5kIGVk
aXRlZCwgd2hpY2ggaXMgbm90IHRlY2huaWNhbGx5IGFsbG93ZWQuDQoNCj4gIAl9DQo+ICANCj4g
KwlpZiAoIWtleXJpbmdfZ2V0X25ldF9rZXkobm9kZSwgbmV0X2lkeCwgJm5ldF9rZXkpKSB7DQo+
ICsJCWxfZGVidWcoIm5vIG5ldCBrZXkgZm9yICgleCkiLCBuZXRfaWR4KTsNCj4gKwkJcmV0dXJu
IGZhbHNlOw0KPiArCX0NCg0KVGhpcyBjaGVjayBpcyBpbnZhbGlkLiBPbmx5IGFuIGF1dGhvcml6
ZWQgQ29uZmlnIENsaWVudHMgLyBQcm92aXNpb25lcnMgaGF2ZSBLZXkgUmluZ3MsIHdoaWNoIGlz
IHVzZWQgdG8gc2VuZA0KQWRkS2V5LCBVcGRhdGVLZXkgYW5kIFByb3Zpc2lvbmluZyBkYXRhIHRv
IHJlbW90ZSBub2Rlcy4gIFRoZSBrZXlyaW5nIGlzIHJlc3RyaWN0ZWQgdG8gbm9kZXMgd2hpY2gg
aGF2ZSBmdWxsDQpuZXR3b3JrIGNvbmZpZ3VyYXRpb24gcHJpdmxlZ2VzLi4uLiAgQWRkaW5nIHRo
aXMgd291bGQgcmVxdWlyZSAqYWxsKiBub2RlcyBpbiB0aGUgbmV0d29yayB0byBiZSBwcml2bGVn
ZWQNCm5vZGVzLCB3aGljaCB3b3VsZCB0aGVuIGFsbG93IHRoZW0gdG8gbWFrZSBjaGFuZ2VzIG91
dHNpZGUgdGhlIFByb3Zpc2lvbmVyLyBDb25maWcgQ2xpZW50IGNvbnRyb2wuDQoNCj4gIAlsX2Rl
YnVnKCIoJXgpICVwIiwgYXBwX2lkeCwga2V5KTsNCj4gIAlsX2RlYnVnKCJuZXRfaWR4ICV4Iiwg
bmV0X2lkeCk7DQo+ICANCg==
