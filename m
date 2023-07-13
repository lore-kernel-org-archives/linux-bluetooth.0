Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C3C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 22:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGMWm5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGMWm4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 18:42:56 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCAA2D47
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:42:55 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a1c162cdfeso1041127b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689288173; x=1691880173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AE3bURiprag7eyXYZWuuYwmt+jom0SmOz+1qpDxWg6c=;
        b=igSd+YZj5s2RB8nB4c8NW/fmGK+WpxWphR0tfcjiUC3D+52Vjaq3Kwk4ZKY/Se+Ne1
         7eOZrFO1hNFOZmSDXIBoMN0fNq+y0Rb3EauLruwv/x8tXY1ak56esF0U5fuVMjxw/qM9
         LsJw2N0ZFvH46DP1nefwp+FSY0Ral8hAWG9PEBSlOCjHY1ltrXsXbhxQZadcvwWPCDYa
         O5N79bz2ZfdrheBhYiIGSaK1qW7y3d4o9OX4mcfSapvp6z5aDk+crUzGT0E8VLoZ37Wb
         2KDeXLsyvLS1bzDSdpuugl64ZFD+fXjAwMHz9m+p37JY92G1E/b3ndRtOBBGQzS1yyoO
         2NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288173; x=1691880173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE3bURiprag7eyXYZWuuYwmt+jom0SmOz+1qpDxWg6c=;
        b=DhQpW9KpWgOzl11CxmVVD+/oyxNH8Sl9BjKNOhBS0WUsPHH9gu9D5EQhWCmmqDTpEB
         FfiVsND4TGbNeRNEU5iM7FrVdLKQhpNp0WXAF3WsgmzZcjU0ORZIJ/FQ7DaDeZVqEJqK
         /+9jRn0OBiwFZCu2qLW9r2H9HbgMpNNCjFQU2hzx3k/eu/GvHshTPjR5mMKC9hx/7NLv
         TDpdgPU5avxD9prLH7Px39bCmhZqIZHXHoWHcZAsp/jU9cSge77ZoSyRfnQtXVdXVh1P
         x0ZoaL3EYOMOXbbs+6Ig7XFW2d42+JHyKsP/Jfqz0SCDjFu7BAwwOpQ95SsUwGZGGmwg
         bjAw==
X-Gm-Message-State: ABy/qLYhOkKoOuaSSRVxHJ64C5pO3J28Y7YpL+oP8ocMTJDFt9Q7cyT7
        LaxE186jhIM/wTXMUFhUJCYZXp8CuXc=
X-Google-Smtp-Source: APBJJlGJI1z2Pmhrdd3Vvjj1VuA2XZBlLJAa3IuyV3prbKNqo5g1EovgNMJQOyAeYacDuR1hd9b4cw==
X-Received: by 2002:a05:6808:1186:b0:3a4:1441:531d with SMTP id j6-20020a056808118600b003a41441531dmr3359805oil.48.1689288173213;
        Thu, 13 Jul 2023 15:42:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006687b4f2044sm5910182pfn.164.2023.07.13.15.42.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:42:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bthost: Add support to set ISO Packet Status
Date:   Thu, 13 Jul 2023 15:42:44 -0700
Message-Id: <20230713224250.2286663-1-luiz.dentz@gmail.com>
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

