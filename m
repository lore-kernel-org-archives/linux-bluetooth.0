Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6452226885;
	Mon, 10 Mar 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602270; cv=fail; b=YoOFI/EiJDWEajR/l32jNaORkmuteNRqFC7FP3mYFWVQksouYkWXXbnVCkJ4eNvzSBqmvNHHmxIae6pg3R1QxcJZoZXnGqiV3RQXbdEkGF36SJhWKyD+q6dxoCjBKgaY/FPJz+9Bv4Pyj/2akCHrP7SLrIfMPjQRt/jfbIsiIn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602270; c=relaxed/simple;
	bh=5t/r0V/KqskiI4Lo+K3+JhPU0eHh5qYN1KbDPfdA2HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZttc4dhBqJQ3GWBq1XxnwA6ofAGrj1EdLV0zE25K2J1Jmav5UrVczfJ/jzl6Jd94O1tFiE0JsmHR4xuEkDClQFDhdUxFgc/EayMXvhzQ/cZ5xEfhOtuJ58t5NxIvX/UqTqLe/XpLaQ0A2xsC+iOEWQIZ5WcN6meDpLmd9AVMak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h4XYZZ6F; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4XYZZ6F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRcYtdHh2nqxEOIoTD5g8N1/tx4nQAHgGJgU8Z7m6Rfwahbf2WCtvrMYEtJkHlWb3am64UZZ8BVqHOcz3Dq8Y8XFIEL+kygD9fhonEwD8vjOTQLJMqXWWZpDf+q4ZGQ4xKPfJql3Fgjw40Tgdc6Km+i5tNKYgtNiz/bRJJ7aynkVkwLrqGpbiqbRbqzgtOe5MddqFB26NTgpahukhFiT5L3rWzHnZt8dUK5Wu5JKwGBpUOLH4pOSjPmwCuxqPhpoQ+YlU66xKVeCsH7IAt90ijKqrc3H0JX9pp0hT3qvfff9aIhfBoyaKUTjGZFhF8VTBzTzoTihPEu6cGXtgn/Kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSDuxsqt53F8j4dIUn3r8arRsbnCAoWhqkkJs65Yz9Q=;
 b=Ky0Bcq5WmRa4CXr93XPGOp8JsjRo+nFjQ7uXfgBvmTZdfGDkLERX5R3kHbLyeFkHrWH71/kCY+yN2WfWbyVSTPmvNBvDkhWIevHOD4Fqw4NeN1tBTuYaz7l7uP9MwhHgWa5i+aDIvjWpahnFdrUGQV+tk1tqk+e15WdjJy76c39pTpnnsmq2fgArFLbeSWSPOnZtwZLstaQGspOtSlRQJSnPEyocZ9Xpnp5WQFhv9qV8XBT2nFYbJndWSpBfUmVCuTzxQfp6jVUMFVGwL0TqVMfUJ2XOyP/G0MoEl5nhO8mrwMQaOCtz0EKcnB5otk1bpAnF4xMe/2J5k1fGZ4tF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSDuxsqt53F8j4dIUn3r8arRsbnCAoWhqkkJs65Yz9Q=;
 b=h4XYZZ6FRTJZM1NRJiLS9Q8LrlnA5Z51X1MsMb6YJIpVbazCYtfbcvzm5w9WVBRu++pohnkqG2KJC2Y8PLfsfhZyorR5lIq1Tcxg3BB+g0x8zMjxQ/0StH4FioYayH6tBFN8zfxgJudk4RlT3Xq91XmRU1MH3hf8v0qD5OONmsuFjEGytSt6LM8uJG4/ERq8fefLPA1l55mr9KzOoQ/dBVzgKtzW7qb8TLosjAp3x8KAq41Uw08FfeYJ0yT9IKZ8brhUIu31PaNOKzTYk3iViWgY/OAfTAs+4NQeibnjmHPKLh4a/BEQGjDx1HxH4KMPdS6taJCSK6I361iHWvg1yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:24:20 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:24:20 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v3 3/3] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Mon, 10 Mar 2025 15:56:13 +0530
Message-Id: <20250310102613.261996-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
References: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 949c6602-6991-4fac-2620-08dd5fbdb82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K+FdRPGxFFUVOnr9HMaZJxa3P+JSBOX+kVkqdEhalcRC2N7sgRCRBp3vKKAv?=
 =?us-ascii?Q?jct14kQpVAgSjbv9fJlsboMYB16bBs9P76HBfpdQU+vlBuWKoa2CWYy2eWgU?=
 =?us-ascii?Q?GbpeEgx6gpiB2pqg/pSC+XzTuBzypGfb1IAEbhHeNw2Fk6zjd4ziC3Exjxio?=
 =?us-ascii?Q?+HxBXzfpLW45teR3AgP05ZjowZLMaJM5qX+ja5vtzghitVfM6+AJog6eBjFR?=
 =?us-ascii?Q?xG6QYS0V19Xz1l2YPFhPg0XsdrA66MTNRqZt6z0srzBiZIy9ClyD1jFewEmn?=
 =?us-ascii?Q?vW42046MnyWHa1VBpScnEfnl++USj/vYtZOGnhayKbTy+xqmj+uPlLW1LDvV?=
 =?us-ascii?Q?F+RM5dyZpAGT0W20kUZiXeYxgCjmzhgZFxAJdkky9XTKggwe/F6ufRzkT8P4?=
 =?us-ascii?Q?RTIVg6FKnswH6GA+3Bo/HzGf+BZx0/zvGpYaxQrVTDAJNQYFbJmEJguWOmt7?=
 =?us-ascii?Q?gEKNRk2V+mLXwIXu5PyIo67O5DO1uohgxGoMFlOuff2eb2IAe4kOcnN1wk0E?=
 =?us-ascii?Q?t36ri34Fe46RYC3MnOSOoWJRjkYLAdDzWhNwAj7Zh5n2HJGul9a6T2mvp+oB?=
 =?us-ascii?Q?1CuYlwHjhpGatJi2K3dJCix5Sif/TBHDNhSfFs1Cb1qhks68Jyt783ljCcko?=
 =?us-ascii?Q?BccPx5oMI97mHPPY5F8NSqmbhgBVUx7uFJBNunw8HHcchzhnI0uPDjpjMxRW?=
 =?us-ascii?Q?3zk1L7d7LiNPZp1D/9DYltrmzxPDzDw1L/hUxD2xANrtRxJnxEiuehcRMQOb?=
 =?us-ascii?Q?eQ+XukZikEx60aF5Zx9apoC2jikXcGYwECENO+d5OY/rJ/THkZ0X6FI7IHlQ?=
 =?us-ascii?Q?5CVymZ5FXQCXeSTrrWo4/ubY6/EYxDpRLWlqj/Ive4UW2IPabnzmYFLG9yqS?=
 =?us-ascii?Q?t/BeVSfR4l0cmFEQUmiIKfvIfglr5WxnHpNWy14tCqmIyEIM7izoY3p9YVJd?=
 =?us-ascii?Q?Xdio0m/nqbv9S508CCRRsmagYRcLVOiGN1bTiH8snG0Npy7J9LQzFXcO4ktm?=
 =?us-ascii?Q?uFu6EbVvzYz1yK5V5ADvcQkE7TWZuvBVenVgLUbX2W/KYfktWFBJdHTbG95k?=
 =?us-ascii?Q?Al+i67fLrs5zLJNNvE6c61Y0JbucH+0hIVbtvHNg7QKpZlht3c3GXuRjLzTl?=
 =?us-ascii?Q?6Ob9A+X2cY/JwzKF9J9L8VTtRvNUY20/xGChYHrOtGa7Rfg7RO2xWxWYR4Ai?=
 =?us-ascii?Q?wSTnRWxvWXHLYGclHprWCRl/jWRLTj/uyBCPlIp0pDZTXupZ9ulauLQHZ5a2?=
 =?us-ascii?Q?vDryaNzkjd5TifEK+aOcyo7zuiunk8PYbbBpt0u6S4ovyGJI8lrUUuKz5Qun?=
 =?us-ascii?Q?+axNQVjBVbM/BPXJcy0o3++zNyryWYNlquB7fWIXBj3FX8bHR9gdOZrjUWwK?=
 =?us-ascii?Q?qtnbmGB9f+NCPU1kE+lL9e5exJnEl8Qmz2iVgVfUpJf9yhgyh5Nzk/ZPFohm?=
 =?us-ascii?Q?94GMwTfoPSYygJ6B6sPyKWnPJGj8tuEM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jYtLROgbjtSWFEAPCaYty39zSgnigafcsgIA9Eg2/hyPqnccOCBeluTByqW?=
 =?us-ascii?Q?bWRa8qXmYqCihqMngVdpRMBS+Z2c6xTL9heYGsasA89sshrKJly2AdhR1WOQ?=
 =?us-ascii?Q?hur4EjtBOzITVAcNN+3uzqturXrSvjMqxg259QucCfXs3kcnNi0d4qruAc63?=
 =?us-ascii?Q?Zs5GJh1X6hCmlYvcOkbXgTP5GZpL/dp9DJbQKB5GdJOvi9ZkM1OMZ2AhfRCb?=
 =?us-ascii?Q?9ilasJI4T5yktBl02zL711wGjV38fwQetCnViqavZLBbkMUFlmnPFVQn16iz?=
 =?us-ascii?Q?tXbFn+jBLohP7U2p06f8LY+6Kp5ftLJ0sBWse0BmeiMa6+JhOYfGm2E2rCjf?=
 =?us-ascii?Q?/psSc7TlhBS8YmLUfEBa+BIQqi6s3Z9hxaoCQX2i2tCoXYyn/lrR1UyX82uf?=
 =?us-ascii?Q?DlemKYh4fS/TJQjUteKn4TXz3iP15zClVdxx1AkjmXqYZFUFFzhs/Tpf8wS8?=
 =?us-ascii?Q?I+qQtodFRDSMoTKDAkfRpYr23RDFqcl4Y60k6Le5hQeQ30uZm2LS4YtQKDb8?=
 =?us-ascii?Q?z2RY/7edj9bc1+byh6Sl8PkBttUmTf90hinBVVXLRQux99FPFdi6EBlBDI0Y?=
 =?us-ascii?Q?QCfycww8wCtYo9U3XJ9RqJWUc90wsxYXhuKQlt2a/jC5WH4HgfNKHda9uySw?=
 =?us-ascii?Q?o+q7r31aFZtntVbKVKpk6XWuqfbWV3kRf2cEa27bn0nJd6vltlTdk/Vje95A?=
 =?us-ascii?Q?ATrtblWuE99/EWHpVppblyRcMSzgCfZqV43j7wSWiu0GjtCtaIVwkBPnZZA/?=
 =?us-ascii?Q?NRXDpzc70zYD8n+hY5AVuiHSvQ6dLqUbv0Wh2LIdNB8X/QU5BKZhuK8yA2hn?=
 =?us-ascii?Q?bgYXyRnzQYYkxZw/NtQI49b08dlwxEWlhoNXnE51MxsINwZsAKV08h9scv0l?=
 =?us-ascii?Q?Lkv+FN9unIB9V0lNbvG88uTwsdaih4tOheOpbCu8v2infHkw/ZU27s03TtAH?=
 =?us-ascii?Q?QBmwIuQUF5bByhenv6cchC1U/sXL6RYnp84fZYSnzqqCeCdk7pV0uIEbZKAj?=
 =?us-ascii?Q?mO0H3FyPQLYVTve9zW95MSwA1jZRF4zFbxv3PuI+dhphb7PS7hwX2D24rhW8?=
 =?us-ascii?Q?oF7QQfhBqdRmsSEbJG94AThf98vX+NPsctP0bNqmmU0lDcqIXerPl3oeC8xf?=
 =?us-ascii?Q?10BMAKODFJ74JduR4a1MRZan646A7JZAH033BoNZxCOd/SaLWUXPuzqKFg6b?=
 =?us-ascii?Q?9GDuV/7BIr5WHVeLDc6hELKa1ZYrWhUUi/Bv+jSa+PQZ3sCcuOPnJUxT7Bul?=
 =?us-ascii?Q?+pWbM3D4OL5vooRJag4VFgDJxNEDOCgl1fA3K+LHoSVFmgSHvrwnG32HGnLt?=
 =?us-ascii?Q?qc0D+/sS+D+5dDQwUZKnfIh3F1jrz3lZnTzglCABjhAzRs92ASToJY6mFcqb?=
 =?us-ascii?Q?fEkj57Jnqd3KjyFL9YG8d/5ewwx2Xy7nYDDAI1bpmRNzIAijr4sJPB50jLgi?=
 =?us-ascii?Q?lhAJGddvsFdIvjzbTxlAxc3cOyldBm8xppN5PiR+qn9e6NgMSbrAh7DGfIzT?=
 =?us-ascii?Q?SE3u1DfmbqjZCpJoMj/wAcbtoNPq0V1aCAJ/LRv838OdVjxTSlUpwCBXdkXL?=
 =?us-ascii?Q?pN+14yp8jY3FnX5LsmVped/FB+W0VnlfaOtSvMjj6u/IA91yZjCSa/nA6Aei?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949c6602-6991-4fac-2620-08dd5fbdb82a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:24:20.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/XF3P8GeaC4o2xg8t6VxRu/JaFjLtVXRv1qOKFw0nMmcigXMVHTYiEzXLiyVsG40RYO86civqtFErsz2lBAUmecJi1gAYZ8i8cqiYTy6Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

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
index 2b7fd864dde1..6fa9057910a3 100644
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

