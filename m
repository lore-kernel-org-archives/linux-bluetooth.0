Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4712C56202
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E8520725
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 08:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IFthXXIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgJ2IMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 04:12:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:58453 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgJ2IMj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 04:12:39 -0400
IronPort-SDR: HMKsEEBUijt68nluRX4hF+OvFdiend37yTDeS42AD+sGX85cuSIm9WiGLltj93qWeeuoL8UyJV
 iGWOpy+Dv4Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="147666379"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="147666379"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 23:07:55 -0700
IronPort-SDR: 8NQgHUuYYshSVMaDayQ0mV0sbsoz7ZpHIukmQRLd9Is57E14wrJ2xi1XIuk+AyLBzuuDSGLV76
 ZthfYlnHBQtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="361380645"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2020 23:07:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 23:07:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Oct 2020 23:07:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 28 Oct 2020 23:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWmaXajNPt8RniviCjLjgS5QhtgAEAD1DohqPQ9uYbrG4qL0kFOwYjobMOqW5fFNOnkjcPMFhnTKctPJlQtVIUCgYzKODaeJrdNk8dXClm3lRAIFDWRy33yLh74X4l/tAkBjIqa6mHgOCLYPE8tQCs++Ds1HB1xbXq2eOOTpmhCQ+yZP18PM1cJJcio4R/bLyipjVtEvMie+CmB/wKazwOE9mxLBSirYoxkv1rVmDeFNLRK6URi976FCfpkZpFlebVnKCJtodapb0Vix5/Cg0rQLdm3CMY6nleTWs5Y2lUNkp7t8IWpWQFgwP/3d2179KOFg7PaIeLtmnQsee5USmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZGtMM2E+pb4dyyPattfO+fIyaERCfQs0YgZLObAhOU=;
 b=ZjKqi5s0Zd20hYaxrCS/ccXaEBsKlnzbnLkYbnRPUMzBTtif/yy2O2murKM8cKULrxnJkrDgmlRJDPG+oeb2jZZTyN70iQDRrzKvrdHtYkW67kBPdrHMzPwFheVwLeF1v8yPTT6sA+poBjxT4Q3AMp6KepeKNpHw9HA04FP+RfAcEU8OOcHdmjAtlfRrZ85TFoK/07zc1skK27qQ4dkW6+FMEtde3mZI3ybXepr+A2k8dHH5W6dyeHqotGuEYVwvvg7ursjptoC4UEH7O2hQnEzWg4YXUcRLV2C5PiygOv7qlulN1k9OQ4aWBPPg3hFHTmOMzzQ+TNjaEeszzoMQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZGtMM2E+pb4dyyPattfO+fIyaERCfQs0YgZLObAhOU=;
 b=IFthXXIfoVkBHsTZ1Ydy3kNvfTbnfgqps1WtBBX7uCDssQgg3MFsVy5WwIDElSYmHGueekM9Nkfavw6ErRvss8sVO+Fx8w6VhrNQMrtz4/V3a8DDFzFZKhveNgdj+UQ0oUF9bu+P4R+CFXskKzG63ZQ5s4wDHeCBszpDjSoAmn0=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SN6PR11MB3469.namprd11.prod.outlook.com (2603:10b6:805:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 06:07:52 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::cc77:c9c8:8d2b:bb35]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::cc77:c9c8:8d2b:bb35%6]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 06:07:52 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>,
        Sathish Narasimman <nsathish41@gmail.com>
Subject: RE: [PATCH 2/3] Bluetooth: btintel: Introducing new btintel read
 version
Thread-Topic: [PATCH 2/3] Bluetooth: btintel: Introducing new btintel read
 version
Thread-Index: AQHWqEwMuIr0KDksAkSaEcBEzeskhqmuF/kAgAAKsBA=
Date:   Thu, 29 Oct 2020 06:07:52 +0000
Message-ID: <SN6PR11MB2703D89B6AC12B2BCA4AB47E94140@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20201022082435.31831-1-sathish.narasimman@intel.com>
 <20201022082435.31831-3-sathish.narasimman@intel.com>
 <20201029052808.GB3990@linux.intel.com>
In-Reply-To: <20201029052808.GB3990@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [27.6.184.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf3f9828-dc34-4822-31ea-08d87bd0f856
x-ms-traffictypediagnostic: SN6PR11MB3469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB34697842F5E834CDFD3E2C5494140@SN6PR11MB3469.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxIUBrsNhm4U2Eo8LHd/GbYPj0yI1S6K3S3+0TC8eW58L260neyX7yUjEper2ey42Y2F0oPTTYYvJInKInKm96GwDAPw6hcIaAzxe6/TanytX2ii+JyTEogztdJLygQU4SygD9E9NwVWzgtzax8Ea52jI6cwkkemQpJRgqqyVLU3D7XNXbG4wAyyyYxh5NscyCfzhXgvUXZW6uMWjpqy5aRv8JNNIzcIUHk/38ydiYGWK5vRbVy2lUiCnIz3/40YwDqWPzSOieeyHh+w/U5pCe9uthBxOIuQxydbad7fpKpcD9hr0NCGo345Rr3WuEW5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(4001150100001)(76116006)(66946007)(71200400001)(54906003)(110136005)(316002)(55016002)(86362001)(53546011)(9686003)(52536014)(26005)(4326008)(2906002)(6506007)(64756008)(66476007)(66556008)(66446008)(5660300002)(8936002)(478600001)(7696005)(83380400001)(33656002)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NR+STodlG/a0VdRX2W5FyKCCnI967l7gb8Kn4Gio3FX9wqswge32/mMgrJc/h86+nxduIefialEVc3f3kunDpnd/17RILA44mpA49w4wNJN9fBMUrvA4D+oGdhWGhJESBlI7ShFIxuOTgiiLvAXR5ONtqt0vTGCZpoymXNzh8BfR6hxLc8rdJ7CzoaT55TenzB5SKn4afncm1Ps3D0t0aVGAq9ToeWQczCAFTFAlpj5H6YP8HxYDscPeAlwA+Da5bui6QP500ahlz4MQmJNuIom/h5dtzLQVLaLBd5rDR83gOFrcaHvt2bUcNU6DpolOReKFJzyNndaTJ4LB+35H4rfrHXvSammhiO8zWgfEPtmCm7+Kd0SKak380T+bK8f4PAXTx9IITb4JNuDNpigcEbFBXCVJgyw9/YBl9kexn4QPyDEw+19b1+i7ShgMsQqPWu9dRwZPFf/T4H79b5olVC2WWh4tGsATA83DYg1OlKk5LN3TKkixfRW7czumtgf5eI7Ze4iQSjGZOrlMOiASDyFVy1/T+EA89MmfVjdhUsVBxsJALOpLogAk5qCDW/3Y4I22R7/du1dHnLrmHTAOVTXOn3ukFJ7cObKaIDpjuhnH195KA42Aa1g0LjzvGs4szLo2euewnNfUyUfza9fL5w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3f9828-dc34-4822-31ea-08d87bd0f856
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 06:07:52.1238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMd2okYWnKt+llNOVfTX7TF9P1tOfd/7oPHXpG/GlhPbQYyqtDuOnKENa4/E85KMwFFw1LdhEnV+wHqbEzNmxvDBVvbrat9gaw2lL8A/4Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3469
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgVGVkZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRlZGQgSG8t
SmVvbmcgQW4gPHRlZGQuYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0
b2JlciAyOSwgMjAyMCAxMDo1OCBBTQ0KPiBUbzogU2F0aGlzaCBOYXJhc2ltbWFuIDxuc2F0aGlz
aDQxQGdtYWlsLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IFR1
bWt1ciBOYXJheWFuLCBDaGV0aGFuDQo+IDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNv
bT47IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPiA8cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwu
Y29tPjsgSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29tPjsNCj4gTmFyYXNpbW1hbiwgU2F0aGlz
aCA8c2F0aGlzaC5uYXJhc2ltbWFuQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzNdIEJsdWV0b290aDogYnRpbnRlbDogSW50cm9kdWNpbmcgbmV3IGJ0aW50ZWwgcmVhZA0KPiB2
ZXJzaW9uDQo+IA0KPiBIaSBTYXRoaXNoLA0KPiANCj4gT24gMjAyMC0xMC0yMiBhdCAxMzo1NDoz
NCArMDUzMCwgU2F0aGlzaCBOYXJhc2ltbWFuIHdyb3RlOg0KPiA+IFRoZSBuZXcgYnRpbnRlbCBy
ZWFkIHZlcnNpb24gc3VwcG9ydHMgdGhlIGxhdGVzdCBpbnRlbCByZWFkIHZlcnNpb24NCj4gPiBj
b21tYW5kIGFuZCBhbHNvIHN1cHBvcnRzIHRoZSBUTFYgc3RydWN0dXJlIHBhcnNpbmcuIEl0IHN0
aWxsIGhhbmRsZXMNCj4gPiB0aGUgbGVnYWN5IHJlYWQgdmVyc2lvbg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2F0aGlzaCBOYXJhc2ltbWFuIDxzYXRoaXNoLm5hcmFzaW1tYW5AaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgfCA1MQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9ibHVldG9v
dGgvYnRpbnRlbC5oIHwgMTUgKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2NiBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gaW5kZXggY2M4ZTZjNGUz
MjA1Li5kZGQzYzRiYmRkNmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gQEAgLTQ3
Niw2ICs0NzYsNTcgQEAgc3RhdGljIHZvaWQgYnRpbnRlbF9wYXJzZV90bHYoc3RydWN0IHNrX2J1
ZmYgKnNrYiwNCj4gPiAgCX0NCj4gPiAgfQ0KPiA+DQo+ID4gK2ludCBidGludGVsX3JlYWRfdmVy
c2lvbl9uZXcoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdA0KPiA+ICtidGludGVsX3ZlcnNp
b24gKnZlcikgew0KPiA+ICsJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4gPiArCXN0cnVjdCBpbnRl
bF92ZXJzaW9uICp2ZXJzaW9uID0gJnZlci0+dmVyOw0KPiA+ICsJY29uc3QgdTggcGFyYW1bMV0g
PSB7IDB4RkYgfTsNCj4gPiArDQo+ID4gKwlza2IgPSBfX2hjaV9jbWRfc3luYyhoZGV2LCAweGZj
MDUsIDEsIHBhcmFtLCBIQ0lfQ01EX1RJTUVPVVQpOw0KPiA+ICsJaWYgKElTX0VSUihza2IpKSB7
DQo+ID4gKwkJYnRfZGV2X2VycihoZGV2LCAiUmVhZGluZyBJbnRlbCB2ZXJzaW9uIGluZm8gZmFp
bGVkICglbGQpIiwNCj4gPiArCQkJICAgUFRSX0VSUihza2IpKTsNCj4gPiArCQlyZXR1cm4gUFRS
X0VSUihza2IpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChza2ItPmRhdGFbMF0pIHsNCj4g
PiArCQlidF9kZXZfZXJyKGhkZXYsICJJbnRlbCBSZWFkIFZlcnNpb24gY29tbWFuZCBmYWlsZWQN
Cj4gKCUwMngpIiwNCj4gPiArCQkJICAgc2tiLT5kYXRhWzBdKTsNCj4gPiArCQlrZnJlZV9za2Io
c2tiKTsNCj4gPiArCQlyZXR1cm4gLUVJTzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBUaGUg
bmV3IEludGVsIHJlYWQgdmVyc2lvbiBpcyBiYWNrd2FyZCBjb21wYXRpYmxlIGZvciBUaHAgYW5k
DQo+IENjUA0KPiA+ICsJICogdHlwZSBjYXJkcy4gd2hlbiB0aGUgY29udHJvbGxlciBpcyBpbiBi
b290bG9hZGVyIG1vZGUgdGhlDQo+IGNvbnRyb2xsZXINCj4gPiArCSAqIHJlc3BvbnNlIHJlbWFp
bnMgc2FtZSBhcyBvbGQgaW50ZWxfcmVhZCB2ZXJzaW9uLiBGb3IgVGhQL0NjUA0KPiBjYXJkcw0K
PiA+ICsJICogVExWIHN0dWN0dXJlIHN1cHBvcnRzIG9ubHkgZHVyaW5nIHRoZSBPcGVyYXRpb24g
TW9kZS4gVGhlIGJlc3QNCj4gPiArd2F5DQo+IA0KPiBtaXNzcGVsbGVkIHN0cnVjdHVyZQ0KPiAN
Cj4gPiArCSAqIHRvIGRpZmZlcmVudGlhdGUgdGhlIHJlYWRfdmVyc2lvbiByZXNwb25zZSBpcyB0
byBjaGVjayB0aGUgbGVuZ3RoDQo+ID4gKwkgKiBwYXJhbWV0ZXIgYW5kIGZpcnN0IGJ5dGUgb2Yg
dGhlIHBheWxvYWQsIHdoaWNoIGlzIGEgZml4ZWQgdmFsdWUuDQo+ID4gKwkgKiBBZnRlciB0aGUg
c3RhdHVzIHBhcmFtZXRlciBpZiB0aGUgcGF5bG9hZCBzdGFydHMgd2l0aCAweDM3KFRoaXMgaXMN
Cj4gPiArCSAqIGEgZml4ZWQgdmFsdWUpIGFuZCBsZW5ndGggb2YgdGhlIHBheWxvYWQgaXMgMTAg
dGhlbiBpdCBpcyBpZGVudGlmaWVkDQo+ID4gKwkgKiBhcyBsZWdhY3kgc3RydWN0IGludGVsX3Zl
cnNpb24uIEluIHRoZSBsYXRlc3QgZmlybXdlYXJlIHRoZSBzdXBwb3J0DQo+ID4gKwkgKiBvZiBU
TFYgc3RydWN0dXJlIGlzIGFkZGVkIGR1cmluZyBPcGVyYXRpb25hbCBGaXJtd2FyZS4NCj4gPiAr
CSAqLw0KPiA+ICsJaWYgKHNrYi0+bGVuID09IHNpemVvZigqdmVyc2lvbikgJiYgc2tiLT5kYXRh
WzFdID09IDB4MzcpIHsNCj4gPiArCQltZW1jcHkodmVyc2lvbiwgc2tiLT5kYXRhLCBzaXplb2Yo
KnZlcnNpb24pKTsNCj4gPiArCQl2ZXItPnRsdl9mb3JtYXQgPSBmYWxzZTsNCj4gPiArCQlnb3Rv
IGZpbmlzaDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBDb25zdW1lIENvbW1hbmQgQ29tcGxl
dGUgU3RhdHVzIGZpZWxkICovDQo+ID4gKwlza2JfcHVsbChza2IsIDEpOw0KPiA+ICsNCj4gPiAr
CXZlci0+dGx2X2Zvcm1hdCA9IHRydWU7DQo+ID4gKw0KPiA+ICsJYnRfZGV2X2luZm8oaGRldiwg
IlBhcnNpbmcgVExWIFN1cHBvcnRlZCBpbnRlbCByZWFkIHZlcnNpb24iKTsNCj4gPiArCWJ0aW50
ZWxfcGFyc2VfdGx2KHNrYiwgJnZlci0+dmVyX3Rsdik7DQo+ID4gKw0KPiA+ICtmaW5pc2g6DQo+
ID4gKwlrZnJlZV9za2Ioc2tiKTsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKGJ0aW50ZWxfcmVhZF92ZXJzaW9uX25ldyk7DQo+ID4gKw0KPiA+ICBpbnQg
YnRpbnRlbF9yZWFkX3ZlcnNpb25fdGx2KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3QNCj4g
PiBpbnRlbF92ZXJzaW9uX3RsdiAqdmVyc2lvbikgIHsNCj4gPiAgCXN0cnVjdCBza19idWZmICpz
a2I7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCBiL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0KPiA+IGluZGV4IDA5MzQ2YWUzMDhlYi4uMDg0MDZlZjkz
NWEzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0KPiA+ICsr
KyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0KPiA+IEBAIC0xMzIsNiArMTMyLDE0IEBA
IHN0cnVjdCBpbnRlbF9kZWJ1Z19mZWF0dXJlcyB7DQo+ID4gIAlfX3U4ICAgIHBhZ2UxWzE2XTsN
Cj4gPiAgfSBfX3BhY2tlZDsNCj4gPg0KPiA+ICtzdHJ1Y3QgYnRpbnRlbF92ZXJzaW9uIHsNCj4g
PiArCWJvb2wgdGx2X2Zvcm1hdDsNCj4gPiArCXVuaW9uIHsNCj4gPiArCQlzdHJ1Y3QgaW50ZWxf
dmVyc2lvbiB2ZXI7IC8qTGVnYWN5IEludGVsIHJlYWQgdmVyc2lvbiovDQo+ID4gKwkJc3RydWN0
IGludGVsX3ZlcnNpb25fdGx2IHZlcl90bHY7DQo+ID4gKwl9Ow0KPiA+ICt9Ow0KPiANCj4gQWRk
IF9fcGFja2VkOw0KPiANCj4gPiArDQo+ID4gICNpZiBJU19FTkFCTEVEKENPTkZJR19CVF9JTlRF
TCkNCj4gPg0KPiA+ICBpbnQgYnRpbnRlbF9jaGVja19iZGFkZHIoc3RydWN0IGhjaV9kZXYgKmhk
ZXYpOyBAQCAtMTUxLDYgKzE1OSw3IEBADQo+ID4gaW50IGJ0aW50ZWxfc2V0X2V2ZW50X21hc2so
c3RydWN0IGhjaV9kZXYgKmhkZXYsIGJvb2wgZGVidWcpOyAgaW50DQo+ID4gYnRpbnRlbF9zZXRf
ZXZlbnRfbWFza19tZmcoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGJvb2wgZGVidWcpOyAgaW50DQo+
ID4gYnRpbnRlbF9yZWFkX3ZlcnNpb24oc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBpbnRl
bF92ZXJzaW9uICp2ZXIpOw0KPiA+IGludCBidGludGVsX3JlYWRfdmVyc2lvbl90bHYoc3RydWN0
IGhjaV9kZXYgKmhkZXYsIHN0cnVjdA0KPiA+IGludGVsX3ZlcnNpb25fdGx2ICp2ZXIpOw0KPiA+
ICtpbnQgYnRpbnRlbF9yZWFkX3ZlcnNpb25fbmV3KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1
Y3QNCj4gPiArYnRpbnRlbF92ZXJzaW9uICp2ZXIpOw0KPiA+DQo+ID4gIHN0cnVjdCByZWdtYXAg
KmJ0aW50ZWxfcmVnbWFwX2luaXQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHUxNg0KPiBvcGNvZGVf
cmVhZCwNCj4gPiAgCQkJCSAgIHUxNiBvcGNvZGVfd3JpdGUpOw0KPiA+IEBAIC0yNDgsNiArMjU3
LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IGJ0aW50ZWxfcmVhZF92ZXJzaW9uX3RsdihzdHJ1Y3QN
Cj4gaGNpX2RldiAqaGRldiwNCj4gPiAgCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiAgfQ0KPiA+
DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGJ0aW50ZWxfcmVhZF92ZXJzaW9uX25ldyhzdHJ1Y3Qg
aGNpX2RldiAqaGRldiwNCj4gPiArCQkJCQkgICBzdHJ1Y3QgYnRpbnRlbF92ZXJzaW9uICp2ZXIp
DQo+ID4gK3sNCj4gPiArCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIGlubGluZSBzdHJ1Y3QgcmVnbWFwICpidGludGVsX3JlZ21hcF9pbml0KHN0cnVjdCBo
Y2lfZGV2ICpoZGV2LA0KPiA+ICAJCQkJCQkgdTE2IG9wY29kZV9yZWFkLA0KPiA+ICAJCQkJCQkg
dTE2IG9wY29kZV93cml0ZSkNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiBJIHRoaW5r
IHlvdSBjYW4gY29tYmluZSB5b3VyIDMgcGF0Y2hlcyBpbnRvIG9uZSBwYXRjaC4NCg0KV2lsbCBj
b3JyZWN0IHRoZSBjaGFuZ2VzIGFzIG1lbnRpb25lZCBhbmQgdXBsb2FkIG5leHQgdmVyc2lvbiBj
b21iaW5pbmcgYWxsIHRoZSBwYXRjaGVzLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gVGVkZA0K
DQpSZWdhcmRzDQpTYXRoaXNoIE4NCg==
