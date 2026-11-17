Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926984;
	b=Uj4iD+7/6DKeHpZvZmZY2zwIDgsOG34oj4Q2n5WbMA7xlbDqrVTaaKgsLb3zcp89YL8Q
	 y5QyZHrNAlKJ2mWxwd/rU8Fv3uROufpXKaWstmJ8uacy0VNXxq4DKJMhmKrmVTkM8YoTs
	 REedl9xNILP4tBW8mF9a7VWAFkPBhen1kW/QIzB164ucAAsQefgpK1/ltGGItYgZtoUu5
	 du+THwi+husjV4I3a6t6IM5BWfKaoUuh4B5zHs44NGYRFbGQeX6Cg6XPZw3LuEBH4zh2k
	 36a4z4QongxGTQeFv7uF4y2G8E819BPrr1p4JeOzYVM3R7kYizzfLkB5GR4AWWb0MOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3sTWPUTlwAcUBnRVcL93zdm48VDNuD84VEKeKVBAxRU=;
	b=fKrYlKkClGxqAhMLQAgPhW5Ir9MaOAx/Kr559mIKc1dToReG7y6rIWwVqXhDboZvbKff
	 IEMWo+O3g28QiL7LJ+s3j5BwCylEY5Sg7UnykQJA7M/dZBuat3KMQ1A4pIH7yD2AJSDfO
	 iulPeg0Mk+WZW4HW3IVmrZD/9EK0OPSmcInhni/0CP6Rcr67TCTuZfwStBPCf0/AU2qfG
	 moxXr7SKyjHEQWBgXFc9YZ1BijeE/KfHegivQPHTzM0qLyMoAWM7YnldgYSOSW4+U2pGY
	 j/++v5TQ2RHqxvwPrlRVLfxdUgP3bG5UOGmJZqELXtGDwLmulqXHqzzsbRKbpFK6I4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+q9gXIV;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CA606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 14:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+q9gXIV
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cddc597d062so2998176a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 06:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794926983; x=1795531783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3sTWPUTlwAcUBnRVcL93zdm48VDNuD84VEKeKVBAxRU=;
        b=c+q9gXIVbFD39Pr8RsogKNzLXL/TkHDlBjgA8twtnolwwDOKAYwY22FaeL7L7GcQmM
         vh2kxx4l9EQuoFpxDQuF7i5ePGgH3wsaKcRRfer6sY3hJUk4je7kT0CcPphm4gpbpxoT
         fqA3k2CTrEDLJWWRxniAn2dgRDu/EEhM/0HJLFAds6N6LsARCxA2WJAqSHBmpPcyJAz5
         mk3w3Q50hLq5y3Ys7fBMkH1MUXsFwQzSa6FyyOEUy7wGxwhZmJqpfnUv4aJVt3bwSnot
         XfEUcl596ql9uv/U3iNTbxIydhU3O4GACxrCTNPlUjwv5WL2Stsaph57EvYLLXonsdDd
         HxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926983; x=1795531783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3sTWPUTlwAcUBnRVcL93zdm48VDNuD84VEKeKVBAxRU=;
        b=H4tzzjsOUkGW00BTUNvSgKjWQdbhPrRFbpush9jfwpIhBMOxOQMDO2/Zy7ZxSv8iUx
         NagSZAPlAGN2e7gFmuQYzJsxKVxfgOggqDw9ukDWZ2ZSArJI8WG5PSjj4wNJAGna45ec
         Vk+OSEnKC2iC7/tLW9E6CAIi9TKYzIYYCrCWVzyeFJ+W5FpJOjglTCQ2rsQriKkg3J9w
         37P9cGuIQeGpHb2WODMQwKTNPEJiobmGIJ8J09c7x4hr9QK1c+DX32C5O4DelOHAF9gr
         LcWPoIPspEr8fivC1RYAUiNNIoLGAza+FkLDlztNZeDp7+bjOmW9vubfH4OEckSyQNV6
         kX/w==
X-Gm-Message-State: APuU4Z8o7P7/mpCsg79SuDN2W+ttEXf3m63MBgXfFaBhQy8vuT/hNVPy
	Ud1G21OESOZYIvu7LzI6qtS5OfA9WfezkctbDqyu6XaRFTuyFjD2YGBg
X-Gm-Gg: AZFdTZcIsXJAhfbLXcJiefhcFfo9t7DmspYNjSI6bqmCMT058qKhai1HdijrzlMBo/3
	d11N2IGfCl5YQOgbfMPPGEnmx+6qhGuIhQKguEJUVWHpWUapKef4hEKAy5IciNrlEzq63FYuYvX
	2bf9ry+l8CCee5qcCLAlKwXlHaXAfggD69lXWVsDOPcwP21+V+6GzhJZgHNcR/xitpDDfmlTotD
	J4z1Yl9paRTWWI1GjbMgqHJLPc7a65i/F/PQd2W/2XxedLcBg0uvTixWaF26hTOA+L/K+q/X3j0
	NJ5pXeH9a1q/Tfno4afTD8PkNLjfiBmrgbOK+unbev+8sBYJMt+YdT2gvafNsfsVSmOs1WQBLBf
	soFbnTe987oC1Ya8anP1RjOn3+o3gYAkKB0q+xusT3WVm0eaRhkZ59Rckvd2FIbfVzfXPeFQx5F
	FxUDe3elBT+sIeF+gMDtt5UsSqzw3fxniftTWQUOiFKCc6jmW9bBamImoDFMc/Uy3Opr9wIquIj
	ssaKXAb/yM0IhzKQ/radVdkDeg9fc0k3s3qHQ9rIagxfXHcElBpy6gg3Y/fYA/4a2tTLEprjYEQ
	S3BJylWY4F8Qjc+hx3qbwhagWQuoNA==
X-Received: by 2002:a17:90b:1dc8:b0:3b1:12ba:867e with SMTP id 98e67ed59e1d1-3b1b0b5b550mr14590958a91.13.1794926982909;
        Tue, 17 Nov 2026 06:49:42 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac1:7ac0:50::498:83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3b6da0fa8sm3491697a91.9.2026.11.17.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:49:42 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stig Hornang <stig@hornang.me>,
	syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
Subject: [PATCH v2] Bluetooth: L2CAP: return LE credits from recvmsg under the conn lock
Date: Tue, 17 Nov 2026 21:49:37 +0700
Message-ID: <20261117144938.82299-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
References: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
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

l2cap_chan_le_send_credits() allocates an ident from conn->tx_ida, sends
L2CAP_LE_CREDITS and frees the ident right away, since the command has
no response. The RX path frees idents in l2cap_put_ident() under
conn->lock. That only works if the credits path holds conn->lock too,
so that no response can be processed between the allocation and the
free.

The RX path does, but l2cap_sock_recvmsg() calls l2cap_publish_rx_avail()
-> l2cap_chan_rx_avail() -> l2cap_chan_le_send_credits() with only the
socket lock held. If the remote answers the credits packet with
L2CAP_COMMAND_REJ, l2cap_put_ident() can free the ident first, and the
credits path then frees it again:

  ida_free called for id=3 which is not allocated.
  WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594
  Call trace:
   ida_free+0x24c/0x2d4 lib/idr.c:594
   l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
   l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
   l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c
   l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317

The same unlocked call also updates chan->rx_credits and reads chan->sdu
concurrently with the RX path.

Publish rx_avail from recvmsg under conn->lock and chan->lock, taken with
l2cap_chan_lock_conn() as l2cap_sock_defer() already does, before taking
the socket lock to keep the conn->lock -> chan->lock -> sk_lock order.
Assert conn->lock in l2cap_chan_le_send_credits() so that an unlocked
caller is caught by lockdep.

Fixes: 6e1930ece855 ("Bluetooth: L2CAP: fix tx ident leak for commands without a response")
Reported-by: syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9dc8780713b11155dd74
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2:
- Drop the untracked cyclic ident from v1: it could collide with the
  ident of an in-flight request, so a REJ of the credits packet could
  free that ident and close the waiting channel (reported by Sashiko).
- Fix the root cause instead: return credits from recvmsg under the
  same locks as the RX path. This also covers the unlocked
  chan->rx_credits / chan->sdu access on this path that Sashiko noted.
v1: https://lore.kernel.org/all/20261115115341.316484-1-ngocthang2710.1999@gmail.com/

Tested in QEMU (x86_64, KASAN + lockdep) with the syzbot C reproducer,
15 runs per kernel on 666539eecdf4, credits counted via dynamic debug:
  base:    10191 LE credits sent, 49x "ida_free called for id=N ..."
  patched:  9330 LE credits sent, no warnings, no lockdep reports

 net/bluetooth/l2cap_core.c | 3 +++
 net/bluetooth/l2cap_sock.c | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7dcb0586a10b..12794af1cba4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7099,6 +7099,9 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	pkt.cid     = cpu_to_le16(chan->scid);
 	pkt.credits = cpu_to_le16(return_credits);
 
+	/* Keeps l2cap_put_ident() from releasing ident before we do */
+	lockdep_assert_held(&conn->lock);
+
 	ident = l2cap_get_ident(conn);
 
 	l2cap_send_cmd(conn, ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e5c15c083c1a..3db1608dd71a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1292,6 +1292,7 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	bool have_conn;
 	int err;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
@@ -1312,9 +1313,12 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	    pi->chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return err;
 
-	lock_sock(sk);
-
+	/* Returning credits must be serialized with the RX path */
+	have_conn = l2cap_chan_lock_conn(pi->chan);
 	l2cap_publish_rx_avail(pi->chan);
+	l2cap_chan_unlock_conn(pi->chan, have_conn);
+
+	lock_sock(sk);
 
 	/* Attempt to put pending rx data in the socket buffer */
 	while (!list_empty(&pi->rx_busy)) {
-- 
2.43.0

