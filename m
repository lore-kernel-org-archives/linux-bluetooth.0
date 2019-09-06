Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7959AC00307
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 19:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D020838
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 19:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDLrYv0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392825AbfIFTH1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:07:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfIFTH1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 15:07:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so3982103pgb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Sep 2019 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcAcfV/1aytS8YWfBaGsXQyMFYMczD5w2us5j4aHxG8=;
        b=rDLrYv0AUkgSY8OCF8xlcDI9BnLCeLvFihsKNiVre7mELqLbZH11jd2HvAiHmfH2FS
         YoOVa+IF9YuSkiU5nvp0afvK1eAVPrYzrV5jlrKcxBh2QOJr8nyljbUx0PDZ2IPErPvg
         9Z9L0fqQxuxjrH3ccK+ziL5HH6/3EIXitaxeZrib/6wtTBMqNW82icCDzIc6AhDWMI52
         AkOxA+ikiCpmPDqxK6uAD5HAIioJ3ZUmr+hnf2an9CLANOOJ+cqSK4UaS5pQ67kjay0M
         BPEVUBu9H+pZkzh2XlOO6nH6FxldaqDqTlAsQmWyPORcQ6G7Mh7Jze312QZLkZoI9RmE
         IafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcAcfV/1aytS8YWfBaGsXQyMFYMczD5w2us5j4aHxG8=;
        b=MbYZJQA1RpEFNeb5ZKHnr9GCp1u/OeJICWyCsZ9XHAI8W2mWqpGUhDucvgL8UGqb7I
         2DFbR/JPVhHYH53uz8Tx9uBbi9CnKdwW0m9x2xyMDwsYa5nOQ9yrtllkOVEQLWkwin3I
         sU/9d2pzukw1Tdc4oyOfwEZ15qLolT2NuutjKigbseIs8fFpkaS2x3CxRk3QrS3eIEHT
         DLkzwSJygpnRuSDwEjfP0R2uVkEaindu8NfIQLoNl16m6nKpVppu7f472yAvWsJB4Gvn
         HdyY7D/or+YpXFIkX0MhjyRgCaKrR7wqC/9nZ3ClcTWgo4jRNRGTsRO2fG8J4dY8m0qn
         0dOw==
X-Gm-Message-State: APjAAAVB/MpFU9dI5b0c6SQWtdzDmqi+utNYUwH/kgW9vVN3B0/KJj8/
        BxTA+2WXesn9cT6KbSXSiAO+eYLAIUU=
X-Google-Smtp-Source: APXvYqwn4x9JhDnumm6brkZXvhCjKKdSlBGiM4fazdZkQmqmCFmlZKwRuCmgT52yu8k9lEFmoTMzqQ==
X-Received: by 2002:a17:90a:de11:: with SMTP id m17mr11190896pjv.38.1567796846252;
        Fri, 06 Sep 2019 12:07:26 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id 14sm7147365pfn.169.2019.09.06.12.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 12:07:25 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2] monitor: Add unknown options decoding for Configure Response
Date:   Fri,  6 Sep 2019 12:07:17 -0700
Message-Id: <20190906190717.1325-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Unknown options respose for Configure Respose packet has a different
layout that that of unaccepted options, so it needs special code to
handle it.

Before:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 2 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        04

After:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 3 len 7
        Source CID: 65
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Retransmission and Flow Control (0x04)
---

Changes since [v1]:

    - Code converted to use l2cap_frame_get_u8() and l2cap_frame_pull()


[v1] https://lore.kernel.org/linux-bluetooth/20190522013216.22493-1-andrew.smirnov@gmail.com/

 monitor/l2cap.c | 54 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 26719ac5e..41967a731 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -705,6 +705,41 @@ static struct {
         { }
 };
 
+static void lookup_option_by_type(uint8_t type, const char **str,
+				  uint8_t *expect_len)
+{
+	int i;
+
+	for (i = 0; options_table[i].str; i++) {
+		if (options_table[i].type == type) {
+			*str = options_table[i].str;
+			if (expect_len)
+				*expect_len = options_table[i].len;
+			return;
+		}
+	}
+
+	*str = "Unknown";
+	if (expect_len)
+		*expect_len = 0;
+}
+
+static void print_unknown_options(const struct l2cap_frame *source,
+				  uint8_t offset)
+{
+	struct l2cap_frame frame;
+	uint8_t type;
+
+	l2cap_frame_pull(&frame, source, offset);
+
+	while (l2cap_frame_get_u8(&frame, &type)) {
+		const char *str;
+
+		lookup_option_by_type(type, &str, NULL);
+		print_field("Option: %s (0x%2.2x)", str, type);
+	}
+}
+
 static void print_config_options(const struct l2cap_frame *frame,
 				uint8_t offset, uint16_t cid, bool response)
 {
@@ -713,20 +748,13 @@ static void print_config_options(const struct l2cap_frame *frame,
 	uint16_t consumed = 0;
 
 	while (consumed < size - 2) {
-		const char *str = "Unknown";
+		const char *str;
 		uint8_t type = data[consumed] & 0x7f;
 		uint8_t hint = data[consumed] & 0x80;
 		uint8_t len = data[consumed + 1];
-		uint8_t expect_len = 0;
-		int i;
+		uint8_t expect_len;
 
-		for (i = 0; options_table[i].str; i++) {
-			if (options_table[i].type == type) {
-				str = options_table[i].str;
-				expect_len = options_table[i].len;
-				break;
-			}
-		}
+		lookup_option_by_type(type, &str, &expect_len);
 
 		print_field("Option: %s (0x%2.2x) [%s]", str, type,
 						hint ? "hint" : "mandatory");
@@ -1122,7 +1150,11 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
 	print_cid("Source", pdu->scid);
 	print_config_flags(pdu->flags);
 	print_config_result(pdu->result);
-	print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
+	if (pdu->result == 0x0003)
+		print_unknown_options(frame, 6);
+	else
+		print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
+
 }
 
 static void sig_disconn_req(const struct l2cap_frame *frame)
-- 
2.21.0

