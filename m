Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692619D087
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139753; cv=fail; b=M7NYRTnhTk5G4zIv+yFuHgSKHSZwy0eXcXWSnNmdaKZXy05EQyXBZ5yRnbx6hUgCBOvsZKDvvm4Jwru74qxLNzJ8MN0rg5Q2iLOOM+NaoqUJl7wq8TgfvQ5+2JKPQeTuUB8MiQr5uq1NhwgrJiXI04gfS1RQob1YB3Xb0mgPieQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139753; c=relaxed/simple;
	bh=6i2epZ8ZL+hAVJ3YxXQgNeKvSvBReBmB9X8m7TFVVTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dI1ksrLf6pdr5ztwjFakSPjTLJNRD41QsgXk6rnGhJ2eHGHZh0immOCBla3Ap+91rKTsvlyOp3/RaQGn/C/AoidAMlnIjKRCV7EoLdKP6cEpPgQkyGgpqAVqu+YKX8oI/kHM2Ssdi8FzhfiP7TiPnQIifEUA75s3K5xN+QIvDjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fkcC875w; arc=fail smtp.client-ip=52.101.67.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkcC875w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viPgMWRqNUbqX9wGI0kt93juZnIIWxpoNDe1MDDdaYB4xwoyDlfhPG8JMaT+Hy1w4kdM1Yin8HKuYCsQZHGOknj6xDQqeLLdmsyX5ZMVcagP8YZpGGWjane97MypacgEHWBtOAWKNugQJ0gzl+fbyVKcStEvOFMvo0jS/H61WgFFmSzINB1b6QnFrb5ptTC/VokKdPGOg9Ml6s/L2kN5GfFt63C7L8kT3c0V+yH0GLr481rjR0I1lm7LaAh3YLI2wweOF0CO1FoAhd90iwsD6LU2WsbXT0JoSu9smN9R8H4plet87QPpE2g57a92q53XKD52bo892xJp91QkXmQ4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBPMx2ponNVSF8LAL86XJ6DpTa+3L6KG4xaC7LiHfkw=;
 b=ahz01yoBD7k88kx2nLickR+cVuVpDja/oaIIRq3PRo8Yl4yAcy7Fie0AzLaDvHfTvTNCJ3s24k6XvOu6fsxE4OltZrBcc91T5mSn2dCAULtzNDTNFAoVrsv2REjftOy+ceObHkFZmNh/4OyzLm5GHuiWmOZYw3fbW9D1yvUgpLqCKGuetKin+KJ651RkFCXSIZUIfQENT5mBytjBtyQloYGW9Tn8k2321nr8N0zm9FixjNkuHJD1H0yQi9peRMdV5biRLDG5l4/t5F0mNrZTuZrGf6RY3DGwASlQdaziYZf0gN69jW+5nOXzIeeo7zsR7ZKV8vz93gxMcHvKqp0sIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBPMx2ponNVSF8LAL86XJ6DpTa+3L6KG4xaC7LiHfkw=;
 b=fkcC875w+x2QXlaD7fjnhUeEeYar2qdhjKJU7DoiufzJmqc6gUG8XkVEqxEarclvOBYQdGV5bLnsAdhnTgy517JlQvOs4LtVhugDnyn+/kKP+70kEC7tucs2z0X5+IgkdQEnmdDVh41VyO9BL3o9/5zQyTiHe5eOuSMKAxFCTx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:29 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 04/10] shared/bap: Allow checking bis caps against peer caps
Date: Tue, 16 Jul 2024 17:22:01 +0300
Message-Id: <20240716142207.4298-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:208:1::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 70636728-a877-47b5-d597-08dca5a2b936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fv9OwY+wf3Tj1/ytqof6g8CXTZh3O/+G9XNMP3zqt+cXxHrgWYBfR6FiyBYg?=
 =?us-ascii?Q?JrvIxxeGzV95hGTT8Iqy6/kZCioghqOtAS4bhkjf4xuUMTmsQ+7MHXs2FJaX?=
 =?us-ascii?Q?gpGoSMnxAlWwvOig0bMzBGFhJy6bpygNZBt//7+H+e+fFzEwBcv91l66JqHh?=
 =?us-ascii?Q?dbhUrzy9MymRj2xW7ADPL2ieEQAEl6OJ17TUP35bbc5IIrf3D2Bc8UfFDYSk?=
 =?us-ascii?Q?b16J6ue7Tsm87qATLBe/2Uc0qQ89w6ou9fMWvHCfRMBrwirBb6alJiGH99EH?=
 =?us-ascii?Q?+qqXjt39T2fi2JZ0yYOEZ8ZNh4Sgikl9ISK3fIfCIF9eSqe7pcuzkimerLGM?=
 =?us-ascii?Q?ND1HiCVNL2WYy3ufphXK3gTN9bMgx7wAqb/iaitix/fjPe8q0M1MUU0cH3Xd?=
 =?us-ascii?Q?nO+AT+F5cxLEUpKcZjTG+DZsn2Y8V2XiD/FOYyhRB95u646fnxxnfLLBQF/Y?=
 =?us-ascii?Q?gpn4b1iEUJvHLg5OG0P0j18w3PfFqSiP+hb0EiqLlpPyWriaJGZw0YPWe0tk?=
 =?us-ascii?Q?O7Mgk5/WCrAGpXTNr+InPniTAPo2Fs1NTfJg+y5HCZZA3SApVN5jHi32qz9E?=
 =?us-ascii?Q?eMfiOwvlGQaAwAjTeKfrp4hfBy4e6ocNRPVhP7NeMJCRxkXmmdjEg8paOR4R?=
 =?us-ascii?Q?mZkujsSqxs6O6XKX2L9YU2Y+0fbiy7I9FPgS31IiImvzBPMIT3TpWsLHFC8A?=
 =?us-ascii?Q?9jr8oondaoksUfuJP5JeQCBAo13bt68kPMxysi1kHhRmdSBuHEg2Cny/pFWH?=
 =?us-ascii?Q?Y8ukK78ax9NDCtEMq0lNj3BefOIg/ylUSXrInim7QKSBITtFFGq5WahA51L9?=
 =?us-ascii?Q?CKnKfHKWg8jpe7ex84YrTXaLD0DZVwbPAIzj2VhsiigZtxMhiKK8aY6sitag?=
 =?us-ascii?Q?4EJyRVDgd+7rokboVUw5xUualwEBWIZlRQNAaRqYlqqsdz5X3bnapj7xT+/0?=
 =?us-ascii?Q?T82KpronHy8nzUtzrUhaTcWoivDWe4NgQSZgHE+MsIEHponBrgtt8Qxxh6NI?=
 =?us-ascii?Q?TAuIh9RmvQ4L9zCpUQJo2nBnibkHqiIJ4gCPBqDupKUT+ovB66bVqlDjlj57?=
 =?us-ascii?Q?S2KeVbuoOx1c6GyD0w4WJkNVh+CBmbiEJn2C/q+id+LttHD/3h0/yUgSJS0G?=
 =?us-ascii?Q?PTPPZyUme57M+ZRA2k4/X4pc4HtCLruIsrhOa6i+nqz2XZjuf3U7XZyWrgV9?=
 =?us-ascii?Q?lWjAmskJqCSqbM/G0tZ4ZGuNTQ7oxDJIQ6ysBPT/HW3/YSX9N6ngmE3ZFbyG?=
 =?us-ascii?Q?w6WkTGK9P5/QPcTWHf6V5Rw95OHAkV4sqnyPS3zYgCm3ebUFQGvQ85pia4Wd?=
 =?us-ascii?Q?kqBx/0xx1hx7YESs1a8fxg4iZzluvbHCTUpjmziW7hFBmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RL1yGQaG3y3zuEab4QwycQS0NWnXemzqvC2uXQdS5asyqIgwCOWt8rxRZniN?=
 =?us-ascii?Q?EsumehUENbDeJdQdfP6oK3GICIb97EuY9dg3Wu7TVHJSlF24EuowJ3a0niAN?=
 =?us-ascii?Q?xFZ3wj8cEo++RCIadnjUCC2y7LTrZyWtME8aoVqIP1q7u5Va+qCLbWPQsfN6?=
 =?us-ascii?Q?b7MfrYgGlVCok3dy/xfEMSyCu1wbPflS768CFksQS0CcQr4cv4nAzvXBttgf?=
 =?us-ascii?Q?k7NBmtMp1w1a7azwJMnWrUBRX6tUO/E5gpA4h3HqbF0Tn/LIj7cjFCA09HCR?=
 =?us-ascii?Q?9bYbzpgfbDaCHYlXi1s5UWk+DuB9uiw2zCyy4lvUOvOdRzPxS9lkykRbXy8j?=
 =?us-ascii?Q?jM+CplyySqWDKvPoPvaimWGnJwynpub+r8ZBOiOEtIAgQlEdmIjAmYf6JpXd?=
 =?us-ascii?Q?arrySHpA9hJKpUD565Va+V6jhy4W52EIyT7bQMwyDDhEqWMbUydB7IpoDHD/?=
 =?us-ascii?Q?fMMolOjQCFNw6cKeYnKkebIZqRZl6Z1xN46sJLFqnuEvIBOYQX27SDKVCrEw?=
 =?us-ascii?Q?8QSmlAyHdKHRsoa32Cp+dQ8qqpXB7+Xji2eRoMJ3uiPZSMVr70Q4Pjv2re3F?=
 =?us-ascii?Q?8x5RbmvmMMTo75+KsdCFnlpZ2ar+dBSVEO7fVemC2oq+s+fNb+bVEMPdvffG?=
 =?us-ascii?Q?26WD/ScccqfUisISesnubuwfo4Xqwx7un2r5fNhNOrRBE1lblRXC2XGksemP?=
 =?us-ascii?Q?xQ7jwakGQAovCAwkVZtQl4F5JKv2Zp66/M5ggFBZA5hEqnOIJWvzJ4ZXucVp?=
 =?us-ascii?Q?3uoReyJ9YP/K+Az4htW0hSmK7bwqDLB+qO0W2UAurMQEFV102O+DEiFGqDuc?=
 =?us-ascii?Q?NLsDoWI1uKePY1X6ILjwBPVt8dIpTXMEf3c+1woAUQHZ5ETJi02r8gmWd22l?=
 =?us-ascii?Q?T0OQnyCyF8P8z3mIkatnCmcescAbEoDn9QbIaehLK3+sPP0nQ8W0FspLb6dl?=
 =?us-ascii?Q?gbkbtxRjvmyhCEnPe5MkIvSjXUH9SyGIH79D1D6canFLpJNmgsQxbXPVCLrZ?=
 =?us-ascii?Q?Bm57Lh6sUDQ2MbeOmhd5rqySQJKDmoGpmiuQrrtB33cVu4+oHpJxFG65/1IY?=
 =?us-ascii?Q?3cpHKciW8WcorXJJn4OvCRUMrrPFVT/0DMGpXPL5pkQmOFFF0RMzf1YJ6qkz?=
 =?us-ascii?Q?sKrrgtEWcvAFe2HEtrxUzvCLVYs0pXSDVQQKzU9kaqzICJUDxty5ywRYv7IQ?=
 =?us-ascii?Q?1f5YkF4oyxTnm6VyWHloIVorN5ysXqhFFUl6tjW6qWpi9+WDmceKo97hfsKb?=
 =?us-ascii?Q?ImeBfvTTwee6g7eFc82d2+kyYk2NNHmuC9cuiF6mPN6GJEJgug07DoyalIOj?=
 =?us-ascii?Q?GBn570/fI26RwNlQK87dBeg30CieKy/RPKLIM/cVanKJMajx1557XeYet9L2?=
 =?us-ascii?Q?jSmR6s1L/oX0GxhfD1yavycXoMZUf/taGJWgOX129+JYD0Zzhm8vqxJLvA72?=
 =?us-ascii?Q?yofN/ofN2zMpX6rcYN93TWAQdhCYO5oCE55CEQiwRnIJ/olE/t371tZRuGNN?=
 =?us-ascii?Q?DzS3vtD1mCq3iUfnj6Rka342w1enKyyulvxSFis/mEV1djvhYWq/q+PVfYwg?=
 =?us-ascii?Q?Am5gZElF+I4gdr14xgm2ZZBNB9RGAI4ukp/L+tV5FdlSg3uI2iEKJRC2Y61X?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70636728-a877-47b5-d597-08dca5a2b936
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:29.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk7STMhh4DCVMtV/NcjJBv1Ae3v1UZeVUNiHdxM9zeTAwns1V7N3GefKEfiCgJcZGh+7jq4Pf7aSYJKBTrmuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

A BAP Broadcast Assistant needs to match stream capabilities with
capabilities discovered in the Sink PAC characteristic on the peer.

This updates bt_bap_verify_bis to check the provided stream capabilities
against local or remote capabilities, depending on the bap structure
provided:

If the device is acting as a BAP Broadcast Sink and the bap session was
created after scanning a Broadcast Source, the stream caps will be matched
with the local broadcast sink PAC.

If the device is acting as a Broadcast Assistant and the bap session is a
client session with a BAP Scan Delegator, the stream caps will be matched
with the PAC records populated in the rdb at service discovery.
---
 src/shared/bap.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d2a500e48..44fb06169 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6577,7 +6577,7 @@ static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
 		data->found = false;
 }
 
-static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
+static struct bt_ltv_match bap_check_bis(uint32_t sink_loc, struct queue *pacs,
 	struct iovec *bis_data)
 {
 	struct bt_ltv_match compare_data = {};
@@ -6588,10 +6588,10 @@ static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
 	 */
 	compare_data.found = true;
 
-	if (ldb->pacs->sink_loc_value) {
+	if (sink_loc) {
 		uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
 
-		compare_data.data32 = ldb->pacs->sink_loc_value;
+		compare_data.data32 = sink_loc;
 		util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, &type,
 				bap_sink_match_allocation, &compare_data);
 	}
@@ -6600,8 +6600,7 @@ static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
 	if (compare_data.found) {
 		compare_data.data = bis_data;
 		compare_data.found = false;
-		queue_foreach(ldb->broadcast_sinks, check_local_pac,
-				&compare_data);
+		queue_foreach(pacs, check_local_pac, &compare_data);
 	}
 
 	return compare_data;
@@ -6642,14 +6641,29 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_pac **lpac)
 {
 	struct bt_ltv_match match_data;
+	uint32_t sink_loc;
+	struct queue *pacs;
 
 	if (!caps)
 		return;
 
+	/* If the bap session corresponds to a client connection with
+	 * a BAP Server, bis caps should be checked against peer caps.
+	 * If the bap session corresponds to a scanned broadcast source,
+	 * bis caps should be checked against local broadcast sink caps.
+	 */
+	if (bap->client) {
+		sink_loc = bap->rdb->pacs->sink_loc_value;
+		pacs = bap->rdb->sinks;
+	} else {
+		sink_loc = bap->ldb->pacs->sink_loc_value;
+		pacs = bap->ldb->broadcast_sinks;
+	}
+
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-	match_data = bap_check_bis(bap->ldb, caps);
+	match_data = bap_check_bis(sink_loc, pacs, caps);
 	if (match_data.found == true) {
 		*lpac = match_data.data;
 		DBG(bap, "Matching BIS %i", bis_index);
-- 
2.39.2

