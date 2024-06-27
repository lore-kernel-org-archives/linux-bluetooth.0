Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2C1171C
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450198; cv=fail; b=oHLpyl6zSKnbno4oRX8La6VjMAtl0EZscQ08VAsZBvCOhOzMyLKv/UDS20NV1PeUGKQ7lLAOJuLXzrP4QOKHKX6Dmp5YQpKCnmSPhwvOeVOaPDIru1MdcmtSSFwvd2zfRinEB/1gjRHiXYZlFzb/muqTeN2iPetfAITV+ogxdIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450198; c=relaxed/simple;
	bh=pxW97geFxFexTapGhYOKTktTp0GxIK6cctBy/L4GWL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxuXW3Kyv2DKzJNV25X+JWNd6bfI+mZGC/e3iYl/iFy6wCYsff6NJb/gFm8POT6OLXOOmLkqvLkUEQ44fcf+iMAnWqlgw/zhZLaMPFXNMqV5xvKUlpAt8alf5yA3CgLMaXbsWueQ1WtUx0/OeUYZ5BO9EyU7+nxhE98XZwhLplU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avEFiwcG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avEFiwcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719450197; x=1750986197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pxW97geFxFexTapGhYOKTktTp0GxIK6cctBy/L4GWL0=;
  b=avEFiwcG6Z17pX0dEiJidK8Quaxfd9dZY/1SfVTArA21BoX3sWaKY0x7
   VhI1ITS0wVm+5SSDtk3iAAMtOeKEUKI7xPWorcNhiPum5iXvWnVhjyK7E
   ewwH4PN/HvA+naH3zBhKQiorwc6oJtHs9DGOnIJcz7EwrLyPisZ5Z4qXk
   V28q8EPlaF3dt8aWb26/IA/sAj6zkd2xIm9DVLWWWrZjTVYF1YyWZagTV
   JSE9gueJp4jqOfyTIGd/+soGZszfPNdsaI3HfGzyQTsOIImGC63D+y9Sz
   tZMbT0ZwMj+/cWgmiglf49BFSvUO4oZXAAIMJhDUbeFS6EsWgpAlrGWDr
   A==;
X-CSE-ConnectionGUID: TKgRhAqWS0+oYQ34KWLPsw==
X-CSE-MsgGUID: IGa+wnjBTfiYmcQhEK1JVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16702469"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16702469"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 18:03:16 -0700
X-CSE-ConnectionGUID: VcOKFJNsSyakC4tlbZeVHQ==
X-CSE-MsgGUID: W0dUBG81SVa8e7b+7GxX4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44619090"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 18:03:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:03:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 18:03:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 18:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr9Aw1S56T7NMTffcZuFYsUaJTqXVNuBii8TM6KWQb3tL2EvzGkea9+fJBRcKnD/2IUu47kk/FRzjkNZsl7Gv8d/hq4trD/2cy38XwfO0XavfzUz2z4/wNj0upS+XpQO+FbVqzKhaEaxmxB4zC13XARjhNmLq4eRHNBcARIDEymYggVnltVdKBuOIRjBDajtF+ZY45mSK3ZWmP8QlJqsmiYWx31hBa0GKaTpBmviGpcVmi2JcGhyiC2ZsYTea5GZ2uHuFWnFYKkiJ7dHQKIQ8vmRlNXV6L4ANx5P9Q1kq6J/bGOW5r8IaA/ePlBonGyoMqPPABluRjfeMwMyO6uG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxW97geFxFexTapGhYOKTktTp0GxIK6cctBy/L4GWL0=;
 b=HovEi34GaKnj5WbuSz5pDSblua+7WqJ8SMEmLq42dnRQnhbJg8y8/RfnZLpALH7iJbzWn6Fo6hZrpb8WEEBEKRO7VsHJ9pBHR1ZVvgQFLbMBDuKMOgCDuDx6xDqCNU3TgMx/QIAW5tUbDeG4GaOl0+qXoRLW7Xr4D4nPq2FqbAedG9Esod9/qc0I0/5Zbms/Opic8CfpEBUbFEXyTYgzuvX1aun2qkJxTL78hAWbbkYFxBttT3SrN/9dKtlNPxS0zYMmV2EplZ96IRsxX6E8NK7BFDdvWjvLUX8IgdJ+GWAmt22UR7P07zSARYWBfuitu0Hm+BW14khQNjVvnhgk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ0PR11MB4863.namprd11.prod.outlook.com (2603:10b6:a03:2ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 01:03:08 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 01:03:08 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Topic: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Index: AQHax6kjeYSrWj+1tUOOSiEx27rXDLHZ+LmAgADSwUA=
Date: Thu, 27 Jun 2024 01:03:07 +0000
Message-ID: <PH0PR11MB7585AD51482CA4FC1F1035A9F5D72@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240626092801.2343844-1-kiran.k@intel.com>
 <390bb99a-55ce-4a97-b268-93ce62bedbac@molgen.mpg.de>
In-Reply-To: <390bb99a-55ce-4a97-b268-93ce62bedbac@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ0PR11MB4863:EE_
x-ms-office365-filtering-correlation-id: d535f0f7-f52d-4ad3-6c5d-08dc9644e85f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Uzd4ekhKNlpNSUgwYXJOZ2t1WldrdFVUZUNxYWxJblJWbFdoNDN1Z2FoZVB6?=
 =?utf-8?B?aVlRZDN2bXp1cjFVSHBiQUdBOG56NmwxY05MbTVzLzZrMlBDQzhQMS8rTVJM?=
 =?utf-8?B?eU1yZlBsd0NGeUl0OUo0MHBGVUZVUzVSRkkzOXNqd0drK3ZmRGgvU2pqc1p4?=
 =?utf-8?B?Q3BrVVgyanJaL0QrOVdvUFhiV3VvOHRmKzQvVmxkdlM4NTVIdmNTY3orR1Zl?=
 =?utf-8?B?aXAxY2c5VGZDTzhINW9OSWVENWZJc3ZZaEt5UWczNHhTcGwzZ3NGWGRYTWtF?=
 =?utf-8?B?WmljV2k2bzJneEw3TCs0YjNWaXNRa2QxS0xpV0YxeEx6dWNieEUrdXdrOHEx?=
 =?utf-8?B?NmdOcERkQXNNR3dBbW1WUm0xYjlKV29XOHBuUmg4TU5tQWdaSkcxNkZVUjhO?=
 =?utf-8?B?VFRVQU42SUI3YkxGYkxwZHNqUkM4dmtoY2MzWlBHNmtjZ3NVckxMQzVlVWpx?=
 =?utf-8?B?SnlOejV3Y20wck5lWVJhSjFGeG1Tc1RBU29EcDgzdDhZL1dCclhra05uVGZM?=
 =?utf-8?B?S1Vlbkh5M2E2bmtmcy9aK0xMb3N4RzNvQ0tuaUIyanZtZWpVaWFkWmNJdk5U?=
 =?utf-8?B?aENxL21RQyt4ZnlrOTBmbmI0MEo1WEg0eEFIb2ZGRzNOTUtmMEo4MkZNeFdN?=
 =?utf-8?B?QnIzNm50cHVObzk1MEo1OVB4Y3RabjdXS0lqeEc0dHltUmpZNHNwRXlES1lN?=
 =?utf-8?B?Yk8xMjZqUlB6MmN6OU9EVVJqeEptS3BRM09rVkQ2bTFPaGk1S3ZZNWRHc1Jn?=
 =?utf-8?B?S0lFVWhmRVJYM2ZmYVFRQWJxZHFlbXo5MmtVUm5ENTVMQmlMdTc1d0MrZGdH?=
 =?utf-8?B?TU1LQ0d1RFoydExpUUI2clNtTGdIK210OFdyVnZmM2pvcUg5ZUhscjkvWGJ6?=
 =?utf-8?B?S2NFODBvTnBUY1p3bi9FMDBxaFdYbmI5M0JBbFFQODBpZnR2bUlnenpSUHh1?=
 =?utf-8?B?Y0NHMC8vemlpb0l4TitzUmdESGpibWNRdWN4SE14V0pUbWZrQno1aU1EYThX?=
 =?utf-8?B?QzZvS1dHMkk1TnFvVk01R3l5d2tGdTJEdzYxc0xUTDVPbFNibTh6NnZqRG1w?=
 =?utf-8?B?a1poRXByWlBHWFJJTmF1L1p6eSs3eHUyK2JaZW1WUXA1U2N6b1J3YVJqQ28r?=
 =?utf-8?B?Snd4RUFzZS85Qm95ZDhWekprdFQwVmNUbkVEU3pNdEt2YW9MdmZlS0R2K3hQ?=
 =?utf-8?B?cjgzbHZuZjVzTG1Ha3R3VnZqSnRmNVcyV1N3TFg0V0tGRzNFZTdlbUhVdzdH?=
 =?utf-8?B?b3g4YXNRdXhpNC9UVWNFNitHdVJYWHhOVzFMcTZIdklldGpoNEVxSm05STVV?=
 =?utf-8?B?TDJCcXpnUis2ckhjdWZZa1VCNUpyWFhHN3B0NkJ2VVFiT3RaZUdoenVIaW1z?=
 =?utf-8?B?Q2JxakV2MGZQTjhwT295V3JmT0htOFRBYWxNcVpOTmlTMFVTR0lyeUtmSk1H?=
 =?utf-8?B?WUl5UmluTmRMR3lPdUlqYU5QbkxZbHlVdm5tOVF4QmJEVk91Z1ZxdklPV0xv?=
 =?utf-8?B?TFFpMTNDS0t5ZnkrNVFUZkpaVlVETGN4TTRTcW5ncnF3SFIvUmFqZFR4VTFR?=
 =?utf-8?B?dGpReTRKc3BsZFArUWhHUkRnLzk2Q29vSWJhRmQ5OGxWMGd3MGZLeGNXMWN1?=
 =?utf-8?B?bUQrNGhkQUVOSGNHMUx4YkNpRmY1SXFGMHFiSVRxV2IydlB6T1d5TFA1UlRX?=
 =?utf-8?B?Ym1VbDdrbTEySzRFdzRyTnVjbGpSY2JlVzJnTlpyK3V3c2d2UnRYWDlzdU15?=
 =?utf-8?B?aWNnYlZzMm1hT05POWpCb1VNdE05VXNIY1lqendwU1RvOWZZSWtQMytnYmpl?=
 =?utf-8?B?ZjgvUWEyamd5MEdVakZYcGJkb1hlU3gzVkcyWjMvUzV2cjNVOE5LZDhSdmFa?=
 =?utf-8?B?SDY4Y1FReWRHYUM2YkhldHBKOVpBVk9tTExqcUhEM3hRNkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEVBSS9XQWNvY2R0eU1BanluN2Noa0dlOHFLa3d4OHp1SGluL3YvTWZRU2Fm?=
 =?utf-8?B?K3hqYU03enNyRGorVHBKMkREc3NGcGREZVAreU5zMnNDY3RhcVBaaXkzbVlp?=
 =?utf-8?B?bWJaSWdTSXI5OEJCcXFWd3MwWCt3NG1ucU0wMkNFYTc4cHgxZVFJQVJvM1Fw?=
 =?utf-8?B?VlhmVGlLemtwOXY2c2J4WkY5S1lvQmgwQ3A3SjUxT1FYdjBXSjZmUm9ZTVlx?=
 =?utf-8?B?UWFON1cvT1FMdHBvWDVKTnc0OGhmQ2VpeWxNSUFRcDdOWlpWVFE2TE1oZ3VV?=
 =?utf-8?B?Mlk2K1B1WmVLeXYxendaSkQveGl2ZjhheXRIYkFkTldkWHB3c1RJMW8yeEIz?=
 =?utf-8?B?TVlLNnFzQW1YbFZ1Q1QvUFZEa2dWczhpdGRGZnI5T3JVdmVmT29UMDBidEZk?=
 =?utf-8?B?OHBBdHNPdGx3V2l0aFZWOUp0bEhleTJhWFI0WVV6WHl6R0FNbkRMRlRpUzhI?=
 =?utf-8?B?SDk2blpKc25QUG43bUdNSXM2UlI2WS9QSEkrMVFjOGpYZWN3bk5ZMDRwTzZH?=
 =?utf-8?B?Q2hFdExFalZ5RjRqVTZYVWtUQ0d6NldpMUJWWG9hVFhZM3JRenZBOExIWXVa?=
 =?utf-8?B?WFVtbFhmL08xNlVCSFVqUmEzM3E3RlN5QThpZTNVMk93V2hqVHgxdFBmeUF1?=
 =?utf-8?B?ZGtBOHA3ekRxZW5lNS9uWktKT1FhcVN4YlRWZ1BKVjR4SFRaUTZQVW0vcTNR?=
 =?utf-8?B?SFZ1WVVBc3Z6Um9tbDBNb0pSbFd4T1p0NjBIQmhhb1V3OHhnZTZwd1hkM2ZX?=
 =?utf-8?B?SW5ZalRoellKNnVlYlZHZnc1L1ZPMU1rZ2QwVVc1TUJLSUZIRTBMVGtqRzRq?=
 =?utf-8?B?enRMWnFvcmtTL0drUG93WjB3OXErRURCazI4UUJUUkdaOHIxY3JBY05vd21w?=
 =?utf-8?B?Myt3RXozaFVQMG1Fd2d2YkhCSVNXRkNGZHQrUU14NDNWSFZuM01ESHFRbU1J?=
 =?utf-8?B?VVRxRVdVY21OYVl3M3U3YVIza0c3UkJPbGx2czdkWHo3UU1ZSUpHN1EvSldj?=
 =?utf-8?B?OEJWUlU2V1FhRVZTR21CcU84WFNSUFNOTWEvaXMzT3hUdmdKQ1NDVTVzMU41?=
 =?utf-8?B?YVZEZDhrNWNQTTFuZ3MwSWZXdzZzZG1QLzdRSSsrYStnQ0QxZFRkbzVCN3hU?=
 =?utf-8?B?eStuSXhzbEFXMUkyeWJjUHdTWThCaVlhQjdFNnFiM3hISDA1Y3I4VnhVcGVq?=
 =?utf-8?B?ckFZYzVCY25SZyt4b0xLRHV1TE8yWWhFQmpGTnN4M1JwelZGNGptdkw3RTVm?=
 =?utf-8?B?dThLUkNaRU5MNTZxUXFOeStSZVNIUmlvQUpRYi9hYkxoS0I1aGRPRzNFbkpM?=
 =?utf-8?B?RmRuWXdZVElLeFJmUVEvVUp5TW5GWjRSODFOQzA4N0FqVkRQMDNHQ2d3Rm1L?=
 =?utf-8?B?WEMrZlJ6cXRCMzdaWW45ZjhCTE4xZUJYNlJiNnlvWk56SkpKak9ueU1hTU5R?=
 =?utf-8?B?SUdQamIvNko5cDBCazV4YTRPT3dxTzUrY0IyWlQ4MDc1N0M3aGZJcFdmVzFu?=
 =?utf-8?B?WnRibVlvc29BNDVLNG9sTVBsa1duYUNlYzByTEg2SlNuWFhzZ1h3K2p2NFNr?=
 =?utf-8?B?cUU3ZjdnNXVrWDgwVTVhMmxPWU8vbVB3QS8yMGtYYjVzVG1TRlkrV1B0RCsw?=
 =?utf-8?B?dXpHNFZJN2l0MktidkducnFMZGdZS2VWQlBUUUk2SUZZTzlGOE9LV1lwZm0v?=
 =?utf-8?B?emlIQnVyUkt5N1VtS3hvZDNhYWpTSlo4TlQxOFNBODdQdjR0eVN0Y1lIaFhZ?=
 =?utf-8?B?bDI2OVZoa05hOGtMU2EwZ2U0L0l4TWJmVWkzL1hSZmVsRDVQUjkxV1F3dGhY?=
 =?utf-8?B?bUhTMUxtV0xzVkNjLzhJNTlJb1FBb0VuRU55anZqSnpLalNPNCtUYW1reVNr?=
 =?utf-8?B?YlppOEVvcU11Ulo1YWk2blRMbmg1UURIVXU3SThFVCticHlkSkE5dW0vM1J3?=
 =?utf-8?B?eWNJVHk0M1I1RU1PQjJ2T2lkcEZTREZHb2t6TS9YOEdXSGs5OWtmOU1TYUU2?=
 =?utf-8?B?NmxzZi9DQzdubGxVMkp4ckFjTFg0cTROUk1udTJNQXR2RW1waG9IUGZSSXk1?=
 =?utf-8?B?ekRaWlpseFZuTlpRTStUcWhjcWtuSzh1SThqcHdBRDJhWlR6cytjTlpZZGt6?=
 =?utf-8?Q?8W9g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d535f0f7-f52d-4ad3-6c5d-08dc9644e85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 01:03:07.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1Y2xJi6KwKgdD6K6SKgr5bPcSl7X0L30PeoJcc/gZXfYszbE2rKiG71JKj28Q1THooP6zVzeYBA9z6HxH46uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4863
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGF1bCBNZW56
ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj5TZW50OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIw
MjQgNTo1NiBQTQ0KPlRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+Q2M6IFNyaXZh
dHNhLCBSYXZpc2hhbmthciA8cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3Vy
IE5hcmF5YW4sDQo+Q2hldGhhbiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBE
ZXZlZ293ZGEsIENoYW5kcmFzaGVrYXINCj48Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwu
Y29tPjsgU2F0aWphLCBWaWpheSA8dmlqYXkuc2F0aWphQGludGVsLmNvbT47DQo+bGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIEJsdWV0b290
aDogYnRpbnRlbDogQWxsb3cgbG93ZXJpbmcgb2YgZHJpdmUgc3RyZW5ndGggb2YNCj5CUkkNCj4N
Cj5EZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPg0KPkFtIDI2
LjA2LjI0IHVtIDExOjI4IHNjaHJpZWIgS2lyYW4gSzoNCj4+IEJSSSAoQmx1ZXRvb3RoIFJhZGlv
IEludGVyZmFjZSkgdHJhZmZpYyBmcm9tIENOVnIgdG8gQ05WaSB3YXMgZm91bmQNCj4+IGNhdXNp
bmcgY3Jvc3MgdGFsayBzdGVwIGVycm9ycyB0byBXaUZpLiBBcyBhIHdvcmthcm91bmQsIGRyaXZl
ciBuZWVkcw0KPj4gdG8gcmVkdWNlIHRoZSBkcml2ZSBzdHJlbmd0aCBvZiBCUkkuIER1cmluZyAq
c2V0dXAqLCBkcml2ZXIgcmVhZHMgdGhlDQo+PiBkcml2ZSBzdHJlbmd0aCB2YWx1ZSBmcm9tIGVm
aSB2YXJpYWJsZSBhbmQgcGFzc2VzIGl0IHRvIHRoZSBjb250cm9sbGVyDQo+PiB2aWEgdmVuZG9y
IHNwZWNpZmljIGNvbW1hbmQgd2l0aCBvcGNvZGUgMHhmYzBhLg0KPg0KPkkgYW0gc3RpbGwgc3Vy
cHJpc2VkIHRoaXMgaXMgZG9uZSB2aWEgYW4gRUZJIHZhcmlhYmxlLiBDb3VsZCB5b3UgcGxlYXNl
IGFkZCBhDQo+cmVmZXJlbmNlIHRvIHNlY3Rpb24gaW4gdGhlIFVFRkkoPykgc3BlY2lmaWNhdGlv
bj8gSG9wZWZ1bGx5IHRoYXQgZXhwbGFpbnMgd2hvIGlzDQo+c3VwcG9zZWQgdG8gc2V0IHRoZSB2
YXJpYWJsZS4NCg0KIlVlZmlDbnZDb21tb25EU0JSIiBlZmkgIHZhcmlhYmxlIHdvdWxkIGJlIGNy
ZWF0ZWQgYnkgT0VNcy4NCiANCj4NCj5b4oCmXQ0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5Q
YXVsDQoNClRoYW5rcywNCktpcmFuDQoNCg==
