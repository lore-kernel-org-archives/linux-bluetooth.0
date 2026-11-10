Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301891;
	b=NoLB4fchT0DmKaBWBDViYgxLfPdDuWbhsGRwHkN/P5jcIxjABLzPOgUX9S+Tfc3ICSwo
	 FrhlgB4WCVaqD/CXfpXX6I1kroosWQkVqrK9eg33pqSdT+ez+yjBiItERDJUeMwUNObfH
	 ck/wyIkwD+PIDLx1DLHgIDjg4tasZEtCHw1GSJ0bi9qOLFQbHBnyJMt4GveELHiHkEd+N
	 IEqY6u2YYW89GxvId2qMfgmyS7XqKlX6IRYdfzVW9xo/0Zu8cgSQJROtgzi4ShHUnwiAf
	 putb6HWlImXm76wZTfQhw2ZXCiZdZmQqZ8XiFnbKFCWNs7heJQf932g8hbFr1pmD2WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301891;
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
	bh=v5U1gi40WeHRPBpcKW4H0c1gJevV5vTmPZFFo78uhPk=;
	b=Z6zIvTBTUPX7Xgm/ux2HJVHo+tO1RECA4V/E9wYT8xbv8M31qUQWxyxL63qu2Lv4BBjm
	 B989IJqrQNvlnWbBJRWGIEcq/d4dFnriIjFnONOTUva0GEAoeLwVBC1iK7KquR5Od4ZPC
	 p1GXGMK1LULzl6cG4p5Y9P9DlQJEJktdbEknQCkEXjSH13kyeE6Bp84/M2EjhY5TFfjFQ
	 udHR6oNe8+St4Yy26zxUq6/YetzCXlpvvhBarbzrDb/BBql/VC/ZuWEO9FXPhdCyyF1cH
	 FJyF+1rz+AjwdJL5aPruEQr22frjN3d+ehT29St1PcuQQxe9NYO86PVulUb6KNd5h6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=qeaWhvhU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.121
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023121.outbound.protection.outlook.com [40.107.44.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F0606A31C;
	Tue, 10 Nov 2026 09:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=qeaWhvhU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0LtjeDdqArWdOC7nQK7GZESm9cTdAv8iJ8o1iNKYrI9nXYLIWuJNy5mRAIbgMk6khqPzcuYsSkH1R70u/k9+e3DIWoynftKV6ZlOalwUh6UcPA6ZYpE7yzy3qYqPKyhrZ6RVxHQ+krxYZKLjrHiuTeVLSG6dtN4yH8p7tJK4N6hQUKstP7VC+4FVB+5OF21DSDLDjZkeoPq2eRB59JYLoJSDj3d08LkVk05zJzDW3H4qLn7F8n3b6ObGbL8gDW1DcZanYS/fA2oiIZJ+V+XRDmYVTBXEFSa++2ELAQ5SO/HlA0wztB1bfPwycq0O34D4hh4OHKsrYB0ZXgEa/z69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5U1gi40WeHRPBpcKW4H0c1gJevV5vTmPZFFo78uhPk=;
 b=MFkkVdcphmOsN914P/Angd2QVD9nPAMDZl05RSNZoLXBeM4az4bBkOw9VHN45RnxkwgnHG1NkM6DDo8wLPatuCwgkoHUhTD6uiivyA29Ooq7CmzkD5hL3G+lBOxmBmd0ghEZvPH9dWN7MnfZJrKAofiNInexC9I8fBAr0QJ1DNqbhWNlBLeAOb1IELlrbjYB6CiysGCiHc7hG3GdglJCVskZtPF5R5DyjYRTHoSkEDIu3NliN4Teen9NQu91Jkv2bHlfTaLB/PtfY32MONCdvQb1qtY7Zdv9QOKNx2a1HLKtKHKAcSXgKkG3zxGlqAfgWf9pZ5i4atHTC/o8TLqWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5U1gi40WeHRPBpcKW4H0c1gJevV5vTmPZFFo78uhPk=;
 b=qeaWhvhUnWxM+v4huZ3oIUETJ+2Nk9wHoDOM0CzBh2LdJxcSWdANEcMney37dDfq6x6MjHhBIVSDPi1qZJrdqU8gPCjNHfGFTJ9xiTNJNvjr8UJ91IIcv1Z9wnXLxGv3zAVNmtryhivRMuQLwXW4h8Fkgb8CO0N7nwOgvfFY+utu3+Sk54rO7ll9vlhy5jqguE1ZviDEE4Ng/musWzOunfuTr1uboyiMEYtQzwv0THUxoz+klaDZ6M8b/oBwPsmtA9T+wcmiS7nWr9zdXXWkQWKe7ccZrrvWDi7Zh8R/0+L5rWgwn72v4eYQiWwStQEq6tG6j14pKFvj0l0rwr1OvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by JH0PR03MB8049.apcprd03.prod.outlook.com (2603:1096:990:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 09:11:27 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 09:11:27 +0000
Message-ID: <f05a1d68-4a07-4b79-aaf7-69fa85038248@amlogic.com>
Date: Tue, 10 Nov 2026 17:11:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Bluetooth: add a quirk for controllers that cannot
 enable Secure Connections
To: =?UTF-8?Q?Christain_Stefan_K=C3=B6ver-Draxl?= <ckoever@outlook.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
 <5d5a22a5-b45e-4cf8-9066-e0e641d719bb@amlogic.com>
 <MMZPR08MB549315933A342E32853DED71E1DF762@MMZPR08MB549315.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <MMZPR08MB549315933A342E32853DED71E1DF762@MMZPR08MB549315.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0205.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::12) To JH0PR03MB9035.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|JH0PR03MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c974d99-259a-4fc0-34e3-08df3f0a99cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|11063799006|4143699003|56012099006|261021121427099003|261026121527099003|261022115727099003|261022075727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EUSWWMItSiBdIB8ARQOpVs7Lot4nfg1Gd5zpkLevlgpS4CELqg03obH3K3F9yLaoK1D2FJxjD9tWiPn9gSCEBQV0bnIHNqo7dTMaWp1fFy6MPP7C+3s8bDJ1G8JpSlLK/ByA09NRLxyVCMfVbZRO8TH1ZKQ0G0gHV+nuQOuqr3g+FNzwXb1kR0xMidPjJrtAn0JvulkSqPSgjK8hO0tFA2gjasFv6yE6FJw0mTAxQVBSOYxPyvom0yBBfx2Myb4+lG2szizZyhq/IK9AI1iiGGGdJbDZDAfr349ME8Mi998VP0PxmWkLOfPmxqAupCf9dY2VfcB07OqJKjcLNhHezrLyrBk7NLL9DObobuhhR5mfjWZav3dSIBuWoXtJyrFyVsIjV0Iwk0wDJkcIOtWNt7/jztcmStKvTUcwgUZGFgikkVVrNQq01ImNRH1Rpo9O2rY0IZMFBT25WeUirzpOw154oOMpJ6NObtPqClwELvuVimu0aYO4IMTZ+ZBO6V67c7bdmpXdmag2auwqYmecDgwVrLAZ/VNGdCERNLQ7EvT1OYm5KlrXIxEku1iJ0qKGFfXs0s0B0eMpJMumwQ0kHzifiuYvcfIlRp3wE/L/aro3C6ewHP6lZsG/rfYjl237
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261022115727099003)(261022075727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm04L2o4TVpWWndTM1d0SzNwRk5wWUkxWVRNNjkrT3lFR2pjRmg4TDc4RUFU?=
 =?utf-8?B?RnVhUnhoRnRaK3ZXRWpNQ3pUczh2Q05GYm1WWFRkYVFNUSsvaTNxTEZnWEJ2?=
 =?utf-8?B?Und3NTJPbmFXR051Z29JaG5aTFdaNzlvVU5tbWFxdXM4SkkrK2FMVk16UXN4?=
 =?utf-8?B?NWdhWS9lUi9BSHFWcUJpSGNtYXBnOGkxbkhJRXVKVVBDU1FRengrckVMS2tT?=
 =?utf-8?B?cTNiSlQvZU9iNGozdjZKQzF6NjFER3cyRGtjR254TXZUekdRMmk2VXVuYkRi?=
 =?utf-8?B?OHRjSWxWWE9jYXhVeUpwdXZVckZhZ2s4eDRtZGtyQkR4cDhIcjBPanhNTlZE?=
 =?utf-8?B?TUxKYmFqNmJJMzExZGFKYnhPcnFuNjdqenpxc1pmMTRab2gzT3hqMzBwU0dl?=
 =?utf-8?B?Y2xUeWtzRzdOQ0Y4elJiVFp6cXJld29aWmlkSXpJNG1kMkx6VG1qRVdNc1g5?=
 =?utf-8?B?Q0wyRU84SEQrRzQ3Y2FJNlU2eG93TDJoVklYdlZSWHR4MldHM2ZGMlRBMkU0?=
 =?utf-8?B?Si9YQ1JYY0kzblRnVHh3KzZJVTlLYWZqUFZqQmY2TGkwemQyeG9ZYkxia1ov?=
 =?utf-8?B?NDRwWGN6TTlOZFY2NTJKcFNEVE9sOGVYSWxjZldxS1dWdGhnOGJXM2h0amZF?=
 =?utf-8?B?Sk9iQllKcXI1aVZKaHdmcTlwbllNOGZtRVJvdTVvcXg0MFgrWG5sMlFvMW5P?=
 =?utf-8?B?UEh0MHdxVGgvY0RWN24ra2NtR3pXVlMyQytyYkdudWx3R0x0NHJGak02UHFp?=
 =?utf-8?B?Y1pweWxvd3dyVWxWUGxCZ2w4R09SaU1pSkFvZW9PcERBTU83eTg3bjRCeXdI?=
 =?utf-8?B?R0dKbHNFd0JLbzVtMW1HMnlHelY5ck5GeEhCUEVIbmQvS2FqeVFRVlBuRmFj?=
 =?utf-8?B?RURQVmM3MHZ6djMwa2wwUjVpVFRYZW1sRUU5UkNqZEJMZkRncmZwcnpDN0VV?=
 =?utf-8?B?dldubGdnQngvelRFTmhFODdDeWdOY2YzSHF1VG0vMzZ4d2t6eUUyRHdVS0Nz?=
 =?utf-8?B?Rituc3VTWmszbFkrMkw0MERUWG9yRjhTRFl6VEQrTjFKaHpnOUpHMnd6TnEx?=
 =?utf-8?B?WDhxa3I4MzNtWS9jS0VqOGJtc0NrYzZaNkRuQWxhamJsaldNMk80MEM3Q1JT?=
 =?utf-8?B?SnA1bHFieW0vVC93LzBPTno5NlNMQ08vSGhKcm8zaGZFODFtbm1MN3Z1azVh?=
 =?utf-8?B?UmlhK2lGc1llTVJyVjd0STgxQlp5eFYwaXUvZGsrZHM0L2VBejAwQUxDT1BS?=
 =?utf-8?B?TzZ2aU8rSlZEblRCK3RFelRIOXpXakdPdGxwdkx3VFcxblQxdlBaZmU2TElN?=
 =?utf-8?B?bW5lNnI4MmVxMGFUZlBVckRZSDczSS9pbi9Pb2dvTWcvamxUYlpTZnN4em9t?=
 =?utf-8?B?WHhtaW5uN3hnVldDODIrTERHNDRDejhtSGUxMjMxRzFkOUYyWElGY3JBbnFD?=
 =?utf-8?B?U01na0dSazNUMG9BdDc3Q1crbUNKLzBucVZzb0UxYU92aWFHbXRBYlZQSWw4?=
 =?utf-8?B?cEY3di9CQ1VsMm9NNWtCRzVTSmZGY1YraUVURXJSUXBVdFEyWlFQWXN2S3F6?=
 =?utf-8?B?VE4xNlpoVjdzYW1Wc0JTU0ZTYldUMTJkb0gzdkxjRklweWkyYmN5d1pvSTBW?=
 =?utf-8?B?dXg3NmNPa2t3dmJKZ0ViRm1UUGVJZE05akJZaVkxOW1rMm1nd0hkOTRxS0tF?=
 =?utf-8?B?RHNUeEIvK2FqN0VabzBrQWJ2RWErWHQxZDMwcm9BY3E2STNHaDZ5SXBoS1VI?=
 =?utf-8?B?U3d4UW1icU1zQ1V2Rlo3YkUyT1RsZ1NhbWgxWlNNaFEyYmx4UDNETW1JVXNY?=
 =?utf-8?B?MmdXTHJwZjVJRnAyc0FqM2VmNVFkNlNjZ2JReDhzS1p3aGgzTWxTemtkdGJz?=
 =?utf-8?B?dExwQTB0c1FRdnhHbUVsd2dLVGgrWXpTYk54WStvdWtyRzV0aFpQSktMSHha?=
 =?utf-8?B?dG5ZZHIvNUdLRW9VdWVpRXo5c2xDSmhIVWVlRjIvY2pNbWNHaEhtYkxtTFU4?=
 =?utf-8?B?Qld5OXU5SjJUelgwdGFMejcwbWpTS2xZeWdXVm5zajU2dWJQSWFlUGFHSmxs?=
 =?utf-8?B?clIzT0xNMmhjYkxBOHFhZk1ISURqaWx6L2paWW5XM3RJaGpKNzhDL2NGV0wx?=
 =?utf-8?B?N3hMRHNCTDM0WWJsZG1DLzdsM1hhNmIwMHNFQTFucm51NjZuTVdjdG5heXJU?=
 =?utf-8?B?TmZ6NFZRTmY2aHJFcVE3dlpvbjFtKy9tRm56ck9BUWp1UytWUTRCZ2RYeDYw?=
 =?utf-8?B?ZEZEeVpSNUdPcE9LUm1PR2pselM5VTBrVFMxVkpUcnQ2NVZEZ0dkc2lDem5J?=
 =?utf-8?B?TlcyYlJTWVZIdWs2MmY2dGV2NTI1cTltSFBwbGplV0hRSzc1T0JGZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c974d99-259a-4fc0-34e3-08df3f0a99cb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:11:27.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCACM6A1j5oHdgstYDnq18n0hIYBahTYOfgIqlF3GFzQvQE17HNYd9iWew2oa/2RI1rGh9gbS8tBa5b67Q1UMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8049

Hi,

I updated the w155s2 firmware bin in linux-firmware.

See the link below.

https://lore.kernel.org/all/20261110-upgrade_w155s2_bin-v1-1-4533ba6005cd@amlogic.com/


>
> On 11/5/26 10:19, Yang Li wrote:
>> This appears to be an anomaly with the firmware binary. Could you
>> provide the FW version in use? It is logged during Bluetooth driver
>> initialization.
>
> Hi Yang,
>
> the controller reports
>
>   fw_version: date = 09.08, number = 0x15d2
>
> The firmware is not the linux-firmware one: aml_w155s2_bt_uart.bin from
> linux-firmware downloads without errors on this board and then never
> starts (no HCI event after the download). The one that works is the
> firmware embedded in the vendor Android libbt-vendor_aml.so of this box
> (X98Q, S905W2), 0x60000 bytes. I load it as aml_w1_bt_uart.bin.
>
> If there is a newer firmware without this behaviour, I would be glad to
> test it, and if it fixes it I would rather drop the quirk than add it.
> Is the linux-firmware image meant for this chip revision, or should it
> start as well?
>
> Kind regards,
> Christian K.-D.
