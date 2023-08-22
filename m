Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9579EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjHVOc1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjHVOc1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5ECE5C
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U69d1Iiztli2Kllr4YB8y3lNUfMkPpUWmUlfYSf+lfGelltjN76Wvt+nJFGDX3cncFGaX7+ECJT/arvreh5+MVSK6C0jSQ8hTPSi8WZFV/pz537cAxfgkHQS6VpecjXpjhjCHQrrztLVLw3g91MeJdK/eEhKdnMU5wGFydsRQjqB51MouLBZFZ6iLSH3kxeVi93nC5fZrksx/qvZ4kr9FsArzjsQYc5TWgpJfSOnoeoWZ3fizFEf2W0WJbKffkgYmwLWB4Jvuxb6e9FCICDHF7p98TrFCQNtDJi3MAam7koA7lIGEVBCEee7nBXqLZYp1MHi+EXe2l8DFi+JOEdxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImJdM82t0uHleclZD+EjHt86yq0KOSCCJwp9ride5TY=;
 b=abhx8mpPQSmkg7WsrkDcPrQzOcZnPkCjpMWUTFmNOI37Woep6FQWAh/vU7G9pvp2DOTj7ayJfivhvA/5EkPFqiK5f7hp2C7Mc3ALi0hGzl741wLSbLy7w8XlI6aV0rKd9CAFPhKyjEf8jaUyNSmuj8OZ7dhiR4l88HzlGf7AuWbcrb+6l942DxEJKucV7EQ82rIb4xFhan7sizsONYnNE5PfX0kYAWtm5teAdKvfpApPkuP4fa46ihb+GRr2T8LAjKTWkAHBhzJsOFF1zBAa1hDc9D86+4dUctlQQfIfVGViGj3asZ/UUIM6B6YV3iuz2w+yfbqgEesxVYmmj//rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImJdM82t0uHleclZD+EjHt86yq0KOSCCJwp9ride5TY=;
 b=XVM+QCQgxQ+BYcRVwdy3vhDsYxJTOCpDNhQuApiXRfAWd/etWuPuoMXi4K0fsPpJp41CtWhxoQPHhgpuJ8LrHEbrZVwX9pP7CFIaCLR0LUDOyK+A7TjSlBLezQx62nON6GxaOklGU2GB1RwWc+BYwsfPvr74K8oQ0Ba3sTxExbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:31:46 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:31:46 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 0/6] Add support for BAP broadcast sink
Date:   Tue, 22 Aug 2023 17:29:29 +0300
Message-Id: <20230822142935.6016-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6812a897-9f58-40ea-244d-08dba31c8320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fBSFrd1eqfFG+j591p+x8Ylo5zzedQJplpRPsuNIUNBYKMjrOytl3unHVVOPbcVVsq4puiDa2ZzjmP269oY5EzMTmD4Jr7CQ1DqRIQLNpEkngouU2USQ6tEbgvxTvNX9wKYCa5z+lirjMFPLL6A9DFlVPTotQ5dv1QddrlGx/AMseipVGqUPiQVNeQrXB+IeEe7v8n+6TaeBEXdfThRp1ujqCObOpzO/+CXONo3XbU7Zn/RYvFPrBuazBTXQQjekTWtJeOVu+sg/9JgxiGx4M6ktuIZyUwwkm9aH8z/PR7t+L7/QzxN5Y1rx7eaG9A5/40hbz1Jvt7F8o3D8VxqlNarNS17kcV4+sPLTHOJz91maaBHGqj05cAFcZ5FZ8J4eJ5bS1hhESApT26OfuSkqmPAQXCSSM7pF3MswIUG7LxQy1LY6wU4uNHckA3QXxnYiqGALpRyVlU9dQFVR3VieRT9rbRAz8zMlLpGtFcU8fqw30a7mqJ9pwYPi5hHsw7NZKsug8lsFE8ts/WAJhi+S3FSnq6aJ4yS1l7qheMGDElmDBQrolW2nUCoj+f0PoXt78288mxk9SvoAOo05xHpPSXnNMaUy9piPUkvcz5/7r8hWp5nSydWJSVBcLE/H49D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7edFlhUuMBgEUaH39NaUCD+vgDuq05astZlVfkl+ZtU1462zOy1XStk4E4bF?=
 =?us-ascii?Q?hXq2lE5bkX9lPQrutPMDHToWUQuInTSqGpV2TAHpAT+dSoUFxBEpIUsz9xiI?=
 =?us-ascii?Q?ced+uQ+434RXbk/pbXO/VJAr6qbJMDGaAM/OP9CqQP+Ji3EoG4QtO+tCv13Z?=
 =?us-ascii?Q?SNFRiDZiHQaoqkb13elxou45iMDq39QXXeQCyia4THTP89JeuYnOdUB7p7Th?=
 =?us-ascii?Q?EEz4Syjyj0S3eXR3fh7eSSkSNVZ+I41NYkXzhv/hjHrOwNEGwYG+MmdBWfGd?=
 =?us-ascii?Q?MMc2FkPuHSLdAozAtPASelTIpRujxQlWrSOYmNhYuiUcws2DOLbuZDFThbNL?=
 =?us-ascii?Q?u7+GadpM74kKp95X6YsPj39xZLqrdmgdwZQZM6GPlQTQH19KSS26sGoCYhGT?=
 =?us-ascii?Q?bWdyaB41jqL72xxVwrbsfa8a3Uae+vHvJLI0BQnEx0Rs1WwFqbo8apgzjuHz?=
 =?us-ascii?Q?KL93zvd+SW71YIBhBFCGFYQIe8LG4o/BU2GMulcjuKziFHnD4as773ZMiw9j?=
 =?us-ascii?Q?7Ya++E5TkMCm98dBJ5Du9xrsx9hXZt02HzCB8vLugjBeZrVDU+8fFMi0fvGB?=
 =?us-ascii?Q?X6DjDZsgM+SSoeBLOMMJiMY0G61MHMTFdRwkCd2QmoaYQPUlTbsaT8+SuJiA?=
 =?us-ascii?Q?N4ZoM8nF2xur9PFaJJ1DcVA/tLvVg1MBlBaS1wxk0QNsjDvVFDQCMX926hEL?=
 =?us-ascii?Q?xsPcj0C40w5FiVs1eKUysNNJsqp52LIIy4O/IZz3YiCRKhk5P92tyiyOjVLG?=
 =?us-ascii?Q?Wzk3+LcSGjaW7OeFryptiBtw4pE6C0y4IFdRYtSoOy2gHLzVVu9zVTHXkNss?=
 =?us-ascii?Q?i9fkvzM3AK3DucDOJMZx05OXyxhfJEWGyuK6A0ngGdxo2zjfq15mYeL598rP?=
 =?us-ascii?Q?OuExQELXYCguNxXoilbZtzNfehAHoQkQ8a2f+oOLsyT5G1yumTckIaxrS7Ig?=
 =?us-ascii?Q?QPbQFQFw15ub/XGL3fWA3WuZx2QW8snrt022C/cQZYPQyyXdvAS7COd5Bddy?=
 =?us-ascii?Q?Np3nWzdErIuFzGMFsBHZL3obJvq/J9zN+Nj3aGf6n5974saP2VLZ0x9nMKPj?=
 =?us-ascii?Q?WfuIxmyTfKw+S50Q7CHdhjOktLXjfC+b9FQzm/Crf10cCNDn+v7idFYtVsoQ?=
 =?us-ascii?Q?XtcgcUxyy32/tl5wQHOFZp8jUtTphk8Dpu6ejO14jR97ADBxNozF9wUkYGbK?=
 =?us-ascii?Q?qJPCC8vXX3HEEuEjSaTuhH0oZcu46xNSg7OR+EYQQ5A8nw3ThwRFmNJ9L4RR?=
 =?us-ascii?Q?mX9h/Sb3tFw6fPktfiLCSecuJYcMb4gCjoBgShA6vMy8TYUx5lwUQujKA9Xs?=
 =?us-ascii?Q?A6pvH+ZvqCuJmIV8VGRsefKpmKdbQl3Hy0gp2qupandqs9Z24nk8/7sUuN/d?=
 =?us-ascii?Q?J+3wqpX19qguDjjobObkMSVJVg8GZH/eOqK11yekqlxJhdZYRvf0ZCqNupSD?=
 =?us-ascii?Q?wEyEDPLelgNJW6LxqW1laeF4SUwdd/Vw/dwBC27kXE1H0dJll+3RhQvJEMma?=
 =?us-ascii?Q?A39/mYQAs0QMrlwQ/zAvlMoXvSKRaolrqSBEfHVZm71KqCD3lkZc1ggcbzEu?=
 =?us-ascii?Q?lcvJghvYm/jrW1oUT6+mKsDWgMxcQlgRWLlnANo2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6812a897-9f58-40ea-244d-08dba31c8320
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:31:45.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiuolcAHv+CKvVGZ3wT0pPF7lm/9sF0cWCltqb8Ug7Ha/yoqzHtS5Uu7B2KVmZlSrVrnwYRw6mwQauYg3VDjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for BAP broadcast sink.
It consists in registering a broadcastsink endpoint using the
Basic Audio Announcement Service UUID,
discovering of broadcast advertisers that announce the
Broadcast Audio Announcement Service, synchronizes to the Periodic
advertisements of the source and synchronizes to the BIG advertised
in the PA train.
To retrieve the BASE info advertised in the PA train, the patch
Bluetooth: ISO: Add support for periodic adv reports processing
was used.

This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

Claudia Draghicescu (6):
  shared/bap: Add support for BAP broadcast sink
  bap: Add support for BAP broadcast sink
  media: Add broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream
  client/player: Remove Broadcast parameter
  adapter: Fix UUID name advertised for bcast source

 client/player.c            |   5 +-
 profiles/audio/bap.c       | 432 ++++++++++++++++++++++++++++++++++---
 profiles/audio/media.c     |  42 +++-
 profiles/audio/media.h     |   3 +-
 profiles/audio/transport.c | 251 ++++++++++++++++++++-
 src/adapter.c              |   2 +-
 src/shared/bap.c           | 169 ++++++++++++---
 src/shared/bap.h           |   8 +-
 8 files changed, 842 insertions(+), 70 deletions(-)


base-commit: 0004eb06d5d9a2f27521d9ce3b206d6f3f82c61e
-- 
2.34.1

