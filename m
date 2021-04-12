Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366CFC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3878611F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhDLIbe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:31:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:42340 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237019AbhDLIbd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 04:31:33 -0400
IronPort-SDR: H4BClqktziI+TLji3KDwtHhtTe9obsp8PD562E+xooTeSM3WoGKhGmZ14pjo/U58dzVsXNk1cV
 I91aNrut4Gww==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="258115316"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="258115316"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 01:31:15 -0700
IronPort-SDR: NXWTc3/MBCZFOo+q000jPGiy/2fmnsc3YG2ZsmsjxfHDUfHL+Sc+fo6Li3t9wfupv9XNEhJ3Sv
 LTZ/YejK0Wng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="460076280"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2021 01:31:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 01:31:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 01:31:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 01:31:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 01:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg+pAAGnzzLvpg52PAkGVMKE7Zmcmx0sjda7oqkFI01Jmka33gLXTIRs+lKAn3xx7KdMJWh4KNGvDWpzqpQ2nlSrWO1UWduwLEHHronLLXPyDf5qSD55I08bG9MylksezM0sQvPGliSUEPqxQrCqI4yKZZSb30P89f71XPpU7e8nk3KS0nOex+okXdCbD5gmJRGzB5eqgz2qvFDzzzsdLnnAJ3Je5iFjMy1GfM9JrViIts1drU0w9iZr+OzmMMEZhEYu8CFKc+SJtdaO9/9aObnYm/bYCeVVkycOdmrkmnD7DrIkBiDPZHcfqjv4hU6M30zCdYicv0n+QHaU/BgYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndx8BPALUJcYcMASjH2zILPsyndEW6M63lWzvjtNxg0=;
 b=WbnSRfOFU3ucMvQxeiYMjgqUIOFHQIQRjmXf0fMX3L0R1seFoCpN8kEBSHxZt8ySmLhjh/Ig9D2w4r1pizN/krCnQHjS1HwICDojz4yAQFWSsb5dE2sb02DixBizGx9tPepKznua6K5iTajMV4alyIQ8Rxs0Ra32K22o6Exf/cy8b1dy4lhqaQOqUN5K54MMxwVV2SlSx1KuBSrEOr/nC+F/4XOXPjvRZjpUlcuYtvYePaGY2BFK2P8HAFl8uL835Q97jC1bOUde7w1QCHZtKdQHM94ah6WntG18jqXKEzqeichywq9PyHCjKnpc9+AoVrDFNx0iNrBYd2yZN3Zkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndx8BPALUJcYcMASjH2zILPsyndEW6M63lWzvjtNxg0=;
 b=xwW1NbHEyx2ZfTuZajmfFJsa5jd59RaQYzDPKrOdyLts175PebuxBz8lA1RGnNB7yxLn+3hiQKs54f21WH3uXnfPwu1uCS5WrqUESwXH8HHN62utUonYe4gZ25HG/WjjZQEFkdhvddx7raqc8513SYfQF0hQ7rVjiUASeHOBmv4=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Mon, 12 Apr 2021 08:31:12 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::edcc:a0ca:cb7e:13b6]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::edcc:a0ca:cb7e:13b6%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 08:31:12 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH v1 1/3] Bluetooth: add support to enumerate codec
 capabilities
Thread-Topic: [PATCH v1 1/3] Bluetooth: add support to enumerate codec
 capabilities
Thread-Index: AQHXLTrBx4RYEx2h+069sWDnWVSGi6qsaacAgAQoC1A=
Date:   Mon, 12 Apr 2021 08:31:11 +0000
Message-ID: <DM8PR11MB5573378DE2583B2261C54627F5709@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210409122405.29850-1-kiran.k@intel.com>
 <20210409122405.29850-2-kiran.k@intel.com>
 <CABBYNZLm5jqbzDVNLRG4G1bSgK8AwCPmz_gjGZ92Oo2EZxfpvQ@mail.gmail.com>
In-Reply-To: <CABBYNZLm5jqbzDVNLRG4G1bSgK8AwCPmz_gjGZ92Oo2EZxfpvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.171.211.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45fa3d0f-f3ba-43f5-13e1-08d8fd8d545b
x-ms-traffictypediagnostic: DM8PR11MB5623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB562374A853F1386D53E22504F5709@DM8PR11MB5623.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOQ1e5jYA7tDmVFDejgC8/vdbaWsR5Zae46rl1BuS1+QLf7ZY8u/udfIpOsAX48XMrt2tNUDjdmHKhBtVuUfBnhujk4iVA4R+xFZUWXFrzsQ2NrZXquJMtCqJhy/2VPkmQJiRww7EboaMfbYEPiwiVsDFNFQPeb5KovL3D/arpcnLgjFHkWQEufUV4XFq7HDWPGHIEjmeZmaJYdztUL3owV4RKVM45ZIL9UU7s+UD9alNSHEe1bSFH1QHbkzEPC2aQ+HJQJS2agjVAzLGFlWV2LrfpU0QLIjiBKu4C+Jg2RzO7xO63NGeFmDdvwDnpfuiy11g4L+DYeOeb9uYspyrI34PCuStHBArcumeWy29/f2s8+m/NTSSWosRojQqBO2L/Ci7JduJLN+G+AnfkxVqkv5I5jpZuBztSAr94OYENhTcYE/8itGk3aYK6Acti/Hy93zKSYNUIu2I1MVkq0S14zlfhWJlsud5qIe5a9PeXo70SIw4ZdX1mG7sD+sOV2VLA4vhTNv4Plmu1bE8Tm7hy8YISDWqKg9qLsrGY3kSqaeE7pTl/7s+LG/n2BATsuPaq7IHZToGDm/sN2ALm7NDT9TWjgbrkqicl+lEqSoY9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(55016002)(71200400001)(2906002)(53546011)(6916009)(6506007)(7696005)(186003)(4326008)(316002)(107886003)(38100700002)(83380400001)(54906003)(478600001)(76116006)(66556008)(5660300002)(66946007)(66476007)(66446008)(8936002)(64756008)(33656002)(52536014)(8676002)(26005)(9686003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cVJNRk95Sk5Ta1liTmZWOXlxRkZyOGRJT1ZscDluOVdRUFY1MGM2VnBpc2d3?=
 =?utf-8?B?K1lxTzJpaFJlaUhESndHTExRVTcyU1ZnZUdSbHh3UUZiUXRUU2hRQ296Z09j?=
 =?utf-8?B?a2lIZStPY1ozbng5SzE2VThDUDVhaFM3TmtBUGJ0ejFPWEZoLzF0eXc4Vk1q?=
 =?utf-8?B?enhUU3M5L2U3WDdCNDM0Q25XcjgzdkFHZFhNRnhFMGZKZzZRN0JuUzQ3QUZZ?=
 =?utf-8?B?cXRGQXRTcFMvejFnNUJtM29LV3JoK2lxK3VNT3M5MHFxdzdlL2VZbjRSWlZM?=
 =?utf-8?B?YklmNFp6bmtVYW4wNnJ5RmpIbHpJaGJPcnZrblhGRHFydGtFY1JkRkVHSURs?=
 =?utf-8?B?MXpoSDRqMHdBWVdvakRZWHFNcnV6RWFXWk1ROXVVeW0yeVlSMnZRSVg4T09M?=
 =?utf-8?B?bGFrVWtVNGkwWFhqRlpWSm9xQ3dGdEwwbGsxTlRpMk9wdUVRS1ljbU95NTlS?=
 =?utf-8?B?U0xRR2pER2RWVzVVTjY5MktjNEswRDR2dXBzd3hCUUhYWEdFS1BLWHVCODg4?=
 =?utf-8?B?SHNRT0VJc243R1dpR3JscDlOMGU0d3NRM0N0TVhubUd2THJlZEw4L3NFVmJF?=
 =?utf-8?B?NXgvS1F6dStGQnpIYTZmcXN0a0xkMWlqZDN4ZW4vL1ErK21PY1plaG1vYzNs?=
 =?utf-8?B?S0hIbTQ3NCtHYUIxL1daYlA1QUpsK1k2Z1dac21tVGZoWVFVMCtFZXZLenc5?=
 =?utf-8?B?R3VqNms3ekZTSDAwbElOZXlYYkNzTFIrOGozMlVBVmtTdk1raXhiaUJyWGtI?=
 =?utf-8?B?bm55ZlpTbU1IbGpESy9iR2RZQVJGRmFxT1YvMnAzNmJJV1c5Rmh6UE92TTVy?=
 =?utf-8?B?dGpjdFB5cUk3V2RQU3lzZXJrVmNzWG00L2l2dnl1c2FRYzVKQm8xWGpOcjZK?=
 =?utf-8?B?RUo5U2Z1ekx5bjBUcmRZYndWUHg4Z3ZtZndpNHEyZHYrUFVQaTVzQStETTFV?=
 =?utf-8?B?VThTWEJSejY1OXgxNnpqM0pUaFIwQlAydHJjSlNwOVNrSXVRWDBnbDJOSktz?=
 =?utf-8?B?dEVGTlR5NlRKVnpOSXRnSHlZYXRKbjJRQkw5cU8rTG9Cbnhkbmw1Smg3R0l1?=
 =?utf-8?B?bFkrRURRdzhzQnlyTHpoS1B5QnpDci9LOVo4WktpSjZ2VmV0eTMvOSs5UEQw?=
 =?utf-8?B?aUJacHh2UXJOaVJ6TU91YnA2ZTRBT3NMSXE2dmEzbW5waXV4emZSK01ISzF6?=
 =?utf-8?B?WWRkcm9UbllyQVNnS2tXU0xWWTNhM2daV0JlSllmNUR3VWRTMmFXWnh3Szd4?=
 =?utf-8?B?ekUvVk9aZUpIOGRDdCs1QjRJL1pPcjc4Q3pyUkJIcjhCcUNKWGwwYnhtRVVS?=
 =?utf-8?B?cGJ5MktTcUJQbjlqbEwvMTBiSi9SUXBndjloUnF5UWo1cjdXUUkva3ZHdFRl?=
 =?utf-8?B?TitQTmJsTlhDQ2lHRFlTc0prWUpqTzZkR1JwRCt5SWRLOUVYYlRUbkpZOWsx?=
 =?utf-8?B?UjB5SVBxSG14K1YrbC9yUFQzSHh3K0hLQUpMTjkvUnZ5cnZQVmcwTENOVHB1?=
 =?utf-8?B?MlBFZ05TQk12YmxmOWRtNXdGQ0JhaDlFcHlLTkdiTW1iNS9hTkZ4U0I0Z1hR?=
 =?utf-8?B?ODF2R2RUNmR4TU9YeGRGQUgyYVdZZnZJM0l6RXF6R2UzazF2dm15NjlEZ0ts?=
 =?utf-8?B?alcxanpjNmJWZ2tESDd6YitVY3ZNZFBsT2w5TXpKNURObEphbVg4ZEJQUGNj?=
 =?utf-8?B?cGV2ZHkzQ0hxRmRYRE0zQTJUdUVuWCtZWkpCREgvS2ZMZ0ZONC9IdFYzckwz?=
 =?utf-8?Q?REnNlKRmiJr/b4Ss0wEAqyd0R+ag6G1YUGClVzV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fa3d0f-f3ba-43f5-13e1-08d8fd8d545b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 08:31:11.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5vLeuIhlZaeFwMLJZzMb+538owVYJdH1dqWhvDUDNuksP8XolaXvnR+WO8RbIr0VvOU4gt7wSSlDHnFoKaGVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuICBJIHdpbGwgZml4IGFuZCBzZW5k
IG91dCBhbiB1cGRhdGVkIHZlcnNpb24uDQoNClJlZ2FyZHMsDQpLaXJhbg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXou
ZGVudHpAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDksIDIwMjEgMTA6MzIgUE0N
Cj4gVG86IEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290
aEB2Z2VyLmtlcm5lbC5vcmc7IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPiA8cmF2aXNoYW5rYXIu
c3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sIENoZXRoYW4NCj4gPGNoZXRoYW4u
dHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgVm9uIERlbnR6LCBMdWl6DQo+IDxsdWl6LnZvbi5k
ZW50ekBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8zXSBCbHVldG9vdGg6
IGFkZCBzdXBwb3J0IHRvIGVudW1lcmF0ZSBjb2RlYw0KPiBjYXBhYmlsaXRpZXMNCj4gDQo+IEhp
IEtpcmFuLA0KPiANCj4gT24gRnJpLCBBcHIgOSwgMjAyMSBhdCA1OjIxIEFNIEtpcmFuIEsgPGtp
cmFuLmtAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IGFkZCBzdXBwb3J0IHRvIGVudW1lcmF0
ZSBsb2NhbCBzdXBwb3J0ZWQgY29kZWMgY2FwYWJpbGl0aWVzDQo+ID4NCj4gPiA8IEhDSSBDb21t
YW5kOiBSZWFkIExvY2FsIFN1cHBvci4uICgweDA0fDB4MDAwZSkgcGxlbiA3DQo+ID4gICAgICAg
ICBDb2RlYzogbVNCQyAoMHgwNSkNCj4gPiAgICAgICAgIExvZ2ljYWwgVHJhbnNwb3J0IFR5cGU6
IDB4MDANCj4gPiAgICAgICAgIERpcmVjdGlvbjogSW5wdXQgKEhvc3QgdG8gQ29udHJvbGxlcikg
KDB4MDApDQo+ID4gPiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUpIHBsZW4gMTIN
Cj4gPiAgICAgICBSZWFkIExvY2FsIFN1cHBvcnRlZCBDb2RlYyBDYXBhYmlsaXRpZXMgKDB4MDR8
MHgwMDBlKSBuY21kIDENCj4gPiAgICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkNCj4gPiAg
ICAgICAgIE51bWJlciBvZiBjb2RlYyBjYXBhYmlsaXRpZXM6IDENCj4gPiAgICAgICAgICBDYXBh
YmlsaXRpZXMgIzA6DQo+ID4gICAgICAgICAwMCAwMCAxMSAxNSAwMiAzMw0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2hldGhhbiBUIE4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNyaXZhdHNhIFJhdmlzaGFua2FyIDxyYXZpc2hhbmthci5zcml2YXRzYUBp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbmV0L2JsdWV0b290aC9oY2kuaCB8ICA3
ICsrKysrDQo+ID4gIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgICB8IDU2DQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2MyBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3Ro
L2hjaS5oIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oDQo+ID4gaW5kZXggZWE0YWU1NTFj
NDI2Li5lM2Y3NzcxZmU4NGYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3Ro
L2hjaS5oDQo+ID4gKysrIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oDQo+ID4gQEAgLTEz
MTQsNiArMTMxNCwxMyBAQCBzdHJ1Y3QgaGNpX3JwX3JlYWRfbG9jYWxfcGFpcmluZ19vcHRzIHsN
Cj4gPiAgICAgICAgIF9fdTggICAgIG1heF9rZXlfc2l6ZTsNCj4gPiAgfSBfX3BhY2tlZDsNCj4g
Pg0KPiA+ICsjZGVmaW5lIEhDSV9PUF9SRUFEX0xPQ0FMX0NPREVDX0NBUFMgICAweDEwMGUNCj4g
PiArc3RydWN0IGhjaV9vcF9yZWFkX2xvY2FsX2NvZGVjX2NhcHMgew0KPiA+ICsgICAgICAgX191
OCAgICBjb2RlY19pZFs1XTsNCj4gPiArICAgICAgIF9fdTggICAgdHJhbnNwb3J0Ow0KPiA+ICsg
ICAgICAgX191OCAgICBkaXJlY3Rpb247DQo+ID4gK30gX19wYWNrZWQ7DQo+ID4gKw0KPiA+ICAj
ZGVmaW5lIEhDSV9PUF9SRUFEX1BBR0VfU0NBTl9BQ1RJVklUWSAweDBjMWIgIHN0cnVjdA0KPiA+
IGhjaV9ycF9yZWFkX3BhZ2Vfc2Nhbl9hY3Rpdml0eSB7DQo+ID4gICAgICAgICBfX3U4ICAgICBz
dGF0dXM7DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgYi9uZXQv
Ymx1ZXRvb3RoL2hjaV9ldmVudC5jDQo+ID4gaW5kZXggMDE2YjI5OTlmMjE5Li5jZWVkNWE1ZDMz
MmIgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYw0KPiA+ICsrKyBi
L25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMNCj4gPiBAQCAtODg3LDYgKzg4Nyw1OCBAQCBzdGF0
aWMgdm9pZCBoY2lfY2NfcmVhZF9kYXRhX2Jsb2NrX3NpemUoc3RydWN0DQo+IGhjaV9kZXYgKmhk
ZXYsDQo+ID4gICAgICAgICAgICAgICAgaGRldi0+YmxvY2tfY250LCBoZGV2LT5ibG9ja19sZW4p
OyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGhjaV9jY19yZWFkX2xvY2FsX2NvZGVjcyhzdHJ1
Y3QgaGNpX2RldiAqaGRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHNrX2J1ZmYgKnNrYikgew0KPiA+ICsgICAgICAgX191OCBudW1fY29kZWNzOw0K
PiA+ICsgICAgICAgX191OCAqcHRyOw0KPiA+ICsgICAgICAgc3RydWN0IGhjaV9vcF9yZWFkX2xv
Y2FsX2NvZGVjX2NhcHMgY2FwczsNCj4gPiArDQo+ID4gKyAgICAgICBidF9kZXZfZGJnKGhkZXYs
ICJzdGF0dXMgMHglMi4yeCIsIHNrYi0+ZGF0YVswXSk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KHNrYi0+ZGF0YVswXSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiAr
ICAgICAgIC8qIGVudW1lcmF0ZSBzdGFuZGFyZCBjb2RlY3MgKi8NCj4gPiArICAgICAgIHNrYl9w
dWxsKHNrYiwgMSk7DQo+IA0KPiBBZnRlciBlYWNoIHNrYl9wdWxsIGNoZWNrIHRoZSBleHBlY3Rl
ZCBsZW5ndGggYWdhaW5zdCBza2ItPmxlbi4NCj4gDQo+ID4gKyAgICAgICBudW1fY29kZWNzID0g
c2tiLT5kYXRhWzBdOw0KPiA+ICsNCj4gPiArICAgICAgIGJ0X2Rldl9kYmcoaGRldiwgIk51bWJl
ciBvZiBzdGFuZGFyZCBjb2RlY3M6ICV1IiwgbnVtX2NvZGVjcyk7DQo+ID4gKw0KPiA+ICsgICAg
ICAgc2tiX3B1bGwoc2tiLCAxKTsNCj4gDQo+IERpdHRvLg0KPiANCj4gPiArICAgICAgIHB0ciA9
IChfX3U4ICopc2tiLT5kYXRhOw0KPiA+ICsNCj4gPiArICAgICAgIHNrYl9wdWxsKHNrYiwgbnVt
X2NvZGVjcyk7DQo+ID4gKw0KPiA+ICsgICAgICAgd2hpbGUgKG51bV9jb2RlY3MtLSkgew0KPiA+
ICsgICAgICAgICAgICAgICBjYXBzLmNvZGVjX2lkWzBdID0gKnB0cisrOw0KPiANCj4gTGV0cyBq
dXN0IHVzZSBza2JfcHVsbCB0byBhZHZhbmNlIG9uIHRoZSBjb2RlY3MgaWRzLCB0aGF0IHdheSB3
ZSBjYW4gcHJvcGVybHkNCj4gY2hlY2sgdGhlIHJlbWFpbmluZyBsZW5ndGggd2l0aCB1c2Ugb2Yg
c2tiLT5sZW4uDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBjYXBzLnRyYW5zcG9ydCA9IDB4MDA7
DQo+ID4gKyAgICAgICAgICAgICAgIGNhcHMuZGlyZWN0aW9uID0gMHgwMDsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICAgIGhjaV9zZW5kX2NtZChoZGV2LCBIQ0lfT1BfUkVBRF9MT0NBTF9DT0RF
Q19DQVBTLA0KPiBzaXplb2YoY2FwcyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmY2Fwcyk7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgLyogZW51bWVyYXRl
IHZlbmRvciBzcGVjaWZpYyBjb2RlY3MgKi8NCj4gPiArICAgICAgIG51bV9jb2RlY3MgPSBza2It
PmRhdGFbMF07DQo+ID4gKyAgICAgICBza2JfcHVsbChza2IsIDEpOw0KPiA+ICsNCj4gPiArICAg
ICAgIGJ0X2Rldl9kYmcoaGRldiwgIk51bWJlciBvZiB2ZW5kb3Igc3BlY2lmaWMgY29kZWNzOiAl
dSIsDQo+ID4gKyBudW1fY29kZWNzKTsNCj4gPiArDQo+ID4gKyAgICAgICBwdHIgPSAoX191OCAq
KXNrYi0+ZGF0YTsNCj4gPiArDQo+ID4gKyAgICAgICB3aGlsZSAobnVtX2NvZGVjcy0tKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGNhcHMuY29kZWNfaWRbMF0gPSAweEZGOw0KPiA+ICsgICAgICAg
ICAgICAgICBtZW1jcHkoJmNhcHMuY29kZWNfaWRbMV0sIHB0ciwgNCk7DQo+ID4gKyAgICAgICAg
ICAgICAgIHB0ciArPSA0Ow0KPiA+ICsgICAgICAgICAgICAgICBjYXBzLnRyYW5zcG9ydCA9IDB4
MDA7DQo+ID4gKyAgICAgICAgICAgICAgIGNhcHMuZGlyZWN0aW9uID0gMHgwMDsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgIGhjaV9zZW5kX2NtZChoZGV2LCBIQ0lfT1BfUkVBRF9MT0NBTF9D
T0RFQ19DQVBTLA0KPiBzaXplb2YoY2FwcyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmY2Fwcyk7DQo+ID4gKyAgICAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2
b2lkIGhjaV9jY19yZWFkX2Nsb2NrKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVm
Zg0KPiA+ICpza2IpICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgaGNpX3JwX3JlYWRfY2xvY2sgKnJw
ID0gKHZvaWQgKikgc2tiLT5kYXRhOyBAQCAtMzQzNyw2DQo+ID4gKzM0ODksMTAgQEAgc3RhdGlj
IHZvaWQgaGNpX2NtZF9jb21wbGV0ZV9ldnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+IHN0cnVj
dCBza19idWZmICpza2IsDQo+ID4gICAgICAgICAgICAgICAgIGhjaV9jY19yZWFkX2RhdGFfYmxv
Y2tfc2l6ZShoZGV2LCBza2IpOw0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPg0KPiA+
ICsgICAgICAgY2FzZSBIQ0lfT1BfUkVBRF9MT0NBTF9DT0RFQ1M6DQo+ID4gKyAgICAgICAgICAg
ICAgIGhjaV9jY19yZWFkX2xvY2FsX2NvZGVjcyhoZGV2LCBza2IpOw0KPiA+ICsgICAgICAgICAg
ICAgICBicmVhazsNCj4gPiArDQo+ID4gICAgICAgICBjYXNlIEhDSV9PUF9SRUFEX0ZMT1dfQ09O
VFJPTF9NT0RFOg0KPiA+ICAgICAgICAgICAgICAgICBoY2lfY2NfcmVhZF9mbG93X2NvbnRyb2xf
bW9kZShoZGV2LCBza2IpOw0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
