Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD667E69
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058222; cv=fail; b=PN+zhSduqQhQk02XfQ/09lOltj8UF3rD2KwkLoRMhBp0zmFnj9XSY+b/Xyb+IPZl1fNl+htGysWFuFZBU9/QQzchiW7UCDrikomBu3cqn0bzD/wOsSXKi2uRCE26HuI8TORdJeOBkfP8UCx8/iXQCjWBg9mtad0ooVxvCjRWhK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058222; c=relaxed/simple;
	bh=8CcoRR6WEcpcLuRsAo4mKv7IY20mi8KKLc2YW8hp5hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHFOUiPohZtLZmdKqtiSChBiPFO8ZJYYOmWTvfHYK2BMsTbXmVTRAB6ZWWCCiECVmhHjZMHi6TSyMi4E01Pyv8jUPvT8FBzsBERWN1YeVw6qIbB2OqaKnl4nbgAPi72wqaLPR0PlaZi0XOXFojq4tb8B06EJIa190DlqBj9CgS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wt36CN3M; arc=fail smtp.client-ip=40.107.7.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wt36CN3M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch5UPjQNjqwH9PN6NSdrW7Y9xtfO8P8b2DbGUehVQaiw4//4XX6fDaXI8peUZvfZTemCk5ssPpcZIbPuDL3Eq/alvIDeKXEsBHm7q1vE6EKmbD0AjilsaMgeC6YZXItwcXHKdQXrOyad8q61kkxITnznUEa4xtC+2pKrC2Sv86ymyQ9ZNT6HL05MbpR+fa5rydsy6Hwtil8e+uGwsjdS7/efVXuflVgEM5cXcU/aZ3KY1AgCafHnomvkO7He96h2WU2OaD5FclkdXEcicnBC4m8eV+kLzmQmg0BV2omFHcWa863CCVhaCffL8Plnz8Gl/6vzLGdbeu1tau8TRJT8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34mNjN4f6XEXOBVPsnxyX1fc04oP3c76IhIrKYx4gGE=;
 b=gRi3ehxOXoPPlvRPyitnqZZGWrSWkUH9iDDsqrRymhy4vbMNXiP8sorfpzBn3/gwveqDon490gYJmAPYr10PrfG3eLWF7cUJEXcEAroxz9m8RQ3XBHx2dl0VqHgoBkSPGIHnhRDNcOQwhM3oAvKeYC+bpYFdsPYz4l6YcPBUvgHjbbwGyJg60qR6gFPMgLQbDZwZae2fu2oPdPgYpnqPDCgQR9j5TvNwgbgKHfGAAERv+NuPiuWsqFpFD91JDQLQ/iflwEap/xf/Bra0d2D+nIOXtb/bbUD3F5sA7M9B2CXU1vbdND1+5076y4scyZ9f8TPOsaVus7lCF9T/wCYukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34mNjN4f6XEXOBVPsnxyX1fc04oP3c76IhIrKYx4gGE=;
 b=Wt36CN3MUUpwkQUrnh7w+8/0XaTiFW5Oyw7r5sXry5q1SAUAHssNvSt6ZA0xBaD+5sP/91BiTG61M21LtGKg0bdqEo6vCb6X3tio425Y04aVFk9YRjZigstRaVAcQcjDMxLhyLxGvH3u4g02pue9tlXqjl+WotIiIWan9+/G1Ak=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:43:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:43:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] bthost: Add support for Set PA data
Date: Tue,  2 Apr 2024 14:43:25 +0300
Message-Id: <20240402114326.3330-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
References: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/8yN33WTX5LPjZ4JOUuyXp55Vho3LA+KLvq+oNy1DLcYf3BGpG1kyD0GjDsepRImWkWo7pCKaSFRSyKZYBfTtUbt52MvAmG1uO5mQes4APkxTbresFLboWu/TNcAc70YceI6TXFP3Gr9I7pRxqu9P2uylsOzK//Fp798FBIUUqAL1ixX3mnYi8HgAzIma+xriqof9gLdS+Xzts6GLfVLnvPh2bKURfAv5olXKIWVf6hewMiRVtN0yCzRRzOGUH3PPUuf9w2dc3zyTsvuEdBkA6C2J/JhbMpeGdDrcYD/Mb09W6WvGumbef+FNeZVu1vkoP8/1/RCm1bR+LVwu2t2dDklLtSq+s0gIC32DQlhlP/5+DSPT6YTRqTvW+05uf0AH6JVbcfTg6hJ8fjRabdai7MXigp6oWfx4Sn3dbkcJQZHVPdeTvLQy0JnZ+uA3pabTlWEP6X9qNsqAaMweO1eLLH759cWKGPfIuWbwF5DwWsz8k+59ZTMYw9z2Z+ih/io8hNfkWG5+9UYTKopdenwS7N70c3fVO2KFUeb+kBdn+/CeFfDWdMVJp+egEK35fkRtNoJgSL9YYs89M29/sW+rM4T4/RcqFxX43iiNcdv/DgtKiTmjiQj5CwfaosMOm09j/vza4pC152DKIkEB5fjbhNuV2uHE3SoWv4S709dME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5kvHWofzMbh79cFcqL9l5/0PfGGvHOizga4Cfc7pUK/WP7yWdTFoA8ODqp1v?=
 =?us-ascii?Q?vfj17dUF/wfYKguITd+zab5F8VRdtGpqYl8ByZ8FOFe6jb1bB9E3iRIOQKRU?=
 =?us-ascii?Q?lRIMlCu9tzsWsLIjg2G6SNS+03nAX+69emJRKONOri75on86pYSZ5HyngA0w?=
 =?us-ascii?Q?zp2sB2oAaLDnDciESfkvNw5jUMFw4hLZ/rYahwy01PMhRucwfUPXFuxHP+3L?=
 =?us-ascii?Q?rq++OrlZThO5LWqUiNgjpFz6SRqoXtqVRfVd31bNNuw8Z9inVZv7dgClKhhI?=
 =?us-ascii?Q?0WncbsqxdPBPnuS0Rxm2bJ3aT0pq9ZrfYvQaLzf8R3cYgtGZ4uUvjku9f4DE?=
 =?us-ascii?Q?Lx0qOSkJ+1P847WiFdR5OJVcc5hQzvGYeZ8JQ+Veo8dOLYewpVAPoopy27+r?=
 =?us-ascii?Q?Wa71THlNK5LPonG+x1B40JN4QkUklHlDYcdTZji41MXLwi86hWo0ShJXOYN7?=
 =?us-ascii?Q?9ebbh6OtJPIByQ7qrHa4moY/11invdRMXW6cSKLFk6TyFO+4zhFe1QYXOINI?=
 =?us-ascii?Q?MQWdw4vBsDkujhoVlOA4icYBDO6YLSnBWt092jL+ugRk27w06q4DAHZ9WvLK?=
 =?us-ascii?Q?yOkh9uwuO0e2WqfFRPpwT2dzORcJkDLdhgytRJ6KxH02wA6O716y+SgLr3af?=
 =?us-ascii?Q?fGchgAOnz+GvT6ysPZnnrHcQg/6xnaaHmYcF9T/l4hQ5cs27Yp9zFlsLSO5z?=
 =?us-ascii?Q?CtJMICAj0E733Gv/mhqGZh6Yq5sgi0RobDdXTdnWGgQQRKzTmu7jmmwT+J/b?=
 =?us-ascii?Q?VfuVjF/GaXEn/uCrBQuMquJVwIaL4kkCZrrIDuC88nOjtvvcke4lD7t+B23M?=
 =?us-ascii?Q?QSG5LVnJQgskJwJicxP7bn9vd8NK5x6RrbftuUc/nzZ0CdNkVioHD5/OBrxf?=
 =?us-ascii?Q?Drs4Pda6sL1DT9Q71JLx1J8XAoKqcVqK68Dhz12nxZ8zNRMumkeFbfbMRHKh?=
 =?us-ascii?Q?N9U0NoI9lYDTgNDObwcRs6OOm34+H7Ps2uLCqIkvszQBvCM9KTc4A4zDbL02?=
 =?us-ascii?Q?NZrn0FogWz+Y8UD0AfYivbO/JNQ4xLEF4e6U5fbfutqz9voeKYpCZdMJIB+Y?=
 =?us-ascii?Q?50QhCFYgflTLfEZv7FEviSudFFLroaRsJ255yOWF1xO6EWhS7wGlJeVXGVjt?=
 =?us-ascii?Q?0VQW5XpdAFgtHHxWVfdwyywTIb19b0x6BGgBIERYWu6zAJNsbIRf5fhKFRDA?=
 =?us-ascii?Q?6JU6XNewydCqv3xdo4dHxva/5xIx/NRmRIHPAtZ8ZarD820cB9h8SLNf4iVX?=
 =?us-ascii?Q?3TP2fhuAkgc1xfnyjzlJuZmXUx7HiNZESModvr5w7vxO0mnAvjvtXwDYzJ8F?=
 =?us-ascii?Q?DaxaIXkLmZ728asu6Ow+2xj1rdpnkA21yCptLAdSWKw+PHpKJJMFZadep35G?=
 =?us-ascii?Q?y/sXuh1ENyFJFUFRucTYCgJIlOz3ZSr40eILYpmciig5kTBrzGkqajTdJzxh?=
 =?us-ascii?Q?KLM29FG92JJid0/jmbNUU4FByTzlx0elRpdhn/TxnMWuaaUsbEfP+bzISgAj?=
 =?us-ascii?Q?/yl135NKA/ECClYpIiK4sQvqkTvP9njOwCKP7h2KYl6JVRSzspErF2v8LOR+?=
 =?us-ascii?Q?gpv6DLi09PJYMSDwJU/4gAewSJtF92XzWG3TNo2udnen7b/qiF06QU0nODmY?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe044f5-141f-4b06-0ebb-08dc530a2361
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:43:38.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AANPqXA3dyPekJ2VDHWb5CEODbr8vwetntlpna2yc7Vbu8RA8MPHWeXGFYPx9SFA9Q9AIBNIwaGf1vg+ffdSRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

This adds bthost_set_pa_data.
---
 emulator/bthost.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
 emulator/bthost.h |  4 +++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 8c40fce90..d710f4982 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -3127,6 +3127,52 @@ void bthost_set_pa_params(struct bthost *bthost)
 	send_command(bthost, BT_HCI_CMD_LE_SET_PA_PARAMS, &cp, sizeof(cp));
 }
 
+static void set_pa_data(struct bthost *bthost, const uint8_t *data,
+				uint8_t len, uint8_t offset)
+{
+	struct bt_hci_cmd_le_set_pa_data *cp;
+	uint8_t buf[sizeof(*cp) + HCI_MAX_PER_AD_LENGTH];
+
+	cp = (void *)buf;
+
+	memset(cp, 0, sizeof(*cp));
+	memset(cp->data, 0, HCI_MAX_PER_AD_LENGTH);
+
+	cp->handle = 1;
+
+	if (len - offset > HCI_MAX_PER_AD_LENGTH) {
+		cp->data_len = HCI_MAX_PER_AD_LENGTH;
+
+		if (!offset)
+			cp->operation = 0x01;
+		else
+			cp->operation = 0x00;
+	} else {
+		cp->data_len = len - offset;
+
+		if (!offset)
+			cp->operation = 0x03;
+		else
+			cp->operation = 0x02;
+	}
+
+	memcpy(cp->data, data + offset, cp->data_len);
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_PA_DATA, buf,
+					sizeof(*cp) + cp->data_len);
+
+	if (cp->operation == 0x01 || cp->operation == 0x00) {
+		offset += cp->data_len;
+		set_pa_data(bthost, data, len, offset);
+	}
+}
+
+void bthost_set_pa_data(struct bthost *bthost, const uint8_t *data,
+							uint8_t len)
+{
+	set_pa_data(bthost, data, len, 0);
+}
+
 void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
 {
 	struct bt_hci_cmd_le_set_pa_enable cp;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 46781365b..f03262d46 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -102,6 +102,8 @@ void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 void bthost_set_pa_params(struct bthost *bthost);
+void bthost_set_pa_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len);
 void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
 void bthost_create_big(struct bthost *bthost, uint8_t num_bis, uint8_t enc,
 				const uint8_t *bcode);
-- 
2.39.2

