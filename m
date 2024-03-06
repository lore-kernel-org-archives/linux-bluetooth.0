Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F005CDFF
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Mar 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713208; cv=fail; b=bnX5/DXA4ywQLkKurYqGPBJ6wN35StZBhjJGtVLamhfoN5m1G1Ec3qPKaUMFYOm7cdgdRb/ywV0cPU77n2vtZYBLK7/MLXgpNsBdpUDEZ/WMVf8jZv7TcoS3SYsk7xDPz5mjjKTXv/ZCX0sgTsfL+iBVWwmGseU4IRMvT6EeenM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713208; c=relaxed/simple;
	bh=lC5eqck5FWtSg4FaE+arxnkOWMX85uEAU4hSvK0ocOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s9fo6PYlDsyy1Gf1r0lSnI2DKolFAuH3ejmSDe2S/5WafQFPl+it1PSQ2lmJWz81EcdukygAmvMqHGt8+Avm9ftMWSZeifvP+yPVqx8/kre4eEcULiEU9MbD9gD8wdUQ5l6xKqVmsHSgrMf0HzPUPDySptgt1ZzjIUiqpnCNlyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKVDTAkP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKVDTAkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709713206; x=1741249206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lC5eqck5FWtSg4FaE+arxnkOWMX85uEAU4hSvK0ocOw=;
  b=ZKVDTAkPFHva49xHOXCyB/gmnn1v0jl8bP6DWcLSkpcufYvQW8kWK91m
   kEa1KkxOHbO05eVdC8U4XxDxXx+YngtcZUazLHaAAKa5xos7hesPyV90+
   g7DdEb+5Qer+3dR0pAp5ZZx1NxOlAq5amO1T9N8F9Z6KHgHzvwmLAaaq7
   qgOmZbY5uQwA48i+PHsyWizBqK/vDR1AfFHRnFpkCuevppGZsssBNfT7T
   5M7JNDollR5PrtCch0DmNHHVL/NcLAM8JMTb63IhKuzOtz4gnZxOWPmKT
   upWLLL3p30zfETAYAweR8vpCD682qLYwQxhIaN6gnFgCEIWIVPH87MPGw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21765098"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21765098"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="10094246"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 00:20:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 00:20:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 00:20:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 00:20:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 00:20:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imz4sLVttkuOTiWS1wbiW5Ca3I2230QlgwFYwYM2flg0JPsVmeqLRm4f4DJuh9TFh3FAJVuYrV3/iugdSXaedcxRuymz8/PXxvEHhxQKw5UHeJYQXxrH10VhVrLoQ7Ld23N5I4dVqQ/6JUtIGcXDCUd32QkVce0FLnmjZmdoPvm0lZyNbHkBPjDNlSaW7Fn8FhN2/KAKPDkVIdYlcpfZ9hABbk/upgIdCW9A9sS0ZqL0ERGP6V2gcK8cO4I6bkyuMVoEyFMbyYe+SbiunTdsn7O0wAAMpk7BBr2+fNjZLswOHTis4nkADoPH57Tinpoi76iIH5XSmTIJxEVpOoyhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC5eqck5FWtSg4FaE+arxnkOWMX85uEAU4hSvK0ocOw=;
 b=AEAlbSUH34Vtp5SPuIcSYHoAVXtX4qtJOE5SwpVKIUNOV4b0JhO4nlspAbirONYo3TXP/rge7l7jWCTowCb7bUgC9+b5EudxXu2c7D/MbXaWy3VzBC3JOhPJltlXVDXB5kH7shqwtcm3H8ijIrmkv6Eqnjg6hChdjgrNGPwKLffdFEh3hQdBL+gkiUpDDf8aby9k/hd4epdR71NoOoZMgI6vI/hjd7D+8VkuPciyc1fyylDUKkunYMpF8xbqQR5CV/BfPQd3aJMCPSEHSIBCwaC2Bl++0NVUnqEDwA5pUXmaqerDkx3wT2CXzIXGp7paK16WecloxoaovZ0AYaS2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 08:20:00 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::b517:edd4:27fa:580e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::b517:edd4:27fa:580e%7]) with mapi id 15.20.7339.019; Wed, 6 Mar 2024
 08:20:00 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v3 1/2] Bluetooth: btintel: Define macros for image types
Thread-Topic: [PATCH v3 1/2] Bluetooth: btintel: Define macros for image types
Thread-Index: AQHabwnQlBiQ2khcpEaJJ1OQPEJsdbEpvsAAgAChAVA=
Date: Wed, 6 Mar 2024 08:20:00 +0000
Message-ID: <PH0PR11MB7585134BF957094A8BD6B103F5212@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240305144459.119564-1-kiran.k@intel.com>
 <CABBYNZJXzX5ppWz5Jt1XGXHZX-y9u09LfnO8F-ZF-3Z9xkZVPg@mail.gmail.com>
In-Reply-To: <CABBYNZJXzX5ppWz5Jt1XGXHZX-y9u09LfnO8F-ZF-3Z9xkZVPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CY8PR11MB7058:EE_
x-ms-office365-filtering-correlation-id: 99229c87-1993-41ff-78e9-08dc3db6374b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gKDxg8DvNgA8RN7TGYGXKXPRH4hfqSw4jKdRvtmJV/xWWGWpQjxy78GcPivmd5WejsLRHvVbPvUIja7VIaNTTwCurEc2CEcp9r5fhmAM+yrY1Y623NILPqiLFF4EOUg9Aj3XOH6sZxsNveMlmbAMFZqB0UCCDmQtNgtbXyyIUDpZoO+0rweOdqimLQifjsc0/XCIuuaWYQSlhrh6/19Gii8bctglEjxzR/OThWLlLwTxmbBZi4GRAtFOW3L5oWpiQtytpoQ1L42Y8ioKcHFU6nVU1aZWqP2H9NwyHuiDx8kLYZNEQcGdFuVof/KCiAcgB1PXmWi2061K8t/tHXUxPmRPMPGodL9dqcCKky9RwdSybuQLnhVwr796X38+CZFbyPn+X9J9SxYyLR9Y6AtIIhh2E/1UfZXyE4l+NupMKm6wXMKCbJDwgZMk2XgdjUhSE9FavjdZZqotDbmb2fTUc5tL9GCQ+td6dlyxuhTDjbfnRTEMrOLVp2N+oPzZml5UTz0+k612eC40A/Bt4PDEDtcl51nQEOOXHQ1KNAgx5BjZbOrjXO81NC2U4RVPZl3XiX4mO6EdBp3pHJ+fSUDABO8/02Y1xhs0QAmZ5aq3fUXK2YbrdPia61bCxbVwm8ajKVCqTgAB2n/rrCyB4Yr3Gfh1TcA9EEhhZjSatYoceFgRer6NjOC4LapiBlktUEmv/8geb0SDEIjgVDP94xrMTQAUKr7MksXj3OnKQsLgDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1czV3dyZWRuWDJwcFl0dFlmT2F6WVVLbUEzQTdLRlU1WXZpZlMvaGdSc0ZE?=
 =?utf-8?B?OTVoSTVKdFpMSEljc3paRFllcWwxMzdMQ3haMEhud0NpdGMwbmtlRTlzakYr?=
 =?utf-8?B?TTN5TGpQdlRjcmpTZkZGdWRQbEljQXZCY0NZSitKaEs3ZGUvUlNzVDNUWEsv?=
 =?utf-8?B?UlRNb05maUpab1QzZStTZWQ3ZDhnY2dQdE5IZGZxcVBybVJ3QkgwR0Z3UEM5?=
 =?utf-8?B?dWloeVVVVDVtcjMzZVRMTGJPM0tRdzJEL0xPUlU0MlNBam12bFVlbnBWUUd1?=
 =?utf-8?B?YnJqOEt5QXBGK2IxeHNOOGF0Z2hPZlg2eWJsWDd2UUtWUnRRcjBRbDN2WVYv?=
 =?utf-8?B?T2tGMElnLzFEdlhBcFlWS0RtMVRLelIvRGxXNjJOMWhOVjNzclR5QytUSkFZ?=
 =?utf-8?B?eUVnVFNxd29VVUxBNUVKVms0YnFJNU8wSDdhaTNkVmh6UzRGZnc3SUlsUGwv?=
 =?utf-8?B?WHdKWDFoVWxZU1pyS1RzWTIrZGFDd1FDMHg2OGZONWlrMVU3UU1xRzJGS3JL?=
 =?utf-8?B?dUtRdlpEc0t3bE9TK1ZQT3lRY3lpMUU2OGV6cWdPSUlsTzlCczg4YzBFWklP?=
 =?utf-8?B?ZXIwQWxjeEhjbHNUOXRzcExBS0Jkem1zbFRLRjBHQlJTdWJmSEFDd1lLNTBD?=
 =?utf-8?B?eHYyMWR3VmFTd3JJTU9zbWpjT0Y4Zm9IUTlxUHhVN2VJTnk4OVBLOTN4V001?=
 =?utf-8?B?d2p3TUFYUFVxZHR3aDk2c2ljYVpUZTc3MHRZR09QQ1pabk5ma0R6R0pTczY4?=
 =?utf-8?B?U29ZblJpTmFQcjUvakMxRGRuUTRMLzNML3h4bHA2UjFqU041VWF0dExTSnZP?=
 =?utf-8?B?bVY3ZERLV0k4MC91UEZaeS9GVlpucCt5NVVNaVJOOWZDczA4UlhBOEZad1lx?=
 =?utf-8?B?akpUWXZobkdjaXdQZEFabGtPTGxkUEk1dUFKZDBUSmVwTXpEU2ZhU1hyQXpI?=
 =?utf-8?B?cmR6VWlaZEJrNkI0TzFZTjlYczNvUHRRZERQWWQzbXJNUE9jUDVCbkhRYVAy?=
 =?utf-8?B?aFY5Y1AxSjh0ZXFZc1BoVDhsR2FBbmNwaWFXMHVLUWVEdW11R3drYjBWSVFx?=
 =?utf-8?B?QUNNSEVISTFuZDlEMy82cUFhVkJVY0VtelBxbGFWOVJURU9NekNjK2YzNFlv?=
 =?utf-8?B?eHpkb0NLUzhjMVRYdXhBTnh4QStPS29Oclh3S0pWSDRmTmFSUnFIWW9yQ1lh?=
 =?utf-8?B?RVF6c0J1TWszL1dBMmhnaSs2TGcwQUovdXVRendla29JZXJzbWNwNFpLaU5I?=
 =?utf-8?B?WEd6dnZKTi96d2g2WWQwTWFRb2RrT1NOanVSRlpEY3FkNlEzWFJSazYzUm56?=
 =?utf-8?B?ODM0TTBvdDBDbXBPSWJSaHFzZDNReUFjT0JQcDlOcFNlaUNzYW5SRDJCZXln?=
 =?utf-8?B?Vk1ITlI4bzJtVW1zVWhwYnFaOTFaTmZNRDRnKzY1VzBVeXRiazQvUzIwUlVS?=
 =?utf-8?B?QkF5UWR4Zk12UE9rQitUODhNV0lRY3R1d21tVVQ0TjdzcWRQNERVWnRLbGxP?=
 =?utf-8?B?bjVXUGdVaUs1bSt0RUNpMG9mTVVtSlhTYjIxTVVkWkZjNDNsTjlobzkxMUZi?=
 =?utf-8?B?WkxaMlRVWDFFYWNOUG1NRHdkS2I4UW8xU2w5N0lIQ3FXQno5dC9Lb01vdjJD?=
 =?utf-8?B?OHlobDVOL3RxVkZrQjM3U0Q3SUd6UGlGaVFHbjUxWVI3bXVTMEdUc0V5SEFE?=
 =?utf-8?B?NmI3blBoR3pZTTRVRkJCTXp4aFNwQWpaSFdXYnpUQWtyRk9EMmlhRVR3OU8v?=
 =?utf-8?B?dUVRZHEvMXM4WVRHbjJwN3gxdjRSZHArSDUwZUVySHR3YU9kRmc5N01nVS8v?=
 =?utf-8?B?TVBUSEJieEhvTytsZmRnWHkrVXYxSEx6ZnNIYnBqN3JRVm5TMGdJNityVnJw?=
 =?utf-8?B?QThITWcrQXljNTVBcHdEN2RBaEJJTld0VlhUeFU2QTB6MW5rczdUSkp0Wm9u?=
 =?utf-8?B?VGEvRlhWbHdUZDkwZkxEQzFYcjQ0NDF1dTJCMUZOSURCVThHUnd4MmhGMzVG?=
 =?utf-8?B?ZTd5b3dVaDE4U3BQL2hQY3FoQ2g4YWlHNWZDZUl0Y3ZSc0tJbzB0ZlBaUnlw?=
 =?utf-8?B?RFpXZkVIRTBPcGtKc0RhRjdZV1BVZmEySWx3cEsydGc4c28xbmxDUUY1aHlG?=
 =?utf-8?Q?Puwc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99229c87-1993-41ff-78e9-08dc3db6374b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:20:00.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkJnNkD/PFdqLlCk/6j/Nk1iPIbgM1r8BXtuVgch6Hq+KddCQS4s3JNGCmdWlKNs1RSKXrG9wUfRw27r8X+V4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBNYXJjaCA2LCAyMDI0IDQ6MTMgQU0NCj4gVG86IEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNv
bT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IFNyaXZhdHNhLCBSYXZp
c2hhbmthcg0KPiA8cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5
YW4sIENoZXRoYW4NCj4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gQmx1ZXRvb3RoOiBidGludGVsOiBEZWZpbmUgbWFjcm9z
IGZvciBpbWFnZSB0eXBlcw0KPiANCj4gSGkgS2lyYW4sDQo+IA0KPiBPbiBUdWUsIE1hciA1LCAy
MDI0IGF0IDk6MzjigK9BTSBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBVc2UgbWFjcm8gZm9yIGltYWdlIHR5cGUgaW5zdGVhZCBvZiB1c2luZyBoYXJkIGNvZGUg
bnVtYmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyB8IDEyICsrKysr
Ky0tLS0tLQ0KPiA+IGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCB8ICAzICsrKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgYi9kcml2ZXJzL2JsdWV0
b290aC9idGludGVsLmMNCj4gPiBpbmRleCA2YmE3ZjVkMWI4MzcuLmVkOThiYjg2N2NmZiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4gPiArKysgYi9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4gPiBAQCAtNDg5LDcgKzQ4OSw3IEBAIHN0YXRpYyBp
bnQgYnRpbnRlbF92ZXJzaW9uX2luZm9fdGx2KHN0cnVjdCBoY2lfZGV2DQo+ICpoZGV2LA0KPiA+
ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBzd2l0Y2ggKHZlcnNpb24tPmltZ190eXBlKSB7
DQo+ID4gLSAgICAgICBjYXNlIDB4MDE6DQo+ID4gKyAgICAgICBjYXNlIElNR19CT09UTE9BREVS
Og0KPiA+ICAgICAgICAgICAgICAgICB2YXJpYW50ID0gIkJvb3Rsb2FkZXIiOw0KPiA+ICAgICAg
ICAgICAgICAgICAvKiBJdCBpcyByZXF1aXJlZCB0aGF0IGV2ZXJ5IHNpbmdsZSBmaXJtd2FyZSBm
cmFnbWVudCBpcw0KPiBhY2tub3dsZWRnZWQNCj4gPiAgICAgICAgICAgICAgICAgICogd2l0aCBh
IGNvbW1hbmQgY29tcGxldGUgZXZlbnQuIElmIHRoZSBib290DQo+ID4gcGFyYW1ldGVycyBpbmRp
Y2F0ZSBAQCAtNTIxLDcgKzUyMSw3IEBAIHN0YXRpYyBpbnQNCj4gYnRpbnRlbF92ZXJzaW9uX2lu
Zm9fdGx2KHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2ZXJzaW9uLT5taW5fZndfYnVpbGRfbm4sIHZlcnNpb24tPm1pbl9md19idWlsZF9jdywN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjAwMCArIHZlcnNpb24tPm1pbl9md19i
dWlsZF95eSk7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0gICAgICAgY2FzZSAw
eDAzOg0KPiA+ICsgICAgICAgY2FzZSBJTUdfT1A6DQo+ID4gICAgICAgICAgICAgICAgIHZhcmlh
bnQgPSAiRmlybXdhcmUiOw0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAg
IGRlZmF1bHQ6DQo+ID4gQEAgLTUzNSw3ICs1MzUsNyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfdmVy
c2lvbl9pbmZvX3RsdihzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwNCj4gPiAgICAgICAgIGJ0X2Rl
dl9pbmZvKGhkZXYsICIlcyB0aW1lc3RhbXAgJXUuJXUgYnVpbGR0eXBlICV1IGJ1aWxkICV1IiwN
Cj4gdmFyaWFudCwNCj4gPiAgICAgICAgICAgICAgICAgICAgIDIwMDAgKyAodmVyc2lvbi0+dGlt
ZXN0YW1wID4+IDgpLCB2ZXJzaW9uLT50aW1lc3RhbXAgJiAweGZmLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgdmVyc2lvbi0+YnVpbGRfdHlwZSwgdmVyc2lvbi0+YnVpbGRfbnVtKTsNCj4gPiAt
ICAgICAgIGlmICh2ZXJzaW9uLT5pbWdfdHlwZSA9PSAweDAzKQ0KPiA+ICsgICAgICAgaWYgKHZl
cnNpb24tPmltZ190eXBlID09IElNR19PUCkNCj4gPiAgICAgICAgICAgICAgICAgYnRfZGV2X2lu
Zm8oaGRldiwgIkZpcm13YXJlIFNIQTE6IDB4JTguOHgiLA0KPiA+IHZlcnNpb24tPmdpdF9zaGEx
KTsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gQEAgLTExNzIsNyArMTE3Miw3IEBA
IHN0YXRpYyBpbnQgYnRpbnRlbF9kb3dubG9hZF9md190bHYoc3RydWN0IGhjaV9kZXYNCj4gKmhk
ZXYsDQo+ID4gICAgICAgICAgKiBJZiB0aGUgZmlybXdhcmUgdmVyc2lvbiBoYXMgY2hhbmdlZCB0
aGF0IG1lYW5zIGl0IG5lZWRzIHRvIGJlIHJlc2V0DQo+ID4gICAgICAgICAgKiB0byBib290bG9h
ZGVyIHdoZW4gb3BlcmF0aW9uYWwgc28gdGhlIG5ldyBmaXJtd2FyZSBjYW4gYmUgbG9hZGVkLg0K
PiA+ICAgICAgICAgICovDQo+ID4gLSAgICAgICBpZiAodmVyLT5pbWdfdHlwZSA9PSAweDAzKQ0K
PiA+ICsgICAgICAgaWYgKHZlci0+aW1nX3R5cGUgPT0gSU1HX09QKQ0KPiA+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAgICAgICAgLyogaUJUIGhhcmR3YXJlIHZh
cmlhbnRzIDB4MGIsIDB4MGMsIDB4MTEsIDB4MTIsIDB4MTMsIDB4MTQNCj4gPiBzdXBwb3J0IEBA
IC0yMjMwLDcgKzIyMzAsNyBAQCBzdGF0aWMgaW50DQo+IGJ0aW50ZWxfcHJlcGFyZV9md19kb3du
bG9hZF90bHYoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+ID4gICAgICAgICAgKiBJdCBpcyBub3Qg
cG9zc2libGUgdG8gdXNlIHRoZSBTZWN1cmUgQm9vdCBQYXJhbWV0ZXJzIGluIHRoaXMNCj4gPiAg
ICAgICAgICAqIGNhc2Ugc2luY2UgdGhhdCBjb21tYW5kIGlzIG9ubHkgYXZhaWxhYmxlIGluIGJv
b3Rsb2FkZXIgbW9kZS4NCj4gPiAgICAgICAgICAqLw0KPiA+IC0gICAgICAgaWYgKHZlci0+aW1n
X3R5cGUgPT0gMHgwMykgew0KPiA+ICsgICAgICAgaWYgKHZlci0+aW1nX3R5cGUgPT0gSU1HX09Q
KSB7DQo+ID4gICAgICAgICAgICAgICAgIGJ0aW50ZWxfY2xlYXJfZmxhZyhoZGV2LCBJTlRFTF9C
T09UTE9BREVSKTsNCj4gPiAgICAgICAgICAgICAgICAgYnRpbnRlbF9jaGVja19iZGFkZHIoaGRl
dik7DQo+ID4gICAgICAgICB9IGVsc2Ugew0KPiA+IEBAIC0yNjAwLDcgKzI2MDAsNyBAQCBzdGF0
aWMgaW50IGJ0aW50ZWxfYm9vdGxvYWRlcl9zZXR1cF90bHYoc3RydWN0DQo+IGhjaV9kZXYgKmhk
ZXYsDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4NCj4gPiAgICAgICAgIC8q
IGNoZWNrIGlmIGNvbnRyb2xsZXIgaXMgYWxyZWFkeSBoYXZpbmcgYW4gb3BlcmF0aW9uYWwgZmly
bXdhcmUgKi8NCj4gPiAtICAgICAgIGlmICh2ZXItPmltZ190eXBlID09IDB4MDMpDQo+ID4gKyAg
ICAgICBpZiAodmVyLT5pbWdfdHlwZSA9PSBJTUdfT1ApDQo+ID4gICAgICAgICAgICAgICAgIGdv
dG8gZmluaXNoOw0KPiA+DQo+ID4gICAgICAgICBlcnIgPSBidGludGVsX2Jvb3QoaGRldiwgYm9v
dF9wYXJhbSk7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCBi
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCBpbmRleA0KPiA+IGQxOWZjZGI5ZmYwYi4uNTJi
MmYxOTg2Zjg1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0K
PiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0KPiA+IEBAIC01MSw2ICs1MSw5
IEBAIHN0cnVjdCBpbnRlbF90bHYgew0KPiA+ICAgICAgICAgdTggdmFsW107DQo+ID4gIH0gX19w
YWNrZWQ7DQo+ID4NCj4gPiArI2RlZmluZSBJTUdfQk9PVExPQURFUiAgICAgICAgIDB4MDEgICAg
LyogQm9vdGxvYWRlciBpbWFnZSAqLw0KPiA+ICsjZGVmaW5lIElNR19PUCAgICAgICAgICAgICAg
ICAgMHgwMyAgICAvKiBPcGVyYXRpb25hbCBpbWFnZSAqLw0KPiANCj4gTGV0cyBwcmVmaXggdGhl
c2Ugd2l0aCBCVElOVEVMLg0KDQpBY2suDQoNCj4gDQo+ID4gIHN0cnVjdCBpbnRlbF92ZXJzaW9u
X3RsdiB7DQo+ID4gICAgICAgICB1MzIgICAgIGNudmlfdG9wOw0KPiA+ICAgICAgICAgdTMyICAg
ICBjbnZyX3RvcDsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0K
PiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQoNClRoYW5rcywNCktpcmFuDQo=
