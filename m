Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16023EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 14:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjF3OuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjF3OuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 10:50:03 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249FA99
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 07:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBL0OuQx7Bws7oOKNdcDMQ+dXhhvqFH3DdoV1appoPThxl54srnj9t8MloBJAnWkvyQglW8eogZRVUQSoZl3u+5tCMo6F5kRLmrafAA6itRffNP2LkjSsaKnfcSQxaWCE8SnNTeU32PB8s8tIcZRxQpATrilMI5JqNSRBQzd8KL5xXt+qRVeHGrlsRStkA1Dq5QbQVGGoi5IeUosN4i2IhwrQi96qK9cLBRHOqO8Smgyc7CMckFqDeuM19xO0CKiaXBp9N4mXN5Ty/lgYtHwmZIfL+u8ozy7V1MWUn1bSJEfubrpmsLkhuwqAyJyWAyTmG7CryK9NdQ7lCvHjH5GZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HMrXVzD48vRsCxukovjTnua0ueiaoDxM+1rjVRmztg=;
 b=bReM9vYlMfZiRp7LRkavfQ4dWF6LqEGRKzqJtZwGQMOc49sTutI3xCX0e2hNneRExbYZ1+iLI8B70zwVcvdh7OfDizkg1UdkM78QN82J3J2wigC9EUwYkGc73AMClTlAidlg8zR0LM/6RsyBujHW1Cp+uXnJclphnu/tl8OCND2MS5RyfPw1sMkvT33ZrKH0yNM111U2v2YPEU9b1d6fHJ/Znz2BMpau5PqUPxTveXtTgbEIDTt4S84CEAjpiIiCvShTaN3473e/XGFUQhzRVT2Ci2VNP75h+fFEHJZW/Hd15ALAzVqFgbPVpQgwvERUZcGF+qRO/i34IpdxbKBxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HMrXVzD48vRsCxukovjTnua0ueiaoDxM+1rjVRmztg=;
 b=dtSOZgs2aKUB54JAZdChAQagww8Z1RBjWG8MEehS5eCTTUosJGe53Zd2H3vrmdtl5AK9ToosSY6L/e0184c8dp+DQoPIB9BBIKk9YRt0TpHdFGWoKqaTEwomdHK34NsczrjIhJf6EMQw2G4fCdr4jto8NdUxdPfCENAMugWWW0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 14:49:57 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 14:49:57 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Fri, 30 Jun 2023 17:49:29 +0300
Message-Id: <20230630144930.216553-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cbae19-b001-4e9e-18b5-08db797945e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAV5oEGVeHeO8P+Z77iD8kC0Ch+oNUEX43qMsqRwmx9Hv1o5CyWXJ4QNJ+4yXdJMfrkZhbAb82KyoJLQQV84Wi0X8E62qL690ZDAbx5sxQAeQJGfOTk4ISXJv9jZdcyuoVlKtln/2G5cpSM6bCUVV/rxAcurykwGVaCFi/+Ql1mJzwWrtu7zqXV1rVyzGxQF7+HXbPBDZB9jBIhMzMj41h/OnTizwmO2EJzh1UcTKp2LYI2BDHFZcinj4CHa9pR56pxKQDRhvqpJ2FC5KByCHW2cimPlc37SSTMuTUnAxkatOM+2J78vz4u64Ti8d5WSx6QuYVzkxbsapASuKv6nze80zKr7XpnVKZ7idPDwonmZkacYun1U7yQtxYVrBw5uZeX8IPtMoGgzFsitwpeSFjEjm2e0c7KWV371A1jYRetryKBFPB22OTL4WZ3iXdicQQUgHe0q1/Kc1NhkCf3RcJ2J7y+4d2URIyh57qxi9RWg2W8mXiB8thPofykUpf0OpgN0BUnMqF8AVRx7sQqeTIEeP+cPlUGqeua2rRflhERHjzyKtR6dudCK4JHk+i9rrhVr/L1R/DQzcQWTc5g4YxEII+A2GfLf1IwD18Vv3bPMHI8Go/SVwEcRewMyg89C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(4326008)(316002)(66946007)(6666004)(478600001)(6916009)(66476007)(66556008)(86362001)(36756003)(83380400001)(186003)(26005)(2616005)(55236004)(6512007)(1076003)(2906002)(44832011)(5660300002)(41300700001)(8676002)(8936002)(6486002)(52116002)(38100700002)(38350700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koFqPAXMnVjrFfy24buSXnjvioyUxyD9HndzyY7vwUjMQFqB4Clkg8Xe/JJ0?=
 =?us-ascii?Q?8OcHtUn9aYe3jtu4rZZF5ARIuwrl9o4J2RtaY1Q7ONIO5CtVDq5PaZggkUH1?=
 =?us-ascii?Q?aSccBwU5irQrPMbESzMsmxLjxPniq97hB/ZaG2+IubeO3hz6dOGE1NJOE4mH?=
 =?us-ascii?Q?818asHfhWH9dIvNRSV2Ho76PPPB03cNcfC5FQit9bMZtMd7K5+6pSMWiNzHI?=
 =?us-ascii?Q?3ICWFgdbBrbf81bYDCdxTwCYs4SKVuaCpPUXOzOTN/5eegneyQv1qHvB3wM4?=
 =?us-ascii?Q?La5UqffvtxKm04FYG1TgUajiGxYbtUdnxcaE/mEyVbfJJeoVP8oE1TEW/z/i?=
 =?us-ascii?Q?Mkcb5BFhYeEetXOjGOKKPjHj2Jj7QPddDeJK82NxMkNCFNqPf1lAOMrvYSzb?=
 =?us-ascii?Q?LhDcYxd3VggvkxIgEA5FyIDdotZR9nqx6vE3g57FMsh0Rl4RITO6oMJxF5PE?=
 =?us-ascii?Q?zgZkUVowyUsWifPoLG39zELeFC2df4bYOIfYAqFjRsxN3LonSpuu3GXrtlEP?=
 =?us-ascii?Q?jBcbfBTtx9kvflmlS+vI2atyQhw5rtsHFOmCxhWcsdRz9GyMCtA5Yl4L9nTS?=
 =?us-ascii?Q?EiDyFZukqGBy0OTrlECG2Rzid/b7VSBixvwpJFBbPDG++pQoXE9GAbsnPqgj?=
 =?us-ascii?Q?QVnd5fTd/WY50/12XGAxLES1yf60QdEYoBGYiYYhoiUFtb8iWAhbbYY+H6/m?=
 =?us-ascii?Q?sqjwmeVudFF92v8SflBsuz02lnzI8gL9EwAf7BAYSKotJ3iJrYPROw3TdO9E?=
 =?us-ascii?Q?esVnaLpbQ1ARDD12CC+p0pQZPWyRAZHMFPHpXH2yBPmF74u8gKWR7JO9PqlC?=
 =?us-ascii?Q?cqzbAqgEmeavrPuaSLYkdeBz7BVWM/5JnyaxJmqxtfFd0QgQ/UWo52cA9zGI?=
 =?us-ascii?Q?RS6zgr3g1wMkILk6FKJXMJcVu2T/YvzEoGNaFUBahGgiI2ZO1dkiyETgzNTV?=
 =?us-ascii?Q?gqf6GbNcU1D3nHQWW8wH7Vdy0LYhXcl0BA4jAeu3hPBddyfR4TczppRDrTp7?=
 =?us-ascii?Q?w6GP1/6RHk/FSQpYSy42p+DSfGOKoW/Dry8Gcepe+Yt6PFi5SoE2y6hxj8Zt?=
 =?us-ascii?Q?ngb+SvHoR2U4+ISeLdaSIA4NKKtNOk5lrpTQl05fSHKKKY8DPr89NkwL6B6Q?=
 =?us-ascii?Q?geCNRUKUzW9d1ysMDNqLIEDXw0c7aqL5/jRi+MLjSKAYVUqMmPMAVF9WcX+h?=
 =?us-ascii?Q?845sjp9z9g5T29a1eWuomXTSHVsCYA3YnGFBVwsR+NV1K8haPmDS/54dLXqS?=
 =?us-ascii?Q?8V/iZCfAgHSVRha4TobBxJKoCdJU+zSL1KxtfBOWz/tJRkNR8sLGcQmeBbSZ?=
 =?us-ascii?Q?1tZrVf1vyoAZISm9t0fwg5MPcKn+TR2MK3FBmliqfU59rGeuzPJ/cvJax+X+?=
 =?us-ascii?Q?jjD1Ig0AWBEICc+p6zXinRbntr0fzCiIo34F0bRgPc4iLoc0+qu0zvGyKtrj?=
 =?us-ascii?Q?+bn5LO0RjN7RQ0oOWs+nfM+QAb37OUCxOL9uMEkb7EOgc1vYPp0Vlt5kloap?=
 =?us-ascii?Q?jjNY1rqGdANKCbor0OG0UU8z7kjEzE96pWs8do/0n0ImXG56j8JcvT5tEFiw?=
 =?us-ascii?Q?xnKZR9ljdq2bar++jWGl1VPU3WzW4o1iBychDT1FdJvcwTnndet0X/D0M0KC?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cbae19-b001-4e9e-18b5-08db797945e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:49:57.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUCDSGAm6S91kerrTLo0Tp7FyAnAhs20vFmtycZVJ/OSksXK+JrC7jBFxWJpqPAj6U1HT6yFggMEZBQvjIrZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch makes it possible for the user to be informed if BIG sync
has failed.

There are situations when certain procedures must be started in this
case, like it is, for example, when a BASS Server fails to synchronize
to a Broadcast source, as a result of a BASS Client writing the
Add Source opcode to the control point characteristic. The BASS server
should be able to detect if the sync was unsuccessful and it should
send an appropriate GATT notification to the BASS client.

Currently, only successful bis connections are notified to the user,
using the listen and accept socket procedures. This patch proposes
an implementation so that unsuccessful bis connections are also added
in the accept list of a listening socket. The connection error is
marked by setting the sk_err field and generating POLLERR on the child
socket. This way, the user can detect if an incoming connection is
successful or not.

From the previous patch version, hci_abort_conn_sync has been
updated to also handle the failed bis case, and other review
findings have been fixed.

Iulia Tanasescu (1):
  Bluetooth: ISO: Notify user space about failed bis connections

 include/net/bluetooth/hci_core.h | 25 +++++++++++++++++++++
 net/bluetooth/hci_conn.c         | 37 ++++++++++++--------------------
 net/bluetooth/hci_event.c        | 21 ++++++++++++++----
 net/bluetooth/hci_sync.c         |  8 +++++++
 net/bluetooth/iso.c              | 35 ++++++++++++++++++++----------
 5 files changed, 88 insertions(+), 38 deletions(-)


base-commit: fd859b4a38153b4d9e1942ade471f4fdcd8d224b
-- 
2.34.1

