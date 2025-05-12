Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023087.outbound.protection.outlook.com [52.101.127.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA468265629;
	Mon, 12 May 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050966; cv=fail; b=rKAT30JyEL0UcGmq0RaQaZqKhSB0MAnpAhT5fB+0EpPBArWSfF80QQH8bFSLFq0BVEHB0mF3Ksf9rzuoUPLyKFKO01uCD65awn7rvkltUMigC90u5EKLdj6cVF7/xiI2HVa4DdSciU1p/6cqKu5B54hSkLyieZlWEWseQdsXog0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050966; c=relaxed/simple;
	bh=G2p9U0GL4TmrPDzm//wMdg2I6dWDp2tAmv1NtlWTuOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hobeM8y/uSi0uPBKNo9umyX6xg0bSaH0fLcpd6qDaXcKuyG//YXq3COrp7uhDipTzOCdrLp5eA5/kSj6gJjLpZyfJ1COXqYgNmy7zH9oqLNdFSrtiZlE7u3KZSIevHqa2ZGufuWwSdzEoD35dG/qySozf/soYmjOT3Irq5W6sn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=MepapQ6O; arc=fail smtp.client-ip=52.101.127.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="MepapQ6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi4yYKmpWRu3bt3S9imPF2zaT745UziUwxst/QVqA/dYaI5bFpPGflKCCBDCohZJicVF90fEk64aPDGeA8Hmy/6lqwJnzgOKDNDapEmllSkn5PfaTu177wzasOCvjZReXP5Yj+2kaNzIpeslrLNzTUxMJJE4edGLiS3wDGrinpBhy48U0wDmKScbcLmXaFGbzWyPRLUbPn3lwLEAlHBeM7U/LlpuwWHSLW+vPVPXHDFuckQqoNClstNzXmE0jYS5aGaZcTYpQeYMEmJM+iIpTpl1wmZ9C7ITuAI0R3DHMog/Xfn+veXDdQJmLJxHvsNKx3Vc7B7Ep+vctCRdakQo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbopu6rmir+AlMgH6Uyz0ayqw1hHYBZmuXJQzBoX0ws=;
 b=pY1PKdoIEQsv68zSdvHo7gAMeeiTL2SmVTiiFkGpjivm8UecUC1NZPcQfQarMYQMyIZtbX8iJyuU657Zb3sEG01T4SYi2NLlPCejZyn47NzdwSx5QjLynsvR27Wp6RglV4v+tT3dxp5R3wdIPuKhHzEIjULIZpirz3O73Jg7ukRkUbBq/axzzNSDrnxpXWbkZK7IuwRDD09NgyCwuBG7mLkyM4BIZir9/fBdkPHS0lxsCTFkCkkRXGDYsRMmIEiHpLs8ldj+7WhlFqQZ+JbUNa+2HazUccROiHhp+hgRmZxhrfV+4hizRCjncj4xSo5SYzwqo9MWTpFOuAWAepUvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbopu6rmir+AlMgH6Uyz0ayqw1hHYBZmuXJQzBoX0ws=;
 b=MepapQ6OgxFoR1bYAcBDN05fIAEJxFc+xn3LfvOLU3idiGujv/yLxi2VSKfTrBzjpNcaEAhUswNM1flyKLLw86qgJAmDSMMBQFMt+EBq6m4XZwMU3PWeEeObt4j3dxpoKRYiml7NGRxWO3MIUxHQF3YCKyjSDdelX7LwrMfptvgqUVFINxN0/jVs7Qa6c+KpcJHWT6zloOtPwc+XxenJW9pxpv8jdDi+RDV50PnbCTNiH3xk1UFUg7bzMXNKNfbxshTtYxI/F31nvSEIWL5hCrCFVZwCOXTc6X1JIYIuwUeqeYZp4QsUQ9p8p+2429Xaaq6M9CXEFhBNt9P2hlr3UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TY0PR03MB6702.apcprd03.prod.outlook.com (2603:1096:400:213::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 11:55:59 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 11:55:58 +0000
Message-ID: <1c4514c8-73a2-41d5-a776-2c8fbda32ffe@amlogic.com>
Date: Mon, 12 May 2025 19:55:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: fix socket matching ambiguity between BIS
 and CIS
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509-iso-v2-1-da53bd18c193@amlogic.com>
 <772853441dbc7bef7dc49741d2a76aedaf92525d.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <772853441dbc7bef7dc49741d2a76aedaf92525d.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TY0PR03MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b37178e-28de-46d0-6373-08dd914bf5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWRDRFNRaWNqV0M4Qlo3ZVV3Y2IvZ1BmWno1SWorVkhKNGhYQyswSDRRNnVK?=
 =?utf-8?B?U0ZGLzZiYVpreHFIeHJkbUNjL0M5L0szSUNtcWtQNDFickc4UG52aFd0U2pq?=
 =?utf-8?B?ZGxLMmJackpIL1cySkM3WDZOUWtHMGt6eEZtSjlqNy91UnRmSm9mYWw1andU?=
 =?utf-8?B?MUYzMTk5dmFYZzNqL2cwTSs3T1VPKzF1WU8wUGZteHZOQ1pORXJKN09zTlVI?=
 =?utf-8?B?SnByK3FNUFFmNlViY2FaVUpUVERMUFFKc0dqQjRRTlg1NytMaklIQ1BKN3pp?=
 =?utf-8?B?VFR2S3l6L3RCQnhnVk81Vk5ldUt1OHFVcjVIampPd0hNZnJTY01wRy9meE53?=
 =?utf-8?B?SHBxQ0NHZ044NHVPR0p2eXZLanQrZHJwUnFzTnNNblQ5ZllManR0M0tJZ0E1?=
 =?utf-8?B?R3hrMmE3dlUyaXBxamZ3S1hjQ3JMQ2xiaHVNVS9IdmN5S2hYSVpjQXZ5Sk5h?=
 =?utf-8?B?ZW5HRHhFZFpkZ09zamNiZlA5NFRBSllzaUM3cFRhcjEzbmxVUFprMnQwRnBp?=
 =?utf-8?B?OEY5QWlGUFBEY1B4UjY1L25NZTdYZ3VWWDNNclNVcVNTY3V0c2orVWJJemJH?=
 =?utf-8?B?bXM3MFhTOGsxTUxFNGhPUGgwMzFwR0UwSktuZXA0SGpQc3JXb2h3Y21TSXIy?=
 =?utf-8?B?RlJ4T2l1TE1uTk1ETnA5akRpK3MrK0Q3VWY0Nk9JS0kraGJMVWtVclpJdlZU?=
 =?utf-8?B?ZENUTDBtUW9XMGFhcTk2RVZUYTd6YnJSbUN4UnJpWnRIVldqQ0xOZjN3djdF?=
 =?utf-8?B?MFRhRGZZbkdmNHNwZEc1aXZOb2daTUVuQ0hNQitQUHh6cTNnZ2FnNTRMQWVG?=
 =?utf-8?B?T3BPci9ZcVQySFFncGRUNEUxSHFVS2dwWGRGanI5enY1cFpoVDc1MHM1YWwx?=
 =?utf-8?B?aFZyeTM1MVJoT0pLY2R4UUJKWW5xUWFrQUxKaWlKOTBpMnc4VCtQNGw1b0lh?=
 =?utf-8?B?VkVaL2pRdHdUTmgyVTZZQTczVlk0aTdtZ3RGN2cySVpWSVFCUEpEWnNUeVIz?=
 =?utf-8?B?ZzRpUHNkRDZPd2s4ZlJ5UkdlNVFhZGRHRnBpRkRhNUZwYlV3d3N3OGJreFNp?=
 =?utf-8?B?ZGhTVmg0NFVURHVmc21FSVo4czFLUkhIb3JQN3FRVWtiajJhQ21OMnZsM2Zn?=
 =?utf-8?B?b2p3RlgvMTRBSDlGbWpSVGtMS09lbUtTRWRMMlMrS1ZrcEhqOStRcUd3dS9Z?=
 =?utf-8?B?U2FiWmFPRDlaN0JDTmltd3FHY3ZoUVVFaVJRSHUrQSsxVVdyUWlXNG1CN2lo?=
 =?utf-8?B?VFRPSGJZNE1DYjZiSTRCZkRPUHNCbDVzM0NBbERnUWpTenI1S1BEK1h5SGVZ?=
 =?utf-8?B?Zk4vcmhmS0RrRmU5YXhHaG5oQ1h6Q3V5UFhRRitBR3lubzd5RmkvQm5OMkVi?=
 =?utf-8?B?TGUwdFAwV3dWNzVZWHpqMEhtN2FqVFVpeFlidG5KNllsckRQNk1MY3pOdVZu?=
 =?utf-8?B?ZlBaVkk2cUJ0aE1SL0RrNitBTFVoeWVBVCtweFpneEYvNEQ2U3RwYXRUbXd3?=
 =?utf-8?B?U0hiK2N2Ym5yQVo2SGd0WkhHeDFmSkUxQ3BmZGFFRTFrekhWakVYcmQ4UEtH?=
 =?utf-8?B?UmJ4d1VqT3lGelhLS3RUbkFWSFEzaWdLNzdQSzl1WEhQQXV5SGhpKzBuSXZq?=
 =?utf-8?B?VlBtdlpONjBmOEVrT1hBakJHdGh5ZVJWTXhVdmxMMnkvWHFPZlA5ZFYrTkNM?=
 =?utf-8?B?b0RpTGI1YVhyaGd2dFBYOGFPM3Z2YmpCM290czhmQjJqekNFQTd5Tk1rK3lz?=
 =?utf-8?B?Yk13THVPNnBsR0JJVWw4ZmNIWnByYzhVNFJ2VFlGWndKcFpvN1ZxOVdLeUs5?=
 =?utf-8?B?aE82NW9GVE1PLzVBMlZKNS8yeFM2Q29UNzJZdExRQ0pQWXc0djVMQlluckIz?=
 =?utf-8?B?OXhPVG1yRFJRVXhNNHNGOFFKZVlPY3VudHZydnMrV1VLd3V1c0k5RWpNejB6?=
 =?utf-8?Q?B6/T6iaVbDM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZVVUk2RkZQY0s2VUxOdUtvYURWSS9UamcybFBDSW5Sd0RQTnhyWkNuN21M?=
 =?utf-8?B?MVU1eGFaZElRN3JJREJ4U3Awc2JLQ3p5OVJSK1BSckxGMXBKNHBabzZ6R1Vu?=
 =?utf-8?B?cURRa0RyUWUxVEpjQzh6dkhnOG1OQ2xuYmVTODVmak8zVkgwT1FXZDJZeXNS?=
 =?utf-8?B?UXpjZlF3WWdMd01rS0ZjY3hIZ1pWdGNKU1B2V0Fka00xZWtFL3ZUN0lxUlF0?=
 =?utf-8?B?Q1Fib2o0WjIwNUdMRDhFTERxYVphenhNNkt4UUxPMmplZzZNTm9xQVRTSG9o?=
 =?utf-8?B?OG5yOUtxckFxc1crNWpoOVhxN3htTmZqMnBUeGU4Mmp0M2wxcVZuN1RPYXBS?=
 =?utf-8?B?bDR2dE5EMUtJYVpNUHFIZmI1dnNDcDdWb01sZ0JjSlVlVTdlSk1tayt4OWZP?=
 =?utf-8?B?S3VXZXpEcTQxZmd3TExjK1NLeFRzQ2VCZEdMcTNaK2pOMStpTEdOb0gzMGFs?=
 =?utf-8?B?MWRTdnlIbXpYRkNvTGdDZTBuc3E5SisyY1hxYml3aG50RHBEN1ptOU84UWhZ?=
 =?utf-8?B?cmdGWExvUkRCUkRQUnBOOFoxaURMMlB2M1llbWd4SlBwRnlQWk5XNVVYa3Rp?=
 =?utf-8?B?R2RZOWMzSHY4bjdBNXN0eTc4MHRScDJDbXlxclB6WDU2Tzd6N1UyVVJnbmVs?=
 =?utf-8?B?ckVZRXlqMWIxZ2JRcEdrNG1JRnAyUllYZ3RJVllSVCtuOEdEck9EV21SbjJl?=
 =?utf-8?B?SFJpYWR1WjM4c1ZSVTY1N25qMXpIeGJ0NVBzdzNnOW9vYzJ0ZHVZb1BTd0l1?=
 =?utf-8?B?MXBkMllWUlloV2w5QjlobGlXbVRBclpJR3VlUk8yMng3ZnJoK3d1bmE4aGoy?=
 =?utf-8?B?c3JTRmI4Q3QvMmtsb2E1RW1pcHRrT2tpU3pIejY1Q3pqNjVrNUU5b0FKQkZS?=
 =?utf-8?B?c2luMjdOL3lkWGpzckJVaFlsdHpvTTZIc2FRM1dlQWZ6Zk9lVnZpUjdQTUZp?=
 =?utf-8?B?UmtuZzNCaldia3RMNkwzcCtiWFBFd1JyUWxsS1h4TjlIWUZ3dVFpUTRjYTFa?=
 =?utf-8?B?dTgxcTl3WUFXVVRxVGVUOWo0ZnhQY29KaE5obzN6V0RvelFMN0hubDA2ZFZu?=
 =?utf-8?B?Rm92SXF6UFViS3pwL2Z1K3A1MTQxemNRMkp3NTBEMzR1TkV4T0xHckVYUnV6?=
 =?utf-8?B?YnFCdWsyays4YXJMRy9ObHl3dVhLeUt0ZWFqS1ZWWFdLcFE2bUNDa1ZxRGdl?=
 =?utf-8?B?blYzR3hOOXpQcjVjV1JiM3lFbkloZTR4NjFLZWZJQ01OSVdpTGpvMmM2ME1a?=
 =?utf-8?B?SlRsZ2I1NFNEYWN3SGQ4NDE3U2pVWnMzakJ1M0Q1a21QbWNxYldXUzhSMmNt?=
 =?utf-8?B?dFdOOFAvdUZ4MzdJVE1kRkJQdG92MXpZQ2FCVzlmZ2ZVK3RmVnpQeVk0NW85?=
 =?utf-8?B?ZzIrUUIxSlRINmRRNVZnRXJHM0JqdVAwVFFCOXYyQVdNakpVWU40YjVTK1VT?=
 =?utf-8?B?UDQ0dDl2cHVmRDd0NURlZWxiZ0dQUy9MSis1M09nakxrZ0ZqRDJENVBvUWxi?=
 =?utf-8?B?YU9FRzBUQmN4dGRnQXpXQThtKzhQdER1VG5PN3pkcWNWYWE2SFBaWjB3VUFW?=
 =?utf-8?B?MEc0QXdHeWYxUEc1Y0JYRGhhS2ltb2grd0lPbzNSRWx3dkNFTWZCMm1sVzc0?=
 =?utf-8?B?TlBWa2tPd2R0Z3BlaVhvd3dUcEZERVFEcXhJTUs4NFNQZ3kxK0c3Yi9rck5u?=
 =?utf-8?B?WWpXZmJHckxCZU91TktvUldnRThuT0Y1a09HbzVZdG9jTS9aRDdNb0FYVWxU?=
 =?utf-8?B?VVNTVXFnejhnQ0VVVmVIMXp3NU5SUW12bG41UlBlRzgrOXg3OVp6WmNMQm40?=
 =?utf-8?B?bDdvMzFXNzBDZlhMZlVrTFF2UllyOWtzQ0NrQWVJMFBTMHk2blRPL0YwOFJB?=
 =?utf-8?B?dlNDQi9HU1RkaE1BaDdpN3h6eXhBR2ZJSTh4eVRBVFBUOW4vTzZoZVhmcm9Y?=
 =?utf-8?B?bldUNC9hd282QXZoNm1SUi9sNnYzS2V2eXVnUC9rTGhEazhQTW9JN2xEalhB?=
 =?utf-8?B?d3RGVThYY3g3clg1S0FHUzBBamZoUlVxeE1rZ2d0SWMvQTh1SEZ4VGVXRkQr?=
 =?utf-8?B?Q0RSQlZkL0lGcXRIQm1maXJiVk5wN1BWc2VZVFlOQTJ6WHpRT3krVkwzVmw0?=
 =?utf-8?Q?uwITaC0pi5vtOoBTh66gFBIQy?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b37178e-28de-46d0-6373-08dd914bf5ad
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 11:55:58.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTOjQfu6wRHQMqV3HTAiKOabruWFpkAo7NL+azULFqkM51y9xLwwjcj9Sht0Gjtm40eLtJES3WYmhFrqhBJtZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6702

Hi,

> [ EXTERNAL EMAIL ]
>
> Hi,
>
> pe, 2025-05-09 kello 18:17 +0800, Yang Li via B4 Relay kirjoitti:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the DUT acts as a sink device, and a BIS already exists,
>> creating a CIS connection can cause the kernel to incorrectly
>> reference the BIS socket. This occurs because the socket
>> lookup only checks for state == BT_LISTEN, without
>> distinguishing between BIS and CIS socket types.
>>
>> To fix this, match the destination address (dst addr) during
>> ISO socket lookup to differentiate between BIS and CIS sockets
>> properly.
> Does it work if you have both CIS and BIS established between the same
> two machines?

Yes, it works.

The DUT functions as a BIS sink, synchronizing with a BIS source to 
receive BIS ISO data. Simultaneously, it establishes a CIS connection 
with a K70 smartphone to receive CIS ISO data as well.

>
> Now that CIS_LINK and BIS_LINK are separate hci_conn types, it could
> make sense to introduce `__u8 hcon_type;` in iso_pinfo, maybe set in
> iso_connect/listen so that also the socket types won't be confused.


The |hcon_type| can only distinguish whether the connection type is BIS 
or CIS, but it cannot be used in the |iso_get_sock| function to 
differentiate between BIS and CIS sockets.

>
>> Link: https://github.com/bluez/bluez/issues/1224
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v2:
>> - Fix compilation errors
>> - Improved the problem description for clarity.
>> - Link to v1: https://lore.kernel.org/r/20250507-iso-v1-1-6f60d243e037@amlogic.com
>> ---
>>   net/bluetooth/hci_event.c | 34 +++++++++++++++++++---------------
>>   net/bluetooth/iso.c       | 12 +++++++++---
>>   2 files changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 66052d6aaa1d..6b26344ad69f 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -6413,6 +6413,8 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
>>
>>        conn->sync_handle = le16_to_cpu(ev->handle);
>>        conn->sid = HCI_SID_INVALID;
>> +     conn->dst = ev->bdaddr;
>> +     conn->dst_type = ev->bdaddr_type;
>>
>>        mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
>>                                      &flags);
>> @@ -6425,7 +6427,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
>>                goto unlock;
>>
>>        /* Add connection to indicate PA sync event */
>> -     pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
>> +     pa_sync = hci_conn_add_unset(hdev, BIS_LINK, &ev->bdaddr,
>>                                     HCI_ROLE_SLAVE);
> Do these make the update of conn->dst in iso_conn_ready() unnecessary?
>
> It should be documented somewhere what are the different types of
> BIS_LINK hci_conn that exist, and what are their invariants...


The pa_sync structure needs to retain the dst addr so that it can be 
used later to match the correct BIS socket.

>
>>        if (IS_ERR(pa_sync))
>> @@ -6456,13 +6458,6 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
>>
>>        hci_dev_lock(hdev);
>>
>> -     mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
>> -     if (!(mask & HCI_LM_ACCEPT))
>> -             goto unlock;
>> -
>> -     if (!(flags & HCI_PROTO_DEFER))
>> -             goto unlock;
>> -
>>        pa_sync = hci_conn_hash_lookup_pa_sync_handle
>>                        (hdev,
>>                        le16_to_cpu(ev->sync_handle));
>> @@ -6470,6 +6465,13 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
>>        if (!pa_sync)
>>                goto unlock;
>>
>> +     mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, BIS_LINK, &flags);
>> +     if (!(mask & HCI_LM_ACCEPT))
>> +             goto unlock;
>> +
>> +     if (!(flags & HCI_PROTO_DEFER))
>> +             goto unlock;
>> +
> Commit message should explain what this reordering of *_ind after
> pa_sync lookup/update are for.


The iso_connect_ind() function needs to locate the appropriate BIS 
socket by matching the destination address stored in pa_sync->dst.

This is just a position swap and does not introduce any logical changes.

>
>>        if (ev->data_status == LE_PA_DATA_COMPLETE &&
>>            !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
>>                /* Notify iso layer */
>> @@ -6993,6 +6995,8 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>                        set_bit(HCI_CONN_PA_SYNC, &bis->flags);
>>
>>                bis->sync_handle = conn->sync_handle;
>> +             bis->dst = conn->dst;
>> +             bis->dst_type = conn->dst_type;
>>                bis->iso_qos.bcast.big = ev->handle;
>>                memset(&interval, 0, sizeof(interval));
>>                memcpy(&interval, ev->latency, sizeof(ev->latency));
>> @@ -7038,13 +7042,6 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>
>>        hci_dev_lock(hdev);
>>
>> -     mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
>> -     if (!(mask & HCI_LM_ACCEPT))
>> -             goto unlock;
>> -
>> -     if (!(flags & HCI_PROTO_DEFER))
>> -             goto unlock;
>> -
>>        pa_sync = hci_conn_hash_lookup_pa_sync_handle
>>                        (hdev,
>>                        le16_to_cpu(ev->sync_handle));
>> @@ -7054,6 +7051,13 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>
>>        pa_sync->iso_qos.bcast.encryption = ev->encryption;
>>
>> +     mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, BIS_LINK, &flags);
>> +     if (!(mask & HCI_LM_ACCEPT))
>> +             goto unlock;
>> +
>> +     if (!(flags & HCI_PROTO_DEFER))
>> +             goto unlock;
>> +
>>
>>        /* Notify iso layer */
>>        hci_connect_cfm(pa_sync, 0);
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index 6e2c752aaa8f..1dc233f04dbe 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -641,11 +641,12 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
>>                        continue;
>>
>>                /* Exact match. */
>> -             if (!bacmp(&iso_pi(sk)->src, src)) {
>> +             if (!bacmp(&iso_pi(sk)->src, src)
>> +                  && !bacmp(&iso_pi(sk)->dst, dst)
>> +                     ){
> Code style issues here.
Will do it.
>>                        sock_hold(sk);
>>                        break;
>>                }
>> -
>>                /* Closest match */
>>                if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
>>                        if (sk1)
>> @@ -1962,7 +1963,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>>                }
>>
>>                if (!parent)
>> -                     parent = iso_get_sock(&hcon->src, BDADDR_ANY,
>> +                     parent = iso_get_sock(&hcon->src, &hcon->dst,
>>                                              BT_LISTEN, NULL, NULL);
> I think the code here would be more clear if it's refactored to handle
> hcon->type == CIS_LINK and hcon->type == BIS_LINK with explicitly
> separate code path.
>
> What happens here if we have a BIS listener socket for `dst`, and `dst`
> initiates a CIS connection? Won't the CIS connection get resolved to
> the BIS listener socket?
>
> IIUC CIS listeners always have dst == BDADDR_ANY. BIS listeners have
> dst != BDADDR_ANY.
>
> Perhaps there could also be `__u8 hcon_type` in iso_pinfo that gets set
> to CIS_LINK or BIS_LINK in iso_connect/listen.

I completely agree with your point that |hconn->type| should be 
specified for both |bis_listen| and |cis_listen|. However, I believe 
that the destination address (|dst addr|) should also be provided. Since 
a CIS connection is based on an LE connection, the |dst addr| must 
already be known at the time of listening. Similarly, for BIS listening, 
the |dst addr| can be determined when the BIG Info is received. 
Therefore, it is possible to know the |dst addr| at that point as well. 
Moreover, if multiple BIS streams are to be supported simultaneously, 
relying solely on |hconn->type| is not sufficient.

So, if we can set the |dst addr| during the |iso_sock_listen()| call, 
there would be no need to assign it later in the |*_connect_ind| functions.

>>                if (!parent)
>> @@ -2203,6 +2204,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
>>        } else {
>>                sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>>                                  BT_LISTEN, NULL, NULL);
>> +             if (!sk)
>> +                     sk = iso_get_sock(&hdev->bdaddr, bdaddr,
>> +                                       BT_LISTEN, NULL, NULL);
>> +             else
>> +                     iso_pi(sk)->dst = *bdaddr;
> This updates the listener socket dst address with that of the
> connecting device? I think what is set in bind() shouldn't be modified
> later on.
>
> Isn't this wrong for CIS, won't it block connecting another device?

Yes, exactly. So far, I haven't found a better approach other than 
updating the CIS socket's |dst addr| within the |*_connect_ind| function.

Thanks~

>
>>        }
>>
>>   done:
>>
>> ---
>> base-commit: f3daca9b490154fbb0459848cc2ed61e8367bddc
>> change-id: 20250506-iso-6515893b5bb3
>>
>> Best regards,
> --
> Pauli Virtanen
