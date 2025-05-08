Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022130.outbound.protection.outlook.com [52.101.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BA33FD;
	Thu,  8 May 2025 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670034; cv=fail; b=JGnfRSrFeoKa3ircv6N5p8RORYLPaJXUAl681bERQ+GqoTnn9LAPhUDNR4eqbO7DSCiq6yybhespDuR5bq/fhSFVjZYSIsa1LvPMDrGuue+aj+9HIoW8WRges55c5CNgFJwaA+QWrLihLzAb06jiBPrj1ja1r9qyASHpzBL8Kd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670034; c=relaxed/simple;
	bh=1YzBgA5TtDi6TTvhVWRH+lrG9TDqrpFSg+X+kjZRY5c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UiHfBfxj7E4CPdAUFfEw8OfYI8Lv0gvsuhEPoSVdGOpJfC6q8cs98WLFDll1TQYnCD5YWwcHEy3K6XC3JRcPMruPVqKEGVtKxodU75O9zKAdEXigME9owbpn/xwPnLgIr/K9RNvsratuVdPuNjVc9ewYAOt7A4HoP6qILvgYHvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=RAaG6q2v; arc=fail smtp.client-ip=52.101.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="RAaG6q2v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkYYLFssvkYqOodtWhlwRJH5jvjtwQdGwxou0ZhAlcpjR4sWOU3sbLWcTdZMoJJEUO/+/eEWJ+omBbG9ylB1wqyEJCJlGWXd5FU6qPtON5K4TUsxs511CnDcm3Yq9D9gqeRlHQKvFyxuzz6nzS+AFI/P79Kx6lN3kY/RyQ0DyxkuRS+rQJXy9FyTviQZ+zwOBb3H0eG0MQJEXN1X2iCixWyo2LsxB4iTZQAMERYJDsw21QlqFaLsQiMS4vGmU2gVKk8A6Rro2c7d1L3yaGe7TvdeXK/qqdjUoTfVPINiYsQTRdLiWzKuA3KBfXmP1yugZi36uNTS/tGU9WVwukufSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTD9Pv33j/zFEJFRKeqTYwcCx2JIS7v2kpdeeNUlJiI=;
 b=jJ7cK9pCweqTQQQ0QZJOAMkykF+f6LA+j5aPMqnrKueAPEg3N3obCTQYE1l1eD+MaXo30IscALXnweDh3c+S5NahhZ4QSDT72sJuS9bMKd5yS8G+LRdmsCpQRYAtPm3HkF3FFSNCxEnwf/KbvxYBenA75DhOBi6vQIT2gT8qbc7P7j1RTVY13VXgyrOl0iJ+T/GJYwNfKZv8+twFhOiGR8UcD+byTfcpDdimOmp6zrgWvhUtHjnoC3e3W/p2KMid7kIIETfUAfGWp3IYPCRpiIuBB4wcv23TBKUCRZLvrO3GWcXpSRtl/Ud6qMj66exhdNgF2Sk0vhQNl3TwCkTaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTD9Pv33j/zFEJFRKeqTYwcCx2JIS7v2kpdeeNUlJiI=;
 b=RAaG6q2vy/RoLZeW5XZWdvDXNAqkeQBhPnEkxtlw4PrndhrF0Zn2sQVZ33rOsHUlQnrqz9hOZw6tC1Ph18mytoovNP/zH2iWvWZ62I4+9QXsS+AD3ImbMT24tndHLs/LSCpc9drXIPXH+mL5NJvJxCP2Fm+VVxTi5z/j9/UOvzhF+CqDoycDTD49xMAKrTQY9iEv2HivtxpspF65v29hett6JF+naL8ku1RzvXlMzf+ZEXcez5Ij/F2+bwNxmxL34hbzcRmV/vKkBnfYkB5CJq6Ym6RSBLpVPWtoIp+EJbW1mCX40cv+h8oURiUNUPpTtmfcPpEGFEuvOawcQPaBNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7852.apcprd03.prod.outlook.com (2603:1096:820:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 02:07:06 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 02:07:06 +0000
Message-ID: <bc2bbcbc-75d8-4070-a133-8909c9b859dc@amlogic.com>
Date: Thu, 8 May 2025 10:06:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and
 CIS
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507-iso-v1-1-6f60d243e037@amlogic.com>
 <98f52c3b-349f-4a32-9a47-443996c95bd5@molgen.mpg.de>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <98f52c3b-349f-4a32-9a47-443996c95bd5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cbec9c-8a35-49c1-0479-08dd8dd50867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDcwR1JmejBlWklIa3h3eUtQZXpLSUxHdExwSmZKRWhYanJmQ2FxNXpRbjFM?=
 =?utf-8?B?TGh2bkUyOEtKMkNCRGNXazY0OEh4MUd5TWRQVEtKSmdVN25mY1lDYno3bWVj?=
 =?utf-8?B?MDZ1dXRvNDhPbGhGOGM3SFFhZFkweXNQL1UwdzV4dDRaRnRwTEovaFVNQ3dN?=
 =?utf-8?B?d1BZeHk3cUx1S0d1NkFPMXJ3V2x5UDJ0b0k1emdkdkRiMGpxd3QzeTFKWWxV?=
 =?utf-8?B?UHRHSFpUS0srZEpHaVVwdmk2WHpjZXhvM2xJaHIyam5UUHlQdTFuc0FpNjVn?=
 =?utf-8?B?VjNrTE12QWVlUlhLUW5CMHJqbVFCWVJ4dXVJODFXcDN1Nk9lVDJmTVVEVklC?=
 =?utf-8?B?YUtxdnF4TnJrd1ZvV2o3TGc5Z1M0NVpjMDBJZHFsODVZR1JjU0xVd0MxZmM1?=
 =?utf-8?B?V3pWNXk4Z3ZrVFk2M0puaE9hOFVwMVpRY3hocG1Uam1CTXZYZE5oblBhYjcz?=
 =?utf-8?B?Q3NiUEQ3WmYyb0ZRNm52aW5YeDJ6Qm0wOGV0OGxURlpVclA3bll5ZzRRbk5V?=
 =?utf-8?B?RmJ3WGFBMEFNdWlkY2xMWm03UUtqZWhmMG8wVU1hRUllQVh4dytPLzFHVWxC?=
 =?utf-8?B?TTFLek54VHg2WHNCbnhFUi9lTzF5Z3JzV1MyUTlDNU5WclFDTEJRUzEwUmlj?=
 =?utf-8?B?QTh0SlhGTjN4OEdaUUpkZGsyMDdQMHl4NDNjU3ZLcS9HNE5Rb0tKN3Evb0xr?=
 =?utf-8?B?ckU4TkNTTkRlUUdDOWtNdllNVHZXY3RoVW84bFNMS3NFTEZLL1gwa1RRTHl3?=
 =?utf-8?B?MzFNSnZXcEU3OFU5UURBU2xSMzRUZlJERXJZRGhCTHlHay9xM0FOQWdDVG5B?=
 =?utf-8?B?VzEvYnhkeGRYMEw1L0JCWXV6YzkvWEFuby96UUhURVZPQndvZUV1Q0RNSDhs?=
 =?utf-8?B?dXpIcjVlbTFXdTdsa09uODZ2bGF6YWNGbWNqYXU2ZEFNZUhMZWtsNXE5NUlu?=
 =?utf-8?B?UjZpM1g5YTNxT3BXeUpRZjhoOC9JRytqVFNic3N0QVZseXZxNThuZnl3LzdZ?=
 =?utf-8?B?NFJSK3R0MnZtSmplbXdIZjFrQ1BjRWdIWXRjNW9pdXVJYWZUWTRiMWtIWnNL?=
 =?utf-8?B?OHZUeDVWQU5oNXV6S2pNMU1BOGVvaUdxNURPejdPSU1HbHc4dnFJVnVaK2h5?=
 =?utf-8?B?YVE0ODhsY2hXTlN1VXBJRG5lWFMzODBVaEhoVktSUHhLQ1VacnhJR3pqQzdN?=
 =?utf-8?B?NzhkNTBBeE44cW85TWM0TXI1akJsZ1poREh5QVM5d2dyR0xZdVYycjBwZkZa?=
 =?utf-8?B?cjRWTjQxNUxRMXJUNnk1OWJ0TGZXWW5hcGFiQzNmZ3VDL3I5bHhVM0MybGIv?=
 =?utf-8?B?YkMwRUNlVjRmeHJ4dFp3cjBmRlR6bnk4OFdrOWdiL1poNWlsRngvYTVUbksv?=
 =?utf-8?B?TCtsZDFjVlcvTXMrYXJBUkxyY3d6UXdlSG5KQ1dmTXI5cnVTUWZlWmgxV3Zy?=
 =?utf-8?B?SGFtQVRLZTJDd2NaN0Jpdm5OMWVwNmtNQng3MDJjdDhobzRZTUdLSzJMTklS?=
 =?utf-8?B?M1JEOHEyZW9qQmZBbENSdlZUOTBjb25PYmhXYlJ4c2NqejZjWjZFRnFwS0pp?=
 =?utf-8?B?VUpLSEFUZk5YUXZaOFE4RUpNN0ZGQ25CL210V0N5a0FxN3BORTJaVGZEZXlm?=
 =?utf-8?B?dnBpSWV3Z2pvSkVZRzUyQWsyUG53UWRPaG1oMWEyMmxYWG41Yi9VWEFraUhm?=
 =?utf-8?B?NFVkb0NNMDIyVEtzUjh1eTdYeW1hdVdYb1NueDhIaG1sL3JOUThDQWN2YU9s?=
 =?utf-8?B?T1VUeVAvV3psaDh3MU4rdlN3c3lYSitHem9YUVhqcnRGWXVrQ3VDb3gzM3Np?=
 =?utf-8?B?ODdSK21vdVg4THJrNlhBRUlndnVybktZR3ZzcWdBTVhucEp1U3lhTDl3RjMw?=
 =?utf-8?B?c0pUNEU0dzZVSUlnNTFNSGtadG5uSTVyWVJpemt4a1hDWmFjck5HeUZxWG9Y?=
 =?utf-8?Q?cvGcFByegJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWMzbSsrVTdXQlBHaWxJUjMvQ25WV0lXZ2g4RlB5MUZPbUg2cTVnQU9vN01J?=
 =?utf-8?B?YzZEd21KNGluYldFa1lYVHRaa2J3UkV1N1MwclFtcGRxRnZqWXA1QTVucDJ0?=
 =?utf-8?B?eTNhL2gyRzhFOW1DczVwMHNnbjA0QjdRV2lkUWpxaGpxK0dObWVVZTJrcFhU?=
 =?utf-8?B?T3JCWFcrUitIQUV3YjZjVlppNzFuVExnOEdMN0VLS2hraE5qVEl1TWJIM1Vq?=
 =?utf-8?B?YWpsbDgzQTllMTZlWkoycjVkNWhwaFFpbWNzNjFMV3hBWldHZ0JRaHRNMUNX?=
 =?utf-8?B?ZHQ5cjEyaFBkc0Q5N0lGSkpyWW9wWkhYWk9mSUNaNFUyQWdOUXRvQnlMWVIr?=
 =?utf-8?B?M2VTeUs2Wk5wMXZwOFBsWVdJSDhjdnRvLzFFa1JUZGFPdW45c1hyR2FNTjI4?=
 =?utf-8?B?UGg2bWo5Z090VUNvQzlhekZ6TEtlNDJTMWUzS0ltUnJNSERpenBueU1paGZw?=
 =?utf-8?B?aVlsVlRFOUxIRkZFdVZFRHAzL2xBdHFkQ2tpdnpxbEIvNmxYY1J1NXJjT0Na?=
 =?utf-8?B?cURyODV4bGV0UlBlTE91aXBhUGlmQTJ4cHduOUEyMHJScVZkY3VkMC9RdExm?=
 =?utf-8?B?NGdzZThYamswb3A5SDU1RkI4RkhzTUxrY00rOUo2QnJBZ0wvWjF3ZDYvVW82?=
 =?utf-8?B?NGxST3hEZDN4L0t0MUJudWhveld2aGVtQld2Z202a2Mwcnh3TjdKazN2UWR3?=
 =?utf-8?B?ODhaaWtnV3VVVUs4NXh5Um5KZG5CSVNmR0hub1lkTnV2Q21acjlFYWFCM0pN?=
 =?utf-8?B?aXBOdWNha0JDUXRqaHc2WTA4ZU1vNE9iZ0pEdVZUd1R3MDJKS0hucFVEa2xP?=
 =?utf-8?B?VGM3a2Z4ZXpHTnpIaGxmeHBHNWFrYXBOVW5qbXBXR2dwNmNDNzFjZWY3Z1RN?=
 =?utf-8?B?TnFEMUpJSSszbGJ4ektMTjhtVXd2U2FGNHdaZzUvMG9ueDFodk5vRGlPUnFH?=
 =?utf-8?B?dDJ3SEplQUIvUE5jYW5VTm0rdGd2eDM0aEFKVzNvb0p0UnBmN01weFJaRUE2?=
 =?utf-8?B?ZGJFM1VyWnlmbHQvUWY4WUZyd09oRzJRc0hwem4vRVB1bVhCOGNLbHdDRyt0?=
 =?utf-8?B?aTI5cnJ4MlZETHJGbHcrcldvQnAwSnNjMytzMi8zM2tlSFJGQUtEQ25RR1g0?=
 =?utf-8?B?aXhCQUtzUjJWK1k0ck5NY1NOSVNGd1B2VmpjYmVBZEpTYXFtMmZETGorYXV5?=
 =?utf-8?B?L0ExVkNySGxqY2xPMERtdlI0WkFpaStISFQ0QkRQalNQZGs2cnA2OGxkMFdL?=
 =?utf-8?B?bUJKUkZGNnpWL0RhZXNGb2lVbDBkaXZHNGRoRkdoVWpqa0RkVWtJNjhsUUdv?=
 =?utf-8?B?MTJoZGdnSEI4TFRIZjZlWGVBU0pORzZ1N3kwM2ROQWRuK0RieWtzR2t2SjhD?=
 =?utf-8?B?bXVubGl5YVZPRnowSnJHeEl2ZGgzZFdXYTg3bkloSnE2b2pmRzVHMkRJMDIw?=
 =?utf-8?B?MFA2TUZZNTc3cmRmMGo0dkdQQTd0YlJ6eFRTditRUzRhdHcrNDBnaEdMa0tm?=
 =?utf-8?B?NUtPVGNONDQvemFlblU1dmY5SUh0WU9ueXZQY2NJcTZHdnk4U3hUQTdDTit5?=
 =?utf-8?B?TExQc3dISG4rQ2xKd2Y1TGtkdlNwTUhwQWVGSDQxZ1FvM2hwWDVXZ2trMmVz?=
 =?utf-8?B?bUVxNFdpbGQraGx2all1b2g2V3E1QXBuWkExNngraTQxZjlxUWJnMi80NDVR?=
 =?utf-8?B?UDRLUnFjMmF1a3pRdmFmMDFORnhxTG8vR0hBcTJ2UTRSOUFzMm8xMG1ZNHcz?=
 =?utf-8?B?L09IZHB3SlliRCs3TEV5Z2tiUTQ2SGRXWC9mUTR1SjljY0JJMFpMMi9xRzBB?=
 =?utf-8?B?aHYrdEExVS95a0x2dWpqMjM3Yi8vMXpTcWdhN0RsOFFjb1VnVmsxNTFOYXBH?=
 =?utf-8?B?QVNuRW1PSDMrS3ArbmIxazRRMHpmYnNqQjJMbjNUNndGMlV2ZE1tUml4TjFP?=
 =?utf-8?B?M1ZMaFArOHA0T0RNdUFKT2pDQ0ZYWHJaRzlkcnpONDVGOWVlcVg0RWJsQlVH?=
 =?utf-8?B?UDlKUVhQcVRZZTJlaERWNnVZMnZsRWhTZFZDelFKWHZBR2JBOVZOVEFnaTlw?=
 =?utf-8?B?Y1BSQzRnQjBCUC9KRE01S3FKWG5XVmVtRU1VUDZUREZkRXJBU2NnV2RVdnlx?=
 =?utf-8?Q?Avm483oWs4Mgf0vXg+MUdCnTG?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cbec9c-8a35-49c1-0479-08dd8dd50867
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 02:07:06.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66rObACK0xTbOh3MCRmeTyDhaJJ03NewHMcQlTOLQcXqyvSBnbgpt7DjWy4Ng+YUjlGabYppQ5tbooIrrSSMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7852

Hi Paul,

> [ EXTERNAL EMAIL ]
>
> Dear Yang,
>
>
> Thank you for your patch.
>
> Am 07.05.25 um 09:30 schrieb Yang Li via B4 Relay:
>> From: Yang Li <yang.li@amlogic.com>
>
> It’d be great if you could start by describing the problem.

Sorry for the confusion—I initially thought the linked BlueZ issue 
provided enough detail.

To clarify: the problem occurs when the DUT is acting as a sink device. 
If a BIS already exists, and a CIS  connection is then created, the 
kernel mistakenly references the BIS socket. This happens because the 
socket selection only checks for |state == BT_LISTEN|, without further 
distinguishing between BIS and CIS contexts.

To resolve this, I believe the destination address (|dst addr|) should 
also be matched when retrieving the ISO socket, so BIS and CIS sockets 
can be properly differentiated.

>
>> The iso_get_sock function adds dst address matching to
>> distinguish BIS and CIS sockets.
>>
>> Link: https://github.com/bluez/bluez/issues/1224
>
> How can this patch be tested?


DUT environment：BlueZ 5.82+pipewire 1.3.83+kernel 6.12

Assistant：Redmi K70 phone

BIS Source：1BIG 2BISes

Steps to reproduce:
1> Use K70 mobile phone to connect to DUT, and configure BIS source for 
DUT as Assistant, and DUT audio plays normally;
2> Do not end listening, K70 mobile phone plays music, DUT still uses 
BIS source audio, check HCI log, CIS link is disconnected；

After testing, the modification resolves the issue I encountered. 
However, I'm not certain whether this approach might introduce new 
issues elsewhere.

>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   net/bluetooth/hci_event.c | 35 ++++++++++++++++++++---------------
>>   net/bluetooth/iso.c       | 12 +++++++++---
>>   2 files changed, 29 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 66052d6aaa1d..c1f32e98ef8a 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -6413,6 +6413,8 @@ static void 
>> hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
>>
>>       conn->sync_handle = le16_to_cpu(ev->handle);
>>       conn->sid = HCI_SID_INVALID;
>> +     conn->dst = ev->bdaddr;
>> +     conn->dst_type = ev->bdaddr_type;
>>
>>       mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
>>                                     &flags);
>> @@ -6425,7 +6427,8 @@ static void 
>> hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
>>               goto unlock;
>>
>>       /* Add connection to indicate PA sync event */
>> -     pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
>> +
>
> Why the extra blank line?


Sorry, I will remove this modification in the next version.

>
>> +     pa_sync = hci_conn_add_unset(hdev, BIS_LINK, &ev->bdaddr,
>>                                    HCI_ROLE_SLAVE);
>>
>>       if (IS_ERR(pa_sync))
>
>
> Kind regards,
>
> Paul
>
>
>> @@ -6456,13 +6459,6 @@ static void hci_le_per_adv_report_evt(struct 
>> hci_dev *hdev, void *data,
>>
>>       hci_dev_lock(hdev);
>>
>> -     mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
>> -     if (!(mask & HCI_LM_ACCEPT))
>> -             goto unlock;
>> -
>> -     if (!(flags & HCI_PROTO_DEFER))
>> -             goto unlock;
>> -
>>       pa_sync = hci_conn_hash_lookup_pa_sync_handle
>>                       (hdev,
>>                       le16_to_cpu(ev->sync_handle));
>> @@ -6470,6 +6466,13 @@ static void hci_le_per_adv_report_evt(struct 
>> hci_dev *hdev, void *data,
>>       if (!pa_sync)
>>               goto unlock;
>>
>> +     mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, 
>> &flags);
>> +     if (!(mask & HCI_LM_ACCEPT))
>> +             goto unlock;
>> +
>> +     if (!(flags & HCI_PROTO_DEFER))
>> +             goto unlock;
>> +
>>       if (ev->data_status == LE_PA_DATA_COMPLETE &&
>>           !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
>>               /* Notify iso layer */
>> @@ -6993,6 +6996,8 @@ static void 
>> hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>                       set_bit(HCI_CONN_PA_SYNC, &bis->flags);
>>
>>               bis->sync_handle = conn->sync_handle;
>> +             bis->dst = conn->dst;
>> +             bis->dst_type = conn->dst_type;
>>               bis->iso_qos.bcast.big = ev->handle;
>>               memset(&interval, 0, sizeof(interval));
>>               memcpy(&interval, ev->latency, sizeof(ev->latency));
>> @@ -7038,13 +7043,6 @@ static void 
>> hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>
>>       hci_dev_lock(hdev);
>>
>> -     mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
>> -     if (!(mask & HCI_LM_ACCEPT))
>> -             goto unlock;
>> -
>> -     if (!(flags & HCI_PROTO_DEFER))
>> -             goto unlock;
>> -
>>       pa_sync = hci_conn_hash_lookup_pa_sync_handle
>>                       (hdev,
>>                       le16_to_cpu(ev->sync_handle));
>> @@ -7054,6 +7052,13 @@ static void 
>> hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>
>>       pa_sync->iso_qos.bcast.encryption = ev->encryption;
>>
>> +     mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, 
>> &flags);
>> +     if (!(mask & HCI_LM_ACCEPT))
>> +             goto unlock;
>> +
>> +     if (!(flags & HCI_PROTO_DEFER))
>> +             goto unlock;
>> +
>>       /* Notify iso layer */
>>       hci_connect_cfm(pa_sync, 0);
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index 6e2c752aaa8f..1dc233f04dbe 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -641,11 +641,12 @@ static struct sock *iso_get_sock(bdaddr_t *src, 
>> bdaddr_t *dst,
>>                       continue;
>>
>>               /* Exact match. */
>> -             if (!bacmp(&iso_pi(sk)->src, src)) {
>> +             if (!bacmp(&iso_pi(sk)->src, src)
>> +                  && !bacmp(&iso_pi(sk)->dst, dst)
>> +                     ){
>>                       sock_hold(sk);
>>                       break;
>>               }
>> -
>>               /* Closest match */
>>               if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
>>                       if (sk1)
>> @@ -1962,7 +1963,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>>               }
>>
>>               if (!parent)
>> -                     parent = iso_get_sock(&hcon->src, BDADDR_ANY,
>> +                     parent = iso_get_sock(&hcon->src, &hcon->dst,
>>                                             BT_LISTEN, NULL, NULL);
>>
>>               if (!parent)
>> @@ -2203,6 +2204,11 @@ int iso_connect_ind(struct hci_dev *hdev, 
>> bdaddr_t *bdaddr, __u8 *flags)
>>       } else {
>>               sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>>                                 BT_LISTEN, NULL, NULL);
>> +             if (!sk)
>> +                     sk = iso_get_sock(&hdev->bdaddr, bdaddr,
>> +                                       BT_LISTEN, NULL, NULL);
>> +             else
>> +                     iso_pi(sk)->dst = *bdaddr;
>>       }
>>
>>   done:
