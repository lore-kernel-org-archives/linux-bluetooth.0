Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250312F5BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686769; cv=fail; b=mVWzRfgwYVO/9ljrtqcoaEEWspKIIh6RtpLk3+mZg6ts3KxmmpYUdQXFJNtikLG6VR5AZXoNOTz0zkJyQ+dteHGNmtXcpL9bX4PxIJLfBr5YA+VtRIwiXz+XDoi7d0505uv0uJVVsMkLwUVV1cQBWJl99bveJ+Po5vHyyOkdfN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686769; c=relaxed/simple;
	bh=M6wzt/Hz+FpBuA11ceb9Fz4Vfk0ZmD72d9XvJEDrpC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRsLkPSmlWRNCj9R2CNjVZcB2cjinbn5PYztbZz5AWuoI3msyOy19SDNwgZxZWJYYh1Y53cfGwnRC4xSKOTcHd3NmEb3lGvSDZqCzwhmRgjtcLW+2yZIEg493am9Yjz0Afbr1am3LLdKN6eb+24Bs94vsHryLBwv2zYrHI8erSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sGTEnngu; arc=fail smtp.client-ip=40.107.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sGTEnngu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsESrQyM+425A1zrHoM+yEgYXO1eC72TUrERNZpgvdh711EvFxHnptUYT4Bww4X+b6AvycVaV7zwG7e3gHZhxGDkN3K/4KIg0Q/D0oxz4f4EwmdYe5Hge8V2oGPEeMDFf/4lhIIPlZVjV9UX7iRCUsTQXlZ7gKbwYMrcGQ8/4HZ3QnwN9AaCHMcn8lRe6c669ZZD53W1dquhbnZu48aJ1et+yflRWyGOm6v9mtZI2271aLtArmnoeDK1xYSJLzM2z5f852vJgjYonK3q+LYcnpTZLSGPtBArv67LevAGz//HTV2I8etRoPb/av6IH4VzXw4Wc94KemJ/4w8Yp1yEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCUDUcDKx8IyeCse8TvkT0zz5DZ72+1qTG9bNV0LmWs=;
 b=Yypk0DgOUfLT8/IXFgNSOVLpGdluW2iew5QnwLNTIdernitAUcAwQ4cZjy99fr/vkEyFNSJpqWvUl99FBY8Ue/S71bZNoTS8AheC+GpydCAI2A9lRNYbFkvK6iQOhQuX2saPbmZroC3wAfBRX6TF35vgc8XWcrZeypAXW6COV3sLreo5NK3zYrlUxroM5RRW9K2Q2JE0PV5FGfkQs2yLbtBSUtTRfhfaOnXFvvNqEENfWOk7WiUtBgl2Er2v/BVcIEUXgCLJNVOGIQw0fJSPXBAJCAsRVVbTMTVh4PQF8AdBKymqqb+TDp/JPvVG3oAjUMxichSmyqE6+dv20SU4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCUDUcDKx8IyeCse8TvkT0zz5DZ72+1qTG9bNV0LmWs=;
 b=sGTEnnguBkVmAl9d0lBmedGpk+UdGeZz5sqEVwMNS4oueq0KVlB0lKjcTNbDISQJlv1vgTEhveCQ8u5SyP71ybeQ7LLBcZnyRkr4vUiVX6ePJ4n8DxTFT7CTdA67OFlslZzZkVD9Gxj5EDDpEFcVQWGGAQAvAKPtidoKoPCqvq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8618.eurprd04.prod.outlook.com (2603:10a6:20b:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:39:22 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 11:39:22 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v4 2/2] bap: Create transports for matching BISes
Date: Tue, 14 May 2024 14:39:14 +0300
Message-Id: <20240514113914.21048-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514113914.21048-1-andrei.istodorescu@nxp.com>
References: <20240514113914.21048-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::37) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 526dae11-6c74-4909-7929-08dc740a7fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FXePsmLIuQervCesNKJ+5UPrbW4Rj/YlPF8zxI4OCxqOj+JQpKpzIIbo9zp8?=
 =?us-ascii?Q?APjbvNXWGz9YHYIjc2GSZ46pyb2EdVwvk++SJ6HsO6fvNvZqnU9NnmYCzQyY?=
 =?us-ascii?Q?JvHeJQMECJzm2dh0IWaC4ha6AgmxnOBSM+f7oXe7qYXRs4i4KPaIitYDXpjV?=
 =?us-ascii?Q?E2VPpPs58sq3W1SAVcyJjtTAwxMk+jdtpEGzLoWmj2fKXc39dZK437y0C+kr?=
 =?us-ascii?Q?ArE1zQ+8Aw/yLWGH03AnMB4MAPYga1b0bfuQXn+i49Z1DvTf/a9f9p+Zo1/d?=
 =?us-ascii?Q?0ey7duADkz2QqnxNSblmu8SbKe/7qNzm72jJSsI/ObKHRRrgrCiHxLDO0rn+?=
 =?us-ascii?Q?SAjHDm++MY/qDv6Bues7naYM6les88mSatT9Dwd+lYm2PqLctxnmOrQartwT?=
 =?us-ascii?Q?IAsK0vtfF10h7aBxFXAmbxclnL/SZcG3zRXTb+JYjD4mV+yqpUfciCBeVE4r?=
 =?us-ascii?Q?O9aw77fYT50WmLpAIxWBdltuffw9CNle3BMGlBEMpOuXFz/1B4rBoLuDbq88?=
 =?us-ascii?Q?cpHYEad78ewiIlRb8EehfrHft74Fe117kzu65XMjPEbz8FuW+r2Mt5wbID5/?=
 =?us-ascii?Q?RzTtbCgZtBzfbIiEPRZRcoaIbiua5fJqH6Qf/2PIGN3LvmZwDSLv6v2Mt5cb?=
 =?us-ascii?Q?9ozj/oHWOZ/bbSTMwv6+AhUPT5uBqTGc4cwT1wmJrUJdpavSb4UefzEvyla8?=
 =?us-ascii?Q?Oj28unyYPuT6FvvLc6/PKrbbfvYbzlRYT1lCUoC8cLQcN5MN1F5l2KyxLKGI?=
 =?us-ascii?Q?UEL2Uob1DO08aTKj4zAAP/oN2r5et8bMHnEQEG5aQEonaxdL8C8anA0g+POG?=
 =?us-ascii?Q?YqEt0NSkajZ5RJju8wESAWGR26f74gl1/qNnnRb2p2s8ZgFGt9oZPazBtr3R?=
 =?us-ascii?Q?ljCy6ct1zj2APfBCYa9ojHfSd/b0f+ZmHcdvF7sQl7F2fGYi07Le3NyTomOz?=
 =?us-ascii?Q?mP9uSKwi9pixOso3K+2mlon+a2Ywdt3dD0OmHvIl8ag8FGbo0GtcRQMdFyu7?=
 =?us-ascii?Q?ctX5aJgouClzgVCaFvaMTjVsAjOXzkGvGMPmuVZW13C/wk/5inj1Tj/Ve7ix?=
 =?us-ascii?Q?20PZXkICI1zokM3RmXyYj/oFzfvxc/ELPJiBQ1VgOAxksWEVZ+pJMggRA3lk?=
 =?us-ascii?Q?+XjVP1XgcZycWGHcHGBBLN/KH0AsKRv9xGz6n14r2SxTqBxEfBPgAjpiFtta?=
 =?us-ascii?Q?OuRh2YH7iLgKHjMCciRb5SsQgyoYmKvYfKmiZVtR+1t3Ju7dYyRa2GX8wB5d?=
 =?us-ascii?Q?YsZpLnX6qrrMJ78K7rIIv3n/CchRV4dynD8EWwAgbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9Tn+YFutiIZclDJj/LxFXoBnlE+teBp+CUJ12e9mW/VFD17BYKFqf14GXo1?=
 =?us-ascii?Q?LEvs9QHxQTV85SR5VywJ0U/XrOVd3p0IycCfynqZoHlxwFzckYcw6Os+bpcK?=
 =?us-ascii?Q?pz4lWXC50DD9xnfAN0Fl2We+9Xtx9lR+ywtZHGNGRP0IER3aGi+dYIPHCYRg?=
 =?us-ascii?Q?LOPJDo6QLUMvtTei5y+V/HNkkIsXSzqc9Ips8yHdQ8pXlKMxpk1n/AH6/EuK?=
 =?us-ascii?Q?W0ySts8ok7LQsXhVumF60/r+4/b7TfcH6PUqQkf9zbyVgtx32uQGd4t9tTI1?=
 =?us-ascii?Q?FJUwGOfIJunNczrF+wzptHyJ82v7cqGfvUvA9z8IbBE/qRGWjgPx8ScSZJTF?=
 =?us-ascii?Q?dkusadhdRQDed8hfO/7LAJee7eUvoHkjuwcDQXO67FVh+6unP/1YMgccVLZD?=
 =?us-ascii?Q?K+VGTJtAgLMpLcZlr229POEMcDfJgmIMFKz0Q+5M4hyVzcEVL/Y1CFtqAK3s?=
 =?us-ascii?Q?OsEf8q77ZNYEJfaPfuRNOsTc5BrXiKJt4TibtZ61Nej1lLkaxwqrQ4CFvO7/?=
 =?us-ascii?Q?Dd8bIhhykgQmqY65p4FpZ+Szu3Iw0UeRi14E0qdlJZdhCr7gumRakTHiB4af?=
 =?us-ascii?Q?HS3v1OVqfhzsvMa7uZb7D2w328O0vZNJeWqtohGWP4PqkAQeem1fJbVjt4oo?=
 =?us-ascii?Q?+yG7RJmDyJGaNDvT0FcszE+7m+XRvmNTFdoBoNMRLpkK1XfGS/T0Q0DEJjIn?=
 =?us-ascii?Q?rc4qJ8SQSClLDPV77gHuIi/JQORjZignVbx8hFVrSZc5UV8S0pwHVCFJS4gK?=
 =?us-ascii?Q?1sAZgcFwVsGTBrroOUXtnIjvlbWdTankTpjss/JbeukunFm/P+eye2eBQ1CZ?=
 =?us-ascii?Q?x3c2krqQIIjTGc6MvzYaiv2cIQZoYCG0O2UpI6Uba5mqwBAL5ECacPxOjFlN?=
 =?us-ascii?Q?ej0F3yO9hnoemc5m338woW2cTYsGHYqiwLQJu2iGE5bktKavceYPriY6eX9E?=
 =?us-ascii?Q?OiBxgdea+5RThCgRBxrw1SitfXuAWxBxkcg0TVTdfcvA7GGA6GxcwrE95FJn?=
 =?us-ascii?Q?geBKw9jITz6WzOgA27PEUbPDLT2MnLjcIQm+C1Ufv/h7e1MzOkh4wAiL6gNE?=
 =?us-ascii?Q?ctGcQM3PIY6MtdAaB0YRg0K8Y3EKP7YKSVoJGqN0V6ZhaiuBnYE+2G54pjJ5?=
 =?us-ascii?Q?35aRSj6JODPTGUf0LxQF1gRnLcNDe8Gf9h6CU8LX13uxoD3VR/WyQ7XWWjmj?=
 =?us-ascii?Q?soLhB4N6zj8PgGLlziOHwMM1lCgdDejAGbt9ZqhSrpPwNd/AB+tgIa/t7JQX?=
 =?us-ascii?Q?hx6HFDNuS9feHAEm/CR8OFMIvZ5nVgzAQXUra+v8X+97l6OM39leqXJv11Jb?=
 =?us-ascii?Q?DqWNgvQtIQcCR1T2UhK9AEKFgwUb1SHYOsN+CAFLfhE8hpMW3DW4Suwc7Mqw?=
 =?us-ascii?Q?TL++e8VdmTGllqymblx5pumf11jaTidH+eTlmmzKPCnrzdvBmLOeaHgG7hJA?=
 =?us-ascii?Q?2e8lxMbO79YPyaRva/1NJ6xS6kjQu2CvkDvr9TMbh9tMQzVWzWObT4yaqA19?=
 =?us-ascii?Q?Rj9LXlBf13S75fh8QmqEX4j8znIsFzeuuY4Dqpym+pMnPulL0oqcqfNIuj/Z?=
 =?us-ascii?Q?JxjLqx259rzJ+WudnBhVsOLr7M0LYs4ZSU2/0c7hzVHR0WdcNfldp7S7TIa2?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526dae11-6c74-4909-7929-08dc740a7fec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:39:22.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQkbRviMdlS9kUpgGY4QdgC+jdgF7RFQbm4pyrQv98OtsrWl/VdPhQkWZkqWLyVPWDK6kWy438xWpg6FXLmM99MynX45/f1tbTaiiq3Zx/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8618

Rename bt_bap_add_bis to bt_bap_check_bis. This function is now an
utilitary for checking if the information from a BIS is matching the
capabilities in bt_bap. This utilitary is used when parsing the BASE
data so that we can decide if we create a new setup/stream/transport for
it, or advance to the next BIS.
When checking in local PACS for a BIS match, return also the local PAC,
along with the status of the operation. This information is required
later when we create the stream.

Use the BIS index received in the BASE to synchronize to the BIG.
Allow bt_bap_endpoint to be NULL.
Remove the Broadcast Sink code from set_configuration.
Update BASE parsing so that it creates streams and transports, without a
remote PAC and endpoint.
Update bap_find_setup_by_stream to find the setup in case the stream does
not contain an endpoint.
---
 profiles/audio/bap.c | 323 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 227 ++++++++++++++++--------------
 src/shared/bap.h     |   6 +-
 3 files changed, 357 insertions(+), 199 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f09f2ea44109..eb321f33386a 100644
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
@@ -131,7 +132,10 @@ struct bap_bcast_pa_req {
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
 
@@ -202,6 +206,8 @@ static void ep_unregister(void *data)
 						MEDIA_ENDPOINT_INTERFACE);
 }
 
+static void setup_free(void *data);
+
 static void bap_data_free(struct bap_data *data)
 {
 	if (data->listen_io) {
@@ -218,6 +224,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->streams, NULL);
+	queue_destroy(data->bcast_snks, setup_free);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -855,7 +862,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
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
@@ -871,12 +882,14 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
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
@@ -947,17 +960,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
@@ -993,20 +995,27 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
+	struct bap_setup *setup = req->data.accept_data.setup;
 	int fd;
 
 	DBG("BIG Sync completed");
 
-	queue_remove(setup->ep->data->adapter->bcast_pa_requests, req);
+	g_io_channel_unref(setup->io);
+	g_io_channel_shutdown(setup->io, TRUE, NULL);
+	setup->io = NULL;
 
 	/* This device is no longer needed */
-	btd_service_connecting_complete(setup->ep->data->service, 0);
+	btd_service_connecting_complete(req->data.accept_data.bap_data->service,
+			0);
 
 	fd = g_io_channel_unix_get_fd(io);
 
+	queue_remove(req->data.accept_data.bap_data->adapter->bcast_pa_requests,
+				req);
+	free(req);
+
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
-		bt_bap_stream_enable(setup->stream, true, NULL, NULL, NULL);
+		bt_bap_stream_start(setup->stream, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -1019,8 +1028,54 @@ static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
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
@@ -1099,6 +1154,10 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 		for (; num_bis; num_bis--) {
 			uint8_t bis_index;
 			struct iovec *l3_caps;
+			struct iovec *merged_caps;
+			struct bt_bap_pac *matched_lpac;
+			char *path;
+			int err;
 
 			if (!util_iov_pull_u8(&iov, &bis_index)) {
 				ret = false;
@@ -1106,6 +1165,11 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 			}
 
 			util_debug(func, NULL, "BIS #%d", bis_index);
+			err = asprintf(&path, "%s/bis%d",
+					device_get_path(bap_data->device),
+					bis_index);
+			if (err < 0)
+				continue;
 
 			/* Read Codec Specific Configuration */
 			l3_caps = new0(struct iovec, 1);
@@ -1128,9 +1192,16 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
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
@@ -1175,12 +1246,16 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
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
@@ -1583,6 +1658,7 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 					struct bt_bap_stream *stream)
 {
 	struct bap_ep *ep = NULL;
+	struct queue *queue = NULL;
 
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
@@ -1597,9 +1673,11 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
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
@@ -2141,7 +2219,8 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	 */
 	req->type = BAP_PA_BIG_SYNC_REQ;
 	req->in_progress = FALSE;
-	req->data.setup = setup;
+	req->data.accept_data.setup = setup;
+	req->data.accept_data.bap_data = data;
 	queue_push_tail(adapter->bcast_pa_requests, req);
 }
 
@@ -2201,7 +2280,7 @@ static void setup_create_bcast_io(struct bap_data *data,
 	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 
-	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
+	if (bt_bap_stream_get_dir(stream) == BT_BAP_BCAST_SINK)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
 			defer);
 	else
@@ -2413,7 +2492,7 @@ static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
 	return stream_cnt;
 }
 
-static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
+static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
@@ -2442,66 +2521,96 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -2847,29 +2956,50 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
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
@@ -2913,8 +3043,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
-	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bap_setup *setup = req->data.accept_data.setup;
+	struct bap_data *data = req->data.accept_data.bap_data;
 
 	req->in_progress = TRUE;
 
@@ -2967,6 +3097,7 @@ static int bap_bcast_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
+	data->bcast_snks = queue_new();
 
 	if (!bt_bap_attach(data->bap, NULL)) {
 		error("BAP unable to attach");
@@ -2977,7 +3108,7 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_sink,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 				pac_removed_broadcast, data, NULL);
@@ -3160,7 +3291,7 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_src,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 919ecbb6a016..fe91cd67f491 100644
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
@@ -2019,6 +2053,17 @@ static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
+					bool disable_links,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	bap_stream_io_detach(stream);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+
+	return 1;
+}
+
 static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -2040,6 +2085,43 @@ static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_src_get_dir(struct bt_bap_stream *stream)
+{
+	return BT_BAP_BCAST_SINK;
+}
+
+static unsigned int bap_bcast_sink_get_dir(struct bt_bap_stream *stream)
+{
+	return BT_BAP_BCAST_SOURCE;
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
@@ -2049,11 +2131,12 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
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
@@ -2061,26 +2144,40 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
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
-			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_start, bap_bcast_sink_disable, NULL,
+			bap_bcast_metadata, bap_bcast_sink_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_metadata, bap_bcast_src_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 };
 
 static const struct bt_bap_stream_ops *
@@ -5380,11 +5477,7 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
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
@@ -5568,53 +5661,15 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
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
@@ -6398,9 +6453,11 @@ static void check_local_pac(void *data, void *user_data)
 
 		/* We have a match if all selected LTVs have a match */
 		if ((bis_compare_data.data32 &
-			CODEC_SPECIFIC_CONFIGURATION_MASK) ==
-			CODEC_SPECIFIC_CONFIGURATION_MASK)
+				CODEC_SPECIFIC_CONFIGURATION_MASK) ==
+				CODEC_SPECIFIC_CONFIGURATION_MASK) {
 			compare_data->found = true;
+			compare_data->data = data;
+		}
 	}
 }
 
@@ -6425,7 +6482,8 @@ static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
 		data->found = false;
 }
 
-static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
+static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
+	struct iovec *bis_data)
 {
 	struct bt_ltv_match compare_data = {};
 
@@ -6451,21 +6509,18 @@ static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
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
@@ -6481,43 +6536,15 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
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

