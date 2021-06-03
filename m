Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965CC47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 23:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B89261411
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 23:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCXbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:31:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:16385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFCXbM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 19:31:12 -0400
IronPort-SDR: tDzy5280rPSnSMtwxAJwWDoFbMrFoZcIdu5keT58cLb1UwFzwUgesFbGEIoYDhUa75bripseR3
 6l7f4Y8bcgdg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="268043616"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="268043616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:29:24 -0700
IronPort-SDR: 4us/uZqpnO45sZGiBfh9NoU+kJH98FB2yCI09avqevoGpGtNhyN5SfC9z6NFTnoVwZIOykDyVY
 PlezKw1JbO0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="468142461"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2021 16:29:23 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 16:29:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 16:29:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 3 Jun 2021 16:29:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 3 Jun 2021 16:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkjBPVHchbhJ2Shs9nq0h9lnEmtq1YNUX3Qv2smrmFZ0se2dvgBvprZIDk1Z2ZlydpdUgpUItoWvVtPbW8/nr+E1XvtJFXXqlzQDTAAQZMl7VSPIRj5HU+IfMrn9MkPLL09svMMSF3CrUBlrCIc/vpYhlEKNsShQ6omkA2ZIF8OY4nFR9U7WI+RiqKL35C7jlr/QqZGCBH9nx8ksZxsHbfdbxU9TP+4llLcGTP5t4L97bYZinjPUjuXj8fZ7e3/grMDpM0Pubiyk/pYc/IvDCbCErH4x47leYgREttLX1kVi1ivdGIDEUh2Jy3jq/LNqDyK9pS4iygY/4/F8OiGZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpQopwSR+RVQkdAEuLqxaFuU5p0aQztI/EPUnuSVNec=;
 b=HD2Ns/iAW5JzNv8TEDGEOXbyea3iFw4P4vvTfBnLnOBc1+9SbYlB+i1ugwz5ivXPKKnhJpLo/MPORaaRjQCbAiMCIZEOU7qSv+xd4DqKswWvGR0g9Zc0tYvyK2s9Ss3CjWL83fFuynk+Rr83y4u3Pa4j1bpfZlf8xLsgpqj1irzus6NNz9Vujn4CYdLRVVMg9ndRQFnbnfOaruJYka5U5JivYNVNxzncmt75H3M7wGt17sucZS6LBNGjTiGop6qLq0gBErK/FzkRiyc5M+QrBeDV6o/YBXDLK4o0d4suFgavV5KhqKPfchSsgAs0YzfuF9yd3e8MDpyRI+bOkKKIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpQopwSR+RVQkdAEuLqxaFuU5p0aQztI/EPUnuSVNec=;
 b=nAARrhBC/wDVL44WZ+XE18RL2jrFS8qij4f2jcGbf6zvr/IOTKaN6+zgD3nO+/4WTZw23O3nf1lHhRX1gQFBXPIsoAfKdQNYjdIquidaa+AThaUeFLRKt30T9yAqMQcyd8aM7GZd9DjEt+WdqUl5TYS2r09cfbTTUNHNlqJ3YO0=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB3343.namprd11.prod.outlook.com (2603:10b6:805:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 23:29:20 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::acc9:8813:eb2b:3480]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::acc9:8813:eb2b:3480%7]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 23:29:20 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "cinaed.simson@gmail.com" <cinaed.simson@gmail.com>
Subject: Re: bluetooth mesh
Thread-Topic: bluetooth mesh
Thread-Index: AQHXWMr/RbXL2DqvBE2Cz4PkGZaIoKsC7veA
Date:   Thu, 3 Jun 2021 23:29:20 +0000
Message-ID: <99a8d9f3c9fe84462210e439cebfbb70636103e0.camel@intel.com>
References: <16f88f89-d3ad-350c-0a7c-e3da3ea202fd@gmail.com>
In-Reply-To: <16f88f89-d3ad-350c-0a7c-e3da3ea202fd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 177b0b1d-3936-426d-1c7f-08d926e769ab
x-ms-traffictypediagnostic: SN6PR11MB3343:
x-microsoft-antispam-prvs: <SN6PR11MB3343AFF6BCE5096B8DD06E62E13C9@SN6PR11MB3343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvPdSfvwzYqEjRrCn3q129WymaRBKgflu16IN8hutbiCtmA8xk46owtfKcm4FAZ7crSAn/Kcv3uOT/Mr8JlhF9aMmMpi/iYbsHC6iIEUsxeKJvuPnq1ZxXIXL7jQGf2XdbnIdPUrpY/SiUNl85XlVoOoDiUwy1SJdDHvUKENFxFC9MB+QF028t5P6erwlLvF4BF/4ZKWpl/JMSETGw8QyIb+lXdXtMsiTGbDoKgI2OL0Q+PfkvmPU+zcBi8BdbbeGB1XM1vIK5/W/Eb+R7yTDt3cgc3ZskquXEd+9A8XM+/dJvp5QH65pXf29Hp8QEprXDxp7lcVd8SmXR0y9APFYy6zmsLim5JQvBAQzBmh6OswjgXMcVAstVYwsSylWkjItbI0JlsWgdQaMsqAaRTSvmXFI0IhO90EkExawpolgqA3iWNBdIcerhYy9wWsIlHH6mmE2jo8YQ/Gw1NJE0dpofet0kTqQc/tRI9bvTySVLgqvLb6FO0mcDIxIdxRDu1mY00Icij6SR258V1tB1B3zcueF9P4x1JgfAE5Z8e5/xAnBDopFPuKDY6tCyHZhIwZT1hLRq35/khL3lgma/ZxHPSO0uNey2hkXHcsOllBI5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(136003)(39860400002)(26005)(6512007)(4744005)(2616005)(6486002)(5660300002)(38100700002)(2906002)(91956017)(186003)(36756003)(110136005)(8936002)(76116006)(71200400001)(6506007)(64756008)(66556008)(66476007)(66446008)(8676002)(478600001)(86362001)(66946007)(3480700007)(122000001)(316002)(7116003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TkNwZlJWdUJEVE5EUlpNK2VMUXdsRVhmdnB4TVZXTFFHalljNUFpSmZVT1dv?=
 =?utf-8?B?UjQzcmpuVkhFVStneGZjVlplbFhJcDN0eStNTS84OHFDVmt2eVF6bUVRRWg2?=
 =?utf-8?B?RGxlOEQzeVRoR2NxMGJmK21QM0diZG5xM2tuRFdnN3lYUVB4TzJLTUtJS2ZE?=
 =?utf-8?B?dzhHWVY5b01WWjJSVUV5aVpEbU53QUZyb2JPSEl3SWV3b2QvU28yZ3hvVkpB?=
 =?utf-8?B?TE9xMktoSmMxelkzVndqZmhmQ20zem9FWWtueGxtQXFyOHdYcGcySEhFb0Yx?=
 =?utf-8?B?STlpaGMrM0tDMCtKeGRCeEFnaWpJVEh6L2luakVLeWN4MHM3RnhsMGFZZWtl?=
 =?utf-8?B?ZnhEWDVtdkdmOU0vSFZlSXNwTVpITXhNL1NEZWF4ay9DQ0xlRG5sWjFuc05R?=
 =?utf-8?B?aFpFNHhLOXhDZHUrQkdtYlovd003SExQNGVDRjdNaTJrbC9WblpSeERwY21m?=
 =?utf-8?B?L3B5T21KTUlTWmtudGVZaTBrT3lvREdmYUowZ1F5SEsvblN4dUJ2eVNnM09W?=
 =?utf-8?B?SFg1NGd5UkhROFhoM2VaMFQ3TmdadUVLdUFBQWp2bStxSXFuaGxuZjBabnd1?=
 =?utf-8?B?RWN4YTJreHJsODVld1VRUWxsYVNLVFNVUVNsZE5ReU56cDg0ZElhWWxwbkZq?=
 =?utf-8?B?bnlFU3hHcW5BYjdtbWVFcXk4Q1Y3MytEaWFiL0tIYTBSM2lwcEQvN0o2M3N5?=
 =?utf-8?B?SVBDMEZnajhLUnNnMUNQcXZxRFE5U1J1V0FPZ0ZpS1UzdHNFOVE2cU9hQmRs?=
 =?utf-8?B?ODRXVjNmMXAyR1JlMzF3RzNLQWRzeUk4ZXhaWllZT2k5WDVES3FTaVA5cExr?=
 =?utf-8?B?U3pWVlBiSktPbDdKRkg0WlBKTk90ZGh1aGhncWFGenVqc0xGYlVtTENma05G?=
 =?utf-8?B?WWkzakdhRWxDaG5CQXpuKzREU0RWamZJdExjT1lieXNwVU9qTGJpdkhYTEdt?=
 =?utf-8?B?UXg3NVQ4VjVkaGZoOUVLVkF0U251d1hPYk5EN1J2VXRmQ3lMelJHTk1wbDdU?=
 =?utf-8?B?WnJqTTR4c2ZBS0M4UUt3dkxsRjAzZTgrdDl2MnlMaS9CVFB5Tkp3UWEreDNR?=
 =?utf-8?B?UDV2aURVMklydXhXQlJ0NFFTOEU2emxVZXhaVmRsNWJoV3RYWjRtNzJWL2J6?=
 =?utf-8?B?bXNSd2lyTjhVa013S01DNENoenJJbXp5MEJtQmhCaVp0dlVQZ2hkSDBSK2dD?=
 =?utf-8?B?RXFqRTU1UXhTRmJtVjRJU01WcEpuUG10Vm1vdlN3dTR5VVJoZys4M2FZMXQ2?=
 =?utf-8?B?dUZJY000TFY0ZDhwYlFyWENrdi9QQmhFaHFpcUdZdTFXRGNCSXllZVNHd01p?=
 =?utf-8?B?SWN1OFRVdXBlRG9kRXMvT3hnWTF6UzBRWWRkZGRqTVNiVVZOS0FIR21aU3o5?=
 =?utf-8?B?QUVaTDRmNXVLM3hNa3VDTC9zMjhhdEx0SDFOZkVMM1VhWks3dEdDcGQvcXBR?=
 =?utf-8?B?bFRyUEovaCtHZnQ2SW8vZXptSVh0Q2dtbXh5S1MvNmNYY3ZXSTNYenlTNEsy?=
 =?utf-8?B?VFNTU2xNN3JCQWtnMSt0b2Y0VmVtdG9VZDFQdTRzWjR6WEFJZHlzeFRJeHVS?=
 =?utf-8?B?K2JKNlljVDRUaHA0Tk1VM0REV25QaVRDbUF5SW54Z3NiSUpnWGJVZVRhb2Fm?=
 =?utf-8?B?MVRZWGFRMjlMcG84Sm8xbnRnMXNGMC8vMEhVZzEzRHRPSnE3VXdxSjJ1ZXZO?=
 =?utf-8?B?VlFHdkt6V004RFFyd0U1K2RjSy9iLzR0V0tZM3JGSXVpRzVlTEVndjd1d0U4?=
 =?utf-8?Q?OZ/XjaEYQffjaOiE46ObZz769cj746C2HNeRX2z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D13D9854A605A84BB621489C164A45C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177b0b1d-3936-426d-1c7f-08d926e769ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 23:29:20.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyCwoA3xOryF3Ug2Zi6Sli5i/1e4oyW8OFMEuJ4vvwgm2GjNtLiZhQt5lYTcY2qEC0yE0o40SEuZbPd/KSI4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3343
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQ2luYWVkLA0KDQpPbiBUaHUsIDIwMjEtMDYtMDMgYXQgMTU6NDkgLTA3MDAsIENpbmFlZCBT
aW1zb24gd3JvdGU6DQo+IEhpIC0gd2hhdCBhcmUgbWludW0gcmVxdWlyZW1lbnRzIGZvciB1c2lu
ZyBtZXNoPw0KPiANCj4gSSdtIGluIHRoZSBwcm9jZXNzIG9mIGluc3RhbGxpbmcgdGhlIGxhdGVz
dCBnaXQgdmVyc2lvbiBvZiBibHVleiBvbiAyIA0KPiBzaW5nbGUgYm9hcmQgY29tcHV0ZXIgQVJN
IDY0IG9kcm9pZCBydW5uaW5nIHN0cmV0Y2guDQo+IA0KPiBCb3RoIGhhdmUgNC54IGtlcm5lbHMg
YnV0IEkgZG91YnQgaWYgdGhleSBoYXZlIHRoZSBjcnlwb3RncmFpY2gga2VybmVsIA0KPiBtb2R1
bGVzLg0KPiANCj4gSSdtIGRvaW5nIHRoaXMgdG8gbGVhcm4gYWJvdXQgYmx1ZXRvb3RoIG1lc2gg
c28gSSBkb24ndCBjYXJlIGFib3V0IA0KPiBwZXJmb3JtYW5jZS4NCj4gDQo+IC0tIENpbmFlZA0K
DQpUaGUgUkVBRE1FIGZpbGUgaW4gYmx1ZXogaXMgY3VycmVudGx5IHVwIHRvIGRhdGUsIGFuZCB0
aHVzIHRoZSBtaW5pbXVtIHJlcXVpcmVtZW50cyBhcmUgY3VycmVudGx5Og0KDQoxLiBBIG1pbmlt
dW0gb2Yga2VybmVsIHZlcnNpb24gNC45IG9yIGxhdGVyIGlzIHJlcXVpcmVkDQoNCjIuIFRoZSBr
ZXJuZWwgbXVzdCBhdCBhIG1pbmltdW0gaGF2ZSB0aGUgZm9sbG93aW5nIC5jb25maWcgb3B0aW9u
cyB0dXJuZWQgb246DQoJQ09ORklHX0NSWVBUT19VU0VSDQoJQ09ORklHX0NSWVBUT19VU0VSX0FQ
SQ0KCUNPTkZJR19DUllQVE9fVVNFUl9BUElfQUVBRA0KCUNPTkZJR19DUllQVE9fVVNFUl9BUElf
SEFTSA0KDQoJQ09ORklHX0NSWVBUT19BRVMNCglDT05GSUdfQ1JZUFRPX0NDTQ0KCUNPTkZJR19D
UllQVE9fQUVBRA0KCUNPTkZJR19DUllQVE9fQ01BQw0KDQpGdXR1cmUgdmVyc2lvbnMgb2YgbWVz
aCB3aWxsIHByb2JhYmx5IGFsc28gcmVxdWlyZToNCg0KQ09ORklHX0NSWVBUT19ITUFDDQpDT05G
SUdfQ1JZUFRPX1NIQTI1Ng0KDQoNCg0K
