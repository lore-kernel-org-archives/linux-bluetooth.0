Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022126.outbound.protection.outlook.com [40.107.75.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F086340;
	Mon, 27 Oct 2025 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535516; cv=fail; b=k901wc6cytMRK3xW7f5FmZ0zof9U/zliPUw84f8K8TnFDIn3U8msj6J+InjatSe/BWAB9JGMc7rpF7iwb/UZDQ+6Jk04/MZ7CoWk+4ddHl35TTs6O1RcloicxaSH5msf5cBkhmCaSI1vnlNuHAD6kPjHiS1yGPRTM6bDxyCSHZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535516; c=relaxed/simple;
	bh=+CiYuYD6n2IupebEZoN104dEYmqpwzIfdATyQSNS7fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jvlxhwtb56205zSMGiE7opXPDccAWjzwsX8/s2CbebQUo5oK/Ubfe7Aa8gaHvuoSKsaczmaqvbsPWgp4tkPRzhfWm30SNiQc2KV7g44U/k1Kpl4cs5LB+metATuiKT9laUb17++nKqm4yncM91R3zpRlMItaasGp8Ce+epTBMHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=FRMD7HVu; arc=fail smtp.client-ip=40.107.75.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="FRMD7HVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCnM7bnBDyki/P5Z325bfZlCbgLN3W0x3qTSpRM98wg9LSknSn9SVzZH5nw11WU/waxUvUtnlZ+/KTmHpDgJL/axdqmjdcKX5nwktssBbCHK9efEytYfK1Dur+3FiAL9elpc86FgXOgwOS/0ZA0v/4ck9iO6+yjkSZmxiKnGolCR48lDuTFyRYWf/+mwUapOHy7mfBuIJN6ou6V2RXf9hkTjW609gMaFnoyS0qSZ+1wLYMJ1cDZxuUUWVxoE+mV4Gn0rSj8JrX1uLmNeCoNiVEDGKOdg837PbU6RLgO1gmr9OFCRedRhbQS0K/jp2tUFXG1ASUI2xSLvpvGtpqjM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdEQjQ85sahal2JPaKw+XoGgBvOmWNfQudUqIUbUEQo=;
 b=ezJZuXxvmXu+FA3PEPZi8kEUD+XtKZThbigUvf+x9R2pJHFCsZkbNsstDNQN3hDpW+HDEz2F0CpiHoslM8/xJlBgnLubXrfu2K8zuFnQWSWOiP3Rr3OL9QNJnyGFUqfRq5di6TGGytw41nF3I49vf5+qeYzqVsJ38JVe6xOAm8DwX2DZOD9lvuTwalIC2mVUguM68zyf3clXeVn+YYpUQaE/2wuLhdDHeSBHLkRoQxLwl8AMMozLLEq+49gucBeltzUlMAYHz2t57WCLmS68yRAlPwxQj5I9r4JOfftLG/cBS23Xg7Vm/CUWvbzjS0yned0n0dRgNcRo4lPtHIj+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdEQjQ85sahal2JPaKw+XoGgBvOmWNfQudUqIUbUEQo=;
 b=FRMD7HVuGUjugixXUjp+b4uJjKu3B/e2T1pKL4GAjIRn6yA2Ftx+k/Bdz2bSGDBOfwuQcG0SuLBN1AQn4llGiosg0MQF0Pjt4Sg5jDh74enA9D1pAuMREYH7BsLasQTWGQSoNoXqBn/MXefEs+0Upm2wQ4XxmuUYS6H6sH2/2vYCs3xdjEqy0mNgvm9MtXPvcjjPeXF2Q+SqrFnLHay1Eu4HCx3f+X8Z+jBzDOUGLd2MaLVRHWh6tNTWUaMiaM90a3H7VWBYFJLuzq/QB4eT82WLxgmTbQAWb1anXZsd1tOgLjC28NqiaYliqC2HkQ7k8Ev95z56bHUhLr+Im0CozQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB8456.apcprd03.prod.outlook.com (2603:1096:101:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 03:25:10 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 03:25:10 +0000
Message-ID: <53f37700-29ee-4ae9-bf68-e37c317e55cd@amlogic.com>
Date: Mon, 27 Oct 2025 11:24:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
 <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
 <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com>
 <CABBYNZ+buYOXaBST-bCyzDWtWihMOoXGaoNzp6+kowKgo+-6=w@mail.gmail.com>
 <5874e307-fa81-4baf-b270-478128d30412@amlogic.com>
 <44d4423f-e557-4506-966a-7abebca7680a@amlogic.com>
 <CABBYNZLY6ExM1+55sPjXqUnFqCXHy1Ua3WA8zPx2TZOSNS-1oA@mail.gmail.com>
 <CABBYNZ+Bs2D9A_OMJ_JGH9yTiLiK_gUz07jBEEXd302Uh01KQQ@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZ+Bs2D9A_OMJ_JGH9yTiLiK_gUz07jBEEXd302Uh01KQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a652475-8d80-4b1f-0bac-08de15086f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUdlQmpGcWdWU2ZlZ1JKQTZxNjJKUDJ2UitzYXRWS0xjaDdsbDBPcEhsYlpj?=
 =?utf-8?B?dG1lWm9rWlo0TlZtRXVGM21TdWVmNGZDaW5NT0ZxTnQwakRkcW5wam1EaFBw?=
 =?utf-8?B?U3JWdFlhWGFxQzdmMW5xSWtLSVJUb1JLNGlPUFNDK2xqMHZMSDFiWXpERlNS?=
 =?utf-8?B?N01Cb3BaMVltZXhxak5EblArWGgrbmlOd2xRVC9aR25rUVJCWmROV0FUOXor?=
 =?utf-8?B?MkRDM3BjQmJCdi9OYjcxVmNVWUQxZTNWdUR2M2JZMFZKeW8rTzlTT2dZdzVl?=
 =?utf-8?B?Sm1BVnByVkZlZFZKeEpVaXFXN3pyUDR5bElWSUZ6V3YzQkJPVXFUay95SUtV?=
 =?utf-8?B?eW5wWldGdzBKSjkwcnIwVHgwM0VkRDRaa2NqQmw1UEdTcVUrbmZsMDUxRWdu?=
 =?utf-8?B?VzVFQmJWRm9GdkJBY0haSkF2bld5N0FmVXVwN0ZQbmhWS1N5VkYyMitqeFFt?=
 =?utf-8?B?bjhQUlBiUTYrTDJvaWlIaXhTSm1Ba0Y1d2tjVndpbXc3bVpneElBQTc4Zk9U?=
 =?utf-8?B?T3JzYVpPYUhNd05jbnNac3dYS1BGUng0ZkFPSklJaXpiYW9CUXVrQ24xTk4y?=
 =?utf-8?B?L0xjVSs5aHlQYTV6Y1pzWUkzdXZ3OWJwR0lzMVJNSmtWTEZYQjBjZVJmemRV?=
 =?utf-8?B?ZlI4Z0dZNEpWRENqeTMrY0xZejY4cEJnNWlQYjRuZTgyUXVOeHpodHhpMEVl?=
 =?utf-8?B?MnE5WmNZTkNxa3A2anlMZmlOSlFKbUpWSEdOTFZmRlQ5bVlCWFdNUDRpWHMr?=
 =?utf-8?B?RUw5OG1oREY0TUVFMUgrL09DMEdSbXZIMWozM3lJeE5EcWYvdlJrOUloclFu?=
 =?utf-8?B?RXM3aWh4ZmJsVU9ZbUkvNkRmbythUlJYWHlOZlI4Qit1WWZqZmdlRGEvNU9D?=
 =?utf-8?B?eVBoZkc5Y2puemV6aWVlaVVQUmNUUXR3ZENZdDRnVTZ6ZTVTOXd4dnVxZCsv?=
 =?utf-8?B?MENvdWkyaE5mNXNtc3hRa0NIQmQ0eGtudEV4elVhdzJpT2pYbDNqT0laak52?=
 =?utf-8?B?ZWJjY2tDNXdaeXJuL1FHU2hKRCtaeW51RGp6M0NJQkxXN3B3czBQenhpN3R2?=
 =?utf-8?B?S0xVYkVHbHlMUDlhZ0UwUWtlL1lFYTIvQ3dqV1ByOUNkcTZ5eC9RL0Vldzlj?=
 =?utf-8?B?cGF4Rjl1QXE3M0hYY0lCVlFCN0svUTNtZlk5OFJqbUM2K2wrMXlMVUV6KzNr?=
 =?utf-8?B?cS93dGNuL0xqRWQxWFVTRmFxMGFZL2VvQjZBVDlxY011ZmxCR292VXZuVG9U?=
 =?utf-8?B?K1gwaVYzNFNWQk5VdlBKVE9Ea21WMEUyU1pFNndTanRvRUJNbTRNeG1HVlpx?=
 =?utf-8?B?SzNCYUQ4N2M3MGJJTjZsSExLbksxTVhtNmlUWnc0TmVFNnpzeUNRM2RkbHR3?=
 =?utf-8?B?UVhzNmRMY3p6QXBCRTZhRWh3RGZ5VjZEQy9CeVFQZjNVODQ0ZllTU0VBWndZ?=
 =?utf-8?B?NEtvSVZ6VkM4NVErWTRQczZndHBNMTYwUytycUtwSGNkTkFpa0hhdHAxNUQ2?=
 =?utf-8?B?RlQ4UW5hanorU3dLODV4Q3hFbkRZeG1WQU14ZDRiektQaW90NTBteGwxTFVC?=
 =?utf-8?B?Y1M2Wlg3ZU5HcFZwdHRoOVMrdkpIdWRHSnNMMFM3Z1A1bUcwZUlrM0tFU05D?=
 =?utf-8?B?NW82clMyLzJMcDA4NU9BL2tlVjRkVEFtb3M0Uzl6cFVWM1ZTY0FNSEFiNGw4?=
 =?utf-8?B?VUZCOGZ4ZUc0YkxYWjlxS3ZLTituYzM5SWhrU2hxem1HTytXSWFndnZPQ2dQ?=
 =?utf-8?B?RG5iMzVGV09jZTVOd3VzeDF0aEQxdzFiTUpDdVN3dmRtZkhRMXUySkRDZ1hp?=
 =?utf-8?B?OVRRdDFLRnNLWG5aTW12cVZDdGk2WnlweFZmVWxCelBqckw2ejZZQ3F2ZUtr?=
 =?utf-8?B?KzJuNUlmRFh4KytFZS94R0FUUjY1Mm94NkpuUWJ1TmppOUdzL2NnVmx5ekF0?=
 =?utf-8?B?SWFweFRldHI2YmMwdVNwbkRtNGZnMk9za3A3MS8wSGJhMU1rNmVoWDQ4aWho?=
 =?utf-8?B?NkkxUTg0YlNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFl6bzhLQXV3QUpzMDdQb3NhOUZ2UHNVWm94c1VnZ052WTBQM1FQcTd4V0dC?=
 =?utf-8?B?dTZuOWU4Y3dFWFZtdERKWXZoMlJ5eGRaS0I5N0Yxa0piZDROL0JxRE5sbDV2?=
 =?utf-8?B?Qmx5MXJvMXVvRHRpSkxTM25KQnZMMlppdUpPUnNSTUtGQUZYa3hYcFpldHR6?=
 =?utf-8?B?UndGRExGa0prMml1eCs4YUVNQmtBRHVScEtVZ1lQUERGbWh4c2NqY25uYlE0?=
 =?utf-8?B?bkZKSVE4TW5kK0JZRDR2RUwzRTBKbVhKdU0xZ1FaWit0VnFIeEdmSFhobExz?=
 =?utf-8?B?djMrUmtib0F1cmkxQzJKaVRGTWk4NUxJUU5zWWo1RzdMVjdNRlpLNVJCWDdT?=
 =?utf-8?B?eXltSGtzZkJUYyt6L2J0bk1UVmRQczZwTXp4Nk1jbE9EdXVYbDFzeUpBcXlH?=
 =?utf-8?B?K1RhNnZKaHRaQnpTVzBTZTJkS3FTajEzdXkyT041S1NaYU93YUxFNkVpbFY5?=
 =?utf-8?B?by9ldlB0dmZJN01OWDRmWXRQTHpaMG9mNUd1Q2NFNThZNjhsb1J2T3N3YXhC?=
 =?utf-8?B?Y3ZoVGZVdGlRNTFxWHBXWmJVME83T0gzeWZ3YW50UTNoL1dYMEZpMHpuV0Jn?=
 =?utf-8?B?RFRGS255Qlg5Y3dKZm1BUnZVbERNaW11Z25IZmRMWUx0RjhlY1E5Zjcvc2VK?=
 =?utf-8?B?OUM4VzNTc1pXZGZQTE5UTUptUjZjVjFsODR1VTZnTUNWaEg3dVpyR3ZsZ2w1?=
 =?utf-8?B?MmRubDNZd2ptK2ZmaG9IdWFHdzg3cnVTbVczc2lCTFQvTmxpZE1OOFpmcnFH?=
 =?utf-8?B?KzF1cUdkWGtXaGpld1k5Sm1HNXcvY0p5eHBCUE1OUS96ZjBKekVpZ2c2Mjdv?=
 =?utf-8?B?T0xhZVdtNDR1emI1SnlrbjNITXltSVptZWlHLzFuZlIxU3p5bVhHN21SZ2JH?=
 =?utf-8?B?OEhGcUR2dkR3ZUZyMHRhTnFVR0hoYVZvRHRvaFNVTjd1bFVPOGw1MmF5Q1lQ?=
 =?utf-8?B?RkhFbFpHVUs4Zm9pU1BldjFSMWZJWGJlT3lqWjRXbHU0V3lKYnVTTkc1bDhW?=
 =?utf-8?B?VXYwREhFQ2VkZkpFUzZLQkp5U3ZsZHpSQmZRWjFvWStxdXdFVklldEN0Ukhs?=
 =?utf-8?B?ZFdFL2tJTlZ4TG1ocmRQd3VBM25Nb3YrOHJpdUtPc1JBWUMxblp2dHNxQU9E?=
 =?utf-8?B?MzRMSmpiNzNoRy96SlVtU3BzOUU3bzVJYy9uY2ZIMzUvTHNuTFlJTkNNclh0?=
 =?utf-8?B?SnVhUmFWdWpCUWVpc0pFRnJ2aVVIMm1sYmlCM2E2MFBFRnBFb2V3R0FMSTVr?=
 =?utf-8?B?bVhJSmY1T0xnOFJEeXpFTExJeW95RFYrdmlIRC9XWG5oZXdtajNqeCtua2pR?=
 =?utf-8?B?K05OdmIxbzZlQytGYmVWNTFQNm8yK2xvMUxwRG93K2ZiVmZTY3dRNXBRdEhZ?=
 =?utf-8?B?ZnBxdFMrQkVjTkFGM0xWOGRuM1hFSUdFRzNwSE9hdGJqcG9hdGE0QllhYTYz?=
 =?utf-8?B?Szl6Yi9TYkl5SDd1cjBEWW12VnZObTZJUTQzN1c2b0w5azV6UGMralYwQzVR?=
 =?utf-8?B?Q2xlNmdNamdwVWRvdTV5eEZ2Zms0RHBlZ1hXR0Yzb0tSTERaaDZ1eE5ubVlz?=
 =?utf-8?B?T0NQR2F6bW5VWStBL0JrZGx5L1pVZWVhYkFkK0tyV3ptWEhoY3dnc2tNUGhz?=
 =?utf-8?B?Y0ZDZFM5SjN2bDRCZ3ZzWE1IcVVZaHlyZi9PUWo2VlFDckdRZzdyQVFLN3JU?=
 =?utf-8?B?RnoyUGlMU01pY0duNXlwY200bE8rUlhkeWZXT2QrZWc4Nm53MmUrYTVKZ2Fa?=
 =?utf-8?B?K3g3bnFOVmNoYi9JRmRXaE85Mmd2QkRjb3I2Z3prQVpZczkzYzQ0dkpKR0NW?=
 =?utf-8?B?OWxLRCtLazZhUEVDKzUwek80ejZXVHcrM25kdkdnL2FQc0dyNlVNNlBuVWhP?=
 =?utf-8?B?NFZJTUJPMkMzRVNMbE1Fa3o2TnNKTFA2L0Q5UEZZY0taZFVKaFg3UDVGOWs1?=
 =?utf-8?B?cGVobERmdGxhTUpwQ3dPZmJYb29GaWtWc0U4TERHcm40SVRFSVF2ZGVucEpK?=
 =?utf-8?B?MzhTZnRoN3dCRHdRUituRHQwTTVVUDlxMTJlT0twUDRjeTMrNzlQcGlNUUJM?=
 =?utf-8?B?d0oxbWxNaWNrMzkxb3R3Mi9Fb3BnMnJMdDZ1RHdkWnF5SUhFTEtLL1VmZTYr?=
 =?utf-8?Q?v6om28Y5wzgWi++6rGc87s39v?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a652475-8d80-4b1f-0bac-08de15086f1b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 03:25:10.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY+Zj4QpbF5hMcZu0lbD/fv6QoI+xDJDBFtr3jhNZHjcuv8dPlRwnfD3yRE4Y/fFeB376ApC1eYlhT0dL38pHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8456

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Fri, Oct 24, 2025 at 9:45 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Yang,
>>
>> On Thu, Oct 23, 2025 at 11:47 PM Yang Li <yang.li@amlogic.com> wrote:
>>> Hi Luiz,
>>> A gentle ping, thanks.
>>>
>>>> Hi Luiz,
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Hi Yang,
>>>>>
>>>>> On Sun, Aug 3, 2025 at 9:07 PM Yang Li <yang.li@amlogic.com> wrote:
>>>>>> Hi Luiz,
>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>
>>>>>>> Hi Yang,
>>>>>>>
>>>>>>> On Thu, Jul 31, 2025 at 4:00 AM Yang Li via B4 Relay
>>>>>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>>>>>> From: Yang Li <yang.li@amlogic.com>
>>>>>>>>
>>>>>>>> When both BIS and CIS links exist, their sockets are in
>>>>>>>> the BT_LISTEN state.
>>>>>>> We probably need to introduce tests to iso-test that setup both then
>>>>>>> to avoid reintroducing the problem.
>>>>>> Since the coexistence of BIS sink and CIS sink is determined by
>>>>>> application-level logic, it may be difficult to reproduce this scenario
>>>>>> using iso-test.
>>>>> Looks like you haven't look at what iso-tester tools tests do, that is
>>>>> not tight to bluetoothd, it directly operates at the socket layer so
>>>>> we can create any scenario we want.
>>>>
>>>> Based on the current structure of iso-tester, it is not possible to
>>>> implement test cases where CIS and BIS listen simultaneously. There
>>>> are several issues:
>>>>
>>>> 1.
>>>>
>>>>     In struct iso_client_data, although both CIS and BIS related
>>>>     elements are defined, they are mutually exclusive. CIS and BIS
>>>>     cannot be used at the same time. For example, .bcast must explicitly
>>>>     specify whether it is broadcast or unicast.
>>>>
>>>> 2.
>>>>
>>>>     The setup_listen_many function also identifies BIS or CIS through
>>>>     .bcast.
>>>>
>>>> Therefore, if we want to add test cases for the coexistence of BIS and
>>>> CIS, the current data structure needs to be modified to completely
>>>> separate the elements for BIS and CIS.
>>>>
>>>>
>>> I'm not sure if my understanding is fully correct, so I would appreciate
>>> any guidance or suggestions.
>>>
>>> Based on my testing, this patch does fix the issue on my side.
>>> Please let me know if there is anything I may have missed or if further
>>> changes are needed.
>> I hope you are paying attention to the mailing list since I did add a
>> lot of new code that introduces support for PAST, including new test
>> cases for iso-tester, so I don't think asking for a test case for
>> having both BIS/CIS together is too much really. Works for me doesn't
>> really cut it since we do want to make sure we don't reintroduce the
>> problem later, but Im fine merging this now if it doesn't introduce
>> any problem existing tests in iso-tester.
> You will need to resend it since it is no longer available in patchwork.


I completely understand the necessity of adding a test case for the 
coexistence of BIS and CIS. However, the current issue is that the data 
structure of iso-tester doesn't support listening to both BIS and CIS at 
the same time. I will keep an eye on the updates of iso-tester and add 
the test case at the appropriate time.

I will update this patch.

Thanks

>
>>>>>> Do you have any suggestions on how to simulate or test this case more
>>>>>> effectively?
>>>>>>
>>>>>>>> dump sock:
>>>>>>>>      sk 000000001977ef51 state 6
>>>>>>>>      src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>>>>>>>      sk 0000000031d28700 state 7
>>>>>>>>      src 10:a5:62:31:05:cf dst00:00:00:00:00:00
>>>>>>>>      sk 00000000613af00e state 4   # listen sock of bis
>>>>>>>>      src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>>>>>>>      sk 000000001710468c state 9
>>>>>>>>      src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>>>>>>>      sk 000000005d97dfde state 4   #listen sock of cis
>>>>>>>>      src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>>>>>>>
>>>>>>>> To locate the CIS socket correctly, check both the BT_LISTEN
>>>>>>>> state and whether dst addr is BDADDR_ANY.
>>>>>>>>
>>>>>>>> Link: https://github.com/bluez/bluez/issues/1224
>>>>>>>>
>>>>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>>>>>> ---
>>>>>>>>     net/bluetooth/iso.c | 9 +++++++--
>>>>>>>>     1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>>>>>>>> index eaffd25570e3..9a4dea03af8c 100644
>>>>>>>> --- a/net/bluetooth/iso.c
>>>>>>>> +++ b/net/bluetooth/iso.c
>>>>>>>> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct
>>>>>>>> sock *sk, void *data)
>>>>>>>>            return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +static bool iso_match_dst(struct sock *sk, void *data)
>>>>>>>> +{
>>>>>>>> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static void iso_conn_ready(struct iso_conn *conn)
>>>>>>>>     {
>>>>>>>>            struct sock *parent = NULL;
>>>>>>>> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn
>>>>>>>> *conn)
>>>>>>>>
>>>>>>>>                    if (!parent)
>>>>>>>>                            parent = iso_get_sock(&hcon->src,
>>>>>>>> BDADDR_ANY,
>>>>>>>> -                                             BT_LISTEN, NULL, NULL);
>>>>>>>> +                                             BT_LISTEN,
>>>>>>>> iso_match_dst, BDADDR_ANY);
>>>>>>>>
>>>>>>>>                    if (!parent)
>>>>>>>>                            return;
>>>>>>>> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev,
>>>>>>>> bdaddr_t *bdaddr, __u8 *flags)
>>>>>>>>                    }
>>>>>>>>            } else {
>>>>>>>>                    sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>>>>>>>> -                                 BT_LISTEN, NULL, NULL);
>>>>>>>> +                                 BT_LISTEN, iso_match_dst,
>>>>>>>> BDADDR_ANY);
>>>>>>> Perhaps we should add helper function that wrap the iso_get_sock (e.g.
>>>>>>> iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is the
>>>>>>> expected socket type, also if the hcon has been set perhaps that
>>>>>>> should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
>>>>>>> introduce a socket type to differentiate since the use of the address
>>>>>>> can make the logic a little confusing when the socket types are mixed
>>>>>>> together.
>>>>>>>
>>>>>>> Now looking at the source code perhaps we can have a separate list for
>>>>>>> cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
>>>>>>> and bis_sk_list), that way we don't need a type and there is no risk
>>>>>>> of confusing the sockets since they would never be in the same list.
>>>>>> Alright, I will give it a try.
>>>>>>
>>>>>>>>            }
>>>>>>>>
>>>>>>>>     done:
>>>>>>>>
>>>>>>>> ---
>>>>>>>> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
>>>>>>>> change-id: 20250731-bis_cis_coexist-717a442d5c42
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> --
>>>>>>>> Yang Li <yang.li@amlogic.com>
>>>>>>>>
>>>>>>>>
>>>>>>> --
>>>>>>> Luiz Augusto von Dentz
>>>>>
>>>>> --
>>>>> Luiz Augusto von Dentz
>>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz
