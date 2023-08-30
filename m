Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F020BC83F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbjH3SyC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbjH3NCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 09:02:35 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1066132
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 06:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkjxdcNK2JfC5+q8F29NLIHmaKyyewsouQ+G8zgPMbw2dii9pZnlws85TEy7F1eKW8P8tBmRleqlNCWsbq91Y5Y0/YQhf6A5yMOXbe95iaGs61DCPUYIsAk1c93CFUCw50PxD17f7APHEtZJwbSOyJ/845wfSSbqdpPdRYzG8FHbikCpoiLuDcWDb9v9Jz5wydirnNA4ovxJ0U/mky2PeRKrdUTcmCzJxZy5M0RxI5nPvza2M5zyO4/Rl3+4RrBBTPlU+Pam2yxEuiTYAsr6SkDTZhxjTUGEQFHAHTDru8ItYKC3Y5U2pVJzad6OhH6egH34xV6GkT8cs6eC+cs5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAvRVu50ui9wvSGICbgYS+zI/2EAM13IYuBhtJwbECg=;
 b=hbyGlTzlW2oiikUfXy7/nCKhmJ/VPTXnFoIxySWpKA6k/ZoP0sgCkhkovZCwvxV6IOGHhJ7cZT0TM71ggnXcvmmfgBb+WB6bFWPV6Vrnzj27zGj6aNI4zmyj9n1dhdXV+Km44hplk7gUL8/2kAQddnswZWyy7Z9X7lwbDHsEzc2zsUnZnsE4gwWrODbK+sL0qTESF1DeKvxjuATSaYKKetoyWuatiTUAmN+IyOu/fTHVsbOLpfbU3ajHJIHlFckO3/NtYeDCFkemvV11BrrVKQ+FFulYe+jqtmlnx4XqPvJcya3vdr74f1NLLP8/DuUOqP76hkz5iHU2Cud4EekRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAvRVu50ui9wvSGICbgYS+zI/2EAM13IYuBhtJwbECg=;
 b=FNPytTfvHSNfZhsvvERk7ET1HUvxAfDEfJsPmxOOlVuStxyp09yU834N9ZKjv1LXfyVPv/DR+IZ8FtqhqXNsKpwOQt+oy9WLp1B1zJYvAHyBS4WJ4pFNWUHvjJQ+cQR+OacQb7xjnAEBMm71oDh6EFDanBE9NWAywaHViMLp60M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 13:02:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 13:02:28 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Pass BIG encryption info through QoS
Date:   Wed, 30 Aug 2023 16:01:46 +0300
Message-Id: <20230830130147.359016-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cf3cc6-c31a-4ae3-01bc-08dba9595d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ILCa5bQPVagXz8c3XCSYc6pqgmv14FRIRQ3F6oHCe3R647Z9gJBSkiaQH8xINUwnMp47dhmJDykxL9QsDqP1OvLfTVj2YIVoH4IBhGgJzCTYPwScxM3n5vDKRHYP+PsD4AeVJ6GI3cy39AnCxxeU1ZCZomerQT1N19Y72catSKYOMqYUNiZdTYEK25+yd4z0+ZzGYoE0JdlBBKRQWlcAVZ0iVTJoAfEmMkSW/tXwGhjxaqLTDTFna5FA/HWEH0VYI2jiJd6PP7Za3CpmVQtfAMMsJJb+6UAkWEz+XqnRs64ghiZJfZNmjmHcsuylYKIz94nD5VPhxi6CcU+GeE82NfzSJEtMony3nrjsKc1235jMe38RBfhpSRx6DW7PNpeu/jTLzUj6hl1sza9ZEx8w4wbodzs7YupJOtT1Sdpw2bf7Lii8IdeLhT6CMak6d5L7mt4Y2iVkajvOpjp4fkOGsQIr1pgAQogNkIZ9gCaR2aB938KgzKiJq9Hf4NoHDzznsLUrDSD/uOMeECKHimB30nyVNV9XtWLV7BClA4ZXp82ODVNmjo0ZdNvAh6c2E4Pbx90sgZmwOamukVk6PeaB3wyPdCX3atiHCG69q8yOn0fvdEZiEPpfQpcYCb21RAb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(2906002)(66556008)(66476007)(66946007)(316002)(6916009)(36756003)(41300700001)(4326008)(8676002)(8936002)(5660300002)(44832011)(6666004)(6506007)(38350700002)(6486002)(52116002)(2616005)(6512007)(38100700002)(86362001)(1076003)(26005)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L02AZ+5GnyEWSNC0J0L1EAsHNcYrAVrm8p73F5lR/BwhtGSq/Fd7xkdQTX1r?=
 =?us-ascii?Q?8oz8cFlDMkWKcngeg1uEL/YAo2/BV23qMxNHAtjDODApCfpsc+vJmy8cOhZm?=
 =?us-ascii?Q?SpB1b+QizzuVFQ8fjrMC9H1DugYaNMTYHIpy+eFoc+hWAOOX1Us4A/9zdAZn?=
 =?us-ascii?Q?XMw2PyXMKA9w8hqKMsqL7VEQ80bbdn57rgh5lxfIeFKeRIBvvhrRAn2KzC61?=
 =?us-ascii?Q?/0MU2QfI7B7GskMRNlOfKns0+ltPHBxnLPJrvU+Unf2qNQchKqmXh9AQ/0sN?=
 =?us-ascii?Q?t7PGg4gYKyUbkKfbEcE3okno6A16qX61jJy/rLtjiqgk8CxOu7ur1YAMQzB0?=
 =?us-ascii?Q?6nngQZg7ULSHHQkcv5llOQkBlqrKMJRJMLkGR+4B/zF0hq5Bcx6vKEskIirg?=
 =?us-ascii?Q?RaDP/QMXhruTNu2joyF7LBAtbARvFqucgfvbFZNHqsXW07WD3nx1o3FHQooz?=
 =?us-ascii?Q?DgSBbS6S9ZQt5zMFGmeXSs5OBjA0k8YXP6KY9gKnMo55rReK+Zf0khUCBW0f?=
 =?us-ascii?Q?I3Eccx0NS9gTio13JJMls/N7MqBuCBtKGRW09HRHKmJlly4q2U8R5vuY2OLp?=
 =?us-ascii?Q?jx+iAaFgDaMyCJ6qmzjIvy+htwYte6hvX7ouYb9XCAxBXmUp5Hob1bx2KiU6?=
 =?us-ascii?Q?5osFpvUASMNbw8/3eIiuufZbm5sBz80xQ7FSfNfi0SRscerCMhz78/hgmt46?=
 =?us-ascii?Q?Xx1DwmvGPh/YQC/Z9PyK1dVoQ0Ag0xq+ggaDUh0i1BQoy2BMIFHunJJmCr4z?=
 =?us-ascii?Q?FO/KTnahiRDOxru/3MBinm5GUgwgzgy81BECAI/prPCW2IRDxAEgTUfgsj8R?=
 =?us-ascii?Q?3ytfJE2mRBzL/5OfzFtyuvJegOeomR5tfxglHcODj2iuI3V90zGdqCgLCivR?=
 =?us-ascii?Q?pMZH3VzZB1UhzH5ulhGT6SHYTAlpxrXrn+pHc993v+mgklBl1CqefzxDhEow?=
 =?us-ascii?Q?FqhXGOovPtc259Z8Xt1bl5EPUuvcijNsPVNthvXR0679GbSmFDUYD+yfZR+Y?=
 =?us-ascii?Q?+H25kV/nXUw0dFTl5QpY1uDG4O222j7YeD7qmFh9VjC7oX4nWIYDQjoDwau9?=
 =?us-ascii?Q?xlHO7JdMQozLwjU1vikX4S0tj1RkMvEAHkWCqsCAeP5UDty6di63VFU8WPKa?=
 =?us-ascii?Q?n+WgoXXbcK342btPkbIvMR2YrwD9jgK2nYPD4jJFz4QCAduy9kqTzpzvnIln?=
 =?us-ascii?Q?tZX+GFMZW2/TdmZpzhWm9H9cWIoaOyGKjS9aS6P5otsMfkSSwOZtwmsA3wdV?=
 =?us-ascii?Q?vFAQ0rXlptjV/xGZZVsf19CcPxcAg7lk+g8G3iho8npKSMRb+Cvbecs+76k1?=
 =?us-ascii?Q?NvBQu1K1KVl9uUdGdkEc/Ns9A31x3t5MTjfwqbMmR/88bD0A2n0S6tAPhMOk?=
 =?us-ascii?Q?hv7u0q8mPsfma3UK4Yye4fNPwN4hRUENkCR+nt/eSdVQfYGxXQYYCW9otijU?=
 =?us-ascii?Q?vko4RHSD8wKYEuKh+Qqmb4qyORg7oL4DWyW6D4I8tLFXNY6fkESR9b5q2MqD?=
 =?us-ascii?Q?V+yZ6zEZkbzkha2wJUxJeF9XE7Dn39DezGO/rClEDGfkxiwNeP+xdJQZ4FGe?=
 =?us-ascii?Q?kmVZaGAEHew8Ey/ARy8ULxDsbItTj2M2MIMaFT3jIBtrWgPSL+3AvNSAxZ5L?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf3cc6-c31a-4ae3-01bc-08dba9595d52
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:02:28.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzputod10REkoCLzNFMtITMPUEWRGzuQLADv7tapId67eTmkrzMHKWH2LGxoah7KoxnN6VG0X2MxauHV7WsaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables the ISO layer to set the encryption field of
the broadcast QoS struct, according to a BIGInfo advertising report
received after PA sync establishment.

This is useful for the broadcast sink scenario: the userspace
opens a socket and starts listening for a PA sync connection.
If the PA is associated with an encrypted BIG, the userspace
needs to be informed.

After PA sync has been successfully established and the first
BIGInfo advertising report is received, a new hcon is added and
notified to the ISO layer. The ISO layer sets the encryption
field of the socket and hcon QoS according to the encryption
parameter of the BIGInfo advertising report event.

After that, the userspace is woken up, and the QoS of the new
PA sync socket can be read, to inspect the encryption field
and follow up accordingly.

Iulia Tanasescu (1):
  Bluetooth: ISO: Pass BIG encryption info through QoS

 include/net/bluetooth/hci.h      |  3 ++
 include/net/bluetooth/hci_core.h | 25 ++++++++++++++-
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_event.c        | 54 +++++++++++++++++++++++---------
 net/bluetooth/iso.c              | 19 ++++++++---
 5 files changed, 82 insertions(+), 20 deletions(-)


base-commit: 75d095daab9fa1d299fa79ebc7ab5dfbead877ca
-- 
2.34.1

