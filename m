Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27F2747B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545819; cv=fail; b=Sqat36T3gUhKRkxxo0lDGL1D61ZwZQM9y3CTfeYNSBtUPFr/SgBcL4FhhXVGjpJW2sUgVwino3o9V4M/ZX5/ZguVb/4Dic43ucx8feNrKpnhdJuP5uKERZmzJmhdrBDX943/xsAzyBHAoQO3aN8CoJoNkQiF7JxMcUEHsZ+u5t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545819; c=relaxed/simple;
	bh=LHJP+8qkvJtxtXl2FKr6PS6bR3RBDHRpfQtt/vbgtzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bVT9g4w5Jpvos/HnapKOItgVEZePjUml2RTiBydWJ9paeC9V69UMR5Id32RFRcS2X0/jIdQbTfUViGbpefGHO7AoSg5zAyhB8G+FTWea1kUd7ziuQ0DR9R+N+dxD0MAJy6sZgxUcLY37rGFkm6LqXoyf+pAV+inpRCi7BxJam84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSPwN2FY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSPwN2FY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752545819; x=1784081819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LHJP+8qkvJtxtXl2FKr6PS6bR3RBDHRpfQtt/vbgtzs=;
  b=cSPwN2FYOc4eu+ALAAaWzC6Di8ZOg0n5e27aKIRonxjJNEZpngSD23vF
   +X75xoh/b5PzVTkYyx1qZcE6xfwiXp/63THBPTKCwQdM1L0o6ePFl4wUb
   IJIklfp1jYco0Vrivt6YAKfzSHufy3QQCujBZYs2aoSvWFaQDJmcR+ccN
   8wxrYS4ejcJA/hoijyuk0UNLMCqkNGufk+h6Pilyv3xXyYDBSxO/kC06K
   wdMbSexHWvcJtqt41GwW8BRUrnSQKoG856nWhNsirhEf5bVawv6YjRV4b
   1snyxS1bZVFODclxMWDJDgUD5Bh3NI3l0wiQVYH7Vrtaqf9CPPYttC06k
   Q==;
X-CSE-ConnectionGUID: zqpZrBHiQZSKvRgDlIb+bg==
X-CSE-MsgGUID: EQjblXpiTOSLj4IYRlywIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54899340"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54899340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:16:58 -0700
X-CSE-ConnectionGUID: gkotVeoYTgeU4G+uMttPlA==
X-CSE-MsgGUID: MK3THJiUSUyDpGBoTsqSsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157637165"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:16:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 19:16:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 19:16:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 19:16:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPBvz0m4PwbkwqnVoNoDbKm7jZmR/g6ftcWPGExUtuO/aj94OWLYP8lBfmH7isi30b11wefPCpq0QKAMcm66dpnm1So8eTzBteMyzJbuuelHRKV2rY3vNl6GCY0eKLSvOmrkQWGUC4yanakkoI8OYnHlfEyL2G63ZkLePWUAAANJf3hR2NgVgujjdpACRceDZRO0byi9SavcPnAU5C+AnETimVQU9Jv+nd9bAtWQzFJ4mvqw2nJAMGIlCHZN9rLS8MfOYEohvjI8rNqN4R2eUYNIEgFEvzoPIHRXU3q6Danzebg0qzH/YW3ejlX4YFlgwdevdr4rtsmF2X4iCAEe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHJP+8qkvJtxtXl2FKr6PS6bR3RBDHRpfQtt/vbgtzs=;
 b=VuiBv4fdEHCqiJi+EowSEAetRxYX2B5nTHL7tD7dqOs2yi/87IPHDbcmmrKlSk3cwwNaLdy/fh9fwuZR1b1Z3P82m3bQWgFn3iGAbNF2hrYsk+yIjRz3tdJgQbKSqJJA9AnCG+AaCAn/pYK+PB7m3vPWuPX7x5M0rn7B34efEqwiGs3TP/SQyfSgZpFzHlkkAkU5oRvFWL102ZBuTJlo/G/+IOe4jCq5LT1ZNBIUd6I3PJqQ6hj94UN+csvpMEunIfMpsTBuJn0daglqCsHzjrqNJSiDGMZ57wsQKtyjtI882p9OpztzdknTjDBbaA6QZtv07zdUvhihKY3x6VO0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DM3PPF4C690C788.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 02:16:39 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:16:39 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
Thread-Topic: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
Thread-Index: AQHb7u+FIJM3uUpiRUaJUhiWwfHCSrQmL0AAgAH5N9CAASeugIAJLY9g
Date: Tue, 15 Jul 2025 02:16:39 +0000
Message-ID: <PH0PR11MB7585F0D73FA7524481DF47B8F557A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
 <20250707034657.929092-2-kiran.k@intel.com>
 <c670c490-04eb-4d5e-921e-e2645489e180@molgen.mpg.de>
 <PH0PR11MB7585A3C89449C58883012E23F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
 <841939db-cd2e-4f8e-a4f5-89d76b52d223@molgen.mpg.de>
In-Reply-To: <841939db-cd2e-4f8e-a4f5-89d76b52d223@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DM3PPF4C690C788:EE_
x-ms-office365-filtering-correlation-id: 7e771f91-1ea2-4502-b6e0-08ddc345a1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U1pEVjNmNUJtdXkzSUU1K2JwYm1HY1I1N2tUSXZOZ0ZCUXptTFhxNU1KTXMr?=
 =?utf-8?B?ZkwzT0VENmNLcWVCcDBnc0xIQmFNQXpOTnJ3YnBEQmlnNjIvaEx5V1ZCeUcy?=
 =?utf-8?B?L0plWWRsaDRXdnFma1hoMkttZ0djL2xYQWpHblBQQ1dBV2JlWjJvWDkveXhv?=
 =?utf-8?B?Z3c5a1pVd2Rxb0pUK0hmWEo2V3dJSUhsYnBGQSswMzdxRlkrcFUrNWxFQWdo?=
 =?utf-8?B?WmQ1enFuMUpsNFAwSE1xZnlyMFJkYUFPdkhUYkRKTktmWHhyYlVBK2h6NzdI?=
 =?utf-8?B?T3pyWE1KdGYzWGFTb2tGL1liSVVicXpiR0lmbHZ0V3pYZm9UemUyNUZueXZI?=
 =?utf-8?B?cDBqNXBRblM3MUVyMS9Pb2NpMEllNW1zQXhiWFgxVklseHpBRDllTjVtMUJE?=
 =?utf-8?B?TFRML0IxNWk1MXMwanZibWtBbmlKdGxLTWNvazVJK29IYzl6NVlhZXRrdlZw?=
 =?utf-8?B?QlRQWnR2L01hWk5rNFpJeW9WRTdJZlYreGpTMGtBRlhvRlB2amxjSzNlc20w?=
 =?utf-8?B?R3V3UDlPQTdpTXQyUmhCSXRPQndEaVhFd0RqaFNQdEtFVWdMVkdVYTlJTHNT?=
 =?utf-8?B?MGo3YUlyQ05GK2FzS1ZweWZuN0d6NEQ4WjBuU0FpbGtqMy9lbytHZWlZS3hy?=
 =?utf-8?B?NmRJMEZFODNFUnpiejlhVndFWTkzY0F4SUF5MzNucmt1YmRIdGhEUHExZ3Zw?=
 =?utf-8?B?V3RtWkpvc3ZRRjBrYUZJZzc0WC9IcTBIenN2WkhRRDhISUppRVU4K29RMTQ4?=
 =?utf-8?B?UXBZU2FQM3pVWmh3cHcvTzM4Mm1oUUl1MW5ScDJpSVZPZURrcWlhd3IrbTk5?=
 =?utf-8?B?aFdJYVBKVWhDL0Jsbm93MCtaWFk4VmxCVnA3UkRpOVprSGwvQzAzY0FXTmZU?=
 =?utf-8?B?bFd2RjZnQ1VBMldEeC92WEZjM3FOaDl2ZDZDR3FLUHBzd09mZTRMVWVwb3V1?=
 =?utf-8?B?eEg1eDRhMmxLMmlORWlzRVVDWFhpcG56Z2pNSFVDWVgzZVUrWFNQN015UGh0?=
 =?utf-8?B?VWp6eStlYjl2d25kRXlNRHJWK0dabFZkSUtXY3NYNjZ4QWFtMWZDa0lnTFgv?=
 =?utf-8?B?WndaWlVlTUlDTmwvR1FHd3FhZGwwcFVyOXdyRHRGV2ZRK3Y2bjJDMUZFYzRK?=
 =?utf-8?B?eENHKzVyZmlaUzBMaW82cnlOSTFKc1RhQk9TMXdaNDZkV2FUR3RUd3RDSkxX?=
 =?utf-8?B?em5ndWhpUVp6c0ErREtuRkV2WndaeFRvalNZV3ZFQ1pOcE9DTjBoL2tQajBG?=
 =?utf-8?B?b05DT296RWNQT2hWbXp3ODh5b3lEZWNrRGNITEZBQnczVXY1MWVlSElRb3Rw?=
 =?utf-8?B?VlRSQ3hRYk82N21nRFJ0NEhrRjlNam9Tb2Via1JJWERtUlZMYk4xNlhwV1NS?=
 =?utf-8?B?aXlCR3BMUWRCYWFlS0tGZEQyUWtMQmtMejNpcWJqeU1YU0VzclVKS2ZKZW1H?=
 =?utf-8?B?T0lWSFNSd1BCUmJINFdDZ0w3a2szMGYvU3J3Wk1vWEdwbDBOeVVYcU42QWZQ?=
 =?utf-8?B?eEhKRzJLY0c2a28wdC9lRXhkMkYzdTNWVWsrOFMzS3NpMHhRWWlBR3lOTlNZ?=
 =?utf-8?B?OWVwa0JueWhXaEVWZVBpckwram1nTTdwT0pzdkVOc3VidE9EYWZ6YVlkRC9Y?=
 =?utf-8?B?djdRcVB2ckpTL0FUbFcxclorZXJ4a0JxWGlMRURTaVBlZGJBRVhiYmxsK29i?=
 =?utf-8?B?Q0hFQnlXcUIzcnVYa3d1VlBLVjJQZmx1REN0M2JTNC85aHdiN1JuOVN6dlBV?=
 =?utf-8?B?emJqUjhRb2FSbU1PeXJRTlpRcG02U0tQOGxGVlN5T0Y5VUtkK2pTZnI0V0N6?=
 =?utf-8?B?RXpESHpObGJOT2RNc2xPdEZab3IyWlZkR28zZFRwc0JvTDk4Mi9Jb1ZNY28y?=
 =?utf-8?B?eld2OFE2VTQ0Z0ZRa1hHa2JKVlRmWER3UE9nNnJuR2NrcXBJSUxBSG5XSjRO?=
 =?utf-8?B?RHBNQzZNZ1Q1eDRXRkRoSWx5cmNYQ0hoNjlZZXBtektkbHRheURyVktobHJV?=
 =?utf-8?B?TDNOM2dDMFZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXF3T29VOHRUaWlvWDlvUVhoL1BMaVV6L3R4dThScGgxN1gvN294YS9MY2pW?=
 =?utf-8?B?RUhweXFwQnc1ZkJWaVAxNTZvMVE0dFJqaWI3WWtFMzVuZXp2dFFXaElNcHk3?=
 =?utf-8?B?TFFhU3JVQitwZTV0RHo4R0o0NmRwRVRIQytZWllTbXpvUEVLaS9ENm8wY3Zq?=
 =?utf-8?B?Q1lmeC8wbEMzbVVpbzRobWhSSlNqc1ZLa0ZiWldsZVNqcjB2eEdFRmNLOSsx?=
 =?utf-8?B?WGdCdkxRS1VCK2l1SHBBME5CT012cWZPblVod0pYd3RucjVnckZwY0NTY2FO?=
 =?utf-8?B?N09mTHM0RmpWYmNORjVIaDBoQWFQYk1MMUxYRmlGUlptcVZHdXhmbHh4MkVY?=
 =?utf-8?B?TjFvSlRYK0pKZWErSnVtWCtFSkhQbXZpZWJJaHlHQlVjdVNCL1VmcW45T2Qz?=
 =?utf-8?B?N1ZKQkh2V1U4aWhGaTBENXVDNGt6bGQxemxydjBsc3Q3QTJGaUkzcjRsMEd0?=
 =?utf-8?B?aUE2cm1DWmVudDczQnZudno0L1RqbXdlSGlGODBZSWk4cmRGVUptOEcrZEpD?=
 =?utf-8?B?cklLTGpCS2RtcVBGamVxOUw3dFN5SWZlUUN1bXU5QlhFODNlSTRDUUNONVlD?=
 =?utf-8?B?NUxFb1FQWUt4d0NqZjQwTFF4TzZyaTYweHhXUk9LdEZrMDVab0JEK3NwMVlq?=
 =?utf-8?B?V2ZrU3MxN0lFcWVWWGs1MGw1bEtON0VnRkVzQ0VOOEVHOW9jNE9tMkQrTGlz?=
 =?utf-8?B?aDRCTFhCSzFjNm85eElVRG9qNWJyTkxDNTZENlhXSC9nc25wNzF5NEJCcDJY?=
 =?utf-8?B?MHpZUHRLRUR4TVcxL3hjZFNGbW9HUitPVGJ1WlgzSTFIa24wQmtZQVJNYnFp?=
 =?utf-8?B?MHlMZTAvbXFYN1NlelRreWc3cmUycnBpb0JBcG0wNi8wTFQwdm5kak5lT3Bo?=
 =?utf-8?B?K1dIZGFtSzhqWXYwaTdUV1ZFajRxdVhSRUJOUStnaGVxbUlpMk1RKytlSXdr?=
 =?utf-8?B?MkxIYUR6b2FXK21iVzY5Vm43NHdmSW0veDRxNFdBM2d6Q1B5Q0hLZHhCWlkv?=
 =?utf-8?B?UHhxbjZGMWYzS2RJOHkxbXZVYmpheXYydSs3RDZzUUtXektLY3gwalZ4K2RV?=
 =?utf-8?B?VzB5SCtYbWdzQUVMbmxsQW9zdUNUZmpyTXpES3dHT1l4NFpMaVpOMTZCRVdQ?=
 =?utf-8?B?bmlJSTNtUDFhVjJhOHIreU1abE91SzBIUlJoa2JkaXFwZmk2dEQvc254WEVt?=
 =?utf-8?B?K212UUxETEovNkRQcVFCbjJUcUF0cGxIdXJVYWEzdGhXVFpoMEhKQTYvTzNO?=
 =?utf-8?B?bUpnRllFa01KWlNVS09GM0hDeDJGNlJ4SzQxMy94TXVsR05LVWIwRXhaZnU4?=
 =?utf-8?B?Znp3eWZONGl0WTRqVVg2K3VCelpORkZxaVZLbjk3TDl1N29NTjloRUM1WHFu?=
 =?utf-8?B?VW1NVmJtVitNc0ZISzlFMmlUeEVxZDZwUGFJYWxRTTJ4dUdHUjFaMHBtbXh0?=
 =?utf-8?B?YmtKSEhVNEdBdWQvRUFMN0ZSb0J4NkpzMStTT2thK0hPcTg3SnhZdm0ybUp3?=
 =?utf-8?B?OGJmVnNOaTFNWWpPOHRseUh2cVBKMW9VWU9kdC9ZNTVaTk5oYzZkWTQrc1lO?=
 =?utf-8?B?ekhMeUhBRVFIREdnZGNVbnRLczc2RWlja1pwTjhXaENtWGJ5TENTdk43YmVS?=
 =?utf-8?B?YU5NSzJmMTRoWnRiSk9KZVJ5K0gzODdvN1JDYTIzSUVzMHNBTzV2SzdoVzR5?=
 =?utf-8?B?MGs3VmhNSmE5TDJHQ1BNZ3o0bFdzN1pEVVlqS0J1dmJ5Q3RPcTlKTDdYYWFu?=
 =?utf-8?B?Z21KZFEwaGNOWFlGUGMvZlJLNlhyY3czQnZKdWtQU3NOcFpSUXpGeHcydHZm?=
 =?utf-8?B?ZmxtRWdtN0RObVpMRG5lc0IzVEJ1emVGRXEvNEV3SE53MFpHckxFOWFHcy8x?=
 =?utf-8?B?a3REVUZwai9ST1plVVVla1dHVFhKUHFvUUdNZGJFeFpqMXFHdXZROEF6YnRO?=
 =?utf-8?B?d2VRU04rRE9RSnhNRVpJaXpOb3FqNWdiKy9pRWw4NFJvVCtHMlVtK3RzTXNz?=
 =?utf-8?B?elBsSzlWcFQwb294T045UUtqeDE5bFFacjdzVDJTbU9meHlrdlJaVkJNM09D?=
 =?utf-8?B?QXpXeXdFZ0k5dk9MOTNrdjRQVHJVNFpWd3k4Rm5hSW5wUUFsOXFPZmIwRzlW?=
 =?utf-8?Q?4RQI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e771f91-1ea2-4502-b6e0-08ddc345a1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:16:39.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/s0zKKBhCVcCH5ZkvNIVfSF7Vwtr40+21Yb+x/Un/1ziYvH62C9Xo8ogBxI1jhjdp+QxVNsk+aPY4HIqcv4sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C690C788
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogRml4IGFsaXZlIGNvbnRleHQgc3RhdGUNCj5oYW5kbGluZw0KPg0KPkRlYXIgS2ly
YW4sDQo+DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KPg0KPkFtIDA4LjA3LjI1IHVt
IDE0OjMwIHNjaHJpZWIgSywgS2lyYW46DQo+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAy
LzJdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBGaXggYWxpdmUNCj4+PiBjb250ZXh0IHN0YXRl
IGhhbmRsaW5nDQo+DQo+Pj4gQW0gMDcuMDcuMjUgdW0gMDU6NDYgc2NocmllYiBLaXJhbiBLOg0K
Pj4+PiBGaXJtd2FyZSByYWlzZXMgYWxpdmUgaW50ZXJycHQgb24gc2VuZGluZyAweGZjMDEgY29t
bWFuZC4gQWxpdmUNCj4+Pj4gY29udGV4dA0KPj4+DQo+Pj4gaW50ZXJyKnUqcHQNCj4+Pg0KPj4+
IChJIHdvdWxkIGhhdmUgaG9wZWQsIHR3byBkZXZlbG9wZXJzIHdvdWxkIHNwb3Qgc3VjaCBhIHR5
cG8sIGEgc3BlbGwNCj4+PiBjaGVja2VyIGFsc28gaGlnaGxpZ2h0cy4pDQo+Pg0KPj4gQWNrLiBV
bmZvcnR1bmF0ZWx5ICAnaW50ZXJycHQnIHdhcyBtaXNzaW5nIGluIG15IGNvZGVzcGVsbCBkaWN0
aW9uYXJ5Lg0KPj4gSSBoYXZlIHVwZGF0ZWQgdGhlIHNhbWUuIFRoYW5rcy4NCj4NCj5odW5zcGVs
bCBvciBhL2lzcGVsbCBzaG91bGQgZmluZCBpdCBieSBkZWZhdXRsLg0KPg0KQWNrLg0KDQo+Pj4+
IG1haW50YWluZWQgaW4gZHJpdmVyIG5lZWRzIHRvIGJlIHVwZGF0ZWQgYmVmb3JlIHNlbmRpbmcg
MHhmYzAxDQo+Pj4+IChJbnRlbA0KPj4+PiBSZXNldCkgb3IgMHgwM2MwIChIQ0kgUmVzZXQpIHRv
IGF2b2lkIHRoZSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24NCj4+Pj4gd2hlcmUgdGhlIGNvbnRl
eHQgaXMgYWxzbyB1cGRhdGVkIGluIHRocmVhZGVkIGlycS4NCj4+Pg0KPj4+IERvIHlvdSBoYXZl
IGEgcmVwcm9kdWNlciBmb3IgdGhlIGlzc3VlPw0KPj4gWWVzLiBJc3N1ZSB3YXMgcmVwcm9kdWNl
ZCBpbiBzdHJlc3MgcmVib290IHNjZW5hcmlvIGFsdGhvdWdoIHJlcHJvZHVjdGlvbg0KPnJhdGUg
aXMgbGVzcyAtIDEvMjUuDQo+DQo+SXTigJlkIGJlIGdyZWF0IGlmIHlvdSBhZGRlZCB0aGF0IHRv
IHRoZSBjb21taXQgbWVzc2FnZSwgYW5kIHdoYXQNCj5zY3JpcHRzL2NvbW1hbmRzIHlvdSBydW4g
Zm9yIHRoaXMgc3RyZXNzIHJlYm9vdCBzY2VuYXJpby4NCg0KQWNrLiBJIHdpbGwgdXBkYXRlIHRo
ZSBjb21taXQgbWVzc2FnZS4NCg0KPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJh
bi5rQGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2FpIFRlamEgQWx1dmFsYSA8YWx1
dmFsYS5zYWkudGVqYUBpbnRlbC5jb20+DQo+Pj4+IEZpeGVzOiAwNWMyMDBjOGYwMjkgKCJCbHVl
dG9vdGg6IGJ0aW50ZWxfcGNpZTogQWRkIGhhbmRzaGFrZSBiZXR3ZWVuDQo+Pj4+IGRyaXZlciBh
bmQgZmlybXdhcmUiKQ0KPj4+DQo+Pj4gSeKAmWQgYWRkIHRoZSBGaXhlcyB0YWcgYmVmb3JlIHRo
ZSBTaWduZWQtb2ZmLWJ5IGxpbmVzLg0KPj4gQWNrLg0KPg0KPlRoZXJlIGlzIG9uZSBtb3JlIGNv
bW1lbnQgYmVsb3cuDQo+DQpTb3JyeS4gSSBtaXNzZWQgdGhpcyBvbmUuIEkgd2lsbCBmaXggaXQg
aW4gdGhlIHYyIHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KDQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2
ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDI1ICsrKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9w
Y2llLmMNCj4+Pj4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4+PiBpbmRl
eCBmODkzYWQ2ZmM4N2EuLmQyOTEwM2IxMDJlNCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbF9wY2llLmMNCj4+Pj4gQEAgLTE5ODgsMTAgKzE5ODgsNiBAQCBzdGF0aWMgaW50IGJ0aW50
ZWxfcGNpZV9zZW5kX2ZyYW1lKHN0cnVjdA0KPmhjaV9kZXYgKmhkZXYsDQo+Pj4+ICAgIAkJCQli
dGludGVsX3BjaWVfaW5qZWN0X2NtZF9jb21wbGV0ZShoZGV2LA0KPm9wY29kZSk7DQo+Pj4+ICAg
IAkJfQ0KPj4+Pg0KPj4+PiAtCQkvKiBGaXJtd2FyZSByYWlzZXMgYWxpdmUgaW50ZXJydXB0IG9u
IEhDSV9PUF9SRVNFVCBvciAweGZjMDEqLw0KPj4+PiAtCQlpZiAob3Bjb2RlID09IEhDSV9PUF9S
RVNFVCB8fCBvcGNvZGUgPT0gMHhmYzAxKQ0KPj4+PiAtCQkJZGF0YS0+Z3AwX3JlY2VpdmVkID0g
ZmFsc2U7DQo+Pj4+IC0NCj4+Pj4gICAgCQloZGV2LT5zdGF0LmNtZF90eCsrOw0KPj4+PiAgICAJ
CWJyZWFrOw0KPj4+PiAgICAJY2FzZSBIQ0lfQUNMREFUQV9QS1Q6DQo+Pj4+IEBAIC0yMDEyLDYg
KzIwMDgsMjAgQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfc2VuZF9mcmFtZShzdHJ1Y3QNCj5o
Y2lfZGV2ICpoZGV2LA0KPj4+PiAgICAJbWVtY3B5KHNrYl9wdXNoKHNrYiwgQlRJTlRFTF9QQ0lF
X0hDSV9UWVBFX0xFTiksICZ0eXBlLA0KPj4+PiAgICAJICAgICAgIEJUSU5URUxfUENJRV9IQ0lf
VFlQRV9MRU4pOw0KPj4+Pg0KPj4+PiArCWlmICh0eXBlID09IEJUSU5URUxfUENJRV9IQ0lfQ01E
X1BLVCkgew0KPj4+PiArCQkvKiBGaXJtd2FyZSByYWlzZXMgYWxpdmUgaW50ZXJydXB0IG9uIEhD
SV9PUF9SRVNFVCBvciAweGZjMDEqLw0KPj4+PiArCQlpZiAob3Bjb2RlID09IEhDSV9PUF9SRVNF
VCB8fCBvcGNvZGUgPT0gMHhmYzAxKSB7DQo+Pj4NCj4+PiBXaHkgbm90IGtlZXAgdGhlIGZvcm0g
b2YganVzdCBvbmUgaWYgc3RhdGVtZW50IHdpdGggJiYgaW4gdGhlIGNvbmRpdGlvbj8NCj4+PiBh
cyBiZWxvdz8NCkFjay4NCj4+Pg0KPj4+PiArCQkJZGF0YS0+Z3AwX3JlY2VpdmVkID0gZmFsc2U7
DQo+Pj4+ICsJCQlvbGRfY3R4dCA9IGRhdGEtPmFsaXZlX2ludHJfY3R4dDsNCj4+Pj4gKwkJCWRh
dGEtPmFsaXZlX2ludHJfY3R4dCA9DQo+Pj4+ICsJCQkJKG9wY29kZSA9PSAweGZjMDEgPw0KPkJU
SU5URUxfUENJRV9JTlRFTF9IQ0lfUkVTRVQxIDoNCj4+Pj4gKwkJCQkJQlRJTlRFTF9QQ0lFX0hD
SV9SRVNFVCk7DQo+Pj4+ICsJCQlidF9kZXZfZGJnKGRhdGEtPmhkZXYsICJzZW5kaW5nIGNtZDog
MHglNC40eCBhbGl2ZQ0KPmNvbnRleHQgY2hhbmdlZDogJXMgIC0+ICAlcyIsDQo+Pj4+ICsJCQkJ
ICAgb3Bjb2RlLA0KPmJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwN
Cj4+Pj4gKwkJCQkgICBidGludGVsX3BjaWVfYWxpdmVjdHh0X3N0YXRlMnN0cihkYXRhLQ0KPj5h
bGl2ZV9pbnRyX2N0eHQpKTsNCj4+Pj4gKwkJfQ0KPj4+PiArCX0NCj4+Pj4gKw0KPj4+PiAgICAJ
cmV0ID0gYnRpbnRlbF9wY2llX3NlbmRfc3luYyhkYXRhLCBza2IpOw0KPj4+PiAgICAJaWYgKHJl
dCkgew0KPj4+PiAgICAJCWhkZXYtPnN0YXQuZXJyX3R4Kys7DQo+Pj4+IEBAIC0yMDIxLDEzICsy
MDMxLDYgQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfc2VuZF9mcmFtZShzdHJ1Y3QNCj4+Pj4g
aGNpX2RldiAqaGRldiwNCj4+Pj4NCj4+Pj4gICAgCWlmICh0eXBlID09IEJUSU5URUxfUENJRV9I
Q0lfQ01EX1BLVCAmJg0KPj4+PiAgICAJICAgIChvcGNvZGUgPT0gSENJX09QX1JFU0VUIHx8IG9w
Y29kZSA9PSAweGZjMDEpKSB7DQo+Pj4+IC0JCW9sZF9jdHh0ID0gZGF0YS0+YWxpdmVfaW50cl9j
dHh0Ow0KPj4+PiAtCQlkYXRhLT5hbGl2ZV9pbnRyX2N0eHQgPQ0KPj4+PiAtCQkJKG9wY29kZSA9
PSAweGZjMDEgPyBCVElOVEVMX1BDSUVfSU5URUxfSENJX1JFU0VUMQ0KPj4+IDoNCj4+Pj4gLQkJ
CQlCVElOVEVMX1BDSUVfSENJX1JFU0VUKTsNCj4+Pj4gLQkJYnRfZGV2X2RiZyhkYXRhLT5oZGV2
LCAic2VudCBjbWQ6IDB4JTQuNHggYWxpdmUgY29udGV4dA0KPmNoYW5nZWQ6ICVzICAtPiAgJXMi
LA0KPj4+PiAtCQkJICAgb3Bjb2RlLCBidGludGVsX3BjaWVfYWxpdmVjdHh0X3N0YXRlMnN0cihv
bGRfY3R4dCksDQo+Pj4+IC0JCQkgICBidGludGVsX3BjaWVfYWxpdmVjdHh0X3N0YXRlMnN0cihk
YXRhLQ0KPj5hbGl2ZV9pbnRyX2N0eHQpKTsNCj4+Pj4gICAgCQlyZXQgPSB3YWl0X2V2ZW50X3Rp
bWVvdXQoZGF0YS0+Z3AwX3dhaXRfcSwNCj4+Pj4gICAgCQkJCQkgZGF0YS0+Z3AwX3JlY2VpdmVk
LA0KPj4+Pg0KPm1zZWNzX3RvX2ppZmZpZXMoQlRJTlRFTF9ERUZBVUxUX0lOVFJfVElNRU9VVF9N
UykpOw0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClRoYW5rcywNCktpcmFuDQo=
