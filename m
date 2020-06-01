Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A636C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1BC206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bnTY+6YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFARZX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:25:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:61230 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFARZW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 13:25:22 -0400
IronPort-SDR: mFUaGouWne65p+oXUVQw46xGLJsKQUbOU/X1tLHVtbiOc6FfG8SkzPwuRMkMAT8khVulH3l2Ll
 prZoLNp84r1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 10:25:21 -0700
IronPort-SDR: xTXvaNgUDeUPDNY57FOaD0Cw5Bx8Yqu9hMp63N5X+jRQ87Er+4ztpK5Y66cdQQcUFvxLMrWsit
 oVtKhVl733pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="256841128"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2020 10:25:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 10:25:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jun 2020 10:25:20 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 1 Jun 2020 10:25:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 10:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUhaIJMmoioMrIeAYxat7xuhdKQl/KHgu8KmCTEWPpWaZQJsAMLaTWUOu/QGKXcoTuKYrBT64K5W0r+WiQJCbWbA4312v20SHfbrQqbwa9CMzuIASUYEnIt4iL1VfeXAyGA70CHTWqabijoGoxoEG+JIAAmp6r2/5eOuITcZ4fNdP8uAtlYtZg2Pt9GqOBqIHgd6Zo45zZUrZxsLrvdr+OgQqvQ0lh+NBICyOl+nQmQ13slk/p+kIxeuoxrtccCM3Nv1Jznx1rgBxpm3pmi9zD/hPdOr2ZDCczxtk5vcmQbtZABNjZ9M2EXOKlawCWeb8zUHBgvl1wDmdbdhZVZFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxSRzyBhIrUcQ4GggL5AIaQpxp8lfUInbvq5mqCJN8c=;
 b=k9SSvvWrV7p5Daq7gvc7qKBI6ubl5gVCWyZi3X1Xbqbx32L/Ime7bXcRoHLAdDwEjvs1kO+3d9UwWbl6/Ib51+X96AdeljCLy2FPPyoY7uh8HoYuj9ZRfj3nwKUdxmKBJkCKAD+moHpGrFfzV1VjmIznqYy/zm3Srk6+n95X2HDsPil0Othzq6TlgJ8xVjsHfNgNWwfEnoKoVVKLgCeh1gFzn/Ks6TJXRlHe8oMm1J0l0MZ/t2k1D3jcbat4tnMjBuyDD5uxVMpCAy4CA6xjt8C/ti8Xl9T6EguQsavhtd36JbpCDnmuwOFEHUMewnMEdF4kqN2XxrMRQMz9ORWlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxSRzyBhIrUcQ4GggL5AIaQpxp8lfUInbvq5mqCJN8c=;
 b=bnTY+6YYUb1ZzM7MY8oAllNlI0QEGOgOmuo+lGFNZOYS3ZoPQWNZOkLEKdCyXgvlOn7gGrW7hgC7owH/yT/VCAr3dGkLvyjzDhpFw+J6hO2OdFaXHhlZNQOJvxhPkOBxjlLE/Lmfvyo13vbDD1Aldx6U89KmtSKW0l2XfMnWaJw=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 17:25:07 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 17:25:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 0/5] Mesh clean up
Thread-Topic: [PATCH BlueZ v2 0/5] Mesh clean up
Thread-Index: AQHWNwXMUWxf+sOf8EKnSsBulrMGBqjEBSMA
Date:   Mon, 1 Jun 2020 17:25:07 +0000
Message-ID: <6c463ba9d28cebcbf1ac338eb5860cf347e2782b.camel@intel.com>
References: <20200531044128.16734-1-inga.stotland@intel.com>
In-Reply-To: <20200531044128.16734-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a185a8-af69-4b72-52e9-08d80650bae7
x-ms-traffictypediagnostic: MW3PR11MB4602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46029C3AA145D016C1BE98FDE18A0@MW3PR11MB4602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yyyyfg0bKN1vDeAKHIvcnQ1yD4s8rwL7gnPxU6fbFGrhCwmLmCvkRXTo+SGhxthsNBu25uySipT1dr9SGrx4T6KErbY6XN9eHjMSxS92bqe7HDj8MKHFiMJTgtiGd/BsH5wbZgxKQw8yfi2mBJJYcD//yCCxdqihcArmw49ZErzAPe8WTyEvLJixzIJOrrM45Z8HDFuykOTtKYEs3i6KG8p5C6XVSS/tYrbnLPfrgIAYvwyBZotWd2Mk/ueM/5h7AxiZpv5K9sobKPUQNE2cwDTOvzgq0M6y+o4QFfuFZkpkYqMzlkcd5Dq2JqWHCb4MbhWZAteKorZYJAN4iodeow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(396003)(366004)(39860400002)(8676002)(6486002)(2616005)(6512007)(8936002)(83380400001)(26005)(36756003)(186003)(86362001)(71200400001)(5660300002)(6506007)(6636002)(66946007)(66446008)(478600001)(76116006)(66556008)(66476007)(316002)(64756008)(110136005)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LwZ3+gzuGN3KH0A8T5iZeXxRMp4hqN2oa6Hhu+NUqeOtd1cyOL3D0ea95FuaJCk3IZXhSWrEh8L051lBkxSIBjnok5E9ojdnL6tWHOEZEVF55+nV9//qAqWOJa8FzFplHGwFb5dA3AIaZ8FvC+YFgXmKjLU7S35WzLzAJjBi/JVDB4AxqvxfLTphlOMRIi10v9A38CC9pud5vBZStgUUBGdEUI3+/Tv/TFS0wCRPpbc399EQGios7kHOIZE0xV0EQkPyLtu0P1yY8WLFiskPIQGDKp9OeOxDgi/q3jeJExo+MByE79a7XZzLuF7fkj5E7BzUhZ99DHB47Ec/anBpCkM8jYC8zw86eBZ0GikbN5kcsuApUEkZRI0M6p328am2/6GrjqyX6sTeNaflPgtHts0EdFddn7BqcuJLBMnzjmzjBv6jDNCwve+g17pd/INjLfk2uyVinAnpHMQtMqOBb1q16R+/8ZVJczMiuGtYSlm+iYrGGUcVPuNKzO420w14
Content-Type: text/plain; charset="utf-8"
Content-ID: <15E88D4D8C39284EBB0AC47642E3F95B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a185a8-af69-4b72-52e9-08d80650bae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 17:25:07.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6GffrnjeH1nSIvJO8CSKYm1odHcRVShFly9BAAKQ+JlyWJdlzYIbOZcMVjNWWrDU+HrotcKIROhcIKKxhvoJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBTYXQsIDIwMjAtMDUtMzAgYXQgMjE6NDEgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IHYyOiBSZXN0b3JlZCBzb21lIGRlYnVnIG91dHB1dCByZWxh
dGVkIHRvIG1vZGVsIGNvbmZpZ3VyYXRpb24gc3RhdGUNCj4gDQo+ICoqKioqKioqKioNCj4gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2VzOiBjbGVhbmVkIHVwIGRlYnVnIG91dHB1dCBzbyB0aGF0DQo+IGhl
eCBwcmludCBpcyBub3QgZXhlY3V0ZWQgaWYgZGVidWcgaXMgbm90IGVuYWJsZWQuDQo+IA0KPiBT
dHlsZSBjbGVhbnVwIGluIG5ldC5jLiBSZW1vdmVkIHVudXNlZCBmdW5jdGlvbnMgZnJvbSBuZXQu
aC9uZXQuYw0KPiANCj4gSW5nYSBTdG90bGFuZCAoNSk6DQo+ICAgbWVzaDogSGVscGVyIHBhY2tl
dCBwcmludCBzaG91bGQgZGVwZW5kIG9uIGRlYnVnIHNldHRpbmcNCj4gICBtZXNoOiBEZWJ1ZyBv
dXRwdXQgY2xlYW4gdXANCj4gICBtZXNoOiBSZW1vdmUgZGVidWctb25seSByZWxhdGVkIGNhbGxi
YWNrIGZvciBwYWNrZXQgc2VuZA0KPiAgIG1lc2g6IENsZWFuIHVwIHN0eWxlIGluIG5ldC5jDQo+
ICAgbWVzaDogUmVtb3ZlIHVudXNlZCBmdW5jdGlvbnMgZnJvbSBuZXQuYw0KPiANCj4gIG1lc2gv
bWFpbi5jICAgICAgICAgICAgfCAgIDMgKy0NCj4gIG1lc2gvbWFuYWdlci5jICAgICAgICAgfCAg
IDYgKy0NCj4gIG1lc2gvbWVzaC1pby1nZW5lcmljLmMgfCAgIDMgKy0NCj4gIG1lc2gvbW9kZWwu
YyAgICAgICAgICAgfCAgNTIgKy0tLQ0KPiAgbWVzaC9uZXQuYyAgICAgICAgICAgICB8IDU3MiAr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9uZXQuaCAg
ICAgICAgICAgICB8ICAzMCArLS0NCj4gIG1lc2gvcGItYWR2LmMgICAgICAgICAgfCAgIDcgKy0N
Cj4gIG1lc2gvcHJvdi1pbml0aWF0b3IuYyAgfCAgIDIgKy0NCj4gIG1lc2gvdXRpbC5jICAgICAg
ICAgICAgfCAgMTEgKw0KPiAgbWVzaC91dGlsLmggICAgICAgICAgICB8ICAgMSArDQo+ICAxMCBm
aWxlcyBjaGFuZ2VkLCAxODIgaW5zZXJ0aW9ucygrKSwgNTA1IGRlbGV0aW9ucygtKQ0KPiANCg==
