Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F1C001DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 22:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjGMWnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjGMWnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 18:43:05 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5902721
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:43:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a04e5baffcso1065675b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689288182; x=1691880182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AE3bURiprag7eyXYZWuuYwmt+jom0SmOz+1qpDxWg6c=;
        b=Umb79jRKHTVh8OMhIfF4FPjioJqrsAfJhf2qAjydtmCZroAbkDKZ8r8qSiPrZjooXj
         lBbdZXCErRlPGKBoGILlS+P8HQGjiDiwjGIUMidVxGiF5xpwBSIQ8WiyWXwC0MJgEE/Y
         P/baBXzupFRvDgbDM42IDiCXFsUfeOUDk+AG191x7FZc0uv3kP83KJbXEy+TDCP6L0Is
         MVZOJUV0HQNZmT0sn9WfLHd4UsL6N+RLZUS+frrX+XY8tj9CodAqPPUPHMQ86eBG3J7G
         3ciyh3TB6flIFPnZAM1p4pmfYSKubpYvGdHP+G2bIjOTRf7azN8YI2FzS+Bp5m/8gPm6
         8e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288182; x=1691880182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE3bURiprag7eyXYZWuuYwmt+jom0SmOz+1qpDxWg6c=;
        b=gFvGIgxrki17WHcwnnomZ6YILWMIYGumhnF2rNRWKTFPOp5F077h75Ye0ay8RiHIs6
         p9iBPDLQchVBtqlP84Z5RkhMBkTA6h6zva4N2N936emDR90te2L5YosLF1X8a+jN33Zs
         O7ArXhHlv1wchNFZNOwhFwdtJ3nYYi+dviMOYuRzrcG+0xwMC2j5hwYCtHxSGbtZtczM
         Zj60pr16mvSZDTPR0pCZ39N1LNMYr6ST2gSiZsnQ/DWSEcRzPzXlBVby/UVcR2RKW/6T
         ln4QrC1R3AmneMCf/H06zNJbkRW+ySPYMlV9IMltTQYSN6ODMnNIi3Ocg2Mbg6WAJ03v
         Ph7Q==
X-Gm-Message-State: ABy/qLZN0t/XiDUzu3nErN8PC6CVe7/2J4D3QYE4xHTg4m5H8NEH8HiQ
        YgK2TAC940rhp8icLVtZ+n88/Kp0gb0=
X-Google-Smtp-Source: APBJJlHFI0o5sB95W8pnFZZT72/T4ZHht6Q+BBYfqN02CLZBZuzCreY9ax8KAVzwOk9sIPD/qq7kWQ==
X-Received: by 2002:a05:6358:9886:b0:132:d42f:8e19 with SMTP id q6-20020a056358988600b00132d42f8e19mr4139406rwa.31.1689288182270;
        Thu, 13 Jul 2023 15:43:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id t12-20020a63b24c000000b0055bf13811f5sm2568433pgo.15.2023.07.13.15.43.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:43:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bthost: Add support to set ISO Packet Status
Date:   Thu, 13 Jul 2023 15:42:59 -0700
Message-Id: <20230713224300.2286788-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to set ISO Packet Status to bthost_send_iso.
---
 emulator/bthost.c  | 12 ++++++------
 emulator/bthost.h  |  4 ++--
 tools/iso-tester.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 3179bb3d20fe..c7d59eefc80c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -732,8 +732,8 @@ void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 }
 
 static void send_iso(struct bthost *bthost, uint16_t handle, bool ts,
-					uint16_t sn, uint32_t timestamp,
-					const struct iovec *iov, int iovcnt)
+			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
+			const struct iovec *iov, int iovcnt)
 {
 	struct bt_hci_iso_hdr iso_hdr;
 	struct bt_hci_iso_data_start data_hdr;
@@ -773,7 +773,7 @@ static void send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 	}
 
 	data_hdr.sn = cpu_to_le16(sn);
-	data_hdr.slen = cpu_to_le16(iso_data_len_pack(len, 0));
+	data_hdr.slen = cpu_to_le16(iso_data_len_pack(len, pkt_status));
 
 	pdu[3].iov_base = &data_hdr;
 	pdu[3].iov_len = sizeof(data_hdr);
@@ -782,8 +782,8 @@ static void send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 }
 
 void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
-					uint16_t sn, uint32_t timestamp,
-					const struct iovec *iov, int iovcnt)
+			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
+			const struct iovec *iov, int iovcnt)
 {
 	struct btconn *conn;
 
@@ -791,7 +791,7 @@ void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 	if (!conn)
 		return;
 
-	send_iso(bthost, handle, ts, sn, timestamp, iov, iovcnt);
+	send_iso(bthost, handle, ts, sn, timestamp, pkt_status, iov, iovcnt);
 }
 
 bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t code,
diff --git a/emulator/bthost.h b/emulator/bthost.h
index cdc12dc1ce8e..46781365b283 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -81,8 +81,8 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const struct iovec *iov, int iovcnt);
 void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
-					uint16_t sn, uint32_t timestamp,
-					const struct iovec *iov, int iovcnt);
+			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
+			const struct iovec *iov, int iovcnt);
 
 typedef void (*bthost_l2cap_rsp_cb) (uint8_t code, const void *data,
 						uint16_t len, void *user_data);
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index bbd5a47f6197..7140f83b2236 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1715,7 +1715,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
-							isodata->recv, 1);
+				isodata->pkt_status, isodata->recv, 1);
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
-- 
2.40.1

