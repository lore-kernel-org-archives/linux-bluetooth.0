Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4B3161B7;
	Tue, 13 Jan 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290424; cv=fail; b=HrRBNl/CDo8ag4GATlvYZqd5MJr6cHAPH9mnDbxZPcIOxkGUaiDUU8i01WnYJrS7pDLuoBkE/F7d7PHS0VPdOumaR8DTIYZXAfG+0Az5oFqD/M67nz0wfLFXVachmBD3ADX4CuyebDOanFegb+GRk1G09VZe8sbJc3LRJpJ2v9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290424; c=relaxed/simple;
	bh=StiBQANQU7vt8NOjtin5XGV1VnO960B2HpkkBwalbpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJEQ+Zmat6jvWkqqxn8em6NoULOnZTkAgch+MolfC/X/OaYhqgUe7w04OltdQVP4sC9sp7aSnKna5KWA2er+NDqH4CoYgxrrLEb4erLpL1SHBfGlQMLE+Bc69LMkT6MC09WUfsopuo7KK2EpVbhKGmyFapwFeQXwMMvM7WU4a/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fLzrOGuC; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fLzrOGuC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2eKWqwEQhovN4ZzAboa3UY8u37tf2pX6x6RAxN9qES2onCryLxFUCrAy71J01ybgHrsAoOste5S1Ll1CQWXv36XjDiC3vPuxMnkZyUZXQ7NaxxwU/yUCFzrIybVvirE2XAPxpvZJZV92Z5ndD8UAQRZo7nO49Og+ByvftRtTx+WQeF8kY6y5i5beYqjRN8sJFRfIkYELt+XBvy1MvbApuJx2MY8UcK1iiFc3+/5Q/kXXyFpvGV/j7DLvIEDLZDXBzuAHCuPNcdRMfdjnL04PIQfG7Q3NGPji/jFDSUWnlwDUHjlu1MCDDwx4LUDnzNWyc/cD4WWPM2coLR0oka0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1No6gPYUtemE3JSRUj6BRQbpjTe4PtRmpJnpoptkxBM=;
 b=Mbpf3NNSu9NcI9nti5pv7O+sYjq58zJqWIWI9g/0K2O/GXu4r1l3Hm+UGM9cgoUnwIXjEEpSTYemfXgWWoMQOOCTTcQCfCEpp+/v4haTddpRXyxbOlaqgEIgCTM9nYnmedfvHCI/sQhhT80c1AU+bm2QcX/bJg8Yybzk1LYTBRf3oistafcwP2Wg5Jk+TFYTEkCKSDPtE3KxnpFjCMK/nnJxi/1L/JZsTS8pgWjyFp+CQ6Tvup5vrvDVuL9XUKYQ8E1C958aYGpFSlswCm07NKohlWOMk2VjxMwG3BDlYZFIx0kehBb5OEP5l1y4NVp5HzYdv1lpOETAI6nfVqeGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1No6gPYUtemE3JSRUj6BRQbpjTe4PtRmpJnpoptkxBM=;
 b=fLzrOGuCjksoy6rRTs+qBbgCmVp27EBxNnxMDf3a8bVafz6SeJmUxmmFRKlmQi367gPaDfAEfPC1Oy0k4HFZKFLsKTkagXvUGNLGZY/zxCE+3M7I1ocxwAx9oUcqIOc0fmoRV6wxWNmaf2s7soUV3h6q1ygbR0LupNzAiEbHMnARaIIHYwl45rw4nRa+uH0sA9xSNfNQWohIX6SVeqP/lkYHuoSXsTOiDAhPV/JohTvNpwcXVVJQzB0z+VdRYpl/9Ppq5+VkTiV9M1F5z+PXa/QoAysRrsQZL3D8xIFzcyUel2b5xoFxM1C3KEIueK1ngufZymzgtSisxetDJhw02w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:46:57 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:46:57 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] Bluetooth: btnxpuart: Implement TLS authentication crypto framework
Date: Tue, 13 Jan 2026 13:17:11 +0530
Message-ID: <20260113074718.2384043-5-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 060edcf8-ac43-4376-ddeb-08de5277ed7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EuQ99pwJAqgNIBFlo3SKo0WxcrC89BD33OhzX+nazOWU+y0lU7rvkk82q0QI?=
 =?us-ascii?Q?QbGBjhrvx++TJaz/p1V+2UC+Y7tX2uLkz2LHozX/yEFnfhZnsnDqW4HO5Jgr?=
 =?us-ascii?Q?vcOrQM4cB9OKVyrlmuXA1w1AKqnHsyWLARGqmMlkBmdVPCmaoAWMxqREPx77?=
 =?us-ascii?Q?q0BSzwNrVEVmLzgQNmx67Ot6wK1Bb7v1ShKEjw0pj59/VN0xMTGKCPwqtxvH?=
 =?us-ascii?Q?mxNvUnf/vFTooSwN9zWYfrl6yqhLvLr9IgznZh5haNPhGOH9IVTJWM6DHrle?=
 =?us-ascii?Q?kUbMXYj6dnK/APavnpj7suuFepFzVjXbw61NSFNYoQ/igkAw84R/85rVNKqj?=
 =?us-ascii?Q?0gm5eTGi8qqA1I2seB36lkqRF9Y9LsfecZy1//g147ljBxJ3oSx/ZQgM/p+W?=
 =?us-ascii?Q?kVR5+b7WLmYVoOF0oCR4YUsc2a6Po/ckHMO4cPKgPIzCP4CScLKFVb2vPl2M?=
 =?us-ascii?Q?r0fKBotHVzc59qEyguOqeO7WGMZKbSDvOtYPNEOpu89Rdhu40SWcFJLSFacr?=
 =?us-ascii?Q?6QGDo8exI7NbO/t8YKvxMg6d/XmWXVH02CKnteyMBxIy6PUdzjiWs53jkCXM?=
 =?us-ascii?Q?sfx9R0rMLN0RHipYjFe+N2zxheIDgFs4ku6Wlff0q4dtPzTX7rPyNbGuVHAE?=
 =?us-ascii?Q?yVwUVo8q8hm5ETj9AKFGB5AzQXq2Rj+Ukms5FvSTDKzVKgMdTEk2u421hIxA?=
 =?us-ascii?Q?FhGnsssB+vmw0H/ZE8Kvsazk3DXsf4wQIkmW/sxDHUN+IgdxW7kpA5WOIKHf?=
 =?us-ascii?Q?POjkc+ZBlVlzSMgmfbs7/J42vz2XJx/KP7pH6Y7/t0XIpqzQzy4l07fmjPF5?=
 =?us-ascii?Q?Y36xkJ02uviJPZFlhN+5TnIxRBJ+KduuGU8y2pIlMX63eRc0nsEs/GSDRAo2?=
 =?us-ascii?Q?UGgeIdbQxXh74KJJZOS95IcUA00JYSnsPJh0My7oGYGR6I3DbhNKFCZ4nfm3?=
 =?us-ascii?Q?83He8IxVFFzTipn9wccJyiSZBatapRyPKwuPgFLJHCZ+Hsk5odC6ip9OkGK2?=
 =?us-ascii?Q?weL2zutJoKrdgdfXhJZERSkLJZmeQ3IPERR1f1K0quaLOwDniOMcgDjbdPCp?=
 =?us-ascii?Q?uBRLU7DHRTsxqC36lcMBpA/3Vxe/BSXQGOKU8qM31IocmO3KmH+p2qLxNZRv?=
 =?us-ascii?Q?uWZUzKhbd+aY4oRUYUQOWiust0yeDb5i8op/DxB+8+e8bGLD1JUvI5PLlxK5?=
 =?us-ascii?Q?ogbpU6E1RfZqRWlIv+JMu4jwrF5d6Np/Drst3VrhDqaugADIz2CEeODnQRID?=
 =?us-ascii?Q?fWRIiiFki07tYs8WprUSyQcKp1EZD1KWpSWRCKDA05LHFk1sZj4jjlKxMmB4?=
 =?us-ascii?Q?8cLyayFhaQHNnmaha6IYNIVnUlQuNCipvw4dsHVKmo7NetYA7TTNAgEIejEc?=
 =?us-ascii?Q?4j3FoULwcDmlQq/u/paUaITj/aN8B1lCxxhR5Ck+Gfej2QzyTaSqlO65MXap?=
 =?us-ascii?Q?ahYElBcVYUPVT4O1iQ59k5pH9Nisa+Jvn/ebLIPF6MVfb57eFhjbpKsrJ7Yh?=
 =?us-ascii?Q?qIyWxVvsa0n6zzX/DhM0uJ4hG03TDwFvDzAs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ql/zd35YP8mmOtUjnPyNv/yycVDMImfeZyLs6PbM8cgoYX6ZAONVj8D8x8HI?=
 =?us-ascii?Q?b73+cZxhty3f33VQeVhPNqBJ2N2nqpMI2z7Kub6RRgOam0X/kHvAcT+Wec6q?=
 =?us-ascii?Q?BJ4gZuICVQxhEhdS4B2jnC/gclBU42b2DIa2K3GXPTcU9cSjFBe4nUmhPUN/?=
 =?us-ascii?Q?KSQpa34aURsQTVBbOt+MKQbhKG29nvX3/sgT8o16RdlsvoPfFmxUFU6KI7Eq?=
 =?us-ascii?Q?SUA0zmsKSFuG1FtE4Rq3JzQ37Ij4ZNOixJ47g8VvlKpzxnU/2hkLjFElqBL1?=
 =?us-ascii?Q?oo5skcupJNqD7Qqmzp8RE6aA3KdIH1TQqvUbjQ5mrxvSDHHTvGf2MQGVB5TT?=
 =?us-ascii?Q?ePf1ytzOu1rvgHIzcYG63jQtsdL24ue/6T981svaiRuzPTFPECySKJKEaQxx?=
 =?us-ascii?Q?gc0ZZGpt0TJYX8VoiGcb14A8KEzQt7dtQsg7uX623cToK08CbApnaIhRg5/7?=
 =?us-ascii?Q?WAr+Tm4t3qiDFwv8x+ZTDO0cW2bv2kHXptutEbj9NxUX5F912ZOw+1coIrnP?=
 =?us-ascii?Q?Ixk2plz9xdAnx8Jv0daF7YYJikr8lCz6At+TA2b7mFMFRHNuDupfjuxefcJD?=
 =?us-ascii?Q?SJ2wHsF3TU0+Id04gZ4cig5k/wIvPy//lNfGMRvvCDF+hd15zk6EyOCJWzuU?=
 =?us-ascii?Q?5p6pJyrx82E5MxeunXSqsKTq5YsdVqhcSjoKKkARBRqt2uUoV5oIRLNVGLpZ?=
 =?us-ascii?Q?GPo/fmf5EoH0Efhtc2AqC+AcTlYB0q7/Dqby8BHLGshp6e7FUY8jwX/3Ktg2?=
 =?us-ascii?Q?48mMhokgHg9YjR6PmzbSAcLhyHNYVQ4/fmBMvMh09T9xKojL2cH62UH49+0k?=
 =?us-ascii?Q?Sk5P7ezgjrfWmYtj1/omehNNRosjXGhnVNoQEnLPp/o68MuqBN/9e+JkeREI?=
 =?us-ascii?Q?KT/CLjAzQDarCrOlHBygycdh/Lwz+f6v79f0vIUQFkYER8gjOENyoHQlUwgJ?=
 =?us-ascii?Q?RD989w7Ad/9hFs6vwovwI+Ze2c2szeVk+SY7XOb+loY9Ry57gf0RQSeN8eAY?=
 =?us-ascii?Q?hGkKJRJILoU5Pi4Jz8zFSmudVMmogQNUiHzaXB+EXvGSO/DvBwkQrct3QO4T?=
 =?us-ascii?Q?vQ3gZK/TzOUJLu4VbekzMqeTBBYOdsa6KvhGxV80b1gL6ecwLdx1aolPZZ1Z?=
 =?us-ascii?Q?D9TstvsumpKcAYmsZ7CTSabFFKzXkHhL+hUbhQq3aCr1hNt1AW0LKQ9kWRZY?=
 =?us-ascii?Q?2Lf7l64zhwE4FXekUVva5AeuNEr/hkeJqCy/0+/lUoQ1iUNiwxq8WgU2MjQ/?=
 =?us-ascii?Q?7qXCpPYojPOYU//Qe32LKe8e/XU22imNeBfHBgwUBHJdalWpwFGtDF9dIA9/?=
 =?us-ascii?Q?XTcrHtvD/2l2qFXq/7T5Trw8N5MowEt1c7TmEDxVp0l9IdLP+8hxm1odK18U?=
 =?us-ascii?Q?Qbe+UmY6VSLIh9MPhjKS3ZMByFqTRAufjfHS1h6xkG+Gv2cefuDAloueuppf?=
 =?us-ascii?Q?Vdix48daAwIDCyAuX4YeYxGCnSqyNEmi57Hu6bfqqbJqljeAtqnsDZ1bIA40?=
 =?us-ascii?Q?RP2uVRnOAjDVQRo+b98DQNE7/NUyzSWLY+5M4tbShnZTioSIFGPkHMeyOTXF?=
 =?us-ascii?Q?1BvHO36AzQDEo0Ms8J00tuEkeYItMWSTKlaE76346d3QszVgAcPRMeVV5nYw?=
 =?us-ascii?Q?CympgTtf5rtij0le8rryZyuvUe2A7oa/WVkbc8QrwDp7C1XGgMODo4aCXeH6?=
 =?us-ascii?Q?w0C0UdVxEeKr7CZx6eFZCBHoUbxDDOc+kOIAbt27sGNI/DkDo270e5Tzlmfy?=
 =?us-ascii?Q?lK/sUaauHX9aVwXtgXVmZZB9r+iS/Hk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060edcf8-ac43-4376-ddeb-08de5277ed7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:46:57.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMuLCPmTlNmUhMIeo0j2LCSS5UmAu4FwcnlTW/xdkjJ2aihTDoeFc+wOZ8YEELJX467Oi8REDooLBpX3yFtV72qJWKuPm8zXVKNK0I8AWC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This adds nxp_authenticate_device() function that sets up cryptographic
resources for TLS handshake authentication. Allocates SHA256 hash and
ECDH-P256 key exchange with proper cleanup after handshake completion
to maintain only traffic keys.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 48 ++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3455460d30f5..7c94d8ab94f3 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -22,6 +22,11 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <linux/crypto.h>
+#include <crypto/sha2.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -192,6 +197,9 @@ enum bootloader_param_change {
 };
 
 struct btnxpuart_crypto {
+	struct crypto_shash *tls_handshake_hash_tfm;
+	struct shash_desc *tls_handshake_hash_desc;
+	struct crypto_kpp *kpp;
 	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
 };
@@ -1602,16 +1610,48 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	size_t desc_size = 0;
 	int ret = 0;
 
+	nxpdev->crypto.tls_handshake_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(nxpdev->crypto.tls_handshake_hash_tfm))
+		return PTR_ERR(nxpdev->crypto.tls_handshake_hash_tfm);
+
+	desc_size = sizeof(struct shash_desc) +
+		    crypto_shash_descsize(nxpdev->crypto.tls_handshake_hash_tfm);
+	nxpdev->crypto.tls_handshake_hash_desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!nxpdev->crypto.tls_handshake_hash_desc) {
+		ret = -ENOMEM;
+		goto free_tfm;
+	}
+
+	nxpdev->crypto.kpp = crypto_alloc_kpp("ecdh-nist-p256", 0, 0);
+	if (IS_ERR(nxpdev->crypto.kpp)) {
+		ret = PTR_ERR(nxpdev->crypto.kpp);
+		goto free_desc;
+	}
+
+	nxpdev->crypto.tls_handshake_hash_desc->tfm = nxpdev->crypto.tls_handshake_hash_tfm;
+	crypto_shash_init(nxpdev->crypto.tls_handshake_hash_desc);
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Crypto allocation (SHA256, ECDH-P256)
-	 * 2. Host/Device hello message exchange
-	 * 3. Master secret and traffic key derivation
-	 * 4. Proper error handling and cleanup
+	 * 1. Host/Device hello message exchange
+	 * 2. Master secret and traffic key derivation
 	 */
 
+free_kpp:
+	crypto_free_kpp(nxpdev->crypto.kpp);
+	nxpdev->crypto.kpp = NULL;
+free_desc:
+	kfree(nxpdev->crypto.tls_handshake_hash_desc);
+	nxpdev->crypto.tls_handshake_hash_desc = NULL;
+free_tfm:
+	crypto_free_shash(nxpdev->crypto.tls_handshake_hash_tfm);
+	nxpdev->crypto.tls_handshake_hash_tfm = NULL;
+	if (ret)
+		bt_dev_err(hdev, "Device Authentication failed: %d", ret);
+
 	return ret;
 }
 
-- 
2.43.0

