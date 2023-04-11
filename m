Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F4FC77B71
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDKHmJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDKHmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F5199E
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 00:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3xoJWYJbwQeftRe56kO87yYdw2P18Mp3Dp681pZD/LxZbUS3TcIQKCk4vIe5xKModPKuC35tGmaX5yIXntJRgR2xLvVCNTx/kLgoEf14bAY90yavQbmr/qvYC8UtIjD+bTWNBNWOVGngd/4h2DjBWIi9fyWWZozwvLAGqoqAjQTKvpkImjOgOGb454G9VUGWKUET/RdFLqrTHavO0i3GsMBQpw4YXbgJrvD98WhpUfjcdx+FeCvEQ6PrsWoKucaaqWJ/M5GNc1faiUhCICPzmBdzLIfCoLPcsQAC8hsKZqQXy8HQ/NHHN1briuf4L+e754NbvZ/pFrNKTyYWn7hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUwEcOjkRcJGQiuiSQqZC9t7zfP8BDVTQSi9ceT2NOA=;
 b=J/YJtBkBWtiMtYOf+BDC0QyuNu1kNtKiwIEwW+1hJ3tJa3akBCGUUbSaqAMnJs0UrFGao+l3EvjiNe3yqHCergsKKxTzvI9gVOkGwvBbDP+FkCit+MAEYMbRo2TaeW4wKz7DRjIawrnQ7rn0oz3C8UFNrYAXJNQOkHZxFkCb+fHAbERw8/48gF5qU6WO7rS7R8yt0uw/ZNDUsUM0K3unoOfX79+X35x4Gtbn4fcUmSye+brZ2kZsBG+I9J2KTmdbg3aBYpg2dOLxit6mcCaR0Sq+nbAp3gvV5f2PEZfN9/fzvmJL4gK+NPPLqCmRj9eErIaauQ7eW+/cI82+ZKefpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUwEcOjkRcJGQiuiSQqZC9t7zfP8BDVTQSi9ceT2NOA=;
 b=Aqvw55y6l9o3/HpWVODYqZzyRskzduJPT5VOZ5o0BjUHCGqwqZw8ugjesMbdkuF1zHfKUBfZ2+nCwLYCOWjSTfQJijl5loiOgsL6jAlY/hF761Iy9XP6MEetnXSx//HyIzoxA9gAINoz5OPt1+P2VvRgBkiCdisOGWrb0HTmM6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 07:42:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:42:03 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: hci_conn: remove extra line in hci_le_big_create_sync
Date:   Tue, 11 Apr 2023 10:41:35 +0300
Message-Id: <20230411074135.69768-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411074135.69768-1-iulia.tanasescu@nxp.com>
References: <20230411074135.69768-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d143d4b-a027-4b91-9194-08db3a603dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a16a/YkWRRVgdR1ya34rzG0MR6XfzSfAw9V1dKriR534gVhSps9w+ANtp9PVQpIDPm2maaFS+NKdudomDHD73VfecB0uhEy5wUUbSBUqtAqrog/uN7s0Qzle349Akjmb+ImVbFMtFbj2NnnGCNfOGyeApvtlTOS0moQE877aNP07tPCno1stCwPEL7wg+9RUTaCpPdDNvp6GLl2dqAt1PiUxCaGFRgso8kowrMlLfJxlvR1KA9qXWy3m9B3ELoYH3e0clqHfM/b8uEuVW4uXjPrri4ABldJrROpCi7jKINxwGPL6Y3256vAE/a42WOAfiR3bkOquAJ28caOOW7nE02yF0HeMgb6QS9N2XymOJJWYSEa3FiAM7YjIQeZtLlPhDzZi1Lb0rtlrgpMfMNdhDA6Jt/9v7tOFoeFC1vh4YOaF3aFCA7i8YgpwYY8TTBNLFP7A3/WBXAuFKR79vdE6vJ6ozlrkzOutwwyQGHe/NFDbx5jlvjB05DOAOQqtzzQPqgzy3qHDsW94PGBHAKUgzZehLUyxLcnksimi3d4lMiI+XBtxE5yDXifGDnOiLy5AI5pWhasXt6dqWZvBbkUncrhkVhakn9dcj4f561GVKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(6486002)(52116002)(66556008)(478600001)(4326008)(6916009)(8676002)(66946007)(66476007)(316002)(41300700001)(86362001)(36756003)(83380400001)(2616005)(6512007)(6506007)(26005)(1076003)(6666004)(2906002)(8936002)(44832011)(4744005)(5660300002)(38100700002)(38350700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDkmNmq9dDu3td4aeSOSnYkwYiOpjf2cFFnxh06nrRgVwekHE1BcjMIT9mnM?=
 =?us-ascii?Q?gqwiVmZ+2PdTMhjepQR9L0l8s64D1rPE+zVEQepgGAeogoB/eaKJ3VBCXsvO?=
 =?us-ascii?Q?FBy7ZLQcQ0B3zN0HWXz6TIks4lhyh7JpCc5f8P4b0YaDrNFDrdAx6EZtgknh?=
 =?us-ascii?Q?56HJTuA3JMo4oYmJVUztCclA6Zyf+6HBTMf21JMpsMSLqNAek/B0UBA+Q4Aq?=
 =?us-ascii?Q?GlucKiafgOdc6kprWiC4mx2Kpy7YhRALbQ2y1ADvN9QsRskctznUCPt7fDrm?=
 =?us-ascii?Q?QaJ7YTovfi3b8mRyxx0eEOH1caN61cE830vomD6L6QwDL8ltHuvuEQSTSC0E?=
 =?us-ascii?Q?AF1uaVds+DtlQVKaozaJuijecDD/68U04f+M4UUC741PuzhOCukz9aabKN32?=
 =?us-ascii?Q?B/yU6q7FdzQAi0+r6d6wudgjRGzfdg2GpVMKpffQTLWxViRZVETPs9+pfJR0?=
 =?us-ascii?Q?z3iYS15N2yn4ChOHZhYHC2W3zSRjekA8mz8mkLD4tVNtQb59jkUePwsMg11t?=
 =?us-ascii?Q?QFfFKZ2Vuk5LSJxPTW4YpMLI7dwgkZOy01c543AP1tiB38kxtG8x68Q2TvWS?=
 =?us-ascii?Q?bJMuc0hKlaylyle+qKqrViyb5BUGk6BItplihT+k4DcUJ6sHGFZdeKgYJQvg?=
 =?us-ascii?Q?OblFz1kIBsWBNp57VvA5mUf169lRk3yPHQqomP0HN04Hk5nqlmAVuOozwl91?=
 =?us-ascii?Q?/JIBlFcalb56WrPYJkdcBvzahtCYyscvbdA5ymoiKZtBLB/Y1biVCXpaf5Pm?=
 =?us-ascii?Q?Lj0X4fXfb+uHlFFKohP00XrVxguUsqU8GKP3MaqUD8m6et2tEBDgTpMoUEJ1?=
 =?us-ascii?Q?gpbpgOLq6/VbhwywLLC7sQdW5K9jrimpqee5s2miTzOYTqfZPka0lFivuioc?=
 =?us-ascii?Q?3iD2LPLIGc8+rLv3fQToUbJZcpCFBA/Q0IHkxAh8WSrXv0nJsiAlDJuQpUdh?=
 =?us-ascii?Q?lLnDHbGa1183EuHdGcMRGHb55PLpTCfdZAohi33SqkDcj8SPGWbN1F8wKzmI?=
 =?us-ascii?Q?iplaRXws/A63r0vFE0BqKbSxxBQn8EI+XiRJDO5+NLLxVFvrUp/VvmpdDN4L?=
 =?us-ascii?Q?/tblicBZfblkfCEK3LEHRjnN85z3qe2r7DREhUaXNg3d7pQ9YMOTODkztGjP?=
 =?us-ascii?Q?KV27Kp7KoPW3uR3uWaPBsSmlRaFrI443bHodH6mxi2/pdNOcz+8GW/HYEZaZ?=
 =?us-ascii?Q?SDeM2oy1BqVQ5xbSN+hgZz0XwpHR2aehaCT1Ab+ZOW9cv57Wyr8tjnVjzW1O?=
 =?us-ascii?Q?RTgLBb3idLvJd8+t5AMJKr4VDgSDnH7TgT7d2h9GAehwAtb95Xg2YJmPX8PR?=
 =?us-ascii?Q?EV9gb9GyJXHtPXjjvZ1uE7G3cr94/ma9QqKcA4wcgoJiYCCcnBw2u3PlqjbM?=
 =?us-ascii?Q?Pw4NWaEZsxQMuFrqlTXtgc4hx9aJz+schFUyLv0R1/qZglw18Lz6QYXaSTHo?=
 =?us-ascii?Q?lJRJkKlNnCoJtuD7PifcT2QDdhlWVYjB9JhZsLxE8rjFn3cXrsRl6ALQBaJZ?=
 =?us-ascii?Q?QU4GMzpsMgs9kjDNeRQf3RNH6NP36g9H9H8ZoUj7ISewnTntwvJtXGoPo3Yh?=
 =?us-ascii?Q?NtgZxWAdhw8gWkoS/nf9myNNfPuc7RellkvnEbkR8vexupxPEY/I8AYXekwq?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d143d4b-a027-4b91-9194-08db3a603dd8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 07:42:03.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M0mpq3wnVKCXCU8JMHoTT+MjPXcucZu5YAyi/+vTB7cjmnGsV9xAsCRTw/782M0r1rMzsuKsIcbVbLma06+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9186
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove extra line setting the broadcast code parameter of the
hci_cp_le_create_big struct to 0. The broadcast code is copied
from the QoS struct.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5672b4924572..01e0b7255174 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1700,7 +1700,6 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
-	memset(&cp.bis.bcode, 0, sizeof(cp.bis.bcode));
 
 	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
 }
-- 
2.34.1

