Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5259EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 10:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjF3KAR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjF3KAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 06:00:15 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A51FE7
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 03:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFF8CB4Dvm7+orFbU4+/kkWOobJbbt5hYCywH3Kaj4wlnjupFKgzcyOWC61WN+v1I35wcoDWnPCSDKwZyGIoxTHTFIGCXpCJaNs5XYqpzTydpAnvse+s1BTXpvcZwj96aUZ0MaZt9JVWE5M0+KXn34kTpJfYj3orJNghIc9DSqBL/o8q6LezWfpbme9/cD2uQbgDLLtbOer7kJsEJOpWoP2RvzaodGVBchdSlcB3319BktjlJdKb3opYKzX2gszhMp1986FeMoQz5Noo19dhiELPH78pvczl0m7EzW2WtHtcexP0/LmTawcDvi4iCwMsXvxq/q5GmgLWu5t6tQOl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa1E9C0IJqDjZnuh2+FpWUT8K+PuGVdFJJAkyL8m3NU=;
 b=TzjjGjV6WvAxmNNXd4TqSkMGa8wwWer0SVVConAVwbpPKfY3G67QgeGkXw0esTCQ1LLqUojYVoBfan+sxbKFWPusVHb5T9F7rvvI5FGENvhBpDcFyrAwA8Wn4Rtpc2tsR12ZijI2InqcU5jb95lLnbMd0si2usk3rcfQcellZ/uJXqF7NDQC/CKbOnxdiWpH0+Z+vu9R2hi2685hLDYYbHpHYsMZwb2RFLXAFuBMPGOzwwc2xO2aanMDcNJ/HpYRRskpI0YLkRzWgZLPej8w+y2nmP0BBKcCqQYXsrBNSyMzLbapY45Y8uUfxIgw1bD6Z+nP9MJjV4dYTKwHpBFyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa1E9C0IJqDjZnuh2+FpWUT8K+PuGVdFJJAkyL8m3NU=;
 b=oQ/OpGmMF+WM+/tzWsp5DLHPswBl7zn0vNMhoqP92htAEfxBHCnh8uom/98/2EUVXosCBU+gh2Vxb4uTne5ORqoDIps7jzOYWChx/ZxQsyj5wZgIDtJWtcOD7geVfEWgZpHvdxdNe8NdJ+55pD9/5YeeVOO1ILReytyk0uOvEl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 10:00:12 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 10:00:12 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Add support for periodic adv reports processing
Date:   Fri, 30 Jun 2023 12:59:27 +0300
Message-Id: <20230630095928.436569-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2031f5-7741-4fe9-81b8-08db7950cb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7+9uV5w0CYOep7I5IcweXclN2IgeCxtAOSNw4pz4SBvZpRxV3TG9WiMqkyZT3UCXkFHeJKGknggTscMigGTzm6ZykVggc/+m3oFEgiKaluXT/KS0x8AlUWOVp5PGi6XjJZrj0hr2s8b1PZ1M7hzhx4oV+VIIOl00LV6tjM5pIHrrFe5s/MGs4yMlIZ/eITJS1KWPkBSN39WXu1POkdO/yqwIdc88SY5D9uC9P0go3YoMmsUeaGrG8Cg6SgilUR5ktl+o85rXLjHE5Ln7QyM0yOfiuuBzIPJt+1NhmmLjAd+KdWpfgzPGDV0n7uKhopw99cM4Q54IFeKrvP9Gj59LllB9XyIxWwuKmAhd2/o0If82rcRKboZSmCJMyRpYhTQ3+8Xhmm71dy2no76pPn1qJsqYwbhw3yBn8jTl6XHQ0G+MQC0lsDGrsopUAipbtKOQYK+F5IjwLAC5OFHNHxdB2/WOiM0pxvA15gPelUc7YUZAp9TnlKN0PDUuH6zTK4BKFuSdX0ODluQgfDS6iXIzS+h7ZvyptAzYt0UsC90l3Xhcb2drCtl+PsX2shof23Rc0Eh4JFTSQZRZNwta7aBnAtWgB4Zzxli2hjyC5YbEa1ON9JWIVqwFWXEU2oqi2do
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(55236004)(1076003)(36756003)(5660300002)(86362001)(66476007)(66556008)(41300700001)(6916009)(8676002)(316002)(4326008)(38350700002)(8936002)(38100700002)(66946007)(2906002)(478600001)(6506007)(186003)(6512007)(26005)(2616005)(4744005)(6666004)(6486002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5A1Ej08lGa0CKItbmPb/mqDmJcmBpVwfQTqp5D/ZAvvE9WG8lDqogEM81hon?=
 =?us-ascii?Q?QGMyKAz/QmYg6BfkQWwJcVpdSn6GRWdEb/otdCo/0Z5ovqh8F1OnNN4XElun?=
 =?us-ascii?Q?0evF6q0s/+aOuL3UbLw6o+1AgHKV2ldA7eFCaPLndLy8lthL5bemvxuxdUR7?=
 =?us-ascii?Q?X50AXY5aFEK9mGGmVS53/a0GiGc4r2gliaiEI/BOC5DIugV6TBxeMskHb90n?=
 =?us-ascii?Q?XyMN9JYuPXp01ynIskHsV/hRBHlLQu+f6A0ZRJN3ADsq8Y1nbOfnt5CJE1Qo?=
 =?us-ascii?Q?21YPOenT8L3g0wvTrOjbI/DQm+tvP08+Hw3RcsmrWl47eCntrLbcBRJic2Ir?=
 =?us-ascii?Q?4hhTIhW+LgEmGP7s1c8kfuKA/PtSJsN3TdJsrC3MU7ciiolJ66oSj2liubdy?=
 =?us-ascii?Q?wYJ3r9on96bGzjeU9xVYVLMrWwMdG5kfIN2C0SDSeeSCoPYM7dbU0G3z0VI0?=
 =?us-ascii?Q?sxXwqo+mAAGacUfzwT2w6oBiHlGy4Er6ZbSaVQbvRQuNe8/SbkDFmV1FEfBc?=
 =?us-ascii?Q?m2WTqIafmpkSfgUPBW7aDtfj63UX1C+LqyNjPdFhfVWFsnaTdohx8GjdOrvX?=
 =?us-ascii?Q?kkbyniS/I8CXMI9ueAGx1lVk07YRthSyg7Vn7vaJQ4kP9bi3bdOxh4cX55OE?=
 =?us-ascii?Q?OHOE0Vj28S/WKI5yvjUUB6tcZMeoHu1agM0CyxRaS/KkmwwFHbORb5ZIm4vl?=
 =?us-ascii?Q?rJm/0it6dlMq9qNC/aoD+vu0/MSVew3Yoh+LUI++Kz4yPM6LsLC1Zup24NsV?=
 =?us-ascii?Q?UY/XQITMofr34zh/Y9AqMYDYZQpslA7xFsHeV6XTquruYI0Kh2MI+oXJ5MQ/?=
 =?us-ascii?Q?WyqMRuuaXMaXk62wOjxiY/Fyk/aJW0V1efukKojUNvHh7+T3UKda3/FaBmJP?=
 =?us-ascii?Q?7ajfP7yWU2RjVDBNErlc+vbs0uIAkEe5dRDxCsSs00la+Q9RxqwWS6XRzY3j?=
 =?us-ascii?Q?7wtdy8x8P80BQ0l89l6rDoyAWTkggIPXhyxbWkIEVc5bXbsoeU3jz1XhCZ1F?=
 =?us-ascii?Q?sBMRDilnklsWQKBAJKMiv4ry9GuVUCwqicC1bWTmqQ5p/nL6Uc7iDQLSRnzH?=
 =?us-ascii?Q?RMMIhvIMEMe/axJGN0A5DiiZQlNH22dY2EqfTqriznk6ZiwhcEEVot+QjU4+?=
 =?us-ascii?Q?G0ORAqZNWa4WIKPCb6PngOAfi1vX6ckSR+eagiM6t3lgJrYKbXgGZMW0Dw+T?=
 =?us-ascii?Q?M61pw7Ie2wNSFP6xBE6sKB0g06OB0XNxVEk2XePLfBS979jSYX7Qz2pjjTjz?=
 =?us-ascii?Q?5aOFeXmZGGOwO/hO9vkyT06WM4obRfxWUfFsdB/SN5EFVFWy6xvzRHO8qBBA?=
 =?us-ascii?Q?I6sdcTHndC52pFr7nlsg9We5SeJV1zQLM5GLxCsBqOAaINjJHb8LqcEZZIMF?=
 =?us-ascii?Q?MC7x0SqBReLYLCQEccZtvJa2/wgbOUNV6u9MsdtuyLg8UZ5uOpC4UMNSo0e5?=
 =?us-ascii?Q?x7MSW6ECTmfluysUmcCHP2E9J1hgoi0s1HTTU+zKYwvAyYrsbuTxmxhyoK5i?=
 =?us-ascii?Q?V2ZjEywqbJwZd2yJF643If6rTINSfkiPRE6nB4CNgym7YpWTvGKWu9KbmHFo?=
 =?us-ascii?Q?xzD/rHOL0JYWwIcsvibxhcw1jBApGaXhmYkRplt4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2031f5-7741-4fe9-81b8-08db7950cb42
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 10:00:11.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaYWal+hi/lrUZe5W+ZyAv0WlmVIWQUnk7Ma2syFAldtYOmwCNd/MT1j84X23aJunDAWnXMcvH2Nuio0ANJ94A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Periodic Synchronized Receiver,
the PA report received from a Broadcaster contains the BASE,
which has information about codec and other parameters of a BIG.
This isnformation is stored and the application can retrieve it
using getsockopt(BT_ISO_BASE).

Claudia Draghicescu (1):
  Bluetooth: ISO: Add support for periodic adv reports processing

 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
 net/bluetooth/iso.c         | 28 +++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)


base-commit: fd859b4a38153b4d9e1942ade471f4fdcd8d224b
-- 
2.34.1

