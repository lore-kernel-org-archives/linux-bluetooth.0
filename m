Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9DC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E67611CB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhFLJes (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:34:48 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com ([40.107.22.128]:36353
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229819AbhFLJes (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Jun 2021 05:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q172mvWjiV183jI8+PKy+ftPQygah1i6LtE/cgpqyNErLhNETnsgViIDejofxDFa5lTZOgnhmsvAkEjywt/EyKi4ZtNbg1sZ4pvlLWIjvlYAXBv2YQbTxBjV3NqAiCsFZXjryBZ9/Y2C8kvoZu3A8Amh1maFAQhUBsEgZV+N7WKoJSzJvBjxUSc08w5YoswUtWru8QD5lexYKYfEykoC0rhnywOETUTcJcLSJN0z9FTZYzCJEtdrxX93ts2e2TB6qrLF4KEIVf4wwsHiuvaOBvFQXHUL5L5MlbCcYpg6+PPgtY7jZiU2lCGjXGZnGU/VpW8mKCHxoZ1IXPj+G2Dl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSscg/fKNXAQ6a1ZHzEmZFq0tw1CIyLnoBPvwSZJltE=;
 b=fV0T3HCpih7kGfuO63HiG/lZMwX2t3SBiIxZtIapSZvAcRLXpp3TbRzOCNZtbYQNepeWteE9NG2IYEjI1aUFv7mtwHhP10rDxpIWmVAkBtQ0qSa8Oa/lSZQQmf/9fx2eCqiIYEHVvMM5KFZSGlLVLcBoKIxw1KmwFfuM2/ThgiYkI+d2xWqiI023OsDhoh/Yr+mBkyWj//yQrm2T0oNK+MKS+ybgf/07tmcC3QqcL4yUnG6oArvH8YUTptIp+QIJGrEI+Y0N5l1yfExajP3DO+MBLaXT9c7gtvwh4bCWTYhFkqZVxd6RW+uuFmKhKnF69keW1lGwZ190LHJr1QCfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSscg/fKNXAQ6a1ZHzEmZFq0tw1CIyLnoBPvwSZJltE=;
 b=lhOKzexNhn/lNlYZz70CGxL3FLiw/1OWok2FcycSUnnwB/BsGpahokcBiF5NihVt3nWqt4IlTxoOPxm9JYbOkNEdcCxOFkyzICPjoMpTV9li9jHVI7MCW/C005NvAlWaXIYa/12twqBYGCdNMBc0fnxBwiiQoxFIKrfYkjKglYY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM0P189MB0610.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Sat, 12 Jun
 2021 09:32:46 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 09:32:46 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Date:   Sat, 12 Jun 2021 11:32:36 +0200
Message-Id: <20210612093236.5293-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZJBbiBvw+r1XLxE5=uXVv3cXe8EpCd3YOF7ZQVmDGxyBg@mail.gmail.com>
References: <CABBYNZJBbiBvw+r1XLxE5=uXVv3cXe8EpCd3YOF7ZQVmDGxyBg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 09:32:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a93bfbe-b4e6-4bbc-16de-08d92d850936
X-MS-TrafficTypeDiagnostic: AM0P189MB0610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P189MB061067BB7871AF9F9BB33B23AB339@AM0P189MB0610.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qALX8B7JvEfvdUgvN5hVhJh3iff7CgPQpSyn7C+KNUwnLcdeqHL3zuKRH0HorxDLujvQLj6BcI2wsppmEHJ3zEuhSOFRAuMN+mxZVH7C08Ib6abGOJST3T4wvFGkjQEF+fL9hTU40qcw+uPtxEEDgmxoUrs9mmeC58wbvNRJ411FHcEUet0vLNjLQQd8VCosqHAC84yLI4/JVpZZn8OlQUrjAmkwcw9N6wLRD0i997mjhobBWFESk0EwckdUmAUjNERTfY/47SQWR196mqL37XSt04AbKPsUU247tX9JQuuqRmKkIS/ifUDCiT92qmkwK954tTf2QdbKjEs6Ipy7zRSZg0L8mkbbkvFXv2yedLoWvgg32f/lOuY7CZ6utOXSXh9sDUksHvpePTkT7zxOAPX4FQHOE5v+Xs0jqmM37vpekthLXvV3ohwqhEq1AYmLdCvB2G9gwFsZ44El7AEQctVvyXif8TP5KhdWqqjbYHRECGQda7bVI50OnL0GL3o42xOzCKIYz6B4DMDbq/e3L/6XQ50UishXJZYgr34KNI3GTwrBoqMl6J84NV0d8H12PubaS22Vf1sGwHBSZe+Guq6CECbKaNoDd9htcFBLK7ww6uDgBd1yLOgsrQWB1nRByfwStkiVQyWNjhepH/gT1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39830400003)(52116002)(478600001)(6506007)(107886003)(6916009)(6486002)(2906002)(4326008)(316002)(36756003)(66556008)(83380400001)(66476007)(5660300002)(66946007)(6512007)(956004)(6666004)(86362001)(1076003)(8936002)(38350700002)(38100700002)(2616005)(26005)(16526019)(8676002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oWg92jW387kMl144Dxg+CljLoxpHmBq5k8jB6zxOWfVPVHgNhFppfvmRMcuS?=
 =?us-ascii?Q?N5itECh+0SRxqn6TACty7L6Wg+08wwf++tQBPyQTD5XpCNIyzIpefaUtVNUq?=
 =?us-ascii?Q?r6su4qM0mLG3Tl077ncibTpcI0xP8kMUuVNDn7SNJUTEYnhOAC7MwgJ2Y9JE?=
 =?us-ascii?Q?9F1Tft+o9zh/M52mVPW7cyUxuF53Sh0O07VjwTslFcVtqxRzEPFNOcz4DbpN?=
 =?us-ascii?Q?xI8yhaHbYk4eZIkQXHIxLKRtkHXxHDTUDAAz0PrfeNt0A26MZwoIO3iOr6qn?=
 =?us-ascii?Q?GjeNINCsRHihT3FZtTZdvMM4nbe8bRZG/hdd0GrWLXUJ3puqZg66azhsRYEJ?=
 =?us-ascii?Q?PVU1+l+96zYitPeAAlkB/8E5z2m/8Rqiuaz4502T6lCruzkh3iZHTdHivT3z?=
 =?us-ascii?Q?3t/KF78lp1iOppIDj8k64v9fv8QeE1MD78K8YpsX5aFsRfna6lalIL7WOD1w?=
 =?us-ascii?Q?dquhp0bU3d8RwIww2AcWtDOZAbbOG+qyj9y/M2cjDRggrdRLidId4puFuKFw?=
 =?us-ascii?Q?7CHJoUPJPT+wWPCNcRL3x9R+idl3m9x4leKbuFuDmSHbEUdywJil22yZ9Ec6?=
 =?us-ascii?Q?0kVsU9dCX0AQIfa8A/xiztCjllCJs05XMHAYX96wHcrqd6K4l/ztjDzTdeOT?=
 =?us-ascii?Q?lkSY3b15ul7pCPkQ45/Bg7uHdiphGNB8BnAcdc9wSV8IRcvSFiqmRp8WeP+L?=
 =?us-ascii?Q?QtzbcD2xDoJ6LsJJjfOYPaV1tgPdVgnl8BTzM3zCXr83LBHV8mP17jWrRr5J?=
 =?us-ascii?Q?NbTa5ni8lHXCr2xBiVWHByjGELTyk6ucF1bc2S22U7XtzZpaN3YRNDG8Sv3Z?=
 =?us-ascii?Q?OTqYS8XgxFHwmrNF+JZQsSJCC0MDJObne1sa12NWca0Iia7I3CtiwFf1vQQ/?=
 =?us-ascii?Q?OezDJezOugfRMVhWOISbpGOagSzOenSw3itUih6WjA/M+pc+P3zxRbGI/0ID?=
 =?us-ascii?Q?Fde+WF4LYkuY0csXrIn82lryGLxB+/bZxcdMwLehFysZD/zCJ4AVvqMo3qzd?=
 =?us-ascii?Q?NJfCnNDN646koUyA94Ry+EDF/lr79t0RDYU6T0I+XzPgBdmajilCgE5Stgk+?=
 =?us-ascii?Q?igsSA2r35L9VTAFR6Q4wP0OPDgDOqZkxKssIB3UrnaO8cSjBAuyCiJg0zoiB?=
 =?us-ascii?Q?sdYf6GxXDO2sufAkuYBQzrMjt1swhBdWgV6feCdGDuAnNPgavIVBbXmBjAIY?=
 =?us-ascii?Q?GRLLHVti961UWfhUmDDRnM1HlD2ba4QzYZZo3vhbhmH5ttV+Yap+qtbywvaw?=
 =?us-ascii?Q?Hs7RMjPpTDJbFjFOnNMJwov3XoFwycJUA+jJOY/dByDmMsmJov7metzbk9HB?=
 =?us-ascii?Q?Gd1bJeCV4qyoTp1JuKWrgMd+?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a93bfbe-b4e6-4bbc-16de-08d92d850936
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 09:32:46.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnCyuDWh77tFqdycGSHlj/i+9CY0yK073xgTSV1il1zyZK3UdVz3BklC7bzQ1AdLu+5SUxXTFXvLXYAzBzmEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0610
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
index 970c35f94..5dbe9d66c 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1690,6 +1690,17 @@ static bool notify_multiple(void *user_data)
 	return false;
 }
 
+bool notify_append_le16(struct nfy_mult_data *data, uint16_t value)
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

