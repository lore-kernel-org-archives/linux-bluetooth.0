Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB23C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CFA613D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFKMb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 08:31:26 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com ([40.107.8.134]:14464
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230188AbhFKMbZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 08:31:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCKPHwsTgAFwX4jMd3cL0d96VUz+1q42Zx4vJPyvR+HtZgmPiaNzf6uwiapflgK8V2EOp3I4htlE6dAbGT7OrIPT4Gb5lDnrGUj538ocGqoFPWtF+iYOx7DGYYsdkqONRMwYAuWsQ283ZkSZCwOlR8wnsRjn0tNHgfPs10aAQgYtqhgaiEMmVVtSoP9LcZA9c3i6BTGSCnXJrxb1oQsaklLEHkw/ERl40OEh+LpJFzPmMuipSiIJsDfRmks7nyXjGZma4GbbG0iZJapaHOfRPA9m4+JuTb0njHveq+foESjW8k89MDTFRL+qlpKUuUk3YbdUMz3CfeJEDzIWQkhY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIInolZECEth8eIBwckvf6bldey1ZNM171ZCiLHnZco=;
 b=n4DaIA3Eg10r2G5SvEvDbYpiWCu52YWrSFpxgr0NshsDfqL/2VwaMoHJE31UZF7l7NblPLsSeDr8z51U4pApPZEcbgdfuLX42gqIFnKz8/FnOqmHHL/72dxug3cP/jqvhWMXEIqN1eNGWFA+bVbYcky1ezzHLy5w+JLobpQUrN12U8+hq3hRwkDThey1RkzdF6fGTOeYrxdZ4tO13eV0eOBzSOs3tZExCxh9oMmuN/RllteaE9WkrJaRYZawZwdoeeWwlgKKh3p1pS1EBjHqLWpDo1IP4ix/2TlAYtM4RTNcdrJCwwmYXW8d/Gi3BZ9XyjavynjvzeGM5kG5tQmEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIInolZECEth8eIBwckvf6bldey1ZNM171ZCiLHnZco=;
 b=KD50XjEQhBMVH+rHPRiCXLlgceT06EuicdKHOalMu7T9RVon7w8GJi3EAO2gc+v/N5Jhe1yITlp7tFlqTJn9+bnCuLV0XDzPGwFuZGl58oTFMLkOf6ow6nhPlsiPHwKGhuJFiTADCQjuTLNGIVgV0CI3lg7i4v9CztBgSkJz3fM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM9P189MB1651.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 12:29:24 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 12:29:24 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Date:   Fri, 11 Jun 2021 14:29:15 +0200
Message-Id: <20210611122915.21068-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 12:29:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d1a6d28-fa6a-4034-2ffb-08d92cd48bbb
X-MS-TrafficTypeDiagnostic: AM9P189MB1651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P189MB16510BCD73A5317DF13BF436AB349@AM9P189MB1651.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlRrtTvOk+OjY+BwwzFTHuMvM1SXXsHu4CLH0wGQ7DzcAlemyzqhb8hOmoh4gkJATeHkETkk8b22kOmPG4xNWSxraEyMxq6bak+d2OcvGyqn2hRL7vgny+tuEoTaFhg7DwhOZR0zF0gjXaZ3caeikRnjnKY+avwiU4aRu6feD+W2tkMqlXsEvTXTe3jPPIv+CocD5pZVpHLRh0jLrm2otSKCKbbkeVruw8Kc54aRVPhV1T/Nj1CqshaN1zkCeBgVatzNzFMxhhY2k0LlJIKr519JNxBDahCBpR6uQPsvAikWtKPc/2JkL0HtNFj/DapWfXyvlrLjf3Ah0vq/sQc+R2ZcDc/y+mq8SvvxSDAgtsiFywOLDR3i6JBXZrZ/IfEosjsxwn9YOYvpi/DOqCnBirJVI7aZNTOS9/mmpRljRDr+phygAfYjf9ikOAT1Ir3e79768Mo4X90V42GCsZeWmNNvO6cDzjQ3IQMjw/EH38rADmqb6LXv/vOC+4b2PO19/ipdqTNsiFjspxWeZcHl/JHa3yIJZE3mBL9i5y9W5H1BpLxKtxJD0Vyg+1TejbJJruVJ66l/1cXWOfU9U5khbKcYcvATDJD/fxr1tvRICqsnkSs5dfQwQvztv3pLBnT4VN8MV3WaJKANZXd/jUOuhSOQ2VBJb9/ZPiZ2ogYUIkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(39830400003)(346002)(6486002)(26005)(8936002)(38350700002)(2906002)(52116002)(6506007)(6512007)(1076003)(956004)(38100700002)(186003)(66476007)(66556008)(66946007)(16526019)(4326008)(6916009)(86362001)(83380400001)(36756003)(316002)(6666004)(2616005)(107886003)(8676002)(5660300002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRfwCgA9n2jvEHk1saUvreVoY1YT1S7S8INwp7NitA5qJZW2VumHqyg/ex0b?=
 =?us-ascii?Q?IJdIwv9HHKGz+tUZJ7EqkNRPdiNW2crzYYUpGS/ECq7+FsIs51+UFHF1VHP9?=
 =?us-ascii?Q?IomtC09ZSG1p6FMgcXzRC/G9ta4fQN6hxW9MGMWVhhkpXy9Ihl9/jsqwtUNo?=
 =?us-ascii?Q?7EMazy7yQXljqRrMOeSbCAi+pZEWNkKwSAzBHgMz5JoUCrpKnJuVVLw9kyc7?=
 =?us-ascii?Q?SUu7emEXJ74Zt3soHCdqniUYN7UuoATbJ7j5etrIXjsxzbq2kbtyIyP9N3cI?=
 =?us-ascii?Q?11aFO/0iN1a3v/L7Ou2MmbRHczt1Ktu+ugg6QiatPfghjJHWwei2PsxN/KaM?=
 =?us-ascii?Q?ydYHehBeHQVwpWbisM/mfQjLpg/mgxuD8g4Mb3xwMV0w8lArufaMrj6piVkc?=
 =?us-ascii?Q?qbk303JkOe6oIGUtKJTQAff3ze/JlIJSrzJHm4DvOMnYm8Q5yzmui4n/yK/L?=
 =?us-ascii?Q?Gi4mHbibJNtMG6bQjgcITFHRDRJPp3Uwjs0Rx1dTj1CSDp9Zdhl0SyhOzFbY?=
 =?us-ascii?Q?WzxmM3lqKA/9jf4dr0DkgEcdQGPgOaanQpDNreTVjj+LJXk8UpZ6CBvKGhYl?=
 =?us-ascii?Q?jbqrMvAK6cG4PperaGFKbLxrYRtkuXLcyXzFsVudCsgd40qbf5bJ6v0Q5DIp?=
 =?us-ascii?Q?8JmVNBLLzt9XRsC3Vn8jG7C/GQpm7VLa8gsQ1LeUjqErd4H+Z3NnrR6qEee7?=
 =?us-ascii?Q?4+5KNb5uAun5ChDDOPVvLWpCEKeX/bvgf744kj29K8l5T28aig08hleRV+KB?=
 =?us-ascii?Q?g6X3lMNjckx2JQQaQb0gSeO2P1J3cetHHVTD52iVdy6k/up8ukUFUiOs5Uki?=
 =?us-ascii?Q?jW0mAgosdcA0GbcSJezBHvQtj4+qAaZ97KK/0nZ3GVt9YUNRW76kGSVb/8eN?=
 =?us-ascii?Q?5VDwMw6o+yuS/EnMUUpdCbzBznZQvRMs8NGEMG1ZvIw+Mct7Hm0f5z08ectk?=
 =?us-ascii?Q?Gxb4keigsTXQ2XQ/cwa8JK0RN27wO77na3U9a83p8OOzIwGibSRyi1w6GB/k?=
 =?us-ascii?Q?k2whA9SnXXFJG6BXVk6T1wPmEio3GloUe8/QblNnEQqC2aSJMpBq3gFKCqE5?=
 =?us-ascii?Q?xbfDy8KXKT/twPZw8IXjSLsbnGX+MBgE2SJ0dFuFhIGg/hGZ+MNGwXu2MMEU?=
 =?us-ascii?Q?ChdpYBs196GgDIafoHY62eiqyLr6q/WOaOJPFyUyTH10lkHVIxcRSx8VD9Jq?=
 =?us-ascii?Q?d8WXsg8adB9NTAgdi7wnNCaM41ZwlDOMNS1464MlhQdey69yT4Vbc5y3517g?=
 =?us-ascii?Q?LfwFjcSbAJvibSktifYVpIpknxD3G7FiQu18sZYV6VxLsEvc9ScaVs93jjxa?=
 =?us-ascii?Q?3EcMSt2Qy4q6qIYI1EquV1vY?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1a6d28-fa6a-4034-2ffb-08d92cd48bbb
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 12:29:24.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBI7Wou82zhLz0ShDHGd1EHtKarLK2fLQ9inkXulwbK/3Bl7qaIxcH3jeb9dyGcpJ6ftR3ZtvFtuc+DjJPShzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1651
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
 src/shared/gatt-server.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 970c35f94..d53efe782 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1700,20 +1700,35 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	if (!server || (length && !value))
 		return false;
 
-	if (multiple)
+	if (multiple) {
 		data = server->nfy_mult;
 
+		/* flush buffered data if this request hits buffer size limit */
+		if (data && data->offset > 0 &&
+				data->len - data->offset < 4 + length) {
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

