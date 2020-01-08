Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC2C33C99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE72206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo88FewY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgAHAeI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:34:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33144 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgAHAeI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:34:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so358249plb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M2Up/tmikMUiLUcniWn1O0KhIXuMcGa8zC92O3BiMhc=;
        b=Bo88FewYi7sMMdv/cbTKEYaRk9mSY4NgNKyEz3wG3n/gHQKjay1pa6PN2kPmLj1D77
         0kdjULkp/0ew1VvjzOSRYzy/cSZvVxGJlHRVxAWtjstmqilfFkQvCB5BddhnIU3rLeZN
         BISPnEwvryCFFgDy2QYUitSnU7RIlgRqrgb9lK5TwvS9z269rlFpfRz+rjgvCj/mXOJu
         Ph4KjPMJgp+wJ9Nn4hEDEBTeqM5xfUql3aRu4qd+XFL50xPb57VBFhEkp80A0J4evJMT
         3A3vQiXl3pgjdKDcaXbwJxh7sRPVVRWugDx4MI27kBOuSejFOE7Ltwo3+Ub2AmoTL7Wh
         A1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2Up/tmikMUiLUcniWn1O0KhIXuMcGa8zC92O3BiMhc=;
        b=D57peuX605vj2Np5v8WrAYVfOyrSygAE1Wn1+WvQTAgiOAXE8fEK+Armx36Tl4IBPz
         wd+H0F/OrHv0ZF36k3nWeK1fXM8cFlXoHrz644R4OySENBxb3IV50k2vlYHJFgR+qhjW
         E+4018JV03bTUCHI3s3Zl7fqrKEN97n0mcxuXapfuj0GOPgppmVbjNkf1WP0HJkN88mr
         NRBrzHwE5FppOSLu/a73b8Je/SN+4ovndySEFWdzxisjvxJ8JCmA7jzJT5KcEanP6yPr
         6kQGdJHOhd3qJAQ82QfvixSmOu8IfPhQAklAj7eaYmz5eghkgzUqrM9/nCat7zzH9+V4
         8fMA==
X-Gm-Message-State: APjAAAVM2/oBOo/5O1vK3D7VoJAf7fEseFBvZwCW/1XoTpex38FGR0k4
        w/eFUjwzYhY4YIbTSboHWBsWFmKY0q8=
X-Google-Smtp-Source: APXvYqx4oTMBF+a+idR4EYoRgOxPumfWFmQL5Gl3fdYlOYDUBkHgmT50gXmRZy/LWyFDfKXy+n4eCw==
X-Received: by 2002:a17:902:ba97:: with SMTP id k23mr2456485pls.343.1578443647377;
        Tue, 07 Jan 2020 16:34:07 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.34.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:34:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 22/22] monitor: Add support for decoding EATT
Date:   Tue,  7 Jan 2020 16:33:42 -0800
Message-Id: <20200108003342.15458-23-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
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
2.21.0

