Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300BBC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B67611CC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFLJ6L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:58:11 -0400
Received: from mail-eopbgr140125.outbound.protection.outlook.com ([40.107.14.125]:22163
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229584AbhFLJ6L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Jun 2021 05:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb4jcKieX4gD9vHkUkqs0uEqR/BcW681V9b5cefTNXOheeAJJ68ulNrD0wK6dUhS4aYAEbmI3PZ+xUPo4u4+C46cJfGDKzK1CDBzaN/aiNiaPmCvO/p6kTh/EFpBS5e/G5F4+LnjXiVIWU0HrsHYcVfcFtEssktom3CXZJ4/anLO0Kdxm2ye63KCox0UPi1LPWchzrXtUoLxJTxxoi6lIfb3McjdjW9NZ8HYCf7t6TH3qYBEQz5bVsGgeYSfYMP/OoJqCriorl1N/AA8qHGePaW5HfuROI1KHRl2JR5t4wzyJiv3JcXVMbJPfnoVoaa6p9qjJqMlWKRLbkzVHkCEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhwzRUQaMq8SVFkQsEzZq5wsh1qUIUTXtzrKXhBprM8=;
 b=F3RsVQbJqQRAcK/ZzevEzuFVzCgCN/gppC+rDwoAgS/WWaE+ihPQ2lCJmwaqzRSmpZlzg68B7MRbb0TVQwEOY9mL2w+ju2g5fp0vOsNQvjq8nplOXYpo4xijfA158P/JArljIfG6GnJEACviJuXlUYvgV9fywWCqIGU9BuPA6Ry3J2SNmKjtjTTKdiVMR/xMRDOUKKhHPnjy/EN5JDbRvKJ7N5NjtHUpEgFkH9T83VzI33GbNlBqLmB3DXM75gudGK0c708CADCeZegey+K0BWUYOwPhTBX9DPOjvHXpU2BcrNxJXLE523UlVGJfGNSrZnm/gNFDCElmG/U20TbXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhwzRUQaMq8SVFkQsEzZq5wsh1qUIUTXtzrKXhBprM8=;
 b=ctQzbW/7guIHLGBIG9DujhOu9nnQ5687h8liZBUO1ejZfBQL81CiGw7H9QT1823gwNCuSAzUOX7VFKJ9VfunTw9An0vNoFrXQ3Un+aNMokBic5oCGySkHMWWOaGg7HtQuGpe/1sYKtrz29dsewgICQw55mjRFCj3X3ZzSSnpPK4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM9P189MB1601.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:300::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sat, 12 Jun
 2021 09:56:09 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 09:56:09 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-database: No multiple calls to AcquireWrite
Date:   Sat, 12 Jun 2021 11:56:01 +0200
Message-Id: <20210612095601.7654-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZ+Z-Z8e2XPpRxfdWoP2AP5QeMVFqhk7Go+2HMD7xpdc4g@mail.gmail.com>
References: <CABBYNZ+Z-Z8e2XPpRxfdWoP2AP5QeMVFqhk7Go+2HMD7xpdc4g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Sat, 12 Jun 2021 09:56:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7e6a7ea-b34f-4fb1-c2e9-08d92d884d75
X-MS-TrafficTypeDiagnostic: AM9P189MB1601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P189MB160191E4ABEA2647A72A539AAB339@AM9P189MB1601.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAO4DUheR0KxXYrzGPSO2MavQIA0iYB9RcTXZd7Id7o93gD9IvF7tEk9ZRm8ARbIdZxF6DPtVGFMnp2uh2NHfkVo0BA5e+MOUasT6/mzb6G0ASsTCQ6sw3+X/C+1QpiSXW5kbgI52UXqyUgm91DmqiiZat7Oi311mJgh/29q6Ux/zJ3O8CvLOUB3UlrYP2NoIZKFuHNQdC22odrQ1yruuQO3MXJ4SuLruacXZ3Bxlti4OPhxj+tlzSzDLHMtQhX8Iz2iLtRDErGb6Nc0pRZPtwszY8T70CAAdaE4qFeRAEeazYGm2s0OpeXmt4sQML8Ead780bW0IgiUxZRq7swwNSHpmFA8tn6JLjqCyZJ5PETNfOsKLvtJxgQjzQmPS65lDch4V64Fa0Uc7yn1tj8cdrADPrf7A5562/YymEWIyKzPB4ub4SetMIYB6BOKFI//Abd4qYn0Hq3NVt3uBUSaePw4abXr+p29iludVvIfg78Bd/RcZhjmnMPoS1E5J2Kxr3tGoD8nb8aQUoiN49/06shpOS3Zk4bQj80e2m3DoZqWkob09MRhBlY/5sSUeqaGbzbAr24IMHKMaJLyC74tpT1ixjk/Z7qvIb7BHWhacLzwTiRRTfa/x49GkjqeF/G0jZ93iIZk4GxeGT6+nX2lxrimmoDelImQRhy/Q7P4fL2Bt4mcM5TxSdkoOfpvZZ0h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39830400003)(136003)(396003)(6486002)(6666004)(66476007)(66556008)(186003)(6506007)(4326008)(5660300002)(38350700002)(38100700002)(2616005)(956004)(52116002)(16526019)(6512007)(8676002)(83380400001)(8936002)(86362001)(6916009)(26005)(2906002)(107886003)(36756003)(1076003)(478600001)(66946007)(316002)(130980200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYSsaZhyBJG49zlVkmND7yzR0WJtQ3PUXBA+6hl2N8ulceMtBp6/NVu1dEFy?=
 =?us-ascii?Q?ARAsx04D++6/aD9uzcmYrJu3MHtwpVrKhZuobr2vY/yJRrWFJYokUgAg2ugd?=
 =?us-ascii?Q?W18QArUBmungIN5hR0eN2dCpfwr1prrYFmK94Kh0OMvr7MufbLJSpxyY+wHb?=
 =?us-ascii?Q?lxpMYREcaFOHXe3oZ8PlMAweYDUjcjsPrGmflSkfe9ZmaCtSJXYWw1k9acth?=
 =?us-ascii?Q?Hz2FlZezJuBL5QWcXdqmGYOPNOqefjfZ77oAj3La6w6InfoK+mlII+Ys0xmy?=
 =?us-ascii?Q?b162LnIJiND8qvR2Nxl7/WgFZ9gXC8ZU4sAro82L8W+AI1RWTO7f920nDVKe?=
 =?us-ascii?Q?B6AjipB1lKfjst4/tiCDOE0Li6q0RXwmiM+MDXxD/RPfLhwX7cxLtpl9ozGG?=
 =?us-ascii?Q?Q1n99fflkLXEkfMTw3hd1zo1kv0njMzRQjgHCU/Ub043HnJm53TW48GF7oiK?=
 =?us-ascii?Q?zNbDSuHx1DNG5WvC+dTHYs5asAQ6ayrsLYNv63ufOgZkb3190qZ/axxVLmWo?=
 =?us-ascii?Q?Nwykq1eGy2APLZok6jgzLCIclYKcsrp0HkjAgVG7Ecmsj/OGIKxhYNA5xyrI?=
 =?us-ascii?Q?jbK8XFnj/XOksZg78i9sMRegXt4uxkNA3GHr0p2ak32XRJ/4LcLHC0mQeC18?=
 =?us-ascii?Q?ZJmkpOD3qcToGhKrggZukFf/HjW6hRYwR10ycHVgyteEGPDUfRJBkaHpNJea?=
 =?us-ascii?Q?9xogOCidmw64ValRJsRAyzR3MHDPp39xTcxsJgK0kcb+/SHpBTfQka3rR68J?=
 =?us-ascii?Q?sdK1Krx2Da90xAAjqOY1jYq5CSUkMcVHOsZRdy0vS/gL3BXVFP1/d9nzJoTT?=
 =?us-ascii?Q?1S6fx6knm/xEPF49SO1dDkGc6KbPmCsC6jmd+y+wSqeK8l5TYYiAr9xm18HL?=
 =?us-ascii?Q?NBt6+LqptzI1v1UqT0wdLLR66rYZ7at7u4tsSCiQ/8fUl+aik4jE1ui/SaZI?=
 =?us-ascii?Q?rVzhUoohLO4SNIIEqY+t2RFHnLjPvYxAO65bJDoih4sABOTRchuSSAqMwVlW?=
 =?us-ascii?Q?5xC6K3WSQVhI+BYqlI8Vi3lM/9eka2cC6cJT2NFHoDO6+fsrvsumjwgKsjph?=
 =?us-ascii?Q?h0EqqggIqLn75p6uVHelp7USOX+ip9BAmfaRyhsrydS7CYlGGgfUhBwUduQz?=
 =?us-ascii?Q?VCOwScDDCrOBIxCafihqYMRjbzkw/5K/ZuKOelNbjbe7Uzp52RR3XetD1vPK?=
 =?us-ascii?Q?Xh1Is+m/T82ELSOf4ulVxs/On0H6I+ck7u7vDLlujLU5o2Mx45kVLTCkqsCA?=
 =?us-ascii?Q?D2Zn30oZoVdxogaDKEgoHOwVBdUMGtx+8qzyH3jBmSFax0kOpGAZAalNiTOd?=
 =?us-ascii?Q?CfL6zsYk66JQjoDpIBVemhUY?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e6a7ea-b34f-4fb1-c2e9-08d92d884d75
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 09:56:08.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1u2nej4krKDVknM2M77kXKmJLWBFMFNSMTQ4vMN5TKGCYVcXN21duXtECFwsUq4EwT8EUcEUGdMiT8ml2YtU6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1601
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This checks if an outstanding call to AcquireWrite is already in
progress. If so, the write request is placed into the queue, but
AcquireWrite is not called again. When a response to AcquireWrite is
received, acquire_write_reply sends all queued writes over the acquired
socket.

Making multiple simultaneous calls to AcquireWrite makes no sense,
as this would open multiple socket pairs and only the last returned
socket would be used for further writes.
---
 src/gatt-database.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index be6dfb265..8cf60c597 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2378,6 +2378,26 @@ static struct pending_op *send_write(struct btd_device *device,
 	return NULL;
 }
 
+static void flush_pending_write(void *data, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	struct pending_op *op = data;
+
+	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
+					write_reply_cb,
+					op, pending_op_free) == TRUE)
+		return;
+
+	pending_op_free(op);
+}
+
+static void flush_pending_writes(GDBusProxy *proxy,
+					struct queue *owner_queue)
+{
+	queue_foreach(owner_queue, flush_pending_write, proxy);
+	queue_remove_all(owner_queue, NULL, NULL, NULL);
+}
+
 static bool sock_hup(struct io *io, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
@@ -2488,18 +2508,19 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 	chrc->write_io = sock_io_new(fd, chrc);
 
-	if (sock_io_send(chrc->write_io, op->data.iov_base,
-				op->data.iov_len) < 0)
-		goto retry;
+	while ((op = queue_peek_head(chrc->pending_writes)) != NULL) {
+		if (sock_io_send(chrc->write_io, op->data.iov_base,
+					op->data.iov_len) < 0)
+			goto retry;
 
-	gatt_db_attribute_write_result(op->attrib, op->id, 0);
+		gatt_db_attribute_write_result(op->attrib, op->id, 0);
+		pending_op_free(op);
+	}
 
 	return;
 
 retry:
-	send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
-				op->data.iov_base, op->data.iov_len, 0,
-				op->link_type, false, false);
+	flush_pending_writes(chrc->proxy, chrc->pending_writes);
 }
 
 static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
@@ -2527,14 +2548,18 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
 					uint8_t link_type)
 {
 	struct pending_op *op;
+	bool acquiring = !queue_isempty(chrc->pending_writes);
 
 	op = pending_write_new(device, chrc->pending_writes, attrib, id, value,
 				len, 0, link_type, false, false);
 
+	if (acquiring)
+		return op;
+
 	if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
 					acquire_write_setup,
 					acquire_write_reply,
-					op, pending_op_free))
+					op, NULL))
 		return op;
 
 	pending_op_free(op);
-- 
2.25.1

