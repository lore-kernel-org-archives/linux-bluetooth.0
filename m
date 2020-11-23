Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9711C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402FA20758
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 17:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IhhVBPW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgKWR2L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 12:28:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:59231 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732550AbgKWR2L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 12:28:11 -0500
IronPort-SDR: 6f2mZ1nN2ZwR+Yp66mf/u+y6oAdf1Ijg1lWt8DXFifyAMo7qchefgn+6U3ZjRe/9Hcqz0VumhP
 UaRjByYBWopw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="158849467"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="158849467"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:28:09 -0800
IronPort-SDR: Vlrb5sBx441zWqeaTjUsAAmnpg4cDfoFCM9u9PAYvZHABQe0EZNZF/SlUNQ/LFRnsWo2zhtuRH
 pccsHeL/JyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="478186905"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2020 09:28:09 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 09:28:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 09:28:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 09:28:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzE26WdzgIy9bxyf3ayqARA2k3bsHJjRCDLiU7sl+BrNnxO0r9J7UpDxCPKy6pRMftMEtd8VQZH4ksf/kMkJz9INzawtD6DshRsv60wTbEk8fTbqp7cGtP1OvbgsGbgbjNhUlyCZp0MrxZ2Jd80juP5l+QAQzGtREUUwdQgsB1QMqFSbZFtCnN/665sUDo/K6Ys5baZUGaUZzFzrn/WC4qCCPkrWkHqKzuf3QhFK90NvSDj0yQHMKinCaiOQI5u0d0f76ZBIlqFeQAi5Iw+3Xo7q7BqFwMoWDDRmsD9qCVypaXp+qjmLa/g8B5kAaUwYg+KORFkn+t75vpinZqq5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSwcat/8xpWIOdenBmmDu/nKgLa6hE0uJLDMIwNUNmc=;
 b=aX1ArjNv8ChKcwQZvD4RezJcgAgzqlKL6DhIautVljy0dViq8Yna7IuHQY0P+2B1/F8pRRYvVB8BfoY81D6vy66xtbMZQa1dmt81cSv/NaJFMUlcc93XRp78k4B468vXjf8RueNn8ugKKDxh2XRxAqLAMZu5OcbdKAF7Vrg4FXhPx1dAaTREWRXzZ1J/EYBrO+1SHVOw2Tqm6RAk1XRm7eqPs4l37RnC95pxAGC2xJfWaBYc8pmCYzbTdB7jv8R1BoJx6uqrfTkeH/11MgTI+oJejTFK8HTOs2TCTwMtW18Z2c7vCiwV2ImWUBAF+8f+v7lEgeN2auZAtWUGPqeYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSwcat/8xpWIOdenBmmDu/nKgLa6hE0uJLDMIwNUNmc=;
 b=IhhVBPW7DppfrAIsYW9u3C1Mk8QAOqdXiDLdZOsHypWxG8mUeb3mRM/ZL0MCy9xJOXCt34w9vaup2l3S0uolWTHiiiWeYFfX9eDG0vhtGg2Ph9Yvv+ke2DGXu2jQpDxMrzi10beWk/rUYhLod4CZEyyQW6TamZjho35JcOWnxrI=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB3591.namprd11.prod.outlook.com (2603:10b6:a03:b4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Mon, 23 Nov
 2020 17:28:06 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::5964:ed9a:9b87:a984]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::5964:ed9a:9b87:a984%2]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 17:28:06 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>, Kiran K <kiraank@gmail.com>
CC:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Firmware version read error on Intel AX210
Thread-Topic: Firmware version read error on Intel AX210
Thread-Index: AQHWwFN1qv0byiSyF0KMPF70QEKl2qnTM3eAgACe2JCAAJqOgIABjdtQ
Date:   Mon, 23 Nov 2020 17:28:06 +0000
Message-ID: <BYAPR11MB3141ACB612F05E55754C1C65F5FC0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <89a134d0-c6f6-c685-2aeb-7dc5eee1966f@gmail.com>
 <44820333-3e09-5405-a1aa-19f64087f164@gmail.com>
 <DM6PR11MB314662E82730EF100538531DF5FD0@DM6PR11MB3146.namprd11.prod.outlook.com>
 <65ed6733-6dd2-41fa-7757-55fe5b91f290@gmail.com>
In-Reply-To: <65ed6733-6dd2-41fa-7757-55fe5b91f290@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.171.222.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d761622f-03a6-44c3-53fd-08d88fd523bd
x-ms-traffictypediagnostic: BYAPR11MB3591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB359197A429964473B333B487F5FC0@BYAPR11MB3591.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FP8pL89O9/kEIfSH92uHHEYo1Fyoept2AeHtylVgYHkv93eI5OQp4H+Fl5Wb/ZoE7Yhh9efZXiWJQ8MA1tcQZyLffjkuzwmEImYzroNsYIrHw2aKPYKgVKSGyi13H27I/yTjhgmGQVY3CmdoUuFLE50b5ssNbzIPkdAJ+YX+ywwaibtuDVMCWJ4KqUVoO1nYO+VR7q9TTNj9773/7OzJVw1sNXGb9OV6AFMZmmwhsI78myOcMGhGN7wkjEwMN7KdrpS4Ix61GSJCp4PrNLWp1Ne7UdftFtvzd0ExF7vq6UjKCuO47tGCDFExprrI7dJ6a+jqTPIUt2HkFFtUgoca/bYTLBbP/Go5Fsijfc7shVRY/1qM8uvTEAIYpI1RKmXqZEeJD3JiRGimh/H1m5qhHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(5660300002)(52536014)(66946007)(76116006)(4326008)(66476007)(64756008)(66446008)(66556008)(86362001)(83380400001)(2906002)(6506007)(8676002)(8936002)(33656002)(186003)(966005)(478600001)(54906003)(7696005)(71200400001)(55016002)(53546011)(110136005)(9686003)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: v1DMnRjY3klmQNL/xpEqW02WipWLEXaf/DOUcxAZmJJHb5IMSHxwzXuxGEvqyj+QAHi94j2YbX/LAioPeDDIY3FgYAA0yuOi6v6JI7q7MySxoeRH4CarY5nz7D/DkZwlcPjxtKUHRSenwaU11l1bq/xzgsEw94Q2ZYynUKohk5YwNPmN+02+6k7gIEPIsR9WlIq9x7Dq7iLueNW+Jg3gMI76fwGym6kxWgUQ+Kp2dLub3BXlWZCozTtM55kpv2zc8VSzz8nznWPx4UaOhKvirYKrSvK9OOnV184dqEluFxCg/VPZBkH0vuPFiIXVbraklFNb0tvGlQ9DORweOofG5LZPY9/neRLaUDrj/Be0XQADpYFmH2S1PblTYyStzXYHNyfursf+SUtruwBa2YCktdeoiStPkl5c5ETkM0CP8DTs0knHeaXpMlTvdoLCvQN6RbQ54ks3buUTIBS1T2xqXhKL5dD6Pc1LAcia8pyMaZ9VgXflGwKQlEv7straqW5Buxf7nQ2UyOMpoIthMDwev83jUq2CL+0niDhbf0Xgh0dvGOcw2u+wqmUxHJt5CCx1eDNkZQ6XyzBAq9wX2Ku4lWTSXMupE3vXTPd+vqvSPt6PoqeISF+1aCF/c4g1Qyftk5MAMDpHcS3Njf/sBsfR0XW0SzZFcCAp17sEQ9RehxvJFTyujBFMbn4j/2xGPq1N5MnvmmALtO3O4hQl9Malocn4YLTkRoz2rF99jWJjLiFb0+LEs5SzAeiPMBY4+NcECsZZjkkuMKkwAmRD5tl2Eyc5GOGCMZloE5OZSw+9bXpLfY2C8ka/ziNvh4NVT/5qaXvgJOv8JLOGVJkkOYTTh5xqHja4bcQq3kBgzuhQ8ITM0HlXXAGHQqW4YkSGNk0mnhd0TXyKOHVNZwmTki0KMA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d761622f-03a6-44c3-53fd-08d88fd523bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 17:28:06.2362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkt1EDvkySNaQ/iVEmz/rK7zjXUoSuaSKiwa1XXG0fkgQo2H8Pa7kj3cCnMYge2fSyeZSpRbdONLawzf1vrgSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3591
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbmVyIEthbGx3
ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBOb3ZlbWJlciAyMiwg
MjAyMCAxMToxMiBQTQ0KPiBUbzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29tPjsgS2lyYW4g
SyA8a2lyYWFua0BnbWFpbC5jb20+DQo+IENjOiBCbHVlWiBkZXZlbG9wbWVudCA8bGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47IFNyaXZhdHNhLA0KPiBSYXZpc2hhbmthciA8cmF2aXNo
YW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sIENoZXRoYW4NCj4gPGNo
ZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgTWFyY2VsIEhvbHRtYW5uDQo+IDxtYXJj
ZWxAaG9sdG1hbm4ub3JnPg0KPiBTdWJqZWN0OiBSZTogRmlybXdhcmUgdmVyc2lvbiByZWFkIGVy
cm9yIG9uIEludGVsIEFYMjEwDQo+IA0KPiBBbSAyMi4xMS4yMDIwIHVtIDA5OjM1IHNjaHJpZWIg
SywgS2lyYW46DQo+ID4gSGkgSGVpbmVyIEthbGx3ZWl0LA0KPiA+DQo+ID4gVGhlIHBhdGNoZXMg
dG8gc3VwcG9ydCAgSW50ZWwgQVgyMTAgIGFyZSBub3QgZnVsbHkgdXBzdHJlYW1lZCBpbnRvDQo+
ID4gYmx1ZXRvb3RoLW5leHQuICBGaW5hbCBwYXRjaCBzZXQgcmV2aWV3IGlzIGluIHByb2dyZXNz
IC0NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvYmx1ZXRvb3RoL2xp
c3QvP3Nlcmllcz0zODc0NzUNCj4gPg0KPiBHb29kIHRvIGhlYXIgYW5kIHRoYW5rcyBmb3IgdGhl
IGxpbmsgdG8gdGhlIHBhdGNoIHNlcmllcy4NCj4gSG93IGFib3V0IGZpcm13YXJlLCBpcyBpdCBz
dWJtaXR0ZWQgdG8gbGludXgtZmlybXdhcmUgaW4gcGFyYWxsZWw/DQo+DQoNCkkgYW0gd29ya2lu
ZyBvbiB0aGlzLiAgSSB3aWxsIGJlIHN1Ym1pdHRpbmcgZmlybXdhcmUgYnkgdGhpcyB3ZWVrLg0K
PiANCj4gRm9sbG93aW5nIGlzIHVucmVsYXRlZCwgaG93ZXZlciBJIGhvcGUgeW91J3JlIHRoZSBy
aWdodCBhZGRyZXNzZWUgdG9vLg0KPiANCj4gSW4gYnR1c2IuYyB3ZSBoYXZlIHRoZSBmb2xsb3dp
bmcgY29kZS4gSSBpbnRlcnByZXQgdGhpcyBpbiBhIHdheSB0aGF0IG9uY2UNCj4gZmlybXdhcmUg
d2FzIGxvYWRlZCB0aGUgZHJpdmVyIHdpbGwgbmV2ZXIgY2hlY2sgZm9yIHVwZGF0ZWQgZmlybXdh
cmUuDQo+IFNob3VsZG4ndCB0aGUgZHJpdmVyIGFsd2F5cyByZWFkIHRoZSBmaXJtd2FyZSBmaWxl
IGF2YWlsYWJsZSBvbiB0aGUgc3lzdGVtDQo+IGFuZCBjaGVjayBpdHMgdmVyc2lvbiBhZ2FpbnN0
IHRoZSBmaXJtd2FyZSB2ZXJzaW9uIHRoZSBkZXZpY2UgaGFzIChhbmQgYXBwbHkNCj4gaXQgaWYg
aXQncyBuZXdlcik/DQo+IEJ1dCBtYXliZSBJIG1pc3Mgc29tZXRoaW5nIC4uDQo+IA0KPiBidF9k
ZXZfaW5mbyhoZGV2LCAicmVhZCBJbnRlbCB2ZXJzaW9uOg0KPiAlMDJ4JTAyeCUwMnglMDJ4JTAy
eCUwMnglMDJ4JTAyeCUwMngiLA0KPiAJICAgIHZlci5od19wbGF0Zm9ybSwgdmVyLmh3X3Zhcmlh
bnQsIHZlci5od19yZXZpc2lvbiwNCj4gCSAgICB2ZXIuZndfdmFyaWFudCwgIHZlci5md19yZXZp
c2lvbiwgdmVyLmZ3X2J1aWxkX251bSwNCj4gCSAgICB2ZXIuZndfYnVpbGRfd3csIHZlci5md19i
dWlsZF95eSwgdmVyLmZ3X3BhdGNoX251bSk7DQo+IA0KPiAvKiBmd19wYXRjaF9udW0gaW5kaWNh
dGVzIHRoZSB2ZXJzaW9uIG9mIHBhdGNoIHRoZSBkZXZpY2UgY3VycmVudGx5DQo+ICAqIGhhdmUu
IElmIHRoZXJlIGlzIG5vIHBhdGNoIGRhdGEgaW4gdGhlIGRldmljZSwgaXQgaXMgYWx3YXlzIDB4
MDAuDQo+ICAqIFNvLCBpZiBpdCBpcyBvdGhlciB0aGFuIDB4MDAsIG5vIG5lZWQgdG8gcGF0Y2gg
dGhlIGRldmljZSBhZ2Fpbi4NCj4gICovDQo+IGlmICh2ZXIuZndfcGF0Y2hfbnVtKSB7DQo+IAli
dF9kZXZfaW5mbyhoZGV2LCAiSW50ZWwgZGV2aWNlIGlzIGFscmVhZHkgcGF0Y2hlZC4gIg0KPiAJ
CSAgICAicGF0Y2ggbnVtOiAlMDJ4IiwgdmVyLmZ3X3BhdGNoX251bSk7DQo+IAlnb3RvIGNvbXBs
ZXRlOw0KPiB9DQo+IA0KPiANCj4gDQo+ID4gUmVnYXJkcywNCj4gPiBLaXJhbg0KPiA+DQo+IFRo
YW5rIHlvdSwgSGVpbmVyDQo+IA0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPg0KPiA+PiBTZW50
OiBTdW5kYXksIE5vdmVtYmVyIDIyLCAyMDIwIDQ6MzAgQU0NCj4gPj4gVG86IEtpcmFuIEsgPGtp
cmFhbmtAZ21haWwuY29tPjsgSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29tPg0KPiA+PiBDYzog
Qmx1ZVogZGV2ZWxvcG1lbnQgPGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4+
IFN1YmplY3Q6IFJlOiBGaXJtd2FyZSB2ZXJzaW9uIHJlYWQgZXJyb3Igb24gSW50ZWwgQVgyMTAN
Cj4gPj4NCj4gPj4gQW0gMjEuMTEuMjAyMCB1bSAyMzoxMiBzY2hyaWViIEhlaW5lciBLYWxsd2Vp
dDoNCj4gPj4+IEkgaGF2ZSBhIG5ldyBBWDIxMCBXaUZpL0JsdWV0b290aCBjYXJkIGFuZCBidGlu
dGVsX3JlYWRfdmVyc2lvbigpDQo+ID4+PiBmYWlscyB3aXRoIGVycm9yIC0yMiAoRUlOVkFMKS4g
VW5kZXJseWluZyBlcnJvciBpcyB0aGF0IHRoZSBmaXJtd2FyZQ0KPiA+Pj4gdmVyc2lvbiByZWFk
IGNvbW1hbmQgcmV0dXJucyB3aXRoIGhkZXYtPnJlcV9yZXN1bHQgPSAxOCAoMHgxMikuDQo+ID4+
PiAocmVxX3N0YXR1cyA9IDApDQo+ID4+PiA+RnJvbSB3aGF0IEkndmUgcmVhZCB0aGlzIG1lYW5z
IGludmFsaWQgY29tbWFuZCBwYXJhbWV0ZXJzLg0KPiA+Pj4gRGlkIHNvbWV0aGluZyBjaGFuZ2Ug
d2l0aCBBWDIxMCBhbmQgY29tbWFuZCAweGZjMDUgcmVxdWlyZXMgc3BlY2lmaWMNCj4gPj4+IHBh
cmFtZXRlcnMgbm93PyBPciB3aGF0IGVsc2UgbWF5IGNhdXNlIHRoaXMgaXNzdWU/DQo+ID4+Pg0K
PiA+PiBTZWVtcyBBWDIxMCB1c2VzIHRoZSBuZXcgVExWIGluZnJhc3RydWN0dXJlLg0KPiA+PiBi
dGludGVsX3JlYWRfdmVyc2lvbl90bHYoKSByZXR1cm5zIHZhbGlkIGRhdGEuIFdpbGwgVExWL0FY
MjEwIHN1cHBvcnQgYmUNCj4gYWRkZWQgZm9yIDUuMTE/DQoNClJlZ2FyZHMsDQpLaXJhbg0KDQoN
Cg==
