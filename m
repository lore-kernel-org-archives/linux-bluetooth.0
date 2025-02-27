Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2D26AA87
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669498; cv=fail; b=WROyfN89WSbv8xtFuX9LYorffaUTsFG3AR6EmQgevhnvGwqaL3z1MpdFWVarMvA0F+slODmvoyGbyhvFvw+/X/SpZVBbqwyGaVEFZrT6pqdatIPUo8pRzV5x9MV0QjOYfBiEn0oiXnWhYvohcOhXvVfNqv5GZB1j6A7hdEva5Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669498; c=relaxed/simple;
	bh=dCIMbZLdukPeMSe269Awu/LhXzWTxdst7FA5Jxh72TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W02ZKfSB32JELodSRaCYdXxyQbnBw7YHPYVAIguJN0xglVL2X8oabRY/Pl9/gt3L8czRMXOolgjHZhBsRprxR605DAdLg2Jd3dsKDi2wDNd+nkfEbd3DSiRy3F/E4Px0c7nKq8tUBoyLX5bwvoCSQkTJoo3/BCL57qewNX+ELmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h70k2lxM; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h70k2lxM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAtZKodLvJxYgWbwKnGDH25l+qPNI5YcZ7Iqu5SQWozTWca6taU79O33xHp/RhslG04xzMhgYukxkD2CNXVdBz3k19PVxjZeQGSoJyH2PZJ52QXbhyUpUzafOXiroDlBaQbbBzSKLW7kpX/AZjdvNMTjmLOz37wn5ZxsIkzdZs5jg6hEqzkCDuwM0Twq0d+eAi/tZVNsF+SvzAMut+2IT52tRF2wy6rx7A7PUmzKT/H+K5BWNPzwyx49hB118bfXJzBMF2SmrHGonxqmFS/QHSlGkMIPxLg2zX1MfCvEr/2sSPnbcVyO2EOwTFvIvsX4izIeAuGUJ0gjsZU0vFj7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DfEsqD6Ug8OISbsA8zl8Wn3I+frqS0mfimgO6/Ol9U=;
 b=w4D/MwJwAfeYsdXyc/+9YtcQIbo5vhS6UDeu5UaW16xsRB8b4s4CVr77jP423JawUKew8W6VpczRkYTTVeKMQh4zh+8eqEV5lm0s2fmFfPMsXwIXYj5JmaQRoZJz3SzjREVZMsq5mGeStmXdAmgZxHeMxqrw5e0KsCpUqHLgUPCV0VhjSN569v3WqFYTsm0CsT95ClCY6SBPxCh/c3MFDgK5UmoBDgKeHN3Sk9RqWsFP6i9p64AFb80duqV4N08Ze2IYf3wwRsExR96YDuSoT3zDqwt8CP6+0n3zgm/bId09yGuj6seVGFlsuR98sB0dEwBkkrGbMDxZwwyU0pmMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DfEsqD6Ug8OISbsA8zl8Wn3I+frqS0mfimgO6/Ol9U=;
 b=h70k2lxMA0g5iL5lnTOqhQI99SRMig0W8PJxAGt0Wqyj0SblpF/tmlxGscC0AjOrHswT/s/zJiJhBylCtCOo5TqijZd5H2nRyHUU7LiTU04FBTUd8lbTFKprY2FInDu+/ggOeezXHbqAKRVli3yTj025szSBNit1vvAdl3ipzUVF1jdUlRVXQ9X5Zf9vidnRyPSqcCRnleUuGkgVHIgjaeOTym7tpgJEZhptG8o7p+SSKSexfMq2xko6+RuLlP8thCMw9Wk7KVYNAI/i575TvzxQ/6or/DYeQO3/oI86Z8x6LGLd1Nb62AsWpd+tI57BMqiOF1GToVLqPXHUD4Bu6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:18:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:18:12 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 3/3] bass: Register bis probe/remove callbacks
Date: Thu, 27 Feb 2025 17:17:56 +0200
Message-ID: <20250227151756.33772-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
References: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e0e9c6-7393-4463-957a-08dd5741f38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAGeL1iDUApRhXrc40RIZX2elYYgAWuPEGK7HazXeFsGuWj90nmRExOUfH96?=
 =?us-ascii?Q?nLgwRHXiIdd6o5g1iMWdjMTut4Y3f3JFjux3uDinSlvXxdQKfE1P57m4SQHA?=
 =?us-ascii?Q?6b8ulZqNS3E5nN3zAbLvI+4pa/sCFdnuALAv7tpDGWJUylFXFw/rn3+BbKqv?=
 =?us-ascii?Q?j9o33aqSlwPOp1czseANfN9lyemKqao+CL1tXpfaQ4sHaonwGshnUCjeX4iK?=
 =?us-ascii?Q?FrulWPcazCXDjGysuoXU+KaanN/5yDisF5DxNVwOa8/eTGPv0bTYWruRjtfI?=
 =?us-ascii?Q?pho2fosLIAAv6AZjOeUf3/frKttQqobXbu9R6j21M/kVLZjvxN79iwXap3r8?=
 =?us-ascii?Q?Rz+ZMwAnL3Rr94POUGsROUPqhv2/8+xK/GbHKSwrk0iMNnlWI0XsUHZkgssm?=
 =?us-ascii?Q?S2USR0XxAk9TMTDpHs7wS7d0b6RaU1gFMrPbTeF+GS9KiAyYXrdQoN6zfa6d?=
 =?us-ascii?Q?mIFzuOuIp4rDgAam0ks6Mz7H6o+sWYhAkrkt2/gtcpWKsCtVXPWR6iTOtitG?=
 =?us-ascii?Q?zGsUiqig8YLNagVqu+fdQj2EfKF7eshTOTtDoEvzU3EiiJjLXpYGID5d6bhz?=
 =?us-ascii?Q?O3ZAXxi0T/R0h9O0mk8+Ie7IQ/wI+HjcFQzELLlkDYWLcV51/PPfB0Mav8/+?=
 =?us-ascii?Q?wXyDh0ohQwbjOo2DCMyKbll8N1u4GHpyv8xo8711+7AmIb6xhB+on+mwN/FG?=
 =?us-ascii?Q?cYN+RNrxZBmTcIRMYjuyZ1qdwaX92J2Vk9C+uJf99j14ReUwzbrXzEpF5c7P?=
 =?us-ascii?Q?4KmS4Yk33NucD9entijS3R/eWkjSUzuf0R32Ua/scGjl5bgLwhCUKt9mVxLf?=
 =?us-ascii?Q?5G/XxYdSUNNyatNjU+eqpa7jmvZKVOhb/utEgJIgsTjXepuPj/loJBJH4atn?=
 =?us-ascii?Q?yK5jAaOKxnwOLr9Dh1s0CRH9vqIusn8+Db/CI1C/kgjxlUxwRSfAF5EDKiYB?=
 =?us-ascii?Q?QjRB25gnISAcYY82HYgj8KHFitxWo6GRndH1ZQ2FqaP6+ONP9eD1jSxVb2MD?=
 =?us-ascii?Q?nTWsr1fiyJwBkXa3nBHIuSIvHKxktv2BHIuLMEM9KLvzC5KsyHlhRO1CcwAS?=
 =?us-ascii?Q?wO+LVHOGy4GYNlAXbyemSeCcQBesDEQRu1gc4Su1/EapLGSFMvJgeEziCcuX?=
 =?us-ascii?Q?DlIwcQQr1X3/w0Wvom53einxgBOb2Io1DkapbN1eyKNLvZSVElibIWTTpVpe?=
 =?us-ascii?Q?gR9U+ftYdtnKMe9s3vx/BgXRxVMa4r6/WzRoYK5xqtC6LMQeeWO3IFH+kXaV?=
 =?us-ascii?Q?42BeqqJsWZtGTAG0Z46hEgTElONSqhdIXFPmvWnLh5Pr6Z0VYEYBh4TZuA6h?=
 =?us-ascii?Q?gGBc6xtPZFNbypwt+j4p52fJuci1gqGUySQxL8kGrueb0AIAhVBqvFzMvCKE?=
 =?us-ascii?Q?cYxIM1ch+0yGhIp2m6qAhUWVHutG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZh32DG8JmNLL6s+E+ZDefd5ytacZ0pywhXjQD4b7ZvBceSXXyD3lSVwX1+W?=
 =?us-ascii?Q?xrAN1R/4mEBk2xVQFh2turonKBvJdZE2VoenvBlTPLsSR736shEyg++hcHI7?=
 =?us-ascii?Q?9omUA4c0zX37A9Damtjir12jNy1keDPoAS+nVAhV0NDq6XvBjb0nwA+LX+Gl?=
 =?us-ascii?Q?0SoLhZKcxW3dNj5jf8t5XaCF8KNTIw95sFat5sQWAX29TaKNlBsvy3n3DU1q?=
 =?us-ascii?Q?40sC8AvjdUzqXbmk19YqCK2zayVfc2WFxoTblDcHkbZ4oHu8pXSAIII1Wxav?=
 =?us-ascii?Q?lDIdHeGq+4YxTwFly8HZrhYrMcWK9iBp4/wXpwVvDxJhSDdFKUiBn4cUWe0H?=
 =?us-ascii?Q?SveI+ZUttBExMZg/jgWIg2ns41wXNEl22jsHCkCfWDSylvSmZzyad40kXdcQ?=
 =?us-ascii?Q?BfVWtSp+8jOZLiW6CVRatP/ZI3i4OSnkHhF9oaD42TJUJ9JAYm4Kz/v/GTbD?=
 =?us-ascii?Q?MWQ/KCgp2cCYpPm8wlJkj2k55bQrlemrLVKrCsxgq8mFwKTTttaFFqCcKRe6?=
 =?us-ascii?Q?XK5tQ+hS2acgho3qdNN0BfsVj+n5KQTtqlcF4+aSDoOhnpg5OvQRFRb6OPuY?=
 =?us-ascii?Q?/rTs+/UBXIGQ0tdh7jn86Flvr0RROY0E1KE+nb2zgHwWcyUgZh0w4M6rx0E9?=
 =?us-ascii?Q?JlPyh4UTza4EvO/fFt76nzyWzlRaXo5qfQF5LNNEoZ1wCv9s+DulVOHlOHoa?=
 =?us-ascii?Q?Lz0MYTn6PGejG7gScGOTWLxwVDv1a/Xhkwzvl3xQSCPR9JvY2KVNVbaTrnzB?=
 =?us-ascii?Q?ar31qHsm4CQ6M9Aj8Latlqn2fSLMgKj2ESv+H+Vw+REnvVU7btXphFqIkfAS?=
 =?us-ascii?Q?sndb2O3YaXA1Tl4aWB8wA3ZueRwxF8l7hRF2zg6QgTYePgblAnTqU1M5ltVb?=
 =?us-ascii?Q?13250aURQhhi08Tzik8GMQzUvNgUqnD8p2Q5+8Mz+u4d9DYgcyS3DJCLmhez?=
 =?us-ascii?Q?ln4LonqAo/MRH2zIwBjAvxvi+Q/in4VrKkrzKaooHrMYRqJDhGgs32V+Un4z?=
 =?us-ascii?Q?8JeVl0EKpu3cDWoZk2vtSZw6Wu4ZJjePLYAt1ANaBDUfef/RmCyqjBeo/g2I?=
 =?us-ascii?Q?v26w5rdYRNf5zjT5Ks3HlQJKhNJp7igTgWz1uhU5+C9Ab8XDm7Yh+uzTfARk?=
 =?us-ascii?Q?ZKMPXuuGYvunSQBYgz74ouRXqB+jgOUfNst+L4PWsBLrN7LkiT3LtCUsOfvw?=
 =?us-ascii?Q?8HBOOtphDjkk27SK5bwjqt6bi/iOvCD1E67PriIdb1gV76IWV5XrtL+m8q4b?=
 =?us-ascii?Q?zuRr8IcoceyL7XCenoODM/Wo4c3HLx47RnWn9wzMj1GRDellX8GGAZutGMvt?=
 =?us-ascii?Q?Fxuw1tEN1dKW6x+ae1EjhQBcGgHoIHo0IqLP1UJBkFsRVUQt3bM9ysAbSrJC?=
 =?us-ascii?Q?3lTtxProLaJdfit2vrzzaHBskveAxAkH+hMqiMagrIdZLiOlgMyQHqVmc8u6?=
 =?us-ascii?Q?cupyTNsEgjeS0P75ZX90I8v3pORULeSNMMzreZO9OXzf97IgTn1KIRjUqP4G?=
 =?us-ascii?Q?0lBnMwxT9q1xjVad88clp+WeWfua7L7cpPaNfZW8emOlQRcJYULkgSWlRjc3?=
 =?us-ascii?Q?1ersyzNR4+PQLMb/A9UcWr5a2kEHtq8+8CYrur47sNc64qR5/+7DcrzwJ+5s?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e0e9c6-7393-4463-957a-08dd5741f38a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:18:12.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq7Ybc3cuIiv95CcHAcZ3akqSquvnva+qzeRGhBqbi2UFlWTbtOb95tszoFDB0sSwtg3eILw2phxxswKgthPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918

This removes the BASS add/remove stream APIs and uses shared/bap to
register BIS probe/remove callbacks instead, to avoid making direct
calls between plugins.
---
 profiles/audio/bap.c  |  6 +++---
 profiles/audio/bass.c | 22 +++++++++++++++++-----
 profiles/audio/bass.h |  5 -----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b36e45ea4..37168e58c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1178,7 +1178,7 @@ static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 	struct bt_bap_pac *lpac;
 	char *path;
 
-	bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
+	bt_bap_bis_probe(data->bap, bis, sgrp, caps, meta, qos);
 
 	/* Check if this BIS matches any local PAC */
 	bt_bap_verify_bis(data->bap, bis,
@@ -3128,9 +3128,9 @@ static void bap_bcast_remove(struct btd_service *service)
 		return;
 	}
 
-	bap_data_remove(data);
+	bt_bap_bis_remove(data->bap);
 
-	bass_remove_stream(device);
+	bap_data_remove(data);
 }
 
 static int bap_probe(struct btd_service *service)
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 96e767744..f5fe60652 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -86,6 +86,7 @@ struct bass_data {
 	struct bt_bass *bass;
 	unsigned int src_id;
 	unsigned int cp_id;
+	unsigned int bis_id;
 };
 
 struct bass_assistant {
@@ -141,6 +142,11 @@ static struct bass_data *bass_data_new(struct btd_device *device);
 static void bass_data_add(struct bass_data *data);
 static void bass_data_remove(struct bass_data *data);
 
+static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_bap_qos *qos, void *user_data);
+static void bis_remove(struct bt_bap *bap, void *user_data);
+
+
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -590,6 +596,8 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 
 	/* Create BASS session with the Broadcast Source */
 	data = bass_data_new(device);
+	data->bis_id = bt_bap_bis_cb_register(bap, bis_probe,
+					bis_remove, device, NULL);
 
 	bass_data_add(data);
 
@@ -678,8 +686,10 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 
 	/* Remove BASS session with the Broadcast Source device */
 	data = queue_find(sessions, match_device, device);
-	if (data)
+	if (data) {
+		bt_bap_bis_cb_unregister(bap, data->bis_id);
 		bass_data_remove(data);
+	}
 
 	dg = queue_remove_if(delegators, delegator_match_device, device);
 	if (!dg)
@@ -1077,10 +1087,10 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	return assistant;
 }
 
-void bass_add_stream(struct btd_device *device, struct iovec *meta,
-			struct iovec *caps, struct bt_bap_qos *qos,
-			uint8_t sgrp, uint8_t bis)
+static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
 {
+	struct btd_device *device = user_data;
 	const struct queue_entry *entry;
 	struct bt_bap *bap;
 	struct bt_bap_pac *pac;
@@ -1142,8 +1152,10 @@ static void unregister_assistant(void *data)
 				assistant->path, MEDIA_ASSISTANT_INTERFACE);
 }
 
-void bass_remove_stream(struct btd_device *device)
+static void bis_remove(struct bt_bap *bap, void *user_data)
 {
+	struct btd_device *device = user_data;
+
 	queue_remove_all(assistants, assistant_match_device,
 		device, unregister_assistant);
 }
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 99b755259..42a2c047f 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -7,11 +7,6 @@
  *
  */
 
-void bass_add_stream(struct btd_device *device, struct iovec *meta,
-			struct iovec *caps, struct bt_bap_qos *qos,
-			uint8_t sgrp, uint8_t bis);
-void bass_remove_stream(struct btd_device *device);
-
 typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
 
 void bass_req_bcode(struct bt_bap_stream *stream,
-- 
2.43.0

