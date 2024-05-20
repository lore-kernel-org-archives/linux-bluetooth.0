Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38500137C27
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222488; cv=fail; b=t/CIUiUwOnEufHaSbUKLgLCob4c31HV/zdSAAeVWveELu/mSX9oSpc6jX0tPAkYpzyToWd9G1/KXZTlVW+U0/3CBcjPTE20SSCEYAyuG0YjqPu9XYG5itNPPjQegF93eVR/bl9iNo+vriPJ+zqlgjTgwxMvqbDgYZJ5fWXM/A4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222488; c=relaxed/simple;
	bh=6mQE9/31VEQIyEg7rm6AA8bVXbIS6S2Fb4z8alqFif4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1TksnHlScuyhqkcAMZGgfGVeEBD7EqIoT+A5Dk3RzuUcGEqUxuj/CPdYV2eddfOLQ8tZoqKnh2ibM0gmcb+tcxwOVy+Nn7h2A8y3ghWcrPUVItjJwpyNCD12ZjrQ/L9rXolRSTjciCrkxPUNxq8XfQ2Fl4DcOS33P6Bv3K7Hic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B4+25H/k; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4+25H/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwX34oXRwNIjzNVRCnDI85JMBFiuJSmo3cB45gajZJqCxHjbmhk8pCpA5Qum5uQTFvQ/JMqTJorJSimrUTKMjCAc8HaZjEVZlxDKQlQhuiOL7NNwW3dnCHrjJ1h19qWWAz1RrDGwc71/HZg2SAmeC83f4eSms/MtI/ndooOpff3lbJaqxU1u88n6Qkwrnzp6u9zPg7QQlc39xMDzesGjDbLykKREf3xKf7iPJhSNgnVtR1PT3aFElXTr1exsVsYMd8IpqOExWEP/kT3hbFAKMY76AviqZW/QzSqMeeYfb/zXH6EwcGs2sEWMCE8UQHH4oy+KeG7eCK2OTo9Eh8R4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvHhdE7VmYzYt0v3H6sQPjnmbO9c4yI6kCXKX5k3/IQ=;
 b=kA+huDxzDdETXdoR9dlM5qESxPSOOgOPyE7r59DPGUigaCvCKHjSrZD67xwmI+onRI4XHF02FuzP1jf2H88YBq8Z/aAyQAwv9W3gou/On4X3jU7zJfuvfsf/MKa2e6ZxSetgM8z02ivknEGQoY+G60W2wx/2+Z4as0NT/+xcqzKwLtJq9i/bXrCgCIhBzD9WhyC/JNbBOX8D6wJVIXkcwseBW3lvZ2J0LKMBki2dcrfWgetmSKm8THo/EekH8YJB6EbPmPS1ofsNYlIWtJuOLH78L4itTOurOMc9llsU9l+FZrKB+3LTk/7hbAQBPlQIxuf78wSo8SATXpU3o7RsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvHhdE7VmYzYt0v3H6sQPjnmbO9c4yI6kCXKX5k3/IQ=;
 b=B4+25H/kfYfN60QraZs3NWXO/Qa80tH34CWYOs0mqP/VdI3ZSULqGh0AfNKcX5jjNerlntvx6qWpZ6iol9fusE8hf3sobP6O0lkMhTRrcAuv5KaViCdd99FBdLKn27CSOS53ROdgNAJwzy3lweS9MBasKa1hSAd8TK6osx4hDpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:28:04 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::81ed:c7d0:c2f6:8ce4]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::81ed:c7d0:c2f6:8ce4%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:28:04 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/2] shared/bap: Update BAP Broadcast Source state machine
Date: Mon, 20 May 2024 19:27:56 +0300
Message-Id: <20240520162757.78187-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520162757.78187-1-silviu.barbulescu@nxp.com>
References: <20240520162757.78187-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::6) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a59d55-e8fd-461c-f469-08dc78e9d2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNEbtd35In6O5XC5cDf66XBul2PtiDh04owF7ka4NfZmpGqucnAWRsg3Er6V?=
 =?us-ascii?Q?2Nc3jKqH2tLIRcdZxoJTpMYxmha8BTXhEsuueGvXYEOEwyX3G2MxIhHhG2Iu?=
 =?us-ascii?Q?YnECpMESVRnv0MI8T6GmsGTrXrX89XGKdItLl923Pxs5E8vowwDaveNGFzLG?=
 =?us-ascii?Q?wUb4QreSiix3a8Lz/F0pU/h6ghdWOlBfs7Wf/tDpDv23pnuSjv0WpHv6aGKx?=
 =?us-ascii?Q?Kc3wu4I4FVJN37Nlyovvm3lcHK2j0rnAS+N3yf6agbFdjWJWpoLcr6SrobqM?=
 =?us-ascii?Q?Kr29L2UiVqz8DZjvnA0Pt+nih2DByLdyOF8QrK5Z+gULq8h3RKQ4IPBTWJ75?=
 =?us-ascii?Q?mx7+54nlafUfF2+NisF5Ytz761Zn3onJbWaPKCQsx6iX3MdXjZ0PRiSzUWzc?=
 =?us-ascii?Q?9isW94AISgWfQq4/B4Ou7SE9+RhHbkRrhv0Sd8+lIVQIF+E9/2Wqi1J9/qIr?=
 =?us-ascii?Q?p2XV6nBzv0JnTS9PahV1gYjYGKV2CVVmA9NFpUJJvLiWyq8+VPUouYK0q4ub?=
 =?us-ascii?Q?HkS6OIusbHGCSOHDuCRzbGspobubzzQgN9xSZbOdlpsmpyKxlKeYgBqGSV5y?=
 =?us-ascii?Q?8++qs8qZH7pmJpvkJe/tyBnpQ+hVi8o5tf7v7dIZl248w9DKgLc1JLAkCSFJ?=
 =?us-ascii?Q?im9ep4cmIcvI/azaYSlzsetyIjin32LwTb6sNMYEz+YlQQSUoeyiA9632Fnn?=
 =?us-ascii?Q?AY8zcoJ309yDDaCUh13W2OMuq1guqRmL6OXGrkcGttlXOhrX1IDmFF1UMEX4?=
 =?us-ascii?Q?0EPWyBcXpqTBTRPnUQu53GAn7BhYa541oCHRZTaLOZdhxSqqoIr41RLUerkn?=
 =?us-ascii?Q?2t1KlLfy9W8lPbqhBNt8yVbiFOQceyMBcaY7ZUFGeRRRy/VXbZ7XQaDGqYFP?=
 =?us-ascii?Q?TO0A5OL6j3kZiMEY3tGsJ9no4Ql/ok7ez7Qd/nHIuGxrSVUysNRTWVejdo2T?=
 =?us-ascii?Q?8W9zgtecNYbEACH3+ztgn5zgRTAd4u/iPlNn+zAWeFRxuwLpGUEuPOKgfKH3?=
 =?us-ascii?Q?tYyfERw2HFaicEruE4EFldkCLLSp3rcyxg9nky51G+/dx/rd5zhahj+oiZPA?=
 =?us-ascii?Q?Fxi8H06suSvZh9QYsoqEpJao+/QEdnfiJA6mcwBh68nsRemjEtH61eveFFiB?=
 =?us-ascii?Q?/HNORLHdI49HNG8oZXEFMGmrFwz8ykkBQ/mgSlgOsREWJscZXR/rr+mtHAmI?=
 =?us-ascii?Q?Oi1wZvILBpkzJWDy7A6fuKtHJ+jkrYZsCz9WOw3th+HKPz0/f0y0+iEGinXw?=
 =?us-ascii?Q?8TP3ipPyZKcbH+ZnB3+1OBw/z0Ov+lhqHdUcfRT9Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aY1C20WyPHWBgzs/PsipVxDimhU47heVIJtItLmTghNuO5WLbgmY/KJeRewT?=
 =?us-ascii?Q?oVR1ZCWxB7sP8Uhf88Bj1RsJc4nki2SV4klY7YLUETre1Sv6reRmys3T0Ge9?=
 =?us-ascii?Q?9KSevkEGJJGR5W+cVcgP7HfJsXR9sg7cMomfddTprwmfvoIrj2ighhL+Cq99?=
 =?us-ascii?Q?a2wZnu9gR7n4JkWvbel4QHpgZdYdW4pDOuOOWBmJTajeL73p04iVREIODWgz?=
 =?us-ascii?Q?dik15aXYOaPnE3oKkv0n25xK2+COpnOvgMZgxic1A9v3cT1JzQM0NXJYUBYV?=
 =?us-ascii?Q?fPI+XrTWilR/bUqkfvuo9w6h2F2SCAF453tl/k4TmARg7lRKyLIwx5MGSJRr?=
 =?us-ascii?Q?ikRJDWzeHE+T+cQrnc1l+qwrNPEGzb/d0gBlmsTTXdeVHApgP9YoOrdNrJ84?=
 =?us-ascii?Q?XAGc6oks98oD5nTLsmoLUoRl9smiLmxPde+K3J3OjHlseUjH0KQSK/C+Z48l?=
 =?us-ascii?Q?HPF6oUSOjQUFJ4B/+2RCk4vVe5W0dHo/XL7hALAoDA6kE7AdvkJ3LzWWCvio?=
 =?us-ascii?Q?twTPGTv1yCcq1RlYFYc9U5vDBNajYH9QPoxThMlWmX5NKmksE7dbKkrCKFr+?=
 =?us-ascii?Q?HR8hcLXsChwUGJTkY+w8iEe1VJdG8kyahIywPu6c3D8YwF8sjLpvEIdQdRJv?=
 =?us-ascii?Q?EYT06nB3N8LaNRuZIo/DbD4JszUYr2m0h9T/KXIgC4Em0MghSM4pNf4b/Bas?=
 =?us-ascii?Q?I8K+KN2Z1E6evL0KMJUEpr6/BGR/iYoqmAXKqjSTASAnvGnLr08fwsnTaZ14?=
 =?us-ascii?Q?UcNxUup4HkKe+g5CwZX7b/wTpgf1By/1QYvhEKJysqZLGe+cVOGwyG2AjItL?=
 =?us-ascii?Q?yr3LBedx8jMNokRLAWVDKGBfjWhOFw4vhrhmP0lXDFgmAr6KuYjjTOgjZK6X?=
 =?us-ascii?Q?zgG2WxEJiEATUvhfEpp2Bvlh8UPRJoHXwQrjE9WuCtYkxBj1HNSHkUppKaAw?=
 =?us-ascii?Q?u0G1HrlRBsBLjWK2yobKWSN8y8a6pN2TaDDD8aT0KMwHJJ1nrg3irPKXCkYy?=
 =?us-ascii?Q?+7WLUuk2vDpgmrhtJxRg+Wajpg4O0OL+JqsfBjsrNSbwzc/ChvNxDH9LuRqG?=
 =?us-ascii?Q?2o0TukY6G6lva1qjzRqXJtWuzT0cbXI/249xfpdEyk2Hj9O6wbP29jQ+s/Al?=
 =?us-ascii?Q?v5lmMui9YMVw67oK2g5L+/PfD/RpmfJEP1BVnQCuCXT2JjO67+sgIooV2xG3?=
 =?us-ascii?Q?tG7uITxVceAm6hqu7kn+o+B6igS0GiK4SpKpsYjgIz3GGkwKD4j4qywvybfy?=
 =?us-ascii?Q?JfeAWzoUwuZUgZixFWC7Nd2S84Yg9lDi028DiGBYlquP7URovv7+d2oJuotU?=
 =?us-ascii?Q?ZE3ipL0Jcyv9xWM04/bs1jNFkQwGOSn/k8LszymJPtDX/Lh3ylgXve/Evir/?=
 =?us-ascii?Q?Z2F1wPbH5KlPtjBZiFss+h4JGSTXEASjPskQLjlL90eX4/lVnNWzC/ErGHni?=
 =?us-ascii?Q?djn33weNoo3GPMtbQWs6I0CZcim0GUEOKO3O40m7SvEC8N6tNE2S0voEGZbC?=
 =?us-ascii?Q?KWzZPtLXgxJYh/dYnp8PId35xOoHti/zfIt42CfuFf+8VSoGxull5UWTvACi?=
 =?us-ascii?Q?bvJ/xDVScRNK4wxTLRPI49goZr2JGe2IpQHw1N0w89AEvJWHPpYLqYqF2scF?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a59d55-e8fd-461c-f469-08dc78e9d2f3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:28:04.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izzH3AeXGjKnMG+V2ovy37z/7eJJL6wt3prj+mlNGRyf4j3+tjqm+A6mQwJUToB1BPTGU0FOzE74RItnIEU1P174IRYht3RsD/gMzHvLxSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436

Update BAP Broadcast Source state machine states to use BAP define states
 for source Idle, Config, Streaming, and an intermediary state enabling.

Updated test-bap too.

---
 src/shared/bap.c | 39 ++++++++++++++++++++-------------------
 unit/test-bap.c  |  4 ++--
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6572ef1d1..639149520 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1361,14 +1361,6 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 	if (err)
 		return;
 
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
-			stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-		return;
-	}
-
 	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 }
 
@@ -1759,6 +1751,15 @@ static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static unsigned int bap_bcast_qos(struct bt_bap_stream *stream,
+					struct bt_bap_qos *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	stream->qos = *data;
+	return 1;
+}
+
 static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     struct bt_bap_qos *qos, struct iovec *data,
 				     bt_bap_stream_func_t func, void *user_data)
@@ -2071,7 +2072,7 @@ static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
 	return stream->state;
 }
 
-static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
+static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2081,22 +2082,21 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 	return 1;
 }
 
-static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
+static unsigned int bap_bcast_src_enable(struct bt_bap_stream *stream,
+					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
 }
 
-static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
-					bool disable_links,
+static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	bap_stream_io_detach(stream);
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
 
 	return 1;
 }
@@ -2106,7 +2106,8 @@ static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
+	bap_stream_io_detach(stream);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -2205,14 +2206,14 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_enable,
-			bap_bcast_start, bap_bcast_sink_disable, NULL,
+			bap_bcast_config, NULL, bap_bcast_sink_enable,
+			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
 			bap_bcast_release, bap_bcast_sink_detach),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_enable,
+			bap_bcast_config, bap_bcast_qos, bap_bcast_src_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_src_get_dir,
 			bap_bcast_get_location,
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 46ee0e4e5..10f9e348c 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -547,10 +547,10 @@ static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
 	struct test_data *data = user_data;
 
 	switch (new_state) {
-	case BT_BAP_STREAM_STATE_QOS:
+	case BT_BAP_STREAM_STATE_CONFIG:
 		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
 		break;
-	case BT_BAP_STREAM_STATE_CONFIG:
+	case BT_BAP_STREAM_STATE_ENABLING:
 		data->base = bt_bap_stream_get_base(stream);
 
 		g_assert(data->base);
-- 
2.40.1

