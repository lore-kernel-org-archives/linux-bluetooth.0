Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68ACDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbjJSNzO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbjJSNzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 09:55:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC9F126
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 06:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKCo9MvuE0dI/SOoglJGScmq2XCYLU9bYss4FFYntff0MmEuPxmDfaGbOJo7ayd7OKY22LZQdzLaIvq5gVHYRmetUZPwbMhMtn9f96mYzLiqlskDSvrgAD7nsA4zShnWnicd+ZcGfinj+lBUz9ecQ2hnnR7jDZ0OV9wQOiwddlW9fqQYjZc/Hh5PZ6+aORdkdhkZqM4Y/nlzG571MlKaZR+JSrhFZ5XcE8Xxy01P+nhqapKhBqE22sAypShBoyhIFzEgLhgsWUS47nM+4SSZY16892CODBBo4/Ofxt6VlPQyCt3zneFL+BFcMzNKVMF0mxikI8jNE/4auDOQ2q9R3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kjsD1vOTh0altlAkNDVKrmlHhcG6I81LAavcyKDZqg=;
 b=LQolhFmz29L/Wk4Dams+EDr0y7qdRq//bGXUAiz/+C3pGulpLwke54iBWcbXc5auyHFlfxGm9IsNb8whszZA/Q+XAzUmWbGeDcboa/NwHuNCLrAu5S8bj5s7cROPUmMMxu8ixaLFn8RLa00xkbOl9ydPgkpijwFVwWHZTEGqpUMVZAtez9edyodFHCm2DLwfejDvpIvfhupWMbsgi9Dvi0oN1+u91n3Psx5SzU2PzURGHZvHsSNgCgg/0CQFDnwmpO4zCXEJigIyNL/cDcpGKL8aXNDNk6efsXJ3r3kGUe+bGo8LLRACQKU1c0YTbQ8ShaPUPYEOi1vXPPv33dXJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kjsD1vOTh0altlAkNDVKrmlHhcG6I81LAavcyKDZqg=;
 b=Y5fGIR+IAAWRUDlb84r6irroih/lcfyaTb4tNhP6mWgcPsRi4VdT707bU9gCc+PmFLufPuWiV6iEDBVGJ+P4xF/TatzC+uwDdd5LbJSOVV15tnb8Gw7SvEAON4pQtONAIjqbUOIvuZFYqyzjWILpuHP/Lm9X2pxw0oSGc1SAmyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 13:55:05 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 13:55:05 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 2/2] bap: Fix source+sink endpoint registration
Date:   Thu, 19 Oct 2023 16:54:43 +0300
Message-Id: <20231019135443.3806-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019135443.3806-1-claudia.rosu@nxp.com>
References: <20231019135443.3806-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 014b260c-4ec1-4303-9ea2-08dbd0aaff73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWUOITTWEHAl1IoRfzZqvnBNcFrClkiJJs7fqKb1hZfsq6wcXCdhvbpYkF9h9y9Id9On84uEIQV3mRLBP9oJKorcB06dKfsiTDNg4VhqEz7cKvCy1T1NyYMXt9vtM+dGwNAFvVrUOEJ4hv9rHAYA35bZH6VMdMYyVjFaj5LamDe3oF1LRcvVxDx07iUrelz5QMx6ndOgpMQdSI4i60F1LLoZPtVY6N11x4UIiw/qodaQZ79LRq5zGKNF2+Np0/LojZcOYW5OaEPJ3LPYkHHt5HTVKDQSTh0K5Z1ogObPLDRWQtOXUHKALz+kIgDYjKXUyNmdhiF5h+iAd0oRCoAjV/jh232+KmnhycxlckXdBsQANtB1WxbeV4k0EC2CW1pJ7SaFKkqTfDEYeMzznCEh19g9PqdanGKyKZtZhhC2V5HjXXfUXpBjPTXL+oX4gIhYmEkz66n178hg7LEfGeKFOE/cnlQpBLf7Js9YCr66Ae56csdVI0rVbRutiLiat7wlfSOdDSzgv5qx1l+LC1k50AygY6TuRP81xWx5WjLhkuXgmfpaSrFfk4jc2shIGCgK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(26005)(2616005)(1076003)(2906002)(5660300002)(8676002)(8936002)(4326008)(36756003)(86362001)(6506007)(6666004)(6512007)(6486002)(6916009)(41300700001)(316002)(66946007)(66476007)(66556008)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kvKYmbf0mP23XigH42l8DNMLlAejtn+TTsYr0raU8OE4vKvkseKWpN/MA59n?=
 =?us-ascii?Q?H+5xlxVtzp8neqkMkJ/lqp73MLrua7BKDV/Ax+ZR8IyaMjIti5fAIYD3XTbn?=
 =?us-ascii?Q?a2zKjBAQS23ZyfSLFJajsxmH+6BO6Ot+PUagbpHCb4Qg6PB6d6VUS4Jll5bv?=
 =?us-ascii?Q?0LBMI28pfFK2zf5S2+AKRSl6F3clkWpbcvMlMC5XAc4qVNYi+B4mdDha09Wm?=
 =?us-ascii?Q?8te30g3ehDNYybhCmNreEYy7GqHR/ZAp19mJJ+vosD5cq48aB1tJnY27lKRo?=
 =?us-ascii?Q?tuIBLlhCaJ1b+FqS/fYmA+y4QdLYk/KkoYITJ6iQYhqyCVWyvTMK5RPTX1fR?=
 =?us-ascii?Q?FIJXVQSpZ0+sgF+CA2QPaW7X1zw5g5xQ2nGMbayXDF+s4Y35LVt89WFc2Qd+?=
 =?us-ascii?Q?sEqp4iMJKwrCZm4p/TYPV4GNDF6+F6VqVP+TB6m/MhrPMgyDU+IKp4JWoO7H?=
 =?us-ascii?Q?Yg5DWsXXvZLhitg8efcRnoi6Y86ahXVuyVtMV9ZcHBBMWgduFW3JBWuY8z9y?=
 =?us-ascii?Q?nwCpHm8mKWOrCQPZFc8XsyyN54ISOLKU+D/C7xR/1ff3T5/dsHhsU62YCGxN?=
 =?us-ascii?Q?pSRM8wSgRM0DE1Re7PEvi97aEZ7BUz9tyR7XkknzGYxdtnY5n6azLejbJm/z?=
 =?us-ascii?Q?g/mGxxfdEFzgL1/KYuLsAOb7aA9PZGoTexKHPf0UXTOG2ej5+qcWYm1c3+gx?=
 =?us-ascii?Q?d5kU+7b4kdq1+mHso0wlDSDBhFAo+IDnDcKSIovp4eH0Q1G4PPDYutjLdjoH?=
 =?us-ascii?Q?LDIb0ZU1bZahIVdo9SFjuT3Wg0QxugqbcJbnZip6LtvHdOjcni/oMfHGQ6H1?=
 =?us-ascii?Q?GGbIOb6rYJTrGIwAcl+DJo+GOLVtZtKZtNh8VG0Si56zrqmXLyOWYGLU1ZNI?=
 =?us-ascii?Q?2XbAjF3uVH5bc/hq33AoMQhvV9T5sm1TCx92v/DOooG46OZK1cdb16dSK/zd?=
 =?us-ascii?Q?mGyr1dDDR1VlG7xsg8Eo50FSlDcRsTpZFNZrhY+FEveAVPfr+KWu+5P6arSI?=
 =?us-ascii?Q?jrBWysxe5G8/+EeV/FnFHF0M88BOxI0jgzKvWMgnKrC+yrCiNSfl78wZyqDP?=
 =?us-ascii?Q?yDsplPu8fU6fsWQiboYJpPKuTKRamcO5P5X4fqek3Ad7V3wE52op4NtCS+CW?=
 =?us-ascii?Q?CcaJDH/TtvHmlMuGEhModSvcleKbI1gaItFizcIsrzPRBc6Pz2se4CdmrFJb?=
 =?us-ascii?Q?fw8dHrF5BWzyt3/rNfNNjbBGUh23SOHUGw/sk6iZjIMGCvPfKrHr7rYXX6UM?=
 =?us-ascii?Q?eVMAwECxsqrasMeyu9nNW0t2e23oTchrkg5grzLnPCwwrYuxsTNx5eloAmVg?=
 =?us-ascii?Q?NMZLccFkKuT0QozqhyOTsQcyzIR/DPwOcUgQARJYYu7QaYH2TG1prh+l2JNJ?=
 =?us-ascii?Q?lXGKpv2hbEMeQm01ERQF43ZAXrnVSb6u/Vprt151u2hXsRrD6QE15q/Aay3N?=
 =?us-ascii?Q?c5tpcOykyPySiNWvNV2Em4UsP+29Z2Po7UWVVXkVJzXJMYqxPECmmGDZhJDo?=
 =?us-ascii?Q?EgQBoAY2+GEi3+y7GGQ8hWbMQICHTfCEfQQhuLdSysRbZAvDtQNo/GeLbbh/?=
 =?us-ascii?Q?Yx+ubLQ4Jn6r0XtSzG33VKUN2LtKfoaivnipWVSX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014b260c-4ec1-4303-9ea2-08dbd0aaff73
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:55:05.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/M7bpUdTq1+RLVpi9X8dl/+oxo0ksxqwZRlIItAPTT0y0N9k4ohSovKdwCijmJf/vD2e7JacOpt/tTIkvbE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix the case when registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints
for each scanned broadcast source.
Remove the need of a remote pac when creating a broadcast stream.

---
 profiles/audio/bap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fa5cf1f54..be30d0efd 100644
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

