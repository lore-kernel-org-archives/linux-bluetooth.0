Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CB3EA71
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521149; cv=fail; b=TrajQZMJzPC7dRQw55q4qKncdk+G97ONSNf+dayxChqQGM/sEBfyAAegsLYAnL06TebCFiPpVXol2Llp6HawWOPeAbydiI9h2PJIfZUGg5H3dlFbpS41Z8US05CF58nVsM+kgv4u0+fn9Oi26qstgEqP0oMO+2ujhu9RsMD64AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521149; c=relaxed/simple;
	bh=jiw6RzqZuhf/aRBgPF5lhSstEHkpJ7jaY0NuWpy7q9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BX3vsUo6yePNViUGVwdGudwXX7Mt1RxK4VpIwrRziQTzuDfyCUP57ptXjyiXqjnass43iua+WSWKqHvFbuxvNHqzDBf60Yt9Rzidb3BEfQO0zfi6M5ZO/12w3lmbFeFPGoZwLm4jSi0i8xT6YaPzisKB/nyBmVBz3nYmyiNjI6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3KT7i30; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3KT7i30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708521147; x=1740057147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jiw6RzqZuhf/aRBgPF5lhSstEHkpJ7jaY0NuWpy7q9c=;
  b=h3KT7i30qI0E0OCCIwXXwIOvC+CR7fsEF27DsvSe132ug3acHVJkkzK9
   OP79x0uDfUucQv/PYh6bHJJiIgX0jklfm10yQPoCYGcKMzCILiSeQVRxR
   oK7301oxcxgAo12Ge0CCjpDhj7fzhQL2QjkNAGvwuMd84BAObiyScvUsU
   rdDHZ1lkVlNP3Yevb4BqifjHeMHxBiQfzixNJk8J3i3fQJA8fUmHeA7Fw
   0LpCpMYNNcW4iI6edGoNJJfG7nQj0Vtqba+9scuMJYl21IgJVItQRFaLH
   rVvyubpulbHAH9EsHUVMvArMnDsLN91cbCYCGdj0wrbIvQ4GdO2nM/TYp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2802564"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2802564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5436643"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 05:12:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 05:12:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 05:12:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 05:12:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 05:11:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaA8coaxSmwT8gSGY/UZuD6w1+iQnflrEiEK/Lo3I4JIhoIp0O9PWFlCOf+Ds128ty3PWgd2zAbIL9kN97MGb5X9Ax8rc7YtVhvNxBpD32qMhD3rMCPLG155h93HxhC0nj2QRmcmAvW6rU20SqJIU5u3ItjrXFhMiqt01bYozv0d2leJ0G0KaA++9TE0qWFDyR0VtmdSHeMgd3ClsGc4ps0/YEGXnUPu18XSLY7PecKdbB6BIFC2S0osInsZV9/KrvFOio7UCuKbxz8r3rd8mitdDFANu7vfMDyhZMhiRL3bF6WMmtULZmdem9fiFUCET3NshOa2D8eGFsGydTpXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiw6RzqZuhf/aRBgPF5lhSstEHkpJ7jaY0NuWpy7q9c=;
 b=mY79rvh/OOUMnh4sJKLt4TO6YicuGHfsGp3JctO69iF5Lz4+pthecXq37yRw96kjt5JYJKrjetr97mj/A4THgshd1NpyPHVdrjwLfHUBbl6/8VyzsnQXeotWsNQDFZ57poiE7yT1zU8Yv9+fGz7itmGnNtsM3AAZAgKOJtC/th1uST5dVPLkZqEXPCj7+gQATo5YTq9PnJ55KnH1DPS+DsAf5VBbnE5saTj4F24weccTurAmZ23qfvZxaBtgI9ISOWL8xblk/ydfLLNa37i5YbcHy1dO7p6KCBI+Dgosc3lEm9WoVe6kdw943VNIwEC6HymzcEKqbRlewyL7LqD5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 13:11:55 +0000
Received: from SJ2PR11MB7600.namprd11.prod.outlook.com
 ([fe80::9e1f:a422:1d22:194f]) by SJ2PR11MB7600.namprd11.prod.outlook.com
 ([fe80::9e1f:a422:1d22:194f%5]) with mapi id 15.20.7292.033; Wed, 21 Feb 2024
 13:11:55 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer
 information
Thread-Topic: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer
 information
Thread-Index: AQHaXpRKgM0eyY7u6k+9PV/vOo9Kp7EIb6yAgAxgBCA=
Date: Wed, 21 Feb 2024 13:11:55 +0000
Message-ID: <SJ2PR11MB7600C810C970BF625D307C42F5572@SJ2PR11MB7600.namprd11.prod.outlook.com>
References: <20240213160152.2836131-1-kiran.k@intel.com>
 <d18dd583-9267-48b6-a0c8-61b1018f921a@molgen.mpg.de>
In-Reply-To: <d18dd583-9267-48b6-a0c8-61b1018f921a@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7600:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: bba78868-8909-4683-ed10-08dc32deadb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kK2p17nEio82u5WeEoM+aGx/RDO6GCkmS9ker5uKbgL1G0QpwyDBY8UBd5QKnzRFvlNYSG8EL/ctw1P9n3XrFOzj3F3eyYDZiImOKAkkdOhLOX8qnWSvvBa0XkODK/vhLF3SCCXs2g1T6vgZMSZ/++oiGgUsMkg+Izf7nSrWTBg7W80KbFTyr5aGESDbiLPo2Tm8fl4tmDqznYVVc59SvWpUrWFhFB9eTE18BzJTIDNxOGFkKPRW8ZkoBFXBiZ62GOjwnCKtjov7XfU0Kppxjm6+MVRo5C0YmG4nh7ZGAgqGQBywq8X+1BImvSYSTYzrbnINf+dkjj+uW0jlV7x2D8kvMjvt2zGLFYnU125/gVfmFU1X1US1anrA56jbj6nwsuVXeypmRXVz3mmQFE0JSmorJhHXplHiArLRkOOvlcVRnd95UokzkMcTm27re+60UguPz2bmEnk56QqC3qe80dQQbM6j+whMCQU+x09eVGzzC2Yi9Po/HRbjmKZwwHQ3nlRW+lkpPEjiH1oi19gf34yyg4HLJa5hr53dJ/YoekaTqWONcZC5Z1W6vMFcwUSR4GLWjJUBPd/52dlbB2Fm1kkxXXhEr1G1cOKa7cQsCx4S1FRpnFz57yX6SAKlz/k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7600.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1lEWXNYNUZTd3V0TE51MWs0RFBLZEZYdnpWcFlyVEpmMDkyYUFoVnAxOFlj?=
 =?utf-8?B?YXRKd3Q1U21vWG9zNTh2M21nMWZ5V2FTeWNrR0xBQkZDd2gwWGR4VDRBN3hC?=
 =?utf-8?B?NnREUjZKcndYWTdDd0crdytleGt6cmthcFovNU8zUi9wK09EQkREVXZRL2w3?=
 =?utf-8?B?ZjF4TnR5MHJmUlJHd1A2T3pHK1ZoM3hRL2x0WnZKSm1HZkVzRkhVQmJ6Ly8y?=
 =?utf-8?B?ZEF1ZkxhUGtUaldZV3dGRkozbzAyb2FoZ0duN0FVS0lkOTRyL29ENWRMbk80?=
 =?utf-8?B?blpsZHhsN3FZeENRVVFyS0xaUndIdU1JZlZjRkNHSDlLYmpvQksrTmk0U3RV?=
 =?utf-8?B?cksxOS9OdXhRMHc1bzdxQzd6WHlOd3BwS0tBNjQ4M1YrLytsSEo0TFNPS1RW?=
 =?utf-8?B?ejZiR1dBLytmT255TTlBWC9qTVZReGVUYnM1ampzcjR2TkNHS2xpaUJocUxK?=
 =?utf-8?B?c0tjeXA4cGc2VVZ3eWFjdG1FTnVhUlF2elVGUDVQa3grclRiUXRCZStDWnVk?=
 =?utf-8?B?akMvZ2FKT0xzcUZYZEtnZEFXNFArd3djSDZWN2h4SEw1NVhsdjNFLzRQaHIy?=
 =?utf-8?B?ZWNObTErdXJiekpXUW5aU0VDY3VvWVRMUEk3UHAvQTVWeDNOMDd5RDl6MFp5?=
 =?utf-8?B?L08xakl4NGd2YzIxdlNJRStoaWJ4S1ZEU1Q3QzRpcGY4ZVlRUHF2RVlBVW1y?=
 =?utf-8?B?K05aOEttRkdvRVd2RHc4WGlCYUtQUURjd1lxZ0VRK3pkT3hUTy9zdWNreW5O?=
 =?utf-8?B?YlIwVmJxRFVCT3ZGTnhkWVNDalVjM3RLQmdLVnpoWkxIZmxiTTNNallXNndH?=
 =?utf-8?B?UWE0cHdtQlZEWXpyL3hkU1lkeEtmK2RRaXhWUDVYMmdTem9pb2NmTnhrQ1g0?=
 =?utf-8?B?QUxpS284TnJXQkQydzNyWTMrNHlaSXh2UWxDcFZCcWUzSHJyM3M1MHdReHg3?=
 =?utf-8?B?SklLaWFpTTExaXJ4bVdHSjNGdzNvdXNrZnFlUW5MSGlFbERqM2kwS3pJbHRo?=
 =?utf-8?B?UnloYmVSUXZRUDRjKzdoT0Nvdm45WU84aVRjdlVraldzRVB3c1Q4dVpKZVVY?=
 =?utf-8?B?N25IdTUxT216ZVBWTGJsUFVvMnBiSGVVODJqSnRiNlJvQ0VNN3k0aGxKTUdR?=
 =?utf-8?B?U2tKTFdBYTFxbldlSVJzOWE4SDlFbTYrcks5WldDbmhxTWNkU0p3M3ZJaURD?=
 =?utf-8?B?VlAvZVNQM2xDbUJWKzdJQ0ErcGhtdUViamxsWXdzQlcwNGUxSWk4T1hldklV?=
 =?utf-8?B?TzBIdFowZGZDM2VXL3Z1U0plNGFpejErMFIwYW4ybk1RTXV4VnI1dkxxZzhV?=
 =?utf-8?B?eHBNMW5tN3ZTVkp0V1JVTi9pZ2hXc2g5M2p1WWN1Zmc5TjZTc0NHWVRYUXBD?=
 =?utf-8?B?N2FjTUlkMTV3WVRwRXVxb2pDaVRzb0FBSGRoUXlZUE9nK1BuaWI0Z3Vtekps?=
 =?utf-8?B?bUh0aWh6enkyNHFUV3JmMlVmTE40andFVnRRZUJvSGV2cktwMk9tM2t2TTV2?=
 =?utf-8?B?akNKWGN5RFJMQThNcTBYbHI2Q1FLT0JtVHR4WmNNaUlNVGxsV0ZuS0s2QVMv?=
 =?utf-8?B?V2NDbzF2OUxSN01aRmlUbEs4WE1LV3IzZnZuZ1VIbWZTMlVBUGdTYms0RnFp?=
 =?utf-8?B?UVVuajBTTmExVnVDTm5jRUdoR0dIRWY1anlTTElwRk8zMFVKeTJrRVJibVV5?=
 =?utf-8?B?M0x1bGxGd0xxYkg4L2pBQThWRmx1a0k3YVJCYXFlWHh1cENQSG13UTV2UnNM?=
 =?utf-8?B?eW0vU1dNR3BKcXNqUm5oUnpjTUhHK3pyY3VweDRKeGUzTWp5eTliSHBtUUs5?=
 =?utf-8?B?dERKNkhta1hQbDN4SG52bVZ3cjN5c1QvT1luSXh1eExZM3p0WFUyZU9reUVT?=
 =?utf-8?B?WUVLeFY1R0taS1NnR3Nzdk44N2piTWNacVc1WmNvRW40WkxsSURKdmNzWFln?=
 =?utf-8?B?cTFIVVRJR0dCUndHdVg1Mno1SituL3lWR1owWTBrWGRMTVBVeFdVbllTZnFV?=
 =?utf-8?B?Y2dnT1FPYlRHY1Q0cHhCZkd6WTRlb0xUcUJpTzFkNDEySzIwclFNWVFUY1d1?=
 =?utf-8?B?c0VIU1ErOHlra2dGaVJqU0JzbkFzbUlHdWppd0RTbnR4RGR5d2dTenBHYStN?=
 =?utf-8?Q?MYZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7600.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba78868-8909-4683-ed10-08dc32deadb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 13:11:55.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fJcRlJa/EKvgJvaeQpuXNqty/hQyu4XnJgHYozs3Y9sJhOvOOTVGoIZ46eJVkExl6Us+rQwF/PK9nXKi1CDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDEzLCAyMDI0IDk6MzUgUE0NCj4gVG86IEssIEtp
cmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj4gQ2M6IFNyaXZhdHNhLCBSYXZpc2hhbmthciA8cmF2
aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sDQo+IENoZXRoYW4g
PGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgbGludXgtDQo+IGJsdWV0b290aEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gQmx1ZXRvb3RoOiBidGlu
dGVsOiBQcmludCBGaXJtd2FyZSBTZXF1ZW5jZXINCj4gaW5mb3JtYXRpb24NCj4gDQo+IERlYXIg
S2lyYW4sDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPiANCj4gQW0gMTMu
MDIuMjQgdW0gMTc6MDEgc2NocmllYiBLaXJhbiBLOg0KPiA+IEZpcm13YXJlIHNlcXVlbmNlcihG
U0VRKSBpcyBhIGNvbW1vbiBjb2RlIHNoYXJlZCBhY3Jvc3MgQmx1ZXRvb3RoDQo+IA0KPiBQbGVh
c2UgYWRkIGEgc3BhY2UgYmVmb3JlICguDQpBY2sNCg0KPiA+IGFuZCBXaWZpLiBQcmludGluZyBG
U0VRIHdpbGwgaGVscCB0byBkZWJ1ZyBpZiB0aGVyZSBpcyBhbnkgbWlzbWF0Y2gNCj4gPiBiZXR3
ZWVuIEJsdWV0b290aCBhbmQgV2lmaSBGU0VRLg0KPiANCj4gUGxlYXNlIGdpdmUgYW4gZXhhbXBs
ZSBvdXRwdXQsIGFuZCBkb2N1bWVudCB0aGUgc3lzdGVtLCB5b3UgdGVzdGVkIHRoaXMgb24uDQoN
ClRoaXMgcGF0Y2ggd2FzIHRlc3RlZCB3aXRoIFR5cGhvb24gUGVhazIgY29udHJvbGxlci4NCg0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyB8IDEwNg0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMDYgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IGluZGV4IGU1YjA0M2Q5NjIw
Ny4uMGQwNjdlZTM5NDA4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IEBAIC0yNjcw
LDYgKzI2NzAsMTExIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfc2V0X21zZnRfb3Bjb2RlKHN0cnVj
dA0KPiBoY2lfZGV2ICpoZGV2LCB1OCBod192YXJpYW50KQ0KPiA+ICAgCX0NCj4gPiAgIH0NCj4g
Pg0KPiA+ICtzdGF0aWMgdm9pZCBidGludGVsX3ByaW50X2ZzZXFfaW5mbyhzdHJ1Y3QgaGNpX2Rl
diAqaGRldikgew0KPiA+ICsJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4gPiArCXU4ICpwOw0KPiA+
ICsJY29uc3QgY2hhciAqc3RyOw0KPiA+ICsNCj4gPiArCXNrYiA9IF9faGNpX2NtZF9zeW5jKGhk
ZXYsIDB4ZmNiMywgMCwgTlVMTCwgSENJX0NNRF9USU1FT1VUKTsNCj4gPiArCWlmIChJU19FUlIo
c2tiKSkgew0KPiA+ICsJCWJ0X2Rldl9kYmcoaGRldiwgIlJlYWRpbmcgZnNlcSBzdGF0dXMgY29t
bWFuZCBmYWlsZWQNCj4gKCVsZCkiLA0KPiA+ICsJCQkgICBQVFJfRVJSKHNrYikpOw0KPiA+ICsJ
CXJldHVybjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoc2tiLT5sZW4gPCAoc2l6ZW9mKHUz
MikgKiAxNiArIDIpKSB7DQo+ID4gKwkJYnRfZGV2X2RiZyhoZGV2LCAiTWFsZm9ybWVkIHBhY2tl
dCIpOw0KPiANCj4gUGxlYXNlIHByaW50IG91dCB0aGUgbGVuZ3RoIHZhbHVlcy4NCg0KU3VyZS4N
Cg0KPiANCj4gPiArCQlrZnJlZV9za2Ioc2tiKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJaWYgKHNrYi0+ZGF0YVswXSkgew0KPiA+ICsJCWJ0X2Rldl9kYmcoaGRldiwg
IkZhaWxlZCB0byBnZXQgZnNlcSBzdGF0dXMgKDB4JTIuMngpIiwNCj4gPiArCQkJICAgc2tiLT5k
YXRhWzBdKTsNCj4gPiArCQlrZnJlZV9za2Ioc2tiKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJcCA9IHNrYi0+ZGF0YTsNCj4gPiArCS8qIHNraXAgc3RhdHVzICovDQo+
ID4gKwlwID0gcCArIDE7DQo+ID4gKw0KPiA+ICsJc3dpdGNoICgqcCkgew0KPiA+ICsJY2FzZSAw
Og0KPiA+ICsJCXN0ciA9ICJTdWNjZXNzIjsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgMToN
Cj4gPiArCQlzdHIgPSAiRmF0YWwgZXJyb3IiOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAy
Og0KPiA+ICsJCXN0ciA9ICJTZW0gYWNxIGVycm9yIjsNCj4gDQo+IE1heWJlIGVsYWJvcmF0ZSBo
ZXJlPw0KDQpGU0VRIGNvZGUgZXhlY3V0aW9uIGlzIG11dHVhbGx5IGV4Y2x1c2l2ZSBiZXR3ZWVu
IFdpZmkgYW5kIEJsdWV0b290aC4gSWYgQmx1ZXRvb3RoIG5vdCBhYmxlIHRvIGFjcXVpcmUgc2Vt
YXBob3JlLCB0aGVuIGVycm9yIGNvZGUgMiB3aWxsIGJlIHJlcG9ydGVkLg0KPiANCj4gPiArCQli
cmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJc3RyID0gIlVua25vd24gZXJyb3IiOw0KPiA+
ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWJ0X2Rldl9pbmZvKGhkZXYsICJGc2Vx
IHN0YXR1czogJXMgKDB4JTIuMngpIiwgc3RyLCAqcCk7DQo+ID4gKwlpZiAoKnApDQo+ID4gKwkJ
cmV0dXJuOw0KPiANCj4gU2hvdWxkIG5vbi1zdWNjZXNzIGxldmVscyBoYXZlIGEgZGlmZmVyZW50
IGxvZyBsZXZlbD8NCg0KSSB3aWxsIGFkZCBidF9kZXZfZXJyIGZvciBub24tc3VjY2VzcyBjYXNl
Lg0KDQo+IA0KPiA+ICsJcCA9IHAgKyAxOw0KPiA+ICsJYnRfZGV2X2RiZyhoZGV2LCAiUmVhc29u
OiAweCU4Ljh4IiwgZ2V0X3VuYWxpZ25lZF9sZTMyKHApKTsNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
