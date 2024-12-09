Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFA215F6B
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737361; cv=fail; b=mUesnIjeb60F4jxm7+RWGzvDdtbgvuC2BEExfGjEo+yR23I+Xl8h1ne6lqlErm2vYp3ADaF532LzzAG+ImvsWWoSore9pmYdoElJNkgP0oQ0QdXRhK5HdT/10VtQDalKd6MuiewRfU9/5FKfRGaHIHyGYdJNcx1W73ZdD26Orl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737361; c=relaxed/simple;
	bh=6rok1+LITzsK1QlXNaQNtr8TmrIeaeWvqKCEAYIOY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPPermh0Ypb8Cgmgx2ubgHe5rITuvQXs77zVVeWtc8GqMECM5jCfRy78V9kWW7F7E8aU+VrkEqHrZah0hQX/zA71MghP79I7/Fp6OZFdSiu7E5bWRYvi+qlKlhcmuvr1XJs95p04BKHhrJpygJnz8kOusp4H+hv8lMLAoVM0/UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SNlPrlCi; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SNlPrlCi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QftO4Kw0peLd2J2MlD0sQP2N+A581i2UsRgFINOQAqjM37KtdPOhZe3CSw9EQW/VqnRJwoyj9ggWC4jJ/Gv6DJloCXccvmbd+a5h4YohndRA1Y1lFe9+mzBLgpLypRNjlhZqdzcOHg6sHjEFmqe49FVmotxt8vMoAgCtHkCh9PW3DsTSZ9WdjfzZoZkHapUd1w06wIF1cxb+9WbnWqewSkrJb0Wssez3snQ/CSG9fXC01vzf+9g88+RvaYCEvSk67EKjGa28i9pWrKYo5N6wrnNmbUyP/EjRo/Bhgfwz+U7CfOcr5OVZmH53oI1ucv5w9IzTEu3Gsc87AG05aAdFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6TflCws7Iy4FhYl+oCkcXU8vpMeJUjULiOFi3nJYYg=;
 b=UzzpMP+AFo27UjWavoYGsZktEyDx/W3OTjpA1gVDj/CQ+oXlaWKdfkXmzQc+T2Nd/SuMHwNqqTlpU4mdNXsHh5dLWSU+mvP72a55DBp4/suyc2jqG2Jvn1QCDv2v1S+vfVigRHxsBJwVztvvl6TLAptyf8BUFho0mvtDrHs/gAonuJV0wmr/5cZv+DRKxf3QNe2iqJxzCQgDB++b7vUH7OE9PK7n9oWUPA9Zd0YwwuI/6bnzsGHCMHlYxIh99k31bpldVKbi+omC1SstyQKf9qgUGFHkSicHPnNfdOm2yc+tFJ06izngQIkUNuopVje2ZPxMU93/88EP9KK1ie2GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6TflCws7Iy4FhYl+oCkcXU8vpMeJUjULiOFi3nJYYg=;
 b=SNlPrlCiZ5CnKjTJIgMII2bM9xiKRcZFlTGi0rQuv8PuoZMynGZdlZ2Su1wh949KiEV6IoICkU/zxgpjga20cefjtjpmYFEk7Q0e48nsiwZBxqSBzbEj03MVX1uZP0ANcqvwdzHv0Ggu8hR6cOu/4V9IWXavG4qFKRrdOQ5POuOqKzDkyWCX8YoHrooFol/oCdfl+e36a6D6NE04zJU6TjBMVcgbbJ31gU47WkyOb0nudRMjS9LuG6WwXue8N4Ajdp63pF6lj6ZOpV9xyFFGJRve9Cs2m4kOK7KQwd9uwNqOjlZpT7Cys72sbSs5DDN9xhbcsn9i2ri6MjBEBaDCVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7086.eurprd04.prod.outlook.com (2603:10a6:800:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 09:42:35 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 2/2] Bluetooth: iso: Fix circular lock in iso_conn_big_sync
Date: Mon,  9 Dec 2024 11:42:18 +0200
Message-ID: <20241209094218.4939-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
References: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: fed948f3-b33c-48f0-3b9e-08dd1835cfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9qmoysk7s7yTVVa8RRLZMTUaBOBSlFa11c/OsAJW4tbOIBeh8pkD83FzBnw?=
 =?us-ascii?Q?3c22rMCIKI8GHUm5DnT/h3yjbxJOz52KUkxYqbLxoQ07+2zWLX/R73L+m/Iz?=
 =?us-ascii?Q?CZEnuoIgBZKsSyTwD5jNjRTje0mclDwUuz2H9dXnuYsTXjHyyWJFkMn8tbCF?=
 =?us-ascii?Q?GsuSG3Dc/8L9Cqtwb+UM7At90rJGAYIA4yuOy2wOZf0KIkC9DL6JKUKXTkyL?=
 =?us-ascii?Q?3NYSDzej9q3AVMM40ftJAGvLw4suyqZv/U7B8A83mO2vG/MiqbtDNMLGSTZG?=
 =?us-ascii?Q?fHgSBcTccogx0ZzTSIvoynkBCc0WuU+ugdYSXOycuey16d5n3SR9ZhjUGZAb?=
 =?us-ascii?Q?8ewrYPM5nX7T+ReGEirdzLqeKAqZKTyx9dJwBXomhJxqSxzCvnE7k+U/HSX+?=
 =?us-ascii?Q?rb96aCSDM9o3RWAmXNG2a8q88i3gKmag5hHv9ya274Eryb9GTPrMvoObgREE?=
 =?us-ascii?Q?bzgNTyDl3SeyG5QRtvAOobdT69u3sh19QjU6MxWIICzWIwvFediqVpK+MFrS?=
 =?us-ascii?Q?0mJmdEz3z9BafWRgqGW3+zycSmX6VcV+IUAgvxbwZq7BOYVQswrquMxswQ6j?=
 =?us-ascii?Q?Cbpv/k4Hy8Ct2EoLAQTXV5kxT2Rbcve6JruxY3MWFolmZH8NMzYjKMG5og8O?=
 =?us-ascii?Q?lZj2cR1mtPDKbVYkVEAQvnze40gXp1/HuaeWSXFQT4oC4hYz7IfAztcCmPSQ?=
 =?us-ascii?Q?65/tkZ8qVso+lcKTdo9kbDaBdXDROjIB9h8ejtr1eIb7wLnP6nzjD81BzzE1?=
 =?us-ascii?Q?PkT2X01kuupJ1N7wUmI0RxdczYDBSdJ0iv7eltHnOf4KfDnnN0tz+95aU8M8?=
 =?us-ascii?Q?MDscCB3TbZ4tzrvRLlSJ1FWbmBuPRunFvtC29/Jrh/50g0rwXajcMyl4/3Do?=
 =?us-ascii?Q?2WLKuHPareXGXH9W33oBWWpgjhfAOTk5nHQNQ7qV6Vmrm0PKLJJSXGt4DomX?=
 =?us-ascii?Q?+/U2BRJI54bd20O78PlAk35a4fcQQdVJNungBytfHWp/ULs7+h6GqzKK+Azv?=
 =?us-ascii?Q?roqp3Fhss8fazKYLyceh6/djQG2EtyZICBL+lpjKUjFMvw3GpIvCWRMXTRj2?=
 =?us-ascii?Q?n7t8J7/oLwkPXHe8YugfYgNTsP0OeVH8V2ak5xM+LYGOyt+IWuKrf2erPZPr?=
 =?us-ascii?Q?bxsewUISmga9u+UL3VjMVwUDXsAuAHc8siczS8sr7jZefbiMN+9krkFyH5Ho?=
 =?us-ascii?Q?aoFpApjjCCd1sr8VNOcYBdyUOBMTgOocSE6yAW05gD060SiBmxfoD/AHRtz+?=
 =?us-ascii?Q?hsx31vyue/VbaXlq2hLbushXG1A55UBMxWjfyLKjoSpERS/x43Sk25+m7tcf?=
 =?us-ascii?Q?3LiyzoS2xPwaLy+DpK2ex3ENnDpO6SmefCUbhfGcrhZq7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7R/K8KaK1aRvA4usrvkhaqR+yWaK3Biqb50wrQlOp+eCLKmZV34nfw2A7pIq?=
 =?us-ascii?Q?fM2Oz0yAQKITT89WbmR4CL6I1sI/sZ2kdlYx0UUD+K/tMKDE7IhE9jEVCFUG?=
 =?us-ascii?Q?Jo5/cq/zoEtb5G5xwTkZz83ot4g7xdmYgfcoxrugbDq/iCx23I4v3YvjYBTM?=
 =?us-ascii?Q?I0CygU0bO92A94yclmORNTtkpl9hNBdZWcjocj9ljLYva/LLoxPEGmCycr9c?=
 =?us-ascii?Q?l2MepZvvmt89pK5XXgFN4set+TcgTnvO2YuE91YzhTOfVhMB5N8a+zKnd2d4?=
 =?us-ascii?Q?R3d62KRvBncdi/vN6oB8mZSZ9rFnr/L7ez//ZvBk6Acjb6StygfNZVPFQQi7?=
 =?us-ascii?Q?5Ny+JhO8zk+GVN8GpG3RlFG9kb5qnK4Uxmn7Flx5vk2EFhS6Vh2eGSE4DSkw?=
 =?us-ascii?Q?lsIqKIbxYFptR3pJw9EP+AKBNoZdmeGI2hK3KuZtj5wOhgqUtZermHQWq2TT?=
 =?us-ascii?Q?SK/vHvT11D5FO6bgdGEgNfWBTQBh7Z3uUr1FGGRmarp9dMwbO3HkCuDLead7?=
 =?us-ascii?Q?lJzRcEzB1ZqgFqw1yZ6pMJ+qH0l+w2j2IzZewxT4/Bc85K+/hUFsVKJjxVkB?=
 =?us-ascii?Q?gDsDyduiFMbSoJIxxG2zz4jG7VEtll7A4Q3HaG4Byr+2GaGi1NO6KPRbjbEG?=
 =?us-ascii?Q?y3NB5l4QulFlwvHZLvkckCep8CoKVA2H0GR4GYxGM6TOpIoS9ddxZzminFpf?=
 =?us-ascii?Q?Tg3w/qjQBYSyF1I+mXlFqMRKjALVYF04mx8wsxpuQcA8us6njQDGQBMdw9pp?=
 =?us-ascii?Q?WcqbqMSNKvUxVzqy+BK/HnjF8AxzogYt5hEazhbBYe1OCxoVIFLMoYTLSL3v?=
 =?us-ascii?Q?GIzIskw49yDRwHJgjcfriJ+TelrFKzlBEsGSyrRdkZJvWtkEx5rHo9dlfaRq?=
 =?us-ascii?Q?2Lp6bQ5quNsdTyv4k4Y+coA2sr3o+xkZO2tce3MjdXWKU8qwETKokhnUm41+?=
 =?us-ascii?Q?Z+BI2eARqK65mEa7n66ZeC2VicrSa0ak6ePw31aYFyzf7dm3P/7UTfN9n/jZ?=
 =?us-ascii?Q?gShbxriH98MKxu7wxgUSBYu5HLKytHbdN7C/RNiUg0AP1/fs9zSKRLs5ey/p?=
 =?us-ascii?Q?5eg0k/6HRXmERXTo0HLtZCkFswU8Ek3jc3X09MwefTvrFBh0/oBelVIZ+6AN?=
 =?us-ascii?Q?TmLe5d2dsf5ZxXh8gcPazv+SK7bZWf6RlVkICuQNHFEuaH4zBZeN1na46M8y?=
 =?us-ascii?Q?OyJ6uHFTiC5c4wR/tRxwQN6yrYm9LCzu0vfmXnoRi5Tl1myO26h8YBTSJjBX?=
 =?us-ascii?Q?uA2LuzZ298bC69bJQNNezE7g7nUN76Sgw1+8GJYXr0n+Tuc2Pi6D6QC05JA/?=
 =?us-ascii?Q?8lwSEolVddPrhyxAo179+R4rVtVxBBOpMYUquoSdx6aOV3XeX3pjp/rlzkmK?=
 =?us-ascii?Q?znTqZQVfmDnhoTf5oFsrKdJwMni/M1ykOgINEYeSLbiVlZ3LO8rvuKKPh1mg?=
 =?us-ascii?Q?QjOlfcqpgB4CSAfLFnTDMCEl8ugdyvBWKNUr86fBQmXAFRHm6px5FhQqlCJ8?=
 =?us-ascii?Q?62gVx94WnSOuI0yF8GvlGu31BxJr3whuZayxybNuyabx3aM52mfwku2gEV0T?=
 =?us-ascii?Q?shLnaogV3Ff786TNU82/hLFu9EHMntYQCZCacrVah8+ikvPcN7slljvDfY7n?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed948f3-b33c-48f0-3b9e-08dd1835cfd5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:35.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lInazsmEP+xwRkiUVpkGwcmpb05MbRRNn3w/q5Cm54dplg9mj5S0jYx+2n+vrxWFFwzUx1k1+5RpB6A2sMPCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7086

This fixes the circular locking dependency warning below, by reworking
iso_sock_recvmsg, to ensure that the socket lock is always released
before calling a function that locks hdev.

[  561.670344] ======================================================
[  561.670346] WARNING: possible circular locking dependency detected
[  561.670349] 6.12.0-rc6+ #26 Not tainted
[  561.670351] ------------------------------------------------------
[  561.670353] iso-tester/3289 is trying to acquire lock:
[  561.670355] ffff88811f600078 (&hdev->lock){+.+.}-{3:3},
               at: iso_conn_big_sync+0x73/0x260 [bluetooth]
[  561.670405]
               but task is already holding lock:
[  561.670407] ffff88815af58258 (sk_lock-AF_BLUETOOTH){+.+.}-{0:0},
               at: iso_sock_recvmsg+0xbf/0x500 [bluetooth]
[  561.670450]
               which lock already depends on the new lock.

[  561.670452]
               the existing dependency chain (in reverse order) is:
[  561.670453]
               -> #2 (sk_lock-AF_BLUETOOTH){+.+.}-{0:0}:
[  561.670458]        lock_acquire+0x7c/0xc0
[  561.670463]        lock_sock_nested+0x3b/0xf0
[  561.670467]        bt_accept_dequeue+0x1a5/0x4d0 [bluetooth]
[  561.670510]        iso_sock_accept+0x271/0x830 [bluetooth]
[  561.670547]        do_accept+0x3dd/0x610
[  561.670550]        __sys_accept4+0xd8/0x170
[  561.670553]        __x64_sys_accept+0x74/0xc0
[  561.670556]        x64_sys_call+0x17d6/0x25f0
[  561.670559]        do_syscall_64+0x87/0x150
[  561.670563]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  561.670567]
               -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
[  561.670571]        lock_acquire+0x7c/0xc0
[  561.670574]        lock_sock_nested+0x3b/0xf0
[  561.670577]        iso_sock_listen+0x2de/0xf30 [bluetooth]
[  561.670617]        __sys_listen_socket+0xef/0x130
[  561.670620]        __x64_sys_listen+0xe1/0x190
[  561.670623]        x64_sys_call+0x2517/0x25f0
[  561.670626]        do_syscall_64+0x87/0x150
[  561.670629]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  561.670632]
               -> #0 (&hdev->lock){+.+.}-{3:3}:
[  561.670636]        __lock_acquire+0x32ad/0x6ab0
[  561.670639]        lock_acquire.part.0+0x118/0x360
[  561.670642]        lock_acquire+0x7c/0xc0
[  561.670644]        __mutex_lock+0x18d/0x12f0
[  561.670647]        mutex_lock_nested+0x1b/0x30
[  561.670651]        iso_conn_big_sync+0x73/0x260 [bluetooth]
[  561.670687]        iso_sock_recvmsg+0x3e9/0x500 [bluetooth]
[  561.670722]        sock_recvmsg+0x1d5/0x240
[  561.670725]        sock_read_iter+0x27d/0x470
[  561.670727]        vfs_read+0x9a0/0xd30
[  561.670731]        ksys_read+0x1a8/0x250
[  561.670733]        __x64_sys_read+0x72/0xc0
[  561.670736]        x64_sys_call+0x1b12/0x25f0
[  561.670738]        do_syscall_64+0x87/0x150
[  561.670741]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  561.670744]
               other info that might help us debug this:

[  561.670745] Chain exists of:
&hdev->lock --> sk_lock-AF_BLUETOOTH-BTPROTO_ISO --> sk_lock-AF_BLUETOOTH

[  561.670751]  Possible unsafe locking scenario:

[  561.670753]        CPU0                    CPU1
[  561.670754]        ----                    ----
[  561.670756]   lock(sk_lock-AF_BLUETOOTH);
[  561.670758]                                lock(sk_lock
                                              AF_BLUETOOTH-BTPROTO_ISO);
[  561.670761]                                lock(sk_lock-AF_BLUETOOTH);
[  561.670764]   lock(&hdev->lock);
[  561.670767]
                *** DEADLOCK ***

Fixes: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ed559c82d353..44acddf58a0c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1447,6 +1447,7 @@ static void iso_conn_big_sync(struct sock *sk)
 	 * change.
 	 */
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
@@ -1459,6 +1460,7 @@ static void iso_conn_big_sync(struct sock *sk)
 				   err);
 	}
 
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 }
 
@@ -1467,39 +1469,57 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct iso_pinfo *pi = iso_pi(sk);
+	bool early_ret = false;
+	int err = 0;
 
 	BT_DBG("sk %p", sk);
 
 	if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+		sock_hold(sk);
 		lock_sock(sk);
+
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
 			if (test_bit(BT_SK_PA_SYNC, &pi->flags)) {
+				release_sock(sk);
 				iso_conn_big_sync(sk);
+				lock_sock(sk);
+
 				sk->sk_state = BT_LISTEN;
 			} else {
 				iso_conn_defer_accept(pi->conn->hcon);
 				sk->sk_state = BT_CONFIG;
 			}
-			release_sock(sk);
-			return 0;
+
+			early_ret = true;
+			break;
 		case BT_CONNECTED:
 			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+				release_sock(sk);
 				iso_conn_big_sync(sk);
+				lock_sock(sk);
+
 				sk->sk_state = BT_LISTEN;
-				release_sock(sk);
-				return 0;
+				early_ret = true;
 			}
 
-			release_sock(sk);
 			break;
 		case BT_CONNECT:
 			release_sock(sk);
-			return iso_connect_cis(sk);
+			err = iso_connect_cis(sk);
+			lock_sock(sk);
+
+			early_ret = true;
+			break;
 		default:
-			release_sock(sk);
 			break;
 		}
+
+		release_sock(sk);
+		sock_put(sk);
+
+		if (early_ret)
+			return err;
 	}
 
 	return bt_sock_recvmsg(sock, msg, len, flags);
-- 
2.43.0

