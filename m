Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CDEC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D662074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmXkF1Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406993AbgDNIJP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406985AbgDNIJE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:09:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200EFC008748
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:09:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w3so9151434plz.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NSjekJEL9dfitQBDMlYCs94wAxGHyeVP0lyLYkmsTXc=;
        b=mmXkF1TiPnLArNENdITTbIK7PKEuRC0AWfk37LwCXOlAJi5whkVBaXbVlSthCWmVAp
         gprYNFHBDQOKwlHBdcRMXZvSpOLbn4DSE/YkC+XaFlVLdQfiXqhsyr5PnsfeQFzyqdB2
         ZkKZUhxsDmTr286OImNRkE5EVZRJuzd1Df6fqdbii8zhXu1WXcY0/OIFdDwpjUIn7KNi
         jOoSbcvXclS2ileGlm4eHyvhEDOR8fnKc+umRQS9MgG+YQvk6TOfedJKHkubEPdqOB6W
         bEqS/aaEsA2iYjWu2+7pKsxGiI0/gzpTZ+/PxnNljZV2PgZv+FJHYwyhYkZykwFk3AkU
         AgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NSjekJEL9dfitQBDMlYCs94wAxGHyeVP0lyLYkmsTXc=;
        b=OzsnozY52iVyBntTOQsSXgpYLM8daGKEjNM6qZwCpwYIIS3xv9217B7XW5UF7HtxLf
         VYIOZIVw9H/LH9ORLMZ2AJkQd8UtUmImZu7j3a7wXd5dX782oqwOxRwbJZ1dq6Ghun7h
         DcZaqquHYC4sPXjMOaFocx5r9NNc3fk9iLKWMwilkkoPvzAfPGHD7MgWh1LR/xxHNctN
         C2xvFzzOBgCNTH3obHMWHWJtgrhlJkWkSXXaWwA4EGR4H+To4dVroe62FtwzzFwK+TqJ
         5almnk4z4K8MmaqPN+FGExKEFD0PLtRCtmZ29XhFE6dmyroyJfRf4GNCierAoax/R2PW
         pwNw==
X-Gm-Message-State: AGi0Puayd4TDpYnluL7rWLNRCXmvXHB3mox46ufZ1i7nGnJzeY440iTh
        4bcQtoBUk6a3IFPktrLGB5PEKnyHKgCaJ3VwwYrJz/fCVgRxHFkH1wda/uWUNlFLuwTqR2vReh+
        ltuEM6/7c5a3zZ4tpqnj3o/yFlH/KM5NkUiXLxcjvWX1CBw0bd7xnqYfBggqQjjCY3Caavz+WdX
        pX
X-Google-Smtp-Source: APiQypI8baE5/Q7SqmnUzI3AwP72Y2H9nKVzkJ7fBqelS6PhL2rYS2Ti9BIkayNWGf2zD1m0exBOQ/IlWhvs
X-Received: by 2002:a63:2901:: with SMTP id p1mr20524245pgp.444.1586851742111;
 Tue, 14 Apr 2020 01:09:02 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:08:40 +0800
Message-Id: <20200414160758.v1.1.Idab9dcdc7da549ed1fd5c66341fb8baffaee8d10@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v1] Bluetooth: L2CAP: add support for waiting disconnection resp
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Whenever we disconnect a L2CAP connection, we would immediately
report a disconnection event (EPOLLHUP) to the upper layer, without
waiting for the response of the other device.

This patch offers an option to wait until we receive a disconnection
response before reporting disconnection event, by using the "how"
parameter in l2cap_sock_shutdown(). Therefore, upper layer can opt
to wait for disconnection response by shutdown(sock, SHUT_WR).

This can be used to enforce proper disconnection order in HID,
where the disconnection of the interrupt channel must be complete
before attempting to disconnect the control channel.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

 net/bluetooth/l2cap_sock.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1cea42ee1e922..a995d2c51fa7f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1271,14 +1271,21 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	struct l2cap_conn *conn;
 	int err = 0;
 
-	BT_DBG("sock %p, sk %p", sock, sk);
+	BT_DBG("sock %p, sk %p, how %d", sock, sk, how);
+
+	/* 'how' parameter is mapped to sk_shutdown as follows:
+	 * SHUT_RD   (0) --> RCV_SHUTDOWN  (1)
+	 * SHUT_WR   (1) --> SEND_SHUTDOWN (2)
+	 * SHUT_RDWR (2) --> SHUTDOWN_MASK (3)
+	 */
+	how++;
 
 	if (!sk)
 		return 0;
 
 	lock_sock(sk);
 
-	if (sk->sk_shutdown)
+	if ((sk->sk_shutdown & how) == how)
 		goto shutdown_already;
 
 	BT_DBG("Handling sock shutdown");
@@ -1301,11 +1308,20 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		 * has already been actioned to close the L2CAP
 		 * link such as by l2cap_disconnection_req().
 		 */
-		if (sk->sk_shutdown)
-			goto has_shutdown;
+		if ((sk->sk_shutdown & how) == how)
+			goto shutdown_matched;
 	}
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	/* Try setting the RCV_SHUTDOWN bit, return early if SEND_SHUTDOWN
+	 * is already set
+	 */
+	if ((how & RCV_SHUTDOWN) && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
+		sk->sk_shutdown |= RCV_SHUTDOWN;
+		if ((sk->sk_shutdown & how) == how)
+			goto shutdown_matched;
+	}
+
+	sk->sk_shutdown |= SEND_SHUTDOWN;
 	release_sock(sk);
 
 	l2cap_chan_lock(chan);
@@ -1335,7 +1351,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		err = bt_sock_wait_state(sk, BT_CLOSED,
 					 sk->sk_lingertime);
 
-has_shutdown:
+shutdown_matched:
 	l2cap_chan_put(chan);
 	sock_put(sk);
 
@@ -1363,7 +1379,7 @@ static int l2cap_sock_release(struct socket *sock)
 
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
-	err = l2cap_sock_shutdown(sock, 2);
+	err = l2cap_sock_shutdown(sock, SHUT_RDWR);
 	chan = l2cap_pi(sk)->chan;
 
 	l2cap_chan_hold(chan);
-- 
2.26.0.110.g2183baf09c-goog

