Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FACEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 10:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF2KBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:01:23 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:41480
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbjF2J7T (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 05:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH/4aoTgA28juHcdr3vR6Slh+RxPMSSp4J+lUIi9o+jbTrYk2GdGvUqtPr1ClooXkKIoHcdeB4OkM4wiTJqQdXDu04dmVdhCxO+loyUhuwErcpCsbsPxqOJx5w1jSe1ayGSLj4G7pKIQwELb8YhdtOZATuRkA7BUVF204bc7fCkzE21tqy5YdrbA3HJqfnhWihYD6TQpFG73ii8ogMSCgEmoAvUHxshLICB14RoWRLM4zsoT7UQXY0QM6r9UgnCgMV+EtjZMhe1uHaXAay4n1oeFHzdF+0F62Au20qMRJEdJ0pnnm0rLv7YkkvpVayNcJOL5IAXlm4GCitHDaEHMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDl9Q4OdvNOgDckQ44scyVKLg0irwowR4dGMu++XoWg=;
 b=EMhH5V0OUq+42ZR+89dQtG0429+rpwMV2oGO4gp7d7sdkSfmZBVKHtn2S717YqdqL19zIe1LQKdrPO/Msbllu27ndGrOSTvlXdrbefUwskWTajNmqz4gmOGyMx+DevmGaCtvUzsrsp9kaqf2b23USfR/3iPPUA7NSpHYgWpLEx6/gWI4oa+tB4JjRhw7MSGRUJeHDbSMnjyCTOtCUQXDpUd7ye0Sfxc91IuAAE15ZtcMKIkZtM7f29riPhgI6Z3XIQJukPz0eg9THh4AyM2w+c3/DvjDMc+UKZZkoghnkJ5cUVm/rpfrhLI5wY5U3ByZ322S6FHXxSbZ1JXif/Hc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDl9Q4OdvNOgDckQ44scyVKLg0irwowR4dGMu++XoWg=;
 b=NNUfv83KcWn0ehVJJ3pElyrOfQYqZxnLvRaLiYx3Umk67HrgDlc/YRNQsQfCyOdPYLf8+NJ9/H42NEOTXpK/wbNn33XfjNFthr8HI5iWVJhZAKOP37yR892Wj9ql4TQaxD8QI68qciWfiSfBIAR58ANpl5vzBSUriVwEmmj+fpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 09:59:16 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:59:16 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: hci_sync: Enable events for BIS capable device
Date:   Thu, 29 Jun 2023 12:41:19 +0300
Message-Id: <20230629094120.5463-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::9) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb914b2-27c1-4e0a-97a0-08db78877faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJs5LE/PuTyXeBAXjuep2vzOlmSQHXr2OQW+ndckKDiC7dEM60xVgpARMh4rc1U9uRYqTH4Ij1CBEycksEzEuvfWaJLRGPqWq9421y7re5sEQcF+04dQyu9nZF+e8U0n9VItbcwE5lwMYFCn3PX7JJ3MOLNKgk4KsiMDK3fw71NhgvnS6Jb8OTmA5RG94CnMTSQii91tu0K+SD8TV2AXKh+MLtFkaHBmmkiTfOaF7kD0P5j+78p14ZuAh/cgpXy63ys+/d7TOQZ/dZTfmmCCYfxerTgdJDiTGTv8jWjDhC+CgexfeaPqNomzRuEUL9VZ6V6DaCXFq+RmzrCRJuEYDEtATDXqSng89j0rnoilR/Nw0mhhZNMfPJHUZmupKkXNoaZpBAeVOXNo8tPU/N4JErkERFkSTX3J6p6JNFUT3JreegF15xctM8i6zLSHU6LiYLFKsuIFcxlFMXL+shdGl9UsUx8Hdb8+1EPTMbbjfuLUW0BN+O3ffH3jPejJ6p5Zxg0sUCy07vRONb830LRFI5Nc+P61dHSA9WAHYVpJtAR6oaABY4NWzby14GrX37CYiuzkD7HNpJdEFdv+nRbFIM5wMCb6RyW20LuARKpdNjN3/3asMA75WYca4jnWYdFA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(5660300002)(66476007)(26005)(2906002)(4744005)(186003)(1076003)(38100700002)(2616005)(38350700002)(6506007)(6512007)(8936002)(55236004)(41300700001)(66946007)(66556008)(36756003)(6486002)(478600001)(86362001)(8676002)(4326008)(6916009)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36V5Y2jYxPU1eVWaedxqaCrv4ipxkW6TO3klkf6+tCvMDCOaT4iWkltz51rf?=
 =?us-ascii?Q?7IZo75kuHHwH1Bd5nJsKSFYGTk6duCXS36Dl+QZ7kQO8S80lTVJMfKH6TTTc?=
 =?us-ascii?Q?BPqU9JIaPeUJ5BTteSTc5oRz8yV/vlFYvrnuSh9ej1reMVttyL8/6LFFSA6b?=
 =?us-ascii?Q?QV4DJ/u+Jp7L3kE84DYmObQ9k3ysSYvDt/PBOZTt7fxKnXnIp2bwayaf8aff?=
 =?us-ascii?Q?vXsOiDWW496VKRh8Xcrap07g9+EmDZjRGVuk3ETyit8dwhTvUPec5tIGhCGN?=
 =?us-ascii?Q?WSIfYr3R3sLmT5xwVIFQJP8KR/gPcwyUG8th0rCBgSRtiSoYVgIezGGF576O?=
 =?us-ascii?Q?0GKZaJxYcOxogLFZ+dnSO257IYjo7t5J9aJxTiqbSd3/tZ0V/XSXsf2bGPIz?=
 =?us-ascii?Q?j9uy6ibwLyLRad7N60j3LZPf3zHgJSR5uqFbOMKtiYTmFQaNdmM7a0BsvOF5?=
 =?us-ascii?Q?f3hYjOMM+nHbolcwV2Q/TnEFrbvPj+GQur9aKkJbktXiRFqiDGA2EqD21YOx?=
 =?us-ascii?Q?6WCORwxIv6TY6fT6p0Kl37qmhTL1JMdEbTRrHnJf33BXWaYKWg19o5AJsU8j?=
 =?us-ascii?Q?uCaGnqFiW4HI2FaqaQ/gVg5MzAgL5WsPRcNjFwnWwZ8ztp4CNWL+uZ+NHsXe?=
 =?us-ascii?Q?jZ73fM1F09XYUASb1gwdRCi2cnvHfaRPKEZFKmh17YLsHGSJreg34mQipBHY?=
 =?us-ascii?Q?2OU/1N0Az98rI7t/ePBR9A5W2BNrhA2TiFcDxsHi0R8JSbUvSbpSHH59vkpX?=
 =?us-ascii?Q?bIbMoqOa3dgOTFj3EhMFTBwGdYcI7KJSpFHFO6YfJ1FGBk9EUEO+9eyXHVeL?=
 =?us-ascii?Q?SR6cbV6U4vspXgux8feU1K+PGjLtro7TD34H87y8RUXKgvSGQtjjrkgg0LEv?=
 =?us-ascii?Q?zpUMP/uKYqpb0Oq8yLg69C+5vTXazjRVxeObULj9Mn/9z+jU3Zl+ooEky1/t?=
 =?us-ascii?Q?hMa6vX6aGrKiMEoay5EHEHsJVrTjOEePD8MC5VXWwFZ+A408CpbEZlUf9HQe?=
 =?us-ascii?Q?iPHJgRnmZtAegPdl+ddcp61hvmREEeLe+kboIN6ghS6ZMmgDiHIMHLjGW/Zi?=
 =?us-ascii?Q?qDlN3c+jrPqYwU6z+dVmALly+ijEfAoo32ZPgeE3GulU1nJNrUJ+OHlj94KT?=
 =?us-ascii?Q?5RI4Aj/hHCRJIPPOHRUjOoXPzPzh6fm0gdYDVQ+xCQARMtcl6hGWtUlpPBe+?=
 =?us-ascii?Q?2XHCbPEXtlKxML71y3IqyVBCUPKr4oBDH2nb6aKE/Pp32M53qEIjCQMRNdGC?=
 =?us-ascii?Q?TTLq29ON2Xm9ug+JXMUNvQoSrO5Ddma3aQQnlB0uYS4G9oB7nTvLWaiPbTnV?=
 =?us-ascii?Q?r+pH4YASYzS6vL816BqDRZlUCyt6kYLIrxmqzynC9auotdvqu4LgyXYVxJkn?=
 =?us-ascii?Q?es83KThSss/H8udOvKW7upV+TrZ8oNXQD1c7aub/pcweb1AvM5Hyo3IRSvoA?=
 =?us-ascii?Q?c0xSHyv9d8PKyfOUNWFGCPJrvk0LcCqk2Oy+/bIeUPDD4PNZQj0Lyv1xY1/Q?=
 =?us-ascii?Q?kvJWYRt6bILq/3fjXjQ0hXhfh+ulA3YFB6FsJ3PIo0NyMLSrnvd1iNwO668C?=
 =?us-ascii?Q?F2ShdhP22tSJBL8Akjss4K9emZ8Pae5YyxkhMhpz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb914b2-27c1-4e0a-97a0-08db78877faa
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:59:16.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CztCJDoKoqfRpbzgOuZ/TD9GfvcQbm172m8WeMcYsc84eNbY9cnDxVPrmWrQtTQ8jOg96l6r3YJNy45hruT0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Synchronized Receiver capable device, enable at start-up the
events for PA reports, PA Sync Established and Big Info Adv reports.

Claudia Draghicescu (1):
  Bluetooth: hci_sync: Enable events for BIS capable devices

 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: e63d8ed98082395ca509163f386f5b04f53872b3
-- 
2.34.1

