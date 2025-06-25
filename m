Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D933594E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839605; cv=fail; b=gsMSKfGOE4sbHDa1HxNu5OXnXoGBjFfJ5XosmAmzwkyaUJOr3jAXlcxdoniqwOGQ3w+kBA62lvzy4CwoiFCZB8u/jiylbhPxQpSm9mSmsbYcZQU08TEa4A9cFl6zvMWdJiSmn5mhdBzeKycYp0kIhuz9f2TEnPio2c6Il/3Rmog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839605; c=relaxed/simple;
	bh=zfBREle4UIU7VdB2eG6QaMPSp98vl4DyWf3uCbn5INs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5lPckxJJe7ce3p3eQNs93oI6amGgveld5yNTMsHOHNi9vSdY6SQJC8ZEhB+pqnk93Oqp6q/ho2rW+p1L0RiskmLarUd9z1F+zZsDwDz++okZEjPyNSab0HjgiYUpOcEmR4emk5DkmuuDIwWP038FzDukyIzfQMmW+/VCmJ9Zuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTWOamZ4; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTWOamZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750839604; x=1782375604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zfBREle4UIU7VdB2eG6QaMPSp98vl4DyWf3uCbn5INs=;
  b=FTWOamZ4PyiZfcGVtWRHqG4imFb6KOx0M3wpyvxY+E7INuT3TMnxiXrP
   bJV9qEgE+H1M3h8QO9WsmUK8x00O54ZK1EiuRodhNOTZMZFD4oyrTiAeU
   FrxKE7NAFsU8gpbFbdiTTjhgY45ef8/wRaiZD6LTNzrM2vtkQsqOfTVEu
   RlpFmFHY7Mmyq2o5Afn/trNq1f0ct1lwIyQxlW/IewBTvXKaVt3tPo8Xw
   ++iXj2SF9gYwhbovaqvfnbmFgMbB52R2AdgKOrPnvLipOutRmm43P/zQM
   5Jf4dSRgnbf1C8c8dvU+p1R8I4c1cIvw+bnU5X3gB5dLV/w5D+D6k6/3R
   w==;
X-CSE-ConnectionGUID: eFAGOHR7TzSNbPPAzRnW9A==
X-CSE-MsgGUID: S78Yja7VTxKHU1qrxBmVpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52817510"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52817510"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:20:03 -0700
X-CSE-ConnectionGUID: yCy9ly7gS8q/QtsYSMKxuQ==
X-CSE-MsgGUID: fJUgtkMNQLCiUuBsu/mswg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156431053"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:20:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 01:20:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 01:20:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 01:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM35A7k+91vpGfcwlYicMPEMoj/mVtf+7Ci6p811KeIXU07qu3OQYOW2vlPguseBNlQ6ncudZEmtPBOadaFLWpF07Yxg/WyVqAYYxqRH48eK7Eu6ORSH/W+2x95FzsdY/X2ZZky/AK92d6pdtmUQwT+Z7g9ZqAJUcrMhOaScY0POwh+vXHtXv0ax8RLwEXGM7+8YjEl9PP71n6cWxjx7YMBodvoN4h6wBSgbAoyOWAmdfwXVAVe3Asb6wNmeIMXu3wWHd6zsqq+DIinM+1f5uZtYPB3Fhtxs5hJzyjPYK45WRaW3OY6Sw1xMLrJP+U29F8BlswKcA2jlMiRH6a87ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfBREle4UIU7VdB2eG6QaMPSp98vl4DyWf3uCbn5INs=;
 b=QW9irVpAYY7h8tt61iDNezICI2hgiQOon9dXweU3NT5iGXPJmeZ+24bsimU2Jeunn7eUdS29uv3oeoLI1dZEgfZ0zJdTK9cYB10edflJMgprSbLYLiWxa/i5Us99aa7KTceufXC2JWPas+KfYAfAG2ZDVZz6dNujCM/dc8eDjiHYyOYZbhGxwknBJCRUtStkCcJMYE9YMvDHY/TG7P6SMOOjPYf0TAULAqDtzpjadKvQGNHKasTZgTl9FJDWmKSefX7Pnkhdtdb6qvFnWAipuFhM9bohr0DyH7jJAWNPnDc5O5iqfjoOJtaUHtZGQXbuIYY98EwVGqeOQwBnMh6KEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 25 Jun
 2025 08:19:58 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 08:19:58 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v3] Bluetooth: btintel_pcie: Add support for device 0x4d76
Thread-Topic: [PATCH v3] Bluetooth: btintel_pcie: Add support for device
 0x4d76
Thread-Index: AQHb4nXs4rtDw3DvjUi+FyFV9gkjvrQNN+YAgAZVxKA=
Date: Wed, 25 Jun 2025 08:19:58 +0000
Message-ID: <PH0PR11MB75858C0F303822E5421BB1CAF57BA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250621064631.781861-1-kiran.k@intel.com>
 <ddd4bdb1-e461-4fdf-bddd-9709c45d60d1@molgen.mpg.de>
In-Reply-To: <ddd4bdb1-e461-4fdf-bddd-9709c45d60d1@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|MN0PR11MB6136:EE_
x-ms-office365-filtering-correlation-id: 2101e028-3e84-4ae6-0696-08ddb3c112e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFZsNExhUXZ5NFNWSHlTU3o3RktrUU5xTURRa3VkclU1bmp3UXRjUHhqTndP?=
 =?utf-8?B?c2hFQUFzZEJQRDFydDYrdXg5UGZ0b0pubzFWM0gvL3dFT3IzWmFZRlB1bzQ2?=
 =?utf-8?B?Sk5xRFJLQXdaUWo2RHUwS0tzVmZ6K2RsSWFheWtrdXBmMDE3MXVDOU1aOGVK?=
 =?utf-8?B?dGJrc2IzYW1QTGEwVjZJdERmcUtYVGRCUEd3WjR6UzhmMjRjdzhnUTBrRUhX?=
 =?utf-8?B?bEhmWExZZjFhTVkvVUJyZGdMR2Y2QkVTOXhpVVl1TTI5WUIwZXk1Z0h5T01M?=
 =?utf-8?B?b1lIandoa0JHZTRWVDBrU2ZvaEpHNHdEY2c4ZC9ZQWFZcHZIcFd0QXcySEU4?=
 =?utf-8?B?OEtndmJwaUVzV1p5RFV3ZnA1elY5aGl4QmxYRjRLcXRzVXZEV0JhSVNUSzFi?=
 =?utf-8?B?Y2g5cmd5akJyWlZxU3F6SHoxVjFOeUN1K2JEajFQdGx1SzhhWVdPNm1yMys4?=
 =?utf-8?B?TnFOOVgzT2dRLzZTZ2FZbHRtQVVrejFXeVFSaExTRFBKK0MyWitaa3d5L1JP?=
 =?utf-8?B?aEU2TTdGQmV2MzBhNEVKRk9KRWM4V0VpNlh1MmFQSFZQanJqcGREbzU1UXR0?=
 =?utf-8?B?TkluMWpIcDFtbm10M1JLejVUdjIvNjhSeHBueEFqVlZreWVsVWt3UFp5K3F2?=
 =?utf-8?B?YU1HWXUxd3lEWTdsTjBZdmhta2NiT1JIWmtWMnZPSXhFYUl6UmVUbEtjQVht?=
 =?utf-8?B?V2tFM1RLS2lyd1lNVXE4bHRhNE9kWjljeitqQkJ4RDZINmFxTXRRWmkxY2E2?=
 =?utf-8?B?YWIwTUZMcTNjVHVRS2tEa2xCN1pkeXliZWgvT2dKNUhGa2NFR1hqcWNQVmtz?=
 =?utf-8?B?TTNYVVdCdkZra0hsaHBHbmJ5dWRLUXpLb24xRmNjU0ZPMG9jY1kyZmh5bE5C?=
 =?utf-8?B?QXdsbFl1YlRlY3E0QklUaHlQOWR0MmdkTjdMb2FrZVN1NjMzTExrNVhncGJa?=
 =?utf-8?B?NGY4bXRjamM5SUxuNStaMWtkNGpUMmtxNHBzdXBjOGc1dzNMTm1Vajc4NmN3?=
 =?utf-8?B?TGhqZXFKMHRlMGdDYXA1RVNGZU4wQXVLbi9ZTk5yVU5Qc2lMTVJmNnhQRHEr?=
 =?utf-8?B?ZHYxTXN6V09TdURiZ3ZzTmo4VElVbHMwYi9SSGs1b2NsTDFMYmpsUEthYzhm?=
 =?utf-8?B?Ry9qY3VCK003NjRCWTh4ZDFqUER2SHhHbC90bHRzK21aWm5CaUJUMU5WcG42?=
 =?utf-8?B?ZHdOVVI3eU5nRVBmY3dLMmIvUWgrZHpOMHVOTkhyMEpBRHJzU2g3SisvTU4w?=
 =?utf-8?B?eTNjbDhLYXRXTkI1ZUhFL2xuSVY3RUhha2d0a2toWXdOeGVZNmcwVHd1SGZ0?=
 =?utf-8?B?TUxOZ2oxOUJLbmlkK0duOS9BeXdUL0JuOEltUzZJQkdQNDd2Zm5MbUpZcTRD?=
 =?utf-8?B?ejQ2ZmZwcEJZbnQrcnBTQzFicGk3Q2ovTDFHUWNaa21NU2ZZS21ZZWpUZFV3?=
 =?utf-8?B?MENYaVhScGRSaitDM3lVUENOTzNZUm4rVDI5aHVEdllDQWlqaVlyZDNid3c1?=
 =?utf-8?B?eUlpOWpRbDJ3WkF1ejY4bUxiUVd0RTR3eVRuWDJyaHZ3c1Y5WlhBMGZqSmM4?=
 =?utf-8?B?enRPeHhvdU5WS3oxUTdwV1Nwd3hyK3dhVFY2ZFlIRkhxa0l3TVQ5TFArNmpa?=
 =?utf-8?B?bEs2bldQYlluV1dWSjJqS0djUTZXNXNWekJSUDhtVDBzWVJoTWFEZ1NwK0ZX?=
 =?utf-8?B?TUtRYm9DdnF0YklJSDJUajgxQ3VzTVhkUEJaZ29lN3NYeUVlMzREN2VIS0Zx?=
 =?utf-8?B?UFlWODZ5dEd3bGZ5SVVCcHBSZFNzY1MzTnJDUWdITUZ2Tlk2Vm8vZjFBdzV0?=
 =?utf-8?B?bHFVdTFhMHl4T0tUc3BzVUhJb3pHZTNtY0ZwY09uWkh2QlVJRStxR0k1cDJY?=
 =?utf-8?B?L2lOdjhrc3RlK1M0VTgzS0U2bDhWQXJneSsxRUN6QjRvQ2JQQkhtSUROanNZ?=
 =?utf-8?B?SFZPNUpkRnFhNTFYM0h5aWp1QnY2QXNjblphQmxBcWJCY2E3eDNrSnU1Mmg3?=
 =?utf-8?B?Sy9lVEVLNWJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TThlc01MencrclVSeVlEbi9td0wyRjBwR3QzTTI4ekw4REI4RlA1c2pobzRN?=
 =?utf-8?B?ajVCT2NUK1VvbFp5MXN3alRJakF1eS9wbk4zRXVmTnEyUmZVSkY4ZWQralVp?=
 =?utf-8?B?OUh6N0lEUkV2NDBLM1Y0UXVGcHJBbUVIMlZ0NUpTZmZGdnRuUEJKeGtWVHNs?=
 =?utf-8?B?eUJhbjNkZ2FhZFYxQXNTdk93WVozMkFESjlFZ0FSaCtsNGU3Tkh4b3Qrc0Rj?=
 =?utf-8?B?U21NcGY1bWNOOXFnNmVFSmlCZ1M4QktzK1hleWR5S3BVMUpVeEF0YzdmdkU0?=
 =?utf-8?B?M0NFZCswNG5QTkpYS3hraGZsRjIwQ0tKZHVMd1JtSmFoL0ZVaCtsS0luN3Zv?=
 =?utf-8?B?aUU2ZDFSL2RXdXpjSUdOZWJnU3E3Rml4RHFGS2JQK1JSb3VBbjZCWjFHU2lp?=
 =?utf-8?B?N0U4RVFqVXJDNVMrMnVJd2tqZ0w2WjRucVNodVM1WVFkckl1NXI0dW9kTWpv?=
 =?utf-8?B?b0NiWE0zRWtxWnBKTzBSVHV6Um5NdFFMODM2M3MvbG1KRmxDd05UYWR2U3dP?=
 =?utf-8?B?cEFvVHk4VjZnenhaaTZuYlZHa1BZMGtjSC81QzVKQ1dobTIxVnk1SVk5dzJT?=
 =?utf-8?B?bldKN0w4TzRaSnhzRVY0KzlTRFhmNHNndmtsUmxmT05UeXFaQ1pGS2pxNVZE?=
 =?utf-8?B?ZjEwZU1ybWs0Uzc1bjZpSWdWekE5UE1kY3h4QnZpQTdpdlZ5djRGUkJmYnZQ?=
 =?utf-8?B?Tk52cHAyTEI2dDIrSzMwTjN4ZGdpeUZyeXV6NVVNNXpYdzJRdzB3aCtYVWor?=
 =?utf-8?B?aW5TcmVwNFAvR3VjQXlHa2VXTnhoNlRzMzEySVNIWm5qTkJ6RUo3dStQUGRr?=
 =?utf-8?B?UExzb2cwNnhxT2FJaUZSVnhRei9RR0FleEhWU0tHZUk1ekNsMEdwRGV3R2I3?=
 =?utf-8?B?UUFlb2lNNGVkVEdoandXblhuK1hiMWhyaEczWFVvanJQd0MzVUNKeHlaRHFh?=
 =?utf-8?B?TElmWHk5akQxbGNMNXk2QlFtc3J3Mk9iODJ0VVc2UGpsaDFKVTg1VzZWV2Yy?=
 =?utf-8?B?VWFuOHd4UFgraWZxTlNZNS9DejFlbloxRVpDM3BFT2xlZG1lamlqc0NTaER1?=
 =?utf-8?B?ZllZdWtPb3gvZ0phWVo5OE9SbGhRSy84bm1jKy9UYmpiSlBoY3ZmNEhPZXU0?=
 =?utf-8?B?dUEyMWpxc0hQV250OWR2TTNISUhCY1ZsNHJ0RnZhZzY5dG1hRzd6QXlJU2ZS?=
 =?utf-8?B?ODJzMVFvMi9uYjljOTdtamlrSElzSG5jNTkxSmExKy95YXNSQVFoWmh3UmJV?=
 =?utf-8?B?d3FEZFhGR2dxRVd1R1Z5dktzbForSDNXUFVCc1FQbXg0Vk0xb1dhcWdSTFhW?=
 =?utf-8?B?MExhN2hDcGpXdFZPTnM0L1ZMR3FSRGVQTzRRajhVclZMU0ZwZEZmTTJaWWJx?=
 =?utf-8?B?MWJjcTQ2MTROeEl6eDVPSk5HWEdRRXRURFc2bzZGeEY5NFp6SXNiQnhYKzQ1?=
 =?utf-8?B?ZVpLNEJycEtVR0RKa1lFMC9jdmd1YnVhMFpQUGNqZjZFb1ZxTXM0RzhUQ3JJ?=
 =?utf-8?B?MVFaUC83bmVpRXVwOHZmQWpZdStqZXhNVzFHcGRGZEpOZE5YVUllYWlXZ2tO?=
 =?utf-8?B?SUhkbmVXcnhjNTMwZnM1Ynk0ZVgvZVZBcXc5bHcvOXV0ZGR5YmZvRVJ1ckhk?=
 =?utf-8?B?MFRKMDg2WlNsRHd2cDYrcEhNUFJKaUlwZVpOUDhzN0hJVE5jOHBjMTdvUXlj?=
 =?utf-8?B?NzBlVU5GbWIrUXFNZXlmd0ttQXVnUFBQSldJV0Z5TmVNSkNPMnVXOGo1aWRE?=
 =?utf-8?B?VGRqRm51eUhlVVlpQjFUSVUxY1MwYnVSN3RTV0dFdVFmWHE1WkQybXdmVGEr?=
 =?utf-8?B?ZmJiMzB1Wk9Hdkg4VDkybURFc3NPOVg4SktXL0hjemRkSkZxMVJJTVBOb2Rn?=
 =?utf-8?B?U0crR3dZVkJGL0FaTGtRekg5b1BWN3lEcGZHV3ZCL0RQZFRDdGtXWFpGNXRm?=
 =?utf-8?B?cUlvdEQrMWtPUHV0WG9TT0lmMTlVN3V4ZTkvN09va3NhSWNuaDRkUHhVV1lr?=
 =?utf-8?B?dzRjMElWSHhQdmEyTldpejZNbnNBWTV0M0w4LzRmZDUyV2VJMldXeFZtZFdD?=
 =?utf-8?B?bDlmN3JlVmZYSnZpWlRNb1VTWUI1WlI2N1RnUTVkay9PZHJ6RlFPQnhCTU02?=
 =?utf-8?Q?1p9w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2101e028-3e84-4ae6-0696-08ddb3c112e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 08:19:58.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E502KMphaSoxqQpXdhPtKGrU57ZtYGWRkVIInVBA0F4FJ8M9CX5KWfcRPspDmovRSskw6MD6HdvBYXe1HlVfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
X-OriginatorOrg: intel.com

SGkgIFBhdWwsDQoNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzXSBCbHVldG9vdGg6IGJ0aW50ZWxf
cGNpZTogQWRkIHN1cHBvcnQgZm9yIGRldmljZSAweDRkNzYNCj4NCj5EZWFyIEtpcmFuLA0KPg0K
Pg0KPlRoYW5rIHlvdSBmb3IgdGhlIHRoaXJkIGl0ZXJhdGlvbiBvZiB5b3VyIHBhdGNoLiBTb3Jy
eSB0byBjb21tZW50IG9uY2UgbW9yZS4NCj4NCj5BcyB0aGlzIGlzIFdpbGQgQ2F0IExha2UsIHBs
ZWFzZSBhZGQgV0NMIHRvIHRoZSBzdW1tYXJ5IHRvbywgYW5kIG1lbnRpb24NCj5XaWxkIENhdCBM
YWtlIGluIHRoZSBjb21taXQgbWVzc2FnZSBib2R5Lg0KPg0KDQpJIHdpbGwgYWRkIGEgY29tbWVu
dCBhYm91dCB0aGUgcGxhdGZvcm0uDQoNCj5BbSAyMS4wNi4yNSB1bSAwODo0NiBzY2hyaWViIEtp
cmFuIEs6DQo+PiBsc3BjaSAtdiAtayAtZCAgODA4Njo0ZDc2DQo+PiAwMDoxNC43IEJsdWV0b290
aDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDRkNzYNCj4+ICAgICAgICAgIFN1YnN5c3RlbTog
SW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDAwMTENCj4+ICAgICAgICAgIEZsYWdzOiBmYXN0IGRl
dnNlbCwgSVJRIDI1NSwgSU9NTVUgZ3JvdXAgMTINCj4+ICAgICAgICAgIE1lbW9yeSBhdCAxMzAx
MzMyODAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdDQo+W3NpemU9MTZL
XQ0KPj4gICAgICAgICAgQ2FwYWJpbGl0aWVzOiBbYzhdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lv
biAzDQo+PiAgICAgICAgICBDYXBhYmlsaXRpZXM6IFtkMF0gTVNJOiBFbmFibGUtIENvdW50PTEv
MSBNYXNrYWJsZS0gNjRiaXQrDQo+PiAgICAgICAgICBDYXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVz
cyBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwDQo+PiAgICAgICAgICBD
YXBhYmlsaXRpZXM6IFs4MF0gTVNJLVg6IEVuYWJsZS0gQ291bnQ9MzIgTWFza2VkLQ0KPj4gICAg
ICAgICAgQ2FwYWJpbGl0aWVzOiBbMTAwXSBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcNCj4+
ICAgICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBidGludGVsX3BjaWUNCj4+ICAgICAgICAg
IEtlcm5lbCBtb2R1bGVzOiBidGludGVsX3BjaWUNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJh
biBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gY2hhbmdlcyBpbiB2MzoNCj4+IC0g
Rml4IGluZGVuZHRhdGlvbiBpc3N1ZSBpbiBjb21taXQgbWVzc2FnZQ0KPj4NCj4+ICAgZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAxICsNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5jDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRl
eCBjYjNjZjJiOWFjZWEuLjExMTNhNjMxMGJkMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
X3BjaWUuYw0KPj4gQEAgLTM1LDYgKzM1LDcgQEANCj4+DQo+PiAgIC8qIEludGVsIEJsdWV0b290
aCBQQ0llIGRldmljZSBpZCB0YWJsZSAqLw0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9k
ZXZpY2VfaWQgYnRpbnRlbF9wY2llX3RhYmxlW10gPSB7DQo+PiArCXsgQlRJTlRFTF9QQ0lfREVW
SUNFKDB4NEQ3NiwgUENJX0FOWV9JRCkgfSwNCj4+ICAgCXsgQlRJTlRFTF9QQ0lfREVWSUNFKDB4
QTg3NiwgUENJX0FOWV9JRCkgfSwNCj4+ICAgCXsgQlRJTlRFTF9QQ0lfREVWSUNFKDB4RTQ3Niwg
UENJX0FOWV9JRCkgfSwNCj4+ICAgCXsgMCB9DQo+DQo+U2VhcmNoaW5nIGZvciAweDRENzYsIGl0
4oCZcyBhbHNvIHByZXNlbnQgaW4NCj5gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9wY2llL3RyYW5zLmNgIGFkZGVkIGluIGNvbW1pdA0KPjk2NzNjMzU0ODZkNCAod2lmaTogaXds
d2lmaTogaW1wbGVtZW50IHByb2R1Y3QgcmVzZXQgZm9yIFRPUCBlcnJvcnMpOg0KPg0KPgkJLyog
b24gaW50ZWdyYXRlZCB3ZSBoYXZlIHRvIGxvb2sgdXAgYnkgSUQgKHNhbWUgYnVzKSAqLw0KPgkJ
c3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGJ0X2RldmljZV9pZHNbXSA9IHsgI2Rl
ZmluZQ0KPkJUX0RFVihfaWQpIHsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCBfaWQp
IH0NCj4JCQlCVF9ERVYoMHhBODc2KSwgLyogTE5MICovDQo+CQkJQlRfREVWKDB4RTQ3NiksIC8q
IFBUTC1QICovDQo+CQkJQlRfREVWKDB4RTM3NiksIC8qIFBUTC1IICovDQo+CQkJQlRfREVWKDB4
RDM0NiksIC8qIE5WTC1IICovDQo+CQkJQlRfREVWKDB4NkU3NCksIC8qIE5WTC1TICovDQo+CQkJ
QlRfREVWKDB4NEQ3NiksIC8qIFdDTCAqLw0KPgkJCUJUX0RFVigweEQyNDYpLCAvKiBSWkwtSCAq
Lw0KPgkJCUJUX0RFVigweDZDNDYpLCAvKiBSWkwtTSAqLw0KPgkJCXt9DQo+CQl9Ow0KPg0KPkNv
dWxkIHlvdSBhZGQgdGhlIG5hbWVzIGFzIGNvbW1lbnRzIGluIGEgZm9sbG93LXVwIGNvbW1pdCwg
YW5kIG1heWJlIGFsbA0KPnRoZSBvdGhlciBpZOKAmXM/DQoNClllcy4gIEkgIHdpbGwgbWFrZSBh
IHNlcGFyYXRlIHBhdGNoIGhhdmluZyB0aGVzZSBkZXRhaWxzLg0KPg0KPg0KPktpbmQgcmVnYXJk
cywNCj4NCj5QYXVsDQoNClRoYW5rcywNCktpcmFuDQoNCg==
