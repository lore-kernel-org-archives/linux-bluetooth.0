Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023119.outbound.protection.outlook.com [52.101.127.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6ED1DE3CB;
	Thu,  6 Nov 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395699; cv=fail; b=WyWi33q4FYCCbC9WkXVdtycChegzSMVp8PPrBxkC/sui9jfoIpl7zIqB084B37q1GaLGUFb9fj1/MWP1fN8AOiYGPDb7yz7UagMmJc+b0czMTuNjLgdU5s6yQ1fok9EDl/AqJqzCo42jDBSTGoxPxpxyUtdQKhphbPgNOHx7FOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395699; c=relaxed/simple;
	bh=1lleJKxSaDsEAU6k7t1sfLPDjSOhkcuQlqCkvmEj27g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YG10WT/bLhdPc9TVog9xieavhe7G8hkuHagxZKt5bohApmfvi/cvT2l4OagQ/4tjwmzHkRnuxAmVrTveiEl3i6DbMJ2KQprtdJNhjZbRm8Bh3l8YevNZ35nYSWhYUKMpY6oAxa0AP7nJYLDQZ6lpdhHIIwKSFZwZMMlYjR1avOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=YDBZeHgi; arc=fail smtp.client-ip=52.101.127.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="YDBZeHgi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIIdUh1B9/FOPX6jx9PgRORe2F4Eci/zTmQh9+XmNAf1uxyGRA/GQegwkpZ0WeswcppvYe1xRb/1g+npkGzsLzhUKySKx91wCs5+TgZXKC6zq3xKPVapGS0BKWwFLcRpYZV2NOOocuRpPbMxypmLt4sNpFH6wwz1tFsJj11NR4oTGNQ6mPUu4gLXeb6jtGCdH6HZCcccuIAO4/WDmb6Z7CMdshQ+P49KkhArMKnxpgPxt4dQ6CBiZVe5hCtkN1op8tGHrTffK/GgcxcvGkzFC466RUzUQJwwwJQTMrWG3Z63qt1jzAjblmnSTj2+AwJE5xqWepBcq9wtE9Y8G7KRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCTLcDtVpGXrub7lJa2J+zqDditoLplGsivwqhpTCec=;
 b=mY73ihcWoRTsqbnPdPGzKoyeG5Jltf9Y63EowaaKe+yETctAM3USZQDNDEmrIUhuJlgBRnyOvmqj92D85xDZzaWhm3/Qa+3JFxjI/pbPykdNDmD9w5xK6bNWcTru0XH9MbiZb9ZdryRJtKg2qdGR43ZS+OYKASr9ZsIeDYY8RdDhBMAd7XmX+GZKwJW4xxAgJ0tUfynPKnpgWZEp3FeL3xtFykfFQvwwMPUIh1EKy7/hIhftnGzgUjFlrX34qfK6bLprxOt6SOiAUCIXDER/9WgHekgdWHkmX+aEYjQFlnNERWeKjAq2X6HZ/WnNZezlOJgbe+DqC7f++YMZICOukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCTLcDtVpGXrub7lJa2J+zqDditoLplGsivwqhpTCec=;
 b=YDBZeHgiA9L05ODTUaCNQGvEdwZ6KoWf3ATFcpveVdqG/id6cof7jkhOHEeRCNDqLXEhhthh1uFnv4cec/neXy3VegMLYGRSdS+LaxZ+MvOCi1hTRsMN01v3b4aRYKGtru2V4qTF7tVHrqSJH1/ETCe6PMKeGsC6JQCFVMA8F8RRn288X1ovACh3fMWFcmp31CWCwyFSC7KejDpH/JfPmDyXQLVfqbGRZUV3U7HK0f65PPYIAxzkNzAhQBAodzdTZNAil4dTqKXdzM8t4ub+CmKcHsrzRinWmDdaE8CFwjL0aYyefUEFSNgWAYCNvGl56pEsN/IOwukDOHjptybnvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB8033.apcprd03.prod.outlook.com (2603:1096:400:45a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 02:21:34 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 02:21:33 +0000
Message-ID: <0aa28372-feea-4252-a498-b3b8be7617f4@amlogic.com>
Date: Thu, 6 Nov 2025 10:21:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: iso: Fix UAF on iso_sock_disconn
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com>
 <c6f8f015-267f-49e8-b427-b4524c134bfb@molgen.mpg.de>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <c6f8f015-267f-49e8-b427-b4524c134bfb@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7a3ad1-d61f-4edc-6b44-08de1cdb3409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGFQdGtoWmpyblE2NUZGT0RiZmwxU2JOd3FyT29Ea3pHaC9PbGhLaWQ4TlNS?=
 =?utf-8?B?Rlp1VVI3UWF2MUFUQ0VKUi9ZdWFEbFp5UGgvMWlMS2hQaldTU2xjbmFmTFFE?=
 =?utf-8?B?WVRBZFdrMnBERG5DZzgrSVdzSDJ2MUVoajExUUMzUSszMHZQejdTZyswdzZk?=
 =?utf-8?B?dWR3OTMrbDIzc1pXWmFxWVYxUlNUWjI5YjBvRmlMUkkxU3Iza0VYaUNtWmwv?=
 =?utf-8?B?OUtTbWIvbktXb1JweU9GZ252eUVFNzRkb1ZtQnNuTUNCMEduRTlqZjhwK2Zs?=
 =?utf-8?B?dDJodGEzQWQ4cStTUWlCcDhzQkJzdEFSd3J6TEkyUitzYm43QWxSUFVQQkor?=
 =?utf-8?B?ZzUzMW5WNFVMbDQyNWxJeXhaRzlaWEJDT3RuNTJ0enQwcHU0S3U2YjM5NlpC?=
 =?utf-8?B?K3VLRTV6enEyMEVzcDg2cmZSNkRoZlA2MlgvSWduUlhhcGIxK0NqTWllcmJH?=
 =?utf-8?B?djdKR3dCUk96ZGFsRnRRcHF2cUJwRmszNk9DTzQzcnpyQisxd3NGallkUnpr?=
 =?utf-8?B?ZW16Qk5RZk9Cb1h6QTlERndWNk10bEx1RU5zQURKRmtKdnpVVG9QWkc4RXhG?=
 =?utf-8?B?TDA0bTlZODFKNWhqekJIbVFUd3IxSksrbkx2TlBxTGQ0NDhJUC8yR0NiZngy?=
 =?utf-8?B?MDBJSzFOSmlyVGZvYnE0MmllaS9IMUZhcENNMGd1V05ya3JhdE0vakRRa1FL?=
 =?utf-8?B?QVRLVDU4eVN3ek1pNGxRRDNidkVPMHVPS3FDdUROV0R2L2FpY1JaTE0rL1RS?=
 =?utf-8?B?MmZxRXB5TU9ldFV0bVIyb0hYL01LbGZXS3lnbzFVVlVTUHFKempaOU0yaHZM?=
 =?utf-8?B?NWdtNGN5Y242WndYN1RzQytJY2gxUWtvVWErNmpNMVgrN05TMURWd0p1NjZv?=
 =?utf-8?B?b0tETkthUEx1RDFVUEY1aUhJZTdDRUxmQlVyVVhQN3VlOGxzYXhSakRqTjJt?=
 =?utf-8?B?cUVnb0UycXRxT3VMSnBRYjNWM0lTQ0ovQnovNE1HaUJWaU9hUE1nRHFsOHZr?=
 =?utf-8?B?bi9UQWFVTGFMK0V1SVFTTmljV0NHb0RqUXhlVW9KMEpqL2M5cTRyRTArOXpp?=
 =?utf-8?B?VlRrS2tRbERvRmNqcExNeEUyNmhMT3d5dDhWMnlGV0pHVlN4Q1ZSbjh4Uk9C?=
 =?utf-8?B?ZU5aR0kyTGpZUmgvc0R2MjN2NzNFZHpEMURMWHhBanFwZzF2NEF0OGVJMmZu?=
 =?utf-8?B?TVhhTG13K0JFQkh6TzViR3Vib0tiWGtJUnZqVGxCZDJWQjhzY0NSeUdVeGYx?=
 =?utf-8?B?dFhCa0NPYTVCQlUzRDBvV3pEeUwraXpiM0ZZeTRUbUpPYi9GcVEzWEwxWi96?=
 =?utf-8?B?a0tGamtrTmlGQUFQSG13emhxSFZhVDlGWU1ackgrZm9INXBTWVc0M0RlS1Zu?=
 =?utf-8?B?b1hXMENTcTV0djk1bWxKOWxCcWtaK0x0UXNKbHVnRDZSUGlvdWk5ckFJeU5i?=
 =?utf-8?B?Q2VzR1ZkTFlwcnQzNUJ0M3FXL3pLcHY4elY5S014MnhNbUpqZzFBNVlHZnpp?=
 =?utf-8?B?ZFdQSm1wcmtOWmcxbTIzRWVWSHhxRmFUSFZ1TXVORFFaRU84R1lBQmRicGx5?=
 =?utf-8?B?ZitaZU43K2xzbkZEbHNCeXk1cEVOYjE1Rkpsc3FIa293cWhoU0k0b2FtQWk5?=
 =?utf-8?B?UUdYa0lkbVNaTlhYcXhkd3lsd0grVlRGZGtkbkhvazZnUllPeGpzbnlPc1Fj?=
 =?utf-8?B?cXhSdmgvWWtDOFY0anJabFNHQXBEWVA1eDJCM3dmeWJRRjVUSHNMdmdjSno3?=
 =?utf-8?B?TW5GcGVzdFhLNmNZcDM3KzEvcVlydWNSKzFVU0lpencrYXdBZld5NVdubEs5?=
 =?utf-8?B?ejFSeU10cVFpc1Q1RXIwMjdDVjVCUGR0dHB6d3A1TlpBYm1PT2l4MmlCdkdS?=
 =?utf-8?B?SVVaOEFRWklmRDdCVGFCUlpiZzNBeFJxdHJhMTV0cngvOHNEMC9XeFdqRDlZ?=
 =?utf-8?Q?nmha+M/hSG5rjaO6KiF5yl+WMtwWzt7B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzRCc0x1eFJZV0pyQ1VhUThmVklGd0pXTHMxaGFiTXN4bE1meTRxbFdwTkJo?=
 =?utf-8?B?eStGOTlFNlo1SUVJRlhlRUN5Njdmd3lFYndZbWg4c3N4Vy91SVp5YStMWVZh?=
 =?utf-8?B?bTAyUHVzS3p0SWhYcUt0d3VqMDhNZEVtdGdVeHJreVFya05RK2pJV0VKMkhk?=
 =?utf-8?B?TFFSWUx1Z29Gdkd2NE1yQmlkNm5McWV1UEhxb3pnS0pQa2o1eFVaajMvVm96?=
 =?utf-8?B?VFQ2N3FrTlRGbEFCU05VWEtmQW5ZYjFjRUNoYnhvSXhhMlFxWW42UXVoTGZ1?=
 =?utf-8?B?a0FBNFlLeXpBRmZrNGtDL3VVM1VNRmxjT1NtSnZNd0ZVT2NVUUJwRkZXQ25L?=
 =?utf-8?B?dzRDMTJxUWdWNmJZWENTd0I5bGYrOTBDVW5xajMxSU5YOVUwWjZGMDV6SEtl?=
 =?utf-8?B?dUx5K3I1akpCSG5kSDNSMTRSM1IvU3k2a21SZ2lUUDY5dmVhc2RId2pCQlRY?=
 =?utf-8?B?QkRESHRFdzhtL2JvcU1wSEk4T2ErVElyemVMZlBoQ3FXelVDeEp3WDRxNmp6?=
 =?utf-8?B?MVh3b2J2UFB4SnpFeUlxcUFJYm5XQjJwSFQ0L09UL2JNdnhrTTM4MlExVm5X?=
 =?utf-8?B?OUNXL1dReUFQT1RwMDJ1WUJDUm9JZExuTmxuQzlxblo4RENPRTR5Vkd2K1lB?=
 =?utf-8?B?SkR3akJPOE0rajNMUi9vakk0Nm9CeTVGUXRsdWpJb2Y1eU9uNW4xTGZPTXhE?=
 =?utf-8?B?UlZxQ1cyQTJ2ckNXZTZHbmtUVGlKQ01Dbm44bjc5UGpUTytBOGRVWWY2Z0tX?=
 =?utf-8?B?Y2xLdEVmQzR6OXhqaFVab2I5eGRybk5NOHV5VnhCUW04K2RGbkl2eXBRWTBj?=
 =?utf-8?B?R2s5VFN1Z1VocmUvdkZtQnVYb1h2OXNJalMzQkFQQlVQMFVJcmh0cE95Y21L?=
 =?utf-8?B?bGhGYjVIa0w5dFJnazY4TVV2U1dRbU04cFdFcmV2Nkt1dXYzYXNWMTM1SzRu?=
 =?utf-8?B?OWtzZlZCWUdkbjRlTEhWcFdaS2lRSVk3Smx5WlVWS3ZlUHFKZFlZdDZlRVRR?=
 =?utf-8?B?ZkVBUUlHc2NPR0FGN0N5RkluZFUycVBWVW01V3V5VVFESUZhN2J4cXJVQzdZ?=
 =?utf-8?B?eVhvL2hrNFRGVGtRZmF5RHl6Q3RJUXRSQ09EV01HRnA1TTVwdzc0Q2dWZmxF?=
 =?utf-8?B?QkQwN3JGaVVrVHlpSmlHM2lNMTgzaW5zdC94Y0JLUWdNc1B1QVdUSmkydWl6?=
 =?utf-8?B?M3FqaDZOOXZCZWlmUG5EaTR2c2R1VTRTS1k5MGxkZ3A0RVNIK0twcStWb3B2?=
 =?utf-8?B?RFRFMEh4VHlYTHN6ZitaUUFPZ1BOTjUwT0Z6YUEwbm45VmdZTDBCZ0VtRlBD?=
 =?utf-8?B?c3BYcm1JRWRBMHJsWm96aEhvOUtEME45MXdNYjU0ZkhoOHYvYWJIQjBnaExt?=
 =?utf-8?B?V0xVV3RtL2Y2UzlHajlXalhYdkdweXUwRjRwRlNIbUNTcjFZL3dRUzZkTmx1?=
 =?utf-8?B?VEFmb2VGVUVFazRnLzRMUDY0blorYVlMaDFGM3dSNjZVME1CWFNyUTExRU9H?=
 =?utf-8?B?UFhZQlBsUnY2YjA0V1gvYk9vY2RDOXFTWDN3aGpaRm92ZkIyaTRnL0EvNXVK?=
 =?utf-8?B?ZENEZFp4bXhhYkZrZkNCSisyb1M5dXFJbnM0aDBiZXhiK1QrZlBEODRXYWFJ?=
 =?utf-8?B?dGxtK1IyK1NyLzM1OU5nbUptL2xVNDlnV3FmUHI3OWdTVy9NU1BxUHlacUhJ?=
 =?utf-8?B?MHZQQXhMazJ5ZUdCcnFteDZvUC92MitVczZlRHBnZDQwRjdKMmpkMGpVWWpy?=
 =?utf-8?B?V0h2RW53TEdhc3lMbm1tNENSbWxVQkJIa1dHNTNpcnpMV2loVXZ5S1lqRjVP?=
 =?utf-8?B?eDRsWUJGTjBRRkVJbDJEeFFJNEttdEYrK2VlZWFSbTVWSHdEM3RtcGM4Y3RL?=
 =?utf-8?B?ODJpanhLeTQ2eElIMWRXdythOFFJUlRibWJ0elNKaG9iOTNQN1J5VXBlV3JU?=
 =?utf-8?B?L1NIbE1UaWNKOWRmaFNzdkx2OEUwVkJ6M1lOV1dNWXlpZzgvREpKN2QzSzlw?=
 =?utf-8?B?elllZGdwK3hkOHpOaHhpMmRRSU84SElyV3Rpdi92SkxXdERnOTNscCtlOWlG?=
 =?utf-8?B?T2xlZFE4SFE3RVQ1VENzZGJ4ODBzWU04d1NoVEJRMkJWVy9JTGhIeDkzdXlW?=
 =?utf-8?Q?HA2+9faYT4rX501DLN3363eyb?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7a3ad1-d61f-4edc-6b44-08de1cdb3409
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:21:33.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgZDqcdyJ+XPmERYKALe0dvfDEkvBX0Mvampq9Zsmq1EMfuQAje3PcvGRXSb0OtBSFOGP7FZa4wwhViEl5qCVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8033

Hi Paul,


> [ EXTERNAL EMAIL ]
>
> Dear Yang,
>
>
> Thank you for your patch.
>
> Am 05.11.25 um 10:02 schrieb Yang Li via B4 Relay:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> kernel panic: Unable to handle kernel read from unreadable
>> memory at virtual address 00000000000003d8
>
> No line break needed in pasted logs.
>
>>
>> Call trace:
>>   iso_sock_disconn+0x110/0x1c8
>>   __iso_sock_close+0x50/0x164
>>   iso_sock_release+0x48/0xf0
>>   __sock_release+0x40/0xb4
>>   sock_close+0x18/0x28
>>   __fput+0xd8/0x28c
>>   __fput_sync+0x50/0x5c
>>   __arm64_sys_close+0x38/0x7c
>>   invoke_syscall+0x48/0x118
>>   el0_svc_common.constprop.0+0x40/0xe0
>>   do_el0_svc_compat+0x1c/0x34
>>   el0_svc_compat+0x30/0x88
>>   el0t_32_sync_handler+0x90/0x140
>>   el0t_32_sync+0x198/0x19c
>
> Please add a paragraph about this problem, and how `iso_pi(sk)->conn`
> can be NULL.


I will update it.

Thanks!

>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   net/bluetooth/iso.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index 74ec7d125c88..89c7700ceb81 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -838,14 +838,14 @@ static void __iso_sock_close(struct sock *sk)
>>       case BT_CONNECT:
>>       case BT_CONNECTED:
>>       case BT_CONFIG:
>> -             if (iso_pi(sk)->conn->hcon)
>> +             if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon)
>>                       iso_sock_disconn(sk);
>>               else
>>                       iso_chan_del(sk, ECONNRESET);
>>               break;
>>
>>       case BT_CONNECT2:
>> -             if (iso_pi(sk)->conn->hcon &&
>> +             if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon &&
>>                   (test_bit(HCI_CONN_PA_SYNC, 
>> &iso_pi(sk)->conn->hcon->flags) ||
>>                   test_bit(HCI_CONN_PA_SYNC_FAILED, 
>> &iso_pi(sk)->conn->hcon->flags)))
>>                       iso_sock_disconn(sk);
>
> This diff looks fine.
>
>
> Kind regards,
>
> Paul
