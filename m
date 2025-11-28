Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023110.outbound.protection.outlook.com [40.107.44.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22835972
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295250; cv=fail; b=JkzSkbQVLwREcrU0MYEjuKnczVQHoEgJ+FsvrzxA3/3rwSBS6uwpoUXA+fpGrc5onD9pMIwc0gq24TxiP57yvLM+aD/kPNPJeWeQ744U2k0vy/Vc472DgkGqyt7suzRrDrc7WvJdVuhwg9YlmqtAhSgvSV349w3CJEd8+P3NPYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295250; c=relaxed/simple;
	bh=C+X99OoKS6aNxhDZ6PikRvlVqAMsANZtTgGrknfVJ98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iyP80JHI+2yKRA3By/CsIQwI4XogDjkp/kEaSjpiCADgKDgMODI47mak78wff1INpf88lceUbRwejl3vnJcsyCu8zvnSYtaZXL0YbMkMB0MfxEnXVwKo20olyFtbE2BaX1f6KPeUnaMo2AjaKme/BETINk/ANzbNiBzdJGPi4mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=CjE0eKrh; arc=fail smtp.client-ip=40.107.44.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="CjE0eKrh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVipnvZv/6imf23E5l4LDMNU/yqgerbc8LS+ru/whUa0PsEbdYo7hXfq597EVqATg0/YG3ALQB6wZsEff7tJ3mYEBRAa9wh4oA6RhHAYYnaBUSMQLgcqz4lRE+kFjFQh1QkLZCJq2BEK7RJ2rskMzUAQs0oorwZexyk1HZeNeR9T9ZlZ+ifnE96ptpVzUGLMVCfax4ofqKZ6TzZ8z5k3y5G46AQUazM5flGQNIAeao8xSsSwSOc3p5tn+kmf3e+r+wZNEPAhU2nxSRSP13y/vxMNaDrpBW+x4otFHq/7HFB+K+VZr3SZrRvajk50c/cWCwdUcApsknDmK39M8RXtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkjegvCMdOI1sjj3vQ0sbJVCJPsmH0x40S4ZfWOPgvo=;
 b=Wzp5cfKL6vTIym9kZGH3C82xLZZ+aDwAuADisgqmUN7JfNNtrS18MiEvQJjE7Hsy7nZdaINKE5zE9B/PKYTkhsqvMnszNDKWz808Ga2ZU+R6TZEaHdbsy1g0xtpgG5nXrF8lnvp7rWH8aN3m4OvoQNEHPCRRYw0EbKxtpanmWNe+0Dou8tvsHz8YVqccHTfbpjIWO2M++ZywxN6KeRcYJ7dOEZqo8H7agUkcaRFN5K/Q8bn0Ye/wXTABXlQtzwg1cVZj2Ghjz5uoc44JWcXCJPBgCCgub7THB09ivuy9kubpcDgSVHkv5uzdHFQZF3wwvglLe7kGMj8EzqN7e6ywCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkjegvCMdOI1sjj3vQ0sbJVCJPsmH0x40S4ZfWOPgvo=;
 b=CjE0eKrhRfsGMEtu3G1iqPEH4bltpFK4LOTLAM0aHuihS8aKVbx6FAK8pfocrJ/MQ6koXDqiVQV9+WOK5uWPlcGQMfKzJAh7YopQmNG6a8AGXdpa5zzJNxNd4VRDJYnzukqyGDk/tW5sDgogGy70JAQXn5/5ryC315mOsre02sr7WAyJknQLTj4NPyKcfU7ZZlfHUhjPzY+eCOYxhuquxSf4VmXqqIGj7kfSGDa1KxL48Y6b4FJsozzGrjdGuafyX61xJYuUw53kj3Odo7fTOMH6yWuKRbWTo9eGUJ5Ut1EEWtT2X00FMcHI5G41rqIjoHX5r+eZnWa8+b3EduRC2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by TYSPR03MB7332.apcprd03.prod.outlook.com (2603:1096:400:431::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 02:00:44 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:00:44 +0000
Message-ID: <32364175-bfd2-4df2-ace3-e59b0f4ab12a@amlogic.com>
Date: Fri, 28 Nov 2025 10:00:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v7 3/3] client: Add shell cmd for bearer
 connect/disconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20251127-bearer-impl-v7-0-9a5b06468992@amlogic.com>
 <20251127-bearer-impl-v7-3-9a5b06468992@amlogic.com>
 <CABBYNZJQTfL250wDbW+ZbadU1b_Uufv3+VAD4W6=DfAZ5T+LRg@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZJQTfL250wDbW+ZbadU1b_Uufv3+VAD4W6=DfAZ5T+LRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|TYSPR03MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f80294-da86-4fe9-ddf0-08de2e21f0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkQxTkt1YS9vbVVtNVlGWmtReHhwTDkxS3JTYzlpUCtXaU9IdFY3c2hGY1V1?=
 =?utf-8?B?ZG50ZW5XQnZ5VFhuOUN6MXovblRPRGt1THo1YTQrMzdPNnlNaWtTcjJlZ3JC?=
 =?utf-8?B?bEg2L1JJUFdzaldKTnYxTGY1MWZFM2tFQVBlbk5VdzRlMkVhcTVwb1BKbTFD?=
 =?utf-8?B?WTVlVTl5SXREbkNSM0I4dFA1VzBLcnFsZWJvUDlDYlZIdU83K28vZWtpRDBp?=
 =?utf-8?B?ZDNDWDBvT3g3NTlPY3p0YWJsb0xOb2xSanBLeXBEQ0c5QVNHYlZNcWk2eDNz?=
 =?utf-8?B?RkwzWFVySm1IbHR2aWYyMkJtV3B4ajJTNVFwL1g0YUNMSzdKMnBudmtVMjlK?=
 =?utf-8?B?Q0JzYjlycXNuaXdIR3orM1FBdlp2UUVkSjBzc1RyR2l3QkpIb2FXNjg4Q3p6?=
 =?utf-8?B?dDFPcndkYWc3OCtpc0ZxRS9JcTVYNjF5NHk3RWtlZVZhR2xtd0dvaCsvVFVE?=
 =?utf-8?B?NDRjT3dlWnhFZjhxbWszRndlY3Ziem5zNG9ibzlhTE5XeVlKc0VKUndIekNs?=
 =?utf-8?B?RU1CWFlTbXBFQnJRYWNyeVVkTDlRUVVKQ1FZSlkvYldTWERBcWhDN0dOb0VO?=
 =?utf-8?B?ckNNMFMyeFB2SmZEZ1RzakxtTkhHbHB2eEdobVJlbkFRSGtQTEZ4OGtMM2xF?=
 =?utf-8?B?UDA0SjlPSFVzRmJndTc0WE1SaVNDL3dqcXFPRk9DK0R6amJHaElOUlVnMTRq?=
 =?utf-8?B?KzZxaXhRK2NXSjYvR2M5M0pLNjM5UGUwWDFEM3RiTVIrK2lIZmhpOGRnS3Vw?=
 =?utf-8?B?b3J0cmNEeVBBODlLSzJ4TVduT3FxK3E2blJxNnhYQVk4SEpaaVFycy9PZWFM?=
 =?utf-8?B?bjExRkdlRXZ4enNQV3pYK2I0aEhqaDh6THNBZmovcTlsRDFKVmQ5NzF2Z3ZB?=
 =?utf-8?B?czlmeGpueEIwL25helpLRFhmS2dJZ1JMeGw5UEhRSjZXamxycFlkcjYzdk5N?=
 =?utf-8?B?Zk5Mc29vOWkvUWpuMGdyOGZrYlM0L0NqU3BjUzZ0NGRZZnUzdnJYeVE2TDVi?=
 =?utf-8?B?YTR5QUcwVzI5dWVUVUdlSmx0S2tQSmFkbzNRUW9BM0wxck1ZcjM4cnZmY0dT?=
 =?utf-8?B?c05IeFZuV2lCZEh2d1hzV3E2azVkcTNpMWJMVHhQdGh3RVpLUDBySTB3aFoy?=
 =?utf-8?B?NG5kbk1nakhIcW5FRVptd2xGTFFOQ05KNzQ2NlhIMmFEQVBHekNnQThrdFhU?=
 =?utf-8?B?aW1NQms0c2hpclpnRlNGYmRmTWlkNzJKTFRKeTV4c0VtZGJ1MWZVbGJJK3RJ?=
 =?utf-8?B?TXBrbFMyVHJkT3gxejAwZS9oTDBRcWUxdkxndTN0Z2dvZkxjOEEvSEdKZzhD?=
 =?utf-8?B?Tm90cENIS0tIMnh5OEM5OWJBcFNHRUgzT1M0RDRha1lKOW1pcHVzTnlHbGJT?=
 =?utf-8?B?Vm9GTTlUTlRiVlpsclRQdm4rZjJhYVlWWWxLVGdidmM0Y29YMHl3a0ZCeDVu?=
 =?utf-8?B?UGpHSnlqckN3cDJlSXZaOUlsUkJlUytqMjhMSUw5UXdEVFBrckJ1SHpUWlRj?=
 =?utf-8?B?eWt6dVlVdEFIZDBTSHlrdDJGbjhienNNdW91TVZlN3N6QXdoZkhSb2IyMndK?=
 =?utf-8?B?bXFPUXp3cDIvOXhMRHFCR2xJTTVhSE5jcWVGb29ucXNTdDNCTG9pNTFmTkh5?=
 =?utf-8?B?YUl5bzFHbldUSWc2K3FRUVJQb2wwMXdpQi85Mk9vdVZ1bkVHOVlRZnlJRmhE?=
 =?utf-8?B?UG54S3RqTjI0VW9EOXFsVGNpMHdaWm5QVVJ2NWcvNkNNNHdWNkdrV2JiazFO?=
 =?utf-8?B?M2VCa1JJVVJTTjNEN2NzaDhFTEk2M1NQRXloOHdNWG1sK0g5S2tZYWVabGpp?=
 =?utf-8?B?UC82YmYvbi90TXNmcDl4YUR1UDVXbTJEMC9IMFEyMmtuYXUrTmNHOGNVWnZQ?=
 =?utf-8?B?MWJKZHJIeU5JV2R3MU1ta09tTktacVV6RTgyeURCdGFOMTdVSlJHQ21OS3RB?=
 =?utf-8?Q?aFRID+yfgOiCYVQRj3qDe+s8ICnY54fS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3NOa0R4di9PTE5OOTlEa2RFbHZnZEtLV3ZvcjFJWUtMUVd3cmdPTldoOTFl?=
 =?utf-8?B?MWpEVm9DYlVoNFZaS3BlVEp0cWJvTUJtYjNhbkUzVEljL0U0M2NOSHpPbnNW?=
 =?utf-8?B?ZlJ1Rm43UWdMRE05NHZIRlprWjhXWjlDYW0rMWp1Vyt2TGNneXJVNEd1c3ND?=
 =?utf-8?B?a01PNnJEeDN4NmlPelZVbVBYU1FBY0ZvUE1JZVZLTE44Q2RaeFlPeFFoVVlr?=
 =?utf-8?B?K3F3UGc0bHN0N3FYa3ZRbExRcmE1ZjRnM3lVVzJvTU9kdFI4dUZUemxpOG5h?=
 =?utf-8?B?YUdpU25XY1ZtajZEd2JjZFdMNjl6NSs3VThMa2NEUC9hTlB5U2NmOUdZV2F1?=
 =?utf-8?B?MUhpMVdjejhtSWxIU0JFY1BxTFNOZXRCMHlPd253TS9ob2NFSGdqalVBa1hQ?=
 =?utf-8?B?OHloOWhzNEUwZkhndGRscllaT21OeWUzYnNubzFrUnBqUmkraUl4emNxZTFW?=
 =?utf-8?B?R0hEand3R1BvTjVtZGI3SW56cXdka2l4U2VvVnJJTFo5TEw3RXo2WithRWVT?=
 =?utf-8?B?TzA0Z29ORFJWUmI4Y256Z0ZRelZxRjg3SUcySy9KdXV3LzJZKzRRNUszWThx?=
 =?utf-8?B?eW40cGtFMkVBWjN3ZldnTG10YkhlWnhUR0MxeUZCaDRBRFlLamhXQlhjMWpF?=
 =?utf-8?B?UjR6MUFxM0l5UEFLS01kS0dRVGRySTVONFVIRkNDOVdyQWlSTy9aZkt3UHJB?=
 =?utf-8?B?WWdvalBWZ21tMTc2dmIrdFJpdXZYeDYyQmlxTm4vWi9pUTJkSW1VNmoySThO?=
 =?utf-8?B?em5od05KdjBuQWYxVXZ4VEFsNE55Zk9McjRmalBKUUlMSk5LU1BOQ0dnTXow?=
 =?utf-8?B?SmZ2andkNE1IT3hBS3l1M0JqRmQvUmtpN3BmNk5HWC96TVdMZ1Q4OEowd2pr?=
 =?utf-8?B?QTMyRDZsWWNqbS90eWxSenpvOS9WcTRucWxtQkFNTXRiSElJRFpYM1F0alQy?=
 =?utf-8?B?ZFhhZUxqSHJXQkdzcHlsbllUNmNvQ01pYUpoU3MxYTN4ZUJXUmNBOG9GWTIy?=
 =?utf-8?B?bXJmRTI3K1l2cVlrc0F6c3l1dzA4VHNYdThNWnhiRWZBeGlZeEtWWVBJUStD?=
 =?utf-8?B?TDJNWmwvZ2FHTEpGMXNseHZxeWZsbXN5ZlVVaCt4ZUxFRFhuSWNkWG45SGlN?=
 =?utf-8?B?eGlmS2pKY0FPZldiQVAyRnpDeUo0N1I5UTZWUjI5NHFoR3B3UUFZdWhUVk82?=
 =?utf-8?B?NG1qYk9oNzdNK1RrQ3p3RWZWZSt5WmN1Qm04M2Q5Q1RLSjYvbDkxQ2dnSjJC?=
 =?utf-8?B?LzJyUEFIOWJsRUcyS1c4SStjcmJZSHIvcFNBby9pOTBHODJQM2RRSHlETTIx?=
 =?utf-8?B?SDlXM1BiU000UGVaODRrdUh3REhEYjZRcHFCWU9nSkdyTVNvc2hHbE84VzNo?=
 =?utf-8?B?b0MrNzdNVG5XZGlJWnZlcFNoVG90QTFEU1F2dnlKbmVaOFJxTGZUTCs0d3l0?=
 =?utf-8?B?OTQrZEFiWGpQb0VnVHB4WlhZUzdla2YzMSsxekFxTm05KzliY2M3cEhibFln?=
 =?utf-8?B?L3g2TmRhcUNlRXczR1JISkJiRHB2cFRralFqeTcwOE0ydE1CNEdZUkgvSjUv?=
 =?utf-8?B?czh5OEFXSkNDWFdPamhKOXpwVDVRZU5iSGtEanJ2eXUyN2drTkhyb2dYRTNN?=
 =?utf-8?B?YWRNaHd2NlQ0UWpuL2JxMmhkcHZmTi9RaXNkZjBnRGpoRXhJOVVXV0gzdzRN?=
 =?utf-8?B?ejRPN0xLUVFUNE5uOVc1OGhyVy9JblpWSUJ4NlFTQk9uWFpOOU0yNDRKZDlM?=
 =?utf-8?B?YkxsL1F1eEVnZHR0RUlwMDl6Szl4dnU2Ni91cjEwdndpemw5N21qbGJ3ZWpN?=
 =?utf-8?B?MlA4L1NpMkEvcmtVUHBIYXZyMlczMUJJYjJmbkEyNzBMeTVyN2szZE9SdGdi?=
 =?utf-8?B?cHlJdXdLVkR3eFZBOGZXVFVhSHhrbCttQURmdE95T2k0bENWSjVQVE5DRGRT?=
 =?utf-8?B?QUJFTHlVYTBnUG9wcHFxMzFpNy9QOFVHNjF5WnFDdTdBeDJ3WHJiMlFIZWF0?=
 =?utf-8?B?N3hydXU2T0EzSGYrR0ttbXd2cEVoM0NjRklTNVFiSDZyUEtMaW56a3VnbTJs?=
 =?utf-8?B?eWtYRG92YXc1cGJnRC91dzdjMUR4NVowbTJSdU10QkhpYzdSYnlRcnFFN2x6?=
 =?utf-8?Q?IonjPYkmQ079UHWcACoToW92N?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f80294-da86-4fe9-ddf0-08de2e21f0a3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:00:44.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY0GNZz7Q+ueMuoCUlVhJoWmeMi8k0O748a/YJc8CknHxXijZxL92yg9p5IHN7mmZsiz9GP30xzruV1pFeIRMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7332

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Thu, Nov 27, 2025 at 4:54 AM Ye He via B4 Relay
> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>> From: Ye He <ye.he@amlogic.com>
>>
>> This patch adds shell command for bearer connect/disconnect.
>>
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> ---
>>   client/bluetoothctl.rst |  49 ++++++++++++++++
>>   client/main.c           | 152 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 201 insertions(+)
>>
>> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
>> index 0187e877d60b28eb1e735181b3203e60da821e6f..87aae8995a29749ffa09bbfefbd74c41f242fedc 100644
>> --- a/client/bluetoothctl.rst
>> +++ b/client/bluetoothctl.rst
>> @@ -296,6 +296,55 @@ needed.
>>
>>   :Usage: **> disconnect <dev> [uuid]**
>>
>> +le-connect
>> +----------
>> +
>> +Connect device over le.
>> +
>> +This command initiates a le connection to a remote device.
>> +
>> +An active scan report is required before the connection can be
>> +established. If no advertising report is received before the timeout,
>> +a le-connection-abort-by-local error will be issued.
>> +
>> +:Usage: > le-connect <dev>
>> +:Example: > le-connect 1C:48:F9:9D:81:5C
>> +
>> +le-disconnect
>> +-------------
>> +
>> +Disconnect device over le.
>> +
>> +By default this command disconnects all profiles/services associated with the le
>> +connection, and then terminates the le link.
>> +
>> +:Usage: > le-disconnect <dev>
>> +:Example: > le-disconnect 1C:48:F9:9D:81:5C
>> +
>> +bredr-connect
>> +-------------
>> +
>> +Connect device over bredr.
>> +
>> +This command initiates a bredr connection to a remote device.
>> +
>> +By default, it establishes the bredr connection and then connects all profiles
>> +that marked as auto-connectable.
>> +
>> +:Usage: > bredr-connect <dev>
>> +:Example: > bredr-connect 1C:48:F9:9D:81:5C
>> +
>> +bredr-disconnect
>> +----------------
>> +
>> +Disconnect device over bredr.
>> +
>> +By default this command disconnects all profiles associated with the bredr
>> +connection, and then terminates the bredr link.
>> +
>> +:Usage: > bredr-disconnect <dev>
>> +:Example: > bredr-disconnect 1C:48:F9:9D:81:5C
> I really meant le and bredr submenus though, not just prefixes, so we
> can later expand the bearer specific functionality as needed.


Sorry for misunderstanding that. Using sub-menu indeed provides better 
extensibility.

I will rework it in the next version.


>>   info
>>   ----
>>
>> diff --git a/client/main.c b/client/main.c
>> index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..45ebea44f9eda80f939b9f8324fb60064f28eb50 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -2303,6 +2303,106 @@ static void cmd_disconn(int argc, char *argv[])
>>                                                  proxy_address(proxy));
>>   }
>>
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
>> +       bt_shell_printf("Attempting to %s %s on %s\n",
>> +                                       method,
>> +                                       argv[1],
>> +                                       iface);
>> +}
>> +
>> +static void cmd_le_connect(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
>> +                                                               "Connect");
>> +}
>> +
>> +static void cmd_le_disconnect(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
>> +                                                               "Disconnect");
>> +}
>> +
>> +static void cmd_bredr_connect(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
>> +                                                               "Connect");
>> +}
>> +
>> +static void cmd_bredr_disconnect(int argc, char *argv[])
>> +{
>> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
>> +                                                               "Disconnect");
>> +}
>> +
>>   static void cmd_wake(int argc, char *argv[])
>>   {
>>          GDBusProxy *proxy;
>> @@ -2789,6 +2889,47 @@ static char *dev_set_generator(const char *text, int state)
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
>> @@ -3528,6 +3669,17 @@ static const struct bt_shell_menu main_menu = {
>>          { "disconnect",   "[dev] [uuid]", cmd_disconn,
>>                                  "Disconnect a device or optionally disconnect "
>>                                  "a single profile only", dev_generator },
>> +       { "le-connect", "<dev>", cmd_le_connect,
>> +                               "Connect le on a device", le_dev_generator },
>> +       { "le-disconnect", "<dev>", cmd_le_disconnect,
>> +                               "Disconnect le on a device",
>> +                                                       le_dev_generator },
>> +       { "bredr-connect", "<dev>", cmd_bredr_connect,
>> +                               "Connect bredr on a device",
>> +                                                       bredr_dev_generator },
>> +       { "bredr-disconnect", "<dev>", cmd_bredr_disconnect,
>> +                               "Disconnect bredr on a device",
>> +                                                       bredr_dev_generator },
>>          { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake support",
>>                                                          dev_generator },
>>          { "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
>>
>> --
>> 2.42.0
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
