Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FE49634
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216612; cv=fail; b=C7Ca9AcMom+7g4odZTvVkgPKCic8FJRET85dFOXR8fXBowwbAnnHknDOI9+vMnqLj/Em8PUyBXiVV0oLGScJldLoAIomNGufBNNuJ5mlhxMw/GblOl/aTtfLXAQddOklJDFngL/GZ8vQEgERIXgnZpUlwRphrBthWuAief3b5to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216612; c=relaxed/simple;
	bh=oCdoDcRIMTynjxnffDT03p1QxumXG9rCbC5GHCXqRi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFj2p3zJRBb/AEMFHcO/6ou243LWoYUArt4J+u79JIY8VPhJVM4bcrD5XTr/P04OtLMb09RgpmLvXG8KAeTtWXXqCl55WrtOi5IuNCx7hS16WInRoDb0uoKws1nAWNel38XojQaZx86K1N2AnGE/7Sw7cgxW4jqapEkBhBTGAcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNWF7Lxy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNWF7Lxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719216610; x=1750752610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oCdoDcRIMTynjxnffDT03p1QxumXG9rCbC5GHCXqRi0=;
  b=LNWF7LxyXjsgw5YwtCpIeEGGYmCMtJG4cxvEg93beuTpj9iEnfgGfleD
   cmN05uB1gHlJhUQBk6zBhiGji0lsEZ/pOR1XfiwFGVf3aqP3QHptdrQgU
   G4uVVirH9P8hZm33/C//GmLQPdsfONi8RjWVYcAz7kDZiKzuML72/CvMZ
   CSXaWD9lDmEgSNJ5aCkSYs9ekGpilsqbY3rCLl8oFCk2zoGY1VW2h+wms
   wG6rzUJPy53r4QJcCGN2xpJwBrqm4dAtej750yMPaVBlG8siIQ5x9Ex+a
   oTKq3F7/QOoGCaddHuYpXyFAQDebnF/XFgyyxdm0bRw9oepOhfsajCfu0
   w==;
X-CSE-ConnectionGUID: bbIOMOYHSBaf3Lw9AT031g==
X-CSE-MsgGUID: 8otAgO5vREu7DH6SWlt/4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16305565"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16305565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:09:52 -0700
X-CSE-ConnectionGUID: S/P96Q23QPeEkWk8dPIYnQ==
X-CSE-MsgGUID: 4Qm9G1HFSiyi6yrAgkMRow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43666383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 01:09:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 01:09:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 01:09:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 01:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6j1l5jNFGp59NERHcuI79uEibK5Gaz4XXzXfbNvbYxqV5eBCeLwGXiNUlDPh6TN9ugYdhTzCEoYyJAW7VUQMhB9EKoR8NS3PotNg8ABLy9Ihan9yhI3fhLMGCRFRQPVVvK1TqnpBlmlVjCnUKe+cHbCHHZeQe2vTCxuUocuWOX9Mak/5mfirVNM9lNzKUlMHyqeYXYjEonX1yANw26dtcFrLnloyZTAHBDGY7OOhrHMY9h5JgOiXaHFZLCKybDcBD4CR39fUZWwmmWtpibb3FDNqskGUvCAF1wZZXAHLq/n8u5WPUoUJ0RiqzWoSb0vBSgoa3Vq7cadoLdiVyJCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCdoDcRIMTynjxnffDT03p1QxumXG9rCbC5GHCXqRi0=;
 b=AIFhL/vexTeVr3ZaRY0Uft9iYGQmnlYbj3yXOkd63lYX+GXyXLltJrNptroiAVa1oIMsdJ3KHDbGG4te8G2u1KTaTuO/obIuz4eMopzSwcCWEaMd3EDdeSMpjWZ5dS1AuDu2DUDr9S9wjmN94ABTXGpF/PFI5WEBBI7rdrCJdXZgnkNk8fGq/eS93ThJYRZmBxUhdtr0rFADQG/Nm0XPn5UKgeXCZ8FDRtuQYyiJjLOpjgZmhKqVwaZ2wmRl78G+/XAwNcKjgPLALmtZH1YZ/5T8SAv3QHGAZoSUn2DoE3/K65OLUYdiS2urIe48L2sl06R8/tk/6jvVsGQWPHFV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 08:09:43 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:09:42 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Topic: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Index: AQHaw6RySCVqnDsP20urkJhoMkIfVLHRznMAgATDhlA=
Date: Mon, 24 Jun 2024 08:09:42 +0000
Message-ID: <PH0PR11MB7585F3365504E29346E8EAE3F5D42@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240621064419.2185652-1-kiran.k@intel.com>
 <82e46c4b-10ba-426e-8d54-9670c8fb6373@molgen.mpg.de>
In-Reply-To: <82e46c4b-10ba-426e-8d54-9670c8fb6373@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ1PR11MB6179:EE_
x-ms-office365-filtering-correlation-id: db02e159-c718-4d9e-173f-08dc942500d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?bm5nczF4NmgzOGFaUzV4enFFZkxuZXc0WUF0UkVadEFub2JvNENmdUpXQXp3?=
 =?utf-8?B?T0NyZGJsbGJjdm5jUXF4Rzk5OHZrbSs3Y245Vk01cjJ6ay85RXJuT0dCcWNs?=
 =?utf-8?B?ZXVQdTdkR01NMU1ud29lOGJpd3htZUc2NHJnaFErVERaNXpSa3FuYVlSRkZo?=
 =?utf-8?B?YW9RaVFqWTViWWwvV3loenRzVWtyTk9mQnQyYVVyRUd3dURaMWZ1L2s3SHFH?=
 =?utf-8?B?UjNMdVhiZ0ZiT1FGYmp2dG5BRTVDSzRybmhHQnpXbndSMExlMkVYSFZINEdJ?=
 =?utf-8?B?ZmFGSUhkalZrYVNWZUZHQi9XSGZ5YlpXRU10VCtOcVBNNnJKZCtXRVlxWGw2?=
 =?utf-8?B?bUxsZC9QYWx6SmdzL2FaK3pZTlA2NjBYN2JnbDRaaS8yaXBKT2tsaG56bU8r?=
 =?utf-8?B?d1Y5L1hVTGdMaXVxUW56Sk02R1hyYXR3VjVTOEQyRkhEV0ovcG9xRDdlcFlQ?=
 =?utf-8?B?ZVN5UVp6eXhxeHVxSWkxbXZwVFlIZXc0M2orSnJPTXc2Q0txNFViZ3AyOTA3?=
 =?utf-8?B?Vkh2d2p2TVA4MGQ4eFloZzdIbC9RNC82dEs1Q2d0WHNVeDA2MTRxTmhRVzVR?=
 =?utf-8?B?ZzIxWXVGLzd0N2tVaVNPdXVDSkNURXBIUEk1Zm9zNW15WHNrWHA4ekc2K1J6?=
 =?utf-8?B?LzJoUWxCVW55YzBlbm83SlpzeHdqZFc4RFlWVTdpaXAxUGhNb2xxZnpNU3ZH?=
 =?utf-8?B?L1pvdUJqemhhZ1MxUDFpbFIrOFhGWHpuNEZWMG9RaTg5TTZ1YmVtUE85NDVI?=
 =?utf-8?B?ckFMR1o0R21Gb1NGMEI0MTZYTW9pMGtNNVNzTG5kaXF0KzV4UkZSMS9sUXhE?=
 =?utf-8?B?TEU0U1RzNm9ONk45YWxESkVhUWllWVB1dkw3US9EVWgvSVptaVI1MStRMzZz?=
 =?utf-8?B?WkhaMWxVVjQ0TlRvM1NiY0JJRCtRM0paZ3BhbXY3N0dxaWRhdzNybE1CZUVr?=
 =?utf-8?B?SHVoT1FaZ2tQRXRNaUd4ckpaY0VBWVhYOTU1SFVPVWxmZndtVzZuZkFabmZx?=
 =?utf-8?B?RklRRVo1VlNsQk4xakcvejdOMzV6MWtqK1ZwaGVHa3NVQ0NzQU1ZVmlhZ2VZ?=
 =?utf-8?B?Mkx3eERRekdvNXV2Y2wvVVNwKzMrdWNNa0t6L0pPaWVPcXNDOEdiKzdZZ2Iw?=
 =?utf-8?B?ODlma1FFQUg3MUM2azlaV1RBOTdtYmVETkxJVnZTbG5WdnpwaEFuZVRnTjQ5?=
 =?utf-8?B?RWt3Vnk1dkVNMHh6Qm9tQ3FZZlVObnBUa2ZKYS9reXlxbEdqV0NmR1VaM1pH?=
 =?utf-8?B?NlJYb2JmU3pDbittSnJCUkFkRGpyK3gwT0R4SnZ5aFJtMHlxUmUvNTNGdzNN?=
 =?utf-8?B?U3dmRkdST3JFUytNRFdRRWZxSFhxamNXMmM4clhmZjNUcVE2dGwrcTczWW1W?=
 =?utf-8?B?UWhkemRENmEvdytidVBDWlZRVk1hL21Za254VFVqMmd6SC8rR0pvNHdjeDJU?=
 =?utf-8?B?cmY2Tll4ZnhodVcxNWlzSDRTTElFcFlpOUNYN2tUV2EzS1NzVXdhdmV2TmEx?=
 =?utf-8?B?bCtUWTVzV0gwNFBJQkVkRXhuRE5vUU5OcDB6SVZPM1hPVlo3Nkd3Tmp4Y2JZ?=
 =?utf-8?B?b0RhZ2QxNndOcWl3aFdlOVZsUDBSUHJ1ZUJ1WHlOTG9nQUh0OGdabVllTFJK?=
 =?utf-8?B?alBNOG52SFV6NnJzMXBRRE1MR0xwZWVXb2Z0L3owbTFSOFlzOXFvRmR6UmFU?=
 =?utf-8?B?Q0xLbVJ4bzVpSVZUWmVKeUNwalAyK2F2R1RjL2M1QU82YWpSVlhVeU1qQk9t?=
 =?utf-8?Q?wZr51Jfwt0frg7SISg0pjWShHC3ZosG/heS4K1f?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNPcjNkUldWT1YySEg5UmdxZm0yYUxMLzh1RmloYWorejZmWjJUQVd4YjZN?=
 =?utf-8?B?dFpkWG9FMUFNMkVqV2tFT0srY3hYR1NvSGhYbW5ua1I1S2RBWWN4T3JvWXI0?=
 =?utf-8?B?bHFTeW5lTkRYSzJYYVh2RlRqMDM2ZGZZcms1N2Y0emZHSXd4b2VjSHppekxl?=
 =?utf-8?B?UXlhOHowMlpnVkFYYUE4ZTllWElJR255elArWkpFa3JBUFRlSmk2UnU0RkZD?=
 =?utf-8?B?Tithbmo4a1l3QzdBeWdXdURCTnRXMWJTV2dydzRQb2tldVUxcnBGWmNyYjZu?=
 =?utf-8?B?bjB5Qmp0ZldEY3NjYW5GS2t0V1JPOTM2UGxxSThUZFYyeDc0YUVrRkNtUTVE?=
 =?utf-8?B?QXBFVUpRZHZsUDZTdzhxcWVQV05JUmJKWk1UcGZCdVEwbk5aN0UzSnRJRHN6?=
 =?utf-8?B?YWpLaWd6OFVNT083MTJ6a1hhVlVoRmgrVUJPRnhMbUZESklCYTlTMnF2ZjVS?=
 =?utf-8?B?ZkFnRFN0aXpzN0haNk5XMnBjR29DTml4aEQ4Y2xST2xCMnp4dEtxWUJrbHQw?=
 =?utf-8?B?eW1rNmlHVXZCMGdFYUxESGViRzQzUVY2b1FDeGI0VjMzRjZ6SkNub3dtZ3U4?=
 =?utf-8?B?QTZtYUUxSngwZktTZVFjWG1uSzA0cTZLclJUT1NPMkI3czFuS2VMTmx4Snc4?=
 =?utf-8?B?alRSWHhwZFNyVWtaQjRLOGdWaFNvU2tkRHBDOXlyZVByUUxzWTNEV0gwOG1D?=
 =?utf-8?B?OEpkc2xLRkxacHhPU0RSNWZidVpoOWJvZ0Y2end3dGdENFJrNFJ2aXEzR0FJ?=
 =?utf-8?B?UGF6OGxzK256UHpNcFZxSTdHVXM1NGJSRmJ4U0NPK2FpcW91dlZMNzBQU2t5?=
 =?utf-8?B?VHlxcHJxSkNtQ0dzcy9maWVXdmI2TkJ3d21LL3VhbXNEamZaMzIzNmd0QUI5?=
 =?utf-8?B?ZWhVZEhwWlpzZzZDSFd5aThXTEk3aENURGs2V2s2SXJycFhodkxvbEROTEZ3?=
 =?utf-8?B?a01IOWUwbkZweDlyTFluU2hVS0N4K1NLQWtiMDZhTjJWRG0vZnY2UlM4SUFt?=
 =?utf-8?B?Qkw2SkxGczNmc3krUHAxUVl5YXpNSVN0bnJtanR1NWJqT1NaUnV2a2pFeGlo?=
 =?utf-8?B?c3lVZ255Q1JRWnZoTkw1VExQb1gwSm1VempmTzNlaktKcUJpbmxGVkJyUlY4?=
 =?utf-8?B?M1NOMFM1UnU2MWdnb3pLQWRqQnhadzlUNFVzY0RnR1BWM3BKWm9OSHF2Zmtw?=
 =?utf-8?B?VzNDcGw4VGpRWEUyUkkvUGxRSlc2M0pRbHJ1WVFsSDYyRUR3UDE0T29HRTBD?=
 =?utf-8?B?UDRoY242Q2tHVTFVQWNSc3JHZWl0cFgzN01IK1VBdzFSaXkrcDM0MGZiRzlu?=
 =?utf-8?B?enZIOS92eFltQ0pMOS9PRXJzUFg0S0RVUzdOWGplYzhQYkpUZHIyWWZLUW9D?=
 =?utf-8?B?ZHYzczJNYng5R3pMVWF2b3J1eG4xdjZ4eCt6MEJhSzhwK3BjcERFbHhHRGFD?=
 =?utf-8?B?N1NRMi9Pekw0Ulc1OThjOHhiWEgwSmZzTlFZM1dwNGRuVXRKMmF6ZlpLcU1E?=
 =?utf-8?B?RFFRa3c4Tkc2OGhua055d29RRTVCMGpwMWlzZVNvdGJZOExPdzhoSmZqaFBC?=
 =?utf-8?B?dE5WQzBRMjdHb1pxM2poMXpXTU1iZTJVTmgyUEkxaEhuSzdoQzIwNVM5a3Jz?=
 =?utf-8?B?Ym12R2x0dW1qQjFHeFZ1eVNNZUpaZ0k0QUlFWDlHRUJRNVdrMmdXZFlUNlhk?=
 =?utf-8?B?SG5RRHRBaERaTjFmSVBpMkk3RDgzSnZEN1NXbTRkbW9PSUczZFE0UTdKWlBt?=
 =?utf-8?B?eWVVVmQ4M0RsTzlWdHNSYU9LTFlBMDhKUnVZYklTMit0TExrM29TTjMxMGpV?=
 =?utf-8?B?a1hlNTB2a0Q0Ykp6eTFnWkpleGRyeXlKNnptV1hBN3QvRy9xNk5vbG85U01k?=
 =?utf-8?B?eEducml3Z2NkdUtHVkFWZ1dxNkFkOHF6anUyOEs0MXRObU0xbUwvRFlYZTNz?=
 =?utf-8?B?WGc2RE5uOTFhaWl2TlhSTlR6QWJPcm15dHlBTWlWb0QyWjhFRzNjM2p5RUhl?=
 =?utf-8?B?OTlzVVpFUkR0NlVRbUhUNVhJb2w1WTdJaXpvUDhuZFBsVFBpV2xnZ2tROEpN?=
 =?utf-8?B?Nzh6aThHMXBQMjRGcDN4b256WDRqYWd4ZVh2alVmN0lYYmptQ0ljRlZaZHBQ?=
 =?utf-8?Q?T7jA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db02e159-c718-4d9e-173f-08dc942500d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 08:09:42.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03oMKNQtAy8iGdYzAS3AbW3BgGEugRwJ5d9zjQ3JC2xTr7R+hlahF8tbaSk7tSWBAlJAuFF1TDt1FwfQW4jgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
PlNlbnQ6IEZyaWRheSwgSnVuZSAyMSwgMjAyNCAxMjo0NiBQTQ0KPlRvOiBLLCBLaXJhbiA8a2ly
YW4ua0BpbnRlbC5jb20+DQo+Q2M6IFNyaXZhdHNhLCBSYXZpc2hhbmthciA8cmF2aXNoYW5rYXIu
c3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sDQo+Q2hldGhhbiA8Y2hldGhhbi50
dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBEZXZlZ293ZGEsIENoYW5kcmFzaGVrYXINCj48Y2hh
bmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPjsgU2F0aWphLCBWaWpheSA8dmlqYXkuc2F0
aWphQGludGVsLmNvbT47DQo+bGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnRpbnRlbDogQWxsb3cgbG93ZXJpbmcgb2Yg
ZHJpdmUgc3RyZW5ndGggb2YNCj5CUkkNCj4NCj5EZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlv
dSBmb3IgdGhlIHBhdGNoLg0KPg0KPg0KPkFtIDIxLjA2LjI0IHVtIDA4OjQ0IHNjaHJpZWIgS2ly
YW4gSzoNCj4+IEJSSSAoQmx1ZXRvb3RoIFJhZGlvIEludGVyZmFjZSkgdHJhZmZpYyBmcm9tIENO
VnIgdG8gQ05WaSB3YXMgZm91bmQNCj4+IGNhdXNpbmcgY3Jvc3MgdGFsayBzdGVwIGVycm9ycyB0
byBXaUZpLg0KPg0KPkludGVyZXN0aW5nLiBDYW4geW91IHBsZWFzZSBlbGFib3JhdGUgaG93IHRo
YXQgY2FuIGJlIGRldGVjdGVkPw0KDQpQYWNrZXQgZXJyb3JzIC0gIE5lZWQgc3BlY2lhbCBoYXJk
d2FyZSB0byBkZXRlY3QgdGhpcyBpc3N1ZS4NCg0KPg0KPj4gQXMgYSB3b3JrYXJvdW5kLCBkcml2
ZXIgbmVlZHMgdG8NCj4+IHJlZHVjZSB0aGUgZHJpdmUgc3RyZW5ndGggb2YgQlJJLiBEdXJpbmcg
KnNldHVwKiwgZHJpdmVyIHJlYWRzIHRoZQ0KPj4gZHJpdmUgc3RyZW5ndGggdmFsdWUgZnJvbSBl
ZmkgdmFyaWFibGUgYW5kIHBhc3NlcyBpdCBjb250cm9sbGVyIHZpYQ0KPj4gdmVuZG9yDQo+DQo+
V2hlcmUgaXMgdGhpcyBFRkkgdmFyaWFibGUgZGVzY3JpYmVkPw0KaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC8vdjUuMTMvZmlsZXN5c3RlbXMvZWZpdmFyZnMuaHRtbA0KDQo+DQo+4oCm
IHBhc3NlcyBpdCAqdG8gdGhlKiBjb250cm9sbGVyIOKApg0KQWNrLg0KDQo+DQo+PiBzcGVjaWZp
YyBjb21tYW5kIHdpdGggb3Bjb2RlIDB4ZmMwYS4NCj4NCj5QbGVhc2UgZG9jdW1lbnQgeW91ciB0
ZXN0IHN5c3RlbSBhbmQgYWxzbyBhZGQgdGhlIG5ldyBsb2cgbWVzc2FnZXMuDQpBY2suDQoNCj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgfCAxMTQNCj4rKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDExNCBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gaW5kZXggNWQ3MzUzOTE1NDVhLi4zZGM1NTdh
YWM0M2QgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4+ICsr
KyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gQEAgLTEyLDYgKzEyLDggQEANCj4+
ICAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4+ICAgI2luY2x1ZGUgPGFjcGkvYWNwaV9idXMu
aD4NCj4+ICAgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgv
ZWZpLmg+DQo+PiArDQo+Pg0KPj4gICAjaW5jbHVkZSA8bmV0L2JsdWV0b290aC9ibHVldG9vdGgu
aD4NCj4+ICAgI2luY2x1ZGUgPG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuaD4NCj4+IEBAIC00OSw2
ICs1MSwzOCBAQCBzdGF0aWMgY29uc3QgZ3VpZF90IGJ0aW50ZWxfZ3VpZF9kc20gPQ0KPj4gICAJ
R1VJRF9JTklUKDB4YWExMGY0ZTAsIDB4ODFhYywgMHg0MjMzLA0KPj4gICAJCSAgMHhhYiwgMHhm
NiwgMHgzYiwgMHgyYSwgMHhjNSwgMHgwZSwgMHgyOCwgMHhkOSk7DQo+Pg0KPj4gK3N0YXRpYyB2
b2lkICpidGludGVsX3VlZmlfZ2V0X3ZhcmlhYmxlKGVmaV9jaGFyMTZfdCAqbmFtZSwgZWZpX2d1
aWRfdA0KPj4gKypndWlkKSB7DQo+PiArCXZvaWQgKmRhdGE7DQo+PiArCWVmaV9zdGF0dXNfdCBz
dGF0dXM7DQo+PiArCXNpemVfdCBkYXRhX3NpemUgPSAwOw0KPj4gKw0KPj4gKwlpZiAoIUlTX0VO
QUJMRUQoQ09ORklHX0VGSSkpDQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRU9QTk9UU1VQUCk7DQo+
PiArDQo+PiArCWlmICghZWZpX3J0X3NlcnZpY2VzX3N1cHBvcnRlZChFRklfUlRfU1VQUE9SVEVE
X0dFVF9WQVJJQUJMRSkpDQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRU9QTk9UU1VQUCk7DQo+PiAr
DQo+PiArCXN0YXR1cyA9IGVmaS5nZXRfdmFyaWFibGUobmFtZSwgZ3VpZCwgTlVMTCwgJmRhdGFf
c2l6ZSwgTlVMTCk7DQo+PiArDQo+PiArCWlmIChzdGF0dXMgIT0gRUZJX0JVRkZFUl9UT09fU01B
TEwgfHwgIWRhdGFfc2l6ZSkNCj4+ICsJCXJldHVybiBFUlJfUFRSKC1FSU8pOw0KPj4gKw0KPj4g
KwlkYXRhID0ga21hbGxvYyhkYXRhX3NpemUsIEdGUF9LRVJORUwpOw0KPj4gKw0KPj4gKwlpZiAo
IWRhdGEpDQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4+ICsNCj4+ICsJc3RhdHVz
ID0gZWZpLmdldF92YXJpYWJsZShuYW1lLCBndWlkLCBOVUxMLCAmZGF0YV9zaXplLCBkYXRhKTsN
Cj4+ICsNCj4+ICsJaWYgKHN0YXR1cyAhPSBFRklfU1VDQ0VTUykgew0KPj4gKwkJa2ZyZWUoZGF0
YSk7DQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRU5YSU8pOw0KPj4gKwl9DQo+PiArDQo+PiArCXJl
dHVybiBkYXRhOw0KPj4gK30NCj4+ICsNCj4+ICAgaW50IGJ0aW50ZWxfY2hlY2tfYmRhZGRyKHN0
cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgaGNpX3JwX3JlYWRfYmRf
YWRkciAqYmRhOw0KPj4gQEAgLTI2MTUsNiArMjY0OSw4MCBAQCBzdGF0aWMgdTggYnRpbnRlbF9j
bGFzc2lmeV9wa3RfdHlwZShzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KPj4gICAJcmV0dXJuIGhjaV9za2JfcGt0X3R5cGUoc2tiKTsNCj4+ICAgfQ0KPj4NCj4+
ICtzdGF0aWMgaW50IGJ0aW50ZWxfc2V0X2RzYnIoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVj
dA0KPj4gK2ludGVsX3ZlcnNpb25fdGx2ICp2ZXIpDQo+DQo+QWRkIGEgY29tbWVudCwgd2hhdCBk
c2JyIGlzPw0KQWNrLg0KDQo+DQo+PiArew0KPj4gKwlzdHJ1Y3QgYnRpbnRlbF9kc2JyX2NtZCB7
DQo+PiArCQl1OCBlbmFibGU7DQo+PiArCQl1OCBkc2JyOw0KPj4gKwl9IF9fcGFja2VkOw0KPj4g
Kw0KPj4gKwlzdHJ1Y3QgYnRpbnRlbF9kc2JyIHsNCj4+ICsJCXU4IGhlYWRlcjsNCj4+ICsJCXUz
MiBkc2JyOw0KPj4gKwl9IF9fcGFja2VkOw0KPj4gKw0KPj4gKwlzdHJ1Y3QgYnRpbnRlbF9kc2Jy
ICpkc2JyOw0KPj4gKwlzdHJ1Y3QgYnRpbnRlbF9kc2JyX2NtZCBjbWQ7DQo+PiArCXN0cnVjdCBz
a19idWZmICpza2I7DQo+PiArCXU4IHN0YXR1czsNCj4+ICsJZWZpX2d1aWRfdCBndWlkID0gRUZJ
X0dVSUQoMHhlNjVkODg4NCwgMHhkNGFmLCAweDRiMjAsIDB4OGQsIDB4MDMsDQo+PiArCQkJCSAg
IDB4NzcsIDB4MmUsIDB4Y2MsIDB4M2QsIDB4YTUsIDB4MzEpOw0KPj4gKw0KPj4gKwltZW1zZXQo
JmNtZCwgMCwgc2l6ZW9mKGNtZCkpOw0KPj4gKwlkc2JyID0gYnRpbnRlbF91ZWZpX2dldF92YXJp
YWJsZShMIlVlZmlDbnZDb21tb25EU0JSIiwgJmd1aWQpOw0KPj4gKwlpZiAoSVNfRVJSKGRzYnIp
KSB7DQo+PiArCQkvKiBJZiBlZmkgdmFyaWFibGUgaXMgbm90IHByZXNlbnQsIGRyaXZlciBzdGls
bCBuZWVkcyB0byBzZW5kDQo+PiArCQkgKiAweGZjMGEgY29tbWFuZCB3aXRoIGRlZmF1bHQgdmFs
dWVzDQo+PiArCQkgKi8NCj4+ICsJCWJ0X2Rldl9kYmcoaGRldiwgIkVycm9yIHJlYWRpbmcgZWZp
IERTQlIgKCVsZCkiLA0KPg0KPk1heWJlOiBFcnJvciByZWFkaW5nIEVGSSB2YXJpYWJsZSBVZWZp
Q252Q29tbW9uRFNCUiAoJWxkKQ0KQWNrLg0KDQo+DQo+PiArCQkJICAgUFRSX0VSUihkc2JyKSk7
DQo+PiArCQlkc2JyID0gTlVMTDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoZHNicikgew0KPj4g
KwkJLyogYml0MDogMCAtIFVzZSBmaXJtd2FyZSBkZWZhdWx0IHZhbHVlDQo+PiArCQkgKiAgICAg
ICAxIC0gT3ZlcnJpZGUgZmlybXdhcmUgdmFsdWUNCj4+ICsJCSAqIGJpdDM6MSAtIFJlc2VydmVk
DQo+PiArCQkgKiBiaXQ3OjQgLSBEU0JSIG92ZXJyaWRlIHZhbHVlcw0KPj4gKwkJICogYnQzMTo3
IC0gUmVzZXJ2ZWQNCj4+ICsJCSAqLw0KPj4gKwkJY21kLmVuYWJsZSA9IGRzYnItPmRzYnIgJiBC
SVQoMCk7DQo+PiArCQlpZiAoY21kLmVuYWJsZSkNCj4+ICsJCQljbWQuZHNiciA9IGRzYnItPmRz
YnIgPj4gNCAmIDB4RjsNCj4+ICsJCWtmcmVlKGRzYnIpOw0KPj4gKwl9DQo+PiArDQo+PiArCWJ0
X2Rldl9pbmZvKGhkZXYsICJkc2JyOiBlbmFibGVkOiAweCUyLjJ4IHZhbHVlOiAweCUyLjJ4IiwN
Cj5jbWQuZW5hYmxlLA0KPj4gKwkJICAgIGNtZC5kc2JyKTsNCj4+ICsNCj4+ICsJc2tiID0gX19o
Y2lfY21kX3N5bmMoaGRldiwgMHhmYzBhLCBzaXplb2YoY21kKSwgJmNtZCwNCj5IQ0lfQ01EX1RJ
TUVPVVQpOw0KPj4gKwlpZiAoSVNfRVJSKHNrYikpIHsNCj4+ICsJCWJ0X2Rldl9lcnIoaGRldiwg
IkZhaWxlZCB0byBzZW5kIEludGVsIERTQlIgY29tbWFuZCAoJWxkKSIsDQo+PiArCQkJICAgUFRS
X0VSUihza2IpKTsNCj4+ICsJCXJldHVybiAtYnRfdG9fZXJybm8oUFRSX0VSUihza2IpKTsNCj4+
ICsJfQ0KPj4gKw0KPj4gKwlzdGF0dXMgPSBza2ItPmRhdGFbMF07DQo+PiArCWtmcmVlX3NrYihz
a2IpOw0KPj4gKw0KPj4gKwlpZiAoc3RhdHVzKSB7DQo+PiArCQlidF9kZXZfZXJyKGhkZXYsICJT
ZXQgRFNCUiBmYWlsZWQgMHglMi4yeCIsIHN0YXR1cyk7DQo+PiArCQlyZXR1cm4gLWJ0X3RvX2Vy
cm5vKHN0YXR1cyk7DQo+PiArCX0NCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgYnRpbnRlbF9hcHBseV9kc2JyKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPj4gKwkJ
CSAgICAgIHN0cnVjdCBpbnRlbF92ZXJzaW9uX3RsdiAqdmVyKSB7DQo+PiArCS8qIEZvciBCbGF6
YXJJICsgQjAgc3RlcCwgRFNCUiBjb21tYW5kIG5lZWRzIHRvIGJlIHNlbnQganVzdCBhZnRlcg0K
Pj4gKwkgKiBkb3dubG9hZGluZyBJTUwgZmlybXdhcmUNCj4NCj5BZGQgdGhlIHNlY3Rpb24gb2Yg
dGhlIGRhdGFzaGVldD8NCj4NCj4+ICsJICovDQo+PiArCXJldHVybiB2ZXItPmltZ190eXBlID09
IEJUSU5URUxfSU1HX0lNTCAmJg0KPj4gKwkJKCh2ZXItPmNudmlfdG9wICYgMHhmZmYpID09IEJU
SU5URUxfQ05WSV9CTEFaQVJJKSAmJg0KPj4gKwkJSU5URUxfQ05WWF9UT1BfU1RFUCh2ZXItPmNu
dmlfdG9wKSA9PSAweDAxOyB9DQo+PiArDQo+PiAgIGludCBidGludGVsX2Jvb3Rsb2FkZXJfc2V0
dXBfdGx2KHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPj4gICAJCQkJIHN0cnVjdCBpbnRlbF92ZXJz
aW9uX3RsdiAqdmVyKQ0KPj4gICB7DQo+PiBAQCAtMjY0OSw2ICsyNzU3LDEyIEBAIGludCBidGlu
dGVsX2Jvb3Rsb2FkZXJfc2V0dXBfdGx2KHN0cnVjdCBoY2lfZGV2DQo+KmhkZXYsDQo+PiAgIAlp
ZiAoZXJyKQ0KPj4gICAJCXJldHVybiBlcnI7DQo+Pg0KPj4gKwlpZiAoYnRpbnRlbF9hcHBseV9k
c2JyKGhkZXYsIHZlcikpIHsNCj4+ICsJCWVyciA9IGJ0aW50ZWxfc2V0X2RzYnIoaGRldiwgdmVy
KTsNCj4+ICsJCWlmIChlcnIpDQo+PiArCQkJcmV0dXJuIGVycjsNCj4+ICsJfQ0KPj4gKw0KPj4g
ICAJLyogSWYgaW1hZ2UgdHlwZSByZXR1cm5lZCBpcyBCVElOVEVMX0lNR19JTUwsIHRoZW4gY29u
dHJvbGxlcg0KPnN1cHBvcnRzDQo+PiAgIAkgKiBpbnRlcm1lZGlhZSBsb2FkZXIgaW1hZ2UNCj4+
ICAgCSAqLw0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClRoYW5rcywNCktpcmFu
DQoNCg==
