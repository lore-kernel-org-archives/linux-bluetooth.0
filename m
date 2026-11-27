Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781583;
	b=A5OfAh+skqmvL9xCHTbY8vj3ItXSZvNfXfHVgn+J9M/LApGDKaWKGr+WcjrBbnzZXYdE
	 kDxeRgsddbyYh05kv6NiXprgJk3Qz/nq9GTCYGDjzZ4tYUw3oz0QljValGNRxWHlD5qig
	 5grgKgsYpKIariMhlQSZjhNXiQOZ7loPYgaxRpNNMyuYv0hsPwzg7BxScSscvFN0+eumk
	 0gQ3jZKYoi7PTcRuBHd2mTcdDNjLc/RfY9zjXYF6mwleNN8p5BWbGFeMcueCSEm3kdoi+
	 h38eusQFFgP01/xVVJQJ2wnm3ouP3zscpZnJIoqHhWhy2Id1iHgbG6KuNnNkYlm/Ajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YI4pdPFOGp37uRd3Zu54wWLpUxYFw13L7ZugMhTPM7M=;
	b=OV5mlSx/YLn1ywNxgSY6iZbLW6RxwqSZTGcvsgcS60gPGyIevtKLX9mwYUazrzBa2Jkz
	 MoZn8qgQbjJUcae97bRbFkyJ4diqcCaryrtCm8Srkvnwf6gxtBayOFpRS3Kkz9FLovTbS
	 xflvAp6q++08Fzr4iFNbSHZZQEsWQalmvvnrbeAleDUPrFTonC17s+OAyJZYwfJYBhuGP
	 1Gu2ntVmcP0uykvbefiMoQDIUYkLwKrVWIiIkX27NNjyaxyMY4kBGXOR6/hvyYwS860zd
	 RZ0OwACTLFVDswRv+Om4Lzfif43EPJvHWdXDbKIvj6dgZDlsXswRXGhgG5FpAMwzUdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=VXsV9w+O;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C424606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 12:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C424606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=VXsV9w+O
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so12483655a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795781580; x=1796386380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YI4pdPFOGp37uRd3Zu54wWLpUxYFw13L7ZugMhTPM7M=;
        b=VXsV9w+OKj7G0gJS4/p8x4xgL7unVlUDuIdcrTgElx0n4JgLPOxyzRM+QOiq6nRiiX
         lvTlTA2AM0v9sS6lWk9wRAowQWuKHePMwygsdW1hXY+o1ox8NNwHGoece4kT/JfM8FgS
         CTvA/lBe5RmYSdjm7gBZHBO06bqKNt2+BcLeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781580; x=1796386380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YI4pdPFOGp37uRd3Zu54wWLpUxYFw13L7ZugMhTPM7M=;
        b=RrYWDeDgPJOV6YKlI7cSCQ25j2gEKb8J5R6SmWdhqtB+7VzmciyprG362JS0vd7Mhf
         D2i5qrout1dAbUodBkU94ZOhtloS7uXFjwFaRBy2zBpffEu4anPOWPc4TScbh4UqP9Br
         iwuLHzxp0eiqeN1a3QNwtgvDuiWd7N5lJDYff+oBCKc7t6GISLOxQ9d+hbkMC9cNIlyE
         AnL5ldCs/DJKjR3bHFuawY8ykjDZ4eDBJsJeFMpvfQb3YBmWVZ2I8QnG8vakRWXsbLhe
         OicmJv7uEx0p3rsTFzyiwjEVP1KRme06MrA0U3rqn+RLzrEJzgS1JbWnRGdY7W1jsuQ8
         a7PA==
X-Gm-Message-State: APuU4Z+b4W+tS4vWu6Pkr0cJVCUn1cYsYlzM+3uPRMeT+RA1hHfnQk7x
	dUFB27K//bpanGUanzorFm0R6+G5+KBpqyulPIsdyPhavVsPFdwBoT8hiiEbABhDQpzR7pY0hXo
	RMHb2
X-Gm-Gg: AZFdTZdxd7LWfiFq3AiDZWjO5glLnJrP9qVDHSqV8JFjsGesb2OVY3cgEec1wYtT3hc
	H8KU2d/qFFb98S6r4psmURxEtAMdH04EA20AiGpfAoR+bUjfXqWLu53OQL2aANpM1XJBGxPhgt3
	EN7RWfrLpMXGuW7uk+q4vlLfVRd0xAA58b8Zn07Bu60EdnBLImq22Zbhn1cRmRBS4hcuPBHfGdW
	U82hgscKuxVVy/Fsc0sxNHe7/lgzVXIVJJ5Bh4WcMELfsWACgvRDKRIBf8kFcypRobk58Dr/qwa
	habx4qpamO7rkJHOqfo4p8T6AmtMvUf+sOqHxdqxjNDvuYSwt2NhOf0dawjQN+jaHbHgZOKi+kG
	R7m7CsJXDZxvKyMNIwj1F3tokj91dg7UO8DBx23BAiPzk5SqwZn095F2iKh2mI5LlresD9t7sD0
	Th4kpbYIsZRqQh6s54iZfkXbpztU+h7nKt5A/NGj7Q/G0cwCywx8ErtReWIuMnfGDc41aM7Ql7Y
	/At41bzX29I9EWePE99Zh3ChIrjQ6oPwXKcxlAFWkJbhW+UIkrT7CTyfthdyYlY6NCe1BCyvh2w
	Y0FTdf1xY33fBk/sGqS4rYIdQYwOkTwvvY7fN34SSG9NqthDig==
X-Received: by 2002:a05:6402:1815:b0:6ba:201b:ca31 with SMTP id 4fb4d7f45d1cf-6ba37c76a45mr14465830a12.6.1795781580221;
        Fri, 27 Nov 2026 04:13:00 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:1a97:1eed:9575:b56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa397asm47480220f8f.48.2026.11.27.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:12:59 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Fix missing key size check for L2CAP_ECRED_CONN_REQ
Date: Fri, 27 Nov 2026 13:12:51 +0100
Message-ID: <20261127121251.2377133-1-simon.mikuda@streamunlimited.com>
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

The encryption key size of L2CAP_LE_CONN_REQ is checked since
commit 138d7eca445e ("Bluetooth: L2CAP: Fix missing key size check for
L2CAP_LE_CONN_REQ"), but the one of L2CAP_ECRED_CONN_REQ is not: a
channel of the enhanced credit based mode is accepted over an encrypted
link whose key is shorter than the minimum.

PTS L2CAP/ECFC/BV-15-C, the twin of L2CAP/LE/CFC/BV-15-C, pairs with a
15-octet key and expects an IUT that requires 16 octets to refuse the
channel with L2CAP_CR_LE_BAD_KEY_SIZE (0x0007). It gets Connection
Successful (0x0000).

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da947b65d26a..a9ac91e03fbb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5525,6 +5525,12 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if Key Size is sufficient for the security level */
+	if (!l2cap_check_enc_key_size(conn->hcon, pchan)) {
+		result = L2CAP_CR_LE_BAD_KEY_SIZE;
+		goto unlock;
+	}
+
 	/* Check if the listening channel has set an output MTU then the
 	 * requested MTU shall be less than or equal to that value.
 	 */

base-commit: 77bc0f253ff9fe1656f6e0fe9e9f5d3da91faf60
-- 
2.43.0

