Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F5A55
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628876; cv=fail; b=XCwUNhGVSUbxLd/5UEglZtalT2dARfmQwNoCEIwORuXhvOTJJJ3pqnQ96OtSPX1GEvc/gSFfoyJ6+pTNanrEysNWUVhx33HhltiGQBysY2Plyh4Vgt/mDPm9p9WYe1ZXxGp5vUJwtZGCKX9Fy2QjVxaVlvIBlMfFde/xqvSRA6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628876; c=relaxed/simple;
	bh=wfMw09lK5oTzjoLMnkoHxr2UJnnqDHh5nLE6CQ/gHK0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=igZ17O+0CBZpUaR1I/lwn/oSR8N1giT+/TS7wci/ZjtFGcaniRlBm66p3n1AeVngp3XP5MaOZJ4LI5EE4ur2Xy71ixtG4VV/AK0PYy0SpJ72MwaXaE4oxx5yZLQyYyU7DlZ68EA6R/s2k44Z44b/W93sLKCpnBF/PH4vkDmiS3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nR0zItSX; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nR0zItSX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/nbeVS5sK95nJJnybLTpOLe3Biq184414PzJ6DsPE3GTkqG4vgRoYCiKh7xWGf8HNv4e7P7DBEj3D9gsL9qI+uL1fIjiIw8p9QmXOAPcdjzTSLRN0XIXJtydVUlk55zQKXD6AEHtgKvw2Way6IKlOluEdmaSSjXmfAVqFutTutDdCa+oZw4dUf2n/4LDkfuRkDkRBfZBDX01MR1lfUi3+mZysL4928I5fu33Ut6PSXKbNQcdTVsS8VzsfMf3XnepvBF9KwNJKOi/chGAblPncyx3vffaU2Bz4IFhVAZXTHLI+CxQw8n3IM/CWcM3RCehwo9r5TvPow3EPD+62q6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTGp0K/WD0TYBf+ouFaSu45eoH7qfE9RlSYTtaRxZ+4=;
 b=qW2ZQiv59/Uhm+v0T7dXmNllm2+Z9ZBa/3YLr2hHk8tYw8fkSL/WjE/2qfuCN9XgpM5KYcCyKNPaIO4a3DiGcHCFT91jhgTZ8Q/AOV1hG7a8WIjpjTBJV19e9yg8kBYkL9N/a2ghTXNmmHYnYMi7N6vSPj2oLa35CfX6Qv4JbYiKVLUu9g86Bu7Dx+YvZufsveHuCrG5Bi3P4Sj5ImZC3ZR6R8jfulhgEpA35rC1NyfG6FxzqRBl9VJUHh3MFVM3e230EvU8+Wf79CLWEuQ2MLQJM6CWSR839g0UVB18I1HowOwa8VebppxSgrUmE0BYk/UEBbDjxBtmtxD0ohScXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTGp0K/WD0TYBf+ouFaSu45eoH7qfE9RlSYTtaRxZ+4=;
 b=nR0zItSXcfTRhp2YKivp7ZUqjpIugRXIu1fLI5RiYg+L9+NWb0xcUPADnTULTVX8aJBuhXVpq72tzkl4Q5z0ncDGzHCALYcyz1aR0jTXXcUgcxtD6E2vaSOmOR9Zv7xYaUuuDsGeaRw89m0m+mOChEY2xcmx01buL+ncOeh/E1cAaAPRVC92WgV0EE81YBiVTbXxfGl9fUWtpI9B3wsoucqasWyux/lau9oSeCWITYkvjI3yT7ifAC1ZPkrM2Iqf75CU9LmMI/e9yh3caIPboc1vSQuABqq8hczv3nmix9YJKhlyS5Ma1J7Hk/MgFbc+Q3jIPg8u6mzUUoJC9U9Dzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Wed, 11 Jun
 2025 08:01:12 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 08:01:11 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH 0/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Wed, 11 Jun 2025 11:00:43 +0300
Message-ID: <20250611080044.26730-1-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::20) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c83e395-c562-4c40-5435-08dda8be215e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwASk6rTpJfLq35EcK+XeyZO5yLpcl7yHXSv7XlA1q5fcdiGxci8pY0E4pop?=
 =?us-ascii?Q?cw08g2QzMjXb5rE6tvqasV8hbi766Is9Qc+/1rkqk4c38T7ZTDUjqwV6LpSm?=
 =?us-ascii?Q?oELYmkZmDrxqytz5DWI/wjh3lipC9NIBpOPDQeN9040d/tqWkjmCBwOc+059?=
 =?us-ascii?Q?XxuowPdyyQtmxWIdqA5+S+xujtyLyMtGqwBVMLh6GoulkORKpAcylFK3gjoH?=
 =?us-ascii?Q?wJmVUhmW3cJ6GL0IAh8zv+h+S+e5HcNrIKFyjEd9NEpgN+uhffjStlmhMGxm?=
 =?us-ascii?Q?8w5gaXkMh0PfICZBv8/8J/fMkh0ptAkEtyexLVOlTjsWcm+T0BDWkY7PO1kH?=
 =?us-ascii?Q?uO1bqDZ0poX+L1luhHIFQZWV1h2PXsZyagNNPThNZEs40aSqCBP7+TO2ScNs?=
 =?us-ascii?Q?KC3jIX63vEmLOhOhF8ld4f85iEfYmDfSLwFnU1r5yO8cOiHJ8NzO1psoZhYB?=
 =?us-ascii?Q?+Qx3A83b0e9VuAut8zwh44j2LRwiCqmBl3HsBGD31+KzmkaO5ndRmZ2C2LyN?=
 =?us-ascii?Q?JTMXodWvE6zvMzPfCcEpa3GE3N71fXVQRRxgdDfW41XMFOlqpUb8nkT53dkH?=
 =?us-ascii?Q?wjkZs4Y/7iItfKnOeboc2nxTM5tD02QQmjVzBJFMay6LF3RIV/hc2FYOAfeV?=
 =?us-ascii?Q?BTY0zgX+mT18Wif+MtGPiOpWm5Eh2wwJcFAKoaqRPQ4deV3Wb8YufyctZbYg?=
 =?us-ascii?Q?slKSzQYNJhCdfEvbtZnGRNpiZyUYl0EuGyjc5bh0o5Vhx9BoPab6qynm/7LV?=
 =?us-ascii?Q?DBlxHtXf4HTRuyhu1O97+DY0sgx2TkbONhsAxJ1nCLWoYKkf0WNMKphNt373?=
 =?us-ascii?Q?5SY3QJUUBdw4R8eb35lXG3UBfD9FgZGq7FbQc7jkQlJ+HUEe/HfquUKINwfU?=
 =?us-ascii?Q?D1eRMrZpCiVRYYCAK8X428EWFThG7iONEZNM+YFSgZfSLPdAdrjJrhuVyld4?=
 =?us-ascii?Q?4+iniNW1XxiZnYpfHMPTfRnNGYS+f+MA1cUP0edPoXqpcjsApAGTAfwrgOCU?=
 =?us-ascii?Q?5kqBRHmALk3Sm0AXldSG1sYA5BhoxGCdd/ngQeOIL5DJWfHAaYW/4VoPQx31?=
 =?us-ascii?Q?4IDXfE9RzL1tf26pQ2/NnmKHPLNzsX9+gXJHZ201KtHxo2V9N8iJMaJdnBTH?=
 =?us-ascii?Q?ULVTJZm8adfTbxNSmHrHZQotj6AeosEtY+DnQ8TqL8RVEHi4rsNSaYgC4DCB?=
 =?us-ascii?Q?XwEm1nrJhOTlqkVZBnbKIeL9JDZVg/wjjZUvoCD/Vvdl7uq87iDejx/EEUu3?=
 =?us-ascii?Q?l7cXI13G3mRAXl43yHOeNjxubUxsG3GkiefuIJE+R7MakfFfgykDOGUOKc2l?=
 =?us-ascii?Q?JD/iUvGEQL7fKmm7Zt2xbVvXOhxH1lIxmn+/hupOOTGS7PSTNt1FCMSi02qs?=
 =?us-ascii?Q?/BiDTocPabelh7CmNECxunehsadzUqF8qEJ4azs/oT7wzTQ1ItlZTxv0uw5D?=
 =?us-ascii?Q?iuffHmBG7Zg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dkOjnixzh1E0Xe3geNrmAI/bsJ45fJ+btJFm159+RFEfR8nwpKGBSyKZhYt?=
 =?us-ascii?Q?0Pt7x/76ihTAXOoj/OHBEMQkzvuEq+5QZeFurbk3TQ/cV87CiRmtK8+DNVwc?=
 =?us-ascii?Q?4wwk9EPBh4FRJmygV12PDdTpfjdJIEVVYL7GQ34K5SdniS1YNSwoOTaLQqcT?=
 =?us-ascii?Q?jNkK3C9/WIs7kjgNqHA+4JZpq09QALKa2klP+dU+WMwwmDSSzi+M4lJvlMyU?=
 =?us-ascii?Q?3pYo7k93BzsBctsgwvPalprzkjemIT9lKRgDMLuaJGehE/WFJ50aW50GeSC8?=
 =?us-ascii?Q?j3W5aMHbVbWSb4m7D0orWa3VG6vA+3fkr8uUbuvG4BTLUQU5wFjO5PBJ/T2U?=
 =?us-ascii?Q?Db1xLlu2R5wFgIVL9jR6+xbuFWxQOilZExqjVV2QqrSZhTxrbgKU6J6NmY+C?=
 =?us-ascii?Q?2kMMTkFLtaXe/2Et3Gumey75BckqZv9VX53Q8OMjcpOqpsEEgLfGv6h8GJ1y?=
 =?us-ascii?Q?WjarrBcKflb+H0p4hIpOa15Y7+655APdYVpp7k4QMDQArTMhKY2QNKYr8JSn?=
 =?us-ascii?Q?aCZiuYfM0YPcNLSS2SNY3brNrxuVfzAnr4jsWOMBLH0PApjmHp44GSpXvVC+?=
 =?us-ascii?Q?JTRws2ZyTZ5xOkjo4uSlQc3OaEs44H3/cnHFUZjPrnFumYIBuWiirRL1jEPS?=
 =?us-ascii?Q?kDsWeXh2O3F8qo6ZKb1ohPguWlR58cvMwYEZcDrrwbhIcpn8L/U88h7FMmT0?=
 =?us-ascii?Q?D4JneyJe38YWwfW9TDEbVQuA59xz7GJp0Q1xRoENY1AWpg2FosoTWNaM9PN6?=
 =?us-ascii?Q?WgMlCdLlLBxWdkP3+W9pCK3enRcIoNU5Nofd9I9W4uhGi5Fp3jVtsPKNAqH4?=
 =?us-ascii?Q?vk/i7G4LyaQHXK2kd0gD/EqfFsxHgIU3p81bPF9I8mgsw7hBaHilVwM7utvD?=
 =?us-ascii?Q?G1GzpwZn2JvWvqZqUYrjAckWJCcloZfOx55I9FurUyN0LDt8u/mOvhbzOXGY?=
 =?us-ascii?Q?HlVWbGdFZbP8Kqo7O8tOSZM+N2jC4nYH04dquYftvMpo8pvdyR5VlvtiKbnM?=
 =?us-ascii?Q?YTLtwHFj3SYSbK6Y9cWfPmyiXbvk3q11A4uuqT5gcX+erkJarYft6zfmkcjT?=
 =?us-ascii?Q?0Ayv1p+8bZfL+0jKdTXtnj9oYDLg4bRq54TLQf1t1iTIlGXuWZysOGn1Towl?=
 =?us-ascii?Q?M/Vz1EWTNE4+wIMji0PbIP11nq/+SEM6oI0egfJiLBLcrSqWfuxlJaZ0CNm1?=
 =?us-ascii?Q?lVrYZHdYH1ZsnMYtFnQe6hvZpxjX4odcdSWhkGJ1k/F9FS+QroWxJSoITvGa?=
 =?us-ascii?Q?ngnaKcPmVMjpY9EA7XAXNX4YlnDM8IM5cg4+XadzB4DnIZ4PwALcKoCGm3la?=
 =?us-ascii?Q?DupI5X7UBYznUId3BUhIa3H/Pdxq3wobd2b9h/uoM7L3yCcvfM5ZUI5NPGsK?=
 =?us-ascii?Q?WKi/IofW0Mkln6WzxmjjcHxPrO7lZ85GsQp+jOHPVugBuGlmZwZ9Srn86tyh?=
 =?us-ascii?Q?renjn0vrqsiN8RN76HkotKICFUfTrOGfzB8iin8JSKd8Xne4//VnGPPDvRDO?=
 =?us-ascii?Q?1usQuO8gE8VGbT+zVVvdV6tvI4bA5zmLG5xYz+9xiB0CrPt0jsN4orfrHHTb?=
 =?us-ascii?Q?NHgGpXSeX+cva0Wx/JFrsfMmn5TtVQqSKqDGf67DNFPb+OhtFrfKexLWR1e+?=
 =?us-ascii?Q?JuSON1xbQrBiTuzxu0uBNBQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c83e395-c562-4c40-5435-08dda8be215e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 08:01:11.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afKCBdqbZV+FzvdoXmFZQgo72GRBeTgsBYczu5naI8vFpsgh8NZEDkXzzJGyInyqX+NnjYO71pSs7culbGZc6TIf4BDLdCm18e+rd3M4FKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Adrian Dudau (1):
  tools: Expose the raw advertising data available on D-bus to PTS
    tester

 tools/btpclient.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 4 deletions(-)


base-commit: 5df9521ce4d50ffa48153503bc5156c11e6ed26b
-- 
2.45.2

