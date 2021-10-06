Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CD9610CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbhJFVjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhJFVjA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 17:39:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A2EC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 14:37:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s16so3573093pfk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQoQWOHtg+xqx/g3tsUgc6AI4/i0B378SYVjJ/euaKc=;
        b=eH29H/tqKUVs9UD/X1H06QXjJ/KKEvcS5xet9PsEcDlgfPZRWkOfZiUu4kc+MUvKGF
         yDmd66yBsZ1Jq4SoBR3ubtRaK5QKIuadX9nHWTlRB+nnlSyeJiSYtQEKSJYL4QW+PI0V
         G3hDylUo5Ubhh6PLbBORCJhVAvEgisFgP1+tmwoIbX1MSYbpaRMWvy71u8nYUEwyjuGQ
         rK//wWUJTgAaY5Xhg2uQMaeIhBHc+6Ue3by5Upe9HNweFMex5zooZaGt9k9pIAbkBYQ7
         RYC8ckfsi82igh5Znf5kGZujMVOi5o6t4U7KLD0JNd7btjj2MDXGarQdUapz6cnS3GrU
         KxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQoQWOHtg+xqx/g3tsUgc6AI4/i0B378SYVjJ/euaKc=;
        b=QDIDNzoj60eYEzuxl1oCqBXs87N7FJ58NuKCTHsDwMwb0koT9nrjqYYUWWPArMzF6G
         AZvLFuEsmcTayDsWz50Zl+M9D/ClfVFSm8agtB9ApW+Ptq98EZacnkZCvSaA91gJnQAQ
         Uou1qMts9myE8mAYZScEebGDkjZObG/mfNLcuoHbRr77xY3DE1U3Ka15QHhh++6ZODBM
         mIXKYkzeFlAoNmLfuu6M+yr4Fs6iHimEJjuv8Xad6yN3inI1z8k1Sw5UJae1V/GN+6zS
         FhPSP1jOV8IZzP0tkFX9NmMedIibcd+fLwkQUVy53qeYxubNLeC8+pMT7sCuK0nl+23t
         WMVw==
X-Gm-Message-State: AOAM531+u1HGnPxnrVkr620bgtpFDtwiyhzZDqDLqu+mD/B1KNJVR4PP
        y4KthDiqT0b6OyBvcMJcFC+Uiof1BNo=
X-Google-Smtp-Source: ABdhPJzYbBTJURcNUigPRA/2STzv218KHGXZgua4mDVngnnU2mwVnp62oN3+mhiAEqme8iSMc6LyFg==
X-Received: by 2002:a63:fc65:: with SMTP id r37mr343254pgk.28.1633556226858;
        Wed, 06 Oct 2021 14:37:06 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e6sm11858763pgf.59.2021.10.06.14.37.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:37:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/att: Add bt_att_resend
Date:   Wed,  6 Oct 2021 14:37:01 -0700
Message-Id: <20211006213704.1093265-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_att_resend which can be used with procedures that needs to
send multiple PDUs to complete (e.g. Read Long, Write Long, etc.) so
they are pushed to the head instead of the tail of the queue so one can
retain its position on the queue.
---
 src/shared/att.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h |  5 ++++
 2 files changed, 64 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 2387fe4c3..169f726e4 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1615,6 +1615,65 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	return op->id;
 }
 
+int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
+				const void *pdu, uint16_t length,
+				bt_att_response_func_t callback,
+				void *user_data,
+				bt_att_destroy_func_t destroy)
+{
+	const struct queue_entry *entry;
+	struct att_send_op *op;
+	bool result;
+
+	if (!att || !id)
+		return -EINVAL;
+
+	/* Lookup request on each channel */
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *chan = entry->data;
+
+		if (chan->pending_req && chan->pending_req->id == id)
+			break;
+	}
+
+	if (!entry)
+		return -ENOENT;
+
+	/* Only allow requests to be resend */
+	if (get_op_type(opcode) != ATT_OP_TYPE_REQ)
+		return -EOPNOTSUPP;
+
+	op = create_att_send_op(att, opcode, pdu, length, callback, user_data,
+								destroy);
+	if (!op)
+		return -ENOMEM;
+
+	op->id = id;
+
+	switch (opcode) {
+	/* Only prepend requests that could be a continuation */
+	case BT_ATT_OP_READ_BLOB_REQ:
+	case BT_ATT_OP_PREP_WRITE_REQ:
+	case BT_ATT_OP_EXEC_WRITE_REQ:
+		result = queue_push_head(att->req_queue, op);
+		break;
+	default:
+		result = queue_push_tail(att->req_queue, op);
+		break;
+	}
+
+	if (!result) {
+		free(op->pdu);
+		free(op);
+		return -ENOMEM;
+	}
+
+	wakeup_writer(att);
+
+	return 0;
+}
+
 unsigned int bt_att_chan_send(struct bt_att_chan *chan, uint8_t opcode,
 				const void *pdu, uint16_t len,
 				bt_att_response_func_t callback,
diff --git a/src/shared/att.h b/src/shared/att.h
index de136a066..4aa3de87b 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -63,6 +63,11 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					bt_att_response_func_t callback,
 					void *user_data,
 					bt_att_destroy_func_t destroy);
+int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					bt_att_response_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
 unsigned int bt_att_chan_send(struct bt_att_chan *chan, uint8_t opcode,
 					const void *pdu, uint16_t len,
 					bt_att_response_func_t callback,
-- 
2.31.1

