Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C6C7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjEWOgL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjEWOgJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 10:36:09 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04F119
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 07:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyOmi1L/2CDX1IVDiDq6SZNMTSflGj3hNoEmIFlLeFzIRETzvN+ojcgp7cLOq5EjbmriSjOZqOWr+6lgXeep9ALTeuvgDC3FF4idnx+yH52IUQhY0/abzl5qZqVXe2Own6WyHbxksW2j+zX2Bov2L7Yg8U08UBREolUJ6YgcxxTE7TUb6pvxe58pe6v1eGxbqvqXNp43s+hq+16uxWOvGlhDnp0ocTIAgHy5KaGBXF/EthiwtB9N8Wx72BoCfhk0OY01H0RFieH+7fCtnE2uWTuRRkNVYzjrKHZEcpwsWsmI6Cp/l9DoH2aufhITpVicwJefhvQUcys1zVQbicDH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VfvP4QPx7KSf+om0h/JfWsoEw3fAiZcld8I0nZm08c=;
 b=RtbP25oY9pLIRj+cy4lmFWjgQAhHwBLZKhN1DvSVgX1F0xi8m7EHgmbiHSb8gBOW/yrE2NSURFEgf+mKVkrTdKmf2rw9qCknu/WT8L4RftEjw4iMsbSPBNXgSCiErmOf0XBytKf5ibpiwmIjw9j0Tde499o/2Q8E3BrCPLB0sDU7Dv0mLPfyLA9AqJSgihgSPIRh6cTywoF5R5gWFiTobhtTK5RNoH/HpQW/okiGbln7FqLmhcxFm6YTfD6kYOwIcvhhVWnapaMW8FjHmmHwsPVYYQ1suLMvcBtzYJqfBh0LEpYqK3ipZ179Nm0pu4YVHq34vOndsWDFVKA4GqQNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VfvP4QPx7KSf+om0h/JfWsoEw3fAiZcld8I0nZm08c=;
 b=FoDplYFuJZTNgtV7hMyKk/U1UKV6gcQb7Bs+fchQ7QcimquZJw5DS7quYrGSMy8cGbK387ul+pf6wgTb94g3m4WMI8ajyt1t41pGc+LTBkeVXKxFJ066R8eIZKZAcA6QScjJU9e3HLPMqoiXNXGompzhQcKgoOhsrmBNErRcqxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:35:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 14:35:28 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ 3/6] monitor: Check for ISO broadcast support in controller
Date:   Tue, 23 May 2023 17:35:01 +0300
Message-Id: <20230523143504.3319-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: f711a0f2-26e8-45ec-5739-08db5b9af45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xgivbCPiUuk/IY8lKVupzTMfoDsH1UvDyf50ttz5BzPnJUXMrQjeX9YeG3VdsmLIFsLR8RO4fTy3xSKov13l0kvSG8rItaFYvMSAlH63DnHk1YawhnNlEGs/QPkEnr/3QJmv7GUpYv1OQbNcL+F3xgHycR/7PRsFB3x3cuxsevZJm6Yi22q3f9b5Ac0sglm2MzlJ0NIyzXuqgcxHjOrw/UJri/2tttOF7PiLaeHkF3f7PERFWR6gYu2z/RceFGP2az+3P7KYh73VYEKlZ1NFIOE2Ci+Tmu+B0YihzmqbUTodZ1jWtWVc03Le2zqW2mFoJCREDaWHogxnuxVpuBcVzz6grAI+622UVVrrcDMIZS0KJ14fiOv0OB9me3JKf6vvV+NWIwUIWEBMXf2uS3/qh9g3GCC1/4ADGCMKFm8PlZaiASNfjmtSgEIlIsQCQ3L7J3pup5gOvvSqrhCF3XnfR89WexGmm8LMzepeMnyEan+wAO0QaqPs5yQcd4dTDgr5U7q8/oYKmjEOxReq9dNN1a04naaB/ygHLDvwEy2yDONuwHs5fsIcWVYSHidyJ1y0xere7b9QoXP5bK7hTUWSP1G+F7VgKe6QSR8EMHAfiWjgw65WPiwRJg5IFQpSOQq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(38350700002)(2616005)(66556008)(66476007)(66946007)(2906002)(4744005)(186003)(4326008)(6916009)(26005)(316002)(1076003)(6666004)(6506007)(6512007)(6486002)(52116002)(44832011)(41300700001)(5660300002)(36756003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eH5WY5GRQdjH7oAoSykD/2FA//kEkPVW0BzOKF/Qv0S2StiwcIMc0kiWE1p3?=
 =?us-ascii?Q?bfKK2e7DrNqKLy1fXUyYQM6MebCyr2IdSQ6JXClkn8SYYRJKb9m2Au+/ALQt?=
 =?us-ascii?Q?7Gn5jB0nqajhibvlCgQJ2JM3w8lDTdl1Z1CX1h1V07m/bcLcVCvel/ZH4FXI?=
 =?us-ascii?Q?/4QEC9Yzj78Clv9lrcD8nIG65jylszfwhW+bn8UosP699GlYPQYsHr0CK7fY?=
 =?us-ascii?Q?OUrY96+LtIm4x328KPjcL9tEBQHmYAOL8KLHKtbgRphvz5bOmVF9wr941RXa?=
 =?us-ascii?Q?dWgD/rq/wJm6wu6wyUACwLhBNamYabzdTwzXxYuZpgD6nHq7gnHFrPEU/3hs?=
 =?us-ascii?Q?kLb1C5ShP5XLQGX+r3Fhz3iCGrcOBsN0oMYIcmhvzTYk6dbE+2VuAC5KVKtU?=
 =?us-ascii?Q?DCYQTwEV4sE3LH0blGKhMKg6oYnk1VsxVy/sMIcn0wKpVZIviIGoEUzHfP0d?=
 =?us-ascii?Q?J3qLjAorab883gQecUH9I5zy7acERIINwtBRbCxmjO5yYfCq+q/WfUCDH7of?=
 =?us-ascii?Q?5hZTqn4FzFHWzxG9yDus0dMDqn5yladzBxgJUDzdMxyyTnwLjGZcr+0BTU8H?=
 =?us-ascii?Q?kp+XaoM7f2VHboRQKqk3AqwiRv47oaxvfeqA7dKWlCSvOWpmIGqFDRpIfmlu?=
 =?us-ascii?Q?Zz5ykeXb44tcEYdueuTXXydsgNnh2L/ys0c/afGK1a2ma7ZSLsTt/spbOlBo?=
 =?us-ascii?Q?gDWUE2DIqhs6QYxDHv3ftsZkWknIo7Y6g2Gi1sXgJ/2Tp3vRvUEcYeWpc1UN?=
 =?us-ascii?Q?/AcNCliVVbCrcZKYIcOHuLXYLapvnyjSgpAEsd53/MrOhMW3+J0WS4K6RCCR?=
 =?us-ascii?Q?dozb/WaCYjyCWfUukM4Rm6H5wsqS+JR7tB5z1Jrw2byJ4tuWyv/KHrlsK4FX?=
 =?us-ascii?Q?cQC0gvEc1PzrzSFpZSPdCz1nScGVKqnePYxJPC1oc+fubhyjt1Rhxu5jkBxD?=
 =?us-ascii?Q?bevCgo2OM1CNH7WOD3TXXubMxOYyPonwB3wjLZvs+Si7FYXQ4VctuYBQKtBe?=
 =?us-ascii?Q?40txiqzir2xtm4wnsX7CLGPZtlUoBdxDuGop7p68rqw5bi9qrH4RIjiFRhmf?=
 =?us-ascii?Q?uHrbdItodLEnkuVOkiObeG1ws6SDPQJh730/o5s5CZHqtswvdoRN6c8e2BNq?=
 =?us-ascii?Q?ADn/W9krGSoCJImIlFWAe1oBzpfS1qoGtYfJdvUK/keZEkY5pgH6/OilXPlo?=
 =?us-ascii?Q?D7itdPVF256lv03b9XJC5tOiNzoqX+Y2G+CAwdOdtWpZg9eUX0QMOFz9PL4B?=
 =?us-ascii?Q?VWoE3+2rsOM9Fo1fZmbBzWDRcADM0n31OLi8+YTo+SQpHigY9IOQCCgukl4F?=
 =?us-ascii?Q?zk11IWDzPuR4C1YezpUNN+amgUryl3ueJW093qb8t3Bc14wE5sBDcFQRpzhM?=
 =?us-ascii?Q?owfLEVjVngUEycyEg5JytDJRIeYMfy3tXTuJH1YZwBCfc3BWc2HSBPorUJii?=
 =?us-ascii?Q?RzMiJ7tLBc0E57kzToRFANczI5i2AxxnVoQMJDKDv85w+XmhX6azphx2kGHu?=
 =?us-ascii?Q?25G7320cXea5ftNmbv0ZLrD+7vjpI3ICUMF/O0cRs7GqPvyCfjMQEOdEMxJP?=
 =?us-ascii?Q?WiU11qtDmPluFh9GVAzBPDiCfZWEIpVc1jiBhkE1Mgs/vkt4oiG5AcRWqSxd?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f711a0f2-26e8-45ec-5739-08db5b9af45b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:35:28.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4RDEFCF31EA0e8rz/wztWwEaWh3Ev2vvhDYWSrQrTDG9gGTYBmys+5gpRjOKjwRKJroI+JwkGEI8MOkoSlqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

This adds bits for broadcast support to mgmt_settings_table.

---
 monitor/packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 94561b65e..30bdcef4c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12653,7 +12653,9 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 17, "Wideband Speech"		},
 	{ 18, "CIS Central"		},
 	{ 19, "CIS Peripheral"		},
-	{ }
+	{ 20, "ISO Broadcaster"		},
+	{ 21, "Sync Receiver"		},
+	{}
 };
 
 static void mgmt_print_settings(const char *label, uint32_t settings)
-- 
2.34.1

