Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E056DC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiHVWAr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiHVWA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:00:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D573DF02
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:00:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v23so5863249plo.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=c6c2W9lldeIbv0uRG289EkdmoZZc6VFBSAXh9hrQiKk=;
        b=PRCEOOy3nKaD2iju9zXRdy/CPByIrX7JLSNun69vpd7NfQN9KxsUjfCOE47fNfc5K3
         F4OjQYF2qhN/T17tITMoTBBiqm8N+FBUM69SVjt1QxuPpsRv/O3+aM12A2+MD1affSYv
         39zrVXAvDqGMbeI9RFTVHY0mUsAxhYiD9AuKRna6Dvn2rIzryPLm3ma46UVmOC3Yaal7
         zGwHMMbRUgH8zjEWQ8IzbSJxB9zaSbNxoAhuJKEXJgwLjd5xylxMWtljnE5mpaa4ssC1
         WPnJidjXsDb5B/PboEUHPFlUUBdf+cEdB6gW5a56JHcbwcvP5hnIw/Zu8eGdN5EEuQLv
         YmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=c6c2W9lldeIbv0uRG289EkdmoZZc6VFBSAXh9hrQiKk=;
        b=rEjDGjxfDzgk/zPlkinGUJSwtuvKDXd3xGdAwBF/bcRWC877Ed1riWYGpMGnoMH1Mz
         8PU/LFOAWpsNZ8B3CqJlteGRy5U9J56CXxvQLAoMfyxJE07d5wgFhCszD/aElke5OENk
         EVnh69aInstqmtxyNbyotucPmoqgd3J1srmy6+zZW70EZ9x7iUtroVtwzdqk8KOtKPqu
         XhHk3hA0l1YQG9Ldk0XceRCULh37iyTFyGMVSlj76iAEtyaxNPR7Onhj5yTvTmDHS9Bk
         JMriQz7sMFUJhE/Cw5OQgcC/+owd86saRFPgRbNdjuja7fDtXzdZhmN9+VUpD1BdlyAM
         1P/g==
X-Gm-Message-State: ACgBeo2ITlViLIMMKT9y1tBlxUHZG81vtx1WpVYWHxfDOsb5C/RDTUbu
        k7fgDmHBo2N3PfYe/C58X14N5yuRU+k=
X-Google-Smtp-Source: AA6agR5UWRu7AZWzx1gJvqJ+ICGEH0eNUDQKJ6MMnbn6hlXrubrXVjshSIx93F+B1L4YorNQO/cZ8A==
X-Received: by 2002:a17:902:be02:b0:172:d409:e057 with SMTP id r2-20020a170902be0200b00172d409e057mr12201255pls.90.1661205627151;
        Mon, 22 Aug 2022 15:00:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79e4c000000b00535e950aa28sm8364751pfq.131.2022.08.22.15.00.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 15:00:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bthost: Add destroy callback to bthost_add_iso_hook
Date:   Mon, 22 Aug 2022 15:00:24 -0700
Message-Id: <20220822220025.541691-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a destroy callback to bthost_add_iso_hook so its user can
detect when the hook is freed when the connection is disconnected.
---
 emulator/bthost.c  | 8 +++++++-
 emulator/bthost.h  | 3 ++-
 tools/iso-tester.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index f067d39a0262..b05198953506 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -137,6 +137,7 @@ struct rfcomm_chan_hook {
 struct iso_hook {
 	bthost_cid_hook_func_t func;
 	void *user_data;
+	bthost_destroy_func_t destroy;
 };
 
 struct btconn {
@@ -306,6 +307,9 @@ static void btconn_free(struct btconn *conn)
 		free(hook);
 	}
 
+	if (conn->iso_hook && conn->iso_hook->destroy)
+		conn->iso_hook->destroy(conn->iso_hook->user_data);
+
 	free(conn->iso_hook);
 	free(conn->recv_data);
 	free(conn);
@@ -676,7 +680,8 @@ void bthost_add_cid_hook(struct bthost *bthost, uint16_t handle, uint16_t cid,
 }
 
 void bthost_add_iso_hook(struct bthost *bthost, uint16_t handle,
-				bthost_cid_hook_func_t func, void *user_data)
+				bthost_iso_hook_func_t func, void *user_data,
+				bthost_destroy_func_t destroy)
 {
 	struct iso_hook *hook;
 	struct btconn *conn;
@@ -693,6 +698,7 @@ void bthost_add_iso_hook(struct bthost *bthost, uint16_t handle,
 
 	hook->func = func;
 	hook->user_data = user_data;
+	hook->destroy = destroy;
 
 	conn->iso_hook = hook;
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 3d7a124f08ad..2cfdef766e4d 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -71,7 +71,8 @@ typedef void (*bthost_iso_hook_func_t)(const void *data, uint16_t len,
 							void *user_data);
 
 void bthost_add_iso_hook(struct bthost *bthost, uint16_t handle,
-				bthost_iso_hook_func_t func, void *user_data);
+				bthost_iso_hook_func_t func, void *user_data,
+				bthost_destroy_func_t destroy);
 
 void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len);
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 5727f3055222..8c935b9220dd 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1137,7 +1137,7 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 	tester_print("Writing %zu bytes of data", isodata->send->iov_len);
 
 	host = hciemu_client_get_host(data->hciemu);
-	bthost_add_iso_hook(host, data->handle, bthost_recv_data, data);
+	bthost_add_iso_hook(host, data->handle, bthost_recv_data, data, NULL);
 
 	ret = writev(sk, isodata->send, 1);
 	if (ret < 0 || isodata->send->iov_len != (size_t) ret) {
-- 
2.37.2

