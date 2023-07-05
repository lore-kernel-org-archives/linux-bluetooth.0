Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE590C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 07:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGEHcs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjGEHcq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 03:32:46 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201771736
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 00:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JifWz7vlmGCW73tCG8IX4IRidBAn2gSdrB+LkcmNV1RsstE46g4shRQUYjfJvfth0NJt2VMhGZgmGa8L2R/QIGHJDWMajXigbLwn0dG+0gXHGxHH+FwqavrrcJa2No/ygg/quSfDR9e4A0eaQNV/dvq5OxF6/pnf6qKcNU4WI+cmgeR7eywdkyCYGYD9NsUOkN+TSPvd4fLg6CETxU5U2df00GwWLngpD2RaRgfmMys0cSQGP+HhFwb3yDREWbc9A1zbvZr3UHG0H42FmBl8Aj5mDxqz347lzqX3atdVte2TU7kMfEY9AUK2W65wmrTsvOmRZEhna5zTqQN4/HzjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL/x95kukH4H5C7a3kHf8Ck2uyqAoy/BAJ0r/SWvuQU=;
 b=IORxxbyBkTAbpkbqXdL9mde/nY0v404M7ib13vsM06U/41fic4tLqynRaz3IJWO2ArySvcBRxQMwDsrwMl2LijF5RLwV0VI7CPUvWjqpFNTG4SqLCHi+dWsjbXffC/mWHWAqKjr/17Yj+eEUSDAE+LAmf2yddwn2kKm+Vfd8yM4lqoyCeFWXW8w81+lAjF8MDahtq9Qq3wv6Ff4YArRYDtxIHwUuM1ot/+h7rjbJ2p02L5c6z/9Ko8q8yBBWrRTYDF4gXXR+NWLvFEBeHi01A+We+0oOd3xhxvQOfiqzopSImB9CNnKNj634zaRy5I1ARK03WhOsMSk7yD1RJjufkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL/x95kukH4H5C7a3kHf8Ck2uyqAoy/BAJ0r/SWvuQU=;
 b=lIEoJbOU6v1/04ehQnjyPy5CM7MmkazTsFgiH/7A2eDn8f5KjB25C2rlfGoVkX62cR24/c7Si0bxkWffmtYLJzEIhmuf2DE9q6M3TJ0uDTY6qY+DMHw9B2WnyzJ8mMjza8h3KNsBmVcezuFR6poFwG5dre+HZf8lZs5nv98pNWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:32:40 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:32:40 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 0/1] adapter: Allow broadcaster to be passed up to application
Date:   Wed,  5 Jul 2023 10:32:18 +0300
Message-Id: <20230705073219.5357-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: e899587b-4583-4f3f-46e5-08db7d2a035a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62A28uzUk0CACOX3SP0Tpy3g/CDzsNDs5QbiwLAS2G0F29D4MvssCQcZDRWxiVCvz9khKKOU0NoCbukMSI8uw4Lbc7hjyDHDGVSqpySnEMo94x9x2H7NCWLJJaFeTcCTdIeSV0Vs7X6opiUH9NPnujK311ZJgs79rSJ6Pu9YpUczDbfoHCji1gXZMplmpiSrkLcVzGR6BdqIRbDiW0jGj5thv1bi7Ji05bZH/H63/LFKT9Ru2hgLacAX+9ruGu4rsqqaz/GZqvy8dczde9/jzYQjZMY2qsI7b58o7Hl+e0InaPGXqr/E6VdrrUW06M83HAM+kQwYou61Rl9GaNS6YqdLEza2x46AOa/ZzzoDVT/Y4hEkWaQ+lutRi7PerdsSRyyam0gtr6BR+eN47GNzH++kNVvbSXa7/u7UiwYMKN424mnkIDxSF1MyfZ2wMuRlILssruo+tuqDGVoVQSmiWyl2ZsohwRQaUOf2LECBJ/vLvef3C/PPxHr4XuTOk04YNMR7DSIgVuH8MPIdeGDyaqsJAm572DjuX/Y81ldX2v22cyo5ZeP8xqhSN122hkant0VqsFhni6oEz0uaprT7OtBXqcfJuLZZWCfkd39Qq5vywyNRj7/47YSTt2HMaz9E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(6506007)(55236004)(1076003)(6512007)(66556008)(316002)(38350700002)(66946007)(66476007)(4326008)(38100700002)(6916009)(2616005)(26005)(478600001)(4744005)(186003)(2906002)(8936002)(52116002)(36756003)(5660300002)(8676002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SqURsJpqzeQUx7RhYSQDAQgIRW3yJ1zhMD8/qROXEfSp8/tjgMB02lld2U27?=
 =?us-ascii?Q?DB6XcNnlmVruEexdfz2c3Zh6DfOA3QD0j4M17rSI23e12GCbZL0jozanOCCd?=
 =?us-ascii?Q?5tgkRsN4EgnurD1S8RRfii7HpAfsraSd1zFmrDNb87KIiesNmn8DxxXU/m2y?=
 =?us-ascii?Q?/vNrdxJwB8OQ3FUd4CO0CFQ5YWphZhUy8BzrzG3UKcHGnqZK8ph2J4Ps9Swb?=
 =?us-ascii?Q?fj5y1rGnjLMQyTh4NtwvU43QPRc8JtCgI7Mv56EfLpO55KiDooFtFA77pCz7?=
 =?us-ascii?Q?Nxj9HseMAwYtZ+XXZlT80uT2ziar0/vyDciulXW7h32T7nO6Ez+5/IgZqGtY?=
 =?us-ascii?Q?pBYxxCiTIgSb+Bd//womExc2+zzQAjFFHCPKcWX2EuFzrJLsGjlOmiLOqUYb?=
 =?us-ascii?Q?L20V91CGiBxNGf0QUazi4/9pHIQ9+CaGekyLElY8BtWl/4FdVxdokAolWmSt?=
 =?us-ascii?Q?uL8oLx0TmDWfuAB7G8DL5040CHA1JUttANIi0kjyaYTtB4jbia97hNvoIAz7?=
 =?us-ascii?Q?8f0z/jADPdSm6aC9ZRRRCa8Wi/Z4wpVVLHH9eATeRca4PR5+BhsV6G2HlGBM?=
 =?us-ascii?Q?/u+oBWqnrFNID3818S9dFCYhuDeuUWU2T4uGwV57wmkoHSubd1jDjOnAT8lO?=
 =?us-ascii?Q?Ks68wj7jYGHp2+65mB9x81Hu07WpPMWu5TleZa+6Z09TNFHJ/+pUou89qCfq?=
 =?us-ascii?Q?Hh1EWR3LK9BYdyYZkp9a4g/9wDwCsC1R3jNTXSiKNDJ+bZQK+zSyvz7K9as0?=
 =?us-ascii?Q?GJUcyc/H+dmoh8bxWm3Ob4OLQGEdzp2ZiiUp07mzL45Wgg1eL7t21wvLQbKs?=
 =?us-ascii?Q?v//wQaMQ3gBhJJktrHo/MpawnSgLpP/w101KDZ8ijubG6ny8dqmzBHaBYFpZ?=
 =?us-ascii?Q?RmmdmqVYifDxrjBXGpkfQZ5EYrDMSHqQwtnyuQS2c5ZTABMrGeA7zvoz4JTI?=
 =?us-ascii?Q?OCap5yD7qxcV5caIqzKENxD0PMBpbnyRXkA51hFhFZwaWrJj/mCK+bcnrxkf?=
 =?us-ascii?Q?g9UdnGkTyYtWl9AGFGD9aBBsgZHADSd+4W1L5ZLPmsT8z917iJY7DKXUTl46?=
 =?us-ascii?Q?jpP8IxHN4sEaFVbGxfU0o8+GaAdvAMEqs/5NRItKBxdSAvsEAmTJTF9CUSgm?=
 =?us-ascii?Q?SMSUajYWN+D6KPto9s+6cDlSosaTGPcF1gmzhONke+4BM0rPr+eOiUAnea75?=
 =?us-ascii?Q?LRU1I6MIn1QQlqDW7lWudFKd4SREPUk6m3M9tNMYrqBiAgwCuuR4jBzsqGnb?=
 =?us-ascii?Q?yrYcrAlj0njFSidWZ8hTlsy0D80GS4TUQLrs+F4Q2jutQgXSxw83A+YyufoL?=
 =?us-ascii?Q?woxypcuYzbIQ4dF/OGXAuQrW2CUSdQ4LUE9bbIM9VshO9a6xv72kgcTm6vTs?=
 =?us-ascii?Q?RClmjqVZCeZUvjEDwMQrD9+M6HStLWUjQyiSRngd6sVpaDHJt1miY6P26ZT/?=
 =?us-ascii?Q?ncTO0x3twCufGx4lNv2gSCvY/kaZmzILC1K3GA9RQY1bhjQMp6r6U2HnzCDA?=
 =?us-ascii?Q?0AM7R8V4nnvISHQOCd6c+QgAHT8KESgZxkdjliVpFrMc4krs4NMsX3UWshxD?=
 =?us-ascii?Q?Rd7+QitzYZBbEdS/z/ame1XBmVsTgDDsK/Kg7PGT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e899587b-4583-4f3f-46e5-08db7d2a035a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:32:40.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nzx8lcuO8BC+lIiYBHoZteJ16X4iMOotcleq9cFaeKHmTg/6AEhC72rGBijh5T0GyBd4Ay3Znq17JiGL2Z9xaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a broadcast advertiser to be passed up to application,
if the scanner is an ISO Sync Receiver capable device.
This allows for a broadcast sink to discover broadcast sources.

Claudia Draghicescu (1):
  adapter: Allow broadcaster to be passed up to application

 src/adapter.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: ddfa40977c7e7b8723fc3ba9389822631ddeeb5c
-- 
2.34.1

