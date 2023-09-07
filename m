Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B37EC873A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjIGPmE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbjIGPYW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD92E66
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPsQMALSYIS9LYxtHzMSJLPYoiNcV3YEtEUeGXCOuZP9c2/nHhKWnKY1JPYMkKZSCQBKHkEOdQdLBxWufMkPaKDv9MDjhPmYJ89nNewdZG81FJ39SQ+jMLY1UDnmTa9ffbGY95a6AaooRL89llxVQsBpaWMpTdFPueAXOUCPn1W8Ri4pX6B4REwDfSyOsJpT4lV4iKXfFo2dyNGJsY17/DLd/OICP5imOs0fFZ3bQkDy/qDCWhRSjjUzzWBpjiapNU+95MsQzVVZvELxCOmVeETQuJlR+8jxYzmCcZkQabSCEma1ucy0NdppwiES860h8/17I5GNICccMkTKsArVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16NfLCBZnk/qFbwvyJzRC2y4cIcGDt56EekY4yh0lL0=;
 b=hcPTGdMjhBFx0k8z6uSnNOhuGX/p142vzxwYvsk0gK860yKMZTmd6TGcfRe/E9W12mrJztwfSJN2ZbmVQcJibuHES+Xna1yMURzS+apc6c9fg5wa+bDDlrN1V6YpSYl7rIxdYuXCSXusKm6nAC2jdui5o67Cn6MiwS20/FnxbFntw1EmgRfZknIzEIDbLcczuTg3j2TzrM04AZ/HC6J3bdO1KLCoUOCSqQoFhlJkDgJof0kLynU0S/OZZQhkb7hqQMiSuwtTw9bvZaBMGdFfuVSlfRikPv8VCmv53ZT4m4SuiAAiyzmaF2Ko+D4VNn0HnzahtX1hDWreXUsU/uwCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16NfLCBZnk/qFbwvyJzRC2y4cIcGDt56EekY4yh0lL0=;
 b=T2InO6hwNL1wZyh2OuLGehXEX/sR3MVQUZdK9vm8+1QGnkEhDEhi+I/Tc8lKtcAFl0fFEMor6uo3gOYaZ+zE1IdGdtCjuv/xfq+yrMwwJi0MKG7nWTmdBOSpoNogFjVFip14i83ULrMTTWF6UZQUYM4yieT/xzVVNBjYOWgfIwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 15:12:55 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:12:55 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] monitor: Fix ATT decoding issue
Date:   Thu,  7 Sep 2023 18:12:28 +0300
Message-Id: <20230907151229.7306-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
References: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc492cb-a0c5-4ac9-587c-08dbafb4e973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqEtYIZjO7pH6rTfPPhxj5oRGeWEDlE9bDzzUKWRjLk+bnvS+2gGJvfZXuA87i/bU9TLLKGm0cVrwfdmqMVXkQycW/38naejI5Vks5kp07hnAc2E+glaACok8QIVFoMtMakn6rfDxNZ7LegvEZwkko/N7/jZI4vEJsBxQ7KCxPkhewlGZzIiXKD9AajZHPX8VyleksCSgqUx7rQajBJohTZdAjA6jLoiIGRbRPHykIOmJN0MyZi5PSPjr25mvJwMQq5Ql5iWbbkUd80V3oV2r4baJd4Im5se+dT/Ikljz1mgYgZLdRQK8P45h5E6fyIR3x5MiIS4UjNHLHwXJ9119+2IVKxXcYnhR6O9glYJo00H+BgTJfkt/m4kBYMLIw1hrba9kHAA/HYWgIAcLu+/dEYAvPqVzr4U6WYKqjYukVFg06DRMx43tRLQw22b3lhpB/R/wqmxi6e8gnduJ7VFBxGH6p2F19TRdl/dTBcR4T3yvJ6IbMbMirsb94l+gsztV/3XqjvDzjsTjiCVlCKp6eZxeXT4hSn+DHFdUobKaW85KkCSqbuXVeuiTsct0rNRBUCeIQedJNy6KnrSczT3fnGw3hXyOptCoLGayTOd20X2BwGGl8aPMZg0qoErx9Fv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(2906002)(36756003)(38100700002)(38350700002)(86362001)(55236004)(52116002)(1076003)(4326008)(8676002)(8936002)(6666004)(66476007)(44832011)(26005)(5660300002)(316002)(41300700001)(66946007)(66556008)(6916009)(6512007)(6506007)(2616005)(6486002)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3bAF/Vx9o1DBIrZQeY6CKPF/Su0wdaUxiu1aMEo1OWoKdi2QubNM8LjMNGHf?=
 =?us-ascii?Q?J3v64kPSE9AR4jALuK+MclARfpXBmeELKBZIuqXocSbE6L+NlAcW837WqXAO?=
 =?us-ascii?Q?dG5itUbnlepiL58OYyuR3GmQJJEIRK02blJd6Wprnb4LgEpDK55dfg+ibG+V?=
 =?us-ascii?Q?5UQl0p8bYXvtPsPOwoDTdCVRU7jGc1AddYO947YTsZf1fnOZdmQWEwfHCifs?=
 =?us-ascii?Q?/jNDAdhsIl6Orxf/WxRduVwmOh9frd+2vqQgcJTWWXoE2bRZ6wyOqngAqxOc?=
 =?us-ascii?Q?bvOGju0viWTJlNHfBnnPGK4KofUYhtNEsCwxyKHb0/B6sX7j3Ufv2+6uNeBH?=
 =?us-ascii?Q?eISjss7XUuaUCUzb9LimZvtHtEPN0Wk2fOfKVuJjBMugtlavMhC1JcR1s3HR?=
 =?us-ascii?Q?dNPjoO1hi7M35xK2PLo2t+IN58hNa5rnUMMCYptd1eC4pD7d7OmkL3NTzOBw?=
 =?us-ascii?Q?i7THKfjvayPnYIMxr1w/p2WuDDllmCMi670MeCw7elSI/oBqfjbX3TS9DbMz?=
 =?us-ascii?Q?oAhJ7R7BRHd6ynEF3cfrKEEqyItRbckA/uehpbH/HOOGyA+CXTgBrHjybEiQ?=
 =?us-ascii?Q?Ph9LvpZ2vn4JHf2/87teH61wKltwqNNPGPMV29MNPpe5y2RApSJp1U41R10E?=
 =?us-ascii?Q?Se/6Sams/CeEh/mY6tMM6L4eIfc82DA2DPuofV9MpbpyioMnm/Byx/j35Tg8?=
 =?us-ascii?Q?DVp2UNIa+pH1k2Jx2frTldoPBg7i38/JYfzhT17yOINC/KxfVFJHcGi+gyR1?=
 =?us-ascii?Q?uawVxBUx8vi+lCgT3MLqE9/GWAsF1vq9IQfDnehbhvdquZ1pi/0+KyDlYMXu?=
 =?us-ascii?Q?u0tyu+Wmz1e+t2FKB7MLjBDvf+87M/ACQkiUXZX3pobXvNnflKgKm6Gkq0Jn?=
 =?us-ascii?Q?okF+l22HClwBjgaDQNbrAzxGjUgfOcUloC+tpwBwemzEE2XrZopmVNGhBmjl?=
 =?us-ascii?Q?aFDnk6nC3XV+j7xJmorcSOIWNwYc/tLDc0zjoIgg5MwuwTo9wCpWn3kommya?=
 =?us-ascii?Q?6WRLVv0E3YlbIhXPxVjO6nPDGqySTN4VD92l+cWGe4svJlnSk+Kl4Sh7yIYx?=
 =?us-ascii?Q?6kVInefJsV9tOgl0yp/fSGBU3Ga5U7sb7pLq0w3i4Jb6e5NXi454/8rdgFda?=
 =?us-ascii?Q?gIkdRj64l2WF9o2FURsYI65GOSDgHVkSyyyrfmiccHVAR/htg0yQNdE/cFg8?=
 =?us-ascii?Q?zqvqtK8l2JwqxF0YV/XjOdSmkScE7KPMAzuGBcdhE8oWC8+Amd9Mw3091h/C?=
 =?us-ascii?Q?O53sfOj7/5Z99/xPEFVUo/SiBJca8kjOFnMmeScZFxYcPgq9+iGzRifo8Cke?=
 =?us-ascii?Q?z7D3jM5gtR4faCaPrdX5R7J7xrnBz5PK2Tj+xQemw+DKS2WEpu78ezTB8t5Q?=
 =?us-ascii?Q?kgUyN4HaVCmRjUhIkVaOxvYtVdYSeW1XfB2nSJns7hZxc1o945PmmpFevif0?=
 =?us-ascii?Q?S8KxP9OPbBgVFE/KceX5caBB5xn9w/vWOjW9e23TubNvGsnllGmeATBivJel?=
 =?us-ascii?Q?/lQdG5MMuq2Sa6mmWwmwOAhwrD+IDNKkjKnPw4GvmAhih1ohtRcDQ1kFnHh3?=
 =?us-ascii?Q?ojDf+bxk0uo9JBOF3vh3o/ZPJCyNmO9lkcqnH/YaOjpSRGMwOGleKDP8ssTP?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc492cb-a0c5-4ac9-587c-08dbafb4e973
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:12:55.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8atDxp1tQnEEHTJrux0NtAz6dJVdQcupSdWuqXRSxYZJF1YVv5e+LJ9BGcL6nu+2YuuKbiRXWVNIoj9y5YgIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the way conn handles are marked as unused in the
conn_list array, so that valid conn entries are not overwritten
by new ones.

---
 monitor/packet.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 279f5408d..f88a11539 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -172,7 +172,9 @@ static uint16_t get_format(uint32_t cookie)
 
 #define MAX_CONN 16
 
-static struct packet_conn_data conn_list[MAX_CONN];
+static struct packet_conn_data conn_list[MAX_CONN] = {
+	 [0 ... MAX_CONN - 1].handle = 0xffff
+};
 
 static struct packet_conn_data *lookup_parent(uint16_t handle)
 {
@@ -192,7 +194,7 @@ static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 	int i;
 
 	for (i = 0; i < MAX_CONN; i++) {
-		if (conn_list[i].handle == 0x0000) {
+		if (conn_list[i].handle == 0xffff) {
 			hci_devba(index, (bdaddr_t *)conn_list[i].src);
 
 			conn_list[i].index = index;
@@ -236,6 +238,7 @@ static void release_handle(uint16_t handle)
 			queue_destroy(conn->tx_q, free);
 			queue_destroy(conn->chan_q, free);
 			memset(conn, 0, sizeof(*conn));
+			conn->handle = 0xffff;
 			break;
 		}
 	}
-- 
2.34.1

