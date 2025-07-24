Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D82BE633
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358323; cv=fail; b=uYcscdfUuq1UPWFrMn96Hpf6MzUjoIZ23xC8RBK+E+AI0KO6175rqmCZID3x5doECmNONbbl1PaK9q4ASvVWlcm1c46MdGlL4yoftS6E7McYJCmrW1ZQwvO22jEo5TE6OYLVruNezyNoQUTvh3x7X959xn0Jl5w/vE1eO/bwl3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358323; c=relaxed/simple;
	bh=fgnUjcoHCNm0bfo1w3ZqeUIG70BdVmF2LcvpsDiHqDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rGQAkYfuNI4E6DymVsLJ05ZHHw4bc/XSv7Ba5DkRyIuATkN/gV+rqQ7IiWDWF2b1mMuOf17AsaPRzCZxXN7S6IrIImArjcYRLFVsPNoNJwwGRgDKfQksda/O40VMaOFitTrJMQXapndC6TsXdjvxGQHZmwDsYYozMmA9rQ8v0R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/8tjiJ2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/8tjiJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753358321; x=1784894321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgnUjcoHCNm0bfo1w3ZqeUIG70BdVmF2LcvpsDiHqDU=;
  b=N/8tjiJ2ASPgcyU1faHCL30mZgrsg68s9VXeFZsUveExiIcZJoai1m/n
   xBG6LOnmHywalfSfWtNh4t2Mf5+IbZfbMurd0d9sL97ZBoQgjOqwuPBPN
   XxMUKV62qTGjKBcemZX9bT8UhGaOF/m4/h0wKX+4/8laJ96u0QUYlD2Eq
   MY0f2HiaH+f3EpyGSFdBPS1Niu8I+qWgNgzm3yU5iFbV+x20WOcfMznnP
   B1nerWed1pH7WzEJ5Ydwu+wr+jnjCERFsRGLeXepZCAdn43bSt8ijRtzW
   U5gaAME4ULbJbAKDNtqXv0nr2Ct5lyq8Tp9/UYrkB2Q7qat2Nkn5bCHb2
   w==;
X-CSE-ConnectionGUID: boxBzCvWS4WSS3YN61VtBg==
X-CSE-MsgGUID: LiNIytjSSMKloer5xHxNOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66234294"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66234294"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:58:40 -0700
X-CSE-ConnectionGUID: pLq440xnQiGr1b3YT3peXw==
X-CSE-MsgGUID: 94/35GlZQ8aIa1Jti8YgfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164396298"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:58:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:58:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 04:58:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixYTl2hsbXcvrPBxX3FM9zElblvd6MhyRyRqX/5PYdN9u3CqVkcU5rqjntt9IorSbZZAuXKPXJ2/+RnhzbyTwahblOh4MOUgj+CNvNVF1hC7xK22fM7AlOtOO7rAwDhxF4Yd29swtJZtEgoWaWY7l6e1Dx+hb0IgiMJs47Rw41eTr1qPXufLJNsT0O6i64Erfyr9mx1/+kQSN2X5FAtOCzIZQmhjFLLzOy0xsTaivycyVBrF8jeP7rIwCfcVCk5vMb0PANcihxC+NmCwnXDCDyoDTUgPyhJNUsxKs4QElUW7rBcJdBO0nM6JaGKPpf+Q68RVrmunVYnrcfxhTXVdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgnUjcoHCNm0bfo1w3ZqeUIG70BdVmF2LcvpsDiHqDU=;
 b=B+Zlj8vMbTDY+ur2YQp2AFtBHnK8lgrrd1UlTCgsZ/5lQh2BxE0YmXIZ0BGIDH/FRN1etHsKTGCmJeEX2r9HGufbRq4ZOJNt/f2EkcgeZSJSfIsV6doW7fqy7XFqF9ER8cZiqQoLyppRFJIbJe97eBiCCqAQPC5pBaXM9F2TTUBklApji/zspfofQx+7JPSz52rUZ83vejbY0N2y7rp2S2U6CiR+DPakXKRfGJSY1AyheqF641c57gkr9NtBFziL5XQjNu/JNzGs39L4C6Wh3sHZ9P9eYFrJkQo9R7mX1b3DcgmfLLrwoMJmmEe1Bal+PBznqf3Kt1sn5JtTETsatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 11:58:37 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 11:58:36 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, Vijay Satija
	<vijay.satija@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
Thread-Topic: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
Thread-Index: AQHb+9WxgPSv0k5A+0Kd3JgiJlxySLRAH1OAgAEMP8A=
Date: Thu, 24 Jul 2025 11:58:36 +0000
Message-ID: <PH0PR11MB75853A96C09178CFE57543A4F55EA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250723134453.1301750-1-kiran.k@intel.com>
 <CABBYNZJ-Ypx-EqrFijnzpbEXwaCSCxeNDLchV_QU0Z00BRpZVQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ-Ypx-EqrFijnzpbEXwaCSCxeNDLchV_QU0Z00BRpZVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CH0PR11MB8168:EE_
x-ms-office365-filtering-correlation-id: e06afdf3-2b67-42fa-feba-08ddcaa96c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z3pOYXFWRlBabUpvM3F1aVVwcC9ORlBIdlFJUUVLazlPT29wMnRFbldIZjQr?=
 =?utf-8?B?ZUJrYkIzREJEYzRlWjFWaFZnbFQyeFF5ZDZBWU5MMzF3SEJpcFZKYXpOZFdu?=
 =?utf-8?B?SE5mYmF5QmxGTFcxMVpmM2ZUWFA3U2p2Q2FCTWoxMWI0SGt4QU1ZZTM2TDUy?=
 =?utf-8?B?RVNsVUtCN3JZZlJNMjNDQm5iNDFva0p6c1hLdE9JeXZYd1d1SzdwTlgzZGlN?=
 =?utf-8?B?dkZLUStKYjRCSFJjV0FpMEQyOEF3bm51Q2JPaU5WZFMrQStIdHlVS29kVUF0?=
 =?utf-8?B?WlpNRnBGczExSlhUV2dwKzJ6VWZQNVpWR3hRQ0lLOUoyNkFoRFpsSmpTSEpv?=
 =?utf-8?B?SUczY1V4bU9EeVJ2T3FxU1FCUHZRYUlwRk15T2xoNk0yNmJHbzg4T1J4NHZB?=
 =?utf-8?B?cXQrUER5SitUWVp1cHJpTHNkUzluWlljaXgvNUc4Rm5CbC84OE8rUlJIOG10?=
 =?utf-8?B?K2xYWVBHZzhDb1VLMk9weUpFdjJUSzFScEMrVVg3Mmt6Y2I4cWp4ZWpua0pm?=
 =?utf-8?B?WkN6cnQ5eFJLZ2lUYzJDM1J3Y2RRd3RmT1NkSXo3dURsalg4VnFzV0VCOEd5?=
 =?utf-8?B?b3BHMEJxd2s3VDI0SFEzdTEyVktiL1BmM253T01QNDVuYUR4KzJrbmVEWlp0?=
 =?utf-8?B?SlRaZllqQndjMEZ0L2srSmpzeGp4L1NHcUkyL3VwWm9qTEF5TnArdDdBN1NC?=
 =?utf-8?B?NThaMXlqaVVxR1lVSVRvd0liczlVR1V4aUwzZTdOYmF6VHQ5b2FPUktNa0Nq?=
 =?utf-8?B?Q2dzcTB4a0c0ZGthTDVOZ2o0aEloV2pjWGVxdEJ6TUpMZlFrNHQ4RTZHcGVw?=
 =?utf-8?B?NFp2YVBPc29wNjdNRmpPNEpnbkZYYXBIQ0FTNi9NUHVQYk9iVHB3ZXRwT1dw?=
 =?utf-8?B?UEZ4YytvbEpaYnRqVUpoZDFRb0pZZXlhY1FlU0NCZ1ZpQzFZMStRVk5KVXRF?=
 =?utf-8?B?ck5XTnVYenpOZ0t6VmxOOVJncUVPZ1E5ajVLWjBCcGN2SmZZVTlHMzNrU2lE?=
 =?utf-8?B?NHhUYWJtWHIxa0w3R0x5alNSUExEMUdjYkNCN0FrOWxuRzNQZzFVQW02ekV4?=
 =?utf-8?B?c2dGTDRkc2d6OEZSbEVoM05tWlhBcEcveWMxMytROVhZa3NiemIxVkhidTRQ?=
 =?utf-8?B?K2VCY0ZYNWFBT1ZHTVZrRGxVaE02YnNhV3ZYWXlCU01BQld2bElyL3lFT1ky?=
 =?utf-8?B?Y0daazNyTUxjRkY2a0QyVlQvNjZ2WWxQYlRHanIxZUQ4T3JuQU5sYUUrSU8z?=
 =?utf-8?B?TkwzWGYxa2dRTjJrMHlOMmhSVERaSEpnWFJQSGtBNFJ5a0wzUTJSSHJYT1VT?=
 =?utf-8?B?ZXFCUis3OXl0aGJKeFlVMmlueFh3VEhGMks2OXc3V29BaTh6R2lvMzBZdlYr?=
 =?utf-8?B?SE1FOHpoREJQdXd3bVZHZndYMExyNi9aanExb2pGM3o1N0U3dU12bGJXbnRQ?=
 =?utf-8?B?ejZ1UTVOSzJVaXIvQ0JROXh3SitvdjZ0d29qZWQ1MDQrWm9LTmwzME5pSkJT?=
 =?utf-8?B?SWxpZXF4MXF0Mm5ZOU1IUEtMc0ZrdHVTbk54UXB0VGdORHpFeWQ5UXh5RGJz?=
 =?utf-8?B?dTVCT2RtQkg4WGZWemNoaittWHpiNXdGUUt3TkFJTzZYdzg2MVgzNlhDMHFv?=
 =?utf-8?B?eWVsOXk2eUhqbHUwM0E3UU42MVVZbzF2cHh1NjNRMkFyeTRSOEZVZ2ZxYmtv?=
 =?utf-8?B?TllLYS85MThGY1JFdyt6azczVXhvako2YlFidEdILzlQWWdkb3dOdEVYb1VG?=
 =?utf-8?B?clp6bnc0bFpOT2lPeUk5R3p2ejlmaHlFSmM4T2l3aWJFaS9vM2VCLzF1Ulc0?=
 =?utf-8?B?clBMMFdONFo5eEpCbUJqbEwrK2pzWXptZUgvRHlLSXE2Sk55TFFuODFKSFNW?=
 =?utf-8?B?T3dYdDdmeW96Qk9xbnJGSXh4bCtyaFo1a1E5bklUVGliakcvNnhxZGFUODBs?=
 =?utf-8?B?S0Rwc0tKeHBMcy9YazA0SzhFcFFUS1Q3V2d0MlpEZkY1aTArc2RwRHRhUGZB?=
 =?utf-8?Q?nONwXJZzKC2dsY/JUJLnda6RO4GEoo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01URTZXcGVCRHdZUWxCSTRDZGxtUUhCRnpmWkk0MzhDRjQxMUQxeE5mYnFI?=
 =?utf-8?B?c214dkhCYnZvcjJlWWwvVTJ4MFZ5cTVTLzRvMWl0N0xJOGw1TkFPZE9JSE55?=
 =?utf-8?B?UXlwWDJCS3h3dWNTZHFGOExTWXZaN1FXdjkvY0M1SUgyQWhzTExEWTBsK3BW?=
 =?utf-8?B?bUF0ODlya2MyUDJoV3RSTlFSQnNBMDBoNXJ0VzZJU0xsNXRQVXNKcUZtMGdO?=
 =?utf-8?B?MjByUkMycGJBYmNuSTFBMnd5N01IZ21WMm5INVNVTjBtRysrOUcxZ1FTQXIr?=
 =?utf-8?B?RE5JSi9CSHZLUlBkcEVNaGYvcEFwRm00ckpoWTIvY0tYRGdDVWs4TE5pdHFT?=
 =?utf-8?B?OFpVOXNZcUxBR3pLYjA2QzNVS2tPYmJuS0dnRHpwVmxXT2NEazI3YnhQUFlt?=
 =?utf-8?B?KzM2WHhsSEF1VGlPckhOaWcvMEFwckhPSlcyMy9nN0RzRHkwQWluRDlSUDFr?=
 =?utf-8?B?OXowVnp3UURyME84enZCSS9LenllTk5Zc1BSMVRwenpDWlhNeE5oZHo4NVBh?=
 =?utf-8?B?c1U5aWtxVVMwbzZCODhUZDYwZDcvR0ZWMnJyZElXdkUxUjk0dWdsQkMrRnFW?=
 =?utf-8?B?RHBMWmVXTUF1VGxLL2lNWVJqNDlGZG5vekJWVW1HV2hoQ1Znb2lNSmlxQitp?=
 =?utf-8?B?RFMwek9rSFk0OWExcUt6TzljcGxDcENYMzdvdzRmdmN3UEZMZnZlMjRsdVpi?=
 =?utf-8?B?T3BwS0xTTER6NS9OV0FhRzFmSWlONVVMQlVJNkM5dzVUdUlhOGp0T1V3WFZk?=
 =?utf-8?B?cmk2RUhHa1ZMRDRWa1FRSHFkVDczZCtVRmt2WXdkaTc2NkZZOThGQTZOTkM5?=
 =?utf-8?B?UU45d3hJTExYRkFxNEwzU25PUklUSHRkMWRld1NWK01oTFJhRW1YSEQ0Y2gw?=
 =?utf-8?B?d2JHbWErWDlhcTA1VXNqdGxmenNPNmJwWTVHZHpva0wxanVFSzJPNU9SZ0FH?=
 =?utf-8?B?M2l0TVd0QU1nZGcvajZIQmJaNlhIVWpTclZoYkRMVEVHK2h2ZjVaN1hsUHV2?=
 =?utf-8?B?TERXMkRXZWNmS2pPUjY2aGIyc1ZjOFJLaFdUTlp1bzFmMTRYZU5OQU5Td1Z5?=
 =?utf-8?B?SVAwK1BWZWthSHFLTEFKTzhpSWxJNE1WYnBnQUpqakN4NlpNZzdvQUJRcVZk?=
 =?utf-8?B?aGxuQThVUVBwbThYa0x2VTBadHVTR2pJYzljQVdCQWs5QXd3WDFRU08zZC9D?=
 =?utf-8?B?Yk80dURyLytULzJaN3JNTUMrSUswYmM0cC9nQUpqdWFGZTFQbkZ1SHQwd0Yy?=
 =?utf-8?B?YXVWZ3UwUXZKY0xwSW9DeDZRNjNrTWRsS2xlRjFKK2MrMkMyOHp5K0o1NFhx?=
 =?utf-8?B?cjRnLzdFbEJBUjNHZEJjSVppbURBU2FrV01HMEhuMGd6T1BrN3ExZ1Z4Zkdp?=
 =?utf-8?B?L1ppMllGODhWMUhPUGNxc05BOGp0VjNvRnB2SVA1NnZlT1RnRTg5SVNuRXFr?=
 =?utf-8?B?NElZY3QxcnA0OE5ZRHh1Q1UyRCtVdlRqd0hlbzRqa2daS1VHZmswc2ZDNkNq?=
 =?utf-8?B?a1lteWpvR2JpT0Jwa0NkV1ZtUkNIMVhGbFpxVjNGc045Qzh0UUZHRDRVZkFp?=
 =?utf-8?B?bGlQZ3d4a0IzdCt6eEpURnIzSkdvNlQ4SnVNb3dleEZaeUJSTEZhY0hmK0lk?=
 =?utf-8?B?eWppMWdPVFpPRDFhUWc4N05ocjdjQ09ldUpYZlp3OFEwOWhOdnU0N1A5cUhL?=
 =?utf-8?B?NmRWMTdxNTJFOVp2cnZPbU85UFpocWN4MlJ0VjIyNWhlMnEra0hyeTJwbSsv?=
 =?utf-8?B?am9DN3BDRXpUazQwWUFVY2NEdVRpNU50UGVRNndnSmFCbUJNcG1xMzBhbEtp?=
 =?utf-8?B?MU5EREJyYVV6aTAzZ21wZ3o1a24vODdBUWltRkEvTlpEMmJscFdkb1pJQ3Y1?=
 =?utf-8?B?U2x5YW5vK1Y0eHViNW92THFJc2g5dEtzVGs2SE1RUXdGYVBkVDNMQll1dWJR?=
 =?utf-8?B?Z0pJZWRsbXZWdWR0cTh3dnRXWWc0Z2xNb3ZDYUFhbkNuZXQvTEtScUNHbXdE?=
 =?utf-8?B?NlVVTjEyemFiUWtoQmNZUWVMM3Bpd0pjOHhNd1NUMzg4cGIreExRT3ZkclFa?=
 =?utf-8?B?RVRDQ0dERFB2ZzVFa0dHN1U2N0JSaTEvRk5yTGUzZ3ZuRGg5TWF6aEhTRUgw?=
 =?utf-8?Q?3vUQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e06afdf3-2b67-42fa-feba-08ddcaa96c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 11:58:36.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BupiiNS27JmQXZrjhpUvuFoQJ42cqdOy7c1VvhiDbvP/vW30pY4DtYr3EEqH4AuoB0ZHIFKCereZuScb+g7bMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTHVpeiBBdWd1
c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+U2VudDogVGh1cnNkYXksIEp1
bHkgMjQsIDIwMjUgMToyNCBBTQ0KPlRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+
Q2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IFNyaXZhdHNhLCBSYXZpc2hhbmth
cg0KPjxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBWaWpheSBTYXRpamEgPHZpamF5
LnNhdGlqYUBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MV0gQmx1ZXRvb3RoOiBi
dGludGVsOiBBZGQgc3VwcG9ydCBmb3IgQmxhemFySVcgY29yZQ0KPg0KPkhpIEtpcmFuLA0KPg0K
Pk9uIFdlZCwgSnVsIDIzLCAyMDI1IGF0IDk6MzTigK9BTSBLaXJhbiBLIDxraXJhbi5rQGludGVs
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBCbGF6YXJJVyBCbHVldG9v
dGggY29yZSB1c2VkIGluIHRoZSBXaWxkY2F0IExha2UNCj4+IHBsYXRmb3JtLg0KPj4NCj4+IGRt
ZXNnOg0KPj4gQmx1ZXRvb3RoOiBDb3JlIHZlciAyLjIyDQo+PiBCbHVldG9vdGg6IEhDSSBkZXZp
Y2UgYW5kIGNvbm5lY3Rpb24gbWFuYWdlciBpbml0aWFsaXplZA0KPj4gQmx1ZXRvb3RoOiBIQ0kg
c29ja2V0IGxheWVyIGluaXRpYWxpemVkDQo+PiBCbHVldG9vdGg6IEwyQ0FQIHNvY2tldCBsYXll
ciBpbml0aWFsaXplZA0KPj4gQmx1ZXRvb3RoOiBTQ08gc29ja2V0IGxheWVyIGluaXRpYWxpemVk
DQo+PiBCbHVldG9vdGg6IGhjaTA6IERldmljZSByZXZpc2lvbiBpcyAwDQo+PiBCbHVldG9vdGg6
IGhjaTA6IFNlY3VyZSBib290IGlzIGVuYWJsZWQNCj4+IEJsdWV0b290aDogaGNpMDogT1RQIGxv
Y2sgaXMgZGlzYWJsZWQNCj4+IEJsdWV0b290aDogaGNpMDogQVBJIGxvY2sgaXMgZGlzYWJsZWQN
Cj4+IEJsdWV0b290aDogaGNpMDogRGVidWcgbG9jayBpcyBkaXNhYmxlZA0KPj4gQmx1ZXRvb3Ro
OiBoY2kwOiBNaW5pbXVtIGZpcm13YXJlIGJ1aWxkIDEgd2VlayAxMCAyMDE0DQo+PiBCbHVldG9v
dGg6IGhjaTA6IEJvb3Rsb2FkZXIgdGltZXN0YW1wIDIwMjMuMzMgYnVpbGR0eXBlIDEgYnVpbGQg
NDU5OTUNCj4+IEJsdWV0b290aDogaGNpMDogRm91bmQgZGV2aWNlIGZpcm13YXJlOiBpbnRlbC9p
YnQtMTE5MC0wMGExLWltbC5zZmkNCj4+IEJsdWV0b290aDogaGNpMDogQm9vdCBBZGRyZXNzOiAw
eDMwMDk4ODAwDQo+PiBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIFZlcnNpb246IDE4NC0yOC4y
NQ0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBmaXJtd2FyZSBkb3dubG9hZCB0byBj
b21wbGV0ZQ0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSBsb2FkZWQgaW4gNjc0MjYgdXNl
Y3MNCj4+IEJsdWV0b290aDogaGNpMDogV2FpdGluZyBmb3IgZGV2aWNlIHRvIGJvb3QNCj4+IEJs
dWV0b290aDogaGNpMDogRGV2aWNlIGJvb3RlZCBpbiAyMjQ4IHVzZWNzDQo+PiBCbHVldG9vdGg6
IGhjaTA6IFdhaXRpbmcgZm9yIGRldmljZSB0cmFuc2l0aW9uIHRvIGQwDQo+PiBCbHVldG9vdGg6
IGhjaTA6IERldmljZSBtb3ZlZCB0byBEMCBpbiAwIHVzZWNzDQo+PiBCbHVldG9vdGg6IGhjaTA6
IGRzYnI6IGVuYWJsZTogMHgwMSB2YWx1ZTogMHgwZg0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBGb3Vu
ZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xMTkwLTAwYTEtcGNpLnNmaQ0KPj4gQmx1ZXRv
b3RoOiBoY2kwOiBCb290IEFkZHJlc3M6IDB4MTAwMDA4MDANCj4+IEJsdWV0b290aDogaGNpMDog
RmlybXdhcmUgVmVyc2lvbjogMTg0LTI4LjI1DQo+PiBCbHVldG9vdGg6IGhjaTA6IFdhaXRpbmcg
Zm9yIGZpcm13YXJlIGRvd25sb2FkIHRvIGNvbXBsZXRlDQo+PiBCbHVldG9vdGg6IGhjaTA6IEZp
cm13YXJlIGxvYWRlZCBpbiA1MTA5OTAgdXNlY3MNCj4+IEJsdWV0b290aDogaGNpMDogV2FpdGlu
ZyBmb3IgZGV2aWNlIHRvIGJvb3QNCj4+IEJsdWV0b290aDogaGNpMDogRGV2aWNlIGJvb3RlZCBp
biAzOTA1NyB1c2Vjcw0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBkZXZpY2UgdHJh
bnNpdGlvbiB0byBkMA0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgbW92ZWQgdG8gRDAgaW4g
ODggdXNlY3MNCj4+IEJsdWV0b290aDogaGNpMDogRm91bmQgSW50ZWwgRERDIHBhcmFtZXRlcnM6
DQo+PiBpbnRlbC9pYnQtMTE5MC0wMGExLXBjaS5kZGMNCj4+IEJsdWV0b290aDogaGNpMDogQXBw
bHlpbmcgSW50ZWwgRERDIHBhcmFtZXRlcnMgY29tcGxldGVkDQo+PiBCbHVldG9vdGg6IGhjaTA6
IEZpcm13YXJlIHRpbWVzdGFtcCAyMDI1LjI4IGJ1aWxkdHlwZSAxIGJ1aWxkIDk2NDQwDQo+PiBC
bHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIFNIQTE6IDB4MzRiODVjMTYNCj4+IEJsdWV0b290aDog
aGNpMDogRnNlcSBzdGF0dXM6IFN1Y2Nlc3MgKDB4MDApDQo+PiBCbHVldG9vdGg6IGhjaTA6IEZz
ZXEgZXhlY3V0ZWQ6IDAwLjk4LjAwLjA1DQo+PiBCbHVldG9vdGg6IGhjaTA6IEZzZXEgQlQgVG9w
OiAwMC45OC4wMC4wNQ0KPj4gQmx1ZXRvb3RoOiBCTkVQIChFdGhlcm5ldCBFbXVsYXRpb24pIHZl
ciAxLjMNCj4+IEJsdWV0b290aDogQk5FUCBmaWx0ZXJzOiBwcm90b2NvbCBtdWx0aWNhc3QNCj4+
IEJsdWV0b290aDogQk5FUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4+IEJsdWV0b290aDog
TUdNVCB2ZXIgMS4yMw0KPj4gQmx1ZXRvb3RoOiBSRkNPTU0gVFRZIGxheWVyIGluaXRpYWxpemVk
DQo+PiBCbHVldG9vdGg6IFJGQ09NTSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4+IEJsdWV0
b290aDogUkZDT01NIHZlciAxLjExDQo+DQo+bHNwY2kgaXMgcHJvYmFibHkgYmV0dGVyIHRoYW4g
ZG1lc2cgd2hlbiBhZGRpbmcgbmV3IG1vZGVscyBzaW5jZSB3aGF0DQo+bWF0dGVycyBoZXJlLCBv
ciB0aGVyZSBpcyBubyBjaGFuZ2UgaW4gdGhlIGxzcGNpPyBJZiBpdCBkb2Vzbid0IHRoZW0gaXQg
cHJvYmFibHkNCkhhcmR3YXJlIHZhcmlhbnQgaXMgaW50ZWwgc3BlY2lmaWMgYW5kIGl0IGRvZXNu
4oCZdCBzaG93IHVwIGluIGxzY3BpIGNvdXRwdXQuDQoNCj5iZXR0ZXIgdG8gYWRkIHRoZSByZXNw
b25zZSBvZiBSZWFkIFZlcnNpb24gVExWLCB3ZSBkbyBoYXZlIGRlY29kaW5nIG9mIGl0Og0KPg0K
Pmh0dHBzOi8vZ2l0aHViLmNvbS9ibHVlei9ibHVlei9ibG9iLzNjMDY5M2M1ZDIyNjA2Zjc4NmRh
NDM4OTEwMzc0MDQyNGENCj4wNDIxM2IvbW9uaXRvci9pbnRlbC5jI0wyOTcNCj4NCj5QZXJoYXBz
IHdlIHNob3VsZCBhZGQgYSBkZWNvZGluZyBmb3IgdGhlIHZlcnNpb24gY29kZSBuYW1lIHJhdGhl
ciB0aGFuIGp1c3QNCj5wcmludCB2ZXJzaW9uIG51bWJlciwgYW55d2F5IGRtZXNnIGlzIGp1c3Qg
bm90IHVzZWZ1bCBpbiBnZW5lcmFsIGFuZCB3ZQ0KPmFjdHVhbGx5IHNob3VsZCByZWR1Y2UgdGhl
IGFtb3VudCBvZiBpbmZvcm1hdGlvbiB3ZSBwcmludCB0aGVyZSB1c2luZw0KPmJ0X2Rldl9pbmZv
Lg0KPg0KSSB3aWxsIGFkZCB0aGUgc3VwcG9ydCBpbiBtb25pdG9yIHRvIGRlY29kZSBjbnZpIG5h
bWUgYW5kIGluY2x1ZGUgdGhlIGhjaSB0cmFjZXMgaW4gY29tbWl0IG1lc3NhZ2UuDQo+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBWaWpheSBTYXRpamEgPHZpamF5LnNhdGlqYUBpbnRlbC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRy
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyAgICAgIHwgMyArKysNCj4+ICBkcml2ZXJzL2JsdWV0
b290aC9idGludGVsX3BjaWUuYyB8IDEgKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBi
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gaW5kZXggYmU2OWQyMWM5YWE3Li45ZDI5
YWI4MTFmODAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4+
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gQEAgLTQ4NCw2ICs0ODQsNyBA
QCBpbnQgYnRpbnRlbF92ZXJzaW9uX2luZm9fdGx2KHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPj4g
ICAgICAgICBjYXNlIDB4MWQ6ICAgICAgLyogQmxhemFyVSAoQnpyVSkgKi8NCj4+ICAgICAgICAg
Y2FzZSAweDFlOiAgICAgIC8qIEJsYXphckkgKEJ6cikgKi8NCj4+ICAgICAgICAgY2FzZSAweDFm
OiAgICAgIC8qIFNjb3JwaW91cyBQZWFrICovDQo+PiArICAgICAgIGNhc2UgMHgyMjogICAgICAv
KiBCbGF6YXJJVyAoQnpySVcpICovDQo+PiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAg
ICAgIGRlZmF1bHQ6DQo+PiAgICAgICAgICAgICAgICAgYnRfZGV2X2VycihoZGV2LCAiVW5zdXBw
b3J0ZWQgSW50ZWwgaGFyZHdhcmUgdmFyaWFudA0KPj4gKDB4JXgpIiwgQEAgLTMyNTMsNiArMzI1
NCw3IEBAIHZvaWQgYnRpbnRlbF9zZXRfbXNmdF9vcGNvZGUoc3RydWN0DQo+aGNpX2RldiAqaGRl
diwgdTggaHdfdmFyaWFudCkNCj4+ICAgICAgICAgY2FzZSAweDFkOg0KPj4gICAgICAgICBjYXNl
IDB4MWU6DQo+PiAgICAgICAgIGNhc2UgMHgxZjoNCj4+ICsgICAgICAgY2FzZSAweDIyOg0KPj4g
ICAgICAgICAgICAgICAgIGhjaV9zZXRfbXNmdF9vcGNvZGUoaGRldiwgMHhGQzFFKTsNCj4+ICAg
ICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgZGVmYXVsdDoNCj4+IEBAIC0zNTkzLDYg
KzM1OTUsNyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmluZWQoc3RydWN0IGhjaV9k
ZXYNCj4qaGRldikNCj4+ICAgICAgICAgY2FzZSAweDFkOg0KPj4gICAgICAgICBjYXNlIDB4MWU6
DQo+PiAgICAgICAgIGNhc2UgMHgxZjoNCj4+ICsgICAgICAgY2FzZSAweDIyOg0KPj4gICAgICAg
ICAgICAgICAgIC8qIERpc3BsYXkgdmVyc2lvbiBpbmZvcm1hdGlvbiBvZiBUTFYgdHlwZSAqLw0K
Pj4gICAgICAgICAgICAgICAgIGJ0aW50ZWxfdmVyc2lvbl9pbmZvX3RsdihoZGV2LCAmdmVyX3Rs
dik7DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5j
DQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCA2ZTdiYmJk
MzUyNzkuLmQwOGY1OWFlNzcyMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0K
Pj4gQEAgLTIxNDksNiArMjE0OSw3IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3NldHVwX2lu
dGVybmFsKHN0cnVjdCBoY2lfZGV2DQo+KmhkZXYpDQo+PiAgICAgICAgIHN3aXRjaCAoSU5URUxf
SFdfVkFSSUFOVCh2ZXJfdGx2LmNudmlfYnQpKSB7DQo+PiAgICAgICAgIGNhc2UgMHgxZTogICAg
ICAvKiBCenJJICovDQo+PiAgICAgICAgIGNhc2UgMHgxZjogICAgICAvKiBTY1AgICovDQo+PiAr
ICAgICAgIGNhc2UgMHgyMjogICAgICAvKiBCenJJVyAqLw0KPj4gICAgICAgICAgICAgICAgIC8q
IERpc3BsYXkgdmVyc2lvbiBpbmZvcm1hdGlvbiBvZiBUTFYgdHlwZSAqLw0KPj4gICAgICAgICAg
ICAgICAgIGJ0aW50ZWxfdmVyc2lvbl9pbmZvX3RsdihoZGV2LCAmdmVyX3Rsdik7DQo+Pg0KPj4g
LS0NCj4+IDIuNDMuMA0KPj4NCj4+DQo+DQo+DQo+LS0NCj5MdWl6IEF1Z3VzdG8gdm9uIERlbnR6
DQpUaGFua3MsDQpLaXJhbg0KDQo=
