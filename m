Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF834B0C9F
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443918; cv=fail; b=sC4tVZF1fg9g5TgmiotarYEWFGaWzgqnXN0qr59IHqknpdor0AgXuy5rOPqTFmhcoQL0VlaGUgY4VocC0aCtoIi0KxvUNeQMYqxIyC7Q96CqO2D8UmQhbnV+i43RCS0ZuRC63kSbNumco7T6zhNVQANUhD0kcgAdkSXPowk/TPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443918; c=relaxed/simple;
	bh=I2UjSuquzOhrORHA48AMIRjRyVDgUkmUGrJ3oBnM5xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tw5FrPZRV9PZYXf3T/X0J/ho9Dh/gCapWiwaHLVax23Rs9+qrA368RRfjjY6YKQXZ3sjWx9JJc/6wwKLbI+BI9/mZ5f1VJOCYTf+gYz3BNFuV/hD0whRBVNUNKgAUW4d9hCSX46wWxC2VW7n/RcXQlaoV5igEP1N0FZ+eBHLWRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVDmAR1Z; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVDmAR1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788443908; x=1819979908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I2UjSuquzOhrORHA48AMIRjRyVDgUkmUGrJ3oBnM5xg=;
  b=lVDmAR1ZmLTOqIcGX0CfOEZOGIRRCdslaG/3eUGkJNhlNRZwnlpU7Zht
   bX5shXvTlmtDch2BkgkvH7PZEsN+838TvTReJsDekQ/aPLFILutldOUDo
   9m9uMyTJ1eSA+IClT6s6aGgD59wu9UpozVPRZM4CYiqpJ53JIh8LLk107
   EwPG9IFwbhjzlpoJuBRNvQMqeNPrkd73L+JO8C519ukGTo8DMfzMZ0iuh
   Q+uCx/Q+KWCSFmK/TWROzYMbTfXsk4WfAMKs37mqSDerA7WQVKhJHX5JW
   g7MPLFVDlfQjI0S1TH7of3RC1ppNYqcfXnbiorREHi89BxJ0V+JxzEsa0
   g==;
X-CSE-ConnectionGUID: irjJT7vsRKqPt84POjVNfg==
X-CSE-MsgGUID: Llex8V+KQOSScmiLyl5Xtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88950303"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88950303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:58:23 -0700
X-CSE-ConnectionGUID: F05KneEeTvOzzewj1G4R7g==
X-CSE-MsgGUID: Y2dJmxi8RNWKnvrV/xtAcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="307945670"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:58:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:58:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 06:58:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.53)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn74qM5MfPSO/vAluSPmsiwixCq2rTJM9uKIygzqO4YioHzNHefpVEGj48p9YcApKl/V/2kRwvdbB0be8dK1zhvzLGCqAwIllvD8Sj+m9cNSs+10xyviTLCEMBdVGe7CJ3lwZLgE1Jw28iVJuw6ayKaXTx1D7bcSyjSeKbqqFdwzPbZBBw+cz64pDWVNnivk35FdTQXup4x5rE9hsYAHAnbqLEL91KvERSsGBEwIuxafpr2tasG0hNsFiy1eeTSiDSO1UzItfCuWwZmsGhLHUQLoH/hmJVeFMfJeJx9JFVsp4lO4iJj8hSQidefJ2+eFttyvnMSrVyqWPatFP0GQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2UjSuquzOhrORHA48AMIRjRyVDgUkmUGrJ3oBnM5xg=;
 b=tU9iXp4mGbw4XJrqXac2rO31JCRsBULL36D6UGuvmZIMfgS7iVisN3+g+Hk3Zz5EUEDpZesA12B2G3PoFDbtpZTJhSvCEYUVELR3OaeEedZ4pdy/8v3WDQq/Sw9qwKg2pQTbLB+m0weP/ANNtx7nytr5WXVUu1L4MlF46hzObjoTof/GfVN6b+6Z7NI7IORBJntUtkv4yCEExLLSRBwMTHeAH3CnQG03Wo3R/vLXRLpW2Z7sYrHNxM5rVm3EWdVVDNOIMD7tMZ60mHN7eYn15oyUf66wAmjZKQJqEMrCHKbxPsPSOkmg6Ojje1qVaIH6q2xV77AQroavQE4kTfvn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by IA1PR11MB9472.namprd11.prod.outlook.com (2603:10b6:208:5ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:58:20 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:58:20 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: validate packet_len
 before skb_put_data
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: validate packet_len
 before skb_put_data
Thread-Index: AQHdOtrBt8Ng3qAUR0S/y7zYJldwq7a8dbCAgABo1DA=
Date: Thu, 3 Sep 2026 13:58:20 +0000
Message-ID: <PH0PR11MB75854BB3BD61E6007C0DB264F5B62@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260902131830.35502-1-kiran.k@intel.com>
 <f97c5109-2620-4f41-bb9a-cc569bc599b9@molgen.mpg.de>
In-Reply-To: <f97c5109-2620-4f41-bb9a-cc569bc599b9@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|IA1PR11MB9472:EE_
x-ms-office365-filtering-correlation-id: 1cea7cd1-0dfd-4ddb-5d53-08df09c36989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|38070700021|5023799004|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: raORrsq8NkpIyt9z+JFEyfKxjxdEZNZqfZgt11Znr95G9ydFG+tK5oFfKDBss2MYoQkWAacBFpDW4fXda37MHLKCP7Cc1bhhFzBkQKKRNiBedfdcSoTfMAivMHWBC/XgZsCPfkmm+OtHjzb+7LarfWFrMqhkBv++x9cVwXvYEZuDlaV3hoFJev1peDKxYl9WyyJolo0sXUouq5esQdgkS3U9ze8ov1GKP29+u4aMa0BkhmVZCzmLSE+YIXEk7Y9Iu7GjFzDuWaLlYkQ7N32YbJG144vvOLsTYH2+bRhuUOk93hP2k9yfZ93jubMkgponKMAJRxACELWQG9EmKpYzF8lqWVw9rVvjdB4BURUVicZdRvLzwilb3R5Vj3dozNByyNyv9vcC9iXQdYp5yGWglplAXY/me552g0XBEtl8uFVDljQtxctF/o+EbdKV3JuC9KGVRB10IY6+4ZrdeZlO56ZFgASyup6x4betNHDCon8vfB6GpSLbNHmETvYJ6HNnMur1HLNvtNDv10nlMDpRqMSPcyf6kiAvFsLnCpE3uI8ob/S5k4qeG02VODFOKrEQrHsHiwoqTl4Uh5N8XR5h/0JptZ6exp8v3WM4HXzmNvh1PGVwKTVp8NQIprsAMVYy5f0rjRWrsDw7jC8fpwXCcDEB9k365TG7uOFw0MZrZVfk+h4C6dXtVKZmxHLK4iGW6y4ZBuaJttnlRrHjRwfsCACrel7sAR+wCvhiGK1W3l0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(5023799004)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0lySUV3bXEvNDRUWVh1MkY0UTZVV2pkRVhFdFE4QmxWVUxvdzRBeTJIOTg5?=
 =?utf-8?B?c085NFErZXRlNjVqYTRlY2Y4cWFEYVNiblJrZktKMmwyOUZLVi81WVlwck81?=
 =?utf-8?B?d0dtNWxWNVlycktXaUZLVG91STAxaFYzbmFMK1VaVU9DTjMyd1Z4Rjh0M1NG?=
 =?utf-8?B?UW5DcjdtS0UvTVE1REwxTGN5bXdhcEdPOFFJdXRvbkg1bkp0a2V4bVJzcjlh?=
 =?utf-8?B?dmZ0NVRWdlQ2cnRDS21kSFdkVTFjOEMzRit4WDdZdnBibzFEQW5NaWp6M0N6?=
 =?utf-8?B?L2szVGZQaDJMKzFMN1ZtYnFObVZLUWRpM1NHcVZUZ2JBU2U4RWtWVjBpckZj?=
 =?utf-8?B?c1JtSm5Ta1VQanF5RVZYTUVJUmtBTHRxRzVNb2U4U0xkN2xKOE9RQ2pIUWJk?=
 =?utf-8?B?RkEzVURmRDV4UW12SnEwKzI3a2ZjeG5yaEx0VWpJOGViWXdWN1psMVJNWG80?=
 =?utf-8?B?cTNCa3FSTm9BVU9IMkJzZCs1R3pvR29UQWZyKzFEQzkvZ2RQeGhTQXdIK3Vo?=
 =?utf-8?B?OUlFYng3V1gxWDdNU1dzcnhSR3BTUk1BYVE1WWc4SDlIWTZIR3dpc3h3MnNy?=
 =?utf-8?B?TStyOFVyejVDZmRiQ1ZvdzhXcTdPR3hDUWFlbytoUkMzSWN0VkMxa1F4b3Bm?=
 =?utf-8?B?ektNTGl4QTNPdjc3SnlKNE5MbFZrZWVySFNBN1MyS29GSkpZdUFjM25FdVB2?=
 =?utf-8?B?TlRxMGM0d0R4OEtTNmRWTW84T3FJTkJzSjF5K1hEMVkwTVNjODl0dVlqMkJG?=
 =?utf-8?B?Z0tZK3BKc2NBREhJQ3ZmZG5ueGsxL290REI5dkNKVjh4Qkcxa3ZvOXNnZ2g4?=
 =?utf-8?B?Q05xUWx4SFNZekZpVW1wME9LbVZkQkJJWG5vN1hvWmdZa29pRkJZd0d6WTFh?=
 =?utf-8?B?YmRuWjhJVHVIdFVoL3E5dDZzRWhuU1ZiaVdWTmViZlJlNDBzdGxBZ3hHWk9m?=
 =?utf-8?B?bCtIYjdqSi9xeWtLL2FRSThVUzdCcytYZGV3ZmtyNWo4bTlvNlVmaWgrTGlP?=
 =?utf-8?B?RlpRdm1QalEzRDhIZjBCNXVJdXBVbnBacjN6ODllVEJLcXlkQU5ab1l1cFl3?=
 =?utf-8?B?Zlp0MzY4R25FVmFZa1Uwbno2akVPcm04aks2R2RmYkZzekVmOWhtS0VmTWdh?=
 =?utf-8?B?R05Ebk5Gd0h2NXlNU2dQdytSdVNEOUMrcysrUEx6K3RpbGxXbnByQllMODRh?=
 =?utf-8?B?WExBcVQ2ejVqZTVjUjNlRXBsTUpQeGoxeVNnbU9xOXEzS29LQVhNOUVMUGRT?=
 =?utf-8?B?aG1DYWhKc1RaY25oaStTeVBuUDlEbmMwOUJsZmVwSWhMWGZ5R3JjVzdwR3NP?=
 =?utf-8?B?VzhDSnJDM2M4dmFqM1c5MWF4ei9wQlovR2txdVhHU3dJeXg1TWlXYmxkckpu?=
 =?utf-8?B?Ky82NkdpY05ER0JxSWNQVDJrNWZLanIxeUFuYUZGUkR3RnVQcEx1Z0VEOFph?=
 =?utf-8?B?ZTlzMkNWTDhPQVkyTnVvN1hjMHVzR3VxZzA1S1VFNC96cGRrRUYzM29KTmJP?=
 =?utf-8?B?amJIbGVXcnk2UDI2WGU1bkRYWlhxVjF1dzZGUEViL1VIUmtWaWRhcUhWWkxm?=
 =?utf-8?B?TEM1WlI0bFlFSUdPaCtGRys0Vm5pd2R0bFVHaXdETlRSbnVhUkErSVBEWlBI?=
 =?utf-8?B?aXlPdk83N2JRTG4vOEc2d1FhZ1NBV0FkNm1mTS9wejRzek50UU9aVmJCblZm?=
 =?utf-8?B?WkYrM2Q4RVVhQ1o3VC9aRXlGRlY1Sit5N0l0VVZvVWZTdS9ldVNTRml3a2k4?=
 =?utf-8?B?S2pnWHIweFlpSVZ2dDMrVFVidjUzcnFBd3VVdHhaVUJrNjU5cEtCT3RFUnJE?=
 =?utf-8?B?QlRtZXRMNGh5NkNCa2RhUFBCQmlCWmFQSmlCU3B0SVQwV29jeFh0bG84WUFv?=
 =?utf-8?B?RVE3blRDYmcrQWEyM0p5bjhITWxuWjVQTlVBR29pTzVYSi8vTG8yYk51WERt?=
 =?utf-8?B?SUVzaUo1UElneWV0YUF1RWRRVXBqc1gwakw3M0ozQzh5YmhrMWNPdGptYmFD?=
 =?utf-8?B?SnFVNysrYUZIY3h4dkQ3a21ZbG1QWXpqcTJyVHRJd1BrTHRDc2VzZDJXVlIv?=
 =?utf-8?B?UXhOaWIwdkM4d0FKYU5nT1k1Tlk2b1Z6b3FVRGNDcFdxamRFMytyOFJmZUVB?=
 =?utf-8?B?M1pYMTRLaldPQXZoR0FUWFhwblg5a2cvWDZsa2k5RnhnS3hJREwxTEc5RDJG?=
 =?utf-8?B?V3EvaXJYb3hrc1lNMmh6R2x6aFM1ZzZnaG94WUMzbWd3STBYcU1SQTVmZlB4?=
 =?utf-8?B?L1ljRmVsOWpWV2xWN21wY1I4NE1KYjhSallFSWFSbjZUUkFZWjdaRytSQmdq?=
 =?utf-8?Q?R1os5MZq9wS8eG07Oz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BS99UbxHI4x3TmWo9PDwiEKqH2eBYcpwPoSiJSd60mtNQU0i1bVGqb57H+L5jKN1rIhwkDdzAX7fCfa5GelU38XOO15p9Pmbuls5/6Tx1rWAliStGkc1B+ZgZl8fI9CoZopx4r8+jElVC14jcm3vjiaSlGBGuRL7RiV0cNrCR3OeTA4ID2lnySgL+N6ikJXG8/2zjrbeOgw9hUN6mNsWpEpVxQISugdUYKfMvyGFoz6ZKYQMh1NwVVQ+WBBzKOUdWD5wJVz0K0N406S46oiOdh3udp/k9Dg8Cfozpl8W7yPDj17z1XDfa0BaOo4AXyVSlpYmYrGjcIFQ9BQ4lDmhMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea7cd1-0dfd-4ddb-5d53-08df09c36989
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:58:20.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTrHhpdg2slBRPolhMtVUJkpXwJdysbrGS6ayTdVJmnEjaCWoFKT4Cad7/fhZX2EctmEsPR3ezIOxHHkP94Xjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9472
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAxLzJdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiB2YWxpZGF0ZSBwYWNrZXRfbGVu
IGJlZm9yZQ0KPnNrYl9wdXRfZGF0YQ0KPg0KPkRlYXIgS2lyYW4sDQo+DQo+DQo+VGhhbmsgeW91
IGZvciB5b3VyIHBhdGNoLg0KPg0KPkFtIDAyLjA5LjI2IHVtIDE1OjE4IHNjaHJpZWIgS2lyYW4g
SzoNCj4+IGJ0aW50ZWxfcGNpZV9zdWJtaXRfcnhfd29yaygpIHJlYWRzIHBhY2tldF9sZW4gZnJv
bSByZmhfaGRyIHdpdGhvdXQNCj4+IGNoZWNraW5nIGlmIGl0IGV4Y2VlZHMgdGhlIFJYIGJ1ZmZl
ciBzaXplLiBBbiBvdmVyc2l6ZWQgcGFja2V0X2xlbiBjYW4NCj4+IGxlYWQgdG8gYW4gb3V0LW9m
LWJvdW5kcyByZWFkIGluIHNrYl9wdXRfZGF0YSgpLg0KPj4NCj4+IFZhbGlkYXRlIHBhY2tldF9s
ZW4gdG8gZW5zdXJlIGl0IGlzIG5vbi16ZXJvIGFuZCBkb2VzIG5vdCBleGNlZWQNCj4+IEJUSU5U
RUxfUENJRV9CVUZGRVJfU0laRSAtIHNpemVvZigqcmZoX2hkciksIGxvZ2dpbmcgYW4gZXJyb3Ig
d2hlbg0KPj4gaW52YWxpZC4NCj4NCj5DYW4gdGhpcyBjYXNlIGJlIGZvcmNlZCBzb21laG93PyBQ
bGVhc2UgZG9jdW1lbnQgaG93Lg0KDQpZZXMsIHRoaXMgY29uZGl0aW9uIGNhbiBiZSBzaW11bGF0
ZWQgaW4gYSB0ZXN0IGVudmlyb25tZW50IGJ5IGVpdGhlcjoNCjEuIFVzaW5nIGEgY3VzdG9taXpl
ZCBmaXJtd2FyZSBpbWFnZSBjb25maWd1cmVkIHRvIHNlbmQgYSBmcmFtZSBoZWFkZXIgd2l0aCBh
biBpbnZhbGlkIMKgcGFja2V0X2xlbsKgIChlLmcuLCDCoDDCoCBvciDCoD4gNDA4OMKgKS4NCjIu
IFRlbXBvcmFyaWx5IG1vZGlmeWluZyDCoHJmaF9oZHItPnBhY2tldF9sZW7CoCBpbiB0aGUgZHJp
dmVyIGNvZGUgKG9yIHVzaW5nIGEgZGVidWcgaG9vaykgcmlnaHQgYmVmb3JlIMKgYnRpbnRlbF9w
Y2llX3N1Ym1pdF9yeF93b3JrKCnCoCBpcyBpbnZva2VkLg0KDQo+DQo+RGlkIGEgdG9vbCBmaW5k
IHRoaXMgY2FzZSBvciBkaWQgeW91IGV4cGVyaWVuY2UgaXQgZHVyaW5nIHRlc3RpbmcvcmV2aWV3
PyBJZiBhDQo+dG9vbCwgcGxlYXNlIGRvY3VtZW50IGl0Lg0KWWVzLiBUaGlzIGlzc3VlIHdhcyBy
ZXBvcnRlZCBieSBNeXRob3MuICBJIHdpbGwgZG9jdW1lbnQgaW4gY29tbWl0IG1lc3NhZ2UuDQoN
Cj4NCj4+IEZpeGVzOiBjMmI2MzZiM2Y3ODggKCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogQWRk
IHN1cHBvcnQgZm9yIFBDSWUNCj4+IHRyYW5zcG9ydCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJh
biBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9i
dGludGVsX3BjaWUuYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+
IGluZGV4IDMwOTIzZWFhYmVkNy4uMWVhYmIwYzgzMjZmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jDQo+PiBAQCAtMTk1NCw3ICsxOTU0LDggQEAgc3RhdGljIGludCBidGludGVs
X3BjaWVfc3VibWl0X3J4X3dvcmsoc3RydWN0DQo+YnRpbnRlbF9wY2llX2RhdGEgKmRhdGEsIHU4
IHN0YXR1cw0KPj4gICAJcmZoX2hkciA9IGJ1ZjsNCj4+DQo+PiAgIAlsZW4gPSByZmhfaGRyLT5w
YWNrZXRfbGVuOw0KPj4gLQlpZiAobGVuIDw9IDApIHsNCj4+ICsJaWYgKGxlbiA9PSAwIHx8IGxl
biA+IEJUSU5URUxfUENJRV9CVUZGRVJfU0laRSAtIHNpemVvZigqcmZoX2hkcikpIHsNCj4+ICsJ
CWJ0X2Rldl9lcnIoZGF0YS0+aGRldiwgIkludmFsaWQgcGFja2V0X2xlbiAlZCIsIGxlbik7DQo+
DQo+V2hhdCBhYm91dCBuZWdhdGl2ZSB2YWx1ZXMgZm9yIGBsZW5gIGFzIHdhcyBjaGVja2VkIGJl
Zm9yZT8NCnJmaF9oZHItPnBhY2tldF9sZW7CoCBpcyBhIDE2LWJpdCB1bnNpZ25lZCBiaXRmaWVs
ZCAowqB1NjQgcGFja2V0X2xlbjoxNsKgKSwgd2hpY2ggdGFrZXMgdmFsdWVzIGluIHRoZSByYW5n
ZSDCoDDCoCB0byDCoDY1NTM1LiBXaGVuIGFzc2lnbmVkIHRvIMKgaW50IGxlbsKgLCBpdCBpcyB6
ZXJvLWV4dGVuZGVkIGFuZCBjYW5ub3QgcHJvZHVjZSBhIG5lZ2F0aXZlIHZhbHVlICjCoGxlbiA+
PSAwwqAgaXMgYWx3YXlzIHRydWUpLg0KDQo+DQo+VG8gaGF2ZSBhIG1vcmUgdXNlZnVsIGxvZywg
SeKAmWQgYWxzbyBsb2cgdGhlIHZhbHVlIG9mDQo+YEJUSU5URUxfUENJRV9CVUZGRVJfU0laRWAg
YW5kIGBzaXplb2YoKnJmaF9oZHIpYC4NCkFjay4NCj4NCj4+ICAgCQlyZXQgPSAtRUlOVkFMOw0K
Pj4gICAJCWdvdG8gcmVzdWJtaXQ7DQo+PiAgIAl9DQo+DQo+DQo+S2luZCByZWdhcmRzLA0KPg0K
PlBhdWwNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
