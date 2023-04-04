Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B25C761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 14:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjDDOUE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDDOUB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 10:20:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A430E3
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 07:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHQjQWeDpf0Zt5NKbhurxzc910DUi7BwDbeEi3aOief1A1h2gfEYYUBqsKJuwG07Nfb+6zCP1QfTi7+ZTX6elglJM9P88NKP8sBRc5KSrMrQqnv51wQAhR0YsSdH6s5nxKLq3lMmEciP4mGJQcioWuMMk2C837kWP6ktOBBt2+63V54pQVQ8/UwDNkZDHApE3dYOWSKNvkqg4/AlkN6m5iSznaSv3p/QuZqGB4NcHT3OpRGFcVduzclgF0hqXE6glEb4Fbjovje8FGtD6uMzfuLkT1m+hO21wEF+gtUaEZNZ5qQwNZm4edgXgKmEDOX4FAjfqWZ/ctlzTGm7A6oEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpDhTxP9U0BRKJqeobbr8zS5k5Oyk/9cFH9kpYaN+mY=;
 b=CJNsVnMztnA9VYqJUJ8o2KEwAuMHeAg1EJ7Yeb72uXGesq9nEVtTTcfKOtswZM8n2I34FkdRe8VCumQmZ9i7JL5VapuMZw0WDmctM719xUccwSgCB+meBglCvHDkJxuERqtBdcBh/CSvNe3tiQssBGScSK4U0YGbses7WmeRDmWS4MyGuQRSuQU3ZtNSZaOgOOopslpIVAU8oo+bddY/WjJsA8RKyEB2FI9VDMqNoy7QWLxpzueVF9RL9WmVCT1KqxN/MRZdnuMoUmdacywwDYLIVTdkGqS+X3nT+fXYNnVNJLOW9PrEVFXkSkMeAgRuefmrytuypYp1l/vxk7/7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpDhTxP9U0BRKJqeobbr8zS5k5Oyk/9cFH9kpYaN+mY=;
 b=dnumuBFQlgUegMAG0QBP5mSx0665OUFSFg8tSk3GqUJdRbFy/ReMXnPlPWhEB3JwGYC5QlTqrj9h6pnFuufc+xY5b04mCeXTjVtcoK1qoG3po6PGTP1KM5bU20jfHoMVCT1WKaKl7p5pzMpry/CR5KnUjQHE3EAP2sbBcg89s4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB7877.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:19:57 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:19:57 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: Set ISO Data Path on broadcast sink
Date:   Tue,  4 Apr 2023 17:18:53 +0300
Message-Id: <20230404141853.4868-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404141853.4868-1-claudia.rosu@nxp.com>
References: <20230404141853.4868-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::17) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f12ef7-95e0-45e1-b7c8-08db3517ab02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RN3Edd0z6O2hzsIxTViHSoYzipgmBpHPwddUT2/y3vnDPHNutZASnA7YHzRblC/7peQwJ9KkS7T2x4CsX6daIzjZ6qCLJFlAoxUuvxcMyrKoQHOoIPk8x7Oe2puj9+OkXawJTcdL6H8pQfbBJXpWodwmNjM5dppcvfix6Wl0l5TWJi/GPjx1KcgL9MfWQGKhj11jZgmw/E2wuHKz0L6VdzJVJO91V5nlHmjvz/wQI48adWsNHt8l8uh7H9xKEX76BMh8mH8NdlimnmjykECDH1IWToJFGLKsAN8iZYzvZ0eInOkKE6M4hAO2UoTZ4VnpDbqpCVYS6vUDS7TD6a6MuaXPMisg7H3olMNrxEnwokjEGZVrT5uYAYbnUTKcxrYqJRLE20sO+msmZdSiSRtk+yK/9TQM4eluO/7kkCCloIrqKMBbuUQ1xb6ItAiDhadZdbMsQQgGm8lTdhZSARm3+Eyn5XJreXt19H85cv/yBYU7ZbcsQ7llAycHX102Ah9pj2K6xjupm2T6PxNAa/5i5UZoS1ckInRb8lUXdg4pCwOO2PbtLeIk5WZPVuBdT0tp0Zd41GZhNdOZ5fdJwYSgcrqOgmFitGjEf9ehKej5x/Yl6HaLVoc/GEDSVQCBXeeA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(2616005)(6486002)(6666004)(52116002)(186003)(478600001)(5660300002)(316002)(1076003)(55236004)(26005)(6506007)(6512007)(4744005)(2906002)(36756003)(38350700002)(38100700002)(66946007)(6916009)(86362001)(66556008)(66476007)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzEgKEeEHgyYBPjlWaSpEMkai+/iTIFvBvkoHy4meTLvq+nQFe3jVUt0aunl?=
 =?us-ascii?Q?YUHOmS+klhikuk759zlGTIgE0FDx9nT3aLbxzDkK849OVYOz7ZI4Kgjq08aL?=
 =?us-ascii?Q?kJrKp+0RtqWyDGSBSqVqSN9HpzhmctqSgokPB44iHikfux+V/XuesZbk37S2?=
 =?us-ascii?Q?zcKbpLsSbABwXVzxpLLY6HvOEt2o0fBjJc9E1YN3Mt7SvenUKqZc0hUwJh5D?=
 =?us-ascii?Q?JujV0Fy/vNoIDqMdX418PZYdkVs0FHiBKtK6NcND3bD3p9UZNNUM1vN13PS8?=
 =?us-ascii?Q?THumnzpwFJktUdSZzTjHicPBenoxmXfdiCAb7s4/YXYRUoCN66SvAVL9YElm?=
 =?us-ascii?Q?I70iR4EzbBGrUwCH/97GFVm89W9Ue+RBOwKtBEoy1Z0+hAGm9Rpex7z+D83L?=
 =?us-ascii?Q?3IfnPqj1+osrTlLUFtmI2P+FqZls13vbJse+2dlhFBZW+GoHHjYIbJXHXIYL?=
 =?us-ascii?Q?jyH04UW+56vj3zhtRvgY4aVvzSI5Ldw3QLh8n0ab45om+VpMSv070eDut/Dc?=
 =?us-ascii?Q?FiuKrjYIC/iE+8YVHlC40X2lKByts+6WQJzdAQhsUKYtgmJCscntTxVBoHCV?=
 =?us-ascii?Q?KRcs1aWe/7eK/zKXKe9mq+dayrw8IjS0W1aDFPupNdVOaMOz6xx9BSWCHdEk?=
 =?us-ascii?Q?qeBngq4PY4HC/2Eab2yuTsbbezhyk1b1auR2pbqroOAMMGH3n7kqrr2o2xxj?=
 =?us-ascii?Q?v3nuoX1hV35enqk0xCsO2uYv811zC5qjMMLlFptFUvBy3pKllDT5b7rPpBg5?=
 =?us-ascii?Q?+4rXJ8fW+OmWKl5qPC2OW2fjHJmfFjfZ1JtO7D6uydbSQdSI7Ia9PJVNTlEe?=
 =?us-ascii?Q?wWZ++I1nfP60ZOHxq8RQPGEp8jukAYmMEWsbGMkE9VU+AkpEd32VkwzN/jnz?=
 =?us-ascii?Q?yAA41hp0VKNYfJeX3FI1p+8QyR9JAH/w1NA4sECSNREkTrS2cMCjCTcrgjC5?=
 =?us-ascii?Q?id7s1YR+2QgkGyaowdXZQac4q5DDnWu2esxp8RmLqH9bfYJ6qyjLHWrxBXRu?=
 =?us-ascii?Q?8lI/E9CQYetGyENC7xxldONrwgckwZwjFhpb+LsBou84esQN6Qn65QAnbGI4?=
 =?us-ascii?Q?HiTKhuYJs0hbcdCxN+V4BYMRc/nT5QnHCtiOD/YfknOWSycpv2eduYZUHsYV?=
 =?us-ascii?Q?mzAFRYNCjvIj46c+uKMvjiX5h+DeDiqTiGezDY7vbtCRIOLRg3Ofs+vYPuWV?=
 =?us-ascii?Q?Z3OyP1uX2fsJFee8pcHo9b3iFNg82Jzc2vQkQ4imgR1fEYUrTonXnGDfsyGc?=
 =?us-ascii?Q?K1P8ToEmKiu0LbQaUY3oJBGEQyXVWSQN7q30OkFAFS7XDgCnsD4aY9rd7Hqm?=
 =?us-ascii?Q?MllwVYJYz9BKC/0hwfKUvtaEE6Jkgpvqr7tPGsobINzM+Ge1cxRs9o9Jlx4B?=
 =?us-ascii?Q?TV+404EVVC/BXQCJARGsrwF/ppHPFG7prIppNTimGzyX1kWrB8FINJf+1lPr?=
 =?us-ascii?Q?ckSxuVK7DteT+MAsMoNGXc0/5n4S20LRHdxW7PKp2quN0oShPmM80A+W9cCD?=
 =?us-ascii?Q?SuCe4bxwinccG2rUatpQpycv/H9pIOfDV0bJET6tW4K1bv+fLOX5MvGEPPLp?=
 =?us-ascii?Q?xmy/olR2X/ASbM6P1w/+6KLfJQSaxn3iSnOaO85+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f12ef7-95e0-45e1-b7c8-08db3517ab02
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:19:57.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz/fD0Ikk26LEAsK9Y0vpUuPI99l2h/RYjQ01Kex2dhmPA3Z2W6ttrK1KFJ0xmQ0cL2xXkovckx1J/xKnURdlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7877
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables ISO data rx on broadcast sink.
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6cf9ae5b14d3..6ecd10069b6e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6997,6 +6997,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
+		hci_iso_setup_path(bis);
 		hci_connect_cfm(bis, ev->status);
 	}
 
-- 
2.34.1

