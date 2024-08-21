Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0971B2EC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252212; cv=fail; b=opsGks4i+Y+RNNEdqlWe4Cd5QWgKgsJMWFGg12aljy+q8IGLHCqhThpeo7Z00cDG3YlNFtvCa++3SmfcMVC/fcYOmxTlAgbvTvIZyy/vumEApuObhkhGsas49g3RdoLL6nmfCm8WyuIuB0FpR3wX4AtXwsh1I8wc1aAFgJDi6vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252212; c=relaxed/simple;
	bh=h1Pdzj+zfWtprnTo+hsm1383pgdYoXs7IMrbZv5XvPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAjifPH77DLT8RcKvKQONuF79Zs9x8pqmyoKyLD6cpQmHDzewudmNFg8ki39IOvFyuWfBGjBd5WCYNhgbL59SN2eMTwqGElbYazyR9rVCUk1Q58p6cHYM5hdGrLu3KKohbyi5/fEqKa5NQZsfZ1J6fQIC3JOPBS1ehX8NmROD0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SpmboDFV; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpmboDFV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj4/CIT3Uu3cjqNfMGhC4kSN93Vy9aXbY/9DZRndN485L9KCzKi5TQZLPOF8o7rXqJQ0WatoBjUViOZayojmfQearEatOhixittL6QXLO5g7n2jXPJ0QJ1OmzoiG5JBF7jsn4rapLqeTe2XxdAdlE1Mt6k9WNcoBWXr+SPDzquNJbnB/c4O0FWVGg3OwzSp+64X+FAbhzdiCJdTE7DyCWnkgvzL5y+OZddYdf37JKs8ARJUFFzNdu5HynggeRnk4MlvjPhqQMd+GKzcWs/b0wTD1XN67rVbirNRol8Lv2Ke+GtclJnq7+mMmslwbT0D7FQHNn+cL3d7wp/nHpnLiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1h42R/mGDQqlayKksC1QpMJXK0Ml/b/moD93vmE16g=;
 b=gRgIqz18wD/IM2LqKDi9nJeOO8RWsLMvxQFVhGIUTVdzWilz7pt93mJo6e9fNS2kpottWujbUR1SDhdiUzJcmoH8U9yfKrCc8J668HfhO0/+OZXq7NV5DbkibavkWSvHAqzmHd22BTXbMUSvZb1BIXpu06BFCjDRIioFbnLipzaPOdOHT+c8X+Oi2eGO+nyMOA9BloMX835Mo4nZfekJVgs+MihWqze/eBCOHinq3dIjjvvdB8dsWbZ5wlErV7VLLFilxLuHZLRmsO3NOdZvqcSdmePI1Gmk7ltf79Sj4IsS3uCGu1hJUqRTnuI7CbCgYa8GCjQTJhQCIjeq3adscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1h42R/mGDQqlayKksC1QpMJXK0Ml/b/moD93vmE16g=;
 b=SpmboDFVUezNiGVYgfEiN2UW09YuyQehD0m7fj+9xKPIK61VIu9jo5lsof20Rew73gbbtGfSHDQtfT3ug3i3Wcdd5l2EPkTPITBN2TNDMPxb54aopW5ENem2PlWGsgIKuus5S0UQSmqBnCEy3qBWYPgzuPOk4Jj7eOjd55f/gIpD4Zxdg7BHfeRvLEnrnlJqLsjLDhHIAcYEF75BaDu9/mJHrmOcGm1tHKNnf4a+p5BD8AmD/LfC/IMtfslt7znNQ1stA2EWtDwuywIT4PNSTf+s/+4iWlkTuc4+d9ZkBA7bV3hMJsBs9kxDBsXThSiCiE75UnE0o+iQU8HuGyLlIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 14:56:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:48 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 12/14] shared/bass: Add API to check BIS required for sync
Date: Wed, 21 Aug 2024 17:56:00 +0300
Message-Id: <20240821145602.92083-13-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de6e05b-5a48-40f7-067c-08dcc1f17b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6m+md7YBGIxUwCzNktlCJ2Rb+DTBN2j2dduhIdXi+syC0NRph4xeg9oN2ppa?=
 =?us-ascii?Q?1JWMNGzLC3+yasHvwcOCMx6wWzGo/POnQKTpRcozL8CkKbyNdt/EcO9YX3Aq?=
 =?us-ascii?Q?LMTZTKNqp79RcUowVUlY7s1kGCrrXzX5BuX0pXDrtE8OWrTAqAouF1kjt4s3?=
 =?us-ascii?Q?JMYE2ZXnTlbDg4yAIV11tWN92eiDu7s7pPuOuvfeE8IjNOiXRd5YlW0cVDjl?=
 =?us-ascii?Q?dp6EmVjRTd2n7CyzUr9kB/WZrxz5PyHpe9LDznR8IedphbTzV4RlbJmnLxUF?=
 =?us-ascii?Q?9OLxgYSpDb3tT49jHFWZ2FrlkwMQzko1THrdHBujHYV6LioMysSkF4NLTBnJ?=
 =?us-ascii?Q?fDmR1rHED4IrrYe/Fb3f/GPC5Og9pf5uk5eHc3DJ3Z6cB4im4n9NN5UPAxEL?=
 =?us-ascii?Q?X38dIYc4DfT8kv6zW5nudbu9WSXv2MbB32o3Zf0wk0bMN90BySBYKjGPCVNS?=
 =?us-ascii?Q?Cctl0Ke4F+yYWG8olXORWleEkQBnlgtEZfEq9CdcaFCQ24gQ5OQmMJ23d+sq?=
 =?us-ascii?Q?2CzZHYeYutnlwO2nWzl/RA3zDuLzn4s2GBZsNp0q0kRQUfnt/pyThSnQT9cC?=
 =?us-ascii?Q?EizDoH0jWa42WqZxi+0fmbbgWL6GWGyPMyc0DlJs/j1QWFg+FbuCpw5r3A3C?=
 =?us-ascii?Q?BGeHOlHPzPpmXOtE2gtbgQJWiZg/40eQ+nLR7X3CpkcmXP3nGa4iowiOoQ3Y?=
 =?us-ascii?Q?JfEsZQig3iMQWooi9HYKpE3nmfoOO/SC47RJsiJ8dBhZz5iWlaq0qcO8e55e?=
 =?us-ascii?Q?SzZ/hZ09x9ZIn4npmwKMJju6GMv+WNm6UUrwdj705J/5Jv/5cX3Q1bfAw22w?=
 =?us-ascii?Q?b077LWwKRpTEZFM/DUAzVC/OvmtNV84u40+QcRLSx7OL9lM7H9/T8vh+uakJ?=
 =?us-ascii?Q?21eqWejVMhMHVM34TAi83Y37OWEW8IGyEjPLTa9+ZHEk5fkpy5Oh1MSaSNpG?=
 =?us-ascii?Q?yJoTJxt1VIjkXgxFSqjh5fMVuDobMjP7kGw819wiK+/U8Ty6pfbsl7iOb1cN?=
 =?us-ascii?Q?//e6DZyhsIc68x/vM/PTEfThJE7G+QvF98pz8qTE+54E2N3YWxkBj+RHBco0?=
 =?us-ascii?Q?PTTHODHCF/f8h9WEzXBO9wLKbEbWC9ayJ5p59f4kGN32IrcV9m9D9F+uFiM1?=
 =?us-ascii?Q?rDli6sMoykdeqB5NcXy0XRxC7TtusMIAQ9kqRzFJ30ZjCE51ZXIaEseRWuFK?=
 =?us-ascii?Q?4TvQOG+DQgeKFkspuJ6At48iAnbJiR8pc/kOXR9sSReJSf/Enw8H9zkaMoJu?=
 =?us-ascii?Q?gmoSgSpcs0W8ijASDNao5GpkP7AImu/dwyhhti7kB1oQoPFWobmXkM9OgN/W?=
 =?us-ascii?Q?Ry4E3MYcVCEGnUP8pxwNluDMUdj0NX5+D6qdkbSTZMSaAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQ7OcBs0UwU4j4UwIw486YcuBf8JIL6daJ/XaNAD33EQqsb9R2xyjHbhg4Fs?=
 =?us-ascii?Q?yAZ7zSvTEDqtSwUd8kjiJiM9n3HcvNBlEYZsq50pta1g052XRF1Cu5JTHTL3?=
 =?us-ascii?Q?SR4zLKitFjF8Q9y08/TMdCqKyG1PJlrvIj2FrR7+EBuGOxsJeXLbVvzVWKBN?=
 =?us-ascii?Q?fmCQQFVvSEGykkhOueu6Hj/DFyfEq8aTzqOHLzEGfv5X4ji3sFDPcZbgV0+B?=
 =?us-ascii?Q?RrBxcPh/0eOaWeVTTae0lttV/uIqQslYxln4U+mSUNr7Zs7TNX/89DzlktA4?=
 =?us-ascii?Q?EHQA+cdLBgNT6hfcwgl9MsgYKwEuGP2Z+P2IAubQJVjxv2hoMYI1g7q3ZbqN?=
 =?us-ascii?Q?5FH9yzd52sxLzFCtnVouCBflJO+Cn8T7hRQa/+h0mR+TUCw1NsdRPWtS1jnQ?=
 =?us-ascii?Q?xHAeChUF6ex68KvWshEBdbb9WutD2hAS/281vpKzgsqZnJtT41lSdGZMnh3z?=
 =?us-ascii?Q?xinKbw7icpD+LhT01WmYV/PQxlZybAzw1xmvQIa+l8FD50QwmMfv6QfGJ3YN?=
 =?us-ascii?Q?w/96UL6Ho9CWxTCjwgIOIJIF1SkerVssDZttakI1avRcajKf72yjhSqQDbN5?=
 =?us-ascii?Q?LfErZS7AmfdyfeEwwp1jmE6HaauSlpAb/JPgbKEK9ToShbqQYeVaoTrRUcvu?=
 =?us-ascii?Q?MsOs0wMCp1QCNraiL3SoVvaumUuIu+ynrD9yCOmSG1LQOzS6vB/4xRmkayq3?=
 =?us-ascii?Q?EVc7/5rMT/iJ/SCcAppwQv92po1c4Z3lE8Mz3icd6VfpUJ9zJ/7Y2T5kHjOD?=
 =?us-ascii?Q?NLxEzcLjxBBBa4Cgm8XBfzHb0h8YOatGFz2VJAduvA9LkfxglgiuYeukdJik?=
 =?us-ascii?Q?EbQrdF6xB3t1cTBcsyb232GgbKXF4RnCkWrDMq+IjbUTdQ8pvHShZCWkzOcK?=
 =?us-ascii?Q?/T+hksNq4tuE2AFodvRZhYdIHA/jIYVW36RYDIHoXDLj5/99dAWMgeRkx7Q/?=
 =?us-ascii?Q?3RwQjeuREo3om/CtBx/Xq7LJwfiP758QK/5my2ToOY51ayEhOSAPWq8GroFz?=
 =?us-ascii?Q?2iD9eM4Y1Vf5nKb+Pv+vgeDahyk4qBp+KBf6HRGmOtMRWWHS+yHf95BavkuK?=
 =?us-ascii?Q?M0HYoelIDm52RTWgrfP1REEKDAK3RGHSy0rmzBHCA39lkJme3T/QgAicDAXq?=
 =?us-ascii?Q?Quv7bAckMF+DI9ufCjwutWjg41vb8AKvYyqFjQ9gTNvp8/xCWZpIFb1epav1?=
 =?us-ascii?Q?mwJkqrYTRK5z3f2W0+wcz2Rui7JxJX/PpYQDWDnTzgcj9BFUEbjlb4g2uGyY?=
 =?us-ascii?Q?vyOtHi7ynBMFBoeexd1WnonDR9xoBxDxcAhrSiqMLc6jrvrTvKVFmjmuyuUT?=
 =?us-ascii?Q?G9byHcsRGwn2Pd8Rw+dS7k4gMpFqasmYXlycUpMEP+u0BeW+opTvYQCqlfd4?=
 =?us-ascii?Q?5Le4UV8fwMrGBXt3wvmas+k5vrMC/EcMXqjqwmmlAiFZ/41gpGlPcXKuzPPk?=
 =?us-ascii?Q?UJnVSSpOThabDKb4cyMZr68FK3fakU4t56kl/vhgwTXl8TOLMLMfv1ZEBfmU?=
 =?us-ascii?Q?mxOTCqaEznxCVrXvX8aaCt1mZ8nlPuPIA61QK6Gk0vF/cFrsQwZGUQFRF24V?=
 =?us-ascii?Q?zYl8ifHnhiX/kHLnmZ858PQtRrqUkZl590In7fZwUEkyumxbLAkji5Oxf1M5?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de6e05b-5a48-40f7-067c-08dcc1f17b97
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:48.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+UYq7mdyE+9I1T1LzmkotoTsUNui+Zk6Iq6lTdDhrz3JHaxwslvHU5W1E/Iwm4ih4aVaGW6OUBcGg5TaIeszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

This adds a shared/bass API to check if a BIS index of a Broadcast Source
has been requested by the Broadcast Assistant to be synced with. This will
be used by BAP after parsing the BASE, to filter out the streams that don't
need to be created.
---
 src/shared/bass.c | 14 ++++++++++++++
 src/shared/bass.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 8f02086a1..76287cfbc 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1818,3 +1818,17 @@ int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
 
 	return 0;
 }
+
+bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis)
+{
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+		uint32_t bitmask = 1 << (bis - 1);
+
+		if (sgrp->pending_bis_sync & bitmask)
+			return true;
+	}
+
+	return false;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index f3f708246..b21256efd 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -132,3 +132,4 @@ bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
 int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
 int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
+bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis);
-- 
2.39.2

