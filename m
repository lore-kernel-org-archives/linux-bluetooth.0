Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 21:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E9C2075A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 21:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KpDeOmBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgFVVjg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:39:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:20724 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgFVVje (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 17:39:34 -0400
IronPort-SDR: uobP+1zHqQ26W99oP0tL4I9gqkjGDBS2Z870cZYl/ueKiEQMIyo29DkWm4WYEQGc+EaPyXcGw/
 uhRxl9GL9/fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="205375953"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="205375953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:39:29 -0700
IronPort-SDR: T7twGGS6n3CwjSG2NlrteQareUJYzBAwyn/+EG3rtMrrP4MbL7vbfta0XDg5gj0ustHlTcwQ01
 9Tx759bEjhSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318901536"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 14:39:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jun 2020 14:39:27 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 22 Jun 2020 14:39:27 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Jun 2020 14:39:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jun 2020 14:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be7vLUE2iwkcGMO4biyQfttVdZsLiWSL+s0vms4m2d/2+NKTL8wugfs2WuaNqaiFXdte/XxXAnm2iLtcw8SLTccDJQ+cOZiGDuDCA5LvVF5Wjl0eJrDLdvZ8EEC6+2TLP8fcBQawNgHEINF6wpvrcy1myRI/JjFSigMxTI1oRyB3vGScN90IlWKJVLZhpL/fd5y72JcO8l6m1XVB0JxMCyD2SUGCI+FyI80CJwF3gDmXLsOjqv8FRErRF0a8kXRlL59C1dNimgaMc8ewrmU0wbh3/bme/oOH+1U6weaozUwIbYSabwIxc/MvEOpToRuenAZxsY71UaphwmV8loohzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciYaXdxd94hGStHWre9mBDezEFPEhon4kcV1q74Em+E=;
 b=mHioxUUizxtd2eNQSpzPxNO+x8i8Kyxg+LWMS6xTgv23LB/zQVP2icujdoKbgdDTSBZaDG+4RZlvafrS8ygOrlxsPR/44GqZjrdGVqD5nIe0JFfOZr4DUmJWyaCGgzYDvuWn6wDFPZKWHX3hxpNvgrQ/RNgqEhPO/CsWcWvir34NUMUKRbB5uROmDS9SqjbCDxiD7wr8AVAKCJD7Xt0Yo5vfmmGkM/F24dsd/yuvIm3Bze7JuBVQgEeYsaAJt0hoDGKMkxlgtRl67dmGP/gBZW18f0uJbqxXJF+C9qyrHOyiW/zGFbB1nqK6ZrCr9s1HwnGToR0x7/yNXHv6omdjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciYaXdxd94hGStHWre9mBDezEFPEhon4kcV1q74Em+E=;
 b=KpDeOmBp5WCXG36saOc78Bqt9peCfCkN2vwmQHrveOXEwDU/Yi6yuEm/0IK/NgmE1rMn5KpeBO65WLBzhxte+wgj+pfhixCHCad7nSs/e2R9mX9SBC+beALgJQxAre26+MKwB8vLMmxop9npOO6PQJE+JnPowL9IB8iR702BKJY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2029.namprd11.prod.outlook.com (2603:10b6:300:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 21:39:22 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 21:39:22 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/3] Blacklist addresses of deleted nodes
Thread-Topic: [PATCH BlueZ 0/3] Blacklist addresses of deleted nodes
Thread-Index: AQHWRoBmLkjLDOfFV0yMXSvgjbvYNKjlLiyA
Date:   Mon, 22 Jun 2020 21:39:22 +0000
Message-ID: <5d5f42a5ce0c54be661dd1f24a22c2bc7c9b2513.camel@intel.com>
References: <20200619212655.107839-1-inga.stotland@intel.com>
In-Reply-To: <20200619212655.107839-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88ec234d-699a-4754-f928-08d816f4ba18
x-ms-traffictypediagnostic: MWHPR11MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB202912311CC80FEFF9233D03E1970@MWHPR11MB2029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ojs+jYSEhskhHzHha4HFk+MTZue4lGhSrGAyWqHSPQnNpP3X2GzvSKidT0QMRNU75KXOt4NcxgAyQclMQgg6ktwQpOe9VWu+Az8+fUMmM7tcvtGHEleWKKQ1RbAqHht8krYE2GGDT/+SnQBgu4F59d3MnMwMroRACBmOIPyh0nQHa2fS1Lc5+MrgW8yuIU5tXEnb1nihvYS1ytL6zOaHiKP5O42+qID1PZyXvxHZ32JbxINE3HEmNQLT9vkNZcLx8uSWc5fOElOrsPFmVukbpx3wSSXK4Eo17Grm6U3akaF2zmN8fP+UH9v62a3yoekJh9VVomPYRaC9pxkptecpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(110136005)(6512007)(36756003)(6486002)(478600001)(186003)(6506007)(2616005)(316002)(6636002)(26005)(2906002)(91956017)(4744005)(86362001)(66446008)(66476007)(66946007)(5660300002)(83380400001)(66556008)(64756008)(8936002)(8676002)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pP2EZs76S8dZjoW4W7r/1vdP4QHNxf1E0lgr3HuN55PBpcse4xYPRf2FhO/RT1Nvu5PkBtK3rMZQKjV5N0XhhQRlCbet7z39U56/YfK6xBjiq2K/xphQvyRhRhuxWPVAtsKMEuSTewoeTVCixF8x7WQgSZNZ1hLBzuXz50Mkaed70CBlzWGWDZQu5sDgQVPVK1zsugxrTEDCfKbNN3MRWXtlgLMzPfKI8x9iJTt5GOJ6Fa1yxDPyUjgouPfdIU49Fu476Ih6eKNwrqE4UQgM+B7R0A7CZPd0cXqp+/lfu8La18CKyvOs+hj8w+H2kec7zcA8wzDeUxLjuaRWNDZAsyZy+7fs6qE0myyK8fV7uScxmevQcQHKTVspzu3pbb61BIVfzvqRe6D6XfbEAusshqhQb2YxqxTAxNd+yjJwrZ2n9fbeROrfQ8tWbcngX2SK13myFdvzdkb+KyLj6dXXamJMunWd+yqau95wJZJLNOg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <924A6DB233EB164DAA31323600C20788@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ec234d-699a-4754-f928-08d816f4ba18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 21:39:22.2198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKGEqLexIw3MgdhPu478bbsD5PufjpceOMaTQx9PV/lD/2T6+TS2R5hCDLwDoX0/wX0iCgYed7XRh0zt5bJ1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2029
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gRnJpLCAyMDIwLTA2LTE5IGF0IDE0OjI2IC0wNzAwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBhZGRzIGEgbm90aW9uIG9mIGJsYWNr
bGlzdGVkIGFkZHJlc3NlcyBmb3Igbm9kZXMgdGhhdA0KPiBoYXZlIGJlZW4gcmVtb3ZlZCBmcm9t
IG1lc2ggbmV0d29yay4NCj4gVGhlIGFkZHJlc3NlcyBvZiBub2RlcyB0aGF0IGhhdmUgYmVlbiBy
ZW1vdmVkIHNob3VsZCBub3QgYmUgYWRkZWQNCj4gYmFjayBpbnRvIGF2YWlsYWJsZSB1bmljYXN0
IGFkZHJlc3NlcyBwb29sIChmb3IgYXNzaWduaW5nIHRvIG5ld2x5DQo+IHByb3Zpc2lvbmVkIG5v
ZGVzKSB1bnRpbCBtZXNoLXdpZGUgSVYgSW5kZXggaXMgY2hhbmdlZCBhdCBsZWFzdCB0d2ljZSAN
Cj4gDQo+IEluZ2EgU3RvdGxhbmQgKDMpOg0KPiAgIG1lc2g6IEVtaXQgUHJvcGVydGllc0NoYW5n
ZWQgd2hlbiBJViBJbmRleCBjaGFuZ2VzDQo+ICAgdG9vbHMvbWVzaC1jZmdjbGllbnQ6IGdldC9z
ZXQgSVYgaW5kZXgNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogYWRkIGxpc3Qgb2YgYmxhY2ts
aXN0ZWQgYWRkcmVzc2VzDQo+IA0KPiAgbWVzaC9uZXQuYyAgICAgICAgICAgICB8ICAgMiArDQo+
ICBtZXNoL25vZGUuYyAgICAgICAgICAgIHwgICA5ICsrKw0KPiAgbWVzaC9ub2RlLmggICAgICAg
ICAgICB8ICAgMSArDQo+ICB0b29scy9tZXNoLWNmZ2NsaWVudC5jIHwgIDQxICsrKysrKysrKy0N
Cj4gIHRvb2xzL21lc2gvbWVzaC1kYi5jICAgfCAxNzAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIHRvb2xzL21lc2gvbWVzaC1kYi5oICAgfCAgIDUgKy0NCj4g
IHRvb2xzL21lc2gvcmVtb3RlLmMgICAgfCAxMTAgKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gIHRvb2xzL21lc2gvcmVtb3RlLmggICAgfCAgIDMgKw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAz
MjkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0K
