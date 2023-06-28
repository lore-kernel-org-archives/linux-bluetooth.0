Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA542EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjF1L4p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:56:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:15096 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbjF1L4i (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687953398; x=1719489398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bOqJq/JBdZmaeXpuqAL1geIZ9ReT7GA6JyrCuik2M40=;
  b=AJ8OXtT+pgDhA7s25s2od9s7KU/PUVXEtQtys8tmhQB82vEeALklpeme
   XuF48kGxMpzdrQLE8jYiFZbCJ1XQb+WCLkmX7b7pzF9ae4PYMaysUTuRE
   RxHba9drT1TC1Lxa0J3nz6cuOAe5zA0I1gVSxtCL0Hh3O76w6NnE1ldq8
   Vpt3S2epNVWTZB+riFSvv9mGJ4y6t0R+1JTAmmylLMDg0nSlGFv183oxl
   5OoEcK5YMjgLIbE37UxXvSrxs+MH65E/PJom3BihsXLphJ/6GGF+OzqCM
   liRU9MqmL+KXw7t/G/JeKWCehBUtnl5LKt3KxJ7tjeJe7AzGAJ5XIQVmM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342160105"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342160105"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 04:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806864161"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="806864161"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 04:56:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 04:56:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 04:56:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 04:56:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 04:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVTp5BDCT2tD5ZWnZinp1eoWhu3tFY3OTT9S6YsdHfIMcbG37+L7JY4xi9GRKytKXWuLo/D7uu64+//2+TLKqusyXfCBai9ZcIETv2T8vQ7J5eydIFvplz3/mjG1bOT4Ybd9GkHsrouiokY1sU/TXrGFMIpYSfHoUGu1rcg1Op2Og7xj7Lh79bRP9QQ4dZC4sj28viHAx6RZ2gfy6T+m+wfJdWsG6AJnhmyX5YtWAlSWJUVkpgp0UhoRE8tAn7T1n8vruX/KW5tBfttN/lNicJDd+PAcf3yhh/9Eg0ofxHJGNK5kO7rU8wCegAcraRZMsurE0suNC++7no5jCjqOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOqJq/JBdZmaeXpuqAL1geIZ9ReT7GA6JyrCuik2M40=;
 b=mJOY+wJ5EFNlwJbloi2rmuAB/MBg9D/Jv2SnVE4cqXH5y3ZNc7uiq1gEGxdzE8NLAPGanqkKibQR1dx97yL5Xdr8AiPVP2+3NizY3NhhxcbBAUVuVcHPVOx8B79xOom9RVC42bfRTEfvZMpqCfhn9reBy8sr5ghXe/NBovQYOZHdp6PRA1xc3mhqAcfB63kMf8mVU57/ANMJszZFrc6p6eXGFVieVCE2GYzcPouudLR4o4uQQYPorKZjG8nBMxRrJkob7lFtCXazvBRvD7mcuvM6DQQM3lxJ8HAANKX9KmJzeBq0GOxhG6VQK7GFzu/7Zlg8d01kudhh13JhJO53Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:35 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::7e99:8d7b:b53d:834a]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::7e99:8d7b:b53d:834a%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 11:56:35 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Add support for GalePeak
Thread-Topic: [PATCH v1] Bluetooth: btintel: Add support for GalePeak
Thread-Index: AQHZqbOonAtucazxkEuo3Rk996m9ga+gFZUAgAAEsBA=
Date:   Wed, 28 Jun 2023 11:56:35 +0000
Message-ID: <PH0PR11MB758555E584EC6C8691133565F524A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20230628113934.824668-1-kiran.k@intel.com>
 <2a43ecd8-faf5-11f7-1a01-c114aa16354b@molgen.mpg.de>
In-Reply-To: <2a43ecd8-faf5-11f7-1a01-c114aa16354b@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|LV2PR11MB6023:EE_
x-ms-office365-filtering-correlation-id: a23a54c8-eade-4d65-cc44-08db77ceb8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRvvTlhN4oczW6hCz64hmpQifb5k93xnJQQzuFGu/JBVl7f4ME2cIFp6iyo110mKfCXTPSetbBW6c0YhG/GPvboP+KUirsqtEBLMsBE+zCDo4pvykaKo4N6CkZIa39Ex2EYoayLRPG95elHyuWUgGmZJYyhUxzb9tuOKeU3E/OVthjqC9HwEuGmDLwxpTSalioLan5VixQBcTvMAn9bIBxbLjJF3e+BQKv0SpwcylnTdHma9Emx8SJiGpIJq0CpP1EzjMYF2hkjHVNZkbPKUNosYBwgAjq82VvRuB0vGstkF4nX0kibt3wKtmwfkR7o+GP1ysAEEdjSODYmCCQjs088fa8wViAuJHFCBiphPceUj63v6l9hp0wDo5Wz3/sMi+DDak38f9OHM4VzANGPXqEvj7zGTgO3FUMX3zA7ac6x1qbPFQoy0M2YvO3P33SpTYcL/ncJFzjmwW5kYWcliTuD5mrCWtZL+/mE3j3H+8Q+V1pBQUfBd+qSqWT28ENsMq+L6OSPelL/6Qv/fe0gmg9xQhYiOljzT25rV+c7Gq+e+GV/Qh5v4d9AgHRlSAvEBfcmC+XRx9PBu6l2LKPzSCyqgkrrRPm2iW3ESxfE49TBtkuoA460al6YfCZfYQhIw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(52536014)(5660300002)(66946007)(76116006)(33656002)(66556008)(64756008)(66446008)(4326008)(66476007)(6916009)(478600001)(316002)(8936002)(8676002)(2906002)(55016003)(54906003)(38070700005)(41300700001)(71200400001)(186003)(7696005)(86362001)(26005)(6506007)(9686003)(122000001)(107886003)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlBYMkJxWWNtNnYwb0s4V09icjBva1dQaW9NeTk5TnB2TGNlUFpvSGFOampB?=
 =?utf-8?B?RlZZeUtGcDZJdXZSYlRlMTVlWUxyOTdUZ2JSVmRzSE9uQ0hBMy9yQ3VLYk5K?=
 =?utf-8?B?YzZtNnUwR0VmQUV2aURjbysvQ2laSTR2OFdzTnVidU5XcXFJQ3VFMWY5ckdn?=
 =?utf-8?B?bGpTMWJ2R3FvZGdEaHBjdDBWOVVqYnRtOWw4TVN4RW9raUJVMEgveXFZdjNu?=
 =?utf-8?B?WklaTDR5cmxjazJLL1lPWkk3eXkrTEZOa1BRdVozZ0drZWdYMU1VUG8xRzVh?=
 =?utf-8?B?emNCRUdEcnNLeHdxZ2ZXMER1d1hTd1lKakYzSThXQjRmVkhDQmhwVHl3Zzl0?=
 =?utf-8?B?QmcvZEZZTHQ2NHVqSkl6Tk9kTklTNStKaEwzN3hndmNCeE1HQlRIOEVJOStI?=
 =?utf-8?B?azVnUGtpb21BT2p2SkZJREZRSGVmeitsSHk0bU5uRzJaRGd4RlAwNUkybU9O?=
 =?utf-8?B?aEEwTGFGd3Y2WlJpWTVDdDEwY3krOTQ1eTJseko4WUZSKy9BUDBkZ1RwUkIx?=
 =?utf-8?B?VWpoTzFmczhPdThWZ1lMTnVJeDkxNGxHUlcvMWx1Y1JEK1U0eUZLd3ptTDN4?=
 =?utf-8?B?UVhpSEcxeVVDWndXSVRNZVQ2Qit1K0o4M01nc2VFdGF1Kyt3VVI3QURpR2V1?=
 =?utf-8?B?bHFFQmxnN2JUZkJSZk83NlRVMGZtczFsMXFvMFZJbTlQdU9vYkV2T0FubGN0?=
 =?utf-8?B?ZWZjMHJQd2xORzRWdFJkVG9qRTNiOFpiNUp5bEV5OHVCT2FxOWM1SzFCbWtB?=
 =?utf-8?B?K21vZXNVdWUxS2NkbzdNYXdqbDFmWTRnUmI3NUNRRDVjQnU5NjgwVUpaeXl4?=
 =?utf-8?B?ZVJYYzJaZm55WFJTTUVibXI5MWFObC80bjBpbG1FQ1JBajFkVGl4bEdlMks3?=
 =?utf-8?B?bHoxTWlyQUkzcGs3dGdQWHQ1d2VkUzMxU2s3UXRNcXBTYlFwTDArZWtYMDR5?=
 =?utf-8?B?QlEwTmdHSmFTUHBMYjV1V2ViLzdjY25TZmd5cVdZYkRnRGxobitpWm9hQnFQ?=
 =?utf-8?B?WjJBR1prWGNVS2tYbmpCUlNYVTNUcHk3VWpmWnB1SFdaMFNtY1VLTFNzQlI2?=
 =?utf-8?B?bE1LeW5Fc1FLWnJ6bUd5am1mc2p5UDB4NEZ3Q2htZGNsb1V1aVljK2VFN0dP?=
 =?utf-8?B?L3U4dnFhdWo3WXNhNFVBZklYWWpKV3NHRjBVTXZaM01xemdEQ3ZBR1psQ1RK?=
 =?utf-8?B?T09EMWxXdGRvSGdsaHFuaUpoT1BNMElDaHNhVWNpTFNmQVlSaHU1d3JtTkwy?=
 =?utf-8?B?UFF1S24zN0J5YlQwNENLQTRoVVdKeTR5dk5uQUFHWDZiS3F5eHJaRE5YV2FX?=
 =?utf-8?B?MkYvZktRQVNMZGVQL1BveXp3ZG0rdC9XTFR4OEdaRnNOcEFwU3poYlZNUU4z?=
 =?utf-8?B?T1RQczJEL1YxWGpLQ3FKZmhLYzhpcUlXaEYxQU1COGpRL2p0SWtLa2tCM2p4?=
 =?utf-8?B?VUEwdzBSRDNZWk9ESEkyMytVKzd6N1oydTVSTE11eGJlTWlzZ2I3a1ZZdi9Y?=
 =?utf-8?B?T3IxTEhoa2NBelpVTWk2eTZxVm1QV1FFOFd1MkZBSUZXcmVjd2ZhNmh6bDZQ?=
 =?utf-8?B?K3ZCMEZHSjVpUmlOUDArbEgwRWp0RlVCc2xNVjlNdDg3cm1OcnFKQXpid0Vi?=
 =?utf-8?B?V1JOdWxUMUJNdDI5OWZYWDFxTXVLUGNLbVZGK3MwbEs5Q29mWlBTMmlhUGlr?=
 =?utf-8?B?aUppUDlqcEhROUZNZ0ZCUWtGRitZZE0xNnZNL3kxRXNPK2NaUVViWllsYzZ0?=
 =?utf-8?B?QXV4WFpPSEFqaHJacGRBS2sxaUIxSnV4ZGloNzJLWGtvK3ppbGtsL2NpcHNw?=
 =?utf-8?B?OUxUSGRXZ1lEZXVyZVZyYzZiYXgwQnVSNVF2Tm53c3J2ZkJiQ0JBZzRGVk9O?=
 =?utf-8?B?U2hqTkx3a3Bhc1BsYWN1ZE1wMDBsOUdNbmVYcUwxdC9YckRTQURsNm9mR0d6?=
 =?utf-8?B?NlRKNVRRM1lweTlRL2M1L1ZJQXhJTEl3WkExMHU2M05hSkNteDF6VUd3S1Rq?=
 =?utf-8?B?WENaVmZqYU4wRWZtbzhZTDRqQ29rRDlxV2cwdmx1Y3VPdmN6cWhIZEp0NUI1?=
 =?utf-8?B?NkJHaVdic29Yd1M1ejVqNHhiTXhZQllpcDdDTExDYW94L3U4Q3gzL1hGMkRC?=
 =?utf-8?Q?fguU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23a54c8-eade-4d65-cc44-08db77ceb8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 11:56:35.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGr3YXdZQX/yG7AR31jpGqj4LuyBg8bM7aD7OOEy+sZFPEJP5dhqoq5rSB+VLQgWUHwOZnFXwvOx15RfLVtTyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj4gDQo+IERlYXIgS2lyYW4s
DQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPiANCj4gQW0gMjguMDYuMjMg
dW0gMTM6Mzkgc2NocmllYiBLaXJhbiBLOg0KPiA+IEhhcmR3YXJlIHZhcmlhbnQgZm9yIEdhbGVQ
ZWFrIGNvcmUgKENOVmkpIGlzIGFkZGVkLg0KPiANCj4gVGhlIGNvZGUgbmFtZXMgYXJlIG9mZmlj
aWFsbHkgc3BlbGxlZCB3aXRoIGEgc3BhY2UsIEkgYmVsaWV2ZTogR2FsZSBQZWFrLg0KPiANCj4g
TWF5YmUgYWxzbyBtZW50aW9uIDB4MWMuDQoNCkkgd2lsbCBmaXggaXQgaW4gVjIgdmVyc2lvbiBv
ZiBwYXRjaC4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgfCAzICsrKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuYw0KPiA+IGluZGV4IGRkMWU0ODgwOGVlMi4uZjRkMDk2NjM5MDgwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWwuYw0KPiA+IEBAIC00ODAsNiArNDgwLDcgQEAgc3RhdGljIGludCBidGludGVs
X3ZlcnNpb25faW5mb190bHYoc3RydWN0IGhjaV9kZXYNCj4gKmhkZXYsDQo+ID4gICAJY2FzZSAw
eDE4OgkvKiBTbHIgKi8NCj4gPiAgIAljYXNlIDB4MTk6CS8qIFNsci1GICovDQo+ID4gICAJY2Fz
ZSAweDFiOiAgICAgIC8qIE1nciAqLw0KPiA+ICsJY2FzZSAweDFjOgkvKiBHYVAgKi8NCj4gDQo+
IFdoeSBub3QgYWRkIHRoZSBmdWxsIG5hbWUgaW4gdGhlIGNvbW1lbnQ/IE1heWJlOiBHYWxlIFBl
YWsgKEdhUCkuDQpBY2suDQoNCj4gPiAgIAljYXNlIDB4MWI6DQo+ID4gKwljYXNlIDB4MWM6DQo+
ID4gICAJCS8qIERpc3BsYXkgdmVyc2lvbiBpbmZvcm1hdGlvbiBvZiBUTFYgdHlwZSAqLw0KPiA+
ICAgCQlidGludGVsX3ZlcnNpb25faW5mb190bHYoaGRldiwgJnZlcl90bHYpOw0KPiA+DQo+IA0K
PiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KDQpSZWdhcmRzLA0KS2lyYW4NCg==
