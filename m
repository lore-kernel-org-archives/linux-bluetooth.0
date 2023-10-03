Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F357E7AD57
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbjJCOtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJCOts (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:49:48 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE79A1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv/lvHFxV5RHNqxvUdmMxebojKiGmwaXAoSlqRX3EgSgQh6PeKHHhL9nIr68iR3crmofw0Hk2OkCz2DR55o+CThsYcDBAM3VF3JHcClOuRFy+fWtI0311vEE4OxPNsIkoWUMrCyQDmpqYAjw3E4aXdZkxulMr4Z0Gv5z9hcbwG9CMBZAsgdKF4CeQjKlKPDzaYaqa/gS6YUi2dSjokIgfdw9Z1byV0MLeCu3HQ3RKIWc++4+ZzqjMRVKnDde+WzZ6Fvc07sv7UjOwAWdo0gqkMOFXqkiyna8irR6AfRyYtEHUsGr4ULFjfQ0QBrbVoW3ZfIj/jfK29GVNTr15lD3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECixQjPHC4ynBDHtIMoaTAv8GT8FLGlxCR2n/lPgoec=;
 b=ZnSKZpcMugYPQ2JxB6vXZZuTVxfN/qAonfAuUL2mjI6p+3ZaFGWx+f4iEEbvExWaonFoRCkXdRsmQrbA/5XJF84m67qbFtdpRdYSNfrmLr3GyVWR/6vSlfZbi65QPkWdhjVNOi4LwdI1S84kpZJTQX9cjPRhd3S2Urq5k/VyPGk/cZZ0SmLRdpFzZtMwauzMAX5anli+kAtxVHuNSPeOKpjGZ72y6PvYnP6yqw/fo5r3F+Sx16nWK+0CGlyok3wCSLZTsdkBul51wvClavh7N1QYluL5hbggW8lW4Hyc0rSie6XeIGaLlBbChMk+XjRFqUeH6sTrbURDFLMBOD05IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECixQjPHC4ynBDHtIMoaTAv8GT8FLGlxCR2n/lPgoec=;
 b=dl5CvkSeWLUbvpOIh1I/YvZ0JRUizOzE5/8YzbCF2qZMwZmyNXS/uWUN5zVZBRHp66kStZyES9PWRRlKc308Tqft6OVrTJnMn825N1slSs3Qo5bOoRKLNoDbg3MyV1JxkGbAv5lIkFsnjMgB32AQdVBPKKG9sJcQ+VtzVmt7/1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 14:49:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:49:43 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Allow binding a bcast listener to 0 bises
Date:   Tue,  3 Oct 2023 17:49:33 +0300
Message-Id: <20231003144933.3462-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003144933.3462-1-iulia.tanasescu@nxp.com>
References: <20231003144933.3462-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0298.eurprd07.prod.outlook.com
 (2603:10a6:800:130::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: f7252661-984e-4239-591b-08dbc41ffab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF5XYU5WRI3JxgUMba8aoK8/ZC54IPWSbNTPKlGiUf2opQ4yYXIe9UXAjnZthf6gk1ItIYrDPSRs3l1aZF0bG15Cxhx8PkyJ1+7dt5gPhaXO594gMIlB1p+mvFB2aKHqbkIFjzGS005/5sh0tFd3XliNSdNSIKOSEovWV1AO1DVtmUpVjXZOwk6tuKoFX3h/pwH0Wwbuijx4JoxE8m0tNoZPKDd+toDSz8JRdUxM6UDtKhgmnthpZ5hmrUzQUHL9VqkZoDiEW8gwYi7GB/LpaIFbIpegCrSk9CALrmfRGCJCaUI7iilYTOrO+xPzJEKLlJvmGRG4ij7xlh2zkyIWdcMbYmicCCYwJHn0FfDSf4UOsYVCr90eMOwq+VVWUnuMgoc0pkzLXpKYPdGUjHPOSDdRzhkT4pxUuJ1UGex45pIktKOMUI1q0RPlCuiaM/gzF696JMjWfKaVc4m3qHH95CYGdI5ta4mePmqQUrCkCXzejiUdgr0K5zNbgBhvfO8vCQj492bkwkXrFztL02i0WaaBw1OiTlA0HP5SM0VCKVtECNn/PA5HAkY0wyORDeUbXFk1OFUhukziG1PTipE4WUNm6VH9cp7ossu4wUAIhGB2jcjP3f8F5r8/TQOvD1aA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66946007)(66556008)(66476007)(41300700001)(6916009)(316002)(478600001)(38100700002)(6486002)(2906002)(8676002)(86362001)(4326008)(5660300002)(8936002)(44832011)(36756003)(83380400001)(6512007)(6506007)(6666004)(2616005)(26005)(1076003)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0Y2ppBT0NY+t+H93jmHqV9vGYgqx7IxPvsFdw1zYX2t7594jEgKqQ+A6iY9?=
 =?us-ascii?Q?a9WEv6SkikuHDLJMzTFJaadQh3t8GZA3vhW4fXYU4LedEYcoToTPc8IyI+i0?=
 =?us-ascii?Q?luyUySBqC5q7SnYDxd5tWymrjI5NA50LDJ2MrbcjSfNT50hRBxyTi5LpBf7R?=
 =?us-ascii?Q?Ty0MHV1p3egdIr8g1YEOlCDlYWU3JvwA9pP6gHDfHdtCZn/ycWXQuDi2X8R7?=
 =?us-ascii?Q?D8Fq1QZXbGlD2WIkXdvhBF9lTbntDe6FuRgW3Z3EASqiw3Dr6bUqKeVuKZ8O?=
 =?us-ascii?Q?XBCXwZhyZi0Gn/DFb3UZ31vJ9VqFRJayoJUNi/bnstWLWRH5wbKt7F0weGXx?=
 =?us-ascii?Q?m52bJouob/z9t8tDZcDObPn+SgZZOGZ9WBmgNgbmkIK5W7/cZlxBkK8MVgb9?=
 =?us-ascii?Q?wKWJwqfaU9SnogYpRhF2eLGVIw9us+knFraiZeJP1a8f7+00z5NcDNJn/dlK?=
 =?us-ascii?Q?Q8lQfDaVz1/4OGzim4yGV6v6YEw2Su/9YwydepAF+I8mAOzoMsVPyWZXLJBN?=
 =?us-ascii?Q?ksSSCP+PlC2UrC9y1glE7Mn05IV2ML/pD2Ybz2rfWewECu1N+O/szaj1nGa3?=
 =?us-ascii?Q?oqreO+n8YCQ4WFV0m0Oa13TRd5In7PRKJBKOwVj8VwksfnzjvAYe1l7MYZqn?=
 =?us-ascii?Q?FPfINHcrLii2hBrg/YbmPErHxd/von+gdLUc23LcQt6NtHaOGnGAL43I3kBU?=
 =?us-ascii?Q?AVCaYhkGzMlsi6+KCM6BGHhxej5vRDq8F11zl5WiSvk+UNMoCXcNcYWfX2hT?=
 =?us-ascii?Q?HNRse+foDghOcmMQXTIurs4ADzfF69vfn1ceFc/zTZUoioFtNoVGHsY4Dwem?=
 =?us-ascii?Q?Gsoi010yVJv0xS2Uf+/oioliKEV5EKhtGiWR1T0hehxWvWCuYFHyn3Y72tuz?=
 =?us-ascii?Q?rm7Ye1V4i3PF9vk2bA757vh8ZRPA1yOjmbIfSjhez2400e3SsceWSaRhN3D9?=
 =?us-ascii?Q?hzruqrX1+YmqqUKVKpLBh7v2QKrPvIrzkPP9137GtwhVbKHDwUvArA8JurzH?=
 =?us-ascii?Q?J7SzqTNEF/abTbUjeI6Ju+a8qt9w2DQNV0M1LwV8iCG6vXUSzqbEZ0kHREfH?=
 =?us-ascii?Q?iOIbrFWt64C0uL0cT9VF7eBxKswiIL9HZlz/8RA/ama4lr6/vpOcvsVuv9Vw?=
 =?us-ascii?Q?YIancqpKu0ZEg+1usUVeCUCs6qS6HHrUb+TJUZ3+pog5ucN/nkSgsMylC2d4?=
 =?us-ascii?Q?h/zwE8n+r22PTv7QGI3HOIH/H5jGuh7oQHCnsmpSfro1lwaDGTIr8L1LgThm?=
 =?us-ascii?Q?okVFDi8v0yBpdBdUUzZQOTNYBib/bN08okhGgryVgvxIB4HWGqsgbowjfwVk?=
 =?us-ascii?Q?vRrPmZEbO7R37pYw+9SbdBuQLPQ/FbqbI6o+FF5exQZgTGFnw+n0VXK/23tA?=
 =?us-ascii?Q?A31PshlUj3yLwRa4jZ+ttNO2Rb7QxSHgG802pVyBsyYyCE+CEcid/UEtKin6?=
 =?us-ascii?Q?MowT5d5WiZnZXb7ezZFosRbggcIqvrF16ioSaUB9Db9vH8oqGOKNTN0GzDQT?=
 =?us-ascii?Q?HMbgb9Mz9heWasIb0xNoB8Bfs4BrvtwhnK8qhzcSuKDmc0SLYAPO1p6FXqGn?=
 =?us-ascii?Q?PahCfRaX5mxV7d7JfC4TkHOXWnLTvNfKGyX2mvkEhbEyAYzrtAnTpqp1nD9f?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7252661-984e-4239-591b-08dbc41ffab5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:49:43.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn3ut3JEokKBzxVYkZORce7x6mQh5KSUCAZbtjefBReafGa4usr44dSqnzWy2hArVlL1HT7jSnw6S74CaJsCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This makes it possible to bind a broadcast listener to a broadcaster
address without asking for any BIS indexes to sync with.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 net/bluetooth/iso.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e62a5f368a51..c4395d34da70 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2138,7 +2138,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 	} pdu;
 	int err;
 
-	if (num_bis > sizeof(pdu.bis))
+	if (num_bis < 0x01 || num_bis > sizeof(pdu.bis))
 		return -EINVAL;
 
 	err = qos_set_big(hdev, qos);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2132a16be93c..8ab7ea5ebedf 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -790,8 +790,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 	BT_DBG("sk %p bc_sid %u bc_num_bis %u", sk, sa->iso_bc->bc_sid,
 	       sa->iso_bc->bc_num_bis);
 
-	if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc) ||
-	    sa->iso_bc->bc_num_bis < 0x01 || sa->iso_bc->bc_num_bis > 0x1f)
+	if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc))
 		return -EINVAL;
 
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr);
-- 
2.39.2

