Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF9C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbjFGIVJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbjFGIVB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:21:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA181BD4
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TL35Xcb4/r7Lp9U+7tNHQrNv8J/h/q23gjHz112QmxX8InjPiBppOjox5V6SkDC3nlnjjauOwAvN8OUUgPFj+8Icz6AP1zwlHL0l1KhW+C7RoFsvJ7igQTAbaqkvH0lhWmqalYp5yJhoE3nKtFw2joYQgYdZN91gJ7cMsnhGYefOYvDW/3B4zjp6RjSc4rkPKi4y8FCz5dnagx2zyWmoogco87krhcixtyuy004CyVF48jeqHDuxQPukUk4pYXcbIaCJDdPoI5lPjhZrJRKRxEckqLaTkoT6/rRyp1Ll7bM6CzjckAfCxmXAnZPE0z6dDGmFplObOVaBVG5hh4sCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJWQkyZfDf2d4XDlF1Aa7Orsm41bx1tAhvapm4hDI9g=;
 b=MH+ZyfELM8TeHMHIHSHsV3VB5uFsMONnmYEaWpUHM4yX4yLa7duOxBIAlw6BSR0gqzMNr/dxaz7jZuVVS8GhvIf8lSYyPNflG3S44GkkjAPGtVw8qnjxU14y6UCsDsgLsA+cCvjFKEr3xeLj2FiOUSeoI3DPmHYmOpg9+t215FB0TRGYpfDwz7fqxA8nD2M+aFr+OjpnOw0B0oqjc5aQab71WQv6YSND86iDB3pRCavRZEVdxMqhPGrTGiB+SYkH1TmUV3JInUQMssnwKXJhiO1k+cIsucdIZI8GmoNrBsBOn9zt4NwN3mZBphl4GY1QSZ6uhfyaSBvWr5wIIePKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJWQkyZfDf2d4XDlF1Aa7Orsm41bx1tAhvapm4hDI9g=;
 b=iLMwA/cBB6IaPUlHXkgX8by6O/NZNY67Ea6zuIZDeV2OUmgTA8kt8kgoFidgYl0SXFCFCBLPod7RenpaQpMA+T+GwUEC8RNB04UslInuH0Gugj7aCPtL4QBoX8Ueo7FRNcnZX5Jhu7GJTJDD9vdXFuuUDTVE7kIv9WxRAiKCIfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7299.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:20:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:20:40 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: cleanup bound BISes
Date:   Wed,  7 Jun 2023 11:20:11 +0300
Message-Id: <20230607082011.4915-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607082011.4915-1-iulia.tanasescu@nxp.com>
References: <20230607082011.4915-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 810fd935-3af1-4052-945c-08db67301461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAID0e3HycnzVsP4DUU9bu9QiJg8N7WdCBoyuJNQ9mQRsAinBuAwoa9EfvzKyxxMXgyds1CuV3mw75JjriPd9zDbnQLeaqkVh4VCSIOWebbLTmvBAHaqVgHIj3CTNTeBcvvXKZmTRHSmZVxX9ymdnQdxsPp/6Ke2jHBrPZJGqewCwH3wkuPU4Xusopw0ZmSL0+VkCxWvy5UjcYJS3u1gz0OOutdw3v48OHIyRXUr5gG+D4DDw9UA4fH8bBg4WaMBl8h4Pv8iF4/NPKtXS+430lhh7SBYy/mWiRAPCtXRw7VURFJwHFilhTLFu0OIeQiE2NJWl+hgC9eXykbuB1ff9cjZfwHaECymmmrDArT6eXsDQOqfLRKueCPMG4PZHbtMordNf65tCMpSGEwGzjSxiqGC/dQ8EVsNvS/FGJIXg1pIAMb+dO71/1jDJ0Av6ISWuG3uFB9XwVxfCUj2YQt8ROrVgy+34RAaMazcVnSrJjkXeSMlHHBaZtcAaN0gWX7qVu0aPA8pw1IU045DtvZz08Nw3UtNlUzkdpYIpPIFdBXVCbRGCTsc4Cjst9xg1DVPUzK+PZbAT4S7FD1M+cQz364awHk+zQpSaqOObC8oN++vGMcky8sP7ML71GP+I6Gj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(6506007)(1076003)(26005)(6512007)(2616005)(186003)(83380400001)(6666004)(6486002)(52116002)(66476007)(2906002)(66946007)(66556008)(44832011)(5660300002)(38100700002)(86362001)(8676002)(36756003)(8936002)(6916009)(38350700002)(41300700001)(478600001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhkoYK1X0X68yB4p6ICq93QfJW/r28tokUP845TUWjfmR4Dl7mfzUMZQ1+RH?=
 =?us-ascii?Q?oOkmiIjiQY6JsyXfaXsLdw42ELokoKSg95PjF9F0Y7wQYFH/WIBd2W0US2rQ?=
 =?us-ascii?Q?pHQYCTaqPo3ElvxJqFkZ4/HJ43qe9ilPh9Wq27vqXlTdmMwhKnFpy1BApZsM?=
 =?us-ascii?Q?Rl5agiD/rKRELk+TOgWJyYIW5QGUG/Vi2ndQ/VgqAVWYwAwhlaxm346PUEMF?=
 =?us-ascii?Q?wWqASlfaIls1YGin3uDoegUggh8ij/ZufKN9lqVD66IQrV8XQ9F9bAkF5fyO?=
 =?us-ascii?Q?7zFQpU0FSbN1RYTDFuVMHHca7zMA8GmeEgjoUhwm/Rh2wlj70GyQIwM2iItj?=
 =?us-ascii?Q?KSSzwlPJ5TLhkXRwJUziEHdbHPLWmA3tbcSjrHCxiRscB8tGXUscMdWx15tj?=
 =?us-ascii?Q?iG8ja0V2HohAvFccehtYPNL1GrPC96qCXtQo9iuZG8D5mus6jRN7FwwmCmFW?=
 =?us-ascii?Q?iR4/7By8s3G7j9jNBY6fDkk1EEiuwVnW4SXTDjZk1zYAFzD7WcOQVrA65nbL?=
 =?us-ascii?Q?rgTWfeKk7muQe5xJBQWJAl1BLU/dUFeRAXbEJtsSiKBtbrx1ZsJDLqKneqRW?=
 =?us-ascii?Q?wmxF4IBH3g8U99RN1wTtR3wraJDRO+zmTjg1tp/LAdpf+UnuOCbSrEd2OUnF?=
 =?us-ascii?Q?TdII+pLdbtxjYWvORmZkBn/zqtQB6gNEOZxm9C4JY2q2MPUm3+eHuUFQUb96?=
 =?us-ascii?Q?/q8o53y1Ojsl3wy2Dfh1mqRBdORK1ENRK3FpOusCvI808UbJf+L5dYFsmAEm?=
 =?us-ascii?Q?AZ5MtcdOCVoGmCFw9HqC/5tKccYqq5pPEV4CENeWr3A/Jy0IxIbrnVmWBq1t?=
 =?us-ascii?Q?MJQQFk1ptOlUvkVIYmJGuBwxhA8EBAObn/VVmP3flRJamRqGgWa7oVohjuR+?=
 =?us-ascii?Q?XJAjCkn91yjN3dV98lFTDnEWh4Byb8VxYc5hBdWDTwYwMBH8Nf55QEDQnwZ4?=
 =?us-ascii?Q?LNB3B+cDvhrmrPvQRdaARslQ7D315FHwcCb8Zpu681i6aZG+ADikP8WjFqeg?=
 =?us-ascii?Q?Er3+Jr6bz+08f8BeSMJitfjXH0O8OxEyvwxMeZKCPZkmMO0n4506tq1+Z7bx?=
 =?us-ascii?Q?ESmcIWpFT+UWusP8TF9GCF0vwc9CfS9QgzLGumxVsVD3e7YEXu8VI7uzOBj4?=
 =?us-ascii?Q?53eYoMaeyQih751MqytU0Yi2DzhF3v89bfqEANvrq0a4UoUTA6VuDCzHi0yU?=
 =?us-ascii?Q?f32LHVbGXipm3DiLYl0q4F7enlGCEcJOWu+DzYh55G3SYJL/iSEnZSFy/lAB?=
 =?us-ascii?Q?HZK1J2Da4ANELGGNXYSFihtiBiCA6ncs9U1ew+2g6viJ4zfbRnnEyXwCvwcm?=
 =?us-ascii?Q?rq+OViTbIfQKWGkGFHgZqCRBKZ8a/gVBH2CDlwSR4RLUFi2ciq+By7sGm1Br?=
 =?us-ascii?Q?TvrLzvDynVWPmRgEjgh2IqCMJATIHGr9UxjhiWHsXBp+hcIBTN1UwTDsvV3r?=
 =?us-ascii?Q?MsVje7ZQf2z/6ZhdHTBtN6YezjWc0SxQt7KyaYOIbxb8QNDQykQ2Df+O9nEE?=
 =?us-ascii?Q?wCClKU71eZMDyufR/LNCFd82xg4J40r4EluKwerVh5FIIAs5REzDpM6m92jW?=
 =?us-ascii?Q?FMAGWok742eIMF1T5BbyzgIl9AevaHQ78wBcRHfF2TZ/7k5/GlMqomi5kGI/?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810fd935-3af1-4052-945c-08db67301461
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:20:40.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfnPPVz0c2UQelUrQCnijTGqjzqxYsEOdGOo2jr2erhYmMqy3+xbQXsCbRRxJMWj7LjgCUCtuxyp0w7podDo6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7299
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For some broadcast scenarios, the user might open a nonblocking socket
and might call connect without defer setup - this will queue the
commands for adding an advertising instance and creating a BIG.

If the socket is closed before the LE BIG Complete event arrives
(connection is still pending), the conn should be properly cleaned up:
it should be removed from the hash list, the adv set should be removed,
and the BIG will be terminated once the LE BIG Complete event arrives,
since no active connections will be found at that point.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index b9a008fd10b1..261e26ec8f16 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -655,13 +655,15 @@ static void __iso_sock_close(struct sock *sk)
 			iso_conn_defer_reject(iso_pi(sk)->conn->hcon);
 		iso_chan_del(sk, ECONNRESET);
 		break;
+
 	case BT_CONNECT:
-		/* In case of DEFER_SETUP the hcon would be bound to CIG which
-		 * needs to be removed so just call hci_conn_del so the cleanup
-		 * callback do what is needed.
+		/* In case hcon is bound to a CIG/BIG, just call
+		 * hci_conn_del so the cleanup callback does what
+		 * is needed.
 		 */
-		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
-		    iso_pi(sk)->conn->hcon) {
+		if ((!bacmp(&iso_pi(sk)->dst, BDADDR_ANY) ||
+		     test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) &&
+		     iso_pi(sk)->conn->hcon) {
 			hci_conn_del(iso_pi(sk)->conn->hcon);
 			iso_pi(sk)->conn->hcon = NULL;
 		}
-- 
2.34.1

