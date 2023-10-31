Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D6C4167D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 15:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbjJaPz4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjJaPzz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 11:55:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE598
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 08:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNbjt+tMWlwDUwlS0ndyv4sLL5TK+r46hJL77ryj3DCFiHCGC06js8zvNApwFoSK5LQVdQxF8DXZnI67A1GlHCLmTiA/zcxxhsZRVXw2tTt6Nfm7lfeTb+GyOMPuUuRQKi3J6fsXYFHo3VCJteuJ62dJfWmDV2g/wPgokH1ZtKPecEP4Ku0PrGZ14GFSD9hAu0XEh6O9OVDC/MMY5hR4RWhvyloDC1xcDXkZQOVcR3g2SOyQh/mPxoQeAMGbbFjeLHLfLBZWE0PMk/zgLHJ1rL05aXoRbP+8jN6Jzr7ZQyV3BrhCjECyi+tx1ytYpp3b3PIIj8ra/5ADhdeGfLFdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi/ZSLXSrUXlK01jYrePfFEPvoRv24/Uft1lOdUvYOE=;
 b=P2QMngOKtZ+XtFmUtpQX2R/iHAP3OKrvy3mQoclYMSeWhZH/x5s+bmR2mTRMMbSG+RNWIOmUTnz9tPPOqcXI6tU1i+lN15YUgIW+Qyr/ey3lOuZIw0pQ02YeyJEcT5b6/nHX7PVSGx78qmxMig2P1ybr2+vpX8mLdQEu2t4WjiQjTloWYXQLdHG0WlT07+TlE5UetCp6nYdgSDV6g/emL1TIe9xESkA0HrZYNbz2Rf2EdO2Q8szakSQywoETve0LvqCVS+7qMqOxGcTcw0tr1f6QVoeEcPcjmjfiAXmFNEpOvX057LN4tPM90v/PeSrzEmm/Ie9jFepgD7eGJQMcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi/ZSLXSrUXlK01jYrePfFEPvoRv24/Uft1lOdUvYOE=;
 b=hw3uShMJZu7YWqoZqyoxdpnEnaPx1MuIVL+NFdTUfwQVCvvCjmYYXPFTLC1oerjxpHpL9zt/iMn7VNA9WcJCEJsyagWcS7LtS6Y+M4O37vq1yYr2Dv7DS6ymz2+gOPSRPo16aze614IyT+HU0n1RokYqSv1+1kCluJOvLU19iFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by VE1PR04MB7440.eurprd04.prod.outlook.com (2603:10a6:800:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 15:55:48 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Tue, 31 Oct 2023
 15:55:47 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v2 2/5] bap: Fix source+sink endpoint registration
Date:   Tue, 31 Oct 2023 17:55:32 +0200
Message-Id: <20231031155535.228994-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
References: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0150.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::34) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|VE1PR04MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1a9f8f-a71c-463f-8fc5-08dbda29d92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWEiOp1vug3eWSlKbqbgIVniZkrjyBYxlBMTykhbRbUiXBmIXzvBufQJaZoYcbZBy7OgkdUj+1VjAiaWvoJ+4xqwWCmPIfMdIicBUnOoz+WyiCBzjv1mRzD0pLJNbkKWjbkdvH32XqKyvoX3th+wO8Kb+VYLhtH2SCYn7ovVti6JYginrA2kvcR24Nzh72iAxYBDQziROybdTM4jJq6R0Mju8ZsQLUZ34lomdsW8grBvASJOXqTzEebTJo46HR8D6f5UvMvVBVoi8N5vLcVsHFAHr9JkWxFePpfIJZQy2VoRQfsWg127iq/ADHES4dq5PDuGboscAu7DDzLHKzGhnQ1O62h7SSY3yBoRrc3FK3bY+Eul5Dhy7018V+eHCmk4eWjnV+6UJ6sbfV8SSWpwaw5/nGxeMBExIFciEhNV8zqD0P0FyTIVYjEIcS+4M1/KAywyTxv8hGGRYLEiDosOMpxnU2DyoEKsNaZ2SZlQYCJwfVdQOAYi9BVjm3zDZ9cMdRUKBLy3VEeZuK/WxYrjnF+DtoKWsblN2YI4vyxmj+rcrpZnftcLbbRCeIvr6I8t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(8676002)(4326008)(8936002)(83380400001)(5660300002)(41300700001)(38100700002)(6486002)(478600001)(6506007)(36756003)(2906002)(6512007)(86362001)(6666004)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?963wjS3M8FnpRuLBJBgnzbDG645Z0LSSAzfOAN8M5IU69r0T0oYW8iGzfI35?=
 =?us-ascii?Q?/vxwVfQZb7BE8/76+8jArK7uqFgqhPsXAm81DUgc+MZFXlPo1rpgGVEPmS1/?=
 =?us-ascii?Q?R6qV79gY5YAGAFrZPRBgaGdU1fDun8SiYurbOF+aiq/rptqU3gTE4I7Fn9nX?=
 =?us-ascii?Q?F0GndCwh4VlsfGwunxa06CA42HOoh7LGlpA2Ww4nQB57b6i66Ic1iHRv7w5m?=
 =?us-ascii?Q?IinFuLA1cd7Lp54btLd5tDCpWY/Xk4xu0RGXMv7DmyW8dJFg3CRyY1GIoFz0?=
 =?us-ascii?Q?T50wOF949/XhKdUmaPTo40LeTidz30qqHtCWDh8EVUu/PuMN0F9WIMdgHMmV?=
 =?us-ascii?Q?o6gyEey4Hq3+koMgdkmHFAuPntRVFxkDISbpPpOrv/MZlTa+0h6zLg7ZDOQ0?=
 =?us-ascii?Q?zm48AJ98pn3tgFDEhEeQg1ocnDbpH79TzuMZvvcTVG4CBiDCjAUxjs4LZx5B?=
 =?us-ascii?Q?4VEGmo8E+NdB9VDc+ae//cI98eaFDuhTCseHVahb7PkQh6b+4Oh88Usob1LG?=
 =?us-ascii?Q?/bxTIk93Wrl0B8iWikJ2rofxlsXNasGweHwVL9NTjqSvf+9SBHs7qP1aYYyM?=
 =?us-ascii?Q?B9TJS5ilwbZNpWmVNIZ35kMZ9zcTDRPpZ8r5lvXdek+sJvnAWS6y4oCBCrkR?=
 =?us-ascii?Q?FPhp88XlvxdSdskahFFvcdHxYlckcj0fKZuxZgO4PIoeQWD+0sxYrebeZA8B?=
 =?us-ascii?Q?rV0QjbG/BWo3hg5t6XUw6OEKgPdYO2yADpdHgStCS6vytR/mAkgLxVcgNhon?=
 =?us-ascii?Q?Ui9ZIjjnNadm3kawW81YMbu1pui/CyGkAF2/74UFaQSOuBvCx71k9QgIeVVH?=
 =?us-ascii?Q?eTe0uE0MpjTVeLX/roBPHUkZGpw/vcdF4IXfZNR3GJrbFjt1m+T1fXBaMf9z?=
 =?us-ascii?Q?IlFtafVnzbDu5hw3BY63vbtVRSspXP7RVippbml8b2eYasyhPDi+xKQMtENG?=
 =?us-ascii?Q?19rnKqNnAqocYaAXNzZAumMJkWY/0h2bHat0Ce8jwGH2BgrENuGtNkYH3kVW?=
 =?us-ascii?Q?QzDVfuzLIasZtmQ9wcGHXTdsxwmNwCRSshJuF8f5k+jJ6YQAnKUuC6fOu0nk?=
 =?us-ascii?Q?0Ux4iTMKTdedrc17Wfx7arpq8EyC1JHp8rgNgkiUyZYnQpUep7w4Mnh2Kd+V?=
 =?us-ascii?Q?VmqsA/hU7pnfpPsPDaZiWEWK/w3D7u6N3Ldqm4stUVLOsL4aigQRqP4ZQt4r?=
 =?us-ascii?Q?yAPIq6I+ROx9MkDHB6+S05L53aBZgYpUeGHEijAs+MEmZ80QBw22OYX2NuIg?=
 =?us-ascii?Q?amnB6WdowqeInr4U9INH6/IFIw2FUjKeawZhFc16C1aMoeY3Rbvu3pxe5jMc?=
 =?us-ascii?Q?4JW7XUNQ1FA3cjFULhCfWSHQtejgklgXQpePjQGe02cnRXEjU3rOEBPowJdr?=
 =?us-ascii?Q?hZfN+VAoAVjORuHGFZtti8UDTFNR1SCzU3IKOflOGzdwhFe8IGmiHt7aGRtV?=
 =?us-ascii?Q?Lf7Xg0H7Atd6BChDDusIWILzje2RTSOnDrA066YlVTekWcf0kj986aEQirqa?=
 =?us-ascii?Q?HLbYZ2u2fxsMfy4QK5WBMMNtslvgTywpNCvEWSWhmV3iwAgP8iC1kGQt21pR?=
 =?us-ascii?Q?B9s79XBkbgTv6pnSHRzLerN2CmI+FJNt66Otn1yA9sW3+0/P3I2qZHPFK9AG?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1a9f8f-a71c-463f-8fc5-08dbda29d92d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:55:47.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o14Msj4BPrv03sU8YVhGzNObR2PY7qsLYWUh+FJzuxdSXGXul1UcTeG9pe1IWh61uLaPaD9w717/kQQ9s0o/zVZ9zDp1jW7axfpI1vto2Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7440
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

