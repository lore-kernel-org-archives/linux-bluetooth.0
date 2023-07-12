Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19425EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGLMXl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjGLMXj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:23:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC41980
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xug84vxVzGZAfws+qktTDbXGxRsmtWUP3+EU9OGDy9YmQ+cQb3VTDRBSkrJLAHrBMbLru5t3JvErLoGHglYn0Qk6YdxMeZH0IsuE/QYD2o0orDtQ7UPKcJL4kveEb9JIUhMKzprMZa26WM29KTJDnfYhIP2n1vJmiLnY6GmC6mGdBfClBCq5FZENooaTGMmwk7/M3ssaKvg7CkFSUrVfmzWdx7QGeFl9CHBGYDMyvPLxzsvUk8BTRtkHRh16sWqrjJWLl7JF+xzlQJryLJEoc5dCj0qLT6fzcj4l0dpeOya18pJ0UnHKq4FepsIGXktwn+7eQ/KzL0q2PNr+FVo27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XUqFkM/Gimatb6mvBGZi6nXPehNOlRRQRxS/V4Jsd4=;
 b=XX7FdrApIk9rGUKlnqvLe17V4Axx8aIYsQHmGV91QNajD9OiOPRlq2p0pgXAF8TYDucvbz1wFIbO+cHpczCOOFG6s9IRVixMWRoEKX4XzqBE4YJytfzCsrDV+wqHKVgrtasgrVfuhNf+4d6O9TN/gS5uqGDQ5CCEmmxqPJE2oOAsf1VJ72K2E6UZsjxFa/quksKHdJJZdJHTmv7eV2iSklnqL4vKuLQ0uc+SiwwfUO0qxbFRqJuWQ52EA+DFyKQ3H9v2xyPweZ/gRrUxgaBB5rhp+XrfZMPlkxL2ZBhTLaTy+2A99otgAIn3TxC1Ncq8TJeWQuo5VnZFI3CZfydZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XUqFkM/Gimatb6mvBGZi6nXPehNOlRRQRxS/V4Jsd4=;
 b=PbF2Qr/5WHnZxZxUlmbhFYfKjKuZQ0t9PUtHKfUeOHKk1cRizee8Qn3JBtG4RjRbG9XQzJGzVwhfAVbPoIIFWCh6Cfu78JuEPgihPA/6g5SDHTSh2ldby9gjSWdMM/Ig+m6x6whXhWR+jri/sq9ARWCX1mCjfJMwIHORUC6rM5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:23:36 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:23:36 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 0/6] Add support for BAP broadcast sink
Date:   Wed, 12 Jul 2023 15:21:29 +0300
Message-Id: <20230712122135.7734-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:208:14::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f96b0b-f232-4ef6-1405-08db82d2d0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qrseIfcEPUHYlrVVjEe2EQbKqErPuAf0okHuN80G5OpsXVd1uKpNMxQ9d27LABI8S8gBehd0p8EMRFT3yN8Yg3KIWJOLiYOUDm72OK7SKBDalbuTJwXvqxcNshxkuSqmix9Y5r6ZfgcXVnuztjB6/NX06WDejpB52ue4TLWNVby+uvrExRx1a6UHP2DFyfksbOlTQ+zAtHrlQnXqLF51Obg9ZQy0WVmIZWMEGJp++Lc6fnG0et1nhsoXwrGQi7foSgJk7KFT5MMIJ8lyN+5KZxg6XYoQjXDpyqZyKcFOOvBudYgcZCJB/owU2NrP+iXedDYJOcrrrli6MMR1viL5viGe/xDARcSIFb6+J2nuVXH7P0fMnUCUX9wSnDjWUey1XXMUeP+Tutg2T/GOs2zYKmgPfocpVQ+2JJKKyVuZYjIDRtT28cPE5yigaWwNWegZy6swuBWEjVAsKtdV1YMrE02Gme+xh7nEn4rFlRgQP3nYhnjdbJdmrtQ4yBXIG65V9TWevq+3Smf2UBT+4MRKCp6JlysG2wBFjmwGctHnrzfYJysbb8EB3oQZ2scAMSuj7aChpSlXkBiJ4ICDAacbGRHpwYoJJWDwiL5/Udr8fXUXNKCWNhY1XdMgX9lvvL1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6666004)(6486002)(6506007)(1076003)(26005)(55236004)(6512007)(186003)(66946007)(2906002)(316002)(41300700001)(6916009)(66556008)(4326008)(66476007)(8676002)(38350700002)(8936002)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCorJt0dTjwruWk/IeHUinqAE8opSAIql+1HEzRVXwJh49r1FrAnsf8T7BDK?=
 =?us-ascii?Q?E7tdcErOaIt+lXPsSLCtWcIivJv7GZy8vFUfvIM2/y74zqXZ/d9w3x3DpT6L?=
 =?us-ascii?Q?qqC9TYSF/BRLPS4n08jalfaLbNScFV8KwLrAJ8kWEWCiFbmk8rpYaM1PoJQC?=
 =?us-ascii?Q?xsVLlH5jAAvqbgbPmsPMT/JaLptjSyjagYAXBUpPFfLShhXO+LNpTA+liDxj?=
 =?us-ascii?Q?H+/TdGG6yuA08hlKgyHEMuTXaB7yqwKvC4LRoK3M1uhlFMRiG2BkL/s16iEr?=
 =?us-ascii?Q?xC03WtD+9XV4CcXjkWe8A52KBufxAdyiWciHVbZ2cuAtDX/QnRSzPbr43OQA?=
 =?us-ascii?Q?iiESD9bMWOtJ4pYQz16DvDfBPUpcfPPQk5uHuzyLnrSXLsZRAkPEl0wYmkBp?=
 =?us-ascii?Q?4zTO7cl/Oz5azm56GjqQNmW5Bso3H0+yLiBxY+dyt7uTjrpTgCM4jlZTS8pp?=
 =?us-ascii?Q?SV93t5/qYsKHi9VcfOLov4szi/OqCjFU6Fg7n0XfHEOQexnrJOrROIwY6NY3?=
 =?us-ascii?Q?1rqvzKcVn2ms756MXIlvdtCUfy1IzpvpRjjZM0vwChfVA0neLzpqwK9qrvXE?=
 =?us-ascii?Q?7jQ6ORQeyJ1QktXEiPhiHgnv2e3pzSh2ynePbV5x0U8ZAF7MHRfkM8bd1u1Z?=
 =?us-ascii?Q?3afEw9u7qNrIzSXlQO9uU7xykFEusLGmbioufsH3HxhSQO2gKkehOSW2SEok?=
 =?us-ascii?Q?/GkJ5v3rMBf4HeVk6pekg07R6ODKq20YNE0lDmodsCOxMdkkqirMYcWwP7rp?=
 =?us-ascii?Q?MMf5ex4NUJSXJiIaCrhxb/VyWjJ2KSmlenk8J7LBSngZEDeVCJwEkovF6BRF?=
 =?us-ascii?Q?Kys/q48U101HzMTEHyQ/Gty1KyBFBfizQBTunP/W9PwxsjHuxrSNszbPOCRj?=
 =?us-ascii?Q?8AptuwebC4ZY2mbWcXj3GlWNGQnhXOlYMJZhhRitBtMI/4tW1441ipsvCY52?=
 =?us-ascii?Q?nvNkz9tFSpwbETuqhg683vRnk0Ue1Z7DR2O+QodhMtZWWq37qPV2S9WdjvDi?=
 =?us-ascii?Q?RJQhvuYXxw5Aveywd43qkz8M/FWSoKpwQvSv+iojivCGRm37IXJ4pMLSdSQ4?=
 =?us-ascii?Q?fYYLCf2+0DyivpJpO41Fh5QovCvFp+JDt49c1akxKk8bERKk+IX4MVcLbive?=
 =?us-ascii?Q?9uLv6+97NbLyb8XxFLxxJz0qrVJP49wEP5s29SQ1TYuc27U/2qtwIxMjgbyk?=
 =?us-ascii?Q?cfygzBJXN8/SpElntS8R6dw3ijf5jsU5rCYucCiQMi0KjCex6crdZ38eK6de?=
 =?us-ascii?Q?IBSy99zzWzVtMvkXTTe0lM9QndBkA4HwBZz0Ni95uZzhlaJx18TGoD5T9fjr?=
 =?us-ascii?Q?lD2/YzMHFt4peo3Coa4UBZBFRehLmljTesmCug9+uI19pemxYVXHmmaZLYw3?=
 =?us-ascii?Q?ZzR5cdD78zehQy+zvcC36T2sUBg104Ua+NlTNr1jcDX1iO8mKIQZzGSd4oaD?=
 =?us-ascii?Q?DOuiXfSeu9scZOZgL231DIGH/SU3hbwV9UU+hsUVyTJVtJSo58GtWH3r5P2a?=
 =?us-ascii?Q?VaUnhw/Klu2EbCuL7hmgqv8Y1YbsSWuqClsjvYTxWoW7GqWktq+GOmYlEb4o?=
 =?us-ascii?Q?D6UPl5cELTycBFDVmvWqJbqk9gxcK+G03dKMY/jN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f96b0b-f232-4ef6-1405-08db82d2d0bc
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:23:36.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM9c/TmDVw5fQStq/5whxu3/I/Iq55hUzI3VKI+nis870aw9tVQRblWJv/HL+CdPCdf0yPNjd/J4bTaRylvPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for BAP broadcast sink.
It consists in registering a sink endpoint using the Sink PAC UUID,
discovering of broadcast advertisers that announce the
Broadcast Audio Announcement service, synchronizes to the Periodic
advertisements of the source and synchronizes to the BIG advertised
in the PA train.
To retrieve the BASE info advertised in the PA train, the patch
Bluetooth: ISO: Add support for periodic adv reports processing
was used.

This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] unicast/broadcast (u/b): b
[/local/endpoint/ep0] BIG (auto/value): a
[/local/endpoint/ep0] BIS (auto/value): a

[bluetooth]# scan on

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 16_2_1 <source_address>

Claudia Draghicescu (6):
  client/player: Add broadcast sink endpoint registration and
    configuration.
  client/main: Add broadcast source discovery
  media: Add support for a broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream
  btio: Add support for getsockopt(BT_ISO_BASE)
  bap: Add gdbus interface for BAP broadcast sink, create
    synchronization with source and create BAP broadcast sink stream

 btio/btio.c                |  13 +-
 client/main.c              |  57 +++++-
 client/player.c            | 187 +++++++++++++++++++-
 client/player.h            |   3 +
 profiles/audio/bap.c       | 347 ++++++++++++++++++++++++++++++++++---
 profiles/audio/media.c     |  35 +++-
 profiles/audio/media.h     |   2 +-
 profiles/audio/transport.c | 244 +++++++++++++++++++++++++-
 src/shared/bap.c           |  50 +++++-
 src/shared/bap.h           |   4 +-
 10 files changed, 888 insertions(+), 54 deletions(-)


base-commit: 838e1578072900d1f98dfb31cc538940d2fad876
-- 
2.34.1

