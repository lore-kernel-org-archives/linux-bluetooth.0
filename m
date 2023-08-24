Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDCCC7113B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjHXKYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHXKYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:24:31 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD501739
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKcjQEiInaW1NWgSo2nu/7LL4TFlZHMwpvov3XU7Hsh5qG0LytdbkfjxUZbJ5o/9FgVjseRTUyWoVCByatZQdJIEwYJPcZghTxJTsfGkMesBBJH6BuP/gBZFwefESUVtNrL5nuo64Mco04cNe/pQk2aegMpRVMIB2zzP/Yz/rtPt9CK6gi+oL8KKj7XJMRRWoT1VvUCaO/FoM/WfNRAMg0L7NWzCAnwzRIErUar4IE7I7LjYmKmWaTzIY21gGUlZB+Hyv2MflqOyRKcl6J8UpnVp2RMpbzcJGNcMxNrM21Kb7Htzxzrlg9EOgCA9ToV2/Pcl4hX2TohETXcCyb9R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riJ25iSpKLm/XRPFQ6VFdu2HomWcAcjG5c2kQP/vuoc=;
 b=K9oXd0CdR2lxbtDfnHSDTdrtMhKRKKLMwhUa829PXcvtCxcj8Lk2vIG0P8xUUhB5rOjmD9Rv6eiLeaDopSw7tRqublUXtTPQK+YszgV5qwK35FuDueQ6gyj3Zi9EqCymyPc0aArHUwZlObpSWeAvSgDRuep/EIcLiVWolbWvscg3alXU1HHgKNCPkS/JBY30gYV8y+KmFsuPb63yJjl2Xg3eUsqhwoFfY1szpEtn3jf1WNa77LpiH65Da2azdw9eIq7PYmJXMOvr/ZcJu4qG6LjyDiT5H6onKH6ivXiXXZs64uU5Xy4+vskrsGllnqPt5meYIlwYQaxFPYjGzu5D6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riJ25iSpKLm/XRPFQ6VFdu2HomWcAcjG5c2kQP/vuoc=;
 b=NLfaWT/zqgGyHycc9dnHl+jUVy1/rJIgutsynGq3uoMg3kpRDiqkd8P4EJvd0HIyCVRpkMNxAf260rp8q0u0aHFU0MSihtV1L52iNoNWyHAiIsznXTnS4aNUmMXPaiuxa8c7BtGA3DakjkrxRv8qUHwdfZXG+ls/8yDUTXPadRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:24:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:24:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/4] lib/mgmt: Add mgmt event for BIGInfo report
Date:   Thu, 24 Aug 2023 13:24:04 +0300
Message-Id: <20230824102407.25883-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
References: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c18889e-f756-407d-60c4-08dba48c4b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heV772/9W9P/jQSo5WxSITs2L0/tQD9S8klQSS+Dp2p9PzdhugGfoCcTIEF/nxNsl/R3WlgeqI792RtjM7ja7a1HCZ3DGHddbiEOjDCnGb0H8lnbYuxRG3Kvf6GsXszbrc8LXkJWXQ8rPvhX2bmW105wLLxuRe6Ae4sdMquV1VsmqpvK+yb5Wg0Dx+A3vlryqW0BkbU+q5y9drTMPL/+s78zlEeiD6ttE86L9JDvQyRjptJW9TEHnJTdf2ZjeGI33EQP4KafPhBDKgv08W+MhEoxNgrGWWhvvELWLp62Munol2NbuFpNEWg8ZmJ7oBBUBFzg0oXGaJ88hsgATb+c2lghvwzGAo9Vr7gotHOZu3ONDNKpSI7mnoUKseW6jdKpm/zhvPlPHxTeibLwqN3aohsk4AKq+PkkMzAZNRoPuzcrREgjZSQI/GPlH6v6QxA3EXBOZCjiHbae6Ij4OeKwnoOUDPhF4B5ZJUxLZF5tZ5Dw+q0yS2jBlFw7cmAA1D7ZQPdSp7fXmlCD6IXp17+ypahmMbwXNjsO4e20YAB6+CzQeHjdQWcgryIMeAFNpSIMB5od69zcfe5+dkUCNEhhXxiSlJZn3vNcshVb7C8HWDwbOke77gHs2hI8eaVkPkSi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(38350700002)(26005)(44832011)(38100700002)(6666004)(41300700001)(52116002)(55236004)(86362001)(6486002)(2906002)(6506007)(6512007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?deVHprFci2mr8R2pTSx8bSgYZ8wcg/gUu5T6jk010xiqS/OdbyLnmNuTFyMq?=
 =?us-ascii?Q?io8T+8TLRoIr/NfUfx1KYREqFxWn9HnLv1Rn/DffEItdC6/Z0gsftNRgh83m?=
 =?us-ascii?Q?S/lNeII3mNOk5dQetqh6AsHcJcHe3zCSUinczDfxG6vWeLrQdhKRLigWANkb?=
 =?us-ascii?Q?TsvTKoCKKx/YhMegR5b2JYxoI++O/oNg0T5Q/hqYDPi8a9jyW2KLsaTo2R9K?=
 =?us-ascii?Q?eiGF0dpm477A3JMcCynpfOzkthpL8qWwyVZf9u4wNWUEIz9of7ACX3UpognY?=
 =?us-ascii?Q?u+sFuu1KcQhKzxtqmiXLTh3ZlB6JAoopcCfiLlvRW/Jq6vJlBuOADmFNbLh1?=
 =?us-ascii?Q?DAQjmn71K74b1PuKDLRRJUFtK9Aph0X9vb0eV4RyEbGsKTFvRbLA4aBzd16r?=
 =?us-ascii?Q?kq+ZyBhVtZHL0gw1s/v8+JDNZFqtpH4UM/tQHtojWssVTvs0JXKQI3/lyl7n?=
 =?us-ascii?Q?iqHsNe+1HcJbD5SiYxF1msceZQ2ZERmPL1kx5ePMrR21ThenBe7VjCH+vYwg?=
 =?us-ascii?Q?6skS1VOG8phZMb2Sfq+287SCR4G6FgSn4xzPR1dhSWUIWE1KinGg0b92op4H?=
 =?us-ascii?Q?dIEXB1jAUFTO5vKUm7ObiGJGs1Tik8yuYE69UGTRnD1WR5Mb1VUpMYSCvEJu?=
 =?us-ascii?Q?hBEgfVx/QxF6TRJedePoWMQ6wC4JrH2oU6KWJrDlYO0Q316X8ESlZU+qmqgR?=
 =?us-ascii?Q?N2APJPJiY54ljmCdJ/nxNo83A24kH1BHJUwqpqS6pyblSHwna223sdKsVHtd?=
 =?us-ascii?Q?WEMCbgx9bAst718VKFwfi6ZRH8NCre5yT8vvjzySntziS2Ny9ek/hwAwMpWw?=
 =?us-ascii?Q?JsdBC7tBNsEVFlPU0hmuc50fesulIV60Z+tWZd7dEzIlWO34lFs5bkvxrI93?=
 =?us-ascii?Q?vvS3dTm+AfNXdi516BYnpmsq1VOWmhE+GumPCTtDpQgUI0IYeKHYwnEkO1Vb?=
 =?us-ascii?Q?eiDA5p69snqBuWM6s1r0R00LBrajQy5LUQ92NPiRHEPE/c24+ppHTS5hcp5p?=
 =?us-ascii?Q?g4KvrAlqqCCEWzQfVFeeCkZHFlRWxpT0Su9bu/3Nu5UiZF2HzVkd8U3fJiue?=
 =?us-ascii?Q?ziCAHgVKBcZ7syhSlb+UTacUYaaMY6ijI4TCFg11HGXIUESSDU6ZaIVUglz7?=
 =?us-ascii?Q?s8TIM0EIAynRdMW/NgN7lDl/is/FxMBwd73rYmzhomRbfkkoxzbd93UTldjQ?=
 =?us-ascii?Q?pyGIhGZfLobduEkUuRJCmlHn+Pcz9Zmu5zm7sZMVYGfPVEPY/6jM2Ku55uBU?=
 =?us-ascii?Q?/ranYGAqJ+da7ge2hZsP133TPcBYNegjGHit6L8Y08keq2vmM7Ga28b1qzBF?=
 =?us-ascii?Q?ZfzpmachRhkDecHnM2wDFy3FqO8wLO+NyO7MeuLeCkWzF5bIP+o6QEN0Q8Pj?=
 =?us-ascii?Q?kmGEOGXMljncvBT6H53pTh8Q7JpuZ/tFsOW71G58b4+76IjS+5Lwb5tW9tNu?=
 =?us-ascii?Q?rNCMx9NWOldea/s6/4qTenpHxHIFheDjg1mXLh/862p5ZtQB+pO0tbqT1R8W?=
 =?us-ascii?Q?+BDJ61Q/wX40ivRM/m0aQbK8ickc1fypCxFoWQGUTqT6A+N1p97l25xZgRtX?=
 =?us-ascii?Q?uvIEYXttmAhKsDaE3HdoCHsVZLcwrKRJFueIf3juXc5qdEXD7734P4NjvM5X?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c18889e-f756-407d-60c4-08dba48c4b43
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:24:27.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrq9v7KOTY88un46UqBn5KC7+ZJvmTK8YuI+oOiJLFzcFHakF6Fei1gi6VV7Am4aZcZpca+L4J7grlP6HZzyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625
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

