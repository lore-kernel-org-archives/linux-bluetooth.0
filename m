Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022086.outbound.protection.outlook.com [40.107.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551381F8691
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409707; cv=fail; b=H1BIuqSLtyXzXsFwwNaHeCo6xtFo/3aWNHWhX07fkfSs5XVrZUeoGz4z6gz5Aql5Q3ai7VAmFw9wEJu77TwjDESBHm5U9R7UIxoaC7e+ahNpxGCSn0t0v04Crps479W+QTQ6wsPwOm5vdpC9mPowmtA4nwTk2a61zYAQ/8osGxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409707; c=relaxed/simple;
	bh=Q5XmiGItEet4IAw6xgQExBXWP+uYPUzGK+uwhzgSmzA=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJqfydEKqVzEIfssy4VtqVCw8J+MJ7kHxYJSqTgKegpqO1BcMdG735jgzITMe28p/FaDZ80dAo6fla3I4FzKqvWtCl456+gbWwCJ5Yoe4sUf+Be7tMgGOWf8faecsLlEPYFWNk3QzIZzRMuSqqZGWPMOGtsJONGswzWawBjmGwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=vWYTRiUs; arc=fail smtp.client-ip=40.107.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="vWYTRiUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH7BW8KP9zPU7I05C9hXBzYQUqVYuUVbbKZCOvrn+axlVwlExSJc014wriYYR2fZLzY8jPUMb79jhL/8gvp6VdXEJny+oRFP+qmqfPi6m7wBzU6fbKNamjFSuCyAHucXboVW/v3ayojhtnVQ+CT+tcQ88RbUYamkra93SeEPtbIwra4IsBKFm0o8y1F8zi9FBnnsclOPhh7BJQCrwTEoJsNDzRKiXOw+mt8rBhP00BsfWqx7bQnGefr2U2Z/VkZRYJKATaykwh5UYGKYnqkWVyU1WY2413Si1rNiJj2H+SAlygZkKdBirXAyEdWuYtTeoabFa/dthC74iUDvZDIfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BfIsx/59M5HP090mk46Dafn27rXVOlWNPtE+SLz8Qw=;
 b=SU04sofJsx2iassRKQ9T6ksYsgsI1VY3BZY2jx9TkKU798Bf7fXnYeRw6aBIRGpY02WLNMk5IDkvJG1K6Wt1UHh/yhIQsFMbhLqok/IO7mqZ0AAZpu7MG6y4Fdl/qWuK08ZJMx8Fd21jT68MatW6q4FIw6WcHgeSULWO6ZSDX3bRqrPp3iYrvlBvxlhxB3p1p/IGqegzaxLQdamniYz5spFg6RJSk6VD8Bqx17V33hGMNIdtZKM1EyGKZ4obD0YtnmmDZBo+y1pZmBmmB1X4GTwS0vdU6H9/NJbQemO3IMgP3synB8o8dlvuUL0nNjmg51h8r260n+fAnwc/h5zcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BfIsx/59M5HP090mk46Dafn27rXVOlWNPtE+SLz8Qw=;
 b=vWYTRiUsGz+wymLzhISAVtyT1a/FoLTBKo09BTgTGGhRVfMhuKEgUueYzFNwYclQzwJpyws6xy/LxKBukUYp8U0wbhXFKyL26AJ/pk9PSKzOSj3rOk/51wKDB1k6Q0yU+F3gvmSHZf8tIniPb7I5w2No17FZPhDkVBCLpYg5yKURnyVlT3SnylaZ5L6a1hDIa8TjHw2OTT4bD0afGFg+Ebs6U98T0fM8Wdx5jab0yiohgh0oR1WjUgNKG7kDRe8hv60c9/IRxsHnQOnhAcmSFnuGaL9h71qFkWPvGFZ+np7lP8nEmAIi1x3wmTYCouMKYBuzwQRctXHW0GkhePi84Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by OSQPR03MB9372.apcprd03.prod.outlook.com (2603:1096:604:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 05:21:36 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::68e7:f16a:544d:2ed3]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::68e7:f16a:544d:2ed3%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 05:21:35 +0000
Message-ID: <bff9098f-ae62-4d3a-8241-45b833055827@amlogic.com>
Date: Wed, 28 May 2025 13:21:09 +0800
User-Agent: Mozilla Thunderbird
From: Ye He <ye.he@amlogic.com>
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix not handling read offset
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20250527132831.232633-1-luiz.dentz@gmail.com>
Content-Language: en-US
In-Reply-To: <20250527132831.232633-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|OSQPR03MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7f236b-1699-4e90-6dcd-08dd9da783f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZKVTFaR1hubXNyKzRuMDBBSjlKM2NWUTIwcklpYlFqNVczLzdDWkJPUkZZ?=
 =?utf-8?B?aWRMMURnWDIzcmpmZWRtUi9aUm82UTRMc3djZm5PRFU2dEFqREFHN3FHajlm?=
 =?utf-8?B?ZjVLQTNwRXY1aXV1M0QyeVNoNWlHVkZlcGVORS94MFMxQ0p5YUtwOWwvNXMv?=
 =?utf-8?B?NTdjZzNuZE9naERidDU5V3NoY1dDSEVlYzNqWk1YN2FvYi93ZVkreXJwQ1Ju?=
 =?utf-8?B?Nm9KUlA2b2JSdHhSR1FDaVE1bkdoaUkvdVRLZXFpQXlSNnJJV040Mnhwazg5?=
 =?utf-8?B?ZWhmN01GVVgwTDRpWkJoY1kvZ2o4QjFadVE0dmRUM1ZZNy9qU1ZYUllET0g4?=
 =?utf-8?B?dElYZ290M0FqYUp4Z1RhcE1NdVJWbUg3bTZaOUVWa1REY0tFMDNzaWpWSFdw?=
 =?utf-8?B?R0JIZndvSnFWZk1qdEJhVHIzZHdMOUZ4ZE5PVWVPM1hvNGoyQWpUWDlHZjI5?=
 =?utf-8?B?MjBzTnVTd3pKQU92RkJTT3o5Y2xHN2tFcUlZTU9QQ2hwbVVJS01MSW56SGhX?=
 =?utf-8?B?TEpRTXUwRXBvdzNYYTNKWUdxWGNBdG9GeHpsVHRibjIxa0JnM1R3ZDFONjdk?=
 =?utf-8?B?YkIxZGM2dmdkQjVqalYwZ09zM0tmZFBzRVV4SlVWdVVrQ0FQdnhCY05PY01R?=
 =?utf-8?B?NUpoM09TRXFsRnVubG1PRDJVeENjeWphY2p2dk5LOUZESThYMXg2VG9uUlRj?=
 =?utf-8?B?a3NUNzU0N0d5TGt1b0pzRnFDcFF5bko1T2UrQlA3UFV1T1hEN3MzQWdPYWU3?=
 =?utf-8?B?NnBJWDNITUwvQjNWNzc2WHRIcFNEQld1Unp3RVc5OEUxcXEvMjZhdlVjUGVC?=
 =?utf-8?B?NkdndXVmV0RkbzZMckRqeWExV2NKS2k2S2RSUHpWMk9HeWlaVU1iVmt3TWQ1?=
 =?utf-8?B?NEJkSVZaRjFBWWNTQUJNdFdDQm9lbmlLUExldmdwd003a1B6S01UUVNsV0pp?=
 =?utf-8?B?TExCOVRiVXA1WFZpc09UQzBoOFNnTU9STFIzeERMdCtHUy8vZ0tuejl2WTBq?=
 =?utf-8?B?cjVDalBsZ3oyVytmZjg2RWVBVTdqRktieDZrVzZtbzgrbFQyN01STzBPdDhU?=
 =?utf-8?B?ZjJCZFdaZkJBWkl5STlhcmh0OWJjSHk3MWR4d2dQam5Vcklpb3BvVUlYSE5G?=
 =?utf-8?B?Qjc4SmdIdHlZYUJhLy9neGxyQ1Y2T2d6VGxTMUdob3hTclMyWWd6WGFacjdN?=
 =?utf-8?B?N2dUbWt0cVhBNEkveGFYK2UveTM1ZDM1dGtuNVhjUXYzM2tQYWFBcEdOZkhi?=
 =?utf-8?B?aVlYc1dBbHl3YnVMNjlhaTBQRmU5YytxOGpQNXhJTVV3UXZTang3Q0wvdG5C?=
 =?utf-8?B?VjgvL2hLaHUwSzZBdnBMVy9TV1Q4ZFhURnNocjkrT1R6NllRT2Q1UmpoZWZK?=
 =?utf-8?B?VU1JcUJRUjMxOEVqdlpYOGk1MXdWVkJGV0o2N0YxVHpoMUVvQTBDZHRWbHNa?=
 =?utf-8?B?WVlVc0ExOFg0TDM4TDUvcHNCaFVxdlFwUFBmR2wxOVlaUmFRSXpPZmJRVEF3?=
 =?utf-8?B?dE0reFkzelkreTBYK3ZQNXI3L2xaYkJTODY4M05US1kzQXl2NHVKTEtEejNv?=
 =?utf-8?B?cEsyTlBFTDRFTXNPVHhHOVdlUWpsWFZ2MDFpaExDWlVQV1VlcUoyWUliVGlT?=
 =?utf-8?B?YkNBa3pSL2lBK2RMSmFBSytjYVRMVlJPSnB4Rm1vMEFHclZHR3BGYVFGSXlO?=
 =?utf-8?B?RGZmc3o0TXArR1BKWUllYm10T1dKbmtITHpyNngwNFZhRzZVbGZ5Uk1XME8z?=
 =?utf-8?B?ODhkNHk4Y1hNTVlvTm9xckMxWU01MSswTE9kSU1OVkxtaDNHRmY4YmhBckdo?=
 =?utf-8?B?U3ZnYWNMdW96QnYrdUlURVFqcitOY3k3WnFQT3ZYZ3VxT0NKN1ZNL0JBcDk0?=
 =?utf-8?B?MEl5QXJtcTk0MzJPVjZsU2x4WGNkeExiWHhrSGgxaUxvc1poeUlaVURoYlZN?=
 =?utf-8?Q?Ex+hxAjgzVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M09NaXBVN0Z1Qnl4MXM1WldETm42Q01FbzNXRDU5RlFKWEZ0NzJsZVQ4QUx4?=
 =?utf-8?B?bVNIZER5TURaNEVSaFFMS1lXRHlYdnErT3BLWlg0U0VzSXROSW0xUHRlSGZs?=
 =?utf-8?B?WTJsc3NPRzJhRVloMVJRUnlpeThsOGdVUCtDQ0Z6WW1aSVJRbDBVbURTakg0?=
 =?utf-8?B?MnRocklWR2RhRVQ3QXo4ZVR4WlRGUDF5bVFqdWRvMmZQZFUyZnIzK21iM3Z5?=
 =?utf-8?B?VXkzNjJxV2Y1VjhlTk4xLzJlL20rZzBkN09HY1BTUmVXMXB3dGhVUDlWbzYy?=
 =?utf-8?B?VW1kSVhCekhGV2Y1VS9TUXplNlcxQzdQS3hZYXNqRHU2VllWQzZrOXZNL0Vj?=
 =?utf-8?B?L0JGRVQrcGZRSEV3MVZNaXdLbDBMWW9sS0c0bmxKQkZsdEhHQlFFcnNjMTV3?=
 =?utf-8?B?SnJYR0hMRzcvMmtnSzBxdFVVUENxYjk0d2p2TGovTlJuSTdFc2lxOHdYeHNN?=
 =?utf-8?B?U2dnUGxrYkFUUCs0Y3VtYWY4dWpGL3QrSFdZOFo0eEJIYkViOStjYjc1VklR?=
 =?utf-8?B?OHYwRTFrNjA0d1g3UUtReENSKzg1RU5Wall4TFErSGNLNE1MMmdQeHZDWjUv?=
 =?utf-8?B?VVRWVWc3aXNDSFJ2cnVTWTkvNVMyMzd2ZDRZZ1JYLy9ZdzFpMXA4alhqM1dW?=
 =?utf-8?B?SEdqOVlUYzFMcmV2MFBhVFdETE5meHcwMERWSWpvR1RuNlNUM05uSjNPWlkw?=
 =?utf-8?B?U3VRekdmRGYwblNmQzBDc1k0U21DVnpieVhtOTZUbktMa1ozSUdwSVZIbEdP?=
 =?utf-8?B?aGJ2dFgxcXRyQVd2eGt0YlNNbVpuT1NvZ1YvMXBJOXRXenk1em9HcVpoVldy?=
 =?utf-8?B?NnpjVkU5YkJRUzc4cmUrWm5DbXBxZk5VNG1IRldzQVV5a0FVQU0vWSttcEVm?=
 =?utf-8?B?SHo1L1dQRkhCTXF0NHlPVVRpOGlNaHlaUENGdEt5SmFLRnZTRy9WcmVLUjR0?=
 =?utf-8?B?eTJiYS9vZHBVVXBZN2dtVUIxTkNJK3ZDRkhiM3ZkNGhhNHBNWWl5bGtkMWc2?=
 =?utf-8?B?aEQ5MTAvZWYxb1liM2p2cVg0cFB2R0ZrdmRLTWY1eVZRTXlYVjcxU3FRUzFR?=
 =?utf-8?B?bWh2QWEyMVZDc3c1dGorSzJ3Yi9ZUVdES2dSNHc1N21GZkJRSlRsVHZ0QkY0?=
 =?utf-8?B?VDdqVE93bDlPWkcrMFdwd25oR2d2S1dxKzlXeFFhUnZ6MEs4UlRaT3d5M290?=
 =?utf-8?B?cWhIbWtzVHZnOVU3cjlaN09sKzFMRkRaajdjb0hiNWVnbkdvaWo5Y0FvdUVi?=
 =?utf-8?B?c0I1ei83UWJOWFJuUGU0alhWL1o5dzkrczlOU3Ivb1JESUFmUW9QTVl5cGoy?=
 =?utf-8?B?WTRrMGsyNHh5TFI0RWZYUTVMbm5qbmEvZTN3ZllidFFLUU1sTStaZ2RTTWs5?=
 =?utf-8?B?M04rVkcyNWhWSzdQSWpjZFhhcjVjbFpPTHZKeEthd0QyeFlRaEVDbXFzek5p?=
 =?utf-8?B?Sm1RVG1URHZPWjdubzlBSGp1U0JKdEFlTllYbGdaMW9sK0M0Nnp6ZGxoVjdj?=
 =?utf-8?B?dVZ5RWNBSEhxTXJkQllYVmNzWUhwbngvNE1oS0w0ZE5zWHc3a093eGF1NUNB?=
 =?utf-8?B?SGRXSllOOUtTS3RwRHgwMWp0SE1seVVjcnhBQytDcmVXd0ZUeWlodTh0b0Ix?=
 =?utf-8?B?R29VVmtpbEowTUtuYXJOZDBESUwxSzJQa1lmWW9MdGJwbytjcDlPcERVODRx?=
 =?utf-8?B?R1BwVGU4VDJ4VFB0NHNwK2h2Y1I5NmNhTGNyd211ZXVad2RjQkFxYkN6eTlB?=
 =?utf-8?B?aFN2RDdpNWdXdjJQL3F3eWt4YjlPYTRzTUZhekJqQTZURmN2Ym5ldEo3RW5x?=
 =?utf-8?B?eUdsWkFpdlN0RTFSZmd6dFJkbHE4bWRNREpWY21ENkRMNCsrZEFORXN2bVht?=
 =?utf-8?B?VXk3RDY4WXBZZmVYSk9wekN2YjF1S3dBdTVRUURQd3dtVm9RNW5XaG1jNm9j?=
 =?utf-8?B?Ni85WWlRblc3V2JzcXdBM2lERk9PTUtsckpPUERhSk1oZlVETUxEa3VnOTN5?=
 =?utf-8?B?dUxpQXA0WVpTeWFJQ2R3cytNQklEcTNOenBOckVJajhjRGpMZm5BTmlrTU9Z?=
 =?utf-8?B?MDZPTGIrclppRm5RNzhiRW1QOWZHY2xrYldNNGJBUjByT0o0eTUra3V5MXlt?=
 =?utf-8?Q?oU6K9C0D70Sy1007IgvcuI61F?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7f236b-1699-4e90-6dcd-08dd9da783f0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:21:35.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 521dZ1sOVEVwscQpxW25ztcOb2IETLsaYYHkVbM1vKZO4yLj3ae14WbdJbg+h+gWmKhIc+p9Mila9CBisc68NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB9372

Hi Luiz,

> [ EXTERNAL EMAIL ]
>
> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>
> Some attributes may need to handle offset other than 0 in case read long
> procedure is used, so this properly handles that for PAC_SINK_CHRC_UUID
> and PAC_SOURCE_CHRC_UUID.
>
> In addition to PAC record this also uses
> gatt_db_attribute_set_fixed_length for attributes that are considered of
> fixed size so gatt_db can handle offset directly.
>
> Fixes:https://github.com/bluez/bluez/issues/1294
> ---
>   src/shared/bap.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 4bb6e08b5379..f0c6f64855c4 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -516,8 +516,15 @@ static void pacs_sink_read(struct gatt_db_attribute *attrib,
>          queue_foreach(bdb->sinks, pac_foreach, &iov);
>          queue_foreach(bdb->broadcast_sinks, pac_foreach, &iov);
>
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> +       if (offset > iov.iov_len) {
> +               gatt_db_attribute_read_result(attrib, id,
> +                                               BT_ATT_ERROR_INVALID_OFFSET,
> +                                               NULL, 0);
> +               return;
> +       }
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base + offset,
> +                                                       iov.iov_len - offset);
>   }
>
>   static void pacs_sink_loc_read(struct gatt_db_attribute *attrib,
> @@ -549,8 +556,15 @@ static void pacs_source_read(struct gatt_db_attribute *attrib,
>
>          queue_foreach(bdb->sources, pac_foreach, &iov);
>
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> +       if (offset > iov.iov_len) {
> +               gatt_db_attribute_read_result(attrib, id,
> +                                               BT_ATT_ERROR_INVALID_OFFSET,
> +                                               NULL, 0);
> +               return;
> +       }
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base + offset,
> +                                                       iov.iov_len - offset);
>   }
>
>   static void pacs_source_loc_read(struct gatt_db_attribute *attrib,
> @@ -627,6 +641,7 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
>                                          BT_GATT_CHRC_PROP_NOTIFY,
>                                          pacs_sink_loc_read, NULL,
>                                          pacs);
> +       gatt_db_attribute_set_fixed_length(pacs->sink_loc, sizeof(uint32_t));
>
>          pacs->sink_loc_ccc = gatt_db_service_add_ccc(pacs->service,
>                                          BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> @@ -649,6 +664,7 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
>                                          BT_GATT_CHRC_PROP_NOTIFY,
>                                          pacs_source_loc_read, NULL,
>                                          pacs);
> +       gatt_db_attribute_set_fixed_length(pacs->source_loc, sizeof(uint32_t));
>
>          pacs->source_loc_ccc = gatt_db_service_add_ccc(pacs->service,
>                                          BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> @@ -659,6 +675,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
>                                          BT_GATT_CHRC_PROP_READ |
>                                          BT_GATT_CHRC_PROP_NOTIFY,
>                                          pacs_context_read, NULL, pacs);
> +       gatt_db_attribute_set_fixed_length(pacs->context,
> +                                               sizeof(struct bt_pacs_context));
>
>          pacs->context_ccc = gatt_db_service_add_ccc(pacs->service,
>                                          BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> @@ -671,6 +689,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
>                                          BT_GATT_CHRC_PROP_NOTIFY,
>                                          pacs_supported_context_read, NULL,
>                                          pacs);
> +       gatt_db_attribute_set_fixed_length(pacs->supported_context,
> +                                               sizeof(struct bt_pacs_context));
>
>          pacs->supported_context_ccc = gatt_db_service_add_ccc(pacs->service,
>                                          BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> --
> 2.49.0
>
>
I am concerned about this solution. It can indeed solve the problem of 
using blob procedure to read sink pacs or source pacs, but if blob 
procedure is used to read other services, will the problem occur again? 
I think we should fix the issue at its root.

