Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872AFC00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 10:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjJXK6C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjJXK57 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 06:57:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F180128
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 03:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ5nLqTyteSM9IGTDZJysPlFIG0m6q7a99c1vRM6h0S+A6nKL8CMRPfsw7AyqDqYnelIYltyVqSvE9YSE13+Ej37jh4A91KiRId1r0KuqUhmP6gqYWAbAmUOW6wW7Uid3JHMjOMHBNTIX8d4uptPVKkmOxKhRbPN6vc16LceniEHHV5hru/PbxyF7HyY38uxfOZ3oK33kUh35kRWQ2uFx9KHxJ+scc8jI+7vib8ahtBAVOW7e2Q0ajIlv4ZJsGT1gkzhP/BSalsbaPdfWNc9NfTcxWR8tbt/moCsmXZ2PvOXCpc/tGj9bdl4m7bWY196qiFql+JVJWasxgygBGpBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSeYPKiTA/X4hTURzqBQCRD4gzCWNvm4uGz0eYBPHLM=;
 b=N8vskWayQKtN9YIedJDTB9ez1lMtT6reJA5ycCR7coYwysW+QM71xZu7skIDMuuONFa937bPU6whnYrYf78UL3NezzSj7QVh6imsgMT9I7t73LDzd9nD0xFP5om5FN9OshcBJqnWlFeJbKKhKSj+Xgufap+uQgCMcPWXHADyjOqD28C5WPioUU8fnS/3FvmfqaymuRvTzOZflA96Ry4S9Q7BkRkFiWIz30PSIlIwpHKGwNoaJBozdGtbe4SB62epFytnQQqK3+sDTzR0MGy4t+aOEL8TWHf6/Slv7X5oCJE2cgggryaQlFa0gRClQzbkb3XNyqEdRbmnv2cL1IWTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSeYPKiTA/X4hTURzqBQCRD4gzCWNvm4uGz0eYBPHLM=;
 b=Ww7ddTagXN9nND4IcAjosKRYzKa8kvycekD0zsd0aX+Boj5q7nwVi5+oChYwxbt7KuZquS+/dt06C1iR6vvxiVprZzIWc5gfygti7CMaWiJP/b7bZOukcBq+jE+6L88l5pTA5kE88Gubuh2vDTowo2/OgAqsTEypH/OAwVhRF9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9458.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 10:57:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 10:57:54 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Tue, 24 Oct 2023 13:57:34 +0300
Message-Id: <20231024105735.3216-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR02CA0043.eurprd02.prod.outlook.com
 (2603:10a6:802:14::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 193fc1da-8306-4d90-4c84-08dbd48012f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akwdMzqPOtQgtW2N5rkTUKCvprceb+ivMFWYe9AWD0JdBT6GK1tQESXjQswQqT/OlWTFXtxLrQyXTVml2yft1f08SA/fPuJ7cRYTs3Ct+JOeTDOemN9wKS8zAnQPVdxopJWhbTEDbHgAZ0nTBuhm6s/KyLDRPJkaAbFPBkNEEhIiv4sn6GTsXL2lMpeJVW2S60CZsLoxiF3Yf/tpCfJEDp9sLARRNYCBy7NAODhe50GaItWt4ljzXhuBOmKqzEBEIeeZ44fZJdeSBBeoKpU75j2OsrvwHGkg3o5iSXXsgQzlkKDEg6Qo+UiMzn1jVsklLjV7cYa5wJp98QwgGMa5Q0TbfcZM/kCxIVC199RCsvIEUlpE8WR1Gnf7Dq/WGUrZcXytHkvvAmZ0FqHvbNUzP06W+lD7HI1cHhJzD5p/kj1/lU0R5pipknqiFVHrwwdvYfuQxrnZETJkULIHbqVi0uVM4aXz+1LyFH/Hq6eceKCy1S8V00NhIbbTRPOC+r4vATwnv9ekRXR6AMBjrmNWqe61i/UfMRXhMEZDYqESg2Ie7Me1Yx3qyCCutE7xD/Ee
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(6506007)(38100700002)(6666004)(6512007)(66476007)(6916009)(66556008)(66946007)(26005)(2616005)(1076003)(6486002)(478600001)(316002)(8936002)(8676002)(44832011)(4744005)(2906002)(36756003)(41300700001)(5660300002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4DenC7hwYLRuqdWCwaOrVw7xH8LxKYQYn0MdfjBSFn4XlLDuS6DU8SI3ZIN2?=
 =?us-ascii?Q?HDBWHm/epMIHmxbPKFRlBlmxtudDMtl3K/OIUlC+j8Cih3gaNjozyZBuEifj?=
 =?us-ascii?Q?dVGb1v8HjeHd5bllo2eYq2wEkORQ3hJv8GlEfp8u6u3aTGZs3a61dkkDI0a3?=
 =?us-ascii?Q?GfVxgwJWjsgnJYYl2da4gFqNGxbwuhWF++1pMaIm0JQP1LBlpOyzdKXbfG7s?=
 =?us-ascii?Q?YmC7mSHqdXBULwbHQ7ViW1dBGz1ox3lbZFzamzp1GRU/Qocf513aC9/XBtXQ?=
 =?us-ascii?Q?LCK821Nh0c2u9MVgaluwBSYmfc76zNDUQPHNUztD6NY1SHZl3+twg/QCc2dr?=
 =?us-ascii?Q?hQs5tdDvJBP/yADLGQc7QIpuEDVmqU8SaKGFxGQ+vkX9f+zwyoKdrVMEie/5?=
 =?us-ascii?Q?BhVelbpFB4BUEAAuDI91buIwB6BzlZH3hCAs9Sb9IeaP67D20jrVYVmRw1KL?=
 =?us-ascii?Q?9jSsWHoFx0O+gVzxqjzCPQXdKNXE3wUMTqteSRdtCTNt/ShUu7vMxWMpPH9K?=
 =?us-ascii?Q?jwoO4stJUXfEWYOPbypbQJYa7Ae+gs1pFw1uqMJZPnR21t32WYRuCmCE/Ahy?=
 =?us-ascii?Q?IXBdaKEDpv9xdtysreRVe7FlEpAGK/n2ZK+1nX3/N357NyB5JsXqFdw3Zxcn?=
 =?us-ascii?Q?1hDn9vimFfpAv6NfDBz3bQEXlvmTP9A37gLLplQpyxAsZpATQZj08mvbAynw?=
 =?us-ascii?Q?2X7v8S1DKcXaky2J9iK4wJg0OOrvuYJo4vae5xtm8LD0da+7Ng+YVxFeAtST?=
 =?us-ascii?Q?UGQpPy3n0HiLokY6WTeKAgADnEbg8YQpn/TI1oa/6sFAcCVJKHYio6LlgMUv?=
 =?us-ascii?Q?RSMlOT24B4wFy6ElPi5mzplextto0t3bmoNp3mnxKGPlY63Iyt1RkirXHVpG?=
 =?us-ascii?Q?Im+W++ejLEsQVOERf5LPjfIoFBNVHJSZCcde3AqkwSLcLDi0vE2KyFqWiSKi?=
 =?us-ascii?Q?P0rl3bj9WA5Xf5XYPuBxRPmdN6JyWs+vEX9a4QGizM/+1E04RsDhGySYOmaG?=
 =?us-ascii?Q?u/3NZpdvI5F5kdhyYoPTXTVXXfFEZA0Eh3JTX88g4B4Hv058HPbhNCtLskLl?=
 =?us-ascii?Q?rncxl6bTR0zKDiyZlYyrnIsgbsdWz4OSXwDRAhatzuZR9OSqrORkkTEANmrP?=
 =?us-ascii?Q?p9jGyiWKWcCVm7mAyk9CX6lyK1nFutoabZZ5O3GMmXUtXC5y/isFV2+MEyCl?=
 =?us-ascii?Q?VV+rzAolWwwCrdKG6OQg89lZ+VH82OWAxqJC7Y0jmX7zSARQ72eiE4cPE63Y?=
 =?us-ascii?Q?Dlif5O9p+6+LChq+x53IB7Hj3To1svQtkyrNOakeRBVV1omfozZNQw2fhq/t?=
 =?us-ascii?Q?rViQt87sLIEaGotFYw4zguDjDMXgRy8ur0rKLf6HGwinsYrbjdmLamuf+ABb?=
 =?us-ascii?Q?a56IxYnD3G4g8QfZmpM/WzmxMtAC+KN+0ea5Dg3S3Ymu4nLfJmgIXvMPttad?=
 =?us-ascii?Q?+8Mjfc4LyE0LqZCQ2+Ac9rhYxPSYPzCAFvK2jIoBIRyc7dEDOg3oML217UvS?=
 =?us-ascii?Q?543zA3KVFWOf9XPkVA4MUvnSioAAt8JpwIVvcxl6MNgFQMWEJtyWw2/VF4vr?=
 =?us-ascii?Q?E0Jd/iUlWGkY2cRV5Ow6hgyne+7AsNqofqcjJGqXOk8fDsfIeIpGV/uyTq7t?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193fc1da-8306-4d90-4c84-08dbd48012f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:57:54.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjwXFh7JwtNwRUE+j0DJo+OB53lOZvgWUKBldvqa9s6FaPjhE6Mus1zpwnl00b0sMpiR6UvR8piY47jmDCizgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9458
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A Broadcast Sink has no way to know how many BISes are available for
sync or their indexes, before establishing PA sync and reading the base
struct.

PA sync is established by calling listen with DEFER_SETUP and accepting
a PA sync socket.

This patch makes it possible to bind a PA sync socket to a number of
BISes before issuing the BIG Create Sync command.

This patch version fixes review comments.

Iulia Tanasescu (1):
  Bluetooth: ISO: Allow binding a PA sync socket

 net/bluetooth/iso.c | 67 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 5 deletions(-)


base-commit: 2fddfadb0478a11952d4a3d543273f28d2c23c03
-- 
2.39.2

