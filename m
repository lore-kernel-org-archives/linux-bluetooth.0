Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129F8462
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081056; cv=fail; b=GM3zb92YUekzx5kRq0m/9yXzBq5uPIMgAUr4FZvJhVJtl8xcJ2v9p21zof5hsQJuCi7kon1n/JCT/x9C9ZDljcRNpslhE3zUeUpvYK1j2ZatV1vGD7OjCIHrJzg7/W7aNTIg8+omwyJzeRzzS/Pv0lO+X0tIkhmBeIVfdDN0CVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081056; c=relaxed/simple;
	bh=wBfFuP908x2YwS1DwRij4ZcNHddlMl8qwp84/eCCVZo=;
	h=Message-ID:Date:Subject:References:To:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0D3McI/8IdJ/mi19IP4S2XoBoHt4dI0f0ZpxQhNq3ynMglJGn2mX8JggS6d2FmUjqVyrOjojA9l9umbklksctCsLpinwz3oBthKO5qg5s5Gjy6P60yPVceLZk/G2nYeRD2e3pKpnBYU3SsTWwtcAorNjZf6BpZGmyt/cBPSOVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=B81Wfo6y; arc=fail smtp.client-ip=40.107.215.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="B81Wfo6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlQzqlLPHPuGn69MwAjdkGhmEC+CyTlyMRiffP1zLqaMcj3oYLmBx7Wit+nwuuccLzVUDUEGeV49XavRBeFOu4leQabQ8/FiUVftw/np3hZwUPUxzA0rvzd21ZhLrOfnZTJi9Wntz2zib5epF6k1Ipe2PK+BHw4JL/z9RtpxpNoO3JQhN6E2T2+1dFtJ9vr4iyRrzfnLrQJBVsl9Av/NQxQbz6C4g8KCnYs7v4WlOuldOEY2zvFMArJJwr0n4xS2XQunumxhhKymuR11H3HP9/7Cv55CjPGNxV12RIvWZoGOdY5lqAE2I4SpdRdYcn1P25Mhp2tyHV+MLMH3OjR+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jhcrrw7Mivpc9nH0LgMt3bK7nEv15FeUTWbL6Nw1iM=;
 b=oXtPoSPSkiDZ8X6017ADvsaRkj9PpDb0A/WbG2ozTuLTuK2l+3DMVahPjsQTAyrv75u78iHoMTsLhfoHHHGsPQAmRaUNS03mRnTdetmdWezFintjqh7XWlszxlvDCjZd77V9eoYsUnuxEM5PBcLdT1YQAcIaz3m5uk17gWXMffFjf4NXVCMqizUJSY8uxjg2HnH0au/PtCF4BUX95TvEqLl3qTXTJ0cQaRKD9USjLHu2boiRZ/Vi2TSxtbOpGtcTVBwODjlGRx7pNKo1LRjexzeUS89dzuv21bousFl3meLA5XMMsP7wOLpqBZVrCopyMWhvmLhl7UD4AgIbQuOrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jhcrrw7Mivpc9nH0LgMt3bK7nEv15FeUTWbL6Nw1iM=;
 b=B81Wfo6yxuA8BRN/RBkEG56StV35kAURFVC1iF+6l94ZWTB0FYs+wO7lZHEC8mGbTOANyyE9QNFn3m2+QY8wgY1wDW1X+1w5bFj5N9Njfb5FtAzOPBxxq45yAOo0fj07FSeuv8aoGM9MZ8f45LGsNZk7SXGGzjvg5dDl+BBa5EoDyBLmNeTf3DIxgr4fTSSbOnf18WbMBYoQM6rCGOvSt5VxfH0V3uJ+olirHoqHrWP9stKPGVlE85+Mn+RzsYMHb2HfpWvS5x4CUfO8hss2zasGtIJsYBtLQ8pRbz0HCoXJB9zBvLfgRItgfO2fA/Jh8GMezSnKJ0eRT2Vvele4+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TY0PR03MB6823.apcprd03.prod.outlook.com (2603:1096:400:218::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.28; Tue, 8 Apr
 2025 02:57:30 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 02:57:30 +0000
Message-ID: <ac3d4669-db31-4d76-840a-2cf294bb20bf@amlogic.com>
Date: Tue, 8 Apr 2025 10:57:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH BlueZ bluez] bap: Add idle notification for ASE State
Content-Language: en-US
References: <0dd92b20-717a-421a-85f6-081cff6586cd@amlogic.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <0dd92b20-717a-421a-85f6-081cff6586cd@amlogic.com>
X-Forwarded-Message-Id: <0dd92b20-717a-421a-85f6-081cff6586cd@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TY0PR03MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: bc50662d-9f79-4c09-2ca5-08dd76491a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1BFbHVWVlVjbWF0bGlhcnZicG9HcldXRkN3Ui8rSnRuWmhUeHBzMEFmWWJm?=
 =?utf-8?B?ZmFORGNRbzFDY1lDbFpIR1BIVWllakxEb3NDT1FxZ3gyMERQb1BXZEJwd3Yw?=
 =?utf-8?B?dEppYjRPUFlHZ2lUa2pVZWNDUmhUbk1LQmZjQXdWS2o3d1lRVjRXNnpUR1ht?=
 =?utf-8?B?NFcwTmdNcm1rMDE1VkF2NmNpVTdNZjE5M09PT1RqODdXcWZtSENBZG5jOE8r?=
 =?utf-8?B?dHJGZ1VHYk9qZWM0QUNPendhWjUzMlQ5VHZ0aTYwckFCZmtDYlY1aFZHK0wy?=
 =?utf-8?B?cU9qeC9keU9vLzViL0ttNGxlcXhUeG1EdGVrYm5aOFFITXhmLzlJaHhUODNL?=
 =?utf-8?B?clo3S0MvcXlCalVZbmVyM0VBaUZRU0lLd3VLL3JDSm1sSVlWUzBVbE1wM3lz?=
 =?utf-8?B?R29SMnBUQnFZM2I4N3RqVC9nZEo4UU5LQWZqcm1JU0ljRkJ3UzM5VjRoaVlm?=
 =?utf-8?B?RWRZT1hoVkVzTnVrTFpxZVUvSlNkc3JxRm5GS3ZVZzdvWGtWVGpCZU5SS0Z5?=
 =?utf-8?B?bXRRRjYxTE91UkdaVXpoMy9lU0FrbWJpckRPYUo1MDlGMW9wT3B2K3VndExT?=
 =?utf-8?B?MGJoMHYrOGpWbVhJMkhZR0ZaRnpWT1VKeWtWTkJUYU9idjNnU0Y5cHFWdm9o?=
 =?utf-8?B?bUFEb0FCTC9WVGN3Njd1THBnZExnMGpTd1c4UVhxTDN1dU1kTWxSNVpEWFBE?=
 =?utf-8?B?Y3pTUjliNWNNaEF6aUxUOHY0MzZXeWlDYWx6QXJHU3RZNEw3SVV4VzdQU0tJ?=
 =?utf-8?B?NGFPb0NRdG1obCswQ2ZwNS9lRThpUk5SRVVWNDR0TzczRWo4NzBEci9JZUN1?=
 =?utf-8?B?ME9RL0l3aU9uZmNxai9KUGRFQkVWcWhhYm4vY0hIM04xanFZY0ZrWGFpeitT?=
 =?utf-8?B?Ky8raFJTak9iaG0rR3hTTkEvMC9KYlRvM1RDWjJjUDVidWlZRDdFQkpPcmJi?=
 =?utf-8?B?MWhQZzh1dFpBV1FHV3FYdkgyQW9rd0NvYlNYUElyNHpoQXZON1lxYlpLWGY3?=
 =?utf-8?B?MUlXYTdoV1I1bkZHR2tZVVoyWXRsY1loak9iM2lUYUlrcEdVdGw1KzNHdDBT?=
 =?utf-8?B?VDZ6cSswdTJSSzE2Tm1YVnFjaU1LS2wvNkZVYzZTcmF4S0RlMG8wWktCZXJT?=
 =?utf-8?B?V0dneU93RldNWHJ3dC9uQ0dGM2hPUUFHL3VKYWpNeFBvZWRrK0hnUWp3aTlk?=
 =?utf-8?B?ekxJd29xL3F3QUJLKzJYdmxIcXhpWVplT2JGVExWdlY3dFJBWWFJVVlDQ0xH?=
 =?utf-8?B?aW8zcDVteC9NRGVpaVNrQnYxdGRSRjlPN1VMc0p4RnVLS3ZZUmo4NE5CRXdn?=
 =?utf-8?B?VFhYZG1YNHFpMmRnM2lieWdYUDQzTDV1RDdWRnBQbk1lOTN6K2daNUxsQ1Jn?=
 =?utf-8?B?a01aSHVjdEZtUFN3Nkl3Yi9uampFb2pDQlhFdEEyalp6RGtMNm1oenJ4MlU2?=
 =?utf-8?B?K3RIbEY4ekp6czhMb2oxaXQvcCsrRUQ3YjJ2RnEwd1IyY0dScGhGU2QzT2N0?=
 =?utf-8?B?ZkxxbjQ2WStzYUw5dzJzaXlIbTc3Y0dPdEQzU25UZ3FBK0tDTEpPUGd6WG9a?=
 =?utf-8?B?bXBrMEJMMkpPZ2pRQkRSRVQ5OWVqRXdLZjhvK1dnbVRoY0VDUzFnNlU1YXkz?=
 =?utf-8?B?OUgwNndjSHpNaEJ1ZERQTDFNaGxHQjdENHRaYzhuZk5wbUxlZzIvOUFtSU9F?=
 =?utf-8?B?TzdZalhnYlJGTHpzWUtlMkRXamhyVjJ5VG40RVdIOGlLVWJmNlF5amhLNE1z?=
 =?utf-8?B?UFVNNzBsMlRoNUxqT29SejBabFUxM1lEd0JOVzdnTThZMVcySFYyQWQzWXJE?=
 =?utf-8?B?Z1dXSDRYSktKNVFBSllNb243Z3lTcUEvMHg5NTBDYjQyS3dFRThpbnBkMTdj?=
 =?utf-8?B?b2lRMjN6YlJtN29aRWwzUVBQMGx2OFF3dlBVeUt3RW9oMDVaN0pybEdML2F5?=
 =?utf-8?Q?g3LGQWyZX+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SURMejN1NzZrUGUzek1uZXduaWo5NVVCQVh0RTNEdGJuSXhWaGkwMXl3U1po?=
 =?utf-8?B?d2NxUlRveWlFcEV2NThCdUoydjkwM0h1REVQd3RXUGp6YVQ0TW1ocyswOGFJ?=
 =?utf-8?B?ZUtsaGhMa3BHYjV3VTlyNEJ5UGNxOFdUOEIxVThJRWE1Y1kzMDNkSUZKT2s5?=
 =?utf-8?B?UHFVRVJtS21FNG9UM2tpbG5ScDJSRkVTWHNXeUlQdWZGUWd2bWxkZklaalNr?=
 =?utf-8?B?WkUzTHZ3WnVleDJGNHB3S0s3M3RwTUJkTmFxZjVzOW92aVd6Ry9yOVZObXFK?=
 =?utf-8?B?OUsvYVJxWmRTbWRFbndMTHZpaXRNZ2ZycllYSWZLOEl2VG81OFRZejkrUDdl?=
 =?utf-8?B?TXhNZGJ4ZGZydFhZVDBEcTMrTjhFV3ZWSEt0c1BGczBOblNsVWg2Ykhway9o?=
 =?utf-8?B?TFBTMURqQWZhemhNeTkvVXdCcmxtYStJSHU4QW1pZXBSbWV3Zk03emJjQmdD?=
 =?utf-8?B?OElvbi9ObmRkcDBsSm9qV1NyMkZuUTcrZ3FDZVhWNW1nSDJVd0EyTjRYSlRD?=
 =?utf-8?B?akFMNFl0L3FkU0srWHBOSUFVaUVUMVY3Q1dUOU9ZRmFlZklGbENxYTRVV0h1?=
 =?utf-8?B?QkNJU2pJbzZzYWs4UitOSnpVSDlKQklIOGRtMDRib0RPQkdhV29ISEZ5Ky9q?=
 =?utf-8?B?WDY2WkNXblJ5T1VpSDRRakdNUk4zWW9zR1MwSUVLQUxNNUgrK1F4Wm0zOXBD?=
 =?utf-8?B?RjRJREdEaE5kTzFJTnA4R2E0aHBZd0RFY1pSNmY0V0k3Sk9hQXBGaklRd3NR?=
 =?utf-8?B?eEl1VVZXY21DTlR1Y3YxTjFiSmwwVzQycC9sRWZVOUFjMVNxNWthTWFGb3Jh?=
 =?utf-8?B?elNoZEFVY1prQ21CK1ZwRCt3ejBuS1dHbkRrL0tlVk1mWHVMRGF2UVFPdE1n?=
 =?utf-8?B?Szk0YVFwN25OU2hlN2tkTUJIT0xSWnVkODE3WTRWY0doNkZBWUcwci9JbTlx?=
 =?utf-8?B?VUY5NHo3WjJYZlhwOHBqMSs2QkoyYTZldkp4TDNhRDMvK3AyRzE2S0hEVUVP?=
 =?utf-8?B?VnBMemVSMFVGUVJtck16WnJUcHFKckY1aGNkRk0zOTh3dFBYcHMyaHBoY0dt?=
 =?utf-8?B?ZTEvMkw2ZzFsWlFyYW1zYndYREJXZStUZTdOdnVJcmgwYVVRVm9ZMmttbkc4?=
 =?utf-8?B?b0RzZ0lnVkNtSGV1Rmc3MlE2ZnprZVRGQ05SYjkydStjYTVMNjJ1MnY1ZGZW?=
 =?utf-8?B?MlRucnhmTUQ2SW9wVTUzR1VqeXQ4c1VVb3FkeHZXWWlrMGN2WXYrbldrUjRj?=
 =?utf-8?B?eWh5ajE4MVhrd1QvZktaM256L2lRNnltR0Zpb2dmaDY5U2s1Q1F2K1g3TUNr?=
 =?utf-8?B?V1dnVGt5ZDJ0Q29lQW1iZlNHMHpKVVNDdHJqUmtDdEdqVkhPdDZ6OHVTYjlu?=
 =?utf-8?B?ZU5VQS9BWjhZTU9lZ1F4M0dkNXlqTzVVbkxJKy9xd09HZVJ3RXhQb2dBZWhK?=
 =?utf-8?B?UEoySm9hd0dUZWI0MGY0M01lWTJieUJ6WjVIejU2Ni9uVVpQZ0VkWmlKQ2hE?=
 =?utf-8?B?bitJdmh3QXR1dmZmNlV4VExQV1FRaVAwMHk0VXdXSVNmdzFvTDdLemc1akVw?=
 =?utf-8?B?QVN3VzdOYkI5NWVCS2xIeW5SRmhsWkZndGdnNUdCdE9IWmlPUFhseE83MElX?=
 =?utf-8?B?Yk1reUkxSXZLeUJEalBxQnZGSzJGbXRFSHg1WUI3UnNMcjZ1cUJUMng3K3lQ?=
 =?utf-8?B?K2FmUElnYjdyYURkZ3FvUFNCS01lRnFqMEpIQnlLY09rUzdublR0dFovaHRR?=
 =?utf-8?B?UXRZNmpnRTlSRTUvSmN4eG5zUG5Vc21kV1I5ME5tOHJLRXZxUXE2Z3gwVUVG?=
 =?utf-8?B?anBrU1JtV1RkQVpmMDg4S3psQm4vN3N0TFU5UytuOW8wUlA2eUpURlR1YkJD?=
 =?utf-8?B?SEFLWExadVJaSFhwMXJJeTVVUVgyMmEzNkgyakh4OUY0ZyswR3JXMk5IcHRw?=
 =?utf-8?B?VDNEMzBLRnluUko1enVNaHRJVXBWdjZ1NXp1UFJRU1k1UHhZdzQzbVgrRFc3?=
 =?utf-8?B?bThiQy9wbDZIRHk0OWJCdEdOS3hqNERBaG04V0lWbENXMWM3MmVWVGhtS05l?=
 =?utf-8?B?LzhNVHNFZDZFVDl0K1A3eGkzVmwrbTB2aGZFdGNhZjI5NURjQjJ0dUVHVllL?=
 =?utf-8?Q?ShtlhR5NWOpm6C8K76Ws0subz?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc50662d-9f79-4c09-2ca5-08dd76491a0c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 02:57:30.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1ZgNmiYauFgdqHQEm18DOQrxjn8iV9A9qNlOOkbkaBsT1ymjPgrvpQ4ebK37MEabN/C7P8viLWXeqwHZbK2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6823

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Mon, Apr 7, 2025 at 6:34 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the ASE state changes from releasing(6) -> idle(0),
>> the idle state needs to be notified to the Client.
>>
>> ---
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> src/shared/bap.c | 13 ++++---------
>> 1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index 650bea2f4..c40d6e051 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -1123,17 +1123,12 @@ static void stream_notify_metadata(struct 
>> bt_bap_stream *stream)
>> free(status);
>> }
>>
>> -static void stream_notify_release(struct bt_bap_stream *stream)
>> +static void stream_notify_ase_state(struct bt_bap_stream *stream)
>> {
>> struct bt_bap_endpoint *ep = stream->ep;
>> struct bt_ascs_ase_status status;
>>
>> - DBG(stream->bap, "stream %p", stream);
>> -
>> -
>> - memset(&status, 0, sizeof(status));
>> status.id = ep->id;
>> - ep->state = BT_BAP_STREAM_STATE_RELEASING;
> Not really sure why you are taking away releasing state, we actually
> depend on it for the new tests:
>
> https://patchwork.kernel.org/project/bluetooth/list/?series=950067
Well, I got it.
>
>> status.state = ep->state;
>>
>> gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status),
>> @@ -1713,6 +1708,7 @@ static void stream_notify(struct bt_bap_stream 
>> *stream, uint8_t state)
>>
>> switch (state) {
>> case BT_ASCS_ASE_STATE_IDLE:
>> + stream_notify_ase_state(stream);
> We need something like stream_notify_idle.
Well, I got it.
>
>> break;
>> case BT_ASCS_ASE_STATE_CONFIG:
>> stream_notify_config(stream);
>> @@ -1726,7 +1722,7 @@ static void stream_notify(struct bt_bap_stream 
>> *stream, uint8_t state)
>> stream_notify_metadata(stream);
>> break;
>> case BT_ASCS_ASE_STATE_RELEASING:
>> - stream_notify_release(stream);
>> + stream_notify_ase_state(stream);
> This is actually wrong, we need to notify the releasing state.
>
>> break;
>> }
>> }
>> @@ -6397,9 +6393,8 @@ static bool stream_io_disconnected(struct io 
>> *io, void *user_data)
>> DBG(stream->bap, "stream %p io disconnected", stream);
>>
>> if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
>> - stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>> + stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> Ok, so this is sort of reverting from bap: Fix not generating
> releasing state? I was wondering how much testing you guys did to
> confirm this is the right behavior, I don't think it is and Im trying
> to figure out if there are any tests for the testing spec that do
> properly verify this behavior.

There are some misunderstandings that need to be clarified. Initially, 
patchset V1 
https://lore.kernel.org/all/20250106-upstream-v1-1-a16879b78ffd@amlogic.com/ 
was proposed to solve the issue 
https://github.com/bluez/bluez/issues/1053, but after discussion, I felt 
that the process of Streaming->Releasing->Idle was OK, so V1 was 
abandoned. Then I submitted patchset V2/V3 
https://lore.kernel.org/all/20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com/. 
I tested K70 and Pixel phones on V3, and both can solve the above 
issues. So my original intention was to merge V3, but after the release 
of version 5.82, I checked the code and found that V1 was merged. So I 
submitted the modification again on the latest version.

I sorted out the process of ASE state switching when the media of 
different mobile phones is paused:

1. Redmi K70: Pause operation, ASE state process is 
Streaming--->Disabling->QoS
2. Pixel: Pause operation, DUT does not cache Codec, ASE state process 
is Streaming->Releasing->Idle
>> - bt_bap_stream_set_io(stream, -1);
>> return false;
>> }
>>
>>
>> ---
>> base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
>> change-id: 20250407-bap_aes_state-9306798ff95a
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
