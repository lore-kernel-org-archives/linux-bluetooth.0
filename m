Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F762512EC
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449081; cv=fail; b=LI1Ekny7XFqaiui8Qu1MH93jBVCEMWqdFnR3B4V7gPvRsorbCFYsDUj10yjnsI3TXfxTGX3LJ5lIT9K4EfOJWSEGJRFOSZ/ZqHhhCbsX4gs1SPHKVbSqgIxHaOj8gjmtKWW9VWW3n/MIZNKjdZQKELtgwhRF4Qncc0M8hb3pB74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449081; c=relaxed/simple;
	bh=SliWlOEOxYrh8m38rP/aEMPG7eKsEG/PaDNrTme+C48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXqB9U0NzdBTib6OfhiHIk1teCibEiO23grhOMp80sRey7TinfM+TohbIuTNKWkXbJZT+VKYzXWV50bSJRm+15+HHErxs0Ufrc5cfaMB+GqVV2NohHFAFkByqTw924RTc2nA5cya3//4lmOFrXD7we5h53u4AC/iebchFWaPEY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=O7FyIy9T; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="O7FyIy9T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9u5ihNBz7gAiFSWb2dH5TwDP3Z+DVuMDsAAGPNab7+PeBSgFaF13mZPZCQrYY+TyaODu/nzwwrobJbixFDU/nAp8tDNC6ezGrwwUzIAKl9WO4MnNj9fHIE2ibWy8AzVieoyGunM0PRJvkewz3zMEQMowPpVSSbrwtkcrTTlV6p/VFq0wpE5CUJfhe5TXF0UatwpnuSfJIcM4cT0jEvzuJQd1swRFHtwmnnIoXqvBvjxfQjuj9RxVgf9mG0Yc1usPgIXCoGg9TRdPD4R1gVTlsDe70z+5DHDJ48Z29mR6VXWBu6THFi81d/dlROyTM6f9dNmzftDzziw5j5YO5qMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge0vRGuhtkIUONkPAUi3CQ5SFgOwJ+uvYqbWhAkOND4=;
 b=YsBF7aFUUVZ3+VIIf4ddMhYaQ8bnFluJvnl0+2BDfBgdKc0g9OflQY2VwuL+eGWcewr7loveRRl77KQAChJdd4msXn6799e2I8cVqIOBXP1zg+cE5rqnAH21dzRdjSRZfgwU+/Tu1yBA5zcCaMLQnqORUtPAjBfhxSYqRLifcQWfYirm5cLhIIkOcS6tfl9jOl9DeRzshJfP7+rY5DG2J5ICFThpuuBcYybpf7ROiCo08STTdnddKoNIHwf1C2CY7HM7bq0QyGQ7QacR2lhb+8RlMzkf8+UB+F2+E1aKpOoL/F/63GsLZ7pa1hqlXaZry+jm9p+04iTFAwOLdmXpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge0vRGuhtkIUONkPAUi3CQ5SFgOwJ+uvYqbWhAkOND4=;
 b=O7FyIy9TVhKlw8uyqkm1SGuLWXLEctyS6uAoZkXz99K3zPz0tiC+HEn/3MrVR9a8P5t8ZyPk9q4rmbKo9RZsFYk5rj1eX6Fe46Bo0bGYkVa232PjM0W8j4tB6KOoGnYUZgDiuicgim7tw+x87WgSkANhAqu1mpzUNqrzWtt1xYs=
Received: from AM8P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::19)
 by GVXPR03MB10825.eurprd03.prod.outlook.com (2603:10a6:150:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 12:44:33 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::4d) by AM8P191CA0014.outlook.office365.com
 (2603:10a6:20b:21a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 12:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 12:44:33 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 5 May
 2025 14:44:33 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: constify
Date: Mon, 5 May 2025 14:43:46 +0200
Message-ID: <20250505124346.6621-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505124346.6621-1-ceggers@arri.de>
References: <20250505124346.6621-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|GVXPR03MB10825:EE_
X-MS-Office365-Filtering-Correlation-Id: 09359592-9552-4ec8-d109-08dd8bd29622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?koSvXpfp3LtLcFb2DxW9GGFi2KU1gbYcF0ZyZfoXVVzOddO2CQqIBJf3uQl0?=
 =?us-ascii?Q?5tc59CfPJBKzt6fo8GtTNjpLF0clw5Z+vYED3h/DEoN2PiQAx02hK06QEkIu?=
 =?us-ascii?Q?qMKEi16ody/mDiOLZoQ+D0yJkjJCtEdzwjLzgbpRLxh3ht1NUz2Zwf0hGYVp?=
 =?us-ascii?Q?6QPMrUHJNXG/KGATl7hk+nyrea1+DmfEicdB4OERdKEmwpXa1M6OsSRo/P8w?=
 =?us-ascii?Q?Q5WtL01gXMQQCFrImq52OJduK6KXz9wUvVLicq9r8beuWyBfWmWN776HBjRN?=
 =?us-ascii?Q?J+5UfisBnmsHUbxNgzV/idUbWcik+fNHUfYTs4zibGivgf1+aI80sI1OHr1E?=
 =?us-ascii?Q?fl9fShRg1B4yCr4nxyxznkoW8qoh8KnuRXR3OGbiba3FZrJWxzwktZuNdAg9?=
 =?us-ascii?Q?1t3f5m7QApTxO6EWX0Dhe4OBJFnUU9OdPFNpYTnJH+Ty+IUzVUfLjltCXLbo?=
 =?us-ascii?Q?8aaQxm4Qqf3CmsMzycM9xDbwXFiH4zA1EHuAYEA3fCrFnA1IwSQkUgIyyfVB?=
 =?us-ascii?Q?5mJ67h5yTHVm59Tm4SVJksKbeKrk3fp+ieNovfDQzZ9JsPYv6tlMFTdqVZE9?=
 =?us-ascii?Q?w5zqu2M+zP7XgMfpXWeQO93LErb7wZK9Ds235k5NthaMf5DygRsrVWRpL1V+?=
 =?us-ascii?Q?X7MiaO4rMAaScs3FxVce/+BLmgetVNLCcxtfA5D42BvUs5WEdIY1UDa7//m8?=
 =?us-ascii?Q?ykgTn6IBw++zp87clkuKmc7r71rjBQLFBD39zx+9pubWWGd9+5pEhi3CFQPH?=
 =?us-ascii?Q?b+BT/ofISdNG8b9Lg9FwJ/MHxvKSA2FwpJTeqnNXVp1/vVvbmV9cwWdFeFm3?=
 =?us-ascii?Q?uwq5nNKlNuLeWAfoMemZpJzefuH87UfAVmjozfL/Q4aqJCRdWq2QOVx20HRC?=
 =?us-ascii?Q?5yRooFPcIQKcYRqj/tFz/VeFV39DRJG5huratl+09nbGlnm1q7Zp4zSaqZz/?=
 =?us-ascii?Q?PcDJ4tD198ogNzMk5cC0MmyAbyAtfp1JfVFz7AOhdr+kEk+FJBn3GnKtoRRF?=
 =?us-ascii?Q?5JgqfFIHnbiqr5/DOC0Bacmtym9bMpDBHwgVjlas2dYvHAP2DThhGe9mku0F?=
 =?us-ascii?Q?koBEolknmMWEJP1prRvTDLqz4w+9S3o6/oR5h6zTIIbVKtamv7TlHrXZRDSR?=
 =?us-ascii?Q?04EG3IuEw1oB74KZibJ+mQ0g8JZ3AKpO/JCWw4KTTYXLzI832oAwPJrpZ+iu?=
 =?us-ascii?Q?oBETVW11J4Sr9THKoo78HpIKu/jlpqulfNZ6PzvcUXh8AtwvcxOBkbOK+8Gl?=
 =?us-ascii?Q?RFKdtaKSHxJ+Ce3Aoj95KBDnmBHLsA2VJ7GqYx+3xpFVmYBKmNpbb9bwMGft?=
 =?us-ascii?Q?zmernrRkEeyH3lyEfa5Onb8HHITDM//77AY2ZFtLXzqlfI6NjspYjC9lVpFw?=
 =?us-ascii?Q?yZ3NOvvuefL8Omjoj9jOlibK6ZmZGfodJBpN7kPji6j1l0P+ePqdpMkKjcz6?=
 =?us-ascii?Q?BT1bS6Ql62CkCeqR1VfBX0Gb7JHWtGknwjTo4jtxoAqp3vhF9c+F1XgAvUMv?=
 =?us-ascii?Q?0GEcDfMBYctH4U1In8xncWyscY7yelD3z57F?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 12:44:33.3571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09359592-9552-4ec8-d109-08dd8bd29622
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10825

---
 tools/mesh/cfgcli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index fb6fa666d2db..8801070ec41e 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -66,7 +66,7 @@ static uint32_t rsp_timeout = DEFAULT_TIMEOUT;
 static uint16_t target = UNASSIGNED_ADDRESS;
 static uint32_t parms[8];
 
-static struct cfg_cmd cmds[] = {
+static const struct cfg_cmd cmds[] = {
 	{ OP_APPKEY_ADD, OP_APPKEY_STATUS, "AppKeyAdd" },
 	{ OP_APPKEY_DELETE, OP_APPKEY_STATUS, "AppKeyDelete" },
 	{ OP_APPKEY_GET, OP_APPKEY_LIST, "AppKeyGet" },
-- 
2.44.1

