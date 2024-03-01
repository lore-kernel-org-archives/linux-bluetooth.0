Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C253A8FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305244; cv=fail; b=X6Z7oJKFz+NV6o+z2fLst8h2lpw9on60eAvOQnQpdlCTbj8hny2OxVwNucQhaX9D1lat5nQrI6Y7Y/cLO2E0gq50R6aYIkImJlLH8dzXkmYDQPIj8cR6IMRzf7MLo8FAdljbAfJ5Ts9sMinZ/eian3kXMX3PD5PpmONr3Dc+Phg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305244; c=relaxed/simple;
	bh=G0ApxJKqEdsmqRQek5FpK8jEP+SiHXemOgK/YoaKAyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUjWmnzhCt2GLpodaIeX0uL9eTikyqZ3B4Av4yM0LJmAQRubLaSc5/Zk2pmc+UbC7N4ohxoskDGQ3R6S9SFmuS1ayP2dCQpc0SsT87jZI+vUDiB6KWiMfx15d5/mnECnjV24WtlqC5lElWhNwJcJCF3a/pyJrTSNaN5B6HPeJyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UpPKHLvV; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpPKHLvV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbjYoBGT5RlJgQoNC57V575t/KYQ452hpvIIKnucArKod6Y81ofQ2Aj9tQxccUaeMjIWw01gHMOLiDfYEKbgMB6hgfY1IlqQtb+6Mmha9PLyFXh+chVdNtmIevRKerIMED+ZFQ4P+AW6w/PvrtUB8lP/OIoWyBhNvX1VvKQ/4q2iEzFa7iEEkJKqIcVEoubPyMGjyFmCpNAr8VAbXz5kMCvZdxleXBzvEfS3N854tzdk6rcNTAOwD1LUsp5ch1qII3Gkguz2iT0EcTIq9f5VtgUOiyM0I1pfTUgjyiLrUC05UAfYCPIePT6sgAaEEqbmC6FcSAFBJMDaHw77IwvbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcT+cC31PBJwlNnSj/hC7KZanpB256aIxem2zdG6PS4=;
 b=RHrwBYGfR8yJTxP2shvhigLO21eDwk/L4uqQue5RE2+qaUvOJsz9qlle93AMaMghez8ezAy4tXsdTjClRZ8azLwUwI3aAG7nUrck0gR05H+euBSjEsN0Id9WHgSnQ3bEGQp+dPBdjrwoL1U6Ww4O7xeD4sWNVH0d5ZCLrcFPImvhO9ZGkBwH0XYorHhCCulHyFjjGd756bCfviL0AEKKI660orgRx9pyVMSB85E7eDdS5qxqejUt17nwelnEnzSMeTtRbyqH/1ZivC8OPxyq/8P623Pn20skBO9l687DiVHvsc7v58TcducvQakkbM9KAT6KjlSas/mdZvisJEUuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcT+cC31PBJwlNnSj/hC7KZanpB256aIxem2zdG6PS4=;
 b=UpPKHLvVpITOguL90FHgxCszfqn2qFqEr6dUyour6FeqPJFTZJMr8ByMnSml3EGg7o7yRk92QiDH2k3RwI1GZzN3e7qDLiGelfMz7PW5QR7WCD3bePakOSFbKh0X2JSLgOkVvvmVhmXgXoB2ChhOHLv6jyrFk4p+r88kQg4sAjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:39 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:39 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 2/6] shared/bap: Allow reading endpoint metadata and data
Date: Fri,  1 Mar 2024 17:00:25 +0200
Message-Id: <20240301150029.14386-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::13) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d170d23-ca11-4846-c6aa-08dc3a005b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/XQl9DyiFgnsiWvDPYI4v4sYEbmmbIZP6x0+k1EfSjysyDGoK1Vr21Ov7Xwyh/k0M0USLFC/Q5leZNBHi49pqrt2PYd2vOeUQYC5srufodu0jhfveTXPHKYATAfs6pl2OKftD37rL+egSh/KAi7Xnbpq9c7d0033941kBWe16i1VDKX/5vYO6mjbF0pzLqJ37q7KZPvHdc/iaASvXXXml2PFPQH+LjXY8DdSOLq6OI8hugR38CiuTiCnhlot9j9oT81YhxEG3M3+xOfxLCum2lYbK1VWFQ+F0Cl/hsj8SaS3y73B+qmM7dhYdJMkaMzPckuxR16lOIAXgz9+JWI4+5HDTxb1zQXBaHWChG1o363Oaj1lyzyyqDB61fP6R33eDj7PuHIrdmEP39fp0zoyTq5VUi7NqemEQh23of93AHHrNZWJ52E50vXHAOaOXD9q2kyBwmJhh4UfEl5jLdQihqRTqHol5IevrfNdaTl+/nGzlAIBOA6CkYiua63HhAazxge1A+QtVuMuf2lDv9Kl8Mx6vt0trMmHZ/SG/+/SH6tjxmMVkubGEgGaevVD7TtEVEsOs14zLhKMIKUSnKX59KAzH8R6FSy7A47zF0Q4xe6AOjqKBxWEUHkOWjAzxPYo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sdsol0iJgUWddKEXZiaWPc6l+M7emd6rfzIdj1KOFtXGsmNcRgqtMLK34tFK?=
 =?us-ascii?Q?a9sZxGOuC5sCnRUp5i9p/jMqcE1FsfWvsXWF3iPLyqqGcGtmCmw6IkblYf2i?=
 =?us-ascii?Q?ADlq6JloNLb1R5YMqDr9wkzaOAvZBy85Ri65Ipm+HKsEggo6I8RPVmBhTW4Y?=
 =?us-ascii?Q?HR5ZVN0ggFQLKxNGRDBt2dqV6VMHLLffHBNLJuSf7lJwdeuBtmhK1QsWXfrO?=
 =?us-ascii?Q?DOC3GglOG+CgXMgdL15jg7Eapw6SgZthu6pWFYnXZnBQp0CwvfPDWHFzf97t?=
 =?us-ascii?Q?kbG4L2Y7PA4qtlM5g2Oz6yPmnqm9WRt29lKEZLCPiYb8DZKWqcFYwGFV6Ua/?=
 =?us-ascii?Q?DFQof1tyYsu/T75Zr339OeMKaQ7+FH5iO1XUWvbkoOdQnzRyTpG/g/NEErfI?=
 =?us-ascii?Q?BvoSf2ijnbzUdQpEsEl+EDYZG6KkyXggfMmnR+CLNfp1YI9/tAXVa+Cr+R9M?=
 =?us-ascii?Q?X0NhTeCs0N7OpiMOPEIvSu68yy4ybT1tMF/dpst6wwWqXGi3rOBPWqs8YDz8?=
 =?us-ascii?Q?u7P/c/aQkuzuAgAErq2eLsT4Ks+u2wYDt99KPlpn7D4d1Cf+wfk9j1vXbPoN?=
 =?us-ascii?Q?E/HHN6Ji/OC+0h+witzpk+syBmvU8EheJcXubJboN2y1v2d4TF2te9gNA4ho?=
 =?us-ascii?Q?bqIa2SiVIPzNorm1pulmZkibkpyyY+54WTaqK7aj6d6DmoJ/5szSZHhAphP0?=
 =?us-ascii?Q?oYgbAAMp1gfB0FFgmVJSOXdAuLnHVdfK4GCuPz/695ikFOA7EqtWNPQvsAdK?=
 =?us-ascii?Q?DEc/2yTfOo00LhxMMqgSrHmTPfLyGT/7hOrlznygvKSE9XkckdCGrt/WKws1?=
 =?us-ascii?Q?Eqh2xmtCzIVUR1EPyZcMGS5lbsOoewUjlqDPEzgEFzrjDZuVWeNjJ/zmcfYX?=
 =?us-ascii?Q?JeZyEZtdIYa4rI8nw9m6XgfjwBBf+6s34KU3evVHO1NSn5bRVvIZHjmlI/Od?=
 =?us-ascii?Q?WVQHoNzQpX3zYuCduOv1Y7enZjvA1gRq9t4VPzgDHz3eagsmZRXpJF1l1pS+?=
 =?us-ascii?Q?9oyPvELdNYYiUYyKzltOwvbGhI38cVggFV9DInkNdlI/RVPYM1SXHDZsxfTd?=
 =?us-ascii?Q?pAa0oUN8cgbRik3b7nspArJ4bTvP6uGMSbUZuVhJM8+0+nY20yPdYTY/XGKd?=
 =?us-ascii?Q?bBmxVFQGBEJX4GEe7E0Yrkt+5xxIjTAHVV+Sk4gqAb14xEGar09lIDD716Xu?=
 =?us-ascii?Q?ugFs+eNVIWqODGlSma4pHQwzsr5B+1w/4FGlYChmv2sf5d27gcMEu+tpjz75?=
 =?us-ascii?Q?C3izg6V4eJjxELvbzQ6rAaJtnrhZHzr/iI2JqNeDp8yXfAPKprFO2w3EetZV?=
 =?us-ascii?Q?K6v+VLuH/8MJzT1WbYClJ5ORNns+Sr/ntYGXGQCifYPptRXUC+nXnNjUW8PV?=
 =?us-ascii?Q?gT0+ZXyHRc4u/dkoFLOVCNo7pBgvTrkLQ8pYBptb+IPj8LXR5YyyMoKiWBC3?=
 =?us-ascii?Q?7v6Ajaec3JztLcdF6sFb4owRTy6AFJ8fzypCByl4ln+7DPsT3vqWqWZ+VmGO?=
 =?us-ascii?Q?Ak23qQBvl1WKykaQQHASifmDj8Pz4M03NNiSox+NOwX7bIqO4Y+DIVWzq39e?=
 =?us-ascii?Q?MoL76kKwFTdfcjXi4CSYunXWDH/vAYsKf2Scf2DSqzjEi/HqOXoCrbImh8hT?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d170d23-ca11-4846-c6aa-08dc3a005b6b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:38.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaLjE+Fi+7vVeIKTZOlV/ZkCQp75kks8lqrLvMFRWHpIXEqlDTMOW2VcZNjAwqTleJ3sFyn635u9diuSuj4EAdb1/6oMFRnw4TFTHxeXRC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Add utilitary functions to get endpoint metadata and data.
---
 src/shared/bap.c | 10 ++++++++++
 src/shared/bap.h |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0931c8fa249f..a44b5534805e 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3457,6 +3457,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac)
 	return &pac->qos;
 }
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
+{
+	return pac->data;
+}
+
+struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac)
+{
+	return pac->metadata;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index fa0d4b524ffd..e4785b587e3a 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -175,6 +175,10 @@ uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
 
 struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
+struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
-- 
2.40.1

