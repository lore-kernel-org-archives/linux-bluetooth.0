Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06387C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0409246B9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BomLSKbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1XrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39197 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgB1XrS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id s2so1438852pgv.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ihpr9Y1VTzQzgPw9VEZXNNYIhYzl+fh8ZyruBbafTqs=;
        b=BomLSKbxqm14l62RVdci9cGy5/vAT/By4PN2LjJaYz6s6lm2yhB3U10E8fqfTgkg29
         mB2vT0dPdnqg5TC+C3EXfiPT3ER1OJERjub5x8iBt4NLtEfZ7qYKcEzJq0S1VCNeAPUP
         ire4Eq99v9QqFSjffMUYjUrr73p4F3bqrxy5omdrcBTxeNCBVw1Kd5mlVsJWscEEThjO
         uBNqDy68mumYqaY5k4tlIjQtrzkiiH0/ryT5z3hxntEftCFPc31ecMWgWb8uq4GkI6oT
         vJLYGgToXxKHBvOM3rTwtV3LInUyB/z3R2of7WfpyaNUdIT+x9zJiYHvX5ordLdYXtWq
         WceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ihpr9Y1VTzQzgPw9VEZXNNYIhYzl+fh8ZyruBbafTqs=;
        b=aBVFvNMsd7Hncqwjsyfk2BVUJFxpyPe2oCuYknxcikBpcz+/tES5B7XwJp/8r9FN6R
         BbncSuFz4uVCM50vgVUL2ccGWYmRtoZ3YoLjqT2rXm7D/cKfifm+bJe6T4+Jlv79yBNV
         98NwLT1pFl6zo4xxpPXtt4q11Rp5oPKVx2KP2eCzTQsso1mzwwZ71AYp4WgB/vUrCiZB
         LJoX72IuTXp37G8wyulsTyMni+5N7mZqJhdoncbm0aVySCKtHTE/kybrb7jAAyZj2ZMl
         4l9atD76iP2pJfV3L0l0IsQ6sYk20LpyooNp6S1PLF1sYC9mlwLCk/FWIGRTRUhBq6Rj
         PzFA==
X-Gm-Message-State: APjAAAWQbG2ODstB2r2jnhJkhN4iWkSdLgaZynstnbpo47VRyJlh9TPg
        sUKt+f30A8kBadRxrh/A5KFF2c7nHqI=
X-Google-Smtp-Source: APXvYqyW3v57MPE2tPOo3vYqBeHnxM5MQSErh4bz4Wa62RLiXiq+jeJ93cy9oafsSBTQagqoc8389w==
X-Received: by 2002:a63:6cc6:: with SMTP id h189mr6781156pgc.201.1582933636601;
        Fri, 28 Feb 2020 15:47:16 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 12/12] monitor: Add support for decoding EATT
Date:   Fri, 28 Feb 2020 15:47:01 -0800
Message-Id: <20200228234701.14614-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This decodes packets received over EATT PSM.
---
 monitor/l2cap.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 3b2b25f24..9409604c3 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2573,6 +2573,36 @@ static void att_handle_value_conf(const struct l2cap_frame *frame)
 {
 }
 
+static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
+{
+	struct l2cap_frame *f = (void *) frame;
+
+	while (frame->size) {
+		uint16_t handle;
+		uint16_t len;
+
+		if (!l2cap_frame_get_le16(f, &handle))
+			return;
+
+		print_field("Handle: 0x%4.4x", handle);
+
+		if (!l2cap_frame_get_le16(f, &len))
+			return;
+
+		print_field("Length: 0x%4.4x", len);
+
+		print_hex_field("  Data", f->data,
+				len < f->size ? len : f->size);
+
+		if (len > f->size) {
+			print_text(COLOR_ERROR, "invalid size");
+			return;
+		}
+
+		l2cap_frame_pull(f, f, len);
+	}
+}
+
 static void att_write_command(const struct l2cap_frame *frame)
 {
 	print_field("Handle: 0x%4.4x", get_le16(frame->data));
@@ -2645,6 +2675,12 @@ static const struct att_opcode_data att_opcode_table[] = {
 			att_handle_value_ind, 2, false },
 	{ 0x1e, "Handle Value Confirmation",
 			att_handle_value_conf, 0, true },
+	{ 0x20, "Read Multiple Request Variable Length",
+			att_read_multiple_req, 4, false },
+	{ 0x21, "Read Multiple Response Variable Length",
+			att_multiple_vl_rsp, 4, false },
+	{ 0x23, "Handle Multiple Value Notification",
+			att_multiple_vl_rsp, 4, false },
 	{ 0x52, "Write Command",
 			att_write_command, 2, false },
 	{ 0xd2, "Signed Write Command", att_signed_write_command, 14, false },
@@ -3287,6 +3323,9 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 		case 0x001f:
 			att_packet(index, in, handle, cid, data, size);
 			break;
+		case 0x0027:
+			att_packet(index, in, handle, cid, data + 2, size - 2);
+			break;
 		case 0x0017:
 		case 0x001B:
 			avctp_packet(&frame);
-- 
2.21.1

