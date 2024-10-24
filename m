Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAC1CACC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767796; cv=fail; b=GW1q7OQjOat7HlwHe1Mk5vndiIYqqHbG7a5GWN5G5xJFuQvxB13gXaSJoasax+9mL2ugOSlNIsbjRCArbPJ/ySAVdrTm/ws0xQzcrYcuXse/RHiGdGxkSy6cJ+jpoYuU/X5IgQ/QfPGgALMV+fqfGVNaWBHAHolVdZt9zCOM6sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767796; c=relaxed/simple;
	bh=DBjw1HuhG9Hc1TTXpFthYCiqbR6nNuTPlts6WlPno80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t76jw4AwSO2rYXOhrie46iFi2u/Lp0QyZdcale5uk2LcLu1IgOuLNO6i3Aj5kbpTFCEnjwS6so4G/5PytB1euKbw0CuH7I5zfoYriPftbYeiMghB1Q+478mPFFYsrDMc4CjSCqJX7Cd2efx/bJ4Jb0Fm4twfRWn7UnHa3NxCG+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NasWlrkY; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NasWlrkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3/OrAAMG3bGE9TD61bs2Xr7/iFHiqqGehuUIN2IpJf0gGfGibAuzQO9eGb9qEuN3OxhsA3pK8TstfG3gqGnlwE6hbo9RXFMANkQSmjCFStJm3dLGlRayhl2VOFtosaK8N/DjJvOvgfsqecxsE5+MnpQaFcUQZ2YQD2uHcOg6JtHYbHitu3j2M3wRrSHoY1I0a6x3SwvhcW5fAwM2RuTt6yXVhntQ3kkICbHsDjsL6ZeTvNsDPZMU2WpAVEZePB8Re8tse8lINdiof1wUhYEBwlYMcSZl5HueG88y1wOykFS1yZbrt8DhYh5CBiJpIKt9X3R0h4d6Y9qKGqKaIDPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwWf7rVpAhkvNGcoWH8mWav+kcSOW7QebguyLx4xXQE=;
 b=wS3FcxWA7Nzn0G2DsIgIXRgnyIlPWBlIDk8Iz09Ndsw/BAVQ+zd8zXEWORps749GqJ67YD8K0hIBRR9vYll6/kq4UcHWLvTIo/KOLqXufbZmjgad7GmO2bna1lBjM3MxIEpK+ku1KT3M4BncHO82p3+tpQpkRqhkNKxQd3/nlfc8TTn+udGCXfnp/40zhbopaDAykhzd6gM0QzL2vfdnyl7ig7hZFw0T5+dFY8F7Fbz9Ou9qr10L3zvupSG3Hg/Mkh6gDdG5HFshr2z8sAaL15NkpvX6Q1IakLPGDwF+Bs4iftjV63V4Qw3U0PnCMdcmxzyC0HrkdkSvW51qAZczrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwWf7rVpAhkvNGcoWH8mWav+kcSOW7QebguyLx4xXQE=;
 b=NasWlrkYiEDMKToQ8Ruj7DT25iEyZCnww6d2AfC1NMxGDOcPYweA+0JQclngWMfMwqP0a+1/8zwlWI1Ya7mpUp2niBpxHNQN3vyO2WmHacZoV2uLk7i4H2XfN+tLzuV3JqWbLjZ47eBKgg4gxuq4Kv8g0cZ15qnpg22RmKX5NPI4I9h8G5ZDskvDmGan/bdSLOZ5hYwgNonGAOtF5qEgU6QeCeTtpvV0tcOdxJ9go+HB398XpgTtNr8kWIF/NPlDGNegyWCFjFK7u8PwGdI0vrWkYcLnS+25kDXaAEgChkXfFvm/4VyjjLh3pOy4cUIp1U/o2v3EfFPecM176/0WsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:07 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 10/14] transport: Set bap_update_links as transport op
Date: Thu, 24 Oct 2024 14:02:19 +0300
Message-ID: <20241024110223.77254-11-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87f3a239-3597-4807-ce87-08dcf41b70e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5xiMTA7POO70Ht2wgJWS0VQsp7s7DRuRK/GUjHi9K9wL/qZ/orjn4s5aHHTl?=
 =?us-ascii?Q?03TJfDgVMwDNatMjgrgN01KqLDAhLIw2N34gkCanIap7RUVuic652TJliPTf?=
 =?us-ascii?Q?zZqd3TEx9kylcniBw4FUQJW+3ukQC80wliQryeF0vcmQ6+PLjHBZycRj4wgO?=
 =?us-ascii?Q?rvQ4/DmHRDoNmzbkJo6zS9GimrRKMvLukdiTCrh/Pb60emw8f6thbBBPHpgN?=
 =?us-ascii?Q?A1W78zqtz1V1myJLFXOPdDGC1tB6dbpN+jcz7TeuwbdYiGHHeA2uEmFnah4j?=
 =?us-ascii?Q?fpVQmRapwtuVALhdlqN8CbzqCB0FKT4bV06ELlHY+YggbVrPQ/KPtecKYmi0?=
 =?us-ascii?Q?WxPqfKGaHtMSriW1jYO0pEcmhRZQ9FAvJg7PftNpFc/RW/O5cee32g7qGM7j?=
 =?us-ascii?Q?RXlAhe0Oqa5jx55yS4g1A+l37xEvCDvNpbv5MuPLKQpKpDunuLwb6jFo1SSz?=
 =?us-ascii?Q?2sACo6XTKaD+NGl8L7cv6lDb6Md2sPVx9009rQ6nSPTO1ktaym9KB5/MxD91?=
 =?us-ascii?Q?LRsN2qeovu64uUqnOjCukQvWXdY9DVaoxapGoFL9nqorJEgst1xCKClH4VLS?=
 =?us-ascii?Q?Hd9WRPSP7MdWCsDzlqnBi70mPT/Qz0HS5cR6ttm0YonsRZjWyVM/8QgLols8?=
 =?us-ascii?Q?6rJPZThWbu3rJ6GPHf+mvIWKD/SDygM7W0iqZv6TcytXvtcXQTTinGIWdh4s?=
 =?us-ascii?Q?KQOe2gxF9HJXe/LJIUwhQdoAMo3lKSGQbAXxSPkcyNCgU5FS+OLc2Dv80siY?=
 =?us-ascii?Q?8PcmUUdSL2fi8hy3vc6dQV9Taxe7qifGYeyvTsMYQpj6e3VyUNYzZmdmDpbI?=
 =?us-ascii?Q?ZH9zbxkF2/sVrrKEeMboB5/pfumkfeCY0u0wISacRGwP+DhyyZINVO2Lom7u?=
 =?us-ascii?Q?RC+yStx4ukG0V/N9NaPz1EledqDEYMd+YBScf6tBe5vCqZWAh7+w+9gKcyCK?=
 =?us-ascii?Q?h7T3NkzUAI1QBsFMgPf/YFg5mybqHOJrMJOeM/OT0pxTYjXvuw82OgOT2sSx?=
 =?us-ascii?Q?oKuWhDxaX6TZihAp03gfg0deXPEyei/2pYV22lN7fvKg1Ke9fG45I5+TW5Yx?=
 =?us-ascii?Q?tETfWeDFcgnC4sBMCRGyCrS5R9egNl9fv4iDITDaogtIVMnubxiWBOnD3x1S?=
 =?us-ascii?Q?jN5CSh6HeSW/CPiI/UMiY5g5L1P0TiNurGiS6RtlAz1idLG3ya0FLR1tgK97?=
 =?us-ascii?Q?h7NP8xSHjr0/i6pFFUGSpEPCkPbyiXMkkEL+7X/2UZcRduXAIImAc9uEM2FX?=
 =?us-ascii?Q?GM35SFRPURb2Zh2/2noe5L8QGEVjY76ACCVEduAxtVN7CYrTyRzTsMJJyvmB?=
 =?us-ascii?Q?xTVgf+Z1vwORk2uEIVh9S1aWtrqEjb3ojswq6iHPGo8nyIrxRPvXrQvdPjav?=
 =?us-ascii?Q?5gixNB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXRj7Ql6Z4joKw3/aN1VlaeW4LzIX+HaWDEH1vaxauvEy4Nqri0PtcrI1AbT?=
 =?us-ascii?Q?U7gQRS15KkAvfWDp5/bM12QdHnrMrjjm5hoJG27bzB/EH8SjD9ZE3RznMmDr?=
 =?us-ascii?Q?p+Icc/MSL2BYQYZMEE2bfI0QJOfxQdI5GZvbFEGYZiSdluhsdpw6VJk4V6mj?=
 =?us-ascii?Q?9+xOfmtfjIJzP1wiBeOwU6jpKSBcZRMTSDw+9q47Rya3chchZKglf8U6IalA?=
 =?us-ascii?Q?0V3lxoDC9n1KzK2n4vLfWPNlLJwfiiTKK5i1/LEVwP5V4VpJ2iZ3BHtJxYYg?=
 =?us-ascii?Q?0MfmEi7Nb9YQN3c17rq+2IeE6vGYt8/AI5Mp/SAelE7DgWPvEETYzEw4RbMG?=
 =?us-ascii?Q?RTc35noTLxJitlmGZFq7ohbA1bfnMTbqXffUjyzCbY8dbd7OmaRE7TXTSKPE?=
 =?us-ascii?Q?Lw6rS/lloul4b7QsiPnzupQW5OWjo9QfdZDtumrFBbHdY2ErbijMFTuEgTsd?=
 =?us-ascii?Q?jO+IkG4OMysTOAFcyAlUqn8eXL+vLYvtt7Dwk07McoqxcMIxhTQBQrs+5+yJ?=
 =?us-ascii?Q?scouKEzm43HbpPYUXOb32LTwed0MZinrarHFzbGtIuxOqGlSa1SSuZFga3jS?=
 =?us-ascii?Q?YB3JP33bEEWx6Rerl62vNwl3BJvOVAZHi7XaA8jEzl2KNGhZmqoGfx4U0Cdr?=
 =?us-ascii?Q?yKqdkeo2ZK3TTEjdd+6lBEtw/m7oCpI0nFYXgaePkS0v4RCIDSdUJ65nguFI?=
 =?us-ascii?Q?c8GcMXPFoRs5OsKD3SNMPNIVRqSkI3jlviSJso42IbDwOVHM4LAUk3C0FEht?=
 =?us-ascii?Q?3TXXW0/CufQB9psLxtGRhuzOHgCw3hpMDyC4E5k3hH9JtRk4NKHEeXX+km0N?=
 =?us-ascii?Q?pYGyW7cSqqmPJy5gV5r/U5bQjbN1jYk7AX4oSfvCjs0/umDw2iCHxSKWBzCx?=
 =?us-ascii?Q?yZER/YAEOYcDmAfvIzS1j38zZXKc74uBuYEz6venURzC9M5DaAkBd6PIeME/?=
 =?us-ascii?Q?XQRS4ECmBothOqZTv+MZbF06/FLnjZRCpZcQ1o6KiWml8bmKddag8HnrNARJ?=
 =?us-ascii?Q?noN46FXtyZ6HktNafKwMojZdMHfJOHQnx6dX0uyUx3zcRnXPVLHOadq7dblu?=
 =?us-ascii?Q?0jeFIjyRv7bJT9vuCPorQr/OCWPgWbQSZoB8Ruua0sKM7cbYAlRyIY+BhWOo?=
 =?us-ascii?Q?qhxZipqCg6fD/YYfTdxYUERyigmxYSkrcRbdZvC8+ebzpGUyCYmCN1rpMPTX?=
 =?us-ascii?Q?unRB86xEhHhL19iShxT0X+zFiqkTplQY3E0x1nE/Ce1FbE/GNXDg7ofv8ov0?=
 =?us-ascii?Q?HDd4kwSaefGmFRkRe8kd7xs+/XSqD6DdeSmnU0DJTIY3YFP3+pbXLmhb7Xjd?=
 =?us-ascii?Q?vfuLpThY4V6xN9BQcrk7rVYL+m6pKDCsYjEZx4C2/5cpGs/Lf0lv4sI41gM8?=
 =?us-ascii?Q?HkBhnJvZY+7sV+fO79xEXkvCtR1hQkELadvWjFJ8Imi1hbRy3C4H4WdwjyW5?=
 =?us-ascii?Q?Q7IIeo6hTlew9iaelvnBv6jTMm167PbCMSXtCJRVnS9/nhLMWmq1AFhqqDwk?=
 =?us-ascii?Q?b09nVulxmeInhZAxfF6fbifwT4oriRwhwJgk+C94BeN6F1AZJ3pCu81rnyYA?=
 =?us-ascii?Q?yN1z2j3UXHLYk7SN2sHF0ZXQ/vicvYUaD4UUBmN4668YPdYOHIu9HynzGvt0?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f3a239-3597-4807-ce87-08dcf41b70e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:07.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vNAmALi7b5dWPyIQgL84P9FTV3og9w33kqbQ2D1Zb3tN/MEs4p1wqahQsPbYrwepLbv27FTpMXZKUGmVXC4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This implements bap_update_links as transport op, since broadcast links
need to be handled differently for unicast, which only allows one link.
For broadcast, the property changed signal should be emitted everytime
a new link is added or removed.
---
 profiles/audio/transport.c | 45 +++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index b3bcbaa19..2f5ff6de0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -116,6 +116,7 @@ struct media_transport_ops {
 	void *(*get_stream)(struct media_transport *transport);
 	int8_t (*get_volume)(struct media_transport *transport);
 	int (*set_volume)(struct media_transport *transport, int8_t level);
+	void (*update_links)(const struct media_transport *transport);
 	GDestroyNotify destroy;
 };
 
@@ -1628,7 +1629,8 @@ static bool match_link_transport(const void *data, const void *user_data)
 	return true;
 }
 
-static void bap_update_links(const struct media_transport *transport)
+static void transport_bap_update_links_uc(
+	const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
 	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
@@ -1651,6 +1653,30 @@ static void bap_update_links(const struct media_transport *transport)
 	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
 }
 
+static void transport_bap_update_links_bc(
+	const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+
+	if (!queue_isempty(links))
+		bap->linked = true;
+	else
+		bap->linked = false;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Links");
+
+	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
+}
+
+static void bap_update_links(const struct media_transport *transport)
+{
+	if (transport->ops && transport->ops->update_links)
+		transport->ops->update_links(transport);
+}
+
 static void bap_update_qos(const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
@@ -2105,7 +2131,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
-		      _get_volume, _set_volume, _destroy) \
+		      _get_volume, _set_volume, _update_links, _destroy) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
@@ -2119,6 +2145,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 	.get_stream = _get_stream, \
 	.get_volume = _get_volume, \
 	.set_volume = _set_volume, \
+	.update_links = _update_links, \
 	.destroy = _destroy \
 }
 
@@ -2127,22 +2154,24 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-			_set_volume, _destroy)
+			_set_volume, NULL, _destroy)
 
-#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner) \
+#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links) \
 	TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, transport_bap_set_state, \
-			transport_bap_get_stream, NULL, NULL, \
+			transport_bap_get_stream, NULL, NULL, _update_links, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_uc_properties, \
-			transport_bap_set_owner, transport_bap_remove_owner)
+			transport_bap_set_owner, transport_bap_remove_owner, \
+			transport_bap_update_links_uc)
 
 #define BAP_BC_OPS(_uuid) \
-	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
+	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
+			transport_bap_update_links_bc)
 
 #define ASHA_OPS(_uuid) \
 	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
@@ -2150,7 +2179,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL)
+			NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
-- 
2.43.0

