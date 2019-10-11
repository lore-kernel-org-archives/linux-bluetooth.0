Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A2ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 18:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F1D20640
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 18:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Nklp9CX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJKSPx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:15:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:33615 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfJKSPx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 14:15:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 11:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,285,1566889200"; 
   d="scan'208";a="206525463"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2019 11:15:49 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 11:15:49 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 11:15:49 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 11 Oct 2019 11:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBVvvBbBKHPuTBm0hJ5uSxDRA8bFA8ALp+sxgiaFAVs3ywwQvS3kM7JZKeq4Yaa4LBt+hPuss40PUjcvtL8vjVVxYQ1WmfwswQn8cRglT2xCpe+rOKHoJxoxmfQKdCZ5nS5pHWkmXsotMmxn8o7pDstZUUQE3gqpVl8KtlED0jieHAa5ZQ8y3DPcqXlKtDCIgwjyp5MHsXXJHhk9ONuNqpnmKDmpMyfji27/Urk9As+Jm05H7+R+9vFEqinjRAcKiMkSN7Qv4/TSfcnasLPrxr7eE2G3SBWl6aY0aQ3GiEfTgT0y/RbHMu/GR7h46JUhjWgQ6qNpgd5kLo+znNt84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrw/8Pfajdpuk0Aj7dEvA5iUI3lqpMJma2JeUQEmEOc=;
 b=h25dzruoV3d8KgoK9KacZSnPOf5TTJg5uOKw7/kc6FECnABHj9TT11n1ccbqPhY+SumDNAdenUC2r+wLcydFWKEyxsxzBGl6Rldt2M6Mr/HdtnE6brVVpjiLCyMLpETLTBPpRloJzCrlb7xhZM5Bt3ZO9kNswjLTdIwTVOLlZdKDD6xAhnJLLaEHT916jlPnz03WLgCfeE3+SFgk4HzzvKBQcXfp2mV6APljSSk4CSGd1+UtIRsV0ZlG6BDGhLdjcwj2yCDCdti0fQYvDc7JVRJl61euozJdFSBbpMDS8U+xwq9yUU03xPzZQFPCddgLc8lotqLqeTY/mpIvjJ5laA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrw/8Pfajdpuk0Aj7dEvA5iUI3lqpMJma2JeUQEmEOc=;
 b=Nklp9CX1Rj3NW6BsBwWCol3howSDQrAlJsudyZGMIUEifIvR4CF9i3gqneJeFKk0DJ+2IKBxAwttK1VEwAlDEMJ5A5X2Y+i4iX25h6PKe9Gxizq8d7D+LM3qXo8DJ0PWDIzTuhucWBhwKEnLf9ivsmt8Z9ghW9Xx0wlKSREzQRg=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3209.namprd11.prod.outlook.com (20.176.120.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 18:15:48 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 18:15:48 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "pali.rohar@gmail.com" <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Thread-Topic: Determinate EDR speed
Thread-Index: AQHVgA3afztLEGC5V0S2QInFi2N9RKdVv7OA
Date:   Fri, 11 Oct 2019 18:15:47 +0000
Message-ID: <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
In-Reply-To: <20191011082723.t6w2jcg7v4erlnq6@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57e7b572-e50d-4689-011e-08d74e770a7c
x-ms-traffictypediagnostic: DM6PR11MB3209:
x-microsoft-antispam-prvs: <DM6PR11MB3209D7C548EB16B8F6AB7C5CE1970@DM6PR11MB3209.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(7116003)(256004)(14444005)(486006)(66066001)(99286004)(4001150100001)(71190400001)(71200400001)(8676002)(3480700005)(102836004)(76176011)(6506007)(7736002)(86362001)(81156014)(81166006)(186003)(8936002)(305945005)(26005)(229853002)(478600001)(118296001)(110136005)(36756003)(6436002)(5660300002)(316002)(476003)(66574012)(6486002)(3846002)(6116002)(6512007)(2906002)(2501003)(446003)(11346002)(2616005)(6246003)(25786009)(91956017)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3209;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvEIxc9luHdz5hwXcrueLNAATkgF3IxiGain+2PVqT2VKu3QwT7Q/iF9JagAVYRqi/3FvpgJ4Ao5+p2xR6SGXJ2jSkayTvmEGreC9MflLiT9/Kn4RxXJCCSOez6pszGDbzB77R0HQxFNqHJLHx+0mAaHzXsIl2ox1F3OgT2R752iYx9Xy+YAIrVkqTK3pSKOlbOyC68Gxr6mv7Gts0GINfIUQ4rGhSKyHcO0X2YJOz5OFDhb9xseHUQYFvMdt2ABSlHEmGD5V3n3KWd6LKYVwDP+ed6okxKmoMHw59Z66DXJcMgldPSCKPFiNOGDttGPFKX+S9NXlRkotBSHym/0TuZT3jcP3eZJOmfPsH9pJncnLgsy0pV3n6UFnbSPpfj3eIBrmIJvznwTmiIvs8HmpAgo5mmwCbgbocaccSN6ePE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE6B52152337274D912E80973FCDA19E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e7b572-e50d-4689-011e-08d74e770a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 18:15:47.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8vmkkqUrBJ7Ni+KNJICcjqiHrKLrnyW2sUj+3NeCoy35ByLI+Vysa334/GeJhDi61VcZNlRdv1boqSNFiTDGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3209
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGFsaSwNCg0KT24gRnJpLCAyMDE5LTEwLTExIGF0IDEwOjI3ICswMjAwLCBQYWxpIFJvaMOh
ciB3cm90ZToNCj4gSGVsbG8hDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gYXNrLCBob3cgY2FuIHVz
ZXJzcGFjZSBhcHBsaWNhdGlvbiB3aGljaCB1c2VzIGJsdWV6IERCdXMNCj4gQVBJIGRldGVybWlu
YXRlIEVEUiBzcGVlZCBvZiByZW1vdGUgYmx1ZXRvb3RoIGRldmljZT8NCj4gDQo+IFBhcnRpY3Vs
YXJseSwgSSdtIGludGVyZXN0ZWQgaW4gZGV0ZWN0aW9uIGlmIGJsdWV0b290aCBoZWFkc2V0IHN1
cHBvcnRzDQo+IEVEUiAyIE1icHMgb3IgRURSIDMgTWJwcyBzcGVlZCBhbmQgYmFzZWQgb24gdGhp
cyBkZWNpZGUgd2hpY2ggU0JDDQo+IHBhcmFtZXRlcnMgd291bGQgYmUgdXNlZCBmb3IgZW5jb2Rp
bmcgYXVkaW8gdmlhIFNCQyBjb2RlYy4NCg0KVGhlcmUgYXJlIGEgdmFyaWV0eSBvZiB0aGluZ3Mg
dGhhdCBjYW4gYWZmZWN0IHJlYWwtdGltZSB0aHJvdWdocHV0LCBhbmQgSSB0aGluayBldmVuIEVE
UiAyIHZzIDMgbWlnaHQNCmR5bmFtaWNhbGx5IGNoYW5nZSB0byBmaXQgdGhlIGN1cnJlbnQgY29u
ZGl0aW9ucy4gIElmIHlvdSBoYXZlIHRoZSBhYmlsaXR5IHRvIGhhdmUgZmluZSBjb250cm9sIG9m
IHRoZSBTQkMNCnBhcmFtZXRlcnMsIEkgdGhpbmsgdGhlICpiZXN0KiB3YXkgdG8gYWRqdXN0IGZv
ciB0aHJvdWdocHV0IGlzIHRvIGNob29zZSB3aGF0IHNhbXBsZSByYXRlIGFuZCBzdWJhbmRzIHlv
dQ0Kd2FudCwgYW5kIHRoZW4gc3F1ZWV6ZSBvciBleHBhbmQgdGhlIGJpdHBvb2wgdG8gZml0IHlv
dXIgdGhyb3VnaHB1dC4gKGJpdHBvb2wgaXMgc29tZXRoaW5nIHRoYXQgY2FuIGJlDQpkeW5hbWlj
YWxseSBhZGp1c3RlZCwgSSBiZWxpZXZlLCB3aXRob3V0IHJlLW5lZ290aWF0aW9uKS4NCg0KSG93
ZXZlcmV2ZXIsIHRoZSByZWFsIHF1ZXN0aW9uIGlzIGhvdyB0byB0ZWxsIHdoYXQgdGhlIGluc3Rh
bnRhbmVvdXMgcmVhbHRpbWUgdGhyb3VnaHB1dCBpcy4uLiAgd2hpY2ggaXMNCmNlcnRhaW5seSBh
ZmZlY3RlZCBieSBzdXBwb3J0IGZvciBFRFIyIHZzIEVEUjMsIGJ1dCBpcyBhbHNvIGFmZmVjdGVk
IGJ5IGRpc3RhbmNlLCBSU1NJLCBlbnZpcm9ubWVudGFsIFJGLCBhbmQNCndoYXQgdGhlIG90aGVy
IEwyQ0FQIGNoYW5uZWxzIG9uIHRoZSBjb25uZWN0aW9uIGFyZSBjYXJyeWluZyAoQVZSQ1AgZm9y
IGV4YW1wbGUpLg0KDQpJIGRvbid0IHRoaW5rIGEgc2ltcGxlIGJvb2xlYW4gZm9yIEVEUjIgYW5k
L29yIEVEUjMsIGVzcGVjaWFsbHkgaW4gdXNlciBzcGFjZSwgaXMgZ29pbmcgdG8gZ2l2ZSB5b3Ug
dGhlIGxldmVsDQpvZiBpbmZvcm1hdGlvbiB5b3UgbmVlZC4NCg0KPiANCj4gSXMgdGhlcmUgYW55
IGJsdWV6IEFQSSBmb3IgaXQ/DQo+IA0K
