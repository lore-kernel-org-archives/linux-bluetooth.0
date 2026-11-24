Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506839;
	b=UKQmbc395Cp0DxlICkrucce3f2S64H1xtudmTEE62h3eiFPFEQvhiXEbxA5VU8z9oRvp
	 iglti/6RDA1pIu4Drv/Evv8vmxbNx9A5IWIDf3mARezzAMoAPBDd6nft+Uuap/19uxI8U
	 JvEbKgwnx+Jek/ExHilBZfhg3JZ196MXO/aG2eE2KlzJgBLUVVe20LvA/9bDdCUQ+Bpam
	 kZ9HCQ804xoX5/HtZn/ptZVmBhUKLcq/zGfORiqTSQH43/VhC4VrvezRD8JJzdxY0PFlH
	 oKlKSG/pXvsXfjMT7yB8wkc90FlTb0aYrDXOjB71GcRFUnYshusF1hyM6siprpLJUFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=SCX/zlcXtsxXk+AbegudUWWFaC5TF5icZqlHpLuDaPM=;
	b=NnUmlNRHEOLS+h+4SRk02WT6WdXol14gj/6RHOU71hyZUje10rNzlA6kBPIZkgazMEPj
	 4P8BfljjtidpuvjWJweS/kRGcKKsHFzxtLpDSi4GhI205Hr5qHB7G77KkDCDJs4ua5er9
	 YfgNZZ2HBFbXo7BYVKy6UjCLe4IZGm3L0Uy1b7BiAy8GoqGJv1wVy3bci14SfJ7zvaodi
	 mBe14isElpBmwXlrQJSEL6QshSr7oRZNoR/cOQ+2uUTzLpjN8Y4Qjan7ElGMjBtKYQkke
	 lIFq/HjPDtpjHnADowKcOncgbI+pd1/HtVarXJegFqIiJdVJ3iKj1xiVDDNXVQuL4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUzCkpES;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86D606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B86D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUzCkpES
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2efddf749e5so20809775ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795506839; x=1796111639; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCX/zlcXtsxXk+AbegudUWWFaC5TF5icZqlHpLuDaPM=;
        b=SUzCkpESpeRKNFbjTs8PZCa6fKK5eGRXv9ieCLyKo/AESavOkaWX5Ec2TAany0LRS4
         zbcJPPQE33By3Jo+v1i7bJalfuEe/BDTLPmRPxOVgfGHvSVfuhFe3LQny1/dtf2Y3Vq2
         kJU3lH5vuPP+SZb9awnokvg0l9GaDnqU0ktKYKNKA8jZi3gpC/JH6vJm/C3I1w6y+zup
         nLVkZ+V4xq2z/l7OI7Mbk9eEks8IBc2zzRZ0ovNp/T+fbWRu++Wbrk8DQdYrvgv1ZK46
         S6UlJPU1wV5jib0jD2G5TwTrZo70s+YjpnAy6lK3ZVVBG/3ggwSiL+OhGf3nFTWy2sBP
         wxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506839; x=1796111639;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SCX/zlcXtsxXk+AbegudUWWFaC5TF5icZqlHpLuDaPM=;
        b=PiycoNVUkj9qsgmBtrqYdFwlaGcxJ6LPwFYXKEfNTAqSNxEF+Xr3IwUP1U235jLthp
         LqjRz7NnrLBS4L7uwgEXDm7d8wJNWV3j506laEpXipvsT0UzePuOIwha5nsA+iOTtYLU
         qGYWXr3c0BpWAY7k+LEl+9FgevGYbUsl8aCoEOKDcCS9asiSwJADdysobdMk/PEwXXZW
         W6N6R1O1EHp3Rzk/BJOHJzRl8KFK5EH46ON5chfLFlFm51bD2ZLjI1tkk0RBBzZ+xJdB
         ZnVhtSkJUOVwwrM2wxu1O6VQjh5xE5Y5tmmGQAiCpo0g77A/YEmjbQPf3hCdDMVrMvcK
         gf8Q==
X-Gm-Message-State: APuU4Z8iWCfaEtu9tCzb0DTUZl30jY+BPWCiYHHrhIlgmVKcBYpDSyla
	anSAjCOg2rsltiC1BibdRyKigx2t15R1/uZDKFXugPACXddtdE706glMJk2EA6e8Ccu+0VdM
X-Gm-Gg: AZFdTZdP3UnFUyKLdRzDY3hWG8IOSOoFD53js3NwBFOQ/+kdp/0aZf6zBfo2eL/MLjt
	Xz4G+Ut9F4ZwAek1xp45vow//eD4DEiNvzH4cg6JWCzrRHf9418zYgte0V+C9irIS4de4kRL6r/
	Sd6AlhqLSdNlzZo9kWf+/f2H1zOgvFq6jqPrBOJBFYCuzVJFRU/6Fw20P26L2fJsjPmxTUYNILN
	bx2BVxVf3kFWqz0AC2uvYa+Hs0sAAUHNRudZ6BhPgsQmUMmU2LUpAOtDUr7yNyhhcy1VIta1XjJ
	7e6F09hIY9XKrW3rdHLxEAs6NwHZ4db/CD+oT04aV5rY9Xt45AW/jwcayAsNfrV4+2uVWpemkkG
	P27U5L1scj4dBYqeyAn9j/04G0brILboBr29LTGb3gH273zgE7JH+fO2FbeskSEUXcWEAjb/8Kx
	SxDkQ7QliP34bQs0/k9UYRwoAvu5C4/4hJIyeYw3gCxjpUF9/bcECc1StebSs7EvsSNQAG3k98/
	Txl8vp6aOs8EoA0odmKgGb2Xjucgg1i7k/9t5hixhBqQSJM+adxbBJgjG2TTQ+jRmugcXx6jxhC
	s09UWohaGzkFH/BtE5BBN5kied7EZqKHrYMGMmOcUhV4mswJ/Jc1szx0BpuoocJiXgyEp8HpDsk
	mPGlygIYYJvUbxwZ4DN2/KEmc1BHluVkwR+Q7
X-Received: by 2002:a17:903:2f06:b0:2f0:a36e:6e08 with SMTP id d9443c01a7336-2f0a36e746cmr35006235ad.30.1795506838380;
        Mon, 23 Nov 2026 23:53:58 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c72sm65352875ad.54.2026.11.23.23.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:53:58 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO dlc->session dereference
Date: Tue, 24 Nov 2026 15:53:55 +0800
Message-ID: <179550683515.38654.13328780695859519079@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

rfcomm_sock_getsockopt_old() checks rfcomm_pi(sk)->dlc->session and then
dereferences dlc->session->sock->sk while holding only lock_sock(sk).
rfcomm_dlc_unlink() clears d->session and rfcomm_session_del() frees the
session under rfcomm_mutex without taking the socket lock, leaving a
check-then-dereference race against concurrent session teardown.

Commit 46f8ffd0a1f1 ("Bluetooth: RFCOMM: fix NULL dereference of
dlc->session in RFCOMM_CONNINFO") added the NULL check for the
post-disconnect case on deferred-setup sockets, but did not serialize
the dereference against concurrent unlink and kfree().

Add rfcomm_dlc_get_conninfo() to read the underlying L2CAP connection
fields under rfcomm_lock(). Hold a reference on the DLC and drop the
socket lock around the helper call to preserve the established
rfcomm_mutex -> lock_sock(sk) lock ordering used by krfcommd.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only; no runtime reproducer was
constructed for the narrow disconnect race window.

Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Fixes: 46f8ffd0a1f1 ("Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
v2: resend via direct SMTP without line-wrapping corruption in the diff.

 include/net/bluetooth/rfcomm.h |  2 ++
 net/bluetooth/rfcomm/core.c    | 23 +++++++++++++++++++++++
 net/bluetooth/rfcomm/sock.c    | 24 ++++++++++++------------
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 9dc5fd4cb8c..2e2cd873dd3 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -290,6 +290,8 @@ struct rfcomm_conninfo {
 	__u8  dev_class[3];
 };
 
+int rfcomm_dlc_get_conninfo(struct rfcomm_dlc *d, struct rfcomm_conninfo *ci);
+
 #define RFCOMM_LM	0x03
 #define RFCOMM_LM_MASTER	0x0001
 #define RFCOMM_LM_AUTH		0x0002
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a4205347c4..e6af6f5f591 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1427,6 +1427,29 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_unlock();
 }
 
+int rfcomm_dlc_get_conninfo(struct rfcomm_dlc *d, struct rfcomm_conninfo *ci)
+{
+	struct l2cap_conn *conn;
+	struct sock *l2cap_sk;
+	int err = 0;
+
+	rfcomm_lock();
+
+	if (!d->session) {
+		err = -ENOTCONN;
+	} else {
+		l2cap_sk = d->session->sock->sk;
+		conn = l2cap_pi(l2cap_sk)->chan->conn;
+
+		memset(ci, 0, sizeof(*ci));
+		ci->hci_handle = conn->hcon->handle;
+		memcpy(ci->dev_class, conn->hcon->dev_class, 3);
+	}
+
+	rfcomm_unlock();
+	return err;
+}
+
 static void rfcomm_check_accept(struct rfcomm_dlc *d)
 {
 	if (rfcomm_check_security(d)) {
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b547494..e91a129a67b 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -741,9 +741,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 				      sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
-	struct sock *l2cap_sk;
-	struct l2cap_conn *conn;
 	struct rfcomm_conninfo cinfo;
+	struct rfcomm_dlc *d;
 	int err = 0;
 	size_t len;
 	u32 opt;
@@ -786,20 +785,21 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case RFCOMM_CONNINFO:
-		if ((sk->sk_state != BT_CONNECTED &&
-		     !(sk->sk_state == BT_CONNECT2 &&
-		       rfcomm_pi(sk)->dlc->defer_setup)) ||
-		    !rfcomm_pi(sk)->dlc->session) {
+		if (sk->sk_state != BT_CONNECTED &&
+		    !(sk->sk_state == BT_CONNECT2 &&
+		      rfcomm_pi(sk)->dlc->defer_setup)) {
 			err = -ENOTCONN;
 			break;
 		}
 
-		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
-		conn = l2cap_pi(l2cap_sk)->chan->conn;
-
-		memset(&cinfo, 0, sizeof(cinfo));
-		cinfo.hci_handle = conn->hcon->handle;
-		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
+		d = rfcomm_pi(sk)->dlc;
+		rfcomm_dlc_hold(d);
+		release_sock(sk);
+		err = rfcomm_dlc_get_conninfo(d, &cinfo);
+		rfcomm_dlc_put(d);
+		lock_sock(sk);
+		if (err)
+			break;
 
 		len = min(len, sizeof(cinfo));
 		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
-- 
2.50.1 (Apple Git-155)

