Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73071C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEB220757
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 14:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="K0RCqper"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbgDBOxz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:53:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:43739 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbgDBOxz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 10:53:55 -0400
IronPort-SDR: 1hEwfIiWDFgnAwJjbkldYHLjzFMcgKMo2FQGxuOEZHvuPQF0hfxagiZLz6WedQEBpS4DRrFEQm
 17O+TWvdEBow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 07:53:54 -0700
IronPort-SDR: 9/l2mtuJXte0ZzpR9m8dpV0i7nFGF8aWNL2/R4fGDx4a3/6Jqgp4V8YSSyZr5mAswsjBNmJN/G
 o6TpB4u0WNCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="423157677"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2020 07:53:54 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Apr 2020 07:53:53 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Apr 2020 07:53:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Apr 2020 07:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek8Ra0Po2xB1diutm4ZDbHcCh+7nlT9A5sMnDOQ4SMv7uMB/MVEbfPLCzs9+xK7dEXnb9I6covS8FWr4M4B72xE7uWP/LZox68+nJEeLX7r4czUrJVV8+hwoBo9uajCIH/Q0hpHmFuJOOnpi9D/n2TVQ94PitVmBUfDRIN2y7mc0JqeLqkmYx0CofPS2DC4En+sQLt36kYGwI5EQ3m4jE91DV9Fk5ZJouuOw1trc++AtLwhWQu952pPL3NEXAHEdiTmtN9kXJh7d7dtp5cJjIgSgUPfWn/TIZSlVOYRFzmVa6YTjPAcfp+x7FqR5Y1sP/71O9+CXaMM6uMzPPxs4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktw0ps0TrV91eS+4p9juFxMmy44my8U5cAWDC/rkSPs=;
 b=dxWsOsppEOhq2e4+N83BH5z8RaDGLiOXwArjVq3j3RhkyRHYDp5EvFC1OsbYy4bCwDdeT1dFnwkmhiG/HYEbDXCzbjGG7zZ3rJYaffotxwssdVex2CpdIayjA+779Pqzp+Sbh8FqACEV5ub5kRARgvZ25YpcUb4GUq0Gwh5q6gS/V+3JzxtrFHbSv8DtxUvDxTpwpGMJaLDn8kYgCB3bxosqi1kKBMjqqh6RUTJ6XHS9lPon9o2Iyq4zja+Gnq6N7bA1lou0vFgjWboMb/tXBdhLv05JfPZyw9ejM8b/LiKqZxVFkKlEkQVASVfNZrEsklcEFpZKtmtGcpVUOwa8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktw0ps0TrV91eS+4p9juFxMmy44my8U5cAWDC/rkSPs=;
 b=K0RCqperwYNDScKYRJAWlg/iINB+Fqjx9bbyFdnQylA8D6BoGMh9+QqxhVD2nZrtcW+TQe09OhBPMHHhWShha+/QfDWtAkTa1oPD7/TPNNk6thvszEytHw8Zer3lnXmBROxuvhaF1B2bET1JcEcsUNDcqNhSxgqTn0ESna2Yrhg=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 14:53:51 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 14:53:51 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "nitin.j@samsung.com" <nitin.j@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>
Subject: Re: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Thread-Topic: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Thread-Index: AQHWCBzUCLdKS+ksE06MAFe9MVMWf6hkY/EAgAF7UYCAAA2PgA==
Date:   Thu, 2 Apr 2020 14:53:51 +0000
Message-ID: <9038a2fe4daafd90def2444d71c8914c6a64a688.camel@intel.com>
References: <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
         <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
         <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcms5p3>
         <20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa@epcms5p3>
In-Reply-To: <20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa@epcms5p3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 056acae6-b03c-47ea-2fb3-08d7d715a8a4
x-ms-traffictypediagnostic: MW3PR11MB4524:
x-microsoft-antispam-prvs: <MW3PR11MB45249EFD49AEF58AEBECAEF2E1C60@MW3PR11MB4524.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(396003)(39860400002)(366004)(346002)(71200400001)(6506007)(66446008)(91956017)(478600001)(54906003)(81166006)(8676002)(64756008)(66556008)(86362001)(66946007)(6512007)(66476007)(81156014)(8936002)(6916009)(36756003)(6486002)(186003)(2906002)(66574012)(316002)(4326008)(76116006)(2616005)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ca3Q6f4Z9SPvzW4+S7UZqRBRz+Id8aFfN0m9EbLWzBPYIZirk/0kdIHVykFfcYoN9vkmNurhVZ8UHbJdjZ+1BzgfCz/PdzkCAa6U3HnFRM5O7ZPL1YnvkMKc1hk2PUDZ4ZzKuMpdfmVaOTZKd+/WKw3Y1tL6l5LH24BegHOjwTxj2tSb0ixi/D1YkgGmddnl1cWJLz2GfpHCjQl7Mouysh+AX/4e/JWkFk8mbjoR4OriwsSyLo+ev0yAeks93bTySi5n0ou8dWRQCKuIiIdJJY2XLaEwKokxGL3/SlfldgD3lmSFX1ZAVQWMScf2zP85PkEmYVTvU39VQm8y4LXrELyNkEwfMDPWX4QixvvzF/zlKWY3piz07qTuPOcZ1e9LKdq61gEl3UEkZpKN2wvxuHRsMEbAGieMmKb82NscR9R5pGvXxZA1/7a4fEy0CO7L
x-ms-exchange-antispam-messagedata: IhaRQb6CSTcNUagjdGcqHyqAwLGbCyxIkU8f9mBilQr8B6vH9lSQHB6jmD1GKyupCYDGQgWl7g6PzHXiu6mtHXs4D09ocGmfLF5JhYwvXSgaInA/5dyassGAhjiwlaXlKg8iz2mdXSjcLWiDero/Lg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B08400D6C5B7DE4D82EAD0126AE02DB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 056acae6-b03c-47ea-2fb3-08d7d715a8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 14:53:51.7990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hExpgDoBZWNThsIuYI+uw1P7LcOe2ttWTt43Px298HOEp3sL1WDq/BM0hMr0yGKVU0PN04et83oUyfm1HdvQrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQW51cGFtLA0KT24gVGh1LCAyMDIwLTA0LTAyIGF0IDE5OjM1ICswNTMwLCBBbnVwYW0gUm95
IHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+ID4gSGkgQW51cGFtLA0KPiA+IE9uIFdlZCwgMjAy
MC0wNC0wMSBhdCAxNjo1MCArMDUzMCwgQW51cGFtIFJveSB3cm90ZToNCj4gPiA+IFRoaXMgcGF0
Y2ggYWRkcyB2YWxpZGF0aW9uIG9mIG5ldCBrZXkgaW5kZXgsIHdoaWNoIHdpbGwgYmUNCj4gPiA+
IHVzZWQgdG8gc2VuZCBtZXNzYWdlIHRvIG5vZGVzLiBSZXR1cm4gZXJyb3IgaW4gY2FzZSBuZXQg
a2V5IGluZGV4DQo+ID4gPiBpcyBub3QgdmFsaWQuIFRoaXMgYXZvaWRzIG1lc3NhZ2UgZW5jcnlw
dGlvbiB1c2luZyBkZXZpY2Uga2V5DQo+ID4gPiBhbmQgZnVydGhlciBwcm9jZXNzaW5nIG9mIHRo
ZSBtZXNzYWdlLg0KPiA+ID4gLS0tDQo+ID4gPiAgbWVzaC9tb2RlbC5jIHwgOSArKysrKysrKysN
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRp
ZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gPiA+IGluZGV4IDk0NTU4
MzMuLjZjYzFkYzUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9tZXNoL21vZGVsLmMNCj4gPiA+ICsrKyBi
L21lc2gvbW9kZWwuYw0KPiA+ID4gQEAgLTU0Niw2ICs1NDYsNyBAQCBzdGF0aWMgYm9vbCBtc2df
c2VuZChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBib29sIGNyZWRlbnRpYWwsIHVpbnQxNl90IHNy
YywNCj4gPiA+ICAJdWludDhfdCBkZXZfa2V5WzE2XTsNCj4gPiA+ICAJdWludDMyX3QgaXZfaW5k
ZXgsIHNlcV9udW07DQo+ID4gPiAgCWNvbnN0IHVpbnQ4X3QgKmtleTsNCj4gPiA+ICsJc3RydWN0
IGtleXJpbmdfbmV0X2tleSBuZXRfa2V5Ow0KPiA+ID4gIAl1aW50OF90ICpvdXQ7DQo+ID4gPiAg
CXVpbnQ4X3Qga2V5X2FpZCA9IEFQUF9BSURfREVWOw0KPiA+ID4gIAlib29sIHN6bWljID0gZmFs
c2U7DQo+ID4gPiBAQCAtNTc4LDggKzU3OSwxNiBAQCBzdGF0aWMgYm9vbCBtc2dfc2VuZChzdHJ1
Y3QgbWVzaF9ub2RlICpub2RlLCBib29sIGNyZWRlbnRpYWwsIHVpbnQxNl90IHNyYywNCj4gPiA+
ICAJCX0NCj4gPiA+ICANCj4gPiA+ICAJCW5ldF9pZHggPSBhcHBrZXlfbmV0X2lkeChub2RlX2dl
dF9uZXQobm9kZSksIGFwcF9pZHgpOw0KPiA+ID4gKwkJaWYgKG5ldF9pZHggPT0gTkVUX0lEWF9J
TlZBTElEKSB7DQo+ID4gPiArCQkJbF9kZWJ1Zygibm8gbmV0IGtleSBmb3IgKCV4KSIsIG5ldF9p
ZHgpOw0KPiA+ID4gKwkJCXJldHVybiBmYWxzZTsNCj4gPiA+ICsJCX0NCj4gPiANCj4gPiBUaGlz
ICptaWdodCogYmUgYSB2YWxpZCAic2FuaXR5IiB0ZXN0Li4uICBBbHRob3VnaCBhbiBBcHAgS2V5
IHNob3VsZCBuZXZlciBiZSBhbGxvd2VkIHRvIGJlIGFkZGVkLCBvciBleGlzdA0KPiA+IHVubGVz
cyB0aGUgYm91bmQgbmV0a2V5IGFscmVhZHkgZXhpc3RzLiAgSSB0aGluayB0aGUgb25seSB3YXkg
YW4gQXBwIEtleSBtaWdodCBleGlzdCB3aXRob3V0IGl0J3MgYm91bmQNCj4gPiBuZXRrZXkNCj4g
PiBpcyBpZiB0aGUgZGFlbW9uIHByaXZhdGUgbm9kZS5qc29uIGZpbGUgd2FzIGhhbmQgZWRpdGVk
LCB3aGljaCBpcyBub3QgdGVjaG5pY2FsbHkgYWxsb3dlZC4NCj4gPiANCj4gPiA+ICAJfQ0KPiA+
ID4gIA0KPiA+ID4gKwlpZiAoIWtleXJpbmdfZ2V0X25ldF9rZXkobm9kZSwgbmV0X2lkeCwgJm5l
dF9rZXkpKSB7DQo+ID4gPiArCQlsX2RlYnVnKCJubyBuZXQga2V5IGZvciAoJXgpIiwgbmV0X2lk
eCk7DQo+ID4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gPiArCX0NCj4gPiANCj4gPiBUaGlzIGNo
ZWNrIGlzIGludmFsaWQuIE9ubHkgYW4gYXV0aG9yaXplZCBDb25maWcgQ2xpZW50cyAvIFByb3Zp
c2lvbmVycyBoYXZlIEtleSBSaW5ncywgd2hpY2ggaXMgdXNlZCB0bw0KPiA+IHNlbmQNCj4gPiBB
ZGRLZXksIFVwZGF0ZUtleSBhbmQgUHJvdmlzaW9uaW5nIGRhdGEgdG8gcmVtb3RlIG5vZGVzLiAg
VGhlIGtleXJpbmcgaXMgcmVzdHJpY3RlZCB0byBub2RlcyB3aGljaCBoYXZlDQo+ID4gZnVsbA0K
PiA+IG5ldHdvcmsgY29uZmlndXJhdGlvbiBwcml2bGVnZXMuLi4uICBBZGRpbmcgdGhpcyB3b3Vs
ZCByZXF1aXJlICphbGwqIG5vZGVzIGluIHRoZSBuZXR3b3JrIHRvIGJlIHByaXZsZWdlZA0KPiA+
IG5vZGVzLCB3aGljaCB3b3VsZCB0aGVuIGFsbG93IHRoZW0gdG8gbWFrZSBjaGFuZ2VzIG91dHNp
ZGUgdGhlIFByb3Zpc2lvbmVyLyBDb25maWcgQ2xpZW50IGNvbnRyb2wuDQo+ID4gDQo+ICBUaGFu
a3MgeW91IGZvciB5b3VyIGlucHV0LiBUaGUgaW50ZW50aW9uIHdhcyB0byB2YWxpZGF0ZSAnTmV0
IEtleSBJbmRleCcgZm9yIERldktleVNlbmQgbWVzc2FnZXMsIHNlbnQgYnkNCj4gKkNvbmZpZyBj
bGllbnQvUHJvdmlzaW9uZXIqIGFwcCBzcGVjaWZpY2FsbHkuDQo+ICBBY3R1YWxseSwgb25lIG9i
c2VydmF0aW9uIEkgaGFkIGlzIHRoYXQsIGV2ZW4gdGhvdWdoLCBDb25maWcgY2xpZW50IHN1cHBs
aWVzIHRoZSAnTmV0IEtleSBJbmRleCcsICYgZGFlbW9uDQo+IHBhc3NlcyBpdCBhbGwgdGhlIHdh
eSB0byBtc2dfc2VuZCgpLCBldmVudHVhbGx5LCBpdCBzZWVtcywgaXQgaXMgaWdub3JlZCAmIGVu
Y3J5cHRpb24ga2V5IGlzIHBpY2tlZCB1cCBmcm9tDQo+IHRoZSBwcmltYXJ5IHN1Ym5ldC4gQWxz
bywgSSBub3RpY2VkIHRoYXQgQ29uZmlnIGNsaWVudCBzZWVtcyB0byBhbGxvdyBkZWxldGluZyBh
IGNyZWF0ZWQgc3VibmV0IChzdWJuZXQtDQo+IGRlbGV0ZSA8bmV0IGtleSBpbmRleD4pIGF0IHBy
ZXNlbnQsIGF0IGFueSBwb2ludCBvZiB0aW1lLg0KDQpZb3UgYXJlIGNvcnJlY3QgaW4gZmluZGlu
ZyB0aGlzIGJ1Zy4uLiAgSXQgd2FzIGZvdW5kIGluIHBhcmFsZWxsIGJ5IFByemVteXPFgmF3IEZp
ZXJlaywgYW5kIHNob3VsZCBiZSBmaXhlZCBhcw0Kb2YgdGhpcyBjb21taXQ6DQoNCiAgIGNvbW1p
dCA4NGE5YjZjZTRiNjZhMmJhMjFjY2U4ZTRiMGMzYzZlMDk3YTU0OTNhDQogICBBdXRob3I6IFBy
emVteXPFgmF3IEZpZXJlayA8cHJ6ZW15c2xhdy5maWVyZWtAc2lsdmFpci5jb20+DQogICBEYXRl
OiAgIFR1ZSBNYXIgMzEgMTQ6MDk6MDggMjAyMCArMDIwMA0KDQogICAgICAgbWVzaDogQWRkIG5l
dCBrZXkgaW5kZXggdG8gc2FyIHN0cnVjdHVyZQ0KICAgICAgIA0KICAgICAgIFRoaXMgcGF0Y2gg
YWRkcyBuZXQga2V5IGluZGV4IHRvIHN0cnVjdCBtZXNoX3Nhci4gVGhpcyBmaXhlcyBwcm9ibGVt
IHdpdGgNCiAgICAgICB1c2luZyBpbnZhbGlkIG5ldHdvcmsga2V5IHRvIGVuY3J5cHQgYXBwbGlj
YXRpb24gbWVzc2FnZXMuDQoNCg0KSWYgeW91IGNoZWNrIG91dCB0aGUgY3VycmVudCB0aXAsIGhv
cGVmdWxseSBpdCB3aWxsIHNvbHZlIHRoZSBwcm9ibGVtIHlvdSBmb3VuZCB3aGVyZSB0aGUgaW5j
b3JyZWN0IChwcmltYXJ5DQpzdWJuZXQpIGtleSB3YXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSByZXF1
ZXN0ZWQgbmV0IGtleS4NCg0KPiAgSSBhbSBub3Qgc3VyZSBpZiAqTm90IHVzaW5nKiB0aGUgJ05l
dCBLZXkgSW5kZXgnIGJ5IHRoZSBkYWVtb24gaXMgYnkgZGVzaWduLg0KPiANCj4gQW55d2F5cywg
SSBnb3Qgd2hhdCB5b3UgZXhwbGFpbmVkIGFib3V0ICphdXRob3JpemVkIGFwcHMgaGF2aW5nIEtl
eXJpbmcgYWNjZXNzKi4gSW4gc3VjaCBjYXNlLCBJIHRoaW5rLCB0aGUNCj4ga2V5cmluZyBjaGVj
ayB3b3VsZCBtYWtlIHNlbnNlIG9ubHkgaW4gdGhlIGZvbGxvd2luZyBjb25kaXRpb24uIFBsZWFz
ZSBzaGFyZSB5b3VyIG9waW5pb24uIFRoYW5rcy4NCj4gCX0gZWxzZSBpZiAoYXBwX2lkeCA9PSBB
UFBfSURYX0RFVl9SRU1PVEUpIHsNCj4gICAgICAgICBpZiAoIWtleXJpbmdfZ2V0X3JlbW90ZV9k
ZXZfa2V5KG5vZGUsIGRzdCwgZGV2X2tleSkpDQo+ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4gCQkJDQo+ICAgICAgICAga2V5ID0gZGV2X2tleTsNCj4gCQkJDQo+IAkJLyoqIEFkZCBLZXkg
UmluZyBDaGVjayBmb3IgdmFsaWQgTmV0IEtleSBJbmRleCAqKi8NCj4gICAgICAgICB9DQo+IA0K
PiA+ID4gIAlsX2RlYnVnKCIoJXgpICVwIiwgYXBwX2lkeCwga2V5KTsNCj4gPiA+ICAJbF9kZWJ1
ZygibmV0X2lkeCAleCIsIG5ldF9pZHgpOw0KPiA+ID4gIA0K
