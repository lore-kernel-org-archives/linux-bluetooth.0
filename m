Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F163CD8C99
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJJOxN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjJJOxA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 10:53:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6710C
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 07:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haxasE7MmfnXVnJhU8FPq7ysndNF5dOyVeioQksShjqMf0t8sQA5NXpa+i0SlennzSZcZORPpjMH4y/CXYxovEeNsAOyinh0EGOmTrU/BIsay96rMEEKwvWGoeSM0ft6OqJ3XNlIydF43EFa7eM/V1wEXHcEtlIfuOlo+zXCzr4MsyxklZaUQviL0a7EMAZlJ9IC65+annoGwYgDVTEaTdXYYgHj30gEY3cJNU4g/bDbHInTGnPHA7rrrI87JTLggYtE09LVQSgpn8eMrHSC0GyxiXE4BZpfQIpywRTTVR55RvB2Dmw9kOfleFzVa3Fo8nd3oSW9+YUN6T1rwsA73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQEKcbv4EmQpgK4zMsnFK42Il+sX6r/sky8pm3IZU8A=;
 b=cybh4iLjC/joc0EkTFIWkyhrdWPInWtOeoAicG/B+LZ5vbmz37LIEybxRRB0rQDj5kw0yNm0E+CqyoG3R31UwODAMWzO2zbQM3CQWIFURXoO78Fh2Ru1aKEMTnR0shh2aE7TSUP3yTqbIsWuB5dd+fw2F9sCCk/AzxQZ48EKXFUIbbDM418TKqUPwipDgMSdzQ9knNIYnY+8E1XwBqsfXQTHhfHu/h5vYcmDy4EKnsFPk+/WTeei7HzSAUeLZsEtNcdAv/wLVxbLKONaJm8mPkFwWpbdqm1mh6dxE95nNs1Ccn55lUUe3BFG9mUZqm+oNXB4MEPKMw2ZL5QrQAyrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQEKcbv4EmQpgK4zMsnFK42Il+sX6r/sky8pm3IZU8A=;
 b=Xc3tLEVGIBrL+U/KRiVaNiCL4bNhqZsErXUQ+SzA+yW+pBI7xriJzwTpzcKc7N9fEe/bcQsD5wAqcG8UlqxNFVHiV3S0Il59xdpUufQ5dwZf7hPd8dBcx9pH+SFj6kAuvuv45CycdGelO9ihAksaGVFBjq8kU/M3Y047Tf+Cjxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 14:52:55 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:52:55 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 2/2] bap:Update transport acquire/release flow for bcast src
Date:   Tue, 10 Oct 2023 17:52:42 +0300
Message-Id: <20231010145243.4441-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
References: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0472.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::21) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d4070e-7af8-497a-1fc5-08dbc9a095ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5eMcAV+lfS5ukGiW0IsuVOuyvqpFA1jkzJo45DDf50tnY0SfciiRlqfiwAzOeTmZtMZvHNQLivpqx+RQxtSTvl4FzR3kdiUqWXLLYVUiB6Ne4UgTzHKX+ERejmxmkoWVsHcsBgx/s1DcY7z2NTsHOX3QAZW5Cyuu9nCKEgmsMCXXb7y7Rbw2OFxJmlAAi9YPQOoNlB1bEz0zkU4yVGMX9zujbVza5pn2QMAU+m98gNttuCsgsefM8P2+PaIsZOB3hjD39BNZmIU4jMneIoBCw1hYEtcDtf7PxRsoVGJzXrrqkb6I5U/fLRVE00DkeOs6dtkjLZFq+AGLefA/NpWjJN81IaiiRAIK8A0FTNbNgREyE+0Mai97I/SD4Tum1//y0OsJQzArgUKG8nu5Ix8eKrsPQWe3pX0PYa9LXbbxm/opCEEKJ0gCEj6KW9WHQ2n1YOPtnxkQeYnebCLH2qqChhywJGEQFrKftGUM6b81szHK+JwUL2i9PFD11AgfDRMUOyUmoDZDSo4nil2knO3x97iS+bPVdiyJAF5SKEZ5jiZWmBDeATLj+xutkbFTAF2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(4326008)(8676002)(8936002)(6512007)(6506007)(6666004)(6486002)(6916009)(1076003)(316002)(2616005)(15650500001)(41300700001)(38100700002)(86362001)(26005)(2906002)(5660300002)(36756003)(83380400001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MF2xVqOwVYtI0QJGDUL4nujHwq8rAn1U5uZLZdXzgXfQtH0Abf1yY6NBsZ8X?=
 =?us-ascii?Q?TSAxmg9ghZsiu6tJMfFAoQpSnfTuG9enMIZxkxJpQGznshhKajWkYiqfZBcu?=
 =?us-ascii?Q?MFnbrdIpQmYytSwEUCbFsKWM3/Da2LXLiGQSSu2mmktFgke5Et2q0s39FpX0?=
 =?us-ascii?Q?+LojxXIliz1OSYYBV0J2Ay8xGF/2QY6GtOsfIBi81CCJu8TjggrAQdfY1XuN?=
 =?us-ascii?Q?XYjfCxTV3zn3e6SUhwCPLK8pGCy7cFs/bGyfWEFWgHZ14ClZTSXnBHtcwubx?=
 =?us-ascii?Q?tJrWQyK7afId/EIEZ4qVCcQUUXpuMxiZV5FtstpJ0HaVN6kiLOJGP/tU2Ctl?=
 =?us-ascii?Q?/6c8bMkGeGC1jnvNkwse0h+7qnwvvvnw9zSKvRggmL2IDVcOLnU5A2/Hu8EK?=
 =?us-ascii?Q?TTslH+IXTVN5PzdZNZ1WhWXV7quyPVELVYK8Om7HHjmrW+gJ66UX61sqYlSf?=
 =?us-ascii?Q?fUkadjKGGZrSE1Ww1ldtzjjS1V52I785orW1ZG641nZ0LC1f8SRr2zGHh81u?=
 =?us-ascii?Q?2qRpGL5ujo/Iz4m+A1QFqnxrTvZi++bQv48sY6kVRqP0Deb7KYvsD/+QitJD?=
 =?us-ascii?Q?fBtfmX7Vv4JBftzVNfaflD0PdR6XiILOEH/PBu9/ujAY89Dfb4xqOvfW7vNj?=
 =?us-ascii?Q?o4ZKnwLaPJw+o8c0/R/8uT6H6Aopb/4FUbSTiSCR8pow3RJoS2gyq+9V/ajv?=
 =?us-ascii?Q?f3uZYOELKhyxrVvcNkEblQpKuoNQmx/LlP7K0QTVIPVI1CXp7pxTZQRfxCD/?=
 =?us-ascii?Q?zsaFpONfza4TcBAd5eXozIFun/gJfo6PJbcBGHHbdkq0fS2pbGqS58Zqo57Q?=
 =?us-ascii?Q?n+WPKE2HGkeRh4W+wLFhej5VCFwDznr2xDYYC04vu3ljEZSyNgcLNZV1zhpU?=
 =?us-ascii?Q?JOxji5RGpDLENNMc7pexefJXXbqd+8lAEFJyq1pFuPGL+KR9JlLaQ7sMm1pa?=
 =?us-ascii?Q?pZTZQnpXi/PZRtMgb5Wl7l1S/Z77TeVfuwNBoJf3rQjkrnfB2DoH2hw9MadY?=
 =?us-ascii?Q?qYG7C7xX95H6+derGMZEQEKodnln7UkANOoWPaBHPk3IpY+pUrQybHo/t5Z0?=
 =?us-ascii?Q?NDYc+S6S+C6XuXdhDG5Tcd2P9kBptjpAplsUMOuBeR6n1WE/N1EQJ9YcTdw3?=
 =?us-ascii?Q?BU/UAXjEmyKxqyHL6bPYQVEmx+QoALfpLXbrGOQcd10MrmENwAPQG6g+XYVu?=
 =?us-ascii?Q?64tPHn+F5Llq1RGyHmhh2A+bw2BzjGbNoJbO62xj9QEFNOq9+c11unBmlIQj?=
 =?us-ascii?Q?CBjq1w85rJ67hveT8N4m1qPdcJfd6MasyCyj2bxz8KWiB7ky0Hy6c35i07db?=
 =?us-ascii?Q?ir6mVdeBG60mZCy5nk+WghB1s1mVuMdS8rpTsgcTbr++cZMvq6LqkFvmf9sn?=
 =?us-ascii?Q?drgpF1TemBgwfAgPEebbQI3LR5B+G4YCPu1AC3rMZ0ZNSesjfDQkYa2PiZEu?=
 =?us-ascii?Q?lMZSQZgqw5v2wA0hh7AIQ1mbu+PF0Pm9pkiq1cJGpEwZHUD16q5aQeZfK4cV?=
 =?us-ascii?Q?7L+OpxXZJE/Xwwqh8uHiYxNdsgsHv8lSwahyVvQdok37T1Vtm1IXzoenkvbP?=
 =?us-ascii?Q?6zuCCiKMRq4ymXdARGC64ecalMzaJE2spM6hBvYXbCfIpaSBiXFHv6SFZ+Fl?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d4070e-7af8-497a-1fc5-08dbc9a095ce
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:52:55.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwdAEXOldPubSiYqbOOMcMSunApkarg+6OxWNKTzJscTvMqZxsBmpPfmzESkUiOLvJIeUXW/7C1/UHQXmfuIGEmTD+8M7ae8BxXzbUpFW20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792
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

