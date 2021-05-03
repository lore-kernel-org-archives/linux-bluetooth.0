Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F2C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D56611EE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 13:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhECNNR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhECNNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 09:13:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BBDC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 06:12:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1ldYN3-003ODA-B3; Mon, 03 May 2021 15:12:21 +0200
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <bberg@redhat.com>
Subject: [PATCH] rfkill: Fix reading from rfkill socket
Date:   Mon,  3 May 2021 15:12:10 +0200
Message-Id: <20210503131210.90066-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

The kernel will always send exactly one event, but the size of the
passed struct will depend on the length of the submitted read() and the
kernel version. i.e. the interface can be extended and we need to expect
for a read to be longer than expected if we ask for it.

Fix this by only requesting the needed length and explicitly check the
length against the V1 version of the structure to make the code a bit
more future proof in case the internal copy of the struct is updated to
contain new fields.
---
 src/rfkill.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index ec9fcdfdd..2099c5ac5 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -53,12 +53,12 @@ struct rfkill_event {
 	uint8_t  soft;
 	uint8_t  hard;
 };
+#define RFKILL_EVENT_SIZE_V1    8
 
 static gboolean rfkill_event(GIOChannel *chan,
 				GIOCondition cond, gpointer data)
 {
-	unsigned char buf[32];
-	struct rfkill_event *event = (void *) buf;
+	struct rfkill_event event = { 0 };
 	struct btd_adapter *adapter;
 	char sysname[PATH_MAX];
 	ssize_t len;
@@ -69,34 +69,32 @@ static gboolean rfkill_event(GIOChannel *chan,
 
 	fd = g_io_channel_unix_get_fd(chan);
 
-	memset(buf, 0, sizeof(buf));
-
-	len = read(fd, buf, sizeof(buf));
+	len = read(fd, &event, sizeof(event));
 	if (len < 0) {
 		if (errno == EAGAIN)
 			return TRUE;
 		return FALSE;
 	}
 
-	if (len != sizeof(struct rfkill_event))
+	if (len < RFKILL_EVENT_SIZE_V1)
 		return TRUE;
 
 	DBG("RFKILL event idx %u type %u op %u soft %u hard %u",
-					event->idx, event->type, event->op,
-						event->soft, event->hard);
+					event.idx, event.type, event.op,
+						event.soft, event.hard);
 
-	if (event->soft || event->hard)
+	if (event.soft || event.hard)
 		return TRUE;
 
-	if (event->op != RFKILL_OP_CHANGE)
+	if (event.op != RFKILL_OP_CHANGE)
 		return TRUE;
 
-	if (event->type != RFKILL_TYPE_BLUETOOTH &&
-					event->type != RFKILL_TYPE_ALL)
+	if (event.type != RFKILL_TYPE_BLUETOOTH &&
+					event.type != RFKILL_TYPE_ALL)
 		return TRUE;
 
 	snprintf(sysname, sizeof(sysname) - 1,
-			"/sys/class/rfkill/rfkill%u/name", event->idx);
+			"/sys/class/rfkill/rfkill%u/name", event.idx);
 
 	fd = open(sysname, O_RDONLY);
 	if (fd < 0)
-- 
2.31.1

