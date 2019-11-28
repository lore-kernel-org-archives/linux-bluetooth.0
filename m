Return-Path: <SRS0=XR6q=ZU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04280C432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FB3217BC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 22:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vpFT91CR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1Wfx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:35:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:47157 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfK1Wfx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Nov 2019 17:35:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 14:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,254,1571727600"; 
   d="scan'208";a="212161984"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2019 14:35:51 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 14:35:51 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 28 Nov 2019 14:35:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow3unf+jzpIeaN8xZWzVS48BmtGmym47kTnYuYEi7Ga2vxFAOeH49+68Zo5ea/hSkI5akcBjQWATeI12IcKwFMp+CgpKMSxJOlqhKu1SGE0b4NBSbth9cWprzue1ndpc9YLCztrUx61ne5NcXIlXJyyd1VS5rSbkdEfKe7NmArQTQoKYA78/KG81m8BQPMEOw7rr1Bp18iY3Dol0rCVz29SVlfxSaeHxaAP8JSrsBpBWefqu7E1Pk+nAXm5877nmtQPWPGZIYwnSFB1MshXZFFZ+/KPYtmisSk62hGzw+mUQVN6zo/+I96435BzbUvtCEJCWICm4W3uNgzCABohGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wgbkKOA0Mhy42fClcQuc7iIwK2KGAeeI7UDFKW6WJU=;
 b=Qhc9QRTXJH29WBgiewB0w/qe6PoU7bobovjFDQJc5Jc8kpHZILbeYAW3ULL4ulVQyIdvMJMwJn2FkRrepo5FMsk6JH2qNVuKAeDLigRNfpwhZb/DuFislxUBVHtqjrWaNPs05hD6Ys6AoptLjhSiIP0DYRrUvldQUYzCSVdj+Tlik2HeaKwX5SZ7qVsKjaKR5dU9jek8Y1uPW6DB6YAlrBZdjFE/P+4LIIX5xTIHHv19D5PQ9wlPQinf0Q7GYOQnM4jUQpP2PF/RgO+xYvGSKaUGX7Ih50qUGiB0hjKYwANoShHlFG24+AnDgTlJ+GDPAhtYRrW3vbprzKD0antWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wgbkKOA0Mhy42fClcQuc7iIwK2KGAeeI7UDFKW6WJU=;
 b=vpFT91CRqzw+Cr/r2xky7picLfuQHGYx2XiBHHrHAAdEmuakxUzcbXsYb89poGxXIcGV4H/EecC77lA9aOvAD5lxCMRlSNwS+SMy0WV2+BN5RYFV1YdFMwi/rfgb1qCKRpQaM5bz9KCN1rJSrf9AwC3p1GrIWE59rPGqfjyqgSg=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1654.namprd11.prod.outlook.com (10.172.71.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Thu, 28 Nov 2019 22:35:49 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 22:35:49 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 0/2] mesh: Fix Friendship for multiple local
 nodes
Thread-Topic: [PATCH BlueZ v2 0/2] mesh: Fix Friendship for multiple local
 nodes
Thread-Index: AQHVpWs//i6cVKajjkmcegaoq4aszqehLYUA
Date:   Thu, 28 Nov 2019 22:35:48 +0000
Message-ID: <6ED08F62-EF2B-41E3-BE49-016941072794@intel.com>
References: <20191127213939.4526-1-brian.gix@intel.com>
In-Reply-To: <20191127213939.4526-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [2607:fb90:8226:517b:341c:ccae:4e19:bb61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59162425-8b97-4007-5b85-08d774535154
x-ms-traffictypediagnostic: CY4PR11MB1654:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1654BFCEC9FE651ACB79228FE1470@CY4PR11MB1654.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(2351001)(53546011)(6916009)(446003)(86362001)(71200400001)(6512007)(14454004)(6116002)(71190400001)(36756003)(11346002)(6486002)(2906002)(66476007)(81156014)(91956017)(102836004)(66446008)(66946007)(6436002)(64756008)(76116006)(229853002)(186003)(7736002)(6506007)(66556008)(107886003)(2501003)(99286004)(46003)(316002)(6246003)(5640700003)(25786009)(478600001)(76176011)(256004)(305945005)(8676002)(4744005)(33656002)(8936002)(81166006)(5660300002)(4326008)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1654;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56j5ydul5IVCIiN5Wp4pM4blAKhEZo7UK8as3hc/xBSHBLS38PaZRvQfOt7FfNa0KM/Kbd+HV5xNXzKYgRFqc9fBFJWXw8+e6jcHAYqDygjKF4hEy7DheFIgDuV2nIesJ7cNBR6ctCvrDXUI8NemvVB9yLYpUcH0gecWPfWWv1lzfEbz0m+xVWM4pZ7R05orhpWxgQoumxS/x1heyPp9m2SU8PI45yvxycx4s8wDfZzGJpEZru27pxt246banoXYHYo4eMpwBiDN0jvnaZS+Le4IJTrlhH3WQSjuqhcj9emwgcu03z15W2P0A1KaTx1Xqp6gU7Z3PDFfSjNC/wWdMMe/xpH6hsZIRd11lHDJGdbSouyRIcZgMlnU86ER/G6fSgxfjom7hlCTKWpYKclSu6SfYp9w969zOn5WvKDuXxXTYF/zvgGlelFITBH+UhF1
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E234259D49B4A439A70E0C44C571D73@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59162425-8b97-4007-5b85-08d774535154
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 22:35:49.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0VD/beKcI3eSf8valgn6FUvIIRWHjbw9wQLnIUmGQ8JVWYW92Icqq+uTEnuEVHkQw7lUANHuOAyIi/e7y1SgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1654
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgYXBwbGllZA0KDQo+IE9uIE5vdiAyNywgMjAxOSwgYXQgMTo0MCBQTSwgR2l4LCBC
cmlhbiA8YnJpYW4uZ2l4QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79QcmltYXJ5IHB1cnBv
c2Ugb2YgdGhpcyBwYXRjaC1zZXQgaXMgdG8gZ2V0IEZyaWVuZHNoaXAgd29ya2luZyBhZ2FpbiwN
Cj4gYW5kIGNsZWFuLXVwIHRoZSBsb2dpYyBzbyB0aGF0IGl0IGNvcnJlY3RseSB3b3JrcyBhY2Ny
b3NzIG11bHRpcGxlDQo+IE5ldHdvcmtzIGFuZCBOb2Rlcy4gIEN1cnJlbnRseSBmcmllbmRzaGlw
IG11c3QgYmUgZW5hYmxlZCBieSBtYW51YWxseQ0KPiBlZGl0dGluZyB0aGUgYXBwcm9wcmlhdGUg
bm9kZS5qc29uIGZpbGUsIGJ1dCBzdXBwcG9ydCB3aWxsIGV2ZW50dWFsbHkgYmUNCj4gYXZhaWxh
YmxlIHdpdGggYSBzb29uLXRvLWNvbWUgbWVzaC5jb25mIGZpbGUuDQo+IA0KPiB2MjoNCj4gQWRk
ZWQgYW4gYWRkaXRpb25hbCBEZWJ1ZyBPdXRwdXQgY2xlYW4tdXAgcGF0Y2ggdGhhdCBtYWtlcyBs
b2dnaW5nIG9mDQo+IGluY29taW5nIG1lc3NhZ2VzIGxlc3Mgbm9pc3kgd2hlbiBtdWx0aXBsZSBs
b2NhbCBub2RlcyBjYW4gZGVjcnlwdCB0aGUNCj4gc2FtZSBpbmNvbWluZyBtZXNzYWdlcy4NCj4g
DQo+IEJyaWFuIEdpeCAoMik6DQo+ICBtZXNoOiBjbGVhbi11cCBSZWNpZXZlZCBNZXNzYWdlIGRl
YnVnIG91dHB1dA0KPiAgbWVzaDogRnJpZW5kc2hpcCBjbGVhbi11cCBhbmQgcmV3cml0ZQ0KPiAN
Cj4gbWVzaC9jcnlwdG8uYyB8ICAgNCArLQ0KPiBtZXNoL2ZyaWVuZC5jIHwgNjEwICsrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IG1lc2gvZnJpZW5k
LmggfCAgIDcgKy0NCj4gbWVzaC9uZXQuYyAgICB8IDMyOCArKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0NCj4gbWVzaC9uZXQuaCAgICB8ICAzMSArKy0NCj4gbWVzaC9ub2RlLmMgICB8ICAgMiAr
LQ0KPiA2IGZpbGVzIGNoYW5nZWQsIDI3MSBpbnNlcnRpb25zKCspLCA3MTEgZGVsZXRpb25zKC0p
DQo+IA0KPiAtLSANCj4gMi4yMS4wDQo+IA0K
