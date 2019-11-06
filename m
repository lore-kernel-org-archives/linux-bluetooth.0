Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1395BC5DF63
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8DF2075C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qhte+qdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKFQPf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:15:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:12003 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfKFQPf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Nov 2019 11:15:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="227530553"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2019 08:15:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 08:15:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 08:15:33 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 08:15:33 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 Nov 2019 08:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2m2+VL3uhfTJE7/QqECO1rNBRsT32KLA8ccBfJHsvZytRIE+6A0Y6zzE6mNp0VBlJ/nIraf7Q04YxB1jJmpu4iJ2eFb9upuQmdmg4rMONdFyQYS21Wzx1Bsf2GaAWSVb8Sogzb3IeCQQKUBOtJyWudIpk5FhyISi/HzgrBriB9zpX+hNgbovLle58S8JZEvX95QsrRwjesoD+eWLyrAG0YDG553xJfSgJAWEsBS0AAojRQsmhKgJjay4IDXlJNrb5L+HspfwE+qa6bKmNvD0aRovUiU+N8w3eLSN9xnbY67wYfOKf3VR3MQ1+HxB5bIMTwrg50MnFZfjMrn2IPHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bswdjKdTeC8kfKvPpubZqpFQoXkJscFo+zDGpwHfLg=;
 b=bUFwQFYYuEoGgaBy7bO9Gyexq4RaZuw7PyYpyQ2GBwPENU1bgr4IjE8S2/HIWcKAnycRvZMC9RdhsyUPQ7IVYOl6XiEKfhNoFNj7q0j4bjJ0MeKdJ7HyXMcfIGHBFVHlh5EEWK7mVbQSp2OdZ1cW3ToTx1cNLmI7rr3nyOWQCNqmk0zld4oCBxuVy4kdee4TUSLm4ADsA8zPzbKSJlz+6wiYU7/qYxIeuIqaFCUxt2DYvnB76NW2B0TEWZBJ4mjrBrQ7kAswz3GGpJ6mfJJ+D6UEkvUnya1JRrHUYKZ6n5fPlCBBAD/wwAdTXbFBEb+fQQalS+FXkkCyF+CayLn38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bswdjKdTeC8kfKvPpubZqpFQoXkJscFo+zDGpwHfLg=;
 b=qhte+qdiiw7mkjUykphBRPicU4aru+eIEO9IUuXkylT1+wgo8C/RJcMUPrkPEixkE65eWpRbgPWYnjqjeMG06S1DATyDNzMsekvXNVyiCaNc0zsCayZ6uMjYmtQARabMHCZkoXFOmhE+/8dgRtcfN2nH4GZ4WjKrn6QPobvTTdc=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2119.namprd11.prod.outlook.com (10.174.52.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 16:15:30 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 16:15:30 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "nsathish41@gmail.com" <nsathish41@gmail.com>,
        "grzegorz.kolodziejczyk@codecoup.pl" 
        <grzegorz.kolodziejczyk@codecoup.pl>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluez Compilation error for l_dbus_object_manager_enable
 arguments
Thread-Topic: Bluez Compilation error for l_dbus_object_manager_enable
 arguments
Thread-Index: AQHVlGyGFPapvsPgbk2N/3jXOYMjmad92RIAgAALHQCAAG3IAA==
Date:   Wed, 6 Nov 2019 16:15:30 +0000
Message-ID: <c2e2bae7eb80d87ab3b0f452ad409d99a6a25091.camel@intel.com>
References: <CAOVXEJJ=dMe=f8R23JmC_idSV=gy1mmH4NSQTZUpmQPedjgBxw@mail.gmail.com>
         <CALevQMaR8C6-cGkkFrNO2B6MfSEo+rxq=6DHnJTBv39wwOW4VA@mail.gmail.com>
         <CAOVXEJ+H2z2EuJ2BaehN-Z+nAiTELFHH9hc2Ym8MRNckVoL9Cg@mail.gmail.com>
In-Reply-To: <CAOVXEJ+H2z2EuJ2BaehN-Z+nAiTELFHH9hc2Ym8MRNckVoL9Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a4cc7d3-0395-441c-f193-08d762d48b67
x-ms-traffictypediagnostic: CY4PR1101MB2119:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR1101MB2119C000433E255D258C20FEE1790@CY4PR1101MB2119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(186003)(66446008)(118296001)(4326008)(305945005)(64756008)(66476007)(66556008)(53546011)(6506007)(91956017)(66946007)(102836004)(6306002)(86362001)(6436002)(8936002)(26005)(14444005)(256004)(316002)(76176011)(476003)(2906002)(486006)(76116006)(2501003)(7736002)(2616005)(446003)(11346002)(966005)(14454004)(71190400001)(71200400001)(6486002)(110136005)(5660300002)(6246003)(66066001)(3846002)(6116002)(81156014)(81166006)(8676002)(99286004)(478600001)(229853002)(36756003)(66574012)(25786009)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2119;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbUADHh2brLXA9r6WXswdQEz6i3oyYhqxj6iqEC61l/UGgSmKLx7xbxdro5+tVpXgRhCyIDU0gxjzq00P4PXMCisDPCl+T2j/ZgCau5bxuBAeDvZx/CXV0OOEzCiv1wbN2H9exeY4ScPZF6gbWoCoM5GeMEAIJsD2p+iXLRf88J/UtFGL8gpMLNkE2ZDeQCQByRCiSy0jduHuc1e1JTu+QwzMHhUTfiEnjwQUItWsBQPUJkgr8ntn3SZ25B5bLVjd6VRjRmrYhOq6WyC+4f1u9fGARQuN1HNbD4EbiIvWxPCe/qbJ2AcX9Y7F1fg8YNnYKyJMQP7IP5+rOm7KHUIA+3iqUazNTm9qJshn31XI9myo1OkgoJfRkUFiHgMDot0YIOtCVEJ9eLyBGAT1TA41tW+Zkx3ZddBvUQHMfYePxWpkfQYl7GQPJorFN7TyXDTKPWnLnk4XLMRho6GXniDxJ6LWFaZ6nASq4PPtg3iH6Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <62292D7D012BDA42B305B1903BBA78BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4cc7d3-0395-441c-f193-08d762d48b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 16:15:30.6928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4HOUM9BkqNnKe9eRjqK4rJ7RDFt9bthKINiRN4JlksL7zbfJCR8gk0xXZDyAv6MLguhQq8pZJF0E2/S1U17+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2119
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgU2F0aGlzaCwNCg0KT24gV2VkLCAyMDE5LTExLTA2IGF0IDE1OjEyICswNTMwLCBTYXRoaXNo
IE5hcmFzaW1tYW4gd3JvdGU6DQo+IEhpIEdyemVnb3J6LA0KPiANCj4gU29ycnkgZm9yIHRoZSBy
ZXBlYXRlZCBxdWVzdGlvbi4NCj4gTm93IGkgYW0gZ2V0dGluZyB0aGlzIGVycm9yDQo+IA0KPiBt
YWtlWzFdOiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCAnZWxsL3N0cnYuYycsIG5lZWRlZCBi
eQ0KPiAnZWxsL3N0cnYubG8nLiAgU3RvcC4NCj4gTWFrZWZpbGU6MzYyNTogcmVjaXBlIGZvciB0
YXJnZXQgJ2FsbCcgZmFpbGVkDQo+IA0KPiBJIHVzZWQgdmVyc2lvbjAuOSBmb3IgaXNudGFsbGF0
aW9uDQo+IGh0dHBzOi8vbWlycm9ycy5lZGdlLmtlcm5lbC5vcmcvcHViL2xpbnV4L2xpYnMvZWxs
Lw0KDQpWZXJzaW9uaW5nIGluIEVMTCB3b3JrcyBkaWZmZXJlbnRseSB0aGFuIHN0YW5kYXJkIGRl
Y2ltYWwgbm90YXRpb24uDQoNClRoZSB2ZXJzaW9uIG9mIEVMTCB0aGF0IHlvdSB3YW50IGlzIDAu
MjYNCg0KPiANCj4gUmVnYXJkcywNCj4gU2F0aGlzaCBODQo+IA0KPiBPbiBXZWQsIE5vdiA2LCAy
MDE5IGF0IDI6MzIgUE0gR3J6ZWdvcnogS2/Fgm9kemllamN6eWsNCj4gPGdyemVnb3J6LmtvbG9k
emllamN6eWtAY29kZWNvdXAucGw+IHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFBsZWFzZSB1
cGRhdGUgZWxsIGxpYnJhcnkuDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBHcnplZ29yeg0KPiA+
IA0KPiA+IMWbci4sIDYgbGlzIDIwMTkgbyAwNzozNSBTYXRoaXNoIE5hcmFzaW1tYW4gPG5zYXRo
aXNoNDFAZ21haWwuY29tPiBuYXBpc2HFgihhKToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBJ
IGFtIGdldHRpbmcgdGhlIGJlbG93IGVycm9yIGZvciBjb21waWxpbmcgdGhlIGxhdGVzdCBibHVl
eg0KPiA+ID4gDQo+ID4gPiB0b29scy9tZXNoLWNmZ2NsaWVudC5jOjE2OTA6NzogZXJyb3I6IHRv
byBtYW55IGFyZ3VtZW50cyB0byBmdW5jdGlvbg0KPiA+ID4g4oCYbF9kYnVzX29iamVjdF9tYW5h
Z2VyX2VuYWJsZeKAmQ0KPiA+ID4gIDE2OTAgfCAgaWYgKCFsX2RidXNfb2JqZWN0X21hbmFnZXJf
ZW5hYmxlKGRidXMsICIvIikpDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+
IFNhdGhpc2ggTg0K
