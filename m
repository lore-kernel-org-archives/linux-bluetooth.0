Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8B3B799
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751958; cv=fail; b=FjhMhkl9zWaow5B1eAEh1BmfUHlAo458Qvzfcx3SMxxIY7HL7F5T4NvpBK4lI0HrMfeVGlh9tGRREViVpFjApqK5gJNvCJV7PqQ/piWIwHi2KpQqiGqJ2fJHZeDFOJa6uOkbgY6dtzJ6BI9Fazd8AfeiSiLSpzjVGF0LbepTadM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751958; c=relaxed/simple;
	bh=xS6M/O8tSwyfrlxN8+PJhsViXY5oGgaKQx4pXIC7xxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9CmAwUMC5imzCWPrlm3dXbETegKmcq5JJC2KkBT0uxmcmkCjnshyifdAcWJ0AYG5PYl6fZ+W7SJlPQDEYjyoAeOAyK5ceGUwIf/KIYGPZavTVHZSQMBFC6AiUA2vRXFDz/66kzPKPvw2kw/VDykqNq9dJDqji7k6rcBahbyuXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RgrIqBEE; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RgrIqBEE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0wOuEbU+SgOG5WykxDPRi7w5JC9ASIvqJNuqzztoJ/mas7inB45z/LpaXAp1KJgvpLB4z5NVAxA9J4ZZeLpOODotL4zjjdTJGYWJFCKtJXc3LqgmhSpHPmjUvLMWg3U7tl57wm8HD/J7Ner/eDQ98SmGGKAk0JxQOT0NULR40obe3OkT6/ywUaCaLB1e3JqGXMZSlvB+APC7l+PHBmm4aco0ZbZsi8ktBtDmr0EzawkxSIAVf+RldaVvbkIRfJg3xNft1kLeQUrBZvVPVv8poJU5Xf8P0rukBCip9jkG1k9BpM53oeblDl7AK4kVxKxDJfNsAlI4R2SY+XlcQFUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtmvMp1VEYbPPe3+MDwerFMwl5w3/RRPBAPxjQjF1/c=;
 b=XZHSRMNnCeLqNQMbegaH5KYg19JWQvV2pTyD4yVSiGM8JnbbL2WJJ806eBkyALNNcgJi3oYoCC0PaQodug1Nby/PGTW2LrZlwVZ10ROVwps5VTZq/SXyO0tZTMW7bIi3Hc7OAwCG0G83bCW2goJZUdaCXv0rlUSsj3qZb/37FkakndhtbPf22erOAwmGylwfAB3Q1ADNojzpzV6xRUQEeO6AjJ4xdgBm9rFF4kyE6GL8pMA+VzAhyxVHCGmM5KafMw4PC+E0UV5R3X15oUMliigthETBCUHjHTXZ5DQgAoSaQusSrhBjTQEW2ZOyBdWF6PAzzKaax249dk4BdLNL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtmvMp1VEYbPPe3+MDwerFMwl5w3/RRPBAPxjQjF1/c=;
 b=RgrIqBEErJeltoa4svlXsf52aqT/dv5Q1z7/pcLcNqd6jUkWF+8Pyag4uJ1LQ4Bh28Rv5Uw+bJGIMF+f8tVUNnzoAkN9D6HFpGMLIvg0QqBCGDD3cjfjy5Fr3PxkFh88eE21YfnGQWlyMoveYTA1XU/sJW0yHrbkLBHbwQBKTNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:32:33 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:31 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 2/7] shared/bap: Create multiple streams for the same pac
Date: Mon, 12 Feb 2024 17:32:17 +0200
Message-Id: <20240212153222.8191-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::20) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c5e8de-bc49-42f0-18fe-08dc2bdfd3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jIZ3bc6EJdR8tYfIgXQngqWXn3gWwZA0AYC7vr04oba3if0+OVYsC16HQBym5A90seZA/CDYFbDLSvpCV4kBEEtTUERJOL49UI/A5f2TXmGGyYg4MA03l15nVjs4WRwQzqVNasUJG9uUb3SEx0pz1j8BoKciK9Q/ykYD23wlC9J7jUblOd/YReLbPLXjye/lAzw7xEatOlnm5rR+YbhIXcFRonCbCqqoI2ADBGQziBpSQEHR2MQySYR2d51OOkPsqJjIR8whLvA3rN//kp3ZQXi52M+3I/J5eXSn2SCdmTgHYB9BZxwtQeIG35yeeGGyFDOzJZZjec3V7rPwvCZqf95pJVoumGuFJT4HZoHwjqzqhRx5LVetyD+SzVR2A5ZvIkeoLYDJpuhzzMQ4U1waZ1CsCGegsO3waQ5OHM06mrHunTXOifmlFJCLJnBh0QwMwX9yeg7wezh5eeyvrFj5AU/Lv1HmR3U1IVGNuEnQ6gfkn1dmO+z9X3iIrd4XVUsoKvYxIvs+l7LMw2x5wix5B58+wHLrFNmmYs+toCHDDXsjRub2liUFHmY82kpT/lJH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(2906002)(5660300002)(66556008)(66476007)(4326008)(66946007)(86362001)(8936002)(8676002)(6916009)(6512007)(6506007)(478600001)(26005)(2616005)(41300700001)(1076003)(36756003)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31oxRRpJ2j8N8Qi4n6pQ5fzWc0S8lopJnVCQ4uchyfgzNPK1EDzJ+Q5aGy+9?=
 =?us-ascii?Q?h1wDfmsLOPUhBxyg0xlAaGqsDqEBMnuHoiUo6xstcx11QHskbwYRfzmsz43K?=
 =?us-ascii?Q?fE+a+j2JxsPves++JfS/m2GyLv3kQ8pLvIt1yYz6h6C8faTl/Q0oOqjwwMHo?=
 =?us-ascii?Q?O6tgWLOiswjG8Rj8GbiiLM1bunsRzWacwgt7Z/YgAdZdJZqoMi3LnLhQlDxk?=
 =?us-ascii?Q?wgD7KqBnjivjf8931PDA1DJaFnt3thr68reL+ANmZvRuR9OI5Ch2uHVXS4iv?=
 =?us-ascii?Q?DYfKeT5yriiswOcBV+dWP86FjidRl9jhQGOeb0Oi5QEj7NKuXqc+MpL939BG?=
 =?us-ascii?Q?I56tV+nvEzJCTnbkbwm9BcPZFsiMwyuLiy6r1M6dCpPeBsc6CsD61NC8CYfo?=
 =?us-ascii?Q?v46aMJMfRt2PP6TYh4xkWyQyG0QwTiFAKdbPTmexKhx5t1o00kzmuYqXxo4T?=
 =?us-ascii?Q?Jh6aPlbbbqgaH567K60WEabrdTPHeK9NWNZkvs+y0hG2G9+uHsbe2Amz+ve6?=
 =?us-ascii?Q?mijo8TahwW4kNCPDaHpLWSVPoqF2nUmRaasEi9NAcIPG3sVDwH2kgcuuHfiT?=
 =?us-ascii?Q?9ANEdiK2PHUNZZ35eLwE78WeFEJTgaWvZ9VKK5xnoBV50rMsejVQ86PzjFrf?=
 =?us-ascii?Q?vHzfhCU5DyApEWsEJss+qSC0InrrT9CbTpvYOH6oI7MrU3zi+AorFEJJh1ig?=
 =?us-ascii?Q?i3l+dcSX7lQ+a1W0lRFu9mAy+I9ZvWKC03P4+jCHvOjRkEIx/4WcNq4fIh9L?=
 =?us-ascii?Q?MsL6jhymlEi8S7UNV7AyyLJxw+YXVJ/LNXII4n5oFV9ZPFk9GIuQ4tOfS4gs?=
 =?us-ascii?Q?zaulmX61WPZtcpnDVYyBKM31OBNbDpqdmbgT3+C4fNMP3+P83T8lL9rnkrVn?=
 =?us-ascii?Q?cHna8MksH2RISu73i5dvRmZjCrZckVFCRAOnB5DiV59RP4SIo6aJkVikTiDA?=
 =?us-ascii?Q?fbG8NT5R9yq0iyFcm4myTeef3YIgoSuvhr3yRn8QbAtGj+BBx7uwz57TUYS6?=
 =?us-ascii?Q?j7DGG7+0ngRkdAssXmoAQznuCWQwKuqyLnwgxd21blOe5T5gHnIygJmw/jce?=
 =?us-ascii?Q?iuaZGjkTQQfiG4WpUFCyA3ehoJW0uwjOQXhtwjOV0QRIBnRgML13Om1b4C27?=
 =?us-ascii?Q?e2/DGF2exWWWdQD3LxipQdPZFtxJYPXo+KbpkCwX96L3uBp3hkgWohYitMFe?=
 =?us-ascii?Q?hHl6/XNxo4BnzaHu4We5GHoZJsTwcphS7VF+dhMNZFXnyfRdRnZHLvomE9z/?=
 =?us-ascii?Q?GadCWvbj69dRfQIIbVz9RqQjEY5L5VbqQL8buq4k63uT5vJLXaVOh6hn/M2l?=
 =?us-ascii?Q?geP6OSFa1vrlC5KY4VAuwH6c5ZAsokFwKFG9g/8+ArT+MBF9t5sLnGaFSCaE?=
 =?us-ascii?Q?eDaHJwIVKmMtaWuhnaPLfTD6FOQZF5zADPSmgQHWn33bsr/hM2Z0EdFN6ks9?=
 =?us-ascii?Q?arqcuA97sQm5cdT1om9ikLSwr88VWhWQjekXWPvkJDNAaxXXToK7cELkAYWp?=
 =?us-ascii?Q?j93RTCy/KEQa2VUCsx0nWoihNBJpn1apWlg8CHKr7KqJYOdpsG5tfiEBbfd5?=
 =?us-ascii?Q?U5Zh/qgKQQRAtvq2sGX7PLL8SO9WoHXb46FE6KmT76NvTI4+Y+JfFInIFowE?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5e8de-bc49-42f0-18fe-08dc2bdfd3cc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:31.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElM7ovHrOpA7/irrCHQ6sg5dtMIUJAkUZSqqwYue1g3G7bEekswjtXPHP608zQn2euNwkZlUNxeKVEvsvLMzOtrXHEtEIqjvBfXlzIKsJ7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Broadcast source requires to create multiple streams for one pac.
This is required for multiple BISes support.
---
 src/shared/bap.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e26dbf944..f0ffdebfe 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5156,7 +5156,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct iovec *data)
 {
 	struct bt_bap_stream *stream;
-	struct bt_bap_endpoint *ep;
+	struct bt_bap_endpoint *ep = NULL;
 	struct match_pac match;
 
 	if (!bap)
@@ -5212,12 +5212,32 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	match.lpac = lpac;
 	match.rpac = rpac;
 
-	/* Check for existing stream */
-	ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
+	/* Broadcast source supports multiple endpoints (multiple BISes)
+	 * for one pac so allow it to register a new endpoint even if
+	 * others already exist.
+	 */
+	if (lpac->type != BT_BAP_BCAST_SOURCE) {
+		/* Check for existing stream */
+		ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
+	}
+
 	if (!ep) {
 		/* Check for unused ASE */
 		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
+		if (!ep && lpac->type == BT_BAP_BCAST_SOURCE) {
+			/* Push a new remote endpoint with direction
+			 * broadcast source
+			 */
+			ep = bap_endpoint_new_broadcast(bap->rdb,
+					BT_BAP_BCAST_SOURCE);
+
+			if (ep)
+				queue_push_tail(bap->remote_eps, ep);
+			else {
+				DBG(bap, "Unable to create endpoint");
+				return NULL;
+			}
+		} else if (!ep) {
 			DBG(bap, "Unable to find unused ASE");
 			return NULL;
 		}
-- 
2.39.2

