Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E8BC48BE0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52616109E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFKMcy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 08:32:54 -0400
Received: from mail-eopbgr60126.outbound.protection.outlook.com ([40.107.6.126]:52883
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230188AbhFKMcw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 08:32:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzLM0vnCGbTz5oYHkrzeN720Medi3unVCSeiLhHFK/haP1A51WQfelfZZpXg5+La8ZaFbCf04+7zAiRd9Y9p0GPKpdAL/ESb4aMkKG2RZ/Cc2Z2IlFIDSGHpU3BwbSpwOIfuR+7bkN0hNPROn9BAm/QePK2De95omkzLzTNcKLuvFOs+uvaGpDwmq0RY51ij5eBtcalTJ2yrDESh65Kecw7lj/aQGE92iv9JwUzQOW3QvPY9y7X+OTHawY9/aLBhTqjqG/OqxMga/RFA5q5t8j3FiYLdO6noH1I7USbhSIjv0GLNKAeSh/zlOq+yQ3jg0TEuMgFBwL4VbRhLo2OIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsH8RHkaryr2LpXsl2oyFShap6UHwiaDEnRwY1m8XOg=;
 b=G4/yKKDENhvaeSfplQfMspvmofGqEdK+kaUi7+6+gYrshdNIASchduBwAmDtEiopfYbE9PLT1o5kT+gpzYWc6iacZXzol94C0h9k8eb42MvUtJuQmp9YDmx8PXMNIRicMgC7cdr+dnZh/NkrtDu/8H86iWVfBJotnlpAyiwb2VMIQwF8JrNI53BXgyBQRAGtEdW+LcXJdu5Q/N8sFU6h7zq02Qv2OP+rdjVOn2lxjoVvK3FMe9zYpNbjYtcwD6oxyiOt+n8tHY8LCqqOz63Av+GB/P6ORxda72pjQjOW80wHzyK8rieNRdUvcrCG8Ci6fu47qO8ppPEX9FiF6ct/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsH8RHkaryr2LpXsl2oyFShap6UHwiaDEnRwY1m8XOg=;
 b=a63JYoPAWlCg80hdnQkLP/lQnoxU4iHlhPOUcCYrqzFI7SYlltdMS1Fwz2NvnSAQSLlR21iIEYslIVwVuHbyHfHmAd/99fa/MpDTUwuhGWNhvqZzUv7vpx/jMTLN2+460fT5gwArqIjawyMJWqgY7pRAvWtO5aDHJgHa6VGybzE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM0P189MB0676.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:196::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 12:30:52 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 12:30:52 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-database: No multiple calls to AcquireWrite
Date:   Fri, 11 Jun 2021 14:30:42 +0200
Message-Id: <20210611123042.21288-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 12:30:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a45b27-17db-4a8b-fa37-08d92cd4c08b
X-MS-TrafficTypeDiagnostic: AM0P189MB0676:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P189MB0676FE4D2CB1F8001847FF02AB349@AM0P189MB0676.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HK6ZQC1MKFlG9KoNDlq36CDXtBKt8+975qxvt5zHl0VEMQSac4TfXk9YnCzZ2otIkHjbub7VMpQzQiecxuz7Z5yMvEeuqXqjVqLjnzTDOUQREuvHODJlxdxqwd4t4LJK81u+ZirG5fP+064zvqTlhk7ksaAgMyR3oeNZIB/KB7SenkKboT6fwotLmtMgqbtdOydIPju5yuODQ8lQCCzD/9vSqkLGXvUhbNRPpbCG7S08ypFmXNh3HTCNmY2BCQa7yAU8QqlzypEVY78yK7JvswuP5s8k5ZFVR/Gitx5wv+KF89Ou/Or8/ykc6Om1V8o/9cXhKJTHWbtBRGFBtKil9+5YRmCMIG+F8dut/ZmRYXt3MwK72ry/hv/4vYmWZKtIHPEENHzWVSQ3uw0bF0yDYKmjkEO1BuXb9FDy2t9O6Jtj9jdD66v3J/Bd7plvh984aCd7hAGcwrxOnWEg4j9zKFRs1fN7wsWIg02aV0WOkujXix4uPMu6dYbbos1iCZ99SRang4KQBzWtiC0/DBV5Ab3qtPjohTpT2nk/9moNUnQxay3GOgwNwOjwZZC5K4GAKsSG7JEcxcMmDYufH3PzNblvjcs4jyqcruy7OoHBCz4zFDl0hdQhHqiBEnNCXQXpFl1xpKeVDXPla7LFYzT1nEVuWgbJyCJXIHcFiue4HhlUu4O0+BOpNUiBV4N3XGLa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39830400003)(36756003)(86362001)(2906002)(66946007)(6666004)(26005)(1076003)(6916009)(5660300002)(52116002)(6506007)(956004)(2616005)(478600001)(66476007)(316002)(6486002)(186003)(16526019)(8676002)(107886003)(6512007)(8936002)(83380400001)(38350700002)(4326008)(66556008)(38100700002)(130980200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iv9HyyTorE+WCKX4yPXdg615fLOzzyAdHxJc/hAdzSL6BQsJcxDfryP6ppyv?=
 =?us-ascii?Q?4//IatZmlw0euHwg1DZlf0IrzG4IWkmKcYXGeWPtO+wzxoUgaPX+KnUa4cL/?=
 =?us-ascii?Q?yQMcxVzL1IG+UcTvSxcqKrkagCsTsbRMX+K5A5JOjRPK7+/RIkJLEvupnv00?=
 =?us-ascii?Q?X1UHvKmt4FzNmhsW3Q5Q8Mv8iyr9ljuGb755kxE0z5QxuVs0yKlitqjJTa1j?=
 =?us-ascii?Q?0RkKl0gczNjxceEJTn0Rf3VjI8s50OwItXqhAGh0dER79Ihq6swTmxX95lOV?=
 =?us-ascii?Q?V9zu5HiCy6se/fZJTRV7xIFzbm2KURiHjSgweOaEMZ6OB7pEg3Nhq50Lacku?=
 =?us-ascii?Q?H8nlIhmYLJuhRZto3JBkyOMw3Zr3J/J8IeTzpZVeoXutQzEjY+GjmsDEoFLw?=
 =?us-ascii?Q?5i198LMxr4hOdQjpq8+iXsRv7PjnZ+ev1oOMT8qTriPhgnhykxrvDt4VRwUl?=
 =?us-ascii?Q?bOByOBJPQakoq5p7n7qKECYxUf6PzFNF2ykfvv7zFoQCLfz+QLLv5AUfCDdh?=
 =?us-ascii?Q?Rzpes/EEeHRkCp67TZk102Y5+Q5CW9R+H/wjJRRQKuHuAr/BM+S9Js8MnCh2?=
 =?us-ascii?Q?aI7H7AA54yiigQFdn7lE+cLd9BWZPbsBIWTmM76zY+CTV5zy04iYpdT//LJX?=
 =?us-ascii?Q?pJfUfp1EqNfB40bmWu5LnHqne5elsb1ImI73qh4em6NPHKXMcfi4w/037YHX?=
 =?us-ascii?Q?StaYwf+iO0FLdK19MK/RqtBy1xB5OIjUEceI1UIt3jtRv2sdHAwQw9iEVICC?=
 =?us-ascii?Q?JLOexdhs9x3Mq+NjRIKndDMHBJhHLp6JORjQA5L9e0MlAebD0Wk8u9I9RU65?=
 =?us-ascii?Q?zN6hr7DnGOHvuPDmGN/+ViUrZIK7Wk4zUB14hZEMS8NFfWkpoz/zUQav0643?=
 =?us-ascii?Q?LL4St+w0gBbizE/43vWOJR2pj1Ois3K7EdsRukxO7THus7ean9vA4o6oJUvN?=
 =?us-ascii?Q?kKxCXZ3FbFGLU9IzWiN4aIdEb2TE4RXCSbCXgHviIG9w2PWiLP54D9uDyebe?=
 =?us-ascii?Q?JJl/pXjPL+4IzlQ4WCGJu+CiZmGBymDsUS3qvKkowbSP7Nz8FfJzfmX09eTf?=
 =?us-ascii?Q?2xp+rMRFpfG+b8CdXwV65aXE4vyqctsa6SkGKMsfyfiXz3v+gdIVYodFhFwg?=
 =?us-ascii?Q?Anr15UDWn2teyb94uxOlrsXsgXYfsW2dwHot74t5ymvDAbr+wHOzpIJNKEQK?=
 =?us-ascii?Q?7CQVXgUHOPkzT1dAHk6Gyyd/scgRcxKw8k8vsVD2Le4ux7UKKLLmWEMKjkbC?=
 =?us-ascii?Q?eEV7Wst0NR05ZFAMi5xwvjvcY+J/0UMq02MhX881A5Sx3LZgyLHv4DJ2VS5N?=
 =?us-ascii?Q?ufJBmDTvE5cd/q3BOKosbHVf?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a45b27-17db-4a8b-fa37-08d92cd4c08b
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 12:30:52.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4zHPXPoRO7SB70kA9b8KbFeVcCu3NFfxJX8FY5pHEGP8ysI+/4LTf0K3f3qNHgO5aWcdTh15W3wLps7pmlvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0676
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
 src/gatt-database.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index be6dfb265..071f88583 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2447,6 +2447,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 {
 	struct pending_op *op = user_data;
 	struct external_chrc *chrc;
+	struct queue *resend;
 	DBusError err;
 	int fd;
 	uint16_t mtu;
@@ -2488,18 +2489,35 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
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
+	/*
+	 * send_write pushes to chrc->pending_writes, so we need a
+	 * temporary queue to avoid an infinite loop.
+	 */
+	resend = queue_new();
+
+	while ((op = queue_pop_head(chrc->pending_writes)) != NULL)
+		queue_push_tail(resend, op);
+
+	while ((op = queue_pop_head(resend)) != NULL) {
+		send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
+					op->data.iov_base, op->data.iov_len, 0,
+					op->link_type, false, false);
+		pending_op_free(op);
+	}
+
+	queue_destroy(resend, NULL);
 }
 
 static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
@@ -2527,14 +2545,18 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
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

