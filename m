Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34EE772B6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjJEQFa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbjJEQEI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDD261A7
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 05:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwN0vlX9SEsgl/cWZ8vzK+lzypFDH+z1EzlzlN1Ml5ovbDNh99dJtjkgUWsT4hdrPR2nyl2th967nvaNcuxpSqGPjZxYUjnvgi/dO5k/6bRnvmqTX0xMNbOc+qxU5Ec37jN8CsbKms+l5wwqNVVuqfMLfxwu1r7uKBB3CrDpd+jft+6/1D8qUJRWmoobQIRNJx2meRcUm5itfElXqYHX+2XqF6pISQxXME9+QEajfcl6OhsmESmuNAU/ED51r21rfv0iZKuuqWFxKZJE2ve4SG6NRiN/ZNgVAeDW/CDE/XX1ER8NJEKu3ktO8xhvBG7OR76oaAsZlX8tieo8pzBFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcoQ1J1Pf1OQUAK5JjmSR5ysmhT0O/avzIfiDMMI/5s=;
 b=UaxypCSYeWkctcEP28Xm1U9KYRamNZ6ncmNWlRT/XxfiqrOLJBYTPBel3NTU9j712KoaeBIinit+82sLDhZoCxcG8VkiTLOgeyW7U+fmiFERbMT2I9PL0dyEeCdTvgOFWuVsDCX44p8yexiP9LaGbOBtdjNsryGashphXVpyIS6CzSauz0Fj9cqAsTgLj9VYalWSSnR8UHNKebCG1tSJ0AhhP7w849C02ULC9g/BBWkE8Ic8jI0n3UDywE/ia4e+pFEK1FhnLO3o12Zp0tt1E7/Zj1uScAItTzNRcMulFJndoyWeakWaDhKPPtYuHUJ3Q9sD8XPSnEEPHBIMNaNPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcoQ1J1Pf1OQUAK5JjmSR5ysmhT0O/avzIfiDMMI/5s=;
 b=TyqEgWKdUBkpU+SWvrW7xI0zO5lFjs3JjhNbPrQiBzkOPvwhEesE3tMAa/IumRbLOEiqe2WwesUoTRUz/NHgd4RcVJdPQKnxWsJsPnfi6wA/Q5nrhJTM3Kf1SwVuVjwl0sUhxIVJ70BhqMlTxokRdNuiRpsAjnhE0OWhh1PO7xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 12:16:19 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 12:16:19 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v4 2/2] src/shared/micp.c :MICP-MICS implementation memory leak fix
Date:   Thu,  5 Oct 2023 15:15:44 +0300
Message-Id: <20231005121544.306495-3-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005121544.306495-1-mahesh.talewad@nxp.com>
References: <20231005121544.306495-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To AS1PR04MB9654.eurprd04.prod.outlook.com
 (2603:10a6:20b:476::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9654:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: a56c47dc-37d8-4936-7adf-08dbc59ce1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhougToV04BhcSjfllrKyJuCzYlUaJuvx3BGUoKuCWlgBUnXk7lwPwmCrkLw1gFw8iJOxi5aT2J42TVYcBLt5gnM6WJANdS0z8wbuWNXoMSFLo2nDn4PCmC6efn+ak9Eu/Dmw4u4ILm7guLNaNFGMlrR7nPtgg6wwwdxU2y+fsXF2/MSiem+F97BUU5+iRsVzs3RChJxol8ZEoWrL/UzEPztEYo1Spi0/Godmb768WMzNLE/erlduJXgHSskCOE0Xvnh5SBJtF/WeDvXyYgdl0XRSv8hOkRN9fErbCVJqzCa9URk+Hwe31HjER5sHWh7Zbp50z94xCBw3c69rvJa/InmXZA6qrbvyO86ojscS63q6XBb886UZ0rQ7w9rBACSgwpNbrpOhZpi8Y9TYHW+lqdnmrItM76lqZJ8k5QDA7/5RPNIu3HaysX8tW9wIOj0i3wpz6zhumEvkNaWO8yxrjBWEas7yPgCHL0LdbhYbOVAdPdA7Y2OhJLOCV7EULrFRIAB4qaRXNy1vp7M4mtpQrVpgPJKjP0OwmJ7VCZgPkVhsbLmW7N6t4beRTA9injGjEAClyGzbgqixU0os63/s1R0qABqkxPBK7Cx7sGSb/+Ux0MSbAyKCq7O1ClrOkeo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(6506007)(52116002)(55236004)(2616005)(478600001)(6486002)(26005)(1076003)(6512007)(2906002)(4744005)(41300700001)(66946007)(6916009)(44832011)(5660300002)(66556008)(8676002)(316002)(8936002)(4326008)(36756003)(86362001)(38100700002)(38350700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHs/uIgcJjzDBRHbJN2Zpdr/qBUAsbEU/Kh4qDaSNO1gT6/QR988J14B/mkt?=
 =?us-ascii?Q?WaZCexo42i8BwitPfYi5mHpcjA9HuxPVB3b8DHYpCHIwbWq8eVidfvffwTs9?=
 =?us-ascii?Q?hY159v8fLLjkveJdIScG0WE+ZgTuop7JPY39474JmzpQD8yhd9OciTGMNQuv?=
 =?us-ascii?Q?uNsAHQSKelthKLFwVeJ2bwGnh0JU+GHk5cVvHbYCjELMnBN8hHylg1m8Xx2W?=
 =?us-ascii?Q?zBKnb88nh99UzQIpordCpJnXuz/8jSm85JSNqtImz1EjQXnidMTSLUOas4Ab?=
 =?us-ascii?Q?dNIt1r2K/Yt+sSQh6pfMaLXftfeFRuOlXEGYbOVDVtE3iT4B/0DENTz68j2z?=
 =?us-ascii?Q?iJ5p+x0WwSKmuesHq1Q48RXB/ehuAoMUcXjZwyxBSC8ze2LRoEHu/Y6RpaYg?=
 =?us-ascii?Q?gem8XVwo8o216quup/bvRGZNrc2Z2vbgJ9LK4FIcPQ0yjuLLL0HGIjFPuT35?=
 =?us-ascii?Q?OeFj+cTiKXDPu8e576swxolOekWGroAmk3Pukja/aLm84cLfkh9uefF/Zkh4?=
 =?us-ascii?Q?i4qG/lJygrgGZmeaRUPDeuash0QRwQH4j2kPn/sFY24LIYj1JBN5pyh2FBHS?=
 =?us-ascii?Q?S4V2Wd9txzLYU8lixVwBKJDqF9OhmuskmVosr80R5aDA0Ab5fxfkNsE0IEai?=
 =?us-ascii?Q?RH65xfF85nhzAkwVGLB8AMDugXaT5PMOqZmdZ1K3ECZfv+gDzrCNC47uFmN9?=
 =?us-ascii?Q?Mt7bARAUBCD8PG0Su6/oAE3HXdtBtgrJGof8c3EgsSZJ4KItqimD7bTcOYr7?=
 =?us-ascii?Q?1R5QuWF5Rr+kMtP3zEEzkNWVCizNAYK5/Kp1kx5V3nPAxFqPdGCYpG16eUkG?=
 =?us-ascii?Q?aYKWb5nOUd3cFmIXkYSklOEZXuW/p8ro/7BhqAAedUjLNEbGxQ+8aDaNLPhq?=
 =?us-ascii?Q?jdq/cgWo2F3KPhJeFYu/sO2+favqKUQ+2ASHHogMkUlgeCmj6UjCrp34QUpi?=
 =?us-ascii?Q?HScG1pSg3OcQ9+eX7nMenog4t3rtFfgBqNyUPXdn+C8Uex92Pd22FUIgh8ON?=
 =?us-ascii?Q?NnjKNUuZMgeYsGPhVLoo4sHdpztii/lvLVfUnevxUwfWbkcVGxUiKzHI7+Wn?=
 =?us-ascii?Q?Avafo1RiCklZuxp6hO/pAqQebSmPV2h5goI9v7UriV09mY6EFdR0E+TElngW?=
 =?us-ascii?Q?dGpVTZPiPYqLnqqJgoMcr377Vr1NHNYSDCc9MX74MBHmrZkBQ4yzgJKTpXyy?=
 =?us-ascii?Q?sWzuXqvVbSQfwtq6R4hsaO8X5oC47+fMnnXdDopZvIBbVaLfEf6+Mu8OalVR?=
 =?us-ascii?Q?v6D6bDpyVAiENzG5oWjr6Sg+rEXahm3p0f4LFOONhDOiHuIOHnAR2jdjT4sH?=
 =?us-ascii?Q?J+dLHvHRyZURfH/0iEtwSL+jlXhRpDSWrhaWEMksI+b1vL9QDqyYZbH2bpqV?=
 =?us-ascii?Q?i4z3JSty5/B+HSS5EimWq1o+IalrGGjZkpx00qhH2I5HiBqTBpXLwpBA9H+W?=
 =?us-ascii?Q?fUyuy6r3mAc1Zs2YrZlvhqiVH6hti8grmTarwz/gCwJGrEce500s5hAxTDaS?=
 =?us-ascii?Q?qBAAltq/DI8G8aLjVCTavoErUO1BPzaXtUvoMUAGuc4vQa9Xtg0u80T4CFzJ?=
 =?us-ascii?Q?O/lgV3q9CsNez67WG6fnBtID1aAeUGFIv2gVIwfm/jZCqbWKul0NPaA7Qfi/?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c47dc-37d8-4936-7adf-08dbc59ce1ad
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:16:19.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZ0oBP1D5aP/1lb/lBKZTsFzQUT0ab/9o6QNyi/JocUcxwUec3KWlRRLmCKAXFtPziJQ4YmSV2QoKPvYrU6MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- Fixed memory leak issue
---
 src/shared/micp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/micp.c b/src/shared/micp.c
index 90d05b301..b82bd92de 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -138,6 +138,7 @@ void bt_micp_detach(struct bt_micp *micp)
 	if (!queue_remove(sessions, micp))
 		return;
 
+	bt_gatt_client_idle_unregister(micp->client, micp->idle_id);
 	bt_gatt_client_unref(micp->client);
 	micp->client = NULL;
 
@@ -175,6 +176,7 @@ static void micp_free(void *data)
 
 	micp_db_free(micp->rdb);
 
+	queue_destroy(micp->notify, free);
 	queue_destroy(micp->pending, NULL);
 	queue_destroy(micp->ready_cbs, micp_ready_free);
 
@@ -594,6 +596,7 @@ struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	micp->ldb = mdb;
 	micp->pending = queue_new();
 	micp->ready_cbs = queue_new();
+	micp->notify = queue_new();
 
 	if (!rdb)
 		goto done;
-- 
2.34.1

