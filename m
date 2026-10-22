Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684047;
	b=a83lgbYf3trUMMwGsHgrHBhR4cEuUpcK8ycEnj+ZUl+9XO3v5B8QEJqGjJ06sNRIp3AM
	 gwN9fcZ0/15rG6xowD/xe2IOoTwPuCnMxvEHQcD5UMUF0GBFhQ7JXwdUfD539zkiWI27O
	 bUnXRsJ6g/5JADbgCtg0vsYG3KHQ4cYEFQkSZxt9ceOsMHo8ufRunl+Pv0VHpxQ2uNa1O
	 ik9oDTlGhkJEWYuXAVuz+TOhEg5u2Rhr5Gaj2hzucmKWA/knsGh8Ld9Jf7qVxqq7VEFiv
	 M/wIqC1ffYoiW2Fg7RDQdGke43llLE693hVOpZh66CLOUoMv5mO/kXXUJOmhJkIvE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9oWaK87SPYSpQ9bhTeby5+umqHB+00EE/LRFr9w1G5g=;
	b=mvAt+6avzUwTE6Z5TdgTRc/erHSxPkhGIFEA7g8DFa4ZUvZqGoLJZDMaUkXEzzjCv1Cz
	 gCK//9ghKOtBF5oQY7E7XiCbLNpX0Sw/S2fmRiMI66lddw7Io7H/hKErnXiUo28DvFYy+
	 TPptovswNC23FHd8TqvLaQh8RqCfSFXqqbSQ5KRvSchY7/ANx4PuQ7RJIEreK9HbDvRe3
	 I66tmW6LhulUJWP5au5zJshOUwZAQ316S69vpJQb9O7GHhM1hLVVf+rm6wwZ35A4+AEQn
	 Q3R+0WEBk15Mlk2WLWSdremo0ZyxFQGfAnbw741M2HfiG6JZxU4iyAg0K1RJ68d2xDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DLfQlAp2;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F3606A332
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562F3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DLfQlAp2
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so29058e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684046; x=1793288846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9oWaK87SPYSpQ9bhTeby5+umqHB+00EE/LRFr9w1G5g=;
        b=DLfQlAp2wh9vGZTEEl28GxgWmSc2JtZ731ARrR8GYRlQvQoMVdkC/sKaud5XLGqcex
         F2SqfXgUnKJ1J7+kVbYoglDGJmbp+UJ5gF5fqxeGLC6pOrXGJjHvnrDsMPkB+uTltTU1
         olTFfYdjCpv/4WF8Mex/ynpEtdY0kqK+ELT8xPBXLXXU5Iv2LMrFl/ZtblSdtcUuAKXe
         ZTFHXEdvz7CkmEUpzrBb3ppcg8XF8NOH68oM8JVdUmhIwEbJk+GwjOompGnbtSeoAFUY
         XJwzlrN//NaF91FN7NI5p/P3kCbgemOBSSZAJGBKCM4T50mAb9d7y+NhnUIYDPmakTpe
         Q2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684046; x=1793288846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9oWaK87SPYSpQ9bhTeby5+umqHB+00EE/LRFr9w1G5g=;
        b=BZXGBeei+QhGx+pOgD/cFw/IC9OvvbCLIe2ml7fWcvecsS36ekdQNX7qcMC3fISG/T
         qMBE5463vqbLYbAup2xU6CIs8zh4u1OddPdEEWV5zGlxWPRO8SVCc8uEJn3J+Oizjusv
         pef+hr0sQzD7NjUCsQZtAYrv650B30+p2jWV3J3fy9zcxPMq7JnlsfmHDBu8vQONf+oc
         a9HTBFQ04SAMvORrewSRfK/AJCl6bJUeY/J9ehWoGawBPd0AgX6jCpmBQaMzP1P/BCj8
         AzPifyPc6XA34xUK1XlA84qGIgE9DGQH5tJl5uvOAgo9wWPScM0X3AKyrRZFa7RJD9EM
         2xYA==
X-Gm-Message-State: AFq9FYKz0ZSp3NvvEQKuoKn1+zFVAaRgl/Ey2Gd09s3Ve3YWqX7mfJuf
	JUMWtXHidEac4dKN4xQMk3SQgZfggJlp2fFCgkF2MpPYVmq/xWb+vrx3j7yJr4a2e2k=
X-Gm-Gg: AYBFou2zcNh/BY+gN8y/64Fq33MJMoqWvgwS+pwOsChQj6Ch0nf+jOd64TY0J1gqWyx
	dzIhsr6UlyG9/1coI0zsrUInDlx7ZkTc0IhiBMfcj2TtJcUsqisb8IWbzkVRVnEM1gkxjNPJihm
	kmFiPkekd/9teM172Y6Mwhqhnm+5kpief9dvHbyXGx5VmI8qef/E2/7VTKISPvAwoR5m4Xyc6Z4
	2KV/lwQRNUaj4bXcBCWzcEhTMpbILgQm0v40d5te+/y5dYB5uGN/eN/tF4GWM2MVpYLazRptx9A
	DSMfl+VXmYS3+1m8d8pU3bNglnLmBA1tbULhW/8h/1jrABE2DHgojryDs74UVdIXm4Sif7XriPG
	WiDElbgnU4SUN2pXWac6/tWuxaTLefDki7JvaMsbEMvqKRXXpW0MvtwqZJr8bqpr3fiYJ+lNYS4
	lcRY26tcRYArAFMYvQYkI7dGYpOW1bYv/IdCsbjATD8r8Jn2ziJcwDTix4KWXVsa8Mrrn7x97Bo
	mQSEwt8pELBJP1P9xpp9Pa7KpmtOewPgwXwnwYtRYcBJ6oGVZkNgEk3uNPSecr7Rv5BPeLkCzW+
	xFgFapvD07s8v+UhVTXkhGYFN1msKp2sKBR1byHJEnnObg==
X-Received: by 2002:a05:6122:2397:b0:5ea:e223:5437 with SMTP id 71dfb90a1353d-5eaebe172b1mr2456038e0c.12.1792684046298;
        Thu, 22 Oct 2026 08:47:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 18/27] shared/timeout: Run timeouts of 0 once idle
Date: Thu, 22 Oct 2026 11:46:51 -0400
Message-ID: <20261022154701.3959500-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
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

With the mainloop backend timeout_add() with 0 never runs, as a timer
of 0 is disarmed, e.g. bt_hci's deferred event filter update. Use an
idle callback for it instead.

With GLib it runs at default priority, before pending events, so run it
at idle priority, as with the mainloop backend, which is what deferring
to the next iteration means.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/timeout-glib.c     | 10 +++++++++-
 src/shared/timeout-mainloop.c |  9 ++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/shared/timeout-glib.c b/src/shared/timeout-glib.c
index 3268d480c3a7..549e3fa5822b 100644
--- a/src/shared/timeout-glib.c
+++ b/src/shared/timeout-glib.c
@@ -52,7 +52,15 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 	data->destroy = destroy;
 	data->user_data = user_data;
 
-	id = g_timeout_add_full(G_PRIORITY_DEFAULT, timeout, timeout_callback,
+	/* A timeout of 0 runs once nothing else is pending, as with the
+	 * mainloop backend.
+	 */
+	if (timeout)
+		id = g_timeout_add_full(G_PRIORITY_DEFAULT, timeout,
+					timeout_callback, data,
+					timeout_destroy);
+	else
+		id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, timeout_callback,
 						data, timeout_destroy);
 	if (!id)
 		g_free(data);
diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index 9be803cda020..e6f9c5e826b3 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -54,7 +54,14 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 	data->timeout = timeout;
 	data->destroy = destroy;
 
-	data->id = mainloop_add_timeout(timeout, timeout_callback, data,
+	/* A timeout of 0 runs as soon as the mainloop gets to it, as with the
+	 * other backends, while mainloop_add_timeout() leaves it disarmed.
+	 */
+	if (timeout)
+		data->id = mainloop_add_timeout(timeout, timeout_callback, data,
+							timeout_destroy);
+	else
+		data->id = mainloop_add_idle(timeout_callback, data,
 							timeout_destroy);
 	if (data->id < 0) {
 		free(data);
-- 
2.56.0

