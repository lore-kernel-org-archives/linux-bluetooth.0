Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36839B48D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943176; cv=fail; b=n9pBEGCODpr88NY9TEYF+SPAOyaiT2/TJmpUQpuOzk/i/6soqUFcKZMKkHxqrNXGbtuAaQE9D4C3TTsINyEWy2lWoSiDcv/2uy0QP2HmVEQVVVBLpw/UIE6vEC61JOmpRH8EH6h8jL817qIK0lDu373ll9UWBboh1TDRS/VfGvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943176; c=relaxed/simple;
	bh=gUERoTGD+/Jp/YQ3m6eNvUfW1E3mZQ0GNRTKjeDrzBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4ZCW3+86foD8DywBfzs0ipdjUVCRgGdfiAImr3yE0Y8ImhPwUMCfi6+cyrsz4l4SubB4MxCjBjgjrNfMD7dnv1km6d7ocs2dFz18KBtYei32LcOYjxKR73obI4v79F63kjCLAioirqnYTWQp2VzjsCuIXyTrq+gfMQ7Mc+D1Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvLb94k3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvLb94k3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771943175; x=1803479175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gUERoTGD+/Jp/YQ3m6eNvUfW1E3mZQ0GNRTKjeDrzBA=;
  b=BvLb94k3aM+Sb/xEJ7/sKdk9ZFcF6Jf1mdDoUsoJpIyj/bJl1Kqulq/J
   e7XwCWqIMRa2cnD5ERA2bq9veJMnXAsAAss/KWdcTnOGWYL7zZBSLygTE
   I6niE44QDGevClUmLEu9hOcj02mHtIDMKUOuAEG6Ce+DMz6Hqap/tZxQ8
   nH1GyR5AKnHTvfD8V68j4s/75vR+vLQh8/CRQoMYW4ZSBD3U1LZKB+hSb
   lqvAjVNdgz5zJZW3+3MTT/J2PtGfZBYuCPFsD0pmCzAUuGudm8XwbJsMm
   imRl122iHtNw1PSK4Mp8qkRUQM/t3kVbI+v6i4i/1AMsPeMb8rQwG7FsT
   w==;
X-CSE-ConnectionGUID: 6Y9ZOe30SK2FAhnV0IpSlg==
X-CSE-MsgGUID: a2P1Ep1cSdebk4Ula32zIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73021290"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73021290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:26:15 -0800
X-CSE-ConnectionGUID: dyMjLplKSkeLJK9RnL4vIA==
X-CSE-MsgGUID: 9qm+T99sT9OLw+6EP/zHzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220427609"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:26:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 06:26:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 06:26:14 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 06:26:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8aNVA0lJi9k61hHD0LOa94cAdyrmatKBhNJBNHQzz8aZKqRZeffZ/YdhV7dZD1T75wFAdCef8uc53R5+WNpW+tK8nZvvDgwjO5YQakJKvHcl7IPTLyi18Rsd+8SK5YUL2+qz+ig8PgPenwU+x5PsAjQPgo10CEaS5hTLQO0Abq+ybeZxl7M6WY/DBQgSS04QZPqJwoUb0t8Din2XxSeSVzu6qkge7ysvZ+8xhI+OaW7FULrujl7EFGr2zGanxNrM/rxqAwedYr1NxYyAOm1b4iaflDOfEe3ZTSU4XekG28mtETDFaRI/tf5EQD1gv9qMyZ9Nhgt3HsyywalrVVM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUERoTGD+/Jp/YQ3m6eNvUfW1E3mZQ0GNRTKjeDrzBA=;
 b=ei+ap0NI6sPmGDHNJk/d4EnWyECbo2Y1kWnPrdxi134w3HC2skVO/O+jU5AevgeYjdPvN5qqjMQQNqRvzpLldY2QHWDr+iaI43DovhNCot5tralfeai+fE4aw/iLgHZm4ZUdHT8DSd5ki3Lv7JMYU10VG9UoaI0ndN39Y4Cbrz6UpFTd5az/S6SiRiCjNeY1OYGDst4ZifU9FwcJGe5grAR4y6RyceLYxyDLV86HKT3W6NoWuwu9+TU0djEClxJtL1N4ZjHXmTDC6erEDvz6556b4Wi7Zk6EnSurk/6GZvT7y6hmyV66USlFsFg/pDhjeibGA8R3n37+80L3/n/g8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 14:26:10 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:26:10 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1 7/7] btintel_pcie: Add support for exception dump for
 ScP2F
Thread-Topic: [PATCH v1 7/7] btintel_pcie: Add support for exception dump for
 ScP2F
Thread-Index: AQHcpOY8tGDB3I3Lz0qjA3krDfNAAbWQhiKAgAFiCUA=
Date: Tue, 24 Feb 2026 14:26:10 +0000
Message-ID: <PH0PR11MB7585507C8E1734C637B331D0F574A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260223172104.167471-1-kiran.k@intel.com>
 <20260223172104.167471-7-kiran.k@intel.com>
 <CABBYNZLa+=ynikAJ3ivM5c-Gu6zbg0MiiSuFReGRL5hTSu-ExA@mail.gmail.com>
In-Reply-To: <CABBYNZLa+=ynikAJ3ivM5c-Gu6zbg0MiiSuFReGRL5hTSu-ExA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS7PR11MB7781:EE_
x-ms-office365-filtering-correlation-id: b04bd84e-038c-4ab3-d3a0-08de73b0a806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UGpaK2x2bEVzL0VBVDJGMWNZaWtkTGhlSWtnK012Y0NHMFlIRG9VVXpWdE9C?=
 =?utf-8?B?YjBPc2w0N29QVFhtVldjMWZoekw5UG9xSEgwdDNsV0wwSlZxZmJ4d05YNXcw?=
 =?utf-8?B?QXpMeVhBdGZkNy9ENUcrMXg0TkFIUEJRWmZzTTR6YnRGWmtYeFM1UUN3NUM5?=
 =?utf-8?B?TUJmaUVPUTE1bnRlUG9uRjgxVEZMeFE2VFc4NXA0L2orSVkxZUFLWVlLKytv?=
 =?utf-8?B?bmpJSXZySThrVGxOQkhOL0JFOUFJSUM2SEVyWXovOFdoTDhaZlRHTFdWV283?=
 =?utf-8?B?bk9DODhQcTgyNGpBWmRnaXFYcWRCN3FtTkxuamd5TGJxK2VKVWJpWHJPTnlH?=
 =?utf-8?B?KzhLNEcwdzhBOHNyQzlJbThta1Npckxkcjg5dUR2UGM2YXJ2Yk02YlQrelJF?=
 =?utf-8?B?NTRIeTR5THQzM2laenZBRnl1N0NVV2NNRW1NdDg2a2wwL1NIYlY1OVhReUI3?=
 =?utf-8?B?OVJHaVNxZnh5aHRNTzJrcS9UdUtOdUI1VmVuTFdaUjRMajBBckRkcUJLeHRq?=
 =?utf-8?B?b3Irc3VkdUtGdGU2RkZXc1FQRzlwK3U2czRWK0dmd3R6Sm9pQi9oZU9TQ05U?=
 =?utf-8?B?WmZDenRRZ1lMeWN0ait6d2trcW00Ymw1TXRUWWVUS2JVM1I0TS9KRm9JVFM1?=
 =?utf-8?B?UUlsb1R5YktoNjZIelVzZzBPNGJVdUxxVmtKdW9LOTJaSFRrYkx6Q3VDSWxR?=
 =?utf-8?B?cVlYM1Fpc2hiY0E3WFc4dytZbm5UY0VDa2NPV2NEaksyVVl4M0FQMFJvNTlX?=
 =?utf-8?B?L1lwYUF1VlBNZ1JjMXlTTlc5dWNFSXNielYvcTR2d21CYkRLeEExRlhOYktC?=
 =?utf-8?B?aXBvdVRFbndQak8xckVWQ3BJejJBSkk0SjZmREFDVzhHa2taUVVMazlMWEtK?=
 =?utf-8?B?cnA5RStyV3JmaDNJZ09UNTZvdyswT25Kb21VbFRaZ3l2cDNwUW1uRDJ3TWFH?=
 =?utf-8?B?RS9RQ2xSVFg5T2pxS0UrbUpLOFlTMVpDZ1UyVlhZKzFjSXVEUlpXQU42ZlYx?=
 =?utf-8?B?VWxYdmRZamNsYURTbWtvV2V4UEl3WmxPTlFsczJDbExFS0VSWlhhS1pVZmJZ?=
 =?utf-8?B?U05yTHM1cnl5eTNWdWZpajA4YXFmYm43T3l5TitSTkhaTTFvekNPL2xIVnFW?=
 =?utf-8?B?Skh5V1NxRUxNZ3JSS21lMXhMU2Fxb1R0M0FkbWhWSDgyR0JSQUd1UWNYcUdE?=
 =?utf-8?B?dFVjQjd4MEVSSlNOMWNDR2V4NFZOTmY2NzFOTWZFV3hoTzBFV0lhOTU5TWlH?=
 =?utf-8?B?dmJFOWpKVnNUclpXcWorWTNOV3l6RXZZZU02UFcrWHRnWW1LZ0gyeWJiQ2tW?=
 =?utf-8?B?SWFCdUZFVHpWa1FUK2RFMVBCaTg2SDF1R2c0VzVHMlQ3THh2emhVdkhUUitZ?=
 =?utf-8?B?amV0T0NTUmpxbnF5b3U2WGJWaXhCWUlrN3A1UDJQa2ZIWEpZTlJzREVWakVj?=
 =?utf-8?B?eDBEOEE4dldmZEs4emI0RStFMjk2d3JsL0ZCaU9DU0hVbWNBNDh5N2Q2bURZ?=
 =?utf-8?B?Q2lqb01SSFlhTjJCQTRlaTN0S1RYTFpMQVFzTytIZXdWbmZib25MRFdGNVFT?=
 =?utf-8?B?U1c1MmRCdkJBRFRYS1djMDhYUGhaclpmQys0VGgzdVdtNWg2eUhkT2JjOStR?=
 =?utf-8?B?d0xrV1h1eVMrbG03c3QzdDRnbzl0cWc2dWJRM1o5dEdYa2RZKzVrZGQyRmw1?=
 =?utf-8?B?SWdVRmVrS0Q2UnVXU1B0ZDJ5VzNxQlR6dVFZVWY5KzY0RFlKU3NUUWs2TFlU?=
 =?utf-8?B?bjJuYTVScldhbTRMNmRHZVJLVWp1L3MwOXJvTmF2clhlZkcwSDcxK0g3dGJI?=
 =?utf-8?B?TVFaejk5Z0J5MXIvYWMzTHpxVk1TM1dBenQyRUtpTk9DaGhpMkd5eDRkKzdk?=
 =?utf-8?B?NU42VG1DTk13RmswVWNHdlNJNDZtQlVWdUs3RTBBSjVvZ0FkYkZ6ZGc2dmZo?=
 =?utf-8?B?SGpESHFhNDZ5RlAwaXh6TnA2VVFlaFFMSVRBWEZnTGEyQlFBTDhIdWZ5UmhB?=
 =?utf-8?B?cWxqTG9JMHJkMUI0WWhuRytVekdxdE80SlBac3BwaEF2WXpod3NNbklvL2Fi?=
 =?utf-8?B?dzZicEE2ZlBJUmN5L25PeXl2M3BIQ1pBRzhGZDFBamdyYXRvc2hKM3QxQ2lv?=
 =?utf-8?B?OEh6RzViSzArU2I4eGU0bmVOY2t2aTZHWVVEMVJGeFAwUzUrc0w3WDM5SXpV?=
 =?utf-8?Q?wG+AFvyea8pGdFrBtC3Jyko=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhVbzVOZzEwQUM5MmZBMVoyUmluM1MzVkZQd0h6SzczQ3FCdmNIWjQ2OUJY?=
 =?utf-8?B?VytpYnFPSk8yZ3M0VkE3ckFyVEJrMld2ei8xNng2blhSYm5pZHY2anV6aTNJ?=
 =?utf-8?B?MGZhaVI4Q0VndlNzV0ZWOW1FU0NMd3dLdkdZTWRJOWNpZjVSUkI4TU1Ma2lm?=
 =?utf-8?B?VzFDQzdhWXVWYzBiWU54WVh4YTc1aHBlbHhLekFWWFFlM05MaWNmLzQvMDAx?=
 =?utf-8?B?RzBwVWgwM1R1TWR0OFRNR3FhVTdjcmVBWDNoRWg3N3VTeTZJS1hjVmVWTzVJ?=
 =?utf-8?B?a3g2ZXJZRWxxVzBUV0gvV2gwczR3cytZMk5ZdmhuTXhvamtaTHhEOUVlNTJQ?=
 =?utf-8?B?TWo4TkZqdGc3RlprV2V2dEJZQ1lkeWFGUmtYQVFYd3RHMVNwSmhmaEg3dzlH?=
 =?utf-8?B?eUV1bU5LcUF2QkVwMUpnOGtlemh1Z0RHbjNNTFJYZGJpQkRMMlJVOEp3OUxL?=
 =?utf-8?B?S3Z0VWU5cXRiTzY2WkRULzB5NUJwWXh6NzFMNExnMStZZS9Ua3BkTU05MHow?=
 =?utf-8?B?eWJWNXJaaXFFY2N4TFYwbjkrbnhGZzRLSnB0eXZUSVpNRGEzL054clFNMkZl?=
 =?utf-8?B?WjhzVGx4aW9oemJhY3pKSGx4UnBrTlZSVzdyU0sxNTZlbUplSkhqcEpQMUd1?=
 =?utf-8?B?ekJDTFVmRDRBY2xJYVoyMFRLWWh6WHlVR0lidHI5Vk5mY2tZZUs3clJoSTRO?=
 =?utf-8?B?Kzl6UkI3YW9vcEZHY2s3ZWFBMUtrcXhRUE9PNGVCTFVVYjVWanhUVGlaeDMz?=
 =?utf-8?B?UktmS0U1Q1VEQXY5VzZHcHljdkZjVUJwUTc1eVZ2L29zTDEyTDdpOXhEd2k3?=
 =?utf-8?B?VGxvNUZSV3dieFBDZWh3RTdaQzI5Y2dTb1ZuQVhtUUtUb2JvY1lsNmhPMHFp?=
 =?utf-8?B?ZFpkc2hUTUZSRk8za1Q2SFQrTXlZSnRQYnFwMDNQU3ZNMXNOZml4SlZ3Z2Z1?=
 =?utf-8?B?bWNUU0xPS0lpejlNODdSQmFTM2NoME8yTWI3L2o3UXdsLzdNVllmN292MStZ?=
 =?utf-8?B?WTc1ZE50c2pVUmxEbGozU2ZQeUNZK0VFckRmeEJzSjM0bWNlWUo1YkZsWlZE?=
 =?utf-8?B?enlQNTQwU05sS0p3Y0l4dThWcmJuRVhaOURtclRhM2lGT0NNczMyZHBmTy9F?=
 =?utf-8?B?ZE03NlVCN25KVVY0elBSWWVnY3I3NjZJWTlWdkJrYzU4aGNMYXZUQnpON0lK?=
 =?utf-8?B?NnFoU2xMOEdkcWR3UHE2dWpXYUlTcDRzNnJYUmdod2czYldqNE4ySzRyYnRG?=
 =?utf-8?B?VlpRNnV5N3N6VGYzMGFQbFZ6M0JHbHE3UzRwZitsOGpRc1IrUnJEbk14MDVz?=
 =?utf-8?B?UGtPeUVCVFBDQ0F3L2JpMmsrSXFvMjdjalRtYnhwcko5YTdvYU1zOGdueHFO?=
 =?utf-8?B?MHlHcUphRjVtbmdPVFlRQW1ZVlhWYmpJUWE4bnJHZHh5K3kyQlF6ZUxhTkli?=
 =?utf-8?B?cGpHN2RnRVNSbDBpTW4yMEVUc0hqZk5FeWsvemJuZDhmbVFjWUw0WXgzRlNy?=
 =?utf-8?B?dEFBazZRbUNkYnNUVGdiK0RHZzUwLzlIbWd6enhFUFFld0cyTElQbk16N2pU?=
 =?utf-8?B?eGFuVTVISEZoVTFsOTN6WjNyM2czeGdsSWtrS3BHSEpIUkdWQVAxQVQ1eHpy?=
 =?utf-8?B?bWFVU0VmYmtNazJXanJKOWhKSXVhdzdxSGlxUXM0R0lhWmcwSVFlS00wKys1?=
 =?utf-8?B?N1g0dGJ6WE16QWVMWnF2Tyt4RWpmNFpRZnVNZUdiWmFFMTd5MWlhOUwzTzJO?=
 =?utf-8?B?bzRPVEF0S1VGSlpzb0RzT3BhNFBsTUVGcGhXTEN2YUVWV0ZiMjg5OFRyaHBG?=
 =?utf-8?B?cWR3UmpNeHh5TzhyVDQ3MWN1WnZValczVkIvbHdRVHJoZUFJbHd2cjhkempp?=
 =?utf-8?B?aExLaFo1OEw2RDhJeGJTcVUwNGZwMEx4alV6cmFBc3VleGpZOE5Bb0lsOGlR?=
 =?utf-8?B?QWVobEpyYmtRSHZmb1psRms2T0V0ZFUwQmxDVzVFYVUrUkg5RzUzOWtSOTR3?=
 =?utf-8?B?UDd2K29VQnBVZ2UwT3NqeVRnWW9IUTY5ZDJHUUhXVUtlY3U0TlpYRDBRS0Jv?=
 =?utf-8?B?bVRlelJDdUpkdWo0T3RaTlh6ZGZ2dFMvdm1kNkVldzk3ZnR2WXBFMGZGa29S?=
 =?utf-8?B?WC9jSEtOejhuU0svemFuQjhtd1ZwT085SDE1MWRKSUVyNXAwS1pyREQwMEhP?=
 =?utf-8?B?UnhqRURWSjR0ZUc2MlJEWmFYcHMrVVpiY3lnRlA5RzhZbjB6SmF4Q0E4bVli?=
 =?utf-8?B?MC9UTGsxcFBMano2UlNFaTBValJSRmRTS3FwTW1jVm54bEdJVnhmNFIxRXgy?=
 =?utf-8?Q?OveV9nUHH7AfC5fTDS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b04bd84e-038c-4ab3-d3a0-08de73b0a806
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 14:26:10.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ld5Ff32TXUeCjzdcSk3VdqiLSj3MTh8m2R1+hMFUHpBg8+OgK7yzXHQH8iCk1/vS6o0UbKsxfcfhv1S6NOi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxIDcvN10gYnRpbnRlbF9wY2llOiBBZGQgc3VwcG9ydCBmb3IgZXhjZXB0aW9uIGR1bXAg
Zm9yDQo+U2NQMkYNCj4NCj5IaSBLaXJhbiwNCj4NCj5PbiBNb24sIEZlYiAyMywgMjAyNiBhdCAx
MjowMuKAr1BNIEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBBZGQg
ZGV2aWNlIGNvcmVkdW1wIHN1cHBvcnQgZm9yIFNjb3JwaW91cyBQZWFrMkYgcHJvZHVjdC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCAgICAgIHwgMSArDQo+PiAgZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAxICsNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
LmggYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmgNCj4+IGluZGV4IGJlZjdlYTg0YjFlNC4u
YjVlN2YwYWFmYjRjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5o
DQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmgNCj4+IEBAIC02MCw2ICs2MCw3
IEBAIHN0cnVjdCBpbnRlbF90bHYgew0KPj4gICNkZWZpbmUgQlRJTlRFTF9DTlZJX0JMQVpBUlUg
ICAgICAgICAgIDB4OTMwDQo+PiAgI2RlZmluZSBCVElOVEVMX0NOVklfU0NQICAgICAgICAgICAg
ICAgMHhBMDANCj4+ICAjZGVmaW5lIEJUSU5URUxfQ05WSV9TQ1AyICAgICAgICAgICAgICAweEEx
MA0KPj4gKyNkZWZpbmUgQlRJTlRFTF9DTlZJX1NDUDJGICAgICAgICAgICAgIDB4QTIwDQo+DQo+
TGV0J3MgZG9jdW1lbnQgdGhlc2UgZGVmaW5pdGlvbnMgd2l0aCBNYXJrZXRpbmcgUHJvZHVjdCBO
YW1lL1BsYXRmb3JtIE5hbWUNCj5lLmcuIC8qIEJFMlhYL1BhbnRoZXIgTGFrZSAqLyB0byBtYWtl
IGNvcnJlbGF0aW9uIGVhc2llci4NCg0KQWNrLg0KDQo+DQo+Pg0KPj4gIC8qIENOVlIgKi8NCj4+
ICAjZGVmaW5lIEJUSU5URUxfQ05WUl9GTVAyICAgICAgICAgICAgICAweDkxMA0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCBkMGNhYmY0ZGY3YzAuLmQ5MDM0NjBiZWE3
NiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiAr
KysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gQEAgLTEyMzQsNiArMTIz
NCw3IEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9yZWFkX2h3ZXhwKHN0cnVjdA0KPmJ0aW50
ZWxfcGNpZV9kYXRhICpkYXRhKQ0KPj4gICAgICAgICAgICAgICAgIGFkZHIgPSBCVElOVEVMX1BD
SUVfU0NQX0hXRVhQX0RNUF9BRERSOw0KPj4gICAgICAgICBicmVhazsNCj4+ICAgICAgICAgY2Fz
ZSBCVElOVEVMX0NOVklfU0NQMjoNCj4+ICsgICAgICAgY2FzZSBCVElOVEVMX0NOVklfU0NQMkY6
DQo+PiAgICAgICAgICAgICAgICAgbGVuID0gQlRJTlRFTF9QQ0lFX1NDUDJfSFdFWFBfU0laRTsN
Cj4+ICAgICAgICAgICAgICAgICBhZGRyID0gQlRJTlRFTF9QQ0lFX1NDUDJfSFdFWFBfRE1QX0FE
RFI7DQo+PiAgICAgICAgIGJyZWFrOw0KPj4gLS0NCj4+IDIuNDMuMA0KPj4NCj4+DQo+DQo+DQo+
LS0NCj5MdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQoNClJlZ2FyZHMsDQpLaXJhbg0KDQo=
