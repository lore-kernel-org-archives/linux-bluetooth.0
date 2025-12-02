Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022089.outbound.protection.outlook.com [40.107.75.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DE26D4E5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663967; cv=fail; b=SMJ02yjJxbyYd2SJaZS5cyc2TLI1rJYdhdfDlvlzIN8gTBgNVy7tRhS1s8bDKmqpN3CePFjjq4bnKI52OG6uhVCtCFkay/1eFXgVgqGwePbeVSxlIqUYV2vrKmRaiSjeJfupKg8O791bP6rXi5xM5LJlntyrU9MFASRbJ94jDOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663967; c=relaxed/simple;
	bh=qw5V02Y/X4bjbfef3vJmkZNdI7YJSYeDyrreepWPuQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CkI/H8TZFswHI8BjV/RtUDT5ZKIo5QiTD1BpjscQmqeFmgEDMlqpw5jtrSasnqp2RvOzweV+JmmbevDC14GbuhxMyykPLAvPZMRM54Z0hs8jwLk7djB0kDwAh3d8ymaypCCbBHP05WS0ABjPpU3wFhZ28kz1XXsGRZ9PyTmR6I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=pdfv3sAi; arc=fail smtp.client-ip=40.107.75.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="pdfv3sAi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh0SrTMskW+Gb7ofES7K6/wsoCIikZcUrxsM2lfdY3ZKSUQGrYGPrhj6ldmmX9wNecAV72cCsIsEalWbtbJSAIHWUGHBafnRO/kt5QfdvGPinqZ+b/445+Wd5waJlie5eJZNiyNo4LyNbCb+K0Fwh1oje1MXrOF/Hj2H7SU57+AQMIpIDVAsBztXs9r+CIv7iOIbZeF0l/wORmKUUzJRLwQ3hCCee2y7i46oMvOXs4e1eAuSc5GMhKp+olmV+XAGG62MZR8piZQaVCBXPmVUrUZbCjhF4pJsvQLF2IypjYpqZA9MsBLHlesUXmIOujZU4OJNKjR3WQKTGXJIu6fDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S2B32rhmwfUBLT5YZs/vbcnAnpyVZSAxtBJhlCy92A=;
 b=bXwPVXr6TLhqP1N5L3qq116KA4597FtVMZQ11xZKpcaTvs2DlTM3PY2w5EUToNemoMxJrI8vdsg3EkEP2YAgSybRfbOGgDKDSrN4w5rkjvEKm/aPQTcG6RNfPw/P51arbDfnBKlHRUoWVFAgJDVwb+W6ntsaIJ8uY3KEZsi0F7En1sRX/mLTU1HZMf7IqrNI5Xo9o+z3316KPJzZ2FpPXiQz3zYc9wD8h9BXGk7KBv1nq2IiRYvRq8tfpErHFasyExVi7By1Ff5YDPonXJ4LXvI6jzevx9gk4Q9EsuIK/9lORVlz93J2+YUb+2ek0AtWbXum99d3tlP4ykUBUbjauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S2B32rhmwfUBLT5YZs/vbcnAnpyVZSAxtBJhlCy92A=;
 b=pdfv3sAiNUmFoG5Bwf3D4OCKWTNOfnuI90ZYJF/3sw8872KLTbo6LOHNOUFaJvFgiK3z0KgvFIhnbuxCnI9AkmV3ndKx2UzD2Q1dWMpiaqn4oQg2ZEVnIjo0P4/bveR5i8ZWhuBC9J/ApHD+MOXJeSATfkz/mdNEWVjmQ2EwKvIDCOP8iFRTVi9DAnncboOCAqSe4NMH2tcHI6IXUQmfTAyru31r/PfoeU9gvf6S9VWLvICt7dcZAZArmSC9s3+fv+Gor/HpPxWHCQL85842wXbiJPyWVtPtbEVw3/DTzKHhyZ+K2tFuyR0uVaztdO8bb/bXGA9ApaL3kAjrcic7dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by SG2PR03MB6479.apcprd03.prod.outlook.com (2603:1096:4:1c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:25:54 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 08:25:54 +0000
Message-ID: <503671d2-1b2f-44be-b196-70cdb70eaaf3@amlogic.com>
Date: Tue, 2 Dec 2025 16:25:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v8 3/3] client: Add shell cmd for bearer
 connect/disconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20251201-bearer-impl-v8-0-f944b6f9f201@amlogic.com>
 <20251201-bearer-impl-v8-3-f944b6f9f201@amlogic.com>
 <CABBYNZLNvKPHmJAtybnXHP29kMgeJ6v2fF7OT+5e6QBCUdvLqg@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZLNvKPHmJAtybnXHP29kMgeJ6v2fF7OT+5e6QBCUdvLqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|SG2PR03MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d06cfe2-acd6-4cde-d830-08de317c68e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE1YbnIrZUFQQXJFMUNCdll3emJyalNDVm82WDFqNnBXcVdwQnB6VDk1NlBm?=
 =?utf-8?B?QlVTQWkvUjlXNFlrYnl5d0kyN00xdkNUUnpTaE4zWGJETDdYMVZXYy9HV1RY?=
 =?utf-8?B?NHBHYUEzMXNCYzhTTVdmdjlvZ2ZOWC9ESUFkMW5nTEFjT3I3ZmhBRnVmQTRk?=
 =?utf-8?B?UHZqV0l0VHBLcDRVTTIrTGQ3SmM2bFF1MU50TXFDMUUwYjlJNXQydlRRUUcw?=
 =?utf-8?B?b0t1cTlERWlXWU93ZGhBb0lJN21yU0d4ajhsK2ViQzVpRlJoU3JXaEk0QUZi?=
 =?utf-8?B?T1E3ZE9oK2llTy9wMUpQMkQ2N1QvalJMWEZmVDZMK0cxdStuNEZhaUxtKzNn?=
 =?utf-8?B?c2JYdnhWbndpaXM5cjQzTkpkQkVJeWxucU95Y2hyVG51Z29raHpGb0dheVAr?=
 =?utf-8?B?aFdRQlM4N0FLYjA2QjR5ZmxmUTF0SC9od01qVXFOdFZyN1gveWJSb09wTk1W?=
 =?utf-8?B?dnhhUHFzSFNpdXNtallTc2hWbkxEUHMrTllNbitKbUZpWVBvNjNUNkhJa2xP?=
 =?utf-8?B?TWZoM241RjlLVE1iL045UmNkRWdQUTlsaVB0MXpyU0NMdU45MG45bm81dGl1?=
 =?utf-8?B?WlVzckZkYU1QOXV0TXJIeitJdEFyMERaOUhRMFpxUmczeUdKRnNwOFVGQWww?=
 =?utf-8?B?elREc0kwZ2tpQkhuRkFraHhBdkVMcysrVXhyUVBOQzdBUVNtZVV5blBUcDZX?=
 =?utf-8?B?aVA4TmNNWHhIMVRDNjZCdDN3Mk9tOXJ0NmNldktjQjFvcEFvWW1URU5xeHZ4?=
 =?utf-8?B?NElvaEtaRlV4QVNBTloxZldwckVpMGhEeGh1ZUJ2bXJidEZBSzFJNWw1N0pn?=
 =?utf-8?B?MUVXRnFqWUNLUGNiZGtybWgwSHlycnJjd0tlMnEvS2VRMHpVeFJwU1NWNUdh?=
 =?utf-8?B?TlE2SEtaSTBRa2xBb1dBNk1vM0U4dVhER1ZvbmRBNmRXeTV3T0NpYy9LRkZv?=
 =?utf-8?B?RFJJTnlGMlBtVC9vamMvZE1Oemd6RGhMeHFrWkFVSVlMWkFjdFVzV3lkMEw2?=
 =?utf-8?B?bUpPZ3lNSXpDc21QckY5TDQ1bUU0cDVQaGNmWWNRNWswaTZYR0FOejJmbGRS?=
 =?utf-8?B?QUtmQjhSdkZYbkpzWkVFcmwyNUxqdkxGQlpRd1E4Zm4rTDFmLzBma0hVeDNn?=
 =?utf-8?B?enJTVlBMYWYxVWZ3aTRyWTZhVVVZblBwSWtyYjZzRWFaUnhXdVlNZzJiSEEr?=
 =?utf-8?B?WVJlVmF2bDRiTTNFb29TNHRNNjJxZW5WOG9abFVpSFYrQTdNcTVabk5BYXhz?=
 =?utf-8?B?RjRQWjFWdmg1akJHU2ZReVNTQjJuOFIrS3k5aGtNVnJmZHoyN09QdUN3RXQ1?=
 =?utf-8?B?NHRaMFo0WGZDbG94aEJmMXFCaUFnQUFiVUl3Y0hGc1dXZmtTWU9GYlVMUEtH?=
 =?utf-8?B?VlZieXNSRG1teVBIVUxJS3l0UFJNNFFveHNOUTJkcWJCM3lQeG9VMTBFUlRm?=
 =?utf-8?B?ZXF6dXd0MU9KT1VndFZ4ZWVmLzdlZkN4Z3FlekFOWjFzeHE5RkVMZGZMZTEw?=
 =?utf-8?B?eTh3N0JIMEZQc1pUODZ4VFE4SlNjeHltQlU0cEtDdmlnWjhpZ29UN2V5RGg3?=
 =?utf-8?B?RkhETmlMQTFSc3NBdU9aUFFrNTZNOGQ2b3A5eHJRaCt1bGQrR2dkYXR5eEhx?=
 =?utf-8?B?RlowaXpxWEE4UFRwSEpabVB1U0hnR1BTYVNJSSt3bFBPeXBmSG5VRmhTZWY3?=
 =?utf-8?B?WjBYQ2RXZ3ZYTXBoMlFRWG5PeFBpdTkrVzhWaXYwWTBBeE1uSGFKOHN1OHd2?=
 =?utf-8?B?bDFXdEF6RlhVcnVTWitzMERrRVQ0VDhGbVFCSVl0TUpGUWo2ODdyMWpjR3V0?=
 =?utf-8?B?QlZjQk5BM2Z4QmhEUGo3eUl2WWF0RlMvNm0xNW4vRGkvQVN4SlZnSW84eWw5?=
 =?utf-8?B?aFFPQVB0S2FHcjNhZDg3WlZZTEs2d25kSnhLRU1kVXZrd2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdPWjAxSFpMUWJTMDJQbUUzc3NyYXJLWjZYcUhwZFpVMjN2SnhwSm9leXZT?=
 =?utf-8?B?b2lRMEk4OTRFOTczWXQySWFsSEdiQVliY01Bd1J0RFVSaGFvZCt5cHpHS3pO?=
 =?utf-8?B?dnBnMnYvVm9xMFFlR2d0cUdkODZncUltMDR0V2N5TjQ4OEE1bUdTamZDYmR2?=
 =?utf-8?B?NU5ZMnArc3RYZUNmUms1UlhSQU9qTmlzdzUyTjJQRFpMVzhOMEpiT01LRUxS?=
 =?utf-8?B?UUpUbUJDenRzczY1Zzc0ZnVEeG0zejZGbnBVUXNjMjkwU0d4Wk5tUHVBVjZs?=
 =?utf-8?B?U0ovd0E2U0ZGUGtsMnV4VTJUQitkb3EzQzNMWENCV1BVN0VPU0tiMFMzOE9T?=
 =?utf-8?B?Wm9nd2J1Z0Zwb2FZWDZ3RDY3VldzUW55OW1yQUh6a0JIT3lKN0hRZXBhcGVD?=
 =?utf-8?B?dTVyV2lVTXpYNTlobE9FSE1VR1hweEp2ZGp1S0xtM01ldWhiYkNIRmxOOCtN?=
 =?utf-8?B?Um81bGtSbDQreExUdjdYeTcvajlNdlZ5THpUT0N4dmNrODdoaGNHRDRGWkZ6?=
 =?utf-8?B?ZGlQZHFrelVKTGJlVEhqTDhDcENCWGlXUTJ2Qk85OFI4aVpHUG9JSXpoK3lN?=
 =?utf-8?B?b1RZclB3U0lPeDA2UFc5Zk1MUDF4Z0tJMlF4V3hjcW0rYytDS0FOREpVdDhy?=
 =?utf-8?B?eXpKSGg0bVd6QzhYbHBHZlNreGNtRWxQQU95TkdsT2h4MUlTV1QzQkNxbjRP?=
 =?utf-8?B?WUJiSHM2NmY3czRhSjZDZEtnMGdybUdWazU2UjByRTVZL2pYRWVtNWRtbzZK?=
 =?utf-8?B?eGRTQmhZNnoyem45OURVRFJsQ1BXUWtTTGtPT0FheEtWZmMzRTBqc2FhWWRv?=
 =?utf-8?B?VE5UN1pkZzdMRXBLenZEV0h5VHVTekMwaFZyU0M2WUFiaCtmOEI3Mk1LZHU1?=
 =?utf-8?B?cGNxaGRNQWYrNnQ0azkzeDI1dStJeDgrOXFPTHQ1YW5tMWY4VzNrRkxidGFJ?=
 =?utf-8?B?Ymp4bDFrdnNUdU9LZUZYQTQ4ZGZSUXRvQmR5WkR0UGhPTFZ5SWhJWk9qb1Vn?=
 =?utf-8?B?WTlnVURPZ05sNkNpajNicE9kOHN0aGJBM01hUC8vNy9IaHpqTDhzbU9selRm?=
 =?utf-8?B?dnpCZlNTdkRkMTJXNERzQnJnQzJzNUx4aTcwaTdJcTQ3bzc0YitIZWMydGpM?=
 =?utf-8?B?djRHZTExOG9OOHEzUTVtcjNUSGNFRDhHVURYT0xwNEZIdzBGSXdxSnluSzFh?=
 =?utf-8?B?NWVWR1pvMVpVSnE2djRwd0lsUUlQeVRnaStrRDNnaGJYZklTSUNTcTZva0tv?=
 =?utf-8?B?YU0vbXFiSmhRS3Eyd3c2aTMrb1owdlAreDQ0QlNxeHQ2Zkt4T2FGdFhBcTh5?=
 =?utf-8?B?RENURmtyVTNudUM0VW93QnRhdlo0dVkxZEhYOXBNbVNBUlpRY05EVFR5RkFv?=
 =?utf-8?B?VG9uTlRPVi9sSmw2c0FKZkVuekZzNlAzd2hwa0hLWlRRNWczaVYyTm5uRVJB?=
 =?utf-8?B?cHdnUTc4QTRleFVxOStESDdHWjNjMVNxMHRUU0V0WGorQ2J0WTlxanJTUThY?=
 =?utf-8?B?LzFvZVZxZi90OS93R0xPMVl5a1U1aWQ1aEM4Y0wxK0s5OVJSN3JQZGZud0JQ?=
 =?utf-8?B?SE82YjJzdjA3MmFrOGNSNWdMVU1ZUTc2NTdpckJCaDRwL3ZqU3JNOTRxQi9X?=
 =?utf-8?B?UmUxNkR6SUxZSVpPRzVja2F0RkVBdnViTm0vbXBDTWVJL2ZTQTNsQmQ4OCtJ?=
 =?utf-8?B?QzVGZ0kwRjBScm5JNkU3VWFwWklHL3dxc1ovcXBBcGt2cTdmNmhCZWVDU2tl?=
 =?utf-8?B?SzQzQU5jMzdseDFTU1AyQnROTnRqUitJU0NRaUhwMkMyTU9OZFVocHlHZDlw?=
 =?utf-8?B?RG1pZ0ZtdCs5ei9LeS93RGx1R3c2S3NyMWRPUEV5R010bytQcU5yMEdTMkxX?=
 =?utf-8?B?d2xSZjRUMStsZjdkN1lSNkFHRHZoRlpIMTRrMmxKOGpiY1N1d3llSE4vY0F2?=
 =?utf-8?B?UnhKVmtTOWFOblBzUkdMZHViOUJCOUNJNVJjTUEzdlpyN1BSUzMzQ0Z2cjlB?=
 =?utf-8?B?Q214cENWdFdtalJiQ0JHWERWWDNoQTM4QTNWSTY3SDBPdkxZNmFuK3daclVD?=
 =?utf-8?B?ZmF5dDJIMTVhRTZHVUpSaGlRZWYyeGJvUXR2aDBiSHFVT05jOFl4d1p6b09E?=
 =?utf-8?Q?eU3kIfFUjd1p+Zzf9irRf/3Jx?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d06cfe2-acd6-4cde-d830-08de317c68e9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 08:25:54.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8IJvLozHA7mQRkmetn1kKCrxhKzoCMypdpSt1lquYowfiJ1jk3+5PIlsqULi7y3Txgg/9UCWxahpv2IO1WBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6479

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Mon, Dec 1, 2025 at 3:29 AM Ye He via B4 Relay
> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>> From: Ye He <ye.he@amlogic.com>
>>
>> This patch adds shell command for bearer connect/disconnect.
>>
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> ---
>>   client/bluetoothctl-bredr.rst |  70 +++++++++
>>   client/bluetoothctl-le.rst    |  71 +++++++++
>>   client/bluetoothctl.rst       |  10 ++
>>   client/main.c                 | 324 ++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 475 insertions(+)
>>
>> diff --git a/client/bluetoothctl-bredr.rst b/client/bluetoothctl-bredr.rst
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..3ec702a59ff35261f6eb71cf77b3267229bbad8b
>> --- /dev/null
>> +++ b/client/bluetoothctl-bredr.rst
>> @@ -0,0 +1,70 @@
>> +==================
>> +bluetoothctl-bredr
>> +==================
>> +
>> +-------------
>> +BREDR Submenu
>> +-------------
>> +
>> +:Version: BlueZ
>> +:Copyright: Free use of this software is granted under the terms of the GNU
>> +            Lesser General Public Licenses (LGPL).
>> +:Date: December 2025
>> +:Manual section: 1
>> +:Manual group: Linux System Administration
>> +
>> +SYNOPSIS
>> +========
>> +
>> +**bluetoothctl** [--options] [bredr.commands]
>> +
>> +BREDR Commands
>> +==============
>> +
>> +list
>> +----
>> +
>> +List available bredr devices.
>> +
>> +:Usage: **> list**
>> +
>> +show
>> +----
>> +
>> +Show bredr bearer information on a device.
>> +
>> +:Usage: **> show [dev]**
>> +
>> +connect
>> +-------
>> +
>> +Connect device over bredr.
>> +
>> +This command initiates a bredr connection to a remote device.
>> +
>> +By default, it establishes the bredr connection and then connects all profiles
>> +that marked as auto-connectable.
>> +
>> +:Usage: > connect <dev>
>> +:Example: > connect 1C:48:F9:9D:81:5C
>> +
>> +disconnect
>> +----------
>> +
>> +Disconnect device over bredr.
>> +
>> +By default this command disconnects all profiles associated with the bredr
>> +connection, and then terminates the bredr link.
>> +
>> +:Usage: > disconnect <dev>
>> +:Example: > disconnect 1C:48:F9:9D:81:5C
>> +
>> +RESOURCES
>> +=========
>> +
>> +http://www.bluez.org
>> +
>> +REPORTING BUGS
>> +==============
>> +
>> +linux-bluetooth@vger.kernel.org
>> diff --git a/client/bluetoothctl-le.rst b/client/bluetoothctl-le.rst
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..808d5786ee805a61228a5195cc731a5f46de9201
>> --- /dev/null
>> +++ b/client/bluetoothctl-le.rst
>> @@ -0,0 +1,71 @@
>> +===============
>> +bluetoothctl-le
>> +===============
>> +
>> +----------
>> +LE Submenu
>> +----------
>> +
>> +:Version: BlueZ
>> +:Copyright: Free use of this software is granted under the terms of the GNU
>> +            Lesser General Public Licenses (LGPL).
>> +:Date: December 2025
>> +:Manual section: 1
>> +:Manual group: Linux System Administration
>> +
>> +SYNOPSIS
>> +========
>> +
>> +**bluetoothctl** [--options] [le.commands]
>> +
>> +LE Commands
>> +===========
>> +
>> +list
>> +----
>> +
>> +List available le devices.
>> +
>> +:Usage: **> list**
>> +
>> +show
>> +----
>> +
>> +Show le bearer information on a device.
>> +
>> +:Usage: **> show [dev]**
>> +
>> +connect
>> +-------
>> +
>> +Connect device over le.
>> +
>> +This command initiates a le connection to a remote device.
>> +
>> +An active scan report is required before the connection can be
>> +established. If no advertising report is received before the timeout,
>> +a le-connection-abort-by-local error will be issued.
>> +
>> +:Usage: > connect <dev>
>> +:Example: > connect 1C:48:F9:9D:81:5C
>> +
>> +disconnect
>> +----------
>> +
>> +Disconnect device over le.
>> +
>> +By default this command disconnects all profiles/services associated with the le
>> +connection, and then terminates the le link.
>> +
>> +:Usage: > disconnect <dev>
>> +:Example: > disconnect 1C:48:F9:9D:81:5C
>> +
>> +RESOURCES
>> +=========
>> +
>> +http://www.bluez.org
>> +
>> +REPORTING BUGS
>> +==============
>> +
>> +linux-bluetooth@vger.kernel.org
>> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
>> index 0187e877d60b28eb1e735181b3203e60da821e6f..f8d6c345797722aeb1550d903a268c7d756545f9 100644
>> --- a/client/bluetoothctl.rst
>> +++ b/client/bluetoothctl.rst
>> @@ -371,6 +371,16 @@ Assistant Submenu
>>
>>   See **bluetoothctl-assistant(1)**
>>
>> +LE Submenu
>> +==================
>> +
>> +See **bluetoothctl-le(1)**
>> +
>> +BREDR Submenu
>> +==================
>> +
>> +See **bluetoothctl-bredr(1)**
>> +
>>   AUTOMATION
>>   ==========
>>   Two common ways to automate the tool are to use Here Docs or the program expect.
>> diff --git a/client/main.c b/client/main.c
>> index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..464243ea3b7247f4ae2be479643c44380af82917 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -2789,6 +2789,47 @@ static char *dev_set_generator(const char *text, int state)
>>          return set_generator(text, state);
>>   }
>>
>> +static char *bearer_dev_generator(const char *text, int state,
>> +                                       const char *iface)
>> +{
>> +       char *addr;
>> +       GDBusProxy *device;
>> +       GDBusProxy *bearer;
>> +
>> +       if (!iface)
>> +               return NULL;
>> +
>> +       addr = dev_generator(text, state);
>> +       if (!addr)
>> +               return NULL;
>> +
>> +       device = find_proxy_by_address(default_ctrl->devices, addr);
>> +       if (!device)
>> +               goto failed;
>> +
>> +       bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                       g_dbus_proxy_get_path(device),
>> +                                       iface);
>> +       if (!bearer)
>> +               goto failed;
>> +
>> +       return addr;
>> +
>> +failed:
>> +       g_free(addr);
>> +       return NULL;
>> +}
>> +
>> +static char *le_dev_generator(const char *text, int state)
>> +{
>> +       return bearer_dev_generator(text, state, "org.bluez.Bearer.LE1");
>> +}
>> +
>> +static char *bredr_dev_generator(const char *text, int state)
>> +{
>> +       return bearer_dev_generator(text, state, "org.bluez.Bearer.BREDR1");
>> +}
>> +
>>   static char *attribute_generator(const char *text, int state)
>>   {
>>          return gatt_attribute_generator(text, state);
>> @@ -3296,6 +3337,253 @@ static void cmd_adv_monitor_get_supported_info(int argc, char *argv[])
>>          adv_monitor_get_supported_info();
>>   }
>>
>> +static void print_le_properties(GDBusProxy *proxy)
>> +{
>> +       GDBusProxy *device;
>> +
>> +       device = find_proxies_by_path(default_ctrl->devices,
>> +                                       g_dbus_proxy_get_path(proxy));
>> +
>> +       if (!device)
>> +               return;
>> +
>> +       bt_shell_printf("Device %s\n", proxy_address(device));
>> +
>> +       /* New properties may add to org.bluez.Bearer.LE1. */
>> +       print_property(proxy, "Paired");
>> +       print_property(proxy, "Bonded");
>> +       print_property(proxy, "Connected");
>> +}
>> +
>> +static void print_le_bearers(void *data, void *user_data)
>> +{
>> +       GDBusProxy *proxy = data;
>> +
>> +       if (!strcmp(g_dbus_proxy_get_interface(proxy),
>> +                                     "org.bluez.Bearer.LE1"))
>> +               print_le_properties(data);
>> +}
>> +
>> +static void print_bredr_properties(GDBusProxy *proxy)
>> +{
>> +       GDBusProxy *device;
>> +
>> +       device = find_proxies_by_path(default_ctrl->devices,
>> +                                       g_dbus_proxy_get_path(proxy));
>> +
>> +       if (!device)
>> +               return;
>> +
>> +       bt_shell_printf("Device %s\n", proxy_address(device));
>> +
>> +       /* New properties may add to org.bluez.Bearer.BREDR1. */
>> +       print_property(proxy, "Paired");
>> +       print_property(proxy, "Bonded");
>> +       print_property(proxy, "Connected");
>> +}
>> +
>> +static void print_bredr_bearers(void *data, void *user_data)
>> +{
>> +       GDBusProxy *proxy = data;
>> +
>> +       if (!strcmp(g_dbus_proxy_get_interface(proxy),
>> +                                     "org.bluez.Bearer.BREDR1"))
>> +               print_bredr_properties(data);
>> +}
>> +
>> +static void cmd_list_le(int argc, char *argv[])
>> +{
>> +       GList *l;
>> +       GDBusProxy *device;
>> +
>> +       for (l = default_ctrl->devices; l; l = g_list_next(l)) {
>> +               device = l->data;
>> +               if (find_proxies_by_iface(default_ctrl->bearers,
>> +                                     g_dbus_proxy_get_path(device),
>> +                                     "org.bluez.Bearer.LE1"))
>> +                       print_device(device, NULL);
>> +       }
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void cmd_list_bredr(int argc, char *argv[])
>> +{
>> +       GList *l;
>> +       GDBusProxy *device;
>> +
>> +       for (l = default_ctrl->devices; l; l = g_list_next(l)) {
>> +               device = l->data;
>> +               if (find_proxies_by_iface(default_ctrl->bearers,
>> +                                     g_dbus_proxy_get_path(device),
>> +                                     "org.bluez.Bearer.BREDR1"))
>> +                       print_device(device, NULL);
>> +       }
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void cmd_show_le(int argc, char *argv[])
>> +{
>> +       GDBusProxy *device;
>> +       GDBusProxy *bearer;
>> +
>> +       /* Show all le bearers if no argument is given */
>> +       if (argc != 2) {
>> +               g_list_foreach(default_ctrl->bearers, print_le_bearers, NULL);
>> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +       }
>> +
>> +       device = find_proxy_by_address(default_ctrl->devices, argv[1]);
>> +       if (!device) {
>> +               bt_shell_printf("Device %s not found\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                     g_dbus_proxy_get_path(device),
>> +                                     "org.bluez.Bearer.LE1");
>> +       if (!bearer) {
>> +               bt_shell_printf("LE bearer not found on %s\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       print_le_properties(bearer);
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void cmd_show_bredr(int argc, char *argv[])
>> +{
>> +       GDBusProxy *device;
>> +       GDBusProxy *bearer;
>> +
>> +       /* Show all bredr bearers if no argument is given */
>> +       if (argc != 2) {
>> +               g_list_foreach(default_ctrl->bearers, print_bredr_bearers,
>> +                                                                       NULL);
>> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +       }
>> +
>> +       device = find_proxy_by_address(default_ctrl->devices, argv[1]);
>> +       if (!device) {
>> +               bt_shell_printf("Device %s not found\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                     g_dbus_proxy_get_path(device),
>> +                                     "org.bluez.Bearer.BREDR1");
>> +       if (!bearer) {
>> +               bt_shell_printf("BREDR bearer not found on %s\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       print_bredr_properties(bearer);
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void bearer_connect_reply(DBusMessage *message, void *user_data)
>> +{
>> +       DBusError error;
>> +
>> +       dbus_error_init(&error);
>> +
>> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
>> +               bt_shell_printf("Failed to connect: %s %s\n", error.name,
>> +                               error.message);
>> +               dbus_error_free(&error);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Connection successful\n");
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void bearer_disconn_reply(DBusMessage *message, void *user_data)
>> +{
>> +       DBusError error;
>> +
>> +       dbus_error_init(&error);
>> +
>> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
>> +               bt_shell_printf("Failed to disconnect: %s %s\n", error.name,
>> +                               error.message);
>> +               dbus_error_free(&error);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Disconnection successful\n");
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void cmd_bearer_method_handler(int argc, char *argv[],
>> +                                       const char *iface,
>> +                                       const char *method)
>> +{
>> +       GDBusProxy *device;
>> +       GDBusProxy *bearer;
>> +
>> +       if (!check_default_ctrl())
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +
>> +       device = find_proxy_by_address(default_ctrl->devices, argv[1]);
>> +       if (!device) {
>> +               bt_shell_printf("Device %s not available\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                       g_dbus_proxy_get_path(device),
>> +                                       iface);
>> +       if (!bearer) {
>> +               bt_shell_printf("%s is not available on %s\n",
>> +                               iface, argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       if (!g_dbus_proxy_method_call(bearer, method, NULL,
>> +                                     strcmp(method, "Connect") == 0 ?
>> +                                       bearer_connect_reply :
>> +                                       bearer_disconn_reply,
>> +                                     NULL, NULL)) {
>> +               bt_shell_printf("Failed to call %s\n", method);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Attempting to %s %s with %s\n",
>> +                                       method,
>> +                                       argv[1],
>> +                                       iface);
>> +}
>> +
>> +static void cmd_connect_le(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
>> +                                                               "Connect");
>> +}
>> +
>> +static void cmd_disconnect_le(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
>> +                                                               "Disconnect");
>> +}
>> +
>> +static void cmd_connect_bredr(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
>> +                                                               "Connect");
>> +}
>> +
>> +static void cmd_disconnect_bredr(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
>> +                                                               "Disconnect");
>> +}
>> +
>>   static const struct bt_shell_menu advertise_menu = {
>>          .name = "advertise",
>>          .desc = "Advertise Options Submenu",
>> @@ -3469,6 +3757,40 @@ static const struct bt_shell_menu gatt_menu = {
>>          { } },
>>   };
>>
>> +static const struct bt_shell_menu le_menu = {
>> +       .name = "le",
>> +       .desc = "LE Bearer Submenu",
>> +       .entries = {
>> +       { "list", NULL, cmd_list_le, "List available le devices" },
>> +       { "show", "[dev]", cmd_show_le,
>> +                                       "LE bearer information",
>> +                                       le_dev_generator },
>> +       { "connect", "<dev>", cmd_connect_le,
>> +                                       "Connect le on a device",
>> +                                       le_dev_generator },
>> +       { "disconnect", "<dev>", cmd_disconnect_le,
>> +                                       "Disconnect le on a device",
>> +                                       le_dev_generator },
>> +       {} },
>> +};
>> +
>> +static const struct bt_shell_menu bredr_menu = {
>> +       .name = "bredr",
>> +       .desc = "BREDR Bearer Submenu",
>> +       .entries = {
>> +       { "list", NULL, cmd_list_bredr, "List available bredr devices" },
>> +       { "show", "[dev]", cmd_show_bredr,
>> +                                       "BREDR bearer information",
>> +                                       bredr_dev_generator },
>> +       { "connect", "<dev>", cmd_connect_bredr,
>> +                                       "Connect bredr on a device",
>> +                                       bredr_dev_generator },
>> +       { "disconnect", "<dev>", cmd_disconnect_bredr,
>> +                                       "Disconnect bredr on a device",
>> +                                       bredr_dev_generator },
>> +       {} },
>> +};
>> +
>>   static const struct bt_shell_menu main_menu = {
>>          .name = "main",
>>          .entries = {
>> @@ -3593,6 +3915,8 @@ int main(int argc, char *argv[])
>>          bt_shell_add_submenu(&advertise_monitor_menu);
>>          bt_shell_add_submenu(&scan_menu);
>>          bt_shell_add_submenu(&gatt_menu);
>> +       bt_shell_add_submenu(&le_menu);
>> +       bt_shell_add_submenu(&bredr_menu);
>>          admin_add_submenu();
>>          player_add_submenu();
>>          mgmt_add_submenu();
>>
>> --
>> 2.42.0
> Just tried something simple:
>
> [bluetoothctl]> le.connect 88:92:CC:54:B8:FD
> Attempting to Connect 88:92:CC:54:B8:FD with org.bluez.Bearer.LE1
> [bluetoothctl]> le.connect 88:92:CC:54:B8:FD
> Attempting to Connect 88:92:CC:54:B8:FD with org.bluez.Bearer.LE1
> Failed to connect: org.bluez.Error.InProgress In Progress
> Failed to connect: org.freedesktop.DBus.Error.NoReply Did not receive
> a reply. Possible causes include: the remote application did not send
> a reply, the message bus security policy blocked the reply, the reply
> timeout expired, or the network connection was broken.
>
> Looks like it doesn't handle things like connection timeout, etc, so
> bearer.connect is never cleanup, nor any reply is generated.


Thanks for pointing out that, i will add exception handling in the next 
version.


>>
>
> --
> Luiz Augusto von Dentz
