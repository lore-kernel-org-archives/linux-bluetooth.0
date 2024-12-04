Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717E1B4130
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330928; cv=fail; b=Ww51Df6RB4gkbyUJIkqPtpSNmXzhBFXVXafl2JPpZwV1RRj9BuDH/sc+mH43C4U2stz1nOzC3cRf7wzyNcBeywv5n+wiPuc4rrXHcO287gDEmjY8wXnXP/qRPkvfdFBRrC5ULx1wTM7gUQMz1smrZ1kxlraq0Iv5rezZJdBIZ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330928; c=relaxed/simple;
	bh=PGDp6THPuwXAyA10YmQuuCgvDZ5Jz8mSFYLa9x4ZXAE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rdXWPnVGAvKfgVeUhHG1ZZjlFhYwaqut4FOTlGet0iptF3+//rbroN7saPTy6NyfCEmYvFNTzWTLe12354I35sooXh7B1rpq3YEZwG3loNy9DgDtlvl0UWy0yh0qtQY/8AykgNZsBEhGmTs2hO8cvoRVvZin5K8FBpudih/C7Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SiJM3qTo; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiJM3qTo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riRcPqvj87xmHmAyTIJuIeKnwZZm9O8MhRSrsg1VhKSto8cqFGt8PG+CM9ABSVi/nGd4eMHWTLN5DtSubzRAHoX+7DpsAlv1j+g94XAzTUMy/G9emzNxAGlvAvovJUH4TpBpr8sgjVjfuQrlaxsdRRDooeyXoVO4FU+xVhp3hQLXHT/SWQ2atnfZCfsUZhQLEMQ+0HiDWG6jUXFIZmFwVwDvKvvASrS0E6j5ey63qlLabzRzB1cDnw2Y2UMo+yxtkeko+J8kqG0aoODBE2k4cMGfwgVhYEBgcSfQqNrLrr4yTYs/tvrhkLLHwwkEgTAfSShWZRg0TasYuipas4aS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwT3W/O1rJE4Udu7RbitmRICFmhWzWwuYvm6Z9zQkqc=;
 b=hwFUj1bT5j9AAItmAbHKOk/EhGOqKiYgONmecVcDP7IfM/0Sz3WhntaVctmp9natZZGMvp0VPp5VtCrMq+SoBlswyPlYG6Y+YtfeYDygf+633MRECYtD+13XAPDZCiSbGvXgppvh2twGYIn5m3xakQGJ/Mp86dMZozzCRqMK3f4V5/kz4fXd88UVDtppoC1A9rGNG4GxM8ABlrRDo9Xlxp/kB0z7QT9OaaNdq+5EbmRJIZ3dCIu3VOpfIJUr1qlVlU8GPyLUuQo0MEQyBelxMKvPs6RasyZnIxXniWWb3unOwpra7cm6Zy4H0uneEA4mHwD+zOO+KsIz4z49HZfnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwT3W/O1rJE4Udu7RbitmRICFmhWzWwuYvm6Z9zQkqc=;
 b=SiJM3qToGK4naHNYlmVpP9GTHmWjFurh7415wlm3lC7fB2EaXKRduiP0g50qImeyjTfeOkoeerwG18KKyMKjlHen0N8WrxxizoQZED4Yv6Oa2mT1mqVAqqIce1ok6fxrTb2mSLkP8PyraES33ESrOFbvijFiUh0JyLzrzwBkIwPEjudnG4bDsDHlbxI2H5VLv6fae7KGB1u/GFW8pmxfsuJRuWZVvbT4MwtndOzFSq+SwIwf14UJs4rd8CQC5QhOfyugb/mXTLLSfa9VtNKYCANzAQJvXYu7ZfUW8HCpLfK3wDj8OKwNttkwdtmx7tM7s+J1s+3nJ8zL/DlpMIqK0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB9001.eurprd04.prod.outlook.com (2603:10a6:20b:408::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:48:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 16:48:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: hci_event: Fix use after free error
Date: Wed,  4 Dec 2024 18:48:38 +0200
Message-ID: <20241204164840.14037-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0102.eurprd02.prod.outlook.com
 (2603:10a6:208:154::43) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: a28de5c5-93bd-4aff-a608-08dd14838326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aC8u9afHvGMiaqHYUbo3Hhk3Zb6e/OumVY36i47AfiaCaNINuf6Prl4xXz2L?=
 =?us-ascii?Q?KlCRyZDTbcragf2xwUpbCkseePXxH7LhHbDdZMG2W554H5+8KEqHN0xbwwdT?=
 =?us-ascii?Q?Os/LmnSexREJuG5L3GKhz2oMayaqh5EGvJ0E7L18Zp05xXXf8yp/fWENezOd?=
 =?us-ascii?Q?78Ue7DLSFHi37sIn/Jeqc48P/q1NVPDh+tOpVsipt6RHVqxQAqnTJRafk8xR?=
 =?us-ascii?Q?lb45XuX5FU/dpTtFlO3ti3X20kU/fuAYtdroj711J00OkDymBTAUABdDiAvM?=
 =?us-ascii?Q?25hiOUBwrLfnd8yKBgvWSrON/tFtehfrwAVdo/ORmGjTa1Ds9jZsxhtLcJVu?=
 =?us-ascii?Q?4cx96nlkKY6a/xzKiiemryN7ubJzxxPZxUZnFps1IaoNgJhy51sqUzz3NF4T?=
 =?us-ascii?Q?LdwhabA8NntndI9O2Rvikaid2GmJ+ekPR8ynnlWZlwF2/NNHB4KzI4oG3zxz?=
 =?us-ascii?Q?Y4BRFdrzqF6BAaj0KtV2MxfHhUmru0q1VHNwFtXXXEMzDRsP7m+qRADAu5Yl?=
 =?us-ascii?Q?VvnG0Hs8LkYB3b/X9IvtcIgusG3o8hzhE0kHDregj/7mMfb1AeTPstNUHMuI?=
 =?us-ascii?Q?AhyNCgVugmp8EIpnff/xm7nDnBylK0ihwG1cmf8Czi6bih1kAHqeEocr/slu?=
 =?us-ascii?Q?BYUbcVy2WQkXMWJKvDoORQYpvUFOdJ7RrC6d8y/SBFhpw4UyoaWbBzR6FOey?=
 =?us-ascii?Q?Ca3/KuHSWcNXm4Dg1eW0ed4TVkdF6yfcIEnG+KbX3+HEHVQy//M5ztXHpkHB?=
 =?us-ascii?Q?ptIqKztVvsC+tOt+Z7Ml2LwK31kZ1PO/RYGdBRV5N7Ma8bpbrNod5qFU60dz?=
 =?us-ascii?Q?Jp5tA499DHpLZUlBNM8enJ0SGYCuFAZ05kknyZXARBrnkH8o/CjFE4bEbK8A?=
 =?us-ascii?Q?88VD52rCGSmTiNJWGVZmkhsxzeLxRbnJhn07BzkBbxCljLa24AhDLBR0B1Zg?=
 =?us-ascii?Q?87IS8ZWV9t3XTmVpXpdP7ZAfRAps6AumaROANA0gKePJZa1Pal4lAiLCzxKC?=
 =?us-ascii?Q?nojgqtO2uAxsKmsNvrAjBqp/1GPWJrViD4nmqemKeNcLG51Qaj8y8Fom2MYW?=
 =?us-ascii?Q?RrKvsfuTnAn17sMpUHWlDUxkRIRNPT0QXS1Gf/kCIwHChHLicwYI0gz93diy?=
 =?us-ascii?Q?QeJFH0jOboEJNckZlRyrYyVV/JgRqZ7Jbnhv2l0NMAF05TtozsyWv86DQ7xT?=
 =?us-ascii?Q?AS/Cqt+eTzvzTmQ4c5tF/4FfjDZHj9K3MucPQ5FLEkGIvAUFi+FEcH/ZqvPe?=
 =?us-ascii?Q?ElT1AqKgWrq6vhPwAwHikYlmkBpQr3PftKeyFDw/bDpe+DGi4tC3yUEMSIaN?=
 =?us-ascii?Q?iK00mAO+xocrTMbpEPHcpx/DZu0fWfDK8YE61Pb05MEqiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/A4G+xoclsq8YqylVqesvtewGRcQ6DmrCFbT3Q8zDlZCxQnkWt5CdabD4Onw?=
 =?us-ascii?Q?mYTFIJqD6Q3IeTwKFZagrlps5aVJln03aIcJSm+rSnyXOklwzzAq2eSF/9Y4?=
 =?us-ascii?Q?WGSOvCg5TmXPcwl1RPTCnL2vqTFsKH9GFwOKIhzfaafRxsknZk6lrGEI9Sk+?=
 =?us-ascii?Q?sHUEjQ3VGtj6leazca/wfIw0lqNuBXkZrKg+cqk3cXX+Qh31u6BnytuG/tPB?=
 =?us-ascii?Q?X3s3lWQQ3NZQ8RLD5x6NzSlzXm7UIrGjhpmTS+AGMumQwwSBo2EA8zY7Ru7X?=
 =?us-ascii?Q?g4I/rEHLElG6BCdnF+CH2Y6o7whL/8lVLkWcEE/ZmXiTmkqrt5GYNInottGb?=
 =?us-ascii?Q?7KP7qFC3aOlqqh410NsJ/AMyV4+3Z6jRrsEul99ZJQ9fomLFQ8YIC20XM9l9?=
 =?us-ascii?Q?oTwxar/9COH4vRWr+DmYZ48lHePctPfO2sQ4WBBbWrX8BrL9YG1lBkvTAi+y?=
 =?us-ascii?Q?7c9C4Pyk8FakRCfrqr0XTAijfLheuUGRQmEhfDkCbft56aRbbXVzA2bJt/B5?=
 =?us-ascii?Q?eVFsHsuDlo5zn3td7GueWDDyQSR9g+dZs4hiXuiYbgp5SXGU0ufDtnqP+oOs?=
 =?us-ascii?Q?JABD7duzHeX0qjZFqKAZw9xfdyb6Z/B9uLC+rzc21eJd3bElV762ehwfrsXH?=
 =?us-ascii?Q?XRruHVXIUEePeX8olUwiBkYX/qDzfwHkIOb5T/jk/gU7dztkqkpM5H4JnHbO?=
 =?us-ascii?Q?kj1YvLhRYvxD7mLM6DaRR4UtmXuZ7aztdeECxfCPD0ZExNQWGEP9cHOeTtKR?=
 =?us-ascii?Q?Uhx7CnXv4m47t83rSpYXGG+FyypyL2FBjpSdY4KRgaAtQcPUycuCUrYXn/xa?=
 =?us-ascii?Q?6MeOF3kw2ekFYt1qjMx4p8BnexKa0L13OsefmZY12FFvYnKim8wXPplp0DNa?=
 =?us-ascii?Q?KkigBDUvhCZHbKihquMNq9GKSZo/8ymf0Aa7CCgBqfWRs2MjiBXz/WRoTsLX?=
 =?us-ascii?Q?uUjd8ZV9OctZJx1MQmg2T7rCR5Avx+shgK9YNLEulaqe92isaR4EyGSYlY7s?=
 =?us-ascii?Q?nJJvo4VcXw/ijeUGWfeNLcZJ6csKb5ZFpyFV9kvX0leERCO5fSyr6RiTNmAZ?=
 =?us-ascii?Q?dRVHrOC7H9DdvUNTBEJOf4vG9rLTgTkLXUnvAUZigz1JyKoHOZjyOQC4/XMl?=
 =?us-ascii?Q?N3XGXEwpaowT+33xhT98c5YS9rJPx/HyGJGYYiH3kg8g/DtPVbLbw6069hNb?=
 =?us-ascii?Q?OaEfuTjWUr2eiLcbipeUHKJO5kolfaXgiqNsZKQSXwHr4IaXhs5/oJjM2wV5?=
 =?us-ascii?Q?YbZNhvFhMTD0ts+Mq5UjOmJJbbKtXnwsfXfCRkHDuAYpK7cLqcW/6lLGVWen?=
 =?us-ascii?Q?7piehAumaGpgxKLez7nE3rxhaB1HcKS/wLIyMQkEevCF58UpftL4+YIoyUmR?=
 =?us-ascii?Q?7by7QCAOx2i4/n6sgP1bpc+ZyTbPNFKUyRArT1I7rgJIIrcae1U+YuWMuYC/?=
 =?us-ascii?Q?ALQlQdOflYun3O5dn0mcK4rqkBdXhQT0ak/VrCfqvNWPw8voemmAbOZKpOAd?=
 =?us-ascii?Q?GZvNpYGti10u9F6yYj/kxUnaXZAh2dQ54BCXTIYpfO5oo2/d5qiOj1C85DMy?=
 =?us-ascii?Q?mI6d2cIHkgEPi40prVj97ul3uXdoBDE977p2LzhlHH8lrcAQzVXHb80CkD8B?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28de5c5-93bd-4aff-a608-08dd14838326
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:48:43.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYXlq4tTL9V+DuO7pL9/uXdLVH6GES04p12ZqbrE5CBTUm+Y7dZXUubwE9+4ry9WBHmcCRrqEj1r7+VjHyXqAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9001

This removes the hci_conn_del call while the conn_hash list is iterated
through, fixing the use after free error below:

[   82.961619] BUG: KASAN: slab-use-after-free in
               hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
[   82.961688] Read of size 8 at addr ffff88811fc0c000 by task
               kworker/u81:2/2806

[   82.961697] CPU: 10 UID: 0 PID: 2806 Comm: kworker/u81:2
[   82.961704] Tainted: [W]=WARN
[   82.961707] Hardware name: Dell Inc. Precision 3571/07K1M2,
               BIOS 1.11.0 12/12/2022
[   82.961711] Workqueue: hci0 hci_rx_work [bluetooth]
[   82.961780] Call Trace:
[   82.961783]  <TASK>
[   82.961787]  dump_stack_lvl+0x91/0xf0
[   82.961796]  print_report+0xd1/0x670
[   82.961803]  ? __virt_addr_valid+0x23a/0x440
[   82.961810]  ? kasan_complete_mode_report_info+0x6a/0x200
[   82.961816]  kasan_report+0xed/0x130
[   82.961821]  ? hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
[   82.961900]  ? hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
[   82.961963]  ? hci_le_create_big_complete_evt+0x427/0x9e0 [bluetooth]
[   82.962009]  __asan_report_load8_noabort+0x14/0x30
[   82.962012]  hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
[   82.962080]  ? __pfx_hci_le_create_big_complete_evt+0x10/0x10
                [bluetooth]
[   82.962130]  hci_le_meta_evt+0x26c/0x660 [bluetooth]
[   82.962194]  ? __pfx_hci_le_create_big_complete_evt+0x10/0x10
                [bluetooth]
[   82.962245]  hci_event_packet+0x55e/0x10c0 [bluetooth]
[   82.962291]  ? __pfx_hci_le_meta_evt+0x10/0x10 [bluetooth]
[   82.962337]  ? __pfx_hci_event_packet+0x10/0x10 [bluetooth]
[   82.962389]  ? __kasan_check_read+0x11/0x20
[   82.962395]  hci_rx_work+0x365/0x1310 [bluetooth]
[   82.962471]  ? lock_acquire+0x7c/0xc0
[   82.962476]  process_one_work+0x859/0x1a10
[   82.962481]  ? __pfx_process_one_work+0x10/0x10
[   82.962483]  ? do_raw_spin_lock+0x137/0x290
[   82.962488]  ? assign_work+0x16f/0x280
[   82.962492]  ? lock_is_held_type+0xa3/0x130
[   82.962496]  worker_thread+0x6eb/0x11e0
[   82.962501]  ? __pfx_worker_thread+0x10/0x10
[   82.962503]  kthread+0x2f0/0x3e0
[   82.962506]  ? __pfx_kthread+0x10/0x10
[   82.962509]  ret_from_fork+0x44/0x90
[   82.962513]  ? __pfx_kthread+0x10/0x10
[   82.962516]  ret_from_fork_asm+0x1a/0x30
[   82.962525]  </TASK>

[   82.962531] Allocated by task 3161:
[   82.962535]  kasan_save_stack+0x39/0x70
[   82.962540]  kasan_save_track+0x14/0x40
[   82.962544]  kasan_save_alloc_info+0x37/0x60
[   82.962548]  __kasan_kmalloc+0xc3/0xd0
[   82.962552]  __kmalloc_cache_noprof+0x196/0x3e0
[   82.962557]  __hci_conn_add+0x163/0x18c0 [bluetooth]
[   82.962634]  hci_conn_add_unset+0x53/0xe0 [bluetooth]
[   82.962708]  hci_bind_bis+0x9b2/0x1a40 [bluetooth]
[   82.962783]  iso_sock_connect+0x7a9/0xd10 [bluetooth]
[   82.962853]  __sys_connect_file+0x145/0x1b0
[   82.962859]  __sys_connect+0x113/0x140
[   82.962864]  __x64_sys_connect+0x72/0xc0
[   82.962868]  x64_sys_call+0x21c0/0x25f0
[   82.962873]  do_syscall_64+0x87/0x150
[   82.962878]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   82.962886] Freed by task 2806:
[   82.962889]  kasan_save_stack+0x39/0x70
[   82.962893]  kasan_save_track+0x14/0x40
[   82.962898]  kasan_save_free_info+0x3b/0x60
[   82.962901]  __kasan_slab_free+0x52/0x80
[   82.962906]  kfree+0x148/0x480
[   82.962910]  bt_link_release+0x15/0x20 [bluetooth]
[   82.962983]  device_release+0x9d/0x220
[   82.962988]  kobject_put+0x18a/0x470
[   82.962992]  put_device+0x13/0x30
[   82.962996]  hci_conn_del_sysfs+0x114/0x150 [bluetooth]
[   82.963072]  hci_conn_del+0x366/0xc00 [bluetooth]
[   82.963145]  hci_le_create_big_complete_evt+0x43c/0x9e0 [bluetooth]
[   82.963217]  hci_le_meta_evt+0x26c/0x660 [bluetooth]
[   82.963290]  hci_event_packet+0x55e/0x10c0 [bluetooth]
[   82.963345]  hci_rx_work+0x365/0x1310 [bluetooth]
[   82.963389]  process_one_work+0x859/0x1a10
[   82.963391]  worker_thread+0x6eb/0x11e0
[   82.963394]  kthread+0x2f0/0x3e0
[   82.963396]  ret_from_fork+0x44/0x90
[   82.963399]  ret_from_fork_asm+0x1a/0x30

[   82.963403] Last potentially related work creation:
[   82.963405]  kasan_save_stack+0x39/0x70
[   82.963408]  __kasan_record_aux_stack+0xae/0xd0
[   82.963410]  kasan_record_aux_stack_noalloc+0xb/0x20
[   82.963413]  __queue_work+0x318/0x1100
[   82.963415]  __queue_delayed_work+0x1cf/0x2d0
[   82.963417]  queue_delayed_work_on+0x8c/0xd0
[   82.963419]  iso_conn_put+0x256/0x460 [bluetooth]
[   82.963460]  iso_chan_del+0x9a/0x240 [bluetooth]
[   82.963499]  iso_conn_del+0x149/0x280 [bluetooth]
[   82.963538]  iso_connect_cfm+0x374/0x1430 [bluetooth]
[   82.963577]  hci_le_create_big_complete_evt+0x39b/0x9e0 [bluetooth]
[   82.963622]  hci_le_meta_evt+0x26c/0x660 [bluetooth]
[   82.963667]  hci_event_packet+0x55e/0x10c0 [bluetooth]
[   82.963713]  hci_rx_work+0x365/0x1310 [bluetooth]
[   82.963756]  process_one_work+0x859/0x1a10
[   82.963758]  worker_thread+0x6eb/0x11e0
[   82.963760]  kthread+0x2f0/0x3e0
[   82.963762]  ret_from_fork+0x44/0x90
[   82.963765]  ret_from_fork_asm+0x1a/0x30

Iulia Tanasescu (1):
  Bluetooth: hci_event: Fix use after free error

 net/bluetooth/hci_event.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)


base-commit: 47ebf099106eb021cf7dd677720e6469a38785a5
-- 
2.43.0

