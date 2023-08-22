Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972BEE4996
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbjHVOcb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjHVOca (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818E1E6E
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmvwcUd/1WKkwdTTqSBgOdadVbobNZzoXqqa+oHBkmDL6l4Kq4GxMJwAQ2C2NtgYPQClWfdfZN+Fql/txINJ3rvewuGeMeMZIr6GZFCkHQI/NaNyDMPG33pp/YhOnzn3vFzRl8UuYTeNrnpQhrsqbKBDbR3Sxf0wOUpqNKfOooEqsEvPUR+VioJtRq1QFGhgIJXsSNAiGgVAIozGwaqXYkNmQU/Mm2kbU+KiZko7/x845bXSTJwH/rOpg5CVJoxcrpgaVOHHBqGVpBSINxaeN3c4toFoqYZ9qzGzFO1DSYjIiPqstUc2ViSTJV2bwyqC9GJfSFCab4YsVD3H8bKLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqBQNL9+mGBD7pt9UrpoAb0LPBXBcKno0/KVktTLh6U=;
 b=KKXYYgJH9trWj4kkWIzwbrpT6H9YwlhHa1n/DdOayHQmc9lhnDdrnUJ+rM1s3xOFoS9JDuomXSzE5+drcpnf3RokvlbxkXBISXq2ryOQk6cMsgUvgZkGJVl/kuJJl4fZKHrS8o6H5wqed25Ii+eAFmXdbequBdvSwhrdRL7A5JZbKzQBeHNS91J2L3gWV2wSyoJ0VWAF/yDfsa/FpfxEt2qDURFkVrY9jn3MZ7607kkgaP7oZv4ukz/PLOIXoWWfJCV1laKDRoXkpHhbP2GZFkgwilcMmNaHX4bt0LO9VxyoPfhymDcYWPXdfScjOCSAlnWwnHAjuSOwd+5xAjcNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqBQNL9+mGBD7pt9UrpoAb0LPBXBcKno0/KVktTLh6U=;
 b=fBBBLNLvVlIio8XcmCarx7wrC93cEspqa4a2xtPp3IVlVWoE9ex3tLCb3sxgEhaEle1o7nUHCuIhH7ncpVDA/8+TC5I79ldVNBk4SBw0kPim7AHdB2CvY9n/uhOkdaiA0WUBo0/WvZn/JV+RWCsMCxB0KAtIx2Y62zaHNmP2YlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:31:59 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:31:59 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 5/6] client/player: Remove Broadcast parameter
Date:   Tue, 22 Aug 2023 17:29:34 +0300
Message-Id: <20230822142935.6016-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0256fab6-a77f-45bc-51df-08dba31c8b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmbduBLS9usmW6cSY1Blpz3t7OUK2MbzJVCSxDGKnf9yFXaZlxIGbEot55IgPkD40MZrlDlSC9nlnBISvkKXghK0Ylt+7Pxy4DngB1RkzZBM6lKg86yUcgl4ceBYsZWgDGRhr6BLgZUeRBYs257pljArV05MtmaZlC8lE3fbOAm2E/kBbYdJpIUZbJXxojc6KQ6rq09YFijhhU6XyHaZu+Cv4V5mpK1j192qtgMGI8ZRmSQdybXSvv8qqRWwzRezlDCC9xWb19dWOEAiEHwN1Fi4ZfQtGwFmlHcnK4Pf3UrK9Vm04M6lFKf9G+8IMXeT11fajWP5MQR/jN5ZykpxxlboTvW1/fhz8uUHgTZRv16v38jEQAvp0AzcWe/RlXFOzJGZhJGfyvvHQHKht8JKlQ2Vl7CdYExFtCrtVdk8t7czxyLDPMe4HkXwZ09NG9p7JHPpYcglMA3vFJy7v7nh4Dl4IxatY00QJeFu1kg2Lv6sAxUxEz3ebcBoU4iam3DtCgNvAih7ZCR8+uFGDBcz6cIDizp2MOk6BHskJ2r+8JYqY/DewVTpYudWadp/LSRjPWMFKM3cQeE1NI2QLs3ZEHMmEgd4/jGadkZoGDe0zLJ5qrjMnvqqbo6+3v8LYHe7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OWOW7pyIp3wPrfsIWX3k2aIu7k8GM9X7SjQLECB2KLr4JJay+24StYicLCmq?=
 =?us-ascii?Q?cJmXLJqDdVn5FvfzO4v+uHicTc0ixmvxz96s9OYChMm5klIW5G7vy/HmVH9V?=
 =?us-ascii?Q?n1ezNcMJ6EvJsegkg5gdKI1/Oj11EkP0sDveVCajXcJWsKxZy4u1HCfUU1WK?=
 =?us-ascii?Q?W4uHLdG0A/WMb400nMRHuqfTlon20mD21RdHilVOegjK0rWLzmduU8UnOVZE?=
 =?us-ascii?Q?dkvzOH7zzO7sr9kaOKZpvg9wsdPTX985g9idFhsOatdMpN1Byxa56Yyy1j1B?=
 =?us-ascii?Q?flqMprZWf9wAYs1eiUWz9dKz6ejtACQ4cvRWDaWkIc7atNeIi1XgnHP908ws?=
 =?us-ascii?Q?Oogm7fw990nMh7r54oY6cjgMod4BlAv3hQ0n491LhzXqb5h0Yjm6+T5/iFRO?=
 =?us-ascii?Q?9uxIsR3v6dPlQqSOkNZYnH5YRNSdTkX9UQ6VpHipb8YnNpwRTQli8sAfZQ+N?=
 =?us-ascii?Q?RQYvZMBbiinVkduI5rpSUtLmEEySiupF54KWS6Aaz45zy/YouE+EB8blRVls?=
 =?us-ascii?Q?wuWKidElpJoGRYJHaIuJ5QvtwWtAn7ZDcN50RZZbh42P17YAYEu+5UJoExCL?=
 =?us-ascii?Q?f96IadyaOgw4Osg9kT4TuYYR3HD+la+CX/d2hK91YqWBnPeALOmmU5d5YHyV?=
 =?us-ascii?Q?PAQ4qtO8SzuTipwInytlF3/1mrYnTli6vO/NXfS1OWb+mxfqpjCrA97Adoan?=
 =?us-ascii?Q?ikZKaHDMo3+DKgxFQQRbOavAdrTEC4zEt/cAdjZdnpXX/g9hLQwZwv/fg6xs?=
 =?us-ascii?Q?pAZskRoe6ii91vnsXA5qTWbYqh9dVhi/MBe4eDrTKJ3YJFNEMeTqlAY/nuaa?=
 =?us-ascii?Q?ZiDETdjDScmk+uBmu/VVTusqJYH1A0Q8aDPbOsjNUWFdZJwHtuaWMO9KK42a?=
 =?us-ascii?Q?eqNiedj4yNPtk6NrCdZ2C+IPZ30uYnbgUqXxYHG+I6IuCC2pUVxWuxwHmEdd?=
 =?us-ascii?Q?OeDhgkAAVqHxXK+Jv80yXoiG9lOFUosoB79zmWGemIR2dOjrgb7AljwXSi1Z?=
 =?us-ascii?Q?xkMe6k662KCKcCRtDe5fk8DMQNk+elctGREelmodQ37XJ1UPWe7I8HbNMG6l?=
 =?us-ascii?Q?w81MfT8lrIXq+5g3m6RviQaO38glOyryeCr6eaptbGw5XAMmh2Dwy+DQZE+L?=
 =?us-ascii?Q?ot58++RL99UPnI9q3aMigk/VqVrmhI1ZowneBL3BZK/wmXV/M5SERPqcmoVV?=
 =?us-ascii?Q?NM4b76tXgm9TT/7koRRMVH+Pc34PuLKZXuMawe0oHWawxTHmDtrWxcDBoQzy?=
 =?us-ascii?Q?/PSTwm9V7Y94AWrUAWAql0zZS7bcQqjN49LH8+fKjMY4NbOvao4Hswyptwh9?=
 =?us-ascii?Q?SPvSlPqt2k9pj2nI7ehgtOwwRWc2Uk9dISIaBPYjfEpny20adqBDncfSEZhR?=
 =?us-ascii?Q?77Bz2oVPb0IalfMqPMoaGrnrsi4ReFu0fCSrio9ieJuWrd2gSdU2P2/EeK6z?=
 =?us-ascii?Q?TbTmXAb4RUJjd7GF6lVImbCzc7MckvgZ6dunrI2xLSP0W/899caTkcGPxmIu?=
 =?us-ascii?Q?Nu1dHOg9XjCvTt/7Tombk2F3+iVTiH6ZHhI4ZvQ7Md1jtlSiV9A0tm9qhC+g?=
 =?us-ascii?Q?blPFY/MMnR5la9xXfYPcYbMi9FTr8VERCPKORtJK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0256fab6-a77f-45bc-51df-08dba31c8b0a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:31:59.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCjcBlUJRpJi0hPkDG64QGs+8rJWTbe86zCZ2DNp/ubD2ps90ogDyK23mShRemTT+/ODq/yUUnFHIhvDSDXoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove unused gdbus parameter.
Fix length for Codec Specific Configuration.

---
 client/player.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/client/player.c b/client/player.c
index 3611a8dfe..42721c210 100644
--- a/client/player.c
+++ b/client/player.c
@@ -111,7 +111,7 @@ static const uint8_t base_lc3_16_2_1[] = {
 	0x01, /* Number of Subgroups */
 	0x01, /* Number of BIS */
 	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
-	0x11, /* Codec Specific Configuration */
+	0x10, /* Codec Specific Configuration */
 	0x02, 0x01, 0x03, /* 16 KHZ */
 	0x02, 0x02, 0x01, /* 10 ms */
 	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
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

