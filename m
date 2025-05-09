Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022076.outbound.protection.outlook.com [40.107.75.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002D270567;
	Fri,  9 May 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778874; cv=fail; b=G53+YUxvP4lqwoEilI6qlJ+NxLDFcZ7hmdE7EAqgrcVBRsiqf+/o42/urEVMfUJgj+uVPESTB0d2Z5tC43EZ4BV6s51KSDR0ZHYf2yBJodBYyFcZMubqZWfvPorFOTlOYGpDD010wf431On2ENfgf1+PUMTkoMWmJ804jD85YW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778874; c=relaxed/simple;
	bh=k+QdJtjSgicg158zzQ7e5ijUTp8YMiHqyvrP5gllrRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nx/js/38EYhd2nRJXu/v+u2UHn7Wso0vUpORKzWj2XGesw62E5YchpOM/Mb4rofcp8nUh/2m9xwKlDOO9jqq/0GpvitilomymICnAMceCMU8AIGo4KC44vb2zIVulN277iqdPULmll4SKI364vgKBEoFdWVapObLys8afT2wMuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=qE3Hm/7R; arc=fail smtp.client-ip=40.107.75.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="qE3Hm/7R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBE4ayad0njU1kjKMrfR4Jfi8po2RG1ncSYnhkMRJkWQDvWyH5t5YV+GHMov2Cc6ErUSkJgRQUTlmnmT8ZF305QGvSxFvrntH7rrNFYLkYMbkQiNteNkvfIyCMzs1ZiCxng+W6Im2G9XT4k5WdQ8lsPWYykAXLqy6Iz+obOirXvMZoJyy1YQA4M7XHyqrKkhhT5ctGG1WBNEPsSHyOtpxUqB/H9r7XDCQwqQqbRsTX7nUNJ4KG9YHIrEFA05Njf4+QlUN0lkZI2X4h/QcGP4tbQxTQqHb01Vq6ATmyHwxK0fQT2Q4OfMmu39phgFp2KvZL7kDNlxV0w55eRTq1imKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jyWxPcqHJDw6WEwdRRglMFoEjgUgcdrMHJkC8sIb1s=;
 b=s89WPySoxfJJeiXy/5VSXFExWqQ8RvAIkWNNoVZ4T8Kv8orwW2Q3tzudIgxp7yAnx/Yop0EKHy/rZYg5oDJky4CNXmQOxZewNK+gwgbPNXWOEMY+/kzuk6y7yW0c8NsryrvLSFWt294yfMYloYNdz0xD9WvepTs1C9mVM+Th81Y/iv5F4vpYpzCRmbuV9udfqfg1fLKRbmj91LD2MkiarywS88Is9/5q0ES73y7iew2ipDhjkc0SLR/ohcRoYbXRtlOe4x8YE0ri0xedW29lDGeTmQ/hLo3PzQoYBTtTMLoqN3JEqHk9pA+zuvxMTCAL6CJSpdaUso5yi9drBPMRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jyWxPcqHJDw6WEwdRRglMFoEjgUgcdrMHJkC8sIb1s=;
 b=qE3Hm/7RNq/fOsopUL1OR1EmLkwfCaMPx6UffgjlZElIHdniV51H2EC7nhO9PypFPmRcTHGiDzxGC6BOxEFkjkLlNPcTKBkg+KXAyKSvNf8SGsUIaO3+UWuQNmTAQQLkl72dFDxS+T8i9JNBjYb5/xppjfrevOXa2Bc1DL8RJIehpm50GtVHkN7MBNW9ZLo0gsAHmFdIbceBICNqlzYXykk4ev6BW/W4onlWxUzzjPFwnM5jZzz9sXHX5Ql/CeqI14zrTCzl0wg3ipHcL9MeqJJz458TdeQmFPj8p/s5Ad2oE6ThZndmoDfYa4a3ARgSpaFs+vX60Zq5MJu+lc94Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB7401.apcprd03.prod.outlook.com (2603:1096:101:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 08:21:04 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 08:21:03 +0000
Message-ID: <cf4d91fa-e5d6-4662-9a43-18f5c777e213@amlogic.com>
Date: Fri, 9 May 2025 16:20:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and
 CIS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 kernel test robot <lkp@intel.com>
Cc: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, oe-kbuild-all@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507-iso-v1-1-6f60d243e037@amlogic.com>
 <202505081427.1Y3wyo7v-lkp@intel.com>
 <CABBYNZKfz1J8YY9Atj935NJ7KoyHpUgPpUNGz_CytffNBXJfRQ@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZKfz1J8YY9Atj935NJ7KoyHpUgPpUNGz_CytffNBXJfRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9a8c4f-61eb-42da-04dd-08dd8ed27045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yld0Z1YwUS9SNytaWlVYbVgzWi9TOFl0K0VlTUZvLzExeDhick9jcDhmWitB?=
 =?utf-8?B?NHFkK2tXSzVuYmwwNWduQWFLRVFsSzFXRlA0aHlaTXR1OElmNDVPdVpiZjNI?=
 =?utf-8?B?dlJuOWxGRDVUSFI2YUZWbjg0U1pGYXY3dkJQWkdWbHdFdzJqeEU3QUFMYVN4?=
 =?utf-8?B?U2t4TGpCTDZrYnBqYm50Z3dpWTl3d2UwRXNCVjdpdmpaaVA1RzBiQmlIMTRu?=
 =?utf-8?B?Y252TDlPVTY3TFl1UjZjVkJwTElucVpYeGo2WE1Hd2JHaWN6bFJLanV6NEVy?=
 =?utf-8?B?T2hoaEhWN3RZWEMxYVpSVWJ0S0pHd0puNnRoRW5oSVlxWlhmUnNOVWxLNThv?=
 =?utf-8?B?b012bGNaVm1XRUhZaFR1N2hUVVJXZUhSb3l0RXE4RUNGMUNyUFRHTCt4RXhF?=
 =?utf-8?B?VHRncXlXeEtGQXBYZWd6RlNtL1E5ZG8zM3ZFWFBFd1pOV3lTY1M1UTZwaEd1?=
 =?utf-8?B?R3NFbnNFam16Z3hacytJTDVXSXg4amZ2bHVnZzNDdTF2MEtDck1uSTJhSWIx?=
 =?utf-8?B?Y01SZnlreTNUT1czSFd5OWhmYnRGN2RZODZMbm9XRUFVd0ZsTE9JSUF0YzMv?=
 =?utf-8?B?em02VHcyYlZxYTJoYUhQc3J2Q0taZFUzNXNVYlh5QkIycC9lQzJxSGJycjJ5?=
 =?utf-8?B?cmJiVngyM2xCL3h4T1pKeUhaVEVBanJmbDdxZHJPN1NielQzck41S0RwZXh3?=
 =?utf-8?B?L3o0aklrc2ExOVVndDZyQkk4b0c4WkJoQWtuWnNxcllFZHFhd3dLei80b2Rt?=
 =?utf-8?B?ZkNaOUNjOEtsdEJEa054S1U1am1yY25JV0p0d3p4Q1Z6K0pHdmNRbUF5M0NE?=
 =?utf-8?B?QlIwdlJTTHh3bEMrbERweTIrWjdReXBoMFdUVFpqVUtySmNhL3B6amV3Qmlo?=
 =?utf-8?B?cnNmMi9zZTUzMzJ3Tlo1WG9RUGxNc21uRzFzV2VnS3lGTk8veFVkVTJnbm1J?=
 =?utf-8?B?VWMzK3IycDhFRTBHb2VzVnpjMnJ3MkY3eTBieGJ5bFBQeUxJUXRVUktjaW0y?=
 =?utf-8?B?dkxUOC96bkhmeVF1VWRsektxZzBlMTBFUG5hcTVqbE9nand1cTFIcG5oQ08v?=
 =?utf-8?B?SmtOb1lzelZZVnZjdyswd29LRGpjWGRMOFREOE1VUDlWNlZqNXZWUi9pVlZY?=
 =?utf-8?B?WkV2MVJ1aUQ2S1NiaXhTa3R3UWViTDRRTy9YVEIvQldNRUNwSVNYWWt5Qjk1?=
 =?utf-8?B?NkdaS3ZScUhuVVNualZ6OVdCeHlWVkN6VzBka1RIYkJVaEZMT3FLeFpnMW5U?=
 =?utf-8?B?WUgzQlNicGxjK3NidUdRZkJieWZDeDNoekZDTHdhOU96Vjd3RzJPZ1dNbXV1?=
 =?utf-8?B?UXl6NmhDWjVPQ1JDU0xCV01ZRHQ1VUY4dGllZlk3R2wxZk1LcUZhTUxUMTZQ?=
 =?utf-8?B?UC80Mzk4N0ZueVlFaHoxRXZNM1l1YTBqVHZZaUZ6WEhrTkhxMTlxR2d5ZUYx?=
 =?utf-8?B?dDZKNGlTWTUrOEhUTW1zYlBSRlJlMW55RDIrU0RlK0V1bmw1OU1LcHQ3YXJy?=
 =?utf-8?B?eUhTbWp4Nm11RTNMT3pXWVpqZmpnMjVtS1QrTThSZVBnME9uM0FxWTZzTjhs?=
 =?utf-8?B?ZGMvL3h4RU43UklPWU9FNHNOQVVuZWxZeXhYWVNXWnV1TXdDKys4c1dJeWNi?=
 =?utf-8?B?NjRMODZGQzIyaHJmaFdvaitGcERobE1WKy95ekU2bFdWNTB1cUJoKzZaQUo1?=
 =?utf-8?B?eUR0ZmFWbzIzd3FBUnZTeXE0V1NzUVNQMldDNjdXbkNudnBpbG5UQ0dKWkl1?=
 =?utf-8?B?ckxoajJyTENuVnRNd1kreWszc1JoWWw1RGxaSVNYbjNlemR6UFlUMmtRbXhC?=
 =?utf-8?B?UjFZZm4wSzM0aHhoMnhPNmpUTVNXNWJ5YTFqWUlsWURQWDF4dkgyakVnTzhu?=
 =?utf-8?Q?s6abRfQUq7ywV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTJzbUp0Z2MrTXNRMTM2Y3dLNG02QkVTTld1YlF5eWZsK2RFS0lzQStKN2hY?=
 =?utf-8?B?elBwY2ZkdmlKV2R5Zjd5ckplbzQrN2swNUpGUkRjMm5BVzFQbkNZOUIreXAv?=
 =?utf-8?B?TCtmNWhUYnB5U2ZIL05HTkVoNDYrNm5acktVWCtDRHFqamxrZ3JWU1ZuNmpt?=
 =?utf-8?B?MVJjejM4Y2RxVFIyT1ZnK2lXTG5GVVN1Zkc1QXR3Q2JSYmoyUElFZk1mcC9F?=
 =?utf-8?B?bUJoQTNlQnc4REhKUFpYckhoakRpbHprQ0lzdWwzVk5hSmpXdDl6KzdMa0R1?=
 =?utf-8?B?RkUyZEx1Z05Pd1pmTFVEdVBsUm5oYlI1UHJPUFFuN0dzOVFiZVd1WTFqTlFu?=
 =?utf-8?B?aUM0eE80TENzK0hFVWpUR0RkQVQ1TFFwcHU0UExZRUllY3MvMEUxSFBmakJF?=
 =?utf-8?B?SCtTY0ViNldjcGJRcnl3TFZWRHpsQ2czOW9rTG5SbTk2NGxPTEIrdnpiV1FI?=
 =?utf-8?B?ZkxYcXlNQ3gyaWFsbXJqNmFiQkZuTjYvdUkwVUxUbVJma1R2elVtRlNZMTQw?=
 =?utf-8?B?ZC9UYmozMlF1SWtmb1AxNlhKUG9aTHJEMVMrR1ZuT05TK1B1QjQzUGxjb2Fq?=
 =?utf-8?B?ZUFZdVdqNGh0K2o3clYzMXF0RWVlZHAxNm5WbDZTeU1BWGZNdUxaRGw4RStT?=
 =?utf-8?B?dEtianFtb0FmY01HeVdOdVdnSkZnUzgrOVBDcXYrOWE3NnBsN2JpZTZSYTdM?=
 =?utf-8?B?dzh4SGVXVlIwaFhOajNKSlhSUVFJR2Via0FwYzNNYldVT3pWUWg2SUVJOUJX?=
 =?utf-8?B?U2dxWlhaZzhuTFVVTXZUQkhxQzliYTZGb0huc1BFODlxaGl5WnJNS3JXOUxl?=
 =?utf-8?B?Q1ZXUERrTDdkek9DQUxzYUQrdW1CdlpXQWNobE9hWERiR1NXNlVLQlVnZzFu?=
 =?utf-8?B?QTNlMUpXVW1qMWVTSzJ5V3pSNVlLVEwxTFI2cnFrQzNkclZaeHFqc1hrSlhP?=
 =?utf-8?B?ZDJhUlpDaHhFQnV0WW9KOWtrRHl5RDdZc3JSazIreXBkZC9CcjNoQytDRWpp?=
 =?utf-8?B?b2ZjUWFBN215bkNwbnpzbThLa05GVVZUeFo3YmJqN3dKcE40S1RacStZWXFv?=
 =?utf-8?B?dmpjUTNPWi9xV2dqNGEwSUlnWmR3TE9TU0FhNXNlNk9NZjZkZ0dKNGlLUFBo?=
 =?utf-8?B?aVVzQUVhZXNNWUFiVnRtNFo4SmdpRStvZi9QNmRIOU0xMkwzZ1RqSEJGNWJC?=
 =?utf-8?B?Qk1JNDBtVU1meG00UVVSSkJ3Q3Z3SUdvVjZsOVJwZlozbENxOWJJVHg5UWVx?=
 =?utf-8?B?NWFnM3VpTytKWWp6anU2VDZWUGpwRGR1SEVaaTkrYmxsU3ViL2RMZ1FxdzE2?=
 =?utf-8?B?YlV1QXJNN3VSZmw3Zm16dEtKYjFwRytBS216NHpUY0xxUUxLeERqZDF2SVFu?=
 =?utf-8?B?elpGWXV2T2I0VG9zNHU0aHlrbCtJa0NhZkdPVWcwL3YxRHFLd1hRenpQd0pz?=
 =?utf-8?B?WnQ3cGFJb1NwS1RCR3Q0MUk3MWNzOTcrWnN2elpFVnU5ZzFIazcxZjdCQm0z?=
 =?utf-8?B?QUpDYzg5RHRoTnZvaVh6YlA3QjgvVDJqUkRjUHdTaFJsVDkxUFRzd05wK0Yw?=
 =?utf-8?B?VFNUcmY4bUVxaFFGbmRycjBuVEhxM0Q4ZytCNGxxclAwdzVjdUdkb1hRYzhv?=
 =?utf-8?B?Qm5YL2RaOUNRaGp2U2hjeU9rbEozdXFNK1QyVzcxN2tacGJHMmQ5QU04NFln?=
 =?utf-8?B?M2Uyb0pOK0Zabm56SGtSNlZ1VkdFTTJEVnRYOUpwc1ErOHgwc2tQUVgvaDdC?=
 =?utf-8?B?aW1QODJiOFZ5aVNVZ1duelNJcGtFbFR6UGtkUzB4V0JjdVg1ZUU2Ujg5aEVl?=
 =?utf-8?B?ZVQ4bENpc0VPblVBaG1ONmVnQVNNck5UV1RWQjZQZ0x2a0FEOWc0NEVVTzl3?=
 =?utf-8?B?NWd3cG95TFNVV1NyRUM4NmRmbUN0b2NJTGJ3bWdQaFo1VUpFVDBCODEzL3Uw?=
 =?utf-8?B?VTlLaTErRTlKWlMwMUZNcFpnN2VCTFdiWFNkeTB5azFnUUVSQjBmOFd3TkFY?=
 =?utf-8?B?MlpoM0xxYVR2Z3pzeUNxbWVsYjExZmphT24wd3czeGJUaWVycWwrS1dnNkJw?=
 =?utf-8?B?UXZyK0xGK29QOG4wS2tGYzRJMUJnNDFZakR3Q2xDeDlKaElseEZCTnFLcVBs?=
 =?utf-8?Q?nOiZTdGcM2l6W2J5CvTj7QwI5?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9a8c4f-61eb-42da-04dd-08dd8ed27045
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:21:03.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx/HEmWTlvZW3DJIEo1eSlsFa8znnNwClCZfz2kneJz1nz8f/74KRjumzinzWV+Bwvb1nnVFGvljDAEmpFaKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7401

Hi Luzi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Thu, May 8, 2025 at 2:54 AM kernel test robot <lkp@intel.com> wrote:
>> Hi Yang,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on f3daca9b490154fbb0459848cc2ed61e8367bddc]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li-via-B4-Relay/Bluetooth-fix-socket-matching-ambiguity-between-BIS-and-CIS/20250507-153347
>> base:   f3daca9b490154fbb0459848cc2ed61e8367bddc
>> patch link:    https://lore.kernel.org/r/20250507-iso-v1-1-6f60d243e037%40amlogic.com
>> patch subject: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and CIS
>> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505081427.1Y3wyo7v-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081427.1Y3wyo7v-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202505081427.1Y3wyo7v-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     net/bluetooth/hci_event.c: In function 'hci_le_per_adv_report_evt':
>>>> net/bluetooth/hci_event.c:6469:60: error: 'ISO_LINK' undeclared (first use in this function); did you mean 'SCO_LINK'?
>>      6469 |         mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
>>           |                                                            ^~~~~~~~
>>           |                                                            SCO_LINK
>>     net/bluetooth/hci_event.c:6469:60: note: each undeclared identifier is reported only once for each function it appears in
>>     net/bluetooth/hci_event.c: In function 'hci_le_big_info_adv_report_evt':
>>     net/bluetooth/hci_event.c:7055:60: error: 'ISO_LINK' undeclared (first use in this function); did you mean 'SCO_LINK'?
>>      7055 |         mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
>>           |                                                            ^~~~~~~~
>>           |                                                            SCO_LINK
>>
>>
>> vim +6469 net/bluetooth/hci_event.c
>>
>>    6449
>>    6450  static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
>>    6451                                        struct sk_buff *skb)
>>    6452  {
>>    6453          struct hci_ev_le_per_adv_report *ev = data;
>>    6454          int mask = hdev->link_mode;
>>    6455          __u8 flags = 0;
>>    6456          struct hci_conn *pa_sync;
>>    6457
>>    6458          bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
>>    6459
>>    6460          hci_dev_lock(hdev);
>>    6461
>>    6462          pa_sync = hci_conn_hash_lookup_pa_sync_handle
>>    6463                          (hdev,
>>    6464                          le16_to_cpu(ev->sync_handle));
>>    6465
>>    6466          if (!pa_sync)
>>    6467                  goto unlock;
>>    6468
>>> 6469          mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
>>    6470          if (!(mask & HCI_LM_ACCEPT))
>>    6471                  goto unlock;
>>    6472
>>    6473          if (!(flags & HCI_PROTO_DEFER))
>>    6474                  goto unlock;
>>    6475
>>    6476          if (ev->data_status == LE_PA_DATA_COMPLETE &&
>>    6477              !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
>>    6478                  /* Notify iso layer */
>>    6479                  hci_connect_cfm(pa_sync, 0);
>>    6480
>>    6481                  /* Notify MGMT layer */
>>    6482                  mgmt_device_connected(hdev, pa_sync, NULL, 0);
>>    6483          }
>>    6484
>>    6485  unlock:
>>    6486          hci_dev_unlock(hdev);
>>    6487  }
>>    6488
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> This is probably already solved by:
>
> https://github.com/bluez/bluetooth-next/commit/f3daca9b490154fbb0459848cc2ed61e8367bddc


I'm currently working with kernel 6.12, but this patch seems to conflict 
with it. Do you know if there's a plan to backport it to v6.12?

>
> --
> Luiz Augusto von Dentz
