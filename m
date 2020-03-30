Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227B5C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD5120771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 22:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qA8KWxyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgC3WHg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:07:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:12394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbgC3WHg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 18:07:36 -0400
IronPort-SDR: wAWRenSQbw6P22gsOy8WC28lFwaIvLiw4tgmUmmUL0rHctgXJ57QDYNOl+prEbcQ31clCzAQNo
 MtaY6qGzfwjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 15:07:35 -0700
IronPort-SDR: a7wcuiGDZVkSv4MmLXQKHvioYeC4eB47RqNenuyv+AsxyRMETuHKcwokxvPHXWmGksS9PDKRm3
 YUOFlJFfnxcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="449945515"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2020 15:07:35 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 15:07:34 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 15:07:34 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Mar 2020 15:07:34 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 30 Mar 2020 15:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrv6Fd7c2VfcDaNlxvkJ+ygpSnUw7BvakKjzuyjiA2dKkFe0g8oeX5cvQH7NfVwUqwdPBJakwIzXZRpPZENIgs2hnh4xSJn1RI3p/BFGTTPvxN22dzaL/Vn6z9kB/CeunzlGdLUiYCy4vWCUrhj6YY0nBzjrR+lTEwqLXyJqe+lAFBXpFTm/W/9oX2VGAbj6SXgrQZ8np9w+61bL8aXg6e6l7Z/ggjrDSraDRO4xCDX9WXIWv61qa5gew4rxINjFfHBX2OF4EJGNsOpRz5ao/5RauoAKEubpZ/HSoZNf50WChbK9C11RE0rxJUVWCoyB5P5S0FBGfr6Qw0mgmut0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmNnrcLN/bfrS/tNSdv7Le/sfg5bgZgI/HOTiGlhHts=;
 b=K1khvuObmbbrtgnG4a0P894Iuvqfn5Og9HmBp40VzWSMKnNsvy16p4p48S/MTSZgSkWRl2ANYhkqrIl58jgWmfw85vLl9qUB/b1VaCHGyCvA4qEnM1B1BrO1dKYx4KLgKcA2b+GpNEXjWutTUGQoqfsghPeX9+hkaemUNLIRXr35bZJKAxiwa32JbMfv4rZ7VadieIhL1/v8gDhb66T6AOKyNTMvbjKFyoGkU0nI4+VjpemRp2PsGr1wc/NPgVU2JxqXxKkgtQSVlcrSnrKdDhh7rwHTrhVDRuG8BLkfbAKf0Aptvv+M/0ZzaOuMMiqJkDTXEc+0AppN6/zZY+n2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmNnrcLN/bfrS/tNSdv7Le/sfg5bgZgI/HOTiGlhHts=;
 b=qA8KWxyToMbeY1q28FPIOPYThNxKlD7n41Y7qSKCr8W8r4klVPBHKbugvPqxg6M9J5tezUBNwJyn46imKTbNoskrDzw4y4L9D+JCOS3/5kByG7SOyiwecqYL/FkXFkWOQrKpqyOnG4e9kz+dbbdzhhSGDwvNOi75e/LYY+EKdlI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 22:07:32 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 22:07:32 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/4] API changes for forward compatibility
Thread-Topic: [PATCH BlueZ 0/4] API changes for forward compatibility
Thread-Index: AQHWBGeY2Y1toiqB7kWHtQ2+a25AzqhhtmeA
Date:   Mon, 30 Mar 2020 22:07:31 +0000
Message-ID: <991a446988c611d3d1b1314ad6b72ee10c4516a8.camel@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
In-Reply-To: <20200327184257.15042-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e37fedd-786d-4c08-92df-08d7d4f6be9f
x-ms-traffictypediagnostic: MW3PR11MB4523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4523D3EA827C8DB993A9E12DE1CB0@MW3PR11MB4523.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(8676002)(81166006)(81156014)(6636002)(66946007)(2616005)(76116006)(2906002)(36756003)(91956017)(8936002)(6486002)(71200400001)(498600001)(186003)(6512007)(66446008)(5660300002)(66556008)(110136005)(6506007)(66476007)(64756008)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89xUirGS0fvKmHXawoecIOeT7iCtuMNEjHGpi/ec57LdUpvPhYdYn54Bj6Z318Jnf3QVJDCSGJBL2MnTKNcvFJGAy0+V5Wa47QdWp+XkrpRgzWQpPAO8XE3GYxLHpDdrOHpmPuIf6HN1+XyPxm9E7Vv095E3DUacwcNlZdx+wNDN1/XUXmPVCCK1mACkQ+XLu8lNaMsFxXDn9EAuosGjx1rUoEaDnPNxJZron1A/GFlzrgcCd46ZKAF9rlYrNcgybUA7iH+eO12HmP8+AVN27caYZZ4Q8F1u67ElTljCFLoR5Fkf9TKP97O0Goi7gZCH/bMhpaVqwEa6oCPsKBnPWkQByIIpU65cFaMQKJfs1AMor9ms+hAnj5tAdv6wLJ3ZkCpchgsGdvOkbwprwP6UpMAcgGJ7NT7/YwxjxTylbsP86O5FbPJL4Xqg8boZjk3E
x-ms-exchange-antispam-messagedata: bjvZh6El+3zGyshFVa6SKf5UN2cKs+aBlryRi1OoF8lO+ckqP+8klxqQXCWbGWcZYh3r/kj/uwy3rsH68F/0lh2jnbOkVZjqP+JrQZLBP90l/y6D2Zcf5i3QeX4fnYqrHP27FlEJe6qCJs32rtpcxw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E48458AFFA0B347B484521E71DE9A2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e37fedd-786d-4c08-92df-08d7d4f6be9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 22:07:31.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: af54Dr31WKkUYPfBu4EE3bN//dyxx8/cIhbJxn3BHgwnn0XR+LOXZAk+AGsgWWlyyd+ojggtMxW/ZHKvj4nNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gRnJpLCAyMDIwLTAzLTI3IGF0IDExOjQyIC0wNzAwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiBUaGUgY2hhbmdlcyBhcmUgY29udGFpbmVkIHRvIE1hbmFnZW1l
bnQgYW5kIFByb3Zpc2lvbmVyIEFQSXMuIA0KPiANCj4gICBUaGUgZm9sbG93aW5nIG1ldGhvZHMg
YXJlIG1vZGlmaWVkIHRvIGFsbG93IGZvciBmdXR1cmUgZGV2ZWxvcG1lbnQ6DQo+ICAgICANCj4g
ICAgIEludGVyZmFjZSBvcmcuYmx1ZXoubWVzaC5NYW5hZ2VtZW50MToNCj4gICAgIA0KPiAgICAg
T2xkOiB2b2lkIFVucHJvdmlzaW9uZWRTY2FuKHVpbnQxNiBzZWNvbmRzKQ0KPiAgICAgTmV3OiB2
b2lkIFVucHJvdmlzaW9uZWRTY2FuKGRpY3Qgb3B0aW9ucykNCj4gICAgIA0KPiAgICAgICAgIFRo
ZSBvcHRpb25zIHBhcmFtZXRlciBpcyBhIGRpY3Rpb25hcnkgd2l0aCB0aGUgZm9sbG93aW5nIGtl
eXMgZGVmaW5lZDoNCj4gICAgICAgICB1aW50MTYgU2Vjb25kcw0KPiAgICAgICAgICAgICAgICAg
ICAgIFNwZWNpZmllcyBudW1iZXIgb2Ygc2Vjb25kcyBmb3Igc2Nhbm5pbmcgdG8gYmUgYWN0aXZl
Lg0KPiAgICAgICAgICAgICAgICAgICAgIElmIHNldCB0byAwIG9yIGlmIHRoaXMga2V5IGlzIG5v
dCBwcmVzZW50LCB0aGVuIHRoZQ0KPiAgICAgICAgICAgICAgICAgICAgIHNjYW5uaW5nIHdpbGwg
Y29udGludWUgdW50aWwgVW5wcm92aXNpb25lZFNjYW5DYW5jZWwoKQ0KPiAgICAgICAgICAgICAg
ICAgICAgIG9yIEFkZE5vZGUoKSBtZXRob2RzIGFyZSBjYWxsZWQuDQo+ICAgICAgICAgb3RoZXIg
a2V5cyBUQkQNCj4gICAgIA0KPiAgICAgT2xkOiB2b2lkIEFkZE5vZGUoYXJyYXl7Ynl0ZX1bMTZd
IHV1aWQpDQo+ICAgICBOZXc6IHZvaWQgQWRkTm9kZShhcnJheXtieXRlfVsxNl0gdXVpZCwgZGlj
dCBvcHRpb25zKQ0KPiAgICAgDQo+ICAgICAgICAgVGhlIG9wdGlvbnMgcGFyYW1ldGVyIGlzIGN1
cnJlbnRseSBhbiBlbXB0eSBkaWN0aW9uYXJ5DQo+ICAgICANCj4gICAgIEludGVyZmFjZSBvcmcu
Ymx1ZXoubWVzaC5Qcm92aXNpb25lcjENCj4gICAgIA0KPiAgICAgT2xkOiB2b2lkIFNjYW5SZXN1
bHQoaW50MTYgcnNzaSwgYXJyYXl7Ynl0ZX0gZGF0YSkNCj4gICAgIE5ldzogdm9pZCBTY2FuUmVz
dWx0KGludDE2IHJzc2ksIGFycmF5e2J5dGV9IGRhdGEsIGRpY3Qgb3B0aW9ucykNCj4gICAgIA0K
PiAgICAgICAgIFRoZSBvcHRpb25zIHBhcmFtZXRlciBpcyBjdXJyZW50bHkgYW4gZW1wdHkgZGlj
dGlvbmFyeQ0KPiANCj4gSW5nYSBTdG90bGFuZCAoNCk6DQo+ICAgZG9jL21lc2gtYXBpOiBGb3J3
YXJkIGNvbXBhdGliaWxpdHkgbW9kaWZpY2F0aW9ucw0KPiAgIG1lc2g6IFVwZGF0ZSBVbnByb3Zp
c2lvbmVkU2NhbiwgQWRkTm9kZSAmIFNjYW5SZXN1bHQNCj4gICB0ZXN0L3Rlc3QtbWVzaDogVXBk
YXRlIHRvIG1hdGNoIG1vZGlmaWVkIEFQSXMNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogVXBk
YXRlIHRvIG1hdGNoIG1vZGlmaWVkIEFQSXMNCj4gDQo+ICBkb2MvbWVzaC1hcGkudHh0ICAgICAg
IHwgMjggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgbWVzaC9tYW5hZ2VyLmMgICAg
ICAgICB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgdGVz
dC90ZXN0LW1lc2ggICAgICAgICB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLQ0KPiAgdG9vbHMvbWVzaC1jZmdjbGllbnQuYyB8IDM2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMDYgaW5zZXJ0aW9ucygr
KSwgMzYgZGVsZXRpb25zKC0pDQo+IA0K
