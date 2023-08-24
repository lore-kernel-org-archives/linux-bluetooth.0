Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F5C3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjHXKZG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHXKYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:24:35 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96121739
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beZTH0ZSMlr7jLonmAL0rAD+9D9V7i8BW3hlgKtYsPcdhpnSI/jKsDmpYIxyz4s+nCTituNVqbzEhaZpeGvMyk3XjZaIzFrVltKsEtpsCd25aJ8+tSnrbt/Efn6g5nusxoHealxxoXxUTKCnBpqDz80cqxEwV9bHfluub5Arb3pq0HPAgb5aH3D1mlfSa/VyuJF0vmMaOpJKvNHS1/+e2mIMNpsvGe7Bx3W107ieD2JH3sayvbMLxcfi8X0VIi5g5m9aB+6jEevQFxx/gTGyyu0E0/Cgz1vRclaOMYQs3Dzi255lcoZtIC3cPdZY58SB3csqdUhsIZhyesko6bXD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzOJoAX4psVU5KfAWHkHcK2bmU+hS0BKkW065wxYZgQ=;
 b=bWyPVfOJbCPS9SoFF4AV3byrWhjndA+0K43u9JUFt5Gfm5rkGBjh/H1/oE/Jcbmo4K0b15MnNQKvzm2Y1h2HpqEviE9Pi4rZgCA9248On2XGKR5i4EZY1zcohhdPPtMYhssyRNHogTmLmHJitBGbC5BNToppJhJookaJ2sZTzQhbDj8TTiFFx10pQYe0jDdS69jmGzsQcULQrEl/ssMWtbURYDIqFIkDtaDp+ih/w7oYFEUN8H/uVr8tLwXWBzGix2SYYrMbn8UgfNizg43zT3aMwS7pyUWc/rBoC6fvlmD4jtdG9FkLnUi9okgIjtB+xoGLmpSE6xEAVgAafc0QUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzOJoAX4psVU5KfAWHkHcK2bmU+hS0BKkW065wxYZgQ=;
 b=abb9bpT2Hb7mVVTfFSu8NXA3Xz0urzYcqFKggtzRN75irKclyWSOvFvs7M//6NlzpLV3NFQ55Y0EP/DyiyiEr42Ulbwgjxo9sJqfy9SlShwPU3hJWPSCBYYDqCyu6ttO877UYjGetAwbmV3jWhIX9lwj7Kd+40ngBO9mY3EHlTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:24:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:24:31 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/4] lib: Add sync_handle to bcast QoS
Date:   Thu, 24 Aug 2023 13:24:07 +0300
Message-Id: <20230824102407.25883-5-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6429ad1-7ef5-40bb-67d2-08dba48c4e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XV6knEcMxPCVUg+bwky+UX6uDlG2IAi99fFW3RpGmIIflPY0RyaxleTGe97N5R7GQ9SHj1fRFDq1kW2zCh7Eq6crx9WLD5Tf1DDJgatP34bVINqEPXFSb15Rj9ySWRvZ3RYE/raIB8Mi6TLAl7JfdY5dAy0kQ87urZSf+SJ8KcGiuTe7OKZgBb6rQiU0s2/P2eMiEiNfyqaekCd/OJZXey+zQtohyjNk4LzpuBgrjGfubNuaUIKTHvAhSUEqwFMmvKdoJaLcdbVbSz+b+0b32W7cIQL/GuzrVYfqvID8dKQpT8QQNd9ZQwlbK8ZoOR2D6ttkMs54mp1wdLXoxSMBlhfYAcRpAGQFRw7gt2XDWmLTH15EfAn5vAhb8snj4W4hu57HtGK3UJ7ZjGgLt5Bv2VCN5M9VM/RqmccD/y/cHqDwvmCaU8MmdV+5eY6dJ5ZzrO6haYqa3nv6IW7zTyonv9Iy/9pUlg2UlCj1hhhgaVSrUr/9dtrL0RbMNT2p7Rv+N+QyHqs+pTViokXgB0RrghJHYIUkj0NxJ22kWAq5Wa2rpWdbwkm9/ME80svTvnGkppCkgXgzoxwcI3s3pLBbZ0PH1w0hnU+7JsYM1G7HZAfmqdChUEvEjyL0H3RENQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(38350700002)(26005)(44832011)(38100700002)(6666004)(41300700001)(52116002)(55236004)(86362001)(6486002)(2906002)(6506007)(6512007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ShNe3dE0aGaB6TD1dkmpYv4SrVDmkKItilMZnJcaV5z1iq5lyx53YFC/Xbmb?=
 =?us-ascii?Q?HEYo9nZENNfjcLe5MZhYLejy9id0lUoGu2lD6JR1bVytC9ajm+L2SaWJX+Sv?=
 =?us-ascii?Q?FzbVQBbXfCrxZ/Hjy1Yy9i+ILxVGgeCrATpRSJOJLtGimxf65RALhtQBC/k+?=
 =?us-ascii?Q?7kybYTI/xwDqZ6ZIcxP/PI/5qO4u4Yi8XHKTWkSq5PBCuVq1P4HCizKjZeGa?=
 =?us-ascii?Q?DFokPiSkt7Gbj0868+/7ENeZeSnQHZbzQ/8y69VoRWDSIHc3UZat1hZAJ3PM?=
 =?us-ascii?Q?I9URLNRJbyJmn9UM785TPpp7NySUDcjbiN1AtuZuGqb1Q9kWbHnxcBB6iEF7?=
 =?us-ascii?Q?0mymjmBLiUxGMLcpXT9/zNSPaGiiSinKAJOyWvA5jJacLO2GsOtptMWp9f0A?=
 =?us-ascii?Q?p2FlE5/vzaZ7RXF0D97p7Fmnm4prunMcOGGoI+3zUhQESTJiz5lCa0/3ZWQU?=
 =?us-ascii?Q?dqjIVHZ4yUWaP0DJ6lCS+lIPJEnkvIzHuZAH8LwXalgaOEoDcdjolkZhuh+M?=
 =?us-ascii?Q?oj+aeOLx0ojCIx2wXQ4cnF97ftYyIHOVRcXIEKrwGONKzbhlnvmsB5rybTqQ?=
 =?us-ascii?Q?AATXyldANJptC1Ab2qhVJXjVAXUN9h3sFhmKhZGhm/qFya7hbAJyoZOI5iWB?=
 =?us-ascii?Q?NXBRfO1dwy3YqSFGa6dQ+y9NwD9NaBz6qBiGKl6IzDnnTqGL7FQUd1yKuud3?=
 =?us-ascii?Q?upHkJfMscfWR6DJlPW9WGX/nRUw8BB1bOwMBHE4LL2mG9ycIbif/l/sSTePM?=
 =?us-ascii?Q?5BXye1AJPsN2P3bgK5hqdM1XJf8F1yMwOpht2RICWDnE5xXCXHGQJk9hhKXK?=
 =?us-ascii?Q?QlEWVRSvkJKeoO7bTzHL7nC6O7iFvnczTw8ma4kd9VmM3YAs0EhgcLQSnmvD?=
 =?us-ascii?Q?HP/OlnHSQZtBnQaK562QfdKQV1mhdAqrM5x9Fe+hAn5OQFw4Kx/gtpkHehwf?=
 =?us-ascii?Q?D3WhLspE80BxCmh+A49wVNIuZQw5h7MlTO/u1y9msF6KchHwmSxGIAs2NpRi?=
 =?us-ascii?Q?kz8Vhk/xSywxxL5VHUplUKOgB4LQzBlDUxOgs2dcbShe2FmDh8nQo5fejw4/?=
 =?us-ascii?Q?ZaMbT/yPtk57V7nIPhDieolo4B/GsOMrEHW61QJQr17zuK1D1QVG+DZOmVjR?=
 =?us-ascii?Q?UYdsDkGlyTE5+w0prvtY8lHj9vz03Ood1K86tW3thmYof+GDvueUFB3Jzv7A?=
 =?us-ascii?Q?fdnj4jFkLH/x8fFA0sDOsZKJxa6cASkmVDsDURYTQPklUJs8p58jSfQPLIVw?=
 =?us-ascii?Q?h0hjVLUx6LlGpS2ho6YoWM9JfmCNIyQmzqWQe8vkiX9BOdzfSGYj4Q4kxAAC?=
 =?us-ascii?Q?wvkXAiKOrrZE4bNksdAnN7qw+woEH1bQ+hz+qAjcLpz/aidJglyzG9da1F46?=
 =?us-ascii?Q?e7vhlQoahLUraM4NsJtYKXXUEF+xBCno7D5p+acaXi3ex0gktxS6omMcfOKC?=
 =?us-ascii?Q?5nIA2Sqifk+1ogGe1UY/Z82YYI5ZqAX2Jgz7/RLI4HJxexLMKh9o9gCfYMMO?=
 =?us-ascii?Q?NT1r+cFHRUgjmwSOC6rXhEqY9WBSKcodArkGUHvi0HAR9886BNGNk/S0efYq?=
 =?us-ascii?Q?i4jKjVhtftz8zBFjKxEtM8BsT0ebBf72uzEAZpgyNJcprWWsCzntDrZ9XKY3?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6429ad1-7ef5-40bb-67d2-08dba48c4e39
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:24:31.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zoj9QmYJkb9UMtWfYgY60f07s7mH0XuMKP0f7er3/YNU7mq7Ifdwkou5tHkq0zO/Y07n6LTCoRJi95TI+/ZIow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the sync_handle field to the bt_iso_qos struct.

---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 1286aa763..f007240f4 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -187,6 +187,7 @@ struct bt_iso_bcast_qos {
 	uint8_t  sync_cte_type;
 	uint8_t  mse;
 	uint16_t timeout;
+	uint16_t sync_handle;
 };
 
 /* (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH) */
-- 
2.34.1

