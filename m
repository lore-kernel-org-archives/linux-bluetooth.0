Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CB24CEFA;
	Wed,  5 Mar 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182260; cv=fail; b=SZ3Uj6vWmKNNQnvXlvCIdfYGju03uX3CqwsFy+3QBC/KwWyAme5mRZfFhtILNydMFrmHWAfKjdtcw6zY1n/z/x4LW+aUl5goYp110LK9z6KmoNJF4ivqy0x7FCBUL/ScRqdn/3WjkvfJMNZ/rWg19B9cs6RH8G8amvehdFbVuIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182260; c=relaxed/simple;
	bh=Ky//E9obdLg2cVGYDs+3YWEbbQkbV80BoxaTG8Rb5vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMMiLPQY8LgDvam81qzq/A4RyTPDf/gL/+c4bVBIjGefvaQIStNqO4gwbkNzlqapeSXwtOAgAkcJzUBALU3Q5fW8guR9ES6eew2LHidjJnUYDd5nzFny6edk3qXQMdN6KIcrl+0NVojK1ajUnX9mFlbUk3Z8bHOWNrLGDbgzqr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMI0741m; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMI0741m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgJ0oqDcxdSwRaNBByugWE7KwAxOOkKlhrIMRRh+TaVFgrpLWG+f2wNF+RSavceABadpPQJiO5a+mvQ3VXQHee++sbxDHRVwPf4xU+OzpmepQq8pQnDvOYfCcWLyD+xOrMfLFZXKpZofSzY91ofjBYRuPmXSQRmdLkwlIv0blSGOp1D6CZ6lBWjk3vSJXMvsGdbK/ZBJKftRNT9oaH/HoL689E5QaFkfCelea5PoruLOFVzIBGHFlrJMrPlqUBqnvFrJSEdVPCtBrn25gibJPclnGhr1pVD0BySN9Yh8sAwr1L/G2rdWR0zPwiQWYhqRUIdIFAGmqQMXdWKzpQDpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAfRswp/iM5QxMMVM9Sl4HvIcmfGlnv5isvXmjHHrCA=;
 b=yjiyf0whQ/d92rfYjDe1Te4s7xbbEuXC1dDXYq6HDGW/TeH46KUYQI0h84gLsXnCuyoUFWXlz3yFqzGwPT9soe+8zoQIsQ8ip4CyetUU0hsYth7peclEQbKG8XIh0LPJzmZlMtxSzVhqRL81T4xeS2MpLzsK6fKP8dsD3SHXq9wpVEWaQv6/K1ChL52+AZjeUSNC246gkgd8RoGCSse1sfCCu9XQmO+BKsXIkvENo4azygxUSBpDn+oyg84rWFku+TZ3dBnBvmeV8dr15lPYYw5+ehWdbY69T2JYHRkdq+lvYMZKJ1k4eKa7bqB9gIaueZvwsWdek7Q6I6uVLd3dpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAfRswp/iM5QxMMVM9Sl4HvIcmfGlnv5isvXmjHHrCA=;
 b=aMI0741mkeX+gJiehSjdZSVhnUNP3d2K2rEZ7c7ZHbE23P/7hx3XfyeW8QeomkRxQayJiFJMSEjfWL8B0gxUSj7ebqQHc5CsoH+i5pjf8Bml9PW248ditSUGVfU0my4lHiBKd7nlkXMOHUQUVUZGpfOGNUaXnOntZNcnRZjffVTRx5NwfIKnDlbJLw12cEDVdJaYmXYN3N4uvCH9gqh0fO93bYCIPloCWx5CU5nQ02uh+V+nX8JlDREwJ5lzAH9A+TbnMV66Po92xDL9RT+86/fONil5HBehGRnT5sSAcRlk26E68t64YLShoz72xQGuGjtKEeLGIlpuBbSvqKa7Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10965.eurprd04.prod.outlook.com (2603:10a6:150:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:44:14 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:44:14 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 3/3] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Wed,  5 Mar 2025 19:15:23 +0530
Message-Id: <20250305134523.40111-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
References: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10965:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e2d57f-7f0a-4d8b-fe99-08dd5bebd129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWw7ZDcfPDigWjYHjWP2bU+behLOSsNv8/cQBV/WTSxkDqdrcQJCjY5Qbh/d?=
 =?us-ascii?Q?c/hc/fdWhAh2l9+Qymj4W90/g3nXG2DlIJeyDHWLKe4Mrs0hTfJbUbSClrWW?=
 =?us-ascii?Q?YB+CJeY/zKSyf8RxBlEtxRB6zmN9l1QUd4LbbZJZIcUi67WkI0jyZ0whqy4T?=
 =?us-ascii?Q?aVY6o7XY9s6qCyNGz1PmoSaIXbfhhaA37riEN/ylFdvRHs/wy6zutS+67AzM?=
 =?us-ascii?Q?0cT0M9tH9DmznR4RWBLTSe2od7tBxdRiG53OMH8eB7oZr5uacSmeRWloFCHu?=
 =?us-ascii?Q?kZGKWTTPVeBX5GYBeZiMUqxGNdzn37Lvbn7lbLwa/HbGwqkeiA5dZEoMA2yJ?=
 =?us-ascii?Q?1y2Bh2lpRya1C3gdjQJy7aj+pjPSgKBgssCerY46nHZ7TYGPHWTVOH4uXkXk?=
 =?us-ascii?Q?mM2KtWx4q79IpQ9YHnGZ1ZfikFSYiJqGbBUZY5et94j/a84TKYhbSrFe6n+R?=
 =?us-ascii?Q?lnQK+/tZ/lpM4gyiJPng9eDOz803hW1AjHmzRUkliiS0SKgL0h/erLxzYABn?=
 =?us-ascii?Q?VpHIFMX2fHIKzCn2JJreLJFESN8Bb0j6KgLBZP8IWOnBKuFNvBzLocLt4Gdy?=
 =?us-ascii?Q?KHCr8rz666QorIvyaUl3sxsKvHu3rANaYdzB1rL6aFWr3ZIlsKaPa1i0iwUQ?=
 =?us-ascii?Q?4ul//ZEKK+Hxnwez2P1ii/wEhFQUwLoMP2zDfOeUUK8k2z4qIN1/20WjW1ZH?=
 =?us-ascii?Q?QJiNq9G+bZKoJl3Xwf8OcNWEl5XZlMO+9mQHuBVkf5EqXRP+9jt01YwH4jXD?=
 =?us-ascii?Q?MK11gP9hrBpAx4OYEVZi1RFQE2vPRDriTH0+VLoYY/HQ8COHssJLIHbTG9KV?=
 =?us-ascii?Q?rZi+wL9Spy81Sq4odJ/8yZLi/gtBhJo6G12vqW1Wj6YCCE5uuKKzX+7PLZ1a?=
 =?us-ascii?Q?CmlJb7niDUtAetdeA6JSm8YjlkiET57U2hQAWR2ymnOvwVu5WrG3SI/VoylT?=
 =?us-ascii?Q?/0jEXfsrl4BX1+jtwHSMtYkMEVtU2gS7uv1p0VkdRr3bDiUPDNcMZyWV1Ef3?=
 =?us-ascii?Q?pD6cv2Ac4vesR46MAzHXks4kkOMTKkTpO2tr2+RevgFBBybbNK3S4RmTvprP?=
 =?us-ascii?Q?2Q/dcdJIq/EipwGjRPZxTGo18anO4u3bdIcy2vbAgR44J4QCjN/IrMmh0Met?=
 =?us-ascii?Q?cz7yV9+m4SRPO4/e/6MZ3xd41UDtFaM3+hzCPYljGGczJVG9GEeKNaF7NN8S?=
 =?us-ascii?Q?EcHaZN1rzjaSwMR8JeN0qizM5KvYGvVk2VYuU6WwmmxiHidTvEkQHPclk/5l?=
 =?us-ascii?Q?jbzXEBFUQ4tJ2HFMfQKGG0rQ4OlgVU/5NG7lApjArSgtWW3v+lGUhARbNxLX?=
 =?us-ascii?Q?g975n9dR9rE2Vhoa2QkoFuh6M9A+aJcyuJrBczEfzcMXgM9i9nfZMSFGtYp9?=
 =?us-ascii?Q?ahScue3Yg7yx5K8iWPbvb7T7voBE8OHcfOOOzhXcRJv6/3W1p60O3FNJRPIN?=
 =?us-ascii?Q?cdRoOv38vkPMu4H78G1XGErfCSn4L1fL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7G4AHFRn6NFILXnds0HhNPh/UaFbytAGXXAC1jLvK16qZg2vmo/r8zmQzHY9?=
 =?us-ascii?Q?AAOhDSoTHrFAWfOK8GksrVY9EiOn5X/oT8eD3jE1MSLgHCn4cJALFo2gFtzO?=
 =?us-ascii?Q?X8CYx/GaT9hN2QVp9m9p5hLfBKFTdEa994uwcsXoFM5SVmcPAJNzbgnpRmJM?=
 =?us-ascii?Q?u0DKISJm8y/GCfDKS+kUAHm0MMOcP+lsFL6wWt+dR3T+59sUmCB2v2kU/SFe?=
 =?us-ascii?Q?OqvTwtt+kLRVCkiuMVh00jQHEQtVUM9tM+MmvjTXSfszut0sKPJpV26Mm+jq?=
 =?us-ascii?Q?bO3fOP7LFFqrPgFkJXN3LBiGXYwcb3mfVhSIksjBxxsjeZryGAcvwKVW+yKI?=
 =?us-ascii?Q?TswUVPtqVgSjh2k68ik9w0IUSisHiUgFHYgC6nbrKUX96dCHsRgeUPRzujwS?=
 =?us-ascii?Q?10jMC2/UIfVa7kueCda6ufkR83VSs+xzhD5lv2OiQnt3HwKXzgTF5OAGKWw6?=
 =?us-ascii?Q?cRW1PT+dQZ5R3Rkr+HjlTHWAM+tTkQ+orWa63IIpSkHx5e+AwarjZS9ecNr7?=
 =?us-ascii?Q?yuDFCHWXGYtOxl856ZiiApSwEjc3D+zL/3Oh8+FsBz0Og/gtsdQrZHt8/jql?=
 =?us-ascii?Q?f/pvYgEzj4SRbzMZRewJZi3vCD3XnxbSt/pvNH+v/FSwMEV2tiO6Qc37uA+c?=
 =?us-ascii?Q?HWCSWnLbeDPgr+1+YS+pW/J88XxVrpqeHLlI72GmPF+odx8bf2M+V8MF5AjO?=
 =?us-ascii?Q?EjASafhmxzMK3AXtWZPg3RqBmqpHQkPIFmtFbBgRdPz+xDnUW8Zycrehwbt7?=
 =?us-ascii?Q?PL5qKXdeDEeaYgXGDr1u1jQab9uHt9mD5TRVWgVenQE8cXYl+/t3/TjUqopE?=
 =?us-ascii?Q?nqsCeeCxkeuo66iDCAO3JzcnxLBn05dl++/cMzvgAKdU/NMDSuezNAaJptEh?=
 =?us-ascii?Q?DjmKrg+NDeCZ7RJdC5n1vM5aJyo4JUuzBufRuOtszfWMK2113Z4bskgA6wxW?=
 =?us-ascii?Q?mSQ4wnJVVkWwdyZ7rJ2axHDmUDHo0EuUNm3e23o7k8bcmEwpwIoq59H84zB0?=
 =?us-ascii?Q?ULat2uxhYEKWDo5zgxEHUsZ5M7v0yQldSOOt5LPOC0Rb7J13mdUCrKHbIjUP?=
 =?us-ascii?Q?1/wsIgwZw7FbUZzBF54F0XPwNEWoda1KrIzUD21vNjj/T6w2bz1BCh4qvOWq?=
 =?us-ascii?Q?E/lvYgp0FZf8K0wPqy15PYUmOuZa9NUjOxOuWeLDO+enaWeC3/0wZCP21Em/?=
 =?us-ascii?Q?0BxIqmFmJN6P/0LbXjyLeeh+CgSAsbGpsfOcGLp4Cnl5PVBiyZEsR5ZfqYzl?=
 =?us-ascii?Q?3E0tC4GJWHNG/HPjnJfqvYTIbrXdsn9mbslaMD6syzdlj/NQwABXKmIakRNC?=
 =?us-ascii?Q?EGNB5b85N2nZmieTUYHqYu+8dPNul8ZVRDhuuU5XrcmUu9XGmc8p4qvcH3IR?=
 =?us-ascii?Q?MQ9fwnCjVfrpsKIYtLWARL8H4yMTYiYqe9/G7ulfLPa3AMQfGH+0heccnTCd?=
 =?us-ascii?Q?370Vdsy8QnABBfjsZVGljuuxQICQnZt1ZUx7VzEqQfOpoKvi/bHfDui2D5WY?=
 =?us-ascii?Q?hu6VZ3WzcWYY1YJg1o8nv7zcGIE6pXukEZGOKkIWh6Bmct2XFE0Jnx164k12?=
 =?us-ascii?Q?RO3FJVVkB9zsUGfayD+Mur82mueq0jf+Dgevsnz7qhl9/rRylTaaIC0xn6Tx?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e2d57f-7f0a-4d8b-fe99-08dd5bebd129
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:44:14.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjD0aMFgc6nuIpL/ElLANJgXjRFOsD5kmCWULpbpkTqEQoVjF7a05Vw8wdI/+FudSh/n1qvXVP0wTvPXJUyRGSiKRUCj96ARQWi7EBFSeNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10965

This fixes a kernel panic seen during release FW in a stress test
scenario where WLAN and BT FW download occurs simultaneously, and due to
a HW bug, chip sends out only 1 bootloader signatures.

When driver receives the bootloader signature, it enters FW download
mode, but since no consequtive bootloader signatures seen, FW file is
not requested.

After 60 seconds, when FW download times out, release_firmware causes a
kernel panic.

[ 2601.949184] Unable to handle kernel paging request at virtual address 0000312e6f006573
[ 2601.992076] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000111802000
[ 2601.992080] [0000312e6f006573] pgd=0000000000000000, p4d=0000000000000000
[ 2601.992087] Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
[ 2601.992091] Modules linked in: algif_hash algif_skcipher af_alg btnxpuart(O) pciexxx(O) mlan(O) overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce snd_soc_fsl_easrc snd_soc_fsl_asoc_card imx8_media_dev(C) snd_soc_fsl_micfil polyval_generic snd_soc_fsl_xcvr snd_soc_fsl_sai snd_soc_imx_audmux snd_soc_fsl_asrc snd_soc_imx_card snd_soc_imx_hdmi snd_soc_fsl_aud2htx snd_soc_fsl_utils imx_pcm_dma dw_hdmi_cec flexcan can_dev
[ 2602.001825] CPU: 2 PID: 20060 Comm: hciconfig Tainted: G         C O       6.6.23-lts-next-06236-gb586a521770e #1
[ 2602.010182] Hardware name: NXP i.MX8MPlus EVK board (DT)
[ 2602.010185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2602.010191] pc : _raw_spin_lock+0x34/0x68
[ 2602.010201] lr : free_fw_priv+0x20/0xfc
[ 2602.020561] sp : ffff800089363b30
[ 2602.020563] x29: ffff800089363b30 x28: ffff0000d0eb5880 x27: 0000000000000000
[ 2602.020570] x26: 0000000000000000 x25: ffff0000d728b330 x24: 0000000000000000
[ 2602.020577] x23: ffff0000dc856f38
[ 2602.033797] x22: ffff800089363b70 x21: ffff0000dc856000
[ 2602.033802] x20: ff00312e6f006573 x19: ffff0000d0d9ea80 x18: 0000000000000000
[ 2602.033809] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaad80dd480
[ 2602.083320] x14: 0000000000000000 x13: 00000000000001b9 x12: 0000000000000002
[ 2602.083326] x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff800089363a30
[ 2602.083333] x8 : ffff0001793d75c0 x7 : ffff0000d6dbc400 x6 : 0000000000000000
[ 2602.083339] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : 0000000000000001
[ 2602.083346] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ff00312e6f006573
[ 2602.083354] Call trace:
[ 2602.083356]  _raw_spin_lock+0x34/0x68
[ 2602.083364]  release_firmware+0x48/0x6c
[ 2602.083370]  nxp_setup+0x3c4/0x540 [btnxpuart]
[ 2602.083383]  hci_dev_open_sync+0xf0/0xa34
[ 2602.083391]  hci_dev_open+0xd8/0x178
[ 2602.083399]  hci_sock_ioctl+0x3b0/0x590
[ 2602.083405]  sock_do_ioctl+0x60/0x118
[ 2602.083413]  sock_ioctl+0x2f4/0x374
[ 2602.091430]  __arm64_sys_ioctl+0xac/0xf0
[ 2602.091437]  invoke_syscall+0x48/0x110
[ 2602.091445]  el0_svc_common.constprop.0+0xc0/0xe0
[ 2602.091452]  do_el0_svc+0x1c/0x28
[ 2602.091457]  el0_svc+0x40/0xe4
[ 2602.091465]  el0t_64_sync_handler+0x120/0x12c
[ 2602.091470]  el0t_64_sync+0x190/0x194

Fixes: e3c4891098c8 ("Bluetooth: btnxpuart: Handle FW Download Abort scenario")
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4367d59b4653..ac8dbdc82255 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -681,8 +681,10 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(60000));
 
-	release_firmware(nxpdev->fw);
-	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	if (nxpdev->fw && strlen(nxpdev->fw_name)) {
+		release_firmware(nxpdev->fw);
+		memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	}
 
 	if (err == 0) {
 		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
-- 
2.25.1

