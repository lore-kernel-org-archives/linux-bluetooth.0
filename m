Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7EA19B58D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139747; cv=fail; b=SDZxPPMbILlC5BQOGvMiWBoGdOXiMC9ZBDYTV/2hc+NLF9azlCeDG4Imi33K0+T/kKkDm6aDiU2WBEb8DRtelsHr0qjo5D5x5E9LFh6dCzsMaU3DPvUhnNv0ZAZqOoXxTrsS+1fF/+d0ZxN64Qo05e4QzsMwgHKjr/sxo3PDfR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139747; c=relaxed/simple;
	bh=iPXaLU5EAwVsxn0iBVLFoaqPIyiNebTMQUK373tbAlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeImaF8bfyTTOqRbhKQN+MZ28kcd6Oekfjg3msdqSwJur5BWwPHZcoDMTk3abvcNeZLLL/2EgmyOPS9mEpkCNosB5DndYS5e4cTuYAh5GUPB/VcoSd0eHAgcM/y/5tEDPtmWBDf06AprPBgVfc42aEuqYaZf1BiUmtynHM8HZKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cGZbxzwH; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cGZbxzwH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvGbfzNKIjNxCH/PZN1KpvPpFGBjtzDEhvlB1SNpF7PtLqoUdms3pWcd9lFsgpRK8M89b/G+Mh+/LwrNOOK5pvRF8JNwAa/GUiOyGWLd1xzwk+q3AQI7MM+9g9Xp/Szhdm+8YFBEHeCPzYd+qPcDFlfzyK4I1DgtABJYdc5JZvfiOzq2Arovq5KJz2NtyEktpOu4tqB2o34vknlbfByA+eT6DQ/pJu83riCt6rLY5xsgXQbdUz+qAZp7vWPBWS8JXE7Yc5UOl8Q8yLKpKurt3mIePcfGQ1bcKvcc+cDZTmxXxgJsQfcViihvPx6FgocXRRUVFC8RxTj/DiHfB5GiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JizQ50A68A8iOZpi8FAJ2q902e3i4soN7UiXw+nuBWA=;
 b=pf/zU+lXrjuZysf1VgL3h7pznBD7l8hW8ToQIEqsYD/Eom4TDpLB//kFDhR3+eyrqbMwtb/hcRsZVGIZqPcuPDL+Zici0H2mX7T9HzMY8H6t98HqAvKDiojAzCXZHZB/DvtpSj5PJYuMjeMywKc9VraVCdKDDh7XR0RU6Tk6F7AZ2GIO5VphhgXmj7LeC4ilGBYeLYM4qmw73LHTF+9UnbgPC77MH5qO+OPgFY0s1g4rHPsY4XDJYdZwoIeUSVu34jD+JIKkpwmrbwh1PqDy1YS6UGlM7O1OxbUUouNhJRRboaf06VfJv8Uw2wQ9CApjSo83GndBm9aq48oHoGQZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JizQ50A68A8iOZpi8FAJ2q902e3i4soN7UiXw+nuBWA=;
 b=cGZbxzwH+/TU29LxKnuW4A9PD+W+/Z4OUtTnU/lUUqczRmB5OD0i4u3AUY/bejirfytXK0zkky9dGrdOAV5A9YZQfdJj1P+WcE3RtPqzp4+degXHsRZlcFa2zE0t1O0IAZFMfKj+8lIsgre8+JIL/83edzhRsPSDDFzmwQ1lxnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 02/10] shared/bap: Update bt_bap_verify_bis to receive caps
Date: Tue, 16 Jul 2024 17:21:59 +0300
Message-Id: <20240716142207.4298-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 277d6e31-36e9-4663-2824-08dca5a2b5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUQLw4PaKoFQfGh6XipXMhyTbsXDQYy3yWGs2hW/oP+VPEgofJTaehLZX6cD?=
 =?us-ascii?Q?GOXRqpdgbO/lPlPQPuTfRVJlvpyEWR0UoBBB/y2VXOKL5aiON4jBuIrxO4g4?=
 =?us-ascii?Q?6wGbCLOLRhAUV3PQ9yEJU1iE8trNec0S9Dc2SlXP92KyovCNinDTXrLhpb3I?=
 =?us-ascii?Q?EuWgo9j/HYU09SzS2e2E/UVoeaJRkGK90iNHSGxHdlmkSMg7ce4CVZxlugYL?=
 =?us-ascii?Q?iOxAX5KJyXzZmtjgMhJfhZAafyoJXbkqZ+jge98EqSiZt3k9gPsPO86fGvTc?=
 =?us-ascii?Q?RdVsgzYKmr/74McbX7QcqENVAcXndk83SNECjvwUWK2SPzvXf6OMlR9IaD5Y?=
 =?us-ascii?Q?oikIUELIkj4AUXSl27MOr9X/Vb69iu0xs46jGL2kG2GKukgJmgM9y1q16Q0E?=
 =?us-ascii?Q?7gQunnuKbx0YmQjTJ5UODa9FiWKHfy/LwABcwNvl7FfLn0TAaWGVXcLgH5z6?=
 =?us-ascii?Q?DFbt0KXzFgvm59f03Ab6T4cbOr8Vr52oqwBn5QOYmpZMjWFs/ZSS31HYufB7?=
 =?us-ascii?Q?qfHjJTjfXi2ElueMs1/bdJ98I+ysNbj1+IeW7g0I7ZO0AyjnseefYTkm/1JM?=
 =?us-ascii?Q?scbvRU9d5LKyyzB7B0cIjSPKwkS1cp/xu6hN4k4UEEld1IpS7BhLyBoF6ZeF?=
 =?us-ascii?Q?tcoKFiEBxU9oIfEzV/PG3cZ+2J77PvbmDosqD2xMC26uqKqWDbtxqXLAyu3G?=
 =?us-ascii?Q?8KqB4IdzaeWQXKDIeNDRlFaZBvOff1BB4hBW9V6FHJ/zpz0BGumqDXzNI78t?=
 =?us-ascii?Q?XxZ21Q84okwyPwxX+n2/L2SjlhqFtc0PqB1pxIDv9n4rXky5S8ug2LI85U4q?=
 =?us-ascii?Q?XONf3lwwo2Rba4SSIqPQlrgXku/Xw07Q1n6Y2HWgwXo34RPxcfKqiE+SVuy8?=
 =?us-ascii?Q?Ng61O/NPKU7HsVjZfrttRzmE2WHkk8vy4V8YJKgetW4HiDm0WRzBRDaU+Uq3?=
 =?us-ascii?Q?i08ZzYWmAlK8T5WUoIS79i+3zJjrKE3lVpATDPBvRRLIRNmH4nit7K3LQI3o?=
 =?us-ascii?Q?+NTxMz2juAaOAfaK34WP2jhz6pPUzKRynnwP2zOhqJLtxfiaZ6115rcxdRu9?=
 =?us-ascii?Q?JHrrtJAFUKX/C9Onj9qL7MenI9+FMmNqwUfHYSwkFmC1uuvL+ZTCStosou+c?=
 =?us-ascii?Q?pfOuPmhzKOFykkww2bQqAHqFvlu5p6NKmLnHg9fQV1AG4xTWYvAGGELLspPq?=
 =?us-ascii?Q?RDfEbSoDn2LfB616JQoBoG8Gjj5dVnxfq0+BLs2KOKXQfizrYPFjLnUc7WMD?=
 =?us-ascii?Q?zBgQIHfEofdgXVxLqyiTgbRjKk04Ow5dniB20+uW38m65PXN5PinMgHV6M6Q?=
 =?us-ascii?Q?mZLISNkv15O58qS7ttsHh477nDRmRiX2zoqSkSpmufy9Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UIRC366xBAgcs2kaCtvhAD7VNJTqP9lFHEVpRftptSaNwbldXu+qrwCD/GnK?=
 =?us-ascii?Q?y1xTP77EnFxo+s3uLM6Tw6il/EYrDchrifwyTccar48WrI6Wb0sz24RBLHXT?=
 =?us-ascii?Q?GrCg2xuruxkvBuqYr4KoFs2o5rCPD5/XjVYDJOiApDc1j9LnTt0NPAFR7Izv?=
 =?us-ascii?Q?11hh90YkRtXPTwTBwEauKbjIUP0BzkCaAMtsn840IVn0c+l/0iCB19nDDifJ?=
 =?us-ascii?Q?32HY4f6FGFtKWFM85i2pRRPD5ZoRzGr1ma4spUWQ4GGj5TZjJ5rLwt0D7QRC?=
 =?us-ascii?Q?WxQUIruTBCKNdGgVIp76Q7MsiVYeGE7W/XyjmllVjceA3Ga/nWycxrUHqWkO?=
 =?us-ascii?Q?+pq4CQOIETl5krmCkuTTkZk5ueOtz2FVTW6dSvQXsCcs3iAlwyYG4gAocFhX?=
 =?us-ascii?Q?aOtl4k33mpta4RWyOi4bGYnf3+d1GYF+2hIcILmKH+hkqmJqrozKbCljmnwI?=
 =?us-ascii?Q?K/VWHWoVrfLlpsJEsOikxcExYflRjdwGfMkfCyLlv0mz73yKmRNvaahCFY56?=
 =?us-ascii?Q?w60IVYwu2WPzCuzrqv9I6JnpCu3QDuyrf6Fqv4QiFGU90M85a2cQMUDi2gIW?=
 =?us-ascii?Q?IF/Kt5gR1fc5smID2C60m8Ew3ej/2LA79kv2O1F/oBKdMZ3JBm7H3oaxXSDZ?=
 =?us-ascii?Q?ECte3GBjSyteaI6+HXY9o+W6by2Xygas3LBfP7UhTBCCuCA9chIGqFBcbWKN?=
 =?us-ascii?Q?LLBg/hScGf78cokJcjRcZWVQSHXL1dfVvX4vpSG1Q+olwN711W9GL7l8icVS?=
 =?us-ascii?Q?uu8Fh08HDptWPubc3fri53/l5jQ3qkUUM9LV7UO0U23fOZo96xyff//3cI2p?=
 =?us-ascii?Q?bukoULHRzs/lYVJeAsGAhPrbb0KQkHpkGwqIkHYbEZGBKkFmyUedMb1svSZp?=
 =?us-ascii?Q?X9I79st5w4GZpmkyYN9wMwyhX8jMOxqNSyxgRKD4LmWLEc7Ddphk9tbQsh+o?=
 =?us-ascii?Q?yNT8lBcV9lfyQgmcurL1O7uzmV7pYyFdD3rmie6HUGowA7T9QwabTHNIAYEe?=
 =?us-ascii?Q?6zwE2peCU/YMKs6x2AF0WUrb3+EIGiNWYAMdB4AfJPhv67D2wvgEDlnr2dW6?=
 =?us-ascii?Q?uRSMaLS/Al2UWRopc+RXs60bNOZ09+jrhsW9YfW0LF7A3Ty2oyQxQce1GI7b?=
 =?us-ascii?Q?rYzyr1XN33EHgM160J37y89Px0nYtlf2klWbl8qXqtL9L8mgglon+UddFxEm?=
 =?us-ascii?Q?2MpV10TYoh8F9EyL8y+sH0AeP29boKhgZ4/nabSQp91Hgb/Dk3xYm3ZoX4Gh?=
 =?us-ascii?Q?gO4ZrcUAF+KO44nZsD35M8ZYNMFMoAd7juj0ifH0+0FgFExDrpcB9sorzRHv?=
 =?us-ascii?Q?LPM8oPuB5SIdEnnV3KxjoohcTQmOcMwl1vp6IDX42NZP0pj/BOhqYzFo23V9?=
 =?us-ascii?Q?YqbxWQsh3d1WsC9QszXwkh1jeJoR8QKKZ57tIxXNaYi9Hbdz7z3MAFW1XHXb?=
 =?us-ascii?Q?j8n7xv8M+UVQi3+VvxUFS4O9gabZkUyXDIRjsL44Wtvl4+TLYYZVIshNMS5j?=
 =?us-ascii?Q?jKHr/uGsokBs7PSxaZ3atXzlQNWfKgsQWvlGrIdyTAZKRo6NDhYB5c/DECcv?=
 =?us-ascii?Q?MuJ9llFsY9NXuj/yUlGqupJFXlAtfG6u5dLG8YUGgkD4roMoxEScW6a7ogob?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277d6e31-36e9-4663-2824-08dca5a2b5e9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:23.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8NPXd+xaie70fMGP10XU/CpnjFfSnHLazus+SIx4W+CXAIo9nS61SRRLw2pkJtbvefJ5/LxmxCHPSRGLo0RlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This updates bt_bap_verify_bis to receive the already merged L2 and L3
capabilities, instead of computing it internally.
---
 profiles/audio/bap.c | 11 ++++++++---
 src/shared/bap.c     | 15 ++++-----------
 src/shared/bap.h     |  6 ++----
 unit/test-bap.c      |  7 ++++---
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index afa938091..2f37d33eb 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1191,12 +1191,17 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 					l3_caps->iov_len, NULL, print_ltv,
 					func);
 
+			merged_caps = bt_bap_merge_caps(l2_caps, l3_caps);
+			if (!merged_caps) {
+				free(path);
+				continue;
+			}
+
 			/* Check if this BIS matches any local PAC */
 			bt_bap_verify_bis(bap_data->bap, bis_index, &codec,
-					l2_caps, l3_caps, &matched_lpac,
-					&merged_caps);
+					merged_caps, &matched_lpac);
 
-			if (matched_lpac == NULL || merged_caps == NULL) {
+			if (matched_lpac == NULL) {
 				free(path);
 				continue;
 			}
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1259ee3c9..3381ffdd4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6639,29 +6639,22 @@ struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps)
 
 void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
-		struct iovec *l2_caps,
-		struct iovec *l3_caps,
-		struct bt_bap_pac **lpac,
-		struct iovec **caps)
+		struct iovec *caps,
+		struct bt_bap_pac **lpac)
 {
-	struct iovec *merged_caps;
 	struct bt_ltv_match match_data;
 
-	merged_caps = bt_bap_merge_caps(l2_caps, l3_caps);
-	if (!merged_caps)
+	if (!caps)
 		return;
 
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-	match_data = bap_check_bis(bap->ldb, merged_caps);
+	match_data = bap_check_bis(bap->ldb, caps);
 	if (match_data.found == true) {
-		*caps = merged_caps;
 		*lpac = match_data.data;
 		DBG(bap, "Matching BIS %i", bis_index);
 	} else {
-		util_iov_free(merged_caps, 1);
-		*caps = NULL;
 		*lpac = NULL;
 	}
 
diff --git a/src/shared/bap.h b/src/shared/bap.h
index e63161dca..3e68f00e2 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -255,8 +255,6 @@ struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps);
 
 void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
-		struct iovec *l2_caps,
-		struct iovec *l3_caps,
-		struct bt_bap_pac **lpac,
-		struct iovec **caps);
+		struct iovec *caps,
+		struct bt_bap_pac **lpac);
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9dd7a45e8..4b47d6363 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -587,12 +587,13 @@ static void bsnk_pac_added(struct bt_bap_pac *pac, void *user_data)
 		codec.id = LC3_ID;
 
 	for (uint8_t i = 0; i < data->cfg->streams; i++) {
-		bt_bap_verify_bis(data->bap, bis_idx++, &codec,
-				&data->cfg->cc, NULL, &lpac, &cc);
+		cc = bt_bap_merge_caps(&data->cfg->cc, NULL);
+		g_assert(cc);
+
+		bt_bap_verify_bis(data->bap, bis_idx++, &codec, cc, &lpac);
 
 		g_assert(lpac);
 		g_assert(pac == lpac);
-		g_assert(cc);
 
 		stream = bt_bap_stream_new(data->bap,
 			pac, NULL, &data->cfg->qos, cc);
-- 
2.39.2

