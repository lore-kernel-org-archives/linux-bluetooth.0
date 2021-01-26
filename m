Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F77C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 22:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FCD2065E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 22:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbhAZW7F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:59:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:54400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbhAZVcJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 16:32:09 -0500
IronPort-SDR: NvfBNIpAGdZWZcGehC0RXsDkRVmQcWuH3u60rGROVKqoE0U9JAnanoMW+7PE1QTWLq8eGzKFNU
 4c/qogZ2bd6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177406490"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="177406490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:31:28 -0800
IronPort-SDR: KiQ/h4DN+2GuTW7EeyVGvhPg7DsWn3vAKNmJpKJzuXsQqtO747KRZoX0V+aDuUF0jHF/oYVbX3
 D/r1oWsh1rZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="353587032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2021 13:31:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 13:31:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Jan 2021 13:31:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 26 Jan 2021 13:31:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 13:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNU64qQlgrfAi1ugrD7ieJ4eXqn2dcHB3+gz1DxlWhff6BZvySXoUwmIwqzYU7PTP31XGmFCiP+ruOONLdyTjkqoGoMt0gTcYwt9JvgvoooQanNMNkA3J9WVsp4b4/nl2/xEEcxgoQot+DQXRb7MOsKYzSI/oLGFlNYysb+/KYfz743PIyti26UjzkZSM2M5Z+nE58OQgzWag9k/oMHVEBGyYzHqFPxNTkeijRAJbnZ1fV3esN3ZW+9iJ2g1qRo/okwa+6hhn9gvPoCdCCij4qMwXQWuuPRmZ6rkubTqMeMNx//uqxeE7Vt2vbEBpFB9ql9ETuhD/kn4kVpI8Vja+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MfjXZ40AE6ylwmqNIrw5Yu6+okiSutzBYFx002qQBI=;
 b=Sw1Pn9CcIYYIs7VG96uqCRJuyxlWZQLp+p1N0PHSm2DNDqt5kP4WoEsI4rwoxzMZVqTWjE27m84RrBlJJXCMxYSaHArSm8M15FzZX+cHCQ8X3SR2kkmvtiqSv52lW72UsdZr4VdtsIAP3KLsTOpSfNZA7i/NlGhuJtSMkr9OPqu9L1n7u3NvTiZZ73rME5ksv1GT5Ec+jEbp6TyraQDm1zwlGg5YG325OAPGLD0+y4QPHfBwWpOtTc0Psbhfnrt+IqJPtBVdRVeb9KUIfZm27dzrL0IxAHQQ12Z8SaMm9N/1/QleMXKWWWWZr9oPDbPKmGO90pMd9j0Y7+RbywmMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MfjXZ40AE6ylwmqNIrw5Yu6+okiSutzBYFx002qQBI=;
 b=eTmv7Np1Gy3qyxYMwcWwDe7qYeofHAtucqDvBXI+5WG7htz/pX75KYhp5lRxdAuhBuZbbWIROv2qxDMrkChMUM5Qtj3uGIft2IlIinEPWBhVsDtJYFOhwl5QoGnIRZFQ1mUSXHx9Gx29tut2nzJznHt5/b3uPhhe9LsR3FVEXEY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1981.namprd11.prod.outlook.com (2603:10b6:300:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 21:31:25 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%8]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 21:31:25 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ] tools: Fix static analysis warnings
Thread-Topic: [PATCH BlueZ] tools: Fix static analysis warnings
Thread-Index: AQHW8PbjyB5R4Da4bUmnSZSvgzr0Wqo6c0SA
Date:   Tue, 26 Jan 2021 21:31:25 +0000
Message-ID: <31facf7f3b7b5e00c21ada1048990788a388b02c.camel@intel.com>
References: <20210122194258.538970-1-brian.gix@intel.com>
In-Reply-To: <20210122194258.538970-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b5c1df7-f0a3-494b-9079-08d8c241bc19
x-ms-traffictypediagnostic: MWHPR11MB1981:
x-microsoft-antispam-prvs: <MWHPR11MB1981E440CB41388711382455E1BC9@MWHPR11MB1981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y75RkPiGjgrjkwiYtea62Vc0Hl2Nz75XX1qH3/8ULopK/8wU96JABDq0M8znFK0n5sB0spHbW+8rhPohBvILqQmclZrkpMViG93U4ZIKlgMZ7gV1G10nMB7PROUv0Ve+loGitGT9kuPEYUbp6+WELARuLrdpnoiLELmwbyH4Fq5wCHURXtOzD4uB9AOKMhIgQmbTRzKkeBJiTTs0UaLDSuIzDxM2PSoOhMSkbSLoETqvkazdRVRIEMBp2c3WEdUS6uoF1nqPfArtyHniCEgXqh3Enuopy6Af5iX4uWqJYDZPxtT7J4OVeGPLUCIBCctbauEW/859HAPRTxJEjdHLJEAb6h5ND0AlHRh9PnInJnadNhkWHLc8qy/Zgy2W0m5koETDklIseUTe8xKB8yeDDkHCEI7nBj4XJRU7u8yMHlBT+K/P5Fo4Jw0APVdWV+NNTx4uQ8BtmmuRcSu9Se/NXegdgXMZjs4w9KOftFtXR6H5wVP2RAc3yOuyUCTLrSFq9XTk4lpjlC6L8Ko7BYDnwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(36756003)(76116006)(91956017)(8936002)(316002)(6916009)(71200400001)(6512007)(2906002)(66446008)(66556008)(64756008)(66946007)(66476007)(86362001)(8676002)(6486002)(478600001)(5660300002)(6506007)(186003)(26005)(2616005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d1N6TkRFK3EyQ1gxZ01rZzFJcW1adWt3RkhFNmpnSmJESDRIVE9pbjFkSHRi?=
 =?utf-8?B?TWFJd1l0dWdLNWxPTlZrSjNXY3pxakQrUDZzRUJhd0JIMlFVZ0hKTU5FUjZz?=
 =?utf-8?B?NGpOYlFOWllIM005R1VIQVJOeGF4SkFndTZlSEttNDJObHZEZ0g1Sk8wL3FM?=
 =?utf-8?B?dDhUN3RhYllyK0hNbFo4TWdLRDlYelpHcDBwYzM0MVp4L1NjSUo4RmlxdmNq?=
 =?utf-8?B?K3FXbi9TVW5qZm1RREhsRS9UWmRESEV3UTkwNDNGWUlhQjl0NGM1S2xET00r?=
 =?utf-8?B?QWF0QmNkcHduYlFqeXBXbXpmamlLUG43OGxsQTdWVXpJSmJ5cHBjZTVqWEtT?=
 =?utf-8?B?MCtlTEJuUElLQnVzeUpDSlVyZkNFNkt3Rm1Qb2NGOVdzTlRuK1l2dEF0dWVs?=
 =?utf-8?B?c2MyN2dZempVOUJVVjhCKytqaTYxdG96Kzh5YnVreGVqOHhqRDBBZDc0Uy9L?=
 =?utf-8?B?bysyZkJFWXRpZXNIYkR6RVZSUm5TcllsTVJkd0Y0RXVvdmNsbjRzT0I2bUtM?=
 =?utf-8?B?M3RxR2RZZkZ4WW9jZW1PNkJrck9WdnFFeXpCSTZzcEF2MERhSUg5azNaVlgw?=
 =?utf-8?B?M2s4UE5SUXpkMy9pb1BWN0FuY3hWU0l4aDdXdFdxRTVjdDNaU09CN2VRNE1Y?=
 =?utf-8?B?VHBLRUNrMXBST3kwZU1qdEQ0YTJXbHpXSC9CQkQzN25IenpNQVRPUVk1Mlh6?=
 =?utf-8?B?YklUaTBVNllPYU81OWwzTmt3UnpxNWJMd0lrK09aaFVUZ2pJZUdYU1VaSVps?=
 =?utf-8?B?aE5mbHBmMVdnNlNZTCt0aEtFY2g4OWF3ODEzVzNBQ3d2TDVYOENodEdNYkNJ?=
 =?utf-8?B?S28ybml2YW45MDFzdXFLZGFiZ1VYcmUrWXhrMUJ1RHpQd1Z3VXZlVFpOMm9o?=
 =?utf-8?B?TVV3dVVJOUowRndyMWk5Uk55RUVzUEZNSmoxcXU2NXdIOHAyK1Q2TG5nZzZY?=
 =?utf-8?B?SkNOeHBvUjExUEpqbi9pTTZLTEpwRlR6QWtndlJ2UnBEOWdFNGtVMjBsR1NM?=
 =?utf-8?B?TDFIWTVYVDBaaVlvZE9WZ3YzRXVEQVFQYzduWjhWRkc0VENNT2FZVGcrbnNB?=
 =?utf-8?B?aVZZenhCeUxzZk5TVmdjVHFRaHE1RkRESVdFeFdON25ramMrakNtTWk4b1Rm?=
 =?utf-8?B?SFN2c0Y4RXJFbCtjbWZvcEFOMklqNSs3R293U29BQ2hYMENUM1dYQndhbEp2?=
 =?utf-8?B?SU1oYWpnRHBzU21mZVNpOGJSM014aUNyUHRUZHh2Slp6WEtvODQ5VENhUTFM?=
 =?utf-8?B?aE5jY05LMWNXUndZRDd0bDZKVmd4dlV2Ri9NcHBCSTBQT1NGYnZ4dk0yaHJB?=
 =?utf-8?B?Q3BaQlpoS3p3cjVuKzZNWmtvL21ZVjQ2aFQwSy9uNlRINTQvY2Fzc3FNcTJw?=
 =?utf-8?B?eC9LZ0szOE13N3pIS2w4QnRHUHhxZGp2RjFmZTRlMmtGY2V0RVFNcGhsNlAr?=
 =?utf-8?Q?iq/lJn2E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BE7B0BBFBC11640BD6B6FEC3DEC294A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5c1df7-f0a3-494b-9079-08d8c241bc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 21:31:25.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqDkroJTOmjbEhL+LujEG9BMMJ74sNx7/ObTuccPExLYUdYeElXBwAKX+ezJti2/+0PKe1SbDpwj7/VN2JHLLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMjEtMDEtMjIgYXQgMTE6NDIgLTA4MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gVXNhZ2Ugb2YgcG90ZW50aWFsbHkgTlVMTCBwb2ludGVycw0KPiAtLS0NCj4gIHRv
b2xzL2J0bWdtdC5jIHwgMTIgKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2J0bWdtdC5jIGIvdG9vbHMvYnRt
Z210LmMNCj4gaW5kZXggMzgzZTcxOTllLi5mNGViNTQxZmEgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L2J0bWdtdC5jDQo+ICsrKyBiL3Rvb2xzL2J0bWdtdC5jDQo+IEBAIC00OTEyLDYgKzQ5MTIsMTIg
QEAgc3RhdGljIHZvaWQgY21kX2Fkdm1vbl9hZGRfcGF0dGVybihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpDQo+ICANCj4gIAljcF9sZW4gPSBzaXplb2YoKmNwKSArIGFyZ2MgKiBzaXplb2Yoc3RydWN0
IG1nbXRfYWR2X3BhdHRlcm4pOw0KPiAgCWNwID0gbWFsbG9jMChjcF9sZW4pOw0KPiArCWlmICgh
Y3ApIHsNCj4gKwkJZXJyb3IoIkZhaWxlZCB0byBhbGxvYyBwYXR0ZXJucy4iKTsNCj4gKwkJc3Vj
Y2VzcyA9IGZhbHNlOw0KPiArCQlnb3RvIGRvbmU7DQo+ICsJfQ0KPiArDQo+ICAJY3AtPnBhdHRl
cm5fY291bnQgPSBhcmdjOw0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8IGFyZ2M7IGkrKykgew0K
PiBAQCAtNDk4Nyw2ICs0OTkzLDEyIEBAIHN0YXRpYyB2b2lkIGNtZF9hZHZtb25fYWRkX3BhdHRl
cm5fcnNzaShpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICANCj4gIAljcF9sZW4gPSBzaXplb2Yo
KmNwKSArIGFyZ2MgKiBzaXplb2Yoc3RydWN0IG1nbXRfYWR2X3BhdHRlcm4pOw0KPiAgCWNwID0g
bWFsbG9jMChjcF9sZW4pOw0KPiArCWlmICghY3ApIHsNCj4gKwkJZXJyb3IoIkZhaWxlZCB0byBh
bGxvYyBwYXR0ZXJucy4iKTsNCj4gKwkJc3VjY2VzcyA9IGZhbHNlOw0KPiArCQlnb3RvIGRvbmU7
DQo+ICsJfQ0KPiArDQo+ICAJY3AtPnBhdHRlcm5fY291bnQgPSBhcmdjOw0KPiAgCWNwLT5yc3Np
LmhpZ2hfdGhyZXNob2xkID0gcnNzaV9oaWdoOw0KPiAgCWNwLT5yc3NpLmxvd190aHJlc2hvbGQg
PSByc3NpX2xvdzsNCg==
