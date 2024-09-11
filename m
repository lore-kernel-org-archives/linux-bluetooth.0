Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384114A097;
	Wed, 11 Sep 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051851; cv=fail; b=UomrWxmaZ/3mwGJpN4w/0g0wAzas5oBWD+yLvZB+Nr+/t2egcfGWRyMb6SHvx8vLL4mT1zUj1LKQR23hqnROn3LZLiLBKcC/Yc5ltrGk39Ngdppsmj7yb3sqNqBbH8QUKooJgfK7oZpC54vpvvxV/DohkwvYE0WMSPlEHReo1t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051851; c=relaxed/simple;
	bh=bXJDq1jPKIZ9smjOnuDw3rw6KBF6ZL2gGitFESkLf/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qDtjGiIOhTMYIBy5YywX+uV5E9MFfhjcUxD7/DJPOsk2tru1D4R1vbgtmJhDk9geMcmGr4b1pXlLQCqHrP8a7/nAOvU4lqJsV9TpckASf/9SzY+jUYmo5tq72uXX2uvQKmYS4mbFhKJH132dZqRNxfxsZPREdACFSsmmQW5jFwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8oC8aRZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8oC8aRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726051849; x=1757587849;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bXJDq1jPKIZ9smjOnuDw3rw6KBF6ZL2gGitFESkLf/k=;
  b=A8oC8aRZEzugkPhLtm0TnOPR1Z6qP0z/qPPTct6gxeta4qlHvVzhAqQN
   K/KUP+Jj16Lxph3xu2uITiLRk2+98ujpS/2C26KvZKhKX+70GrhZVTGeo
   Uw77BsUDwhLv68HBbcWhNCIAhomb/NWUKMwPDc7nj7oIfMT8J2MIsjxFF
   Oj7XlT0tN3UR8p1bkEawZIQN0FAqpH0HyEDHQmcKXJgYndUH4vh9y7jMv
   G25QjSBHroSr3oqNiNuVHB4Sy68/t1TmQ042ve44LdQjzZ3KiXl/Ds7VF
   39I0Pi6iZlXhjMFGwPSz94F42OdshekY4yyKyKTIWa4f6+dVCwTkfMTg2
   Q==;
X-CSE-ConnectionGUID: wlpfd2lHTbu1QSLOjrMCzQ==
X-CSE-MsgGUID: 7wkeYQnaTraTL88QD6Hu/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="47360579"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="47360579"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 03:50:48 -0700
X-CSE-ConnectionGUID: aTmGOPtQS3G71HLaQAiuxw==
X-CSE-MsgGUID: eSw8KD1wT5Czoy4XHJtVXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="98167732"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 03:50:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 03:50:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 03:50:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 03:50:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee8nRWTaBXoJJ4DUelGiqvHkiLjq9uqsMvZThEjo6WfnwRMvlPDaN2AcWz20sZxeVDxwiYG/KNlFBVnCvekJGgehkbMk6EvJVsTCHFdtLiLsVG3z254e3XS66QddK0kjFPHWqRyYVLEvMA1GmIwT/qUW1Dw7m6bpRkxIXHciKOjFGifpT7xsdcOEIe1fe0wGuq4dG8bqydXp/7KqVUWYHefVVWPVd9dI0vbyFEljOaGgt2hMonbSHASEvhhrjtB3/eVhVn9+rS7vj4CNxQoe+wUqdwysCjquY9lip+BHgSpMbdPaUREkJhfXhayJJNs5TvAFou4XDln8bYKEi9G/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXJDq1jPKIZ9smjOnuDw3rw6KBF6ZL2gGitFESkLf/k=;
 b=sk2bH/qy6wtBsy1xca/0mE9EEExuoYFeWe7YEHCkPFVwolhdxFMARNogYPgh6blSwlTuzlv1WykSjYduWeclYz5U8v3jhYLBeVqJbzVrqymKtdJ2XwEJaGlPSfZ6AoO7weeijmjhsCPxVFIEMq5jK9yKtCNPPl7giSDgc7iJZzo+g3kD2nzugnAySy9IF8pxEIzG42RHi2zc0TgrqElJ9fwP7FuRzMa64I+WSDZvESvzK9tH+72uOWnw+NKRF8IGjOQtCd04wJC1LkU2Yg1EBql2K/ST4H5zAigiyJ7/fkgJv/XfGbllEpONkvnFeJnejwSyllC65GEzOpBYzolbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 10:50:38 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%6]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 10:50:37 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
Thread-Topic: [PATCH v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
Thread-Index: AQHbAvolSewVtOg41kWxEsI+8rHJ6rJQoN+AgABlhoCAAWPNcA==
Date: Wed, 11 Sep 2024 10:50:37 +0000
Message-ID: <PH0PR11MB7585E7A96E723F8DF79DA488F59B2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240909205152.2397337-1-luiz.dentz@gmail.com>
 <1a2b267a-8d9f-44e6-880d-2383f8b5369b@molgen.mpg.de>
 <CABBYNZKJNT3kY7Ug+S3=v0p2x1S1adR+wmb7RNfy0_DJBqJg1w@mail.gmail.com>
In-Reply-To: <CABBYNZKJNT3kY7Ug+S3=v0p2x1S1adR+wmb7RNfy0_DJBqJg1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB4936:EE_
x-ms-office365-filtering-correlation-id: 92297018-9152-482a-91e4-08dcd24f925d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEFpTUUxUUhqYytjenlZai8xN3lUZ3d5SmllZ1VMd0xCS0NSWjBZQ0ZVT2ow?=
 =?utf-8?B?U3d4YStWOEVEazBLREdPUldETWtBTWlZTlY0TUlRYXdHbWtnVG54T0Z0TktC?=
 =?utf-8?B?SEV3cWZ5clJkSzg5YzFCc05POUQreDlJK281WmdKREtWc1ErY3lCMHZUWGg3?=
 =?utf-8?B?R2pGNW1ZWUU5cjc0cVJZVVBPTHlDNzJ3dDFUZStvcjN0eEJJM0ZnMVRlZ0xq?=
 =?utf-8?B?cDc2TkNmaEVaOVRuN1NoMzhBM0Q4Q1NzRmE3d0h2amNzbldiNUFiblAzYjRK?=
 =?utf-8?B?TFp4SGFITlhYd0prNFpWT3QydmtMN1BWZkdVUnNTMWpXQlBrTDhNU3gyaThx?=
 =?utf-8?B?LzRTVGViVU5ETHRISnNCczgzaUlBQW5YOVA2b01hTlJTZmc3NzV0SkNhbjhY?=
 =?utf-8?B?eEd2YkgyU3NRQUZ4cXM0UUh3RjZkUXdQN1o5WlZKeEhQWTZLNm4rL1hudzZj?=
 =?utf-8?B?UngyU2FSMWdXNklidWo3d1dsTis4czJUcHg2aWdjcG1SSnNLMW5OdFBpa0hR?=
 =?utf-8?B?aXFJTHByWnV5WFB5SENSWkJWQzRldTcyZ0xvb2l1ajhmZllzU0htaTR2cGJE?=
 =?utf-8?B?dWZ1RkdWWU5OaURqTjltSGhVbU9LcllCSVJuSGRVVHp4ZTRGSjlzSVprTEtP?=
 =?utf-8?B?bnFUeVdhUFE3UjVsSXI1SEZRSC9OSHQ1Y2NZQWdOVXQ5SkJVZHZUT2cxZXds?=
 =?utf-8?B?RzhNc05XT015ZEplZnlmdW1wM2dkYUlhR2E0NFpGVUVuaDBVcUtXczhiWnYv?=
 =?utf-8?B?MklQV1FMamJObHJtQUN2WWY1eVpzZHBNZnR2ZTlTY0ZnUk1hT1R6N214UnVv?=
 =?utf-8?B?OU4ydmJmRHpGNUJ3MUJSTVlaUFpQMGlnWUVUMkpSNjNKYURMcG9URkhZWHRG?=
 =?utf-8?B?bzhPWUhNNFA5SjZhdC8yMHBnK2tUbFlKYURQMXdGVlZLMklSa3NtK05UR29C?=
 =?utf-8?B?cEZySXRZYUdaZUJIUzhKb2tzVHRaeVNFai91cWJuWEZOTXZzb2Q3RUcwQlBx?=
 =?utf-8?B?cVFyWEREaXVvZGpjNFZ4Y21ydmJ1bHNvQk02N3ljTnFyOWs3NzRzRDZuS05n?=
 =?utf-8?B?SGZyWFlZMzRoWWdhWmZGQjd1MmYwanBXSTRMQXNXZ1RrMWVrWGRZVm1nUitT?=
 =?utf-8?B?blNhR25tMFBKNDRCNTZOQUdZM1Y5b1NFa2Vqb25Wa2szKzdHcit0blZoYWw0?=
 =?utf-8?B?MjJWOUg0K3pYdGkraEFZNk5TRXF2cnRvZnFHTHlhMUw5Q0p5YXdxczIramFk?=
 =?utf-8?B?TitZYTFkdTExcFkxV1VhQ0VDOTNTZ1pVWTA3ajRFa0xtK3NTbVRQL0lJRXh5?=
 =?utf-8?B?aTAza2ROa3FjL0pTdTBQRlZPbG1rczRXME5Ca3J6SUNYL1FGK3I4Z0NCbzJB?=
 =?utf-8?B?cExtdDlBSE43OFA2TEpUaCtBQzNjb0ZWOXpmd3ZVSnhCYnQzQ0hTaTJKUnpq?=
 =?utf-8?B?N0xYdkIvTnkwTWd1dHQ5cmt4ZXE5NUtFaDRObTF5SkZEaDBBWXJObTk4MkZP?=
 =?utf-8?B?SWRSeWp3SEU0MlcwYjdBZi9UUks3bGhlTjFpMWlvOFRqUVh4KzhTaWxLckNX?=
 =?utf-8?B?RXlneG1jRWlPY1lhODUveEJGNXZmbDRKaU9XSXdWQVBxclRjZVd2a3hQYjZ0?=
 =?utf-8?B?T1dBS2hjc1FBbTU2VVhjaEthOThqZ0RiK2NUalpKdGNITnNIZVJvSGxkWnZZ?=
 =?utf-8?B?RTl6U0x4bVhuWHVsYzIxY2lKTlo1Uy9LbDNKTHk2SlhIdE1hMGJacnd0SnNF?=
 =?utf-8?B?eUFOVzZaTG9GSVJPOFFUYnVDSVZrR2JDY2Z0MmE4VTBjeDIxVEE1LytZVGZV?=
 =?utf-8?B?d3pYQmp2T1ZKTWcxMkkwelpJcHhXSEpCekdMeXpYSTVqTTBlNm9WVWVLaDc4?=
 =?utf-8?B?eW4rNnBaUW1TVXNDeWc2ekFZVms2NzZLeFdGaEtTK0UwcFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEIxRFFoVkZHQnNJVHRRVUJiUlZQVnhqQ2xEYzg3bUdUQ3BtVlBoa2c1YWs2?=
 =?utf-8?B?SFF1T2NCZUt0U1VvbE1paWdzYlM0NjlibXNoNWR2ZHRGYXI3alo5OUVxSS9v?=
 =?utf-8?B?WHl0RzNIQk5RQTRUWkVKNW53eXgxQ29Ydk1FSTJRTVhmVTVzamVCcUVNSlk1?=
 =?utf-8?B?TFdmRjVsekEvNTJuS1JINTh3TlUwdWVFbjE2U2JqYXpleldKY2dvVnl2blJw?=
 =?utf-8?B?alNEdDFFNERLdmFGWUYvR3QvSVJTNHQrVjRmakpnc1dOdnl4bnpnUHlQajdC?=
 =?utf-8?B?K2RjSHNLVkNlVUk1S3NpVnFSNyt3MTkzaWhEczA2SWU0YVhDZVV2NjFTaFd0?=
 =?utf-8?B?MndTMGtaeUh4WVppaERscEpuUHB3cHZ5bXp5OVlYSy9kYjNFNnkwS2prRlph?=
 =?utf-8?B?OWdhRlV1cGN4d3NTRnFXU2kwUlY4UUZyd0EwN0Mwcml6T01ITWsrRlFaYzJs?=
 =?utf-8?B?dVNReGJ2VFFpcjd2UlU4ZGxxdFJyUm1MRk1tUzYrU2VCNjBobzhpbzYvOTVY?=
 =?utf-8?B?T002TTVnaFRraVdpS0FXaVlCU0t0Nnc2K1JwbmphQit6ZithOElwK2I5TXZV?=
 =?utf-8?B?Q0JDVGRvOURtYUkzc1dCWGgwS0lxQ3VMR2xIY1VTUGRkMENiVWNWR2tvaUth?=
 =?utf-8?B?Z1hQOGd6S0QwWlhRREZNVkV5RmhkSE8yeS9JMG9uL3ZaVERsQTY3OFFUYnhx?=
 =?utf-8?B?QjVqTUxvTThmME52ME1WSkp5QlRZcTFZdFdnMFpqTnRON1RsZ0ZJdGNGRVgw?=
 =?utf-8?B?MVYyM0EyeWJuVjhndHVMc3Y5dW9UekhDQW5uTHNxSUZscUJ2cDRaS1huZUJS?=
 =?utf-8?B?K0JseGgwQWwzMEFYMUVvYmdDWmtZOGZ3ak83WWxqdnZCTERYUitDT0xJM1Zt?=
 =?utf-8?B?QTJZTHJrTEtoMFg3M1Bld0JFYTgrODBDREVET0ZxYVZ1Z3JsYmZjWitlR2Vx?=
 =?utf-8?B?TmRWZi9NeVhPS1dzb21leGdFYkVqUFVqcGkrNDhkUWZTQzZtVlNWQnNENkoz?=
 =?utf-8?B?UGJmY3dSQllkb0FSZHBqOVNLKzVMcXhGUGhJazBJOUNRYnlCNUhjbm84T3BH?=
 =?utf-8?B?MmdBMEpWVlpWUVl6WVlLZ0tPOGVob3BPZXhvWG8wbUgzejZSMDdKMEhaOXpV?=
 =?utf-8?B?SDYvcWhEZHRWdWczb0RMbzdzdDM0b0EwT3FJWEdmZC9yQ3NtMmhTbTA3bFpx?=
 =?utf-8?B?dTcySHJRMmNSaS9lcDFVV25TUzMrQ2dIdkFhL0gzRTcvM2lwYkYrWlpHR2hQ?=
 =?utf-8?B?VnFtWWkwbC9Uc29PNmc5R1hUOU9yTS9DeHFjZU1PM1RqelZ2ejZnaE1HWFJ3?=
 =?utf-8?B?dlBVNFozYUFVS3M2TnYrL2NPTGFnTUdpYTRiNDVmWFBNd3pxRnIxOVBuWWIz?=
 =?utf-8?B?OC83SkFtSUZCaGdVWGFuQ1c5d3NqejhmV0QxcVJ2N2ZjQjZpUVU3ZERkbG5T?=
 =?utf-8?B?MXorcDQzOWxWYkRXSXJKTldPS2V5dmxrT2R6elExVld1d3BqWFNUWnlUUXlI?=
 =?utf-8?B?YkYzQnJKakM3Mm0vckh2UXJ4RDhxekQzME1TOFBkU0NWM2IzYzM3UnlkaHFD?=
 =?utf-8?B?bWVVMmMrWVl5eDl2dGVyNXQyOUQyNHo3a1Zkb3VGMXNaUEo0ajZoemRDdFRp?=
 =?utf-8?B?UndYRlFpTWFMQTJxNDVPQ29yR0IyU1VFaFFLYlNkYm5rR2JOWFg1TVBrZ2Zk?=
 =?utf-8?B?cU9vOUovVDErS0lJeUlwNVN4ek9WK0dTV21rVHh0aTd1dEg3TlU3dDgzSWVl?=
 =?utf-8?B?c00yUXVzNmwzUzd2aGZ3OTVuT1dHaCtZMjBTd0EySnY2Wi9kNTFDdlE0VkFG?=
 =?utf-8?B?bzJja1pZOGxVNUI3eEU2Z01SME1jNW9tUDVUbHNya254SEMrMTZwclhXb1hN?=
 =?utf-8?B?aE1NN2s4NGZUU0dRZmVYSFJmVjBPNHRnSEtWNTMxSWJvRmRTRWt3Y2t5RW40?=
 =?utf-8?B?L3BENkpTT3B3Y3VDbitSV0piNEhRdWRnQ2NIeDc0V1BKbHpDVmVSeFVSKzFW?=
 =?utf-8?B?emRZK2R6bXBGNEhCajBkOEdKNCtnSTZIUm96MElremNGalFlQXJQd3FXU2hY?=
 =?utf-8?B?M1YvS1dQKzM5RE1tL3dpSUZJWXN0K0N4bVd5UDBrT21zUnpnTCthSlpxcVU2?=
 =?utf-8?Q?fZuc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92297018-9152-482a-91e4-08dcd24f925d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 10:50:37.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhq9Xg8mNtHBE+0HReB6v4z2ABxs93MA2WigmjCrkOIAnTDtEr5HJHBDX6bugyNhJBJu3ULOjk+Qz1Uw5iKO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KSSB2ZXJpZmllZCB0aGlzIHBhdGNoIGFuZCBmaXJtd2FyZSBkb3duIGlzIHBh
c3NpbmcuDQoNCj4NCj5IaSBQYXVsLA0KPg0KPk9uIFR1ZSwgU2VwIDEwLCAyMDI0IGF0IDM6MzHi
gK9BTSBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPndyb3RlOg0KPj4NCj4+
IERlYXIgTHVpeiwNCj4+DQo+Pg0KPj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPj4NCj4+
IEFtIDA5LjA5LjI0IHVtIDIyOjUxIHNjaHJpZWIgTHVpeiBBdWd1c3RvIHZvbiBEZW50ejoNCj4+
ID4gRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29t
Pg0KPj4gPg0KPj4gPiBSZXF1ZXN0aW5nIHRyYW5zZmVycyBvZiB0aGUgZXhhY3Qgc2FtZSBzaXpl
IG9mIHdNYXhQYWNrZXRTaXplIG1heQ0KPj4gPiByZXN1bHQgaW4gWlBML3Nob3J0LXRyYW5zZmVy
IHNpbmNlIHRoZSBVU0Igc3RhY2sgY2Fubm90IGhhbmRsZSBpdCBhcw0KPj4gPiB3ZSBhcmUgbGlt
aXRpbmcgdGhlIGJ1ZmZlciBzaXplIHRvIGJlIHRoZSBzYW1lIGFzIHdNYXhQYWNrZXRTaXplLg0K
Pj4gPg0KPj4gPiBBbHNvLCBpbiB0ZXJtcyBvZiB0aHJvdWdocHV0IHRoaXMgY2hhbmdlIGhhcyB0
aGUgc2FtZSBlZmZlY3QgdG8NCj4+ID4gaW50ZXJydXB0IGVuZHBvaW50IGFzIDI5MGJhMjAwODE1
ZiAiQmx1ZXRvb3RoOiBJbXByb3ZlIFVTQiBkcml2ZXINCj4+ID4gdGhyb3VnaHB1dA0KPj4NCj4+
ICgqaW50ZXJydXB0KiB3b3VsZCBmaXQgb24gdGhlIGxpbmUgYWJvdmUuKQ0KPj4NCj4+ID4gYnkg
aW5jcmVhc2luZyB0aGUgZnJhbWUgc2l6ZSIgaGFkIGZvciB0aGUgYnVsayBlbmRwb2ludCwgc28g
dXNlcnMgb2YNCj4+ID4gdGhlIGFkdmVydGlzZW1lbnQgYmVhcmVyIChlLmcuIEJUIE1lc2gpIG1h
eSBiZW5lZml0IGZyb20gdGhpcyBjaGFuZ2UuDQo+Pg0KPj4gRG8geW91IGhhdmUgYSBiZW5jaG1h
cmsgc2NyaXB0LCB0aGF0IGNhbiBiZSBydW4/DQo+DQo+SXQgaXMgYSAqKm1heSoqIG5vdCBhIG1p
Z2h0IGFuZCBub3QgdGhlIG1haW4gb2JqZWN0aXZlIG9mIHRoZSBjaGFuZ2UuDQo+DQo+PiA+IEZp
eGVzOiA1ZTIzYjkyM2RhMDMgKCJbQmx1ZXRvb3RoXSBBZGQgZ2VuZXJpYyBkcml2ZXIgZm9yIEJs
dWV0b290aA0KPj4gPiBVU0IgZGV2aWNlcyIpDQo+PiA+IFNpZ25lZC1vZmYtYnk6IEx1aXogQXVn
dXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4NCg0KVGVzdGVkLWJ5OiBL
aXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4gDQoNCj4+ID4gLS0tDQo+PiA+ICAgZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYyB8IDUgKysrKy0NCj4+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiA+DQo+PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPj4gPiBpbmRl
eCAzNmE4NjlhNTc5MTAuLjgzZGYzODdhZWE5MiAxMDA2NDQNCj4+ID4gLS0tIGEvZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYw0KPj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+
PiA+IEBAIC0xMzQxLDcgKzEzNDEsMTAgQEAgc3RhdGljIGludCBidHVzYl9zdWJtaXRfaW50cl91
cmIoc3RydWN0IGhjaV9kZXYNCj4qaGRldiwgZ2ZwX3QgbWVtX2ZsYWdzKQ0KPj4gPiAgICAgICBp
ZiAoIXVyYikNCj4+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ID4NCj4+ID4g
LSAgICAgc2l6ZSA9IGxlMTZfdG9fY3B1KGRhdGEtPmludHJfZXAtPndNYXhQYWNrZXRTaXplKTsN
Cj4+ID4gKyAgICAgLyogVXNlIG1heGltdW0gSENJIEV2ZW50IHNpemUgc28gdGhlIFVTQiBzdGFj
ayBoYW5kbGVzDQo+PiA+ICsgICAgICAqIFpQTC9zaG9ydC10cmFuc2ZlciBhdXRvbWF0aWNhbGx5
Lg0KPj4gPiArICAgICAgKi8NCj4+ID4gKyAgICAgc2l6ZSA9IEhDSV9NQVhfRVZFTlRfU0laRTsN
Cj4+ID4NCj4+ID4gICAgICAgYnVmID0ga21hbGxvYyhzaXplLCBtZW1fZmxhZ3MpOw0KPj4gPiAg
ICAgICBpZiAoIWJ1Zikgew0KPj4NCj4+DQo+PiBLaW5kIHJlZ2FyZHMsDQo+Pg0KPj4gUGF1bA0K
Pj4NCj4+IEtpbmQgcmVnYXJkcywNCj4+DQo+PiBQYXVsDQo+DQo+DQo+DQo+LS0NCj5MdWl6IEF1
Z3VzdG8gdm9uIERlbnR6DQoNClRoYW5rcywNCktpcmFuDQoNCg0K
