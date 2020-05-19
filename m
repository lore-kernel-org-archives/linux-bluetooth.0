Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 21:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BF620DD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 21:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cAH0kV4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgESVnL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 17:43:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:22380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgESVnK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 17:43:10 -0400
IronPort-SDR: 3gAKzKadxWQAlMVws77qF9+UcIJqJKAbbwz6Q36k5V09YotZQDvC+hXIGjjtc0kC0p7NUzvehJ
 I03I2Z0ed0dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 14:43:09 -0700
IronPort-SDR: lac7JnqKoPQA7Xwd+eJGYla5D8Bwrgc8tn1zcQK/IgOj8J3rXnHdhdNwx0piFxGuetHvLp09KB
 U1FUJB2PBQxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="scan'208";a="439778586"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2020 14:43:09 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 May 2020 14:43:08 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 May 2020 14:43:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 19 May 2020 14:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAVVCdzX4O/v55tc8AmTnIALXX+1eSyNBSBHMzX+oylI3XqE0JyeLWekNDAXtI+3la7HymU5YVuwDQCwpSCq0LHeOk3JtVv4EiruwKpNfp3dywXkfEtyEt8TiWQnz+TP7WxUA4xezc4EFuVUCg+8zVECocsOxbmpWbjEDET1JP8RIgaZnOQN2lmScunETZa+LPOPxsOVUDvEvqLtBAYZN13fSkh6/tMCIopHLIrD+r9VmT1xq/j/5DGK/FcfvAg/cL0UZudkpMhgc74hYS2fMZz2n2dOFIcEwJ6I7etJ4VH7MScLNyVkX+Mwe6a7m65w7DA6v/+GiLM6ARAdwsdaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miBd/gt91xf3B8m+2CevBa4BY8UUtWkDpk4dTSfxTOY=;
 b=ZZPtQENuY1MCBhLizYSFmSzAA9DVz9RzbRlGU3KkJBRQda9lrICbWWXAPzLozhg7D1iUfUAoqRqa8KFHds/aKDVaJAh7EPcxRj8zyseQe5maikHrInuglqutQd9ci6juia76UosphazBDjyaywXW24FLJYBmairTTA9RIxkNH4fjyflXQHhtBLrpwEXcNvfCtahpemWeTG6QyyBrjtuZrsYTQwFz1GgW6uzdxgTjdBvh0KkVKe9Ll5Ep3nCjZWMXQSX5aI2aIFS8pxY8x1MJ+zdUMxNuy8ler7lixz7AoRTviitiNjsfGHinCiPownpm71+l370lw+sVr0jEOiJ6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miBd/gt91xf3B8m+2CevBa4BY8UUtWkDpk4dTSfxTOY=;
 b=cAH0kV4qtyGGSWmQ9mUgG8cbJg/6AUYRfDherpuyAOYXsmk5LNRM7kAr1KDBDMren+RA4Q8LuViVpf/GyQOoncmEKyxMQZOC7cweMObrAs5i2Jz0ZOZmFFsKgfmftTlyA/tgZIyOn/3N89mlJD/38cGhpAq3rdcSvKIGjKvDVI4=
Received: from DM5PR11MB1468.namprd11.prod.outlook.com (2603:10b6:4:4::20) by
 DM5PR11MB1835.namprd11.prod.outlook.com (2603:10b6:3:114::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24; Tue, 19 May 2020 21:43:06 +0000
Received: from DM5PR11MB1468.namprd11.prod.outlook.com
 ([fe80::a4e3:18e1:e433:c4ef]) by DM5PR11MB1468.namprd11.prod.outlook.com
 ([fe80::a4e3:18e1:e433:c4ef%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 21:43:06 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
CC:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Subject: Re: [v3,1/4] a2dp: Fix caching endpoints for unknown version
Thread-Topic: [v3,1/4] a2dp: Fix caching endpoints for unknown version
Thread-Index: AQHWLh265hZXqbz+HE6RhmIuP9Uxw6iv5mmA//+U+AA=
Date:   Tue, 19 May 2020 21:43:06 +0000
Message-ID: <85003180-1126-4D5D-9B74-745593E58643@intel.com>
References: <20200519200345.217345-1-luiz.dentz@gmail.com>
 <5ec4441d.1c69fb81.6be43.3c0a@mx.google.com>
 <CABBYNZ+j1a+dvaNj6+W4DDwed-1N5cXGXw7v9bGPVv1z8c+81g@mail.gmail.com>
In-Reply-To: <CABBYNZ+j1a+dvaNj6+W4DDwed-1N5cXGXw7v9bGPVv1z8c+81g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.37.20051002
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10ca6836-4582-4fd2-1aa0-08d7fc3d9de7
x-ms-traffictypediagnostic: DM5PR11MB1835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1835927A24F45EDF8502F1F7FFB90@DM5PR11MB1835.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqcEdLJXasm1e0FvjvXLn2leKptbhhpNI6n8X4d8nXZCRQTjt/U2Gq4RToRo+V5iJd66ISrZ6DZnOUApc5BVs7iJbCyBSC24PtG5x457Wx64PBlEYPhlQs6w6Dz4dThp9nRTajZss8VPzNDkt4vOFbWGSRCG7K01l0xf6HVaVBkWiqL4f0Zabz4jNLeMvyWnNHam6LjmTA8P5YlzPK2FD9Fz7UxwmxLmYdeKXQxWbAWIfzt+vLsu6dEypRx4LHylWzGXD64dEITV8sqVrj3CogFj6SS2kjEFtYk/qLghXeX5Zw1wUHY47hqdLsY/HxHLwYUbtrvNpppnBnZ0o7UGvNqVHqq5zZlrJMeeG/95eHj8IUwDBMvsn5DMh5yc6+hZLCDsOOyPqoYJqiYNCK11FxrSrVrue8QCMDbnm8aQinio39TaZ/BfC43bDK2IhIz6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1468.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(6512007)(2616005)(6486002)(316002)(8676002)(2906002)(110136005)(33656002)(86362001)(6636002)(71200400001)(8936002)(53546011)(186003)(64756008)(66556008)(66446008)(6506007)(66946007)(91956017)(26005)(66476007)(76116006)(4326008)(36756003)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KDIDr4j5I90aEsBjufwO/hix9u2NS/eXP5MOGXowNA16ll3b62rbS51Lp1hO2lJgagTk1j6DhsXaYwzv7lJSHRla9FNqvX5VfL/+IrCkWli83AyRCLMjBlDUSj1F/JaxWgqeoY6Xp1WI5VIsQdsY6m3uInupTF0HsFgtubE98XoGbAwdVORd/0poiJteNQJwbydJXsPyVvxRH95ALLXpv1rTo+q8lUsIydh+gEFSOLSVxw2KgFoe68rBcglFbNnhXex8SFHe9I/olOSYf0AUyZRUQVUsO8T333C/wPMyv9n8DojVsJP4NFrqvunvANgeBm9y66Bx5NI20aYZDF+lXu2dwSKgIULtsk7ARSKG82aW6pvr1b1XQz2EOH0Kp/qG3WEGViZo9UwWx01TLBYRKywjF6dhWMlYyvZTChGKVt/gR9YIVATc3KPZ4p3zReUV9+ht6IDBDQU+T85jNGDOWSakvD3tysbwQbk5en2yExVGvTcmEEIuiRsSXP7vAfeg
Content-Type: text/plain; charset="utf-8"
Content-ID: <223083763BCB1745AC5EBB2F07AA51E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca6836-4582-4fd2-1aa0-08d7fc3d9de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 21:43:06.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkcDY3AIbikDUrMg/bmpQmqvbhtL1PR7Wp4I+tRf8lHm5qiKH7dHQhY0a+MjABE/u6wkMMj57BEtEoj/pLSH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1835
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeg0KDQpUaGUgZmFpbHVyZSBpcyBmcm9tICJ0ZXN0LW1pZGkiIGZyb20gdGhlIG91dHB1
dC4gSG93ZXZlciwgdGhlIGN1cnJlbnQgc2NyaXB0IGRpZG4ndCBzYXZlIHRoZSB0ZXN0LXN1aXRl
LmxvZy4NCkkgaGF2ZSBhbm90aGVyIHRlc3Qgc2V0dXAgb24gYSBkaWZmZXJlbnQgYWNjb3VudCBi
dXQgdGhlIHRlc3QgcGFzc2VkIG9uIHRoYXQgc2V0dXAgd2l0aCBzYW1lIHBhdGNoIHNldC4gU28g
aXQgY291bGQgYmUgdGhlIGZhbHNlIHBvc2l0aXZlIGFzIEJyaWFuIG1lbnRpb25lZC4NCg0KTGV0
IG1lIG1ha2UgYSBjaGFuZ2UgdG8NCi0gY2FwdHVyZS9zYXZlIHRoZSAidGVzdC1zdWl0ZS5sb2ci
IGlmIHRoZXJlIGlzIGEgZmFpbHVyZQ0KDQpBbHNvLCBJIHJhbiBhZ2FpbiB0aGUgaXQgcGFzc2Vk
IGF0IHRoZSAybmQgdGltZS4gDQpJIHdpbGwgZGlzYWJsZSB0aGUgdGVzdC1taWRpIHVudGlsIHdl
IGZpeCB0aGlzIGlzc3VlLg0KDQpSZWdhcmRzLA0KVGVkZA0KDQrvu79PbiA1LzE5LzIwLCAyOjA3
IFBNLCAibGludXgtYmx1ZXRvb3RoLW93bmVyQHZnZXIua2VybmVsLm9yZyBvbiBiZWhhbGYgb2Yg
THVpeiBBdWd1c3RvIHZvbiBEZW50eiIgPGxpbnV4LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5l
bC5vcmcgb24gYmVoYWxmIG9mIGx1aXouZGVudHpAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIEhp
IFRlZGQsDQoNCiAgICBPbiBUdWUsIE1heSAxOSwgMjAyMCBhdCAxOjM5IFBNIDxibHVlei50ZXN0
LmJvdEBnbWFpbC5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+DQogICAgPiBUaGlzIGlzIGF1dG9t
YXRlZCBlbWFpbCBhbmQgcGxlYXNlIGRvIG5vdCByZXBseSB0byB0aGlzIGVtYWlsIQ0KICAgID4N
CiAgICA+IERlYXIgc3VibWl0dGVyLA0KICAgID4NCiAgICA+IFRoYW5rIHlvdSBmb3Igc3VibWl0
dGluZyB0aGUgcGF0Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4NCiAg
ICA+IFdoaWxlIHdlIGFyZSBwcmVwYXJpbmcgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcywgd2Ug
Zm91bmQgdGhlIGZvbGxvd2luZw0KICAgID4gaXNzdWUvd2FybmluZy4NCiAgICA+DQogICAgPiBU
ZXN0IFJlc3VsdDoNCiAgICA+IG1ha2VjaGVjayBGYWlsZWQNCiAgICA+DQogICAgPiBPdXRwdXRz
Og0KICAgID4gLi90ZXN0LWRyaXZlcjogbGluZSAxMDc6IDE0ODQxIEFib3J0ZWQgICAgICAgICAg
ICAgICAgIChjb3JlIGR1bXBlZCkgIiRAIiA+ICRsb2dfZmlsZSAyPiYxDQogICAgPiBtYWtlWzNd
OiAqKiogW01ha2VmaWxlOjk3MjY6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxDQogICAgPiBtYWtl
WzJdOiAqKiogW01ha2VmaWxlOjk4MzQ6IGNoZWNrLVRFU1RTXSBFcnJvciAyDQogICAgPiBtYWtl
WzFdOiAqKiogW01ha2VmaWxlOjEwMjI4OiBjaGVjay1hbV0gRXJyb3IgMg0KICAgID4gbWFrZTog
KioqIFtNYWtlZmlsZToxMDIzMDogY2hlY2tdIEVycm9yIDINCg0KICAgIENhbiB5b3UgZ2l2ZSBh
IGxvb2sgd2h5IENJIGlzIGNvcmUgZHVtcGluZyBoZXJlLCBhbHNvIHBlcmhhcHMgd2UNCiAgICBz
aG91bGQgaW5zcGVjdCB0aGUgdGVzdC1zdWl0ZS5sb2cgd2hlbiB0aGlzIGhhcHBlbnMuDQoNCiAg
ICAtLSANCiAgICBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQoNCg==
