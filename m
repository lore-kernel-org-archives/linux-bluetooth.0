Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDE1B2524
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252180; cv=fail; b=AZ5DKf3WkDu11yh8xziH00ERDXqTFC75M3TJuEDrIuBun+Ht+WD3T6m4E6wKPXtJXSmj+F+KsZLSlbW1oDm2a2F3eLEoeMzfzQ7aGxw0I9FYWezyIBEgL+iCdpaFj8+GoYfGXbbA3i2Q2Ymakl3TuByrJz1OBYYiXvpUzXcfUjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252180; c=relaxed/simple;
	bh=EoLwUWUOBhyU7gibLgVH8F/ZI+TfYdWGLy8RjLTFkBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emxxsEBajHDmjGiBkejq9sOJRsM04wkTwJTNKzEtkoomrGs28Eogo56a/gEYnKUrh6Xt7/QQRnRYrMY8LByKiwFGjtdLidNKwtMpCW8c6yJVx0E14uQ7Is21rziMANhXD0swL1JQkFBWP8iRrOG/xWCjJIWq5V2u1c+kBWbvA40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WGyA4RxB; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WGyA4RxB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/uK/lrkx/E9OS3DHuAOoXfo1a1IyZLDaB1aWIFESFMI6uKqkAEt2HySFxdaJ3s+8rJZ5/NJYiroi8465lALXjyUytHhaiD21GMXP6dXdhlh7FBIjeOZVxPQvxnl1sQT3utbtGJhf5jmSAhuuwbhxAyrPBr8PuZTDBfQXLJjZZLgUQzMxREAsmL2UjxeI6HHBjzgVkARiLGwFPN7+pA54KK6y00RTNXhfxxCPH2yqIBIkLx43gugNhXJbOA1FFW4wHq+26YX6z7E5rkBu8d1//KScafgCt0bMs/hiqZoX1aPO+3mpleByCo1An2Efz2ZEr6/339Ar3NoxaIJv8DuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GaUWnikGt/IVfR5prLzSRcGv8npPOnXe/duAlPxmeI=;
 b=hMThwbNtFyTGO7PK1+F53pQ3eZ4lCSlNrom+eMcOaFUKlec+41AJvFjzWxD7BbDhxU1thYYyCq1SI8t2Nra+MFV1qlmojHmpGM4CGe8w24CxRAaNrrKte7mlMYjGByVcxnOzt7zsl0H2xGzCGquFJxN31kIPtrmhhPhIAUAIHOL1UsWxgcjqVtxEyV0UPVtlw8SZVeD2AUKS8VBgHRfhH6sD/NJpSR+zGMpDQBunqhcr94I2tOhRq79RXLBe3xqo8lc6b8xkHLK9y9d0L17VvZFkIjq16QKeKORBW/KScDaBJxiCMsLCZ9VM3tyrfhwRRQNTZURrDHEHufUzyNNNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GaUWnikGt/IVfR5prLzSRcGv8npPOnXe/duAlPxmeI=;
 b=WGyA4RxBcri1bytytH8wSQxJMofoaT0AuF4VvIdo8BsrU+Y8TDa4ptQyXVHOZWkuuUaJLybskX/4G+Zl05Sw1Bw2gUJIekodOPkik/8tK1jk7pqmUPXRKhWPYWpqGesHYTNJtq3ir5LYplItZnb5pkWRWjAL+2mioAD92rql85o94XrCZekTej6m/c96IWt/+/SISOD/CTFVOJXoS9JmpizJ6DfXSmVDAv1oJ4HAZh81ZI4o/L0LsEZTlUGcndYI0mJuQfL2CyajzrIIboYddiz+5zB0nYjl/wVCjIv4uuKrUtwiuTTqcdSQhjTfLbeNFgVIL3Pm0CKxv+PnhD0r2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:16 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:16 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 02/14] shared/bass: Make bt_bcast_src private
Date: Wed, 21 Aug 2024 17:55:50 +0300
Message-Id: <20240821145602.92083-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: ca28df40-8f4d-4e8e-a8fe-08dcc1f168b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2uaKOa6WLM6Xkyrebcu2oSWLhH3WkP1wRD3Wvm65ddeWr8Emadv8IaAX2qTT?=
 =?us-ascii?Q?9m4+QEyX4HVyB7Xb7YkNjrEdRJGU058KG7H23ok7OWm/56auoQfYR0v15cU2?=
 =?us-ascii?Q?VQXYD8Lc1qSrH7XClwiyyIg9E4c3376t58vwU/KKuNWa4ulT2VL6OSCalpEG?=
 =?us-ascii?Q?5x/AclpBMqpt544aBaTkV6DEO2AFcrXJznSgQbmcnub+iFXKcoh+DRnTYvuo?=
 =?us-ascii?Q?CZpI42ufxHaPBIRs7QG3FkDBxuIS5jedr4/DXQZ0t3FuqY2I2KsrWPHq9j0Y?=
 =?us-ascii?Q?rrHDmDisdVmFUHe+E5e2F4p27r1V4btggjJGzAcjT9OX7UmVr8oMqWSRD9Bj?=
 =?us-ascii?Q?IyUXgkk09Elv3m7K+pfCFiYiYyIoyu6dGEZB1T0b3tGWFcDCPGaBwzlOUqP4?=
 =?us-ascii?Q?bPfSQqsaHm6wRODB2jyuU9HVPef+XEEiIxG/9rpkZBIvLofWgwAqFCiupQIa?=
 =?us-ascii?Q?9IaAhEEs1LMbPqwlrJnPRx/Uj5VcYW2BDQ3LXZhu7HNyGdv5fVn447TYNwPg?=
 =?us-ascii?Q?bFR/dCfR2nM9RRCorCS9Cddr1UQVw9f5BBbFc7+irvNsfa9xxGR8LGGX62ee?=
 =?us-ascii?Q?RIdipB0lTg2t7OD1cSVXZeT2UdZI1K/TygSXj/aaBZLxXwL2VnfzvZCFylI+?=
 =?us-ascii?Q?qCpj/AVOU5EdsJqewXWFoaYh6J3gAmbax5bYFZ+XNhmE1KJ/vqXDq2ivXl1s?=
 =?us-ascii?Q?QsiOyKkecINTRxWuG77lJ92ogeL348HXvdFORVJDsnICwngW6ueZXooSXSfQ?=
 =?us-ascii?Q?Shuq2KbGq3ApE7P0ic9Remp8g5LZbSZZnOkrMMHIRDwnj9/avia5tDm4+ADr?=
 =?us-ascii?Q?UtveeRRVNl2uj6RdeWbCxDzMY81cXLbhn9fzhMebGwgw+T37vEObFbYa/pGx?=
 =?us-ascii?Q?Dd6Nb0XclW7fLc/c0wCvoVrzPuRvPUlkOpg1jPbqY23LlpxByULC1yhZGAkE?=
 =?us-ascii?Q?lJq/AospXtDaZf/mWkWLl0gAJ4RWj/vKJf+5OcAyP7rQGzKH14OlgHUyBjuR?=
 =?us-ascii?Q?mireOPPidSqni/vIA1RiCFgpE52Qcy7nPcWKaA0nWcf7NoOafgSaIe94aYVE?=
 =?us-ascii?Q?gZQiCDHjHtMBd6awUUnJqdCM6V4s3LvcOMyy1MCmeNEyXT8I9yrPdmsBJx7b?=
 =?us-ascii?Q?Gf8xKBqOECXsB7W1mu08hiVsGELfVIxx2C0idAKsFGFt0xvHhs2IK5UmqW6J?=
 =?us-ascii?Q?2KgOTid08OORrQ4elFBfZNgSfccT/ZiqVCm4a7s34bNEDCV5j5Ex+sIOWd4l?=
 =?us-ascii?Q?95naoc8jplkphTR/zcPOicZCIiiK93CQffs7/7aVZsq5oCWZdySAD3u8Yrks?=
 =?us-ascii?Q?Y9oNFEHBHezgC30sWiaXAXChmVPOHJ0LlGZ7EIRQ4QlcYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gA/W9/wKwJoTTm0/DeeWdON89K8UoRZiW2ubO3bExnnBpIPya+uGkbJQlv3R?=
 =?us-ascii?Q?nbu7q1vy6EIWDMZx2GY3Evyd/rwWlYjk+S0U71iaohaR5AAY2hXPKGRHfYVG?=
 =?us-ascii?Q?Dd7rZxIucqcapvjKOAZwmoy5j9sqkhfiwL/E8ruIUoZFlcO4u8BvvDHTw/U1?=
 =?us-ascii?Q?Z9P+oUjC9UaqfwOMql86ssM0eVJpegh16/I7dEw73k8wNm7cEpRsyvJ4Joz4?=
 =?us-ascii?Q?vcONoMitkwtpqguNCLgcm3aD3iaoXJjQqrJohVYElSIUZMjqIk4fslErpXvA?=
 =?us-ascii?Q?tP61PD8ZKM8SJ8D2CSW8jeVPWFwGbreRw+gknwDtphc0yBRXMbTRp/qlhSK2?=
 =?us-ascii?Q?/CwFRgCHhAKFa79M1JHYOCbewTsr+Rp7k8GTXVbdfjZED6vKuGn7pG74QmT3?=
 =?us-ascii?Q?mbmqS4R/s5J7AEncZ+h01pL8aP1+RFPl5dbslaov2gGm/oUKtAiNqrN3pjel?=
 =?us-ascii?Q?0dt35dti2c0Telj9DF6h4FO8aj50+ykPjGDMKWvZrdVyqJZE49Nv+gBOsfqY?=
 =?us-ascii?Q?aJBCLBvE1wRxn+kQ+PaE8STaB3O72IkNKWgeNLEPLs/EsVu8rqPsfNlHKrPL?=
 =?us-ascii?Q?+QY/Mwsz3dtDdsMXaKTInyLkyCcyTCrkpxEpxNQ+dLyNuSWLrYMqVrcUWc+H?=
 =?us-ascii?Q?grS62+B4WZGd6+nx/NgVJcGnGW0z0ZPHcJlLnoPq+Jsf3fRfGq4psLc0Zm3/?=
 =?us-ascii?Q?n0hoIE3HJ+vvSPDDRHED/tYdxrYWM2ppDVqpt2OgVYuo0+Al0Z0WYuDJyZ01?=
 =?us-ascii?Q?ZxlOlEY5K5rzWOwU9A+Ei0sux3xicRzUYwl3y2TuzXKk3bUAwmxFZ73PqfTF?=
 =?us-ascii?Q?y1ygn8UVKomVj/QBVir0on7oD4k3nY8c7LCKnrPAdMVgo8XDaZEQ8zriXk42?=
 =?us-ascii?Q?v7F4zO/hRZ7GxXjof4sZg8iV8LKUatKIVCeDXFfIP9LxnRSspcmOCS8UVEpx?=
 =?us-ascii?Q?IfIKP67QjS9bSJZDX5TRnmotQAhMVQW0AXSRF8Q9fSKXMlrxTy0mjNQrtf0q?=
 =?us-ascii?Q?+B5DiEWcoZOiDk/QvctoGTq8Iqom9O8BF4ESxzkyrEA7n1iQdnoEJDQxi78D?=
 =?us-ascii?Q?22zYF0FKn9opOA+fbwKYNQlrlP0qu1EBE3AeNQK0GrA491j4xq7E2WPWLfHy?=
 =?us-ascii?Q?1Vt/YAT8YLxHyz9nxmfAnpn2iasg2uLQN2ytoEWl9iJAgEHrax/K/i5CF/e9?=
 =?us-ascii?Q?ARERecM7LWDlFOhqoqKZIR7iB5L7LzqiwqlnSmsg4I+sQqnoW2i+jqir4ftI?=
 =?us-ascii?Q?ejaiH/2feZ761tteAreWvmAEb43XwfLcYJenYXQz870M/XU/nNTfsAhGLx1S?=
 =?us-ascii?Q?aPxkv6lzLgpB98vl5YgRBeoNBhfbI1x5EixES/v4s5OJ1SZRzQrNOL0ZqsZl?=
 =?us-ascii?Q?39yRd1mD9+3vWab1JAbdoKbFnNwVYZ4MVsevnXXpCDIZ45mYpnhckcLa1RbL?=
 =?us-ascii?Q?Uddk5sXL4ofLaHqTU+Aogsso/IYMi6x4AseNgHboqg4jd1iiv2lyU5j7HriX?=
 =?us-ascii?Q?c7/byD9YUgizP0EEwqmFb/WRuiPGYh5dV5A7/fPXywN0wgG5w7qLBPFgvvZo?=
 =?us-ascii?Q?rl390m4KTs+a+WTPE4YR/KPvagBLXuu2mfYWuwGqbupY45V+kWbkWPMmciMR?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca28df40-8f4d-4e8e-a8fe-08dcc1f168b0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:16.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvLYSMr0u9E63K2x8WmD0BXUikHl3bB3m2WedV5VomPR6GUk9Zw92fio9S/Tu97uo9hJuwMs0TUAYUgZOyNrdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

The bt_bcast_src structure holds information for the BASS Broadcast Audio
Receive State characteristic. This commit makes this structure private
for shared/bass, since this is the only place where GATT characteristics
should be handled.
---
 src/shared/bass.c | 26 ++++++++++++++++++++++++++
 src/shared/bass.h | 30 +-----------------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index bf739526c..ce13f2c24 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -78,6 +78,32 @@ struct bt_bass {
 	void *user_data;
 };
 
+/* BASS subgroup field of the Broadcast
+ * Receive State characteristic
+ */
+struct bt_bass_subgroup_data {
+	uint32_t bis_sync;
+	uint32_t pending_bis_sync;
+	uint8_t meta_len;
+	uint8_t *meta;
+};
+
+/* BASS Broadcast Source structure */
+struct bt_bcast_src {
+	struct bt_bass *bass;
+	struct gatt_db_attribute *attr;
+	uint8_t id;
+	uint8_t addr_type;
+	bdaddr_t addr;
+	uint8_t sid;
+	uint32_t bid;
+	uint8_t sync_state;
+	uint8_t enc;
+	uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
+	uint8_t num_subgroups;
+	struct bt_bass_subgroup_data *subgroup_data;
+};
+
 typedef void (*bass_notify_t)(struct bt_bass *bass, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data);
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 878bab51a..086fe335e 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -8,6 +8,7 @@
  */
 
 struct bt_bass;
+struct bt_bcast_src;
 
 #define NUM_BCAST_RECV_STATES				2
 #define BT_BASS_BCAST_CODE_SIZE				16
@@ -32,35 +33,6 @@ struct bt_bass;
 #define BT_BASS_BIG_ENC_STATE_DEC			0x02
 #define BT_BASS_BIG_ENC_STATE_BAD_CODE			0x03
 
-/* BASS subgroup field of the Broadcast
- * Receive State characteristic
- */
-struct bt_bass_subgroup_data {
-	uint32_t bis_sync;
-	uint32_t pending_bis_sync;
-	uint8_t meta_len;
-	uint8_t *meta;
-};
-
-/* BASS Broadcast Source structure */
-struct bt_bcast_src {
-	struct bt_bass *bass;
-	struct gatt_db_attribute *attr;
-	uint8_t id;
-	uint8_t addr_type;
-	bdaddr_t addr;
-	uint8_t sid;
-	uint32_t bid;
-	uint8_t sync_state;
-	uint8_t enc;
-	uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
-	uint8_t num_subgroups;
-	struct bt_bass_subgroup_data *subgroup_data;
-	GIOChannel *listen_io;
-	GIOChannel *pa_sync_io;
-	struct queue *bises;
-};
-
 /* Broadcast Audio Scan Control Point
  * header structure
  */
-- 
2.39.2

