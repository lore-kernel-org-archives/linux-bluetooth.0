Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021095.outbound.protection.outlook.com [52.101.129.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE854F81
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651229; cv=fail; b=GqY5xeQ3GCQpP9jO/5d2zFg1bPvnTIARurqQJeSkCJGk5bPEAgWCG1ksOz+BGjmErCTnfzHPUMyNHBRL4b1e29CZXlRmZl/vko2jN4sSclyRgzAjTPjZ+b+xRv4p0FFBOn96gMgPCb0lmj51eKT53jVZeerDRlbeAYJopHIjGJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651229; c=relaxed/simple;
	bh=mbL2nC5fiL5DisIc0MDDwUxHZcMk+OLKEIaQcII07T0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gSGvbsrJtMln3vk1OlF+YKAf93R9Us/aE55lubVXkngX+5NIemVXYr+LCuqpDQ3MS0DJpCXw5MoXai0Scz+LPa3tEdTTYz7MO76XOVWqBfrxz1wgypHhCPlcEyoI2a7WtxCqmasYVMz8hJxXLSIPMzk3xpz0FsA1J9tYfszLs9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tqhD8i52; arc=fail smtp.client-ip=52.101.129.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tqhD8i52"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG4z75ysAdAeoVKPJ/a7H3rufGkemD4acOdBaFylIOSBTqd5tK9b3e1yBAi4wFs6LmHtGhbBFB/HrOR3Svyx6Qoevbm3hsji01l4+c6sqWjA6ETGENHPxWqUqZ+8RUkUr6bDIe/widhITCttviqMj7FGiSCdLNR76yDH6IrP8iJYds4XQaHJeDCQZvq/BlRarJL+hugCyfuwzkNW/5rb7zXkgc+SYWj3BQ7KI22v9LLP1GriFvgTzjBGo1uFTO5d9j6uYybs5wzrJKyN6F9IxeNtMT+FM0dciG0lKgsNymZ2GfvzdX4sg1Z2v2j3kEIaiA9vi4aUKFBkP8AN9Mb7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9U0LAYlij/SuPSICaSSF3mc/XqpZYDAmoP0X0MWSLY=;
 b=pBdbAKz0L+E7WlSb5VH7jPUep4ExEzzETaftZa9caryWtO3H9rkisnxLHvONqIKMDL76zxQ+/KK2++s0nO/ywStlA0QB6wEr91WVIrKzdslmuh1cYMQCFKJRTMbkU5x6oTQPfgwH7Gd0Jvb1xeIuQQo4e8DMsLi7f/+7IEmA+JVa/EiS3Q81FY8XCPYHW40QzAAvzXaELDddWHub1dE5oVoDWerwf1om/0LfLBOV6b3yxXUcSClDToyi6ZxPP7WBF+yh5M1+4OjpHUFNQXSNkN2Et6PAuIi73MIwX5yCxW34qGYp/rGkuJbxPyaD7YP409C3gH/B5EUXdXLHL4WBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9U0LAYlij/SuPSICaSSF3mc/XqpZYDAmoP0X0MWSLY=;
 b=tqhD8i522RPhmX0jMEzqsz4J7+dsqO6P21OvejMFYW/StTm+6JHz/3vOWZTfcKlfqHTw2pKfdtgmEv9OVqyKDSRMQvacsUhKFiHo36faexqP0hsPkQu/Fd/2V6UftYbeOW8uNGDDH1rpxvW4uBMMg3cRb6Vow0F+aVJPxHiJfFbdyCWGZdZFbQNEIzbkHNfdRA2NP+6rgm6tgGaLoV6MjYvsaZ/LdEel6Sz0B5/fYpCFDdGFbLvSeVjHqM4vFQjad/TZS5qE5pGpr47aegWRmJ8JsVIkZ8ubq2OYwd3Wfl5WdbzryLCRiH5nlpIb6KIND4HTG6FOHXpxXzDGHX8j9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB7534.apcprd03.prod.outlook.com (2603:1096:101:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Thu, 3 Apr
 2025 03:33:40 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 03:33:40 +0000
Message-ID: <8d77a6bf-096d-42c8-86fc-42b9dd6844c6@amlogic.com>
Date: Thu, 3 Apr 2025 11:33:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] bass: Clear the temporary flag of the BIS
 source device
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
 <CABBYNZJB4YJWyLBc9p0HDkY0cEpkLFj4ZRod0sDJXvmnWNx91g@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJB4YJWyLBc9p0HDkY0cEpkLFj4ZRod0sDJXvmnWNx91g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: eed341e4-a68d-42b5-0a6f-08dd72605373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1phYXFxNmJxUGJPUWRzR3B4aUpEcTV4UVdkSENCMTZ6eDYyRjRQUTdCNHY1?=
 =?utf-8?B?bjg2ektRR1puUWZzNlFOOW81ZDV0dGVsMG9MN2locWNScE5ZNjNZMk9ralZ4?=
 =?utf-8?B?UWp4ZHU2dnJVSU1jbS8rZWw2VkwzN29ieVN6TUxnSnorOW9YV0lkQ3dOUE1P?=
 =?utf-8?B?QUFRNFdnTjA2cEh5N1Z6Q1J6TG4wYjZLWnVRRXdKSGJ0aUk3KzdlT2tqc2lQ?=
 =?utf-8?B?YUVuaVFONGg3R0FLMFB3T0VPWGVhZmJmTlByRWtzUW92N1FrNGxNR3RENkdo?=
 =?utf-8?B?M0RMb2ZIbFcwNlVUY2g2QnVJdTFrOHFYcDZySktJZkJQMDdjdEhkVjVLV3pP?=
 =?utf-8?B?TFVsSE5yVFR4ckhZME12aC80L1JacEtnSkt2RDJxR0VZRzllM0dXNGNoK3JN?=
 =?utf-8?B?c0pmbEdQdENQT3hYd2F2dDY2VDhmcXp0ZGhlYjQ0NFJSWmZTaUZFNzdDU09X?=
 =?utf-8?B?U2hEcWx1UnY0VnlGOWNjdjNERXo1ZG1sN3NSbnQ0ZThYTU8xdCtNQkV6eVNN?=
 =?utf-8?B?czhvUTQxRzdRWnp5eVRLdkpLMklzbWl0RVJVemM4Z3lCMThqSEU3ZGNYb0lI?=
 =?utf-8?B?b3dkODVaMEVaSElBbCs4ZTUwM1llR1d1L2NiM3VpNzFTOFQwRHB1ejdMZXFk?=
 =?utf-8?B?Z3UyS3FjZGFybjNPYjdIZkt5S2NLNjgyTmlmQStqV3FnN2UyWTM3RmtxMUxh?=
 =?utf-8?B?TnB0aEtEZDVCZWlqbTAzdmtNcjZMd3huRi9zQWRBeE1tVC9oK2ZRSGZsUEEx?=
 =?utf-8?B?OU4zdElTcEF3ZGxpQzlYZzVBYk5zalFFdld1eTV1ZVVTdkpESThaSDNlV1Jk?=
 =?utf-8?B?cW9PMy8rZjZnNFVySmxRZHFLVXJCNzd0NWE5cjFuYTBMNnQxb1JPWms3SFov?=
 =?utf-8?B?UTNXeW5RK3VpUFkvaklEOE5zS2x2VmlnQVNhRGhiT0FUVW9uU0JpR3F6TnNo?=
 =?utf-8?B?K2JKVThYQzBwd1RERXRpd1o0TWNIZHVVd2lLSGMrK1JPQ09yM0wyenhWMExw?=
 =?utf-8?B?YzI1b0xYc1ZRcFI1RjEzckJlZU80SmJ4eUVjQkpubXdFQU9RVmdwUVB6ck9j?=
 =?utf-8?B?OXA0emg0a2c3RTVJb01ZdkRMQTFHbTVvU3ZMbGt1NXZYVWFyRVVpQm1vN0gw?=
 =?utf-8?B?VHZPYk5EN21wWCs3QndFcHFRS2NqZm1kK3h4bGhOR2w2SFpqY0FVZlk0RVhr?=
 =?utf-8?B?UlJWamJITm45dXJoSWJ1UjE0SGJOMm1xa3MyUGxVWmd0OUtPcGQ3VXllOFda?=
 =?utf-8?B?KzlDYUlaRVhUNElMaVoxVkJScy9GcHdoME5sQ2NzejZ5U1BDQkovWklqbTlk?=
 =?utf-8?B?NldqUEJTdGxLWXJsQmFlVjRYYU5RUWlFUWJFZVlESk5NUkhzS3JrdXY0WmFz?=
 =?utf-8?B?SDNjU1pxYmlOcXAra0JPVFpOeHNwcmx2RjY2QjVlUmVpL1Y0RUY3M0Y1Z3Q1?=
 =?utf-8?B?REdYdVJSWktER0VzQlhzeXpsaE1QYnFvd1lWQW11TnM1Tlc2NlczZE9Kb285?=
 =?utf-8?B?aFRnRG01d1pURGF3NDZxZ1BBMGxHbUM4Uk52UE90S0VHWVlFRXh4MHFDVDF1?=
 =?utf-8?B?Q1o3LzQwTXpxT0dyUGJZaVp1cG50RE1Rdk5NZzBsUkN0eUVQSktrOENoRU1z?=
 =?utf-8?B?dGFqVEh0ZThLQVM1TGdpZTF6NG1LbkgyVEJMTDJFRmNzc0dQSndpNExuYS9x?=
 =?utf-8?B?WmJla3lveXhOblU0TGZ3Yi8vb0lOL3hCbVcxZnp5eWhxTFFxblR4dEpCZSsr?=
 =?utf-8?B?cGRYRHVlK0x4TjlZMFlMWlB5UEVEWHFpeE9DNmxGMktBQ0dlV3VzYjFiYXFa?=
 =?utf-8?B?VXhxK1JoWVRLY0s1Y3hQUnBSM1daWjFyOUpYeVZzYzFhOGtDeHVUZ0RsSWNL?=
 =?utf-8?B?bEFsRXJSVGx0SWRma3B2YzZ4QWtsWWhiM2xXUDFyakpjK3ZUaWVFR2V1cXBw?=
 =?utf-8?Q?eOAeRQRA1TY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUN4UkRzTkkwTU5TSzNGQVZianhGWmVENTdOSmtEZ1dzTVAzRHkzbUtMNEd0?=
 =?utf-8?B?TGVoRXBKS2ZWVkRlbWVJVDhtQlNYczhpcFhNb3V6bzNBZmRpQnF3OXNYVHlE?=
 =?utf-8?B?d0tmTkRGSkdoUzFZbHF5cXJRdzRvNDdwdm5nejV3dmJmMlFLTHB5RzFUSkhD?=
 =?utf-8?B?M0R3Mk1YeFBvUzVhN0Y5ZUxDOHNsdVZRSXNnbE8rSnl0YjFTYVJpV3BxS3ha?=
 =?utf-8?B?K2lxS2hIRjZlbGVidDhHcWlubXFoQ0I4UlNTSUtuU2E4V292SDhEaHJuUEtw?=
 =?utf-8?B?WU8rbmlOL3hTdmI0RjVhdGVjVFMvZFFCRmJNVUMwdXhSeDg5dTZEeC83aWhJ?=
 =?utf-8?B?dzJsTDhFQUs0dUcyRXFmbTcxdUJjeUJXRWxQVVdmei9yYzhzWFdQLzBoYjRI?=
 =?utf-8?B?T09NYUl5clNyZXlrZFdHeTlkMnZlL2owdmdXMHBIS0xtYklRMTNxUzZ4blpY?=
 =?utf-8?B?SXpXcWl6bHhQRGc0R2g2VW52N0RLQ0JTcmNMKzR3SkloNlc4R2VObXVkVGJU?=
 =?utf-8?B?UjRTbkpOM2RYUTZWUldIaE1iS1doYmQvbk92YjdLLzhITU5zVzQ3Ym5hTmp6?=
 =?utf-8?B?a2g3bGpIMEczdzVtRWtoTjNKZHoramVROFhxeFYyaDVBNHZIWWZySGZTWGRD?=
 =?utf-8?B?VVdIdE5tSk5QdzJtallVUTkzUWlZZ3BpeFh2dHBaZnpSdTI1TGE0ZzZwNXYw?=
 =?utf-8?B?TE1iWmxLUlhkaklaektPbmdzUm5JOVdaUGE3R2dYb3lJSEhYOUdSZlBaZ1p6?=
 =?utf-8?B?K0VIVjR3V0J0ODVOQWszTGN5Ti9Dazc1WHM4TDYzMHZzYVdCcytLaUlLZDNE?=
 =?utf-8?B?aU13bForaWt6WGVIQXNtK0l3SDI1NXlSMjJ0dUxBQXptb0ZEb3BqRkY3TUZ5?=
 =?utf-8?B?L2Ryak1ZdTJvZURFeWh5OW5yd3l6VURWSW5XN0VmdEp3ZFM0TndXK0FsWHhi?=
 =?utf-8?B?bTlZVGdXYWVFbDNWeGVDZCtHbTVPRG53N2xDRCs4NGxoQWVVWmxaa1ZDT0Rn?=
 =?utf-8?B?Z1pRQ3VTVllKYVNpcUJ0Y3hEZHRSQjUyb3k1UGZ0Z0lZSUd3Z1VKNjBCaEZS?=
 =?utf-8?B?cWh6YThsT1ZWQlIzbXFlNzNMdjFnaU05VlhzdFh1R05HdXNhYzBYYi9zY1la?=
 =?utf-8?B?cFVqT3VJWVN2cEN6U3JFUWh2TXN3SXJWVGZYNlF6RjIyUW80VFZINnp3RStD?=
 =?utf-8?B?NTB3V2pDUFhLUHVWUmEwQU5BNUVtU05hTjNkVEd5b3lDcERCbFRSdnVMK0Zk?=
 =?utf-8?B?UllJSkZWeU92U2dzaUdkc3oyWWpKMHFiWlVBZ05RbFBTWWR4cVFGL1hZWE5B?=
 =?utf-8?B?WC9CdU5MUFBFYlA1OU5xcGNCOUVYbzlHdnlnakYyeDFsNnJ0WUJPQ0pNdE5K?=
 =?utf-8?B?MmFEN2drQzhrN3BqekxZWWFRcnM2MjltS08yOWcxR2FXNmE5SlQ0ejVpaHd0?=
 =?utf-8?B?OVdpcXFhQzd1ZzNCckRpK05rTG00UlIrNGRSNkxmSWlrcStPOXpqN21SWGNi?=
 =?utf-8?B?bUlLTGhnUEJqdEdBVjl4LzhzSS9YZWlpUmFybXYzam9hTWFLK3htSnRaNFYr?=
 =?utf-8?B?NHlYNlJVakZSN3laMDc0UVI4cnU0SGJIcHV1M21XTEwyYm5ycWNYeWtBUDN2?=
 =?utf-8?B?MEFjOVk3dVVzdlNKaHNEaTBGZWhrdmc5Zy9jU0g5a3YrRkJKdlVldGxyUkF1?=
 =?utf-8?B?aHRKVlVZa2N1YUkvZFV3ZVl4R1diNkFmbUFkMVhpc3JnWHpRbnBDT3NCVVI1?=
 =?utf-8?B?SUJ3ZUFTVlAxVFpWNm1XSEZGV1kxNU0zV2tEMFlEblpmUGdvLzJyNUtOOVFE?=
 =?utf-8?B?SDZxYUViUmJBTVUwb1BGazRObWVQR3FNeVN2dlVPZXhycVpFd1M3ZVpQNTZq?=
 =?utf-8?B?OTdzcUc4UUhnOWJjQWlBRERURjN5NVNMZmJxd2R3OVlYSG9HbHdEOWozZm1o?=
 =?utf-8?B?bjdOazhxUC9VU0xWNHZ4QXkvQ0d4VEhkVE9GM3R6UEJ2M2VhbzNTR3V5ZFhy?=
 =?utf-8?B?eFRkcGg4N25qeUEreGZKRGU2VjdJVWVtWnh0NjVmT3ZHRk9OYnF3dW9oNnlE?=
 =?utf-8?B?U2ozRlBqNEw5MzhsdWpyY21WV3RmMlhNRWNGaDJrb1pPSGthcklMc2JGV205?=
 =?utf-8?Q?uesob3D7HeVdkd1D02Hp/JbGm?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed341e4-a68d-42b5-0a6f-08dd72605373
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 03:33:40.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qQadOmWzhewPLiuvFDWKTzXXlvzrdgphxQdPyKHv8SSAVLb5J/xOihrMzXmT1yO14UU4jhoYKCMcWH+tyRU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7534

Hi Luiz

> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Wed, Apr 2, 2025 at 3:33 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When BIG sync succeeds, remove the temporary timer. Otherwise,
>> the device will timeout and be removed, triggering the automatic
>> termination of BIG.
>>
>> issue: https://github.com/bluez/bluez/issues/1144
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   profiles/audio/bass.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
>> index c36f43277..99f1decce 100644
>> --- a/profiles/audio/bass.c
>> +++ b/profiles/audio/bass.c
>> @@ -565,6 +565,9 @@ static void confirm_cb(GIOChannel *io, void *user_data)
>>          g_io_channel_ref(io);
>>          dg->io = io;
>>
>> +       /* Clear temporary flag*/
>> +       btd_device_set_temporary(dg->device, false);
> This is not quite right, we shall not persist the broadcasters, as
> they are likely not pairable/bondable, that said the device shall be
> marked as connected which would prevent them to be removed. That said
> we should be handling if the service is marked as connected:
>
> static bool device_disappeared(gpointer user_data)
> {
>      struct btd_device *dev = user_data;
>
>      /* If there are services connected restart the timer to give more time
>       * for the service to either complete the connection or disconnect.
>       */
>      if (device_service_connected(dev))
>          return TRUE;
>
> And it looks like that is done in iso_bcast_confirm_cb in bap plugin
> which calls btd_service_connecting_complete.
>
I tested it with a K70 phone as Assistant and another Android device as 
BIS Source. After the Assistant added the BIS source information, the 
iso_bcast_confirm_cb function was not called, but the 
connect_cb(profiles/audio/bass.c) function was executed. In my next 
patch, I will add btd_service_connecting_complete to the connect_cb 
function.
>>          /* Update Broadcast Receive State characteristic value and notify
>>           * peers.
>>           */
>>
>> ---
>> base-commit: 6d20a300642f312290af0bc9869a0e1b416c58dc
>> change-id: 20250402-bass-66200bb7eba1
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
