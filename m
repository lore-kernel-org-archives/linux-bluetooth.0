Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6035EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 10:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjF2KB6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:01:58 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:19553
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232105AbjF2J74 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 05:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIHmtuqJmtUNkj7a+0CTILBOF0Mo3qMFmCfZ+E/HAQyGGgfE32qaMYYmyNihN6FllIx+FxV1qeFlFeZz3vZNaOBIbQvjeTn9p6K442uzQjgF3Lt4DhOcJZL2XXeGc8FXZYgJ7u3wQqcF1EXmTcX54gX2EI/VxkdKZCxQWQqp2lfMotb+ppEU5h1nWby7HvXW44a2siivGey7kJiw8PwdbyXUsUXr3/G6VsQWAE48I3fw3WaEY6HIj0ARHLce00QgLmB4JR4B+FgE2RDyM+f/rnDUCRHED1fZEQzQmq/PsFPnHGo5e7HKSU91BHMHyttPGkmT7zb1Sj+KkDa9oi/J3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7N5tm7PQvy4w+WilK7luPaYi72vudljwocW7F7X7bo=;
 b=Ru2HjZLVnge+Uq6zrIpQzkbbMbQrJOAU+BE6yZ4Lhpno8KgYcOOBd2lV5O5hrefgmlHDqewqyfLPBFE3+JAhCUYx5h0bvVj77ZxPIOwaJSymJXa5Y9XwrES0rkH3X01+NeVbilWueahU/d3N8Gj5mr4+nk9P9Sy9cPSZ2pgL+vBpevaIB6gUopYXTm4Ij5nNvZyRYcf3OVdJmSUDc8lArmQPk8amPydNQcAv59O2DMcp6JOV7zUaIGwXvqUoR7Zs+DFNrY/IiB5q7mKzs0hwbiPiI/cKJb36DyfFb1vPfBJZ8eKimxykSEYrGFuO7N+gRJGM+LNfbJWoVAzjn+pIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7N5tm7PQvy4w+WilK7luPaYi72vudljwocW7F7X7bo=;
 b=fkIJVoynjyp5B775xbar4zK3QHxfbDoVW9VjT4XFbzzHZZRFH+igPZXzr+Ji2fg2jr3bGyqj2eF+VEhdvb1nL7XovdmWmDS/rUD3TnDiT+/VAowpx+X3JQykHPdEX/m4mGS6gYoRcEczKBZqe56ZU3cvDeT5OZMumjIRHrgnpao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 09:59:19 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:59:19 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
Date:   Thu, 29 Jun 2023 12:41:20 +0300
Message-Id: <20230629094120.5463-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629094120.5463-1-claudia.rosu@nxp.com>
References: <20230629094120.5463-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::9) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 5265f75e-dc2c-4800-542f-08db788781a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4JRhkabato0ZLf3bHvmOKMpY7jvFz/bDOTw/vKBCkBivKTJxKZHIOhWeAU6jAEEehgbdJy66KFmcB466WvImgrnxThdVlqgVst+kwDBvV5YSoLk+skAlyfAfr0LlYsV9zdDvzvXGxtj/9rgzXrxwpssrY0eLNBzdzJ7IK9SeDShc2Ig20/Lgny7SFb4klrD60hNo6Ak+uNdJP4Igyjo4NhhHxW9aCi1WGOWHXd1GZZylzJ20zaGAlHtr3h9QZHlgM4cD5X14xU3wI2zhLl6H9ZBCbbukhqH5kpgjY+8kmxNooB318tLieqJDrvpQfH2l/VtvIwXHkqZ5cSUPyRGFlaZSVeJDrZMNlBVUzfm1rFDaT+oUF7ZTPrAB6IAGbnIkEXvhDdVpB/yAWjAZubFhWcdWZ5DXRNwdnWGXt2kbnQW/CYtDAQUYtrMS48i4vDq+xgW149IxXsRZ1uBrn/RCfInRSq7ti1QHKrW25EUYXlvQ6V3A3v+Z20Ok7LcIZNHtYf4PaRmZnt/NT6utR+deHurGvqT7FQdIDyCdSfXu5UmSjJTiNtQ69BS1VJ/ykWPP80ELOFyA1S3EgBxNVQ0zS5nVa5kKeoOyMW9/J19xD7etiAHvDKhrhA+Wn9Gljea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(5660300002)(66476007)(26005)(2906002)(4744005)(186003)(1076003)(38100700002)(2616005)(38350700002)(6506007)(6512007)(8936002)(55236004)(41300700001)(66946007)(66556008)(36756003)(6666004)(6486002)(478600001)(86362001)(8676002)(4326008)(6916009)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iXwo4T64inM9APq1I/3PyqY4MWpMbtO6j6LNchcS13jFAdBDj1YMAKq/vp3E?=
 =?us-ascii?Q?Km5Sf5SyPTNyin7SdkZb78bsJFe0emsy/VMGfIziGt3DqGx17p3TWxdA1ing?=
 =?us-ascii?Q?vQEe/3U1gV3lJijZdnXy5aY0PxbCFTnQuK4SJoo2c9mwF89ireHmZr8xQEGv?=
 =?us-ascii?Q?LveqTK3sfzemOiwoNRjSK8dlDZvqPS6XMtaKBSKOQQQsT0gxuX9khy9gtVDn?=
 =?us-ascii?Q?I1CS4B0neEkddDL/Nc2zksEok4kX1OfMs2YRpVOQlEIe0JhMcb4tszG03L7f?=
 =?us-ascii?Q?SDXFDxQdVohvdygGHuSO1EhEgiMgOYuibZBVveWRwFaVbdUpj5kRS0gH+SAH?=
 =?us-ascii?Q?I7Q3rDCOQ3TAQZO6groJIC1tRYDUto4olrbFskSwC3ylO7m3xWjz//xQKl40?=
 =?us-ascii?Q?zVkIZLdNilyG7h8QfJldXdWRnjm30ZpK7JZQcjhigKYQ6UBcLmwnwyn08Okf?=
 =?us-ascii?Q?b7jHhJfO5fiSWY1ql9FNcWsE1z/1nU64naab3orAcEaXpJfThRNBWEbucsfA?=
 =?us-ascii?Q?vZXOgWIKDp8wyMommEZZ5zldoIh3SnptoD5skenUHI5xzPorhRl4ErpqV0Dt?=
 =?us-ascii?Q?yTf1bwaGlo3eo7Ej0kJE79hr0SXe8RVEoyb/tRprWRZlHNr+yRjbkXWZEeJV?=
 =?us-ascii?Q?CkTLWYQQUGmVt7pI7S0bnci991pSk6dWukpf66Jdp0s/aXq801Ioytll6CDQ?=
 =?us-ascii?Q?WmaGP0PZTfW2THLKxdUEdcTw1GlPy++Qa5zsHkvMPwIP4hGmlSpHUKPGI6k6?=
 =?us-ascii?Q?4CAIvDQRgo0x3hdjNb9PnQcSwPeaSZMK1UOzzoxrLIvhig1GzhSwiOoMZFAh?=
 =?us-ascii?Q?sJLQ1605FliAzoE/eINBrbpAFNa2H/DrvW4mdTy5SEJaArjv/dXoddvaLnUP?=
 =?us-ascii?Q?/zgoy4Ntq6a9ljY1TjOc5a/H4NXU5fWGNllsIWuGEeE3fEn1g+ZSvPrsdy3m?=
 =?us-ascii?Q?8Z7cedsewIL7S7sr0hnWPlze3mDmUSX8sXkH3Zr036O+pFKaSLCbrcVPVOTh?=
 =?us-ascii?Q?xl1m9ImHSec9zOYUo2gnxLht6arnscZH18REFQUMAJoidpBuZz+sdncBC6pA?=
 =?us-ascii?Q?8tN8/YwrfkF2WfNYzIogyqxgWrUVDMwro2ivQwaoSr3On1QK2U1f4m5ovwf5?=
 =?us-ascii?Q?kY0G570rIgrnEJbgJikiBKpGQXVYlqqqz4RMLS+tQQQkbQhvHD0Qo2hJm4iC?=
 =?us-ascii?Q?+mmyqpiJE3LHx+VJHoUbaUaDsNm82S1LBE85t5yP3GjFqLWek0zlOyeSTZYG?=
 =?us-ascii?Q?HIMD8wRoasaHWP9k18PXhtzUps9Mw7YHnbk+J2qvHs82QJqBTEmp7AZVLwHJ?=
 =?us-ascii?Q?90JdaMdigr00M87cP9hriMlKmGKb0qJm6RbV8CPwEbp1SntPdDo2B263l+HZ?=
 =?us-ascii?Q?wbUSjxkW5e5mLuk/1Yv2oablIUu7ImqTuAPgzScCxin29fXihLQtXDgY7oB/?=
 =?us-ascii?Q?D64Gl5RV8+Lplq1sPIosSzvGKepEFOr3YwwjWIOCTimLT/Xlk5s4klr7H1E5?=
 =?us-ascii?Q?1OI/S+IRQD8LgXNFeYlHexMYuCtI/LcatqM4JoEJ5MCePtMfN2y6sv7aZN1s?=
 =?us-ascii?Q?lBA/XRNkLjKd/wbP92tfF465Gma69I73w/0FmlPg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5265f75e-dc2c-4800-542f-08db788781a6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:59:19.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWlHRO1m+gNcvVIhNmVWC4yWlUPHrqlC4W9Cp2oPM16yxIDRQGHp6ebrz+guRcLB4fjGPLtfzlA+ohxqPAQOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index afb8e970e62c..73b49d0c1e11 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4135,10 +4135,13 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	}
 
 	if (bis_capable(hdev)) {
+		events[1] |= 0x20;	/* LE PA Report */
+		events[1] |= 0x40;	/* LE PA Sync Established */
 		events[3] |= 0x04;	/* LE Create BIG Complete */
 		events[3] |= 0x08;	/* LE Terminate BIG Complete */
 		events[3] |= 0x10;	/* LE BIG Sync Established */
 		events[3] |= 0x20;	/* LE BIG Sync Loss */
+		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
-- 
2.34.1

