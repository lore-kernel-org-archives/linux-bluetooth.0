Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74871EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 18:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjFMSGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFMSGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 14:06:16 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0019A8
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 11:06:10 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Qgc1Y25g5z10MP;
        Tue, 13 Jun 2023 21:06:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1686679569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A88fH+WVTfME8Ra4Drw+Ud5TSkQO5GNvM/Shcwais9w=;
        b=Ow/YcC40506svU97MaNFqHFX/Bp3En1jDPp+9jN0bKpIKcZhQ3x61/4BziBJrFXFrm4gIx
        gvp4qctClbZC5aFVv0UOdIyPSBhRNwVZtEbEpTFMPp1Inar93yDVX8Wyrs9BaL3u6OCekp
        zogCBrVjFa9yiifXbiVdmPUeFuu7LUI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1686679569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A88fH+WVTfME8Ra4Drw+Ud5TSkQO5GNvM/Shcwais9w=;
        b=hgwL59+8QY96QUlinwFhfj81qQZaLjw6QLdeZvnCj+sAno29SmG3JUXQ0T1Ca36vU25YVF
        n13FwHPvny3FM8vHqgER+YH22VzzDx5RBeW8i8eVhkfh44FGXpCq2uhgd0B05phWVX35sH
        +NxYgwE2MOoIUfGHIL7DBFlTbtF2Ocs=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1686679569; a=rsa-sha256; cv=none;
        b=Wj+TBaK3GGuNXJ95hfa0gAYTL5fT59mQF5QjkzuPWzlQ22QUvdPy2r/2Ds8efeR8amQrRZ
        zNWnfbh4mISjZA2r/Xy4U3NHm5zs0sDslmDT5xkTU4yKqdBYAceaBos472vRuXKAXqneht
        642GnnVy7E9keZBP+wAeJX+bM0Yuup8=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues
Date:   Tue, 13 Jun 2023 21:06:04 +0300
Message-Id: <3a0cbe341bd6051ffcd58d3abef6800f9f2615ff.1686589290.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686589290.git.pav@iki.fi>
References: <cover.1686589290.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sk->sk_state indicates whether iso_pi(sk)->conn is valid. Operations
that check/update sk_state and access conn should hold lock_sock,
otherwise they can race.

The order of taking locks is hci_dev_lock > lock_sock > iso_conn_lock,
which is how it is in connect/disconnect_cfm -> iso_conn_del ->
iso_chan_del.

Fix locking in iso_connect_cis/bis and sendmsg/recvmsg to take lock_sock
around updating sk_state and conn.

iso_conn_del must not occur during iso_connect_cis/bis, as it frees the
iso_conn. Hold hdev->lock longer to prevent that.

This should not reintroduce the issue fixed in commit 241f51931c35
("Bluetooth: ISO: Avoid circular locking dependency"), since the we
acquire locks in order. We retain the fix in iso_sock_connect to release
lock_sock before iso_connect_* acquires hdev->lock.

Similarly for commit 6a5ad251b7cd ("Bluetooth: ISO: Fix possible
circular locking dependency"). We retain the fix in iso_conn_ready to
not acquire iso_conn_lock before lock_sock.

iso_conn_add shall return iso_conn with valid hcon. Make it so also when
reusing an old CIS connection waiting for disconnect timeout (see
__iso_sock_close where conn->hcon is set to NULL).

Trace with iso_conn_del after iso_chan_add in iso_connect_cis:
===============================================================
iso_sock_create:771: sock 00000000be9b69b7
iso_sock_init:693: sk 000000004dff667e
iso_sock_bind:827: sk 000000004dff667e 70:1a:b8:98:ff:a2 type 1
iso_sock_setsockopt:1289: sk 000000004dff667e
iso_sock_setsockopt:1289: sk 000000004dff667e
iso_sock_setsockopt:1289: sk 000000004dff667e
iso_sock_connect:875: sk 000000004dff667e
iso_connect_cis:353: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7e:da
hci_get_route:1199: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7e:da
hci_conn_add:1005: hci0 dst 28:3d:c2:4a:7e:da
iso_conn_add:140: hcon 000000007b65d182 conn 00000000daf8625e
__iso_chan_add:214: conn 00000000daf8625e
iso_connect_cfm:1700: hcon 000000007b65d182 bdaddr 28:3d:c2:4a:7e:da status 12
iso_conn_del:187: hcon 000000007b65d182 conn 00000000daf8625e, err 16
iso_sock_clear_timer:117: sock 000000004dff667e state 3
    <Note: sk_state is BT_BOUND (3), so iso_connect_cis is still
    running at this point>
iso_chan_del:153: sk 000000004dff667e, conn 00000000daf8625e, err 16
hci_conn_del:1151: hci0 hcon 000000007b65d182 handle 65535
hci_conn_unlink:1102: hci0: hcon 000000007b65d182
hci_chan_list_flush:2780: hcon 000000007b65d182
iso_sock_getsockopt:1376: sk 000000004dff667e
iso_sock_getname:1070: sock 00000000be9b69b7, sk 000000004dff667e
iso_sock_getname:1070: sock 00000000be9b69b7, sk 000000004dff667e
iso_sock_getsockopt:1376: sk 000000004dff667e
iso_sock_getname:1070: sock 00000000be9b69b7, sk 000000004dff667e
iso_sock_getname:1070: sock 00000000be9b69b7, sk 000000004dff667e
iso_sock_shutdown:1434: sock 00000000be9b69b7, sk 000000004dff667e, how 1
__iso_sock_close:632: sk 000000004dff667e state 5 socket 00000000be9b69b7
     <Note: sk_state is BT_CONNECT (5), even though iso_chan_del sets
     BT_CLOSED (6). Only iso_connect_cis sets it to BT_CONNECT, so it
     must be that iso_chan_del occurred between iso_chan_add and end of
     iso_connect_cis.>
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 8000000006467067 P4D 8000000006467067 PUD 3f5f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP PTI
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
RIP: 0010:__iso_sock_close (net/bluetooth/iso.c:664) bluetooth
===============================================================

Trace with iso_conn_del before iso_chan_add in iso_connect_cis:
===============================================================
iso_connect_cis:356: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7e:da
...
iso_conn_add:140: hcon 0000000093bc551f conn 00000000768ae504
hci_dev_put:1487: hci0 orig refcnt 21
hci_event_packet:7607: hci0: event 0x0e
hci_cmd_complete_evt:4231: hci0: opcode 0x2062
hci_cc_le_set_cig_params:3846: hci0: status 0x07
hci_sent_cmd_data:3107: hci0 opcode 0x2062
iso_connect_cfm:1703: hcon 0000000093bc551f bdaddr 28:3d:c2:4a:7e:da status 7
iso_conn_del:187: hcon 0000000093bc551f conn 00000000768ae504, err 12
hci_conn_del:1151: hci0 hcon 0000000093bc551f handle 65535
hci_conn_unlink:1102: hci0: hcon 0000000093bc551f
hci_chan_list_flush:2780: hcon 0000000093bc551f
__iso_chan_add:214: conn 00000000768ae504
    <Note: this conn was already freed in iso_conn_del above>
iso_sock_clear_timer:117: sock 0000000098323f95 state 3
general protection fault, probably for non-canonical address 0x30b29c630930aec8: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 1920 Comm: bluetoothd Tainted: G            E      6.3.0-rc7+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
RIP: 0010:detach_if_pending+0x28/0xd0
Code: 90 90 0f 1f 44 00 00 48 8b 47 08 48 85 c0 0f 84 ad 00 00 00 55 89 d5 53 48 83 3f 00 48 89 fb 74 7d 66 90 48 8b 03 48 8b 53 08 <>
RSP: 0018:ffffb90841a67d08 EFLAGS: 00010007
RAX: 0000000000000000 RBX: ffff9141bd5061b8 RCX: 0000000000000000
RDX: 30b29c630930aec8 RSI: ffff9141fdd21e80 RDI: ffff9141bd5061b8
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffb90841a67b88
R10: 0000000000000003 R11: ffffffff8613f558 R12: ffff9141fdd21e80
R13: 0000000000000000 R14: ffff9141b5976010 R15: ffff914185755338
FS:  00007f45768bd840(0000) GS:ffff9141fdd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000619000424074 CR3: 0000000009f5e005 CR4: 0000000000170ee0
Call Trace:
 <TASK>
 timer_delete+0x48/0x80
 try_to_grab_pending+0xdf/0x170
 __cancel_work+0x37/0xb0
 iso_connect_cis+0x141/0x400 [bluetooth]
===============================================================

Trace with NULL conn->hcon in state BT_CONNECT:
===============================================================
__iso_sock_close:619: sk 00000000f7c71fc5 state 1 socket 00000000d90c5fe5
...
__iso_sock_close:619: sk 00000000f7c71fc5 state 8 socket 00000000d90c5fe5
iso_chan_del:153: sk 00000000f7c71fc5, conn 0000000022c03a7e, err 104
...
iso_sock_connect:862: sk 00000000129b56c3
iso_connect_cis:348: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7d:2a
hci_get_route:1199: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7d:2a
hci_dev_hold:1495: hci0 orig refcnt 19
__iso_chan_add:214: conn 0000000022c03a7e
    <Note: reusing old conn>
iso_sock_clear_timer:117: sock 00000000129b56c3 state 3
...
iso_sock_ready:1485: sk 00000000129b56c3
...
iso_sock_sendmsg:1077: sock 00000000e5013966, sk 00000000129b56c3
BUG: kernel NULL pointer dereference, address: 00000000000006a8
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 1403 Comm: wireplumber Tainted: G            E      6.3.0-rc7+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
RIP: 0010:iso_sock_sendmsg+0x63/0x2a0 [bluetooth]
===============================================================

Fixes: 241f51931c35 ("Bluetooth: ISO: Avoid circular locking dependency")
Fixes: 6a5ad251b7cd ("Bluetooth: ISO: Fix possible circular locking dependency")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: no changes
    
    Don't have a clean reproducer, but these occur sometimes on
    bluetooth-next/master when sending data over ISO and disconnecting +
    reconnecting immediately, although the timing window required for these
    to occur is not so wide.
    
    These appear to be somewhat more easily reproduced if
    hci_le_set_cig_params is changed to return errors if CIG is busy.
    Enabling printks also seems to help.

 net/bluetooth/iso.c | 53 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index b9a008fd10b1..8f570ab66ae7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -123,8 +123,11 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 {
 	struct iso_conn *conn = hcon->iso_data;
 
-	if (conn)
+	if (conn) {
+		if (!conn->hcon)
+			conn->hcon = hcon;
 		return conn;
+	}
 
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
@@ -311,14 +314,13 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	lock_sock(sk);
 
 	err = iso_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
-
-	lock_sock(sk);
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -335,7 +337,6 @@ static int iso_connect_bis(struct sock *sk)
 	}
 
 	release_sock(sk);
-	return err;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -403,14 +404,13 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	lock_sock(sk);
 
 	err = iso_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
-
-	lock_sock(sk);
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -427,7 +427,6 @@ static int iso_connect_cis(struct sock *sk)
 	}
 
 	release_sock(sk);
-	return err;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1078,8 +1077,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
-	struct iso_conn *conn = iso_pi(sk)->conn;
 	struct sk_buff *skb, **frag;
+	size_t mtu;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1091,11 +1090,18 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	if (sk->sk_state != BT_CONNECTED)
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_CONNECTED) {
+		release_sock(sk);
 		return -ENOTCONN;
+	}
+
+	mtu = iso_pi(sk)->conn->hcon->hdev->iso_mtu;
+
+	release_sock(sk);
 
-	skb = bt_skb_sendmsg(sk, msg, len, conn->hcon->hdev->iso_mtu,
-			     HCI_ISO_DATA_HDR_SIZE, 0);
+	skb = bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_DATA_HDR_SIZE, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1108,8 +1114,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	while (len) {
 		struct sk_buff *tmp;
 
-		tmp = bt_skb_sendmsg(sk, msg, len, conn->hcon->hdev->iso_mtu,
-				     0, 0);
+		tmp = bt_skb_sendmsg(sk, msg, len, mtu, 0, 0);
 		if (IS_ERR(tmp)) {
 			kfree_skb(skb);
 			return PTR_ERR(tmp);
@@ -1164,15 +1169,19 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	BT_DBG("sk %p", sk);
 
 	if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+		lock_sock(sk);
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
-			lock_sock(sk);
 			iso_conn_defer_accept(pi->conn->hcon);
 			sk->sk_state = BT_CONFIG;
 			release_sock(sk);
 			return 0;
 		case BT_CONNECT:
+			release_sock(sk);
 			return iso_connect_cis(sk);
+		default:
+			release_sock(sk);
+			break;
 		}
 	}
 
-- 
2.40.1

