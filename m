Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F05146A8A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864663; cv=fail; b=if8IWEFqZDPTsYTHXK0xV+txYMI+H9jQu0kSdfZJ1Br/rGJxP2j1+wkylMBQcry7ayUxwsz01ECS3XknsnS+clVLs8Qrdpa+8tshbyI1JpTyMwAJZlN4x3Yk0/69IiUjSh8+CkL1K26Y57zQD5WVzWnPimqyMuLg1PpbZD4Xw4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864663; c=relaxed/simple;
	bh=CTv8GsAt74FN3HIMa018Oa+ymmAAxE5pbCASHJVHKQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9O3rMOriKNgivlZSvM48ynoleE44ZOpaZY9/LDFUkUEYb6Bf+7Rrd08rJTU5/OAUck0XFba83M2vbQs7VcFZ9oy0JDC6R6/Bc3T/gk2Upqha78PCQO61vqnaoTrelPMQWlb0Z8SVfA5u/DGQxmIndPUIkUVqGFZRHBTmZMWFLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLMWlZQ6; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLMWlZQ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqRDuLLHcWhpgdJBhVoM3U5suKVJVnLq5L/OFlgnK4IAbAoO4hwaWgnWsv1v7KRcWv+VVObZl16P7y1/tIOjHwenGJ74kTyU4LGCkgfeAOLpxhUOJ50pXgqZFctVGSgbQUy8+EraQDV41BJzcpRhHLKeWr4GfBjY2SoBee44EUkAUGgEiOI5pLAhHJS1dP3BeoUaxI5zGnPNYJrzRUV3iLHPhi4UoZ6hHEg6uUcGMjkg60YwHDGOn8lWXvJHEsJXfMRKlVJHZo7F6fWYrhRUwBBAQc3V3aHCuB9Hyk8pchKuX5c3C0Tzfh4wp4vmaS4QIszLY00obP4lDQCbqoVFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1MgYxk0EslhOm7iPk+hfb+Z1gDOOF3iRHpDplbUzY8=;
 b=XhYginb5fVey+LE8dVZ342esKtqa0XAwGOXz1YNrbOF1y+e1To3aoJdPmrQsBNumnbKmcFgBgtlU5t2us6zF4iqWUKWqdQDoAjR5dv4A2zvalVByt5C9ZsOgoI0k05AanMXNIxaqeBvJ0ylm6Mg4avTWARseIjNn0nLBUcpkRrTPRHusoVHpKJ3Bs7XiiBX62SCY3OqZY4YnIcZXc71vnY4uyuxinOueGYN7geAPZPFCv/G6FGj/7YZXfmbdYF4HrhRgSeZDeUOAmTvxlBGhH6MBQt2hG/e4Q+d9GjaY5AWIPjdxqsiWMknwlJ7+gHxRnhTpqu0G/4AtkmYwuTukow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1MgYxk0EslhOm7iPk+hfb+Z1gDOOF3iRHpDplbUzY8=;
 b=ZLMWlZQ64k23yIXNyMjn0potAQP7CL9Xv1nMktgbMu+Kw3IoSFbHIgNUeOXedlwlzNLAloSru3NTTtymtDsDG5WQOLTKPqbxTZBljgH7iExTqcouCjOOwHxnnfnWPrA5S+AdCMGtbkB7kZAC7b15J4VCFAdL+rjQgqErK64EGug=
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
Subject: [PATCH BlueZ v5 3/6] bap: Update BIS management
Date: Thu, 16 May 2024 16:03:57 +0300
Message-Id: <20240516130400.16713-4-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0112.eurprd04.prod.outlook.com
 (2603:10a6:208:55::17) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed90ede-b98c-4d7c-3329-08dc75a8ac30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87dHMfaI/gXR0c66oikiyFdFfIvaW6iUg/2H47A1C3u14543Iu4Ri4Y/QpY6?=
 =?us-ascii?Q?VG9oScA89Sgy8v1dpj+p2TADvNIo8i9Ao6t4nr25am8LYB85XoColmISRlWU?=
 =?us-ascii?Q?0uLieelfSzLUL/8R1fwIDVLFbLguo/EXiP4JV4ZCEmG6as44Kq4dX2MIOaMO?=
 =?us-ascii?Q?C6j4IB2IANOVxebjQEZfhGpUllDsQJ8Q5UQo2W5Q5OPeonYAu79qhNoZYsZb?=
 =?us-ascii?Q?ft8vsFEoXvcyFaqncXYOhqBYGTU6cURh0TfPJLdBcePzINsbPF3lXF4jP2Sk?=
 =?us-ascii?Q?tYrQTvWarHWuLDZgHL/KceSyA2235A3zsfJc+KWBw4O6kMUzPR9K7tDPLjgX?=
 =?us-ascii?Q?aw3Xujt4d0iu3ze78khVdMruVDikHPQnrbWg3yBuLkgSgfZdJUIAYfWaFwAH?=
 =?us-ascii?Q?ef7YM2UeUKlTsMKGg1xajvuIevCb44FA70hurrw2r35u9ONiYdq5ePwHzKKm?=
 =?us-ascii?Q?sO8fclKtiVsndbkIYVMtNMoU1mcxUtjBAdP6u0gcMnj9j8oZlKg2uVdcVvIV?=
 =?us-ascii?Q?tp5h3h0QG8gTYHXj9cOBa0dvt5WSf6/StBpyL77Jb/FXEsh+wLIcd4cf6ZDL?=
 =?us-ascii?Q?oPKnqkEAUHg1QsrglbzNABo9lvj2IPDzwCflrJzt/Wmv/fvF9qkfdEjpwP6x?=
 =?us-ascii?Q?wY9ToS8rOTVan5YkGwxnd2VX0ZU3x+cAvX/TpsdJcQQJZBIrhqCTQ3ntIIHl?=
 =?us-ascii?Q?0CmVy6VurMJ3O4/RyVfMwfkLiDNQg49MdrRBiiQEkoJkHQOkq7ujCtlQp3IG?=
 =?us-ascii?Q?ttwHICQ7m/wsot9G7MBxgt6Jzas9wILOz6BnaJZJEjNkNJJ3SPQDvlSYmq4Z?=
 =?us-ascii?Q?rKFlgstDS88TsR5VIABdNTyyhg9YxGI/8UEmhz+FBm/jKjfgbw8IgPUnrgLY?=
 =?us-ascii?Q?uRi2mbUnuagYwIyl/1TiAA0BKHRWRPVUOl6hogNelgXeLtBm9pyWubtsjwwJ?=
 =?us-ascii?Q?wtORGNLlDr65j1a7oCUmzO9NVrCGCeb5fXtSn4j5khShLs/mLrf8nTHWPVdh?=
 =?us-ascii?Q?t8GtYRrAqBYaJRnYq4s/40w+rKEhp8oZ19w+esmvClMXnX1z+y6kuACOHQLg?=
 =?us-ascii?Q?y6vVMU4N3oZhKNgmhAgZA2+989VYOdO/xg3AIRa8llHnuY4JDJjExBrlDimf?=
 =?us-ascii?Q?j+wOlS8mWKRM0nEmAFgzJltSfPCrmNSLSXh7UszilWdTVRPfh5MoaedT8PZ5?=
 =?us-ascii?Q?OE3hsVoT/pP8ZaW8e/+YCKgMMdVm7wVlfYvu1/D4HHaNiOIkVX8vWR/zNm4X?=
 =?us-ascii?Q?PhK8tDrWfTgHCYAQhSVbRG7bohTx8WV8Ypg+S2jktg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCd/1dOXJOAeJvSkpaPM5sjb0lR4YxdFrwZ29v0aZpZeqx0oxKwRgdkRBmJG?=
 =?us-ascii?Q?SHPyzZJEysC2ucrcjg+rQYEMRgJD2YN7yD9vxgWkKvrIeuK2W5ONuqiQN7q6?=
 =?us-ascii?Q?QRnjhEz7hPtQ6aT0TJH3ZhVfvgfQh/veTXIslPUlsguH3gwlqaaxRSxcjhj2?=
 =?us-ascii?Q?Nnv00/hg6Q2x8MUYGvaGQYGyttRFtxuoPDIq1EqmWdU8bXDEja6bFL6RW/FP?=
 =?us-ascii?Q?oKJeAWbltWV2coLhZvfh35RNyTXWcd5s9YH7XlB7LUTF5hF+J9bulZA28DUe?=
 =?us-ascii?Q?CBCqxJqPiLyBKvTIetblDJu4QKo2kLqSt45D3Lybfkd2iQmxR3riKG+NMZWO?=
 =?us-ascii?Q?n3OIfSHxxu8px95fo1JoNcW6HJv7Stt5zPZGnhXl8rdLQBuTM0rU+9yunn5n?=
 =?us-ascii?Q?fedmzhVwiuI1Qzt4QrD7k0NEKvCPEMsEA6swbSu242Vo5f3P4nzjf25zEZES?=
 =?us-ascii?Q?DpBjN/zoSrRrnoZfvPr3ONG7Da5tcAI8UZ+Qt0xjY26hvMaFXNuqpZlTdn45?=
 =?us-ascii?Q?G7QFIWpAaQDbyF2eWajlf1IwIu5fN3wB+ybn8oDPNOQm+1uGeKwVKLx8lK5U?=
 =?us-ascii?Q?5rRTu+zF1NhcPGbnc1nyX1tu1M9FSLGHHaxzqjvIb1PyTkiShmOtIutGa/ph?=
 =?us-ascii?Q?plpkOi6yLUvCJBYllGAtaZ2aHgUdR1M5FnOSw+2FXD8yCiX3u0I8f668bIoq?=
 =?us-ascii?Q?FPty7w2UOh/7gs4K+D6858INQMPG84wPdfwxWM6+4KVW8VU01LvIEm7lj74Q?=
 =?us-ascii?Q?qeubtsy6x9vmrpXjkJzWVO8zVbUEyY2AjcHWcqq45JV5UMV54S81Llcu8vBm?=
 =?us-ascii?Q?QyMgA0ZrQp3qqR2ZhchWWtK3srvLdvr0zCzdRb7rV2yo+dwwCII5E7okrBdy?=
 =?us-ascii?Q?nx0J3Z2D6N0nhFmHLLTA45XnpNXGsB7hI6NEV+mywZXrfcnDWSljh1lcdcpU?=
 =?us-ascii?Q?btAuxsHvXU74mX0074mnUCk5bh1x2G0XtaCT31eEkoXUIX++7poQxDYJMaqv?=
 =?us-ascii?Q?U6yT6YZ4jDy0Wg+ZJY+2FSK8jj3iV9Ng/2k0kT/YkWHXplxX2Co/Rddegl/c?=
 =?us-ascii?Q?gzua4AzA5+3JNXncLVgMhZT7ncMwpRQoeFkRde8h+l04t0CkeeESKW08qV3h?=
 =?us-ascii?Q?oUiqc4UqUdVzLw0D6r1KPnvvCiFm3KRHObY+WvGMLs1kS7sWLitE4d9oJuJg?=
 =?us-ascii?Q?zzgAwLsfJGHIU+tL5TKFC7jwVE62hNBv6rhNpqT8YdTz59AEQKZawmn2rxn6?=
 =?us-ascii?Q?oXSTCDLholRxHrUAyPXgJ4l9RYt9q1Ez1hMg6OzfLH2KPbO//N6Q2FZx+z59?=
 =?us-ascii?Q?iETbll6IVtrevM2mH9y+t4oS+5dEy1bgGmN4RhPKUUfNP1iyhS4u5eQiwbpw?=
 =?us-ascii?Q?OcKxxM5i6HfrAHBi4G2zemidgC4uYHlUftHE2zC2cATuoHTijKVJdCejNlw5?=
 =?us-ascii?Q?P5q5FBM5kefGlCKbWC6ei4FBqeM8/fi+PNvWASGSSvhnlcDX9M7oUzYjLbxD?=
 =?us-ascii?Q?RAawIPp50NICW+NXmsXg7qh2+vu41CrGNczcUJNkSuDMJhU6lqNI0YJ5z+m5?=
 =?us-ascii?Q?69xOT+MSGXDokp5c7y/8XNxf9OA04ru8Em45FhcHPA86PP11xE6DmPKPKDJB?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed90ede-b98c-4d7c-3329-08dc75a8ac30
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:08.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPl3Qj51DjHutjv6WkmT0vV4aAHDcEO+ZDSOoJCpodWxMdanEG3LO9Dm9hJf+TDkle1Tqt3PFOnFHF/HFMTLKO9zzIbMXdVFRhKTzwk3B3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

Use the BIS index received in the BASE to synchronize to the BIG.
Allow bt_bap_endpoint to be NULL.
Remove the Broadcast Sink code from set_configuration.
Update BASE parsing so that it creates streams and transports, without a
remote PAC and endpoint.
Update bap_find_setup_by_stream to find the setup in case the stream does
not contain an endpoint.
---
 profiles/audio/bap.c | 320 ++++++++++++++++++++++++++++++-------------
 1 file changed, 226 insertions(+), 94 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f09f2ea44109..06dc4e254210 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -115,6 +115,7 @@ struct bap_data {
 	struct queue *srcs;
 	struct queue *snks;
 	struct queue *bcast;
+	struct queue *bcast_snks;
 	struct queue *streams;
 	GIOChannel *listen_io;
 	int selecting;
@@ -202,6 +203,8 @@ static void ep_unregister(void *data)
 						MEDIA_ENDPOINT_INTERFACE);
 }
 
+static void setup_free(void *data);
+
 static void bap_data_free(struct bap_data *data)
 {
 	if (data->listen_io) {
@@ -218,6 +221,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->streams, NULL);
+	queue_destroy(data->bcast_snks, setup_free);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -855,7 +859,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
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
@@ -871,12 +879,14 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
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
@@ -947,17 +957,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
@@ -995,18 +994,26 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	struct bap_bcast_pa_req *req = user_data;
 	struct bap_setup *setup = req->data.setup;
 	int fd;
+	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
+	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
+	struct bap_data *bap_data = btd_service_get_user_data(btd_service);
 
 	DBG("BIG Sync completed");
 
-	queue_remove(setup->ep->data->adapter->bcast_pa_requests, req);
+	g_io_channel_unref(setup->io);
+	g_io_channel_shutdown(setup->io, TRUE, NULL);
+	setup->io = NULL;
 
 	/* This device is no longer needed */
-	btd_service_connecting_complete(setup->ep->data->service, 0);
+	btd_service_connecting_complete(bap_data->service, 0);
 
 	fd = g_io_channel_unix_get_fd(io);
 
+	queue_remove(bap_data->adapter->bcast_pa_requests, req);
+	free(req);
+
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
-		bt_bap_stream_enable(setup->stream, true, NULL, NULL, NULL);
+		bt_bap_stream_start(setup->stream, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -1019,8 +1026,54 @@ static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
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
@@ -1099,6 +1152,10 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 		for (; num_bis; num_bis--) {
 			uint8_t bis_index;
 			struct iovec *l3_caps;
+			struct iovec *merged_caps;
+			struct bt_bap_pac *matched_lpac;
+			char *path;
+			int err;
 
 			if (!util_iov_pull_u8(&iov, &bis_index)) {
 				ret = false;
@@ -1106,6 +1163,11 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 			}
 
 			util_debug(func, NULL, "BIS #%d", bis_index);
+			err = asprintf(&path, "%s/bis%d",
+					device_get_path(bap_data->device),
+					bis_index);
+			if (err < 0)
+				continue;
 
 			/* Read Codec Specific Configuration */
 			l3_caps = new0(struct iovec, 1);
@@ -1128,9 +1190,16 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
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
 
 group_fail:
@@ -1175,12 +1244,16 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
-	queue_remove(data->adapter->bcast_pa_requests, req);
-	free(req);
+
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
-	parse_base(data->bap, &base, bap_debug);
+	parse_base(data, &base, &qos, bap_debug);
+
+	service_set_connecting(req->data.service);
+
+	queue_remove(data->adapter->bcast_pa_requests, req);
+	free(req);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1583,6 +1656,7 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 					struct bt_bap_stream *stream)
 {
 	struct bap_ep *ep = NULL;
+	struct queue *queue = NULL;
 
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
@@ -1597,9 +1671,11 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
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
@@ -2201,7 +2277,7 @@ static void setup_create_bcast_io(struct bap_data *data,
 	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 
-	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
+	if (bt_bap_stream_get_dir(stream) == BT_BAP_BCAST_SINK)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
 			defer);
 	else
@@ -2413,7 +2489,7 @@ static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
 	return stream_cnt;
 }
 
-static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
+static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
@@ -2442,66 +2518,96 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (!setup || setup->id)
 			break;
-		if (bt_bap_stream_io_dir(stream) ==
-				BT_BAP_BCAST_SOURCE)
-			/* If the stream is attached to a
-			 * broadcast sink endpoint.
-			 */
-			setup_create_io(data, setup, stream, defer);
-		else {
-			/* If the stream attached to a broadcast
-			 * source endpoint generate the base.
-			 */
-			if (setup->base == NULL) {
-				setup->base = bt_bap_stream_get_base(
-						setup->stream);
-				/* Set the generated BASE on all setups
-				 * from the same BIG.
-				 */
-				queue_foreach(setup->ep->setups,
-					iterate_setup_update_base, setup);
-			}
-			/* The kernel has 2 requirements when handling
-			 * multiple BIS connections for the same BIG:
-			 * 1 - setup_create_io for all but the last BIS
-			 * must be with defer true so we can inform the
-			 * kernel when to start the BIG.
-			 * 2 - The order in which the setup_create_io
-			 * are called must be in the order of BIS
-			 * indexes in BASE from first to last.
-			 * To address this requirement we will call
-			 * setup_create_io on all BISes only when all
-			 * transport acquire have been received and will
-			 * send it in the order of the BIS index
-			 * from BASE.
+		/* If the stream attached to a broadcast
+		 * source endpoint generate the base.
+		 */
+		if (setup->base == NULL) {
+			setup->base = bt_bap_stream_get_base(
+					setup->stream);
+			/* Set the generated BASE on all setups
+			 * from the same BIG.
 			 */
-			nb_bises = get_streams_nb_by_state(setup);
-
-			if (nb_bises == 1) {
-				setup_create_io(data, setup,
-				stream, defer);
-				if (!setup->io) {
-					error("Unable to create io");
-					if (old_state !=
-						BT_BAP_STREAM_STATE_RELEASING)
-						bt_bap_stream_release(stream,
-								NULL, NULL);
-				}
-				break;
-			} else if (nb_bises == 0)
-				break;
+			queue_foreach(setup->ep->setups,
+				iterate_setup_update_base, setup);
+		}
+		/* The kernel has 2 requirements when handling
+		 * multiple BIS connections for the same BIG:
+		 * 1 - setup_create_io for all but the last BIS
+		 * must be with defer true so we can inform the
+		 * kernel when to start the BIG.
+		 * 2 - The order in which the setup_create_io
+		 * are called must be in the order of BIS
+		 * indexes in BASE from first to last.
+		 * To address this requirement we will call
+		 * setup_create_io on all BISes only when all
+		 * transport acquire have been received and will
+		 * send it in the order of the BIS index
+		 * from BASE.
+		 */
+		nb_bises = get_streams_nb_by_state(setup);
 
-			if (!create_io_bises(setup, nb_bises, data)) {
+		if (nb_bises == 1) {
+			setup_create_io(data, setup,
+			stream, defer);
+			if (!setup->io) {
+				error("Unable to create io");
 				if (old_state !=
 					BT_BAP_STREAM_STATE_RELEASING)
 					bt_bap_stream_release(stream,
-						NULL, NULL);
+							NULL, NULL);
 			}
+			break;
+		} else if (nb_bises == 0)
+			break;
+
+		if (!create_io_bises(setup, nb_bises, data)) {
+			if (old_state !=
+				BT_BAP_STREAM_STATE_RELEASING)
+				bt_bap_stream_release(stream,
+					NULL, NULL);
 		}
 		break;
 	}
 }
 
+static void bap_state_bcast_sink(struct bt_bap_stream *stream,
+				uint8_t old_state, uint8_t new_state,
+				void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+	bool defer = false;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	if (new_state == old_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
+		return;
+
+	setup = bap_find_setup_by_stream(data, stream);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Release stream if idle */
+		if (setup)
+			setup_free(setup);
+		else
+			queue_remove(data->streams, stream);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (!setup)
+			break;
+		if (old_state ==
+				BT_BAP_STREAM_STATE_CONFIG)
+			setup_create_io(data, setup, stream, defer);
+		if (old_state ==
+				BT_BAP_STREAM_STATE_STREAMING)
+			setup_io_close(setup, NULL);
+		break;
+	}
+}
+
 static void pac_added(struct bt_bap_pac *pac, void *user_data)
 {
 	struct btd_service *service = user_data;
@@ -2848,28 +2954,51 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	GError *err = NULL;
 	struct bap_bcast_pa_req *req = user_data;
 	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
+	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
+	struct bap_data *data = btd_service_get_user_data(btd_service);
 	struct sockaddr_iso_bc iso_bc_addr;
 	struct bt_iso_qos qos;
+	char *path;
+	int bis_index = 1;
+	int s_err;
+	const char *strbis = NULL;
 
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
+
+	strbis = strstr(path, "/bis");
+	if (strbis == NULL) {
+		DBG("bis index cannot be found");
+		return;
+	}
+
+	s_err = sscanf(strbis, "/bis%d", &bis_index);
+	if (s_err == -1) {
+		DBG("sscanf error");
+		return;
+	}
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
@@ -2914,7 +3043,9 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
 	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
+	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
+	struct bap_data *bap_data = btd_service_get_user_data(btd_service);
 
 	req->in_progress = TRUE;
 
@@ -2922,11 +3053,11 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 	setup->io = bt_io_listen(NULL, iso_do_big_sync, req,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(data->adapter->adapter),
+			btd_adapter_get_address(bap_data->adapter->adapter),
 			BT_IO_OPT_DEST_BDADDR,
-			device_get_address(data->device),
+			device_get_address(bap_data->device),
 			BT_IO_OPT_DEST_TYPE,
-			btd_device_get_bdaddr_type(data->device),
+			btd_device_get_bdaddr_type(bap_data->device),
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, &bap_sink_pa_qos,
 			BT_IO_OPT_INVALID);
@@ -2967,6 +3098,7 @@ static int bap_bcast_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
+	data->bcast_snks = queue_new();
 
 	if (!bt_bap_attach(data->bap, NULL)) {
 		error("BAP unable to attach");
@@ -2977,7 +3109,7 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_sink,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 				pac_removed_broadcast, data, NULL);
@@ -3160,7 +3292,7 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_src,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
-- 
2.40.1

