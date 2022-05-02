Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiEBVJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiEBVJ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 17:09:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEBBC32
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 14:05:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n8so13438815plh.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Pru5JZcj+cHsvQbTgyyfRtFvPSEQ+Gl4fw1M4k+drs=;
        b=Gheg6X4esOW0qJrQa3HlAnDrRTPJFD5PAosHvyENezR/plXA1SPZt1nfIj44NwTWM4
         ExzwLwYctMOHM76tUg/mKuwCRICtFAFfHWPNN7r0w+S7gUkw5MTme66E8QRL5/MVK01y
         DsNCX9q37Hkl9DR2WWZ1xRXkrcKMY1IpG7J3D4qYloHqjbX555jATT21mkaam9H4Ir7k
         zkay2740LL/tFzU493+nwYCBJ60SelW/zRFQKyncko2TZyfYPMPUq6p7gEERseJQsZRW
         HhNkMwi++/XypAc1ze9Bf0DcO21ZN7ifEQI0RXrHNCw4Aca1SFxa+BJSy3H4c4X2voyM
         bppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Pru5JZcj+cHsvQbTgyyfRtFvPSEQ+Gl4fw1M4k+drs=;
        b=kg3q8bZsedrDOwdU1cD4valwvkYLLyoE2uBtT4ehMujk9GnyDk1k/Uw0/4arwW+OP4
         QIRZEpwUXkIS+KtX/ASKiJAYdIxGJWo1rv68ZpO5wPXhcTHMHwKW64xmPrfnm/Cd5mJI
         LCCc04y0Roeznq3IseXE/5mNNgVW/8aObrGRkojMjCIiFfbPRyInmisbeGEUy35uyKWc
         sSmjBg3bbBmg5DdkaHQ7kpMYaHI5KN/BMP5ASVqJmrdJGfk+jFZnxYHZJggCHZlULjyb
         Z3BtfK4Ou9S33eIur7Q30bHrCcywIkigZpSc9muqDGfqPq5FgqEdxj/ADRjatNj63Wkq
         20bA==
X-Gm-Message-State: AOAM531gtPpwTJJ2nUaVlQgiJ4nMttRUbwwN5AhDktH90wkmjtk4kAib
        36uK9cRML9tm36LF6WU0vWXWuMvEMDA=
X-Google-Smtp-Source: ABdhPJzj8pFz3gRjonNQY3xvTavYVbwz1cTh8eleKzHe5p/p20ZNXm6mrHTGetxoiK/hc5sdZk48Ig==
X-Received: by 2002:a17:902:f70f:b0:153:ebfe:21b3 with SMTP id h15-20020a170902f70f00b00153ebfe21b3mr13512709plo.119.1651525554899;
        Mon, 02 May 2022 14:05:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902e38200b0015e8d4eb2d8sm846255ple.290.2022.05.02.14.05.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:05:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btdev: Fix not removing connection and advertising set on reset
Date:   Mon,  2 May 2022 14:05:52 -0700
Message-Id: <20220502210553.2271064-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure that all connections and advertising sets are cleanup
on reset.
---
 emulator/btdev.c | 76 +++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d3f565438..641e308b3 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -509,6 +509,42 @@ void btdev_set_rl_len(struct btdev *btdev, uint8_t len)
 	btdev->le_rl_len = len;
 }
 
+static void conn_unlink(struct btdev_conn *conn1, struct btdev_conn *conn2)
+{
+	conn1->link = NULL;
+	conn2->link = NULL;
+}
+
+static void conn_remove(void *data)
+{
+	struct btdev_conn *conn = data;
+
+	if (conn->link) {
+		struct btdev_conn *link = conn->link;
+
+		conn_unlink(conn, conn->link);
+		conn_remove(link);
+	}
+
+	queue_remove(conn->dev->conns, conn);
+
+	free(conn->data);
+	free(conn);
+}
+
+static void le_ext_adv_free(void *data)
+{
+	struct le_ext_adv *ext_adv = data;
+
+	/* Remove to queue */
+	queue_remove(ext_adv->dev->le_ext_adv, ext_adv);
+
+	if (ext_adv->id)
+		timeout_remove(ext_adv->id);
+
+	free(ext_adv);
+}
+
 static void btdev_reset(struct btdev *btdev)
 {
 	/* FIXME: include here clearing of all states that should be
@@ -517,12 +553,16 @@ static void btdev_reset(struct btdev *btdev)
 
 	btdev->le_scan_enable		= 0x00;
 	btdev->le_adv_enable		= 0x00;
+	btdev->le_pa_enable		= 0x00;
 
 	al_clear(btdev);
 	rl_clear(btdev);
 
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
+
+	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
+	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -674,29 +714,6 @@ static bool match_handle(const void *data, const void *match_data)
 	return conn->handle == handle;
 }
 
-static void conn_unlink(struct btdev_conn *conn1, struct btdev_conn *conn2)
-{
-	conn1->link = NULL;
-	conn2->link = NULL;
-}
-
-static void conn_remove(void *data)
-{
-	struct btdev_conn *conn = data;
-
-	if (conn->link) {
-		struct btdev_conn *link = conn->link;
-
-		conn_unlink(conn, conn->link);
-		conn_remove(link);
-	}
-
-	queue_remove(conn->dev->conns, conn);
-
-	free(conn->data);
-	free(conn);
-}
-
 static void disconnect_complete(struct btdev *dev, uint16_t handle,
 					uint8_t status, uint8_t reason)
 {
@@ -4627,19 +4644,6 @@ static struct le_ext_adv *le_ext_adv_new(struct btdev *btdev, uint8_t handle)
 	return ext_adv;
 }
 
-static void le_ext_adv_free(void *data)
-{
-	struct le_ext_adv *ext_adv = data;
-
-	/* Remove to queue */
-	queue_remove(ext_adv->dev->le_ext_adv, ext_adv);
-
-	if (ext_adv->id)
-		timeout_remove(ext_adv->id);
-
-	free(ext_adv);
-}
-
 static int cmd_set_adv_rand_addr(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-- 
2.35.1

