Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2136.outbound.protection.outlook.com [40.107.93.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A21DFFC
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834064; cv=fail; b=KX3mCZcQ1PgdWTPTb2kIIrqnXGoLv8WCzOftGBmGcBPVypBgc1tDN/amVxg7CpIArRpk+1K1Jf1YgLseVzaJ6GenegCA7R7DFk5nV0UyQHTRD5flYyWM2c6+AWxKwvhdBbqWfA672vV2nPjjJKyoxIiwEDDVO+SkN7xjbLtWZpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834064; c=relaxed/simple;
	bh=bBt5HPQe5N6esALzxgVZtkWN6JnMtskNTTQ8krl7GP8=;
	h=Date:From:Message-Id:to:subject:Content-Type:MIME-Version; b=oTcjjCGWGapHcd1r+DzTsLw37KQIWjwNsAYVv0YrVHDB9O5tlY2uTuTmG4+R7YqeQRvhQi1GryLEd3dEfhYhv0vdUKa3AtfQ5ZGoXogTS35F+IkELXmy41r1Px/RZ1UdGM2BGQSK3+jb2nL86lwTBDQfnYxmeX9Mu1osBQV6juo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alumni.caltech.edu; spf=pass smtp.mailfrom=alumni.caltech.edu; dkim=pass (2048-bit key) header.d=alumni.caltech.edu header.i=@alumni.caltech.edu header.b=E1Ooope0; arc=fail smtp.client-ip=40.107.93.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alumni.caltech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alumni.caltech.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alumni.caltech.edu header.i=@alumni.caltech.edu header.b="E1Ooope0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPFYjCgkvqsHem2CWlcR8Ed6X1DNxbUqpaMrhxxSX3VyGq7/N/AxnRFURsuflQ1fmmi45HC+Q93r1SMMwCCcBOnYU2Qer+iIXcgOjuhdGOl/WddRrHUAj+SSkdE/3rnCgfuHEAyGn0jYe0nza9Qx1S4h4a/Xj/RQY8azMlYUtpqphi0UL98s93vHCBM9qOUokLqSZkD0vEo6Mo9gr2xqUK2fDA2nT6YaaOZH1v7scpwNnacRjkfxUZcPc/S/WX3L007jeN0KkgEiARSpV/wiYk2fnYH+hY2XrPxfngL2n8tn/mfirNjsT4nGLgQi0pZDigRrs2JBjeUIJBHFrLgC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OanOkQ29SFGU1y0I3IRPBSVvj9c4O4GCTamy8ldKE8c=;
 b=KyzI5pzxXJ3OqZ01eqPCISNkcrkvTplFHaqkeOL0qporV4o49SO4asPp0Dhi6TWz5VGocbuPng6te7tJ1CPsXKPBEwxDKl35ZVPkZLI1CMBeSEAhmgA5sFFsxRBYIx3IoSaaP8Grf/47ye1jbM780I+QxrDVO9GGd8Xe6BAGI4bgMnpSBm1h8zqVdvb7cQpdnfQo6gEq69ZkXt/rbehohVxXUbvnJAMO7bQACpP1kZ/AseI5miDW/W0VsSPU+M3SWm9icVipvkMw6EeQAmBf7acAV3w1QgagtXEuHRTtLo/HOqox9v2PaRKKeq3uRuLBXeBqnJcg4tKWActk3+G+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alumni.caltech.edu; dmarc=pass action=none
 header.from=alumni.caltech.edu; dkim=pass header.d=alumni.caltech.edu;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alumni.caltech.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OanOkQ29SFGU1y0I3IRPBSVvj9c4O4GCTamy8ldKE8c=;
 b=E1Ooope0CVFkX//eVG5dkSzSz+t3bO98KMCAN76Fl4qaX525+YKUHmW/2ig9Djy53QY+sGVPy7d2OwDVsaIc3neIVVK52Cs9SlVtm15JBl+tivq3QCJQlDfPBLii6KV7XAbJ4zGUk0X1bRyEECpMu8cRvN/ZCrd8dVltNl+G8M3A3Ve8UsKwD2mDVckqSEHT52Qy6pJFH7T/dE/v7a3pjlgkW3NymXJ/XHQDwn9vQvMIlYRbkTcQ1jAqLoDSh8cz5zftEEQZFiNd7jj9kEzwvwq3lY4dVOCTEQ89uk80qzM4+xrwy7WrFEhJmE+uUM0xuxD288Cg6IkipnchyxC2jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alumni.caltech.edu;
Received: from SJ0PR03MB6485.namprd03.prod.outlook.com (2603:10b6:a03:398::5)
 by BN5PR03MB8055.namprd03.prod.outlook.com (2603:10b6:408:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Sun, 13 Oct
 2024 15:40:58 +0000
Received: from SJ0PR03MB6485.namprd03.prod.outlook.com
 ([fe80::3ad1:85f0:a873:33c0]) by SJ0PR03MB6485.namprd03.prod.outlook.com
 ([fe80::3ad1:85f0:a873:33c0%6]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 15:40:57 +0000
Date: Sun, 13 Oct 2024 09:40:53 -0600
From: rbell@alumni.caltech.edu
Message-Id: <202410131540.49DFer5C020925@randytool.net>
to: "The excellent bluez mailing list!!" <linux-bluetooth@vger.kernel.org>
subject: src/plugin.c:init_plugin() System does not support ccp plugin
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:610:e6::6) To SJ0PR03MB6485.namprd03.prod.outlook.com
 (2603:10b6:a03:398::5)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6485:EE_|BN5PR03MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: be8772a9-b82e-4240-8575-08dceb9d6e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7b04EWbcLTkJwp0BAXUKLLUfSWyyvTTYMuM2WDGcXXmxwFFvmWtbxB60zPo?=
 =?us-ascii?Q?9OGuVgNLmx7LqiBqN25d4tO01dpBFd78Ipn8T4cROhOECRcwNB7Os64Hw+6o?=
 =?us-ascii?Q?3hvUrNpx4S+SrOewwPFAcOqa9AtNwTzJiLFjNBa2Wlf8i0bcHbfnI9lhAXav?=
 =?us-ascii?Q?NrrgTHNs3yYkLnLWHjne4T3VfObuG+KH6Qz2NRuHLZ4R7mMGM96pO+pdGozq?=
 =?us-ascii?Q?xh5wHCqu3b3xd3yoJHb9CuHSC/MmPT0fEkzDq3A1CYbLvm9ui42/WGidLaPu?=
 =?us-ascii?Q?KotLXk65Rg/R9t1iVqzYwGwmiuraeOxxvsKWsh9zeSn5FG8KjnT6qzcq5+ZR?=
 =?us-ascii?Q?V5qEjZjzCLcZSUNkXhMzcHApHbTUJtKgrKR/diAdL8fTbJz+v9hmhyJtBn/X?=
 =?us-ascii?Q?ggY/uR3C4KQMGf2iWBbHYUJqP2klofYeKlMtysLRegi0wZsvCPR4ezkBhtUi?=
 =?us-ascii?Q?b1QNhGUmnKIHe3H3fIxxWAwYYE8FqTDBAJFSQT45g6U45EI7SpFo9ulZRczu?=
 =?us-ascii?Q?3QK0iQ+JEScVM2FFVXgHITYJ84+tWfUNvmnE3PnCNuH8f7AOgeEZh2fK8YqY?=
 =?us-ascii?Q?glHQ+p3sm5F9I2So6z7p1rnUZSPJbduzb+0qPnVIRAvSjCYNQNiOCGgjXaHg?=
 =?us-ascii?Q?m12mf/zrKChrEygV5vEBi820LnttNlZxhf2PZGztZ5VRScQwK67XPWGT9eay?=
 =?us-ascii?Q?ocDgMpW3cHBGJPS9fFJVwivYVmR8zq2LttJ9cmrQaL17w39TVOqQVldYm2jN?=
 =?us-ascii?Q?h8bSCZ5oOxsagjPqgCF8qRmpMTAmW1BvHqDJoJHBJ3ailFGreAXKvx5d7/8+?=
 =?us-ascii?Q?HQAeDf3emIl5PT5BnbdBSlTlFL+TZ5EMpDlRLHs8RcopOLZSM5R6g4vib10x?=
 =?us-ascii?Q?gQkrA0mWHDsOnCXtb3UJJBf30FQtxfreb7vMgiyA76S9CbTL0iBXIR36eAYs?=
 =?us-ascii?Q?cZP5mSYycvUwJXudCu6r1bhctqQS8WYctsU+gwb6iHoPCwxhrawdmbx920k2?=
 =?us-ascii?Q?vO+ZGwvyR78cIjs8s1f/w9qc8q0wWyTt6kaBZvdPM5NmK7SJSiHZLaMvRmP/?=
 =?us-ascii?Q?cXG1DlsONv303Q6k94+Xchh3W91gu9wnAq9rDN+QCvIElT1H6K1qA34ptvMJ?=
 =?us-ascii?Q?7aTAF8U11Yl+43RYa98pFBwrsRbf2m/1oeclxJ6kCe0AEKiM1FhWAif/IzSp?=
 =?us-ascii?Q?vjDyvoiYyX24tPFoKgnjm1LFjAMx5yEgnYA+ou1bXQMVzUPSJB1+UHwUw8FL?=
 =?us-ascii?Q?7r+hIiBXiXH3wWV7vTj+Q+am7m3cMCc+Fi08wh5vXNKMF5rHplnurA8iu8TN?=
 =?us-ascii?Q?U3n4Ffn6nN8fn7LxAzRb7hzXUzQnM4sFMJmFqY0WGE/w1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6485.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wP0NzrMnVI94kQzrI8yhfXQWt5wrOlYiJlPjIxINZEB5dZIpFdjjhXulddoF?=
 =?us-ascii?Q?90/+oyaPCiGTXK9WJkxw3MbDS/GF6j0QvIg+yjY4X52oIdIDmloR+z+pNYq7?=
 =?us-ascii?Q?NFMJaQrCYGF30HFsRPprAU6ZaAPL+Mf8GTSmzv9sx3GyJ9z0EFl8rH0r5U1a?=
 =?us-ascii?Q?+u93X+4485Ek8NH2+RcKjJ3hTZkyconlKabnoUsJBzfpk64jZli94hbhqDkV?=
 =?us-ascii?Q?eojclT1Buhz+MFEn3Vku+3Ikk3w7xbqx6pk01yO8f0E0N+cUD5HuQekLXG5Z?=
 =?us-ascii?Q?fK3Qt5kMU4bTemI+mBUkE5SbuEfS7iWQYmvxMKD/V9oXYDapvwlzAWch4x7q?=
 =?us-ascii?Q?TzA0W157QM16LlhTZP/CdXmg3KBSomEeDWHgYQ5s6SrdC6Y11w3ixjJkDawK?=
 =?us-ascii?Q?3Tj2XgcxYzJjT0KJdcdgrmdJIrTNIBGQLD/Nc3bV+giHh0Qe/3RQBxBUP9c3?=
 =?us-ascii?Q?Om8DxLTGCk47Olxn0OFmOgrGM+VrdRFzpfxyFCrH8uS/3y32M+1iB/BRcfSj?=
 =?us-ascii?Q?yH5bZ0XKhnFc3RVC3mPYCiS27llgbhQ6vXIC2XsNBGM7m/phkoSV4A0ounBP?=
 =?us-ascii?Q?1MJFSX5+K/RcaXe4UlyNS+hXGnLvQG/reB97R2qaIcs9Xussnfw4lvOpErR1?=
 =?us-ascii?Q?BDVOldr95YntjjIdusjoVo7s9OOT2WP2T/I+Whm7Flt9pd1lckVj8ZKlLN+3?=
 =?us-ascii?Q?L4RvEg61zFNgUjS7Gp2Noyn2kwuTRDVjV01Hhb/G4Sy8zgJKNkRu7wCXYuRM?=
 =?us-ascii?Q?/bsLhsyZC+wc6tFbf9jRFM7ILTccb5jqOAKaUC7QYJuLxdkwhKY4X1V4RZMj?=
 =?us-ascii?Q?8rMjtIp4q43Q6+OpoFHu+oNGaDT1aZMPToUq/FnvP+WF3TGoOl+9B5xP4gfJ?=
 =?us-ascii?Q?mb++CleoIx+C7qOc4uNzXHCqy2qlDAFF8COGJu/eNBNCi3j5F9l/khoW9oHw?=
 =?us-ascii?Q?yxpO0gYZPJG8XH8S2Vf/boYKhHN1TNFTfhSiDTkGPr/qeQHbnT16nE9J8u9y?=
 =?us-ascii?Q?t8rIqySd9eMfXJplafOmcqYR6EL95F/iBHmQUhvS3mwYIQu4QAo9ZHcto1uQ?=
 =?us-ascii?Q?GFv0/kDM5o/FJbCtRc9LYnTs35Mjd+wzdO/mlYW0EFdYaWnMOq8QaHk9nliR?=
 =?us-ascii?Q?tttqdDewAI8AXA4F+cOaxaIumYE4FPk+10+q3rznyiu6Zx23zf/i1vGjV1N5?=
 =?us-ascii?Q?7UeXezZbjWVxQfaeKXtMMZEqUiERRtr3a+wkgyfqTrY+oHJEJ1YZug16SJbD?=
 =?us-ascii?Q?rb7/vN1D8CpNzkemkUOlztcmQy4amh1AcKGRepJMZMjAzJp0vPuiBHlJROQT?=
 =?us-ascii?Q?aMNMBqrAncfl4bOCb4+fTf8PprCpC3ja3Wxklb7HqxXAbc3WAVBDn3CFlcUq?=
 =?us-ascii?Q?pxO2a7DNv4GjJUfdef5s4FI+P2+UhWjOYBSAAL+5jVJV9GxUyNfyqh3SlTvr?=
 =?us-ascii?Q?TY/dmhES4AYTvR0JRBMMc+7KaeZ7l7ySGiBrlY+agTUvCSNeYD7iGOoOU6M9?=
 =?us-ascii?Q?4OwC/h+6Bknsqc3ZJDA2mP3kMiPyOnKymMd0qFcDqx/wrYNP7RZV28aurSFg?=
 =?us-ascii?Q?c9jGrlqitqZEffF8FxQvTf3hY/awMakUU+S5T0J5tdL3SJhOQj0sNlTaYeAF?=
 =?us-ascii?Q?qCIrVyazYp1l/5fBor0dcEY=3D?=
X-OriginatorOrg: alumni.caltech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: be8772a9-b82e-4240-8575-08dceb9d6e6e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6485.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 15:40:57.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd5be9d9-7b72-4df9-830e-b1f9cc5b44bd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxlKEOhpOQLvnq2BCfr4q+bCjrR0qMiaKzEX3/VHd5N/JPyZ8MjBtdaykqY2gFKH+YmXjjMTK8P9Aqf8ddYUXXZQL7XzzqDYz1rDsekBcoKckUdcwv/1X7BJNoclJrV0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8055

	bluetooth stopped recognizing any of my controllers Saturday
morning.  (They work on a different computer.)  I get:

	Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding workarounds and force-suspending once... 
	Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround 
	Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: HCI Delete Stored Link Key command is advertised, but not supported. 
	Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: HCI Read Default Erroneous Data Reporting command is advertised, but not supported.
       	Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: HCI Set Event Filter command not supported. 
	Oct 11 09:59:15 mydomain kernel: Bluetooth: hci0: Opcode 0x1004 failed: -110 
	Oct 11 09:59:15 mydomain kernel: Bluetooth: hci0: command 0x1004 tx timeout
	Oct 11 09:59:25 mydomain bluetoothd[30412]: src/plugin.c:init_plugin() System does not support ccp plugin
	Oct 11 09:59:36 mydomain kernel: Bluetooth: hci0: CSR: Local version failed (-110)


	What does the ccp plugin do?  What support could it be missing?

	Thanks for your attention.

russell bell
