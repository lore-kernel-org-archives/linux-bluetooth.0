Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9E72621
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716100; cv=fail; b=ty5j95p00OO0ts1lQT/uj8Hg/wd9DxvYoIPZ1ZWqZgC9grVC5ZrAcNBFmgJRcGMRqxyby8qLzfOxWWJ5f2Tbrc6MCRxG0b9UMsPLTfjX9/xpwjB+Zi0P9rd/9gSM3qRL0m7bzaum381R9W3yrtbVbG4p3Q2UfWGyqOCnh3jk+ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716100; c=relaxed/simple;
	bh=EnPkGyagiTL32CflGoMDt1MVcmUc4Wkq+D+96nCcBKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8MZz+2Xh2kj7XoqLvuFAhAy2YlJCFQ8yIGiOXHFLXmfq0JVFnZRJozD1ddJCslJ/0JxHZ3mU9+99S+2aPdJLh985njKW7vOIb0cLkKmG4HwBIiFuslD3bfIGnkNCdmHrPZwG62E9Z4qwoX5qJHU3ZJtaKaxNfzh5pQZEXMD9s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKv6fZLr; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKv6fZLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753716098; x=1785252098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EnPkGyagiTL32CflGoMDt1MVcmUc4Wkq+D+96nCcBKw=;
  b=OKv6fZLrEJP4bygHnCeu2YLL9KpARgpiDKq7kjzJIPIHsWS3hSMlgd+f
   96QFVkJokmebn0QC9QA+/X1Tn87ICn3kqhDvQZBATd/Gl2Qkrlco3fZKO
   ElV3XaGO45lQUoQlkrMm6Wma1b2XJeAHZQMrsHlXdjJxeQx/dWqNxvrGH
   p84cycoUr12cxoYwM+zZs0C2wLCfqF0RCTvaF/Uos2vYAJTqzSJKLrqgx
   w27KJaGt34RS7ni9WQvlzly2GFnZ9yEJTYSCLtJUC1MkgowHi0GpLH+05
   XJ4H4QZIihTywcORP1LcE0s4Yx7BYwbabBqwHT8Ikx+fIR06hYSKCFbal
   A==;
X-CSE-ConnectionGUID: 7UgAlKWfSGW4Xz2i0WUpLw==
X-CSE-MsgGUID: exfPHMUoTk2YyrEzJ+3jdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67319971"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67319971"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:21:37 -0700
X-CSE-ConnectionGUID: RjjE3sPFQBKbNz/Az2VtYA==
X-CSE-MsgGUID: JnK+kwEWReme0hXJSRHU2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162770112"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:21:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:21:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 08:21:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t33qw2CRVZFwcQ6JlCVBadyFk7wlOmAHMrxVpyr124pj62B2Rd6+uAAf7IN5kO9RrrEMvSBveg1qa82prFWi3WTuHiTrCS66W0RKW+P7+Zy3eiHvs3yVRPreU1Lv5fQ7lu090jShgKOV58CZ8CtbvJSIsTyGArIpD7qFIlE6BD0ipCUGgDAD7ztJG393nMDafEt2ZviB46RytCElvwYyvziCSDz2XPkQiMH/hgNsxIOXtkIIYZSYjdcLaYjJXiXEAom62mF25d386o3GDmXBvoztwWEjwmtmf0l6eD4m24PZg1wFrWFqOevB+GJlsfwvkp1DcufBMUPLAxiSEKEJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnPkGyagiTL32CflGoMDt1MVcmUc4Wkq+D+96nCcBKw=;
 b=v/YyvWKgWYLWgLhwOVj1uXQUvehZaxUZQ66wmmAAxkBRq4sMKYb5A3lVsREmMRUQXcC4mgApjoaZDkaPklv3halXIKDBkke/607Fis+HsnG3i0PSM0QUnUiVkjL1VRPRwmXRfuvi/c/gFW+fm/nTl5yOJZ9P0DstutSKmSAMYu7qS73Wjun7h5zuhzAXx+c7Tnt/b20iPptGdCkwo3W4wQtjVres3Zd9Fg+ztd3ikW4lhHKSiGtjvyA7fgk4CbSX1alPXSkPbugjlitgK9e9kJ8byxG6xzZkqCOvKf0joYbvjKOlOB3yopVuiE/6Nd4doDj1FZR/czDehF1ErpnEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 15:21:19 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 15:21:19 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v2 2/2] Bluetooth: btintel_pcie: Add support for device
Thread-Topic: [PATCH v2 2/2] Bluetooth: btintel_pcie: Add support for device
Thread-Index: AQHb/5yK9ufxVnwPCU+alEgfv6myz7RHiiuAgAAc7qA=
Date: Mon, 28 Jul 2025 15:21:19 +0000
Message-ID: <PH0PR11MB7585FF3322569795AE098517F55AA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250728090554.1425120-1-kiran.k@intel.com>
 <20250728090554.1425120-2-kiran.k@intel.com>
 <80683fab-a4a5-4f49-ab66-d69cae30a1aa@molgen.mpg.de>
In-Reply-To: <80683fab-a4a5-4f49-ab66-d69cae30a1aa@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|MW6PR11MB8312:EE_
x-ms-office365-filtering-correlation-id: 75890053-2cc3-4c64-0974-08ddcdea6727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c2IxNFViZFFNeU1qaEtUME1BWGR3aFBSVHJMRkxqQkhWNTVTeVZneW42YnBX?=
 =?utf-8?B?Rm51c1Q2UkJuWHJhWEgwK1djZGl0T21TQUZTQSt1YWV3dURWNFNKSXdwSml4?=
 =?utf-8?B?VXVZYjFxSE0wMUZKSE5qVmdKbzFnRGhiMmZtbUdUbTArRTQzaGdIVmMycVV3?=
 =?utf-8?B?NWdKL0tqdFZ1VkxuVGdWbE1ZWDM1bkUvd2VaYThSN2FxdThicDU5VFUrRlVC?=
 =?utf-8?B?ZFpjd01DVWVGSmovUDdBS0U5OENyQmUvMlcra3VpV1dpL3lCR0JnUFRRQXZ2?=
 =?utf-8?B?cGVSMmVnTFkvbk5oTHpHc1VFSC9YUklDM3dWVGl0bXZTRklhZ3NxVTlOM25Z?=
 =?utf-8?B?QllPV3lIV05hSVc5RUJPN1kyT3JVb0FJZnQ0UER4cjZxaU52K0RpbGc4eVhr?=
 =?utf-8?B?eUhISG5qRjVvM1JBL1I0WDVFdGRNR2pTWFIwcXJpMGRacE5uNlVzVXJPREVq?=
 =?utf-8?B?U1NRNmt3Y0x1MjBXNDV2RkY0cEtiVkFzWUtFdWk4dVFxUEp4OWtldTVOc3Zl?=
 =?utf-8?B?WXF1MHl0Y0hHL3JkRStMaHlBTXdkK3ZkNTFsSlBHYUg5MWRjTWxKU2ppTnls?=
 =?utf-8?B?S0FmdkVvUm1zdzVOVnRzTmJQQW1rNFRNSTdxT1RkMlEreHJCMWh2OEY3b2VF?=
 =?utf-8?B?Tjc3UkFkN3VydWRObS91cStXNHlRSHZzQjFYaTZXTyt1cUkzVFhLb294bjA2?=
 =?utf-8?B?ZFF5YlNxUWRMSzhmNXoxR2t1VFB4QWRyNjhqbVBmbzFwNklnOUdkWXl6Tjg0?=
 =?utf-8?B?VWlDZXBjRlZFaGwxTkxoejRXQk9HdDJyOHdkWmxwSnBGTG1DZndxTTJtYnRI?=
 =?utf-8?B?MThCSDhBbjZnY2hSU0NQSlpZZmlCb3NvSW1JbVhlUDhJU3pTV3lEZGxWczZs?=
 =?utf-8?B?ZWdUU3hHeExQN3MwcU1mZnUrck1tNU1CVUFLcG1hak8yMURFQjN1elh2R3RC?=
 =?utf-8?B?MjArN2NHdTRXbmxkNzJRbGNDOGJ4NDY0Qlh3QkkvcVZzWVZNWVNIVWVHcHlC?=
 =?utf-8?B?VzlWVkFTYkZyTTd5eFBCbTRNUGdQY2QwdWZ1ZGQxS3AwZCtoMW9MRHdYb2hF?=
 =?utf-8?B?amVWV1RjNUJlaFlvcHZ4cHFzc0dvMXI3bkNidnZweXlhY1ZwcEJvZTZYYkEv?=
 =?utf-8?B?Mk82Zzc1UVcvYmJuK1g2VDZEelJTUlUxblVsbGZhVmo2UHZuaE9uOTlZcHpk?=
 =?utf-8?B?dkJLZVVEMzdIVTlpUnFiMkMxc3VwN1Y5b1ZPeTF4RXpoSVFRVzN3VGR1N0Jt?=
 =?utf-8?B?ZktPWlJPQlVqbHFFN2VscjhrWmY3c1NGeUVEZ2E3OUNLck0zWTFrbjZhQllS?=
 =?utf-8?B?YklOemhFbU9va2FoQnVRcks4L2x2MTdIK29TM1k0ck41TnFyNE5ia29BRDg5?=
 =?utf-8?B?cTY1ZVl2Z3ErL3NTSE5DbE5mM3hQMDlWMnRVdHdtVW91cWNEdnpxeittT0xl?=
 =?utf-8?B?Mko1VXZ4QjgyWVErNFNWZ2lhN3h3cThtZG9tR1JVc09Ud3NLeWNnT28rZGVr?=
 =?utf-8?B?dG55Y3pYMEpFSlFoVnRFUFBHOTlVd3VCdGFLTnBSUGt2V0hlOWVua1IyQ1hJ?=
 =?utf-8?B?NE0vTzVKVy9uano4S2ZHcExVWm1wOUgxNk01cGxHRWZJTncvdnorTUxkdzdJ?=
 =?utf-8?B?VWdFNEhxcTVQYUgyL3dMSXRhcEtzeU9tRzlnbFA5WEV2TlNacTNJaEdWZ0pH?=
 =?utf-8?B?cTZXVkt3NFM1Qk1sMmhaSFZMMmIxZTlRdzErK1RWQkp0b2pTOUZMK3ZDV0I4?=
 =?utf-8?B?Mm10Yms5K2s3MEp6eWZ5dUZPUTROaGEwRTNvWXh2MGJZbEdlb005ZVNUNTAz?=
 =?utf-8?B?Rjk3MEZPbVVja20xdEhqUC80cHAvZkFWWkFJSTFoRjJxSklyd1U1S3ExMGdJ?=
 =?utf-8?B?QjZKNkNaeTQ0UUt1SmZ5RzVmM25GeVovR2lYdzUvSlJLOW5OTFVySEQxVDZI?=
 =?utf-8?B?SU01K0I5dTJ2ZUNzdlNvVE1sMk1BNVQwaXErNzg3b0tmTDVYZmhIdmlFc0VC?=
 =?utf-8?B?RmxUQnFkTmV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlI2WmYrVi95ZjlQQXJqeStMT2psTHhCQlZYZ1FvTmdla3NCWjRCeFpXOGpi?=
 =?utf-8?B?b2RYVjkybkw1S0pFR3hSYTg4aDZsQWpDU1pWekltY2xKcUlGZ3VhLzUrTmNv?=
 =?utf-8?B?RWhtMXhpQkd5ZDFTYXhBaFFpaVh3MStoSUMzbHlML1F0T3JWd3BiZkRhdldp?=
 =?utf-8?B?QnptT0tic0liZEJQVUVwZkRTOWk0SjVBbmlpRVFCRzBDSkFzZmNvTm1WcEgw?=
 =?utf-8?B?c0tMK09nV1FPaks5OTBSOXA1NUFWQzhPNjk4QTR3emdjNWpoT0dWNE4yeFFX?=
 =?utf-8?B?UERPTllxbGkvMWZMYnZ0THAvVzBxRnhWdml1dUVScnN6RDNodjBMK3p6QkZC?=
 =?utf-8?B?elgwd0JMMXg5eVdGNmFscHJhVHV4aVEzSloyd2tLV2dMYk9qL1F5UzdQMHY3?=
 =?utf-8?B?ZkZxQk14VHNaNnJ0RG9jWG5YczBTRE9LUXg5M3R6enFpRFEyWXBZMEgxa2Qr?=
 =?utf-8?B?Ym5nZHdNMHdpcFJOTkltQlYzL3h4TWVCd21NSVo0b3hZcG1lUkZ3WEFEOWNj?=
 =?utf-8?B?ODZKYkp3MUJmQzJodWhLUHRNS2xOcGtKUXkxY0p2QnV4ZTVYQVpTcG9WdDBR?=
 =?utf-8?B?bTBOaWdIM1JGSUJEQjkvb0dHTGRlb2lUSEc3UzI2ekp3aWNtMVBXc29zRGdG?=
 =?utf-8?B?eDlQOHc1V3REN3NoSmlkbm5CQUU5a0pvakhGRFQxZ2lPNDVPUjZ2ZUp2ekZq?=
 =?utf-8?B?L0ZMdyszR09vMW5rbjdjWm5CQS9RWURvemt0YjZxRTNXNDJKK1MvQkYvditY?=
 =?utf-8?B?Tk1zSzZiamowVUJ2UUQzelRtOWp5SFo0VE5jT3RyUVVqSXJyS3VpOE51Y1dU?=
 =?utf-8?B?aDMwV0pLMXd2aS9Zd3pvbmJDWnN4cHNUUmxMNlBKZXpLU3hObkRmUkR0bjds?=
 =?utf-8?B?QXVVOWUvQ3B2OXJLcjE5UVdWenVJbUxmTXdKZGoveGF5VWh5MllhY2RMTHIw?=
 =?utf-8?B?TklVVDVEOE1qYXc2bWpRZktlVnJpZ1ZON1REQjczTlUrbkozMmpoS0luNnor?=
 =?utf-8?B?V3AzL1doR2Rqc3FPOVE5dXQ4bkFRakZwaVJVa3RpOW45dkxhOGo4RjNPcFV5?=
 =?utf-8?B?S1BpNnpjdlJaQTg1UFMyam1ROVBHcWxJanUxbnp2TU1UbXJ0VEMwdG1aRHdm?=
 =?utf-8?B?QnU4SVEzdTMwTjRsZkdFWExkZ2ppYTVwTi9ibVFxd0gwNWt3aDIrd01WZy80?=
 =?utf-8?B?VEI0b214cm9TWFU2c0t0aTVVaVRQMEJkbkVlTzVvVnBKODVpOWxINDE5R21y?=
 =?utf-8?B?R2kyajczRjk5bi9vMTNHYmVVa3E3ZFJyME8rVldzdXM5Y2t5Nys0Q01zc25T?=
 =?utf-8?B?aUJ4c2VHZEFBV2pYb09POGNIcnlhTmpHNndmbkpoR214bUFRN1RmZFNyWlBB?=
 =?utf-8?B?Y0ZJVXh5UnlxTzlpUVFDSHRBQk5sdXYvNkZlaDZGTFBHU20waDVjcWRLUWV6?=
 =?utf-8?B?RUw0TGxjcThGem51Y1hZaFA3cjNLZkpTdHRVTm1Ib09oWHNIVS9NUG1qeExw?=
 =?utf-8?B?Y1NzcEJpdk5ZRk1tZFVBZ0NYMXI4bkFUbHJCMmQzMEI2OU14MkhiUzRWTENQ?=
 =?utf-8?B?Wk40RE9EbXd0R1JxQzdXaXRHNjRFekYwbWdqenRPZUIzbXRBQnFwU0pTdFc5?=
 =?utf-8?B?K3dXOVc0NG9aTld4YVNTMHQrWm1FVWREYWdCd3oxRWQraDVVcGNMOUxIWFZy?=
 =?utf-8?B?enA5ZW5qaUpsT2sxZlpSVmpJTmVuaGdlQjlxd3BSNytJejhYVStVU1E3cUwy?=
 =?utf-8?B?UVE0ZXBITVRNNWRXMFFvWnlvanpsWkgyREY3OThVeG9YME1pczh2THBmUitu?=
 =?utf-8?B?dXZpcm9FSTljSHpNQmxLazd4RnFyOVFsRkE0bmFMSjVvblU2YWFSU2N0TS9K?=
 =?utf-8?B?QkFSZEM0M3hXNk1EdEdKRWVJUjN6MEVvTkEraGcrQTQySGpmNlFLdVBNc0VF?=
 =?utf-8?B?bUxBKzF2b01GQVlEMVVoQU5NM3pGY3BUZ29SeUx1VWtteDROMkkwOGJEVFRQ?=
 =?utf-8?B?K0NsM0VwSXMwRVpjekxpeDc5c0liZG1EZGRZNnVZcWhFYmthTlRabjZSOWZ5?=
 =?utf-8?B?NFlyYVJ4TlVSTm9FbUtqTU1EQ3NlR2JkTm1temh4UjQ1bWFpTTcwS2Fha0tI?=
 =?utf-8?Q?x8Go=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75890053-2cc3-4c64-0974-08ddcdea6727
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 15:21:19.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Dmomy67/S18xnRzaCrwTvO/2gjHE/Bpl50P3eiW3B+rJEKhClZ5sKmP5lb9BlE+5FNX1wvtCqbeu488tLpy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGF1bCBNZW56
ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj5TZW50OiBNb25kYXksIEp1bHkgMjgsIDIwMjUg
NzowNyBQTQ0KPlRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+Q2M6IGxpbnV4LWJs
dWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPjxyYXZpc2hh
bmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBEZXZlZ293ZGEsIENoYW5kcmFzaGVrYXINCj48Y2hh
bmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
Mi8yXSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogQWRkIHN1cHBvcnQgZm9yIGRldmljZQ0KPg0K
PkRlYXIgS2lyYW4sDQo+DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPg0KPkFtIDI4
LjA3LjI1IHVtIDExOjA1IHNjaHJpZWIgS2lyYW4gSzoNCj4+IHN1ZG8gbHNwY2kgLXYgLWsgLWQg
ODA4NjplMzc2DQo+PiAwMDoxNC43IEJsdWV0b290aDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNl
IGUzNzYNCj4+ICAgICAgICAgIFN1YnN5c3RlbTogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDAw
MTENCj4+ICAgICAgICAgIEZsYWdzOiBidXMgbWFzdGVyLCBmYXN0IGRldnNlbCwgbGF0ZW5jeSAw
LCBJUlEgMTYsIElPTU1VIGdyb3VwIDE0DQo+PiAgICAgICAgICBNZW1vcnkgYXQgMTQ4MTUzNjgw
MDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KPj4gICAgICAgICAgQ2Fw
YWJpbGl0aWVzOiBbYzhdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzDQo+PiAgICAgICAgICBD
YXBhYmlsaXRpZXM6IFtkMF0gTVNJOiBFbmFibGUtIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQr
DQo+PiAgICAgICAgICBDYXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyBSb290IENvbXBsZXggSW50
ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwDQo+PiAgICAgICAgICBDYXBhYmlsaXRpZXM6IFs4MF0g
TVNJLVg6IEVuYWJsZSsgQ291bnQ9MzIgTWFza2VkLQ0KPj4gICAgICAgICAgQ2FwYWJpbGl0aWVz
OiBbMTAwXSBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcNCj4+ICAgICAgICAgIEtlcm5lbCBk
cml2ZXIgaW4gdXNlOiBidGludGVsX3BjaWUNCj4+ICAgICAgICAgIEtlcm5lbCBtb2R1bGVzOiBi
dGludGVsX3BjaWUNCj4NCj5J4oCZZCBiZSBncmVhdCBpZiB5b3UgYWRkZWQgdGhlIG5hbWUgdG8g
dGhlIHN1bW1hcnk6DQpBY2suDQoNCj4NCj5CbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogQWRkIGlk
IG9mIFNjb3JwaW91cywgUGFudGhlciBMYWtlLUg0ODQNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEtp
cmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiBjaGFuZ2VzIGluIHYyOg0KPj4g
ICAgICAtIE5vIGNoYW5nZQ0KPj4NCj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2ll
LmMgfCAxICsNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGluZGV4IDhmMDJjMjdiYzU0NC4uYzBjM2UxN2E0ZmE0
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsr
KyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBAQCAtMzcsNiArMzcsNyBA
QA0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgYnRpbnRlbF9wY2llX3Rh
YmxlW10gPSB7DQo+PiAgIAl7IEJUSU5URUxfUENJX0RFVklDRSgweDRENzYsIFBDSV9BTllfSUQp
IH0sIC8qIEJsYXphckksIFdpbGRjYXQgTGFrZQ0KPiovDQo+PiAgIAl7IEJUSU5URUxfUENJX0RF
VklDRSgweEE4NzYsIFBDSV9BTllfSUQpIH0sIC8qIEJsYXphckksIEx1bmFyIExha2UgKi8NCj4+
ICsJeyBCVElOVEVMX1BDSV9ERVZJQ0UoMHhFMzc2LCBQQ0lfQU5ZX0lEKSB9LCAvKiBTY29ycGlv
dXMsIFBhbnRoZXINCj5MYWtlLUg0ODQgKi8NCj4+ICAgCXsgQlRJTlRFTF9QQ0lfREVWSUNFKDB4
RTQ3NiwgUENJX0FOWV9JRCkgfSwgLyogU2NvcnBpb3VzLCBQYW50aGVyDQo+TGFrZS1INDA0ICov
DQo+PiAgIAl7IDAgfQ0KPj4gICB9Ow0KPg0KPlRoZSBkaWZmIGxvb2tzIGdvb2QuDQo+DQo+UmV2
aWV3ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+DQo+DQo+S2lu
ZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
