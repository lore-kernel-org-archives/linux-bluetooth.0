Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9950CA0FF8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbjIEQXD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353666AbjIEHJq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 03:09:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEFD1B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 00:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJPk6mSCYxOdY1Aue9Bro3m8/2QsuOm3bSNvn2imIsvUzbBloDHUk6p3c+XOJDgZwo0FGxT72N1yoSDF9euBzWiJBobwUPn/yuawI42bRLa5iR7VA5aIesvJrOwt5KSUlRIJUBZmspD6v38Uf0uC2zJf89aNY6rh8EigndufMS5UoPE/AVPEbndxNBtXS7tS/amMPugPqCHBtIZihOvJ3LY/GmslbFvxas9kx+AE3OOB7n7Tq15TXAJxsMLs4hd2X0u2G6XOZWLcSksk9xeuZgSA5m/+aXeeP+9OXT3VUNNvXwQYH7YBYWfLWeDUVWERaJRbJNETKXEIY8GgpR5tZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHjpEsTxiKVXO3w7TxwvpHsCBA0riV72SOVE0BjXJaI=;
 b=M81sTjnCzNXIfprt97riGBTwGVfw3FuUM7uqi7lCXfB92XVNDqCyhMIho/PwvLCjebBk1wJXiXW+z7eaixYA6aEoWKDjeFNW9BeTAAG3yvqX0lpGAznCZYy7i1wRHax6LwUxzBee+JZovzmq4LV6Gi13KmZjjqYMKpjdYdkYaCUHZu54q0k4k/IO5ryWk4NNJVKjegPA2eIkJNx735mqQ93Dsm83jUcIHwrlnq2hVDS5FCVUc8j2ekFedEKe7RAm5xZpogO86yB1SJJkkAblqKKauVDrLDvhsIQa0poGpYacSVLSLuLMDR/vKovPcc4PNQIIuexc//j7mhoOG+c9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHjpEsTxiKVXO3w7TxwvpHsCBA0riV72SOVE0BjXJaI=;
 b=OD/oQKcq/NdatNWzP2nCsbMXJUA9VI0kO/xI+0q1QUgiXwik8f0AwKwy5pkGkFbcX3ScJA786MPXrnnvdMsQKkFaT2dMfz2zUk5Iqg2n2jOa80TjrQppkG5byyvgdzOx1aMx4wbYaA94UK/DizpwEUSfOLbSvsiHgjAJ3Tfuu1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 07:09:40 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 07:09:40 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mahesh.talewad@nxp.com,
        luiz.dentz@gmail.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 1/4] lib/uuid.h: Add UUID(s)
Date:   Tue,  5 Sep 2023 10:09:09 +0300
Message-Id: <20230905070912.82340-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905070912.82340-1-nitin.jadhav@nxp.com>
References: <20230905070912.82340-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DBBPR04MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 8578028b-17be-482e-9a94-08dbaddf127c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4XjEsMZuWcAt6v/r5BzCWqPLajVNStm952iPaXfc8Q2Gz4u2WesJra++L7MQW/zKzuTyQJpWnJ3lO+sl26BiWQHbebX23C/B8nRBf09zPym+bxrNjqO58KtmXHlZyJtMECuWvPKFLd5RX91xMQctd4TN1ICJ8o0411rjYPxIzxt7MLKHJ96oRM4AYcrKn+6/Kec7u+McClJdpaJyxqYlgbccEmVyEiFEomXT6QH9XFVaIPKc5+4dHlavYDjnhx8VecYOTR6qo2zOQBgzh9gevaG/u6OyPaHKeMpQSPjRRe51Q2i01pm07LpQ0TDghXU24566Cc7kwfdWLERIxTJZm7ZfqKdSfV33BFL3GlhA302E9mVQHxAoLP/LCeb3WMjQ9ZglcB/rI/N+3pFO5fYi9wi0yEEzFsalK3O8XamzpkP8jXP2nunKhTVdYqRP7B+sF4HldQkJqDrR0EzOwXNqcs8OB7oNLDB/BZVg83LT5Wu3gVDrKvJW0bgu0ugIo9QRn9TM2D4vlC2dKgxzM0cC2YqPWwrHmtxHiDSpTZrszwuj/CSrldFGe0MoiYbVheaBBIo+r7BDAvEyzg2tYPoufuEPubmuuYu3Aw2pcTMcK4/YURjgmQlmvTOsRQun5o5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(6916009)(478600001)(38100700002)(38350700002)(316002)(4744005)(2906002)(41300700001)(86362001)(8936002)(8676002)(4326008)(5660300002)(44832011)(6506007)(83380400001)(6512007)(6666004)(6486002)(52116002)(55236004)(2616005)(26005)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRjEzR97RyvED3sTaf0L2gtrIe9UqVL73gZosDR2sWyZ0sDd5AM9xBL7OjUT?=
 =?us-ascii?Q?QqBRiog5aYlzj+KWUIvlQcQFbGQ15ekrWAlQhDPhrkCftRCsk4RLaNPLgCzw?=
 =?us-ascii?Q?jJbiKGVOqZRyX8CIVnyTlO8KvgPF8Pn7Dxopu0JkqN/Mc3Ij9aiKT1P4JSOs?=
 =?us-ascii?Q?4ok2MmARnZlpuSx7OBiI2z8WQNpFQNh0zI/9BDC52GrEoekgP7hW3Bor8c0q?=
 =?us-ascii?Q?6y5vDwnvWUyuUgZmuI7bBgnUoOJ/vY7nbuFtfsxJiHHfhwyL9cwq+OZa9vlB?=
 =?us-ascii?Q?sKWwcIqODPBlyF5SJTQweKw0bjLEDD07T/XKIDeab4PoksUKgmfpqB7RQKMO?=
 =?us-ascii?Q?CBHxjkmdc9iSjaltLa+3Oz8mDZHKhLhS+fmJrnd+GxJJ6s/wuitc2iMgTFld?=
 =?us-ascii?Q?sXyK21drpXtDSTExs5GDiVLHoOSvlQWdQro78rF3BsQNOulqs7lm1l4vlHt/?=
 =?us-ascii?Q?0pXCVGvBmcE9QgsJu4RvVkGmA75PUF3lAuSm9NpNgZSKaFSwKM727GObEsHG?=
 =?us-ascii?Q?9EtvA6myDAy/VDZ7b07NnylZLl4BAgN/VKudhG8Yh+PblMZL5Q4yDyIaalbH?=
 =?us-ascii?Q?sX29o3I/Uui9TV65I52YBXItzhfCdBwz08cQQf9jtJlL7w+mptPWpxwSAsFj?=
 =?us-ascii?Q?UJqOE4Jw1LMn6MAm+02zCGORtkeniRPB41ud2KKF0mypPXgztaraQhgUpRv4?=
 =?us-ascii?Q?BRc3TMgR8V/fTq8tc6/JxeKdWBRE/vcJXL0cizArz+MDCMCmhygtm4qgY3/J?=
 =?us-ascii?Q?YGRp5SXQOLFrN2gbRYz/znKZwpv3OqqwfEJOeTeqH+9x7A21tohIIPG7dGYr?=
 =?us-ascii?Q?m2PpEX8d/2ofLL5MYzy8YE9YXzkVuSUkctzM/2vm61088fr1JEb5jBWUgncU?=
 =?us-ascii?Q?B+ytMWvKbjVtvwW3Blg/3kwvv478A5EW1Ns2YnmhkH/43i3U4PZBvRYpQALy?=
 =?us-ascii?Q?5iaerEqfH5MYOO/Ql6Vl3HzrbslYqUMawqwqU8L6GqC2g69++bsgNUT8qSTi?=
 =?us-ascii?Q?oID4oZbUY+oFlJ8VYJK4Hv7Z7LLdQir8OU4v+GbJ8Xk3g3iTESCuFT13zdVf?=
 =?us-ascii?Q?09zvfCnruMax+IT7nV0vTiazOXusPdYhMQ6pVKXh7D4D2owpRgwtFM+378m6?=
 =?us-ascii?Q?dKtZWkbgckRTU2+LU1vq0Mfvhux/v2Zxe4ts8GZHJp+ccQ/878Or/xeriNqs?=
 =?us-ascii?Q?bSSMpXdZ4M+NoIzjrzi5RsMCr3tcG4VvZzZmeMS4vRvm31rgL8kGhAS/7cy7?=
 =?us-ascii?Q?kdpjOxxzU0kgPhDBoFRiwBPTpHcxeG0LPbSgMndYtekmUcIYpaA6tf+nNAee?=
 =?us-ascii?Q?ANZWl4wDHVqDH3iS6fia3kFQXhAilfe85Z5tAAmELkKg2MuGSinTOCrOQt//?=
 =?us-ascii?Q?kIgaakdO9L7Jn9Tj/ngOpFb63yfdg5+OeknHdpt9yAYbZM74Y4NcugV1200h?=
 =?us-ascii?Q?dPCC1XjKDVY6WC44n1eOC4aoFR0CtIue9/4/xVIBSg+4djadn1NwCcC3gONe?=
 =?us-ascii?Q?ZRW4TMiil7bKtuYoOyeUHY3M31uoSKtv2Tj5iDUV4zGVcozAStF8DiRXliMc?=
 =?us-ascii?Q?HdEDrNw3p7cOdpYw5PPsvi65VxBu74+AmoYWBG8y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8578028b-17be-482e-9a94-08dbaddf127c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 07:09:40.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOWqFNR3/V4n++UhP3fhs7ZdtwZ5Qfnu7p+HUE6FbXPaUMZqWJq7EcAiKi9CtBJTSvD55xgfTPYM4BvqebjSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add MICS characteristic uuid(s)

Co-developed-by: Mahesh Talewad <mahesh.talewad@nxp.com>
Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
Signed-off-by: Nitin Jadhav <nitin.jadhav@nxp.com>
---
 lib/uuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index cd3b3655f..a79eeee18 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -206,6 +206,11 @@ extern "C" {
 #define CS_LOCK						0x2B86
 #define CS_RANK						0x2B87
 
+
+/* Microphone Control Service(MICS) */
+#define MICS_UUID					0x184D
+#define MUTE_CHRC_UUID 				0x2BC3
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.34.1

