Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09CAC47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98932089F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 19:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HCs/CpCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfJKTAN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:00:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:39121 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbfJKTAN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 15:00:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 12:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,285,1566889200"; 
   d="scan'208";a="346111744"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2019 12:00:12 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 12:00:11 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 12:00:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 11 Oct 2019 12:00:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5LuhZn5C0eOtF7MUVnqedPePM0NH0WKuHoqbHMbIfb0tWLFSjujFRLFy7UxW/tGT7JniETGfDuPIhY6cf0RC7i8lWBAFcIcpYprcYiwxKRNb8nDplsFJIW7FvbyKHgKXG8COZm59aKDUwYleTAXscqa0/1CtPJvyFH6kQNzGKQQnO4Rqw+l7OcXaPzzVdyombrRTv8uehJzgF6/fRJBnfNujjQHUAxK+Y/EG9LrUTbQnwjIZC1jh3hirKOGxaiaEFtqUrKGt67sw0VfpJ+29oXUXVHaGoUihUIMtsnPavG6LAhHjvG289VzuAlcg5Lu+xxaPMSIgcnRKQpjFEP1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTyAu0CxOI0Ent+h9wWrE4l1GB1rSHBs0IiUW8S9V1c=;
 b=DeAhC+y6u6w7HPkor36T9IY5AWhDeqiRkbTDCU8DSaofwy8fu2UhZNFUCDJ9nAPILV1shXuxD9qWIPuf7InbUCR9kKPSj3n3piMR3kKe2yYQalKzGRrjPBjw18/KcMzx2euYXNUHLYEzMmrqGlerUPTZXXsoARQnNfhxqP9L86aAdOzuVq6bsZfAOXsiRI/qU09lSEcO83VXNhPumZ1tIC5jOPzRgIre4ItJvV6BgEzTBpM5zrPtanwSK/k9Q2yOUTUTjM4Z2O/jtGrsuko8bq8v7nUgpeza1HSHGz5KMhrpkuJbJqVqaRfBgYC99FDKaioPVjgt/AEhNFizlYLRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTyAu0CxOI0Ent+h9wWrE4l1GB1rSHBs0IiUW8S9V1c=;
 b=HCs/CpCneuwy4xSkVkAWRKPPQb9JhPg/RVSeKhJ97RJR1g/r4YHQ34cL04OkfNowqSzEy7nrY+tjhPhflBIrDRKjx7c+RxpnnSIQguJJCLHUcjTyty7S3cD26+GXDMAzR8shiG9X7z64KLwqHgc8mUdTENbUiqPfGiqMD0x6pPw=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3771.namprd11.prod.outlook.com (20.179.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 11 Oct 2019 19:00:09 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 19:00:09 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "pali.rohar@gmail.com" <pali.rohar@gmail.com>
CC:     "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Thread-Topic: Determinate EDR speed
Thread-Index: AQHVgA3afztLEGC5V0S2QInFi2N9RKdVv7OAgAAFYACAAAcEAA==
Date:   Fri, 11 Oct 2019 19:00:09 +0000
Message-ID: <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
         <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
         <20191011183502.ao45xlyfabpbadxo@pali>
In-Reply-To: <20191011183502.ao45xlyfabpbadxo@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a85ea3ef-c30d-4d44-4080-08d74e7d3d0a
x-ms-traffictypediagnostic: DM6PR11MB3771:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR11MB37712E1F72844C5DDFF42560E1970@DM6PR11MB3771.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(136003)(376002)(199004)(189003)(2501003)(6246003)(6506007)(26005)(229853002)(4001150100001)(76176011)(6436002)(6486002)(14444005)(256004)(5640700003)(316002)(71200400001)(71190400001)(66946007)(1361003)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(6116002)(3846002)(2906002)(186003)(446003)(54906003)(66066001)(102836004)(476003)(11346002)(2616005)(2351001)(81166006)(486006)(6306002)(25786009)(6512007)(36756003)(8936002)(86362001)(14454004)(99286004)(305945005)(7736002)(8676002)(81156014)(3480700005)(66574012)(966005)(5660300002)(7116003)(118296001)(4326008)(478600001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3771;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vavMMH1Do2h5O3+Lr03sHiA8IFPDYSAtdtfte4APH2G3GbIixpFyh/Cy6wpGF1DdP90MiFRocin3x70bFq+cZ60qtesMAAcG+OSNyJc1uevDxGrN3hzAGj/FiToygrYVg8MwEpVLqC1mCBK2dGpQNyZygV7ENK4ov4wTiLgzMEw1hRlGmUIyVgw380xYnzCI/t8OirPxIQ/2U3KTJ1jryDQ78cJve/JHufZaGaVr1xzxUEH7JTDnfdEvsklI4gUCGXCThg+Z5fEzNEm9zQFcS9QH/BQsE2E50oLBA0ZpEesp7BNxPuqO6f6E8skyNcyADojSkr/R2ShceH7p18BBgr6wlNwElIUcrfR0+E4tyLip3av2jvMSFZsrEZWa3cNzbIKDaxbtlDe4Lg4HM0mY4nVrrgWwfrhGnKiYvURSMuMeUU/NQbzpFFPoOVCEPX/zRE/x1dkBV5kIRWjG43CQpg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B56901B8CFC0B40B8280BE51199A040@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a85ea3ef-c30d-4d44-4080-08d74e7d3d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 19:00:09.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxxxeXCXjjlTrafInizGgn95X//w2jHkQooAIu7iLOKFcZGM3U5qFWSRIRx+6c/PfKFy+Dvi4fZpy0J2n6S4WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3771
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGFsaSwNCg0KT24gRnJpLCAyMDE5LTEwLTExIGF0IDIwOjM1ICswMjAwLCBQYWxpIFJvaMOh
ciB3cm90ZToNCj4gQ3VycmVudGx5IGJsdWV6IEFQSSwgbWV0aG9kIEFjcXVpcmUoKSBhbHJlYWR5
IGluZm9ybSBjYWxsZWQgYXBwbGljYXRpb24NCj4gd2hhdCBpcyBzb2NrZXQgTVRVIGZvciBpbnB1
dCBhbmQgb3V0cHV0LiBTbyBmcm9tIHRoaXMgaW5mb3JtYXRpb24gaXQgaXMNCj4gcG9zc2libGUg
dG8gZGV0ZWN0IGlmIGRldmljZSBzdXBwb3J0cyBFRFIgMyBvciBub3QuDQo+IA0KPiBCdXQgaXQg
aXMgdG9vIGxhdGUgdG8gaGF2ZSB0aGlzIGluZm9ybWF0aW9uLiBJIG5lZWQgdG8gc2VuZCBTQkMN
Cj4gcGFyYW1ldGVycyB0byBibHVleiBmaXJzdCB3aGVuIGRvaW5nIEEyRFAgbmVnb3RpYXRpb24s
IHRoaXMgaXMgZWFybHkNCj4gc3RlcHMgYmVmb3JlIEFjcXVpcmUoKSBpcyBjYWxsZWQuDQoNClRo
aXMgc2VlbXMgdG8gYmUgdGhlIGtpbmQgb2YgaW5mb3JtYXRpb24gd2hpY2ggaXMgZml4ZWQsIGZv
ciB0aGUgbGlmZSBvZiB0aGUgcGFpcmluZy4NCg0KV2hhdCBpZiB5b3UgYXNzdW1lZCB0aGUgbG93
ZXIgc3BlZWQgdGhlIGZpcnN0IHRpbWUgeW91IGNvbm5lY3RlZCwgZGV0ZXJtaW5lZCB0aGUNCnNw
ZWVkIGR1cmluZyB0aGUgZmlyc3Qgc3RyZWFtaW5nLCBhbmQgdGhlbiBlaXRoZXIgaW1tZWRpYXRl
bHkgcmVuZWdvdGlhdGUgKGNhY2hpbmcgdGhlIGlkZW50aWZ5aW5nIGluZm9ybWF0aW9uDQpvZiB0
aGUgU05LKSwgb3IganVzdCBjYWNoZSB0aGUgaW5mb3JtYXRpb24gZm9yIGZ1dHVyZSBjb25uZWN0
aW9ucy4NCg0KT3IgdGhlIHJldmVyc2UsIGFuZCBhc3N1bWUgZmFzdCwgYnV0IGltbWVkaWF0ZWx5
IGFkanVzdCBkb3duIGlmIHlvdSBhcmVuJ3QgZ2V0dGluZyB3aGF0IHlvdSBob3BlZCBmb3IuDQoN
CkluIGFueSBjYXNlLCB0aGlzIHdvdWxkIGJlIGEgIkRldmljZSBTZXR1cCIgZ2xpdGNoIHdoaWNo
IHlvdSBjb3VsZCBub3RlIGFzIGEgcm91dGluZSBwYXJ0IG9mIHBhaXJpbmcgaW4gdGhlDQpkb2N1
bWVudGF0aW9uLg0KDQo+IA0KPiBUaGVyZWZvcmUgSSdtIGFza2luZyBmb3Igc29tZSB3YXkgaG93
IHRvIGdldCBpbmZvcm1hdGlvbiBpZiBkZXZpY2UNCj4gc3VwcG9ydHMgRURSIDIgb3IgRURSIDMu
IFRoaXMgaXMgYmFzaWNhbGx5IHJlcXVpcmVtZW50IGZvciBwcm9wZXINCj4gaW1wbGVtZW50YXRp
b24gb2YgU0JDIGluIGhpZ2ggcXVhbGl0eSBtb2RlLiBTbyBpZiB0aGVyZSBhcmUgbm90IHN1Y2gg
QVBJDQo+IHlldCwgY291bGQgaXQgYmUgZXhwb3J0ZWQgZnJvbSBrZXJuZWwgdG8gdXNlcnNwYWNl
IGFuZCBibHVldG9vdGhkDQo+IGRhZW1vbj8NCj4gDQo+IFNlZSB0aGVzZSB0d28gYXJ0aWNsZXMg
Zm9yIG1vcmUgZGV0YWlscyBhYm91dCBTQkMgYW5kIGl0cyBoaWdoIHF1YWxpdHk6DQo+IA0KPiBo
dHRwczovL2hhYnIuY29tL2VuL3Bvc3QvNDU2MTgyLw0KPiBodHRwOi8vc291bmRleHBlcnQub3Jn
L2FydGljbGVzLy0vYmxvZ3MvYXVkaW8tcXVhbGl0eS1vZi1zYmMteHEtYmx1ZXRvb3RoLWF1ZGlv
LWNvZGVjDQo+IA0KPiA+ID4gSXMgdGhlcmUgYW55IGJsdWV6IEFQSSBmb3IgaXQ/DQo+ID4gPiAN
Cg==
