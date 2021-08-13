Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C28C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28E6610FA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbhHMMUu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhHMMUt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6BC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n200-20020a25d6d10000b02905935ac4154aso8926620ybg.23
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OSZOPfTppezBMekhYxQMiyjUungy/Ia53ml6iFlewQY=;
        b=LbFrvtk7nteqlwgBT/H394xIEYQ5Gne9zyeD4QdgCUmt7yf7MTAfIJ0YVNA/nI8bVG
         wEeWjR1zAUQk30ZluNy45YodtTz734jW0fMJjeTK+6PCD/TtnlI5aqrfZTHSmfZXxmrR
         B+SqwRd0FIccw6DRsMyw1xmFlWsEU636XihTXBZQ79O6oIK8BbGmlPdjO3Ps6RetQXJj
         c2c83a1QR8ca8T43O50LcOQoM3nYqkg/UGhkpKv3Io1nbz/ruvGMRzHYXPpKBIFH9Y3w
         1BvXz68mJKk8cWk08H1aKYp2rUXjm8nje4iyvrXTSngZho2Vgnh0fk4xNubTstGXr9N4
         G5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OSZOPfTppezBMekhYxQMiyjUungy/Ia53ml6iFlewQY=;
        b=GGOMYjr864UuTae+YGXeJZyhtJkJlS77HN/OEQOzkGMvefrVojYXVN+4mBw/jqEB2S
         V8dymmakxgrq0ynmiz0PK+tqhTY3CoP2fOMFLjdu2xxnNJPCc1wmo2D1c6S9Z67rn6V+
         zyay3jLJl43bryGjW+yewz8uAcOzri6Yjyr3fP01muPmqpZhyvP1ULpL5E9YlSMDKH2u
         XXnxrw8a7CIplUrewqUx/oaycXcFGoNvrp//RnpPGsdoUYr4LWapeNLCuy/WX79+yUmi
         SLYTDnCjWqZI3z0HPRpyAlZhiL8SW2ZwkZRjeiJYuQfB1JgX8Eq0U19fn/sj1LuD3PEV
         Kdag==
X-Gm-Message-State: AOAM532slwd4Hmg1i7C6d7BE38ZW5tM2xuQUVEpZ9qccL6XHlzpWSRru
        sIDnUy10ZipTr7kT7PTcGslj4DYvoYwyDuMlNHd4Ots9tQ8ylP0j5jtjTEbb7k5bO4RNHe4r4oc
        yYaCVPJDe0VQZyhVyBE39+NMOF4FJ+rnl9omXmsuo2GdoRtR6L0XAMqbvYU/Db2libhX/g8Gloq
        83
X-Google-Smtp-Source: ABdhPJxt4YwNztRbVllj3YZ+wCdyseukEP8BCpepgsh7jBlgzsIn1rYwBqmqpYpHTbuYw/6mq3Ny4mALG0ck
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:a20a:: with SMTP id
 b10mr2595240ybi.478.1628857222507; Fri, 13 Aug 2021 05:20:22 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:58 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.13.Iace7436b123a902208d19b893f5f99a250d0af18@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 13/62] monitor: Inclusive language in SMP related things
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected in the BT core spec 5.3.
---

 emulator/smp.c  | 8 ++++----
 monitor/bt.h    | 4 ++--
 monitor/l2cap.c | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/emulator/smp.c b/emulator/smp.c
index ec1baea046..c0f9911774 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -382,7 +382,7 @@ static void distribute_keys(struct smp_conn *conn)
 	if (conn->local_key_dist & DIST_ENC_KEY) {
 		memset(buf, 0, sizeof(buf));
 		smp_send(conn, BT_L2CAP_SMP_ENCRYPT_INFO, buf, sizeof(buf));
-		smp_send(conn, BT_L2CAP_SMP_MASTER_IDENT, buf, 10);
+		smp_send(conn, BT_L2CAP_SMP_CENTRAL_IDENT, buf, 10);
 	}
 
 	if (conn->local_key_dist & DIST_ID_KEY) {
@@ -570,7 +570,7 @@ static void encrypt_info(struct smp_conn *conn, const void *data, uint16_t len)
 {
 }
 
-static void master_ident(struct smp_conn *conn, const void *data, uint16_t len)
+static void central_ident(struct smp_conn *conn, const void *data, uint16_t len)
 {
 	conn->remote_key_dist &= ~DIST_ENC_KEY;
 
@@ -725,8 +725,8 @@ void smp_data(void *conn_data, const void *data, uint16_t len)
 	case BT_L2CAP_SMP_ENCRYPT_INFO:
 		encrypt_info(conn, data, len);
 		break;
-	case BT_L2CAP_SMP_MASTER_IDENT:
-		master_ident(conn, data, len);
+	case BT_L2CAP_SMP_CENTRAL_IDENT:
+		central_ident(conn, data, len);
 		break;
 	case BT_L2CAP_SMP_IDENT_ADDR_INFO:
 		ident_addr_info(conn, data, len);
diff --git a/monitor/bt.h b/monitor/bt.h
index cde68d4802..3d3073e462 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -4026,8 +4026,8 @@ struct bt_l2cap_smp_encrypt_info {
 	uint8_t  ltk[16];
 } __attribute__ ((packed));
 
-#define BT_L2CAP_SMP_MASTER_IDENT	0x07
-struct bt_l2cap_smp_master_ident {
+#define BT_L2CAP_SMP_CENTRAL_IDENT	0x07
+struct bt_l2cap_smp_central_ident {
 	uint16_t ediv;
 	uint64_t rand;
 } __attribute__ ((packed));
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index f16f82532c..109bc16b44 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -3017,9 +3017,9 @@ static void smp_encrypt_info(const struct l2cap_frame *frame)
 	print_hex_field("Long term key", pdu->ltk, 16);
 }
 
-static void smp_master_ident(const struct l2cap_frame *frame)
+static void smp_central_ident(const struct l2cap_frame *frame)
 {
-	const struct bt_l2cap_smp_master_ident *pdu = frame->data;
+	const struct bt_l2cap_smp_central_ident *pdu = frame->data;
 
 	print_field("EDIV: 0x%4.4x", le16_to_cpu(pdu->ediv));
 	print_field("Rand: 0x%16.16" PRIx64, le64_to_cpu(pdu->rand));
@@ -3123,8 +3123,8 @@ static const struct smp_opcode_data smp_opcode_table[] = {
 			smp_pairing_failed, 1, true },
 	{ 0x06, "Encryption Information",
 			smp_encrypt_info, 16, true },
-	{ 0x07, "Master Identification",
-			smp_master_ident, 10, true },
+	{ 0x07, "Central Identification",
+			smp_central_ident, 10, true },
 	{ 0x08, "Identity Information",
 			smp_ident_info, 16, true },
 	{ 0x09, "Identity Address Information",
-- 
2.33.0.rc1.237.g0d66db33f3-goog

