Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14FEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 23:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiDLAAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDLAAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 20:00:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E4C2B271
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 16:58:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q142so15529553pgq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8RzyST7saizguP9YNR7p0PMunWg0Gzwx9hn1iwbjTA=;
        b=Z7QXAefwsaWLvDXImsn9vAHqftyDm6EJ7uap6AnRnAnXMSTaJqZxxFy7ZBQikfNvgL
         MSVB3bpf0p2ANMtXE+26q9yFVPTHXkOYcvNsczmyE852hlHweS6DpJmZzQOUowJjbIpG
         oKKW4Mh2VlMY4QoeKHioZonKlP22HiEylHUMJ9uI2gJoCGc31axfC/slZVy2s8qsI4ds
         St/Mnjwm9jTcRn5zXVRfJcBqsTsWvlQdeZQSUgQ+uAc8GJkgqoiVQUsXQS8GcRQs6wiO
         0xg65xU4AjasBTtSrH3FoAELNrfIvaevmqofdzaOQ+qskfB6/1kIyION+QyzroxoUIgN
         +GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8RzyST7saizguP9YNR7p0PMunWg0Gzwx9hn1iwbjTA=;
        b=vb9o/Qs8343j4M5Gy6S+28wgBSd3mphEmKA43I+HHt/DhqyuvhAXrrQCiEbNBS+6EO
         RO6lWSIDaZqO3crqFlWF7pTvtRnFDGNVD7LI6JIfc1NgERFNtC8EnaDFFiptSFeqoUba
         TOL7DLKCouUxCCosDJgHxQ0f0+r88vj3lgi01VqHq/P9NU+gszNIkdS//NKQOJell/OF
         Dh3XGp5CVRvRHXL9jTTLKgywHSNXLoGYvB3XWa3UavIPubvDh+QvNYBtVScXjKKTZW2O
         bM8Gc5TLVW8+FZ2E64186o/4smwXggZDQ95yZgN04Dnu7erl5wjkAXWTn7qETH7lnz0M
         H/FA==
X-Gm-Message-State: AOAM530s6w7TffIR17RtxuPBcZ+PsVW6j4bxrhscgrSgDispQcf5SSz/
        23mhKuIIfRWxIiiIexaWXcDiZ7Bd01E=
X-Google-Smtp-Source: ABdhPJy3zZaisD8XDzpuyUUDifX6CEj6yvQNZtrvgOBlxxni9Yp7BUgcltMRcZClYwtYrBqcGI3m+g==
X-Received: by 2002:aa7:9283:0:b0:505:fe1e:f6b with SMTP id j3-20020aa79283000000b00505fe1e0f6bmr269759pfa.29.1649721486304;
        Mon, 11 Apr 2022 16:58:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w92-20020a17090a6be500b001cb9ff8dfbcsm572515pjj.33.2022.04.11.16.58.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:58:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Fix not cleanup ssp_status and ssp_auto_complete
Date:   Mon, 11 Apr 2022 16:58:02 -0700
Message-Id: <20220411235804.3776702-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not clenup ssp_status and ssp_auto_complete flags on
auth_complete.
---
 emulator/btdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f70fa9136..ccfaed36b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1366,6 +1366,11 @@ static void auth_complete(struct btdev_conn *conn, uint8_t status)
 	ev.status = status;
 
 	send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+
+	conn->dev->ssp_status = 0;
+	conn->dev->ssp_auth_complete = false;
+	conn->link->dev->ssp_status = 0;
+	conn->link->dev->ssp_auth_complete = false;
 }
 
 static int cmd_link_key_reply_complete(struct btdev *dev, const void *data,
-- 
2.35.1

