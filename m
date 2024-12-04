Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50E20C474
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330930; cv=fail; b=kvJRgG9lOh/Oy2DaQ0d4uwc1uP5L2oJCdSbnMIl1oP0F6IIWCuOWCHSZUqtr//AhXFzmnrObU97gp/sQyC10vTfCHji1HWq/qFw4D8kuDIVmRfOKMIDCEjhYTkfe2fMVaHlto0X/Ubd6FMKkIXGw+rCNxxuPzqqL/oFiuMzqqfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330930; c=relaxed/simple;
	bh=Hk7N0gRo/qYhzF1jJsx1t58iRr/Khic8VRTfllrc1K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhiEFGJcSNDWISxt1gtAJD55+L9lAhyDeyTgLRRG0iXdob4o2CWLOkq8TgLOMwGQTyLItAYmfpbsW1CzYDcegwuwCfNO2cbuLtecLLh50uv31JUtMgTHMfVwDUoFotTK0MGHH8uAOL00uJpeAvL2XXbou9lN13jw81JSwrBLY/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q/ui/gKL; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q/ui/gKL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASAzvjYtARfe+r/DHwL9L5cAo3I9eCUEjX9s1ko6h7ESGSioYmPjYEGKVhCf2Lgu1INBfqW/8MJ2JA/nRw7ZQswhShINMrszElASqAVJMFLid9mxCVVQ05XckSs2TZ/nhWoHCdX/FosQM4eS5Kp5xU8IUFD1iYgMjxqW+KCxumHPZaE/GVgPuuhdrT730G9Lwa+RY+8cNGoq5Zo3vyc8xjSbnoFdo/7OFXOQAgfmgkXv8P3mBGZNV3Ngqrxxi5Wk3JTfC9t2Q6UGadkaKtM4YaV7wl1NhgqmwfCUaA7Noi+5twPJT4SajaiCIIIFuXnES349yjQDv0ZH7anOLacYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlKDoMO5Ir3JVQcKUIjZO75Uy3tpayVoPO3wDrz5cbQ=;
 b=Cu+VKwJU3zFLfVT1rlEnFaT1yOL6m5A5u7EQWIsCT+dVQopoMwno7MQe6Eh3qtTFJLEKMZNDF1qD/ZYLL/SFjvVwwyuoIeh5+SeGl3TOtEtfMpnosexNJE9051czv5j19v56UK6WrBewTZ6mW8fNmVigHe/gfCZpZkv/csIupZ4sfrJbeQU4McRxwFZvkKuBmGqZHihflAzc2i8ZzaQ+51THabTnNOyntHKMNW7/XW1HdQTSKMhz/EKxDw1PlaomMHsQWkXpFzTMpPfgKGIxfCd5+CXsAT47Hn8rJleEp6DmEEhdC7jifpP8aXMj4VA3sXrWd+NHzhpPQMfAJBtLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlKDoMO5Ir3JVQcKUIjZO75Uy3tpayVoPO3wDrz5cbQ=;
 b=Q/ui/gKL1YpE4yu+GUgdqvFcnVSSqWDmkDTT7mycYmO5uFqoUPIS5XJCTaBzbsHJ8Uu7APScPppuXmnNos3dVVQeY+Vwl81nWj5LVFt3/W7wZE2s2DTsZ4P/um8mg2SjNDHNTHSZo/62m30Y874V2FMjnqbnhzjQB9qMCFFV8+NbF1kJji0DB0okrHELmQuolRON9RITGuUeE/9fAVnzAhoobpIfrxmb61oxBCqUG8BIbR6kkpQXmFBm1aCsFrE7i/cUrjzj9smkyaqrhnGbOr8JDHZC9WkdyCSe69+NcnEAOQddg44Wz6G8cNjbWXqBCTheoleTtKQXnFOJBY33gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB9001.eurprd04.prod.outlook.com (2603:10a6:20b:408::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:48:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 16:48:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: hci_event: Fix use after free error
Date: Wed,  4 Dec 2024 18:48:39 +0200
Message-ID: <20241204164840.14037-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204164840.14037-1-iulia.tanasescu@nxp.com>
References: <20241204164840.14037-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1269eb1a-8238-4605-5901-08dd14838519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SVrNPWlM0dEOpqVF3wu9wXHxE1llDpQeSuSrfAUijGMBYVQt7RRZTEXg3cgM?=
 =?us-ascii?Q?Suq84Qr40UWq2hPCy0xGdlI/VMV0mliL58w8Vdd7ctiC7xuMvOvO/DbXg5gR?=
 =?us-ascii?Q?gSeLIw2pk+GMuzcNgtKXDPW37bAgl+e1NYwSpntlebbo2W+cefCrB9NhYXK5?=
 =?us-ascii?Q?Un4Q3mlnwf4Py51vYoKEeh3kwZhIOLxGfs1IHUagKOus1k1TJ7gv3ylVHfU9?=
 =?us-ascii?Q?ytn1F2HpSZJ1eoUJDuidyYKx+drGcvxNxzCMIp2ihL9mD3UDEHdAqL5A2OWw?=
 =?us-ascii?Q?PcAIie5E37r3YI58Lw9hpM7pTLf3f8R9dDeZRqyIAId9bFIyrKUYdpKCyYBj?=
 =?us-ascii?Q?Xb37jv67byFU/lOIi1ucZKCDAWRmfFpCCzdshdzqFVHboEbv9xnatB2offOC?=
 =?us-ascii?Q?aPqrRZPMoRlMBQmBJTmxzIfM6eq+aHoreHRlhwqPPwR017clen/ZYmt4aOzU?=
 =?us-ascii?Q?i4E/j/cmhezf19DAt7UWOhoy21EGcTrSNNpmIRr2rxnJYFWY4B5EGwSv2mKb?=
 =?us-ascii?Q?HFqnZHvMcaUxLs9zFU2a1ZiY2KHUR7YH5jHzlmC8uH3P8flKyoQsBiYwedny?=
 =?us-ascii?Q?9Vx6BJT2kuoNROlqrAyS2u5TnqXqvFhBrqfL8j38MZTtp6DNfzdI3u/XBiIV?=
 =?us-ascii?Q?ZWZ4SpJv6QjJuP5ey0YToQ5jWM2wMxjidlHSNg4b8NEwRf2FKrhSujuv3Eb8?=
 =?us-ascii?Q?zLKf/1oT7iwUOyk/optM28XvhxUB9RmzfUbayMNyTcSlOYBq5DQdQZGVwQEZ?=
 =?us-ascii?Q?iXvSkuEUiTexIANXovqT1qyhnBInNgVLpBLX5/B6GeCeKeJXWTHatPglotO0?=
 =?us-ascii?Q?RiJmx+SNu+g6+4dNsU5ZvMeSaFTkT6uyyQupLSNyMAH69IkJATGMIMv5R5J0?=
 =?us-ascii?Q?lBClT9AoLGf6L4oeCpRHY8Z1SyQNeaEY1kcDxMva5Rtrbd07upU+xizxnuRl?=
 =?us-ascii?Q?b8IDAP0zn4NOMmj877kXyccm2EgJl+IjRL5kIwcOCv640J9W/9nlb5b04lH2?=
 =?us-ascii?Q?TwYmnyipISviP1Zhp4XO68Rqgf/K1YzvSVuIsqMjQR4OiRfQlbP5t6GR5Px2?=
 =?us-ascii?Q?fGRAl+46o/jnQ9V+7SCXJdc81TIxXzqrEkZxAQy+6wBqdhIA31VP1xyBUuxd?=
 =?us-ascii?Q?Is8ALSctItqyFnm3luntP2qMffX/FH1NNo4jouFACauEl6sTtQo+aM4eU2h6?=
 =?us-ascii?Q?sgOJrUBTdPGP8zc/K1qFNUT9H3nwUXVHBAyQVkZOxbQ4ifCj0mmV4JqtfXJ6?=
 =?us-ascii?Q?pjBZdfzxRCOXJ/1HjAlQXRutpKFmEBdm3SIfa6V3vZqKmeDIXs1/BX57YGeN?=
 =?us-ascii?Q?eRkvWvhpYSSrTE1O618q2lq2034IFZKT1Cn7u4YXa5tJdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bq88+0Jq5T3THLqbnHwAV44XsfyYcsNEtjCCZhs3JJ4pHRCn4VbDqJmLgLXC?=
 =?us-ascii?Q?Jv1iulmMZT6pc/9vnV5FG/KYicW3EFlQv/ScU2xSMwV7fIOj/26Qb1iwXXur?=
 =?us-ascii?Q?EsHDTsNjg2eyjdEgbe8Q8k1ox9uG4cVGiX0v/I8KvvShMFU3SHASW79TMIkh?=
 =?us-ascii?Q?e2NouvYiri3Fh8p3ObaTZzq9waiyilOQb8PH+XRZaddM9hA9PTiBTWXmX15R?=
 =?us-ascii?Q?0VwFch74f2T1P818L6KEjtD12EcBNdDiY91USHMIthkXaEq7Rg5l+IfzfiFF?=
 =?us-ascii?Q?8qmN751nvkuoaOActO6n8zfOzu5oDrBvsKwJJDRXsCmMVLoRPd7G9LsQIIia?=
 =?us-ascii?Q?Skx3odHH/Am/oiit8SDBUhp1XuZDUBHGJOMIEXXDhmdekDO1eyLWodaJnBp0?=
 =?us-ascii?Q?HB0HN8JSK64INX4RqzOyphU6FWaLtZM/lFhUPvnQtMpfMBiF+3AH4sAlp7j3?=
 =?us-ascii?Q?bO1t1U/DeuGTeaHfAtyvQbot3oSB9uhWKx1v9qQC2MU2sdNFOa4oV+7Mm/z6?=
 =?us-ascii?Q?wv7fVpql89qTTSLQBl6nw3u8Yff4kRUFX/20RIThmGqv9gDmZGo6etLPY17P?=
 =?us-ascii?Q?0FyNQvGbWAACddt+lRtrIWlMjayHkVKhhsUGDSrTeD52pvA1iA2lBYKPj2co?=
 =?us-ascii?Q?lJtwEVeR4UmxiG4N71OI3H/p3ogia1TV3xyuARfHvl95Z7gjd41wmR+vc0aT?=
 =?us-ascii?Q?NTWfnwxuWYelhb4mKbnaeIH1vI8hpPXOk8PRA8M0adsAkOnndtonnzjRcsBB?=
 =?us-ascii?Q?A/nolInOmtBEb5SS8zDG+IyEBrlwJ/3RnaMlDRAUzKfBWm5E5DJfrxQUIykA?=
 =?us-ascii?Q?q1wcp5vOFjXJGAT+2pTg+2iTBAorae2iYYC8DP0aqJ67wImBALfKDrZquikf?=
 =?us-ascii?Q?mTaJkjOFYwyfNht4OvVSZSe2mXG1HRIM2ExsRCdCl7nHbMB+tgb3gKPYe7CH?=
 =?us-ascii?Q?CIgEPfR4p+FwlpTOIHxPqT1T+gOWX247iSdMRmWSDqfjuRd1RLlnOWbfbo/Z?=
 =?us-ascii?Q?YVII/FSovYPncBtusccqoblAdR+vKAkzlF/QKL3xtCGdAVREw4VBuA4ASymB?=
 =?us-ascii?Q?0n8QuiQq8aB3srlRTiNoxcP6IswHx9VkAyDJFnE4VtXuA2Jf/r2L7o0zmmh0?=
 =?us-ascii?Q?eMouhTbqunsFhggT8CA0g4p5Su8bq0q55Hg8G8C6uwPUppy4rGPxsSka//d3?=
 =?us-ascii?Q?0+LQw0Oby5YUiAlVZM25NjFH/86/gc/5WJyQdrDPM8V06m9oXnHITglwyKyn?=
 =?us-ascii?Q?FCPOe8ckhgLexfOO2M7WR1Qi5ihXUX092xzRmeOjhYlShZd3OA3Xq8LxTOoI?=
 =?us-ascii?Q?HbE33k/SKpOfKvA1aTxbrqLG6+wZITPGrUBZSBM/ayt7A+TNvSAKdh9AWIvz?=
 =?us-ascii?Q?vFaOiJURbZblXAV9mRBwO/WjT9jr2VrL6MTVyB/Jv64yFyor0KyZTJzYDqx8?=
 =?us-ascii?Q?r9by5fena2HqxicokmU4iyCmJMJdWs89AhlCyhcT2uea4IVl8FWiJXcr+z1e?=
 =?us-ascii?Q?sGAgLEFbrOmQJjtCcUGhVlYLi4VAN+ELHbBBAuJVIy1G7MPdoI9aQrNoWznF?=
 =?us-ascii?Q?MQJGCXGFsgK9Txsn2qmUUdmZj6Q3RbLqXHVVW1BaXoAcgYao22Mf5+JArDFd?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1269eb1a-8238-4605-5901-08dd14838519
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:48:46.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU6VWD2dDZSUVeEqigOHK17R48hXuUwgG+k8dmhbJzda6uy7G+HHJRYg56qQpwog4KlReDA/+Ky/5neeGW5W1w==
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

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_event.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aca121408369..8735264ccd8b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6872,6 +6872,15 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_dev_lock(hdev);
+
+	if (ev->status) {
+		while ((conn = hci_conn_hash_lookup_big_state(hdev,
+							      ev->handle,
+							      BT_BOUND)))
+			hci_conn_failed(conn, ev->status);
+		goto unlock;
+	}
+
 	rcu_read_lock();
 
 	/* Connect all BISes that are bound to the BIG */
@@ -6885,26 +6894,18 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 					__le16_to_cpu(ev->bis_handle[i++])))
 			continue;
 
-		if (!ev->status) {
-			conn->state = BT_CONNECTED;
-			set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
-			rcu_read_unlock();
-			hci_debugfs_create_conn(conn);
-			hci_conn_add_sysfs(conn);
-			hci_iso_setup_path(conn);
-			rcu_read_lock();
-			continue;
-		}
-
-		hci_connect_cfm(conn, ev->status);
+		conn->state = BT_CONNECTED;
+		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
 		rcu_read_unlock();
-		hci_conn_del(conn);
+		hci_debugfs_create_conn(conn);
+		hci_conn_add_sysfs(conn);
+		hci_iso_setup_path(conn);
 		rcu_read_lock();
 	}
 
 	rcu_read_unlock();
 
-	if (!ev->status && !i)
+	if (!i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
@@ -6913,6 +6914,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
 				   UINT_PTR(ev->handle), NULL);
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.43.0

