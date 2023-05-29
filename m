Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB73C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjE2G1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjE2G1c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:27:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9560B1A8
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCbFdQNtp/yo1Q2pXaRZnfunUYSral0wTVzN1CNzLqeBolnYWqcmXDNhXbbL+gQV5h/GOuSi3Zx3hHN9Fu6A9jYwq8ZhwyF6jn+NFx88zHPYf6RY0K46lSnoCEHp1B89WjEWujmDWr23J0N0kHiLHo4HauMMCPd/T9j0LPgKczzMe9TLrR74Gg80DLnGVtXB0sDR2XwtLMcIdTdIbkUzh/4UFuyYnDoG2fDmGtNr5jJUYgNO2ACAG7z4//jwXn711mN+DrrnspVOi3/ct3epJySdQYXanuL3dKJ4/x3fl/1pIqBPOlid4broIB7esjTNscPtrrcjlxQb+WaVzQylVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcfjgqjZn9su+QzBZMzKjmsLKUdnnk7Lz9bnAdq0BME=;
 b=cMLZkLi7lRWYkPmRK/9EKWt7EkvGZ9ePmlEjyz4FyXvHdpqzsP8C8hsVL1yfhLD10gowNkP0MmXOjqyj7x+YkOEF+3bSLReTD6fvR15scVVjWAhZNGm9Qwo0EP1T2leXUS4qFf62FOcn8Z1zj8aguKUv77/DBdgU3Yw9+kxJJKteHigPjHgOBnLkE/0AJMCcc7SQokryg51kxFN3VvOlKY+wd2qn50it3zxfS5c77f3/A2+vB3XBHI+/r9+ZTZuxjDLmOvtTbxlDZmq+vtr1TczoFZpHltj7TwZcCGl7HOAawaqMgJtSri98cI2AQJdXwY9IVT1m9nso7yv7SrKbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcfjgqjZn9su+QzBZMzKjmsLKUdnnk7Lz9bnAdq0BME=;
 b=NcMMq9M/Lsy5dWt+KQEbW2HO7rYjfWSJxFlQoxNv1lyluAy6l137TqMey8rULiM8V6BuPmRhnx/8H+1fI/rRbrH8euHDaoD1sNYCPgDpmbrT3gjN576DLERn5evhgAdV/YOS4QFjbOKMWhrch1gc+9sadrBRxLxKjEEm5486pdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:25:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:25:15 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] btdev: Support multiple BIS
Date:   Mon, 29 May 2023 09:24:57 +0300
Message-Id: <20230529062458.3632-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
References: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: f22b87dc-de83-47a9-6a3f-08db600d7727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dK1o7lk3gz3Zi4A8cQQsgO2mPKVDK2PYgvW7ClUk/LmJqx8O4nhZll7OgEbLwA89gvTCXHPeyTWeDa4t4fYlq/+KfWJe8gbPLVd9iaaKFbiC+hDaaKpat1Ois9qXpbwwlDI6x6fmyxGESFpHLiDTyaM3StKobjDXnIcfJTAc/5yTzWoLpL9T6tvkRF2QAirzkoLm5uj3tU6LSeYYdpBZqNFbdb/sQr8rQWKtAjEw6j5/RVPIJ4JqGguhmzEP6QlW2q3zXAP5p9mAQUobhgQQjqASkEqFCKIb4gT3iSEV4YtZd96B6sFOrLsCufAiRsKCOKLMxZbRCPQDNGEc4RcrpPsaZKOjjE19zFr2NEj9eoFSv2/BrmzI08eLYo4lejO8cqWVeebzCKTTx/zOgpEu/ejAxzpxc41cZ85/ekk1yy/YKADs0OKKZQI1amGgh2HZvdrCDQZ3MzC3RuMb+WxZHFtNdE5Ih/LcCTFlIzCckVA7Dec/Eiw0v4jQjhfqUcoRbsoms1e++zbCzWalF9WNxlFLh784X3K8kxVBs+2bsHzulFzXH6OwQZJ1FfL2b7K+KBHtkLldUtVLE82ll+m8eRdLHGZKqzsTuqLoPW2TiXBEvDjIsH4Z6OS82LaS2hWL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(6506007)(6512007)(186003)(44832011)(2906002)(2616005)(26005)(478600001)(1076003)(83380400001)(52116002)(86362001)(8936002)(8676002)(6486002)(38100700002)(38350700002)(41300700001)(5660300002)(36756003)(66476007)(6666004)(316002)(66946007)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpFyMgU21ag5g4t4mXWepRXHXMvTxcHcpkhZxKHXsZraGZdTd/V0po1GGerq?=
 =?us-ascii?Q?qC7st6EHynxyGjW/T/pyJTo2OrVTA2tKmv+nGhbe8kYLsIs4BtxA9Ru+2x7O?=
 =?us-ascii?Q?IGZ6Jij4Zz+BAnaK4/jSqyX6i32aXJ7sJZvmPassuamX12s8RbZK7CV3BFzf?=
 =?us-ascii?Q?jFeMTXl73MdFMX0QEj322m8lq/6/bHXEJ+1m0ccYnqc3XYIyp6U6GixYwNqO?=
 =?us-ascii?Q?Nh5boBHz2PX+XsiBMC+RX7v+sRcpiHDcl3fooyfOFH6ufgsOIAUUrcSMB31m?=
 =?us-ascii?Q?PEVjvsaWSQ5rN8e6HN77AcmIoAjWDvEN1B34sLh80HlImCue/LD78Sv1Sitt?=
 =?us-ascii?Q?QJPV8utaiBXPY92VFvAcziY+IbCSwbil39GMqaf9XtU/j5fZOdUaw7VlHSv+?=
 =?us-ascii?Q?sAG0Sc3REqb97UV8hq9Lh+Iw0xpvi8cuTlUOcskb0KC9BCN5AmB8jHwFZCf9?=
 =?us-ascii?Q?yPB54z2PjKrmYIYwgq+63K4ZRM44khH40JklmAuOnMHNpOvuQbQ1zTlimSzy?=
 =?us-ascii?Q?PtC9P5H1fjBp37UPsBs5CEbyH4VYRUhndhoG/uG2y3Zof7P2eCSqQLhNx6OU?=
 =?us-ascii?Q?3RHBRmW/HUskt1AGq6UQwSUjSPI97ncUYI+QWJkrSpwR63CBO3FItMe7yDdy?=
 =?us-ascii?Q?zyI2DXD/JJJ2tLBFIwJLQexuzVdPakvEe6tfqi7bGCY6Llrkz2nDPEE8ZeRx?=
 =?us-ascii?Q?OKv2F/4ZYoQEvxh/20gv/sruEuhEytiEmJdP0EpDm+y+ok7f44BtdcTaCo1a?=
 =?us-ascii?Q?LsVDjoiHQi5shMXsf3RBXGVUMDXVE4DfZ4gHHJTPo+iszz4ucUAQujvOuWBd?=
 =?us-ascii?Q?gyEby7mBXT4ENkfTkEj1F+AOiAJr7nKYIZfHV/GICQ8RE2JiC1NKSNPjrfCz?=
 =?us-ascii?Q?nupo3OayFSww118X6FDFWjVjBwDZdDRFSx0ejmRKKy8k1OYlvo3KhUbB+ZDq?=
 =?us-ascii?Q?1uVufhKCja+MMV493Meu+V3U0BGvU3vMzVxQW/nVNhS5V7H5meU2fiROg+vo?=
 =?us-ascii?Q?2C0ljN2FUVQ+yuA7qnXeMBKj1XHfdApQXFZcfjQLjAQibWNqugtFYbp75GgV?=
 =?us-ascii?Q?zqLji6rMhXVOmbcOPQhzA5OQQmP5PxfdIaiWzWXZyz7KU8wXFmt+Q57JK+sU?=
 =?us-ascii?Q?QxbyFa4qQnXOapQVQFXbbKEBudeoZrYIiKsKKwWAdwuAXTo2LeLXnYybAbdS?=
 =?us-ascii?Q?JlvV8mOWGL5ilBmZrHRNHcxPVJs1Gf7KkQX+YN2Xl6PaAujMGKzSywhuXkWU?=
 =?us-ascii?Q?mz/IpGqaWbHUwWpemdImsXtPwcryd0v69P25VVXQ5bZU10eUZabsdp4U2xYs?=
 =?us-ascii?Q?CCgBLtXsF1oMc4XrDMddvau7pLEDathKDtli5YP1Avwdrx+UBXNlTuQKe7qt?=
 =?us-ascii?Q?+7z9yslCQQzhab9T7JttaBN/+gfQuZ2rlEN+PcK0gRL6E00ChNBFcVZvNK7X?=
 =?us-ascii?Q?9S004cd0fMn6M+EgHJPLPdA+DTQL++BPpQc4Elw3xdYYggrgtA23lIgka8M6?=
 =?us-ascii?Q?F9RCQkzjU0PN8YZ+omKGXYTbKBu+z1SPvxqTvXCjWPNLEiCcfCb1rriyD/3L?=
 =?us-ascii?Q?zFEDhaZtiyYpBjXrUXNlmQ79q2HQLsUxroLsPX1Hv8bZE4ejn+Ogqn8nUGPv?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22b87dc-de83-47a9-6a3f-08db600d7727
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:25:15.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNIBckFdhptrd4ZkywPmHsHxKg7ZI9OHPekozbCks8eh/ptgecbOPqYtbQWf/z+X1Whgp1Z7SuF3m8QDhmMAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for creating a BIG with multiple BISes.

---
 emulator/btdev.c | 52 ++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f9260511a..2e15d5af2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6101,35 +6101,49 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 	const struct bt_hci_cmd_le_create_big *cmd = data;
 	const struct bt_hci_bis *bis = &cmd->bis;
 	int i;
+	struct bt_hci_evt_le_big_complete evt;
+	uint16_t *bis_handle;
+	uint8_t *pdu;
+	uint8_t pdu_len;
+
+	pdu_len = sizeof(evt) + cmd->num_bis * sizeof(*bis_handle);
+
+	pdu = malloc(pdu_len);
+	if (!pdu)
+		return -ENOMEM;
+
+	bis_handle = (uint16_t *)(pdu + sizeof(evt));
+
+	memset(&evt, 0, sizeof(evt));
 
 	for (i = 0; i < cmd->num_bis; i++) {
 		struct btdev_conn *conn;
-		struct {
-			struct bt_hci_evt_le_big_complete evt;
-			uint16_t handle;
-		} pdu;
-
-		memset(&pdu, 0, sizeof(pdu));
 
-		conn = conn_add_bis(dev, ISO_HANDLE, bis);
+		conn = conn_add_bis(dev, ISO_HANDLE + i, bis);
 		if (!conn) {
-			pdu.evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+			evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 			goto done;
 		}
 
-		pdu.evt.handle = cmd->handle;
-		pdu.evt.num_bis++;
-		pdu.evt.phy = bis->phy;
-		pdu.evt.max_pdu = bis->sdu;
-		memcpy(pdu.evt.sync_delay, bis->sdu_interval, 3);
-		memcpy(pdu.evt.latency, bis->sdu_interval, 3);
-		pdu.evt.interval = bis->latency / 1.25;
-		pdu.handle = cpu_to_le16(conn->handle);
+		*bis_handle = cpu_to_le16(conn->handle);
+		bis_handle++;
+	}
+
+	evt.handle = cmd->handle;
+	evt.phy = bis->phy;
+	evt.max_pdu = bis->sdu;
+	memcpy(evt.sync_delay, bis->sdu_interval, 3);
+	memcpy(evt.latency, bis->sdu_interval, 3);
+	evt.interval = bis->latency / 1.25;
+	evt.num_bis = cmd->num_bis;
 
 done:
-		le_meta_event(dev, BT_HCI_EVT_LE_BIG_COMPLETE, &pdu,
-					sizeof(pdu));
-	}
+	memcpy(pdu, &evt, sizeof(evt));
+
+	le_meta_event(dev, BT_HCI_EVT_LE_BIG_COMPLETE, pdu,
+						pdu_len);
+
+	free(pdu);
 
 	return 0;
 }
-- 
2.34.1

