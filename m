Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03B823DD
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784521232; cv=none; b=FELp/y/r3/FVLBDdiJJd9zTVVPNQRN5zljQd8PvWejWUW9eMPsj8fXGC0E5R1agrGmdxarzigO9Zxj6zBThuxZ+rvFmv12bC/+5GUN12XkBgjsKGYpOZnnq3Eu0FVMLsQd17iJn92lMRxx1zN1U1QRFYXsb3R727ZhEZ/c3XVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784521232; c=relaxed/simple;
	bh=YmgYGyUpDAu0H3q5OnStVKMWPwv1KbTwSKGTGPAhHRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEdjavDW6LgjyFAYtTurs07RLeOh/JE6+Ye6tRCW3RY11QYccfTOHU6iH4lpkUKD39RJJbDcGJl9qHklDyqSJdBA1HB0bbFGHUdu/IXWqf4554tW7SpyAX+Zl7Nl04+wnaJ8fi1+XnZVwQh4r1EjQHlzWRm98niIZ2B2QJB6Rps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXDxixgV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXDxixgV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cae1a3a744so72890995ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 21:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784521230; x=1785126030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IV9s4hFvSMH+qyPoxR6Ev543soYmK66ij2t1GFhZjI8=;
        b=CXDxixgVYIqEWxgaq0HN9C+Qc/yVl1n6OLKjErUIr2xDhrjRqvwEN2mrPSEp0WBzH+
         SYpJsBBi0eH5lZkroVGgYCW8CvfuQJe9cMtksXFUqE3W2+DCQCnuK+fCJUusl4F8bWnh
         yVWqPajBXj/f63LWoSdFfs+TlCxKcg0H0TiQjWU6hdyvaaFJqoJPDyaos5BNAs9OPC9k
         RsjTTKUWJe9TLm25dseqTFFqY02kipEc92loFu6d7HKn33cXusxsXUcc5DNN9CwDoMPK
         eXy2ALyCh1n/47b9mi62r+IwW5UO3u6yQoIm6Ot2kevTSOi61wSJN4J5Qtf8xHFTpeov
         QPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784521230; x=1785126030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IV9s4hFvSMH+qyPoxR6Ev543soYmK66ij2t1GFhZjI8=;
        b=p/0/eSzuvHpditXQ3nRvIPNfVNggLfxqfloT5e2DDNcDq4iFnt2UZCnDK7xyloGyNA
         uCyYZYZ53X1lTnOR1I9ohtaPyypMFoSDxsLVyQZYWw0irKgOyfHDmS6D1dITNPi3Y9Sf
         iM4xtBl5bxHXl94RkjwCzNRPnlYqy885Z92pAj3FNt4VSoqjBxGps6Qg/wfETTZ6E90/
         9nsgScMgweyRjX9Mv5YobfWOugWwV1zegA9BsI98xYpWFRVkBJlJpJjk73joLsT/5zMh
         lchaDYkJ9l8rsH7ee8IC6cAHcbhJ/h9Jl0xhJHzarD4VqCySBhGLWIZRryRWDtj+xnN6
         S3/w==
X-Gm-Message-State: AOJu0Yx+7MQGdwULDw3DlzD/+RM1krV10CZKjnOwUciZ1g4jtmE7i92l
	F4m5CHp24EPUH6gllBWVw+DeX2WCv3FzhbavdWJiNIX/3xLhwnc71mrgCb1qih/Gwtw=
X-Gm-Gg: AfdE7cnmexzWYaFI8wcqXq8gaf0AEUAo4UN5drR3phmiuiUxQtYtpZSlrmzl+jm0fJ7
	xgIwA+x5CYhiqT1tVkCEBewBx8aIFosPgoroMfuMG2nU+hemN6OXyzQSNo1ZqcJX7qynVOJyYos
	0DIYneL43CoAuTE+blDBPSEKphi3TKje0qc9T1YH1SVF/M0wkma/c0WHPp2zo5bUUxZeyt82RVy
	7CDEDuciaWJH12/NVrpiyphxEwSOoBOJQYLUocv90XZ+1E+6waysw/HQ9HAhgN4iak3rGifJhed
	Igua2x/cE9s/gxq7nz6Ks9Mn45GQCmwUzkPRP9s3PcBNcQbZNpkDreBHwp4yaV4H43DXwHwb9uU
	wYje5tUv8skCb+1Wo8lzMcdl4cKXb90RMF38NhNju/XelnqmaAgRZLpLRWxFU34oTYSoOUwVtT+
	D8mxz/dUOAT1yyU4lYSA==
X-Received: by 2002:a17:903:988:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2cf34821a87mr148283515ad.10.1784521230106;
        Sun, 19 Jul 2026 21:20:30 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448dac2sm49482845ad.3.2026.07.19.21.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 21:20:29 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	rollkingzzc@gmail.com,
	tim.bird@sony.com,
	safa.karakus@secunnix.com,
	leitao@debian.org,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] Bluetooth: Fix parent socket UAF in accept queues
Date: Mon, 20 Jul 2026 12:19:10 +0800
Message-ID: <65767989c644f8adf52f35334f4034c66f47881f.1784383243.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784374481.git.xizh2024@lzu.edu.cn>
References: <cover.1784374481.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

Bluetooth children queued on a listening socket store the listener in
bt_sk(sk)->parent, but the accept queue did not hold a reference on that
parent socket.  The child side can later fetch that pointer and unlink
itself from the accept queue while still needing to notify the listener,
for example from L2CAP, ISO or RFCOMM teardown/state-change callbacks.

If the listener is closed concurrently, removing the child from the
accept queue can drop the last listener reference before those callbacks
call parent->sk_data_ready(parent), leaving a stale parent pointer and a
use-after-free.

Take a reference on the parent when a child is queued and drop it when
the child is unlinked.  Since unlinking now drops the accept-queue
parent reference, take a temporary parent reference in the callbacks that
continue to notify the parent after bt_accept_unlink().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bluetooth/af_bluetooth.c | 2 ++
 net/bluetooth/iso.c          | 2 ++
 net/bluetooth/l2cap_sock.c   | 2 ++
 net/bluetooth/rfcomm/sock.c  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index a2290ffdc2c1..0cb745ce652d 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -217,6 +217,7 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
+	sock_hold(parent);
 
 	if (bh)
 		bh_lock_sock_nested(sk);
@@ -265,6 +266,7 @@ void bt_accept_unlink(struct sock *sk)
 	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
+	sock_put(parent);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2e95a153912c..a2ed9da0e42d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -253,8 +253,10 @@ static void iso_chan_del(struct sock *sk, int err)
 
 	parent = bt_sk(sk)->parent;
 	if (parent) {
+		sock_hold(parent);
 		bt_accept_unlink(sk);
 		parent->sk_data_ready(parent);
+		sock_put(parent);
 	} else {
 		sk->sk_state_change(sk);
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4058ff50cc27..3cd69cf26335 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1707,8 +1707,10 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 		sk->sk_err = err;
 
 		if (parent) {
+			sock_hold(parent);
 			bt_accept_unlink(sk);
 			parent->sk_data_ready(parent);
+			sock_put(parent);
 		} else {
 			sk->sk_state_change(sk);
 		}
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index feb302a491fa..4195816b4236 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -77,11 +77,13 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 
 	parent = bt_sk(sk)->parent;
 	if (parent) {
+		sock_hold(parent);
 		if (d->state == BT_CLOSED) {
 			sock_set_flag(sk, SOCK_ZAPPED);
 			bt_accept_unlink(sk);
 		}
 		parent->sk_data_ready(parent);
+		sock_put(parent);
 	} else {
 		if (d->state == BT_CONNECTED)
 			rfcomm_session_getaddr(d->session,
-- 
2.43.0
