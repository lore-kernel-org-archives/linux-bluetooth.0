Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326AEC32792
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 21:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97AA207FA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 21:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sQUSyHlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfI3VVB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:21:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:52537 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbfI3VVA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 17:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 10:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="220738395"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2019 10:58:04 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 10:58:01 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 10:58:01 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 30 Sep 2019 10:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jptIBSeBFwMzlTASiKYWnLoITUo+aOTB7Dxm7bo0MyN7nMg1VN5+BLDB/+jTXALcG7G8qCuGm7Sscx7OSw16fz6nXmBG66EJoh0evJ7TcaYeksbSXv4hBpkZQ1cQOMlcMaB4fHhelUgAfLZ3lmLR7WONMzd0dlxTrZJ5BlJHfabNLNqZTQhtnFcSL+rQIWG7EBqIJI8Xw7WO8O9/cX6HFL9eYPJitEHNmGj5uxuaxpXhwv4tlxSH2eNHon5mOIQ5/POjt8OFsjlLVm0x/c7YKs47VJFXbYHbQmxI90QyODfk7nK7mgxXKBTsBDcxTFO4abEmxA/RPjvEV0kgErNVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwJ64gKFCkfx4Abqq7R8PGYNhcuaKPn5yvgLa1znHYk=;
 b=At6mtkuTXb6VQi1nUHBmDQSIP09k/G0U+p1FDgPcLpZ//C+guNy0jnUh0TJagpcbHnF2Farf6Xs9j9J0aGt1PkMDCADFsg0tJ/+6RBtrlCusRcdes8Bq5SsgsrGnjiiPv7Y4FDAv/TMIl04zVLTzQo/tzm3zi6scPa3tXybPbHEKgzkvHMx1FXPVj+mv/V43PJVyrARRWfmIQVk3tYDKypTXbrslGgVGmvkljKIHSPsaCSjY5WUYZo0gV89HPKiixOXSubcJsEhOXiNHKQfM/FkJpi4K1WF+B1+gsXotGDxBwMG1niHukWBfLXf7HZxfvVl8SikZAkdcYn/B7XtlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwJ64gKFCkfx4Abqq7R8PGYNhcuaKPn5yvgLa1znHYk=;
 b=sQUSyHlcPehWmLWB9oqkXWBJTznPzXfZhZkd5aL9w1IMyCSdg3IeUkUzcBN/jU7Y9wj+5GMb1Njjt8qBHTRkmpnR6SnTmGZ/jaVI6utthl5tQtB4lE+uIAjiyZTG2cWPyk6JpdiZY1CEWGChyd03ze9F6IA0AzThUHxSVZRJeHM=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3676.namprd11.prod.outlook.com (20.178.231.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 17:58:00 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 17:58:00 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6cxPhOAgAuqqYCAAVPegIAAWhSAgADMPACAAHTBgIAAGq4AgAAhlwCAA+uvgIAAsaxQ
Date:   Mon, 30 Sep 2019 17:57:59 +0000
Message-ID: <DM6PR11MB44126F270599A750722C5A1BE1820@DM6PR11MB4412.namprd11.prod.outlook.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
 <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
 <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
 <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
 <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
 <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
 <01c84f55db98fbcc2790d11fd6090589881c36cf.camel@intel.com>
 <856d4e6bfdbe84b7b7ac3742ebede263c7801346.camel@intel.com>
 <86e707237937cfb5c4e8fea8e96924f4590ab0a3.camel@intel.com>
 <20190930071803.nvp3ema26ynuiwz3@mlowasrzechonek2133>
In-Reply-To: <20190930071803.nvp3ema26ynuiwz3@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzllNzBjZWEtYTY5MS00YzE5LTkwZGEtNzk1ZWJlMTQ4MzliIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiekNKMlF6UGlHcFwvV29pNjRUWFdXRHVnbXNRanQzVE9uditoVXprK2ZKemVjbmJob2cxQ09heUpFUFJpbzFNY3IifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.52.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f688d54f-9d7d-4487-d148-08d745cfbb66
x-ms-traffictypediagnostic: DM6PR11MB3676:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3676D53A3CB1305FC7454BBDE1820@DM6PR11MB3676.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(66446008)(52536014)(66476007)(66556008)(64756008)(5660300002)(25786009)(102836004)(478600001)(71190400001)(71200400001)(76176011)(6436002)(66946007)(7696005)(6916009)(99286004)(76116006)(14454004)(81156014)(6506007)(8676002)(3846002)(26005)(6116002)(8936002)(186003)(86362001)(229853002)(7736002)(54906003)(446003)(11346002)(316002)(2906002)(6246003)(81166006)(305945005)(4326008)(74316002)(2501003)(256004)(33656002)(5024004)(15650500001)(9686003)(2351001)(5640700003)(486006)(476003)(66066001)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3676;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+WyrDiAInyWQTEOpqYkNIbA8tkN0BuOGl2KGcds2Z/FcYdL/QsYgFa5UJDs7NjmXbBk3uswlAE9w+E6oMIy/hRiFds4+3X9o9xJvMO9FFjHxKW8iiD0eIQizcXAu/X3J7G8WuGTYfKpu36Vo31nnxLyls7T5EWbh8lb7kDesKYsZ399eujQQt2+utmyf4aD8USVmzUn+S6Z9e00fWD+vE+cXgr5cEGYOGstbKkMINhc6Xaq75Wa3NWCG614pXCZ630kgCyPyWCjfANQd+u9GsZ7bMiOVzCz3iRjLa/6Vv6YCz4vObWRSdRs+cMi6owygVYNLNT5g19lMtLyLX/QeksX0A/G/KESnh0whyeCK4HwNIfdxzTOsWkq3HkmsZ11SmAMiKRQeK+oN9CPLCUGTUS+Q5Ocrm7TyoyBMPaIsp4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f688d54f-9d7d-4487-d148-08d745cfbb66
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 17:57:59.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXqwtfYHPcZO2RQAm9vfogzgmvTqZG1sSxAhKY+FIH5mR4bHc0mZt4RJay2+EybWC4bKyytvRsc1DLljAy6LPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3676
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KQ2FuIHlvdSBzdWJtaXQgYSBwYXRjaCBzZXQgd2l0aCB0aGVzZSBhZ3Jl
ZWQgY2hhbmdlcywgdGhhdCBpbmNsdWRlczoNCiogZG9jL21lc2gtYXBpLnR4dCBjaGFuZ2VzDQoq
IFNvdXJjZSBjb2RlIGNoYW5nZXMNCiogdGVzdC90ZXN0LW1lc2ggY2hhbmdlcyB0aGF0IGNvbmZv
cm0gdG8gbmV3IEFQSQ0KDQoNCk9uIDMwLVNlcC0yMDE5IE1pY2hhxYIgd3JvdGU6DQo+ID4gRm9y
IGEgc2luZ2xlIE1lc3NhZ2VSZWNlaXZlZCgpIG1ldGhvZCwgdGhlIGNsZWFuZXN0IHdheSBpcyB0
byBoYXZlIA0KPiA+IHRoZSBzdWJzY3JpcHRpb24gYWRkcmVzcyBwYXJhbWV0ZXIgYXMgYSB2YXJp
YW50IChzdWdnZXN0ZWQgYnkgDQo+ID4gTWljaGFsKSBvciBhcyBhIGRpY3Rpb25hcnkuDQo+ID4g
QW4gYXJyYXkgaW50cm9kdWNlcyBhbiBleHRyYSBjb25zaWRlcmF0aW9uIG9mIGJ5dGUgb3JkZXJp
bmcgZm9yIA0KPiA+IGdyb3VwIGFkZHJlc3Nlcy4NCj4gDQo+IElmIHZhcmlhbnRzIGFyZSBlYXN5
IHRvIHNvcnQgaW4gc2NyaXB0aW5nIGxhbmd1YWdlcyBsaWtlIHB5dGhvbjMsIHRoYW4gDQo+IEkg
c3VwcG9zZSBJIGNvdWxkIGxpdmUgd2l0aCB0aGlzLg0KDQpMYXN0IHRpbWUgSSBjaGVja2VkLCBp
dCB3YXMgQyB0aGF0IGhhZCBpc3N1ZXMgd2l0aCAgYW55IHR5cGUgb2YgJ2R5bmFtaWMnIHR5cGlu
Zywgc28gSSB3b3VsZG4ndCB3b3JyeSBhYm91dCBjbGllbnQgbGFuZ3VhZ2VzLiBIYW5kbGluZyBE
LUJ1cyB2YXJpYW50cyBpbiBweXRob24gaXMgdHJpdmlhbC4NCg0KPiBPciBpcyB0aGlzIHN0aWxs
IGEgdHdvIHN0ZXAgcHJvY2VzcyBvZjoNCj4gMS4gRGV0ZXJtaW5pbmcgdGhlIHUxNiB2cyB1MTI4
DQo+IDEuMSB1bm1hcnNoYWxsaW5nIHRoZSBjb3JyZWN0IHR5cGUuLi4NCj4gDQo+IFdoYXQgd291
bGQgdGhlIHNpZ25hdHVyZSBvZiB0aGUgbWV0aG9kIGxvb2sgbGlrZT8NCg0KU29tZXRoaW5nIGxp
a2UgdGhpczoNCg0KCXZvaWQgTWVzc2FnZVJlY2VpdmVkKHVpbnQxNiBzb3VyY2UsIHVpbnQxNiBr
ZXlfaW5kZXgsDQoJCQkJCSB2YXJpYW50IGRlc3RpbmF0aW9uLCBhcnJheXtieXRlfSBkYXRhKQ0K
DQphbmQgb24gdGhlIFB5dGhvbiBzaWRlLCB0aGUgaGFuZGxpbmcgd291bGQgbG9vayBzb21ld2hh
dCBsaWtlIHRoaXMgKHNpbmNlIFB5dGhvbiBkb2Vzbid0IGRvIG92ZXJsb2FkaW5nLCBhdCBhbGwp
Og0KDQpjbGFzcyBFbGVtZW50SW50ZXJmYWNlOg0KCWRlZiBNZXNzYWdlUmVjZWl2ZWQoc291cmNl
LCBrZXlfaW5kZXgsIGRlc3RpbmF0aW9uLCBkYXRhKToNCgkgICAgaWYgdHlwZShkZXN0aW5hdGlv
bikgPT0gZGJ1cy50eXBlcy5VSU5UMTY6DQoJICAgICAgICBncm91cF9kZXN0aW5hdGlvbiA9IGRl
c3RpbmF0aW9uDQoJICAgIGVsaWYgdHlwZShkZXN0aW5hdGlvbikgPT0gZGJ1cy50eXBlcy5BUlJB
WToNCgkgICAgICAgIHZpcnR1YWxfZGVzdGluYXRpb24gPSB1dWlkLlVVSUQoZGVzdGluYXRpb24p
DQoJICAgIGVsc2U6DQoJICAgICAgICByYWlzZSBEQnVzRXJyb3IoJ1VucmVjb2VuaXplZCBkZXN0
aW5hdGlvbiB0eXBlJykNCg0KPiA+IFdoYXQgSSBtb3N0bHkgYWJvdXQgaXMgdGhhdCB0aGUgcmVw
cmVzZW5hdGlvbiBvZiB0aGUgc3Vic2NyaXB0aW9uIA0KPiA+IGFkZHJlc3MgaW4gdGhlIE1lc3Nh
Z2VSZWNlaXZlZCgpIG1ldGhvZCBjb3JyZXNwb25kcyB0byB0aGUgDQo+ID4gcmVwcmVzZW50YXRp
b24gaW4gdGhlIGNvbmZpZ3VyYXRpb24gZGljdGlvbmFyaWVzIGZvciB0aGUgQXR0YWNoKCkgDQo+
ID4gYW5kDQo+ID4gVXBkYXRlTW9kZWxDb25maWd1cmF0aW9uKCkgbWV0aG9kcy4NCg0KQWdyZWVk
Lg0KDQoNCg==
