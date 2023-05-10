Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A8C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 13:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbjEJNru (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbjEJNrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 09:47:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D86A4B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 06:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNkyEqEYEeUhXqgpUpcQ5/40rXVzZs0NeujN5sobwqFjrxIA5crhmPRAtIpHKTtX5qzKuoWkV9LkRU5aKyThdUYJLcIZKvKPmEDT+qTxjDFW9ZA4Qdq5Nnfr0g5sfJJgaTacZDuO7DUdXFP9SpUxKpo6FidaQRfXEmjONs8cpgQgsumeVPwHr3zATLOSW/BeVMC4YWHdDsm8A9bVqys4ejL4iovEadnjOGLyqpBIluhysmbpIV6zqSlb0XITtXiknrhXoclMhix5fuhTawwieGcV46Ahc0H7XxBrOTYTi3OcnbVLVZHk4Bx5hQNjp/wW4cepy1A18i1QAqpb9y5cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5C5v/UYxLtu8oHFwxCYJHLZIoiyOYUEzsmKuCjuIF4=;
 b=ldoIyqRt3S1hyWBeghRH5upNGm7+2ZY9o51enWGEvWGyZaIbCrjpTCTH9gSz8AyPKKmgAWF3OGKIPVkAACn1PzYwyEiArj6Xt0lU7TX8ggVZpPN5/1KBFNPn3wYR/6swIrnuxa2ainRYsFFruh6cGL+wE7In6w1DwYsnXSf4HcukkDqyAqLCuA9VBDZi+A5ScC9KgiKRdAVVS/wOdxHSemPeGQwH6DVvpM4W9I4lo0Y2fRaVWkrIPdDWUxTkTXd5/Bqfj7fTRCt0cWTHGdYjZci5rbAXIv2qi4akwKfIsUbsdNHi4Wnfzinvzw7oUayTucCqEjGfHFdWdjgpc9QPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5C5v/UYxLtu8oHFwxCYJHLZIoiyOYUEzsmKuCjuIF4=;
 b=LQAc33pdZ3n6hH1a9Cw+YmNjGwADgxEZBWRfUmtqvlMOmnBc3/No7lqjRR1h09sCgi/kknVbrShZg7Fe3i9dmjIC+Fdw8WqA3v53YUGeamRO/QFKGDAfLUWKfbgrk0TI8HYFgRKG7ofZKJcYC6v11OvLAw5oa6D7LaJztFKjJzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 13:46:19 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 13:46:18 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: Check for ISO support in controller
Date:   Wed, 10 May 2023 16:45:57 +0300
Message-Id: <20230510134557.11486-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510134557.11486-1-claudia.rosu@nxp.com>
References: <20230510134557.11486-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::20) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a8c2db-41c2-4d8e-b656-08db515ceeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRvhlf5kf+80nvqYUbLXX9xcfFQcV9Cv6bqgbH416Xh3G3fyIplCRMF+xwBpWQJ3rUTYH42azOm62FnBxQtYJMVf9vRPixJZg5vWEMb7cA9CJVzvlyPoJ4Yo0npBSEbJ+Sr/hiqykdnr/AbWhwPkE19x4nMfi0aWeoO39WMvYxlltSEJClI4go/NbPUMe/KIm4PxgcHYellLkiUPy6HTSqlD/ZDtuZatQSHQAfwrn09DZ+CKBgVYh04bbnTk6wrq/urqTrjeK0m+fP67uCk8H5gZCwjLKdNK1iYYzQ/iKP74rBYCBeSw6yENhcJPB6PeUSL9nIfX4RBBNNJ6Dtt57PyxsuXF6FZIbMJNVKlZzXwZ8/8g1GhczaDsrnVu3gPVm9nZQJDkZ/xyc02BypoL/PDPZf6E80jYDIlhyNYcaN5weG4dlCASQLbBoMDCgHAfn4TK9Ch4iyQeYpvcouY2ooUr9P2FgPGtzszhDFIAIgqLZwi/6Ey6sHia9ESmydJGAd51GHzOO1nvd9usIY65k8IVkgwJYt/1I26KqPN3BaCJaFaWK1cqhKgActU1FyoHg+5x6BdwwS22RaoUFH21LfR/vKgC9ojYuxH7y81OoE0lzYIQAiI8lwdECp8kzgnI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(52116002)(4326008)(66946007)(316002)(6916009)(66556008)(6486002)(478600001)(66476007)(36756003)(86362001)(2616005)(26005)(6512007)(6506007)(1076003)(6666004)(8936002)(41300700001)(8676002)(5660300002)(186003)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wv9KEpbeRdHv5pkZrd62lgqzKEXYkHCaGgvvyO8jpl1sDd3tPlL3gPICcm5P?=
 =?us-ascii?Q?4TOCGgkATCQYUN1eY8lPhRsvUVe7NBERZAfRWrs5gaNTSpZ89eYqzN/X30sz?=
 =?us-ascii?Q?1UEXjz/dBPwdGcLh4gscaPzD382V/cYGI4GwbShxuG44vpZ0x4WOdPUC2vex?=
 =?us-ascii?Q?ySBsUqJJFdUK9DEbg7Z5ySzcKxAHsrFiGwfvxpWsWgcUcpQhOx00y9OwS39D?=
 =?us-ascii?Q?ICQ6u0gaE6mkJjFSNFT4h+7NwczR4WMAL3tmwM1/HBrWC/QHqeyWBQiGD1NU?=
 =?us-ascii?Q?NjjLkWKqnZJbyN63m84rda0d26f81HThQPc8fNexd+AQRq60MmHI5VL41LlR?=
 =?us-ascii?Q?4l4W9pVr5oYGbkBHKSG9V1nNng+uESmdohy3Y3w12DiqqQ2OY8STJ1QAUQ3u?=
 =?us-ascii?Q?RiY58eqg7HoCB1K6AhZhgfZq8Zu2XjUyq+HLZFwmDCitPyRtQIMzvzftx+4b?=
 =?us-ascii?Q?+5Ae9ql4TpiSic8HNWb1T1jOEZMNoaCujeClDwi2JL6Ui64mQKVWWHQPhXmZ?=
 =?us-ascii?Q?jMRIsnXPmN9zD4/wbGpWK9EI1yxu+DcQ5vpnwI/ttts3iF/vy5l1EayyrnGt?=
 =?us-ascii?Q?Ur/QdccWiMaWd6oBi/aM4A5tr7CyKtcuTiBjAj+Ye0eG6q1jrla/fCpduOsq?=
 =?us-ascii?Q?FSbisEWQiuTGaklAM3mYfD8Fzpd+hVjeKHjl5czkLOpTim65bTeUQrmjSJAN?=
 =?us-ascii?Q?Qo0KKHrN5YXyK85dbB7Zu/mNhrSSlLvpZ/ZVIRb+s5uRXa5ViZ57N9fJuKsq?=
 =?us-ascii?Q?nYPXqOF2W5JWpYPq4Twn9XqIngJvC4e0Y+2pe69KYMfHDiE0NK36pldsNprD?=
 =?us-ascii?Q?Ojc7bHbwunEjtL4cP+GCk7onZnFkULvGTONiUn/GWAR17I5RXftvIRdT38N3?=
 =?us-ascii?Q?4300NFbI0ugjSuvBkle6Pfao3nAaocugcA24K/fbex3EGbyvYZ97p8Co/CzU?=
 =?us-ascii?Q?2WpUgoKi9YEF2F7/4Cbau7dpSiayJWV5AP3x6EqikICbQ2TaQBRZqLa6j89q?=
 =?us-ascii?Q?bqCdqhY9Dd4ICgWd/j2vJQRTiiehY93ACC4wfD90YMgTSSB68FTHiZxvMuRB?=
 =?us-ascii?Q?AeBuNssVg/9TITq2uaQylzd/sGRm4KcObcXj3UQGv2NKt19zACR90fsLrntO?=
 =?us-ascii?Q?xs6Va2Xha4Raz71WEniPw/JUeL42tdDtrw6NTBnetxSzEYZLzb+rKsiG+N+n?=
 =?us-ascii?Q?Gns5XmeeoPKCzCOyp0KZVvADZUxE19fwCRIdImZJaxtpVry8n5utcnQD0FOt?=
 =?us-ascii?Q?2tWl5Sr1sZhvE5bSAFVvGQFmkZJH0jamjeau6e1Hdh4KLB7VC79Ni7RYW6Ra?=
 =?us-ascii?Q?zh6fG7SexPOuu0UXfrt8H2PpgBcLEfBSonwVtiG/BmghxXkuW5fifWL5U7Xe?=
 =?us-ascii?Q?o9NjkEwGoJk/xlonuxF+U8A1qXs+UWa6jSBWG4N1nq+KIjOvYjAnZ4LrrlSj?=
 =?us-ascii?Q?MRASPIFoRiViBwUEP9Z90y4q/sdOla0jDGSgzdvLFg9WVcgITe+n4xqT434J?=
 =?us-ascii?Q?X41tNlkBGD0CGDWT9MhFKO5Ux/S5WVPJazHia9Jfxc69R2MDbi6Ixa0Lnm/i?=
 =?us-ascii?Q?PRW1sVL0Z+Iq82mIkJCxtm3DW9ZHHq2LsP4cqQ5F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a8c2db-41c2-4d8e-b656-08db515ceeb6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:46:18.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORMlzJk/PRbOAMLkOBLCSUUz3yxka7hnpJmvEhqkF/RqYgFZ+UA1ycPaItmB+q3hvC87oONpVsbgZMV0uuYFmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch checks for ISO_BROADCASTER and ISO_SYNC_RECEIVER in controller.
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 include/net/bluetooth/hci.h      | 1 +
 include/net/bluetooth/hci_core.h | 1 +
 include/net/bluetooth/mgmt.h     | 2 ++
 net/bluetooth/mgmt.c             | 6 ++++++
 4 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 07df96c47ef4..16a452438dfd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -576,6 +576,7 @@ enum {
 #define HCI_LE_CIS_CENTRAL		0x10
 #define HCI_LE_CIS_PERIPHERAL		0x20
 #define HCI_LE_ISO_BROADCASTER		0x40
+#define HCI_LE_ISO_SYNC_RECEIVER	0x80
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6c8aee2f256..6a0ffe027d57 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1760,6 +1760,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define cis_peripheral_capable(dev) \
 	((dev)->le_features[3] & HCI_LE_CIS_PERIPHERAL)
 #define bis_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_BROADCASTER)
+#define sync_recv_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!test_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &(dev)->quirks)))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a5801649f619..7eeec8501846 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -111,6 +111,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_WIDEBAND_SPEECH	BIT(17)
 #define MGMT_SETTING_CIS_CENTRAL	BIT(18)
 #define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
+#define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
+#define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f7b2d0971f24..61c8e1b8f3b0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -944,6 +944,12 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (cis_peripheral_capable(hdev))
 		settings |= MGMT_SETTING_CIS_PERIPHERAL;
 
+	if (bis_capable(hdev))
+		settings |= MGMT_SETTING_ISO_BROADCASTER;
+
+	if (sync_recv_capable(hdev))
+		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
+
 	return settings;
 }
 
-- 
2.34.1

