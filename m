Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023124.outbound.protection.outlook.com [40.107.44.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F5260565
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763343316; cv=fail; b=NRxla0Iv9lvoe1d40PieFh+ket42UAC2v98d7NP3BKcGChNAnZBoQGokERar84pShwb/ly9N1hXLkvAJTmFcfmBSb3F8Cvzb/cLyhGFNHKO0XnZlRaGpNaKmfb3o7QuUCLVP0Qz8cYJXOhdt8dhmYZjgoAJU2l7588ve+3cj0XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763343316; c=relaxed/simple;
	bh=ubZi1xWolCXwq18lbEnGT9rAcuQCPsmnErG3pvc25XQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/nyGv/XX8rKiHKLqZszyBZQ9IYUCdx1A8sfhazp6IfMVq4SHuQCvQKRLuRsWc6hFwU3zP6VjKgu2vbpmoeUgze3BtguuCSw3NL2SSX5P0jx3Ndy97DDKvH4p60F36fm/iiHfNmpAi0GXqXGEiOIWDhjQb3Yp0o4RVWGPaCjeX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=qiAu228n; arc=fail smtp.client-ip=40.107.44.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="qiAu228n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aevRo1AEiM4uyK91h7TV77xnMboxqEg5ZKG5VbKn6SwMmcD7bojNQwxd0U5/nQjkffDukg88iaCrgNQ55oVzH0letXXeSujqjbOdX3KRscbXqhICkaFtFSp9KNJG508BiBA6V1/naFJHXrthrZO5t20fthRo7Rcfh1dP5kRuITTmBzJWP+TeM2dH8gnCFNw+1T8uLwaFzO67A9987afJjlo7+VdLQIVHjxKI1DdRZebeajTJyBCoxoAU6AqADIPG6kDVhfRmAMOZo6s0rSzJTA6SRwcNw3Yo3TNdh/UqAm26Zr1sRs44Lt5oo6UsfauTRgOVg1YUM4W6AbKOZ7vpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAaCX7S1xgLP5+h3wTrOfFL5itlzajRlmHNzMGz/Kn0=;
 b=wVKFrOnNRUDcncyd2iUzUVFOBpLJycy8QPKcl5VfsWkjEMFBW3UCS9x6VdsNeVwjyPPKVEsLaZD3XNMbUKwAp6FC4q26wJ6FaJml7aAFxx5HIAIbR7xmOdPk0uhEnVTHHIUH0mQU0DsJhsTuX4qh80rZyFuH/do+FO7NdzbZ67KiruEe/sXdaqxb/jBG6yoDTPfpajd1DvDC1UcSwVxiyZyZdhrxgrURahzXUIhFWb9vnzgjYYbZnQvHth+Ub1rKW2OV/+JX0IAc98D5hhRklb1VaHjwRwwx+0G68dR3hG2oES/BzQyCH4OhP+EHi3ZZ2ANeHadQPlU0xYFbyBOFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAaCX7S1xgLP5+h3wTrOfFL5itlzajRlmHNzMGz/Kn0=;
 b=qiAu228nVLdVmg3CyNzwyjPT6Ei3fTJfyr6p5NxnseGFnd/BtoZzasV7K8+tte5t/BQN316OBIzilMizmdWOOCLcBw+/SsGhTmBtH/rhc1Ns9c1/piO7yHwNVcrl5NJS9fDpfhJEbRjK16LaKYaBrlqAM+WVknXnLlm8g31OY3iCDAsnRtwOfTWfBa+w+oGvAOjKl8O56h1HVQPbWknU8jFBvPed7fi9bUPli/BpVQ7kMPdxmaj/CwHl6CvRqhpVaAY4KnL0yGl2kAoMh8E8ynMi/Qo3Xd2lyPoBG0g0yaI7rSlxmrVrTnb02kxj/7rLlLRJDRn3+0DVk7OoB0CCsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by JH0PR03MB7908.apcprd03.prod.outlook.com (2603:1096:990:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 01:35:10 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 01:35:08 +0000
Message-ID: <cc5149ed-3392-4c18-9fbd-97ba6ab83ede@amlogic.com>
Date: Mon, 17 Nov 2025 09:34:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v2] bearer: Implement Connect/Disconnect methods
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com>
 <CABBYNZKgJEMviz6ffcs9K2kbqZK9fS3r81R5vT6xs_4LNjuC5g@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZKgJEMviz6ffcs9K2kbqZK9fS3r81R5vT6xs_4LNjuC5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|JH0PR03MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 14183fbf-d8e1-4910-3895-08de25798b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0g2cjF1QjdwTUVyOERrbVZYWTRaVUMxUDZJV3VuZGUxRXBYREswZzhSdHp4?=
 =?utf-8?B?cW0vRlJJUmdQcGpvWWZrWUMzdW41bU9tSVlPYlRvYnhlUm5qZHFCY3JZSng3?=
 =?utf-8?B?M2tEVitSTFcybng0eXZmVHNlajE4LzJMUG5pTHdTZmYxdEE1ZGl2WFpTWFNK?=
 =?utf-8?B?TUN0ZjVMdVlqWVJ3Zy9QdkhBNHFmdWJ4clFPclRNam95aTAxRkgzdE1jYS9Y?=
 =?utf-8?B?Tnk2MW9NQlBNVXBGZkV2VWtxVVZuM0Y0Z1EySU83U2xXeEE0S0FBT1hCV3Aw?=
 =?utf-8?B?eWtwRTlMNVhOU2dkeHJJUG9MWlNUcndYaGRHUGVoYmZrZWtuSXhjNUtSOTRn?=
 =?utf-8?B?eU5DT2ZFelROT2pOcHQvV3VqMjNjYkY3Yzg4ZTVhZGk1bFdXMGZHenJSSkx6?=
 =?utf-8?B?dUxaRG1GWFVZK3d0TTVZRFBMU2Z0L3h4Q2lhTmdqRytKbXJnbnZncmhzb2Vh?=
 =?utf-8?B?c2VXL3VDR1YyZHNSNEtVYi9weGdDWmFXVHFBZFdVYmsxZDQ0cEp6YmFFZm9K?=
 =?utf-8?B?UW9nS2tkZ0ZYQlR5cWU1SFhTTVVxWFJ4Ry9nbXBtQjFGWUY2WUgxcGNmL1RN?=
 =?utf-8?B?a2g1MTFSVjBRQzBlNmpacDkyb051YlNkeDhpeWtGWVRJdXFxRmM3bERrWXJT?=
 =?utf-8?B?VG83TjdHa0k5SEFJbVV3TjBPS3dNZVJHL2FLZm9ZVXAvektHMUNrMmtLTDRr?=
 =?utf-8?B?bjlUSFZZT0NUSnZHNlJ2SlFaNjRIdHppejcrYUVtYjZabkxGQ0NBYUNGb0xQ?=
 =?utf-8?B?cjlpaFlOZ2NTM0ljTEZBVVJHVTFtUnlWNzc3emJBMGk0akM0NlVWUmhmV2Vm?=
 =?utf-8?B?UjlxYUFteFJXd0tYL0RsZG5NVGJ0ZXlHYUN5VDFNTndqZGd2UDY0K0VtWndZ?=
 =?utf-8?B?VU85dytwdW53Z29zdHBQNHltQmoyTE91ZzlqR1NIamdoZWlPRzRxdWFIRzJz?=
 =?utf-8?B?cXhaY1d1eWFaZENnL2pmZGFzanVHVDYrWTRnSHNIS2JSQS9Od1dhc2podE9o?=
 =?utf-8?B?T2REczhkUU9kVGdjdGE0OFlXNG1RUkxjYk02bklEVUM5OTR2S0RmRDBJQ2hr?=
 =?utf-8?B?Y2I4c0hPQ0VZNDRlWXlPdzV4NFB3S3I1dDIvVVQ2REtHK2lCbWI0RkFMZXZx?=
 =?utf-8?B?TlhQc2gwM28rMWpPemFtUHg3RGU3OFExMU9UWHg2VUNCVkxORDdhN3BXMm9T?=
 =?utf-8?B?M3I0dkxuQVBLRklMYU5FQXNWelZJdW8ybHVNSkQ1N3JiUjQ1TzhQVllvbnRw?=
 =?utf-8?B?Z1NzQ1c5UFI4L050T0ZUS3daQTVHNXhDQ1B6QmhyVEUydVVkdmo0UnErNHZJ?=
 =?utf-8?B?UVRWeWNYamQzdTAxUCttTFRuRmJxdjRzdXNsZjloNUNoNEF2V3ZWT3BZQmlp?=
 =?utf-8?B?TmdoYjk1S3dMV1o2cEFFM2E2YW9ZeUpWMTRqa0NvSDdZVmNvWVoxaDEzRTEy?=
 =?utf-8?B?aStrYXRKRmVBTDBtTXg1SnduSUJhTmcxZDV6bVpGTkNzMFM3Wk42alZVL1BY?=
 =?utf-8?B?a29tSG1mNnNHbjBmNnZSSUFpc2JFTDVVb2xOMWprUWt1RlRIWXpiZzV2dWsy?=
 =?utf-8?B?QjJuR2grSTVVTWkvbE1sa3h6dkZFaDhUQXowUE54YzJqbU5DUDh0NnQwTStJ?=
 =?utf-8?B?RWt2QzRTY2JiRWY4OFB2MG5PaS9uN0pVdm5zRTZJcVluV3B2MHpnTmNLN2Rx?=
 =?utf-8?B?MzRrN0dyZmpCbGwwczV2dzQvcTZXcVZrampzcWtRRURGWUNuL2cxRTR6NTBQ?=
 =?utf-8?B?SlFEVXcwMk5pVktWejg0bU9XMFhUYjRCemd2TEFXL1FiYUpRSTgzNmdyQWc0?=
 =?utf-8?B?d1ZXNnBRWk5sblFqdzdENHIwMml3ckRvTUZHdzlZVExCRWJkZlRlVzJDQTkw?=
 =?utf-8?B?VVRHQ3hTNVlZTlkydUpieEpCTXY5VE10WWJ3bXBuNTl5QlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHBqNlpTTnA2RlRXNHZ0K21OWkhOb2VNaXlHeURRc05xalRZYmwrTU4xR2FW?=
 =?utf-8?B?dFNRUmNzVWNObXFwQzk5SEdMcVgzZk1QMnEweGVUcmozaUg2eWtTWkE0T21L?=
 =?utf-8?B?L3BRNzR1TmxOSkUxSWc0ZUNIWmFYdTg4WEljRjJjVTNjTVJOWXhOeWc2YkQ1?=
 =?utf-8?B?N2oxdlR2YUVpMzJrN3RMNDRrWTNDQ2R5TmpGVWJmWXR2SytwYTY4UHBTLzZO?=
 =?utf-8?B?SFFpbXBOTEduVnozdzFRT1pZL21QemtHcjNERzVlL3pTUTFIM0RObVJqOWFy?=
 =?utf-8?B?emhCRERXeHZsRWJoK2VLOThGSmV1OWlNMG1IYWkvMzlFczB5ak9HcFU0YmJz?=
 =?utf-8?B?V296a1JXaVVtdStpa0taQzZydnhETnBWZVFPRUEwRjdkUmRONXRMRjdKYk5B?=
 =?utf-8?B?MGUzcHZqTFErMzcrSDUrNk9kczJ1YzFDQklyVzJERjlYTUpqaXNhOHUxajRk?=
 =?utf-8?B?RC90MnlKOEIxSldZSTVrTVg0MXdWR1Z4d2dqRFdWdHpQK0s3cjYzYkRaSXpk?=
 =?utf-8?B?VzlhTW02dEdTVEdOZWpYeTBLMFBQL3hYRHFHeWMwbzdUVWhnVjgzYTRaZkdM?=
 =?utf-8?B?ME1oS2I4SFZSQVpCTkFqYktoQktMcUFVc2FKbW5mVVAveVpyK2VkUGtyaytB?=
 =?utf-8?B?bEE1dG5IYjJQLzFyKytVUHd2cHUwSnBMbmh5b0FYc2krNU1USU1EOWN6emFp?=
 =?utf-8?B?M1M4SWg5QUs1L0Z3UDVZQzR4QjNNamhRbGtPMTllMWZla0cyYTZLSms5dXRm?=
 =?utf-8?B?dmFKS1BjdVQ2c0kvNFVTdk9tS0lSZlRzd3p0cW9kYWpQaGtCTWFRSXdnRXJy?=
 =?utf-8?B?MzM4N3ZHVmJITGlmQUVvbEhOZEFabVF4RjRIN1d4NGxGeHdBeHJJQWFZY0Vt?=
 =?utf-8?B?OXA4T2RsK3R0M0lsWTV2RTNvd2xHRDczODFCZDZ5SFVOczVSbW05UDNqTG5w?=
 =?utf-8?B?c2pqa25memxXaXJYTkNaTzNzM2xtUGRRWVNyVFlabXEzUlRrcG5aNjhtaGwx?=
 =?utf-8?B?M1VjNzVhS3NNdndSVVNkQWJLNEhTZStBT1dYYkFDTFpyR2NCSzR1cnNKSENt?=
 =?utf-8?B?ZnpES3lFc09oRFlueC9OWkg2Unc5Z0d0bHdNbTlzM3psSHpwQ1BOaW9uQUJt?=
 =?utf-8?B?MzF2MEYvQWhEamFGWEsxSjV2eDBrL3RuTzIwaWMvUDRXdXg0blFNclpCVUpn?=
 =?utf-8?B?bTM2RU41VWRTRU9PdWRuTENnekdWTzQ3dzNCSzM4Njg0YVJobkgxejQ5UjF4?=
 =?utf-8?B?Y05hQWIvajB0U0laa2VqaWQ5K1ZMejloWnFwR3hEeEhTWkN3K3prRW41ZFBu?=
 =?utf-8?B?Q3N2VU0wN2JZZUd4QkRCNFZXc0cvK3ZwcDY5NGR3NkI3M0tIdUtscEhqQVFH?=
 =?utf-8?B?THNCVy9uT0tqbitMTEJDaTJSK2t5L09RZldXU1htNWQwS0xzUFpCNE1CVEpa?=
 =?utf-8?B?UHBnWURVbXNBMDEvM29mTkM0T013aDRETlJiN0hjelh6V2dYWDF4UGMvWjhI?=
 =?utf-8?B?OHpJZ3RnVDZQcW0yU1A3NFgvWHQ5UnJ0b3EzVWNxTUorNVhEcUhSSmtZN3Bl?=
 =?utf-8?B?UldpUUw5dGh6Tm1tZHRlVjRldGU1c3B6Z0VaWHJqWGEwUDhIMjVqREoxQ2pE?=
 =?utf-8?B?U1JPeU4yalZuMDVpRXVnNEZVekc1SG9EejN2UnJ3Qld6ZTVXWTVnemlJWWtK?=
 =?utf-8?B?bFB6T010ZlZtZGxGaXlwY0Fwc0R1bTVjNDgwN0JZcVBGc0RmODRZQXZjMW9h?=
 =?utf-8?B?bDJ4enhNaHQ1ZHF4YlhZSHFqZGlrL0NFajFUeEV2Q1dYbUs0M1NCZGtYdmd1?=
 =?utf-8?B?VGlXS1hiSys2UXdCTXhGMWZCckx0RzFac2hPYTdFaXNYSElpSHNqWmZEWWtz?=
 =?utf-8?B?RFEvUm41dmhhZTZmTSszSnJDNjRTL3gzZGFUODZFQXM0UEwxc1JKcHRQQjVq?=
 =?utf-8?B?SFJ4dWYyTUgwbkhxa1cwK2J3QzdSNUdhb0lVM3luT3IzREVJaWRVckxCMXov?=
 =?utf-8?B?SHEvODM5d3hFVkkvdU9LNEZWSlU3ZHR1WnJYOFZoZVh4S3ROeXBVcTRwekNJ?=
 =?utf-8?B?L1V5ZWNjS24zM3hpUXpZNHpLMU81TERHOGZVMGNReURTbWtFZkVWdFhUUFRT?=
 =?utf-8?Q?71cqGHAZzkNCZnOWwwSHCd073?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14183fbf-d8e1-4910-3895-08de25798b0f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 01:35:08.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvYhEW6nxaB8stQK0ofV19cHLkMHcxvshczKAJIcQRBzfyCybnNa76szuuNOJ10KdR3aDRYQeTRGyWqlPEZHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7908

Hi Luiz,

Thanks for the feedback. I will rework the patch so that all new logic
lives within bearer.c. If access to device-level information is required,
I will add minimal helper functions instead of exposing struct btd_device
directly, and avoid adding new logic into device.c.


> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Wed, Nov 12, 2025 at 10:43 PM Ye He via B4 Relay
> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>> From: Ye He <ye.he@amlogic.com>
>>
>> This patch provides implementations for the Connect and Disconnect
>> methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
>> interfaces.
>>
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> ---
>> Changes in v2:
>> - Fix build error & warning.
>> - Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f41585144218@amlogic.com
>> ---
>>   src/bearer.c |  57 ++++++++++++-
>>   src/device.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>   src/device.h |   4 +
>>   3 files changed, 280 insertions(+), 52 deletions(-)
>>
>> diff --git a/src/bearer.c b/src/bearer.c
>> index 9723b59e2e7b39b2974e258363aa0ace95862651..c18d134e5783108ce048e3f52f17da835387b245 100644
>> --- a/src/bearer.c
>> +++ b/src/bearer.c
>> @@ -40,6 +40,8 @@ struct btd_bearer {
>>          struct btd_device *device;
>>          uint8_t type;
>>          const char *path;
>> +       GSList *disconnects; /* disconnects message */
>> +       GSList *connects; /* connects message */
> Use struct queue for storing the connect/disconnect requests.
>
>>   };
>>
>>   static void bearer_free(void *data)
>> @@ -52,14 +54,46 @@ static void bearer_free(void *data)
>>   static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
>>                                                          void *user_data)
>>   {
>> -       /* TODO */
>> +       struct btd_bearer *bearer = user_data;
>> +
>> +       if (btd_device_bdaddr_type_connected(bearer->device, bearer->type)) {
>> +               if (msg)
>> +                       return btd_error_already_connected(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (bearer->connects) {
>> +               if (msg)
>> +                       return btd_error_in_progress(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (msg)
>> +               bearer->connects = g_slist_append(bearer->connects,
>> +                                               dbus_message_ref(msg));
>> +
>> +       device_request_connect_bearer(bearer->device, bearer->type, msg);
>> +
>>          return NULL;
>>   }
>>
>>   static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
>>                                                          void *user_data)
>>   {
>> -       /* TODO */
>> +       struct btd_bearer *bearer = user_data;
>> +
>> +       if (!btd_device_bdaddr_type_connected(bearer->device, bearer->type)) {
>> +               if (msg)
>> +                       return btd_error_not_connected(msg);
>> +               return NULL;
>> +       }
>> +
>> +       if (msg)
>> +               bearer->disconnects = g_slist_append(bearer->disconnects,
>> +                                               dbus_message_ref(msg));
>> +
>> +       device_request_disconnect_bearer(bearer->device, bearer->type, msg);
>> +
>>          return NULL;
>>   }
>>
>> @@ -200,9 +234,19 @@ void btd_bearer_bonded(struct btd_bearer *bearer)
>>
>>   void btd_bearer_connected(struct btd_bearer *bearer)
>>   {
>> +       DBusMessage *msg;
>> +
>>          if (!bearer || !bearer->path)
>>                  return;
>>
>> +       while (bearer->connects) {
>> +               msg = bearer->connects->data;
>> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
>> +                                               DBUS_TYPE_INVALID);
>> +               bearer->connects = g_slist_remove(bearer->connects, msg);
>> +               dbus_message_unref(msg);
>> +       }
>> +
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type),
>>                                          "Connected");
>> @@ -212,10 +256,19 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
>>   {
>>          const char *name;
>>          const char *message;
>> +       DBusMessage *msg;
>>
>>          if (!bearer || !bearer->path)
>>                  return;
>>
>> +       while (bearer->disconnects) {
>> +               msg = bearer->disconnects->data;
>> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
>> +                                               DBUS_TYPE_INVALID);
>> +               bearer->disconnects = g_slist_remove(bearer->disconnects, msg);
>> +               dbus_message_unref(msg);
>> +       }
>> +
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
>>                                          bearer_interface(bearer->type),
>>                                          "Connected");
>> diff --git a/src/device.c b/src/device.c
>> index 91b6cc0c65eaae8058cd445c0942ffee57289f0d..b05c508674f194c3c6b0cef96f6ac3bc6a300d9a 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -250,7 +250,8 @@ struct btd_device {
>>          bool            temporary;
>>          bool            connectable;
>>          bool            cable_pairing;
>> -       unsigned int    disconn_timer;
>> +       unsigned int    disconn_bredr_timer;
>> +       unsigned int    disconn_le_timer;
>>          unsigned int    discov_timer;
>>          unsigned int    temporary_timer;        /* Temporary/disappear timer */
>>          struct browse_req *browse;              /* service discover request */
>> @@ -315,8 +316,13 @@ static const uint16_t uuid_list[] = {
>>          0
>>   };
>>
>> +static bool disconnect_le(gpointer user_data);
>> +static bool disconnect_bredr(gpointer user_data);
>>   static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
>>   static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
>> +static void device_set_auto_connect(struct btd_device *device, gboolean enable);
>> +static DBusMessage *connect_profiles(struct btd_device *dev,
>> +                       uint8_t bdaddr_type, DBusMessage *msg, const char *uuid);
>>
>>   static struct bearer_state *get_state(struct btd_device *dev,
>>                                                          uint8_t bdaddr_type)
>> @@ -922,8 +928,11 @@ static void device_free(gpointer user_data)
>>                  sdp_list_free(device->tmp_records,
>>                                          (sdp_free_func_t) sdp_record_free);
>>
>> -       if (device->disconn_timer)
>> -               timeout_remove(device->disconn_timer);
>> +       if (device->disconn_bredr_timer)
>> +               timeout_remove(device->disconn_bredr_timer);
>> +
>> +       if (device->disconn_le_timer)
>> +               timeout_remove(device->disconn_le_timer);
>>
>>          if (device->discov_timer)
>>                  timeout_remove(device->discov_timer);
>> @@ -1903,23 +1912,6 @@ static gboolean dev_property_set_exists(const GDBusPropertyTable *property,
>>          return !queue_isempty(device->sirks);
>>   }
>>
>> -static bool disconnect_all(gpointer user_data)
>> -{
>> -       struct btd_device *device = user_data;
>> -
>> -       device->disconn_timer = 0;
>> -
>> -       if (device->bredr_state.connected)
>> -               btd_adapter_disconnect_device(device->adapter, &device->bdaddr,
>> -                                                               BDADDR_BREDR);
>> -
>> -       if (device->le_state.connected)
>> -               btd_adapter_disconnect_device(device->adapter, &device->bdaddr,
>> -                                                       device->bdaddr_type);
>> -
>> -       return FALSE;
>> -}
>> -
>>   int device_block(struct btd_device *device, gboolean update_only)
>>   {
>>          int err = 0;
>> @@ -1927,10 +1919,15 @@ int device_block(struct btd_device *device, gboolean update_only)
>>          if (device->blocked)
>>                  return 0;
>>
>> -       if (device->disconn_timer > 0)
>> -               timeout_remove(device->disconn_timer);
>> +       if (device->disconn_le_timer > 0)
>> +               timeout_remove(device->disconn_le_timer);
>> +
>> +       if (device->disconn_bredr_timer > 0)
>> +               timeout_remove(device->disconn_bredr_timer);
>> +
>> +       disconnect_bredr(device);
>>
>> -       disconnect_all(device);
>> +       disconnect_le(device);
>>
>>          while (device->services != NULL) {
>>                  struct btd_service *service = device->services->data;
>> @@ -2022,6 +2019,28 @@ static void dev_disconn_service(gpointer a, gpointer b)
>>          btd_service_disconnect(a);
>>   }
>>
>> +static void dev_disconnect_watches_notify(struct btd_device *device)
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
>> @@ -2055,7 +2074,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>                  device->disconnects = g_slist_append(device->disconnects,
>>                                                  dbus_message_ref(msg));
>>
>> -       if (device->disconn_timer)
>> +       if (device->disconn_bredr_timer && device->disconn_le_timer)
>>                  return;
>>
>>          g_slist_foreach(device->services, dev_disconn_service, NULL);
>> @@ -2063,21 +2082,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
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
>> +       dev_disconnect_watches_notify(device);
>>
>>          if (!btd_device_is_connected(device)) {
>>                  if (msg)
>> @@ -2085,14 +2090,166 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>                  return;
>>          }
>>
>> -       device->disconn_timer = timeout_add_seconds(DISCONNECT_TIMER,
>> -                                                       disconnect_all,
>> +       if (!device->disconn_bredr_timer)
>> +               device->disconn_bredr_timer = timeout_add_seconds(
>> +                                                       DISCONNECT_TIMER,
>> +                                                       disconnect_bredr,
>> +                                                       device, NULL);
>> +
>> +       if (!device->disconn_le_timer)
>> +               device->disconn_le_timer = timeout_add_seconds(
>> +                                                       DISCONNECT_TIMER,
>> +                                                       disconnect_le,
>>                                                          device, NULL);
>>   }
>>
>>   bool device_is_disconnecting(struct btd_device *device)
>>   {
>> -       return device->disconn_timer > 0;
>> +       return (device->disconn_le_timer > 0) ||
>> +                               (device->disconn_bredr_timer > 0);
>> +}
>> +
>> +static void dev_disconn_bearer_service(gpointer a, gpointer b)
>> +{
>> +       struct btd_service *service = a;
>> +       uint8_t type = *(uint8_t *)b;
>> +       struct btd_profile *profile;
>> +       bt_uuid_t uuid;
>> +
>> +       profile = btd_service_get_profile(service);
>> +       if (!profile)
>> +               return;
>> +
>> +       if (!profile->remote_uuid)
>> +               return;
>> +
>> +       if (bt_string_to_uuid(&uuid, profile->remote_uuid) != 0)
>> +               return;
>> +
>> +       switch (type) {
>> +       case BDADDR_BREDR:
>> +               if (uuid.value.u16 < 0x1100 || uuid.value.u16 > 0x11FF)
>> +                       return;
>> +               break;
>> +       case BDADDR_LE_PUBLIC:
>> +       case BDADDR_LE_RANDOM:
>> +               if (uuid.value.u16 < 0x1800 || uuid.value.u16 > 0x18FF)
>> +                       return;
>> +               break;
>> +       default:
>> +               DBG("Unsupported bearer addr type: %u", type);
>> +               return;
>> +       }
>> +
>> +       DBG("Disconnecting profile %s (UUID 0x%04x) for bearer addr type %u",
>> +           profile->name ?: "(unknown)", uuid.value.u16, type);
>> +
>> +       btd_service_disconnect(service);
>> +}
>> +
>> +static bool disconnect_bredr(gpointer user_data)
>> +{
>> +       struct btd_device *device = user_data;
>> +
>> +       device->disconn_bredr_timer = 0;
>> +
>> +       if (device->bredr_state.connected)
>> +               btd_adapter_disconnect_device(device->adapter, &device->bdaddr,
>> +                                                               BDADDR_BREDR);
>> +
>> +       return FALSE;
>> +}
>> +
>> +static bool disconnect_le(gpointer user_data)
>> +{
>> +       struct btd_device *device = user_data;
>> +
>> +       device->disconn_le_timer = 0;
>> +
>> +       if (device->le_state.connected)
>> +               btd_adapter_disconnect_device(device->adapter, &device->bdaddr,
>> +                                                       device->bdaddr_type);
>> +
>> +       return FALSE;
>> +}
>> +
>> +void device_request_disconnect_bearer(struct btd_device *device,
>> +                               uint8_t bdaddr_type, DBusMessage *msg)
>> +{
>> +       if (device->bonding)
>> +               bonding_request_cancel(device->bonding);
>> +
>> +       if (device->browse) {
>> +               if ((device->browse->type == BROWSE_SDP &&
>> +                       bdaddr_type == BDADDR_BREDR) ||
>> +                       (device->browse->type == BROWSE_GATT &&
>> +                       bdaddr_type != BDADDR_BREDR))
>> +                       browse_request_cancel(device->browse);
>> +       }
>> +
>> +       g_slist_foreach(device->services, dev_disconn_bearer_service,
>> +                                       &bdaddr_type);
>> +
>> +       dev_disconnect_watches_notify(device);
>> +
>> +       if (bdaddr_type == BDADDR_BREDR) {
>> +               g_slist_free(device->pending);
>> +               device->pending = NULL;
>> +
>> +               if (device->disconn_bredr_timer)
>> +                       return;
>> +
>> +               device->disconn_bredr_timer = timeout_add_seconds(
>> +                                                       DISCONNECT_TIMER,
>> +                                                       disconnect_bredr,
>> +                                                       device, NULL);
>> +       } else {
>> +               if (device->att_io) {
>> +                       g_io_channel_shutdown(device->att_io, FALSE, NULL);
>> +                       g_io_channel_unref(device->att_io);
>> +                       device->att_io = NULL;
>> +               }
>> +
>> +               if (device->disconn_le_timer)
>> +                       return;
>> +
>> +               device->disconn_le_timer = timeout_add_seconds(
>> +                                                       DISCONNECT_TIMER,
>> +                                                       disconnect_le,
>> +                                                       device, NULL);
>> +       }
>> +}
>> +
>> +void device_request_connect_bearer(struct btd_device *device,
>> +                               uint8_t bdaddr_type, DBusMessage *msg)
>> +{
>> +       int err;
>> +
>> +       if (device->bonding) {
>> +               g_dbus_send_message(dbus_conn, btd_error_in_progress(msg));
>> +               return;
>> +       }
>> +
>> +       if (bdaddr_type == BDADDR_BREDR)
>> +               connect_profiles(device, bdaddr_type, msg, NULL);
>> +       else {
>> +               if (device->le_state.connected) {
>> +                       dbus_message_new_method_return(msg);
>> +                       return;
>> +               }
>> +
>> +               btd_device_set_temporary(device, false);
>> +
>> +               if (device->disable_auto_connect) {
>> +                       device->disable_auto_connect = FALSE;
>> +                       device_set_auto_connect(device, TRUE);
>> +               }
>> +
>> +               err = device_connect_le(device);
>> +               if (err < 0)
>> +                       g_dbus_send_message(dbus_conn,
>> +                               btd_error_failed(msg, strerror(-err)));
>> +       }
>>   }
>>
>>   static void add_set(void *data, void *user_data)
>> @@ -3880,17 +4037,24 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>>          if (!state->connected)
>>                  return;
>>
>> +       if (bdaddr_type == BDADDR_BREDR) {
>> +               if (device->disconn_bredr_timer > 0) {
>> +                       timeout_remove(device->disconn_bredr_timer);
>> +                       device->disconn_bredr_timer = 0;
>> +               }
>> +       } else {
>> +               if (device->disconn_le_timer > 0) {
>> +                       timeout_remove(device->disconn_le_timer);
>> +                       device->disconn_le_timer = 0;
>> +               }
>> +       }
>> +
>>          state->connected = false;
>>          state->initiator = false;
>>          device->general_connect = FALSE;
>>
>>          device_set_svc_refreshed(device, false);
>>
>> -       if (device->disconn_timer > 0) {
>> -               timeout_remove(device->disconn_timer);
>> -               device->disconn_timer = 0;
>> -       }
>> -
>>          /* This could be executed while the client is waiting for Connect() but
>>           * att_connect_cb has not been invoked.
>>           * In that case reply the client that the connection failed.
>> @@ -5359,9 +5523,16 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
>>          device->pending = NULL;
>>
>>          if (btd_device_is_connected(device)) {
>> -               if (device->disconn_timer > 0)
>> -                       timeout_remove(device->disconn_timer);
>> -               disconnect_all(device);
>> +               if (device->disconn_bredr_timer > 0) {
>> +                       timeout_remove(device->disconn_bredr_timer);
>> +                       device->disconn_bredr_timer = 0;
>> +               }
>> +               if (device->disconn_le_timer > 0) {
>> +                       timeout_remove(device->disconn_le_timer);
>> +                       device->disconn_le_timer = 0;
>> +               }
>> +               disconnect_bredr(device);
>> +               disconnect_le(device);
>>          }
>>
>>          clear_temporary_timer(device);
>> diff --git a/src/device.h b/src/device.h
>> index 6ed8affa0d4a9274d30cac9b48e8a6826edefd64..f756fbbd4abfda467a669a38a95ddbcf586d8ff6 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -141,6 +141,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>>                                                          uint8_t reason);
>>   void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
>>   bool device_is_disconnecting(struct btd_device *device);
>> +void device_request_disconnect_bearer(struct btd_device *device,
>> +                                       uint8_t bdaddr_type, DBusMessage *msg);
>> +void device_request_connect_bearer(struct btd_device *device,
>> +                                       uint8_t bdaddr_type, DBusMessage *msg);
> I thinking in implementing this as part of bearer.c to minimize the
> chance of affecting existing code and causing regression, we have
> already struct btd_bearer that can be used to store timers, etc, what
> perhaps we will need to do is to either make struct btd_device
> definition available or have some helper functions to access the
> necessary information, in either case the changes to device.c should
> be as minimal as possible since that is already overloaded with so
> many things I don't think adding another one really helps us in the
> long run.
>
>>   void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>>                                  bool central, uint8_t enc_size);
>>   bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
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
