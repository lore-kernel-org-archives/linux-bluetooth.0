Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAECCD8C99
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 14:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjJJOti (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjJJOte (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 10:49:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7699
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 07:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URthfT2OydaW9TiPDrDhG/3dpjprycDVm1H3sGVC9et9Rvb5BhjtjbWsEbDM6n+vbBiF/ZNc3FLclbdogqXs9m94QZQfald51pWJ2W6YRI8jhnJl+c2WurwNcGOj5WR8WtX80VWhQ0X0/vDYTUyErSxIH3odReTbIX7zuDxKDVLH06Yad4Ujue4JBS1iVL5XjpbZw8xmV3lXc/V5pkDaOcSr92NCFZ+w3iXi5DHmWnfX1uMA+wd979ZU4OHXdATEI5Cd58M7RFYQKjdPXhewXV4uDhB1R9yNBQwdGZrUXE8JpH09/h6ChkOwgDixRPsazBieIlHL0E96KASR8N8QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQEKcbv4EmQpgK4zMsnFK42Il+sX6r/sky8pm3IZU8A=;
 b=JyiQ+dJB2PVlu1Q8rbQR/8f7FDlQW4r17o5DitB5ozv76/FLbDMWWpvX6L6gxx0sVT5J+qtofYK9I/5Q8TqhQDF0RW0zhQCPf9H+lQ6N2eBbmS4SBSeQl5NWlNv3EgByK07n3Nde26Vx5E1kvT9n5VantqSvXIpLnDjehInW8Zr2FkhI+C2YuY/adFVmlQcdJ/iWvK9+KLLUhk+RlRQy7+N6fMnWkUniOct8uT7W4gzlfmE6hGUKfB+ygz2RVijpCNnNJ6gCQBXj3r5uLr3qTUiW8SzBDpBuZgBr7r14dVyMnB5Bk8RZiiH2/doL9WYtKhOOCnu5ym/vvY6RLQ5FZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQEKcbv4EmQpgK4zMsnFK42Il+sX6r/sky8pm3IZU8A=;
 b=Oalwvog8E6ADjPoKM30BnumpGNtTB1d4VR2K9F/Q4vHlX9gri+rBDWKPMQsyOrZ2Fk2HnV4Zwm27zy2MI+Q9T4tQLjsJvnCacS6dZkHwBd9phRpyl4xm6u3Dr5hAS/tZnwITRFwBb6hiv/HTWdzx3bZJA4FTeBJVPh4tiujyPS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9220.eurprd04.prod.outlook.com (2603:10a6:102:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:49:29 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:49:29 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 2/2] bap:Update transport acquire/release flow for bcast src
Date:   Tue, 10 Oct 2023 17:49:17 +0300
Message-Id: <20231010144917.4400-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010144917.4400-1-silviu.barbulescu@nxp.com>
References: <20231010144917.4400-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::42) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2976391c-18d9-4ade-52b5-08dbc9a01b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9FBKuQDwnZ9deZze3wklI+rL5gH+OQVldNoc8OvB//MhELCD2X4bpIvCfEhBio9RJ6XpdC+UTtt2UeYLKBtGro4SbvV2xW4J8qHMhrZeWzSFBFNlvYvR9HKcbkweKweNj+YBpu3UYtDQ3XqhuAwED3o7rm5CC1ORMFCRv+PSCqJFFNA4X9IMDnpMtZDfCZJ6URf4GLjr+6vqCle8a2cyOtVmP3rdfydcwZPTJ2PTtEbThaazaY1CxOje92ZLnVxfoMXYPxQRwAc1q2S6xMdKnsoLkW/oscLwvdA77bc3k8woEjt9Xic8JF4UD6dGITGcESYwM0ei61FzeUy67S7WYkdHmZm5iuyAJhWEZQZUA3aiNPiQr/yodncGKpdELj+hZxcHM5F64EtPHHVgySZIe9SEs+nzc1XU+G8TuGXJDjPSDcUV3bufGyOuElRNEGurz/+SavmrxrnnbxU5MW1x4NKxTYDM35oK9koWydRvhmuaFe7FIDaWOexL2pZtEf041J1Aj6/cPm+6kpXh9xJpHiCqEz+z6psg8MBjJxp48bqWvwvw1L434+XvnzOMkZU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(1076003)(6506007)(2616005)(478600001)(6486002)(6666004)(83380400001)(26005)(15650500001)(2906002)(5660300002)(66556008)(66476007)(66946007)(6916009)(8676002)(8936002)(4326008)(316002)(41300700001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUpLKJ9W2QPqCd9OkBMeeC8X+UauCKCs+awjXaVOych5tw7PJ3B7TDedCiJe?=
 =?us-ascii?Q?N7tbdRenR2UW0RLUn/wduFoGeoQiNjGDMltkTMvZFvwMmgBNr3nA0/HmVOPk?=
 =?us-ascii?Q?am+uamUd1PalaDRugM8tdZa9UttVd2Mf0gbPj8OQ9n403oPxFACg23sUngR9?=
 =?us-ascii?Q?UD16AuM0SuSje64vUxMgB3+o6rHlFgziJhwV4Oh+h+0zbmFsYmEqBksJJcqM?=
 =?us-ascii?Q?0f3rlBHNEyLPrOasiJc5hAI+8un551gRBqXZZkkhlJj4BOcV0HvOXXPZNVKC?=
 =?us-ascii?Q?VPBq5nqPpiTFOl4hBfgAW1VBi4uHoejPPyyBd+og7SCqeW51Y3AgNP7wI853?=
 =?us-ascii?Q?08/ucnikz0fVgqWd6TJKwUB1yTKy4QUbpPHzLIOv/mXXp2X9INXi0yTOKXvK?=
 =?us-ascii?Q?A1oOnFUQVu4BAgIYoCJkErKXYOSUu4rySqXSSAZEBrp/10ZhZpjoQ+FISeZN?=
 =?us-ascii?Q?P0ZVLOfqfnWvzcjqqfJSe6WrTEhxgvwy43hW5U/932ZUUwY3vctCm55dL15x?=
 =?us-ascii?Q?GIOvdCG/tZP6VT58FI49xyCPFN+EFKRcHPHEfwZha8EN7KjbraURNH40L+N9?=
 =?us-ascii?Q?CFZRYV2F5578YPXhQVocc7OIOsdeZ3PeAVgmGLmylMyeO2BbC2TPWHK4PB6r?=
 =?us-ascii?Q?dmLgOAE9Yih/vJ3shOnADt9xVravjHtXaQiFQdIc+c6Dz7vIoYFGfK8OOp+C?=
 =?us-ascii?Q?m1mkbIeomFqGBGv8SD4GexNNuOFaX0PPnBbfCtOt8saW2CFtzMDYGh1kEc/v?=
 =?us-ascii?Q?zaN3uo0fWNLo4iDhUXzbSsta5acqlOtPEYYWJc/qdCY+8SaEuQIJGgD3PtE4?=
 =?us-ascii?Q?KzHpchgBirAKDhpkhdzYJYZQ0/5CmhF1NzTIYze1SMqiPj1cZU2cqJZYAJOh?=
 =?us-ascii?Q?LRQQtR/7cJ756+AUw/zOqt5sp58CRvl3PhrzPclm0b2ZuU2ckcCRfp4hwcRg?=
 =?us-ascii?Q?T0HOHm4a6dfQQwsWmZKEN033oiNJaEGhgJZWW7qyTDvZdxJDBmblIdlf5y0E?=
 =?us-ascii?Q?XkDc2F33Ifyrv420tNwT1gkzW9ynffsoR8oCC/yHFftUubKIU0OW+eF9T5Me?=
 =?us-ascii?Q?YToay1gybt9XWr1YrA4XAv2bbq4DIO7Qib93lwz3m6aDnxUWDp0safY6iXua?=
 =?us-ascii?Q?0oQge1bHXphsZVce/3tmYRZtz/dK1FXOeRSmHcD7lNLFZ63XePWWow3FGgdH?=
 =?us-ascii?Q?z2Os3u+GD6kPPLgHQd9vWz52Q0wt15bYhs7zKxj9lUyaLAzOln5unWzbav82?=
 =?us-ascii?Q?PzCxtC+WBjMj+0/q46axO0oPUAY/Z+9wyjXqZdF5OZB3JX6Twh9mROZNEw7y?=
 =?us-ascii?Q?m7rGLoJabUhdca8Jh6YcNdhmn4cNdlBCoA2s9Ph8jAxi1MjynLyFb8Z3sW9e?=
 =?us-ascii?Q?lKarai48SS8R5zKLeHGiBimjj2i7Hbb/Lns+qXypyeWOub4PISdZ9/nWhFMY?=
 =?us-ascii?Q?c5Eq1XEqnKX16Z7TV2i3AcDkORNawMtrSNGfScWgm7/pgoSf9MQ316ujZNM8?=
 =?us-ascii?Q?DFejrL2XO4d9DacMRW+qhuWV1cz0MRoNdBRa1Qh74oqUL7iTPkfMQR3Kf/2n?=
 =?us-ascii?Q?ngQoMJbJct/wfERasn3D9KKPlKJXrRNwqrnOVOlOYcqyKcLUCA7qrEh6kAk2?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2976391c-18d9-4ade-52b5-08dbc9a01b47
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:49:29.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5exuOPswI4NaNiyNMme/BMJ4b1jZg4SJ4BCC8G4JeNWdlTN/Jtc31YqMQovZYJ6cJ3eKVEB+gv9n3TkJRwXQN++aJST1x8yxPq4VkDCSCLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9220
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP bcast source

---
 profiles/audio/bap.c | 51 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 48a1a4f86..f23e04f00 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1312,6 +1312,32 @@ static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
 	return NULL;
 }
 
+static void iso_connect_bcast_cb(GIOChannel *chan, GError *err,
+					gpointer user_data)
+{
+	struct bt_bap_stream *stream = user_data;
+	int fd;
+
+	if (err) {
+		error("%s", err->message);
+		bt_bap_stream_set_io(stream, -1);
+		return;
+	}
+
+	DBG("ISO connected");
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	if (bt_bap_stream_set_io(stream, fd)) {
+		bt_bap_stream_start(stream, NULL, NULL);
+		g_io_channel_set_close_on_unref(chan, FALSE);
+		return;
+	}
+
+	error("Unable to set IO");
+	bt_bap_stream_set_io(stream, -1);
+}
+
 static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct bt_bap_stream *stream = user_data;
@@ -1560,6 +1586,17 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
+					gpointer user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	if (!ep->stream)
+		return;
+
+	iso_connect_bcast_cb(chan, err, ep->stream);
+}
+
 static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct bap_ep *ep = user_data;
@@ -1661,7 +1698,7 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	DBG("ep %p stream %p ", ep, stream);
 	ba2str(btd_adapter_get_address(adapter), addr);
 
-	io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+	io = bt_io_connect(bap_connect_bcast_io_cb, ep, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(adapter),
 			BT_IO_OPT_DEST_BDADDR,
@@ -1887,18 +1924,16 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-		bap_create_io(data, ep, stream, true);
+		if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+			bap_create_io(data, ep, stream, true);
+		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (ep)
 			bap_create_io(data, ep, stream, false);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		if (bt_bap_stream_get_type(stream) ==
-				BT_BAP_STREAM_TYPE_BCAST) {
-			if (ep)
-				bap_create_io(data, ep, stream, false);
-		}
 		break;
 	}
 }
@@ -2116,6 +2151,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 			ep->qos.bcast.big = qos.bcast.big;
 			ep->qos.bcast.bis = qos.bcast.bis;
+			bt_bap_stream_config(ep->stream, &ep->qos,
+					ep->caps, NULL, NULL);
 		}
 
 		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-- 
2.39.2

