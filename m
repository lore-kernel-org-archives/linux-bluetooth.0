Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49307EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 18:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjGNSP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjGNSPZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 14:15:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BEF173F
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 11:15:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b9c368f4b5so22997685ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689358503; x=1691950503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZmyXjTXAo9lcN9xEXOF5f/iWqnZnCo4LZ8v2GMplXA=;
        b=LYsSsUHQFZ0xn+cw5Ft4dNgKQQJCzF89P+VTcn0xZogMo6Uwwc4955CfZdxo/mReer
         lWIeavvWWNB0TXnevWVqrXv1EAvendh9PrrDguYgS+2clztmll8HCH5h2OU388EyZOeP
         bJEZq9R2SoJRO+/rd4tv2PENTAj51f7HzdMTCHDORzPv7B/Fx71VF3lJtg7d4evlRqO4
         wIG7MVPnE2cQ4Q79kg9J+0D/sVcJLZjmucmAODDfqQWQiGLDgw+jFdvJu9397Pxz1aRD
         Atn4kLcyDy7imCNiN3JhwGfIpZIKsQA4j67tevj0Y62wjTDJ4l+m2r0ZJNzUib0gd04B
         Q+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358503; x=1691950503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZmyXjTXAo9lcN9xEXOF5f/iWqnZnCo4LZ8v2GMplXA=;
        b=EpA4dzaHvayjyIzQIvqDA7wy5XRZ9XT0YTF3t5+8kPddib2f+wGzWuhINEi8uZ34xE
         WnroigzPK4kS/VRRCGpoo5OuXbEIibhHvUZeoOF7SmCUwQ6WtP3SA9IoawZCgyFz/Pee
         vj/HkbVqemJZ5V3XbtXLnm8a7QD0qEwWQhln1zwFsTUP/xCYRnptZNz0RkYJ6bAoxN8x
         wiO6IMmXG97cmfLU3jv+hZsqs9onqxTxCm4mZzhAGPnCvYQ6yaRFh57KbrfJhFq6yg+U
         hZW88jqJvP8uc+INJkXCpVG+8AzyJgtFzmu05QK+xAWi36jhzd8wDSETbNanH07Gw7DX
         IXZg==
X-Gm-Message-State: ABy/qLZohSyR4Exr0Ds3Z+qxeQZfQgrR/rM5mDvh45sZokNRQEBrWJrV
        0la6IAu2tIYQGOER9h4Vb2MCFjq9YP4=
X-Google-Smtp-Source: APBJJlEqMDujPVIJQeBASOHnh4wVmAI3HFYB8MwTN+FgpNy68fB3TmiTIJKGW8KkVm01gaak+FXZNQ==
X-Received: by 2002:a17:902:dac2:b0:1b6:a37a:65b7 with SMTP id q2-20020a170902dac200b001b6a37a65b7mr4479809plx.23.1689358502858;
        Fri, 14 Jul 2023 11:15:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id bt19-20020a632913000000b0054ff075fb31sm7800508pgb.42.2023.07.14.11.15.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:15:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] bthost: Add support to set ISO Packet Status
Date:   Fri, 14 Jul 2023 11:14:59 -0700
Message-Id: <20230714181500.2371014-1-luiz.dentz@gmail.com>
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
index bbd5a47f6197..ae3eb684e830 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1715,7 +1715,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
-							isodata->recv, 1);
+				0x00, isodata->recv, 1);
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
-- 
2.40.1

