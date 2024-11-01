Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8119B3E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461908; cv=fail; b=CGT7uLpBrLWIcuA2NKMCYWCIwRG2/1DQPDciAejlu3X+KG3xBPdW1P4gkDtiBfEo/+6mqKVIBZxn6azxCZSPrvCvUzRkt/laGnTdNkZMj6c5jYFxkWaTkR2PyU9DUtyYUzHC1XAW2eR4qadUgap7EymvmlOaisQiBLzi82ceysQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461908; c=relaxed/simple;
	bh=PTmDwFE3ICceuHkmBYO56NuKGvRblDl5n9Dqf3xT72c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojgwi6x4qsAk5vTaOKj6B7wDM3Y+EYbWyBR1zD/77q13UnX95PEGWbimPlDHgodWkVLGnoWg9tfhM3Vd/FYwjI/f2UuEyOVC8mwStUB+mH6MR4TnqAdifYnupZHfKzmg2y62CftMHF7LNRzu5qar8vBt/5OVFSEbaVbTBkbM7DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VVjukn3A; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VVjukn3A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmIcwYz1qo46COBkYmSVwAl1KWi9mmSU80xXcCxetOnEH9DE+NyAf6c341Q421RTVc+c0FRBJ9LCaE5/tdJuxEqzAtbxM8IAtoe6NvBI6DEVyW0kBciE9VhV/hHCY9VHoXxkefwYQZL3Iu//libXOidVYs8+2RgI7ahIRy6VwxcXdPrBM2ULPVO7Jtzpdhx/6IcWROv4KQwudD5bwtT8fVVBDq+Z9YqmfMKNB9sAPjrxLBq6CRCPbVj4IQ2Aq0Cq6rij3gTub0cz3GV5e6rWnzRFh2NniTdOZggazNEWHCOzyOx4VE77bQuFhghbwoAaeTMGGs2l0Y9g7vHfFPPsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm3IAImrKBksr+dVb83BH9sw7i6XR44SLhq615ongeA=;
 b=n/kJLfus2vO6uhitS2kpPjEqmsFHphBGhIuQaEgpsq+lV0mpsK8bToWF0+wfTb9uHkvXmgV4VBKKjsd2EYH1mrXbJj6I92ywc0aM0ZzMqG93wnh6U1K6NdWRL5arhleOgzKWuISbyVtWY9H/N/Y0XikFva/MClNpJAKiDfLQFzShUSTpmaOK/9jvZQ3J/AdQrJ1SHsOcar3XYksyeF8A4WclZWYtt1RaqNuPtFvzKJWjHI8eQ2MXUpousJNx5Kc/Um4G9N+9RMjRRcb7235WS1yd1JjsvTpNz1XIyrLZ4oAc4TPPw/CcyuiVn9dE0sn0iV/yyDIVpl+vGM6RMsqgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm3IAImrKBksr+dVb83BH9sw7i6XR44SLhq615ongeA=;
 b=VVjukn3AVGQbgosKgZGtmSL8U6sRrpcrtvPTOxCKO2Javr6ADjGEnpagJYEEOuR+qh5V4w//tHdD/8LRXictfrbQUBvTWrJzN+p9v7Ig5UU8tNlcQyO4oAQxH1pahxjfU3wxguC4ppAB5sSwvs3FW/NDbxWhK4oeZtPcgsV7C254FQ185W9bqj/AfH9yW5vBsOAGKDHhPuGRTOXmDP5ncb6ZmKqrK4swH7Miq5Ip/bumBR7RsgZ2Wm9MoZeMyMRLb/YIfy5mKWFu/Rf5AowxYJomjFPmCfJolkCgWK/tL/veNiIj62nLc/Pgf//+gQJi0CSw6j5kvTDI6JbMSjL4pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 11:51:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:51:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/5] btdev: Add support for syncing to multiple PA trains
Date: Fri,  1 Nov 2024 13:51:14 +0200
Message-ID: <20241101115118.43891-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
References: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 148ec311-bdfc-4c46-c8ec-08dcfa6b8d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NaE+BjH95xGlbKKmy9Zfr5sZH3sB+OdHL9+M1YOB8UZ0tf/YZJevofK33AYA?=
 =?us-ascii?Q?mDqXVqjYcm0JtNNWzemQ9mb62qUH3ICQ6dElG9o9pCrzEiZs4qofCyIUvJnc?=
 =?us-ascii?Q?Mn8eIbWJ/VkwGFdmMq0D76LcGJf5sKrmuyxFwHtAiBl6z19nQlD5sKW4epdw?=
 =?us-ascii?Q?w+nAeI2k3R5EhbJ03r/Pu8ELlPz3tgSf2vr0Gu6dhFbYKVOSWOdkOYeeO3jB?=
 =?us-ascii?Q?wH1S6HOrMw4mmmLMl9yMH6Ns1MoPRvZCOIPvOuyMG3mIeXgf4AsRdyi6e3mo?=
 =?us-ascii?Q?TJwZrDbn/hXlGpmgw+6FUCXG9509qG2fdy4V1WNhtma+IfpiuTQETdvodeay?=
 =?us-ascii?Q?3eWLf9dhpUaU6hTfxR7E5qtaqPWdYPZv8ovoIKyAQMvQS5dX6SSSx4br1KaW?=
 =?us-ascii?Q?k1cItjzunnrubr0sv+ctqaIWCwkebGTGC6ygvxP3agkf/A5S9Iri83n9RQN6?=
 =?us-ascii?Q?Ia+OQr4GwDdKXwq/PCe4DR8GOcXO60bAOrCxQkFcVpTdvf1Vg+Bzq5AVqJcj?=
 =?us-ascii?Q?TPFLu1ahy7zMBxuq+Xwnf2ukoTYC9YvBL09OVw+AZzxYyCob2Ij1tZfrsz/p?=
 =?us-ascii?Q?1RCOPrA0FPxR+rZsStdIvyi/MXn+Z10Z2QlKoFMnZYOyrSHdJiqMf/R9mXLq?=
 =?us-ascii?Q?Oqbq84xYhIKLZuHXpRikHLVOZibmn2SfkHSvjxbH87PkTiiY5DSL71g95AQo?=
 =?us-ascii?Q?SMvsf8e6stzRVl0kckhSFjoswSiMvRRTE4tY/gPIufr7aFUqklUb+n17IsXo?=
 =?us-ascii?Q?ypAwTo1gg1/rmZMIl+ZnfY0Z7jTbiN7O8nd1A8LyXO8bNQkGP3NOL3JuibuR?=
 =?us-ascii?Q?XOvw6ZoVi5bmMpWbzeTsJeoQDHay9CNj+c8GUOrs421rUkfWrUIib+lcEphc?=
 =?us-ascii?Q?sgiqtg8G9AjJwCnvgL9/gwiRLQAQ80a8uwV+3LJrscYddQanouwRd5UXn+lP?=
 =?us-ascii?Q?Utl3vJcKa2FgNd/OIE+ovOFvfNbyimzN5VRdcMqsG82bHfXf5O2dmkt/KTOj?=
 =?us-ascii?Q?fPvIJHaYT36h/uteU/dkNMb4SHhCp3F/zZe3dzU1oHl4MRQiGalMqA2bRPtS?=
 =?us-ascii?Q?teAymfislBKAsOelPtvptrol7J+I9y9LJQFnQfZcNjqY9qqqTAek4nxWA23b?=
 =?us-ascii?Q?+BaluBQC6E5H6LKqX7gf92stUQ2AeaymmBNrkFqJyuRu0T5jtkykzlyM0pEr?=
 =?us-ascii?Q?KZ0apX+8yeH883qeGg+5Ow9E8wR0jBC13dhh26MlwKKQzbxhCdC/WDuf6I+T?=
 =?us-ascii?Q?7zodY2QabXxC0CWbDatOdIzgRWlfBNoQYN4JC9JF/2XPd4F9Qmv1ugGdegJk?=
 =?us-ascii?Q?SgiN/N2hVv29/GSrXQUT0Lku4OvMo9nGhJMxlv5HGpToBRqGTueePRLcoGBQ?=
 =?us-ascii?Q?QBLWXuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9fkCDEh4TkOPuF4O/3Jz0raJKkliCpiHFOuEeYaoFirJn9qbOwOj3St7wFI?=
 =?us-ascii?Q?yJT+PhkyQ2/w56EZSTAw39QKTeAQoyafnnHP6nHAw1SIIEexUAN6ETCYpOJc?=
 =?us-ascii?Q?cvNlbJf2zIug9oqcadbfsusmYV9Tt6A0BMOW6jYe073Ld5oXMZCmSxox8eX6?=
 =?us-ascii?Q?bSIVAIq5wY3BV1tPCyBdCGuromVfmYGWSlIvd8ZcvXwLlKg3Mp7OAJvaElkV?=
 =?us-ascii?Q?aqK3cRinUNjbY1JYM8vdO9ZFX3HeN4F/Xi3+Tr8WHm10PSlg7dOdnJEqB73M?=
 =?us-ascii?Q?V2xgARai5CHvZkluf1wjzM5o7eyyvgcJQQWtCjWZFaJ1CVsowcguzAAoL2C9?=
 =?us-ascii?Q?I4up/zy0vbg9c0jr4KUtrxqibi7bx4aXyVfFqd/oW3TPzTks1xr9MeNxuvaf?=
 =?us-ascii?Q?K4C4GsKNg22+XgyMTwPQ8DmNvvrDeSpLj8qtlTSM6uOrw73rv5gneCy1ESJy?=
 =?us-ascii?Q?TArI5AKFRBiWXC9yuyw/SQoMd0friwHFRpyL/O/kVkUzeDIzrnBG3Wvkh9Wc?=
 =?us-ascii?Q?CA40eDfbW+z37wYOycofLTYTLltmsI1B7cxq6cKYA3rQGR59/964HURmJlFs?=
 =?us-ascii?Q?uZI9NJGwZS9PASgJg1No2FfyvN9WHONSLQ69btrN4JE2nD//iqGsHz7g8l8W?=
 =?us-ascii?Q?6nrsOIPG7d6CvTMpwBa+ZmOg2UhbQZ87i7zzb0w1RfKmI68GlAY20ezn+3jf?=
 =?us-ascii?Q?t5QU7am73eVQZrR5uYcL6PyQIuJjhMKRz/XTMJNFT2658aeOgjXjgbG03Mny?=
 =?us-ascii?Q?8nNAaypSNfPWVwxXyFdRkep3nXwTtB0djA/vEMXsjQBTBocKacyBQRvoT8mO?=
 =?us-ascii?Q?SJnERUzGRXvNvUlny7EVZR2EoY2cdqEI6mdGvIQSI9Sn3XszUwFdiKWOaqCm?=
 =?us-ascii?Q?3+TKqGhxgrex95CjuAFztnKLVHqnG14C+NIJBqoKNwDYoI2qzEV3nWFTNySN?=
 =?us-ascii?Q?t67l88sAmI7NSKTru7F8uS5mkR3kRuzsP8yCFY4wa2Zy3UE5vSYmSEHPkMlZ?=
 =?us-ascii?Q?jOChN4LhGN4Vr6w4cIgcyFTz41GqU0wDAHjHmwFw6el5wx/fVm5MJMtjrzfl?=
 =?us-ascii?Q?9vrQR5IIVx6FzQyHegsv7Vkxr061nTHVZYfVLRa5UaTqkKycKmHuX/X0K/6Q?=
 =?us-ascii?Q?t29X9PHLZx5UXRaYraOPBt2gETCQMJ4fWbBNqXLOEAzfR+YwIEqaWSClHrEB?=
 =?us-ascii?Q?WeKrCgUpABmykH4eN/gtmTetNfIuqQnuRGD8ZUkUW59XuSs5Zg3AEWstARpm?=
 =?us-ascii?Q?UpJCyEssxKLXFJJt+U2JF/4NTi1LzJhvL/Dk//PkFgt9sE7w9qaOD8SxGqvp?=
 =?us-ascii?Q?vKRjdCqm9hpj7q1DDtPMFH5Kel05xqDew4Jk2hue6mp0aA1nicFAhicxbXhT?=
 =?us-ascii?Q?nbuuStW9xqTXiMTZOn2SdbDj2P30VmjFEAQkDXFLBwMSFi8sHTVxGvL5lPk4?=
 =?us-ascii?Q?31N3UlEmYbji+j10L0fE30pVKfCt1drHDrO9VzoeZIt0BBNl42gyoYyxh9NW?=
 =?us-ascii?Q?7xj32Jpkwur8F2qgl8UUgKv0wbDzG/D365bSKbEiNNI5mEzrw/NYga5UeI0d?=
 =?us-ascii?Q?JC20miSu86CsuHgH5DLBi0u29E2T8ZzXI3aSzAo+e6Rpn/Fr+PFNAdwSAure?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148ec311-bdfc-4c46-c8ec-08dcfa6b8d9b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:51:42.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXJR4bwkYc5A2p9fSfPrV7/yFKLhsj1DmBrE6tIRjKepScTVzBspAFMWr6UMqj19OQPEK0k+EtRoN4zTCM0reA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

This adds support for synchronizing to multiple PA trains.
---
 emulator/btdev.c | 145 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 111 insertions(+), 34 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 5752a2fb0..ca70ad076 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -52,7 +52,7 @@
 #define ACL_HANDLE 42
 #define ISO_HANDLE 257
 #define SCO_HANDLE 257
-#define SYC_HANDLE 1
+#define SYNC_HANDLE 1
 #define INV_HANDLE 0xffff
 
 struct hook {
@@ -105,6 +105,13 @@ struct le_ext_adv {
 	unsigned int id;
 };
 
+struct le_per_adv {
+	struct btdev *dev;
+	uint8_t addr_type;
+	uint8_t addr[6];
+	uint16_t sync_handle;
+};
+
 struct le_cig {
 	struct bt_hci_cmd_le_set_cig_params params;
 	struct bt_hci_cis_params cis[CIS_SIZE];
@@ -212,8 +219,6 @@ struct btdev {
 	uint16_t le_pa_max_interval;
 	uint8_t  le_pa_data_len;
 	uint8_t  le_pa_data[MAX_PA_DATA_LEN];
-	struct bt_hci_cmd_le_pa_create_sync pa_sync_cmd;
-	uint16_t le_pa_sync_handle;
 	uint8_t  big_handle;
 	uint8_t  le_ltk[16];
 	struct le_cig le_cig[CIG_SIZE];
@@ -239,6 +244,7 @@ struct btdev {
 	uint16_t le_ext_adv_type;
 
 	struct queue *le_ext_adv;
+	struct queue *le_per_adv;
 
 	btdev_debug_func_t debug_callback;
 	btdev_destroy_func_t debug_destroy;
@@ -578,7 +584,6 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_scan_enable		= 0x00;
 	btdev->le_adv_enable		= 0x00;
 	btdev->le_pa_enable		= 0x00;
-	btdev->le_pa_sync_handle	= 0x0000;
 	btdev->big_handle		= 0xff;
 
 	al_clear(btdev);
@@ -589,6 +594,7 @@ static void btdev_reset(struct btdev *btdev)
 
 	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
 	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
+	queue_remove_all(btdev->le_per_adv, NULL, NULL, free);
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -5246,7 +5252,8 @@ static int cmd_set_pa_data(struct btdev *dev, const void *data,
 	return 0;
 }
 
-static void send_biginfo(struct btdev *dev, const struct btdev *remote)
+static void send_biginfo(struct btdev *dev, const struct btdev *remote,
+							uint16_t sync_handle)
 {
 	struct bt_hci_evt_le_big_info_adv_report ev;
 	const struct btdev_conn *conn;
@@ -5259,7 +5266,7 @@ static void send_biginfo(struct btdev *dev, const struct btdev *remote)
 	bis = conn->data;
 
 	memset(&ev, 0, sizeof(ev));
-	ev.sync_handle = cpu_to_le16(dev->le_pa_sync_handle);
+	ev.sync_handle = cpu_to_le16(sync_handle);
 	ev.num_bis = 1;
 
 	while (find_bis_index(remote, ev.num_bis))
@@ -5281,7 +5288,7 @@ static void send_biginfo(struct btdev *dev, const struct btdev *remote)
 }
 
 static void send_pa(struct btdev *dev, const struct btdev *remote,
-						uint8_t offset)
+				uint8_t offset, uint16_t sync_handle)
 {
 	struct __packed {
 		struct bt_hci_le_pa_report ev;
@@ -5289,7 +5296,7 @@ static void send_pa(struct btdev *dev, const struct btdev *remote,
 	} pdu;
 
 	memset(&pdu.ev, 0, sizeof(pdu.ev));
-	pdu.ev.handle = cpu_to_le16(dev->le_pa_sync_handle);
+	pdu.ev.handle = cpu_to_le16(sync_handle);
 	pdu.ev.tx_power = 127;
 	pdu.ev.rssi = 127;
 	pdu.ev.cte_type = 0x0ff;
@@ -5309,41 +5316,67 @@ static void send_pa(struct btdev *dev, const struct btdev *remote,
 
 	if (pdu.ev.data_status == 0x01) {
 		offset += pdu.ev.data_len;
-		send_pa(dev, remote, offset);
+		send_pa(dev, remote, offset, sync_handle);
 		return;
 	}
 
-	send_biginfo(dev, remote);
+	send_biginfo(dev, remote, sync_handle);
+}
+
+static bool match_sync_handle(const void *data, const void *match_data)
+{
+	const struct le_per_adv *per_adv = data;
+	uint16_t sync_handle = PTR_TO_UINT(match_data);
+
+	return per_adv->sync_handle == sync_handle;
+}
+
+static bool match_dev(const void *data, const void *match_data)
+{
+	const struct le_per_adv *per_adv = data;
+	const struct btdev *dev = match_data;
+
+	return dev == find_btdev_by_bdaddr_type(per_adv->addr,
+						per_adv->addr_type);
 }
 
 static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 						uint8_t status)
 {
 	struct bt_hci_evt_le_per_sync_established ev;
-	struct bt_hci_cmd_le_pa_create_sync *cmd = &dev->pa_sync_cmd;
+	struct le_per_adv *per_adv;
+	uint16_t sync_handle = SYNC_HANDLE;
+
+	per_adv = queue_find(dev->le_per_adv, match_dev, remote);
+	if (!per_adv)
+		return;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.status = status;
 
 	if (status) {
-		memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
-		dev->le_pa_sync_handle = 0x0000;
+		queue_remove(dev->le_per_adv, per_adv);
+		free(per_adv);
 		le_meta_event(dev, BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED, &ev,
 							sizeof(ev));
 		return;
 	}
 
-	dev->le_pa_sync_handle = SYC_HANDLE;
+	while (queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(sync_handle)))
+		sync_handle++;
 
-	ev.handle = cpu_to_le16(dev->le_pa_sync_handle);
-	ev.addr_type = cmd->addr_type;
-	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
+	per_adv->sync_handle = sync_handle;
+
+	ev.handle = cpu_to_le16(per_adv->sync_handle);
+	ev.addr_type = per_adv->addr_type;
+	memcpy(ev.addr, per_adv->addr, sizeof(ev.addr));
 	ev.phy = 0x01;
 	ev.interval = remote->le_pa_min_interval;
 	ev.clock_accuracy = 0x07;
 
 	le_meta_event(dev, BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED, &ev, sizeof(ev));
-	send_pa(dev, remote, 0);
+	send_pa(dev, remote, 0, per_adv->sync_handle);
 }
 
 static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
@@ -5369,7 +5402,8 @@ static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 			continue;
 
 		if (remote->le_scan_enable &&
-			remote->le_pa_sync_handle == INV_HANDLE)
+			queue_find(remote->le_per_adv, match_sync_handle,
+			UINT_TO_PTR(INV_HANDLE)))
 			le_pa_sync_estabilished(remote, dev,
 							BT_HCI_ERR_SUCCESS);
 	}
@@ -5477,11 +5511,14 @@ static void scan_ext_adv(struct btdev *dev, struct btdev *remote)
 
 static void scan_pa(struct btdev *dev, struct btdev *remote)
 {
-	if (dev->le_pa_sync_handle != INV_HANDLE || !remote->le_pa_enable)
+	struct le_per_adv *per_adv = queue_find(dev->le_per_adv,
+			match_sync_handle, UINT_TO_PTR(INV_HANDLE));
+
+	if (!per_adv || !remote->le_pa_enable)
 		return;
 
-	if (remote != find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
-						dev->pa_sync_cmd.addr_type))
+	if (remote != find_btdev_by_bdaddr_type(per_adv->addr,
+						per_adv->addr_type))
 		return;
 
 	le_pa_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
@@ -5622,16 +5659,37 @@ static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static struct le_per_adv *le_per_adv_new(struct btdev *btdev,
+			uint8_t  addr_type, const uint8_t *addr)
+{
+	struct le_per_adv *per_adv;
+
+	per_adv = new0(struct le_per_adv, 1);
+
+	per_adv->dev = btdev;
+	per_adv->addr_type = addr_type;
+	memcpy(per_adv->addr, addr, 6);
+	per_adv->sync_handle = INV_HANDLE;
+
+	/* Add to queue */
+	if (!queue_push_tail(btdev->le_per_adv, per_adv)) {
+		free(per_adv);
+		return NULL;
+	}
+
+	return per_adv;
+}
+
 static int cmd_pa_create_sync(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_pa_create_sync *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
+	struct le_per_adv *per_adv;
 
-	if (dev->le_pa_sync_handle)
+	/* Create new train */
+	per_adv = le_per_adv_new(dev, cmd->addr_type, cmd->addr);
+	if (!per_adv)
 		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
-	else {
-		dev->le_pa_sync_handle = INV_HANDLE;
-		memcpy(&dev->pa_sync_cmd, data, len);
-	}
 
 	cmd_status(dev, status, BT_HCI_CMD_LE_PA_CREATE_SYNC);
 
@@ -5671,7 +5729,8 @@ static int cmd_pa_create_sync_cancel(struct btdev *dev, const void *data,
 	 * HCI_LE_Periodic_Advertising_Create_Sync command is pending, the
 	 * Controller shall return the error code Command Disallowed (0x0C).
 	 */
-	if (dev->le_pa_sync_handle != INV_HANDLE)
+	if (!queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(INV_HANDLE)))
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_PA_CREATE_SYNC_CANCEL,
@@ -5690,16 +5749,24 @@ static int cmd_pa_create_sync_cancel(struct btdev *dev, const void *data,
 
 static int cmd_pa_term_sync(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_pa_term_sync *cmd = data;
+	struct le_per_adv *per_adv;
+	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
+	per_adv = queue_find(dev->le_per_adv, match_sync_handle,
+				UINT_TO_PTR(sync_handle));
+
 	/* If the periodic advertising train corresponding to the Sync_Handle
 	 * parameter does not exist, then the Controller shall return the error
 	 * code Unknown Advertising Identifier (0x42).
 	 */
-	if (dev->le_pa_sync_handle != SYC_HANDLE)
+	if (!per_adv) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
-	else
-		dev->le_pa_sync_handle = 0x0000;
+	} else {
+		queue_remove(dev->le_per_adv, per_adv);
+		free(per_adv);
+	}
 
 	cmd_complete(dev, BT_HCI_CMD_LE_PA_TERM_SYNC,
 					&status, sizeof(status));
@@ -6359,11 +6426,13 @@ static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
+	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
 
 	/* If the Sync_Handle does not exist, the Controller shall return the
 	 * error code Unknown Advertising Identifier (0x42).
 	 */
-	if (dev->le_pa_sync_handle != le16_to_cpu(cmd->sync_handle)) {
+	if (!queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(sync_handle))) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
 		goto done;
 	}
@@ -6402,9 +6471,15 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	struct btdev_conn *conn = NULL;
 	struct bt_hci_bis *bis;
 	int i;
+	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
+	struct le_per_adv *per_adv = queue_find(dev->le_per_adv,
+			match_sync_handle, UINT_TO_PTR(sync_handle));
+
+	if  (!per_adv)
+		return 0;
 
-	remote = find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
-						dev->pa_sync_cmd.addr_type);
+	remote = find_btdev_by_bdaddr_type(per_adv->addr,
+						per_adv->addr_type);
 	if (!remote)
 		return 0;
 
@@ -7200,6 +7275,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
+	btdev->le_per_adv = queue_new();
 
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
@@ -7219,6 +7295,7 @@ void btdev_destroy(struct btdev *btdev)
 
 	queue_destroy(btdev->conns, conn_remove);
 	queue_destroy(btdev->le_ext_adv, le_ext_adv_free);
+	queue_destroy(btdev->le_per_adv, free);
 
 	free(btdev);
 }
-- 
2.43.0

