Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB41CDB483
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 10:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJMKGj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJMKGh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 06:06:37 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FFD6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 03:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKwxHT2xt8WIJ9QV//OFH0QEZ6a5ioH8WtewszLNoRQYViKbO4poyJQPms0c7QkeSiUSXEOFb7vt8Y03dQwNkxB60aV6zWKnrL150JKYy0d6U1V7xBeb/ExcQlRxwjUrr5v/YwPWiTdNeolkeyd84TR2h0r9ouaU5wT3eypI9BH+Sg/GvPhYVQj3AtEDCrUS6ZFEOKC6XW546s0H3f/AKDXEL82pLMvBVHFtd2eXxeSjfSBO7DWwWMhMWNBDYVZyGEIB6VxzdUdOtldeU+JZOgpgV7nSCj+Jrqa+6bueLml2ywGL4cd/e6GuONNPg8174dXFQS+N0VKsHHK4uSRrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iwQzgGXnLwyQA/YmSlwyG7Ih/dUeVyOkY/pNqsZeo4=;
 b=Qf9JiPkZSbXgNRzEK2dlCa8oXzEtIF1sUg0BcfjCm9V4Z0ZUqrQHScOIxAnYFyRLCINVdylmzFt97zOhpjPh1Fex05KsbjBaEc65P9vVNNQ2ZNltFlOMmvVkFId7zO/zudAeztIazKTcTm4BY590spH1byZHgrqFpMbyPXyBi0RPdGnWlUk46tk6s7h052g6y+cKFbRZsVmDNjRp/FSaQAEQEKezG6klUtdW45mF6YNB8kx3ZtpEzs+CboiDl0N7NCKbFG7qdt1V5Pc2d3ASvsKqQOnUp33OWq3c4deAMDfTfAF9dNuu+8Y0zkQjvka6yWgO06YXA4i8XsJmumBGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iwQzgGXnLwyQA/YmSlwyG7Ih/dUeVyOkY/pNqsZeo4=;
 b=GCR7dsnoRfGPJd2GRAEb8PWIaJ4oag2o1YtJcXTr8qnKf9rnEi6dk+JQqPUkbZgzb0LoAgrmQVJfrOqhr7cSHfKKeRI7n+J6pznnoZcQuWdLZa9bG+7DqqWJD4SwDuH62FRV0WqDdZXlKTRz82DxVhLTS9IkjthDKCeeChJf6gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:06:31 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:06:31 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 2/2] bap: Fix source+sink endpoint registration
Date:   Fri, 13 Oct 2023 13:05:37 +0300
Message-Id: <20231013100537.3867-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013100537.3867-1-claudia.rosu@nxp.com>
References: <20231013100537.3867-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::18) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eab1099-a14d-4643-da13-08dbcbd412b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGzt8ruFz8ijsMBucnerxgdGXmAH6Iw/pmnEmU89jxr56c0d+pESICaPDizZ+y0ulc3WfQbkN79O8wrh2Bo75TiMNO5RJSw6TFJuaPSFTr5p9vsQSRFE0Vm2zkdP8g4quuFx7MRPszhvgri5hRAhmv+hVAUV3JrTy+hL6RlUULxr1YoCsUfccWYrw03zgi6wULv35DM92CvgmO6M6c76+WYouwzSXks0YuEwtetTp14+fhqI396ozbn2VdeO9vR7ghHejP/0GkwMq3bHDl3cNE27HrijBcjhKIOXDcCYsafGtndHZU97St9mTA2ObVdLGGm+oQUWWxDw70W1RCz1Kj3r8ohQgfBqFbSdS0nc3VNj+ReGRF6YeFD4bMz1AdipfOmiNNGr84PjSrxvC6EjvY8T97MJILuGaGy17lEhhEpgjyyLt+/qCcipMRnAC/oUmnt0o5G8KdvAPC7ouuLDwdBT/yzlKn1woIXekH1iwPSgMJf+PWHMZjhVjxW05+dI1RP4hgCvuLrxoA30KqHoe08kWnH7h8M6v+NUXkLdbl1MpBSSR84Oy5h2xpLZB91q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6506007)(38100700002)(86362001)(1076003)(2616005)(83380400001)(26005)(8936002)(8676002)(4326008)(2906002)(41300700001)(316002)(6916009)(5660300002)(6486002)(66556008)(66476007)(66946007)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNsETQERsFCEAu2qnjRQ8zELdB0k5JLbskCDfU4AwOwQTXyG7okEY1NBhL1o?=
 =?us-ascii?Q?ZN6+VOOaIKADNvnJtOcdm4o6r/W9WFgblvIH2ysFG9UOUhWFu6cq3xE9aY+A?=
 =?us-ascii?Q?5dyDg3Gnwopljbv75ZdatvlnOXobwXm/ndAN/cOAahcCpl5cY3fhsMBa4YhX?=
 =?us-ascii?Q?AC1aaOT+wXTjBBLoYUGLn6Vdjp00kCuKBIsMsoFmGDFB+395w9/W6qgYofeo?=
 =?us-ascii?Q?KX1tRW/Ee0fwYRoPGKrrmqCLxUR5Pyh+iVHDThDJ9pacCBBi1rs2+pvQXnah?=
 =?us-ascii?Q?GLv9A5kHl9O7h3QnSRciNtZurJg5HT82vO5dLRndHPgYfCLM9GDZQXeRMIeW?=
 =?us-ascii?Q?gYYC5+UkVszpvuRzdiiQmsatQ9JPH3k0/7xF5daZyl7YVuRbVjFTHOVln4/8?=
 =?us-ascii?Q?pOLgSO2X9rnATqmjRtyRump/zUZFQ7VXDj5i4fR369v6XT7R7uFLkJ6sMm7I?=
 =?us-ascii?Q?aw5atiHqKekSaSlFQEJz7RJnOvGZTHoYHih4XXqL3qlBEacWDHbII6AMMXER?=
 =?us-ascii?Q?SWohqRbqsdG90RhrKVA9yuTkttsxvqhV3AM/FE1CjeKBz1DAblvutfykDqMv?=
 =?us-ascii?Q?J7yJYpddXXlBy6N2lwqFOpS7znwDHb6howWExkrL/kYo3rIqskHuHZ3qnzWC?=
 =?us-ascii?Q?QBCB6bYDLH3nX3J5SpBbeYHAAOHmgkTI6zZ5vVjPMxMwgS9b/mRrETm7c1o4?=
 =?us-ascii?Q?el08iec762r/NyrocwiiI99XHYCvGq5EHQp1JBARSnriEMWAN44UTewSk1Jq?=
 =?us-ascii?Q?nQf4N2bUvp3T64WlJoEL991/kEepFNFf/2AHP7vAiS78dc85Tbw/aiXEMvCo?=
 =?us-ascii?Q?RHEcCQ5GWzSIOWwHRNNu3dRAzz288Hyr/27GChQ6g8aTdY1Z6wR4GY27mYoG?=
 =?us-ascii?Q?qwsHhsu8bju4BWeMB0F8JmTsRF0ccgMNOESEsAazpJKE4iZ0xgbmW23H+Mji?=
 =?us-ascii?Q?5CPv53nKsgLjbvjTxPXeaVEpIqhan3EYMHS3Q2wZ/1Ltgjk8GmId/FM8fKb2?=
 =?us-ascii?Q?BMLwprXHXSvCRkmNeDELA+h1AwlpR6t3oJznQpN2brn/1AACuTyFISJyXbuu?=
 =?us-ascii?Q?5LETu8aGoLLMJSaknXacaZ698EyQ58FFdY20T5QOQ+a5mHqmmjlYLJBUrRGO?=
 =?us-ascii?Q?riHdDmV2DnR/w1Ujwk04kMM+7BAWjSgxnBZkNKgBw3QtQezYbWhVbCf9cWap?=
 =?us-ascii?Q?LXLn6ZFzAP5nv0b3AMk1fqzy/R/zDDY1URsdxx/sju7NZhcSESk3Rq8mYp6R?=
 =?us-ascii?Q?plZR5hLZ0hXL17f3FAQ/rMxwiQEYtf5WFYD3jkLn+hBXsDBdXJhPbbGcxviw?=
 =?us-ascii?Q?oe34ejV6PcFn+CJnQj7NwoVglfDRDI+YkkPCddAcvDrQU7Zq9Jxg4VH/lMwb?=
 =?us-ascii?Q?8aszgT+ERqhzGXJoc1+76dL25Vm6y0xSA2yotuWtRPQuZW6iKmzWXw2hIydc?=
 =?us-ascii?Q?wnESvZROXNCohQuQsflgPyEBHz+SpVWj2Fvu+/zPXAaG/B6pRSGoBNeV/wTn?=
 =?us-ascii?Q?z+lxXATpNRdSNb3y9hx2RBSlBo+PlC6Cts0TqySrfcOTZPWuEVNRYutbc4vQ?=
 =?us-ascii?Q?4QJQJtsyPJ/lE2U6MJLh4b/aSxw7J803BZnXzfF1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eab1099-a14d-4643-da13-08dbcbd412b0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:06:31.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/aAHtt5HMc7067q527stAAEtqTu7NkQjPU/xUK6b60vXbMtOXZGj6RUgnm1XWMQLo0ZZ+8nEcBc3yHfF5d7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9080
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create new endpoint name for the simulated broadcast sink that is
created when registering a broadcast source endpoint.
This removes the ambiguity when having registered a local
broadcast sink and fixes the situation when multiple remote
endpoints are created when discovering a broadcast source.

---
 profiles/audio/bap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fa5cf1f54..cdb84d4bd 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1053,6 +1053,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SOURCE:
 	case BT_BAP_BCAST_SINK:
+	case BT_BAP_SIMULATED_BCAST_SINK:
 		queue = data->bcast;
 		i = queue_length(data->bcast);
 		suffix = "bcast";
@@ -1075,6 +1076,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SINK:
+	case BT_BAP_SIMULATED_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
 		ep->base = new0(struct iovec, 1);
@@ -1266,6 +1268,9 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	DBG("lpac %p rpac %p", lpac, rpac);
 
+	if (bt_bap_pac_get_type(lpac) == BT_BAP_SIMULATED_BCAST_SINK)
+		return true;
+
 	ep = ep_register_bcast(user_data, lpac, rpac);
 	if (!ep) {
 		error("Unable to register endpoint for pac %p", rpac);
@@ -1792,7 +1797,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-
+	ep->io = io;
 	ep->data->listen_io = io;
 
 }
@@ -1958,12 +1963,8 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
-						pac_found_bcast, data);
-	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
-						pac_found_bcast, data);
+	bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
+				pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
-- 
2.39.2

