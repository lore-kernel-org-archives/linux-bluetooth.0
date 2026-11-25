Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615194;
	b=d0LRfkvw9ej9O+d7Xr5MzVzh28Gws52vFtU29/BLfzlI0cegcBIxAW+p8JraDYjAg86t
	 /V6LAgqhbW0xI0R/UH11LEO3BfoMR6ANUb2xOXVuEhvfXfsJdIrTCAvBR2X002vxPiHZs
	 ctD80aixDP5Ax0VPbv/8O8o26VX63w+XVlyNFc5Jc7YGBhy+AU7uYHoe6LglFMU6nhL2d
	 MsJhrjCMkr66bDP07dxsqzO106n3cgNAE77vv7inhinHk8XrNI6QSEBsMOflplFBwlfm7
	 X2EMj23mop8MGqWBqgKYrYrcKiP4Ccuqh3sV03Mr350pmqXJh2bc525vP5cOs7qniaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/i1AWHwYlBYllRQmEBTMsajgoaO2HBUmLOsCfs1bkio=;
	b=rtFt4J8l25L4+sJUAxqEebPowfMxEUm4FJKyK68jXnCLdbWr4Uqv/nbQ3FJznv+oi0/E
	 CBTXdOqroLtB/t/qZNHQf+7UPQT9inlNxwXrIF0jXcp/rTl9iuzXOUpilweg6sqOZBVnv
	 DiHOrIp6ashdmA1TzxW0t0nSNSb435cllJDPu+HEa0R0SX0imQDRNJEiUqeAyD3jMhaGd
	 3XjbNnbF4h3YuwTrrEe0cXncsnxKNJbrURRWi/FCEcqZa5wVUtW0cR4lL/Ip7C9WGq6z9
	 HVF4yBtsSp6bMNFOdzcWUUKQvnGsYXMs4eBw+ol0RPDkA9Qyw4Ner2AKmDW2oeiIuXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvUIcSvw;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F3606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvUIcSvw
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1960491b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 05:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795615193; x=1796219993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/i1AWHwYlBYllRQmEBTMsajgoaO2HBUmLOsCfs1bkio=;
        b=IvUIcSvwIEKeStYvCEZkyRkQyd2l8HHztZEtP6YfhkMkVrhJEn6kWXHYHCW1yogsdH
         8iKl3n/pSANAPar97Z0LAPgJBFlDyCjCTFyed/QaDvXvXGWUdeZI2XFXFLfgEqOMvHL8
         tgOwkinlw81HL8nwl0NnRrjK5R3/Nn10U3cUNSbbhV2PKoKsPr6YFnyYMzOfWrvGNw7p
         59Tbiu/aFV+M73WD2xSKZlqkD6kpH36LeGyUATrvM9RDwzYMgjex9/x7T2DeYSdxBWyw
         I3H598kS4ChEpNWoYzaUSMmYBewLgPj9zWORC5jARBwli8yBT7EtCtSETft8IKNn7ueI
         rgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615193; x=1796219993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/i1AWHwYlBYllRQmEBTMsajgoaO2HBUmLOsCfs1bkio=;
        b=t6k2wj5TMulDFFJcahupU/g/qlXId5kd4oOrZ0nP0k0gKxHyqgawcX29AJWRS7Cn6T
         X9fSrlVi89iqNnkIxASqjSyv3LL3TtDk/KGkXT13KQT6bk1knOQ4otnn+IVdRRQlqbWq
         xOFCmQ2b+2tVYA9Bx2lavYitsj7LtpBXSD5rqAAanKjFZD7G8D+BLLWW0OYWxEUJeiRC
         g/wrZnOuXCw1ga9aDYF/jlsOVLAzpKfizfrLMnNHZJWny8rYYp87FbgGvQt+ZyRseyhM
         SzdzG3tYLSf3W+8fAYNe05Sz9/zTIjYuKTq/OMJd60sll+h2Zwxy7qGp4ZK+oga1JjgA
         aRfw==
X-Gm-Message-State: APuU4Z8V0SlZ7hGjlq581QE11hYLZ1NRdKO8ZxifmXQDfFYkuxy6WILR
	WbXScsjZ0wq8vXH/FTP5mxAI8A5W/c4juJpTtHENdMxn+5aqkkewv4X9
X-Gm-Gg: AZFdTZcRikc3unjJJJjw0V+uRxPBIHRVLkqo6rlUKKIqpf7+d1ONReeEASvDQSral7k
	QMV5b3pVhGFDFBe2soFQy9dGb1npYf4dGv0AD3INkoQdcHHAd0xuVUqNBtvQTwBfwxv53yjahAe
	nSbwcOI6aR3xAW9VUAjdZDfvgUYHucVbPMxNl1tDoUJe2Yvq0uXIEZXIbmhQo3Vkm1y8Ykla0ul
	Z9m7ksYSvT0/3mrDI7z72GU0N0/hPZvOVhEW1PB6SenYLxjgL450ii0Yp3p7K2P9xSZ+pi1LB6i
	DkXg6Uo8/QfHZXpFZl+eW0rLKv4Ie1MVa62NXNFEFNiX4tTAgRj2NBgPec0SzBEPEWbpPWth+WM
	5uUUweJQ6jO1CEhCiGd3WsXr6lMz/YwU0HrObfAU5MMih3reJrJXzGaUJqsdqYGO5wTTWBQI60v
	a+kqOZtfvdAxbK6BOwMvKUj6kVeyyoUd1Vn0Dj673pI2c1PCEOP0h5jvTJ4asKp4yBkNE5vnVgP
	LAixPJ2ag/1tsRqAiuZhhoMyoil0Wp2kcRW56+pipUckxr6zJOfrzE+esNtjnleykJ9+uJ/KFLg
	L2gBDciNbZkVsFeIi9IbXxIPaQ==
X-Received: by 2002:a05:6a21:511:b0:3f9:bcb9:30dc with SMTP id adf61e73a8af0-4014d14d4f5mr17022559637.38.1795615193316;
        Wed, 25 Nov 2026 05:59:53 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm9143860a12.2.2026.11.25.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:59:53 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: L2CAP: Serialize BT_SECURITY with connection teardown
Date: Wed, 25 Nov 2026 21:59:39 +0800
Message-Id: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connected socket BT_SECURITY path calls smp_conn_security() while
holding only its socket and channel locks. The callee requires exclusion
from l2cap_conn_del(), but the fixed SMP child can be torn down before
teardown reaches the later socket channel:

  BT_SECURITY syscall               HCI disconnect
  hold socket and channel locks
  smp_conn_security()
    chan = conn->smp
                                    delete SMP child
                                    wait for the socket channel
    l2cap_chan_lock(chan)

Use l2cap_chan_lock_conn() for BT_SECURITY and its matching unlock helper
on exit. This takes the existing connection mutex before the channel and
socket locks, excluding SMP child teardown across the security call.

The excerpt below retains the headline and stack traces.

The receive path uses the same helper in
commit 5beb86f98c3d4 ("Bluetooth: L2CAP: return LE credits from
recvmsg under the conn lock"). The nested connection, channel and
socket lock order follows
l2cap_sock_defer().

KASAN report as below:

    BUG: KASAN: slab-use-after-free in smp_conn_security+0x268/0x960
    Read of size 4 at addr ffff888110c2700c by task pmbd0211-client/530

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? smp_conn_security+0x268/0x960
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? smp_conn_security+0x268/0x960
     kasan_report+0xe0/0x110
     ? smp_conn_security+0x268/0x960
     kasan_check_range+0x105/0x1b0
     smp_conn_security+0x268/0x960
     ? find_held_lock+0x2b/0x80
     ? __pfx_smp_conn_security+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     ? __might_fault+0xdd/0x190
     l2cap_chan_check_security+0x16a/0x2b0
     l2cap_sock_setsockopt+0xc88/0x2270
     ? __pfx_sock_has_perm+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_l2cap_sock_setsockopt+0x10/0x10
     ? free_zapped_rcu+0xd0/0x1e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_socket_setsockopt+0x66/0x80
     ? __pfx_l2cap_sock_setsockopt+0x10/0x10
     do_sock_setsockopt+0x1fb/0x430
     ? __pfx_do_sock_setsockopt+0x10/0x10
     __sys_setsockopt+0x106/0x180
     __x64_sys_setsockopt+0xc2/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7fdfe600a2ba

     </TASK>

    Allocated by task 514:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     l2cap_chan_create+0x47/0x930
     l2cap_new_connection+0x1f/0x280
     l2cap_connect_cfm+0x46c/0xe60
     hci_le_remote_feat_complete_evt+0x417/0x680
     hci_le_meta_evt+0x30c/0x5c0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 514:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     l2cap_chan_put+0x273/0x3a0
     l2cap_conn_del+0x41f/0x860
     l2cap_disconn_cfm+0x87/0xd0
     hci_disconn_complete_evt+0x30f/0x990
     hci_event_packet+0x894/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

Fixes: b25120e1d5f2 ("Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/l2cap_sock.c | 158 +++++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 70 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d8a7b5f4baf64..fae2c64eb39e3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -929,12 +929,96 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
 	return 0;
 }
 
+static int l2cap_sock_set_security(struct sock *sk, sockptr_t optval,
+				   unsigned int optlen)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_conn *conn;
+	struct bt_security sec;
+	bool have_conn;
+	int err = 0;
+
+	have_conn = l2cap_chan_lock_conn(chan);
+	lock_sock(sk);
+
+	if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
+	    chan->chan_type != L2CAP_CHAN_FIXED &&
+	    chan->chan_type != L2CAP_CHAN_RAW) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	/* mic_len was added at the end of struct bt_security, so
+	 * accept the shorter struct as well, leaving mic_len unset.
+	 */
+	if (optlen < offsetofend(struct bt_security, key_size)) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	err = copy_struct_from_sockptr(&sec, sizeof(sec), optval,
+				       optlen);
+	if (err)
+		goto unlock;
+
+	if (sec.level < BT_SECURITY_LOW ||
+	    sec.level > BT_SECURITY_FIPS) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4,
+	 * Part E, Section 7.7.8: MIC_Length 0x00 is 32 bits,
+	 * 0x01 is 64 bits and 0x02 is 128 bits; all other
+	 * values are reserved for future use.
+	 */
+	if (sec.mic_len > 0x02) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	chan->sec_level = sec.level;
+	chan->mic_len = sec.mic_len;
+
+	conn = l2cap_chan_conn(chan);
+	if (!conn)
+		goto unlock;
+
+	/* change security for LE channels */
+	if (chan->scid == L2CAP_CID_ATT) {
+		l2cap_chan_req_mic_len(chan, conn->hcon);
+		if (smp_conn_security(conn->hcon, sec.level)) {
+			err = -EINVAL;
+			goto unlock;
+		}
+
+		set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+		sk->sk_state = BT_CONFIG;
+		chan->state = BT_CONFIG;
+
+	/* or for ACL link */
+	} else if ((sk->sk_state == BT_CONNECT2 &&
+		    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
+		   sk->sk_state == BT_CONNECTED) {
+		if (!l2cap_chan_check_security(chan, true))
+			set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+		else
+			sk->sk_state_change(sk);
+	} else {
+		err = -EINVAL;
+	}
+
+unlock:
+	release_sock(sk);
+	l2cap_chan_unlock_conn(chan, have_conn);
+	return err;
+}
+
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 				 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	struct bt_security sec;
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
 	int err = 0;
@@ -950,79 +1034,13 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
+	if (optname == BT_SECURITY)
+		return l2cap_sock_set_security(sk, optval, optlen);
+
 	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
-	case BT_SECURITY:
-		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
-		    chan->chan_type != L2CAP_CHAN_FIXED &&
-		    chan->chan_type != L2CAP_CHAN_RAW) {
-			err = -EINVAL;
-			break;
-		}
-
-		/* mic_len was added at the end of struct bt_security, so
-		 * accept the shorter struct as well, leaving mic_len unset.
-		 */
-		if (optlen < offsetofend(struct bt_security, key_size)) {
-			err = -EINVAL;
-			break;
-		}
-
-		err = copy_struct_from_sockptr(&sec, sizeof(sec), optval,
-					       optlen);
-		if (err)
-			break;
-
-		if (sec.level < BT_SECURITY_LOW ||
-		    sec.level > BT_SECURITY_FIPS) {
-			err = -EINVAL;
-			break;
-		}
-
-		/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4,
-		 * Part E, Section 7.7.8: MIC_Length 0x00 is 32 bits,
-		 * 0x01 is 64 bits and 0x02 is 128 bits; all other
-		 * values are reserved for future use.
-		 */
-		if (sec.mic_len > 0x02) {
-			err = -EINVAL;
-			break;
-		}
-
-		chan->sec_level = sec.level;
-		chan->mic_len = sec.mic_len;
-
-		conn = l2cap_chan_conn(chan);
-		if (!conn)
-			break;
-
-		/* change security for LE channels */
-		if (chan->scid == L2CAP_CID_ATT) {
-			l2cap_chan_req_mic_len(chan, conn->hcon);
-			if (smp_conn_security(conn->hcon, sec.level)) {
-				err = -EINVAL;
-				break;
-			}
-
-			set_bit(FLAG_PENDING_SECURITY, &chan->flags);
-			sk->sk_state = BT_CONFIG;
-			chan->state = BT_CONFIG;
-
-		/* or for ACL link */
-		} else if ((sk->sk_state == BT_CONNECT2 &&
-			    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
-			   sk->sk_state == BT_CONNECTED) {
-			if (!l2cap_chan_check_security(chan, true))
-				set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
-			else
-				sk->sk_state_change(sk);
-		} else {
-			err = -EINVAL;
-		}
-		break;
-
 	case BT_DEFER_SETUP:
 		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
 			err = -EINVAL;
