Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023127.outbound.protection.outlook.com [40.107.44.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59329AB1A;
	Thu,  3 Jul 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532303; cv=fail; b=b1YThVSwvCRmD6DyRuRIzVqMZ6EDtLt4Kzx/BTCC/X6dyVb8Al7TxZT+yKfCiNJQRZSjq17SzhoTqUFmwIB3zhkjtfZ9sNx6GZK0J7dU6Tg1bpfGpxAILUSeqCsAqfDySrdAm2jYOhHfCljLZ1kg5JA4CweX8jnbmuO80a6Ed/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532303; c=relaxed/simple;
	bh=FXRIcZIy3ya1Q1PuZGmIc7XEtJGIrsN4d6PDC+wPKzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ILSR0UnrmygKX4NQGRmFW9iuLumYE1wzhfnzyCCjGzf5Z++rJJMG1MPr4oUdsibGPnHI9kxJ4r7z4W2Op2PJ2vLSUtVAuejd+iSF9tIbAwUmnfeAD+45z0snr7cGjQqGFDew9PLCguggCd1EoCQDLZqsoEDrrxPSW7al+yy3Xws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=urLAB9rY; arc=fail smtp.client-ip=40.107.44.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="urLAB9rY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dY0FVpbaOn3f+hEbt4ONzpAYZHDCN4Qw5R9nMkNphptSLoJPGHlgZ3XhHVUY7xAQVSXoaczet52SELMrREzlGudhb9Of9Kn3LBtIHbm2/Iw0LzeGO0s+lvE3OBP5pb4BHXVPnlhEzOQ25OvdJHaqmQEQ0zx8eMOQXauUTf2g8ELW2yPI1MBclwGooPWZU0rJBxrClfVoYWm9DvJGvVHzGreqm2U6A0am3sUTxDhfLltfIE6DTLMt/JREjsXNPK6BkEnk/ywugG/zJHGnEB7P06L278+FR9n/QGqMlTZNouhDVYCHJbg37LfPptN186e+pbCDyFJ4lysE41u/VqaOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPKzPME3OkKVgVWDUqmcxZ2pjWgjSx/Z0KRlmEp/oYo=;
 b=OET0VgPKer5dLxTX/SFpvJzjTs39diSPQDIcrEYDBJwcNEisetobLukjxXlk4QdaJJfjtP2FmAJwt/vimBoWy4S5wcjC549ZlMM9z9iCbc9hyBFMwRZgv7QraXAGAb0tX337/3KcMpXaDrScf0PtHVCrekvbjHNeYBT8OzLWrcFG0OBkUPWQiW8ATOXfg/Za0ya2fGpbniUv0sz3NQuv1JE8mO+InP+XdoGYENuobXfufAwTQb3hdth8ozGoLoyIVsEtEU6SYVRQhoq4gp2woGLRYTKxeXV8wAAQ4zbpM6zEQgmUrIZuZrXovdhD+hVmydYBU2zm0CuYOt4dhFFXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPKzPME3OkKVgVWDUqmcxZ2pjWgjSx/Z0KRlmEp/oYo=;
 b=urLAB9rY45elmorS9gotS/uQTXkhpXibCb+bvzzdMA3rXOuLPnKIDmjO5oDtSKJfzzr9ju8O/gbF2E4vaozfAKv179fkRFMlNpn/gEzbFYqMMRkw/gNiNGYjliiMdvjZncS1ri2EG+qU+ZBGp557WFOJC5j32bLrPOGNtJRBFB1paa+amYg5HKVNs4Wv4dWI7uyUQ9hCGwCTFfyHK8LYIDChWXVDiNOMxGA3MDfaBlmX197CBzjYOZR+UPyIWnTyDVFMacKFSoD7Cb+JgCq1tC2Qj7oUdqkqXWD0NztZ4hmKUT8PtjnZit9x9IA5Ac80ka6HeELO5uhSP2XXLTwYcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB7533.apcprd03.prod.outlook.com (2603:1096:101:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:44:58 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 08:44:58 +0000
Message-ID: <583badf5-26b0-431f-abe8-e411ef126c26@amlogic.com>
Date: Thu, 3 Jul 2025 16:44:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: Hold PA sync conn when BIG sync
 established
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
 <CABBYNZJJJcjhwbDwYZxqxu-RHtyUd9T3Lvf-qEqgNfxfCsk+9w@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJJJcjhwbDwYZxqxu-RHtyUd9T3Lvf-qEqgNfxfCsk+9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb76516-2372-4aa2-a04c-08ddba0de419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1Z4dzRTRzlTNElHMlo4M2s3NXFxUktYd3hvazgvWUdodzBPOUZLb0Z3VGo4?=
 =?utf-8?B?NHhjenZpZ1NZaXdlc2VWT0d5a3Y0MWlrTkVxVWdvV0JUSkNEeU01NjhwOURw?=
 =?utf-8?B?K0tiL2R5MWdOQVRMVDdxL05rS2lHWTNodEI0d0tPb2Z5SEZNS0lTQzZ4NW1T?=
 =?utf-8?B?Q05sSzYybmozeXhtTkV1RVpRaHR5U3huaDdFaHFoYnFVQ1NiOVVDb0ZROU04?=
 =?utf-8?B?cE9GKzNQZGlvNUZFYUVVVnk0c2VQdFZkRk1yTkRadHlMeHhPRTlVWkNUS25G?=
 =?utf-8?B?MkxwMCszZ2NjaDdiZCszODkzTXIrUU94RmUxVUlyVEFGb0Zhbmk1ZEZoSDV2?=
 =?utf-8?B?RWxkWVJOTHJNRWlKZkQ3TVNLVSttbTJvYjd0TTRtYW1wb0xoYmVoVWlkczI4?=
 =?utf-8?B?LytDQWc3Nkc4Qy8wR1cvRzBZZVRNdGxySzV1OThycDQrSzJNQzBqanBNUkYv?=
 =?utf-8?B?WjNWa0k2ZmRaTTRrNDQycEFrY052VUZKRWl4UlJDTHkwZHNWK2lDQVlGTXJi?=
 =?utf-8?B?NHM0dUl0d21CUWp1aU1CaUlkb1l4UkVsbURjRXlBdGRNVmozK013a1huOXFu?=
 =?utf-8?B?WWNDc1FNS29ESU1nSkpCTE5DMVFndkVnU3p0dVZ1STIzN3l3YTVqY2VUUm1y?=
 =?utf-8?B?VDE5dEdTbUxtcUl6YVVnM2s4ZExXUFEyTHQ3OWVMd054RFhIUHlqeGFyRURq?=
 =?utf-8?B?L2JaTTcvcTBXbSsySENDK2xHM3B6TG1kcHBsME1PNUNyTEZvUUZSOU8wU29x?=
 =?utf-8?B?MDgzSGFZS1VEZU1sUExuZVl3bmdHSnh1QlBuMEhqZGZSR3h6bHhpOUlCR2F3?=
 =?utf-8?B?ZVBncTZVYnFZQ1RiK3I0UmRJZ2VrRDRXcE9HWEJiL214WitlTzNHNld2dkU3?=
 =?utf-8?B?a2dwZXdVSjRWMEpLNG1QdmtZeWZCRmp5UHl0YTZmK2lsMy9zWmZpd0RzQU1p?=
 =?utf-8?B?RTBla2NzTG9YZXZrdDBSN0dzQUplSGJ4TlBqM1JOWVhqS3E0Z1lzcmhibW9r?=
 =?utf-8?B?ekVVTk9NYXRxUUZuMmJkK2t5TDRwbU96Uys5UFQzcXNzK3h3Z2hyWGtqQk9a?=
 =?utf-8?B?SnFEWGdRR2dVekJSUWtOQnJDdWJHNHo1ZXQ2KzNQY2c5L2duWTlPUnQxdnRK?=
 =?utf-8?B?VGg1TjUrRTBvZUZVdVF2Z1Rjb051KzVvSS8rQXl3NjdPcW8ybjhwTVpKNE4v?=
 =?utf-8?B?ejVtMTg5bjBBQk5uS3prNUZOWUQza0pFVDJBU05BZ3ZtS1Zoa3lYVEUwdzRL?=
 =?utf-8?B?RGsyUnlkV1VEaktIeTFBNkk4RmphSmczNUlldng4WktBWEN1dnJTMWVwNmFl?=
 =?utf-8?B?RWExNGVjTC9GNENXSk1aVW9VWG0zbnhNUDZiVmJjWGFwMDRIbktDRVcyS2NG?=
 =?utf-8?B?YkVEWElHdWVSMFYwNnpWWldqUWQxTTJ5K2VtMDNPY0pXU3dJeFZLYWhaTFhO?=
 =?utf-8?B?VjNTVWZLNEpNNnBhT0crM21CUHo2YVlZVkVoeW9xa096RVNoNTljWEdEcGFG?=
 =?utf-8?B?eW0xNmF2Rkt0MW43TmNLMWVqbE5iaXlpeDRiOHJlYVNzaUVpUmxmMGdNT0pQ?=
 =?utf-8?B?UGUzSTRMWXhTRkFWbVBPS0JRRlRsbjN1bFZDaHNRZFZ1bXZ3cEtwTG1QYkFh?=
 =?utf-8?B?YzJPbitZSWVwVXhLdmJwajVmc2lPQTJ2c1kxWE9iMkhLVmkzODF0Uk9Ncy80?=
 =?utf-8?B?SlBHSHZOM2M3dm5wczVuK0Y5ZHpkaVcwT3cxa1NSTklKR1MxZFhNbDE0Y1NR?=
 =?utf-8?B?TjAxcWk2WFJPcmRkaWNnZGNCM3U2V3FqekNmdWlSNFN1azY4Vmd6SWZEMk1x?=
 =?utf-8?B?TGxvL3V2amVCZXVJMThZK21WK2xMTTc3cDVvRW5Zay81bm1NN0pTcDVkSm82?=
 =?utf-8?B?UXZtdGlhejcwbUlkZXRneVpkOHhpSXBwb3dla1B0d2R5L1hJQ1kzbUhiV0w1?=
 =?utf-8?Q?SiOr1sT/yO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzdmWWdhVUR6bXc5dVlLT2U3Q0c1Zk5XSXM2STZGNGhHUU85dmlMRmE2L1ps?=
 =?utf-8?B?dWNMcXdCM3RDRFVlN3VicUNXblNnZjB4WnZ3TmVpbWdDVC9OTnBqY0hoQUEw?=
 =?utf-8?B?eCswcUwrQnRXRUVUQ2xrblkxU05OZVUxWjBrV2ZZd0xUK25Sclc5U3duRW9M?=
 =?utf-8?B?cnpNY2lsdm9BSnR2RUFnVmRaWEh0dUFsQlo4dEFTUEpzeTJPR2EzeUMxZ0dL?=
 =?utf-8?B?TkVML1Y1ZDBIYmJEY0ZXNVF2QUo0bGhDck56Y0ovOHkrUXFwVHNCcUdYYmpP?=
 =?utf-8?B?TFVaSlZSWFBFcVJuV21rNXpVaWw1T2hIQytKQnJLOUR1MzliMnUzTStEVW5Q?=
 =?utf-8?B?NkZCeFIyYVMzUkNvZHJCYnFiSmgyV3ZQN2xjUUh5ckYyUlZDTGtxWThicSsy?=
 =?utf-8?B?dzdzRzcra0Z0aExib05ueGEvQVBRd3FaZ01TYzN5THUxNmlTOTkwMW5ac1Rj?=
 =?utf-8?B?TkZZR25Na0Z4alpCa1Y2UTRodnRQUHR4UkhHeUIrREIvQmVxY2hNaW43c3Aw?=
 =?utf-8?B?VzNrd3JlODZVT2VSeHhscndVRngwVlFFZmJMaHFpd1JBR3FScS9JcHR6ZDFO?=
 =?utf-8?B?RkRyRU8yeGpVTmluRUpDRi8rYndyVzFqT0RsUTJENDFuRm1oUmRvMG5LTU9v?=
 =?utf-8?B?QURLQnpvWEY0SVJhNkhNdlBEcWxRT0tBNEFmUU9KckJabHcxVFl1OVp3WklT?=
 =?utf-8?B?eFQ2aEJuNjhzaWV6VWdCZXJJT0VQS2o3TkVNWSt5Nnc2TkNqMC9pblQ2VU4r?=
 =?utf-8?B?Ty9GL1ZHZzh6c0NTa05uVlp2WWM1ZVc1bGl3S1pyM25VaFFtSmE3WGNxZ2JC?=
 =?utf-8?B?MEJ6OFZiTDJRQXI4aGJmOExKL1NvdVFvcUNEM2Q0a2NSS2Q5VktoN1grU3kw?=
 =?utf-8?B?U1FBSjA1K2UwdVNWa2ZIY1hvQ2xDTE1PWTFFU1lNZnRrMXdyUjhxTkdtcnd5?=
 =?utf-8?B?VUJiWWdCbi8ya3BiR3NJUmFJWmNnUjBoaWVWRXFjQUdMWmZIWHp2TXRIaTZi?=
 =?utf-8?B?K0VUOHB6VklvcUtvcUhIbjJyejFSS0Q4elBUYVQrZjQ0dW4zVkYwTndxL1VD?=
 =?utf-8?B?M2g0MDJMOFplNzA5dGZLa0dlVDVQR2l2dlhnbGI3VVUyYmlWbFBreHNCN2ZE?=
 =?utf-8?B?WlpPUS8zTmJubmg4aUZ6Kyt1SCtKTVZJalJGbCt1dG8veGY5bm53eEY1Qm9i?=
 =?utf-8?B?Y3dQNzgvbUhKdVIxSnBSdjlkaUpPbm5YQnFKVDdQdVRvQlE2SnF0VzNqTlRw?=
 =?utf-8?B?MXV0RURhNkFjQ2JIb0VpbmUrNitMVXVMQ2daSHdPZWwwT2ROeDM5MzlPZDBD?=
 =?utf-8?B?RnNtY1kwVitmY1NVa2hOV2xaQnVtV1NCcHBVb09UZnE5cWlmT1AyeTJaWUtJ?=
 =?utf-8?B?YzI5eXRwWWJvbGZVVmlmbHdqWDVUOVoyYkVxKzBpZW1mbEhWTkdPOWp5MDNm?=
 =?utf-8?B?dStXSU94NkllVkZLL3J0NFdnYSsrb2JJRE9QK2ZPOVhGQlpmUVpLL0dtenJG?=
 =?utf-8?B?eEx1UWg4L1JlcCtwN25kRUFUUm44T3JCbmtuUmowQ1oyRDdDaUgzTGhrbloy?=
 =?utf-8?B?ZmdDU3dkSlRrVG1Db29NdktNZWdDYXNzWUdlcU8rTVJqY082My9KRExGQS85?=
 =?utf-8?B?dHZyL2VIdk9jRlI3bjdIQXJJWTlWM3NIdzN5cExaSTdadnNERUtNY21FaUFN?=
 =?utf-8?B?cUoydUo1cHlKd2VZQkI0ZWkxRGZLQlpRM0wxc1p6bDZTc2hxanZIYmpLbjdC?=
 =?utf-8?B?U2l5Rk51Zy9JdUpIdFpsU0orbzdHK2dWNlhvUzVzYklFRVZuWC8wU1owM0Zu?=
 =?utf-8?B?S3ZNcnFVNTcra2hGQlV4aGd2NEd3N1ZGNFFtRXM5c1RXZmxDbURneGU2aSt2?=
 =?utf-8?B?cGJXeEtiS3ZXYTJ0MmJrTVNISnE1RUV6TjlUdHhIbXhqdmQ2TEFncXY2TFhh?=
 =?utf-8?B?emE0SEM1QS9hWHNzME4reS9zZjVXSnhHUmlaYlVPZnZFdFJOYlVvb2V2V21I?=
 =?utf-8?B?cFdTUkpzRmhKVTRiRmNTNUhLVDU1VXZZN3V1RGxZM1A0b1NnZ05pajJrWG5Y?=
 =?utf-8?B?dThMcXNXMnRTcWJEVGhyOWNLR2p1d3dVc1JVSlBOTkZ5NmRvbTRRQk5saEVI?=
 =?utf-8?Q?4nebIQe9A0N1DzkmO1MavWESN?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb76516-2372-4aa2-a04c-08ddba0de419
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:44:58.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGFkcLZMWEUM9JuN2DUsH2uUVJ4DzkH+VNpJ6XL9M4lVveev1WRql2Ts9l7cBgvzqrjLg7VGqwuI2JofNe1Mhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7533

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Tue, Jul 1, 2025 at 11:12 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Hold PA sync connection to prevent cleanup during hci_conn_timeout.
> You will need to do a better job explaining what is the issue here.


Since the PA sync connection is set to BT_CONNECTED in 
hci_le_big_sync_established_evt, if its status is BT_CONNECTED when 
hci_abort_conn_sync is called, hci_disconnect_sync() will be executed, 
which will cause the PA sync connection to be deleted.

int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 
reason)
{
...
     switch (conn->state) {
     case BT_CONNECTED:
     case BT_CONFIG:
         err = hci_disconnect_sync(hdev, conn, reason);
         break;
...

stack trace as below:

[   55.154495][0 T1966  d.] CPU: 0 PID: 1966 Comm: kworker/u9:0 Tainted: 
G           O       6.6.77 #104
[   55.155721][0 T1966  d.] Hardware name: Amlogic (DT)
[   55.156336][0 T1966  d.] Workqueue: hci0 hci_cmd_sync_work
[   55.157018][0 T1966  d.] Call trace:
[   55.157461][0 T1966  d.]  dump_backtrace+0x94/0xec
[   55.158056][0 T1966  d.]  show_stack+0x18/0x24
[   55.158607][0 T1966  d.]  dump_stack_lvl+0x48/0x60
[   55.159205][0 T1966  d.]  dump_stack+0x18/0x24
[   55.159756][0 T1966  d.]  hci_conn_del+0x1c/0x12c
[   55.160341][0 T1966  d.]  hci_conn_failed+0xdc/0x150
[   55.160958][0 T1966  d.]  hci_abort_conn_sync+0x204/0x388
[   55.161630][0 T1966  d.]  abort_conn_sync+0x58/0x80
[   55.162237][0 T1966  d.]  hci_cmd_sync_work+0x94/0x100
[   55.162877][0 T1966  d.]  process_one_work+0x168/0x444
[   55.163516][0 T1966  d.]  worker_thread+0x378/0x3f4
[   55.164122][0 T1966  d.]  kthread+0x108/0x10c
[   55.164664][0 T1966  d.]  ret_from_fork+0x10/0x20
[   55.165408][0 T1966  d.] hci0 hcon 000000004f36962c handle 3841 #PA 
sync connection


btmon trace:

< HCI Command: Disconnect (0x01|0x0006) plen 3             #75 [hci0] 
14.640630
         Handle: 3841
         Reason: Remote User Terminated Connection (0x13)
 > HCI Event: Command Status (0x0f) plen 4                  #76 [hci0] 
14.642103
       Disconnect (0x01|0x0006) ncmd 1
         Status: Invalid HCI Command Parameters (0x12)


So the current question is whether the PA sync connection, which is 
marked as BT_CONNECTED, really needs to be disconnected.
If it does need to be disconnected, then the PA sync terminate command 
must be executed.
However, in my opinion, the PA sync connection should not be disconnected.

>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   net/bluetooth/hci_event.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index e817c4a77f97..85ae1608e028 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -6968,6 +6968,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>
>>                  if (!ev->status) {
>>                          conn->state = BT_CONNECTED;
>> +                       /* Prevent cleanup in hci_conn_timeout. */
>> +                       hci_conn_hold(conn);
>> +
>>                          set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
>>                          hci_debugfs_create_conn(conn);
>>                          hci_conn_add_sysfs(conn);
>>
>> ---
>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>> change-id: 20250702-hold_pa_sync-91ca7a81adf0
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>
> --
> Luiz Augusto von Dentz
