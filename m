Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA574C761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 15:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjCaPi1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaPiZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 11:38:25 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A94C35
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 08:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8sk3n3/psxje7Z6TXzuDrq8mILBWlxWcq36hMez6hISv3DPQqRX0VxnHXAzztNM+De5rClGB05lwWUIdSgS/CHRRFR5swkLvHahBYIFcY34lTSvXrpSzSSV+MpCnp4NFdk/SXdHO9IA7rnxwKrUOZQPcgqZbn8gn+0kzfv2AAs4hC5TRwdRlMt1YmcolHT5T/1a0xJcbp4XVWEvIOgIuTClq6ltgj+h+hsy6R0SM2YSAs9u8f8kWvzv2dAFMkZzh2VfoI79OUieGGRUSisgryJ8GOF5AVsdZLZ/pGkfaTfOhwfV+le76syiajkJ7n2FGm7Zk69e81GVs+QhrWgWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXxhKBaTc6AkWEaXh881q2SWUj92XAgMWq7zGSGBOJY=;
 b=FdhpPRih2eVUkVJJS0YWQ4D1qVu3jZW+e2Lpai400je/jlseS/d0JVXZrZCsonizsDEESoXdOct+0yvjPWza2eMJPRpqR2+zGwAH1b5lq2KmYToE7T7x/+k6KqN/kwvn6zXzyfBSfCPr8kH0Rgq4Q05kdCjeqMgJsf/w2ga9O9G49mjlUX0tCH7YQM8ymBGPHVbesQs2obThEafDFWV59UYBO+UVCy5HZA6DalU4ND7PbrZiY+QWrCoxo9iDXzOJRUMEMLhozE4ktOTsskDmHLwDqwTQX8UQdYx1vpoO/BLyv6Lkz69976XfK+v54sNLSgfGtx7V96Y4J+uQbk4nTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXxhKBaTc6AkWEaXh881q2SWUj92XAgMWq7zGSGBOJY=;
 b=chqaBlhTONWoXts7CT/58ljB0cMwfNINqq+9Vg5E1/qWl1BRWnoNdoIeceSs4D5XP51FHOQ2qCl4Tjue1nekjHb2kl9r0f9ghdz0JCaRW+SJxvPc+vSdIO7rJv6QarmAw1EMRLFG6cqaKpfNvYWX3mWMzbFX+19hd0Qzh3NSalY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 15:38:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 15:38:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Fri, 31 Mar 2023 18:38:00 +0300
Message-Id: <20230331153801.35290-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f671716-518a-427a-596a-08db31fdf2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOvADgSn7zTcQ4xbY51sO6s6064Cz4JcOETeWXwSvClgcxtsYa7rLEcKIU1TQD0WjdeWARdxegOYZVIwZE4yArXYXG4QFAvAgW3nU8lJAj8egLGVkN/6MqstkOJ2qJOFC6TW6GDLQMrF0CvtIcfnzxivcqQYXOWek0uuBisaDjvigYXl7aM1FCLzM7rMjpjtDDd4yT+n6VIpYQGR5pUAMW005QMCywY42DLn0ByQ21ePFGKXPR44NREGd3OtpZ0gOGdXGyXmISC2I6cOzy3QoG5d0kYZvODQEmgfTOquFHA4yLa8dwAgMXbV0/ut2jldgWwk4/5NBBR0JqgXsNdO7cLsX5rrpL8oF2v7wCu7UQrEy9/iEP0KuI3M7dT+E2afbrveD7OPyicqFuhEjVQqGpUB//VL34aKqJBnHp1hiXgVgZGUayo/E9nRNQ1Pvs92313VqAg603MQ+cX44tmQOAIw3nFltiR4y0oBMJUMkusb28ICILif/y00tqh+872xl4G90dL/2Ch1OYwTiCjN2tAFHpQfMaVSmSD+ByYF5LcMfofkh9ivsiVWs9ixR47otF1PvSY4fddWuH/kzmq+RAmeBk+edN/C4FclqxwaRmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(2616005)(52116002)(6486002)(6512007)(26005)(36756003)(478600001)(6506007)(1076003)(55236004)(186003)(6666004)(41300700001)(6916009)(66476007)(66556008)(4744005)(4326008)(8676002)(44832011)(5660300002)(38100700002)(8936002)(316002)(83380400001)(86362001)(66946007)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2M610+F//m0T/0TI98GbdyGs5hC/tKY3ufPSAOos9zIkl8XZpGMDdMN1PRz?=
 =?us-ascii?Q?affZGEWMsmIMZ8v0UyDQMuq/ekpeus5OTgyCgKD+mussbs25kswKyYN4oVll?=
 =?us-ascii?Q?LY3B8K0udUxkuahDZF0KKfuRB6PkGEYUGIGiS4c4KUSMouaGfZsYi9UuGrr/?=
 =?us-ascii?Q?4jXv3WBGOwkgjBZe08GTi9Xril3ONB2Nj8F8AHr2fXwBU1YJ7JyK4Jkw5/mi?=
 =?us-ascii?Q?iBThqxvTQfj76IZfSLsEyHTHplKc5PIwxQ8t0YI8IKPWxGegrl3UaT3GRLYO?=
 =?us-ascii?Q?lgCqawRktmO71i0Win+LAirpgsCq2lmCifFjrPglLVhTZAAMvR1Bd5pRLJDy?=
 =?us-ascii?Q?aNNYRb2KHokgoKbhlh5TQsd/C8ejmjm5ZjLU0BffyvN9ed0Vkln6UIAwfGy/?=
 =?us-ascii?Q?wdeZVwVYmsR3gVl6XKEw9jUwZBp0f68Bz0Uwum1bQOtz8JWZaFcHBc3Z7zZ3?=
 =?us-ascii?Q?5IMEj5uUZZoS6sJ3hnYFyCyOBnWdMeY1iRRp8l5tKsZz3IWuc031K/VgughI?=
 =?us-ascii?Q?jb0bzNaSAzyW5nW9Fn+cQsOFec5uNHY5pseyZ2jXRlY0ufcmgyu/KlT0NgTT?=
 =?us-ascii?Q?vJ+GxR1ZAp2shZxbFvEAdLF4OiTD7bvn+Ee4OHBdS8JiysD82O1m0Gn33gj/?=
 =?us-ascii?Q?kNL5/xAGVXnI4nxUGXs6WYXCk2+cgCLubQ56+/L8fw/GiZW2raiBdx4u9fM4?=
 =?us-ascii?Q?ffVQ0faL5CfM60cR3t9mPHRAqBzDne9vMzcVWX6ug9cu0/5nf+eHKkhpH8mA?=
 =?us-ascii?Q?XzSlNyP2+J1vQaN8R63bBtYxJ1itUKPh+KcN4Lk4t5RXNd4S/nCO7JfDe74k?=
 =?us-ascii?Q?1/9bXGRTt/pUByRJ6ZpJwBZIteY73WVTc6ZJc6deQBl5TWDmgYZwKrqHV8jx?=
 =?us-ascii?Q?F6OZEKrlrHfDcQTXo60XJm6qu8/UgocJ0ZTUWuBv3Vsym6Yyzy1hYH3qA5dL?=
 =?us-ascii?Q?sX3xcJ5X5F18xZ0UP9N0HL5F8DHkyVNiyRs7ewYyzKp4y7UQnsWeu+2HFpPw?=
 =?us-ascii?Q?vZjZV2MWbwJMiWKlP9nawfW35AGIyE1Vhfi3KvCTHY5vyZDED6XATznLt2+B?=
 =?us-ascii?Q?5vsi8YAvu8qcxwI8d/b2wvLqq0TZwBNKtv7I9pxhOt93ObJJ8mAz6W/05W/V?=
 =?us-ascii?Q?2JyoLbt4+WbLIvyFDT+iKZLBXDKegGHsSHzQPX0PViaaVb4mIap8fWeQbKYy?=
 =?us-ascii?Q?cTSp64XIGMv/V7lKt7Vh4Ur2DWSHIKWpEaI1LzQzeiF/ZUJCnvDC07165jH6?=
 =?us-ascii?Q?zSSc+kTCK8/DAh4rbQ20EdkQxfrMqDQvMqYu3WkzjW5W/ufPISoTCXbTpVOz?=
 =?us-ascii?Q?6gG4cb9Cs9ZaTfiJMmn7H9gKX8arhc2taNk+sLekizDIN3/N6ur8U5t08Fhj?=
 =?us-ascii?Q?xfedOqZtdiq1R6mzYVTAKbMw5JQsNd4kfJxKDdUF+nypQ79Fbj/AJEfZdbJ/?=
 =?us-ascii?Q?o3RU6/SF30w0gwpztbsJsp4gLcHp+h4yTdUieU0V+zaymdZvAyasA6VDitIr?=
 =?us-ascii?Q?NrqN4/6git907zova8pzzEPbUdvIVKG+67//7khFvUPtTxxqqjcbD/X1UfVY?=
 =?us-ascii?Q?67jgCxtmMzJMaF/emVzsrRnfWizCk25sCdk32ptAX31/HHpRDJ8gO+SvPkaV?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f671716-518a-427a-596a-08db31fdf2c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:38:17.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OYZ+hCKKRMwxApP4jjgnCKLkL0lqHbK/CAVr1LuhlBht9045QzhWm8etcCVOX2b/Py0o1YvrzOnbQNXiLYDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for additional ISO broadcast QoS parameters,
that the user can set before performing broadcast procedures
using an ISO socket.

This patch splits the "bt_iso_qos" structure into dedicated
unicast and broadcast structures, so that ISO sockets
can be configured with dedicated QoS options depending
on the type of ISO procedures to run.

This patch depends on the BlueZ patch
[BlueZ,v2,1/1] Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Bluetooth: Split bt_iso_qos into dedicated structures

 include/net/bluetooth/bluetooth.h |  43 +++++---
 include/net/bluetooth/hci_core.h  |   9 +-
 net/bluetooth/hci_conn.c          | 162 ++++++++++++++++--------------
 net/bluetooth/hci_event.c         |  33 +++---
 net/bluetooth/iso.c               | 125 ++++++++++++++++++-----
 5 files changed, 237 insertions(+), 135 deletions(-)


base-commit: 5b23f8375a3685b93022feb625a2c4b43e5c0ad3
-- 
2.34.1

