Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04F1C9B68
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767786; cv=fail; b=X7AU/guhO2DuWiyoIvpXDw90asH3gp4NXrdz+MWjQFvw/FrMtkHTgVVC9RCbEVjGavhvUAdSL63nZVUBWcoGtOZ4o5BTjiPJWcvDwAGyU6+uZs6E+hkr/VHMk7TU/EKms2T0J0/x6YeiKiT6QsZ2/HcsbZBPVolkiEZJHy7wRGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767786; c=relaxed/simple;
	bh=+YJ4lQkKR64sWBWXE1mQtWFPDnweSL6VRli84jxYYls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tYDZoBXHzqPHfCuzVpc2WAoHVIe8no0Oihz4TSMkU2gaA0l6c+GOTRl5KqGI/d7SSWAjD8n+OMb9B8iRtvhMoxp3LHFT/NnBBNdzS7d/612Kk8d0jmPtitKTFe1Q/yMP7ZtuJKInvMccVsEXD/jAL1K4YQLHEskCoJ6mhAEz4Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ru7FmxWd; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ru7FmxWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT6bWQTWA9TY88oThZ1owW6sjBHFhN+IWJQBurm+voNFU2XNVc/EDhmvxFoA51DDcfiDLzSDxFOhb6H3FTvsk9cJDBlQAbiiAsmaEr+RjbS2W5p9/7SSk3BL7yLJGwF27EM/C5ODWM615BSlN7GPi+72C+XheImuDoULiUBRc3Yy4Adj2XqmKYG1xjz0kWmGHHKDfwKzYMbyQ5TC8eHEkxbUXp3upm5EH9Iq3698EYPdDLkdX3m9/jJN5LBXNMFvqAwvQl17qJN7XMHUwdDnMDjG4mq9/Jdx5vzua/tE8w+YlBhvKm+qCCc/d4uIijVV78onzahxQc4zbaadx478Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeQS4U5MDyh0ZG/10HnEvqs8K/O7Tkj+eucr6oAqRIw=;
 b=y7BNI37FzXQyQc9rtMad8FVOqzBXStthzKxR4o/wehFYT10VCfwGZ0+c3QK2JxVfs/XE86g7WCXkcRzouJanAowFgMy5uobQTE+Awi4TEGEtqPqD3+F68GDjjkTyMJx7k+18+95w/M+TgPANQ1wXD05maAEcC12wkacIixdNkAlUDtfB7/tDjf0BmGzFQRKVC+EfufbqjBVPvKcPRb/F81cwiCixddwrsX3aNDSNvPf5PacHNYyE40ONhQfNF8Sy72qqUlZrf39tPUCRW0GFF4Q27pl1d96gGSo5au/pTeNEvZVs6MphYfivooXJwT6P8CNPEzqiiWbkbK2snsL7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeQS4U5MDyh0ZG/10HnEvqs8K/O7Tkj+eucr6oAqRIw=;
 b=Ru7FmxWdBtoo3rNR5ObnAYjuhdleYGfxAplzA3WjmlyvaezHKSU0TrxcanT+8mZltWBudDNVziMaWeVlcDCcQ3wbL+U0SIBwOOWKC5F/4qF2MTzPW0ExUOMVncHLqEw1NMrosaXjM4Rb+OsQehqW92H1qF3hjYulo55NGGYW5/5v76vuMKb8ax2uZIupGgdA13won8cHeFDb7uDQ5PeFw+fPbCDePiEKLNZMyzL395kAwXF6Ki5+SYV3MOrVzyeDd4lmsD4DpA0H0P+4OD/gZIylytmJ3FTAlnP/SwIe+omWpneHKxGC944I0R2IRoeeVN89qaTLXqg1jSe6SyJ85A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:02:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:02:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 03/14] shared/bap: Fix broadcast set state
Date: Thu, 24 Oct 2024 14:02:12 +0300
Message-ID: <20241024110223.77254-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 01739cd7-f742-4d39-9a22-08dcf41b6a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nakkLaUt3sjzVgnvDy1T5syhTJd89zhbP+3CtXdCLRoW0rTLNOPkYAg4LmcC?=
 =?us-ascii?Q?6OKf04wi8gCzIIxvpSAK/+MLKsqBvpsHREDbXAeLwIJz2vk+u+5l6SrAl2hL?=
 =?us-ascii?Q?5r42g0QFbJOk+Q4Fr0NqzvBDcaYsUBp9Kp3/6b0BmUzgegK4Yq3WF/q4JHSR?=
 =?us-ascii?Q?6gybUngbHgneTVOA0rjLkecZzaXV1Pubje0EDxZaEks2FbiaftBQ88/gONHQ?=
 =?us-ascii?Q?jTweb52Mg8bt3CTcgDNMkqD9D9z2rDQiVbJFba911Pw6YOX+gh9ewjx3Tvpx?=
 =?us-ascii?Q?wy8qM4S7sZ4NK0y7kabZI3sV02xOQw79csJjVUryYNzwLvhmPiogRfcJHtLJ?=
 =?us-ascii?Q?jYRGCT36W3yzGNxeeX+BK2PkB5T3Y+qqGDXTSSelM1MTme5ShaJPZEQpEtCc?=
 =?us-ascii?Q?xF0EYc+njwkl1NgTSwU/vSpcJiRAZCNR8I3egAoGWfJ/es8mJ9iuqgfXTSGW?=
 =?us-ascii?Q?eLeUBFpe8oARckJJfOyGwl+J/P4G5CXqxpD7K4G1nYKStaxJf38Sm8rcA/FO?=
 =?us-ascii?Q?YXM3G1RBRzMp8PkpYbPkqOR75IViwanEO2LmHFjbA8Og9nTpHrLUE+ncypD6?=
 =?us-ascii?Q?Lice8yXZ7fcNVthd4C8m8Mp8J58qa9tc6yyGKzCYfF2kIsMMUF4bZp3Kl8LZ?=
 =?us-ascii?Q?YHbv/rndv5veP+BMbt9jwvL/iUXmP6VFrddUclikB/NdRsgdDw7jPFPIhCt2?=
 =?us-ascii?Q?RSmZauunJTrvPSHsbxNonSN/URSqSDNXxG4ZLpmq+UKowTL1ep1qH/9nJWHk?=
 =?us-ascii?Q?kivHw8Vlyl6RurOPk6Hw3/Hed1zDo32DJSz+O4ki6YWTSJMTXPn/bkq3wCHB?=
 =?us-ascii?Q?PCjZWmlDyCMy9OKiqUwn4B7M8WI4K98ozTIjZiXLF4B96w+S4xDUizTBPuCI?=
 =?us-ascii?Q?4yofgjGndy6kR5Sih4mQ3riwkyD2Cx6l8PasETLhAPePxy0sFQizi2+sHpRl?=
 =?us-ascii?Q?BySnW6+hXaESdjdaS+enLAous4v6A6W7ApPx793yPoU8mrWJZ+sW21KTsYku?=
 =?us-ascii?Q?VS9j0hxlcquWWlDScLHvUWzuPm+nI1ioPHEZMQ4nR1+2W56alPpYuRzIzdzc?=
 =?us-ascii?Q?LTDvGjUK8lqG5iDVSZCgrugyADN+43z2ZdyITulxeidFfbFuUE9ZVbRVGE0P?=
 =?us-ascii?Q?cc1Xk6AoauGSwtkKoWvjTpGyTx4rUnUXELFULnXlrMFkMUpq5fd8RJwV14w7?=
 =?us-ascii?Q?MS6s9jUlchnlK8CRdjDmrzNA5MJWyTM2Yh9qznscQWVPNuWpXahjwB9UFSy9?=
 =?us-ascii?Q?4rsFOwJXnJZrxbVZS6OSkH0lSxocOjne0hCL3n4pdpzMQQ0K7DmfhmlDAK2l?=
 =?us-ascii?Q?vawEy37e2rVt7Oql5J1WH7yYkb6xu9iciK6U2WS2dHliTR/zrmr9UlKL+z2t?=
 =?us-ascii?Q?3r11y+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdPiMVVMlAtFrnLG0Bxte3Vd8HajxSkh9tZrK9GhTct0kKTxHjVQDYZjeWKt?=
 =?us-ascii?Q?ITVmNQ1wYQZSHS7Z7kUwMIXL2voKpOLF9MXEU5x1d2c8sZBYrNuHqTuXv1R5?=
 =?us-ascii?Q?QAsbiarnbq2NpS+F+BYZpDZPG8Ce08XLQirQ6Fq2+qTkgoqrGZgVeH0V+3VN?=
 =?us-ascii?Q?Gf9BqiIRY2/rnFR7VQYM30f+8zgS4Py1/vtPzLKadCKpmW8TCScSGy+oeHPF?=
 =?us-ascii?Q?dAHYmEvUE/KKBYUCqyqb4vwlDgZ84ICOkI4muqWs/7S3AgIJK4iUx1uB7ESc?=
 =?us-ascii?Q?6Ucmv8Wm2aq3BsG/YtXFI8o0YICj2rk3Goj67WVKAUKOBzb6u2lNgTzzptxo?=
 =?us-ascii?Q?2JRWE7hPQQhOx/be9SYD7RJbehBupTb72Dh5RseF3K6hyGcHfoV7i8Yk3/Gn?=
 =?us-ascii?Q?nC28WOX204DaGojS9tYRBNMRhWqeqgyw3vjV1glIXUgmk0ICKHsZkEO6MfAG?=
 =?us-ascii?Q?RezGvgmL8tJqGmOJstWwraT5COh1Tm3JK2MbWmSBSouyVhzopFRjjiYYstN8?=
 =?us-ascii?Q?fatKW+idKjv0J2lGJOicXx8gs3AQHVhNCf+xAGQ0RxY1xqocTNVpvM2eJ4do?=
 =?us-ascii?Q?+yYDieFD7YDmEiBqMxhOgVJCELUakSca+CC27/ei6m4EugxLRuIN/DG/5gZG?=
 =?us-ascii?Q?dj+klxmima9oiXh9CxmfjxAvOmPzxV4DCY8Bpax/axls2y+z5HrNgcTPp4Zc?=
 =?us-ascii?Q?F1t+Md9Uh34YwcfQ4ZaSAPjhUTBJwisgETemVxWpW/S+/IRY8k7uOdTQnjhD?=
 =?us-ascii?Q?Qopf1p1VuqunzIFA6N9nyfYZiPNTJXyIAXCjKJzmms+Z01kKAlYQAzFpSP64?=
 =?us-ascii?Q?7m82cghgen4lJ6mRU1nwkJ4wrxNuZLh4sWoOv1PVsoq7AIsEyUglEMFS3k3G?=
 =?us-ascii?Q?aq4RDyj1sZR6fliT+OTJzzkKLUkA4o4rwnXk+jXT2e0kUSL2ipdnCW87G0I2?=
 =?us-ascii?Q?4kRNlhRAWUBD0FjO1SH6RlXdVmiqGsZlwqjwFQ5yoFlUdILqh4LjA1ClAylv?=
 =?us-ascii?Q?Go64xpIddhnc0xCKPI+7lt9X3kf+obP/tuDKv7yGc/IWBeOFCf+RZ/H4oIIl?=
 =?us-ascii?Q?JjyunV5vOCkuJkL8B9VQeseGwFugP12632hZbizwzTFNU51eL8Xk4c9jGfPG?=
 =?us-ascii?Q?FvFMXVGlCdbDaTJ8kC3EMMqFxP/vYwlN9OaQXiEFZGnHCHT4dkLtGl0w+CF3?=
 =?us-ascii?Q?BK1QPdItqgL10OpxtzvlOO1As1SY3CnBq+1M+t/ES0dd+OYsj1gp5C1UUZ7h?=
 =?us-ascii?Q?tlHh4oRBme9bpiLpriGWCfIndJrJOsuoOAJ0tdgOkPiaWD6dRiTBBNnYRBk8?=
 =?us-ascii?Q?barhQEFLO6XayQ2Qvdv7Hddc8NCo2zYbT0oATYFgOnU184b5IsbSsq5U2XGd?=
 =?us-ascii?Q?2AUPjmMORekpKbIN1zPUzqE2TW18Gg0K2VoY0ekhsldjwNHuUWyrSo7/+fds?=
 =?us-ascii?Q?m3PZoEVrRRNMCQY/PSi5LtYkiNIT+cEhl7x/nTKigAPePBq8X3V7qhY5Py1C?=
 =?us-ascii?Q?Xq285EeADuwcsvYORIVETpqjXDFrBvKry1ow+6ThL1eUaIkdRmjM0xehyAqw?=
 =?us-ascii?Q?Go3DBxLHqIdwZ1SKWabzBhfQGSJ4JDHOLhe94iCO7H0q1LsdFDIPREv7UCG2?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01739cd7-f742-4d39-9a22-08dcf41b6a55
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:02:56.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogp4ckKgsc0U4K9KHy0h5TbYuKJqHpb4VXylu5o1Ea0PJv0SBafJxNPKMIdICk/QQZ6fZh14SELQqwOcVolUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

When a stream changes state, the update is notified to other drivers
that registered a state changed callback. These callbacks might further
change the stream state, leading to the stream being freed. To avoid
use after free errors post notifications, this commit adds support to
ref/unref streams, to make sure that the stream is kept alive until all
processing is completed. This also updates the switch condition post
notifications, to handle the stream based on its current state.
---
 src/shared/bap.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ddf8ab84d..46ed490d1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -262,6 +262,7 @@ struct bt_bap_stream_ops {
 };
 
 struct bt_bap_stream {
+	int ref_count;
 	struct bt_bap *bap;
 	struct bt_bap_endpoint *ep;
 	struct bt_bap_pac *lpac;
@@ -1204,6 +1205,17 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
 }
 
+static void bt_bap_stream_unref(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return;
+
+	if (__sync_sub_and_fetch(&stream->ref_count, 1))
+		return;
+
+	bap_stream_free(stream);
+}
+
 static void bap_ucast_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
@@ -1220,7 +1232,7 @@ static void bap_ucast_detach(struct bt_bap_stream *stream)
 
 	stream->ep = NULL;
 	ep->stream = NULL;
-	bap_stream_free(stream);
+	bt_bap_stream_unref(stream);
 }
 
 static void bap_bcast_src_detach(struct bt_bap_stream *stream)
@@ -1238,7 +1250,7 @@ static void bap_bcast_src_detach(struct bt_bap_stream *stream)
 	stream->ep = NULL;
 	ep->stream = NULL;
 
-	bap_stream_free(stream);
+	bt_bap_stream_unref(stream);
 }
 
 static void bap_bcast_sink_detach(struct bt_bap_stream *stream)
@@ -1248,7 +1260,7 @@ static void bap_bcast_sink_detach(struct bt_bap_stream *stream)
 	queue_remove(stream->bap->streams, stream);
 	bap_stream_clear_cfm(stream);
 
-	bap_stream_free(stream);
+	bt_bap_stream_unref(stream);
 }
 
 static bool bap_stream_io_link(const void *data, const void *user_data)
@@ -2115,6 +2127,16 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static struct bt_bap_stream *bt_bap_stream_ref(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	__sync_fetch_and_add(&stream->ref_count, 1);
+
+	return stream;
+}
+
 static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap *bap = stream->bap;
@@ -2123,6 +2145,8 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	stream->old_state = stream->state;
 	stream->state = state;
 
+	bt_bap_stream_ref(stream);
+
 	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
 			bt_bap_stream_get_dir(stream),
 			bt_bap_stream_statestr(stream->old_state),
@@ -2138,7 +2162,7 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	}
 
 	/* Post notification updates */
-	switch (state) {
+	switch (stream->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
 		if (stream->ops && stream->ops->detach)
 			stream->ops->detach(stream);
@@ -2148,6 +2172,8 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 		break;
 	}
+
+	bt_bap_stream_unref(stream);
 }
 
 static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
@@ -2544,7 +2570,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 
 	queue_push_tail(bap->streams, stream);
 
-	return stream;
+	return bt_bap_stream_ref(stream);
 }
 
 static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io)
@@ -4145,6 +4171,13 @@ static void bap_detached(void *data, void *user_data)
 	cb->detached(bap, cb->user_data);
 }
 
+static void bap_stream_unref(void *data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_unref(stream);
+}
+
 static void bap_free(void *data)
 {
 	struct bt_bap *bap = data;
@@ -4163,7 +4196,7 @@ static void bap_free(void *data)
 
 	queue_destroy(bap->reqs, bap_req_free);
 	queue_destroy(bap->notify, NULL);
-	queue_destroy(bap->streams, bap_stream_free);
+	queue_destroy(bap->streams, bap_stream_unref);
 
 	free(bap);
 }
-- 
2.43.0

