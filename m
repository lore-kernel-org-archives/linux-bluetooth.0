Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE3256C7A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753725; cv=none; b=AyvlTo6L4TqRqn7DDxADxvzs1W96JZdmPqiXzxo4GyeCUYm8RYjSrj9luUQ+2VQrEjimRaBGSWN+3VCvR0zvVe9r1Bc7MjugelijySHgAXrfLHtjHQSWJ4UKOZ+lUlqjop2YfJLCj5uttMhk3kr54fL3U3PxZLITyuOoEw6+X7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753725; c=relaxed/simple;
	bh=bxD5U/pqR9CAvif4Ws67X53oubNpkgNHvaQSSbKHb7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4rsJiZQhZWbnkgvSIP+UX6SjU9CW6QrKgl6mvaigqUpk+Cjsyr1APUOmKiq4zbLIq8yCG/o1I3+5xE86WqDsA0wP1x2ae7/lDa2Z8EfYgrRT1fjs7e1YlEq2ULeQyXrCT+KgcFiW+kNTMYR5QXi+hNU2Sha813jtf3rJSDdM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrZg2Drz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrZg2Drz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-528ce9730cfso926550e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753722; x=1745358522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6q9nPjK0qjCdD4Kwid+6GpDr7Ex4JICXycYRmJPEkE=;
        b=PrZg2DrzXvVBnxrvPUdGIC1gVKJsU1P4Nk5H3HqQCx2NMFtede9AlPBBCAQQYCCDaT
         acO0ZXLq2U7nYu3Ez6iBqjK1Pzmoq1H2/NBzZ+qRVeWGwUf6g1IegSrWbDl4rPaE2jJq
         wBM0Qo9VBh9O9rm6B/VffEn3eWNXNcMZvQUo8QX291d+9bt9RuqQWg2ZdYMYak8zpASZ
         zLg4X3BcRQSOwjV0SOGgjBrlg4oOjqWWOZTKbxjb1XAHFm7p8ynYFW2tbFuTaFzObvZf
         MCBa7NfmCKYFLS6XRakXI16JqpakSuJejbkjm6YId+fJDfYJZ7Uh+bT9kwkZTCiiRvIr
         Ngvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753722; x=1745358522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6q9nPjK0qjCdD4Kwid+6GpDr7Ex4JICXycYRmJPEkE=;
        b=ps2fxtdxP5Rz+sz2fgNSDXaPdP3JLPMpypsgLdkcgTp5PUCOK6ld3c0SeGbb+LwbHM
         /TzxPXS99mwS+J9ULHC3kvndlA5prth/9X7P9THuZUihbKe3nIvZZ71lUrRtDlVbE1Vt
         YrwyjSeLV/8uGzIbBM7Mx80hCAPWpCvB3KSBbo1be7Kgvm62xHbdbw23JC2lm6sbkTwc
         f2/ScrWlKO2bviD11AxWu9fGMKTvb79WtPBf7IxVhrS3AAktf0srH64ptukIP5jegEc3
         5iYHon4Ope0dssJT8k4Yu/oA8uGim9IGv/xXM6nPkaRl0u0teSAni/GmcfuORIKHcB0b
         VJsA==
X-Gm-Message-State: AOJu0YzM8bQsfoJfxGgG51OC8oSTzwSuyIdGTNv7QqAQIojVDRnNCY8w
	Ug7kY1myLveTYfSFzEf47jUtXQC6cvwD22p/wNmJSMJhl7L+3DgF8n0VsTL/adY=
X-Gm-Gg: ASbGnct61IjFku6GapHC69SFHRvCpqeBPj3BKH6T7urgeT2G1NkW8uQH0dvQXmcZXn9
	cslTSo3ZxHopB3Ggg35kJzkJY7bn4Ngnkw9rZP9tASdwkmIuXWaugrBrQMDE3FdFGrnJVIpXTKu
	keVfSs9Ky1d3+Jl137xwPVCCZD1i8rBxa0TIzPI8Kvaeb1T9LTvzA5BPGAFjq2cjqKkcZpK8Muo
	quxA0mtZqw5rQhc9XItd3YSVe+G2Gqdpq1S9XH3kjOjMlBxOjjr8DHAg2YZRW0TYTWLLvjuDQFO
	eNvi0ieGcqLcyP7o9br/DMaZJY6WhfcOQppPRmsb8epHGifg+XqnNc++vYn+WrG1nkdHW+jI/vk
	gTcBhcPXLC3VED60Eyfo6
X-Google-Smtp-Source: AGHT+IGmx0hzzsZNF0jFNTfxBMkQhZaFWKL0qN/e0OBPTizBLCnYRAfPl+MSTy+WnjSvE+yaIApwsg==
X-Received: by 2002:a05:6122:1e06:b0:516:18cd:c1fc with SMTP id 71dfb90a1353d-529092ba51cmr695093e0c.8.1744753721839;
        Tue, 15 Apr 2025 14:48:41 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd74563sm2859321e0c.11.2025.04.15.14.48.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/3] Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
Date: Tue, 15 Apr 2025 17:48:35 -0400
Message-ID: <20250415214835.1678138-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214835.1678138-1-luiz.dentz@gmail.com>
References: <20250415214835.1678138-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the socket is a broadcast receiver fields from sockaddr_iso_bc shall
be part of the values returned to getpeername since some of these fields
are updated while doing the PA and BIG sync procedures.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index bd6b5cfb95fe..49534c93dc78 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1330,6 +1330,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 {
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
 	struct sock *sk = sock->sk;
+	int len = sizeof(struct sockaddr_iso);
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
@@ -1338,12 +1339,20 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 	if (peer) {
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
+
+		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
+			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
+			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
+			       ISO_MAX_NUM_BIS);
+			len += sizeof(struct sockaddr_iso_bc);
+		}
 	} else {
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->src);
 		sa->iso_bdaddr_type = iso_pi(sk)->src_type;
 	}
 
-	return sizeof(struct sockaddr_iso);
+	return len;
 }
 
 static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
@@ -1989,11 +1998,13 @@ static void iso_conn_ready(struct iso_conn *conn)
 			hcon->dst_type = iso_pi(parent)->dst_type;
 		}
 
-		if (ev3) {
+		if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
 			hcon->iso_qos = iso_pi(sk)->qos;
+			iso_pi(sk)->bc_sid = iso_pi(parent)->bc_sid;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
-			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
+			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis,
+			       ISO_MAX_NUM_BIS);
 			set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
 		}
 
-- 
2.49.0

