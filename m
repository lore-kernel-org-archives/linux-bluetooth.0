Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023141.outbound.protection.outlook.com [40.107.44.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBE2D0C86
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532040; cv=fail; b=AEASsJYNviAtiMJEtD9iU1VlzQCAi/QLhi22+o4NLLnwXVb2kC2f6jZlLBzM2e/bbNv+uRZMXX22FKoiTQ96HpL/nImkAeuGOu4C5PXqOAfeSjumcmLVLfBfMUi9DL6fmvwBP8qJo76JywTe0VcQWWXsuYZNPNHH+AmELo5qBVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532040; c=relaxed/simple;
	bh=uhM775dCWKUr515MYbbLXs9HNA3IOGVL7qXpp/p/55Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPpCKBZ38sZU7ybRO0EdXn5w9d7sTt+MS3O8kUktAxCJtHWeNOhDapJk0TbUZ0tz8qhKcoJNKIPmrc1AEjmCJdZ+NAEMx0sKV30Vas9v23KGBhc4Pbyo+QyPEPIf1GmMkeeE78lIgd6BY+pJ0DHVioBMtF1ovP9dobAO8eaAKKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wA/0chw3; arc=fail smtp.client-ip=40.107.44.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wA/0chw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOF3Qq0tg+FCzvCywGT2oBvdpGVUysfuraLze9AcD+fl7xjelfxRdRP2twbF+LXRh0PsWIqyOTC4BGgveil0C35whOzAoD2fgXZgUgdpWE6iZMdNoxPx8Z5jQyXAko29BqFrEg3S7EV4h2/0tqcwtEsDwNhJWdu2eOyL5ougImt5Ea9MvBdeU93b3nVxt04YGoCOsIuHsuuT/xwK8ePN4JHTx9FoGO5Y8u99kj7UHfWQ7KgYvkqKpTzjWap7rLQ8vczxdVLFmjwnOQShhFx2m1+z8DIkXW6QuDR4OtAXyA2qpLjagIyG8AthoYppyhnXaZXIlrm8HKTZiJHDkFw9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oElniMKWzvIaC7XgJFK17OdkADP/QwEIHampAD73/1Y=;
 b=or2Rw8v86My6y3QKzB3BSdqbXTW1sKuVtbz6f8QCYwbde0bJ7RzGv6ie6M2Xi6tDqcFAJpS3oF0Z+EnG2KkvKo0IjJPfHbdRUKGj2N6ksbalGb+Ca1qVxGriDJXIuXU3lVjOSNmlmshstHvOHeQ516jnUkULAS0kTEKMH8O1fQbl44OzHFaoVunM07nMVhb4kXBWQSZoltNwO0KK2weLDJkNbnD01OfMdj8MXQHbG8iGohOgqXOsU4Q0kkVFQBxo1y14PDd3J+XcBVc5SHJrB89GSVhRDGVR8sBcl5xbDqiW7omVDhitpgfZySR7NbNiQTOL8B9xzlU9MS233cpXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oElniMKWzvIaC7XgJFK17OdkADP/QwEIHampAD73/1Y=;
 b=wA/0chw3qbegwwwlOCoKkHBlmEzNc+ITyGx8Ia12MYM0sRZ3spbtirqMU9iadrPuRG0dtbcphIuNzmWiubTE5IWqJw0a0QBnSfsNuHJDQzrjyBLrAf+jQvrxjcNCI+zrSYR+q1avl8ulX4OiIgBxUpgvZOwd3DaarVyOTKUdnPGtPcv0lHbH+UIEnOHtCr7vmir3+Y/nVijDVWjn6gcMjpBO5PQ0QzC+dBgLWX0BlSVmLTR3EpOW8ps/0F3jh67yMuTZtwrCG4qsUKNTwMLKSLNHALteASUFM+tdGt43vvlJ07vKhGS5HXmFKw5QJKCm9cORoANdSU6nrzmht3d0Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB7533.apcprd03.prod.outlook.com (2603:1096:101:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:40:33 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 08:40:32 +0000
Message-ID: <05dcbdc1-893d-4ea6-8c8c-40abfbb906f4@amlogic.com>
Date: Thu, 3 Jul 2025 16:40:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v3] shared/bap: Add stream state check in
 stream_disable
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250702-bap_for_big_sync_lost-v3-1-d314b60abf7a@amlogic.com>
 <CABBYNZLNdr5kW=AXYohCOp71CCmvir3hjeBungDHYq2gRD0xEg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZLNdr5kW=AXYohCOp71CCmvir3hjeBungDHYq2gRD0xEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 0018e161-6f6b-46da-02df-08ddba0d45f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWNmWU9iMmltaUd5d0ZTWWFqWXVsRjVKd1UwQTR6aWFRZ1pKKzJVc1VJRVFh?=
 =?utf-8?B?MkF3bFM3TUVWRys1VVhCNjZIaEZ6VVRLa0ZTZmQzWG5FVDRWMnpsVkJSdk4z?=
 =?utf-8?B?V1l0WFFwYVMyQU5vMTNPcDB0L2JDU1RvZEZLOXlxK2xMTEVXU2xMcnZvYkdm?=
 =?utf-8?B?eW92V3NKSnNLNjVzNFdEOFZvemp3QTJOblFEbjRFelhzVmcwaFZyZG1Udm5N?=
 =?utf-8?B?dXpuOEVXMVVLZnh2a1JNN2ZFdTdIaXR6ekx0S1RBb3drZi9BYlVWSWhta2dY?=
 =?utf-8?B?Y1lGUXlBV3dXL0dzQjRDb2hSUVM2dWljU1R5TnIvRDIvc2VXaVhZTmptNWRX?=
 =?utf-8?B?eWRqMUZiMjZqSzlQajdPWTA3VTdzMFdvbERLSlZtMWVoZTlyZFpZNTF4YmRm?=
 =?utf-8?B?VUJKRmQrZnNjS3RKN2c4UVdUeExNeVNGcEowTElGdzJxS0NaMjR4UjZJc3hr?=
 =?utf-8?B?NE9lZ0RHeU1MRW5qQVlXMDBKT3VrTHN0cVVsUEJ0aDVMb0RxYXpTUTdmUGJm?=
 =?utf-8?B?MVVYQTM4UXd6L2Y2K1hOcW1lVGZsUW1FOWtOMGloVnJ0eVFOdEJiRVhvRGJn?=
 =?utf-8?B?OWFrQUpvTy81WWtwdjh4bUdvbHExRitpRnd4aHBzQ0pDajVyK1VCYnhsQzRz?=
 =?utf-8?B?Qzk5QnJqQXRUVzhUbTNUVmhVU3gxb01uVFRVbkxwUFlSRHJuSnUyTTRwL0Vn?=
 =?utf-8?B?dWczWlZYVThYTXhSWmdTckk2MjgxSks5WkR1ampvdkJoYU9zbnZsbmhmZEVW?=
 =?utf-8?B?WTRGK3d3U2I5Z2g0bW96dTc3NzJveXpsR3VNK21QRk0rS2wyc1QyMzJHZDBT?=
 =?utf-8?B?dDU4WjVxbzU2TklPcDFCVHhrUW1WUTE4QjRPTHFaMmpQU2NIL08xaEZBNTdq?=
 =?utf-8?B?NWp6Nkt4UnFSZDZxT01rcnVod0lzUnQweXNKKzZGN3VUUGVzNXY2bndPY04x?=
 =?utf-8?B?eThnN2ZNOHJZMmc3aUNZOGZpR3p0eHZBU2swNjBFUlhXOFlVZHFHb2NRZCs5?=
 =?utf-8?B?NDVDVVNuYVhtRlQ1WENoUlpZL3BpRGc2UHJ5WFFITzlDclc1bW1ZakRpaGZK?=
 =?utf-8?B?VERxcGwvamNmNzhveEhCOXpYcWVGb01LTEFtdWxKYytCZFl6TnB4bnNDeUNV?=
 =?utf-8?B?TzN2QThPekkrRDR4UlBLL3N0cm50T1BES1d3eTl6WTFkTS9LT1hXbEZuenFY?=
 =?utf-8?B?a0VyZFJvU3RCNGFoUkhyenVZUlZFajQybHJ0RWVPMlZqSnFLUmtqZ2NOdlB5?=
 =?utf-8?B?cVFvY3JrenA2a0hQOG13Zk5PNEVwSXdPZmFFSjlGclFMNDhtODk4cTNOS3J2?=
 =?utf-8?B?cGFRV0w3OEp2RTJVODExNnhYSEF3eWRNVEZaQzdPazBwZ2R5K3RyR3RweWl5?=
 =?utf-8?B?MS9haWpjZ1VsTU1ETmkvc0NSSktQMFB3MTZueEZJUGN6RVJ0Y2FZYzIvbFU3?=
 =?utf-8?B?VlJ5UVNzcHBlQXhyREQzSFgyRDMySFVZYXRpaTcwL2xGbmVhSXkrWXNUak0z?=
 =?utf-8?B?SHc4NVk4SU1KZUNsRW1RUlRlQVBWVFRRNW9DWmg2QVVIYmxYK1BRcDJ5Vmtu?=
 =?utf-8?B?OGErYWxRem1IdXo5ejAxVlFvNEdUUlNMNmlHSUgwbVNUenB0YjF3NlBDNjRZ?=
 =?utf-8?B?eHZWTUwyM1g2NzBna3hkeThxNmhtRG44TmtVcXpROTBKYktFckh3Y2YreThl?=
 =?utf-8?B?eEZYTUJ5Z3J5SFBSdWNsS2dFQnhrclJTaWJLQ0ttK2VoK3BwSWhoZHcrbXpi?=
 =?utf-8?B?Ulg1TGpRZkNIdlJPNlVDc2ltbzRZK2pzbU5XbUlaWHlieitDQUJZaFU2N0xF?=
 =?utf-8?Q?ChbeCH/GNCIGP1gF1xF9GnEvb4TGyk8eigmKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tng0S3NCckVoMkVJcnYyTktDWFhPaXhaNzlleXYyZXRsWno5a0s5WitrYUlG?=
 =?utf-8?B?R1ZkYUt4NXJGeTFjZVZ0Q2hBeUY4Y3hvQ0Q5d3JRQkFwekdCT2dCdGltdWFL?=
 =?utf-8?B?ZWcvaWV0UElqaGgwNDdtZkpuWjc4cmhYZEtjNm9WOWpEejFFemsyTWxyeTBt?=
 =?utf-8?B?djhucXppMVU5TlhrMXBWY3dveTAvYWJyUHY0M2UvU0c3dWQ0Vi9zeW5MMW5V?=
 =?utf-8?B?dHdqa0VvY3pDVnpTSXJaUFBlcjZzY0pmbGh4UWNlUlIrWnhtaGQyOWNuZ2FK?=
 =?utf-8?B?NGRnQm9hbm9LYTYxcFY0a01qK2x2SXl2YXJZN2ZuZU9aNCtjQzB5elplZ29G?=
 =?utf-8?B?U0s4M1VJM2dtNkJsUjc1bm5ZK210bzBYVHR2MkVEU1JzUGQwQnZvTVNJTlRQ?=
 =?utf-8?B?dWxKV2ZISG5wWW5jcjZQaVBNMHZjdnVHOStjUzBDcVIxWUZDejcrR0p3bVZy?=
 =?utf-8?B?c1QrcXdadHZ2VzR2eXhsQjd1V0ZkTHhrNTdneHNJRHRrdDFsQ0JJM0thRE9x?=
 =?utf-8?B?TXNyZWJxTy9NNzBMTzMvbkl2TUJiUVhRR20vNDZUeVJaaEloTVZmVWpzVk9T?=
 =?utf-8?B?T1JlRzlVMU9vbWdnSGJZL0VUbHQ1NFlWU3dQbTV2VDRpbGdacEpLUHFLQlV3?=
 =?utf-8?B?OWFOYzloSmROSm9CTGRsZzhETWdvbE9DZkxEV3FKUVR6S1B4cFJ3YWZhQVRi?=
 =?utf-8?B?b2ZPaHUvRTkzeWFHbWNVcnd3azQrdTVtTTBmdzVKdGtjcnpLbEZhTFR6bElZ?=
 =?utf-8?B?SWEyNktEaFVmaU5NUG9wYzkzN0VzbFJUMXQvRWk0Qmc1RjVSYjh3Yjl0dEta?=
 =?utf-8?B?OUFiOWZzUEVSR3E0dzU3b2p6RDZWaTl3RzNXK2JJVTI5VjRWTk1RTEkzc2lT?=
 =?utf-8?B?M3UrZzdxRlhTR2xoWjZ2KzgzdzIxVy9EWGtlbFp2RFc0ZVROVXNaSk83SDNj?=
 =?utf-8?B?N0habU5oaUlQWU1PYXduSkNTcEtxWThsaXNtelZhZ0kzd1QyUGxkcGJZN1R5?=
 =?utf-8?B?QXlEcFYxQ3lPU3YzMUVBUy82RHlFd3FlNDFZekdzd0F6SExnVFJORDB0VGgr?=
 =?utf-8?B?SjV2dWVmdVFPMHVxNk1vOGJMczNXWm9lUmZGYTZ4M1hDUHBqTTVsOENmZ3Fy?=
 =?utf-8?B?aDVJcEZMSXYxcVdYbEd3VlRVYjRzckRzcVVnRDkwS3VYKzQ0bDIrTUNweDlW?=
 =?utf-8?B?czl6TVF3dms4SC9ULzJWTDBaU0VvVnVnYjVpSG5HQUZpMmgzN0R1cWUyMmZE?=
 =?utf-8?B?NjVlN2ZNc2dZcTlVZCtZTEQ2WUFTSFNFV2trOVpBL0psNUtlRFFzYWU5S2dI?=
 =?utf-8?B?NEI1L2pTVXJHaTZsUFdzOVJnV1Jnb3BtT3QwcXNIZExqNXJrSjBIQTV1ZXR5?=
 =?utf-8?B?aW1yZG5yR3hGbjQ3b1BRWHFRN0ttbXZOV09LMzdjdDN2dnorTjR4ZWthQk5K?=
 =?utf-8?B?eEZzQXlGTmN0QnhQV2c3bnlJTldWYmg2bzVaaW5KY0YxNHAzOTF3c0E4TDlR?=
 =?utf-8?B?NnJneEhLajU4Tzg0K0QvcjlZRk0zeTZ0TUkxUUhEVG00a0xSNzVIUUJvYlNP?=
 =?utf-8?B?NnhzSk0vV2FyQ0RCNGhvb1ovaytzb1diQWZtVXFTUzl3TW43NUVCWXZsQXdG?=
 =?utf-8?B?OTVqM2FoWkp0UzZZR0R3NWZhdWlsRVpuYTVHdUlVU2tHSXJiSW5xZlRKYXFn?=
 =?utf-8?B?NW1maE5uNGI4QUYycjJoYU8vbnhsK1dwUitVVlZJdVdqT0swSGJmYzltYW9Z?=
 =?utf-8?B?ckduQzVBaHRVR2NTdDF5S2p5cEdWek1SeUZXVVhFTk1aeHhna2hEWjJTWjht?=
 =?utf-8?B?b0w4eXMrRWNsVWJKNURtMVZFaGZsN0txc1liYnBBcUdSVU03YVNWN1R6bHV3?=
 =?utf-8?B?L2YrbDNtZFN3U0lzWWZseUtOZHkrY0tISktzaTlsZmlKTmFlVzZVOU55OGlO?=
 =?utf-8?B?RTZlZlA4L3pvcHR1U2tIb1FlQjUwSjE1MG51M2tiVUU3VFlqSDNIV1pMc1cw?=
 =?utf-8?B?cnA2YmZpK1BXaFJ6T2xxbmRnU3d5VUJxQWc2enQ5L3BpSkg5TVZLVzNmS1k2?=
 =?utf-8?B?MllSSmd5ZGliM1BQYmVkRXF6MGdoUmhGcmlxZ3l4Mm1mOSt5MkZiU0ZSREt1?=
 =?utf-8?Q?Me+mrs5protXROFRX1KYVTLRF?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0018e161-6f6b-46da-02df-08ddba0d45f2
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:40:32.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugkppHE0WW4oCRk5g6wnEkfaf//7oW8oxbGTwwGhjdqs0LsjJ3/9U4ihzej7BsIPmEYnhY6nKZVBvHI80LyR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7533

Hi Luzi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Tue, Jul 1, 2025 at 9:19 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add a state check so that stream_disable() is a no-op when the stream
>> is not in ENABLING or STREAMING state. This prevents unexpected state
>> transitions or redundant operations during cleanup.
> What is the issue here, do you have traces, debug logs, etc?

Regarding the Unicast caching configuration you mentioned, there is
currently an issue in the code flow. The relevant log is shown below:

When music is paused on the pixel 9 phone, the CIS link gets
disconnected. As the transport state changes from ACTIVE to IDLE, the
stream state transitions from config to qos.

 > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [hci0]
49.572089
Status: Success (0x00)
Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
Identity type: Random (0x01)
Identity: E8:D5:2B:59:57:A6 (Static)
Reason: Remote User Terminated Connection (0x13)
bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream
0x1f9fc20 io disconnected
bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
0x1f9fc20 dir 0x01: releasing -> config
bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20
state 1
bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed()
stream 0x1f9fc20: releasing(6) -> config(1)
bluetoothd[2313]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=TRANSPORT_STATE_ACTIVE
Playing=0
bluetoothd[2313]:
profiles/audio/transport.c:media_transport_remove_owner() Transport
/org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() Owner
:1.1
bluetoothd[2313]:
profiles/audio/transport.c:media_transport_suspend() Transport
/org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
bluetoothd[2313]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1:
TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
0x1f9fc20 dir 0x01: config -> qos
ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426
[hci0] 49.585656
ATT: Handle Value Notification (0x1b) len 46
Handle: 0x007b Type: Sink ASE (0x2bc4)
Data[44]:
01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
ASE ID: 1
State: Codec Configured (0x01)
Framing: Unframed PDUs supported (0x00)
PHY: 0x02
LE 2M PHY preffered (0x02)
RTN: 5
Max Transport Latency: 10
Presentation Delay Min: 20000 us
...
bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hci0]
49.585725
ATT: Handle Value Notification (0x1b) len 19
Handle: 0x007b Type: Sink ASE (0x2bc4)
Data[17]: 0102010010270000025000050a00204e00
ASE ID: 1
State: QoS Configured (0x02)
CIG ID: 0x01
CIS ID: 0x00
...

when playback resumes on the phone, it attempts to set the ASE state to
Codec. However, since the stream has already transitioned from config to
qos, the phone ends up disconnecting the connection.

bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [hci0]
60.216004
ATT: Handle Value Notification (0x1b) len 7
Handle: 0x0087 Type: ASE Control Point (0x2bc6)
Data[5]: 0101010000
Opcode: Codec Configuration (0x01)
Number of ASE(s): 1
ASE: #0
ASE ID: 0x01
ASE Response Code: Success (0x00)
ASE Response Reason: None (0x00)
bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hci0]
60.226086
ATT: Handle Value Notification (0x1b) len 46
Handle: 0x007b Type: Sink ASE (0x2bc4)
Data[44]:
01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
ASE ID: 1
State: Codec Configured (0x01)
Framing: Unframed PDUs supported (0x00)
PHY: 0x02
LE 2M PHY preffered (0x02)
RTN: 5
Max Transport Latency: 10
Presentation Delay Min: 20000 us
Presentation Delay Max: 40000 us
Preferred Presentation Delay Min: 20000 us
Preferred Presentation Delay Max: 40000 us
Codec: LC3 (0x06)
Codec Specific Configuration: #0: len 0x02 type 0x01
Sampling Frequency: 16 Khz (0x03)
Codec Specific Configuration: #1: len 0x02 type 0x02
Frame Duration: 10 ms (0x01)
Codec Specific Configuration: #2: len 0x05 type 0x03
Location: 0x00000003
Front Left (0x00000001)
Front Right (0x00000002)
Codec Specific Configuration: #3: len 0x03 type 0x04
Frame Length: 40 (0x0028)
Codec Specific Configuration: #4: len 0x02 type 0x05
Frame Blocks per SDU: 1 (0x01)

...

 > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [hci0]
63.651497
Status: Success (0x00)
Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
Identity type: Random (0x01)
Identity: E8:D5:2B:59:57:A6 (Static)
Reason: Remote User Terminated Connection (0x13)

Here is Pauli Virtanen’s analysis and solution:
https://lore.kernel.org/all/3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi/

AFAICS the bug appears to be:

- bap.c:stream_disable() should do nothing if stream is
not ENABLING or STREAMING

since it's called from bt_bap_stream_disable() which is called on
transport suspend which should be noop for BAP server if stream is
already gone.

Next, I will attach the relevant btmon trace to the commit message.
>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Optimizing the code
>> - Link to v2: https://patch.msgid.link/20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com
>>
>> bap for big sync lost
>>
>> To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>
>> Changes in v2:
>> - Add state check in stream_disable.
>> - Add type check in stream_io_disconnected.
>> - Link to v1: https://patch.msgid.link/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com
>> ---
>>   src/shared/bap.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index 40e1c974b..1790b277b 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -2131,14 +2131,20 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
>>
>>          ascs_ase_rsp_success(rsp, stream->ep->id);
>>
>> -       /* Sink can autonomously transit to QOS while source needs to go to
>> -        * Disabling until BT_ASCS_STOP is received.
>> -        */
>> -       if (stream->ep->dir == BT_BAP_SINK)
>> -               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>> -
>> -       if (stream->ep->dir == BT_BAP_SOURCE)
>> -               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>> +       switch (stream->ep->state) {
>> +               case BT_ASCS_ASE_STATE_ENABLING:
>> +               case BT_ASCS_ASE_STATE_STREAMING:
>> +                       if (stream->ep->dir == BT_BAP_SINK)
>> +                               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>> +                       else if (stream->ep->dir == BT_BAP_SOURCE)
>> +                               /* Sink can autonomously transit to QOS while source needs to go to
>> +                               * Disabling until BT_ASCS_STOP is received.
>> +                               */
>> +                               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>> +                       break;
>> +               default:
>> +                       break;
>> +       }
>>
>>          return 0;
>>   }
>>
>> ---
>> base-commit: 55a6763cde8a2309fd23a96479ee4cf2fc23a442
>> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
