Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143251A238F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853722; cv=none; b=djSWiDUuH9djGCZPGZTmDFcNo2XH6tA8ikdaiu5KsxWtjogpIxldIgSfBMXMB+J2vC2lYP4Phz6PNU3XzAkwhIkZFF+5ythMcn1vUaTkIqOkN8l8IDedrdgqq0rfZD0kbzDGF4A3k8amK54GUNrqx9rlBsXe6v4nV8w6hUSAPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853722; c=relaxed/simple;
	bh=E1ETmbI3PJdIrAAdLmFArJU07Tu70pf4kty3lXSME30=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GDlPvlnpAMXYV23opUGy1/xMlV0bMUhS9eeFvo9nR+nUmBPUgWoaslfiDzq4z4I17o2S8KhKxDyERyJSLHApOiVvXTO6OSPzk0GtY33MiI5xG/GHSAtdWvBCa+5qJJCTXcgFqSfNJ2uF0KvD3Obhavk5oEdKOoQdLyGfqWsygSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyjb0kTU; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyjb0kTU"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73720e58dafso47923137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787853720; x=1788458520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s9ckicEow7TpFb7Fq5fjM1N/jZhBAKlOa03FFAdM0jw=;
        b=Fyjb0kTUAmyr0vmVlDPVhRQqtfZoyPMiPA2dN3BKBsBqfKeMSBJNGQY2cZyl0NYKrS
         +W+sR8w24GRNK/LiCG9xGmfA+E53VisLgK5FUaQNGY1Ivj/1gKsvf+QufGjq4pUJIkiN
         j7rF9zs0vcJXatR8Jn5GQwcX++eih555KcjMwjsVpI4FchUg7/ezFToKXa0aOntzSisA
         abu18f+tg+Re36JM1Hg79rWlDJZlI+UGaUgEdTNorooO8kNM40fFdo/OApR+9r/K1DQz
         6sOECMi1zOQg7Yf3FQ1obfJr067nyvAliNCh3VfDVDEKqiwuc8qbJV/hS502zc91+rBL
         jLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853720; x=1788458520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s9ckicEow7TpFb7Fq5fjM1N/jZhBAKlOa03FFAdM0jw=;
        b=oGsYRKLrTKXXVZ4AkdkO3G6BiXfs9nhwm2QvNk5dIn7iVsuKhYwdkGxMEP6Bd2T/mJ
         7jXn8L10TEdpS9add7Y17EKipAYJRGb/xKEL5MlcYCpMH74b1q+KxfBGkt8wzU4R47HP
         akI6gwa5/KwNGyUjv1hUCkaoUSzsSrVtckdfNKTGMehdtcbV/97pKnZNR/dmPgpkC7Kg
         AK2vVLK4y7Z52q3EC6o3i0ifatuRYvvjbSEUfMd15q4oVK9k6QubFnan22pW2nhWOHcB
         5naeg62PxvBMQkzbnj5LJ8yK4/K+On+3HXTgk6J23h5dDyla1l72C8Fi1Vb8f5IMjK56
         wl/g==
X-Gm-Message-State: AFuF++lonDvkjdwl/FxbfAacDA6Z4RTMf7cRJ28PzWX7JTIi8mIGi6Al
	4ZyAsFcU488DP1HZTuhhk4zo5q2rtbzxjLqwY/nPkK0Vq5/4BW8wBJP3hFRNy0eL
X-Gm-Gg: AR+sD12AnO511IPF9diYjZUr5wPlgWQa8gQnnx+G42l1RpcqJQyHYK2O+fiyHZ7UscF
	6RzlmNXSH6TLY/ep54FN8mDFYtBPMju0/RJNEAMPOb8DUo4nBHAIMdvgNBe29MaiEXqe1VyEhW/
	nH+ZxNsEbk2kIxtwiaqaRKfXuSpObwicFdH6Q6lj0I2zKRRF/J2BDWLX78fc2P2V1NrgPFh9cmW
	qKBp07kHfAFlU30qCS8e+8UG+pHW09yqjhPrMZFNfxSplMzIuetqL5vPq2pbdt74KaHA9AQGph/
	dk5iyNdv7dctqxg5IrzlK+LHuQa2xlVN1h1BYDmzxNUGmvpRNkB6hx8yWa1imsY2+1SrYdx5d6Y
	fGtS/oHQRkKlehazLSJewKq7VvuxI4tEEsZtuon8ZfdB3UoyJSJAYqnE+ynZF/MNDFfsq0jWTqf
	X572Fa1IWsLp0LsNZeA2HULqHcqDoARH2KrNYK82HckOwBJsk5Hyg2UQRhnfFWyd13yHCPOsrLW
	awYw12qCSZmQUcES21T2admpFnnCtqvZDR68AhgOhr8izhgfpwKs2o=
X-Received: by 2002:a05:6102:149e:b0:785:5a17:739b with SMTP id ada2fe7eead31-785939481a8mr111652137.0.1787853719690;
        Thu, 27 Aug 2026 11:01:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97ccc0f4963sm3695458241.12.2026.08.27.11.01.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:01:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to bind
Date: Thu, 27 Aug 2026 14:01:48 -0400
Message-ID: <20260827180149.415744-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SCO sockets have no PSM or port namespace: binding one simply reserves
the ability to accept any incoming eSCO/SCO connection on the adapter.
That is equivalent to listening on a well-known service, which L2CAP
already restricts to CAP_NET_BIND_SERVICE in
l2cap_validate_bredr_psm()/l2cap_validate_le_psm().

Apply the same restriction to sco_sock_bind() so unprivileged processes
can no longer hijack incoming SCO links.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d4362a09df4..e4c26551e513 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -667,6 +667,13 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 
 	BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
 
+	/* Binding a SCO socket reserves the ability to accept any incoming
+	 * eSCO/SCO connection on the adapter, so restrict it in the same way
+	 * L2CAP restricts well-known PSMs.
+	 */
+	if (!capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
-- 
2.54.0

