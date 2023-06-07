Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD20AC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjFGIVH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjFGIVB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:21:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231011BC3
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbUsiRixR4AUggEjp/xdB3Slk9VS8LQgm7AKdcdG+qPIT05SCVG9P+YxD/XDcieghsNTfTQTPjN72TAvWcf5jKv6VgosZn1qk3/Ho5ZkL4Cr9SqrcATOOqa3Zc9wm3f9/jgtnM+WlldVRFZVigRex95stcHi8h/0PDZi25lbG8Q9lBn9Ff1aIQZJGcOlVWOz58O81RAWal5fi9uY/IMSLvIOKxb900QKoKmzDZvVHMuGgHAI/MfYodIAusZV//eMeQ8/xRYUXAVmyzEyykdCXmGthi8cDzpohpOw7twV1Jgj8WgXI+XhagfbaH9TCvp6sby3hq/mnCOSYulXB7W2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJeFdGJWAalFImzG7YjvxDORIc65oIlDfo/fIjdV3pM=;
 b=f6PtNallp5KF4JPlg5R5zNfVO1bEAjRfwe4korl4uW9qyddv5nl9e0+EsTubgc6PFtMqEQ/p0RhiUbXIhvEeLd0JOjvoVTFrjZl+UBPFg4X1psdSD5NYkMbsl2AHEtVNfFYnoETEcSDRim57zUryEQ86R1NFq3mndAziqy5X1iyDQDqFT0aLfEtntsWWDcjm6EKBGOJk6Gq5E5xXaiJhYM1MBDhD1ufG9JSrGdBXR4D9R6KX1kh6xLHOhBQ5S/wi9kzCp50uNrTw7tMix52dO36lIQcXP6MecaJNG4Dj3rPcpk8eWq41cD+xd0rxUxpZX8yC6FKsJ0GNEAmKikHkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJeFdGJWAalFImzG7YjvxDORIc65oIlDfo/fIjdV3pM=;
 b=JkSbVolzTFY/phWb5BZE24slKKNBcOr6Q1lLJxED3nq6RCX5v5UCkwYkhU30GuryidL/VowKa5JQtC8HSYLrqRLvQtsJ8ws6o6JTOVzJvIC+oBLRbPHsg/0Pgg3tT01Ol9rpDozkq21WDG1h5P4TZPKytbFObvt/BklDF52QOUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7299.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:20:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:20:37 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: cleanup bound BISes
Date:   Wed,  7 Jun 2023 11:20:10 +0300
Message-Id: <20230607082011.4915-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b5244b-614d-40e1-5494-08db673012eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbcaCaP4km/DBA2U1qjTy4rDSmDTJ9avI3oIvBJTnF9PuyvSUFbUljxqiRB+7jQBqAxUgLX8Vz2IfC1MC0ayxWTc5K+54qvwUSQBa5QAED7NfH4GRFcvX+hxyfMWpk012vmZJoBLkSNoPsulSm+vrF1c99O/ED09m20GD2guWTvCQBt7Ss5OFXW3IIIpItmfAWnTQW6gfKwxbjkbqJCJHyhmoDqMryjKrTVf72vyx57jBO5UkTU3V+hDR/s59OtsnBL69dBPa2V74jDFOsT36HdEkyOnqbrqHlz2broA3e0FOYRNoaCCkZb0SHHclU5n9nxTh3qIwHI529GGxukcY8CHRe8pf5Tn5AcfAwKwWpdIBBsuey4EXGgNwQPdLZJdpjTOlf+zfo3XLvJb9MZOWTSf+hIkpCCQ30YJpxJs2wuBG1hOyjr7BdJ8vTvPY5kDyYPVciibVHrI7KfSz+nbgi3XpsTYJkK01kgjkC38lOY4dkNPefxJbIUbgZbiv+yvag0m3IC1ZT1UC94d1RTCeS2TuH9ihxs3/WF4nEtOBNu/ALGoPc9tKucAO8zjUDlhOHAqpEYMiYPgNsHJsg5M+c6C+rU6m62y2jJ+cRTYCsHXMgGWBJrR2reWqzCzsO/T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(6506007)(1076003)(26005)(6512007)(2616005)(186003)(83380400001)(6666004)(6486002)(52116002)(66476007)(4744005)(2906002)(66946007)(66556008)(44832011)(5660300002)(38100700002)(86362001)(8676002)(36756003)(8936002)(6916009)(38350700002)(41300700001)(478600001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVAXSCQOyRQjb/C2hgkAh5C4/GjpX1VMpvaUIEP6Qnv2vxkmX32RVQLj69N4?=
 =?us-ascii?Q?mxuOSOek0FXgr2XZUg3/3u4x9pI+8wHIj/QXOR+E9Dvo6DI63fWLr/nHVuqn?=
 =?us-ascii?Q?MG7OKKLF1oM0YSTsHwip4AfaNMHW6b87iPJL/j40wcYYP2Miz8cuRY1ixZ/Q?=
 =?us-ascii?Q?GnCzlXoq7tycmYkI3cTeNNeQI1kzf3O7osCqaE1kEXF80SITioboo5LvYY7p?=
 =?us-ascii?Q?3U+FehIEI+TP1S/+oUPgL3TBlMEv1S70Xh8Ysj9Dd9ux3PPDuHA0YiAVuy8d?=
 =?us-ascii?Q?DVrWEHsuHlfTMRG5tNGU+EicQHWZpeuRYDunN6WSBqYiEavstKBUnSFXk0Ez?=
 =?us-ascii?Q?WSFanNz5K/h678g/lWY2i8oxc4BO3A0FoEP45koF+4jauI92ZGiKbHRT8iFM?=
 =?us-ascii?Q?yiEnWUjNyf/yjm+vIgPMuZmLhIyi/lR5TjA5J1Q+Rz+dIVN/Sy/uZ4bT/k/o?=
 =?us-ascii?Q?8utPaHvAlMjJDr2TJgFzrtmcp/qhjXz2SMasGoNoBpXwVvaE1o3dNalaHmt4?=
 =?us-ascii?Q?S0uTN1y6TfgHrqRQBrUHm6seW1UhkHtDmaoNFY6Bo2OSvFWFfwl6tVjwD24a?=
 =?us-ascii?Q?9GZ/7cmyT/tt2dDHIxtfxSRYVBjhPqbr39yHkMYN2/cALCnrprRKQwFsrp2f?=
 =?us-ascii?Q?ops8Fg4LQ4O2l0j8TNQfz/Db5Eu8qbtQmZruLi2aZPw+m3x+hk0gLPRWetBH?=
 =?us-ascii?Q?RoGeWOxxtlIb8wvVYGEMF0WrfopAdh/6jvi4S/LOwA8GoXnT2xas52hnMUU4?=
 =?us-ascii?Q?DfnDaQDk5irLI/VYngiRSMtUg41mYz9e822plcopViQXjUflOfLEygxYP6Dr?=
 =?us-ascii?Q?LvTO4HHXCZ+Cuv0nfdYdRuJbOZfTewSLgTUT0QDAG98Bzp1qh4m2mupcnpTJ?=
 =?us-ascii?Q?qxUjzYhSxBP/TAxy68uI56CVCPMxsvBjEXmkuX9F5uf2MoAUSTB3BCUWsinn?=
 =?us-ascii?Q?0UlpezA0Y/AXqxqo6dAvOBjRxEfSldHq2dOSdMokJvVmbLH8FM3+6W1JLs1Q?=
 =?us-ascii?Q?x3oijC4hPyub7FzrNdWQ1XjYjhyJ6VSB63HpVZ/USdL2g0Zm4hW2TX22wA5+?=
 =?us-ascii?Q?+5RxrmUvmIqpMOUhihLiz2tddF6tNqyNUvQrM9TFBlEH/io7970MYcBomMeF?=
 =?us-ascii?Q?0wcrwMS8jsOv/4LR1kEBlJ7zGtdAYUi13nKSqk3TBkekwaIi+4W3A3nuycq1?=
 =?us-ascii?Q?Zk8WE5bPWEsozXbFkYaeiUs19UF0xdZ5hq94ueyDOFyMMsTno8M/tDWtkXcR?=
 =?us-ascii?Q?mWaP5GsN7oUYHK0FDx578Vy/qMSXzDe//QGviI0vMQ5DO4lwmUgBNYu8OseH?=
 =?us-ascii?Q?fqsBcA9V3m0ajyT5oQEQWeaqjLZapQN1PfC03lKmm6duh452ANsZYVpjBF5Z?=
 =?us-ascii?Q?IjKDg0oFlnfuwiPBVsrr87XSaFgIUXl0NFNcdd4578364Hx7+5xE0A71IFGC?=
 =?us-ascii?Q?TDNgn8l0UqWht+xS2ohjcQsUNPBGoqkQflesRQ96jxfQQUjctbpl29mwarwA?=
 =?us-ascii?Q?k72LHdBA2y0TTDJroGsUihWLTSEe8xl8JtZI/guu6peOx1FCVdnw/bR3YSM8?=
 =?us-ascii?Q?phguZ4zl6uQ4ayCijp6CYfb12mtR+cQmlKiKJSskA1IOta5IyN2azRwDG1kG?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b5244b-614d-40e1-5494-08db673012eb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:20:37.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ritfyctgFiLL1AnYs/ViuTL44xBzmplJ4PqaNNEDW7gZrV+9b8bucTnMYV1iSkWq605IbpKVmOQTkikG9698Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7299
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the fact that if a broadcast socket is closed
while it is still in BT_CONNECT state (that is before the BIG
was successfully created), the connection will not be properly
cleaned up - the bis_cleanup callback will not be called.

If the socket is closed, even if the BIG was not yet created,
the advertising set should still be terminated, and the conn
should be removed from the hash list, so that when the
BIG complete event arrives, no active connections will be
found and the BIG will be terminated also.

Iulia Tanasescu (1):
  Bluetooth: ISO: cleanup bound BISes

 net/bluetooth/iso.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)


base-commit: 817efd3cad7481ce2ee25fac5108afecbad56228
-- 
2.34.1

