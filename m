Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CCC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 16:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B6420737
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 16:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="X7k1ShCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbgDBQXV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:23:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:54281 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389598AbgDBQXV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 12:23:21 -0400
IronPort-SDR: mwmiyjNBCM+ztr5Eyf8ox3GvvutMkI+FoIEIk0gD6E+Kdma7vl/wnYBAqvrmWDEzRL14sTFN7l
 l2L+Pv2YBP6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 09:23:20 -0700
IronPort-SDR: sVHX1m/q7lB/qubxKp/k/65stqKJN2Pea9orDDoKdi1vRuU0vMtY32+VfIr3Xs4kclzg2YbgA8
 8dafHuZASQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="284835400"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2020 09:23:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Apr 2020 09:23:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Apr 2020 09:23:19 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Apr 2020 09:23:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Apr 2020 09:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6sCDcP9ChpaqAQORAr+8jg5lqWVAESHzimiitBmaIxtceNP/sky47DIzW/IZWJBEyWdRmEluLryJkgSBJFuu7ymMBk7wCuVLF3fUmQs/HTbG/KOxvOHSfo171CiRmW900cz2Dqf+CKZFQWusUxZJsK3YuI3SZoxSm1K6L1REmsTGlh9vYvtdu5zgF1Cz08h8VDQOzh9s22gQQ8Ti6Pz66BCJbwnrl2YhHbdb83uxu+6DunrxO1wiN9fLAA3ALsjNv1JFlM3WQ1nHXAbQzowDN4TdtdBVm1Zs3ha5+3RNrUFCPzOrT/DlarnLVKBEHpR1BN7ZtU7QAEF6bXetj3U2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzVq6cAG6YVpKF9e80xkYrQXBT8IOZANSplT4RD1UHE=;
 b=RxnddnPv5vz1V4G/ZvVG3r0TiEmzIq8MORWpV8WubiyB5mlM362PpYKjHggCGWr70VqbiV3BS1/iLgIzM6iN1mS5DOwab8BB09QVZT396wjPtucL8EzZ2aydbi8w4VWmbXVO3DH6abNyer2xgtN/T69H627F09kK7cAlxGVXlVf76hu2llgrJLOtEI7WZ1dx8UJm1dXfZjVwnMb/WmpAc7rttqntFwN4r6qLpTzpVxvgP5UjDVgQDBy5OFHjilJFqvML/KtRf96Y91cUAvk5LlWQcPkt0bSRTUvDBm6vKsWpD5NonU6RWJjKbUQOoLXisqV6k/vwiD0PPcULc5Wayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzVq6cAG6YVpKF9e80xkYrQXBT8IOZANSplT4RD1UHE=;
 b=X7k1ShCoZowCbZ6HxxwMTqT3Do3dddHxj328+preSVb01DHREsZujlFVJ4Zb4E1EjjDlLMKOB1vaHmKdosj4Nzsw9fv17rRzv3w9INNrjdds6HEXZY2N4fSNAZP7ZFFciWwHgmUSDljn8MdY5r5SvtBYicruR7KT1V4kJCLZ1wA=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 16:23:15 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 16:23:15 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "nitin.j@samsung.com" <nitin.j@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>
Subject: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Thread-Topic: [PATCH BlueZ] mesh: Add check for valid netkey index
Thread-Index: AQHWCQsD9XmerQcL8E6Qct/cmiZXzQ==
Date:   Thu, 2 Apr 2020 16:23:15 +0000
Message-ID: <3aa08d9a552ab02b0495b2a3970405ee082c85de.camel@intel.com>
References: <9038a2fe4daafd90def2444d71c8914c6a64a688.camel@intel.com>
         <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
         <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
         <20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa@epcms5p3>
         <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcms5p5>
         <20200402160037epcms5p5c94d5798e7611c11e795c51bc39b5a6b@epcms5p5>
In-Reply-To: <20200402160037epcms5p5c94d5798e7611c11e795c51bc39b5a6b@epcms5p5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78206ba4-c60c-432a-fdc7-08d7d722258b
x-ms-traffictypediagnostic: MW3PR11MB4731:
x-microsoft-antispam-prvs: <MW3PR11MB4731046CCCB2C8DA38453DD8E1C60@MW3PR11MB4731.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(54906003)(81166006)(2906002)(8936002)(71200400001)(2616005)(81156014)(498600001)(6916009)(6512007)(64756008)(66446008)(91956017)(186003)(76116006)(6506007)(5660300002)(66556008)(36756003)(6486002)(26005)(8676002)(4326008)(66946007)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39hgTtQd5x/JPDrnn75yBvj8qUmWgaxo7wikXslYHQ/oGSZMRNoZTOT2Eg/5QAkqGSgDTSX3rWj6AXLvU+X5yEFLQOm0Q1cbIMGikfM6l3cOKGRn4xax7WMbxNS7fJg9VXuNO25utYV/uE0s/9uPlS0g1xlp4tuumEtZMbAFXdIFSj1l7/NkypjeHXg1Afa1XSVWOlwLgG7KX9FzQmy0ote11rcEySXezZKVHTLJLXs2LytJFuGHQZYqp6BzdTB5KJ4xxwzHurUjFXBbTnGseQ/3IiW1GH9c7wTnSzuQeR0+engkzTlYwE//R5+aushYRMLqwJUNTgGXQUNeVnI47dIaqC5Dr/hNyv543xIJBMQR9GO0WyklBgKQleTOXe5HFyWDMTiD3oi1MId6bE2tEXtgtwhMnwKH1M5fKYl9n14yZUJtJl4lJvi3+qedMPfa
x-ms-exchange-antispam-messagedata: n1pVDYWW6K3+eTINtzgtScbbHuCtL06NYksqNtia5739dtslzu3mFLCn9toDZoPpVKKtljGgag7MgMzlMNL0FrxsP2Jcjr92aN9DmZAwco33ypRZdLTLhNx8ZxtBc03ov1OzXZF9/U77eTCNkrRLDA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <978512E34333FF4182A7763C97905217@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78206ba4-c60c-432a-fdc7-08d7d722258b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 16:23:15.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32//9cRd2exmlDJeoUfBQuilCSWtde1nyfKZT7/4siIPU9cwVETzkbDrUhKLJwRRLH/UuCBqz2ooWCfzHoAkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTAyIGF0IDIxOjMwICswNTMwLCBBbnVwYW0gUm95IHdyb3RlOg0KPiBI
aSBCcmlhbiwNCj4gDQo+ID4gWW91IGFyZSBjb3JyZWN0IGluIGZpbmRpbmcgdGhpcyBidWcuLi4g
IEl0IHdhcyBmb3VuZCBpbiBwYXJhbGVsbCBieSBQcnplbXlzxYJhdyBGaWVyZWssIGFuZCBzaG91
bGQgYmUgZml4ZWQNCj4gPiBhcw0KPiA+IG9mIHRoaXMgY29tbWl0Og0KPiA+IA0KPiA+ICAgY29t
bWl0IDg0YTliNmNlNGI2NmEyYmEyMWNjZThlNGIwYzNjNmUwOTdhNTQ5M2ENCj4gPiAgIEF1dGhv
cjogUHJ6ZW15c8WCYXcgRmllcmVrIDxwcnplbXlzbGF3LmZpZXJla0BzaWx2YWlyLmNvbT4NCj4g
PiAgIERhdGU6ICAgVHVlIE1hciAzMSAxNDowOTowOCAyMDIwICswMjAwDQo+ID4gDQo+ID4gICAg
ICAgbWVzaDogQWRkIG5ldCBrZXkgaW5kZXggdG8gc2FyIHN0cnVjdHVyZQ0KPiA+ICAgICAgIA0K
PiA+ICAgICAgIFRoaXMgcGF0Y2ggYWRkcyBuZXQga2V5IGluZGV4IHRvIHN0cnVjdCBtZXNoX3Nh
ci4gVGhpcyBmaXhlcyBwcm9ibGVtIHdpdGgNCj4gPiAgICAgICB1c2luZyBpbnZhbGlkIG5ldHdv
cmsga2V5IHRvIGVuY3J5cHQgYXBwbGljYXRpb24gbWVzc2FnZXMuDQo+ID4gDQo+ID4gDQo+ID4g
SWYgeW91IGNoZWNrIG91dCB0aGUgY3VycmVudCB0aXAsIGhvcGVmdWxseSBpdCB3aWxsIHNvbHZl
IHRoZSBwcm9ibGVtIHlvdSBmb3VuZCB3aGVyZSB0aGUgaW5jb3JyZWN0DQo+ID4gKHByaW1hcnkN
Cj4gPiBzdWJuZXQpIGtleSB3YXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSByZXF1ZXN0ZWQgbmV0IGtl
eS4NCj4gPiANCj4gT2theSwgZ290IGl0LCB0aGFua3MuDQo+IFNpbmNlIHdlIHBsYW4gdG8gdXNl
IHRoZSBuZXQga2V5IGluZGV4LCB3aWxsIHRoZSBiZWxvdyBzYW5pdHkgY2hlY2sgc3RhbmQgdmFs
aWQoaW4gY2FzZSBvZiBhcHBfaWR4ID09DQo+IEFQUF9JRFhfREVWX1JFTU9URSk/DQo+IEFzIGl0
IG1heSBzYXZlIHNvbWUgdW4tbmVjZXNhcnkgcHJvY2Vzc2luZyBvZiB0aGUgbWVzc2FnZSBwYXls
b2FkIGluIGNhc2UgbmV0IGtleSBpbmRleCBpcyAqTm90KiB2YWxpZCBvcg0KPiAqc3VibmV0KiBp
cyBkZWxldGVkIGJ5IENvbmZpZyBDbGllbnQuIFBsZWFzZSBzaGFyZSB5b3VyIG9waW5pb24uIFRo
YW5rcw0KDQpJZiB0aGUgQXBwIHVzZXMgRGV2S2V5U2VuZCgpIHdpdGggcmVtb3RlID09IHRydWUs
IGJ1dCB0aGUgbm9kZSBkb2VzIG5vdCBoYXZlIHRoZSBkZXZpY2Uga2V5IGZvciB0aGF0IHJlbW90
ZQ0Kbm9kZSBpbiBpdCdzIGtleXJpbmcsIHRoZSBtZXRob2Qgd2lsbCBzaWxlbnRseSBmYWlsLCBh
bmQgbm8gbWVzc2FnZSB3aWxsIGJlIHNlbnQgT3Zlci10aGUtQWlyLg0KDQpJZiB0aGUgQXBwIHdh
bnRzIHRvICpyZXNwb25kKiB0byBhbiBpbmNvbWluZyBjb21tYW5kIHJlY2VpdmVkIHdpdGggdGhl
IGxvY2FsIG5vZGVzIGRldmljZSBrZXksIGl0IHNob3VsZA0KcmVzcG9uZCB1c2luZyBEZXZLZXlT
ZW5kKCkgd2l0aCByZW1vdGU9PWZhbHNlLCBhbmQgbmV0X2luZGV4ID09IHRoZSBuZXRfaW5kZXgg
ZnJvbSB0aGUgY29vcmVzcG9uZGluZw0KRGV2S2V5TWVzc2FnZVJlY2VpdmVkKCkuDQoNCg0K
