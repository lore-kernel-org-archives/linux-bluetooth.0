Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8DCDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 09:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376896AbjJTJiE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 05:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376903AbjJTJhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 05:37:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE28172B
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 02:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foZOIFQh3pLrceY+fxIUjZ1gyS/e7Ftq5JNQPnRE1ZzhObrp+bb6mKSmtXekJIBfUMSMs8ZMgxPQ8Ftw3xAj/M9c7ZFBYZOnuKOgrztrtU+DqZgUPReeCdzyJ3COjS5sLlG9pVuPrIYBE8G5VqPdVAXERZrwxkP9EHFRdmwL9xs4C0yAw+e61wWAuWt13FDrsQXZeSMNRZNa26LHP0hNSWDBe0z8caztbLRHiPIR7WyUnNedfPKpiltU3Cls8lhPK1r22+NIKB/BPiZsSyKnNKYxKIN1ZD66sLqf2xTSeXgywuuAaijWLOX310eeFzVHOo6smdf0lG4/iWyT4lXkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCkB0Wa57JWtyIryV67jrEx35WJi2iIx2/wUnob39tI=;
 b=GiZK4XaL9aRiFJOC+/2DtqFgT3oe2SN6mIOndRxMETlJPh4XN7CTi9GvMp6nymlqBQnDHFczTjNqhN+8OK0nqjBgYXAyL1D/qnhLkORdTZCnSctEdjWMrwHaL2WC51+MZiSR49bw5gZjQhkMcSp7BDss4JJMQSX+ChQVQshNjwc68/02flQDbf31pndCVkKFKg7pjJ5s0ZF56X5PLG69t9P7MSy1Hs900TAG7lqE4b4+9gj2vSTh3ZAuG2WskqCotsowdWMCSdX19vfPeKiKO54ZZ+xc3Os5BneadNl54v1nQrO0WCJ7bf1Uuva80etSfTyFXVl4oJggdbF2Laz6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCkB0Wa57JWtyIryV67jrEx35WJi2iIx2/wUnob39tI=;
 b=kPLEuZW3tvBbs17WLcZpxf3WYRA9xE3x66hpwYEtWbov7Ws0ZZYVSm5bQOHhnsiVrjHYDwAV35GirVY/PAZ+s4Fdqj7MNGsJyp78Gku8dz2C89fH4JJ7ookMUW5qVaDmPclvHSCeaOJe+LIp6UfzLtB5EZthMAwh43odrM5CRpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 09:37:42 +0000
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28]) by PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28%7]) with mapi id 15.20.6933.008; Fri, 20 Oct 2023
 09:37:42 +0000
From:   Purendra Singh <purendra.singh@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, nitin.jadhav@nxp.com,
        luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, purendra.singh@nxp.com
Subject: [PATCH BlueZ v2 1/1] gobex/gobex.c : Increase default obex timeout from 10 sec to 500 sec
Date:   Fri, 20 Oct 2023 12:37:16 +0300
Message-Id: <20231020093716.9654-2-purendra.singh@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093716.9654-1-purendra.singh@nxp.com>
References: <20231020093716.9654-1-purendra.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To PA4PR04MB8016.eurprd04.prod.outlook.com
 (2603:10a6:102:cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB8016:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b2d700-3bdc-486c-36c3-08dbd15034fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okaAq4JblmlC0JqlTf3cM3Cib88tFOsSYh+/HACnz+zR1dclymGBzoGHwhjSD13/hxbSc2LSzg2tjGnmihaoCJ4+3N95abjRwbfv6aV/gnN09Fsx1v/G8lYOtsI/HeY6Lny84Q7Bgaj6mbw0xBs1TYUF0CHBwscPsbQMp0V3XEV8Wgy0y9t1cvYG7WQ4ZvdOKwIgzwMAGs4o2NTvrDofN5iv8z+VPLvoJGdQAMufAPKHv18eTJdh5qegws1/Qjk7V6zckc0PUymytD6jCTU7u9beIRwmmrg+ndT0F74QRUpUrAj/zhVC/KgOYdghRiqyxWwpZtDTEd8+3J93O/UwuVUyaTEPLKBczXIceC97MXExzXZaql8qkQAxmaWmldGETYZgDOJOTjJgtWbJ7tg+jrfmIz9NE9sQddZekdsLgPDBPLcKnAMY7up6jsl819aO0iwJSL/PM08pblQQHJ1XSxzBGvdQCA6bSF94dy/7vgZRXUxLmDcTV/hleiLEv++7ixgoLndeOAf0FYwj2Ds3X4lnx3TDgz3jio/B7qELWM1WWHqu2Y+C9Ji/sK3uakdXtOEDQXsg2/Jtp5FbuDelUnOSCXYWA0XMmsu11qcBgOlDmnpJocQ+gCbg23icI0Tz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB8016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38350700005)(86362001)(38100700002)(4326008)(2906002)(44832011)(83380400001)(41300700001)(1076003)(6512007)(6506007)(4744005)(26005)(2616005)(52116002)(55236004)(5660300002)(36756003)(478600001)(6486002)(8676002)(8936002)(6666004)(66476007)(66556008)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzxWPj2zBNJ1fj1pPlilwWGo1EcHDoV21lQ3wsN3utRoZH2+ZLsWJa16K93n?=
 =?us-ascii?Q?WZ/tXRWObXGOuTQStmwjNblKroPau6PyRMavwFdicqteJXQeHdNxZckiFXF1?=
 =?us-ascii?Q?o/7zw1G8FFmm27TLoDmGxkQ9tb8A2Fx1IMhMSYvlPfu3wWHAiLm2oEOocwsV?=
 =?us-ascii?Q?I2eylxFYv1W+uARB0Q62qwFHSZF9cQzkuW53itXfubTmKrolMAYlW72SuDa6?=
 =?us-ascii?Q?lMOKobcgcOE/PaIH0y7jjdYivxE7dRlXHseb7/ChSiPJEpBUOwZ8TXdCyujn?=
 =?us-ascii?Q?g1YtCGbON5P5jQHO3lYiyyY7zCL+VbWvkEL11owWKpb+knY0S6mvlhaMJuey?=
 =?us-ascii?Q?58KGCokV1p+OfgmxrbK14pS3Wp04y88i0lmwO3km06+yV9+PcHO+C0CEToT+?=
 =?us-ascii?Q?czDiPG6OihAbFn5inm0I0crZ/7vlYy150M9HQfOUI9xJyYl2hqvMFZq9QYz3?=
 =?us-ascii?Q?eCfRn68LF9d/bOJHl6NtqjHIfw3GBAJQz/N9t9+aREd3tmVcbIyPFhUdM9WS?=
 =?us-ascii?Q?hd8dPRbMn0rFk/F5/DdrEW/Vr48AdVv32Ou+M8nbb6LZKfrKP9TtB8547OF/?=
 =?us-ascii?Q?U9IUxBgXCZfgzRd+qF4RFW6oUgFcA1MNxJ6gBQilyw1BFXRYc8H6T72h2uhV?=
 =?us-ascii?Q?S7ehGH6oXfRasXn39ppdPxoVC0U4VnPCItcu76neIWF+6/0Y351U3rr8bZU9?=
 =?us-ascii?Q?vtT3H8Cj2U+SRgRbzHjhjS2LE6pblAn+0k4UZJetwjrgROzUoGzRCHFVcRYr?=
 =?us-ascii?Q?e90yVqlrH+Bt37s64N0E6vnNM0aIzvEfca3JtOKKAHPf+y66OxfLdr6ejYKg?=
 =?us-ascii?Q?mtklphwEo3wQy8LP5bjwjGLPJy72v5pgogGqoAnxiK9vChnAky7UX+05KpaW?=
 =?us-ascii?Q?whzWNw/YnyvWFd9DtZtHFhD2lI1gfSy9SdLqRtBdw5webnsLQicBRoHFYKen?=
 =?us-ascii?Q?3XM12DpRd7XPt314KYbj2KeB6AtAqqm2+XLsqIa1bCbQ21GzYoq6qnhDbVu9?=
 =?us-ascii?Q?6qT5+DS+PT7LPhl3eU5mNkcwOZO63+51cFDhticTq3dLKNSUpsGe2dqKO343?=
 =?us-ascii?Q?1IPDkV1pJOxB20X2W5sL8Fqf9mJxKqNkxYuGZTLtM2GgtGfVsegBwczV+Lbt?=
 =?us-ascii?Q?MqYAEilXksov4HwzXb+GAQ55XKRX8Y1eSl0KMUTw9vlXEUk2ov+rvd43xYwk?=
 =?us-ascii?Q?Ihhm0zC6UpC4ykMPnFQJXzi8COnuwG5UgXBnIfnxIzygUbZGBEfDb3Ks40Ba?=
 =?us-ascii?Q?YgzwG8tt6kOQc2D2lXk5zo1GF9BnEB+cD4v1ZIPaLLDmLu3aCxMi4EGn3vJ6?=
 =?us-ascii?Q?LwvowAZXSfG6pZE2MQuJuReYOE64CHs/gtIypCRC9Pe0KB/gJOFhlwK5lz0K?=
 =?us-ascii?Q?lEwHUTGKwogm7p6bCudO7aN/L7043E6FmHtPdTgD6iUIrVB4xMds7tw9VlMn?=
 =?us-ascii?Q?AOS+3Yo9bN18aMgbmotFeAUnDTtz6YY5MzPTUCADnh3KySr09auihzbDvR0s?=
 =?us-ascii?Q?AWjWWJFxQe5IXaAzOFtAp31CIs6C0oGzPFOaKPvz/C3i27d0bVBiEXRjXkfn?=
 =?us-ascii?Q?2e5vKEByRC/Gt+6uV2cuhHiuJviag9Lpd8FbKa75GtDGju4iCtgbhfiT3KjO?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b2d700-3bdc-486c-36c3-08dbd15034fc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB8016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:37:42.2741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NztFIDm49jdAIYSsERimPxHTb8Iji7r8gF5XF8jSl5CO7GA5Ir6w6yOJE2GWv4NOdkm7PdaADAOnwVOYd+ppnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This issue is observed when multiple profiles are active from
multiple connected devices: A2DP + HID + OBex File transfer

File received status of some reference devices is delayed,
that causes timeout and file transfer status error (Variation
of timeout is between ~100 seconds to ~450 seconds).

We tested with Motorola Edge, Samsung M33, OnePlus 6T.

Experimentaly we increased the timeout and at 500 seconds no issue was
observed.
---
 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index e9b89cead..f0e1c2c83 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -22,7 +22,7 @@
 #define G_OBEX_MINIMUM_MTU	255
 #define G_OBEX_MAXIMUM_MTU	65535
 
-#define G_OBEX_DEFAULT_TIMEOUT	10
+#define G_OBEX_DEFAULT_TIMEOUT	500
 #define G_OBEX_ABORT_TIMEOUT	5
 
 #define G_OBEX_OP_NONE		0xff
-- 
2.34.1

