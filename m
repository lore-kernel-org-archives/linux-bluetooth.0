Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F50CD8C99
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjJJOtc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJJOtb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 10:49:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F6A4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 07:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPCOeLYy7MskQmG75GRVap8390UEk3+bu72KbbPn/BmDRUzXzofRo4lvc/Wmerrrl9z+X0oOYzrIV3Fwxn6eI+dV6judUSp2J8ngjnU5Bc9oE9sYctDPeumgqv9L0ovzqUq65GIQnoMhKAI+GM1A0cO+oa/KU3rrqIDcfDI78fN7pSZ0xee7AB6T56stEXTfR10Il9PjVH/MZaXY4JguFLh6nybA1YTg9m+Pt9WvoaBCODFbYOeCliNt3JcEDj/fBH8vZVlhhUQG9iJ2pVkQHtJYaeDk7bDRnoWIVfJrNDHLOxbM2mibcNJCjkF1nU8+G47YzhkJvF6r8erBoDn9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPGOd0iZaH5amcPJM+xODsa3IVBYjRljQyUNZiA+QJw=;
 b=MTLM2qTJFgyWXgi8EVSyIFYe/kcw/773ft6keCxk3oryx96hyS6AT4L2vgIwykR9f4+QZakbZoBqVDtFllXJK1xfWbhSQQE1vgL9YnOdvXbWyJLGV6pP2N8ufA2V8EXIL8ZEZElZZTAsgM2GiA5zsBvHbDXyIIA6graENExfGL9+nsp6h6tVGDXUZLsi5Oz9yIRtP9j1JU+W/2HDVaG550Sth9FmWz/oQpeR6BBjszpG6J73HuHqkSN1S2EEtl8u5ZcZMFBz7EFq6bNvqsxMotGHQnmTQdvW7bDS24BMTGnjOY1+4qWCCB0db9k0OGuUSFdjWVYzIatC8Z0Sey20QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPGOd0iZaH5amcPJM+xODsa3IVBYjRljQyUNZiA+QJw=;
 b=W0P3WH7Wz5Gb0xJRf1ecm/gdt5eI+WkhMFMcHY2NxhbWO+YvwahjmzHsX4ddfZQC4yV1aPJ3eYf1tIOnSi3LSYi9i8bokADdUbx9fKEJGAEcWjl7ncbnN26a0S/EPpFxwxVUnLtvuDVOJ6j1dSJ1TF0qbP8cm9SrQNm41n/JxBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by AS8PR04MB8930.eurprd04.prod.outlook.com (2603:10a6:20b:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 14:49:22 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:49:22 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/2] Update transport acquire/release flow BAP bcast source
Date:   Tue, 10 Oct 2023 17:49:15 +0300
Message-Id: <20231010144917.4400-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::10) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|AS8PR04MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd9fa7c-170b-4ec5-97c2-08dbc9a016eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45Rgu9/7r3Pt9Qo/GeWLlVllKGvtG7Kn774RvkGHmMcpbu0k9PDQWP2Aozs6XUGgpP02ECxrCSeyF2TKpKIZZykwfjuOvhk1zj6i7xK3Pas0mBlbvyDfGtTss/pfBcoAXCDXhaV9VYrU689Rtams4NnMBylJ26VQDrn/Jf2Vkt4hKX8l7lsTIU/AgvsYMemek0Cxhch63520nu0AKluvRpzPo0WnKbWWqE+pJ8eIEKE60ocHeg6EJVRO30KBcMxU7UhkngSgV/6/J8RDaznPupxNsQhJ4wfquvKVorHLs8sqN/GhNe1kU8sJdLhu/XltcLIBlwSDtP8IAkTdyS1ikjyJLfjc2L8OFTf6Jhau320J2AGTVRIaFsMrAUiROHWp0cbrcVntW0FU8wLhHqf0HPryNH1svvv4i7PdjcAZDbax7QJpj3ow6ME67xcKe3Ht+IKoGcZ5Okv36mgnColSTcOA7a/eUMXtYPGaafUEbufrgFwODg7d7qMWI1shB0jIghu7xLjDff+6/cD6mf0O1bjH3ZtKG/fm5x3+bEWa4sbW9PZXjLC0ifOCo990RKYk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(2616005)(6506007)(1076003)(478600001)(316002)(41300700001)(6486002)(4744005)(15650500001)(83380400001)(2906002)(66476007)(66556008)(5660300002)(6916009)(66946007)(8676002)(4326008)(8936002)(26005)(38100700002)(36756003)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1lZogg4djWW+uQnNMzUC692OU8hU+Y5bTCbty/nnwOmUD5Q2/FYhLbOF6FIt?=
 =?us-ascii?Q?txGJCipbiLjgzUnWH2NAMpnNfdo8dtyJVRMHZ/v08SLJaF6V+74wg45l/Yo6?=
 =?us-ascii?Q?lODdri/N1kk0zAbv6PXkXYjyIvWnYPFby2xmLizVbYjkB7dCbEmJZeAmq2DW?=
 =?us-ascii?Q?xsitL8mbQ5jgdWOJe4tgY7dqVVYVdHAjJUQNW9y0PDfFsF3RSHat7wUYTGdB?=
 =?us-ascii?Q?j0447AmyPaZhuaMMu4zu2Lqi8kHcfc8KU1phSmoLNK5QW4Xqa6oP6FbBXCmO?=
 =?us-ascii?Q?aJ+mv+3bukKMLf5icdecp1jJcbSkSDEQpEIaIlWhGjkDGdLEPNv3NiApXTGF?=
 =?us-ascii?Q?sPKQKa4kUzhiZ66bHzaC1QHXSaJXfvDEWTDLUCpnvzaI99Yo+vtOUKWLUqgX?=
 =?us-ascii?Q?NAQ6xdQZ86Qx9jMKQgrAVZhokFQSPTMypV2s4ll36BT6TGeVNh9VJJBrvdyH?=
 =?us-ascii?Q?bnpdudHbSKbSsr8On8BYG1Q36Xu2koWB5dU6m1p5A0MOXBQegcrfyeno0qqH?=
 =?us-ascii?Q?ipcHH9wo8Bw9xGKL3UzhWKHGiRT2JwgGb/LShtH2BA99jByL+LgZbcc8Bd42?=
 =?us-ascii?Q?3rodco3vKeHGQM699ub1cC02Z75jeRPL0uuhVqyR+8Rm1oKvemYLm+/yLwBv?=
 =?us-ascii?Q?RggW459+QM/FaDQ5gAoy6hLcmuTjHwLw9OHRdPgKvJ0qctlL3RHcxXEhxTud?=
 =?us-ascii?Q?yySV4Ft4YLZFwF4n5vJBT5vSCDxT1R/dQYQBI6wcPJTjxsQSYLmlzsxObT0+?=
 =?us-ascii?Q?46cpHWz+UKpJY8W1Vb2mjXRBGTkjjiKD8Vh0uMkUgAmf8MJEkxsk67/aIppl?=
 =?us-ascii?Q?kfVFZCFutqvp5NgP0iY+L5gbUJaIBgAeVU995boMSXs8UkZFsuBUWeKP8VFX?=
 =?us-ascii?Q?AUCPezRUnLtDzFv8rkhSn4Q1/M4tHI7NOe9zpLbtaLMVci0oo3cZbAUtVSH7?=
 =?us-ascii?Q?I1ulL5TzhP4fwnIGx5FYrz1OfNYhQRcqY4H0uHSkbChtfJya07VyQDYeohPI?=
 =?us-ascii?Q?CPz7vm56okNkOwJjG/U3mDSEs9rQzGnGiGH+5rX1UiBYlYXmPEV4iAwEMf/P?=
 =?us-ascii?Q?kP97+ObNg1c2qqHbCDRCKCyCDNiBzUYoomT44H09b4g6Z8jxkfKa5cAuBtIf?=
 =?us-ascii?Q?rDIZX9owXWUWATLBZENi5YS/7iPQn0O62PK1SAV3TB/HTEsDsA6XO1n7N9aN?=
 =?us-ascii?Q?1eSD2MNGpL7MPDBpZQOyFcAHfTjk0a9UW4YPa4+EMFKTF6wWXHogvBZgVzgW?=
 =?us-ascii?Q?0QSDfmfZQtoNbsH6WLQE19w2AVoPbkRwwPcm6SZJ7VMVGVfGpgJdtH4x1KoH?=
 =?us-ascii?Q?BRQY+apxYplrrdpnnAE+8ZqtD1JsL0fenru3ghErwHS2syVyTUKoL/6JHo2d?=
 =?us-ascii?Q?onupV6aGAlFEOSn9f8MEqCWcXMEWskVfgWkaXQavODEuB0bzViZ7w/WczzKW?=
 =?us-ascii?Q?7y+utlT0RiFdBnsgrOHB0AtX/n+/OfXqRlT/+hQs+iAyguzuJ76R89/b7gMD?=
 =?us-ascii?Q?Dz2/mvZT/fahBrOAAdsbhg3UlAcHAsnaRhEbtt4rpsIgnZy1wTdlz1SzWRN1?=
 =?us-ascii?Q?LEw38uJ7Gs+eYUVTkkt7+QTxWDAdT17qJG2kw+zNBGG1q+6HsEAq/oUNAh1T?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd9fa7c-170b-4ec5-97c2-08dbc9a016eb
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:49:22.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGi2vYMXRDKo3BWEjn73lmogJwHBMJW6cjD5SbfxZ8ihnzFJok9r8GNaj81SnH21yvO/qOGNFzRsa5rotp+M98hbsn4BODO7QLkvx9N0Y5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8930
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP broadcast source to 
fix failure on transport release, and second acquire

Silviu Florian Barbulescu (2):
  transport: Update transport release flow for broadcast source
  bap:Update transport acquire/release flow for bcast source

 profiles/audio/bap.c       | 51 ++++++++++++++++++++++++++----
 profiles/audio/transport.c | 65 ++++++++++++++++++++++----------------
 2 files changed, 82 insertions(+), 34 deletions(-)


base-commit: 7a79ff88fd9576cd9935a8c0bab4906b7c38ea03
-- 
2.39.2

