Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624044;
	b=Pin3dQHkloFF93SFkm/XUs/c+czjdmLbv3hJwbPwFGi6N5KwPqZ7dIaz+dmMgD8xJ4nE
	 7yc595Y5JKoEBMrdEIA6p7GRTyrXtEIV8vVFPfspXuuaRZ5jp68ncEwcjN5PeyN0dkcGv
	 oePjn+xLhetx7y/tJgI1rKb+DKqUJFYyOkEXtEaEpMiD4ejdgBeKrqTtDpdp9ms2nQRGV
	 CriE1SEDn7W7jv6+XyQpLnpD3s+ZTYOEe4KOfjeCpNoL0oMW2DSyN1Ik/8OOL4zneNxUR
	 RtbdJ9xhkT7CqtIkV+OWy9wQs0F8L1z0sv21rqp+1kWV1JjLvVwd7u6udluiDXexZAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CrDGRVgZRLKfn8v9BBHhfnTXrk8Jh8Bf4xopcuuTKCI=;
	b=rk46tu6f2BUFhBqeEzoTIJNC+099nP5UV0wRvKOyi6SbiEg5+lr1EDwL0NbAlKMgr2ol
	 OsPTFlBjmj5np1Rieog4mAR/FTJLMPi2Ts1ZOGLKySRWqnZ4lsdXUgHzfsD5OzpFCc1Ky
	 rKNZPH3InGODHC2jiFt8Z8Kp3PBYVEMBZ8PHliDTBU3do0ZWfhtiTS/8VHvVq32afNYrz
	 4M9k4maW06YVLoRM9lPpaU0aTWzWIWZbN8Fm97VqUxcafhs5jDwQlYZ2PTCn8QYOdOkuY
	 Itf6Gig2CrAHt1VSSyQnHdVPXXyZ0PULnSkro/M4wJjjV+gx0I43gunjrb/+OtheuGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qgaLORto;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952E606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9952E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qgaLORto
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d6a6776719so3646847137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624043; x=1796228843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CrDGRVgZRLKfn8v9BBHhfnTXrk8Jh8Bf4xopcuuTKCI=;
        b=qgaLORtoe2MUK0JwRtpe4hQn3fCk4Fck97EGisS6pv8HR44GEo3nA8QIXSHRigDTha
         7YQ3RBOKu2zpwtUFu+acunmSp4bgIYCPCdCFOH/J784SV5zD/DiRUrwIJnz6WDELJfTu
         gdvp5ZLRVb/XzPWaauVPJegJoydWPhIv3PmaN3VPYGuXNALxW8CUugwCMAio2zUZ5NVs
         VpUDFCfN3DWAma+zZiHfT8oKei2qd0zmxh0I6Y44fSh5IEklWmT7UADegUWy8FEpDEhB
         DwqNJoiSi7a0m0D9FLgoBYQv4KdE0UH4RFZkzREvkA3g934m4OiA+p/BD8RtLJQHySYf
         Bxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624043; x=1796228843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CrDGRVgZRLKfn8v9BBHhfnTXrk8Jh8Bf4xopcuuTKCI=;
        b=lMPKnW0SdO4b8HMcGUTyIWtRAJWmWhh8rcFRpAVM+3thQPdWTYKpNba/IhYZvM5x+w
         zDz8GSXl4GJok04oa3jYV/enQhC8Cyi91Rdl+/btY6USJuK99amfzhD50Qii77ibkmc/
         wc3xCaVS/vdnupyk5KeJ33aU6QMKzJAfanPx+03i3R6m3boxpBTQ3eSfpDljTmiiaSjJ
         dw6mPDv2LJ9qNY7meU6prdzyHWKBqudQtMVwQeB1nk69j4JntXZ2G/gcdBCYnTny7Xkf
         0gDdFPHqHH5YlZMXeRszc3MTaAYJahwU1PM48BOaufacj1vyQ7GanFscklTn/GsH1EjI
         Y5tQ==
X-Gm-Message-State: APuU4Z+BWxfYJ6a0KusinqsjL2Es0x9okvCv4vJW+NcjEUTMq21aa51m
	++8U/LUYdYelXjbkZwWNC1dbbeNFORDO4Wnd3oByyivWGMnTp8qVIFMneQfyMQ==
X-Gm-Gg: AZFdTZcxvxc7a94y/7ShzvM7asiXR6Wr33a3VjOqVzyi/KkqNvIEeUCw+EqyYucyJwP
	VZXqh4K73s0ObtBoSgHHU+VuyBsXkdov68cYxzJcIE9ALi3g+KqDsACm4FlDtJUkEepHLtnIHlv
	aokIE4s+m3MBzqzifBdlkJhqRu37iO/30q1jk9Ei6za4WfKaek0V4PLGkrxnF8XeStSDEpwjSoL
	WuMuKd1lX2EhjGBM1DnMjY4WwkeDiViIJuDNMdMUIXq5rIw4X0zL1nuuUaY+YdVcxWkxRv9IGsR
	uQaq8JBS+S7HJlXKFAixYUsX22jBhIqZZzmtQ5kz/SOtsaYfRVxJUKXxkSMS/XU2iMI2kGVip3Z
	wqb9Lz32uksEWYMJHNrER8WIasOUu97DMLih3iRX90TJAp+QZSbuk8/dmMMOKtpq5AYJJT2CBhu
	xjnMhZvMiqbKKBBOK6LodRh7Vig0Y+Uv2+AHfbnyeG5/UEaS+6/KdRr2lVg89jTevG49tGUMRCs
	i2qLNyb2GjzLuv0HGkKQvFqmVlPfH7RPiJSm/e3AzM2KSYoAGpNawg3zUHkdVdI6rw2zTqW8brZ
	NGz1jYdHhHYcmmAMfF41aPjbQ3edsP6RH2U4MTNlsXGNmwHRb3OV/B3M+Nyh5vDc638wWZ7e4hr
	lPyrI/toQKkG83TE4NYy64VJ0zF/IrKWKM9Pgv/k563QD/5ZtYBSYNUHs4JzhvGb0pzuVmA4JXf
	BJ83c=
X-Received: by 2002:a05:6102:26d3:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d739460f96mr10126744137.18.1795624043367;
        Wed, 25 Nov 2026 08:27:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e8265e55sm19511881137.11.2026.11.25.08.27.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:27:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
Date: Wed, 25 Nov 2026 11:27:19 -0500
Message-ID: <20261125162719.1407771-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125162719.1407771-1-luiz.dentz@gmail.com>
References: <20261125162719.1407771-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A BR/EDR channel is moved to BT_CONNECT2 as soon as the connection
request is answered as pending, no matter if it is waiting for the
information exchange, for the link security or for userspace to
authorize it, and the socket state follows the channel state.

bt_accept_poll() assumes that a child in BT_CONNECT2 of a listener
using BT_DEFER_SETUP is waiting to be authorized, and
bt_accept_dequeue() returns any child of such a listener, so although
the listener is only notified once the security is met, a listener
that doesn't wait for it can accept() the child and then authorize it
with recvmsg() while authentication is still pending.
l2cap_sock_defer() then moves the channel to BT_CONFIG and responds
with L2CAP_CR_SUCCESS, and if authentication fails afterwards the
channel is left open since l2cap_security_cfm() doesn't close channels
in BT_CONFIG.

Fix this by only moving the socket to BT_CONNECT2 when the channel is
offered to the listener with l2cap_sock_defer_cb(), which is only
called once the security is met, and by only letting accept() return a
child of a listener using BT_DEFER_SETUP once it is in BT_CONNECT2, as
bt_accept_poll() does. The child stays in the accept queue so the
backlog limit and the cleanup done when the listener is closed are not
affected.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/af_bluetooth.c |  6 +++++-
 net/bluetooth/l2cap_sock.c   | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 7758e9ea3848..103d61d13fbf 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -330,8 +330,12 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			continue;
 		}
 
+		/* With deferred setup only a child in BT_CONNECT2 has been
+		 * offered to the listener, see bt_accept_poll().
+		 */
 		if (sk->sk_state == BT_CONNECTED || !newsock ||
-		    test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)) {
+		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
+		     sk->sk_state == BT_CONNECT2)) {
 			bt_accept_unlink(sk);
 			if (newsock)
 				sock_graft(sk, newsock);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c8730e4b6c21..fec393d460d1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1831,7 +1831,13 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 
 	lock_sock(sk);
 
-	sk->sk_state = state;
+	/* BT_CONNECT2 also covers a channel still waiting for the information
+	 * exchange or link security. Only l2cap_sock_defer_cb() moves the
+	 * socket to BT_CONNECT2, once the channel can be offered to the
+	 * listener.
+	 */
+	if (state != BT_CONNECT2)
+		sk->sk_state = state;
 
 	if (err)
 		sk->sk_err = err;
@@ -1899,6 +1905,8 @@ static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 
 	lock_sock(sk);
 
+	sk->sk_state = BT_CONNECT2;
+
 	parent = bt_sk(sk)->parent;
 	if (parent)
 		parent->sk_data_ready(parent);
-- 
2.56.0

