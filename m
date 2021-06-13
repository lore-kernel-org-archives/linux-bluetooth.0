Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A3C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Jun 2021 10:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4A460240
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Jun 2021 10:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFMKl2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Jun 2021 06:41:28 -0400
Received: from mail-am6eur05on2094.outbound.protection.outlook.com ([40.107.22.94]:62209
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231620AbhFMKl2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Jun 2021 06:41:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miEhFF2oJeg3DgzFuKq5qzd2+9ow/zsJuG/X7Sh1ISgzmi9WeXvUyaXpeQqXW7eHr/wLu97kAvFoO86ZhPuM9upcLtjgzLQHxSKhvXgbB75apcj8OatH4YLOamXoMRIc5wAptkpXa6y3zDqZeADpSlXNYZW79RanruOdg9AiaxIghIByEE2pBk+Ls4I4f/EtqXF1F9OPYHT1VYZpw+oL4DirCJJBQYpzngEpi2Gaig+9m2e+MpYO/Q3EAySA4mbivbN6g3qrx2ewywBrcclz0roNbM/TyCI9zbrQYOxRTlYpOUXXONIdcf3Pnyl7rgHG/1Q6/2nXicnF2lQGdiayyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPS1tnwe67cgIqnEz6NqE/Oz7q3T9UTUFZNEfJMjLBQ=;
 b=AoJXaKa6WlTZjjy+VCtsPkyacXPlS2e3q+HXewqjC7RYshL8/aJrgS3KMsIVr008mjYlWO3U01VIylAehfhnZnM93mWLO9Y3/av0Nd6OaXxNIL1POWVOZgOPRJFnMZxyxxm7CIEEthSe4ZOSyLSVqz/YBcHm+oEPypD4DycgcWpxTmKI69rIGHbXlDTlBXxccBHp2P7fEdwPiWo54wO58EjbnA88RnVmALIrpx/ECIfot4RU8PixyKW1QX0SM6bCErXo+gKubRtk7Xf1OAkDf0EcicjKfvzQ+LwJOl4L0uYTqRT36ACCPqNLnzzA2vT3BSSzMbGpyttpVUlBNpM6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPS1tnwe67cgIqnEz6NqE/Oz7q3T9UTUFZNEfJMjLBQ=;
 b=VMwgV2/cAdsbkPQhZj9dMI18z4A0YK47cGdVHHrC/775JilTv5BPrbavsNAaZjzo9fceByo6Z/ytHwDdOGfHl0xZTRfLpu/5FAIB7cz5H9+J9XCe5vKmyY0L/TH56qc8OhSV+btj9JL7oA8YtGCgJMV+Vzakh0GuiisxxdRjLOk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM8P189MB1348.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sun, 13 Jun
 2021 10:39:25 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 10:39:25 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Date:   Sun, 13 Jun 2021 12:39:18 +0200
Message-Id: <20210613103918.5814-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <60c484e0.1c69fb81.c8dcd.c325@mx.google.com>
References: <60c484e0.1c69fb81.c8dcd.c325@mx.google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sun, 13 Jun 2021 10:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6807d19-35b4-4c86-5251-08d92e578331
X-MS-TrafficTypeDiagnostic: AM8P189MB1348:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P189MB1348324341BACD9331377918AB329@AM8P189MB1348.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TThA+I0U1pPZ3GgHyyZWtNksUMTp+Aa/rDQFNNpbBEJ29qwSPSm4fOm+Q4cQvGMuNL3P97iwavoyeTkx7AatzVuXC9V2pvHSkJVEn5meGJpaxFLJUG1waWq3Iu/RsACdmFS/Z4dz01SOzUdquZVGeTg4jX5vnBjBRep+1qgFk1lNYrQhA9LuWJ/WycTI5u6aNztmiBJJUOwEB5PCgTrnC1kBxpyvcMo99shz3Tv3MkFYmTHkBeJIA/ngq2l25RSjoEDeyiTAObn3X7KnMKWNv9IjVJ9wnn8MzYo/uKksjvhlrxzOO3SLPz1VNrQQ5Hyz9hPtMwl8DvUfO+nu3WZO/NiZlxl0RlCIdeYNm75+b+qnaTP5xJ03Tm1+2DR4EyRkl2KILBlmnldtQDachUNU4Gyu1mqSTXNJW4aQ9x9nKJvslz9W+GIXmqU27z4JpLgkid7Bh7eKVx9IZz8WAIFhSwgjiYy6eaFPRl/TGe5pzgxVOJRBHceTbOApBAK4NooDTInN7h65/Bn7WLOj3MAJC+ZWdHsUvgk+mCxuDrolK/6pNtNccJkOMu4KcnsMP7604WvCk7GqpYHpolEQwlPODZTmTGv61Phjyub/tWJh6uoITSedZcQojFeTM8tOOHOkf/fIDajHAir+cVBIBSznGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39830400003)(5660300002)(8676002)(86362001)(6512007)(8936002)(6666004)(2906002)(107886003)(66476007)(66556008)(4326008)(66946007)(2616005)(6486002)(83380400001)(38350700002)(38100700002)(6506007)(186003)(956004)(26005)(16526019)(1076003)(52116002)(6916009)(478600001)(316002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MvBtY8xDXpkEsRXDAbLmUXNzixr9xRsVBNAYFOGAFcbPCeSVQWDe24c61yU?=
 =?us-ascii?Q?jUlW3VTosC6X/tDAAqqNyc5e3p4RY2ZrMeLT5dvgw2YV18OUHeojbFsEqgcY?=
 =?us-ascii?Q?jd+sHu8LIgBUNehFtJy+7rgyrLU9cqgtOYx5LrWO7BgJKsIbCZ/mqc0fetEe?=
 =?us-ascii?Q?/8ROM1QTrwqUEDcHeLVn9N53u+jA7CrrNSGALGGYGB6IfsheFcxmMMkcBmrM?=
 =?us-ascii?Q?dNmbE05H9DOpNXUDnMozludSo8K756JV54kTTEbctqugloyGW2/vRfLp1Zi4?=
 =?us-ascii?Q?mPgmvqUHfIsnVT9FgRq3TGFbXET3m02wRMruiCSA+YptFuND1RA8vMQs/iLT?=
 =?us-ascii?Q?IM6tem1kVmAcQ4Z1u8urjE+TIB6btHC/gWWgyCKPKVKV98Zf+ikXg0ehSCPA?=
 =?us-ascii?Q?iFWUjZNqTQpf9iJcuISH1XFEpnQErUSFy3H6evYsGHRx0xjrZUWI+qvYB7PQ?=
 =?us-ascii?Q?T9z5YM7re1nt++CWfJk121FSH0TUbGdVH0JhnqbB3XXGO+J7+mqrKmgIpdEx?=
 =?us-ascii?Q?wjOEr06N00wAhmBkJALthmQghAdthnPWUdmXFbc8+MP53hEi1+Aj04d7Xcnf?=
 =?us-ascii?Q?fum8VtvHLuidmLzAMitB/WrHaaIBzz1zeBTD2NQ1FT+8/c7YT2NqhFyrofAS?=
 =?us-ascii?Q?RqL3qpt0g9PYtXIb9phRtZNksXnjhbAzLrF+XpotldnLw9JdSlp0X6m2v4P+?=
 =?us-ascii?Q?ICnr0fX4p5hKg3ZXaDBKEoXXEjgv2DgmYnV7rxI25iIUwkwcrlJ8ZCTr1V/h?=
 =?us-ascii?Q?K8ixzHMs3wjLDuRSlfpk+DJUv3FyIlfcVcJ6B+bCC7tUMjNlP7tf6nzJBJ38?=
 =?us-ascii?Q?zA2EkHJ6OAxuMB4+ob8B5UhSMA/QfXETl9xPKZZYb2LpnakSX+QLxArIoy3L?=
 =?us-ascii?Q?MvfBayXbYoJqSXEARZa8/ZnGGtirxu9cO/jRBXrB0RyXIf93lQaw/vkjBoEd?=
 =?us-ascii?Q?PFM0N8+uHYfxidNex018qJ82tw5P7/KhXyVRHCreEA95yvA8ZtDkGcQFFZyo?=
 =?us-ascii?Q?c+ZP05jd/z1WMYozcwLrukSUB8LXF7qzghpW+O79av7CJR7fd2hqlu+W/5ef?=
 =?us-ascii?Q?m16M7AbQqkCIJ2Wkp6TCMwkJTCbnaR8IWdiOs+siK/D3oyQxKtLAACARK1Kq?=
 =?us-ascii?Q?Udp9OW4Y88LoNsioMnC8Xd3W1WE60MA+txuZqWvz12stLyw0aByU9eknI7vW?=
 =?us-ascii?Q?hPVC2N54ITzlKTErDIIbqzS3PDgK8YAncC8tzY5P2IjEKOZuIo4IAGcSlXus?=
 =?us-ascii?Q?zSNMmr06UdmQu340iTX79GPTY+bVIL4ixwyZK5QBkX+YdX+lDc3Gty51ZkA6?=
 =?us-ascii?Q?v6qUobzaU4Dx6t9saEP+bHoZ?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a6807d19-35b4-4c86-5251-08d92e578331
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2021 10:39:24.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGkcNdhsMcnrmazUbojyQ4hKzD2oNUAwSxaU0GL8VuBtUO3vElKKU49Ug1VMrwka6A2bWzmMyym93gFaQwN9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1348
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
 src/shared/gatt-server.c | 43 +++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 970c35f94..dc4e681c9 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1690,6 +1690,17 @@ static bool notify_multiple(void *user_data)
 	return false;
 }
 
+static bool notify_append_le16(struct nfy_mult_data *data, uint16_t value)
+{
+	if (data->offset + sizeof(value) > data->len)
+		return false;
+
+	put_le16(value, data->pdu + data->offset);
+	data->offset += sizeof(value);
+
+	return true;
+}
+
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length, bool multiple)
@@ -1700,23 +1711,35 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
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
+			/* data has been freed by notify_multiple */
+			data = NULL;
+		}
+	}
+
 	if (!data) {
 		data = new0(struct nfy_mult_data, 1);
 		data->len = bt_att_get_mtu(server->att) - 1;
 		data->pdu = malloc(data->len);
 	}
 
-	put_le16(handle, data->pdu + data->offset);
-	data->offset += 2;
-
-	length = MIN(data->len - data->offset, length);
+	if (!notify_append_le16(data, handle))
+		goto error;
 
 	if (multiple) {
-		put_le16(length, data->pdu + data->offset);
-		data->offset += 2;
+		length = MIN(data->len - data->offset - 2, length);
+		if (!notify_append_le16(data, length))
+			goto error;
+	} else {
+		length = MIN(data->len - data->offset, length);
 	}
 
 	memcpy(data->pdu + data->offset, value, length);
@@ -1740,6 +1763,12 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	free(data);
 
 	return result;
+
+error:
+	if (data)
+		free(data);
+
+	return false;
 }
 
 struct ind_data {
-- 
2.25.1

