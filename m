Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63102C031E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545507; cv=fail; b=h2XEPz8C2tRe5X1gnrGN02MWf82CdjwGjG64PEfhqBmNN3dIIGd4N1q0UJA8SeFOjekMf5I7N+LUSa8Biam60Hm/cUuTasi6J3mTuuTrPQ/CzbORO48O7NLXwTuS9gDU5HigRJlFEzod52sbj3igK97Ji59Htt1WTXir9IurPP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545507; c=relaxed/simple;
	bh=4V8nHeSojsBqZFErz5ECg+S2tZgsuIIsSu/B4cuUnWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o3Scot64wIRN3PRnwmPbMmkvRN+wCMkEE5Hh4eosFKUOPSoE3ZIc7CCcu4ojZBQ+5Oz0bNRMHLYUIdo/tShHp/TwePid6Y6r2emwG/aWGi1BD4QbGBP8yY4Rb72IqRpV9W5ST8mP0VOqU5nnr/drCM939M08ZL4T5dH+pgN3BvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbnSGMMq; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbnSGMMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752545506; x=1784081506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4V8nHeSojsBqZFErz5ECg+S2tZgsuIIsSu/B4cuUnWI=;
  b=RbnSGMMqMknFAyHoOF+Cf6lEEOxjcAHWHkMCioA3/KLnB2Ko2FBbSt+g
   LvipCrEqOmKAxYAjU1edUe9wmpCqNq4viEdlI5LzSKbnzu5lIryPM27Px
   exjPD+xmGkIP55FGVP1Y5nYNHT5Fs4MRDnVIqQ/eTvMzjQjCB7ACsE3h8
   MXppEzGTX+8MwdBA6QBR+Ah1i6sFT79Qkx54V7/9l1Cj9TuumNCVXu2rP
   QFSe/FM66MaTrgEK/GHqEhjlyWaiv1kI2rYF53O91J7cvb+rPuYN38c/L
   RAwEPeXEdqFoqz+/o+JWxkL5xMG+cPIVqwVFGmfEwDvziVWdUAa4vcZJV
   w==;
X-CSE-ConnectionGUID: le8VkMTRTCCPErK7G9omxQ==
X-CSE-MsgGUID: 9Ju6fYTFR+OR+pjbY/Zlsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66201489"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="66201489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:11:45 -0700
X-CSE-ConnectionGUID: tEEaE9iVRPmzAXlyKcFsnQ==
X-CSE-MsgGUID: Mnd+RMMHQFiF4ULU6eSZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="161409631"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:11:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 19:11:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 19:11:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 19:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXy8v1hI9/RDluwXdyA6FV3UiizWw9QiKXE8v98e7L3XUxC2sZ2OhdYi65KFD4y1+FUeEnwxNHrxnobNyeLYvjHjqgTVXc90oKStZYu1bk2SDvQveOgIRdrGHljssq/2LbIYuLIJAm3peCoHHZ2Ixf8yfEdXgTdnyhBF+8yU/b6m00kwEtg/Ktku3tJUFSv+sNFFTC8IsFNJGQIrgIGxjpSiqIJfH4cz+eQaCdLni1bgaJfOLJ5kOz7Inz+Ux+f1iLK6T3hAZowrjUgaeeb2rfWbo6EVls9ySLWtP1iW9nKvn/KzdEDwM4b4ogV/aXCJohKj016P38y5ECkS/xRFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V8nHeSojsBqZFErz5ECg+S2tZgsuIIsSu/B4cuUnWI=;
 b=eGR+HhLbuoX0WDIyjt+XJGJHPH6JaXZKMMTabJe3A1qc6fhjPHw4qHhZetSlMUFTevY0t7t5qmqJE48nWoTo92nuHEdQre1AiJVH6c651MBmL/09Lddr9aBtjVYQPZquclySk0xTFzqurDgmtNBAx813bhQQACZsSshwrnh6nRJ7bngcpG53xRby/WDJRuSjPXOv1D+K8nm/TGGpGGZYrnG51cDcg+tJulMr9tCJq5IDHyxO42b6BMIANZGivDiiKeoJ2pKnct8X4kvQb07Euv3tZH9Um6PD5g0KPQVYZuyP6f3Eqg6Fi2H/y+48nCzs5/5U8pqtsjFYlEC/za+g3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DM3PPF4C690C788.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 02:11:26 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:11:21 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
Thread-Topic: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
Thread-Index: AQHb7u+FIJM3uUpiRUaJUhiWwfHCSrQosI6AgAnMkUA=
Date: Tue, 15 Jul 2025 02:11:20 +0000
Message-ID: <PH0PR11MB758578050E8DD93F158D3DAFF557A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
 <20250707034657.929092-2-kiran.k@intel.com>
 <CABBYNZKA70vQ4gpmOe23WweJUU5FY4Y9hcqTDdpMcQns-gGEUw@mail.gmail.com>
In-Reply-To: <CABBYNZKA70vQ4gpmOe23WweJUU5FY4Y9hcqTDdpMcQns-gGEUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DM3PPF4C690C788:EE_
x-ms-office365-filtering-correlation-id: ab749398-f204-4542-ccfe-08ddc344e434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUhpM1lhK3NPTytSNzVLc0hNOFRTUGFUa3pCN01icGE0eFE3NXpjejlnQjhR?=
 =?utf-8?B?SnZZWkFka0VFbktPRFY1dWs2REhVZnk0blBuekpldWR4bFNxc0NsZ2x5SW5C?=
 =?utf-8?B?dlRMN0xlL0tveFJHR21xZGdCaTM4ejRJSEkwVjd1V2d6NjhOQVl4Z3ErUFE4?=
 =?utf-8?B?N2ZqUnF5Wks2VjlPTXJadUlNdFBENURLNndBNGM2UGRUOVRYL2dtRDNaL2lt?=
 =?utf-8?B?UmtBUHkraUViMEFOaGFTcUxZWW5hY3NIQ1U1VUVzbHl3bUpGL01LcFY2MFl5?=
 =?utf-8?B?U0xHS3BjaEU0MGpyVDY2dzA1NThhaGxDRXhxSGdMTlJhMFdQRENyUHBSbHk4?=
 =?utf-8?B?WndxMUFMRlJRT01kNWFBK05Ccy9VZFlVV3pieW5aeG9hT2diakdqSTY1c2lj?=
 =?utf-8?B?TFUrYVdQNkF1NEQyQUFELzRGK3g5SnlqM3o5SWM5Yi9wUEIyT29FOEd2bkxC?=
 =?utf-8?B?RkcwVFBFYUpJc3FTZ0hyeFVnSWxDUmwrUFhrWVpRYS9UNmhQSkdnM3c5cWF0?=
 =?utf-8?B?TmkwQ01EM2llQTZaK2VJTDU1eGtadTdseUxqbkRLVDVERlBkV1Z0VFVZMmNh?=
 =?utf-8?B?THFqYlBZRmVuVVhmNVFWV3BKdXdWQ3hCWFhybjVEVEsvR1FWbTNpSXBiVjQr?=
 =?utf-8?B?RU9rQWhYd2ZlMDBYanNjdGNuZnpTWVhjSkpYM2xVbVJDZjhJQ3BRakRzY1Ft?=
 =?utf-8?B?d2tpbTk3UXAxaTgvVTd4NTFUcmF3UnBmOFRGNDhxLzVQR0VtSm8zeHVsd0ZF?=
 =?utf-8?B?SXRJMDFHMXQ0a21QUDArYzRGQTNlZ1JDOTJEaGV3NE53SkcvQ1N2clF0WGpY?=
 =?utf-8?B?WXNDUjk1UmU1QmxCalF1ai94RlBXRzY0akRWZ0lqMnIvdVozZGRpdlFocWlR?=
 =?utf-8?B?OHJKbFprY2hxVk1BV1ZLSzNaZ0ptQXlqb294cmxQU3RGUUh5K3VBTGlKenQx?=
 =?utf-8?B?MjlDWm9hbTNmYUZ2T0pQL3pQS0o5eWZsUUI3Q1RnRUdtNGE4Ym9IZ01zS3hh?=
 =?utf-8?B?eU5td1ZBeW0xbkNTRkZxV2pxejZuT1YzMlQ2RHBONkVsVzNEMWVqZ3VOWUZQ?=
 =?utf-8?B?ZEZDcFpvY2M2SHY4TXJrUVcwblEyMjdzNCtNNlMvTWFzVXZJcUpxMXFodEo2?=
 =?utf-8?B?bklFa1hKNCtMN3BhVmxZbnRaTjZTdmNFSjVwRUo5MElwSmc3MnVGaFVWKzdS?=
 =?utf-8?B?TlpxUC9Da09UcjEwMFpyM2NrclJGcE1idFlSVGJ6eEhjMEpZVEJGd0NWbWRF?=
 =?utf-8?B?d1JPL0kzeGdpcnNMVW1HNjNTclo4cHVwYll3bXQzNHQ3QUhBTW11azQ4V3dp?=
 =?utf-8?B?VEJqL1dxbFVZL0F1dzFPM1BhU29XbXB3TWpzeDJBY214Z01GSmNybWM3M1kz?=
 =?utf-8?B?OVN3UzZGeHdqWFprU05VT3AzSDBJb0dRRlBhS25wcnNJemhVZU8vbk1LR1Zk?=
 =?utf-8?B?Vys1NHBzRjFTaXhidGFhZWd1aGwyUCtnRHFwOFhpNlgwSE1mRDFlU1R0V2tI?=
 =?utf-8?B?NFRsZUUzUEhHMk1BTHViRW1QeFU4TjFrcnBMdE5peGtvRFpSUHBmQXd6N0tu?=
 =?utf-8?B?Y2VmbWVGWG42dCtJQzJGTHh3aTlLTGE3K3YzZEpjL1ZxVUdGaGgzVWdGcnlG?=
 =?utf-8?B?T1RUcDJRSVQ4VmZ3UGVRKzVjUjlMY2srcHJxUkFZanZDVW5SQ3ViSENWYTFk?=
 =?utf-8?B?MlY4YXlCT3hrNzhqVk1ITUZJUjhtRnBxNjNMOVZPZXRLWmxIaUZOZkJIYVJI?=
 =?utf-8?B?Tm01SzY1VEEyWkliaVVLVGFBMDVGYVBzTnZSeE1NVUs4SzZvTThOVmFFVmVF?=
 =?utf-8?B?TmpOYzNGaXpYRTI2di94S1EvQmh2UFh0T0I4TmdBK0V1UkVRSmZraGUzZFhD?=
 =?utf-8?B?ajR6YmtOczlCcEZuRVRIb1FIY0NSdHp0VWdEOWc1V21DMnhnTE1sQnJyQ1B3?=
 =?utf-8?B?aGJlVGR6RTY0cWsyTVdETU9MS3Y2NmdwVURiZmhxYkpuQ3h5MjBKbGdPNjZX?=
 =?utf-8?B?cVJGNkpqTSt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3B2L0swcVhPMm9FZzNUekF3YWFXV08wZzZ4NnJ6dzN1Q1dKVDFPK1grN0NK?=
 =?utf-8?B?Und1TjZJTUc5UkY0eE1qM0gwVmFabGZqRmR4M1ZWZnhVdGR3T21mVW9UMFJz?=
 =?utf-8?B?NVhEcThPcWFNT2ltem15UFlIanJreVg4WkNyRTFpaExpTVBiQ1F6amJzZ0lX?=
 =?utf-8?B?LzdXcnZvdHBHRTdtZHR0RlhkK3JzOGVwanpUMFA5MWk0TS9MVkpobmRGWHdQ?=
 =?utf-8?B?ZDdmbFZLWWF1L0F2QzV3N2lsTFVCNVluU1BuVldTZEk4TUNHV1kydktaV0RN?=
 =?utf-8?B?VEphMkVENTF5endmUUo1dHBoOWdaYnN5d2NiOXJjMzlOeUVwU3g3NU1TU1RS?=
 =?utf-8?B?OExKYkwxMWREN21wdGluZ0N2NGpmZFFGWWNJQkRNZDNqTzI3bTN3ZUdySnJE?=
 =?utf-8?B?YkhlRmpVUkJRcU4rTWxXNXYxUURhaHZjQ2t2a001QXhhR3RoSCtQN3hNVWp0?=
 =?utf-8?B?MGlwdEJFdHN4N2E3U2UrRklFc1BINDIxVUs3Um1pdGVsSkZBc0pkRWlhUHVN?=
 =?utf-8?B?d3oyNVBSZnFIRngxTG5BM21pMVhjdjdiajRmQXl5K3ppSzhVczRqeEtpOHRh?=
 =?utf-8?B?eDZBUEFaS0xKTmVIN3QwZktOcmNiMmtaWFJwKzNBbmxQd2lNdytVckwwelhL?=
 =?utf-8?B?bXpRWlh4aGJ6K09nVm8zOHFwZTVYZ1NCMmdaS3dEMkxtNWlHZUQxQ1pGRGVE?=
 =?utf-8?B?OFMwbWxKTUJQNDhteDZPL24wS3VSaURncDdQbFlUUnlzTmdyVXFOb250Yys4?=
 =?utf-8?B?OXV2SDlTL2tmWFcvZ3hzcG5aMlJHVXJxRTl0bll0dW9TMG5HNHFrU2llQVkv?=
 =?utf-8?B?RVVrZld0U1dFaE8zdWg4VGpkdkRSN2o2VXptaXJ6QStpQ3crV3JaNDdoM2lV?=
 =?utf-8?B?K2l0aGpTRHJLZy9vTE9qR2lxT0w0ZzI3UVF3MUh2WHdaMzd3cGhmQzlmS0lq?=
 =?utf-8?B?dTZWMTNPR3dTS0ZIWnFxYWpDSy90VHUwcVdTR2xZcldtNWdpdVIxcUc5aCs4?=
 =?utf-8?B?aHZRWGRUVmtWV0M1K0s2aGZqY3JVdTJwVXVKNnNjNG8yUlcyQlVYYkpaMU14?=
 =?utf-8?B?MFhLaGE1UlZDcDhjUTNKVHdtSytjMVp4RjBCb2pRdUx6NGdyNFVkM1hhL0cv?=
 =?utf-8?B?NjJMaUs0RTdqMEl3MG5XMkdKckVselNycjVLRkxYSFhDOWVKY0RTRHRXdWFN?=
 =?utf-8?B?OHJxc3E0MjdKekpjbXdzZkl0ZjFScVNWbUU1MHVia0Z1N2I5elNleTYzWU1V?=
 =?utf-8?B?cS9XN3ppSTZrSWE1OWlxQWNMMUQvbEsva0kwMXZpaXp4RjNVUUdlSEJENlkr?=
 =?utf-8?B?dnBYd25tVG9DejExY1ZvNlc2bDUyU3I5akptVUV2SHVVRmg3bHg0UGdseTZH?=
 =?utf-8?B?eXVyY2Z4bktzZGVBbUE1YkNBVnlwUkNpWHdWZnJnMzcweENwN1BkdGFFeTJx?=
 =?utf-8?B?b2ErOHh3b3JvWjJ5ZXN5V1g4S3R5eDNYc25mYjdPQnh3d0hRZ0gzN0dFei82?=
 =?utf-8?B?cXBvT0l1SSs5aEg5dmJYUFNQTm02ZVdmZitxRFBHU28wdjE0eWRScEp3NUJ2?=
 =?utf-8?B?aXozdWJaeE1IWU55SW1DS3F4bkFQOFFRWmRhRldXNGlOdkNyMW5xWkMrNHIr?=
 =?utf-8?B?VFY1Nk8vOVF3eE5NOWdMcWVLUGhDZjZ3bWNtSlcrQWpsQ2NxT0U4UEVJczZG?=
 =?utf-8?B?dkFFRkduSm1od01tc0k0cVRIQ2JEMjdXSHB6SjMzZnExa1RxZ0xIT1pEckZ2?=
 =?utf-8?B?N3lpZ2RaQjZhU3lrdVFQYnFwVlpCUFNBQ1daRStuMHNDTWpockxsOExFV3g5?=
 =?utf-8?B?czhnd2Y2UCtHd3VEU2p2bGMzcVRZMm5IRmlJM3VHRG5tZ0FDV3YrenpsY0Iw?=
 =?utf-8?B?OHQzMjVoOVNCMEwwaGRhRE00Y1pDMVBCTFh5VnNXSUVJZ3YyVzZpSGpmR2xM?=
 =?utf-8?B?MzU1ZWJGckVBK3pReU1mdkw2OTFlWCthVWowWXF0RXBzS1AxUW5JV0s1eXJB?=
 =?utf-8?B?U09uYk92a3Y5VWFxTTQvUW51Wk52YWZwcHZBczY4SE9BVVNldzRiaHZqQktL?=
 =?utf-8?B?WHJBdUQ4dStqbGU2ci9wYmJ3dXY5cXUvcy81Slh4OURsdVFPekV0ZjJURWxq?=
 =?utf-8?Q?7ZI0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab749398-f204-4542-ccfe-08ddc344e434
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:11:21.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dUa6xFFsv/ypq5k1bz7P7j7CfXO0R3hIu8cMFyiS7HuhROJwlvMWce31ukbk5217udaaUU4tmuUOBxkNHv2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C690C788
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogRml4IGFsaXZlIGNvbnRleHQgc3RhdGUNCj5oYW5kbGluZw0KPg0KPkhpIEtpcmFu
LA0KPg0KPk9uIFN1biwgSnVsIDYsIDIwMjUgYXQgMTE6MzDigK9QTSBLaXJhbiBLIDxraXJhbi5r
QGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRmlybXdhcmUgcmFpc2VzIGFsaXZlIGludGVycnB0
IG9uIHNlbmRpbmcgMHhmYzAxIGNvbW1hbmQuIEFsaXZlDQo+PiBjb250ZXh0IG1haW50YWluZWQg
aW4gZHJpdmVyIG5lZWRzIHRvIGJlIHVwZGF0ZWQgYmVmb3JlIHNlbmRpbmcgMHhmYzAxDQo+PiAo
SW50ZWwNCj4+IFJlc2V0KSBvciAweDAzYzAgKEhDSSBSZXNldCkgdG8gYXZvaWQgdGhlIHBvdGVu
dGlhbCByYWNlIGNvbmRpdGlvbg0KPj4gd2hlcmUgdGhlIGNvbnRleHQgaXMgYWxzbyB1cGRhdGVk
IGluIHRocmVhZGVkIGlycS4NCj4NCj5UaGlzIHNob3VsZCBiZSBhIGxpdHRsZSBtb3JlIHNwZWNp
ZmljLCBsaWtlIGV4cGxhaW5pbmcgd2hhdCBpcyBhbGl2ZSBpbnRlcnJ1cHQNCj5zdXBwb3NlZCB0
byBtZWFuIG9yIGlmIHdlIGNhbm5vdCBkbyBhbnkgY29tbXVuaWNhdGlvbiB3aGVlbCB0aGVzZSBh
cmUNCj5wZW5kaW5nPw0KQWNrLiAgSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UuDQoN
Cj4NCj4+IFNpZ25lZC1vZmYtYnk6IEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogU2FpIFRlamEgQWx1dmFsYSA8YWx1dmFsYS5zYWkudGVqYUBpbnRlbC5jb20+
DQo+PiBGaXhlczogMDVjMjAwYzhmMDI5ICgiQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IEFkZCBo
YW5kc2hha2UgYmV0d2Vlbg0KPj4gZHJpdmVyIGFuZCBmaXJtd2FyZSIpDQo+PiAtLS0NCj4+ICBk
cml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDI1ICsrKysrKysrKysrKysrLS0tLS0t
LS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5j
DQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCBmODkzYWQ2
ZmM4N2EuLmQyOTEwM2IxMDJlNCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0K
Pj4gQEAgLTE5ODgsMTAgKzE5ODgsNiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zZW5kX2Zy
YW1lKHN0cnVjdCBoY2lfZGV2DQo+KmhkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJ0aW50ZWxfcGNpZV9pbmplY3RfY21kX2NvbXBsZXRlKGhkZXYsIG9wY29kZSk7DQo+
PiAgICAgICAgICAgICAgICAgfQ0KPj4NCj4+IC0gICAgICAgICAgICAgICAvKiBGaXJtd2FyZSBy
YWlzZXMgYWxpdmUgaW50ZXJydXB0IG9uIEhDSV9PUF9SRVNFVCBvciAweGZjMDEqLw0KPj4gLSAg
ICAgICAgICAgICAgIGlmIChvcGNvZGUgPT0gSENJX09QX1JFU0VUIHx8IG9wY29kZSA9PSAweGZj
MDEpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxz
ZTsNCj4+IC0NCj4+ICAgICAgICAgICAgICAgICBoZGV2LT5zdGF0LmNtZF90eCsrOw0KPj4gICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAgICBjYXNlIEhDSV9BQ0xEQVRBX1BLVDoNCj4+
IEBAIC0yMDEyLDYgKzIwMDgsMjAgQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfc2VuZF9mcmFt
ZShzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2LA0KPj4gICAgICAgICBtZW1jcHkoc2tiX3B1c2goc2ti
LCBCVElOVEVMX1BDSUVfSENJX1RZUEVfTEVOKSwgJnR5cGUsDQo+PiAgICAgICAgICAgICAgICBC
VElOVEVMX1BDSUVfSENJX1RZUEVfTEVOKTsNCj4+DQo+PiArICAgICAgIGlmICh0eXBlID09IEJU
SU5URUxfUENJRV9IQ0lfQ01EX1BLVCkgew0KPj4gKyAgICAgICAgICAgICAgIC8qIEZpcm13YXJl
IHJhaXNlcyBhbGl2ZSBpbnRlcnJ1cHQgb24gSENJX09QX1JFU0VUIG9yIDB4ZmMwMSovDQo+PiAr
ICAgICAgICAgICAgICAgaWYgKG9wY29kZSA9PSBIQ0lfT1BfUkVTRVQgfHwgb3Bjb2RlID09IDB4
ZmMwMSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+Z3AwX3JlY2VpdmVkID0g
ZmFsc2U7DQo+DQo+VGhpcyB0eXBlIG9mIGZsYWdzIHNob3VsZCByZWFsbHkgYmUgbWFkZSBpbnRv
IGF0b21pYyBmbGFncyBzbyB0aGV5IGNhbiBiZQ0KPmNoZWNrZWQgYXRvbWljYWxseSwgYW55d2F5
IHRoaXMgc2hvdWxkbid0IGJsb2NrIHRoZXNlIGZpeGVzIGJ1dCBzb21ldGhpbmcgSQ0KPnZlcnkg
bXVjaCBsb29rIGZvcndhcmQgdG8gYmUgY2hhbmdlZC4NCkFjay4NCj4NCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIG9sZF9jdHh0ID0gZGF0YS0+YWxpdmVfaW50cl9jdHh0Ow0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZGF0YS0+YWxpdmVfaW50cl9jdHh0ID0NCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKG9wY29kZSA9PSAweGZjMDEgPyBCVElOVEVMX1BDSUVfSU5U
RUxfSENJX1JFU0VUMSA6DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQlRJTlRFTF9QQ0lFX0hDSV9SRVNFVCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBi
dF9kZXZfZGJnKGRhdGEtPmhkZXYsICJzZW5kaW5nIGNtZDogMHglNC40eCBhbGl2ZSBjb250ZXh0
DQo+Y2hhbmdlZDogJXMgIC0+ICAlcyIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG9wY29kZSwgYnRpbnRlbF9wY2llX2FsaXZlY3R4dF9zdGF0ZTJzdHIob2xkX2N0eHQp
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidGludGVsX3BjaWVfYWxp
dmVjdHh0X3N0YXRlMnN0cihkYXRhLT5hbGl2ZV9pbnRyX2N0eHQpKTsNCj4+ICsgICAgICAgICAg
ICAgICB9DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgcmV0ID0gYnRpbnRlbF9wY2ll
X3NlbmRfc3luYyhkYXRhLCBza2IpOw0KPj4gICAgICAgICBpZiAocmV0KSB7DQo+PiAgICAgICAg
ICAgICAgICAgaGRldi0+c3RhdC5lcnJfdHgrKzsNCj4+IEBAIC0yMDIxLDEzICsyMDMxLDYgQEAg
c3RhdGljIGludCBidGludGVsX3BjaWVfc2VuZF9mcmFtZShzdHJ1Y3QNCj4+IGhjaV9kZXYgKmhk
ZXYsDQo+Pg0KPj4gICAgICAgICBpZiAodHlwZSA9PSBCVElOVEVMX1BDSUVfSENJX0NNRF9QS1Qg
JiYNCj4+ICAgICAgICAgICAgIChvcGNvZGUgPT0gSENJX09QX1JFU0VUIHx8IG9wY29kZSA9PSAw
eGZjMDEpKSB7DQo+PiAtICAgICAgICAgICAgICAgb2xkX2N0eHQgPSBkYXRhLT5hbGl2ZV9pbnRy
X2N0eHQ7DQo+PiAtICAgICAgICAgICAgICAgZGF0YS0+YWxpdmVfaW50cl9jdHh0ID0NCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIChvcGNvZGUgPT0gMHhmYzAxID8gQlRJTlRFTF9QQ0lFX0lO
VEVMX0hDSV9SRVNFVDEgOg0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCVElO
VEVMX1BDSUVfSENJX1JFU0VUKTsNCj4+IC0gICAgICAgICAgICAgICBidF9kZXZfZGJnKGRhdGEt
PmhkZXYsICJzZW50IGNtZDogMHglNC40eCBhbGl2ZSBjb250ZXh0IGNoYW5nZWQ6DQo+JXMgIC0+
ICAlcyIsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBvcGNvZGUsIGJ0aW50ZWxfcGNp
ZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKGRhdGEtPmFsaXZlX2ludHJf
Y3R4dCkpOw0KPj4gICAgICAgICAgICAgICAgIHJldCA9IHdhaXRfZXZlbnRfdGltZW91dChkYXRh
LT5ncDBfd2FpdF9xLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkYXRhLT5ncDBfcmVjZWl2ZWQsDQo+Pg0KPj4gbXNlY3NfdG9famlmZmllcyhCVElOVEVMX0RF
RkFVTFRfSU5UUl9USU1FT1VUX01TKSk7DQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KPj4NCj4NCj4N
Cj4tLQ0KPkx1aXogQXVndXN0byB2b24gRGVudHoNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
