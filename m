Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35119CCE5
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139751; cv=fail; b=Tyd964JV5mtIWD/Pot4OHx52/APhDi8l7uJlrpzVXlynO++sdsTS/BkjZnN4IbSlY28yBcYkTLxT2oB1cFu/hwgacN7iQe7tKWncIl/TuPoi7p5RrEENMdDEbTNdDnaHrItK384ED40alIqxURAZiP1Rz8ZTdzLvsfsGGVjsGkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139751; c=relaxed/simple;
	bh=4xBj9lxpm8GOXQeRw9dng/g6lY6GngQ1wuLU8l4U/Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXsijr3Pzk8+TYSBxXv7/hR3VkAF1lBVEDX8f0+FEvpIRa2JYO7AGQgSnxjU3mocEdX78CQ2o7is9PSVsDfsoOyupTx2yuk3a5w31wVKzNYw65vYB249FmhXuS1F0+rkYES0N+FMc9PLnrnW/jHCmGvTcPe3SMm9DRUYUVzjDw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eGRaL9mj; arc=fail smtp.client-ip=52.101.67.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGRaL9mj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyn8fXb90jE1HgZ10tuIlIbvleP4qao44osMcSdmb2yXRu2oUyMwmdZL98cOWLp4nCH01DGpJ6+yRW670UPghcIf0/h860NzfuL7iFofp7R5LpJwvbB1oaTRJLD7rKn2beilzIVB+2ZqQjEiAME2pKYrg2UlvcwIcXWxcoPneR1R/1jJ59dC8a0zthyKv3FWxuQrSyV2DiB0L6U4wHEzedi93ki+GYlwdYaqI3UEIH0yBBWg/BU6npYvSICLwyXzk4YvYKINKrTjGe/LRzsGGe3IbfNAXKlK9/3Z+1D9pPOjQLfGHTsVz/1uiKpEPMZqvEn/mCIJove7ypAUa34mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcVQkXbrYgajAMXYT97/wkR7PSB2qrWY+f7I7MFZzb0=;
 b=MtxFz8vyoO59YcoiFYIEGOrNcwfolXkckgZK8Aoqjqmv8wg8L9PyIOguL9Ak4R9ZTs8Ge9ZPYMvelisCh02lZ4BlVypeRjZiEju51SH3rnH33/DQdK38W+fLARTIdDSu06iuqeNzZHc/z2L1yETQVxvSwFe3Vq53cYF8ZD1k2OPDxMMg3XaINq+w6BAxVIXWnzPLUof+Ectmg58sIMnii4zRFdYxf8TdaC46cV19Gkph7TQcdazPs5DFBwdhX69J+DzvMrlsHd8dhyEHh/LiYL4ZoFjIQweffCV/xkvHrHcp4MN6n6/ECmObWcgLzgxYjLYCOcwPPG4w+94nW1RBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcVQkXbrYgajAMXYT97/wkR7PSB2qrWY+f7I7MFZzb0=;
 b=eGRaL9mjxILfv7v/jTBz90XXKvn6ttcPIzk8a2jYp3ZIzKU2zkawJX1SUxkYm/JK8orFsXZw15y53QgekXaDLsYVe6py3x0Q8MKc8wWkYNjyeOOxOrbWNEtIkvFUOPK/8TGhKglE3ItBiuQrSXYdrWJUsf8ulooTfkIqWtrHT68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:26 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 03/10] shared/bap: Remove unused param from bt_bap_verify_bis
Date: Tue, 16 Jul 2024 17:22:00 +0300
Message-Id: <20240716142207.4298-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::45) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce55081-b93c-4ba5-3ea5-08dca5a2b7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOcligUbsg07spfgB3rD+Bd3NRNQsjoX6DNKD4qfsAnvinmKZNQe+nfs1JK2?=
 =?us-ascii?Q?wqtj2RbfrAqDxgloA/bQ1PmzxKaPtwzJcI4dIFp5rlQ7cOSiT+AesdhGV0j7?=
 =?us-ascii?Q?tsmZ0Oukq5Qt0E6ygVIIgm+vGZGNWdvFdymnW42r47wtNSMm4bw4vStKTt3S?=
 =?us-ascii?Q?C/yOVnWZuvRiR1yC3YCu/IX25ZCQora59SQPj1fJKG7gMyGt6g4cE1OP0sAB?=
 =?us-ascii?Q?fxrGEV7nzFkyuuKOr3ymQSRqz61KbS+ikvU93C2+fExgt+0PIafhseMDYSqO?=
 =?us-ascii?Q?3pmYhwbsN6UCWeVtoSEAKsmdwDf4n3Zu8mWlZtasW9j6HkDjs+0GbtzoGH9o?=
 =?us-ascii?Q?ewEteJSzEbA46WWqz/4UPhR4yedM7iDQ69VnHWIIm8XNpujK7MzKScUqV3Em?=
 =?us-ascii?Q?HuJrrtE506cUBxS7B5hQpyY0zJWY310KkpdIwZqrRdWXVq7EVTEg+9ifM2lV?=
 =?us-ascii?Q?G9IDsHtl8omhvshdR4f+xQQ8nQ3fP/vWrabcSqX+Z1nQ9jJH8bAweA3cKG9n?=
 =?us-ascii?Q?Hza9NfhweWBWwXbkYYB8PqXQ35zBN/fzwYqIKaEYD4PzoRpbx8aiZvos1oNc?=
 =?us-ascii?Q?LaCMtFc+Gg15XUPkWjSTBlrzN6ek5QUz7DJc0rb9a2VUK7JIDDHICgQCj7qz?=
 =?us-ascii?Q?90OA27a4jhyHL7oXHs3allO6KyQ+xdR6pfe1cz31VOaBQr67u75jXqisuPxQ?=
 =?us-ascii?Q?qJ6ZpklMlioQ9O1L4vetQ3KFFWrhh+GN7SCjihWT0BEHNq421SnxHOxja6RZ?=
 =?us-ascii?Q?Y4yddbhPgY807EOglGBbQe4e5lMyHqK60EoBlDIkv1M6speBUTzUuS04aW/4?=
 =?us-ascii?Q?fd6XjKb5bnMzQ+/YACsR5S7l2IRtysL9hHgWz5mfiGSqpPcSt9KcKJVB2u2a?=
 =?us-ascii?Q?IgakEcaDa4mABL7jKL9ubyZBBDKpxRxU2odBGQ+6yfiOhr/k3Hb6EAgPXkBn?=
 =?us-ascii?Q?22aee/i6DEYZqQ1i0g8ICytJ+nC+f2CA2kdOv3SfUKeWUILjvHL1Lr7nQ2+E?=
 =?us-ascii?Q?hpdq96Pq8K7HYBhjxuYzX2YhbCytSpGGH8V5OFhrqibO0wQON1WWAVBEyubG?=
 =?us-ascii?Q?cVN21iR8ish3yWJ87YU0pikqaTepIGuerNHrm9ImSLZruNV40LC52lCoIdV+?=
 =?us-ascii?Q?tMmwMqqmfyOgJS+UY6KRhfsXKcW3Qfz+J68kijuJUNlpmALtczat+STaj5Xf?=
 =?us-ascii?Q?pd+eY9rr86HrILynNEbAC3zTNDXAwF+Jm2xwCs/LaRmmId25TSum0aUFop6C?=
 =?us-ascii?Q?/8kRUPDqM/oXTnIgegqn2FCtLWag21AicmudiXACnsiayVDeaQELotdemI/G?=
 =?us-ascii?Q?vICmPe5qtwRSH45p6/DicOIEkK7QlQFhWsCl73cxcdrhqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjjujkUf3cSiM/7pQzwVFyKt1SBCBv5LNuEqll6V3uJr2KJCCtzvWi6gYiGi?=
 =?us-ascii?Q?PNvzDOEVLI2GEoMEhuN7M8sIm4aeViY/huAmhBqNdYfPjFh7P8eEqICo78FF?=
 =?us-ascii?Q?uCEuRI7JMuNjrm9zjYNBtLCLfpRIJxuVMPioAP9Ki7NSD2XbPdPi03SI+cUr?=
 =?us-ascii?Q?nh/7juIxZglig0c4VVMtpY2URx8zL76rXQFRTav9qb9h18MY7UWvgl+7Xbrv?=
 =?us-ascii?Q?iAxXtNYM1/pQYv39DJ3p8ckHYstXgNYyefFkqKJljDq7wDjBfUsIEM7DG1o0?=
 =?us-ascii?Q?7l2HgfbkfaSuPqoySTCP7LrJuU9S24tJRPOaVksQLNbPqv1bbuv6U164Y7Ah?=
 =?us-ascii?Q?QSkO2nR9YlKAMBAIM+BdxLMr5b8EV8mEBPE3KnYXvCKpNnoku87F1Dn/NQRF?=
 =?us-ascii?Q?A3OiKnZdpW9dcLPutmEL0CLUKapQBDUnbhT1yrfesw+UmXzPHf1YS0PYqfA7?=
 =?us-ascii?Q?Xsli/3c79wsMYhmqP3fTtV4hV4DIN9GM/VBtvhU4Fi6cScTblDoNxSQMnYw+?=
 =?us-ascii?Q?MGf7VEyLS8pTw5dsqzpvvaMz+aWRkrQKJ2wdmngBIZiTDAad9j3eDU9S4eJH?=
 =?us-ascii?Q?BEegD3BiERSGz7pvkU9d5kE+CjTeqMc16TKZI3J9+tcfi6M4IJTpujbXL8E0?=
 =?us-ascii?Q?9S1yPgbK9nBs4jGO/qkdG4qdiBU59jBk6/TptdtLDeyVYumcVYhqyeFeZEnk?=
 =?us-ascii?Q?LW4mBs0W8AbY9GPxbkAXDX5AR1SmOep0P4/lU43lefV3QWtY/3Wgpm+IgBS4?=
 =?us-ascii?Q?vP96mgFDurE/3HfblHN6BOHDHOGC1SKDppWMv34b6pbF3W/VKmiZXtlUGtsd?=
 =?us-ascii?Q?R/xCUt14RJxzKjXLGFijVIaxfPXy+KtnwK9DMgQka9st+zkJMZNYmOo521S1?=
 =?us-ascii?Q?YR3nn5i+MSPYnnGD9TxMAdtvQqdmbM8yGKI8djgaGeMLlM/cNwwjQll1mpU0?=
 =?us-ascii?Q?RJPXbUpkAcQ7iwhPu38YuAgipNK2kQc7whK9SqkHKi1CeenQNGoNzDNIAdEQ?=
 =?us-ascii?Q?Sx/kdg6lPBpNZjOzee7vgEorTIMa4XffIefQBgeS26/w+DQ7NQ28zg5pSoLU?=
 =?us-ascii?Q?AmsWHdo3LcTxx9nHCBqlyc7Nr5OfmkUlaxvfgm/SQtAohHwXvGQimQf13JtL?=
 =?us-ascii?Q?+1uopWoUufbQElyTiJ+yEmezUjmr/tC7K70jBZXlJEBQqSys0rKJL60YqYwU?=
 =?us-ascii?Q?GP4QMBoXEamk2/GQK5+IAFoDlb7tKuUiI2+jy4fFevf3G64Vq+qLCUN8p0eB?=
 =?us-ascii?Q?rMjSIn2RpgdZR60WgiBwNgvQDUVOxPybeNnLX7LeNR0vfK58xHKDtvKJig1j?=
 =?us-ascii?Q?BgSyJ8ZxtoUScF7y+SjctIEsIZ0SWWsMf2b261YhJRR0doCyJz/IpC6OLNrJ?=
 =?us-ascii?Q?P04Hh64LCNcY1qEfOtIvP0t9zG0GN8vwSXNPmUVLmLvo8wfB/gyMP2lhUVrq?=
 =?us-ascii?Q?jYeKd7NIj/3djBsr98q6FLmESll1iOrQWax1iX39OgssZkGsuJMYY8vqZ8GZ?=
 =?us-ascii?Q?5Gs6BuIxgQXmRZBMjOcCbPX4iABQxSyKMMmTCkoSatfwG0Ul5F2eH3Vb28Tq?=
 =?us-ascii?Q?JswZbxETvmVdh8IUe1qdjo4xQc+yBM+OgFGsTe9YI5VHGZCDQMYzSTnPK8CQ?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce55081-b93c-4ba5-3ea5-08dca5a2b7b5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:26.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f60I0RleVQzTgvcbwBdeCUiXPEfIx2Oi68UJWlBjA/FPXRnhUbNBxosrWVU2XPWDqZ8zYQCAyO3LyphzCsvXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This removes the codec parameter from bt_bap_verify_bis,
since it is not used.
---
 profiles/audio/bap.c | 2 +-
 src/shared/bap.c     | 1 -
 src/shared/bap.h     | 1 -
 unit/test-bap.c      | 8 +-------
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 2f37d33eb..6d8289418 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1198,7 +1198,7 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 			}
 
 			/* Check if this BIS matches any local PAC */
-			bt_bap_verify_bis(bap_data->bap, bis_index, &codec,
+			bt_bap_verify_bis(bap_data->bap, bis_index,
 					merged_caps, &matched_lpac);
 
 			if (matched_lpac == NULL) {
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3381ffdd4..d2a500e48 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6638,7 +6638,6 @@ struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps)
 }
 
 void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
-		struct bt_bap_codec *codec,
 		struct iovec *caps,
 		struct bt_bap_pac **lpac)
 {
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 3e68f00e2..bf928bc2d 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -254,7 +254,6 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps);
 
 void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
-		struct bt_bap_codec *codec,
 		struct iovec *caps,
 		struct bt_bap_pac **lpac);
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4b47d6363..9cfc8c403 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -575,22 +575,16 @@ static void bsnk_pac_added(struct bt_bap_pac *pac, void *user_data)
 	struct test_data *data = user_data;
 	struct bt_bap_pac *lpac;
 	struct iovec *cc;
-	struct bt_bap_codec codec = {0};
 	struct bt_bap_stream *stream;
 	uint8_t bis_idx = 1;
 
 	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
 
-	if (data->cfg->vs)
-		codec.id = 0xff;
-	else
-		codec.id = LC3_ID;
-
 	for (uint8_t i = 0; i < data->cfg->streams; i++) {
 		cc = bt_bap_merge_caps(&data->cfg->cc, NULL);
 		g_assert(cc);
 
-		bt_bap_verify_bis(data->bap, bis_idx++, &codec, cc, &lpac);
+		bt_bap_verify_bis(data->bap, bis_idx++, cc, &lpac);
 
 		g_assert(lpac);
 		g_assert(pac == lpac);
-- 
2.39.2

