Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794522961;
	b=trgsyDkY1ZH5GWMu6gRO2tTvIfWf2VDF5engvSpmQskHuLuU8jcM87Pm1w6FGTbBA9zg
	 /KhsGl6Uo8PENzyP5o0vc3qKYushoNXfz4GG9OL2Q+APpb0qhX9419WsFl0cpJuGhNGGb
	 Hrk4Jq6eKmLp8Sqppg+jPHSb+mFRdicCQvA4CP+1CFLShoqIgluPOD7GIV0LPDSd8OOz0
	 +nTTNDq+pKoUF6Dpbzx3kMxOCi0BzZW8z7zKg8Y7GnLYjLS1lxqybDkNlpd6g2/iu0bLC
	 Uvut5OIZ5isfFVw7+V3T4bYWtybv5R2BTN6ttPz3YMh6Tmj2u9qi3Tbn9dXht8sMNWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522961;
	h=DMARC-Filter:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j1u0YM9ee89yTkuIr2ILkz1fx3Hq3OqZQjFOEJwv5hk=;
	b=e7TE7kZ1Ez3iEqAWXTIR3rFxu3Msu7EFCsuZtqn+QrVcI79bXIfFgYPNPPTF+NFahyTF
	 kXhW361Swcy+XxX5huLS9HiZ6ogn4S6lgPUFJh3Wcu6fPvUgQnPv5DVTPZhctOgvnGAr/
	 MBsB7nUTOMr1gYYWnfr358F5H+6meoNxowAMm1l9VdTcEEKmnfMl6nwZZX96w55bIs0g0
	 Mx9896ObeuChsmBAGbzT7x6aLEvc7hos4qCT95KRVJwni7rqT/GwgMcj2jId0SNRsQTco
	 HnUVtvO4sUu/D08n1dL08v44noPupQlfzLeJ7afH/sHYPDo6dX4M5BgD1aE3m5ft2sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=jwillmer.de;
	spf=pass smtp.mailfrom=jwillmer.de;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.12
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013012.outbound.protection.outlook.com [52.103.33.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53911606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 22:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53911606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwillmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwillmer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i80QaoeCRpbsBqc0gctRbvr8NHdfdqTSBsQ9oQOzskHFZ5RlT9EYwhMl4IC6KXkD6g5vNkyr7ErPuDGtRvJ7Qe7KIXq6qzRzNCL/q4ZO2KxDyfAFah1l+u4vkNjom9L2TS0hHNF2j6oX4HKzRanVAQITNnV9WDTUVdOPqK2URSg9Fyx5USTDt8JtvH8TsJwlXWQtpPUy8zzaPLoiIGJsewJtKulq2OT6bH5BatG8DCArTjb6gNql6gLj8zoWfyTR16ef8Y+LZ3bV/iPyAIiKH9ZZg0WdUMYUT1Ri9o3oLN/4bDDbGQVpU0iW49TiVujAzrZzpF9GGd74McolKHM/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1u0YM9ee89yTkuIr2ILkz1fx3Hq3OqZQjFOEJwv5hk=;
 b=y+AbSv2alrwEUp/Q9TYEgllpN3/nasJk8mZ21RnKyn4PDb0uAdkgdY02dkJYWekdrpAQyX8D67L/xWvVE9qywuHhDxVm8CIN/AXeLNlbK7RVlVNf0pvS9/MvO6jp60G9QWX+cjpGGqTT/WKp0H4IWn+Srz4scPLkEHwVIygUN8G8B7MxcRGBbXTaqPo1Ks05IYJKvLPLteMbefVY+H/m1LZmdbV9x6T6S7+lvn9VO96ZZ1FqykZDC4c6/1O8yik6YvnHb64gv/zTuwLDvYvfShORj8iMT+c9N4c3BVYkIfnHKDJxGoAyGaQRdTkng9ffFccvmC6VU7qGnWmHHaz8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1PR08MB5247.eurprd08.prod.outlook.com (2603:10a6:803:10d::16)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 22:35:49 +0000
Received: from VE1PR08MB5247.eurprd08.prod.outlook.com
 ([fe80::c16c:8c20:cce6:13fc]) by VE1PR08MB5247.eurprd08.prod.outlook.com
 ([fe80::c16c:8c20:cce6:13fc%4]) with mapi id 15.21.0592.009; Thu, 12 Nov 2026
 22:35:49 +0000
Message-ID:
 <AM0PR08MB5236476D29AE5CDA369BD6CFD5702@AM0PR08MB5236.eurprd08.prod.outlook.com>
Date: Thu, 12 Nov 2026 23:35:40 +0100
User-Agent: Betterbird (Linux)
From: Jens Willmer <info@jwillmer.de>
Subject: Re: Bluetooth: btusb: Wait for setup to finish before system sleep
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <VE1PR08MB5247BE2C05F27B1A2675FA25D5712@VE1PR08MB5247.eurprd08.prod.outlook.com>
 <6af5086b.afff5b00.2aa0c8.9b05@mx.google.com>
 <CABBYNZL=1cTSCt_3Nn4HoV62Tqq29Mxi2F73CGG+3hHpdEE-Pw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZL=1cTSCt_3Nn4HoV62Tqq29Mxi2F73CGG+3hHpdEE-Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC40.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2e7) To AM0PR08MB5236.eurprd08.prod.outlook.com
 (2603:10a6:208:155::17)
X-Microsoft-Original-Message-ID:
 <3ea4498f-46d7-408a-897f-e0825dda1f9b@jwillmer.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB5247:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f30be9-fe8c-4e99-8d47-08df410d4c11
X-MS-Exchange-SLBlob-MailProps:
	+bEufbke4JdvqmTQng7ItjpfaCLJSA3uNvVna6KB6oTgb6lhEnJG4i6W29UaB7D91aRN6SfiGAYBiSE3QqMzagwiMbSP7JJQxYirOgAnzPDtdlbVl9TTGZJj9u3vHBkt8zld9TcJvnZavkxjDX29oVP0fTJwk2xQGl9vtwjDBLi6SsPjOH8T0GEk3yCGrxII84NCNW+JNJW6sV6HUFXcGkw/u9xdMG3lNqghEO/z54E0bMixBn1yTslC2BtHZCILlOX9cgRnEHAI7EYESz5qUyKVg4KQ2nDkK4uBAIpw+XNFxmF0udqPuQwyQEaFK6izSbejy77UDJy7LGiTEvZwhE5wDLcDBkH+mqbj9S5wwayAZY8ycEE4R7tP+XDT8zcLc2M9RsJbEEHmpLv7Xuz5PoY5XlHS7YP9+QD2kvOEDCL+BCzgdqqfmt53SI0ZQsA3cC/QA/uaH2tVc4d5h0FuBXvHzB/8QqS4YKIsCTvxhusKGmhGfE+o4ulBsjuQnOYuu/zy5jzExKotnRkzOuc6oiOSQqoDWtukHSltQnjDGFH4WuU1u5ctP0AHLk5VQpE88Gpc6wqLZERRlxOr/Hbd+mjD0nw9C58idwiy70qh9tczTtVUAhC3yD226W2+zrwOQSHnhIdNdEZFZo1Pxt0r8qbsqzWxooZNFZkumW+8bY05WA0F6GB3dQFOjIH0roysJyR+NOH/2050Gl0HFDR3zk0otP80nxO0cmjQ05vwiBrbWv+XE9G4YuquorxsLqV2pknspSI5Nyjdnr9ZEaXK+A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|5072599009|51005399006|23021999003|6090799003|15080799012|25010399006|24021099003|3412199025|4302099013|440099028|56899033|1602099012|12091999003|10035399007|40105399003|1141799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjhnVlJpc0Rxem00Y3hMUDZid1NpblN4eVZFQTMvYzFja3A2Z0NMQXBJVDZv?=
 =?utf-8?B?RFdkZFRoYmJFZ29QOXRWQ0RYRy8yZU96YjUrd3dVWUpUKzB3K3Z1Nkg5R0Vj?=
 =?utf-8?B?LzNKZ1hYZ3pZUk9ndjJ0M1gyU05OZll3THE5RWlkYTZLblpLVCsrQXNjdEEy?=
 =?utf-8?B?VThUZWRYRDBGa3RIZjNJNkhVWVdmOEE4RzVselp3UCtCQTJjMEo0ZkhPd3ox?=
 =?utf-8?B?TUZmeXJIczFJWHZuQ0FYellMZ0JCcVJSS2dxWUxlcDZmbUUvK2tubG83YmVL?=
 =?utf-8?B?Zjk3cXFyV3pUUkVCcksyNjdjSXp5L0FLSlhlUW0rWGNRYWY3OEFMc09iajRG?=
 =?utf-8?B?YW9TVDhjNVhTYkwvL2IzNVJRYXRUdkw1OGRvQ0pBL2JPSHBTVDFLQnNpR09m?=
 =?utf-8?B?U0lURStIaWZEZ25oQ2RGT04zUGtBaGFIa1cxNGNjNDk1NzV5eTgwNFBGUldr?=
 =?utf-8?B?V205VVFmVXpRTEVRTFY0U0ROZ1RQK2VpeE1QZjJmWnNXc0J4NCs5VzlpRHRq?=
 =?utf-8?B?N1NJa1p2NHBFY096VVNrVlkvUjd5cDNXSmV0MmJzZmJ6VHd4TTY2ZFNlMzNJ?=
 =?utf-8?B?ZThhcnZFcjEwSllRNyttSHhtT2N2dzNGS1NHbU5GaFJUMks0ZENKaXpWY1ZD?=
 =?utf-8?B?UGN2dGhVV0F6SWpLOURING9iZmcySXJUN0RrWVp3SFZvN1hpaER2MUN6blEv?=
 =?utf-8?B?bU5WbTNiZUxjWFF5K29WRmljaSs0cVNybHByZ2IzVm91RlB4SElsOTZDNGow?=
 =?utf-8?B?R3YzVzE0MGlwdkRubVN1cXFNWnpBakYvUlczamxnT3UzSnlIWEFPMVZpckRU?=
 =?utf-8?B?K1dSNmNIY0VzNGJkN2RDMWZSWVFFdllxMkh4eHJza2JTZVJvSzFaa0l4cXB1?=
 =?utf-8?B?VW9TMDZqSy82NE5GKytqdnlWRVJNdFhrNnFnMlN1bWdqZ2tnV2dBL3phNEJn?=
 =?utf-8?B?MVdFMzNxZm40Y2x2WSt3OVRsR0ZKQVNWUlFVeU1taDVwVloxL1hzRUsvZ1Bi?=
 =?utf-8?B?SXM1S0dxU2NpWWduQlhtRG5IWTREU0hiSThCTGNQZWw4QlB6eHdMSEljN05r?=
 =?utf-8?B?YlVFejRGRnFHM0RSQitHcU1leGs2TEdLNTBnTUZXajJ1Nmc5a1JIdkx3T2x4?=
 =?utf-8?B?SXhNR2kvdmNSNXcvZFpvRXNQZUlwbDROV3RUWW5zUzJMK3E4M1hGSE9ucmpo?=
 =?utf-8?B?VmRQTll1SHg3L1Q2RnNFV3ZsMEtaWFAvbGNoRnN3WkNXQllSdENVUG5mUXgw?=
 =?utf-8?B?MVhjNlNzSG5EaysySTluOURjRVovUEhlVHl1MCtpcmdPQUpNNXZDSlEzTzll?=
 =?utf-8?B?OS9PWUxTck9mL3JSTkg1T3N3aDBOYUtUbk0zWHJpa3R0MGZRWjQyS0lyZHd6?=
 =?utf-8?B?RGhFelVRcnpsMDM1RUlkRUhtZTJaVHN6WVVDdmtELzZrb0l4ZllJUVk2NGxL?=
 =?utf-8?Q?vrELbaBr?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdJYjhRcFJwUTU0eFd0NEJvV1VhV2psdGN1cTZDeDNNU1YvT1RybDAzNk43?=
 =?utf-8?B?UUJrQktwTi9wZ0FXbnFsWGRLeEd0enlKZERDVGk0K0ZQUGo2NSt6ZVpWWkly?=
 =?utf-8?B?ci90dDQxQTdhSmMxVWc0aEc1R2RRaDVUeXF3RlVETEtWKzZyUnpONTM0Ni9j?=
 =?utf-8?B?RURNazRBbXN1WHlCNTFGWmFQV0h0eUxUQVJnUHI5S2RhcSsxWFVYYTJONWhk?=
 =?utf-8?B?ZHVreGZORnliRTZyc1pDWk4rN3NYSmU4cHBuZEJNRUlBa3ZVUVdDY2J2dUNN?=
 =?utf-8?B?TnlYdk1DYmFPVUtKQ25WVThkd2hxL3BEbFE3UUZzTFBGcUh5MzhoclJSYXg0?=
 =?utf-8?B?R2EvSkR2UWJSejJXYnFpV3NIQnpWdzVWSXowQ1J6SWZGS3dSWTY4M0JlcEdt?=
 =?utf-8?B?WDdjTnZHM0RtTnhuYWR1Ym83UE1tY2lXMEIrcmcvemdSeGRocUREQlpDRXhX?=
 =?utf-8?B?QlVxWktQK3p1Z1hPbTFSN2RoaVkrWVp3NHV0ZlhXanl1ZjMwbnZHRDg5ckNE?=
 =?utf-8?B?TmRQb3RDYytyN0JxKyszT3JWU3R0NnF1bUMwTE53QzJDQzBUUTRHZElEaWxr?=
 =?utf-8?B?WFdIN1NvR3lBdlpLQWNoYkhvN2NPQTVDbzNtVlQyZWlxMzU2RTNpd0hoWHN4?=
 =?utf-8?B?cEFTVXhWMUxKY01TY0g0MjU1Ui9ZNmYyOG1SNElUVlJuQlJCTGNRNG5MaDkx?=
 =?utf-8?B?cFppNUwyZzZLN1lUb3YrekhsZ3c3V0YrVjFiVW1rdmtkZ1ZIakdJcU1zTU1k?=
 =?utf-8?B?dXg2NmlZcTFkU2Nkc05NdHIvV1VMMWpaRXl6a0s5aXFYeTJZVWRMWHBUM3NY?=
 =?utf-8?B?ZUw1MWtWV2FTMEFzMXZIYlNLdUxMMFJkNjhXNXJLVVlFVEw0U0gwNlo4a2Rr?=
 =?utf-8?B?Sm84WEw0QWFEV2Q2Uk1yMHVoMFFaU01tbisrd1hxQ2RGVTRUTUVNV0JwZXFy?=
 =?utf-8?B?SUxXdlFVQ1diQnFpUldzR3NBclNtZFpobE41amhFTGlCdjI3YUJ2NEdSc25o?=
 =?utf-8?B?Njk3R1o1OUp2ZnJ4QWg2UFNVN1Nka3hXWWRtRmp2bW5hUG1aNGJXZWFMTndR?=
 =?utf-8?B?VGZyMEhCRDBlTUd2UnZQMWFKUVJSZ0UxWGt2QVVBeW9HY05KbTgxdGlTRWF2?=
 =?utf-8?B?Yk8zbVBLdU9QdnF2S1M1T0NvdkdUa0xPYVRpSXNlY1M4RTRjMUdoZGFERmpa?=
 =?utf-8?B?dHNsZTBxQkx3OEgvbXVnMkliM3plWTN5ZzU2b3NsNERVRk9CcDR3S0R4Mk5L?=
 =?utf-8?B?NnFNdzc3VjM2UEdKS05BY2VOL2hvbnRWOVg5RGsyWUZPbFpJOHFNNTE0a2Jw?=
 =?utf-8?B?aHUxdkhVRTF0WE00ZStjZU84akpGN1ZuNEJqd2thWExqOTN2amtjL3pOQ0c5?=
 =?utf-8?B?UjZKeW9ucE5xdXRma1A0eTQ5eXRVZityWE1hTWcxMzFyLzR0L1dpREJQV2Zn?=
 =?utf-8?B?ZWsvaGFYbFBwbUVUaDN3akJvQ2EwUzY1cVUwREtVSDF1SHNacDhyQlRyUWRx?=
 =?utf-8?B?a0pqUW8xdUczdFh3ZVNsTk1haE4xTGN0V3hlRGFuZVlIL091eEwrN3YyMTVv?=
 =?utf-8?B?QVpIZVREdlI5MWRQVVAvNy92UHZYbHNYSGJxZ2ZmNTFDQjV5bThLNEs3U1Vz?=
 =?utf-8?B?RG41aElFOGdFdHJPUy92NDdtMEVjN3IzdUJvcHZXNTVwY1ZXR1VvSFFpeFdU?=
 =?utf-8?B?ZE1jSlo4bTh1a2M4Y3RjdERxYkFjaUhQTXJTb0o2ZlZ5NDI4SmtXQXQ3ZGp4?=
 =?utf-8?B?UUM0cHhrSmdqMmJlQXdPOU0yM011aGc4a1hqUmJRU3k3ZmpzeEI2Ky9qVk83?=
 =?utf-8?B?M1pWMVc0cDVta1k5RVU4S3ZWemhwNFB6K2U4cU9OZ1pVUXd2RXNCd3oxSHht?=
 =?utf-8?Q?aT2BWeJR08Hwt?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fbb9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f30be9-fe8c-4e99-8d47-08df410d4c11
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5236.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 22:35:49.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653

Hi Luiz,

On Thu, Nov 12, 2026 at 14:25 -0500, Luiz Augusto von Dentz wrote:
> Sashiko flagged some problems with these changes:
>
> https://sashiko.dev/#/patchset/VE1PR08MB5247BE2C05F27B1A2675FA25D5712%40VE1PR08MB5247.eurprd08.prod.outlook.com

thanks for the pointer. I went through the report.

1) Circular locking with dev->mutex (Medium)

The two device locks in the reported chain are different mutexes:
btusb_probe()/btusb_disconnect() run under the lock of the main
interface (data->intf), while btusb_mtk_claim_iso_intf() takes the lock
of btmtk_data->isopkt_intf. For a deadlock, a task would have to hold
the ISO interface lock while it waits for pm_chain_head.rwsem. In btusb
that would be probe or disconnect running for the ISO interface during
setup:

- btusb_disconnect() returns early there, because the interface is not
  claimed yet and has no intfdata.
- btusb_probe() would have to get past the endpoint checks for
  interface 2. I do not have MediaTek hardware, so I could not confirm
  that it never does.

There is also no lockdep report to expect, since dev->mutex is set to
novalidate in device_initialize().

So I think this is a false positive, but I cannot test it on MediaTek.
If you prefer to rule it out by design, I can send a v2 that drops the
btusb notifier and does the flush_work(&hdev->power_on) in
hci_suspend_notifier() before hci_suspend_dev(), as offered in the
notes. Tell me which you prefer.

2) Use-after-free in btusb_bcm_set_diag() (Critical)

As the report says, this is not introduced by this patch. I left it
out of scope here.

The GitLint failure is trailing whitespace in the notes below the
"---" line, not in the commit message. It is fixed for a v2.

Regards,
Jens
