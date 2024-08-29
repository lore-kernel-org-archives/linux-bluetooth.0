Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A81AE86F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935775; cv=fail; b=VYMJVEPtJozJKGFY0UtLY7KrX1YR1PaeReIjlflfl7PWv8htzD47qZI8w+Uxg5zkUtANu45m/zj+PTWju8O9JS4aAr5zdzxSrGL83eciEv2DuN1+8fFUX2b4Mf/sozi5Dl3k3jEyslxJcJZ2Io7oP8TOJv5KnCsDNF5XrKSeixA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935775; c=relaxed/simple;
	bh=klDnZ6fy+Xc04clq0EJ3VLDTQAsebXu+r4W1LpWRIc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OsLGEcYNb0P6WdCRYuE0+nZisT+pO0Fitq+IXpgTvXnywco7FIrfk3+NZJpWAayb7xgKreV12d8/O818zgLgOpAvJnpGvXzTL9j6f7KAQPJ3TCrocXtB1fc+cBEbKGdlmGznE8KWk0CcXEtqbA1m/ssa2ZtbhWuHGRvvPjTs0ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gGpZXk++; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gGpZXk++"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo8lN0QMsJKPKiKWbRhVBKDZ7x9km2xohDd5a8U9X9suMCXmvuYsh9nhmqyA5lYwawozge3pY/UxEtNDYHFJ6MQ/3xahogAzgG24lubpLwstj27EO6C2uKzPH5FAhdcuSopK47HKu85VH9Kdf4XS7l00cl7x3ABg8RU2hkEsYkam9tL7/bWK1bAoq2SMG/Bz8gR7SDGPOJzVdVjixaxWl7sN5XQDmHCpJ4RjgK3pbXo7D8z1AuU0egqnEW4yh0Xj3NfPF0NVC+CAxIJQs/Z6WLBwHLFWtN6UT5+ElgHx1rvavu9iv164/5S1UAB45tMg6y9exZhWJEd/WLJgga+9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGT5rxydsj9x+DVZG3GqjZudONw42DWsN+IDAfyzGpk=;
 b=PeTOz7xkBhss3IlLzHbNIoxdYDE7m99tT67wF2B4ilTGCWI190OcUFHUoCZ8jN5IeIor8cT3naEgNcpwKZMJyS2+5EbkjAHyEA+6YAI0QkgngMFSgJtbEx9ah+KXVAGM/Vm4kzuxBLPrVBNBXqfitdCOY/X4KXIG/oh1eDKYgEh72dYGqjDqzooSu9L8PpCn1ppM+gtvd4wgcsNiW1mt/Xv49sz+J5SlJNQ8etbqjzFMdhxsokGWfoX4aBhYzA66VElSGo2Y4hYp7QM2/BEFFt03ZvgpLSr9g7kJcw0Kuowwwbo25e2h6NBYwTGuYICxUvzA5SmpbPuX6LIViyjxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGT5rxydsj9x+DVZG3GqjZudONw42DWsN+IDAfyzGpk=;
 b=gGpZXk++MeRa0MnpDBJw5wnO9yxHjDgbrVzkH6umaL8JM2JRXaTLFBejVySmA9GoUGKCuIQQx5AorYqt463h21Eii78FzEoQSNEOzfSPzHxkITdCq4evUkw9bkybilqE4lcdzj1DJ1jY7MLyZeyuNCzUCmsPltRH7EYLCMgsJJShTif5PvZjf5aco0tY8wjbf2/WCfwfwrysy7DrLTeuuS5cqGQJ5lXLEDJM0HHUtHS3yv40OmnOBgegOJpMNaQXQ+y89jHBsnAKjwDryFWY9xvuDgvuKBN9H0Fv7UDjDGI9dCWlJ0STRTmaHP7X25gy1QJq387vnMOkOUkrABcuhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 02/16] shared/bass: Make bt_bcast_src private
Date: Thu, 29 Aug 2024 15:49:04 +0300
Message-Id: <20240829124918.84809-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0062.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0c5679-7d06-47f4-c297-08dcc8290690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaP6jFr8tRhxRZYBRvI7S0G/BSTE0eOkISLNNEePR6BXWCRvI7P6gIX0KRJf?=
 =?us-ascii?Q?AMOPQPUU+T3+LpO1Z9xBkUJr8MFLqwDHwr6HIwOq5IY2wOSQmViRGAc3ctPr?=
 =?us-ascii?Q?N1vufc8+R52j15SJlxlhDRgRlWFlfTJ1DkiyltVBuEQ+bV0BRO6t9pKF7gXC?=
 =?us-ascii?Q?vmyDIfjCMOT69O+zLpASJfPCSeIQtdJVtB6seOFX366pGzw5YhdoTEdeAUEz?=
 =?us-ascii?Q?uQjIkgr4Hf9QT/WYcdknPdEvmloWoin4fspwpUPtd8CGf81jw7PkEuWMeAVD?=
 =?us-ascii?Q?mwqrCRSvJMP2InZKSl3/U9S/KNbF2dzNemI/+RSN25tNgovGIKVYfWwi7w53?=
 =?us-ascii?Q?99IA2sOGydOl6a+zBzDf97EZNnSgWk8UueXwqDQerJMdsezJ96+yWfHGRk5m?=
 =?us-ascii?Q?ZBCAu3Oty2Hsgv1xntJ85cCqkR5b2hVNYI3bQIzWHaSSoeDVkFTSMoPAkcy3?=
 =?us-ascii?Q?Y56Hd+G2/pbsKW/NVaNi2/HtYD2IOked5HGOrMQDJJ/LtbUPTorFxKeWHQk9?=
 =?us-ascii?Q?oXqENaTh0l3w6na12vQNEGRIVL9ln7YePzD3m4oldELCnGn6mtbfvuq/TIFs?=
 =?us-ascii?Q?nPqNeJAaQ8/jEAfYAoZ2MpXHh4SVLQzQ5lurgEgJJI1cncLp8CrtrUJWDOSf?=
 =?us-ascii?Q?wGOw7KTrQLdKwHKh/HwGZiM3/HDWsdQtcU5pLrS67YEtYbjdylD8izv62605?=
 =?us-ascii?Q?4Uj0Y8JbgvdURV49h4IOOFRO20i5wDZOmcNUb4HouB7vEX8xfFA7uylUXPHQ?=
 =?us-ascii?Q?374kX+xEi0UVtLgHER2pq4FIlO7/Bn9WGWbG82XjV+vj3tw8XtK02VWK+NlJ?=
 =?us-ascii?Q?ZAI5Ds+j9K+BU0VHV3hsK+ODM4bxtJqDjQO7HIRGDJZctnm8bJxZGB6Aarzg?=
 =?us-ascii?Q?MqiBVlj9ETuBm8tJKsUlPDyDXpeo96s3sDaAu5KrSebzVRX9iJ2+R3K59ntL?=
 =?us-ascii?Q?EruA1zdmUyOxjRSvoU1Ycs6UB7P5cb+hkNdr56uLm/HTPIvSvUxZO4GxcWfX?=
 =?us-ascii?Q?b6HyPNzqGBxyw/FZx2gFg3oQuPa31vJ03DNp1hWh71YBRnImPn1J0tKE4brl?=
 =?us-ascii?Q?Nrh5IE/k7GdA7QYhgS5Jgmrnvb9+zSh4/4Gw4JC1Zs6ZLIWPsI3vrcqRLK0N?=
 =?us-ascii?Q?XbYXuw3SbK4U5I4jtLZhayeIMlqqVzZWdl7EWLIQ6PiRVMO6h4oxXiGKyzs/?=
 =?us-ascii?Q?ba70p4vb261cJhef6eBZvgRqSDB9GyDzkar743voi5VlORwiJc1X7aQb/VfT?=
 =?us-ascii?Q?uyks5rVvOIXQgcZHr3PyPoumFtusF7CsT2gNuX5dh4ICrm3q/POhLFUt4v1y?=
 =?us-ascii?Q?K2vF74IsFDi+ZJCsi6rkeXearHCpI9IGvbmNLQBpNW2Jfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGMhi2jfzNuQngxaL2fIl5qOHxBJcDv5/cXQwbyR4jAilMatQuZmCIAL828Y?=
 =?us-ascii?Q?blUqfkjNbyTttIoE8ft7A3uMqYMUU9xI3eqwtLZowAwoaj3U72qrG9ihGmz6?=
 =?us-ascii?Q?uBu48jj75ep8wS8ZURUHNxR/QplZtnxl3Rd7pHw87fxvXNgQDeSdQotkhHSS?=
 =?us-ascii?Q?mSDzm0YoVX2HCkqNoyo6N1wmVPhBQyEe7at7ri1bc1YV8tIHo5CHjJLvyfml?=
 =?us-ascii?Q?+Mqzca5PQ+Hi/UHPd/RcHpKMPXUa1TOLr0tnVFMptJcIrIri3AlotOJQI1YW?=
 =?us-ascii?Q?1Ib034nwl0xjHxmoBF9VNvG5tS2ZHn/zuVy/POBpEvp4rjoPUDo7jDXqwwgY?=
 =?us-ascii?Q?XR8rSk7xrAthP5TXDsoiUmF0OxuxDSTJYxOn6dqUq1Kk7r2JuYK2T5pcrybA?=
 =?us-ascii?Q?FwC32E1V7/BhI38CbOGHg7PWaQz3GIdUtFqNMdj6XjV7UeAmFOCRndZr60Go?=
 =?us-ascii?Q?TZ7CLaLkCsbJ9lRWJZ7ARIziOatpc3jypGSdnlZ7pMGYpia59t1wRGmuN/i5?=
 =?us-ascii?Q?nuU0bRJz9AFqKeqRJ/S8tCbk1xOfiSHGiaWvYi2T6JOU9c34khjHKhIAm2IQ?=
 =?us-ascii?Q?/Hy/sRqF/puctu9Qwpa13nIHXBQGHpnmf34Go+QrwxRyZC2J5zKgraWoJCEo?=
 =?us-ascii?Q?uEQySAYtbJuBUck4/d+eUrTJ8VG+8xyk1vG20Z+nSE0LQ04P/uldJo5OC4qt?=
 =?us-ascii?Q?pYG/EUdyQXN7e00HA5fCH9NHcro9eOJOBj7lc0HfRRZQAODJaGnrNISuVSge?=
 =?us-ascii?Q?YA5qeeTknutKeFY+g43iiB4iPzxBmSxUyZzlAbTEBZEw/H2wIh4vWFCst4pF?=
 =?us-ascii?Q?YmO0/lMi0gHQc5n8XtusO/wlZnC76Bt8EToqOqGQr9dQ7aarD+IeHbkFqEJm?=
 =?us-ascii?Q?K3YCIljf4kmsZyXcq0ITn58XvBGnCXGb8M3fVXmvT1O7Mo1CtWHIvYBNCi+Q?=
 =?us-ascii?Q?Qwcw1x1LqaPvoW0kU6KymFOJ298vnCitS26DX99FXnEhZdx75GzFay1pCayU?=
 =?us-ascii?Q?KgJwW9DsLrGyZiIAtOYrxAimceiesmYvsn8ToJ7VVqLse/NT6Hul30Nwaekv?=
 =?us-ascii?Q?ScX3/+hX+Tex138poEOrHvKD5BtJBnB4fyzeU8OVZRGvSHYsodzpPUb4NW8Q?=
 =?us-ascii?Q?+9A2AVDgIXZr3nkHdemJ9AIBm92l2U1UImCIc0d0pnBrmfw2d5d7BIOJ3dfK?=
 =?us-ascii?Q?KDTE1sR0HWPWKogcs+32CCNvtAGi38tGzWs/p3qsuWQ54sfXnsv18bBu20sM?=
 =?us-ascii?Q?H9Qhq7YhIqYZotbFjbZCLA6sea5Ej/2rDuOxxdHbSK+LRlicQe6NDN2ChMc9?=
 =?us-ascii?Q?YS2ZL0Pe6FVydRysLVdhLqdMSNGuzl7TvXHR4TbGqGOkUOiwOywETdCokc5P?=
 =?us-ascii?Q?Zkw6oIdmimD6CMGnZ1/+EzUADu5+ZU0gj4EQUWakgk7l3fWS3jyDRlGt0sFT?=
 =?us-ascii?Q?zRq5u2/Y09nzWKiwmBC6+3iDbMhJVRT2oGphL89PBQwAvol1mejtiamWtPGT?=
 =?us-ascii?Q?gjy5rHakWNfhj+JZMtnMiMuwGhTzM04QVPKdo7oCMHIcSPQa070KmNXH6yFv?=
 =?us-ascii?Q?MMq08Q9imnsQoPMsU/MS3wSG8OZB6d0JuN0zSWvCjsK3jpXvt+n4C8H2J6fV?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0c5679-7d06-47f4-c297-08dcc8290690
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:31.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwF8e7dLHq6nq5h4ZNskAimZKpnYmwDkNjwEI+VsgMKZeeHeirY7FDR8AO7YHy+mKFEVLIcQdJNmUHQggHPLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

The bt_bcast_src structure holds information for the BASS Broadcast Audio
Receive State characteristic. This commit makes this structure private
for shared/bass, since this is the only place where GATT characteristics
should be handled.
---
 src/shared/bass.c | 29 +++++++++++++++++++++++++++++
 src/shared/bass.h | 30 +-----------------------------
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index bf739526c..131f978b0 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -78,6 +78,35 @@ struct bt_bass {
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
+	GIOChannel *listen_io;
+	GIOChannel *pa_sync_io;
+	struct queue *bises;
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

