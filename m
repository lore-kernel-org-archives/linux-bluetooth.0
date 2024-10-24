Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9021CACD0
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767806; cv=fail; b=m1rvkloP9AeD22QPpcBMd7UNcH0G/ESg/Ua4IvhsXHJHlZ74EUCG6NKqNg6P6XlBSyRslzGqftsCaQA+66Hzia3dooPx3NbC62/x2iE8kry7YiOdrvgP0/ZKvhVhPCfajAjgwA912JD7LclJbEvjg8je/3DeIPZZbN2uSURFL2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767806; c=relaxed/simple;
	bh=aptpSCqH6pxjKOB/xIFyw1qsWYabgNFS7EDrumA7kxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzDHYP/wLqUxJ30c+xPzACqNgMNWMn0xk2sqjWEgTsMNNufKQ69nf5tRMn+GHY+xCi7ojwOatBi1+mo7yXdTfRl/F1uT7/FtMKbo1yXkxlT7ZdNvWr8usxxgZOC12CBEv+eL60YZqOVs//FAr7XevYZd3pl5L2QEZPHfvwxEUp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L+TleTwN; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+TleTwN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao4sX9npY2I0IcIPEalZbTWquj2S2kvBZYe+Ji63rjHW3RzR0enXSz5sh9H7gRpc5KbRKNItT2KpSBN/Evqwu8i4HoiH89M58aZrpIxKvSSyDVxRDFcV0FCAOjN3CkfPYxvHYsLDdx9lxmeXpF2hKPdkwYMsFUUoqioBy4bw2fL2LWOrZgq/KJP9poxpLplESBcY6StGComNeEDVfh6Csuz9gPZsLTg23MZGwKEo9ZH/pnUY5Frdtmclu4BfhJixf4s3nwU05r/fHDiPIjXfVyMYD1bXgWb0FTQnjirqyKrf2nhUEx9Tx0txdK4dDr8BvPA5wjy7sgePFhAL/Cl/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2aUKoPzRSyH7ntYn26/cxnlFeEcu2EtfFfDD2XBHlQ=;
 b=KPNKAivTLDkSv+ikrRWLA5hS9as0q9xbNNYDmgNvTWaCdou22sON1buUMYYtLPJ3/hgyTZhh3419nWBIxA9I5PZG0Kar8VUhcU05+pMWieoIe4rWwyBr512RmzxGW5d8rnlseCOIRW2kOqPRqTpH2Q6SauXBsSnDTO2AGlnCzOyu50bd5e5sOloUnXXICLKNI0f9qvi9AMDan2rY+eUFtv0euOF0CiswTZW9K7STT5w2xO/ELyE9v9qM3NsFYvSg7LzrWKMKK5mMMtYEco8RH3j55AEcZTPuoGvTppT8/a5lv0DniYRdzCYg9AydxznG4A9wVnw1eI31N4LfMopJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2aUKoPzRSyH7ntYn26/cxnlFeEcu2EtfFfDD2XBHlQ=;
 b=L+TleTwNjc3Y+n5Jlcf+swPWJlBFjftvE1LCPKSWksGYTXfci2w77A0L56skRVyuIoDuE3kXqiZ1w46dA7KOlDXyAFRi0tLhlGSdGKqd7yBUrjd0tStQDRcBT0/Ar19I3IIfUUfcT6AOAjmXGzWrXYpxcBeVpdP8vmDvbjvTWrsTMJqdsV7esbCXbHy6nCDPme48Wgpd2kNzdsRejt2qAbQsN66kxhNKxqQgAZFnxbTKhjOlzl06/HRAaRbVIAhiHQcXJ6aKO2/oMco+0WzpIqZxlzP273Jx5NMOX3tHpsNiljEakIsxhYXR5xaZ6CuiE8rM4UetL1WiR5a+8C2Peg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 14/14] transport: Unlink broadcast transport at release
Date: Thu, 24 Oct 2024 14:02:23 +0300
Message-ID: <20241024110223.77254-15-iulia.tanasescu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: eded5710-f6e9-4c01-403c-08dcf41b7573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZxvIBRXpQpKfh1upmof2iV9LcslQNNGjxCij57Bs/wtQ2+knF2W199+MQeOj?=
 =?us-ascii?Q?gzx7SYBsN8OwNvRQQf/x7a6JdR0jKBI8lqpFNDyF0ydwJhvxfCh81L25gL6c?=
 =?us-ascii?Q?xZkWmvCKE26JCPacXveGd6me7F36F9dX+RTnexFqFnp4UNRSotu1tZU15aQV?=
 =?us-ascii?Q?eQtgcJ7UWmEnwetp954/XJYzimt1khOPGYRLmcLG6+TWQEZ2WvvfnzBbiOqi?=
 =?us-ascii?Q?EiSunxTg1K+21xJZRdunLzv9LIix60KaBetv3261se7Q4Hr7zvdub6FrASUB?=
 =?us-ascii?Q?ERNQtww5RhGv+cp2l8roBhvTbiK3kUT48hcr2UrDKGrZEFSmhDHTRDdMcLAI?=
 =?us-ascii?Q?v/95AWsZ2EwAAPQjZjKRt8jxX99k/MaHdpMI6WVzSBvDXlHNIIVwbGLS5Eh0?=
 =?us-ascii?Q?mfbPc9Hpzh3YATc3x/2L7PezXOc8IT30iRKLU/auCKuWvmYcyD/uQpVjb1g4?=
 =?us-ascii?Q?31hoOB2KvbahyAL8FkDsviCxfbQ0d1Y4sXsfOnlYR3Hh3eTH9hzLJcekjsvI?=
 =?us-ascii?Q?S8qXn5CwdYUwKkolTVaGpDvB/movdZf2+dJB0yh3ays6IBFLLdvfyehn4rxP?=
 =?us-ascii?Q?8GlK3nRhJgsUGgYGEpLOWNZJTNF+RMQX2JCzZXIzIHqpTQzu/DGUyrLCBI+z?=
 =?us-ascii?Q?hyFm0bqyyjeit2gZ29Izv9frswwNX0YbPNY5UXBx7YlsfX6IAXDQnY2dgaKV?=
 =?us-ascii?Q?LTGBMZiNhvPp+z3MxZGXU/WWqIMfadeBeWHqnfgBSVB1lfhIDrYJmA+SpLsE?=
 =?us-ascii?Q?oTla9nRK9x92fuKyVjynFqqSdH7CWXteO9ZOyoHXXNEvy81xHqxt6n2UwuCU?=
 =?us-ascii?Q?Oav1AR8fVb4i+bodulcaG0VZQMEvHxCGxQFoJ+Aqb4bhye9Ir1Hxo3O/YxJ/?=
 =?us-ascii?Q?Rp8etJtGpXNZBV9ErQXPLva+13uU6/P7Eyiv0yI2dLUcf6kg2pRCF9VF6lGc?=
 =?us-ascii?Q?wSaW/lYTnxXUN1SAwD/cyV/H6MkVDfH6DM1atlcbkKWsEdtjYu2VqmMa4IHH?=
 =?us-ascii?Q?KP6tDGjIFStGIskPyHRHychGbxGKvc6IZ8904MSO7NQGQUaaZ1DamzE9YR5/?=
 =?us-ascii?Q?G2fMSNoKsDFVCbqBFIIjasXci0NCKghAQ5SPRzZpwK34CGr61Tf51n1atMQc?=
 =?us-ascii?Q?n5LVnqaxy/o9IEG6DANuOgLZGxaMSDJDhkuLmSa4oPiPPHl6rlHrcnJjWr+r?=
 =?us-ascii?Q?9xtiAq/KT2fhdffKGMrHu3Ji4WnGG3z7AKkubyOqQii26lSdAkaVeyFSDaiI?=
 =?us-ascii?Q?NWJ8u/6oFcCC7soFbOFW6FUnfROhTx0TSsh9MmLvBn4mAM2qfDUjsNcCrYlv?=
 =?us-ascii?Q?lEmkFS1LPxhC3uWZs+w+c3xUNXs2bbPVP07dQcVQgELY/QI8HETxb2YUuk+5?=
 =?us-ascii?Q?ta+SWqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iGdGIstCGK+F3H0dyApaVvI+QfpFXNyoLXY4prDpvQi2on0ECPljXc+qrE5V?=
 =?us-ascii?Q?ECwJF9JWvXC2wKqJ1UziZE3TznIH2b6xj2s/5ARkXGMqdUeS6MT1kuMMW8nC?=
 =?us-ascii?Q?KL5yrsCY6fGk/U5DbHAPNsqXjxrRyB3HiMlfFnXFSCVG0bsjsETWE2FIiKWg?=
 =?us-ascii?Q?PXQ0JE+ZIA/Z2vTrIH3bokSnm1PIlRqqjcQz4bZgUO7v7HJ3ea7fCfXY0ddM?=
 =?us-ascii?Q?6Rz76sdgTDX/22P94i5gYdZrQauXhbbt9WeMOSQpdtWbNwJ6CnjXTlcsK65v?=
 =?us-ascii?Q?DAjJmS2baDG1xoUDSb5MHPOsNReEYFKxR548efhZ+7sWyB8McOrWWUy61o9u?=
 =?us-ascii?Q?UTOzUzwYOlRBXwvdeYSJmwKrgPp7AO2tA2HkVIChaNbaVvYUinmNu5OawP6H?=
 =?us-ascii?Q?avT8LX0LJR51mf3BuRT0CMicrHS9Nzq6kdHCn5HCPwJBgJDR+JkzD9+pG8Eb?=
 =?us-ascii?Q?OdiVgKiQK/QDMtyU4ngaNdKVS1C3EcJeXTlqn1S4ezOIPCapqnn0k4kTRILc?=
 =?us-ascii?Q?w9IYo/QZO0VOl+Ga+LInpe1QkbyGKtYv3nvXPbcXHJUdRgdWNQwXC1wi0+kH?=
 =?us-ascii?Q?a1nMzs4ptja7JYmr7ofzJKBInvw6aTopvOJH7YO5YuW6keC0fclz6QaifdG/?=
 =?us-ascii?Q?It01y4KYTeU9eS5XMgSIVTfGHzpUfsSbU+RJdRv05HP6QikcE4dnAMaghGDy?=
 =?us-ascii?Q?zHKlqdewbgSqjeTZLAEGJbZOWqr+DhDqJytvDfpT0gO2twtVPngFgBu0O3KM?=
 =?us-ascii?Q?KtGwHPqPjFXOOEu+ftkas22jR6/p9yBPtxUceINQFGm5YtyIvp5j8e2G8dkG?=
 =?us-ascii?Q?74HN/1QwzHE7EVrHYsscP4Wm/1qCf8GuUVNyOEBx+PWCeNWAkT1Sun+uXB3W?=
 =?us-ascii?Q?oebUtL6IYWK0+rYwLuXjasrsvdbtWqtZZlAItZGqsAcR/qkbySiOwUv+U+G1?=
 =?us-ascii?Q?WntAJ4Bt0odAKNDkL0TueEzWHGHm3h5R4Db1qAk4LVGWvRvhahaNlbZgZLng?=
 =?us-ascii?Q?qD6CEwCcvlR6azoy8fs4W+B+S0uU9LbVWBzs7WR7IyjfA/UE9Exj2VWV+UBh?=
 =?us-ascii?Q?aBIYKKkkXxZ/TfjQOY2todprvWuOqsGzzzFvRUIbQp5fN05z0xDb9D9fdVbc?=
 =?us-ascii?Q?tF+4eGql6nYt6s9OhYz+PfN2leLOqR5FDK3u0QA+uJSjAcUn0Nm/zJXYU6Lr?=
 =?us-ascii?Q?LJTXWsrRIWdCr5Hh91d0JVdHvBrj8N/ARe8VBw5lwlTMHfaGnwLv8cjSoHXs?=
 =?us-ascii?Q?J5+MB/lk2vwfx/bxt/+gWAwFv77TRmdaR0kncIhGaqWfvFbvnewSrMUVTtwA?=
 =?us-ascii?Q?8Ba2xJtkiAHNEk7njqgTSCOpexhfwYt61xlxCf/MHI7IqZJN1JfjNCVfCv/l?=
 =?us-ascii?Q?8QIMMKx1G0PVJvz4LeK6SsYgiuO7Reei6WzBCjYWTBRTRZR0cdDCXyJ1MGnV?=
 =?us-ascii?Q?MALViEr9ST6Ns8XxVNGqwjmTiDUNx/LtEzlwp7yQ4Lw5vys2a5tDMpeA1gY7?=
 =?us-ascii?Q?RapaQufDYXwTIpG5pNtAOne3J7iPAgIcytD8hDm6hdA21Tgr1E/XuiSiy48r?=
 =?us-ascii?Q?IXvEX5qeUNNKlC10CZE0QD9OkuVtDTxByY46FOOM92HInRM2Yl9bNWU82CLf?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eded5710-f6e9-4c01-403c-08dcf41b7573
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:15.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA6gdVrV1cpxNziFWzAkQPT36D1KKyImbbuhxOTNkM2l+k9qirOFXrTeRopUtN5AeGz0gWzWxxtN4MC01OfKBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This updates broadcast transport release to unlink stream from all its
links.
---
 profiles/audio/transport.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bb2ce8a4a..5646b2004 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1779,10 +1779,45 @@ static guint transport_bap_resume(struct media_transport *transport,
 	return id;
 }
 
+static void update_links(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(link);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	bap_update_links(transport);
+}
+
+static void transport_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct bt_bap_stream *stream = user_data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(link);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	bt_bap_stream_io_unlink(link, stream);
+
+	bap_update_links(transport);
+
+	/* Emit property changed for all remaining links */
+	queue_foreach(bt_bap_stream_io_get_links(link), update_links, NULL);
+}
+
 static guint transport_bap_suspend(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 	bt_bap_stream_func_t func = NULL;
 	guint id;
 
@@ -1794,6 +1829,10 @@ static guint transport_bap_suspend(struct media_transport *transport,
 	else
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 
+	if (bt_bap_stream_get_type(bap->stream) == BT_BAP_STREAM_TYPE_BCAST)
+		/* Unlink stream from all its links */
+		queue_foreach(links, transport_unlink, bap->stream);
+
 	bap_update_links(transport);
 
 	id = bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
-- 
2.43.0

