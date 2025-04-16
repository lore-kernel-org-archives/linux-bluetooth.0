Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96608225408
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833338; cv=none; b=JzsEgwE5Eof6cbpgBWzgtEPo8ds2ZSfmU8xKZjzqvkfRg8Pq4z7QTWWJzzbvdS8xHexLoDCg/grHoQ67GpREp2FMj8RQqY4SFzseCrg8PiMGz9EKV98ngNkAU3R+SUvJkBmcmpdMspJK7xD725fqiJ2ufdmXfUS/ObeAj4VhnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833338; c=relaxed/simple;
	bh=WCruzil8CW2bYmslJXOzRaeOplSPiK+FWl1FjlWhi4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9kA7wBM5w3JMbPTBL6UyvLmhuUFczi9U5cyDCAttU/qlTkZwEfQrcd+Scv0ZYPUhNunKBJ1UI1NpefT/xIo8OETqJH8yXF+0Ckm+2DzgP8Pyk/2891HAciaa8gsYTfTPsdJ17f9cralx4K1CKvsHb06gh3pz4+MC/DQY+owO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEaoTMhx; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEaoTMhx"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d6ac4d5a9so21382241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744833335; x=1745438135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G8THI2yClH7rv1jbhssbjCNVQujFadW3iEgZJTztBM=;
        b=hEaoTMhxHhtqqVSYMLX9/STeiSBtTNQrKcURartq213dFGuA6kaREdrH9quZ668dPx
         YbaHWgBkJACLzgquCiB0dqr32/cA5bnyw9ZLFqyPwvGACxi6dYgHCswUjh7ABB2azcBW
         Bj2zS00j/RKjTQR3y2hlnGIvCABi9LlrcNE+7Lqvh8g4OVE5l44M2qMQ9MCpDPcZVgqS
         HNHuA+sxoYAJv3TAsJA0Xj8G+DZD4Ho2/9QL9DcGPTyI3FfucgBhoLyYOCkqz2jIWGLI
         qKEml9Xavu/Uc0rZUvdwi0BjWhKK5Pt9Jac7WuhMU3q0QIZVZuX7x3y0IP5mhuQFazjr
         XOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833335; x=1745438135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G8THI2yClH7rv1jbhssbjCNVQujFadW3iEgZJTztBM=;
        b=Ow9MpbKT+f9my4TV9B60t9Ds5qDU3ID46blwoj6PXO9Q8g5nP4yNr3o1P6tBQECqe1
         0OqhhkYHGZCn3yp2UpZv32AD3YCUiDUJ8xEQRzeIXnfPaj/YZYxLTbPaj24LFyqS29x2
         V9IkW4qwmgcPU9mXyeBx4F9v97evtIzTNfXJIvFwThQ/w6A9t3EYtAi4twV6jZuSQWsO
         eE+GQSx+EBqQEJUOWY+RuitbKUw1Sffv6pkCQUBFJ6ZyRoIvgXIDJW+VPGhWAX3u8ZQ9
         5+Vz88YHs2fL2KIUFiPT08AGJgyy7Fq2j2mSiODcJl2Acj2yGubK2yn8SNOUdQUo12Cm
         55WQ==
X-Gm-Message-State: AOJu0YyHTNsPvkPO72sl0/pELNLlTRV9dDmcgu8hZvMpfwYCmpMHFGWN
	FWVgqxW6QDQYtVAVfWa0kggdqkAa0RJ/y8vZn56gIu3/9cmTGSpfWLXCsfQS
X-Gm-Gg: ASbGncvx8KXpTTzBxjC+3Ye73xESRyRpGszgIh+jxWGvMQgj3DCWZ1p3tgZ9xHlymhb
	IQN+gse/tpWbrePrhjxywVmdECz5q5xLWwtdWTKBUN5ciFmxGHerA/sobWz8oKGAnJ0B8eveNSz
	FiZwwGt8auLWJHcoHxuXozlAdeBZZlrQsLToIm0lQy7onaXVkJE82OZ9PgWQq5uUz8E8KpkUKXI
	JaX5hAaU7vnL++e2xXmyfTNdIFBDsjCOWweTKVH68Jdp8mtIwrmPPAMzcJTo1GHM+q/1KpEE5JI
	odVc8rWbIgUT+pR0PM4oNWUFDvEICrVjmjMjf8BTRVGTFYPNXRlkkaBZSOzx4N32OWTRJ/yHZeP
	iH4UHRzsSu64UTdnQeqWJ
X-Google-Smtp-Source: AGHT+IGIgStfdzp9ioLVc868UlT2A4RjmPeIhGVynW3SeMg3Ilef0VvC6Abne24A3+1RCYTCxw/Y3g==
X-Received: by 2002:a05:6102:55c2:b0:4c4:edfa:9634 with SMTP id ada2fe7eead31-4cb5918fc9cmr2188930137.1.1744833334408;
        Wed, 16 Apr 2025 12:55:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87557281a80sm3243415241.27.2025.04.16.12.55.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:55:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/4] Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
Date: Wed, 16 Apr 2025 15:55:26 -0400
Message-ID: <20250416195526.1989143-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416195526.1989143-1-luiz.dentz@gmail.com>
References: <20250416195526.1989143-1-luiz.dentz@gmail.com>
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
index 7c0012ce1b89..2f348f48e99d 100644
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
@@ -1988,11 +1997,13 @@ static void iso_conn_ready(struct iso_conn *conn)
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

