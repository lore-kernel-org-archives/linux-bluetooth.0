Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3D3B775A
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617628; cv=none; b=d9GPyUjBxiF1WZ0fV1MkVGVBRjh3ZcdIn2OaacHLuoB82p04v8LwezrfR9wJ41K/urEUeUzcoCTasllDV9gOpZc/I/AcXx1xj+b5mR5HdwbqijB8TJuhMcHPBZYmACl5WkQS8fiWyVi2CuIsQGmhtkdJW9RteeIAMHL1cNxCqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617628; c=relaxed/simple;
	bh=NndGd9GOf0I6NO8Ce3nP+s13O09BbawYzE6kgfvxPZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxkBo+vj/gVjRimujir1BfPIAEi4WPOGxopqHKn3pZDUZp0oAd0ZjAXdhz/XH+UD9jCJ+TGdpNMxGwMgoJhw3cwT3Jb8vBb88zup6gMGtvpqAUzwNtMYWuXKFlGI13p35kjPk2ZUBUeGIozy+4KnBSxWms75VQI5dkol07mufDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPELqpR0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPELqpR0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so2559025e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789617617; x=1790222417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TH7pqPWttSJGp/Lqeiet7/X4Ui7u8p69YinbdJusLhk=;
        b=qPELqpR04YALqjxUxYX27T5X6LbKk7qrq2qS4kGgGTQpyIJTtjUNQOrjXzVat2nJR7
         cvWbz/2JETY+eWMI5n/cGRtA4oVq+IorawxoFFcbvWCN/QgnI/Li/oJW55jlXl2wrhsV
         twyuzaKIivXO3EQQKVwb++qJFll81qA36yH9L8JeqFXW2mWXBlpS4CfuM5scboFuWneB
         EILTypVnyiaTrh/ZsQTpCGdE44iHP7oDfsclJ68X+avzaBrYLMBQ9PUXJCl2SNk4US4j
         p82EAspswa8ms4XxoRVCeSJ+NciuPPSlw3ClQAN6/sdvk+qGCMttXAnsmbCdz0v8xi83
         Z1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789617617; x=1790222417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TH7pqPWttSJGp/Lqeiet7/X4Ui7u8p69YinbdJusLhk=;
        b=XbQ1LYXnP/PqD5+ZxiD3RgEVv6qy0vshczWqfedy5KNT9cxd4ARxRcOE3j1YCYf7dZ
         865voeLP/20K+/PydgUaA80Ufx91OoQrHv7OEleAbcyY2ZRL6C7QMHKF/acGoxXpzfqi
         WkwfF8lGS+2c8csGXrRo9/JdmIdzrhQIHlDLpMtxPjrRDXuAz4Abp5TI381V4ZW0x7kY
         dN6Ym2veNyFfGWH/VcVT5m/5ZduMLx7ffRnL6oCBzzZ7rpNCJ0i3Obc5AhepKtvhRhrr
         4EOzSLzUtue0wL252kqarjd16s9zjz/kfcTgFScnkOermotIYP0ynyDcW7mY8iLleKsq
         I5+g==
X-Forwarded-Encrypted: i=1; AKwUvBwYmqPsv9xaZ7WRZ90aUEPcd3nMKWfy0NveFU8LB0m9nLuFVmMqpcUb+O4hFuVYkDzGgSC1vi+A/Fpd6IJVfOE=@vger.kernel.org
X-Gm-Message-State: AFuF++nV/l8/qXX0oYqKISnyEA0awSpYI7Bj6rrRo3UCfrPlaojx4Dp+
	+qvENKrSdiO+tpv4ocP49kaU73jZ3m6klYlSWPOkrYtJrRMp+ySXO7cv
X-Gm-Gg: AYBFou3AdtkZN7aXrK7MRTfhCEpVkOspK7iAAYsuuas+yyuyWNuy4hCXaBEznTIPVaW
	g1t4U0K3cMls+x6jmHGT0xMW1rLPDL+9O7V7nsw1GjYGtvLixK9Cq/wTlPaLeujlIbQiRwTYisr
	FZf6LqBAyCaMXottrnQ6snlgE6yXHRA+3hpEsSZByJDUNGA6hqAlREQstxEEv3UC1urQcYlPeOX
	sBGIvDl8CXBqIQ6B4O/WGCO8oJyqtE4VRVRNUwoIjPY7vW+ugNm1ThkQNiuEgKc4hqrCuwNfL9k
	D15fYSAy5iCsXLXG4l4RAy+EYEUDwRq50LojflArb9eAnds6MgV0hDZnMU2uR5+/yQB5bEOkc/D
	mj5sYJHX5rpsJbHs64hu7ZRTHs9+f8mEzQmEuxyfoLQjxadpJQI7XRMlXd3oR7tjMQE4GHxu+tG
	vFTknX0bgcsQs0gKav3zt14ooEFI4C5W4Rl/P70upBJLTwFatVyuC9X6+zlK5VATTCSa68hZfyG
	WSTBkj3/GP6a/uRq3/XsCPAXa8hZH86gMfzsFQEEVBVJ0btbQ/ax7KfxyKu4ldl9WTuPN8UNIKy
	NR8u9LE/vAfSBQN9nuJP1aY7fpa4BklD5u9sehz2xZtinTx2XXiBYudRat1sFQU3Q5kVfspVIMQ
	b
X-Received: by 2002:a05:600c:83c8:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49eb7341406mr52441125e9.29.1789617616894;
        Wed, 16 Sep 2026 21:00:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbfd935cfsm6880015e9.0.2026.09.16.21.00.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 21:00:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	eadavis@qq.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	pav@iki.fi,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Subject: [PATCH 5.15.y 2/2] bluetooth/l2cap: sync sock recv cb and release
Date: Thu, 17 Sep 2026 06:00:04 +0200
Message-Id: <20260917040004.21041-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260917040004.21041-1-kmehltretter@gmail.com>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065546.976652519@linuxfoundation.org> <20260913202907.3100-1-kmehltretter@gmail.com>
 <20260917040004.21041-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 89e856e124f9ae548572c56b1b70c2255705f8fe ]

The problem occurs between the system call to close the sock and hci_rx_work,
where the former releases the sock and the latter accesses it without lock protection.

           CPU0                       CPU1
           ----                       ----
           sock_close                 hci_rx_work
	   l2cap_sock_release         hci_acldata_packet
	   l2cap_sock_kill            l2cap_recv_frame
	   sk_free                    l2cap_conless_channel
	                              l2cap_sock_recv_cb

If hci_rx_work processes the data that needs to be received before the sock is
closed, then everything is normal; Otherwise, the work thread may access the
released sock when receiving data.

Add a chan mutex in the rx callback of the sock to achieve synchronization between
the sock release and recv cb.

Sock is dead, so set chan data to NULL, avoid others use invalid sock pointer.

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Karl Mehltretter: applied in the form this commit has after
  f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock"), that is the
  chan->data clearing in l2cap_sock_kill() and the guard in
  l2cap_sock_recv_cb(), without the channel locking in the callback.
  That locking is what caused the recursive chan->lock deadlock.
  f1a8f402f13f removes it and moves the lock to l2cap_conless_channel(),
  which the previous patch does here. l2cap_data_channel() already
  obtains the channel locked from l2cap_get_chan_by_scid(). ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0b51c3e0f469..bef6a948d7d5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1237,6 +1237,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1519,9 +1523,13 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
+	struct sock *sk;
 	int err;
 
+	sk = chan->data;
+	if (!sk)
+		return -ENXIO;
+
 	lock_sock(sk);
 
 	if (l2cap_pi(sk)->rx_busy_skb) {
-- 
2.51.0
