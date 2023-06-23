Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F0DEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjFWHjU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFWHjQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:39:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15691BC1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3SSN5jyxngraXWeT5Sf5BIin8oMCQ/gwbc7HQ1XEKo2/ZnLrx5bphacLtynV0T/RUJ0ZDZJECcVS0PxjaSQvFAvupuZgmkKVtD7ZCA+vjLc2QvqLgmo99gTeVhCQFAINuwMcHnHmrKx+KuFmRZBZP0ghPqtG8u4lKq0LYqqToBj1jk3oYYnr5zS3j4HijtMEhmfw/CsjcuMXyT96vQ4+cr0KzkuXCkwA2mL3u/IkU77Vct+a1ILI3K/UcKWlO/rMusfEEchhmTS3DN7BLjtWkbRN02EtubiM9GT9SU9rOTZVy3m2zeTWwb5064TbQtjdORbtSN8vCr5BjYs+zlmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT0AdoYfj+zZBjPGeatU7V8QQyMkg2jiKoqUNadsfPI=;
 b=OcLviZ7Dpf5BhC/cT7Qx1boxRdWkHq3E5G7Pyr5kA/tU7UsnD2wF5oFd2wTruJHudSBTmoMcY+qIQSaxlKGUo9nG64CEtJs/2FyXTAXRoYseM6eT2CbBtekUGE06mil++OXSyvyQP1PkRDNCbGqEnnH9R0ciGCyQtblWX1Hs73NoFVYdScsydFOvzRXY6Nc4/o8i2ifae3+YfJyggw1U1Le7RVueRYbeg66SKlbnvsTQQTggEz+GWfk66xvpaHWaIHnHWkx2IeTGp0+Abk10kxmpfepiNFTtwXLcYQIKb+dzApXh+7Pv7ikqbRiMY5C9eYiYOznD37yLO84BUIV2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT0AdoYfj+zZBjPGeatU7V8QQyMkg2jiKoqUNadsfPI=;
 b=bCmzduizHD6pC7oOO8SjNxZogny3/97HqJj5zWYtW3Oh4ZYCBDovhYCJTGL1gMQ7DshMbEZ2XwRMWsSjH1JV7u2Mr+nDM1s8Hn0rw+DZn91pqnYrV8gsM9TrmiB7jyHyNvhmTYs/Vbesu0YmlUOEa0yPyZqIuCrBK5hxPf1XlwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAWPR04MB9816.eurprd04.prod.outlook.com (2603:10a6:102:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 07:39:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:39:10 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Fri, 23 Jun 2023 10:38:41 +0300
Message-Id: <20230623073842.16466-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0193.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAWPR04MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cad78f-02b3-4a82-a78f-08db73bcef26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHqajF27QDXbil9gP5bI66QuzxRh6Gi7s0Ywop/Q0V1GjJLdyk7ruMT2MOMzsI1jHNItTpcrekEzxCbFM3TQOH+ubkq6bd06UHFsHMxF9yZhuPvlLIRF4oEnMh/xjFu+L5iM962chGhmMUkiFA+G61uweqNfIxPzayy40QbNhgjrtSJEbOjHWnfGpmyQSUA8gmTC7XgrOkQuLTAYwHxWL0903q1jMRuLiibiEvunD34+8lXogQBcbcfi2aiWl+koCBUk4IpTNAFM4mIBUNVw9F7IdbZ1Y6um5PFOyEVLyibYbDnqDvTi9BDYN2pNz/AAT6dv7ozvEKNUPXsxh8ThR/tDMqxPkRHiZZrKqK4po9RvUbSvu/Casfz7RbvytTqYclHaDBYEmA2h3BchIFnPCxNRrebH9r5wREW3ownSvn7gBRAKRgXUXFgjmjReOdXfpled9gBWY7OqXwxpcdqQq2TzCIWHJNGfjzNxy0YQ/noce1oWuQpV+GG+tRHDPEb3Nlhi68RFcn/ag/Z8MovGG80eZO4dMdxzylpDlpsdskIOGXvwszbhvJ5e0GoK50/ZjONYQAY6jH34G4b1KW9HEj2mVLs3nC0LPyuuOm+z61H8RrIeiU+3sjX4Og7ErpGw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(66946007)(66556008)(316002)(66476007)(4326008)(6916009)(6512007)(8676002)(8936002)(26005)(186003)(6506007)(2616005)(1076003)(41300700001)(6486002)(6666004)(52116002)(2906002)(478600001)(5660300002)(44832011)(38350700002)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8kBfyM5ft1Tx0sLvx0Ydsr06ZqukWTJuyzWnV8Vh1QAqWQBZhWMYvTI0XXx8?=
 =?us-ascii?Q?VB3c+C5WdVQCeqImVcqwYMNfVr7H7BHW5Uk6hgyyUqXf984OzxIgQra4hrGd?=
 =?us-ascii?Q?r772iK1g+NUo0MjdeBgJq/JanGdu0vKbpLWLoCLN/jXPOF7jkoGeIf073TAU?=
 =?us-ascii?Q?mX3oE1E6b9LDtTC/HSR+laLXA4Cf81f8uKS8+rWUEIGcCGnH2IsEjRn0hmKp?=
 =?us-ascii?Q?b7XG3nJdvU2zGj+o+yioXqES+kGlxLGcy4ke7K/+Pd4TSy+FDbHYuM5ta+d0?=
 =?us-ascii?Q?hdtZ/F7uCRKqwTOo3T/NzhAB0XaCZRVTenWvpsN6jql6fVQwlexqA5fsBqKe?=
 =?us-ascii?Q?RG78jR089D3luZhCx9Npc4fq/FlhHRh9byvuI0bpmNVB8BiwyLQiJhvtV3K/?=
 =?us-ascii?Q?nDkzwGpvsgXKplhVOwmjun6GQ9cOrTbMNNjKD0zVZVH65MfgRwK2aS9YnFab?=
 =?us-ascii?Q?WigNq5uzpXOUxxpaQLHHg0CyGGumjfFX4I4q890YEqD+rkQCuwTZ9zV9tj5f?=
 =?us-ascii?Q?XwPTbbCyCj7lfaTmSmnlFYzBwK8tOkNvZ40XIU3lPz7e8qYx4CkbK6AajGvQ?=
 =?us-ascii?Q?UwkFEDvAuAiBIZwhUVnvTHmo0UdHt8KesYKz1tjMPfN3/q0XGfwlml2oX3Sy?=
 =?us-ascii?Q?zdhGzvrlHZhqT5N/hE4z1YhHS/bWpWET0TpcG/+sd1TcvmgmJ0tqo69KRgPO?=
 =?us-ascii?Q?L0Vmm5c46xqE0c/wXqruya3dWpkK4AuO+ySB/B/wmSoKALyX4z0ixzcH57a/?=
 =?us-ascii?Q?kEf3yL5YdqvnkmfqIeEnQCnvc86xCY3OuEQuDUDFjKisAg85+noTGDYcjOWo?=
 =?us-ascii?Q?+EVjMF141o5bfld4WGnuFXz/FfeJ+TN6FnGQQeWObvlG+8qIb3MUM6VUO9aR?=
 =?us-ascii?Q?HIY8raGq5Awf4ltmrTLEyYanqHAday6syX8ZKRDZQmOWId5PwtWJpQdjxhZA?=
 =?us-ascii?Q?RNpN+/uyOa41r+OT7BVKTm2x8DqKr3dIl2ZRwK+yHxPlqregXDhIV75Oeorh?=
 =?us-ascii?Q?2GlJhI0fG7gg/plNoKCFaCF1GgM55Cf0z6+gECki0kT8acNHMPCAq2rYuvD8?=
 =?us-ascii?Q?1QZZS0f/thYbX5ly4uMHi7hEBj0XZCBwaFabehQTI0AekmcqVjgTjxoGcM+q?=
 =?us-ascii?Q?MMV1zi1SCex65jls7FibtK5wI4GiEg73ARlyHciLBrJUO8olh+J3SPAHKKp5?=
 =?us-ascii?Q?gTV8YvCIfohPgfu9lFvvn4qLbrilYxK5H8F4BhrLbjgbGRLt9bJ31sJ230NQ?=
 =?us-ascii?Q?tXFa9v7BNeCcsp27Pux1653LEQH126WrtwuRZAVNlIVJda9nY4KuLKm7zxVg?=
 =?us-ascii?Q?hboAuBXWJgWRlD3Bl/AYRIZ1uPccGoL7Q9nJB9upskPsCep6BGnADhU9SBWy?=
 =?us-ascii?Q?1iWA6Z40KFR/2u5LFRQPKQJ19NzBi6nn5TYow07DRuGYClTHxWY93hFz+b/A?=
 =?us-ascii?Q?cCPkMVRWaXrYTNyXO4rhT2hvhsrDIO0CHLes2Qn1xZXZKgGNDC3twVbg13z5?=
 =?us-ascii?Q?SBeYoyGlvb9+Msz08W1w6XJZCYQ/Lhn6lA51qQ1I7C4bGtSE4NZLoKHhCnI+?=
 =?us-ascii?Q?mvJCUe60urVdTT2Q/piJYas6pqLE0wGnXj6jntU7HfPpXpjZI/vMM42UOw7k?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cad78f-02b3-4a82-a78f-08db73bcef26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:39:10.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlrKqu8Es7vj4ltebMnpsS09W83IDz0fjs94+LwfQ52gHuN+SzCT4oj7cjkAXYMXZLobU8Uy0bEq+bj0a8Kxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9816
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

Iulia Tanasescu (1):
  Bluetooth: ISO: Notify user space about failed bis connections

 include/net/bluetooth/bluetooth.h |  5 +-
 include/net/bluetooth/hci_core.h  | 25 ++++++++++
 net/bluetooth/hci_conn.c          | 78 +++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c         | 21 +++++++--
 net/bluetooth/iso.c               | 37 ++++++++++-----
 5 files changed, 145 insertions(+), 21 deletions(-)


base-commit: 631016e6154d9bb1f992e1bd31615194cc5a872b
-- 
2.34.1

