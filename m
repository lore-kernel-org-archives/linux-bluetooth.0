Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EA1C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjEJMJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjEJMJ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 08:09:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E77D93
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 05:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aapn73zBbxZ0qo9ZyxAoBs+ChFjLlS8rK8Lnm+0Q9swqeqhjLhOzrMc0z9JC8QmL5q0ODuTb+/+wp16VJ06yl3MRKQwGidOPPm5PaXKETpcA1p+IewDAd0NQIUEKt402Ds5cdnfTBBWAR0KQ40Ja/8toxdV6dT9BrzXD/pkPEgVdcJ1DXoA6RtEnnj6fpxGl39LaGr2fccJaYEGfncLVLJyF/BaboIP8bccy0Lqq79htw4oy0lK4ug4eFgSL6QACv+bkpMbFF6CUusDh2m6U7sbivsifCzQ3z8ai2AUr9JfNVMujNHad3TVhnITwoYcdhCKflH1AajDLNRGrL8Vv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5C5v/UYxLtu8oHFwxCYJHLZIoiyOYUEzsmKuCjuIF4=;
 b=gVhlhHjHgcENJVFYZE4ce7nuqYJMxht+Ua9QMR89nfk9qwnLVrILyo8XMk/IMeR8oTgL6lXYSHJCVzkfWhvMPmCD1WOBWs2C3Y6TPOg+yMgS7JSuVNq9DsegsmoSDtK2Zq+1IPzt3WFkiirr/BP96Zx4WZl0j1s41zsk5aiQiZpF2497Q8MA/jnEfNzh8L0kDFLtxXL2bKUMngo2vkdFKasQ0JfpFQxJwnhR/KxepC6seWvxZ4tmZxsB9eefRq6a40H4jKjY7pePn0SvuGbkm2OsavPdT/7Pc476FZ1WaWBbeDAq1ZG3pym2zNlaWNHhnSwkXyItUKH3BW4Jz3ooqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5C5v/UYxLtu8oHFwxCYJHLZIoiyOYUEzsmKuCjuIF4=;
 b=eU/oMC+t0Lw2+2NBe9QdsMPBbXOzck/HTv+Grz+zUjJzh4h/yh/F6cs7p+GL/Yw7+T7h4WRNuwveSxCFEi4yRxsRPXQH1fdUPqcJ5TuO2oIRNqyVCY6ziw1RspSjEqHxBfK0cH6KmdzrX6Ygr6FkJgUi9Bvx6bopNN7SejNLDmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM8PR04MB7234.eurprd04.prod.outlook.com (2603:10a6:20b:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 12:09:24 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 12:09:24 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 1/1] Check for ISO support in controller
Date:   Wed, 10 May 2023 15:08:43 +0300
Message-Id: <20230510120843.10336-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510120843.10336-1-claudia.rosu@nxp.com>
References: <20230510120843.10336-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0025.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::38) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM8PR04MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c559b5-64ee-4032-c156-08db514f6528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pw9up0G6Fzd8DThtvobSHIba7YtsHB9jcgr8pxUDBUBb/nvOA6226EkOxVdTcE0rKDbKNCPT2i/gilFukp0I0V6xLA9daxWE2Bolyf/FkAbZWa51px4AO6CUyTbNgDwOifiHS5dKyZD7bp76nbj4DrTKCVTxD5zIbpglt/nHEZ6meE4F1RQmZaFKIPSj60L/d82811neF1gF8D0lf118AygsJ/8YztCQtBstjD7Hg8TQbmnqPPLmqda7xJDrTCLw4gc0ab+eujFmEm+bPlr1lpJz3ERYFYpd85zmYv8aBJQ/nrOzor9O/jBGoaY5nzv8PtTSWT8VU064wEvGvJyXphUXqqWePcAjWYyXB4rbZAVX1ZPXr4VvEf1uox2V5D1kJpEWSgPzr2qBiYScrRvB8vybnU5M9vuuRO0LvtPnL9f13r5TYGKhEaHcbiYEGyLU7r14Ct9ctKkjXH9o6AiLAhonJcNxr2VRWCzeEX+OkI3kEcT4+inNykyV84pphoTmZuX5MaLO/GTErKFbVILCWtOd1GTTYaYdZBEoGSnPTxp9/3pIZ584DJZPvY7GbroebgaZkWYDg6iyY8iaSDkwOnzQFDhQYDyORWgSXLgS9vo29Fbd+pMHf0U1GEUoekT6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(5660300002)(8936002)(41300700001)(86362001)(66476007)(66946007)(66556008)(316002)(6916009)(2906002)(4326008)(8676002)(478600001)(38350700002)(38100700002)(52116002)(6486002)(6666004)(2616005)(6512007)(1076003)(186003)(26005)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49qaa92BriUI1/RkhBdXCIOSmBhkO3D8yec5SOy5h0niwKmx7c9pL6RfZZUU?=
 =?us-ascii?Q?oQg4kyUkm2L+4t0ebDToccEwaKRY+EyvobfRhwr9WKgjptHMCVnWB0bp9ZYq?=
 =?us-ascii?Q?ig+H2YthJAD4jGkiw4uzDATuwSXwjc6Vvd5vzJ2zE4zdMrlmSlj8ja1JDGlv?=
 =?us-ascii?Q?NyKMiLnH8SbxpWvzstMsrWxEbuGE0558BWIi0Ks64PbVqNeihf4Juwy1J5DS?=
 =?us-ascii?Q?i3O5SAxhAUryB1HiQCow1naffoId5p+fxbSiLgWJycW7Y9p/lSiYtmReijTO?=
 =?us-ascii?Q?vmH31cvgWUysYnEG1phulKwz19xfFKB9TjpE99o1eAGjp0M5qAKdLhsJynmg?=
 =?us-ascii?Q?jIVCO+uJnc57ypuHMkGiUvPpoiWZd3KAPHYmlMzb0vdXfWXFyv4xMCyylGXm?=
 =?us-ascii?Q?AeG+5iMxKbq04QZpBy+gfa/NygBQeYyWe7aj59wyaWUc0KdkIEicsPwHQENt?=
 =?us-ascii?Q?Kpq88f2LggzQlDZ/WBXaBznnkLPLSh96bCyxkCXD6YPV4Q/Y80lMi7wHZHvP?=
 =?us-ascii?Q?fP5C6YMNrVZDv4azBZUdolG+EXecmZm/Xkn2LNVuXzQwmsAhxUOmbDkUicxb?=
 =?us-ascii?Q?SDIIzzE/Ne4apVeCYEZ1uaDq6ag5Vd+auqs4IXu2DLccY8fdQejWd8b603v9?=
 =?us-ascii?Q?r4Pv7X1EgtM7PpHpjq8220WVakppmlD46ZnAWqvK7U/YFEBVBwZoM+yEinwX?=
 =?us-ascii?Q?5Bt48/hGJCKOg8EUL7dcXsVlRiT9vmiQPzNoTekghSp9xmaqCkztChMP9yhR?=
 =?us-ascii?Q?Cafga+0As0/SkJCEqvsCP44DAwEjJDg4tlT75xRa6LxzicmLf+qQlv04/FkH?=
 =?us-ascii?Q?FLrgh47Ifp65QYTdr32e9BXmoLCMaluYJyd1zh8hyLCDy84PlRi++297r7kW?=
 =?us-ascii?Q?2nP8H6lzf9T2Jeag04AW33hLSBwFhw+jaoD3DvEESL3HXzyIBYH1xVqn/qZw?=
 =?us-ascii?Q?5zgvUyNeDZx0NloILbt/FvD6QWknnG2YhmasjTboWXkAEWPKflmsEe8cq2/y?=
 =?us-ascii?Q?GzoQr433zSgykb6fS833x6JqmMIEYlPgo47yVe7dEN2JXUWwD+fR824xxSn+?=
 =?us-ascii?Q?Q9k4y7S8v/2LtoTmTTJs7Lbpi3UAnjqaNhuPFFGaqAxOKo378NG4i1OFZruj?=
 =?us-ascii?Q?8YsH+iUh2W38mKFS2GECO2qZaXeaBJcA1xIVAvhdQedo9EAOPG1/UATumIfY?=
 =?us-ascii?Q?wxy14OOSM/rFT/cydvRg0hIvQVR1zqb0PmzOlYsyhMCWZ9JvNIj5cHaajN4k?=
 =?us-ascii?Q?mB928lhDIshHJtrnMMUizqgmI895pzCZkFn/DbzcsJhM1JpI65h2pmysI4Ze?=
 =?us-ascii?Q?8RDGss3pIrFon6vx+sqU18Zy7kHNlB7kEj8y37b8aZPjXUtriBAQ+3rylNpe?=
 =?us-ascii?Q?3RZiDQnPULGV9egkqh9wzwCRKabR1oo1dbXK7TB6vWryZwak3jbtVOZvmHFJ?=
 =?us-ascii?Q?4vRhBT3hISA01511Ng61ojMu0UZaVrfWPUmb83syqEWk81RzLN7y7uHXhKD3?=
 =?us-ascii?Q?AK5rWKeVgnWvcK6IeKZ9tBMrkDfyGGTXxsWgUrEpCIZx7gDcUWtI+dxwjC2F?=
 =?us-ascii?Q?ES6o2+EiLxmPBnl0zMlqf6038JpIGgZwQXEoec99?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c559b5-64ee-4032-c156-08db514f6528
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 12:09:24.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAPrTWlW7TF/is7uRynMLlTf1Oaa8rEWtCj8R9sIk1ihzDBFzNrxD7K6rKHS9A2Uv2SGDUnvZ90zW0Ju5QpOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7234
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

