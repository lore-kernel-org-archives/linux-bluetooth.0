Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD839E185;
	Tue, 21 Jul 2026 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784602971; cv=fail; b=FXd+POy9JWeAoDQcDlsuLn7+YI7gmjMJS2viDhTvxdZuYhUZGJrkFjFZ0ohkb/Yv3PdeCBQPpIxy3zh7Nsd1+6XiSSmnkNvxZsUP4T2HVpplDlNVQ6CMoV4eMGbYn4Bsfn2DUwQOFu/V1Rjxo44X60tK/M5JDYIC5riojl8Kz18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784602971; c=relaxed/simple;
	bh=Vk0cgX7r/uxjdRY5f8X+T5F3CFvuifRyUiYNaAQylAI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W++OJZU+Dmy6J4rplKZVyMdsA4U6r/uAPVugBpHt/afJdVqK7tDxdAmr0qD2hJHfUfJio6u4PdoosNUXHvJOo3xlRgRIbPFbBq7H+5hD5jvqOEhrynNyKguy5lScLa2s5GbxQIXJbcgCOebvFxas4fzHqPzB3kTEoUeAmQ79KKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iDK6QMKC; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iDK6QMKC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYH3+jx9Ev6/tOhHH03iAe9cqtO+YJUIqKYHp/rnEFaG4Uas87e9wq87gQQ2SD4J5t1MGJDylpUjKSMesU/7Fi4kWby/kTvNheWlA7IGJzD0eE7581WFwLazoR0jz/cc1nz1GSjah8caUTFOhL/KepnP5G/4JCvGlQDTVBlg8mnPIDnzTi/tCSFeQzTu+oNs6v+2y5bjL+bvxuGGNesFLm1hC/ajD3HcxkJQ7uLlUKnI8QmwCUJXy1o+rDLqSmHHqkM5MogHq4YMLLj8F9nLoZpVlOc8wn7lE+EMy11owxvtWc7J1e1mvkfeGFxfupDM4vCbZbwJBeSNFbYaltzPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8+GFQCCbiV5xTj+YfSBUXsWXbhmG6HMZEUdit3JUCo=;
 b=wK1PfgRbtIo1xHDVYyluY7N9Ik0yM8+dkwWmbz0jxIQlriYM9pwNjS/6QMwhVeRyvz3wyOMtiEpibW3j0fKRDDqMEuHuB+dYGY8KunVtlqDFqxC+BMKdI9COHLVC2iE9hBTImIJT+gBsjdi8PmVCOaM+TBGhzq2u8Q2NgavpuxD4RaRGMJv9vb9dcBW27Q8n9xaP+3cdav62Hv6jMQJdHF92xV9MNLqGtllh/F0mVHgkA/gl3ptSGJebiacH1fHfMhAFqb5y2lkOQ4XCMw+/CReylT7S9tfksSLoEnLUHpnR3kk2YFAMx4SitOtp+72F2ewT7xnBH+FFCUobR0CfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8+GFQCCbiV5xTj+YfSBUXsWXbhmG6HMZEUdit3JUCo=;
 b=iDK6QMKCRvv3nUPgbCyFA3kzY+L+1txv0kixiKxSsLhtZyOKjhSQFnUsg9ZGb75lPEGpj0fLU2rwyB1vlS/9OVsrcO+4cXZCC7nqq5oTEiN9gtFSxXkUBEQnQOBHWcXJ7Y9+qyDuWQQw4WUfhnHwA3Fu8maq/d760fuLEEMF1o2o7BkdV40Z8JZPeS7m7qRn2TnFXoAifIpQFbFC38BFMjD/R0vlkVRfnlZW6hDhgTLK8tVhKryNGar/W9LuqEBHrFuZxQ1WU4pT/PhUWjtCTLWjW7C5DkwSz/a2R3tnrg9F7PNpy4ByPsmMXER6C985TvL2k20lMuLZXq8gdRoIdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GVXPR04MB9802.eurprd04.prod.outlook.com (2603:10a6:150:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 03:02:46 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 03:02:46 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V7] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
Date: Tue, 21 Jul 2026 11:04:58 +0800
Message-ID: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:4:297::18) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GVXPR04MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d084ee9-c834-4b38-1330-08dee6d48a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|376014|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZniDdcA9ft6jOdEJl+6dVUa6Cq2ITokoVbCa/BOpaZO4m/jInoQx1kaK8ZIQc1aq+o0Y8nKfvWQtdMgx9ajJi+VOqxi2c0Of8SUopiajtzaYqZS7FIKv42qeuvJ5lVXbj16zFwv4/SFBGHzlnCVutFSUxB2Xf5/v+v7gDq/FpN1ZjMVS4Icr3dRB+qSmWpadB54+u07/1zvZZComep9VHppxf+yOf18y873sb1HuQGmC5tx/eDjjyGCG8338/6O3UM6zw65kLMsjNsGLpHgz1HipwK6l6FoKW+ylCx8l9qWV6kZ+z3bwKcs33AZiXYG6ZsWFToUByk2tzgyOhWYWbHK/o66dKeLZVo00ZdIKGm2Ha8oJoaC4ckvWDk0FyqyCr/PVvJdholWRWwR+3Lp4no7BoOS7pWYg/NWr6orlAlr07XdHX9FkH08L4+jvLIFnkFgcgnf9lUsxEmU0aXu17nDtLz1NgeVpjxOipgHlA91bfmGklF1BKlt89kvIKnk8e/oSGfid0cDzLw1BrMoaaS3aT2IEAA54u7OYKFnlN5SkjQ6V5el7oMexRQYLpq6p7bdDsh7wP3XU0ITUDshJ/jeMI3PAYuwHK61k1B2PA4XwSNKldZqdgLRAct/yFoNScajFYHXAmrzEcZnRMJH3p7Y6NLVz7qKmkvCgoTo7KxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbjviioE/J8a4foB0TXMfpdO/fym6LFIk4Cq4sNc+yGxApdJADbBHHxQbfRJ?=
 =?us-ascii?Q?EQ49E8DfiPQuz7MyKEjrJkWQdmrEcXXAe18wuwU1s+nzvi6ObMwfYkXVYhwP?=
 =?us-ascii?Q?BVzOIXrJRLJ74GChQzRMnmGwdZPk/K89anSf8C6zk9qObAJYAwDpZl/V7aHA?=
 =?us-ascii?Q?2OgtqjmQ09Y8/Mg8eqczKIzI59j5Bx7GZYuCLPWechTteKhob2WhfIV57N2F?=
 =?us-ascii?Q?x0V0pI7rCH3rbsjP0VkFFD/cpjPTccYh2uf1YbGNbATJKvcs35DDyPotiind?=
 =?us-ascii?Q?nv8yMV6fCPZ2xTdJI/cmWR2/XhzAdaS50NpKmophIGutnGa/HtPAxGGFhjLg?=
 =?us-ascii?Q?D/Sm2S3qGzxFrUEZ6DQGywFEwhIVyXHlB8KQdQnPw9r1JrAPt728MD+Od4DU?=
 =?us-ascii?Q?ZXV3pbovJi1qNUR1jb5+gRLTt6OPs2l8KGas0uSBuJ/9/dnijGxoOgHzkWI3?=
 =?us-ascii?Q?B5Q9IlHRmWLCI3/q79//hWIj/O0kUMyE8Spe31KF/dztC3AOdiFcDMG8ICma?=
 =?us-ascii?Q?l/ZzostVaeb20dDgHNdNMOWN0ljxkz8RWENv208bovZzok/OqRXHIbEQF3Q/?=
 =?us-ascii?Q?I1wRH5E5Xp3TMtBwQQLVAL5w+z2suZk+3V1No1sCW6HWsbxIsDbFeSHGyIo4?=
 =?us-ascii?Q?SlR742ew1dWLjbEVW7A1NyC3CeqqdOGzfv2p2O9BF1VLv0JMb2cZed6ubN20?=
 =?us-ascii?Q?/NoC3BP3EAPY1XKGcaiHZxEkKawYred+mkqoIrIdkUKL8jmQ9hKcvd2i2Sa+?=
 =?us-ascii?Q?HnrbCoXkmfckNl+oyrFjPguYaNwHqm3/qj+8yG6ttCNxihG39y2x/O5IhI/i?=
 =?us-ascii?Q?Dkg8OaFqZKsP20BTv6W1hd2HS0zK5bnK3vQU0vGAuda/EldtQVyTa49pdqOr?=
 =?us-ascii?Q?MsEcTvIxi/SHY3Wft27jPZjxDNuWBALUayBVnff5ULDCW6dojawjAR/v1biz?=
 =?us-ascii?Q?Cv/NJbx15ygwmx3hSGt5g9IzXFp1ZmlQ6EkKE1/PL8RKP8OzjaKkLXd1ZI9h?=
 =?us-ascii?Q?2c322+3C7fobcAWoMYNRurJKkwhInrx8x9sGvRq5t/uhtbfaWV57Syxkvu6p?=
 =?us-ascii?Q?ckZTIzo+6fgYwZIQk7lqgkpj9kd6noIuFH4hFWpQElXjQmdrbXO/3/ap9BZo?=
 =?us-ascii?Q?9d6QT/uBErV2DIjfPEOLVurTxYF1SNZInv7th4OSdqdcUT2jkYDC2fjEIm96?=
 =?us-ascii?Q?zKwEWXPUlcQo16XATuHVZAPAixD1fjBZVqE7DW5cGldFcKiEe966XT4Qa9t+?=
 =?us-ascii?Q?U+zgAzcLirJsazAKzmNTVSiR3ILqvAEVHrPgPwAn8dLCrjAS/R/ClatVN82I?=
 =?us-ascii?Q?WbpEXczd0f9z8BGTkD/ajAAU/WFmoYhmyVSh+eKPwtKD/wroUfmGLBsHngVB?=
 =?us-ascii?Q?PplRF/8Eolm+ozIBjjPvbqKBRnrWCSzjgAAgH8UMnDuOdB/1oR/7gyjdL5P9?=
 =?us-ascii?Q?sMi0vKME/OMnubxUzu4jKvaDi7B1ENJusywVaC1lpnpupAxqsLPBmdG4BVsz?=
 =?us-ascii?Q?BpXJ2hgG660y6qA01DeOZwlt1tfQCUH9/EuA++JZUy65gU0dzl/8KTMGvK+j?=
 =?us-ascii?Q?51iph0R019SRKv6Ga2G/vfM7NrvQMI9Ct3yDQg1qcXCbxghpce3rPGAk86df?=
 =?us-ascii?Q?/rE0Hl/p8ta9myyj8X+ahuU4tKTQ/iDnz5/chy++8sYQQfzsnX0M5IQglT3s?=
 =?us-ascii?Q?ItYLMi8RAlWt4zldHU9PoSP4R/G3UCwn/21zobWWOUinzgj8gqXbYbN4qoBV?=
 =?us-ascii?Q?Z5ZGh9FcEvsu0/YTmZHW0EJuAGNIgSx/5+6W9jEb2jDGUwPPE39U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d084ee9-c834-4b38-1330-08dee6d48a14
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 03:02:46.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pktBCk6qFDMDt1cYKK6zKdHu0gfYcTX7ew26v5bEt2Ms91FUmUQalE2H54ShaOxDTFxEazOuDZySLnOagne4NOMOLLuKL1z0XB/qK4BByaQ+tQvFBRWRNpJhRUm8Z6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9802

From: Sherry Sun <sherry.sun@nxp.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support
for getting the pwrseq device if the OF graph link is present.

Once obtained, pwrseq_power_on() is called to power up the M.2 Bluetooth
card. The power sequencer descriptor is obtained via pwrseq_get() with
the UART controller device (serdev->ctrl->dev), since the OF graph
link is defined on the UART controller node.

Also add the explicit pwrseq_put() call in all exit paths, pwrseq_put()
already calls pwrseq_power_off() internally, so no separate
pwrseq_power_off() call is needed.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes in V7:
1. Seperate this Bluetooth patch from the V6 M.2 patch set so that it
can be applied directly to bluetooth-next tree, no code change.
https://lore.kernel.org/all/20260713023435.235765-1-sherry.sun@oss.nxp.com/
---
 drivers/bluetooth/btnxpuart.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0bb300eef157..81a11ac05114 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -9,6 +9,8 @@
 
 #include <linux/serdev.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/skbuff.h>
 #include <linux/unaligned.h>
 #include <linux/firmware.h>
@@ -211,6 +213,7 @@ struct btnxpuart_dev {
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
+	struct pwrseq_desc *pwrseq;
 	struct reset_control *pdn;
 	struct hci_uart hu;
 };
@@ -1872,11 +1875,26 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
+	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+		struct pwrseq_desc *pwrseq;
+
+		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
+		if (IS_ERR(pwrseq))
+			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
+					     "failed to get pwrseq\n");
+
+		nxpdev->pwrseq = pwrseq;
+		err = pwrseq_power_on(pwrseq);
+		if (err)
+			goto err_pwrseq_put;
+	}
+
 	/* Initialize and register HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		dev_err(&serdev->dev, "Can't allocate HCI device\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_pwrseq_put;
 	}
 
 	reset_control_deassert(nxpdev->pdn);
@@ -1907,13 +1925,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (bacmp(&ba, BDADDR_ANY))
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
 
-	if (hci_register_dev(hdev) < 0) {
+	err = hci_register_dev(hdev);
+	if (err < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
 	}
 
-	if (ps_setup(hdev))
+	if (ps_setup(hdev)) {
+		err = -ENODEV;
 		goto probe_fail_unregister;
+	}
 
 	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
 			   nxp_coredump_notify);
@@ -1925,7 +1946,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 probe_fail:
 	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
-	return -ENODEV;
+err_pwrseq_put:
+	if (nxpdev->pwrseq)
+		pwrseq_put(nxpdev->pwrseq);
+	return err;
 }
 
 static void nxp_serdev_remove(struct serdev_device *serdev)
@@ -1952,6 +1976,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
 	reset_control_assert(nxpdev->pdn);
+	if (nxpdev->pwrseq)
+		pwrseq_put(nxpdev->pwrseq);
 	hci_free_dev(hdev);
 }
 

base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
-- 
2.50.1

