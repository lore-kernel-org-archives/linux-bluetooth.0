Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CA205ABA
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427182; cv=fail; b=THNQiSups0Az5GPx2rFCeK9+fMrSYYqREPj3vzCXw/EO/qrcRi2p71ldXAL4tdLjJeyTn1fDRDZbxR0n614DRbGXSiP/5I9ajVyMvmyaOliidYn/AYDThQs3v+5B/jFreqHZHn9gYpniIcd/yTYABXCVV2zUQI252g9MT/1+NPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427182; c=relaxed/simple;
	bh=rgudyu641uOJun3DQOHhJexUbUzxbNNMNwat1KplT0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKbMIPVz8PsijCAmtNNE2AFLXeAAj275H8bS/Vs5zbqRzwLIAvTukNHeGLfOnI2b+jOxR+bmwdao1dI4C2QAFlW/Gp2ir+F6DOzKKxxGNyUcG7Ig2krC711sMvDmt5/h+QVDpwCe0gdchTum7FViJHfFfVVzxB87elDGiC2LnWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZVyZsHu; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZVyZsHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731427180; x=1762963180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rgudyu641uOJun3DQOHhJexUbUzxbNNMNwat1KplT0A=;
  b=lZVyZsHutZ483VIHNwp7C9zwyKbfQjzP3Y2MA9fvjavCDXm5wRp5ii75
   Fovvk4SsHRCvReTBaxQpsqy8pVs3ntwmm7CsoIfJeXCIP8hsiwqKpPlWo
   vq2e33NBiOJ4LmTNLBzIG0fiXltLoOuW4VHbawC7d1dHxlYhuV3DJ6lc3
   BN2tmlQoxjJ2PTNvltw5OAofEtz+effXg8KrDaL1tKZ6Io5P75aXZNgxj
   7MHWw6ZWm8gTFp6aKJQffgCpZ2NbZIAc4xzgSxp413H0BXzlSJ0pbhmVg
   k2p9VxPfX+/EVo/Zzdao1b7W7yE+8sfgVKqxxY9m8IPxC9lUhxUqsZ6AQ
   A==;
X-CSE-ConnectionGUID: OXoojh/pQkenfo+SUWQToQ==
X-CSE-MsgGUID: LT7gYU1/RTKuApS3yXRcNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41878912"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41878912"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:59:38 -0800
X-CSE-ConnectionGUID: cKgxSwMTQEacwvxwNO6JOA==
X-CSE-MsgGUID: ayzdjkocTKaekHBRk0jRuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87108673"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 07:59:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 07:59:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 07:59:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 07:59:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiKNzXhHbXOlNaR/BrLUwC6ABqSQe93OGWcQcplcxTtRab2RWeJwZwDMalmYOpgphFQLebxXsiURMMT5DgKtNQYttuzkZcP+IdIMsjxTuqQMcq7avblKim/cmaPRq0ePvsLK3o/Uyz/BxpswhL+h11X5j0H7sa8/0wKyAMUSuw9z3Zs7LDktNYdd8ZMujsa5s/fmXeizl+zWEwAvGVzQ2F5KegolVnIiA+uH5LRe/i7Q1Gio4yOsgbW0k+PU8FVNmFix2W2YQByCVcaqo6HwzhQzfyglLugtic4FDwKxQOwfo7cYNBmxANMBaC/2/94ZZKtK39gA1uu5BdsEYsIu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hl7Kcp85bhyjEmiEBgngq8X545sYH+ysYahrOysEcA=;
 b=U66DfMy2LaV2q1pjTcNNJFlmnB7aRtkMFTpGUK1Nz3BP3OgiXanJP+5M9flHwJICe/esfQo1lx5Mv3KgahPS1LYnDPsL8FXa9WtbLO10OMY2q/fzzKvRiH63ndX9ZObppYMmtf9LNBD+RcXhW/2Ih8HQkyFPBWfDeDJqXOF0XzM9bQThtAEj7BFemkEWUuadeympYdJovYTGAXufcevDG2czSMw4fsIEjxiuwu8/yhNe5DiQS0uE25l0tOAlHynceRS29uz84D43vF8xw1VH/glI908J9kfWaRAZAQL4/2E40Xbb3LX7yYZe9o1cEWGIyzRvHhHI5BofI5rgNqmT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:59:33 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 15:59:33 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
 driver and firmware
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
 driver and firmware
Thread-Index: AQHbE+zfvY00RUFF00CmVe/BlzThyLKyp2iAgAFni7A=
Date: Tue, 12 Nov 2024 15:59:33 +0000
Message-ID: <PH0PR11MB7585591CC8F201F3144F0FF0F5592@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241001104451.626964-1-kiran.k@intel.com>
 <20241111182923.GA1802958@bhelgaas>
In-Reply-To: <20241111182923.GA1802958@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ0PR11MB5918:EE_
x-ms-office365-filtering-correlation-id: f03b6ed0-5971-474a-bc1f-08dd0332ffea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wbs4AFozRJBljQY/A7G+AMeBPjkgyhUd1d4oSKfM4U+l1MAPf7JOU0FiZxqb?=
 =?us-ascii?Q?YyI9p3B642E6TLG8xrg/ws7HxekLy8bM6XsfIetXFqshpFj09GzW45awg6bB?=
 =?us-ascii?Q?1XsPuvIT6sYWM1yuDLcalN7rOv+5TTuLHaWzs+uyI4w45YT9yMYaE1RyqNwZ?=
 =?us-ascii?Q?HIPtFmeVE5SE6RbQ0sige4SgaRdIu1UK/wM7mbV5xhC2wQtfSa+1iql4fnlm?=
 =?us-ascii?Q?Lum95B0/ANrrmfqS3M30ejBV3gBrU4jExgThQrHfCv1aIYPdHo/p7HlZfze5?=
 =?us-ascii?Q?08cw91ckSM9VCVR6v7o9NIx7QVjL89cFFPCWTInI3hlrK+ZXkN8ohHtBb1c8?=
 =?us-ascii?Q?5HVy+rzw+xuXdcuP5PEt+sdKRjce/QCMmTXLvWMz0/0cKfQwhzmecv7AB+oJ?=
 =?us-ascii?Q?0S+DigQdKjsYfWLCtLR3G2TzB4784lXv5cM52r1oKWnAnP5loR2eQKhiVwie?=
 =?us-ascii?Q?Hqt5yZwu2SOcJXzBFpDFhlRCY9HY19IG/EtNJUIlmwBsv7wODkktkJ1vgJ/Q?=
 =?us-ascii?Q?Fw6iluavRNDXLd36pf5j8aTLPek8nPIs5abnJZ6eK1VSlfTv0zy4dD3jxW7H?=
 =?us-ascii?Q?OGhh2H1DbXfFMY8g4HRZWxec52acXN7JkCPnweQAA5/L89qgRSVs1DrebP7w?=
 =?us-ascii?Q?Tqoaom+uG0Rk8TPvjozX6UF8s5lysPqHGHRC3ZoePTUZFo02DuLi51AmB8gE?=
 =?us-ascii?Q?DqIzyp5+aw5SfNXg/5Yi1NrieLsJar3Ak3aB2oWWBpwVX6E2WVHZmMMraXig?=
 =?us-ascii?Q?7S3DjhxY4Y+UoH9CyNDkIIC5ENufS2KW4SpewJzgNBNr7pbLw26rh1OuwD+6?=
 =?us-ascii?Q?KPXmbDBocfkbI8oVDrZzGSY/+0to9ohP8m80zKRsL0ZvatYtWMRkeG+63u+8?=
 =?us-ascii?Q?dZqcWjavIIqajMMVXGhoS3SX10xE4CPg4TMbQOssOipjIVa0ARf7IhEcPB4k?=
 =?us-ascii?Q?gtC7/pfBYj9tG9IFZgZteqSBUNHmNnC397tLrMNZFZh9RerbOhTPNTMfZoe/?=
 =?us-ascii?Q?UkLt6PdQ+uYG4PxJwY2BN7smyq1bHjOZffTQAEq0cFbIxYrRiU+8nFR3jh2A?=
 =?us-ascii?Q?eHyDTIfMONwNrGLIFTlRO5bHx3/NO9VV28thrCSEa2TuHZGUOFFsv3/NqInV?=
 =?us-ascii?Q?yVh2v2qxJ9ghOzy2HzxuoiojMGyCVB5nK2q6ac7IQtueR9GhLFQbXPvysVBc?=
 =?us-ascii?Q?29glJ6vFxy6ov7mhzVaG2NWwAtuEgkLhne3GDP8HqJdP0X3oCcTCoEMuGQ3Z?=
 =?us-ascii?Q?B0PtLGTGyT3EPvsf6IUOpQmmm+fFSW/Q3U1m2WcEUnhiv0m38yFPwFnI4uvf?=
 =?us-ascii?Q?ll+ZZBGyPFnIOCNo9rZRQZOn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v4mv+CE8y/EPutN8+1YS6HUn/Br/igxSHcFdKI5bRITn9CwMTq1K6cq33Ruh?=
 =?us-ascii?Q?ULH8onbfzXoymxYO6x1TXiqg/7O9UMYL9vlxpy2RBH+l/BHkAP1XXKd5o7Yq?=
 =?us-ascii?Q?mBq9i6SQrR4q8du0eV66ZNyaC1N/tcZORJXy+TZ9icx9x/AVvF5QSHrGTWKP?=
 =?us-ascii?Q?gQOrip6a8wd7eXaAZzkjqmAlor4xyR4RCz4ez+zR3nGmsg09ThH1Yh1/NPNN?=
 =?us-ascii?Q?SRKHjGWPek8Rl3Rjfxf7LpxqWuYnJ0/wk+RIhvqdzUbBEapL5JqoNhtixra+?=
 =?us-ascii?Q?Mz+erSQZTl1lU/+N2ZDbYhjgf02toIH2cj6qNutgSecPQ9NSIl0HmL/v1q9+?=
 =?us-ascii?Q?Di+dZyuL8dFHPmvFp3MiK3QjCrfKiywDK7MqT86ye9sHndo7XW2nalqIwzBU?=
 =?us-ascii?Q?b7bTBkti15oO3nRC3OZv+fe/vmdjmvo3S6d9p3Z1ZG9R1drZoxgiGBV9BQaN?=
 =?us-ascii?Q?Qq4pTWqiMtA9zbaQ18KvdS4Mp4nd2VErwMp0U+JYpCrmaR6JWL02H0r5QOkh?=
 =?us-ascii?Q?yUC+23ZiKeF0nKnu1zaAVGUYdNjyLzJshqI9z06QwMpXo/KG9uEdeWkJ+QuS?=
 =?us-ascii?Q?lABG5R3l6pp1E96DDa/Tq2GROWOuJ60JlFBeIFpGxhHHhcaLqNMtLJhWrS/p?=
 =?us-ascii?Q?nUEbNJjhQCk5er3G0/V0dyZFgNk4j6CxwMn34ZENeE5FHy71LOFKyIQXatnA?=
 =?us-ascii?Q?nN0YKBONs/+HhfqL/ZC9i5Ms7DwPnNxRrqJlqSASHv1os48h5lzNoulG2u9K?=
 =?us-ascii?Q?gFql6QHsGwjTGK2lfCr1FDcHek+MmnB+FAi4kRpzp0XsOqNPp4w6EDKwfSIE?=
 =?us-ascii?Q?Gn4zBJoVmQPHUSDjBNMQCvZE29wVi/STFQHDIIgiowEN4gHTEEHHWnqlBiX1?=
 =?us-ascii?Q?ttXJviO6p4Qyvu4QP3QjLwgl3bxGtRWqlMNAXsIgHbCs4K2wXZm+DiQP0BO6?=
 =?us-ascii?Q?Mlpw0gflaD33KKxTbuNHYEwpq0tKsG9ls2DimfrPgWMXve13jEE1+/EtHl5m?=
 =?us-ascii?Q?nd0AvdE42bOv+xh8dW5qSUEuo0ybua2fFWnSntqYiHNU7zmsyqv35gpIxWRJ?=
 =?us-ascii?Q?ryNULsbKaZs6l4KjZ7+G6BomPg2wyI6zpZjJacdw+u1lD7b3H+cqpNsMxgDV?=
 =?us-ascii?Q?MCaZEcgnRjgcQ/BjBMGu9aWYXMeO6yChuTylTmSRNeLGXWIANOKjHF2tfrPe?=
 =?us-ascii?Q?Yr/DeUk2oIyZnQlenROLNIpE24avV7s+ZUnUTwpf6kDgpdPSg5OP6KwGuYpy?=
 =?us-ascii?Q?zksx7TYdkNQ50ketOp3VlCq8PhCJ8AQSxqSjAIAgjx3IrhUpsvbWIXXMaGDe?=
 =?us-ascii?Q?HD0JveW1ruVU31/Spqz9BMMt9PXmFrJJwqIA3rp1QznXN3RKs5WcvwnynBVJ?=
 =?us-ascii?Q?4QfMrZ1QALPDTHVAUjPNYBFIOzbga48IbAMXYrg0EurOwcY+XFZdkozn76tb?=
 =?us-ascii?Q?G3aoTszxlXwjMX65PIBW88A+ncWXai592hNlgvhzOlSTt8qWasengkITJEV4?=
 =?us-ascii?Q?jqiLN5Ox5Bt/f3w+rog361u0DO8o2vc+TTnu/tICIAY8/PFJtBXnyZhD0JF9?=
 =?us-ascii?Q?IjEJ6GwgqQ+C/yIuNwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03b6ed0-5971-474a-bc1f-08dd0332ffea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:59:33.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7ZW07QsFaKk0pzCgq2hq3LFriuYQBeF+u6iZLmLk1ynVHbBWWMxo+oa0FI4WRAVFKW5rRyzkig78/MsnkFZOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com

Hi Bjorn,

>-----Original Message-----
>From: Bjorn Helgaas <helgaas@kernel.org>
>Sent: Monday, November 11, 2024 11:59 PM
>To: K, Kiran <kiran.k@intel.com>
>Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
><ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
><chethan.tumkur.narayan@intel.com>; Devegowda, Chandrashekar
><chandrashekar.devegowda@intel.com>
>Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
>driver and firmware
>
>On Tue, Oct 01, 2024 at 04:14:50PM +0530, Kiran K wrote:
>> The following handshake mechanism needs be followed after firmware
>> download is completed to bring the firmware to running state.
>>
>> After firmware fragments of Operational image are downloaded and
>> secure sends result of the image succeeds,
>>
>> 1. Driver sends HCI Intel reset with boot option #1 to switch FW image.
>> 2. FW sends Alive GP[0] MSIx
>> 3. Driver enables data path (doorbell 0x460 for RBDs, etc...) 4.
>> Driver gets Bootup event from firmware 5. Driver performs D0 entry to
>> device (WRITE to IPC_Sleep_Control =3D0x0) 6. FW sends Alive GP[0] MSIx
>> 7. Device host interface is fully set for BT protocol stack operation.
>> 8. Driver may optionally get debug event with ID 0x97 which can be
>> dropped
>>
>> For Intermediate loadger image, all the above steps are applicable
>> expcept #5 and #6.
>
>I see this is already applied to bluetooth-next and is probably immutable,=
 but
>if not...
>
>s/loadger/loader/
>s/expcept/except/
>
>But more importantly, the race below is still in linux-next as of next-202=
41111.
>I mentioned this before at
>https://lore.kernel.org/all/20241023191352.GA924610@bhelgaas/#t, but it
>probably got lost in the suspend/resume conversation.
>
>> @@ -1053,8 +1272,11 @@ static int btintel_pcie_send_frame(struct hci_dev
>*hdev,
>>  				       struct sk_buff *skb)
>>  {
>>  	struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
>> +	struct hci_command_hdr *cmd;
>> +	__u16 opcode =3D ~0;
>>  	int ret;
>>  	u32 type;
>> +	u32 old_ctxt;
>>
>>  	/* Due to the fw limitation, the type header of the packet should be
>>  	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read @@
>> -1073,6 +1295,8 @@ static int btintel_pcie_send_frame(struct hci_dev *hd=
ev,
>>  	switch (hci_skb_pkt_type(skb)) {
>>  	case HCI_COMMAND_PKT:
>>  		type =3D BTINTEL_PCIE_HCI_CMD_PKT;
>> +		cmd =3D (void *)skb->data;
>> +		opcode =3D le16_to_cpu(cmd->opcode);
>>  		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
>>  			struct hci_command_hdr *cmd =3D (void *)skb->data;
>>  			__u16 opcode =3D le16_to_cpu(cmd->opcode); @@ -
>1111,6 +1335,30 @@
>> static int btintel_pcie_send_frame(struct hci_dev *hdev,
>>  		bt_dev_err(hdev, "Failed to send frame (%d)", ret);
>>  		goto exit_error;
>>  	}
>> +
>> +	if (type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT &&
>> +	    (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D 0xfc01)) {
>> +		old_ctxt =3D data->alive_intr_ctxt;
>> +		data->alive_intr_ctxt =3D
>> +			(opcode =3D=3D 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1
>:
>> +				BTINTEL_PCIE_HCI_RESET);
>> +		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context
>changed: %s  ->  %s",
>> +			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
>> +			   btintel_pcie_alivectxt_state2str(data-
>>alive_intr_ctxt));
>> +		if (opcode =3D=3D HCI_OP_RESET) {
>> +			data->gp0_received =3D false;
>> +			ret =3D wait_event_timeout(data->gp0_wait_q,
>> +						 data->gp0_received,
>> +
>msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>
>This looks like a race.  You're apparently started something previously th=
at will
>eventually result in data->gp0_received being set.  The ordering you expec=
t is
>this:
>
>  1) Tell device to do something and interrupt on completion
>  2) Set data->gp0_received =3D false here
>  3) Call wait_event_timeout() here
>  4) Completion interrupt causes btintel_pcie_msix_gp0_handler() to be
>     called
>  5) btintel_pcie_msix_gp0_handler() sets data->gp0_received =3D true
>  6) wait_event_timeout() completes
>
>But this ordering can also happen:
>
>  1) Tell device to do something and interrupt on completion
>  2) Completion interrupt causes
>     btintel_pcie_msix_gp0_handler() to be called
>  3) btintel_pcie_msix_gp0_handler() sets data->gp0_received =3D true
>  4) Set data->gp0_received =3D false here, overwriting the "true"
>  5) Call wait_event_timeout() here
>  6) wait_event_timeout() times out because completion interrupt has
>     already happened
>  7) We complain "No alive interrupt received" here
>
Possible. Unfortunately, this issue did not show up in our test. I will rep=
roduce this issue and publish the same.
>You should be able to force this failure by adding a sleep before setting =
data-
>>gp0_received =3D false in this patch.

Ack.


>
>> +			if (!ret) {
>> +				hdev->stat.err_tx++;
>> +				bt_dev_err(hdev, "No alive interrupt received
>for %s",
>> +					   btintel_pcie_alivectxt_state2str(data-
>>alive_intr_ctxt));
>> +				ret =3D -ETIME;
>> +				goto exit_error;
>> +			}
>> +		}
>> +	}
>>  	hdev->stat.byte_tx +=3D skb->len;
>>  	kfree_skb(skb);

Thanks,
Kiran

