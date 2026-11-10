Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346958;
	b=oOk54ZQikcwsGDMBP9NlEJg9LoseMqSW6WR5h89B+mgMRclMC/VW/+b8GN83YEjFV5YO
	 vYj8XXiYLdMss6ffX2e5jt12zNo8+Og0DubRqijWp3U0Lh1iKqAJQqT3VgV91/a62QOjU
	 zEWpuNlWEu1kEekX36SxPD5zglKObubWOb6EZXqhs0DqLl8u3/0YwrVhqkDTRgh9gkUte
	 6UAK43EZZQesP76plooiC33S9/d8Ko51bDZOtLyJuVRrodS71PyGi013Xuhp06AGEoZAH
	 DajIksDK10O2sXgjzHJ90f7z4i2oqyqOgVNOFDZqvSnz7CUw7lwI9C7H07AbMXpXUIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5RCtVbPz+qIXu1i5cf+OFt0akM1iFcHbAtV0XVQiBYU=;
	b=J+jZUYsMT/LWU0yvyNDP2Jx1VkWbCPyLfoVAJSuDcSilnZoT1fLNo/lO4V9XDgY4RFsR
	 p9a5B//K/IxY6hRG5ZL2rLCoP2dl2tG2UNQXL2qbj7FvGdEB1GRXgfvWz4qy7enuIXw0G
	 Y7zlmi5LwMHnrQh9Z3jt/4exqb5OZFuQ0v3HtN+ULR5w1TSZe4PAjdcOXbdkR4lpMaN3X
	 O2aYlwszHCKUI714e+7VtOfPI6Y7GSM289qVVvjFOicUbrZtdyK2p+6ZqL0+Uh8xwu9Za
	 AYmhwqLtLvLhOjBCJyI1A7P7oZMXL/uKH1zZdJ2A0NYg2x2kAiA0N9Ctlc+QkOJ/l4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k6H/qLF4";
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECA606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43ECA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k6H/qLF4
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702fd86d674so1247018eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346957; x=1794951757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5RCtVbPz+qIXu1i5cf+OFt0akM1iFcHbAtV0XVQiBYU=;
        b=k6H/qLF4bbf7rcyUJTTOVrtLQg1T4mQisUqZqTOptcR9ySMlXow2jQgdbUvSY2ZN3G
         wQEj+U2eBJ7apPFknmoofTcmAR5+g6JbMuuQIqc0aRkb4ars5n7dbyB1LPmPKf6cn/7M
         7rl1i0h4T/v36yR1UJXxaJTdS3NJlA4pyW4xZW2V3NWRAbguVUQl/a01nLVQzcWBATc+
         yeyk53L0xKKE6u/kq2zj8m8tfi+FnmWWl/GWc9hPD6Zh/zkHpOgnBPYQBBum+Uadey9g
         i5tuu17OP0qYFk8Aq1NK7Y/LYAEHa6UK8rVXQr0puM7Wjf877vnPpmHmCUcPBIlNln7f
         0Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346957; x=1794951757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RCtVbPz+qIXu1i5cf+OFt0akM1iFcHbAtV0XVQiBYU=;
        b=tHEKXzUTkNVnGuyJx4Mde5Db5xKrcOXzcw2zVDx+jb5bKHtN1MCJIxQHvWKT6yibN2
         qcrL1usHm7mez6Sf0r1o1MOYLycKxg/F6azGSu25SFR3B7Ihl5T34K7++/aRbEge92YG
         VbybxgeG7IYWDSEK4e/3fIWEvdrLeQ3hdNMBKXpdbqGLSrwRRteP9MBiXNkWjmHavXcT
         qwe75eOh5jmUJlrOdetXR6RTZKEoxwPBECQJobXFq5uRoNcdutfB4L+OZMAtGbvEewFq
         MjLYP9w1zkKI+CFyAg9cAiC3UOUAkLb6/ef9KL1jvOIT1LbdZ38C2Yi5vAR7o0/DlqdG
         bqHA==
X-Gm-Message-State: APuU4Z8BS0d3nrBZWbTqG82D7p7FAlZFU6I74YqfTKegqKE7CBzx2GEV
	FJXtbnOZtNYQKxcQKHhBJZFqohevyfywrwCJVsYsYI6sRCXsIzUfE0ybiOCsuv48mO0=
X-Gm-Gg: AYBFou3WsC2Gyoe5UH4QXr14lU0ZA79uPZ5r0QQuWnaulKxYklQeO4iMplKek9IOlqh
	q0PZxFV0QV4bBdCWYUyroQg7N5g0613BY8OdAt8X7Et1QHmlusRASQH4BLDOIlFOQq8R5K89GXI
	Ca6HA6BZMplTikvTbIkOuE5lt9mn76sLTAhftCg/8Vnc9ypQruGWbDxKb5ITr4wpnFaupIpzvli
	k3F0jr9dMYyVs7xbRGUtRmlxICeiRmxuFNfmKn0F8Ic8mSeNCpB5Y91Ctag1Ved6KjJDHuApbOk
	7T5tqFGRm1VIPHNYroMM6f5f9mCiYM5qm1//jXap3e1IwvK8t4v2BHl8dQ79TLds0GnsFVlCXn5
	cD9eDs0Z5Z2xgTwx+QJtE1U4QQjafP6ws6n7WQxEbbtf2PIRzqKjrjookCGdvNSowP9gc5lF2uD
	bwt2uoqdScEYQ946YS34eNxVQYtldN/nN58Y6yxqY3mEYb53FVV1POmuj+seOP/uq2bxckhsSXC
	jK+UIswVGdeNRcXUw2EpB3/ojxEPWGZDESRQFNz0mLt6Ef0vxmuk3+8axaDsvqi6inPM0sBSTsi
	QHGel8BJ7Rm+Ed0IDuxjdCqI
X-Received: by 2002:a05:6820:1518:b0:70b:8379:c145 with SMTP id 006d021491bc7-719177cc79fmr245993eaf.28.1794346957078;
        Tue, 10 Nov 2026 13:42:37 -0800 (PST)
Received: from en1.. ([204.144.167.9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a945ceebsm2575322eaf.8.2026.11.10.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:42:36 -0800 (PST)
From: Amir Abudubai <amirabudubai@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Amir Abudubai <amirabudubai@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Increase default socket buffer to hold large SDUs
Date: Tue, 10 Nov 2026 15:42:30 -0600
Message-ID: <20261110214230.3646539-1-amirabudubai@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The L2CAP send path requires a full SDU to be assembled in the socket
buffer before transmission can begin. Therefore, the socket buffer must
be large enough to hold a worst-case SDU.

Derive the required buffer space from the worst-case parameters:
Maximum SDU plus length field: 65535 + 2 = 65537 bytes
At MPS 24:                    2730 full PDUs + 17-byte tail
With 4-byte L2CAP headers:    28-byte full PDUs, 21-byte tail
At HCI MTU 27:                2730 * 2 + 1 = 5461 fragments

MPS 24 and MTU 27 are chosen because they produce the most fragmentation.
Apply a 4x safety factor because SKB_TRUESIZE can underestimate actual
usage because of class-size rounding and minimum allocations.

Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>
---
The L2CAP send path deadlocks waiting for buffer space if it cannot fit
a full SDU in the send buffer. Using the system default typically causes
that to happen before the max allowed SDU. I didn't address the deadlock.
I just scaled the buffer so it is unlikely to happen unless the socket
gets resized after initialization.

 include/net/bluetooth/l2cap.h | 4 ++++
 net/bluetooth/l2cap_sock.c    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 54eddcdd341f..0cf1ca4ec3cd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -26,6 +26,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/atomic.h>
+#include <linux/skbuff.h>
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
@@ -41,6 +42,9 @@
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1492    /* Sized for AMP packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
+#define L2CAP_MAX_SDU_FRAGS		5461    /* Sized for worst-case CoC fragmentation */
+#define L2CAP_DEFAULT_SNDBUF \
+	(4 * L2CAP_MAX_SDU_FRAGS * SKB_TRUESIZE(SKB_DATA_ALIGN(HCI_MIN_LE_MTU + BT_SKB_RESERVE)))
 #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 #define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..5f4fde8b4a6d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -2046,6 +2046,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
+	sk->sk_sndbuf   = L2CAP_DEFAULT_SNDBUF;
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
-- 
2.43.0

