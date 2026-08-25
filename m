Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31733372A
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677329; cv=fail; b=EdR8XNmAgxX6TxDHldQ9tTwyUidTt/CbNbhn8tjlQt1NC00KW8MneJQsXeLOQZAHlMn5rUtQIu2naOU+Fmr/JwZ9jrPxInmxqBMpO4i8DiNE1gKwXO59GZgJDIZIwzc6DohqBYlDPce2jfkU1Tjrqu/fJRXVsdL+V8KrnUzQ5nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677329; c=relaxed/simple;
	bh=dCVWEwqBsR3lVtHbhBL4Blza4pMc/RmTmRyJLD/oEco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3Ly5xIBLwkKjjyEN6Eg0VU1bhwTOb2P2g+HivL8uliz47OdwruOCiPh8gZ+JqQuPpkGj3ifqgjrJKNp/T4P7DZk0UxBTjFuLqjS9Oy3vEY4Hfq49N5w9/YKtUjYQak/Gt8BWiVRWEahPPbaMAVf+yLlOHAgCTADZLBOvMJl2Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTPuUzkW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTPuUzkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787677328; x=1819213328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dCVWEwqBsR3lVtHbhBL4Blza4pMc/RmTmRyJLD/oEco=;
  b=mTPuUzkWmJCF0oGeFJS2CMYnV72oa9/twfZsFVGUHYkunTs+MHi2Vfyz
   RWG5OX1VCtgcXjowh1CFgP/oPI80ale+EoQvQPCuz6wlmG2CERayfGh+T
   iJ7h1DTaOvJKmHzNfcoHplqnhEmNPAhl6lmm7nZcmmGuMmxLx8HxMjIpB
   6kCgQe1VHxNtcCPV1/FfHNuDeGUovoVgfAAm4WwdXDPS2eqwIug0IQPPT
   FJWTrsC7RnE1bXy9KjpOJMsYju3+EC3JJl2qFyD38D4ziktgxn69rr4eR
   RezhUA3hL90a92Tqw2TDIGc35b1QwzEN1WW0lJQQuN1Sic/cqqr9K1whD
   g==;
X-CSE-ConnectionGUID: QOuTGOv2TVm5QZRd9tETGw==
X-CSE-MsgGUID: BLWyVfSrTKKNSFP395KYQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="113687023"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="113687023"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:02:07 -0700
X-CSE-ConnectionGUID: 5R44fgiUScqk2LlfA73H1Q==
X-CSE-MsgGUID: 0HLToxL6RdCgh0BUYkHGzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="271541035"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:02:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 10:02:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 10:02:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 10:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahg0cRKd7rOj+o54I/AGKazcb2fUltV0K50oFbCilFiNHvXlxKFdkBdWe/QlP7G6aFiTZHqeL7y1b+Q7G1ISBKL9LDz/ATSTB8cTY4g1ropZF9aMHtsu3NdnG/41Fz5p5IM84suBRg9QI4O2jhyqeK5gkLCQRksNgg0U20h+Pmpps74C42xdq6Frt7j5aMf69X+WQpJ/YSBGF8pydmqgXm6Y6XV/kRMUgsSutQAqRbe9PiRVajks6p4WkZ1VzX70tfP2cgJMx8EMR0BRcDDRm1FLBClE0bDgt8RCj0srzwMzdtLqU+B+AL2e+lVlqZvb4AZzLIsOa+FFcUlyF6AQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCVWEwqBsR3lVtHbhBL4Blza4pMc/RmTmRyJLD/oEco=;
 b=y47VrCLGCUra4pglK6f6Nzfh4CdfUEwocBI9C+dL8ZKjQyB/USyjSWbPok3ZYuiUjmzV2wqBTpWlfiDnu6Eot8D1zAnaymzSk6V5sNWZddbaMxzuj0es23k3I4DC+f1+dEDdDtefseHzXk07gYKXR8ATeyhqka1HU9b0CCbN8UtaRIZrkvcXJvN2gThr8lXvaiLLwxXnTwkvOYjlQAKufK5py5QKXXW/Y6lQToFeuXcyJ93kE+Roy6Vl0xJkcDcldNzyKbqFQYtj3lwDtM3gLGU4wEDORArx1yNPrMDEE7VcdI3dKJqHLT0jHtsb+bgEoHVouIdzi16rg6pZM7Mtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DSWPR11MB9737.namprd11.prod.outlook.com (2603:10b6:8:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:01:58 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 17:01:58 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Clear automask on spurious
 interrupts
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Clear automask on spurious
 interrupts
Thread-Index: AQHdNKuIMg3E8LWNyUqUGifw9PnUILau74UAgAANsCA=
Date: Tue, 25 Aug 2026 17:01:58 +0000
Message-ID: <PH0PR11MB75856FADF37AFA1EEE8D7B7EF5AF2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260825162512.143965-1-kiran.k@intel.com>
 <CABBYNZJSHpX_GD9gg8SP1BmDW8tWCXcW1aS5aCOXcEZp-0Kr1g@mail.gmail.com>
In-Reply-To: <CABBYNZJSHpX_GD9gg8SP1BmDW8tWCXcW1aS5aCOXcEZp-0Kr1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DSWPR11MB9737:EE_
x-ms-office365-filtering-correlation-id: dde94868-a0c6-4643-a439-08df02ca9354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: Tywrd29ItTlIT14hFrJHAWWlgoO0kW0ZbhKtoNOGEeJltYB9TM7NNJSF+fh0mypRUW0FsCqLVL4z6fwTJjNQHxuw3YxkUenq+flfZ8WJK8gIJsM1u2ed96reh56QsvKgbk0PAQnt5OznGPResKXnlH9dhK0zSuvOv6hw3FPyHe914EWY14Sib17pke95/VxCe54+rifwhsEBWo0uFx/pORonJSPMFmSV7429/pAKnnqmHQESFgnYrhlxcJuvPxLJxIWgRNsXK+Jb7RN5pdmWSaQ90p5p0RYZ5KheID4KfdA/KnNj7Qr0h9pEuE0GNL1tHNQPM0P6BSC1kDRrMuwMhzrrIIUQYTvJ9tuFW9Ih+L94iXZ6q44XdGZ3uORxb5zdPWbez7OjOAqz2XtYgNHzRstKo3ptT//B0uZ7yKh55jxQYycKT5+KN8i+2Z38ZZr3dmElgOU120KJ7hEyonnl9UHKwcdQA1Q3kcaRZAfHpYGi7TzqrT6oGeqIeXNSO8dslVp8aj6Xq8LfvI3IEL8e58YxFOUB9GOWX//vw752UWY3kNVqbqVZBan+A0oVSViwLtPvftI8J7euSFMcoc17aeJXBXWpaOUAjhKAT+ud+/Nr9MjRAJWP9lWp4iv7rBdcCgloI2gaygo1i2zuXSfKd6UOaI3sHSEQeJO9l89oOQFbp14NjzTNJHXQwly+x0q+Cd+ZcQygoK7Z8NOqzxPm4ouZhnHTw5F3gQCwoU+zgfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFNGSTJjMy92Q3M1bmFvWCswU3gzY2JjZGtHd25tZEd1V0gvZjNBQnVkUHIy?=
 =?utf-8?B?dllBc2owNzUxVjMxK0YxQUMrR1YwRHU3VFhCam5IMU5peWI0MUw2by82QWpB?=
 =?utf-8?B?MTNuclRCR0FRN3FiRDR3QlpXWGFlc1BqZ0JmazJEdUk5SFdjU09XOFNNOFp3?=
 =?utf-8?B?NE5NRDZRM3pDTG5BQkJxdjdZb0dwbS93NmR5K2xmMWpyUEZrZlZRbldkMmtU?=
 =?utf-8?B?RytjdkhvcnlzWVo2a2JKRDJjZCs3bEI3ZlBab0xKVnovbFhmYjZJaHdTOW1M?=
 =?utf-8?B?WjQ0UDdqQ0NPSVQwUU9nOHVMQzFUeW0yRFAzOVpHTlMvYU12Um5PTkg5SnRN?=
 =?utf-8?B?R1pEZFJRTFNnYVIzZVcrNktsYnkyM1ZnVmV5ejFsRU1jOXlSZVlxVlduSGt5?=
 =?utf-8?B?SXhqUWx2SjRWNTZRWjQ2bXE4NzdnYktlaC9MR1N6NGFmbXNlRVBpdXQ0TC9G?=
 =?utf-8?B?dDZIVm94eHo3NUQ3a3lQTmZBcVduMUhJZDVxOWRQSDY4bllwM2MweGhMbjZq?=
 =?utf-8?B?Q3RjRDhNY3hYVUxjN01qZUJlYmFTMnh3NmFXMG82SDZLUXg5M0xiaHYzS0xh?=
 =?utf-8?B?emdUOWFNNlRhZHg0bVJyWWRxSUVaakxPZUx0MGxtVGszYjlTQ0JQSkVVZnR2?=
 =?utf-8?B?dVM2OVRPazM5VFZnSGljZ25PeUpZQ3B6UU02MjBxanFkcEtLMmtRMU0vVzdR?=
 =?utf-8?B?VXJuUTZQUnNLNEs1bnYxRXp1VU80cU1HSnVLUVEyQzBXL08vVlR3d2g2OEJY?=
 =?utf-8?B?TEc4dHlyeC9BRklxZTJCejdiKzVnc1N2SkphTE9Sd3RGc0hkWHJqbkRyaEMw?=
 =?utf-8?B?UUQxUUx6ZVhuV2RZczYya29BUkV5NEZlV2JhcFhMZm5nSXFTbjVWT1JCNTRD?=
 =?utf-8?B?M2tyakQvYjBuSVRnT2lNc3VzcTI2Vm40dmhFRGdUNGtiNnpkc0hTdWxkR2JY?=
 =?utf-8?B?aEpHTHl4OTlGdmRKQVZ0WTVLRk9hcDBHRC8rRTFMak5XdUlmdCttTGFRSWRx?=
 =?utf-8?B?aGxFU3VZMDVrUm95ZDkyNWNjeWJvUWl5TkJJWERucHRVbXdsemo2azZHaGFY?=
 =?utf-8?B?eUFITG05T3JQZjErbmR4WVFqcUQrQmtrSDUzM2xRaUZTVGNyTXp5NTZjR1kv?=
 =?utf-8?B?OE4yNlJ0UXk0eDBUdWtTOW5HVHBNT3ZucEhGSlVTUEZQVkRwa2hQaVlqaVF1?=
 =?utf-8?B?TGhUMnpZTitob2VDMjdubGV0VVZZWXpkQndYOWs3T2QremlsaXYwbklVWDBW?=
 =?utf-8?B?ZmxTQU1LbWtxNHk2bk1PNGZoQVpNUmlJWmM4bTNHYi9VYktUVVc5Y1lxeWJa?=
 =?utf-8?B?V0RzajA0aGpBN3JhNXdCcHM3cVUzODRySXZVUnd0VFVSb05sY0JoMnVCMVVO?=
 =?utf-8?B?Z1ZGRWsyd0ZQdmpTTGxMckYyQnA3T2NnSUltV2o3OVNvajJ5NWs2cnBMU3dl?=
 =?utf-8?B?Q0YydDd5ZWxWWTV2bDJCYXBQQnYzMEFtL0VtS0hiR1BPWXgzbHRaOFRBZkVi?=
 =?utf-8?B?d3ljaDJzM1F5WlRvQXVETXV3WkhXVWlxMzB2YzdobFR3eGxwMWUzbHUrV3Bk?=
 =?utf-8?B?dThpNDVuZWlrYnhMTHNLUlh1SXRmRUxMNEJOaytPMklxMWpCbW5RZWlSdFNT?=
 =?utf-8?B?QkRQZzQzVEpGUGZiM0U0NVhMVHgzTVBmZUVZaXpJZ09ZaVNlR0FPQ0xPUElx?=
 =?utf-8?B?NlBFeVBDb0VwUGZEeStTOWpFa21USDk3MEZJR0pVazBPVGJha1FvOHUvSDdy?=
 =?utf-8?B?cnZGYkV0RkZUVmNwRXExR2RPTG1JUmtrcWljNThmZHNjaE5tUkEvUkc4bEdl?=
 =?utf-8?B?YVhCNEdUcGJtM0tTaE1kOGRMM1A3dVp0eXB6TjlOU08xTUJjbmlpRWRTdnNV?=
 =?utf-8?B?aGZDdkhLQ1dpbmFYeUxQcjc4Y1NYcjhwa2JudUtyR0UySU1zaWtYNW1BMmZw?=
 =?utf-8?B?Znp4dTZXOGxOcXJxenBOU0N5cnNqNE15YWVld0hLaDY4c2JpRi8wd3ZXOHlN?=
 =?utf-8?B?dGQ0RXkyNHpldVlrRkhteWIyRHNNbWJWNjZESFBuU2k3aUl0RnA0ZzJWWmU2?=
 =?utf-8?B?Tjlvb01wdWJEYTdLWlBabXBIbnpBVklEaXcxVzVCdkdiWmovRDNTeExoRWR2?=
 =?utf-8?B?aTlPSXExNWxOaGU3TjZiQjdSTGkvbEUzanh0NTI5dGVCVVQxcHVIMEc0RkJo?=
 =?utf-8?B?ZTFWaUdqbUNlRGNUMDNHV3g3SnhEb0VEc3dOZVl4QUZjR2tDUHduWFJwSkVU?=
 =?utf-8?B?NW94a3VSUUdPdWFEd2M3aUVIellJSzA4ckdPdjlRWWYvcWVnN3djd29oRXRv?=
 =?utf-8?Q?+gLtIIq6Ys6BilyI/j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TkgWJLSMrxxYC8oTfOtguuIdt9fze4POjyHPM/oKXysAg8HZmKnCDS2OxbwZPXpT+n03xHO6htm3sy9EHY2VzH5vK7b7U/aPDJ2JiDgidWLA1XqnXUlZ/m7Wuz7Yln1w5hM0WExq+4EhuZ77m+YWTl+WfeYrYZU0FW1UmlhxuvhnhRS02tT0EM8SHOBaM3io9d55GpqGV+RVLsaMtMYfThUM0erWColpvBz5i3VrcRUW7MOcFYFxol3I6MiihMI85xHNW4TgBYEa0eoLxA+JAd6AkcDl0pJqXlbdllHt32BYJpDFPsUQDcz9RvyywB9J5oLM4/X3kFTGV/mQLAis3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde94868-a0c6-4643-a439-08df02ca9354
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 17:01:58.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dkc94KruSGK5//paY0+sXTo5b67Dr1nUmcZyy2+lzeM7vLRhzldh8s0OC8BjUAxMegw27sNQGNf/V6C8CvWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9737
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogQ2xlYXIgYXV0b21hc2sgb24gc3B1cmlv
dXMNCj5pbnRlcnJ1cHRzDQo+DQo+SGkgS2lyYW4sDQo+DQo+T24gVHVlLCBBdWcgMjUsIDIwMjYg
YXQgMTI6MDbigK9QTSBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
T24gc3B1cmlvdXMgaW50ZXJydXB0IHdoZXJlIHRoZSBUWCBhbmQgUlggY2F1c2VzIGFyZSBub3Qg
c2V0LCBkcml2ZXIgd2FzDQo+PiBub3QgY2xlYXJpbmcgdGhlIGF1dG8gbWFzayB3aGljaCBjYW4g
YmxvY2sgYWxsIHRoZSBpbnRlcnJ1cHRzLiBEcml2ZXINCj4+IG5lZWRzIHRvIGNsZWFyIHRoZSBh
dXRvbWFzayBldmVuIGlmIG5vIGNhdXNlcyBhcmUgc2V0Lg0KPg0KPkFyZW4ndCB3ZSBtaXNzaW5n
IHRoZSBmaXhlcyB0YWcgaGVyZT8gVGhpcyBsb29rcyBsaWtlIGEgY2FuZGlkYXRlIGZvcg0KPmJh
Y2twb3J0LCByaWdodD8NCkFjay4gSSB3aWxsIGFkZCB0aGUgZml4ZXMgdGFnIGluIHYyIHZlcnNp
b24gb2YgdGhlIHBhdGNoLg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0Bp
bnRlbC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8
IDMgKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCBiYWE2MjFiM2ZlZjkuLjMwOTIzZWFhYmVkNyAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiArKysg
Yi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gQEAgLTIwNTEsNiArMjA1MSw5
IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBidGludGVsX3BjaWVfaXJxX21zaXhfaGFuZGxlcihpbnQN
Cj5pcnEsIHZvaWQgKmRldl9pZCkNCj4+DQo+PiAgICAgICAgIGlmICh1bmxpa2VseSghKGludHJf
ZmggfCBpbnRyX2h3KSkpIHsNCj4+ICAgICAgICAgICAgICAgICAvKiBJZ25vcmUgaW50ZXJydXB0
LCBpbnRhID09IDAgKi8NCj4+ICsgICAgICAgICAgICAgICBidF93YXJuX3JhdGVsaW1pdGVkKCJC
bHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogUmVjZWl2ZWQgc3B1cmlvdXMNCj5pbnRlcnJ1cHRcbiIp
Ow0KPj4gKyAgICAgICAgICAgICAgIGJ0aW50ZWxfcGNpZV93cl9yZWczMihkYXRhLA0KPkJUSU5U
RUxfUENJRV9DU1JfTVNJWF9BVVRPTUFTS19TVCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQklUKGVudHJ5LT5lbnRyeSkpOw0KPj4gICAgICAgICAgICAgICAgIHJl
dHVybiBJUlFfTk9ORTsNCj4+ICAgICAgICAgfQ0KPj4NCj4+IC0tDQo+PiAyLjU0LjANCj4+DQo+
Pg0KPg0KPg0KPi0tDQo+THVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQpSZWdhcmRzLA0KS2lyYW4N
Cg0K
