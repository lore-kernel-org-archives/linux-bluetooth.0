Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35FC48BE0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6D1613B3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 08:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFKIVz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 04:21:55 -0400
Received: from mail-eopbgr70092.outbound.protection.outlook.com ([40.107.7.92]:61710
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229584AbhFKIVx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 04:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljZXT1sDmJugft5fORb23HKU+TEO97ZyEbA6FmtxDy6mTx8Z9MJ4PbC5U+4DVqQcjuvsTTaule+/bdNhKWK4S5Vm+nLh1dW2R+bX7G0otk4qaWsytBemYm9Nnp/DAk5Nn8h7EfD+f1IW0ujKorQsodPSz65D7xBIGnsTArMYXzGlk8A+OIvLrzGOaG0i4JVWA70lzXC/VPFrxudS3aTKPKfyht5Dm38fHqESEJqBJbqlM08fiFqWYGchWr3vt2MMKsSlxoLXx4wcRhk753+XIKsr446ExyCCPguxXOhO5qU2qnLXCv1KofQkMStS/dqv8JCRYIhez4odA+H4zVoTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEGjoplj1+KQFWqRWVWAIo6UiErhamD3zdmUjUj8tvc=;
 b=nQQCi6cb6uICUIa085OBuk1gI6EHkauchol7PqdmhBzTWDWnuwyx+RwK7ci4d/rpqgwkuQ5eR3eBR1F5vVKQSyxiv6uf8MBWklQkAoaCh+roheOrrWaOXEeh1g5Ka2o76+7XP/pcSgJmxiHmINyNPdZDjRbqKSVkZB4Hb5yjNwI7ln4oXciCtmqHYSJhX7f7ndB+LjPKmztPfOsBEnvcIwQAvJIbBpvY4noD1vfxn7WW0ZDTts6gWq7Js98lsSirkOgW2O6XTm1fhm7UOLsm5+rcF7fiYsJjCwVQsPLtsx70q7MIZjM94bAShtwftn+b6bDzHI9e/Ao+w9r31na9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEGjoplj1+KQFWqRWVWAIo6UiErhamD3zdmUjUj8tvc=;
 b=RbQHhc5O8LbBeWNy1MPp/NA0ViR6ay6o5NnI9Yw8Io8SA7t4Cp3L22N1GatQXqd2LL0eDR3uqgRsQa+nlRF1b9yY+/v7XwmegsdnQBI5fkMcb2g2QA1qnQY+K5W9eO+BDQdXW+zqvKQAD3STJw9EvBKJFPLmzvHzgWgWnfqElMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM9P189MB1716.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 08:19:54 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 08:19:54 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Date:   Fri, 11 Jun 2021 10:19:32 +0200
Message-Id: <20210611081932.4279-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 08:19:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4871f19-296b-4d57-33cb-08d92cb1b118
X-MS-TrafficTypeDiagnostic: AM9P189MB1716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P189MB1716712B346D3379ABA77DE2AB349@AM9P189MB1716.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etYcOufH2CHmP/EDMqIK65J6REGq8L5upI6rplRqd2d9qTBvqSsnXY0BvbcWTlkw94bm32v3LkExkWaEB6K9DWDj+OtTzODB0roV1pRxJAtkrGu7F5hFCE3j5MdAmZItN1dBzt7WFoPaGSh/jXyYhxIyTJ9avP66n0+rRxf4Odo8yPUmH1lPF0EnBZigmrDvVsvaPWvA0Z/csVqWzVV6+31c3JW1arlShsa/xZ/h/8qvNldUhISSxIWKGPx7BwRsnRrSma2eqZiUlL+6adB6WzXXknJngqafOKszzrh4iXQIUsbSOHD7mWV3LIx78/FCiDKqpqGOBAxcQuLi4lDlNWSOapk878GS03NB6S+e3yh655kpbzsWhpQ6CKN9oQArayUV8D322GkCGt2/e8KHj1UXgNm889ufpGbTSm0y2rik/ppgv6TrYf570OrBPVVP3KVcO2cWGOfi3SItsF6EnqSdryZQa6DwPGtskXfLn4IN4ggO7gB/+3IYcSDTWslKffQBV8yimM8VaXuL+Vob1O7RSXjLpi4fJ/9V7fxvucMOgRG8S9vpGAaj/wa00OkJp8/ZROy8N2gAQll2y0JHHpto4wvWeW6nWkh+JS0b1Qo5MYVG6jLaHhE4vE8YV7K922PfWoL5WXQlXvwbAynjnxsRtAi0bxSHbSKaTT3LXaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(346002)(136003)(366004)(376002)(38100700002)(52116002)(36756003)(316002)(478600001)(16526019)(4326008)(6506007)(38350700002)(2906002)(26005)(186003)(2616005)(1076003)(6486002)(66476007)(66556008)(66946007)(8676002)(6512007)(6666004)(83380400001)(8936002)(86362001)(107886003)(6916009)(956004)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqRX5zFQqQg/nw3ID+xp2qmpN8uYGV15QdQXKSXuZCDXfntpP8UxGorHZa5s?=
 =?us-ascii?Q?NzjlDwkNUQBN7ns+679c22Rk2sSfGotjhqGTSWKZirknWX6ifH0Duk/ohELm?=
 =?us-ascii?Q?2NgC6qoQQ0RD4DHOD1rGiza/ZLTdFwVF7+FoA9niKW4wLihSNIaphqZsuwmb?=
 =?us-ascii?Q?+/4/74LGTbDlDPOlU4tSpIdXsq+XHnkgaYXHCr14L1dHqS8jf7wqTaibq4MO?=
 =?us-ascii?Q?k50eDwDgJxDIaRnHDqPviwCZ9zDhkHOlYxSrbZgQLcZ1Vvts4ftLjFLgKNCJ?=
 =?us-ascii?Q?ZuycbsPOulZBMlh6MSiWUQMOl1ep/pqzl1YQe7mgpy0NgmzTnP4c2m7cUllE?=
 =?us-ascii?Q?FQpDU4Uq92LVdfsT+CYCEt4zirfM4U3t0RBgWbsXK10aWKnojRWcViD5JSwP?=
 =?us-ascii?Q?hcOWcXHp8b1fBtM4zG6VT6ovWcpz9OrFnEkXgHltAYYFMI7kEwcBuGLwEd5h?=
 =?us-ascii?Q?9FGDDhVY7N7DUf2y3SDr+sA/xI9T6kpTNYgNSjWoedrpGmsDlKqu///zgD7F?=
 =?us-ascii?Q?Ambw/87kD5TU75JPMolchyj1FoW51bCz1LwpzlszBF+2HDB+qeuoXTZNXA0h?=
 =?us-ascii?Q?padc/u51Q6UEnQZlFbS/Dk1gKlj5HflkT0wufNIzCfL2SPfJmwOx98YDTfSU?=
 =?us-ascii?Q?eaZ1JMOhtLobTgXKcQP86XNx24AB2nsGKmcw7vJMNjOa/IEPf6Id4UCRQ181?=
 =?us-ascii?Q?6X4BGsAF4+BA0mgDUMABT7CpKvX1XbMVAUVt7+ycMQdsD0V+qsh7RUoOXalr?=
 =?us-ascii?Q?qPDUWBFuvQRX4GtLRLy4/xH+mX0Zu7fL3ib+7W2HqscOsnVJSpCQSQtUxinA?=
 =?us-ascii?Q?J/UX+n0Aa97mFdQO9I5vO87tqe5uMvC5DqFyluH/GO9lVFE+eU3AM7UHY7TH?=
 =?us-ascii?Q?SegNIPcbtcgWdvHrHcyjiNR0nr8y63euCsjc/bUBOsEg7WYOL5hRLSz5WEtD?=
 =?us-ascii?Q?cCxXiCgxnjRdSpLGLkbBTowUQxXuc5IBtYnSghdjqqVY9TLSWV2F6UQPFQhX?=
 =?us-ascii?Q?5PK/J4QylI5DoZETmeMUZ8QV4isHvGuiD5GiutNKIYJdClEeX24qgdNw6Jck?=
 =?us-ascii?Q?/uuJicm/eDCNa/PoZnvY8I1ZdctDMDRydZXQhlBlYZORFj27r9KB0nLAckVx?=
 =?us-ascii?Q?nek9p1yS4Fa1C0Tg5uhvcVwzx1Jxy46q4peeg6UP4eK/BndRPgBUEuL710b0?=
 =?us-ascii?Q?mr34Ux7ld8QMy75vYuDpT4Dnbc3r3x/pCsBpB+axIdsUYM8oSQR8abyhCf7B?=
 =?us-ascii?Q?weWGeN4QmSYrTEycTWqxBt6LPunv0Vye2Dv+NUkLBgWgXEs3z2ngcPmHD/Ss?=
 =?us-ascii?Q?wdJVM/7gJpOne8LtSO/pmnmG?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a4871f19-296b-4d57-33cb-08d92cb1b118
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 08:19:54.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLbYsGxJTZfJeFV/+HtBSn61z5l8QcsAxceH+RCm+9jPsVD81c5eQEbR0vn2vzYtKeZr+pM0CZw40FvI/ZC81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the calculation of available buffer space in
bt_gatt_server_send_notification and sends pending notifications
immediately when there is no more room to add a notification.

Previously there was a buffer overflow caused by incorrect calculation
of available buffer space: data->offset can equal data->len
from a previous call to this function, leading
(data->len - data->offset) to underflow after data->offset += 2.
---
 src/shared/gatt-server.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 970c35f94..e7155f16a 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1700,20 +1700,34 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	if (!server || (length && !value))
 		return false;
 
-	if (multiple)
+	if (multiple) {
 		data = server->nfy_mult;
 
+		/* Flush buffered data, if this request hits buffer size limit */
+		if (data && data->offset > 0 && data->len - data->offset < 4 + length) {
+			if (server->nfy_mult->id)
+				timeout_remove(server->nfy_mult->id);
+			notify_multiple(server);
+			data = NULL;
+		}
+	}
+
 	if (!data) {
 		data = new0(struct nfy_mult_data, 1);
 		data->len = bt_att_get_mtu(server->att) - 1;
 		data->pdu = malloc(data->len);
 	}
 
+	if (multiple) {
+		if (data->len - data->offset < 4 + length)
+			return false;
+	} else {
+		if (data->len - data->offset < 2 + length)
+			return false;
+	}
+
 	put_le16(handle, data->pdu + data->offset);
 	data->offset += 2;
-
-	length = MIN(data->len - data->offset, length);
-
 	if (multiple) {
 		put_le16(length, data->pdu + data->offset);
 		data->offset += 2;
-- 
2.25.1

