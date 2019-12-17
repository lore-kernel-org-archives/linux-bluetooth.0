Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C0CC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 18:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75070206D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 18:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="AA2spOfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfLQS4q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:56:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:33433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfLQS4p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 13:56:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 10:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="247588442"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2019 10:56:45 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 10:56:45 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 10:56:44 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 10:56:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9etjXHGvgMF3WLNGVw5kLjrcpQXgBwcLALrE1KwlQSgezVmkwXBywzn8HE7YFiDhG5SCEoyP1MNvv/scPVBjU0FzYCXpWBFcQ98ULSYvzEvV1iB/w8ne77MTn9vqGL7DIo6GhMCwqJMKEnRdMUmX23Yn5ehmSd+2muQOUxROANKjyYhkdPEOS+vSBGObcc2nlAh828wK8i3GeTQCOaLA236n6sMspFgoKMqutezX/9S8djVDjD093tqQNmwLZXSu6owM7ecNBgZirl0hilQOLEE9ktK0/I1QSEUnu6KWsAAMuVFmsL42Pn6cmhVQ7jwY4tgFpY4+3RV7yVxfzELhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICr4tARtPdhe7UKpbfYI4PjbXffMNT9hcBeDBQ6pvMo=;
 b=JVtcteqo7Z58tw/uymygfjM+hB7gziam4NtYG5QIEXBPIfozPoBCeqBYoOnM5XOSTBZZ5qLSQgr6287vO9bbDWkLBxBh0Uf17GsF55JvviyhGJdMVkGfjK0jX7+lwM916Jdm/sbs4INL5Umvcq7VpvAg+4Zt29qrk5Tk3+cBceAMsGP0LQLpjAOQRP4IyvJx1p0ZaIatVhhq+XaY43x+FCnrX9f++rFEveR9jsGr3SeQ7J3RF+gOJBgXdE6HQGAtcrYdkQ9S2q1xyoRCS9Vs4gNJ8+3aDDmUJsmbajbbdj7eTYkMg30bTIl9sbYFiEpaVlBSy3KJOioJmEOFhPDv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICr4tARtPdhe7UKpbfYI4PjbXffMNT9hcBeDBQ6pvMo=;
 b=AA2spOfh/vfRdFF6vtxK+xdr8WxGu6MJQ3EmSM/2Mx+m9jECKX2faXAS3wq1cPvsPd74zIGd+hUtqHNS1AmzmtdNSb5rmJc1Yh4WKEa+PAuYuKDOg4K3uf/8mEH9JyJ9psort/XJOzNd7YyI6m1+14c1Pi+XwXCtW3kPkBNj9cw=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1781.namprd11.prod.outlook.com (10.175.80.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 18:56:43 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 18:56:43 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Thread-Topic: mesh: Handling application failures on Create/Join/Import
Thread-Index: AQHVtQn6uV8/TznPHkeEUzvQD9wTFae+qsgAgAAClAA=
Date:   Tue, 17 Dec 2019 18:56:43 +0000
Message-ID: <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
         <20191217184728.qoapokv7acfyaz33@kynes>
In-Reply-To: <20191217184728.qoapokv7acfyaz33@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84279d1d-dd2e-4fd2-146b-08d78322dbbf
x-ms-traffictypediagnostic: CY4PR11MB1781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1781C042072B6D6CDF850E84E1500@CY4PR11MB1781.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(8676002)(5660300002)(186003)(8936002)(81166006)(26005)(91956017)(36756003)(6512007)(6486002)(64756008)(66556008)(81156014)(71200400001)(86362001)(4326008)(110136005)(66446008)(66476007)(66946007)(6506007)(2616005)(316002)(478600001)(107886003)(76116006)(2906002)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1781;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIEJqrkeciZdDxq8aGqCfg6dptwXied5zrAIdNK3qJJ3cZ3BJqjPlT5bF4n533+b/741sUJTmTfsUhnEmOPagufVkghp5yfZQgl9/I7Hd+W1b7L7cK63bvOifM1I0DLtSovYCawLVhuJ2k2U5ZgJPevLKFxSdg4DaCHXtTn1hnW6oHnhUt7j+/f/Z9v0MT6FPqZF3P4aGyQr54OT3s3BwBRI76j2XBr9OwAIHsjaPdxLMWYK52XIzMD3J69AbLI/EOJLNRVihSJ1IGAJbdAJqaXJBXUcwNDWd7JNOk2NHWAUnocrrzlNAH7IHX8KDhVQMC1L7/HRNMN32kZqVVReQ7gPQBfqWZlj989bJWSxaYIjBiew+vbj00nHa+A8dSmknPGWEP/xQszXY7i7N3XmymdzX2aiAF8hbFmjuCTRZD3Eq2sgL/RzCbrUqji6EPlf
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DBB2274EE7CD74EBA19EB3ECD58875F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84279d1d-dd2e-4fd2-146b-08d78322dbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 18:56:43.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJqNqWwDSjZXFdONIGKS/dD2ISBgX0w2YTeLkfaLEeNb3cUcNYACx6TlRuNP8mrAUCA0mReMpYPXqjWIz9ySbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1781
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVHVlLCAyMDE5LTEyLTE3IGF0IDE5OjQ3ICswMTAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gT24gMTIvMTcsIE1pY2hhxYIgTG93YXMtUnplY2hv
bmVrIHdyb3RlOg0KPiA+IEkgd291bGQgbGlrZSB0byBkaXNjdXNzIHBvc3NpYmxlIHNvbHV0aW9u
cyB0byB0aGlzLiANCj4gPiANCj4gPiBPbmUgb2YgdGhlIGlkZWFzIGlzIHRvIGdpdmUgdGhlIGFw
cGxpY2F0aW9uIHNvbWUgdGltZSB0byBzdWNjZXNzZnVsbHkNCj4gPiBBdHRhY2goKSBpdHNlbGYg
dG8gdGhlIG5ldyBub2RlLCBvdGhlcndpc2UgaXQgZ2V0cyByZW1vdmVkLg0KDQpOb3QgYWxsIG5v
ZGVzIG5lZWQgdG8gYmUgYXR0YWNoYWJsZS4uLiAgRm9yIGluc3RhbmNlLCBhIG5vZGUgdGhhdCBp
cyBvbmx5IHVzZWQgZm9yIGZyaWVuZHNoaXAsIHJlbGF5aW5nIG9yDQpiZWFjb25pbmcgY2FuIGV4
aXN0IHdpdGhvdXQgZXZlciBiZWluZyBhdHRhY2hlZCB0by4uLiAgc28gcmVxdWlyaW5nIGFuIEF0
dGFjaCgpIHNob3VsZG4ndCBiZSBhIHJlcXVpcmVtZW50Lg0KDQo+ID4gDQo+ID4gQW5vdGhlciBw
b3NzaWJpbGl0eSB3b3VsZCBiZSB0byByZW1vdmUgImNyZWF0ZWQgYnV0IG5ldmVyIGF0dGFjaGVk
IiBub2RlcyBvbg0KPiA+IGRhZW1vbiByZXN0YXJ0Lg0KPiANCj4gT3IgbWF5YmUgY2hhbmdlIHRo
ZSB0b2tlbiBmbG93IGEgYml0IGFuZCBpbnN0ZWFkIG9mIHN0cmFpZ2h0IHJldHVybiwNCj4gbWFr
ZSB0aGUgZGFlbW9uIGNhbGwgSm9pbkNvbXBsZXRlIGluIGFsbCAzIGNhc2VzLCBleHBlY3Rpbmcg
YSBjYWxsDQo+IHJldHVybiBmcm9tIHRoZSBhcHBsaWNhdGlvbj8NCj4gDQo+IElmIEpvaW5Db21w
bGV0ZSBjYWxsIGZhaWxzLCBub2RlIGNvdWxkIGJlIGRyb3BwZWQuDQo+IA0KDQpJIHRoaW5rIHRo
ZSBBcHBsaWNhdGlvbiBkb2VzIG5lZWQgdG8gdGFrZSByZXNwb25zaWJpbGl0eSBmb3IgdGhlIHRv
a2VuLCBvbmNlIGl0IHJlY2VpdmVzIGl0Li4uICBJZiB0aGUgY2FsbCAob3INCnJlc3BvbnNlKSB0
aGF0IGRlbGl2ZXJzIHRoZSB0b2tlbiB0byB0aGUgQXBwIGZhaWxzLCB0aGUgbm9kZSBzaG91bGQg
YmUgZGVsZXRlZCwgYnV0IHRoZSB0b2tlbiBpcyBjb25zaWRlcmVkDQpzZW5zaXRpdmUgZW5vdWdo
IHRoYXQgd2UgbG9jayBkb3duIGFjY2VzcyB0byBpdCBhcyB0aWdodCBhcyBwb3NzaWJsZS4gIElm
IGl0IGlzIGluYWR2ZXJ0YW50bHkgbGVha2VkLCB0aGVuDQp3aG9ldmVyIGdldHMgaXQgaGFzIGFs
bCB0aGUgYWJpbGl0aWVzIG9mIHRoZSBub2RlLCBzbyB3ZSBtaW5pbWl6ZSB3aG8gc2VlcyBpdC4N
Cg0KDQo=
