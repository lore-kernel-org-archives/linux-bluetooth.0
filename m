Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E76C25B48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbjJZOvL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJZOvJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998A1A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CImvOEWWgxAvFNWA4MnSszfCCUKW2E55DResBIufzpqdYCbjCtO8DsIjfGGsKIR8v5v8DDvu8up5MXQTHws6Jo2ik4+ZexurpfSKt4iwmnW+iVZr0fcppbVJpkXi1acyh6pwHBPAXZzTDRCZygCZo0+VVH6yRm9Cb1smCf2ebc+rBKRmuhehg96yG6CEDy06eGCpAGaYKOnU6pz9Yhc8gBmH3VqVHJutMbRBzxTVzgmZaxqHkldR2g8A9LX8hbHBC4GjB2PdT7Myzpe9paAX8fQo4Jt8BS3TVL4GSOSg5lgWYSzc4v9XFRanm0BbH2cqTHwUV3sJ8Y/rF0wFP8yOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3D1XnVnDTa6VLUTi8bbSA6go8Lr5EG6/FNSP2AvqOg=;
 b=mM6kZ66D57fBqwvImekiqOcxDIqcHh3r8frMHtWUBWHgWJNYQ+b6/tUtN+MEVsCMOVe+PgBSmoC1xI2x7xDhiq4qFPXFEPQDnwLKkZR5dAdzkOymDL/ogxkczMMm5A9FE+H7ZKMoO0Mir+ja/9TZ7ZVSiYhSwdgxrZe6FrALAvyDAAyzJOEKWokJZ5xDrcIlYdgyrZNVIEW+Ro55K6Hc8lvaq2OMl46M+P/WPVvD2SpOfcsKgPBEFI/OYv+3SWsczZsBOEYtMOkqTr9yoUtCFGhg+nsk7RSuurveXsvyEwPTgdJEpnMdSObqrOJ1POBXpfXEB7tA/z1qggiIkiNv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3D1XnVnDTa6VLUTi8bbSA6go8Lr5EG6/FNSP2AvqOg=;
 b=mzWiXWi6PYwM7zwJc9q6uSfhuMjud4IBWvcZxJIW9GB2nhlUmQVqKQmED3Kz5CBJrhM2I7Mi4k+t27ZKkkR++CLf8OQn0UiBSfKsksbgnO7DnAsxxGllP087GYg8/sXcl/ct9A5S7fT5ARDLSv/PNALV/lyfBCFJ98E7EeR98pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:51:04 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:51:04 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 2/6] bap: Fix source+sink endpoint registration
Date:   Thu, 26 Oct 2023 17:50:43 +0300
Message-Id: <20231026145047.4637-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 8675c23c-e4b3-4612-2fa4-08dbd632faa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRrC+ehfMUFy6hGJZOtHDlR8YmS+KJYax4PkYKGMzwxzIdC2NjoM7niqzomTRgO9fjKnZvRYc7Bm1R8fEfLfpkvsGAvwOmnCfB4eqe00e2XAI9xmiPFm3GEPSr6ajQzWZRXGOa7oO8rAuXVFJF9WbT7XM1JxSjCBz6cthLCCRur1r7FCRsypELOpJ9fIdhaqQAk7xvGU5EENGxjfqqsLn1Ja5dF+zs+6UUM/DMaHctTfPQpPfYZBvzu43Umji/qhRrqz3/d2FmrV1nvQ5AArkG/vOp1w87d47bYryVeTiBisbGexBv55Hewe+PYd0RKGuAQ+QHc5I/q7FE3b4zC6I9iX611toqFHo1+CbFDrQUR737/sOPToWQBypDzSoxyeie8rRLMMPjR4awsS66eov8Vu3VEOH9zeKC4c+gMYyZLAyafzUd5JJ6d6Fyyh/RBGb58SteEjgkJd9KUXieL/aH5lCDCOvuzTBij2jSor1z0rrIbq0W86UyYC0l0AHKxbTxDyE1MYioqjfqLWYAFJJRzXpp2IQpnGIvfyjibTLL12GuKVQElRtfcDM1oY1sv2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(5660300002)(2616005)(83380400001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJe0GP0WkCPUklWK95yjbaggKnZ9ZuZDKr+KWrgoHhHyCGMiOcgb7bxAbQf/?=
 =?us-ascii?Q?cQ4bfJUivL93oIeZTkAAur9yK2089t7eAcQIddiT8C6N8Ojuib4XLT2DKvCX?=
 =?us-ascii?Q?5p8giiWocxM25Y5+ErXsJS686sPLK06kQ3TI6c/Egbe6A72LGnR+eQzvAlnm?=
 =?us-ascii?Q?PpeDK8f45tCd/OvUwqeSfvkB7COBB1/j8iMM+WArGrku6XXh1i1dW701ndDd?=
 =?us-ascii?Q?q23PqoCgAJsMRKAYjAcZsI0MbMDXvWszCZx4cyEFo2Ht43zGeYkTj7ipb0bM?=
 =?us-ascii?Q?I/lUWyRYe0PC37/4DzpegSf4YrV7TEwqRews+jkKjfzjofChbhaP4Te5OOqg?=
 =?us-ascii?Q?lItopfmNq3ynik0Mxu1afHS08GTOqTNNFZ0/ZyXMKVL3tpmhqj661dUCgj+x?=
 =?us-ascii?Q?t6FGyPOyGdXuZRZvP28wOedBFUnSJr9FtGzaDGUKDSz2rFrpl0X6iDYvjRax?=
 =?us-ascii?Q?ujihQ8vDZL9d2FXiXA/K8FchGUy/zysPS2JT/ro3uK3XbirH184x4yZPL+HA?=
 =?us-ascii?Q?YkRGhO5h/Y6nkmj6gNeWtWysclG1HUMmEP954YgimXTBMC2DDs5N5ZK5trtE?=
 =?us-ascii?Q?N+Tkl0GV8JawAQAIirB09f1njnou0y94VfZlVerfKGDxk5qTG48wh07tfZuU?=
 =?us-ascii?Q?EUcMNr88QQLR3l74aGuIgEKz2hXcniCqkWMb0nKGzMht0Vf5Fduct5Hzq2ZX?=
 =?us-ascii?Q?nlQzPBHAMvYD882f1odX7+Y4yThlC+tYr2DN/nDp2razjkGn9MC7u7OkJojB?=
 =?us-ascii?Q?Xfzu1R4KRjQYelbRLk6o/cms2CY54W5ZkAxqsfZ2WZqAtf+c3n615SALJh2T?=
 =?us-ascii?Q?xXcd4aSUHRbBprgYgsRwH0fHYFBCfgjC/A1MFCektvHoQfdEIe+C2vyaHdwC?=
 =?us-ascii?Q?mvmm5EPozwkbS40589lDUHFIK6fZBbe1qkOJ7NT+odXf8yaB+eS6Wtk3bcfC?=
 =?us-ascii?Q?rqlOVbL/MUrGSVJ6Rse6cVmOj037C88xakJM2pis34bmK+BeCU4WX7qq2jq3?=
 =?us-ascii?Q?1O/8j154hbSB7CJjRR+LOdl/M+gigyQDFunpAIcnv/+V+i6cVvCFCX6kwswa?=
 =?us-ascii?Q?E4Zpxrp1Uw0CJvsFEDOXAeKQ5lrpGyEkxSieff7g/W4YLGygvkTsxE8hAPQ2?=
 =?us-ascii?Q?LkHFySd/ikYSF87BVBewMY7abLJi8zPuhXkaAmEwLYDD8m7BHIUq6nCz8BGu?=
 =?us-ascii?Q?8OpBKi3m6op47H3O4scD82i9hMuEc4yV9dKCTvi0FnR7TKiS+8CG83FgRvyn?=
 =?us-ascii?Q?DHOtnEkfiIjuOTGUkGtXrFGZ5RLjWYBpHunMcVY+ZvnrhqHl2voLaOwaX3Us?=
 =?us-ascii?Q?m9e35iVMIyuSp6D4+KBqbrWfx2zMvOfAsC1Sz7W74vhoVkC2he/JBnO/xWt1?=
 =?us-ascii?Q?ER1L7HH+jBQ4PRAWtulLfl6SPbyqxnU3z1G44TdEq6pyXnJINsNMXiCTcOZO?=
 =?us-ascii?Q?iSwxhklCBuYHgkxlJXgGFlkwSRT903Meo8AUgMGDLuUgZVg16ZSctnruqLaM?=
 =?us-ascii?Q?c7ACLF9VRUEt+uSi5QemF0bTojrB3vtrdXb8JEiGcWCnX4EvxK8ViPy78W9y?=
 =?us-ascii?Q?H5uajfU1Mb68G35Sf5OuUdKLR1ta8QFmjcgBJDzsgl2KZmDOIui1fKij3U1z?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8675c23c-e4b3-4612-2fa4-08dbd632faa5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:51:04.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlwkjxzrHQH/2F3Lp/jDMsyKPk9c92pak8g4qgyZiC9xTTrPM0f5mI/Z34G5ug39z2OYIFWLI2q4yiEecaILKJsEOMY7EJiNnl+GWukWGj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
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

