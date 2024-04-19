Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BD13B5A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550094; cv=fail; b=KJTK4OXbRQclBp7LWR4slwRsDKiqBF+X4db1Ke4kwBfzvKCZvHj6UmDuo7TBdI7deABRqPAAxPpIUkjGNNkyUSvcanZpyQg4O6em1ne6mbz7QaQCWZMpeuJWZICIMP5GoH+/Bhlr732hGpYkWXCF0fSwoXLiM65cyoiKeWv4E9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550094; c=relaxed/simple;
	bh=PAcz4SD+EYh2NgK3WzNEn9o5pEJx/HGVmNXgnE7Vlic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUhCxxwfFNS5RSh9YwdjarpH17+slg2hBiRSlTmYlT52cW9F1bpbk/AADEsr3b2rnAPNtL2iH3ii68ulER+/LhCOTU5qrRj5pm0ow7zP3fy1ztbqcENnmFVTPs8VStqRqOzenLP2BnnWouUCE0TmUxf65SbrU9VSvZxqMMfoNHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pzUNDGi/; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pzUNDGi/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN4UmTZzLu9yLIZXQpEXxcXoALQVUlfC8qOrTackCl5KO2sYgtE29KHohrP7s/C1IJmN7JP88juqVjTTSF5Izd0WSVQviHgp62fAnyRbxw/qMZcLwXVDEf9ViPgBsb//GJWhu5LBPZm6ZP2chedLjLNqCRmSGudChreLD4J4zy8c9/506Fjzcg+/NWQpqgBtOo+a0nANecHFXv/Br3zTIWM63nTMu88EwgvRSXlWWmBZTq3rjJsn9iGnKxLFA4cZ6O2T5xE54JEH9k5oDajhI7L3Cskrnaj0IOGkLGRnagp4YUNhoVxgZxe+ZJz6hIozcvyLskWMNlPkr5TyOZBdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObXBBNDfSPC9j6DJ7bl/wgve1yTyqqGY6oZQCClD84U=;
 b=DP7RTvx6k4RiOOH2YT/LMJ+sd+rhrqEZYi9Le94tSymbC6Y1qY/LyWptDy2W1BsCI14zT2nWlInT3kgznOnveE3BbQKuVlJZDNuCjMSCtb6gx0BVFdKer0nUO5TSBIKrD4SKzmk+8aMvqBx1wQICwY7s06i0G29FCSZDTvtm8ceKSBGqUCBk2qR4v+b+pGiAQ/88n06QR+pFkQ5pNpXKOsiGIlzhLbWx73Vv42fvIQmReZXjuATW9JWsql/isd3Ood6Z7rRSMRFMxCBJowgzhWendWWHTaFLXP1uW1bJN1pilolIWnA7Zk74rdOYemnAn7I3VPDkB8DcAuuDPzkhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObXBBNDfSPC9j6DJ7bl/wgve1yTyqqGY6oZQCClD84U=;
 b=pzUNDGi/z9jEcV8MaWyoyNF+MTqxKSXUvxwfA02gkT0QdVji0DTi8y/NpiDKY3eFDUMHm2RwTy9UfdfkyV9qGDGEjI09THNrjZWndzDIs6ChyC8LOBa/5d+MkZRlRUVHTkYlyDap4ihgFM27lKyv6O/xCD03U5c8QelQdFEddpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PA1PR04MB10261.eurprd04.prod.outlook.com (2603:10a6:102:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.48; Fri, 19 Apr
 2024 18:08:08 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:08:08 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 5/5] bap: Create streams and transports for each matching BIS
Date: Fri, 19 Apr 2024 21:07:52 +0300
Message-Id: <20240419180752.96699-6-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::10) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PA1PR04MB10261:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc2c155-6c2a-4528-9bc3-08dc609baaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sgUFAWAjp3eMLL0opxuPCiA+lrw+3C7/Emp3VeiOw0pFk6jEYJbOdU6cZOD?=
 =?us-ascii?Q?AAP0ieNY37akghpi1BhJST4mokJCZ5q15u5t3GyU0+sRa1Wh1c6qRQv0Zthp?=
 =?us-ascii?Q?ASOcICEWh5CkBrqNScF8vtbuL6D2YsBWZVtWHVpYnmBAQjEjknm9ka/f2qU8?=
 =?us-ascii?Q?lTRW0q6vWzR9V0R32EBzyK/vg+XoEc24ARCHv9AZtLyYp2JDNvP3wwdXnXXK?=
 =?us-ascii?Q?XFv8+jbXPkx3Vl/YEiN2zdNcUv1m3pf/gzy80xpc58SR38HJTJuIfDVnrYWv?=
 =?us-ascii?Q?5X7GnIL2tuyuag2rOecYZbO5HvUGZ3zWSkBVrypeXqrdthkO8uibwGAZmkba?=
 =?us-ascii?Q?hwq5AoBzgisK5y8toduLLD/19nLo0KxpXFws93EyOW7T+uriiEg4W1+Wx/dl?=
 =?us-ascii?Q?eoMkBNpfTh4M42MD0XdYqrLIp8ZSwo/+IynJOILcgJld+zuRfyOIzn7Vzhoz?=
 =?us-ascii?Q?r0qeEDxPqAOmkjs013937cjbF5+cQe3GDyRnAXg7FZUf0BI56TT6qD/7+NaP?=
 =?us-ascii?Q?wG0fX05Zedzbw1To1yG/UE+z47jpVPSLNZRkggLmW8bs2kW7zhNK+ADeoiV8?=
 =?us-ascii?Q?aUzMV/JQGqeg1snGOPikIuaGELFCXWrAQ6kXksuZCQlh1TKihfZCUgdrfloV?=
 =?us-ascii?Q?Ef796F4moAQmzWi3u9i1SQ1pasuMcS3WP2+mzSdT4bix3Gzr+f/urNKEoV6W?=
 =?us-ascii?Q?3yHXXPjtRY894SZGIzr66qfX2zVA1QPQeKcZI5YINtZ6ZrMUHtI10WyqfYre?=
 =?us-ascii?Q?filSzUg8XgcX4UNjB3zvG0VLOWd2y/4hJ7Cg4CD2ie0isgYHAAf3fIVmexwq?=
 =?us-ascii?Q?ST9gBFFS2+BZdXISexDhtN5aoWxpsrXnnzM/ZvkQcsrF6hHL1QED3MiD+3jW?=
 =?us-ascii?Q?CrMGdhKWW40ismBqUqD3AuBUiLigWuBP9pYVtgSOH1xBGAouHMCqz1vLRv4s?=
 =?us-ascii?Q?kT63Bino7gLo2xQBhaaJjGxM0Ku5IGQHARciqMPWMnEHUyq3kfEbFC8T22HQ?=
 =?us-ascii?Q?PSJVdmUzZRe6SUA4PGUX4aBp0BRNgy1zlON53XK5T4lEFZP1DpeTa1X02GkS?=
 =?us-ascii?Q?87tuVRULwk65751IX4KpH1+K/7mFm42f7x0Qh0wLf3nyOpeHDA9VE7JSvyIT?=
 =?us-ascii?Q?hoNTfPnC6k8WlxSBZ8yuzNBFKOkdo66VcG+FDUD57i8/Rkvi9V2OBCf5he9S?=
 =?us-ascii?Q?8UCLd2h/8IhQfZB6mKwPksYCdVJbJJrIpB95y0d7WJ0z0mmM+gcBwkICOLVW?=
 =?us-ascii?Q?rUXclQQWQvk3+ziDr7SoTryL3Dm6mccYq9yWR2ppbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBi6X02rXDtmorVZHtmyh8gm2yit7ST/XCiSZDHxzUc5Xh85yHqzQvHiafVp?=
 =?us-ascii?Q?Qr7HVA+GlNr9W+Ay33hXsCjKPW/ZAT4yqfoxlwb4FD7YAqJVW8fMDSf80YLa?=
 =?us-ascii?Q?on4nAYgj3QX5Hh/LzQAKp+D0BaR8oHSHiUGws7W+7t1UDIwpFjgqg0L7TPEt?=
 =?us-ascii?Q?9kOW6t1roUf61esDqz626OVPRbFI/IPoVMx6h+z84VD0pgt57ZVB71zXN8x4?=
 =?us-ascii?Q?ACQ5pWQMdq0Jj795nFTxNEY7TcTALzEsO8uZ7ya0LQppvUrs5BmRi7+0PmeF?=
 =?us-ascii?Q?a+7Hecj22geomuRiYJCLLPWzYh1mJZHOSOEuEbRU/NiDz7GQQf7gTEuiBWc4?=
 =?us-ascii?Q?5BNQJwHivJuEUfeySjSjhqZALosVTahTQktNbsanqffvbFACOYX6JiNaIO7P?=
 =?us-ascii?Q?UsjfmHHtloUa/2fTJ4wDniBWYJGJ/Ak3JBy24f3L0aLxne3FrBH+vHt75KZd?=
 =?us-ascii?Q?f78hmLpZC1EfDlWJf2basMKqj1oTdMFy6DgZ/PxEYgbS1U/iJrpqVydVc5jR?=
 =?us-ascii?Q?VO64X1dKLv0W7DDO7VFZko2G+DbKn69w0Ji2P6gjLZxTmEcyNlUr0wxF70JF?=
 =?us-ascii?Q?/8jejW10gyBge6ds8YdO/zzjpd8RexcEx6fb6JrrAsXHbGetbwp8BkO8dEQw?=
 =?us-ascii?Q?oz74Vujw7TF7x/01e07aAjil+cjRXya8L57QVyQB5JUqSieLtp1IebQCCZlX?=
 =?us-ascii?Q?2weIHf90pZRu81I5j+idMXwaPeCUPZ0zncQVt+CvRtFlSwfMiIwhKa2mdGAj?=
 =?us-ascii?Q?CCPZta0hqqd+kuZs71nxz9O9cr/AQWY1lEUgKe0Upj/WJgkVzWwvwxlBTXqZ?=
 =?us-ascii?Q?UDtJC+eR9yHebglW9J4s1evfogYTDpnC4CTs3DkvMVC+XyvbJlu4aSegX7h+?=
 =?us-ascii?Q?q060inwW5O8/08KXzg5FGt0irahF7dXu2UA1fqNpxg4vEW0okUNE6ybXHoNs?=
 =?us-ascii?Q?POEan4tA0aWFdhZF8A2gOtRAu2FFfpcqbQmGvYEEC1GL6awfwbuEFPDmSuJA?=
 =?us-ascii?Q?IITSYcVc2rVzErTUkDaS3eNo6lEQsRXxWIdeYlIkWYGkiUS37aArD58D7pcI?=
 =?us-ascii?Q?gxk9wnE2YVtLbWoUMxACPJis2cnMZuyfG+69RvnSzSLozUN2lzVhVsiRuTUO?=
 =?us-ascii?Q?I1SAL+UMTL97EY1phSPy7AtetCR9iDl/2/OiR04xqtM2oBKtxbq/SzJiOjJq?=
 =?us-ascii?Q?bwJzaBIAr3avt/oIQIOweqpLB7xQEwZUjigOeoAoT2VmUwXTgnlVq7oy5tST?=
 =?us-ascii?Q?XI7yVjsBYNXmNDczvTX1Lh0+9uLq+wu6EwPyJ8SEav+h7zQvuns8DmlATlLi?=
 =?us-ascii?Q?B8+Ofyt/UgGIWTsdNSS3QzlgtOJeWlzLf9+3GhqizjhzI6y08DT43dqj15YX?=
 =?us-ascii?Q?yvfYWlAKTPNyITxlktbMl7+2UuZXTY2YWW9YKbjHj3RAPC9QL9oFEMNO1lQ1?=
 =?us-ascii?Q?Ney1JmB2mQARGd8Rm6lOvKEGCZfdCzKnaSSiN4VvSD9/myhXM4Tb6XO20vv1?=
 =?us-ascii?Q?PqJ/LPRVrymZvkqhOk4Xe/gh1av4MoOZjKgGi6Jsms7ZA2v2ExewyhEI7hO4?=
 =?us-ascii?Q?00MO6xQhbW7zQ4wT7JTB4zU0rgCHvmJ/twoWSA/BsV5AvNtb+5s5g3QtP7ij?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc2c155-6c2a-4528-9bc3-08dc609baaf0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:08:08.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnnMRdyqHjMQgB16voZ/S99Snx+eerc9BUvUbQ0vH9NtPedkcPz5ozF/d4QKExCq5Yv8kae73hI88nawCeYqlMn8f0WufIi7nb10S+lzTrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10261

Rename bt_bap_add_bis to bt_bap_check_bis as its scope has changed.
Use the BIS index received in the BASE to synchronize to the BIG.
Allow bt_bap_endpoint to be NULL.
Remove the Broadcast Sink code from set_configuration.
Update BASE parsing so that it creates streams and transports, without a
remote PAC and endpoint.
Update bap_find_setup_by_stream to find the setup in case the stream does
not contain an endpoint.
Update BAP Broadcast Sink state machine:
* BIS matched over the air -> create stream and transport and set the
  stream state to BT_BAP_STREAM_STATE_CONFIG
* transport acquire sets stream state to BT_BAP_STREAM_STATE_ENABLING
  and do BIG Create Sync
* BIG Sync Established received sets stream state to
  BT_BAP_STREAM_STATE_STREAMING
---
 profiles/audio/bap.c | 184 +++++++++++++++++++++++++++++----------
 src/shared/bap.c     | 199 ++++++++++++++++++++++---------------------
 src/shared/bap.h     |   6 +-
 3 files changed, 244 insertions(+), 145 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ff6d6d881346..b59ef405ab74 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -109,6 +109,7 @@ struct bap_data {
 	struct queue *srcs;
 	struct queue *snks;
 	struct queue *bcast;
+	struct queue *bcast_snks;
 	struct queue *streams;
 	GIOChannel *listen_io;
 	int selecting;
@@ -125,7 +126,10 @@ struct bap_bcast_pa_req {
 	bool in_progress;
 	union {
 		struct btd_service *service;
-		struct bap_setup *setup;
+		struct bap_accept {
+			struct bap_setup *setup;
+			struct bap_data *bap_data;
+		} accept_data;
 	} data;
 };
 
@@ -197,6 +201,8 @@ static void ep_unregister(void *data)
 						MEDIA_ENDPOINT_INTERFACE);
 }
 
+static void setup_free(void *data);
+
 static void bap_data_free(struct bap_data *data)
 {
 	if (data->listen_io) {
@@ -213,6 +219,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->streams, NULL);
+	queue_destroy(data->bcast_snks, setup_free);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -850,7 +857,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 	setup = new0(struct bap_setup, 1);
 	setup->ep = ep;
 
-	if (queue_find(ep->data->bcast, NULL, ep)) {
+	/* Broadcast Source has endpoints in bcast list, Broadcast Sink
+	 * does not have endpoints
+	 */
+	if (((ep != NULL) && queue_find(ep->data->bcast, NULL, ep)) ||
+			(ep == NULL)) {
 		/* Mark BIG and BIS to be auto assigned */
 		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
@@ -866,12 +877,14 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		setup->qos_parser = setup_parse_ucast_qos;
 	}
 
-	if (!ep->setups)
-		ep->setups = queue_new();
+	if (ep) {
+		if (!ep->setups)
+			ep->setups = queue_new();
 
-	queue_push_tail(ep->setups, setup);
+		queue_push_tail(ep->setups, setup);
 
-	DBG("ep %p setup %p", ep, setup);
+		DBG("ep %p setup %p", ep, setup);
+	}
 
 	return setup;
 }
@@ -942,17 +955,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	/* For BAP Broadcast Sink, the capabilities and metadata are coming
-	 * from the source's BIS, which are present in the remote PAC
-	 */
-	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
-		util_iov_free(setup->caps, 1);
-		setup->caps = util_iov_dup(bt_bap_pac_get_data(ep->rpac), 1);
-		util_iov_free(setup->metadata, 1);
-		setup->metadata = util_iov_dup(
-				bt_bap_pac_get_metadata(ep->rpac), 1);
-	}
-
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
@@ -988,20 +990,24 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
+	struct bap_setup *setup = req->data.accept_data.setup;
 	int fd;
 
 	DBG("BIG Sync completed");
 
 	queue_remove(bcast_pa_requests, req);
 
+	g_io_channel_unref(setup->io);
+	g_io_channel_shutdown(setup->io, TRUE, NULL);
+	setup->io = NULL;
+
 	/* This device is no longer needed */
-	btd_service_connecting_complete(setup->ep->data->service, 0);
+	btd_service_connecting_complete(req->data.accept_data.bap_data->service,
+			0);
 
 	fd = g_io_channel_unix_get_fd(io);
 
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
-		bt_bap_stream_enable(setup->stream, true, NULL, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -1014,8 +1020,54 @@ static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	util_hexdump(' ', v, l, user_data, NULL);
 }
 
-static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
-		util_debug_func_t func)
+static void create_stream_for_bis(struct bap_data *bap_data,
+		struct bt_bap_pac *lpac, struct bt_iso_qos *qos,
+		struct iovec *caps, struct iovec *meta, char *path)
+{
+	struct bap_setup *setup;
+
+	setup = setup_new(NULL);
+
+	/* Create BAP QoS structure */
+	setup->qos.bcast.big = qos->bcast.big;
+	setup->qos.bcast.bis = qos->bcast.bis;
+	setup->qos.bcast.sync_factor = qos->bcast.sync_factor;
+	setup->qos.bcast.packing = qos->bcast.packing;
+	setup->qos.bcast.framing = qos->bcast.framing;
+	setup->qos.bcast.encryption = qos->bcast.encryption;
+	if (setup->qos.bcast.encryption)
+		util_iov_append(setup->qos.bcast.bcode,
+				qos->bcast.bcode,
+				sizeof(qos->bcast.bcode));
+	setup->qos.bcast.options = qos->bcast.options;
+	setup->qos.bcast.skip = qos->bcast.skip;
+	setup->qos.bcast.sync_timeout = qos->bcast.sync_timeout;
+	setup->qos.bcast.sync_cte_type =
+			qos->bcast.sync_cte_type;
+	setup->qos.bcast.mse = qos->bcast.mse;
+	setup->qos.bcast.timeout = qos->bcast.timeout;
+	setup->qos.bcast.io_qos.interval =
+			qos->bcast.in.interval;
+	setup->qos.bcast.io_qos.latency = qos->bcast.in.latency;
+	setup->qos.bcast.io_qos.phy = qos->bcast.in.phy;
+	setup->qos.bcast.io_qos.rtn = qos->bcast.in.rtn;
+	setup->qos.bcast.io_qos.sdu = qos->bcast.in.sdu;
+
+	queue_push_tail(bap_data->bcast_snks, setup);
+
+	/* Create and configure stream */
+	setup->stream = bt_bap_stream_new(bap_data->bap,
+			lpac, NULL, &setup->qos, caps);
+
+	bt_bap_stream_set_user_data(setup->stream, path);
+	bt_bap_stream_config(setup->stream, &setup->qos,
+			caps, NULL, NULL);
+	bt_bap_stream_metadata(setup->stream, meta,
+			NULL, NULL);
+}
+
+static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
+		struct bt_iso_qos *qos, util_debug_func_t func)
 {
 	struct iovec iov = {
 		.iov_base = base->base,
@@ -1087,11 +1139,20 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 		for (; num_bis; num_bis--) {
 			uint8_t bis_index;
 			struct iovec *l3_caps;
+			struct iovec *merged_caps;
+			struct bt_bap_pac *matched_lpac;
+			char *path;
+			int err;
 
 			if (!util_iov_pull_u8(&iov, &bis_index))
 				goto fail;
 
 			util_debug(func, NULL, "BIS #%d", bis_index);
+			err = asprintf(&path, "%s/bis%d",
+					device_get_path(bap_data->device),
+					bis_index);
+			if (err < 0)
+				continue;
 
 			/* Read Codec Specific Configuration */
 			l3_caps = new0(struct iovec, 1);
@@ -1110,9 +1171,16 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 					l3_caps->iov_len, NULL, print_ltv,
 					func);
 
-			/* Try to create a PAC using this BIS information */
-			bt_bap_add_bis(bap, bis_index, &codec, l2_caps, l3_caps,
-					meta);
+			/* Check if this BIS matches any local PAC */
+			bt_bap_verify_bis(bap_data->bap, bis_index, &codec,
+					l2_caps, l3_caps, &matched_lpac,
+					&merged_caps);
+
+			if (matched_lpac == NULL || merged_caps == NULL)
+				continue;
+
+			create_stream_for_bis(bap_data, matched_lpac, qos,
+					merged_caps, meta, path);
 		}
 
 	}
@@ -1155,7 +1223,9 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
-	parse_base(data->bap, &base, bap_debug);
+	parse_base(data, &base, &qos, bap_debug);
+
+	service_set_connecting(pa_req->data.service);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1558,6 +1628,7 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 					struct bt_bap_stream *stream)
 {
 	struct bap_ep *ep = NULL;
+	struct queue *queue = NULL;
 
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
@@ -1572,9 +1643,11 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 	}
 
 	if (ep)
-		return queue_find(ep->setups, match_setup_stream, stream);
+		queue = ep->setups;
+	else
+		queue = data->bcast_snks;
 
-	return NULL;
+	return queue_find(queue, match_setup_stream, stream);
 }
 
 static void iso_connect_bcast_cb(GIOChannel *chan, GError *err,
@@ -2097,7 +2170,8 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	 */
 	pa_req->type = BAP_PA_BIG_SYNC_REQ;
 	pa_req->in_progress = FALSE;
-	pa_req->data.setup = setup;
+	pa_req->data.accept_data.setup = setup;
+	pa_req->data.accept_data.bap_data = data;
 	queue_push_tail(bcast_pa_requests, pa_req);
 }
 
@@ -2157,7 +2231,7 @@ static void setup_create_bcast_io(struct bap_data *data,
 	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 
-	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
+	if (bt_bap_stream_get_dir(stream) == BT_BAP_BCAST_SINK)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
 			defer);
 	else
@@ -2399,12 +2473,7 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 		if (!setup || setup->id)
 			break;
 		if (bt_bap_stream_io_dir(stream) ==
-				BT_BAP_BCAST_SOURCE)
-			/* If the stream is attached to a
-			 * broadcast sink endpoint.
-			 */
-			setup_create_io(data, setup, stream, defer);
-		else {
+				BT_BAP_BCAST_SINK) {
 			/* If the stream attached to a broadcast
 			 * source endpoint generate the base.
 			 */
@@ -2455,6 +2524,14 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 			}
 		}
 		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			setup_create_io(data, setup, stream, defer);
+		break;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			setup_io_close(setup, NULL);
+		break;
 	}
 }
 
@@ -2794,6 +2871,7 @@ static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
 		error("BAP unable to attach");
 		return -EINVAL;
 	}
+	data->bcast_snks = queue_new();
 
 	bap_data_add(data);
 
@@ -2833,29 +2911,41 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bap_setup *setup = req->data.accept_data.setup;
+	struct bap_data *data = req->data.accept_data.bap_data;
 	struct sockaddr_iso_bc iso_bc_addr;
 	struct bt_iso_qos qos;
+	char *path;
+	int bis_index = 1;
+	char device_name[40] = {0};
+	int s_err;
 
-	DBG("PA Sync done, do BIG Sync");
+	DBG("PA Sync done");
 	g_io_channel_unref(setup->io);
-	setup->io = NULL;
-
+	g_io_channel_shutdown(setup->io, TRUE, NULL);
 	setup->io = io;
 	g_io_channel_ref(setup->io);
 
 	/* TODO
 	 * We can only synchronize with a single BIS to a BIG.
 	 * In order to have multiple BISes targeting this BIG we need to have
-	 * all the BISes before doing this request. This request is triggered
-	 * by an endpoint "SetConfiguration" command. For multiple BISes
-	 * we need another way to specify which BISes user is requesting
+	 * all the BISes before doing bt_io_bcast_accept.
+	 * This request comes from a transport "Acquire" call.
+	 * For multiple BISes in the same BIG we need to either wait for all
+	 * transports in the same BIG to be acquired or tell when to do the
+	 * bt_io_bcast_accept by other means
 	 */
+	path = bt_bap_stream_get_user_data(setup->stream);
+	s_err = sscanf(path, "%s/bis%d", device_name, &bis_index);
+	if (s_err == -1)
+		DBG("sscanf error");
+
+	DBG("Do BIG Sync with BIS %d", bis_index);
+
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_bis[0] = bis_index;
 	iso_bc_addr.bc_num_bis = 1;
 
 	/* Set the user requested QOS */
@@ -2898,8 +2988,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
-	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bap_setup *setup = req->data.accept_data.setup;
+	struct bap_data *data = req->data.accept_data.bap_data;
 
 	req->in_progress = TRUE;
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8c4868f4bf9f..e69f6cec99bf 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -226,6 +226,7 @@ struct bt_bap_stream_io {
 struct bt_bap_stream_ops {
 	uint8_t type;
 	void (*set_state)(struct bt_bap_stream *stream, uint8_t state);
+	unsigned int (*get_state)(struct bt_bap_stream *stream);
 	unsigned int (*config)(struct bt_bap_stream *stream,
 				struct bt_bap_qos *qos, struct iovec *data,
 				bt_bap_stream_func_t func, void *user_data);
@@ -245,6 +246,8 @@ struct bt_bap_stream_ops {
 	unsigned int (*metadata)(struct bt_bap_stream *stream,
 				struct iovec *data, bt_bap_stream_func_t func,
 				void *user_data);
+	unsigned int (*get_dir)(struct bt_bap_stream *stream);
+	unsigned int (*get_loc)(struct bt_bap_stream *stream);
 	unsigned int (*release)(struct bt_bap_stream *stream,
 				bt_bap_stream_func_t func, void *user_data);
 };
@@ -1578,6 +1581,11 @@ done:
 	bap_stream_state_changed(stream);
 }
 
+static unsigned int bap_ucast_get_state(struct bt_bap_stream *stream)
+{
+	return stream->ep->state;
+}
+
 static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
@@ -1923,6 +1931,27 @@ static bool bap_stream_valid(struct bt_bap_stream *stream)
 	return queue_find(stream->bap->streams, NULL, stream);
 }
 
+static unsigned int bap_ucast_get_dir(struct bt_bap_stream *stream)
+{
+	return stream->ep->dir;
+}
+
+static unsigned int bap_ucast_get_location(struct bt_bap_stream *stream)
+{
+	struct bt_pacs *pacs;
+
+	if (!stream)
+		return 0x00000000;
+
+	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
+
+	if (stream->ep->dir == BT_BAP_SOURCE)
+		return pacs->source_loc_value;
+	else if (stream->ep->dir == BT_BAP_SINK)
+		return pacs->sink_loc_value;
+	return 0x00000000;
+}
+
 static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2000,6 +2029,11 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	}
 }
 
+static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
+{
+	return stream->state;
+}
+
 static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
@@ -2043,6 +2077,41 @@ static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_get_dir(struct bt_bap_stream *stream)
+{
+	if (bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SINK)
+		return BT_BAP_BCAST_SOURCE;
+	else
+		return BT_BAP_BCAST_SINK;
+}
+
+static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+	*((uint32_t *)user_data) = le32_to_cpu(location32);
+}
+
+static unsigned int bap_bcast_get_location(struct bt_bap_stream *stream)
+{
+	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+	uint32_t allocation = 0;
+	struct iovec *caps;
+
+	caps = bt_bap_stream_get_config(stream);
+
+	/* Get stream allocation from capabilities */
+	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
+			bap_sink_get_allocation, &allocation);
+
+	return allocation;
+}
+
 static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2052,11 +2121,12 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	return 1;
 }
 
-#define STREAM_OPS(_type, _set_state, _config, _qos, _enable, _start, \
-			_disable, _stop, _metadata, _release) \
+#define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable, \
+	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release) \
 { \
 	.type = _type, \
 	.set_state = _set_state, \
+	.get_state = _get_state, \
 	.config = _config, \
 	.qos = _qos, \
 	.enable = _enable, \
@@ -2064,26 +2134,40 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	.disable = _disable, \
 	.stop = _stop, \
 	.metadata = _metadata, \
+	.get_dir = _get_dir,\
+	.get_loc = _get_loc, \
 	.release = _release, \
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
 	STREAM_OPS(BT_BAP_SINK, bap_ucast_set_state,
+			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
-			bap_ucast_metadata, bap_ucast_release),
+			bap_ucast_metadata, bap_ucast_get_dir,
+			bap_ucast_get_location,
+			bap_ucast_release),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
+			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
-			bap_ucast_metadata, bap_ucast_release),
+			bap_ucast_metadata, bap_ucast_get_dir,
+			bap_ucast_get_location,
+			bap_ucast_release),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_metadata, bap_bcast_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_metadata, bap_bcast_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 };
 
 static const struct bt_bap_stream_ops *
@@ -5383,11 +5467,7 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 	if (!stream)
 		return BT_BAP_STREAM_STATE_IDLE;
 
-	if (stream->lpac->type != BT_BAP_BCAST_SOURCE &&
-			stream->lpac->type != BT_BAP_BCAST_SINK)
-		return stream->ep->state;
-	else
-		return stream->state;
+	return stream->ops->get_state(stream);
 }
 
 bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
@@ -5571,53 +5651,15 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
 	if (!stream)
 		return 0x00;
 
-	if (stream->ep)
-		return stream->ep->dir;
-
-	if (bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SINK)
-		return BT_BAP_BCAST_SOURCE;
-	else
-		return BT_BAP_BCAST_SINK;
-}
-
-static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
-		uint8_t *v, void *user_data)
-{
-	uint32_t location32;
-
-	if (!v)
-		return;
-
-	memcpy(&location32, v, l);
-	*((uint32_t *)user_data) = le32_to_cpu(location32);
+	return stream->ops->get_dir(stream);
 }
 
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 {
-	struct bt_pacs *pacs;
-	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
-	uint32_t allocation = 0;
-	struct iovec *caps;
-
 	if (!stream)
 		return 0x00000000;
 
-	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
-
-	if (stream->ep) {
-		if (stream->ep->dir == BT_BAP_SOURCE)
-			return pacs->source_loc_value;
-		else if (stream->ep->dir == BT_BAP_SINK)
-			return pacs->sink_loc_value;
-	}
-
-	caps = bt_bap_stream_get_config(stream);
-
-	/* Get stream allocation from capabilities */
-	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
-			bap_sink_get_allocation, &allocation);
-
-	return allocation;
+	return stream->ops->get_loc(stream);
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
@@ -6459,17 +6501,13 @@ static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
 	return compare_data;
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
 	struct bt_ltv_match match_data = {0};
 
@@ -6488,43 +6526,14 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
 	match_data = bap_check_bis(bap->ldb, merge_data.result);
-	if (match_data.found == false)
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
+	if (match_data.found == true) {
+		*caps = merge_data.result;
+		*lpac = match_data.data;
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
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 62e2104850c7..35524df0b451 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -251,9 +251,9 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 
-void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
 		struct iovec *l2_caps,
 		struct iovec *l3_caps,
-		struct iovec *meta);
-
+		struct bt_bap_pac **lpac,
+		struct iovec **caps);
-- 
2.40.1

