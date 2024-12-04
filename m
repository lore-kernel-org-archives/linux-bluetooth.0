Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA81B87CA
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315346; cv=fail; b=Oc2FTR8nOrHNLHvtdZIuSEG7EBvJmlrS7CsS1BXMPWz+FOz5AhhhimUUw0moPBo1HO37GZv0DMtNvrakd2j3v5nvZYdnHqKQFruIHN2WA1allDdjQ/Wd8LWGC1qzpg/yCs0WcPi6Hx5ZdMoZ0meajO+kqo1baTMrjX5wE3n1kUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315346; c=relaxed/simple;
	bh=cKbokvH51FNUj9okWUSFuvKSlhEIkSxZHstPCZ02+fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajlUZ+IG4q/T1k70KJv0sfCqNgY13YXQBjVc8Ot/jkLJm8zZbj42EL4hRCWZXu+eVsuQ3V2ceSYdWd5nJBlLKcIb9L70HOSowttyuVwOqWjBUVwOE56lYgGebx9ACr52kGgZxJKBN4dnioK/9tIhQwKuod+bfVCOU1dANG8dVVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IZa3SePQ; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IZa3SePQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx4elqvMUwKjOsYowypI4RLf8sF9jQHJde+QRoApWPCpXup4vjI0AudQnD2pTauM9EDjpDAGaM3uUHqC+jgF/q2pZ1GvEDEL2UQkxdfFBNfwZpp8meIhcSgObfdQtZutnIHsGNYS3l7fWOfhekSVWjozJ9B4j6O3SGX2OssKqwiwgTSMgum/sRaysWGmJAZTCAn1BnNS1slubB1Rq3ZGImdHyfhg+dXJ+rvopKGzEb6rP3GD4OHGlQx8YkQllgIylePnRYHWb0RdjG2ppMj1Iqr0AmlVCkjSjCckPcldoTr9sUbmglDixfrNDW4ZA4YalFGIbywe7Cft578H9+9RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKptTudsUtBI84oRe1+J3Txb0cIv4hLrhSdOBdflye4=;
 b=L67SPKV/8nW2OHsNF9xT/drNCWN8P8LlpqQjYfVW7uhTdOBFiXYwXKMNYk7dj1zxvaFObL1ojuIYaYdy9cJ0ED8MCV3WHeY65tfnYiiwGuOtIOcAS5YevflXQdNd2FT27uxiYvX15I9E7y0VgfRQt3B58sgfqGikfKw34+aIJmGlH+ERPy3aAPjWYve8BimSeuf6SxnqeqfC0QD1KgVEg2/ocahiaNY7t2CY8PdAzovNqRhECjSNjhA8btuRjpi4Qxp8j1G0LkVabgC6Ir5s3DSWcsiFFnTMaG6Y672K/7ftw+e2rDjgt0HIAxP/I8QMILhFOFEhpN++ghM2xiu/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKptTudsUtBI84oRe1+J3Txb0cIv4hLrhSdOBdflye4=;
 b=IZa3SePQmYVe0IkWYmMdKGMOWllzJxHsb4eI+/RL8xrdrBFCDUXH38kvCJouNC4487FHZuqp5ZvG1Pqur5XYjvSqjdSWZsTSuJy63/HICrc3z8yJ2izsSFSG/LL9Zy6ZStGqEjcIkmgRV7Dbg8JFENxQm1W8fnnMMsg38wxTFtZJP6u618EEeKXV/fA9vVZGTrOWggaSr5GFsNT2U2ow/6tib6DWXlbM4SfGHCbTNCApSnSClLevCotEBIYOO1XAOcp+j+jWZzrQa3ckViPiFMQ82MK0nexexR5ZdUMBNcXmxZElgdjSSyau6wD1rHSVIP4PoD1uKycmr+QKgC15XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 4 Dec
 2024 12:28:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 12:28:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/3] Bluetooth: iso: Fix circular locking dependency warnings
Date: Wed,  4 Dec 2024 14:28:47 +0200
Message-ID: <20241204122849.9000-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
References: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: c70cde51-0a41-4f61-c1b4-08dd145f3ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9NTz6BMIoZSpDHpA6g4Cvygo9qKSXGipQoGU5beGfBZvm5s04da7PgiissiH?=
 =?us-ascii?Q?mf9HHcdlQE9wrlfFOksaGUkzT/mOvyhWciEWmNqcAzjKSqt5215Q2TXcp/tJ?=
 =?us-ascii?Q?H1TOc0sg1RcXbAu/Ayfbae+p0LTsj2IYWbUQ/bpj7+r7kjUVE/oK6+FmOH+/?=
 =?us-ascii?Q?iZsA5srgLE6mdV0IalRaKe/Fi03e6b1rJsSm+skBO1QEYjW1wrMKFizZFJNJ?=
 =?us-ascii?Q?Oi5zmhZG/+wX4YWPi7UDtHOn/yhnPSntG/vfS/Ra+L29iVtVUEZlSFMZDvYf?=
 =?us-ascii?Q?IZT3SW3Z0HZ4Ivf+Z9LdYhcOK0TnBTj4tUOJpZJKuFsIZF6G/s+P2diDTvZw?=
 =?us-ascii?Q?6Jy8CXWdq6YhHIhfAcx8rFPPvTHPVLnAIc+LbGe6VfG8f/lHuceleuLypCIV?=
 =?us-ascii?Q?sX4RXb2Nwqp+qUpzBgju1KwDAZgh4zbVYtY5Sv/0j5yJVmL1K2CdK8a/dti0?=
 =?us-ascii?Q?YvATs/31bIiW+2E63S5VjrbLEQL+hK9pfzyAqKNdUkhzWs+Dt/fPw7GpWdcU?=
 =?us-ascii?Q?1OqYgcKDPnQ2EjPCTLC+mxeFVGKzo5zrdgKhmZKZ0wfpmcXwqwBd5D/3wnUM?=
 =?us-ascii?Q?EBlo7vJzLo2WKBUBc1GuxuWurz0qzL37g/tDy+KrOurOIOTrLYArFbnW3ZlP?=
 =?us-ascii?Q?GDmEW16nYhoocxanAGSiPM32gquEApNiZh93PSMJqZO/vpTVCzyI2BpqoNzL?=
 =?us-ascii?Q?zQ4XFz3CbMKt1vtgkXWyFr5JwllxOdvBve1t70/7DzMhBxgXqc/UnnjTXYpz?=
 =?us-ascii?Q?JpL+JafyiamQQqx31/Aqz3ndpEr4v0I5Nl8VKmyyzIaSnrBIcx8nXUjCcpwm?=
 =?us-ascii?Q?7PPF1BBxPVWIh+zf5pYvueDFMSLbNzvp6If6oJ7mZeuzzW6cSnauc/PVLmyH?=
 =?us-ascii?Q?gH4FF3DK54rI+k8dVDcXQCjsAgosvQ1So45YfUy2f3AmUd+YO9+By/RuqMCu?=
 =?us-ascii?Q?+l6TUn8kX1mOG/SOfAZUNPexS0yy0mkYPJkyYI8JOzPWtbHbbUiwhQPYx5l3?=
 =?us-ascii?Q?JxVW75d2Ddu3XzmdtAM4h+oCvk7wgGlQPivynpwcOVhktv8wG38nqjMn/LIf?=
 =?us-ascii?Q?SMzSnna04MSiEgSLMlFbXqzRwr/RzBaXH1oJ5dsU2IyFcduMMdl2CKX6kpp5?=
 =?us-ascii?Q?97HRLoq0NpXATYWmMbeB9Y2V+pL/9M7KIr8JTWvY3USfHsuYL3+Oh1F73rAN?=
 =?us-ascii?Q?2DoQ0WdNAm8WRbtaZBUPJGoMy77v9Wjk3gA3IaJ5sNKVz9d8rcTev1eomR+v?=
 =?us-ascii?Q?qtQP7fEgxvoHl0JPHOU01rWD7F3uqJuxhR7Q4yT2VqFy2n+j3FPsE4gkY18f?=
 =?us-ascii?Q?r9JP7HmrQ3j+Iv1afBJK1zF+ON+Ax0HZKu93q6KUW5Q1ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmxlUe384f5sCsPuRaPSQzW5aMxBzPuMyqwn6OsJcaMoTEsesYfdhCBvYYV9?=
 =?us-ascii?Q?xTtnKw6JKS8ZGaUWmDJOkO01mrSnaD8kJB4Ics28Mjbva+Y0Hpm6vpk9y588?=
 =?us-ascii?Q?2dnvWj1t73Rg6i6Ve7c/9/zoDnHHdStDxRWA1dArr/Ri46hQxQGbPV9CngTE?=
 =?us-ascii?Q?qGeD7v+0FqalGj0S1d0R5vsQf0sTI+HXd7PawlYK/HIQH8qxtElHDEFmOegC?=
 =?us-ascii?Q?nf9sCi7iTf1G08odiKUMYtYJeJcewCHNgO/Et1VAXLb5buM2JLUezySq8aTu?=
 =?us-ascii?Q?tcNQhHWDZkB2szfpw7l6HvbpLzXAsx+5VrdTChtK8jGc83NDI98ZSaBsgPDh?=
 =?us-ascii?Q?nzPnkgp/VhgfC4d2DDIuIHFNMyCUU/qIColUr6f9q7mY+4fdXt574//VVxai?=
 =?us-ascii?Q?ldyW2GDPpW9EdKdDVhR3YArbOQZK5vzviRLujc63hB12+rrqZE8luyfKZEAN?=
 =?us-ascii?Q?o/ZeYFIq8RXCZbpmP5rnCKHl8f2Vti0Q/pgYad6HECvGkvdQVmyegVy2AzlB?=
 =?us-ascii?Q?TaV+M4kRKVDhm9vB0ic8Amgu7+tP+4GjSOIon+XU8B++xmKHcUtq/YoMF4k2?=
 =?us-ascii?Q?EFFzwDbMiNkQfQK0Hrq2rkOmOd0JbQsZmKWLiy7QqemQCD0OcX164AV5Z8E3?=
 =?us-ascii?Q?9cY4JKxDifOBQJN+AFHgRzUFNlDY12pnIKGwsepG+diNpxOSNw1kc+4RrYL6?=
 =?us-ascii?Q?EGdoau3aijOvQjAo7MeGnPZNrjp1ldphtKQng4r3D60dGfRf3iMblGUF43Mc?=
 =?us-ascii?Q?XCN+eo1YNHSM2TrYYUK0NDolLC6LuYj6UjHZrRnNPM9TebnBabfuHo10TL10?=
 =?us-ascii?Q?+mIjyb76QB4zey+11BvgvmPghoQ1T2pPE8Kz0wcdJ0E1ndOavJ+qDq8xhhEz?=
 =?us-ascii?Q?LJ3d+L7mcmSyo0ztpaV1f27cvSKFT5JlcjM4b8TUJw1mVO40L3cktJ54zx7b?=
 =?us-ascii?Q?b+VtQHjJN9QhwPmjZaGqz1RdEU9Ej+w0Ckj7s4eUb4YPaTbge5WL9l15Z+28?=
 =?us-ascii?Q?HZB4gFh70uSnIpgA0J8mFyHD/RcNLDIv0Ktc/95F0dVGgyE6LYnnAGEIvUqm?=
 =?us-ascii?Q?5h25Jfnh62JJvvetlNcS/azXP9L2iHDMMZY7zbqiNsDSbg04ZTJHedxLbGmG?=
 =?us-ascii?Q?i1JAuQswGvdnLfXxgKWlYvCERiO7veYZ5nDpRTnHMkGdAJlEp4Wjp+lJ6Fv5?=
 =?us-ascii?Q?a2fBjT9FT7O7RKhR8NH9MO4FzR4EJ8ArY3J86BCwxCD0TujgAmzabLcPa2vL?=
 =?us-ascii?Q?sKhTlXpmHy5u66HI+hckHFgPCawRaj7VhRjR6FJFiez74o9lb8pW+tbOeeuW?=
 =?us-ascii?Q?U4uwsrJpxfdNW7qUjQuOyNmSsOrDEIyMqUw1gXzP8+CtwnfxQhCF8sDP5Kht?=
 =?us-ascii?Q?DAW3TaFsT6E9THntlOvoGpZY71pelI/MxCbyoc2QYYqX/4Lym9FkSaNk87lV?=
 =?us-ascii?Q?f+oUqFjgbtvKGXMRRB3AW41BIC5zU70sYsy/AvidQCI9B3qtnH7YZEXbHCgJ?=
 =?us-ascii?Q?hLMAVZbBZhQuR3eLSuOGKr4x0Gqm2/SObLcK6E86y/JcAKQYudqSlnorPCW1?=
 =?us-ascii?Q?qdzbSNAoxOFCgYEDxP5ijN7pfHpofhHVX7H/9nRxAVWyk6CU8iIuHmjYuT93?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70cde51-0a41-4f61-c1b4-08dd145f3ab2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:28:59.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R47foIdyuYtoyLoJKk8+U36uA5ECxavMDpBq5HHuF94TCY36Fo+w0BPQ33RbUi8t75D0ODFj/y1Y5y6kzJJ8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431

This fixes circular locking dependency warnings, by ensuring
the hci_dev_lock -> lock_sk order for all ISO functions.

Below is an example of a warning generated because of locking
dependencies:

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

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8ed818254dc8..cb004b678d65 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1102,6 +1102,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	return err;
 }
 
+/* This function requires the caller to hold sk lock */
 static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
@@ -1128,7 +1129,15 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
+	/* Prevent sk from being freed whilst unlocked */
+	sock_hold(sk);
+
+	/* To avoid circular locking dependencies,
+	 * hdev should be locked first before sk.
+	 */
+	release_sock(sk);
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
@@ -1161,7 +1170,13 @@ static int iso_listen_bis(struct sock *sk)
 	hci_dev_put(hdev);
 
 unlock:
+	/* Unlock order should be in reverse from lock order. */
+	release_sock(sk);
 	hci_dev_unlock(hdev);
+	lock_sock(sk);
+
+	sock_put(sk);
+
 	return err;
 }
 
@@ -1417,6 +1432,7 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
 }
 
+/* This function requires the caller to hold sk lock */
 static void iso_conn_big_sync(struct sock *sk)
 {
 	int err;
@@ -1428,6 +1444,14 @@ static void iso_conn_big_sync(struct sock *sk)
 	if (!hdev)
 		return;
 
+	/* Prevent sk from being freed whilst unlocked */
+	sock_hold(sk);
+
+	/* To avoid circular locking dependencies, hdev should be
+	 * locked first before sk.
+	 */
+	release_sock(sk);
+
 	/* hci_le_big_create_sync requires hdev lock to be held, since
 	 * it enqueues the HCI LE BIG Create Sync command via
 	 * hci_cmd_sync_queue_once, which checks hdev flags that might
@@ -1435,6 +1459,8 @@ static void iso_conn_big_sync(struct sock *sk)
 	 */
 	hci_dev_lock(hdev);
 
+	lock_sock(sk);
+
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
 					     &iso_pi(sk)->qos,
@@ -1446,7 +1472,12 @@ static void iso_conn_big_sync(struct sock *sk)
 				   err);
 	}
 
+	/* Unlock order should be in reverse from lock order. */
+	release_sock(sk);
 	hci_dev_unlock(hdev);
+	lock_sock(sk);
+
+	sock_put(sk);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.40.1

