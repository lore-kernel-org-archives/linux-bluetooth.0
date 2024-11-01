Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A96156F4A
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449911; cv=fail; b=q/q45h3PqJc/f6Weh0k3jc/IZYhUPyZzC+C3dgStL80+Nyztf06Ku30ZKiU03TSi2U/QD/TK4LOHtvoWWPrhjeV9cd81fMdmfovQpClwFnV2li3Wyu+P3LEfC+Fwrp9IeL5U6J4q2w+tWimlA1qbaH+azTRz/YxVDIYIW/D2mio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449911; c=relaxed/simple;
	bh=36PcaJ/+ROEQXtTGmyMwot4azT8EnM10ufmINSBeeWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYFkk7GG4WS5P9w6k7mcMl0TpJe2qaALxnpcrfK2BZcTbzvw4Dn+xQzkQ+xAH48wooYA9QRXaR4CzNd0DfRfnJCz94OTN9Zo7QF9qOqmx+DpFSvJizJT5gmnROikmHBQSh67mXA7eSjx18Ag+xXV4WfanWWKznZfwJi10GWmzIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h9OIwg9q; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h9OIwg9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKNlxGWrVsAgYcE/SuNavpmaDtVPP7LJYnkc5tB5fcCg79i4S/bx3V6+p4GB/sxP1oYJ+ABmKYWjv36jnnl8VP24x/igDxbKTDDf450TlYbvW+JMjLd4qEMDkMqjyJtkguoGfnIrfbXZw4nShQ6bK8hi6fF1NymsVO59Hfg9TrVnHE0P/uEzzf5ExAQLD0yiylAxCaMnwBBm3exyAw8LFK/FIRHbsn+1c1SjPVVNGrgLu19qpcuPKjk0VY+8jHZPoEPHhcGxSmxCEY8D1evZkwcKJbB6jT+XYe9h5umnsRwpzzdSALstW7IdyPgQ9Ivo7PyQP73wHMGYjqJcHI4nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0nas5snKGgsLGrOh2GmmxUX4gyvgEyKoYn/56M+oRA=;
 b=cfRl7cQuvA2ThH9+6YN8Ko/xXgaObpa3eucNPGMGWyRx+l+Zee+Wj5IzPuATFcgO/lkdjmDh1chNbAm1GvpMr2oPtzTyP67xFgqd6JPGOnixoI0zy3Hv/cVEHTAR4B7gioXCDwT4TAm8SP1pbdsWvjOiNpd+/Jx4ovUqqPzf/YdIIXiNZX23fJJCA5pA/vKAgnUonht9fg+p4zOacNoEDdYt58L/4pn+x418qAh2VKB2xUNCfC4X8SfBB30N+bu4jPGi5GzP3xoyyqhVt0JbpR+ambSqMjCgfNr97YVEKz+TWjdsLbBEr2Rh2phXOXIwewKXmjeb6Ro0uYsfpSkZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0nas5snKGgsLGrOh2GmmxUX4gyvgEyKoYn/56M+oRA=;
 b=h9OIwg9qx5ViFkCzWX4m+gWsl8kWOCylDvjaZVlx2ya2/b1klDjQMHoOMFef4Jv4zouj6sTRoxRl/zg43vhJ7SWuG1Uy1TNAXWGdcZJxkoahs1YF0ugVLwmdnvfuK4L4kneUQoEE1+L2knLC4LM3g2dG1jzLueLcLoLK3+3f1ZIlSq0bg8Tg30wvDx6+QheMDl+IwS2N/NdHYaAsa/VODELfrGs2bIpUs1/d2GM4kixb8OYJh8gpxtkxBJZtEpodJWIZ4uDCk02iQyZ6rHF1+BaN6Idz/pAj5IKq+vZDMMqXA33lv4ti5rWrD4uO1EDw/Krt50sYkZv6nSaJQd5eqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 08:31:45 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:31:45 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/5] btdev: Add support for syncing to multiple PA trains
Date: Fri,  1 Nov 2024 10:31:15 +0200
Message-ID: <20241101083119.4510-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
References: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d3f4a4-c2ed-45de-4da3-08dcfa4f9ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwy6bMtLo+q88peptqYzH2l90BGSMDKgLKV9KzCC6pCNnWVFUr7mxJbU1X/y?=
 =?us-ascii?Q?2ndpAyhuNhf6fG3s5YrO4x3NSuFUggmqMCpxH861OEBdtcXAikRu4MZVkqX2?=
 =?us-ascii?Q?WB/DNNkuzu4MoQOuDHZYxsIuhxdm81mRIxiIhuKGF5lp4pfLuS2h5GLooADJ?=
 =?us-ascii?Q?0pKWma0wHu+uzqKq7Ni1YJzbQk/mm5IYWeNpXXiQzJ6V1IwTROar45PWTPLH?=
 =?us-ascii?Q?8+npNIYiTT1wzzb0K7KDeQpaZtFaRL6Vm6seSNYHRxC4ExbDyg+7v7eRw3l6?=
 =?us-ascii?Q?ZSKrFRiZW2FhgUdWnINvr0pNOypCIx8T5pQ9U6fTQ0fvQ7qj15ZbSoCp/0RS?=
 =?us-ascii?Q?tQ+N7hwK/7/Rw9x2f7frt2ex08R8MXA47z7J4EMOLqSKgkGeN/crNovhRKg+?=
 =?us-ascii?Q?ihBM2ad4AnBCU9sve3gTEE4PZzKorLMrC63G0o5oY7vnjPrUD7jTYRtYVcvc?=
 =?us-ascii?Q?IwCY5bpmP87nthF1fYjQi8HieLMrqA9F+Jl4xUwgdU9CnOoa/Z/FGWJ1p89E?=
 =?us-ascii?Q?wJQe0HXHcLGz4Qf5GgmvO5mSTBu6jqe3XnxY8xd6RnsWQhfc891WVLClS5No?=
 =?us-ascii?Q?eT/nMpFRoX+JkiCVbJlj+XYjD1+GgjQwW1+btqNgJYiqQFbPQlFvg+a21jst?=
 =?us-ascii?Q?Nvhe00TU8mywIXcZ8EK9heVXelbHJ2Gr0PwVwrPgDrZ23CnK9oBWXrUiEZVA?=
 =?us-ascii?Q?hRbj2d3aqugSFskNyeSavcFUrFnLj9v5+fUVFS6Ko/8CETOP15h6I2+c+1wo?=
 =?us-ascii?Q?dAoqf/2FYS4Ihut34rxpIcblP6Llr5baR2UHC7U+kuzNtBpJLKKwcEC4BPdU?=
 =?us-ascii?Q?XI2M011sjE6Vmz9SNU0B4IJ0j41Ri8pJQcA4J701UA4BjoX9+2fghgX+9nv5?=
 =?us-ascii?Q?e+5vjI5J+rWUIB68glNizkAaYjOAWvbK5Sz3twu9V9vHQytpuDC+4JnmWEJb?=
 =?us-ascii?Q?W7sWZFJWz0QFARBHSQqajmwQ/efSnympbEs82I6LH3QHaiswvtdx/I0AKs4E?=
 =?us-ascii?Q?dNHLg2mkLAoiwuSBGuiyVNk8t7iXXMqjhwsiCh5aSVzd0eH4ylUo62yAC6im?=
 =?us-ascii?Q?V5WkFDsfUBQzyPSLXUv3n2pf0pp8/KKZCYl7Qc2jW1ohcrTf3RbeZXxZ/O2/?=
 =?us-ascii?Q?oFEk+NjXXZJ58QPWel/xJlYMTMSi+2mLOs/N/cIWMytkJGx8v6+m4a5OXbXf?=
 =?us-ascii?Q?FRH1d6uFntVdqmgQTLWaMKnOhqmPHJ0i+ZS1GqJBWY6hGWVA46B/gNDCfQ79?=
 =?us-ascii?Q?7Y9YgeXoq7NJB8FFJ3ZpaMSV9wG7GxWyVTLiMiPPCExFsLiqNw8AGn0vnz1K?=
 =?us-ascii?Q?FfJI9mmZG2OdWTGbs2kNHo7t9MS4MrL1ACFQTiGCJpd3F6Bo/4z623k2ofk9?=
 =?us-ascii?Q?aP+F+Lo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gv2YUn9K1RVW+2Lil+Wycf0LnKLzTXmPH6Ks1Pb4Ioug1xvZle8/UN6mtGSf?=
 =?us-ascii?Q?b2H4FtT40ztSfKEAPyu+aWAda14BXgbQkkNhNJ/ZjxI2BIvvQyMcPVYh1CFI?=
 =?us-ascii?Q?I75+TLphVNQh+omtImdStNYZ+NO1nAH+7PWuhcbpe/hDEdiQglmLVGMZBU14?=
 =?us-ascii?Q?W5/epYkMBr7koWEsFsKqMXbdIEADuj8aEXNUW2DAYuCocn3F4Qn52vr75r0n?=
 =?us-ascii?Q?F+CJJ5HC1cHxQzVZNVOZnLj7tejCrQl2if3oaFaklx26YAykhlVmSapHtAJj?=
 =?us-ascii?Q?mm1FaF8/c1vOQHY3HTqdZZE8WjwfD/k6VdVaev80/M2rxQQahJH+TDDtORp2?=
 =?us-ascii?Q?Ti3me7+KthrlfB8t7b2L3UpDsLH2YTqnGsV/W5DRNvbqZQfEmiqkI3/nufS6?=
 =?us-ascii?Q?D3kuED0Wwv7oYl6Ezmcw8cBURngoYPsQLkIwOmKyswz7c8fw7EO2HsIl3Inb?=
 =?us-ascii?Q?BPfnVY5EBrzeQoumwiU3tL06/3bSVZlAb4O10NDfVrR2HDxRESRtkHtIXpoF?=
 =?us-ascii?Q?p6odYX6DuXXtYbRCjpKF0eRJeLxJOb50hgbFLfqMWIOx8coUfXoeUOxE6OPC?=
 =?us-ascii?Q?HbIFJ26Kvrb0jj9Sy1/r0A5+1iDahk+KAqV2xbgAK6L/J38zhhdiieU20XDi?=
 =?us-ascii?Q?mgbfwEr3Q+9jOS9gJLYNhaNvq+ZkBuS2EQZobHe1wBhkpfHRbMVAYKywJGVZ?=
 =?us-ascii?Q?jaH83gmlFdexNIvHXITjr2RUSi0TMWT0DQn6tWhbR6siPe4TE4verdDClbtC?=
 =?us-ascii?Q?RzWMi6H6ldUL5qYVEnd46gEvlHgQdw4iKY3E9L7vPwM+o02MfxS9c13Lxu/n?=
 =?us-ascii?Q?0LWs6y+Ref7urXf+zAChVYxsYJ9PypXFTFDwriMZXfOnSVUv+ybIpVblw8Iv?=
 =?us-ascii?Q?Jwyq+TOb6o2bIKtt54inyGbw2iCL0CuUR+Uow84hU5+u7EA3N7jTDHr3z69U?=
 =?us-ascii?Q?DfSOwYBOLJCyKkiMMUdsoDGCf2Ib0CJ2Vlx0R4aRz5xbKZ7nZ2ZRT/dN+Wxw?=
 =?us-ascii?Q?oUHVmsKBA8J64HTXm1hkSgcemMNdYk8rD7CZckkJHk1+LzoY5TpZoihfhCml?=
 =?us-ascii?Q?xp7uClKS0KeFhELiDQU7vD8I5MHRSRBDRIyfMloDsbI4LqCN8OOPxr4zuYPH?=
 =?us-ascii?Q?URkqPdi927Crbq42Dfh8bMRhtfn/yndkgbmBzauM4M1MGfLk7awArsmqtsQj?=
 =?us-ascii?Q?AIHcumHziAjwOV5MCtVj6KMc2QMYXZD1NfhG4G0t5hP+Zfxbl5roiEgwCJrK?=
 =?us-ascii?Q?uueFCz+Ny23l5VJClFlcvVkEA1bmQqJouiCy6kkj+sjqUwJJDVn+sKl0yzto?=
 =?us-ascii?Q?qayhK4fustQSDSIKRuBAQtmr70eKcFHOhFB9o8PtkHfslzFMklH+wXWAMx6u?=
 =?us-ascii?Q?KWO/M6HS91q9ET8Q76PWfdfzXzg1HpvqPyQm5drC5Fpy+mJ7qjgujCjstjVm?=
 =?us-ascii?Q?vUt4OMUt9isLeOJzPogZnsmpfpy7syN9l2U/f00ZBIbOvnZM4EtXYkKJMy14?=
 =?us-ascii?Q?vl10p+d1b/r0SDIQ00WCjvQqm5ZfuBYlowt5zonwVKtjo1gxO3GkgcnY0Sqq?=
 =?us-ascii?Q?YmITKH34ja/zCx3kSVn0943C5/bZrvnaaAaVOCtLp0ogeLWH/NFd2s+inkbz?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d3f4a4-c2ed-45de-4da3-08dcfa4f9ed6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:31:45.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orJR+E00Sh4i+Qa6xtwc0IB9Lg9qo7d0I65OPlmee8/fyLBkWjBcPJ6C1lpLeFyVII9+Vqo/FNOUT7OfG3CbJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

This adds support for synchronizing to multiple PA trains.
---
 emulator/btdev.c | 131 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 100 insertions(+), 31 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 5752a2fb0..3b0a267d1 100644
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
+
+	per_adv->sync_handle = sync_handle;
 
-	ev.handle = cpu_to_le16(dev->le_pa_sync_handle);
-	ev.addr_type = cmd->addr_type;
-	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
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
@@ -7200,6 +7267,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
+	btdev->le_per_adv = queue_new();
 
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
@@ -7219,6 +7287,7 @@ void btdev_destroy(struct btdev *btdev)
 
 	queue_destroy(btdev->conns, conn_remove);
 	queue_destroy(btdev->le_ext_adv, le_ext_adv_free);
+	queue_destroy(btdev->le_per_adv, free);
 
 	free(btdev);
 }
-- 
2.43.0

