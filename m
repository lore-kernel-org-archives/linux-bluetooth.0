Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793845457;
	b=5DkBbwPGwTcDykX5vwrUW37AAJJW/QFiv2MSum4BAVGJOekP5l8dlymbRDmTbrqV2o+4
	 tsN0qaRmXZuhQxWwKzabITcpmWwRFYuoS98JlArM5apZIdzANzBIS3duACi/MqWAcdf/P
	 QKIgxVngU9B8wDuaTIXIR5xtO4fY1C4jJXLaoO8bAbw3h23wf08hR0dXJkOs1Ica9eLgL
	 5xrPzoRaddCRvBUpZOOA5MTM8A6iqitLiIpuqSgMAjjoiNIKRk7nZAh9OKIaLeZT+a6SX
	 9QNet3lf1kP1A5fjBUXYeqmpYzOfAK4svWjKmml0HecWrzd4BFpZDTwI9jkIK9AUptw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845457;
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
	bh=mQpq9sMeYpjpbrGNlS1wKH84DMxpQDqcPxZ/WAeznpA=;
	b=lXbh7QjLrAKYyYC+hFYMv0LmBnzWdDVq5iLKDENRLZlgjpDFA1yBpHDAPxot9g49Gy4T
	 ip1NOEJWrL7uUVQNWnCbWFe4DUZQOGrKFpDlpYEgaB+DhCRP4BYMn1eDHOCwWP2bb1X64
	 yrYRfpLc7SdU3dzWf406MrvjxbOOoiombyplbfyGtrX6xSOdrIRqZ1V/zy4rVVygZDfBj
	 vhjgXVB5chdd8EsuQU4GVPid1EmEGqQX1Q6AIMxKeguERLbiflOP0YYFA65/f7BUS1r60
	 WQk+KFhPWPQcROa8QZGiYKS9nW80R0NAtpZVJP6UecSF2q4oXd0EYl24CWqt1xfax0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=VadXMYgQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.108
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023108.outbound.protection.outlook.com [40.107.44.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E90606A326;
	Thu,  5 Nov 2026 02:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E90606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=VadXMYgQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMYpJPjTmQpXHm84dk0OjoB0zgMUEL6oiDiUaTM7pfDFRL4zGDgIAy/JxDUeqI370DrvUvaGmAfvy2VA105Ft1WLts19nhjNdwQfEOky7kxHH0CLr+kEr2oJYIZ8qSu0rvCdHqXczroXdiJUa8wyajibr0CCCgOBibPh6uQPEZ1pdUBOPoXHH6iqEgZyySn6F+MPnQoBVhljG0yFQhb7J0gSnOj3AAd8JgMjXK30ZoEO9F/VQm2H6AruRNKMEtlaB1BAtKXiXSsIeKOFmNaoJC5CT35EZjrGWZVUt1rTkRLvNT2IudVFxo/fIpuW3oMuH+72o9tmb4oNPxWXOuccOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQpq9sMeYpjpbrGNlS1wKH84DMxpQDqcPxZ/WAeznpA=;
 b=nbd1wZpVhbiB20CMLMq9UBmgLP64MHsa9O0+LnBjRe0XLv9s8Qj0+8sSN0epkc0OHZj6UN0Pi6UFhgjGx5Z/5eloWTS73Bf5Bkqq1KqKQmgu60P1pITRWylDBaX9AXiwIRrHuvl3QCym06/7HLusmml5z0c0HtNU2CmVB6CVLO6sjUEQiJ7ebd5h7p8t5GYUrxDzDHMyw38BDJ17+fUY+ghC0koMtCEqOvH1bQeyBVaOb/qvfbrB8kdefCRHzEA9QpyZhosXX/WjzTetNupmqxiBBz7t8GC+79itlgXllkzbd3Gc155H4hiWwQBZme4CE5FpbKcLC73MRps7UrJnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQpq9sMeYpjpbrGNlS1wKH84DMxpQDqcPxZ/WAeznpA=;
 b=VadXMYgQHj0Vww6BQtsM76HhywKKRp7RulNoB5lF9Awr3+nI5XpDWZDQzA7j9y+2UGF7s6ggrd2MQtroeYS1X+Fme1j0tK2jqBHpgzY2UqxbhYvNneo+uw+kFP2Mx7RK4l+4uYp3VoHrcNmof6EFJ5XZiSTIXz76rnaSQvivGXC2mbIYZhuJw9/oGu2Vz0FE7lXamcA5wSf5KYGGK7uwOZXIdRHODgbr8lRFkHzOOuBJSJ4oO/7VC8NXslFOAf2FgvUGqoSEHGoysBD0H0jXUNeNwTId0RpS8UXzb60xMKqYoKAU4XVvDaGHBCLCPB5FFmksR6tbFNAvoqF9e5YImA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by JH0PR03MB8665.apcprd03.prod.outlook.com (2603:1096:990:90::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 02:24:12 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:24:12 +0000
Message-ID: <2b75bc46-3e93-449a-b13a-2cc4ba8cf755@amlogic.com>
Date: Thu, 5 Nov 2026 10:24:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] Bluetooth: add a quirk for controllers that hang on
 Write Current IAC LAP
To: christian.koever-draxl@student.uibk.ac.at, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-3-christian.koever-draxl@student.uibk.ac.at>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20261025192338.209574-3-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To JH0PR03MB9035.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|JH0PR03MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e12bcc-3818-4a51-2dfd-08df3ae3e179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|6133799003|22082099003|18002099003|3023799007|261021121427099003|56012099006|261022075727099003|5023799004|11063799006|4143699003|261102123227099003|261026121527099003|261022113327099003|261009223027099003|261028144727099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	mkYqOA7ZvpC2paT7LrZ6UwqdAQu5ncVuT1mUNVYGT5Q5vblWYUVvVDqm5Zrxqy+ISJXqPKozes4DPwd2Z+KxmmMqwE0BM+GqgThZQNpBgDCsRWB5FZmXrTU3TwUUMIRupGk5A9u6MvDPzSLbfJmwipWqCgmpAJOgorDSO950PhiYgq5E14ZDOnDagf+8VZMDfiszeO+GUZfgBwR68nIgYo0fIb64rLIXIO5r7vRLfArk3EMFtOmL00t69chgnRbyHDUgZytmzYohqNGNEHI8PRPuyrB1PWkxg67ZFNplTW4D4mGhE2bkvRzoJ99Zipb+wrCLexT1ZUKqLsmBnqM/XxnJ8U+xqY7QIthD3qQI34cPNpMl/ue3JXqV9A7GoKB3PVz6MU+CeULlK3a4dwJgjAiLHbBMfU/xgN9QfRJ1F7T8Dg2AP1afDp7ltyAdf2PcexQejrgjFL2jMHVbyKA/s3SUIcTIlpoHBT42uffW6weQovUm9z/8AiD7PEnsPgPcK651/0hPzqVWYgmy9217K10L9hMWmMo1akPmxT01/HGx8g5j5c+/foraG+3lGiZ9fTEL8LP5TvH0+eFSVT/v06WWSK2F/UeYiFCktSREjwLjEaL0quHLVktQpH5TCJyiPdwl//ggEoW6hZ+2GPEjbGoND3rG+R2A1geg5TW6kys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007)(261021121427099003)(56012099006)(261022075727099003)(5023799004)(11063799006)(4143699003)(261102123227099003)(261026121527099003)(261022113327099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDV1emJGWDFIM2tQRnBkVnNNY0lCVVoxalZwcTF2MjlMTEtQMXRFRzFtK3Nz?=
 =?utf-8?B?M3NLSC90ZnByUnZVSlJITSt0RWxqL3AxVVU1eTdIbzcrR05nWjBDSUxQa3Nw?=
 =?utf-8?B?RU5rTnpYTU9GVGduUTcyTXc2d3V2VFQvK1dIVmIyY0JOWmJ6N0YyVVkzcGhV?=
 =?utf-8?B?Qy8vdXgvTDMrenFzeTVUSHMxVURHdDQwS3IyL1F0SHh3RmtGdzlGbTZJRjlV?=
 =?utf-8?B?Y0ttNEZyYThXN0hORzViMmQxSkFXMVN5cFoxT3c2U3hNZW1DdEJ4OFlQQUZ4?=
 =?utf-8?B?Mm9CMkVPQU9TUk1IbnFyVmVGQU1oa2VlQjh0QkNQOWR2WTBSQXFTc2JzVzdP?=
 =?utf-8?B?blFuUTdGTW5ZZmQ0TkZBY0ZXWFN5S1ByRC9JNmhMeDd2dnpKREJBTkN6cU90?=
 =?utf-8?B?ZlhPSEZOemo0OUh2Z3ZON1dOVHg4VGpaeU5GaktDTXc4ZzByaFI5MXZxcFhI?=
 =?utf-8?B?TzdDVmxSeWNVRFo5eWFmVkN1Z2gweDJCT295MHpCRUc0cDhvbWlNb0JlVlIr?=
 =?utf-8?B?MUphRURjb0pEaDlpTHppb3EzdUZBNFJOcEg1eUZqY08zUnNyQWRGbmp4NTBR?=
 =?utf-8?B?dlZlSDA3K1R4K3piNVVNWFdQVnVkTG41S21HZVBzWUtjVHJrWmNjOTlzeGo2?=
 =?utf-8?B?VitJWTUzWEQ1YUk4QUNTblF2a3UveEpWakYxQ2QrNi96c1h6ZHNiYjFLU3RJ?=
 =?utf-8?B?Y2I1MU9wTWh2SVFDblZiTTgyWHRDMDBGdS83TFlVQ1NJanhJWVJ6ZDBtWFhw?=
 =?utf-8?B?b3ptWjdrc2QyZGRNY2pzL3RiY0RWOEw2SVFVNmdKaGZaRVQ5QktXNXhjR1RX?=
 =?utf-8?B?VlJybDVBaG9Cc2ZRUGpURmxSS3FKM2NJWm9YOW9RMCtkQml6clRYbUszK1BE?=
 =?utf-8?B?WXNDU2ZQN2JiMXUzZ282cHAyb1QwcGFGRGRmVURjQS9KelRWUjF1SXhjT3c5?=
 =?utf-8?B?M0VMQXFRQk9xQ0hEK29jRkhFWEJ6QjEwM3pibzhVbWRNTXkxWG9kRFV4Tk10?=
 =?utf-8?B?UEFkc2xIRTZoc0ZjVzd3OGRWNkhJT0dJMzhFVjV5dmFkRXFiazlhWmZRNVMy?=
 =?utf-8?B?TWJRVkhoQnNNV0xxUWdwVGVnZkxNWm0wZVZQOTRBZXZxZnFlV1Y2ZUV2RU4y?=
 =?utf-8?B?aW50ZHZ6bzJpS0tWZS9TMGVPMExlU2NRWW5LbzdmTzRsRkZmc24wSWY5UXo4?=
 =?utf-8?B?ZnA5SlBvWm1XMUxKUG8rR0xTbkZuR1pPUmlBMnYzK3dsV2ZNWEI0a3RIbU5a?=
 =?utf-8?B?ajJSOVZSQW80SXVkWTFQeVUzVTJ6VVdQNFo1MjZxQUhXZ0QzYkZyQ1ltajVk?=
 =?utf-8?B?U3UrWVd4MzBtblNJdHhrZDVKUHdmbXZQanpWb2plTHk5SFlRU0NoWlZHMjBs?=
 =?utf-8?B?aVdnVWxlQ05DSFA2MDkvVDgrNTgreitBNTVic0ZWbHRsTkx4SGdzSEJOaWpK?=
 =?utf-8?B?KzRNTVE5a2h5YzZneXhXV2F0bXJqTVZHWExwYWlJUy9Pc085NURCbkpYOGZl?=
 =?utf-8?B?UWFFRlRlRkxOYnEyS1NjSmx4L3A2VnVxY2s3YU5TaEJ0cFdCR3FyUUZvVWdh?=
 =?utf-8?B?UTZJOE94SldlVHVLUXlxWEFqTUgrTXIvSEdRaU5KZlgvZElvTGN3NzF2dUxh?=
 =?utf-8?B?N2x1akl5eEowQU5QeG1sVlEwc2V1K2xDeWxFaTdSVmFCcUdsSUlvMmdVcXJC?=
 =?utf-8?B?R1QyeXA0OTVqUzFwOTBYeE9iNXVTK3NFV01yQWErQmp0WllnNWZYMHFvRkN3?=
 =?utf-8?B?dktIZStVR2NJU3pyTW5aSXo1eXVaUkVRNUhQUU1sMmV5QWVRcmdHWXdKeXhn?=
 =?utf-8?B?bllDZEJoK01TcFljWndYVm9RcTBCSzFzTTFFbnY4ZG5GTWJJZ2FQdEkySlc4?=
 =?utf-8?B?Z3NnVkZ4aEczbkozRmpxd1VFd0xZaXczVldLWEFRS1Vjd0pDMzdPRmo1cnd0?=
 =?utf-8?B?eDUwSmRzcmhNendFRXJORlowMXl6Z2QxYWNoT2FIblpEZDJRdEtRTzR3WEFF?=
 =?utf-8?B?WVdsazZUWHFBT291NTBYamR6d0FQbHZnVy83aFhRd2VxY0FnaE5hZFlsYmZO?=
 =?utf-8?B?dHkzRmdVdmxZMTFjczZMTUhscVJtODRkUllrd1BCY2podkxybDU2V0NWRG55?=
 =?utf-8?B?d1ZMTGloNG0wSEQrOGdSaDVscFFlWC8yVCtPMG5BNFN3U2lLNFM2ckxSU1U0?=
 =?utf-8?B?ZVpsQ0NLTFVoai9ZSTYvV3JoZlNCUjB2TjlSQWlXai9OUGJ1TEt3RGtmbzlt?=
 =?utf-8?B?dDNGMGRvNTg3MHUvblQzQVJyQUdUR2laTmZwUmY0QitSdnF1VTZJODRyVGll?=
 =?utf-8?B?ZkxSRGFESlVIcVcrUmtYaVdTUTBsQlVtTDl6dTNTVXgwU3k5dTJtQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e12bcc-3818-4a51-2dfd-08df3ae3e179
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:24:12.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rxAQAQAVPK8TtRGqiz3J0MZWtJptRn33na6DX2KfFjcP4Yw7CWjF3ergo/M9hV04mz2NcOYA6Vsi3Sp+VANkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8665

Hi,

>
> [ EXTERNAL EMAIL ]
>
> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>
> Some controllers list Write Current IAC LAP among their supported
> commands and answer Read Current IAC LAP, but stop responding to HCI
> altogether as soon as the write is issued, even when the value written
> is the general inquiry access code the controller already reports.
> Nothing short of a power cycle recovers the part.
>
> The write is only sent on the way to becoming discoverable, so such a
> controller dies exactly when something asks it to become visible, and
> the failure looks like a dead radio rather than a refused command.
>
> Add HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP and skip the write when it
> is set. This costs limited discoverable mode, which needs the LIAC
> programmed. General discoverable mode is unaffected, as the controller
> already holds the GIAC.
>
> Seen on the Amlogic W1 (W155S2); set the quirk in hci_aml.


This appears to be an anomaly with the firmware binary. Could you 
provide the FW version in use? It is logged during Bluetooth driver 
initialization.


> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> ---
>   drivers/bluetooth/hci_aml.c |  6 ++++++
>   include/net/bluetooth/hci.h | 18 ++++++++++++++++++
>   net/bluetooth/hci_sync.c    |  8 ++++++++
>   3 files changed, 32 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
> index 990e701da4be..5979b114f2e4 100644
> --- a/drivers/bluetooth/hci_aml.c
> +++ b/drivers/bluetooth/hci_aml.c
> @@ -603,6 +603,12 @@ static int aml_setup(struct hci_uart *hu)
>           */
>          hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT);
>
> +       /* Write Current IAC LAP is advertised, but the controller stops
> +        * answering HCI as soon as it is sent, until the combo chip is power
> +        * cycled. It is sent when the adapter is made discoverable.
> +        */
> +       hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP);
> +
>          err = aml_power_on(amldev);
>          if (err)
>                  return err;
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bcbe76c84d1b..a59f48f387ac 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -389,6 +389,24 @@ enum {
>           */
>          HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT,
>
> +       /* When this quirk is set, HCI_OP_WRITE_CURRENT_IAC_LAP is never sent.
> +        *
> +        * Some controllers list the command among the ones they support, and
> +        * answer Read Current IAC LAP quite happily, but wedge and stop
> +        * responding to anything at all the moment the write is issued - even
> +        * when the value being written is the general inquiry access code the
> +        * controller already reports. Going discoverable is what triggers the
> +        * write, so on such a controller the adapter dies precisely when it is
> +        * asked to become visible.
> +        *
> +        * Skipping the write costs limited discoverable mode, which needs the
> +        * LIAC programmed. General discoverable mode is unaffected: the GIAC
> +        * is what these controllers already have.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP,
> +
>          __HCI_NUM_QUIRKS,
>   };
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index f1dfef81ca96..92c442910d6a 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5258,6 +5258,8 @@ static const struct {
>                           "and will not be used."),
>          HCI_QUIRK_BROKEN(WRITE_SC_SUPPORT,
>                           "HCI BR/EDR Secure Connections is advertised, but cannot be enabled."),
> +       HCI_QUIRK_BROKEN(WRITE_CURRENT_IAC_LAP,
> +                        "HCI Write Current IAC LAP is advertised, but hangs the controller."),
>          HCI_QUIRK_BROKEN(LE_CODED,
>                           "HCI LE Coded PHY feature bit is set, "
>                           "but its usage is not supported.")
> @@ -6127,6 +6129,12 @@ static int hci_write_iac_sync(struct hci_dev *hdev)
>          if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
>                  return 0;
>
> +       /* Controllers that wedge on the write are left alone. They already
> +        * hold the GIAC, so general discoverable mode works without it.
> +        */
> +       if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP))
> +               return 0;
> +
>          memset(&cp, 0, sizeof(cp));
>
>          if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
> --
> 2.56.0
>
