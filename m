Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F7EB64D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 14:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbjFMOST (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMOSS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 10:18:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EFA7
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRECByIYqXF+7KsNSI9JfrGXoi58v7NVCMTzKV1iWla5rMnuVPXMXNeTh1h9x7m1SjwGjaztfpRDCiJu4zVT5YxoPnMItm/00YXiB6Jl06bQzaaOMuLs/Lh4GB8c459lhk8505ctKRi7iS+KV84R74gpFb5DPTj9Dh7ZbbKz3WxKEY6/zI8XkVp5+iKT6f4GS2EKgdplF9NsFT9/hXm3dfVQE4fcTmeJJViSuVjuMRX5lfGyaI9t3Kde3zCdg85ZqEpNhOk0vFKVJnBgI/gvVjRCev8Fu4L/5HEXJTQSK/ty6v897z6yr6TUZYCG+DnjyzcDDeWySNydvYZDcWyEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPKKkEb4oTeoufduRP3H8d+ct9PJbTSTdUA7EgNdj+M=;
 b=Ra14PLRlmxFhjhIAxPlbj7oxtD3x+ELH99OjHVav/C08EJePhrTAVofJyDOFeKpqRsCuObqthm0uQistfm7LqyZgiRf46O6tWnmR5a0LKc7lQmnh3Zkad/ef1z5D2L0XDH3QAN9HhUg/4IqHKfO3Lc0lxzGvff9JF64R0o2mLNiRlPZCeO33crOXRZ49YFMyPIrncd/EoQ9ljTy6HzUApI68fi7Fz6nuZbRatNBBBN2/gvKB3hEbE7JrT5E0RCFOiyWvjHP8CS8pxYWGPlMR/5EsdnNlKu+xAsuZnilZ3nR86Ca3BDiU+OkbTCwKisanYHWyDX4XCxSC7hGQFtv+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPKKkEb4oTeoufduRP3H8d+ct9PJbTSTdUA7EgNdj+M=;
 b=KFG3R/GyDLb2N9RKKmgxaW/OmekxqOQbm/0AXXKe/NbQaJEXe2O9uwOob/vW4c/Ulu5orPoj7zHz26NDo0pyGykj4ff2/OOifRmgNodVtRmAvQph30wuP+hXfOzeqY9Y+9kaOLjfM/OZyJiWrPbxTB2fvhQF1QLEdI+00V0wWJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8685.eurprd04.prod.outlook.com (2603:10a6:102:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 14:17:16 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:17:16 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        andrei.istodorescu@nxp.com, mihai-octavian.urzica@nxp.com,
        vlad.pruteanu@nxp.com, Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] shared/bass: Implement CP opcode handlers
Date:   Tue, 13 Jun 2023 17:16:23 +0300
Message-Id: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0501CA0046.eurprd05.prod.outlook.com
 (2603:10a6:200:68::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a39eb8c-0fde-40a6-bcd6-08db6c18e3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rb/FXrkE4QDnOyK9zlWEB4S7xYdJupyfbYVncqayj3mZQxYXuAxX5rP3Iy/IEIpi+pPTxtjWMrWszg47BE5qAnzu1pPv8X62OtLZqVf6rJnNkaANClGZX33hrN4aNgp9/pxD6RTz0Nk58rM3R1gaJ/T8cce31vB/ythhHhwQm5NsanCv7bDaNfxywid0s9/ftGwVAvjlfmsIQxe/97ncLqfIj8wzRGTfihSyEykpQNUkBm+RDGoyPAI9rwbvCfhbxKchNXV2Y+I+G792YGNDff589a5s56sheKZ1ONL+k2wZfzwsqTmokx/XYw3xXlHaBe4G7SOrfvsMC5jQTJP3IaYT5HlhmSlSsdmwt734tzN+j2aWdnBA/XGmdwxOUTh4EFl88SWeQBDT3adpequmNhA6qYhCDq/DuYlZIrgcuwVnVJmyrKUB5Hnz6ydaWlaADRMmU5/1oZcyInBC4tc9eTYHOvUwsVNKiQ2xTUJ4VXU/D+yAGKHS91Fq0Oghi/HqayfG0/Lq4z1kHOmCqPXb8vOaCxpF8iMr1wEE7qgafqTKbcaA6XsnVmy1NpMLQdWOa0q0cXyZRrhw+mHFkHr0aB9EBNqMw+LU1ETCCvC6bAzADlrXXdy5vE2jEHDh/1k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(86362001)(36756003)(38100700002)(38350700002)(6486002)(52116002)(2906002)(4744005)(6666004)(44832011)(186003)(6512007)(6506007)(1076003)(26005)(316002)(66946007)(6916009)(4326008)(66556008)(8936002)(8676002)(478600001)(5660300002)(41300700001)(66476007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d65AlcfBB6vMDrTL0+9zf5eIwAhNAwWAh1jPqIiM8D56jGRid5FW5umC5xGL?=
 =?us-ascii?Q?KVPezz8jJWMOCNAwRCZSFldTGd4XafGS563gm9o5JstfdgtcqqnAVwGkPxRC?=
 =?us-ascii?Q?AE8i9YZf190rlvkbYdl15ToKQ2WI+nJGlyblIEW++V8TdrYLKeINB9GPgP/G?=
 =?us-ascii?Q?EXWyrunoA0dFrnjuzEIeuuHh8TK9QGdsrNNfvQYMH7tpg7YA8sfDq4KZD7rc?=
 =?us-ascii?Q?N17dAdWUavISnoqL8hLJ+fT1mCdv2yJ3rjmwj06VWQEL75aT4Xp7FFGHQot9?=
 =?us-ascii?Q?tAXwZVJt5S/q3GbU21sux7cc23jNObW4oXx5Sriy3Xangq5do6oI4wz/ck0m?=
 =?us-ascii?Q?QVc8XIlCmEQdmqjmFe8Ayw8E94aa+AkAf9M1CK2RDyeGCS6Z4AFCkXU/aTDI?=
 =?us-ascii?Q?h4J7FDl/O69wWhS7B1jdjVTJFLb07/NycBkyM9KzgnU6GnMSeMf5K3rwgxmn?=
 =?us-ascii?Q?vquzBv2mQdMy2O/lU86V2yisYKfimKx10GxhcQPBFc8qSasV9Hw04vzeSF70?=
 =?us-ascii?Q?9EJDjYyW29B8hwp8E8DGwhnYW1ECqJ9niC26O2qqLfwtCNaiZjytJvKoOrvu?=
 =?us-ascii?Q?0nd++2LwmH7pP+RyTvlvSFTU1U0/UWp9tBPYn4O/eW8D3tdgy+dVnPFaGbRJ?=
 =?us-ascii?Q?bg0eynB0HxVkD5ACDsOzEYz/p64S0bSjyrj9d/lLq/LbrbBXLFmHmXPpjqmP?=
 =?us-ascii?Q?yqVT3gLdbyQNM4+vTjFecEfHUFoM1wEmU7mwEfeLXPftH0Ss2YEtqXvilqnD?=
 =?us-ascii?Q?XmlOtLueyNuwBI4q1tZr8iko3+potWQw/LNTlDthTcKhllW9p1UkXqtTE2hI?=
 =?us-ascii?Q?T5Ekt4gKJaEpO4sLbCWTt/4bjfr38l9vbLlUpAd7xiTqK26nH1t7Bc2R4QKE?=
 =?us-ascii?Q?UQTB4shT7lxmdzQhO6VdKTAKWz51dBjuROofp5rYFDmSwtD7RZEZI99QDIPy?=
 =?us-ascii?Q?eEIjPZz7lYLXkhNMit155BU71l/XHOIuh69RoP7WdJyhr6fdVwVBLGpFlU0a?=
 =?us-ascii?Q?1YvlhYXcwPgYObHjCLCSamvVBSvE5kwdQNpet1aW/4eRvfPJCZqYZdI0YFiL?=
 =?us-ascii?Q?eTo3M4P/j80cl2HmK4XCKhRlO5/w5TYII1oeBruNkVMUn3BXOz9Ak7384zLT?=
 =?us-ascii?Q?3gaPI+GHcVJxcn7iiuZQJi6GKami7XjtE4FGhrImdPF44JMAMYHAnMde2W8f?=
 =?us-ascii?Q?taPJAjUwqATNzDEnbZ9hYrqKBhwrM40xTg/1VbrANhtfwBuRWt9387olRHWP?=
 =?us-ascii?Q?zYytYeW10gVT/T1iTcNYPBu1sehxPh3LI4EiiyLIk9k3jkUK87QqFh3vGb4G?=
 =?us-ascii?Q?pQcfTv38abciWXQfQO67jowce1Kkp8CxR/GfY+r5NIpCstp0NJtKxjdNCki0?=
 =?us-ascii?Q?syIJ7Fnml0qgXGHQEdKqj1y+Y7pkV/ssccAmxBw0uBgogvuCSklqutZRaZlI?=
 =?us-ascii?Q?DkyC2QJQ7sWG0NimA3OXLFWGulbzBAPR9sww9BXdhU0Qr9AH38AwwLLXSm7W?=
 =?us-ascii?Q?tzYvdpuuDeIQSeCRCeYiVqvPsaMUkigvf96r2GaVCqItpd52r7D/qhYIDvHm?=
 =?us-ascii?Q?l+rlgvfGEJfpbe/uv8wxaPwq/NH4LbACuvb1kMuZmiQm//GFhV07JhtKnduh?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a39eb8c-0fde-40a6-bcd6-08db6c18e3b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:17:15.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHE/z5loVTtPf42JLQV1QJ7Dg5A+Q9rtGDNu4wjqnmsEAqAJz3Uet+A1nDQXqz4OTVcIoyPCt6QkJJeCLk/inA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8685
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series introduces opcode handlers for the following
BASS Broadcast Audio Scan Control Point opcodes:
   Remote Scan Stopped
   Remote Scan Started
   Remove Source

Iulia Tanasescu (2):
  gatt-server: Check pointer before memcpy
  shared/bass: Implement CP opcode handlers

 src/shared/bass.c        | 155 +++++++++++++++++++++++++++++++++++----
 src/shared/gatt-server.c |   5 +-
 2 files changed, 146 insertions(+), 14 deletions(-)


base-commit: 3030883005c02c77766e1a27a8d5c4d579daa9b5
-- 
2.34.1

