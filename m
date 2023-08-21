Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F4EE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjHUMEb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHUMEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB8A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK5EZg7JlKpKGgceZlked9mlNCTB9I3oNNFdkfRQcTaVkKQdZaDOQQw1Khg/WYV+uIka1zpQ3xmjwde7fqclVEE9tsTNAWnlmG+jy48SpUVx00LAwO8gCU85OxJlIbWM+e/JSq8m22qB97Mak6BTrf64jwXSbJHmKrDudSqD25SpBcjPeMu+57AZ71+DagMpSbIzEkPr9YNuaDu6NV6PCLTKj6vQ2+M7J8TdvDZ5HPUcUf7zTNd+eoMdaarGeBN++snFyDo/s/2Uj4KkWzeQVrl5ZxKEUnkm39EhwywDKpDAAvYJ5DrGs+xEUjoyrR0SSnU7VWXLkKg+gAL+4CRWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riJ25iSpKLm/XRPFQ6VFdu2HomWcAcjG5c2kQP/vuoc=;
 b=VTsv+aYCxIgLqwLzq8vjDxR1hbAbqrTiq9DmS96GwefCWNA7K0/3Yo8lMf4zTwAKx7NgIp7Jeh95iYAHAVatJ037GLMKGQcWDOyvQnJei+EGg0YLjuxzsAEm+Ik/zeR1KmTr8rysaw+7nRxDD5EkJCLusZSf4bKDgHExfcLrRDq5v9pPjV5gA/LUjA+QdlQD8GD8EUgKeVb0Lrck0uEXQHxNX85PdwrFSkKGX7xl+ZKFN3L9MqbXa43jhcJGm1MOKo9YDoFR4DlPyQwh1DWEpABkiLl2/yIXSh/FnkbhDa9igwMNzNdd9953u7CATNYbnjGjG4YoHpuRmxtxEj2EXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riJ25iSpKLm/XRPFQ6VFdu2HomWcAcjG5c2kQP/vuoc=;
 b=mJj5ODUbVUPAKmT3GdqPWaVMEERjZThYA4u9lUezqFabezEG+syy+45k2EAwS1hacIONgvSEb5ahs9CpTlCLEvP3wQ3AbkjZ2pAAONbNeviC3+lYFcQNbhhn6njtgJoU9ezpb7A/D7h90mhD8N0+x9VFmG1VpuxFM1vxvWwlf6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9586.eurprd04.prod.outlook.com (2603:10a6:10:31e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 12:04:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:04:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/4] lib/mgmt: Add mgmt event for BIGInfo report
Date:   Mon, 21 Aug 2023 15:03:50 +0300
Message-Id: <20230821120353.28711-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
References: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e19deb-1668-4950-dc0c-08dba23ec4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q7dBhSuN0yqDXJICFZo1KeZvJZpefGcAoqwDCMLBH/6yF3oAA7H5UqGe1X/La8HQ5aNlAh04Nk8RoP9Apt7mtrTqEFuSWxPTkDoT+LQug2uAqUcYiLgDy/qQHoPkpwnruoXFk6Qv74qzCh7107k/elTBNy+WCLVYJhXHW9fkOhWjxcdoFvHvms+9SG5Wk3h47UPi5uUbg05mRVuY6Rh6SwBk3qWEHJKeBJO8JI2hcab5uRYkz5IW94MR5am5XkFf4FazEMONL0RZ4HfiUhpcScTT3+cK5GAl8qOuu/Ca7mckLcgdmxb3ypCVLw+np1r6X9WhXX84BYPHG467TVFidm33ZvrNnKjCwrUTLv2ps92Cj8eCqJRv1v6Fl6NlBDyi/AjI9CC1yahZ0nnYAwoU71hjyg7493XUmQHlJUbWueyWqvwh407ZCU7a4Cn/pNKIa7Dh4WyyPy3Ecl6brW6AosdsNBHmmmtw8LOAv8Mu4kURxyB/qyiroMgfzVBVQmvlF36oA4c67E+RRwGhM4wWhdd1FC5NCloYNC67RMmppduN+ivAe9MSmZY6lVTggjdTX/cuyd2xxwwP8L9ME2yaqtZW6GfmBKclwSaPEEHgBJHPQui0HpECi4972Mn7VxD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(478600001)(1076003)(6666004)(55236004)(6486002)(6506007)(26005)(52116002)(6512007)(2616005)(4326008)(44832011)(8936002)(5660300002)(8676002)(2906002)(4744005)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNItyfcnnEe91nA747kXJyCz4jydUd+LIBFq4qDb59KPAd9DhGfWH1cVcCPk?=
 =?us-ascii?Q?NKtWqVTBTxPy2esUk+8mYEyzfdkTntRTaXiTPISBNlnY9FEctUFc+ngSUGSg?=
 =?us-ascii?Q?IMWGJnrTTBdNjgrPNmX1TWRNKXQa3NQfJ6NwNw56qXAk8xslEJD7peeqIzeH?=
 =?us-ascii?Q?l1JZJionK6o31eoVdHqxmoUpk6qd7UmJeSKcDiIQqi6AspBUemzXy0ZCb6hL?=
 =?us-ascii?Q?qbMsqkY18YNbfnIxEHQQbJ+8kkUdjcx8GxsKvpb8UK9S7QuL84lA1rJUR9sJ?=
 =?us-ascii?Q?QWquvAeWFOG5dwusSWjx4hJqNHCGXfi3XWRdWPNDe4GNcGO4fcaQxIQjMseG?=
 =?us-ascii?Q?yPS3JfIA4ryNfbwUAz+PqMvQiLEYGMcHAESkElFQ+r1l0c2BBK2FEm66Uj5J?=
 =?us-ascii?Q?CwBdG3haSy6byBLlaMGCD8izBMzyf6ZCWASKURFM3Ox3RZbIOtRPvBatwMpl?=
 =?us-ascii?Q?RpSbKO/kk5zl3hL624h4MExa1bfyOdeUM1ru/E5rORuZhk2h/fUOaT/Tnkpi?=
 =?us-ascii?Q?UPvDinEPiI4My4YempygDZkcAx3RcmFOWXC/NEkamHseph6YBXf0Zpiw6Gp6?=
 =?us-ascii?Q?+wJQP4u2t8IIpf5Jaez0S6pSt8aFXp5UW1fydVpudshH92WF6lKe6pkAt6yb?=
 =?us-ascii?Q?s82QobU62i1lqkoC2gN3sCp8ca0bnZcb1dqv17sIMDkfrt7255jsLdRwSAe1?=
 =?us-ascii?Q?7FCfRJ5ShBfqfpwekkjm8gQNYTmJyidZSiPgHEflQiFNb54+fghVShFnazu+?=
 =?us-ascii?Q?xcoKUGKsNeLj7c9CPrfvnxCo0SE2yxDek+CfjcOXA+3gVhIV6ITidfgdCb9i?=
 =?us-ascii?Q?QR38vJO5XMi2a+a/NckxEVNThGSNbFyPUUeS5IdBJofq5OacHdE/mQUcQ6uz?=
 =?us-ascii?Q?g0WYeIb6YidG5CUAFOOinVTKr0b4VkiKOwBZ5Z/zatiB7Y90UVVVrM6qFh0U?=
 =?us-ascii?Q?rDK2/ss4Pcys+VWa+wlKrp8MelljdduaGm6dchgTtO1PdArhXXYd5wgUoIWL?=
 =?us-ascii?Q?3doXw0KbOciBJjUKOx7RiP7LeZDFp/8uHBGucjW1t847K32R9uLafOoK7NcL?=
 =?us-ascii?Q?j5kOZlJprBpc58HQ/2pN9AVExI1eq42MmiSTz8xhVMIOQhP5psauibrqjeZg?=
 =?us-ascii?Q?kEL5hC+nShxorXgi+C1ftuojEk2tDWWL0JjycPig90IMXa4kVZhwnaMeg2mH?=
 =?us-ascii?Q?i7u4AU6zd0AXl4hRZ3k4xMTjKTkZj4V65eQkqxdhhk+IxFmajMMyNDcDG0QO?=
 =?us-ascii?Q?UbP7Hfp++XhRxmN4tbvmiSCBzyLEZ17KF064iFuy+zEFKwW5TWkUXNwXnWLE?=
 =?us-ascii?Q?AAKn10i52T7m2PNPltY4xkJ0kIlN556H+zcIdsgU2Dd5q0lbC0cBLwCTzugV?=
 =?us-ascii?Q?AlK0KoyewLaCyx1x85uLzmMvHk9vZF8bpn0QhYDqc7HI8NhoVwgc5OhVL81r?=
 =?us-ascii?Q?/Rmg8rCGEcdiYPb7TIWphJdX38rJYcOtxMz+v/0xCANZ6Dn0qT1Pl7xcx5io?=
 =?us-ascii?Q?VdNoaTHhUsMLHbPVndBEMmZCwTZxODFKlVm+/6IhMzlX3cK8h/G6lch2EjiO?=
 =?us-ascii?Q?hADjxAomAj64meHjV+0ZBTBS68fJ6TVWFcE3NxXfNx8SYwk8tK2xd+KkTyZz?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e19deb-1668-4950-dc0c-08dba23ec4ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:04:27.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sig0IQn//GLEOCaCpFX8yzLkyoDu5h1v/aZbeGbJCc1rHQ3bCdaoLwudQL3cWyFmo4DGjcEFp6O/tZOQUctOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9586
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the MGMT_EV_LE_BIG_INFO_ADV_REPORT event.

---
 lib/mgmt.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 8f92b7731..f075d435c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2010  Nokia Corporation
  *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -1092,6 +1093,23 @@ struct mgmt_ev_mesh_pkt_cmplt {
 	uint8_t	handle;
 } __packed;
 
+#define MGMT_EV_LE_BIG_INFO_ADV_REPORT	0x0033
+struct mgmt_ev_le_big_info_adv_report {
+	uint16_t sync_handle;
+	uint8_t num_bis;
+	uint8_t nse;
+	uint16_t iso_interval;
+	uint8_t bn;
+	uint8_t pto;
+	uint8_t irc;
+	uint16_t max_pdu;
+	uint8_t sdu_interval[3];
+	uint16_t max_sdu;
+	uint8_t phy;
+	uint8_t framing;
+	uint8_t encryption;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
-- 
2.34.1

