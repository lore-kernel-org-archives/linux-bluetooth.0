Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDD215F5C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737358; cv=fail; b=LMCvZKxbtH/00irxvDplt4hFAKwgieru/Y3VoTWo/oKTrwe5Jfb2SJpanBYAcLxpjKam0Mh39SMPOAyNo34XTh/UR3iUDYwcZDrqwdpiYrwo32psb3PHfmGo3odcon2ojwTnLTSTHm2tGg9nzVGnISPL8HR3mmRB2Q9RgMNP+tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737358; c=relaxed/simple;
	bh=wKdSmyXwfJuAkVjbaYUOd8VDB5n54KHV8G+/V0MKWds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLZJQehfKy3La62+3mkijlUBEOGJOLRco54nSijguiNCe7vASQNzy2cWphAaJBwSAQty7Rcnd4iVrhhEdK4g0BWkt1TqfIs+bGmVHsH7wKZVTIfs15uFwwz8fsT7XHANUhTg3XuixcFoXh1PZlRbpnfP9KVvp7BQcVz7ObZyJUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CSkTjHfS; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CSkTjHfS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvHVSqvsq+dRwPBe/m7atC1C4nfPr4k4Q2zvG3PDlpGqI5GcRKDOeZBbq5gUFZXW3D4pIxqSFUHwPpNED7pdToVGOKEoQLTTc4kvpFPRjQafdAsvG6Co0tLxjWlyfy4ZXo3lgOx+JTrM6byZYnInL4RTWvjROa9NGyQAkA8dAbLvCqMm5nm7jz+2ghJDNJ01MPT+4qCXzVBuSGSyabxeqRGX/lmNiotToHnJMjt5JTxa8ssE2iGWfbx9FpAVjMM0Gb11hm12rDcbggkR3jyMUVr3h6sQDUvAc0QQtWC0WbzYJo2mEGtoFdlAg4opemQVI6zoKiQzDnknElT+PUQATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUQkiFm2SbWHpoV4/1tqfSg1ec+GTBm5MgP84GSp9aQ=;
 b=W8goWq0QsR4isOLf+z3oMgYHiLDQFnYn4hyhJn34EChMs9Xkkdur7auGXAWzLbkiCAD/YuCyWBTm2Acw2TSNCUW0JnTyIsMhlDYkVyBTvZyhd61rxUyE/LzfqjV93M4PnfqDBcEa+XqPKt0SUo6kcNlzyS7DKkQRUqvcpAJeiX1S0ami40ccka84BkN6UPZi5Nsa21q0fdFgS0P6PFvnLSscsmB45pVHXD9Qc9FVvsjMpJrf4HQgzV+JaNh5KnCQBV5pyz/cmUPDVL62KW6QXujMnG2bsJxi4efLxms5xBWzOCCfb958GNtctrL0HDsfq7ysT/zujgX9+dkP7cEvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUQkiFm2SbWHpoV4/1tqfSg1ec+GTBm5MgP84GSp9aQ=;
 b=CSkTjHfSYK/vK/dYPbJ/HNfYgtvu3aEryLoO0b7ijOQL5ttMO8RzbZkyNeRg0elhyDNpqno2gZdFQ92zexfo3Y3hGAg1cbIX4RpvkSFWGJS6Si02qlYiZtHn/wPmkqnlPwvE2weFst+lNTx3D5D+jLd3lU6/Yx7abE5NF5p4C78kfL8TLTNCH38jxDllfSm0NKs4xOIz4lJ9ExDTOi4oW3/ieMv5ZO8f6tMaJdqy5KFnbhrIfamNLJ+a/VaST6rxoYCdA9WVWWmJt7bMV/w73soLfGIVaZsrn7Amk01FGutcSrXTu/FvGAcPpQTUZxkxnyKFN6ICZvorQZ1YTMXHoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7086.eurprd04.prod.outlook.com (2603:10a6:800:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 09:42:32 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/2] Bluetooth: iso: Fix circular lock in iso_listen_bis
Date: Mon,  9 Dec 2024 11:42:17 +0200
Message-ID: <20241209094218.4939-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
References: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6025693e-00ad-43a5-fbe7-08dd1835ce10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bq7jr/u/fkx0U5ClUxYWTfOpaIRgUgJJkPA0iMCZ9glXVa869vH95ogZ2/8P?=
 =?us-ascii?Q?Yi1UVc8pdx9t921CPTqtpfXarQLaw3YFidVdQkDX0Bp0xY5gzZtp36ZCNZZ2?=
 =?us-ascii?Q?8r6I/AMpalQMfzRmqDd0qecp1DHLWwnknJA0zeWW0DpHFGxwWO6XhiNhHTVv?=
 =?us-ascii?Q?rSGUNSVK3Py0jAIiUCfW7Rw60eQFV8DfUTOznAHAuEKxm+HgtIwCvQVL3W46?=
 =?us-ascii?Q?Bw60X9Q401+UrERl5J/uOWmZTfBN5kvSBfmafE8UR5P1Fp1gBMMpeA8yN5If?=
 =?us-ascii?Q?rKgEiE6wZ5s0whNxCQWP6hzSoCXUhUB5JozQGM8G2X8MOKyr7grnd1WsGUmY?=
 =?us-ascii?Q?huDHBLtlH5hpTAJZLg6aUo6kOURDBfdLcopvVGABux0lenb9iBYqiC60ipSj?=
 =?us-ascii?Q?xyTBbrUzjxBrfa1rIc4GVtQJoHncfRuwKU/IbnGoZjKQTdKWoEUQOgZfJYQj?=
 =?us-ascii?Q?3HftSSBFSYqw2+DTTlB4Igm9OQl4GA3XxoXcUgODBpxLrmEZhvteWUDJ581s?=
 =?us-ascii?Q?Ni1PO8mO9MdrlBQdlgiNAKTedlm60jcP/4QaZJBDQBIgzK71GLDjMFEpRtWk?=
 =?us-ascii?Q?BRgpGceqhjgfwkEj+gkerdJOQ3gA97jn+NeX+OkBqWA/mY4VqlalHHA+KGr6?=
 =?us-ascii?Q?uOAadpiklN4J4AtLU5ewT/6IVI99X+CB2KTTGqofZ4hGgiDWKmH6nl6EUG6r?=
 =?us-ascii?Q?aOqZs+rzR1+TflpxCUhSdEz1wUGWRlJrpTzHD38HzQ572ZHcM8gHOdu6SfLL?=
 =?us-ascii?Q?sDzY18sauWifuNloEi6D9xQLaRpFUZZ/XnrTyaKsRv7fL0MJRLdqolTLUK88?=
 =?us-ascii?Q?Npgbbo/qWhzZ26BJBcMSUeGCnXiskuX3B4azZg1wqenWe/+ZK4p5huyivR0+?=
 =?us-ascii?Q?CdVXqSUgWv2ef4+E9DmhQCnOLTGxQ3PSFk/ZdJdfwX303TcroIUWq82PeTJk?=
 =?us-ascii?Q?qn8opwhE/T7BlHfIMj2yIdnRkevKJe9C8v03wm+73ZJreLGWSUGa0wvmVvDq?=
 =?us-ascii?Q?xTPaHud18dhLvswbNwFB9ZxcKU1/gAT/JecuRgSMxWLDO5KWUZGzA+xD7QvK?=
 =?us-ascii?Q?G26zfa9iWpyogIt/sROP7QCJEc9wd/yyBOpqdJn6u+aVHrjZhuEW/Vv4UCqi?=
 =?us-ascii?Q?OpZwHKJ3JNlyL5YEI8RTEb10zn9E/vbTN+Mk81jL85e5yOom2dLOOI3GI1Q8?=
 =?us-ascii?Q?t4hrdZJ9oEsrnF9Bu7EHBYobDQfTcYLrzS8/oX10n4NqGkI99KINcpoJxgKc?=
 =?us-ascii?Q?epmy/d8xNdtjCXWIaWnXYY6irlO8UGq923oAvd356fGgS157zYHSoovi8rQQ?=
 =?us-ascii?Q?r0vSH/zwhbXeMY0L0huAsWNePXjwW+WlLMd/LixzbjrsqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0OHRPbn5cKh3f/1WwcrKPhYY4N9OZn1H0CYGygMV/93jQ03zgzjZx+OoLQK?=
 =?us-ascii?Q?wagtuau3kaTgfi3w/J4EOyAHmJGIpZAgkuArPx+9G+6g8/4BPluPCcu+mxKB?=
 =?us-ascii?Q?7a/BZ/LiPe2e4v52XhG3MdtuW/1vAfvtHDKD8QW3z59B89qpSb4k/rEKpclT?=
 =?us-ascii?Q?nl0Vsdst6yCUTynu6SJgEvkjHDUWt1xcuA3QqdIz+27byjNgy2TicB4gregy?=
 =?us-ascii?Q?n/3NwdBhZ/mLK3fB3wWfNQn9brwUIPGaoFP1PtApjIqgSex8tBvTP4++YBR6?=
 =?us-ascii?Q?ha91MT1oylbhK7+zF5DdNOHnwOy+2XdKwhOh+wWJ4lhEb+r2eMw9gHYxDO64?=
 =?us-ascii?Q?1ZzY341vDOdnuWTNWhXBHlYBpLMdHtSQZg2PWUK50Bzt8qufz3tuMjutc1ct?=
 =?us-ascii?Q?Z5kuoJmR/mP6aza1S6onkGVkoF9AAWEDUU7jeNxn4yKij6Zpg3y/r6ZAV7ZW?=
 =?us-ascii?Q?Fs3r4wsPUZa9Gkl9F16HMwv/DyOI+bsFnAY7a2mAJ9k8lcHhL8irk9wH0cM3?=
 =?us-ascii?Q?3hQ3aQdkvAO+6Z1EDVVD0VblsQn3IWnzESDVONYKSenkNvFys4MKIgScRAot?=
 =?us-ascii?Q?NVdwqxMHzZnwtcdv4+hZgosZ7f5tYcS6fhqNFGKnZHRH74l+w1waJ7zP6R0w?=
 =?us-ascii?Q?SGjyfXZhZMHhm3E6dkrVDkwcnwQdJq6dSJ1x3QvlB054NIb/s7vDZDr+MWqI?=
 =?us-ascii?Q?Bxmhg5maqoHST42i2qanw56knzdxqsaeV/QikQNRV4HscIrQuRXK4ly4lFmk?=
 =?us-ascii?Q?ww2Y+bnyGmODDfJJpBNEkw+9TB+j8jmwug1YkZ78X8SBeRLgiWPJqSd0PreF?=
 =?us-ascii?Q?0UdEs6+saybCMDKQAFVacQ/kzRHswn7tQ40Ll9E8V+S8rE5iZwt9t/sbG7Zu?=
 =?us-ascii?Q?KkOSFTwVkYZpXx3c91E9VgGKfSUp/7cLlDKT4BL1tqDW10atfcyFP48ymbFH?=
 =?us-ascii?Q?RR/affPJNAsZNuycgrdxkDGwjheAUL1DmG75cnp47ltrGuAB1mgCvOAKhpSq?=
 =?us-ascii?Q?Vwi18hvhItNXe0nnD7YZHsHF628Uu7BiZ3D40ReqewkRFKOyYoPE87uZ2vgP?=
 =?us-ascii?Q?P02YQZmHnAnqd8MsGNHDEiDi4Wo9qJ8mj53OpRDQLzDAWI2kQR/FyA6Ck/Qr?=
 =?us-ascii?Q?oDXBoWNTHmgXcYE++Vbk2GztWrp/a1fS+drKFe3KTvXR78aqkYyr5O/8XooC?=
 =?us-ascii?Q?2zHCxBi2ugeVwWUULhm9SI+yuSZD/Zuo1i1m5hYZvrJvxhaJgs1y4d+up7Qi?=
 =?us-ascii?Q?y0ZCEt9cMnxSC2IFzkJ9RuwBYjHkc8ODZn/Kb7BQxBq1V+QV2rSzdANHmi61?=
 =?us-ascii?Q?NUPpB2+dsZPHevDICVNfket4bo2GoPVmu1oLXXxc1mv6FLBSgtBtiti+WtJE?=
 =?us-ascii?Q?TdQHv0+qfuYG1e6dKSjgaYMRHmlCrpjtGY0vQyfp2erGVBaWmhNuRwt7h8Po?=
 =?us-ascii?Q?5eXyMAkYFKStkrK9iSQaUUKlq7/pMC4SmllPB+4nj7LJ23vmfKTBXVLEV7t+?=
 =?us-ascii?Q?Bfmw1F2Xjs+UbJFCuRq4Zo8tTUFMPrBXUT3DxZ6VWOOgC5+LP4VnxO//xNzo?=
 =?us-ascii?Q?uIstaGs/6iK3nlKvqtnbF2gZrmmyxun2x1/Sj7pLINORM5QBGaE30Ujq33VD?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6025693e-00ad-43a5-fbe7-08dd1835ce10
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:32.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVeUAk/+XzULMiCWc40Oa7halRBmVJ2mPfXcDNIq+F8oAk05lYrauWZYSSKCK5PN01mqfUUg+h4ShINLwK0CAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7086

This fixes the circular locking dependency warning below, by
releasing the socket lock before enterning iso_listen_bis, to
avoid any potential deadlock with hdev lock.

[   75.307983] ======================================================
[   75.307984] WARNING: possible circular locking dependency detected
[   75.307985] 6.12.0-rc6+ #22 Not tainted
[   75.307987] ------------------------------------------------------
[   75.307987] kworker/u81:2/2623 is trying to acquire lock:
[   75.307988] ffff8fde1769da58 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO)
               at: iso_connect_cfm+0x253/0x840 [bluetooth]
[   75.308021]
               but task is already holding lock:
[   75.308022] ffff8fdd61a10078 (&hdev->lock)
               at: hci_le_per_adv_report_evt+0x47/0x2f0 [bluetooth]
[   75.308053]
               which lock already depends on the new lock.

[   75.308054]
               the existing dependency chain (in reverse order) is:
[   75.308055]
               -> #1 (&hdev->lock){+.+.}-{3:3}:
[   75.308057]        __mutex_lock+0xad/0xc50
[   75.308061]        mutex_lock_nested+0x1b/0x30
[   75.308063]        iso_sock_listen+0x143/0x5c0 [bluetooth]
[   75.308085]        __sys_listen_socket+0x49/0x60
[   75.308088]        __x64_sys_listen+0x4c/0x90
[   75.308090]        x64_sys_call+0x2517/0x25f0
[   75.308092]        do_syscall_64+0x87/0x150
[   75.308095]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   75.308098]
               -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
[   75.308100]        __lock_acquire+0x155e/0x25f0
[   75.308103]        lock_acquire+0xc9/0x300
[   75.308105]        lock_sock_nested+0x32/0x90
[   75.308107]        iso_connect_cfm+0x253/0x840 [bluetooth]
[   75.308128]        hci_connect_cfm+0x6c/0x190 [bluetooth]
[   75.308155]        hci_le_per_adv_report_evt+0x27b/0x2f0 [bluetooth]
[   75.308180]        hci_le_meta_evt+0xe7/0x200 [bluetooth]
[   75.308206]        hci_event_packet+0x21f/0x5c0 [bluetooth]
[   75.308230]        hci_rx_work+0x3ae/0xb10 [bluetooth]
[   75.308254]        process_one_work+0x212/0x740
[   75.308256]        worker_thread+0x1bd/0x3a0
[   75.308258]        kthread+0xe4/0x120
[   75.308259]        ret_from_fork+0x44/0x70
[   75.308261]        ret_from_fork_asm+0x1a/0x30
[   75.308263]
               other info that might help us debug this:

[   75.308264]  Possible unsafe locking scenario:

[   75.308264]        CPU0                CPU1
[   75.308265]        ----                ----
[   75.308265]   lock(&hdev->lock);
[   75.308267]                            lock(sk_lock-
                                                AF_BLUETOOTH-BTPROTO_ISO);
[   75.308268]                            lock(&hdev->lock);
[   75.308269]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
[   75.308270]
                *** DEADLOCK ***

[   75.308271] 4 locks held by kworker/u81:2/2623:
[   75.308272]  #0: ffff8fdd66e52148 ((wq_completion)hci0#2){+.+.}-{0:0},
                at: process_one_work+0x443/0x740
[   75.308276]  #1: ffffafb488b7fe48 ((work_completion)(&hdev->rx_work)),
                at: process_one_work+0x1ce/0x740
[   75.308280]  #2: ffff8fdd61a10078 (&hdev->lock){+.+.}-{3:3}
                at: hci_le_per_adv_report_evt+0x47/0x2f0 [bluetooth]
[   75.308304]  #3: ffffffffb6ba4900 (rcu_read_lock){....}-{1:2},
                at: hci_connect_cfm+0x29/0x190 [bluetooth]

Fixes: 02171da6e86a ("Bluetooth: ISO: Add hcon for listening bis sk")
Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5ca381a3b04b..ed559c82d353 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1129,6 +1129,7 @@ static int iso_listen_bis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
@@ -1159,6 +1160,7 @@ static int iso_listen_bis(struct sock *sk)
 	}
 
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -1187,6 +1189,7 @@ static int iso_sock_listen(struct socket *sock, int backlog)
 
 	BT_DBG("sk %p backlog %d", sk, backlog);
 
+	sock_hold(sk);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_BOUND) {
@@ -1199,10 +1202,16 @@ static int iso_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+	if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
 		err = iso_listen_cis(sk);
-	else
+	} else {
+		/* Drop sock lock to avoid potential
+		 * deadlock with the hdev lock.
+		 */
+		release_sock(sk);
 		err = iso_listen_bis(sk);
+		lock_sock(sk);
+	}
 
 	if (err)
 		goto done;
@@ -1214,6 +1223,7 @@ static int iso_sock_listen(struct socket *sock, int backlog)
 
 done:
 	release_sock(sk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.43.0

