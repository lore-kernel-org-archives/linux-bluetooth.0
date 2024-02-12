Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3683C092
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751964; cv=fail; b=JXeTv64/WAvZIMeoKy4r+XXs9mwIEiXb/Hpq0Sjoh0kKczlpohXzEXr9iVCJjfCWOe1N57E7CEXBuFEpwc3772iDaq6puf2XeO1rgmTEKaPWlXbBjFuqFuTaZfHjlXTHVgMsTuSkWMsRUqelTCvAK8CthEaESZOhDmRVUQ9O9fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751964; c=relaxed/simple;
	bh=N9NxA+u0BsScDfm4y2vZT9Y9GTicbxxgxCiSMXE58qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBvnTGzAQ6devZCCbsvFZmabeL+NCrr0P+LPZS7JYmgxi7FGDsMGAGbi/vt7x94QYm3cfoABpg5J3LZ/iv0w3RTutRBz9ZlC39DTdxYm6Y52uSsKQ+6LUTakfUdhj6BzmO0HU9WkuX1m+qbD8cqEseexOlcPSz0m++XsyFiGTTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K4OhfRxQ; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4OhfRxQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJEGyWnZihxBbO+sb9c2rOm6htDUrCyLRkchwVmblNpgja3AEYmGqrUHDMhopZRwxlsRsXt/aY4lcyH3/XB2WlrCisM899Q+l6rdC+YAOkZkWEs8p3iESaKWWH2r5OMfQOuK6JeWZIGJVZ9oHXxQeU+helZH5OgjJirvF0emXlG/OYRGQeURZkuVDhcuUXl33ntCxzBT+9cDSFHV+yejPXI0pHc+Y4MSZrkcxFOd0PB5PoZc8r1s5tn9ou6MHtx7uanFXPKWuIosuW2SPEmGUJI/wg/hxOuRuuH6u87AkKAcNvBseC0gP4/OOJ0WPaAIU4iAkIeuj1fYA0holvF1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H/wMe4ThMz2C/RsU1grmhMzmim4s5YA2NYbFaIJeFA=;
 b=ajujRuV4WUJQZbIA7G+d1a2hWfmufNl0+n9NaoVTPGgqO+V8m8J+YZjdqrTv20BmzmhKnjmc/BemBu6n+rYmoDbgre7SbrdP1eP7dV+xmg/UwXOKD8keNancmKFmyit0wVLi/AMffI60uyqOFJ70VhoT12fCu05a/KwFsnAyWh8ArlwXr6SGvNv3FWgaIC889OpzSsFcGyzAxBq4wR7mCof7bBXG5j7LLyBoytOAPt0POaJoC24/Y2T+s8wwcyjzrsByGLbnLQ4F1/WgrNlTSRmx6pQ4YCuWpymHxv+kHBO4X/O71z+Un3eStvBzON5Ipu1ZysIdaE1UtAyVEAMZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H/wMe4ThMz2C/RsU1grmhMzmim4s5YA2NYbFaIJeFA=;
 b=K4OhfRxQ02YmJ6lpIWaWOvcHIAGjAxRFDbGR7g/6PGr0nblSGBpuYO9/HLcr/N4HdmlUCQWW2kCkpISM/zUZJE2VURn9GWrh244iA/qw2thwlT+5VSp+ZXfO7bxz7B0MvYbKmG1FkC1mjb5V24bshGXk4PqvvK3dNYIiVs5kVow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:32:35 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:35 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 4/7] bap: Split bap_state and bap_connecting in two functions
Date: Mon, 12 Feb 2024 17:32:19 +0200
Message-Id: <20240212153222.8191-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::12) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: cda5b45d-8c68-40da-7542-08dc2bdfd668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qLxdKVullgoFOhE8ebhWxDL8wMGHsb++Amf8XReiPY/TWbykZmdxxBC3JONrtw9lIR2QXvad4COGbnTz+jHksX5b5z3wRmUH9dBJzfUgrgceiLzIIS4++hyL1bxU55Rjq2NRUF40QV4P9QTbCIVtG/wNmQQ8ppX0agnLIfEIyswKt0ntcEbpmqjitOPg3d+lHSyqGH4KNtfHgnyW2fTQJQG4ojqKcmbHQmParrCS8lUcMvx7IkCEMK6MHBEQ+7cY1TtTRj4wu6kJD2T6lxm1DI8dIoApDcSffqGjtyZHODLCO8yJtWDOBiKXV9i8XJVIuOu5oQAEe1/pGh0OC3xL+SLuIb+u34gnO+er2rmvCb0N88Kmz2PBUJ0od/sPZg5bXOscCDSc9OTmvaOODxhGfN2qeVtEfIeAh12O78yYfVFihHGxySy6NQYVl5hPi+59e4Yriek79abNT5aSJ8OoCI17lnZFcn/eWT9D94jkpBaizZ18ksQG6P9lBz0W/97ZVCBeXm02s0N67tZGxv14wyr/nf13e2SaJhnzdJZzrRNZeem0asUntC6b+Y1ip2hV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(2906002)(5660300002)(66556008)(66476007)(4326008)(66946007)(86362001)(8936002)(8676002)(6916009)(6512007)(6506007)(478600001)(26005)(2616005)(41300700001)(1076003)(36756003)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtaVRfiFOPPoi6kYiMOVGhLVUi+/NHVYuh3TzqySxAXmVXDPXtJFxyEkRaCv?=
 =?us-ascii?Q?10iTAbQLYa/no0WKDuzQCexLdF7HLg794dho/5MwVnuvjHJktpTAWpiWzFID?=
 =?us-ascii?Q?7Eu1GfdTiueZbhBLUTi9oEJQ59dH8XhPOV0pByURfM+ASXGQ79RNtk/TCEMd?=
 =?us-ascii?Q?DS4gzc34Yy60eeIsaAyiaMmX6zywPwKCy633Hj5sGbCF5JCMU4zwtFBqOpG9?=
 =?us-ascii?Q?+JYtOVNb0BqEx459keYLZmW1LHAxWB5eSULyYAxqKBOEjb7zL/zN5o/D8+Bl?=
 =?us-ascii?Q?dAugFFVSsYsUJ8FQGRvkQw2suWUkEkAxZcWZu8c64JCmAnf0r7i+m/flJ+Cf?=
 =?us-ascii?Q?z9b8L9cWgVPCGsztr18ckhxxERxBjRHyuWzRbDAnBCgV1Fpwsxq/YN7lnM0Y?=
 =?us-ascii?Q?AML/duh6xtNzdo4pMrtGfAILAgcQCV8CPpECoSNDMA1rjLxtJ8htOF58zYdU?=
 =?us-ascii?Q?Ck+zwQuEtnAQVsLmp4mV+3d9y+qgomalBHuwNskoQ2IASwIcHOfSr6qxw6Rn?=
 =?us-ascii?Q?QxBzqQloO4Ljy6UTGW7gQ3x9uk+R5ybXTh1zhfkBzZtH0MBNO3HnfgHRXDmD?=
 =?us-ascii?Q?6Sj1wQAYRwtcfLyCk3fcmy68ns2keZ3QxxX1NVEpSEB7AzIf7cBsOWdiikTu?=
 =?us-ascii?Q?BK0ncid8ccTU98rjjT1d37t7VIWLTL0ekKhpTxWJzzKWgKhTt7Hc6yk+cgYN?=
 =?us-ascii?Q?m3oNHjb0NLI4S3QTVrLGTlLz+uz2OZoVwCFziycdnutTjwI6FyGQImWIClpe?=
 =?us-ascii?Q?sqwZV3GLlVF6hOGU/Wq49nG31+jcGQYc/f5Wk9NL+BP0XWLzsrkrSxRm0teZ?=
 =?us-ascii?Q?ziwxoIGaXF/JcftQaq1Ms0EgV9OvizE7CPlEnBAuGv+JGGG8lGJCQt58fgkD?=
 =?us-ascii?Q?pSILfo9++8VUVMc4yOQGgKdr0DFplZgt0vVOvq30dgaSLDm/2ILnpQB0QLjI?=
 =?us-ascii?Q?DiHcrnQTBbOY+aJFBs13jcrXHxMVEq2OQ3MEzLd1ILh4m10oxiqRr36UhDdp?=
 =?us-ascii?Q?Eo3ODFhd9QdOblekVo+HV8yAsEDcY0RPIcsEJqQJE0BelaYWzjA9QRmGlYIg?=
 =?us-ascii?Q?xc3t8N92Y/ggHJMcs882n1jKvSg6pL7eIsP4OWQ2ABhfvn+SfKaIYkTPlBZx?=
 =?us-ascii?Q?eyZAsGCNarUgAT/A8T8OfyeNcbVMYCID0dq1U+vesJF5H/PgE0IwLt7GOKFN?=
 =?us-ascii?Q?xpo05hskjLzaS9eBeQZ+DMQu84AKQ79LWb7tmlK9zKaRPOi9C6lLbpj+muYg?=
 =?us-ascii?Q?3Y1LATCNpXhxbJTf798zi/Nr90/E2fzpgDncfzF2JKV2csjLVg5mNIW3OJlC?=
 =?us-ascii?Q?qDcEZB74f4FAj/B6EBkQ7ISZ0cFtwUHsObd0gSF51ex1HSw89ba8TpgOIbTy?=
 =?us-ascii?Q?85NE45iNvb2u5L0oPLVIpSocQozSzOOr9/ix7neup3sb59qDnCFiz4r6LGun?=
 =?us-ascii?Q?KZSBXcGlFJYvdaec/xpz6w2kes9aGj/ZaZuYbldqxJ46rwkZoWbcVncIrLgA?=
 =?us-ascii?Q?BpjgJFT5gw9NNOOxihLO9B+GVBtwxJ0zlN1aoFId9trINPVb8Brla4Wp5SNH?=
 =?us-ascii?Q?U01vHCcZLvdhi0GK59X/FjWKGPyLsb0OOMt/D7pfN7b33PnSxFvvOQAGnBK6?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda5b45d-8c68-40da-7542-08dc2bdfd668
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:35.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VQ+f6HGEUu8kYs/eVZyq4kKAR9GX8jxfL5FLmhWqD2gVi6xlxUlFykNArGH/7S2i5HNl6AXxbOyzdrcM3IeaHLQ+YByzgAMjGL14aS4h3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Split bap_state and bap_connecting in two specific functions
for unicast (bap_state, bap_connecting) and broadcast
(bap_state_bcast, bap_connecting_bcast).
---
 profiles/audio/bap.c | 157 +++++++++++++++++++++++++++++--------------
 1 file changed, 107 insertions(+), 50 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ffd742d7d..cf1c53b30 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2110,25 +2110,19 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				return;
 			}
 
-			if (bt_bap_stream_get_type(stream) ==
-					BT_BAP_STREAM_TYPE_UCAST) {
-				/* Wait QoS response to respond */
-				setup->id = bt_bap_stream_qos(stream,
-								&setup->qos,
-								qos_cb,	setup);
-				if (!setup->id) {
-					error("Failed to Configure QoS");
-					bt_bap_stream_release(stream,
-								NULL, NULL);
-				}
+			/* Wait QoS response to respond */
+			setup->id = bt_bap_stream_qos(stream,
+							&setup->qos,
+							qos_cb,	setup);
+			if (!setup->id) {
+				error("Failed to Configure QoS");
+				bt_bap_stream_release(stream,
+							NULL, NULL);
 			}
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-		if (bt_bap_stream_get_type(stream) ==
-					BT_BAP_STREAM_TYPE_UCAST) {
 			setup_create_io(data, setup, stream, true);
-		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (setup)
@@ -2139,6 +2133,45 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	/* Ignore transitions back to same state */
+	if (new_state == old_state)
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
+		if (setup && !setup->id) {
+			setup_create_io(data, setup, stream, true);
+			if (!setup->io) {
+				error("Unable to create io");
+				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
+					bt_bap_stream_release(stream, NULL,
+								NULL);
+				return;
+			}
+		}
+		break;
+	}
+}
+
 static void pac_added(struct bt_bap_pac *pac, void *user_data)
 {
 	struct btd_service *service = user_data;
@@ -2332,45 +2365,69 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	switch (bt_bap_stream_get_type(setup->stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		/* Attempt to get CIG/CIS if they have not been set */
-		if (qos->ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
-				qos->ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
-			struct bt_iso_qos iso_qos;
+	/* Attempt to get CIG/CIS if they have not been set */
+	if (qos->ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+			qos->ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
+		struct bt_iso_qos iso_qos;
 
-			if (!io_get_qos(io, &iso_qos)) {
-				g_io_channel_unref(io);
-				return;
-			}
-
-			qos->ucast.cig_id = iso_qos.ucast.cig;
-			qos->ucast.cis_id = iso_qos.ucast.cis;
+		if (!io_get_qos(io, &iso_qos)) {
+			g_io_channel_unref(io);
+			return;
 		}
 
-		DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
-				qos->ucast.cig_id, qos->ucast.cis_id);
-		break;
-	case BT_BAP_STREAM_TYPE_BCAST:
-		/* Attempt to get BIG/BIS if they have not been set */
-		if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
-				setup->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
-			struct bt_iso_qos iso_qos;
+		qos->ucast.cig_id = iso_qos.ucast.cig;
+		qos->ucast.cis_id = iso_qos.ucast.cis;
+	}
 
-			if (!io_get_qos(io, &iso_qos)) {
-				g_io_channel_unref(io);
-				return;
-			}
+	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
+			qos->ucast.cig_id, qos->ucast.cis_id);
+}
 
-			qos->bcast.big = iso_qos.bcast.big;
-			qos->bcast.bis = iso_qos.bcast.bis;
-			bt_bap_stream_config(setup->stream, qos, setup->caps,
-								NULL, NULL);
+static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
+							int fd, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+	GIOChannel *io;
+
+	if (!state)
+		return;
+
+	setup = bap_find_setup_by_stream(data, stream);
+	if (!setup)
+		return;
+
+	setup->recreate = false;
+
+	if (!setup->io) {
+		io = g_io_channel_unix_new(fd);
+		setup->io_id = g_io_add_watch(io,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				setup_io_disconnected, setup);
+		setup->io = io;
+	} else
+		io = setup->io;
+
+	g_io_channel_set_close_on_unref(io, FALSE);
+
+	/* Attempt to get BIG/BIS if they have not been set */
+	if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+			setup->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+		struct bt_iso_qos iso_qos;
+
+		if (!io_get_qos(io, &iso_qos)) {
+			g_io_channel_unref(io);
+			return;
 		}
 
-		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-				qos->bcast.big, qos->bcast.bis);
+		setup->qos.bcast.big = iso_qos.bcast.big;
+		setup->qos.bcast.bis = iso_qos.bcast.bis;
+		bt_bap_stream_config(setup->stream, &setup->qos, setup->caps,
+							NULL, NULL);
 	}
+
+	DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
+			setup->qos.bcast.big, setup->qos.bcast.bis);
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -2468,10 +2525,10 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
-	data->state_id = bt_bap_state_register(data->bap, bap_state,
-						bap_connecting, data, NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
-				 pac_removed_broadcast, data, NULL);
+				pac_removed_broadcast, data, NULL);
 
 	bt_bap_set_user_data(data->bap, service);
 
@@ -2623,8 +2680,8 @@ static int bap_adapter_probe(struct btd_profile *p,
 		return -EINVAL;
 	}
 
-	data->state_id = bt_bap_state_register(data->bap, bap_state,
-						bap_connecting, data, NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
 
-- 
2.39.2

