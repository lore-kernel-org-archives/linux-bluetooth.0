Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3745CC7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbjEYPfV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbjEYPfT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:19 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC73195
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHdf18jPaytTciWXRsr3GgX0MA3xtzWi0KqhVFyN2DlL4G0EW4g4UZ8xQTSafz2AFLpnbe3BPrXJMeQ3zdCip2UkOTpcAQ75mxOz6O3RzRxm2A7zXqGyKqEgvVDlIZsd0RP+KZPE7fo5fiTKg0HOXGkiT59iXOHH8xkrxSDB3dMBg2E2zfdZFrlTXpgb0GRIOy50BJL5IajFTnjJDbo8DvmfHmfgKpXoNC/GF6SjauIRLww9CARqY0qGz9pbnpuivmC/mVcmtcHHfRpJX+shxwO7vMgcYqQrMDZTiLxv/lmiKDSwelCOCsPvaPmXTZWJxTdnx6Av6HKXVgLIiPJXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwsghK4GbbCtstfoKwoYB1ei7+mnLVU5TUDPQWncwL4=;
 b=aiQxt5K8KwAvl+21Q+YedZBT1yeu0srOnsVO2vSBzs0sCopoZLDksN789/TEqwOmfCooV0m9BGdnrmbTo0cEjSwGkuSf0CVB9XQzq1N8FXbDuErFw0QTwsRYyUCt/J8IKHnRfr9xhWPX4rg5LO6HpnGuRXD0AQMFaEQTGe+oSEv8oAZ+FsitWhB2llJvCAcynhmr78h/+fJFdTr1tfUTtKSkevBkU8vBeMPiyg08qkFRJb7w6XFz1kJ1h+GLpfobV/CVsI+pHVJ0loDl2TT88cpqJjLSLnEv2eewvoZWhLYWJsg7bywjnY9s01uzcUeBeDENekcLMg+vk0qhuuRY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwsghK4GbbCtstfoKwoYB1ei7+mnLVU5TUDPQWncwL4=;
 b=fD4517wDLdnpY93HBYplvi6sG4zwreDr/uR6WGey2GUwCLoBMw1tDZ6GJm8jL6AEzJUe3BYuJ6HpNd38VlRiI5HCxduF84IFIME/Okuj+uw4zD5pWi5eQf4YxoHQ2voWT4jM2OO0jYEsrDfybTkQnJMW9fUcpLHhHLcBG7+C5/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 15:35:15 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:15 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 3/6] Check for ISO broadcast support in controller
Date:   Thu, 25 May 2023 18:34:49 +0300
Message-Id: <20230525153452.125789-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f32ff9-553c-4c89-7c82-08db5d35a326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SDpspk9F71issvkBN7lUSx70EQNKYzoc6O+Aat4MiFPNeQwHY+x5ZQzonosOITLE8iF9492m0vJ5uQ1rk9aoYD6AYqrNJZiCkb/qU41VBX0+Ab5AYiTq+eue9gYNA3nORN5zFYQpFkcSLVsTxDJwTn1WbcTYaGSFe5XhgVEW38AMBMOQWFjSfreVhuUtMEqkyDdjB5NVtDjkOzNB9cINhFlKhFFxjGjsd9Htg5vc7KxufQ4XAlNRlkIZdkOdyAesxn1ZQqm0/CYvkNIAGt1bo8XvsXm49pPoYyJvi0BDWEEyeUwpKzNfsFS+kRTsUtuSd6zUB7AQiQzziSgpXDAWtJ36YzZwhvm78XXpx9aw6jQRuISqJVMEuaZWWs7ydg8ycIu/LWEJJkxGRx9lspsa9RmUtHGILHGyYHDOMiE12UVK4bt/YC13fZCZD2jXK22e1ScaaybrnFie+8a8AzppP/si5J0D0Qo+d3kYXTWhIwRfyGnyWTcpN5ZdIkkl4kkCWXqJklqQw7j4JOr6b3rjHi0q3PGC5V7eXcNM8/CJ3YP4rPG9wkVXiRarHJVD/pJO1oynrYKULInH7/qeSr/yFNmMBDwPY/I5hS5FhHaxSjJh4TXEli5coec7AZ6zoyb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(5660300002)(36756003)(186003)(2906002)(2616005)(4744005)(8936002)(6512007)(1076003)(6506007)(26005)(55236004)(478600001)(66946007)(66556008)(66476007)(6916009)(86362001)(4326008)(8676002)(38350700002)(38100700002)(41300700001)(83380400001)(316002)(52116002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyAZBen3qA+d2nJwBSXVUp2NQrq555qd6ATBrFqK2zAcfK87hjTs8gZ5q23e?=
 =?us-ascii?Q?adw1aZnQxaakr3rBvheAZsX+XeeoHlTezbHFd2v6EwxjL7PNbdd4xUNpXwmY?=
 =?us-ascii?Q?bwAwK3xyZp9l/vZ3QccMksS1MB7TKNi1uwtmkGZ1T/M9f2+EMC6nVZEvTCy/?=
 =?us-ascii?Q?2MmOYzAfCyxBQNhSFZwzSLMM5nQRaE19UyyHBrgMqBQAOBigx0dYIO53Xyuo?=
 =?us-ascii?Q?N3Z6Iby9yjiq0JQ9e7F/bOMo45JaFLiIcLlGYGn8AqcCF6sNLMHeMiemwLMB?=
 =?us-ascii?Q?4nM1pzl0Gj3PrRBO/o/t1UV9NxzOqZBmFKGzCqzRNU2xYRrQHLthIvHyqdCI?=
 =?us-ascii?Q?cHPhouVI0cRTDKCxKKjQrpYcXNQq35NY6ghrXFalkp6gWs+QPNi6BSSd/C+q?=
 =?us-ascii?Q?2iuhBNFOlRvlabkvKgeXga8Fbvs+ZKB0+HWS8UqPCW877a+Be0Jk0Hb972Hi?=
 =?us-ascii?Q?qeyh2Ik70OjAheCv7polzFdWy7v2NC9QPC0RADEvpSq7KNgyTCfTsdbE1vB9?=
 =?us-ascii?Q?Ij5Q8QnwSLgNfH794RJF8j6beEbgzg2eE9RfPAZVK7SBzn/uqQAtYqtS+Ixo?=
 =?us-ascii?Q?9N9CHslPXDSuHJf5jbYv2nS62W64w7aMjKO1zO/1hNBDSMc5XC3Jrhv/Yyw/?=
 =?us-ascii?Q?oad7hRvbCXdt4QYE4FDAXidmfzFImjXWqYWTu9jbSMUzsaa5f8jbOF/qkDUJ?=
 =?us-ascii?Q?Z3c2kQigTMXVkZMC68C6HzIt/aNt37Xj3cyBkEdVZpnz2iaJ49q6dgDLi4Cm?=
 =?us-ascii?Q?PD1X9xF/8tgT3ZUSmxH4fLM0iCgamE4B3Sk/eWypcsHjq9qKP0oMXG2fsqFv?=
 =?us-ascii?Q?Xi3v5ATxPUJxHUQWQBNgQn/VUmda20CwqnqnzCx6veET9owbUbC6at+CRIcl?=
 =?us-ascii?Q?DkmwOo6mk+ZlBbXVMEwqKmBkjW6VtpVrd5k9sCgObroENUdCTGZb0dyPc8u2?=
 =?us-ascii?Q?8rEDvb+BnQgyyUU1B2nroHEMdyn+MHASpJ5GjVC3h+NpnPPFcd1anNa1tttB?=
 =?us-ascii?Q?wNaS7/caNRtHMUQnMh1V+AtMg+l5XLKX5uX7zUIhtn759qQp+YS7ZXkmQ4vq?=
 =?us-ascii?Q?huOJkyV/MMG5/XJGFq+DCiTVRnPzZAkEcqATKPV2NqEx+cnk+Jxyxg9ngIUv?=
 =?us-ascii?Q?jEXvig8diExQ1U+Z4BdgRyIpU3yUeKp4lv11VI60LMnWThrFvC+kAydvoY0v?=
 =?us-ascii?Q?d3GF2PUESr73ZDx9KXp0lQHWnwe+S5bm1vlGcqzZUh2EBQvkS4gw3nqOc+L7?=
 =?us-ascii?Q?2TcOobSFdw8ZkCCWkclH7p5qJldsdB4xydIYoLtlGJ05NuuHJuf7Gy02nsRb?=
 =?us-ascii?Q?j2C75Sf31sdoqkM8SHxHreVZM5ilXuBQa61RbxiUTHkg38cBNJV52EFsAyym?=
 =?us-ascii?Q?p80NOPAzlXI8kZWJDetPE3vfVciXvXnMTxC9y9f6V1BM9A3j8GBMkPKWdG/a?=
 =?us-ascii?Q?mzm0tgBwHWBhi/kwKSGUH6ACGdeW62ANIOcrAcNKdNsqeKQ/L9mbT/cd3fdb?=
 =?us-ascii?Q?KMhtB96zVYmdK7S+yfN7TmgfDpzhiIh/if5jeJ0bSPJeBij7dUuQex1kuJM2?=
 =?us-ascii?Q?c81xtjhjnArmt/fjFKb8mS4rpO6x/iB3wLxJTp8mKtcfBp2m2YO51JHivhw/?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f32ff9-553c-4c89-7c82-08db5d35a326
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:15.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Oi3iNvjNbk5hN8hA8uag2vbqHmJSQ0DFgClTykaRubLjLROC5qKSTfFP8c3Nzim6GIE3sqFhwIrjXhHPsb0L35uC403oyzWHvoeh47kYKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds bits for broadcast support to mgmt_settings_table.

---
 monitor/packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index b492b8a75..429df79f1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12796,7 +12796,9 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 17, "Wideband Speech"		},
 	{ 18, "CIS Central"		},
 	{ 19, "CIS Peripheral"		},
-	{ }
+	{ 20, "ISO Broadcaster"		},
+	{ 21, "Sync Receiver"		},
+	{}
 };
 
 static void mgmt_print_settings(const char *label, uint32_t settings)
-- 
2.34.1

