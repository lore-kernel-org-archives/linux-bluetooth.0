Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1628F4
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542099; cv=fail; b=aTStgZhtKB5uXy06pC+c2gwbHWCVW2p1wdOt3WPVEwpK5b3VtKhDJSxkam47NzhVWUuCnpk3owLWMKEICpD/uHPrgK7yDpO+a3E5NtOcqsq8I6X2wO2ejDxXjB9s4ZWa2oVm4LOsDyzJfHVWdUAqFFCSQTGXA5XihUMhZYjG6wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542099; c=relaxed/simple;
	bh=KtdvlLVvUUqftit353CgmSYRe4WtNbPIlVfwfBPWc1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzmX26O/kvRZ2Bh6AIm5rjKfcFXCp2Qs0dhxtPvZXo6IQ9r84SZZO+Uu5Zx1Rprr7VnS8IbvmkUjZoCC8IsWvpO0DnRESEiJ9LAIBBdwOcruL4bZxQW2mHcYdZkYdOTJjVS21cxPVh+2R4IjgimDjPNAJMvBvgT4Nr+enUvsceM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoPBGjl5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoPBGjl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752542098; x=1784078098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KtdvlLVvUUqftit353CgmSYRe4WtNbPIlVfwfBPWc1w=;
  b=SoPBGjl5Qb2jRaryVyM7Ctf4X22pg/XLkuS+FFLUjFmx+i+/ytIr+6Nf
   QLaojiaL70W47sR4r/KgPGUebbb+I6LE0bJ7+qae8lB6Hoo1Ru9/Bqvl4
   UI4r2Rri9LFSmh9r1S01KMb3I72aoWsoNL4pwLCJo0mDxzSibGcxeLynW
   CCNHjLG24bkE6zD4U/fWjUA2C68nxd4LmkwgFVqvH+gAIs0F7jNWelZC4
   W71szO8MEvBh/NawYp+SrOhrlsQMYnQ2LHttiWzZgfp+XXMUPwYQ/i+Ki
   LYgI23bq6TIv/OPKvjx4Ef0nm1H+KAkFc9G0VVRIE4iQzUNLALao3Qrjr
   A==;
X-CSE-ConnectionGUID: bP4CelhsRlOfub71J3pr9g==
X-CSE-MsgGUID: EAcmOmEFQ8mLFwLsmre3Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54836610"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54836610"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:14:38 -0700
X-CSE-ConnectionGUID: s9SDmCBHRZC5WhGcNF83zQ==
X-CSE-MsgGUID: WM0nuZW6RtSUwAd515TCWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="161104113"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:14:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 18:14:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 18:14:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 18:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rlsf3KnTME/c6EseBC5noPtkeU6FuYD0Lkj7OHb9UQqgyyXCuElBnbrPr77OmNyQddorkAkNvBqE5ZNf+nWK3Ks7wlHRWvi7K+HvIaH0KI7GCI45MatakLkczkLSNEqWszA/10E9Cvwomvp2JmRb0Y0hDdEqAd72202MziXroMLS8WZvnyK6FMehsglrCaxcOBrS8J1m91j59I93ZizvVHUD4JxFzFWwngypkDMm/HPP39CzKd73BWZlpcQJg0WJwQEEJTgVzaYyweUDslJDhxdkzg7A5kNdAhGxGF7jEgkiFJBJm/gQyjT2rJ6RQ+RIjcNqwA4wHNM3HeteW6IzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtdvlLVvUUqftit353CgmSYRe4WtNbPIlVfwfBPWc1w=;
 b=vPxUBOiiUWvAJO+g0wnjHkLwCPKtsWPya/+L8KDVskVK6d1jk7+YxIF+lZYQ97wvUT8IbaiNn3ngVi7MAytEtXg3U3HzRttPLoFU8uZnoErOPZVyF7MT53rYSK092+rcxE3+J7w2xus9C9zQcSzaFuYNTGle770PE7uimcUX+M35AKxsMGbIW4ZVN7RQUrQyxSo1lKH9xiUobQcEATrX50fxmzxaFKB7cOj1xW5Q2d1AsnwA6qGm515W0oOS5SvUc42GyBHG3qEw3jWS/FKFQKGqd8246YlbieXXRb8vkAj+JbMM0rXvpujVdsz8NOjpxqhTxnE0dxayPNj7XOf90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 01:14:20 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 01:14:19 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
Thread-Index: AQHb7u+DytQ/+OqxGUy5ACz03ltmJrQotjOAgAKB4pA=
Date: Tue, 15 Jul 2025 01:14:19 +0000
Message-ID: <PH0PR11MB7585D97F361063B17C8E64C4F557A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
 <CABBYNZLukco6ShSh_9NP4GgpukY7wuYcAX4Xhg00AdkTwOySEQ@mail.gmail.com>
In-Reply-To: <CABBYNZLukco6ShSh_9NP4GgpukY7wuYcAX4Xhg00AdkTwOySEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SN7PR11MB7019:EE_
x-ms-office365-filtering-correlation-id: 8c2b576e-7dc6-4813-b753-08ddc33cecfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VkViSVV1NittemRhTGhBNjJoektEZ01iQy90VGpraElrUkJDT0QxTGY5V0My?=
 =?utf-8?B?UjVyQ2V4b1ZRU2lhcEZYN0Q5TGs1K2pod0JyQ0JzRjU3UW5qQmxqOEt2ekps?=
 =?utf-8?B?WngrcXlXbVlhdUlsb0E3NmhpQUhxdXJ0d2VqbUJqZWRtZUVhMEdVNHdqMFVD?=
 =?utf-8?B?ckx3bFgrQlcyVkVpbi9mdHNXMEdvTDJnQnE2S0FuM0NlSVZDd0tsMDV4akp1?=
 =?utf-8?B?M0FHZm4xbHlYZkVSSml2dFZYblY1WDM3Ym1PUDh1TVhpWGo1RDN0RG1XZkZ3?=
 =?utf-8?B?WFZDOGQvYS9aamVQeEdXZkNpYmtvVUpkZzUyMTMrMW16dDBaaFpkMUN1TXZa?=
 =?utf-8?B?N2hHNkpiUXNrRVg1ams0UWFhdkVvWklYTEVuUGdVajBCeVpMS1g1R3UzMmpY?=
 =?utf-8?B?YUkzSjh4V2NtUU14d2ExemJkWUhwdmhaUjFpSS9BSlZuS1dIMnZKQW4wVjRB?=
 =?utf-8?B?NzhRdkp0NTdIVDJHbGlSdzRuUU9vKy8xdWd2Um5Dd0dLNk9IZkZVWXJTSFFX?=
 =?utf-8?B?VHJLL20yM2w0M3ZaWGNPQmhMclM2NWlSNFMvZnBYWUpBOHNhZEphYTg4MjIw?=
 =?utf-8?B?ajBGYU5BR0x6ZXIvMjkvcEZackZ1K1hiRVU3Uk54Z3FoODNFU0xGRlJqQlRU?=
 =?utf-8?B?Mnl0UWhRNVY5TDBPY2tRb3QzSk9zK0ZKTHdSdWE4aGdlZmdPRUFMOWdsNXhC?=
 =?utf-8?B?dkQzUWx0cWU2U2VLdlVkUTRmNEp2dlV0K1BkY0xZaXpyakw4VGVOVS9vd2lV?=
 =?utf-8?B?NTI5UXFwSHBMYWk3YzczSXZaWnJRa0szQ0Y0c3BGMDlKelZDWm9KS3NVYVZa?=
 =?utf-8?B?SEpnRlBZTlUrTGpGL0psdTlndFVMSDg1Y1ZPSjY0S2JoWWdLOFgwL3J1V1NW?=
 =?utf-8?B?b09sdWphc092c0N6Szc2bms0VzhOQUNDZnAyWW81N044UVJXcXplMTlQUVlH?=
 =?utf-8?B?RHcwdzlPbGk0TXFSbzNXZW1WcnNORzdCdmZsYTRFbWJZZzNwa2RUQXpTalFx?=
 =?utf-8?B?ekdjdjF1VHRReGxnS2kwMDEvN25qaUt4Z2pNb2lrbFNkZHlHY0RSN3hpckdY?=
 =?utf-8?B?K1FNd0tpc2JNeDdORnhvRzBEK005anZ1cStZeEszckg1L2hMa3ZvMGJOd0k2?=
 =?utf-8?B?RkFncWJPSzRJOUdyUmJLSVBIbGRuK3pGQm1KQzRsYno5aVBMYnI4R1p4MGN4?=
 =?utf-8?B?YUxhMXlFOUFkcDIyeFdYRSt6RENyajhubGJyUk13bjdQeWMyZUtIQUhxUTl2?=
 =?utf-8?B?bUFWRE8zL2lTbkNjN1I1RlgvZkwrRlVVU0o3WHBHcEZvUENQTkJUQUYyQmFk?=
 =?utf-8?B?RTNUeUhiT1J5TUNuVGx0WGdVajMvMzdhK1dVN05PSEl0VkQvWXNQTmxqM2pj?=
 =?utf-8?B?bHBhNzh6eGRHNFdibDdTdWgrK1M2T3NCd1FaZXkvM0FJeWkyQktCQmk5eG5W?=
 =?utf-8?B?eEdmZTdwMkdrV3A1VTRqMkFRSlpiZnRLRitVc0NLRXliRTM3L285UlZWZitn?=
 =?utf-8?B?bDkzS2NQaVBUeExMV0RRaXBjelZBdlhOVEM1dG9GYW5HYmQ2T0JXdEtIR1lI?=
 =?utf-8?B?YUpHeGlRdVFISFpXUno3QS9VZEVNakFsREFnSitQM0YzUTAxdHp4cWlWQXc4?=
 =?utf-8?B?TUpWMjVDbkttb1FSamFMZFh1ckU5WjVKajFoSWVmMmFybnEvMnhiVDBWc3RP?=
 =?utf-8?B?MXkvSUlid2hKZmRlMU5kbTV0ak5lYittZ0MwTlhwa1RPemp4OVZxREx3Vjkw?=
 =?utf-8?B?M0lNcjZxV2FPNGZXRnlzMXpBQ0tuRUlCMmhNZzloWVNFRW12dW1xdi9IT1d0?=
 =?utf-8?B?MFdWTzBiMWVRam1pbUVuSXZSYU9EWldaMUswSDcvbjdvbFlaVjhNMHNrOVEy?=
 =?utf-8?B?V1c3WEVKNGNocHNObXRhc0NmdW1jT0lrOFRWd3ZLOFZpMWhOcHhaTVNLd3dV?=
 =?utf-8?B?YnVpR01HN3BQRHRJQkZtdXdFS2wxV2dhOTdDWEtYR1ZYMXMyVU1EcW5Ga1pW?=
 =?utf-8?B?NUlkRnlTTzdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZLZEhKMmhaQVpxVUh2YTF3Mk02ejlCZUhNTVlDNDlsa25EcnU3UkxpZEdR?=
 =?utf-8?B?VmU4WkNpbVNlNzFtZTd6OEJHb2pOVkRiODNkeWF1WGhITWlkT0lWQU1ZcnRz?=
 =?utf-8?B?SitDUlBmM2RZY3Jmb1hCenFBb3lSRTk0YW1lRkVMMHVwdmpvQWdJa2haU3Qz?=
 =?utf-8?B?MFlhOTlGQXpUOWZlNllKTVBOcUQvelpCUTBuUXZwczU4YW9QUGZoNUcxVXEy?=
 =?utf-8?B?Qk44MHUvTWxaVUdsS2ZidXFJZnpOYUE3RnBYRENENnJJQysxdnZDcDVsa05H?=
 =?utf-8?B?MHdtMjNMeGZGNGR3ZGtqZVN4UkpKVGZneW00dHRmeWNGdzQzSUtSNXN1bmEw?=
 =?utf-8?B?TWxSVzRyVm9qVCtvd1FiQ0JjWmVrSzBvR3c2eUhXc1FZWHYzS1JESW1yTlN0?=
 =?utf-8?B?NitrQUg0czc4R0gxRmpycHUzc090WGo1WE9aeTF1R29MTWtPZ2hpWHUyMmxu?=
 =?utf-8?B?bWFlajN2bEF5MWpweUVGKytBVmtRT05uQmw4S3lDOHRPM1pldlcwT3ZQKzZl?=
 =?utf-8?B?ek91dVMyS0l0ZjJYYUJLVWtDVkJUVE9DVWZTTjBJdlN5SzU2RjU1eGZUTWlD?=
 =?utf-8?B?a3RsMEg0VjMxOEtzWjNScmFyakR6d1ZxMDZvaHhTSytvc25TdVVDekZlUElX?=
 =?utf-8?B?eDQ2M3QzU2pyK3JRL3dZcTI5Tlc5aElhNit1Q3RuQjQxek5OcEcrak85NFlL?=
 =?utf-8?B?dXFBSXltR0hsMU56S3hRY0g3cXcwSGM3YW12OG10b29KWStYajJ2WWNyRWlJ?=
 =?utf-8?B?TUJ6bG9Gc1Q2YlBZSUwvc2Q2TVZkdWMreUQ4c1VvU2RQdjF4TFJKRnpqUldB?=
 =?utf-8?B?dW1VV1ZmS2EzNjkzOU51V0VUdVhsY3JmVVVTbnVSUytGcUVJZEExTFliYUVF?=
 =?utf-8?B?N0RyOVNrd1ZUbmlCcDdKZDg5NHJmVlFsdGpUZS9adjkwMWtGZnM2RzEwMGFi?=
 =?utf-8?B?bGh4SmUwRVZnMHlZbXNWWkFDMG8wR2VHWXBCQ2plQ2lwZzhrSjBGdldpZmE5?=
 =?utf-8?B?WjRLOFhISUJCNHVQbzdyTnhhZTBEaGZwNVJ3MFh2eGFyRko1Q3VTNEdqRjY0?=
 =?utf-8?B?NjY0R3VYcG5lZXQ3K2F3RjdKZWRtb3l5YnV4M0lkalYrcDlwczNlU01JZ0Iy?=
 =?utf-8?B?a1U5aTV1ZHZ3MHc5UVdUWXlFMUJDN29KNUFQTkJtMnpiMmVxTGFDN0pUUVZZ?=
 =?utf-8?B?V0dvK1VxYXhsbTJBcmd3VzlCVEJydThBZTAvL0hkYmJSQzZpS0ZLRlhKd1N1?=
 =?utf-8?B?b1ZzWnRMYldCczVkM1MxLzVkdk0xeXhQZVBKRVVnRUZQMUtKQytmYWpBUG4y?=
 =?utf-8?B?Zy9YZ05TRDNZbGNLb1pnSGtnWWROZ0FJdTNZUHNHNGs0Nnk2SkpTVjZEODJX?=
 =?utf-8?B?MHlReU8yMkZiYWxUV0dlNURVMzJ1cXZuUHdUSTYycjlYVmNYank2MHFndVlE?=
 =?utf-8?B?RkdtTGFOTFNVaDlndGUvMmFla1VhN1dTY240R1JJWWtFcWs1N09BUzdyMlRq?=
 =?utf-8?B?MW5rWnVIZ0NZMkdMaEVhdlZCUDRrQlVHelY2ekFCMWdRaXhJT0VmSUF1RlF1?=
 =?utf-8?B?M0NhM3dsOVdGdDVwOHMyR21OZHFYaXlWWUlock1MNnR5Tm9EVTZCaDhUajRj?=
 =?utf-8?B?cFd1UmJRc0FPeDlQanB1a29ZWWFtTGNZdlIyN1Y3U3V2andoRTFROW1VY3lO?=
 =?utf-8?B?WWRmbDRNWnd0SEZUOXQrRmMydUdSMVdEQnNLUzl0aGUvb2liR01IcVIxR2Nj?=
 =?utf-8?B?Yk5yd3BDOFptVnhZRHdRTVIrWlRtblFheSsvcGE5SXRGaElwUTVpb1RENDZ4?=
 =?utf-8?B?MFZPZWtqL3dwRnlwVnZkbi9pbEtKTkI0WUJIajdaMFhYQ0pweWw2R0V2OFFq?=
 =?utf-8?B?bXNBUUJxKzBIM3hOSkNseFJ4UlJFOFQ3YWJNY1lSUkZQZFAxQng0N1E2ZExL?=
 =?utf-8?B?WnFrUjFva2pVWHd2Z0hJakR6RHhHWHJzcjQwVGNRZEFkRXZ4cDY3ckl1TTUr?=
 =?utf-8?B?ZFQyQUYxa05xTlkzTURUQWtiVWx0bGpzYTdadlhXVWFad3d4aGlGdHBCT3hq?=
 =?utf-8?B?MG1sVFozN25xcXVDaHRsY28xdWx1NGdKczB5UDZ4dU15RzA0TUkzenVybG9t?=
 =?utf-8?Q?PPko=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2b576e-7dc6-4813-b753-08ddc33cecfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 01:14:19.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GimorPrgykBeX3Z9mm7nUSmeLzM2BKLPhsVxHkwU1+VQ1hJrb7JTbaUHef6/NXUSUk0kO0KbcIEw2BSb9Cs1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8yXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogTWFrZSBkcml2ZXIgd2FpdCBmb3IgYWxpdmUNCj5pbnRlcnJ1cHQNCj4NCj5IaSBL
aXJhbiwNCj4NCj5PbiBTdW4sIEp1bCA2LCAyMDI1IGF0IDExOjMw4oCvUE0gS2lyYW4gSyA8a2ly
YW4ua0BpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEZpcm13YXJlIHJhaXNlcyBhbiBhbGl2ZSBp
bnRlcnJ1cHQgdXBvbiByZWNlaXZpbmcgdGhlIDB4ZmMwMSAoSW50ZWwNCj4+IHJlc2V0KSBjb21t
YW5kLiBUaGlzIGNoYW5nZSBmaXhlcyB0aGUgZHJpdmVyIHRvIHByb3Blcmx5IHdhaXQgZm9yIHRo
ZQ0KPj4gYWxpdmUgaW50ZXJydXB0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNhaSBUZWphIEFs
dXZhbGEgPGFsdXZhbGEuc2FpLnRlamFAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogS2ly
YW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiBGaXhlczogMDVjMjAwYzhmMDI5ICgiQmx1ZXRv
b3RoOiBidGludGVsX3BjaWU6IEFkZCBoYW5kc2hha2UgYmV0d2Vlbg0KPj4gZHJpdmVyIGFuZCBm
aXJtd2FyZSIpDQo+PiAtLS0NCj4+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8
IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRl
bF9wY2llLmMNCj4+IGluZGV4IDExMTNhNjMxMGJkMC4uZjg5M2FkNmZjODdhIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBAQCAtOTQ3LDExICs5NDcsMTMgQEAgc3RhdGlj
IHZvaWQgYnRpbnRlbF9wY2llX21zaXhfZ3AwX2hhbmRsZXIoc3RydWN0DQo+YnRpbnRlbF9wY2ll
X2RhdGEgKmRhdGEpDQo+PiAgICAgICAgIGNhc2UgQlRJTlRFTF9QQ0lFX0lOVEVMX0hDSV9SRVNF
VDE6DQo+PiAgICAgICAgICAgICAgICAgaWYgKGJ0aW50ZWxfcGNpZV9pbl9vcChkYXRhKSkgew0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgc3VibWl0X3J4ID0gdHJ1ZTsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHNpZ25hbF93YWl0cSA9IHRydWU7DQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4+ICAgICAgICAgICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgICAg
ICAgIGlmIChidGludGVsX3BjaWVfaW5faW1sKGRhdGEpKSB7DQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICBzdWJtaXRfcnggPSB0cnVlOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2ln
bmFsX3dhaXRxID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPmFsaXZl
X2ludHJfY3R4dCA9IEJUSU5URUxfUENJRV9GV19ETDsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPj4gICAgICAgICAgICAgICAgIH0NCj4+IEBAIC0xOTg1LDggKzE5ODcsOSBA
QCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zZW5kX2ZyYW1lKHN0cnVjdCBoY2lfZGV2DQo+Kmhk
ZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAob3Bjb2RlID09IDB4ZmMwMSkNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnRpbnRlbF9wY2llX2luamVjdF9jbWRf
Y29tcGxldGUoaGRldiwgb3Bjb2RlKTsNCj4+ICAgICAgICAgICAgICAgICB9DQo+PiAtICAgICAg
ICAgICAgICAgLyogRmlybXdhcmUgcmFpc2VzIGFsaXZlIGludGVycnVwdCBvbiBIQ0lfT1BfUkVT
RVQgKi8NCj4+IC0gICAgICAgICAgICAgICBpZiAob3Bjb2RlID09IEhDSV9PUF9SRVNFVCkNCj4+
ICsNCj4+ICsgICAgICAgICAgICAgICAvKiBGaXJtd2FyZSByYWlzZXMgYWxpdmUgaW50ZXJydXB0
IG9uIEhDSV9PUF9SRVNFVCBvciAweGZjMDEqLw0KPj4gKyAgICAgICAgICAgICAgIGlmIChvcGNv
ZGUgPT0gSENJX09QX1JFU0VUIHx8IG9wY29kZSA9PSAweGZjMDEpDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICBkYXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxzZTsNCj4+DQo+PiAgICAgICAgICAg
ICAgICAgaGRldi0+c3RhdC5jbWRfdHgrKzsNCj4+IEBAIC0yMDI1LDE3ICsyMDI4LDE1IEBAIHN0
YXRpYyBpbnQgYnRpbnRlbF9wY2llX3NlbmRfZnJhbWUoc3RydWN0IGhjaV9kZXYNCj4qaGRldiwN
Cj4+ICAgICAgICAgICAgICAgICBidF9kZXZfZGJnKGRhdGEtPmhkZXYsICJzZW50IGNtZDogMHgl
NC40eCBhbGl2ZSBjb250ZXh0IGNoYW5nZWQ6DQo+JXMgIC0+ICAlcyIsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBvcGNvZGUsIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3Ry
KG9sZF9jdHh0KSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ0aW50ZWxfcGNpZV9h
bGl2ZWN0eHRfc3RhdGUyc3RyKGRhdGEtPmFsaXZlX2ludHJfY3R4dCkpOw0KPj4gLSAgICAgICAg
ICAgICAgIGlmIChvcGNvZGUgPT0gSENJX09QX1JFU0VUKSB7DQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICByZXQgPSB3YWl0X2V2ZW50X3RpbWVvdXQoZGF0YS0+Z3AwX3dhaXRfcSwNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5ncDBf
cmVjZWl2ZWQsDQo+PiAtDQo+bXNlY3NfdG9famlmZmllcyhCVElOVEVMX0RFRkFVTFRfSU5UUl9U
SU1FT1VUX01TKSk7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXJldCkgew0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZGV2LT5zdGF0LmVycl90eCsrOw0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidF9kZXZfZXJyKGhkZXYsICJObyBhbGl2
ZSBpbnRlcnJ1cHQgcmVjZWl2ZWQgZm9yICVzIiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBidGludGVsX3BjaWVfYWxpdmVjdHh0X3N0YXRlMnN0cihkYXRh
LQ0KPj5hbGl2ZV9pbnRyX2N0eHQpKTsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0ID0gLUVUSU1FOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGV4aXRfZXJyb3I7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICB9DQo+PiArICAgICAgICAg
ICAgICAgcmV0ID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0X3EsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPmdwMF9yZWNlaXZlZCwN
Cj4+ICsNCj5tc2Vjc190b19qaWZmaWVzKEJUSU5URUxfREVGQVVMVF9JTlRSX1RJTUVPVVRfTVMp
KTsNCj4+ICsgICAgICAgICAgICAgICBpZiAoIXJldCkgew0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaGRldi0+c3RhdC5lcnJfdHgrKzsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0
X2Rldl9lcnIoaGRldiwgIk5vIGFsaXZlIGludGVycnVwdCByZWNlaXZlZCBmb3IgJXMiLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidGludGVsX3BjaWVfYWxpdmVjdHh0
X3N0YXRlMnN0cihkYXRhLT5hbGl2ZV9pbnRyX2N0eHQpKTsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IC1FVElNRTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXhp
dF9lcnJvcjsNCj4NCj5UaGlzIHNob3VsZCBwcm9iYWJseSBnbyBpbnRvIGJ0aW50ZWxfcGNpZV9z
ZW5kX3N5bmMgaW5zdGVhZCBvZiBkb2luZyBhIHBvc3QNCj5oYW5kbGluZyBhcyBhYm92ZSwgYWxz
byBpZiBJIHJlYWQgdGhpcyByaWdodCB0aGVuIHdlIGhhdmUgdG8gd2FpdCBvbiAyIGludGVycnVw
dHMNCj53aGVuIGl0IGNvbWVzIHRvIEhDSV9SZXNldCBhbmQgMHhmYzAxPw0KPmJ0aW50ZWxfcGNp
ZV9zZW5kX3N5bmMgYWxyZWFkeSB3YWl0cyBvbiBVUkJEMCB0aGlzIGFsc28gYWRkcyBHUDAsIGhh
dmluZyAyDQo+aW50ZXJydXB0cyBtZWFucyBwcm9wZXIgb3JkZXJpbmcgbmVlZHMgdG8gYmUgZW5m
b3JjZWQsIG90aGVyd2lzZSBpZiBHUDANCj5oYXBwZW5zIGJlZm9yZSBVUkJEMCB0aGlzIHdpbGwg
cHJvYmFibHkgdGltZW91dCwgaWYgdGhpcyBpcyBkb25lIG9uIHB1cnBvc2UNCj5sZXQgZG9jdW1l
bnQgd2h5IHdlIHRoaW5rIGl0IGlzIG9rIHRvIGRvIGl0Lg0KDQpUaGUgVVJCRDAgaW50ZXJydXB0
IGlzIHJhaXNlZCBpbW1lZGlhdGVseSBhZnRlciBwYWNrZXQgcmVjZXB0aW9uLCB3aGlsZSB0aGUg
QWxpdmUgaW50ZXJydXB0IGlzIHRyaWdnZXJlZCBhZnRlciB0aGUgZmlybXdhcmUgaW5pdGlhbGl6
ZXMgYW5kIGVuYWJsZXMgdGhlIGRhdGEgcGF0aCBmb3IgcmVjZWl2aW5nIFRYIHBhY2tldHMuIFRo
aXMgb3JkZXIgaXMgZ3VhcmFudGVlZCBieSBmaXJtd2FyZS4NCg0KPg0KPj4gICAgICAgICAgICAg
ICAgIH0NCj4+ICAgICAgICAgfQ0KPj4gICAgICAgICBoZGV2LT5zdGF0LmJ5dGVfdHggKz0gc2ti
LT5sZW47DQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KPj4NCj4NCj4NCj4tLQ0KPkx1aXogQXVndXN0
byB2b24gRGVudHoNCg==
