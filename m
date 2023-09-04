Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21638CA0FF3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjIDWML (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbjIDWMJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A77CDB
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so30744881fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865523; x=1694470323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyo1tkxni+p1MNEnypGuf8h5ed39NY3A4rmpbAGxJBI=;
        b=alyChdPRJ1wao6+64bBNjz/Xao6bmLgyVNnDu7K9eFROo5XWu9ZL1LVBVjHZi7h6pj
         rnRHjVSGAOooBOssxbtfDXBN+ylDClEVFw1mKkkeAYe7Ag1UcvUzo7gZuqpMWFWXXeUx
         Ne+UIoFcJtjAVPqm1HWA/QHs7Ia+oYGqS4mbolnFip8SrJN0bjFxmWlZIQvWdhkPqL0s
         jvWR5qLCpJogfnGqYbMTzeHljB8eUSgzfvY5PamLuE7W1IoX7UBHDb0lDn2GVawxk4bT
         P0ETcgrlCTDGyhNRL8ipiQXUAQ6JqLfgs5vPoT37mlFll2Ei4qsqbNJxjekmP8g8xgCb
         3U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865523; x=1694470323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyo1tkxni+p1MNEnypGuf8h5ed39NY3A4rmpbAGxJBI=;
        b=X/BXVPvL2GmtYgEBVZryeRlrJYNHYZNJyWnUPqSHiVZ7JVfeq3b0Z9PAp5YykBE8dd
         0P2tBwm9oEyRv8iYZtFNBYrmrNzv2rd2u0vOpsxC/0ITjjH9f0+fNeUOE95ea6xptJCi
         lfPpV6cUKuoICqr3o4mKLxn27ns9I6L7SYjRi4y7jgyGwm+l6UVbaOUQkyHh+HmdbJ1t
         LfDHOiNyohsIOAxuHgyWnf7G0fzHAhWxZAj97nGRKgxX2IlQooxnImAMZInmZ5QzQ9NJ
         H9U8/lN2OwpYavkLW4VXxCSCSMKdM858MnGpmPWp4y0suKaFkhDgjp1o9JMfv2KcJyh8
         xQvA==
X-Gm-Message-State: AOJu0YyUZneXNwNgcthgw3Bx78JV5a8OzdRjOOkjWE2p5imjmytrhuem
        g61BR1p+0xN8V4jiMX/hMlCbfg==
X-Google-Smtp-Source: AGHT+IH+eOSYCSlRmapK5DCQ7GhChDWqG4fs55gtG1thCCBWNdSeoTvB9JNSu1aKeqFpPG/Ql3M7mA==
X-Received: by 2002:a2e:360e:0:b0:2bc:c28c:a2b5 with SMTP id d14-20020a2e360e000000b002bcc28ca2b5mr6889476lja.51.1693865522955;
        Mon, 04 Sep 2023 15:12:02 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:02 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 4/7] Bluetooth: L2CAP: free the leaking struct l2cap_conn
Date:   Tue,  5 Sep 2023 00:11:55 +0200
Message-Id: <20230904221158.35425-5-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a leak of "struct l2cap_conn" [2] objects, and of "struct
hci_conn" objects, when a user-mode application scan for a BLE MAC
address, with timeouts [7] [8]. The "struct hci_conn" leak is a
consequence of the first, and we prove it below.

The "struct l2cap_conn" memory leak comes from the
"l2cap_chan_connect()" function.

 1. "l2cap_chan_connect()" [3] calls "l2cap_conn_add(hcon)", which
    allocates a "struct l2cap_conn", sets is reference counter [1] to
    1 and returns it. The "struct l2cap_conn*" is stored in "conn".

 2. "l2cap_chan_connect()" calls "__l2cap_chan_add(conn, chan)" [4],
    which stores "conn" in the "conn" member of "chan":

      chan->conn = conn;

    Since a recent commit [6], "__l2cap_chan_add()" increases the
    "conn" reference counter to 2.

 3. Nothing frees the allocated "struct l2cap_conn". The channel is
    eventually deleted by "l2cap_chan_del()" [5], which sets
    "chan->conn" to NULL and, since a recent commit [6], decreases
    "conn"'s reference counter back to 1.

A recent commit [6] has added reference counting to "chan->conn": the
counter is incremented in "__l2cap_chan_add(conn, chan)", when it is
assigned to the "chan->conn" member, and the counter is decremented in
"l2cap_chan_del()", when the "chan->conn" member is reset to NULL. The
reference counting should free the "struct l2cap_conn", if correctly
used.

The memory allocation error in the current "l2cap_chan_connect()"
comes from a lack of transfer of "struct l2cap_conn" ownership to the
"chan" object. When "l2cap_chan_connect()" calls
"l2cap_conn_add(hcon)", because the latter allocates a "struct
l2cap_conn", the caller receives the responsibility to free it, we
call this "ownership". Because "struct l2cap_conn" is reference
counted, "l2cap_chan_connect()" should either call "l2cap_conn_put()",
or transfer the ownership to a function or object.

Calling "__l2cap_chan_add(conn, chan)" did not, but should transfer
the responsibility to free "conn" to the "chan" channel. The channel
can free "conn" because it stores a reference to it.

This commit fixes the memory leak because it transfers the ownership
from "l2cap_chan_connect()"'s local variable "conn" to the
"conn" member of the "chan" channel.

The ownership transfer is done by decrementing the reference counter
in "l2cap_chan_connect()": "l2cap_chan_connect()" states so it does
not use the "conn" reference any more and does not keep any reference
to the "struct l2cap_conn".

In the no-error case, "l2cap_chan_connect()" has called
"__l2cap_chan_add()", which has taken its own reference and increased
the ref-counter. "l2cap_chan_del()" will eventually drop the channel's
reference and decrement the ref-counter. The reference count will
eventually reach 0, "l2cap_conn_free()" will be called and it will
free the "struct l2cap_conn".

If an error happened between the memory allocation and
"__l2cap_chan_add(conn, chan)", we need to free "conn", which happens
because the "l2cap_conn_put(conn)" is after the "chan_unlock:" and
"release_conn:" labels.

Fixing the "struct l2cap_conn" memory leak fixes the "struct hci_conn"
memory leak. Indeed,

 1. "hci_conn_add()" allocates a "struct hci_conn", and it calls
    "hci_conn_init_sysfs()" that:
     1. initialises the "conn->dev" reference
        counter to 1 with a "device_initialize(&conn->dev)".
     2. registers the "bt_link_release()" callback that will free the
        "struct hci_conn", when the reference counter will reach 0.

 2. Following the "<...>_add()" / "<...>_del()" convention,
    each call to "hci_conn_add()" should be matched by a
    "hci_conn_del()". However, this is not the case for us, because
    we only scan and our use case matches "hci_conn_del()"'s comment:

	/* Remove the connection from the list and cleanup its remaining
	 * state. This is a separate function since for some cases like
	 * BT_CONNECT_SCAN we *only* want the cleanup part without the
	 * rest of hci_conn_del.
	 */
	hci_conn_cleanup(conn);

 3. "hci_conn_cleanup()" will eventually be called, not from
    "hci_conn_del()" but from "le_scan_cleanup()". It will call
    "hci_conn_del_sysfs()" that deletes the device.

 4. There are several "hci_conn_get()" with matching "hci_conn_put()":
     1. "hci_chan_create()" calls "hci_conn_get()" because it sets the
        "conn" field of the "struct hci_chan" it is initialising.
	"hci_chan_create()" is matched by "hci_chan_del()", which
	calls "hci_conn_put()".
     2. "hci_connect_le_scan_remove()" calls "hci_conn_get()". An
        explicit comment explains some cleaning work is deferred to
        the "le_scan_cleanup()" callback, which indeed calls
        "hci_conn_put()".
     3. "l2cap_conn_add()" calls "hci_conn_get()" because it sets the
        "hcon" field of the "struct hci_chan" it is initialising.
	Following the "<...>_add()" / "<...>_del()" convention,
	"l2cap_conn_del()" should match "l2cap_conn_add()". In our use
	case, "l2cap_conn_del()" is never called, and it does not
	contain any "hci_conn_put()" either. The "hci_conn_put()" is
	deferred in the "l2cap_conn_free()" that is eventually called
	when the reference counter in the "struct kref ref" member of
	the "struct l2cap_conn" reaches 0.

In our sources, "l2cap_conn_del()" is called only in
"l2cap_connect_cfm()" and "l2cap_disconn_cfm()", but those callbacks
are never called in our use case.

References:
- [1] "Adding reference counters (krefs) to kernel objects"
      <https://www.kernel.org/doc/html/v6.5/core-api/kref.html>
- [2] "struct l2cap_conn"
      <https://elixir.bootlin.com/linux/v6.5/source/include/net/bluetooth/l2cap.h#L674>
- [3] "l2cap_chan_connect()"
      <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L7939>
- [4] "__l2cap_chan_add()"
      <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L583>
- [5] "l2cap_chan_del()"
      <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L642>
- [6] commit b7556839b38b ("Bluetooth: L2CAP: use refcount on struct
      l2cap_chan->conn")
- [7] "ble-memleak-repro"
      <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
- [8] "[syzbot] [bluetooth?] memory leak in hci_conn_add (2)"
      <https://lore.kernel.org/linux-bluetooth/0000000000000fd01206046e7410@google.com/T/#u>

Signed-off-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
---
 net/bluetooth/l2cap_core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 768632fba6f8..f5dcb4a4fb15 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8080,7 +8080,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		if (data.count > L2CAP_ECRED_CONN_SCID_MAX) {
 			hci_conn_drop(hcon);
 			err = -EPROTO;
-			goto done;
+			goto release_conn;
 		}
 	}
 
@@ -8126,6 +8126,18 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 chan_unlock:
 	l2cap_chan_unlock(chan);
 	mutex_unlock(&conn->chan_lock);
+
+release_conn:
+	/* Transfer the "conn" ownership to "chan->conn".
+	 * l2cap_conn_add() above has created "conn" with a
+	 * ref-counter at 1. "__l2cap_chan_add()" stored a "conn"
+	 * reference in "chan->conn" and incremented the ref-counter.
+	 * Before "conn" goes out of scope, decrement here the "conn"
+	 * ref-counter, so that when "l2cap_chan_del()" will
+	 * eventually decrement the ref-counter, the "conn" will be
+	 * freed.
+	 */
+	l2cap_conn_put(conn);
 done:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
2.39.2

