Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE17E578
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461211; cv=fail; b=gg0SLa6+EmB65eHW6lH4JfcUH6lHIdeShEvT4qp207dhUI6YOFeUQQHMZBBxCNj9prtqrgt/a5gIgiPcbQOdScukNyamJ5BdR+aXRkaomY3lrG7eG9g94EDHym2nH8cbCrpxt8uSwrQcCpWNgkJtSdH1JHrOyBNjZttEYdGpn3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461211; c=relaxed/simple;
	bh=rVqJsXFUfcQ/tmWgvxQ4j41YymKu5swBkjBSIBk9pJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0a/eK9yP8gkJcTxVQKrv2Q8jR7MFFIAYTT20qixQ2xgjWbEPJVqbM+Wi21/UhoCsVRCvTeuqwsa1qeIQhKxrMVvsdERpSyU5AJyyhA/LCEV6xMNEQK5ImvyXHrwJl4Dnt6HOcP7lAmjLE7b28mKsTq8QsI3MNUBba/WF0H0fMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b9EbSjK6; arc=fail smtp.client-ip=40.107.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b9EbSjK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMPQGId5UUndqkZU1LAn/roaNEemp7CMsZxMuw7QeY/+I6+/b1eoUQ2iHsoyuLS7eRjXxdmrfAAn3CSPtbIYUyIxnfOn7DWurm8KObKvEaugRQrjBcpYL8SK2SGZ+xjHBlyGBJ2CB1eDmr118uuMpcUrSWaNeO9Jt3QHber6c2V35/r7WLbzi1h/dNTn0WM/JXeEJRHeS17eaY8sBbB3v2+1Vn2dyETkkkwA6mPTCMNtY/dyP+nLIVrIBzIC+tlmo9NbYgJfngVD1sOKm7RDAqsjvoqtdzd/MyiqCkJZfdeH5IRxnZE4AT2SbC6oYn1aqrtcaNNp9alrZDlOJUKKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHZ7owULaXQMxH5SYwFr1DywVHCvr81HQd82gLEoanU=;
 b=k4RPeRg61YY8C7GHk7FqfTkWvIKKkMxh7GLzRUeKwKh+t9BI6k3IExUAmz62uNnkHcCr6LyKd1mQ4uPKhiD2ZcjAbQvTlEXe7i44W3q6kO0G95MSedyxJrM//ydf6FiKvSFO89MgrMrokzd5ETTSJHKnQxT1CR/jU3JIfcpfJRGNzQfhfWOCo8797p8FBDffzvGWhukjaBxd/b5BUMMejdc48QVmPD6fIqoCgYo2IW4ZY+nik3SJEC+8k9mOnCaWS/xhzCTrA7tOQRxx/dOS6j/AdNnasEiYMHvklFIJe2+5qaqKf1QfMDCeyF4R/byHyarTu+O+jIwqu5SHjTBm+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHZ7owULaXQMxH5SYwFr1DywVHCvr81HQd82gLEoanU=;
 b=b9EbSjK6a4ZCUL1kun0Ves5bstWFnbkJrYibMcozzlgHa52D/0hjTqDyX/cwz9SM4JQ0Wm92sVhtFmTGnwIzhw7QBqn56Gfjh/1M6e0ibXSIXl/qpMTCj1nwoY4umeGYHEfGAGgt9siE4DuUxUvwHCwvUSD3wLH4r9Nj1UfQPw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 23 May
 2024 10:46:46 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:46:46 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Update BAP Broadcast Source state machine
Date: Thu, 23 May 2024 13:46:43 +0300
Message-Id: <20240523104643.18999-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CABBYNZLzSW1VBxZE_f=Qya31OerUxHuwHFOxQJtzNoNt29ia7g@mail.gmail.com>
References: <CABBYNZLzSW1VBxZE_f=Qya31OerUxHuwHFOxQJtzNoNt29ia7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0179.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::34) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GV1PR04MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c277cae-eadc-425a-3266-08dc7b15a417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktIbXRhc2lPV0JCbDJrQ0hRV2dQMFFPTVZOV2pITjArUnAvQ1ZyQ2tPamN4?=
 =?utf-8?B?UENqK1h0WXY3NGtxUGFLYm1uajhMdThsWXNTNktzNkgzYnFEcU1aeG4rUlZF?=
 =?utf-8?B?d3NFT01vZXJyckNwcnlFY1A3eng2UWtHL2ptOFBsL0ZXaWVkQ3hWK2swcEQ1?=
 =?utf-8?B?WFNnS014bXVvWnh2MitoWHk3b1RmMk9HQUtzOG1wYnVadFRuVGd5QkxnR1BK?=
 =?utf-8?B?TjBHdkNOV1BpbzY4aERISjFHSEFQTUtlLytqUEpBbEtIZDhvQ1pOVVZKbzJ0?=
 =?utf-8?B?NWdkVDdhYTF3aStzZ2YrRTBQQ3hJQWk2aWpxSjhCeFR1QmtsbFltaU1OMXdP?=
 =?utf-8?B?Ui9XZWhtSGRpQ2E5N0FTcjNQSmRrRHFKa1djNER6UzRvbnpSSkVjRUJPeHFF?=
 =?utf-8?B?WnlhcW9QdTFsekUvZ0VISGQ0N0s2bDYwZmppaHo4ZExLRzIvci83Y2g2MFNy?=
 =?utf-8?B?NVgyYVc3em1Mbk5vUFppUjl4Z2tyZUlDc1JzWEhFQnJqTFRYVExCaGRIWklZ?=
 =?utf-8?B?aXdwS28vcVRKbHFEeGhEN2c4ajlaTGFsbGI0d0htMVRxZFRTNCtVbEczdU1x?=
 =?utf-8?B?YWFSV1hCOGRQSWhMTk9taE14R2hLRDlrMERQUmoxclQzWVgzR1dRUGFZQmZJ?=
 =?utf-8?B?T1JrVjlqNHhqb202WkluZk1BQlNqSExFNFN1Y1ZiUjlWeVlDVWhRSXZCdTFY?=
 =?utf-8?B?NTVtZlZaU05jYU51K0tyaEdZVUhIdlpXYVRjeEIwK3MvK0RPN1VzaG84TXNu?=
 =?utf-8?B?UGhEbkEzS01PSkRNa09GZkt4c283TzZpQmF0ZU1XeHVZVS9KSGplTEsxemll?=
 =?utf-8?B?dU15MXZKNnQzYVJrTm5RWlFJbjFsVzI0NUNwUENuL1E4SFA2L1MzQU53Slgv?=
 =?utf-8?B?QnFnMVVoalRudGhKbDdJcWY2NlJ3TlU5TTJDdnVHY2NZR3B3M2dzSUJuc0sv?=
 =?utf-8?B?WGM0SFpGVUxIRVFkTVYxd2plS2h0TjVESjN6U2RScklMM2ZtTCsvZG5CaHMv?=
 =?utf-8?B?R3VySVlrMHl1UUpNV1lQa2ttT2x4Q2hkRUo4MzVkVk8zSHIrY1RaekU4Tmp0?=
 =?utf-8?B?L0x2NEhqZkNzN0JWM2hjWk11Y3VTZmw3eGNjcGxNck1Mb3dXOUQvWkpuV3Vw?=
 =?utf-8?B?TVRxSVhCcWZLTkJKTm5qZm1UbmRxOEdDSHNSbUR5Smlvc2dzQTJpZEhPQlp1?=
 =?utf-8?B?dGwwWmEzM1kvOVJud1pIUW5NTjFpQU43NWFVazhkSlBqSlFnRTNqYjBnenlE?=
 =?utf-8?B?UlNiL1NCUWpwUTZxQUFNUVg0Z2pBWG9tZmRpY1pKZUdPeGZKMFhwbG1tS0I3?=
 =?utf-8?B?QkphNHRnZjRsTE5PSmR6NW1LUi9hOWV2Y2o3am5XUDZBRnhmeUtyMW5DM2ky?=
 =?utf-8?B?SkFvSU1ZekJlMkFjSVFQUW9MemErSkNSby9EWlRRSlFhN3QvcTd1T1BWU3RZ?=
 =?utf-8?B?SGVuaCt0RlpCM01TSEI2RmlxaEtYbGRkQ3lHVjk2cnRkcHdXVy9TSUlEMEdF?=
 =?utf-8?B?NE5FNGQwNUJFeXNIckp4c05RTDIrWFVBVlZzNU5VYVVtcWZPZ3NOZVdJQXhv?=
 =?utf-8?B?NmU1eEZOdTdLbWFkcU9YeXVHM2p0c3kzWG9FUEQ5UzZCNXJoK2xLaWtMRmE1?=
 =?utf-8?B?QXhYdjljV0Zxd00rRnUwRFpHRTBaZzJ0MWtPME5SNXhmUVJ4Tm9sZ2p5Q2pl?=
 =?utf-8?B?TS81OU5ZSkNEelJhU2lhSWhFYzFQVnpDaWdhaTZmay9HNW44MXBFQitBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9lS2F6NmVzR2VjNzBkQU5iQThGTjEzRDFYQk9OcFpRYVVLdmxzWTJ1bmJz?=
 =?utf-8?B?RjhjWHRyMGpxMHBKZkpCTHIyTTVkb2ZPVEhTSkNMMWZPSnhwYW1UejFCVUdU?=
 =?utf-8?B?VjZEN3c4UjVDOEVibG9FK21GTzJvUmZ5VWNZbDdwUUNCVzFSQjhvL2FSeHN4?=
 =?utf-8?B?VzhaMnNTa0tVOXBxcVF0T0xPTjltSmpPOWFuWnVtSGFJK2F5NUErdnozRk1J?=
 =?utf-8?B?dmNkRVFVd3ZNeFR2cGJaQ1RzaXM1YjBrUVRFS1VuYmpnTUsxZWtRMmE3RDd5?=
 =?utf-8?B?clZuenBMUThSRTNTOForWS9IYnh1cmU1ZFZlVklHRS9JMUV6V0ZtcTZYN09V?=
 =?utf-8?B?bm93cjFJZHZsWW15RXpMK0dlc0ZjdFVsUmFVTW1ianljRC9SV2RYbi8zMytJ?=
 =?utf-8?B?T3hIcDlLNzZqb3pOSkFWS0hvRDEzWTBoNWVaMmpjUTRCS3NzRTVVM2JWQWdR?=
 =?utf-8?B?SWxsVnpKM0pMeWNWdkJrU1ExR1d5USswSlNVOHhkQVBQYWVMMDZjZzd3TUVO?=
 =?utf-8?B?K1lqeFJEN256aWRhOVVFVEcwZ1lQRVVGSnk5R1BwZm9qR2c1aUFFek8zNHpS?=
 =?utf-8?B?Tm1YYm9iN0puU0IxTHB5SWo4TTFMd042SllYWHhaaE9Nekc2UmZZNU9UVVdl?=
 =?utf-8?B?SExmYmFZN28xTkNpcVY5b0hFNjFjOXJnVUt3aDZBdDlIRVFjYTNKN2ZUZHFK?=
 =?utf-8?B?Tzg4dEF1bFl5bUNFdjBVNWFwUmZkS3VDSmhsZDU4dUE0T3lmbVlRWXJMTW9x?=
 =?utf-8?B?TXREZ3dHYWU0MEh2dEZidERUSTBuYlM1UnZTQ3Y1QWhMSUdvV1h6S0tDOGI2?=
 =?utf-8?B?UDFtWFVxc3g4UzU3VittRWRlUDI3amkzU1FwK1VlSHVBRG1IRmNBVmxaajNW?=
 =?utf-8?B?dExNVng2alczS0pobWU2WDdnbUxRcDdhVGN5MTZZMTJpNzNIMGJxWU9Uem4v?=
 =?utf-8?B?RlhQaWxaU1VIUy9JMFJGSGtKWmJEbksvbThMRi85Z3haRTFEUm8vQW5FTG5a?=
 =?utf-8?B?U0h5NmQxaTVad1IzbkFmVUVzMlJQZkZ4RXYwK09PV0FUa2NoaFZ5YlNZb3da?=
 =?utf-8?B?YkJicm12enREdGVITUxPMG9UcGlJMGtnVlY1ZlVpcWN5SG1WY1FDb3Nhdy9R?=
 =?utf-8?B?UG9DWGFIZzR1UEFnenMyS0N1d2VoMGRBb2JGbDd5VFJQdnVPampzUWNwWGdu?=
 =?utf-8?B?R1UycFRnVEN4QlFXQ1FXQWd0dTI3dTR5eDlZeTdRYVVJS1pUcTJiM0padWJw?=
 =?utf-8?B?ZUlJTVJlejRiQWNVZGtYdWhrY05KRHZZMkZYUjJQMVVSWkRVeS9wUUp6WGJR?=
 =?utf-8?B?T1lOdkpjTUpoeit6bkN3QnEvTW5JMTNiTFFUNjhsRHZPVnJBd3BKR1JwSVE0?=
 =?utf-8?B?L1EzallHd2VIbDFuK2k4OEhyMjVtWVVodDVEcy8ycUVaQU9Ma3ZCcXZ2TUFx?=
 =?utf-8?B?Z0FxLys5eEJRSmoybzVGbzZJMjF1UFo4WFI3TXFNeFJXM0tmVTRHeWovMXpk?=
 =?utf-8?B?eElhS0g0Mk9kYm55THQvTlBGVUZVN3crYUZCT0lHWGxtQURWcW5UMllwUXMw?=
 =?utf-8?B?S3J6VXJDMnhzUnRzRWNVdGlsVFovMHBTS0oydjN0ZThpVTlwL2NCbTI2MUt1?=
 =?utf-8?B?L0xpaGx3VE9lSmRZd0diNURoNng1Vmc3YVpnVVI4ZWdSUXdhUFdnV3F0NHQy?=
 =?utf-8?B?aDhqRis3MUZaelBIbXpJbUU0VTRRV0srQW1ZaGRhVkYxakJNWkF4NWFNd3BV?=
 =?utf-8?B?UnBkVVEwMEFwWE80U1JmRll2UEJEa0I4NjdKRVZMNHJVa2Q5YUlXUnBRM0F4?=
 =?utf-8?B?VnVlbmlFK3JRSnhCckdubW5qNEt2bUtPbFBRY25wak13ZmtjWmF6QTNEcmFi?=
 =?utf-8?B?UVozek43aXpyTXRINS9sUjVsaDl6V2dlaWdLM1NYQ0h3NjYwWmFpQ3VoQ09F?=
 =?utf-8?B?aTdmTWRoV0FRbGRzdUtvN0JhSGpIbzd1RVIxY2xOUG5KL3ZheFJETTJaS2dy?=
 =?utf-8?B?aDN6WmxNWEFoeWg5VWc2d01oeDBQVjhLVUg1czNCWFZDa3dtZWU5MlhPRHhv?=
 =?utf-8?B?WXJCSnFjMis4OVhJZWpIblZWc0RBVzhpUmFJWWlzQXRNYisxSlRBeWp6SkRs?=
 =?utf-8?B?VkVUcHROb0ZuaWRXbmVpbjVnS2hkUU8vQjI3Y1NOT041RGJEQXU4UVNpbUk1?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c277cae-eadc-425a-3266-08dc7b15a417
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:46:45.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8AeTkRHU6XaAjRKHx/QhjCf04TJhG9ZvhkqDbujSKV7pA1UqaVJ/Q/BaG+ZO0bDMV+WZoODFCI8D0NADnLYw27JwQvllz6ezjUv5KHeapU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Monday, May 20, 2024 7:40 PM
> To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>; Andrei
> Istodorescu <andrei.istodorescu@nxp.com>; Iulia Tanasescu
> <iulia.tanasescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ 1/2] shared/bap: Update BAP Broadcast Source
> state machine
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report this
> email' button
> 
> 
> Hi Silviu,
> 
> On Mon, May 20, 2024 at 12:28 PM Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com> wrote:
> >
> > Update BAP Broadcast Source state machine states to use BAP define
> > states  for source Idle, Config, Streaming, and an intermediary state enabling.
> 
> Not really following, what is an intermediary state? Or do you mean internal
> state? And more importantly why would we need an internal state like that?
> 

Hi Luiz we use the ENABLING state to know when a transport linked to a stream 
has been acquired by a process and in the case of a BIG with one BIS stream goes 
in the ENABLING state waiting for the response from the kernel that the BIG has 
been created so it can go to the streaming state.
For the case of a BIG with multiple BISes, the BIG is created when all BISes 
are acquired. So we use the ENABLING state to  verify that all transports 
attached to that streams form  BIG have been acquired so we can create the BIG.
If we don’t use this internal state we can use a flag in the stream structure 
to be informed that the transport attached to the stream is in the acquiring 
procedure, but this would not look good, as we will have a flag intercalated 
with the stream state machine.

> > Updated test-bap too.
> >
> > ---
> >  src/shared/bap.c | 39 ++++++++++++++++++++-------------------
> >  unit/test-bap.c  |  4 ++--
> >  2 files changed, 22 insertions(+), 21 deletions(-)
> >
> > diff --git a/src/shared/bap.c b/src/shared/bap.c index
> > 6572ef1d1..639149520 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -1361,14 +1361,6 @@ static void ep_config_cb(struct bt_bap_stream
> *stream, int err)
> >         if (err)
> >                 return;
> >
> > -       if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST)
> {
> > -               if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
> > -                       stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> > -               else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
> > -                       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> > -               return;
> > -       }
> > -
> >         stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);  }
> >
> > @@ -1759,6 +1751,15 @@ static unsigned int bap_stream_metadata(struct
> bt_bap_stream *stream,
> >         return req->id;
> >  }
> >
> > +static unsigned int bap_bcast_qos(struct bt_bap_stream *stream,
> > +                                       struct bt_bap_qos *data,
> > +                                       bt_bap_stream_func_t func,
> > +                                       void *user_data) {
> > +       stream->qos = *data;
> > +       return 1;
> > +}
> > +
> >  static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
> >                                      struct bt_bap_qos *qos, struct iovec *data,
> >                                      bt_bap_stream_func_t func, void
> > *user_data) @@ -2071,7 +2072,7 @@ static unsigned int
> bap_bcast_get_state(struct bt_bap_stream *stream)
> >         return stream->state;
> >  }
> >
> > -static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
> > +static unsigned int bap_bcast_sink_enable(struct bt_bap_stream
> > +*stream,
> >                                         bool enable_links, struct iovec *data,
> >                                         bt_bap_stream_func_t func,
> >                                         void *user_data) @@ -2081,22
> > +2082,21 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream
> *stream,
> >         return 1;
> >  }
> >
> > -static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
> > +static unsigned int bap_bcast_src_enable(struct bt_bap_stream *stream,
> > +                                       bool enable_links, struct
> > +iovec *data,
> >                                         bt_bap_stream_func_t func,
> >                                         void *user_data)  {
> > -       stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
> > +       stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
> >
> >         return 1;
> >  }
> >
> > -static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
> > -                                       bool disable_links,
> > +static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
> >                                         bt_bap_stream_func_t func,
> >                                         void *user_data)
> >  {
> > -       bap_stream_io_detach(stream);
> > -       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> > +       stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
> >
> >         return 1;
> >  }
> > @@ -2106,7 +2106,8 @@ static unsigned int bap_bcast_disable(struct
> bt_bap_stream *stream,
> >                                         bt_bap_stream_func_t func,
> >                                         void *user_data)
> >  {
> > -       stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
> > +       bap_stream_io_detach(stream);
> > +       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> >
> >         return 1;
> >  }
> > @@ -2205,14 +2206,14 @@ static const struct bt_bap_stream_ops
> stream_ops[] = {
> >                         bap_ucast_release, bap_ucast_detach),
> >         STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
> >                         bap_bcast_get_state,
> > -                       bap_bcast_config, NULL, bap_bcast_enable,
> > -                       bap_bcast_start, bap_bcast_sink_disable, NULL,
> > +                       bap_bcast_config, NULL, bap_bcast_sink_enable,
> > +                       bap_bcast_start, bap_bcast_disable, NULL,
> >                         bap_bcast_metadata, bap_bcast_sink_get_dir,
> >                         bap_bcast_get_location,
> >                         bap_bcast_release, bap_bcast_sink_detach),
> >         STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
> >                         bap_bcast_get_state,
> > -                       bap_bcast_config, NULL, bap_bcast_enable,
> > +                       bap_bcast_config, bap_bcast_qos, bap_bcast_src_enable,
> >                         bap_bcast_start, bap_bcast_disable, NULL,
> >                         bap_bcast_metadata, bap_bcast_src_get_dir,
> >                         bap_bcast_get_location,
> > diff --git a/unit/test-bap.c b/unit/test-bap.c
> > index 46ee0e4e5..10f9e348c 100644
> > --- a/unit/test-bap.c
> > +++ b/unit/test-bap.c
> > @@ -547,10 +547,10 @@ static void bsrc_state(struct bt_bap_stream
> *stream, uint8_t old_state,
> >         struct test_data *data = user_data;
> >
> >         switch (new_state) {
> > -       case BT_BAP_STREAM_STATE_QOS:
> > +       case BT_BAP_STREAM_STATE_CONFIG:
> >                 bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
> >                 break;
> > -       case BT_BAP_STREAM_STATE_CONFIG:
> > +       case BT_BAP_STREAM_STATE_ENABLING:
> >                 data->base = bt_bap_stream_get_base(stream);
> >
> >                 g_assert(data->base);
> > --
> > 2.40.1
> >
> 
> 
> --
> Luiz Augusto von Dentz

