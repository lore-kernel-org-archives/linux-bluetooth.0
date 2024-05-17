Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9025750;
	Fri, 17 May 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944528; cv=fail; b=ahq0ABBwTLtsFpGoN6N9ZjizVwhWETadUtszkCeXP0mr4r2apSpCLPcDgdzud2zkBApHEle8rdqdzCtYTkYmKVQHU4rn0DMrpQlKWlfPmnWAhApCrkVuKwDJvjD28K3MrVYbpFa7d+0sD9hCXOnfOFzc/k6X3F+DoDzzfMZyhD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944528; c=relaxed/simple;
	bh=A+OG/nzFbfPfox94dfpGTvEC1Dd8+zoYgcQTgfmEuZU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rJOYfBg1vRczm3C7LoFRIeOTFnkNMBdrbnBCf32Ebkfrbu6bu0U+2/tvxzfUnFjfDQ8hTlRlOSvcwPPO36+GBfO+jcwswY/iDGHNarovACeUcRtdTx59mTKP57B8hGyQyk6uabrlOB3iIBkNuIlX2kWl7SsDM6lBUWgZgMg8pDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AHCgqxK1; arc=fail smtp.client-ip=40.107.13.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AHCgqxK1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pndu0IhEOfVOZwVoWiMJ4APvb5/Yj99iANYTmK37T7Ptesu+6MZVBP9PWir3wkGJagP/QjIdjFwTStskFqrXWrCWXV/LWHWgUdrfIMmMTpHVDPhFc1EgZhqnstK+RKoj1R5i7tFHy9g/p9jKjrTWe5lpMbGmkP932hJBUbZTptXG/awZ/Q62+M65Y2FZhYyD/jqikSA6UvmnoEOU4z+E7BzkPOvTDKs4a7O/EyA43x+ecT5f99Q29NnqmGlSUXs1uFLItzDP6u/l+sJRRlG0Td7NQoevWenjLnb1yabSyuvlSao75SG/UU6l2JLCZonMB5+AyRfTanixU/Wgf8pbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNd0AxzmjkVG+XQaOEYgGmjrw87eyw54tLK+Tm5/TXY=;
 b=oXfQxO3C+Gp1bMVZ8iX6rjSrC8qvrlrR10s+GmzgROuEXvFJQ9Pl35Z1BbJHtkkmssfJHQg8VkZK0K7kl3TCd1tgYSZklzZhmWpk5XrmJ6yBHcOu6XhgtWO7EmLUlu8xsDXIwTsNaNxE5gnpljHJY9oO8Oh7g8rM0stNozmAiv5LHFuKIvFJeUwXjCOJT8zJaXEgTOU09cjEHnAkO8YSsxuypf4ivavhdSktk/2qRAu6BerXWecD/k1Q2XcG24XXupUFlirgzhFaoqn/3Wkvue+eWRyNBp2zZgOcCe2oGjCzMhyrDTEe+3xdMRFtmVjGZqoJdReveLuklJrQlGReXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNd0AxzmjkVG+XQaOEYgGmjrw87eyw54tLK+Tm5/TXY=;
 b=AHCgqxK1F+mJQT7aTxo6xrWxSmRYk6tiJgONAp0DvmF0XnEMqPESUYNlRc9M1INUB5OFgK8X3e0+mz0FBtbBMCGLMVd8t8jBf4835TBT9xpPPiUg4Nl/ftDZcPn1dDBMGkr/vB3qFdLY5qABoF+E0GALTVseZPwHmJ650PVu7n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI2PR04MB10978.eurprd04.prod.outlook.com (2603:10a6:800:27e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 17 May
 2024 11:15:22 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 11:15:22 +0000
From: ziniu.wang_1@nxp.com
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	haibo.chen@nxp.com,
	jun.li@nxp.com,
	guillaume.legoupil@nxp.com,
	salim.chebbo@nxp.com,
	imx@lists.linux.dev
Subject: [PATCH] Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading
Date: Fri, 17 May 2024 19:15:35 +0800
Message-Id: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|VI2PR04MB10978:EE_
X-MS-Office365-Filtering-Correlation-Id: 236a58e1-6019-436f-16e7-08dc7662a46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pIjR4YKiOZSQ7VOvyPl3EsXGy/bX915KAJ2cEBfBbwPoL8Nq1SpE2a9N/hJ4?=
 =?us-ascii?Q?FEWzRvz94xLHEyoWfI8QlnlDZtFN8kf/4VoNXqnTPuHiGsXVlVtlgC+5EJo9?=
 =?us-ascii?Q?oGSfSuVm8UCYtEH6P6y/zQXv5PHGrpdpBz5jeaXEBx4BJOmqKU9pvQBIgYII?=
 =?us-ascii?Q?8sRtB9n3Zr0rVmF5nt8AHsxnz+5ef9s9rMvRuh5SW/NvRnJl8CFuOqGCOwPt?=
 =?us-ascii?Q?ToH4bjYK1y4mjfWPNUmPzUr2rf/yUTJ+U/ga4P5RlndRHnVKI9jZVLCGvp2L?=
 =?us-ascii?Q?basFrrvHlB1ouCdC9HQZKf5UJByrb6zOJsYUHROYUMX79EYkwW4r6LqbK+QH?=
 =?us-ascii?Q?UK7EM0s2gdMY6Fog9AQnYhdikJuY6rZ5NhEZazl3+mq0E1LE9hOorbFnk3Dr?=
 =?us-ascii?Q?Rl2kbzcjuXc4XN8a5L/HrgUn4IUd+vfwh0AqO1nQ6a6NLg9jH4xWV1VbJ37k?=
 =?us-ascii?Q?bUlW6fZnouKpdLMbDESpAgwB22ZS8UbySW1zqwf7eEEXDazle0+/nEYKsAFN?=
 =?us-ascii?Q?/DNnX4ioPLZ/cwZWVAWkcfJtW+oOozum9YtsGw/UbzwaFi56uV86nwqpMJN2?=
 =?us-ascii?Q?0D17oUVY4XwXQ9zc9g4zG+p2jsKZmy146AN+x3ZFZyq2eaavRzdDq+59yb+X?=
 =?us-ascii?Q?9WKS/+ZSWCPbPNffuYpeC4qB/V4EpMVF0TO6vwDofWLxWKplfG+ZudhH9ZKD?=
 =?us-ascii?Q?hhc8j9CznSk3VxiGPW/oVFpwF+2Tu7y+VMqdVPutxZehhx6pJ+b5yi6LLjAv?=
 =?us-ascii?Q?YgBWz/u4LXL+pdnvrjPW/ziShBUiyNVzMoJpupDewjXuFJdFBOzwCBR++1CW?=
 =?us-ascii?Q?5JRbzI6oCG/jpFPtR4ANGShC+aysy+TwHZWkSd9vPSjIgw9eX/QRthrcoCOJ?=
 =?us-ascii?Q?rOM/QHe0bKzJhOlPYz3dAJ/IAMPDL29Qd1LOL4dlISZLgB/EygpPvPPgps0Z?=
 =?us-ascii?Q?ZiwaR8x0VNvBQF7NhDO5rLKWlSxP38m1Cq43jTJrFy7bDvBWrgeN+2Cb6eAu?=
 =?us-ascii?Q?z4PcDQUCfcUf5uJvgdorTRt89cZdc9w7lDYtgJvQy+pOUW1ulWNhMKUP6tc8?=
 =?us-ascii?Q?TgnKu8hPdZNXEjlNi0ZYlIQOXvq//B5C/22MhOM7errg39dtNCYpET31G7az?=
 =?us-ascii?Q?CayY8B3RI9q0OQ5N3jupievHdjloP1Bz0sOOwYW/pNjFlgox3smTs9S/gAtC?=
 =?us-ascii?Q?7G0WD8AGpvoWJhX7Gvdmf54rYagFnvggOtOMQPP/Px9aqrSvEiBU8UNjoBEM?=
 =?us-ascii?Q?yNJ2aDXhwdcGq4bPMA35w93he3tJIQCa1ztt4KRbMOwAZEyBOWXv0ud6QVbY?=
 =?us-ascii?Q?7vBOm7MBq6YDvvQicAjvrVIMg7URs6Rdkgd+VFxZHZXiCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C75rsabimkniidpKhjdD6DpS+6mYE4m4QCzrMmIT0hoe1+Juf67tIyBZm6QM?=
 =?us-ascii?Q?Az8+hje3AX/+1MeMWVggx4YzMqpr/8uUkZcuwi4NeUKl6hPaIjADdFn522uj?=
 =?us-ascii?Q?6CC3359Sh33FhZ1CMpSejYse5bfrGZwuHlErQO0K8cSqN0BTAWZSX90yRnKQ?=
 =?us-ascii?Q?8sKGvon91410KpErqmlPq8EB3i82W+eNHSGsDPQE1hCQ8jgKbdDjI+V0DVaW?=
 =?us-ascii?Q?A/BNWPY+R3pF7Ks6ZR2k/9yl9Ceo7AKhj/MgbyWqY8mziJ5SdhrpKmdrlUmy?=
 =?us-ascii?Q?0Q27IH/ZeFB8Mkp4V6G17roBz+61Yf+UqF782P0KxcIie976Ej3M3AZVht5b?=
 =?us-ascii?Q?0T5o3NF7qsICNyfWy4GQT+HFFPPkdrJPGB8gLS+qR7zE2AFCczp41yDTi3rq?=
 =?us-ascii?Q?mbyTFtFUO4Y/ey89nO/vImdYfwOEObBgFnKsYvhR+ImSsw+MCAglTJAdDnxF?=
 =?us-ascii?Q?oUncN/ahGKa2rTtROo9kripgjst0FwEu7xPZoDh8YVrPYSdrQBh1Mvsowwdh?=
 =?us-ascii?Q?OrZPJjy44/XSH6mew0sawBy2XTUjEvllCgkM9C6BdcH+BniqW/6m0sGaoIZZ?=
 =?us-ascii?Q?A7kQdzZiUOQqkpJ0AKuYnJch0i7R0IP1fvgZov7I11MQvSlZKmTdN3L25C1f?=
 =?us-ascii?Q?1FSR8LPbO3qrREE7Mb2Gb4TGebEdF9q1D1nffJ8k819WP4o5i9uWXFsyoVjk?=
 =?us-ascii?Q?ZNg+YujvIjLnzoWYK2qzeC9OKybUcZX835KJTKDdEKuDx4EJoEVO93V4N2VB?=
 =?us-ascii?Q?1W3DqsUuxHsPlpsF0BB7pN6xav6OSzK2/irvzPxPOaCibFCmdzVA4hCmUaA6?=
 =?us-ascii?Q?R5plPSwmpcOHOZD/fQ5avCWAFwkYIZZ1U52Oive6rL3EAsdjr6AmL4DIC72v?=
 =?us-ascii?Q?PPj3rXZQR2KifP9L/y7qmHqdOmFOKQDUtQKjJVtFkEVeeQCVs/dgVFHv0oPo?=
 =?us-ascii?Q?ShTlv9XpRUAJdJbgNZThDwQ1dfhTuctd4DGUSFYarEwOl6eh/4xZXb924wm4?=
 =?us-ascii?Q?e5TNix+jexL03nUgaoEg3U/eDuNL2gyf8uyxKPxdzEnM6Dz2ZtNU+zbAtKCh?=
 =?us-ascii?Q?nDatu6L1v3edzQ9mmrb88ZB3tzcAZC7dyqXsPC4R7AHf6RbP8BG+12QCbUPa?=
 =?us-ascii?Q?r80JKXUBs9vDbf1C6wNEPMiJxG8Jhkoz24EwtWDlMHl59l9o3oj1gdiRIyom?=
 =?us-ascii?Q?9dwk798ZGG80zfEX57wb+5RF6yt6bLZO3p34qbh+WemoIVamDcO9bXO15+Wf?=
 =?us-ascii?Q?lbcljclYEIH1LWwcX8K9g3HgVPox97onDhRBuSBaigqQGudcTCrr7NyZ2mSy?=
 =?us-ascii?Q?HhdUojEQHDBo72Vhshcub+MsByWFj2H/zrrNiJNY7rTnIvDua3Be2vVee3dG?=
 =?us-ascii?Q?Gw9AaEp+DwWYlzQI1u47oo4fEFK9Gg7yWvG7kyZZTaMvjxUMR0n87w0oP0xk?=
 =?us-ascii?Q?VkR51MboP1KRzbv4Mk1bg699hfs568IKUozjDIvbgTEknVjrZDS6VcTEovhv?=
 =?us-ascii?Q?vLLED7exX8TKuuVEHG6yIdpyI73goINRJ5EDiEw3o58pTke0fr6yAhj2Xc7h?=
 =?us-ascii?Q?ivpuyRc7frtyUebieeXoROdteMcsQh/WY5f0QmTR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236a58e1-6019-436f-16e7-08dc7662a46c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 11:15:22.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9jq57Ls6o3tRdZEmKuA/MMgpdpbBpI+MVQ3V/vUU9rqqGaRrM5PCpXfcR+gKdeKc9QH0lalz6D6g2WP/Yeg9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10978

From: Luke Wang <ziniu.wang_1@nxp.com>

When unload the btnxpuart driver, its associated timer will be deleted.
If the timer happens to be modified at this moment, it leads to the
kernel call this timer even after the driver unloaded, resulting in
kernel panic.
Use timer_shutdown_sync() instead of del_timer_sync() to prevent rearming.

panic log:
  Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP
  Modules linked in: algif_hash algif_skcipher af_alg moal(O) mlan(O) crct10dif_ce polyval_ce polyval_generic   snd_soc_imx_card snd_soc_fsl_asoc_card snd_soc_imx_audmux mxc_jpeg_encdec v4l2_jpeg snd_soc_wm8962 snd_soc_fsl_micfil   snd_soc_fsl_sai flexcan snd_soc_fsl_utils ap130x rpmsg_ctrl imx_pcm_dma can_dev rpmsg_char pwm_fan fuse [last unloaded:   btnxpuart]
  CPU: 5 PID: 723 Comm: memtester Tainted: G           O       6.6.23-lts-next-06207-g4aef2658ac28 #1
  Hardware name: NXP i.MX95 19X19 board (DT)
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : 0xffff80007a2cf464
  lr : call_timer_fn.isra.0+0x24/0x80
...
  Call trace:
   0xffff80007a2cf464
   __run_timers+0x234/0x280
   run_timer_softirq+0x20/0x40
   __do_softirq+0x100/0x26c
   ____do_softirq+0x10/0x1c
   call_on_irq_stack+0x24/0x4c
   do_softirq_own_stack+0x1c/0x2c
   irq_exit_rcu+0xc0/0xdc
   el0_interrupt+0x54/0xd8
   __el0_irq_handler_common+0x18/0x24
   el0t_64_irq_handler+0x10/0x1c
   el0t_64_irq+0x190/0x194
  Code: ???????? ???????? ???????? ???????? (????????)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Oops: Fatal exception in interrupt
  SMP: stopping secondary CPUs
  Kernel Offset: disabled
  CPU features: 0x0,c0000000,40028143,1000721b
  Memory Limit: none
  ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7f88b6f52f26..77f974a5251b 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -328,7 +328,7 @@ static void ps_cancel_timer(struct btnxpuart_dev *nxpdev)
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	flush_work(&psdata->work);
-	del_timer_sync(&psdata->ps_timer);
+	timer_shutdown_sync(&psdata->ps_timer);
 }
 
 static void ps_control(struct hci_dev *hdev, u8 ps_state)
-- 
2.34.1

