Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758CC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCKAuQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCKAtz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:49:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6770114EE7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:48:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so8880996pjn.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GcnDg8Z7WGEEH1ZaQ3pRyfxNZF7233jBeqjI2RRVg4w=;
        b=bEqaUDaqheuApggrq6k9gP6A3jEvnGhORzL33SvYd+I0sZGMaCXnmb6JkVNk4nKKw7
         8vAbffguZw6Y9voSNWbXvkH9I894Avy8/upTWsi5Z+UJgF1Okh2/AexWkhpV++FdgCoI
         cs9WK5ydYZvgJD10eeE/WkztiZLWQ/8tGHnCowQ0/uVPXKwfNwPoHfotPeCaMRvjtnlv
         75FRAFUQ16NYIT+Blj6dfnW/GW4pqGT8cMXDAqye6MCljQvxBcxjwkRqad5Nznb3BreI
         Vz7awypPQdFwd5b81pySAVkBxrXAMCC8BPJJxrdkdw/UMV87hjfxPUFVQkD/HAhQsieX
         JtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcnDg8Z7WGEEH1ZaQ3pRyfxNZF7233jBeqjI2RRVg4w=;
        b=ijOFF/yHGPBvAzq9fwg+kSmWYBYfD2qX3gv3sv5mMiQ71VETxNLtKYKv/FAwMvfYql
         DmWgm1IqFu9CWsZIuM7scOGT2sePruMgUC+wqenJNe5sgMqeCMAjxeY47hAYhnCd8Q68
         iRdUlfDq0AG2qWNGBj7ftBH7WejGEK0rDfN7xRnVZZrur5cim7RMzOVlZo6oD3YK81nj
         H8Obx0Z6I2nRZrA8P8RdxdZbqk3cIeHXqbTXm3ZNSrMA8dDcaHBIdLQ7dkSEX/590whQ
         uAaQWD45VfTnidx8r4qTXwetZfDhy9mE7itNDqPmEvR45oaPtLOISJeWMunTHFVih9Uu
         U4Ng==
X-Gm-Message-State: AO0yUKVNaqOD0HRRGwHiWq3NTkCeb/P+xzm9Pg2ASODLRp9MXDVW14p3
        /6H4ojM5KG7/pkIURW+QngbXdVSBBxA=
X-Google-Smtp-Source: AK7set/AaBAsuGCYxc8qv7fN3dK9ZJSazwWswmQ7C+epEx77nr62lMMpHadMNEanP092Cvrtn+AfuA==
X-Received: by 2002:a17:902:e80d:b0:19c:cb64:dacc with SMTP id u13-20020a170902e80d00b0019ccb64daccmr32657725plg.61.1678495642342;
        Fri, 10 Mar 2023 16:47:22 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kh12-20020a170903064c00b0019f0f670c00sm508826plb.225.2023.03.10.16.47.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:47:21 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Use a short timeout for EATT bearer
Date:   Fri, 10 Mar 2023 16:47:20 -0800
Message-Id: <20230311004720.4017529-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses 5 seconds timeout for EATT bearers since it maybe possible
that other channels can be used so the operation can be resend.
---
 src/shared/att.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 85feead77d0f..b8fc44b16b20 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -30,6 +30,7 @@
 #define ATT_OP_CMD_MASK			0x40
 #define ATT_OP_SIGNED_MASK		0x80
 #define ATT_TIMEOUT_INTERVAL		30000  /* 30000 ms */
+#define EATT_TIMEOUT_INTERVAL		5000  /* 5000 ms */
 
 /* Length of signature in write signed packet */
 #define BT_ATT_SIGNATURE_LEN		12
@@ -42,6 +43,7 @@ struct bt_att_chan {
 	struct io *io;
 	uint8_t type;
 	int sec_level;			/* Only used for non-L2CAP */
+	int timeout;
 
 	struct queue *queue;		/* Channel dedicated queue */
 
@@ -470,6 +472,8 @@ struct timeout_data {
 	unsigned int id;
 };
 
+static void wakeup_writer(struct bt_att *att);
+
 static bool timeout_cb(void *user_data)
 {
 	struct timeout_data *timeout = user_data;
@@ -495,7 +499,16 @@ static bool timeout_cb(void *user_data)
 		att->timeout_callback(op->id, op->opcode, att->timeout_data);
 
 	op->timeout_id = 0;
-	disc_att_send_op(op);
+
+	/* Resend op if it is using EATT bearer and there are more channels
+	 * left that could be used since there maybe a problem with the channel
+	 * e.g. not enough credits to send the entire packet.
+	 */
+	if (chan->type == BT_ATT_EATT && queue_length(att->chans) > 1) {
+		queue_push_tail(att->req_queue, op);
+		wakeup_writer(att);
+	} else
+		disc_att_send_op(op);
 
 	/*
 	 * Directly terminate the connection as required by the ATT protocol.
@@ -585,8 +598,7 @@ static bool can_write_data(struct io *io, void *user_data)
 	timeout = new0(struct timeout_data, 1);
 	timeout->chan = chan;
 	timeout->id = op->id;
-	op->timeout_id = timeout_add(ATT_TIMEOUT_INTERVAL, timeout_cb,
-								timeout, free);
+	op->timeout_id = timeout_add(chan->timeout, timeout_cb, timeout, free);
 
 	/* Return true as there may be more operations ready to write. */
 	return true;
@@ -1204,9 +1216,16 @@ static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 		/* fall through */
 	case BT_ATT_LE:
 		chan->mtu = BT_ATT_DEFAULT_LE_MTU;
+		chan->timeout = ATT_TIMEOUT_INTERVAL;
 		break;
-	default:
+	case BT_ATT_BREDR:
 		chan->mtu = io_get_mtu(chan->fd);
+		chan->timeout = ATT_TIMEOUT_INTERVAL;
+		break;
+	case BT_ATT_EATT:
+		chan->mtu = io_get_mtu(chan->fd);
+		chan->timeout = EATT_TIMEOUT_INTERVAL;
+		break;
 	}
 
 	if (chan->mtu < BT_ATT_DEFAULT_LE_MTU)
-- 
2.39.2

