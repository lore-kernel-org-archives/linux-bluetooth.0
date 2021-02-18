Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC7CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38A964EB4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhBRTLx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:11:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:55334 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232950AbhBRTGc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 14:06:32 -0500
IronPort-SDR: FqkZbOEyNuHqm37Dk+xolmnIV6lYhb9ahsp8qsj4MSlwzu0yxbTFf7U/E7R34auPUBGiiGvk1a
 OfV6w4dg9Cng==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="245070766"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="245070766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 11:05:05 -0800
IronPort-SDR: NzClYH3QGMsFbz1AFEBvV+3kxea+BO74XqeSRRktWIj5XYQBewDthbw0cWPiL+mUqUb9VXk+Wr
 oXETRCGgCexQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="367633817"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2021 11:05:05 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 11:05:05 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 11:05:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Feb 2021 11:05:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Feb 2021 11:05:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlNxzAKfNkxkYu0+xWEfnHOjFoUj1E1kkV/Wji2PPx9KSN7TMOH0Km64KgBFz3SN3nG2JnQSS077kkji7JZI/XgZgZz8J2SYqBGn+UPVrxBsocxqy+IKrIiCUmxbdTxCISKrdJCuf4KXqNfqYU+YlpKwrz4m+UfjbaKPLdTkCIceslkRHMW6bLvLgru73PHNGIDdZcGWDAQHvpjsi0Yvu0LAzdaCUoMuDddjXVd6O6kqN2WdnLkyR5dQrES35VnBucAfWdBzytTu82FvftJ9J1A9CVfD5ekE9+/lw14P6RmY8Ln+kRNV42qh+UeEcEKogk5yn9vPXgorvYlOjR7WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3E3hw7xM2wqA/rgfGWjje0XS6n1hVv9W4BSDvvJxg=;
 b=CgsiCSDg5bcxnuLztgtWqSMzVoOCtGWuga3wAjBIr3dzLEvFHEBOPuNfOLG1OhH9oogdJl9fXcJtjyH9pI0zBgTdgLSmKremngrZnFgTkceH1K4EeUwbs7VUFM79Yox5V7q87k6DJaSwtm5AxeHw/FIumEmpbNxA1OzioIxatVHm3nKXfVFxxMElLCkuXnvoGZt+QtnLqMzer736vlUX0S7E3xMwJ3IFMIbw3e57lC1Uc/oLh8u56KECy56cu61SogBfouNlISoRbH2jgw2QFpLabD90dhnpPfzwUqhbSGJ+8slI7e9eazdC4Pd7zkcJ+pDCJPnFS2ag1cXIkUH+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3E3hw7xM2wqA/rgfGWjje0XS6n1hVv9W4BSDvvJxg=;
 b=PBWSWRWTNnRt6nTaDUkM1vrbNHm5GAxjeonM+pevYbkuPEPTWjHD9LPsgeyBzUTZ9/ZFYZWskZtDjy+KUX4gdDlTPnxXcRe0yHXzT+0MFiRIf2hJ++h2f7nZtBP+ldBlPg/niIqE5HOU2UBSb4vXnwjKsgesWkfJxYJyook2a0U=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1488.namprd11.prod.outlook.com (2603:10b6:301:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 19:05:03 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%7]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 19:05:03 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "tedd.an@linux.intel.com" <tedd.an@linux.intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Combine common functions for NetKeys and
 AppKeys
Thread-Topic: [PATCH BlueZ v2] mesh: Combine common functions for NetKeys and
 AppKeys
Thread-Index: AQHXBY6mEeyBzQbxnkC2pqU7MhadsKpeRs0A
Date:   Thu, 18 Feb 2021 19:05:02 +0000
Message-ID: <0bf04a728472a4e9b1fd09f882b4b4ded163ab2b.camel@intel.com>
References: <20210218003956.23887-1-inga.stotland@intel.com>
In-Reply-To: <20210218003956.23887-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5df9cd5-297f-4fc4-aa18-08d8d44018c7
x-ms-traffictypediagnostic: MWHPR11MB1488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14889D2674150B94A0BCA847E1859@MWHPR11MB1488.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCxp9g1vl89ioDt5ocaos3ONzPooPvJLWLHYDisIc5jqRFPwFZboCbzH0ahbvfPlumE5Ns8vQy0bEPvZV8fMudJNSwVcVG6Jz+DdpGACQQJFROeaDTHWzsPVwDNr9aOrXnvq33jcNFUk7nVTLLT75vLq7B6A10qT7xX9ogSiaLur8MvWicO5FjZFOo1dhI1ZpEmgzsCfjlByxB2yE4of5gvS+4u5tibUDkrTDIxfw7BBkeWy7uY3gyfBPKGVAMI5mBCg1s3dE8LIBq5gLfNlM9EOKhp59aswxvOJRF09EkhN9q/9QfhiNk/znvPvEeTu8YTldJGBWDmZoHlEFdQSnwuz+HPWJ9M3Lm7cJpb/JLejFgjaCjZG8pr2o8sM028YLtav8vaix1sKRJXf7Hq6poJU1ek3MK3mi0bFsC9WnmW1uqRsHjI/huKnYlIah1g7SDlifYIbSBKV/KJzuamyLaaMfAo0NMgDHVnBkcicg2d64br7gFXNrsN4KjMkESFAR+NP44JNiREX0ppBvt413w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(6486002)(2616005)(316002)(36756003)(8936002)(4326008)(26005)(2906002)(8676002)(110136005)(76116006)(83380400001)(71200400001)(5660300002)(478600001)(66946007)(66446008)(6512007)(64756008)(186003)(6636002)(54906003)(66476007)(66556008)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aTluc1psRW4zRHp5bFpUdk4xUERGckJHTTFCUjFUMXp3VENDb1ZwSnc3QXdn?=
 =?utf-8?B?TkoyK0JSVXgwQVE4SDllc0FJa0dpdDM5Y0NTZkVrajZtSjdkd0tuT3E0c1VN?=
 =?utf-8?B?UlU3aGpGd1FReXNBL1hYT3JtYm1BMG5IaGwwdWdsWWNIODdVbE10ZTB2QzFX?=
 =?utf-8?B?WnRtQ05KVGF1SHZPT25IRm1iU2VCbGRCeldIazIzTmZuZVZkTDhkOFFabXd5?=
 =?utf-8?B?cVZmTGNieGVaT25oRElNV3ZJNlJHcGlzOEhEek4rK1JZZis4S0JLbzRyM2s1?=
 =?utf-8?B?bjNNbjFoK1orQUMyL1JsK1JqWTFvcUFEOWlDZ0l6bEQyVGt5M1NURUtqMWJP?=
 =?utf-8?B?Tjk1cXNadFFzU2huVWJaK09rcW5pQjFLODN6cGZtYTNaaktVTDE0NlZnd0o0?=
 =?utf-8?B?b201dlhJRXNNY2c1UExCbzY3bzBCRXdVcEE1dFR5ZFBhTTc5L003eXhaanJR?=
 =?utf-8?B?dEkyQzZMQXZmMlZEM1doZDIrVjlCeG5vVnN3M1VDTXJhUTJ3cGNNTnpDLzhT?=
 =?utf-8?B?T2xCdjNPbldkMXVIWjhZcUV3ckpISDBoT1hGSWloemtQUzd1R3hJNldyNzJw?=
 =?utf-8?B?TmJhbzRJZitXWVlucmY1aHByWDM5OWZ3K0lQNUFpbWxFSXhHa0h6bHhMNXl2?=
 =?utf-8?B?SUtoZHRENkpFVHZ3a3dTOEJaR3hGSHNHM1lDeWhhZUlIZzBOd0lKb1FKVVVG?=
 =?utf-8?B?TWVaU2d0K0taVlBoWFhEK01jT2xyVlZNdDNHcnJFQVJ3dWFlQlk2b05tYnIr?=
 =?utf-8?B?M3NLYUlrSC9kdHFKL0FmUVFzcHBOT1ZVZ3B5RHJXMm5MdUtPWlZGcEF1NnVV?=
 =?utf-8?B?RzliM1J6WGNmUDVleThXNUlNdnFjYVVadHdyME1kb2pkM2trQU5Zb0JPWVdH?=
 =?utf-8?B?Q3BhVm9hbmUzZEkwVjdjVzFDaFI2ZEFqQmhtZjBnMWV6QUN5b3NXOStNdXha?=
 =?utf-8?B?M0VjN0JSbTFtWVFtNnZDbkIxN0VIRlRZV3BSV1M5OGo2emRsNWhNRjRwREow?=
 =?utf-8?B?V01mb0VqVXJZUUZyS1B0NEpoUGkvNVVlNEpUVEUxQlArTWVpWFFaZXJjK1R5?=
 =?utf-8?B?eEdETkl6ZWhHRlZGNXl4SFA4YmtYOHlQSDVNVzJjQWlRQ1ptYlFqWTVjTnIy?=
 =?utf-8?B?clNhNUdNeDdpMVBMY3kvc0JzVldiQTJRVUViU2p6U0ZySDcwczB2V25BZmlO?=
 =?utf-8?B?Vm1jQ0doNnMzRGxLN20xcXdVMXNqNk94N04wOTlrMDRZS3RoYmZoQm0wa3Vn?=
 =?utf-8?B?OVVIZDZ2SnluQVRDb3FLcUVvdkQ2R1FtSWR5V0N6RmJHMWdQcmE1ZDhwVThG?=
 =?utf-8?B?Rm5GKzdyTFl4b3M2MEROcUoxbE0vaEdEek9naDJrU0E5b3JubFRYK2pTYllM?=
 =?utf-8?B?ODhqVG1GSytIQVZzc2lEbk1UOUhDWUhUUmRwVTlGVldRZGVsR2dpcUFUSU1l?=
 =?utf-8?B?b09ZWjltWXhRUkJnZ29GQjUxSFQ2K0tiZnl4UlNmTXB5dUNIb3BRMW9ZWFgx?=
 =?utf-8?B?TTlrMUJLMzUxb1NGK3pGUmpHbVNRQitUZ3VreVMzWkpIeElZSVFrWTB4MUQ5?=
 =?utf-8?B?R1BMb0hSbU9kN09kQWhjd1pIODFTaGJVMXlHREI5ZWdYQ3VDakI0aEVpVy8w?=
 =?utf-8?B?LzFrSUEvMzBGdWRqNGJpOEFFU21FVHBmZFQzR0R5VGhzb1V3Q2p0UjlCaENn?=
 =?utf-8?B?ZFlXSmpLemdON0Z3T0UyRGljUzhndDE5a0ZUeFZHQnh0M3FkV2RHV0V5M3Iv?=
 =?utf-8?Q?sfduPE3HeBQC4PL0dkImu7ytneKM1dU34fuXfKY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D31ADC23B67A9D4E9A3824DCDA49BE4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5df9cd5-297f-4fc4-aa18-08d8d44018c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 19:05:03.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJzOmjHpkO/kHNrAQpOya2nKMj+uivaIrdtWSbds7R8r5atj92lSUeEh7m7OF3XHa0G+A3YHtKzCSTR7QgkY/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1488
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIGFkZGl0aW9uYWwgdHdlZWsgb2YgY2hhbmdpbmcgZmlsZSBtb2RlcyBmcm9t
IHN5bWJvbGljIG5hbWVzIHRvIDA2MDAgdG8gY29uZm9ybSB0byBuZXcgdGVzdHMgaW4NCmNoZWNr
cGF0Y2ggYW5kIGtlcm5lbCBzdGFuZGFyZHMuDQoNCk9uIFdlZCwgMjAyMS0wMi0xNyBhdCAxNjoz
OSAtMDgwMCwgSW5nYSBTdG90bGFuZCB3cm90ZToNCj4gTm8gY2hhbmdlIGluIGZ1bmN0aW9uYWxp
dHksIGNvZGUgdGlnaHRlbmluZy4NCj4gLS0tDQo+ICBtZXNoL2tleXJpbmcuYyB8IDExNyArKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgNjggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9rZXlyaW5nLmMgYi9tZXNoL2tleXJpbmcuYw0KPiBpbmRleCAwYjc0ZWU5MTQu
LmNiMDQ0MzdlZCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9rZXlyaW5nLmMNCj4gKysrIGIvbWVzaC9r
ZXlyaW5nLmMNCj4gQEAgLTMzLDMxICszMyw0NSBAQCBjb25zdCBjaGFyICpkZXZfa2V5X2RpciA9
ICIvZGV2X2tleXMiOw0KPiAgY29uc3QgY2hhciAqYXBwX2tleV9kaXIgPSAiL2FwcF9rZXlzIjsN
Cj4gIGNvbnN0IGNoYXIgKm5ldF9rZXlfZGlyID0gIi9uZXRfa2V5cyI7DQo+ICANCj4gLWJvb2wg
a2V5cmluZ19wdXRfbmV0X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRf
aWR4LA0KPiAtCQkJCQkJc3RydWN0IGtleXJpbmdfbmV0X2tleSAqa2V5KQ0KPiArc3RhdGljIGlu
dCBvcGVuX2tleV9maWxlKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIGNvbnN0IGNoYXIgKmtleV9k
aXIsDQo+ICsJCQkJCQkJdWludDE2X3QgaWR4LCBpbnQgZmxhZ3MpDQo+ICB7DQo+ICAJY29uc3Qg
Y2hhciAqbm9kZV9wYXRoOw0KPiAtCWNoYXIga2V5X2ZpbGVbUEFUSF9NQVhdOw0KPiAtCWJvb2wg
cmVzdWx0ID0gZmFsc2U7DQo+IC0JaW50IGZkOw0KPiArCWNoYXIgZm5hbWVbUEFUSF9NQVhdOw0K
PiAgDQo+IC0JaWYgKCFub2RlIHx8ICFrZXkpDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gKwlpZiAo
IW5vZGUpDQo+ICsJCXJldHVybiAtMTsNCj4gIA0KPiAgCW5vZGVfcGF0aCA9IG5vZGVfZ2V0X3N0
b3JhZ2VfZGlyKG5vZGUpOw0KPiAgDQo+IC0JaWYgKHN0cmxlbihub2RlX3BhdGgpICsgc3RybGVu
KG5ldF9rZXlfZGlyKSArIDEgKyAzID49IFBBVEhfTUFYKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+
ICsJaWYgKHN0cmxlbihub2RlX3BhdGgpICsgc3RybGVuKGtleV9kaXIpICsgMSArIDMgPj0gUEFU
SF9NQVgpDQo+ICsJCXJldHVybiAtMTsNCj4gKw0KPiArCWlmIChmbGFncyAmIE9fQ1JFQVQpIHsN
Cj4gKwkJc25wcmludGYoZm5hbWUsIFBBVEhfTUFYLCAiJXMlcyIsIG5vZGVfcGF0aCwga2V5X2Rp
cik7DQo+ICsJCW1rZGlyKGZuYW1lLCAwNzU1KTsNCj4gKwl9DQo+ICANCj4gLQlzbnByaW50Zihr
ZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzIiwgbm9kZV9wYXRoLCBuZXRfa2V5X2Rpcik7DQo+ICsJ
c25wcmludGYoZm5hbWUsIFBBVEhfTUFYLCAiJXMlcy8lMy4zeCIsIG5vZGVfcGF0aCwga2V5X2Rp
ciwgaWR4KTsNCj4gIA0KPiAtCW1rZGlyKGtleV9maWxlLCAwNzU1KTsNCj4gKwlpZiAoZmxhZ3Mg
JiBPX0NSRUFUKQ0KPiArCQlyZXR1cm4gb3BlbihmbmFtZSwgZmxhZ3MsIFNfSVJVU1IgfCBTX0lX
VVNSKTsNCj4gKwllbHNlDQo+ICsJCXJldHVybiBvcGVuKGZuYW1lLCBmbGFncyk7DQo+ICt9DQo+
ICANCj4gLQlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzLyUzLjN4Iiwgbm9kZV9w
YXRoLCBuZXRfa2V5X2RpciwNCj4gLQkJCQkJCQkJbmV0X2lkeCk7DQo+IC0JbF9kZWJ1ZygiUHV0
IE5ldCBLZXkgJXMiLCBrZXlfZmlsZSk7DQo+ICtib29sIGtleXJpbmdfcHV0X25ldF9rZXkoc3Ry
dWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCwNCj4gKwkJCQkJCXN0cnVjdCBr
ZXlyaW5nX25ldF9rZXkgKmtleSkNCj4gK3sNCj4gKwlib29sIHJlc3VsdCA9IGZhbHNlOw0KPiAr
CWludCBmZDsNCj4gKw0KPiArCWlmICgha2V5KQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4g
KwlmZCA9IG9wZW5fa2V5X2ZpbGUobm9kZSwgbmV0X2tleV9kaXIsIG5ldF9pZHgsDQo+ICsJCQkJ
CU9fV1JPTkxZIHwgT19DUkVBVCB8IE9fVFJVTkMpOw0KPiAgDQo+IC0JZmQgPSBvcGVuKGtleV9m
aWxlLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DLCBTX0lSVVNSIHwgU19JV1VTUik7DQo+
ICAJaWYgKGZkIDwgMCkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+IEBAIC03MiwyOCArODYs
MTQgQEAgYm9vbCBrZXlyaW5nX3B1dF9uZXRfa2V5KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVp
bnQxNl90IG5ldF9pZHgsDQo+ICBib29sIGtleXJpbmdfcHV0X2FwcF9rZXkoc3RydWN0IG1lc2hf
bm9kZSAqbm9kZSwgdWludDE2X3QgYXBwX2lkeCwNCj4gIAkJCQl1aW50MTZfdCBuZXRfaWR4LCBz
dHJ1Y3Qga2V5cmluZ19hcHBfa2V5ICprZXkpDQo+ICB7DQo+IC0JY29uc3QgY2hhciAqbm9kZV9w
YXRoOw0KPiAtCWNoYXIga2V5X2ZpbGVbUEFUSF9NQVhdOw0KPiAgCWJvb2wgcmVzdWx0ID0gZmFs
c2U7DQo+ICAJaW50IGZkOw0KPiAgDQo+IC0JaWYgKCFub2RlIHx8ICFrZXkpDQo+IC0JCXJldHVy
biBmYWxzZTsNCj4gLQ0KPiAtCW5vZGVfcGF0aCA9IG5vZGVfZ2V0X3N0b3JhZ2VfZGlyKG5vZGUp
Ow0KPiAtDQo+IC0JaWYgKHN0cmxlbihub2RlX3BhdGgpICsgc3RybGVuKGFwcF9rZXlfZGlyKSAr
IDEgKyAzID49IFBBVEhfTUFYKQ0KPiArCWlmICgha2V5KQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+
ICANCj4gLQlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzIiwgbm9kZV9wYXRoLCBh
cHBfa2V5X2Rpcik7DQo+IC0NCj4gLQlta2RpcihrZXlfZmlsZSwgMDc1NSk7DQo+ICsJZmQgPSBv
cGVuX2tleV9maWxlKG5vZGUsIGFwcF9rZXlfZGlyLCBhcHBfaWR4LCBPX1JEV1IpOw0KPiAgDQo+
IC0Jc25wcmludGYoa2V5X2ZpbGUsIFBBVEhfTUFYLCAiJXMlcy8lMy4zeCIsIG5vZGVfcGF0aCwg
YXBwX2tleV9kaXIsDQo+IC0JCQkJCQkJCWFwcF9pZHgpOw0KPiAtCWxfZGVidWcoIlB1dCBBcHAg
S2V5ICVzIiwga2V5X2ZpbGUpOw0KPiAtDQo+IC0JZmQgPSBvcGVuKGtleV9maWxlLCBPX1JEV1Ip
Ow0KPiAgCWlmIChmZCA+PSAwKSB7DQo+ICAJCXN0cnVjdCBrZXlyaW5nX2FwcF9rZXkgb2xkX2tl
eTsNCj4gIA0KPiBAQCAtMTA1LDEyICsxMDUsMTIgQEAgYm9vbCBrZXlyaW5nX3B1dF9hcHBfa2V5
KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IGFwcF9pZHgsDQo+ICAJCX0NCj4gIA0K
PiAgCQlsc2VlayhmZCwgMCwgU0VFS19TRVQpOw0KPiAtCX0gZWxzZSB7DQo+IC0JCWZkID0gb3Bl
bihrZXlfZmlsZSwgT19XUk9OTFkgfCBPX0NSRUFUIHwgT19UUlVOQywNCj4gLQkJCQkJCQlTX0lS
VVNSIHwgU19JV1VTUik7DQo+IC0JCWlmIChmZCA8IDApDQo+IC0JCQlyZXR1cm4gZmFsc2U7DQo+
IC0JfQ0KPiArCX0gZWxzZQ0KPiArCQlmZCA9IG9wZW5fa2V5X2ZpbGUobm9kZSwgYXBwX2tleV9k
aXIsIGFwcF9pZHgsDQo+ICsJCQkJCQlPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DKTsNCj4g
Kw0KPiArCWlmIChmZCA8IDApDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAgCWlmICh3cml0
ZShmZCwga2V5LCBzaXplb2YoKmtleSkpID09IHNpemVvZigqa2V5KSkNCj4gIAkJcmVzdWx0ID0g
dHJ1ZTsNCj4gQEAgLTIyNiwyNCArMjI2LDE5IEBAIGJvb2wga2V5cmluZ19wdXRfcmVtb3RlX2Rl
dl9rZXkoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgdW5pY2FzdCwNCj4gIAlyZXR1
cm4gcmVzdWx0Ow0KPiAgfQ0KPiAgDQo+IC1ib29sIGtleXJpbmdfZ2V0X25ldF9rZXkoc3RydWN0
IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCwNCj4gLQkJCQkJCXN0cnVjdCBrZXly
aW5nX25ldF9rZXkgKmtleSkNCj4gK3N0YXRpYyBib29sIGdldF9rZXkoc3RydWN0IG1lc2hfbm9k
ZSAqbm9kZSwgY29uc3QgY2hhciAqa2V5X2RpciwNCj4gKwkJCQkJdWludDE2X3Qga2V5X2lkeCwg
dm9pZCAqa2V5LCBzc2l6ZV90IHN6KQ0KPiAgew0KPiAtCWNvbnN0IGNoYXIgKm5vZGVfcGF0aDsN
Cj4gLQljaGFyIGtleV9maWxlW1BBVEhfTUFYXTsNCj4gIAlib29sIHJlc3VsdCA9IGZhbHNlOw0K
PiAgCWludCBmZDsNCj4gIA0KPiAtCWlmICghbm9kZSB8fCAha2V5KQ0KPiArCWlmICgha2V5KQ0K
PiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gLQlub2RlX3BhdGggPSBub2RlX2dldF9zdG9yYWdl
X2Rpcihub2RlKTsNCj4gLQlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzLyUzLjN4
Iiwgbm9kZV9wYXRoLCBuZXRfa2V5X2RpciwNCj4gLQkJCQkJCQkJbmV0X2lkeCk7DQo+ICsJZmQg
PSBvcGVuX2tleV9maWxlKG5vZGUsIGtleV9kaXIsIGtleV9pZHgsIE9fUkRPTkxZKTsNCj4gIA0K
PiAtCWZkID0gb3BlbihrZXlfZmlsZSwgT19SRE9OTFkpOw0KPiAgCWlmIChmZCA+PSAwKSB7DQo+
IC0JCWlmIChyZWFkKGZkLCBrZXksIHNpemVvZigqa2V5KSkgPT0gc2l6ZW9mKCprZXkpKQ0KPiAr
CQlpZiAocmVhZChmZCwga2V5LCBzeikgPT0gc3opDQo+ICAJCQlyZXN1bHQgPSB0cnVlOw0KPiAg
DQo+ICAJCWNsb3NlKGZkKTsNCj4gQEAgLTI1MiwzMCArMjQ3LDE2IEBAIGJvb2wga2V5cmluZ19n
ZXRfbmV0X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiAg
CXJldHVybiByZXN1bHQ7DQo+ICB9DQo+ICANCj4gK2Jvb2wga2V5cmluZ19nZXRfbmV0X2tleShz
dHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiArCQkJCQkJc3RydWN0
IGtleXJpbmdfbmV0X2tleSAqa2V5KQ0KPiArew0KPiArCXJldHVybiBnZXRfa2V5KG5vZGUsIG5l
dF9rZXlfZGlyLCBuZXRfaWR4LCBrZXksIHNpemVvZigqa2V5KSk7DQo+ICt9DQo+ICsNCj4gIGJv
b2wga2V5cmluZ19nZXRfYXBwX2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBh
cHBfaWR4LA0KPiAgCQkJCQkJc3RydWN0IGtleXJpbmdfYXBwX2tleSAqa2V5KQ0KPiAgew0KPiAt
CWNvbnN0IGNoYXIgKm5vZGVfcGF0aDsNCj4gLQljaGFyIGtleV9maWxlW1BBVEhfTUFYXTsNCj4g
LQlib29sIHJlc3VsdCA9IGZhbHNlOw0KPiAtCWludCBmZDsNCj4gLQ0KPiAtCWlmICghbm9kZSB8
fCAha2V5KQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gLQlub2RlX3BhdGggPSBub2RlX2dl
dF9zdG9yYWdlX2Rpcihub2RlKTsNCj4gLQlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIl
cyVzLyUzLjN4Iiwgbm9kZV9wYXRoLCBhcHBfa2V5X2RpciwNCj4gLQkJCQkJCQkJYXBwX2lkeCk7
DQo+IC0NCj4gLQlmZCA9IG9wZW4oa2V5X2ZpbGUsIE9fUkRPTkxZKTsNCj4gLQlpZiAoZmQgPj0g
MCkgew0KPiAtCQlpZiAocmVhZChmZCwga2V5LCBzaXplb2YoKmtleSkpID09IHNpemVvZigqa2V5
KSkNCj4gLQkJCXJlc3VsdCA9IHRydWU7DQo+IC0NCj4gLQkJY2xvc2UoZmQpOw0KPiAtCX0NCj4g
LQ0KPiAtCXJldHVybiByZXN1bHQ7DQo+ICsJcmV0dXJuIGdldF9rZXkobm9kZSwgYXBwX2tleV9k
aXIsIGFwcF9pZHgsIGtleSwgc2l6ZW9mKCprZXkpKTsNCj4gIH0NCj4gIA0KPiAgYm9vbCBrZXly
aW5nX2dldF9yZW1vdGVfZGV2X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCB1
bmljYXN0LA0K
