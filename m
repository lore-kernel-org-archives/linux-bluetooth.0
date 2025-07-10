Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967213A3F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145551; cv=fail; b=OkYVDAwcFq9HrX0Wasf1wv7ekN6ffWe2KVla/FkYWTilpuVyTDLjxTY28RbvrXw0N7VLtslDsFIgPKAofznVHsrdcXABVFz2sFlwhvLwtiUNIY60+TyQ9wWHVKm5lI958OZJLrWRaewWfPkwadm1hqOn9OAV9J0FLZZPyBveZes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145551; c=relaxed/simple;
	bh=yYm/JVr/85sWRd6lg5CY5ofWq5j+ma3X5FI/H+vt8OI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lxsZPgIYyEowXA7ozB7YtjOy/1zdZvPEk5ghAOVNgCBs84NZeSP68MPPqa5fvrQnBWVuPeAKaSDsZ2psOXJ8gcNsMAApQgUuwnKF/01a8Pf4ednWBTjrj9Zwvjrx7AQgQn9HXsVW+yXnR20kj/T6Pc0mFa6PJQJHAeJ/uuL42HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8oEDono; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8oEDono"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752145549; x=1783681549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yYm/JVr/85sWRd6lg5CY5ofWq5j+ma3X5FI/H+vt8OI=;
  b=L8oEDonootDSVaW0acZtlaWlKNR6z2DXvFvziTiWBTVeycT6gzJBCNDi
   UizZJR8nnU3MC2YOp4Oh8ugwer07HrxUxZvE7111qMkDrGp87vr54NaeG
   iYGgAy686LmNg31Y62HBScXTomvoMeNie+hmOu3iZTqnWseUUBgrzuExd
   BnbnymAwF7V6KANnmj0XdXHxvqFoWq01p1GdPUA6VZLoXr8A5xxklaQ4w
   s7QWTPKYZfvSKOiCBi3s8+Upsl3J71BeNyPsR+QMf+GdyP/AQ2vGQwQCR
   np2cBtfB/FKHkZhUHsBw2PHBHiLh+kq5qrTl7BPAZAa8rWzFE1NGA8doa
   g==;
X-CSE-ConnectionGUID: bI8+3JVtRIaRFnjNiweq7Q==
X-CSE-MsgGUID: iX4mopEJSraVuxSP3P5XyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54548634"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54548634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:05:49 -0700
X-CSE-ConnectionGUID: 8oLGrHhBTDCrj7rnC4asOw==
X-CSE-MsgGUID: J9VVxQw/TyCj9izmnMAavg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="161609801"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:05:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 04:05:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 04:05:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 04:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlyPZt4Ufp5tMGb6sYC/6b397uSH9yiv62dJwzC8PYzyfFsjBbFEF7KT0fDekioOV+oZqiiNEeCP0xQq6eNmVGZ2LjUQc2JJcZIWgl79yriezciOECMTvu5/DvaMn8m69D5AweXIAoBjcfg9EqpmhltJLg2BKiN87aq3XngQhJKEBWWr116lkOp8XwMDGE0U1tV3IylEgm0iBHPNqUh4WlcbzeMc0tq0gVfTgnm3RRIovgMNwQd/HsYTkqClnn0XVDjo9v2MliYzQjjFjTWC1n9cwtJqz+xqwPFeev634Mv37Ug8+XCdcQ/eHJLWm/tF9ouNYw3xEaCns3H5OTgP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYm/JVr/85sWRd6lg5CY5ofWq5j+ma3X5FI/H+vt8OI=;
 b=PUILrtXJ/8OK5uKKD/bHnS2+9fOeL+AR7tm4Sy6S02IoUUBk++lhwLZod5LdlWEQy26aF1kPfIsTbeuvd7JDqDuPcdN/Txx35mzAau72572BNTpGH56e4Jb+3ta/lSvC+85myJdaGVQJ/6hIWFyMm8nFKdrrtxUCESF82+HP+xDqDpB1AXu38sDnyfEmdtlW7qn1boLl0zFAM+Jal87WdhEXgtPggGfx3X+oaUMbWXRludzVNKf/1t1ed6ZTDp399w2JTtftPeqV9fy5x+iqiy2QhFo7Gwa4d6IC6ra8MVl9ooqFScU+i1Uz6tOjWQnrdn3po3VgYJEtRm6MA4+daA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 11:05:18 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8922.017; Thu, 10 Jul 2025
 11:05:18 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
Thread-Index: AQHb7u+DytQ/+OqxGUy5ACz03ltmJrQmLRAAgAH3lsCAAGlaAIACqNAg
Date: Thu, 10 Jul 2025 11:05:18 +0000
Message-ID: <PH0PR11MB7585152AD9D7EF6C9F75971DF548A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
 <e3bcf617-7b9f-4229-89a0-12ea9e0e001b@molgen.mpg.de>
 <PH0PR11MB7585AF4917BFA37FD1A29AE4F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
 <c53f34c7-b5cd-44fd-b1cd-8806ec19b89b@molgen.mpg.de>
In-Reply-To: <c53f34c7-b5cd-44fd-b1cd-8806ec19b89b@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|BN9PR11MB5306:EE_
x-ms-office365-filtering-correlation-id: 291401d5-f361-4ba9-96df-08ddbfa1a816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aWNId2tqSHUrakVpZ3hLU0Vma0s3V1NnUWlINVFJdXBEb2REQlN5NTBxTUIv?=
 =?utf-8?B?SWxNMFdFQnNnRmlNc3ZyZmRKT2YvVlVDL0hTR3ZFaldSc2kxbHIzSkkwNVN1?=
 =?utf-8?B?L3FaeGJ6UnRPQ2FBeUo2ajhoVUlKMkdvSUpwM3oxNVBFNmNUTXk5eUtaZndG?=
 =?utf-8?B?b1RaSXlGTis1bXBseGJFRDlVRXo2c01RcTlEQVlvd1ljblJDS2xVUkJRcENj?=
 =?utf-8?B?UHlQRUg3ZGNoUFNvYWFxaHJGcmprMmk4T25zREFQSTZJcFA5TGVXUTZUYXVC?=
 =?utf-8?B?Qk5KN2VqUnZBQmIyQjlqWVFLYWpwM3lkb2VaZ05peHQveC90MExvY0g4d1JT?=
 =?utf-8?B?WTlhekhlUGpETFdNTEhSMG1jLzVlQkR3ZGRHUGtjYnc2TWREOEJRcGRKMmdy?=
 =?utf-8?B?djBZdnQ0K1NIK2d2STVUaVlBWFg0WUo2TEp5dzNMcXhSZFVoU0xhS1Nrazl1?=
 =?utf-8?B?WG1jR0pDb2NKaTBxNCt1Zk55QUNhNEx0WStnMTQrYlZDSVJUR3NuR1dhUzVC?=
 =?utf-8?B?U2NVU1c3eGhvaVcybTJXeWREUkEzL0d6VkkvWkIrcmlJZWR6OVBCQjdwTWwv?=
 =?utf-8?B?YkdGSisvNWNIOVFscXpqbURON3ZFV2xicWZQb0ZFdi9zSC8yQU9SWE9RT1Bi?=
 =?utf-8?B?QzRqRnQ5UkVudmp0a2VVTW1rSDFkaFJMLzdWWnpHTHQwbXlmZ1FTbWNKaTZm?=
 =?utf-8?B?NnJPaUVIZTRaMndHWndBYUl2NkdJUjZFZlVMYWZ1Sm1BWmRURGxBSUU5Zlo0?=
 =?utf-8?B?M0dvdUJZTGlJN210RllBU0pYZC9Fb0ZxL3podlhvbjB5VWVFLzUvS1ZKZGFC?=
 =?utf-8?B?emQrVzJzQnVtWElTSjNhMkZ6Y0s1RzVNbmhDVlN1RWhnTEdwdUdiZDVEMlV1?=
 =?utf-8?B?blIxWThhWmtESGJJRUdheTVoa29CS3RRTHNsVVZhQTY4WHhlazA5MkR4YkE4?=
 =?utf-8?B?ak5mR1krL0tKUWVJd3B2aGFFcnpwRC9CY01KSFIxZjQyMWFsZmc0aGk3VGRp?=
 =?utf-8?B?MnZCTzVxRHdTUnlNN2pqeUVaYjg2WUdhSnh1NVFNUWZLR2JreHFlSlhpR2RN?=
 =?utf-8?B?RTdaek55MG84RWVUeENZQVVaZWdDMUJOREwrYllTZHZML0lpbFZJYWUxMWpQ?=
 =?utf-8?B?dXZ1dSsyR3JhLzFCcWcwbHJwVktmeS9jZmVpSndQVStzVFFmSkdrV2lvblk3?=
 =?utf-8?B?V084ZFpOOHl6YXNnSEVvWFlxSmpRaUhxZkRSTmdLWjVJUm1kdkQ3a0t3cHFP?=
 =?utf-8?B?MWJhZUtISHhLNmViVXBjVVg4UWgyS3Nld3MrWnFNQTF2cWhlS005eXZoZ3k5?=
 =?utf-8?B?VW9oUHBQZFpwS2lWVWo1OCtJT3MrbjduSlBKczMxM2x4cEZYdWNBNTZ4dHBO?=
 =?utf-8?B?STVoWk5wNnJoMkExeWJkVTVscHgxcXVic0J3YkoxUU1BRWhyN3dIQlFrYmhU?=
 =?utf-8?B?eG8yb1M5a3U0VXh4SkRsNE9yVmd3MHZpcU93UkZJSU4vWHBsSXFLZzhDNWJa?=
 =?utf-8?B?ZUM4Wmk0b3VsOTNBNkdBS0NUQis5UzRBRXVXL0UrM0F6UE54dnZKNmdpVFE2?=
 =?utf-8?B?clVlM3ZOZVVHWWt3N2ozNjllUk5QTTJKYTl3QytNWmZiN3pIR3RUclViNUJq?=
 =?utf-8?B?YUx4ZFZOTFBXZUlReWJJb09BQkVkcUlrVWwva241Qm94dnZXWVBoaHhKSXpW?=
 =?utf-8?B?dEFlMzR0UEw3aW5iSEgrbk51NTNpQXViSFExTjdNU2E1L05vYzNIQTNmQjBX?=
 =?utf-8?B?bW5EcU1tZTBUK0ZtV2tRMUhUbUs4MjNreCtSUGVZRkdhYndRQ1ZvVHgxaWpl?=
 =?utf-8?B?OCtoelJaVGJYdUU5aTVsNVZIRUFvUW9OQW1FYndTSXRrZDF5Y3JQSzdPTDlP?=
 =?utf-8?B?Z1hCTHJRUmhtNVppQjJpcTZtM2lUZ0EzR2lYWmZ5RTVwRWRLYjhxanlRQy96?=
 =?utf-8?B?Ui9KUTliOVpNZ2JVTHR5ZHJObWtlRThFU2tOUldCaXdLcTdHVlJycUhGUGZU?=
 =?utf-8?B?OS92eTgxcG1RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SS9mQUdGR0R6V2d5b0RzVEh0b2swMXNnbWpYN1hGcFJrenhldmhGS2pSU1Ev?=
 =?utf-8?B?QjZQcHFqbnBFZkVGYkw2SjUxK2VzYmxDcWdTeXM0TmduVWxmTHQ3NjZqOStt?=
 =?utf-8?B?eDczbHZVY0NIU2txNXV0K2VJOHhSaUgxdExleWwvNXVudWc1QkI4NzJTRndx?=
 =?utf-8?B?SFBpQkV3OHNtZHFRWUl5c3AwZktUUjVWUjFHeGIxWGVmQzY5MjAxSHJWT0Rm?=
 =?utf-8?B?QUdabmRZSGhwNFBpcjJLRTJZc1YzRDVhVmU5MHZabXR3ZkNBVktNd05xK0Q2?=
 =?utf-8?B?YnEzeVZnQ3FzRFM4VmVBSUFSR1JZOEI5K2YzL3FFcENkZFV3NUhtOTNwc0M3?=
 =?utf-8?B?bzN0M05RNHUzS0k2VEtJS3EwbmV3bm4wL0xkbmczZXNzZWpaK1pHdFV4S1ds?=
 =?utf-8?B?dmQ4cUdMY2dWK2Z4NkxsOU1lZ3IxUll6KzlsM2VMTU00eTVDYVF6Y25EQXk5?=
 =?utf-8?B?dWdxaHFtNzh2MkdRQlZVaTlCOWh2RU9UTkFvSWVIY2w1UEc4Sk5kMStaZWRE?=
 =?utf-8?B?VWdsZFIwb1NkMTZGU0Vid2c3TXhCQU9tN2FCQ1EvMEtiV2hsK003eXNMZlVI?=
 =?utf-8?B?YkNRR0Jhcjc2QnQ4RzhFdjJnS1hVcUpYMjdxeVZkaUtXcGtYTWFWbFVVQ1N2?=
 =?utf-8?B?VWloUjRha05uWjNFYXNzellMUWlvR3pJeThSZkl6UXBxU0J6SzMzVy9waElE?=
 =?utf-8?B?aVo1Mmxva2tQeE1zQ3BzR1pNQzVPRUxVYm53azhlMlBIY0t1b3RrZ0xzMDl3?=
 =?utf-8?B?SHlUS1NSWEUxSmt1MHUrYmFVL01hOFNuQjJsZ2wySXM4TUdwYk1pVUFBaDIv?=
 =?utf-8?B?OW12NUltZWIrYlN2RW1JYmUyaHE3V3BmQ1RQVnMzeTJMZ2UvblU3eXlvVE5D?=
 =?utf-8?B?OUp5NW8yd0U3YnF0czFIVDRHUzU4cGVCSC9pQ05TWi9jV0FGMDRjNTJwY2ov?=
 =?utf-8?B?SytqOVd0N05nL1NTWXVtUkVuZVo3OUtEMjBnTldQN1ZBNlNxTmdxUS9mK0VO?=
 =?utf-8?B?K2dSRWtBZVJsZEVKTDArTkQweTNJWGNZTEJrRzRvV050N0UrUitJeWJVWWwy?=
 =?utf-8?B?N1p1dXdLMHByeXZyZGU1ZXJGSm5GaUd1ai91UHgwcnMySkJMVmZ3RGIzWUJx?=
 =?utf-8?B?NURBVk4zNTVIVWt2VmZjOGhNcGdaRnF3SFYzb016cjg0NDFZUW9tQ3FPZUk1?=
 =?utf-8?B?c0NTNWJqVzhnOXBSYU9GTnNUU1R5cjVCVjlNUjl1d3ZOOUxhTG41aitJZW5J?=
 =?utf-8?B?TDM4dXd1TmF4RFRPQlE1Y1VRY3N6M1dlb091SUFNeUVSRlRwTXhSeCs4Y0hO?=
 =?utf-8?B?bnl6UjlZV1I5VWYvbmR3NCs5OXZkSFBEYWxTdGd6K2daQWFmQUhGdXNUcm0w?=
 =?utf-8?B?SGc5V0NhaEVoZlp1Vkh2aUR6OGJxYXM1K3F1SGtRazFqSm93cG5pa3NoTTkz?=
 =?utf-8?B?eWdEbXVZNEdaT1pwZ0xVbW5YNi9Hdnd6RWRGa2E0cHBRNUg3U1VCZ1V5a21E?=
 =?utf-8?B?WTB2NkZpdGswWERmVGRIZ2xKOGNVTGtaUlNzbkVBVDV2bE1Ybit1UmI0VkVW?=
 =?utf-8?B?SXd6Vnl2RUxEZTdHOTBTZWdvYTR4RytYcmtPUWZ0NHlSdXVDT3hPOWZWM2dv?=
 =?utf-8?B?ZFNpeWJDdG1LN3ZJZ1BwUVN3TnF6K0RHaUdId3g1b1VoamNoa3pSRWhKc3Z4?=
 =?utf-8?B?ckxqZ01ETzNvTFN0SWR5WTVVQjZMbVFjWVkvL3NyRG9tQWpQTmtlS1p1aHhW?=
 =?utf-8?B?MUw3TVI0WW44cGlBTVZVTFJKSE9GRk5NY1VkY1d1eXhhSitRMDRaRUhLcy9G?=
 =?utf-8?B?d1pkSDZBY1VPU3VEYnc3a1ZJYTZ3eDZ3SmVDM2ZteVdWd3VDekVZcWpMREVQ?=
 =?utf-8?B?Y0RPc2Z1dTRRN1Qvc1I2MENXRmxqSkc5RzRNWGtYUlpPa1NPWmh1elk1Vk5p?=
 =?utf-8?B?THpRTTQ4alVOYm1nK1dTMnI4MWxDMGlzY0pkbDEyR2VhazRJVkYwczJ0aVhN?=
 =?utf-8?B?QzhoTnpXelVVVllpVzRXWi8zQmYrOTNweE1vWXJBYUtmK0xETHRsL2Z4Q2g0?=
 =?utf-8?B?bmdMY3loTzlYTkNCTlkvZmYwRjlEbHR1aEpRZHh1bHdTSEo2a3ZIQWNBa2V4?=
 =?utf-8?Q?oSIg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 291401d5-f361-4ba9-96df-08ddbfa1a816
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 11:05:18.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbV7OFhsbLAlxwONvHUMTLpBnDe2zJ1UCfWY2nN2ZyaxfxczeKtmc4qhmqxgVj1+DUYlcfTjqptxi0Ex/ekkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8yXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogTWFrZSBkcml2ZXIgd2FpdCBmb3IgYWxpdmUNCj5pbnRlcnJ1cHQNCj4NCj5EZWFy
IEtpcmFuLA0KPg0KPg0KPkFtIDA4LjA3LjI1IHVtIDE0OjIzIHNjaHJpZWIgSywgS2lyYW46DQo+
DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIEJsdWV0b290aDogYnRpbnRlbF9wY2ll
OiBNYWtlIGRyaXZlciB3YWl0DQo+Pj4gZm9yIGFsaXZlIGludGVycnVwdA0KPg0KPj4+IEFtIDA3
LjA3LjI1IHVtIDA1OjQ2IHNjaHJpZWIgS2lyYW4gSzoNCj4+Pj4gRmlybXdhcmUgcmFpc2VzIGFu
IGFsaXZlIGludGVycnVwdCB1cG9uIHJlY2VpdmluZyB0aGUgMHhmYzAxIChJbnRlbA0KPj4+PiBy
ZXNldCkgY29tbWFuZC4gVGhpcyBjaGFuZ2UgZml4ZXMgdGhlIGRyaXZlciB0byBwcm9wZXJseSB3
YWl0IGZvcg0KPj4+PiB0aGUgYWxpdmUgaW50ZXJydXB0Lg0KPj4+DQo+Pj4gV2hhdCBpcyB0aGUg
Y29uc2VxdWVuY2Ugb2Ygbm90IHdhaXRpbmc/DQo+Pg0KPj4gVGhpcyBpcyBhbiBhbGlnbm1lbnQg
YmV0d2VlbiBkcml2ZXIgYW5kIGZpcm13YXJlLiBJZiBkcml2ZXIgZG9lc27igJl0DQo+PiB3YWl0
IGZvciBhbGl2ZSBpbnRlcnJ1cHQsIHRoZW4gdGhlcmUgaXMgY2hhbmNlIG9mIHN0YWNrIHNlbmRp
bmcNCj4+IGNvbW1hbmRzIGJlZm9yZSB0aGUgZmlybXdhcmUgaXMgcmVhZHkgdG8gYWNjZXB0Lg0K
Pg0KPlRoYW5rIHlvdSBmb3IgZWxhYm9yYXRpbmcuIEl04oCZZCBiZSBncmVhdCBpZiB5b3UgYWRk
ZWQgaXQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlLA0KPndoZW4geW91IHJlc2VuZC4NCkFjay4NCg0K
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTYWkgVGVqYSBBbHV2YWxhIDxhbHV2YWxhLnNhaS50ZWph
QGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5j
b20+DQo+Pj4+IEZpeGVzOiAwNWMyMDBjOGYwMjkgKCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTog
QWRkIGhhbmRzaGFrZSBiZXR3ZWVuDQo+Pj4+IGRyaXZlciBhbmQgZmlybXdhcmUiKQ0KPg0KPkkg
d291bGQgYWxzbyBwdXQgdGhlIEZpeGVzOiB0YWcgYWJvdmUgdGhlIFNpZ25lZC1vZmYtYnkgbGlu
ZS4NCkFjay4NCg0KPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRl
bF9wY2llLmMgfCAyNyArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+Pj4gICAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+Pj4gYi9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4+PiBpbmRleCAxMTEzYTYzMTBiZDAuLmY4
OTNhZDZmYzg3YSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9w
Y2llLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+Pj4g
QEAgLTk0NywxMSArOTQ3LDEzIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9tc2l4X2dwMF9o
YW5kbGVyKHN0cnVjdA0KPmJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKQ0KPj4+PiAgICAJY2FzZSBC
VElOVEVMX1BDSUVfSU5URUxfSENJX1JFU0VUMToNCj4+Pj4gICAgCQlpZiAoYnRpbnRlbF9wY2ll
X2luX29wKGRhdGEpKSB7DQo+Pj4+ICAgIAkJCXN1Ym1pdF9yeCA9IHRydWU7DQo+Pj4+ICsJCQlz
aWduYWxfd2FpdHEgPSB0cnVlOw0KPj4+PiAgICAJCQlicmVhazsNCj4+Pj4gICAgCQl9DQo+Pj4+
DQo+Pj4+ICAgIAkJaWYgKGJ0aW50ZWxfcGNpZV9pbl9pbWwoZGF0YSkpIHsNCj4+Pj4gICAgCQkJ
c3VibWl0X3J4ID0gdHJ1ZTsNCj4+Pj4gKwkJCXNpZ25hbF93YWl0cSA9IHRydWU7DQo+Pj4+ICAg
IAkJCWRhdGEtPmFsaXZlX2ludHJfY3R4dCA9IEJUSU5URUxfUENJRV9GV19ETDsNCj4+Pj4gICAg
CQkJYnJlYWs7DQo+Pj4+ICAgIAkJfQ0KPj4+PiBAQCAtMTk4NSw4ICsxOTg3LDkgQEAgc3RhdGlj
IGludCBidGludGVsX3BjaWVfc2VuZF9mcmFtZShzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2LA0KPj4+
PiAgICAJCQlpZiAob3Bjb2RlID09IDB4ZmMwMSkNCj4+Pj4gICAgCQkJCWJ0aW50ZWxfcGNpZV9p
bmplY3RfY21kX2NvbXBsZXRlKGhkZXYsDQo+b3Bjb2RlKTsNCj4+Pj4gICAgCQl9DQo+Pj4+IC0J
CS8qIEZpcm13YXJlIHJhaXNlcyBhbGl2ZSBpbnRlcnJ1cHQgb24gSENJX09QX1JFU0VUICovDQo+
Pj4+IC0JCWlmIChvcGNvZGUgPT0gSENJX09QX1JFU0VUKQ0KPj4+PiArDQo+Pj4+ICsJCS8qIEZp
cm13YXJlIHJhaXNlcyBhbGl2ZSBpbnRlcnJ1cHQgb24gSENJX09QX1JFU0VUIG9yDQo+MHhmYzAx
Ki8NCj4+Pg0KPj4+IEEgc3BhY2UgaXMgbWlzc2luZyBiZWZvcmUgKi8uDQo+PiBBY2suDQo+Pg0K
Pj4+PiArCQlpZiAob3Bjb2RlID09IEhDSV9PUF9SRVNFVCB8fCBvcGNvZGUgPT0gMHhmYzAxKQ0K
Pj4+DQo+Pj4gUGxlYXNlIGRlZmluZSBhIG1hY3JvIGZvciB0aGUgbWFnaWMgbnVtYmVyLg0KPj4N
Cj4+IFRoaXMgaXMgdmVuZG9yIHNwZWNpZmljIG9wY29kZSBhbmQgaXMgYWxzbyBzaGFyZWQgYWNy
b3NzIGJ0aW50ZWwuYywNCj4+IGJ0dXNiLmMgYW5kIGhjaV9pbnRlbC5jLiBXb3VsZCBpdCBiZSBh
Y2NlcHRhYmxlIHRvIHN1Ym1pdCBhIHNlcGFyYXRlDQo+PiBwYXRjaCBmb3IgdGhpcyBjaGFuZ2Ug
YWxvbmU/DQo+DQo+U3VyZS4gRmluZSBieSBtZS4NClRoYW5rcy4NCg0KPg0KPj4+PiAgICAJCQlk
YXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxzZTsNCj4+Pj4NCj4+Pj4gICAgCQloZGV2LT5zdGF0LmNt
ZF90eCsrOw0KPj4+PiBAQCAtMjAyNSwxNyArMjAyOCwxNSBAQCBzdGF0aWMgaW50IGJ0aW50ZWxf
cGNpZV9zZW5kX2ZyYW1lKHN0cnVjdA0KPmhjaV9kZXYgKmhkZXYsDQo+Pj4+ICAgIAkJYnRfZGV2
X2RiZyhkYXRhLT5oZGV2LCAic2VudCBjbWQ6IDB4JTQuNHggYWxpdmUgY29udGV4dA0KPmNoYW5n
ZWQ6ICVzICAtPiAgJXMiLA0KPj4+PiAgICAJCQkgICBvcGNvZGUsIGJ0aW50ZWxfcGNpZV9hbGl2
ZWN0eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwNCj4+Pj4gICAgCQkJICAgYnRpbnRlbF9wY2llX2Fs
aXZlY3R4dF9zdGF0ZTJzdHIoZGF0YSAtDQo+YWxpdmVfaW50cl9jdHh0KSk7DQo+Pj4+IC0JCWlm
IChvcGNvZGUgPT0gSENJX09QX1JFU0VUKSB7DQo+Pj4+IC0JCQlyZXQgPSB3YWl0X2V2ZW50X3Rp
bWVvdXQoZGF0YS0+Z3AwX3dhaXRfcSwNCj4+Pj4gLQkJCQkJCSBkYXRhLT5ncDBfcmVjZWl2ZWQs
DQo+Pj4+IC0NCj5tc2Vjc190b19qaWZmaWVzKEJUSU5URUxfREVGQVVMVF9JTlRSX1RJTUVPVVRf
TVMpKTsNCj4+Pj4gLQkJCWlmICghcmV0KSB7DQo+Pj4+IC0JCQkJaGRldi0+c3RhdC5lcnJfdHgr
KzsNCj4+Pj4gLQkJCQlidF9kZXZfZXJyKGhkZXYsICJObyBhbGl2ZSBpbnRlcnJ1cHQgcmVjZWl2
ZWQNCj5mb3IgJXMiLA0KPj4+PiAtCQkJCQkgICBidGludGVsX3BjaWVfYWxpdmVjdHh0X3N0YXRl
MnN0cihkYXRhLQ0KPj5hbGl2ZV9pbnRyX2N0eHQpKTsNCj4+Pj4gLQkJCQlyZXQgPSAtRVRJTUU7
DQo+Pj4+IC0JCQkJZ290byBleGl0X2Vycm9yOw0KPj4+PiAtCQkJfQ0KPj4+PiArCQlyZXQgPSB3
YWl0X2V2ZW50X3RpbWVvdXQoZGF0YS0+Z3AwX3dhaXRfcSwNCj4+Pj4gKwkJCQkJIGRhdGEtPmdw
MF9yZWNlaXZlZCwNCj4+Pj4gKw0KPm1zZWNzX3RvX2ppZmZpZXMoQlRJTlRFTF9ERUZBVUxUX0lO
VFJfVElNRU9VVF9NUykpOw0KPj4+PiArCQlpZiAoIXJldCkgew0KPj4+PiArCQkJaGRldi0+c3Rh
dC5lcnJfdHgrKzsNCj4+Pj4gKwkJCWJ0X2Rldl9lcnIoaGRldiwgIk5vIGFsaXZlIGludGVycnVw
dCByZWNlaXZlZCBmb3IgJXMiLA0KPj4+PiArCQkJCSAgIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRf
c3RhdGUyc3RyKGRhdGEtDQo+PmFsaXZlX2ludHJfY3R4dCkpOw0KPj4+DQo+Pj4gSW4gYSBmb2xs
b3ctdXAgcGF0Y2gsIHRoZSBsb2cgbWVzc2FnZSBjb3VsZCBiZSBpbXByb3ZlZCBieSBhbHNvDQo+
Pj4gYWRkaW5nIHRoZSB0aW1lb3V0IHZhbHVlIHRvIGl0Lg0KPj4gQWNrLg0KPj4NCj4+Pj4gKwkJ
CXJldCA9IC1FVElNRTsNCj4+Pj4gKwkJCWdvdG8gZXhpdF9lcnJvcjsNCj4+Pj4gICAgCQl9DQo+
Pj4+ICAgIAl9DQo+Pj4+ICAgIAloZGV2LT5zdGF0LmJ5dGVfdHggKz0gc2tiLT5sZW47DQo+DQo+
S2luZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0KUmVnYXJkcywNCktpcmFuDQoNCg==
