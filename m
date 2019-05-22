Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD30C072B5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 01:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECBE20657
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 01:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aemLcNXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfEVBc1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 May 2019 21:32:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33658 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVBc1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 May 2019 21:32:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so411968pfk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2019 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Be4VSkTD1BI4HlyMXDbsildx9VoPJ/h7t/U9CICTL0=;
        b=aemLcNXgp/+A39OPndS0evuPlsbVbUq821unnZn1fG2zjrwysjoEMU3/FxxettPZ+u
         zqcc8pryCIU1F0F6tz3vJAHe+MAhJ9E/iLmSE0Bv35ppZ4yYv5jskPanVav1sC6+adpK
         6OWSwIGSCcV7JcRBMfnMlJf8/ixVUxi9wy187Xw9Pa3oTSgWq34eB/o93QfncnklUnda
         smQ33af8U161JXVRSlohlOs4mOvW1wcTS0YPjXZg4MW4UcSfw8davmQo3HK4OvrwfHpn
         FM/M3V+ntYr7/+CwIXIGejn1GFcb1t0/2tOI0+6xRIYUdIkYJdxunAu75u7EgrPSfkzR
         T+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Be4VSkTD1BI4HlyMXDbsildx9VoPJ/h7t/U9CICTL0=;
        b=qmOoxbIWGsmJwtrHE4SZ3y3Xgrd2s2ohdP60NOSvLQip1TsvV3KLUhvlHSGDPuz4NW
         QVboD5BRKK1kn1DJu5hnaGAIyf2Z3rVI0vvVAiNmdDAp3co3B8qjMUYddB2XvZGjqPze
         +7bEceSGn/nO3aX13ni/XCtmcg/eyQBdkOrWlXX8ZKQnfdCAphgK/x9GgJM6yh3oCyyF
         Jrft8CY2wceFhDZEVpE/rj4BCMck/2ual8Q61DUX1DatJZE+OiKgOZ5DK1f2f/htiY5G
         pDK8O7wMJ5Jk59Lm5FtXH5vWt3TM+YQ0Dn4Wj6W8Tza9ezLv5PG+Uwmwzm+TzbCdxZt1
         unYQ==
X-Gm-Message-State: APjAAAUbFjFYBwsVdkzrurQTyeKi4FzvHUioVZq0RMcVTjqf17utxcoT
        lmOIcrZNxIL//GL7d3FiZcvUh+ozqWA=
X-Google-Smtp-Source: APXvYqy32TTfwMFyUvGq2MFzPs0SFjz6zUJuYzipVcOwAZ2Fv1Nk1mOEntQ4nFRvz5SGa5VGzsiAiw==
X-Received: by 2002:a62:87c6:: with SMTP id i189mr93891391pfe.65.1558488746047;
        Tue, 21 May 2019 18:32:26 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g17sm14570903pfb.56.2019.05.21.18.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 18:32:25 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH BlueZ] monitor: Add unknown options decoding for Configure Response
Date:   Tue, 21 May 2019 18:32:16 -0700
Message-Id: <20190522013216.22493-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Unknown options respose for Configure Respose packet has a different
layout than that of unaccepted options, so it needs special code to
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
 monitor/l2cap.c | 56 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 26719ac5e..6983f80f0 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -705,6 +705,42 @@ static struct {
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
+static void print_unknown_options(const struct l2cap_frame *frame,
+				  uint8_t offset)
+{
+	const uint8_t *data = frame->data + offset;
+	uint16_t size = frame->size - offset;
+	uint16_t consumed = 0;
+
+	while (size--) {
+		const char *str;
+		uint8_t type = data[consumed++] & 0x7f;
+
+		lookup_option_by_type(type, &str, NULL);
+
+		print_field("Option: %s (0x%2.2x)", str, type);
+	}
+}
+
 static void print_config_options(const struct l2cap_frame *frame,
 				uint8_t offset, uint16_t cid, bool response)
 {
@@ -713,24 +749,16 @@ static void print_config_options(const struct l2cap_frame *frame,
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
-
 		if (expect_len == 0) {
 			consumed += 2;
 			break;
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

