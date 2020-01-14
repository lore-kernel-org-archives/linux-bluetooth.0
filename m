Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB952C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C59624680
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="S5KvT3sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANOhl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:37:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:30549 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANOhk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:37:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="305161905"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 06:37:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:37:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 06:37:39 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 06:37:39 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:37:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7GufAspUnWxCa1Rnv5QYmke6xDJZ7VbVEgFfpRXDEolNLWVI7ud/1xKXdoqN6iXyI7JeV/20HxljUvadRdhJZ8dpiNjsdm11GXhoDIAFUKc/eaigWlMwqZ+c9D83Mt38GfjYZ/afbdnE2FOy4oY4CEWHLuW+039Fwqs+KhqNo2tShK8gZScX6FVSnpGNkQTqspR+3+a2f8GX96JonXZpuTm1zQnVvR6hsnrBiFD9B71NympKdO/NDplswlLpD27ynFNoZrx434Eps1bohQR4WErOHNCnC6OfB7GMRHaemiSolJKEW2UHU3moc47pwab2qCc89KlwIUFCEsmIxPj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS/AIbAiyeOI85zb5xC5esu5CL9Gg00m4zMwbchZ0Jk=;
 b=CbNAcAVQlSLUd2fYVtiYTYhxitm6RDy1KuMjUoEqcHGICx5+cALzrxpyj/m3r1vwS0FgzqxGQhU7okn8aVlfPBNr1snAokLzogVMQN39qS3/T0blhk4CHgbGdGywWydEtKddzAtmNO4sh6CbUfgvDAmZN1OTv6TDnalfBYkJggFh0HVC2IRtjW1nVzRUBHIkVNvJWLSrul3F5Irx6j5X/HNhgsz47qmpVTKN8FWThuaJvZvO/7yXjIUxMoyBq6S6OJbemuCze4cQNcBNfgPU1mB0GL2w/k7xRjZkeRzm3zFFRz5hKPfzANwuKQnbQq6nhnJNJqo71H4cA5GD1eHYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS/AIbAiyeOI85zb5xC5esu5CL9Gg00m4zMwbchZ0Jk=;
 b=S5KvT3sWEmKQKJTAOlvzI2vG0meBEYF5jyBAFQJNjZmxQTz+PcAjxQ62VthMoGXD+p9qH/Qbw0Pz6nhv02Plewq2Cg7eb7zVkb0yzFDgyfYD5NYc97JMcqQiHEdxBIUnpax5BVShLO/QYQibxLvCtLyXB+RCzOhmXbkyhvBwmZc=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:37:18 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:37:18 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] Fix AppKey deletion
Thread-Topic: [PATCH BlueZ 0/2] Fix AppKey deletion
Thread-Index: AQHVx1cv2dby4JY+hk2hz13ShWTBoafqQY6A
Date:   Tue, 14 Jan 2020 14:37:18 +0000
Message-ID: <2f16da308b1fe1f173cdd761d8e630774414ed11.camel@intel.com>
References: <20200110014145.1785-1-inga.stotland@intel.com>
In-Reply-To: <20200110014145.1785-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bf10ce1-a187-44af-1aae-08d798ff41be
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB180575EF7DB79AF3CDFADA25E1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(6506007)(478600001)(6486002)(36756003)(91956017)(66476007)(6636002)(8936002)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(4744005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(316002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xx40KO1HFTScond92AQIMZUn32/20LYKmUtt/WjR0Z5S3ShlgaPwv86UjhZ6uAGevEXeMHtKyUTJyfLtuzfwEoxVEhN1pYSx33RrO1kh75+X202KdYwcD0ceJdYdpBpeQoKdv6vtO6hDXbFWWCWvsy9/GEFHB8KuGX6mTE/1REPZQ0ob8Bd6+pV6vQnqt41M7kFinSCDAefNYBsH27Sf4tlxPJi1pkzCATp5DlGUhMqDx2YHVFk5E25hCGzvbE7cNt0xpyud1ZTJdkLBZiey/Z6M8XQCgFaB0y4B9enZN1KH9HH5hZHXf/A9U73PLngAMPV/ET8P54xkQOwbVMIPujSPHWII+D0dDvfGYgJ8nktx7P02JoDeAjlirVZH7E/hl8YoM2vc10Uq0R0t204DnbfDMGoB4ny/cVl+kInN/SDh41bY4UNyt/HS0qkJhpUZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <4039E49A7503C245A9472700B78D30EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf10ce1-a187-44af-1aae-08d798ff41be
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:37:18.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SM8z+T1aQAeue/14L+IRw/knW/xlS63sYiSHth+9VkcX/pwOGQg8E8K5YusCeLEewO/23yVfsQISxpBPlfwgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDE3OjQxIC0wODAwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBjb250YWlucyBmaXhlcyBmb3I6DQo+
ICAtIGRlbGV0aW5nIGluZGl2aWR1YWwgYXBwIGtleSBkZWxldGlvbiBhcyBhIHJlc3VsdCByZWNl
aXZpbmcNCj4gIENvbmZpZyBBcHBLZXkgRGVsZXRlIG1lc3NhZ2UuIFRoZSBmaXggcmVtb3ZlcyBh
IGR1bHBpY2F0ZSBhdHRlbXB0DQo+ICB0byB3cml0ZSB0byBjb25maWcgc3RvcmFnZSBhbmQgc29t
ZSBmdW5jdGlvbiBjYWxsIHNpbXBsaWZpY2F0aW9ucw0KPiANCj4gLSBkZWxldGluZyBhIG51bWJl
ciBvZiBhcHBrZXlzIGFzIGEgcmVzdWx0IG9mIHJlY2VpdmluZw0KPiBDb25maWcgTmV0S2V5IERl
bGV0ZSBtZXNzYWdlLiBXaGVuIGRlbGV0aW5nIG11bHRpcGxlIGVudHJpZXMgZnJvbSBhDQo+IHF1
ZXVlLCBkbyBub3QgdXNlIHF1ZXVlIGl0ZXJhdGlvbiBtZWNoYW5pc20gYXMgdGhlIGRlbGV0aW9u
IG9mDQo+IG11bHRpcGxlIGVudHJpZXMgbWF5IHJlc3VsdCBpbiBzZWcgZmF1bHQuIEluc3RlYWQs
IGZpbmQgYW5kIGRlbGV0ZQ0KPiBib3VuZCBrZXlzIG9uZSBieSBvbmUgdW50aWwgbm9uZSBhcmUg
Zm91bmQuDQo+ICANCj4gDQo+IEluZ2EgU3RvdGxhbmQgKDIpOg0KPiAgIG1lc2g6IEZpeCBsb2dp
YyBpbiBBcHBLZXkgZGVsZXRpb24NCj4gICBtZXNoOiBGaXggd2hvbGVzYWxlIGRlbGV0aW9uIG9m
IGFwcGtleXMgYm91bmQgdG8gYSBuZXRrZXkNCj4gDQo+ICBtZXNoL2FwcGtleS5jIHwgMzIgKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIG1lc2gvbm9kZS5jICAgfCAyOSArKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9ub2RlLmggICB8ICA0ICsrLS0NCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pDQo+IA0K
