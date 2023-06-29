Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB15CEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2Iwa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:52:30 -0400
Received: from mail-db3eur04on2088.outbound.protection.outlook.com ([40.107.6.88]:46837
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231767AbjF2Ivy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 04:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=modBYClIF/RSuvumdCeWZxRkN5jO3xz7kjc2CDhJJ/Vg+Gwe3eMsvGixx+7BMAua9inH/+6UJxLVPboOeAw73lsf3WLZ3UKFnm/k03t9XAxE3F3eCTVKQgYEr+3BdgJO+97HKfP2WMZJ8GTMRYgiqVzhNrvPr3W0S9ss6Jh/Sq0pl8G5YF54X8uuZu6RGb34tMSwe1Nfk69JciDL8SMI4iqdDGROJYSGsBsTWeopMRUqm1LPDe2YDewjFsVEh2w1jsa1qr+70FiJNKG3t79v1A/ZYHxNyTalyQV9nJkiV2ibHcNOy9bL4hWoBOMHhsMgpGH4g/5ZjGsGoWJZvfDcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZIl7L5Z6v39SLu+X+Pbxgp8eEXp6Yn2GKsdLxdP4Jo=;
 b=WKMnB9cz29TJp1EU1UFjFEUVzvXN9iQlDbVsxG/prBKS+B9K8iMqVaYZO/X5ntdQFwUK+t/WhcpcJh0mdaA3Hmhk7WJA83AiX44VPfRfKEaKa9mU9V8ShIPCazO/v/4Q9mT60zd2+GsUfJ9lzeWJU2N0OBVRqQk2HrNDuST8rDcVt3mwhC0UYdUMy40MKyKlBzUgEZcSAx1B7qQaPSI3bR6tSNv6GZYd2ZebcIVRBWEYRRxd7nnQFQFgbVXf3yWm0x34teGbaQkYPzYP6/eoFUlKCxrywmMtsE3JR/Tt56tQ43MAG/0ecViXolrYVqTAB5SEpBf+NILoBwd7fWddyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZIl7L5Z6v39SLu+X+Pbxgp8eEXp6Yn2GKsdLxdP4Jo=;
 b=RhmL9PTjk6jVUnoLf/qJFefz2lXP/fpGzwsnLyRR4Bp77uKu775pE9fkc/MBdEeT6WTtZBi41SZ2311mhIBXoqFFOVliNP9aNELgyQhZLgbFvKN6BtS72fEbs8BnNZcbNdhgUDlNcV6Aa1qqJNERmd+3AVf0sWtsb+3eIzkFEIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DB8PR04MB7132.eurprd04.prod.outlook.com (2603:10a6:10:12e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 08:51:52 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:51:52 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: hci_sync: Enable events for BIS capable device
Date:   Thu, 29 Jun 2023 11:37:25 +0300
Message-Id: <20230629083726.8505-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DB8PR04MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d2a57a-3ef3-49de-7c67-08db787e1501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leyagu09FP0Rk8KxWfIqQwmeRwQFpzWRMNzJan+oougu0XtwoUNWt7Vh5OlZEL3DprIkWui30Um0l3cV2f4IUhgMxE4tXLI1J5s3hGgu+Ur3qkT+uS0L1oTiNW489i7x5oDopf0rinJu2nfaDeq0IC1Of4tiLr908HS5xhSIfzlEnZNkxWKhDrUJtx2oCgdBKKTMU0DKerbV3eDjpMiU4Ccrc3zTZN7Mx/WrNUsJLsKusg0qTTolERwge1z19spHwk375ifwOVzqTLs+TX7Vab62br4PqY7PugSa2Fbgx8HkqX/qdLHMZ+/62m4qLZTlXBKIfHkaoQfRPmZdVb+v5VseN24mXwBIGHqOMbhV4Xa9G1DTpbuVC3VbAaUHtAhEIO+JyDM7igi6qBOxFzqhvf3Zp+kQbPxRG9QG+ywBAR3ovAprPdDGZw3eyNbxdU8g0jNoD0iZrCPFPEJuv2qTuCjhtgWVwxYJ1X2Tu1qjTJE5Ug5FCeVqyWwgAscmthPkWr5mjc3MOakiz9nfr43QjwxcYjIwfjgVn/uR4MFjZTapFO72B4D+7PnaT5zyo+AIH7vfcfI/X6shwkavGyodgXXqA+cSzpJyXdhM707s0+tj2h4HLBtmnAdtwxwGgpj3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(6512007)(26005)(4744005)(2906002)(86362001)(52116002)(6486002)(6666004)(38100700002)(38350700002)(2616005)(55236004)(186003)(41300700001)(4326008)(478600001)(36756003)(66946007)(66556008)(316002)(66476007)(6916009)(1076003)(5660300002)(6506007)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/TQV4hjQFHuWJdv8qOruQglyCjSmNmLi513XCv4Xv2s7zK1I2AN4jiQHYu8q?=
 =?us-ascii?Q?UOlo5FHcgwccXioPy2ulO40Eb/pO4J6H/RAl/j9X4255N9SDYWSu4kAQFL82?=
 =?us-ascii?Q?k+i910mz9cdHJkRNhGLScEYhaK5gmZmXmVqhoP7dY14wRQiMEKY0DoWgxHEx?=
 =?us-ascii?Q?kW1Rbe1xV8wvVqbiURcSN8Ch5URsD9OTFsfvO41FV+QJbpPKB+O8PJu2vWXJ?=
 =?us-ascii?Q?AsZJI9bOM/KsLPOt0k+GtzcKxGSyCfPuDlmeQQqWdEL1nA2HkHklmNHwemyp?=
 =?us-ascii?Q?dWdkXxHOb3tVYt6JKG4HSmokRntZdbRwFSMkSkN0dTR33BwEFO/FOYfAtBYM?=
 =?us-ascii?Q?zsQ6ctzgL6tAPKwoI3u8hLZzZu5f+cZJfQp0A4CbZq9Sty5mXD/2hFzecHE2?=
 =?us-ascii?Q?zLgPU2bAYtnFpr53YxfeGgtgpr8Hoqa9sNEldOcwoueCHoDNDpHQ2p+xH7a7?=
 =?us-ascii?Q?UrHwNtieU21/LlDd9cndOZ9MDKLRW+HmTRpr/q2WcxoZcnVsMo/ZEIwE1p6T?=
 =?us-ascii?Q?znh+oqmeP+zxDi+KWI1oUocLiCcD0bfvI4X/mOhWpPSNOQCjoOsmPE3EzADe?=
 =?us-ascii?Q?P4365w/PrxKU4auJb7PKOe/7mAd2sCx5/mef717IBV5mTVTDaD3qpSJNx9i2?=
 =?us-ascii?Q?9BWAA7EKQfn9fTC4QGYo0sJdsw1VxDAjVtCCIBNI7i/FgnZRvdL1tHSYiVHQ?=
 =?us-ascii?Q?31wULkKEzkkmmGGfqCJ6LhVm+We/YIq3i5STqplx8J3DATyu9q903pkIVNH8?=
 =?us-ascii?Q?eNam54sUxf1Ayf5ei14rXX+NmMXq+fwO71qc8yEFPFn2LiZQJT820w3zHjNk?=
 =?us-ascii?Q?jQyRhiGJ/91NQED+MbZzayEmZL75MiXMA7isk7oeP9uOpUR43cV6VLZC817K?=
 =?us-ascii?Q?S3TMevW/JB/fMZm2LuCzFGRahm2iFOKcU7xNHUfWZIYMO0lSN2XBCx5oPIUS?=
 =?us-ascii?Q?SPHfZd4v0v9l5B1f19dpYHVsrzF1r0KQgDLmqm5cAEETtf3ihR5IFFW9VZr2?=
 =?us-ascii?Q?tOjrkQjAG3M+vUE5ZOaZVVQ3aT1TBFk3OU1nwJO3XDAH+cPwugIYgO+lc6Jg?=
 =?us-ascii?Q?e2pNOqMBsHxe2vao63mYf6CY4sHFJG+JAFjFR7lOuwbfXU4rR3V+RIaMnvTH?=
 =?us-ascii?Q?OITxIAWhAharEWfadpB+IhmJVQU+yL5oAQeuGCnm0xClv+lJpz2BdgskgOkx?=
 =?us-ascii?Q?lcxNVVQs8r5UAvS7trloafJVi4zzZ9nrB5B0w1QUqyb5gVccXc6dETxVsxGc?=
 =?us-ascii?Q?WFkL1bwjS5as0Xd41fm2LfuQZZxW5bkKFXKPZ5vubrwhKbwpROQCswI+sq/0?=
 =?us-ascii?Q?UZPBKZ2QHsyc0D6GS27q55P/CWHdE8ZYxr6SuXPHTHu1CYYTMbcLzWgWQMSg?=
 =?us-ascii?Q?5xIiGE4jVmBynCoLcVw121Y2hHJGBvakq57q9wv3Y1F5kMCTBn62QVVlhMun?=
 =?us-ascii?Q?Ym3tIVVM8stJRon9zOAf7C4EhiCTLO7gYfZ622IV1yJK2DRaomN9K8xj8BOE?=
 =?us-ascii?Q?D+YcBoV8aeJdj+izjjzgjamvI94LWrmGS97Anj4miG1Uwew5mbnLOyjU6rg0?=
 =?us-ascii?Q?OGFfYOxLcbB45aPnbpPmffqW/PFKJwTNdFJVdbjk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d2a57a-3ef3-49de-7c67-08db787e1501
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:51:52.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LUw6XlUTpdsr7CYOVWY0WtCI4ZP8S7hUHuYiuWjJlZdW+iVi/StxySig4WXPEZCXGk4+ScF0Gh+mRFZX5UlTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7132
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Synchronized Receiver capable device, 
enable at start-up the events for PA reports, PA Sync Established
and Big Info Adv reports.

Claudia Draghicescu (1):
  Bluetooth: Enable events for BIS capable devices

 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: e63d8ed98082395ca509163f386f5b04f53872b3
-- 
2.34.1

