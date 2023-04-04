Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F64C761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 14:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjDDOTs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjDDOTr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 10:19:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B8E75
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 07:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCwOubHaHrk+RjdmyW7xF301/YzTB+C7y41w3UIr8CPMYe/SadDDavPrzob9I8oatYF6SAeVBuLwIso9IDtgBofkt7IQqzI9Ljm1WTYVnOmJ5r2te7+aFiUlNqp98gfb8PAQfXiBbFwjywxeJp2tskaYw+2viLy8tQjeB/9vU2pj25YIaOofhHgADgVAllwCnvOUQB1L+qL9mwWR53oql0FQyCp/2FYHqiLr6Tn+WscZkumrkyBQ/9Hlz6nU0YkCQzdY0W6ronSbo2Hlin1xrhDHhaKUor4NS/y3fXf6jyBDR3IMVukMmp8ab78o33fOqjH4jdQgMsx4MDS6jURWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poEOEbctnF7MiXIxh7pppS3bGrqXC0Plm+Zm6GzLww0=;
 b=khxSeR/4paX7LmKreVUR8Sggp/T0XxCDWfx716lFwwJ57hIH6YkNi5Fq70XEpanXJVAApD9DtErx1EdxZomwLRqNmNQRqKk+2NCacWyz3QT76Ak0Cr0ijDLQpU12nhp2mHqS1iFlHlVKYFImkhBky2HPgOO8DZTixsMa2B1jJALNRKEHWR1MuXiOqGB3wYrBR3NmEZUvjLAgBwKKK1zek01yV9p4iOTbnsjfz5n9IfCAC77Ba7b0zJ6VHIR4eGXcX2j6J5VAzlClqtSFzlnaxud1f7hEEA2o86lAwycu6LRXL5h/V/3hX9ZPoVz/M+9gR19SkTAHaLOPvqaBcokvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poEOEbctnF7MiXIxh7pppS3bGrqXC0Plm+Zm6GzLww0=;
 b=oqwYA68me+7HAHQvu2qYEhagSkNxFK/E2VCjs3FkvJfDJ+sZo70GvlrBIUhJMc/5sRiXv2B68YTGHhJJYd5yEw21tW8P4TRbI2wYXQwvRDNnpOZwEiJFL7qlosE9lQcn5RBaSoC8EBhvwj+ZDFV7d6va/1pRCbD+6vy/1lqoP6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB7877.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:19:43 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:19:43 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 0/1] Set ISO Data Path on broadcast sink
Date:   Tue,  4 Apr 2023 17:18:52 +0300
Message-Id: <20230404141853.4868-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::17) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: ec14ae97-4fcc-4b6e-a503-08db3517a269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpYgZuCO8LPMUqxu7nIcTXMyqF1ea2PqCfVis11HhEXovU2+Hy7dlnN+pswuagnNmC30aScX8dMYpjZGwzLiMfRqZp9vInjSw3SldhW06j8CHndoh3J/nHiaob270gmb10nFugzbnxxjuoS0jLvtrdKl6J3JfXiXlBYk1rhFZaDz9mWDVNfFD7B1TuE46iLAWYHC/NEkbAcPC0AA2fLTLFumtUUoPTALlHqG60gUItOHn62y3EypPE7dCoULQTeNFV3TQGCnC+QxVws1F2ShDqS0Fo+z1vUNHTAIEcnfUwrjsptwCay1uYUuBa4hChxxUH4rTDCI8tisnyRwlk9Kh67xW0js5rVsyvc2breYGKexkmKv2UgsC7zjG8Xer/79krCDTGvN92gpqSS/2bjDN/JYvejj0CrczsKaQA3ehHJRjs9vyvghzyagL6BRozJeOo1IuDIPMPe2s0qOWH6N8LXAQmAR/xte2b22m7774JMlvZQ+FQBNy1by+38C/6qJPpgBw0bU1ZcbXlCuBvwbGGhqlle2PFu4Lv8lu6qAoWABYpHrhAWebZjCNyqTR45pw1WE/lGPXPdd9qkssHWeoUZaKo0FLLREvNqVX0aIJf8oCvnBlDJ8y4HSXHsMe0GM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(2616005)(6486002)(6666004)(52116002)(186003)(478600001)(5660300002)(316002)(1076003)(55236004)(26005)(6506007)(6512007)(2906002)(36756003)(558084003)(38350700002)(38100700002)(66946007)(6916009)(86362001)(66556008)(66476007)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L40rFdZwv2ABamz3AiRtbCy+0sVE50XFRQHs6/KbhC5ja7SM7ZFhkPK+WvxA?=
 =?us-ascii?Q?sS4NXYAAzFE7WwS2kYQxttvwz2gYgNeLt5M6EKzbCavAd/WGS52Vm+BOrHaV?=
 =?us-ascii?Q?koFJQwlyGAAggJYse305octX4JThNWT7t149JESFF53yP9pbm2sXxrtZMWJy?=
 =?us-ascii?Q?Ewiy4q5xvGN2w2yJqXekkjUmn/wzjmbM5z3RVkAx33yybacezv9CZac2T1AX?=
 =?us-ascii?Q?+ifJ1SqU1raUTc47sAt8KbPHUOMVR/YT8HnCQJkSsDvMMPg9j87RRR3Zfhmc?=
 =?us-ascii?Q?nozIwsMp4G4hiEbWk6zQ+VrcNw7ZMVrBXKu3hzUSlXfAi5I+cRw8/fN9JgP9?=
 =?us-ascii?Q?6aJh3g5RfBQTSUTNDS8LRo7s54JJtdUwbgAd34RPT5rtSQAH7jjcMYyNfJ0D?=
 =?us-ascii?Q?2bfvhY1Dt1VNuce5Mn0LH1zlSmVbVXP9nb33hM0OfZ6HmyZh6r7LoWq2CArk?=
 =?us-ascii?Q?4vW1KZRjLEZ5vsWqmBdrx9GgPJBzcOpBPuJlnuP0LfeA4bJLXQ3gQcLASI4K?=
 =?us-ascii?Q?mZ8oqgkQGAjrRfkHUVJL9ELuD9ZC4+ChRb4uqsoY8zQsRZPUQixSrDg9a3p/?=
 =?us-ascii?Q?VjJ/HWp/7Z+7NMFjluN60MmREtfFPRimFZmDNmFBsK0R0ww/nD1Y2NC+/vPt?=
 =?us-ascii?Q?f+UMT9X2f63OXrxxa0UEjwVeBVCr8Ogxul+g82dhicG9aJi/s7T2eMi1rNh6?=
 =?us-ascii?Q?Tipmlhn2nN4/oqU3+8YXZprrhvu4QSKEYoleSduo7dc/y9M4HDtbWDmdkplZ?=
 =?us-ascii?Q?u7lGNBI1PI9ztOeULac5jyOQu60vJAlpZ19k9IycM2w99NUgJoFr2kokVpx0?=
 =?us-ascii?Q?AHRzBfc/+NEVdiLhJNAvGoEM7o2Yv99qHVM7ORw5Tmjfacq+VuaTcSNV+KLD?=
 =?us-ascii?Q?LyRX8dGuqglhdhHdJ1PAJZwhqqu0bjL7uzb1p7OFU99ufQc0TeAD/IggcBWh?=
 =?us-ascii?Q?1hBBp/ly+QWZlkY6bxuD8rVnuZbsHpchGLk9tK5JcUKSqKaJO08AsNjbp3Px?=
 =?us-ascii?Q?k8criy6aJgIguptRO27QN4ulStuHnTnPratukp6oolrN8pD5ncB3NVafqYLR?=
 =?us-ascii?Q?Wf1uFFM3W1X3yAJg0SURBYTyG6PSI4lBYC0sXT19HhBzKYnIEuvXyPvA1+Jq?=
 =?us-ascii?Q?9p7rCSUa01BbvdwUp6NmZdqkMEhdetYLmh39jYeM0xTb2qz6+jqHB5AEPLNT?=
 =?us-ascii?Q?bWePBbozbORrctzFHcvasn0aorabZTCb+KhRrmK13mJwZEBz3Ddz+iNKyTss?=
 =?us-ascii?Q?lOozazLvToKqxmdDzMvDYom18gqryAX9seOBWrB0RAJsE1mDZpd40IsNv9gO?=
 =?us-ascii?Q?cINs06vXsU7wUnxAlonhhEELvHZtURz6B/nv7hhY0nm++4gXuEyPyAvX9Yea?=
 =?us-ascii?Q?3FYF+jJ92kQSgPDJEt2qxrfbvF5TpaIqMSX26VtsCO2zD1iRe/jmNu0WDyEK?=
 =?us-ascii?Q?t0U0GNbymy6Vt2xThpHm6DuULhJ/q5DLex6l6CIUxNJERsYcyMbeO0/SXvRk?=
 =?us-ascii?Q?qXLWK32wcIfIh+SRxZsLK15UpOocKcu4xZBb08zVNt/FPv3DcrJHKw0iHH34?=
 =?us-ascii?Q?mE2c2of87Tuvy6DruiAplyXZoEz6TdQfK3Nc8PrJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec14ae97-4fcc-4b6e-a503-08db3517a269
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:19:43.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr/8LYgW2yb0WiXz6cQa2cYoPxi0nbCYn9rYjNsZSJ8R2g3ZAelflZhK803TaahQAwJxcWePIkwEYDz+wtfkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7877
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables ISO data rx on broadcast sink.

Claudia Draghicescu (1):
  Set ISO Data Path on broadcast sink

 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1

