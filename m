Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AED4EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjF2NqO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:46:14 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:18976
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230036AbjF2NqN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 09:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AURjFcenMvvzQg3om3zQygGPOaunC6NQ8NBE+p3mST0th5RacWM68czpK38S1rNbT1u27zCWhwFUAtnGI2QOsuFmWBRnKZfP9+ure1301aKl3YPGGuNyhvUuvyji2k04PuNfrK+F6qjmaufJVk5Wu2FkgU1d5CCOwanVDzEzCVvmZVah1VjzQbdc4ZiDmr3qrMsn/22P5BdVDR3VvO9z2TYrK44V5EGvOW2rHXoiIQmZpLTymW/LpymlelnLdMTi7KhHtfkNjDmYBppgYxZVHHKnCrcupPMLo9y5gyXecp+jSqKK5EoE+af2pC+HyGf5o1mZGXVxNrbgAt36Us6oMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2Treu0E9RO1lZt/wCSy/9aJ9TCqwzDEEAqpZDDiJSY=;
 b=ccjAwKFUuPLXJU+plWqedgeu0n+FxuYK2cOoL7N2cutQwgzUx617fuOy0oIVugAEcHfRdG+BIOn5v+k2Nl4c0loQtEONqi1E0kf9j+pZDbBN6eknXPwE3AqRCEo6QXf8NcnGrpvt4X7mvjnpRfcT2eeImZXJ1lnEKuJEV5a/WG+vXB5W5QI9IMdwMY128NNNq7QLAPuXCDYuHE1XSXjsHnfqMWWxVPCOll2SikReNtFxmG4syk/q8GcbrdEXQgGQVWgwoB4ZZhYfLOTTTLA48q4+qlr25OAXoJ9TbZ8dH3pD3yk9aQn21QgqK7FFHzM1KuWaEBhrWxehT7GjRzy7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2Treu0E9RO1lZt/wCSy/9aJ9TCqwzDEEAqpZDDiJSY=;
 b=RIcHC/2RaHf4umcLELqClrQTDGNtz++ATDOCIYq05n9eiKOGjr5tAhXLhm92A9x7JmLI1oWx/c/9pQ73DRcNOu+hew38T/8bjO0iIEeG5/2YSH3FakAmsQ7KtyjCRZMlSH/pRADD3ZzBHUmVwvIMd9HWHdTTYh4aOqe5wj7hkYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB7634.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 13:46:11 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:46:11 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
Date:   Thu, 29 Jun 2023 16:45:18 +0300
Message-Id: <20230629134518.5574-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629134518.5574-1-claudia.rosu@nxp.com>
References: <20230629134518.5574-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e95de6-402c-42c1-c3f7-08db78a732a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owqEf3wPiKvFNgxxueMWfUw/6LQDjrMzwty93azdd1+8DJOdCY83pwn+B4B3GgOGa59MP1jkp1FU5HxbSkpPGwAD6w4guVQ4Shi+QSrQThUXMTErrVImR7XtUJ//jdQghJjnwKbhlunBVVr1OvKvaW7DbM/Rn4pKZhPgfE8Gmv1YSMawdpPhIsUHeytu4/yk2kj8CWugiUmVtoqL0feptYPH0ZKopZCGBHhMtrbM48HMfh0AuDzbJas4P2N5o0KWoi5jvnCbROzjHeDkpa03DiGlGI3Bj/bNeXYWH8N5mRnTeRZzO14zylLnXHRV1SRNaA1aAQYhSEFEweDpRLuzEUDgOQx6RylN9j0qIwqVEi35oTZKqY/o92TfxVMNDrS9Cf5vhQ7iYQ1DNnadWYhaO6BiPLmN1m4GLtOL7c+OEh/2FevoYEzPXU7HCEzfCo9wAPsNjc81yPQ1Hp2Lh+9oBPvr+swH8r3DqU33BgO2kGavv6YpgYsJzKhQmpMprQ79gu0qMePeXca3Nwn6yNUqtnF2Jdl70FET1EoKTJs5TM14VFr4CGufUjJAoboQgnfaaNSrMFXpMFb9cGTv9so/scO+Z/Vq7w9IoCKORSNDxgnkXid0n7M0zjD9UX8tI6Z3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(8676002)(8936002)(5660300002)(36756003)(478600001)(6486002)(66946007)(66476007)(66556008)(4326008)(6916009)(316002)(6512007)(52116002)(41300700001)(38100700002)(38350700002)(186003)(55236004)(4744005)(2616005)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R740wWNlIQ407QgIc//0CBqXMZTnRNyPvRneljGTryQkkOPSnATYpNETokgg?=
 =?us-ascii?Q?zq7xTIgQEWGHCUt2E5ctR+VcQUmI9uxgc63h8qbqhR3HQ28YZqk64ylvwwT2?=
 =?us-ascii?Q?vVaVYT9diCYFG34DRGSXTVM2iuqwzfgCljRX684sStimiqhud0HY6BfEHpH/?=
 =?us-ascii?Q?7i6ID0lV46q4yzM0rWWPGQg74mNimI00rfn4ScBZ/E12NwEre12FGBtlUHSC?=
 =?us-ascii?Q?DSEdpM9PBc9tkJweNn7wM5ILra2w63uaW7WJ01uryjk1Y5H39KwHE6m9bkej?=
 =?us-ascii?Q?fWE7rHBBTr0/n68mte0NyH7YPd12vSuww1O/j3p+DQVlwJLyy365fnJpLFEe?=
 =?us-ascii?Q?u5cEMpmMLH4XjkbWtyXoXDbjXEjhg2MkXCtztcwUykDY1y1+60dNDMw6efD7?=
 =?us-ascii?Q?dCjxy6OfqfTAuLqSSNRF6rUupaKWg5BjakV2h5QQcC6lzX6/TJxMA+pU/mMF?=
 =?us-ascii?Q?4YIa3oLUcNikBbZwlYf519NsKL/OSVnryULFL9b1kcJ+N1260JLLwa159NtZ?=
 =?us-ascii?Q?Bq58RgvCmPB0XBvGTyh5xwGK18KJb+DDkxydUIE71wjTHx3lV389fDxYYvza?=
 =?us-ascii?Q?5kFGvEtOanRP+c/iLoz5/xemcqT0BRcdmhLqWOUKi63rmoNUpmlNWlEu84lE?=
 =?us-ascii?Q?7PKsVsHeZzwcXF0KYilxelSLx015sxaCavzn8FFuvleVoMGPqHA/9i9/iHAW?=
 =?us-ascii?Q?x8Fvl8FlJ671xJJoN1iIyO2g0rzucJsWVMapSXBYJGMvrUrhMBGfyYqns1km?=
 =?us-ascii?Q?iJv8ttXATgRgTaYwIg0hsZ3YbfvfZF1ntoBYZBuwE2ndos5eae6v+VHz4RMP?=
 =?us-ascii?Q?r4FXDwPlzO6uu9MCePuFkt9/N3qo+E6VSpwGTQMR5ewsAXNNguC9uA3HQZoF?=
 =?us-ascii?Q?6oev0sgbK6UhVyKufUO9L+Fe//Y6AV+5mF040e63nLR/g0wZ9IlhKtlWykQm?=
 =?us-ascii?Q?bnkzd+fld9zOewjTpp8afRJJSB6umriivKurYmVdvsRkDy8Ev5IlF2OmMrqL?=
 =?us-ascii?Q?9tkl2mqcvx7KVojctKUmEKFp6fFCTKgFjH3AYKGF/wgmT3/kNSZhixDpuORc?=
 =?us-ascii?Q?/crBfodG7okOfFk6YGgem87D4rM3DmQ2MfnXcBfWaL8s7xzl/xeBBdEkxBo1?=
 =?us-ascii?Q?3Pjr5HhN7rTJbHc3n/yLX1DJ9jC0qGFD9m8kSUdEj3PiinNlR/uhWWi8mOV9?=
 =?us-ascii?Q?jXKv9kMcnZEN3LPGeLg3Sts207L7i9/UaECU49TwHswJkVy9I/bVAwHiSvwZ?=
 =?us-ascii?Q?vVWXC0dl8HH0+rowD7V1NLIU2ivNN8A2ERaWAi/x1Eq6rr0C6o/eh5XFPvF0?=
 =?us-ascii?Q?Pdv/kEur7WZOIbjj5PO+wQwyoF7CKOCTnOlK+Tk8Q4rbQnzdzoJOHnO+h0cc?=
 =?us-ascii?Q?VUIdUfjgKlLGuBSr93Psv1D1KqUEk+O4e7kqvi7q2gWWk5HNe8Q2qAsF9iXn?=
 =?us-ascii?Q?5OMpQMU3f/9zC4zCPrft8Fh+R3k+Q+Zu7DV3n3zlWvh9C5WHNR8ig7tjp7c4?=
 =?us-ascii?Q?i8R0iGhCiF8th8BqBRf5CIuIIQBQR2SUYaF3PBKnn7Q5xi9UppZbtqSZkzr0?=
 =?us-ascii?Q?MA2Hl086QIJbrvvTgyl5XprV9+75fCkJ64QwOvDR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e95de6-402c-42c1-c3f7-08db78a732a5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:46:10.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbCX9Q6kYdAVvSn4ljyQGSTWDvhtyIXcVrEbklCJE7xjf1FVvyxHQyv/OKj8xHekXPOece4zl4gVbM5gBaIpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7634
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Synchronized Receiver capable device, enable at start-up the
events for PA reports, PA Sync Established and Big Info Adv reports.

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

