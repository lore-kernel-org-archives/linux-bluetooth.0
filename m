Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23938EB8FAF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjIFLsH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjIFLsG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 07:48:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F264137
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 04:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzzSeSmVj/O4lDux//3CncrGi+I3ejdXTrlIGNsSUjfpeGzirR/Ahnls8LsUu+AkNPFXU0ydsZXJLOUDK2WWdw4pNIla3XWvWn0PVeUZyb5sw3PzzwkgdQQ2/nxb01VUV1oB25UKl6vyDhOiQnF0gPMKPJ5Y5BYKZJpjS0qAal/yK5H9TwBz58toVitqdVAm6iWi2iTeGR8RQkRD27pVXT4rxtSCVjDSqr2RQEaEs8riqwiHx0GrJldfjssbcPb8+sXy1H4ikk6Sgv5+q16bAA95UBqDOG8Y7aV1qJh1/j8980RcNa9EOwT0CQ7k5F3CKe7u7iPBg8Zd+749E3+yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDjQN2/IjJ+N4KN53yHYy+fqtM26KdA9uJv5Zb4YMHs=;
 b=LnZf4ImtEsxOhNGIL6ORW6GkU+jGeK8In49hd0D8qn58lsWnv6AtrLIbLpI6r8vI1AN7A0eIoy8j3oPwkKqN7Qg8/ZTGTsurHBsRTIYGgkie7oqUN4d/OWvMTk2n68A7Nzc1zpqwof1BJ3N49h22fqMb1VXWXnxDNljIfTjN9qXGfVOlCMsOPGksagHWynFSpNmva0glsu5FgU5fdk4S5Yci2V1fAWcVVXZdEygsvPLyeGTAUnx3ML5vN56HHcfs4bDjuPgnZSV+I7Rm2tCxPCbjuTamGQJ4VwpFeviOV7o7Sh98AKX6hzeTq6HpuFVXnveyjiSGJG6EbhABi9r42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDjQN2/IjJ+N4KN53yHYy+fqtM26KdA9uJv5Zb4YMHs=;
 b=fYRaTKh+5YdhwwVI1AMNf17yCZbJSZVhXs5nvRe3mvBvYRQJyZpcg42Rs+uu7mYT4E3qN/dv21jXkNn1sH6BOWdTJH9N84xtwUaXgibcZMk0yN6BljDs6BwTdx7nosYtvbpdi7A7wyrth9YhPpeL0uYbezhrX4dQIIZzLZF19TA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:47:52 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 11:47:52 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 1/1] btio: Fix BASE copy from getsockopt()
Date:   Wed,  6 Sep 2023 14:42:34 +0300
Message-Id: <20230906114234.10617-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906114234.10617-1-claudia.rosu@nxp.com>
References: <20230906114234.10617-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 332050ba-6e7a-456a-480b-08dbaecf19d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtWzSKMA93l0a24sjBeynu/18TwrGmNr9H6AA7PCwVbv1QxEzBUaDMOj3xCXBf+2Bzj5rgErSt4b+fpRAijhAl530ZLbB+8xpJWbT5WlIM2wO8YcO3gGq3314b8P1tiowRj/cK60w9OQeURavKRbQqOxjIBKb/dJNBPqJrEvJnn4xXcdxtv9hVmybQtCvtrGEhOFUcJOdIZ9pfmrx52756nUMxfwMvT1jTX77F6jrUDuSP8OBWXu+eQTCbxyT5BtgZ18gevhJuQhkC8AxlbDMZyIZjWo/pnawQgUylUPE5LUMlNd/5iSc6wTORSVAUX+rCRBAV+jga5w3Dv4KMYy5rpHZCQ9BH5PY2BUQ6oW0ZyNTcuJEVCU6je3Fx/nl6OaJI8tJC2PAlqcVnMm3biy6XZ1H29OvEv6rFCOYMpQiDPbHH8aeAZXJHCWxzvGBbcVHtqG8XBvtkez2C2HXOpuKM6SJyRXXJwiaqNOiLNFreJITPbFle9jrzqGxZhrgaC3lTU7Ubq1n0mhS+mRsjkEm4MJehsbaLhJFYSuPc7E7dp3Jf9DfCN1jj3cgICsr1vNoczqgzY5WhOq3Qr7jgrMbfQ3MkR0PqDgb/JOrJiku1mwganuziCJc8IhEKDEhm1Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(36756003)(38100700002)(86362001)(38350700002)(478600001)(6666004)(26005)(1076003)(5660300002)(52116002)(66946007)(66476007)(316002)(66556008)(6486002)(6506007)(6916009)(41300700001)(2616005)(6512007)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buAH9Xml7RaesydyR95YN0cCGNK63opb4Tv6gbRkfT+Jaq+uFwbDbVT8eQp5?=
 =?us-ascii?Q?sm/hlpaTqsQNyxaE0+8+/YIwewt+GO0CFgrq9TCFBZOhuUlKSwTSoSbj2zXm?=
 =?us-ascii?Q?c+FT2aRLOii9BaY2z9Z0Sg+aDftmCzfDERWHibG7BXzOUzKnggzR0GY4mgho?=
 =?us-ascii?Q?wxudZ3Bft/xgiLbqfkuTl/gQ5Qe500rMSjvsU9mG21ECOBkzsK55LjJPkpH6?=
 =?us-ascii?Q?VGzHNgCLuWT4ybnRdqaEKSyUB9jtVkEhjwclS1LQp0GXpYYZ90b3LGPOpN5e?=
 =?us-ascii?Q?M8D0NHBCOn/iz2YLliWyI3a+4tdf8kUnxkxZd9QqYr6120cG3znLXAPsLLmC?=
 =?us-ascii?Q?tfyhYUorcSTyxl7r710+yAVBTxoSLjUxOikhb+5udbdY7OcowBNy4khjef9e?=
 =?us-ascii?Q?+3LDqHD10UJiKt2OBk/Ooa9ZXs70XyKnIjkNY4+BwMpjCBMbLRr0C/wtKlGi?=
 =?us-ascii?Q?YLjxk0UT0SwziJxEdfVrG7If2dgglFnuGB0/XiEo3mu49gsO6OUH/jsPj5+I?=
 =?us-ascii?Q?pbKO5Kd/5FRLTZ+abzwd8+zCUK7JX/bbBv7Z9I75qF0uyE64WI9UmL4kBHIy?=
 =?us-ascii?Q?u37JgFyWlsSV5HZ7UmGxfIiD68x3DK8cC/nBk6cWr9CpWA/bO8kpfwK7adhP?=
 =?us-ascii?Q?7pNbK1PK1d+Ejm5CQnkApmZNx1Ybx3FPS1f/eXhvylZDdtKszHGiveBp96lQ?=
 =?us-ascii?Q?8fyi/2fZiTt6NhS7Ci9/qlk2Ipjl6sMPIdJ3zQ/Y0Zu/7Z9P+zRZiPaQPXH9?=
 =?us-ascii?Q?RHy/S1H45W3AAjZwPxMptW6osaRxnkZRbrxwN/9G9KazEp79wDey3wgtmhWi?=
 =?us-ascii?Q?YFvq1iM85pfMgXuGRirks/mc+1FKnaE4/h1lVfi9gzHuZGy402jjmHhC0n3F?=
 =?us-ascii?Q?Zl3AewADWPjwCCAxJoJkQm2tG1d8gAw7xrryUiMdMJvBoCtN2PjNsbS+mBnR?=
 =?us-ascii?Q?EOe6Q0h4OuCM6/HU1OQqQazb1xJ7Qi4BO4H2XYLeo9KZSHuxBu11eCGQdUmY?=
 =?us-ascii?Q?S/NAj/hkGa1tVOAn/2rvc5YCN6KwMt26Bkn6bVu8mrnYVBRoLIF5aQFqJ3an?=
 =?us-ascii?Q?fX2i0HLpvByMS1Rutw+jmWpBrIkOwmeTUNLNjyA8ZJcA5u0kEWLmmPoE46vF?=
 =?us-ascii?Q?CwmzIt4LoYmxetBeEgONWvwiqfWfPEe8pM2M722NJiSeEDdByulUt6qqT3tv?=
 =?us-ascii?Q?l17yI8vgjkwYC+wgCAg8q4fz7hhpUeEVoTS5pR3sbYoTuCymNwAtyttgyvN8?=
 =?us-ascii?Q?J3KRMEmCKvy3o3s45ow8T9RdXfW9LQZz9CH6YNM8lQ/8H+DrlH2flJa7dKQa?=
 =?us-ascii?Q?pXQrpdovcfRHZDsOafvjvWD9w294OC3wzgZngyA8a4Bus5C43TTUyjvNKRw9?=
 =?us-ascii?Q?4rP3qltL7svehFihZjggzNZlXtrty4Ft1h5j9BIgn4rc1XHDsNdW5OS4+B2M?=
 =?us-ascii?Q?81XypU3Ra2y+edoxKFYPuB4ypOk9iA/RIvK0JP/usKXWHdpTQhcaKsaUMDRB?=
 =?us-ascii?Q?vCOGei27rVHPHL4EUrmW+DaiDLliIXIbB+m12bYMmR4e11r2d9JNV1qWd1i8?=
 =?us-ascii?Q?1WclSbXz8AWWwxnuryP6G3JgpGwBMPo1fHiFuv9o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332050ba-6e7a-456a-480b-08dbaecf19d2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:47:52.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUnDhCA11Ftr5KY3FzvsfiHKvKSjKyyvORxZWpY88XZ/ri+UnOySdXQtILY7YCybWRK/xICS074GN+QI3a5hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8353
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix copy of BASE from getsockopt() and update base length.

---
 btio/btio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 8178250d2..8d9959038 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1649,10 +1649,12 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		return FALSE;
 	}
 
-	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE, &base, &len) < 0) {
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE,
+			&base.base, &len) < 0) {
 		ERROR_FAILED(err, "getsockopt(BT_ISO_BASE)", errno);
 		return FALSE;
 	}
+	base.base_len = len;
 
 	if (!get_src(sock, &src, sizeof(src), err))
 		return FALSE;
-- 
2.34.1

