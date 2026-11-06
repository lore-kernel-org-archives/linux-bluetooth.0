Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793934929;
	b=fLmmFl4csiX6P4ljl6xf3ubeK9aV4AU2hZcuvJ/EPfCPWhGAQhnUO/FJoByEUsJONk8t
	 yLVcX18bOC+KRYKOxPxUrML+4juS+nhT83WH1TLMFenNYZs7Apgov2S6sOThf4l0aqoFf
	 tQohWDmG1DjttnrCfKDp3e5YlAdsiHCk/7LwKtrZPD1wmIXHVPo4+s7sYwiNuP3QMr8se
	 R5yJJDSdQ/eCxlPSorqzLpAFZsl6UoG/tLqIOwK3DJeI47NAn5vM+jvjnofID9KY69ltv
	 RxoAC/z1m0q0sPLCRLKeqZSJMyCiElK/ftgM8C20Jg54KnUR7VWs24wEu50sJFcks+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934929;
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
	bh=7rQdytvDsqHVy4X7k9Ar5sz//8F9PAiMyb4FMZqXv2E=;
	b=O66pWntIr5eZASsmvUuqikwaOHkx1hDebHoi4eijhZrkN5QPLLM1Dh2+CLHdxjJ7l7vv
	 gdcQssgT+dFQaKaoxkdndsirygfNzkc0aOdf2uSjMv3hGGQs3UYtj+fZFVW6u9XnafOxd
	 oMprVoj7Kbr45fMOBprLfMc2aicUd/kobDFTYQ4nSp4M3/S4TuMho2K4VcUkFZImG1cmU
	 MjASmqW7E7slfh/+PSZ0C6MYbTsqDCheXlIsawtkd4/rByT/UfAWm8cKYOL/HygQPHWmm
	 MCKxlrviWqIqHquextKcPBungHsZc7XhFlP7Waqog4KZtwVUf/0VsGbdIFl44sR+Big==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=tn8SLTew;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.106
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023106.outbound.protection.outlook.com [40.107.44.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44E606A328;
	Fri,  6 Nov 2026 03:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB44E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=tn8SLTew
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq+Mn6+lP0HlvRR+yjpCB0TewnEHloqc8JWnShTrkwrVhKwxm+a3857tNPnI1xSPHMuY9k2dyDF/+vK26f6OB/npZKsmN5gPnvIwXmmsq1IV410SwRm7HlJPQEo/1DgV8puFPm8lSN1BZrE1EhoFyswZgc6Xc8qxIEF1hOqIe2fkv7dhUIHUuRAb+p5YXbacR7qwrKAXthwVhvMzlI6pxjfr0RYxmaNy4dNdI8shqjOA1k610AG/Ets7iIY81VfNbVqUWFnaerguBL/xJ5FGkFdN9IhZfmTIijZme9dIgj37SJ3mVrcX8AIqmUjbVq/ooJUyIv+JwXij0zRA6aZdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rQdytvDsqHVy4X7k9Ar5sz//8F9PAiMyb4FMZqXv2E=;
 b=Wn789CciqmRZnw9PNgNwJmZI6I9/oKQSM0Kk+0xLa1PqQI1Tb+oZpTPWa9JCJMIcNTsss/y2qFnbEtdn0OdLwkAmSTxmptHlW6uVGSVvdHs9x0ZE0GQedrys8oJUlX7+VF5rwusqBdFtrd2Lubh226wq3Q9sz0yM2Ez5TrvvRZhxikspgQcx7aygNlGCKUu4X2Dl9OwSmv3ykA6WYBGMBbNw/TjHsU1qjoMdpGsS5/HLXX0hujBRnQLI7cPkrWm/h8QeX5o9Pb3Y3+4mYWkgpiam35N7rrHYKCIPwzvBjyxfGAWaF2wnx74nwow6s6BPwrS6+SM0O6xTpFPCEVuVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rQdytvDsqHVy4X7k9Ar5sz//8F9PAiMyb4FMZqXv2E=;
 b=tn8SLTew5EvfNm2gkRJQdtsaCS6CRF6kbaYHKIRidLDu+RxNKejp96peJQOPZIvwDQEq35FSFom3KSk+kZafSlfyGnnplb2VGTuBZ+fNTKmvq7bvQohg1BO681tAKouE0SPFa7AyeHBxJQN0gqMx3qPVbIDOn8jjK2E61qOU1e7PwDwvHU43e0hVVNivjFdYsbwyiphh0/LFxD4QWWoFC0h3g1bjCgXn+gGCfO6kvo3dxy70ejkvohag/MD5aC8TrUaWaG1EXcbne9fiJE/YKtmzqKLN/SqkQMUr5w3V/bIK1MTLhU593c6spvsmCQvPX2GHFiRrKtKwwkYNAHjFOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by TYSPR03MB7941.apcprd03.prod.outlook.com (2603:1096:400:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 03:15:23 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 03:15:22 +0000
Message-ID: <5ebaca7d-5295-4b0d-a6a2-0415d8db6f34@amlogic.com>
Date: Fri, 6 Nov 2026 11:15:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] Bluetooth: hci_aml: take the address from the
 firmware description
To: christian.koever-draxl@student.uibk.ac.at, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-6-christian.koever-draxl@student.uibk.ac.at>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20261025192338.209574-6-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
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
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|TYSPR03MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b87bb7-09cc-43b4-5027-08df3bb4316d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261026121527099003|4143699003|11063799006|56012099006|261026140227099003|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XwIe7NbPojgnLg1aUXu9gv6Os28HJUz6wMMARApEJCgaT0qAjkmp0AzzpfpnNlLWK6/ONZOS8e1UDJfuJJT/qr8gJhOzMh4pLjFH67vyrMSQCZPEeuGSFvuj5Kt244jKBBIpsHetuJyDlMIRUZRpQ0Q3XqjLQluJXJBGgp1NgQSqORBeGtjMmo2eJU6X6dYHUcEGxQ6k5TJRRTb3LiCAgq++R7ch+yDSRDECuOqd2aAuwxtFt1G2m7PwSp1PdKgMvDJoNcagOetpJ3G3CtL93td5HLZ977Q7acL/FETbQFkWaWpjrJq6IM6OM0WaIVXRQCNdcW8G/Sy/7HikFoZZfATEIHfvkfp3tsKA8Z34R37ItLyVBmNW3A12H4pad2x9lsUPmhc9tJbWvkSJXKeVi0pXMCGg+ljp8Nuihscw0p+/CHHF0WTq4RdSbHGqqdnf/bLFu0pshuKXiZgh8WN3Ijcs+VHgdlxFMoexkSQhSg7Y3kIKQaq4zwHkqTp+sQKYvT0B/T6/XoK8L+iMDLdjlcccrQK7GSwYLCx6E6JhySlDaw/AyOn5htKFL3aT2ZSI78ww1354V66F/2g9ki0dWJ+iuIASzwPqkN4Nk2C55WMoMprZWp9iG1KQocc1kt8KVHe15bhpVDwR0Dz34dMcHlxWH/N8jpBlsX4vy7VvTv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261026121527099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTdtRyt3cWdDWFo5RDdJbWpBRGNmQnNqTnFVcnNjTGUwUTZKVHNjVDN5WTRE?=
 =?utf-8?B?d2lrRnpPbnJWZGltaHdlQmpxZTVqVWMyQk9ONUJJV0E0SWd0Zm5BTXJ2Y3M4?=
 =?utf-8?B?akxpSXlUR2NFbWV0R0s2WkhrUDN3ZHlSeDZYcS96NWRzL2k4OENrb2lULzhO?=
 =?utf-8?B?VDJTWGRCaXhSRnF3TEJqSkJ5dWRMQzVqYXVyeGVLUFZKcjNOVnFMbHAzMU9w?=
 =?utf-8?B?RkVQS1NpcWl6NnhEdHBYV1g1RnpmRVFtbUk4UHZBRVR1RWpnMHNpZzdVSkJW?=
 =?utf-8?B?MlV1dXQ1OFA5eWxvOXdjRFgyeEQwaS9hU2NKbWVIWmN3d3dKdkd2NnRJeTNp?=
 =?utf-8?B?TE0vN1RNa0pWd1VxdG00UzVHMU9CQUx4Y1RmKzVJN1psb3B6c2t5R3I2VFdU?=
 =?utf-8?B?N3IwSDIrZnhBYyt5Wm5VZ0JOL3pOaVZmOExJa1hDY21JYU92SDJ0MVdzTjZt?=
 =?utf-8?B?cHZLdmJHRkFTeThWcmFndmk0TDVxYTBJaXVJQnkrWndPUHVKTWNnOWpOeUFD?=
 =?utf-8?B?Lzhad0g1dkhhQlp6N1ZIN21IUnRqU25BbEtZMkNCR0t5NWlWdlB0RGdLcDE3?=
 =?utf-8?B?UnRCVkZwYkxMVHFURTFNeElzdlhjRmxkS3RBa0JaVGtibEFzVFBUdTZ4NXZk?=
 =?utf-8?B?bmhJYUlKWnNRMXZ6UzhITFJ3b3lUT1N0QVAwY0hyd2ZlTkNyK2cwMHlwdVBM?=
 =?utf-8?B?emRwN2c4OGxDY21OOWpadGFKcEJOVHVOZzZLOFJZNFJaNXBOcW9ONHdOQTVh?=
 =?utf-8?B?QUFZNUUwaVFwVC9ZLzIwQzBoZ1RXcHROTDJSQmpBdG05ZXY5c1ZISTNCdjZa?=
 =?utf-8?B?U3JEU25pSW9ybWt1M0txdGJRYWpPTEh2VUZyUVNIQTF3eWpLMUM2US9na215?=
 =?utf-8?B?cmhaVExpWEJ1TUw0NEl5NGxLVjh0cmI5d0NXYVdKbEFXQ285bktJeXB1N245?=
 =?utf-8?B?czluR2VhaXJsV1JnRkdGaGtRUGdNYlBaVzg1Z05Uek1XSkVoWkppa3lKU0xt?=
 =?utf-8?B?TjZrbWpoMjIvb0QwZWdlMnA3SzlPTHozY1JzZWhGQTdoMFJrMUNtdXFXUUtj?=
 =?utf-8?B?TDJzZ2hMQ0VHeUVxUWw3SkNlb2trS0cyMitJZ0VQOEUxc0dzT1hJVHdxYnlj?=
 =?utf-8?B?dlNUelZBVXVLV0xtSFJNQitQSkViYWZvOGVBMXlZWm1RWHJtL005T2dtdVov?=
 =?utf-8?B?MUlnNFNVNkp6UTBRV09PcHMxY2V2TTdPT2ZQRkYxcFBnd0FpZk9GT2x5WXN0?=
 =?utf-8?B?QlNaQlhJcjg5NVN4eWk0NndQcVZ0S280QVVIdVV2aFMyek9saFRrb2ZjWGhE?=
 =?utf-8?B?VDFSaWlmSzRmRHR0MExjSUQxSlZQZkNpVm5mb3JuZWpwOUlhZ2oyak9vUXNk?=
 =?utf-8?B?TmZkRzlMMWtiV1NsNUlKWGpSTnkwRkRScXVVc2d6NkpzalNNWUZpdUNzYW5B?=
 =?utf-8?B?VThWeTFuMmZXU1hTN1hiOVpHZ3dSRGVpNGl0SEpGTjdIc1lYT29uNWQ1U3hN?=
 =?utf-8?B?cW00RzBlL2w2TjEra3A2U3FQdnBrcFB3VnBsMDNKeHJBbXB1bUhiTGRzR2hr?=
 =?utf-8?B?bVJsNVVTeGFMTUNoZGFQQ01rQlJYTjVDajNuVERTRXFhN1hFODNpWmhuUTJs?=
 =?utf-8?B?clY5S0FZc3RzZk9LZG5SSWIvVmhmRExkZmxUL3YvMlE4aFpKVHhNdlBTeUJv?=
 =?utf-8?B?N0MySGRucGU0S0xPazVSVzYxSDErNExhcThta1ZWUTJDZHphZ3dXUkJDN1lC?=
 =?utf-8?B?VTVPYktIVG1Ma05JK2k0TmRmR1UzSGVZRzR0ak9ZN3d0WVp0VFptVnJZNHZy?=
 =?utf-8?B?Um5BK1Q0cWJYY2tKU2kySVgycnlMVFRWbStoVUlLVlNHd0syQmFGUTV6TUll?=
 =?utf-8?B?UjlmTmlmNllsMmJkcE4vNW9Na0NjVTlwcTlZM1RNNlBYNGkwK1NFMUxrZHlK?=
 =?utf-8?B?WnJUaGk3a1kyT2x3aGhOcXNCNkw1TFRENWtxLzQvdE04SzB2RXByZFBMenli?=
 =?utf-8?B?WUJnYWZ3SEU3WDg3M2ZEVzh5bFR5alFNQS9LTSt4c1ZTZGQ2T09NblNBRXVj?=
 =?utf-8?B?TWUvN1dGNzlpSkEyRHFPdGEzQTNIaFpRdzFrTU1DSGt2YjB3T0tRcUVRU0R5?=
 =?utf-8?B?eGRpUW9JQUV2d1pvRWh6cUlJOWNSUmU0azZJVTNnaG42bE1BdXlPdERqR01M?=
 =?utf-8?B?U3BZWVhUMlcvN1ZaVW9WRzhwd1pMVzI4cUhWdW5PTkJHR2piclR1TlcrTWJm?=
 =?utf-8?B?RDlVNnArRFI5cnJKN0N2RVdXRXBlbW0ySmxJdWV0M01Bb0xvVTE2blhhVlpV?=
 =?utf-8?B?VmwzbVBGR0V4bUIwY1RJWGVEazBWb0pBdFdOZFRjZkhHbXJmS0k5QT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b87bb7-09cc-43b4-5027-08df3bb4316d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:15:22.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JdKjd+C6TqA3HLPTfQRUt/q0xA3vMTXqOrZ67ciGiT3dSz1q8P5ZNoFVphjPwFlsy9Iz8NAZ+9FNUTjjhltDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7941

Hi,

Thank you for your patch!

> [ EXTERNAL EMAIL ]
>
> From: Christian Stefan Kövér-Draxl<ckoever@outlook.de>
>
> When the controller reports the Amlogic default address the driver
> marks it invalid, which leaves userspace to configure one before the
> adapter can be used. The controller does not keep an address across a
> power cycle, so there is nowhere else a stable one can come from.
>
> Set HCI_QUIRK_USE_BDADDR_PROPERTY as well, so that a local-bd-address
> property, typically filled in by the bootloader, is used when present.
>
> Signed-off-by: Christian Stefan Kövér-Draxl<ckoever@outlook.de>
> ---
>   drivers/bluetooth/hci_aml.c | 4 ++++
>   1 file changed, 4 insertions(+)


Reviewed-by: Yang Li <yang.li@amlogic.com>


------

Best regards,

Yang Li

