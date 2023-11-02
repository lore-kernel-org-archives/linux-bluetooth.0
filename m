Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78906C4167B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 15:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376943AbjKBP6q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjKBP6p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7112D
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbZIx/d0LNDjGjq1p7RhFML8AqWNMhZbuAuqytU/lyZSXsQM1GPaZzmCUiJ1ro+yWlOasrqfkIPJqhA0mVio8ifnesi5YKoOUMfrQF/DLWXzB22GUcUgw/2wmBtfRdCzCmxB5gq1eXNYLE5oH5AqLQ8S9wGFDPpK+wWwAcylybYiu+VVypGePpfs/xynfLPk+/7n4ka6DVrvT+UIyWzmAG/+AY96/sPOEFW/xvbg/xbB/QRRHvtcI8OUkn5mhni9tFdt7/DgBH+4/1AX4xEfTS9oUbxXY0QBzordXkPpDL5AQfVw5bk5fFFdL6uxCgQhk35gCRSj+qUZgV/lDlqgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi/ZSLXSrUXlK01jYrePfFEPvoRv24/Uft1lOdUvYOE=;
 b=PAIrKiFG+9k/WKfx5s+AtdZPPRb9qJ/I4u6W3ieVPOJHuC6oB4G+HvByBqe1Z5j3yOZUiQbyrMxV2kFTNDT6JU39VzII4eGpniKw7lkiWXdhM+QpL53JIQ8HS4HpOlSRFHje8Tb2GjJlnsTx0V1tG6/NfF0Yav8xsDQMyKJXaGcgtFl1vaLsK8t/PWmj0wO24uCsPj/zhJPWBHdhRWtay9Ozb1JFMx/MOiRqU7p8aK/smLS2OusvdaQJ1K8ML8xPXlKkZeXlMWh2RobvzKmVfK+PKBoUEIpqXG3H3M4toz3Ymj8hlCayn3ZJGif4QEZSVB1GrCwJvpi2dqN3937mWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi/ZSLXSrUXlK01jYrePfFEPvoRv24/Uft1lOdUvYOE=;
 b=dGaj2/QseDkanMHNmROj9HfCA9oSB7TTuHrRJyU5rJOcJgsrKYijUmXH93EkuYmt9Z+PiiUO9QB4ABRFki89rihoo3oBK91RbuYBW6UPJkeJoP3ZuUXl9hgqbV4IpspukZDMVg1+I4UIvaryeKu+aFKYvuLumd8xlkURiO2lr1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Thu, 2 Nov
 2023 15:58:36 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:58:36 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 2/5] bap: Fix source+sink endpoint registration
Date:   Thu,  2 Nov 2023 17:58:24 +0200
Message-Id: <20231102155827.4219-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:803:104::48) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b81032e-6785-4c76-112b-08dbdbbc92db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na3CSHfyVSSUjkIKZVH6JNDZJ7PJEx0WzXOxIAUZcMadSErM2YMIUgTSgJKTnUEq7ssAXZDmxIOd6nuHHTXpKXdsGPKLKp2HCF1H+dJExBVZRvlj+EsvP4c6BMkcziodC1h8IkzjeqQdRdB67XE6+2yNZp3xJQH93I4Q3gj7Mkqqx9NOxc6IiSfZlL5ptQvchRxvOJN2/YJNxxkdGEnSQkZ4HyXd5rG6W7Z2B1aOaaBVeODKEb5ItU2u+jC/vLr/6OK5K833rb5Ilh+hZw9/tdtK5caokcJXFHMtyzyQbniQlPVTGkTU3nU5ghWwDXoYI6/FYpvadx6hqYiXvN2FLhoEwUv3on0+qfHztmBLkW43tQwbzDeRtS06Res8OeOStZY/9EuC6fOgadhPaQMaOak9EYBBLD31uLGBqCP1KCuD+Ay9S9zNxgb7f8Lm3KO3yTzPBdZcRfWSy/8fv/+1iLrc8AzV420lQ4p3YjTvmQ2Y0SH4j1DCxv1DyYQFY+W/NcqPLIPJTUw8h88nkRlwBMWN3L0D7g9pXhT193FOFlJ0PkqRlvVHZwRDj3RIV7vC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6512007)(1076003)(478600001)(6506007)(83380400001)(6666004)(8936002)(8676002)(66946007)(41300700001)(5660300002)(66556008)(6486002)(2616005)(66476007)(6916009)(316002)(4326008)(38100700002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wwoRcsEC4UKXX4DdkUULeR2aejzfWCguU1k4NAfmUKdkKoG/EZDiYz+LtBnr?=
 =?us-ascii?Q?3asqi1CwDvqjbKkZ9VjNiZN7eK8ar/3CxJ02ZUcl9QmwzXWeotle8t4wixNx?=
 =?us-ascii?Q?2gUsX/aAkete223Nb3/p/ZUnK06arhoD4h4p3EPz7VsXScsJ+O/f82ocO4oQ?=
 =?us-ascii?Q?s9AcAuxPrY4qrlpynin6pMSISiFOXJ7WrYg/qWsWP39Edxs8eqUV0L37XphH?=
 =?us-ascii?Q?oHQ09hsODQsUl7Vs1FYHtZlMqMAzx5kOKkeBlspWuU6KRBuSj7yHOrN4Afq6?=
 =?us-ascii?Q?SsfUficGgQojPk5+rsjj5bPS0VkxYXh593/6HEUH/I0uwqTdMnYZtBu/I/d3?=
 =?us-ascii?Q?xSCNeNsf3ss89LO0/plUzAGN/n9mL4FPaLAFtQs7HB+2xQlM41vHbDVLraHB?=
 =?us-ascii?Q?adgjzNMSHU9rdSnTRCXBA/yUKMqQB5M5IjLIlTrmU2OV/ylH83BPcDaFwqAJ?=
 =?us-ascii?Q?TMi9oILoCTrjGDn2Fq7oslsZVWTFiA2EW7yuwYvRhzmpphQP+Eci2FNFMQUY?=
 =?us-ascii?Q?T0vv6JUCC4fNAta+PxSrfCcqDxKOhpQ1q4Ez+r8gk/RrRZQyarCPc/F39139?=
 =?us-ascii?Q?8d3zN9T7N/47BRScv+bdhiD5ZPLsknpjtHlS4c2UlTgxJQlsdvrpi6eDi4yz?=
 =?us-ascii?Q?dHCvto2hQRFZPIcjc4nNUyDKgqFWHuUB5O268FpGtinuKF9MMf6dZTQITh9e?=
 =?us-ascii?Q?3WHaL0Qd2yciTS44bTIMYoghSkCd+7VV/r7jRAh9+Hr53Lq84+Kdw6fhWiVn?=
 =?us-ascii?Q?17LoFO/HLmHtovKHS/33NnVCtGO7orL6GPvh9VKxJeYep6c6z1QInLaHWs7n?=
 =?us-ascii?Q?vv2w4H19JjVnyzVftNNP2LVQQ3GpsEVCKSBXFzjuuQOTXh4PsrnYCNAB/ga6?=
 =?us-ascii?Q?JxUnG+Qwtvw7gqgb/2I7vh+b5ctK3axJGkNIGM8fNDfC6svcSgNaduc/YlJR?=
 =?us-ascii?Q?uaTxcXr4xHf/NebId5sa3cfGr22aQDgcqepK0Vfq8HDI5Pdphfs3yhw0EsCa?=
 =?us-ascii?Q?2ltZZPLjQyL+XSxxykuLS+H9JOMUdQ9Qs2lq8nGLyol0R05e6QbJ/XK8c8ad?=
 =?us-ascii?Q?HY6gr4xjBmErHwAxUDqIvfWHH4GaqvGg3xg2cJyxck+RMUOZMUNj1Yg4XRy4?=
 =?us-ascii?Q?7qwfhQjEcjVVu9JswYMDVLfJZaTo3vhKYKMuasdK6bZL4AJ9irMuYAXg0Wy0?=
 =?us-ascii?Q?wp1OISJP49Vh1BGt0aboq1jcOlDxtzvHh2vFE3AwqtRgnXWlmIwNYjntHqPk?=
 =?us-ascii?Q?i14VqtOv/cA2WcV/yj/ajj+H+8ik/YHga37U60Vnfugjb5yyU12u8+JA9MMG?=
 =?us-ascii?Q?glz5N0PbN16Q38Jk3XsBw6SQTGyP1B8iAgYMQAg5oDYkv0A3MsFgmzAUpRkR?=
 =?us-ascii?Q?JpK88dUZhCZEa9GsLFtYqh+00b9dsYGtxaYls7EJ/tvU+qKNaoanpymnlSFL?=
 =?us-ascii?Q?E9nZfGCCIsM+okiZ5almKax9dREekv7Wndppf1hcYdhQTwikYkQ7MHv7ahfE?=
 =?us-ascii?Q?eGWxfb58sZ829nGL55aI9tyb36D+HlsoLnjLLvL2kncRhFM4qP30/2r4ZF/W?=
 =?us-ascii?Q?9tay5Pxf6NQrDPmqPg18MiJ1mnPNHGMkaCg+HZUDouznHvVWw3JucOpWdpJE?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b81032e-6785-4c76-112b-08dbdbbc92db
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:58:36.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ON8ZhLh05vSmlw80UOw5WAbB59Na407pQWEWY7INa/99xzyaxxraYycr2XSsaW2UlgQFmt/FKyAvzZM+L1KdiNxnmRiQdtzPhJ3ysHZs9MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Claudia Draghicescu <claudia.rosu@nxp.com>

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source

---
 profiles/audio/bap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b74498c4c..a84181e1a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1050,7 +1050,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
-	switch (bt_bap_pac_get_type(rpac)) {
+	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
 	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
@@ -1073,13 +1073,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	if (device)
 		ep->data->device = device;
 
-	switch (bt_bap_pac_get_type(rpac)) {
-	case BT_BAP_BCAST_SINK:
+	switch (bt_bap_pac_get_type(lpac)) {
+	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
 		ep->base = new0(struct iovec, 1);
 		break;
-	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
 		ep->base = new0(struct iovec, 1);
@@ -1101,7 +1101,10 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		ep_free(ep);
 		return NULL;
 	}
-	bt_bap_pac_set_user_data(rpac, ep->path);
+	if (rpac)
+		bt_bap_pac_set_user_data(rpac, ep->path);
+	else
+		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
@@ -1792,7 +1795,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-
+	ep->io = io;
 	ep->data->listen_io = io;
 
 }
@@ -1958,12 +1961,12 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
-						pac_found_bcast, data);
-	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
-						pac_found_bcast, data);
+	if (bt_bap_pac_bcast_is_local(data->bap, pac) &&
+		(bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE))
+		pac_found_bcast(pac, NULL, user_data);
+	else
+		bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
+					pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
-- 
2.39.2

