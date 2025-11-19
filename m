Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022107.outbound.protection.outlook.com [52.101.126.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA2E9EBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522849; cv=fail; b=lAOYv5I91xWEAZz04n6EWuQeonCaRBOGgfF5vwUIoNZU1VS4nzRtOniC8Qtfl54Wy/NtiaLdeP/0/ymBD3MF2s7crvICArV+XTEQEZcMgGhcIOigrlNLx39CEWLSaL9+QAUiuMfcUE9mVy8LVBMT+4iRpY+pKYrrGuSVF92ieJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522849; c=relaxed/simple;
	bh=52eR+TRf9h1Afw/VjlVh1yWbmO8fD0Tne4UC+AMi/8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RXyjV0o+UpefW3nSND0twFr7RzAShGT+FzHsRnrGLtZ/1000vcixZ+NALNVMjGz8vfJ8NrFD/krTwVat0P3mkcsNZtRUqjyOSL7VR71ed//Eel+4qdOaJuhNWKUxPW2y/+lNIP2qYXEKvmg8y9eKitxPDGMvT+PsyetvwGMtclM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Rt0WSczH; arc=fail smtp.client-ip=52.101.126.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Rt0WSczH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niaHEax/mv+ZD0E3vDsQSDC1X/e6QouTSy5NuuPnnrpAdCotFiiP14nav37bWWpHl5+fwj3mPsQK0QHslYgy28J0qkkPCG/vMyjS9PxK0I6ca3+P44OVX4tc9p3eUU6XCIQbyJmL9q97tcozl7MBuTSJDFcii4JEvn+uHBQTyU4MLA92HRtUSrGPUbgiTBbaQjsrtlyNywvYFl4+iBNHqIGqGmsIg9QVuivMRiUzt7KxBz/yWiGy5hfTVKfkWY3ROUHYiLI9gnUavCGDsHD2I7Q3NtL/a6kdDQwucdNcqtnYnP0zaicTPEXEWWjqICM2TVcihI/PMJxSoOSMsc03aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3asi8TzVxpdbhKksabK5PzWkzuRFj6oAOZmFm9iP934=;
 b=E3c4C+i0hlk+rTeTA9vLhbUt4nwI4fbPNzzAQ54F3VcYkJgWqHwXZ73fCyVxf1UVzhdRTAoSSjI8J50jGyGEZoDWl05u4JqGzw1oenr3deXMNvRL+cwdWztLLzA6CoBchs3agiw4IS0AnL1wD+gzWJiZDZqhrcwYh36A6YJKSGxXh29XjGjc6U+GSR3MENuxT5bItpit2acH03shRpvV58Qj9WuZkjMpLCy4I036VmHLqry9J8UW3jjG7OBeZLH9WfT/6Oi8+PYcseXHEae8/bhQ5f4zzg5D0ALgl//k0bIZj4qqaj5h0kiSAx9sM+alccHC0YaNeCk+IHa8nm2l2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3asi8TzVxpdbhKksabK5PzWkzuRFj6oAOZmFm9iP934=;
 b=Rt0WSczH0oK8Mm2uR4hy8geQc4YAKykvnepSa48h9DuoPwBktt/WJ8Z3Tr/QdokmW+UYHyL3wzugcTC5GTcS2lbQDKB/TpS4Nl0IEIduzKMdeQSVInoRuOX6y/kynxttdEWLC795pZo80BBZ0K3//MzydLUbH1MFAIkY9FvvrfLjxp1SFvUQR5jVAMgRTXJbYiNczIgtM6bwogrOlvBC+zsvbJaf0pEfLKI/R3EylD2DqlM5m+WsIFxHt2Id200t9eKf3G0J0Hc5Bm+gJIaVtTF32apYAOxlnF9Dur+p52yLhwmVdUsA4/ZX68eF6Q9wSSZcKY5H+6DSZtVVwZ3g6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by TYZPR03MB8252.apcprd03.prod.outlook.com (2603:1096:405:1d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 03:27:23 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:27:23 +0000
Message-ID: <80198c62-366a-4c1a-8487-783a983f66b5@amlogic.com>
Date: Wed, 19 Nov 2025 11:26:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v3] bearer: Implement Connect/Disconnect methods
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com>
 <CABBYNZKZ-Y2PqH620t0Tyr9sygoKikeyjdKTVOjV+7LDNxPRgQ@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZKZ-Y2PqH620t0Tyr9sygoKikeyjdKTVOjV+7LDNxPRgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|TYZPR03MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 80425ff9-325c-4982-fa0f-08de271b8dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjJrR0JvenczZCtJNUtyZEpXVmhMdVNId1FrZlRDUzBTTTlNZnNXL013Ynh3?=
 =?utf-8?B?elRWeTl4ZTJ6ZG5jNCtuNDZGSFR3ZjJVaThjWjJHTzl4Y05SZVgyT3N4YVlO?=
 =?utf-8?B?WkdDZWtFNzRyYkUyZlY2TnVrdHJZZVh1M1FOeS9wTXE2UTdoeFM3OU81bThy?=
 =?utf-8?B?ZWxnMElSQ3kzUUFPS1B3a0NKWnBXVlVoV0dla3FwK3RiOTBINDBiNk5BN2lT?=
 =?utf-8?B?aWdjdGZqOWdTdS9EYjJJSzJqdU4ydkUwVFY1cExIYWFIb0tWTDY5cTZPaXk3?=
 =?utf-8?B?eHZaWjBUS0VmVEtnVGMzM2ZDS3Z3SlFzVTFVUWNzTkdxeVJNekFZUHZDaDRG?=
 =?utf-8?B?bHowaGxjM1JtSHRnaTdDcC8wNmcrbGFHU2I1aCs2UXpyby9vMUUyb0ErZklO?=
 =?utf-8?B?b0FOMTUva0ZyUndpTEkyVGozYzV6WU0wR2lZMzBaV2lUdVV0MCtLekZOazFK?=
 =?utf-8?B?NitlVlRSYWFaOFVpaVM2WDNXU1hEUitPamJJWlhHbkpKbHhvNjVUV3dKR0Rw?=
 =?utf-8?B?ODhsdFFOYjh2WXcyMmY3YW1vaExzTEhBRkt3NllSSExVOHNMMnJPZVRJT2l4?=
 =?utf-8?B?NWRZV0xFYWRhQXkzRUlRQ0pBbDlFVHdHNGljTDdwWG0xaXJKZm10OVhHUUdC?=
 =?utf-8?B?QTYyNVdqNFRTNTEwdEVtQ24xRGpoblFmM1ZoZCsycWVxQ2poWEdIUUozUlZN?=
 =?utf-8?B?dU41US9mQlJIWFdwYngrNzN0b1hkSjBLcHE0d2p1aHJaNndZeitqaEYrN0Ro?=
 =?utf-8?B?NlJxUHIvVmZMbEQ0SjlXV1NTRmRieWdvdXhHSmVnL2VrQlBBZlUyMlFMdENJ?=
 =?utf-8?B?R29yNHRqc0hIc1JFL0xTMTN0SHo2R3F2U1pYc1BPMy9NZENseGlHTkQ1dzEv?=
 =?utf-8?B?S2gxNTdONzhkVGpqOU9EMGpFd1VUWFNVN0k5aERnaVB4MWxWbTcvZEZKQTJs?=
 =?utf-8?B?OTVXVHFISjZJUVBIaE9NdUNITWR2NWVWa0dXbTVhV3FPWWlocWF4SVYvUWpp?=
 =?utf-8?B?THBkSjFML3p5L05CdXBuTlNabnBkTkVqVWQweVdVZ3lxWkVwT0kxWWpFbjkv?=
 =?utf-8?B?WUwrN3FrcytTa2FkMDU4TytZUnhIVFZzZkh3UmRQa2M2T3JqalByWGNWQndV?=
 =?utf-8?B?aXQ4WVFWbEUvQ0RueWxFUzAvdUtqNUtESVNIeHBNVE43V0V1SXF1L1VRTDk5?=
 =?utf-8?B?ZlRnbzN3L3hlVzdhc29GbkVQWDlTWEdHbjNXc3o5NkprVzV4UGZ0V3dUZWwz?=
 =?utf-8?B?N25OYUtjTlNBVTh5bTc3M2ZheE40Kzc0dTN1blVwYWtFVVhYczVDU0tNTlFx?=
 =?utf-8?B?S29yN2VrS2kyRlhod2dJSGZvMDQrSUlDQnFZU25jOGVyNXBqNHNKQU5FdjNx?=
 =?utf-8?B?dktkNEt4OUVaOWVGMW12YkxaZ2h2REoyOStubmVvMUhwVGtrOTNmVjk1OXVa?=
 =?utf-8?B?bGI0NGsrOW5QNGJyYnlMVGxnZG9adE53T1RsMVdYbU1rUUJZVEFvRDVTdVRN?=
 =?utf-8?B?Q3I0QW45d3hTRTQyYWxMOG91ZEg1ZG5xdWg4dWZlOENZSURpbjJUYko2S0Zy?=
 =?utf-8?B?Vk9GYjVoZ2ovSWxqNEJjUFFZNFg1UEhFQ1B1ek8vNFFRWGpLMHFISTlYWTRJ?=
 =?utf-8?B?bVhNZUtvYndLeDdqUWpFMnE3RGVyeDkxTDhXTG56aXEvRFJOMVNDRXd0Skds?=
 =?utf-8?B?dG52Nndqb2NhMU5GT01FNWJiUTBxZEsxNkpuVXVJcWNZSkdLWUtqZE5OTmww?=
 =?utf-8?B?VDdPUlpncHVvckc0NnlNdUdEM3JaeVI5NVNKcUVMQnlSSHNTUWluWWpoTVFV?=
 =?utf-8?B?RDhRbDZ1SzU0YXF5STg2Mlg4dHBSaGJ4bnhzNlJieXdmdW0wRk8zREdlMTE2?=
 =?utf-8?B?UDRkdkV5S2x4aTZOeGpsZ0JQUEFFMXJwRFF2dkI1ZTFuR2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1p6dSsvRlR5NGYzSTJlaTUxZm1HeHNjTlNRNzQvMWRNVzE1NTJCRkFNTFlU?=
 =?utf-8?B?Vml5Rks0b0NBWGZGdEJwY1NURjVRNDVOcTRJTExqNEh4aHNlZ2VxWm5HQzRH?=
 =?utf-8?B?aHdkdXR1RGNGZHNBUHF4UmFyc0Y5MTFDalRSYVJpb1hYMUJiNmlKVUd5bzdZ?=
 =?utf-8?B?MmpZaW92eVJxaUlvRHRRKzMrUk5zUGJWcGVSaVAxc3VuZDRKR2VFQ2xHTExD?=
 =?utf-8?B?WEx5SFhIdEpFakh2aHl1WnNVelhWT2FVaGJIR3h3UTgwQndYMW94alZZQVZB?=
 =?utf-8?B?M1R5b21NUnpBT2UwRVg3SjJaNTVsYmFiclpkSE1lVFpaRHVGcEh5TWJNOGxG?=
 =?utf-8?B?aGVIZWNkcC9BWUZUWFVobmVpZHgwa3dOdUZNWTUxN2pkM3FSZndBcWlSNmxy?=
 =?utf-8?B?aCt6RWRYWnkwSzhYTXlIYzJpbjdhcm4xS08za3NpYVJpZ2kwVmpKQ1VxNWRS?=
 =?utf-8?B?QW8wc2dQZW54MldYWHNsUkhWS2xib0JBOHNjMDJrRjBFa2JhN0FRNFVGc29u?=
 =?utf-8?B?WC9Ec25Ba2xrVU54WHBsYlNYVzVqaC9Ea1U1NjF0K1E0N0NuaVQxOFAvMnFi?=
 =?utf-8?B?U2hPM0oyYkV6cnNVNDNDVzdiMmdCOHIyRDd0am5mVlRiSWxpNzNGcHQrY1dG?=
 =?utf-8?B?K1pLMTZFMHNmbjgrbnM0d1dWRGRycXlLY3ZuRHZuZ21INU4yd0hnbW1RL0xt?=
 =?utf-8?B?dFprL05tTnVKWjJZTitsbzhuekx3b21MTk5rQUx3ZXVEbTI1VlhPakF5cTNI?=
 =?utf-8?B?d2ltMGZNSXJCTXJ3VXp6YzE3VkcxY2lQbjA2M0NTQURoWmoxOGRXZHVNZHFF?=
 =?utf-8?B?OTZ2NWJxVzFmT3lJZGtjWmE4OGpqclA0VlVrdElndnBqeVJwRXdJTDFOb2tP?=
 =?utf-8?B?QktnZjE1bVh0cDcva1Fkb2VYRWJPM0JiQVphYm55RUN1UUNSTC8yVFhCUFVp?=
 =?utf-8?B?bzhzT05IajlSV0dYOTJrYlNENUQ3RU1Hc3ZXdWFsMytkZmtUYmVHMFRBU0cy?=
 =?utf-8?B?dCszT3Rza1lBRG12RHVBY1JseHY3cktvZXBPOGZYUU5UamFVM3B0TGdNYzFD?=
 =?utf-8?B?bEhvUnRyQ2FUWTZlbFIxQXFaUjRsbnZvR3Y4Z1JKazMvNlVwNDJGZE92UXl0?=
 =?utf-8?B?ZHMraVM0THJPOERIRTZ6TFFOV3A5UHZ5VEcrakJQSWtvVTVJVk9zRGthTU5U?=
 =?utf-8?B?M1ArK1lMZ0lJT3lTeUI1bXJraTNkUnV2bXJzTnd4MnkvTmN6ek0wUUhleldG?=
 =?utf-8?B?RVdoeFBZQ29oeUptMGdkY015ZXZSOU5Sd2VHUFNvVEU0VTY0Q3ExOHZnUno2?=
 =?utf-8?B?d0Y4bjJrVnFJOGZlYWRDK0tQRVVDSkhPZkd5dS9tbWZVakVyaEFKT3B0cFli?=
 =?utf-8?B?MldpaGdGMktIZnFPS1JtZktPVEw1aXVUbEZ5WDA5YWFsZ3VaZHZmOXQyM01G?=
 =?utf-8?B?NVRRak95YTNEbDRTcWhNcW9vVklydms3V0lHWFBsWDNWSXZ0THVwNGZuaE5h?=
 =?utf-8?B?NVUvUmtJTHVtR2hCUEhGWktrNUhucWk3MVUrTXJDdkR2cGdCdFY5bWFFdjkx?=
 =?utf-8?B?MmZrT0Zla2w0SDIzWmhpajZjTkhRdERac1hPME5VUjNCZ1oyTDJ2UjlXWGg0?=
 =?utf-8?B?akR1WmF6V1JWNDh0c29DajJlaGVFNG5QUThWVG93Zm40WFNvclI5TVBKOUdz?=
 =?utf-8?B?S2F5UU55QlV1cHdqcStkTkxFOG5lTE53alh0RHV5VVllNWJiRER3NTlTMEJw?=
 =?utf-8?B?QVdqdlhMSFRJTUxIRTZkSVJMeDBrYnNqSThnMC9jZ2dOMnZrN1NuSHRZZ3ZH?=
 =?utf-8?B?SXU3RXlKOTNKanRBQTdTYzFkV1hyM2pjcy9lSXlPOG9tYUNIelRlMzNJdURp?=
 =?utf-8?B?c3p4YlVFNTNjSC9HOXcyc3FnWi9IRk1EWlhyNzZRVElRVEtaK2tQTlRyNXBJ?=
 =?utf-8?B?UDlHZmU3Q21NK0IxZEpWUzJIelI3S3dZRjMvZmpNc2R4am0wajZaOEJWQ1hB?=
 =?utf-8?B?WWJ3QVRhMFI2REN3S1Nhdm13WUx1a3hESHNkdVdoQUFBbyt2N05XRDl5Mnk5?=
 =?utf-8?B?WERFRmlsdEcwM0ovd1JSZ0FIRkdqQ2R4SDMvU2xMZUZyam91YnJUL0lKS21u?=
 =?utf-8?Q?7JQUcgWrN6pPrhNcEwP+qLF2y?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80425ff9-325c-4982-fa0f-08de271b8dc3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:27:23.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/trmDdphoXs24PVyT4NkQX5qQaRYzkxLlIbbB0d/Y6fZND1cx3npNKjukNRfcGFBmV5SpJIfE1zd2F4GOcUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8252

Hi Luiz,

> Hi,
>
> On Tue, Nov 18, 2025 at 4:32 AM Ye He via B4 Relay
> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>> From: Ye He <ye.he@amlogic.com>
>>
>> This patch provides implementations for the Connect and Disconnect
>> methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
>> interfaces.
> Ok, we will need some coverage in bluetoothctl in order to exercise this API.
OK, I will add the shell commands of bearer into bluetoothctl.
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> ---
>> Changes in v3:
>> - Move the modification logic from the device to bearer, and add
>> - some helper functions to the device.
>> - Link to v2: https://patch.msgid.link/20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com
>>
>> Changes in v2:
>> - Fix build error & warning.
>> - Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f41585144218@amlogic.com
>> ---
>>   src/bearer.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   src/device.c | 130 ++++++++++++++++++++++++++++++++++++++++--------
>>   src/device.h |  17 +++++++
>>   3 files changed, 285 insertions(+), 22 deletions(-)
>>
>> diff --git a/src/bearer.c b/src/bearer.c
>> index 9723b59e2e7b39b2974e258363aa0ace95862651..46e272b16096740ce28bcc80d0e2426df8538a2e 100644
>> --- a/src/bearer.c
>> +++ b/src/bearer.c
>> @@ -25,23 +25,38 @@
>>
>>   #include "bluetooth/bluetooth.h"
>>   #include "bluetooth/mgmt.h"
>> +#include "bluetooth/uuid.h"
>>
>>   #include "gdbus/gdbus.h"
>>   #include "src/shared/util.h"
>> +#include "src/shared/queue.h"
>> +#include "src/shared/timeout.h"
>>
>>   #include "log.h"
>>   #include "error.h"
>>   #include "adapter.h"
>>   #include "device.h"
>> +#include "profile.h"
>> +#include "service.h"
>>   #include "dbus-common.h"
>>   #include "bearer.h"
>>
>> +#define DISCONNECT_TIMER       2
>> +
>>   struct btd_bearer {
>>          struct btd_device *device;
>>          uint8_t type;
>>          const char *path;
>> +       unsigned int disconn_timer;
>> +       struct queue *disconnects; /* disconnects message */
>> +       DBusMessage *connect; /* connect message */
> This doesn't sound quite right, why don't we queue connect messages?
Just like Connect() in org.bluez.Device1, the connect operation is defined
to allow only a single in-flight request. Queuing additional Connect
calls would change the existing API semantics and could lead to
unexpected state transitions—for example, duplicated browse attempts
or redundant link-level connection requests.

Disconnect() is different: queuing only affects how replies are
delivered, not the device’s actual behavior.
>>   };
>>
>> +static void bearer_free_dbus_message(void *data)
>> +{
>> +    dbus_message_unref((DBusMessage *)data);
>> +}
>> +
>>   static void bearer_free(void *data)
>>   {
>>          struct btd_bearer *bearer = data;
>> @@ -49,17 +64,126 @@ static void bearer_free(void *data)
>>          free(bearer);
>>   }
>>
>> +static void bearer_disconnect_service(struct btd_service *service, void *user_data)
>> +{
>> +       uint8_t bdaddr_type = *(uint8_t *)user_data;
>> +       struct btd_profile *profile;
>> +       bt_uuid_t uuid;
>> +
>> +       profile = btd_service_get_profile(service);
>> +       if (!profile || !profile->remote_uuid)
>> +               return;
>> +
>> +       if (bt_string_to_uuid(&uuid, profile->remote_uuid) != 0)
>> +               return;
>> +
>> +       if (bdaddr_type == BDADDR_BREDR) {
>> +               if (uuid.value.u16 < 0x1100 || uuid.value.u16 > 0x11FF)
>> +                       return;
>> +       } else {
>> +               if (uuid.value.u16 < 0x1800 || uuid.value.u16 > 0x18FF)
>> +                       return;
>> +       }
> What are these ranges above?
The UUID ranges are the SIG-assigned blocks for BREDR profiles
(0x1100–0x11FF) and LE GATT services (0x1800–0x18FF).
I originally used them to guess which bearer a service belongs to, but
this seems unreliable — some profiles exist on both BREDR and LE.
I’m open to better guidance on how to classify services/profiles
per bearer.
>> +
>> +       DBG("Disconnecting profile %s (UUID 0x%04x) for bearer addr type %u",
>> +       profile->name ?: "(unknown)", uuid.value.u16, bdaddr_type);
>> +
>> +       btd_service_disconnect(service);
>> +}
>> +
>> +static bool bearer_disconnect_link(gpointer user_data)
>> +{
>> +       struct btd_bearer *bearer = user_data;
>> +       struct btd_device *device = bearer->device;
>> +
>> +       bearer->disconn_timer = 0;
>> +
>> +       if (btd_device_bdaddr_type_connected(device, bearer->type))
>> +               btd_adapter_disconnect_device(device_get_adapter(device),
>> +                                               device_get_address(device),
>> +                                               bearer->type);
>> +       return FALSE;
>> +}
>> +
>>   static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
>>                                                          void *user_data)
>>   {
>> -       /* TODO */
>> +       struct btd_bearer *bearer = user_data;
>> +       struct btd_device *device = bearer->device;
>> +       int err;
>> +
>> +       if (btd_device_bdaddr_type_connected(device, bearer->type)) {
>> +               if (msg)
>> +                       return btd_error_already_connected(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (device_is_bonding(device, NULL)) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (device_is_connecting(device) ||
>> +               bearer->connect) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (msg)
>> +               bearer->connect = dbus_message_ref(msg);
>> +
>> +       if (bearer->type == BDADDR_BREDR)
>> +               return device_connect_profiles(device, BDADDR_BREDR,
>> +                                                               msg, NULL);
>> +       else {
>> +               btd_device_set_temporary(device, false);
>> +               err = device_connect_le(device);
>> +               if (err < 0)
>> +                       return btd_error_failed(msg, strerror(-err));
>> +       }
>> +
>>          return NULL;
>>   }
>>
>>   static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
>>                                                          void *user_data)
>>   {
>> -       /* TODO */
>> +       struct btd_bearer *bearer = user_data;
>> +       struct btd_device *device = bearer->device;
>> +
>> +       if (!btd_device_bdaddr_type_connected(device, bearer->type)) {
>> +               if (msg)
>> +                       return btd_error_not_connected(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (device_is_disconnecting(device)) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (msg)
>> +               queue_push_tail(bearer->disconnects, dbus_message_ref(msg));
> This also makes no sense, if you are going to queue the disconnect
> message why are you sending in progress error if it is already
> disconnecting?
device_is_disconnecting(device) indicates that the 
org.bluez.Device1.Disconnect()
operation is in progress. This call has the higher priority because
it tears down both LE and BR/EDR bearers. Any bearer-level disconnect
requests should therefore be dropped once this state is active.
>> +       device_cancel_bonding(device, MGMT_STATUS_DISCONNECTED);
>> +
>> +       device_cancel_browse(device, bearer->type);
>> +
>> +       btd_device_foreach_service(device, bearer_disconnect_service,
>> +                                                       &bearer->type);
>> +
>> +       device_remove_pending_services(device, bearer->type);
>> +
>> +       if (bearer->disconn_timer)
>> +               return NULL;
>> +
>> +       bearer->disconn_timer = timeout_add_seconds(DISCONNECT_TIMER,
>> +                                                       bearer_disconnect_link,
>> +                                                       bearer, NULL);
>> +
>>          return NULL;
>>   }
>>
>> @@ -151,6 +275,7 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
>>          bearer->device = device;
>>          bearer->type = type;
>>          bearer->path = device_get_path(device);
>> +       bearer->disconnects = queue_new();
>>
>>          if (!g_dbus_register_interface(btd_get_dbus_connection(),
>>                                          bearer->path, bearer_interface(type),
>> @@ -174,6 +299,16 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
>>                  return;
>>          }
>>
>> +       if (bearer->disconnects) {
>> +               queue_destroy(bearer->disconnects, bearer_free_dbus_message);
>> +               bearer->disconnects = NULL;
>> +       }
>> +
>> +       if (bearer->connect) {
>> +               dbus_message_unref(bearer->connect);
>> +               bearer->connect = NULL;
>> +       }
>> +
>>          g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type));
>>   }
>> @@ -203,6 +338,13 @@ void btd_bearer_connected(struct btd_bearer *bearer)
>>          if (!bearer || !bearer->path)
>>                  return;
>>
>> +       if (bearer->connect) {
>> +               g_dbus_send_reply(btd_get_dbus_connection(), bearer->connect,
>> +                                               DBUS_TYPE_INVALID);
>> +               dbus_message_unref(bearer->connect);
>> +               bearer->connect = NULL;
>> +       }
>> +
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type),
>>                                          "Connected");
>> @@ -212,10 +354,24 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
>>   {
>>          const char *name;
>>          const char *message;
>> +       DBusMessage *msg;
>> +       const struct queue_entry *entry;
>>
>>          if (!bearer || !bearer->path)
>>                  return;
>>
>> +       if (!btd_device_is_connected(bearer->device))
>> +               device_disconnect_watches_callback(bearer->device);
>> +
>> +       while (!queue_isempty(bearer->disconnects)) {
>> +               entry = queue_get_entries(bearer->disconnects);
>> +               msg = entry->data;
>> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
>> +                                               DBUS_TYPE_INVALID);
>> +               queue_remove(bearer->disconnects, msg);
>> +               dbus_message_unref(msg);
>> +       }
>> +
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type),
>>                                          "Connected");
>> diff --git a/src/device.c b/src/device.c
>> index 91b6cc0c65eaae8058cd445c0942ffee57289f0d..918f1e51acd3a9cd6b776cc080c198885511fb20 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -2022,6 +2022,28 @@ static void dev_disconn_service(gpointer a, gpointer b)
>>          btd_service_disconnect(a);
>>   }
>>
>> +void device_disconnect_watches_callback(struct btd_device *device)
>> +{
>> +       if (!device || !device->watches)
>> +               return;
>> +
>> +       while (device->watches) {
>> +               struct btd_disconnect_data *data = device->watches->data;
>> +
>> +               if (data->watch)
>> +                       /* temporary is set if device is going to be removed */
>> +                       data->watch(device, device->temporary,
>> +                                                       data->user_data);
>> +
>> +               /* Check if the watch has been removed by callback function */
>> +               if (!g_slist_find(device->watches, data))
>> +                       continue;
>> +
>> +               device->watches = g_slist_remove(device->watches, data);
>> +               g_free(data);
>> +       }
>> +}
>> +
>>   void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>   {
>>          if (device->bonding)
>> @@ -2063,21 +2085,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>          g_slist_free(device->pending);
>>          device->pending = NULL;
>>
>> -       while (device->watches) {
>> -               struct btd_disconnect_data *data = device->watches->data;
>> -
>> -               if (data->watch)
>> -                       /* temporary is set if device is going to be removed */
>> -                       data->watch(device, device->temporary,
>> -                                                       data->user_data);
>> -
>> -               /* Check if the watch has been removed by callback function */
>> -               if (!g_slist_find(device->watches, data))
>> -                       continue;
>> -
>> -               device->watches = g_slist_remove(device->watches, data);
>> -               g_free(data);
>> -       }
>> +       device_disconnect_watches_callback(device);
>>
>>          if (!btd_device_is_connected(device)) {
>>                  if (msg)
>> @@ -2095,6 +2103,11 @@ bool device_is_disconnecting(struct btd_device *device)
>>          return device->disconn_timer > 0;
>>   }
>>
>> +bool device_is_connecting(struct btd_device *device)
>> +{
>> +       return device->connect != NULL;
>> +}
>> +
>>   static void add_set(void *data, void *user_data)
>>   {
>>          struct sirk_info *sirk = data;
>> @@ -2712,8 +2725,8 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
>>          return connect_next(dev);
>>   }
>>
>> -static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type,
>> -                                       DBusMessage *msg, const char *uuid)
>> +DBusMessage *device_connect_profiles(struct btd_device *dev,
>> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid)
>>   {
>>          struct bearer_state *state = get_state(dev, bdaddr_type);
>>          int err;
>> @@ -2826,7 +2839,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
>>                  return NULL;
>>          }
>>
>> -       return connect_profiles(dev, bdaddr_type, msg, NULL);
>> +       return device_connect_profiles(dev, bdaddr_type, msg, NULL);
>>   }
>>
>>   static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
>> @@ -2848,7 +2861,7 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
>>                  return btd_error_invalid_args_str(msg,
>>                                          ERR_BREDR_CONN_INVALID_ARGUMENTS);
>>
>> -       reply = connect_profiles(dev, BDADDR_BREDR, msg, uuid);
>> +       reply = device_connect_profiles(dev, BDADDR_BREDR, msg, uuid);
>>          free(uuid);
>>
>>          return reply;
>> @@ -3421,7 +3434,7 @@ static DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status)
>>          }
>>   }
>>
>> -static void device_cancel_bonding(struct btd_device *device, uint8_t status)
>> +void device_cancel_bonding(struct btd_device *device, uint8_t status)
>>   {
>>          struct bonding_req *bonding = device->bonding;
>>          DBusMessage *reply;
>> @@ -6629,6 +6642,38 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
>>          return err;
>>   }
>>
>> +static gboolean device_is_browsing(struct btd_device *device, uint8_t bdaddr_type)
>> +{
>> +       if (!device->browse)
>> +               return FALSE;
>> +
>> +       if (bdaddr_type == BDADDR_BREDR && device->browse->type == BROWSE_SDP)
>> +               return TRUE;
>> +
>> +       if (bdaddr_type != BDADDR_BREDR && device->browse->type == BROWSE_GATT)
>> +               return TRUE;
>> +
>> +       return FALSE;
>> +}
>> +
>> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type)
>> +{
>> +       struct btd_adapter *adapter = device->adapter;
>> +
>> +       DBG("");
>> +
>> +       if (!device_is_browsing(device, bdaddr_type))
>> +               return;
>> +
>> +       if (bdaddr_type == BDADDR_BREDR)
>> +               bt_cancel_discovery(btd_adapter_get_address(adapter),
>> +                                                       &device->bdaddr);
>> +       else
>> +               attio_cleanup(device);
>> +
>> +       browse_request_free(device->browse);
>> +}
>> +
>>   int device_discover_services(struct btd_device *device)
>>   {
>>          int err;
>> @@ -8088,3 +8133,48 @@ void btd_device_foreach_service_data(struct btd_device *dev, bt_ad_func_t func,
>>   {
>>          bt_ad_foreach_service_data(dev->ad, func, data);
>>   }
>> +
>> +
>> +void btd_device_foreach_service(struct btd_device *dev,
>> +                               btd_device_service_func_t func,
>> +                               void *user_data)
>> +{
>> +       GSList *l;
>> +
>> +       for (l = dev->services; l; l = l->next)
>> +               func(l->data, user_data);
>> +}
>> +
>> +void device_remove_pending_services(struct btd_device *dev,
>> +                                       uint8_t bdaddr_type)
>> +{
>> +       GSList *l = dev->pending;
>> +       GSList *next;
>> +       struct btd_service *service;
>> +       struct btd_profile *profile;
>> +       bt_uuid_t uuid;
>> +       bool match = false;
>> +
>> +       while (l) {
>> +               next = l->next;
>> +               service = l->data;
>> +
>> +               profile = btd_service_get_profile(service);
>> +               if (profile && profile->remote_uuid &&
>> +                       bt_string_to_uuid(&uuid, profile->remote_uuid) == 0) {
>> +
>> +                       if (bdaddr_type == BDADDR_BREDR)
>> +                               match = uuid.value.u16 >= 0x1100 ||
>> +                                       uuid.value.u16 <= 0x11FF;
>> +                       else
>> +                               match = uuid.value.u16 >= 0x1800 ||
>> +                                       uuid.value.u16 <= 0x18FF;
>> +
>> +                       if (match)
>> +                               dev->pending = g_slist_remove(dev->pending,
>> +                                                               service);
>> +               }
>> +
>> +               l = next;
>> +       }
>> +}
>> \ No newline at end of file
>> diff --git a/src/device.h b/src/device.h
>> index 6ed8affa0d4a9274d30cac9b48e8a6826edefd64..fee1ad50dc9c7ae248acd819dae07762c783ac35 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -120,6 +120,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>>   gboolean device_is_bonding(struct btd_device *device, const char *sender);
>>   void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
>>   void device_bonding_failed(struct btd_device *device, uint8_t status);
>> +void device_cancel_bonding(struct btd_device *device, uint8_t status);
>>   struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device);
>>   int device_bonding_attempt_retry(struct btd_device *device);
>>   long device_bonding_last_duration(struct btd_device *device);
>> @@ -134,6 +135,9 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
>>                                                          const char *pincode);
>>   void device_cancel_authentication(struct btd_device *device, gboolean aborted);
>>   gboolean device_is_authenticating(struct btd_device *device);
>> +
>> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type);
>> +
>>   void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
>>                                                          uint32_t flags);
>>   void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>> @@ -141,6 +145,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>>                                                          uint8_t reason);
>>   void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
>>   bool device_is_disconnecting(struct btd_device *device);
>> +bool device_is_connecting(struct btd_device *device);
>>   void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>>                                  bool central, uint8_t enc_size);
>>   bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
>> @@ -170,6 +175,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
>>                                  disconnect_watch watch, void *user_data,
>>                                  GDestroyNotify destroy);
>>   void device_remove_disconnect_watch(struct btd_device *device, guint id);
>> +void device_disconnect_watches_callback(struct btd_device *device);
>>   int device_get_appearance(struct btd_device *device, uint16_t *value);
>>   void device_set_appearance(struct btd_device *device, uint16_t value);
>>
>> @@ -184,6 +190,9 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
>>
>>   int device_connect_le(struct btd_device *dev);
>>
>> +DBusMessage *device_connect_profiles(struct btd_device *dev,
>> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid);
>> +
>>   typedef void (*device_svc_cb_t) (struct btd_device *dev, int err,
>>                                                          void *user_data);
>>
>> @@ -225,3 +234,11 @@ void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
>>   void btd_device_foreach_service_data(struct btd_device *dev,
>>                                          bt_device_ad_func_t func,
>>                                          void *data);
>> +
>> +typedef void (*btd_device_service_func_t)(struct btd_service *service,
>> +                                       void *user_data);
>> +void btd_device_foreach_service(struct btd_device *dev,
>> +                               btd_device_service_func_t func,
>> +                               void *user_data);
>> +void device_remove_pending_services(struct btd_device *dev,
>> +                                       uint8_t bdaddr_type);
>> \ No newline at end of file
>>
>> ---
>> base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
>> change-id: 20251111-bearer-impl-5f7e396174aa
>>
>> Best regards,
>> --
>> Ye He <ye.he@amlogic.com>
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
