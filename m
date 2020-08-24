Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8843C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74634206B5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 15:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="R99cbgnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXPEP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:04:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:50708 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgHXPEM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 11:04:12 -0400
IronPort-SDR: zh6zJ0Z5U2tHlQVa2TPoc7Cf4dH9FQ8LfNNX+1qvHR0GQGJNSfHLJPZKaRYaEqZ2kSzUdDX6N/
 cO5ET6zrD/VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="173956284"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="173956284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:04:07 -0700
IronPort-SDR: moR5Yp5G/6o3VTmRDM3ez0UtugBjrHycSTu9lteaTIzN++GtXwgOO+ZJSyEDu0vkS9bAQ3EaMG
 9wYti9OlmJ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="336199094"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2020 08:04:07 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 08:04:06 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 08:04:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 08:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPfYB/3QN0KjthoLxHPAJP4Ynl5K/QK+iEf+Y/THk/CTfaWwR/GrDr20G39Umqt4jvjog+32ZOrFibKUUkqYIb58KhbuZA991ReWmRho8RTb4ctQuDIZDXVS9I/r4noOu8xZ8q9yPOqveUJEVapWmBYWOBmeCDWN//MSvOe9WJvuz/8OhQ9LXjIS7GILbViyfP3hSlghhhY5mPN3h7gf7sxIwozSLRJtsRt5vub2Z336O1aKkjshT1x8lMkgAmsP3D0tGosXR/4yvCMd3F04inWss1zFsFMXxUpkFAiCzeT4/p6+pfADlOq+xF9ufroKBnFOQN/kLSZwn2jwQdrgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEanj//a9v3pn8naZLf8Gqfmes1X3zWnQLYl8CndmWA=;
 b=MTvyoee7ot1B2EMAXCQ2+epoPb5oEFLKMqQiz+ao+1zl8TedtMoogRc0jY7nRidQpKN5PXO3+YbCSY+os7tq+TN5wIaAeyR/fnE2H9cBatbqL5e7OuMSTUOV5UfPpEt8yiLlsz/51KwgjXhI3BQyj3k2pIYZJ9XZR4lemwcEJsXvfxG5VKvxEyz6zhOQncoZqIGI63rjT1jKEupqXZoWH9r2dIpWqxI2a457Nm3fdmfLvFTkeCy3KXqvu4Klm8L0/ztAu4KHAu+yfl0Sk1zjVRSYYB1/cBAvyAmAlGiYX/rXbs6fSiW54YzCtMo7dDnHhYvtgFAemIEcBMoz9K1uCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEanj//a9v3pn8naZLf8Gqfmes1X3zWnQLYl8CndmWA=;
 b=R99cbgnkThZcCDHrl8lKsnSUaFaXlWrWP/AEN4mNltSe1QtEXvLUIHQfIMuxFlpOorKpca6XESW0n0XLd8XO0wlgNmqKlETFa3EgEHLIkMl7Lj0W68FiipQoicZEZ5uMp7GFYOZLg+cXDnbsUn5sFywbTbd1Tk/H9IoL4MJxnco=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1438.namprd11.prod.outlook.com (2603:10b6:301:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 15:04:05 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 15:04:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ 1/4] doc/mesh-api: Add "options" dictionary to
 Send/Publish
Thread-Topic: [PATCH BlueZ 1/4] doc/mesh-api: Add "options" dictionary to
 Send/Publish
Thread-Index: AQHWecpArCBCyLTwGkGlFXRwZUIh1qlHXAgA
Date:   Mon, 24 Aug 2020 15:04:05 +0000
Message-ID: <d4d15630945c28e040a68002d91cebed692b2832.camel@intel.com>
References: <20200824035415.13420-1-inga.stotland@intel.com>
         <20200824035415.13420-2-inga.stotland@intel.com>
In-Reply-To: <20200824035415.13420-2-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631ddbed-6b95-44d8-c443-08d8483ef1cd
x-ms-traffictypediagnostic: MWHPR11MB1438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1438E9551B3A24E00DC13185E1560@MWHPR11MB1438.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZKdFrJFFFxgmH32fbilFldykqHaj2hRm1vZ7Hz0SYqxvEphxGOcXU2ufr6WaUPlOU6ZBEQpjuvZ5moLl1bPh++P0GKiSWwWgbYgDMJbIHUFxEXcHyQMR73T1xaoxGR0eiuccRcjLY09GGGTq25wNSMJ8b0uzeJm4nU8CnG4Z+Fn73z5xFX7AcC7CW+8mG5Df8kt/APrx5p5iBqVRwHT/zzt5AQEe8OpENMpO6/ErAYMjUoEX63drSjj9WEjCcqhf0Cfod5rIYtl1nfLEkQmL8RxbhqHr+z6PU9Fox3wuF+uSslb9zcxwTSWMhirqzdYalBQQ7sy2zaeiAZXfkHtyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(2616005)(6506007)(71200400001)(83380400001)(6486002)(6636002)(8936002)(5660300002)(36756003)(86362001)(4326008)(6512007)(8676002)(110136005)(64756008)(91956017)(2906002)(66556008)(66946007)(316002)(26005)(66446008)(478600001)(76116006)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HZTvbjB2A8U2Kz/A614ahNNF24nfhNtSrdFV/6+uv5Re9gN6/fUfsJVpJzL4gmiL+cyDeuwv9KGXpP9lIyOgMIRXsS4f5kdBEjklZW4s6N877ixHteGNwyopHHQhGCVgNZo7lfALOEGHYnExo0v1zdENC9cKjdu0lV43AEBcIiZnEgdkNgtBXqOSSlpoALqWjfFyXa2wpsLhRVSr/8Nvsw018TC2L4hX0+Nh5Zk/DoZ5rXq+qPuzWAeda4Cnz/fr3iNt/eC/i7HS9iShvd0XD5eD2rGOXxhPx1k/0sOmBbLIB3Mxm3V9ZbBK3xanvuYRh8VjACJ+eGEL6nm+6SxpyvsqEtu6YJlILlVBFUttiwMUfMEDSJi3i5p/LoEVkTjK/p1A8jJVm7dXCpHwNRKA3nxWzDK587+yHWncU4ZxSMRYEHBOc37xizJmirnv7hGkGFmOz1VpsgF6woeWYxp3VBG03+OS9e+mUsx2lqCIiQvzLBo2AW7j0nnftw7M06RpgHiOXeNksNf5UdNE13KnpVYOsWAZcE3hOCNGhmPVGPq+irCNL+bpAh8wszzMSrCUwLNFl98KiGVoW9mrxn0Hm4cwE9PTCypAW12wOK75gQP4gwwqJiXAHSDRrgMQQPc1wV3CypyygwFNiXbElGJjZQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <802282A8C02B454ABBDB5D514CEE81DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631ddbed-6b95-44d8-c443-08d8483ef1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 15:04:05.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hW+VZe6dJ/r4OStTW0hzrRPx4ar93QQCX3e6YpvfOVLQniq6NYAObVXRSA8Tk+fj8B42FotbTrVpNFzPF46ISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1438
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gU3VuLCAyMDIwLTA4LTIzIGF0IDIwOjU0IC0wNzAwLCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0K
PiBUaGlzIG1vZGlmaWVzIFNlbmQsIERldktleVNlbmQsIFB1Ymxpc2ggJiBWZW5kb3JQdWJsaXNo
IG1ldGhvZHMNCj4gb24gbWVzaC5Ob2RlIGludGVyZmFjZSB0byBpbmNsdWRlIGFkZGl0aW9uYWwg
YXJndW1lbnQgIm9wdGlvbnMiLg0KPiBUaGlzIG5ldyBhcmd1bWVudCBpcyBhIGRpY3Rpb25hcnkg
dGhhdCBjdXJyZW50bHkgaGFzIG9ubHkgb25lDQo+IG5ldyBrZXkgd29yZCBkZWZpbmVkOg0KPiAg
ICAgIkZvcmNlU2VnbWVudGVkIiAtIHRvIGZvcmNlIHNtYWxsIHBheWxvYWRzIHRvIGJlIHNlbnQg
YXMNCj4gICAgIAkJICAgICAgb25lLXNlZ21lbnQgbWVzc2FnZXMNCj4gDQo+IE90aGVyIGtleSB3
b3JkcyBtYXkgYmUgZGVmaW5lZCBpbiBmdXR1cmUgdG8gYWNjb21tb2RhdGUgZXZvbHZpbmcNCj4g
cmVxdWlyZW1lbnRzIG9mIE1lc2ggUHJvZmlsZSBzcGVjaWZpY2F0aW9uLg0KPiAtLS0NCj4gIGRv
Yy9tZXNoLWFwaS50eHQgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL21lc2gtYXBpLnR4dCBiL2RvYy9tZXNoLWFw
aS50eHQNCj4gaW5kZXggNDk1Zjk1YjBiLi5mODM2MTQyYTcgMTAwNjQ0DQo+IC0tLSBhL2RvYy9t
ZXNoLWFwaS50eHQNCj4gKysrIGIvZG9jL21lc2gtYXBpLnR4dA0KPiBAQCAtMjI5LDcgKzIyOSw3
IEBAIE9iamVjdCBwYXRoCS9vcmcvYmx1ZXovbWVzaC9ub2RlPHV1aWQ+DQo+ICANCj4gIA0KPiAt
CXZvaWQgUHVibGlzaChvYmplY3QgZWxlbWVudF9wYXRoLCB1aW50MTYgbW9kZWwsIGFycmF5e2J5
dGV9IGRhdGEpDQo+ICsJdm9pZCBQdWJsaXNoKG9iamVjdCBlbGVtZW50X3BhdGgsIHVpbnQxNiBt
b2RlbCwgZGljdCBvcHRpb25zLA0KPiArCQkJCQkJCWFycmF5e2J5dGV9IGRhdGEpDQo+ICANCj4g
IAkJVGhpcyBtZXRob2QgaXMgdXNlZCB0byBzZW5kIGEgcHVibGljYXRpb24gb3JpZ2luYXRlZCBi
eSBhIGxvY2FsDQo+ICAJCW1vZGVsLiBJZiB0aGUgbW9kZWwgZG9lcyBub3QgZXhpc3QsIG9yIGl0
IGhhcyBubyBwdWJsaWNhdGlvbg0KPiBAQCAtMzU4LDYgKzM3NSwxNyBAQCBNZXRob2RzOg0KPiAg
CQlUaGUgbW9kZWwgcGFyYW1ldGVyIGNvbnRhaW5zIGEgbW9kZWwgSUQsIGFzIGRlZmluZWQgYnkg
dGhlDQo+ICAJCUJsdWV0b290aCBTSUcuDQo+ICANCj4gKwkJVGhlIG9wdGlvbnMgcGFyYW1ldGVy
IGlzIGEgZGljdGlvbmFyeSB3aXRoIHRoZSBmb2xsb3dpbmcga2V5cw0KPiArCQlkZWZpbmVkOg0K
PiArDQo+ICsJCQlib29sIEZvcmNlU2VnbWVudGVkDQo+ICsJCQkJU3BlY2lmaWVzIHdoZXRoZXIg
dG8gZm9yY2Ugc2VuZGluZyBvZiBhIHNob3J0DQo+ICsJCQkJbWVzc2FnZSBhcyBvbmUtc2VnbWVu
dCBwYXlsb2FkLiBJZiBub3QgcHJlc2VudCwNCj4gKwkJCQl0aGUgZGVmYXVsdCBzZXR0aW5nIGlz
ICJmYWxzZSIuDQo+ICsNCj4gKwkJVGhlIGRhdGEgcGFyYW1ldGVyIGlzIGFuIG91dGdvaW5nIG1l
c3NhZ2UgdG8gYmUgZW5jeXB0ZWQgYnkgdGhlDQo+ICsJCW1lc2hkIGRhZW1vbiBhbmQgc2VudCBv
bi4NCj4gKw0KPiAgCQlTaW5jZSBvbmx5IG9uZSBQdWJsaXNoIHJlY29yZCBtYXkgZXhpc3QgcGVy
IGVsZW1lbnQtbW9kZWwsIHRoZQ0KPiAgCQlkZXN0aW5hdGlvbiBhbmQga2V5X2luZGV4IGFyZSBv
YnRhaW5lZCBmcm9tIHRoZSBQdWJsaWNhdGlvbg0KPiAgCQlyZWNvcmQgY2FjaGVkIGJ5IHRoZSBk
YWVtb24uDQo+IEBAIC0zNjcsNyArMzk1LDcgQEAgTWV0aG9kczoNCj4gIAkJCW9yZy5ibHVlei5t
ZXNoLkVycm9yLkludmFsaWRBcmd1bWVudHMNCj4gIA0KPiAgCXZvaWQgVmVuZG9yUHVibGlzaChv
YmplY3QgZWxlbWVudF9wYXRoLCB1aW50MTYgdmVuZG9yLCB1aW50MTYgbW9kZWxfaWQsDQo+IC0J
CQkJCQkJYXJyYXl7Ynl0ZX0gZGF0YSkNCj4gKwkJCQkJCWRpY3Qgb3B0aW9ucywgYXJyYXl7Ynl0
ZX0gZGF0YSkNCg0KSSB3b25kZXIgaWYgd2Ugc2hvdWxkIHRha2UgdGhpcyBvcHBvcnR1bml0eSB0
byBlbGltaW5hdGUgdGhpcyBNZXRob2QgaW4gZmF2b3Igb2YgYWRkaW5nIGEgVmVuZG9yIGtleSB0
byB0aGUgbmV3DQpkaWN0aW9uYXJ5IGluIFB1Ymxpc2goKS4gIElmIHRoZSBrZXkgaXMgbWlzc2lu
ZywgdGhlbiBmcm9tIHRoZSBkaWN0aW9uYXJ5IGluIFB1Ymxpc2goKSwgdGhlbiBpdCBpcyBhIFNp
Zw0KZGVmaW5lZCBtb2RlbCwgYW5kIGlmIHByZXNlbnQsIHRoZW4gaXQgb3BlcmF0aW5nIGxpa2Ug
dGhlIGN1cnJlbnQgUHVibGlzaFZlbmRvcigpLiAgVGhpcyB3b3VsZCBzaW1wbGlmeSB0aGUNCmNv
ZGUgaW4gdGhlIGRhZW1vbiwgYW5kIG1ha2UgYSBzbWFsbGVyIGNvZGUgZm9vdHByaW50Lg0KDQo+
ICANCj4gIAkJVGhpcyBtZXRob2QgaXMgdXNlZCB0byBzZW5kIGEgcHVibGljYXRpb24gb3JpZ2lu
YXRlZCBieSBhIGxvY2FsDQo+ICAJCXZlbmRvciBtb2RlbC4gSWYgdGhlIG1vZGVsIGRvZXMgbm90
IGV4aXN0LCBvciBpdCBoYXMgbm8NCj4gQEAgLTM4Myw2ICs0MTEsMTcgQEAgTWV0aG9kczoNCj4g
IAkJVGhlIG1vZGVsX2lkIHBhcmFtZXRlciBpcyBhIDE2LWJpdCB2ZW5kb3ItYXNzaWduZWQgTW9k
ZWwNCj4gIAkJSWRlbnRpZmllci4NCj4gIA0KPiArCQlUaGUgb3B0aW9ucyBwYXJhbWV0ZXIgaXMg
YSBkaWN0aW9uYXJ5IHdpdGggdGhlIGZvbGxvd2luZyBrZXlzDQo+ICsJCWRlZmluZWQ6DQo+ICsN
Cj4gKwkJCWJvb2wgRm9yY2VTZWdtZW50ZWQNCj4gKwkJCQlTcGVjaWZpZXMgd2hldGhlciB0byBm
b3JjZSBzZW5kaW5nIG9mIGEgc2hvcnQNCj4gKwkJCQltZXNzYWdlIGFzIG9uZS1zZWdtZW50IHBh
eWxvYWQuIElmIG5vdCBwcmVzZW50LA0KPiArCQkJCXRoZSBkZWZhdWx0IHNldHRpbmcgaXMgImZh
bHNlIi4NCj4gKw0KPiArDQo=
