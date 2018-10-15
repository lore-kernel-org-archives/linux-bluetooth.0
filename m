Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE58C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 22:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A212208B3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 22:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZiaRs2/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A212208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPG0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:26:47 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38047 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJPG0r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Oct 2018 02:26:47 -0400
Received: by mail-pg1-f173.google.com with SMTP id f8-v6so9834326pgq.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuY8LAxSxS55zRD95DXrDh+Km3xdX2skhUgRR8XSkKI=;
        b=ZiaRs2/xfxbh3Z028bjxcboNEtR7ODXlDQvCkTTeBTgLAw8xabjDoXdtlLlvl9ba3P
         E/rYSMdqX7UsESJj4BeGEpX4TvlCvqffyyPXnf+vhdOq+x1sMdtL5Fz+mZdvNXASJq3w
         HMjFViNH8MoB3A5s0X84msDUa9mgJKX96jl+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuY8LAxSxS55zRD95DXrDh+Km3xdX2skhUgRR8XSkKI=;
        b=fI3ATER7QhyClk9g5jyI1MieY8eMjenfSbx6A4vyZqNG1uCYg+xsaY0m5KW/kW03O6
         +aWzpT6iqLqGUHmWvjJDi7FXPGODMMrj1bARVNcjz5VWX7DuaOWYvFHne0Ig1o/uP7p9
         A0xwC223AtegivBaDawFsfGreowZMWsicyiZOn3F/WKcDIo8pBhUMLZz/fRVwEfsnDMy
         XrmDHiCqmmK21+cV+Oa7YFGX7JvPil/7eo7t+LsS/HEO51qs4d3Vur60uQrwbHKpUBMq
         pQfph56/3J/RivJbvm57+a3EvgQH/ToL8XTJlhNJsPlSTzvtIMfx/loX++mwBVG1yfzi
         Gzug==
X-Gm-Message-State: ABuFfojBsuKyvs7Cc35eHwqEBy5Ur2rjj45RfmLo9NQqRnSCruFAvb0U
        Nd53x/5Rrfwqcy53Cqnxoi+cGg==
X-Google-Smtp-Source: ACcGV62OQPn7nBG5elb/A8zvfgFdF0M2n1dhKx9o/79nEmZq8sX047Z4nMHrtRaEIjfCDqidg0nStw==
X-Received: by 2002:a63:4952:: with SMTP id y18-v6mr17776728pgk.32.1539643170806;
        Mon, 15 Oct 2018 15:39:30 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id r1-v6sm15379649pfb.41.2018.10.15.15.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:39:30 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] Bluetooth: Fix locking in bt_accept_enqueue() for BH context
Date:   Mon, 15 Oct 2018 15:39:10 -0700
Message-Id: <20181015223910.197729-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
atomically") lock_sock[_nested]() is used to acquire the socket lock
before manipulating the socket. lock_sock[_nested]() may block, which
is problematic since bt_accept_enqueue() can be called in bottom half
context (e.g. from rfcomm_connect_ind()).

The socket API provides bh_lock_sock[_nested]() to acquire the socket
lock in bottom half context. Check the context in bt_accept_enqueue()
and use the appropriate locking mechanism for the context.

Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Not sure if this is the correct solution, it's certainly not elegant and
checkpatch.pl complains that in_atomic() shouldn't be used outside of
core kernel code. I'm open to other suggestions :)

 net/bluetooth/af_bluetooth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index deacc52d7ff1..0f0540dbb44a 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -159,10 +159,20 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk)
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
+	if (in_atomic())
+		bh_lock_sock_nested(sk);
+	else
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
-	release_sock(sk);
+
+	if (in_atomic())
+		bh_unlock_sock(sk);
+	else
+		release_sock(sk);
+
 	parent->sk_ack_backlog++;
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
-- 
2.19.1.331.ge82ca0e54c-goog

