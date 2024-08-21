Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B521B2ED6
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252196; cv=fail; b=B2P2o/MFm1tCCKP0EE01UpvHhc+QXw07VSGZ6yioPdm6SPJkTSrN5DZXa6u2yp1mE8rawAoEnQyKBdfzJURR2jljHR3D3CZmRVk4wQSv0ibw/U7KFJ09WMO3diYaABiXuG3xwakQx4iJM5qUm2aER35XnoUD74jaD6kw2Hr4dE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252196; c=relaxed/simple;
	bh=byegnlnYu/gcSMgtojUeTNxvU5oKZO+2XC2mnLl9i5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dx319MViHFZ65pPCRV7euKFP4MZPbq5PmY239YZjvR+Eal5xbL7NTsUC820o65OYLpr2/Qb7JyVBCYXHR5PrIssI2rcUA6zM7HefEUlohNmIsvasdYaeNimtSCa76e7O8aIxFD3klIzuJY+FE3iSaMx92p5pz8K4Zcixd775qtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=adx1vlP9; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="adx1vlP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7KgTTkCFYIGHcc2PhSF/VmE78o52XI32ZkzT304WjJvAsm4aYdwLRenflVCM+mMtuOz2JT2I67FWhHUbMaZTZjOW9Th2cfJOtcwzf5km6svBVEaeEiSr4PGUuIl38W/5/FBESiQecHzREOnpTp/H7Wcv5UZE5a7rcC3H9Nc5F87YjVxCSOMN481WJcyX9El2j5BAe89dW2bdbUav/O77EWkPh+90WbPH8tiIgfjGrgSgpsSN18vRzLIql0gZHrniquFSVOMEMPlIdJSTd7LJIM0WnJeRMdNI8YqI7+qM5sRGNn0rLD8XAdYvtT9EDM//PjqA91N5zpt7JA8LAfLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFjbGv1gVK4zKseDku8+u/eMqcE953O6sweqZZBPOQk=;
 b=Ilp1pJXBNci7W/FEgbMlk9jbW40nBezAdpvVOG7rfwZEGU/ZkwUnJkiReo/esQIhgyQn6giQl07IC5T3d5q2oXdSAq2SDMBGCu+Ss6XSSZmEW5tJ6qj5i8jlTI7hy4RRVPE5+0ePtx9znz1cw37WUe6wYfj3HEv9f+HNeoSDtKCvoGicxDSX3xdYPtsVzLW8nX0Ys6/eUHxmYfZPxbPkHvnZCAio1aIlS/sTzEIORGlgmcfJlbWwfjlitiqT01OsHVP/56xUSF88wxfGjhUGn0DwfDdOMkuYHNN3N3XeY3x3258ghGaQTxUJ20fIUxudH6jEEEsJgcNFNqZwibn6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFjbGv1gVK4zKseDku8+u/eMqcE953O6sweqZZBPOQk=;
 b=adx1vlP9srQ5+ATG5+h/n0WpSZ3zi1yGEcegqyjRa0pq/ajDCDm10hSiu9AtyZJH2zCOxWHraCZWRYO/KHlcMX8PfTjm0Aam5PXa2iDNFhxDiwckKF5OkvwnMlyGj3xZ3Fx7wVbnR55iM5y208sDPCPfMfmPfll9XVREBFbzaAfGUGNrM2lNz2LH2XphA86jzjfHfAXQu+eR3nDGNiZFHOWSjUAGCTYsCe2b/lY4XXF+IN5QbWAPb7H+KApYbwERyvNkpUgRpk/becLeipZyJS5P5YV5zxWbtsEyMkuuSdMXtCQeGdod5El+WEGWEl25hEyZdsa+SCJa8qx2V0wQBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:33 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 08/14] bass: Add APIs to probe/remove Broadcasters
Date: Wed, 21 Aug 2024 17:55:56 +0300
Message-Id: <20240821145602.92083-9-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e56ef6-9972-40ee-eaab-08dcc1f172bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFwd5du8fwECXAP/M5xPFX+cRtc8C2aEQjrkpM04SGnh2woLjAeQzMLLU00z?=
 =?us-ascii?Q?WKKfDM3brjR29muTkMkdQfj/Rark/wnpcGxfmltzNZwBAI+FjMOUWqI7sshG?=
 =?us-ascii?Q?TY7dRBdcUy/ZlqxIwzESrDjYDJZM1aUaEKg1tw7uAcT6RNQWPsHsf7rh5uuw?=
 =?us-ascii?Q?gseIO30KX7j983AzEbYBJfRHUbXKXyQ1MEnL7DzmEzsndu6Lo6B8385HUTLR?=
 =?us-ascii?Q?Ot9V5yVpmKVP2O4EYT8X23+hfhyde53ubd35DnNBuVX+IMzUB/6ckCOCv0wh?=
 =?us-ascii?Q?ml5vWgWhiutV1TkX8t8lwVWgnXj4J76VKDNid11LUdUyO89R3aUiVsMs5uvg?=
 =?us-ascii?Q?Bzwfger7ZuX57TCM8/RW9/+HebLb80cymuZBBO7/1rf+KSIGiVeWXnT2yckH?=
 =?us-ascii?Q?fAzt8IknyPcdZRw1hzutIRMtcyPhWK2j8I8oXIJ+yLFVrtPw4XYoNyTgkyzy?=
 =?us-ascii?Q?z5ELJPSzwShvJn6CEE5hVUuCUbQLDYcA1+v5sauMUs2tkpvKCVeFCQYxf3df?=
 =?us-ascii?Q?JFC01lADB7H17y16Z0oSFPHs3Vy1UU9BoA0G6ca+E1tv16bMrqCeZOD9xtg3?=
 =?us-ascii?Q?1Ymj6I2PBCCLA/oaMSZVACUZMDNzMgOpZEcZwZuK9KLGQuAcM2lLhvXMwP1L?=
 =?us-ascii?Q?kw8J8glMIVm3ZQjk9jxMhzrENdOI+sSz2pr0ra25sqNhNIRUbVhvpunAp8/p?=
 =?us-ascii?Q?yCib8AVjyU5yTf1M3GOTVQzgg7yc5YQCz+Z8vLwLT8u8lbgy4CFHR6slhgNl?=
 =?us-ascii?Q?zQ/hajLTRffoqP7LZ4abhCVnx9BNrC8dEGiFf47p/1YeA2HVr0BCGnWPvSl2?=
 =?us-ascii?Q?+aYIY8cDBWzsMG8MigJ83NwQVKWDTB4HOCmWAxHO1MAjMUDVyIC/rtvICQlP?=
 =?us-ascii?Q?mkiWOqOOqBZuI3Rq5c3yPazUT+quHI4svuxhM83oEF4/afSwb5OTA80EXtT+?=
 =?us-ascii?Q?NbJb+39wDGDCcNFcJSePx02BEupvHlpY85A4+MbylotutPE5Ug6JwrQugFgq?=
 =?us-ascii?Q?umCkK7cf2KVHMTCDje8OvshBsQH9Mq6X3LWQzXSnBw1g/l+dEiRUzf7OrYyx?=
 =?us-ascii?Q?CWO3L1eP3vL9gBGgxsytZ6+AKxLNVscDXgFZk8ZH270ur5SzXrBbZeKgNnhC?=
 =?us-ascii?Q?+r1pl3qPVWkDoVPRGN1LRIZOYE6Xe+EC5c/myqB316J5eDcR8wCFuWhPH2FS?=
 =?us-ascii?Q?83C27vOsejG+XvFVN1U8W4R+CqZEjBXHkrEufsmhcf2Qw3fPxnDrQr9FJQOr?=
 =?us-ascii?Q?9VXs3mBL4mUO35NaWB1hn6tdsOQmOBppJZ0D6r/5pZlt36n2X/qb5ijxyyvP?=
 =?us-ascii?Q?2EF64AJi2WJUZoPmFDiRbI4cQ1kazUeQ9CXVar8U2izotg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akxfhqBPc99r5mmpWrwrWFoQIWXudnHbumfIRNVvYVeQHMbrxNt0TOOgFF5K?=
 =?us-ascii?Q?+4QRUSfaV/lK2cYScyPft5vGTNtfkiOEGqvv9LiigPx2wKVp6yVJeVsjnZTo?=
 =?us-ascii?Q?ZMeKfqxj+HYWSqmLSRkTc4IMZi8nbcvYq9MEfnQLn3nivarS1XzsdxeIZgVX?=
 =?us-ascii?Q?2/ZWxy7xLbPuezggxYSVYT+AWYctJLIdBIJEFs6MxopejNzjX0mT/F3/wr5V?=
 =?us-ascii?Q?OgNSslXgfgH1J4ZUcmvWaQgc3xqdcsLQ7enCAn5QWfFvbqmE/X3UVGMNYwgp?=
 =?us-ascii?Q?n91tvDg2zbahK98IdfmKrUnxoAArqPseCVY1ZEVSIayT1BOMWSqdygL2WY4R?=
 =?us-ascii?Q?+38V/CthO7LSh1lcN2cEQ933dYfe/KUOSOPBt/91lnOWyjejbQNZvThLquVp?=
 =?us-ascii?Q?nNzxPKPSM3YiIOjFOMgz58622wmwRNLqFuFm+Yg+Z4RDkwYhmPmiZX3VqGQy?=
 =?us-ascii?Q?fpW/ivhOxz1kzHBvyJPS+LPubowlGllonu1b+em6Dzby1/O9EpdpppsMBe1r?=
 =?us-ascii?Q?HmsjazgpI1XIcaZz/aK84oVH5Igcxb0Eik/2fQiTvpadHY6u3hRP6MW4dOBv?=
 =?us-ascii?Q?57HZoZkCmOZPh4Z3v0ThwfKKHMMYzByGSnjolkSog7MK6N1ZqtqU/lnMWFR9?=
 =?us-ascii?Q?dmcGXgcypJy/FZNT2b/oTClY9QcfJ5XFGyn9WR8K/mqpGcSyVXM4AuJdLpl2?=
 =?us-ascii?Q?XTrbEIsUk4xSxVTf/qIKvAgjZTTXt45wpD799UexvTtgVfjvGzpT1tkRClGO?=
 =?us-ascii?Q?kN292of4dy+7sP4BNwQJLGYeznVJXfIUAWx9XM9G6lZBhFrvVxCm4DfNfL9h?=
 =?us-ascii?Q?ijIgVwan8EV5NL7pz1schd6F8BghPIA+I27Sq0k8+w34jRMcWzsyRoPQwNq3?=
 =?us-ascii?Q?/Z96VDzJHjzS91r42URmV3WR6n/XjNsLIKcdn1gk4d0pRGg6TcEhETZqrB6W?=
 =?us-ascii?Q?NRoKwBl8vsTePdzea8MHQZHCNUwqZ0zF0+xhGyP6h0rpUlMqXCFXwdjI5w6f?=
 =?us-ascii?Q?XBkNxiE8Su4a2EPLPHEBNo0Ey6C4K/vfjXQNFPiVyyJpwWh4TvEglLBYK/ND?=
 =?us-ascii?Q?ePW7y6QnX8GIBDJMTZxSFZD5VXD/Qfm8CvLi4QqAfJ3B/d53+C/n3amVENjo?=
 =?us-ascii?Q?P8g6cLs2FOgsbUJeUeJ6Qgc3BmTbSxhl/8SHuAWfOLDNbAndmK+tfESWjvyr?=
 =?us-ascii?Q?z9AjjtVbw1MvW+uizm/mLhZifat3rk3NmviVSxMXOmhfcyfrQs6xNcfSY1Pt?=
 =?us-ascii?Q?v0iEfIe6whyIRxOtuEcEQpECC4w6PEQteCjaWsSNUQlWGXW3A4EmZiLiM0Ru?=
 =?us-ascii?Q?z9YOjcB/FqEaWC1H1z5VkRLeDy0wOd0V+/6641TR6TWbHgyS+XhgZWfPP+9m?=
 =?us-ascii?Q?HDJrTahdKatfMdLWODEslOr6hy9NlXF2HuVvLQJq5pvYlw43xev3B8uBJjwk?=
 =?us-ascii?Q?QHqXC9O9RzsSEEs94bzzTMrmNKY2jylgxdOAC8ZbfFcE/jMbr95sMb9ZBTHL?=
 =?us-ascii?Q?8KOPJUFtjUEU9WUckJ6pghNWBduQE4PY8wef++Du0pqIyx90UVUFkuVBNm54?=
 =?us-ascii?Q?q3YbwZ1pYFlob+8OuOk/4jGH6H2f3lPdmK86R/A7Kq5NzeKAZtejj92JYTsG?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e56ef6-9972-40ee-eaab-08dcc1f172bf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:33.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t17FpEtmJfgbvLZZztBF+3aq6iT54y1EIeMHhYc/30NXusGf8Gzqyvrp8xXJJWueNt451O9i/V16t0ahi+pdjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

This adds BASS APIs to probe/remove Broadcasters probed by BAP.

The BAP plugin might probe Broadcasters that were either scanned
autonomously, or that were added by a Broadcast Assistant through
BASS.

After performing short-lived PA sync with a Broadcaster added by a
Broadcast Assistant, the BAP plugin will call the BASS probe API,
to inform BASS that PA has been established with the Broadcast Source
and to provide a reference to the created bt_bap session. Once a
Broadcaster has been probed, BASS will update the PA sync state inside
the corresponding Broadcast Receive State characteristic and
the peer Broadcast Assistant will be notified about the update.

Once the BAP session with a Broadcaster is deleted, the BASS remove
API will be called, to inform BASS that the Source is no longer active.
The BASS plugin will update the PA sync field of the corresponding
Broadcast Receive State characteristic and it will notify the peer
Broadcast Assistant that PA sync is no longer established with the
Source.
---
 profiles/audio/bass.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/bass.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 5aadb0dc8..22e8d1c9b 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -102,6 +102,7 @@ struct bass_assistant {
 struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
 	struct bt_bcast_src *src;
+	struct bt_bap *bap;
 };
 
 static struct queue *sessions;
@@ -115,6 +116,56 @@ static void bass_debug(const char *str, void *user_data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static bool delegator_match_device(const void *data, const void *match_data)
+{
+	const struct bass_delegator *dg = data;
+	const struct btd_device *device = match_data;
+
+	return dg->device == device;
+}
+
+bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
+{
+	struct bass_delegator *dg;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		return false;
+
+	DBG("%p", dg);
+
+	dg->bap = bap;
+
+	/* Update Broadcast Receive State characteristic value and notify
+	 * peers.
+	 */
+	if (bt_bass_set_pa_sync(dg->src, BT_BASS_SYNCHRONIZED_TO_PA))
+		DBG("Failed to update Broadcast Receive State characteristic");
+
+	return true;
+}
+
+bool bass_bcast_remove(struct btd_device *device)
+{
+	struct bass_delegator *dg;
+
+	dg = queue_remove_if(delegators, delegator_match_device, device);
+	if (!dg)
+		return false;
+
+	DBG("%p", dg);
+
+	/* Update Broadcast Receive State characteristic value and notify
+	 * peers.
+	 */
+	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
+		DBG("Failed to update Broadcast Receive State characteristic");
+
+	free(dg);
+
+	return true;
+}
+
 static void assistant_set_state(struct bass_assistant *assistant,
 					enum assistant_state state)
 {
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 5bef92946..7e20385e5 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -11,3 +11,6 @@ void bass_add_stream(struct btd_device *device, struct iovec *meta,
 			struct iovec *caps, struct bt_iso_qos *qos,
 			uint8_t sgrp, uint8_t bis);
 void bass_remove_stream(struct btd_device *device);
+
+bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
+bool bass_bcast_remove(struct btd_device *device);
-- 
2.39.2

