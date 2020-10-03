Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F353CC41604
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90754206CD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 13:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="THzjRrRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJCNRm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 09:17:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:43562 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgJCNRl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 09:17:41 -0400
IronPort-SDR: hz16tbLZfc+soDBX9T7xb93Wjz3Z6GiY1NLtheabFDT4Hfx94Sm42hhE0DyBqMt1rB85HPoxBD
 ce0QlrNbfDOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="227344399"
X-IronPort-AV: E=Sophos;i="5.77,331,1596524400"; 
   d="scan'208";a="227344399"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 06:17:33 -0700
IronPort-SDR: dEhGplbaJdXDJlx9PjP+7H1tny/M9wGe0Hg6InTaNycZu5iuuiCVCAOHigDLyANdsIDzxAEYNX
 g4HTy8xevhlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,331,1596524400"; 
   d="scan'208";a="515461376"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2020 06:17:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 3 Oct 2020 06:17:31 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 3 Oct 2020 06:17:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 3 Oct 2020 06:17:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 3 Oct 2020 06:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OthA6lr96WyiH6Gq2gilqDZsbJWeX6z+ZQfGmSkRBc9R6FDWMKrbltMoMPEtgHoWaM7apRA7R0P5c/B2TWWqwJMkuI47tW+CmXbvJ3lzIA6Uf0aA0aHsagDt4Zw3JhrzLNdWvToGNrovX3oFxCr3b0cAa4yjWzXnPLUHFvzoNYGFLlsUKQrZaU6/VtjrG1TEkpKT+OJ0fYT+xMZHgY40RRHkrbPSWbtDcFM8C2jeRXuRTXTHahZ6Cvc53du4+E/q6jzmG790SKQtoxan2TWcIg4GtlzpF0/9PednocuGyiJrtxsJ0aE5IfJoVxWeh5bfvBEhQmKReETvXMZ5HAbuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9p6zcqGk9xMrcmzpVfd/xx6gVL4+kKi3K3SGtlFDL4=;
 b=EVUlssqqC4lTNgz5gTbyRijoKb3dnVohZ7rZbjzQ7BtiB7Je7R1nEL8B2crjhN1Nqrz5lnKe5GLva7FXouLgnAhZirPz8SJg+j4o5rpZtOa/DrM7ZX1Hu9hlH0C8j1M410PT/cClpWmq0nNxKwIkJ6B56NX9Ngqt4neiJBQQvo1y3hMem6RuOEeJiNjhc28fd1ikKi+WcUMfpWDTPLSVCkaJqv5JPv77M8c4KpQo/0VQFiIQCCz5YE6LK5X7xsvggfpRv21vgt1j42vpJ09YXn2EK0f90cS7rRe6yJT3EvoqCvBVlVv0hDRowdeK+elxNct27X8ujMpOsGbp1gW8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9p6zcqGk9xMrcmzpVfd/xx6gVL4+kKi3K3SGtlFDL4=;
 b=THzjRrRNDwI9HUiWSvgrEakHU2li4WJiFMvyKganxFpYSiYlIOWEQuPikeJPN5NqN5ItKN9DAybfBVcKVuQkzTn7pgOwprhooR/Ju7QCx/jKiAkfc66LN1BhPxcISnHSv01P3tfnbcxAZ0HyDieskZo7FMKxGUmPsCZPh5DnUII=
Received: from DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) by
 DM6PR11MB3868.namprd11.prod.outlook.com (2603:10b6:5:19f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Sat, 3 Oct 2020 13:17:28 +0000
Received: from DM6PR11MB3146.namprd11.prod.outlook.com
 ([fe80::a832:f79a:3a:1159]) by DM6PR11MB3146.namprd11.prod.outlook.com
 ([fe80::a832:f79a:3a:1159%6]) with mapi id 15.20.3391.028; Sat, 3 Oct 2020
 13:17:28 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>, Kiran K <kiraank@gmail.com>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v5 1/2] Bluetooth: btusb: use usb vid/pid for initializing
 hal callbacks
Thread-Topic: [PATCH v5 1/2] Bluetooth: btusb: use usb vid/pid for
 initializing hal callbacks
Thread-Index: AQHWmVu2sD3RSWkX8UiSW7P1YZwBf6mFiz0AgABQc+A=
Date:   Sat, 3 Oct 2020 13:17:28 +0000
Message-ID: <DM6PR11MB31464DDCB9BDA1110F888E5CF50E0@DM6PR11MB3146.namprd11.prod.outlook.com>
References: <1601712179-13540-1-git-send-email-kiran.k@intel.com>
 <5B30E5BC-6631-40C3-8EDE-C69E62064D35@holtmann.org>
In-Reply-To: <5B30E5BC-6631-40C3-8EDE-C69E62064D35@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.167.33.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afa4d5dc-8bc4-465b-f4cd-08d8679ead3f
x-ms-traffictypediagnostic: DM6PR11MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3868F65C9D5A8AB4F658778FF50E0@DM6PR11MB3868.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/QeUNqNqUOIHWVFcA2E9XH4CI1GtqcHV6tl9I2k1oI5jiAnYzLmkF4QrCBucvSbwqlH/HD1dyGc7Y+6+4z3C0y2htblh83H6tj8TX012Pfo2P5nkEVL2wXgyrxo6aleigDx0lVoT16CiNZcqplCZMdww4d3VmTbaRAS0YaXWabgHRzCnIejGcmaptMS9sgcnwJAcmvm0trJ+E44JyktcGjdUEXHc1ipKV4BpceeoxAks7AL2+x441AQUNlPqX3ge7ynHZIvv2TsG5dKo0Zb4ZZPoH0JusMd/2Wl8BXLp463NvOFSN1iP44tQdHJSQRYntbzbTmyXF28wLl++vg+Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3146.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(6506007)(8676002)(4326008)(53546011)(54906003)(83380400001)(8936002)(316002)(2906002)(71200400001)(110136005)(86362001)(52536014)(186003)(26005)(55016002)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(7696005)(9686003)(5660300002)(107886003)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /pl3c/FUKHA6iGets6RkfS38gsoYD5T0IMKMBHPxiRVJn3nv2hoh+YlQspii/4TaRSgFsM1b+Ez1NGXxa+oSlL9JzUOv9M1Kxw/ZhL4s8DKos2dJNK9HHnObv63f5fZVIuR4i+pKIGiFz7mlqmENfMWkK74KJv87bSYPFuPmCxJmrMCiaiq4fdKLuhPUpLR4DlgLbj6EFAj9J38vQv2kbHWmxZ+MF+wuqMg++YjuK6FCaagZDDqWwTauujPqyqvhXKhed2Qei63SUD6iItfuADzG0Kii0nt/K87qU2Kq38PiU5wbW//OpaRm4pefE6YZVF0agQWRp5yTigbNN6Ja5dNl9/bW5WvrprgI/1Qsw/HOJrFNFcjDWmCudG++kSnnVteK2rXMi+bxOCrEGUiZWi3nlZZEvYyWB1Bruh7Fcdm89CCT6/2ey0obmHFU1FLKbpNlsa965+8Rwy1TDOHk09aXpFD4/IpgnDtr+Ij6RlOIuJ+y57lWwro9RLN5s06ZNffE2HKYAxtRYhWLQniDdQGD7CRRgogYDgMXa4LUPdNsBLGDYnccWAm3iKYHgIfnVkNZ4CtBNzw5SXxXQSHH5EIhtUOX7AfOrQEXxGjKeyV4eNPmGKGcVV/HPELG8qUFRkT1/V71lAvJhV2ZX1oWfQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3146.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa4d5dc-8bc4-465b-f4cd-08d8679ead3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2020 13:17:28.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1F8BRQya6eHfpfdBaJ7MKeEtBIoQnobIgLcx0e9f+vkhnBSJKju0NlosaR1gw0jbSJMLuvzKM+nRvDbLoxjQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3868
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNl
bCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9i
ZXIgMywgMjAyMCAxOjU3IFBNDQo+IFRvOiBLaXJhbiBLIDxraXJhYW5rQGdtYWlsLmNvbT4NCj4g
Q2M6IGxpbnV4LWJsdWV0b290aCA8bGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47IE5h
cmFzaW1tYW4sIFNhdGhpc2gNCj4gPHNhdGhpc2gubmFyYXNpbW1hbkBpbnRlbC5jb20+OyBUdW1r
dXIgTmFyYXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+
OyBTcml2YXRzYSwgUmF2aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNv
bT47IEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NSAxLzJdIEJsdWV0b290aDogYnR1c2I6IHVzZSB1c2IgdmlkL3BpZCBmb3IgaW5pdGlhbGl6aW5n
DQo+IGhhbCBjYWxsYmFja3MNCj4gDQo+IEhpIEtpcmFuLA0KPiANCj4gPiBGb3IgSW50ZWwgY29u
dHJvbGxlcnMsIHVzZSB2aWQvcGlkIGZvciBpbml0YWxpemluZyBoYXJkd2FyZQ0KPiA+IGFic3Ry
YWN0aW9uIGxheWVyIGNhbGxiYWNrcyB0byBhdm9pZCBkZWZpbmluZyBuZXcgcXVpcmsgZmxhZ3Mg
Zm9yIG5ldw0KPiBwcm9kdWN0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtpcmFuIEsgPGtp
cmFuLmtAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gKiBVc2Ug
dXNiIHZpZC9waWQgY29tYmluYXRpb24gdG8gaWRlbnRpZnkgY29udHJvbGxlciB0eXBlIGlzdGVh
ZCBvZg0KPiA+IHVzaW5nIGZsYWdzDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHByZXZpb3VzIHZlcnNp
b25zOg0KPiA+IE5vbmUuIFRoaXMgaXMgYSBuZXcgcGF0Y2ggY3JlYXRlZCBwYXJ0IG9mIHY1DQo+
ID4NCj4gPiBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIHwgNzkNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCA0
OCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+
IGluZGV4IDEwMDViNmUuLmUyY2Q3OGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9v
dGgvYnR1c2IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiBAQCAt
Mzk2OSwxMyArMzk2OSwyMSBAQCBzdGF0aWMgaW50IGJ0dXNiX3Byb2JlKHN0cnVjdCB1c2JfaW50
ZXJmYWNlDQo+ICppbnRmLA0KPiA+IAlpbml0X3VzYl9hbmNob3IoJmRhdGEtPmN0cmxfYW5jaG9y
KTsNCj4gPiAJc3Bpbl9sb2NrX2luaXQoJmRhdGEtPnJ4bG9jayk7DQo+ID4NCj4gPiAtCWlmIChp
ZC0+ZHJpdmVyX2luZm8gJiBCVFVTQl9JTlRFTF9ORVcpIHsNCj4gPiAtCQlkYXRhLT5yZWN2X2V2
ZW50ID0gYnR1c2JfcmVjdl9ldmVudF9pbnRlbDsNCj4gPiAtCQlkYXRhLT5yZWN2X2J1bGsgPSBi
dHVzYl9yZWN2X2J1bGtfaW50ZWw7DQo+ID4gLQkJc2V0X2JpdChCVFVTQl9CT09UTE9BREVSLCAm
ZGF0YS0+ZmxhZ3MpOw0KPiA+IC0JfSBlbHNlIHsNCj4gPiAtCQlkYXRhLT5yZWN2X2V2ZW50ID0g
aGNpX3JlY3ZfZnJhbWU7DQo+ID4gLQkJZGF0YS0+cmVjdl9idWxrID0gYnR1c2JfcmVjdl9idWxr
Ow0KPiA+ICsJZGF0YS0+cmVjdl9ldmVudCA9IGhjaV9yZWN2X2ZyYW1lOw0KPiA+ICsJZGF0YS0+
cmVjdl9idWxrID0gYnR1c2JfcmVjdl9idWxrOw0KPiA+ICsNCj4gPiArCWlmIChpZC0+aWRWZW5k
b3IgPT0gMHg4MDg3KSB7DQo+ID4gKwkJc3dpdGNoIChpZC0+aWRQcm9kdWN0KSB7DQo+ID4gKwkJ
Y2FzZSAweDAwMjU6DQo+ID4gKwkJY2FzZSAweDAwMjY6DQo+ID4gKwkJY2FzZSAweDAwMjk6DQo+
ID4gKwkJY2FzZSAweDBhMmI6DQo+ID4gKwkJY2FzZSAweDBhYWE6DQo+ID4gKwkJCWRhdGEtPnJl
Y3ZfZXZlbnQgPSBidHVzYl9yZWN2X2V2ZW50X2ludGVsOw0KPiA+ICsJCQlkYXRhLT5yZWN2X2J1
bGsgPSBidHVzYl9yZWN2X2J1bGtfaW50ZWw7DQo+ID4gKwkJCXNldF9iaXQoQlRVU0JfQk9PVExP
QURFUiwgJmRhdGEtPmZsYWdzKTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+IAl9DQo+
IA0KPiBwbGVhc2UgZG9u4oCZdCBkbyB0aGlzLiBUaGlzIGlzIGV4YWN0bHkgd2hhdCBJIGRpZG7i
gJl0IHdhbnQuIExpc3RpbmcgUElEIGluIHRoZQ0KPiBkZXZpY2UgdGFibGUgYW5kIHRoZW4gYWxz
byBhZ2FpbiBpbiB0aGUgcHJvYmUgY2FsbGJhY2sgaXMgYm91bmQgdG8gYmUgZXJyb3INCj4gcHJv
bmUuDQo+IA0KDQpHb3QgeW91ciBwb2ludC4gSSB3aWxsIHNlbmQgdGhlIGZpeCB3aXRoIEJUVVNC
X0lOVEVMX05FV0dFTiBhcyBkaXNjdXNzZWQgZWFybGllci4gIFRoYW5rcy4NCg0KPiBSZWdhcmRz
DQo+IA0KPiBNYXJjZWwNCg0KUmVnYXJkcywNCktpcmFuDQoNCg0K
