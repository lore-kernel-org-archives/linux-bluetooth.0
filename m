Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEE22A4F6;
	Mon, 10 Mar 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608050; cv=fail; b=tvvgk2f1yVcdBpyNgZ+VyruDrnYvhhER7iUuXhMLu6JdKmX560LuLlbfo1UcbGvo8O71jaQjJv7K2F9XRBsL/3PrfiAvc7SRETKMVEeQgP/9ZUi50RdC3HqMSaFzcoUs2FeoXynXu+yz7d+41Y9ezsVPXI5yzk3o8yM19VGsH7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608050; c=relaxed/simple;
	bh=qe2alsBKbOKlFOQFM1YcRjXhX+t058CVOIYE8hywYNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKRsng4JLFmcQa3p1TYduFgKgKPwsURXzvQ6MOz3m4K2gckYhHofzNIAqTrdvHeSPo4awwpfC9TemYD/TNJ00AHR6+DOceeaobwsZQ2EDdUQ4xcGD7oa7dGrQCVr5ixUrW0s8Bg4LuZT2NwVzaF3qRFNhLVtgfNNukWpdcIGHXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BFipzIOU; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BFipzIOU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2/BtiwL4CvbKZpW3gwv3Jj6qYejEcIA0pJdpvlZj3vsqgNyyP7YqRgFOsINReFsc4PS+lXaJ+77c4UXtVBL7xoihPxFIh+JmEiC69VM1SH7zssuIcL7as7bjUuwvy6pKiSYhJKqcus28XGSETjVFTAPHBJO5EcQzIZgcOUu/5EGxfIS5l5lJYivltAKq347rJJ0kkcqlH46Yk5srreekhDfMzcB3P8y3wxtv72EWWkgPhI9Hn9tn/CX5TJN6du7ma+5dQdMUUYE+IzEOyhKqWaY+edhX/SBuIbXnCO4ob8c2g9xDhhBU5V+UBY5c2vtLb58lG6bARnhIY/KuwOQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdN+UaRKdfu2V2MYIvbi2CmBGMx3tXwU0nQfmrhWLC8=;
 b=Ri70YtcJyjTd8lp6qFiz61c05t+UT8cQiYviC/r+PQNpYA+QmkXa3VSpt2OFgzstLMw7WiPIPCVdStlUEk18H2LkNW1CkOaisLLQKPSOOuwEQtSBnSsIGG+Hws2MkhbzTxEs6zSrC0fS5T/A+mcv8GFsFZ0w8Ayn449ZDsDeKWn9By+BQKJHCYE9fSrhyQ8xZIoPLS/RHtuyMV/ksHOU4w1khfEwnPuq0LERZSqrtEmZid4b9y4RWqLn8uRmPbuoiLRx+4stRn2YdFNd6ALC74aVY0Jqo8n0cjVTclMcwyz9ZeXG7Yt29yuuluNR9HtM3BZsGq30JuaX9GrLncOHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdN+UaRKdfu2V2MYIvbi2CmBGMx3tXwU0nQfmrhWLC8=;
 b=BFipzIOULUDsvG7XII416pg1h+AsMCmmU9pq7ToVN0etORsJERhcHzTjHSJ3Gfv7vQq5lsUvD88NAoz9RaNzO0rZga4/hw9MRASmVZK/n6nTBLeJ8gCW7LKHb7GRk6Zk+V9westoR2CrbVm6Yc05l7LNbQDGQ5T2g7ooOohtXQzOjYLktMUu28h56FqgSHmLLrsQxDhffqIa2ORYn2CAKUOORhZvsvdZbjxZZtWvAJlfK3XB6Abb9WpPWAd4HRqAzWs1yqQzoiVAZUYl9HnsDcyN/tvEFG564uAszSGETZAWvCrG24O/hBm+zX2BFb5l8FKQ4/mKCy5e/6M79jjNMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Mon, 10 Mar
 2025 12:00:43 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 12:00:43 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v3 3/3] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Mon, 10 Mar 2025 17:32:31 +0530
Message-Id: <20250310120231.263174-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
References: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 354f4b4b-a7b6-4d42-3860-08dd5fcb2edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwW5qy4L/WTM/PzNeFABQAT5Uu5M1EpGnDFcs0Xz+B2xK8y6RMRDaR7hVt5c?=
 =?us-ascii?Q?sENspWevs19Ha/VPSlSy/te0NhNz0GlK3/ZR1NN2uzg80OV5mAFXoKXeotdz?=
 =?us-ascii?Q?dlJb1nMarYuyoXlzPlsxAntmHAtHhy/OOCNK9TIYA14Zfa/ajPg2OYypjF4n?=
 =?us-ascii?Q?pYyQJP/+WHIBzn1xGctwn6fn2uSNt85cyKs1vIkeDrXYtlPheFl5QTJL3X/o?=
 =?us-ascii?Q?0sBDdViR4TFuiLu3/7A8Dd7hf6HhgMYYZOq33p3dN/GKKXjtai0AzomrU1At?=
 =?us-ascii?Q?xp2irubjRjKhkFUzS21NTSbBqwUqyozbysdUwZjTCi4/jI6GbduUSh3DgPa5?=
 =?us-ascii?Q?+c7tv7hoBAXSoSAtXgczRTvBG9DC2fGagMCTkkYmxsrE6FrbnUfe8MDswizD?=
 =?us-ascii?Q?HJjw8A5DdY3lntGikA5nCfJjyzyi1duYnedow33QTDf3dAMLVW/gzQRWWvFi?=
 =?us-ascii?Q?DNizvAKinByvxyWhMGAcqwycpMWmQF6SYSqTxBp+xu+tPoF+4x952D5oa4VR?=
 =?us-ascii?Q?4gekt8AUeQjxHYh6Qf3a4KBJbinzZ4gdxstz5vcKcYL2eCDrUU/fH2tjxX4n?=
 =?us-ascii?Q?LLwcQsNX/yrX7KpReHEPX37llqwtLByx603N8Hv7ZeuOeaz10/2cr3Y4/4Po?=
 =?us-ascii?Q?PG5P+jCvnoLGzZ3AA1I4kDLbDw9YF4OmE6OIp08wPJWzGOyqH+3rjHt2iTyb?=
 =?us-ascii?Q?lFH/hPvvkGJpKIP7U57stSMvNhbIh1LD9aMOM1AG0Fb6HGa3+BWZXMchKNgI?=
 =?us-ascii?Q?wm7p9RsUAzApFlmyfRd9RI6Fwndi/a69WyB/atlv4Z5RPpwHHoxV1/aC0oS/?=
 =?us-ascii?Q?5nPSSHl4QbSycJflPwaTefV61SbMlRzLlPYkpnbArCgsYQQm1J+cPE6WXNzs?=
 =?us-ascii?Q?hQNzVuqI62C6p7HWb45lLajcjTXKM9/y3biw/okICSFWbKDE5DoQTUhTmumc?=
 =?us-ascii?Q?7QqgK7RHdbN0GZqCV/Z7Nrj744WfwSD2X//oz2cDY6y+U2lx/dSsNO7BSkSa?=
 =?us-ascii?Q?QCCBHzBwrm7MrgyxCF79dyW/DuO78kfqqi4pOaJRy9REpWj1LSoHvkMxghG8?=
 =?us-ascii?Q?Hy9kRezm6V8nIo/LqG7ZDsfJSqa+XI4sX7Vlf74l7C/vdXJsZqr4Q8I6X+gx?=
 =?us-ascii?Q?NREXlErSVb1VGnmD9lkkjNPYwlGRcxU04Bi+d5mq3OyDnqrbTepNTZxvxIil?=
 =?us-ascii?Q?zabrb3z9wO+rAM47ouLIiCGHVOIYxHVZoqKyBUicudhZZS1MOGeD7RCBWH6q?=
 =?us-ascii?Q?yTqUUMBwOBEmLpmk/96TbbV1iApWuepFC+LIQhupojjvIjswHQ1vu2kLDVr0?=
 =?us-ascii?Q?r7qafXV5LQp9EQhDO/a4ON5RG4wuAv4apmSJ6M3anIQ7EJXOs07al5x96dVM?=
 =?us-ascii?Q?WudQsEwAP2hiauaaUGHcijNOsMl1jUoZESbdE//aqBWxe2y8YPA24ix7P7RO?=
 =?us-ascii?Q?uv/50qwUtaHlImU6rJSbSXIpJYr4DhX3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+001GSedBhB0GNRSCaemKCe/FAl11ABTJXkLgWEiTg0NjdRypoOPKDd3iD9?=
 =?us-ascii?Q?I5hXYrEdWq7+dwvYLdbIdpQLC2bV6g3IXdAUTFww79Adx+dhsI2DSCvzifKx?=
 =?us-ascii?Q?4+VRG92O/UZDaO/iX43MY9Zp2Vrdt+mXamTfPQXt3Nhfxo1/X4dsyVFACvXK?=
 =?us-ascii?Q?+/QcU6cto+lZR0LMWCfBopqfD98Bmq1c7KsnSDftrNRIU6WAYpX0QuXMSnNM?=
 =?us-ascii?Q?ujSeRjyi912WJVZKYC+yNR9uICTInmP/XdZyRIpKSQCnpXAHjsLv+GlZBFha?=
 =?us-ascii?Q?sHLuIrMhNCEDbp1XpzGfivpDDsF+iqCdxSaOXbBN7SySpzu8QtScmsdKFxbr?=
 =?us-ascii?Q?ZFuv+Jb0MQxxQQhwT7I6fgtOnGnm+4wlDfPsA0Kjm3GlhdlJckjhMSYX4Xd6?=
 =?us-ascii?Q?NH3/ZfoFO8tlp2Qi7Vb6yynUGaYgSXE/LClYTvaEjSsdSNrqJZdYbdmZ6Glp?=
 =?us-ascii?Q?cmq0BQbRWpULMoc2VXXCsxK0mFSVPQJqUi/O/9EwNdllCDusFrg4f+eWqCj0?=
 =?us-ascii?Q?QIRIvXrB8Whg80SwlZAagouoBhgc9lPoBRhcedKh5aLWBj2u/Wfrax6zuKbf?=
 =?us-ascii?Q?bnIfqhYLC2+m1sGEEBT6BxcxlXKgK/2VsV7RF3fl4Mt5IEwMNEcHrur6KGUv?=
 =?us-ascii?Q?tOkW6xMeVUWvkbtIBxYqwfG9y4sgtD+5P+rEGtxNFwpeOLgdnCRAKdeDOSBa?=
 =?us-ascii?Q?6b98ALst/hFYOZiF3GieaQfWoko1ev6VuOFWZAAdk/YFuGpsTdGf1NwI+9zf?=
 =?us-ascii?Q?m99MIPx8E6PXKh2LE/+kHDKGF6xCljqGH9CLlZkUeZupdx43pSeeULp5Tu33?=
 =?us-ascii?Q?S1QSjxeL6L0jK8/r/Idh15d7/rT+W+J78hpuOSjzheeKpK68qrArP2suXHOG?=
 =?us-ascii?Q?9TgQ3H7i+9pbBds10XapTZr2gZx2Al04/AvCiz5/ifFzoJ6Cu0D8LxiWvP0G?=
 =?us-ascii?Q?wQNB8x2OHl+knHlYBYllL6mJSFC2DahnrTLuGVfJOPFQlgKB0Z6RJ66Dvtu/?=
 =?us-ascii?Q?3G1QP+mRGnAc3FUxGaZn9OvONhNjKplsrIF4yGULFcjf4l2FaQSA6bZs6tze?=
 =?us-ascii?Q?oIAc8J4GOmHJgKdKtWwSSTV3uuPXbqyvN4WDF4tpu3gWL4IPYRX5bdTJeDbE?=
 =?us-ascii?Q?Mc/UBhQiOVTxJrNUFpom44ZD89aMs28MNHt6ZjP0B/kJwrogBq8XnHSyd4r5?=
 =?us-ascii?Q?Crkpbly5aSIMQIg0xBt4uH677HG/WYaOpgMVHSyAgF+myvV2YOwjm8IV9f9L?=
 =?us-ascii?Q?QSdyFFST+SjMXn7fIhceQ8kxqgCLB5mySp3nfuCSxZ8+c5eKqWZlZAPWxr0v?=
 =?us-ascii?Q?iwzJms2vbPkvnaEuyq0NDc9ENV1uQSwBBoyZJuCLB3REGmRp9gK9CECA+7Ik?=
 =?us-ascii?Q?JnPwkQ2CVpz7wv+7JRYS6igCgE41j7hajg6IFkTe2Kd+JSE5XEiXktHIdvx7?=
 =?us-ascii?Q?rZS0VbJBlZK+YZtYSKWcG3KkG90XhnpavNSfBPJ9VQ7bdDigvMctsXgj6/qM?=
 =?us-ascii?Q?dZ7ooF0e9ryppIO0JggbVwB5Da3+hTUySygHxO0kVxrlSuF/gQIk/yQUuSmu?=
 =?us-ascii?Q?9R4ktf+lFolJN4XmsWeM+GDMwouCzdkE5Pgr1lH77mlIuX414Hz6ppKqbRl8?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354f4b4b-a7b6-4d42-3860-08dd5fcb2edc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:00:43.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvboLUS8ipNNrQIGKctX9T3u0lPDAqWMzm8mbBVdFG0/S+0vTNRyrGVk8LvqK1OwBEuq1rxgjAVCrwsFmJEe2zqCGYo+tDAsZ83EDCcIqcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

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
index 1eaee4832b2e..cb2ee773c95f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -701,8 +701,10 @@ static int nxp_download_firmware(struct hci_dev *hdev)
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

