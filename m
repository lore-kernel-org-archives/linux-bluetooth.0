Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D13909A8;
	Sun, 27 Sep 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522286; cv=fail; b=YMacWPUc8dfeS0QHwe7UXfKsAHbuDU7a78EDzb81ROrcjrowmtuA47ZzuYLuuFOCUZFqYkMtnhlQRS7TuUb5CX4RA/uz83IeEmx1lxnzhNTEY9V/eJBbwXG64dn6lYD2zwo2/SRUkLuTbCOxzmcFIFnJ3CR2Eih+P1Wqd9ebbQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522286; c=relaxed/simple;
	bh=+xjYzA4BsEY96Ooj0ZVmoPVjO4XgzuuETDHzkwVYcV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1RMXq0qotoNI3tHk3z++580Z2hgCaN1++EnROY0ulYGtTYcodKuas1hxXrxZD5mh4K3CETO7gQOjv78hY57VcamueFfgIchLImxH8Oi103W+QN8AAgXtBbniYlurw6/5gPD+KPKF5yzBEhlBOu+yn98hEJdbg6KjWgMa1DGe+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8wyGq4m; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8wyGq4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790522284; x=1822058284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+xjYzA4BsEY96Ooj0ZVmoPVjO4XgzuuETDHzkwVYcV0=;
  b=P8wyGq4mckC/VJ0uvZAQ93s6ZvSgSr9da/XAepCSNGMnE8h5Omt7GerI
   0FkvU3hi0UXcxWT2MNuwpNRVlbD3c9s8fsDN7WFXnDTSI+s0TC6FwnjQM
   Zjcgtdeey8kUjN5zZ/+xLQNLmSXIlhGIMk5W9UUBDUPYdOayyL8s3+tqW
   iXpC+SYmtiOFeiK1u1sNqe/i5dM9P3g08gkc+DIgZ3dFbtfyuacka9TY2
   1pVLVJVx3Kt462Rnvkpe2QJ/lPqwU3DmlxB5e/qyn1jfQ5I+xEe46/MDj
   od/eg/Fw1chILUZ9cKZgcpo6AnbQisB2trN+hehiMCwkLB1hzlXFLDDuV
   w==;
X-CSE-ConnectionGUID: 2Z7x6rXTQZWKW6dm6hzLHg==
X-CSE-MsgGUID: /UJeaD07Q1i9OHwTsF71Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="107616199"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="107616199"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 08:18:04 -0700
X-CSE-ConnectionGUID: exwuqVQ5T9ypy2S2e+sw6w==
X-CSE-MsgGUID: ETiG0WmpTMGZ9psU7Ii35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="274951258"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 08:18:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 08:18:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 08:18:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 08:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVL+trVscMiESelLF7fa4fjT2m/dR+IBO/42hL57va/pa4t0Hv9qWt4pS/J2FEHygg/kuabzSKv8eLNafqt5XLMw0jFT8ssIWsBa9nvUsz9XWbJFggRGu4cCj6g12Qql/QRH9e8wMfgwm0ds1ZiyXD+ew6V9GiZYFiZKqLLhh8eaghTYDUF//BJ1wi3Kj+1SyzgbE5sb06u2Aj/Nbe6LyqOOPICnl9L1bDDyoh72lhgUQdAHph8beJ69qNTTyX+34XlPH4+EVjQ//NtHJD49elaUfsYfe0on9MumPbY5CgEzh5nmfuAdLA/ry93rotoEBrFMRHgl0+I76F/Nc79E7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xjYzA4BsEY96Ooj0ZVmoPVjO4XgzuuETDHzkwVYcV0=;
 b=A+IPp8RIq0NX11nR9X0FNDiffMTi9EY6aNGGRJKdonIvCm2/8xRRnX6kna7vKR6gz4U2tTJ5E0NrzqLIr3Udor9YP7Me1B+bZFaKs4r1fReJPqiDH1byC+EPOiahHdfY4+QIiTB7hR0XP55Y9W2XrIwLQx3WKvKmk9ZobxzFWY2zpf1YNB/kTrd1Llo6ihVxPYX8AOlJ0/ugLdQPBkD3dd7v+j6w+FmJZSxga1ZriFL/r6y1xclyFCjYcEE5clNNs0Ibynt486tNgCpT5XGpQRe18JcBddmu3xZyo8qfFqI2sBT09r/onuvAmgf47x2nt5AbHXP8rre8XqP/waUJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by FT1PR11MB124400.namprd11.prod.outlook.com (2603:10b6:170:c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 15:17:56 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 15:17:56 +0000
From: Ravindra <ravindra@intel.com>
To: Sergey Lebedev <lsa.uz@pm.me>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
CC: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ferenc Lengyel
	<dev@lengyelf.eu>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "K,
 Kiran" <kiran.k@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Chambarakatta, Mahalingeshwara"
	<mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and
 S4
Thread-Topic: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3
 and S4
Thread-Index: AQHdQFegX4pPZiOCjE6klieJL/7w1LbGkqIAgAAlbACAEDeXsIAAOxCAgAVJV3CAAby+AIACbYBwgABsPICAAZqPIA==
Date: Sun, 27 Sep 2026 15:17:55 +0000
Message-ID: <IA1PR11MB786973526A152F6D76C114A7DA8E2@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260909123416.71919-1-lsa.uz@pm.me>
 <20260909123416.71919-3-lsa.uz@pm.me>
 <CABBYNZJfH4F1-Hy1eiOrzuU1nzTbMbue3EqMT5gfHs60wFw9QA@mail.gmail.com>
 <20260909204654.91282-1-lsa.uz@pm.me>
 <IA1PR11MB786999FA8FCC7E7B8752F7A4DA852@IA1PR11MB7869.namprd11.prod.outlook.com>
 <20260920075720.7004-1-lsa.uz@pm.me>
 <IA1PR11MB7869C1A9A0630F8C8C856B73DA822@IA1PR11MB7869.namprd11.prod.outlook.com>
 <20260924191301.39161-1-lsa.uz@pm.me>
 <IA1PR11MB786927FFF15A4863BB96AB4FDA8F2@IA1PR11MB7869.namprd11.prod.outlook.com>
 <20260926144451.17188-1-lsa.uz@pm.me>
In-Reply-To: <20260926144451.17188-1-lsa.uz@pm.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|FT1PR11MB124400:EE_
x-ms-office365-filtering-correlation-id: 60023ebc-2e7f-4de0-df1c-08df1caa81fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: wjGXvj66b/pqYdocVo7UYGWVh9NbmAAPMCLOi2m6QPZOMWnfqvpPcMIQGUfSjr8qFWSDvJK2XmGPJKYWN1VTkNm/ELDDIpLO9GFojlqAfe9pjeEPDds9kheZLyLmEyRbcjdFrxjx9mL9p147F/8y2UiX15Q+FfxG3o46whYnzeZkgLkTdolKchXxJu6votceBUEYtAE1xOSK2OJnXZlghBD9M4tqkXPTuxTmnZgrUjAM+VWRExvQ2LpmNgisMLy+0hq3hdlvz8d6j56pkeYIKwywcBXFZzzXWpZ+foMk3NR15ge6WcjWubxzensYLEC2ngXQziZURIvNd22atIcgSaytENx57OhXhCxnN/QyMLVGKW5QWl08jWgrrhKqBJjEk0qMH7I1qa3Ls3rV3d0Q9tW6TXB9FUvcnsB+9p9FigCxGgeBy2NcneZU594+IckMVdsI8AIWkaxhgEjLSdrKoCL94W4qifeRWP82FTzDDPk8Z0vsBp3uP791N+jisJOZN0VmsKOn2EtO7uBemffRoGfJzy9mVqUg140H0g6cVVvk7z9SptQ+sbYoPSqpyhxXrfLhtnQA1lZWNvcDZ0mH6Q1kfRcauEqHq11FZlHKEn7SyCMiuWuDvZ4KWuYieWMjTpNzMH9sGQSAX0kecqQf5XNd5gQaXuLcEEU1qav1Xh8HIyJPyXRgQlLxu657L7oMM5oeuJx2Y58de/gaFbJNybk7NPMgejhymwktBJVa0zw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlYL0JiVFhsb2NLZ3kyckErRnExWFppRzFoT2Q1cFdaaHphT0tGa2w2UG1Q?=
 =?utf-8?B?dmUvbVc1YUphTVJPUHhyT3gvMlk3YXFnS2Flcmk5RFExemxlYUdKRklXZjJ0?=
 =?utf-8?B?RzJUSUFEU3R6dGVsMmNYRjNpMVB4UTRxTk5pa2VhM2E1RW0zTDhCZEtpRDlG?=
 =?utf-8?B?Qk14QUx2elNoQjMxVkY4dnpxYXI0dWorYW1QQkIwVm8xSlBEOGUwT1VXSFpO?=
 =?utf-8?B?Z1VhMGM2TUU5S2xrTDBDNC9CUEFEZEhjZWQ0eGM2UElUaUtBUjR0UUtRcFJB?=
 =?utf-8?B?OVp0K2RKazg0RHlRT0RMcXcyUUQwZmNBM3A5SE90ZVRvSDc1c1FwZGdXK1RQ?=
 =?utf-8?B?YlMwL1Q0bE5oR0pTTmRYWEhIb1U4Ym9mVmFuTUxaRmFaYmxNRjdOOVhWaG9x?=
 =?utf-8?B?ZU1OMk8rLzZJb1NWNGdWR3VFUEVNZWpKQjdwakV1WERuRlI1NXlBYmx2ZzNp?=
 =?utf-8?B?ZGNYQWdiQmU2L0w5T3E0cnVPWGJHRUtyWEVyN2szMWJaZ1NzZERta0p1Rlhs?=
 =?utf-8?B?am9qNUNQemxvZTR6MU1reG9telFRS0RhL3ViYlBGRHh3QzBibWxVQnBKQ0g1?=
 =?utf-8?B?dmw1ekV3b29hUzlVTWVmbEEvL01zQ2Q4c3dDdnZXb1FUZ3k0dGZ4N2h4bXB1?=
 =?utf-8?B?MVVqdnY2UytFQ0o5d25IZ1R2Qkh3dmlmbER3R1pxTEJYaWVGeGI5Y0liVXRx?=
 =?utf-8?B?R1JvYlE1WWJTWVY0Tzh5TTUrTm9jYXNRMWl5NmVXdkNFU3E4dlFRV2FzSFhr?=
 =?utf-8?B?RkZpUXpMWlFUOUxhTFUrU2pEU3lyNXVwUFlHUVh6ZWs2TldoQXQ2eDc3bHRE?=
 =?utf-8?B?VjJuVi9WZlNpeWMyc042ZnRzZm43QlY5L0ZxaFFobDk3NlVrR3RIb20vdFZh?=
 =?utf-8?B?cHQxNFVMbFBEdUl5UHVoUFJEYXc2UkVoS3RueWgyRGFJY0dJbXBSaWltdmdK?=
 =?utf-8?B?TEpHVFNqci85Qm1YTnloU2h5eXZKUm1YeGQ4UEdNdTcxa04wVFZEZ0Jhcyto?=
 =?utf-8?B?UW9oSnpRN281T3loK0hNdlFMMlhrbXVwdGxEbXVnSFFVbnVKMFZISzZRekdz?=
 =?utf-8?B?alRLT0dLanpCY2hSVkltMktwa2ZsZ1BuaUZDY0hhR1FKVFRjc2h1cUFiUFk4?=
 =?utf-8?B?UlMwK21JSU5rN2dwTW5jK2U2NXJyVDgwZ0xmQmRDdWVVait2c3hpWS9mNjRz?=
 =?utf-8?B?dFVyRm5EL0V3MDBTRzNuNmJQQjlraFl1SEZFTUVjeWxBaWxHMVJVdlh0QVdQ?=
 =?utf-8?B?T0ozRDVsaTVEc1BQcjBZa2tEbTlnM3dlQ1Rldks2WjB3SGl3TzJWQmVWV1M1?=
 =?utf-8?B?NEw0aGZCWUdNRzNCV1czc0F2Uk5jdVNiZ1R6elY1NEc3QjlRMStsalYrWUJS?=
 =?utf-8?B?TnlTSmwyV2xEMXFGN29SK3dPQ053QmMweWtTM2g4VE0vSERvM1o4YzlmNnFH?=
 =?utf-8?B?bUs2TVpoaHNWdkxMRW1sYjhBZ3VkU2pnRmxjcFR5aXZTYkgxYUNGRmk0b2w4?=
 =?utf-8?B?emFkZjY3eHB1VmpXd05sdndxYjI2WTd6TUlXemJ6QjJHU0lGTDhqSGV2L0tM?=
 =?utf-8?B?R05YUG9HRk52ajhheWNjUmlySVkzaGYyVGhYQ1ZuL2lwajdBWnI1K1dEYlp3?=
 =?utf-8?B?Q3BwUFIwK2FybXMramtyMXlVUWprM2JRMmlRK3YrOW5oOVg2SUMrY2E5S2dD?=
 =?utf-8?B?ZXJmc3E1b0FhMnZyUWJKOVFBNUFyZ2VMT1k1ekJzVjhXc1NuZFp3V2paNy96?=
 =?utf-8?B?VjVlVjE3VkZnNGhSOVRhYnBhTS80SzJlNTUxM3V5TldKaTBldXdxYWhyNThD?=
 =?utf-8?B?WUZyUlVOVmtOek1MTWU1NndkQU5iWUxiRVlqZkFNL3NKZjNTRUdmclEvV0tk?=
 =?utf-8?B?a2JLWDRjbWZLTzhSUDUzQkYySldCcEdMdXRWZGRSTjZ5OXV6a1NsYnQ3bkUx?=
 =?utf-8?B?bFNIYTVJOXJyTy9vSldkV09ISGZucm1xODN2Q0dUUjl1c0tsZGVsR3hjbCtU?=
 =?utf-8?B?WUVTUUxxb2VwMU1LQUFSeXBoTytxTVNmR2R6NEc0cCtpZ3JUaDk2dzVheDRz?=
 =?utf-8?B?bm9KQnRtcG55U0NGZXViOGZsMHArWmU5eFZKa0xzTW95b3VxVjIxc014VlBC?=
 =?utf-8?B?MEF2cGpIbklva0E3MmEvQ3E3T3l6RVRkZzQyZnZDWkpNSUcrbXVJdWNiZ0Rw?=
 =?utf-8?B?MnBKd2h4VENWYTBoZmN0T09KS2xTYWJLVVJzZDMxTmJzb1ZhTUNiVHZremEz?=
 =?utf-8?B?R3pyakdjbC9Vd3c0S0diZXRlWG11SVF1Q01EVUZ5c0drdFQ2cUxoeHdYcVBJ?=
 =?utf-8?Q?CUOXXnIjeidDtHRyfi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AVzyBPUmvg74RCf3605AV0b65zfHTPe0tIasYWrDkeTQiukiAT/czpH4FXDNb/lzwyeA+C8Nzm8AebGY8i/BpDPIq94tukZLxqwgf1VUp91hQcep18vI3o3NEzKLCiT6PN5I0eQmOp6ZbZfsnOlBVqy68A02lUQMpij3Pyzyl8lFITxSoubRjPDT3BC+wvSVa7rignhehygce6Q5QT/GPPR9+PZ3IehCS/bUWnWUQVETaoM9n9ucstyDy6gFJvhcS1/c1zjvoN4rNw+ltkQPgCy6S6DvCwsurzbpqH9UWTuKOG69MrdCLqd3RARsB4CkieP1RgRvQPfrI+Z61cf7uA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60023ebc-2e7f-4de0-df1c-08df1caa81fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2026 15:17:55.9952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LE6zVsbumISNLh6aqpi7j06IlHQb0puIyHXxt7dBR0bCW45vEl1KaJsKmjcLsGrSXQGkpaWup4hCWEckw9Di1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB124400
X-OriginatorOrg: intel.com

SGkgU2VyZ2V5LA0KDQpUaGFuayB5b3UgZm9yIHJ1bm5pbmcgdGhlIGZ1bGwgYmVuY2ggYW5kIGZv
ciBjb25maXJtaW5nIHRoZSByZXN1bHRzLg0KDQpUaGUgYWRkaXRpb25hbCBEMyBicmFuY2ggd2Fz
IGludGVuZGVkIHRvIGNvdmVyIGV4YWN0bHkgdGhlIHJlc3VtZSBob2xlIHlvdQ0KaWRlbnRpZmll
ZDogd2hlbiB0aGUgaGFuZGxlcidzIEQwIGNhc2UgcnVucyBiZWZvcmUgdGhlIGNvbnRyb2xsZXIg
cmVhY2hlcyBEMywNCnRoZSBjb250ZXh0IGNhbiByZW1haW4gRDAgYW5kIHRoZSByZXN1bWUgZ3Vh
cmQgY2FuIGluY29ycmVjdGx5IHNraXAgcmUtYXJtaW5nDQpSWC4gUmVjb3JkaW5nIEQzIGZyb20g
dGhlIHZlcmlmaWVkIGhhcmR3YXJlIHN0YXRlIGVuc3VyZXMgdGhlIG5leHQgRDANCnRyYW5zaXRp
b24gcGVyZm9ybXMgdGhlIHJlcXVpcmVkIHJlLWFybS4NCg0KWW91ciByZXN1bHRzIGFsc28gY29u
ZmlybSB0aGUgb3RoZXIgcGFydHMgb2YgcGF0Y2ggMzogbWlzc2VkIEdQMCBoYW5kbGluZywNCnRo
ZSBEMy10by1EMCBmYWxsYmFjaywgcmV0cnktZmxhZyByZXNldCwgYW5kIHByZXNlcnZhdGlvbiBv
ZiB0aGUgbm9ybWFsIFM0DQpmcmVlemUvdGhhdyBhbmQgcmVzdG9yZSBmbG93cy4gSXQgaXMgZ29v
ZCB0byBzZWUgSENJIHJlY292ZXIgc3VjY2Vzc2Z1bGx5IGluDQphbGwgb2YgdGhvc2UgY2FzZXMu
DQoNClRoYW5rcyBhZ2FpbiBmb3IgdGhlIGRldGFpbGVkIHRlc3RpbmcuIEknbGwgaW5jbHVkZSB5
b3VyIGBUZXN0ZWQtYnk6YCBhbmQNCmBSZXZpZXdlZC1ieTpgIHRhZ3MgZm9yIHBhdGNoIDQuDQoN
CkJlc3QgUmVnYXJkcywNClJhdmluZHJhDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIEJs
dWV0b290aDogYnRpbnRlbF9wY2llOiBmaXggUE0gZmxvdyBmb3IgUzBpeCwgUzMgYW5kDQo+IFM0
DQo+IA0KPiBSYXZpbmRyYSwNCj4gDQo+IFRoYW5rIHlvdSAtIGFsbCBmb3VyIGFyZSBpbi4gSSBj
aGVja2VkIHRoZW0gaW4gdGhlIGNvZGUsIHdpdGggdjQgYXBwbGllZCBmcm9tDQo+IGxvcmUgb250
byA2NzFkNTY2ZDNjM2IgYW5kIG9udG8gZTQwZWRmYTA0LCB3aGVyZSBpdCBsYW5kcyBpZGVudGlj
YWxseS4NCj4gDQo+IFlvdXIgRDMgYnJhbmNoIGFsc28gY2xvc2VzIGEgaG9sZSBpbiB3aGF0IEkg
cHJvcG9zZWQ6IGlmIHRoZSBoYW5kbGVyJ3MgRDAgY2FzZQ0KPiBydW5zIGJlZm9yZSB0aGUgY29u
dHJvbGxlciByZWFjaGVzIEQzLCBpdCBicmVha3Mgd2l0aG91dCByZWNvcmRpbmcgRDMsIHRoZQ0K
PiBjb250ZXh0IHN0YXlzIEQwLCBhbmQgdGhlIGd1YXJkIGluIHRoZSBEMCBicmFuY2ggdGhlbiBz
a2lwcyB0aGUgcmUtYXJtIG9uDQo+IHJlc3VtZS4gVGhlIGJlbmNoIHNob3dzIGl0IHdpdGggYW5k
IHdpdGhvdXQgeW91ciBicmFuY2guDQo+IA0KPiBCZW5jaDogU3VyZmFjZSBQcm8gMTEsIEJFMjAx
IDgwODY6YTg3NiwgdGhlIGRyaXZlciBhdCBibHVldG9vdGgtbmV4dA0KPiBlNDBlZGZhMDQgYWdh
aW5zdCB0aGUgc2FtZSBwbHVzIHY0LCBvbmUgaW5zdHJ1bWVudGVkIGJ1aWxkIGVhY2guICJIQ0kg
b2siDQo+IGlzIFJlYWQgTG9jYWwgVmVyc2lvbiByZXR1cm5pbmcgc3RhdHVzIDAgYWZ0ZXIgdGhl
IGN5Y2xlLg0KPiANCj4gICBmaXJzdCBncDAgb24gRDMgZW50cnkgZHJvcHBlZCwgYXMgYSBtaXNz
ZWQgaW50ZXJydXB0ICgxLzQncyBjYXNlKQ0KPiAgICAgc3RvY2sgIHRpbWVvdXRzIGF0IHJldHJp
ZXMgMCwgMSBhbmQgMiwgLUVCVVNZLCBzdXNwZW5kIGFib3J0ZWQsDQo+ICAgICAgICAgICAgSENJ
IGZhaWxzDQo+ICAgICB2NCAgICAgb25lIHRpbWVvdXQsIEQzIHJlY29yZGVkIGZyb20gdGhlIHJl
Z2lzdGVyLCBIQ0kgb2sgKDIgb2YgMikNCj4gDQo+ICAgaGFuZGxlcidzIEQwIGNhc2UgZm9yY2Vk
IHRvIGJyZWFrIG9uIHN1c3BlbmQNCj4gICAgIHY0IHdpdGhvdXQgdGhlIEQzIGJyYW5jaCAgIHJl
c3VtZSBza2lwcyB0aGUgcmUtYXJtLCBIQ0kgZmFpbHMNCj4gICAgIHY0ICAgICAgICAgICAgICAg
ICAgICAgICAgIEQzIHJlY29yZGVkLCBoYW5kbGVyIHJlLWFybXMgb24gcmVzdW1lLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgSENJIG9rICgyIG9mIDIpDQo+IA0KPiAgIGhhbmRs
ZXIncyBEMyBjYXNlIGZvcmNlZCB0byBicmVhayBvbiByZXN1bWUNCj4gICAgIHN0b2NrICBzdWNj
ZXNzIHJlcG9ydGVkIHdpdGggY3R4dCA2IChEMyksIHRoZW4gaHcgZXhjZXB0aW9uLCBGTFIsDQo+
ICAgICAgICAgICAgMHgwYzAxIHR4IHRpbWVvdXQNCj4gICAgIHY0ICAgICByZS1hcm1lZCB0byBj
dHh0IDUgKEQwKSBlaXRoZXIgd2F5IHRoZSByYWNlIGZhbGxzOiBoYW5kbGVyDQo+ICAgICAgICAg
ICAgYmVmb3JlIHRoZSB3YWl0LCAyLjIgbXM7IGR1cmluZyBpdCwgMjA4IG1zOyBIQ0kgb2sgKDIg
b2YgMikNCj4gDQo+ICAgc3RhdGUgY2hlY2sgZm9yY2VkIHRvIGZhaWwgdGhyZWUgdGltZXMgb24g
c3VzcGVuZA0KPiAgICAgdjQgICAgIHdhaXRzPTMsIG5vbmUgc2tpcHBlZCwgNDEzIG1zLCAtRUJV
U1kgYXMgZm9yY2VkDQo+IA0KPiAgIHBsYWluIHMyaWRsZQ0KPiAgICAgdjQgICAgIEQzIGluIDEu
NS0xLjYgbXMsIEQwIGluIDEuNS0xLjcgbXMsIEhDSSBvayAoMyBvZiAzKQ0KPiANCj4gICBTNCwg
aW4gdGhlIGtlcm5lbCdzIHN1c3BlbmQgYW5kIHRlc3RfcmVzdW1lIGhpYmVybmF0aW9uIG1vZGVz
DQo+ICAgICBzdG9jayAgLnRoYXcgZ29lcyB0aHJvdWdoIEZMUg0KPiAgICAgdjQgICAgIC5mcmVl
emU6IEQzX0NPTEQgaW4gMS41LTEuOCBtcw0KPiAgICAgICAgICAgIC50aGF3OiBEMCBpbiAxLjYg
bXMsIEhDSSBvayBhZnRlciAoMiBvZiAyKQ0KPiAgICAgICAgICAgIC5yZXN0b3JlOiBGTFIsIGZp
cm13YXJlIHJlbG9hZGVkLCBIQ0kgb2sgKDIgb2YgMikNCj4gDQo+IFM0IHJhbiBvbiB0aGUgYmVu
Y2gga2VybmVsLCBzaW5jZSB0aGUgZGlzdHJpYnV0aW9uIGtlcm5lbCByZWZ1c2VzIGl0IHVuZGVy
DQo+IFNlY3VyZSBCb290IGxvY2tkb3duLCBhbmQgd2l0aG91dCBjdXR0aW5nIHBvd2VyLCBzbyAu
cG93ZXJvZmYgaXMgbm90DQo+IGNvdmVyZWQuIFRoZSBmaXJtd2FyZSBvZmZlcnMgbm8gUzMuDQo+
IA0KPiBBZnRlciB0aGUgRkxSIGluIC5yZXN0b3JlIHRoZSBsb2cgc2F5cyAiQlQgcmVwcm9iZSBm
YWlsZWQiLCBvbiBzdG9jayB0b287IHRoZQ0KPiBkZXZpY2UgcHJvYmVzIGFnYWluIGFib3V0IGEg
c2Vjb25kIGxhdGVyIGFuZCB3b3Jrcy4NCj4gDQo+IFRlc3RlZC1ieSBmb3IgNC80IGZvbGxvd3Mg
aW4gaXRzIG93biB0aHJlYWQuDQo+IA0KPiBTZXJnZXkNCg0K
