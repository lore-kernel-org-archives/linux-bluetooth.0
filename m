Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FE1EDA11
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155539; cv=fail; b=BkibmYnMzMHMX8irN6T0cMuwbrTB8EWGMlZ2FspBkUt9l9Q6bL4t8UN/a/V1RqBkB3F4esKxzaZZwh84bKQ12o3eSWaIb03fRZwGc1kGYeSN2Swo6hg9s3FpR4D2Upcg0xj/A8ogumo2JC79N5ZFI0ffqeMoq5m6GOAcP86K7tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155539; c=relaxed/simple;
	bh=unOwE+o+eLvdg190qsZC5cCWf/aPqTMCdXUF/2np6kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJsUuFgaR/fkeA8KJ71YsRwE0MIvImOilieTACxAjMV9zpCAWReQEAv+2FrWGCe6ommDe17Orfk6UKN6XqQ4V/OMHEKVezRj3LIM9xiojDmfYEeviSuZ7+1Mw1V10Sg06zCXMmZt/VSrHT33pVMepOLMiCvagj5jd2D1XTLjesk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A8dsJt+R; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A8dsJt+R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQjBjudUd3zuqU2efn8qWYer4cZGs7AUq2HRoNQvzADQGN79TLIbn7Ic6N2BCAi5Y58eOTEM9Iuay26foI1chcEv+mkPbEnF+C7Zcebpk6gDurofXLc+9NskYLGEWuiq1qJSmiGrbhfAaVBfxOsi56iIEXpJ1Q2BcWwDjz69BJTDqfiLXYB15gSPKBqkMlg509fOhF65qjdCQnhvYK5tldseTllnyuQbnNuQSGsgRxUCMoN1txwM3aN1MrIyTm93aOksExRw0WHGcmnzYz55XNHYrq8mrLBPhE6Hd1x54oNMctVvJX/FM69b3GarHxUaK8etewEHkODSlAcLmfgCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEdEdIwvgFvSH8iHU3nSQBOHNNfs+cIZ/Xk3tMUtAnw=;
 b=v43AMNmzIQXIlW1ySL8zP5p0U7qGTHkVdsKBqVAriwPQ3J0XEVGLtItMWYcH8SjFR7+FpY5wpQxRDaOhM78dRjDriLg1selgzwd3EKSRaW9rYG4QRB5GKmWKI2xGdStwodaFiOFmAjY4m7XVjPtI8AFDUpVZPPIt/4BxM2O7P5WJ32xcLEtUkEKZC1YbvEjgYzOPROAUru2JGWz42TNNWi/u8Yj3IKgvdyj0Ec3mBXcqYzzyTldQmplEA91WoziiDSfpdwWUzDc/3S0vSmfHMqQknIl+Z69Dk4V2C1pRZp10XQ/rmfmsBE2+tsFd+N7JqzpqJf1LkP0Zgy/NhfC77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEdEdIwvgFvSH8iHU3nSQBOHNNfs+cIZ/Xk3tMUtAnw=;
 b=A8dsJt+R0ML2IU6Flc9v8SYev0nUHql4BHafvwOK/H8E77+MOePqLcjXecY9MosvOuOyOmClnc5FI+QAin09jaOKJBsX+96MYZGm8ITd4qmNEr1TbECS1BV9hBS2o7UV9tHblzfOT2fjVBRZdBj6ot1060RCMsA9INadSc62qxjLM3AyM7L9coJhxIMDp2eHSswjPIsVCry4qOUy4GlNB2kWtkVdTIFVEhnOkAr1It2H5XeWLHYYykn8e+ZvtiM3gvr6wyhlsTdMkjBo/smSO6ug+Bh1pMP8OfhUke+/GEsZXzHLXDxf+Mo7QeJbhI8rfir8Y0vGEVFEQzCMJtTiVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by AS8PR04MB8152.eurprd04.prod.outlook.com (2603:10a6:20b:3fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:32:14 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:32:14 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com,
	iulia.tanasescu@nxp.com,
	mihai-octavian.urzica@nxp.com
Subject: [PATCH BlueZ v1 1/1] shared/gatt-db: Fix incorrect attribute type
Date: Fri, 21 Feb 2025 22:01:39 +0530
Message-ID: <20250221163139.1705-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250221163139.1705-1-sarveshwar.bajaj@nxp.com>
References: <20250221163139.1705-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|AS8PR04MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2818ab-ea55-477e-493f-08dd52954c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9cv2U1VCWZcFbdKNVCihLTPV0D7JLvDjkh6d8IS80uioIzIPo59xksY4FLRu?=
 =?us-ascii?Q?wJIMwFM76ePP06B56bsxEZuHWR6oBHf1AQvVB9U62PhLlhoiNDADrBQtrXSV?=
 =?us-ascii?Q?pYkxh2Oy4Dd5kmUxtllMsu+IPr2UX/nTp38OG3wQkc/TBSF6S9nxuPBdDALl?=
 =?us-ascii?Q?XnruVwuhEt8cCROtdNbSJcMPnIl17uX4FT2dqFLN8LyvaU4GY/CvEikZNISI?=
 =?us-ascii?Q?WUIRryqk3/jHl1ETxAwvput1fCAIBySV9nGrgOxmaDX1Q6bMoOhrB6trDGqd?=
 =?us-ascii?Q?+zj50He2piUum5BfvPYBFQ4uXIPHrh95DVdvvM44gApm8dNECvR4xeNm79sj?=
 =?us-ascii?Q?tqXa5L9l3msvv2sYW4PQCmjkKYMS3r1VguftvXIYgChMGYfYdnb9y/sNNYek?=
 =?us-ascii?Q?RBW1W9NRdUBV7wjGqLQ2srECJMZzkcMVd/vsxOXR679x5ZLtCYWBCWPNtMPP?=
 =?us-ascii?Q?Pkd4XD58ZGWcyemH2zUYmKQWaFyYjKKKMj09ojTuslYPSccG6zEQvkAXrLOw?=
 =?us-ascii?Q?tLCxCve6Wi87iem5H4oj0a83cW7K+up14qkciAzcRHORwFYj2vAEyHA/PYtf?=
 =?us-ascii?Q?kKZQuT0b3n5dubn1oMdFpgSxnwuS417BJzwzmuIsah7IN7tG25xNsQphu/cV?=
 =?us-ascii?Q?CDeXs+gqhwlJmAoY/tUHSjVmAdpJO+QEJ5GObxOCgP0f7iywJEv7VXskXo6D?=
 =?us-ascii?Q?w01bb28X+vopVSIYrQikMgTlMASiguo5Sv0DxYXlE7UFalcsqLlMjjdkhDQ7?=
 =?us-ascii?Q?kurj6fOZZhai0Uk/AJkVdas/j8gFeLb/GmrGkWMOsO5hST7g1EMI7NtXGBnR?=
 =?us-ascii?Q?hZxifekhj74/xKUhDdo5w9SPg53z2SkcLdPE8iJz18geJsxLcyfrd2KnpZLG?=
 =?us-ascii?Q?jg4VUlLdLwxcFAu0/dAOsMN2pUNGeVZtmiB5oIvUGY4rkPyA5/ikWEDJLM7A?=
 =?us-ascii?Q?gZ3zIRB7OIa0eeTeRQzLnrBbfc/m/YuODSpoSqe6S17HHP/sf9ohQUxc80fa?=
 =?us-ascii?Q?KMzdLd4WOpPGOjf5TT3ra1CvlE/k12Qow3wEmnmP2JQ0h2OfXkE4MMsFjJGI?=
 =?us-ascii?Q?LFflvw7On/8w1ohTTuBFw8ghJBGE0f/uHrWmd+nDOPZYJeCscpXAiMGXkU3G?=
 =?us-ascii?Q?Ed1ddKRpleKB14x23I1Zjgsif1LZuNcAidXbRyY3dN2miQ/yjJyVHjetfOVV?=
 =?us-ascii?Q?Us1hSNKPB7ydMEHBAaOtA9zYaIG1bQN6MMHD22lcpUqvRq+BnFmPul24qYoy?=
 =?us-ascii?Q?/05TqxaH1tJ1dVVl40ep0Ivgu1sDX87oZ+N2xlirjuc88xq2CVvfpLBp+5OJ?=
 =?us-ascii?Q?enrPNyOD17Mzg/QxBF7CwzS5gq6I7QuYO0ydBFNrHSAwkjUoDwO8zuYP0vdv?=
 =?us-ascii?Q?HN6LDQ2HIlb/xrP650yJnGniBvKXJVLkQo/gwqXYHA4N7lVVJZSTILeDBOI3?=
 =?us-ascii?Q?QW/XZyXx8ZeMwaXb/SqNLp8orNnfzkvl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kI0AH8Lti9Z4YZW7hAx7JuEzhoaRqUQV9Ju4ylxVolNXvt92Bptiy2pFWa8I?=
 =?us-ascii?Q?qXau8rRHH0PaGxYUxpfxwvfmgQAtvy/uLX576NpPZX3IYaperxp5LZV33IpB?=
 =?us-ascii?Q?xf4XMCdnd8lfDNAvBty/1S3mxhkGR77G0lXvV83Hwfr8YZX9L7zcAeYKRNRX?=
 =?us-ascii?Q?ylvEL9DqH0jeROxb01HNaSIyFPzm2WFRtEe5Qt95cZTzbN7lUBfgWCwJFmg8?=
 =?us-ascii?Q?7caeZi22YVlIerHB7tokXxJXDdXvD48OZgFMkAYQ1/CYuZw8lHJS3ZSpV+gj?=
 =?us-ascii?Q?Tbr3pVKkGBNqXxPGrKQB8BO+TcqoPP33pOC1RnewvbZdl+rVu1QCRJZiogRG?=
 =?us-ascii?Q?J7Vn5PXRs3m2Tt/5l/5/pr1z8OfPQ8bCxvOjboetX4PkBs8sNqoqZdAiW262?=
 =?us-ascii?Q?51Vz78PHPVs+uxMduJgD29fnYL8jBskM1gXOkE1CE9k/4jixIiTuQ+Wuwvm1?=
 =?us-ascii?Q?tAgoD06qQUYjRRGqdaJMN5v7T9QDTzl/YfacFkIpf7966oXNqncS5uESnDdU?=
 =?us-ascii?Q?+7EDZW6LMwrr7y6iFyqjymYGbOJ/44GT1RFSpRp5VV6s8OLyihxHJsoMy9BU?=
 =?us-ascii?Q?sbH2gjIE4BzzdN9lYghkC0zgtimtEl41Foe3IlBn56rBZPPHjx6EZ0fuXiaR?=
 =?us-ascii?Q?ZM9S5CJZB3s0jbGrrPDPDLn4zZgA8DA8F6+OAIQWn1oqDsmt9rRGmP9XxquZ?=
 =?us-ascii?Q?KswQJPY3IVMpmV4/l7/PZChxU/Rd6oY+zcVIlN+2WVjqHBvtCG9JkhDZa2xY?=
 =?us-ascii?Q?ZCm6hoHQxD3eW9SLWngW8eEgS8vxRgSMgt26AboKqic7ba99Lt2lQPullaoA?=
 =?us-ascii?Q?1bV3t3jBXmUuBNlLZSocUP/w3TEj2VQYXovolyyjInQWpaYm2yn70iMV6+Aa?=
 =?us-ascii?Q?5SYNzOs89OO+1Q0HPKo50LpoxaLlel1Xv6HL0QpOM/sRuNwTlys+nhRigdJ2?=
 =?us-ascii?Q?rU/X15F1ogEPzQdJ1WrNLGBcBm1AOsooRNQemcJbQRGzha8Zy8fFHuINp5wV?=
 =?us-ascii?Q?1f/llA4e0C0Ng/jRiQK9gWdtUJPsxDgnUez11tae8yu5pKDHBzwjWdCRlGvD?=
 =?us-ascii?Q?VqEUH6pBQhCXJubnsaSbrS5EFWl0Om9VM/QPL32w2wFvYecTCTHKEdsQQI7w?=
 =?us-ascii?Q?SWm/QKXF1iuM9BIJk+Pc05+/FpeI7tejX797E8n5xPPGM/sGQXkMWTl8VvKB?=
 =?us-ascii?Q?eXlkK3HUX4kwx8+ccOpcUu5BENFdmoxbE+2vZ5jcMzYaFZ831NM35nUq+Jl8?=
 =?us-ascii?Q?063+vcx+ygp5XDR+rm/PWNVyusehDdQGeY1ykOLsQLT54YYnsX2ONokiD1vG?=
 =?us-ascii?Q?80gEMLIAaVSv80HYYyehIDEWBa0FYQ2u2yLzV1nRZ0jvPfo76+9WE/juSQza?=
 =?us-ascii?Q?73uTp6VyyhBh1J2a4JWAOuLPydYTdX3VlBOii+iOKB5GfOhq9vKGyoqo0YGN?=
 =?us-ascii?Q?eHwr7jYEtOk2yO5jlhoMulrMMEC8hOcdK3gtLcS18ULBgJgOBXjLljf5BvGY?=
 =?us-ascii?Q?ainzHYKum6D/Srdq8iZsvG8pMB8uJ5arvuqFu+RfF2u7qq2nyhfDOqz7KSol?=
 =?us-ascii?Q?nNOH3wmJ8Tfo5d1RN6CyxYXDh4VySvfLj1VVRfChOfktwuBbifuOlI45g7lr?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2818ab-ea55-477e-493f-08dd52954c70
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:32:14.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2fO3y3nTuxFv82rnhrs/9xPUuJlylEAJfDm1+OKO7wz/DzPHwdsHYVz+GrXcwXxFBuu2Pus9pEiga68PSxAtd7psekSqAgPzbYA+jkrYXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8152

As part of BLE GATT Fuzzing testcase,if application sends an invalid
ATT_FIND_BY_TYPE_VALUE_REQ with attribute type as CCC (UUID 0x2902).
However,this request is not valid for descriptors like CCC, as it is 
specifically intended for discovering primary services with a given UUID.
When processed in find_by_type(),attempts to access attribute->value 
without checking if attribute or attribute->value is NULL,
leading to a segmentation fault.

Added NULL pointer checks before accessing attribute values in multiple
functions to prevent potential crashes due to invalid memory access

Bluetoothd crash dump:
0 0x73fec87ae81e  (/lib/x86_64-linux-gnu/libc.so.6+0x1ae81e)
1 0x73fec94942e9 in MemcmpInterceptorCommon(void*, int (*)
(void const*, void const*, unsigned long), void const*, 
void const*, unsigned long) 
../../../../src/libsanitizer/sanitizer_common/
sanitizer_common_interceptors.inc:881
2 0x73fec9494bc6 in __interceptor_memcmp ../../../../src/
libsanitizer/sanitizer_common
/sanitizer_common_interceptors.inc:892
3 0x73fec9494bc6 in __interceptor_memcmp ../../../../src/
libsanitizer/sanitizer_common
/sanitizer_common_interceptors.inc:887
4 0x5d5c290f2456 in find_by_type src/shared/gatt-db.c:1389
5 0x5d5c290ff855 in foreach_in_range src/shared/gatt-db.c:1549
6 0x5d5c29099752 in queue_foreach src/shared/queue.c:207
7 0x5d5c290fb085 in gatt_db_foreach_in_range src/shared/gatt-db.c:1593
8 0x5d5c290fb4ca in gatt_db_find_by_type_value src/shared/gatt-db.c:1434
9 0x5d5c290e1996 in find_by_type_val_cb src/shared/gatt-server.c:745
10 0x5d5c290c3083 in handle_notify src/shared/att.c:1015
11 0x5d5c290c3083 in can_read_data src/shared/att.c:1100
12 0x5d5c291867c1 in watch_callback src/shared/io-glib.c:157
13 0x73fec931bc43 in g_main_context_dispatch 
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
14 0x73fec93712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
15 0x73fec931b2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/
libglib-2.0.so.0+0x552b2)
16 0x5d5c29188518 in mainloop_run src/shared/mainloop-glib.c:66
17 0x5d5c29188e26 in mainloop_run_with_signal src/shared
/mainloop-notify.c:189
18 0x5d5c28d8c6ae in main src/main.c:1544
19 0x73fec8629d8f in __libc_start_call_main ../sysdeps/nptl/
libc_start_call_main.h:58
20 0x73fec8629e3f in __libc_start_main_impl ../csu/libc-start.c:392
21 0x5d5c28d8f4c4 in _start (/root/LE_Audio_Work/Bluez/bluez/
src/bluetoothd+0x6204c4)
---
 src/shared/gatt-db.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index fe272de34..b44140523 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -379,6 +379,9 @@ static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
 	uint8_t *data;
 	size_t len;
 
+	if (!attr || !attr->value)
+		return;
+
 	if (bt_uuid_len(&attr->uuid) != 2)
 		return;
 
@@ -1005,6 +1008,10 @@ service_insert_characteristic(struct gatt_db_service *service,
 
 	/* Update handle of characteristic value_handle if it has changed */
 	put_le16(value_handle, &value[1]);
+
+	if (!(*chrc) || !(*chrc)->value)
+		return NULL;
+
 	if (memcmp((*chrc)->value, value, len))
 		memcpy((*chrc)->value, value, len);
 
@@ -1229,6 +1236,9 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 	uint16_t included_handle, len = 0;
 	int index;
 
+	if (!include || !include->value || !include->service || !service)
+		return NULL;
+
 	included = include->service;
 
 	/* Adjust include to point to the first attribute */
@@ -1386,6 +1396,9 @@ static void find_by_type(struct gatt_db_attribute *attribute, void *user_data)
 		if (search_data->value_len != attribute->value_len)
 			return;
 
+		if (!attribute || !attribute->value)
+			return;
+
 		if (memcmp(attribute->value, search_data->value,
 					search_data->value_len))
 			return;
-- 
2.34.1

