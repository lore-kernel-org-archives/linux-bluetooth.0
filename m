Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023073.outbound.protection.outlook.com [52.101.127.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED428000C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690424; cv=fail; b=nTG5nJYvO6I2q5eV8VgK2CWZVJ3qezJlUhXwP37UVJTF/g0p3hW0dphQcSe0JD/tt8HFEz9VHX3BlvCludgUGIbvTdZwhJ5YNr3j/ZNB0prrrc9a7MaBDe0Nc7hujRewI9oKoFjUkqQZxysh7JVDScwYG81HitH0aT0yFoOfMMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690424; c=relaxed/simple;
	bh=wmEttRW2vuzlx2O7WW2moX9A33J0X1uBypgUErYJ6DM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NtIeLCuqlKx3UtcVN+dFI0ZziPwkkt3bM3w76MenfGhhx17ci3+QOoVprvcyil2Y6G7y4FZeYn7IaxgbbCF0QqQaJ2WGGVLozjvOTTCu2k6xHLIprdls7RAHECwRYitXA5/iMGe5IPo2xPU9TkZJ/lHlLLwiBpHaImYNzQTFer4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wslCRjXX; arc=fail smtp.client-ip=52.101.127.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wslCRjXX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD/SDSFFKLZarcMFrvRum4TdMG/h8AD+EVk7REGEBVqnH1GX+j6U3JbzhBBcLaHf5SE+QDUrr+9J9e6AxEvfwDHF/BoCnvZIuX5B+Ly7cP6FqEdIpMBwJQAFWQQmt2FTgyH3UW7N2HmqW3JeWNMnCYsfEi2JTKXrRYtzI+QwmqzWKCMo7BGY+zFyXFISNhu9vGzaMXAdcFu/GEv2dyCTwvA3dmhNXdPLP1z+5dCo4A1TVPLPsv2mGELNBrhGbPQvqrOQ+mQiulV75l2Q76MfgCG2yZZp0hjfWLaDvagTuWsNn4ZlD7UYvqCO/fvwMxjmXxCKRaV7l9y7xlPyjKIx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJSuvhjQZkj78iMo8lnH9vuSfi1ic/aA4wauPRjcNms=;
 b=m01hzfzkihvjf7GYXX2kwYza+QKiTK03ASNWAmqN+0S2yS0ObR9in9bIvXdjVkRqt1fCEJ+isGluFdD0H+J/zNBZIuvk2Gu3zXMFsAOUA1NbzPumuNwudSKcdZD2DiVeRqMR/CuWRVUZiMo2JCN0kjIyYnqbo3k0MCh+nz/8TdFc529oNLa7nhTwb/RLzfnxcBv3CUgSdObdrAgY7tj3oprrRA0qfOB9c9RqTYos4N3yyiNreCZmyrYmgeUriSCdKQD3cT9n/co4k6OTTVO/hk5XGFp3ilJNx9ar80MaqXDGpiM2X/al0ZNurlBpA2O0/teMcOMe/dENLrRjDs3l2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJSuvhjQZkj78iMo8lnH9vuSfi1ic/aA4wauPRjcNms=;
 b=wslCRjXXvhG5l0clcajsgywV49OYdVLcXIUAOku6Grou6ym0LsiKtS7m0ZLEUY5txVc6Ik9rK6YAypQIpQ7SaEhqqcf3F2gpsCR7TkxIuGXwPvREeq05N2aFpLlJEeaCz0NLg3MMFBtLj2sP5GbHGuY5S3x3hCihcxnVscG/B49XE3pwZ7id4CN0lYYe7DpgUmgldDGys7tjrxuraxUyvmduTnDUGu7GJ/7myTQ40tMJZaykT40GsdrYWIFgbgwLdyzZ02jXF3UGrvvuzPnpuwjufpE6mrteOdgq3s7CaSFTw1cbH9fVgbsKUgf13Np9M8rnJLiF/RKHfTT2r5RpGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by TY0PR03MB8279.apcprd03.prod.outlook.com (2603:1096:405:14::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:00:17 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 02:00:17 +0000
Message-ID: <5ecbcf93-7977-4a0c-b429-f7d87781ba31@amlogic.com>
Date: Fri, 21 Nov 2025 09:59:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v3] bearer: Implement Connect/Disconnect methods
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com>
 <CABBYNZKZ-Y2PqH620t0Tyr9sygoKikeyjdKTVOjV+7LDNxPRgQ@mail.gmail.com>
 <09087c54-4d27-460e-a6cb-ac74833068b6@amlogic.com>
 <CABBYNZLNDUUBj6pT_vgo8cdTb5B9ZDGOdf-+yFL2-h_Y2WANRA@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZLNDUUBj6pT_vgo8cdTb5B9ZDGOdf-+yFL2-h_Y2WANRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|TY0PR03MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c431fb9-c531-4e27-5ea1-08de28a1b7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlY2aTBFR1ZFYVVCNk96R1hkTmlpejZXa3d4MHBUMFQ0WU5iS1hFTFNYQnh0?=
 =?utf-8?B?QlNTajExUUxlSzY5Zk1ZMFVaOEpjZml1ekRZYXFqa2xaSWxMWUdwbHROYkNN?=
 =?utf-8?B?cmpDZ2wrM3Jzbnl6UHpiUXFHejNTM2doanVxSTZpd2RhNGRYQVZSZGQvMUxn?=
 =?utf-8?B?b21lWHFQdUdPamVsWktmR1ZZVTVpUVlMamQ1emw5OGRYclNCaUlhSGJGckVk?=
 =?utf-8?B?d1hRQlplT3pzOEhmWXNSdkJ6VTE1dnZzN09HVHRRbkMyZk1obGJscHNxengw?=
 =?utf-8?B?YThJZWU2bWJaZTV6enlOMm1uTmd4UTNNSTh4M3ZaOXhVbnAzR2JGYU83MFpS?=
 =?utf-8?B?N1hoeW5nbUdCVWdkL1ZGNlNMYTNUb0JaVEJsUUJFdkxQVS9GOGRaSWgxOFR4?=
 =?utf-8?B?Q25VNHI0RDBpeFRNWWtoL1B6NGQ1L2ZsSjQ3MmdiQjAxbkFiRXZRMy8yZVpo?=
 =?utf-8?B?MUVEeHhBS1o1WU9sZkoxbUFXclVZUGEwNjNFV2JFZkdhQi9RamZUcnpGd3pm?=
 =?utf-8?B?MkduYWc4ZVlmOU1VQldsbWFldFBKWVdscnUwZVV3MEpTM1V1cFgrT0puNzZK?=
 =?utf-8?B?cjBLb01yTEluT3ZOdWx6VEJQbUdtbEVqV0hJSmw0RmVmQzRiRHFPOVhHT3lV?=
 =?utf-8?B?Q205Y1FqZW9zSUtHdjBGUmFmbFArYTRrdWpFb1N2T0lWM3pMd0sraEVzWWhv?=
 =?utf-8?B?RUQ3alRsTEQ0clRGMkdESXVTZkNaODJZR1oxSHFiTEw5NG1qVXdKTWMyUXNC?=
 =?utf-8?B?NWJheXhIS0ZTc1VSMWJyK1MzdnpxYXp5dGllaU80RnZJRFVjUVNidmVDTFlp?=
 =?utf-8?B?NHNhQXBDVmJhNXdWM1hDY1UxcGo1S3VLaFQrdWl2aFhRZTE5QitZTDREK3Jm?=
 =?utf-8?B?Q3MvbFhmUDRtQXJPUHhOS3JjU2pJZnZpbWQ1czNWbEpIemc5Ymd2bmVVRkFQ?=
 =?utf-8?B?Zk9mVkVTZ1I3dVZoRXQxaXlaSENvaExsbzh6TVNsa0g0VDYwaGNwakt0ZGJF?=
 =?utf-8?B?WW8yemYzbEh1RlNoWG0rRjBpY0VrSjZtLzdkM0ZwM29DQkxmaGlzQWdiZWpm?=
 =?utf-8?B?V0UrQ2RGUWZhRWREYnE1azF1blVzNStpemVOZXF6ODVKK1ovVktEbVRDTE5F?=
 =?utf-8?B?enJ2QkRXckZNZlpETkF1TnNSWWltbndtNVZXWVM4NllFUGpPd010UUlrOXBq?=
 =?utf-8?B?bHdUeWMxTnExOVVjcVlLYlhEZnBKSDBQSkdXdTl6NmxOTXhVSTFzcTRQOFRF?=
 =?utf-8?B?Mkpra3BYMHFGcmwxSUN6dm8zRjRuelpRemJuMUZnM1pZbUYwWWR6cG4wUi9W?=
 =?utf-8?B?SUN0TUx0WkVKMEp6MkJ6UnJjR0NySGVIblBxVzRPaHd1dTNOakRZR2xFdkZI?=
 =?utf-8?B?dGc1Z05VN0hCTzlzZXJFWTZoa2VkOXB3bHUyYStKVmZCeDlXMER2QWsxVk1Q?=
 =?utf-8?B?UkdHWmxtbmgra3ovekhCenhEdW9rM1VOYTE1OEFCQVd6UlJUaHFuMjhJaEN1?=
 =?utf-8?B?d2dueDFydjhOMG1EYmhwb2ZBVU9qcWQrRUl0RHhsTCs1WmI0WWI2aXZTUFV1?=
 =?utf-8?B?VG01TVQxRXoremMxdGNtVWlNM0JqUm5uQkVWNHY4bUVwbkxzaGt6VHZVUlJj?=
 =?utf-8?B?RU1aVWxTQnNoS2ljOFYrakJrK2tGWTdxNW8yRUppUEhmUTNVZXF2UkpHbHlw?=
 =?utf-8?B?M3drNkIxcVVpYlBVNHhEcVgvK1B5NDFYTTdhQ0VuQ2pvMy92b3F0d083MGlJ?=
 =?utf-8?B?eGhLTTc0bjUzVm4wZkhVQXB5MU8zVkFjMzY5ZG9hWDFwVDE0NlBxS3o0eko5?=
 =?utf-8?B?ZHdMVCt4ais3Q1dzWXI1WTNnbDMwNmxTVXlGeEhmYVJFT2lpTHVrdFRYRk13?=
 =?utf-8?B?a1FreDlPMkZSY0ppdmtmVUtQZlkwMXQwZFIrMWpCUm9uUEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elhITTg0RlpPWE9xWitKL29OZFN4V3RJcUtqSjNPTDZyTHNZZ0xvU1NzTXJs?=
 =?utf-8?B?eHkzM0N3UXp1QW1QUXY2cmVEc3ZwTy9ZWFVTT3NtUnVXc3JrRUpuaUQ3MmV1?=
 =?utf-8?B?RXg1cUdEVXJTTHFsNEUwTkhpMGU4SHZudk5SeVdWeHYwQ2lkZ1E3QThrZVBo?=
 =?utf-8?B?VnRLVUl2Q09GVHJyeWpVQU5oajQ1dy9icmN0aG0zejdwcDFuOVNldm0yNllr?=
 =?utf-8?B?QXN3VWROejZ2ZUp5MFN1d3JudStSbEp5SEFLV0s2U0JLRjFyNHFNK240T0N1?=
 =?utf-8?B?SGhncDhKVzVkRE9HN3ZpQ2ZrSkRKRCtPQmptMkIzZlVYU1dLRmlIRHpieFc3?=
 =?utf-8?B?cTZkcUZYWjFsczltSUNkMm1VUUdOY1crK3RCMjB5dmQybjA3M3pIMk1xejl4?=
 =?utf-8?B?WHNDemRJK1M5QVFFdXlxZTFBMkIvYkM1OEVFLy9IaE1SZzZIODZQRDBSLzFh?=
 =?utf-8?B?WjFwVU81ZVV5dEVZNnROenR2dkpKeWExREtob3NqNHBUQXhGcEsyYmV0cHds?=
 =?utf-8?B?OGFYVU1CTStyZTZRdFBMbmJ2ZzU2Tmd4aUZrd0drRS9vOWVLR3hkQUhXeS91?=
 =?utf-8?B?Y2xmSlozQlJiYXQ2NzNPRXgybE40cTVJR3p0QmdCd3YzTTdYSUtXaFRLZFM1?=
 =?utf-8?B?bU14ck0yUkQ1M1J1b0t2anBENE1KekdvdUZNa3VUNHlVQk9aK2hBaFpvYnVo?=
 =?utf-8?B?OVJGTzk2WUIwS3E4L1NFV0REcFpPRktaNHJtODZzNXpyTkpaTjZ5aHluZDVY?=
 =?utf-8?B?ZkZKZ2FIZWYxUVJ1NmVBeHg5QmdIY1h6SW1OZEIwS3JLMXZXa2dPWU56WHhN?=
 =?utf-8?B?TVdzRmJydzdqaDZUaVJ6RkNYS05YQ05OWURjMVZlMG9YanhjdVdHZ251L2p5?=
 =?utf-8?B?OW90bUZ0UENDY1dCaE9YWlhWcG43czdCRHNsb0pDNnZaUnR4QUV6bCs4d2ZI?=
 =?utf-8?B?SnJSaE9RdFNZK1BYS3JNSkJVMnNqUlYxem9NYS84cUJFc1NzZFpobzF0M0JN?=
 =?utf-8?B?Qy9SYzFPWW1MVFRCRjJuSS9hM1lZeUNkSjVtTytkMlVDeXMyaktPeCs0RUtm?=
 =?utf-8?B?WGtqcGtxRTZNN2pmWDJrREF2SDRqQ2RpNW52VkU2WjlERGIxczNWWEVQREVM?=
 =?utf-8?B?R0RVdmdOVUlMaGNNay9Gclc0OWNvSEZQRklXa0ZZbUlMN1o0MGNCaGJXVzBt?=
 =?utf-8?B?Mmg1aDRzY0FIRG95TDM3SVV0WHpzMnJZR2xTNWhCam9DdDA5MjRDalk2dkhm?=
 =?utf-8?B?L3dpSElJbVd2dytTYzJVMUV3OHhsZGR5MjNzYUQ1K1dyS3czYkh3cUxVbDJw?=
 =?utf-8?B?eUhWSnZRZ2tISmpzdTZFZnBMYXNZZSsyVzBBM0lkU2w0QmRIM3JGYWxFeW5s?=
 =?utf-8?B?QlIzTDEyS0NJVkNJcjAvT2IvaXhEbmNKOUozRFdoRVEyR2tvcG9pNlhqZmRi?=
 =?utf-8?B?a1pSRTFxaUQ1Vmp4aEFYdkFoZUxiRFpEUzdwa0JNSDFhMlQ5ZVR0Zjh2Ym9G?=
 =?utf-8?B?NmZOMStOMWpkNU55VzEvMm9DTzZoZTk4MmVxSmZib0hvSlo3bWIxNmRQT1Qz?=
 =?utf-8?B?YTI3QVRGcXloWUREUklGNVNFZ0IzVGxqRjdOMjlrTHN2SkF4ZXdZeFJ6ZDRm?=
 =?utf-8?B?RHB5VDRYR2FDVithN0Y5MktidFN0L3ZBVFVqQlNLem9Tc050Zm5ONEJibVRK?=
 =?utf-8?B?eE0rN3p4Nzl1RlYwZjk1dzkzc21XeFBqUk4rVFJmQ3dGdGh2U0NXaG54ZC8z?=
 =?utf-8?B?ak15cFJDdm8xQnV0ZVk4U2RScU92c0ovSVZ0RUVjQjNNYnNISHRpMUhhSisz?=
 =?utf-8?B?dmlBYjk3MEZqVmlzSG1jU09YaFZTRXR4TVlQRGwzVWpTOURLVzE3b00ySGNM?=
 =?utf-8?B?NDIyVlphRkpMYkZRSExKRG9KMVFBYU9pd0dUbVVHYUc3SGhVRlJFUWx2V2xS?=
 =?utf-8?B?QlUrOENVd0dKTUF2TTBkZ2xjbHRKWmJVUEZqaG1ncnNNaHUyVHdJb1U0T2Zn?=
 =?utf-8?B?NjhoakMydzZNQWRDdDBzdkxTcGNqYW0vOXZBKzY5dmE5Q3VoejMvNjJQeG5G?=
 =?utf-8?B?SVdEcXpGelJPOWM1UFFiNWFUVUU2Q1B3M3NCS0ZYZTlsY3pqcTJRVjltclRu?=
 =?utf-8?Q?A1HIX0Q7zyNV7XKg/MEP8AVSS?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c431fb9-c531-4e27-5ea1-08de28a1b7f5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:00:17.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixPVlNkabOHy6ZWGuMQlXFXt7SihfpJxvhFMenwIY59E4UqdiIWF9L3Sr0VP6X+M5FRJmcRe0TJSYFE9yyMO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8279

Hi Luiz,

> Hi,
>
> On Tue, Nov 18, 2025 at 9:40 PM Ye He <ye.he@amlogic.com> wrote:
>> Hi Luiz,
>>
>> Hi,
>>
>> On Tue, Nov 18, 2025 at 4:32 AM Ye He via B4 Relay
>> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>>
>> From: Ye He <ye.he@amlogic.com>
>>
>> This patch provides implementations for the Connect and Disconnect
>> methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
>> interfaces.
>>
>> Ok, we will need some coverage in bluetoothctl in order to exercise this API.
>>
>> OK, I will add the shell commands of bearer into bluetoothctl.
>>
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> ---
>> Changes in v3:
>> - Move the modification logic from the device to bearer, and add
>> - some helper functions to the device.
>> - Link to v2: https://patch.msgid.link/20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com
>>
>> Changes in v2:
>> - Fix build error & warning.
>> - Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f41585144218@amlogic.com
>> ---
>>   src/bearer.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   src/device.c | 130 ++++++++++++++++++++++++++++++++++++++++--------
>>   src/device.h |  17 +++++++
>>   3 files changed, 285 insertions(+), 22 deletions(-)
>>
>> diff --git a/src/bearer.c b/src/bearer.c
>> index 9723b59e2e7b39b2974e258363aa0ace95862651..46e272b16096740ce28bcc80d0e2426df8538a2e 100644
>> --- a/src/bearer.c
>> +++ b/src/bearer.c
>> @@ -25,23 +25,38 @@
>>
>>   #include "bluetooth/bluetooth.h"
>>   #include "bluetooth/mgmt.h"
>> +#include "bluetooth/uuid.h"
>>
>>   #include "gdbus/gdbus.h"
>>   #include "src/shared/util.h"
>> +#include "src/shared/queue.h"
>> +#include "src/shared/timeout.h"
>>
>>   #include "log.h"
>>   #include "error.h"
>>   #include "adapter.h"
>>   #include "device.h"
>> +#include "profile.h"
>> +#include "service.h"
>>   #include "dbus-common.h"
>>   #include "bearer.h"
>>
>> +#define DISCONNECT_TIMER       2
>> +
>>   struct btd_bearer {
>>          struct btd_device *device;
>>          uint8_t type;
>>          const char *path;
>> +       unsigned int disconn_timer;
>> +       struct queue *disconnects; /* disconnects message */
>> +       DBusMessage *connect; /* connect message */
>>
>> This doesn't sound quite right, why don't we queue connect messages?
>>
>> Just like Connect() in org.bluez.Device1, the connect operation is defined
>> to allow only a single in-flight request. Queuing additional Connect
>> calls would change the existing API semantics and could lead to
>> unexpected state transitions—for example, duplicated browse attempts
>> or redundant link-level connection requests.
> I think that was done because there is the likes of ConnectProfile,
> which is not the case here, anyway I'd probably add a comment that
> this is done in order to keep API semantics from Device.Connect.

OK, I will keep avoiding queuing Connect messages and add a comment
explaining that this is intentional in order to preserve the same API
semantics as Device.Connect.

>> Disconnect() is different: queuing only affects how replies are
>> delivered, not the device’s actual behavior.
>>
>>   };
>>
>> +static void bearer_free_dbus_message(void *data)
>> +{
>> +    dbus_message_unref((DBusMessage *)data);
>> +}
>> +
>>   static void bearer_free(void *data)
>>   {
>>          struct btd_bearer *bearer = data;
>> @@ -49,17 +64,126 @@ static void bearer_free(void *data)
>>          free(bearer);
>>   }
>>
>> +static void bearer_disconnect_service(struct btd_service *service, void *user_data)
>> +{
>> +       uint8_t bdaddr_type = *(uint8_t *)user_data;
>> +       struct btd_profile *profile;
>> +       bt_uuid_t uuid;
>> +
>> +       profile = btd_service_get_profile(service);
>> +       if (!profile || !profile->remote_uuid)
>> +               return;
>> +
>> +       if (bt_string_to_uuid(&uuid, profile->remote_uuid) != 0)
>> +               return;
>> +
>> +       if (bdaddr_type == BDADDR_BREDR) {
>> +               if (uuid.value.u16 < 0x1100 || uuid.value.u16 > 0x11FF)
>> +                       return;
>> +       } else {
>> +               if (uuid.value.u16 < 0x1800 || uuid.value.u16 > 0x18FF)
>> +                       return;
>> +       }
>>
>> What are these ranges above?
>>
>> The UUID ranges are the SIG-assigned blocks for BR/EDR profiles
>> (0x1100–0x11FF) and GATT services (0x1800–0x18FF).
>> I originally used them to guess which bearer a service belongs to, but
>> this seems unreliable — some profiles exist on both BR/EDR and LE.
>> I’m open to better guidance on how to classify services/profiles
>> per bearer.
> If we really need to distinct the services per bearer Id add a bearer
> field to btd_profile, because as you say above there are profiles that
> can exist in both BR/EDR and LE, anyway if you look at util.c where
> there is the table of UUIDs it seems that the service UUID can extend
> from 0x1800 to 0x2800, but there could also be vendor ones which are
> on 0xfxxx range, meaning there could be multiple ranges we would need
> to check so I don't think this would be reliable in the end.

Thanks for the guidance. I will add a bearer field to btd_profile to
indicate the bearer type.

>> +
>> +       DBG("Disconnecting profile %s (UUID 0x%04x) for bearer addr type %u",
>> +       profile->name ?: "(unknown)", uuid.value.u16, bdaddr_type);
>> +
>> +       btd_service_disconnect(service);
>> +}
>> +
>> +static bool bearer_disconnect_link(gpointer user_data)
>> +{
>> +       struct btd_bearer *bearer = user_data;
>> +       struct btd_device *device = bearer->device;
>> +
>> +       bearer->disconn_timer = 0;
>> +
>> +       if (btd_device_bdaddr_type_connected(device, bearer->type))
>> +               btd_adapter_disconnect_device(device_get_adapter(device),
>> +                                               device_get_address(device),
>> +                                               bearer->type);
>> +       return FALSE;
>> +}
>> +
>>   static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
>>                                                          void *user_data)
>>   {
>> -       /* TODO */
>> +       struct btd_bearer *bearer = user_data;
>> +       struct btd_device *device = bearer->device;
>> +       int err;
>> +
>> +       if (btd_device_bdaddr_type_connected(device, bearer->type)) {
>> +               if (msg)
>> +                       return btd_error_already_connected(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (device_is_bonding(device, NULL)) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (device_is_connecting(device) ||
>> +               bearer->connect) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (msg)
>> +               bearer->connect = dbus_message_ref(msg);
>> +
>> +       if (bearer->type == BDADDR_BREDR)
>> +               return device_connect_profiles(device, BDADDR_BREDR,
>> +                                                               msg, NULL);
>> +       else {
>> +               btd_device_set_temporary(device, false);
>> +               err = device_connect_le(device);
>> +               if (err < 0)
>> +                       return btd_error_failed(msg, strerror(-err));
>> +       }
>> +
>>          return NULL;
>>   }
>>
>>   static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
>>                                                          void *user_data)
>>   {
>> -       /* TODO */
>> +       struct btd_bearer *bearer = user_data;
>> +       struct btd_device *device = bearer->device;
>> +
>> +       if (!btd_device_bdaddr_type_connected(device, bearer->type)) {
>> +               if (msg)
>> +                       return btd_error_not_connected(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (device_is_disconnecting(device)) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (msg)
>> +               queue_push_tail(bearer->disconnects, dbus_message_ref(msg));
>>
>> This also makes no sense, if you are going to queue the disconnect
>> message why are you sending in progress error if it is already
>> disconnecting?
>>
>> device_is_disconnecting(device) indicates that the org.bluez.Device1.Disconnect()
>> operation is in progress. This call has the higher priority because
>> it tears down both LE and BR/EDR bearers. Any bearer-level disconnect
>> requests should therefore be dropped once this state is active.
>>
>> +       device_cancel_bonding(device, MGMT_STATUS_DISCONNECTED);
>> +
>> +       device_cancel_browse(device, bearer->type);
>> +
>> +       btd_device_foreach_service(device, bearer_disconnect_service,
>> +                                                       &bearer->type);
>> +
>> +       device_remove_pending_services(device, bearer->type);
>> +
>> +       if (bearer->disconn_timer)
>> +               return NULL;
>> +
>> +       bearer->disconn_timer = timeout_add_seconds(DISCONNECT_TIMER,
>> +                                                       bearer_disconnect_link,
>> +                                                       bearer, NULL);
>> +
>>          return NULL;
>>   }
>>
>> @@ -151,6 +275,7 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
>>          bearer->device = device;
>>          bearer->type = type;
>>          bearer->path = device_get_path(device);
>> +       bearer->disconnects = queue_new();
>>
>>          if (!g_dbus_register_interface(btd_get_dbus_connection(),
>>                                          bearer->path, bearer_interface(type),
>> @@ -174,6 +299,16 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
>>                  return;
>>          }
>>
>> +       if (bearer->disconnects) {
>> +               queue_destroy(bearer->disconnects, bearer_free_dbus_message);
>> +               bearer->disconnects = NULL;
>> +       }
>> +
>> +       if (bearer->connect) {
>> +               dbus_message_unref(bearer->connect);
>> +               bearer->connect = NULL;
>> +       }
>> +
>>          g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type));
>>   }
>> @@ -203,6 +338,13 @@ void btd_bearer_connected(struct btd_bearer *bearer)
>>          if (!bearer || !bearer->path)
>>                  return;
>>
>> +       if (bearer->connect) {
>> +               g_dbus_send_reply(btd_get_dbus_connection(), bearer->connect,
>> +                                               DBUS_TYPE_INVALID);
>> +               dbus_message_unref(bearer->connect);
>> +               bearer->connect = NULL;
>> +       }
>> +
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type),
>>                                          "Connected");
>> @@ -212,10 +354,24 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
>>   {
>>          const char *name;
>>          const char *message;
>> +       DBusMessage *msg;
>> +       const struct queue_entry *entry;
>>
>>          if (!bearer || !bearer->path)
>>                  return;
>>
>> +       if (!btd_device_is_connected(bearer->device))
>> +               device_disconnect_watches_callback(bearer->device);
>> +
>> +       while (!queue_isempty(bearer->disconnects)) {
>> +               entry = queue_get_entries(bearer->disconnects);
>> +               msg = entry->data;
>> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
>> +                                               DBUS_TYPE_INVALID);
>> +               queue_remove(bearer->disconnects, msg);
>> +               dbus_message_unref(msg);
>> +       }
>> +
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type),
>>                                          "Connected");
>> diff --git a/src/device.c b/src/device.c
>> index 91b6cc0c65eaae8058cd445c0942ffee57289f0d..918f1e51acd3a9cd6b776cc080c198885511fb20 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -2022,6 +2022,28 @@ static void dev_disconn_service(gpointer a, gpointer b)
>>          btd_service_disconnect(a);
>>   }
>>
>> +void device_disconnect_watches_callback(struct btd_device *device)
>> +{
>> +       if (!device || !device->watches)
>> +               return;
>> +
>> +       while (device->watches) {
>> +               struct btd_disconnect_data *data = device->watches->data;
>> +
>> +               if (data->watch)
>> +                       /* temporary is set if device is going to be removed */
>> +                       data->watch(device, device->temporary,
>> +                                                       data->user_data);
>> +
>> +               /* Check if the watch has been removed by callback function */
>> +               if (!g_slist_find(device->watches, data))
>> +                       continue;
>> +
>> +               device->watches = g_slist_remove(device->watches, data);
>> +               g_free(data);
>> +       }
>> +}
>> +
>>   void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>   {
>>          if (device->bonding)
>> @@ -2063,21 +2085,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>          g_slist_free(device->pending);
>>          device->pending = NULL;
>>
>> -       while (device->watches) {
>> -               struct btd_disconnect_data *data = device->watches->data;
>> -
>> -               if (data->watch)
>> -                       /* temporary is set if device is going to be removed */
>> -                       data->watch(device, device->temporary,
>> -                                                       data->user_data);
>> -
>> -               /* Check if the watch has been removed by callback function */
>> -               if (!g_slist_find(device->watches, data))
>> -                       continue;
>> -
>> -               device->watches = g_slist_remove(device->watches, data);
>> -               g_free(data);
>> -       }
>> +       device_disconnect_watches_callback(device);
>>
>>          if (!btd_device_is_connected(device)) {
>>                  if (msg)
>> @@ -2095,6 +2103,11 @@ bool device_is_disconnecting(struct btd_device *device)
>>          return device->disconn_timer > 0;
>>   }
>>
>> +bool device_is_connecting(struct btd_device *device)
>> +{
>> +       return device->connect != NULL;
>> +}
>> +
>>   static void add_set(void *data, void *user_data)
>>   {
>>          struct sirk_info *sirk = data;
>> @@ -2712,8 +2725,8 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
>>          return connect_next(dev);
>>   }
>>
>> -static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type,
>> -                                       DBusMessage *msg, const char *uuid)
>> +DBusMessage *device_connect_profiles(struct btd_device *dev,
>> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid)
>>   {
>>          struct bearer_state *state = get_state(dev, bdaddr_type);
>>          int err;
>> @@ -2826,7 +2839,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
>>                  return NULL;
>>          }
>>
>> -       return connect_profiles(dev, bdaddr_type, msg, NULL);
>> +       return device_connect_profiles(dev, bdaddr_type, msg, NULL);
>>   }
>>
>>   static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
>> @@ -2848,7 +2861,7 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
>>                  return btd_error_invalid_args_str(msg,
>>                                          ERR_BREDR_CONN_INVALID_ARGUMENTS);
>>
>> -       reply = connect_profiles(dev, BDADDR_BREDR, msg, uuid);
>> +       reply = device_connect_profiles(dev, BDADDR_BREDR, msg, uuid);
>>          free(uuid);
>>
>>          return reply;
>> @@ -3421,7 +3434,7 @@ static DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status)
>>          }
>>   }
>>
>> -static void device_cancel_bonding(struct btd_device *device, uint8_t status)
>> +void device_cancel_bonding(struct btd_device *device, uint8_t status)
>>   {
>>          struct bonding_req *bonding = device->bonding;
>>          DBusMessage *reply;
>> @@ -6629,6 +6642,38 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
>>          return err;
>>   }
>>
>> +static gboolean device_is_browsing(struct btd_device *device, uint8_t bdaddr_type)
>> +{
>> +       if (!device->browse)
>> +               return FALSE;
>> +
>> +       if (bdaddr_type == BDADDR_BREDR && device->browse->type == BROWSE_SDP)
>> +               return TRUE;
>> +
>> +       if (bdaddr_type != BDADDR_BREDR && device->browse->type == BROWSE_GATT)
>> +               return TRUE;
>> +
>> +       return FALSE;
>> +}
>> +
>> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type)
>> +{
>> +       struct btd_adapter *adapter = device->adapter;
>> +
>> +       DBG("");
>> +
>> +       if (!device_is_browsing(device, bdaddr_type))
>> +               return;
>> +
>> +       if (bdaddr_type == BDADDR_BREDR)
>> +               bt_cancel_discovery(btd_adapter_get_address(adapter),
>> +                                                       &device->bdaddr);
>> +       else
>> +               attio_cleanup(device);
>> +
>> +       browse_request_free(device->browse);
>> +}
>> +
>>   int device_discover_services(struct btd_device *device)
>>   {
>>          int err;
>> @@ -8088,3 +8133,48 @@ void btd_device_foreach_service_data(struct btd_device *dev, bt_ad_func_t func,
>>   {
>>          bt_ad_foreach_service_data(dev->ad, func, data);
>>   }
>> +
>> +
>> +void btd_device_foreach_service(struct btd_device *dev,
>> +                               btd_device_service_func_t func,
>> +                               void *user_data)
>> +{
>> +       GSList *l;
>> +
>> +       for (l = dev->services; l; l = l->next)
>> +               func(l->data, user_data);
>> +}
>> +
>> +void device_remove_pending_services(struct btd_device *dev,
>> +                                       uint8_t bdaddr_type)
>> +{
>> +       GSList *l = dev->pending;
>> +       GSList *next;
>> +       struct btd_service *service;
>> +       struct btd_profile *profile;
>> +       bt_uuid_t uuid;
>> +       bool match = false;
>> +
>> +       while (l) {
>> +               next = l->next;
>> +               service = l->data;
>> +
>> +               profile = btd_service_get_profile(service);
>> +               if (profile && profile->remote_uuid &&
>> +                       bt_string_to_uuid(&uuid, profile->remote_uuid) == 0) {
>> +
>> +                       if (bdaddr_type == BDADDR_BREDR)
>> +                               match = uuid.value.u16 >= 0x1100 ||
>> +                                       uuid.value.u16 <= 0x11FF;
>> +                       else
>> +                               match = uuid.value.u16 >= 0x1800 ||
>> +                                       uuid.value.u16 <= 0x18FF;
>> +
>> +                       if (match)
>> +                               dev->pending = g_slist_remove(dev->pending,
>> +                                                               service);
>> +               }
>> +
>> +               l = next;
>> +       }
>> +}
>> \ No newline at end of file
>> diff --git a/src/device.h b/src/device.h
>> index 6ed8affa0d4a9274d30cac9b48e8a6826edefd64..fee1ad50dc9c7ae248acd819dae07762c783ac35 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -120,6 +120,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>>   gboolean device_is_bonding(struct btd_device *device, const char *sender);
>>   void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
>>   void device_bonding_failed(struct btd_device *device, uint8_t status);
>> +void device_cancel_bonding(struct btd_device *device, uint8_t status);
>>   struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device);
>>   int device_bonding_attempt_retry(struct btd_device *device);
>>   long device_bonding_last_duration(struct btd_device *device);
>> @@ -134,6 +135,9 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
>>                                                          const char *pincode);
>>   void device_cancel_authentication(struct btd_device *device, gboolean aborted);
>>   gboolean device_is_authenticating(struct btd_device *device);
>> +
>> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type);
>> +
>>   void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
>>                                                          uint32_t flags);
>>   void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>> @@ -141,6 +145,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>>                                                          uint8_t reason);
>>   void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
>>   bool device_is_disconnecting(struct btd_device *device);
>> +bool device_is_connecting(struct btd_device *device);
>>   void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>>                                  bool central, uint8_t enc_size);
>>   bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
>> @@ -170,6 +175,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
>>                                  disconnect_watch watch, void *user_data,
>>                                  GDestroyNotify destroy);
>>   void device_remove_disconnect_watch(struct btd_device *device, guint id);
>> +void device_disconnect_watches_callback(struct btd_device *device);
>>   int device_get_appearance(struct btd_device *device, uint16_t *value);
>>   void device_set_appearance(struct btd_device *device, uint16_t value);
>>
>> @@ -184,6 +190,9 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
>>
>>   int device_connect_le(struct btd_device *dev);
>>
>> +DBusMessage *device_connect_profiles(struct btd_device *dev,
>> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid);
>> +
>>   typedef void (*device_svc_cb_t) (struct btd_device *dev, int err,
>>                                                          void *user_data);
>>
>> @@ -225,3 +234,11 @@ void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
>>   void btd_device_foreach_service_data(struct btd_device *dev,
>>                                          bt_device_ad_func_t func,
>>                                          void *data);
>> +
>> +typedef void (*btd_device_service_func_t)(struct btd_service *service,
>> +                                       void *user_data);
>> +void btd_device_foreach_service(struct btd_device *dev,
>> +                               btd_device_service_func_t func,
>> +                               void *user_data);
>> +void device_remove_pending_services(struct btd_device *dev,
>> +                                       uint8_t bdaddr_type);
>> \ No newline at end of file
>>
>> ---
>> base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
>> change-id: 20251111-bearer-impl-5f7e396174aa
>>
>> Best regards,
>> --
>> Ye He <ye.he@amlogic.com>
>>
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz
