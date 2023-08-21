Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97DEE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjHUPv7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHUPv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061FFE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXaNk6GnMPvsPQwVqUR9szloMxzEfnnw29xY/hUxESn1Af8g5iOgZ9G9sU2JIDijTWf3dzNbfHvq8t1CHJOmd/zvdl4DorisLzQ15aJ7Fydm1PgTewFJtvHQ3bZqGdmPX2NPPowU2nYwm6eCeoBYedFa8K1+1b57Ov6KI600IGyABpDZiX83X9EODEnuwKrAH5Pw93WJvA5MJYIv/iPCdPQu0Pj6DX0OFyxazX//qcsc/sIdPKiGcSv1D+SAo5/upqNlPw332ObnnJqYRGuLT1IfsSypJrvQnNHsj1tEyF8EMCZINHQ8wrBIZw0ahFo1xyylPEXXu9p9xswkdT9kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiF1ouM49xxIFi/dIK76vtBldjOFMJOc7QnnmzBaf2g=;
 b=Ce6TU6n4LI+yHCFO3z+AofW2hS8YA2+HmuhPKuGZGSDuwrKwDvfVJJCePD3CLG4cdfdC5HQKrV31IUEh8Hx7pwEgGjh/AOIYAePiE+s++Zh3wDWTxVqjyaxeBxJQXZ2fTm1rJxIYh/YqSFQ7p7Pgc0w5HabkqoZQg0/QKvZA3I8AeVqaOV6/OplWSceoqQxQPd4SKUfnoV78jw9JbOgVPgr2tu3CWzBPbwsjg8dCqRYhq+ZN0OmY6Dm8Y+PoFCRSymc4OhbvTlPitcs3kLVRoXSidcg27RrLMeNSobifOEZ9syeRKjX2S7LhlzbdwqNfOtTZwntPtJe25W8Sr83/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiF1ouM49xxIFi/dIK76vtBldjOFMJOc7QnnmzBaf2g=;
 b=ZgAZCScFEXk3RIFzUIgRBQDbH9XJiYhgV382jc7tl0TBmi2KSZ+G9lJieOdxxLJS0DC7jkhF1njx1h8LX53M1FCbON5zFukYChDxUKACELgesy3xPNdnPefwz95dlRO2yksxGZ1hQZ3D4iNbASpJOfAEdC5AwkdfJb/Y7x3zbXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:51:43 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:43 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 5/6] client/player: Remove Broadcast parameter
Date:   Mon, 21 Aug 2023 18:51:03 +0300
Message-Id: <20230821155104.86954-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821155104.86954-1-claudia.rosu@nxp.com>
References: <20230821155104.86954-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: e12d187e-2ea2-4667-e79c-08dba25e8469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyyZfxR33xKoGwurVl1wuFmwupvh5dBC+B1cYOMQB7gwitYjytg3Vq0leTYS6YQkoyfrwhkg/A9aeY0EeeusTzVVnTD7S+bLVn/RhzoTCqbeRrIO8OUKbvY4IVLTkFa+gA87u+95cpCCWqQu65x3pTvkC3Yje+M/gwd2hErYwNCsfljPAbwmr0mtWzkYMRYkiJmNHlFJt6iZtmfU0NZ+0JyMq2TQoUpfboNzTRdYNmKzM4bJg/2KPK6sgYqyICSmD/RCMJyXmndAaSmAvo0Ivmy45JSTMbevlW6+X53a4Sg0F6mhTgCUPNp5XuWE5wT2UUyK684B0Ink+QRoFloM9T17j+S/9aR0vW6ODpqiLSms2ilSCLyXHMwoezp4imonFv5maDOPDtsZV5Pje8jHNEgsIn9+rrGUf1l69T8+9p/J1vksvxEvHXuP2xzie7cux5iRgyeW9Ng/IX8c1j6/HcOPlJGueIAYthkrbntqHFw7GxjJc2OeQgswzAWi5sfDWc7OtUdgjs1NFmbNjqojXa40bblQIew5UzwxBSU3zdrYjsM+HLFTMljPQS+G3X9G6x2SDRtfNjBiZ8cYI1hZlGm0Xe7xAyrxQ9fVyLRNVrcGafrgmiDvhjFKqrcUITLF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GROOW9wbzmLatb8CBI0FaSMbqW4iO+dWzko6RQjQqBJZTj4eX8T0pa0o5f/O?=
 =?us-ascii?Q?HBN3XQqlhiB9QoJm7rGNmabLgDA4aGdQviKzi5IE+qFRIgDnHmpo7LVMHpxJ?=
 =?us-ascii?Q?QwZkS9lJEGWaHgnaD1wodgw/pT4mUxLg9IYR9khGCkXLWR9bgGFJHbbHPX+n?=
 =?us-ascii?Q?dW367Mfo+NNs2fvIdimdFeQL1wB14ybmliX7id9tvmhCZmSSTq1GxHljhIbc?=
 =?us-ascii?Q?TJ8pMyrDxCmMqNMzBPiAVeD+RVq1V2UWNNFOjPpRpnvHKiu4tYvPKK9vcSMR?=
 =?us-ascii?Q?b3W7d6/ToSEfi+6Bx/rFJhY9NoPzEZFKXwuBYGvChdH4EmCemz02OEZvLKKq?=
 =?us-ascii?Q?tUy2cvw9rW7Y7KB2p5/SgSACLJyT33HPE+/DoTXbDn045pgcD7nVaX7AQ3G5?=
 =?us-ascii?Q?rQYwUcfq7GgWibyfnzqHxNCjpJDwXGAIj0gvR4imweOcbNpkr8OKRmONOtfK?=
 =?us-ascii?Q?MIGCRZJs3Xo8BdoBPyuOkpkJsrxuyDU2A4+tHr6CNUMcaYn0jN9H1VgW2B2E?=
 =?us-ascii?Q?C2JwP3EUkwTKJPAeSAwVAinS4bsGeutkRP0ysbKlDXAgYhxGELPzdfOQf6bF?=
 =?us-ascii?Q?nOWjkNn2iQuJu8ENO2uwO6vGdyqVmtFodPyM55S2SsWzgXZJ791NnaYyTOym?=
 =?us-ascii?Q?FIVdGwcVnRHiSTx2akxzGEkSAmTY2gEBFEZ5qRTUuAZGdqmfcyunWojf6n45?=
 =?us-ascii?Q?GGDGSH9Bit7b3Jayd6bSTj5P2D1WE+/FryTm/Q13gzZY+IS6PgIqwIxrTOJH?=
 =?us-ascii?Q?WXNIgFU1KA1fKJQSi0z6mSw/MzRoKPe1Rv9EwFmqrD4FyDhkrwGfEIfGi4px?=
 =?us-ascii?Q?xxG8xcZn3yxqrDRt/N2/qKc26TjHzcw52j4mpwgeEsFQ0QRXsASndGOhnsXt?=
 =?us-ascii?Q?QsEQb4sgoO7EIruxC9Qt0IBKEUurKfcp40c6n3xPlUrP8fwuvkub+3k7C7yz?=
 =?us-ascii?Q?zk9svIYcPw7+Nz8fGj7crpB5PxVTDFFrWHJHy6OcgDqTXxTQT2Fv+xN6KrAH?=
 =?us-ascii?Q?fZPAlzFhHlIa9cUCT/mhoEbZ1hpRSjvmwv8WCdC4GQIEWdv/NFnn5CW3CzTb?=
 =?us-ascii?Q?GZ/qHfXKnpiQ+6PhhAdW9jE8E13+e83tZsj5de06csTS+EszYujzyrfdWrTw?=
 =?us-ascii?Q?BygYTuInOq83nRWhtyaIZGSfywrPEd5ww30e+k12JyTkl3bgaO3q74cNorpe?=
 =?us-ascii?Q?cNtboVm/fhzZg3zmI7HpxDCGXLop7g8uwLW/xjK5mZlNMrVgOFQxqSGEkQ70?=
 =?us-ascii?Q?JuUVjZkyUga5fCv7fwdTzPi1nWpcWU4IJEnIvyT+ASDENQY31oDyWwem7MVH?=
 =?us-ascii?Q?J8ZyrUjdeYdwgXD/QtdH6VL7LB4C3zfxpyMFrDBcYQId6kxHMwinijkkhTTu?=
 =?us-ascii?Q?BUvDe1OLBN7n3McWuw+QEP3Ju3P8SjGtPbwEQXH1SpqwsuEndeDWU4VwPBPs?=
 =?us-ascii?Q?im3+4P3s61YSuLShEIxuKDGAIGkbMy8J/5JbuwqxPIp7vtTQm//Aq9/O9Noh?=
 =?us-ascii?Q?YnxgblipjZT7EDNW/KqkOPxk6OfPoJxEP8LQXcDhZDFMhlSxhvBTbeuUavp0?=
 =?us-ascii?Q?SZhBaXA3isSYnEqNO0XD1H3Q0odpeB943XDiKc7cg1mq36P2WcxMXbibYpLx?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12d187e-2ea2-4667-e79c-08dba25e8469
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:43.7335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1i0jB7pfvEHbD1d2956eh46oEAKs5vPFj33vckIurROugAsi6uaUI2ZwebIjrkIN3w//OC+g8ZEDQrd6UFihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove unused gdbus parameter.

---
 client/player.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index 3611a8dfe..38590405d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2297,9 +2297,6 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
 	}
 
-	g_dbus_dict_append_entry(&dict, "Broadcast", DBUS_TYPE_BOOLEAN,
-				&ep->broadcast);
-
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-- 
2.34.1

