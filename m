Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519F19E83E
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Sep 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545644; cv=fail; b=O++OJUq2yZ+NYS5QJIO83k+rwBuxsOF3xQQG2gD9tZne8GAHPv0/PvCG3KNDf/4m0pxlZkqBXcbGPRqtcAb2gFgn+ifjmHZFqbrwOOXEwUe6szn1hV85xmKfvzJrMiijOA+1L4Qoo8s0FHW4Z2c9KY0W/ZruZJRzegWbpjsjWpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545644; c=relaxed/simple;
	bh=NioGPcElBpwuIfJxvdn22phhkqJKI4kvZohn0+p4VnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRk9qAJwNlO7o03rc5BZPiw+Q8pNmA4qrnRKAI1P6n6Q7vJ1sLsWxXSHrMpPhUSQ/FwcRAon1cVUsUUAg9EUmYEGflnqJ9aw6EhaKU08xfIQMWgPHD+mkmzzzqJK7m689OFpOxp84+z4H9MDZSwbwU+CEDSE8qJD4M4r7PYDN8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aD2wnVpM; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aD2wnVpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj9acSpFOGfjYqap9vLqjQ+U7IbRMWruEkBGUhPScOunJSRRz5hpdOKg5CAVMv92PQFfCHZYIQasGw7k2yANVh7JdxmEiG4/KGoKYppRnnxI+gp1zjNuPNF9KcYVdJ/ReTxPTrU2tE3VcDYAbqdYson1ZPwtMPhbbgCZGmelrwOT5css6az65oDTZ5DOxKTpZWJ25anNRDub7muyh5WRAVRLxzKlak+3L8KuF10kZ4ubsbmnQKFDoZvT3SDAb18Ll6jXG11QtWYgYKXQmrKfQO2fmXVbUZIbkuTekA/CFbjI55GkzJyoH5HO7WZpXd3abn9I/JSqQAmozM2BdR902g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lds+eMuBuNzY6Ensq1Wt4vI4OVeibD5liMgdsNiqPxQ=;
 b=Bk7HKX7Ck28OV52v7PT5AHQAEZ7W4Lxz+tqd3YEaC5D4toYA110TJ+LphwbGA7BZDzp+gDu+tMypqSivpAzG/+PK3X/9UBGA3ULYhPbaECP+guvc8KhF4od8Qp59DY867JI2+HZQI0DJ9PL6oiQFQfXT81sRqKNOsJHLOJPXuYLZ91UpiOwIo2Inb0ANfqCh1coyEhkGGEQh8UsbKeS1ucNmaiF9pAKGFl4avNH+H75Q2OBJzXo0TdrkWck0eu60osjwJpSrCC90rhKXsMXHSyr4DSpQ3MnYEbWuQ6IDBO+XZ5l/lDlCGDUzAh3O9kyswaoF06bdVDA6q6p3XTddqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lds+eMuBuNzY6Ensq1Wt4vI4OVeibD5liMgdsNiqPxQ=;
 b=aD2wnVpMn0yMjVRxzbjxI3J6jWDaV7MLAUXiGRHC5OuF8t4bngdzPBjuxSjWP45h+fkGfrFqRueQIzLy/xC4fImfQg/8Sozb5LJ7YRkLrOPn7mOcrDbXkMmU8fNsTfrucu+f4EiF8E6z6hqdOSZHiZ34R2tkNM7LQJMcUXuJ7ryJXZJC28dgungKdpTNXW+9X/nkuu+kbq89RErxU/yvseBTsznd934bCp5hF0At66fRjRb4ds9ABNByVazSq/k5l4yoP/qWEDlIof3fU/uNgr5iLRT0IwTE+7wZ0gqiYwIHb7VFmMxqXeEkG/+p9XInnP9rAvaQjiWd9s+VhSEqgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9108.eurprd04.prod.outlook.com (2603:10a6:102:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 14:14:00 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:14:00 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] transport: Fix broadcast sink check
Date: Thu,  5 Sep 2024 17:13:40 +0300
Message-Id: <20240905141340.65495-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240905141340.65495-1-vlad.pruteanu@nxp.com>
References: <20240905141340.65495-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::6) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c100f76-0ddd-4979-0d35-08dccdb4fcdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IN7fpyk2vEPxl7hfBQYXWEiz2bSsUWu93Y15FEezfOinwTNP/jl3cGkTIyyY?=
 =?us-ascii?Q?Mo9BnRFnYnDxl4Mkf1ewd/PN44O9CbzQAMJo6lNzRij1o6fDurUCoVhr13Fl?=
 =?us-ascii?Q?aOHWfiSzj39GSKHvEabv8mx3Y35NPmsdS+sNdBVAk3PhhoQEkxraYaVeEkPP?=
 =?us-ascii?Q?9naw/Ne4f74cd6/WalZNwpPdq5PG7a7D9s5Xpya5muGno03gDJBflC3gc546?=
 =?us-ascii?Q?f56rRYYMKxNDNOrRhK9Q9txGyAt7v/vhOhSsWbHgPBQMjYYj91iMKQUOExAA?=
 =?us-ascii?Q?0xduc0OUP9Eg5Hs4KX7bucqkjrZp6TQOoWFQUhlD3kCuPuC/EXVQDYz9o+YP?=
 =?us-ascii?Q?7bsyrmcxNILPglf8DT0zmFajeLAwO4P6CyHakAE3VosfUxJVkDCuIr3hceOX?=
 =?us-ascii?Q?pEOh+lChaLUO8p9xcPOWNUFBWKWoo91Wl+5b/fUwchMwVSsqQnGUmH4zdyue?=
 =?us-ascii?Q?54X4D8IaoM6pCL1gfHoVmxclhQ3ctfDzUHKKRKT5mtthGJPpcDkSCjm5NSK1?=
 =?us-ascii?Q?C3qm02xmOa0TDaoYUzrSnnhwmONuphVuV8IgWT4sAgKom4Gee2Vs6Rvhx80u?=
 =?us-ascii?Q?ZYf6ycfIfrOaRG6cFVlWQVKwTAtxCDiKLgqCS6u7LQ97TCbcyyTYtMPegYnQ?=
 =?us-ascii?Q?J5w7K7gmu44SenNYIDypXbjph2pEuZGLCPI8w6VqxEy9YIFtwuqaclsZ/WXZ?=
 =?us-ascii?Q?qLBphjxEjIR35S4MUinl4JxVdfCMl4BQ2h5zfEqiSyULWN6MmbpIIg03wO+Z?=
 =?us-ascii?Q?r20benfHFuhjM6Pm0bsA7RuDRsU0Qg1sCX9aYVbKSZyfETKxXcNP07yxnojc?=
 =?us-ascii?Q?7iLjCF55GtT1NkbnnuA7UHh4eOv5EnvlivZTI5F5+LYOMvBiMNUtovvrBSjL?=
 =?us-ascii?Q?o+FXtlQJC1xBFwEUGudcMEdAZipwBDbiOXT0NWzbfSBUlOYvuD+m49i9MwM2?=
 =?us-ascii?Q?/7DOi5I/g5+6OZpQw+9j1nayXf3VawRseI5Lyyer/yfEVUBCbJ6cIkylWNQM?=
 =?us-ascii?Q?AtUnjEAyuOBwxB1sMwttLmpbscwZWjftLIFx/QpfucPuKuBpyIqZe1vqpmuN?=
 =?us-ascii?Q?2OcLRZ65kCS7UKzAiMMgEnPUswfdoapoXAL9rbi6eTVgVQ4BBIUuD61+BtCB?=
 =?us-ascii?Q?NJuNhQKB1koXaQyqFdfUMV/4m6DYZYmkv+hWJphs2UgQl8ZhmSuX4p+27Tqs?=
 =?us-ascii?Q?09tt3OTr/uMJkq+glJ5fLacCe7Z85y3f3XWPSgJjKBWlYFk1K3We8BeMiaT2?=
 =?us-ascii?Q?2qwh6Z/Q4hGQvbQRCaQoxBgmrIBPDtfZY2cV1tFz7qeCeE5RxPW7dQykD3j1?=
 =?us-ascii?Q?HXdMeXTKp3GzB8qa63/aUfkq8Jr9dXdL/DThEy4dzpA18JIvFRnesbWCZIRv?=
 =?us-ascii?Q?hiWBReorPuLW5d2tRVosJ5QTY1158HJDtZSF6y8TJU4wjCa/pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7jKYJql+CXG7G98ctZhIgWe+726s9qkW3F9Frl6diiOXoyCH0DykCJ06lvL?=
 =?us-ascii?Q?q9b8YfnRwMo+64kYFCTBRik2HCx4ximxuZjdEHP3tUJtuqHgOOzWA0h6qyYd?=
 =?us-ascii?Q?NMlob1BjDxJn+wNt0hayRjvR0DOqF5oZL0gk7uOpKiQ1ML2UwJNmW8E9Ya0v?=
 =?us-ascii?Q?uczj19JX2ZKO/pF9WzdlxeuuaPH214rL9BkFY/yFKVGEbqq+6zwnJ1TQVXw5?=
 =?us-ascii?Q?j47bXHtJwSZo9W8ftgaQAbH6b8fKUutiSlo1EazdnAXZhaVqTt8izEEOfitW?=
 =?us-ascii?Q?tVSiS1UEuvzqNjTN8iXGUwF+a+eu/ZEoeE7T2h0C5W6gwctDpKaHM0AjdPZB?=
 =?us-ascii?Q?6tikVLXDJ7JsTz75g8+KApf5PsH/g8930t0pI1vIJgmJVk+mmP4tboZwJM85?=
 =?us-ascii?Q?MkeFUv8XeMfEeSC6YBmNBFzvD3nD01hmOq/k2yDjIxRD6aOHOpD7r8/sXEi/?=
 =?us-ascii?Q?zc6NSN/bVKYJaLvgcoW2sYsZWBjNxwB3uDcWyW6kOD1KN0v6GacuHhAY7vHd?=
 =?us-ascii?Q?rDORl/GIov1pxRu57HWUeZMRavGj4dM3jWseXkhACkOx8z3gYgHnFrSUB/R4?=
 =?us-ascii?Q?yh8Q0pAVRVEIpoJJve6bueq9tyfaWpyz6g53zDMm9IcURp/mrpsV9KGpWi7h?=
 =?us-ascii?Q?4ytX3mjzBhI0x3CEfSlpVF6bx5MwVRIrDRuMUS8Cw7pABaurJWzM0QL735Fk?=
 =?us-ascii?Q?VEvAzBYRBKiNF1xKE1NLIn28NDOtRx0AFbj5TFnYphuCIVvTqNmxn0frnvAf?=
 =?us-ascii?Q?OQG334EKnicKU6Jyg9TjQb9FR1tE9SH74M5wA1rxLtqwQi12o2i3aXY5/OYC?=
 =?us-ascii?Q?FUiJA9zVUE2bEQifcx+ScN9xqL87R0NApud9pO9TV2ZNxRHTa5wKqPB3aCy/?=
 =?us-ascii?Q?asgIuLrmmDA1xjyUe6jfFDCld01BTd7/e9j7opkAq+j2fhq+Jgb1qZfjcXM6?=
 =?us-ascii?Q?zdvRg+AAlywk0DYNJtrfel2fqRzqbJcEnQ92AJWe2/ablPvcc4e+NUltZtqn?=
 =?us-ascii?Q?Z5rLfdZSmNgR7YYyaObBDUdvoe651DrSY02jRwOiX0OEiGOP9XqfpJU60j7b?=
 =?us-ascii?Q?hFAC6RVaI6rFvM+bTNQW92G6+rAU8vXds4AvS4siP68TXZsFG73aJD9OCD7y?=
 =?us-ascii?Q?QUV9IiNkv+XvlST6MzL7zQyicx7lgHkEjUqSzHkqGDZGTH80ti+hMRQL9LlI?=
 =?us-ascii?Q?Qo/pc/qGIakrjmaMlxEDpa7Hw/esiMSYW8vAUcvMh5+uMvjHGcFN1AnPERzz?=
 =?us-ascii?Q?vb8boBhcY8bKEGhnFhxbc4Ga8xYUlcegimVgvxdbJIG1MUcYHOrtmcHcKV4F?=
 =?us-ascii?Q?uqBm/J8dsJ8564ndpuCCwtxCwbnGZpQvnegbh+wZwD0qVIF0GdYeOMFmlk1E?=
 =?us-ascii?Q?X0FHN+wFkAyPxJZ/J4ZcUa7nD6YPgnyMMZgm/01+vUrkhyOomSCeuLf6vpEp?=
 =?us-ascii?Q?X4hDjLVtgq+keY5PEHPA81D3+Bu2EbfNXBz1KOlXULotB5cDeDUTRrlE113k?=
 =?us-ascii?Q?frjl9Dg5ATtLBYR3Y9lWD46mRkzRk71hlTI1DZgWDgC6NXs3cJ4YU5LRYSSa?=
 =?us-ascii?Q?+e6oNTujNiQib8gRXr9W/VWLxUbHcNruO6JDcQW+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c100f76-0ddd-4979-0d35-08dccdb4fcdf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:14:00.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvhwGO5AB1+QoS01rBCGAE6g/zzEBlRx4g1MBtLC1+18F1WsnhXaILt8iIvauM0+8h5ZR1gbSItGpHcS9fK6YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9108

In transport_update_playing a check is performed to guard the path
which contains the TRANSPORT_STATE_BROADCASTING state. This branch
should be taken only when the device on which the code runs is a
broadcast sink. Thus, the UUID check is wrong, and this patch
updates it appropriately.
---
 profiles/audio/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 300145794..2c09d415e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1301,7 +1301,7 @@ static void transport_update_playing(struct media_transport *transport,
 
 	if (playing == FALSE) {
 		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
-						BCAA_SERVICE_UUID)) {
+						BAA_SERVICE_UUID)) {
 			if ((transport->state ==
 				TRANSPORT_STATE_BROADCASTING) ||
 				(transport->state == TRANSPORT_STATE_ACTIVE))
-- 
2.40.1

