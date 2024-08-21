Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813C1B2539
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252194; cv=fail; b=uO96X88XrliNM6epiHjFUI0Jx24H2j7YjBizAnzuCxXcRSog0hJ0olGzetpjIo02nuzguHEX1Ne5oSVpG4OwwOIPEqXeUXOIGk97gjwgGtbYoJvv9VX2PIm66xt5oFECRtzPIslTpD+J0Dhm2unY0RsfofDg54Rt70Ty2gVF104=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252194; c=relaxed/simple;
	bh=C+bdOP/CtooUgzeUcN/4LT8YfgOda6kM8lHsJU1XzfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1MLbB+HR3TTc+bwMBsXlkdhAZrCQSOsEi7HJ+a4GDl6IAZ31+921VPV/Q5vv4TNYcDyXNKP2v72liT4ikkrijvNHPU76Tyj93+adVr9uBMwZBHb8CNUjPWtm5mCT+MBIcf3lOIyFd+KFJg6Kl7tTphZGBzUt8YP9n3ba+UbWAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dd8ncMwB; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dd8ncMwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueyzu15Cl3u4herEt/SxpM9wve397hGJ4aZZF7+6sh3j08+WxCF9rZaZxarOhp0lliXzMOxdF6GbSNEyvHN1XK0kwphdq+3tgAZcLVraHfSq3h9aCNIjUtl/sQfP/m14Tp338u2knyarOKDdvEDrkjlD+LA6TRm0b0m2A+f1ofYZYQlxGJ0QCPfZKbZ1UNJM8Wy5/TEeM0ynwek/Z7gR+36v5YHTLvEAZIwL+1E9xTL2af7TsGP37jOzBtST3CsycmF7h16qtTCqqN9Dxx0gYEvgOQdOwgz5FcQtTx49u9HGuplq/imi/ALsNr1r7FcrmCo3/L1kzUn0K+ixunOiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gsSC/ji0e6hjh1/rymHMqyQq+8WSJuERiuPNx6S7HY=;
 b=YjeckLP/hlt4Te7hJgaZfoHQM/Jg9yGFKCMRbsaH5Q8yIl3Cyg5TXKHvX+P8KLvdClAroWVQa3YiE/venSCyGgBe1Q5WAw5b988usBkC6Yvh+NMkemz1R4IzFVajW8Wafhw7vH74NLItCRvAMms0oa1hql44uMMFiJJh3fTW0YQmfX6WL0ifo3SWP4qD6Etmfd2XtKzAzxnuDJjZ2Gddh4yTw+IdYBRjyxinpmiBl7DeF60pegGfNYCDFi/nPXq80PdMvrdhtPMYWDFZNhzwGEjyFRw3PKDAxgx1484gKwCNNXZMZSEoDhveDGfFBl9h8B3TafoMPq/XPJYUZSh9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gsSC/ji0e6hjh1/rymHMqyQq+8WSJuERiuPNx6S7HY=;
 b=Dd8ncMwB+JBMMkb1rdDrgwEeltZNHLP9OiF5to5EMXQVQgkd5lQrXW89xaIHAlLWcL3kk9FOZWSq0UCVQx5SHd0fQfpG6YhZ6h3sgcvDZpRAdirD0EViklvlObAk1HPETlzhmhApWII0CYDeZtzWZwpicCtc7KkV3k019kcLXqlzy290PdgoNfUX2bONVc9QFWpfZppv1jHpDxu5yhDK9nF5ToFUHhG9rQg6PwA+Nw4XaPZZQnnFIj6UncPupy3hs6906eoH6uyolue67jnOzPzX/ifCA52kEI8uQkzNzNKD9SJTR/yp5CqiYsY+wpS8FG4wFUTPxIfL3iODbsfveg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 07/14] shared/bass: Add API to set PA sync state
Date: Wed, 21 Aug 2024 17:55:55 +0300
Message-Id: <20240821145602.92083-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b45df27-0a2c-42e6-0ab3-08dcc1f17116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y68dghuhhlzVk2dK8ATH3SAQZhWTfebWBDg8f/DKAgiEC25ZD2luSK3UvA0Y?=
 =?us-ascii?Q?VSL0yztxrQFFlSH2N/yh2m+nPMMkglYvFbIQtm+wMe/EZJvQRlhEcd5nhAhT?=
 =?us-ascii?Q?yKzlBG1Rw7amFz9RVP3fePjg8dxo1pxVz9iaxrIlnxsvQWnMo7fpbj+nzCXB?=
 =?us-ascii?Q?aD14MK9MHy+ph+T55Cs2WltLe4GrYvMCOo2GIzkP9UhBSxiYg+h1Yx0GUADP?=
 =?us-ascii?Q?VJYc5YbIokXXuP09eLTgtwYEJM5Y31ZJYLUMoSCzcFzWhuNA7DIBe5QZA5yx?=
 =?us-ascii?Q?sU/mU7wk27FO1qm131/y27gMkkrD1w4rEIxPUIDsuhCconCvyDHOrXE3RvtK?=
 =?us-ascii?Q?EUPS0ThCor4bfJvD+8zlH30LCrSfcEUi82KVBqICQ//W3moWRWyom8gWIV6Y?=
 =?us-ascii?Q?Q45tQW3rmewDPF1fKZsc970fksss/wZqku6pCFXD9j5/WscWH6REHSqU7S8o?=
 =?us-ascii?Q?Ebx59csbPRPgZBetgk0KYzB35GGdCS/74UAhwQog5z9iqH/BUr2XgAaKqfyZ?=
 =?us-ascii?Q?MI/atnPChAsc/aKDG/V9U19oaPQkDakSbL8PMujUQP2kfXdoCm116a97NFfM?=
 =?us-ascii?Q?B2OkIuaUL9w4cxrD1fUyeJNgvq4z+np0/RdbOSVtAKxbBskTEZ/JwAZcOUAo?=
 =?us-ascii?Q?2eGR3oWwqO3AC6GrPzsD71uNEm1fzmVcz9qVcgTLeHSPkvKW7dsd93Im1IUq?=
 =?us-ascii?Q?qnsQ1wtafeiNIjvwPUcaSqTDjlkoSnJjWbZgfVE3oh6MMFoMoVb4KyHx0vl2?=
 =?us-ascii?Q?E/SCZMyEguZD+gZQqNlQPcEf+2cdiNKA6CpLBJeKWX7a2dN8ycdGwkPjQtOw?=
 =?us-ascii?Q?y14PR/JEkHylroQgr+2EorI5avRIAi/NrCR8bC2bw2oUqdnJn2gWwJQ1qF4x?=
 =?us-ascii?Q?lbVZeEcsI+Il2tfAPfzm9WJ6s5Yd2btDV0N8nLPSTPeiMLx2YaCO7aUCj3il?=
 =?us-ascii?Q?VxfPexLCdDAUEbVpQ1BItLb/0x1l4lYDoeB8cqDw/O6y/lQoClzpJX8d6MUt?=
 =?us-ascii?Q?vonfi7wVrHvP4Kb58r1F29+1fCjppcEA05vVSOTwcM5PFFJTqX/qt2IzSNA6?=
 =?us-ascii?Q?PuCHA0TxKRs+QuBtFdcNFJIUTn0yLvMwJw/GQs2skMttNDDyMxz46PaDaCJ8?=
 =?us-ascii?Q?0eRp4ZvK8iUbAK/RdCdIJWTMu8XgwTGKA5BmtKyDztpqjjft8qWox7Y6I68U?=
 =?us-ascii?Q?nwL7i1OeuSEUjydnVfUS/RvXKpPQvPSKDZSqpWq2s/JAsML13QBgVvx43jSA?=
 =?us-ascii?Q?faIaymeq35gOzQjJqtpsKERcGZlLgi1eQsCrH3Px5S5LgOrzHU2L4c85/NhP?=
 =?us-ascii?Q?4pb79NI8bl0ioeTv01XJRnF9dJC6N7XG6P8EUrm0N239EQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ppFdQ2ITlQyZqRomx291qXRidASYmMJ38+UjwLfpmo8nbvPT9LYmtVecHr7D?=
 =?us-ascii?Q?U2EGqvUofZZhILAw4dhliQmZEetyEdiyDdov5J62ueHUfI+LXMOyZAT6sg/f?=
 =?us-ascii?Q?M/zkUN1N8jR3dxRrqYKRxw6g+yWNCjWEP3iB54QzrLd28MymFmgTNxZYkxjT?=
 =?us-ascii?Q?jZNA+BYEDbf5JQ0l6OFgH+BRs54kqJ31yJBqp09P7cnxMXH1x/xShZHmopQ7?=
 =?us-ascii?Q?74L1ZCNUb6TWsOi8vls7g6mGWrlMpJsKYSd+kQXjmERg8xetssGfhxDrYsmr?=
 =?us-ascii?Q?Cg1FdApsc6qZ5KExrgva6lmX354KDVR47H7e63YMHP//OcdMnJ4WUAPWqQes?=
 =?us-ascii?Q?i01KHIAoT6VixZBp01KH47zsJkVUiFn8J8FLEPHp5gTHLoWcQlG+4JUJH9Rg?=
 =?us-ascii?Q?0jgaQReExLx20xJEk6xtTY429HLgnuPyKW20w62dy8e/OK5Lxy6TfPgD2JsG?=
 =?us-ascii?Q?KBpM1YTm1p1xwM8oNrOyFjrn83c5bzPGGR2azfWswSPRF8PEfYtwkdw50a7+?=
 =?us-ascii?Q?iVSMrX6ttA9x1DvJ7KqINw7ZJp0mhWpCiKG9j9NSafo9pTWgm5OGZLPUncpe?=
 =?us-ascii?Q?Ra7O2zNNMQCCbRuKGz7kFEqCKLMwGiqjbpd7lPFzs+VtnoUTFlkeAOHKZTJp?=
 =?us-ascii?Q?IvWqA8TW0ig/OsQa6MRjzItlVYsMLBgS6MKXoXGH7jkqZpc2ScukCc3T8V5f?=
 =?us-ascii?Q?tTOZlgyxK0GpBZT2gY7gcGlgnBfjFkOoHM+PyFh6QrcglBSzgDqZY9qlpaGE?=
 =?us-ascii?Q?yauG2qVgLGFVs5VBmj/2+t1bcVTzU83PnnmENey9txEkCkqtBdNxD0MPhSaZ?=
 =?us-ascii?Q?8xxif/p8/kEWjhIrbe4+kkqJeLPsSw201ccfWoVwHs57ZW+mbD3EJu2nOInF?=
 =?us-ascii?Q?D22IWHPc8aZ6AVvd/5I/lj6FnOhoDYWUr5/DqQYNs56IF1sjNrVTmVanNSFl?=
 =?us-ascii?Q?EDbNJ/8XP0nETd3VMzK3WdYAnY1XuSkTc57cNMU/LT7CdcUchj7QQ9Th1wIT?=
 =?us-ascii?Q?BKwryCKmlfdKoKtu5w82glMPkB+9DIMfOGdr1grLkwa6hWXGAcx+GLtuaq4V?=
 =?us-ascii?Q?LpRIoI/B8ylLCLYC/MTcUDQRdwN4LzEOzn/7Ct+4Uk+DDJrHh6oFzA0VyJJc?=
 =?us-ascii?Q?8zwgmnROMEMO7FO+UFrV5/mFs58nLNfcwvbArr84mV3TohkPSHn5n2AULfD0?=
 =?us-ascii?Q?+GGpyLvgMrlkiEEL864SXFVO5VgtUtRdXPcoQM9Qgmn+k5z8LMZ9u482F1F+?=
 =?us-ascii?Q?o4C53a2qw5YbQklf/IjlP0mMS6V1mRgn2CGaLIz4GcwCjXCitsxcbGOeZtCN?=
 =?us-ascii?Q?h4cLar+QQrASRpx9KDzqryiHKDrc5ShkbC1aAv9+a+0y8Mbygt39AvDiuSAE?=
 =?us-ascii?Q?7q9DHr81wejjzr4KGQFXxBPaFHONrVoS8Fm047viDQRpJA2K465qj1hwNsiZ?=
 =?us-ascii?Q?zk6l0GLxoFvXvkKABvEPKuaxllHtfoUeJsMiRLIya+nXfynMR/7W5HPPjAGl?=
 =?us-ascii?Q?9z5q2+WFih12E/7kq9R+0nwdjaXQMM77irHi63uvw4EFS6o0dH4XcQJEDaIX?=
 =?us-ascii?Q?dUbKPF9jqR7mxntXHzx4VpWmeQVniL8r9nSmhBApy+jkaNzHmyGY1hnxQ/SF?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b45df27-0a2c-42e6-0ab3-08dcc1f17116
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:30.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BhsibkOpkpPBp5MDpX0qxLe1pLof632JNatrm8HG4+qKq7+pC0N8AGcRrGxMXZNW8uMDxBHl6Pjtpci0c+2iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

This adds a shared/bass API to set the PA sync state field inside
a Broadcast Receive State characteristic. Notifications are then
sent, to inform all peers about the update.
---
 src/shared/bass.c | 34 ++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 70e747700..958b6f788 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1732,3 +1732,37 @@ done:
 
 	return err;
 }
+
+static void bt_bass_notify_all(struct gatt_db_attribute *attr,
+						struct iovec *iov)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		struct bt_bass *bass = entry->data;
+
+		gatt_db_attribute_notify(attr, iov->iov_base,
+			iov->iov_len, bt_bass_get_att(bass));
+	}
+}
+
+int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state)
+{
+	struct iovec *iov;
+
+	if (!bcast_src)
+		return -EINVAL;
+
+	bcast_src->sync_state = sync_state;
+
+	iov = bass_parse_bcast_src(bcast_src);
+	if (!iov)
+		return -ENOMEM;
+
+	bt_bass_notify_all(bcast_src->attr, iov);
+
+	free(iov->iov_base);
+	free(iov);
+
+	return 0;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 2ca659cca..a82d8f573 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -129,3 +129,4 @@ unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
 				void *user_data);
 bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 				unsigned int id);
+int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
-- 
2.39.2

