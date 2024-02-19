Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0492D602
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344926; cv=fail; b=e3kLiZOTc6aGSDSrqxciMhYAFF/wa2ftu0ApI0s3pb8AY0wfs42QAXrMozEKf3UL+faqVKuC2Uv75WE2fe7A1nRizVy96lSW/aOiXGwiCOtvjH4kRkL5i3yvt7Dr+siXUkaWacNryDCeQ4h9IO//L6t4UYomnqWgyv64eozs7kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344926; c=relaxed/simple;
	bh=g8HzpD242OE1BEHH9AivH1bfQovIMlejxPb82jHU0qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ft87okKJhnOnOWZk7dIoA2ar4AY77/H4DXMMdcdrOOqn8gOgXRKip+3NzaMoEUSGzXTRTwPEq9eYkDPtt+1bzl+N2iDW3LJM7CaZ0r/PV0keRcbGGm/C5CnHMGejtncjQyL895L8rZ34Aa3NVpuVH8rcNQXzpV071NDOcF9eKi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X/j8Lgze; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X/j8Lgze"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXVGmdwqY5inJHt2FALR+ZkRQX6AIDnceSmRHEdVWkm/TizhKZWW83vTivIlWPV9mPaI4GXLbkSUAKYUweeNQ++z1pOyS1Id/ycu8uemSb1faLxAZxBR9+R7Xu/+ysEgLHG4/U1vJTsGX66cTvhyrTV4vAeVIr/WCFtGQFK21P69in8GDePj/QXToMPkfidgEkKwLrk8eC9N+pBt5f7UwYcHYqehmhwwYnanL6a76q7fSP6diJkwet1voLTG+TjpZM6LlfVwQZCVrU+EGrwPqrCa3p8iPq5+FbfdtVQqKFZvqga5wCGS9rVJ3htSpBZC7x/4+QG2cfK09GAuvS6F4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrfbAIFEw8KaXKvHGllD1LufCIzh4RDJiDcsJYsv6MQ=;
 b=VsG4/Z92oKl1oaW5kpupvQTli6iIe8Zet0/NO7LWVEqlfLeqkNYEwp1U4ZrBxK6+Tm9pjpAgxWQDGGEmgcCP66dmBdsWQd7VMYlaZNG3U51NiUJjLXJ53spqcfc3akXxMTQ9qQwzAOnyiZmuiJoea2UktkM92lEh/M39D2+Rg4Xb14VDv29NXx4jjZTdKVSnkqI1aXzbbi66kGUdpEE5EzTHOnHofKdhtScMuc0Tndwj8x7imjwn6mxE6eBfX4SG8IaG3ZQP06KVQDY83+++7j9AV62uOBo4qSbu7yBt70dmek4RP/CC9kkMr6+rbogzz4iI5jIt/sm8rRjHrRHPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrfbAIFEw8KaXKvHGllD1LufCIzh4RDJiDcsJYsv6MQ=;
 b=X/j8LgzeCKhRJCY9d/0UhP02Wg/sHgyn3C71qeBiTQfC6Cl6DSPynpt8RWgqcBpe+LQk+rx05Ns5GX9q62xqhAIT/8CTxabFW21is9G8cZz8wtUPfRr9A6n31TVMe5JL1eQ+RMMW9NOaMMo3Vhw7gQmwWKQeH3Kr7VO+Al1E/fY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:15:18 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 12:15:18 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 3/4] shared/bap: Add Broadcast QOS copy functions
Date: Mon, 19 Feb 2024 14:15:08 +0200
Message-Id: <20240219121509.5702-4-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
References: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:205:1::29) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 82949da8-567f-4474-397e-08dc31446fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uSePvjcqaykavfCHPhBAu+uCDP3xLjxealilEfhxEvQPeUo2/qyBk01OiN882HOEereTcJkBwH0IVPYWl79zT5ZzqzGgSuZ2I+k+jDEA6N8Z5snWkCLHwVzQZtOXm04PSGj0GNbya96us9f5QeuBwQDNh3HFTdzQymcceoxrW8rvFJqo9LkDH4mj1OHec8uXCIzgrt8+1pSDjErKe3LhRHbzXNNu476opWg2uOoJpt32m36o3SaNrPGKfiXt2WhVkttONCqNRwtUXxyAqTZy9p51Ds3gtouR4C2XSzjv5rssue1aG3TCEHWYxYHqYndVzsqYx19ernrVCZzsGqoJxbo5O+WTAeoLuWVz6GnSru/wk1zd2iIBGrpUa5hZYWrxcj4m2s4g60NxZbruGO5APHUudtv085Xn9DJzQSk0pnoApT8HpHYqv6elk0kPl+QVmhEhCI94vMRLEzP0UTzbmAvsc+EMizGsWYFBM8ojV1zmz/gDg0sgKQmtbf9rwidUVpp5FohiE5WZlBvJnu66AsrjbFKgi0D0Aw9CNBnGej0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvR0tMRZzmtKKNkOkEjxt2yN8VSIfl4E+kV6tOnkp3kIfBtd72sN7M+kWOnI?=
 =?us-ascii?Q?xaUGtxLvP9gbNCCbKUNPA3MPE3MJBVpQpBogVHo2Zmv5q78Fpr5CMpwgn/5/?=
 =?us-ascii?Q?/wDCcW4QyI2MKTEUel5+hcSLGXnnR5P+pomSrROXlkFPEGSaqV1xWTfikjh6?=
 =?us-ascii?Q?mtqRmbYvswrgqi9caZnjav3j885YccgIecJgZt9N3q+ke3cYuv2Upg/sMBIh?=
 =?us-ascii?Q?ZjVV4Ol+s+fxrWhBnmaBfDGGHcBaKo2AzmI3Aiq51d8Tsj4wX5953zHhL+Pq?=
 =?us-ascii?Q?bRU4xTkmtLnmNvGODdBJA2uWz9etd/Njkz1bnVVTcr58tuzhWRMEkK0e1HTN?=
 =?us-ascii?Q?UYHKhkFLGPXVLr+vybXwXE04A0yY6PmSdJURJgRGFelPCjmNjgqNMihcYN12?=
 =?us-ascii?Q?xI6sL7ZiG5obqj4FuT6P33qNC5bugHUKFQzrPme1NgwXYep49HZ820/uoKUU?=
 =?us-ascii?Q?BswBV95+VherYvl6M22vfc8vcWLWtmIbLynYJOj4Pp3YbgtDQJjpJcNVGSkp?=
 =?us-ascii?Q?BzPu9WGFN1xK27vk+AxLgjy4wW1fvmcOskMz6PvEir1rSyxcxUhuMKvs5jr7?=
 =?us-ascii?Q?EKQA6ZOryAiIkavpLpjqbtnxQ44IJR2B95PJpTPBUyk0y00Fr/cXVrEs3bj3?=
 =?us-ascii?Q?VdUoFcwpuGcTvX1ITjweBtLQj4owgLT51Y2eSr5PjOGi9ds6pfkkpmSp/65o?=
 =?us-ascii?Q?IDhCY6SlqurlOPVvS7p02jLlygkSXWk6h0VSuSU0mjN+nWKxZsm6p80r4IuT?=
 =?us-ascii?Q?O0t8D/cjrphPgMKKFfksOQHt4g+vcyasYxVsJ5xZrCEiI3Psdle2T8fzktDi?=
 =?us-ascii?Q?WWpN1d+clG0tXZVphge/sFN1feB/7ZAvA3CFDVrj1CHXAGhXzM9vVVSMTQCv?=
 =?us-ascii?Q?vmdhT+5itIaXnCD3wl3VURf7YG/bketxtcanqCU1pIrk1L2ALcw6LeAwhpzJ?=
 =?us-ascii?Q?uXYqPet8vOWyC9oPrxoc+E6nYbwpjBa9Lb8LpNblwMjxYaO59aLXbPdfqwfB?=
 =?us-ascii?Q?nXpTfdCtBz183IfDbv9JJJJafDyi1fLC2RwoEkFh4vc+Lx0DHbqlHkZiX303?=
 =?us-ascii?Q?3dBiqdDzc7S+F6srHJfwBE/DAj1JgKCLJbkVvFljNVBYR32QVBxVyGX6lIet?=
 =?us-ascii?Q?ACsuKoJ9Hg6ZHSxGVlSGyS8UhRzgssX3wZbvubwJs5hq3LV2mvpRvou4Spm7?=
 =?us-ascii?Q?Cen8c4neR4nCN7qi+WNNLC14BgaL/F/yVLeYFsCthaXIBNz/Io7/GVdsZX1M?=
 =?us-ascii?Q?k53+gwWeoi7691AF3wzjy9U7Mj0XOapR/KXvdEKf/tbSaSvbmhb+RPf4yOXL?=
 =?us-ascii?Q?9ZRlY1Nh+NUflHCOANf7kIdgZEzNBgQBb/43MPzdPzb1r+3fR96uv8cxPFU3?=
 =?us-ascii?Q?nb0LwbwWA1NDsUT9ntJ4DYXwVnorWbV1Q0IMnPvK/gWykHvPfJP9SFcjBkHq?=
 =?us-ascii?Q?8ysmOn3y1/G0L96SonBptG37Q/AJPr7aKpIgbgXZMWoOjQhlk3fHi+/GZEl9?=
 =?us-ascii?Q?t5fy09lZRNLMRLztBMukmGE4BmVMR1X/GRj7a6enT8ap82A2ZWbI6MBljdfM?=
 =?us-ascii?Q?a1Sjrz8G7LV6v8WKYqF3RriJ7rbFxEU/mC//nEVoovB4xlblr9B1rYmktZ29?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82949da8-567f-4474-397e-08dc31446fec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:15:18.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wquWliXUR/M88K6loywdzRhajeh6P1vJ8vXWxutSokxmHMuH4Ffk5MkOFmYyRJJtGyLuk1aykUoWqY1/o/7i2pb/h93ogj2K7Ta1l85Sky0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

BAP works with bt_bap_qos structures and kernel with bt_iso_qos. These
functions are utilitary functions to allow jumping easily from one
structure to another.
---
 src/shared/bap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c3d96c08fddc..19e40e3c70f4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6527,3 +6527,47 @@ void bt_bap_parse_bis(void *data, void *user_data)
 	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
 	cleanup_subgroup(subgroup);
 }
+
+void bt_bap_bcast_qos_iso_to_bap(struct bt_bap_qos *bap_qos,
+		struct bt_iso_qos *iso_qos)
+{
+	bap_qos->bcast.big = iso_qos->bcast.big;
+	bap_qos->bcast.bis = iso_qos->bcast.bis;
+	bap_qos->bcast.sync_factor = iso_qos->bcast.sync_factor;
+	bap_qos->bcast.packing = iso_qos->bcast.packing;
+	bap_qos->bcast.framing = iso_qos->bcast.framing;
+	bap_qos->bcast.encryption = iso_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(bap_qos->bcast.bcode->iov_base, iso_qos->bcast.bcode,
+				bap_qos->bcast.bcode->iov_len);
+	bap_qos->bcast.options = iso_qos->bcast.options;
+	bap_qos->bcast.skip = iso_qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = iso_qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type = iso_qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = iso_qos->bcast.mse;
+	bap_qos->bcast.timeout = iso_qos->bcast.timeout;
+	memcpy(&bap_qos->bcast.io_qos, &iso_qos->bcast.out,
+			sizeof(struct bt_iso_io_qos));
+}
+
+void bt_bap_bcast_qos_bap_to_iso(struct bt_iso_qos *iso_qos,
+		struct bt_bap_qos *bap_qos)
+{
+	iso_qos->bcast.big = bap_qos->bcast.big;
+	iso_qos->bcast.bis = bap_qos->bcast.bis;
+	iso_qos->bcast.sync_factor = bap_qos->bcast.sync_factor;
+	iso_qos->bcast.packing = bap_qos->bcast.packing;
+	iso_qos->bcast.framing = bap_qos->bcast.framing;
+	iso_qos->bcast.encryption = bap_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_base,
+				bap_qos->bcast.bcode->iov_len);
+	iso_qos->bcast.options = bap_qos->bcast.options;
+	iso_qos->bcast.skip = bap_qos->bcast.skip;
+	iso_qos->bcast.sync_timeout = bap_qos->bcast.sync_timeout;
+	iso_qos->bcast.sync_cte_type = bap_qos->bcast.sync_cte_type;
+	iso_qos->bcast.mse = bap_qos->bcast.mse;
+	iso_qos->bcast.timeout = bap_qos->bcast.timeout;
+	memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
+			sizeof(struct bt_iso_io_qos));
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index aed3bf52b8d9..968257651766 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -354,4 +354,8 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
 		util_debug_func_t func, struct bt_bap_base *base);
 void bt_bap_parse_bis(void *data, void *user_data);
+void bt_bap_bcast_qos_iso_to_bap(struct bt_bap_qos *bap_qos,
+		struct bt_iso_qos *iso_qos);
+void bt_bap_bcast_qos_bap_to_iso(struct bt_iso_qos *iso_qos,
+		struct bt_bap_qos *bap_qos);
 
-- 
2.40.1

