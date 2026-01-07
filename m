Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022108.outbound.protection.outlook.com [52.101.126.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972C224F3;
	Wed,  7 Jan 2026 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764332; cv=fail; b=PFTDQP9U/HdLXNeaI65UxaK0EeYcEhDLY8ltDCCKWzegbkLkuILW7IhY6+hDhriS0h3MhTqUMxtVlwZt/VQIdoR71EctYGe5QZuD3u/BhTGKuLbYCRXpXf00J4Kv4hjJPxIi3HYL9tFYwbNvCwGp0Lx7ZwJVghjf2UCMC42BI+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764332; c=relaxed/simple;
	bh=aXl7jVSBYpKFuR6PqSreaJgHBeou/qgHk1jawWIzJvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JX+FHzbqLyKHuCP3nP4FTuQFIE2+5rUxyeFOgyw72DsLAQcO6cVa85Womu6B02ghin1tPZmU5LZKj1qpsitYSHkYqX6VVA0dpcitml8Cmfq3wEUbcf9x8cl4ZPDhlz2SG/b1yqNBFn8n6jiymiFlXTc9FAhnUy5e60r/EHwuwGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=UXODHU+j; arc=fail smtp.client-ip=52.101.126.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="UXODHU+j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb4aTVEqxNT01D3UC+xQirJG+2uYzQ6TA+VLhWKE6UqYrY9GFdnAfTU9UnGdCDM7kaCKLgv/7CnVKLZj6XplA/y7bUOHWlOdP2DB2X9V2YdejbxiiIHLNXQseDSiMex8gV+PJRxaQ50afKuFG3TrhPmlJbIg4vYHo0oG95celSLqYvYQW+zxsqtGBXtsF7DVqGPzGVH8Mi330ZcxjsbK19aB8jtID8UhdUGNtJ29ToYwqcutugFAUAaWLilgCMk7ekSv/2UOuj+QZo0erIVQI2xP3Ei6vR+iT3ifZwIxsQET8/wHmka9KzbOBMnBEnsliAkw1cqDyfTJIsOHN1BNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2G7X8wpL41jjCmcYDSZuhDPvLqbz48WqtciaWm9ldA=;
 b=ErCLP8o0597vrb2Me8DddKnOq9GFPD8n54FCR8rMA3KZC+7roaXeDGGYJ0BA5e2dgM6K0GcsEe9fXy7wt6w3R97zvFe7IVyp4QehHnwwwbjEIj8UXLffymKJTLFXaYHz5bDV9vo0LXkTKn+L1XFe2GEBhnr6u0ckVrj+ICZTuOl40Kz29MpCN863t+IY945SBa+Lzt7ycjJPi5I4k4Te3Omk4CcTMGOwOn9Fj7zDn6+ve4Fyc5rEadXmNqUDV8aE5jGhGsX3n4q7UriNFkTzT/4X1LLc1v1w1Flmr6UGYhuMdxxpkx7FD0YEtgLSQ7Qh/6vy14yG410onNut4sKvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2G7X8wpL41jjCmcYDSZuhDPvLqbz48WqtciaWm9ldA=;
 b=UXODHU+j5fR/P+E/DiAFtWH/37FZ9bjJ2APnRxPU3n6d8Z0l3dBqGVvLIfwx3Bwxzrjcmrr8RBxF2fx2IxdeZmumx+JZYjv6a8ztvU6EH9qydDLHFdIsyCc7N4LAbPpq1SreqbtcaM4bs2dd/+mYAwdx8I2tFmEoZUATI2Nk9Tpfd71zKOyUL6+cAPE0qmXj5vszhkR/gL8WbHXJoZiwy9IwC0jcbe3L7drozAoDFoQxFOS6RJoP5iRXzLWslQYX2OIigkdHOziFK2g5cAdWavfCOqEwHunOeaOlO31/CrVo9nYT2PFHuFhBJfrAU2zoqrUoOlTkXo2N7+WnbJ+Scw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SI6PR03MB8610.apcprd03.prod.outlook.com (2603:1096:4:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 7 Jan
 2026 05:38:46 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 05:38:46 +0000
Message-ID: <93015e38-a906-43ff-8b04-921328d351e0@amlogic.com>
Date: Wed, 7 Jan 2026 13:38:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: enable PA Sync Lost event
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SI6PR03MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaacb30-5c1f-4dc2-4a95-08de4daf06a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWd5ZjQyWWtNVEtjN2k1enQ2Zkd6Rk1yNFdCVjIxYmJXN3ljR2dqaFZXYXN4?=
 =?utf-8?B?bkdyNUFIVzZtSUMzWmk5UGNmeThCaS9LMjdQMmkzVkgveXRZTGFaS1VBN2dL?=
 =?utf-8?B?ek9QWjJsSXYyd3RNeHJoSTRDbzZnY21FbW1TREVPZ0pQZFJxOEZiUmdHRUor?=
 =?utf-8?B?VzMweDhMSnovNUVCMTdzbVZtOXhiVWlVek5KRnl0NGsxTFNhYkxXcUJuNHRG?=
 =?utf-8?B?ZlRPYi9aSXJSV0Z4Sm9VV1BETS82aGVvcm1ZYlQ1SExUSFJiRCtuRFRvczYx?=
 =?utf-8?B?dUJIa1IzV01MUXN3OG9aZHpXSFVTVlBENkpzakVJYXhlUUxpNWFiTElobmZo?=
 =?utf-8?B?YWk3bWxldlRPM2lnNjZ4ZkpGZEx5MFUzWDAwOXR0QlZJOXNuNGhNcXlyR01p?=
 =?utf-8?B?R3lKcVIxeFY2V1Fyc1NrUmY0R0EvREJ5RHhwQVdUNTdzNnFWNHFqbVVMUzhz?=
 =?utf-8?B?UGRPT3VKNmJwSCtkTkF4RTBEUXlYS0YwcGxGNVhkUjZwQ1RaV1pPNzhlM0VI?=
 =?utf-8?B?MUdWUFMzTVJVUnJSQmdjNHR3OE0xdkRFNkNPZ3lDNkFCbUh6QURKV084N1Jv?=
 =?utf-8?B?RXQrbzVFUm00QWNRNkJYVHpVUzI5Z3pMWm5KWWlWVFdvcENJMTYvQk5WZjJT?=
 =?utf-8?B?N2lYZWxyZFNacTB2d0JoZ01LVWxPUmpiaU45cU5Wb0t6MWc1WjlkS0VkaHFZ?=
 =?utf-8?B?dzQ4b2I5Uk92MXEzVGtBdnhHT29lU3pmajlBRVpxdlAydDBrWnY5RGlHN1ZH?=
 =?utf-8?B?amk1S0RvZUxhS252T2xGVGhVS1pQd0E0TVNLaS8xSThONzRZMjNQSXVmK2M3?=
 =?utf-8?B?alA1T1dpUHRWNDdrRnNoWXJWb1Fla29FWHcxU0xTL2JMY1dBN1piSkJ3eHQw?=
 =?utf-8?B?MFRwRkFPTmhBOHBCeUNpbGg0WVVXdTI1dDAyaTF1ZGJMTGo5UWFFMytBSTZh?=
 =?utf-8?B?Nmt6VG05aFVKZ0pERlZ6ekRNSlZUNFJ5MlZabVRXM3RqSGs5UFlWMUNVeDN3?=
 =?utf-8?B?cXdWdzRVSCswZldrYUttVGtkYUhEb3RIQ2dNdU8wdzg5Tnl4WlRkQml3R1Q4?=
 =?utf-8?B?NXJOTUx0bk5YNW05RGtDYS81QVFwS20wSTI1Q1BXcm1wbStMd1FnZ2lNOFdH?=
 =?utf-8?B?TzdYQk0wTU9scUNzU0lOZG9td1R2bUZUZE0zWG5xQ1ptMk5nMW1NWTkzMjN5?=
 =?utf-8?B?anRsWUxNRzJkQ1cvOURjbzAxVXlGNUxWenNJY0xpK2dwVTZoWlh0WG5zRm1E?=
 =?utf-8?B?dHR6QktuWFdhMUxhTHNQWGNIRUxJYkF5U3NvQWkrUmpWTlRNbmV4OXYzT0c3?=
 =?utf-8?B?Zy9WK3JjMkFaTzdsa1hRMWc3QlM4ZjAxa01FcFZ6UkIzUG9SRzA0d0ZHaitq?=
 =?utf-8?B?clAwbkFtSWttNHFDcXZzOHFqL04rTVkrdDQ0bFEvd1FOdy9YdFZiWXoyVHBJ?=
 =?utf-8?B?R3k0L1Mvc3Z2Q1BpRUlXZjRtdzBBSHd6bFpyQ0FjQ0Evd3FEek9pN3ZOZlB6?=
 =?utf-8?B?SGtTdG15ZXlMb09SWkZRUUo2RHNCRVY4cU0zM1JuekZFNkVkdzdIajZ5Vllo?=
 =?utf-8?B?bnhNc3ppSDRhOEdRUzc0aWUyam1pZUVzM1JIOWU1N3FEcm5iaFovQUdoSlhZ?=
 =?utf-8?B?aHVZY0V5aXZrYklBZHdmMnhTZUlMQVZaUkpvQklFb3BuemdncWFHdzlrMFZB?=
 =?utf-8?B?SW1IeWc3VisvS0ZuUmZhSnVsbmdvbGI2SDl1OXFnbG5wb25YQ05qdE9xTkFp?=
 =?utf-8?B?MEl2WEcrYS9HZHk2U3RSazV2NFRXY0tFM1R3YjJzejhsMXMxenAyOEhuaGNN?=
 =?utf-8?B?RXBhY3o3OU9rT3l4Q0tlS3MzcjdMdkhkKy9jMms0V2hFb3VsMG5MeURjelZT?=
 =?utf-8?B?VVRTUW9EbFJsakFBNFU4UXFjUm5peXJ0Ti8zZW9LQUVocWpBMXErQkNNVzhs?=
 =?utf-8?Q?4mxShWSzG8mlBNv4T2DCGyp/EsFb44aX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QThRdlhmTjFNOE5XWnhIYmtLNDdRb053MGtOdjFyakhlUjV4bHdwZ0tjQWI0?=
 =?utf-8?B?QXBBWDRwVDBZTmt2NklrUlhMSlNKMlFsU1RRNHB3VGh5Rm50Zkd3Tk9RdUdx?=
 =?utf-8?B?ZWp6b3ZJTy9vaTdoRlc5Mm1IRE9BY1dBRVZEdVRLbktINkJqVmZRV0p4M2gz?=
 =?utf-8?B?VUJuZEc2VG81dE1nTjQrUlprVFpFOVI3ZXNaYjhOMmVKZVFSOGZiMDRrOHhB?=
 =?utf-8?B?K2Y5SDBpUFNURnlpVWRob3JDRGZEb3hSNVJSUGJnem5OWXBsK05ha2hnYXBp?=
 =?utf-8?B?cFh2a0diSDM1STBwMWxaVStDWWhWbWdPREZvZ2ROTUNOUVl6b3FTOUFZdS9m?=
 =?utf-8?B?Um9uQUZRS3FDbGV4a2pseFJ2RXc4V1lrR2hEeHFuMDFYWEJxcW5WMEMzMktW?=
 =?utf-8?B?cVNOdHJOdzViNGN4bEJodUNvRURvT0xOb2VWeHNNdG9uZVNxeE1BRm5nemJx?=
 =?utf-8?B?QVQzVU9MKzJrVURNS0liTTc3ZkRtL3NuUW52MUlMRXRyLzRYQlRRb2h6QXA0?=
 =?utf-8?B?ZkQ0Q0x6dGFSUjNSeWhtZm1SSGFhQlFMQVM5NmswMUVka2p2Q0cwYnFzcldP?=
 =?utf-8?B?dWJBV3JzVUE1LzRIY29nU01aOE8vMmZxbk9heUczQ0l1Zm1KK1FIUmhkY1hC?=
 =?utf-8?B?am9GRndkdGt1d1orQ3lFRVJlcndyWEMxajQ3UExTK3pOVTh5UkprZkpaL3Nz?=
 =?utf-8?B?TjhGSDhwUUc0OFIxUzkwcjUxSHVBUW5UWTRpczN5cmc1VlVpekNhbjVneFN2?=
 =?utf-8?B?VGw1a2x3UzRvT3J4T2FBanhjSjVSV0RhWHFsSmltQmFIVGFiSndiQU5VN0pK?=
 =?utf-8?B?aDVLdDdCeUJEMEtxVG9FL0NsNXl1b0RHbittT3VsZ0RlaXE3a0p3QUs4Znli?=
 =?utf-8?B?cWNjaFJkeGxCaVNrYkdjTFZyOGRTTVUxUVQ5V1hHQ0p4YmhBcHE4YTNRSHl4?=
 =?utf-8?B?dkJQQlJPaU1xVFpqSHZPSmkwN25uMzdyQkZXWFB2NWYzV0tsYy81UjBQVEQy?=
 =?utf-8?B?dkpETFl2MUswcE5lVDFBWWwwbEFoQmw3MUNobzNvRU02eXhQM3lzb0RmeWNh?=
 =?utf-8?B?QlZmOURTYzRqeUJiOTB0SGVIQmhyMXRiamVsQXczNlJpTnRVVTYrYVM3YTlj?=
 =?utf-8?B?K0gySzU2bkNrNGFiVHc1MkJnVVZDWHJoRWIxdldlZEo4QnQvb2x2OGNxWUFJ?=
 =?utf-8?B?Nm91TXl6WjNVYnlSN3ZQOW0wU1RTQ3QwVzIrS0poeHNPejZRb2dBOHg0bW5k?=
 =?utf-8?B?aHlCaGVFSFZveXArUm5UbjFrWVdrVVJscFRGeW9lei9FaXZZMS9rdFduNHIw?=
 =?utf-8?B?anpjN1JvWWdhUTF1MS9hWUZXMitNYVVsSUdYdTgyaVJwRHg0cXpsbzR4cmxk?=
 =?utf-8?B?YmFEb0N4ZFhNeUlTZDRMRXRnZGVDUGZhT3V6OGtDUjIybjYvTEFLZHpOYm1X?=
 =?utf-8?B?Q2NwamJyYXNQVXNJNGhqZVNEbjJEa0tCZDVPdjk3MVh6SnYxSU1GNlRFM3RY?=
 =?utf-8?B?WHovVExyN0FtSUxvV0lUdVZDaHNPMnJUb21XU2t0cEdqTTk5WVhOK0R6enVx?=
 =?utf-8?B?MUsyOWZoQ1R5ZmpDRmVmOFkvc3lsTFQrUllEcU5Gdy81MTR6RU0xa1hJWDhm?=
 =?utf-8?B?Qkt0UFcwbHRoODFCK3ZTbkhBeXJpeFRSU2xzRTdXYW56N2EzTHZndmRMMXNY?=
 =?utf-8?B?citxUENFRHhhVytxV2g1RVRjMlMrRjdFT2VWNHhVck5TeWxUMWVxTXE5RUNH?=
 =?utf-8?B?S3dSQ05wcTRmWVVTUXhoQ0lYZTBsN3gwZFdGOFNNbkI2Um55b2ZUUkxLTlhz?=
 =?utf-8?B?ZnNackdVbTBiT2dmbm01clNwemhUN2tneURHN09iSzZPZVdLWmYydFo2T1pq?=
 =?utf-8?B?UGptTXdFKy9DcjJ5cndSeXRKemRMNXFTbkJsa2hMTElMTzk1OFkyTlQxYnVF?=
 =?utf-8?B?OGRQU2p0NXRzVGVhbTNjZnR0ODJpck4yOFZqNzM1UUsrOGNmUzNaZW9KRFZi?=
 =?utf-8?B?U3g3L0xSbnJGK1pWSkUrOE5QZlZWSmFkRkhqcUlnb1M2SmxFVXNSSEhCMHRR?=
 =?utf-8?B?MnFRM2Irb2ptRk9RTkFTcU9qTmQ5M0NnVThuWC9mVUV6S3lJK01aRGYxWlJY?=
 =?utf-8?B?clJSNDZBZkZrejJNYy9DSmdXcDcxdUVwU0ZPQ0JIbEYvMGg5R0hxK01wN2Iz?=
 =?utf-8?B?c2dIRHpqUzA4MGxmUEJYeldQQ2hYSTdKTnkwck1xTEZjZ2g0VHAvVHZnZTl4?=
 =?utf-8?B?Q1ROSVNzbnZ3QVpFSE1kVmN0Tkx3ZmNJMGJrZDJIRXQzOU5BbkJGM3kyNnVa?=
 =?utf-8?B?c2xzRXMyZWk2TjdOdTFLdHF0RlYrZlBOdUdUT3FkWDVMV2I5WXRHUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaacb30-5c1f-4dc2-4a95-08de4daf06a6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:38:46.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKqzDDcxhIvN9w13CIPXIIx28K8hzsG/d96LwVMHTxtigQvM3wID3KX59VthvUgTMo34+NwNBOFOmsP/swhZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8610

Hi,

Just a gentle ping regarding this patch.


Best regards,

Yang


> [ EXTERNAL EMAIL ]
>
> From: Yang Li <yang.li@amlogic.com>
>
> Enable the PA Sync Lost event mask to ensure
> PA sync loss is properly reported and handled.
>
> Fixes 59e5396a2579 ("Bluetooth: hci_event: Fix not handling PA Sync Lost event")
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>   net/bluetooth/hci_sync.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5de98be752bc..3f04510b806b 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4420,6 +4420,7 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
>          if (bis_capable(hdev)) {
>                  events[1] |= 0x20;      /* LE PA Report */
>                  events[1] |= 0x40;      /* LE PA Sync Established */
> +               events[1] |= 0x80;      /* LE PA Sync Lost */
>                  events[3] |= 0x04;      /* LE Create BIG Complete */
>                  events[3] |= 0x08;      /* LE Terminate BIG Complete */
>                  events[3] |= 0x10;      /* LE BIG Sync Established */
>
> ---
> base-commit: 98246938a0e66e4100e95b6b7881843a9a4e4882
> change-id: 20251219-enable_pa_sync_lost_mask-ae0fb71f29f3
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
