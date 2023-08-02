Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EA5C04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjHBImC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjHBImB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7F2194
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLn7jOnOsRJNgpMAq8cFfCZamas9eErglWOkx8+3H81Y84paVfVpSdb1bT4vGW4MoepLwQP6xu9lWT6WnA0vZk6OscXOn4Hw96lKOc18f3OfQfN8qmeY3s1c5g0Q5opePfjAAU+nmf7dSoqFU0MeEV1mYeI80Je7ccSjKB8E6QUkFxNiRT39Ur3eKl9MAuuH9OO3qARy6q0qp/YuePrsVM66y3WTDvMMzY/aU48hsYJ9SKM0tcCVRZWYBSFrPBNOT1n1JCHR9i38CR3AJGFicCXIHosKyXs/L7EJEHB+VvXVr36shC5HRpr2gQ01CqPyDZeMs88f79LQLnU6AbG9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=077nyy8HwOK16SykFeIfK5xwm32ul98BIRWFanxx7rU=;
 b=BVFOR9adj18YnLOJsdToLYXiDfJjB1sVfmx+ItYKl3ceakk34yIX/FG0MrDnhimdKgx53QbsamGU6ayRfi2GQGcy8LvjYZgYVJu/bT30CJsUYwdUrMw6nZljhUlbSKIG3yNzkGOZ2feltraPUpXZ0asENQblA5WUvWG8cQ2TserpS79BYaTXT2Cv+MmJ+oSc5zPqMRbopIxXPtKaBbvcLuKdSfsel4aLcAQ5yhy2tvgED1Jj14gJ4VVU6LZIlTXGkinbhBCPzDSxPc3kk4p0pJ0/Rxk8NjrgS0LMzCjAdqexCqOQAagfmBbUEyiHPELLn4pXpo3F4cgA1hvNQA5ixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=077nyy8HwOK16SykFeIfK5xwm32ul98BIRWFanxx7rU=;
 b=V5y796q/2PBx3kfCk9lEfwh+O7qNoH/GzoahrC15BXwUid3N9iE3H+DupOHRUpspNYdk3CrSV7eYCMogBZDbMRDBjhccYu8QQQe6MbaAE/JPiGyf6WczC21BKjM7xxtcLaCtRWwJhHrkXkOzA/aTrAtRye2zAJxg9gwCR+bU9j8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:41:56 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:41:56 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 0/6] Add support for BAP broadcast sink
Date:   Wed,  2 Aug 2023 11:41:34 +0300
Message-Id: <20230802084140.51105-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfc0386-66e9-4fad-727b-08db93345400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ofkf+F/IfRYD+snpZnuo1tD7G9sZagyUku5aPIAvkwlrA2wlRdT2RtVzZC1mshXl5aRPe04a73t7/LRTeqkOpFR6IziwVwL//D8ntl2r9u8TU0KGBWUKeCGnYGYderS8gv1KB5MI3jyLxC56O45FZso85VDMHa7lZOM6CKUs8JaZNJ+cxStK4jFg9i0ywSl7869qTzM5hVfWhreJSSQK6/QobrlTJ9u/taHcohaFERTHwTM/K8WcsCYQ2nyCMvUEYbqgYs0w0CAdTqAVFS9TW+lw8/dX/NVm1a1T6MyK5iN2MoRoMS1MfDISdQ9NtLwqy2MuEspcLuERZZNTn5iCiSDBkpi9DEt2kOHKoYV5iKnQiN24AKQXOR7rCNLXJ3IlK80m95tgqcPPHcV50Ij+Y/OyZuoirXgZ92OGsuFzQP99GTJC5l6APqVf3T2eHQwNguLxZrpgYmv95vTnUAN5JRkZO5yq5z+SMoKmj0A5c5anfUpHqhDu5o3/5QXn+Gy9/wV5dyuJVYQFxaxDIo+elXKqU7vKUdR03h2SyN0ZIOEDp4wU6zE3bzhfn83dooMdMwtfE190xoOSdKjAhkBsEXiIyqINvv10IRWoSAxYhScJ0eUMvEYZfxiiDWgyN7vL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(66476007)(66946007)(4326008)(6916009)(66556008)(316002)(6512007)(83380400001)(2906002)(86362001)(186003)(26005)(1076003)(5660300002)(6506007)(36756003)(2616005)(38100700002)(38350700002)(41300700001)(8936002)(8676002)(6486002)(52116002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3c/ohG9bJWC3Qkhe/VUU+PvoOcRg1I9JDNTdB0ViQBwM5tJyQvwmGmxiW6b?=
 =?us-ascii?Q?iiIKTbKINhO9tpiHix4CO0p309zxpQkaYmg8zJOiRJSpuv4MwQiAioRvsflm?=
 =?us-ascii?Q?lJiBQiBA2KsKMMFWb2W8QqrfZ4dgEusQI/2FcxRvJjaHU71QIyMWNOu7SNQC?=
 =?us-ascii?Q?oS1Gkkz9gLJ0nbwrmSFF8FuzzqFHSyOvbLLqtZRfmBRGbe0bEamxrs9wO0cO?=
 =?us-ascii?Q?Ip6Tfl7lB4mtgwI1miEjmb2ZRnVqMc+GicRbvlflOBSBKOQTm9wlSoxdkAsV?=
 =?us-ascii?Q?7IAyOXRPbJIZD7mYlE432kPBIa8tTleshK42tVGlwHyTwlLOiu/Q+nbgJXGN?=
 =?us-ascii?Q?GOJBGcHgTFBCQY58k77wCb12/8zh0PObmlMUHmQiusVpLVPIDCmSRKXFiNTh?=
 =?us-ascii?Q?QB4dt8yapvc42AO1ykcRFchNkarUZ2MCfrGNEhW8nWOfIsKMiyeBkS+i9KNK?=
 =?us-ascii?Q?REoN/6AzJjdUDhuOWcclf1yZIejPT6E15OaQZdPLuSLZSbyZNqT4eKtvG6Ir?=
 =?us-ascii?Q?pLjwoEvMb8efr2O1i7BOXLpv7NFUmQkpp/1V4JvzG3vwSN9/bXz88ceIS9A4?=
 =?us-ascii?Q?aAKxrFERMKYgijIQjNEeSFdUwGO2ZQxtJudKoEPZZmeMcfymRtyODuA45Oqi?=
 =?us-ascii?Q?bF/1qhsYJ3P/34MCBdUUZBqfChLZpyAQtoBGzw0Uaz4u67GAFzdDRCom6Yxx?=
 =?us-ascii?Q?47tCNIcMLEPz0OJ6YRbmvrnsGmjRKC6WgnmMzo3JnwjlfzRySasmws20+Igv?=
 =?us-ascii?Q?/OWmkWwEI8pnMUd5/iwcfwBR9bl/74IKQsloPSOiKzv+GYFnd9l+Ex0GAJQz?=
 =?us-ascii?Q?FL+25bLylCR/mD9QW2jUGnhjYExvT+txMfCrvrinEOuwxvxKUbdbDHEYm7K+?=
 =?us-ascii?Q?cBW1aMX3mhhacDj2ZHnCiI+cjUMaGLQrzO6THlaFb6jekcDM/O4Fd9RJYBKa?=
 =?us-ascii?Q?wK5Kan7ZWpApu+4YEYs9rviLJZWLdx/Cwn/kzb9aQw+dbav1UVcC9PhbC8wu?=
 =?us-ascii?Q?Doolc9ku9b0b9/guecQoQWjU7Uv0itNMITleSZj8IaZoVcwRg83sOVwpjZCw?=
 =?us-ascii?Q?3LdDyNWvAN8Z3SghLgaBa11i36RnxS7vwI0WY0GdlltIyBF1QKA9TLJpV61Y?=
 =?us-ascii?Q?IuaQsAKsEEKHo9Gb1DA21C2t7hFui32FcKYE/R3qabPOvCjis9A7xgPCFMXa?=
 =?us-ascii?Q?hNPyAT2twP3HqGLAwXzqKtTeqmmDbE1zxXBHxwgB1ofB1Xn4DH/+GUUyck1b?=
 =?us-ascii?Q?uP65HtU6kkmuDKLdEpe/NQUB1gxHC70u6bsH91pQAPer9h/9+UG13zlCr677?=
 =?us-ascii?Q?2kB2EXPBtfVbM7+dkeS4Um6JX86vj08QrtylN/L4aMP9kYFa7qR/5blyxFFp?=
 =?us-ascii?Q?SQAFaXIL+w7Kc4FElH8mpUWhBLUIEZQ1tpRew+OOFLA7VHu9CILW5e2igKwx?=
 =?us-ascii?Q?IwV2EYcNKmUeOvB1RaC2TYn2Kl8N6h3XS9DAZBd+C4n9EJRmLY5IPM8tGSBH?=
 =?us-ascii?Q?4+Apfe4m34JXKzYmDKrx0uzfkjGVEH2uMQyVTrWDZ9TXV0LKrLdCiYIIo36O?=
 =?us-ascii?Q?4FJgmz0OgjktZ0as8N+1npelJR5V6+OhxZ4AS69u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfc0386-66e9-4fad-727b-08db93345400
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:41:56.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrhHcpynYyrT8MrTSkcg7ZWMfeO0KMA9kS2286Zpv83cR4JDOu0D5GioKVkRZDfCJIscl+uqqlQ8b4tjZn+PEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
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
  client/player: Add broadcast sink endpoint registration
  media: Add support for a broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream
  btio: Add support for getsockopt(BT_ISO_BASE)
  bap: Create synchronization with source and create BAP broadcast sink
    stream
  adapter: Trigger adapter driver when a broadcast source is discovered

 btio/btio.c                |  13 +-
 client/player.c            |  61 +++++++-
 profiles/audio/bap.c       | 300 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     |  81 ++++++++--
 profiles/audio/media.h     |   3 +-
 profiles/audio/transport.c | 245 +++++++++++++++++++++++++++++-
 src/adapter.c              |  48 ++++++
 src/adapter.h              |   2 +
 src/shared/bap.c           | 153 ++++++++++++++++---
 src/shared/bap.h           |  11 +-
 10 files changed, 835 insertions(+), 82 deletions(-)


base-commit: 8eb1dee87e019f29b6c8233dfe0f9aef8ee44461
-- 
2.34.1

