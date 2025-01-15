Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD6194A54;
	Wed, 15 Jan 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959064; cv=fail; b=bXiGLSxSyZ5TyyHqmbaVf6FXc2cvjrNbmZjzNL34WPQf3oS5OPF1TYh0vj3y0Zj+IC+BtqIMS5bxfTdS6FAk98FmprUtygbtrmeGM1X/fXjBc10ips6jQWG3Y8aRgtHA7NvnImMaXnwBGGEEkwEM7D7HRMRCXaXM51hqxN3flEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959064; c=relaxed/simple;
	bh=wtpNaREMXoeKvZyK2KJIhERJ8JA2vNi/7MLQlh7aSvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3heXlp8rDLNT2aLbEUL9/LQKUqeXfeKacu92XmraR6ctJ5IbL1ksB2bnjQcx3B/n42wm35/CVoK/bM4AaVkD6vgVtlNLbu11asBh4tFWx3S1noqIhyC4QaK1xGraiANvFBaov9GQvISJeV8Dmw1tIeO2k6P8P43tikR8XAhSfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n2AXkztY; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n2AXkztY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIWW8d99U8MCY5xFWjol2N8p4Md1b4pYanS4tmtkiCrdhibNcf582NJz5HwJFO7+mSjc48TGxovNGhhPjizxOr5RIUJ2Hw4lFEwTI5+lkBUvRw1J69RRzvTztyLccgKjlixPKEDjOWC+BS0NNO6SG/t1o8xUff5DHJ0Xzs+C34ojK0zszApYcqlqCIgUFlqOwAGWU82DhBDF0iCL0vM/sykDlO8ZDdqYYjxbKEOZqswQOMypt9Aq5QF2pdvc+/fEASjwwKEZlMNWKHGiIuTIvzYSezvtjjyTfUzhGfFNdmFwi9YM7n7aITM/1D/2wtN++69VJAfLzW2Paosu3H6VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRe9+lZM2I1aLDz7V8EYgNMomijvzqACZ8+BxPNAUmg=;
 b=LXrQw2gFpkHOMBpHeSbkrj3d9UzGgO7uIZ0UE/Ki7lkoteqBHJDRx63L+y2+tFXuyIqPL0eP/VOPo5ZRn2NuGBBiuOaOPN3cisGtmu+vL1F9OWEOUye2N5ouIbT4VEkM+1mgFer1WDi0E4EiVkczlX6iACs+gW71Wzp5UH5ySfGFU+OSR0+7Soco157tKwr+mhh+pxC9v6XQxNsv2+OTXkuStNhfSH2TqatfKqkV5pwikomC5cPQq3XVSQK5pB89QzyO4QFnyxYjGcH2sRTqbEmyg+Otjgw4H9Zv81r/NnHqwjUrJEK60oTV+fnFKkr0fE8Sioxj39G9wq8+/SZb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRe9+lZM2I1aLDz7V8EYgNMomijvzqACZ8+BxPNAUmg=;
 b=n2AXkztYa8CO87imZm09bH3Qmu/P+RabmZbRbgwpVfPNGdCGlbZTK9Lw/CpEawO+yIUtUP/QdBR0h0PTMXzqTfCwWvXqCB80pzODrgcfTX5Z4GeztsNVonjmJJut999GBin33PCAu3oKJP8G8gx7UiS1WjMrgWXRMBhCn3WEumk+IDPEn9Rpw4rjqyytGAy0Qw1QGb9vcDHBni6EzwHd1esvYJX0CmRIR1sIHFKzpM4PgyHED8qlrINaAXwnRB/5JGn6ARscWSgNlYzNkg+pCVdIW0a5TppLHu2OHo7L3HVtKrvTLJPZLUXYUJFAm7yBIDu7qhDLYgLpFzY5Hh5cgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:37:40 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 16:37:38 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v5 2/2] Bluetooth: btnxpuart: Add support for set BD address
Date: Wed, 15 Jan 2025 22:08:46 +0530
Message-Id: <20250115163846.2385345-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115163846.2385345-1-neeraj.sanjaykale@nxp.com>
References: <20250115163846.2385345-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: cb67833b-8e1d-4717-448a-08dd3582ec24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2VxOWRqcC8zQlJlZGc0QUk1QlRwOTJjdUFCMnJJV2JWMEY1cHNrdVpCVCtR?=
 =?utf-8?B?aVBuaEJHQnp1L3hkamtoYU9wWUNja0VWZE5wSytiNGU5eEl1dXAvbXVGK1dX?=
 =?utf-8?B?NVRYdkFwSUxhczh6WDZJbWVqbmQ2YklpaGRzWDdVa2IrTzh4emNUZVFPWGM0?=
 =?utf-8?B?aE83RGxiSW04dU1XU0xURzB0SzBTTC9LcEh3UG5qeTlRMFVvZ09SQ3hIR0k0?=
 =?utf-8?B?M1FnejFkSWQzY0EveEErN01RTnh0WHAxNC9qT0Q4UWlpdHBsV2pDU2x3M0xP?=
 =?utf-8?B?RlZnWE5hVzhZYmM2THVTbVYxVnFsUzJTWmNxQUdPOHFSaytBSGlPc1duZXlB?=
 =?utf-8?B?bVVYRXhHVWxRWGJEUFhEeVk0cWRzTkZITjBSSUl1TU1qZ1ZKRXFMajVGMDY1?=
 =?utf-8?B?N3ZSZXY0SWpITWFxa2haZDdUNTZkVm1xYnpyQzQxUFEwY2xiUjNOUmg4Zjlj?=
 =?utf-8?B?UVB1bm1PMXFML00vL1lWaFZwekNkNlpoOW5PcE5QQSsyVm1ZcU9kV0EvWjU1?=
 =?utf-8?B?aDdyYnkrOVBDajkvZHFrNS9yOGZNTnlpakFKbnVCMDdBeU43UVc0NGthelJR?=
 =?utf-8?B?aU85UVpuVkxna2dJdFNkb2lOZFFMcWpINnZNNFd1cUNPYjE3U3hIUjZIbVFq?=
 =?utf-8?B?UHdHV2lmN01rR2plQjNXdDM0bG1KbUczTUpvUHBJbi81NXdqa1U2TzJFUmF6?=
 =?utf-8?B?eHBDemtkcXdTN3htVjkxUzRvUGhZMFBMTXIvdFQ3K01YK0FmZ0ZEblBydHR1?=
 =?utf-8?B?WjBYb09sZ29TZlR1YlhJbUl2Y0gxN2l1WE53SUVOSkFrUGgwUUZjdklpeGpY?=
 =?utf-8?B?RnJzQVBQa0ZXY2pUOCsvdzdEanA0eFpXRUZEamd3aml5MWJRRXkzOXN0VHpL?=
 =?utf-8?B?TSt0ZEdZMldXdm52bGlkR2swTVBPZkk0b0NqYWkxZU51U2VxQjBSRGZ0N0Mz?=
 =?utf-8?B?bEY0cTFBMHZ5d3BQQTAvWWtlMGlwYis5WENyRTAzcFZEeFNGc09WN1I4dVM4?=
 =?utf-8?B?QXdCMVFheSthRjcyYk1tWUVBSW5haXYzM2gvajNUS0xGUmdrNXVDcHM0cnZI?=
 =?utf-8?B?bDJpb1RKeDh4emtBTEhnN01EMHlYU1MyYUtXVm54OFhRNGdUUjBVSmg3anhp?=
 =?utf-8?B?VmNYeUlVTEt6dWVXVFBhY0tGZWpQRUtUU3Jtc3htQ3huNnp4ZG12SEZjOHJC?=
 =?utf-8?B?RDBqV1l3RTBKRjFtMFdRSVVmQXBNVnR5ZzhMZEJBV0lmRGUwdE9XMEJHUkZw?=
 =?utf-8?B?aHNzVmxvbmV6SU5pSTJlY3RMK0lLcnNmRkVmNmI3VEZkYkVnVisza251QkJx?=
 =?utf-8?B?bGROL2szQWdIOE1VOU5RUm5JNzdoQlpWbVlIVllnM3FaNzdXWVRHeFd1TkpD?=
 =?utf-8?B?UEsrRVFyY2IxWHUxREkwdlpVYWFxSFJKRmVKc2NLMjk4eFUrMXkyVXpNK1F5?=
 =?utf-8?B?UzhRSW8ybk0reVZKRUNUSjk5dVFzemlPT1p2N1ZRSHVKNHJrQkZSeGc3Smt5?=
 =?utf-8?B?QUJJSnhKNzRHb2dUSjJTK2hiVWxlbU0xTWdmQzdSaW45Sk5VenpBN0NuU1Z2?=
 =?utf-8?B?NHplLzRyYjlGOC96OHJzWnd3ZGVIVVBneThjbm9Ed0pFTzRFN3BleHJJeHk3?=
 =?utf-8?B?cWFwS2pzaFR5TFNjMDJGRFMzL3hORXNnN0RMQjREN3pmdGhMaUFKS1N2NWw2?=
 =?utf-8?B?MXEvNFhrcEhnYWZmRG1wdmtQY0xnS05FTGFHcHMxZ1JXTXgxNTRGRmFtbkZo?=
 =?utf-8?B?dmtEYWNuaHVPTUVRSWJNdC9KZERHVjhGOTAyTkFGZFBYVmUvNU1zbFcxVmdG?=
 =?utf-8?B?Y0c0TnE4QjRKUEJleno2V085cXF4cDJNdTBlWGFxTU5WaStlU3ZNcjAveWlP?=
 =?utf-8?B?Z0U1ZnByL09iWXZ2dktxNnZaUGF4dWl4WkR5MXdWOGVNT1pUY3JhUlVCQ0R4?=
 =?utf-8?Q?EQ+++6qCEf3kivNo6ZK97VH0e/o5NMlH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODVOSEYzZXdZT25kY3RXM0paVEpFYVozOVBtaCtScTM3dzdNemlQZkRBTWwr?=
 =?utf-8?B?QUhuS3c5TzZLWkFRK0VhL2laamNIaFAxTnRHeFlGVGlTazlZR3pQTmpKSFZw?=
 =?utf-8?B?RW0yT2ZyNXlka3dMTWVsS2ZQdk1DSXBjMUR2MDhrcWJjK2xQVWl6N3N4Z2NV?=
 =?utf-8?B?dFJ0RWVVZmROZHNuMklNRFFMUC9kMXpCd2RGZEh6cG13SW1SMDJDNVM1c1NQ?=
 =?utf-8?B?LzlOeHBOQk5WMW5zTjJOSm5VR2RySmI3YVNPWGg0UFR6V0JJVzFFNWQvb01O?=
 =?utf-8?B?clQrRVl0aFRVVFZ2bHcxSmVnNWNtZFg4d0N0MVJJVkkxNXNKZk9MTGJhY3JV?=
 =?utf-8?B?bnltSUl2bE1ROFl3WkhEZzJEMWprNE91TmlacjhXR1BWblpMNUVkU0VSc2h3?=
 =?utf-8?B?YnJFSzZmVUJEY2lkWE5tU2ZXMlBmREt3Q3o1WjE5SFA5UjFqeG9rVXpvRDgr?=
 =?utf-8?B?R0JYYlB3TGlJUlNKV2ZxL0g0OFlKUm5qK1dOQTNRWVgzTHlUZmg1VWVTaUhR?=
 =?utf-8?B?aHFUczRXb0N2V09wMlhRR2tRNWEzOU53cVdCOUtDZFdhdU9MTVN3dCsvNkJ5?=
 =?utf-8?B?WG1VVFNhY0pqK1lseHJzS3d3Vld6b09tREkzN3B0VVhsV0dGMlFvYWk1MFI1?=
 =?utf-8?B?Q00yNytGc2k1elJaUlZxT283UTVteHFYS2s4NGowTmFCNUZSVDNQREp1dUZm?=
 =?utf-8?B?WW0wdkxVK0xtOGcybXo1OHJ3SDY5QmRtVzIrUjFhNmFUNWxwU1JoS1FCQS9j?=
 =?utf-8?B?K2hRZVVKeWNUNTZFU0xOQWo3OU9WdVB0ZWk5NTZEajgwSG8yL2NhKy96aWVm?=
 =?utf-8?B?L2U5NGcyMzF4dUJ1Tll1cEMrQ1IrRTdxSjJneWhyQmVVSHV4WE9TblF0VmM3?=
 =?utf-8?B?U09zQ3BadkZIUTNNS3pURFlRc2NVUzRsbjJkeGlyQTBEQkdtNTRWblZpZGFz?=
 =?utf-8?B?aWpxS0hiUXBncit1VHJQN3hvcDZWVEdHZm9QRTJHUjQxd2p0eTNobmNPSlJ3?=
 =?utf-8?B?MWV5a3JFUk5BY3NhQ0tJL2hSZnluQnd1R2paQWUvMG1YZmt2Q1NIVDh3WjNY?=
 =?utf-8?B?bU9ZdTFHRk01R29MWEh0UVRKUm5naUp6R3dWNHNZc3Jjelp6NE1ER21udmQz?=
 =?utf-8?B?VG4yeE80elZFWmNiRTN6UjNRNDc5NFhVSjhtNytyd2NoM1BjTURGTHFpSks5?=
 =?utf-8?B?VGFyTGZMTHdRbENNSGxUVTRYR1E0WURWZDhlR2ttbFpVNHhMTEZrRnFMYmlG?=
 =?utf-8?B?ZXh4QnZDNmJGYmt5anhldjJJNjlIcHhGeGNwMmxpZFJ4d2FabTMxMlpWMm1a?=
 =?utf-8?B?aWYyS1o1Y0VDWHFHNFB0Tm9WZ1JlSUVBWjZCZ20xVjNnalFOTHRVWW1rcjZQ?=
 =?utf-8?B?bFg5VG5yNlpvemNDTnJyWFBZdVdDU1lvQzNVeEUxYWxQeGp2R1pGOVJWSWFY?=
 =?utf-8?B?RWdpSnJuSTJSSVM5UUw5M3p6SXRyeUtxQXZ3bCtQY0J6MXBka0U1SnVTZG9O?=
 =?utf-8?B?MjlSTUlNWWZvYTcxcnVDUjAxSG1rcVhhK1VsWThRRi96enIvdzNiYXlWSERX?=
 =?utf-8?B?YmswdWdsR3hKZmNNVnBrcitKTXVDMHZHSTg2NGhQclcxcnhveERQV001REF0?=
 =?utf-8?B?eEhCR25wUXRFa0FzZzF3SmtXNEgzNVd6NWJHN09MZVBPRzJGcEFtT1lJTUdB?=
 =?utf-8?B?TXFDMUNGN1FFS2dBTHFQV3JwTmNvRExNVkh3V2pGKzUrWUt2YXVhZWdIZllL?=
 =?utf-8?B?NVgzT0cwZ0FxTC9HTjhPeWxwWXVDeitNNHFIOUlTQnRXVjVaeHM0cHU1T0Js?=
 =?utf-8?B?alNTM0l1a041WnZnczEzY3FSaWlrdkdiUnF5RW9BSUxzY3FSYndGb1ovWWQz?=
 =?utf-8?B?a24zTEZJYkp0dVFRT0VUMzBJZDk4Z3BxQjZITXRlTUdRL1lkNGlIVFM0RlY5?=
 =?utf-8?B?WTg2OFF1eTVZM0w0S3FMSWdlWWlVd3JBNGcxZUlMV013WktvVldUTTRHd1Ix?=
 =?utf-8?B?MzYzMXU4RkNDQk9WVEhxVDRXT2d3RlV4VGQyTnpENXB3NWI2b2p6S29sN1Zw?=
 =?utf-8?B?RGJOLzVXb0VuS2daQjF6WlJsUWtQN2V6S2ZWM2dqZEVEczl4WlRKSEswTDRV?=
 =?utf-8?B?ZUdKeGd3aW1sRlQ5N1h4R1ZXM2FwcEx4eUR3ZUVDbWsrZWl4NEI3bjNERTQw?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb67833b-8e1d-4717-448a-08dd3582ec24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:37:38.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBrllZDiVRiebvS13w4LasYLwQMX08w6H/ZvTpkn+u7NP5FbenUzNItI9NdYBGsqJq2JLiS1uf6fD1bxgvoju5pqe8lLgegM4zkDc4IzbqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

This adds support for setting BD address during hci registration. NXP
FW does not allow vendor commands unless it receives a reset command
after FW download and initialization done.
As a workaround, the .set_bdaddr callback function will first send the
HCI reset command, followed by the actual vendor command to set BD
address.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Signed-off-by: Kristian HusevÃ¥g Krohn <kristian.krohn@remarkable.no>
Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v4: hci0 interface shows RAW mode if 'local-bd-address' not defined and
    HCI_QUIRK_USE_BDADDR_PROPERTY is set. Add Quirk only if device tree
    property 'local-bd-address' found. (Neeraj)
v5: Initialize local variable ba, update Copywrite year. (Kristian)
---
 drivers/bluetooth/btnxpuart.c | 39 ++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..dd9161bfd52c 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  NXP Bluetooth driver
- *  Copyright 2023 NXP
+ *  Copyright 2023-2025 NXP
  */
 
 #include <linux/module.h>
@@ -1197,6 +1197,34 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	u8 data[8] = { 0xfe, 0x06, 0, 0, 0, 0, 0, 0 };
+	struct sk_buff *skb;
+	int err;
+
+	memcpy(data + 2, bdaddr, 6);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
+			   PTR_ERR(skb));
+		return err;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(data), data, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Changing device address failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1500,6 +1528,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	bdaddr_t ba = {0};
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1547,8 +1576,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	device_property_read_u8_array(&nxpdev->serdev->dev,
+				      "local-bd-address",
+				      (u8 *)&ba, sizeof(ba));
+	if (bacmp(&ba, BDADDR_ANY))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

