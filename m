Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31125CC9B;
	Thu,  6 Mar 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284472; cv=fail; b=ORT1XGpwoe2fUetazj/IOBvEuYlNlT2pEUXikTt8vSXX79RaIHmhBUfnbT9kgaCdfiaCFdIGjkKe9rLCQG/vfLC03DrzsY22Oe1KBLTMMFvbh3C+ZnKiRJQ7UMS5WZt1/5nxGLPd+hvAgceE1EgRXC6ntVlak4xYWkESRNvPGLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284472; c=relaxed/simple;
	bh=5FqtfwGFRDDqeLrQGcKTDm8JAYpX6d06izDlQ+qVS5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8gIBzZgkchJtgrFeq3FSNSWPINCioclP/YdZROBUHXudKSyTZ6BB0ZzpsCTBFKUiWBKZeLp94vA9P3UMbl5yRi1NTwpVQ7olSYfTJ/sTjnwJSi0vAvHkXj11t71lFMOYiJbTPYq2q0CWTzdVRPcXcgLXGGfPqh6f0VUIrDxa0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (0-bit key) header.d=nxp.com header.i=@nxp.com header.b=lemvgeml reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nxp.com header.i=@nxp.com header.b="lemvgeml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrQRo+spjw0tXYHKeNAdsrFBA8UUtj+5uc2OqdLHpx0/jngynk7CCjLWrRosKDG1Rn55N/7w1EPgmOvnQ+r1nG3ysaMvviFXKil7rPFFHTk0jO3iSB7xW0LURkhva7VrXRGW3delGHQiILxv7YgP8GeCD95ABwFHNCk6pyoXb63cF4AEgKmb0fNYupFDskL32yb2d6Z3MX6UAUJg9gu+Z5daHnYU1PyygC2lDT3dQYAHjrMd8neJOV2WUMHYPnJ0VwjV8QwO73+/TW9ei7WDb1Mo/k61byzvOosi6taKzNcZwMQFiT5e2yScihZDw9k95XwXESf1hGNa3hVrLmbm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPe+AmfUFZLD6XFTWm9rUM1kbKK/z8q9RatGzi/7BCs=;
 b=upwDMZwI5EJZjB5NjmHsHAaQBGnB4QzemGleeQC6EXzIFA2SakBhrzNcP2G/BMkVoiyWUhNBQrHq65PzQWtMQN9OoKD+vzlsyRbpc4xLL58q1c+nuvnmv4awdQiDpZSOiMHD27zeDlX1ZgYgQ0ECSMXocj3T2DXv9ySYJG3Y5bS8JoCcKduE9jtFYKDxGqUpRXAQFFqUpVPoaK9yuQNpum0RH7eLwdDbhrDqhZAF/8d6l+V2dKSeBlUatTamtCzeC0n0W6S6lZY/Zc6/CFrDlKpXOTU3lhIF1qT59Z79qpGlc6chbSPky0N3TKOu6o/6r6NqkMfrphue7AERQiBg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPe+AmfUFZLD6XFTWm9rUM1kbKK/z8q9RatGzi/7BCs=;
 b=lemvgemls1xzXwEpBbSkgg5FG+rw7LI/bUbkFA13VWKIDTTfL/JFCiIcHcuLPyGZiOaaNuYZSLXrD45uqqOd4qgrCiqZWyLBRRR0cM9BsE42ACuG4d2pPE8J6CPWn+2nOJxiplD/YnxFbf2m3xZ7TVr0B21Th54dlWIhuLm6qAt0gwhIuUJcEqC3nVcTuYAnR5dNsj4SvXMKG1A3wCc8f7zTuZNZGcVCFemNsU6y4I+0szNo+YOnjFnJvIxYOhXusxoy7h/U4449VKdK/uZpEKbpmIVV0bkrByxBF8EnvkpNPuVHoRIM5B7ES3Wmgs8td8GfAfOjvmQZ76Tk39GUwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10603.eurprd04.prod.outlook.com (2603:10a6:102:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:07:45 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:07:45 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 3/3] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Thu,  6 Mar 2025 23:39:31 +0530
Message-Id: <20250306180931.57705-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
References: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB10603:EE_
X-MS-Office365-Filtering-Correlation-Id: edfbf128-5857-40ad-f523-08dd5cd9cbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25vQ9T0I/LvcMewL+GmAKMqJjV94wQCvu9iUTnDZ2TXXSfpDpPGubwPSKYfX?=
 =?us-ascii?Q?7KGd9RIfoLJednHu3xGUCspt91vTpYI4kpqH9ihsOTy2aZFrw8P6Sj+OT7Go?=
 =?us-ascii?Q?a+lB/GvbF1WwzYhKP0LJfmjwu2rm2MhK4JVXeP/Gh8zfd8Pn7yjK+SW88G7C?=
 =?us-ascii?Q?ecofgKbdrpSKN8DG2iF0r/NoeWuK681EovN6dsIZP12ariiuAlvhBenGiOtJ?=
 =?us-ascii?Q?KBeNsAaLdsiNA1UtNcy/1MwezNh1prGQtRYH0L+ofxZQbRTVQSZfPhGLvFDf?=
 =?us-ascii?Q?EGGWvUKBs4dLaIyo2HngoqrYrUHhC4mfD/GLqSTgq7AtXS9eMMLxc8Gp6Pf8?=
 =?us-ascii?Q?cogmX9ZhvKxzPLSVedBJmyNVwz5arWbW+Y8plcHZuSr6T91YF9Z03qJF9FmI?=
 =?us-ascii?Q?Ee381EdVQrXQU+6ovSQczCxfnjaVVJ9AOQ1ZbJ/BKGGwVF11zi4tka/GR9QJ?=
 =?us-ascii?Q?+sAz9fJ4ld6kWYRH0ZiE+O81uyCDA+i2QTD8/OWgmeAXZN+Hdrt1eTjrns0R?=
 =?us-ascii?Q?TUsLKIaiBrsIQvvAJ3v8jzAgrq7RPB9fbDLDD0pU8NDctV8nPg0e806qTvH/?=
 =?us-ascii?Q?4KijbjUqbfJ9N0vwys3Omknl1hif/WzbublhCj3/ixYSZ8QOc6376mofm3ge?=
 =?us-ascii?Q?MtrYRLf9uuxkm1defojD7teGaeMlr6ggi6nqhY/My6Z69r81fhUroc0KTUJr?=
 =?us-ascii?Q?2tK00ExACnl6gyuX179U9uw2Kgi0ELSoT+d0l+XFCZ1TcK+4U5zx/wJsqo4l?=
 =?us-ascii?Q?3jqj2lnsoiC1l4KqZfcoLpPl31yzm0QrIueB3BJFGVrFuMXmFBvcjT/ghOQc?=
 =?us-ascii?Q?FsEmsqZdl5EdD+D6X7ORwzaIN9mVK1/kHf+soDwbhuohC392X0V1FA4WsZxp?=
 =?us-ascii?Q?mnJIUhpfGgqmR8+i9VI0IHpjAQTddpxFJ88Ya7GxanYSz9j7RPGqwBhH8LLh?=
 =?us-ascii?Q?rp0Dgl2dxdI0ujzdbeogggpcVUGf9gLSnbpL3kqU1nHG+K0mBdC6ILHXE/Go?=
 =?us-ascii?Q?JmlwmVx2EBO0pdTS9FZsVe1upjJ2pv661WO20m8ixQe+kbUqpwasqvbQHFnC?=
 =?us-ascii?Q?YYU1vs627k1DVYZCLaIYMIZbAMVSopIZ0eeOB+9fdLAUny6wV0pazIoPbN9K?=
 =?us-ascii?Q?RfxYGkA1xxO/uj4ycxaxHmu+6fX81OkwZ1CSnyTspFfPFRu8R8L1rMjNlzHH?=
 =?us-ascii?Q?IcIktxBaH92+IxNElbCuBCVSUUVzBF3QIpVk1Q0xAlh01TbnPLmyNXdoP8f9?=
 =?us-ascii?Q?MmW7wtBeeKxQMtXRMP7+DJNcXQM+F6Ok+byB9bDlE4aJGB49VkKBbwRLTUtF?=
 =?us-ascii?Q?yIzq2mFm2MujbwtGSSLTSJNqbhCQ19Q1m3bJMIQvwQLo+OHqV8AYOMk0bsGR?=
 =?us-ascii?Q?tfI2UBh/K4XBHc2H6KZEOBFD41aFSlh4YIQMbZggCR2HEEW1rSRuF4aa9tO6?=
 =?us-ascii?Q?IokJltQnKvAFXtYFe1QqZUPN2+XqlK7k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+hYExBujCSyRXV5jDjnNR8oDrxU4fV08B35EQ3VCL6g60rllfK0kwU2n7V/?=
 =?us-ascii?Q?i3xk9wYbNWFFYQ53wl04/zlqnPA9a/7SDyz4YoOPm9HbQgaoVIPjKjyDpfxV?=
 =?us-ascii?Q?E2WR6CckPlddEiha1/Ag6jkvPO4mC0bihrjrUulKeTmNkCAh7inpxEk+wlqf?=
 =?us-ascii?Q?ayeeHS4dcfjfUzLCQ0zeZC2watHMW2LINqoJ+84qq1gtW3ZqQyflGdaMQU0/?=
 =?us-ascii?Q?i8cT2pWqgO1rrU0KuuDb6gAPzKF1+08600OFjpV6zyDRdBUmOU2cAMi4+DDj?=
 =?us-ascii?Q?EEYCIZMG2UN0v5GdtmlQGjiH1NuF8ldf7UaCaw4V8WAsjX7JDsbs8ysu2NbV?=
 =?us-ascii?Q?454NMv+Qq99YjdZD7SAO/DeaYg5zkjI8zgt1Ro1YW7NZ2lKAhRLVeL0dgcaN?=
 =?us-ascii?Q?UH4gq9KZU9ydtwHyMgFHGUIK9qe6vUZhNwsA/U2aBwl7vpAFIDMy9J1wCV3F?=
 =?us-ascii?Q?H9eB1Yz7h2GU3BFkUQ5I8E8Uo+DeCm2HHM75npu4yyl6Un9fCbPyqedDUh5V?=
 =?us-ascii?Q?kLUsbNfUfxpB1yq+Poh2qx3CuI9Z1lHP0YNYUdWjXptVUezy8RkAW58MOpbI?=
 =?us-ascii?Q?CTVE7s0Bcj0VZfQad70AGjOWOLt2vYDYCIBMHsjtJjlvWh+QppqTsKT8MO9H?=
 =?us-ascii?Q?2KJg2OU5GPePBO5RGoFUmGCcUYpBWPpTA+HI47ft+dyviSsvxOwOH9ALTxlR?=
 =?us-ascii?Q?RJrCImczxuW1FYFmg0qSBgD2lNYvd04b94H8xsEtlpfhQOMkTc3Pn7iYB87R?=
 =?us-ascii?Q?DAozWlv+Fk0tuDo6U00okliPlAd34FHSCQx9GwossHFvT2q/QrTqiJD/qDjZ?=
 =?us-ascii?Q?TGAn4AcKEu1ckyNFgyl740HvO/FiEM1fvPK5o+Dy90OxRfMueVFTsXaQVXJ8?=
 =?us-ascii?Q?VcFzpL13A2uwfOPDtjhNgU6pwSgzJZ4J4KEvigqcT0mbaLG0NoTKSeTbmd+6?=
 =?us-ascii?Q?ha0g/KLFhCMY6qAj00psafg5qBWJvghYHINmIuZ3UiXYRnA64/fGBy8uCPsq?=
 =?us-ascii?Q?Vbwz7ea63SdEXP5w3wIvHs66X1WK1ha4VI8zOm3k+J4OB2mvDJ/ZwhgwCHxX?=
 =?us-ascii?Q?4Bl9hJYng/zDQ0vYF4W0mcMw1NpJA4B/jd9pGkjKJdZfwv459h/8doRRcbvr?=
 =?us-ascii?Q?xANLXBtZQuXLa2h+X6Z84b4awkfwA/JOcjTIluCvo79urp8HQgwMP/6pk63r?=
 =?us-ascii?Q?l/A8oolvQ1r8RJRnQ6bsOBU7R0rJ130a3E+aMmkr/CfZKLng5xTwU5B7yKv9?=
 =?us-ascii?Q?r9UDO182g7v08VXPDMyglccMg7IoWv0FXArhxM8k8ciHLrbIp1FNeB9dy7Zw?=
 =?us-ascii?Q?pEgkMdVFuxiQc3o5WBTMSlse5gSztpJOJdwliMWz93za2gQzJDsYQgoqiAmH?=
 =?us-ascii?Q?BLrXdunpyCeDaNAUTfLw6/Y/Q7GBguu62DfYB8WqLOPT3yoGWJmQy8mV5SM7?=
 =?us-ascii?Q?GZdRwIwN6x6oQCOQWwkFR32GReth4pIaJgxtV+crumU09JMkM1XyzY/b/Bwv?=
 =?us-ascii?Q?PqqNsULdtVfXnKHrQYpvy3Rb7PfE3las9F31BnjUkAd7u/JjqAHywfUoHrDZ?=
 =?us-ascii?Q?vxWLZq91uWjiaTIo6ssWR86UDPA8pVHTkY7kqJ8RtRIvl6DQu9sajxVzeQ9L?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfbf128-5857-40ad-f523-08dd5cd9cbe5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:07:45.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7qX/w4Gyj34vQUsk1jtWwvPYG0GS4vQcO8RnKLfe2Mr1E8CS++ufVDaV95350Rrbt8tLwInj0/wKrEBs8jLlyDpUD476lMwKv1yBB+YNKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10603

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
index a47181298e81..2869da5d1e1f 100644
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

