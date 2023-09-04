Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA934C83F33
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbjIDWMJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDWMI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB8CDA
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a1de3417acso593221266b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865522; x=1694470322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gArWs5Q5c1PsBa7PCApkxjz+wZ4/Au6Fx4OqD6X/u4U=;
        b=gote8BAH1dfry79ayUQUZp6/WJMCaNkkdJXsd4qoWFaWWiTsgylOK/iI+5K0apMzky
         HqNaG3WPM425tZJGFaqVr5iBI/BGxc3Z0XKPSvGyDnjQ3aZ5Oh/7sVQMpnEaFA+ffsSO
         WPF/HRzar9GFtOsecuU4+NwGt0I6MH+6770iZYvCLeTZtri9fO+OY0EzpMOVylFL5hRK
         a1ipqBmGro2yZBzAOLgCxRhvisICF1apxxF7q2sZ0UXtc1RUxbsPepKsrTFvZ2KHahMT
         jbhRkFHQlGCChNqQrw2gMs0RUBdkdVc3aM1I5TFNNDYti9rSXooiaLBHu38bA38L/Ykb
         pj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865522; x=1694470322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gArWs5Q5c1PsBa7PCApkxjz+wZ4/Au6Fx4OqD6X/u4U=;
        b=USaRazkNKxcl6vgoxyYNs5rpy3ceJPfInlq8HjVQD4O0GzVqmP3yPrfylHmkHkStzC
         cWQkJ+cmPM7pzfQbrwYd69TCrXJZayRp7tA1ZCXVbKIUIjr+z8wpRSmYhO4effDPb1DL
         2dNTwXV4rNRRcvnZggVh7VJ17e4csebYzh95UW8n+6/NaOb4I9vL+y/EY7WriqEbf/Gt
         r9LRhQQ2TYd04cKxP3/f7vx/QEFiXwnLYDohl2wF+h9wHf/Byo2htFGCiKfGnkgjcG0z
         B3GtAJ4miB0S6kjwYPxqETZCg/plIJbBaqOVMSIZjKIxai5Tt1MYKc/XzQvxd9iwIaLU
         DWmw==
X-Gm-Message-State: AOJu0YxmQ8aktHSMCjGK0y/b4f54GMtb8PzAD7hcb49fc67JWOAiX6sU
        PTB4J7BhIljwi0vkPGTyQwck0w==
X-Google-Smtp-Source: AGHT+IFaVoPIsdEXXEJGSK0ibzOr6EUvtMfDzXMWWIs50iC+huwvFJoVXIvugNjIAkxZWWVCqFSLpQ==
X-Received: by 2002:a17:906:3010:b0:9a5:bceb:1cf8 with SMTP id 16-20020a170906301000b009a5bceb1cf8mr11138985ejz.3.1693865522265;
        Mon, 04 Sep 2023 15:12:02 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:01 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 3/7] Bluetooth: L2CAP: use refcount on struct l2cap_chan->conn
Date:   Tue,  5 Sep 2023 00:11:54 +0200
Message-Id: <20230904221158.35425-4-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We have detected a memory leak of "struct l2cap_conn" objects, and of
"struct hci_conn" in the bluetooth subsystem [12]. The second is a
consequence of the first. This memory leak was also detected by syzbot
[13].

"struct l2cap_conn" is allocated in "l2cap_conn_add()" [2]. "struct
l2cap_conn" is reference-counted [1] by its "ref" member [3]: every
holder of a reference to it should increment the reference counter by
calling "l2cap_conn_get()" [4], and every reference holder that stops
keeping the reference should call "l2cap_conn_put()" [5]. The "struct
l2cap_conn" is freed when the counter reaches 0, meaning there is no
reference holder any more.

This mechanism is already used by the "hidp_session_new()" [6] and
"session_free()" [7] functions that create and delete the "struct
hidp_session" [8] objects, which contains a "conn" reference to a
"struct l2cap_conn".

The same reference counting mechanism is not used for the "conn"
reference kept in the "struct l2cap_chan" [9] object. There were two
places where the reference counting was not applied:

 1. In "__l2cap_chan_add()" [11], the "struct l2cap_conn" reference is
    stored in the "conn" member of the "struct l2cap_chan" [9].
 2. In "l2cap_chan_del()" [10], the "conn" member of the "struct
    l2cap_chan" is set to NULL.

To apply the reference counting to the "conn" member of the "struct
l2cap_chan", we use "l2cap_conn_get()" in "__l2cap_chan_add()", where
we store the reference, and "l2cap_conn_put()" in "l2cap_chan_del()",
where we drop the reference.

Handling the "conn" member of the "struct l2cap_chan" with the
existing reference counter will help to fix the kernel memory leak in
a following commit.

References:
- [1]  "Adding reference counters (krefs) to kernel objects"
       <https://www.kernel.org/doc/html/v6.5/core-api/kref.html>
- [2]  "l2cap_conn_add()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L7833>
- [3]  "struct l2cap_conn"
       <https://elixir.bootlin.com/linux/v6.5/source/include/net/bluetooth/l2cap.h#L674>
- [4]  "l2cap_conn_get()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L1952>
- [5]  "l2cap_conn_put()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L1959>
- [6]  "hidp_session_new()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/hidp/core.c#L910>
- [7]  "session_free()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/hidp/core.c#L979>
- [8]  "struct hidp_session"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/hidp/hidp.h#L137>
- [9]  "struct l2cap_chan"
       <https://elixir.bootlin.com/linux/v6.5/source/include/net/bluetooth/l2cap.h#L540>
- [10] "l2cap_chan_del()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L642>
- [11] "__l2cap_chan_add()"
       <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L583>
- [12] "ble-memleak-repro"
       <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
- [13] "[syzbot] [bluetooth?] memory leak in hci_conn_add (2)"
       <https://lore.kernel.org/linux-bluetooth/0000000000000fd01206046e7410@google.com/T/#u>

Signed-off-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
---
 net/bluetooth/l2cap_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c749b434df97..768632fba6f8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -587,7 +587,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
-	chan->conn = conn;
+	chan->conn = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -669,6 +669,8 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		if (mgr && mgr->bredr_chan == chan)
 			mgr->bredr_chan = NULL;
+
+		l2cap_conn_put(conn);
 	}
 
 	if (chan->hs_hchan) {
-- 
2.39.2

