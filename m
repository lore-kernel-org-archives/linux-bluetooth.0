Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793933877;
	b=gN9gDWn2XGEHXQnVeg7w/3jarRVyi/sszO62LiKP/m8KRJ6F9qg0kC+nI3IxMZNbp+w9
	 TzjxCspes3BkiGNvTJmiv9d+uTyAzUBZvd57L4yQJmWSK/JzHpLitrNLsQ0Xrc3bn5M9z
	 6wK4Fe5D8zS0x9TNRsbap+WbEMjQKhe3Wdd9gF9HcQTf+EdChH1qOaDWJ6djfsQePw7E/
	 8xZ6kkakvq1uwQHCo2sM4uUoqi66dCV33oVpqsdrsNWzvpCvEQWbO3aabQ3TvaJ9HWlPq
	 bDjuamipOcRZR3hyVamME3EhXMCJHvtjA3Bq+Tmr4T38Xzv4IwORGvtf51BDdS/wYjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933877;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Sakc8iPOwBSEGraaTgtKYH2NnG0cfSLpR94nwwlrRwQ=;
	b=r0fVL5lxccF6mUjCh1wmowv2V4r2XeayqyVsRQMBvXCq7yf7gAjbbjwUnUKnpS9RhBOM
	 sAB+TfZqwFXRP/clF1zhZOBmCASPpy/AmzCMv+OugfqrbFXxsl58/zYCmcBAF5usmzz6U
	 vryi4uxEsDw2gkMs2sgW2DEi1KBog7+P5FCwCFhVoQzaxz/fn3H5dCLVGBL9VIcgv/O8c
	 Clndsox3y0HQNq9eX/5ue7eloMBRm+ISK4axNfnWwgZ6wvYk9MC4S8bgWV7+Tutt7vpFp
	 XefqMlKCP9y9E8/Fsk7ukz8m6/uxsgT9f++MIgPuU194QvFjMH/rm6kwLtqmE//MtWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=reyW22q7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.120
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022120.outbound.protection.outlook.com [52.101.126.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B73606A31B;
	Fri,  6 Nov 2026 02:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B73606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=reyW22q7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hujCSypiNleyRobcLlNgQPO3sfl9QvgEyPMWovADMQuN1Zf6qMGC6VGo7422q6FH+Gn1uY4fKqUiqnmB4i7+bh8J78ZhUblx4kkqJvbOzuPwkczMuHDuuqqYYYErTrxCoPJqddPWu9Z+ZoOi/fwJqGqsAJb67TdMgQre8LYDlnme88mgPNOCtDMkmooMkHrVvN+E3aTILPUVMDdz/xnXeb32RAg61QpaSzrx101XSgijSeZb20CpW73+eACiOFIQReLrROgzErwESr71gniZe4QoYEVPUV0weLcANUshChGa+96/uCIqLcUJHlirLP542HjKcJOtFnol506rZ5pYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sakc8iPOwBSEGraaTgtKYH2NnG0cfSLpR94nwwlrRwQ=;
 b=Jo4hS60782O1YO/6bAxV3cLZSU2OlpcUrVroxOZmXLOhBx1vJcHlsSIiXnHsOU5m/Wrj0Cd1ZwilnW7MvIIF75c1BBwX5Qc/AOjTRq69ZsOYYuxfH5HKG9IVpeUA7u72RNwyFP1U3lqIP3pPz+QALi6kfMMVbFbS20/oeq5SHgMO1cLVVcOyoi55e5creptuN2sXksWkyqeW5icTESgZeuvoszlbFdNkUtoA24qLu+7ZkUoLKc8CCOX8+bS4VoWCXReSqQsBsZJFC6IsiQLpKHC64ROwt8X+PvVXPBBy+EgpeBmlyphzpqyItpMYXyXtaPU68WcIa9V9IEFv8Lxuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sakc8iPOwBSEGraaTgtKYH2NnG0cfSLpR94nwwlrRwQ=;
 b=reyW22q7YTJNqRMbpaLWIUq9R5qirLLWlD9N7Vs4iJlKeQN//MWK7FdaujprQ3HNAv7V5jdUSEwwDFkWmTY3Pd1GfeoE7PYy0bjmA7byJp9ia2WV5DSGKgO8LpVSZmBmnSofCjBgtDNYypJGbHF8pdd20tzFHLUHMtibJRB3lWmHaF/x3NHyMpxKtx4DSBDlNEVLDzqNcqqSnzIFyMpOD7UaXJOsycGVfvAkPAd4j/u1K/RvDQHW8wJ5DsL+k06M1hAFP8JXwKSwjM2XaRoPJ+eE/tbioDJXNUvdWFeYTNbbZjSf362FMEBGfMQ9qBuXRUaAt8TQsWdoGSowL4lxZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by SE2PPF0DEAE0EC0.apcprd03.prod.outlook.com (2603:1096:108:1::488) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 02:57:52 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:57:52 +0000
Message-ID: <7cafbdb9-1411-46ff-976b-7c7b8ab09bfe@amlogic.com>
Date: Fri, 6 Nov 2026 10:57:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] Bluetooth: hci_aml: configure the RF for a shared
 antenna
To: christian.koever-draxl@student.uibk.ac.at, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-8-christian.koever-draxl@student.uibk.ac.at>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20261025192338.209574-8-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To JH0PR03MB9035.apcprd03.prod.outlook.com
 (2603:1096:990:7c::13)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|SE2PPF0DEAE0EC0:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc1e697-727d-4903-5e46-08df3bb1bf59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|4143699003|261102123227099003|261021123027099003|10067099003|261022075727099003|5023799004|261021121427099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TZFoGpg1nMRpexT0tMDGVoIDXFrdz9mAj/zyHBnw4UeUqlJLtnWPr37taJk2n9HiJZVXqSCKWmkgafdL4RFLmir8cVwtQWp2gZcnRgS4D5xxSGU2vf5sN3k9dA5TXgbP1/RYs/OHQZyFXXFU7hmWuNUGsG4Zjj17vVugIbV1HyQ+ZWMToIwtN9ghESCq6UKaF3sODdEtFZrSjfjhZp4ndKjMozveP7GDjzh1irGmCh6/4QZZ9bHGX6nXUqMjMYIXFep6pF5H2unUzdFCE2vyfLgAgG5c8cV48IA4Fa6BMZ9UlQrCxhaz88kurSovceF9IvY7N2J+Xu+PzrJKxmWfss2WIJGhaDx3hQpR6Wf4kwHpMBJMFcoh+r7+SGSvnMKRHnDElso0n6CexwX5Nnb9tZ3k7jNg32RKA1Ekwfc5sIVgVCQWF7w2zwxk+CT6aBQ2ClLnBoWtgqobLRXqYfh6QdcWkyenw6EZVgn95fjTKFdSALEsLANa9cHFKsjupisyqPNhXaopaq3zAH+3wFnEXGqN+rU2k8rNOI8C5B1GZsZT0+fnNDa2X9el3BaiYtMbvJ4M7vGKHPDQWPh63ByN5SqrBh1IkB6z7JhdXu6x0kzVQ0sRKrq5YlShwyBqbYw79nnEiiIIIMEr5d/4Je2VFWV+jQSp2oT45gMcLNqK67w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(261021123027099003)(10067099003)(261022075727099003)(5023799004)(261021121427099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZJcFlIYUVjb1VMdklQZXd4dEwwNGpZeFNKLzV2UFFEVExHbnhwSWxWTDRN?=
 =?utf-8?B?aE4zQ1NkdWRiaWk3cjNIOXR3eFo5alAyOUtzMUhLN0ZVc0EzbEsxYTVnRWJE?=
 =?utf-8?B?eHVCeUQ2V0w0NVlDbTh5WDlOdjUxc1pGdG96aTcrOUY2Z3RUcnJqRWIvL3A2?=
 =?utf-8?B?NmdTQStXWnBhTnZjSm4veEhyZThtNWNHRzJPTnRHbVhyVzVYR3o1SnNTd3cx?=
 =?utf-8?B?TjlDSGc5ZEZUamZWcVJrUXZBYXRvblpGV2ltUXcwUzFIYU9hbVhCallWbEZB?=
 =?utf-8?B?WC9yNHVhRVdFT0J5ODB0MGU4WEVCM3FQRjA1QTk2dXdNSmxyaTM4ZElzbXpR?=
 =?utf-8?B?akZIeCtERk1jSVJjWEo0b1FJMzcxK1VNeE9VMGNHaDZGTzlJaHdsemRsZ2FD?=
 =?utf-8?B?VzMwM00zTG1adXJtQVRHV0xYek9kRXg1VjRabmExOCtTYzBlRFVsWGVUbmhS?=
 =?utf-8?B?a29jcEhHcVRzL25sKzZDbXA3Ri9PYU1vTFFkb3VybjRWSkdWcGkzbGI4Z2RL?=
 =?utf-8?B?aGlLb0Izc1lhcG5PSCtYVFhBQXEvN0hvanB3NU5KOG9lbkdESWpiQXVoeVdF?=
 =?utf-8?B?b1Q0VWhBdCtuUDZnVFYyNFRwN0MzWGpWcGhKb0ZGY3BCMWV3aXhVYzhOZHVy?=
 =?utf-8?B?V3V1eFgrelJaUEIyT0d6bkVnRUVUMzNFSHU1V3B1T29TNDJCWlBaVlBnSkJz?=
 =?utf-8?B?UDhMREsybGMzei9XTTlzbkpTdGN0SmN1TWVydi9WcXRFTUJxS2pRMFpRdkVJ?=
 =?utf-8?B?NE5yQzBPYlhXSEVFTEZYVDVvMng3REF2cjNSY3orbDcyc3U1eUZCT2dKMDht?=
 =?utf-8?B?TmFMZ0VhRVMyNExtMUhpaUpodnhVQVFIK20yTVlSWmVWc2p2dWJ0U0lpS0xM?=
 =?utf-8?B?SWgzV0N5RzBpdGx3NkVwR2NFWWx3NmlsQ3VDSVN4aGFMWFhsUmVhbDdqQy9B?=
 =?utf-8?B?cVNzTkxYZHJPclhtS3hUWHlYZmQrZlBkRzU5Q0gwaEJMRUw1V1BwMFVVRkJC?=
 =?utf-8?B?WlQraGVLWmRUVng0Q0tSU2l1dnM0Y0pHV3UxMXZpaWViVytqMWEvMVhQQzRZ?=
 =?utf-8?B?SERGdzhyazdGRjBUdy9BT09sb2l5RlFEM2dwZ2ZPb21lV1RPLzQxbWN4Q1Vu?=
 =?utf-8?B?K3l4ZklNVmVpdkxteTRpS2kyL1ByejIvaGV3amJEWG1oT2RxR1JwWnI0K0JO?=
 =?utf-8?B?VkxFSGJXZTBjV1BvcUxkZjFhU05PS3B1V1FlcGdCYkI5UVJFVUVHbFVuMXBC?=
 =?utf-8?B?N1pMZTRPdm94ejlGb3FBcktBSENrRWJKdjdoYmRnVm1INUtOMW1ZM0psQnhN?=
 =?utf-8?B?bmxtU2JDVEpUU0hQYmY4UU5ubUY4bG8vU20zZlNpVkRKUFp5cWRXaFNpbHlQ?=
 =?utf-8?B?WmtoQW9zRmxFZlo3Qnc0VjJBa2s4WE1Sc2pmVkxxUm5MVFo1R2Q0VkZ5dzc3?=
 =?utf-8?B?S3RMR0VueEVIN1JRL0s2ZU1XTmZsemZEUkhNMmJIWWRCQ1pyUUN6ZWhiaUdJ?=
 =?utf-8?B?eUJiR2dBUTZHNklSejNyK3YxSWlPTzhPQU1lLzdUeUZ2WkR1WFRRdkFib29O?=
 =?utf-8?B?UWVaYlpza2svbGFkUmxMZk15OG4wYWJsNzg2bHZ5cXU2U0FWdmMwTGJjR2Vw?=
 =?utf-8?B?RGdzMDFOWG13WmduRllBeGFUM2RYM3JtU1BDK3V3UUdVeGpTOVZxT0R6SXZ3?=
 =?utf-8?B?TGZVRTdjMUJDRDdmc0JEcS9rVHNyYmwrcGpLVFdEejh3OGlISzRxcUNhblFF?=
 =?utf-8?B?b09PUUZiVVlhK2RrYmV1Nk0waWxzR0x1NHREQTF5RDdJUmUycWpRZlFQWmVD?=
 =?utf-8?B?MXdZakllQjN2YzJ1d29ZSnBsZVlaQUVPV094M1E3QXd3Y2p1NnJpU2gvcnhu?=
 =?utf-8?B?WnphdkRLalliRGNKczRtZUM1bzloRWtJVURSQTFieE90d3F4VGVud2Z0NjQ3?=
 =?utf-8?B?ZlFMZ1Fnek9hYlRnZWJQN3FpWWdqUzdWaUwvck5pVHdIQjFRcVdPSFdHckVx?=
 =?utf-8?B?dzRQZnU2ODhVMUdVY0RrTGF1ZlVWWWFwRFFFcUpTUTU5Ni9vUU0vR1N3ZitE?=
 =?utf-8?B?NXRTOVIyb3JVajQ4eWZrZkNMRzQrNkN4a0s0VE9jRy9pekxzT3JIb0l2UEsx?=
 =?utf-8?B?SVNmVEZoM2ZTdExEcXB1MjQyZlBGbWxFaU10TWZYL2k5SG0wMGE3VEIvSWRQ?=
 =?utf-8?B?U0I0RGNNMDlOL1dOZDdVK3JId2FSbWNhdFJZUkJEWDBya2Npd2ZsUkxvRUgz?=
 =?utf-8?B?RXpua3lqR21ldmdTSnErUTVjUEovV1JIVnV0QWpUR2NVSzdtS2dNM1VFaE0y?=
 =?utf-8?B?MkgxNExlNWNkTEpkUGdGR3FOVkQwRUx2RTBQclR0N2ZlZHRCcTJUUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc1e697-727d-4903-5e46-08df3bb1bf59
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:57:51.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: durdtas3U/1Ut0y4o4VUHYNGBTKO6vZtqOC/aHGrBm9XYdGNmEtieDRyjTZEBxEsYqrEIuEXOvu3hFLDHoMu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF0DEAE0EC0

Hi,

Thank you for your patch!

> From: Christian Stefan Kövér-Draxl<ckoever@outlook.de>
>
> The RF configuration selects the single antenna setting only for parts
> flagged as coexistence capable. On an S905W2 TV box with a W155S2-class
> W1 chip, Bluetooth and Wi-Fi share one antenna; with the default dual
> antenna setting the received signal is about 15 dB weaker.
>
> Use the single antenna setting when the board sets
> amlogic,shared-antenna.
>
> Signed-off-by: Christian Stefan Kövér-Draxl<ckoever@outlook.de>
> ---
>   drivers/bluetooth/hci_aml.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
Reviewed-by: Yang Li <yang.li@amlogic.com>


------

Best regards,

Yang Li
