Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAE2163A4
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737352; cv=fail; b=WWwAVBaosxpITCgYonYrGGVf+P0cMrjtDhihKN+3d8U16R453kX69uysscMBYJ6JkLFj/z8JjppHQKFZDi25ku+exwitTv99bKitGAmKI+nZNq9u+jT6a3++SYc5wpdeSMbshwxfBCKPF+wuAIfkFFccKTp7olwKe9g0eIw2ktU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737352; c=relaxed/simple;
	bh=L17dOwBX0MarJPVyTZDhSk46ve1EzRERqQszQx8pdeU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=td45HAiqhRIPSh0lElNmV0Oo8wHr8H+2/026N7BUcMuwkiuUtgKD5pFcuk0SwpPf+JwNCodk+0TV+WN9Kjl8werCCx3/G00VIw3IvgB6Yp/RpK9h1rSBLAuank2iTeTXxwkki3fltI04TXXdRNK9fkgx02t00kQiBB1CgN0CdqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eaS6do5a; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaS6do5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nawgTANsEdhTI+yOyXIXRmYVofOssfvEy2fh/ifvuTZab8nuDpMMulu/Lpcw3Ka2PxGBKW3GMca2gaYawuOEdRi2nFeSPVVrn9/PN1PkNj6DDSL66kookjx2BWCJSN7Xd08gt8jtziyqPWjzwUpZu7dVZGObJ74oKeaBU033IWIWCgieFGXCetFuJSydsY4v+VGHLxsdJV3UFOC8AtMbnIkowiqBM0yEyHNk3tsDL9yvscCS+eaRc/acjaeWJz/yyKbgSiRiKsYFr2QPK1rFCbEp94BQ+BqHnHgfQZBd9DyQAi/gp1Dt6IU67GxxS89sc6oHzjDmBcPhHhCIlFnMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ulTC6pqqXjOO6w2NC7MNEdjXaVqcbmbHYa1fvk/E5w=;
 b=gl3UC+iT1eWby5SpAfcFhc2MllZAbtLjMoO8FPacpkVlnkXRXvl2K+0RuVcWjrfKoojHZtXxUfhV0ix9ZaEtE677exk2k7abXuS31ojKNaOc6bMWMefVrwIgMyITTvJMHLBBHvlREADnKTRB6MXFRx7uS4qAlnSA6KSbG+ApV5FGmIYPkhPl8sBqCdg/WccGwYEFVrUYDAYNqF35S58aT4fzHLRDVBDBHgaB5NvLwpL+wAomOsKz/adiN5qAZIHwL9jAjn7qlUGEtFE3yvZ47PElkgMvtfGNk2gtmpHglyhSnvpG6gZL0nsroy1Z82cyI0gADcfIABIGI2qQYhKBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ulTC6pqqXjOO6w2NC7MNEdjXaVqcbmbHYa1fvk/E5w=;
 b=eaS6do5aWuXBZ8DX9fpyE+HRmytaEAdtlBi/HGCEU/KxfNn+X28dtxdr7GggXpucQRuaOen4EqAT1/tYuHNQx1/nyq/PUTD/M8tEQKgGqS6lVyfzyYorTfRenOgXoj6ACT7DYV7Uh2z99/wVgGJuVJXryr+yfvSmwOweMpA/MEroBYjGwarPqX4P90Zru1Ufl8vzDkk6gp0n3+RxjvoZl7wCI+Sn634sVVkP8tEBVFJ7ivSJp0WvvYMleqAijh2DyeRFE0qcQf54pEZC0dYXIXsHQFdZAESkqvfrn0dCizlRrK2X5yTy+w2IiQUQ9nyA0gEd/0mNH2a15URClwf0Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7086.eurprd04.prod.outlook.com (2603:10a6:800:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 09:42:26 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/2] Bluetooth: iso: Fix circular lock warnings
Date: Mon,  9 Dec 2024 11:42:16 +0200
Message-ID: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0017.eurprd07.prod.outlook.com
 (2603:10a6:205:1::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb8d065-3fb1-4fde-e7c6-08dd1835ca79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jvQhM7KRsjj5pScXgMmq49l+3shGs9uPWfLi8PigJ/xJrTuwL9DJfI88O+vP?=
 =?us-ascii?Q?LT++hyVoMwMyC4axstECSGn1gWWd5IlNeWTj0a2mWAGv56eBWqIzdg9m6vpj?=
 =?us-ascii?Q?J4yB5FGqfT3n9JPIpk+WpYWLtCz99F00ovuLocfJB8Y/vgK/JSrU69/wbZyk?=
 =?us-ascii?Q?HPaf/AUp4TuNitWCDLbueWlhxYpDkZsCMF2/3953lWDBGFAfj1gpyF2dKuO9?=
 =?us-ascii?Q?pcNVQ0M5JV8WR0xp1CTPiOs2VIxN7Y4uQ+5/uMH0dbGZsSt8IkJelZ7Pp6+t?=
 =?us-ascii?Q?QAvBKeRegQCfWh/ZEX3NXRbG9ig+HpAV6gDNJiB0e/EHIUr/DyQVRTLMawD2?=
 =?us-ascii?Q?fC4wH8JEjavcsMsoRSHGhWKGninee+EbHGUIzaMZO5+MFEpeBS1DwrG6kr+H?=
 =?us-ascii?Q?F3wThAD9s2QloWXXdPkVpfRgsDB//p9XpetayFVhaJz1Es5xebW+HZyAN6zL?=
 =?us-ascii?Q?++vk59Te+8lYCuelwGvkG/W8JFdtCd8nzVLRPNRF8EagEb4/m1R/6FA69k5l?=
 =?us-ascii?Q?KhqJc7RbS3rVIoJZMBXTz0hE1apMHWuOTGgETUM58PMvoDuTU1H97zYDPWN+?=
 =?us-ascii?Q?8N6m0CIz1M5ZvqmmqGcGveYDE/AZmsmcL/H/22tHHaRZ0EIkEn3IsbhzWxM5?=
 =?us-ascii?Q?25UnQFQFrdCClEoIchW02G3B4k50uLG8O+paSNu0CdzvtkOVEiFCrLHkBU8Z?=
 =?us-ascii?Q?ybGagXTky/L4grpnJL2tQ1LS+b+ot27BKfMwdjAllE3Vc6KBaCG8tIk+EXjF?=
 =?us-ascii?Q?rhxnh5VpPhFcW3W1FELAKiB5dF+qLtl/iN2IqA8hx/jcMjX1eNSzuViSu1in?=
 =?us-ascii?Q?cMZnu0kGEdagfz9AVimxvzYaXG7lzi9QnNCUSjrPHJyiNKp1/ozTVnk5Ap3s?=
 =?us-ascii?Q?astQ3w4tKZtoARcrozyRpNWBmwKzZjiJwjZNpwollSddu7aKgh591smQ/J/w?=
 =?us-ascii?Q?hfwT1lA6UoyTC5bhRMSSV4K1QfPOTz7R6nnaEdietYUzAvCEGtrft6xkTwg5?=
 =?us-ascii?Q?1NtBsMyl+ZxsKK8KeMrZt6oNX5wKdKLesYbR/H6BG8Vk4ueOvNgXwujh/y1o?=
 =?us-ascii?Q?en3zdyV+FlKj/37NHJZxJ0e0o/QMdUS5hfsNRyIVVFLwV1k1WdwqrR+tQnVk?=
 =?us-ascii?Q?BqTJplMo/Ytu4AQkhNCCtef6jFd8af6p63+trJuzvny/AL+hSNR1xShBezt3?=
 =?us-ascii?Q?BPN+Orv3yZiXlodVBplqFy/fLKbcohMIysfiuJqrq4henssWwPO5WIbvMP8t?=
 =?us-ascii?Q?z+PRbaEcQSYuLh7bHktz6YWmZZe/5TR51gWxkoQ9azNLs52XEWICg56R0IeB?=
 =?us-ascii?Q?+P5pl8MHo7Hob1NJGJ1YZJIQdPmBvs4N6AFqQ2autbFPug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QafQrvfBvsuvN9dBESrkQ2qr5VtVj4dJ1RXRIl6xvldy+486g/nlF892hhOB?=
 =?us-ascii?Q?tOtle0/453+LH8x5zdpS3obDGwtspxxEjdxiEXPytvKpKj8BzVql05MD4bi4?=
 =?us-ascii?Q?KMgKP+TN2Od0JVnfLippOWf+IWiFcC+cA2H4j7O6uTOp1NFppsML+BJDdUkh?=
 =?us-ascii?Q?swLdylSJv3aiO0NtM63WqAQjeq1vPH3T955UCj43DD15Ascw/yPu1DJenHPH?=
 =?us-ascii?Q?ZJN0B0UTeZsDxd1vPJbiWoSzV/S/o6iJxLZpSxvcuXa5kRg3VIMbeuVVCBhy?=
 =?us-ascii?Q?hsTCaypoQeE9d4TU9mLABepn4XB6G22a1DpZh773MzU3ERLQXZZU89zsW+lc?=
 =?us-ascii?Q?YFBEX4CskqgjVt556tTc2UnlgzKDhTomZKphvBKLGGOgHsFdKPzayP6qNRth?=
 =?us-ascii?Q?/EJr7biIGZEk3pqFUv4Ot0fBxnDqWDfCqmlBBpl7uBUncMybePz6uBR5hJcp?=
 =?us-ascii?Q?70FNBGrkMoD738emjVBmqglNLnj9gpUescIEPUurs8iAc3+ncsuFZ31qRX0H?=
 =?us-ascii?Q?35Fbq2b5S6TnRN99NTEkbroDir55To81ZnOUhdNtGhRz2J9xV5Cr42bUtrWh?=
 =?us-ascii?Q?/fWvurvHXx2kK/CgGJxxn62lHowUHRbeKtHy3/H06IhdcWAimS+rLnslvLNs?=
 =?us-ascii?Q?kw3oOdwcEYV1NgO3OdD9c7WZBMpzav4GMvP4rjX+S8aKK8tedX3GPO+PFm5c?=
 =?us-ascii?Q?nTxA5YcLsqG2ZgR2lltHlu9YeDJMhpGbqnLWYjKiyRnG/URdsIiaHJNBfgQ7?=
 =?us-ascii?Q?3xaDwqXFc+pixY3IOAROywngx/uT/o9tEjsO/ZNQzOfDFC6VAGXyRMkUDlm+?=
 =?us-ascii?Q?jkZJI4sRYP4KbMo5ZW/HyA9XnaOEcY0RruWbIEWWK3UHe1E8fSBFggAbjEWH?=
 =?us-ascii?Q?qQ9SqpTRcgozBflB11GRjNHo9ABjok3PFH2N9orxixNuDhCGcJuIt0poxm6l?=
 =?us-ascii?Q?4dFbhWwVvGqjpK7Y3TvhqfUGYgmnlIKZq7zQjhaWWJrDr4GKRsJcbRvxUBDo?=
 =?us-ascii?Q?4DOVfsjmXF4z72g/RvhITClU+G3mhg0OLBnqI6AIuustGorhsAMRUAwi8LNY?=
 =?us-ascii?Q?VYt/FPb6gvXiZ1kUA2/p5N5ycYPvPMZCkvzuTMupliPdSrMGTueSuMQ/o+oI?=
 =?us-ascii?Q?62MmlMTwZJjnOO+5iS+/W2CiMUWrL3Og7Qt4AAvneA36gqyEk3b/BfkkRnh1?=
 =?us-ascii?Q?aKQU4lvVl/fjMPYNe3wTPV26Mh3ZVm3e9Lr99T8LVDEkVYFO9lbREtADgz65?=
 =?us-ascii?Q?rfh7bnv52ehkuz20+uLuSmUvlvS7FAGEdY80s8IV3Nejju4iJm2gzgf7u4OW?=
 =?us-ascii?Q?iZPTCN5xh4vx6qNZ6jxRMDRq4K01zGFPeJV2/wNyJkSRBQQP3nLmV+tpSSIF?=
 =?us-ascii?Q?s97ebGrlJfEhlOjbMgc8nt+d6kTWyPmeL0J1xTwscHhR0JCiKp/btl0Mfv4C?=
 =?us-ascii?Q?EUE2lT6iMV7pQi4I9UZLl/rpO+ZaQX7Vm10TMEiw1WhPUAwV1yI+6Tmaph+L?=
 =?us-ascii?Q?hicXsRW9MG3JZqhYqUedmrFcnH+XPGZGrzNy/F++VzEs/vfbGhGhOBp8Erqi?=
 =?us-ascii?Q?HhJ8S7NKa7ViH66twgqiycC58OabExPYW6kn5DHkPDvbddMZPbbHaRti/alW?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb8d065-3fb1-4fde-e7c6-08dd1835ca79
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:26.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7n0oRKWTf53o2c7TQnaDcwf8C5Gfj/I3UheUygZ5cz37ZytX+ofP+az2SXHrgG4VLXMNx7Z7JWKVBTnK6LHmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7086

This patch fixes the circular locking dependency warnings in iso.c,
caused by A->B/B->A type lock ordering with sk and hdev.

The first commit fixes the warning caused by iso_listen_bis, by
releasing sk lock before entering the function and acquiring hdev
lock.

The second commit fixes the warning caused by iso_conn_big_sync.
This reworks iso_sock_recvmsg, since it contains multiple function
calls that need sk lock to be released: The socket needs to be kept
alive with sock_hold before being released. To avoid multiple
hold/release/lock/put calls, the socket is grabbed and locked at the
beginning of the switch, and it is released and ungrabbed at the end,
with release/lock calls when necessary in the switch.

Iulia Tanasescu (2):
  Bluetooth: iso: Fix circular lock in iso_listen_bis
  Bluetooth: iso: Fix circular lock in iso_conn_big_sync

 net/bluetooth/iso.c | 48 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)


base-commit: 269f7b219173ffbb01121243c55cef8a5503593b
-- 
2.43.0

