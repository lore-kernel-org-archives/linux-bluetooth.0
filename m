Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81B52F8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676698; cv=fail; b=Czl1BtG44otbzpow5GodjUb4HnEIsDNCm0xF1l7G3fi1UKhACUlJOlqIzpYsVEO5+cA1RXutXiRJKGx8Za/0fvQ16fkq2IU8DzLo1leERq/QeHBVlxtnnyQg8M3ct6hClwyhZ786rDF8b+gjKHs7WoyAxD5CEESyyUWvtGMvYrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676698; c=relaxed/simple;
	bh=unjOjte1QYmPxs4ovys/9jov/JvKHW/iLVTo9wUeUpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmLojv+ix2HD4/Usmutb/4aVffq8us+wxafXprlxwqzjXU4lk2hxNF6/pzStulC2F0870kWnbTcJg/D2Ujv+2Ruk4qsHyfqQi8qjB9mxjjO7iE2F4fczkPD1JZeDTcIMpP3mgd2ZNuPZAFTFbLvW7hEUZAP0RhZY9cr+Uij6vKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N8V+ETRd; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N8V+ETRd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCultwEq6e8Bj36yK6GGgqnogq56x7xmPWeGh/BqkI5Y7XrnfVFTzscm2+47ET/DfGTKsx6eSDM7LBa2t0MCDMeq/uv8GnUT1RaPv++GrQaKnL0ZNuJfawbMirL770XPOqIiLcLfQ5LK+w5req8IUmflk969DmuVxosPiV7UdHYXyTt1RhcWaTU38YCq9g3rdfAZIoH2mZxgKUfiZnJb0eYjo2RdvI3aUUYXAOcgBoMkR6LPFJeBFkpmW+1+d3ikXb8Cdo0HhPtD8ScNI0/g5/9PvhTKaf4LRE9TQjDWpFUysLVckurgd2Sqg61N0wGFANzCP9+HdFcs4pONMtZnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kC20XzJxPNlb7NIkWH/HSsj8tviw8Dcc/QBzeQbmSM=;
 b=hRCRUoZABbATQREWHhr4QsTwGyElLAaCCqEv+fkHqGRB8AqhWJ7Z5s0zZmo7Wu4DpVNL5SZaQaJ3nksVdCvlwiASHLfa652neydZ92B/hl9jIjBSZezLVqnKHlbfxSzEsemFtpz22Ir27t3i/eREIaGBEnfXl2NTcoQihFUtsYeTE1pPEEnsO+J3Xe49WFON9g7akxR8uH4I6dNwQ+8mOHctaeiyXYig9R6w629i/c3kY+Ec3l9lsUWKaiTzW/Qp9cMI/CElD3IHGLdsXeldjEI9q9gj313IfIPuu+OXXg8gzuhLMYytgCBuO3Iz2TcBss/si72lGBDlwmB/eZN0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kC20XzJxPNlb7NIkWH/HSsj8tviw8Dcc/QBzeQbmSM=;
 b=N8V+ETRdVBJNq0MzBsTjZNDxg2Ha7kdONOnW0IGWC0MINC5IcXuvVuExhnq3klntxW6H/VqwGrWtLb8uX0PQJepPmYKU0qsD5W+mnCShTcrlS2ihu4sKLmtC9BeNFNdWemR/lUKmZ4WIN6aYThqfjdcHY04bqoxDuPep6X4hHws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 15:04:52 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 15:04:52 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Fix bcast endpoint config
Date: Fri, 19 Jan 2024 17:04:43 +0200
Message-Id: <20240119150443.3163-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119150443.3163-1-iulia.tanasescu@nxp.com>
References: <20240119150443.3163-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0053.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ece56bc-62d6-4ce3-bb19-08dc18fffcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAv3PEVEKz+jX55zar2gofa6oD3PoaYPSQTzN3tinf33blKu3elzn5qBCR0COuFNCDrlRAPK45h63FJuSXALtEbLluxWftM9gL08Gm3i7mkY1GHu2IQ9QDqHzgtqnKWK2qx1+EqlhF17u7DSILtHaPt6LcASNJ/2iV3WqTogb4byGGm+A8d9kGTzb4kFzvcZyIeJR7TTSzm9kR62IHOcOuB/sRlhrKClleCdQVOBgNh0RkR018rRyvWiuJtUaGO9J/r6TYo/z00K4FiuwoqmWUmTVVhkcIRy9ZH1zj2f2BiEre7Ib6auyK2B+bguCo3ZycPqiZ5+9uif4PN6hoeqnW/szj302OZN+GNpziyssw/Dui99JdBOHelt67eIUC2cojuwHWK/amYWNtTDXbv/KWg2851oklr0jhhj1Qq2cTwpYm7RWCfvXDop8Pj+P+w7M6NWJiQEwcAIbg9kJA8TsOXDh7u8WpzeVJJn4pGYZEgIz27ZJIaB+4uDrh1SdgKyYDaBsLO2G7OFmb5vwWqvds4CvZpjZH4uAi9s3xmzMqZNTY7HIDXXjHH5fRwHGYWt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(66556008)(66476007)(66946007)(316002)(86362001)(478600001)(6666004)(6506007)(6486002)(2906002)(6916009)(8676002)(36756003)(8936002)(5660300002)(44832011)(4326008)(26005)(1076003)(2616005)(83380400001)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hk+xkUpZ+oYKUggaguTaM86Ozif+iaJfvlG0LYVgvZo7Wqg26qAqpuFRf5yq?=
 =?us-ascii?Q?NpA8uMO3DRioTL6KTHEcdwGk/eUjB8MGPgnzTtrTzKTwl2QyH/safUdLuT2i?=
 =?us-ascii?Q?1DqktlJbwGJ2dnfdjMxHwUBM5PkwrE14BMyWIRVC256/Ov1GYav0PPU1ROJW?=
 =?us-ascii?Q?B3wMDgpcuwUpMUwLTlcDk6wEC5Bs58HpvLSj5vmnkj2v+a8QRkfKdyIFMwr2?=
 =?us-ascii?Q?36s+NBRyp2HNIKRQZK1e/uXZGEeKDZNojj/itpbV9bEWU5/TTzLVJQLqIUre?=
 =?us-ascii?Q?/gBmNjryhg/29FbZg66KSHPAebdJWSdTHdBXRzo4kfqQRIoBJ5emjdD7tcUd?=
 =?us-ascii?Q?SgobI3uizH2y0qLGC4/QBtIOmlEoXsB7OE+9MUkUrHSiJXPh+Uxu6WwWi7SJ?=
 =?us-ascii?Q?9lH6h9zoiwYnsmF45OSO+umfyMadGkowK5J1TX8/suRj1XbF9CmJWmXa0n1Y?=
 =?us-ascii?Q?xzxTvJBrE7vsdI2Npy51kkFOlBHzVNj6O4BR6KF35eX+gvR1alII9BNwew6e?=
 =?us-ascii?Q?ELPhFib1ltpiWAajEesyRGu6jiiDrNZ+taxkn9N+QSbAumZgi8ckzmvOwdH0?=
 =?us-ascii?Q?br1yoxh4DBkLjf4VJjdlOCK95dzhk1LYJjsJAkZWuKBmM4voUDQQy1n270Z3?=
 =?us-ascii?Q?I9akmSJNXOjiU24ZAL88Iks9hFrjVHPyhOXsJdbEf2wBuWxS1dc33GkgCvje?=
 =?us-ascii?Q?zeyMahh9CEOJRcZcDqo99AxqW31mqJwiPv7YT6H6snPeMiazK/x4KGSGjbs5?=
 =?us-ascii?Q?l7j/BKJ2wtHH/w5g9DQ32+mg3oFDaBCyp77KB79MCMP6BDLaJNDNLlpCIf7l?=
 =?us-ascii?Q?py62o31DlJXr1pu4e82xxmvY0hlvYkaFZYcENbcmuQh5NaVEF80scB/0dxId?=
 =?us-ascii?Q?LthDzuH+jR+Otv2it6s99ESXfuX5dBKFoJqRaMo6UKhlPaeCCoHNPzfYfG2f?=
 =?us-ascii?Q?IiVfqHS0qvyfjRrOqkN59CaVqklgp7RRrcPZFMPe9CD0JiVYH60PwmJ8wTxT?=
 =?us-ascii?Q?6tIVTCrW8i+SnFprT1JPs6gsICpIYX0MwdjxkmILzOWmeLXrhO1+5Op5j3w2?=
 =?us-ascii?Q?uUdtwXiEZqTqk8hfVqqkGKetgTXiI3q5TP78ZyL1LSv//Rf/jwCz9t/xzm3s?=
 =?us-ascii?Q?DIqWou0EVZONR1N1Di4l4I1nKBM/vM5z1QcabvpUwwvBeRZbKxXXpkAHMqQc?=
 =?us-ascii?Q?76ac7TdJVyKuqr3xQlzP34PlKaTmaLYxgC8fJEyuaKMjbRh5TUY284DyHoGA?=
 =?us-ascii?Q?UDfb0acCUB0vcXzfz+znzR1s+I9WabnRA1w7chvoUxsmAFNmQig1s7UXztWu?=
 =?us-ascii?Q?LMhwRjXu5TGe1w9O0N6cAO7pk0AFM/B3DpFY++aVDC5eUMrpBQtFr6eye0rS?=
 =?us-ascii?Q?LqRbmnYuNaIpa14VtiJ5cKpkutxpOsPCRs3K6DAzclK8MfU9ZCyS9ark5V/t?=
 =?us-ascii?Q?vjjZtgmKnaP7FutYD4bIOU1CRa2oJSlSEo+xMC0qDHW35tweExsyK4XwakYd?=
 =?us-ascii?Q?mGT/TVgI6amhAvui5qjJq/BInfcv295jrXyNCEl12CWdCJ+cdVI9z3DmJbUS?=
 =?us-ascii?Q?dVDnmTQprQTHVHdhsny2qfCSGpmrXvGQBRg1UEZ3KJbGvdsV5x971D7EHMAF?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ece56bc-62d6-4ce3-bb19-08dc18fffcf8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 15:04:52.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ec+9zf+u4RSX+XSM/Ecc6Oi95qkWv+zYQFpCSHNzcthUeGxNTV6xVIMfHT7odjom2oXg4wlFJ5AwAUyxXHzFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

This updates the way broadcast is differentiated from unicast
at endpoint configuration: Instead of checking if setup->base
is allocated, check lpac type.

---
 profiles/audio/bap.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b88876485..137ed7d39 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -617,15 +617,16 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 	return 0;
 }
 
-static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
-			struct iovec **base)
+static int parse_qos(DBusMessageIter *iter, uint8_t pac_type,
+				struct bt_bap_qos *qos)
 {
 	DBusMessageIter array;
 	const char *key;
 	int (*parser)(const char *key, int var, DBusMessageIter *iter,
 			struct bt_bap_qos *qos);
 
-	if (*base)
+	if ((pac_type == BT_BAP_BCAST_SOURCE) ||
+		(pac_type == BT_BAP_BCAST_SINK))
 		parser = parse_bcast_qos;
 	else
 		parser = parse_ucast_qos;
@@ -656,9 +657,9 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 	return 0;
 }
 
-static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
-				struct iovec **metadata, struct iovec **base,
-				struct bt_bap_qos *qos)
+static int parse_configuration(DBusMessageIter *props, uint8_t pac_type,
+				struct iovec **caps, struct iovec **metadata,
+				struct iovec **base, struct bt_bap_qos *qos)
 {
 	const char *key;
 	struct iovec iov;
@@ -686,6 +687,12 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 
 			util_iov_free(*caps, 1);
 			*caps = util_iov_dup(&iov, 1);
+
+			/* Currently, the base iovec only duplicates
+			 * setup->caps. TODO: Dynamically generate
+			 * base using received caps.
+			 */
+			*base = util_iov_dup(*caps, 1);
 		} else if (!strcasecmp(key, "Metadata")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
@@ -699,24 +706,13 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 
-			if (parse_qos(&value, qos, base))
+			if (parse_qos(&value, pac_type, qos))
 				goto fail;
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	if (*base) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
-		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
-		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis, &codec,
-			caps, NULL);
-	}
-
 	return 0;
 
 fail:
@@ -882,8 +878,9 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
-	if (parse_configuration(&props, &setup->caps, &setup->metadata,
-				&setup->base, &setup->qos) < 0) {
+	if (parse_configuration(&props, bt_bap_pac_get_type(ep->lpac),
+				&setup->caps, &setup->metadata, &setup->base,
+				&setup->qos) < 0) {
 		DBG("Unable to parse configuration");
 		setup_free(setup);
 		return btd_error_invalid_args(msg);
-- 
2.39.2

