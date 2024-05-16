Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57D146D6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864661; cv=fail; b=aZXJMgkDOC9kb6LpqXUtMwQm+6SMmSfpdJSORUEqI1yFGCxjXBdICnjO2vlnQj6//juQnLx5AaRkeHQMe2E9r88KW7+UlZkYe3f+ILgbGuJ1C71En/hk/vodG8XgZRU8kqMcdEBF+/lbYZ3j5fz8+V7NeHhf21FztUBuPitnlhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864661; c=relaxed/simple;
	bh=CTeIYurGRRsqn8V1bBAAeGZS2Y8SYw6HvNBZE78vRtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwQo58Rc230krzqRQeKmk2pPlDzTxIxJAfk6Gm65R2kR3vsUXHIMSOsdjuTNFli1GnUeNiS0jG97F6tc+OiG/MFc7VlMn3mXl/C/WQA94h5D1PiyVuHfMkGfEtwjogXZWfs/IyOggRRRJJbGyeMEwia6FIdwVzJ7XMQ/zkwrMbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aKPJn4Y0; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKPJn4Y0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l359/Xp+lWbLqQmpj4GeinmzkuAfpAq138MgDKgC/VKOJBgMAqmLGfNh33XohjQXZReGXYxEhPpguWQq0iKIfQDi+Q3CXXkIzHrJ1u1ScoW+wMSjSZDO8E25lsR4Fl9o4p+CnBGL1Ts0KZG0PjAxjea8hqky4C68ZnebBVKnuE/Qp6Xyv9Z5GeVC5qV5AJCwowQGjAWb+kQXlnrW35Cz/U1a7yJZpYDPu9hZlsqW9OPEWoCm6gVqlipY94mGfE7+8+GxbwTQwhHzHAaTYI5VY5WkvPC0FlPJqtDdu2h3qHR0u2zqI75MzMnASBNNLneG6/4c6KUfs9/VtGEjSxW9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nhH4rehtxiXaGpLR3iK/N8jCWBaoutYYggG0kOa/O8=;
 b=SFu6hW5E+DEN9WvFhjqknkMsYis0/oZaGnNSKl76YyrliGCk21dM6vv0GeluQfHboYmby6zOFk7KFltPUsnUq+fiY9OTVaV+CqOoVt+n+w3yB2ddyaAice0piiMpNLQE8i6ruyc+z0dPbG3PLQhWtWcusJpkppWgPumj/+wEbC/LLoqo/wNds8ZfnavetttHRc+FEYgDwlrT5iu0K1zrYNVQmU6xrE1MlsEXkygNJ4Qmj6jY4hCeSifpRqEbdkmz7Xq0zg7gE6SSiWSvdxxHLHvU0VGS16VNNp2Mn8bL91zqO22WdvLiHxSpdFamyYC+b+Khz8QaOB3m3sd1j+QySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nhH4rehtxiXaGpLR3iK/N8jCWBaoutYYggG0kOa/O8=;
 b=aKPJn4Y0GehzfHADbwuWMu9EpHq68YaTxmMgwrQQu/irGVv48qmM7HbN7ex6AmF6KKlZi4t+xCU9yItIyy/rbHeuinTEZ9ID97r0ErcZ2/QLiWpQDWQYYKSKGHCBEzjw+uHVwv7ovQXGBUiv7p71lxFQWKXrfT4sVu8YeKO+/ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:04:10 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:04:10 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 4/6] shared/bap: Remove not needed function
Date: Thu, 16 May 2024 16:03:58 +0300
Message-Id: <20240516130400.16713-5-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0190.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::27) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: fd21015a-7b75-4dc4-1293-08dc75a8ad14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d02ooY/IDMz6slgTiclLa83hUEhydIxVQEd3gKj9ZlIKqCDlszQHJCksqt5k?=
 =?us-ascii?Q?D7cvc0hdnSwdYmNCI5uEbNwjOf0tUrHcN5orCA0TSlVdFd+14x3SHutjZdGs?=
 =?us-ascii?Q?17EF1YPXM1lzgp0DU11fAZna9GnvV68Hh1EDVOAxl7tKjilcmfhUZDD+fZ0+?=
 =?us-ascii?Q?ifcYR9VPG7gKMnc/lzr+4Cj/fmBmCfSVRbbQMT4t5gCt/49MwTLQzQ2GCYlT?=
 =?us-ascii?Q?BxBtyniI8Q1FnA+2ONPcXnHYk6JavnR403DWHTWMefA0ZiOMVqgD3qenrZH2?=
 =?us-ascii?Q?P7E1vAYQ/tsMuKkKw4/mtNnePCSI5tsuHTwwucuXD2dHTo6Jip/yYxWpCdad?=
 =?us-ascii?Q?In8j57XkfQonC6NjZkVPZuXzx4PMFPjcdbSmX49WUPSsy44b9D/RH/B1Oj/E?=
 =?us-ascii?Q?xVhzoGlgEsUu3FTcymVO6uxMf8PIokyXJTI5SuZ36p/cn0rglLsiEjG3xmy4?=
 =?us-ascii?Q?6YejU7eKlfEUF9lFPNDcggpG0+R6ryYCO0EEjUm0xVHbvWkcCUeqbbM0l5S0?=
 =?us-ascii?Q?GwNirVrnXMy/fJVFmigS+QrnW/JjOnWepErmlOziBPiCWB0Gkmt+IT6f6/OT?=
 =?us-ascii?Q?PWZ23sDrlMo03iYtAZhIKjlzmqQmzBSEmJcaBOhZbQP8Y4vP9RkQvasP8i0O?=
 =?us-ascii?Q?k2h0hZqfVL5v+Z250178elSvMncrd2TIer7fdAVZYPY1CDWkrPhUqgIPgj6v?=
 =?us-ascii?Q?U6lpfEdeGV2zw63cnwfO6GBw2V1VInwzmBX/af95BcY2PZmF8MCo9I1RxtOB?=
 =?us-ascii?Q?BGSUvED1Qht42H8lPdjnRIn6xT3sYZcEIr7EToaZM8NwVz0pPq+L70/v+cKh?=
 =?us-ascii?Q?LonAL5felE3/NiGdj7lanC7MeD3RWtINMaBcICwDNn/rRQZfZ7PU2VjkBuWR?=
 =?us-ascii?Q?yUbMfqapMI9uJSBzZmOs9ynHtoFW9Mpi6WVot9wwcAHhPznr0vyUlRXH+5qx?=
 =?us-ascii?Q?BMBULjJ2G9eWHKGDDmeIfNs0EgQmSUhNy8lojlIq1vKbPNI8645QRqvwCs0z?=
 =?us-ascii?Q?2OwqFY4APiBFx+jrA4sy7FaIbC6CLYOIX03eWjR0fumDuzzTNWgfmnnStqp7?=
 =?us-ascii?Q?4TFDzk0/KD+jaZXGgKEgA8V1QihjhGxptnzMgeizc1+1xNelozvoJ9MN3th6?=
 =?us-ascii?Q?JO8hQ8Hm5dVQNUo71j5LokNsv1TDkEjm4NPPJoNn4hc1tYwlODAprtDSRnHh?=
 =?us-ascii?Q?Ub1QK/M+Hb0nBDwGnsg44NWtemEKIhi9PuBoFB3+i+acpRiKw0zfeaD0ORlc?=
 =?us-ascii?Q?3XJcJLKZ0SyY7mZWzlmMxUBknHf3znZWJK2AH9TxJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+pgx5Zwch/q2x4hePsoYS80F+EBEWa2CMKLLQ1nWJWS7Y1nzaxdc0Eb7Ama?=
 =?us-ascii?Q?z8Ii33KI4pQT6N3Z9XQ5mj5W7Iq31CIyPAP/rt0DkVuIfOIyOfN2oSdkmhw2?=
 =?us-ascii?Q?q90fRzJKcXn+Y5ZUFsMakMb9D28MCK119rmnJqqu1vN7sRRNS/g67PnYz5cu?=
 =?us-ascii?Q?US088CB1fJGnfe8h3wgbByyc/j3WgjD2ojJ1UTI0g13QED03WNRHycH057+e?=
 =?us-ascii?Q?ZyBNlqHJvqRlqSo4s/fd+EfO9Yv29NCM+VjDdr5JjhHC4Q1AtGGK4OlYDVIq?=
 =?us-ascii?Q?yUO/brIg4Z3kOhmp+lQykxWp06WrXr1pMe5yRLGgXxThdPrW9BHEU50wfH62?=
 =?us-ascii?Q?zPbGpB1HDGKPLEpCXkAjtg+UFYKUNLhrfXJpYMY2Ds48B/njSSajZHtGu4l5?=
 =?us-ascii?Q?J1XVzxC8Gdqx+jz5JdZlEemqvORNAIlFn6HxYb3lFFK0wMpfP0bdr8tCd32d?=
 =?us-ascii?Q?n7a6Z+LQQ3mz1aDWURun3Iw87JlCq9k3Xn0a+wrOaomHvjN0aOp2bpUKyREv?=
 =?us-ascii?Q?Ad2Gm6fdCNkm+MpJR/lFqPnBqNxtdt9aQMQ8phJEocVQJl1W35BpVW8cyau5?=
 =?us-ascii?Q?tUy+W8ioIqBI6BWIiQwsBilMxee7HSPamC7hsBDmPPONzkLUFNEOfP9C/nDw?=
 =?us-ascii?Q?GJALXGlk3TNYslC+Y9Cy61H50TUDNuCoGgZ5wDnx866kH2bRHG0gSe4ahzSL?=
 =?us-ascii?Q?4szLCfVA1s3sowLzH/9qzgDeKuV9NZSxHbIuVY5/Zxr5T1wBIpJpqKZDg+Eo?=
 =?us-ascii?Q?fxyhmnzTfuxGJxFK/gZdrLQLlTYQEVFe+e60QdyRebVZY2BAg14V+QdOWMDa?=
 =?us-ascii?Q?ignUiNPVF2nZbZIzCp07M+2pYgVp8nf8DDgk0zv+qthq6BTUqNDBXV3fIdEB?=
 =?us-ascii?Q?rolSMggyS+RG5IrsRMRW1qdOPaXV4U9aGYqNLE/G2Rik6yRCfh1WkMdBK06y?=
 =?us-ascii?Q?NAAH2CoNvZeqqYihq7AGG6af48V/Rx56sD8bkT+UZ3m4YaV5WsjOmwHL67o4?=
 =?us-ascii?Q?FMUhSzbQG4NTxCP6K+3TAsDfqwBlSiJ2Znxc42wLkrFrBkgHERMDvOJn1LQ5?=
 =?us-ascii?Q?TzUFRN6vdfxhRvQ3GIeTB2vKbEwr2zBSg8CjKFrAs5Ijq7MBc8pEx6gXuOl5?=
 =?us-ascii?Q?rH4lbq6MuwKD0C5ldPNUgp5zb4Nsdt3IgmhKNBIEBpD4MqwRzOkWDKZwbv8U?=
 =?us-ascii?Q?aezlqnrQh+wsVBA3iUWNfXoipwgrdeoSY9CUGeodQ4cUpxEaIrk4nh99f1do?=
 =?us-ascii?Q?W04Dr1FS4R3I3cugW0/Id9kR9VGxwQ9xNJfWtBe3C74MRNjVz48TpV8g8P3d?=
 =?us-ascii?Q?KAXWmbeDA9ddJ0j61dE36S62Nhb/ick8q/OGGMizQYXfwZUXGjrfjByDWxwH?=
 =?us-ascii?Q?qC+2FsbIxtO+LkyHABwdLC1M/sbt39c6SqME7D7muXxsOht1zFnG/ifGt4Ep?=
 =?us-ascii?Q?CP/XYDVAhzJIxrVYybc+eqqpFfxCvw3Q1DsHwF/itlG35F/REkKTFiISf9MC?=
 =?us-ascii?Q?4sH7boN8oBd0hNQ3+cmGLvd1ylC8vSTdS/Tfb+p0MhUHl4suQYTXeNJwcBKK?=
 =?us-ascii?Q?OK6yoPGsDBHAMQ0w3SQNJePhRwLaEu+PsxkDQD7oYeJ/pwxCPQ3n5tg92sst?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd21015a-7b75-4dc4-1293-08dc75a8ad14
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:09.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97R+xL8V+mZZxzY0dQQKKDN4Zghszi8nSsNAJhFgVzoh8njlLJOHYR8AeJgHJeB1mtqBvJXBwD/lBEKTJ+c8uP8bIN5Byl+1MywUNw8UVTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

---
 src/shared/bap.c | 82 +++++++++---------------------------------------
 src/shared/bap.h |  6 ----
 2 files changed, 15 insertions(+), 73 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c927ddc21572..1d1a6b25d1a9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6425,7 +6425,8 @@ static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
 		data->found = false;
 }
 
-static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
+static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
+	struct iovec *bis_data)
 {
 	struct bt_ltv_match compare_data = {};
 
@@ -6451,21 +6452,18 @@ static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
 				&compare_data);
 	}
 
-	return compare_data.found;
+	return compare_data;
 }
 
-void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
 		struct iovec *l2_caps,
 		struct iovec *l3_caps,
-		struct iovec *meta)
+		struct bt_bap_pac **lpac,
+		struct iovec **caps)
 {
-	struct bt_bap_pac *pac_source_bis;
-	struct bt_bap_endpoint *ep;
-	int err = 0;
-	struct bt_bap_pac_qos bis_qos = {0};
-	uint8_t type = 0;
 	struct bt_ltv_extract merge_data = {0};
+	struct bt_ltv_match match_data;
 
 	merge_data.src = l3_caps;
 	merge_data.result = new0(struct iovec, 1);
@@ -6481,64 +6479,14 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-	if (bap_check_bis(bap->ldb, merge_data.result) == false)
-		goto cleanup;
-
-	DBG(bap, "Matching BIS %i", bis_index);
-
-	/* Create a QoS structure based on the received BIS information to
-	 * specify the desired channel for this BIS/PAC
-	 */
-	type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
-	util_ltv_foreach(merge_data.result->iov_base,
-			merge_data.result->iov_len, &type,
-			bap_sink_get_allocation, &bis_qos.location);
-
-	/* Create a remote PAC */
-	pac_source_bis = bap_pac_new(bap->rdb, NULL,
-				BT_BAP_BCAST_SOURCE, codec, &bis_qos,
-				merge_data.result, meta);
-
-	err = asprintf(&pac_source_bis->name, "%d", bis_index);
-
-	if (err < 0) {
-		DBG(bap, "error in asprintf");
-		goto cleanup;
+	match_data = bap_check_bis(bap->ldb, merge_data.result);
+	if (match_data.found == true) {
+		*caps = merge_data.result;
+		DBG(bap, "Matching BIS %i", bis_index);
+	} else {
+		util_iov_free(merge_data.result, 1);
+		*caps = NULL;
+		*lpac = NULL;
 	}
 
-	/* Add remote source endpoint */
-	if (!bap->rdb->broadcast_sources)
-		bap->rdb->broadcast_sources = queue_new();
-	queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
-
-	queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis);
-	/* Push remote endpoint with direction sink */
-	ep = bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
-
-	if (ep)
-		queue_push_tail(bap->remote_eps, ep);
-
-cleanup:
-	util_iov_free(merge_data.result, 1);
-}
-
-void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
-		struct bt_bap_codec *codec,
-		struct iovec *l2_caps,
-		struct iovec *l3_caps,
-		struct bt_bap_pac **lpac,
-		struct iovec **caps)
-{
-	struct bt_ltv_extract merge_data = {0};
-
-	merge_data.src = l3_caps;
-	merge_data.result = new0(struct iovec, 1);
-
-	/* Create a Codec Specific Configuration with LTVs at level 2 (subgroup)
-	 * overwritten by LTVs at level 3 (BIS)
-	 */
-	util_ltv_foreach(l2_caps->iov_base,
-			l2_caps->iov_len,
-			NULL,
-			bap_sink_check_level2_ltv, &merge_data);
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index c9cc4c3a4db7..b35b2711edb9 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -251,12 +251,6 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 
-void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
-		struct bt_bap_codec *codec,
-		struct iovec *l2_caps,
-		struct iovec *l3_caps,
-		struct iovec *meta);
-
 void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
 		struct iovec *l2_caps,
-- 
2.40.1

