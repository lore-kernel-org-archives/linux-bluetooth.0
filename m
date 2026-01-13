Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF722FC89C;
	Tue, 13 Jan 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290418; cv=fail; b=CUHDx3v9V300p12O06IZSc7rmtx9TJzKJCku7+AYxNiblwNAUEKoV9X+CHsd5EHN7QOdyAc04UeTeYGdOZjPvPyB13YIAlJ/+nNHJM+6QDTanMpmfadqOgHYMnl/dvydJ9qWxSakdbCddchDJXWw0mPhLxRGyQ2juzNA9sKgwHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290418; c=relaxed/simple;
	bh=EZo63DR0TPzM0/AImPfULgdxPzyS+J1tS61nsVGKXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9mWMepYVbv1dR0rgmgz8khGehLRHXo6Lep2gkFzk/pclV5ZSAcNQPiRXdOzYfnVlu/tEx7tG/CaCutUmZX4o6ohPHhw5pfmNlV5kddDQmVTTO6RB8t/S/nLx3++S+YX7DpGJ9+KtZGhjatmNWbDQZ3kmBoY4GPMjzAMJRWd8UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fuOZn9GX; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fuOZn9GX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaqHkRHedaxc+xJs1VoKNdpKVL2lbjx9rGaNq9jofuwrnF5FHkYak/uEl5miJiCQicbEvb06MegM0//wACCnyrcju/Zv05CSJKgG2QGnemdwHI78i4D2zCYo6MGtvmO6T2afYwzhxs9FIuTBx0zROF4BdycZVvRANO9MNQfdq20jEfnNrS6SlcjDVdkxRjHxptZx2wHdseQG/L9vNYZkNqAJbt42p0a15wSjH4sZ0qRHVc4plb8EN9AFLZgNmgpEZRGOBrRRP004P9G8rBluakH0Ik2JU+IExVT+ZCX5FV7yfdi6nvnLvK3JZ5X6HCsKD1OpAIc/QcUFDUocAdKzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyLSli6q6PvXLMpbs2Zcfbf90mxIIEQkLciE7/+Sr9E=;
 b=eJngRrZ0Ceh/bvWDFpzp7h/I6GigJw+RmpKsZcu1LYDZmNDUbkT1ECWXt85YGum6ab5ushvPyCxmjnSazhrNR3VU0jNSFBkjR9QP9ca//uD4XF7HEMpwi7lWkTWvYa8m/sWRBJXdfuZ82m2A9pMkINpyRSnsOtFqdkfxu3BuOEnyKA4+s41jNoM4qFhaLuh6hBHZW2HQwZOCx/cFNitIokFJUiJsnMhZK1TVglorkKhiQJAck5CmU9av03qWhsCmyRr7/QWGY8dmh1FoP1M6p4TOB1T7w2+1UEsQlmYB4LrYtghpeY1Sp2NJEF5vVeYT0hPOgVAWWaV3j1C2JgGNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyLSli6q6PvXLMpbs2Zcfbf90mxIIEQkLciE7/+Sr9E=;
 b=fuOZn9GXDWA3RkWBjFbcNcGulDuIuqDhbNO36B5QrbjNknSxY+ulcqqpxVRdWGeqVZDWIvpCX+FFAbmCWspPJ2Bf69LRojuxutQRACODhsk8yDv7APiPzXFShdTv5Ie2jGwr5hZAYAVIkVq3kgO1jCO5EX/TW2pBfcFLvgNbkOy8B8wwyzty/UynYW58oA4bzKJhaFy/Q+EHSkVDlRVxzRA5Rb/7uCMMyaZ46CMK670PIisc13av37/v59N8naUHUOvSU905/sMh2o3Mpv7ycikpz1znICBhcKz1H2ezSZqjJs7fN9HhvuwZI3JfwCi/mr5dRayjZSFm8sCNJq7K8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:46:51 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:46:51 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] Bluetooth: btnxpuart: Add firmware metadata parsing for secure interface
Date: Tue, 13 Jan 2026 13:17:08 +0530
Message-ID: <20260113074718.2384043-2-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac9cd179-8660-445a-46b2-08de5277e9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLDBChiT2i7rHdMQyeYON35uJm/5sYNkUwYejqgMXa2HFbeKtkU7ZA3dfg0M?=
 =?us-ascii?Q?eJbByvhctIL7bmmGiZxK5JAkQGUnz5pGvMiIUCULsGQZHHD4Vn/Dfaw8u10K?=
 =?us-ascii?Q?FX4JHkC4Gq2UoHxFiDNeE+QKhR+afdoTQDe+W5feiZNAIl5aWkorRGCY+77T?=
 =?us-ascii?Q?10snEIJZaUfdN0w6cfcwDnnl7PfgoJ8UfvuI/Xsfn0mutjEN3LiLHct9bpJi?=
 =?us-ascii?Q?GQu9GpcjS0nLiVJT8tyYk2QZmrIZ3E2z3xuN446q6Drk9mCR/LhJT8nYqri2?=
 =?us-ascii?Q?PQiVFQuPsAxfuhZEF0RM8HhPiJyKudUd5PT4pTBRQZvUpgj0+UCAC9UQHqa+?=
 =?us-ascii?Q?Y3qBti7DWbSFyPlC6wNv0jWCSPOORZsIAeFDFX6zDxuHYIF2dMv6EKjjUQz7?=
 =?us-ascii?Q?pE8cl6kQUt5popyxqOe1on/BiW8oTJnLCWC8cS1Tmyff97fF46r78g5zzTK+?=
 =?us-ascii?Q?3j2qVB9ic9vUzOm/Qtt3X1sXWZXtaBsAOV9+5RtdmJnmDPreSXC1zF4VJysS?=
 =?us-ascii?Q?z3rWjaUH6GVzIMmj23dI/EjZepXOvaTnouzZ853AJbrbJDsE7POohKj0T5tQ?=
 =?us-ascii?Q?5NT52o1USUxIv+6ML8ZMcfduzUFlrEIZpNUoIOvDJTPRoRgoXFeAIKzuJUri?=
 =?us-ascii?Q?U9BhehWvLRc4FlM8A+Eo6fzq4HhW7PGHi/5IVru0xyOcQ4/dfI7Pm1g9aMsm?=
 =?us-ascii?Q?D7vrBertwAIxhfoAwFzG8X0zOSubCj16tI6JlK+312y70qYHp3rytp74bD9L?=
 =?us-ascii?Q?Nh0XwA7NUDEbhfsUUP8Q/0Fzx5McgU0YDG6ChmaJxuz8fSWrrBrornBfdCOB?=
 =?us-ascii?Q?NnU95rQ/BqkvO5/RCCL93UWeGrpguHH5Tnu9rNFXj+TcSh8IyXHTHUWRLrJ3?=
 =?us-ascii?Q?3hN3d6T/FiIyWdXdGyO9TPcoypgCv5Zd1H6KNzTwr1vQORK3NHU0UcstvYYf?=
 =?us-ascii?Q?irtbpyPNpFP9wu8h4RSd4OfBD7vVsDAIwQLv0iLSo1eT2xseRF9rj0jVgmou?=
 =?us-ascii?Q?+tCHz/MekB3F7M8ipN2ppCuQ9n3va1rwNscDxa+11u37mVT90PvH6gjB8dg/?=
 =?us-ascii?Q?jY7M0rxO2q4u1Z9F1KyVJRIcWyy/5N2QRJ+y002FmKmd9R2Af0WIOtpx/nuN?=
 =?us-ascii?Q?D7mstkQmSXb/oZdYg6LiKcMWHzPEAB5NE8yD4Uk0bJEKOpOtpZvyHV9THeWj?=
 =?us-ascii?Q?/Y4fG5GcflXY8EQ6ZiyBphA/bAlSmkt6LdNmfk8QCanklqehrNnUIYpPK01L?=
 =?us-ascii?Q?qcNYCL8fO7a8o60bgjIgF1IOs17vbp7V8qNWNOO2mxu2fAOOB0ANCA+5WrhR?=
 =?us-ascii?Q?eVjjpubkNuHa46wIT1gP+xNUw1ayvCR/kmKE7QZkdsoMxii9S5zrPxBcLZAo?=
 =?us-ascii?Q?ga0NNFnnpFi21TA+OKh/iwHu+mkTDD3r3Se1Y0CraGeSdirUPCFaKWRYW9he?=
 =?us-ascii?Q?oggGg3t6EvHVyzckzqaGt5QxyMXOVnaP1YvlwSdrvzNdfRui8VilVbsSv0Cf?=
 =?us-ascii?Q?JtxLUHRU07jfc8uEYuR8YkLkpfPhiCr2569l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMyzrWn/AzyZuHKoVVX9fsFtKjZq74lKo47IYeGZTV8Hjm0MNljcX/mBea3u?=
 =?us-ascii?Q?ZcROo9VaujlbPMc29r7amLh75KL878GhGF1CmgL7R4gC4mKC6NJ7f3sQX+sY?=
 =?us-ascii?Q?cdcBYTRXxWROjivFDljJ7sz8iJ2uka4ptL/zgOJ6Uc89r/iigVwZq0Xighvf?=
 =?us-ascii?Q?WzIUFwbSer27PsOUB5DtxEt906cjPUdnLYxPMRr8B+jYeBlO0EiEnGkS0Hlo?=
 =?us-ascii?Q?6WBhXzVGb9IrtICKnQauRufnkKbNBrbHHQmG3Rurc/g/JLlwvzF2l98cZsJl?=
 =?us-ascii?Q?0h0fjDzwSq1gYw27I6sxbcThhP0m0grfku0rYuXlbONccyMrjqyOUaQKBf+e?=
 =?us-ascii?Q?vOh+qwLWVtHS9IAALRi0ZseRYroXYKtKJOwhQQIj59NfEOuttx5v/YetzlZS?=
 =?us-ascii?Q?hOvswWORdotj6PfO60DvwlGIY2fsigFMQnIZUvPpYISkZgpQpoke7Tj8lMgH?=
 =?us-ascii?Q?iY/1VmP2UC1nCG3JYbegvv0A4Xy1EXwZGLA+o7/T9axCWeuoD0ERC7oESfME?=
 =?us-ascii?Q?QHJ5u/LprdS9NhxFrMu48Jg0Q7yrhGqLZhUYsIsBJJDL8Z/mvhLorzosCU0q?=
 =?us-ascii?Q?DxF+iQs+wpjK/cnLrh73gYfVb5MI3tMOlPu7gHWLlvpucHR7/hz8G6vVKKwj?=
 =?us-ascii?Q?lE1dZTtMHnWLDcrlzR4/uqzHurWlRfsk+KVqpTBbZDSAXKrkVCibN+QFBWUi?=
 =?us-ascii?Q?WSeG66wO66i5UIm1GpB9kYeQB9BUXUqO/9KQpfmXrMd73MnLvNmO6LMmkeDM?=
 =?us-ascii?Q?lOXJh1gYA5Zu9fAzsHhisX8KJHXtc6PMDvGVTjJD6BIt0hg2a4jKK4c7MA0O?=
 =?us-ascii?Q?YT8XqVTJziqpghFo8m5cGZrAENwt/2e/4nRkYyax5tFiJIOebSWrfrlTAi6I?=
 =?us-ascii?Q?BX/hKjkSgyQtU5+8ayn9ScSWInocX8HO6mBHwQ1L8UmbV8vYBxb7GL7HrPrL?=
 =?us-ascii?Q?n9hzINnJDSxmfrc9dtwnMuU3ghDb+yZ3PweCdeYLhmCiu+dSoP7vHURPcK9/?=
 =?us-ascii?Q?29YTA4YjIKsjA6QQLQa1zkoFr1aEfqYKq888yzCkcFlEDLPR/MjjCTGGqCDc?=
 =?us-ascii?Q?nrM18/2AT74EMMthl2Daf8NU9F/Kzj+Bzxes3gzecf7b7W1PSU7TbnOw7EnL?=
 =?us-ascii?Q?49md0JBWpP9aGCRQcIXJUOMCyX2WUFO8RPsryRjzZ7sEQAHmvGCE8ptqzE27?=
 =?us-ascii?Q?o+rQhUVg5TvesrbI1wsxVPeXIeT1dnnmXB+2LdBL3t/QfqgICthpczqZj9pE?=
 =?us-ascii?Q?y7XH05V1VpuzOLLUZIsfzCCfoo6oh7ATSECiBhlDr/09Z/jE2TI5xenUADF9?=
 =?us-ascii?Q?BAumzAxT8172MV8nms7IuojgUvXK3FXLg1398qRe611t+O3Y3ZgPrGptrxCj?=
 =?us-ascii?Q?kvmx+pcqZjnuWj439mON8rnu2qI2Y9grkijtcVvE1NmWc6LJdDG91mWuWZpD?=
 =?us-ascii?Q?c/7FFFvZyHt4srBxvIV4zcLIMVjXc+ycw3zYegCI9oZxH41HgECFcrSXRKqc?=
 =?us-ascii?Q?eg+w2wdRytnsGlUBoH68XMVnl39P3KfQjWtn/G4mb5FDWHcWk6NLBysWmO9U?=
 =?us-ascii?Q?V24kXDfI2JLmVCaZLLNc+VCPiVhkwcMDP7BAXgR5FYxbBnB/zS/udeE3KOJt?=
 =?us-ascii?Q?YJXkkRjyhGvoTjsWwp9vclWuMGKuRAPiPftW6BHZirLgsHul6qNWYdI/0Xoj?=
 =?us-ascii?Q?inoARcwZxOu19ozFhgPw5Uz6ZjlUtj1dIo5Ip16YMSwrTwd0MJr/CNnM5FjA?=
 =?us-ascii?Q?x8TRpxkYkwzGsrgQ4OQV5mys3kVGTYk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9cd179-8660-445a-46b2-08de5277e9e4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:46:51.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jujm95biIq8P1Yre/N9MamgK/aluMHPH6lXFg0+OrUDQIehTP01Lxy5Df2raHUeHlwZKtlqN+p6iVWDiJ2+HcErlU5o+/R990w/jib9tR7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This adds support for parsing firmware metadata TLVs to extract FW UUID and
ECDSA Public Key from FW metadata for secure interface authentication.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Fix sparse warnings. (kernel test robot)
---
 drivers/bluetooth/btnxpuart.c | 133 ++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3b1e9224e965..78a7651d55d6 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/crc8.h>
 #include <linux/crc32.h>
+#include <linux/math.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
@@ -134,6 +135,14 @@
 #define BT_CTRL_WAKEUP_METHOD_EXT_BREAK 0x04
 #define BT_CTRL_WAKEUP_METHOD_RTS       0x05
 
+/* FW Metadata */
+#define FW_METADATA_TLV_UUID		0x40
+#define FW_METADATA_TLV_ECDSA_KEY	0x50
+#define FW_METADATA_FLAG_BT		0x02
+
+#define NXP_FW_UUID_SIZE           16
+#define NXP_FW_ECDSA_PUBKEY_SIZE   65
+
 struct ps_data {
 	u8    target_ps_mode;	/* ps mode to be set */
 	u8    cur_psmode;	/* current ps_mode */
@@ -180,6 +189,11 @@ enum bootloader_param_change {
 	changed
 };
 
+struct btnxpuart_crypto {
+	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
+	u8 fw_uuid[NXP_FW_UUID_SIZE];
+};
+
 struct btnxpuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -213,6 +227,7 @@ struct btnxpuart_dev {
 	struct btnxpuart_data *nxp_data;
 	struct reset_control *pdn;
 	struct hci_uart hu;
+	struct btnxpuart_crypto crypto;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -362,6 +377,26 @@ union nxp_set_bd_addr_payload {
 	u8 buf[8];
 };
 
+/* FW Meta Data */
+struct fw_metadata_hdr {
+	__le32 cmd;
+	__le32 addr;
+	__le32 len;
+	__le32 crc;
+};
+
+struct fw_metadata_tail {
+	__le32 len;
+	u8 magic[8];
+	__le32 crc;
+};
+
+struct fw_metadata_tlv {
+	__le16 id;
+	__le16 flag;
+	__le32 len;
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -1190,6 +1225,85 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
 	}
 }
 
+static u32 nxp_process_fw_metadata_tlv(struct hci_dev *hdev, char **payload)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct fw_metadata_tlv *tlv = (struct fw_metadata_tlv *)(*payload);
+	u32 ret = sizeof(*tlv) + le32_to_cpu(tlv->len);
+
+	/* Process only BT specific metadata TLVs */
+	if (!(le16_to_cpu(tlv->flag) & FW_METADATA_FLAG_BT))
+		goto align_and_return;
+
+	switch (le16_to_cpu(tlv->id)) {
+	case FW_METADATA_TLV_UUID:
+		if (le32_to_cpu(tlv->len) == NXP_FW_UUID_SIZE)
+			memcpy(nxpdev->crypto.fw_uuid,
+				*payload + sizeof(*tlv), NXP_FW_UUID_SIZE);
+		break;
+	case FW_METADATA_TLV_ECDSA_KEY:
+		if (le32_to_cpu(tlv->len) == NXP_FW_ECDSA_PUBKEY_SIZE)
+			memcpy(nxpdev->crypto.ecdsa_public,
+				*payload + sizeof(*tlv), NXP_FW_ECDSA_PUBKEY_SIZE);
+		break;
+	default:
+		bt_dev_err(hdev, "Unknown metadata TLV ID: 0x%x", le16_to_cpu(tlv->id));
+		break;
+	}
+
+align_and_return:
+	/* Align the pointer to 4 byte structure alignment */
+	ret = round_up(ret, 4);
+	*payload += ret;
+
+	return ret;
+}
+
+static void nxp_process_fw_meta_data(struct hci_dev *hdev, const struct firmware *fw)
+{
+	const char *metamagc = "metamagc";
+	struct fw_metadata_hdr *hdr = NULL;
+	struct fw_metadata_tail *tail;
+	u32 hdr_crc = 0;
+	u32 payload_crc = 0;
+	char *payload;
+	u32 payload_len = 0;
+
+	/* FW metadata should contain at least header and tail */
+	if (fw->size < (sizeof(*hdr) + sizeof(*tail)))
+		return;
+
+	tail = (struct fw_metadata_tail *)&fw->data[fw->size - sizeof(*tail)];
+
+	/* If tail doesn't contain the string "metamagc", this is invalid FW metadata */
+	if (memcmp(metamagc, tail->magic, strlen(metamagc)))
+		return;
+
+	hdr = (struct fw_metadata_hdr *)&fw->data[fw->size -
+						  sizeof(*tail) -
+						  le32_to_cpu(tail->len)];
+
+	/* If metadata header isn't cmd24, this is invalid FW metadata */
+	if (le32_to_cpu(hdr->cmd) != 24)
+		return;
+
+	/* If header CRC doesn't match, this is invalid FW metadata */
+	hdr_crc = crc32_be(0, (u8 *)hdr, offsetof(struct fw_metadata_hdr, crc));
+	if (hdr_crc != le32_to_cpu(hdr->crc))
+		return;
+
+	/* If payload CRC doesn't match, this is invalid FW metadata */
+	payload = (u8 *)hdr  + sizeof(*hdr);
+	payload_crc = crc32_be(0, payload, le32_to_cpu(hdr->len) - 4);
+	if (payload_crc != le32_to_cpu(tail->crc))
+		return;
+
+	payload_len = le32_to_cpu(hdr->len) - sizeof(*tail);
+
+	while (payload_len > sizeof(struct fw_metadata_tlv))
+		payload_len -= nxp_process_fw_metadata_tlv(hdev, &payload);
+}
+
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1248,14 +1362,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		goto free_skb;
 	}
 
-	if (req->len == 0) {
-		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
-			   nxpdev->fw->size);
-		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
-		goto free_skb;
-	}
-
 	offset = __le32_to_cpu(req->offset);
 	if (offset < nxpdev->fw_v3_offset_correction) {
 		/* This scenario should ideally never occur. But if it ever does,
@@ -1267,6 +1373,17 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+
+	if (req->len == 0) {
+		if (nxpdev->fw_dnld_v3_offset < nxpdev->fw->size)
+			nxp_process_fw_meta_data(hdev, nxpdev->fw);
+		bt_dev_info(hdev, "FW Download Complete: %u bytes.",
+			   req->offset - nxpdev->fw_v3_offset_correction);
+		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
+		goto free_skb;
+	}
+
 	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 				nxpdev->fw_dnld_v3_offset, len);
 
-- 
2.43.0

