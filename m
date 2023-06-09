Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE8C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 09:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbjFIJvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbjFIJu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 05:50:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA77A84
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 02:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b23O2S/XpuRhVc5WJSHI++5/4TprD5928eDgucBRyV+m05uUKl3RdDmOb8lnCGtySPeQu6UhfAx9GuNomiqv3GzuZFDd8ksaaMjN/dWM7CFf6dapBGCYy9D75pYn4P41XiLhwVViOmvHLfKkhOb5h7YSfwwUs0gDheJYzrc7tX6kKJFnrAx5qHNQmHEVR45ukjj+dKX+2bfSQ43c3/D1ZWGro8nO05otwfxCnOJ0nxPbO665lIzqBpMWIN3/pHRbJ7earslRBgcffUSR1PpkGtq3aGwMs1sixfq8qubSnFGatkGJsRoMWbfLfbe5MKmuekosDtSVhTW+pgJSgupl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO3jTnAmM88LAZH+zjV7RwZRJJsbDjwWt2P9vEDH9CM=;
 b=FxsiadY/OihNgWVcxAL4VeXfiHLBv32dJh0jWiGgwF5sWJ2JlMNfZKFGNjNTAKDhkjJqaO5h9WwuvewCYnkHIvWYT4GkSTQEjSEOcFRUUS+jxzDqa9P5SvXkKjFl9VbNXQGGkaqPuK6pE2wkjZwvgBVhMXTAxhs9PsvbZXnQX01oTBV77RveBHw2+GcjAgqCjnPNaLvXO2oUcPKKfwo+mASyJ4F3xkV65vhQCHSSK6wAB8qZlhu58yO1aa2dWhv8kxOE37nk+pLHKOhgFZXKqxKTbYKWmh6ndWMNXv/sDhwbJ7zqJebCKEv1551ntMEHHaoob3t6y0jLw0V4735gbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO3jTnAmM88LAZH+zjV7RwZRJJsbDjwWt2P9vEDH9CM=;
 b=GbsEOl2RaK/seA45R+Ghy8n0LaHlVf+2X0svLZQsjhRC/Jy41LMp/sbU6cbQOBEP/A6tIUibxHs5VXh7VOqBVR8Q0g/0x9XrIzl6SNgtlJqH8DLvxBX0tE1SPAJpdL7sOGFzv6SZus8fDSGS0PY/I42B9W3zYBhAgccIRN+GayQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 09:43:08 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:43:08 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 1/3] lib/uuid.h: Add VOCS characteristic uuid(s)
Date:   Fri,  9 Jun 2023 15:12:20 +0530
Message-Id: <20230609094222.1877-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.33.1.windows.1
In-Reply-To: <20230609094222.1877-1-nitin.jadhav@nxp.com>
References: <20230609094222.1877-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 154c1b97-31ac-475e-45c7-08db68cdee9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKZpUoRa8C2fiNEtFjoDZIr0uBAOF/y451XcQnkK7oFez0+oXgvNkzZsB0Gg6R+xhaPRqgSdp3c1nfU7l4SnZsulkBAlLLFIK2RNyB3XJngxnz/A4gV4DB3quycxM0xyuaGSvbRjEE7Bp9ZjL2rBD2nA5uaS0qDCWqgbXvThN9nt3XX6BOHjohargK+Wx+tZSe8UHgusqmzC8ZDpB05kaTOsuKWq6lq5n+SYHvoLM3vhvwbiQRVUdNyXLMbhXqiww5jtXXsWVmOofFn306gmi+23WUbkacm70kJf5hSIn6EZaxGQrSek2IlXfXnEpfeqBAWDJ3YKu5L419/Ux719ENxTj59xJ733RqaReGiDy8jrjOkhMYqHkpYH12mE03cirSziU1kwD3HP5P05dzZ9ZZYlHPS1SzlFaoNAfnSWBiQ8xgRZErWczYdGIwVbjHZhUhtluFb4yRpLuiLIpClHVzQn6jtOFOawWVrx4hWNeG7LYImrXxkhaF+55wdmIH/BWyDWU2f5aGBEgAh7TiDFJ5kmw+JJxqd06wAaF4tuVGHFVMeDcdCevR8UNATnbdKwEGq7hkQrfWcOt4wIgFgijYTTXq3RlfNBszktYdrlXRU92g7RvQC7g3lmL1GknUDa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(36756003)(2906002)(4744005)(86362001)(44832011)(5660300002)(2616005)(52116002)(6486002)(186003)(6666004)(6506007)(26005)(6512007)(1076003)(478600001)(66946007)(66556008)(66476007)(4326008)(38350700002)(38100700002)(316002)(41300700001)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mSwhPPik+hSao2Lgmqvzoy8Noh7O2itcRBmjHN1JiQbqXkn9NMt5BTwc13Hg?=
 =?us-ascii?Q?pWpOmNePhHO1bwesD6RTCWm5TxrAl5+kdL0FeveszFUwY+gfuxdGDTvd87n8?=
 =?us-ascii?Q?k4tAsCw9JMltwjL2PS6I0Ae5fn8mrpdWkFkCcevNd/v0u1t2r5MW84vu1pIa?=
 =?us-ascii?Q?9y0ZGBO5QMSDvZT9lkAiSeC/8k7YkJ+EwyyccJL5JxFN6GxolQad/yoOx0q4?=
 =?us-ascii?Q?toW6E01nVeHmkDg48vD7vHMVCWgDEQ5X7pCevBxlJ7U5x+ysAYtoQMYO7ZzM?=
 =?us-ascii?Q?g0hOHMSAPb5wqtGAlwwM5jx/OuuVoMiCFLFOg1pTZng7rjLUE9AnxhFw2QYw?=
 =?us-ascii?Q?nSxKTDEFfqam+iP1I5sqffdhOpeGYN8wju5uX8WnOurNECG54NMyfymlYMbJ?=
 =?us-ascii?Q?Hngl4BfNgfX7r3cgQbCQuYM2aEcR/asV2lCng8B410ASfX5NVRhHisJvEbzI?=
 =?us-ascii?Q?kgd4Xw0lf25aZyoUaTTlAGBpaF8+Ws4xLbEMU2oah2z6UcK4Ugwri+w+KOUs?=
 =?us-ascii?Q?+iE7mQlvpjj5407h4eONVr7TwMn3G0+QkGDgoIGTiQNy31khgHQ5226Tmg8i?=
 =?us-ascii?Q?kfEOBmsAdb6bsOkW2DABj51ehcjJ8QCDStfGFnMME8V22qCQiqzYXvN3XG0V?=
 =?us-ascii?Q?QzUxKYt1/VDEVfF4Os+Q0juV6CFmSaksanFHRT7K75dc1AJOppXvyhiuSbph?=
 =?us-ascii?Q?5fNH060Seknd2240F8iBH6DfQjFF5PpCQd2YGqzzenq4b2fFTlJsXjcd7I2I?=
 =?us-ascii?Q?22RVsEOQdmZeRH8i4N7DXySefKIRV/QAszVP11iKANCQjiT3rZorcfn09wiE?=
 =?us-ascii?Q?df+6oKC4q/zxSZGNhXx7URaMaUbHjEzuNnIY9roqjFBaRqxz6hbBBiKrJFf1?=
 =?us-ascii?Q?Y5Db5Irg5ZVwKlF59damU7c93Jyukbyu3nrmzbYAueXyJfJOATlveeTdP06K?=
 =?us-ascii?Q?jPExjq8w5i16xLDK4SqoXYVWeI52usFHrc76cVrkVUHJuPUwlE7zQge0P4XC?=
 =?us-ascii?Q?VaPXORuUrk6+emltRwAeLFhOZzWFXZG4Z+wHxL0WT7aAb7S9XdjfkyRKVTTG?=
 =?us-ascii?Q?IgsliWMDIop6u7dKoRTQIOz3ZocYTpTVbN3sDZ8bqXzjWA9icwcXUHrf/lY6?=
 =?us-ascii?Q?c3n40l+5uf6umBwWABmm/8V9kXmmY58rs2t99oCxFXrS5o5OVRttaxgfvznY?=
 =?us-ascii?Q?yJ8Nj6QOmaM1C8nitLzVlZKFBItFDNnxsBZ1DAI6iXUBXamOrYuxmYM5PyFf?=
 =?us-ascii?Q?ET6+Bem1ICTLXysEqrihTTxMwsTSYfh4jhxVTB86MthXRBOXHaN83uBlU4wX?=
 =?us-ascii?Q?172o77YspKSXd3BASBvUc9Z8BYcT4tcXIJzk+/gv1H2O8HEkOHgwvG000mGd?=
 =?us-ascii?Q?k3rFp7sA4YhqS8YO45tvYpD3dhFbPfx1j0+RPp/PSV1891oqZwetIehEVyTP?=
 =?us-ascii?Q?P0lqxZNOM/XnxHgZ4vJr3o3uff+5vlxNweSMabD2NzMvoOfYWknUa8dHIpHv?=
 =?us-ascii?Q?KpWu2i9DAAYe7IDlk4sknOOUDa60ikM5id6R9RY7HzXPTRN2eF+PQ0Hceqmr?=
 =?us-ascii?Q?bn0RgfvtCB/FclicKUPnX69zYFuY8Yq6uXmtRqHT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c1b97-31ac-475e-45c7-08db68cdee9b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:43:08.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47OAm3ZVGJIsipbjyKApBlYQ6S29m+JAPMCn0uoTNLCbPRhSnbOTn7HMrk3liAN/AxHd7VbjfLuCWe/fZJI8Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 lib/uuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 5cdfedb4b..cd3b3655f 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -179,6 +179,11 @@ extern "C" {
 #define VOL_CP_CHRC_UUID				0x2B7E
 #define VOL_FLAG_CHRC_UUID				0x2B7F
 
+#define VOCS_STATE_CHAR_UUID			0x2B80
+#define VOCS_AUDIO_LOC_CHRC_UUID		0x2B81
+#define VOCS_CP_CHRC_UUID			0x2B82
+#define VOCS_AUDIO_OP_DESC_CHAR_UUID		0x2B83
+
 #define GMCS_UUID                               0x1849
 #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
 #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
-- 
2.34.1

