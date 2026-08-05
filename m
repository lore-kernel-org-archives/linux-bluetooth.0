Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61635DA64;
	Wed,  5 Aug 2026 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898621; cv=fail; b=ZUnRwn7OLV/XZ1lFUYHILKhx5HznKVrkZpbM2RnNWn9DMiRCAE/aQ2a/vwAPZMB4IFPFkGJAiTjeDnCcq23421/4sW5B0rrRMtJLhJImRHzCplrR+n8AovohHg2wBHkV9r8xs2FQAYp+tjQ9S3Uk/eW/5+YYcmT8EzwbuHsjdfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898621; c=relaxed/simple;
	bh=Q6cC36zNniaNEv27QXIRmNUFmjWoNKyzfJWdKugtw6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=haDL+X/9SOM0rTsdAXmRH/f2P64hzx1bjhabMInFxPLucROJy0cNc098G6xMmYu/pRHh2teiTfDF43ScAPAhfRKlLZ5RjMgbIJIx+t5Crgv14Z8S33Ld4IW/MYpwu9hP9hwhr+vIqjTIgkh7PSRc+2lIi8iEAEYdSpZSH7w7ouY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=G1YcAT4f; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G1YcAT4f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqnFoMYoQz1xoUDYZXQTH8y/M0pXMMcsppr8JHOgi4wCGD+iBe/AjiHU1hLtYHGCV9bfXs0OQ1C8iWgMRDQlSqzx6SK8K2doFHa5KUFj1mJ3AWROP+NZbxAQwB2hG2sScpZgtW24yhdWHW8m7r4RJefTaFYkS8XUcgBkKcVzH8WuntuOaE/0l+LaZEhluuXP69OZ38/DxHa+d6Rq+goP81T7PBzqlCl+3muFTlH6HejuE4f2lRwkdmpKEUAaTFLikMJd0vIM9x/BB+LtZHYyEu05Bq/2grrsKo3aMABmxd4N+PUCRR5zdRMckk5tv+FUOqIsSVauOLs0PDiFsRitNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPusPnO/WeWD6qwAY2vTi94b7Kfde3Cf0Ghh2+l9KbQ=;
 b=TIk7ZEf5H5f4mIG59DGkGqLwE/xi1yY02T6UjiFLXf1HiScL3ZkQYWJHKTtXdxatHJgeOUfkuDXgsyaFC8KRNYQQTxE3vVPPwDJnDKI30ig5jrZh0Dtk8L+RzFitZO/OggamKDVc2G6r1M5+J/BCO1xfRUxmBsaxJ1Ft8z10yiyI3P51hWLOWBmPBjWt54gDWsCTdzXGtgsapLsfRRf78GhPwmF4Lkh9osYZ/Ou+mwxjXpccJP+LNVarDryMS/XaTMrgH9ONcaJZDFsWoswWQgmmbScNyV5MSGdwFaG1unoBC2OP5+XzrYDiPpw+ztc0/vF6on8BRKhv6FuElNZG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPusPnO/WeWD6qwAY2vTi94b7Kfde3Cf0Ghh2+l9KbQ=;
 b=G1YcAT4f0URGjZKpHK/nX/YG/8P5nMr9VIuV9SWftiJspdaUVE62nE/vVVpsn5jwKy4cYad9dwYUd1HLgHH3C8nGHHViaN9EHK7zXr+CWqFR9OoqOzHCGbiDJ0HhxUl+s4UvtCLQRFBzmdYAj0oPgfc8CeMei/KiW6+Y4pCUAZ9D5XMQk/aq6vtTZyQB13t+6f47tWXNZ9cFufJmCwczT5JVMZh66eFhQE5k0lS5GYwXSBtmVxOTPq3bAneiCHpaWQClWl5lf5GWm6KiqWWNAZCfqdQTj/0W8gYhO8wLF9DNGcW+HjjaOSAcU7ciE6dH0FjI34t+N1pQnBS72IV80A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GV2PR04MB11215.eurprd04.prod.outlook.com (2603:10a6:150:279::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 02:56:56 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 02:56:55 +0000
Date: Wed, 5 Aug 2026 10:59:33 +0800
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, 
	marcel@holtmann.org, luiz.dentz@gmail.com
Cc: imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, sherry.sun@nxp.com
Subject: Re: [PATCH V7] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Message-ID: <anKmfKB6T2dE9MCl@shlinux88>
References: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: SI3PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:295::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GV2PR04MB11215:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1ded52-2985-4677-4c9d-08def29d3581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|22082099003|18002099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2Ztt+WvBGQH1AGFZiNSkeAx9uKXs8X0z5OUIySt4yD+0P3I2Znb/MTd8Buq064WRNKG2nC3GSH7xDzSGJTQ+J3LZqoHlDbVfrQ0RWgDzwxB3ssPL9dwIFkqYHcRABEuLPuQ9QmNToXB+7mXwlakxwpsNgdLwkFidhDRXOptdOUqHh5SzsQP9MugKAfQhQEPVK6qZ6j1RS+GDs9ZJtGZsI8XSjC80PW7BYSKj2bMj9kydgRcbAjdo9qMdaceizwVHu54aMWKTZ5nGEleROhi1X2esEcSUAThlF2czNkXdbD/e7a9IzRGaJdaQW9SQIGOjPXHhN6+fems82cMsTNfWR8GqqxoatPzxdQlTZHe1TeEIPakIe7Hsh3tFNYDq7k4bQVoWw1nuG299EIK3QW1FwwoZl1zI+92ji9zXmbyuQFlUPB0lnYH0u0I7E3hkvHuHsWCPj9k10JyBv4eL3IduJOxpR412llCoMff1R3m4XNitAWS40QPWm4UrjX6Pz/UMwG4jXPEZhRpi5cbl5IVY0WaOu/ci3RQ998j6a8+km6h35tqrkAIQSzalUYFLu6YIn+9C/wgdM+e825QkHP3UYy2sVWSUH8YMey4H8H4a/kxKpkACQMxW2dRZfw4mDYFomBRxVJ7NlUIDaSEXC0zsVCBHsNbVLHV/uB5VrdvJhyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/RzYisdlPDrvMhghfAptHGFLEkVWSOtyuhbenYxVUbz9zQMT9gmmE7OusY2?=
 =?us-ascii?Q?8gomP//UEuzjqbf25dkRZy1u4iMp8CLOBxQAYFX0WgPQ+4AJufnOUETOy7xB?=
 =?us-ascii?Q?MIpJWa9H5bzM3mJ1NEP5fbjqirBXa99I9B9SkOk8IL+NjH7xns6xxbjYiLCw?=
 =?us-ascii?Q?OaXI9xCWqHbFUjNX/x+Jk0cNomYouF0/GpyxVcE+UbDpLk9P+LdrlyI/Uxk7?=
 =?us-ascii?Q?veiNNFlGdSSI9Vv5XkzPO3aSpUFICJFugX06PjsIYMAqHyVjoVCn09yU5FU4?=
 =?us-ascii?Q?AMVvqyh/I5IIbmirMWoTkPDCAWq0QxI/Hpw8seP8RYSXf4CyXqHyJ42YJ3OA?=
 =?us-ascii?Q?HCKFl5dp55jGt6prztibiiSRcPwfOALVaATMno5x6wTaMG54L3ZyH637a9/K?=
 =?us-ascii?Q?1PyYwi8510pHD61ezUyqp/Xere5CbjgVn4w302LUBlpU6ox9cyta6MOBEDbS?=
 =?us-ascii?Q?q+fSevxZGz88n3k5D4M6ZZpRNi06PRfzRPvJNktKeyocNlLUWk9PGHf9ekhb?=
 =?us-ascii?Q?dYY+D+2G/lRP/sfnBO+hoHBsMNuNTfJ4ng7+eVxWXVx158vLhvTjnqFL2J2u?=
 =?us-ascii?Q?Vlf86u3JYiAnR/4OF2aPKb1+oR6iGaEnhPyBZ4xmsSXn9coRCePEvzcLh2cH?=
 =?us-ascii?Q?+DVJCS/FB9L5mTO72BQ72yWlmusFbF0JTqgMB2gWKFWLVfyD50a3znQ8ZpIk?=
 =?us-ascii?Q?ccvuikwD/n2i7G/BZLzXkUV7QQsiZDKIXiS/PwoYB9JvOADJ3ImK9DSpGJF7?=
 =?us-ascii?Q?TYGEDgIRUtRbDpXJ++XiFkA5x//8//Ro2NftlFP++760PR9KGhPFKGNf5TQS?=
 =?us-ascii?Q?E5HlREvSrcwulCwaeg6Zd7ztQrJgIPzhrvRz8H3d5tkxtTncoaWcaMjiMbHv?=
 =?us-ascii?Q?lmp64UBHFQbWgRZkumPvy3mgJ3cbFPnf9yp0dYrvlSWRKGl8tBq1zbxhxe6Y?=
 =?us-ascii?Q?NNPLyXNX6nOpU+qve36DUwYGXieGHUq4PJEPSwTFatt3N5TdJzaxMI+NthGI?=
 =?us-ascii?Q?jb17dTAW/kX2qCtW77gYQNVBadj4aFiZAukyQM3nXcc3SRGCuiOwbCJFOnpw?=
 =?us-ascii?Q?E4IDxwC1e6Llc8e9iw2sTle9SVeaP2dK6+SVvKEWUlRDohOwscJdc3RINZO/?=
 =?us-ascii?Q?nDpXjKoLSDoM+ImDgd0xZpybFVkFRhQ0uZEn2mVHdyGNpXlNX/XP65nCvoP5?=
 =?us-ascii?Q?OoSjnPQCjLVHRNuUmZ9SRQUmhcgScbG9+UebDV+Yd8TQf+gi0rN6Kcm8BDaC?=
 =?us-ascii?Q?j0l2qgIwydfkbRbdi6FubxQisL3ymT3k4MtkHDJwrNRd4g9lF3ih/CsMjcD7?=
 =?us-ascii?Q?wLhW3Rm9wz7vFQZkSF6u8JFPfjFvqZI2j/S/R5wL+E2XCB92574VnVnHNbdb?=
 =?us-ascii?Q?piEqfPXi3QcKmqXTAv1+UUtaxg6SctPagqVBRC3HLSVdTJ7/kT2vQ/mj4AVr?=
 =?us-ascii?Q?CYqiU/juL2yVlvv95soXPWUc08YY2hZ7ZHAX5X/jR2detmK51ziX5r+0h8nY?=
 =?us-ascii?Q?u05NIryFNdQvE71M9zXjiUIRDliQb+2/5CypCoI56TINl/y82Sg2/oTA52Nl?=
 =?us-ascii?Q?BwKYXY+kkUzhy/10/W4h5c8gYJryb2GUAZRtn+Nju2R3f0LDej00UWvxUtY3?=
 =?us-ascii?Q?KLUV3ruLCFQ3IiTfaHc4VnqpPogFqQNQwBIF8kzZEzJid7cuIFQyRFHKvmd0?=
 =?us-ascii?Q?SGuiZ7Kdi8Hlkr+uEKkMB/tM+yPByJZrSmB5sQCJr6u+c9CrPp29JTRqZpxO?=
 =?us-ascii?Q?1/9lDzzqWlSU3+Qzh8qhA0/qonUB8grq9POfRl/7dPYULLw/zfGe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1ded52-2985-4677-4c9d-08def29d3581
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 02:56:55.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCFLjB2xOcu3FiWHBWaKVoSJ4Cu8vZq/D1MTA2V7X2ZoDY2ExM10qsVbtMLqXheNGPSKXT/nrmCi1NXhdjSST6iw/MpGo2IBIhWGkUSHbiL4yhP5yFcRXqxN3F1O/8fD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11215


Hi Luiz,

Gentle ping ...

On Tue, Jul 21, 2026 at 11:04:58AM +0800, Sherry Sun (OSS) wrote:
>From: Sherry Sun <sherry.sun@nxp.com>
>
>Power supply to the M.2 Bluetooth device attached to the host using M.2
>connector is controlled using the 'uart' pwrseq device. So add support
>for getting the pwrseq device if the OF graph link is present.
>
>Once obtained, pwrseq_power_on() is called to power up the M.2 Bluetooth
>card. The power sequencer descriptor is obtained via pwrseq_get() with
>the UART controller device (serdev->ctrl->dev), since the OF graph
>link is defined on the UART controller node.
>
>Also add the explicit pwrseq_put() call in all exit paths, pwrseq_put()
>already calls pwrseq_power_off() internally, so no separate
>pwrseq_power_off() call is needed.
>
>Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
>Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>---
>Changes in V7:
>1. Seperate this Bluetooth patch from the V6 M.2 patch set so that it
>can be applied directly to bluetooth-next tree, no code change.
>https://lore.kernel.org/all/20260713023435.235765-1-sherry.sun@oss.nxp.com/
>---
> drivers/bluetooth/btnxpuart.c | 34 ++++++++++++++++++++++++++++++----
> 1 file changed, 30 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
>index 0bb300eef157..81a11ac05114 100644
>--- a/drivers/bluetooth/btnxpuart.c
>+++ b/drivers/bluetooth/btnxpuart.c
>@@ -9,6 +9,8 @@
>
> #include <linux/serdev.h>
> #include <linux/of.h>
>+#include <linux/of_graph.h>
>+#include <linux/pwrseq/consumer.h>
> #include <linux/skbuff.h>
> #include <linux/unaligned.h>
> #include <linux/firmware.h>
>@@ -211,6 +213,7 @@ struct btnxpuart_dev {
>
> 	struct ps_data psdata;
> 	struct btnxpuart_data *nxp_data;
>+	struct pwrseq_desc *pwrseq;
> 	struct reset_control *pdn;
> 	struct hci_uart hu;
> };
>@@ -1872,11 +1875,26 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
> 		return err;
> 	}
>
>+	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
>+		struct pwrseq_desc *pwrseq;
>+
>+		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
>+		if (IS_ERR(pwrseq))
>+			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
>+					     "failed to get pwrseq\n");
>+
>+		nxpdev->pwrseq = pwrseq;
>+		err = pwrseq_power_on(pwrseq);
>+		if (err)
>+			goto err_pwrseq_put;
>+	}
>+
> 	/* Initialize and register HCI device */
> 	hdev = hci_alloc_dev();
> 	if (!hdev) {
> 		dev_err(&serdev->dev, "Can't allocate HCI device\n");
>-		return -ENOMEM;
>+		err = -ENOMEM;
>+		goto err_pwrseq_put;
> 	}
>
> 	reset_control_deassert(nxpdev->pdn);
>@@ -1907,13 +1925,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
> 	if (bacmp(&ba, BDADDR_ANY))
> 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
>
>-	if (hci_register_dev(hdev) < 0) {
>+	err = hci_register_dev(hdev);
>+	if (err < 0) {
> 		dev_err(&serdev->dev, "Can't register HCI device\n");
> 		goto probe_fail;
> 	}
>
>-	if (ps_setup(hdev))
>+	if (ps_setup(hdev)) {
>+		err = -ENODEV;
> 		goto probe_fail_unregister;
>+	}
>
> 	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
> 			   nxp_coredump_notify);
>@@ -1925,7 +1946,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
> probe_fail:
> 	reset_control_assert(nxpdev->pdn);
> 	hci_free_dev(hdev);
>-	return -ENODEV;
>+err_pwrseq_put:
>+	if (nxpdev->pwrseq)
>+		pwrseq_put(nxpdev->pwrseq);
>+	return err;
> }
>
> static void nxp_serdev_remove(struct serdev_device *serdev)
>@@ -1952,6 +1976,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
> 	ps_cleanup(nxpdev);
> 	hci_unregister_dev(hdev);
> 	reset_control_assert(nxpdev->pdn);
>+	if (nxpdev->pwrseq)
>+		pwrseq_put(nxpdev->pwrseq);
> 	hci_free_dev(hdev);
> }
>
>
>base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
>-- 
>2.50.1
>
