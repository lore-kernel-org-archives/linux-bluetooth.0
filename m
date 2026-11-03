Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697086;
	b=onUaAyPavrvGI8fUpHTRpW/f18D72Wi9J0ybb1OAwaf62PbL1KZ3v36771qV9HcQ8Mk/
	 YS5hdpa/3gf+DJqGAmpr5WO2ErC+ORj3h7sUkT/P3iw42vz587G4vojCFiU4KBEHl1Lkp
	 zbVXjQxNwlKudArM7e/RhSZLt2IyLNIw8TGQDL5SVAPvBht61PRvA0Y7ZEDqJawZDTVaf
	 KzgorjrIsaM3P3VsfvR/ctNs8bu/hq/C2yuKPGJeMYApPzmBOMmYtmHAj22JAMp9PTuwf
	 ouuWJt345YzkMugCErAwshSlLYExE4j8d6VfkKto1sjB58uOgWvYFAuFjbJ45/oGLNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697086;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ngOfrUI6zw4G6QzQyxWQ/EH7+OAaCOVamWhj/UNB5V4=;
	b=uNVJJkAOrS6qOz+AwDOmItmuGTzJvI/O+4O2H8V0kFXdGG0u4MZyybBpTGGcl1mtME93
	 XX4fEsPJIK0z989EmcWAKGCNw826PQd8gN7ZIjOUE3QKH08EddkFgMO0L/HkRN+/saT3p
	 2erdr1Pj1nwFIuxwIBbT4pcOfPsccM6WaaNgglJXbyRzbA2r+A003ubhrJmvOnF9gfcM6
	 /Of6a0VNulfNZbhXcaWWT2BfKEazwm9GxLK6cwWO+qv8hx6Zb9x/Qzrw4fS70Pla9n8lV
	 U6/mh0oA0nwrxp7Ram7yUcSNMEo2UsJR3y5w/b/AZI9At5Zr/e74voHV3RFOt2T+ffA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNvxBTGt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84322606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 09:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84322606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNvxBTGt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793697085; x=1825233085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ngOfrUI6zw4G6QzQyxWQ/EH7+OAaCOVamWhj/UNB5V4=;
  b=kNvxBTGtud8YvwstCEMs57zFJH9go9cCP3fXiy3EcDmeMgYIw3UxX6xo
   /F8lOGsAenqyjgKst2FJqzypTcaSAsULHe9Jbw4sA+hiIcBTOl4ZU7zKG
   HyPR5maBgTzaL/v6WVuPa4x3weukq9HpbAzL9u/fuyC3lq37fAYcf9wrS
   /R5gxxELy1QMmhyJaD84yJ5Swi2zHx5bQLM7IbP5SHhaaOMpG4tkU2+iO
   WtSCBgQ17Y21ZK4duaNGGB5k+G6fHlqzT7UsqbKhWMlpnkvNSEH6YEXQa
   95sbripoNd+4O1fJWPE6C/LVSJkRcYBUOogh+FkMUFzcX+VHUvzR4DE8b
   g==;
X-CSE-ConnectionGUID: X+gz3L2qR9SUpHjrzNwFNw==
X-CSE-MsgGUID: cAHldmMVRZa3DErGNxAQAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2292566"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2292566"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:10:08 -0800
X-CSE-ConnectionGUID: X6OVgcaLS+2pKgyX2+747Q==
X-CSE-MsgGUID: mjQugLQ3TMmzbO+igXWGBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6711784"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:10:08 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 01:10:08 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 01:10:08 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 01:10:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qclbxGUKn61l1nUSIlaaEPfvUOSCy0+NtAdsbuaSxlEz2zQp4lXqyl2Nbxa071OfYNFIDhI4uWDdAvvo1Rs9JFkR6QPqgIG7YF89uDFV5Jl+ri0RyLbGrlbCioBwijm/NfQN4iv1ofqZNpwQv9jOUuOYL0+FP+sVxgZVavHF52uJmmgTIFm578s2roqcI3QEqMeaLnL1W4h0+lb5MA1519Lh2T21o6TBPQCQw9HwAzi8lGFVknhSKWB4oqiNGwj8Ay0hxj+KBy2Y57GrG9X4uc4tWireyB1quPp3MsK9bMOIy6yzlicVxucUE6fAbT8MLzmgdskIe63894c0kQDm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngOfrUI6zw4G6QzQyxWQ/EH7+OAaCOVamWhj/UNB5V4=;
 b=xg2X1vDXcysah0bSQnwxaAE0Z7E5WFSTxT0WQNObR3+zB1Z9RTc5bJnKE8yvp9HhuCmD/RBVyuQKWi/fMXt7pTPKRMfs7W3+jn5Gjq7e7APT0fn7QMpjOJqxWuEuX2ekzzuLnpRNVN8cTuaPEb2YOxxDZ7HGWV/osUeJIv5pZZF036r1C5COHXwQaSv2KItm+RL2d+ZEVnJlz/96hNJA/YaZzvcGZABKxdHaluBp/s7k3VmRMDeT3jRq3czViDDK99NDppZkMNeXS5ep5pVkyKTz2vuMxaizXP6/qc+Mr8tfXVY6YtSBl1QPl3TklhFw16YTbjCvfEbj+jG68jOEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6243.namprd11.prod.outlook.com (2603:10b6:208:3e7::8)
 by FT1PR11MB837409.namprd11.prod.outlook.com (2603:10b6:170:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:10:06 +0000
Received: from IA1PR11MB6243.namprd11.prod.outlook.com
 ([fe80::55b9:7dc8:2496:bca8]) by IA1PR11MB6243.namprd11.prod.outlook.com
 ([fe80::55b9:7dc8:2496:bca8%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 09:10:05 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Set MAC_INIT in
 get_mac_access()
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Set MAC_INIT in
 get_mac_access()
Thread-Index: AQHdaHg+wLIKw/a4nUqJGDk8A8ATeLcWbFUAgAWmg3A=
Date: Tue, 3 Nov 2026 09:10:05 +0000
Message-ID: <IA1PR11MB62431A38F0DAE74B16089B23F5692@IA1PR11MB6243.namprd11.prod.outlook.com>
References: <20261030142907.139369-1-kiran.k@intel.com>
 <d10df07d-03fe-446a-b462-0d956ced4e8a@molgen.mpg.de>
In-Reply-To: <d10df07d-03fe-446a-b462-0d956ced4e8a@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6243:EE_|FT1PR11MB837409:EE_
x-ms-office365-filtering-correlation-id: e7d55e49-dd95-4c65-e77f-08df398a4068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|261102123227099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261009223027099003;
x-microsoft-antispam-message-info: eAVRYrH3f2fC+k/8tDVszs8F6/f8fuXk29FHQOduA8l89g0M9XMSH+Z0lQ09NTBdm4uTFSfPoU5CiVoYcOZx0Dl5Fey/wvPchFkFopTLaN7q3uiJQ2G5FxNQ1eUPkz6nEwHXFY3V5MUq89ui28zUYgbynfxu7X4OFrR4qHx1sU2naJJR12W5VU3XeWwoBkQ2GGpHCVGC+bEwcvJs8WNhXgYRcsdeMQjGFJHpfV1tnopRlqaeAuMGYDHfM5DB/AG7Ph2URvk6xgi/k//K644oGSVX0QqXXIfeBgE2CeQxGBS7EUEIOF07RFk2nr0txpyecgfbmN54XDxodhjzYfh6pep76UNXdWUkDPnoFrDI67v+zrmCLkCRQNb5PNxk+m2BsbqU/2NH57cpY1CFZ0DyagyXFsuOggsVpWRCoATkeKiWZYd7lF+2lXShp21ZI5ZmEqJkEucrJpWaU9I2usrO8QF0WcRXNXCxXl/JtOFB3R+IKXnB+C9r/A5smtlsz7XrpmgUaE0VCYnqr46dVoY1nQOq7WoLsqst0bu9jMOVtrPG7IEL9yW0WsiHuRqeFYwAAHaO0VHetKGTEEdlfDzBKiMmOcuAnDUdVHe8TfLd7gKlaglaEgjqWGGQxwjhk+bUJXlN5gRZEWVM5+kfCbyWMc3+MSRMfBZlXFT1E2zVYcVLDqakgJLRZYSOijWg0hUYa0Ye/B6CFr9eZpgA6HfZ7uMggb5BI1qMApOXJLz0qOc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(261102123227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhEZm5ac2RpRm4waVZkMkY4bjhMUkFOWXZOZG9YWWcwamNEODFxNlJ3bzhV?=
 =?utf-8?B?Z3JFR2UwWkhLTS8yenVUNVJHN2lIQ0ZIRmlFL1RJVFVKV0pDZzRxaDloRHZh?=
 =?utf-8?B?VlRxNGVQSFBHaWNqNEh3dllGQnpESEU4bUVFNEVCdm1nT2J6WVlwVnJGZWJI?=
 =?utf-8?B?MHRVYUhKRXBQblhsektqc0dyNWFQdFN3TFdjMFQ5Y1RadUdCYnRiUW1NcDRW?=
 =?utf-8?B?NlgrZGF2bUdmZVRCNEtBQ0EyNnh0ZjVoOGs1MHJzRlltaFBZRndsUEVpZFc1?=
 =?utf-8?B?bGovSS92Z1Z4amRwaUFaL0dQU05UYVQxYVlnUlp3c1hMTmRBa3hSbHZJeVp3?=
 =?utf-8?B?Sy9TQ0VqQm9RSnYwcTYrL1hyaVFuTGRwakNDTk45SndHa3gxWnBDUmtmWEJ5?=
 =?utf-8?B?OVVWNFZaaUpRRGNSYWZhR1NXclZDZUhLd05WZnh3cWF1K2NadS9mNDZQSEx6?=
 =?utf-8?B?b2g0a1VVQUJ5cDhpWDFhR2tHNGJSWDVYTUM1Y3lPb0JuajRMRlk3SVNWeVdz?=
 =?utf-8?B?a0tzOXV6NFZqWEdLNjl5OWpzdE5qa0phbXF4R2NvZVhEc2ZBVjZNUnJrZktK?=
 =?utf-8?B?NmhaWHpQd3RadDkzZkg2aWhoalBLMG5ZTHlGMkgwYzBOR21xbm1reEQzSGEv?=
 =?utf-8?B?RkVsVjdtamhQWTNPMmNkaHVnaDFCZHhFSmQ0WDJZeUtiMGNnUzJIS24yZVVi?=
 =?utf-8?B?cGlYRFEralIvNjd2dndtcml0TUJTNkJpelNEcmZnTHAwejBxekkvRzN5a2g1?=
 =?utf-8?B?eEswdUVubUZhelN5cHdEZmd3RW10Qlk1dEVLTXpVQTZhT3l0eW02T0psSzY1?=
 =?utf-8?B?MnpRYTJDd0hrNEhJdDNOeFBKZUp3c3BJWXNMUEk3RDdXNEFrR3UzZXpNdlhT?=
 =?utf-8?B?dHZQcTNBN3pQTmpYVjR4a3JUUFZUUlZmQkVlWXhMcko5Q1M5Yys4Qk81TFMw?=
 =?utf-8?B?eTdyWkEzSk0yNVZmaTYvNlRHa2FaQnFSby9MdXF6VC9FQzNjcUNha1RBS0ZU?=
 =?utf-8?B?UzVvQ1BxMG43Mk5rSGlURVFBbDcxSUZQWlYrMFhKTi84dDFrVmg3eFJpSWcr?=
 =?utf-8?B?K1V0SWJNQUlTUXlqUE95QlRRdXR6VUdRKzd6dHN0YmtKN0tYaFJzN3RkczBn?=
 =?utf-8?B?MnBKOFJic0RqVEdWbHhvNERjVmVwajBlcFJJZHlZY3NVTVVVT09wb0Q2azFH?=
 =?utf-8?B?VjE1Uk9tdUp5Ri9BeUVYamlDMkxFWmgvWUlHMDl0M0FWK2tWc0ZjTU5uUklO?=
 =?utf-8?B?S1VwNUxkOHlGaUFkaHZ3enQyenB2dzlqcGNzaDJWVGlNbFQ4cHRjdk0vZ3RZ?=
 =?utf-8?B?NWp4NEdMbUNodFpOVkprT1pobFRESDZPQlJVdEM2eHd5Y2VJbmcvTTg2eXpw?=
 =?utf-8?B?QlZRcGF6SU9GZ3B4NSttVWQ2UXFZR25tTmJkckxpdFpPYnpiSUFaYWltUDNr?=
 =?utf-8?B?K3BESHVrbGpJRTdOMm1ZRnBUQ0dEVDlpTU1xbTNFbEdwRlF2a1YwdkFmSlBX?=
 =?utf-8?B?eTdrbkQ4NEsyMkZ5MjN0WEx0OFBjQSsyTndjK3Fic1dKUUJJYm5lWkhOSkNO?=
 =?utf-8?B?YXg4YUF0bE1ISjBIYWtpdlM3YTlmRVVKdUtIbzdsUjVZd0lIVWhXRzk2Nllk?=
 =?utf-8?B?UDlGNm9lUHVaeVdRWGlNQi85VVJwb0NUNkNvT2RyUkNEeGNXNXBOZnorSXdv?=
 =?utf-8?B?Q1RiL25abFhoNFZZQ3g4c1lwaWhLa0N6dGRnT2ZPQzUxTnJYQ2IrZnlKaEVO?=
 =?utf-8?B?SGphc0Z1WGQ0VkRiRHV0MHZNYXBmd1QyN0ZwSmNmNVprQmtBa0NQczVGYnQ2?=
 =?utf-8?B?dDZKbHV0R21WUHRrME5VeHVaY29mRHZxS0I0MkRkMUxMR1k3SzU0a2YyR3Jk?=
 =?utf-8?B?c25sajkzWEorajBDbFJ6UFZscllrMks3bVZSeTU4ajZQaWlKbHVCNDg2YThy?=
 =?utf-8?B?Q3JaMS9BejJmL3Jjd1NOQ1dFVVhwcENKYytUeXBvV2VLQ2V3VmlXR3JhaVdh?=
 =?utf-8?B?R3NwQVZTb3RhK1ZCajJINzFObGd1NHBDNk9GZUZPd3BsUXNmOGFabTl6bGdx?=
 =?utf-8?B?TkRMaUxhMVY1NjI0R2JzWm9Cc0tQT01TNDRUVzFJM04wV3lKbW5SL05wQ1pC?=
 =?utf-8?B?TGw1YjJRRFpBc21CQjMwMGVOY3dnSHVRdk52ZUhSejdHbkZpcG1kcEZidENZ?=
 =?utf-8?B?VWhzTXpLK0o0RC9kOEVXVTlXQ0QxVW8xQVRiSFFxVE1lZmVmT1AybXpUV25i?=
 =?utf-8?B?dlgyMVdQbUMyVzlwUnVtdTdGa3ZuUmhlK1p6TEFvSEFyTmJ1b2NXMEYvUWJ2?=
 =?utf-8?Q?RO9s+xGN/l9Attw1av?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DA4E6cJJmtTzb8Z6vMzHkPZtwlEBzM3+dftLZwP95cPclfveAE7/0KyhpI1ZOLC0CDLqYWYYdnHtWi/J3zeu5EmQcawg5N1+vqWBx5BsWoAfMTK0xfUZzU2M7dI1vfXKIIP7Z8I2fVC4U/+XbTNTXPSyqsXEkOwe1SH2bdpTvEUE5rwPO+rNj1Q5pk4eGijiiQ0SlemFPPfTIiNV6VCRp52HDvVlpQZLFrky6xr+fxAw9bvyREndcogD0kF+T9BVf5SP/Vkqdhr0QLv4qSb+gAtDdELPRYh58MNg/AZIEQ6vHXB0i927eDJH9FZ+OHVQWZt5URgpCIBNLWlkyxyxmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d55e49-dd95-4c65-e77f-08df398a4068
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 09:10:05.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMj1wJt/ifP85ywtuiQbqF1L/L9TygTtpjkuOIH5Mf5apP0L1S06lz/oQZvJYiNf2Aq5zHZWqJu1BhZSsCIkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB837409
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MV0gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IFNldCBNQUNfSU5JVCBpbg0KPmdldF9t
YWNfYWNjZXNzKCkNCj4NCj5EZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlvdSBmb3IgeW91ciBw
YXRjaC4NCj4NCj5BbSAzMC4xMC4yNiB1bSAxNToyOSBzY2hyaWViIEtpcmFuIEs6DQo+PiBFdmVy
eSBjYWxsZXIgdGhhdCByZWFkIGRldmljZSBtZW1vcnkgaGFkIHRvIGNhbGwNCj4+IGJ0aW50ZWxf
cGNpZV9tYWNfaW5pdCgpIGJlZm9yZSBidGludGVsX3BjaWVfZ2V0X21hY19hY2Nlc3MoKS4NCj4N
Cj5J4oCZZCB1c2UgcHJlc2VudCB0ZW5zZTogQ3VycmVudGx5LCBldmVyeSBjYWxsZXIgcmVhZGlu
ZyBkZXZpY2UgbWVtb3J5IGhhcyB0byBjYWxsDQoNCkFjay4NCj7igKYNCj4NCj4+IEZvbGQgdGhl
IE1BQ19JTklUIGhhbmRsaW5nIGludG8gYnRpbnRlbF9wY2llX2dldF9tYWNfYWNjZXNzKCkgYW5k
IGRyb3ANCj4+IHRoZSBzZXBhcmF0ZSBoZWxwZXIgYWxvbmcgd2l0aCBpdHMgdGhyZWUgY2FsbCBz
aXRlcy4NCj4NCj4gRnJvbSB0aGUgZGlmZiwgaXTigJlzIG5vdCBjbGVhciwgd2h5IG1vdmluZyBp
dCB0byBgYnRpbnRlbF9wY2llX21hY19pbml0KClgIGRvZXMgbm90DQo+Y2hhbmdlIGJlaGF2aW9y
Lg0KDQpBcyBmb3IgdGhlIG90aGVyIGJpdHMgKCBGVU5DX0VOQSAsIEZVTkNfSU5JVCAsIEJVU19N
QVNURVJfRElTQ09OICwNCmFuZCBTV19SRVNFVCApLCBvbmx5IE1BQ19JTklUIGFuZCBNQUNfQUND
RVNTX1JFUSBpbiB0aGUgZnVuY3Rpb24NCmNvbnRyb2wgcmVnaXN0ZXIgbmVlZCB0byBiZSBwcm9n
cmFtbWVkIHRvIGFjcXVpcmUgTUFDIGFjY2Vzcy4NCmJ0aW50ZWxfcGNpZV9tYWNfaW5pdCgpIHdh
cyBpbmNvcnJlY3RseSBwcm9ncmFtbWluZyB0aG9zZSBhZGRpdGlvbmFsDQpiaXRzLXdoaWNoIGFy
ZSBub3QgcmVsZXZhbnQgdG8gTUFDIGFjY2Vzcy10aG91Z2ggZG9pbmcgc28gZGlkIG5vdA0KY2F1
c2UgYW55IG9ic2VydmVkIHNpZGUgZWZmZWN0cy4gSSB3aWxsIGNsYXJpZnkgdGhpcyBpbiB0aGUg
djIgY29tbWl0DQptZXNzYWdlLg0KPg0KPj4gVW5saWtlIGJ0aW50ZWxfcGNpZV9tYWNfaW5pdCgp
LCB3aGljaCBhbHNvIG1vZGlmaWVkIEZVTkNfRU5BLA0KPj4gRlVOQ19JTklULCBCVVNfTUFTVEVS
X0RJU0NPTiwgYW5kIFNXX1JFU0VULCBsZWF2ZSB0aG9zZSBiaXRzDQo+dW50b3VjaGVkDQo+PiBh
cyB0aGV5IGFyZSBub3QgbmVlZGVkIGZvciBNQUMgYWNjZXNzLiBTZXQgb25seSBNQUNfSU5JVCBh
bmQNCj4+IE1BQ19BQ0NFU1NfUkVRIHdpdGggYSBzaW5nbGUgcmVnaXN0ZXIgd3JpdGUgd2hlbiBl
aXRoZXIgYml0IGlzIG5vdCBhbHJlYWR5DQo+c2V0Lg0KPg0KPknigJlkIG1ha2UgaXQgdHdvIGNv
bW1pdHMuDQoNClN1cmUsIEkgd2lsbCBzcGxpdCB0aGlzIGludG8gdHdvIHBhdGNoZXMgaW4gdjI6
DQoNCjEuIERyb3AgdGhlIHVubmVjZXNzYXJ5IGJpdCBtb2RpZmljYXRpb25zLg0KDQoyLiBGb2xk
IE1BQ19JTklUIGludG8gYnRpbnRlbF9wY2llX2dldF9tYWNfYWNjZXNzKCkgYW5kIHJlbW92ZQ0K
ICAgYnRpbnRlbF9wY2llX21hY19pbml0KCkuDQoNCj4NCj4+IEZpeGVzOiBiOTQ2NWU2NjcwYTIg
KCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogUmVhZCBoYXJkd2FyZSBleGNlcHRpb24NCj4+IGRh
dGEiKQ0KPj4gQXNzaXN0ZWQtYnk6IENvcGlsb3Q6R2VtaW5pIDQgQXJnb24NCj4+IFNpZ25lZC1v
ZmYtYnk6IEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIHwgMzEgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMN
Cj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGluZGV4IDdkODRjODEw
NmNmMS4uMDI1YzRjNjRkMDIwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+
PiBAQCAtOTg5LDMxICs5ODksMTggQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfcmVzZXRfYnQo
c3RydWN0DQo+YnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+PiAgIAlyZXR1cm4gcmVnID09IDAg
PyAwIDogLUVOT0RFVjsNCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMgdm9pZCBidGludGVsX3BjaWVf
bWFjX2luaXQoc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKSAtew0KPj4gLQl1MzIgcmVn
Ow0KPj4gLQ0KPj4gLQkvKiBTZXQgTUFDX0lOSVQgYml0IHRvIHN0YXJ0IHByaW1hcnkgYm9vdGxv
YWRlciAqLw0KPj4gLQlyZWcgPSBidGludGVsX3BjaWVfcmRfcmVnMzIoZGF0YSwNCj5CVElOVEVM
X1BDSUVfQ1NSX0ZVTkNfQ1RSTF9SRUcpOw0KPj4gLQlyZWcgJj0gfihCVElOVEVMX1BDSUVfQ1NS
X0ZVTkNfQ1RSTF9GVU5DX0lOSVQgfA0KPj4gLQ0KPglCVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RS
TF9CVVNfTUFTVEVSX0RJU0NPTiB8DQo+PiAtCQkJQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxf
U1dfUkVTRVQpOw0KPj4gLQlyZWcgfD0gKEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX0ZVTkNf
RU5BIHwNCj4+IC0JCQlCVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9NQUNfSU5JVCk7DQo+PiAt
CWJ0aW50ZWxfcGNpZV93cl9yZWczMihkYXRhLCBCVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9S
RUcsIHJlZyk7DQo+PiAtfQ0KPj4gLQ0KPj4gICBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9nZXRf
bWFjX2FjY2VzcyhzdHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+PiAgIHsNCj4+IC0J
dTMyIHJlZzsNCj4+ICsJdTMyIHJlZywgdmFsOw0KPj4gICAJaW50IHJldHJ5ID0gMTU7DQo+PiAr
CWNvbnN0IHUzMiByZXEgPSBCVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9NQUNfSU5JVCB8DQo+
PiArCQkJQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfTUFDX0FDQ0VTU19SRVE7DQo+Pg0KPj4g
ICAJcmVnID0gYnRpbnRlbF9wY2llX3JkX3JlZzMyKGRhdGEsDQo+QlRJTlRFTF9QQ0lFX0NTUl9G
VU5DX0NUUkxfUkVHKTsNCj4+DQo+PiAtCWlmICghKHJlZyAmIEJUSU5URUxfUENJRV9DU1JfRlVO
Q19DVFJMX01BQ19BQ0NFU1NfUkVRKSkgew0KPj4gLQkJcmVnIHw9IEJUSU5URUxfUENJRV9DU1Jf
RlVOQ19DVFJMX01BQ19BQ0NFU1NfUkVROw0KPj4gLQkJYnRpbnRlbF9wY2llX3dyX3JlZzMyKGRh
dGEsDQo+QlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfUkVHLCByZWcpOw0KPj4gLQl9DQo+PiAr
CXZhbCA9IHJlZyB8IHJlcTsNCj4+ICsJaWYgKHZhbCAhPSByZWcpDQo+PiArCQlidGludGVsX3Bj
aWVfd3JfcmVnMzIoZGF0YSwNCj5CVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9SRUcsIHZhbCk7
DQo+Pg0KPj4gICAJZG8gew0KPj4gICAJCXJlZyA9IGJ0aW50ZWxfcGNpZV9yZF9yZWczMihkYXRh
LA0KPkJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX1JFRyk7DQo+PiBAQCAtMTk1MSw4ICsxOTM4
LDYgQEAgc3RhdGljIGludCBidGludGVsX3BhcnNlX21ib3hfdGx2KHN0cnVjdA0KPmJ0aW50ZWxf
cGNpZV9kYXRhICpkYXRhKQ0KPj4gICAJaWYgKCFidWZmZXIpDQo+PiAgIAkJcmV0dXJuIC1FTk9N
RU07DQo+Pg0KPj4gLQlidGludGVsX3BjaWVfbWFjX2luaXQoZGF0YSk7DQo+PiAtDQo+PiAgIAll
cnIgPSBidGludGVsX3BjaWVfcmVhZF9kZXZpY2VfbWVtKGRhdGEsIGJ1ZmZlciwgdGJsX2FkZHIs
DQo+PiAgIAkJCQkJICAgYnVmZmVyX2xlbik7DQo+PiAgIAlpZiAoZXJyKQ0KPj4gQEAgLTI2NDMs
OCArMjYyOCw2IEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9yZWFkX2h3ZXhwKHN0cnVjdA0K
PmJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKQ0KPj4gICAJaWYgKCFidWYpDQo+PiAgIAkJZ290byBl
eGl0X29uX2Vycm9yOw0KPj4NCj4+IC0JYnRpbnRlbF9wY2llX21hY19pbml0KGRhdGEpOw0KPj4g
LQ0KPj4gICAJZXJyID0gYnRpbnRlbF9wY2llX3JlYWRfZGV2aWNlX21lbShkYXRhLCBidWYsIGFk
ZHIsIGxlbik7DQo+PiAgIAlpZiAoZXJyKQ0KPj4gICAJCWdvdG8gZXhpdF9vbl9lcnJvcjsNCj4+
IEBAIC0yNzMyLDggKzI3MTUsNiBAQCBzdGF0aWMgaW50DQo+YnRpbnRlbF9wY2llX2R1bXBfZnd0
cmlnZ2VyX2V2ZW50KHN0cnVjdCBidGludGVsX3BjaWVfZGF0YSAqZGF0YSkNCj4+ICAgCWlmICgh
YnVmKQ0KPj4gICAJCXJldHVybiAtRU5PTUVNOw0KPj4NCj4+IC0JYnRpbnRlbF9wY2llX21hY19p
bml0KGRhdGEpOw0KPj4gLQ0KPj4gICAJZXJyID0gYnRpbnRlbF9wY2llX3JlYWRfZGV2aWNlX21l
bShkYXRhLCBidWYsIGRhdGEtPmRlYnVnX2V2dF9hZGRyLA0KPj4gICAJCQkJCSAgIGxlbik7DQo+
PiAgIAlpZiAoZXJyKQ0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClRoYW5rcywN
CktpcmFuDQoNCg==
