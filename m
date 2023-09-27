Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5644BE80A93
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 06:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjI0GY6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjI0GY5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 02:24:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23897
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Sep 2023 23:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex878PhKw6kgF0i4g152+XnJ+To6UsFnfoeqdvqQFpMNKGEfEwwEp87IqUwNhPRxYsNWc1Mri5aU7BpNmTcQfaoMSsP9e82rnRbxFJee6gUG4VLH6lTW80+PeTAOmJxJvG7YgzOHUV7hJNCHkyDKx8vdggCehwOl5KJWjGxj+zrm/cEV45i0H10CUTq3dg0kSyOkF7hie/L5phsUR6Ueq4my94SiEpV9WaRZM+CGDsulb2YpsSvitPhBevWXOtaoPz8qaMZZOxcDVL4PCbaGKS2u9qqCgpIiu+uy2RZqLcQyFTaQrZGUVcsi9qbacHmssizcD1HmlivtkmXRYfKbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYw6UdbtKLdxsDAwX3AFPoBIQ9bUKsSLDb6kM86eQTc=;
 b=PjkV8S1hx1Mm7ltXvus39gzhii1TtGLw2Ox8Yqcck08zKfPqEin/Wy+lsMjIL9hHapvF1xFq9AoJceaCvMqXblsubTgacaJ5LLEmySuEURwvm07ecNrPXghFda7f69Jq8pUUuHSNimgCIVWRB+QyuqWDldIR3qTNv4x0e8C/+Bp8S8tEKaNNtFnd0gHCKD/p6Ha7W2brqDih9C9WUqqY3sw7DbyWm2HCT8jaxfZ3kFFFBsYiWlcU1qPFQp/14dNTu+J/tm1VuKSPV0JzL/OcedAa2S2iyPcBAJciGjXzGW+EpluqbEOnE4OWoDZcBvOwmeGHeC3Ikgj+Kb1DufAseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYw6UdbtKLdxsDAwX3AFPoBIQ9bUKsSLDb6kM86eQTc=;
 b=jcMGX2I1WojCdEETB+GQqDLNWbqp1AtGyhN8B5RNND2AvjVIbVnMYnyYBqQ0dTFYYUrGxlrHOYEs65XN/JUcXZz+6VA7VtE+IDf5yuX/df9PzBVt8awBCYJkCUshYhGJGL3pPd8hbF7giGJJE7PzLK2QwkU51wTIZOor3S2qDTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:24:53 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 06:24:53 +0000
From:   Andrei Istodorescu <andrei.istodorescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        iulia.tanasescu@nxp.com, luiz.dentz@gmail.com,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 2/2] shared/bap: Set stream lpac to NULL after removing the stream.
Date:   Wed, 27 Sep 2023 09:24:36 +0300
Message-Id: <20230927062436.6306-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927062436.6306-1-andrei.istodorescu@nxp.com>
References: <20230927062436.6306-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: afa51fbd-b43a-4f59-59c9-08dbbf227650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKK2WuOSkc9h4Hyx/j6hAjJBaEYl34vHO3cBW7Bv4ii2sZQ62eKXndOQ9tVP3YvpQoix99TFotbOtYBPy/FAprWSVsJrBS7ujZBNL/tliR24pd3ysOsBqDFnfJyH18maMREC8qQbmleFIeyFs+Sgu3vdo2cjeAemSOPa8hXsOKTKoe6Wjbn5amVy9GBi3zw8TkVjLWHfhff4Ks36qyPruGV/eAG0z9PpZE5PTZSbyX7IZfGTr6m0kGaVWiCFimKU68sM31Z1Qt9osh6z9tkRJMKoNAXiNoEmMaLRbba+9TqKkXlSrdPY43jEGDOGwg+1PY5GQcrw9GYzc964MUOxkkvuWHyi9nYDhxSqr0o0X1Aq8nZk6epMch8tYmqc1ms0ckKfkwedHEUdMxh7rzEJce8+uAPJrAWe0jRXDibykK95DqwdrjYGeqbrydze9jklapbHdfEwRQcQiFTp4E5HsxlRVeyzjTciHDVRYtCgDwosz1MxScM0ZzJg7nXLBfBKpraqRU+Q43Ww3J0rCWx/YGTvesIN368H5Y1sp8joEPVP+KZU518ULQhUsdhw84Zw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(4744005)(316002)(5660300002)(83380400001)(6916009)(41300700001)(44832011)(8676002)(8936002)(36756003)(2616005)(4326008)(66946007)(1076003)(6666004)(6486002)(6512007)(6506007)(66476007)(66556008)(26005)(86362001)(2906002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FEZQAX+LBCCqP6Qe70KLsRN7d6fKsAyQQa1uyGV2ATXe+eOsxxzclDu30CF?=
 =?us-ascii?Q?aXaZWRo8lX+VuETh5AxhUhHhRqtGbPZr0srLWxeaUQkDtMpkKewaLqjRtTf/?=
 =?us-ascii?Q?mLekjXHV8DqGBBDaLkw8S2pOBjE5egC6y0MWYhb3KiDB5WADtHa/HeEUo76H?=
 =?us-ascii?Q?BDuvmeUxL6ym1fusl361EGGrS80RgiX6TEswlKd8SJhD/MEWUdDOLNQ3oo3t?=
 =?us-ascii?Q?f4Kdbx0F+zWkRN82TS3qtuMM8KyhKpLhCYjdhGxTJZmCcKlLmbdnvc1MTj8a?=
 =?us-ascii?Q?lYEFxxGncDrlrOxYprKE5R76NmaLiaBN6nbkphr2zT6IVnpQT83JVdomoQYC?=
 =?us-ascii?Q?syZSP2lSM6lYtASs7r/qc8ip5neVtb6Nh0P+KgjZ/VQRetys7EDNd48+qMuC?=
 =?us-ascii?Q?f0UUm3YkIu2l5lk/TQCtcsPzqnyDtQq6nsPxnLWdq8zxmtmHGwGyKp+L+UQ4?=
 =?us-ascii?Q?t9GmUOow6zeF83gwmTcmESkvnB5L0aQvSsq1H7q6w9ofiZkWX9Mn957sEC03?=
 =?us-ascii?Q?c/jrTbD3x4z29ts0G1r70D5oPLkb+Y5ekf3caaaYdt4YtuGscGt4EJuEuaGH?=
 =?us-ascii?Q?tRw2EEjR5zYA2F49L60rKyxclst21qAxOtVIOyp/S+7kRhSm7DJlTUgws8zT?=
 =?us-ascii?Q?pxDQkjlu2ym3j49LV6Y6PeOW5A7e9qlJ4Sf27oE2gDKtF4imKzkBfnY7E/R3?=
 =?us-ascii?Q?b+0oXHzPEL9wEHeIbcw59LBVtKZkuUSSJlpmXrz9ykPztF0dse80UEdPQekJ?=
 =?us-ascii?Q?1Jo+L9uyCMd8MIshH3qqfQA1TzrEBLysxp3IWlfM5e2ac3ezQKHXQ9MRyaun?=
 =?us-ascii?Q?9gnK5a2sVrzulp+EDubS3ojxedjeKx3oF9++v+6vbuOToi5KMWp4LBj/qXVT?=
 =?us-ascii?Q?C+u518iBr2pZt3+WcowBF/v6s0OD3kv55d9ATkGir5TYdzH2LYEls3Lt2U/C?=
 =?us-ascii?Q?0MUn4wB0lkz3urYFINPTjRvdLIDRg931yptRmgFK08Y5Ve17nCvJ8+slsRjI?=
 =?us-ascii?Q?LrTfesE2CEwBMALI0qmKKCOQB37lraIqQU+1WoqIPl54pCDhn/gpVdmi44NE?=
 =?us-ascii?Q?jsJAAner1khsp1/babvEIyW9hfp2nzf+gvClR71Ls2Vs5fUgJKTrvJQ6cmLS?=
 =?us-ascii?Q?sy2zhMRj4mx0YI24rFHZ1fsHuUsLiNsyzTYOJsXvZXduL98/2p/6O8Wk00Pd?=
 =?us-ascii?Q?2F21BxeHpc4HLnIl65WKhV5743iZnJLBsJsPowdYn8MzbvCVzvwfY5lbXNN2?=
 =?us-ascii?Q?fADFqZTk5TS/ulE09PjPMI1jyGjQOO//WuL2Uv4wqSqSNeRJJQQyxTV7XBdX?=
 =?us-ascii?Q?G0v9C0Wx9knicC6CSFnokVAVRF8BFwJVt5hJKMlOU+JeUCeKQm/ENl1ZGoxU?=
 =?us-ascii?Q?sVh06Kt+J/TH00xyB6q3BmxVqJSFl+GqXu5A4ILQk181h2MNW0yWKHWI08xr?=
 =?us-ascii?Q?l8OZHwEYBi91AgmtExaB/801/xiL+Sm1ommIujAJ9pndfuXvYRnRTqjqKOyp?=
 =?us-ascii?Q?zL2LYv+Si12T7bsmffhweIngV2+PqFJQWWcMI4ZA3vfr9wret9Mv5tsdrNFP?=
 =?us-ascii?Q?r0DRT72X2WuDPv/Rym7FsEp623eouiUb1bqTWEIKHhciZMlcSxUJujmCGfQ3?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa51fbd-b43a-4f59-59c9-08dbbf227650
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:24:53.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcT8WJNAo9+FDuQ3hzUOdvQ2IKhXmix27b1PQYN1ok2S8uHktxV0zeyKeXyylIAU+gtTuRQQkZZ1QH0tAYa3kKdiJMG0JWTithdlWrxmLn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is required as the pac is freed in another place and will result
in a dangling pointer.
---
 src/shared/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1c43680c2457..a0f0135eb135 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2681,8 +2681,10 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;

 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	if (stream) {
+		stream->lpac = NULL; /* mark stream->lpac to NULL, as it will be freed in bt_bap_remove_pac  */
 		bt_bap_stream_release(stream, NULL, NULL);
+	}
 }

 bool bt_bap_remove_pac(struct bt_bap_pac *pac)
--
2.39.2

