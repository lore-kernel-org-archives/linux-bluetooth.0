Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021094.outbound.protection.outlook.com [52.101.52.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415ED2E11DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043309; cv=fail; b=UgM/TIQ0LHg+p2/nySLki/4HfmPNwW04H8lObEKoyCL/Qma8g7hDbh2A7tp7c+W035VzHnADJI4BG8x2AkhOMAaYxUJRJuCREBibvGCPUhXvoI4ZLVmHxIfMV3OddhVYI3BQ7sbZU1+7E0d8Z6InccIgmzA9LCSokUsoHjhACKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043309; c=relaxed/simple;
	bh=5FWHbFwmJOB70GNK0nydJQMnhfW7spNzgD4M0cuVDLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5pXoiPBKF8/ygCNpEI1wDWKk/zJhWUa4Mt6QAd+SzSvZXzDXaspMzzU/1rgJcI9tygHNPfkY1SwZU+p9d/H1EcpgvfZB3VtWrChsZpyzFjVtjx9d/Lv1zxrl0hOUPC7nqIcC8nOMCAWSnF3MCkvuItKiskqKrM8jHGRclbSTmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=iXDDcMee; arc=fail smtp.client-ip=52.101.52.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="iXDDcMee"
Received: from CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) by
 DS4PR01MB9388.prod.exchangelabs.com (2603:10b6:8:29e::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 03:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK35207NSNkT5s8e09WeXA8K4oAdqE1b8Uur4bEx+7+xPZyBnh4TxKldnS6vReNRhm53In7aDCPXoh1VcOeyR5dWM+zH3Bo5rQzl2CHKNaYzQO/RIvheoTSREUa8SDQlV4b54lFyx4zbn66D+MpjYMiVhp+AfWJemPOQSs7bDM0I8i2o8fdvosfhr++8U6I4T8qztTDW//0S37J44UH5PkcEvSIOxVlvo3B52rlOwn/H2Y9j01rUbigqXRO97q/9hP9JBYZQ+sQTNu18Oa/FsrSL51xVO1DskgtzsUkCTisVfzniqbqi4qWJN3HXua5csHaRFWs2T71LfA1DTY2wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRXVUhjl1PRq50IE6r9warWG8kZYjxZ02i8EMlXZy/w=;
 b=u8lbRU4mMIUdlp6yBgqQF99Ea+n5xONlgxwNHc2zDEOSxf2sP56WDadok16bCJn669stXXmZ/FCn7IFSraPE8rU7kwpbgIEBjIOOaTCmAPvsV6uVd4eRBiHqtLsQ4W7Eo8oXtCOt4CasQavKRrnjL1lj0XNYExyCprPIJOnPaUru3rhEgpOS8IN03GEAVDeEehe433UM4EgROC/WdUhwAYFFpsHSZlAUAhscVpAYK8W8E6ci0b25K2ylbswA8rKiikAQS1fiJnfwfrzd3IxzNMqma1+jVuvPk+SG5YMFRpx7CFrzU52aS4+UOu9c3Dlojko35q2aCj3K+D7NoyD0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRXVUhjl1PRq50IE6r9warWG8kZYjxZ02i8EMlXZy/w=;
 b=iXDDcMeefIhPFuWXK5M4rV5jO7JRTD2qkIeaI8vaTGuWna4SHYugQeMBtEKOplP0LI+Y2a1KiU+LJ8XuK94kskkUgJb3uq3TSGwHUtJAuEqZbXFNXXPLSoIobgBoiaEErdeIuuKwceZ4e2MtYbsPIw2OoxhNZqwEJ/2swWM2eMs251aG8Vte1DHONDnhbfklIywLhvQldaAjp5PAvAiADi1btMrAxOiA9Rx3HWWHC9mKxXLB45eO4kB1rrf6cJPQ7QpczXg7VnWaIBZhNYOR3g6KyEt4Mmz8bpFAHOoU+QpID1zChwV8NZS7aJ2SV03GLuked9COlWmeBqZoUqRYHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:21:29 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:21:29 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH v2 3/3] Bluetooth: mgmt: Add idle_timeout to configurable system parameters
Date: Wed, 17 Dec 2025 17:21:12 +0100
Message-ID: <20251217162112.444181-4-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162112.444181-1-ssorensen@roku.com>
References: <20251217162112.444181-1-ssorensen@roku.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	SJ2PR01MB8282:EE_|CH0PR01MB7091:EE_|DS4PR01MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3c8a95-6a74-43e5-5393-08de3d885566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OUxkeThkcVdmSy9hQ2FkS09pNUVVWFliOTRzM3BDTFZMQ2tGaTlieU9uRjY4?=
 =?utf-8?B?b1p4d0RmeVBjb2NkZTFLYms2WU5GRUplZXVTNWxzUjd4QTYzTmNzY3owYk5G?=
 =?utf-8?B?RTdEb0pTdGZHRnlvQ0FGVVFERWxhOXB0QWs0b3lSWlg2THowZ09qRmMxdEVD?=
 =?utf-8?B?OW9Sc0l5L1hoVytMU3J5cmZBaW0vQ3VOZ1RlMjFTV3hpWEtaR21OL0Z1dkd0?=
 =?utf-8?B?aFhxMnFkOTVkYmRqYysrc2VFUUZyUTFRUEU2LzIvYWNodk5BK3A0Z09KV3FJ?=
 =?utf-8?B?N2E2Wm5YVStxTld6eGxNZ2dvUFVEYWV0SFA2U3U4UWYwNEVuWVJNVEVldnJW?=
 =?utf-8?B?SUVxSkU5Q2p5QTR0ZUpROExsVTBucFAvZjV6ako3aGUrRjgxaU9LL1VMOURp?=
 =?utf-8?B?Z0hhVVNkckd4YkNYOVNnd09sYk16RUxFMHZoUG13ZGN5WWZvVFJnSWF3Qy81?=
 =?utf-8?B?cTAxb1o1V2ZqSFZhU3hINitnSlFGNzdOOGRhSCt5YVlya0M1ODl5bHVyS1d3?=
 =?utf-8?B?Y25hZzU5bklIdGJ3a09iOExMU1FtOThzdmkwTk5rb2xQUHM3ZGE2cXNvbmg1?=
 =?utf-8?B?bnRRdlIySW9oaTlxTEp0TlBLTE0vaWlBOTdFOEcyWDd4Ung2cUxBUnJWc2RF?=
 =?utf-8?B?Ni9vaUR0NHhXam5pa2haSnVzejJrZGg3L1RRcVVDWkZ0bTQvbkxGME8yK2FH?=
 =?utf-8?B?ckVmSlZ0SkYyd1BJdlRuS2hqTGdUYWk3VXBrUFpqa1dTQWlYVEVUcVFwMWZK?=
 =?utf-8?B?TlppSjNITDJ5UHpLT1RrRHRTSnZwbEJGZWhzK09CSHZJbXRFS0QrbkM1a2o4?=
 =?utf-8?B?a2l3SnpVYW8xYUlrRktmQmMxRzlYNzFnVHQ1QWVMaSt6OFRjZWdnMVJVTkNx?=
 =?utf-8?B?azFka1hMVkNJTFNZRUxudHZiTGo4S015M3FuUk1JelJJSnpjTkRxVTM0V3Nv?=
 =?utf-8?B?aUtFMXYrY3Nmb01TZ1Vrei82Q2RrSCtpR1k5N2hIQkpYZk45VGVERXR3MVRn?=
 =?utf-8?B?WU44a3hCdzlmUDJQRFpiN2ExT3NlQkJXS2kxaG5Kak5MUllIRTQ2bVVGdVlT?=
 =?utf-8?B?N3FWNmZkK2grQ2VCTE1NWFhIQTNwaFJGMWx2MFl3aXhNWDJONWpzdkdlTXZV?=
 =?utf-8?B?NDZhdGVHQTFXOUFBYWQ0d3g1ckxFbGczalJiZGlEV3RuM2JsNG5YZXBodmVv?=
 =?utf-8?B?MWVNRThBTlVRY1JMKzF6RzVzKzZlV3lrZjdiU29RTnR1ZFJ3ejBVd3MwRXhs?=
 =?utf-8?B?QmZtK3ZaSjB6Z1c5OStzWWo0V0VRdTZiZ3NyMDZlY0REanVyNk9zamxCeDFs?=
 =?utf-8?B?RGF4SHBTbXJDWjAwdFp1SFlmM2pnZ0JZVUFWbGE3aStOU2JRYXlQVHVWeHdN?=
 =?utf-8?B?a0Y3cUtTck5aUFNJTEJ1bjBKTUkrRDlNNThZWlRJK1FLOWFtSFhxdGNjT2w0?=
 =?utf-8?B?K2txWE1xbzcxNGFIWGIxK251ZW4yZldJNzh1UGhscUpEZW1GbTlzbzMycUUw?=
 =?utf-8?B?d1ZndmVGZ1lVRDNvYkdsa1lxQWVYU0xkRzc1emkvakxETDRGcE5MME9BNjRH?=
 =?utf-8?B?RklsbHdBZTJKc3NpSlcyUUNZSy9EQ2FJKzMvZ2padVBGNWc5Q0VIMlVnYnB0?=
 =?utf-8?B?TUJPejdMV2F2MDdadHJZYTJ1QXMrNDBNOWt4NnZKMUdKS21BSENtd1VUQStK?=
 =?utf-8?B?ZWZhTnNKV1NpbG1pM1BFT0xMdll6OHRoeUVNU1lONkRUTUpTUXJMOWNLN0Nw?=
 =?utf-8?B?dnN4SkFtVkQrQnkzK1hrS2J3aXhkck1YcFdXdkxFZ1M5b3pLWHRtM2lkTTlU?=
 =?utf-8?B?TnFoN0FRSjdaR1Jsc21Kc28yek5xTW9Lekk1MnZYTk8rWDJuaTJyYzNLUDJQ?=
 =?utf-8?B?Zjh6VklMb21qdnMxT2ZXNmNqcVgzdHk1c0l2Ynh5Y2c0V2lxQ3NKcDZQZ3Fy?=
 =?utf-8?Q?VCDfEu+pqZ6qrMElcFbcmSD33bN7cA6M?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cVc3Yk1XaGdtbktmdC9NRlRwdGRYUDh1QjZTZy93VC9GcmtzVnRSRmxIT1Vl?=
 =?utf-8?B?ejFxa3dueGdsdUh5K1dGOVhiL1AzZDAxdUQ4Uk9nSjZaUVJLNXNpL2l2K0h6?=
 =?utf-8?B?bmt2NGhmT0JZVVpCUFJibFhpd0lFWjIweExUR2F0YnI2YVl6eUovUlNQWmJU?=
 =?utf-8?B?d0xudExQVmFrNDFlR3c4bjQrZUtOM0ZiVTUyN25uc0xEVDJOUTNielNhRHY0?=
 =?utf-8?B?MmIrZStWbXBUSlB6UmxsYmx2TmFxeG50OFhlZUFUdEJkRTZJZ09oczhuSE1Y?=
 =?utf-8?B?UEUrWHcwTk9xWGZZbmtrUnp6ajc1N1h6WFc2T2cvZnE1RSt3S1NUZ081azZo?=
 =?utf-8?B?Rkg4Y0ZmSExRclZrMmNvOElxTmdYUm5hSDFabU9iWVB3ay9GMThWZ1kxWDVK?=
 =?utf-8?B?UVNwQWtFYXpnTyszSkVwZHIxZmRBTTY4emhqdEZ6TEpqWWhyaVJGVjg0VjlI?=
 =?utf-8?B?YUw0aTBmYTZobFpzQjE5YnEyTmZwRHJZcy9DaGovZGJjOWVoOUE5VjBiVldI?=
 =?utf-8?B?dysxWWQwOFZOT21sVmJWRTdsZU51Nmc5TTdseWs4b3lENjJqK25CK29OYjZr?=
 =?utf-8?B?NzBXeVExNmVKSWs0RldGbkVmZ3A4OFlPUDlHbitsVFMrWVZvcml3TVJ2R1Vx?=
 =?utf-8?B?alhjY051NFpoNUk5N3pEYXhZWGRwSkxKcVVOMldRcWlUYWR0bGg5U2sxZnRM?=
 =?utf-8?B?cnlUSjNOajBndXUvVXRvSmZqQW9tK1RTQmF5YVZRbDAzMUNyMGNWcEgvbkJW?=
 =?utf-8?B?Q1Z1Y2JVTmh1MUlNRFhoQlR3MTI5dlc1RHFmM1grQytobWZrNlRGRmtXanZY?=
 =?utf-8?B?OG1qNy9mMHN5RE1LZ0xGMEsrRlhqWjRja1RxWWV2d1ROMFNxU05aWFlDSGZo?=
 =?utf-8?B?WXBtdDdpUjBzZGZvbEdXY0lIS2hZZ09NV1hoZktTbW1pamV0VFJreW1Lemt6?=
 =?utf-8?B?QkFDSkZMbGtEU2RhajMveisxMDQ4dUNoekVpQkh6d3JScjYwUEZ4T1hpaWF4?=
 =?utf-8?B?NDRKTGdValpxUEVhZkttQUZuMFRKRGpRcXFMdUFBOXFmN1plOUtaRHQzN0c0?=
 =?utf-8?B?ZWlHZmlqbWloZDNmMGJlejFQdmg0Qmxqd0h0WGhVOFd3WDl6TTJNV2dOcUty?=
 =?utf-8?B?L2N6WFZBT28vVGhUSWNucVFYMG0zTGNrOVkwTlZIaWNZMktyV2JUZUlMb1hO?=
 =?utf-8?B?MVB6ZVN4MW1xZmRRdWxYdUZzbjk5ejR6dzJSWVhSd0NlNmgwcjM2YmFGaERN?=
 =?utf-8?B?ZEwvUSttWjFXVE4rMDAzV0x3VjhwdnNxVnBQeForSEt5QVR1d1JEOTlmQVEy?=
 =?utf-8?B?V0w1MUp1Qk5PZlNiaEFYSzBQUWMvY1Bmdk9pbkJ1eWVzRnMvZGxLb1Y5Tm5P?=
 =?utf-8?B?b2hOMmlrZzdNWmxBRHBmQThOV3drTUs0VlNUZWNmaTdHVE9QLzkrZ3Z0K1U3?=
 =?utf-8?B?bStCTjNlSGJrVVZDRFJSa1gxNGJnK0c1a3M0bFN1ZDgyTGJ3U2hTQmZEMHcv?=
 =?utf-8?B?Q0pHUThGenNVR1hCSGY1aFUvdzNtcWtGMm9HNHBjbVF5MlBSSk5uSnpSclo5?=
 =?utf-8?B?eEZaZzRkeDJ6WXVDU3l2NGhjRVJ0cFMwU0VMclErenBRVUh2YUt4QTZrVFQr?=
 =?utf-8?B?bGx0ZWRJN1BQUVR4YzBBSjNzNmVQRkN4cFd6ZEZPcDNrbFE5VWhoREo5UUU0?=
 =?utf-8?B?dkRHdWo2Zk5YOWFQNHhZamFqdSt5SGM3aDhvalNxVUI1V0ppYkluYkljOGJo?=
 =?utf-8?B?ZlRSODVTQVo4c2hvTW9oRXBhQnhPODBMdjFTcXh4c1VpMU9JNkt1QUUxalRH?=
 =?utf-8?B?UVpDdTVwczdHYm9VR01Fa28wa1RvalRCSi9iMldyVXBvZzhLd2xpOHNVZTdw?=
 =?utf-8?B?eVErWDFDenY3ZUFZa1hGMDdIWnBtMDFWTU1BR3Z5RGZ4Q3lwSDhZTFVmR3o3?=
 =?utf-8?B?TS9uUnFZOGxubERlRk9xakczWG10Wm44TjYvNFVDNWNjbzFZSHBYbkdzK0di?=
 =?utf-8?B?ZU5HaGYrTFNrVWZzbDhNNk5aUlBpSFFaZ0JGMG5xSEVCOHhmVGVUTnJLenAr?=
 =?utf-8?B?N2wyZlFwN1pnZ0VFejEvNFNzTG9scGxTQ0MxZHhMQzhXUkl6R2htTjdaT2lZ?=
 =?utf-8?Q?MxYWNdoug33LrbvLQ2tcfAsA7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3c8a95-6a74-43e5-5393-08de3d885566
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:21:29.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Inx1a2gNQRHN//6YfH8/6qzlrb+YraGhUSvO1DrA9Tmd3B4pFGZxo8lD1vYqROTbJxlG8enrIOjhRkNHdGrtPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091
X-OriginatorOrg: roku.com

While the configurable system parameters allow controlling the SNIFF
mode parameters, they do not include the idle_timeout parameter
responsible for enabling SNIFF mode.

Add the idle_timeout parameter to allow controlling the idle timeout
of BR/EDR connections.

Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
---
 net/bluetooth/mgmt_config.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index c4063d200c0a6..fdcc752c6f13f 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -11,6 +11,12 @@
 #include "mgmt_util.h"
 #include "mgmt_config.h"
 
+#define HDEV_PARAM_U32(_param_name_) \
+	struct {\
+		struct mgmt_tlv_hdr entry; \
+		__le32 value; \
+	} __packed _param_name_
+
 #define HDEV_PARAM_U16(_param_name_) \
 	struct {\
 		struct mgmt_tlv_hdr entry; \
@@ -29,6 +35,12 @@
 		cpu_to_le16(hdev->_param_name_) \
 	}
 
+#define TLV_SET_U32(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u32) }, \
+		cpu_to_le32(hdev->_param_name_) \
+	}
+
 #define TLV_SET_U8(_param_code_, _param_name_) \
 	{ \
 		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
@@ -78,6 +90,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(advmon_allowlist_duration);
 		HDEV_PARAM_U16(advmon_no_filter_duration);
 		HDEV_PARAM_U8(enable_advmon_interleave_scan);
+		HDEV_PARAM_U32(idle_timeout);
 	} __packed rp = {
 		TLV_SET_U16(0x0000, def_page_scan_type),
 		TLV_SET_U16(0x0001, def_page_scan_int),
@@ -111,6 +124,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		TLV_SET_U16(0x001d, advmon_allowlist_duration),
 		TLV_SET_U16(0x001e, advmon_no_filter_duration),
 		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
+		TLV_SET_U32(0x0020, idle_timeout),
 	};
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -122,6 +136,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 }
 
 #define TO_TLV(x)		((struct mgmt_tlv *)(x))
+#define TLV_GET_LE32(tlv)	le32_to_cpu(*((__le32 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_LE16(tlv)	le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_U8(tlv)		(*((__u8 *)(TO_TLV(tlv)->value)))
 
@@ -191,6 +206,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001f:
 			exp_type_len = sizeof(u8);
 			break;
+		case 0x0020:
+			exp_type_len = sizeof(u32);
+			break;
 		default:
 			exp_type_len = 0;
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
@@ -314,6 +332,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0001f:
 			hdev->enable_advmon_interleave_scan = TLV_GET_U8(buffer);
 			break;
+		case 0x00020:
+			hdev->idle_timeout = TLV_GET_LE32(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.52.0

