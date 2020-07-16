Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C642C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E81020760
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lL1mM/wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgGPIkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:40:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:41393 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPIkX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 04:40:23 -0400
IronPort-SDR: eYteHwnVFp7qnvFqOpIp6kVC68NPBND9FaieR6Uk0OjhQ04RQaC5IvdtXfdqnfiDDkDxGbaKti
 NAG2OwmnY1Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148492488"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="148492488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 01:40:23 -0700
IronPort-SDR: lWD+dpcfCCjzuCdHxcvtpIs3QM8GuLmWfXN3C0tbOqBwnt3Tyydrp19fdanfFrnf5MuarhImxE
 Su7XIkYP3xHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="391035638"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2020 01:40:23 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 01:40:22 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 01:40:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Jul 2020 01:40:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbMLHaa0kMGDCyq+cB74UzLWr9DWKDaUZ+MI4+bigUT06ITrTSlL34XRpCxVXyQROIZnWhkixySbevUcPW+nz2NlLd41jYqlqzrdWjAf7TvMHRy63LT1/spG8sjsxO50UR/HrVpbSezLeOIqCmsl3B0FLGqfElgmmD16nWtmlLsQmf9lmu0O66cIAeZ4ZjaoFyUwkRzhSUxEbH//zqq+70SiP8ZomzKzQ8QKUETeUfmhMxOJD4Izv1KMwCqecbanMG8XcS4CutUP6oVs5bqZNV25WDKGe4J4NAquhc3jQ4RlusmWHS0OtYCKZ73W1SFIxPT/Jda3WyBtCz9Ece1OQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4cw7rpC0qCAMHoY/5HqxFqHL5DuLQY4t9FESOL/1zI=;
 b=Wgt+p0q2vDeTji4LBVriJFY7e3mwxVM7nxB77q8VAwyOwLeOW5eeWtDgJ9FPPT65V+70pb9Bq6WzCKHQGGkmlKnOnhXmUiJt6okaZY/8KaDuKso6aMXAH79pW21RvYOPDat+CF9Crnr/8BhYb/Vj+GHpqkMVrCGSfH4TFkRVl86ZDH1b5yPQw8xdRNwhsePNqJ/pgsA04incVIkECEZXPNKcRT3K1ZfEAO5HNQlDzB4Ah5ur0gtjFEn8gjQ7s27Mdt3AU4DAYZHLJnfUqWeTE6NSzSnYhH7f+NvfJzid4ElID/ej8qXZz3WWHK+2QxYx3yi6yOmM14Y6hyodFKpKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4cw7rpC0qCAMHoY/5HqxFqHL5DuLQY4t9FESOL/1zI=;
 b=lL1mM/wT+FzN7O9rsCvJK0oVvOqhrhc5X0LvsMkbjv2TAZ0k7f+uQoItYjiiX5HwgXE2lP7T1L292YiLDWo6KkTjQm6Qd7nAAmH8NaU65DiqkEfaEVSF528ht9gKNNN/ifIiEwgcRVbCSufmd5q9oK+glkUZe/Va0QdOldJLe/s=
Received: from DM6PR11MB3369.namprd11.prod.outlook.com (2603:10b6:5:b::16) by
 DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Thu, 16 Jul 2020 08:40:21 +0000
Received: from DM6PR11MB3369.namprd11.prod.outlook.com
 ([fe80::9064:3ba:cdd3:793b]) by DM6PR11MB3369.namprd11.prod.outlook.com
 ([fe80::9064:3ba:cdd3:793b%7]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 08:40:21 +0000
From:   "Singh, AmitX K" <amitx.k.singh@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Panda, Bharat B" <bharat.b.panda@intel.com>
Subject: RE: [PATCH] bluez:update handle for large database
Thread-Topic: [PATCH] bluez:update handle for large database
Thread-Index: AQHWO0WTQMBYhmarxk+ML2/6wbSJqKjKQ4eAgDzUj4A=
Date:   Thu, 16 Jul 2020 08:40:21 +0000
Message-ID: <DM6PR11MB3369FB0F059C03E34D96BC48B67F0@DM6PR11MB3369.namprd11.prod.outlook.com>
References: <20200605142541.28412-1-amitx.k.singh@intel.com>
 <20200605142541.28412-5-amitx.k.singh@intel.com>
 <CABBYNZKW39ZbrPcWU_8ttj8rM7-0yzWCBCB_Ge40Mm=h8VkM4Q@mail.gmail.com>
In-Reply-To: <CABBYNZKW39ZbrPcWU_8ttj8rM7-0yzWCBCB_Ge40Mm=h8VkM4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.207.200.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f63a6cb2-1cb3-4bc0-e126-08d82963e01b
x-ms-traffictypediagnostic: DM6PR11MB2937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2937759C833935BC8EAAC838B67F0@DM6PR11MB2937.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwbKcObPddTrZhzIJs8rEPXpo39PCwE08eApQNPQJCmztI+7VnXQA8UqE5uAszA6XfCm06nOEGfgQGB21GtyLutMEkqja1YAk+7+BeBvAV6tty1W86ZylJCj3AqBj5O4TDgaTqE4dWPbpvxXxsSL54PIDH1CJnnk5W9FvavCwKoMon783Si+CEAq4lvpvvr+b5AUG9ucOv1PpVZaQ+HeXkjaGu9rQxGbRek6/SEyetUwfCDjtK/9K4ySNaPkc6/kaE0uoP8vnzPbqqCfcjsy1QbF8V51+K4rtGkI6HLWHOjeKQE6jO8UvpL3Rb9fjjwgtsPzWeLLykwwqhqdhlEXkCQ0sF9ksUtvZ2Im9ElDyqL/gVamlweUjhRSLLFptEYS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3369.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(6506007)(66476007)(64756008)(66556008)(26005)(54906003)(53546011)(6916009)(186003)(478600001)(7696005)(33656002)(66946007)(8936002)(8676002)(86362001)(5660300002)(9686003)(66446008)(55016002)(2906002)(71200400001)(76116006)(15650500001)(52536014)(4326008)(55236004)(107886003)(316002)(83380400001)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: s/v1751dwvaR3+hw/K0Kcf0t7jG8KKDe+XoFQemITEMAQslVUT2NZgRK1KLEOnsJF/BS39B4IY88a22rqVbeVQZJrhEjUKHe2LCnIqL4nwhOxfBEJpbNk1oaHZQJTK5TKrygxLvWZAD7icTcUgE2+GuIGYRYjjqB0rdsm8vWV+ibobouTOaFzAMxvjxdCQf6Qas9oQsExtEyAcUQmNL4tGmNMl5JXHBfpCT2aFMB0a+XqYjr/HyhCahpH2HsrmagpTsrSh36zYBMa8eT/BcgAR0a1IjF4KcuENEjIqPQl+/37hHw3g9Tx2TSVq7J6h6giLt3HB0Pjsq1hTUwIhmwWatTC8eUQM4xu1B7sVu3KEkp4+Flsvb0Oqz1ayozcLhG30YuQDmhK0IhGpGA+pxc6RNaDRgZiC0oj1Z5vDcaOiGIPC1fo6ZvvBabIeIxCZjjBiI6M0n9Bw/IIGTuSPxBHM/AWuxhDneY6HOuNtoTZ1g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3369.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63a6cb2-1cb3-4bc0-e126-08d82963e01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 08:40:21.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Je1lBGLzn5DFRnA9YSdxFh2+/CwwCTKg14RfjWNKwzU4fMklxiNCwYjAHh8VU/exo0vntWqgsrvKbry3yzAX/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2937
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1aXogQXVn
dXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1
bmUgNSwgMjAyMCAxMDo0NiBQTQ0KPiBUbzogU2luZ2gsIEFtaXRYIEsgPGFtaXR4Lmsuc2luZ2hA
aW50ZWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBibHVlejp1cGRhdGUgaGFuZGxlIGZvciBsYXJnZSBkYXRhYmFzZQ0K
PiANCj4gSGkgQW1pdCwNCj4gDQo+IE9uIEZyaSwgSnVuIDUsIDIwMjAgYXQgNzozMCBBTSBBbWl0
c2k1eCA8YW1pdHguay5zaW5naEBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogYW1p
dCA8YW1pdHguay5zaW5naEBpbnRlbC5jb20+DQo+ID4NCj4gPiBVcGRhdGUgaGFuZGxlIGZvciBs
YXJnZSBkYXRhYmFzZSBhbmQNCj4gPiBhZGRlZCBjb25kaXRpb24gYmVmb3JlIGZyZWUgdG8gYXZv
aWQgZG91YmxlIGZyZWUNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGFtaXQgPGFtaXR4Lmsuc2lu
Z2hAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBzcmMvc2hhcmVkL2dhdHQtY2xpZW50LmMgfCAx
MiArKysrKysrLS0tLS0NCj4gPiAgc3JjL3NoYXJlZC9nYXR0LWRiLmMgICAgIHwgMTUgKysrKysr
KysrLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc3JjL3NoYXJlZC9nYXR0LWNsaWVudC5j
IGIvc3JjL3NoYXJlZC9nYXR0LWNsaWVudC5jIGluZGV4DQo+ID4gMTlmZjZhYjY1Li4zY2I2YWU0
NDMgMTAwNjQ0DQo+ID4gLS0tIGEvc3JjL3NoYXJlZC9nYXR0LWNsaWVudC5jDQo+ID4gKysrIGIv
c3JjL3NoYXJlZC9nYXR0LWNsaWVudC5jDQo+ID4gQEAgLTExMzEsOCArMTEzMSw2IEBAIHN0YXRp
YyB2b2lkIGRpc2NvdmVyX3NlY29uZGFyeV9jYihib29sIHN1Y2Nlc3MsDQo+IHVpbnQ4X3QgYXR0
X2Vjb2RlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3VjY2VzcyA9IGZh
bHNlOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBkb25lOw0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAv
KiBEYXRhYmFzZSBoYXMgY2hhbmdlZCBhZGp1c3QgbGFzdCBoYW5kbGUgKi8NCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBvcC0+bGFzdCA9IGVuZDsNCj4gPiAgICAgICAgICAgICAgICAgfQ0K
PiA+DQo+ID4gICAgICAgICAgICAgICAgIC8qIFVwZGF0ZSBwZW5kaW5nIGxpc3QgKi8gQEAgLTEz
OTIsOSArMTM5MCwxMyBAQA0KPiA+IHN0YXRpYyB2b2lkIGRiX2hhc2hfcmVhZF9jYihib29sIHN1
Y2Nlc3MsIHVpbnQ4X3QgYXR0X2Vjb2RlLA0KPiA+ICAgICAgICAgdXRpbF9oZXhkdW1wKCcgJywg
dmFsdWUsIGxlbiwgY2xpZW50LT5kZWJ1Z19jYWxsYmFjaywNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbGllbnQtPmRlYnVnX2RhdGEpOw0KPiA+
DQo+ID4gLSAgICAgICAvKiBTdG9yZSBpdGhlIG5ldyBoYXNoIGluIHRoZSBkYiAqLw0KPiA+IC0g
ICAgICAgZ2F0dF9kYl9hdHRyaWJ1dGVfd3JpdGUob3AtPmhhc2gsIDAsIHZhbHVlLCBsZW4sIDAs
IE5VTEwsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRiX2hh
c2hfd3JpdGVfdmFsdWVfY2IsIGNsaWVudCk7DQo+ID4gKyAgICAgICAvKiBTdG9yZSB0aGUgbmV3
IGhhc2ggaW4gdGhlIGRiICovDQo+ID4gKyAgICAgICBpZihnYXR0X2RiX2F0dHJpYnV0ZV93cml0
ZShvcC0+aGFzaCwgMCwgdmFsdWUsIGxlbiwgMCwgTlVMTCwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYl9oYXNoX3dyaXRlX3ZhbHVlX2NiLCBj
bGllbnQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHV0aWxfZGVidWcoY2xpZW50LT5kZWJ1Z19j
YWxsYmFjaywgY2xpZW50LT5kZWJ1Z19kYXRhLCJEQiBIYXNoDQo+IG1hdGNoIHdyaXRlOiBza2lw
cGluZyBkaXNjb3ZlcnkiKTsNCj4gPiArICAgICAgICAgICAgICAgcXVldWVfcmVtb3ZlX2FsbChv
cC0+cGVuZGluZ19zdmNzLCBOVUxMLCBOVUxMLCBOVUxMKTsNCj4gDQo+IE5vdCBmb2xsb3dpbmcg
dGhpcyBjaGFuZ2UsIGlmIHdlIGdvdCB0byB3cml0ZSB0aGUgZGIgaGFzaCB0aGF0IG1lYW5zIHRo
ZSBvbGQNCj4gdmFsdWUgZGlkIG5vdCBtYXRjaC4NCj4gDQoNCldoZW4gd2UgdmVyaWZ5IHRoZSBQ
VFMgdGVzdCBjYXNlIEdBVFQvQ0wvR0FEL0JWLTAyLUMgdGVzdCBjYXNlLCB0aGUgVGVzdCBjYXNl
IGRlbWFuZHMgdG8gcGVyZm9ybSBtdWx0aXBsZSBjb25uZWN0aW9ucyB0byB0aGUgUFRTIGRldmlj
ZSB3aXRoIGRpZmZlcmVudCBkYXRhYmFzZSB1cG9uIGVhY2ggY29ubmVjdGlvbiwgd2hlcmUgdGhl
IGN1cnJlbnQgY29kZSBkb2VzIG5vdCB1cGRhdGUgdGhlIGRhdGFiYXNlIGhhc2ggb24gZWFjaCBj
b25uZWN0IGl0ZXJhdGlvbiB0aGF0IHlpZWxkcyB0byBzZWcgZmF1bHQuDQpBZGRlZCBzdXBwb3J0
IGZvciByZW1vdmUgcGVuZGluZyBzZXJ2aWNlIGlmIGFueSBhZnRlciB1cGRhdGluZyBuZXcgaGFz
aCBpbiBkYXRhYmFzZS4NCg0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPg0KPiA+ICBkaXNjb3Zl
cjoNCj4gPiAgICAgICAgIGlmICghb3AtPnN1Y2Nlc3MpIHsNCj4gPiBkaWZmIC0tZ2l0IGEvc3Jj
L3NoYXJlZC9nYXR0LWRiLmMgYi9zcmMvc2hhcmVkL2dhdHQtZGIuYyBpbmRleA0KPiA+IGI0NGY3
YjVlOS4uMTVhZjRjMjBhIDEwMDY0NA0KPiA+IC0tLSBhL3NyYy9zaGFyZWQvZ2F0dC1kYi5jDQo+
ID4gKysrIGIvc3JjL3NoYXJlZC9nYXR0LWRiLmMNCj4gPiBAQCAtMzQ0LDEwICszNDQsMTUgQEAg
c3RhdGljIGJvb2wgZGJfaGFzaF91cGRhdGUodm9pZCAqdXNlcl9kYXRhKQ0KPiA+ICAgICAgICAg
Z2F0dF9kYl9mb3JlYWNoX3NlcnZpY2UoZGIsIE5VTEwsIHNlcnZpY2VfZ2VuX2hhc2hfbSwgJmhh
c2gpOw0KPiA+ICAgICAgICAgYnRfY3J5cHRvX2dhdHRfaGFzaChkYi0+Y3J5cHRvLCBoYXNoLmlv
diwgZGItPm5leHRfaGFuZGxlLA0KPiA+IGRiLT5oYXNoKTsNCj4gPg0KPiA+IC0gICAgICAgZm9y
IChpID0gMDsgaSA8IGhhc2guaTsgaSsrKQ0KPiA+IC0gICAgICAgICAgICAgICBmcmVlKGhhc2gu
aW92W2ldLmlvdl9iYXNlKTsNCj4gPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBoYXNoLmk7IGkr
Kykgew0KPiA+ICsgICAgICAgICAgICAgICBpZihoYXNoLmlvdltpXS5pb3ZfYmFzZSkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBmcmVlKGhhc2guaW92W2ldLmlvdl9iYXNlKTsNCj4gPiAr
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBpZihoYXNoLmlvdikNCj4gPiArICAgICAgICAg
ICAgICAgZnJlZShoYXNoLmlvdik7DQo+ID4NCj4gPiAtICAgICAgIGZyZWUoaGFzaC5pb3YpOw0K
PiA+ICsgICAgICAgaGFzaC5pb3YgPSBOVUxMOw0KPiANCj4gSSBiZWxpZXZlIHRoaXMgZXJyb3Ig
d2FzIGFjdHVhbGx5IGludHJvZHVjZWQgYnkgeW91ciBjaGFuZ2VzIGFjdHVhbGx5LCBzZWUNCj4g
YmVsb3cuDQo+IA0KPiA+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICB9DQo+ID4gQEAgLTY4
OSw3ICs2OTQsNyBAQCBzdHJ1Y3QgZ2F0dF9kYl9hdHRyaWJ1dGUNCj4gKmdhdHRfZGJfaW5zZXJ0
X3NlcnZpY2Uoc3RydWN0IGdhdHRfZGIgKmRiLA0KPiA+ICAgICAgICAgc2VydmljZS0+bnVtX2hh
bmRsZXMgPSBudW1faGFuZGxlczsNCj4gPg0KPiA+ICAgICAgICAgLyogRmFzdC1mb3J3YXJkIG5l
eHRfaGFuZGxlIGlmIHRoZSBuZXcgc2VydmljZSB3YXMgYWRkZWQgdG8gdGhlIGVuZA0KPiAqLw0K
PiA+IC0gICAgICAgZGItPm5leHRfaGFuZGxlID0gTUFYKGhhbmRsZSArIG51bV9oYW5kbGVzLCBk
Yi0+bmV4dF9oYW5kbGUpOw0KPiA+ICsgICAgICAgZGItPm5leHRfaGFuZGxlICs9IG51bV9oYW5k
bGVzOw0KPiANCj4gTm90ZSB0aGF0IGlmIHRoZSBzZXJ2aWNlIHdhcyBub3QgYWRkZWQgdG8gdGhl
IGVuZCB0aGlzIHN0YXJ0cyBhZGRpbmcgZ2FwcyBpbg0KPiBiZXR3ZWVuLCBzbyBJJ20gYWZyYWlk
IEkgd2lsbCBoYXZlIHRvIG5hY2sgdGhpcyBjaGFuZ2UuDQo+IA0KPiA+ICAgICAgICAgcmV0dXJu
IHNlcnZpY2UtPmF0dHJpYnV0ZXNbMF07DQo+ID4NCj4gPiBAQCAtODExLDggKzgxNiw2IEBAIHNl
cnZpY2VfaW5zZXJ0X2NoYXJhY3RlcmlzdGljKHN0cnVjdCBnYXR0X2RiX3NlcnZpY2UNCj4gKnNl
cnZpY2UsDQo+ID4gICAgICAgICAgKiBkZWNsYXJhdGlvbi4gQWxsIGNoYXJhY3RlcmlzdGljIGRl
ZmluaXRpb25zIHNoYWxsIGhhdmUgYQ0KPiA+ICAgICAgICAgICogQ2hhcmFjdGVyaXN0aWMgVmFs
dWUgZGVjbGFyYXRpb24uDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAgIGlmIChoYW5kbGUg
PT0gVUlOVDE2X01BWCkNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+IA0KPiBU
aGlzIHBlcmhhcHMgaXMgdGhlIHJlYWwgcmVhc29uLCBpdCBzZWVtcyB0byBtZSB0aGF0IHlvdSBo
YXZlIG1vcmUgdGhhbg0KPiBVSU5UMTZfTUFYIGhhbmRsZXMgc28gdGhlIGhhbmRsZXMgbG9vcCBh
cm91bmQgYW5kIHN0YXJ0IG92ZXIgZnJvbQ0KPiAwIHdoaWNoIGlzIGludmFsaWQgYW5kIHdpbGwg
bW9zdCBsaWtlbHkgY2F1c2UgZG91YmxlIGZyZWVzIGV0YyBhbmQgdGhleSBjYW4gYmUNCj4gbXVs
dGlwbGUgYXR0cmlidXRlcyBhc3NpZ25lZCB0byB0aGUgc2FtZSBoYW5kbGUuIEhvdyBiaWcgaXMg
dGhlIGRhdGFiYXNlIHlvdQ0KPiBhcmUgdHJ5aW5nIHRvIHRlc3Q/IElmIHRoYXQgaXMgZ29pbmcg
cGFzdCBVSU5UMTZfTUFYIGl0IGlzIHByb2JhYmx5IGJyb2tlbiBhbmQNCj4gbm90aGluZyBjYW4g
YmUgZG9uZSB0byBmaXggaXQgb24gdGhlIGNsaWVudCBzaWRlIHdoaWNoIGlzIHdoeSB3ZSBzdG9w
IGFkZGluZw0KPiBhdHRyaWJ1dGVzIGFmdGVyIGl0Lg0KPiANCg0KV2hlbiB3ZSB2ZXJpZnkgdGhl
IFBUUyB0ZXN0IGNhc2UgR0FUVC9DTC9HQUQvQlYtMDItQyB0ZXN0IGNhc2UsIHRoZSBUQyBkZW1h
bmRzIHRvIHBlcmZvcm0gbXVsdGlwbGUgY29ubmVjdGlvbnMgdG8gdGhlIFBUUyBkZXZpY2Ugd2l0
aCBkaWZmZXJlbnQgZGF0YWJhc2UgdXBvbiBlYWNoIGNvbm5lY3Rpb24uIA0KSW4gb25lIGNvbm5l
Y3Rpb24gc2V0dXAgZGF0YWJhc2UgaGF2aW5nIGhhbmRsZSB2YWx1ZSBpcyBVSU5UMTZfTUFYLCAg
d2hlcmUgdGhlIGN1cnJlbnQgY29kZSBkb2VzIG5vdCBhYmxlIHdoZW4gaGFuZGxlIGlzIG1heCAg
Lg0KDQo+ID4gICAgICAgICBpID0gZ2V0X2F0dHJpYnV0ZV9pbmRleChzZXJ2aWNlLCAxKTsNCj4g
PiAgICAgICAgIGlmICghaSkNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiANCj4gLS0N
Cj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
